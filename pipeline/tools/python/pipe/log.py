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

from __future__ import print_function
import sys
from bcolors import bcolors

logd = False
if '--logd' in sys.argv:
    logd = True

def __log(msg, error=False):
    if error:
        sys.stderr.write(msg.strip('\n')+'\n')
        sys.stderr.flush()
    else:
        print(msg)
        sys.stdout.flush()

def info(msg):
    if logd:
        __log(msg)

def traceback():
    import traceback
    return ''.join(traceback.format_stack())

def warning(msg):
    if logd:
        W=bcolors.WARNING+bcolors.BOLD
        WT=bcolors.END+bcolors.WARNING_DARK
        __log(W+"WARNING: "+"="*120)
        __log("WARNING:\t"+WT+(W+'\nWARNING:\t'+WT).join(str(msg).split('\n')))
        __log(W+"WARNING: "+"="*120+bcolors.END)

def error(msg):
    # __log(bcolors.WARNING+"_"*120, error=True)
    __log(bcolors.FAIL+"ERROR:\t"+'\nERROR:\t'.join(str(msg).split('\n')), error=True)
    __log("_"*120+bcolors.END, error=True)

def debug(msg):
    if logd:
        D=bcolors.BOLD+bcolors.GREEN
        DT=bcolors.END+bcolors.BLUE_DARK
        __log(D+"DEBUG:\t"+DT+('\n'+D+'DEBUG:\t'+DT).join(str(msg).split('\n'))+bcolors.END)
