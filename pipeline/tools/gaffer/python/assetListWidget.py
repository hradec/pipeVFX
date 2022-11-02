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


# TODO: Add a vertical toolbar with custom buttons for generic tools and
#       project specific tools.


# python3 workaround for reload
from __future__ import print_function
try: from importlib import reload
except: pass


import os
import sys
import re
import time
import weakref
import threading

import IECore
import Gaffer
import GafferUI
import pipe

import assetUtils
import genericAsset


# backward compatibility
import imath
for c in [ x for x in dir(imath) if 'V' in x[0] or 'C' in x[0] ]:
    # print('IECore.%s=imath.%s' % (c,c))
    exec( 'IECore.%s=imath.%s' % (c,c) )

try: _long = long
except: _long = int

if assetUtils.m:
    reload(assetUtils)
    reload(genericAsset)

import bundleListWidget

# add a custom folder to search path, so we can add custom functionality
tools = [ '%s/config/assets/' % x for x in pipe.apps.gaffer().toolsPaths() ]
tools.reverse()
for tool in tools:
    if tool not in sys.path:
        sys.path.insert(0,tool)

try:
    import custom
    reload(custom)
except:
    class custom:
        pass


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
__tools__ = pipe.roots().tools()


_search = IECore.SearchPath(os.environ['GAFFERUI_IMAGE_PATHS'], ':')

def gaffer_delay( delay ) :
	endtime = time.time() + delay
	while time.time() < endtime :
		GafferUI.EventLoop.waitForIdle( 1 )

def getMayaWindow():
    """
    Get the main Maya window as a QtGui.QMainWindow instance
    @return: QtGui.QMainWindow instance of the top level Maya windows
    """
    if assetUtils.m:
        if 'pyside' in pipe.whatQt():
            import shiboken2
            import maya.OpenMayaUI as apiUI
            ptr = apiUI.MQtUtil.mainWindow()
            return shiboken2.wrapInstance(_long(ptr), QtGui.QMainWindow)
        else:
            import sip
            import maya.OpenMayaUI as mui
            ptr = mui.MQtUtil.mainWindow()
            return sip.wrapinstance(_long(ptr), QtCore.QObject)
    return None

def findMayaWindowWidgets(_hasattr, widget=getMayaWindow()):
    ret = []
    if hasattr(widget, _hasattr):
        ret += [widget]
    if hasattr(widget, 'children'):
        for obj in widget.children():
            ret += findMayaWindowWidgets(_hasattr, obj)
    return ret

def toQtObject(mayaName):
    '''
    Given the name of a Maya UI element of any type,
    return the corresponding QWidget or QAction.
    If the object does not exist, returns None
    '''
    if assetUtils.m:
        if 'pyside' in pipe.whatQt():
            import shiboken2
            import maya.OpenMayaUI as apiUI
            ptr = apiUI.MQtUtil.findControl(mayaName)
            if ptr is None:
                ptr = apiUI.MQtUtil.findLayout(mayaName)
            if ptr is None:
                ptr = apiUI.MQtUtil.findMenuItem(mayaName)
            if ptr is not None:
                return shiboken2.wrapInstance(_long(ptr), QtGui.QMainWindow)
        else:
            import sip
            import maya.OpenMayaUI as apiUI
            ptr = apiUI.MQtUtil.findControl(mayaName)
            if ptr is None:
                ptr = apiUI.MQtUtil.findLayout(mayaName)
            if ptr is None:
                ptr = apiUI.MQtUtil.findMenuItem(mayaName)
            if ptr is not None:
                return sip.wrapinstance(_long(ptr), QtCore.QObject)
    return None


def uiColumnName():
    columnName = ' '
    if assetUtils.j:
        columnName = "job/"+assetUtils.j.proj.split('.')[0] + '/' + '/'.join( assetUtils.j.shot().path().split('/')[-2:] )
    return columnName




class SAMPanel( GafferUI.Editor ):
    def __init__(self, scriptNode=None, hostApp='gaffer', onRefreshPanel=None, **kw  ):

        self.onRefreshPanel = onRefreshPanel
        self.layout = GafferUI.SplitContainer( GafferUI.ListContainer.Orientation.Horizontal )

        self.__scriptNode = scriptNode
        GafferUI.Editor.__init__(self, self.layout, self.__scriptNode, **kw )

        self.columnName = uiColumnName()

        # add new dock widget
        self.__buttons = []
        self.__buttonsSignals = []
        with self.layout:
                with GafferUI.ListContainer( GafferUI.SplitContainer.Orientation.Horizontal ):
                    self.__buttons += [1]
                    self.__buttons[-1] = GafferUI.Button( "", "samShelfPanelx20.png", toolTip="Refresh the panel from the most up-to-date data"  )
                    self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
                    self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( Gaffer.WeakMethod( self.refreshPanel ), scoped = True ) )
                    # self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( Gaffer.WeakMethod( self.refreshPanelHard ), scoped = True  ) )

                    self.__buttons += [1]
                    self.__buttons[-1] = GafferUI.Button( "", "samShelfx20.png", toolTip="Open sam browser"  )
                    self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
                    self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( Gaffer.WeakMethod( self.openSAMBrowser ), scoped = True ) )

                    GafferUI.Spacer(IECore.V2i(10,10))

                    self.__buttons += [1]
                    self.__buttons[-1] = GafferUI.Button( "", "Autodesk-open-maya-icon_20.png", toolTip="Open selected asset in the current maya session"  )
                    self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
                    self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( lambda b: self.al.mayaImportDependency(), scoped = True ) )
                    self.__buttons[-1].setEnabled(assetUtils.m != None)

                    self.__buttons += [1]
                    self.__buttons[-1] = GafferUI.Button( "", "Autodesk-maya-icon-edit_20.png", toolTip="Open selected asset in a new maya session"  )
                    self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
                    self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( lambda b: self.al.openDependency(), scoped = True ) )


                    self.__buttons += [1]
                    self.__buttons[-1] = GafferUI.Button( "", "gaffer-20.png", toolTip="Open selected asset in a new gaffer session"  )
                    self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
                    self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( lambda b: self.al.openDependency( 'gaffer' ), scoped = True ) )


                self.al = assetListWidget( self.__scriptNode, hostApp )

                # with GafferUI.ListContainer( GafferUI.SplitContainer.Orientation.Horizontal ) as filterBarIcons:
                #     types = assetUtils.types()
                #     keys = {}
                #     for t in types.keys():
                #         keys[ t.split('/')[0] ] =0
                #     keys = keys.keys()
                #     keys.sort()
                #     for t in keys:
                #         # print "assets/%s-20.png" % t
                #         self.__buttons += [1]
                #         self.__buttons[-1] = GafferUI.Button( "", "assets/%s-15.png" % t, toolTip="Show assets of type %s" % t  )
                #         self.__buttons[-1]._qtWidget().setMaximumSize( 15, 15 )
                #         self.__buttons[-1].type = t
                #         self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( Gaffer.WeakMethod( self.filter ), scoped = True  ) )
                #
                #     GafferUI.Spacer(IECore.V2i(10,1))

                with GafferUI.ListContainer( GafferUI.SplitContainer.Orientation.Horizontal ) as filterBar:
                    self.__searchString = GafferUI.TextWidget()
                    self.__buttonsSignals.append( self.__searchString.editingFinishedSignal().connect( lambda b: self.al.assetFilter( self.__searchString  ) ) )


                # make bg of filter bar black!
                filterBar._qtWidget().setStyleSheet("background-color:black;")

        self.layout._qtWidget().resize(150,100)
        self.al._qtWidget().resize(250,100)
        self._qtWidget().resize(150,100)

    def filter(self, b):
        pass
        # print b, b.type

    def refreshPanelHard(self, button):
        if self.al.hostApp() == 'maya':
            import assetListWidget;reload(assetListWidget);assetListWidget.SAMPanelUI()
        else:
            self.refreshPanel( button )

    def refreshPanel(self, button):
        import assetListWidget;reload(assetListWidget)

        t = time.time()
        # assetUtils.types(True)
        self.al.treeModelStateSave()

        if self.onRefreshPanel:
            self.onRefreshPanel(button)

        if self.al.hostApp() == 'maya':
            self.al._mayaNodeDeleted(force=True)

        self.al._model.setColumnName(self.columnName)
        print( "SAMPanel(%s).refreshPanel():" % self.al.hostApp(),time.time()-t )

    def openSAMBrowser(self, button):
        import IECore
        c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
        a = c.load( "test" )();a.run()

    def __repr__( self ) :
        return "GafferUI.SAMPanel( scriptNode )"




