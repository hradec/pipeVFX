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
    if ('TRAVIS' in os.environ and os.environ['TRAVIS']=='1') or ('ENVIRON_TRAVIS' in os.environ and os.environ['ENVIRON_TRAVIS']=='1'):
        BS = ''

    HEADER = '\033[95m'
    BLUE = '\033[1;34m'
    BLUE_DARK = '\033[0;34m'
    GREEN = '\033[1;32m'
    GREEN_DARK = '\033[0;32m'
    WARNING = '\033[1;33m'
    WARNING_DARK = '\033[0;33m'
    FAIL = '\033[1;31m'
    FAIL_DARK = '\033[0;31m'
    END = '\033[0m'
    BOLD = '\033[1m'


    def disable(self):
        self.HEADER = ''
        self.BLUE = ''
        self.BLUE_DARK = ''
        self.GREEN = ''
        self.GREEN_DARK = ''
        self.WARNING = ''
        self.WARNING_DARK = ''
        self.FAIL = ''
        self.FAIL_DARK = ''
        self.END = ''
        self.BOLD = ''
