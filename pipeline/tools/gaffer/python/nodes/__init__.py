# backward compatibility
try:from importlib import reload
except: pass
import sys, os
sys.path.insert( 0, os.path.abspath( os.path.dirname(__file__) ) )
# print(  os.path.abspath( os.path.dirname(__file__) ) )

# backward compatibility
import IECore
try:
    import imath
    for c in [ x for x in dir(imath) if 'V' in x[0] or 'C' in x[0] ]:
        # print('IECore.%s=imath.%s' % (c,c))
        exec( 'IECore.%s=imath.%s' % (c,c) )
except:
    pass


import mayaScene
import publish
reload(mayaScene)
reload(publish)

from mayaScene import *
from sam import *
from publish import *
from mergeNode import Merge

import utils


class MatteAssignment( GafferScene.SceneProcessor ) :

    def __init__( self, name = "MatteAssignment" ) :

        GafferScene.SceneProcessor.__init__( self, name )

        self["__red"] = GafferScene.StandardAttributes()
        self["__red"]["in"].setInput( self["in"] )
        self["__red"]["attributes"].addMember( "user:matteColor", IECore.Color3f( 1, 0, 0 ) )
        self["redFilter"] = self["__red"]["filter"].createCounterpart( "redFilter", Gaffer.Plug.Direction.In )
        self["__red"]["filter"].setInput( self["redFilter"] )

        self["__green"] = GafferScene.StandardAttributes()
        self["__green"]["in"].setInput( self["__red"]["out"] )
        self["__green"]["attributes"].addMember( "user:matteColor", IECore.Color3f( 0, 1, 0 ) )
        self["greenFilter"] = self["__green"]["filter"].createCounterpart( "greenFilter", Gaffer.Plug.Direction.In )
        self["__green"]["filter"].setInput( self["greenFilter"] )

        self["out"].setInput( self["__green"]["out"] )



class SphereOrCube( GafferScene.SceneNode, Gaffer.ComputeNode  ) :

    Type = IECore.Enum.create( "Sphere", "Cube" )

    def __init__( self, name = "SphereOrCube" ) :

        GafferScene.SceneNode.__init__( self, name )

        self['sceneIn'] =  Gaffer.ArrayPlug( "sceneIn", Gaffer.Plug.Direction.In, element = GafferScene.ScenePlug( "sceneIn" ) ) #GafferScene.ScenePlug( "sceneIn", Gaffer.Plug.Direction.In )
        self["asset"] = Gaffer.StringPlug()
        self["type"] = Gaffer.IntPlug(
            defaultValue = int( self.Type.Sphere ),
            minValue = int( self.Type.Sphere ),
            maxValue = int( self.Type.Cube ),
        )


        self["__sphere"] = GafferScene.Sphere('obj')
        self["__sphere"]["enabled"].setInput( self["enabled"] )
        self["__sphere"]['name'].setInput( self["asset"] )
        self["__sphere"]['sets'].setValue( "assetList" )

        self["__cube"] = GafferScene.Cube()
        self["__cube"]["enabled"].setInput( self["enabled"] )

        self["__primitiveSwitch"] = GafferScene.SceneSwitch()
        self["__primitiveSwitch"]["index"].setInput( self["type"] )
        self["__primitiveSwitch"]["in"][0].setInput( self["__sphere"]["out"] )
        self["__primitiveSwitch"]["in"][1].setInput( self["__cube"]["out"] )


        self["__group"] = GafferScene.Group()
        self["__group"]["in"][0].setInput( self["__primitiveSwitch"]["out"] )
        self["__group"]["in"][1].setInput( self['sceneIn'][0] )
        # self["__group"]["in"][2].setInput( self['sceneIn'][1] )

        self["out"].setInput( self["__group"]["out"] )

    # def affects( self, input ) :
    #     print input
    #     print self['in'][0]
    #     # if input:
    #     outputs = Gaffer.ComputeNode.affects( self, input )
    #
    #     if len(self['in']):
    #         if input.isSame( self['in'][0] ) :
    #             outputs.append( self["out"] )
    #
    #
    # def compute( self, plug, context ) :
    #     print 'compute', plug, context
    #     assert( plug.isSame( self["out"] ) )
    #     self["__group"]["in"][1].setInput( self["in"][0]["out"] )
    #
    #     self["out"].setInput( self["__group"]["out"] )

IECore.registerRunTimeTyped( SphereOrCube )

Gaffer.Metadata.registerNode(

    SphereOrCube,

    "description",
    """
    A little test node
    """,

    plugs = {

        "sceneIn" : [

            "description", lambda plug : "The input scene" + ( "s" if isinstance( plug, Gaffer.ArrayPlug ) else "" ),
            "nodule:type", "GafferUI::CompoundNodule",
            "plugValueWidget:type", "",
            "noduleLayout:spacing", 1.0,
        ],
        "type" : [

            "description",
            """
            Pick yer lovely primitive here.
            """,

            "preset:Sphere", int( SphereOrCube.Type.Sphere ),
            "preset:Cube", int( SphereOrCube.Type.Cube ),

        ]

    }

)
