
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class pythonSetup(generic):

    def __init__ ( self,
                  args,
                  name,
                  env=None,
                  python=pipe.libs.version.get('python'),
                  src='setup.py',
                  sed=[],
                  download=None
                ):
        generic.__init__(self, args, env, sed=sed, download=download)
        self.name = name
        self.args = args            
        self.pythonVersion = python
        if type(python) != type([]):
            self.pythonVersion = [python]

        # register builder
        bld = Builder(action = self.builder)
        self.env.Append(BUILDERS = {'pythonSetup' : bld})
        
        # build all python versions specified
        for p in self.pythonVersion:
            # build all versions of the package specified by the download parameter
            for n in range(len(download)):
                #download pkg
                archive = os.path.join(buildFolder(self.args),download[n][1])
                pkgs = self.download(archive, 'SConstruct')
                #uncompress
                setup = os.path.join(buildFolder(self.args),download[n][1].replace('.tar.gz',".python%s" % p),src)
                py = self.uncompress(setup, pkgs)
                # installation folder
                target = os.path.join( self.installPath,  self.name, download[n][2], 'install.python%s.done' % p )
                # build it running setup.py
                t = self.env.pythonSetup( target, py )
    #            self.env.Clean(t,  os.path.dirname(target))

                self.env.Alias( 'install', t )


    def builder(self, target, source, env):
        import re
        target=str(target[0])
        source=str(source[0])
        pythonVersion = target.split('python')[-1].split('.done')[0]

        dirLevels = '..%s' % os.sep * (len(source.split(os.sep))-1)

        installDir = os.path.dirname(target)
#        if not os.path.exists(installDir):
#            os.makedirs(installDir)

        pipe.versionLib.set(python=pythonVersion)

        site_packages = os.path.join(dirLevels,installDir,'lib/python$PYTHON_VERSION_MAJOR/site-packages')
        os.environ['PYTHONPATH'] = ':'.join( [
            site_packages,
            os.environ['PYTHONPATH'] ,
        ])
        
        print '='*120
        print source, pythonVersion
        def runCMD(cmd,target):

            # adjust env vars for the current selected python version
            for var in os.environ.keys():
                pp = []
                for each in os.environ[var].split(':'):
                    each = each.replace('python%s' % os.environ['PYTHON_VERSION_MAJOR'], 'python%s' % pythonVersion[:3])
                    if '/python/' in each:
                        each = each.replace(os.environ['PYTHON_VERSION'], pythonVersion)
                    pp.append(each)
                os.environ[var] = ':'.join(pp)
            
            os.environ['PYTHON_VERSION'] = pythonVersion
            os.environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]

            call = os.popen(cmd)
            lines = call.readlines()
            ret = call.close()
            if not ret:
                os.system( 'echo a >> "%s"' % target )
#                for each in lines :
#                    print each.strip()
            else:
                print '-'*120
                for each in lines :
                    print each.strip()
                print '-'*120
                raise Exception('Error executing setup.py install - %s' % ret)
                print '-'*120

        cmd = 'cd "%s"; mkdir -p "%s" ;  ppython --logd --python_version %s %s build 2>&1' % (
            os.path.dirname(source), 
            site_packages, 
            pythonVersion, 
            os.path.basename(source)
        )
        print 'building...'
        runCMD(cmd,target)

#        cmd = 'cd "%s"; ppython %s install --prefix=%s' % (os.path.dirname(source), os.path.basename(source), os.path.join(dirLevels,installDir))
        cmd = 'cd "%s"; mkdir -p "%s" ; ppython --python_version %s %s install  --prefix=%s  2>&1' % (
            os.path.dirname(source), 
            site_packages, 
            pythonVersion, 
            os.path.basename(source), 
            os.path.join(dirLevels,installDir)
        )
        print 'installing...'
        runCMD(cmd,target)

        cmd = 'cd "%s"; mkdir -p "%s" ;  ppython --python_version %s %s clean 2>&1' % (
            os.path.dirname(source), 
            site_packages, 
            pythonVersion, 
            os.path.basename(source)
        )
        print 'cleaning up...'
        runCMD(cmd,target)

        