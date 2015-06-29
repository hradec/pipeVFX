from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Action import *
from devRoot import *
import pipe
from pipe.bcolors import bcolors
from glob import glob

import os, traceback, sys, inspect


import multiprocessing

# initialize CORES and DCORES(double cores) env var based on the number of cores 
# the host machine has
CORES=int(multiprocessing.cpu_count())
os.environ['CORES'] = '%d' % CORES
os.environ['DCORES'] = '%d' % (2*CORES)

# we store in this list all builds that we want to make
# subsequent builds depend on. 
# As we store the scons build class, we have all the info we need 
# for the subsequent builds, including all versions build information
# so we a build can pick and choose its dependency version, if needed!
allDepend = []


# cleanup pythonpath env var!
if not os.environ.has_key('PYTHONPATH'):
    os.environ['PYTHONPATH']=''
#pythonpath_original = ':'.join(filter(lambda x: '/usr/'!=x[:5], sys.path))
pythonpath_original = ':'.join([
        os.path.abspath('../tools/python/'),
        os.environ['PYTHONPATH'], 
])
os.environ['PYTHONPATH'] = pythonpath_original 
environ_original = os.environ.copy()

# cleanup tmp folders
os.popen("rm -rf build/tmp.*").readlines()

# check if we have a faulty libGL.la installed by nvidia
file = '/usr/lib64/libGL.la'
if os.popen('''cat %s 2>&1 | grep "'/usr/lib'"''' % file).readlines():
    raise Exception(bcolors.WARNING+'''
        WARNING!
        
        The file %s is pointing to the wrong lib folder, 
        and this WILL CAUSE freeglut build to fail. 
        This is usually caused by an NVidia driver which writes 
        x64 libGL.la pointing to the x32 version!

        This can be fixed in 2 ways:
            1. remove %s (it builds fine without it!)
            2. install a newer Nvidia driver, which fixes this (since it's their fault it seems newer drivers fix it!!)
                                                                
    ''' % (file,file) + bcolors.END )


class gcc:
    ''' a simple "enum" class so we can use gcc.system/gcc.pipe instead of numbers in the code'''
    system=0
    pipe=1

