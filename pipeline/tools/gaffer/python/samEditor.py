##########################################################################
#
#  Copyright (c) 2012-2014, Image Engine Design Inc. All rights reserved.
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
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THISp
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

import os, sys, random, pipe
from glob import glob
import weakref
import threading

import IECore

import Gaffer
import GafferUI

import Asset
# reload(Asset)

QtCore = GafferUI._qtImport( "QtCore" )

# from assetChooserWidget import *

class SamEditor( GafferUI.BrowserEditor ) :
    class __buttons(dict):
        def show(self, b=None):
            if b:
                dict.__getitem__(self,b).setVisible(True)
            else:
                for b in self.keys():
                    dict.__getitem__(self,b).setVisible(True)
        def hide(self, b=None):
            if b:
                dict.__getitem__(self,b).setVisible(False)
            else:
                for b in self.keys():
                    dict.__getitem__(self,b).setVisible(False)

    def __init__( self, scriptNode, **kw ) :

        self.__column = GafferUI.ListContainer( borderWidth = 8, spacing = 6 )

        GafferUI.EditorWidget.__init__( self, self.__column, scriptNode )

        self.kw = kw
        self.setFilter("")
        for each in kw:
            self.__dict__['_'+each] = str(kw[each]).strip()

        self.setFilter(self._type)

        with self.__column :
            with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal, spacing = 6 ) as layout:
                # add a job/shot label
                header = GafferUI.GridContainer( 0, 0 )
                header.addChild( GafferUI.Label( "<img src='%s/gaffer/graphics/atomo/opa.png'>" %  ( pipe.roots.tools() ) ), (0,0) )
                header.addChild( GafferUI.Spacer(IECore.V2i(10,10)), (1,0) )
                header.addChild( GafferUI.Label( '<h1 style="text-align: right;color:#202020;font-family:sans-serif;font-style:italic;">%s  </h1>' %  ( '/ job / '+self._jobShot.replace('/',' / ') ) ), (2,0) )
                samIcons = glob( '%s/gaffer/graphics/sam-??.png' %  pipe.roots.tools() )
                imgSize = 80
                imgNum = len(samIcons)-1
                self.samIcon = GafferUI.Button( "", "sam-%02d.png" % (int(random.random()*imgNum)+1), toolTip="Click here to REFRESH!" )
                self.samIcon._qtWidget().setMaximumSize( imgSize, imgSize )
                self.samIcon.setHighlighted(False)
                def imgHeader(b):
                    try:
                        b.setImage("sam-%02d.png" % (int(random.random()*imgNum)+1))
                        b.setHighlighted(False)
                    except:
                        if self.timer:
                            self.timer.stop()

                def samIconButton(b):
                    imgHeader(self.samIcon)
                    self.refresh()


                self.__headerImg = self.samIcon.clickedSignal().connect( samIconButton )
                header.addChild( self.samIcon, (3,0) )

                self.timer = QtCore.QTimer()
                self.timer.timeout.connect(lambda: imgHeader(self.samIcon))
                self.timer.start(10000)

                # header.

                modeMenu = GafferUI.MultiSelectionMenu(
                    allowMultipleSelection = False,
                    allowEmptySelection = False,
                )
                for mode in self.__modes :
                    modeMenu.append( mode[0] )
                self.__modeChangedConnection = modeMenu.selectionChangedSignal().connect(  Gaffer.WeakMethod( self.__modeChanged ) )

            self.__pathChooser = GafferUI.PathChooserWidget( Gaffer.DictPath( {}, "/" ), previewTypes=GafferUI.PathPreviewWidget.types(), allowMultipleSelection=False )
            self.__pathChooser.pathWidget().setVisible( False )


            # add a listContainer to booth sides of the splitContainer that handles the pathList and the preview,
            # so we can add stuff to booth sides!
            self._splitContainer      = self.__pathChooser.pathListingWidget().ancestor( GafferUI.SplitContainer )
            self._previewListColum   = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical, spacing=6 )
            self._previewListColum.append( self._splitContainer[1] )
            self._splitContainer.append( self._previewListColum )

            self._pathListColum   = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical, spacing=0 )
            self._pathListColum.append( self._splitContainer[0] )
            self._splitContainer.insert( 0, self._pathListColum )


            # add a listContainer to add our create buttons
            with self._splitContainer[0]:
                pathButtonRow   = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical, spacing=0 )

            # create buttons for each asset type
            self.buttons = self.__buttons()
            self.__buttonsSignals = []
            for b in Asset.types(): #['render/maya', 'animation/alembic', 'particle/nParticles']:
                self.buttons[b] = GafferUI.Button( "Create a NEW %s asset" % b  ) #, "arrowRight10.png" )
                pathButtonRow.append(self.buttons[b])
                self.__buttonsSignals.append( self.buttons[b].clickedSignal().connect( Gaffer.WeakMethod( self.createButton ) ) )
                self.buttons[b].type = b
            if not self._debug:
                # hide then by default
                self.buttons.hide()


            # show the ones specified in the buttons parameter, separated by comma
            if self._buttons:
                for each in self._buttons.split(','):
                    self.buttons.show(each.strip())

            # self.__pathChooser.setVisible( False )

        self.__modeInstances = {}
        self.__currentModeInstance = None
        self.modeMenu = modeMenu

        self.modeMenu.setSelection( [ self.__modes[0][0] ] )
        self.modeMenu.setVisible(False)

    def createButton(self, b):
        with GafferUI.ErrorDialogue.ExceptionHandler( parentWindow=self.ancestor( GafferUI.Window ) ) :
            os.environ['PIPE_PUBLISH_FILTER'] = b.type
            appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
            appLoader.classNames()
            app=appLoader.load( 'opa' )()
            app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type',b.type,'1','IECORE_ASSET_OP_PATHS'])
            app.parameters()['op'] = 'publish'
            app.parameters()['gui'] = 1
            try: app.run()
            except: pass
            # self.ancestor( GafferUI.Window ).close()


    def refresh(self):
        self.__currentModeInstance.refresh()
        self.__modeChanged(self.modeMenu)


    def filter(self):
        return self._filter

    def type(self):
        return self._filter

    def setFilter(self, f):
        self._filter = str(f)

    ## Returns the PathChooserWidget which forms the majority of this ui.
    def pathChooser( self ) :

        return self.__pathChooser

    def __repr__( self ) :

        return "GafferUI.SamEditor( scriptNode )"

    def __modeChanged( self, modeMenu ) :

        label = modeMenu.getSelection()[0]
        if label not in self.__modeInstances :
            for mode in self.__modes :
                if mode[0] == label :
                    self.__modeInstances[label] = mode[1]( self )
                    break

        if self.__currentModeInstance is not None :
            self.__currentModeInstance.disconnect()

        self.__currentModeInstance = self.__modeInstances[label]
        self.__currentModeInstance.connect()

    class Mode( GafferUI.BrowserEditor.Mode ) :

        def __init__( self, browser, splitPosition = 0.5 ) :
            self.__browser = weakref.ref( browser ) # avoid circular references
            self.__directoryPath = None
            self.__displayMode = None
            self.__splitPosition = splitPosition

        	# create the op matcher on a separate thread, as it may take a while to trawl
        	# through all the available ops.
            self.__opMatcher = None
        	# threading.Thread( target = self.__createOpMatcher ).start()

        def browser( self ) :

        	return self.__browser()

        def connect( self ) :
            GafferUI.BrowserEditor.Mode.connect(self)

            self.browser().pathChooser().directoryPathWidget().parent().setVisible(False)

            splitContainer = self.browser().pathChooser().pathListingWidget().ancestor( GafferUI.SplitContainer )
            self.browser().pathChooser().pathListingWidget()._qtWidget().setMinimumSize( 270, 400 )
            self.browser().pathChooser().pathListingWidget()._qtWidget().setMaximumSize( 270, 1400 )
            splitContainer.setSizes( ( 0.05, 0.95 ) )
            splitContainer.browser = self.browser

        ## Must be implemented by derived classes to return the initial directory path to be viewed.
        def _initialPath( self ) :

            raise NotImplementedError

        ## May be reimplemented by derived classes to change the initial display mode of the path listing
        def _initialDisplayMode( self ) :

            return GafferUI.PathListingWidget.DisplayMode.Tree

        ## Must be reimplemented by derived classes to specify the columns to be displayed in the PathListingWidget.
        def _initialColumns( self ) :

            raise NotImplementedError

        ## May be reimplemented by derived classes to return a custom OpMatcher to be used
        # to provide action menu items for the ui.
        def _createOpMatcher( self ) :

            return None

        def __contextMenu( self, pathListing ) :
            return self._menu(pathListing)

        def importAsset( self, parameterValue) :
            print  '===>',parameterValue



    __modes = []
    @classmethod
    def registerMode( cls, label, modeCreator ) :

        # first remove any existing modes of the same label
        cls.__modes = [ m for m in cls.__modes if m[0] != label ]

        cls.__modes.append( ( label, modeCreator ) )

