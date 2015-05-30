
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
        'make -j $DCORES && make -j $DCORES install',
    ]

    def fixCMD(self, cmd):
        if 'configure' in cmd and '--prefix=' not in cmd:
            cmd = cmd.replace('configure', 'configure --prefix=$TARGET_FOLDER ')
        return cmd 
    

        
class boost(configure):
    src = './bootstrap.sh'
    environ = {
        'CC'        : 'gcc -fPIC',
        'CPP'       : 'g++ -fPIC',
        'CXX'       : 'g++ -fPIC',
        'CXXCPP'    : 'g++ -fPIC',
        'CPPFLAGS'  : 'g++ -fPIC',
    }
    cmd = [
        './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
        './b2 -j %d cxxflags=-fPIC -d+2 install' % (CORES*2),
    ]

#    def installer(self, target, source, env):
#        os.popen("rm -rf %s/lib/python*/*.a" % env['TARGET_FOLDER']).readlines()

