

import os, sys
import IECore
import GafferUI
import nodeMD5
import pipe.maya

try:
    import maya.cmds as m
except:
    m = None

import genericAsset
# reload(genericAsset)
print genericAsset.m
genericAsset.m = m

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


    import maya.cmds as m


# apply animation from a maya scene file to a asset rig!
def checkoutRigAndApplyAnimation(self, paths = None, maya_scene=None):
    ''' this function is solely to be called from an UI environment
    it will import assets and file prior to call the animation connection functin '''

    if not paths:
        paths = self.getSelectedColumns()['assetFullPath']
    print self, paths, maya_scene

    if m:
        from maya.mel import eval as meval
        meval('source doCreateParentConstraintArgList')
        # import the animation from a maya scene and apply to rig
        # basically imports the animated rig, keeps the crtl meshes and delete
        # everything, and attach the imported crtl transforms to the asset rig
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            if not maya_scene:
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
            else:
                path_anim_scene = { x:maya_scene for x in paths }


            # now we import the file, asset and attach the controls.
            pb1 = genericAsset.progressBar(len(paths)*3+1, 'importing assets and animation from maya scene file...')
            pb1.step()
            for path in paths:
                pb1.step()
                asset = self.checkout([path])
                asset_maya_name = os.path.dirname(path).replace('/','_')
                file_maya_name = os.path.basename(path_anim_scene[path]).replace('/','_').replace('.','_').replace(' ','_')

                # open maya scene inside a group, if not already opened!
                pb1.step()
                GRP_asset_maya_name = GRP+file_maya_name
                if not m.objExists(GRP_asset_maya_name):
                    m.file( path_anim_scene[path], i=1, gr=1, ignoreVersion=1, gn=GRP_asset_maya_name )
                genericAsset.maya.removeNamespaces()

                m.setAttr('%s.visibility' % GRP_asset_maya_name, 0)

            assetListAssetImport()



# apply animation from a maya scene file to a asset rig!
# def applyAnimation(self, paths = None):
#     ''' deprecated '''
#     import assetUtils
#     if not paths:
#         paths = self.getSelectedColumns()['assetFullPath']
#
#     if m:
#         from maya.mel import eval as meval
#         meval('source doCreateParentConstraintArgList')
#         # import the animation from a maya scene and apply to rig
#         # basically imports the animated rig, keeps the crtl meshes and delete
#         # everything, and attach the imported crtl transforms to the asset rig
#         with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
#             rig_maya_names = [ x for x in m.ls(sl=1) if '|SAM_rigging_' in x ]
#             if not rig_maya_names:
#                 rig_maya_names = m.ls('|SAM_rigging_*')
#
#             # now we import the file, asset and attach the controls.
#             pb1 = genericAsset.progressBar(len(paths)*3*len(rig_maya_names)+1, 'importing assets and animation from maya scene file...')
#             pb1.step()
#             for path in paths:
#                 pb1.step()
#                 for rig_maya_name in rig_maya_names:
#                     pb1.step()
#                     _connectAnimation( self, path, rig_maya_name )
#
#             pb1.close()


def _cleanupAnimationScene(GRP_asset_maya_name, filter=CTRLS):
    ''' cleanup animation scene so we have it the fastest we can '''
    if m:
        # remove namespaces
        genericAsset.m = m
        genericAsset.maya.removeNamespaces()

        # try to delete everything that's not controls in the animation imported scene!
        for each in m.ls(GRP_asset_maya_name+"*", dag=1, l=1):
            if filter not in each:
                    # print filter, each
                    if m.objExists(each) and len(each.split('|'))>4:
                        try: m.delete(each)
                        except: pass




def manualAssetAnimImport( assets, maya_scene):
    ''' imports the assets into maya and imports the maya scene with animation,
    prior to call _connectAnimation. This is the function to be used in scripts without
    assetListWidget. (without X11/UI)'''
    if m:
        import time, datetime
        import assetUtils
        # import animation file
        ticStart = time.time()
        tic = time.time()
        GRP_asset_maya_name = GRP+os.path.basename(maya_scene).replace('/','_').replace('.','_').replace(' ','_')
        print GRP_asset_maya_name
        print maya_scene
        if not m.objExists(GRP_asset_maya_name):
            m.file( maya_scene, i=1, gr=1, ignoreVersion=1, gn=GRP_asset_maya_name )
            _cleanupAnimationScene(GRP_asset_maya_name, CTRLS)

        print "loading animation scene took %s secs" % str(datetime.timedelta(seconds=time.time()-tic))
        # remove namespaces!
        tic = time.time()
        genericAsset.maya.removeNamespaces()
        print "cleaning namespaces took %s" % str(datetime.timedelta(seconds=time.time()-tic))

        # import assets!
        if type(assets) != type([]):
            assets = [assets]
        for assetPath in assets:
            tic = time.time()
            op = assetUtils.assetOP( assetPath , 'maya' )
            op.doImport( )
            print "importing rig %s took %s" % (assetPath, str(datetime.timedelta(seconds=time.time()-tic)))

        # from now, we call the function used by the UI version!
        tic = time.time()
        assetListAssetImport()
        print "attaching animation took %s" % str(datetime.timedelta(seconds=time.time()-tic))

        print "total time: %s" % str(datetime.timedelta(seconds=time.time()-ticStart))

