
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class pythonSetup(generic):
    src = 'setup.py'
    
    def action(self, target, source):
        # register builder
        bld = Builder(action = self.pythonSetup)
        self.env.Append(BUILDERS = {'pythonSetup' : bld})
        
        return self.env.pythonSetup( target, source )
        

    def pythonSetup(self, target, source, env):
        import re
        target=str(target[0])
        source=str(source[0])
        
        dirLevels = '..%s' % os.sep * (len(source.split(os.sep))-1)
        installDir = os.path.dirname(target)
        pythonVersion = target.split('python')[-1].split('.done')[0]
        site_packages = os.path.join(dirLevels,installDir,'lib/python$PYTHON_VERSION_MAJOR/site-packages')

        
        cmd = 'python %s build' % (
            os.path.basename(source)
        )
        print bcolors.GREEN+'\tbuilding...'+bcolors.END
        self.runCMD(cmd,target,source)

#        cmd = 'cd "%s"; ppython %s install --prefix=%s' % (os.path.dirname(source), os.path.basename(source), os.path.join(dirLevels,installDir))
        cmd = 'python %s install --prefix=%s' % (
            os.path.basename(source), 
            os.path.join(dirLevels,installDir)
        )
        print bcolors.GREEN+'\tinstalling...'+bcolors.END
        self.runCMD(cmd,target,source)

#        cmd = 'ppython --python_version %s %s clean 2>&1' % (
#            pythonVersion, 
#            os.path.basename(source)
#        )
#        print 'cleaning up...'
#        runCMD(cmd,target)

        