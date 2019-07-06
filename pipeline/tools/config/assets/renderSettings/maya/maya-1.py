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


import IECore, pipe, tempfile
from glob import glob
import os, datetime, sys

import genericAsset
reload(genericAsset)

class maya( genericAsset.maya ) :
    _color = IECore.Color3f( 0.50, 0.20, 0.10 )

    exportTypeNodes = [
        "PxrPathTracer",
        "PxrVCM",
        "PxrValidateBxdf",
        "PxrVisualizer",
        "PxrOcclusion",
        "PxrDirectLighting",
        'PxrCamera',
        'PxrDebugShadingContext',
        'PxrDefault',
        "RenderMan",
    ]

    def __init__( self ) :
        self.selectNodes()
        genericAsset.maya.__init__(self, 'renderSettings', mayaNodeTypes=None, mayaScenePublishType='ma')
        self.setMayaSceneType('ma')

        self.parameters()["%s%s" % (self.prefix, self.nameGroup)].setValue(  IECore.StringData( ','.join(self.selectNodes()) ) )
        # print self.parameters()["%s%s" % (self.prefix, self.nameGroup)].userData().values()
        self.parameters()["%s%s" % (self.prefix, self.nameGroup)].userData().update({"UI" : {"visible" :  IECore.BoolData(False)}})

    # @staticmethod
    # def onRefreshCallback( assetType, nodeNamePrefix ):
    #     genericAsset.maya.setRenderSettings()

    def doPublishMayaExport(self, fileName, operands):
        ''' we override doPublishMaya just to force meshPrimitives to be the default nodes! '''
        self.data['meshPrimitives'] = [ str(x) for x in self.selectNodes() ]
        print self.data['meshPrimitives']

        ret = genericAsset.maya.doPublishMayaExport(self, fileName, operands)

        self.data['meshPrimitives'] = [ 'defaultRenderGlobals' ]
        return ret


    def selectNodes(self):
        ''' select the rendersettings related nodes in maya and return a list of node names.
        since all scenes use the same ones, this is a static selection! '''
        if genericAsset.m:
            exportNodes = [
                "*Globals*",
                "*default*",
            ]
            ignoreNodes = [
                "*mtorPartition*",
                "SAM_renderSettings*",
                "*LightSet*"
            ]
            exportTypeNodes = self.exportTypeNodes

            nodesToDelete = []
            if  genericAsset.m.objExists( 'rmanFinalGlobals' ):
                displays = genericAsset.m.listConnections('rmanFinalGlobals',d=0,s=1)
                rmanNodes = genericAsset.m.ls(type='RenderMan')
                if rmanNodes and displays:
                    nodesToDelete = [ x for x in rmanNodes if 'Globals' not in x and x not in displays ]
            # genericAsset.maya.cleanNodes( nodesToDelete )


            genericAsset.m.select(cl=1)
            [ genericAsset.m.select( genericAsset.m.ls(n), add=1 ) for n in exportNodes ]
            [ genericAsset.m.select( genericAsset.m.ls(type=n), add=1 ) for n in exportTypeNodes ]
            [ genericAsset.m.select( genericAsset.m.ls(n), deselect=1 ) for n in ignoreNodes+nodesToDelete ]

            return genericAsset.m.ls(sl=1,l=1)

        return []

    @staticmethod
    def cleanupRenderSettings():
        for n in ['renderManRISGlobals','rmanFinalGlobals','rmanRerenderRISGlobals'] :
            if genericAsset.m.objExists(n):
                genericAsset.m.lockNode( n,l=1)
        maya.cleanNodes(
            genericAsset.m.ls('defaultLayer*' ) +
            genericAsset.m.ls('defaultRenderLayer*' ) +
            # genericAsset.m.ls('rmanFinalChannel*' ) +
            # genericAsset.m.ls('rmanFinalOutput*' ) +
            [ x for x in genericAsset.m.ls(type='RenderMan') if str(x) not in [
                'renderManRISGlobals',
                'rmanRerenderRISGlobals',
                'rmanFinalGlobals',
                'rmanBakeGlobals',
                'rmanFinalOutputGlobals0',
                'rmanRerenderRISOutputGlobals0',
            ] ]  +
            # genericAsset.m.ls('rmanFinalGlobalst*' ) +
            # genericAsset.m.ls('rmanRerenderRISOutputGlobals*' ) +
            # genericAsset.m.ls('renderManRISGlobals*' ) +
            # genericAsset.m.ls('rmanRerenderRISGlobals*' ) +
            # genericAsset.m.ls('rmanRerenderRISGlobals*' )
        [])
        for n in ['renderManRISGlobals','rmanRerenderRISGlobals','rmanFinalGlobals'] :
            if genericAsset.m.objExists(n):
                genericAsset.m.lockNode( n,l=0)

    @staticmethod
    def setRenderSettings( ):
        ''' execute the mel code stored in SAM_RENDERSETTINGS to set rendersettings! '''
        if genericAsset.m:
            import maya.mel as mel
            import time
            t = time.time()
            for node in genericAsset.m.ls( 'SAM_renderSettings*' ):
                if genericAsset.m.objExists( node + '.SAM_RENDERSETTINGS' ):

                    lines = str(genericAsset.m.getAttr( node + '.SAM_RENDERSETTINGS' ))
                    lines = lines.split('\n')

                    maya.cleanupRenderSettings()

                    pb = genericAsset.progressBar(len(lines)+1, 'Render Settings setup...')

                    pb.step()
                    for l in lines:
                        pb.step()
                        if 'SAM_renderSettings' in l:
                            continue
                        try:
                            # print l
                            mel.eval(l)
                            # if 'createNode' in l:
                            #     mel.eval('select -ne %s' % x.split('-n')[-1])
                        except:
                            pass


                    nodesToDelete = []
                    # if  genericAsset.m.objExists( 'rmanFinalGlobals' ):
                    #     displays = genericAsset.m.listConnections('rmanFinalGlobals',d=0,s=1)
                    #     nodesToDelete = [ x for x in genericAsset.m.ls(type='RenderMan') if 'Globals' not in x and x not in displays ]
                    # maya.cleanNodes(
                    #     genericAsset.m.ls('defaultLayer*' ) +
                    #     genericAsset.m.ls('defaultRenderLayer*' ) +
                    #     nodesToDelete
                    # )


                    pb.close()
                print '\n\nDone'
            print time.time()-t


    @staticmethod
    def filterOnlyAllowedNodesInMA(lines):
        newLines = []
        currentNode=False
        for line in lines:
            line = line.strip()
            if 'createNode' in line:
                # if createNode, all following commands are referent to this one node.
                # if this createNode is not one of the allowed type, we have to ignore
                # all lines until we reach a new node setup
                typeName = line.split(' ')[1]
                if typeName in maya.exportTypeNodes:
                    # store the node name in currentNode
                    currentNode = line.split('-n')[1].replace('"','').strip().strip(';')
                    line += ';select -ne %s;' % currentNode
                    # exists = genericAsset.m.ls(currentNode)
                    # if exists:
                    #     if genericAsset.m.lockNode( currentNode, q=1):
                    #         genericAsset.m.lockNode( currentNode, l=0)
                    #     genericAsset.m.delete(exists)
                else:
                    # if createNode is not one of the allowed types, ignore all following lines
                    currentNode = False
                    continue

            elif 'select' in line:
                # if we hit a select node, all following commands refer to this one.
                # in this case, we don't filter it, so just make currentNode=nodeName
                # select is hit!
                currentNode = line.split('-ne')[1].replace('"','').strip().strip(';')

            # elif 'rename' in line:
            #     # if we hit a select node, all following commands refer to this one.
            #     # in this case, we don't filter it, so just make currentNode=nodeName
            #     # select is hit!
            #     line = 'lockNode -l 0;' + line

            # elif 'connectAttr' in line:
            #     # if we hit a connectAttr we need to check if the source and destine nodes exist.
            #     # if not, remove the line!
            #     nodes = [ x.strip().replace('"','') for x in line.split(' ')[1:3] ]
            #     if [ x for x in nodes if not genericAsset.m.objExists(x) ]:
            #         # if any of the nodes doesn't exist, skip the line
            #         continue
            #
            #     # now we check if it's alread connected!
            #     # print nodes, [x for x in genericAsset.m.listConnections(nodes[0], p=1) if nodes[1] in x]
            #     connections = genericAsset.m.listConnections(nodes[0], p=1)
            #     if connections and [x for x in connections if nodes[1] in x]:
            #         continue

            # elif 'addAttr' in line and currentNode:
            #     # check if the attr exists before adding it
            #     # this prevents annoying error messages
            #     node = currentNode + '.' + line.split('-ln')[1].strip().split(' ')[0].replace('"','').strip()
            #     if genericAsset.m.objExists( node ):
            #         # if genericAsset.m.lockNode( node, q=1):
            #         #     genericAsset.m.lockNode( node, l=0)
            #         # genericAsset.m.deleteAttr( node )
            #         print node
            #         continue

            if currentNode:
                # we use the lines ONLY while currentNode is True.
                # this way we only setup the allowed nodes!
                newLines += [line]
        return newLines


    def doImportMaya( self, filename, nodeName ):
        # maya import code!

        if genericAsset.m:
            lines=open(filename,'r').readlines()
            tmp = []
            _lines = ''.join(lines).replace('\n','').replace('\t','').replace(';',';\n').split('\n')
            n=0
            is_lastLine_string = False
            while n < len(_lines):
                # if last line was a unfinished string, this line is a continuation of it
                if is_lastLine_string:
                    tmp[-1] += _lines[n].strip()
                else:
                    tmp += [ _lines[n].strip() ]

                # count how many ascii(") we have
                n_str = len(_lines[n])-len(_lines[n].replace('"',''))
                # if we have an odd number of ascii("), tell the next line that this one was a unfinished string
                if  n_str>2 and n_str % 2 == 1:
                    is_lastLine_string = True
                else:
                    is_lastLine_string = False

                n+=1
            _lines = tmp

            lines = maya.filterOnlyAllowedNodesInMA( _lines )
            if not lines:
                raise Exception('''
                    ERROR: Published renderSettings asset doens't have any renderSettings information!

                    It may be possible to fix this by opening the original scene and re-publishing it to a new version!
                ''')

            # prman setup only!!
            try:
                n=genericAsset.m.renderer( 'renderManRIS', q=1, globalsNodes=1 )
                # if prman nodes don't exist yet, we have to open the renderGlobals window
                # before importing, so the renderer can finish creating nodes!
                if n!=genericAsset.m.ls(n) and not genericAsset.m.about(batch=1):
                    genericAsset.meval('unifiedRenderGlobalsWindow')
            except: pass

            genericAsset.maya.cleanNodes( genericAsset.m.ls('SAM_renderSettings*' ) ) #genericAsset.m.ls('*%s*' % ( '_'.join( nodeName.split('_')[:4] ) ) ) )

            node = genericAsset.m.createNode( "transform", n=nodeName )
            genericAsset.m.addAttr( node, ln="SAM_RENDERSETTINGS", dt="string" )
            genericAsset.m.setAttr( node + '.SAM_RENDERSETTINGS', '\n'.join(lines), type="string"  )
            #
            # maya.setRenderSettings( )
            # lines = maya.filterOnlyAllowedNodesInMA( _lines )
            maya.setRenderSettings( )

            # delete any mesh that may get into the exported scene.
            maya.cleanNodes( [ x for x in genericAsset.m.ls("SAM_renderSettings*", dag=1,type='mesh', l=1) if 'SAM' not in x.split('|')[-1] ] )

            genericAsset.m.select( node )
            return True
        return False






IECore.registerRunTimeTyped( maya )
