# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================

from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Action import *
from devRoot import *
import pipe
from pipe.bcolors import bcolors
from glob import glob

crtl_file_build   = '.build'
crtl_file_install = '.install'
crtl_file_lastlog = '.lastlog'

_spinnerCount = 0


import os, traceback, sys, inspect

tcols = int(''.join(os.popen('tput cols').readlines()))-1


import multiprocessing

buildVersions = []
def baseLib(library=None):
    ''' baseLib are libraries that are basic to build other libraries, like Python versions'''
    if library:
        buildVersions.append(library)
    return buildVersions


allPkgs = {}
__pkgInstalled__={}

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

# check if we have a faulty libGL.la installed by nvidia
f = '/usr/lib64/libGL.la'
if os.popen('''cat %s 2>&1 | grep "'/usr/lib'"''' % f).readlines():
    raise Exception(bcolors.WARNING+'''
        WARNING!

        The file %s is pointing to the wrong lib folder,
        and this WILL CAUSE freeglut build to fail.
        This is usually caused by an NVidia driver which writes
        x64 libGL.la pointing to the x32 version!

        This can be fixed in 2 ways:
            1. remove %s (it builds fine without it!)
            2. install a newer Nvidia driver, which fixes this (since it's their fault it seems newer drivers fix it!!)

    ''' % (f,f) + bcolors.END )

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


    def __init__(self, args, name, download, baseLibs=None, env=None, depend={}, GCCFLAGS=[], sed=None, environ=None, compiler=gcc.system, **kargs):
        global __pkgInstalled__
        self.__dict__.update(kargs)

        self.spinnerCount = 0

        self.args     = args
        self.name     = name
        self.download = download
        self.baseLibs = baseLibs
        self.env      = env
        self.depend   = depend
        if hasattr(self, "init"):
            self.init()
            args     = self.args
            name     = self.name
            download = self.download
            baseLibs = self.baseLibs
            env      = self.env
            depend   = self.depend

        if not self.baseLibs:
            self.baseLibs = 'noBaseLib'


        sys.stdout.write( bcolors.END )
        self.className = str(self.__class__).split('.')[-1]
        self.GCCFLAGS = GCCFLAGS
        self.args = args
        self.error = None
        self.os_environ = {}

        # cleanup tmp folders
        os.popen("rm -rf %s/tmp.*" % buildFolder(args)).readlines()

        allPkgs[name] = self

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
        if self.env is None:
            self.env = Environment()
        self.name = name

        # set the base libraries to build for.
        # we'll repeat this package build for each base library version
        if type(self.baseLibs) == type(""):
            class tmp:
                name = self.baseLibs
                downloadList = [('','','')]
            self.baseLibs = tmp

        if type(self.baseLibs) != list:
            self.baseLibs = [self.baseLibs] #noqa

        # the download list of package versions
        self.downloadList = download

        # versions:
        self.versions = {}
        for each in self.downloadList:
            self.versions[each[2]] = each

        # sed patches, per initial version
        if sed:
            self.sed  = sed
        if environ:
            self.environ  = environ

        self.installPath = installRoot(self.args)

        # cmds to build!
        self.kargs = kargs
        if kargs.has_key('cmd'):
            self.cmd = kargs['cmd']
        if type(self.cmd)==str:
            self.cmd = [self.cmd]

        if kargs.has_key('src'):
            self.src = kargs['src']

        if kargs.has_key('flags'):
            self.flags = kargs['flags']

        self.targetSuffix=""
        if kargs.has_key('targetSuffix'):
            self.targetSuffix = kargs['targetSuffix'].replace('.','_')

        self.userData = None
        if kargs.has_key('userData'):
            self.userData = kargs['userData'].replace('.','_')

