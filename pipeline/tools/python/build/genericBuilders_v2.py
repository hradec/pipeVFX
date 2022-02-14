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
# ===============================

from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Action import *
from  SCons.Script import *
import os, traceback, sys, inspect, re, time
from devRoot import *
import pipe
from pipe.bcolors import bcolors
from glob import glob


def versionMajor(versionString):
    return float('.'.join(versionString.split('.')[:2]))

DB={}
def spitDBout( target, source, env ):
    from pprint import pprint
    pprint(DB)
finish_command = Command( 'finish', [], spitDBout )

crtl_file_build   = '.build'
crtl_file_install = '.install'
crtl_file_lastlog = '.lastlog'

_spinnerCount = 0

global buildTotal
global buildCounter
global buildStartTime
buildTotal=0
buildCounter=0
buildStartTime=time.time()
global sconsParallel
sconsParallel=0
# if 'TRAVIS' in os.environ:
#     sconsParallel='1' in os.environ['TRAVIS']
# else:
#     os.environ['TRAVIS']='0'

if 'EXTRA' in os.environ and '-j' in os.environ['EXTRA']:
    sconsParallel=1

mem = ''.join(os.popen("grep MemTotal /proc/meminfo | awk '{print $(NF-1)}'").readlines()).strip()
if 'MEMGB' in os.environ:
    mem = os.environ['MEMGB']
memGB = float(mem)/1024/1024
print "Memory: %sGB" % memGB


def _print(*args):
    global sconsParallel
    # print args
    p = True
    l = ' '.join([ str(x) for x in args])
    if sconsParallel:
        p = False
        if '[' in l[0:40] and ']' in l[0:40]:
            p = True
        if '::' in l[0:20]:
            p = True
        if 'TRAVIS' in os.environ and os.environ['TRAVIS']!='1':
            if [ x for x in ['processing', 'building', 'Download', 'md5'] if x in l ]:
                p = True
        if 'touch' in l[:15]:
            p = False

    # dont print dinamic log line if running in CI
    if 'TRAVIS' in os.environ and os.environ['TRAVIS']=='1':
        if l[-1] == '\r':
            p=False

    if p:
        sys.stdout.write('\033[2K\033[1G')
        # if args[-1] == '\r':
        #     print " ".join([str(x) for x in args]),
        # else:
        #     print " ".join([str(x) for x in args])
        sys.stdout.write( l.strip() )

        if l[-1] != '\r':
            sys.stdout.write("\n")
    sys.stdout.flush()
s_print = _print

def expandvars(path, env=os.environ, default=None, skip_escaped=False):
    """Expand environment variables of form $var and ${var}.
       If parameter 'skip_escaped' is True, all escaped variable references
       (i.e. preceded by backslashes) are skipped.
       Unknown variables are set to 'default'. If 'default' is None,
       they are left unchanged.
    """
    def replace_var(m):
        return env.get(m.group(2) or m.group(1), m.group(0) if default is None else default)
    reVar = (r'(?<!\\)' if skip_escaped else '') + r'\$(\w+|\{([^}]*)\})'
    return re.sub(reVar, replace_var, path)


def DEBUG():
    return ARGUMENTS.get('debug', 0)


try:
    tcols = int(''.join(os.popen('tput cols').readlines()))-1
except:
    tcols = 120


import multiprocessing

buildVersions = []
def baseLib(library=None):
    ''' baseLib are libraries that are basic to build other libraries, like Python versions'''
    if library:
        buildVersions.append(library)
    return buildVersions


allPkgs = {}
__pkgInstalled__={}
class pkgInstalled:
    @staticmethod
    def set(id, v):
        global __pkgInstalled__
        __pkgInstalled__[id] = v


# initialize CORES and DCORES(double cores) env var based on the number of cores
# the host machine has
print "=====> SCONS ARGUMENTS:",ARGUMENTS,"<======"
CORES=int(multiprocessing.cpu_count())
if 'CORES' in ARGUMENTS:
    CORES = int(ARGUMENTS['CORES'])
os.environ['DCORES'] = '%d' % (2*CORES)
os.environ['CORES']  = '%d' % CORES
os.environ['HCORES'] = '%d' % (CORES/2)

# if we have less than 8GB, use half of the cores to build
if memGB < 5:
    os.environ['DCORES'] = '%d' % (CORES/2)
    os.environ['CORES']  = '%d' % (CORES/4)
    os.environ['HCORES'] = '%d' % (CORES/8)
elif memGB < 8:
    os.environ['DCORES'] = '%d' % (CORES)
    os.environ['CORES']  = '%d' % (CORES/2)
    os.environ['HCORES'] = '%d' % (CORES/4)