class assetListWidget( GafferUI.Editor ):
    __pathSelectedSignal = GafferUI.WidgetSignal()
    __selectionChangedSignal = GafferUI.WidgetSignal()
    __displayModeChangedSignal = GafferUI.WidgetSignal()
    __expansionChangedSignal = GafferUI.WidgetSignal()
    # updateFinished = GafferUI.WidgetSignal()
    __filter = ''


    def assetFilter(self, textWidget):
        self.__filter =  textWidget.getText()
        self.refresh()

    def treeModelStateSave( self ):
        if hasattr(self, '_model'):
            # only save state if NOT in a search
            if not self.__filter.strip():
                state = []
                for n in range(self._model.rowCount(QtCore.QModelIndex())):
                    index = self._model.index(n, 0, QtCore.QModelIndex())
                    state += [self._qtWidget().isExpanded(index)]
                globals()['__assetListWidget_state__'] = state


    def treeModelStateLoad( self ):
        if self.__filter.strip():
            # if in a search, open everything!
            state = [ True for x in range(self._model.rowCount(QtCore.QModelIndex())) ]
        elif '__assetListWidget_state__' in  globals():
            # restore the cached state
            state = globals()['__assetListWidget_state__']
        else:
            # if no cached state and no search, just sjow it all closed!
            state = [ False for x in range(self._model.rowCount(QtCore.QModelIndex())) ]

        for n in range(len(state)):
            if state[n]:
                index = self._model.index(n, 0, QtCore.QModelIndex())
                self._qtWidget().setExpanded( index, state[n])
                for l in range( index.internalPointer().childCount() ):
                    self._qtWidget().setExpanded(index.child(l,0), state[n])


    def setTreeModel(self):
        __populateAssets = populateAssets(self.hostApp(), self.__filter)
        t = time.time()
        # print "setTreeModel:",__populateAssets ; sys.stdout.flush()
        self._model = TreeModel(__populateAssets[0], self)
        print( "self._model = TreeModel(__populateAssets[0]):", time.time()-t, self._model ); sys.stdout.flush()
        self._qtWidget().setModel(self._model)
        # self._qtWidget().expandToDepth(0)
        self._qtWidget().setSelectionMode( QtGui.QAbstractItemView.ExtendedSelection )
        self.__selectionChangedSlot = Gaffer.WeakMethod( self.__selectionChanged, scoped = True  )
        self._qtWidget().selectionModel().selectionChanged.connect( self.__selectionChangedSlot )
        self._qtWidget().setSelectionMode( QtGui.QAbstractItemView.ExtendedSelection )

        self.treeModelStateLoad()

    def __init__(self, scriptNode=None, hostApp='gaffer', **kw):
        from GafferUI.PathListingWidget import _TreeView

        if not scriptNode:
            scriptNode = Gaffer.ScriptNode()

        __toolTip__maya__=''
        if assetUtils.m:
            __toolTip__maya__='''
                  <tr></tr>
                  <tr>
                    <td></td><td></td><td></td>
                    <td><img src='%s'></td>
                    <td>= EDIT MODE AND PRESENT IN THE SCENE - <b>This mode is only allowed for renderSettings assets.</b> It indicates the asset
                            is present in the scene as an asset, but also can publish a new version!
                           </td>
                  </tr>''' % '%s/gaffer/graphics/edit-green-20.png' % __tools__

        if True:
            __toolTip__ ='''
                <h3><u>How to Edit:</u></h3>
                    <table style="border-spacing: 15px;backgroundd : rgb(255,255,200);">
                      <tr>
                        <td></td><td></td><td></td>
                        <td><h4>   To edit an asset: </h4></td>
                        <td>Right click over the asset name or version and select any of the "Edit.." menu options.
                        <br>Double clicking on an asset name or version opens the asset in the current host app session!</td>
                      </tr>
                    </table>
                <hr><h3><u>How to Publish:</u></h3>
                    <table style="border-spacing: 15px;backgroundd : rgb(255,255,200);">
                      <tr>
                        <td></td><td></td><td></td>
                        <td><h4>   To publish a new version: </h4></td>
                        <td>Right click over the asset name (with the edit icon) and select "Publish an Update..".
                        Only assets with the EDIT icon can be published</td>
                      </tr>
                      <tr></tr>
                      <tr>
                        <td></td><td></td><td></td>
                        <td><h4>   To publish a new asset: </h4></td>
                        <td> Right click over the asset TYPE and select "Publish a new asset of type..".</td>
                      </tr>
                    </table>
                <hr><h3><u>Light Icons:</u></h3>
                    <table style="border-spacing: 15px;backgroundd : rgb(255,255,200);">
                      <tr>
                        <td></td><td></td><td></td>
                        <td><img src='%s'></td>
                        <td>= asset not present in the scene</td>
                      </tr>
                      <tr></tr>
                      <tr>
                        <td></td><td></td><td></td>
                        <td><img src='%s'></td>
                        <td>= asset present in the scene, and up-to-date</td>
                      </tr>
                      <tr></tr>
                      <tr>
                        <td></td><td></td><td></td>
                        <td><img src='%s'></td>
                        <td>= asset present in the scene, but its an older/not current version</td>
                      </tr>
                      <tr></tr>
                      <tr>
                        <td></td><td></td><td></td>
                        <td><img src='%s'></td>
                        <td>= EDIT MODE - the scene has the source nodes for publishing a new version, and NOT the actual asset.
                               \t  If this is a render scene, please make sure to remove the original nodes and import the asset!
                               </td>
                      </tr>
                      %s
                    </table>


                <hr><h3><u>Background:</u></h3>
                    <table style="border-spacing: 15px;backgroundd : rgb(255,255,200);width: 100%%">
                      <tr>
                        <td></td><td></td><td></td>
                        <td><h4 style="background:rgb(150,150,255)">blue</h4></td>
                        <td>= shot specific asset</td>
                      </tr>
                      <tr></tr>
                      <tr>
                        <td></td><td></td><td></td>
                        <td><h4 style="background:rgb(255,255,150)">yellow</h4></td>
                        <td>= same as edit icon</td>
                      </tr>
                    </table>
                    <br>
            ''' % (
                '%s/gaffer/graphics/blanklight.png'  % __tools__,
                '%s/gaffer/graphics/greenlight.png' % __tools__,
                '%s/gaffer/graphics/redlight.png' % __tools__,
                '%s/gaffer/graphics/edit-20.png' % __tools__,
                __toolTip__maya__,
            )

        self.__toolTip__ = __toolTip__ #.replace('\n','<br>')
        self._script = scriptNode
        self.hostApp(hostApp)

        # super( assetListWidget, self).__init__( _TreeView(), scriptNode, toolTip=__toolTip__, **kw )
        # super( assetListWidget, self).__init__( self._model, scriptNode, toolTip=__toolTip__, **kw )

        GafferUI.Editor.__init__( self, QtGui.QTreeView(), scriptNode, toolTip=self.__toolTip__, **kw )
        # GafferUI.Editor.__init__( self, _TreeView(), scriptNode, toolTip=self.__toolTip__, **kw )
        # GafferUI.Editor.__init__( self, _TreeView(), scriptNode, **kw )
        self._lastLS = None

        # self._model = TreeModel(populateAssets()[0])
        # self._qtWidget().setModel(self._model)
        # self._qtWidget().expandToDepth(1)

        # self.setTreeModel()
        self._mayaNodeDeleted()

        self.columnName = uiColumnName()
        self._model.setColumnName(self.columnName)

        self._qtWidget().resizeColumnToContents(0)
        self._qtWidget().setColumnWidth(0,100)
        self._qtWidget().setIndentation(10)

        self._qtWidget().setAlternatingRowColors( True )
        self._qtWidget().setUniformRowHeights( True )
        self._qtWidget().setEditTriggers( QtGui.QTreeView.NoEditTriggers )
        self._qtWidget().activated.connect( Gaffer.WeakMethod( self.__activated ) )
        if 'pyqt' in pipe.whatQt():
            self._qtWidget().header().setMovable( False )
        self._qtWidget().header().setSortIndicator( 0, QtCore.Qt.AscendingOrder )
        self._qtWidget().setSortingEnabled( True )
        self._qtWidget().setExpandsOnDoubleClick( False )


        # self.__pathSelectedSignal = GafferUI.WidgetSignal()
        # self.__selectionChangedSignal = GafferUI.WidgetSignal()
        # self.__displayModeChangedSignal = GafferUI.WidgetSignal()
        # self.__expansionChangedSignal = GafferUI.WidgetSignal()

        # members for implementing drag and drop
        self.__emittingButtonPress = False
        self.__borrowedButtonPress = None
        self.__doubleClick = self.buttonDoubleClickSignal().connect( Gaffer.WeakMethod( self.__buttonDoubleClick ), scoped = True  )
        self.__buttonPressConnection = self.buttonPressSignal().connect( Gaffer.WeakMethod( self.__buttonPress ), scoped = True  )
        self.__buttonReleaseConnection = self.buttonReleaseSignal().connect( Gaffer.WeakMethod( self.__buttonRelease ), scoped = True  )
        self.__mouseMoveConnection = self.mouseMoveSignal().connect( Gaffer.WeakMethod( self.__mouseMove ), scoped = True  )
        if 'SAM_DISABLE_DRAG' not in os.environ:
            self.__dragBeginConnection = self.dragBeginSignal().connect( Gaffer.WeakMethod( self.__dragBegin ), scoped = True  )
            self.__dragEndConnection = self.dragEndSignal().connect( Gaffer.WeakMethod( self.__dragEnd ), scoped = True  )
            self.__dragEnterConnection = self.dragEnterSignal().connect( Gaffer.WeakMethod( self.__dragEnter ), scoped = True  )
            self.__dragPointer = "paths"

        self.__contextMenuConnection = self.contextMenuSignal().connect( Gaffer.WeakMethod( self.__contextMenu ), scoped = True  )

        # self.__dragEnterConnection = self.dragEnterSignal().connect( Gaffer.WeakMethod( self.__dragEnter ), scoped = True  )

        self.__path = None
        self._nodeGraph = None
        self._script = scriptNode


        self.timer = QtCore.QTimer()
        def forceRefresh():
            # import threading
            # threading.Thread( target = ).start()
            self._mayaNodeDeleted(force=True)
            self.timer.singleShot( 60*1000,forceRefresh)

        # self.timer.singleShot( 60*1000,forceRefresh)
        if 'pyqt' in pipe.whatQt():
            self._qtWidget().connect(self._qtWidget(), QtCore.SIGNAL("selectionChangedSignal(PyQt_PyObject)"), self.handleValue)
        # bundleListWidget.bundleListWidget._selectionChangedSignal().connect( Gaffer.WeakMethod( self.handleValue ), scoped = True  )

        # genericAsset.updateCurrentLoadedAssets(True)
        genericAsset.updateCurrentLoadedAssets()

    def __buttonDoubleClick(self, *args):
        # import time
        selectedData = self.getSelectedColumns()
        selectedPaths = selectedData['assetFullPath']
        selectedPathsOP = selectedData['assetOP']

        # setExpanded(const QModelIndex & index, bool expanded)

        # if selectedPathsOP[0]:
        #     # selectedPathsExistInHost = selectedData['assetOPSourceExistsInHost']
        #     if self.hostApp()=='maya':
        #         if 'maya' in selectedPathsOP[0].whoCanOpen() and os.path.splitext(selectedPathsOP[0].assetDependencyFilename())[-1] in ['.ma','.mb']:
        #             self.openDependency('maya', selectedPaths)
        #
        #     if self.hostApp()=='gaffer' or self.hostApp()=='maya':
        #         if 'gaffer' in selectedPathsOP[0].whoCanOpen() and '.gfr' in selectedPathsOP[0].assetDependencyFilename()[-5:]:
        #             self.openDependency('gaffer', selectedPaths)
        # else:
        # t = time.time()
        for index in self._qtWidget().selectionModel().selectedRows():
            expanded = self._qtWidget().isExpanded(index)
            self._qtWidget().setExpanded(index, not expanded)
            for n in range( index.internalPointer().childCount() ):
                self._qtWidget().setExpanded(index.child(n,0), not expanded)

        # print 'SAMPanel->doublClickShowAssets:', time.time()-t



    def handleValue(self, kk):
        pass
        # print kk
        # sys.stdout.flush()


    def refresh( self , lastLS=None):
        self.setTreeModel()
        if self._lastLS != lastLS:
            self._lastLS = lastLS

        # update the treeview node list so it updates each asset status!
        self._model.refresh(self._lastLS)

    def _mayaNodeDeleted(self, force=False):
        ls=[]
        self.treeModelStateSave()
        if assetUtils.m:
            ls = assetUtils.m.ls("|*")
            # this accounts for <f4> expression in ribArchiveNodes, for prman 21.n.
            if pipe.isEnable('prman'):
                assetUtils.m.setAttr('defaultRenderGlobals.preMel', 'python("import fixPrmanArchiveSequence;reload(fixPrmanArchiveSequence);fixPrmanArchiveSequence.fix()")', type="string")
                assetUtils.m.setAttr('defaultRenderGlobals.preRenderMel', 'python("import fixPrmanArchiveSequence;reload(fixPrmanArchiveSequence);fixPrmanArchiveSequence.fix()")', type="string")
                assetUtils.m.setAttr('defaultRenderGlobals.preRenderLayerMel', 'python("import fixPrmanArchiveSequence;reload(fixPrmanArchiveSequence);fixPrmanArchiveSequence.fix()")', type="string")

        if ls != self._lastLS or force:
            self.refresh(ls)

        def __SAM_assetList_mayaNodeDeleted__(forceRefresh=False):
            genericAsset.updateCurrentLoadedAssets()
            self._mayaNodeDeleted(forceRefresh)

        assetUtils.mayaLazyScriptJob( runOnce=False,  deleteEvent=__SAM_assetList_mayaNodeDeleted__ )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['DagObjectCreated',lambda: __SAM_assetList_mayaNodeDeleted__()] )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['NameChanged',lambda: __SAM_assetList_mayaNodeDeleted__()] )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['deleteAll',lambda: __SAM_assetList_mayaNodeDeleted__()] )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['NewSceneOpened',lambda: __SAM_assetList_mayaNodeDeleted__(True)] )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['SceneOpened',lambda: __SAM_assetList_mayaNodeDeleted__(True)] )

        # def __SAM_assetList_mayaSelectSam__():
        #     print m.ls(sl=1)
        # assetUtils.mayaLazyScriptJob( runOnce=False,  event=['SomethingSelected',__SAM_assetList_mayaSelectSam__] )

    def hostApp(self, hostAppName=None):
        if hostAppName:
            self.__hostApp = hostAppName
        else:
            return self.__hostApp

    def __contextMenu( self, pathListing ) :
        return self._menu(pathListing)

    def _menu(self, pathListing):
        # asset=0
        # assetData=1
        # assetFullPath=2
        # assetOP=3
        # assetOPSourceExistsInHost=4

        menuDefinition = IECore.MenuDefinition()
        selectedData = pathListing.getSelectedColumns()
        selectedPaths = selectedData['assetFullPath']
        selectedPathsOP = selectedData['assetOP']
        selectedPathsExistInHost = selectedData['assetOPSourceExistsInHost']
        selectedPathsEditable = [ x for x in selectedData['assetEditable'] if x ]

        # if selection exists in host app
        selected_source_exists_in_host = False if [ x for x in selectedPathsExistInHost if x ] else True

        # if selection is asset names or versions, its an assetMenu
        isAssetMenu = [ x for x in selectedPaths if len(x.split('/'))>2 ]

        # if selection is type and data type, the menu is a publishe NEW menu!
        isPublishMenu = [ x for x in selectedPaths if len(x.split('/'))<=2 ]

        # asset menu!
        if isAssetMenu:
            # if selection is "importable" in the current app
            selected_canImport  = True #if [ x for x in selectedPathsOP if x.canImport() ] else False

            # canImport = not selectedPathsEditable and selected_canImport #selected_source_exists_in_host and selected_canImport
            canImport = True

            # renderSettings can ALLWAYS be imported, even if they are publishable as well!
            if len(selectedPaths)==1:
                if 'renderSettings/' in selectedPaths[0]:
                    canImport = True
                if 'render/' in selectedPaths[0]:
                    canImport = False

                menuDefinition.append( "/import or update selected" , { "command" : IECore.curry(self.checkout, selectedPaths), "active" : canImport  } )

                # add the publish menu, if the item can be published
                if selectedPathsEditable or 'render/maya' in selectedPaths[0]:
                    menuDefinition.append( "/Publish an UPDATE to the selected asset" , { "command" : IECore.curry(self.publishAssetUpdate, selectedPaths) }) #, "active" : not selected_source_exists_in_host  } )


        # updateall
        menuDefinition.append( "/d2" , {"divider":True } )
        menuDefinition.append( "/update all assets", { "command" :  IECore.curry( self.updateAllAssetsInScene) } )
        menuDefinition.append( "/d3" , {"divider":True } )

        # asset menu!
        if isAssetMenu:
            # if only one asset is selected, we can add some more menu itens
            if len(selectedPaths)==1:

                # if the asset is publishable in maya add the edit in maya menus
                # we do an extra check if the extension of the dependency files is a .ma/.mb to garantee its a maya scene!
                if 'maya' in selectedPathsOP[0].whoCanPublish() and os.path.splitext(selectedPathsOP[0].assetDependencyFilename())[-1] in ['.ma','.mb']:
                    if self.hostApp() == 'maya':
                        menuDefinition.append( "/edit original scene in this maya session " , { "command" : IECore.curry(self.mayaImportDependency, selectedPaths) } )
                    menuDefinition.append( "/edit original scene in a new maya session " , { "command" : IECore.curry(self.openDependency, 'maya', selectedPaths) } )

                # if the asset is publishable in gaffer add the edit in gaffer menus
                # also check if dependency extension is '.gfr'!
                if 'gaffer' in selectedPathsOP[0].whoCanPublish() and '.gfr' in selectedPathsOP[0].assetDependencyFilename()[-5:]:
                    menuDefinition.append( "/edit original scene in gaffer " , { "command" : IECore.curry(self.openDependency, 'gaffer', selectedPaths) } )

        # publish NEW menu only shows if only one is selected!
        if isPublishMenu and len(selectedPaths)==1:
            # we need the asset types and data types to show menus to publish for
            types = assetUtils.types()
            selected_type = selectedPaths[0].split('/')[0]

            # menu callback which opens the opa dialog for the selected asset type/data type
            def createNewAsset(paths, assetType):
                with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
                    op = assetUtils.assetOP( assetType, self.hostApp() )
                    op.newPublish()

            # create a menu item for each data type of the selected type!
            for t in [ x for x in list(types.keys()) if selected_type in x.split('/') ]:
                if self.hostApp() in types.whoCanPublish(t):
                # if [ x for x in publishable_data if '/%s' % x in t ]:
                    menuDefinition.append( "/publish new asset of type %s" % t.replace('/','_'), { "command" : IECore.curry(createNewAsset, selectedPaths, t) } )



        if hasattr( custom, 'assetListRightClickMenu' ):
            menuDefinition = custom.assetListRightClickMenu( self, pathListing, menuDefinition )

        self.__menu = GafferUI.Menu( menuDefinition )
        if len( menuDefinition.items() ) :
        	self.__menu.popup( parent = pathListing.ancestor( GafferUI.Window ) )

        return True

    def checkout( self, paths = None ):
        ''' import an asset to the host app '''
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            if not paths:
                paths = self.getSelectedColumns()['assetFullPath']
            def __SAM_assetList_doImport__():
                import genericAsset
                pb = genericAsset.progressBar( len(paths)+1, "Importing assets..." )
                for path in paths:
                    pb.step()
                    # print path
                    op = assetUtils.assetOP( path , self.hostApp() )
                    op.doImport( )

                pb.step()
                pb.close()

                if hasattr( custom, 'assetListAssetImport' ):
                    custom.assetListAssetImport(  )
                # print op, path
            __SAM_assetList_doImport__()
            # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_doImport__)

        if self.hostApp() == 'maya':
            assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=lambda: self._mayaNodeDeleted())
        else:
            self._mayaNodeDeleted()

    def updateAllAssetsInScene(self):
        ''' update all assets in the host app'''
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            nodes = []
            if self.hostApp() == 'maya':
                nodes = assetUtils.m.ls('|SAM_*')
            pb = genericAsset.progressBar( len(nodes)+1, "Updating all assets in scene..." )
            for n in nodes:
                pb.step()
                if not checkIfNodeIsUpToDate(n):
                    n = n.split('_')
                    path = '%s/%s/%s' % (n[1], n[2], '_'.join(n[3:-4]))
                    op = assetUtils.assetOP( path, self.hostApp() )
                    # print '%s/%s/%s' % (n[1], n[2], '_'.join(n[3:-4])), op.path, op.data
                    op.doImport()
                    # run custom code, if any!

            if hasattr( custom, 'assetListAssetImport' ):
                custom.assetListAssetImport(  )
            pb.step()
            pb.close()

        if self.hostApp() == 'maya':
            assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=lambda: self._mayaNodeDeleted())
        else:
            self._mayaNodeDeleted()

    def publishAssetUpdate(self, asset = None):
        ''' publishs an updated version to an asset that already exists
        '''
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            if not asset:
                asset = self.getSelectedColumns()['assetFullPath']
            op = assetUtils.assetOP( asset[0], self.hostApp() )
            op.updatePublish()

        if self.hostApp() == 'maya':
            assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=lambda: self._mayaNodeDeleted())
        else:
            self._mayaNodeDeleted()

    def mayaImportDependency(self, paths = None):
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            icon = '%s/gaffer/graphics/Autodesk-maya-icon_48.jpg' % __tools__
            if not paths:
                paths = self.getSelectedColumns()['assetFullPath']

            if not paths or len(paths[0].split('/'))<=2:
                raise Exception( "You first need to select an asset!" )
            else:
                paths=[paths[0]]

            msg = '''
                Click OK to edit the asset <p style="color:rgb(100,255,100)">%s</p> in the current maya session.

                <p style="color:rgb(255,100,100)">Please be carefull since the current scene will NOT BE SAVED!!</p>
            ''' % paths[0]

            def __SAM_assetList_mayaImportDependency__():
                for path in paths:
                    # print path
                    op = assetUtils.assetOP( path, self.hostApp() )
                    op.mayaImportDependency( )
            # if assetUtils.m:
            #     assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_mayaImportDependency__)
            # else:
            html = '''
                <body>
                <table style="border-spacing: 15px;text-align: center;">
                  <tr>
                    <td align="center"><h3>%s</h3></td>
                    <td><h3>  </h3></td>
                    <td><h3>  </h3></td>
                    <td><h3>  </h3></td>
                    <td rowspan="4"> <img src='%s'></td>
                  </tr>
                </table>
                </body>
            '''
            msg = html % ( '<br>'.join([ x.strip() for x in msg.split('\n')]), icon )

            if GafferUI.ConfirmationDialogue( "SAM", msg ).waitForConfirmation():
                __SAM_assetList_mayaImportDependency__()

        self.refreshPanel()

    def openDependency(self, app='maya', paths = None):
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            icon = _search.find('Autodesk-maya-icon_48.jpg')
            if app=='gaffer':
                icon = _search.find('GafferLogoMini.png')
            if not paths:
                paths = self.getSelectedColumns()['assetFullPath']
            verde = '100,255,100'
            msg = '''
                Click OK to open one %s session for each of the assets below:
                <p style="color:rgb(100,255,100)">%s</p>
            ''' % ( app, '\n\t'.join([ '%s </p> <p style="color:rgb(255,255,100)">job: %s\n%s: %s' % tuple([x]+assetUtils.assetOP(x).getJobShot()['path'].split('jobs/')[1].split('/')[:3])  for x in paths if len(x.split('/'))>2 ]),  )

            if not paths or not [ x for x in paths if len(x.split('/'))>2 ]:
                paths=['']
                msg = '''
                    <p style="color:rgb(100,255,100)">Click OK to continue opening a new CLEAN %s session.</p>

                    To EDIT an asset in a new maya session, select the asset first!
                ''' % app
            def __SAM_assetList_mayaOpenDependency__():
                for path in paths:
                    # print path
                    op = assetUtils.assetOP( path, self.hostApp() )
                    if app=='maya':
                        op.mayaOpenDependency( )
                    elif app=='gaffer':
                        op.gafferOpenDependency( )
            # if assetUtils.m:
            #     assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_mayaOpenDependency__)
            # else:
            html = '''
                <body>
                <table style="border-spacing: 15px;">
                  <tr>
                    <td><h3>%s</h3></td>
                    <td><h3>  </h3></td>
                    <td><h3>  </h3></td>
                    <td><h3>  </h3></td>
                    <td rowspan="4"> <img src='%s'></td>
                  </tr>
                </table>
                </body>
            '''

            msg = html % ( '<br>'.join([ x.strip() for x in msg.split('\n')]), icon )
            if self.hostApp()=='maya' and app=='maya':
                if GafferUI.ConfirmationDialogue( "SAM", msg ).waitForConfirmation():
                    __SAM_assetList_mayaOpenDependency__()
            else:
                __SAM_assetList_mayaOpenDependency__()

    def getTitle(self):
        return 'SAM Asset List'

    def __repr__( self ) :
        return "GafferUI.SAMAssetListWidget( scriptNode )"

    def setNodeGraph(self, nodeGraph):
        self._nodeGraph = nodeGraph

    def setScript(self, script):
        self._script = script

    def getSelectedPaths( self ) :
        selectedRows = self._qtWidget().selectionModel().selectedRows()
        # print [ index.internalPointer().data(TreeItem.assetFullPath) for index in selectedRows ]
        return [ index.internalPointer().data(TreeItem.assetFullPath) for index in selectedRows ]

    def getSelectedColumns( self ) :
        selectedRows = self._qtWidget().selectionModel().selectedRows()
        # print selectedRows
        ret = {}
        for column in [ x for x in dir(TreeItem) if 'asset' in x ]:
            ret[column] = []
            for index in selectedRows:
                ret[column] += [index.internalPointer().data(eval('TreeItem.%s' % column))]
        # print ret
        return ret

    def __selectionChanged( self, selected, deselected ) :
        # print selected, deselected;sys.stdout.flush()
        self.selectionChangedSignal()( self )
        return True

    def selectionChangedSignal( self ) :
        # print 'selectionChangedSignal', os.environ['SAM_VIEWER_MODE']
        if 'SAM_VIEWER_MODE' in os.environ:
            import Asset
            import glob
            import GafferScene, GafferSceneUI, GafferImage
            selectedData = self.getSelectedColumns()

            def frameRange(data):
                if data:
                    fr = data['assetClass']['FrameRange']['range'].value
                    start = int( fr.x )
                    end = int( fr.y )
                    self._script.context().setFrame( start )
                    self._script["frameRange"]["start"].setValue( start )
                    self._script["frameRange"]["end"].setValue( end )
                    GafferUI.Playback.acquire( self._script.context() ).setFrameRange( start, end )

            # delete previous preview nodes
            for each in [ x for x in list(self._script.keys()) if x[0:2] == '__' ]:
                del self._script[each]

            # grab the viewer from gaffer
            scriptWindow = GafferUI.ScriptWindow.acquire( self._script )
            viewer = scriptWindow.getLayout().editors( GafferUI.Viewer )[0]

            # now we create the nodes needed to display the selection
            # group node in case we have mode than one geometry node selected
            group = GafferScene.Group()
            if "group" in self._script:
                del self._script["group"]
            self._script["group"] = group
            # the set is used to assign the node to the viewer!
            # (the same as clinking on the target icon at the right-top
            # corner of the node in gaffer!)
            gset = Gaffer.StandardSet()
            count = 0
            for assetFullPath in selectedData['assetFullPath']:
                data = Asset.AssetParameter( assetUtils.j.path('sam/')+str(assetFullPath) ).getData()

                # we have a path in data, so we can continue
                if data and 'path' in data:
                    path = data['path']
                if not data or not os.path.exists(data['path']):
                    path = assetUtils.j.path('sam/')+str(assetFullPath)
                    if not data:
                        versions = glob.glob("%s/*" % path)
                        versions.sort()
                        if versions:
                            path = versions[-1]

                # print( path, assetFullPath )
                # gather alembic / USD files
                abc  = glob.glob("%s/*.abc" % path)
                abc += glob.glob("%s/*.usd" % path)
                # gather images
                images = glob.glob("%s/images/*.exr" % path)

                # a node name convention so we can delete it when the selection changes.
                nodePrefix = str(assetFullPath).replace('/','_').replace('.','_').replace('-','_').replace('-','_')

                # alembic/USD geometry
                # print( abc, images )
                if abc:
                    GafferScene.MergeScenes
                    for each in abc:
                        node = "__sceneReader%s%02d" % (nodePrefix, count)
                        self._script[node] = GafferScene.SceneReader()
                        self._script[node]["fileName"].setValue( each )
                        group["in"][count].setInput( self._script[node]["out"] )
                        count += 1
                        gset.add( group )
                        frameRange( data )

                # images!
                elif images:
                    # aovs = list(set([ os.path.splitext(os.path.splitext(x)[0])[0] for x in images ]))
                    aovs = list(set([ x[:-8] for x in images ]))
                    if aovs:
                        frameRange( data )
                        nodes = 0
                        for each in [aovs[0]]:
                            # print( each )
                            node = "__imageReader%s%02d" % (nodePrefix, nodes)
                            self._script[node] = GafferImage.ImageReader()
                            self._script[node]["fileName"].setValue( each+'####.exr' )
                            nodes += 1
                            gset.add( self._script[node] )
                            frameRange( data )
                else:
                    os.system("ls -lh %s/*" % path)

            if gset.size():
                # add the nodes created in the loop above to the viewer
                # (the same as clinking on the target icon at the right-top
                # corner of the node in gaffer!)
                viewer.setNodeSet( gset )
                view = viewer.view()
                viewport = view.viewportGadget()

                # we need to wait for the viewport to be properly set after adding the set.
                viewport_primary_child = viewport.getPrimaryChild()
                if hasattr(viewport_primary_child, 'waitForCompletion'):
                    viewport_primary_child.waitForCompletion()

                # now we can grab the boundingbox from the viewport, so we can "f" frame the viewer
                viewport.frame( viewport.getPrimaryChild().bound() )
                if hasattr(view, 'expandSelection'):
                    view["minimumExpansionDepth"].setValue( 999 )
                    # print (dir(view))
                    # def setSelection( paths ) :
			        #     GafferSceneUI.ContextAlgo.setSelectedPaths( view.getContext(), IECore.PathMatcher( paths ) )
                    # setSelection('/')
                    # view.expandSelection( depth = 100000000 )
                    # setSelection('')

                # print self._script.keys()
                # print [ x for x in self._script.keys() if x[0:2] == '__' ]

            # with row :
            #     if abc:
            #         try:
            #             # class SceneReaderPathPreview( GafferSceneUI.SceneReaderPathPreview ) :
            #             def frameRange(self, start, end):
            #                 start = int(start)
            #                 end = int(end)
            #                 self._script.context().setFrame( start )
            #                 self._script["frameRange"]["start"].setValue( start )
            #                 self._script["frameRange"]["end"].setValue( end )
            #                 GafferUI.Playback.acquire( self._script.context() ).setFrameRange( start, end )
            #
            #             # scene = SceneReaderPathPreview( Gaffer.FileSystemPath( abc[0] ) )
            #             fr = data['assetClass']['FrameRange']['range'].value
            #             scene.frameRange( fr.x, fr.y )
            #             txt=GafferUI.Label(  "Previewing: %s" % abc[0] )
            #             txt._qtWidget().setMaximumSize( 1100, 10 )
            #         except:
            #             GafferUI.Label( "<img src='%s/preview.jpg'>" % str(data['publishPath']) )
            #             del row[0]
            #     else:
            #         GafferUI.Label( "<img src='%s/gaffer/graphics/samNoFiles.png' width=%s height=%s>" % (pipe.roots.tools(), 800, 600)  )
            sys.stdout.flush()


        if assetUtils.m:
            # assetUtils.m.select(cl=1)
            selectedData = self.getSelectedColumns()

            # print selectedData
            for n in range( len( selectedData['assetFullPath'] ) ):
                path, op = selectedData['assetFullPath'][n], selectedData['assetOP'][n]
                # op = assetUtils.assetOP( path, self.hostApp() )
                # print path
                if not op:
                    op = assetUtils.assetOP( path, self.hostApp() )
                if op:
                    nodes = op.assetSourceExistsInHost()
                    # print "===>",path,op, nodes,self.hostApp()
                    if self.hostApp()=='maya' and nodes:
                        if assetUtils.m and assetUtils.m.ls(nodes):
                            assetUtils.m.select(nodes)
                    else:
                        op.selectNodes()
                # self.refresh(op.mayaLastLs())


        return self.__selectionChangedSignal

    def __pathForIndex( self, modelIndex ) :
        ret = self.___pathForIndex( modelIndex )
        # print ret
        return ret

    def ___pathForIndex( self, modelIndex ) :
        if type( modelIndex ) == list :
            return [ Gaffer.Path( index.internalPointer().data(TreeItem.assetFullPath) ) for index in modelIndex ]
        else:
            return Gaffer.Path( modelIndex.internalPointer().data(TreeItem.assetFullPath) )

    def __activated( self, modelIndex ) :

        activatedPath = self.__pathForIndex( modelIndex )

        self.__path = activatedPath
        if type( activatedPath ) == list :
            self.__path[:] = activatedPath[:]

        if activatedPath.isLeaf() :
            self.pathSelectedSignal()( self )
            return True

        return False

    ## This signal is emitted when the user double clicks on a leaf path.
    def pathSelectedSignal( self ) :
        print( 'pathSelectedSignal' );sys.stdout.flush()
        return self.__pathSelectedSignal

    def __buttonPress( self, widget, event ) :

        if self.__emittingButtonPress :
            return False

        self.__borrowedButtonPress = None
        if event.buttons == event.Buttons.Left and event.modifiers == event.Modifiers.None_ :

            # We want to implement drag and drop of the selected items, which means borrowing
            # mouse press events that the QTreeView needs to perform selection and expansion.
            # This makes things a little tricky. There are are two cases :
            #
            #  1) There is an existing selection, and it's been clicked on. We borrow the event
            #     so we can get a dragBeginSignal(), and to prevent the QTreeView reducing a current
            #     multi-selection down to the single clicked item. If a drag doesn't materialise we'll
            #     re-emit the event straight to the QTreeView in __buttonRelease so the QTreeView can
            #     do its thing.
            #
            #  2) There is no existing selection. We pass the event to the QTreeView
            #     to see if it will select something which we can subsequently drag.
            #
            # This is further complicated by the fact that the button presses we simulate for Qt
            # will end up back in this function, so we have to be careful to ignore those.

            index = self._qtWidget().indexAt( QtCore.QPoint( event.line.p0.x, event.line.p0.y ) )
            if self._qtWidget().selectionModel().isSelected( index ) :
                # case 1 : existing selection.
                self.__borrowedButtonPress = event
                return True
            else :
                # case 2 : no existing selection.
                # allow qt to update the selection first.
                self.__emitButtonPress( event )
                # we must always return True to prevent the event getting passed
                # to the QTreeView again, and so we get a chance to start a drag.
                return True

        return False

    def __buttonRelease( self, widget, event ) :

        if self.__borrowedButtonPress is not None :
            self.__emitButtonPress( self.__borrowedButtonPress )
            self.__borrowedButtonPress = None

        return False

    def __mouseMove( self, widget, event ) :
        # print '__mouseMove'
        # print dir(widget)
        # print event.line

        if event.buttons :
            # take the event so that the underlying QTreeView doesn't
            # try to do drag-selection, which would ruin our own upcoming drag.
            return True

        return False


    def _nodeGraph_currentFrame( self ) :
        ''' return the current framing of the gaffer nodegraph, so we can change it! '''
        self.nodeGraph = GafferUI.NodeGraph.acquire( self._script )
        viewportGadget = self.nodeGraph.graphGadgetWidget().getViewportGadget()

        rasterMin = viewportGadget.rasterToWorldSpace( imath.V2f( 0 ) ).p0
        rasterMax = viewportGadget.rasterToWorldSpace( imath.V2f( viewportGadget.getViewport() ) ).p0

        frame = imath.Box2f()
        frame.extendBy( imath.V2f( rasterMin[0], rasterMin[1] ) )
        frame.extendBy( imath.V2f( rasterMax[0], rasterMax[1] ) )
        return frame

    def _saveNodeGraphFrame(self):
        ''' since gaffer does a frame() when a node is dropped, we save the frame.bound()
        here so we can restore it in the drop event! '''

        pass
        self.cb = self._nodeGraph_currentFrame()
        min = self.cb.min()
        max = self.cb.max()
        self.__box = imath.Box3f()
        self.__box.extendBy( imath.Box3f( imath.V3f( min.x, min.y, 0 ), imath.V3f( max.x, max.y, 0 ) ) )

    def _restoreNodeGraphFrame(self):
        ''' restore nodegraph saved frame.bound '''
        self.nodeGraph.graphGadgetWidget().getViewportGadget().frame( self.__box )

    def __dragBegin( self, widget, event ) :
        # print '__dragBegin'
        # print widget
        # print event.destinationGadget
        # print dir(event)
        # print event.line
        self._saveNodeGraphFrame()

        self.__borrowedButtonPress = None
        selectedData = self.getSelectedColumns()
        selectedPaths = selectedData['assetFullPath']
        selectedPathsOP = selectedData['assetOP']
        selectedPathsExistInHost = selectedData['assetOPSourceExistsInHost']

        if len( selectedPaths ) :
            GafferUI.Pointer.setCurrent( self.__dragPointer )
            s = Gaffer.ScriptNode()
            # print selectedPaths
            for each in  selectedPaths:
                # print each
                asset = each
                each = each.replace('.','__')
                node =  Gaffer.Node( '_'.join(each.split('/')) )
                node['in']= Gaffer.ArrayPlug(  "in", )
                node['out']= Gaffer.Plug( "out", direction = Gaffer.Plug.Direction.Out)
                node['__mapping']= Gaffer.ObjectPlug( "__mapping", direction = Gaffer.Plug.Direction.Out, defaultValue = IECore.CompoundObject(), )
                node._name ='_'.join(each.split('/')[:-1])
                node["asset"] = Gaffer.StringPlug()
                node["asset"].setValue( asset )
                s.addChild(node)
            return s


            return IECore.StringVectorData(
                [ str( p ) for p in selectedPaths ],
            )
        return None


    def __dragEnter( self, widget, event ) :
        pass
        # print '__dragEnter'
        # print widget
        # print dir(event)
        # print event.line
        # print widget, event.destinationWidget
        # if  event.destinationWidget:
        #     nodeGraph = event.destinationWidget.ancestor(GafferUI.NodeGraph)
        #     assert( nodeGraph is not None )
        #     gadgetWidget = nodeGraph.graphGadgetWidget()
        #     graphGadget = nodeGraph.graphGadget()
        #     script = nodeGraph.scriptNode()
        #     cb = nodeGraph._NodeGraph__currentFrame()
        #     self.box = IECore.Box3f()
        #     self.box.extendBy( IECore.Box3f( IECore.V3f( cb.min.x, cb.min.y, 0 ), IECore.V3f( cb.max.x, cb.max.y, 0 ) ) )
        #
        #
        # sys.stdout.flush()


    def __dragEnd( self, widget, event ) :
        import sys
        # print '__dragEnd2'
        # print widget
        # print event.destinationGadget
        # print dir(event)
        # print type(event.line),event.line
        # print event.destinationWidget.__class__

        # if in maya, just do the same as the import menu
        if self.hostApp() == 'maya':
            selectedData = self.getSelectedColumns()
            selectedPaths = selectedData['assetFullPath']
            # self.checkout( selectedPaths )

        # if in gaffer, we create sam nodes!
        elif self.hostApp() == 'gaffer':

            # we have to restore the original framing of the nodegraph, since its default is to frame the nodes in the scene
            self._restoreNodeGraphFrame()

            def dropNodes():
                if  event.destinationWidget:
                    nodeGraph = event.destinationWidget.ancestor(GafferUI.NodeGraph)
                    if nodeGraph:
                        import GafferScene
                        import nodes
                        assert( nodeGraph is not None )
                        gadgetWidget = nodeGraph.graphGadgetWidget()
                        graphGadget = nodeGraph.graphGadget()
                        script = nodeGraph.scriptNode()

                        # print dir(nodeGraph)
                        _nodez = []
                        for _node in event.data.children():
                            if type(_node) == Gaffer.Node:
                                asset = _node['asset'].getValue()
                                # asset = asset.replace('-','_')
                                tmp = asset.split('/')
                                tmp[2] = tmp[2].split('.')[-1]

                                node = eval( 'nodes.SAM%s%s( "%s" )' % (tmp[0], tmp[1].capitalize(), '_'.join([tmp[0]]+tmp[2:-1]) ) )

                                # set asset path and override mask
                                assetStr = os.path.dirname(asset)
                                assetOvrMsk = assetStr.replace('model','[animation|model]')
                                assetOvrMsk = r"%s[\/.*\.|\/]%s" % ( os.path.dirname(assetOvrMsk), os.path.basename(assetStr) )

                                node["asset"].setValue( assetStr )
                                # node["name"].setValue( assetStr.replace('/','|') )
                                node["overrideAssetMask"].setValue( assetOvrMsk )

                                _nodez += [node]
                                # add the shader node if its a model/animation node
                                # todo: find a way to show a warning error if the created shader node asset doesn't exists!
                                node2 = None
                                # if tmp[0] in ['model', 'animation']:
                                #     node2 = eval( 'nodes.SAMshadersMaya( "%s" )' % ('_'.join(['shaders']+tmp[2:-1])) )
                                #     node2["asset"].setValue( "shaders/maya/%s" % node["asset"].getValue().split('/')[-1] )
                                #     node['in'].setInput( node2["out"] )
                                #     _nodez += [node2]


                        with Gaffer.UndoContext( script ) :
                            for node in _nodez:
                                # add it to the nodeGraph

                                if node.parent() is None :
                                    graphGadget.getRoot().addChild( node )


                                menuPosition = self.mousePosition( gadgetWidget )
                                fallbackPosition = gadgetWidget.getViewportGadget().rasterToGadgetSpace(
                    				IECore.V2f( menuPosition.x, menuPosition.y ),
                    				gadget = graphGadget
                    			).p0

                                graphGadget.getLayout().positionNode( graphGadget, node, IECore.V2f( fallbackPosition.x, fallbackPosition.y ) )
                                # graphGadget.setNodePosition( node, IECore.V2f( fallbackPosition.x, fallbackPosition.y ))

                                graphGadget.getLayout().connectNode( graphGadget, node, script.selection() )


                                # force the compute method to run
                                # so the node can show a error icon if theres a problem
                                try:
                                    node['out'].getValue()
                                except:pass

                            script.selection().clear()
                            for n in _nodez:
                                script.selection().add( n )
                            nodeGraph.frame( _nodez, extend = True )
            dropNodes()



        # self.__viewportGadget.dragEndSignal()( self.__viewportGadget, event )


        # if self._nodeGraph:
        #     graph = self._nodeGraph.graphGadget()
        #     graph.getLayout().layoutNodes( graph )
        GafferUI.Pointer.setCurrent( None )

    def __emitButtonPress( self, event ) :
        ''' when we click on the treeview, this method is called and it's responsible
        for emitting a mouseMovent to the widget. This allows for us to intercept
        the mouse coordinates and correct the y position, since pulling the y from
        the event in QT5 is coming with an offset of 27. '''
        qEvent = QtGui.QMouseEvent(
            QtCore.QEvent.MouseButtonPress,
            QtCore.QPoint( event.line.p0.x, event.line.p0.y-27 ),
            QtCore.Qt.LeftButton,
            QtCore.Qt.LeftButton,
            QtCore.Qt.NoModifier
        )

        try :
            self.__emittingButtonPress = True
            # really i think we should be using QApplication::sendEvent()
            # here, but it doesn't seem to be working. it works with the qObject
            # in the Widget event filter, but for some reason that differs from
            # Widget._owner( qObject )._qtWidget() which is what we have here.
            self._qtWidget().mousePressEvent( qEvent )
        finally :
            self.__emittingButtonPress = False





