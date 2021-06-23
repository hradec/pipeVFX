

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


class _EditAssetPlugValueWidget( GafferUI.PlugValueWidget ) :

    def __init__( self, plug, *args, **kwargs) :

        row = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical )
        GafferUI.PlugValueWidget.__init__( self, row, plug )

        with row:
            # self.__startPauseButton = GafferUI.Button( image = 'timelinePlay.png' )

            with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal ):
                self.__label = GafferUI.Label( '' )
                self.__open = GafferUI.Button( image = 'Autodesk-maya-icon-edit_20.png', toolTip="Open the graph as a scene in Maya"   )
                self.__open._qtWidget().setMaximumSize( 30, 30 )

            # self.__startPauseClickedConnection = self.__startPauseButton.clickedSignal().connect( Gaffer.WeakMethod( self.__startPauseClicked ) )
            self.__openClickedConnection = self.__open.clickedSignal().connect( Gaffer.WeakMethod( self.__openClicked ) )

        self.mayaRunning = None
        self._updateFromPlug()
        self.timer = QtCore.QTimer()


    def _updateFromPlug( self ) :

        with self.getContext() :
            self.asset = self.getPlug().getValue()
            self.__label.setText(self.asset)

        self.__open.setEnabled( True )

    def __openClicked( self, button ) :

        scriptName = '/tmp/xx.mel'

        with self.getContext() :
            node = self.getPlug().parent()

        mayaCode = [
            'import maya.cmds as m',
            'def _gafferBundle_():',
            '   import assetUtils,genericAsset',
            '   import nodes',
            '   genericAsset.hostApp("maya")',
            '   nodes.mayaScene.bundleLoad(\''+node['out'].getValue().replace('@app@','maya')+'\')',
            'm.scriptJob( runOnce=1, idleEvent=_gafferBundle_ )',
        ]
        f=open('%s.py' % os.path.splitext(scriptName)[0],'w')
        f.write('\n'.join(mayaCode)+'\n'*2)
        f.close()

        f=open(scriptName,'w')
        f.write('''python("exec(''.join(open('/tmp/xx.py').readlines()))");\n\n''')
        f.close()

        self.mayaRunning = subprocess.Popen("bash -l -c 'source %s/scripts/go && run maya -script \"%s\"     '" % ( pipe.roots().tools(), os.path.abspath(scriptName) ), shell=True )

        # os.system( 'run maya -script "%s" & ' %  scriptName )


GafferSceneUI.SAM_editAssetPlugValueWidget = _EditAssetPlugValueWidget





class genericComputeNode( Gaffer.ComputeNode ) :
    ''' a generic computeNode so we can add some logic to an intern scenGraph '''
    def __init__( self, name = "none" ) :

        super(genericComputeNode, self).__init__( name )
        self.__pars = []
        self._init()

    def _init( self ):
        self.add( Gaffer.StringPlug( "out", Gaffer.Plug.Direction.Out, "" ) )
        self.add( Gaffer.StringPlug( "in" ) )


    def add( self, par ):
        self.__pars.append(par.getName())
        self[par.getName()] = par
        self.outs = [ x for x in self.__pars if 'out' in x ]

    def affects( self, input ) :
        outputs = Gaffer.ComputeNode.affects( self, input )

        # if input is any out plug, don't make it affect out plugs
        for out in self.outs :
            if input.isSame( self[out] ) :
                return outputs

        # make all other plugs affect all out plugs
        for out in self.outs :
            outputs.append( self[out] )

        return outputs

    def hash( self, plug, context, h ) :
        # ignore plug and hash all inputs to force to evaluate all the time!
        for p in self.__pars:
            if p not in self.outs :
                # print p
                self[p].hash( h )

    def compute( self, plug, context ) :
        self._compute( plug, context )

    def _compute( cls, plug, context ) :
        pass



