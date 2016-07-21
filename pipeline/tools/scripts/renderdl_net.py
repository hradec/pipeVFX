#!/usr/bin/env python
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




import pipe,sys

import os


class netrender(pipe.farm.current.engine):
    def __init__(self, cmdline, renderer='3delight', name='', extra='', CPUS=0, priority=9999, range=range(1,10), group='pipe'):
        self.renderer = renderer
        rib = ""
        for each in cmdline:
            if '.rib' in each:
                rib=each
                break
        self.scene =  os.path.abspath( rib )
        self.cmd = cmdline
        pipe.farm.current.engine.__init__(self, rib, name, CPUS, extra, priority, range, group)
        
    def cook(self):

        if self.renderer == '3delight': 
            self.name += " | 3DELIGHT v%s" % pipe.apps.delight().version()
            self.licenses['delight'] = True
            self.cmd = 'run renderdl %s' % ' '.join(self.cmd)

     
jobids = []

jobid = netrender(
        cmdline     = sys.argv, 
        name        = 'NETRENDER: ', 
        CPUS        = 9999, 
        priority    = 9999, 
        range       = range(1, 6, 1), 
        group       = 'pipe'
    ).submit()
print 'job id: %s' % str(jobid)
jobids.append(str(jobid))
