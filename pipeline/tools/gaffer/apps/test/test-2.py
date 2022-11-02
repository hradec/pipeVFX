#!/usr/bin/env ppython

############################################################################
##
## Copyright (C) 2005-2005 Trolltech AS. All rights reserved.
##
## This file is part of the example classes of the Qt Toolkit.
##
## This file may be used under the terms of the GNU General Public
## License version 2.0 as published by the Free Software Foundation
## and appearing in the file LICENSE.GPL included in the packaging of
## this file.  Please review the following information to ensure GNU
## General Public Licensing requirements will be met:
## http://www.trolltech.com/products/qt/opensource.html
##
## If you are unsure which license is appropriate for your use, please
## review the following information:
## http://www.trolltech.com/products/qt/licensing.html or contact the
## sales department at sales@trolltech.com.
##
## This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
## WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
##
############################################################################


# python3 workaround for reload
from __future__ import print_function
try: from importlib import reload
except: pass




import os
import sys
import re
import weakref
import threading
import ctypes

import IECore

# try :
# 		originalDLOpenFlags = sys.getdlopenflags()
# 		sys.setdlopenflags( originalDLOpenFlags & ~ctypes.RTLD_GLOBAL )
# 		from pxr import Usd
# finally :
# 		sys.setdlopenflags( originalDLOpenFlags )
# import IECoreUSD
# print IECoreUSD.__file__

import Gaffer
import GafferUI
import GafferScene
import GafferSceneUI
import pipe
import genericAsset
import assetUtils

if assetUtils.m:
    reload(genericAsset)
    reload(assetUtils)

# import GafferSceneUI # for alembic previews
# import GafferCortexUI # for alembic previews
# import GafferCortex

# import pipe
# import opaClasses
# #import pipeBrowser
# import Asset
# import samEditor
# import timelineImage

QtCore, QtGui = pipe.importQt()


# from PyQt4 import QtCore, QtGui

# import simpletreemodel_rc


class test( Gaffer.Application ) :

    def __init__( self ) :

        Gaffer.Application.__init__( self )

        self.hostApp = genericAsset.hostApp

        self.parameters().addParameters(

            [
                IECore.StringVectorParameter(
                    name = "scripts",
                    description = "A list of scripts to edit.",
                    defaultValue = IECore.StringVectorData(),
                ),

                IECore.StringVectorParameter(
                    name = "asset",
                    description = "asset to edit",
                    defaultValue = IECore.StringVectorData(),
                ),

                IECore.BoolParameter(
                    name = "fullScreen",
                    description = "Opens the UI in full screen mode.",
                    defaultValue = False,
                ),
                IECore.PathParameter(
                    "initialPath",
                    "The path to browse to initially",
                    "",
                    allowEmptyString = True,
                    check = IECore.PathParameter.CheckType.MustExist,
                ),
                IECore.StringParameter(
                    "type",
                    "only shows assets of the specified type",
                    "",
                ),
                IECore.StringParameter(
                    "action",
                    "select the action mode for sam: import or publish",
                    "import",
                ),
                IECore.StringParameter(
                    "buttons",
                    "specify the asset types to show create buttons for, separated by comma.",
                    "",
                ),
                IECore.StringParameter(
                    "debug",
                    "",
                    "",
                ),
            ]

        )

        self.parameters().userData()["parser"] = IECore.CompoundObject(
            {
                "flagless" : IECore.StringVectorData( [ "initialPath" ] )
            }
        )

        self.__setupClipboardSync()


    def _run( self, args ) :
        # import maya.standalone
        # maya.standalone.initialize()

        self.root().asset = str(args["asset"])
        GafferUI.root = self.root


        GafferUI.ScriptWindow.connect( self.root() )

        if len( args["scripts"] ) :
            for fileName in args["scripts"] :
                scriptNode = Gaffer.ScriptNode()
                scriptNode["fileName"].setValue( os.path.abspath( fileName ) )
                # \todo: Display load errors in a dialog, like in python/GafferUI/FileMenu.py
                scriptNode.load( continueOnError = True )
                self.root()["scripts"].addChild( scriptNode )
                GafferUI.FileMenu.addRecentFile( self, fileName )
        else :
            scriptNode = Gaffer.ScriptNode()

        Gaffer.NodeAlgo.applyUserDefaults( scriptNode )
        self.root()["scripts"].addChild( scriptNode )
        self.scriptNode = scriptNode



        if args["fullScreen"].value :
            primaryScript = self.root()["scripts"][-1]
            primaryWindow = GafferUI.ScriptWindow.acquire( primaryScript )
            primaryWindow.setFullScreen( True )

        #
        # self.timer = QtCore.QTimer()
        # self.timer.timeout.connect(progress)
        # self.timer.start(100)
        # primaryWindow._qtWidget().resize( 1800, 800 )

        # self.setSize()


        GafferUI.EventLoop.mainEventLoop().start()

        return 0

    # def setSize(self, w=20, h=20):
    #     primaryWindow = GafferUI.ScriptWindow.acquire( self.scriptNode )
    #     desktop = QtGui.QApplication.instance().desktop()
    #     geometry = desktop.availableGeometry()
    #     adjustment = geometry.size()
    #     ww = int(adjustment.width())/w
    #     hh = int(adjustment.height())/h
    #     geometry.adjust( ww, hh, -ww, -hh )
    #     primaryWindow._qtWidget().setGeometry( geometry )


    def __setupClipboardSync( self ) :

        ## This function sets up two way syncing between the clipboard held in the Gaffer::ApplicationRoot
        # and the global QtGui.QClipboard which is shared with external applications, and used by the cut and paste
        # operations in GafferUI's underlying QWidgets. This is very useful, as it allows nodes to be copied from
        # the graph and pasted into emails/chats etc, and then copied out of emails/chats and pasted into the node graph.
        #
        ## \todo I don't think this is the ideal place for this functionality. Firstly, we need it in all apps
        # rather than just the gui app. Secondly, we want a way of using the global clipboard using GafferUI
        # public functions without needing an ApplicationRoot. Thirdly, it's questionable that ApplicationRoot should
        # have a clipboard anyway - it seems like a violation of separation between the gui and non-gui libraries.
        # Perhaps we should abolish the ApplicationRoot clipboard and the ScriptNode cut/copy/paste routines, relegating
        # them all to GafferUI functionality?
        QtCore, QtGui = pipe.importQt()

        self.__clipboardContentsChangedConnection = self.root().clipboardContentsChangedSignal().connect( Gaffer.WeakMethod( self.__clipboardContentsChanged ), scoped = True )
        QtGui.QApplication.clipboard().dataChanged.connect( Gaffer.WeakMethod( self.__qtClipboardContentsChanged ) )
        self.__ignoreQtClipboardContentsChanged = False

    def __clipboardContentsChanged( self, applicationRoot ) :

        assert( applicationRoot.isSame( self.root() ) )

        data = applicationRoot.getClipboardContents()

        QtCore, QtGui = pipe.importQt()
        clipboard = QtGui.QApplication.clipboard()
        try :
            self.__ignoreQtClipboardContentsChanged = True # avoid triggering an unecessary copy back in __qtClipboardContentsChanged
            clipboard.setText( str( data ) )
        finally :
            self.__ignoreQtClipboardContentsChanged = False

    def __qtClipboardContentsChanged( self ) :

        if self.__ignoreQtClipboardContentsChanged :
            return

        QtCore, QtGui = pipe.importQt()

        text = str( QtGui.QApplication.clipboard().text() )
        if text :
            with Gaffer.BlockedConnection( self.__clipboardContentsChangedConnection ) :
                self.root().setClipboardContents( IECore.StringData( text ) )





