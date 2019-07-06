


import IECore
import Gaffer
import GafferUI
import GafferScene
import GafferCortex
import GafferCortexUI
import Asset
import assetUtils
from sam import genericComputeNode


from GafferCortexUI.ParameterisedHolderUI import __plugDescription,__plugPresetNames,__plugPresetValues,__plugWidgetType,__plugNoduleType, _ParameterisedHolderNodeUI, __nodeSummary, __nodeDescription

import utils
reload(utils)


class RenderMayaPublish( GafferCortex.ParameterisedHolderDependencyNode ) :

    def __init__( self, asset, name = "RenderMayaPublish" ) :

        super(RenderMayaPublish, self).__init__( name )

        self.op = assetUtils.assetOP(asset)
        self.op.loadOP()
        self.setParameterised(self.op.op)

        # self['asset'] = Gaffer.StringPlug( 'asset', Gaffer.Plug.Direction.In , asset )
        # self['name'] = Gaffer.StringPlug( 'name', Gaffer.Plug.Direction.In , '' )

        #
        # self['in'] = Gaffer.ArrayPlug( "in", Gaffer.Plug.Direction.In, element = GafferScene.ScenePlug( "in0" ) )
        # self['out'] = GafferScene.ScenePlug("out", Gaffer.Plug.Direction.Out)
        #
        # self['parameters'] = Gaffer.CompoundPlug( "parameters" )
        #
        #
        # class __RenderMayaPublish_COMPUTE(genericComputeNode):
        #     def _init( cls ):
        #         # self.add( GafferScene.ScenePlug( "inScene", Gaffer.Plug.Direction.In ) )
        #         cls.add( GafferScene.ScenePlug( "enable", Gaffer.Plug.Direction.In ) )
        #         cls.add( Gaffer.StringPlug( "inAsset", Gaffer.Plug.Direction.In, "" ) )
        #         cls.add( Gaffer.StringPlug( "out", Gaffer.Plug.Direction.Out, "" ) )
        #
        #     def _compute( cls, plug, context ) :
        #
        #         import utils
        #         # print '===>',cls['in'].getValue()
        #         assetPath = str( cls['inAsset'].getValue() )
        #         asset = assetPath.split('/')
        #
        #         # if plug.isSame( self['out'] ) :
        #         if plug.isSame( cls['out'] ) :
        #             cls['out'].setValue( utils.samAssetToGaffer(assetPath) )
        #             self.parent.op = assetUtils.assetOP(assetPath)
        #             self.parent.op.loadOP()
        #             self.parent.setParameterised(self.parent.op.op)
        #
        # # self.setParameterised(self.op.op)
        #
        # self['__opHolder'] = GafferCortex.ParameterisedHolderDependencyNode()
        # self['__opHolder'].setParameterised(self.op.op)
        # self['parameters'].setInput( self['__opHolder']['parameters']['Asset']['info'] )

        # self["__computeNode"] = __RenderMayaPublish_COMPUTE(self.getName()+'_computeNode')
        # self["__computeNode"].parent = self
        # self["__computeNode"]['inAsset'].setInput( self['asset'] )
        #
        # self['name'].setInput( self["__computeNode"]['out'] )
        #
        # # group in and this node into the scene
        # self["__group0"] = GafferScene.Group()
        # # self["__group0"]["enabled"].setInput( self["enabled"] )
        # self["__group0"]["in"].setInput( self["in"] )
        #
        # # remove the group and parent the nodes back to root
        # self["__subtree"] = GafferScene.SubTree()
        # # self["__subtree"]["enabled"].setInput( self["enabled"] )
        # self["__subtree"]['root'].setValue( '/group' )
        # self["__subtree"]['in'].setInput( self["__group0"]['out'] )
        #
        # self["out"].setInput( self["__subtree"]["out"] )


# GafferUI.NodeUI.registerNodeUI( RenderMayaPublish, _ParameterisedHolderNodeUI )

Gaffer.RenderMayaPublish = RenderMayaPublish
IECore.registerRunTimeTyped( RenderMayaPublish, typeName = "Gaffer::RenderMayaPublish" )

Gaffer.Metadata.registerNode(
    RenderMayaPublish,
    "description", __nodeDescription,
    "summary", __nodeSummary,
    plugs = {
        "in" : [
            "description", lambda plug : "The input scene" + ( "s" if isinstance( plug, Gaffer.ArrayPlug ) else "" ),
            # "nodeGadget:nodulePosition", "left",
            # "compoundNodule:orientation", "y",
            "nodule:type", "GafferUI::CompoundNodule",
            "plugValueWidget:type", "",
            "noduleLayout:spacing", 1.5,
        ],
        "parameters" : [
            'label' , '',
            "nodule:type", "GafferUI::CompoundNodule",
        ],
        "parameters.*" : [
            "description", __plugDescription,
            "presetNames", __plugPresetNames,
            "presetValues", __plugPresetValues,
            "plugValueWidget:type", __plugWidgetType,
            "nodule:type", __plugNoduleType,
        ],
"result" : [

			"description",
			"""
			The result of running the Op.
			""",

		],


    }
)
Gaffer.Metadata.registerNodeValue( RenderMayaPublish, "nodeGadget:color", IECore.Color3f( 0.2, 0.45, 0.40 ) )
