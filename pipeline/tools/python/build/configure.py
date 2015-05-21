
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class configure(generic):

    def __init__ ( self,
                  args,
                  name,
                  env=None,
                  python=pipe.libs.version.get('python'),
                  src='configure',
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
        bld = Builder(action = self.configure)
        self.env.Append(BUILDERS = {'configure' : bld})
        
        # build all python versions specified
        for p in self.pythonVersion:
            # build all versions of the package specified by the download parameter
            for n in range(len(download)):
                #download pkg
                archive = os.path.join(buildFolder(self.args),download[n][1])
                pkgs = self.download(archive, 'SConstruct')
                #uncompress
                setup = os.path.join(buildFolder(self.args),download[n][1].replace('.tar.gz',".python%s" % p),src)
                s = self.uncompress(setup, pkgs)
                # run configure and make/make install
                target = os.path.join( self.installPath,  self.name, download[n][2], 'install.python%s.done' % p )
                t = self.env.configure( target, s )
    #            self.env.Clean(t,  os.path.dirname(target))

                self.env.Alias( 'install', t )


    def configure(self, target, source, env):
        target=str(target[0])
        source=str(source[0])
        pythonVersion = target.split('python')[-1].split('.done')[0]

        dirLevels = '..%s' % os.sep * (len(source.split(os.sep))-1)

        installDir = os.path.dirname(target)
#        if not os.path.exists(installDir):
#            os.makedirs(installDir)

        pipe.versionLib.set(python=pythonVersion)
        pipe.version.set(python=pythonVersion)
        
        print '='*120
        print source
        def runCMD(cmd,target):
#            print cmd
            # adjust env vars for the current selected python version
            for var in os.environ.keys():
                pp = []
                for each in os.environ[var].split(':'):
                    each = each.replace('python%s' % os.environ['PYTHON_VERSION_MAJOR'], 'python%s' % pythonVersion[:3])
                    if '/python/' in each:
                        each = each.replace(os.environ['PYTHON_VERSION'], pythonVersion)
                    pp.append(each)
                os.environ[var] = ':'.join(pp)
            
            os.environ['LD_LIBRARY_PATH'] = ':'.join([
                os.path.dirname(''.join(os.popen('which gcc').readlines()))+'/../lib64/',
                os.environ['LD_LIBRARY_PATH'],
            ])
            os.environ['LIBRARY_PATH'] = '/usr/lib/x86_64-linux-gnu/'
            os.environ['PATH'] = ':'.join([
                pipe.libs.python().path('bin'),
                os.environ['PATH'],
            ])

            os.environ['PYTHON_VERSION'] = pythonVersion
            os.environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]

            call = os.popen(cmd)
            lines = call.readlines()
            ret = call.close()
            if not ret:
#                os.system( 'echo a >> "%s"' % target )
                f = open(target,'a')
                for each in lines :
                    f.write(each)
                f.close()
            else:
                print '-'*120
                for each in lines :
                    print each.strip()
                print '-'*120
                raise Exception('Error executing setup.py install - %s' % ret)
                print '-'*120

        cmd = '''cd "%s"; ppython --logd -c "import os,sys;sys.exit(os.system('./configure --prefix=%s 2>&1'))"'''  % (
            os.path.dirname(source), 
            os.path.abspath(os.path.join(os.path.dirname(source),dirLevels,installDir))
        )
        print 'configure...'
        runCMD(cmd,target)

#        cmd = 'cd "%s"; ppython %s install --prefix=%s' % (os.path.dirname(source), os.path.basename(source), os.path.join(dirLevels,installDir))
        cmd = 'cd "%s"; make ; make install  2>&1' % (
            os.path.dirname(source)
        )
        print 'making...'
        runCMD(cmd,target)

        cmd = 'cd "%s"; make clean ; make distclean 2>&1' % (
            os.path.dirname(source)
        )
        print 'cleaning up...'
        runCMD(cmd,target)

        