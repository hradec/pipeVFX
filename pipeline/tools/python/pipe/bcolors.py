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




class bcolors:
    import os
    BS = '\033[1D'
    HEADER = '\033[95m'+BS
    BLUE = '\033[94m'+BS
    GREEN = '\033[92m'+BS
    WARNING = '\033[93m'+BS
    FAIL = '\033[91m'+BS
    END = '\033[0m'+BS
    if 'TRAVIS' in os.environ:
        BS = '\e[1D'
        HEADER = '\e[95m'+BS
        BLUE = '\e[94m'+BS
        GREEN = '\e[92m'+BS
        WARNING = '\e[93m'+BS
        FAIL = '\e[91m'+BS
        END = '\e[0m'+BS


    def disable(self):
        self.HEADER = ''
        self.OKBLUE = ''
        self.OKGREEN = ''
        self.WARNING = ''
        self.FAIL = ''
        self.END = ''
