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

import pipe
from baseApp import baseLib, libsDB
from baseApp import versionLib as version
from pipe.base import roots
from pipe.bcolors import bcolors
import os, glob
import traceback


genericRegistry = [
    'class %s(baseLib):',
    '   pass',
]
for each in libsDB():
    if each != 'gcc':
         exec( '\n'.join(genericRegistry) % each.replace('-','_').replace('+','_plus_') )


class allLibs(baseLib):
    ''' this class loops over all installed libs and sets the proper
    env vars for then.
    As all our libs are installed in a padronized way, we don't need
    specific classes for each lib. 
    In the case a library needs some special setup, we can allways create a
    new class for it, in the same molds of our apps classes!
    '''
    def environ(self):
        for each in libsDB():
            if each != 'gcc':
                self.update( eval("%s()" % each.replace('-','_')) )
        





# avoid getting duplicated files. 
libz = {}
def sourceLibs( jconfig ):
    if os.path.exists( jconfig ):
        for each in glob.glob("%s/*.py" % jconfig):
            libz[ os.path.basename( each ) ] = each

# go over the folder structure, and overwrite the files before sourcing then.
sourceLibs( "%s/config/libs" % roots.tools() )
if pipe.admin:
    if pipe.admin.job.current():
        sourceLibs( pipe.admin.job().path("/tools/config/libs") )
        if pipe.admin.job.shot.current():
            sourceLibs( pipe.admin.job.shot().path("/tools/config/libs") )
            sourceLibs( pipe.admin.job.shot.user().path("/tools/config/libs") )


# now we source our files!!
for each in libz.keys():
#    print appz[each]
    try:
        exec(''.join(open(libz[each]).readlines()),globals(),locals())
    except:
        print bcolors.FAIL+'='*80
        print each+" ERROR:\n"
        print "\n\t".join(traceback.format_exc().split('\n'))
        print '='*80,bcolors.END

