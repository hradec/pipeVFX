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

##########################################################################
#
#  Copyright (c) 2012, Image Engine Design Inc. All rights reserved.
#  Copyright (c) 2012, John Haddon. All rights reserved.
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

import os

import IECore
import Gaffer
import GafferUI
import GafferSceneUI # for alembic previews
import samEditor
import assetBrowser
import genericAsset

# if genericAsset.m:
#     reload(samEditor)
#     reload(assetBrowser)

class sam( Gaffer.Application ) :

    def __init__( self ) :

        Gaffer.Application.__init__( self )

        self.hostApp = genericAsset.hostApp

        self.parameters().addParameters(

            [
                IECore.StringParameter(
                    "initialPath",
                    "The path to browse to initially",
                    "",
                    # allowEmptyString = True,
                    # check = IECore.PathParameter.CheckType.MustExist,
                ),
                IECore.StringParameter(
                    "type",
                    "only shows assets of the specified type",
                    "",
                ),
                IECore.StringParameter(
                    "action",
                    "select the action mode for sam: import or publish",
                    "import",
                ),
                IECore.StringParameter(
                    "buttons",
                    "specify the asset types to show create buttons for, separated by comma.",
                    "",
                ),
                IECore.StringParameter(
                    "debug",
                    "",
                    "",
                ),
                IECore.StringParameter(
                    "asset",
                    "",
                    "",
                ),
                IECore.StringParameter(
                    "hostApp",
                    "",
                    "maya",
                ),
            ]

        )

        self.parameters().userData()["parser"] = IECore.CompoundObject(
            {
                "flagless" : IECore.StringVectorData( [ "initialPath" ] )
            }
        )

    def _run( self, args ) :
        import os
        if 'OCIO' in os.environ:
            del os.environ['OCIO']

        self.root()["scripts"]["script1"] = Gaffer.ScriptNode()


        title=''
        if 'PIPE_JOB' in os.environ:
            title = '%s/%s' % ( os.environ['PIPE_JOB'], os.environ['PIPE_SHOT'].replace('@','/') )

        with GafferUI.Window( "SAM" ) as GafferUI.window :
            self.browser = samEditor.SamEditor(
                self.root()["scripts"]["script1"],
                args=args,
                type=args["type"].value,
                action=args["action"].value,
                buttons=args["buttons"].value,
                debug=args["debug"].value,
                jobShot=title,
                asset=args["asset"].value,
                hostApp=args["hostApp"].value,
            )

        if args["initialPath"].value :
            initialPath = os.path.abspath( args["initialPath"].value )
            self.browser.pathChooser().getPath().setFromString( initialPath )

        if args["action"].value :
            if 'import' in str(args["action"].value) :
                GafferUI.window._qtWidget().resize( 1200, 800 )
            else:
                GafferUI.window._qtWidget().resize( 1200, 800 )
        else:
            GafferUI.window._qtWidget().resize( 1200, 800 )

        # desktop = QtGui.QApplication.instance().desktop()
        # geometry = desktop.availableGeometry()
        # adjustment = geometry.size() / 8
        # geometry.adjust( adjustment.width(), adjustment.height(), -adjustment.width(), -adjustment.height() )
        # self.__window._qtWidget().setGeometry( geometry )

        GafferUI.window.setVisible( True )


        try:
            GafferUI.EventLoop.mainEventLoop().start()
        except: pass



        return 0


    def __dialogueClosed( self, dialogue ) :
        try:
            import maya.cmds as m
            from maya.mel import eval as meval
            reload(Asset)
            # m.ls()
            GafferUI.EventLoop.mainEventLoop().stop()
        except:
            m = None



IECore.registerRunTimeTyped( sam )
