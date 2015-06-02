from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *
import pipe
from pipe.bcolors import bcolors
from glob import glob

import os, traceback, sys, inspect


import multiprocessing

CORES=int(multiprocessing.cpu_count())
os.environ['CORES'] = '%d' % CORES
os.environ['DCORES'] = '%d' % (2*CORES)

allDepend = []

environ_original = os.environ.copy()


class generic:
    src   = ''
    cmd   = ''
    extra = ''
    sed = {}
    environ = {}

    def __init__(self, args, name, download, python=pipe.libs.version.get('python'), env=None, depend=None, GCCFLAGS=[], sed=None, environ=None, **kargs):
        sys.stdout.write( bcolors.END )
        self.className = str(self.__class__).split('.')[-1]
        self.GCCFLAGS = GCCFLAGS
        self.args = args
        
        # dependency
        self.dependOn = depend
        if type(self.dependOn) != type([]):
            self.dependOn = [depend]
        # add global dependency
        self.dependOn += allDepend 
        
        self.env = env
        if self.env==None:
            self.env = Environment()
        self.name = name
        self.pythonVersion = python
        if type(python) != type([]):
            self.pythonVersion = [python]

        self.downloadList = download
        if sed:
            self.sed  = sed
        if environ:
            self.environ  = environ
                        
        self.installPath = installRoot(self.args)
        
        
        if kargs.has_key('cmd'):
            self.cmd = kargs['cmd']
        if type(self.cmd)==str:
            self.cmd = [self.cmd]
            
        if kargs.has_key('src'):
            self.src = kargs['src']
        
#        bld = Builder(action = self.sed)
#        self.env.Append(BUILDERS = {'sed' : bld})
        
        self.env.AddMethod(self.downloader, 'downloader')

        bld = Builder(action = self.uncompressor)
        self.env.Append(BUILDERS = {'uncompressor' : bld})

        os.popen( "mkdir -p %s" % buildFolder(self.args) )
        
        # download latest config.sub and config.guess so we use then to build old packages in newer systems!
        for each in ['%s/config.sub' % buildFolder(self.args), '%s/config.guess' % buildFolder(self.args)]:
            if not os.path.exists(each) or os.path.getsize(each)==0:
                print 'Downloading latest %s' % each
                os.popen( 'wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=%s;hb=HEAD" -O %s 2>&1' % (os.path.basename(each),each) ).readlines()
                os.popen("chmod a+x %s" % each).readlines()

        
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
        for name in self.environ.keys():
            self.set("ENVIRON_%s" % name.upper(), self.environ[name])

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
        
        lastlog = self.__check_target_log__( "%s/lastlog" % os.path.dirname(str(target[0])))
        if lastlog==0:
            os.popen("touch %s" % str(target[0])).readlines()

        else:                            
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
                    cmd = cmd.replace('"','\"')
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
        try:
            if os.path.exists(target):
                lines = open(target).readlines()
                ret = int(''.join(lines[-3:]).split("@runCMD_ERROR@")[-2].strip())
        except:
            pass
        return ret


    def runCMD(self, cmd , target, source):
        ''' the main method to run system calls, like configure, make, cmake, etc '''
        # restore original environment before ruuning anything.
        for each in os.environ:
            if each not in environ_original.keys():
                os.environ[each] = ''
            else:
                os.environ[each] = environ_original[each]
        
        target=str(target[0])
        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
        installDir = os.path.dirname(target)
               
        # adjust env vars for the current selected python version
        sys.stdout.write( bcolors.FAIL )
        pythonVersion = pipe.versionLib.get('python')
        if len(target.split('python')) > 1:
            if not os.environ.has_key('PYTHON_VERSION_MAJOR'):
                os.environ['PYTHON_VERSION_MAJOR'] =   '.'.join(map(lambda x: str(x),sys.version_info[:2]))
            if not os.environ.has_key('PYTHON_VERSION'):
                os.environ['PYTHON_VERSION'] =   '.'.join(map(lambda x: str(x),sys.version_info[:3]))
                
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
            
        os.environ.update( {
            'CC'                : 'gcc',
            'CPP'               : 'cpp',
            'CXX'               : 'g++',
            'CXXCPP'            : 'cpp',
            'LD'                : 'ld',
            'LDSHARED'          : 'gcc -shared',
            'LDFLAGS'           : '',
            'CFLAGS'            : '',
            'CPPFLAGS'          : '',
            'CXXFLAGS'          : '',
            'CPPCXXFLAGS'       : '',
            'PKG_CONFIG_PATH'   : '',
            'LD_LIBRARY_PATH'   : '',
        })
        
        if not os.environ.has_key('INCLUDE'):
            os.environ['INCLUDE'] = ''
            
        CFLAGS=['-fPIC']
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
                    # if dependency in explicit in GCCFLAGS or 
                    # if dependency doesn't have a lib/pkconfig/*.pc file, 
                    # include the dependency folders into CFLAGS(CPPFLAGS/CXXFLAGS) and LDFLAGS parameters
