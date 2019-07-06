

import IECore
import Gaffer
import GafferUI
import GafferScene


import utils
reload(utils)

class Merge( GafferScene.SceneNode ) :

    def __init__( self, name = "Merge" ) :

        super(Merge, self).__init__( name )

        self['in'] = Gaffer.ArrayPlug( "in", Gaffer.Plug.Direction.In, element = GafferScene.ScenePlug( "in0" ) )


        # group in and this node into the scene
        self["__group0"] = GafferScene.Group()
        self["__group0"]["enabled"].setInput( self["enabled"] )
        self["__group0"]["in"].setInput( self["in"] )

        # remove the group and parent the nodes back to root
        self["__subtree"] = GafferScene.SubTree()
        self["__subtree"]["enabled"].setInput( self["enabled"] )
        self["__subtree"]['root'].setValue( '/group' )
        self["__subtree"]['in'].setInput( self["__group0"]['out'] )

        self["out"].setInput( self["__subtree"]["out"] )

Gaffer.Merge = Merge
IECore.registerRunTimeTyped( Merge, typeName = "Gaffer::Merge" )
Gaffer.Metadata.registerNode( Merge,"description","Merge the object in the node with the root of the scene",
    plugs = {
        "in" : [
            "description", lambda plug : "The input scene" + ( "s" if isinstance( plug, Gaffer.ArrayPlug ) else "" ),
            # "nodeGadget:nodulePosition", "left",
            # "compoundNodule:orientation", "y",
            "nodule:type", "GafferUI::CompoundNodule",
            "plugValueWidget:type", "",
            "noduleLayout:spacing", 1.5,
        ],
    }
)
Gaffer.Metadata.registerNodeValue( Merge, "nodeGadget:color", IECore.Color3f( 0.2, 0.45, 0.40 ) )