class generic:
    '''
        The main build class in our system. All other build classes derive from this one, so we can put most of the
        build logic in just one place. 
        Download of packages, uncompression, running the build command, setting the environment and dealing 
        with dependencies, is all done in here.
        Also, the installation prefix is defined here.
        The parameters:

            name        = the name of the package, as it will be installed. 
                          ex: name=openexr will generate a folder structre like <libs folder>/openexr/2.0.0/<install files>
                          
            download    = its a list, where each component is a tupple of minimum 4 strings, being: 
                          ( url to download pkg , pkg file name "openexer-2.0.0.tar.gz", version "2.0.0", md5 for the file )
                          note: the pkg filename must match the folder name after uncompressing it. 
                          note: tar.gz extension must be used (if its a tar.bz2 or tgz, just put tar.gz and the class will figure out)
                          note: md5 will be show when building, if not specified. The build will fail, but it will give you the md5 to
                                copy/paste in the tupple. 
                          a 5th dict element can be added to the tupple, to specify dependency version for each pkg version, like this:
                          ( 
                            "http://oiio.com/oiio-1.5.0.tar.gz", 
                            "oiio-1.5.0.tar.gz", 
                            "1.5.0", 
                            "8c54705c424513fa2be0042696a3a162"
                            {ocio : "1.6.3"}
                          )
                          the dict has a ocio build class (previously defined), with a string telling the build should 
                          use ocio 1.6.3 to build this oiio pkg version 1.5.0.
            
            python      = a list of strings with the python versions we should build the pkgs for. 
                          if not specified, the pkg doesnt need python.
            
            depend      = a dict specifying dependency for all the pkg versions in the build, specified just like the example 
                          above (5th tupple element of download)
            
            sed         = a dinamic patch mechanism, where we can replace strings on files before building.
                          { 
                              '0.0.0' : {  # initial version this sed will be applied to - 0.0.0 applies to all!
                                    'ext/tinyxml_2_6_1.patch' : [ # lets patch file ext/tinyxml_2_6_1.patch
                                        ('-fPIC', '-fPIC -DPIC'), # add -DPIC after every -fPIC
                                        (' -fvisibility-inlines-hidden -fvisibility=hidden', ''), # remove all fvisibility 
                                    ],
                               }
                          }
            
            environ     = a dict that replaces environment variables before a build.
                          { "LDFLAGS" : "$LDFLAGS -lglib" } # adding glib library to linking
            
            compiler    = set what compiler to use when building. 
                          Options are gcc.pipe (pipe gcc 4.1.2) and gcc.system (whatever version that is installed in the host system)
            
            src         = a string that tells the build what file to look at when uncompressing. ex: Makefile when building a make based pkg
            
            cmd         = a list of commands to build the pkg and install!
                    
    '''
    src   = ''
    cmd   = ''
    extra = ''
    sed = {}
    environ = {}

    def __init__(self, args, name, download, python=pipe.libs.version.get('python'), env=None, depend={}, GCCFLAGS=[], sed=None, environ=None, compiler=gcc.pipe, **kargs):
        sys.stdout.write( bcolors.END )
        self.className = str(self.__class__).split('.')[-1]
        self.GCCFLAGS = GCCFLAGS
        self.args = args
        
        # dependency
        self.dependOn = depend
        if type(depend) == type([]):
            self.dependOn = {}
            for d in depend:
                self.dependOn[d] = None
        # add download dependency
        for d in download:
            if len(d)>4:
                self.dependOn.update(d[4])
        # add global dependency
        for d in allDepend:
            if d not in self.dependOn:
                self.dependOn[d] = None
        
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

        bld = Builder( action = Action( self.uncompressor, 'uncompress($SOURCE0 -> $TARGET)') )
        self.env.Append(BUILDERS = {'uncompressor' : bld})

        os.popen( "mkdir -p %s" % buildFolder(self.args) )
        
        # download latest config.sub and config.guess so we use then to build old packages in newer systems!
        for each in ['%s/config.sub' % buildFolder(self.args), '%s/config.guess' % buildFolder(self.args)]:
            if not os.path.exists(each) or os.path.getsize(each)==0:
                print 'Downloading latest %s' % each
                os.popen( 'wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=%s;hb=HEAD" -O %s 2>&1' % (os.path.basename(each),each) ).readlines()
                os.popen("chmod a+x %s" % each).readlines()

        
        # store the compiler type to use
        self.compiler = compiler
        self.set( "BUILD_COMPILER", self.compiler )
        
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
                self.env['TARGET_FOLDER_%s' % download[n][2].replace('.','_')] = self.targetFolder[p][-1]
                os.environ['%s_TARGET_FOLDER' % self.name.upper()] = self.targetFolder[p][-1]
                
                setup = os.path.join(self.buildFolder[p][-1], self.src)
                build = os.path.join( self.targetFolder[p][-1], 'build%s.done' % pythonDependency )
                install = os.path.join( self.targetFolder[p][-1], 'install%s.done' % pythonDependency )
                
                # if install folder has no sub-folders with content, we probably got a fail install, 
                # so force re-build!
                if not glob("%s/*/*" % self.targetFolder[p][-1]):
                    os.popen("rm -rf "+install).readlines()
                    os.popen("rm -rf "+build).readlines()
                    
                # if not installed, force uncompress!
                if not os.path.exists(install):
                    os.popen("rm -rf "+setup).readlines()
                    
                #uncompress
                s = self.uncompress(setup, pkgs)
                        
                # run the action method of the class
                # add dependencies as source 
                source = [s]
                for dependOn in self.dependOn:
                    if dependOn:
                        depend_n = self.depend_n(dependOn, download[n][2])
                        k = dependOn.depend.keys()
                        if p in k:
                            if dependOn.depend[p][depend_n] not in source:
                                source.append( dependOn.depend[p][depend_n] )
                        elif len(k)>0:
                            if dependOn.depend[k[-1]][depend_n] not in source:
                                source.append( dependOn.depend[k[-1]][depend_n] )
                
                # build
                b = self.action( build, source )
                
                # call the install builder, in case a class need to do custom installation                
                t = self.install( install, [b,source[0]] )

                self.depend[p].append(t)
                self.env.Alias( 'install', t )
                self.env.Alias( 'build-%s' % name, t )
                
    def registerSconsBuilder(self, *args):