def checkIfNodeIsUpToDate( node ):
    from glob import glob
    p = node.strip().replace('-','_').split('_')
    path = assetUtils.assetOP._fixShotPath( "%s/%s/%s" % ( p[1], p[2], '_'.join(p[3:-4]) ) )
    if '/sam/' not in path:
        path = pipe.admin.job().path('sam/')+path
    f = path+'/current'
    # print f, os.path.exists(f)
    if os.path.exists(f):
        current = ''.join( open( f, 'r' ).readlines() ).strip()
        version = current.strip('/').split('/')[-1]
        # print f, version, '.'.join(p[-4:-1]), p, version == '.'.join(p[-4:-1])
        return version == '.'.join(p[-4:-1])

    return False


def _populateAssets(hostApp='gaffer',filter="", folderName='sam', forceCache=None):
    import samDB
    reload(samDB)
    db=samDB.asset2()
    return (db, )


def populateAssets(hostApp='gaffer',filter="", folderName='sam', forceCache=None):
    import samDB
    from glob import glob
    ret = {}
    ret_sem_shot = {}
    zdata={}
    ret2={}

    try:
        j = pipe.admin.job()
    except:
        j=None
    if j:
        isAsset = '/asset/' in j.shot().path()
        shot = j.shot().shot
        def recursiveTree(path, d={}, d2={}, f='',l=0):
            if l>=4:
                return d
            for each in glob( "%s/*" % path ):
                if f in os.path.basename(each):
                    id = each.replace(path,'')[1:]
                    # print '====>',f
                    if os.path.isdir(each):
                        # try:
                        #     data = Asset.AssetParameter(each.replace(j.path('sam/'),'')).getData()
                        #     # id = id+" (%s)" % data['assetUser']
                        #     zdata[each] = data
                        # except:
                        #    pass
                        if l!=2 or len(id.split('.'))==1 or isAsset or shot == id.split('.')[0] :
                            # if l==2:
                            #     print shot ,id
                            # sys.stdout.flush()
                            d[id] = {}
                            # id2 = ( id if id[0].isdigit() and len(id.split('.'))>2 else id.split('.')[-1] )
                            # d2[id2] = {}
                            # recursiveTree(each, d[id], d2[id2],l=l+1)
                            recursiveTree(each, d[id], {},l=l+1)
                            # if l<3 and not d2[id2]:
                            #     del d[id]
                            #     del d2[id2]
                    elif 'current' in each :
                        lines = ''.join(open(each).readlines()).replace('\n','')
                        d['__current__'] = lines
                    #    d[id] = False
            return d
        t = time.time()

        # ret = recursiveTree("%s/sam" % (j.path()), ret, ret_sem_shot, filter)
        print( "populateAssets->starting: %0.04f" %  (time.time()-t) )
        types = assetUtils.types()
        print( "populateAssets->gettingTypes: %0.04f" %  (time.time()-t) )

        db = None
        if 0: #samDB.exists() and not forceCache:

            db, whoCanImport = samDB.retrieveAssetList()

            for t1,t2 in [ x.split('/')[:2] for x in whoCanImport.keys() ]:
                if not hostApp or hostApp in whoCanImport[ '%s/%s' % (t1,t2) ]:
                    ret2[t1] = db[t1]
            print( "populateAssets->usingCache: %0.04f" %  (time.time()-t) )

        else:
            whoCanImport = {}
            if forceCache:
                hostApp = None
            for t1,t2 in [ x.split('/')[:2] for x in types.keys() ]:
                if not hostApp or hostApp in types.whoCanImport( '%s/%s' % (t1,t2) ):
                    if t1 not in ret2:
                        ret2[t1] = {}
                    if t2 not in ret2[t1]:
                        ret2[t1][t2] = {}
                    ret2[t1][t2] = recursiveTree("%s/sam/%s/%s" % (j.path(),t1,t2), ret2[t1][t2], ret_sem_shot, filter,l=2)

                    # this removes asset types that have no asset inside... just to make the teelist cleaner!
                    if not ret2[t1][t2]:
                        del ret2[t1][t2]

                if not hostApp:
                    whoCanImport['%s/%s' % (t1,t2)] = types.whoCanImport( '%s/%s' % (t1,t2) )


            if not hostApp:
                samDB.cacheAssetList( (ret2, whoCanImport) )
                # print ret2
                print( "populateAssets->writeCache: %0.04f" %  (time.time()-t) )


        print( "populateAssets: %0.04f" %  (time.time()-t) )
        # print ret2
        # cleanup empty ones
        # for n in ret.keys():
        #     for i in ret[n].keys():
        #         if not ret[n][i]:
        #             del ret[n][i]
        #             del ret_sem_shot[n][i]
        #     if not ret[n]:
        #         del ret[n]
        #         del ret_sem_shot[n]
        # print ret
    return (ret2, ) #ret_sem_shot, zdata


