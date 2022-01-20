
from glob import glob
from pprint import pprint
import os,sys, pipe

import pipe, build, genericBuilders

# try to get an env var, if not exists return value
def get(var, value):
    import os
    if os.environ.has_key(var):
        return os.environ[var]
    return value


# import cortex options
sys.path.insert( 0, os.path.abspath( os.path.dirname(build.__file__) ) )
from cortex_options import *

pushPrint()

BUILD_TYPE="RELEASE"

# os.environ['LD_LIBRARY_PATH'] = '$GCC_TARGET_FOLDER/lib/'
# ENV_VARS_TO_IMPORT="LD_LIBRARY_PATH"


cortex = os.environ['CORTEX_VERSION']
qt     = os.environ['QT_VERSION']
#pyqt   = os.environ['PYQT_VERSION']
pyside = os.environ['PYSIDE_VERSION']
oiio   = os.environ['OIIO_VERSION']
ocio   = os.environ['OCIO_VERSION']
# llvm   = os.environ['LLVM_VERSION']
osl    = os.environ['OSL_VERSION']
boost  = os.environ['BOOST_VERSION']

import build
if build.versionMajor(os.path.basename(os.environ['GCC_ROOT'])) > 4.2:
    CXXSTD = "c++11"
if build.versionMajor(os.path.basename(os.environ['GCC_ROOT'])) > 6.0:
    CXXSTD = "c++14"

# INSTALL_DIR = os.environ['TARGET_FOLDER']
BUILD_DIR='/tmp/build/gaffer-${GAFFER_MAJOR_VERSION}.${GAFFER_MINOR_VERSION}.${GAFFER_PATCH_VERSION}-${GAFFER_PLATFORM}-python'+'.'.join(python.split('.')[:2])
BUILD_DIR=os.environ['TARGET_FOLDER']

LOCATE_DEPENDENCY_CPPPATH=[]
LOCATE_DEPENDENCY_LIBPATH=[]


libs = os.path.dirname( INSTALL_PREFIX )
apps = pipe.roots().apps()



LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['PYTHON_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/python%s' % ( os.environ['PYTHON_TARGET_FOLDER'], '.'.join(python.split('.')[:2]) ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['PYTHON_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['TBB_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['TBB_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['BOOST_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/python%s'     % ( os.environ['BOOST_TARGET_FOLDER'],'.'.join(python.split('.')[:2]) ) )
BOOST_LIB_SUFFIX = ''

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OPENEXR_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/OpenEXR'  % ( os.environ['OPENEXR_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OPENEXR_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['ILMBASE_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/OpenEXR'  % ( os.environ['ILMBASE_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['ILMBASE_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['GLEW_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/GL'       % ( os.environ['GLEW_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['GLEW_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['FREEGLUT_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['FREEGLUT_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['JPEG_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['JPEG_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/arnold/%s/include'  % ( libs, arnold ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/arnold/%s/lib'      % ( libs, arnold ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/delight/%s/include'  % ( libs, prman ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/delight/%s/lib'      % ( libs, prman ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'  % ( MAYA_ROOT ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'      % ( MAYA_ROOT ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'  % ( NUKE_ROOT ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'      % ( NUKE_ROOT ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'  % ( HOUDINI_ROOT ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'      % ( HOUDINI_ROOT ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'  % ( RMAN_ROOT ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'      % ( RMAN_ROOT ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'                  % ( os.environ['CORTEX_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/boost.%s'              % ( os.environ['CORTEX_TARGET_FOLDER'], boost ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/boost.%s/python%s'     % ( os.environ['CORTEX_TARGET_FOLDER'], boost, '.'.join(python.split('.')[:2]) ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/maya/%s/lib'              % ( os.environ['CORTEX_TARGET_FOLDER'], maya ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/nuke/%s/lib'              % ( os.environ['CORTEX_TARGET_FOLDER'], nuke ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/prman/%s/lib'             % ( os.environ['CORTEX_TARGET_FOLDER'], prman ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/houdini/%s/lib'           % ( os.environ['CORTEX_TARGET_FOLDER'], houdini ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/alembic/%s/lib/boost.%s'           % ( os.environ['CORTEX_TARGET_FOLDER'], abc, boost ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/alembic/%s/lib/boost.%s/python%s'  % ( os.environ['CORTEX_TARGET_FOLDER'], abc, boost, '.'.join(python.split('.')[:2]) ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/usd/%s/lib/boost.%s'               % ( os.environ['CORTEX_TARGET_FOLDER'], os.environ['USD_VERSION'], boost ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/usd/%s/lib/boost.%s/python%s'      % ( os.environ['CORTEX_TARGET_FOLDER'], os.environ['USD_VERSION'], boost, '.'.join(python.split('.')[:2]) ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/openvdb/%s/lib/boost.%s'           % ( os.environ['CORTEX_TARGET_FOLDER'], os.environ['OPENVDB_VERSION'], boost ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/openvdb/%s/lib/boost.%s/python%s'  % ( os.environ['CORTEX_TARGET_FOLDER'], os.environ['OPENVDB_VERSION'], boost,  '.'.join(python.split('.')[:2]) ) )
if 'APPLESEED_VERSION' in os.environ:
    LOCATE_DEPENDENCY_LIBPATH.append( '%s/appleseed/%s/lib/'          % ( os.environ['CORTEX_TARGET_FOLDER'], os.environ['APPLESEED_VERSION'] ) )
    LOCATE_DEPENDENCY_LIBPATH.append( '%s/appleseed/%s/lib/python%s'  % ( os.environ['CORTEX_TARGET_FOLDER'], os.environ['APPLESEED_VERSION'],  '.'.join(python.split('.')[:2]) ) )


LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['QT_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['QT_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['PYSIDE_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['PYSIDE_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OIIO_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OIIO_TARGET_FOLDER'] ) )
OIIO_LIB_SUFFIX = ''

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OCIO_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OCIO_TARGET_FOLDER'] ) )


LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['LLVM_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['LLVM_TARGET_FOLDER'] ) )

OSLHOME=os.environ['OSL_TARGET_FOLDER']
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OSL_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/OSL'      % ( os.environ['OSL_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OSL_TARGET_FOLDER'] ) )

if 'APPLESEED_ROOT' in os.environ:
    LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['APPLESEED_TARGET_FOLDER'] ) )
    LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['APPLESEED_TARGET_FOLDER'] ) )

if 'PRMAN_ROOT' in os.environ:
    LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['PRMAN_ROOT'] ) )
    LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['PRMAN_ROOT'] ) )

if 'ARNOLD_ROOT' in os.environ:
    LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['ARNOLD_ROOT'] ) )
    LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['ARNOLD_ROOT'] ) )


GAFFERCORTEX = True


LOCATE_DEPENDENCY_PYTHONPATH = [
    '$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages',
    '$CORTEX_TARGET_FOLDER/openvdb/$OPENVDB_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages',
    '$CORTEX_TARGET_FOLDER/alembic/$ALEMBIC_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages',
    '$CORTEX_TARGET_FOLDER/usd/$USD_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages',
    '$USD_TARGET_FOLDER/python/',
    '$OPENVDB_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/',
    '$PYILMBASE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/',
    '$QTPY_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/',
    '$PYSIDE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/',
    '$OCIO_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/',
]
LOCATE_DEPENDENCY_PYTHONPATH = [ build.expandvars( x ) for x in LOCATE_DEPENDENCY_PYTHONPATH ]

os.environ['PYTHONPATH'                     ] = ':'.join(LOCATE_DEPENDENCY_PYTHONPATH+[os.environ['PYTHONPATH']])
os.environ['GAFFER_JEMALLOC'                ] = '0'
# os.environ['OCIO'                           ] =  genericBuilders.expandvars('$OCIO_PROFILES_TARGET_FOLDER/aces/luts/rrt/rrt_v0_1_1_sRGB.spi3d', os.environ)
os.environ['QT_QWS_FONTDIR'                 ] = genericBuilders.expandvars('$INSTALL_FOLDER/fonts/', os.environ)
os.environ['QT_QPA_FONTDIR'                 ] = os.environ['QT_QWS_FONTDIR']
os.environ['IECOREGL_SHADER_PATHS'          ] =  genericBuilders.expandvars('$CORTEX_TARGET_FOLDER/glsl', os.environ)
os.environ['IECOREGL_SHADER_INCLUDE_PATHS'  ] = os.environ['IECOREGL_SHADER_PATHS']
ENV_VARS_TO_IMPORT += ' GAFFER_JEMALLOC DISPLAY QT_QPA_FONTDIR QT_QWS_FONTDIR OCIO IECOREGL_SHADER_PATHS IECOREGL_SHADER_INCLUDE_PATHS '

os.environ['PATH'] = ':'.join([
    '$OSL_TARGET_FOLDER/bin',
    os.environ['PATH']
])

# sphinx in python 2.7 can't build docs in gaffer anymore! 
if os.environ['PYTHON_VERSION_MAJOR'] == '2.7':
    SPHINX="none"

popPrint('All Gaffer Paths...')


# print os.environ['LD_LIBRARY_PATH']

# def rest(INSTALL_PREFIX, python, boost, LOCATE_DEPENDENCY_CPPPATH, LOCATE_DEPENDENCY_LIBPATH):
#     ''' add all libraries as dependency to gaffer '''
#     from glob import glob
#     import os
#     for each in glob( '%s/*' % os.path.dirname( INSTALL_PREFIX )):
#         if 'gcc' not in each[-3:]:
#             app = each.split('/')[-1]
#             if not filter( lambda x: app in x, LOCATE_DEPENDENCY_CPPPATH):
#                 versions = glob( '%s/*' % each )
#                 versions.sort()
#                 versions.reverse()
#                 LOCATE_DEPENDENCY_CPPPATH.append( '%s/include' % (versions[0]) )
#                 LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/python%s' % (versions[0], '.'.join(python.split('.')[:2])) )
#                 LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib' % (versions[0]) )
#                 LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/%s' % (versions[0], boost) )
#                 LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/%s/python%s' % (versions[0], boost, '.'.join(python.split('.')[:2])) )
#
#                 if app == 'glew':
#                     LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/GL' % (versions[0]) )
#                 elif app in ['openexr', 'ilmbase']:
#                     LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/OpenEXR' % (versions[0]) )
#                 elif app in ['osl']:
#                     LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/OSL' % (versions[0]) )
#
#     return (LOCATE_DEPENDENCY_CPPPATH, LOCATE_DEPENDENCY_LIBPATH)
#
# LOCATE_DEPENDENCY_CPPPATH, LOCATE_DEPENDENCY_LIBPATH = rest( INSTALL_PREFIX, python, boost, LOCATE_DEPENDENCY_CPPPATH, LOCATE_DEPENDENCY_LIBPATH )

# OPENEXR_LIB_SUFFIX = '-%s' % openexr


#BUILD_DEPENDENCY_OIIO = True
#OIIO_SRC_DIR = os.getcwd()+'/oiio'

# OSL SUPPORT
#BUILD_DEPENDENCY_LLVM=True
#LLVM_SRC_DIR=os.getcwd()+'/dependecies/llvm-3.2.src/'
#BUILD_DEPENDENCY_OSL=True
#OSL_SRC_DIR = os.getcwd()+'/dependecies/OpenShadingLanguage-Release-1.4.0/'


#pprint( LOCATE_DEPENDENCY_LIBPATH )
#pprint( LOCATE_DEPENDENCY_CPPPATH )
#CXX="/atomo/pipeline/libs/linux/x86_64/gcc-%s/gcc/bin/g++" % gcc
#CC="/atomo/pipeline/libs/linux/x86_64/gcc-%s/gcc/bin/gcc"  % gcc

#CXXFLAGS=[ "-pipe", "-Wall", "-Werror", "-O2", "-DNDEBUG", "-DBOOST_DISABLE_ASSERTS" ]
# CXXFLAGS=[ "-pipe", "-Wall", "-O2", "-g", "-DNDEBUG", "-DBOOST_DISABLE_ASSERTS", "-DBOOST_SIGNALS_NO_DEPRECATION_WARNING" ]
# LINKFLAGS+=[
# #    "-Wl,-rpath,%sgcc/lib64"  % libs,
#     # "-Wl,-rpath,%sboost/%s/lib"  % (libs, boost),
#     # "-Wl,-rpath,%scortex/%s/lib"  % (libs, cortex),
#     # "-Wl,-rpath,%stbb/%s/lib"  % (libs, tbb),
#     # "-Wl,-rpath,%soiio/%s/lib"  % (libs, oiio),
#     # "-Wl,-rpath,%socio/%s/lib"  % (libs, ocio),
#     "-Wl,-rpath,%sqt/%s/lib"  % (libs, qt),
# #    "-Wl,-rpath,%spyside/%s/lib"  % (libs, pyside),
#     "-Wl,-rpath,%spyqt/%s/lib"  % (libs, pyqt),
#     # "-Wl,-rpath,%spython/%s/lib"  % (libs, python),
# ]

#PYTHON_LINK_FLAGS=LINKFLAGS
# print LINKFLAGS
# SHLINKFLAGS=LINKFLAGS


#INSTALL_DIR="/atomo/pipeline/libs/linux/x86_64/gcc-%s/gaffer/%s/" % (gcc, getCortexVersion())
#INSTALL_DIR="/atomo/apps/linux/x86_64/gaffer/%s/" % getCortexVersion()