# GafferUI.EditorWidget.registerType( "SamEditor", SamEditor )






# class FileSystemMode( SamEditor.Mode ) :
#
# 	def __init__( self, browser ) :
#
# 		SamEditor.Mode.__init__( self, browser )
#
# 	def _initialPath( self ) :
#
# 		return Gaffer.FileSystemPath(
# 			os.getcwd(),
# 			filter = Gaffer.FileSystemPath.createStandardFilter(),
# 		)
#
# 	def _initialColumns( self ) :
#
# 		return list( GafferUI.PathListingWidget.defaultFileSystemColumns )
#
# SamEditor.registerMode( "Files", FileSystemMode )
# SamEditor.FileSystemMode = FileSystemMode
#
#
#
#
#
#
#
# class FileSequenceMode( SamEditor.Mode ) :
#
# 	def __init__( self, browser ) :
#
# 		SamEditor.Mode.__init__( self, browser )
#
# 	def connect( self ) :
#
# 		SamEditor.Mode.connect( self )
#
# 		# we want to share our bookmarks with the non-sequence filesystem paths
# 		self.browser().pathChooser().setBookmarks(
# 			GafferUI.Bookmarks.acquire(
# 				self.browser().scriptNode(),
# 				pathType = Gaffer.FileSystemPath
# 			)
# 		)
#
# 	def _initialPath( self ) :
#
# 		return Gaffer.SequencePath(
# 			Gaffer.FileSystemPath( os.getcwd() ),
# 			filter = Gaffer.FileSystemPath.createStandardFilter(),
# 		)
#
# 	def _initialColumns( self ) :
#
# 		return list( GafferUI.PathListingWidget.defaultFileSystemColumns )
#
# SamEditor.registerMode( "File Sequences", FileSequenceMode )
# SamEditor.FileSequenceMode = FileSequenceMode
