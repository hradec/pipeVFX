

import os
import IECore
import GafferUI

try:
    import maya.cmds as m
except:
    m = None

# this function is called from the right click menu on assetListWidget
# we can use it to change the menu and add new functionality!
def assetListRightClickMenu( self, pathListing, menuDefinition ):
    selectedPaths = pathListing.getSelectedColumns()['assetFullPath']
    if len(selectedPaths)>=1:
        if 'rigging/' in selectedPaths[0]:
            menuDefinition.insertAfter( "/import selected and apply animation from a maya scene", { "command" :  IECore.curry( checkoutRigAndApplyAnimation, self ) }, "/Import selected" )
            menuDefinition.insertAfter( "/ ", { }, "/Import selected" )

    return menuDefinition



def checkoutRigAndApplyAnimation(self, paths = None):
    if not paths:
        paths = self.getSelectedColumns()['assetFullPath']

    if m:
        # import the animation from a maya scene and apply to rig
        # basically imports the animated rig, keeps the crtl meshes and delete
        # everything, and attach the imported crtl transforms to the asset rig
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            # first collect the maya scenes
            path_anim_scene = {}
            for path in paths:
                # for file in  m.fileDialog2( caption="Select the Maya Scene file to extract the animation!!", startingDirectory=os.getcwd(), fileFilter=("Maya Scenes (*.m?)") , okCaption="Open" ):
                _file  = m.fileDialog( dm="*.m?" , mode=0, title="Open maya scene that contains animation for %s" % path)
                # we can cancel after having one file... in this case, it will use the last selected one again
                if _file:
                    file = _file
                if path not in path_anim_scene:
                    path_anim_scene[path] = []
                path_anim_scene[path] += [file]

            # now we import the file, asset and attach the controls.
            for path in paths:
                self.checkout([path])

                # open maya scene inside a group!

                # leave only the controls from the imported scene

                # attach the meshes from the imported ctrls to the asset rig ones
