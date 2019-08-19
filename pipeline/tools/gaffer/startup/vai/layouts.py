##########################################################################
#
#  Copyright (c) 2011-2012, John Haddon. All rights reserved.
#  Copyright (c) 2011-2013, Image Engine Design Inc. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#      * Redistributions of source code must retain the above
#        copyright notice, this list of conditions and the following
#        disclaimer.
#
#      * Redistributions in binary form must reproduce the above
#        copyright notice, this list of conditions and the following
#        disclaimer in the documentation and/or other materials provided with
#        the distribution.
#
#      * Neither the name of John Haddon nor the names of
#        any other contributors to this software may be used to endorse or
#        promote products derived from this software without specific prior
#        written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

import GafferUI

import jobManager

import assetListWidget
import bundleListWidget

layouts = GafferUI.Layouts.acquire( application )

# register the editors we want to be available to the user

layouts.registerEditor( "Viewer" )
layouts.registerEditor( "NodeEditor" )
layouts.registerEditor( "NodeGraph" )
layouts.registerEditor( "SceneHierarchy" )
layouts.registerEditor( "SceneInspector" )
layouts.registerEditor( "ScriptEditor" )
layouts.registerEditor( "Browser" )
layouts.registerEditor( "Timeline" )
layouts.registerEditor( "UIEditor" )
layouts.registerEditor( "SAMList" )
layouts.registerEditor( "SAMBundleList" )
layouts.registerEditor( "JOBList" )

# register some predefined layouts
layout2 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.163087, ( {'tabs': (), 'tabsVisible': True, 'pinned': []}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.720387, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) )"
layout4 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.162910, ( {'tabs': (GafferUI.JOBListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.720247, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) )"
# layout4 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.162910, ( {'tabs': (GafferUI.SAMAssetListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.720247, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) )"
layout10 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.287942, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.491561, ( {'tabs': (), 'tabsVisible': True, 'pinned': []}, {'tabs': (GafferUI.JOBListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Horizontal, 0.720576, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0,'pinned': [None]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) )"
#layout11 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.287942, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.491561, ( {'tabs': (), 'tabsVisible': True, 'pinned': []}, {'tabs': (GafferUI.SAMAssetListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Horizontal, 0.720576, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0,'pinned': [None]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) )"
layout13 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.195207, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.399390, ( {'tabs': (), 'tabsVisible': True, 'pinned': []}, {'tabs': (GafferUI.SAMAssetListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Horizontal, 0.819110, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.500606, ( {'tabs': (), 'tabsVisible': True, 'pinned': []}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) ) ) )"
layout14 =  "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.194541, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.398176, ( {'tabs': (GafferUI.SAMbundleListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.SAMAssetListWidget( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Horizontal, 0.819696, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.500657, ( {'tabs': (), 'tabsVisible': True, 'pinned': []}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) ) ) )"
l17 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.194266, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.398773, ( {'tabs': (GafferUI.SAMbundleListWidget( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Horizontal, 0.753465, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.501211, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) ) ) )"
l21 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113821, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.753289, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.500657, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) ) ) )"
l30 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113728, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 1.000000, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.500605, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (), 'tabsVisible': True, 'pinned': []} ) ) ) ) ) ) )"
l40 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113821, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.753289, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.206522, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [True]}, {'tabs': (GafferUI.ScriptEditor( scriptNode ), GafferUI.NodeEditor( scriptNode )), 'tabsVisible': True, 'currentTab': 1, 'pinned': [None, False]} ) ) ) ) ) ) )"
l40 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113821, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.723684, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.970652, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.494565, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [True]}, {'tabs': (GafferUI.ScriptEditor( scriptNode ), GafferUI.NodeEditor( scriptNode )), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None, False]} ) ) ) ) ) ) )"
l50 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113821, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.753289, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.369565, ( {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.951220, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]} ) ) ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.205435, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [True]}, {'tabs': (GafferUI.ScriptEditor( scriptNode ), GafferUI.NodeEditor( scriptNode )), 'tabsVisible': True, 'currentTab': 1, 'pinned': [None, False]} ) ) ) ) ) ) )"
l60 = "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113821, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.753289, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.552174, ( {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, ( GafferUI.SplitContainer.Orientation.Vertical, 0.911330, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]} ) ) ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.492391, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (GafferSceneUI.SceneHierarchy( scriptNode ), GafferUI.ScriptEditor( scriptNode )), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False, None]} ) ) ) ) ) ) )"

