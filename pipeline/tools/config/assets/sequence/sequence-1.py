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
from glob import glob
import os, datetime, sys
import pipe, clients

try:
    import maya.cmds as m
    m.ls()
except:
    m = None

class sequence( IECore.Op ) :
    
    def __init__( self ) :
        IECore.Op.__init__( self, "Publish %s assets." % self.__class__,
            IECore.Parameter(
                name = "result",
                description = "",
                defaultValue = IECore.StringData("Done"),
                userData = {"UI" : {
                    "showResult" : IECore.BoolData( True ),
                    "showCompletionMessage" : IECore.BoolData( True ),
                    "saveResult" : IECore.BoolData( True ),
                }},
            )
        )

        currentUser = pipe.admin.job.shot.user()
        self.parameters().addParameters(
            [
#                IECore.FileNameParameter(
#                    name="dependency",
#                    description = "Dependencia que gerou esta sequencia.",
#                    allowEmptyString=True,
#                    defaultValue = currentUser.path(),
##                    userData = { "UI": {
##                        "defaultPath": IECore.StringData( currentUser.path() ),
##                        "obeyDefaultPath" : IECore.BoolData(True),
##                    }}
#                ),
                IECore.FileSequenceParameter(
                    name="sequence",
                    description = "Selecione uma sequencia de imagems.",
                    defaultValue = currentUser.path(),
                    allowEmptyString=False,
                ),
                IECore.StringParameter("assetType","",'sequence',userData={"UI":{ "visible" : IECore.BoolData(False) }}),

            ])

    def doOperation( self, operands ) :
        result = 'done'
        return IECore.StringData( result )

IECore.registerRunTimeTyped( sequence )
