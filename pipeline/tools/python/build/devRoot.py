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



import os, sys, pipe


def installRoot(args={}):
    if args.has_key('RELEASE') or 'install' in sys.argv:
        # RELEASE will install properly in the right place,
        # respecting the ROOT env var as the path for the pipeVFX root!
        dev = pipe.build.install()
    else:
        # we mangle the ROOT env var so we can get a install
        # folder local to the current folder, by default!
        tmp = None
        if os.environ.has_key('ROOT'):
            tmp = os.environ['ROOT']
            del os.environ['ROOT']
        dev = pipe.build.devInstall()
        if tmp:
            os.environ['ROOT'] = tmp
    if args.has_key('PREFIX'):
        dev = args['PREFIX']
    os.system("mkdir -p %s" % dev)
    return dev

def buildFolder(args={}):
    build = '.build'

    if args.has_key('BUILD_FOLDER'):
        build = args['BUILD_FOLDER']

    return build