#        name = str(args[0]).split(' ')[2].split('.')[-1]
        name = self.className
#        bld = Builder(action = args[0])
#        bld = Builder(action = Action( args[0], '%s%s($TARGET)%s' % (bcolors.GREEN,self.className,bcolors.END) ) )
        bld = Builder(action = Action( args[0], self.sconsPrint ) )
        self.env.Append(BUILDERS = {name : bld})
        return filter(lambda x: self.className==x[0], inspect.getmembers(self.env))[0][1]
        
    def sconsPrint(self, target, source, env):
        t=str(target[0])
        n=' '.join(t.split(os.path.sep)[-3:-1])
        if '.python' in t:
             n = "%s(py %s)" % (n, t.split('.python')[-1].split('.done')[0])
        print bcolors.WARNING+':'+'='*120
        print bcolors.WARNING+": "+bcolors.BLUE+"%s( %s )" % (
            self.className,
            n
        )
        print bcolors.WARNING+": "
        d=map(lambda x: '.'.join(str(x).split(os.path.sep)[-3:-1]), source[1:])
        print bcolors.WARNING+": "+bcolors.BLUE+"   depend: %s" % str(source[0])
        for n in range(0,len(d),6):
            print bcolors.WARNING+": "+bcolors.BLUE+"           %s" % ', '.join(d[n:n+6])
        print bcolors.WARNING+": "+bcolors.END
#        print bcolors.HEADER+'-'*120+bcolors.END
                     
        
    def setInstaller(self, method):
        self.installer = method

    def set(self, name, extra=''):
        self.env[name.upper()] = " "+str(extra).replace('"','\\"')
        
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
        lastlogFile = "%s/lastlog" % os.path.dirname(str(target[0]))
        if len(str(target[0]).split('.python')) > 1:
                pythonVersion = str(target[0]).split('.python')[-1].split('.done')[0]
                lastlogFile = "%s/lastlog.%s" % (os.path.dirname(str(target[0])), pythonVersion[:3])
        
        lastlog = self.__check_target_log__( lastlogFile )
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
                    self.runCMD(cmd, target, source, env)
     
            # if building for multiple python versions
            if len(str(target[0]).split('.python')) > 1:
                pythonVersion = str(target[0]).split('.python')[-1].split('.done')[0]
                targetFolder = os.path.dirname(str(target[0]))
                folder = "%s/lib/python%s/" % (targetFolder,pythonVersion[:3])
                os.popen("mkdir -p %s" % folder).readlines()
                for each in glob("%s/lib/*" % targetFolder):
                    # store all files in lib folder into lib/python$PYTHON_VERSION_MAJOR
                    if not os.path.isdir(each):
                        cmd ="mv %s %s" % (each, folder)
                        os.popen(cmd).readlines()
                    # and move everything inside a lib/python folder to lib/python$PYTHON_VERSION_MAJOR
                    # and remove lib/python
                    if os.path.basename(each) == 'python' and os.path.isdir(each):
                        cmd ="mv %s/* %s/ && rmdir %s" % (each, folder, each)
                        os.popen(cmd).readlines()
                        
                        
    
    def depend_n(self,dependOn,currVersion, dependencyList=None):
        ''' support function to find the same version of a depency
        # look in the dependency download list if we have
        # the same version number as the current package.
        # if so, use that targetFolder!
        # works for cases like openexr and ilmbase which are 
        # released with the same version!
        # also, for packages who need an specific version of a dependency to build, sets it here!
        '''
        depend_n = -1
        dependOnVersion = self.dependOn[dependOn]
        # grab dependency version from download list
        for download in filter(lambda x: x[2] == currVersion, self.downloadList):
            if len(download)>4: # 5th element is a dependency list with version
                if dependOn in download[4]:
                    dependOnVersion = download[4][dependOn]
        
        for each in range(len(dependOn.downloadList)):
