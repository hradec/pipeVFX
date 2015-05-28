from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *
import pipe
from pipe.bcolors import bcolors

import os, traceback, sys, inspect

class generic:
    src   = ''
    cmd   = ''
    extra = ''

    def __init__(self, args, name, download, python=pipe.libs.version.get('python'), env=None, depend=None, GCCFLAGS=[], sed=None, environ={}, **kargs):
        sys.stdout.write( bcolors.END )
        self.className = str(self.__class__).split('.')[-1]
        self.GCCFLAGS = GCCFLAGS
        self.args = args
        self.dependOn = depend
        if type(self.dependOn) != type([]):
            self.dependOn = [depend]
        self.env = env
        if self.env==None:
            self.env = Environment()
        self.name = name
        self.pythonVersion = python
        if type(python) != type([]):
            self.pythonVersion = [python]

        self.downloadList = download
        self.sed  = sed
        self.installPath = installRoot(self.args)
        
        
        if kargs.has_key('cmd'):
            self.cmd = kargs['cmd']
        
        bld = Builder(action = self.sed)
        self.env.Append(BUILDERS = {'sed' : bld})
        
        self.env.AddMethod(self.downloader, 'downloader')

        bld = Builder(action = self.uncompressor)
        self.env.Append(BUILDERS = {'uncompressor' : bld})

        os.popen( "mkdir -p %s" % buildFolder(self.args) )
        
        # download latest config.sub and config.guess so we can build old packages!
        if not os.path.exists('%s/config.sub' % buildFolder(self.args)):
            print 'Downloading latest config.sub'
            os.popen( 'wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD" -O %s/config.sub 2>&1' % buildFolder(self.args))
            print 'Downloading latest config.guess'
            os.popen( 'wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD" -O %s/config.guess 2>&1' % buildFolder(self.args))
            os.popen("chmod a+x %s/config.sub"   % buildFolder(self.args))
            os.popen("chmod a+x %s/config.guess" % buildFolder(self.args))

        
        # store all string variables in the class inside the current scons ENV
        # the variable name is upper() case!
        for each in filter(lambda x: type(x[1])==str and not '__' in x[0], inspect.getmembers(self)):
            name = each[0]
            value = each[1]
            self.set(name.upper(), value)
        
        for each in filter(lambda x: type(x[1])==list and not '__' in x[0], inspect.getmembers(self)):
            name = each[0]
            v = each[1]
            for n in range(len(v)):
                if type(v[n])==str:
                    self.set("%s_%s_%s_%02d" % (name.upper(),self.className,self.name,n), v[n])

        # set extra environment variables to env
        for name in environ.keys():
            self.set("ENVIRON_%s" % name.upper(), environ[name])

        # add all extra arguments as env vars!
        for each in kargs:
            v=kargs[each]
            if type(v)==type(""):
                v=[kargs[each]]
            for n in range(len(v)):
                self.set("%s_%s_%s_%02d" % (each.upper(),self.className,self.name,n), v[n])
        
        # build all python versions specified
        self.buildFolder = {}
        self.targetFolder = {}
        self.depend = {}
        for p in self.pythonVersion:
            pythonDependency = ""
            if len(self.pythonVersion) > 1:
                pythonDependency = ".python%s" % p
                
            self.depend[p] = []
            self.buildFolder[p] = []
            self.targetFolder[p] = []
            # build all versions of the package specified by the download parameter
            for n in range(len(download)):
                
                #download pkg
                archive = os.path.join(buildFolder(self.args),download[n][1])
                pkgs = self.download(archive)
                
                # build and install folder
                self.buildFolder[p].append( os.path.join(buildFolder(self.args),download[n][1].replace('.tar.gz',pythonDependency)) )
                self.targetFolder[p].append( os.path.join( self.installPath,  self.name, download[n][2] ) )
                self.env['TARGET_FOLDER'] = self.targetFolder[p][-1]
                os.environ['%s_TARGET_FOLDER' % self.name.upper()] = self.targetFolder[p][-1]
                
                #uncompress
                setup = os.path.join(self.buildFolder[p][-1], self.src)
                s = self.uncompress(setup, pkgs)
                        
                # run the action method of the class
                # add dependencies as source 
                source = [s]
                for dependOn in self.dependOn:
                    if dependOn:
                        depend_n = self.depend_n(dependOn, download[n][2])
                        k = dependOn.depend.keys()
                        if p in k:
                            source.append( dependOn.depend[p][depend_n] )
                        elif len(k)>0:
                            source.append( dependOn.depend[k[-1]][depend_n] )
                
                target = os.path.join( self.targetFolder[p][-1], 'build%s.done' % pythonDependency )
                b = self.action( target, source )
                
                # call the install builder, in case a class need to do custom installation
                target = os.path.join( self.targetFolder[p][-1], 'install%s.done' % pythonDependency )
                t = self.install( target, b )

                self.depend[p].append(t)
                self.env.Alias( 'install', t )
                
    def registerSconsBuilder(self, *args):