class TreeItem(object):
    asset=0
    assetData=1
    assetFullPath=2
    assetOP=3
    assetOPSourceExistsInHost=4
    assetEditable=5
    assetIcon=6

    def __init__(self, data, parent=None):
        self.parentItem = parent
        self.childItems = []
        self.itemData = data

    def __getitem__(self, index):
        return self.data(index)
    #
    #
    # def index(self, item):
    #     return self.childItems.index(item)

    def append(self, item):
        self.appendChild(item)

    def appendChild(self, item):
        self.childItems.append(item)

    def child(self, row):
        return self.childItems[row]

    def childCount(self):
        return len(self.childItems)

    def count(self):
        return self.childCount()

    def columnCount(self):
        return 1 #len(self.itemData)

    def data(self, column, set=None):
        try:
            if set:
                self.itemData[column] = set
            else:
                return self.itemData[column]
        except IndexError:
            return None

    def parent(self):
        return self.parentItem

    def row(self):
        if self.parentItem:
            return self.parentItem.childItems.index(self)

    # def rowCount(self):
    #     if self.parentItem:
    #         return self.parentItem.childItems.index(self)

        return 0


class __tmp__:
    pass
class TreeModel(QtCore.QAbstractItemModel):
    ls=[]
    __old_ls=[1]
    updateFinished = GafferUI.WidgetSignal()

    def setColumnName(self, name=None):
        if name:
            self.columnName = name
        elif not hasattr(self, 'columnName'):
            self.columnName = uiColumnName()
        # print self.columnName
        self.rootItem.itemData = (self.columnName,)

    def refreshData(self):
        self.rootItem = TreeItem([' ','','',None])
        self.setupModelData(self.__data, self.rootItem)
        self.setColumnName()

    def __init__(self, data, parent=None):
        super(TreeModel, self).__init__(None)
        # print "TreeModelData:",data
        self.__data = data
        self.__parent = parent
        self.__hostApp = self.__parent.hostApp()
        # try:
        # except:
        #     self.__hostApp = "gaffer"
        self.refreshData()

        self.line = QtGui.QPixmap(_search.find('assets/dot.png')).scaled(200,1,QtCore.Qt.IgnoreAspectRatio)
        if assetUtils.m:
            self.__allLS = assetUtils.m.ls()

        self.assetMainTypes = {}
        self.assetTypes = {}

        self.__old_ls = [1]
        self.ls = []

        def compIcons(img, img2=_search.find('check_box32.png'), height=10, width=10, x=0, y=0, scale2=1):
            image = QtGui.QImage(img).scaledToHeight(height)
            imag2 = QtGui.QImage(img2).scaledToHeight(height*scale2)

            painter = QtGui.QPainter()
            painter.begin(image)
            painter.drawImage(x, y, imag2)
            painter.end()
            return QtGui.QPixmap.fromImage( image )

        for each in data.keys():
            if 'pyqt' in pipe.whatQt():
                typeIcon = QtGui.QPixmap(_search.find('assets/%s-15.png' % each))
            else:
                typeIcon = QtGui.QImageReader(_search.find('assets/%s-15.png' % each)).read()
            x, y = 5,5
            self.assetMainTypes[each] = {
                'plain' : typeIcon,
                'green' : compIcons( typeIcon, _search.find('greenlight_alpha.png') , 15, 30, x, y, 0.75),
                'red'   : compIcons( typeIcon, _search.find('redlight_alpha.png')   , 15, 30, x, y, 0.75),
                'yellow': compIcons( typeIcon, _search.find('yellowlight_alpha.png'), 15, 30, x, y, 0.75),
                'edit'  : compIcons( typeIcon, _search.find('edit-alpha-20.png')    , 15, 30, x, y, 0.75),
            }
            for each2 in data[each].keys():
                if 'pyqt' in pipe.whatQt():
                    subTypeIcon = QtGui.QPixmap(_search.find('assets/%s.png' % each2)).scaledToHeight(14)
                else:
                    subTypeIcon = QtGui.QImageReader(_search.find('assets/%s.png' % each2)).read().scaledToHeight(14)
                self.assetTypes[each2] = {
                    'plain' : subTypeIcon,
                    'green' : compIcons( subTypeIcon, _search.find('greenlight_alpha.png') , 14, 30, x, y, 0.75),
                    'red'   : compIcons( subTypeIcon, _search.find('redlight_alpha.png')   , 14, 30, x, y, 0.75),
                    'yellow': compIcons( subTypeIcon, _search.find('yellowlight_alpha.png'), 14, 30, x, y, 0.75),
                    'edit'  : compIcons( subTypeIcon, _search.find('edit-alpha-20.png')    , 14, 30, x, y, 0.75),
                }

        self.lights = {
            'blank'     : QtGui.QPixmap(_search.find('blanklight.png')).scaledToHeight(10),
            'green'     : QtGui.QPixmap(_search.find('greenlight.png')).scaledToHeight(10),
            'yellow'    : QtGui.QPixmap(_search.find('yellowlight.png')).scaledToHeight(10),
            'red'       : QtGui.QPixmap(_search.find('redlight.png')).scaledToHeight(10),
            'warning'   : QtGui.QPixmap(_search.find('warning-20.png')).scaledToHeight(10),
            'edit'      : QtGui.QPixmap(_search.find('edit-20.png')).scaledToHeight(10),
            'editGreen' : compIcons(_search.find('greenlight.png'), _search.find('edit-alpha-20.png')),
            'editRed'   : compIcons(_search.find('redlight.png'), _search.find('edit-alpha-20.png')),
        }


        self.colors = {
            'sourceExists': QtGui.QColor(230,230,110,50),
            'shot': QtGui.QColor(50,140,250,50),
            'assetType' : QtGui.QColor(20,20,20,255),
            'assetSubType' : QtGui.QColor(20,20,20,150),
        }

        self.lightCurrent = {
            self.lights['green'] : compIcons(_search.find('greenlight.png')),
            self.lights['blank'] : compIcons(_search.find('blanklight.png')),
            self.lights['red']   : compIcons(_search.find('redlight.png')),
            self.lights['yellow']: compIcons(_search.find('yellowlight.png')),
        }
        self.n = 0
        self.extraData = None

        if self.hostApp() == 'gaffer':
            self.lights['red'] = self.lights['green']

        self.refresh()

    def columnCount(self, parent):
        # print self.rootItem.columnCount()
        # print parent
        # print parent.isValid()
        # print parent.internalPointer().columnCount()
        if parent.isValid():
            return parent.internalPointer().columnCount()
        else:
            return self.rootItem.columnCount()

    def setExtraData(self,func):
        self.extraData = func

    def parentWidget(self, parent):
        self.__parent = parent
        self.__hostApp = self.__parent.hostApp()

    def hostApp(self):
        return self.__hostApp
        # return self.__parent.hostApp()

    def refresh(self, ls=[]):
        # if self.ls == self.__old_ls and ls==[]:
        #     return False

        self.ls = ls
        if not self.ls:
            if self.hostApp() == 'maya':
                    if assetUtils.m:
                        self.ls = assetUtils.m.ls( '|SAM*' )
            elif self.hostApp() == 'gaffer':
                self.ls = []
                for script in GafferUI.root()['scripts'].keys():
                    script = GafferUI.root()['scripts'][script]
                    self.ls += [ str(script[x]['asset'].getValue()) for x in script.keys() if 'asset' in script[x].keys() ]

            self.__old_ls = self.ls

        # self.dataChanged.emit(QtCore.QModelIndex(),QtCore.QModelIndex())
        self.layoutChanged.emit()
        # self.updateFinished.emit()
        return True


    def data(self, index, role=QtCore.Qt.DecorationRole):
        ret = self._data(index, role)
        # print "---------->", ret,'<---------------'
        # print "QtCore.Qt.DecorationRole", role == QtCore.Qt.DecorationRole
        # print "QtCore.Qt.SizeHintRole", role == QtCore.Qt.SizeHintRole
        # print "QtCore.Qt.BackgroundRole", role == QtCore.Qt.BackgroundRole
        return ret

    def _data(self, index, role=QtCore.Qt.DecorationRole):
        if not index.isValid():
            return None

        item = index.internalPointer()
        # print item ; sys.stdout.flush()
        # we don't cache ops for versions at initialization, so we do it in here,
        # that way it's only cached as needed!
        # this makes the panel shows up earlier!
        # print TreeItem.assetOP, TreeItem.assetData, item.data(TreeItem.assetData), item.data(TreeItem.assetOP) ;sys.stdout.flush()
        if item.data(TreeItem.assetData) and  item.data(TreeItem.assetData)[0] >= 2:
            if not item.data(TreeItem.assetOP):
                op = assetUtils.assetOP( item.data(TreeItem.assetFullPath), self.hostApp() )#, self.__data[item.data(TreeItem.assetFullPath)] )
                item.data(TreeItem.assetOP , op)
                assetSourceExistsInHost = item.data(TreeItem.assetOP).assetSourceExistsInHost()
                item.data(TreeItem.assetOPSourceExistsInHost , assetSourceExistsInHost)


        # tells if an asset is editable or not
        assetForPublishExists = False

        t = time.time()
        # if host app is maya!
        if self.hostApp() == 'maya' and  assetUtils.m and item.data(TreeItem.assetData)[0]>=2:
            # rendersettings in maya are allways editable!
            if 'renderSettings/' in item.data(TreeItem.assetFullPath):
                assetForPublishExists = True

            # others must have the original meshPrimitives used to publish present in the scene!
            else:
                assetForPublishExists = item.data(TreeItem.assetOP).assetSourceExistsInHost() #item.data(TreeItem.assetOPSourceExistsInHost)
            # item.data(TreeItem.assetOPSourceExistsInHost , assetSourceExistsInHost)

        # if host app is gaffer!
        elif self.hostApp() == 'gaffer':
            # if gaffer was called to edit an specific asset, we make ONLY that asset editable
            if  GafferUI.root().asset:
                assetForPublishExists = os.path.dirname(item.data(TreeItem.assetFullPath)) in GafferUI.root().asset
            # if no asset was specified, we call assetSourceExistsInHost() for the app to difine if its editable or not!
            else:
                if item.data(TreeItem.assetData) and item.data(TreeItem.assetData)[0]>=2:
                    assetForPublishExists = item.data(TreeItem.assetOPSourceExistsInHost) #


        # ICONS!!
        # print role, int(QtCore.Qt.UserRole), int(QtCore.Qt.DecorationRole), int(QtCore.Qt.BackgroundRole), int( QtCore.Qt.DisplayRole), index, index.column()
        if role == QtCore.Qt.SizeHintRole:
            ret = None
        elif role == QtCore.Qt.DecorationRole:
            ret = None
            # if the item has some data, we can Decorate!
            if item.data(TreeItem.assetData):
                op = item.data(TreeItem.assetOP)


                # if tree level is zero, we show the main data type of the asset
                if item.data(TreeItem.assetData)[0] == 0:
                    ret = self.assetMainTypes[item.data(0)]['plain']

                # if tree level is one, we show the data type of the asset
                if item.data(TreeItem.assetData)[0] == 1:
                    ret = self.assetTypes[item.data(0)]

                # if our asset has an OP, we can turn some icons on/off
                # elif op:
                if 1:
                    ret = self.lights['blank']
                    import re
                    asset = item.data(TreeItem.assetFullPath)
                    node = asset.replace('.','_').replace('-','_').replace('/','_')

                    # gather data from host app to show if things are up2date, loaded or editable
                    # if nothing changed, just use the cached value!
                    if not self.refresh() and item.data(TreeItem.assetIcon):
                        return item.data(TreeItem.assetIcon)

                    # using gathered data show if things are up2date, loaded or editable
                    nodesInTheScene = None
                    match = re.search(r'_\d\d_\d\d_\d\d', node)
                    mask_any_version = 'SAM_%s_.*' % ( node )
                    # if this asset has a version number
                    if match:
                        # check if the node is loaded!
                        versionPosition = match.start()
                        if self.hostApp() == 'maya':
                            mask_any_version = r'.*SAM_%s_\d\d_\d\d_\d\d_' % ( node[:versionPosition] )
                            # nodesInTheScene =  assetUtils.m.ls( '|SAM_%s_??_??_??_*' % node[:versionPosition] )
                        elif self.hostApp() == 'gaffer':
                            _node = asset.split('/')
                            mask_any_version = '/'.join(_node[:-1])

                    # if no version number, just check for the type and subtype
                    else:
                        # if self.hostApp() == 'maya':
                            mask_any_version = r'SAM_%s_*' % ( node )

                    nodesInTheScene = [ x for x in self.ls if re.match(mask_any_version, x) ]

                    # if nodesInTheScene:
                    # set the light status for the highest hierarqui
                    if item.data(TreeItem.assetData)[0]<2:
                        icons = self.assetMainTypes
                        if item.data(TreeItem.assetData)[0]:
                            icons = self.assetTypes

                        ret = icons[item.data(0)]['plain']
                        if nodesInTheScene:
                            ret = icons[item.data(0)]['green']
                            for each in nodesInTheScene:
                                if not checkIfNodeIsUpToDate(each):
                                    ret = icons[item.data(0)]['red']

                    # if we are on the asset name level
                    if nodesInTheScene and item.data(TreeItem.assetData)[0]==2:
                        ret = self.lights['red']
                        # if node version matches current version, make it green!
                        if [ x for x in nodesInTheScene if node in x ]:
                            ret = self.lights['green']

                    # version number level
                    elif nodesInTheScene and item.data(TreeItem.assetData)[0]=='/':
                        # only light up the loaded version
                        if [ x for x in nodesInTheScene if node in x ]:
                            ret = self.lights['red']
                            current = item.data(TreeItem.assetData).replace('.','_').replace('-','_').replace('/','_')
                            if node in current:
                                # if the loaded version is current, make it green
                                ret = self.lights['green']
                        # else:

                    elif op and not op.data:
                        ret = self.lights['yellow']


                    # only to set the current version icon!
                    if item.data(TreeItem.assetData)[0]=='/':
                        if node in item.data(TreeItem.assetData).replace('/','_').replace('.','_').replace('-','_'):
                            ret = self.lightCurrent[ret]


                    item.data(TreeItem.assetEditable, False)
                    if assetForPublishExists and item.data(TreeItem.assetData)[0] == 2:
                        item.data(TreeItem.assetEditable, True)
                        if ret == self.lights['green']:
                            ret = self.lights['editGreen']
                        elif ret == self.lights['red']:
                            ret = self.lights['editRed']
                        else:
                            ret = self.lights['edit']


            item.data(TreeItem.assetIcon, ret)


            # if time.time()-t > 0.01:
            #     print '===>', time.time()-t, item.data(TreeItem.assetFullPath) ; t = time.time(),

            if self.extraData:
                ret = self.extraData(index, role)

        # sets the background color!
        elif role == QtCore.Qt.BackgroundRole:
            ret = "1"
            depth = item.data(TreeItem.assetFullPath).split('/')
            # asset type level
            if len(depth)==1:
                ret = self.colors['assetType']
            # asset data type level
            elif len(depth)==2:
                ret = self.colors['assetSubType']
            # asset NAME level
            elif len(depth)>2:
                dots = depth[2].split('.')
                # for assets that can be published (with the pencil icon), make the background yellow!
                if assetForPublishExists and item.data(TreeItem.assetData)[0] == 2:
                    if item.data(TreeItem.assetData):
                        # if its renderSettings, keep the default background (but the pencil icon still show!)
                        if 'renderSettings/' not in item.data(TreeItem.assetFullPath):
                            ret = self.colors['sourceExists']
                # if the name has dots in it, its a shot specific asset!
                elif len( dots ) == 2:
                    ret = self.colors['shot']

        elif role == QtCore.Qt.DisplayRole:
            ret = item.data(index.column())
        else:
            ret = None

        if '---' in item.data(TreeItem.asset):
            ret = '  '
        # if item.data(1) and item.data(1)[0] in [1]:
        #         return ''

        # print "treemodel data:",ret, item.data(TreeItem.assetFullPath)
        return ret


    def flags(self, index):
        if not index.isValid():
            return QtCore.Qt.NoItemFlags

        return QtCore.Qt.ItemIsEnabled | QtCore.Qt.ItemIsSelectable # | QtCore.Qt.ItemIsUserCheckable

    def headerData(self, section, orientation, role):
        if orientation == QtCore.Qt.Horizontal and role == QtCore.Qt.DisplayRole:
            return self.rootItem.data(section)
        return None

    def index(self, row, column, parent):
        # print "=========>",row, column, parent, self.hasIndex(row, column, parent)
        if not self.hasIndex(row, column, parent):
            return QtCore.QModelIndex()

        if not parent.isValid():
            parentItem = self.rootItem
        else:
            parentItem = parent.internalPointer()

        childItem = parentItem.child(row)
        if childItem:
            return self.createIndex(row, column, childItem)
        else:
            return QtCore.QModelIndex()

    def parent(self, index):
        if not index.isValid():
            return QtCore.QModelIndex()

        childItem = index.internalPointer()
        if not hasattr(childItem, 'parent'):
            return QtCore.QModelIndex()
        parentItem = childItem.parent()

        if not  parentItem or parentItem == self.rootItem:
            return QtCore.QModelIndex()

        return self.createIndex(parentItem.row(), 0, parentItem)

    def rowCount(self, parent):
        # if parent.column() > 0:
        #     return 0

        if not parent.isValid():
            parentItem = self.rootItem
        else:
            parentItem = parent.internalPointer()

        # print parentItem.childCount();sys.stdout.flush()
        try:
            return parentItem.childCount()
        except:
            return 0

    def setupModelData(self, data, parent):
        import threading, sys
        ttt=0
        def recurseProcessData(data, parents = parent, depth=0, atype=[]):
            if not hasattr( data, 'keys' ) or depth==4:
                return
            keys = list(data.keys())
            keys.sort()
            current = [depth]
            if '__current__' in keys:
                current = data['__current__']
                del keys[keys.index('__current__')]
            for d in keys:
                    # print 'recurseProcessData:',d, depth
                    fullpath = '/'.join(atype+[str(d)])
                    op = None
                    assetSourceExistsInHost = None
                    if hasattr( data[d], 'keys' ) and  '__current__' in data[d].keys():
                        fullpath += '/%s' % os.path.basename( data[d]['__current__'].strip('/') )

                    if depth==2:
                        op = assetUtils.assetOP( fullpath, self.hostApp() )
                        assetSourceExistsInHost = op.assetSourceExistsInHost()

                    # if depth==0:
                    #     parents.appendChild(TreeItem(('---','','',None), parents))

                    item = TreeItem([d,current,fullpath,op,assetSourceExistsInHost,None,None], parents)
                    parents.appendChild(item)
                    recurseProcessData(data[d], item, depth+1, atype+[d])

            if depth==0:
                self.ready = parents

        t = time.time()
        self.ready = None
        recurseProcessData(data)
        # print parent
        print( 'setupModelData:', time.time() -t )

        # threading.Thread( target = lambda: recurseProcessData(data) ).start()
        #
        # self.timer = QtCore.QTimer()
        # def forceRefresh():
        #     if not self.__data:
        #         self.timer.singleShot( 100,forceRefresh)
        #     else:
        #         print self.__data