#            if currVersion == '1.6.7':
#                print each, currVersion, dependOn.name, dependOn.downloadList[each][2], dependOnVersion
#                for n in self.dependOn:
#                    print n.name,self.dependOn[n]
            if dependOnVersion:
                if dependOn.downloadList[each][2] == dependOnVersion:
                    depend_n = each
                    break                    
            if dependOn.downloadList[each][2] == currVersion:
                depend_n = each
                break
#        print depend_n
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


    def runCMD(self, cmd , target, source, env):
        ''' the main method to run system calls, like configure, make, cmake, etc '''
        buildCompiler = int(filter(lambda x: 'BUILD_COMPILER' in x[0], env.items())[0][1])
        
        # restore original environment before ruuning anything.
        os_environ={}
        os_environ.update( os.environ )  
        
        # first, cleanup pipe gcc/bin folder from path, if any
        os_environ['PATH'] = os_environ['PATH'].replace(pipe.build.gcc(),'').replace('::',':')
        
        # now check if we want to use pipes gcc or not!
        if buildCompiler == gcc.pipe:
            os_environ['PATH'] = ':'.join([
                    pipe.build.gcc(),
                    os_environ['PATH'],
            ])
        
                
        target=str(target[0])
        pkgVersion = os.path.basename(os.path.dirname(target))
        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
        installDir = os.path.dirname(target)

        # set a python version if none is set
        pythonVersion = pipe.apps.baseApp("python").version()
        os_environ['PYTHON_VERSION'] = pythonVersion
        os_environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]
               
        # adjust env vars for the current selected python version
        sys.stdout.write( bcolors.FAIL )
        if len(target.split('.python')) > 1:
            pythonVersion = target.split('.python')[-1].split('.done')[0]
        
        print  os_environ['PYTHON_VERSION']+" "+pythonVersion 
#        pipe.versionLib.set(python=pythonVersion)
#        pipe.version.set(python=pythonVersion)
    
        for var in os_environ.keys():
            pp = []
            for each in os_environ[var].split(':'):
                each = each.replace('python%s' % os_environ['PYTHON_VERSION_MAJOR'], 'python%s' % pythonVersion[:3])
                if '/python/' in each:
                    each = each.replace(os_environ['PYTHON_VERSION'], pythonVersion)
                pp.append(each)
            os_environ[var] = ':'.join(pp)

        
        os_environ['PYTHON_VERSION'] = pythonVersion
        os_environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]
        pipe.apps.version.set(python=pythonVersion)

#        site_packages = os.path.join(dirLevels,installDir,'lib/python$PYTHON_VERSION_MAJOR/site-packages')
        site_packages = '/'.join([
            self.env['TARGET_FOLDER_%s' % pkgVersion.replace('.','_')],
            'lib/python%s/site-packages' % pythonVersion[:3]
        ])
        os_environ['PYTHONPATH'] = ':'.join( [
            site_packages,
            os_environ['PYTHONPATH'] ,
        ])
        
        prefix = ''
        if buildCompiler == gcc.pipe:
            prefix = 'x86_64-unknown-linux-gnu-'
        os_environ.update( {
            'CC'                : '%sgcc' % prefix,
            'CPP'               : 'cpp',
            'CXX'               : '%sg++' % prefix,
            'CXXCPP'            : 'cpp',
            'LD'                : 'ld',
            'LDSHARED'          : '%sgcc -shared' % prefix,
            'LDFLAGS'           : '',
            'CFLAGS'            : '',
            'CPPFLAGS'          : '',
            'CXXFLAGS'          : '',
            'CPPCXXFLAGS'       : '',
            'PKG_CONFIG_PATH'   : '',
            'LD_LIBRARY_PATH'   : '',
        })
        
        if not os_environ.has_key('INCLUDE'):
            os_environ['INCLUDE'] = ''
            
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
                    os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()] = dependOn.targetFolder[p][depend_n]
                    os_environ['PKG_CONFIG_PATH'] = ':'.join([
                        '%s/lib/pkgconfig/:' % dependOn.targetFolder[p][depend_n],
                        os_environ['PKG_CONFIG_PATH'],
                    ])
                    # if dependency in explicit in GCCFLAGS or 
                    # if dependency doesn't have a lib/pkconfig/*.pc file, 
                    # include the dependency folders into CFLAGS(CPPFLAGS/CXXFLAGS) and LDFLAGS parameters
