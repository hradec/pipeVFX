

import os, sys
import IECore
import GafferUI
import nodeMD5
import genericAsset
import pipe.maya

try:
    import maya.cmds as m
except:
    m = None

CTRLS = '|CTRLS|'
ROOT  = '|ROOT'
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
        # if 'animation/maya/' in selectedPaths[0]:
        #     try:
        #         menuDefinition.insertAfter( "/apply the asset animation using rig controls", { "command" :  IECore.curry( applyAnimation, self ) }, "/Import selected" )
        #         menuDefinition.insertAfter( "/       ", { }, "/Import selected" )
        #     except:
        #         pass
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




def assetListAssetImport(self):
    if m:
        for rig_maya_name in m.ls('|SAM_rigging_*'):
            for animation_asset_path in  m.ls("|__SAM_TMP__*")+m.ls("|SAM_animation_*"):
                _connectAnimation( self, animation_asset_path, rig_maya_name, loadFile=False )


# apply animation from a maya scene file to a asset rig!
def applyAnimation(self, paths = None):
    import assetUtils
    if not paths:
        paths = self.getSelectedColumns()['assetFullPath']

    if m:
        from maya.mel import eval as meval
        meval('source doCreateParentConstraintArgList')
        # import the animation from a maya scene and apply to rig
        # basically imports the animated rig, keeps the crtl meshes and delete
        # everything, and attach the imported crtl transforms to the asset rig
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            rig_maya_names = [ x for x in m.ls(sl=1) if '|SAM_rigging_' in x ]
            if not rig_maya_names:
                rig_maya_names = m.ls('|SAM_rigging_*')

            # now we import the file, asset and attach the controls.
            pb1 = genericAsset.progressBar(len(paths)*3*len(rig_maya_names)+1, 'importing assets and animation from maya scene file...')
            pb1.step()
            for path in paths:
                pb1.step()
                for rig_maya_name in rig_maya_names:
                    pb1.step()
                    _connectAnimation( self, path, rig_maya_name )

            pb1.close()

def _connectAnimation( self, animation_asset_path, rig_maya_name, loadFile=True ):
    if m:
        rig_maya_name = str(rig_maya_name)
        import assetUtils
        path = animation_asset_path
        path_anim_scene = {}
        asset_maya_name = "rigging"

        if not loadFile:
            # if path is an already import animation
            GRP_asset_maya_name = path
            file_maya_name = GRP_asset_maya_name.split(GRP)[-1]
        else:
            # else path is an asset to be imported to apply animation to
            op = assetUtils.assetOP( path , self.hostApp() )
            path_anim_scene[path] = op.data['publishFile'] % op.data['multipleFiles'][0]
            # asset_maya_name = os.path.dirname(path).replace('/','_')
            file_maya_name = os.path.basename(path_anim_scene[path]).replace('/','_').replace('.','_').replace(' ','_')
            GRP_asset_maya_name = GRP+file_maya_name

            # open maya scene inside a group, if not already opened!
            if not m.objExists(GRP_asset_maya_name):
                m.file( path_anim_scene[path], i=1, gr=1, ignoreVersion=1, gn=GRP_asset_maya_name )

        m.setAttr('%s.visibility' % GRP_asset_maya_name, 0)

        # as CTRL is a start of a string, we must find the CRTL for the current
        # rig_maya_name!
        CURRENT_CTRLS = '|%s|' % [
            z for z in [
                x for x in m.ls('|%s*' % rig_maya_name, l=1, dag=1) if CTRLS in x
            ][0].split('|') if CTRLS.replace('|','') in z
        ][0]
        CURRENT_ROOT = '|%s|' % [
            z for z in [
                x for x in m.ls('|%s*' % rig_maya_name, l=1, dag=1) if ROOT in x
            ][0].split('|') if ROOT.replace('|','') in z
        ][0]
        print rig_maya_name, CURRENT_CTRLS, CURRENT_ROOT

        # leave only the controls from the imported scene
        # and gather their names into a list
        m.delete([ x for x in m.ls('%s|*' % GRP_asset_maya_name, dag=1, l=1, type='mesh') if CURRENT_CTRLS not in x ])
        CTRLS_MESHES = [ x for x in m.ls('%s|*' % GRP_asset_maya_name, dag=1, l=1, type='mesh') if CURRENT_CTRLS in x and CURRENT_ROOT in x]
        CTRLS_MESHES.sort()
        CTRLS_MESHES = list(set(CTRLS_MESHES))

        # attach the meshes from the imported ctrls to the asset rig ones
        # gather the controls from the imported sam asset
        asset_nodes = [ x for x in m.ls( '|SAM_%s*' % asset_maya_name, dag=1, l=1 ) if CURRENT_CTRLS in x and CURRENT_ROOT in x and GRP not in x ]
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
                nodes_original_rig = [ x for x in md5.getNodeByMD5( nodemd5 ) if x != node and rig_maya_name in x and CURRENT_ROOT in x]
                if len(nodes_original_rig)!=1:
                    nodemd5 = False

            # fallback mode to use the node name to attach animation, if md5 is broken!
            if not nodemd5:
                nodes_original_rig = [ x for x in asset_nodes if anim in x  and rig_maya_name in x and CURRENT_ROOT in x ]

            # print len(nodes_original_rig), node, nodemd5, len(md5.getNodeByMD5( nodemd5 ))

            nodes_original_rig.sort()
            nodes_original_rig = list(set(nodes_original_rig))
            # only select the asset rig crtl nodes that match the
            # current animated one!
            for rig in nodes_original_rig:
                trig  = m.listRelatives(rig, p=1, f=1)[0]
                if m.nodeType( node ) == 'mesh':
                    # gather all extra attributes in the control meshes (excluding the md5 one)
                    extra = [ x for x in pipe.maya.getAllExtraAttributes(tnode) if 'md5' not in x ]
                    # main attributes in control meshes that have animation on it
                    attrs = ['translate', 'rotate', 'scale'] + extra
                    # connect the animation to the rig control meshes
                    for attr in attrs:
                        # we connect by default
                        do_connect = True
                        # unless we have something already connected.
                        connected = m.listConnections('%s.%s' % (trig, attr), p=1, d=0, s=1)
                        if  'moveall_0_ctrl' in tnode[-20:]:
                            print connected , tnode
                        if connected:
                            # if something is connected, we can't connect
                            do_connect = False
                            for c in connected:
                                # unless the connection is not from the rig itself
                                # in this case, we break it so we can connect!
                                if 'SAM_rigging_' not in c:
                                    # disconnect it so we can connect the animation!
                                    m.disconnectAttr( c, '%s.%s' % (trig, attr) )
                                    do_connect = True

                        # we can connect
                        if do_connect:
                            # only connect if the rig attribute is not locked
                            if m.getAttr("%s.%s" % (trig, attr), settable=1):
                                if  'moveall_0_ctrl' in tnode[-20:]:
                                    print '%s.%s' % (tnode, attr), '%s.%s' % (trig, attr)
                                m.connectAttr( '%s.%s' % (tnode, attr), '%s.%s' % (trig, attr), f=1 )

        pb2.close()
