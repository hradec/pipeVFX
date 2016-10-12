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
    from maya.mel import eval as meval
    m.ls()
except:
    m = None


class render( IECore.Op ) :
    
    def __init__( self, prefix='', ext='', basePath='', extra_parameters=[],fileNameParameterType=None ) :
        
        class RenderFileParameter(IECore.FileNameParameter):
            def valueValid(self, *args):
        #                ret = IECore.FileNameParameter.valueValid(self, *args)
                ret = (True,'')
                if args:
                    argExt = os.path.splitext(str(args[0]))[1].lower()
                    print argExt
                    print map(lambda x: '.%s' % x, ext.split(','))
                    if argExt not in map(lambda x: '.%s' % x, ext.split(',')):
                        ret = (False, 'Extensions %s not allowed!' % argExt)
                    
                print args
                print ret
                return ret
                
        IECore.Op.__init__( self, "Publish %s assets." % self.__class__,
            IECore.Parameter(
                name = "result",
                description = "",
                defaultValue = IECore.StringData(""),
                userData = {"UI" : {
                    "showResult" : IECore.BoolData( False ),
                    "showCompletionMessage" : IECore.BoolData( True ),
                    "saveResult" : IECore.BoolData( False ),
                }},
            )
        )

        
        output = pipe.output()
        outputDefault = output.labels()[0]
        
        j = pipe.admin.job()
        jobData = j.getData()
        if jobData.has_key('output'):
            outputDefault = jobData['output']

        currentUser = pipe.admin.job.shot.user()
        
        scene = basePath
        if basePath[0] != '/':
            scene = currentUser.path(basePath)
        if m:
            scene = m.file(q=1,sn=1)
            if not scene:
                raise Exception("\nERROR: A Cena precisa ser salva antes de ser publicada!")

        
        self.parameters().addParameters(
            [
                IECore.FileNameParameter(
                    name="%sScene" % prefix,
                    description = "Scene to render. It can be Maya, Nuke or Gaffer!",
                    defaultValue = scene,
                    allowEmptyString=False,
                    check = IECore.FileNameParameter.CheckType.MustExist,
                    extensions = ext,
                    userData = {
                        'assetPath':IECore.BoolData( True ),
#                        "UI":{ "invertEnabled" : IECore.BoolData(False) },
                    }
                ),
                IECore.StringParameter(
                    name="%sOutput" % prefix,
                    description = "Configuracao do render output.",
                    defaultValue = outputDefault ,
                    presets = output.asPreset(),
                    presetsOnly = True,
#                    userData = extraUI
                ),
                IECore.StringParameter("assetType","",prefix,userData={"UI":{ "visible" : IECore.BoolData(False) }}),
            ])
        if extra_parameters:
            self.parameters().addParameters( extra_parameters )

    def doOperation( self, operands ) :
        result = 'done'
        return IECore.StringData( result )