class samAssetNode( GafferScene.SceneNode ) :
    ''' a new sam node that better integrates the assets into gaffer
    this node is a sceneNode with a small simple INTERNAL node network.
    this network is inter-connected by means of a custom python computeNode,
    which can do some basic logic, like getting the asset path from the node asset plug,
    and gather the alembic file for it, and return it as a conection to the internal alembicSource
    node.

    The compute node also connects to a empty objectToScene node, which
    basically just creates the object name to show up in the hierachy list.

    The objectToScene is also used to add the obj name to an assetList Gaffer SET.

    This SET is basically used as a fast array that contains all the enabled assets in the network.

    That way, any node can quickly retrieve this array for processing, like maya scene node.
    '''

    def __init__( self, name = "none" ) :

        GafferScene.SceneNode.__init__( self, name )


        self['asset'] = Gaffer.StringPlug( 'asset', Gaffer.Plug.Direction.In , '' )
        Gaffer.MetadataAlgo.setReadOnly( self['asset'], True )
        self['name'] = Gaffer.StringPlug()
        Gaffer.MetadataAlgo.setReadOnly( self['name'], True )
        self['camera'] = Gaffer.StringVectorDataPlug( 'camera', Gaffer.Plug.Direction.In , IECore.StringVectorData([]) )
        Gaffer.MetadataAlgo.setReadOnly( self['name'], True )
        self['alembic'] = Gaffer.StringPlug()
        Gaffer.MetadataAlgo.setReadOnly( self['name'], True )
        self['overrideAssetMask'] = Gaffer.StringPlug()
        Gaffer.MetadataAlgo.setReadOnly( self['overrideAssetMask'], True )
        self['previewAlembic'] = Gaffer.BoolPlug( 'previewAlembic', Gaffer.Plug.Direction.In , True )

        # a input scene nodule, so we can connect another asset to this one
        # useful to connect shader to model/animation
        self['in'] = Gaffer.ArrayPlug( "in", Gaffer.Plug.Direction.In, element = GafferScene.ScenePlug( "in0" ) )

        # we use this to convert the asset parameter to a gaffer name
        class logic(genericComputeNode):
            ''' we use this small python compute node to do some logic in the sceneNode.
            Basically it works like an expression, which uses the value of "asset" plug to setup
            the internal alembicSource node so alembic shows up in the viewer.
            it also sets the name of our node, so it shows up in the hierarchy list.
            '''
            def _init( self ):
                # self.add( GafferScene.ScenePlug( "inScene", Gaffer.Plug.Direction.In ) )
                self.add( GafferScene.ScenePlug( "alembic", Gaffer.Plug.Direction.In ) )
                self.add( GafferScene.ScenePlug( "enable", Gaffer.Plug.Direction.In ) )
                self.add( Gaffer.StringPlug( "inAsset", Gaffer.Plug.Direction.In, "" ) )
                self.add( Gaffer.StringPlug( "out", Gaffer.Plug.Direction.Out, "" ) )
                self.add( Gaffer.StringPlug( "outABC", Gaffer.Plug.Direction.Out, "" ) )
                self.add( Gaffer.StringPlug( "outCAMERA", Gaffer.Plug.Direction.Out, "" ) )
                self.add( Gaffer.StringVectorDataPlug( "outCAMERAs", Gaffer.Plug.Direction.Out, IECore.StringVectorData([]) ) )
                self.add( Gaffer.BoolPlug( "outCAMERAenable", Gaffer.Plug.Direction.Out ) )
                self.add( Gaffer.StringPlug( "outCAMERA_proj", Gaffer.Plug.Direction.Out, "" ) )
                self.add( Gaffer.FloatPlug( "outCAMERA_fov", Gaffer.Plug.Direction.Out ) )
                self.add( Gaffer.FloatPlug( "outModelAsset", Gaffer.Plug.Direction.Out ) )
                # self.add( Gaffer.StringPlug( "out2", Gaffer.Plug.Direction.Out, "" ) )
                # self.add( GafferScene.ScenePlug( "outScene", Gaffer.Plug.Direction.Out ) )

            def _compute( cls, plug, context ) :

                import utils
                # print '===>',cls['in'].getValue()
                assetPath = str( cls['inAsset'].getValue() )
                asset = assetPath.split('/')

                def getCameras( scene, path, l=[] ) :
                	for childName in scene.childNames( path ) :
                		if scene.object( path+'/'+str(childName) ).typeName() == 'Camera':
                			l += [path+'/'+str(childName)]
                			l[-1] = l[-1].replace('//','/')
                		getCameras( scene, path+'/'+str( childName ), l )
                	return l

                if not asset[0]:
                    asset = ['unnamed','unnamed','unnamed']

                node = self["__alembic"]

                # if plug.isSame( self['out'] ) :
                if plug.isSame( cls['out'] ) :
                    cls['out'].setValue( utils.samAssetToGaffer(assetPath) )

                elif plug.isSame( cls['outCAMERAenable'] ) :
                    cls['outCAMERAenable'].setValue( False )
                    if asset[1] in ['alembic'] and asset[0] in ['camera']:
                        for camera in getCameras( node["out"], "/" ):
                            cls['outCAMERAenable'].setValue( True )

                elif plug.isSame( cls['outCAMERA'] ) :
                    if asset[1] in ['alembic'] and asset[0] in ['camera']:
                        cameras = []
                        for camera in getCameras( node["out"], "/" ):
                            cameras += [ utils.samAssetToGaffer(assetPath)+'/'+camera ]
                            cls['outCAMERA'].setValue( cameras[-1] )
                    else:
                        cls['outCAMERA'].setValue( 'no camera found' )

                elif plug.isSame( cls['outCAMERAs'] ) :
                    cameras = []
                    if asset[1] in ['alembic'] and asset[0] in ['camera']:
                        for camera in getCameras( node["out"], "/" ):
                            cameras += [ camera ]
                    cls['outCAMERAs'].setValue( IECore.StringVectorData( cameras ) )

                elif plug.isSame( cls['outCAMERA_proj'] ) :
                    if asset[1] in ['alembic'] and asset[0] in ['camera']:
                        for camera in getCameras( node["out"], "/" ):
                            cls['outCAMERA_proj'].setValue( str(node["out"].object(camera).parameters()['projection']) )

                elif plug.isSame( cls['outCAMERA_fov'] ) :
                    if asset[1] in ['alembic'] and asset[0] in ['camera']:
                        for camera in getCameras( node["out"], "/" ):
                            cls['outCAMERA_fov'].setValue( float(node["out"].object(camera).parameters()['projection:fov']) )

                elif plug.isSame( cls['outABC'] ) :
                    if asset[1] in ['alembic']:
                        cls['outABC'].setValue( assetUtils.assetOP(assetPath).data['multiplePublishedFiles'][0] )
                    else:
                        cls['outABC'].setValue( "" )
                elif plug.isSame( cls['outModelAsset'] ) :
                    if asset[0] in ['model']:
                        cls['outModelAsset'].setValue(0)
                    else:
                        cls['outModelAsset'].setValue(1)


        self["__computeNode"] = logic(self.getName()+'_computeNode')
        self["__computeNode"]['inAsset'].setInput( self['asset'] )
        # self["__computeNode"]['inScene'].setInput( self['in'] )
        # self["__computeNode"]._compute = _compute #lambda cls, plug, context: self["__computeNode"]['out'].setValue(str( self['in'][0].getValue() ).replace('/',' | '))

        self['name'].setInput( self["__computeNode"]['out'] )
        self['camera'].setInput( self["__computeNode"]['outCAMERAs'] )
        self['alembic'].setInput( self["__computeNode"]['outABC'] )

        self["__alembic"] = GafferScene.AlembicSource()
        self["__alembic"]["enabled"].setInput( self["previewAlembic"] )
        self["__alembic"]['fileName'].setInput( self["__computeNode"]['outABC'] )

        self["__alembicTimeWarp"] = GafferScene.SceneTimeWarp()
        self["__alembicTimeWarp"]['speed'].setInput( self["__computeNode"]['outModelAsset'] )
        self["__alembicTimeWarp"]['in'].setInput( self['__alembic']['out'] )

        self["__cameraSet"] = GafferScene.Set()
        self["__cameraSet"]['mode'].setValue(1)
        self["__cameraSet"]['name'].setValue('__cameras')
        self["__cameraSet"]['paths'].setInput(  self["__computeNode"]['outCAMERAs']  )
        self["__cameraSet"]['in'].setInput( self['__alembicTimeWarp']['out'] )

        self["__obj"] = GafferScene.ObjectToScene()
        self["__obj"]["enabled"].setInput( self["enabled"] )
        self["__obj"]['name'].setInput( self["__computeNode"]['out'] )
        self["__obj"]['sets'].setValue( "assetList" )

        self["__parent"] = GafferScene.Parent()
        self["__parent"]['in'].setInput( self['__obj']['out'] )
        self["__parent"]['child'].setInput( self['__cameraSet']['out'] )
        self["__parent"]['parent'].setInput( self["__computeNode"]['out'] )

        # we use this group0/subtree0 to connect the compound input of this node into our sub network
        self["__group0"] = GafferScene.Group()
        self["__group0"]["enabled"].setInput( self["enabled"] )
        self["__group0"]["in"].setInput( self["in"] )

        # remove the group and parent the nodes back to root
        self["__subtree0"] = GafferScene.SubTree()
        self["__subtree0"]["enabled"].setInput( self["enabled"] )
        self["__subtree0"]['root'].setValue( '/group' )
        self["__subtree0"]['in'].setInput( self["__group0"]['out'] )

        # group1/subtree1 merges the inputs with the internal network scene
        self["__group1"] = GafferScene.Group()
        self["__group1"]["enabled"].setInput( self["enabled"] )
        self["__group1"]["in"][0].setInput( self["__subtree0"]['out'] )
        self["__group1"]["in"][1].setInput( self["__parent"]["out"] )
        # self["__group0"]["in"][2].setInput( self["__alembic"]['out'] )

        # remove the group and parent the nodes back to root
        self["__subtree1"] = GafferScene.SubTree()
        self["__subtree1"]["enabled"].setInput( self["enabled"] )
        self["__subtree1"]['root'].setValue( '/group' )
        self["__subtree1"]['in'].setInput( self["__group1"]['out'] )


        self["out"].setInput( self["__subtree1"]["out"] )


        # self["__computeNode"]['inScene'].setInput( self['out'] )
        # self.addChild( Gaffer.StringPlug( "fileName" ) )
        # self.addChild( Gaffer.ObjectPlug( "out", Gaffer.Plug.Direction.Out, IECore.NullObject.defaultNullObject() ) )
        # self.addChild( Gaffer.ScenePlug( "scene", Gaffer.Plug.Direction.Out, IECore.NullScene.defaultNullScene() ) )

    # def enabledPlug(self):
    #     return self['enabled']
    #
    #
    # def affects( self, input ) :
    #     outputs = Gaffer.ComputeNode.affects( self, input )
    #     if input.isSame( self['in'][0] ) :
    #         outputs.append( self["out"] )
    #
    #     elif input.isSame( self['asset'] ) :
    #         outputs.append( self["out"] )
    #
    #     elif input.isSame( self['overrideAssetMask'] ) :
    #         outputs.append( self["out"] )
    #
    #     elif input.isSame( self['enabled'] ) :
    #         outputs.append( self["out"] )
    #
    #     return outputs
    #
    # def hash( self, output, context, h ) :
    #     assert( output.isSame( self["out"] ) )
    #     for plug in self['in']:
    #         plug.hash( h )
    #     self['asset'].hash( h )
    #     self['overrideAssetMask'].hash( h )
    #     self['enabled'].hash( h )
    #
    # def compute( self, plug, context ) :
    #     #print 'compute', plug, context
    #     assert( plug.isSame( self["out"] ) )
    #
    #     self.op = assetUtils.assetOP( self['asset'].getValue() )
    #     if not self.op.data:
    #         raise Exception("Asset %s doesn't exist!", self['asset'].getValue())
    #
    #     ret = [ x.getValue() for x in self['in'] if x.getValue().strip() ]
    #
    #     if not self['enabled'].getValue():
    #         # if not enable, we disable everything that is connected to a model/animation
    #         # that way we prevent shaders and other model setups to be loaded!
    #         if [ x for x in ['SAManimation','SAMmodel'] if x in str(self) ]:
    #             ret=[]
    #
    #     # if self['enabled'].getValue():
    #     # if 'SAMcamera' in str(type(self)):
    #     #     ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s, "camera": True } ]' % ( self['asset'].getValue(), self['asset'].getValue(), self['enabled'].getValue()) ]
    #     # else:
    #     #     ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s } ]' % ( self['asset'].getValue(), self['asset'].getValue(), self['enabled'].getValue()) ]
    #
    #     ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s, "frame" : %s} ]' % ( self['asset'].getValue(), self['asset'].getValue(), self['enabled'].getValue(), context.getTime() ) ]
    #     ret = '+'.join(ret)
    #
    #
    #     plug.setValue( ret )
    #
    #
    #     if self.op.data.has_key('multiplePublishedFiles'):
    #         self.alembic = []
    #         for each in self.op.data['multiplePublishedFiles']:
    #             if '.abc' in each:
    #                 self.alembic += [ GafferScene.AlembicSource( ) ]
    #                 self.alembic[-1]['fileName'].setValue( each )