#        name = str(args[0]).split(' ')[2].split('.')[-1]
        name = self.className
        bld = Builder(action = args[0])
        self.env.Append(BUILDERS = {name : bld})
        return filter(lambda x: self.className==x[0], inspect.getmembers(self.env))[0][1]
        
    def setInstaller(self, method):
        self.installer = method

    def set(self, name, extra=''):
        self.env[name.upper()] = " "+extra.replace('"','\\"')
        
    def setExtra(self, extra=''):
        self.set('EXTRA', extra)

    def setCmd(self, extra=''):
        self.set('CMD', extra)
        
    def action(self, target, source):
        ''' action must be implemented by derivated classes. action is called by the python build loop in __init__ 
        it needs to register a builder method and call it!!
        '''
        return self.registerSconsBuilder(self.builder)( target, source )
                

    def fixCMD(self, cmd):
        ''' virtual method to fix cmd lines before execution, like adding --prefix to configure '''
        return cmd 

    def installer(self, target, source, env):
        ''' virtual method may be implemented by derivated classes in case installation needs to be done by copying or moving files.'''
        pass

    
    def builder(self, target, source, env):
        ''' the generic builder method, used by all classes 
        it simple executes all commands specified by self.cmd list '''
        
        if self.__check_target_log__(str(target[0]))==0:
            os.popen("touch %s" % str(target[0])).readlines()
        
        else:
            os.environ['CC'] = ''.join(os.popen('which gcc').readlines()).strip()
            os.environ['CXX'] = ''.join(os.popen('which g++').readlines()).strip()
            os.environ['LD'] = ''.join(os.popen('which gcc').readlines()).strip()
            
    #        import build
    #        for each in filter(lambda x: hasattr(x[1],'src'), inspect.getmembers(build)):
    #            print each, each[1].src
                
            # put all CMD vars into a dict
            # filter only the ones that belong to this class type!
            vars = {}
            for name,cmd in filter(lambda x: 'CMD' in x[0], env.items()):
                if self.className.upper() in name:
                    vars[name] = cmd
            
            # so we can sort then and use in order
            ids=vars.keys()
            ids.sort()
            for name in ids:
                cmd = vars[name]
                if cmd.strip():
                    cmd = self.fixCMD(cmd)
                    print '\t%s%s: %s %s ' % (bcolors.GREEN,name,cmd,bcolors.END)
                    self.runCMD(cmd, target, source)

    
    def depend_n(self,dependOn,currVersion):
        ''' support function to find the same version of a depency
        # look in the dependency download list if we have
        # the same version number as the current package.
        # if so, use that targetFolder!
        # works for cases like openexr and ilmbase which are 
        # released with the same version!
        '''
        depend_n = -1
        for each in range(len(dependOn.downloadList)):
            if dependOn.downloadList[each][2] == currVersion:
                depend_n = each
                break
        return depend_n

    def __check_target_log__(self,target):
        ret=255
        if os.path.exists(target):
            lines = open(target).readlines()
            ret = int(''.join(lines[-3:]).split("@runCMD_ERROR@")[-2].strip())
        return ret


    def runCMD(self, cmd , target, source):
        ''' the main method to run system calls, like configure, make, cmake, etc '''
        target=str(target[0])
        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
        installDir = os.path.dirname(target)
               
        # adjust env vars for the current selected python version
        sys.stdout.write( bcolors.FAIL )
        pythonVersion = pipe.versionLib.get('python')
        if len(target.split('python')) > 1:
            pythonVersion = target.split('python')[-1].split('.done')[0]
            pipe.versionLib.set(python=pythonVersion)
            pipe.version.set(python=pythonVersion)
    
            for var in os.environ.keys():
                pp = []
                for each in os.environ[var].split(':'):
                    each = each.replace('python%s' % os.environ['PYTHON_VERSION_MAJOR'], 'python%s' % pythonVersion[:3])
                    if '/python/' in each:
                        each = each.replace(os.environ['PYTHON_VERSION'], pythonVersion)
                    pp.append(each)
                os.environ[var] = ':'.join(pp)

            site_packages = os.path.join(dirLevels,installDir,'lib/python$PYTHON_VERSION_MAJOR/site-packages')
            os.environ['PYTHONPATH'] = ':'.join( [
                site_packages,
                os.environ['PYTHONPATH'] ,
            ])
        
            os.environ['PYTHON_VERSION'] = pythonVersion
            os.environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]
            
                
                
        os.environ['PKG_CONFIG_PATH']=""
        os.environ['CFLAGS']    = ""
        os.environ['CPPFLAGS']  = ""
        os.environ['LDFLAGS']   = ""
        
        CFLAGS=[]
        LDFLAGS=[]
        for dependOn in self.dependOn:
            if dependOn:
                depend_n = self.depend_n(dependOn, target.split('/')[-2])
                k = dependOn.targetFolder.keys()
                p = pythonVersion 
                if k:
                    if p not in k:
                        k.sort()
                        p = k[-1]
                            