# we store in this list all builds that we want to make
# subsequent builds depend on.
# As we store the scons build class, we have all the info we need
# for the subsequent builds, including all versions build information
# so we a build can pick and choose its dependency version, if needed!
allDepend = []
all_env_vars = {}


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
            1. remove %s (it environ_builds fine without it!)
            2. install a newer Nvidia driver, which fixes this (since it's their fault it seems newer drivers fix it!!)

    ''' % (f,f) + bcolors.END )

def __add_boost_python_versioned_lib_folder(paths):
    # make sure paths is a new list, not a pointer
    ret = []+paths
    # add extra rpath to account for boost versioned libs
    for p in [ x for x in paths if 'BOOST' not in x.upper()]:
        ret += [p+'/boost.$BOOST_VERSION/']
    # add extra rpath to account for python versioned libs
    paths = []+ret
    for p in [ x for x in paths if 'PYTHON' not in x.upper()]:
        ret += [p+'/python$PYTHON_VERSION_MAJOR/']

    return ret

def rpath_environ( paths=[], disable="" ):
    ''' create env vars to add rpath to gcc link, as well as include paths.
    pass the lib folder of a package, and it will figure the include path'''
    if type(paths) == type(""):
        paths = [paths]
    paths = __add_boost_python_versioned_lib_folder(paths)

    if 'NOBOOST' not in disable:
        paths += [
            '$BOOST_TARGET_FOLDER/lib/',
            '$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
        ]
    if 'NOILM' not in disable:
        paths += [
            '$OPENEXR_TARGET_FOLDER/lib/',
            '$ILMBASE_TARGET_FOLDER/lib/',
        ]

    # special case for OIIO and OCIO libraries.
    paths += [
        '$OIIO_TARGET_FOLDER/lib/',
        '$OCIO_TARGET_FOLDER/lib/',
    ]

    # special case for cortex libraries.
    paths += [
        '$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/',
        '$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/',
        '$CORTEX_TARGET_FOLDER/openvdb/$OPENVDB_VERSION/lib/boost.$BOOST_VERSION/',
        '$CORTEX_TARGET_FOLDER/alembic/$ALEMBIC_VERSION/lib/boost.$BOOST_VERSION/',
        '$CORTEX_TARGET_FOLDER/usd/$USD_VERSION/lib/boost.$BOOST_VERSION/',
        '$CORTEX_TARGET_FOLDER/openvdb/$OPENVDB_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages/',
        '$CORTEX_TARGET_FOLDER/alembic/$ALEMBIC_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages/',
        '$CORTEX_TARGET_FOLDER/usd/$USD_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages/',
    ]

    _environ = {
        'LDFLAGS' : ' $LDFLAGS '
            +' -Wl,-rpath,'+' -Wl,-rpath,'.join(paths)
            # +' -Wl,-rpath-link,'+' -Wl,-rpath-link,'.join(paths)
        ,
        'RPATH' : ':'.join(paths+['$RPATH'])
    }
    return removeDuplicatedEntriesEnvVars(_environ)

def lib_environ( paths=[], disable="" ):
    ''' create env vars to add rpath to gcc link, as well as include paths.
    pass the lib folder of a package, and it will figure the include path'''
    if type(paths) == type(""):
        paths = [paths]
    paths = __add_boost_python_versioned_lib_folder(paths)

    _environ = {
        'LDFLAGS' : ' $LDFLAGS '+' -L'+' -L'.join(paths),
        'LIBRARYPATH' : ':'.join(paths+[
            '$LIBRARYPATH',
            '$BOOST_TARGET_FOLDER/lib/',
            '$OPENEXR_TARGET_FOLDER/lib',
            '$ILMBASE_TARGET_FOLDER/lib',
            '$OIIO_TARGET_FOLDER/lib/',
            '$OCIO_TARGET_FOLDER/lib/',
        ]),
    }
    return removeDuplicatedEntriesEnvVars(_environ)

def include_environ( paths=[], disable="" ):
    ''' create env vars to add rpath to gcc link, as well as include paths.
    pass the lib folder of a package, and it will figure the include path
        disable = "NOBOOST" -> remove default boost includes
        disable = "NOILM" -> remove default ilmbase/openexr includes
    '''
    if type(paths) == type(""):
        paths = [paths]
    if 'NOBOOST' not in disable:
        paths += [
            '$BOOST_TARGET_FOLDER/include/',
            '$BOOST_TARGET_FOLDER/include/boost/',
        ]
    if 'NOILM' not in disable:
        # we need this to build with exr version below 2.2.0
        paths += [
            '$OPENEXR_TARGET_FOLDER/include/',
            '$OPENEXR_TARGET_FOLDER/include/OpenEXR/',
            '$ILMBASE_TARGET_FOLDER/include/',
            '$ILMBASE_TARGET_FOLDER/include/OpenEXR/',
        ]

    _environ = {
        'CFLAGS'      : ' $CFLAGS ',
        'CXXFLAGS'    : ' $CXXFLAGS ',
        'CPPFLAGS'    : ' $CPPFLAGS ',
        'CPPCXXFLAGS' : ' $CPPCXXFLAGS ',
        'CPATH' : ':'.join(paths+['$CPATH']),
        # 'CPLUS_INCLUDE_PATH' : ':'.join(paths),
        # 'C_INCLUDE_PATH' : ':'.join(paths),
    }
    return removeDuplicatedEntriesEnvVars(_environ)


# some env vars require : to divide paths
PATH_ENV_VAR = [
    'CPLUS_INCLUDE_PATH',
    'C_INCLUDE_PATH',
    'INCLUDE',
    'LIB',
    'LIBRARY',
    'CPATH',
    'RPATH',
    'LIBRARY_PATH',
    'LD_LIBRARY_PATH',
    'LD_PRELOAD'
    'PATH'
]
def removeDuplicatedEntriesEnvVars(data):
    ''' remove duplicated entries in env vars '''
    result = {}
    clean_result = {}
    result.update(data)
    for _env in data:
        result[_env] = str(result[_env])
        cleanup = []
        divisor=' '
        if _env in PATH_ENV_VAR:
            divisor=':'
        for each in result[_env].split(divisor):
            if each not in cleanup:
                cleanup += [each]
        clean_result[_env] = divisor.join(cleanup)

        # remove double characters
        for removeDoubles in ['  ', '::', '//']:
            clean_result[_env] = clean_result[_env].replace(removeDoubles, removeDoubles[0])
            clean_result[_env] = clean_result[_env].rstrip(removeDoubles[0])

    return clean_result


def update_environ_dict(dict1, dict2addingTo1):
    ''' add a environ dictionary correctly to another, without
    overriding key values'''
    result = {}
    clean_result = {}
    result.update(removeDuplicatedEntriesEnvVars(dict1))
    for _env in removeDuplicatedEntriesEnvVars(dict2addingTo1):
        # make sure key exists in result dict
        if _env not in result:
            result[_env] = ''

        divisor=' '
        if _env in PATH_ENV_VAR:
            divisor=':'

        # account for $ENVVAR in itself
        # we always prepend the $ENVVAR to itself.
        _ENV = None
        if _env not in ['LD','CC','CXX','CXXCPP','CPP']:
            _ENV = '$%s' % _env.upper()

        # print _ENV, dict2addingTo1[_env].replace(_ENV,result[_env])
        if _ENV and _ENV in dict2addingTo1[_env]:
            var = divisor.join([result[_env],_ENV])
            result[_env] = dict2addingTo1[_env].replace(_ENV,var)
        else:
            result[_env] = dict2addingTo1[_env]

    return removeDuplicatedEntriesEnvVars(result)


def globalDependency(classObj, RPATH=True, LIB=True, INCLUDE=True ):
    # ==========================================================================
    # add class obj as a global dependency for all subsequent builds!
    # We MUST do this at the end, so it won't influence itself
    # ==========================================================================
    global allDepend
    global all_env_vars
    # if not [ x for x in allDepend if x.name == classObj.name and x.targetSuffix == classObj.targetSuffix]:
    if not [ x for x in allDepend if x.name == classObj.name and x.targetSuffix == classObj.targetSuffix]:
        allDepend += [classObj]
    if RPATH:
        all_env_vars = update_environ_dict(all_env_vars, rpath_environ(   '$%s_TARGET_FOLDER/lib/'     % classObj.name.upper() ))
    if LIB:
        all_env_vars = update_environ_dict(all_env_vars, lib_environ(     '$%s_TARGET_FOLDER/lib/'     % classObj.name.upper() ))
    if INCLUDE:
        all_env_vars = update_environ_dict(all_env_vars, include_environ( '$%s_TARGET_FOLDER/include/' % classObj.name.upper() ))



def checkPathsExist( os_environ ):
    '''' remove unexistent paths from a env vars dict '''
    for each in os_environ.keys():
        # check if the paths in the env vars exists.
        # skip the ones that doesn't
        if each in PATH_ENV_VAR:
            parts = []
            for n in os_environ[each].split(':'):
                if n.strip():
                    # check if we have a path,
                    # so we can check if the path exists
                    if n[0] == '/' and not os.path.exists( n ) and 'http' not in n:
                        continue
                    parts += [n]
            os_environ[each] = ':'.join(parts)




class _parameter_override_:
    name='None'
    real_name='None'
    targetSuffix=''
    downloadList=[range(10)]
    _depend={}
    do_not_use=True



class pkg_superdict(dict):
    ''' a dictionary where you can use the object as key, or a string
    that matches it's .name variable '''
    obj = None
    version = None
    class superstring(str):
        obj=None
        version=None
    def __getitem__(self, key):
        if type(key) == type(""):
            v = [x for x in self.keys() if x.real_name == key.lower()]
            if v:
                key = v[0]

        if dict.has_key(self, key):
            value = str(dict.__getitem__(self, key))
            ret = pkg_superdict.superstring(value)
            ret.obj = key
            ret.version = str(value)
        else:
            # we do this so we can add dependency of versions that exist,
            # and just ignore when the requested version doesn't exist.
            # (ex: ilmbase 2.3.0 and up is builtin openexr, but we still add it
            # when version is bellow, so to avoid adding "ifs" everywhere, we
            # just ignore then)
            # print ":: key ",key,"requested, but does not exist!"
            ret = pkg_superdict.superstring("0.0.0")
            ret.obj = None
            ret.version = str("0.0.0")
            ret.requested_key = key
            print ":: WARNING: key",key,"doesn't exist"
        return ret

    def __setitem__(self, key, v):
        _keynames = self.keyNames()
        if key.real_name in _keynames.keys():
            dict.__setitem__(self, _keynames[key.real_name], v)
        else:
            dict.__setitem__(self, key, v)

    def __contains__(self,key):
        ''' check if a dependency pkg with name key exists '''
        if type(key) in [str]:
            if [ x for x in self.keys() if x.real_name == key ]:
                return True
        else:
            return key in self
        return False

    def keyNames(self):
        return { x.real_name: x for x in self.keys() }

    def update(self, d):
        _keynames = self.keyNames()
        for key in d:
            if key:
                # since keys are build classes objs, we first
                # check if the class name exists, and re-use
                # the obj for the given classname.
                # this fixes the issue where we can endup having
                # 2 dependencies of the same package, each with a diferent
                # version.
                if key.real_name in _keynames.keys():
                    self[ _keynames[key.real_name] ] = d[key]
                else:
                    self[key] = d[key]




# a class to override builder parameters in the download dependency dictionary,
# so we can override a default parameter for a specific version of a package,
# like src, for example.
class override:
    class src(_parameter_override_):
        pass

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

            noMinTime   = if True, won't assume a minimum time of 5 seconds for builds

            globalDependency =  set the build as a dependency for all subsequent builds (so no need to add it in the depend list)
                                if more than one version is available, the subsequent builds will use the last version in the download list!
                                to set a specific version, set it in the last 5th line of the tupple in the download item. (see download above!)
                                if the string "NORPATH" is assigned to this parameter, no Wl,rpath will be added to the global dependency
                                if the string "NOINCLUDE" is assigned to this parameter, no -isystem will be added to the global dependency, neither *_INCLUDE_PATH will be defined
                                if the string "NOLIB" is assigned to this parameter, no -L will be added to the global dependency, neither LIBRARYPATH will be set

    '''
    src   = ''
    cmd   = ''
    extra = ''
    sed = {}
    environ = {}
    do_not_use=False


    def __init__(self, args, name, download, baseLibs=None, env=None, depend=[], GCCFLAGS=[], sed=None, environ=None, compiler=gcc.pipe, **kargs):
        global __pkgInstalled__
        global buildTotal
        global sconsParallel
        global allDepend
        global all_env_vars

        download = [ list(x) for x in download ]

        self.__dict__.update(kargs)

        self.gcc_pipe = gcc.pipe
        self.gcc_system = gcc.system

        self.spinnerCount = 0

        DB[name] = {}

        self.args     = args
        self.name     = name
        self.real_name= name
        self.download = download
        self.baseLibs = baseLibs
        self.env      = env
        self.depend   = depend
        self.name     = name
        if hasattr(self, "init"):
            self.init()
            args     = self.args
            name     = self.name
            download = self.download
            baseLibs = self.baseLibs
            env      = self.env
            depend   = self.depend
            name     = self.name

        self.github_matrix = False
        if 'MATRIX' in self.args:
            self.github_matrix = True

        # store a list of versions and version dependency versions if
        # one exist.
        self.download_versions = {}
        for x in download:
            self.download_versions[x[2]] = {}
            # if we have the 5th element
            # we store it (the dict of packages:versions)
            if len(x) > 4:
                self.download_versions[x[2]] = x[4]


        # initialize a scons environment for this class object!
        if self.env is None:
            self.env = Environment()

        self.env2 = {}
        for each in self.download_versions:
            self.env2[each] = Environment()
        # ==============================================
        # dealing with global dependencies only in here
        # and at the bottom of __init__
        # only self.depend and self.environ are altered
        # with global dependency values!
        # ==============================================
        # add global dependency if not already in
        self__dependNames = [ '%s%s' % (x.name, x.targetSuffix) for x in self.depend if hasattr(x, 'name') ]
        if type(self.depend) == type([]):
            self.depend += [x for x in allDepend if '%s%s' % (x.name, x.targetSuffix) not in self__dependNames]
        else:
            for d in allDepend:
                if d not in self.depend:
                    self.depend[d] = None # no version set

        # print '====>', name, [ x.name for x in allDepend ], [x.name for x in self.depend]

        # fix depend in case we're reusing it from another package
        self.depend = [x for x in self.depend if hasattr(x, 'name')]
        depend      = self.depend

        # se environment override
        if environ:
            self.environ  = environ

        # add global env vars
        if not hasattr(self,'environ'):
            self.environ = {}
        self.environ = update_environ_dict(self.environ, all_env_vars)


        # we pass over self.environ as ENVIRON_<key()> in the scons environment,
        # so the static build function can pick it up at build time, since build
        # time has no access to the class state at this point in time.
        for n in self.environ.keys():
            self.set("ENVIRON_%s" % n.upper(), self.environ[n])

        # ==============================================

        if not self.baseLibs:
            self.baseLibs = 'noBaseLib'


        sys.stdout.write( bcolors.END )
        self.className = str(self.__class__).split('.')[-1]
        self.GCCFLAGS = GCCFLAGS
        self.args = args
        self.error = None
        self._os_environ = {}
        self.os_environ = {}

        self.targetSuffix=""
        if kargs.has_key('targetSuffix'):
            self.targetSuffix = kargs['targetSuffix'] #.replace('.','_')

        if kargs.has_key('real_name'):
            self.real_name = kargs['real_name'] #.replace('.','_')

        # cleanup tmp folders
        os.popen("rm -rf %s/tmp.*" % buildFolder(args)).readlines()

        # add this class to the allPkgs cache
        allPkgs[name] = self


        # set the default version to use!
        # if one is not set, we default to the latest in the download list
        self.version_default = -1
        if kargs.has_key('version_default'):
            for n in range(len(download)):
                if kargs['version_default'] == download[n][2]:
                    self.version_default = n
                    break

        # dependOn retain all dependency packages for each version of this
        # this package. If None is set for a package version, it will use
        # the latest version in the package download list.
        self.dependOn = {}
        # self.depend is the dependency list for all versions of this build
        for download_version in self.download_versions:
            if download_version not in self.dependOn:
                self.dependOn[download_version] = pkg_superdict()
                self.dependOn[download_version].obj = self
                self.dependOn[download_version].version = download_version

            # now we finally update self.dependOn with self.depend
            for dependencyPkg in self.depend:
                # set the last version on the download list for each package
                #  in the self.depend list!
                defaultVersion = dependencyPkg.version_default
                # if the package is python, we try to default to the oldest
                # if dependencyPkg.name == 'python':
                #     print "===========================> ", self.name,  dependencyPkg.name, dependencyPkg.version_default, defaultVersion,dependencyPkg
                #     defaultVersion = 0
                dependencyPkgLatestVersion = dependencyPkg.downloadList[defaultVersion][2]
                self.dependOn[download_version][dependencyPkg] = dependencyPkgLatestVersion

        # but download list retains individual versions of packages to build
        # a version of this build.
        # add/update the dependency versions from the download[n][5] (dict)
        for download_version in self.download_versions:
            if self.download_versions[download_version].keys():
                self.dependOn[download_version].update(self.download_versions[download_version])

        # double check if the version required does exist in the packages.
        # if not, delete it!
        for download_version in self.download_versions:
            keys = []+self.dependOn[download_version].keys()
            for each in keys:
                if not self.dependOn[download_version][each].obj:
                    print "::==> deleting dependency for ",self.name,": it's None (", self.dependOn[download_version][each].requested_key, ')'
                    del self.dependOn[download_version][each]
                if hasattr(self.dependOn[download_version][each].obj, 'download_versions'):
                    if self.dependOn[download_version][each].version not in self.dependOn[download_version][each].obj.download_versions:
                        ts=""
                        if self.targetSuffix:
                            ts=" (%s)" % self.targetSuffix
                        print "::==> deleting dependency for ",self.name," (",download_version+ts,"): ", self.dependOn[download_version][each].obj.name, self.dependOn[download_version][each].version, "does not exist!"
                        del self.dependOn[download_version][each]

        # set gcc_version for instalation purposes
        # gcc_version = None
        # for download_version in self.download_versions:
        #     for each in self.dependOn[download_version]:
        #         if 'gcc' == each.name and not each.targetSuffix:
        #             gcc_version = self.dependOn[download_version][each]
        # if gcc_version == None:
        #     gcc_version='gcc-multi'


        # set the base libraries to build for.
        # we'll repeat this package build for each base library version
        class noBaseLibPlaceHolder:
            name = 'noBaseLib'
            downloadList = [('','','')]

        if type(self.baseLibs) == type(""):
            self.baseLibs = noBaseLibPlaceHolder

        if type(self.baseLibs) != list:
            self.baseLibs = [self.baseLibs] #noqa

        for n in range(len(self.baseLibs)):
            if not self.baseLibs[n]:
                self.baseLibs[n] = noBaseLibPlaceHolder



        # the download list of package versions
        self.downloadList = download

        # versions:
        self.versions = {}
        for each in self.downloadList:
            self.versions[each[2]] = each

        # sed patches, per initial version
        if sed:
            self.sed  = sed

        # cmds to build!
        self.kargs = kargs
        if kargs.has_key('cmd'):
            self.cmd = kargs['cmd']
        if type(self.cmd)==str:
            self.cmd = [self.cmd]

        if kargs.has_key('src'):
            self.src = kargs['src']

        if kargs.has_key('flags'):
            if not hasattr(self, 'flags'):
                self.flags = []
            self.flags += kargs['flags']

        if kargs.has_key('keep_source_folder'):
            self.keep_source_folder = kargs['keep_source_folder']
            self.set( "KEEP_SOURCE_FOLDER", '1' if self.keep_source_folder else '0')

        self.userData = None
        if kargs.has_key('userData'):
            self.userData = kargs['userData'].replace('.','_')

        self.ramdisk = None
        if kargs.has_key('ramdisk'):
            self.ramdisk = kargs['ramdisk']
            self.set( "BUILD_RAMDISK", self.ramdisk )

        self.dontUseTargetSuffixForFolders = None
        if kargs.has_key('dontUseTargetSuffixForFolders'):
            self.dontUseTargetSuffixForFolders = kargs['dontUseTargetSuffixForFolders']


#        bld = Builder(action = self.sed)
#        self.env.Append(BUILDERS = {'sed' : bld})

        # add our custom SCons build method downloader and uncompressor
        self.env.AddMethod(self.downloader, 'downloader')

        # bld = Builder( action = Action( self.uncompressor, 'uncompress($SOURCE0 -> $TARGET)') )
        bld = Builder( action = Action( self._uncompressor, self.sconsPrint) )
        self.env.Append(BUILDERS = {'uncompressor' : bld})

        # make sure our build folder exists!
        os.popen( "mkdir -p %s" % buildFolder(self.args) )

        # download latest config.sub and config.guess so we use then to build old packages in newer systems!
        for each in ['%s/../.download/config.sub' % buildFolder(self.args), '%s/../.download/config.guess' % buildFolder(self.args)]:
            if not os.path.exists(each) or os.path.getsize(each)==0:
                _print( 'Downloading latest %s' % each )
                os.popen( 'wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=%s;hb=HEAD" -O %s 2>&1' % (os.path.basename(each),each) ).readlines()
                os.popen("chmod a+x %s" % each).readlines()
                os.popen("ln -s ../.download/%s %s/../.build/" % (os.path.basename(each), os.path.dirname(each)) ).readlines()


        # store the compiler type to use (DEPRECATED??)
        self.compiler = compiler
        self.set( "BUILD_COMPILER", self.compiler )

        # store all string variables from the class (self.variable of type str)
        # inside the current scons ENV, so they can be retrieved at build time
        # if necessary!
        # the variable name is upper() case!
        for each in filter(lambda x: type(x[1])==str and not '__' in x[0], inspect.getmembers(self)):
            self.set(each[0].upper(), each[1])

        for each in filter(lambda x: type(x[1])==list and not '__' in x[0], inspect.getmembers(self)):
            v = each[1]
            for n in range(len(v)):
                if type(v[n])==str:
                    self.set("%s_%s_%s_%02d" % (each[0].upper(),self.className,self.name,n), v[n])


        # check if we're running in TRAVIS-CI
        self.travis=False
        if 'TRAVIS' in os.environ:
            if '1' in os.environ['TRAVIS']:
                self.travis=True
        if  sconsParallel:
            self.travis=True
        self.set("TRAVIS", '1' if self.travis else '0')

        # check if we have proxy setup
        if 'http_proxy' in os.environ:
            self.set("http_proxy", os.environ['http_proxy'])
            self.http_proxy = os.environ['http_proxy']

        if 'https_proxy' in os.environ:
            self.set("https_proxy", os.environ['https_proxy'])
            self.https_proxy = os.environ['https_proxy']


        # add all extra arguments as env vars!
        for each in kargs:
            v=kargs[each]
            if type(v)==type(""):
                v=[kargs[each]]
            if type(v) not in [int, float, bool, dict]:
                if v:
                    for n in range(len(v)):
                        self.set("%s_%s_%s_%02d" % (each.upper(),self.className,self.name,n), v[n])

        # make adjustments according to app used in the build
        # this will change the version specified in the download[4]
        # dictionary!
        self.setAppsInit()

        # build all python versions specified (baseLib)
        self.buildFolder = {}
        self.targetFolder = {}
        self._depend = {}
        self.installAll = []
        self.downloader_install_done_file = {}
        self.downloader_archive = {}

        # when no baselib is set, self.baseLibs will
        # be a noBaseLibPlaceHolder class obj
        for baselib in self.baseLibs:
            for baselibDownloadList in baselib.downloadList:
                # create target file
                p = baselib.name
                if baselibDownloadList:
                    p = "%s%s" % (baselib.name,baselibDownloadList[2])

                # add target sufix to target file.
                pythonDependency = ".%s" % p
                if self.targetSuffix.strip():
                    pythonDependency = ".%s-%s" % (p,self.targetSuffix)

                self._depend[p] = []
                self.buildFolder[p] = []
                self.targetFolder[p] = []

                # if we have a real baseLib, add it as dependency
                baselib_gcc = None
                baselib_gcc_version = None

                # setup specific for when using baseLibs (python!)
                if 'noBaseLib' not in baselib.name:
                    # run over all download versions and set the version
                    # of the baselib!
                    for download_version in self.download_versions:
                        self.dependOn[download_version].update( {baselib :  baselibDownloadList[2] } )

                    # # find if baselib has gcc as dependency and add it to the list
                    # # we force the package version to use the same gcc
                    # # version as the baselib gcc
                    # baselib_gcc = [ x for x in baselib.dependOn if 'gcc' in x.name and not x.targetSuffix]
                    # if baselib_gcc:
                    #     baselib_version = self.dependOn[baselib]
                    #     baselib_gcc_version = [ x for x in baselib.downloadList if x[2] == baselib_version ]
                    #     if baselib_gcc_version:
                    #         if len(baselib_gcc_version[0])>4:
                    #             baselib_gcc_version = baselib_gcc_version[0][4][baselib_gcc[0]]
                    #             for download_version in self.download_versions:
                    #                 self.dependOn[download_version].update( { baselib_gcc[0] :  baselib_gcc_version } )


                # build all versions of the package specified by the download parameter
                for download_version in self.download_versions:
                    dependOnBackup = {}.update(self.dependOn[download_version])
                self._dependOnByVersion = {}


                self.downloader_install_done_file[baselib] = []
                self.downloader_archive[baselib] = []
                for n in range(len(download)):

                    # os.environ['GCC_VERSION'] can override the gcc version set in the installRoot
                    self.installPath = os.path.abspath(installRoot(self.args))

                    targetpath = os.path.join(buildFolder(self.args),download[n][1].replace('.tar.gz',pythonDependency))
                    if '.zip' in download[n][1]:
                        targetpath = os.path.join(buildFolder(self.args),download[n][1].replace('.zip',pythonDependency))
                    if '.rpm' in download[n][1]:
                        targetpath = os.path.join(buildFolder(self.args),download[n][1].replace('.rpm',pythonDependency))

                    installpath = os.path.join( self.installPath,  self.name, download[n][2] )
                    # print "%s/install.*.done" % installpath, glob( "%s/install.*.done" % installpath )

                    # build and install folder
                    self.buildFolder[p].append( targetpath  )
                    self.targetFolder[p].append( installpath  )
                    self.env['TARGET_FOLDER_%s' % download[n][2].replace('.','_')] = self.targetFolder[p][-1]
                    os.environ['%s_TARGET_FOLDER' % self.name.upper()] = os.path.abspath(self.targetFolder[p][-1])

                    setup = os.path.join(self.buildFolder[p][-1], self.src)
                    # custom src in the download dictionary
                    if  len(download[n])>4:
                        if override.src in download[n][4]:
                            setup = os.path.join(self.buildFolder[p][-1], download[n][4][override.src])

                    build = os.path.join( self.targetFolder[p][-1], '%s%s.done' % (crtl_file_build, pythonDependency) )
                    install = os.path.join( self.targetFolder[p][-1], '%s%s.done' % (crtl_file_install, pythonDependency) )
                    self.downloader_install_done_file[baselib] += [install]

                    # if install folder has no sub-folders with content,
                    # or if the final install file doesn't exist, we probably got a fail install,
                    # so force re-build!
                    if not self._installer_final_check( [install], [build] ):
                        # if not installed, remove build folder!
                        if os.path.exists(self.buildFolder[p][-1]) and not self.github_matrix:
                            cmd = "rm -rf "+self.buildFolder[p][-1]+" 2>/dev/null"
                            _print( ":: __init__:",cmd,"\r" )
                            os.popen(cmd).readlines()

                    # _pkgs hold all download files for all versions of this
                    # pacakage
                    _pkgs = []
                    # file to be download
                    archive = os.path.join(buildFolder(self.args),download[n][1])
                    self.downloader_archive[baselib] += [archive]
                    if download[n][0]:
                        # the download URL is not empty!

                        # so actions can check if its installed
                        __pkgInstalled__[os.path.abspath(archive)] = install

                        #download pkg
                        pkgs = self._download(archive)

                        #uncompress pkg so scons can see the source (setup) file
                        s = self.uncompress(setup, pkgs)
                        _pkgs += [pkgs]
                    else:
                        # when the download URL is Empty (PIP)
                        # just create the build folder, and create the
                        # source (setup) file so the build function can be called
                        # by SCons
                        # this accounts for builds like python pip
                        s = os.path.join(buildFolder(self.args),download[n][1],self.src)
                        if not self.github_matrix:
                            os.system( 'rm -rf "%s" ; mkdir -p "%s" ; touch "%s"' % (os.path.dirname(s), os.path.dirname(s), s) )



                    # add dependencies as source so dependencies are built
                    # first.
                    source = []
                    # this also makes possible to display the
                    # dependency.versions during build.
                    # reminder: self.download_versions keys are string versions!
                    for download_version in self.download_versions:
                        # just a reminder:
                        # pkgDictKey is a package object, not a string!
                        for pkgDictKey in self.dependOn[download_version].keys():
                            if not hasattr(pkgDictKey, 'download'):
                                continue

                            # check if this dependency applies to this version of the package!
                            # if the version has the dependency as None, we should NOT depend on
                            # it for this version! (ex: openssl for python 2.6 and not for python 2.7)
                            if not self.dependOn[download_version][pkgDictKey]:
                                continue

                            # dependVersion = self.dependOn[download_version][pkgDictKey]
                            # tmp = [ x for x in pkgDictKey.download if x[2] == dependVersion ]
                            # if tmp:
                            #     if self.name == 'pyilmbase':
                            #         print pkgDictKey.name, dependVersion
                            #     __source_install =  __pkgInstalled__[ os.path.join( buildFolder(self.args), [ x for x in pkgDictKey.download if x[2] == dependVersion ][0][1] ) ]
                            #     if  __source_install not in source:
                            #         source += [__source_install]
                            # else:

                            # now, add dependencies to the source list
                            # so we can instruct scons to build the dependency
                            # first!
                            # reminder: depend_n is the index of the
                            # dependOn.dowloadList[] for the given version
                            depend_n, dependOn = self.depend_n(pkgDictKey, download_version)
                            # keys of the dependency package object _depend variable
                            # _depend keys are the same as "p" (baselibname+version)
                            # and value of _depend[key] is the target file
                            k = dependOn._depend.keys()
                            # if baselib "name"+"version" exists in the keys of
                            # the dependency package obj _depend variable.
                            if p in k:
                                # so we have the target for the current
                                # baselibName+version in the dependency
                                # package _depend variable...
                                if dependOn._depend[p][depend_n] not in source:
                                    # but it doesn't exist in the source list
                                    source.append( dependOn._depend[p][depend_n] )
                                # else:
                                #     if self.name == 'pyilmbase':
                                #         print 1, depend_n, dependOn.name, ".%s." % dependOn.targetSuffix, p, k, dependOn._depend[p][depend_n]

                            # the baselib name+version doesnt exist in the
                            # dependency package obj _depend keys, but there
                            # are keys in it!
                            elif len(k)>0:
                                # since we don't have a matching key for the
                                # current baselibName+version, just get the
                                # latest
                                kk=k[-1]
                                if dependOn._depend[kk][depend_n] not in source:
                                    source.append( dependOn._depend[kk][depend_n] )
                            #     else:
                            #         if self.name == 'pyilmbase':
                            #             print 2, depend_n, dependOn.name, ".%s." % dependOn.targetSuffix, p, k
                            # else:
                            #     print 3, depend_n, dependOn.name, ".%s." % dependOn.targetSuffix, p, k


                    # _new_source=[]
                    # for each in source:
                    #     if self.name not in str(each):
                    #         _new_source += [each]
                    # source = [ x for x in source if self.name not in str(each) ]

                    # source.sort()
                    # source = list(set(source))


                    ENVIRON_DEPEND = []
                    for download_version in self.download_versions:
                        # set a DEPEND env var that contains all dependency names
                        ENVIRON_DEPEND += [x.real_name for x in self.dependOn[download_version] if hasattr(x, 'name')]
                    self.set( "ENVIRON_DEPEND",  ' '.join(ENVIRON_DEPEND) )

                    # ENVIRON_DEPEND_VERSION is only used to display dependency during build
                    # source_versions = [ '.'.join(str(x[0]).split(os.path.sep)[-3:-1])  for x in source ]
                    source_versions = []
                    for x in source:
                        pkg_name_version = '.'.join(str(x[0]).split(os.path.sep)[-3:-1])
                        if 'python.' in pkg_name_version and 'noBaseLib-' in str(x[0]):
                            source_versions += ['pip_'+str(x[0]).split('noBaseLib-')[-1].split('.done')[0]]
                        else:
                            source_versions += [pkg_name_version]
                    source_versions.sort()
                    self.set( "ENVIRON_DEPEND_VERSION",  ' '.join( source_versions ) )

                    # we use this to inform the build python module when it's
                    # been imported inside a running build
                    self.set( "ENVIRON_BUILD_RUNNING",  '1' )

                    # print self.name, gcc_version

                    # add dependency to uncompress
                    # s is the source file for each build
                    # ex: in a build.configure, s="configure" file!
                    self.env.Depends(s, source)
                    # source = [s]+source

                    # download
                    aliasDownload = self.env.Alias( 'download', _pkgs )

                    # build
                    b = self.action( build, [s,_pkgs] )

                    # call the install builder, in case a class need to do custom installation
                    # t is the .install*.done file. install variable is the same file!
                    t = self.install( install, [b] )

                    self._depend[p].append(t)
                    self.installAll.append(t)

                    # self.env.Depends( t, aliasDownload )

                    # self.env.Depends( aliasInstall, aliasDownload )
                    self.env.Depends( finish_command, t )

                    aliasPkg     = self.env.Alias( self.name, t )
                    aliasInstall = self.env.Alias( 'all', t )
                    # if 'field3d' in self.name and 'phase' not in str(t):
                    #     print '\n'.join([str(x[0])  for x in source])
                    #     Exception("BUM")
                    #     print '--------> %s' % (self.name), t
                    #     z=[ str(x) for x in source ]
                    #     z.sort()
                    #     print '\n'.join(z)
                    #     for download_version in self.download_versions:
                    #         z = [ str(x.name)+":"+str(self.dependOn[download_version][x].version)+" "+str(x.targetSuffix) for x in self.dependOn[download_version].keys() ]
                    #         z.sort()
                    #         print download_version,'\n\t'.join(z)
                    #
                    #     print [ x.name+' '+x.targetSuffix for x in allDepend ]

                    # we always have to call 'scons install' so the target
                    # paths are full abspath!
                    # (without install they are not abspath!)
                    # So we have to set install to nothing here, or else
                    # we can't build individual packages.
                    self.env.Alias( 'install', [] )

        # ==========================================================================
        # add itself as a global dependency for all subsequent builds!
        # We MUST do this at the end, so it won't influence itself
        # ==========================================================================
        if kargs.has_key('globalDependency'):
            if kargs['globalDependency']:
                self.globalDependency = str(kargs['globalDependency'])
                globalDependency( self,
                    RPATH   ='NORPATH'   not in self.globalDependency,
                    LIB     ='NOLIB'     not in self.globalDependency,
                    INCLUDE ='NOINCLUDE' not in self.globalDependency,
                )

    # def __repr__(self):
    #     return { x:str(self[x]) for x in self.keys() }

    def __contains__(self,key):
        ''' check if a dependency pkg with name key exists '''
        if type(key) in [str]:
            if [ x for x in self.keys() if x.name == key ]:
                return True
        else:
            return key in self.keys()
        return False

    def keys(self):
        ''' return the versions of this build package obj '''
        return pipe.versionSort(self.download_versions.keys())

    def __getitem__(self, version):
        ''' retrieve the dependency dictionary for the given version '''
        return self.dependOn[version]


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
        global buildCounter

        # if 'install' in  str(what):
        #     print bcolors.WARNING+": "+bcolors.BLUE+what+bcolors.END
        #
        sys.stdout.write('\033[2K\033[1G')
        if 'builder' in  str(what):
            if not self.shouldBuild( target, source, env ):
                return
            t=str(target[0])
            extra = []
            if self.targetSuffix:
                extra = ['-',self.targetSuffix]
            n=' '.join(t.split(os.path.sep)[-3:-1]+extra)
            if '.python' in t:
                n = "%s (py %s)" % (n, t.split('.python')[-1].split('.done')[0])
            _print( bcolors.WARNING+':'+'='*tcols )

            _elapsed = time.gmtime(time.time()-buildStartTime)
            _print( bcolors.WARNING+": %s[% 3d%%] [%02d:%02d:%02d] %s %s( %s ) " % (
                bcolors.GREEN,
                int((float(buildCounter)/float(buildTotal))*100.0),
                _elapsed.tm_hour, _elapsed.tm_min, _elapsed.tm_sec,
                bcolors.BLUE,
                self.className,
                n
            ) )
            _print( bcolors.WARNING+": " )
            # print '===================>',  [ '.'.join(os.path.dirname(str(x)).split('/')[-2:]) for x in source ]
            # d = [ '.'.join(str(x).split(os.path.sep)[-3:-1]) for x in source[1:] ]
            d = env.get( "ENVIRON_DEPEND_VERSION" ).strip().split(' ')
            _print( bcolors.WARNING+": "+bcolors.BLUE+"   depend: %s" % str(source[0]) )
            d=list(set(d))
            d.sort()
            for n in range(0,len(d),6):
                _print( bcolors.WARNING+": "+bcolors.BLUE+"           %s" % ', '.join(d[n:n+6]) )
            _print( bcolors.WARNING+": "+bcolors.END )
        else:
            sp="/-\|"
            _print( bcolors.WARNING,"%s: %s[% 3d%%] %s[%s] %s processing:" % (
                bcolors.BS,
                bcolors.GREEN,
                int((float(buildCounter)/float(buildTotal))*100.0),
                bcolors.BLUE,
                sp[_spinnerCount],
                bcolors.WARNING,
            ),'[',str(what).split('(')[0],'] [',str(target[0]),']','\r', )
            _spinnerCount += 1
            if _spinnerCount >= len(sp):
                _spinnerCount = 0


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
        # a counter to display a percentage
        global buildTotal
        buildTotal += 1
        return self.registerSconsBuilder(self.builder)( target, source )

    def fixCMD(self, cmd):
        ''' virtual method to fix cmd lines before execution, like adding --prefix to configure '''
        return cmd

    def __lastlog(self, target, pythonVersion=None):
        # if no pythonVersion specified, see if we can figure it out from target
        target = os.path.abspath(str(target)).replace('pipeline/build', 'pipeline/libs')
        if not pythonVersion:
            pythonVersion = "1.0"
            if len(str(target).split('.python')) > 1:
                pythonVersion = str(target).split('.python')[-1].split('.done')[0][:3]

        lastlogFile = "%s/%s.%s" % (os.path.dirname(str(target)), crtl_file_lastlog, pythonVersion)
        if self.targetSuffix.strip():
            lastlogFile = '%s-%s' % (lastlogFile, self.targetSuffix)

        # print lastlogFile
        return os.path.abspath( lastlogFile )


    def shouldBuild(self, target, source, env, cmd=None):
        lastlogFile = self.__lastlog(target[0])
        lastlog = self.__check_target_log__( lastlogFile, env, stage='pre-build' )
        # _print( '=====>',target[0], lastlogFile)

        if lastlog==0:
            os.popen( "touch %s" % str(target[0]) ).readlines()

        return lastlog

    def builder(self, target, source, env):
        ''' the generic builder method, used by all classes
        it simple executes all commands specified by self.cmd list '''

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

        didBuild = False
        if cmdz:
            didBuild = self.runCMD(' && '.join(cmdz), target, source, env)

        # here we check if the last build was finished suscessfully
        if not didBuild:
            return

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



    def depend_n(self,dependOn, target, dependencyList=None, baseLib=None, debug=False):
        ''' support function to find the same version of a depency
        # look in the dependency download list if we have
        # the same version number as the current package.
        # if so, use that targetFolder!
        # works for cases like openexr and ilmbase which are
        # released with the same version!
        # also, for packages who need an specific version of a dependency to build, sets it here!
        '''
        # target can be version or target path...
        # (called when constructing nodes to build)
        currVersion = target
        runtime = False

        # in case it's a target path, we figure out the version from it.
        # (called at runtime!!)
        if len(target.split('/'))>2:
            # we have to use the same gcc version as the current python build used.
            currVersion = target.split('/')[-2]
            runtime = True

        # by default, use the latest version of the download list!
        depend_n = -1
        if debug:
            print '\t',target, dependOn.name, self.dependOn[currVersion][ dependOn ]
        if dependOn.name in ['gcc', 'python'] and not dependOn.targetSuffix:
            # or the oldest if it's gcc or python
            depend_n = 0

        # in case it's a target path, we figure out the version from it.
        # (called at runtime!!)
        if runtime:
            # we determine here if the build is using baseLib python or not!
            if '.python' in os.path.basename(target):
                # adjust env vars for the current selected python version
                if len(target.split('.python')) > 1:
                    pythonVersion = target.split('.python')[-1].split('.done')[0]

                    # we have to use the same gcc version as the current python build used.
                    # if 'gcc' in dependOn.name  and not dependOn.targetSuffix:
                    #     for python in [ x for x in self.dependOn[currVersion] if 'python' in x.name ]:
                    #         # find the gcc version used for the current python version
                    #         for gcc_version in [ x for x in python.downloadList if x[2] ==  pythonVersion ]:
                    #             # and set it
                    #             # print  currVersion,dependOn.name,currVersion, pythonVersion, gcc_version[4]
                    #             self.dependOn[currVersion][ dependOn ] = gcc_version[4][ dependOn ]

                    # we set the python version to the same as the baseLib we're building to!
                    if 'python' in dependOn.name:
                        self.dependOn[currVersion][ dependOn ] = pythonVersion
                        self._os_environ_(target)['PYTHON_VERSION'] = pythonVersion

                # if we're not building using baseLib
                else:
                    self.dependOn[currVersion][ dependOn ] = dependOn.downloadList[depend_n][2]
                    if 'python' in dependOn.name:
                        self._os_environ_(target)['PYTHON_VERSION'] = dependOn.downloadList[depend_n][2]



        dependOnVersion = self.dependOn[currVersion][dependOn] # reminder: string version
        dependOnOverride = dependOn # reminder: package obj
        # grab dependency version override from download list, if any!
        for download in self.downloadVersion(currVersion):
            if len(download)>4: # 5th element is a dependency list with version
                override = [ x for x in download[4].keys() if hasattr(x, 'name') and dependOn.name == x.name ]
                if override:
                    dependOnOverride = override[0]
                    dependOnVersion = download[4][override[0]]


        # find the index of the dependency download version in the
        # dependency download list, and return it!
        if dependOnVersion:
            for each in range(len(dependOn.downloadList)):
                if dependOn.downloadList[each][2] == dependOnVersion:
                    # we have the version specified in the download
                    # print "download version",dependOn.name,self.dependOn[dependOn], currVersion, dependOnVersion
                    depend_n = each
                    break

        # return the index of the download list that matches the required
        # version of the dependency (depend_n)
        # and the dependency obj (dependOnOverride)!
        return depend_n, dependOnOverride

    def __check_target_log__(self,target, env, install=None, stage='pre-build'):
        ret=0
        msg="__check_target_log__(%s): " % '/'.join(target.split('/')[-3:])
        if os.path.exists(target):
            lines = ''.join( [ x for x in open(target).readlines() if '@runCMD_ERROR@ $?' not in x ] )
            # check if ld failed
            if len(lines) < 35:
                if 'pre-build' in stage:
                    _print( msg, 'last build log is empty!' )
                ret =  999
            elif [ x for x in lines.split('\n') if 'ld returned 1' in x or 'ld: cannot find ' in x ]:
                if 'pre-build' in stage:
                    _print( msg, [ x for x in lines.split('\n') if 'ld returned 1' in x or 'ld: cannot find ' in x ] )
                ret = 100
            # check if we have a make error message
            elif [ x for x in lines.split('\n') if 'make:' in x and 'Error' in x and 'ignored' not in x ]:
                if 'pre-build' in stage:
                    _print( msg, [ x for x in lines.split('\n') if 'make:' in x and 'Error' in x and 'ignored' not in x ] )
                ret = 101
            elif 'Configuring incomplete, errors occurred' in lines:
                if 'pre-build' in stage:
                    _print( msg+"last build failled during cmake!" )
                ret = 253
            elif "@runCMD_ERROR@" not in lines:
                if 'pre-build' in stage:
                    _print( msg+"the build didn't finish suscessfully - rebuilding..." )
                ret = 254
            elif "@runCMD_ERROR@" in lines:
                code = lines.split("@runCMD_ERROR@")[1].strip()
                code = int(code)
                if code and 'pre-build' in stage:
                    _print( msg+"last build finished with error code: %d"  % code )
                ret = code

        else:
            # double check if the dependency list changed!!
            if '-' in os.path.basename(target):
                tmp = glob(os.path.dirname(target)+'/.??*'+os.path.basename(target).split('-')[-1]+'*depend')
            else:
                tmp = glob(os.path.dirname(target)+'/.??*'+os.path.basename(target).split('.')[-1]+'*depend')

            if tmp:
                build_depend_list = tmp[0]
                print str(build_depend_list), env.get('ENVIRON_DEPEND_VERSION').split(' ')
                if os.path.exists(build_depend_list):
                    build_depend_list_content = [ x.strip() for x in open(build_depend_list ,'w').readlines() if x.strip() ]
                    for each in env.get('ENVIRON_DEPEND_VERSION').split(' '):
                        if each and 'pip' not in each:
                            each = each.split('.')
                            each = each[0]+'/'+'.'.join(each[1:])
                            if each not in build_depend_list_content:
                                _print( msg, "dependency changed for %s" % os.path.basename(target) )
                                ret = 102
            else:
                # _print( msg+" log %s doesn't exist!"  % target )
                ret = 255

        return ret

    def _os_environ_(self, target, value=None):
        t = str(target[0])
        if value != None:
            self._os_environ[ t ] = value
        if t not in self._os_environ:
            self._os_environ[ t ] = {}
        return self._os_environ[ t ]

    def runCMD(self, cmd , target_original, source, env):
        ''' the main method to run system calls, like configure, make, cmake, etc  '''

        target = str(target_original[0])


        # for each in  source:
        #     print str(each)
        global buildCounter, _spinnerCount

        buildCompiler = int(filter(lambda x: 'BUILD_COMPILER' in x[0], env.items())[0][1])

        # restore original environment before ruuning anything.
        os_environ = {}
        os_environ.update( self._os_environ_(target_original) )

        # first, cleanup pipe gcc/bin folder from path, if any
        os_environ['PYTHON_TARGET_FOLDER'] = os.environ['PYTHON_TARGET_FOLDER']
        os_environ['PYTHONPATH'] = os.environ['PYTHONPATH']
        os_environ['PATH'] = os.environ['PATH']
        os_environ['PATH'] = os_environ['PATH'].replace(pipe.build.gcc(),'').replace('::',':')

        os_environ['CORES']  = os.environ['CORES']
        os_environ['DCORES'] = os.environ['DCORES']
        os_environ['HCORES'] = os.environ['HCORES']
        for key,value in self.env.items():
            if 'CORES' in key:
                os_environ[key.replace('ENVIRON_','')] = value

        pkgVersion = os.path.basename(os.path.dirname(target))
        pkgName    = os.path.basename(os.path.dirname(os.path.dirname(target)))
        installDir = os.path.abspath(os.path.dirname(target))
        os_environ['VERSION'] = pkgVersion
        os_environ['VERSION_MAJOR'] = ''.join([ c for c in '.'.join(pkgVersion.split('.')[:2]) if c.isdigit() or c=='.'])
        os_environ['%s_VERSION' % self.name.upper()] = os_environ['VERSION']
        os_environ['%s_VERSION_MAJOR' % self.name.upper()] = os_environ['VERSION_MAJOR']


        # set a python version if none is set
        pythonVersion = '1.0.0' if pkgName != 'python' else pkgVersion


        # set the python version needed (baseLib build!)
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

            # fix pythonN.N folders if we have a PYTHON_VERSION_MAJOR env var
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

        # set Python version env vars.
        os_environ['PYTHON_VERSION'] = pythonVersion
        os_environ['PYTHON_VERSION_MAJOR'] = pythonVersion[:3]
        pipe.apps.version.set(python=pythonVersion)

        # set target folder and python folder for the current pkg
        target_folder = self.env['TARGET_FOLDER_%s' % pkgVersion.replace('.','_')]
        # site_packages = '/'.join([
        #     target_folder,
        #     'lib/python%s/site-packages' % pythonVersion[:3]
        # ])
        # os_environ['PYTHONPATH'] = ':'.join( [
        #     site_packages,
        #     os_environ['PYTHONPATH'] ,
        # ])


        prefix = ''
        os_environ.update( {
            'CLICOLOR_FORCE'    : '1',
            'CC'                : '%sgcc' % prefix,
            'CPP'               : 'cpp',
            'CXX'               : '%sg++' % prefix,
            'CXXCPP'            : 'cpp',
            # 'LD'                : 'ld',
            'LD'                : '%sg++' % prefix,
            'LDSHARED'          : '%sg++ -shared' % prefix,
            'LDFLAGS'           : ' ',
            'CFLAGS'            : ' ',
            # 'CXXFLAGS'          : ' -D_GLIBCXX_USE_CXX11_ABI=0 -w ',
            'CXXFLAGS'          : ' ',
            'PKG_CONFIG_PATH'   : '',
            'LD_LIBRARY_PATH'   : "%s/lib/" % (installDir),
            # source: https://gcc.gnu.org/onlinedocs/gcc-4.1.2/gcc/Environment-Variables.html#Environment-Variables
            # The value of LIBRARY_PATH is a colon-separated list of directories,
            # much like PATH. When configured as a native compiler, GCC tries the
            # directories thus specified when searching for special linker files,
            # if it can't find them using GCC_EXEC_PREFIX. Linking using GCC also
            # uses these directories when searching for ordinary libraries for
            # the -l option (but directories specified with -L come first).
            # LIBRARY_PATH DOES NOT WORK IF LD IS CALLED DIRECTLY, NOT BY GCC/G++
            # in this cases, we have to specify -L<lib path> in LDFLAGS, or force
            # a build to use g++ by setting LD=g++
            'LIBRARY_PATH'      : "",
            # Each variable's value is a list of directories separated by a special
            # character, much like PATH, in which to look for header files.
            # The special character, PATH_SEPARATOR (:), is target-dependent and
            # determined at GCC build time.
            # CPATH specifies a list of directories to be searched as if specified
            # with -I, but after any paths given with -I options on the command
            # line. This environment variable is used regardless of which
            # language is being preprocessed.
            # ( CPATH searchpath AFTER -I paths!!)
            'CPATH'             : "",
            # The remaining environment variables apply only when preprocessing
            # the particular language indicated. Each specifies a list of
            # directories to be searched as if specified with -isystem,
            # but after any paths given with -isystem options on the command line.
            # ( *_INCLUDE_PATH searchpath BEFORE -I paths and after -isystem!!)
            'C_INCLUDE_PATH'    : "",
            'CPLUS_INCLUDE_PATH': "",
            'OBJC_INCLUDE_PATH' : "",
            # In all these variables, an empty element instructs the compiler to
            # search its current working directory. Empty elements can appear at
            # the beginning or end of a path. For instance, if the value of
            # CPATH is :/special/include, that has the same
            # effect as '-I. -I/special/include'.

            # conclusion:
            #    -isystem   == *_INCLUDE_PATH
            #    -I         == CPATH
        })

        if not os_environ.has_key('INCLUDE'):
            os_environ['INCLUDE'] = ''

        C_INCLUDE_PATH=[]
        CPLUS_INCLUDE_PATH=[]
        LIBRARY_PATH=[]
        LD_LIBRARY_PATH=[]
        PKG_CONFIG_PATH=[]
        PYTHONPATH=[]
        PATH=[]
        RPATH=[]
        CFLAGS=[]
        LDFLAGS=[]
        gcc={
            'gcc' : 'gcc',
            'g++' : 'g++',
            'c++' : 'c++',
            'cpp' : 'cpp',
        }

        RPATH          += rpath_environ  ( "$%s_TARGET_FOLDER/lib/"     % self.name.upper() )['RPATH'].split(':')
        C_INCLUDE_PATH += include_environ( '$%s_TARGET_FOLDER/include/' % self.name.upper() )['CPATH'].split(':')


        dependList={}
        sourceList = map(lambda x: os.path.basename(os.path.dirname(os.path.dirname(str(x)))), source)

        for dependOn in self.dependOn[pkgVersion]:
            # reminder: keys of self.dependOn[pkgVersion] are package objects!
            if dependOn and dependOn.name not in dependList and  dependOn.do_not_use==False:
                # if not in the source list, skip it
                if dependOn.name not in target and dependOn.name not in self.env['ENVIRON_DEPEND'].split(' '):
                    continue

                # specific rule to ignore pre-built gcc 4.1.2 binaries as dependency, since we add
                # it down in this code in case no GCC is present as dependency.
                if dependOn.name=='gcc'  and dependOn.targetSuffix=='pre':
                    continue

                # grab the index for the version needed
                debug=0
                # if 'oiio' in target:
                #     print pkgVersion.replace('.','_')
                #     debug=1
                depend_n, dependOnOverride = self.depend_n(dependOn, target, debug=debug)

                # override dependOn with the one set in downloads
                dependOn = dependOnOverride

                # deal with python dependency
                # the noBaseLib key holds all the paths for the python versions being built
                if 'python' in dependOn.name:
                    # grab the target folder for the python version we're building to!
                    tmp = filter(lambda x: pythonVersion in os.path.basename(x), dependOn.targetFolder['noBaseLib'])
                    # if we have a python target folder for the requested version, use it!
                    if tmp:
                        dependOn.targetFolder[os.path.basename(tmp[0])] = [tmp[0]]
                        os_environ['PYTHON_ROOT'] = tmp[0]

                k = dependOn.targetFolder.keys()
                p = pythonVersion

                # print dependOn.name, k
                if k:
                    p = filter(lambda x: p in x, k)
                    if p:
                        p = p[0]
                    else:
                        k.sort()
                        if dependOn.name in ['gcc','python'] and not dependOn.targetSuffix:
                            p = k[0]
                        else:
                            p = k[-1]

                    if len(dependOn.targetFolder[p])==1:
                        depend_n = 0
                    dependList[dependOn.name] = dependOn.targetFolder[p][depend_n]

                    os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()] = os.path.abspath(dependOn.targetFolder[p][depend_n])
                    # os_environ['%s_VERSION' % dependOn.name.upper()] = os.path.basename(dependOn.targetFolder[p][depend_n])
                    os_environ['%s_VERSION' % dependOn.name.upper()] = os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()].strip('/').split('/')[-1]
                    os_environ['%s_ROOT' % dependOn.name.upper()] = os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()]

                    if os_environ['VERSION'] not in DB[self.name]:
                        DB[self.name][os_environ['VERSION']] = {}
                    DB[self.name][os_environ['VERSION']][dependOn.name] = os_environ['%s_VERSION' % dependOn.name.upper()]

                    if not dependOn.dontUseTargetSuffixForFolders:
                        # if 'pyilmbase' == dependOn.name:
                        #     if 'alembic' == self.name:
                        #         print(dependOn, dependOn.targetSuffix)
                        if dependOn.targetSuffix:
                            os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()] = '/'.join([
                                os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()].rstrip('/'),
                                dependOn.targetSuffix
                            ])

                    if p in dependOn.buildFolder:
                        os_environ['%s_SRC_FOLDER' % dependOn.name.upper()   ] = os.path.abspath(dependOn.buildFolder[p][depend_n])
                    else:
                        os_environ['%s_SRC_FOLDER' % dependOn.name.upper()   ] = os.path.abspath(dependOn.buildFolder['noBaseLib'][depend_n])

                    PKG_CONFIG_PATH += [
                        '%s/lib64/pkgconfig/:' % os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()] ,
                        '%s/lib/pkgconfig/:' % os_environ['%s_TARGET_FOLDER' % dependOn.name.upper()] ,
                    ]

                    # include dependency search path in LIBRARY_PATH, so we don't
                    # have to populate LDFLAGS with a bunch of -L<dep path>
                    # this also has the advantage of not "recording" the build search paths
                    # on build packages, so cmake won't pick the up later!
                    LIBRARY_PATH += [
                        "$%s_TARGET_FOLDER/lib/"                               % dependOn.name.upper(),
                        "$%s_TARGET_FOLDER/lib64/"                             % dependOn.name.upper(),
                        "$%s_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/"   % dependOn.name.upper(),
                        "$%s_TARGET_FOLDER/lib64/python$PYTHON_VERSION_MAJOR/" % dependOn.name.upper(),
                        '$%s_TARGET_FOLDER/lib64/python$PYTHON_VERSION_MAJOR/lib-dynload/'     %  dependOn.name.upper(),
                    ]

                    _rpath = rpath_environ( "$%s_TARGET_FOLDER/lib/" % dependOn.name.upper() )
                    RPATH += _rpath['RPATH'].split(':')
                    LDFLAGS += _rpath['LDFLAGS'].split(' ')
                    # RPATH += [
                    #     "$%s_TARGET_FOLDER/lib/"                               % dependOn.name.upper(),
                    #     "$%s_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/"   % dependOn.name.upper(),
                    #     '$%s_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/lib-dynload/'     %  dependOn.name.upper(),
                    # ]

                    # include dependency search path in *_INCLUDE_PATH, so we don't
                    # have to populate C*FLAGS with a bunch of -I<dep path>
                    # this also has the advantage of not "recording" the build search paths
                    # on build packages, so cmake won't pick the up later!
                    # USD picks up -I<paths> from python, for example, and if we have gcc paths
                    # from the gcc version used to build python, those will interfere with
                    # the gcc version used with USD.
                    C_INCLUDE_PATH += ["$%s_TARGET_FOLDER/include/" %  dependOn.name.upper()]
                    C_INCLUDE_PATH += include_environ( '$%s_TARGET_FOLDER/include/' % dependOn.name.upper() )['CPATH'].split(':')

                    # add extra folders inside dependency include folders
                    for each in glob("%s/include/*" % dependOn.targetFolder[p][depend_n]):
                        if os.path.isdir(each):
                            if dependOn.name == 'tbb' and 'serial' in each:
                                continue
                            C_INCLUDE_PATH += ["%s" % each]

                    # set python searchpath for dependencies
                    PYTHONPATH += [
                        "$%s_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/"                   %  dependOn.name.upper(),
                        "$%s_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/"     %  dependOn.name.upper(),
                        '$%s_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/lib-dynload/'       %  dependOn.name.upper(),
                        "$%s_TARGET_FOLDER/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/"                   %  dependOn.name.upper(),
                        "$%s_TARGET_FOLDER/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages/"     %  dependOn.name.upper(),
                        '$%s_TARGET_FOLDER/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/lib-dynload/'       %  dependOn.name.upper(),
                    ]

                    # set PATH searchpath for dependencies binaries
                    PATH += [
                        # "%s/bin/" % (dependOn.targetFolder[p][depend_n]),
                        # "%s/lib/" % (dependOn.targetFolder[p][depend_n]),
                        "$%s_TARGET_FOLDER/bin/" % (dependOn.name.upper()),
                        "$%s_TARGET_FOLDER/lib/" % (dependOn.name.upper()),
                    ]

                    # pull env vars from dependency classes
                    # we add all searchpaths from dependencies as well.
                    # for each in dependOn.environ:
                    #     sep = ' '
                    #     if dependOn.environ[each] and type(dependOn.environ[each])==str:
                    #         if dependOn.environ[each][0] == '/':
                    #             sep = ':'
                    #
                    #         cleanV = ' '
                    #         for v in dependOn.environ[each].split(' '):
                    #             if v.strip()  and v[0] != '$':
                    #                 cleanV += v+' '
                    #
                    #         # print dependOn.name, each, cleanV, sep
                    #         if each in os_environ:
                    #             os_environ[each] = sep.join([
                    #                 os_environ[each],
                    #                 cleanV
                    #             ])
                    #         else:
                    #             os_environ[each] = cleanV





        # here we check if the last build was finished suscessfully
        __shouldBuild__ =  self.shouldBuild( target_original, source, env )
        if not __shouldBuild__:
            return False

        # fix PYTHON_VERSION_MAJOR based on PYTHON_VERSION
        # from dependent classes
        if 'PYTHON_VERSION' in os_environ:
            os_environ['PYTHON_VERSION_MAJOR'] = '.'.join(os_environ['PYTHON_VERSION'].split('.')[:2])
            os_environ['PYTHON_TARGET_FOLDER'] = '/'.join([ os.path.dirname(os_environ['PYTHON_TARGET_FOLDER']), os_environ['PYTHON_VERSION'] ])
            if '/python/' not in target:
                os_environ['PYTHON_ROOT'] = os_environ['PYTHON_TARGET_FOLDER']
            PATH += [ "%s/bin/" % os_environ['PYTHON_TARGET_FOLDER'] ]

        # set lastlog filename
        extraLabel = ''
        lastlog = self.__lastlog( target, '1.0' )
        if 'GCC_VERSION' in os_environ:
            extraLabel = '(gcc %s)' % os_environ['GCC_VERSION']
        if 'noBaseLib' not in target:
            extraLabel = '(python %s)' % ( os_environ['PYTHON_VERSION'] )
            if 'GCC_VERSION' in os_environ:
                extraLabel = '(gcc %s / python %s)' % (  os_environ['GCC_VERSION'], os_environ['PYTHON_VERSION'] )
            lastlog = self.__lastlog( target,  os_environ['PYTHON_VERSION_MAJOR'] )

        # set TARGET_FOLDER and INSTALL_FOLDER
        os_environ['TARGET_FOLDER'] = self.env['TARGET_FOLDER_%s' % pkgVersion.replace('.','_')]
        os_environ['SOURCE_FOLDER'] = os.path.abspath(os.path.dirname(str(source[0])))
        os_environ['INSTALL_FOLDER'] = os_environ['TARGET_FOLDER']
        if not self.dontUseTargetSuffixForFolders:
            if self.targetSuffix.strip() and len(self.targetSuffix.split('.'))>1:
                os_environ['INSTALL_FOLDER'] = '/'.join([ os_environ['TARGET_FOLDER'], self.targetSuffix ]).replace('//','/')

        # create current package bin/libs folders so paths are not
        # removed from env vars
        folders = ['bin', 'lib', 'lib64']
        _p = '.'.join( os.path.basename(lastlog).split('-')[0].split('.')[-2:] )
        if float(_p) > 1.0:
            folders += ['lib/python%s/site-packages' % _p]

        for n in folders:
            path = '%s/%s' % (os_environ['INSTALL_FOLDER'], n )
            os.system( 'mkdir -p "%s"' % path )

        # PATH         = ['$INSTALL_FOLDER/bin'] + PATH
        # LIBRARY_PATH = [
        #     '$INSTALL_FOLDER/lib',
        #     '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR',
        #     '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/lib',
        #     '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/lib-dynload',
        # ] + LIBRARY_PATH
        # PYTHONPATH   = [
        #     '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR',
        #     '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages',
        #     '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/lib-dynload',
        # ] + PYTHONPATH

        # make sure all paths from the dependency loop exist and remove duplicates
        # print PYTHONPATH
        # C_INCLUDE_PATH  = [ p for p in set(C_INCLUDE_PATH)  if '$' in p or os.path.exists(p) ]
        # LIBRARY_PATH    = [ p for p in set(LIBRARY_PATH)    if '$' in p or os.path.exists(p) ]
        # PKG_CONFIG_PATH = [ p for p in set(PKG_CONFIG_PATH) if '$' in p or os.path.exists(p) ]
        # PYTHONPATH      = [ p for p in set(PYTHONPATH)      if '$' in p or os.path.exists(p) ]
        # PATH            = [ p for p in set(PATH)            if '$' in p or os.path.exists(p) ]
        # print PYTHONPATH

        # transfer all lists to env vars now
        os_environ['CPATH']     = ':'.join(C_INCLUDE_PATH+[os_environ['CPATH']])
        os_environ['RPATH']     = ':'.join(RPATH)
        os_environ['LDFLAGS']   = ' '.join(LDFLAGS)
        # os_environ['C_INCLUDE_PATH']     = ':'.join(C_INCLUDE_PATH+[os_environ['C_INCLUDE_PATH']])
        # os_environ['CPLUS_INCLUDE_PATH'] = os_environ['C_INCLUDE_PATH']
        os_environ['INCLUDE']            = os_environ['CPATH']
        os_environ['LIBRARY_PATH']       = ':'.join(LIBRARY_PATH+[os_environ['LIBRARY_PATH']])
        os_environ['LD_LIBRARY_PATH']    = os_environ['LIBRARY_PATH']
        os_environ['PKG_CONFIG_PATH']    = ':'.join(PKG_CONFIG_PATH+[os_environ['PKG_CONFIG_PATH']])
        os_environ['PYTHONPATH']         = ':'.join(PYTHONPATH+[os_environ['PYTHONPATH']])
        os_environ['PATH']               = ':'.join(PATH+[os_environ['PATH']])

        if self.travis:
            os_environ['TRAVIS']    = '1'

        # fix pythonN.N folders after getting python version
        # env vars from dependency.
        for var in os_environ:
            pp = []
            if ':' in os_environ[var]:
                for each in os_environ[var].split(':'):
                    if  'PYTHON_VERSION' not in each:
                        if 'PYTHON_VERSION' in os_environ and '/python/' in each:
                            each = each.replace(each.split('/python/')[1].split('/')[0], '$PYTHON_VERSION')
                        if 'PYTHON_VERSION_MAJOR' in os_environ:
                            each = re.sub('/python.../', '/python$PYTHON_VERSION_MAJOR/', each)
                    pp.append(each)
                os_environ[var] = ':'.join(pp)

        # use dependency gcc, if any!
        os_environ['CC']  = "%s %s" % (gcc['gcc'], os_environ['CC'].replace(':',"").replace('gcc',''))
        os_environ['CXX'] = "%s %s" % (gcc['g++'], os_environ['CXX'].replace(':',"").replace('g++',''))

        # update LIB and LIBRARY_PATH
        os_environ['LIB'] = os_environ['LD_LIBRARY_PATH']
        os_environ['LIBRARY_PATH'] = ':'.join([
            os_environ['LIBRARY_PATH'],
            '/usr/lib/x86_64-linux-gnu/',
        ])

        # reset lastlog
        open(lastlog,'w').close()
        if hasattr(self, 'preSED'):
            self.preSED(pkgVersion, lastlog, os_environ)

        # run sed inline patch mechanism
        self.runSED(os_environ['SOURCE_FOLDER'])

        # set os_environ in self so overridable funtions can pick it up and change,
        # since dicts in python behave like pointers!
        self._os_environ_(target_original, value = os_environ )
        # if the build has apps setup, add their env vars to the build
        self.setApps(target_original)

        # run customizable fixCMD() which is used to fix the command line
        cmd = self.fixCMD(cmd, os_environ)

        # apply patches, if any!
        if hasattr(self, 'patch'):
            if self.patch:
                cmd = ' && '.join([ self.__patches(self.patch), cmd ])

        cmd = cmd.replace('"','\"') #.replace('$','\$')
        _print( bcolors.WARNING+':'+bcolors.BLUE+'\tCORES: '+bcolors.WARNING+os_environ['CORES'], \
                 bcolors.BLUE+', DCORES: '+bcolors.WARNING+os_environ['DCORES'], \
                 bcolors.BLUE+', HCORES: '+bcolors.WARNING+os_environ['HCORES'] )
        _print( bcolors.WARNING+':' )
        _print( bcolors.WARNING+':\ttarget : %s%s' % (bcolors.GREEN, target) )
        _print( bcolors.WARNING+":\tinstall: %s%s" % (bcolors.GREEN, os_environ['INSTALL_FOLDER']) )

        for l in cmd.split('&&'):
            _print( bcolors.WARNING+':\t%s%s : %s %s  %s ' % ( \
                     '.'.join(os_environ['TARGET_FOLDER'].split('/')[-2:]), \
                     extraLabel,bcolors.GREEN,l.strip(),bcolors.END) \
            )
        # we need to save the current pythonpath to set it later inside pythons system call
        os_environ['BUILD_PYTHONPATH__'] = os_environ['PYTHONPATH']
        # and then we need to setup a clean PYTHONPATH so ppython can find pipe, build and the correct modules
        #    os_environ['PYTHONPATH'] = pythonpath_original

        showLog = ' > '
        if DEBUG():
            showLog = ' | tee -a '
        pipeFile = ' 2>&1 \
            | LD_PRELOAD="" LD_LIBRARY_PATH="/root/source-highlight/libs/" source-highlight -f esc -s errors \
            | tee -a  %s %s %s.err ' % (lastlog, showLog, lastlog)
        # cmd = cmd.replace( '&&', ' %s && ' % pipeFile )

        # go to build folder before anything!!
        cmd  =  '( cd \"%s\" && ' %  os_environ['SOURCE_FOLDER'] + cmd
        cmd +=  ' ; echo "@runCMD_ERROR@ $? @runCMD_ERROR@" '

        # and pipe all to the log file
        cmd +=  ') %s' % pipeFile

        # set internet proxies, if needed
        proxies = { x[0]:x[1] for x in env.items() if '_PROXY' in x[0] }
        for each in proxies:
            os_environ[each.lower()] = proxies[each].strip()

        # default to our gcc tarball in case we have none!!
        # we should avoid using the system gcc at all times!!
        if 'GCC_TARGET_FOLDER' not in os_environ and '4.1.2' not in os_environ['INSTALL_FOLDER']:
            os_environ['GCC_VERSION'] = '4.1.2'
            os_environ['GCC_TARGET_FOLDER'] = '%s/gcc/4.1.2/' % os.path.dirname(os.path.dirname(os_environ['INSTALL_FOLDER']))

        # only add gcc search paths if not building GCC.
        if 'GCC_TARGET_FOLDER' in os_environ:
            # we set LD_LIBRARY_PATH to always use the latest GCC shared libraries.
            # since GCC shared libraries are backward compatible, we have to use the latest
            # to avoid "version `GLIBCXX_' not found" like errors
            # here we set LATESTGCC_* env vars to use for that purpose...
            versions = pipe.versionSort( [
                os.path.basename(x.replace('/bin/gcc','')) for x in glob('%s/../*/bin/gcc' % os_environ['GCC_TARGET_FOLDER'])
            ] )
            os_environ['LATESTGCC_VERSION'] = versions[0]
            os_environ['LATESTGCC_TARGET_FOLDER'] = '%s/%s' % (
                os.path.dirname(os_environ['GCC_TARGET_FOLDER']),
                os_environ['LATESTGCC_VERSION']
            )

            # here we set the latest GCC runtime searchpath , no matter what gcc version we use to build.
            os_environ['LD_LIBRARY_PATH'] = ':'.join([
                '$LATESTGCC_TARGET_FOLDER/lib64',
                '$LATESTGCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$LATESTGCC_VERSION/',
                '$LATESTGCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/',
                os_environ['LD_LIBRARY_PATH']
            ]+glob('%s/lib/gcc/x86_64-pc-linux-gnu/*' % os_environ['LATESTGCC_TARGET_FOLDER']))

            # but we set the correct build GCC in the PATH searchpath.
            os_environ['PATH'] = ':'.join([
                '$GCC_TARGET_FOLDER/bin',
                os_environ['PATH'],
            ])

            # we link gcc using -L instead of -rpath, since we need to set the latest
            # gcc shared libraries at runtime!
            os_environ['LDFLAGS']      = ' '.join([
                '-L%s/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'  % os_environ['GCC_TARGET_FOLDER'],
                '-L%s/lib/gcc/x86_64-pc-linux-gnu/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                '-L%s/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                # '-Wl,-rpath=%s/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'  % os_environ['GCC_TARGET_FOLDER'],
                # '-Wl,-rpath=%s/lib/gcc/x86_64-pc-linux-gnu/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                # '-Wl,-rpath=%s/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                os_environ['LDFLAGS']
            ])
            os_environ['LLDFLAGS']      = ' '.join([
                '-L%s/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'  % os_environ['GCC_TARGET_FOLDER'],
                '-L%s/lib/gcc/x86_64-pc-linux-gnu/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                '-L%s/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                # '-Wl,-rpath=%s/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'  % os_environ['GCC_TARGET_FOLDER'],
                # '-Wl,-rpath=%s/lib/gcc/x86_64-pc-linux-gnu/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                # '-Wl,-rpath=%s/lib64/'  % os_environ['GCC_TARGET_FOLDER'],
                os_environ['LDFLAGS']
            ])

            # we need to set this so compilation finds the includes from our GCC, instead of the system ones!
            os_environ['C_INCLUDE_PATH'] = ':'.join([
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/',
                os_environ['C_INCLUDE_PATH'],
            ])
            os_environ['CPLUS_INCLUDE_PATH'] = ':'.join([
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/',
                '$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/x86_64-pc-linux-gnu/',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/x86_64-pc-linux-gnu/',
                '$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/',
                '$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/backward',
                os_environ['CPLUS_INCLUDE_PATH'],
                # '$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/tr1',
                # '$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/tr2',
            ])
            os_environ['CPATH'] = ':'.join([
                '$GCC_TARGET_FOLDER/include',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/',
                '$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++',
                os_environ['CPATH']
            ])

            # set gcc exec env vars
            os_environ['CC']  = "$GCC_TARGET_FOLDER/bin/%s" % (os_environ['CC'].strip())
            os_environ['CXX'] = "$GCC_TARGET_FOLDER/bin/%s" % (os_environ['CXX'].strip())
            if 'LD' in os_environ and 'g++' in os.path.basename(os_environ['LD'].split(' ')[0]):
                os_environ['LD'] = "$GCC_TARGET_FOLDER/bin/%s" % (os_environ['LD'].strip())


        # we need LLVM search path before anything else, since
        # there are name clash of headers between LLVM and GCC
        if 'LLVM_TARGET_FOLDER' in os_environ and not hasattr(self, 'dontAddLLVMtoEnviron'):
            os_environ['PATH'] = ':'.join([
                '%s/bin/' % os_environ['LLVM_TARGET_FOLDER'],
                os_environ['PATH'],
            ])
            os_environ['LIBRARY_PATH'] = ':'.join([
                '%s/lib/' % os_environ['LLVM_TARGET_FOLDER'],
                os_environ['LIBRARY_PATH'],
            ])
            # for LLVM, we use -rpath instead of -L so the search path
            # gets backed into the compiled file.
            os_environ['LDFLAGS']      = ' '.join([
                '-Wl,-rpath=%s/lib/' % os_environ['LLVM_TARGET_FOLDER'],
                os_environ['LDFLAGS'],
            ])
            os_environ['LLDFLAGS']      = ' '.join([
                '-Wl,-rpath=%s/lib/' % os_environ['LLVM_TARGET_FOLDER'],
                os_environ['LDFLAGS'],
            ])

            # we need to set this so compilation finds the includes from our GCC, instead of the system ones!
            os_environ['C_INCLUDE_PATH'] = ':'.join([
                '$LLVM_TARGET_FOLDER/include/',
                '$LLVM_TARGET_FOLDER/include/clang',
                '$LLVM_TARGET_FOLDER/include/clang-c',
                '$LLVM_TARGET_FOLDER/include/llvm',
                '$LLVM_TARGET_FOLDER/include/llvm-c',
                '$LLVM_TARGET_FOLDER/lib/clang/$LLVM_VERSION/include',
                # '$LLVM_TARGET_FOLDER/lib/clang/$LLVM_VERSION/include/cuda_wrappers/',
                os_environ['C_INCLUDE_PATH'],
            ])
            os_environ['CPLUS_INCLUDE_PATH'] = ':'.join([
                '$LLVM_TARGET_FOLDER/include/',
                '$LLVM_TARGET_FOLDER/include/clang',
                '$LLVM_TARGET_FOLDER/include/clang-c',
                '$LLVM_TARGET_FOLDER/include/llvm',
                '$LLVM_TARGET_FOLDER/include/llvm-c',
                '$LLVM_TARGET_FOLDER/lib/clang/$LLVM_VERSION/include',
                # '$LLVM_TARGET_FOLDER/lib/clang/$LLVM_VERSION/include/cuda_wrappers/',
                os_environ['CPLUS_INCLUDE_PATH'],
            ])

        # add  options last, so we can add includes before and after the bunch
        # https://gcc.gnu.org/onlinedocs/gcc-4.1.2/cpp/Invocation.html#Invocation
        # -nostdinc     Do not search the standard system directories for header
        # files. Only the directories you have specified with -I options (and
        # the directory of the current file, if appropriate) are searched.
        # -nostdinc++   Do not search for header files in the C++-specific standard
        # directories, but do still search the other standard directories. (This
        # option is used when building the C++ library.)
        # -isystem dir  Search dir for header files, after all directories
        # specified by -I but before the standard system directories.
        # Mark it as a system directory, so that it gets the same special
        # treatment as is applied to the standard system directories. See System Headers.
        os_environ['CFLAGS']   = ' -O2 -fPIC -w -nostdinc  -Wno-error ' + os_environ['CFLAGS']
        os_environ['CXXFLAGS'] = ' -O2 -fPIC -w -nostdinc -nostdinc++ -Wno-error ' + os_environ['CXXFLAGS']
        os_environ['LDFLAGS']  = ' -fPIC ' + os_environ['LDFLAGS']

        if 'GCC_VERSION' in os_environ and versionMajor(os_environ['GCC_VERSION'])>=6.3:
            os_environ['CFLAGS']   = ' -D_GLIBCXX_USE_CXX11_ABI=0 ' + os_environ['CFLAGS']
            os_environ['CXXFLAGS'] = ' -D_GLIBCXX_USE_CXX11_ABI=0 ' + os_environ['CXXFLAGS']

        # since we're using -nostdinc, we have to setup the system folders by hand
        system_includes = [
            '/usr/include',
            '/usr/include/linux/',
            '/usr/share/systemtap/runtime/',
            '/usr/lib64/glib-2.0/include/',
            '/usr/include/glib-2.0/',

            # ========================================================================
            # we can't have cuda in the generic search path since it overrides
            # some of GCC headers. We have to trust whatever package who needs it,
            # will have to find it by itself!!
            # ========================================================================
            # '/usr/local/cuda-10.2/targets/x86_64-linux/include/cuda/std/detail/libcxx/include/',
            # '/usr/local/cuda-10.2/targets/x86_64-linux/include/',
            # '/usr/local/cuda-10.2/extras/Sanitizer/include/',
            # '/usr/local/cuda-10.2/extras/CUPTI/samples/extensions/include/',
            # '/usr/local/cuda-10.2/src/',
            # '/usr/local/cuda-10.2/samples/common/inc/',
        ]

        os_environ['C_INCLUDE_PATH']     = ':'.join([ os_environ['C_INCLUDE_PATH']     ]+system_includes)
        os_environ['CPLUS_INCLUDE_PATH'] = ':'.join([ os_environ['CPLUS_INCLUDE_PATH'] ]+system_includes)
        os_environ['CPATH']              = ':'.join([ os_environ['CPATH']              ]+system_includes)

        # add -iquote so build can find #include <header> in the correct places
        # iquotes = ' -iquote' + ' -iquote'.join( os_environ['CPATH'].split(':') )
        # os_environ['CFLAGS']   += ' ' + iquotes
        # os_environ['CXXFLAGS'] += ' ' + iquotes

        # just make CPPFLAGS/CPPCXXFLAGS the same as CXXFLAGS
        os_environ['CPPFLAGS'] = os_environ['CFLAGS']
        os_environ['CPPCXXFLAGS'] = os_environ['CXXFLAGS']

        # cleanup empty search paths ('::' and ':' at the beginning and end)
        for each in [ 'CPLUS_INCLUDE_PATH', 'C_INCLUDE_PATH', 'LIBRARY_PATH', 'LD_LIBRARY_PATH', 'PYTHONPATH', 'PATH', 'RPATH', 'CPATH' ]:
            if each in os_environ:
                os_environ[each] = os_environ[each].strip(':').replace('::',':')

        # this helps configure to find the corret python
        if '/python/' not in target:
            os_environ['PYTHON'] = '$PYTHON_TARGET_FOLDER/bin/python'
            os_environ['PYTHONHOME'] = '$PYTHON_TARGET_FOLDER'
        else:
            os_environ['PYTHONPATH'] = '$SOURCE_FOLDER/Lib/:'+os_environ['PYTHONPATH']+':'
            os_environ['PYTHONHOME'] = '$SOURCE_FOLDER'
            # we do LD_PRELOAD in the command line to prevent error messages on the build            os_environ['LD_LIBRARY_PATH'] = '$SOURCE_FOLDER/:'+os_environ['LD_LIBRARY_PATH']+':'

        # cortex rely on finding the libraries on the current folder.
        if '/gcc/' not in target:
            os_environ['LD_LIBRARY_PATH'] = '$SOURCE_FOLDER/:'+os_environ['LD_LIBRARY_PATH']+':.'
            os_environ['LIBRARY_PATH'] = '$SOURCE_FOLDER/:'+os_environ['LIBRARY_PATH']+':.'


        # set extra env vars that were passed to the builder class in the environ parameter!
        # this must come last but before expandvars so we can modify the env vars after they are all set!
        for name,v in filter(lambda x: 'ENVIRON_' in x[0], self.env.items()):
            _env = name.split('ENVIRON_')[-1]
            if _env not in os_environ:
                os_environ[_env]=''

            # expand variables em v using os_environ
            v = expandvars( v, env=os_environ )

            # and now replace the variable in os_environ
            # this way, one can add to the env var by assigning
            # itself + the extra data. ex: LDFLAGS="$LDFLAGS -lGL"
            # or can just replace the one created so far.
            os_environ[_env] = v.strip(':').strip(' ')

        # expand variables in os_environ
        for each in os_environ:
            os_environ[each] = expandvars(os_environ[each], env=os_environ)
            if each == 'LDFLAGS':
                os_environ[each] = os_environ[each].replace("$LDFLAGS", "")

        # add system includes for last
        os_environ['LIBRARY_PATH'] = ':'.join([
            os_environ['LIBRARY_PATH'],
            '/usr/lib',
            '/usr/lib64',
            '/lib',
            '/lib64',
        ])

        # after expanding all env var,
        # add LIBRARY_PATH to LD, if it's 'ld',
        # since 'ld' does not use LIBRARY_PATH
        LD = os.path.basename(os_environ['LD'].split(' ')[0])
        if 'ENVIRON_LD' in self.env:
            LD = self.env['ENVIRON_LD']
        # if 'ld' in LD:
        #     for each in set(os_environ['LIBRARY_PATH'].split(':')):
        #         if os.path.exists(each) and glob( '%s/*' % each ):
        #             os_environ['LDFLAGS'] += ' -L%s' % os.path.abspath(each)


        # cleanup paths that don't exist from the searchpath env vars!
        # checkPathsExist( os_environ )


        # set LD_RUN_PATH to be the same as LIBRARY_PATH
        # LD_RUN_PATH should do the same as specifying -Wl,-rpath,<path> for
        # each library path in the command line. Need testing though!
        if '/gcc/' not in target:
            os_environ['LD_RUN_PATH'] = os_environ['LIBRARY_PATH']
            # os_environ['LD_LIBRARY_PATH'] = os_environ['LIBRARY_PATH']
            os_environ['LTDL_LIBRARY_PATH'] = os_environ['LIBRARY_PATH']
            os_environ['LTLD_LIBRARY_PATH'] = os_environ['LIBRARY_PATH']
        os_environ['TERM'] = 'xterm-256color'

        # run the build!!
        from subprocess import Popen
        _start = time.time()

        # prevent glibc from being in LD_LIBRARY_PATH!!
        os_environ['LD_LIBRARY_PATH'] = ':'.join([x for x in os_environ['LD_LIBRARY_PATH'].split(':') if 'glibc' not in x])

        os_environ = removeDuplicatedEntriesEnvVars(os_environ)

        proc = Popen(cmd, bufsize=-1, shell=True, executable='/bin/sh', env=os_environ, close_fds=True)

        # keep giving feedback about the build.
        while proc.poll() is None:
            tail = os.popen('tail -n 100 %s | LD_PRELOAD="" LD_LIBRARY_PATH="/root/source-highlight/libs/" source-highlight -f esc -s errors | grep -v "LD_PRELOAD cannot be preloaded" | tail -n 1' % lastlog).readlines()
            if not tail:
                tail=['']
            _elapsed = time.gmtime(time.time()-_start)
            sys.stdout.write('\033[2K\033[1G')
            sp="/-\|"
            msg = bcolors.WARNING+"%s: building: %s[%s] [%s.%s]%s elapsed:%s %02d:%02d:%02d %slogtail:%s %s" % (
                bcolors.BS,
                bcolors.BLUE,
                sp[_spinnerCount],
                pkgName,
                pkgVersion,
                bcolors.WARNING,
                bcolors.BLUE,
                _elapsed.tm_hour,
                _elapsed.tm_min,
                _elapsed.tm_sec,
                bcolors.WARNING,
                bcolors.END,
                tail[0].strip()
            )
            _print( msg[:tcols-2], '\r', )
            _spinnerCount += 1
            if _spinnerCount >= len(sp):
                _spinnerCount = 0

            sys.stdout.flush()
            time.sleep(1)
        sys.stdout.write('\033[2K\033[1G')

        ret = self.__check_target_log__(lastlog, env)
        _elapsed = time.gmtime(time.time()-_start)
        _print( bcolors.WARNING+':\ttotal build time: %s %02d:%02d:%02d' % (
            bcolors.GREEN,
            _elapsed.tm_hour,
            _elapsed.tm_min,
            _elapsed.tm_sec
        ))

        if _elapsed.tm_sec < 5 and _elapsed.tm_min+_elapsed.tm_hour==0:
            if not hasattr(self, 'noMinTime') or not self.noMinTime:
                ret=666

        f = open(lastlog,'a')
        f.write("\n\n"+cmd+"\n\n")
        f.close()

        # finished without errors!!
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

        # error during build!!
        else:
            _print(  '-'*tcols )
            if not DEBUG():
                os.system( 'cat %s.err | LD_PRELOAD="" LD_LIBRARY_PATH="/root/source-highlight/libs/" source-highlight -f esc -s errors' % lastlog )
            #for each in open("%s.err" % lastlog).readlines() :
            #    print '::\t%s' % each.strip()
            _print( ret )
            #print '-'*tcols
            #pprint(os_environ)
            _print( '-'*tcols )
            _print( bcolors.FAIL,
                     traceback.format_exc(), #.print_exc()
            bcolors.END )
            _print( cmd )
            _print( '-'*tcols )
            _print( self.travis, self.__class__ )
            if ret==666:
                msg =  bcolors.FAIL+"\n\nERROR - BUILD WAS TOO FAST (%d secs)!!!! IF THIS IS CORRECT, SET noMinTime=True WHEN CREATING THE BUILD CLASS OBJECT!!%s\n\n" % (_elapsed.tm_sec,bcolors.END)
                _print( msg )
                f = open( lastlog, 'a' )
                f.write( msg )
                f.close()
            sys.stdout.flush()
            if not self.travis and not sconsParallel:
                os.chdir(os_environ['SOURCE_FOLDER'])
                proc=Popen("/bin/sh", bufsize=-1, shell=True, executable='/bin/sh', env=os_environ, close_fds=True)
                proc.wait()
            raise Exception(bcolors.FAIL+':: Error [%d] during build of package %s.%s - check log file: %s' % (ret, pkgName, pkgVersion, lastlog) )

        # cleanup so we have space to build.
        keep_source = filter(lambda x: 'KEEP_SOURCE_FOLDER' in x[0], env.items())
        if keep_source and keep_source[0][1].strip() != '1':
            os.system('rm -rf "%s"' % os_environ['SOURCE_FOLDER'])

        self.installer(target, source, os_environ)

        _print( bcolors.END, )

        return True


    def installer(self, target, source, os_environ): # noqa
        ''' virtual method may be implemented by derivated classes in case installation needs to be done by copying or moving files.
        this method is called after the build (not at install), since we want to provide the os_environ env var to run shell commands
        in the same environment as the build'''
        pass

    def setAppsInit(self):
        '''
        sets the version of the app as set in the apps parameter.
        also fix the build dependency versions according to the
        version defined in the app class for that dependency.
        for now, only sets the python version.
        '''
        if hasattr(self, 'apps') and self.apps:
            for (app, version) in self.apps:
                # we extract the class name with this ugly code, just
                # so we don't execute the app class before setting the version
                className = str(app).split('.')[-1].split("'")[0]
                # now set the version of the apps
                pipe.version.set( {className : version} )
                # create the app class
                _app = app()
                # expand the environment from the app, setting all the correct
                # versions of everything, so version.get() can retrieve it!
                _app.fullEnvironment()

                # fix dependency version to the app default version!
                for lib in ['python']:
                    # if the dependency is python, and this is a
                    # build for multiple python versions, skip it
                    if lib=='python' and 'noBaseLib' not in self.baseLibs:
                        continue

                    # set the version of the dependency, if it exists as a
                    # dependency in this build
                    dependency_class = [ d for d in self.depend if d.name==lib ]
                    if dependency_class:
                        for each in self.download:
                            # item 5 of the download set is the dependency dict
                            # so we either modify or add the depency version here
                            each[4][dependency_class[0]] = pipe.libs.version.get(lib)

    def setApps(self, target):
        '''
        update the build environment with all the enviroment variables
        specified in apps argument!
        '''
        if hasattr(self, 'apps') and self.apps:
            pipe.version.set(python=self._os_environ_(target) ['PYTHON_VERSION'])
            pipe.versionLib.set(python=self._os_environ_(target) ['PYTHON_VERSION'])
            for (app, version) in self.apps:
                className = str(app).split('.')[-1].split("'")[0]
                pipe.version.set({className:version})
                _app = app()
                _app.fullEnvironment()
                _print( bcolors.WARNING+":"+bcolors.BLUE+"\tapp: ", "%s(%s)" % (
                    className,
                    version
                ),)
                # get all vars from app class and add to cmd environ
                for each in _app:
                    if each not in ['LD_PRELOAD','PYTHON_VERSION','PYTHON_VERSION_MAJOR']:
                        v = _app[each]
                        if type(v) == str:
                            v=[v]
                        if each not in self._os_environ_(target) :
                            self._os_environ_(target) [each] = ''
                        # if var value is paths
                        if 'ROOT' in each:
                            self._os_environ_(target) [each] = v[0]
                        elif '/' in str(v):
                            self._os_environ_(target) [each] = "%s:%s" % (self._os_environ_(target) [each], ':'.join(v))
                        else:
                            self._os_environ_(target) [each] = ' '.join(v)

            # remove python paths that are not the same version, just in case!
            # for each in self._os_environ_(target) :
            #     if '/' in str(v):
            #         cleanSearchPath = []
            #         for path in self._os_environ_(target) [each].split(':'):
            #             if not path.strip():
            #                 continue
            #             if '/python' in path and self._os_environ_(target) ['PYTHON_TARGET_FOLDER'] not in path:
            #                 pathVersion1 = path.split('/python/')[-1].split('/')[0].strip()
            #                 pathVersion2 = path.split('/python')[-1].split('/')[0].strip()
            #                 # print each, pathVersion1+'='+pathVersion2, path, self._os_environ_(target) ['PYTHON_VERSION_MAJOR'], path.split('/python/')[-1].split('/')[0] != self._os_environ_(target) ['PYTHON_VERSION_MAJOR'], path.split('/python')[-1].split('/')[0] != self._os_environ_(target) ['PYTHON_VERSION_MAJOR']
            #                 if pathVersion1:
            #                     if pathVersion1 != self._os_environ_(target) ['PYTHON_VERSION']:
            #                         continue
            #                 if pathVersion2:
            #                     if pathVersion2 != self._os_environ_(target) ['PYTHON_VERSION_MAJOR']:
            #                         continue
            #             cleanSearchPath.append(path)
            #         self._os_environ_(target) [each] = ':'.join(cleanSearchPath)

        # self._os_environ_(target) ['LD_PRELOAD'] = ''.join(os.popen("ldconfig -p | grep libstdc++.so.6 | grep x86-64 | cut -d'>' -f2").readlines()).strip()
        # self._os_environ_(target) ['LD_PRELOAD'] += ':'+''.join(os.popen("ldconfig -p | grep libgcc_s.so.1 | grep x86-64 | cut -d'>' -f2").readlines()).strip()
        #self._os_environ_(target) ['LD_LIBRARY_PATH'] = '/usr/lib/:%s' % self._os_environ_(target) ['LD_LIBRARY_PATH']

    def setInstaller(self, method):
        self.installer = method

    def _installer(self, target, source, env):
        ''' a wrapper class to create target in case installer method is suscessfull!
        we do this so whoever implements a installer don't have to bother!'''
        global buildCounter
        buildCounter += 1

        from glob import glob

        ret = None
        # ret = self.installer( target, source, env )
        f=open(str(target[0]),'w')
        if ret:
            f.write(''.join(ret))
        else:
            f.write(' ')
        f.close()
        self._installer_final_check(target, source, env, ret)

    def _installer_final_check(self, target, source, env={}, ret=None):
        ''' check if something was installed
        this garantees things get installed!'''
        if self.github_matrix:
            return

        _TARGET = str(target[0])
        TARGET_FOLDER = os.path.dirname(_TARGET)
        _TARGET_SUFIX = ''
        if '-' in _TARGET:
            # _TARGET_SUFIX = '-'+_TARGET.split('-')[1].split('.')[0]+'*'
            _TARGET_SUFIX = '-'+'-'.join( os.path.splitext(_TARGET)[0].split('-')[1:] )+'*'
        if not self.dontUseTargetSuffixForFolders:
            if self.targetSuffix.strip() and len(self.targetSuffix.split('.'))>1:
                # TARGET_FOLDER becomes INSTALL_FOLDER here, if necessary
                TARGET_FOLDER = '/'.join([ TARGET_FOLDER, self.targetSuffix ]).replace('//','/').rstrip('/')

        # if not hasattr(self, 'apps'):
        if not os.path.exists(_TARGET) or (not glob( '%s/*/*' % TARGET_FOLDER ) and not hasattr(self,'no_folder_install_checking')):
                # if we have a log, show it!
                if ret:
                    _print( bcolors.WARNING, '='*80, bcolors.FAIL )
                    _print( [ str(x) for x in target ], [ str(x) for x in source ] )
                    _print( ''.join(ret) )
                    _print( bcolors.WARNING, '='*80, bcolors.END )

                cmd = []
                if not os.path.exists(_TARGET):
                    cmd += [":: not os.path.exists(%s): %s" % ( _TARGET, str(not os.path.exists(_TARGET)) )]
                    cmd += ["rm -rf %s" % _TARGET]
                    cmd += ["rm -rf %s/.lastlog.?.?%s" % (os.path.dirname(_TARGET), _TARGET_SUFIX)]
                    cmd += ["rm -rf %s/.lastlog.?.?%s.err" % (os.path.dirname(_TARGET), _TARGET_SUFIX)]

                # if nothing was installed, cleanup source so we can rebuild it!
                # if we don't cleanup sources, the build gets stuck!
                path_exist = False
                for each in [ str(x) for x in source ]:
                    if os.path.exists(os.path.dirname(each)):
                        path_exist = True
                        cmd += [":: os.path.exists(%s): %s" % ( os.path.dirname(each), str(os.path.exists(os.path.dirname(each))) )]
                        # cmd += ["rm -rf %s/* 2>/dev/null" % os.path.dirname(each)]
                        cmd += ["rm -rf %s" % _TARGET]
                        cmd += ["rm -rf %s/.lastlog.?.?%s" % (os.path.dirname(_TARGET), _TARGET_SUFIX)]
                        cmd += ["rm -rf %s/.lastlog.?.?%s.err" % (os.path.dirname(_TARGET), _TARGET_SUFIX)]

                # if not glob('%s/*/*' % TARGET_FOLDER):
                #     cmd += [":: not glob( '%s/*/*' ): %s" % ( TARGET_FOLDER, str(not glob('%s/*/*' % TARGET_FOLDER)) )]
                #     # cmd += ["rm -rf %s/* 2>/dev/null" % os.path.dirname(each)]
                #     cmd += ["rm -rf %s/*" % TARGET_FOLDER]
                #     cmd += ["rm -rf %s/.lastlog.?.?%s" % (os.path.dirname(_TARGET), _TARGET_SUFIX)]
                #     cmd += ["rm -rf %s/.lastlog.?.?%s.err" % (os.path.dirname(_TARGET), _TARGET_SUFIX)]

                cmd = list(set(cmd))
                if cmd and path_exist:
                    _print(     ":: _installer_final_check: error! (%s)" % _TARGET )
                    for c in cmd:
                        if c[0] == ':':
                            _print( c )
                        else:
                            _print( "::                       "+c )
                            os.system(c)

                if ret:
                    # if we have a log, raise an exception, since it was called from a
                    # real installation builder.
                    raise Exception("ERROR - nothing was installed at %s/*/*" % TARGET_FOLDER)
                else:
                    # if no log, just return since it was called live
                    return False

        # if something is installed,
        # make sure lib and lib64 have the same contents
        for each in glob( '%s/lib/*' % TARGET_FOLDER ):
            if not os.path.exists( '%s/lib64/%s' % (TARGET_FOLDER, os.path.basename(each)) ):
                os.system( 'ln -s ../lib/%s  %s/lib64/ >/dev/null 2>&1' % (os.path.basename(each), TARGET_FOLDER) )

        for each in glob( '%s/lib64/*' % TARGET_FOLDER ):
            if not os.path.exists( '%s/lib/%s' % (TARGET_FOLDER, os.path.basename(each)) ):
                os.system( 'ln -s ../lib64/%s  %s/lib/ >/dev/null 2>&1' % (os.path.basename(each), TARGET_FOLDER) )

        # remove build folder now that everything is done!
        for each in [ str(x) for x in source if '.build/' in str(x) ]:
            if os.path.exists(os.path.dirname(each)):
                cmd = "rm -rf %s 2>/dev/null" % os.path.dirname(each)
                # if ret:
                # _print( ":: _installer_final_check: done - ",cmd, each )
                os.system(cmd)

        return True



    def md5(self, fileName):
        import hashlib
        value="nao exist!!" # hashlib.md5('').hexdigest()
        if os.path.exists(str(fileName)):
            if not os.stat(str(fileName)).st_size == 0:
                value = hashlib.md5(open(str(fileName)).read()).hexdigest()

        return value
#        return ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % str(file)).readlines()).strip()

    def downloader( self, env, _source, _url=None):
        ''' this method is a builder responsible to download the packages to be build '''
        global __pkgInstalled__
        self.error = None
        source = [_source]
        for n in range(len(source)):
            # print __pkgInstalled__[os.path.abspath(source[n])]
            download_path=os.path.dirname(source[n])+'/../.download/'
            download_file=os.path.dirname(source[n])+'/../.download/'+os.path.basename(source[n])
            os.system('mkdir -p "%s"' % download_path)
            os.system('rm -rf "%s" 2>/dev/null ' % (source[n]) )
            os.system('ln -s "../.download/%s" "%s"' % (os.path.basename(source[n]), source[n] ) )
            if not os.path.exists(__pkgInstalled__[os.path.abspath(source[n])]):
                url=_url
                if not url:
                    downloadList = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)
                    url = downloadList[0]
                md5 = self.md5(source[n])
                if md5 != url[3] and not ( '.git' in os.path.splitext(url[0])[-1] and ( os.path.exists(source[n]) and os.stat(source[n]).st_size > 10 ) ):
                    count = 5
                    while count>0:
                        count -= 1
                        _print( bcolors.GREEN, "\tDownloading %s..." % download_file )
                        _print( bcolors.END, )
                        if '.git' in os.path.splitext(url[0])[-1]:
                            # clone a git depot and zip it
                            # we specify a tag as version
                            # TODO: implement logic to use a commit hash as version!
                            cmd= '''( \
                                git clone --recursive --depth=1 --branch %s '%s' %s && \
                                CD=$(pwd) && \
                                pwd && \
                                cd %s && \
                                    git checkout --detach %s && \
                                    ( find . -name '.git' | while read p ; do rm -rf $p ; done ) && \
                                cd .. && \
                                zip -r %s %s &&\
                                cd $CD ) >%s.log 2>&1
                            ''' % (
                                url[2], # version / commit number as this is a git download
                                url[0], # git url
                                os.path.splitext(download_file)[0], # git folder
                                os.path.splitext(download_file)[0], # git folder
                                url[2], # version / commit number as this is a git download
                                os.path.basename(download_file),
                                os.path.splitext(os.path.basename(download_file))[0],
                                source[n],
                            )
                        else:
                            _download_cmd = "wget --no-check-certificate --timeout=15 '$url' -O $save >$log.log 2>&1"
                            cmd = _download_cmd.replace('$url', url[0]).replace('$save', download_file).replace('$log', source[n])

                        lines = os.popen(cmd).readlines()
                        # _print( bcolors.FAIL )
                        # _print(cmd)
                        # _print(''.join(lines))
                        # os.system('cat %s.log' % source[n])
                        # _print( bcolors.END )

                        if os.path.exists(download_file) and os.stat(download_file).st_size > 0:
                            break

                        # os.system('ls -lhrt %s' % download_file)
                        # os.system('hexdump -C %s | less' % download_file)

                    if not os.path.exists(download_file) or os.stat(download_file).st_size == 0:
                        raise Exception ("error downloading %s" % download_file)
                    if url[3] and not '.git' in os.path.splitext(url[0])[-1]:
                        md5 = self.md5(download_file)
                        if md5 != url[3]:
                            sys.stdout.write( bcolors.WARNING )
                            _print( "\tmd5 for file:", url[1], md5 )
                            sys.stdout.write( bcolors.FAIL )
                            sys.stdout.flush()
                            self.error = True
                        else:
                            _print( "\tmd5 matches for file:", url[1], md5, "=", url[3] )

            else:
                if not os.path.exists(download_file):
                    open(download_file, 'a').close()

        return _source

    def _uncompressor( self, target, source, env):
        if not self.github_matrix:
            self.uncompressor( target, source, env )

    def uncompressor( self, target, source, env):
        ''' this method is a builder responsible to uncompress the packages to be build '''
        global __pkgInstalled__
        ret=None
        if self.error:
            raise Exception("\tDownload failed! MD5 check didn't match the one described in the Sconstruct file"+bcolors.END)

        if not self.shouldBuild( target, source, env ):
            return

        for n in range(len(source)):
            url = filter(lambda x: os.path.basename(str(source[n])) in x[1], self.downloadList)[0]
            # print source[n]
            s = os.path.abspath(str(source[n]))
            t = os.path.abspath(str(target[n]))
            if not url[3] or self.md5(source[n]) == url[3]:
                import random
                tmp = int(random.random()*10000000)
                tmp = "%s/tmp.%s" % (os.path.dirname(os.path.dirname(str(target[n]))), str(tmp))
                # print "\tMD5 OK for file ", source[n],
                # print  "rm -rf %s 2>&1" % os.path.dirname(t)
                # print self.__lastlog(__pkgInstalled__[s]), s, t
                python = '1.0'
                if '.python' in t:
                    python = '.'.join( t.split('.python')[-1].split('.')[:2] )

                # if not os.path.exists(self.__lastlog(__pkgInstalled__[s],python)):
                lastlog = self.__lastlog(__pkgInstalled__[s],python)
                # print self.__check_target_log__( lastlog, env ), str(target[0]), str(source[0])
                if self.__check_target_log__( lastlog, env ):
                    # _print( "\n:: uncompressing... ", os.path.basename(s), '->', os.path.dirname(t).split('.build')[-1], lastlog )
                    os.popen( "rm -rf %s 2>&1" % os.path.dirname(t) ).readlines()
                    cmd = "mkdir -p %s && cd %s && tar xf %s 2>&1" % (tmp,tmp,s)
                    uncompressed_folder = self.fix_uncompressed_path( os.path.basename(s.replace('.tar.gz','').replace('.zip','')) )
                    if '.zip' in s:
                        cmd = "mkdir -p %s && cd %s && unzip %s 2>&1" % (tmp,tmp,s)
                        _print( cmd )
                    elif '.rpm' in s:
                        ss = os.path.basename( os.path.dirname( str(target[n]) ) )
                        ss = uncompressed_folder
                        cmd = "mkdir -p %s/%s && cd %s/%s && rm -rf  %s.rpm && ln -s %s %s.rpm && rpm2cpio %s.rpm | cpio -idmv  2>&1 && cd .. " % (tmp, ss, tmp, ss, s, s, s, s)
                        _print( cmd )


                    cmd +=  " ; mv %s %s && cd ../../ && rm -rf %s 2>&1" % (uncompressed_folder, os.path.dirname(t), tmp)
                    lines = os.popen( cmd ).readlines()
                    if not os.path.exists(str(target[n])):
                        _print( '-'*tcols )
                        for l in lines:
                            _print( '\t%s' % l.strip() )
                        _print( str(target[n]) )
                        _print( cmd )
                        _print( uncompressed_folder )
                        _print( '-'*tcols )
                        _print( "str(target[n])",str(target[n]) )
                        if not self.travis and not sconsParallel:
                            os.system('/bin/bash')
                        raise Exception("Uncompress failed!")

                    for updates in ['config.sub', 'config.guess']:
                        for file2update in os.popen('find %s -name %s 2>&1' % (os.path.dirname(t), updates) ).readlines():
                            os.popen( "cp %s/../.download/%s %s"   % (os.path.dirname(s), updates, file2update) )

                    ret = True
                else:
                    # os.mkdir(os.path.dirname(s))
                    # f=open(s, 'w')
                    # f.write(' ')
                    # f.close()
                    if not os.path.exists(os.path.dirname(t)):
                        os.mkdirs(os.path.dirname(t))
                        open(t, 'a').close()
        return ret

    def fix_uncompressed_path(self, path):
        if self.kargs.has_key('uncompressed_path'):
            path = os.path.basename(path)
            k = [ x for x in self.kargs['uncompressed_path'].keys() if path in x ]
            if len(k)==1:
                return self.kargs['uncompressed_path'][k[0]]
            else:
                if len(k)==0:
                    _print( "\n\nCouldn't find the uncompressed folder name from the list: %s\n\n" % str(self.kargs['uncompressed_path']) )
                else:
                    _print( "\n\nMore than one match for path %s: %s\n\n" % (path, str(k)) )

        # if hasattr(self, 'targetSuffix'):
        #     path = os.path.join(path, self.targetSuffix)
        return path



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
        if self.do_not_use:
            return
        url = filter(lambda x: tmp in x[1], self.downloadList)[0]
        for version in ids:
            v  = map(lambda x: int(x), version.split('.')[:3])
            vv = map(lambda x: int(''.join(filter(lambda z: z.isdigit(),x))), url[2].split('.')[:3])
            if len(vv)> 2:
                if vv[0]>=v[0] and vv[1]>=v[1] and vv[2]>=v[2]:
                    for each in self.sed[version]:
                        f = "%s/%s" % (t,each)

                        # sed a file if it exists!
                        if os.path.exists("%s" % f):
                            _print( bcolors.WARNING+":"+bcolors.BLUE+"\t'sed' patching %s %s... %s" % (bcolors.WARNING, f, bcolors.END) )

                            # we make a copy of the original file, before running sed
                            # if we already have a copy, we restore it before running sed
                            if os.path.exists("%s.original" % f):
                                os.popen("cp %s.original %s" % (f,f)).readlines()
                            else:
                                os.popen("cp %s %s.original" % (f,f)).readlines()
                            # apply seds
                            for sed in self.sed[version][each]:
                                cmd = '''sed -i.bak %s -e "s/%s/%s/g" 2>&1 ; echo $?''' % (
                                    f,
                                    sed[0].replace('/','\/').replace('$','\$').replace('\n','\\n').replace('#','\#').replace('"','\\"'),
                                    sed[1].replace('/','\/').replace('$','\$').replace('\n','\\n').replace('\\"','\\\\\\\\\"').replace('"','\\"').replace('&','\\&')
                                )
                                lines = os.popen(cmd).readlines()
                                # _print(cmd+'\n'+'\n'.join(lines))

                        # if it doesnt exist, create it!!
                        else:
                            ptr = open(f, 'w')
                            for sed in self.sed[version][each]:
                                ptr.write(sed[1])
                            ptr.close()

                    break

        # patch all -O3 to -O2 everywhere in the source, since -O3 can create
        # CPU specific code!
        if not [ x for x in ['/gcc', '/4.1.2'] if x in t ]:
            _print(  bcolors.WARNING+":"+bcolors.BLUE+"\tpatching %s %s for generic cpu... %s" % (bcolors.WARNING, '/'.join(t.split('/')[-2:]), bcolors.END) )
            files2patch = {}
            result = os.popen(''' grep -R  '\-O3' %s/* 2>&1 ''' % t).readlines()
            # print result
            for each in result:
                if 'binary file' not in each.lower():
                    f = each.split(':')[0]
                    if f not in files2patch:
                        files2patch[ f ] = []
                    files2patch[ f ] += [each]

            for file in files2patch:
                os.popen('''sed -i.bak -e 's/\-O3/-O2/g' -e 's/\-O4/-O2/g' -e 's/\-O5/-O2/g' %s ''' % file).readlines()
            # print os.popen(''' grep -R  '\-O3' %s/* ''' % t).readlines()

        # wee need certain aclocal-* versions in case we modify configure base files.
        # so just symlink the needed versions here.
        links = {
            '/usr/bin/aclocal' : '/usr/bin/aclocal-1.15',
            '/usr/bin/automake': '/usr/bin/automake-1.15'
        }
        for each in links:
            if not os.path.exists(links[each]):
                os.system( 'ln -s "%s" "%s" 2>/dev/null' % (each, links[each]) )

    def install(self, target, source):
        ret = source
        if self.installer:
            bld = Builder(action = Action( self._installer, self.sconsPrint) )
            self.env.Append(BUILDERS = {'installer' : bld})
            ret = self.env.installer( target, ret)
        return ret

    def _download(self,target):
        ret = target
        if self.downloader and not self.github_matrix:
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

    def downloadVersion(self, v, compare = '=='):
        ''' return the download array with just download packages for
        the specified version.
        if v is a string, it will return just one version matching the exact version in the strings.
        if v is float, it will return all versions matching the versionMajor specified in the float.
        compare is the logical operation to do between versionMajor and v. ex '==','>','<=', etc
        '''
        # print type(v), v, self.download
        _download=[]
        if type(v)==type(""):
            _download = [ x for x in self.download if x[2] == v ]
        elif type(v)==type(float):
            _download = [ x for x in self.download if eval('versionMajor(x[2]) %s v' % compare) ]
        else:
            raise exception("Error returning the download (%s) for the version specied - %s" % (self.name,v))
        return []+_download



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
