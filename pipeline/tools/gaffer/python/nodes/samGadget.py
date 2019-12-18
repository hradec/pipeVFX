

import ast
import os
import sys

import IECore

import Gaffer
import GafferUI
import GafferDispatch
import GafferScene
import GafferSceneUI

QtCore, QtGui = pipe.importQt()

sys._stdout = sys.stdout






class _SAMPlugAdder ( GafferUI.PlugAdder ):
    def __init__(self, node, edge ):
        super( _SAMPlugAdder, self ).__init__( edge )

        self.node = node
        self.edge = edge

        self.node.childAddedSignal().connect(self.childAdded)
        self.node.childRemovedSignal().connect(self.childRemoved)

        self.updateVisibility()


    def acceptsPlug( self, connectionEndPoint ):
        return True

    def addPlug( self, connectionEndPoint ):
        # UndoContext undoContext( m_switch->ancestor<ScriptNode>() );

        self.node.setup( connectionEndPoint )
        inPlug = self.node["in"]
        outPlug = self.node["out"]

        inOpposite = False
        if connectionEndPoint.direction() == Gaffer.Plug.Direction.Out:
            inPlug[0].setInput( connectionEndPoint )
            inOpposite = False
        else:
            connectionEndPoint.setInput( outPlug )
            inOpposite = True

        self.applyEdgeMetadata( inPlug, inOpposite )
        self.applyEdgeMetadata( outPlug, not inOpposite )


    def childAdded(self):
        self.updateVisibility()

    def childRemoved(self):
        self.updateVisibility()

    def updateVisibility(self):
        self.setVisible( self.node["in"] is None )



class _SAMNodeGadget( GafferUI.StandardNodeGadget ):
    def __init__(self, node):
        super( _SAMNodeGadget, self ).__init__( node )
        self.setEdgeGadget( GafferUI.StandardNodeGadget.Edge.LeftEdge,     _SAMPlugAdder( node, GafferUI.StandardNodeGadget.Edge.LeftEdge ) )
        self.setEdgeGadget( GafferUI.StandardNodeGadget.Edge.RightEdge,    _SAMPlugAdder( node, GafferUI.StandardNodeGadget.Edge.RightEdge ) )
        self.setEdgeGadget( GafferUI.StandardNodeGadget.Edge.TopEdge,      _SAMPlugAdder( node, GafferUI.StandardNodeGadget.Edge.TopEdge ) )
        self.setEdgeGadget( GafferUI.StandardNodeGadget.Edge.BottomEdge,   _SAMPlugAdder( node, GafferUI.StandardNodeGadget.Edge.BottomEdge ) )