#                    if dependOn in self.GCCFLAGS or not glob( "%s/lib/pkgconfig/*.pc" % dependOn.targetFolder[p][depend_n] ):
                    CFLAGS.append("-I%s/include/" % dependOn.targetFolder[p][depend_n])
                    LDFLAGS.append("-L%s/lib/" % dependOn.targetFolder[p][depend_n])
                    LDFLAGS.append("-L%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n], pythonVersion[:3]))
                        
                    os.environ['LD_LIBRARY_PATH'] = ':'.join([
                        os.environ['LD_LIBRARY_PATH'],
                        "%s/lib/" % dependOn.targetFolder[p][depend_n],
                        "%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                    ])
                    os.environ['INCLUDE'] = ':'.join([
                        "%s/include/" % dependOn.targetFolder[p][depend_n],
                        os.environ['INCLUDE'],
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
            os.environ['CFLAGS']    = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os.environ['CPPFLAGS']  = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os.environ['CXXFLAGS']  = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os.environ['CPPCXXFLAGS']  = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os.environ['LDFLAGS']   = "%s" % ' '.join(LDFLAGS)
                        
        os.environ['LD_LIBRARY_PATH'] = ':'.join([
            os.path.dirname(''.join(os.popen('which gcc').readlines()))+'/../lib64/',
            os.environ['LD_LIBRARY_PATH'],
        ])
        os.environ['LIB'] = os.environ['LD_LIBRARY_PATH']
        os.environ['LIBRARY_PATH'] = ':'.join([
                   os.environ['LD_LIBRARY_PATH'],
                   '/usr/lib/x86_64-linux-gnu/',
        ])
        os.environ['PATH'] = ':'.join([
            pipe.libs.python().path('bin'),
            os.environ['PATH'],
        ])
        os.environ['TARGET_FOLDER'] = self.env['TARGET_FOLDER']
        os.environ['SOURCE_FOLDER'] = os.path.abspath(os.path.dirname(str(source[0])))
        
        # set extra env vars that were passed to the builder class in the environ parameter!
        for name,v in filter(lambda x: 'ENVIRON_' in x[0], self.env.items()):
            os.environ[name.split('ENVIRON_')[-1]] = v.strip()

        # set lastlog filename
        lastlog = '%s/lastlog' % os.environ['TARGET_FOLDER']
        if len(target.split('python')) > 1:
            lastlog = '%s.%s' % (lastlog,os.environ['PYTHON_VERSION_MAJOR'])
        # reset lastlog
        open(lastlog,'w').close()
            
        # run sed inline patch mechanism
        self.runSED(os.environ['SOURCE_FOLDER'])
        
        # run the command from inside ppython, so all pipe env vars get properly set!
        try:
            cmd = 'cd "%s" && ' %  os.environ['SOURCE_FOLDER'] + cmd
            cmd = '''ppython --python_version $PYTHON_VERSION --logd -c '''+\
                  '''"import os,sys;ret=os.system(\'\'\''''+cmd+\
                  '''\'\'\');print '@runCMD_ERROR@'+str(ret)+'@runCMD_ERROR@';sys.exit(ret)" >%s 2>&1''' % lastlog
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
        ''' a wrapper class to create target in case installer method is suscessfull! 
        we do this so homever implements a installer don't have to bother!'''
        ret = self.installer( target, source, env )
        f=open(str(target[0]),'w')
        if ret:
            f.write(''.join(ret))
        else:
            f.write(' ')
        f.close()

    def md5(self, file):
        return ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % str(file)).readlines()).strip()

    def downloader( self, env, source, _url=None):        
        ''' this method is a builder responsible to download the packages to be build '''
        self.error = None
        source = [source]
        for n in range(len(source)):
            url=_url
            if not url:
                url = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)[0]
            md5 = self.md5(source[n])
            if md5 != url[3]:
                print "\tDownloading %s..." % source[n]
                lines = os.popen("wget '%s' -O %s >%s.log 2>&1" % (url[0], source[n], source[n])).readlines()
                md5 = self.md5(source[n])
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
            md5 = self.md5(source[n])
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
                        
        
    def runSED(self,t):
        ''' this method applies sed substitution to files specified in the sed dictionary. 
        The structure for the sed dict is as follow:
            sed = {
                '0.0.0' : { # the inital version of the package this sed will be applied
                    'file' : [ # the filename to apply the sed to
                        ( 'string to replace', 'string to replace' ), # a tupple with the replace strings
                        ( 'string to replace 2', 'string to replace 2' ), # a tupple with the replace strings
                    ],
                    'file2' : [ # another filename to apply the sed to
                        ( 'string to replace', 'string to replace' ), # a tupple with the replace strings
                    ],
                },
                '2.1.0' : { # this sed will be applied to all versions equal or above 2.1.0, instead of sed 0.0.0
                    ...
                },
            }
            
        this way we can have multiple seds for different versions of packages.
        '''
        ids = self.sed.keys()
        ids.sort()
        ids.reverse()
        url = filter(lambda x: os.path.basename(t).split('.python')[0] in x[1], self.downloadList)[0]
        for version in ids:
            v  = map(lambda x: int(x), version.split('.'))
            vv = map(lambda x: int(x), url[2].split('.'))
            if vv[0]>=v[0] and vv[1]>=v[1] and vv[2]>=v[2]: 
                for each in self.sed[version]:
                    file = "%s/%s" % (t,each)
                    # we make a copy of the original file, before running sed
                    # if we already have a copy, we restore it before running sed
                    if os.path.exists("%s.original" % file):
                        os.popen("cp %s.original %s" % (file,file)).readlines()
                    else:
                        os.popen("cp %s %s.original" % (file,file)).readlines()
                    # apply seds
                    for sed in self.sed[version][each]:
                        cmd = '''sed -i.bak %s -e "s/%s/%s/g" ''' % (
                            file,
                            sed[0].replace('/','\/').replace('$','\$'), 
                            sed[1].replace('/','\/').replace('$','\$')
                        )
                        #print cmd
                        os.popen(cmd).readlines()
                    
#            os.system("cd %s && rm -rf %s" % (buildFolder(self.args),d[1]))

#    def sed( self, target, source, env):
#        ''' use this method to inline patch the source code before building! 
#        It's usefull to perform quick patches without a patch file!'''
#        def _sed(target,source,sed):
#            installDir = os.path.dirname(target)
#            if not os.path.exists(installDir):
#                #env.Execute( Mkdir(installDir) )
#                os.makedirs(installDir)

#            if os.path.isfile(source):
#                cmd = 'sed \'%s\' %s > %s' % ( ';'.join(sed), source, target )
#                #print '\t', cmd
#                os.system( cmd )

#            if os.path.isdir(source):
#                for each in os.listdir(source):
#                    if each[0] != '.':
#                        _sed( os.path.join(target, each), os.path.join(source, each), sed )

#        for n in range(len(target)):
#            _sed( target[n], source[n], self.sed )


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

#    def sed(self,target,source):
#        ret=source
#        if self.sed:
#            ret = self.env.sed( target, ret)
#            self.env.Clean(ret, target)
#        return ret            
