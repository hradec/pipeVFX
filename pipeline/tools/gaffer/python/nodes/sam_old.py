##########################################################################
#
#  Copyright (c) 2015, John Haddon. All rights reserved.
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



class samAssetNode( Gaffer.ComputeNode ) :

    def __init__( self, name = "none" ) :

        super(samAssetNode, self).__init__( name )

        self['asset'] = Gaffer.StringPlug()
        Gaffer.MetadataAlgo.setReadOnly( self['asset'], True )
        self['name'] = Gaffer.StringPlug()
        Gaffer.MetadataAlgo.setReadOnly( self['name'], True )
        self['overrideAssetMask'] = Gaffer.StringPlug()
        Gaffer.MetadataAlgo.setReadOnly( self['overrideAssetMask'], True )

        self['out'] = Gaffer.StringPlug( "out", Gaffer.Plug.Direction.Out, "" )
        # self.addChild( Gaffer.StringPlug( "out", Gaffer.Plug.Direction.Out, "" ) )
        self['in'] = Gaffer.ArrayPlug( "in", Gaffer.Plug.Direction.In, element = Gaffer.StringPlug( "in0" ) )

        self['enabled'] = Gaffer.BoolPlug()
        self['enabled'].setValue(True)

        # self.addChild( Gaffer.StringPlug( "fileName" ) )
        # self.addChild( Gaffer.ObjectPlug( "out", Gaffer.Plug.Direction.Out, IECore.NullObject.defaultNullObject() ) )
        # self.addChild( Gaffer.ScenePlug( "scene", Gaffer.Plug.Direction.Out, IECore.NullScene.defaultNullScene() ) )

    def enabledPlug(self):
        return self['enabled']


    def affects( self, input ) :
        outputs = Gaffer.ComputeNode.affects( self, input )
        if input.isSame( self['in'][0] ) :
            outputs.append( self["out"] )

        elif input.isSame( self['asset'] ) :
            outputs.append( self["out"] )

        elif input.isSame( self['overrideAssetMask'] ) :
            outputs.append( self["out"] )

        elif input.isSame( self['enabled'] ) :
            outputs.append( self["out"] )

        return outputs

    def hash( self, output, context, h ) :
        assert( output.isSame( self["out"] ) )
        for plug in self['in']:
            plug.hash( h )
        self['asset'].hash( h )
        self['overrideAssetMask'].hash( h )
        self['enabled'].hash( h )

    def compute( self, plug, context ) :
        #print 'compute', plug, context
        assert( plug.isSame( self["out"] ) )

        self.op = assetUtils.assetOP( self['asset'].getValue() )
        if not self.op.data:
            raise Exception("Asset %s doesn't exist!", self['asset'].getValue())

        ret = [ x.getValue() for x in self['in'] if x.getValue().strip() ]

        if not self['enabled'].getValue():
            # if not enable, we disable everything that is connected to a model/animation
            # that way we prevent shaders and other model setups to be loaded!
            if [ x for x in ['SAManimation','SAMmodel'] if x in str(self) ]:
                ret=[]

        # if self['enabled'].getValue():
        # if 'SAMcamera' in str(type(self)):
        #     ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s, "camera": True } ]' % ( self['asset'].getValue(), self['asset'].getValue(), self['enabled'].getValue()) ]
        # else:
        #     ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s } ]' % ( self['asset'].getValue(), self['asset'].getValue(), self['enabled'].getValue()) ]

        ret += [ '[ { "op" : assetUtils.assetOP("%s","@app@"), "node":"%s", "enable": %s, "frame" : %s} ]' % ( self['asset'].getValue(), self['asset'].getValue(), self['enabled'].getValue(), context.getTime() ) ]
        ret = '+'.join(ret)


        plug.setValue( ret )


        if self.op.data.has_key('multiplePublishedFiles'):
            self.alembic = []
            for each in self.op.data['multiplePublishedFiles']:
                if '.abc' in each:
                    self.alembic += [ GafferScene.AlembicSource( ) ]
                    self.alembic[-1]['fileName'].setValue( each )


