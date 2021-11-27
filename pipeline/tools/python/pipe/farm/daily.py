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

from pipe.farm import current
import os, sys


class daily(current.engine):
#    def __init__(self, cmdLine, name='', CPUS=0, extra={}, priority = 9999, range = range(1,11,1), group = 'pipe', pad=4, asset=''):
#        current.engine.__init__(self, '', name='', CPUS=0, extra={}, priority = 9999, range = range(1,11,1), group = 'pipe', pad=4, asset='')

    def subJobs(self):
        return '1'

    def cook(self):
        import pipe.apps
        d = pipe.apps.dailies()
        version = os.path.basename( os.path.realpath( d.path() ) )
        self.cmd = os.path.abspath( self.cmd )
        self.job = "DAILY %s %s: %s" % (version, self.job, self.cmd)
        self.cmd = ' '.join([
            'run nuke',
            '"%s"' % self.cmd,
            '%s,%s,1' % (self.frameNumber(), self.frameNumber()),
        ])
