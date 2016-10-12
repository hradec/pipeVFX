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

import IECore, pipe, os
from IECore import *


try:
    import maya.cmds as m
    m.ls()
except:
    m = None



class delight( IECore.Op ) :
    
    def __init__( self ) :
        IECore.Op.__init__( self, str(self.__class__), IECore.Parameter(
                name = "result",
                description = "",
                defaultValue = IECore.StringData("Done"),
                userData = {"UI" : {
                    "showResult" : IECore.BoolData( True ),
                    "showCompletionMessage" : IECore.BoolData( True ),
                    "saveResult" : IECore.BoolData( True ),
                }},
            ))
        
        renderPasses = ["allRenderPasses"]
        if m:
            override = 1
            start = m.getAttr('defaultRenderGlobals.startFrame')
            end = m.getAttr('defaultRenderGlobals.endFrame')
            byFrameStep = m.getAttr('defaultRenderGlobals.byFrameStep')
            
            renderPasses = m.ls(type='delightRenderPass')
            
        
        
        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}
        
        pars = []
        for each in renderPasses:
            pars.append(
                IECore.BoolParameter(
                    name=each,
                    description = "Check this to render.",
                    defaultValue = IECore.BoolData(True),
                )
            )
                
        self.parameters().addParameters(pars)

    def doOperation( self, operands ):
        sceneName  = str(operands['mayaScene'])
        mayaOutput = str(operands['mayaOutput'])
        
        self.cmd = ' '.join([
            'run Render',
#            '-s %s -e %s' % (self.frameNumber(), self.frameNumber()),
            '-proj "%s"' % self.projectRoot(sceneName),
#            '-renderer "%s"' % self.renderer,
            '"%s"' % sceneName
        ])
        
        print self.cmd
#        os.system( self.cmd )
        
        return IECore.StringData( 'done' )

IECore.registerRunTimeTyped( delight )