#                    if dependOn in self.GCCFLAGS or not glob( "%s/lib/pkgconfig/*.pc" % dependOn.targetFolder[p][depend_n] ):
                    CFLAGS.append("-I%s/include/" % dependOn.targetFolder[p][depend_n])
                    LDFLAGS.append("-L%s/lib/" % dependOn.targetFolder[p][depend_n])
                    LDFLAGS.append("-L%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n], pythonVersion[:3]))
                        
                    os_environ['LD_LIBRARY_PATH'] = ':'.join([
                        os_environ['LD_LIBRARY_PATH'],
                        "%s/lib/" % dependOn.targetFolder[p][depend_n],
                        "%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                    ])
                    os_environ['INCLUDE'] = ':'.join([
                        "%s/include/" % dependOn.targetFolder[p][depend_n],
                        os_environ['INCLUDE'],
                    ])
                    for each in glob("%s/include/*" % dependOn.targetFolder[p][depend_n]):
                        if os.path.isdir(each):
                            os_environ['INCLUDE'] = ':'.join([
                                each,
                                os_environ['INCLUDE'],
                            ])
                        
                    os_environ['PYTHONPATH'] = ':'.join([
                        "%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        "%s/lib/python%s/site-packages/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        os_environ['PYTHONPATH'],
                    ])
                    os_environ['PATH'] = ':'.join([
                        "%s/bin/" % (dependOn.targetFolder[p][depend_n]),
                        os_environ['PATH'],
                    ])
        
        
        if CFLAGS:
            os_environ['CFLAGS']        = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os_environ['CPPFLAGS']      = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os_environ['CXXFLAGS']      = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os_environ['CPPCXXFLAGS']   = "%s" % ' '.join(CFLAGS+LDFLAGS)
            os_environ['LDFLAGS']       = "%s -L/usr/lib64" % ' '.join(LDFLAGS)

        if buildCompiler == gcc.pipe:
            os_environ['LD_LIBRARY_PATH'] = ':'.join([
                pipe.build.gcc()+'/../lib64/',
                os_environ['LD_LIBRARY_PATH'],
    #            '/usr/lib64', # temporary workaround for redhat systems
            ])
        
        # if running in fedora
#        if os.path.exists('/etc/fedora-release'):
#            os_environ['LIBRARY_PATH']      += ":/usr/lib64"
#            os_environ['LTDL_LIBRARY_PATH'] += ":/usr/lib64"
#            os_environ['LD_LIBRARY_PATH']   += ":/usr/lib64"
#            os_environ['LIB']               += ":/usr/lib64"
        
        os_environ['TARGET_FOLDER'] = self.env['TARGET_FOLDER_%s' % pkgVersion.replace('.','_')]
        os_environ['SOURCE_FOLDER'] = os.path.abspath(os.path.dirname(str(source[0])))
        
        # set extra env vars that were passed to the builder class in the environ parameter!
        for name,v in filter(lambda x: 'ENVIRON_' in x[0], self.env.items()):
            #print name.split('ENVIRON_')[-1], v.strip()
            
            env = name.split('ENVIRON_')[-1]
            bkp = ''
            
            # expand $var if exists in os_environ
            if ':' in v:
                for p in v.strip().split(':'):
                    if p[0]=='$':
                        if p[1:] in os_environ.keys():
                            bkp = os_environ[p[1:]]+':'+bkp
                            continue
                    bkp = p+':'+bkp
            else:
                for p in v.strip().split(' '):
                    if p[0]=='$':
                        if p[1:] in os_environ.keys():
                            bkp = os_environ[p[1:]]+':'+bkp
                            continue
                    bkp = p+' '+bkp
                
            os_environ[env] = bkp
        
        # update LIB and LIBRARY_PATH
        os_environ['LIB'] = os_environ['LD_LIBRARY_PATH']
        os_environ['LIBRARY_PATH'] = ':'.join([
                   os_environ['LD_LIBRARY_PATH'],
                   '/usr/lib/x86_64-linux-gnu/',
        ])
        os_environ['LTDL_LIBRARY_PATH'] = os_environ['LIBRARY_PATH']
        os_environ['PATH'] = ':'.join([
            pipe.apps.python().path('bin'),
            os_environ['PATH'],
        ])

        # set lastlog filename
        extraLabel = ''
        lastlog = '%s/lastlog' % os_environ['TARGET_FOLDER']
        if len(target.split('python')) > 1:
            lastlog = '%s.%s' % (lastlog,os_environ['PYTHON_VERSION_MAJOR'])
            extraLabel = '(python %s)' % os_environ['PYTHON_VERSION']
        # reset lastlog
        open(lastlog,'w').close()
            
        # run sed inline patch mechanism
        self.runSED(os_environ['SOURCE_FOLDER'])
        
        # run the command from inside ppython, so all pipe env vars get properly set!
        try:
            cmd = self.fixCMD(cmd)
            cmd = cmd.replace('"','\"').replace('$','\$')
            for l in cmd.split('&&'):
                print bcolors.WARNING+'\t%s%s : %s %s  %s ' % ('.'.join(os_environ['TARGET_FOLDER'].split('/')[-2:]),extraLabel,bcolors.GREEN,l.strip(),bcolors.END)
            # we need to save the current pythonpath to set it later inside pythons system call
            os_environ['BUILD_PYTHONPATH__'] = os_environ['PYTHONPATH']
            # and then we need to setup a clean PYTHONPATH so ppython can find pipe, build and the correct modules
#            os_environ['PYTHONPATH'] = pythonpath_original
            os_environ['PYTHONPATH'] = '%s/pipeline/tools/python' % pipe.depotRoot()
            cmd = 'PYTHONPATH=\\"\$BUILD_PYTHONPATH__\\" && ' + cmd
            cmd = 'cd \\"%s\\" && ' %  os_environ['SOURCE_FOLDER'] + cmd
            cmd = '''nice -n 10 %s/pipeline/tools/scripts/ppython --python_version %s --logd -c ''' % (pipe.depotRoot(),os_environ['PYTHON_VERSION'])+\
                  '''"import os,sys;ret=os.system(\'\'\''''+cmd+\
                  '''\'\'\');print '@runCMD_ERROR@'+str(ret)+'@runCMD_ERROR@';sys.exit(ret)" > %s 2>&1''' % lastlog
#            os.popen(cmd).readlines()
            from subprocess import Popen
            Popen(cmd, bufsize=-1, shell=True, executable='/bin/sh', env=os_environ).wait()
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
            for l in os_environ["PYTHON_VERSION"].split(':'):
                print l
            print cmd
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
        import hashlib
        value=hashlib.md5('').hexdigest()
        if os.path.exists(str(file)):
            value = hashlib.md5(open(str(file)).read()).hexdigest()
        return value
#        return ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % str(file)).readlines()).strip()

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
#            print "..%s...%s..." % (md5, url[3])
            if md5 == url[3]:
                import random
                tmp = int(random.random()*10000000)
                tmp = "%s/tmp.%s" % (os.path.dirname(os.path.dirname(str(target[n]))), str(tmp))
#                print "\tMD5 OK for file ", source[n], 
#                print "... uncompressing... "
#                print  "rm -rf %s 2>&1" % os.path.dirname(t)
                os.popen( "rm -rf %s 2>&1" % os.path.dirname(t) ).readlines()
                cmd = "mkdir %s && cd %s && tar xf %s 2>&1" % (tmp,tmp,s)
                lines = os.popen(cmd).readlines()
                cmd =  "mv %s/%s %s && rm -rf %s 2>&1" % (tmp, os.path.basename(s.replace('.tar.gz','')), os.path.dirname(t), tmp)
                lines += os.popen( cmd ).readlines()
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
            v  = map(lambda x: int(x), version.split('.')[:3])
            vv = map(lambda x: int(x), url[2].split('.')[:3])
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
