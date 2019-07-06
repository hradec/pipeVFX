

import os
import weakref
import threading

import IECore

import Gaffer
import GafferUI


class AssetChooserWidget(GafferUI.PathChooserWidget):
	def __init__( self, path, previewTypes=[], allowMultipleSelection=False, bookmarks=None, **kw ) :


		# GafferUI.PathChooserWidget( self, path, previewTypes, allowMultipleSelection, bookmarks, kw )


		self.__column = GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Vertical, spacing=8 )

		GafferUI.Widget.__init__( self, self.__column, **kw )

		# we use this temporary path for our child widgets while constructing, and then call
		# self.setPath() to replace it with the real thing. this lets us avoid duplicating the
		# logic we need in setPath().
		tmpPath = Gaffer.DictPath( {}, "/" )
		with self.__column :

			# row for manipulating current directory
			with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal, spacing = 4 ) :

				self.__displayModeButton = GafferUI.Button( image = "pathListingTree.png", hasFrame=False )
				self.__displayModeButton.setToolTip( "Toggle between list and tree views" )
				self.__displayModeButtonClickedConnection = self.__displayModeButton.clickedSignal().connect( Gaffer.WeakMethod( self.__displayModeButtonClicked ) )

				self.__bookmarksButton = GafferUI.MenuButton(
					image = "bookmarks.png",
					hasFrame=False,
					menu = GafferUI.Menu( Gaffer.WeakMethod( self.__bookmarksMenuDefinition ) ),
				)
				self.__bookmarksButton.setToolTip( "Bookmarks" )
				self.__bookmarksButtonDragEnterConnection = self.__bookmarksButton.dragEnterSignal().connect( Gaffer.WeakMethod( self.__bookmarksButtonDragEnter ) )
				self.__bookmarksButtonDragLeaveConnection = self.__bookmarksButton.dragLeaveSignal().connect( Gaffer.WeakMethod( self.__bookmarksButtonDragLeave ) )
				self.__bookmarksButtonDropConnection = self.__bookmarksButton.dropSignal().connect( Gaffer.WeakMethod( self.__bookmarksButtonDrop ) )

				reloadButton = GafferUI.Button( image = "refresh.png", hasFrame=False )
				reloadButton.setToolTip( "Refresh view" )
				self.__reloadButtonClickedConnection = reloadButton.clickedSignal().connect( Gaffer.WeakMethod( self.__reloadButtonClicked ) )

				upButton = GafferUI.Button( image = "pathUpArrow.png", hasFrame=False )
				upButton.setToolTip( "Up one level" )
				self.__upButtonClickedConnection = upButton.clickedSignal().connect( Gaffer.WeakMethod( self.__upButtonClicked ) )

				GafferUI.Spacer( IECore.V2i( 2, 2 ) )

				self.__dirPathWidget = GafferUI.PathWidget( tmpPath )

			# directory listing and preview widget
			with GafferUI.SplitContainer(
				GafferUI.SplitContainer.Orientation.Horizontal,
				parenting = { "expand" : True }
			) as splitContainer :
				with GafferUI.ListContainer( GafferUI.ListContainer.Orientation.Horizontal, spacing=8 ) as self.directoryLayout:
							 self.__directoryListing = GafferUI.PathListingWidget( tmpPath, allowMultipleSelection=allowMultipleSelection )
				self.__displayModeChangedConnection = self.__directoryListing.displayModeChangedSignal().connect( Gaffer.WeakMethod( self.__displayModeChanged ) )
				if len( previewTypes ) :
					self.__previewWidget = GafferUI.CompoundPathPreview( tmpPath, childTypes=previewTypes )
				else :
					self.__previewWidget = None

			if len( splitContainer ) > 1 :
				splitContainer.setSizes( [ 2, 1 ] ) # give priority to the listing over the preview

			# filter section
			self.__filterFrame = GafferUI.Frame( borderWidth=0, borderStyle=GafferUI.Frame.BorderStyle.None )
			self.__filter = None

			# path
			self.__pathWidget = GafferUI.PathWidget( tmpPath )
			self.__pathWidget.setVisible( allowMultipleSelection == False )

		self.__pathSelectedSignal = GafferUI.WidgetSignal()

		self.__listingSelectionChangedConnection = self.__directoryListing.selectionChangedSignal().connect( Gaffer.WeakMethod( self.__listingSelectionChanged ) )
		self.__listingSelectedConnection = self.__directoryListing.pathSelectedSignal().connect( Gaffer.WeakMethod( self.__pathSelected ) )
		self.__pathWidgetSelectedConnection = self.__pathWidget.activatedSignal().connect( Gaffer.WeakMethod( self.__pathSelected ) )

		self.__path = None
		self.setPath( path )
		self.setBookmarks( bookmarks )