#                    print dependOn.name.upper(), dependOn.targetFolder[p][depend_n]
                    os.environ['%s_TARGET_FOLDER' % dependOn.name.upper()] = dependOn.targetFolder[p][depend_n]
                    os.environ['PKG_CONFIG_PATH'] = ':'.join([
                        '%s/lib/pkgconfig/:' % dependOn.targetFolder[p][depend_n],
                        os.environ['PKG_CONFIG_PATH'],
                    ])
                    if dependOn in self.GCCFLAGS:
                        CFLAGS.append("-I%s/include/" % dependOn.targetFolder[p][depend_n])
                        LDFLAGS.append("-L%s/lib/" % dependOn.targetFolder[p][depend_n])
                        LDFLAGS.append("-L%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n], pythonVersion[:3]))
                    os.environ['LD_LIBRARY_PATH'] = ':'.join([
                        "%s/lib/" % dependOn.targetFolder[p][depend_n],
                        "%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        os.environ['LD_LIBRARY_PATH'],
                    ])
                    os.environ['PYTHONPATH'] = ':'.join([
                        "%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        "%s/lib/python%s/site-packages/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        os.environ['PYTHONPATH'],
                    ])
                    os.environ['PATH'] = ':'.join([
                        "%s/bin/" % (dependOn.targetFolder[p][depend_n]),
                        os.environ['PATH'],
                    ])
        
        if CFLAGS:
#            self.setExtra( 'CFLAGS="%s" CPPFLAGS="%s"' % (
#                ' '.join(CFLAGS+LDFLAGS),
#                ' '.join(CFLAGS+LDFLAGS),
#            ))
#            self.setExtra( 'LDFLAGS="%s"' % ' '.join(LDFLAGS) )
            os.environ['CFLAGS']    = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os.environ['CPPFLAGS']  = "%s" % ' '.join(CFLAGS+LDFLAGS)
#            os.environ['LDFLAGS']   = "%s" % ' '.join(LDFLAGS)
            
        os.environ['LD_LIBRARY_PATH'] = ':'.join([
            os.path.dirname(''.join(os.popen('which gcc').readlines()))+'/../lib64/',
            os.environ['LD_LIBRARY_PATH'],
        ])
        os.environ['LIBRARY_PATH'] = '/usr/lib/x86_64-linux-gnu/'
        os.environ['PATH'] = ':'.join([
            pipe.libs.python().path('bin'),
            os.environ['PATH'],
        ])
        os.environ['TARGET_FOLDER'] = self.env['TARGET_FOLDER']
        os.environ['SOURCE_FOLDER'] = os.path.abspath(os.path.dirname(str(source[0])))
        
        # set extra env vars
        for name,v in filter(lambda x: 'ENVIRON_' in x[0], self.env.items()):
            os.environ[name.split('ENVIRON_')[-1]] = v.strip()

        lastlog = '%s/lastlog' % os.environ['TARGET_FOLDER']
        if len(target.split('python')) > 1:
            lastlog = '%s.%s' % (lastlog,os.environ['PYTHON_VERSION_MAJOR'])
            
        open(lastlog,'w').close()
        # run the command from inside ppython, so all pipe env vars get properly set!
        try:
            cmd = 'cd "%s" && ' %  os.environ['SOURCE_FOLDER'] + cmd
            cmd = '''ppython --python_version $PYTHON_VERSION --logd -c "import os,sys;ret=os.system(\'\'\''''+cmd+'''\'\'\');print '@runCMD_ERROR@'+str(ret)+'@runCMD_ERROR@';sys.exit(ret)" >%s 2>&1''' % lastlog
            os.popen(cmd).readlines()
            ret = self.__check_target_log__(lastlog)
            if ret == 0:
                f = open(target,'a')
                for each in open(lastlog).readlines() :
                    f.write(each)
                f.close()
            else:
                raise
        except:
            print  '-'*120
            for each in open(lastlog).readlines() :
                print '\t%s' % each.strip()
            print '-'*120
            print bcolors.FAIL,
            traceback.print_exc()
            print '-'*120
            sys.stdout.flush()
            raise Exception('Error!')

        print bcolors.END,


    
    def _installer(self, target, source, env):
        ''' a wrapper class to create target in case installer method is suscessfull! '''
        self.installer( target, source, env )
        f=open(str(target[0]),'w')
        f.write(' ')
        f.close()

    def downloader( self, env, source, _url=None):        
        ''' this method is a builder responsible to download the packages to be build '''
        self.error = None
        source = [source]
        for n in range(len(source)):
            url=_url
            if not url:
                url = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)[0]
            md5 = ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % source[n]).readlines()).strip()
            if md5 != url[3]:
                print "\tDownloading %s..." % source[n]
                lines = os.popen("wget '%s' -O %s >%s.log 2>&1" % (url[0], source[n], source[n])).readlines()
                md5 = ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % source[n]).readlines()).strip()
                if md5 != url[3]:
                    sys.stdout.write( bcolors.WARNING )
                    print "\tmd5 for file:", url[1], md5
                    sys.stdout.write( bcolors.FAIL )
                    sys.stdout.flush()
                    self.error = True
        return source
            
            
    def uncompressor( self, target, source, env):        
        ''' this method is a builder responsible to uncompress the packages to be build '''
        if self.error:
            raise Exception("\tDownload failed! MD5 check didn't match the one described in the Sconstruct file"+bcolors.END)
        for n in range(len(source)):
            url = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)[0]
