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
import os, datetime, sys, tempfile
import pipe

try:
    import maya.cmds as m
    m.ls()
except:
    m = None

class nParticles( IECore.Op ) :
    
    def __init__( self, prefix='nParticle' ) :
        IECore.Op.__init__( self, "Publish nParticles assets.",
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
        scene = currentUser.path()
        
        # get framerange!
        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}
        start = 0
        end = 10
        byFrameStep = 1
        override = 0
        if m:
            override = 1
            start = m.getAttr('defaultRenderGlobals.startFrame')
            end = m.getAttr('defaultRenderGlobals.endFrame')
            byFrameStep = m.getAttr('defaultRenderGlobals.byFrameStep')        
            
        # if running in maya
        selected = ""
        if m:
            selected = ','.join(m.ls(sl=1,l=1,dag=1,type=prefix));
            scene = m.file(q=1,sn=1)
            if not scene:
                raise Exception("ERROR: A Cena precisa ser salva antes de ser publicada!")
                
        source = IECore.FileNameParameter(
            name="%sNodes" % prefix,
            description = "type the path for the %sNodes node to cache"  % prefix,
            defaultValue = selected,
            allowEmptyString=False,
        )

        self.parameters().addParameters(
            [
                source, 
                IECore.FileNameParameter(
                    name="%sDependency" % prefix,
                    description = "Dependency file that created this model.",
                    allowEmptyString=False,
                    defaultValue = scene ,
                    userData = { 
                        "UI": {
                            "defaultPath": IECore.StringData( "/atomo/jobs/" ),
                            "obeyDefaultPath" : IECore.BoolData(True),
                        },
                        # this UD flags this parameter to publish use to construct the asset filename
                        'assetPath':IECore.BoolData( True ), 
                    }
                ),
                IECore.StringParameter("assetType","",self.__class__.__name__,userData={"UI":{ "visible" : IECore.BoolData(True) }}),                
            ])
        

        
        self.parameters().addParameters([
            IECore.CompoundParameter("FrameRange","",[   
                IECore.V3fParameter("range","Inicio, fim e 'step' da sequencia a ser rendida.",IECore.V3f(start, end, byFrameStep), userData=disabled),
            ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}}),
        ])
        
#        default = IECore.PointsPrimitive()
#        # if we're in maya, and theres a particle node selected, use it as default!
#        if m:
#            s = m.ls( type='shape', dag=1, sl=1)
#            if s:
#                if 'particle' in str(m.nodeType(s[0])).lower():
#                    default=s[0]
                
#        source = IECore.PointsPrimitiveParameter(
#            name="%sParticles" % prefix,
#            description = "connect a particle node here (ex: in maya, particleShape or nParticleShape nodes)",
#            defaultValue = default,
#            userData = { "UI": {
#                "collapsed": IECore.BoolData(True),
#            }}
#        )

    def publishFile(self, publishFile, parameters):
        frameRange = parameters['Asset']['type']['FrameRange']['range'].value
        path = os.path.dirname(publishFile)
        name = os.path.splitext(os.path.basename(publishFile))[0]
        file = "%s/%s.%%04d.mc" % (path, name)
        files = map(lambda x: file % x, range(frameRange[0],frameRange[1],frameRange[2]))
        return file
    
    
    def doOperation( self, operands ) :
        result = 'done'
        frameRange   = operands['FrameRange']['range'].value
        meshPrimitives = operands["%sNodes" % self.prefix].value.split(',')
        tmpFileName = tempfile.mkstemp()[1]
        self.data['assetPath'] = "%sFrame%%d.mc" % tmpFileName
        self.data['multipleFiles'] = range(frameRange[0],frameRange[1]+1)
        self.data['nodes'] = meshPrimitives

        
        if m:
            m.cycleCheck(e=0)      
            m.cacheFile(
                dtf                 =1,
                format              ="OneFilePerFrame",
                fileName            =os.path.basename(tmpFileName),
                directory           =os.path.dirname(tmpFileName),
                cacheableNode       =' '.join(meshPrimitives),                
                st                  =frameRange[0],
                et                  =frameRange[1],
            )
            
            # check if simulation finished susccefuly by looking for all the cached files!
            frames = self.data['multipleFiles'] 
            if len(filter(lambda x: os.path.exists(self.data['assetPath']%x), frames)) != len(frames):
                raise Exception("Simulation was cancelled by user interaction or some other unknown issue. Asset not published!!")

        else:
            raise Exception("We can only publish nParticles from within maya!")

        return IECore.StringData( result )


    def postPublish(self, operands, finishedSuscessfuly=False):
        # cleanup 
        sudo = pipe.admin.sudo()
        for f in self.data['multipleFiles']:
            sudo.rm( self.data['assetPath'] % f )
        sudo.run()
        
        if finishedSuscessfuly:
            if m:
                for each in self.data['nodes']:
                    if not m.objExists( "%s.pipe_asset" % each):
                        m.addAttr( each, ln="pipe_asset", dt="string" )
                    m.setAttr( "%s.pipe_asset" % each, self.data['publishPath'], type='string' )



IECore.registerRunTimeTyped( nParticles )