# class SAMPanelUI(MayaQWidgetDockableMixin, QtGui.QDockWidget ):
class _SAMPanelUI( QtGui.QFrame ):
    def __init__(self, title="SAM", parent=None):
        width=150
        # if not parent:
        #     parent = getMayaWindow()

        # if assetUtils.j:
        #     title = "SAM / %s" % assetUtils.j.proj

        self._windowTitle = title
        self._windowObject = "%sWinObject" % self._windowTitle.replace(' ', '')


        # super(_SAMPanelUI, self).__init__()
        QtGui.QFrame.__init__(self)


        self.setObjectName(self._windowTitle+'_')
        self.setWindowTitle(self._windowTitle)
        # self.setWindowFlags(QtCore.Qt.Tool | QtCore.Qt.FramelessWindowHint)


        # remove panel if it exists
        # for child in parent.children():
        #     if hasattr(child, "objectName"):
        #         if self.windowObject in child.objectName():
        #             # print child.objectName()
        #             parent.removeDockWidget(child)

        with GafferUI.Window('test') as self.window:
            self.al = SAMPanel( Gaffer.ScriptNode(), 'maya', self.refreshPanel )

            self.setLayout(QtGui.QVBoxLayout())
            self.layout().addWidget(self.window._qtWidget())
            self.layout().setAlignment(QtCore.Qt.AlignTop)
            self.layout().setContentsMargins(0, 0, 0, 0);

            # self.layout().addWidget(self.al._qtWidget())
            self.al._qtWidget().resize(width,100)
            self.resize(width,100)

        GafferUI.EventLoop.mainEventLoop().start()

    def refreshPanel(self, button):
        import assetListWidget
        reload(assetListWidget)
        assetListWidget._SAMPanelUI()