os.environ['SAM_DISABLE_DRAG'] = '1'
os.environ['SAM_VIEWER_MODE'] = '1'
if __name__ == '__main__':
        import assetListWidget, GafferScene,GafferCortex
        # gaffer needs a script context
        script = Gaffer.ScriptNode()

        pipe.apps.gaffer()._gaffer__userSetup('gaffer')

        class mayaSceneNode(Gaffer.Node):
            pass

        Gaffer.Metadata.registerPlugValue( Gaffer.Node, "in*", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )
        Gaffer.Metadata.registerPlugValue( Gaffer.Node, "out", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )
        # Gaffer.Metadata.registerNodeValue( Gaffer.Node, "nodeGadget:color", IECore.Color3f( 0.61 ) )
        # Gaffer.Metadata.registerNodeValue( mayaSceneNode, "nodeGadget:color", IECore.Color3f( 0.61, 0.1525, 0.1525 ) )


        # script.addChild(GafferCortex.OpHolder())

        # create some nodes
        node=Gaffer.Node( 'animation_alembic_test' )
        node['file'] = Gaffer.StringPlug()
        node['file'].setValue( 'test.abc' )
        node['out']= Gaffer.Plug( direction = Gaffer.Plug.Direction.Out )
        # script.addChild( node )

        node=Gaffer.Node( 'camera_alembic_test' )
        node['file'] = Gaffer.StringPlug()
        node['file'].setValue( 'camera.abc' )
        node['out']= Gaffer.Plug( direction = Gaffer.Plug.Direction.Out )
        # script.addChild( node )

        # create a node to connect other nodes to
        node=mayaSceneNode( 'mayaScene' )
        for n in range(10):
            node['in%d' % n] = Gaffer.Plug()
        script.addChild( node )

        # connect nodes
        # script['mayaScene']['in0'].setInput( script['animation_alembic_test']['out'] )
        # script['mayaScene']['in1'].setInput( script['camera_alembic_test']['out'] )

        with GafferUI.Window('test') as window:
            with GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal ) as split:
                assetList = assetListWidget.assetListWidget( script )
                # layout =  GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal )
                nodeGraph = GafferUI.NodeGraph( script )
                GafferUI.NodeEditor( script )

        graph=nodeGraph.graphGadget()
        graph.getLayout().layoutNodes( graph )

        assetList.setNodeGraph(nodeGraph)

        def _key( widget, event ):
            import sys
            # print dir(kw[0])
            print( dir(event) )
            print( event.modifiers )
            print( event.key )
            if event.key in ["Delete","Backspace"] and not event.modifiers :
                for each in script.selection():
                    script.removeChild( each )
            sys.stdout.flush()
            return True

        nodeGraph._extraDrag = nodeGraph.graphGadgetWidget().keyPressSignal().connect( _key )
        # nodeGraph._extraDrop = nodeGraph.graphGadgetWidget().buttonPressSignal().connect( __drop )


        # model = TreeModel(populateAssets()[0])
        # view = QtGui.QTreeView(layout._qtWidget())
        # view.setModel(model)
        # view.expandToDepth(1)
        # view.resizeColumnToContents(0)
        # view.setAlternatingRowColors(True)
        # view.setColumnWidth(0,100)
        # view.setIndentation(10)
        # view.show()

        split.setSizes( ( 0.2, 0.5, 0.3 ) )

        window._qtWidget().resize( 1000, 600 )
        window.setVisible( True )

        GafferUI.EventLoop.mainEventLoop().start()

        # app = QtGui.QApplication(sys.argv)
        #

        # view = QtGui.QTreeView()
        # view.setModel(model)
        # view.setWindowTitle("Simple Tree Model")
        # view.show()
        # sys.exit(app.exec_())


IECore.registerRunTimeTyped( test )
