
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
    cmd = [
        'python setup.py install --prefix=$TARGET_FOLDER',
    ]

    def fixCMD(self, cmd):
        mkdir = 'mkdir -p $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/'
        if mkdir.replace(' ','').lower() not in cmd.replace(' ','').lower():
            cmd = "%s && %s" % (mkdir,cmd)
        return cmd 
    
#    def action(self, target, source):
#        self.registerSconsBuilder(self.pythonSetup)
#        return self.env.pythonSetup( target, source )
        

#    def pythonSetup(self, target, source, env):
#        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
#        installDir = os.path.dirname(str(target[0]))
#        pythonVersion = str(target[0]).split('python')[-1].split('.done')[0]
#        site_packages = os.path.join(dirLevels,installDir,'lib/python$PYTHON_VERSION_MAJOR/site-packages')

        
#        cmd = 'python %s build' % (
#            env['CMD'],
#        )
#        print bcolors.GREEN+'\tbuilding...'+bcolors.END
#        self.runCMD(cmd,target,source)

##        cmd = 'cd "%s"; ppython %s install --prefix=%s' % (os.path.dirname(source), os.path.basename(source), os.path.join(dirLevels,installDir))
#        cmd = 'mkdir -p $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ &&  python %s install --prefix=$TARGET_FOLDER' % (
#            env['CMD'],
#        )
#        print bcolors.GREEN+'\tinstalling...'+bcolors.END
#        self.runCMD(cmd,target,source)

#        cmd = 'ppython --python_version %s %s clean 2>&1' % (
#            pythonVersion, 
#            os.path.basename(source)
#        )
#        print 'cleaning up...'
#        runCMD(cmd,target)

        