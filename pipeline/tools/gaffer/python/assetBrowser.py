# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently 
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================



import os
import re
import weakref
import threading

import IECore
import Gaffer
import GafferUI
import GafferSceneUI # for alembic previews

import pipe
import opaClasses
#import pipeBrowser
import Asset




def populateAssets(folderName='sam'):
    from glob import glob
    ret = {}
    try:
        j = pipe.admin.job()
    except:
        j=None
    if j:
        def recursiveTree(path, d={}):
            for each in glob( "%s/*" % path ):
                id = each.replace(path,'')[1:]
                if os.path.isdir(each):
#                    try:
#                        data = Asset.AssetParameter(each.replace(j.path('sam/'),'')).getData()
#                        id = id+" (%s)" % data['assetUser']
#                    except:
#                        pass
                    d[id] = {}
                    recursiveTree(each, d[id])
#                elif os.path.isfile(each):
#                    d[id] = False
            return d                    
                
        ret = recursiveTree("%s/sam" % j.path(), ret)
        print ret
    return ret


# gaffer browser preview!!
class assetPreview( GafferUI.DeferredPathPreview ) :
    def __init__( self, path ) :
        self.__column = GafferUI.ListContainer( borderWidth = 8 )
        GafferUI.DeferredPathPreview.__init__( self, self.__column, path )
        self._updateFromPath()   
        self.__classLoader = IECore.ClassLoader.defaultOpLoader(  )
#        self.__classLoader = IECore.ClassLoader.defaultLoader( "IECORE_ASSET_OP_PATHS" )
        self.jobs = populateAssets()
        self.__node = Gaffer.ParameterisedHolderNode()
        self.__op = self.__classLoader.load( "asset/gather" )()
        self.__node.setParameterised( self.__op )
        
            
    def type(self, path):
        return os.path.dirname(os.path.dirname(str(path)))
        
    def name(self, path):
        return os.path.basename(os.path.dirname(str(path)))
        
    def version(self, path):
        v = map( lambda x: int(x), os.path.basename(str(path)).split(' ')[0].split('.') )
        return IECore.V3i( v[0], v[1], v[2] )
        
    def isValid( self ) :
        path = self.type(str(self.getPath()))
        if not path:
            return False

        return path in Asset.AssetParameter().classLoader.classNames( "*" )
                
    def _load( self ) :
        return self.getPath()
    
    def _deferredUpdate( self, path ) :
        del self.__column[:]
        
        self.jobs = populateAssets()
        self.__node["parameters"]["Asset"]["type"].setValue( self.type(path) )
        self.__node["parameters"]["Asset"]["info"]["name"].setValue( self.name(path) )
        self.__node["parameters"]["Asset"]["info"]["version"].setValue( self.version(path) )
        
        data = Asset.AssetParameter(str(path).split(' ')[0]).getData()
        self.__node["parameters"]["Asset"]["info"]["description"].setValue( data['assetDescription'] )
        
        with self.__column :
            GafferUI.Image( "%s/opa.png" % pipe.name() )
            GafferUI.NodeUI.create( self.__node )
            
            button = GafferUI.Button( "Gather" )
            self.__executeClickedConnection = button.clickedSignal().connect( self.__executeClicked )

    def __executeClicked( self, button ) :
        self.__node.getParameterised()[0]()
            

class AssetMode(  GafferUI.BrowserEditor.Mode ) :

    def __init__( self, browser ) :
        GafferUI.BrowserEditor.Mode.__init__( self, browser )
        self.__classLoader = IECore.ClassLoader.defaultOpLoader()
                 
    def connect( self ) :
        GafferUI.BrowserEditor.Mode.connect( self )
        self.__contextMenuConnection = None
        self.__pathSelectedConnection = self.browser().pathChooser().pathListingWidget().pathSelectedSignal().connect( 
            Gaffer.WeakMethod( self.__pathSelected )
        )
        self.__contextMenuConnection  = self.browser().pathChooser().pathListingWidget().contextMenuSignal().connect( 
            Gaffer.WeakMethod( self.__menu )
        )
        
    def disconnect( self ) :
        GafferUI.BrowserEditor.Mode.disconnect( self )
        self.__pathSelectedConnection = None
        self.__contextMenuConnection = None
    
    def _initialDisplayMode( self ) :
        return GafferUI.PathListingWidget.DisplayMode.Tree
    
    def _initialColumns( self ) :
        return [ GafferUI.PathListingWidget.defaultNameColumn ]
            
    def __pathSelected( self, pathListing ) :
        selectedPaths = pathListing.getSelectedPaths()
        if not len( selectedPaths ) :
            return
            
        print selectedPaths[0]
#        op = selectedPaths[0].classLoader().load( str( selectedPaths[0] )[1:] )()
#        opaDialogue = opaClasses.OpaDialogue( op )
#        pathListing.ancestor( GafferUI.Window ).addChildWindow( opaDialogue )
#        opaDialogue.setVisible( True )

    def __menu( self, pathListing ) :
        print "XXXX:%s" % str(pathListing)
        menuDefinition = IECore.MenuDefinition()
        menuDefinition.append( "/%s " % str(dir(pathListing)), { "active" : True } )
        menuDefinition.append( "/%s " % str(dir(pathListing)), { "active" : True } )
        menuDefinition.append( "/%s " % str(dir(pathListing)), { "active" : True } )
        
#        if self.__opMatcher is not None :
        selectedPaths = pathListing.getSelectedPaths()
        if len( selectedPaths ) == 1 :
            parameterValue = selectedPaths[0]
        else :
            parameterValue = selectedPaths
        menuDefinition.append( "/Actions", { "subMenu" : IECore.curry( Gaffer.WeakMethod( self.__actionsSubMenu ), parameterValue ) } )

#        else :
#            menuDefinition.append( "/Loading actions...", { "active" : False } )

                
        self.__menu = GafferUI.Menu( menuDefinition )
        if len( menuDefinition.items() ) :
            self.__menu.popup( parent = pathListing.ancestor( GafferUI.Window ) )
        return True
            

    
    def _initialPath( self ) :
        return Gaffer.DictPath( populateAssets(), "" )
        
#    def _initialColumns( self ) :
#        return ['Job Name']

       
GafferUI.PathPreviewWidget.registerType( "Asset Preview", assetPreview )
GafferUI.BrowserEditor.registerMode( "SAM", AssetMode )
GafferUI.BrowserEditor.AssetMode = AssetMode

