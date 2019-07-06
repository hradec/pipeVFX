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




import os
import sys
import re
import weakref
import threading

import IECore
import Gaffer
import GafferUI
import pipe

import  assetListWidget
reload(assetListWidget)

import assetUtils
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


QtGui = GafferUI._qtImport( "QtGui" )
QtCore = GafferUI._qtImport( "QtCore" )



class bundleListWidget( GafferUI.EditorWidget ):

    __pathSelectedSignal = GafferUI.WidgetSignal()
    __selectionChangedSignal = GafferUI.WidgetSignal()
    __displayModeChangedSignal = GafferUI.WidgetSignal()
    __expansionChangedSignal = GafferUI.WidgetSignal()
    _selectionChangedSignal = GafferUI.WidgetSignal()

    def __init__(self, scriptNode=None, **kw):
        from GafferUI.PathListingWidget import _TreeView

        __toolTip__='''Light Icons:
            off\t= asset not present in the scene
            green\t= asset present in the scene, and up-to-date
            red\t= asset present in the scene, but its an older/not current version
            edit\t= EDIT MODE - the scene has the source nodes for publishing a new version, and NOT the actual asset.
                   \t  If this is a render scene, please make sure to remove the original nodes and import the asset!
                   \t  (Unless renderSettings assets, since they are allways available for publishing)
        '''
        __toolTip__ +='''\nBackground:
            blue\t= shot specific asset
            yellow\t= same as edit icon
        '''


        self._script = scriptNode
        super( bundleListWidget, self).__init__( _TreeView(), scriptNode, toolTip=__toolTip__, **kw )

        # GafferUI.EditorWidget.__init__( self, QtGui.QTreeView(), scriptNode, **kw )
        self._lastLS = None

        # self._model = TreeModel(populateAssets()[0])
        # self._qtWidget().setModel(self._model)
        # self._qtWidget().expandToDepth(1)
        self.setTreeModel()
        self._mayaNodeDeleted()

        self._qtWidget().resizeColumnToContents(0)
        self._qtWidget().setColumnWidth(0,100)
        self._qtWidget().setIndentation(10)

        self._qtWidget().setAlternatingRowColors( True )
        self._qtWidget().setUniformRowHeights( True )
        self._qtWidget().setEditTriggers( QtGui.QTreeView.NoEditTriggers )
        self._qtWidget().activated.connect( Gaffer.WeakMethod( self.__activated ) )
        self._qtWidget().header().setMovable( False )
        self._qtWidget().header().setSortIndicator( 0, QtCore.Qt.AscendingOrder )
        self._qtWidget().setSortingEnabled( True )


        # members for implementing drag and drop
        self.__emittingButtonPress = False
        self.__borrowedButtonPress = None
        self.__buttonPressConnection = self.buttonPressSignal().connect( Gaffer.WeakMethod( self.__buttonPress ) )
        self.__buttonReleaseConnection = self.buttonReleaseSignal().connect( Gaffer.WeakMethod( self.__buttonRelease ) )
        self.__mouseMoveConnection = self.mouseMoveSignal().connect( Gaffer.WeakMethod( self.__mouseMove ) )
        self.__dragBeginConnection = self.dragBeginSignal().connect( Gaffer.WeakMethod( self.__dragBegin ) )
        self.__dragEndConnection = self.dragEndSignal().connect( Gaffer.WeakMethod( self.__dragEnd ) )
        self.__dragPointer = "paths"


        self.__contextMenuConnection = self.contextMenuSignal().connect( Gaffer.WeakMethod( self.__contextMenu ) )

        self.__hostApp = None
        # self.__dragEnterConnection = self.dragEnterSignal().connect( Gaffer.WeakMethod( self.__dragEnter ) )

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


    def _mayaNodeDeleted(self, force=False):
        ls=[]
        if assetUtils.m:
            ls = assetUtils.m.ls("|SAM*")
        # print ls
        if ls != self._lastLS or force:
            self.refresh(ls)
        def __SAM_assetList_mayaNodeDeleted__():
             def __SAM_assetList_mayaNodeDeleted_IDLE__():
                import genericAsset
                genericAsset.maya.cleanUnusedShadingNodes()
                genericAsset.maya.attachShadersLazy()
                # genericAsset.maya.setRenderSettings()
                self._mayaNodeDeleted(True)
             assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_mayaNodeDeleted_IDLE__ )

        assetUtils.mayaLazyScriptJob( runOnce=False,  deleteEvent=__SAM_assetList_mayaNodeDeleted__ )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['deleteAll',__SAM_assetList_mayaNodeDeleted__] )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['NewSceneOpened',__SAM_assetList_mayaNodeDeleted__] )
        assetUtils.mayaLazyScriptJob( runOnce=False,  event=['SceneOpened',__SAM_assetList_mayaNodeDeleted__] )

        # def __SAM_assetList_mayaSelectSam__():
        #     print m.ls(sl=1)
        # assetUtils.mayaLazyScriptJob( runOnce=False,  event=['SomethingSelected',__SAM_assetList_mayaSelectSam__] )

    def hostApp(self, hostAppName):
        self.__hostApp = hostAppName

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
        # for path in selectedPaths:

        selected_source_exists_in_host = False if [ x for x in selectedPathsExistInHost if x ] else True

        isAssetMenu = [ x for x in selectedPaths if len(x.split('/'))>2 ]
        isPublishMenu = [ x for x in selectedPaths if len(x.split('/'))<=2 ]

        if isAssetMenu:
            def checkout(paths):
                def __SAM_assetList_doImport__():
                    import genericAsset
                    pb = genericAsset.progressBar( len(paths)+1, "Importing assets..." )
                    for path in paths:
                        pb.step()
                        print path
                        op = assetUtils.assetOP( path )
                        op.doImport( )
                    pb.step()
                    pb.close()
                    self._mayaNodeDeleted()
                    # print op, path
                __SAM_assetList_doImport__()
                # assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_doImport__)

            canImport = selected_source_exists_in_host
            if len(selectedPaths)==1:
                if 'renderSettings/' in selectedPaths[0]:
                    canImport = True
            menuDefinition.append( "/Import selected" , { "command" : IECore.curry(checkout, selectedPaths), "active" : canImport  } )

            if len(selectedPaths)==1:
                menuDefinition.append( "/  " , { } )
                menuDefinition.append( "/ " , { } )

                def updateAsset(asset):
                    op = assetUtils.assetOP(asset[0])
                    op.updatePublish()

                menuDefinition.append( "/Publish an UPDATE to the selected asset" , { "command" : IECore.curry(updateAsset, selectedPaths), "active" : not selected_source_exists_in_host  } )
                menuDefinition.append( "/" , { } )

                def mayaImportDependency(paths):
                    def __SAM_assetList_mayaImportDependency__():
                        # print paths
                        for path in paths:
                            # print path
                            op = assetUtils.assetOP( path )
                            op.mayaImportDependency( )
                    if assetUtils.m:
                        assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_mayaImportDependency__)
                    else:
                        __SAM_assetList_mayaImportDependency__()

                def mayaOpenDependency(paths):
                    def __SAM_assetList_mayaOpenDependency__():
                        # print paths
                        for path in paths:
                            # print path
                            op = assetUtils.assetOP( path )
                            op.mayaOpenDependency( )
                    if assetUtils.m:
                        assetUtils.mayaLazyScriptJob( runOnce=True,  idleEvent=__SAM_assetList_mayaOpenDependency__)
                    else:
                        __SAM_assetList_mayaOpenDependency__()

                if assetUtils.m:
                    menuDefinition.append( "/open original scene in this maya session " , { "command" : IECore.curry(mayaImportDependency, selectedPaths) } )
                menuDefinition.append( "/open original scene in a new maya session " , { "command" : IECore.curry(mayaOpenDependency, selectedPaths) } )

        elif isPublishMenu and len(selectedPaths)==1:
            from pprint import pprint
            types = assetUtils.Asset.types(refresh=True)
            atype = selectedPaths[0].split('/')[0]

            def createNewAsset(paths, assetType):
                op = assetUtils.assetOP(assetType)
                op.newPublish()


            for t in [ x for x in types if atype in x.split('/') ]:
                if 'render/' in t:
                    if assetUtils.m and 'render/maya' not in t:
                        continue

                menuDefinition.append( "/publish new asset of type %s" % t.replace('/','_'), { "command" : IECore.curry(createNewAsset, selectedPaths, t) } )

    	self.__menu = GafferUI.Menu( menuDefinition )
    	if len( menuDefinition.items() ) :
    		self.__menu.popup( parent = pathListing.ancestor( GafferUI.Window ) )

    	return True


    def refresh( self , lastLS=None):
        self.setTreeModel()
        if self._lastLS != lastLS:
            self._lastLS = lastLS
            self._model.refresh(self._lastLS)

    def setTreeModel(self):
        self._model = TreeModel(populateAssets()[0])
        self._qtWidget().setModel(self._model)
        self._qtWidget().expandToDepth(1)
        self._qtWidget().setSelectionMode( QtGui.QAbstractItemView.ExtendedSelection )
        self.__selectionChangedSlot = Gaffer.WeakMethod( self.__selectionChanged )
        self._qtWidget().selectionModel().selectionChanged.connect( self.__selectionChangedSlot )
        self._qtWidget().setSelectionMode( QtGui.QAbstractItemView.ExtendedSelection )

    def getTitle(self):
        return 'SAM Bundle List'

    def __repr__( self ) :

        return "GafferUI.SAMbundleListWidget( scriptNode )"


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
        # print [ index.internalPointer().data(TreeItem.assetFullPath) for index in selectedRows ]
        ret = {}
        for column in [ x for x in dir(TreeItem) if 'asset' in x ]:
            ret[column] = []
            for index in selectedRows:
                ret[column] += [index.internalPointer().data(eval('TreeItem.%s' % column))]
        return ret



    # def setSelectedPaths( self, paths, scrollToFirst=True, expandNonLeaf=True ) :
    #
    #     # If there are pending changes to our path model, we must perform
    #     # them now, so that the model is valid with respect to the paths
    #     # we're trying to select.
    #     self.__updateLazily.flush( self )
    #     selectionModel = self._qtWidget().selectionModel()
    #     selectionModel.selectionChanged.disconnect( self.__selectionChangedSlot )
    #
    #     selectionModel.clear()
    #
    #     for path in paths :
    #
    #         indexToSelect = self.__indexForPath( path )
    #         if indexToSelect.isValid() :
    #             selectionModel.select( indexToSelect, selectionModel.Select | selectionModel.Rows )
    #             if scrollToFirst :
    #                 self._qtWidget().scrollTo( indexToSelect, self._qtWidget().EnsureVisible )
    #                 selectionModel.setCurrentIndex( indexToSelect, selectionModel.Current )
    #                 scrollToFirst = False
    #             if expandNonLeaf and not path.isLeaf() :
    #                 self._qtWidget().setExpanded( indexToSelect, True )
    #
    #     selectionModel.selectionChanged.connect( self.__selectionChangedSlot )
    #
    #     self.selectionChangedSignal()( self )


    def __selectionChanged( self, selected, deselected ) :
        self.selectionChangedSignal()( self )
        return True

    def selectionChangedSignal( self ) :
        if assetUtils.m:
            assetUtils.m.select(cl=1)
            selectedData = self.getSelectedColumns()
            # print selectedData
            for n in range( len( selectedData['assetFullPath'] ) ):
                path, op = selectedData['assetFullPath'][n], selectedData['assetOP'][n]
                # print path
                # op = assetUtils.assetOP( path )
                if op:
                    nodes = op.assetSourceExistsInHost()
                    if nodes and 'renderSettings' not in path:
                        if assetUtils.m:
                            assetUtils.m.select(nodes)
                    else:
                        op.mayaSelectNodes()
                # self.refresh(op.mayaLastLs())

        self.parent()._qtWidget().emit(QtCore.SIGNAL("selectionChangedSignal(PyQt_PyObject)"), {"self": self})

        return self.__selectionChangedSignal

    def __pathForIndex( self, modelIndex ) :
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

        return self.__pathSelectedSignal

    def __buttonPress( self, widget, event ) :

        if self.__emittingButtonPress :
            return False

        self.__borrowedButtonPress = None
        if event.buttons == event.Buttons.Left and event.modifiers == event.Modifiers.None :

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

        if event.buttons :
            # take the event so that the underlying QTreeView doesn't
            # try to do drag-selection, which would ruin our own upcoming drag.
            return True

        return False

    def __dragBegin( self, widget, event ) :

        self.__borrowedButtonPress = None
        selectedPaths = self.getSelectedPaths()
        if len( selectedPaths ) :
            GafferUI.Pointer.setCurrent( self.__dragPointer )
            each =str(selectedPaths[0])
            print each
            node =  Gaffer.Node( '_'.join(each.split('/')[:-1]) )
            node['in']= Gaffer.Plug(  )
            node['out']= Gaffer.Plug( direction = Gaffer.Plug.Direction.Out )
            return node



            return IECore.StringVectorData(
                [ str( p ) for p in selectedPaths ],
            )
        return None


    def __dragEnter( self, widget, event ) :
        print widget
        print event.destinationGadget
        print event.destinationWidget
        sys.stdout.flush()


    def __dragEnd( self, widget, event ) :
        import sys
        for each in event.data:
            # node =  Gaffer.Node( '_'.join(each.split('/')[:-1]) )
            # node['in']= Gaffer.Plug(  )
            # node['out']= Gaffer.Plug( direction = Gaffer.Plug.Direction.Out )
            if event.destinationGadget:
                event.destinationGadget.ScriptNode.addChild( node )
        # print dir(event)
        print widget
        print event.destinationGadget
        print event.destinationWidget
        sys.stdout.flush()

        # self.__viewportGadget.dragEndSignal()( self.__viewportGadget, event )


        # if self._nodeGraph:
        #     graph = self._nodeGraph.graphGadget()
        #     graph.getLayout().layoutNodes( graph )
        GafferUI.Pointer.setCurrent( None )

    def __emitButtonPress( self, event ) :

        qEvent = QtGui.QMouseEvent(
            QtCore.QEvent.MouseButtonPress,
            QtCore.QPoint( event.line.p0.x, event.line.p0.y ),
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



def populateAssets(filter="", folderName='sam'):
    from glob import glob
    ret = {}
    ret_sem_shot = {}
    zdata={}
    try:
        j = pipe.admin.job()
    except:
        j=None
    if j:
        isAsset = '/asset/' in j.shot().path()
        shot = j.shot().shot
        def recursiveTree(path, d={}, l=0):
            if l<2:
                for each in glob( "%s/*" % path ):
                    id = each.replace(path,'')[1:].strip()
                    print each,id,[ x for x in ['shots/','assets/'] if x in each ]
                    if os.path.isdir(each) and [ x for x in ['/shots','/assets'] if x in each ]:
                        # try:
                        #     data = Asset.AssetParameter(each.replace(j.path('sam/'),'')).getData()
                        #     # id = id+" (%s)" % data['assetUser']
                        #     zdata[each] = data
                        # except:
                        #    pass
                        d[id] = {}
                        recursiveTree(each, d[id], l+1)
                return d

        ret[j.proj] = {}
        recursiveTree("%s" % (j.path()), ret[j.proj])

    return ret, ret_sem_shot, zdata





class TreeItem(assetListWidget.TreeItem):
    asset=0
    assetData=1
    assetFullPath=2
    assetOP=3
    assetOPSourceExistsInHost=4

    def __init__(self, data, parent=None):
        self.parentItem = parent
        self.itemData = data
        self.childItems = []

    def appendChild(self, item):
        self.childItems.append(item)

    def child(self, row):
        return self.childItems[row]

    def childCount(self):
        return len(self.childItems)

    def columnCount(self):
        return len(self.itemData)

    def data(self, column):
        try:
            return self.itemData[column]
        except IndexError:
            return None

    def parent(self):
        return self.parentItem

    def row(self):
        if self.parentItem:
            return self.parentItem.childItems.index(self)

        return 0


class TreeModel(QtCore.QAbstractItemModel): #assetListWidget.TreeModel):
    def __init__(self, data, parent=None):
        super(TreeModel, self).__init__(parent)

        self.rootItem = TreeItem(("Shots|Assets", ))
        self.setupModelData(data, self.rootItem)

        self.line = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/dot.png').scaled(200,1,QtCore.Qt.IgnoreAspectRatio)

        self.assetTypes = {}
        for each in data:
            # self.assetTypes[each] = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/%s.png' % each).scaledToHeight(30)
            for each2 in data[each]:
                self.assetTypes[each2] = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/%s.png' % each2).scaledToHeight(15)

        self.lights = {
            'blank'  : QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/blanklight.png').scaledToHeight(10),
            'green'  : QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/greenlight.png').scaledToHeight(10),
            'yellow' : QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/yellowlight.png').scaledToHeight(10),
            'red'    : QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/redlight.png').scaledToHeight(10),
            'warning': QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/warning-20.png').scaledToHeight(10),
            'edit'   : QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/edit-20.png').scaledToHeight(10),
        }
        self.colors = {
            'sourceExists': QtGui.QColor(230,230,110,50),
            'shot': QtGui.QColor(50,140,250,50),
        }

        def compCheckbox(img):
            checkbox = QtGui.QImage('/atomo/pipeline/tools/gaffer/graphics/check_box32.png').scaledToHeight(10)
            image = QtGui.QImage(img).scaledToHeight(10)
            painter = QtGui.QPainter()
            painter.begin(image)
            painter.drawImage(0, 0, checkbox)
            painter.end()
            return QtGui.QPixmap.fromImage( image )

        self.lightCurrent = {
            self.lights['green'] : compCheckbox('/atomo/pipeline/tools/gaffer/graphics/greenlight.png'),
            self.lights['blank'] : compCheckbox('/atomo/pipeline/tools/gaffer/graphics/blanklight.png'),
            self.lights['red']   : compCheckbox('/atomo/pipeline/tools/gaffer/graphics/yellowlight.png'),
        }
        self.n = 0
        self.extraData = None

        self.refresh()

    def columnCount(self, parent):
        if parent.isValid():
            return parent.internalPointer().columnCount()
        else:
            return self.rootItem.columnCount()

    def setExtraData(self,func):
        self.extraData = func

    def refresh(self, ls=[]):
        self.ls = ls
        if assetUtils.m:
            if not self.ls:
                self.ls = assetUtils.m.ls( '|SAM*' )

    def data(self, index, role):
        if not index.isValid():
            return None

        item = index.internalPointer()

        assetForPublishExists = item.data(TreeItem.assetOPSourceExistsInHost)

        if role == QtCore.Qt.DecorationRole:
            ret = None
            if item.data(TreeItem.assetData):

                # if item.data(0) in item.data(TreeItem.assetData):
                #     ret = self.lights[1]
                #
                # elif item.data(TreeItem.assetData)[0] == 0:
                #     ret = None
                #
                #
                # elif item.data(TreeItem.assetData)[0] == 2:
                #     ret = self.lights[3]

                op = item.data(TreeItem.assetOP)

                if item.data(TreeItem.assetData)[0] == 1:
                    ret = self.assetTypes[item.data(0)]

                elif op:
                    ret = self.lights['blank']
                    if assetUtils.m:
                        asset = item.data(TreeItem.assetFullPath)
                        node = asset.replace('.','_').replace('/','_')

                        if [ x for x in self.ls if 'SAM_%s' % node in x ]:
                            ret = self.lights['green']
                            if item.data(TreeItem.assetData)[0]=='/':
                            #     ret = self.lights[5]
                                if node not in item.data(TreeItem.assetData).replace('/','_').replace('.','_'):
                                    ret = self.lights['red']
                        elif not op.data:
                            ret = self.lights['red']
                        elif [ x for x in self.ls if 'SAM_%s' % node.replace(op.data['assetVersion'].replace('.','_'),'') in x ]:
                            ret = self.lights['red']
                            if item.data(TreeItem.assetData)[0] == '/':
                                ret = self.lights['blank']

                        if item.data(TreeItem.assetData)[0]=='/':
                            if node in item.data(TreeItem.assetData).replace('/','_').replace('.','_'):
                                ret = self.lightCurrent[ret]

                    if assetForPublishExists and item.data(TreeItem.assetData)[0] == 2:
                        ret = self.lights['edit']

            # if '---' in item.data(0):
            #     ret = self.line
            # if 'maya' == item.data(0):
            #     ret = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/maya.png').scaledToHeight(20)
            # if 'alembic' == item.data(0):
            #     ret = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/alembic.png').scaledToHeight(20)
            if self.extraData:
                ret = self.extraData(index, role)
            return ret
        elif role == QtCore.Qt.BackgroundRole:
            depth = item.data(TreeItem.assetFullPath).split('/')
            if len(depth)>2:
                dots = depth[2].split('.')
                if assetForPublishExists and item.data(TreeItem.assetData)[0] == 2:
                    if item.data(TreeItem.assetData):
                        return self.colors['sourceExists']
                elif len( dots ) == 2:
                    return self.colors['shot']
            return None
        elif role != QtCore.Qt.DisplayRole:
            return None


        if '---' in item.data(TreeItem.asset):
            return '  '
        # if item.data(1) and item.data(1)[0] in [1]:
        #         return ''

        return item.data(index.column())

    def flags(self, index):
        if not index.isValid():
            return QtCore.Qt.NoItemFlags

        return QtCore.Qt.ItemIsEnabled | QtCore.Qt.ItemIsSelectable

    def headerData(self, section, orientation, role):
        if orientation == QtCore.Qt.Horizontal and role == QtCore.Qt.DisplayRole:
            return self.rootItem.data(section)

        return None

    def index(self, row, column, parent):
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
        parentItem = childItem.parent()

        if parentItem == self.rootItem:
            return QtCore.QModelIndex()

        return self.createIndex(parentItem.row(), 0, parentItem)

    def rowCount(self, parent):
        if parent.column() > 0:
            return 0

        if not parent.isValid():
            parentItem = self.rootItem
        else:
            parentItem = parent.internalPointer()

        return parentItem.childCount()

    def setupModelData(self, data, parent):
        import threading
        def recurseProcessData(data, parents = parent, depth=0, atype=[]):
            if data:
                keys = data.keys()
                keys.sort()
                current = [depth]
                if '__current__' in keys:
                    current = data['__current__']
                    del keys[keys.index('__current__')]
                for d in keys:
                        fullpath = '/'.join(atype+[d])
                        op = None
                        assetSourceExistsInHost = None
                        if '__current__' in data[d].keys():
                            fullpath += '/%s' % os.path.basename( data[d]['__current__'].strip('/') )

                        if depth>1:
                            op = assetUtils.assetOP( fullpath )
                            assetSourceExistsInHost = op.assetSourceExistsInHost()

                        if depth==0:
                            parents.appendChild(TreeItem(('---','','',None), parents))

                        parents.appendChild(TreeItem((d,current,fullpath,op,assetSourceExistsInHost), parents))
                        recurseProcessData(data[d], parents.child(-1), depth+1, atype+[d])

                if depth==0:
                    self.ready = parents


        self.ready = None
        print data
        recurseProcessData(data)

        # threading.Thread( target = lambda: recurseProcessData(data) ).start()
        #
        # self.timer = QtCore.QTimer()
        # def forceRefresh():
        #     if not self.__data:
        #         self.timer.singleShot( 100,forceRefresh)
        #     else:
        #         print self.__data





GafferUI.SAMbundleListWidget = bundleListWidget
GafferUI.EditorWidget.registerType( "SAMBundleList", bundleListWidget )
