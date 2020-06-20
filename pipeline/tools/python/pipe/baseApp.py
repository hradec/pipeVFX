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
    return map( lambda x: x.strip(), os.popen('xsetwacom --list').readlines() )

def root(platform=platform, arch=arch):
    return roots.apps(platform, arch)

def getMacAddress():
    return os.popen( "echo $(ifconfig | grep -B1 eth0 | awk '{print toupper($0)}') | cut -d' ' -f5" ).readlines()[0].strip()


class cache:
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

        self.win = platform == WIN
        self.osx = platform == OSX
        self.linux = platform == LIN
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
        for app in glob('%s/%s' % (self.root(),app)):
            appDict = {
                'defaultVersion' : None,
                'versions' : [],
                'path' : app,
                'environ' : [],
            }
            # look for all versions available and populate the app dict with then
            for version in glob('%s/*' % app):
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
        ret = {
            'subpath' : '',
        }
        if hasattr(self, 'macfix'):
            macfix(ret) # noqa
        return ret

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
                if glob( ret+'/'+_subPath ):
                    subPath = _subPath

        if subPath:
            subPath = '/%s' % subPath

        subPath = subPath.replace('//','/')

        return ret+subPath

    def pythonPath(self, appName=None):
        '''
        returns a default python module path, if the app has one.
        else returns Blank
        '''
        self.setApp(appName)
        pythonPath = {}
        for each in glob( self.path(subPath='lib/python*/site-packages/') ):
            version = each.split('/site-packages')[0].split('python')[-1]
            pythonPath[version] = [ each.replace(version,'$PYTHON_VERSION_MAJOR'),
                '/'.join(each.replace(version,'$PYTHON_VERSION_MAJOR').split('/')[:-2]) ]

        for each in glob( self.path(subPath='lib/python/*/site-packages/') ):
            version = each.split('python/')[1].split('/')[0]
            pythonPath[version] = each.replace(version,'$PYTHON_VERSION_MAJOR')

        for each in glob( self.path(subPath='lib/python/*/*/site-packages/') ):
            version = each.split('/site-packages')[0].split('/')[-1]
            pythonPath[version] = each.replace(version,'$PYTHON_VERSION_MAJOR')


        if self.osx:
            for each in glob( self.path(subPath='*/*/Frameworks/Python.framework/Versions/*/lib/python*/site-packages/') ):
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
        if glob("%s/*%s" % (lib, self.so)):
            ret += [self.path(subPath='lib')]
            ret += [self.path(subPath='lib/boost$BOOST_VERSION')]
        if platform==WIN:
            ret += [self.path(subPath='bin')]

        if glob("%s/python*/*%s" % (lib,self.so) ):
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
    # print tmp
    return tmp



# initialize global cache of versions!
if not '__DB_LATEST' in os.environ:
    os.environ['__DB_LATEST'] = str(appsDB().latest)
class version:
    '''
        a namespace class for initialization and access of the global __version database.
    '''
    @staticmethod
    def set( x={}, **args):
        '''
            used to set apps version. One can specify the app name and version as
            parameters (like maya='2001', delight='9.0.0').
            It also accepts a dictionary in the form of: {'appname':'version'}
            This method accepts more than one app/version at once.
            If reset is passed as a parameter, the __version DB will be reset to the latest
            version of all available apps.
        '''
        _version = eval(os.environ['__DB_LATEST'])
        args.update(x)
        if [ x for x in args.keys() if x.lower()=='reset' ]:
            _version = appsDB().latest
        else:
            for each in args:
                # try:
                #     v = appsDB()[each]['versions']
                # except:
                #     v = [args[each]]
                # if args[each] not in v:
                #     try:
                #         vv = [ x for x in v if '.'.join(x.split('.')[:2]) == '.'.join(args[each].split('.')[:2]) ]
                #     except:
                #         try:
                #             vv = [ x for x in v if args[each] in x ]
                #         except: pass
                #     if vv:
                #         v = vv
                #     versions = versionSort(v)
                #     args[each] = versions[0]
                _version[each] = args[each]
        os.environ['__DB_LATEST'] = str(_version)

    @staticmethod
    def get( appName=None, all=False ): #noqa
        '''
            returns the version for the given app.
            if no app is specified, it will return a copy of the __version database dictionary
        '''
        _version = eval(os.environ['__DB_LATEST'])
#        # check for config files
#        if os.path.exists( "%s/config/versions.py" % roots.tools() ):
#            exec( ''.join(open( "%s/config/versions.py" % roots.tools() ).readlines()) )

        v = None
        if appName:
            if appName in _version:
                v = _version[appName]
            if all: #noqa
                v = appsDB()[appName]['versions']
        else:
            v = _version
        return v