'''


    def computeChildNames( self, scenePath, context, parent ):
        print "computeChildNames:" + scenePath, context, parent
        if scenePath.size() == 0:
    		result = IECore.InternedStringVectorData()
    		name = self['asset'].getValue()
    		if name.strip():
    			result[ name ]
    		else:
    			result[ "unnamed" ]
    		return result
    	return parent.childNamesPlug().defaultValue()

    def hashChildNames( self, scenePath, context, parent, h ):
        if scenePath.size() == 0:
    		GafferScene.ObjectSource.hashChildNames(self, scenePath, context, parent, h )
    		self['asset'].hash( h )
    		return
        h = parent.childNamesPlug().defaultValue().hash();



	def computeBound( scenePath, context, parent ):
	def computeTransform( scenePath, context, parent ):
	def computeAttributes( scenePath, context, parent ):
	def computeObject( scenePath, context, parent ):
	def computeChildNames( scenePath, context, parent ):
	def computeGlobals( context, parent ):
	def computeSetNames( context, parent ):
	def computeSet( setName, context, parent )



        virtual void hashBound( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashTransform( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashAttributes( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashObject( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashChildNames( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashGlobals( const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashSetNames( const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;
		virtual void hashSet( const IECore::InternedString &setName, const Gaffer::Context *context, const ScenePlug *parent, IECore::MurmurHash &h ) const;

		virtual Imath::Box3f computeBound( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual Imath::M44f computeTransform( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual IECore::ConstCompoundObjectPtr computeAttributes( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual IECore::ConstObjectPtr computeObject( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual IECore::ConstInternedStringVectorDataPtr computeChildNames( const ScenePath &path, const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual IECore::ConstCompoundObjectPtr computeGlobals( const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual IECore::ConstInternedStringVectorDataPtr computeSetNames( const Gaffer::Context *context, const ScenePlug *parent ) const;
		virtual GafferScene::ConstPathMatcherDataPtr computeSet( const IECore::InternedString &setName, const Gaffer::Context *context, const ScenePlug *parent ) const;




'''


IECore.registerRunTimeTyped( samAssetNode, typeName = "Gaffer::samAssetNode" )
# Gaffer.ArrayPlug.enableInputGeneratorCompatibility( mayaScene )

Gaffer.Metadata.registerNode(

    samAssetNode,

    "description",
    """
    The base type for all nodes which take an input scene and process it in some way.
    """,

    plugs = {

        "*" : [

			"nodule:type", lambda plug : "GafferUI::StandardNodule" if isinstance( plug, GafferScene.ScenePlug ) or isinstance( plug, Gaffer.StringPlug ) else  "",
		],

        "in" : [

            "description", lambda plug : "The input scene" + ( "s" if isinstance( plug, Gaffer.ArrayPlug ) else "" ),
            # "nodeGadget:nodulePosition", "left",
            # "compoundNodule:orientation", "y",
            "nodule:type", "GafferUI::CompoundNodule",
            "plugValueWidget:type", "",
            "noduleLayout:spacing", 0.4,
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
            "nodule:type", "",
            # "plugValueWidget:type", "GafferSceneUI.SAM_editAssetPlugValueWidget",
            # "plugValueWidget:type", "GafferUI.FileSystemPathPlugValueWidget",
            # "pathPlugValueWidget:leaf", True,
            # "pathPlugValueWidget:bookmarks", "rib",
            # "fileSystemPathPlugValueWidget:extensions", IECore.StringVectorData( [ "rib" ] ),

        ],
        "name" : [
            'label', '',
            "description","""The path for the asset. """,
            "nodule:type", "",
            "plugValueWidget:type", "",
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




import assetUtils
types = assetUtils.types()
for t in types.keys():
    each = t.split('/')
    if len(each)>1:
        nodeType = "SAM%s%s" % (each[0], each[1].capitalize())
        exec( 'class %s(samAssetNode):\n pass' % nodeType)

        IECore.registerRunTimeTyped( eval(nodeType), typeName = "Gaffer::%s" % nodeType )
        Gaffer.Metadata.registerNodeValue( eval(nodeType), "nodeGadget:color", types.color(t) )
