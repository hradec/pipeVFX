

import os, sys
import IECore
import GafferUI
import nodeMD5
import genericAsset

try:
    import maya.cmds as m
except:
    m = None

CTRLS = '|CTRLS|'
ROOT  = '|ROOT|'
GRP   = '__SAM_TMP__'

# this function is called from the right click menu on assetListWidget
# we can use it to change the menu and add new functionality!
def assetListRightClickMenu( self, pathListing, menuDefinition ):
    selectedPaths = pathListing.getSelectedColumns()['assetFullPath']
    print "XXXXXXXXXXXXXXXXXX"
    if len(selectedPaths)>=1:
        if 'rigging/' in selectedPaths[0]:
            try:
                menuDefinition.insertAfter( "/import selected and apply animation from a maya scene, using rig controls", { "command" :  IECore.curry( checkoutRigAndApplyAnimation, self ) }, "/Import selected" )
                menuDefinition.insertAfter( "/       ", { }, "/Import selected" )
            except:
                pass
    return menuDefinition


# apply animation from a maya scene file to a asset rig!
def checkoutRigAndApplyAnimation(self, paths = None):
    if not paths:
        paths = self.getSelectedColumns()['assetFullPath']

    if m:
        from maya.mel import eval as meval
        meval('source doCreateParentConstraintArgList')
        # import the animation from a maya scene and apply to rig
        # basically imports the animated rig, keeps the crtl meshes and delete
        # everything, and attach the imported crtl transforms to the asset rig
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            # first collect the maya scenes
            _file="xx"
            path_anim_scene = {}
            for path in paths:
                # for file in  m.fileDialog2( caption="Select the Maya Scene file to extract the animation!!", startingDirectory=os.getcwd(), fileFilter=("Maya Scenes (*.m?)") , okCaption="Open" ):
                if _file:
                    _file  = m.fileDialog( dm="*.m?" , mode=0, title="Open maya scene that contains animation for %s" % path)
                # we can cancel after having one file... in this case, it will use the last selected one again
                if _file:
                    file = _file
                path_anim_scene[path] = file

            # remove old tmp groups!
            # if m.ls('|%s*' % GRP):
            #     m.delete('|%s*' % GRP)

            # now we import the file, asset and attach the controls.
            pb1 = genericAsset.progressBar(len(paths)*3+1, 'importing assets and animation from maya scene file...')
            pb1.step()
            for path in paths:
                pb1.step()
                asset = self.checkout([path])
                asset_maya_name = os.path.dirname(path).replace('/','_')
                file_maya_name = os.path.basename(path_anim_scene[path]).replace('/','_').replace('.','_').replace(' ','_')
                GRP_asset_maya_name = GRP+file_maya_name

                # open maya scene inside a group, if not already opened!
                pb1.step()
                if not m.objExists(GRP_asset_maya_name):
                    m.file( path_anim_scene[path], i=1, gr=1, ignoreVersion=1, gn=GRP_asset_maya_name )

                m.setAttr('%s.visibility' % GRP_asset_maya_name, 0)

                # leave only the controls from the imported scene
                # and gather their names into a list
                pb1.step()
                m.delete([ x for x in m.ls('%s|*' % GRP_asset_maya_name, dag=1, l=1, type='mesh') if CTRLS not in x ])
                CTRLS_MESHES = [ x for x in m.ls('%s|*' % GRP_asset_maya_name, dag=1, l=1, type='mesh') if CTRLS in x ]
                CTRLS_MESHES.sort()
                CTRLS_MESHES = list(set(CTRLS_MESHES))

                # attach the meshes from the imported ctrls to the asset rig ones
                # gather the controls from the imported sam asset
                asset_nodes = [ x for x in m.ls( '|SAM_%s*' % asset_maya_name, dag=1, l=1 ) if CTRLS in x and GRP not in x ]
                asset_nodes.sort()
                asset_nodes = list(set(asset_nodes))
                # now go over the animated crtl nodes and attach then to
                # the asset rig crtl nodes!
                pb2 = genericAsset.progressBar(len(CTRLS_MESHES)+1, 'Attaching animation controls to imported rig assets...')
                pb2.step()
                md5 = nodeMD5.nodeMD5()
                for node in CTRLS_MESHES:
                    pb2.step()
                    tnode = m.listRelatives(node, p=1, f=1)[0]
                    anim = node.split(ROOT)[-1]

                    # use the embbed md5 on the animation to find the nodes we
                    # have to attach to!
                    nodemd5 = md5.getNodeMD5(node)
                    if nodemd5:
                        nodes_original_rig = [ x for x in md5.getNodeByMD5( nodemd5 ) if x != node and asset_maya_name in x ]
                    else:
                        nodes_original_rig = [ x for x in asset_nodes if anim in x ]

                    nodes_original_rig.sort()
                    nodes_original_rig = list(set(nodes_original_rig))
                    # only select the asset rig crtl nodes that match the
                    # current animated one!
                    for rig in nodes_original_rig:
                        trig  = m.listRelatives(rig, p=1, f=1)[0]
                        # print asset_maya_name
                        # print tnode
                        # print trig
                        # sys.stdout.flush()
                        if m.nodeType( node ) == 'mesh':
                            m.connectAttr( tnode+".translate", trig+".translate", f=1 )
                            m.connectAttr( tnode+".rotate", trig+".rotate", f=1 )
                            m.connectAttr( tnode+".scale", trig+".scale", f=1 )

                pb2.close()
            pb1.close()