#        bld = Builder(action = self.sed)
#        self.env.Append(BUILDERS = {'sed' : bld})

        self.env.AddMethod(self.downloader, 'downloader')

        # bld = Builder( action = Action( self.uncompressor, 'uncompress($SOURCE0 -> $TARGET)') )
        bld = Builder( action = Action( self.uncompressor, self.sconsPrint) )
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
            self.set(each[0].upper(), each[1])

        for each in filter(lambda x: type(x[1])==list and not '__' in x[0], inspect.getmembers(self)):
            v = each[1]
            for n in range(len(v)):
                if type(v[n])==str:
                    self.set("%s_%s_%s_%02d" % (each[0].upper(),self.className,self.name,n), v[n])

        # set extra environment variables to env
        for n in self.environ.keys():
            self.set("ENVIRON_%s" % n.upper(), self.environ[n])

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
        self.installAll = []
        for baselib in self.baseLibs:
            for baselibDownloadList in baselib.downloadList:
                p = baselib.name
                if baselibDownloadList:
                    p = "%s%s" % (baselib.name,baselibDownloadList[2])
                pythonDependency = ".%s%s" % (p,self.targetSuffix)

                self.depend[p] = []
                self.buildFolder[p] = []
                self.targetFolder[p] = []

                # if we have a real baseLib, add it as dependency
                if 'noBaseLib' not in baselib.name:
                    # if baselib not in self.dependOn:
                    #    self.dependOn[baselib] = None
                    self.dependOn.update( {baselib :  baselibDownloadList[2] } )

                # build all versions of the package specified by the download parameter
                for n in range(len(download)):

                    targetpath = os.path.join(buildFolder(self.args),download[n][1].replace('.tar.gz',pythonDependency))
                    if '.zip' in download[n][1]:
                        targetpath = os.path.join(buildFolder(self.args),download[n][1].replace('.zip',pythonDependency))
                    installpath = os.path.join( self.installPath,  self.name, download[n][2] )
                    # print "%s/install.*.done" % installpath, glob( "%s/install.*.done" % installpath )

                    # build and install folder
                    self.buildFolder[p].append( targetpath  )
                    self.targetFolder[p].append( installpath  )
                    self.env['TARGET_FOLDER_%s' % download[n][2].replace('.','_')] = self.targetFolder[p][-1]
                    os.environ['%s_TARGET_FOLDER' % self.name.upper()] = os.path.abspath(self.targetFolder[p][-1])

                    setup = os.path.join(self.buildFolder[p][-1], self.src)
                    build = os.path.join( self.targetFolder[p][-1], '%s%s.done' % (crtl_file_build, pythonDependency) )
                    install = os.path.join( self.targetFolder[p][-1], '%s%s.done' % (crtl_file_install, pythonDependency) )

                    # if install folder has no sub-folders with content, we probably got a fail install,
                    # so force re-build!
                    if not glob("%s/*/*" % self.targetFolder[p][-1]):
                        os.popen("rm -rf %s/*" % os.path.dirname(install)).readlines()

                    # file to be downloads
                    archive = os.path.join(buildFolder(self.args),download[n][1])

                    # so actions can check if its installed
                    __pkgInstalled__[os.path.abspath(archive)] = install

                    # if not installed, build!
                    if not os.path.exists(install):
                        os.popen("rm -rf "+self.buildFolder[p][-1]).readlines()

                    #download pkg
                    pkgs = self._download(archive)

                    #uncompress
                    s = self.uncompress(setup, pkgs)

                    # run the action method of the class
                    # add dependencies as source
                    source = [s]
                    for dependOn in self.dependOn:
                        if dependOn:

                            # check if this dependency applies to this version of the package!
                            # if the version has the dependency as None, we should NOT depend on
                            # it for this version! (ex: openssl for python 2.6 and not for python 2.7)
                            if len(download[n])>4:
                                __dependencyID = filter( lambda z: z.name == dependOn.name, download[n][4] )
                                if __dependencyID:
                                    if not download[n][4][__dependencyID[0]]:
                                        continue

                            # now, add all dependencies needed!
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
                    self.installAll.append(t)
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

    def sconsPrint(self, target, source, env, what=None):
        global _spinnerCount
        # if 'install' in  str(what):
        #     print bcolors.WARNING+": "+bcolors.BLUE+what+bcolors.END
        #
        if 'builder' in  str(what):
            if not self.shouldBuild( target, source ):
                return
            t=str(target[0])
            n=' '.join(t.split(os.path.sep)[-3:-1])
            if '.python' in t:
                n = "%s (py %s)" % (n, t.split('.python')[-1].split('.done')[0])
            print bcolors.WARNING+':'+'='*tcols
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
        else:
            sp="/-\|"
            print bcolors.WARNING,"checking built pkgs"+'.'*_spinnerCount,'\r',
            _spinnerCount += 1


    def set(self, name, extra=''):
        self.env[name.upper()] = " "+str(extra).replace('"','\"')

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

    def __lastlog(self, target, pythonVersion=None):
        lastlogFile = "%s/%s" % ( os.path.dirname(str(target)), crtl_file_lastlog )

        # if no pythonVersion specified, see if we can figure it out from target
        if not pythonVersion:
            if len(str(target).split('.python')) > 1:
                pythonVersion = str(target).split('.python')[-1].split('.done')[0][:3]
            if os.path.basename(os.path.dirname(os.path.dirname(str(target)))) == 'python':
                pythonVersion = '.'.join( os.path.basename(os.path.dirname(str(target))).split('.')[:2] )

        if not pythonVersion:
            pythonVersion = "1.0"

        # if we do have a python version after all, include it in the filename
        if pythonVersion:
            lastlogFile = "%s/%s.%s" % (os.path.dirname(str(target)), crtl_file_lastlog, pythonVersion)

        if self.targetSuffix:
            lastlogFile = '%s.%s' % (lastlogFile, self.targetSuffix)

        # print lastlogFile
        return os.path.abspath( lastlogFile )


    def shouldBuild(self, target, source, cmd=None):
        lastlogFile = self.__lastlog(target[0])
        lastlog = self.__check_target_log__( lastlogFile )

        if lastlog==0:
            os.popen("touch %s" % str(target[0])).readlines()
            # remove build folder since it was indeed built suscessfully
            os.system( 'rm -rf "%s"' % os.path.dirname(str(source[0])) )

        # if not lastlog:
        #     # check if dependency changed!
        #     for t in target:
        #         if os.path.exists("%s.depend" % t) and os.path.exists("%s.cmd" % t):
        #             for l in open("%s.depend" % t,'r').readlines():
        #                 if l in source:
        #                     lastlog=255
        #                     break
        #
        #         # if os.path.exists("%s.cmd" % t):
        #         #     tmp = ''.join(open("%s.cmd" % t,'r').readlines()).strip()
        #         #     if tmp != cmd.strip():
        #         #         lastlog=255
        #         # else:
        #         #     lastlog=255

        return lastlog

    def builder(self, target, source, env):
        ''' the generic builder method, used by all classes
        it simple executes all commands specified by self.cmd list '''

        # here we check if the last build was finished suscessfully
        if not self.shouldBuild( target, source ):
            return

        # put all CMD vars into a dict
        # filter only the ones that belong to this class type!
        v = {}
        for name,cmd in filter(lambda x: 'CMD' in x[0], env.items()):
            if self.className.upper() in name:
                v[name] = cmd

        # so we can sort then and use in order
        ids=v.keys()
        ids.sort()
        cmdz = []
        for name in ids:
            cmd = v[name]
            if cmd.strip():
                cmdz.append(cmd)

        if cmdz:
            self.runCMD(' && '.join(cmdz), target, source, env)

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
        return depend_n

    def __check_target_log__(self,target, install=None):
        ret=255
        if os.path.exists(target):
            lines = ''.join(open(target).readlines())
            if "@runCMD_ERROR@" in lines:
                ret = int(lines.split("@runCMD_ERROR@")[-2].strip())

        if not self.installer or install:
            if not glob("%s/*/*" % os.path.dirname(target)):
                ret = 255

        return ret


    def runCMD(self, cmd , target, source, env):
        ''' the main method to run system calls, like configure, make, cmake, etc '''
        # for each in  source:
        #     print str(each)

        buildCompiler = int(filter(lambda x: 'BUILD_COMPILER' in x[0], env.items())[0][1])

        # restore original environment before ruuning anything.
        os_environ=self.os_environ
        os_environ.update( os.environ )

        # first, cleanup pipe gcc/bin folder from path, if any
        os_environ['PATH'] = os_environ['PATH'].replace(pipe.build.gcc(),'').replace('::',':')

        target=str(target[0])
        pkgVersion = os.path.basename(os.path.dirname(target))
        pkgName    = os.path.basename(os.path.dirname(os.path.dirname(target)))
        installDir = os.path.abspath(os.path.dirname(target))
        self.version = pkgVersion
        self.versionMajor = float(''.join([ c for c in '.'.join(pkgVersion.split('.')[:2]) if c.isdigit() or c=='.']))


        # set a python version if none is set
        pythonVersion = '1.0.0' if pkgName != 'python' else pkgVersion
        if '.python' in os.path.basename(target) or pkgName == 'python':
            # pythonVersion = pipe.apps.baseApp("python").version()
            # os_environ['PYTHON_VERSION'] = pythonVersion
            # os_environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]

            # adjust env vars for the current selected python version
            sys.stdout.write( bcolors.FAIL )
            if len(target.split('.python')) > 1:
                pythonVersion = target.split('.python')[-1].split('.done')[0]
                tmp =''
                for n in pythonVersion:
                    if not n.isdigit() and n!='.':
                        break
                    tmp += n
                pythonVersion = tmp


            for var in os_environ:
                pp = []
                for each in os_environ[var].split(':'):
                    if 'PYTHON_VERSION_MAJOR' in os_environ:
                        each = each.replace('python%s' % os_environ['PYTHON_VERSION_MAJOR'], 'python%s' % pythonVersion[:3])
                    if 'PYTHON_VERSION' in os_environ:
                        if '/python/' in each:
                            each = each.replace(os_environ['PYTHON_VERSION'], pythonVersion)
                    pp.append(each)
                os_environ[var] = ':'.join(pp)

        os_environ['PYTHON_VERSION'] = pythonVersion
        os_environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]
        pipe.apps.version.set(python=pythonVersion)

        target_folder = self.env['TARGET_FOLDER_%s' % pkgVersion.replace('.','_')]
        site_packages = '/'.join([
            target_folder,
            'lib/python%s/site-packages' % pythonVersion[:3]
        ])
        os_environ['PYTHONPATH'] = ':'.join( [
            site_packages,
            os_environ['PYTHONPATH'] ,
        ])


        prefix = ''
        os_environ.update( {
            'CC'                : '%sgcc' % prefix,
            'CPP'               : 'cpp',
            'CXX'               : '%sg++' % prefix,
            'CXXCPP'            : 'cpp',
            'LD'                : 'ld',
            'LDSHARED'          : '%sgcc -shared' % prefix,
            'LDFLAGS'           : '',
            'CFLAGS'            : '',
            'CPPFLAGS'          : ' -D_GLIBCXX_USE_CXX11_ABI=0 ',
            'CXXFLAGS'          : ' -D_GLIBCXX_USE_CXX11_ABI=0 ',
            'CPPCXXFLAGS'       : '',
            'PKG_CONFIG_PATH'   : '',
            'LD_LIBRARY_PATH'   : "%s/lib/" % installDir,
            'CLICOLOR_FORCE'    : '1',
        })

        if not os_environ.has_key('INCLUDE'):
            os_environ['INCLUDE'] = ''



        CFLAGS=['-fPIC']
        LDFLAGS=[]
        gcc={
            'gcc' : 'gcc',
            'g++' : 'g++',
            'c++' : 'c++',
            'cpp' : 'cpp',
        }
        dependList={}
        sourceList = map(lambda x: os.path.basename(os.path.dirname(os.path.dirname(str(x)))), source)
        for dependOn in self.dependOn:
            if dependOn and dependOn.name not in dependList:
                # if not in the source list, skip it
                if dependOn.name not in sourceList:
                    continue

                # deal with python dependency, specially because its a noBaseLib but it has
                # the paths for its own versions.
                if 'python' in dependOn.name:
                    tmp = filter(lambda x: pythonVersion in os.path.basename(x), dependOn.targetFolder['noBaseLib'])
                    if tmp:
                        dependOn.targetFolder[os.path.basename(tmp[0])] = [tmp[0]]
                        os_environ['PYTHON_ROOT'] = tmp[0]

                depend_n = self.depend_n(dependOn, target.split('/')[-2])
                k = dependOn.targetFolder.keys()
                p = pythonVersion

                if k:
                    p = filter(lambda x: p in x, k)
                    if p:
                        p = p[0]
                    else:
                        k.sort()
                        p = k[-1]

                    if len(dependOn.targetFolder[p])==1:
                        depend_n = 0
                    dependList[dependOn.name] = dependOn.targetFolder[p][depend_n]

                    os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()] = os.path.abspath(dependOn.targetFolder[p][depend_n])
                    os_environ['%s_VERSION' % dependOn.name.upper()] = os.path.basename(dependOn.targetFolder[p][depend_n])

                    if dependOn.name == 'gcc':
                        gcc['gcc'] = 'gcc-%s' % os.path.basename(dependOn.targetFolder[p][depend_n])
                        gcc['g++'] = 'g++-%s' % os.path.basename(dependOn.targetFolder[p][depend_n])
                        gcc['cpp'] = 'cpp-%s' % os.path.basename(dependOn.targetFolder[p][depend_n])
                        gcc['c++'] = 'c++-%s' % os.path.basename(dependOn.targetFolder[p][depend_n])

                    if p in dependOn.buildFolder:
                        os_environ['%s_SRC_FOLDER' % dependOn.name.upper()   ] = os.path.abspath(dependOn.buildFolder[p][depend_n])
                    else:
                        os_environ['%s_SRC_FOLDER' % dependOn.name.upper()   ] = os.path.abspath(dependOn.buildFolder['noBaseLib'][depend_n])

                    os_environ['PKG_CONFIG_PATH'] = ':'.join([
                        '%s/lib/pkgconfig/:' % dependOn.targetFolder[p][depend_n],
                        os_environ['PKG_CONFIG_PATH'],
                    ])
                    # if dependency in explicit in GCCFLAGS or
                    # if dependency doesn't have a lib/pkconfig/*.pc file,
                    # include the dependency folders into CFLAGS(CPPFLAGS/CXXFLAGS) and LDFLAGS parameters
                    # if dependOn in self.GCCFLAGS or not glob( "%s/lib/pkgconfig/*.pc" % dependOn.targetFolder[p][depend_n] ):
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
                            CFLAGS.append("-I%s" % each)

                    os_environ['PYTHONPATH'] = ':'.join([
                        "%s/lib/python%s/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        "%s/lib/python%s/site-packages/" % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),
                        '%s/lib/python%s/lib-dynload/' % (dependOn.targetFolder[p][depend_n],pythonVersion[:3]),

                        os_environ['PYTHONPATH'],
                    ])
                    os_environ['PATH'] = ':'.join([
                        "%s/bin/" % (dependOn.targetFolder[p][depend_n]),
                        os_environ['PATH'],
                    ])

                    for each in dependOn.environ:
                        sep = ' '
                        if dependOn.environ[each] and type(dependOn.environ[each])==str:
                            if dependOn.environ[each][0] == '/':
                                sep = ':'

                            cleanV = ' '
                            for v in dependOn.environ[each].split(' '):
                                if v[0] != '$':
                                    cleanV += v+' '

                            # print dependOn.name, each, cleanV, sep
                            if each in os_environ:
                                os_environ[each] = sep.join([
                                    os_environ[each],
                                    cleanV
                                ])
                            else:
                                os_environ[each] = cleanV



        os_environ['CFLAGS']        += "%s" % ' '.join(CFLAGS+LDFLAGS)
        os_environ['CPPFLAGS']      += "%s" % ' '.join(CFLAGS+LDFLAGS)
        os_environ['CXXFLAGS']      += "%s" % ' '.join(CFLAGS+LDFLAGS)
        os_environ['CPPCXXFLAGS']   += "%s" % ' '.join(CFLAGS+LDFLAGS)
        os_environ['LDFLAGS']       = "%s -L/usr/lib64 %s" % (' '.join(LDFLAGS), os_environ['LDFLAGS'])
        os_environ['LLDFLAGS']      = "%s -L/usr/lib64 %s" % (' '.join(LDFLAGS), os_environ['LDFLAGS'])


        #os_environ['LD_RUN_PATH'] = os_environ['LD_LIBRARY_PATH']
        # if running in fedora
        # if os.path.exists('/etc/fedora-release'):
        #     os_environ['LIBRARY_PATH']      += ":/usr/lib64"
        #     os_environ['LTDL_LIBRARY_PATH'] += ":/usr/lib64"
        #     os_environ['LD_LIBRARY_PATH']   += ":/usr/lib64"+
        #     os_environ['LIB']               += ":/usr/lib64"

        os_environ['TARGET_FOLDER'] = self.env['TARGET_FOLDER_%s' % pkgVersion.replace('.','_')]
        os_environ['SOURCE_FOLDER'] = os.path.abspath(os.path.dirname(str(source[0])))

        # set extra env vars that were passed to the builder class in the environ parameter!
        for name,v in filter(lambda x: 'ENVIRON_' in x[0], self.env.items()):
            # print name.split('ENVIRON_')[-1], v.strip()

            env = name.split('ENVIRON_')[-1]
            bkp = ''

            # expand $var if exists in os_environ
            if '/' in v:
                for p in v.strip().split(':'):
                    if p:
                        if p[0]=='$':
                            if p[1:] in os_environ.keys():
                                bkp = os_environ[p[1:]]+':'+bkp
                                continue
                        bkp = p+':'+bkp
            else:
                for p in v.strip().split(' '):
                    if p:
                        if p[0]=='$':
                            if p[1:] in os_environ.keys():
                                bkp = os_environ[p[1:]]+':'+bkp
                                continue
                        bkp = p+' '+bkp

            os_environ[env] = bkp.strip(':').strip(' ')


        # update LIB and LIBRARY_PATH
        os_environ['LIB'] = os_environ['LD_LIBRARY_PATH']
        os_environ['LIBRARY_PATH'] = ':'.join([
            os_environ['LD_LIBRARY_PATH'],
            '/usr/lib/x86_64-linux-gnu/',
        ])
        os_environ['LTDL_LIBRARY_PATH'] = os_environ['LIBRARY_PATH']

        # os_environ['PATH'] = ':'.join([
        #     pipe.apps.python().path('bin'),
        #     os_environ['PATH'],
        # ])

        # set lastlog filename
        extraLabel = ''
        lastlog = self.__lastlog( target, os_environ['PYTHON_VERSION_MAJOR'])
        if 'noBaseLib' not in target:
            extraLabel = '(python %s)' % os_environ['PYTHON_VERSION']

        # reset lastlog
        open(lastlog,'w').close()
        if hasattr(self, 'preSED'):
            self.preSED(pkgVersion, lastlog)

        # run sed inline patch mechanism
        self.runSED(os_environ['SOURCE_FOLDER'])

        # run the command from inside ppython, so all pipe env vars get properly set!
        self.os_environ = os_environ
        cmd = self.fixCMD(cmd)

        # apply patches, if any!
        if hasattr(self, 'patch'):
            if self.patch:
                cmd = ' && '.join([ self.__patches(self.patch), cmd ])

        cmd = cmd.replace('"','\"') #.replace('$','\$')
        for l in cmd.split('&&'):
            print bcolors.WARNING+':\t%s%s : %s %s  %s ' % ('.'.join(os_environ['TARGET_FOLDER'].split('/')[-2:]),extraLabel,bcolors.GREEN,l.strip(),bcolors.END)
        # we need to save the current pythonpath to set it later inside pythons system call
        os_environ['BUILD_PYTHONPATH__'] = os_environ['PYTHONPATH']
        # and then we need to setup a clean PYTHONPATH so ppython can find pipe, build and the correct modules
        #    os_environ['PYTHONPATH'] = pythonpath_original

        pipeFile = ' > %s 2>%s.err' % (lastlog, lastlog)
        cmd = cmd.replace( '&&', ' %s && ' % pipeFile )

        # go to build folder before anything!!
        cmd  = 'cd \"%s\" && ' %  os_environ['SOURCE_FOLDER'] + cmd
        cmd += pipeFile+' ; echo "@runCMD_ERROR@ $? @runCMD_ERROR@"  >> %s 2>&1' % lastlog

        # remove Paths that don't exist from os_environ
        for each in os_environ:
            if '/' in os_environ[each] and ':' in os_environ[each]:
                cleaned = []
                for p in os_environ[each].split(':'):
                    # we want to keep install folder in the path, even if doens't exists,
                    # just in case the build will need to use for testing/install after build
                    if os.path.exists(p) or installDir in p:
                        cleaned.append(p)
                os_environ[each] = ':'.join(cleaned)

        # use dependency gcc, if any!
        os_environ['CC']  = "%s %s" % (gcc['gcc'], os_environ['CC'].replace(':',"").replace('gcc',''))
        os_environ['CXX'] = "%s %s" % (gcc['g++'], os_environ['CXX'].replace(':',"").replace('g++',''))


        if gcc['gcc'] != 'gcc':
            tmp = glob('%s/lib/gcc/x86_64-pc-linux-gnu/*' % os_environ['GCC_TARGET_FOLDER'])
            os_environ['LD_LIBRARY_PATH'] = ':'.join(tmp+[
                'lib/gcc/x86_64-pc-linux-gnu/lib64/',
                os_environ['LD_LIBRARY_PATH']
            ])
            os_environ['PATH'] = ':'.join([
                '%s/bin' % os_environ['GCC_TARGET_FOLDER'],
                os_environ['PATH'],
            ])

        from subprocess import Popen
        proc = Popen(cmd, bufsize=-1, shell=True, executable='/bin/sh', env=os_environ, close_fds=True)
        proc.wait()
        ret = self.__check_target_log__(lastlog)
        if ret == 0:
            f = open(target,'a')
            for each in open(lastlog).readlines():
                f.write(each)
            f.close()
            f = open("%s.depend" % target,'w')
            for each in dependList:
                f.write('%s\n' % dependList[each])
            f.close()
            f = open("%s.cmd" % target,'w')
            f.write('%s\n' % cmd)
            f.close()
            os.system('rm -rf "%s"' % os_environ['SOURCE_FOLDER'])
        else:
            print  '-'*tcols
            os.system( 'cat %s.err | source-highlight -f esc -s errors' % lastlog )
            #for each in open("%s.err" % lastlog).readlines() :
            #    print '::\t%s' % each.strip()
            print ret
            #print '-'*tcols
            #pprint(os_environ)
            print '-'*tcols
            print bcolors.FAIL,
            print traceback.format_exc(), #.print_exc()
            print bcolors.END
            print cmd
            print '-'*tcols
            sys.stdout.flush()
            os.chdir(os_environ['SOURCE_FOLDER'])
            proc=Popen("/bin/sh", bufsize=-1, shell=True, executable='/bin/sh', env=os_environ, close_fds=True)
            proc.wait()
            raise Exception('Error!')

        print bcolors.END,



    def setInstaller(self, method):
        self.installer = method

    def installer(self, target, source, env): # noqa
        ''' virtual method may be implemented by derivated classes in case installation needs to be done by copying or moving files.'''
        pass

    def _installer(self, target, source, env):
        ''' a wrapper class to create target in case installer method is suscessfull!
        we do this so whoever implements a installer don't have to bother!'''
        ret = self.installer( target, source, env )
        f=open(str(target[0]),'w')

        if ret:
            f.write(''.join(ret))
        else:
            f.write(' ')
        f.close()


    def md5(self, fileName):
        import hashlib
        value="nao exist!!" # hashlib.md5('').hexdigest()
        if os.path.exists(str(fileName)):
            if not os.stat(str(fileName)).st_size == 0:
                value = hashlib.md5(open(str(fileName)).read()).hexdigest()

        return value
