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

import pipe.apps
import current
import os

class nuke(current.engine):
    def __init__(self, scene, writeNode='Write1', name='', CPUS=0, extra={}, priority = 9999, range = '1-10', group = 'pipe'):
        self.writeNode = writeNode
        self.scene = scene
        current.engine.__init__(self, scene, name, CPUS, extra, priority, range, group)
    
    def cook(self):
        
        writeNodes = self.writeNode
        if type(self.writeNode) == type([]):
            writeNodes = ','.join(self.writeNode)
        
        self.licenses['nuke'] = True
        self.cmd = os.path.abspath( self.cmd )
        self.name += "| NUKE %s" % pipe.apps.nuke().version()
        self.cmd = ' '.join([
            'run nuke --log-level verbose -V 2 ',
#            '-t -x -X "%s"' % writeNodes,
#            '-V --',
            '-t', # terminal mode - render license!!
            '-f -X "%s"' % writeNodes,
            '-F %s' % self.frameNumber(),
            '"%s"' %  os.path.abspath( self.scene ),
#            '%s,%s,1' % (self.frameNumber(), self.frameNumber()),
        ])
        
        self.files = ["%s/images/none" % self.asset]
        
#"/usr/local/Nuke7.0v4/Nuke7.0" -t -x -X "Write1" -V -- "/mnt/Projetos/0216_HOOPONOPONO/SHOTS/_shot_01/DAN/NUKE/Comp_v031.nk"  138,138,1