# initialize global cache of lib versions!
if not '__DB_LATEST_LIBS' in os.environ:
    os.environ['__DB_LATEST_LIBS'] = str(libsDB().latest)

class versionLib:
    '''
        a namespace class for initialization and access of the global __version database.
    '''
    @staticmethod
    def set( x={}, **args ):
        '''
            used to set apps version. One can specify the app name and version as
            parameters (like maya='2001', delight='9.0.0').
            It also accepts a dictionary in the form of: {'appname':'version'}
            This method accepts more than one app/version at once.
            If reset is passed as a parameter, the __version DB will be reset to the latest
            version of all available apps.
        '''
        _versionLib = eval(os.environ['__DB_LATEST_LIBS'])
        args.update(x)
        if filter( lambda x: x.lower()=='reset', args.keys() ):
            _versionLib = libsDB().latest
        else:
            for each in args:
                try:
                    v = libsDB()[each]['versions']
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
        os.environ['__DB_LATEST_LIBS'] = str(_versionLib)

    @staticmethod
    def get( appName=None, all=False ): #noqa
        '''
            returns the version for the given app.
            if no app is specified, it will return a copy of the __version database dictionary
        '''
        # check for config files
#        if os.path.exists( "%s/config/versions.py" % roots.tools() ):
#            exec( ''.join(open( "%s/config/versions.py" % roots.tools() ).readlines()) )

        _versionLib = eval(os.environ['__DB_LATEST_LIBS'])
        v = None
        if appName:
            if appName in _versionLib:
                v = _versionLib[appName]
            if all: #noqa
                v = libsDB()[appName]['versions']
        else:
            v = _versionLib
        return v


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
        if app:
            self.className = app
        else:
            className = str(self.__class__).split('.')
            self.className = className[len(className)-1].strip("'>")

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

        # Look for the --disable command line option, which disables packages
        # ex: maya --disable delight,prman
        self.enable = True
        if '--disable' in sys.argv:
            id = sys.argv.index('--disable')
            for each in sys.argv[id+1].split(','):
                if self.className==each:
                    self.enable = False
                    break

        # source config files in the search path
        self.DB_EnvVar=DB_EnvVar
        if not 'PARENT_BASE_CLASS' in os.environ:
            os.environ['PARENT_BASE_CLASS'] = str(self.className)
            # self.configFiles()

        # disable class if has being disabled in a config file
        if disable.app( self.className, get=True ):
            self.enable = False

        # stores all classes that update this one
        self.updatedClasses = {}

        # current local machine/system info
        from platform import dist
        self.platform = dist()[0].lower()
        self.win = platform == WIN
        self.osx = platform == OSX
        self.linux = platform == LIN
        self.arch = arch
        self.py = py
        self.DB = DB
        self.globalVersion = versionClass

        # evaluate the version method, if class have it!
        if hasattr(self, 'versions'):
            self.versions()

        # eliminate recursion class creation by using a cache buffer for the classes we evaluate.
        # we store the cache buffer as an extra argument of sys, so its global to the whole python environment!
        recursionCache = {}
        if hasattr(sys, 'recursionCache'):
            if DB_EnvVar in sys.recursionCache:
                recursionCache = sys.recursionCache[DB_EnvVar]
        else:
            sys.recursionCache = {}

        # check if the current class is cached, and if the current version changed.
        # if thats the case, we have to delete the cache and re-cache everything again!
        if self.className in recursionCache:
            if self.globalVersion.get(self.className) != recursionCache[self.className]["%s_VERSION" % self.className.upper()]:
                sys.recursionCache[self.DB_EnvVar] = {}
                recursionCache = sys.recursionCache[self.DB_EnvVar]

        # retrieve a previous evaluated version of this class, if any
        # so we don't waste time evaluating things more than once!
        if self.className in recursionCache:
            _environ.__init__(self)
            _environ.update(self, recursionCache[self.className])
            self.appFromDB = recursionCache[self.className].appFromDB
            self.path = recursionCache[self.className].path
            self.updatedClasses = recursionCache[self.className].updatedClasses

        # evaluate the class!
        else:
            self.DB_EnvVar = DB_EnvVar
            self.appFromDB = self.DB(self.className, platform, arch)
            self.path = self.appFromDB.path
            if self.version( self.globalVersion.get(self.className) ):
                _environ.__init__(self,
                    LIB                 = self.appFromDB.lib(),
                    PATH                = self.appFromDB.bin(),
                    INCLUDE             = self.appFromDB.include(),
                    LD_LIBRARY_PATH     = self.appFromDB.LD_LIBRARY_PATH(),
    #                    PYTHONPATH          = self.appFromDB.pythonPath(),
                )

            # store the class object into our recursionCache to prevent
            # from evaluating the class more than once!!
            recursionCache[self.className] = self
            sys.recursionCache[self.DB_EnvVar] = recursionCache

            if self.enable:
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
                # self.configFiles()

                self.evaluate()
