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
from multiprocessing import cpu_count

try: from importlib import reload
except: pass


import genericAsset
reload(genericAsset)

from genericAsset import m

class maya( genericAsset.maya ) :
    _color = IECore.Color3f( 0.20, 0.35, 0.20 )

    def __init__( self ) :
        genericAsset.maya.__init__(self, 'shave')


    def doPublishMayaExport(self, fileName, operands):
        '''
        create mapping nodes before publishing
        '''

        # find all shave nodes
        shaveNodes = m.ls(self.data['meshPrimitives'], dag=1, l=1, type='shaveHair')
        connectionsToRestore=[]
        createOnlyOne = {}
        for snode in shaveNodes:
            placeholder = "SAM_SHAVE_%s_%s_%02d_%02d_%02d_%s" % (
                self.data['assetType'].replace('/','_'),
                self.data['assetName'].split('.')[-1],
                self.data['assetInfo']['version'].value.x,
                self.data['assetInfo']['version'].value.y,
                self.data['assetInfo']['version'].value.z,
                ''
            )
            # duplicate the shave origin mesh so we can publish a clean scene
            # TODO: disconect all shaders from mesh to avoid exporting shaders!!
            c = m.listConnections( "%s.inputMesh" % snode, p=1, c=1 )
            for n in range(0,len(c),2):
                newNode = c[n+1].split('.')[0]
                if newNode not in createOnlyOne:
                    m.setAttr( "%s.visibility" % newNode, l=0 )
                    createOnlyOne[newNode] = m.duplicate(newNode, n=placeholder+newNode)
                    createOnlyOne[newNode] = m.parent(createOnlyOne[newNode], w=1)[0]
                    # self.data['meshPrimitives'] += m.ls(createOnlyOne[newNode],l=1)
                    m.setAttr( "%s.visibility" % createOnlyOne[newNode], 0 )

                m.disconnectAttr( c[n+1], c[n] )
                m.connectAttr( "%s.%s" % ( createOnlyOne[newNode], c[n+1].split('.')[-1] ), c[n] )
            connectionsToRestore += c
            # m.connectAttr( '%s.%s' % ( m.listRelatives(snode, c=1)[0], c[1].split('.')[-1] ), c[0], f=1)

            if not m.objExists(snode + '.SAM_ORIGINAL_NODE'):
                m.addAttr( snode, ln="SAM_ORIGINAL_NODE", dt="string" )
            m.setAttr( snode + '.SAM_ORIGINAL_NODE', str(c), type="string"  )

            c = m.listConnections( snode, type='file',  p=1, c=1 )
            if c:
                for n in range(0,len(c),2):
                    m.disconnectAttr( c[n+1], c[n] )
                connectionsToRestore += c

        # use the generic maya export to write scene
        genericAsset.maya.doPublishMayaExport(self, fileName, operands)

        for n in range(0,len(connectionsToRestore),2):
            # print( connectionsToRestore[n+1], connectionsToRestore[n] )
            m.connectAttr( connectionsToRestore[n+1], connectionsToRestore[n], f=1 )

        for node in createOnlyOne:
            if m.objExists(createOnlyOne[node]):
                m.delete(createOnlyOne[node])



    def doImportMaya( self, filename, nodeName ):
        ''' called by SAM when import an asset in maya '''

        if not m.pluginInfo("shaveNode", q=1, l=1):
            m.loadPlugin('shaveNode')

        # cleanup shading leftovers
        cleanup = m.ls('|%s*' % ( '_'.join( nodeName.split('_')[:4] ) ) )

        for each in cleanup:
            if m.objExists( "%s.visibility" % each ):
                m.setAttr( "%s.visibility" % each, 0 )

        maya.cleanNodes( cleanup )
        genericAsset.maya.cleanUnusedShadingNodes()

        ret = genericAsset.maya.doImportMaya( self, filename, nodeName )

        # cleanup useless nodes
        allNodes = [ x for x in m.ls(nodeName, dag=1,l=1)  ]

        # remove namespaces, if any!
        for x in [ x for x in allNodes if ':' in x ]:
            try:
                m.rename( x.split('|')[-1], x.split(':')[-1] )
            except: pass

        # refresh allNodes with the new cleaned names
        allNodes = [ x for x in m.ls(nodeName, dag=1)  ]

        # get the shave nodes and the connected nodes
        shaveNodes = m.ls(nodeName, dag=1, type='shaveHair')
        nonDeletable = []
        for x in shaveNodes:
            for n in m.listConnections( x ):
                node = m.ls(n, dag=1, l=1)
                if not node:
                    node = [n]
                nonDeletable += node

        # delete everything that is not connected to the shave nodes!!
        for x in allNodes:
            if x not in nonDeletable and 'SAM_SHAVE' not in x:
                nodeType = m.ls(x,showType=1)
                if nodeType and nodeType[1] not in ['shaveHair','transform']:
                    m.delete(x)

        # delNodes = [x for x in allNodes if x not in nonDeletable and 'SAM_SHAVE' not in x and m.ls(x,showType=1)[1] not in ['shaveHair','transform'] ]

        # if ret is True, onRefreshCallback will be called after we return
        return ret

    @staticmethod
    def onRefreshCallback( assetType, nodeNamePrefix ):
        '''
            This method is called by SAM to refresh whatever setup needs to be done
            when this type of asset is in the scene.
        '''
        if m and m.pluginInfo('shaveNode.so', query=1, loaded=1):
            # shave doesn't like any group named shaveDisplayGroup that doesn't have a proper shave setup,
            # so we must remove any group named shaveDisplayGroup that don't belongs to a SAM_shave asset
            cleanup = [ x for x in m.ls('shaveDisplayGroup',l=1) if '|SAM_shave' not in x ]
            if cleanup:
                m.delete(cleanup)

            # genericAsset.maya.cleanUnusedShadingNodes()

            for n in m.ls( '|%s*' % nodeNamePrefix, dag=1, l=1, type='shaveHair' ):
                hiddenMesh = m.listConnections( "%s.inputMesh" % n , p=1, c=1 )
                if hiddenMesh:
                    m.disconnectAttr(hiddenMesh[1],hiddenMesh[0])
                c=eval( m.getAttr( "%s.SAM_ORIGINAL_NODE" % n ) )
                if c and  m.objExists(c[1]):# and not m.listConnections( hiddenMesh[1].split('.')[0]+'.inMesh', p=1, c=1 ):
                    m.connectAttr(c[1],c[0])
                    # m.connectAttr(c[1].split('.')[0]+'.outMesh',hiddenMesh[1].split('.')[0]+'.inMesh')

                    # attach the shaders onto the shave geometry
                    # for sg in m.listConnections(hiddenMesh[0].split('.')[0],  type="shadingEngine"):
                    #     m.sets( c[1].split('.')[0], e=True, forceElement=sg )

            # m.setAttr( "defaultRenderGlobals.preRenderMel", "shave_rmanFrameStart", type="string" )
            # m.setAttr( "renderManRISGlobals.rman__torattr___renderBeginScript", "rmanTimeStampScript;shave_rmanRenderStart", type="string" )
            # m.setAttr( "renderManRISGlobals.rman__torattr___preRenderScript", "shave_rmanSetOptions", type="string" )
            # m.setAttr( "renderManRISGlobals.rman__torattr___postRenderScript", "shave_rmanInjectCleanup", type="string" )
            # m.setAttr( "renderManRISGlobals.rman__torattr___postTransformScript", "shave_rmanInsertArchive", type="string" )


IECore.registerRunTimeTyped( maya )
