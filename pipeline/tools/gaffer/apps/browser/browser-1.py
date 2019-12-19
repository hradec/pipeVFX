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

import IECore
import Gaffer
import GafferUI
import GafferSceneUI # for alembic previews

import assetBrowser, jobManager, opaClasses

if hasattr(IECore,'Color3f'):
	from IECore import Color3f
else:
	from imath import Color3f



class BrowserEditorAtomo(GafferUI.BrowserEditor):
	@classmethod
	def registerMode( cls, label, modeCreator ) :
		# first remove any existing modes of the same label
		cls._BrowserEditor__modes = [ m for m in cls._BrowserEditor__modes if m[0] != label ]
		cls._BrowserEditor__modes.append( ( label, modeCreator ) )

	@classmethod
	def unregisterMode( cls, label ) :
		# remove any existing modes of the same label
		cls._BrowserEditor__modes = [ m for m in cls._BrowserEditor__modes if m[0] != label ]

GafferUI.Editor.registerType( "Atomo Browser", BrowserEditorAtomo )
BrowserEditorAtomo.unregisterMode( "File Sequences" )
BrowserEditorAtomo.unregisterMode( "Files" )
BrowserEditorAtomo.unregisterMode( "Ops" )
BrowserEditorAtomo.registerMode( "Job Management", jobManager.JobMode )
BrowserEditorAtomo.JobMode = jobManager.JobMode
BrowserEditorAtomo.registerMode( "SAM", assetBrowser.AssetMode )
BrowserEditorAtomo.AssetMode = assetBrowser.AssetMode



class browser( Gaffer.Application ) :
	def __init__( self ) :
		Gaffer.Application.__init__( self )
		self.parameters().addParameters(
			[IECore.PathParameter(
				"initialPath",
				"The path to browse to initially",
				"",
				allowEmptyString = True,
				check = IECore.PathParameter.CheckType.MustExist,
			)]
		)
		self.parameters().userData()["parser"] = IECore.CompoundObject({
			"flagless" : IECore.StringVectorData( [ "initialPath" ] )
		})

	def _run( self, args ) :
		import pipe
		QtWidgets = pipe.importQt('QtWidgets')

		style = GafferUI.StandardStyle()
		style.setColor( style.Color.BackgroundColor, Color3f( 0.5, 0.5, 0.5 ) )
		# print style
		# print dir(style)
		# print style.renderText()

		self.root()["scripts"]["script1"] = Gaffer.ScriptNode()

		with GafferUI.Window( "Atomo Gaffer Browser" ) as window :
			browser = BrowserEditorAtomo( self.root()["scripts"]["script1"] )

		if args["initialPath"].value :
			initialPath = os.path.abspath( args["initialPath"].value )
			browser.pathChooser().getPath().setFromString( initialPath )

		# add image header
		# window._setStyleSheet( style )
		window._qtWidget().setStyleSheet('*[gafferClasses~="GafferUI.Window"] { background-color:#555; }')
		# browser._BrowserEditor__column._qtWidget().setStyleSheet(style)
		browser._BrowserEditor__column.insert(0,opaClasses.pipeImage("opa"))

		# centre the window on the primary screen at 3/4 size.
		## \todo Implement save/restore of geometry, and do all this without using Qt APIs
		# in the app itself.
		desktop = QtWidgets.QApplication.instance().desktop()
		geometry = desktop.availableGeometry()
		adjustment = geometry.size() / 8
		geometry.adjust( adjustment.width(), adjustment.height(), -adjustment.width(), -adjustment.height() )
		window._qtWidget().setGeometry( geometry )


		window.setVisible( True )

		GafferUI.EventLoop.mainEventLoop().start()

		return 0

IECore.registerRunTimeTyped( browser )
