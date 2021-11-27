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
import os


class cmds(current.engine):
    def __init__(self, name='', cmds=[], files=[], postCmd={}, CPUS=0, priority=9999, group='pipe', capacity=1000, description=None):
        current.engine.__init__(self, "", name=name, CPUS=CPUS, priority=priority, group=group)
        self.cmd = cmds
        self.files = files
        self.postCmd = postCmd
        self.capacity = capacity
        if description:
            self.description = description
