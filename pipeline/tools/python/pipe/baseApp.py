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

import log
from environ import environ as _environ
from base import depotRoot, roots, platform, py, arch, WIN, OSX, LIN, runProcess, taskset, vglrun

import admin

import os, sys, stat, shutil, traceback
from glob import glob
from multiprocessing import cpu_count
import cached

from bcolors import bcolors

libraries_with_versioned_names = [
    'boost',
    'tiff',
    'jpeg',
    'libpng',
    'libraw',
    'oiio',
    'openvdb',
    'alembic',
]


def wacom():
    ''' check if wacon is attached '''
    return map( lambda x: x.strip(), cached.popen('xsetwacom --list').readlines() )

def root(platform=platform, arch=arch):
    return roots.apps(platform, arch)

def getMacAddress():
    return cached.popen( "echo $(ifconfig | grep -B1 eth0 | awk '{print toupper($0)}') | cut -d' ' -f5" ).readlines()[0].strip()


class cache:
    ''' class used to deal with wine caches '''
    @staticmethod
    def rmtree(path):
        if os.path.exists( path ):
            if os.path.islink( path ):
                try:os.remove( path )
                except: pass
            elif os.path.isfile( path ):
                try:os.remove( path )
                except: pass
            else:
                shutil.rmtree( path )

    @staticmethod
    def makedirs(path):
        if path:
            if not os.path.exists( path ):
                os.makedirs( path )

    @staticmethod
    def copy(pathFrom, pathTo, symlinks=True ):
        cache.rmtree( pathTo )
        if os.path.isdir( pathFrom ):
            shutil.copytree( pathFrom, pathTo, symlinks )
        elif os.path.isfile( pathFrom ):
            shutil.copy( pathFrom, pathTo )

    @staticmethod
    def copytree(pathFrom, pathTo, fileToCheck=None, symlinks=True):
        if not fileToCheck:
            fileToCheck = pathTo
        if not os.path.exists( fileToCheck ):
            cache.copy( pathFrom, pathTo, symlinks )



class appsDB(dict):
    '''
    appsDB gather all installed software for the current platform (pipeline.platform)
    and stores on itself with the following data:
        versions - a list of all installed versions
        path - a cache of the filesystem absolut path
        environ - a list of methods that configure the runtime environment for the app
        defaultVersion - the version to use
    '''

    def root(self):
        """

        :return:
        """
        return roots.apps(self.platform, self.arch)

    def __init__(self, appName=None, platform=platform, arch=arch):
        dict.__init__(self)
        self.latest = {}
        self.app = appName

        self.win = WIN in platform
        self.osx =  OSX in platform
        self.linux = LIN in platform
        self.arch = arch
        self.platform = platform
        self.py = py

        self.so = '.so'
        if self.osx:
            self.so = '.dylib'
        elif self.win:
            self.so = '.dll'

        # look for all apps in the apps folder and populate the
        # class with the names on it.
        app = '*'
        if self.app:
            app =  self.app

        # cache the glob result so we avoid doing thousands of globs
        # CACHE='__CACHE_GLOB_%s__' % str(self.__class__).split('.')[-1].split("'")[0]
        # if CACHE in os.environ:
        #     globz = eval(os.environ[CACHE])
        # else:
        #     globz = glob('%s/%s' % (self.root(),app))
        #     os.environ[CACHE] = str(globz)

        globz = cached.glob('%s/%s' % (self.root(),app))
        for app in globz:
            appDict = {
                'defaultVersion' : None,
                'versions' : [],
                'path' : app,
                'environ' : [],
            }
            # look for all versions available and populate the app dict with then
            for version in cached.glob('%s/*' % app):
                # get only the version, not the full path!
                version = os.path.basename(version)

                # only consider versions starting with a number!
#                if filter( lambda x: version[0] in str(x), range(0,10)):
                appDict['versions'].append( version )

            # if app has a version, store the app.
            if appDict['versions']:
                app = os.path.basename(app)
                self[app] = appDict
                self[app]['versions'].sort()
                self[app]['versions'].reverse()
                self[app]['defaultVersion'] = self[app]['versions'][0]
                self.latest[app] = self[app]['versions'][0]


    def setApp( self, appName=None):
        '''
        set the current app
        '''
        if appName:
            self.__init__(appName)

    def version(self, ver=None, appName=None):
        '''
        set and retrieve the current used versions for the current app
        '''
        if appName:
            self.setApp(appName)
