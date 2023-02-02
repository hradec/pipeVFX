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


import pipe
import Gaffer
import GafferUI
import jobManager
import assetListWidget
import bundleListWidget
import os



# ========================================================================
# setup project root path!
# ========================================================================
def __setupPipeVFX( container, script ) :
	try:
		script["variables"]["projectRootDirectory"]['value'].setValue( "%s/gaffer/" % pipe.admin.job.shot.user().path() )
	except: pass

application.root()["scripts"].childAddedSignal().connect( __setupPipeVFX, scoped = False )

# ========================================================================
# we need this to retrieve the script in our scripts
# ========================================================================
pipe.gafferRoot = application.root
GafferUI.root = application.root

# ========================================================================
# Arnold console output defaults
# ========================================================================
import GafferArnold
arnoldOptionsUserDefaults = {
	"options.consoleInfo" 	  : True,
	"options.consoleWarnings" : True,
	"options.consoleErrors"   : True,
	"options.consoleDebug"    : False,
	"options.consoleAssParse" : False,
	"options.consolePlugins"  : True,
	"options.consoleProgress" : True,
	"options.consoleNAN"      : True,
	"options.consoleTimestamp": False,
	"options.consoleStats"    : True,
	"options.consoleBacktrace": True,
	"options.consoleMemory"   : True,
	"options.consoleColor"    : True,
}
for each in arnoldOptionsUserDefaults:
	value = arnoldOptionsUserDefaults[each]
	Gaffer.Metadata.registerValue( GafferArnold.ArnoldOptions, each + ".value", "userDefault", value )
	Gaffer.Metadata.registerValue( GafferArnold.ArnoldOptions, each + ".enabled", "userDefault", True )


# ========================================================================
# SAM Nodes
# ========================================================================
import nodes, IECore, Gaffer, GafferCortex, GafferScene
moduleSearchPath = IECore.SearchPath( os.environ["PYTHONPATH"], ":" )
nodeMenu = GafferUI.NodeMenu.acquire( application )

# nodeMenu.append( "/SAM/Maya", nodes.mayaScene )
# nodeMenu.append( "/SAM/Publish/render_maya", nodes.RenderMayaPublish )
# nodeMenu.append( "/SAM/Hierarchy/Merge", nodes.Merge )
# nodeMenu.append( "/SAM/Hierarchy/Group", GafferScene.Group )
# nodeMenu.append( "/SAM/Hierarchy/Prune", GafferScene.Prune )
# nodeMenu.append( "/SAM/Hierarchy/Isolate", GafferScene.Isolate )
# nodeMenu.append( "/SAM/Hierarchy/Switch", GafferScene.SceneSwitch, searchText = "SceneSwitch" )
for each in [x for x in dir(nodes) if 'SAM' in x]:
    nodeMenu.append( "/SAM/Assets/%s" % each, eval('nodes.%s' % each) )
nodeMenu.append( "/SAM/ClassLoaderPath", lambda : GafferCortex.ClassLoaderPath(IECore.ClassLoader.defaultOpLoader(), Gaffer.Path('/asset/publish')), searchText = "ClassLoaderPath" )



# ========================================================================
# setup SAM panel
# ========================================================================
layouts = GafferUI.Layouts.acquire( application )

# register the editors we want to be available to the user
layouts.registerEditor( "SAMList" )