if assetUtils.m:
    import inspect
    import maya.OpenMayaUI as omui
    from maya.app.general.mayaMixin import MayaQWidgetDockableMixin

    class DockableBase(MayaQWidgetDockableMixin):
        """
        Convenience class for creating dockable Maya windows.
        """
        def __init__(self, controlName, **kwargs):
            self.controlName = controlName
            self.workspaceName = "%sWorkspaceControl" % self.controlName
            # we use the global mixinWindows var to store the control name
            # so we can delete the workspace when it already exists.
            # this fixes the problem at startup, since the workspace indeed exists
            # if maya was closed with it already open, and deleting it at startup
            # crashes maya! But the global var is empty at startup, so it won't
            # try to delete the workspace!
            if not hasattr(sys, 'mixinWindows'):
                sys.mixinWindows= {}

            # if self.controlName in sys.mixinWindows:
            #     del sys.mixinWindows[controlName]
            if assetUtils.m.workspaceControl(self.workspaceName, exists = True):
                # print "#######>", assetUtils.m.workspaceControl(self.workspaceName, exists = True)
                assetUtils.m.workspaceControl(self.workspaceName,
                    retain = False,
                    restore = 1,
                    requiredControl = "ToolBox",
                    dockToControl = ("ToolBox", 'right'),
                    width=200,
                    e=1
                )
                assetUtils.m.deleteUI(self.workspaceName)

            super(DockableBase, self).__init__(**kwargs)
            self.setObjectName(controlName)
            sys.mixinWindows[controlName] = self
            # print "##====>>",workspaceControl, omui.MQtUtil.findControl(self.objectName()), self;sys.stdout.flush()
            #     workspaceControl = omui.MQtUtil.getCurrentParent()
            #     print "##====>>",omui.MQtUtil.getLayoutChildren(_long(workspaceControl))
            #     sys.mixinWindows[controlName]=None

        def close(self):
            super(DockableBase, self).close(self)

        def show(self, *args, **kwargs):
            """
            Show UI with generated uiScript argument
            """
            modulePath = inspect.getmodule(self).__name__
            className = self.__class__.__name__
            super(DockableBase, self).show(dockable=True,uiScript="import {0}; {0}.{1}._restoreUI()".format(modulePath, className), **kwargs)
            if assetUtils.m.workspaceControl(self.workspaceName, exists = True):
            #     assetUtils.m.deleteUI("%sWorkspaceControl" % self.controlName)
                assetUtils.m.workspaceControl(self.workspaceName,
                    retain = False,
                    restore = 1,
                    requiredControl = "ToolBox",
                    dockToControl = ("ToolBox", 'right'),
                    width=200,
                    e=1
                )
                mixinPtr = omui.MQtUtil.findControl(self.controlName)
                workspaceControl = omui.MQtUtil.findControl("%sWorkspaceControl" % self.controlName)
                if mixinPtr:
                    name = omui.MQtUtil.addWidgetToMayaLayout(_long(mixinPtr), _long(workspaceControl))


        @classmethod
        def _restoreUI(cls):
            """
            Internal method to restore the UI when Maya is opened.
            """
            # Create UI instance
            # restore the one already created if one exists!
            # if hasattr(sys, 'mixinWindows'):
            #     instance = sys.mixinWindows[controlName]
            # else:
            #     instance = cls(controlName)
            #     # Store reference to UI
            #     sys.mixinWindows= {}
            #     sys.mixinWindows[controlName] = instance

            # instance = cls()
            # print instance
            # # Get the empty WorkspaceControl created by Maya
            # workspaceControl = omui.MQtUtil.getCurrentParent()
            # print "====>>",workspaceControl,dir(workspaceControl);sys.stdout.flush()
            # # Grab the pointer to our instance as a Maya object
            # mixinPtr = omui.MQtUtil.findControl(instance.objectName())
            # print "====>>",mixinPtr,instance;sys.stdout.flush()
            # # Add our UI to the WorkspaceControl
            # name = omui.MQtUtil.addWidgetToMayaLayout(_long(mixinPtr), _long(workspaceControl))
            # print " omui.MQtUtil.addWidgetToMayaLayout(_long(mixinPtr), _long(workspaceControl))", name
            # sys.stdout.flush()
            # controlName = name.split('WorkspaceControl')[0]


    # class SAMPanelUI(MayaQWidgetDockableMixin, _SAMPanelUI ):
    class SAMPanelUI( DockableBase, QtGui.QFrame ):
        def __init__(self):
            super(SAMPanelUI, self).__init__(controlName="MyWindowSAM")
            self.setWindowTitle("SAM")

            # self.pushButton = QtGui.QPushButton("Push me or else!", parent=self)
            self.widget = _SAMPanelUI()

            self.setLayout(QtGui.QVBoxLayout())
            self.layout().setAlignment(QtCore.Qt.AlignTop)
            self.layout().setContentsMargins(0, 0, 0, 0);
            self.layout().addWidget(self.widget)
            # self.layout().addWidget(QtGui.QPushButton("One"))

            self.show()


