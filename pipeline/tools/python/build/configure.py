
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
    cmd = './configure'
    make = 'make && make install'

    def action(self, target, source):
        # first we nee to register our custom scons builder
        self.registerSconsBuilder(self.configure)
        return self.env.configure( target, source )
        
    def setMake(self, make):
        self.set('MAKE', make)

    def configure(self, target, source, env):
        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
        installDir = os.path.dirname(str(target[0]))

        cmd = '%s %s --prefix=%s' % (
            env['CMD'],
            env['EXTRA'],
            os.path.abspath(os.path.join(os.path.dirname(str(source[0])),dirLevels,installDir))
        )
        
        print '\t%s%s...%s ' % (bcolors.GREEN,env['CMD'],bcolors.END)
        self.runCMD(cmd, target, source)
        
        if env['MAKE']:
            cmd = env['MAKE']
            print '\t%s%s...%s ' % (bcolors.GREEN,env['MAKE'],bcolors.END)
            self.runCMD(cmd, target, source)


        
class boost(configure):
    src = './bootstrap.sh'
    cmd = './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/'
    make = './b2 install'