# layouts.add( "Default", l60 )



layouts.add( "Default", "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.170588, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.227214, ( {'tabs': (GafferUI.JOBPanel( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Horizontal, 0.669042, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.559692, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.869767, ( {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]} ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.653402, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (GafferSceneUI.SceneHierarchy( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]} ) ) ) ) ) ) )" )

layouts.add( "user:Layout 1", "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.113725, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]}, ( GafferUI.SplitContainer.Orientation.Horizontal, 0.753333, ( ( GafferUI.SplitContainer.Orientation.Vertical, 0.551990, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.142433, ( {'tabs': (GafferUI.SAMPanel( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]} ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.895044, ( {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [None]}, {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': False, 'currentTab': 0, 'pinned': [None]} ) ) ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.492940, ( {'tabs': (GafferUI.NodeEditor( scriptNode ),), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False]}, {'tabs': (GafferSceneUI.SceneHierarchy( scriptNode ), GafferUI.ScriptEditor( scriptNode )), 'tabsVisible': True, 'currentTab': 0, 'pinned': [False, None]} ) ) ) ) ) ) )" )


#  '''
#     GafferUI.CompoundEditor( scriptNode, children = (
#         GafferUI.SplitContainer.Orientation.Vertical, 0.97, (
#             {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0},
#             (
#             GafferUI.SplitContainer.Orientation.Horizontal, 0.70,( (
#                 GafferUI.SplitContainer.Orientation.Vertical, 0.48, (
#                     {'tabs': (GafferUI.Viewer( scriptNode ),), 'tabsVisible': True, 'currentTab': 0},
#                     {'tabs': (GafferUI.NodeGraph( scriptNode ),), 'tabsVisible': True, 'currentTab': 0}
#                 )
#             ),(
#                 GafferUI.SplitContainer.Orientation.Vertical, 0.54, (
#                     {'tabs': (GafferUI.NodeEditor( scriptNode ), GafferSceneUI.SceneInspector( scriptNode )), 'tabsVisible': True, 'currentTab': 0},
#                     {'tabs': (GafferSceneUI.SceneHierarchy( scriptNode ), GafferUI.ScriptEditor( scriptNode )), 'tabsVisible': True, 'currentTab': 0}
#                 )
#             )
#         ) ),
#               {'tabs': (GafferUI.Timeline( scriptNode ),), 'tabsVisible': False, 'currentTab': 0}
#         ) )
#     )'''.replace('\n', '')
# )

layouts.add( "Scene", "GafferUI.CompoundEditor( scriptNode, children = ( GafferUI.SplitContainer.Orientation.Horizontal, 0.772664, ( ( GafferUI.SplitContainer.Orientation.Horizontal, 0.255898, ( (GafferSceneUI.SceneHierarchy( scriptNode ),), ( GafferUI.SplitContainer.Orientation.Vertical, 0.500000, ( ( GafferUI.SplitContainer.Orientation.Vertical, 1.000000, ( (GafferUI.Viewer( scriptNode ),), (GafferUI.Timeline( scriptNode ),) ) ), (GafferUI.NodeGraph( scriptNode ),) ) ) ) ), ( GafferUI.SplitContainer.Orientation.Vertical, 0.500000, ( (GafferUI.NodeEditor( scriptNode ),), (GafferSceneUI.SceneInspector( scriptNode ),) ) ) ) ) )" )
layouts.add( "Empty", "GafferUI.CompoundEditor( scriptNode )" )

del layouts # avoid polluting the namespace for other config files