#
# class SAMPanelUI_old(QtGui.QDockWidget ):
#     def __init__(self, title="SAM", parent=None, ):
#         if not parent:
#             parent = getMayaWindow()
#         super(SAMPanelUI, self).__init__(title, parent)
#
#         self.parent = parent
#         self.windowTitle = title
#         self.windowObject = "%sWinObject" % self.windowTitle.replace(' ', '')
#
#         # remove panel if it exists
#         for child in parent.children():
#             if hasattr(child, "objectName"):
#                 if self.windowObject in child.objectName():
#                     # print child.objectName()
#                     parent.removeDockWidget(child)
#
#
#         # mayaImportDependency
#         # checkout
#         # publishAssetUpdate
#         # mayaOpenDependency
#
#
#         # add new dock widget
#         self.__buttons = []
#         self.__buttonsSignals = []
#         with GafferUI.Window('test') as self.window:
#             with GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal ) as self.layout:
#                 with GafferUI.ListContainer( GafferUI.SplitContainer.Orientation.Vertical ):
#                     with GafferUI.ListContainer( GafferUI.SplitContainer.Orientation.Horizontal ):
#                         self.__buttons += [1]
#                         self.__buttons[-1] = GafferUI.Button( "", "samShelfPanelx20.png", toolTip="Refresh the panel from the most up-to-date data"  )
#                         self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
#                         self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( Gaffer.WeakMethod( self.refreshPanel ), scoped = True  ) )
#
#                         self.__buttons += [1]
#                         self.__buttons[-1] = GafferUI.Button( "", "samShelfx20.png", toolTip="Open sam browser"  )
#                         self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
#                         self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( Gaffer.WeakMethod( self.openSAMBrowser ), scoped = True  ) )
#
#                         GafferUI.Spacer(IECore.V2i(10,10))
#
#                         self.__buttons += [1]
#                         self.__buttons[-1] = GafferUI.Button( "", "Autodesk-open-maya-icon_20.png", toolTip="Open selected asset in the current maya session"  )
#                         self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
#                         self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( lambda b: self.al.mayaImportDependency() ) )
#
#                         self.__buttons += [1]
#                         self.__buttons[-1] = GafferUI.Button( "", "Autodesk-maya-icon_20.png", toolTip="Open selected asset in a new maya session"  )
#                         self.__buttons[-1]._qtWidget().setMaximumSize( 22, 22 )
#                         self.__buttonsSignals.append( self.__buttons[-1].clickedSignal().connect( lambda b: self.al.mayaOpenDependency() ) )
#
#
#                     self.al = assetListWidget( Gaffer.ScriptNode() )
#
#         # self.al.hostApp('maya')
#
#         self.window._qtWidget().resize(100,100)
#         self.layout._qtWidget().resize(100,100)
#         self.al._qtWidget().resize(200,100)
#         self.setWidget(self.window._qtWidget())
#         self.setWindowTitle(self.windowTitle)
#         self.resize(100,100)
#
#         self.setObjectName(self.windowObject)
#
#         self.attach2Maya()
#         # self.raise()
#
#     def refreshPanel(self, button):
#         import assetListWidget
#         reload(assetListWidget)
#         assetListWidget.SAMPanelUI()
#
#     def openSAMBrowser(self, button):
#         import IECore
#         c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
#         a = c.load( "sam" )();a.run()
#
#     def attach2Maya(self):
#         # add the dock to the maya window
#         self.parent.addDockWidget(QtCore.Qt.LeftDockWidgetArea, self)
#         # self.widget().setMinimumWidth(100)
#         # self.widget().setMaximumWidth(200)
#         GafferUI.EventLoop.mainEventLoop().start()


