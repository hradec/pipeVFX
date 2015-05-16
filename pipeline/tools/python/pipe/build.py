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

from base import roots, platform, bits, arch, distro, LD_LIBRARY_PATH, depotRoot, getPackage, win, osx, lin, name


def install(plat=platform):
    ''' install directory for the current platform'''
    return "%s/pipeline/libs/%s/%s/%s" % (depotRoot(),plat,arch,distro)

def devInstall(plat=platform):
    ''' development install directory for the current platform'''
    return "%s/pipeline/build/%s/%s/%s" % (depotRoot(),plat,arch,distro)

def env():
    ''' return the PATH to add our custom gcc, so when we build something, it will use pipes gcc'''
    return '''
        PATH=%s/gcc/bin/:$PATH
    ''' % (install())