#                # evaluate license method of all classes, just in case!
#                if hasattr( self, 'license' ):
#                    #only run if not root!
#                    if os.getuid()>0:
##                        log.debug(self.className)
#                        self._license()


            if 'USE_SYSTEM_LIBRARY' not in os.environ:
                os.environ['USE_SYSTEM_LIBRARY'] = ''

        # print self.className, versionLib.get('boost')

    @staticmethod
    def configFiles(self=None):
        ''' Run over config files located in the pipeline and also in jobs '''

        import sys
        if not hasattr( sys, "versionsFile" ):
            sys.versionsFile = []

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
                        sys.versionsFile += [line]

        version_py = ''.join(sys.versionsFile)
        exec( version_py )


    def ignorePipeLib(self, libname ):
        ''' set library names to ignore using from the pipe version and use
        system or application default ones!'''
        if self.parent() == self.className:
            if not 'USE_SYSTEM_LIBRARY' in os.environ:
                os.environ['USE_SYSTEM_LIBRARY'] = ''
            os.environ['USE_SYSTEM_LIBRARY'] += ' %s' % libname


    def updateLibs(self):
        ''' update environment with pipeline library paths '''
        # standard dependencies
        if self.parent() == self.className:
            from libs import allLibs, python
            allLibs = allLibs()
            libs={
                'LD_LIBRARY_PATH':[],
                'PYTHONPATH':[],
                'INCLUDE':[],
            }

            # we use this variable to flag libraries that should be ignored!
            if not 'USE_SYSTEM_LIBRARY' in os.environ:
                os.environ['USE_SYSTEM_LIBRARY'] = ''

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
                    for each in glob( "%s/%s/%s/lib/python%s" % (roots.libs(), lib, suffix, pv) ):
                        self['LD_LIBRARY_PATH'] = each
                    for each in glob( "%s/%s/%s/lib" % (roots.libs(), lib, suffix) ):
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

    def parent(self):
        ''' return the top wrapper class called by the user '''
        return os.environ['PARENT_BASE_CLASS']

    def bin(self):
        '''returns the app bin folder (from appsDB)'''
        ret = self.appFromDB.bin()

#        sys.stderr.write("%s\n" % str(ret))
#        sys.stderr.flush()


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
        for each in glob( '%s/*' %  self.bin()):
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
        if not '%s_VERSION' % appName in self: # prevent from adding twice!
            self.replace( {
                '%s_VERSION' % appName : self.appFromDB.version(),
                '%s_ROOT'    % appName : os.path.abspath( self.appFromDB.path()+'/' ),
            } )
            try:
                self.replace( {
                    '%s_VERSION_MAJOR' % appName : '.'.join( self.appFromDB.version().split('.')[0:2] ),
                })
            except: pass

            if '--logd' in sys.argv:
#                sys.stderr.write("%s \t " %  self.)
                sys.stderr.write("%25s " %  self.className)
                sys.stderr.write("%-25s " %  self.globalVersion.get(self.className))
                sys.stderr.write("python: %s\n" %  self.globalVersion.get('python'))
            py='.'.join( self.globalVersion.get('python').split('.')[:2] )
            pythonPaths = self.pythonPath()
            if py in pythonPaths:
                self['PYTHONPATH'] = pythonPaths[py]

            # run the virtual environ() method of the app class, if any!
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
#        return self.globalVersion.get(self.className)
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
        for each in glob( '%s/tools/config/*.py' % depotRoot() ):
            module = os.path.splitext(os.path.basename(each))[0]
            dir = os.path.dirname( each )
            sys.path.append( dir )
            if module not in __file__:
                exec( 'import %s;reload(%s);del %s' %  (module,module,module) )

            del sys.path[ sys.path.index( dir ) ]
            del module
        self.version()

    def expand(self, binName=None):
        ''' expand all env vars in this class to the environment
        if binName is specified, fullEnvironment will also run the license setup
        '''
        # here is were we actually update self with all updated
        self.fullEnvironment(binName)
        _environ.evaluate(self)

        # update python itself with the newly created PYTHONPATH.
        for each in os.environ['PYTHONPATH'].split(':'):
            sys.path += [each]


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
        ''' virtual method to be create to customize license setup in an app class
        '''
        self['LM_LICENSE_FILE'] = "%s/licenses/%s/%s" % (roots.tools(), self.className.lower(), self.appFromDB.version() )

    def _userSetup(self, binName=''):
        ignore = [ 'python', 'xnview', 'chrome', 'rv', 'qube'  ]

        # evaluate the noUserSetup() method, if one exists, to enable/disable
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

    def update(self, environClass={}, top={}, noIgnoreLibs=False, **e):
        # recall all added classes to batch update later at RUN
        useSystemLibs = []
        if 'USE_SYSTEM_LIBRARY' in os.environ and not noIgnoreLibs:
            useSystemLibs = os.environ['USE_SYSTEM_LIBRARY'].split()
        if environClass:
            if environClass.className not in useSystemLibs:
                self.updatedClasses[environClass.className] = environClass
                self.updatedClasses.update( environClass.updatedClasses )
                # we need to mantain the recursionCache up2date!!
                if environClass.className in sys.recursionCache[self.DB_EnvVar]:
                    sys.recursionCache[self.DB_EnvVar][environClass.className].updatedClasses = self.updatedClasses

        # do 'e' update on the fly!
        if e:
            _environ.update(self, e=e)

        if top:
            for each in top:
                self.insert(each,0, top[each])

    def inFarm(self):
        return False
        ret =  'PIPE_FARM_USER' in os.environ
#        if os.environ.has_key('PIPE_FARM_ENGINE'):
#            if os.envion['PIPE_FARM_ENGINE'] == 'afanasy':
#                ret=False
        return ret

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

        # only run if enviroment is set and not root!
        if os.getuid()>0:
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

    def run(self, binName):
        ''' the application!!! '''
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
            del sys.argv[id]
            del sys.argv[id]

        # force a disable of a certain package, if --disable <package>
        # TODO!!!
        if '--disable' in sys.argv:
            id = sys.argv.index('--disable')
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

        # if we are in a job/shot, make sure
        # the user has a writable folder to work!
        self._userSetup(binName)

        # use /bin/sh to run apps...
        os.environ['SHELL'] = '/bin/sh'

        # if the app is a wine app, set WINEPREFIX
        if os.path.exists( "%s/drive_c" % self.path() ):
            self['WINEPREFIX'] = self.path()
            self['WINE_VERSION'] = self.globalVersion.get('wine')
#            self['WINEDEBUG']='+opengl'
            # handles wine if extension of bin is .exe
            binNameExt = os.path.splitext( binName )[1].lower()
            if binNameExt == '.exe':
                os.environ['SHELL'] = '/bin/bash'
                debug = "run wine "


        # only run if enviroment is set and not root!
        if os.getuid()>0 or 'RUN_SHELL' in os.environ:
            # here is were we actually update self with all updated
            # classes - the ones we do 'self.update(classApp())' in environ method!
            self.fullEnvironment(binName)



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

        # run the software in GDB, if --debug in command line
        runWithOsSystem = binName in ['python','houdini','prman','mayapy']
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

        # one can specify an assepath to create dependency that can be
        # used by pre and post methods in apps
        # for example, maya.py uses this in post to publish rendered frames
        # into asset images folder!
        self.asset = None
        if '--asset' in sys.argv:
            id = sys.argv.index('--asset')
            self.asset = sys.argv[id+1]
            del sys.argv[id]
            del sys.argv[id]

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
        # TODO: mangle it correctly for debugging!!
        extra = ""
        if os.path.splitext(binName.split(' ')[0])[-1].lower() == '.py':
            from libs import python
            extra =  python().path('../$PYTHON_VERSION/bin/python')