def shaderUniqueNames():
    import maya.cmds as m
    import genericAsset

    for sl in m.ls(sl=1,l=1):
        prefix = sl.split('|')[1]
        nodes = []
        for shape in m.ls(sl,dag=1,type='mesh',ni=1):
            sgs = m.listConnections(shape,  type="shadingEngine")
            nodes += sgs
            for sg in sgs:
                c  = m.listConnections(sg+'.surfaceShader',  s=1, d=0)
                c = [] if not c else c
                cc = m.listConnections(sg+'.displacementShader',  s=1, d=0)
                cc = [] if not cc else cc
                c=list(set(c+cc))
                def recusiveConnections(c):
                    ret = []
                    c=list(set(c))
                    # print c
                    for node in c:
                        if node in ['lambert1','defaultColorMgtGlobals','initialShadingGroup'] or not m.objExists(node):
                            continue
                        if prefix not in node:
                            # print node, prefix+'_'+node
                            node=m.rename( node, prefix+'_'+node )
                        cc = m.listConnections(node,  s=1, d=0)
                        if cc:
                            ret += recusiveConnections(cc)
                            ret += cc
                    return list(set(ret))
                recusiveConnections(c)

        nodes = list(set(nodes))
        for node in nodes:
            if prefix not in node:
                if node in ['lambert1','defaultColorMgtGlobals','initialShadingGroup'] or not m.objExists(node):
                    continue
                # print node, prefix+'_'+node
                m.rename( node, prefix+'_'+node )


class SAMShelf(assetUtils.shelf):
    def __init__(self):
        super(SAMShelf, self).__init__('SAM')

        self.addShelfButton(
            '',
            'Open/Refresh SAM panel',
            cmd='import assetListWidget;reload(assetListWidget);assetListWidget.SAMPanelUI()',
            icon='%s/gaffer/graphics/samShelfPanelx32.png' % __tools__,
            menu=[('RELOAD SHELF', 'import assetListWidget;reload(assetListWidget);assetListWidget.SAMShelf()')]
        )

        self.addShelfButton(
            '',
            'Open SAM Browser',
            cmd='import IECore;c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" );a = c.load( "test" )();a.run()',
            icon='%s/gaffer/graphics/samShelfx32.png' % __tools__,
            menu=[('RELOAD SHELF', 'import assetListWidget;reload(assetListWidget);assetListWidget.SAMShelf()')]
        )

        # self.addShelfButton(
        #     '',
        #     'Get the name of the selected node and use as a prefix for all the nodes in the shader network. Use this to make the shading network nodes be unique!',
        #     cmd='import assetListWidget;reload(assetListWidget);assetListWidget.shaderUniqueNames()',
        #     icon='%s/gaffer/graphics/samShelfx32.png' % __tools__,
        #     menu=[('RELOAD SHELF', 'import assetListWidget;reload(assetListWidget);assetListWidget.SAMShelf()')]
        # )


        self.create()




if __name__ == '__main__':

    # gaffer needs a script context
    script = Gaffer.ScriptNode()

    # create some nodes
    node=Gaffer.Node( 'animation_alembic_test' )
    node['file'] = Gaffer.StringPlug()
    node['file'].setValue( 'test.abc' )
    node['out']= Gaffer.Plug( direction = Gaffer.Plug.Direction.Out )
    script.addChild( node )

    node=Gaffer.Node( 'camera_alembic_test' )
    node['file'] = Gaffer.StringPlug()
    node['file'].setValue( 'camera.abc' )
    node['out']= Gaffer.Plug( direction = Gaffer.Plug.Direction.Out )
    script.addChild( node )

    # create a node to connect other nodes to
    node=Gaffer.Node( 'mayaScene' )
    for n in range(2):
        node['in%d' % n] = Gaffer.Plug()
    script.addChild( node )

    # connect nodes
    script['mayaScene']['in0'].setInput( script['animation_alembic_test']['out'] )
    script['mayaScene']['in1'].setInput( script['camera_alembic_test']['out'] )


    with GafferUI.Window('test') as window:
        with GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal ) as split:
            layout =  GafferUI.SplitContainer( GafferUI.SplitContainer.Orientation.Horizontal )
            nodeGraph = GafferUI.NodeGraph( script )
            GafferUI.NodeEditor( script )

    graph=nodeGraph.graphGadget()
    graph.getLayout().layoutNodes( graph )

    model = TreeModel(populateAssets()[0])
    view = QtGui.QTreeView(layout._qtWidget())
    view.setModel(model)
    view.expandToDepth(1)
    view.resizeColumnToContents(0)
    view.setAlternatingRowColors(True)
    view.setColumnWidth(0,100)
    view.setIndentation(10)
    view.show()

    split.setSizes( ( 0.2, 0.5, 0.3 ) )

    window._qtWidget().resize( 1300, 800 )
    window.setVisible( True )

    GafferUI.EventLoop.mainEventLoop().start()

    # app = QtGui.QApplication(sys.argv)
    #

    # view = QtGui.QTreeView()
    # view.setModel(model)
    # view.setWindowTitle("Simple Tree Model")
    # view.show()
    # sys.exit(app.exec_())





GafferUI.SAMPanel = SAMPanel
GafferUI.SAMAssetListWidget = assetListWidget
GafferUI.Editor.registerType( "SAMList", SAMPanel )
