
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class make(generic):
    src = 'Makefile'
    
    def action(self, target, source):
        # register builder
        bld = Builder(action = self.make)
        self.env.Append(BUILDERS = {'make' : bld})
        return self.env.make( target, source )
        

    def make(self, target, source, env):
        target=str(target[0])
        source=str(source[0])

        dirLevels = '..%s' % os.sep * (len(source.split(os.sep))-1)
        installDir = os.path.dirname(target)

        cmd = '%s %s' % (env['MAKE'], env['EXTRA'])
        print bcolors.GREEN+'%s...' % env['MAKE']+bcolors.END
        self.runCMD(cmd, target, source)
        

