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

import Gaffer

class matcher(Gaffer.OpMatcher):
    def matches( self, parameterValue ) :
        return ('ssss',parameterValue )

class PipeBrowserEditor( GafferUI.BrowserEditor, GafferUI.EditorWidget ) :
    ''' our generic pipeline browser'''
    def __init__( self, scriptNode, **kw ) :
        self.__column = GafferUI.ListContainer( borderWidth = 8, spacing = 6 )
        GafferUI.EditorWidget.__init__( self, self.__column, scriptNode, **kw )
        
        with self.__column :
            GafferUI.Image( "%s/pipeBrowser.png" % pipe.name() )
            with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal, spacing = 6 ) :
                GafferUI.Label( "Role" )
                modeMenu = GafferUI.SelectionMenu()
                for mode in self.__modes :
                    modeMenu.addItem( mode[0] )
                    
                self.__modeChangedConnection = modeMenu.currentIndexChangedSignal().connect( Gaffer.WeakMethod( self.__modeChanged ) )
        
            self.__pathChooser = GafferUI.PathChooserWidget( Gaffer.DictPath( {}, "/" ), previewTypes=GafferUI.PathPreviewWidget.types() )
            self.__pathChooser.pathWidget().setVisible( True )
            # turns the listmode and path string invisible!
            self.__pathChooser.directoryPathWidget().parent().setVisible( True )
        
        self.__modeInstances = {}
        self.__currentModeInstance = None
        self.__modeChanged( modeMenu )

    ## Returns the PathChooserWidget which forms the majority of this ui.
    def pathChooser( self ) :
        return self.__pathChooser
    
    def __modeChanged( self, modeMenu ) :
        label = modeMenu.getCurrentItem()
        if label not in self.__modeInstances :
            for mode in self.__modes :
                if mode[0] == label :
                    self.__modeInstances[label] = mode[1]( self )
                    break

        if self.__currentModeInstance is not None :
            self.__currentModeInstance.disconnect()
        
        self.__currentModeInstance = self.__modeInstances[label]
        self.__currentModeInstance.connect()
    
#    def _createOpMatcher( self ) :
#        return matcher()
            
    __modes = []
    @classmethod
    def registerMode( cls, label, modeCreator ) :
        # first remove any existing modes of the same label
        cls.__modes = [ m for m in cls.__modes if m[0] != label ]
        cls.__modes.append( ( label, modeCreator ) )
        
#GafferUI.EditorWidget.registerType( "PipeBrowserEditor", PipeBrowserEditor )	
#GafferUI.EditorWidget.registerType( "Browser", PipeBrowserEditor )

# replace default browser class by our custom pipe one!
#GafferUI.BrowserEditor = PipeBrowserEditor	
