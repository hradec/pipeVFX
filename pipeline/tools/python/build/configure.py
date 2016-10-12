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


from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys
from pipe.bcolors import bcolors


class configure(generic):
    src = 'configure'
    cmd = [
        './configure  --enable-shared',
        'make -j $DCORES  && make  install',
    ]

    def fixCMD(self, cmd):
        if 'configure' in cmd and '--prefix=' not in cmd:
            cmd = cmd.replace('configure', 'configure --prefix=$TARGET_FOLDER ')
#        if 'make' in cmd:
#            cmd = cmd.replace('make', "make CC=$CC CXX=$CXX CFLAGS='$CFLAGS' CXXFLAGS='$CXXFLAGS' ")
        return cmd 
    


class openssl(configure):
    ''' a make class to exclusively build openssl package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    src='config'
    cmd=[
#        './config no-shared no-idea no-mdc2 no-rc5 zlib enable-tlsext no-ssl2 --prefix=$TARGET_FOLDER',
#        'make depend && make && make install',
        './config shared --prefix=$TARGET_FOLDER',
        'make && make install',
    ]
    def installer(self, target, source, env):
        targetFolder = os.path.dirname(str(target[0]))
        os.popen("ln -s libssl.so %s/lib/libssl.so.10" % targetFolder).readlines()
        os.popen("ln -s libcrypto.so %s/lib/libcrypto.so.10" % targetFolder).readlines()



class freetype(configure):
    ''' a make class to exclusively build freetype package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    def installer(self, target, source, env):
        t = os.path.dirname(str(target[0]))
        if os.path.exists( "%s/include/freetype2" % t):
            os.popen("ln -s freetype2 %s/include/freetype" % t).readlines()

        
                
class boost(configure):
    src = './bootstrap.sh'
    environ = {
        'CC'        : '$CC -fPIC',
        'CPP'       : '$CPP -fPIC',
        'CXX'       : '$CXX -fPIC',
        'CXXCPP'    : '$CXXPP -fPIC',
    }
    cmd = [
        './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
        './b2 -j $DCORES cxxflags="-fPIC $CPPFLAGS" linkflags="$LDFLAGS" -d+2 install',
    ]

#    def installer(self, target, source, env):
#        os.popen("rm -rf %s/lib/python*/*.a" % env['TARGET_FOLDER']).readlines()

