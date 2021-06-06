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
        def recursiveTree(path, d={}, d2={}, f='',l=0):
            if l>=5:
                return d
            for each in glob( "%s/*" % path ):
                if f in each:
                    id = each.replace(path,'')[1:]
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
                            sys.stdout.flush()
                            id2 = ( id if id[0].isdigit() and len(id.split('.'))>2 else id.split('.')[-1] )
                            d[id] = {}
                            d2[id2] = {}
                            recursiveTree(each, d[id], d2[id2],l=l+1)
                            if l<3 and not d2[id2]:
                                del d[id]
                                del d2[id2]
                    elif 'current' in each :
                        lines = ''.join(open(each).readlines()).replace('\n','')
                        d['__current__'] = lines
                    #    d[id] = False
            return d

        ret = recursiveTree("%s/sam" % (j.path()), ret, ret_sem_shot, filter)
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
    return ret, ret_sem_shot, zdata


class TreeItem(object):
    asset=0
    assetData=1

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


class TreeModel(QtCore.QAbstractItemModel):
    def __init__(self, data, parent=None):
        super(TreeModel, self).__init__(parent)

        self.rootItem = TreeItem(("Asset", ))
        self.setupModelData(data, self.rootItem)

        self.line = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/dot.png').scaled(200,1,QtCore.Qt.IgnoreAspectRatio)

        self.assetTypes = {}
        for each in data:
            # self.assetTypes[each] = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/%s.png' % each).scaledToHeight(30)
            for each2 in data[each]:
                self.assetTypes[each2] = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/%s.png' % each2).scaledToHeight(15)

        self.lights = [
            QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/blanklight.png').scaledToHeight(10),
            QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/greenlight.png').scaledToHeight(10),
            QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/yellowlight.png').scaledToHeight(10),
            QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/redlight.png').scaledToHeight(10),
        ]
        self.colors = [
            QtGui.QColor(150,150,180,50),
            QtGui.QColor(150,150,20,80),
            QtGui.QColor(150,20,20,80),
        ]
        self.n = 0

    def columnCount(self, parent):
        if parent.isValid():
            return parent.internalPointer().columnCount()
        else:
            return self.rootItem.columnCount()

    def data(self, index, role):
        if not index.isValid():
            return None

        item = index.internalPointer()

        if role == QtCore.Qt.DecorationRole:
            ret = None
            if item.data(TreeItem.assetData):
                ret = self.lights[0]

                if item.data(0) in item.data(TreeItem.assetData):
                    ret = self.lights[1]

                elif item.data(TreeItem.assetData)[0] == 0:
                    ret = None

                elif item.data(TreeItem.assetData)[0] == 1:
                    ret = self.assetTypes[item.data(0)]

                elif item.data(TreeItem.assetData)[0] == 2:
                    ret = self.lights[3]


            # if '---' in item.data(0):
            #     ret = self.line
            # if 'maya' == item.data(0):
            #     ret = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/maya.png').scaledToHeight(20)
            # if 'alembic' == item.data(0):
            #     ret = QtGui.QPixmap('/atomo/pipeline/tools/gaffer/graphics/assets/alembic.png').scaledToHeight(20)
            return ret
        elif role == QtCore.Qt.BackgroundRole:
            # if '---' in item.data(0):
            #     return self.colors[0]
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
        def recurseProcessData(data, parents = parent, depth=0, atype=''):
            keys = data.keys()
            keys.sort()
            current = [depth]
            if '__current__' in keys:
                current = data['__current__']
                del keys[keys.index('__current__')]
            for d in keys:
                    if depth==0:
                        atype=d
                        parents.appendChild(TreeItem(('---',''), parents))
                    parents.appendChild(TreeItem((d,current), parents))
                    recurseProcessData(data[d], parents.child(-1), depth+1, atype)

        recurseProcessData(data)

if __name__ == '__main__':
    import assetListWidget, GafferScene,GafferCortex
    # gaffer needs a script context
    script = Gaffer.ScriptNode()


    class mayaSceneNode(GafferScene.Group):
        pass

    Gaffer.Metadata.registerPlugValue( Gaffer.Node, "in*", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )
    Gaffer.Metadata.registerPlugValue( Gaffer.Node, "out", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )
    Gaffer.Metadata.registerNodeValue( Gaffer.Node, "nodeGadget:color", IECore.Color3f( 0.61 ) )
    Gaffer.Metadata.registerNodeValue( mayaSceneNode, "nodeGadget:color", IECore.Color3f( 0.61, 0.1525, 0.1525 ) )


    script.addChild(GafferCortex.OpHolder())

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
        print dir(event)
        print event.modifiers
        print event.key
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