#            print source[n]
            s = os.path.abspath(str(source[n]))
            t = os.path.abspath(str(target[n]))
            md5 = ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % s).readlines()).strip()
            if md5 == url[3]:
#                print "\tMD5 OK for file ", source[n], 
#                print "... uncompressing... "
                os.popen( "rm -rf %s 2>&1" % os.path.dirname(t) )
                cmd = "cd %s && tar xf %s 2>&1" % (os.path.dirname(os.path.dirname(str(target[n]))),s)
#                print cmd
                lines = os.popen(cmd).readlines()
                cmd =  "mv %s %s 2>&1" % (s.replace('.tar.gz',''), os.path.dirname(t))
#                print cmd
                if s.replace('.tar.gz','') != os.path.dirname(t):
                    os.system( cmd )
                if not os.path.exists(str(target[n])):
                    print '-'*120
                    for l in lines:
                        print '\t%s' % l.strip()
                    print '-'*120
                    raise Exception("Uncompress failed!")
                
                for updates in ['config.sub', 'config.guess']:
                    for file2update in os.popen('find %s -name %s 2>&1' % (os.path.dirname(t), updates) ).readlines():
                        os.popen( "cp %s/%s %s"   % (os.path.dirname(s), updates, file2update) )
                    
#            os.system("cd %s && rm -rf %s" % (buildFolder(self.args),d[1]))

    def sed( self, target, source, env):
        ''' use this method to inline patch the source code before building! 
        It's usefull to perform quick patches without a patch file!'''
        def _sed(target,source,sed):
            installDir = os.path.dirname(target)
            if not os.path.exists(installDir):
                #env.Execute( Mkdir(installDir) )
                os.makedirs(installDir)

            if os.path.isfile(source):
                cmd = 'sed \'%s\' %s > %s' % ( ';'.join(sed), source, target )
                #print '\t', cmd
                os.system( cmd )

            if os.path.isdir(source):
                for each in os.listdir(source):
                    if each[0] != '.':
                        _sed( os.path.join(target, each), os.path.join(source, each), sed )

        for n in range(len(target)):
            _sed( target[n], source[n], self.sed )


    def install(self, target, source):
        ret = source
        if self.installer:
            bld = Builder(action = self._installer)
            self.env.Append(BUILDERS = {'installer' : bld})
            ret = self.env.installer( target, ret)
        return ret
        
    def download(self,target):
        ret = target
        if self.downloader:
            ret = self.env.downloader( target )
            self.env.Clean( ret, target )
        return ret

    def uncompress(self,target, source):
        ret = self.env.uncompressor( target, source )
        for t in target:
            self.env.Clean( ret, os.path.dirname(t) )
        return ret

    def sed(self,target,source):
        ret=source
        if self.sed:
            ret = self.env.sed( target, ret)
            self.env.Clean(ret, target)
        return ret            