#            if debug:
#                if 'gdb' in debug:
#                    extra += ' --debug'
#                else:
#                    extra += ' --gdebug'
#                debug = ''

        # -vgl32 is a vgl argument that forces vgl to intercept
        # 32bit opengl instead of 64bit default
        m32 = ''
        if '-vgl32' in sys.argv:
            m32 = '-32'
            del sys.argv[sys.argv.index('-vgl32')]

        # check if we have opengl hardware (local X11) or not (vnc/ssh)
        # if we don't, try running with virtualGL
        display=0
        if 'DISPLAY' in os.environ:
            display = float(os.environ['DISPLAY'].split(':')[-1])
        # we assume that ssh or any other remote connection will
        # have a DISPLAY bigger than 9 here, to detect if we need virtualGL or not!
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
        elif display > 9:
            debug = 'xhost + ; env QT_X11_NO_MITSHM=1 QT_GRAPHICSSYSTEM=opengl LIBGL_ALWAYS_INDIRECT=1  %s ' % (debug)


        # construct the command line to run the software
        binFullName = '%s/%s' % (self.bin(), binName)
        if os.path.islink(binFullName):
            binFullName = '%s/%s' % ( self.bin(), os.readlink( binFullName ) )
            binFullName = binFullName.replace(' ','\\ ')

        # ???
        if '--wine' in sys.argv:
            del sys.argv[sys.argv.index('--wine')]
            binFullName = ''

        # ???
        fixit = False
        if '--fix' in sys.argv:
            del sys.argv[sys.argv.index('--fix')]
            fixit = True

        # construct cmd string!!
        cmd = '%s %s %s %s' % (
            debug,
            extra,
            binFullName,
            # now add all arguments passed by command line, but the ones intercept above
            # which have being deleted from sys.argv!
            ' '.join( map(lambda x: '"%s"' % x.replace('"','\\"'), sys.argv[1:] ) )
        )

#        # ????!!!!
#        for each in filter(lambda x: '--' in x and '_version' not in x, sys.argv):
#            if hasattr( self, each[2:] ):
#                exec( 'self.%s()' % each[2:] )
#                del sys.argv[ sys.argv.index(each) ]


        # if we have a localCache method, call it to update/create the local cache
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
        if hasattr( self, 'preRun'):
            cmd = self.preRun(cmd)

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



        log.debug(cmd)

        # remove TBB_VERSION to avoid TBB spitting out information!!
        if 'TBB_VERSION' in os.environ:
            del os.environ['TBB_VERSION']


        # starup a shell instead of the software (usefull to debug environment)
        if '--shell' in sys.argv:
            del sys.argv[sys.argv.index('--shell')]
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

                    # # send all class env vars to sudo
                    # allEnvs = self.keys()
                    # go = ' echo %s ; ' % ('='*200)
                    #
                    # # if we're in a job, send it over too!
                    # if os.environ.has_key('PIPE_JOB'):
                    #     allEnvs.append('PIPE_JOB')
                    #     allEnvs.append('PIPE_SHOT')
                    # go = ' ; '.join(map(lambda x: 'export %s=\\"%s\\"' % (x,os.environ[x]), allEnvs ))
                    #
                    # go += ' ; echo %s ' % ('='*200)
                    #
                    # jobPath = filter(lambda x: '/jobs/%s/' % os.environ['PIPE_JOB'] in x, cmd.replace('"','\\"').split())
                    # if jobPath:
                    #     jobPath = jobPath[0]
                    # else:
                    #     jobPath = "No Job!!!"
                    #
                    # sudo = admin.sudo()
                    # # construct the su cmd line.
                    # sucmd = '''runuser -l %s -c '/bin/bash -l -c "echo %s ; %s ; %s ; %s 2>&1 " ' ''' % (
                    #     os.environ['PIPE_FARM_USER'],
                    #     jobPath,
                    #     go,
                    #     'export HOME=\\"%s\\"' % self['HOME'],
                    #     cmd.replace('"','\\"')
                    # )

                    print( "Running in farm as user: %s" % os.environ['PIPE_FARM_USER'] )
                    print( '='*80 )
                    # print sucmd
                    # # run it over dbusService!
                    # sudo.cmd( sucmd )
                    # try:
                    #     returnLog = sudo.run()
                    # except:
                    #     returnLog = "\n\t".join(traceback.format_exc().split('\n'))
                    #
                    # print returnLog
                    #
                    # if 'error' in returnLog.lower() or 'StackTrace()' in returnLog:
                    #     ret = 255
                    # else:
                    #     ret = 0
                    ret, returnLog = runProcess(cmd)

                else:
                    # as we need stdin for python, we use os.system for now until
                    # we find a solution for runprocess to be able to work with stdin!!
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

        # fix for afanasy to report a failed frame!!
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


    def LD_PRELOAD(self):
        pv = versionLib.get('python')
        bv = versionLib.get('boost')
        pvm = '.'.join(pv.split('.')[:2])
        ret =  glob( self.path('lib/*.so') )
        ret +=  glob( self.path('lib/python%s/*.so' % pvm) )
        ret +=  glob( self.path('lib/boost%s/*.so' % bv) )
        ret +=  glob( self.path('lib/boost%s/python%s/*.so' % (bv,pvm)) )
        return ret