IECore.registerRunTimeTyped( samAssetNode, typeName = "Gaffer::samAssetNode" )







Gaffer.Metadata.registerNode(

    samAssetNode,

    "description",
    """
    The base type for all nodes which take an input scene and process it in some way.
    """,

    plugs = {

        # "*" : [
        #
        # 	"nodule:type", lambda plug : "GafferUI::StandardNodule" if isinstance( plug, GafferScene.ScenePlug ) else  "",
        # ],

        "in" : [

            "description", lambda plug : "The input scene" + ( "s" if isinstance( plug, Gaffer.ArrayPlug ) else "" ),
            # "nodeGadget:nodulePosition", "left",
            # "nodule:type", "GafferUI::CompoundNodule",
            "noduleLayout:spacing", 1.5,
            "nodule:type", "GafferUI::CompoundNodule",
            "plugValueWidget:type", "",
        ],

        "out" : [

            "description","""The processed output scene.""",
            "nodule:type", "GafferUI::StandardNodule",
            "plugValueWidget:type", "",
            # "nodeGadget:nodulePosition", "right",

        ],

        "asset" : [
            'label', '',
            "description","""The path for the asset. """,
            # "nodule:type", "",
            # "nodule:type","GafferUI::StandardNodule",
        ],
        "overrideAssetMask" : [
            "description","""The path for the asset. """,
            "nodule:type", "",
            "plugValueWidget:type", "",

        ],

    },

)
Gaffer.Metadata.registerNodeValue( samAssetNode, "nodeGadget:color", IECore.Color3f( 0.2, 0.25, 0.30 ) )
# Gaffer.Metadata.registerPlugValue( samAssetNode, "in*", "nodule:color", IECore.Color3f( 0.45, 0.6, 0.3 ) )
# Gaffer.Metadata.registerPlugValue( samAssetNode, "out", "nodule:color", IECore.Color3f( 0.45, 0.6, 0.3 ) )
Gaffer.Metadata.registerPlugValue( samAssetNode, "in*", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )
Gaffer.Metadata.registerPlugValue( samAssetNode, "out", "nodule:color", IECore.Color3f( 0.2401, 0.3394, 0.485 ) )




def samAssetNodeCreator( node ) :
    import samGadget
    reload(samGadget)
    result = samGadget._SAMNodeGadget( node )
    result.getContents().setText( str(node['asset'].getValue()) )
    return result
# GafferUI.NodeGadget.registerNodeGadget( samAssetNode, samAssetNodeCreator )




import assetUtils
types = assetUtils.types()
for t in types.keys():
    each = t.split('/')
    if len(each)>1:
        nodeType = "SAM%s%s" % (each[0], each[1].capitalize())
        exec( 'class %s(samAssetNode):\n pass' % nodeType)

        IECore.registerRunTimeTyped( eval(nodeType), typeName = "Gaffer::%s" % nodeType )
        Gaffer.Metadata.registerNodeValue( eval(nodeType), "nodeGadget:color", types.color(t) )
        # GafferUI.NodeGadget.registerNodeGadget( eval(nodeType), samAssetNodeCreator )