#        if ver:
#            version.set( {self.app : version} )
        return version.get( self.app )


    def __macfix(self):
        if hasattr(self, '_macfix_recursion_prevent'):
            if self._macfix_recursion_prevent:
                return self._macfix_recursion_prevent
        self._macfix_recursion_prevent = {
            'subpath' : '',
        }
        if hasattr(self, 'macfix'):
            self.macfix(self._macfix_recursion_prevent) # noqa

        return self._macfix_recursion_prevent

    def parent(self):
        ''' returns the name of the main class running this instance '''
        ret = ''
        if 'PARENT_BASE_CLASS' in os.environ:
            ret = os.environ['PARENT_BASE_CLASS']
        return ret

    def path(self, subPath='', appName=None):
        '''
        returns the app path. one can specify a subfolder path that will be
        concatenated to the end of the app path and returned.
        '''
        self.setApp(appName)

        macfixData = self.__macfix()

        ret = ""
        if self.app in self:
            if hasattr(self, "osxPath"):
                ret =  '%s' % (self.osxPath)
            else:
                ret =  '%s' % (self[self.app]['path'])
                currentVersion = self.version()
                if currentVersion:
                    ret =  '%s/%s' % (self[self.app]['path'], currentVersion)

        if macfixData['subpath']:
            subPath = '%s/%s' % (macfixData['subpath'],subPath)

        # account for targetSuffix version builds of a package, if they exist.
        for targetSuffix in  [self.parent(), 'boost']:
            if targetSuffix and targetSuffix != self.app:
                parent_version =  version.get( targetSuffix )
                if not parent_version:
                    parent_version =  versionLib.get( targetSuffix )
                _subPath = '%s.%s/%s' % ( targetSuffix, parent_version, subPath )
                # use glob instead of os.path.exists, since glob will
                # resolve wildcards!
                if cached.glob( ret+'/'+_subPath ):
                    subPath = _subPath

        if subPath:
            subPath = '/%s' % subPath

        subPath = subPath.replace('//','/')

        # sanity check: path shouldn't return folders at root path ever!
        if str(ret+subPath)[0:4] in ['/lib','/bin','/inc','/usr','/opt']:
            if self.app not in globals()['DBKEYS_FORCED']:
                log.warning(log.traceback())
                log.warning("%s - %s\n" % (self.app, str(ret+subPath)));sys.stderr.flush()
            return ""

        return ret+subPath

    def pythonPath(self, appName=None):
        '''
        returns a default python module path for each version (dict),
        if the app has one or else returns a black dict
        '''
        self.setApp(appName)
        pythonPath = {}
        for each in cached.glob( self.path(subPath='lib/python*/site-packages/') ):
            version = each.split('/site-packages')[0].split('python')[-1]
            pythonPath[version] = [ each.replace(version,'$PYTHON_VERSION_MAJOR'),
                '/'.join(each.replace(version,'$PYTHON_VERSION_MAJOR').split('/')[:-2]) ]

        for each in cached.glob( self.path(subPath='lib/python/*/site-packages/') ):
            version = each.split('python/')[1].split('/')[0]
            pythonPath[version] = each.replace(version,'$PYTHON_VERSION_MAJOR')

        for each in cached.glob( self.path(subPath='lib/python/*/*/site-packages/') ):
            version = each.split('/site-packages')[0].split('/')[-1]
            pythonPath[version] = each.replace(version,'$PYTHON_VERSION_MAJOR')


        if self.osx:
            for each in cached.glob( self.path(subPath='*/*/Frameworks/Python.framework/Versions/*/lib/python*/site-packages/') ):
                version = each.split('/lib/python')[1].split('/')[0]
                pythonPath[version] = each.replace(version,'$PYTHON_VERSION_MAJOR')

        return pythonPath

    def appFolder(self, appName):
        self.setApp(appName)
        appVersion=version.get(appName)
        appFolder = "%s.%s" % (appName, appVersion)

    def lib(self, appName=None):
        '''
        returns a default lib path for the current app.
        '''
        self.setApp(appName)

        ret =  [
            self.path(subPath='lib'),
            self.path(subPath='lib/python$PYTHON_VERSION_MAJOR'),
            self.path(subPath='lib/boost$BOOST_VERSION'),
            self.path(subPath='lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR'),
        ]
        return ret

    def bin(self, appName=None):
        '''
        returns a default bin path for the current app.
        '''
        self.setApp(appName)
        ret = self.path(subPath='bin')
        if not os.path.exists(ret):
            ret = self.path()
        return ret


    def include(self, appName=None):
        '''
        returns a default include path for the current app.
        '''
        self.setApp(appName)
        return self.path(subPath='include')

    def LD_LIBRARY_PATH(self, appName=None):
        '''
        returns a default LD_LIBRARY_PATH path for the current app.
        this class adjusts itself to bin folder if running in windows (mingw platform)
        '''
        self.setApp(appName)
        lib=self.path(subPath='lib')
        ret = []
        if cached.glob("%s/*%s" % (lib, self.so)):
            ret += [self.path(subPath='lib')]
            ret += [self.path(subPath='lib/boost$BOOST_VERSION')]
        if platform==WIN:
            ret += [self.path(subPath='bin')]

        if cached.glob("%s/python*/*%s" % (lib,self.so) ):
            ret += [self.path(subPath='lib/python$PYTHON_VERSION_MAJOR')]
            ret += [self.path(subPath='lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR')]

        # adds all pipeline based libraries right after app lib

        return ret

class libsDB(appsDB):
    '''
    libsDB gather all installed libs for the current platform (pipeline.platform)
    and stores on itself with the following data:
        versions - a list of all installed versions
        path - a cache of the filesystem absolut path
        environ - a list of methods that configure the runtime environment for the app
        defaultVersion - the version to use
    '''

    def root(self):
        return roots.libs(self.platform, self.arch)

    def version(self, ver=None, appName=None):
        '''
        set and retrieve the current used versions for the current lib
        '''
        if appName:
            self.setApp(appName)
#        if ver:
#            version.set( self.app = version
        return versionLib.get( self.app )


def versionSort(versions):
    def method(v):
        v = filter(lambda x: x.isdigit() or x in '.', v.split('b')[0])
        return str(float(v.split('.')[0])*10000+float(v.split('.')[:2][-1])) + v.split('b')[-1]
    tmp =  sorted( versions, key=method, reverse=True )
    return tmp


# initialize global cache of versions!
if '_appsDB' not in globals():
    globals()['_appsDB'] = appsDB()
if '__DB_LATEST' not in os.environ:
        os.environ['__DB_LATEST'] = str(globals()['_appsDB'].latest)

class version:
    '''
        a namespace class for initialization and access of the global __version database.
    '''
    _DB_LATEST = '__DB_LATEST'
    db = '_appsDB'
    @classmethod
    def __retrieve__(cls):
        if cls._DB_LATEST not in globals():
            globals()[cls._DB_LATEST] = eval(os.environ[cls._DB_LATEST])
        return globals()[cls._DB_LATEST]

    @classmethod
    def __save__(cls, value):
        os.environ[cls._DB_LATEST] = str(value)

    @classmethod
    def set(cls, x={}, **args):
        '''
            used to set apps version. One can specify the app name and version as
            parameters (like maya='2001', delight='9.0.0').
            It also accepts a dictionary in the form of: {'appname':'version'}
            This method accepts more than one app/version at once.
            If reset is passed as a parameter, the __version DB will be reset to the latest
            version of all available apps.
        '''
        _version = cls.__retrieve__()
        args.update(x)
        if [ x for x in args.keys() if x.lower()=='reset' ]:
            _version = globals()[cls.db].latest
        else:
            for each in args:
                _version[each] = args[each]

        cls.__save__(_version)

    @classmethod
    def get(cls, appName=None, all=False ): #noqa
        '''
            returns the version for the given app.
            if no app is specified, it will return a copy of the __version database dictionary
        '''
        _version = cls.__retrieve__()
        v = None
        if appName:
            if appName in _version:
                v = _version[appName]
            if all: #noqa
                v = globals()[cls.db][appName]['versions']
        else:
            v = _version
        return v





# initialize global cache of lib versions!
if '_libsDB' not in globals():
    globals()['_libsDB'] = libsDB()
if '__DB_LATEST_LIBS' not in os.environ:
    os.environ['__DB_LATEST_LIBS'] = str(globals()['_libsDB'].latest)

class versionLib(version):
    '''
        a namespace class for initialization and access of the global __version database.
    '''
    _DB_LATEST = '__DB_LATEST_LIBS'
    db = '_libsDB'
    @classmethod
    def set(cls, x={}, **args ):
        '''
            used to set apps version. One can specify the app name and version as
            parameters (like maya='2001', delight='9.0.0').
            It also accepts a dictionary in the form of: {'appname':'version'}
            This method accepts more than one app/version at once.
            If reset is passed as a parameter, the __version DB will be reset to the latest
            version of all available apps.
        '''
        _versionLib = versionLib.__retrieve__()
        args.update(x)
        if filter( lambda x: x.lower()=='reset', args.keys() ):
            _versionLib = globals()[cls.db].latest
        else:
            for each in args:
                try:
                    v = globals()[cls.db][each]['versions']
                except:
                    v = [args[each]]
                if args[each] not in v:
                    try:
                        vv = [ x for x in v if '.'.join(x.split('.')[:2]) == '.'.join(args[each].split('.')[:2]) ]
                    except:
                        try:
                            vv = [ x for x in v if args[each] in x ]
                        except: pass
                    if vv:
                        v = vv
                    versions = versionSort(v)
                    args[each] = versions[0]

                _versionLib[each] = args[each]
        versionLib.__save__(_versionLib)

    # @staticmethod
    # def get( appName=None, all=False ): #noqa
    #     '''
    #         returns the version for the given app.
    #         if no app is specified, it will return a copy of the __version database dictionary
    #     '''
    #     _versionLib = versionLib.__retrieve__()
    #     v = None
    #     if appName:
    #         if appName in _versionLib:
    #             v = _versionLib[appName]
    #         if all: #noqa
    #             v = libsDB()[appName]['versions']
    #     else:
    #         v = _versionLib
    #     return v