def assetListAssetImport():
    ''' called with assets already imported and animation file as well.
    it will gather the maya node names and pass then on to _connectAnimation'''
    if m:
        for rig_maya_name in m.ls('|SAM_rigging_*'):
            for animation_asset_path in  m.ls("|__SAM_TMP__*")+m.ls("|SAM_animation_*"):
                _connectAnimation( animation_asset_path, rig_maya_name, loadFile=False )

def _connectAnimation( animation_asset_path, rig_maya_name, loadFile=True ):
    ''' connect animations from a standard maya scene to the sam original
    published rigging asset '''
    if m:
        rig_maya_name = str(rig_maya_name)
        import assetUtils
        asset_maya_name = "rigging"

        if not loadFile:
            # this runs when _connectAnimation is called from
            # assetListAssetImport or manualAssetAnimImport
            # in this case, animation_asset_path is the name of the maya group
            # holding the animation scene previously imported!
            # (animation and assets have being imported prior to call this function!)
            GRP_asset_maya_name = animation_asset_path
            file_maya_name = GRP_asset_maya_name.split(GRP)[-1]
        else:
            # this runs when we have to load the maya scene from disk.
            # in this case, the maya scene actually is the asset maya scene stored in
            # an animation/maya asset, passed on to us in animation_asset_path
            op = assetUtils.assetOP( animation_asset_path , 'maya' )
            path_anim_scene = {}
            path_anim_scene[animation_asset_path] = op.data['publishFile'] % op.data['multipleFiles'][0]
            file_maya_name = os.path.basename(path_anim_scene[animation_asset_path]).replace('/','_').replace('.','_').replace(' ','_')
            GRP_asset_maya_name = GRP+file_maya_name


        # only continue if we have the required CTRL and ROOT groups in the rig!
        rig_list = m.ls('|%s*' % rig_maya_name, l=1, dag=1)
        rig_list_root = [ x for x in rig_list if ROOT in x ]
        rig_list_ctrls = [ x for x in rig_list if CTRLS in x ]
        if rig_list_ctrls and rig_list_root:

            # open maya scene inside a group, if not already opened!
            if not m.objExists(GRP_asset_maya_name):
                m.file( path_anim_scene[animation_asset_path], i=1, gr=1, ignoreVersion=1, gn=GRP_asset_maya_name )

            # list everything inside the animation group
            anim_list = m.ls('%s|*' % GRP_asset_maya_name, dag=1, l=1, type='mesh')
            anim_list_ctrls = [ x for x in anim_list if CTRLS in x ]
            # and only continue if we have the required groups for conection inside the animation group
            if anim_list_ctrls:

                # make sure animation seem is clean and lean!!
                _cleanupAnimationScene(GRP_asset_maya_name, CTRLS)

                # set time slider to the found time range from the animation in the
                # imported maya scene
                print GRP_asset_maya_name
                genericAsset.maya.setTimeSliderRangeToAvailableAnim()
                # startFrame, endFrame = genericAsset.maya.getAllNodesMinMax(GRP_asset_maya_name, CTRLS)
                # m.playbackOptions( e=1, minTime=startFrame, maxTime=endFrame, animationStartTime=startFrame, animationEndTime=endFrame )

                # and hide it!
                for each in m.ls(GRP_asset_maya_name):
                    m.setAttr('%s.visibility' % each, 0)

                # as CTRL is a start of a string, we must find the CRTL for the current
                # rig_maya_name!
                CURRENT_CTRLS = '|%s|' % [z for z in rig_list_ctrls[0].split('|') if CTRLS.replace('|','') in z][0]
                CURRENT_ROOT = '|%s|' % [z for z in rig_list_root[0].split('|') if ROOT.replace('|','') in z][0]
                # print rig_maya_name, CURRENT_CTRLS, CURRENT_ROOT

                # leave only the controls from the imported scene
                # and gather their names into a list
                m.delete([ x for x in anim_list if CURRENT_CTRLS not in x ])
                CTRLS_MESHES = [ x for x in anim_list if CURRENT_CTRLS in x and CURRENT_ROOT in x]
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
                    print "attaching %s to rig nodes %s..." % ( str(node), str(nodes_original_rig) )
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
                                # if  'moveall_0_ctrl' in tnode[-20:]:
                                #     print connected , tnode
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
                                        # if  'moveall_0_ctrl' in tnode[-20:]:
                                        #     print '%s.%s' % (tnode, attr), '%s.%s' % (trig, attr)
                                        m.connectAttr( '%s.%s' % (tnode, attr), '%s.%s' % (trig, attr), f=1 )

                pb2.close()