#layouts.add( 'SAM', "GafferUI.CompoundEditor( scriptNode, _state={ 'children' : ( GafferUI.SplitContainer.Orientation.Horizontal, 0.157126, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': True, 'currentTab': 0}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.969265, ( {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0}, {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': False, 'currentTab': 0} ) ) ) ), 'detachedPanels' : (), 'windowState' : { 'fullScreen' : False, 'screen' : -1, 'bound' : imath.Box2f( imath.V2f( 0.0500000007, 0.0492424257 ), imath.V2f( 0.949999988, 0.950757563 ) ), 'maximized' : False }, 'editorState' : {} } )", persistent = False )
#layouts.setDefault( 'SAM', persistent = False )
layouts.add( 'Standard+SAM', "GafferUI.CompoundEditor( scriptNode, _state={ 'children' : ( GafferUI.SplitContainer.Orientation.Vertical, 0.962963, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.699888, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.479469, ( {'tabs': (GafferUI.Viewer( scriptNode ), GafferSceneUI.UVInspector( scriptNode )), 'currentTab': 0, 'tabsVisible': True}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.155145, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'currentTab': 0, 'tabsVisible': True}, {'tabs': (GafferUI.GraphEditor( scriptNode ), GafferSceneUI.LightEditor( scriptNode ), GafferUI.AnimationEditor( scriptNode ), GafferSceneUI.PrimitiveInspector( scriptNode )), 'currentTab': 0, 'tabsVisible': True} ) ) ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.538647, ( {'tabs': (GafferUI.NodeEditor( scriptNode ), GafferSceneUI.SceneInspector( scriptNode )), 'currentTab': 0, 'tabsVisible': True}, {'tabs': (GafferSceneUI.HierarchyView( scriptNode ), GafferUI.PythonEditor( scriptNode )), 'currentTab': 0, 'tabsVisible': True} ) ) ) ), {'tabs': (GafferUI.Timeline( scriptNode ),), 'currentTab': 0, 'tabsVisible': False} ) ), 'detachedPanels' : (), 'windowState' : { 'screen' : -1, 'fullScreen' : False, 'maximized' : True, 'bound' : imath.Box2f( imath.V2f( 0, 0.341227114 ), imath.V2f( 0.666666687, 1.02260494 ) ) }, 'editorState' : {'c-0-0-0-0-0': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-0-0-0-1': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-0-1-1-0-1': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-0-1-1-0-3': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-1-0-0-1': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-1-1-0-0': {'nodeSet': 'scriptNode.focusSet()'}} } )", persistent = True )
layouts.add( 'Standard (multi-monitor) + SAM', "GafferUI.CompoundEditor( scriptNode, _state={ 'children' : ( GafferUI.SplitContainer.Orientation.Vertical, 0.962963, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.699888, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.147106, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'currentTab': 0, 'tabsVisible': True}, {'tabs': (GafferUI.GraphEditor( scriptNode ), GafferSceneUI.LightEditor( scriptNode ), GafferUI.AnimationEditor( scriptNode ), GafferSceneUI.PrimitiveInspector( scriptNode )), 'currentTab': 0, 'tabsVisible': True} ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.538647, ( {'tabs': (GafferUI.NodeEditor( scriptNode ), GafferSceneUI.SceneInspector( scriptNode )), 'currentTab': 0, 'tabsVisible': True}, {'tabs': (GafferSceneUI.HierarchyView( scriptNode ), GafferUI.PythonEditor( scriptNode )), 'currentTab': 0, 'tabsVisible': True} ) ) ) ), {'tabs': (GafferUI.Timeline( scriptNode ),), 'currentTab': 0, 'tabsVisible': False} ) ), 'detachedPanels' : ( { 'children' : {'tabs': (GafferUI.Viewer( scriptNode ), GafferSceneUI.UVInspector( scriptNode )), 'currentTab': 0, 'tabsVisible': True}, 'windowState' : { 'screen' : -1, 'fullScreen' : False, 'maximized' : False, 'bound' : imath.Box2f( imath.V2f( 0.104444444, 0.107642628 ), imath.V2f( 0.838333309, 0.90419805 ) ) } }, ), 'windowState' : { 'screen' : -1, 'fullScreen' : False, 'maximized' : True, 'bound' : imath.Box2f( imath.V2f( 0, 0.341227114 ), imath.V2f( 0.666666687, 1.02260494 ) ) }, 'editorState' : {'c-0-0-1-0-1': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-0-1-0-3': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-1-0-0-1': {'nodeSet': 'scriptNode.focusSet()'}, 'c-0-1-1-0-0': {'nodeSet': 'scriptNode.focusSet()'}, 'p-0-0-0': {'nodeSet': 'scriptNode.focusSet()'}, 'p-0-0-1': {'nodeSet': 'scriptNode.focusSet()'}} } )", persistent = True )
layouts.setDefault( 'Standard+SAM', persistent = True )


del layouts # avoid polluting the namespace for other config files