def app(appName, v=None):
    '''
        This method is used to initialize a class app from its name in the form of a string.
    '''
    if v:
        version.set({appName : v})
    try:
        appClassObj = eval('%s()' % appName)
    except:
        appClassObj = None
    return appClassObj

def lib(libName, v=None):
    '''
        This method is used to initialize a class lib from its name in the form of a string.
    '''
    if v:
        version.set({libName : v})
    try:
        libClassObj = eval('%s()' % libName)
    except:
        libClassObj = None
    return libClassObj




class globalApps(_environ):
    def environ(self):
        #self[PYTHONPATH] = '%s/tools/python' % root
        pass


# use this class to disable apps
class disable(object):
    __disableList={}
    @classmethod
    def app(cls, app=None, get=False):
        if not get:
            cls.__disableList[app]=True
        else:
            return app in cls.__disableList

# extensionAutorun is a database to hold automatic launch of application
# based on extension of a file.
# for example, wine can register '.exe' extension so when
# a .exe bin is executed, the baseApp will prepend 'wine' to the
# command line!!
class baseApp(_environ):
    '''
        the base class used to setup apps.
        this class does all the hard work of setting up the default
        environment variables (lib, include, LD_LIBRARY_PATH, PATH)
        it also has version control built in, respecting the current
        version set in the global __version dict.
        by default, global __version dict is set to the latest
        versions installed.

        TODO: a subsystem to automatically detect default version on
        the filesystem.
    '''
    def __init__(self, app=None, platform=platform, arch=arch, DB=appsDB, versionClass=version, DB_EnvVar='__DB_LATEST', cache=True):
        '''
            the class init basically just sets the version according to the __version db,
            and calls refresh(), which does the actual env var initialization.
            this method also fills self.appFromDB with all data for the app that has the same name as the
            derivated class, for example:
                for a "class maya", it will init self.appFromDB with all data for the app "maya"
        '''

        # initialization we need to do, even if cached!
        # =====================================================================
        self._PARENT_ONLY_ += ['PYTHONHOME']
        self.DB_EnvVar = DB_EnvVar
        self.globalVersion = versionClass
        if app:
            self.className = app
        else:
            className = str(self.__class__).split('.')
            self.className = className[len(className)-1].strip("'>")

        # source config files in the search path
        if not 'PARENT_BASE_CLASS' in os.environ:
            os.environ['PARENT_BASE_CLASS'] = str(self.className)
            # self.configFiles()

        # initialize the ignorePipeLib env var
        if 'USE_SYSTEM_LIBRARY' not in os.environ:
            os.environ['USE_SYSTEM_LIBRARY'] = ''

        # deal with situations that DISABLE the class!
        # =====================================================================
        # Look for the --disable command line option, which disables packages
        # ex: maya --disable delight,prman
        if '--disable' in sys.argv:
            id = sys.argv.index('--disable')
            for each in sys.argv[id+1].split(','):
                if self.className==each:
                    self.enable = False
                    break
            del sys.argv[id+1];sys.argv[id]


        # globals()['DBKEYS'] stores what's actually installed in the central
        # disk, opposed to pipe.apps/libs.version() that returns what has been
        # set via python
        if 'DBKEYS' not in globals():
            globals()['DBKEYS'] = globals()['_appsDB'].latest.keys() + \
                                  globals()['_libsDB'].latest.keys() + ['allLibs']

        if 'DBKEYS_FORCED' not in globals():
            globals()['DBKEYS_FORCED'] = []

        # disable class if has being disabled in a config file
        self.enable = True

        # if class has force_enable, that's override any auto enable setup
        if hasattr(self, 'force_enable'):
            self.enable = self.force_enable
            if self.enable:
                globals()['DBKEYS_FORCED'] += [self.className]
                globals()['DBKEYS'] += [self.className]
        else:
            if disable.app( self.className, get=True ):
                self.enable = False

            # so if app/lib class doesn't exist in disk, we just DISABLE it!
            if self.className not in globals()['DBKEYS']:
                self.enable = False

        # dealing with cache
        # =====================================================================
        # a global cache for class objects, so we don't have to double-evaluate
        self.__PIPEVFX_EVALUATE_CACHE__ = '__PIPEVFX_EVALUATE_CACHE_%s__' % DB_EnvVar
        if self.__PIPEVFX_EVALUATE_CACHE__ not in globals():
            globals()[self.__PIPEVFX_EVALUATE_CACHE__] = {}

        # eliminate recursion class creation by using a cache buffer for the classes we evaluate.
        if self.className not in globals()[self.__PIPEVFX_EVALUATE_CACHE__]:
            globals()[self.__PIPEVFX_EVALUATE_CACHE__][self.className] = self

        # if the current class is cached and if the current version changed,
        # we have to delete the cache and re-cache everything again!
        elif self.globalVersion.get(self.className) != globals()[self.__PIPEVFX_EVALUATE_CACHE__][self.className]["%s_VERSION" % self.className.upper()]:
            globals()[self.__PIPEVFX_EVALUATE_CACHE__][self.className] = self
        else:
            recursionCache = globals()[self.__PIPEVFX_EVALUATE_CACHE__]
            _environ.__init__(self)
            _environ.update(self, recursionCache[self.className])
            self.appFromDB      = recursionCache[self.className].appFromDB
            self.path           = recursionCache[self.className].path
            self.updatedClasses = recursionCache[self.className].updatedClasses
            self.platform       = recursionCache[self.className].platform
            self.win            = recursionCache[self.className].win
            self.osx            = recursionCache[self.className].osx
            self.linux          = recursionCache[self.className].linux
            self.arch           = recursionCache[self.className].arch
            self.py             = recursionCache[self.className].py
            self.DB             = recursionCache[self.className].DB
            log.debug("self.parent: %s -> cached self.className: %s " % (self.parent(), self.className))
            return

        # we only continue, if the class isen't disabled
        if self.enable:
            # from now on, this is the initialization we need
            # to do if NOT cached!
            # =====================================================================
            log.debug("self.parent: %s -> live self.className: %s " % (self.parent(), self.className))
            # sys.stderr.write("self.className: %s (%s)\n" % (self.className, self.parent()));sys.stderr.flush()
            # if '--logd' in sys.argv:
            #     sys.stderr.write("%25s " %  self.className)
            #     sys.stderr.write("%-25s " %  self.globalVersion.get(self.className))
            #     sys.stderr.write("python: %s\n" %  self.globalVersion.get('python'))


            # run job_config files before executing environment, so we can set flags
            # to alter app configuration, like enable/disable plugins!
            if '__executed_job_configs__' not in os.environ:
                os.environ[ '__executed_job_configs__' ] = ""
            job_config = [ "%s/config/job_config.py" % each for each in self.toolsPaths() ]
            for each in job_config:
                if each not in os.environ['__executed_job_configs__']:
                    os.environ[ '__executed_job_configs__' ] += " %s" % each
                    if os.path.exists(each):
                        exec( ''.join( open(each,'r').readlines() ) )

            # stores all classes that update this one
            self.updatedClasses = {}

            # current local machine/system info
            from platform import platform as dist
            self.platform = dist()[0].lower()
            self.win = platform == WIN
            self.osx = platform == OSX
            self.linux = platform == LIN
            self.arch = arch
            self.py = py
            self.DB = DB

            # evaluate the version method, if class have it!
            if hasattr(self, 'versions'):
                self.versions()

            self.appFromDB = self.DB(self.className, platform, arch)
            self.path = self.appFromDB.path
            if hasattr(self, 'macfix'):
                self.appFromDB.macfix = self.macfix

            if self.version( self.globalVersion.get(self.className) ):
                _environ.__init__(self,
                    LIB                 = self.appFromDB.lib(),
                    PATH                = self.appFromDB.bin(),
                    INCLUDE             = self.appFromDB.include(),
                    LD_LIBRARY_PATH     = self.appFromDB.LD_LIBRARY_PATH(),
                    # PYTHONPATH          = self.appFromDB.pythonPath(),
                )

            if self.osx:
                dotAppName = "%s.app" % self.className.title()
                if hasattr(self, "dotAppName"):
                    dotAppName = self.dotAppName()

                osxPath = self.path( '%s/Contents' % dotAppName )
                self.replace( {"%s_ROOT" % self.className.upper(): osxPath } )

                macos = "%s/MacOS" % osxPath
                if not os.path.exists(macos):
                    macos = "%s/MacOs" % osxPath
                bin = "%s/bin/" % osxPath
                if not os.path.exists(bin):
                    bin = macos
                lib = "%s/lib/" % osxPath
                if not os.path.exists(lib):
                    lib = macos
                include = "%s/include/" % osxPath
                if not os.path.exists(include):
                    include = "%s/Frameworks/" % osxPath
                    if not os.path.exists(include):
                        include = macos

                self.osxPath = osxPath
                self.macos = macos

                self.replace( {"%s_BIN" % self.className.upper(): bin } )
                self.replace( LIB                 = lib )
                self.replace( LD_LIBRARY_PATH     = lib )
                self.replace( PATH                = bin )
                self.replace( INCLUDE             = include )

            # read the versions.py one and cache it!
            self.configFiles()

            # evaluate license method of all classes
            self.evaluate()


    @staticmethod
    def configFiles(self=None):
        ''' Run over config files located in the pipeline and also in jobs
        We cache it in globals(), so we ran it just once '''

        import sys
        if "versionsFile" not in globals():
            globals()['versionsFile'] = []

            # check for root config files
            configs = [
                "%s/config/versions.py" % roots.tools(),
                "%s/config/licenses.py" % roots.tools(),
            ]

            # check for job config files
            if 'PIPE_JOB' in os.environ:
                configs.append( admin.job.current().path("tools/config/versions.py") )

                # check for shot config files
                if 'PIPE_SHOT' in os.environ:
                    configs.append( admin.job.current().shot().path("tools/config/versions.py") )

                    # check for user in shot config files
                    configs.append( admin.job.current().shot.user().path("tools/config/versions.py") )
                    configs.append( admin.job.current().shot.user().path("tools/config/licenses.py") )

            # check for config file in the user folder
            if 'HOME' in os.environ:
                configs.append( "%s/tools/config/versions.py" % os.environ['HOME'] )
                configs.append( "%s/tools/config/licenses.py" % os.environ['HOME'] )

            # exec configs in order
            for each in configs:
                if os.path.exists( each ):
                    for line in [ x for x in open( each ).readlines() if x.strip() and x.strip()[0] != "#" ]:
                        globals()['versionsFile'] += [line]

            version_py = ''.join(globals()['versionsFile'])
            exec( version_py )


    def ignorePipeLib(self, libname ):
        ''' set library names to ignore using from the pipe version and use
        system or application default ones!'''
        if self.parent() == self.className:
            if libname not in os.environ['USE_SYSTEM_LIBRARY']:
                log.debug("ignorePipeLib: %s (%s)\n" % (libname, self.className))
                os.environ['USE_SYSTEM_LIBRARY'] += ' %s' % libname


    def parent(self):
        ''' return the top wrapper class called by the user '''
        return os.environ['PARENT_BASE_CLASS']

    def bin(self):
        '''returns the app bin folder (from appsDB)'''
        ret = self.appFromDB.bin()
        if '%s_BIN' % self.className.upper() in self:
            ret = self['%s_BIN' % self.className.upper()]
        return ret

    def bins(self, appName=None):
        '''returns all available executables in the app
            Overwrite this method to return custom
            executables!
        '''
        from glob import glob
        import os
        SHLIB = [
            '.dylib',
            '.dll',
            '.so',
            '.la',
            '.lib',
            '.a',
            '.crt',
            '.bin',
            '.txt',
        ]
        ret = []
        for each in cached.glob( '%s/*' %  self.bin()):
                cmd = os.path.basename(each)
                app = os.path.basename(each)
                if filter(lambda x: x  in cmd.lower(), SHLIB):
                    continue
                if not (stat.S_IXUSR & os.stat(each)[stat.ST_MODE]):
                    continue
                if os.path.isdir(each):
                    if os.path.splitext(each)[1].lower() == '.app':
                        app = "%s/Contents/MacOS/%s" % (cmd, os.path.splitext(cmd)[0])
                    else:
                        continue
                else:
                    ret.append((cmd,cmd))
        return ret

    def pythonPath(self):
        ''' return pythonpath() from appsDB '''
        return self.appFromDB.pythonPath()

    def evaluate(self):
        '''
            the actual initialization of the class.
            It inits the default env vars, and calls "environ" method, which
            is a virtual method that must be defined by each app class.
        '''
        appName = self.className.upper()
        # if not '%s_VERSION' % appName in self.keys() and 'PARENT_BASE_CLASS_%s' % appName not in os.environ: # prevent from adding twice!
        # os.environ['PARENT_BASE_CLASS_%s' % self.parent()]='1'

        self.replace( {
            '%s_VERSION' % appName : self.appFromDB.version(),
            '%s_ROOT'    % appName : os.path.abspath( self.appFromDB.path()+'/' ),
        } )
        try:
            self.replace( {
                '%s_VERSION_MAJOR' % appName : '.'.join( self.appFromDB.version().split('.')[0:2] ),
            })
        except: pass

        py='.'.join( self.globalVersion.get('python').split('.')[:2] )
        pythonPaths = self.pythonPath()
        if py in pythonPaths:
            self['PYTHONPATH'] = pythonPaths[py]

        # run the virtual environ() method of the app/lib class, if any!
        if hasattr(self, 'environ'):
            self.environ()


    def version(self, v=None):
        '''
            returns the current version for the class app.
            if a version is passed to this method, it will set it as current in the global __version db,
            refreshs itself with the data for the new version and will return that version.
        '''
        # handle --<pkg>_version <version> command line options
        # ex: maya --maya_version 2013
        for each in filter(lambda x: '--' in x and '_version' in x, sys.argv):
            name = each.split('--')[1].split('_version')[0].lower()
            v = sys.argv[ sys.argv.index(each)+1 ]
            if self.globalVersion.get(name) != v:
                self.globalVersion.set({name : v})
            del sys.argv[ sys.argv.index(each)+1 ]
            del sys.argv[ sys.argv.index(each) ]

        __version = self.globalVersion.get(self.className)
        if __version:
            self.appFromDB.version( self.globalVersion.get(self.className) )
        # return self.globalVersion.get(self.className)
        if hasattr(self, 'versions'):
            self.versions()

        return self.appFromDB.version( )

    def versionList(self, numbersOnly=True):
        ''' returns all the versions available for the app'''
        zappsDB = self.DB(self.className)
        if not zappsDB:
            return zappsDB
        if numbersOnly and self.className != 'houdini':
            return filter(lambda x: x[0].isdigit(), zappsDB[self.className]['versions'])
        return zappsDB[self.className]['versions']

    def scanConfig(self):
        ''' scan for config files, like the ones in tools/config '''
        for each in cached.glob( '%s/tools/config/*.py' % depotRoot() ):
            module = os.path.splitext(os.path.basename(each))[0]
            dir = os.path.dirname( each )
            sys.path.append( dir )
            if module not in __file__:
                exec( 'import %s;reload(%s);del %s' %  (module,module,module) )

            del sys.path[ sys.path.index( dir ) ]
            del module
        self.version()

    def toolsPaths(self):
        ''' return all the tools paths in the hierarqui, sorted correctly! '''
        #add tools paths
        toolsPaths = [roots.tools()]
        if admin.job.current():
            toolsPaths.append( admin.job().path('tools') )
            if admin.job.shot():
                toolsPaths.append( admin.job.shot().path('tools') )
                toolsPaths.append( admin.job.shot.user().path('tools') )

        toolsPaths.reverse()
        return toolsPaths

    def _license(self, binName=None):
        ''' setup license  - create license(self) if we need a custom license mechanism!
            by default, it looks for a license.py script and sources it, so we can add custom setup easily.
            if no script found, sets a default LM_LICENSE_FILE env var pointing to the pipe license place:
                /studio/pipeline/tools/license/<class name>/<version>/
        '''
        try:
            self.license(binName)
        except:
            self.license()


        # run version independent license.py
        license_scripts = []
        for each in self.toolsPaths():
            license_scripts.extend( [
                "%s/licenses/%s/license.py" % (each, self.className.lower()),
                "%s/licenses/%s/%s/license.py" % (each, self.className.lower(), self.appFromDB.version()),
            ])
        for license_script in license_scripts:
            if os.path.exists( license_script ):
                try:
                    exec( ''.join(open(license_script).readlines()),globals(),locals() )
                    # print( license_script )
                    break
                except:
                    print( bcolors.FAIL+'='*80 )
                    print( license_script+" ERROR:\n" )
                    print( "\n\t".join(traceback.format_exc().split('\n')) )
                    print( '='*80,bcolors.END )


    def license(self):
        ''' virtual method to be created in app classes
        to customize license setup
        '''
        self['LM_LICENSE_FILE'] = "%s/licenses/%s/%s" % (roots.tools(), self.className.lower(), self.appFromDB.version() )

    def _userSetup(self, binName=''):
        ''' do the user setup needed before running an app.
        If a app class has a userSetup() method, this method
        will call it.'''
        ignore = [ 'python', 'xnview', 'chrome', 'rv', 'qube'  ]

        # if a class has needJob() method and it returns false,
        # we don't do anything here!
        if hasattr(self, 'needJob') and not self.needJob():
            return

        # evaluate the runUserSetup() method, if one exists, to enable/disable
        # user setup execution. Default is enabled!
        j = admin.job.current()
        if hasattr(self, 'runUserSetup'):
            bin = filter(lambda x: x[1] == binName, self.bins())
            if bin:
                if not self.runUserSetup(bin[0]):
                    j = None

        if j:
            if j and self.className not in ignore:
                user = j.shot.user()
                user.mktools()
                user.create()
                user.mkdir( self.className )
                user.create()
                user.pwd = os.getcwd()
                os.chdir( user.path(self.className) )
                if hasattr(self, 'userSetup'):
                    self.userSetup( user )
                self.user = user
        else:
            if hasattr(self, 'userSetup'):
                raise Exception(bcolors.FAIL+'''\n%s

        SHELL WITHOUT A JOB AND SHOT!!!
        -------------------------------

        You must run this app from inside a job and shot!
        -------------------------------------------------

        Please run:

                go <job name> shot <shot name>      or
                go <job name> asset <asset name>

        before running this app.


        Ex:  go 9999.rnd shot dev
             go (a shortcut to the last job/shot set)

        Tip: Just look at the titlebar of a shell. If it shows the JOB/SHOT,
             thats the JOB/SHOT set in that shell!!

                \n%s''' % ('='*80, '='*80) +bcolors.END)

    def inFarm(self):
        ''' return TRUE if we're running on a farm machine! '''
        ret =  'PIPE_FARM_USER' in os.environ
        return ret

    def update(self, environClass={}, top={}, noIgnoreLibs=False, **e):
        ''' Recall all added classes to batch update later at RUN
        When adding other apps/libs to an app/lib class in environ(),
        instead of actually adding it, we cache it all to avoid
        running things multiple times.
        Things are actually updated by the expand() method!
        '''

        useSystemLibs = []
        if 'USE_SYSTEM_LIBRARY' in os.environ and not noIgnoreLibs:
            useSystemLibs = os.environ['USE_SYSTEM_LIBRARY'].split()
        if environClass:
            if environClass.className not in useSystemLibs:
                self.updatedClasses[environClass.className] = environClass
                self.updatedClasses.update( environClass.updatedClasses )
                # we need to mantain the recursionCache up2date!!
                if self.className in globals()[self.__PIPEVFX_EVALUATE_CACHE__]:
                    globals()[self.__PIPEVFX_EVALUATE_CACHE__][self.className].updatedClasses = self.updatedClasses

        # do 'e' update on the fly!
        if e:
            _environ.update(self, e=e)

        if top:
            for each in top:
                self.insert(each,0, top[each])

    def updateLibs(self):
        ''' update environment with pipeline library paths
        this should run once, only for the main parent class before run()'''
        # standard dependencies
        if self.parent() == self.className:
            from libs import allLibs, python
            allLibs = allLibs()
            libs={
                'LD_LIBRARY_PATH':[],
                'PYTHONPATH':[],
                'INCLUDE':[],
            }

            extraUpdates = {}
            for lib in allLibs.updatedClasses:
                if lib not in os.environ['USE_SYSTEM_LIBRARY'].split():
                    # we check if a lib class has environ
                    # if so, we need to update all its environment variables
                    if hasattr(allLibs.updatedClasses[lib], 'environ'):
                        for each in allLibs.updatedClasses[lib].keys():
                            allLibs[each] = allLibs.updatedClasses[lib][each]
                            extraUpdates[each] = 1

                    # if not, just grab what we need!!
                    allLibs['LD_LIBRARY_PATH'] = allLibs.updatedClasses[lib]['LD_LIBRARY_PATH']
                    allLibs['PYTHONPATH'] = allLibs.updatedClasses[lib]['PYTHONPATH']
                    allLibs['INCLUDE'] = allLibs.updatedClasses[lib]['INCLUDE']

                # set lib versions no matter what!!
                for each in [ x for x in allLibs.updatedClasses[lib] if 'VERSION' in x ]:
                    allLibs[each] = allLibs.updatedClasses[lib][each]
                    extraUpdates[each] = 1

            self.insert('LD_LIBRARY_PATH', 0, allLibs['LD_LIBRARY_PATH'] )
            self['PYTHONPATH'] = allLibs['PYTHONPATH']
            self.insert('INCLUDE', 0, allLibs['INCLUDE'])
            self.insert('LD_LIBRARY_PATH', 0, self.path('lib'))
            self.insert('LD_LIBRARY_PATH', 0, self.path('lib/boost$BOOST_VERSION'))
            self['LD_LIBRARY_PATH']=self.path('lib/python$PYTHON_VERSION_MAJOR')
            self['LD_LIBRARY_PATH']=self.path('lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR')

            self['BOOST_VERSION'] = versionLib.get('boost')

            def addTargetSuffix(lib, _suffix=['*/boost.*']):
                # account for targetSuffix folders (boost for now!)
                pv='.'.join(versionLib.get('python').split('.')[:2])
                for suffix in _suffix:
                    for each in cached.glob( "%s/%s/%s/lib/python%s" % (roots.libs(), lib, suffix, pv) ):
                        self['LD_LIBRARY_PATH'] = each
                    for each in cached.glob( "%s/%s/%s/lib" % (roots.libs(), lib, suffix) ):
                        self['LD_LIBRARY_PATH'] = each

            # account for all versions of theses packages!
            for lib in libraries_with_versioned_names:
                # add all targetSuffix version
                addTargetSuffix(lib, [
                    '*',
                    '*/boost.*'
                ])

            # if we have extra variables, just update itself with it!
            for each in extraUpdates:
                self[each] = allLibs[each]

    def fullEnvironment(self, binName=None):
        '''
        here is were we actually update self with all updated
        classes - the ones we do 'self.update(classApp())' in environ method!
        we also add all libraries path
        if binName is specified, fullEnvironment will also run the license setup
        for all classes in updatedClasses[], including the this one.
        '''
        # add our pipe library collection
        self.updateLibs()

        # only run if RUN_SHELL enviroment is set or not root!
        if os.getuid()>0 or 'RUN_SHELL' in os.environ:
            # here is were we actually update self with all updated
            # classes - the ones we do 'self.update(classApp())' in environ method!
            for className in  self.updatedClasses.keys():
                # evaluate all classes, but itself!
                if className != self.parent():
                    self.updatedClasses[className].evaluate()
                    # first, run license method for all added classes
                    if binName:
                        self.updatedClasses[className]._license(binName)
                    # then, update self with the class!
                    _environ.update(self, self.updatedClasses[className])

        # last, run self license
        if binName:
            self._license(binName)

    def expand(self, binName=None):
        ''' Expand all env vars in this class to the environment.
        This runs at the very end, before running the actual app
        '''
        # here is were we actually update self with all updated
        # classes - the ones we do 'self.update(classApp())' in environ method!
        self.fullEnvironment(binName)

        # and _environ.evaluate actually sets os.environ!
        _environ.evaluate(self)

        # update python itself with the newly created PYTHONPATH.
        for each in os.environ['PYTHONPATH'].split(':'):
            sys.path += [each]

    def run(self, binName):
        ''' run the application!!! '''
        debug = ''

        # if one of the arguments is a file, and it exists, make it abspath!!
        for n in range(1,len(sys.argv[1:])):
            each = sys.argv[n]
            if os.path.exists( os.path.abspath(each) ):
                sys.argv[n] = os.path.abspath(each)

        # dinamically add app classes to the current application environment
        # its a dinamic self.update( <app class> ) in command line!
        if '--with' in sys.argv:
            id = sys.argv.index('--with')
            import pipe
            for each in sys.argv[id+1].split(','):
                self.update( eval("pipe.apps.%s()" % each) )
            # remove from command line
            del sys.argv[id+1]
            del sys.argv[id]

        # force a disable of a certain package, if --disable <package>
        # TODO!!! (it does nothing at the moment!)
        if '--disable' in sys.argv:
            id = sys.argv.index('--disable')
            # remove from command line
            del sys.argv[id+1]
            del sys.argv[id]

        # if we're in the farm, set the HOME folder to be /tmp/<username>
        if self.inFarm():
            print( "="*80 )
            # if we're in the farm, set the HOME folder to be /tmp/<username>
            # so environ and all other methods will have it ready for use from
            # the begining
            self['HOME'] = "/tmp/%s" % (os.environ['PIPE_FARM_USER'])

            # self['HOME'] is being initialized at __init__!!
            home = self['HOME']
            # use dbus service to create the temporary user folder
            # in the farm render node, so to prevent clash of file
            # creation/modification from different machines!
            sudo = admin.sudo()
            sudo.cmd('mkdir -p %s' % home )
            sudo.cmd('chmod a+rwx %s' % home )
            print( sudo.run() )
            # add pipe bash init script to be sourced in the fake
            # home folder just in case.
            f=open('%s/.bashrc' % home,'w')
            f.write('. %s/init/bash\n' % roots.tools())
            f.close()

            # synchronize use maya folder
            os.popen( 'rsync -avpP --exclude "projects" %s/maya/ %s/maya/' % (os.environ['HOME'], self['HOME']) ).readlines()
            os.popen( 'rsync -avpP --delete %s/Adlm/ %s/Adlm/' % (os.environ['HOME'], self['HOME']) ).readlines()
            os.popen( 'rsync -avpP --delete %s/.pixarPrefs/ %s/.pixarPrefs/' % (os.environ['HOME'], self['HOME']) ).readlines()

        # set JOB and SHOT env var for easy setup of paths relative to shot and job
        # inside applications - using $JOB or $SHOT
        if 'PIPE_JOB' in os.environ:
            os.environ['JOB'] = admin.job.current().path()
            if 'PIPE_SHOT' in os.environ:
                os.environ['SHOT'] = "%s/%s/users/" % ( os.environ['JOB'], os.environ['PIPE_SHOT'].replace('@','s/') )

        # use /bin/sh to run apps...
        os.environ['SHELL'] = '/bin/sh'

        # WIP: Windows apps using WINE
        # if the app is a wine app, set WINEPREFIX
        if os.path.exists( "%s/drive_c" % self.path() ):
            self['WINEPREFIX'] = self.path()
            self['WINE_VERSION'] = self.globalVersion.get('wine')
            # self['WINEDEBUG']='+opengl'
            # handles wine if extension of bin is .exe
            binNameExt = os.path.splitext( binName )[1].lower()
            if binNameExt == '.exe':
                os.environ['SHELL'] = '/bin/bash'
                debug = "run wine "

        # if we are in a job/shot, make sure
        # the user has a writable folder to work!
        self._userSetup(binName)

        # expand all environment variables stored in this class to
        # actual os.environ vars
        # it also updates this class with libraries path, all the classes
        # that where added by self.update() and if binName is specified,
        # it will run the _license() method for all classes
        self.expand(binName)

        # get extra default command line parameters
        # if extraCommandLine() method exists!
        if hasattr( self, 'extraCommandLine'):
            sys.argv.extend( self.extraCommandLine(binName) )

        # SAM asset publishing support
        # =====================================================================
        # one can specify an assepath to create dependency that can be
        # used by pre and post methods in apps
        # for example, maya.py uses this in post to publish rendered frames
        # into asset images folder!
        self.asset = None
        if '--asset' in sys.argv:
            id = sys.argv.index('--asset')
            self.asset = sys.argv[id+1]
            del sys.argv[id+1];del sys.argv[id]

        # GENERAL DEBUGGING
        # =====================================================================
        # we set here the apps that need to run with os.system because they
        # need keyboard input
        runWithOsSystem = binName in ['python','houdini','prman','mayapy']

        # run the software in GDB, if --debug in command line
        if '--debug' in sys.argv:
            # if self.className == 'maya':
            #     binName += ' -d gdb '
            # else:
            debug = 'gdb -ex run --args'
            del sys.argv[sys.argv.index('--debug')]
            runWithOsSystem = True

        # or in nemiver (gdb gui), if --gdebug in command line
        elif '--gdebug' in sys.argv:
            if self.className == 'maya':
                binName += ' -d nemiver '
            else:
                debug = ' nemiver '
            del sys.argv[sys.argv.index('--gdebug')]
            runWithOsSystem = True

        # traces all opened shared libraries and display on a window, if --trace
        traceID = filter(lambda x: '--trace' in x, sys.argv)
        if traceID:
            traceID = traceID[0]
            filterVar = '.so'
            if '=' in traceID:
                filterVar = traceID.split('=')[-1]
            del sys.argv[sys.argv.index(traceID)]
            filterVar = filterVar.replace('.','\\.')
            debug = ' ; '.join([
                'touch /tmp/%s.trace' % binName.split()[-1].replace('/','_'),
                '(xterm -geometry 200x40 -bg black -fg white -e "tail -f /tmp/%s.trace | grep \'%s\'  | grep -v \'No such file or directory\'" &)' % (binName.split()[-1], filterVar),
                'strace -f -o /tmp/%s.trace' % binName.split()[-1].replace('/','_'),
            ])

        # display extra pipe log.debug() info when starting up, if --logd
        # very usefull to examine if class apps are setting up the environ
        # vars correctly and debug!
        if '--logd' in sys.argv and 'wine' not in debug:
            del sys.argv[sys.argv.index('--logd')]

        # if binName is a python script, run with our pipeline current python
        # =====================================================================
        # TODO: mangle it correctly for debugging!!
        extra = ""
        if os.path.splitext(binName.split(' ')[0])[-1].lower() == '.py':
            from libs import python
            extra =  python().path('../$PYTHON_VERSION/bin/python')
            # if debug:
            #    if 'gdb' in debug:
            #        extra += ' --debug'
            #    else:
            #        extra += ' --gdebug'
            #    debug = ''

        # VIRTUAL GL SETUP (to run apps remotely)
        # =====================================================================
        # -vgl32 is a vgl argument that forces vgl to intercept
        # 32bit opengl instead of 64bit default
        m32 = ''
        if '-vgl32' in sys.argv:
            m32 = '-32'
            del sys.argv[sys.argv.index('-vgl32')]

        # check if we have opengl hardware (local X11) or not (vnc/ssh)
        # if we don't, try running with virtualGL
        display=0
        if 'DISPLAY' in os.environ and ':' in os.environ['DISPLAY'].strip():
            display = float(os.environ['DISPLAY'].split(':')[-1])
        # we assume that ssh or any other remote connection will
        # have a DISPLAY bigger than 9 here, to detect if we need virtualGL or not!
        # (or if running in DOCKER, use vglrun!)
        if ( display > 15 or 'DOCKER' in os.environ ) and vglrun:
            # debug = 'vglrun -c jpeg -q 30 %s %s' % (m32, debug)
            # find out what display is active
            # d = os.popen("echo $(ps -AHfc | grep Xorg | grep $(cat /sys/class/tty/tty0/active)) | cut -d' ' -f10").readlines()
            # if d:
            #     d = d[0].strip()
            #     if not d:
            #         d = os.popen("echo $(ps -AHfc | grep Xorg | grep -v grep) | cut -d' ' -f10").readlines()[0].strip()
            #         if not ':' in d:
            #             d = ":0"
            #     d = "-d %s" % d
            d = os.popen("loginctl list-sessions | egrep -v 'SESSION|sessions' | awk '{print $1}' | while read s ; do loginctl show-session -p Display -p Active  $s ; done | grep 'Active=yes' -B1 | grep ':' | awk -F'=' '{print $2}'")
            if not ':' in d:
                d = ":0"
            else:
                d = ""
            if d:
                d = "-d %s" % d
            debug = '%s +v %s %s %s env LD_LIBRARY_PATH=$LD_LIBRARY_PATH' % (vglrun, d, m32, debug)
        # if a display is below 15, we're running ssh connection, not xpra, so we use LIBGL_ALWAYS_INDIRECT instead of VirtualGL.
        # this way, opengl applications will use the client GPU, not the host GPU.
        # this allows to run hardware accelerated opengl applications in a GPUless HOST (software runs in the host,
        # but uses GPU hardware from client!)
        elif display > 9:
            debug = 'xhost + ; env QT_X11_NO_MITSHM=1 QT_GRAPHICSSYSTEM=opengl LIBGL_ALWAYS_INDIRECT=1  %s ' % (debug)

        # ???
        # =====================================================================
        if '--wine' in sys.argv:
            del sys.argv[sys.argv.index('--wine')]
            binFullName = ''

        # The --fix (or FIX env var) forces the virtual method postRun to run
        # BEFORE running the app as well as after! Is postRun returns 0, the
        # app won't run!
        # We can use this to check if rendered frames exist on disk (which is
        # what postrun does) and don't render if they do.
        # it's a usefull workaround to retry all frames in a farm job, and have
        # the pipeline render only the ones that are missing automatically!
        # =====================================================================
        fixit = 'FIX' in os.environ
        if '--fix' in sys.argv:
            del sys.argv[sys.argv.index('--fix')]
            fixit = True

        # just run a shell setup for the app, not the actual software!
        # =====================================================================
        shell = False
        if '--shell' in sys.argv:
            del sys.argv[sys.argv.index('--shell')]
            shell = True

        # FROM NOW ON, WE CONSTRUCT THE COMMAND LINE!
        # =====================================================================
        # if app binary name is a link, translate it to its target
        binFullName = '%s/%s' % (self.bin(), binName)
        if os.path.islink(binFullName):
            binFullName = '%s/%s' % ( self.bin(), os.readlink( binFullName ) )
            binFullName = binFullName.replace(' ','\\ ')

        # construct command line string
        cmd = '%s %s %s %s' % (
            debug,
            extra,
            binFullName,
            # now add all arguments passed by command line, but the ones
            #  intercept above which have being deleted from sys.argv!
            ' '.join( map(lambda x: '"%s"' % x.replace('"','\\"'), sys.argv[1:] ) )
        )

        # if we have a localCache method (wine), call it to update/create the local cache
        # and mangle the cmd line accordingly
        if hasattr(self, 'localCache'):
            cmd = self.localCache(cmd)

        # if we have a pipe method, make stdout and stderr
        # pipe to its returned value!
        if hasattr(self, 'pipe'):
            cmd += ' 1>%s 2>%s' % self.pipe()

        # if class has a bg method and it returns True,
        # run the app in background!
        if hasattr(self, 'bg'):
            bin = filter(lambda x: x[1] == binName, self.bins())
            if bin:
                ret = self.bg(cmd,bin[0])
                if ret:
                    cmd += ' & '

        # force affinity to be the number of cores in the machine, just in case.
        # we saw some apps running with affinity to just one cpu without this,
        # in fedora 14/kernel 3.9.8. Could be an isolated problem only!
        if self.linux and taskset:
            cmd = "%s -c 0-%d " % (taskset, cpu_count()) + cmd

        # run preRun if it exists - returns the cmd to run!
        # (preRun virtual method can modify cmd as it wants!)
        if hasattr( self, 'preRun'):
            cmd = self.preRun(cmd)

        # LD_PRELOAD SETUP:
        # =====================================================================
        # only preload if exists!
        _preload = []
        # workaround for centos 6.5
        if os.path.exists('/etc/centos-release'):
            _preload = [
                "/opt/glibc-2.14/lib/libc.so.6",
                "/opt/centos7/usr/lib64/libXft.so.2",
            ]

        if 'LD_PRELOAD' in os.environ.keys():
            _preload += os.environ['LD_PRELOAD'].split(':')

        # only preloads if they exist!
        preload=[]
        for each in _preload:
            if os.path.exists( each ):
                preload += [ each ]
            else:
                log.debug("pipevfx dev warning: can't preload %s since it doesn't exist." % each)

        os.environ['LD_PRELOAD']=":".join(preload)
        os.environ['_LD_PRELOAD']= os.environ['LD_PRELOAD']


        # show cmd in debug log (--logd)
        log.debug(cmd)

        # remove TBB_VERSION to avoid TBB spitting out information!!
        if 'TBB_VERSION' in os.environ:
            del os.environ['TBB_VERSION']


        # NOW WE EXECUTE IT!
        # =====================================================================
        # starup a shell instead of the software (usefull to debug environment)
        if shell:
            ret = os.system( 'env PS1=" >> " /bin/sh' )

        # run the software
        else:
            # if --fix and the class has a postRun method, run it before the main app
            # if it returns somthing > 0, run the app!
            ret = 255;
            if hasattr( self, 'postRun') and fixit:
                ret = self.postRun(cmd, ret)

            sys.stdout.flush()
            sys.stderr.flush()
            returnLog = ''

            if ret > 0 and cmd:
                # when running as a job in the farm, we rely on PIPE_FARM_USER env var to find who is the job user
                # the run script is the one responsavel to find out if its in the farm or not, and set this env var for the pipe!
                # in this case, we use it to run the cmd line as that user, using dbus!
                if self.inFarm():
                    print( "Running in farm as user: %s" % os.environ['PIPE_FARM_USER'] )
                    print( '='*80 )
                    ret, returnLog = runProcess(cmd)

                else:
                    # when we need stdin for python, runWithOsSystem will be set
                    # so we use os.system for it, until we find
                    # a solution for runprocess to be able to work with stdin!!
                    if runWithOsSystem:
                        ret = os.system( cmd )
                    else:
                        ret, returnLog = runProcess(cmd)

                sys.stdout.flush()
                sys.stderr.flush()

                # if the class has a postRun method, run it after the main app
                if hasattr( self, 'postRun'):
                    ret = self.postRun(cmd, ret, returnLog)

            else:
                print( "\n\tThe Pipe won't run the requested app since it was launched with --fix, \n\tand the postRun() method says there's not need to run." )
                print( "\n\tIf you want to run the app no matter what, please remove \n\tthe --fix optional parameter from the command line!\n" )
                print( '='*80 )

        sys.stdout.flush()
        sys.stderr.flush()

        # if we got an error, return a parseable string so farm erro parser
        # can be triggered!
        if ret:
            print( '[ PARSER ERROR ]' )
            ret = -2
        sys.exit(ret)