#        return ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % str(file)).readlines()).strip()

    def downloader( self, env, source, _url=None):
        ''' this method is a builder responsible to download the packages to be build '''
        global __pkgInstalled__
        self.error = None
        source = [source]
        for n in range(len(source)):
            # print __pkgInstalled__[os.path.abspath(source[n])]
            if not os.path.exists(__pkgInstalled__[os.path.abspath(source[n])]):
                url=_url
                if not url:
                    url = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)[0]
                md5 = self.md5(source[n])
                if md5 != url[3]:
                    print bcolors.GREEN,
                    print "\tDownloading %s..." % source[n]
                    print bcolors.END,
                    os.popen("wget --timeout=15 '%s' -O %s >%s.log 2>&1" % (url[0], source[n], source[n])).readlines()
    #                lines = os.system("curl '%s' -o %s 2>&1" % (url[0], source[n]))
                    if os.stat(source[n]).st_size == 0:
                        raise Exception ("error downloading %s" % source[n])
                    md5 = self.md5(source[n])
                    if md5 != url[3]:
                        sys.stdout.write( bcolors.WARNING )
                        print "\tmd5 for file:", url[1], md5
                        sys.stdout.write( bcolors.FAIL )
                        sys.stdout.flush()
                        self.error = True
            else:
                open(str(source[n]), 'w').close()

        return source


    def uncompressor( self, target, source, env):
        ''' this method is a builder responsible to uncompress the packages to be build '''
        global __pkgInstalled__
        if self.error:
            raise Exception("\tDownload failed! MD5 check didn't match the one described in the Sconstruct file"+bcolors.END)



        self.shouldBuild( target, source )
        for n in range(len(source)):
            url = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)[0]
            # print source[n]
            s = os.path.abspath(str(source[n]))
            t = os.path.abspath(str(target[n]))
            md5 = self.md5(source[n])
            # print "..%s...%s..." % (md5, url[3])
            if md5 == url[3]:
                import random
                tmp = int(random.random()*10000000)
                tmp = "%s/tmp.%s" % (os.path.dirname(os.path.dirname(str(target[n]))), str(tmp))
                # print "\tMD5 OK for file ", source[n],
                # print  "rm -rf %s 2>&1" % os.path.dirname(t)
                # print self.__lastlog(__pkgInstalled__[s]), s, t
                python = None
                if '.python' in t:
                    python = '.'.join( t.split('.python')[-1].split('.')[:2] )

                # print self.__lastlog(__pkgInstalled__[s],python)

                # if not os.path.exists(self.__lastlog(__pkgInstalled__[s],python)):
                if self.__check_target_log__( self.__lastlog(__pkgInstalled__[s],python) ):
                    print ": uncompressing... ", os.path.basename(s), '->', os.path.dirname(t).split('.build')[-1], self.__lastlog(__pkgInstalled__[s])
                    os.popen( "rm -rf %s 2>&1" % os.path.dirname(t) ).readlines()
                    cmd = "mkdir %s && cd %s && tar xf %s 2>&1" % (tmp,tmp,s)
                    if '.zip' in s:
                        cmd = "mkdir %s && cd %s && unzip %s 2>&1" % (tmp,tmp,s)
                        print cmd
                    lines = os.popen(cmd).readlines()
                    cmd =  "mv %s/%s %s && rm -rf %s 2>&1" % (tmp, os.path.basename(s.replace('.tar.gz','').replace('.zip','')), os.path.dirname(t), tmp)
                    lines += os.popen( cmd ).readlines()
                    if not os.path.exists(str(target[n])):
                        print '-'*tcols
                        for l in lines:
                            print '\t%s' % l.strip()
                        print '-'*tcols
                        raise Exception("Uncompress failed!")

                    for updates in ['config.sub', 'config.guess']:
                        for file2update in os.popen('find %s -name %s 2>&1' % (os.path.dirname(t), updates) ).readlines():
                            os.popen( "cp %s/%s %s"   % (os.path.dirname(s), updates, file2update) )
                else:
                    os.mkdir(os.path.dirname(s))
                    f=open(s, 'w')
                    f.write(' ')
                    f.close()


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
        a newer sed version means it replaces the older sed versions!!!

        in the example above:
            sed version 0.0.0 will be applied to all versions of the pkg up until 2.0.99...
            sed version 2.1.0 will be applied to all versions from 2.1.0 up. In this case, 0.0.0 will NOT be applied!
        '''
        ids = self.sed.keys()
        ids.sort()
        ids.reverse()
        tmp = os.path.basename(t).split('.python')[0]
        if '.noBaseLib' in t:
            tmp = os.path.basename(t).split('.noBaseLib')[0]
        url = filter(lambda x: tmp in x[1], self.downloadList)[0]
        for version in ids:
            v  = map(lambda x: int(x), version.split('.')[:3])
            vv = map(lambda x: int(''.join(filter(lambda z: z.isdigit(),x))), url[2].split('.')[:3])
            if vv[0]>=v[0] and vv[1]>=v[1] and vv[2]>=v[2]:
                for each in self.sed[version]:
                    f = "%s/%s" % (t,each)
                    # we make a copy of the original file, before running sed
                    # if we already have a copy, we restore it before running sed
                    if os.path.exists("%s.original" % f):
                        os.popen("cp %s.original %s" % (f,f)).readlines()
                    else:
                        os.popen("cp %s %s.original" % (f,f)).readlines()
                    # apply seds
                    for sed in self.sed[version][each]:
                        cmd = '''sed -i.bak %s -e "s/%s/%s/g" ''' % (
                            f,
                            sed[0].replace('/','\/').replace('$','\$').replace('\n','\\n').replace('#','\#').replace('"','\\"'),
                            sed[1].replace('/','\/').replace('$','\$').replace('\n','\\n').replace('"','\\"')
                        )
                        # print "\n\n"+cmd+"\n\n"
                        os.popen(cmd).readlines()
                break

    def install(self, target, source):
        ret = source
        if self.installer:
            bld = Builder(action = Action( self._installer, self.sconsPrint) )
            self.env.Append(BUILDERS = {'installer' : bld})
            ret = self.env.installer( target, ret)
        return ret

    def _download(self,target):
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


    def __patches(self, patchList):
        # apply patches
        count = 0
        ret = []
        for p in patchList:
            count += 1
            patchName = "/tmp/__patch.%0d.%s" % (count,self.name)
            f = open(patchName, "w")
            # because we want to store patch text in a list with proper python identation
            # we need to mangle the patch text to remove the trailing spaces here!
            # we also make sure that, if a \ at the end of a line was used in the patch, we use '    +' to
            # re-create a newline \n! (since even with ''' python still understand the \ and uses it insead of
            # just storing it as is!)
            firstOnly = 1
            tabs = 0
            for line in p.replace('     +','\n+').split('\n'):
                if firstOnly:
                    l = line.lstrip()
                    if l:
                        tabs = len(line) - len(l)
                        firstOnly = 0
                if len(line) and line[0] == ' ':
                    f.write('%s\n' % line[tabs:])
                else:
                    f.write('%s\n' % line)
            f.close()
            ret.append('cat %s | patch -p1 ; echo %s' % (patchName, patchName))
        return ';'.join(ret)


    @staticmethod
    def pkg(download, pkg, version=None):
        ''' # a function to manipulate the download list so we can switch dependency versions
        on all download versions and delete pkg dependency from all versions
        This method is specially usefull when we need to build the same pkg multiple times,
        with different pkg depency versions. (like cortex that need to be build against all boost versions)
        '''
        # allways make a copy fo the original download, so we can
        # change the dependency as we see fit!
        hdownload = []
        for n in range(len(download)):
            hdownload.append( [ download[n][0], download[n][1], download[n][2], download[n][3], {} ] )
            for i in download[n][4]:
                if i != pkg:
                    hdownload[n][4][i] = download[n][4][i]
                if version != None:
                    hdownload[n][4][pkg] = version
        return hdownload
