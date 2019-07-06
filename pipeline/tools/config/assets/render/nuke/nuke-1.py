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

try:
    import nuke
except:
    nuke=None


class nuke( render ) :

    def __init__( self ) :
        try:
            import nuke
        except:
            nuke=None

        self._whoCanPublish = ['nuke']
        self._whoCanImport = ['maya','nuke','houdini']
        self._whoCanOpen = ["nuke"]

        start = 0
        end = 10
        byFrameStep = 1

        basePath = 'nuke'
        if nuke:
            basePath = nuke.root().knob('name').value()
            if not basePath:
                raise Exception("ERROR: The scene needs to be saved on disk before publishing!")

            start       = nuke.root().frameRange().first()
            byFrameStep = nuke.root().frameRange().increment()
            end         = nuke.root().frameRange().last()


        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}

        pars = [
            IECore.CompoundParameter("FrameRange","",[
#                IECore.BoolParameter("override","Check this to override the frame range defined in the file.",override),
                IECore.V3fParameter("range","Start, end and step of sequence to be published.",IECore.V3f(start, end, byFrameStep), userData=disabled),
            ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}}),
        ]


        if nuke:
            rps = []
            # get all write nodes that are enabled!!
            for each in filter(lambda x: x.Class()=='Write', nuke.allNodes()):
                if not each['disable'].getValue():
                    rps.append(
                                IECore.BoolParameter(
                                    name=each.name(),
                                    description = "Check to publish this node.",
                                    defaultValue = IECore.BoolData(each in nuke.selectedNodes()),
                                )
                            )
            pars.append( IECore.CompoundParameter("WriteNodes","",rps,userData = { "UI": {"collapsed" : IECore.BoolData(False)}}) )

        render.__init__(self, 'nuke', 'nk', basePath, pars)

    def doOperation( self, operands ):
        # gather selected writenodes
        self.writeNodes = []
        if 'WriteNodes' in operands.keys():
                for each in operands['WriteNodes'].keys():
                    if operands['WriteNodes'][each].value:
                        self.writeNodes.append(each)

        if not self.writeNodes:
            raise Exception("You have to select at least one write node!")

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
            jobid = pipe.farm.nuke(
                scene       = each.replace( '#', pipe.farm.nuke.frameNumber() ),
                writeNode   = self.writeNodes,
                name        = 'RENDER: %s_%s' % (data['assetName'],data['assetVersion']) ,
                CPUS        = 9999,
                priority    = 9999,
                range       = range(int(frameRange.x), int(frameRange.y+frameRange.z), int(frameRange.z)),
                group       = 'pipe'
            ).submit()
            print 'job id: %s' % str(jobid)
            jobids.append(str(jobid))


        return IECore.StringData( ','.join(jobids) )




IECore.registerRunTimeTyped( nuke )
