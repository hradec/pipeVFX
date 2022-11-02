# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================

# import maya.app
# maya.app.general.fileTexturePathResolver.findAllFilesForPattern("/BTRFS10TB/atomo/jobs/0704.hi_chew/assets/sala/users/iinaja/maya/sourceimages/personagem_maca/textura/corpo/Base_maca_Color_<UDIM>.png",0)


import IECore, pipe, tempfile
from glob import glob
import os, datetime, sys
from multiprocessing import cpu_count

try: from importlib import reload
except: pass


import genericAsset
reload(genericAsset)

from genericAsset import m



class maya( genericAsset.maya ) :
    _color = IECore.Color3f( 0.0, 0.25, 0.45 )

    def __init__( self ) :
        genericAsset.maya.__init__(self, 'shaders', animation=False)

    @staticmethod
    def onRefreshCallback( assetType, nodeNamePrefix ):
        import samPrman
        samPrman.setRenderScripts()
        m.setAttr( "defaultRenderGlobals.preMel", "python(\"import genericAsset;genericAsset.maya._attachShaders()\")", type="string" )
        # genericAsset.maya.cleanUnusedShadingNodes()
        genericAsset.maya.attachShadersLazy()

    def publishMayaShadersAndTextures(self, shadingFile,  operands):
        from threading import Thread
        import math

        # cleanup scene before publishing
        self.cleanupScene()

        # loop over all meshs and gather shading mapping!
        shadingMap, shadingGroups, shadingNodes, displacementNodes, textures = maya.getShadingMap( self.data['meshPrimitives'] )

        self.data['shadingMap'] = shadingMap
        self.data['shadingGroups'] = shadingGroups
        self.data['shadingNodes'] = shadingNodes
        self.data['displacementNodes'] = displacementNodes
        self.data['textures'] = textures

        # mayaExt = os.path.splitext(operands['%sDependency' % self.prefix].value)[-1].lower()
        # shadingFile = "%s/data/shaders%s" % (m.workspace(q=1, rd=1), mayaExt)
        self.data['extraFiles'] = []
        self.data['publishedTextures'] = {}

        tmpFolder = '%s/renderman/sam' % m.workspace(q=1, rd=1)
        if not os.path.exists(tmpFolder):
            os.makedirs(tmpFolder)

        def cleanFileName(file):
            clean = [
                ' ',
                '!',
                '&',
                '(',
                ')',
                '[',
                ']',
            ]
            ret = file
            for each in clean:
                ret = ret.replace(each,'_')
            return ret

        def processTextures(n1, n2, cores, pb, tmpFolder):
            # tmpFolder = '%s/renderman/sam' % m.workspace(q=1, rd=1)
            for node in self.data['textures'].keys()[n1:n2+1]:
                textures = self.data['textures'][node]
                if type(textures) == type(str):
                    textures = [self.data['textures'][node]]


                for t in textures:
                    if not os.path.exists(t) and os.path.exists(os.path.splitext(t)[0]):
                        t = os.path.splitext(t)[0]

                    # fileName = '%s/sourceimages/%s' % ( m.workspace(q=1, rd=1), os.path.basename( self.data['textures'][text] ) )
                    ext = os.path.splitext( t )[-1].lower()
                    if 1: #'/sam/' not in t or ext != '.tex':
                        publishedText = "%s/%s" % ( self.data['publishPath'], os.path.basename( t ) )

                        # by adding to extraFiles, the texture will be published to the asset folder
                        if ext != '.tex':
                            tex = '%s.tex' % os.path.basename( cleanFileName(t) )
                            self.data['extraFiles'].append( t )
                        else:
                            tex = os.path.basename( cleanFileName(t) )

                        # convert to tex file
                        # if ext == '.tex':
                        #     self.data['extraFiles'].append( t )
                        # else:
                        cmd  = "mkdir -p %s/ ;" % ( tmpFolder )
                        cmd += "rm -rf %s/%s ;" % ( tmpFolder, tex )
                        cmd +='LD_LIBRARY_PATH=$RMANTREE/lib/ $RMANTREE/bin/txmake -resize down -t:%s -mode periodic "%s" %s/%s' % ( cores, t, tmpFolder, tex )
                        # print( cmd )
                        os.popen( cmd ).readlines()
                        self.data['extraFiles'].append( '%s/%s' % (tmpFolder, tex) )
                        publishedText = "%s/%s" % ( self.data['publishPath'], tex )

                        self.data['publishedTextures'][node] = publishedText

                # now we set maya texture node to use the published texture!
                # print '===>', publishedText
                # maya.setFileTexture( text, publishedText )


        # convert textures to tex using multiple threads
        threads = []
        cores = cpu_count()#*1.5
        batches = len( self.data['textures'].keys() ) / cores
        batches =  int( math.ceil(batches) ) # + math.ceil( 1.0 / batches-int(batches) )

        # progress bar
        pb = genericAsset.progressBar( len(self.data['textures'].keys())+int(math.ceil(cores))+1, "Pre-converting textures for publishing...")

        # for n in range( int(math.ceil(cores)) ):
        #     n *= batches+1
        #     # print n, n+batches
        #     threads.append(  Thread( target=processTextures, args=(n,n+batches,cores,pb,tmpFolder,) ) )
        #     threads[-1].start()

        for n in range( len( self.data['textures'].keys() ) ):
            # print n, n+batches
            threads.append(  Thread( target=processTextures, args=(n,n,cores,pb,tmpFolder,) ) )
            threads[-1].start()

        # wait for the convertion to finish
        pb.step()
        for thread in threads:
            pb.step()
            thread.join()

        # make file texture nodes use the published shaders
        for node in self.data['publishedTextures']:
            pb.step()
            maya.setFileTexture( node, self.data['publishedTextures'][node] )

        pb.close()

        # cleanup shading leftovers
        cleanup = m.ls("SAM_SHADER_%s_%s*" % (
            self.data['assetType'].replace('/','_'),
            self.data['assetName'].split('.')[-1]
        ))
        maya.cleanNodes( cleanup )
        maya.cleanUnusedShadingNodes()

        newNodes = []
        for node in self.data['shadingMap']:
            placeholder = "SAM_SHADER_%s_%s_%02d_%02d_%02d_%s" % (
                self.data['assetType'].replace('/','_'),
                self.data['assetName'].split('.')[-1],
                self.data['assetInfo']['version'].value.x,
                self.data['assetInfo']['version'].value.y,
                self.data['assetInfo']['version'].value.z,
                node
            )
            n=m.createNode('mesh')
            snode = m.rename(m.listRelatives(n, p=1), placeholder)

            m.addAttr( snode, ln="SAM_ORIGINAL_NODE", dt="string" )
            m.setAttr( snode + '.SAM_ORIGINAL_NODE', str(node), type="string"  )

            m.sets( snode, e=True, forceElement=self.data['shadingMap'][node].keys()[0] )
            newNodes.append( snode )


        m.select(
            self.data['shadingGroups'].keys() +
            self.data['shadingNodes'].keys() +
            self.data['displacementNodes'].keys()
        ,r=1, noExpand=1)

        m.select(newNodes)

        cleanup = m.ls("SAM_SHADER_%s_%s*" % (
            self.data['assetType'].replace('/','_'),
            self.data['assetName'].split('.')[-1]
        ))
        maya.cleanNodes( cleanup )

        # export RLF data for prman
        if m.pluginInfo('RenderMan_for_Maya.so', query=1, loaded=1):
            self.exportRLF(operands)

        # restore original file texture paths before saving scene.
        for node in self.data['publishedTextures']:
            maya.undoSetFileTexture( node )

        mayaExt = os.path.splitext(shadingFile)[-1]
        m.file(shadingFile, force=1, pr=1, es=1, typ=("mayaBinary" if mayaExt=='.mb'else 'mayaAscii'))



    def exportRLF(self, operands):
        import samPrman
        reload(samPrman)
        self.frameRange = operands['FrameRange']['range'].value

        m.select(self.data['meshPrimitives'])

        rlf =  samPrman.exportRLF(animation=operands['enableAnimation'].value, range=[self.frameRange.x,self.frameRange.y,self.frameRange.z])

        pb = genericAsset.progressBar( len(rlf)+1, "Publishing Renderman Look Files...")

        sg = "SAM_SHADING_GROUP_%s_%s_%s_" % ( self.data['assetType'].replace('/','_'),self.data['assetName'].split('.')[-1], self.data['assetVersion'].replace('.','_') )
        # self.data['extraFiles'] += [ os.path.abspath( rlf[r][0] ) for r in rlf ]
        self.data['RLF'] = {}
        for r in rlf:
            pb.step()
            # print( '######>',rlf[r] )
            newrlf_file      = os.path.dirname(rlf[r][0])+'/asset.%s.rlf' % rlf[r][0].split('/')[-2]
            newrlf           = open(newrlf_file, 'w')
            # in case we missed any .tex file, grab it from rlf!
            lines = open(rlf[r][0], 'r').readlines()
            samTEX = [ x.split('[')[1].split('"')[1] for x in lines if '.tex' in x and '/sam/' in x ]
            current_payload = ''
            for line in lines:
                # if we hit a close payload, reset current_payload
                if '</Payload>' in line:
                    if current_payload in self.data['shadingGroups'].keys():
                        current_payload = ''
                    else:
                        current_payload = ''
                        continue

                # we track the payload definition, so we can filter out the un-needed payloads!!
                if not current_payload.strip() and '<Payload Id="' in line:
                    current_payload = line.split('<Payload Id="')[1].split('"')[0]

                # if we're in a paylod and the payload is not in the asset shadingGroups, skip this line
                if current_payload.strip() and current_payload not in self.data['shadingGroups'].keys():
                    continue

                if '.tex' in line.lower() and '[' in line and '"' in line:
                    tex = line.split('[')[1].split('"')[1]
                    if tex[-4:].lower() == '.tex':
                        if not [ x for x in self.data['extraFiles'] if os.path.basename(tex) in x ]:
                            self.data['extraFiles'] += [tex]
                        if '/sam/' not in tex:
                            newPath = "%s/%s" % ( self.data['publishPath'], os.path.basename( tex ) )
                            exists = [ x for x in  samTEX if os.path.basename(tex) in x ]
                            if exists:
                                newPath = exists[0]
                            line = line.replace( tex, newPath )

                # fix the payload names
                if 'Payload' in line:
                    line = line.replace('Payload Id="', 'Payload Id="'+sg )
                    line = line.replace('PayloadId="', 'PayloadId="'+sg )

                # we must fix shader nodes as well
                # for shaderNode in [ x for x in ['Bxdf', 'Pattern', 'Displacement'] if x in line[:len(x)] ]:
                #     shaderNodeName = line.split(' ')
                #     if len(shaderNodeName)>3:
                #         shaderNodeName = shaderNodeName[2].strip('"')
                #         line = line.replace(shaderNodeName, sg+shaderNodeName )

                if '__instanceid' in line:
                    instanceID = line.split('__instanceid')[1].replace('"','').split('[')[1].split(']')[0]
                    line = line.replace(instanceID, sg+instanceID )


                # if we hit a rule and the shading group exists in this asset, fixed its name
                if '<Rule ' in line:
                    # RuleShape = genericAsset.maya.rule2node( line.split('><![CDATA[')[1].split(']')[0] )
                    # RuleMeshSelected = [ x for x in m.ls(sl=1,dag=1) if genericAsset.maya.rule2node(RuleShape) in x ]
                    RuleShape = line.split('><![CDATA[')[1].split(']')[0]
                    RuleMeshSelected = [ x for x in m.ls(sl=1,dag=1,geometry=1,l=1) if genericAsset.maya.node2rule(x) in line ]
                    if line.split(' Id="')[1].split('"')[0] in self.data['shadingGroups'].keys() and 'initialShadingGroup' not in line and RuleMeshSelected:
                        line = line.replace(' Id="', ' Id="'+sg )
                    else:
                        continue

                newrlf.write( line )
            newrlf.close()
            self.data['extraFiles'] += [os.path.abspath(newrlf_file)]
            self.data['RLF'][r] = "%s/%s" % ( self.data['publishPath'], os.path.basename( newrlf_file ) )
        pb.close()


    def doPublishMayaExport(self, scene, operands):
        '''
        This function is called by doPublishMaya() after the basic generic export setup has being done.
        In a simple geometry publish, this function only selects the geometry and file->export it!
        '''
        self.publishMayaShadersAndTextures( scene, operands)


    def doImportMaya( self, filename, nodeName ):
        ''' called by SAM when import an asset in maya '''
        # cleanup shading leftovers
        # cleanup = m.ls("SAM_SHADER_%s_%s*" % (
        #     self.data['assetType'].replace('/','_'),
        #     self.data['assetName'].split('.')[-1]
        # ))
        # maya.cleanNodes( cleanup )
        ret = True

        if 'RLF' in self.data:
            import samPrman
            node = m.createNode("transform", n=nodeName)
            m.addAttr( node, ln="SAM_DATA", dt="string" )
            m.setAttr( node + '.SAM_DATA', str(self.data), type="string"  )
            m.addAttr( node, ln="SAM_RLF_FILE", dt="string" )
            m.setAttr( node + '.SAM_RLF_FILE', str(self.data['RLF']), type="string"  )
            samPrman.setRenderScripts()

        else:

            genericAsset.maya.cleanUnusedShadingNodes(force=True)

            ret = genericAsset.maya.doImportMaya( self, filename, nodeName )
            if ret:
                shadingMap, shadingGroups, shadingNodes, displacementNodes, textures = genericAsset.maya.getShadingMap( m.ls("SAM_SHADER_*", type='transform') )
                # for node in textures:
                #     texture = os.path.basename( textures[node] )
                #     publishedText = "%s/%s" % ( self.data['publishPath'], texture )
                #     if os.path.exists( '%s.tex' % publishedText ):
                #         publishedText = '%s.tex' % publishedText
                #
                #     # print texture, '%s.tex' % publishedText , os.path.exists( '%s.tex' % publishedText )
                #     maya.setFileTexture( node, publishedText )



                genericAsset.maya.cleanUnusedShadingNodes()

                # delete any mesh that may get into the exported scene.
                maya.cleanNodes( [ x for x in m.ls("SAM_shaders*", dag=1,type='mesh', l=1) if 'SAM' not in x.split('|')[-1] ] )

                # for shader in m.ls("SAM_SHADER_*", type='transform'):
                #     nodeToAttach = m.getAttr( shader + '.SAM_ORIGINAL_NODE' ).split('|')[-1]
                #     nodesToAttach = m.ls("*"+nodeToAttach)
                #     print nodesToAttach
                #
                #     # atach to nodes matching naming map
                #     n = m.ls(shader, dag=1, visible=1, ni=1, type='mesh')
                #     for sg in m.listConnections(n,  type="shadingEngine"):
                #         m.sets( nodesToAttach, e=True, forceElement=sg )

        return ret






IECore.registerRunTimeTyped( maya )