class baseLib(baseApp):
    '''
        the base class used to setup libs.
        this class does all the hard work of setting up the default
        environment variables (lib, include, LD_LIBRARY_PATH, PATH)
        it also has version control built in, respecting the current
        version set in the global __version dict.
        by default, global __version dict is set to the latest
        versions installed.

        TODO: a subsystem to automatically detect default version on
        the filesystem.
    '''
    def __init__(self, lib=None, platform=platform, arch=arch):
        baseApp.__init__(self, lib, platform, arch, libsDB, versionLib, '__DB_LATEST_LIBS')

    def needJob(self):
        ''' all lib binaries can run without a job/shot set! '''
        return False

    def LD_PRELOAD(self):
        pv = versionLib.get('python')
        bv = versionLib.get('boost')
        pvm = '.'.join(pv.split('.')[:2])
        ret =  cached.glob( self.path('lib/*.so') )
        ret +=  cached.glob( self.path('lib/python%s/*.so' % pvm) )
        ret +=  cached.glob( self.path('lib/boost%s/*.so' % bv) )
        ret +=  cached.glob( self.path('lib/boost%s/python%s/*.so' % (bv,pvm)) )
        # d = {}
        # for each in ret:
        #     if os.path.isfile(each):
        #         d['LD_PRELOAD'] = each
        return ret
