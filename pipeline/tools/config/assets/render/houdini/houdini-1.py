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


import IECore, pipe
import os
exec( pipe.include( __file__ ) )


class houdini( render ) :

    def __init__( self ) :
        self._whoCanPublish = ['houdini']
        self._whoCanImport = ['maya','nuke','houdini']
        self._whoCanOpen = ["houdini"]


        import pickle as db
        pipe_root = pipe.roots.jobs()
        pipe_job = os.environ['PIPE_JOB']
        pipe_shot = os.environ['PIPE_SHOT'].split('@')[1]
        pipe_user = os.environ['USER']
        publish_data = '%s/%s/shots/%s/users/%s/houdini/.publish_data' % (
                        pipe_root,pipe_job,pipe_shot,pipe_user)

        hipfile='test'
        output_nodes=['test']
        start=0
        end=1
        if os.path.exists(publish_data):
            publish_settings = db.load(open(publish_data))
            hipfile = publish_settings['hipfile']
            output_nodes=publish_settings['output']
            start = int(publish_settings['frame_start'])
            end = int(publish_settings['frame_end'])
        byFrameStep = 1

        basePath = hipfile

        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}

        pars = [
            IECore.CompoundParameter("FrameRange","",[
#                IECore.BoolParameter("override","Check this to override the frame range defined in the file.",override),
                IECore.V3fParameter("range","Start, end and step of sequence to be published.",IECore.V3f(start, end, byFrameStep), userData=disabled),
            ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}}),
        ]
        # output_nodes=['mantra1','geo1','cortexWriter1']


        nodes_publish = []
        # get all write nodes that are enabled!!
        for each in output_nodes:
            nodes_publish.append(
                        IECore.BoolParameter(
                            name=each,
                            description = "Check to publish this node.",
                            defaultValue = IECore.BoolData(False),
                        )
                    )
        pars.append( IECore.CompoundParameter("OutputNodes","",nodes_publish,userData = { "UI": {"collapsed" : IECore.BoolData(False)}}) )

        render.__init__(self, 'houdini', 'hip', basePath, pars)

    def doOperation( self, operands ):
        # gather selected writenodes
        self.writeNodes = []
        if 'OutputNodes' in operands.keys():
                for each in operands['OutputNodes'].keys():
                    if operands['OutputNodes'][each].value:
                        self.writeNodes.append(each)

        if not self.writeNodes:
            raise Exception("You have to select at least one output node!")

        return IECore.StringData( 'done' )


    def submission( self, operands ):
        ''' publish calls submission to send to farm'''
        data = self.data
        assetPath           = str(data['assetPath'])
        publishFile         = str(data['publishFile'])
        frameRange          = operands['FrameRange']['range'].value

        if not hasattr( self, 'files' ):
            self.files = [publishFile]


        jobids = []
        for each in self.files:
            while '##' in each:
                each.replace('##','#')
            jobid = pipe.farm.houdini(
                scene       = each.replace( '#', pipe.farm.houdini.frameNumber() ),
                driver   = self.writeNodes,
                name        = 'RENDER: %s_%s' % (data['assetName'],data['assetVersion']) ,
                CPUS        = 9999,
                priority    = 9999,
                range       = range(int(frameRange.x), int(frameRange.y+frameRange.z), int(frameRange.z)),
                group       = 'pipe'
            ).submit()
            print( 'job id: %s' % str(jobid) )
            jobids.append(str(jobid))


        return IECore.StringData( ','.join(jobids) )




IECore.registerRunTimeTyped( houdini )
