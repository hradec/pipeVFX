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
from pipe import log
from pipe.baseApp import baseApp, baseLib, root, version, wacom
from pipe.baseApp import cache, getMacAddress, _appsDB
from pipe.base import roots
from pipe.libs import allLibs
from pipe.bcolors import bcolors
import pipe.cached as cached
import os
import traceback

# avoid getting duplicated files.
appz = {}
def sourceApps( jconfig ):
    if os.path.exists( jconfig ):
        for each in cached.glob("%s/*.py" % jconfig):
            appz[ os.path.basename( each ) ] = each

# go over the folder structure, and overwrite the files before sourcing then.
sourceApps( "%s/config/apps" % roots.tools() )
if pipe.admin:
    if pipe.admin.job.current():
        sourceApps( pipe.admin.job().path("/tools/config/apps") )
        if pipe.admin.job.shot.current():
            sourceApps( pipe.admin.job.shot().path("/tools/config/apps") )
            sourceApps( pipe.admin.job.shot.user().path("/tools/config/apps") )


# now we source our files!!
for each in appz.keys():
#    print appz[each]
    try:
        exec(''.join(open(appz[each]).readlines()),globals(),locals())
    except:
        print( bcolors.FAIL+'='*80 )
        print( each+" ERROR:\n" )
        print( "\n\t".join(traceback.format_exc().split('\n')) )
        print( '='*80,bcolors.END )




class buildStuff(baseApp):
    pass


class wxpython(baseApp):
    def pythonPath(self):
        p = self.appFromDB.pythonPath()
        # for each in p:
        #     p[each] = [ x for x in glob.glob(p[each]+'/*')  if 'wxpython' in x.lower() ]
        return p




genericRegistry = [
    'class %s(baseApp):',
    '   pass',
]
for each in _appsDB:
    if each.strip() not in  dir():
#        if os.path.exists( '%s/%s/bin' % (roots.apps(), each) ):
            exec( '\n'.join(genericRegistry) % each )
