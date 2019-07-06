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



import IECore
import Gaffer
import GafferUI
import pipe

# find images using GAFFERUI_IMAGE_PATHS search path for our
# dialogs
def pipeImage(op):
    if type(op) == type(''):
        opName = op
    else:
        opName = op.path
    opImage = "%s/opa.png" % pipe.name()
    if opName:
        import os
        image = "%s/opa_%s.png" % (pipe.name(), '_'.join(opName.split('/')).replace('%s' % pipe.name(),''))
        search = IECore.SearchPath( os.environ.get( "GAFFERUI_IMAGE_PATHS", "" ), ":" )
        image = search.find(image)
        if image:
            opImage = image
    return  GafferUI.Image( opImage )

# disable standard op previewers from main gaffer
class disable( GafferUI.DeferredPathPreview ) :
    def __init__( self, path ) :
        self.__column = GafferUI.ListContainer( borderWidth = 8 )
        GafferUI.DeferredPathPreview.__init__( self, self.__column, path )
        self._updateFromPath()

    def isValid( self ) :
        return False

    def _load( self ) :
        return self.getPath().info()

    def _deferredUpdate( self, o ) :
       pass
GafferUI.PathPreviewWidget.registerType( "Op", disable )
#GafferUI.PathPreviewWidget.registerType( "Info", disable )


## new op mode for browser!
class OpaMode( GafferUI.BrowserEditor.Mode ) :

    def __init__( self, browser, classLoader=None ) :
        GafferUI.BrowserEditor.Mode.__init__( self, browser )
        if classLoader is not None :
            self.__classLoader = classLoader
        else :
            self.__classLoader = IECore.ClassLoader.defaultOpLoader()

    def connect( self ) :
        GafferUI.BrowserEditor.Mode.connect( self )
        self.__pathSelectedConnection = self.browser().pathChooser().pathListingWidget().pathSelectedSignal().connect(
            Gaffer.WeakMethod( self.__pathSelected )
        )
        self.__contextMenuConnection  = self.browser().pathChooser().pathListingWidget().contextMenuSignal().connect(
            Gaffer.WeakMethod( self.__menu )
        )

    def disconnect( self ) :
        GafferUI.BrowserEditor.Mode.disconnect( self )
        self.__pathSelectedConnection = None

    def _initialPath( self ) :
        return Gaffer.ClassLoaderPath( self.__classLoader, "/" )

    def _initialDisplayMode( self ) :
        return GafferUI.PathListingWidget.DisplayMode.Tree

    def _initialColumns( self ) :
        return [ GafferUI.PathListingWidget.defaultNameColumn ]

    def __pathSelected( self, pathListing ) :
        selectedPaths = pathListing.getSelectedPaths()
        if not len( selectedPaths ) :
            return

        op = selectedPaths[0].classLoader().load( str( selectedPaths[0] )[1:] )()
        opaDialogue = opaClasses.OpaDialogue( op )
        pathListing.ancestor( GafferUI.Window ).addChildWindow( opaDialogue )
        opaDialogue.setVisible( True )

    def __opDialogueCommand( self, op ) :
        def showDialogue( menu ) :
            dialogue = opaClasses.OpaDialogue( op )
            dialogue.waitForResult( parentWindow = menu.ancestor( GafferUI.Window ) )


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

        return showDialogue

# add the new mode in the browser main window!
#GafferUI.BrowserEditor.registerMode( "Opa Scripts", OpaMode )
#GafferUI.BrowserEditor.OpaMode = OpaMode

# patch op dialog!
class OpaDialogue(GafferUI.OpDialogue):
    def __init__( self, opInstance, title=None, opName="", sizeMode=GafferUI.Window.SizeMode.Manual, **kw ) :
        GafferUI.OpDialogue.__init__( self, opInstance, title, sizeMode, **kw )
        layout = self._getWidget().parent()
        layout.insert(0,
            pipeImage(opName)
        )
        # resize the dialog to a better default size!
        self._qtWidget().resize(600,700)

#        self.farmButton = self._addButton( "Run in the Farm" )
#        self.__farmButtonClickedConnection = self.farmButton.clickedSignal().connect( 0, Gaffer.WeakMethod( self.__initiateExecution ) )

#    def __initiateExecution(self, *unused ):
#        GafferUI.OpDialogue.__initiateExecution(self, *unused )

#    def __finishExecution( self, result ) :

#        if isinstance( result, IECore.Object ) :
#            # no error from normal execution, so run the farm method!
#            print result.parameters().keys()
#            result.doFarmOperation()

#        GafferUI.OpDialogue.__finishExecution(self, result)

# gaffer browser preview!!
class OpaPathPreview( GafferUI.DeferredPathPreview ) :
    def __init__( self, path ) :
        self.__column = GafferUI.ListContainer( borderWidth = 8 )
        GafferUI.DeferredPathPreview.__init__( self, self.__column, path )
        self._updateFromPath()

    def isValid( self ) :
        path = self.getPath()
        if not isinstance( path, Gaffer.ClassLoaderPath ) :
            return False

        if hasattr( path.classLoader(), "classType" ) :
            if not issubclass( path.classLoader().classType(), IECore.Op ) :
                return False
        else :
            if path.classLoader().searchPath() != IECore.ClassLoader.defaultOpLoader().searchPath() :
                return False
        return path.isLeaf()

    def _load( self ) :
        return self.getPath().load()()

    def _deferredUpdate( self, op ) :
        del self.__column[:]
        self.__node = Gaffer.ParameterisedHolderNode()
        self.__node.setParameterised( op )

        with self.__column :
            pipeImage(op)
            GafferUI.NodeUI.create( self.__node )

            button = GafferUI.Button( "Execute" )
            self.__executeClickedConnection = button.clickedSignal().connect( self.__executeClicked )

    def __executeClicked( self, button ) :
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            self.__node.getParameterised()[0]()

GafferUI.PathPreviewWidget.registerType( "Opa", OpaPathPreview )
