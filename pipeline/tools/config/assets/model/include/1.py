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
import pipe

try:
    import maya.cmds as m
    m.ls()
except:
    m = None

class model( IECore.Op ) :

    def __init__( self, prefix='') :
        IECore.Op.__init__( self, "Publish model assets.",
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

        self.prefix = prefix
        currentUser = pipe.admin.job.shot.user()

        source = IECore.FileNameParameter(
            name="%sMesh" % prefix,
            description = "type the path for the models",
            defaultValue = "",
            allowEmptyString=False,
            userData = {
                'dataName' : IECore.StringData('meshPrimitives'),
                'updateFromApp':IECore.BoolData( True ),
            }
        )

        self.parameters().addParameters(
            [
                source,
                IECore.FileNameParameter(
                    name="%sDependency" % prefix,
                    description = "Dependency file that created this model.",
                    allowEmptyString=False,
                    defaultValue = currentUser.path(),
                    userData = {
                        "UI": {
                            "defaultPath": IECore.StringData( "/atomo/jobs/" ),
                            "obeyDefaultPath" : IECore.BoolData(True),
                        },
                        # this UD flags this parameter to publish use to construct the asset filename
                        'assetPath':IECore.BoolData( True ),
                        'updateFromApp':IECore.BoolData( True ),
                        'dataName' : IECore.StringData('assetDependencyPath'),
                    }
                ),
                IECore.StringParameter("assetType","",prefix,userData={"UI":{ "visible" : IECore.BoolData(False) }}),
            ])

        self.__updateFromMaya()

    def __updateFromMaya(self):
        # if running in maya
        if m:
            selected = ','.join(m.ls(sl=1,l=1,tr=1));
            scene = m.file(q=1,sn=1)
            if not scene:
                self.canPublish = False

            self.parameters()["%sMesh"       % self.prefix].setValue(  IECore.StringData(selected) )
            self.parameters()["%sDependency" % self.prefix].setValue(  IECore.StringData(scene) )

    def doOperation( self, operands ) :
        result = 'done'
        return IECore.StringData( result )
