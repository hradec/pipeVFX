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
exec( pipe.include( __file__ ) )

try: from importlib import reload
except: pass


class gaffer( render ) :

    def __init__( self ) :
        self._whoCanPublish = ['gaffer']
        self._whoCanImport = ['maya','nuke','houdini', 'gaffer']
        self._whoCanOpen = ['gaffer']
        self.data = []
        render.__init__(self, 'gaffer', '',  'gaffer/')

        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}
        pars = [
            IECore.CompoundParameter("FrameRange","",[
                IECore.V3fParameter("range","Start, end e 'step' of the sequence to be rendered.",IECore.V3f(0, 10, 1), userData=disabled),
            ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}}),
        ]
        self.parameters().addParameters( pars )

        # set OP according to the loaded gaffer scene
        if 'PIPE_PARENT' in os.environ and os.environ['PIPE_PARENT'] == 'gaffer':
            if 'GAFFER_CURRENT_FRAME_START' in os.environ:
                scene = os.environ['GAFFER_CURRENT_FILENAME']
                start = float(os.environ['GAFFER_CURRENT_FRAME_START'])
                end   = float(os.environ['GAFFER_CURRENT_FRAME_END'])
                by    = 1.0
                self.parameters()["%sScene" % self.prefix].setValue(  IECore.StringData(scene) )
                self.parameters()["FrameRange"]['range'].setValue( IECore.V3f(start, end, by) )
            else:
                # TODO: pull from gaffer scene file, so we can submit from shell.
                pass

    def submission( self, operands ):
        ''' publish calls submission to send to farm'''
        print( '====> 4' )

        data = self.data
        assetPath           = str(data['assetPath'])
        publishFile         = str(data['publishFile'])
        publishPath         = str(data['publishPath'])
        frameRange          = operands['FrameRange']['range'].value
        scene               = operands["%sScene" % self.prefix].value

        project = ""
        if 'GAFFER_CURRENT_FILENAME' in os.environ:
            project = os.environ['GAFFER_CURRENT_PROJECT']

        if not hasattr( self, 'files' ):
            self.files = [publishFile]

        print( '====> 5' )
        jobids = []
        jobid = pipe.farm.gaffer(
            scene       = publishFile,
            asset       = publishPath,
            project     = project,
            name        = 'RENDER: %s_%s' % (data['assetName'],data['assetVersion']) ,
            CPUS        = 9999,
            priority    = 9999,
            range       = range(int(frameRange.x), int(frameRange.y+frameRange.z), int(frameRange.z)),
            group       = 'pipe',
            description = data['assetDescription'],
        ).submit()
        print( '====> 6' )

        print( 'job id: %s' % str(jobid) )
        jobids.append(str(jobid))

        return IECore.StringData( ','.join(jobids) )

IECore.registerRunTimeTyped( gaffer )
