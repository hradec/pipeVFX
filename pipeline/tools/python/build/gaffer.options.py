
from glob import glob
from pprint import pprint
import os,sys, pipe

import pipe

# try to get an env var, if not exists return value
def get(var, value):
    import os
    if os.environ.has_key(var):
        return os.environ[var]
    return value



exec( ''.join( open( '%s/cortex.options.py' % os.path.dirname( sys.argv[1].split('=')[-1] ) ).readlines() ) )


# python  = get('PYTHON', 	'2.7.6')
# #tbb     = get('TBB', 		'2.2.004' )
# #tbb      = get('TBB', 		'4.2.20140416oss' )
# tbb      = get('TBB', 		'3' )
# boost   = get('BOOST', 		'1.56.0' )
# #boost   = get('BOOST', 		'1.46.1' )
# openexr = get('OPENEXR', 	'2.0.0' )
# ilmbase = get('ILMBASE', 	'2.0.0' )
# glew    = get('GLEW', 		'1.9.0' )
# glut    = get('GLUT', 		'2.6.0' )
# arnold  = get('ARNOLD', 	'4.0.1.0' )
# #prman   = get('DELIGHT',        '11.0.2' )
# prman   = get('PRMAN', 		'20.2' )
# maya    = get('MAYA', 		'2014' )
# nuke    = get('NUKE', 		'7.0v8' )
# houdini = get('HOUDINI', 	'hfs12.5.421' )
# #katana  = get('KATANA', versions['katana'] )
# #abc     = get('ALEMBIC', versions['alembic'] )
# #cortex = get('CORTEX',     '7.11.0.r5340' )
# #cortex = get('CORTEX',     pipe.libs.version.get('cortex') )
cortex = os.environ['CORTEX_VERSION']
qt     = os.environ['QT_VERSION']
pyqt   = os.environ['PYQT_VERSION']
oiio   = os.environ['OIIO_VERSION']
ocio   = os.environ['OCIO_VERSION']
llvm   = os.environ['LLVM_VERSION']
osl    = os.environ['OSL_VERSION']
boost  = os.environ['BOOST_VERSION']


# app paths
# =============================================================================================================================================================
apps                    = pipe.roots().apps()
MAYA_ROOT               = apps+"/maya/%s/"   % maya
RMAN_ROOT               = apps+"/%s/%s/RenderManProServer-%s"  % (prmanName, prman, prman)
NUKE_ROOT		        = apps+"/nuke/%s/"   % nuke
HOUDINI_ROOT	        = apps+"/houdini/%s/" % houdini
OSLHOME                 = '%s/include'          % ( os.environ['OSL_TARGET_FOLDER'] )
#APPLESEED_ROOT



# INSTALL_DIR = os.environ['TARGET_FOLDER']
BUILD_DIR='/tmp/build/gaffer-${GAFFER_MAJOR_VERSION}.${GAFFER_MINOR_VERSION}.${GAFFER_PATCH_VERSION}-${GAFFER_PLATFORM}-python'+'.'.join(python.split('.')[:2])
BUILD_DIR=os.environ['TARGET_FOLDER']

LOCATE_DEPENDENCY_CPPPATH=[]
LOCATE_DEPENDENCY_LIBPATH=[]


libs = os.path.dirname( INSTALL_PREFIX )
apps = '/atomo/apps/linux/x86_64/'



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

#LOCATE_DEPENDENCY_CPPPATH.append( '%s/arnold/%s/include'  % ( libs, arnold ) )
#LOCATE_DEPENDENCY_LIBPATH.append( '%s/arnold/%s/lib'      % ( libs, arnold ) )

# LOCATE_DEPENDENCY_CPPPATH.append( '%s/delight/%s/include'  % ( libs, prman ) )
# LOCATE_DEPENDENCY_LIBPATH.append( '%s/delight/%s/lib'      % ( libs, prman ) )

RMAN_ROOT='%s/prman/%s/'      % ( apps, prman )


#LOCATE_DEPENDENCY_CPPPATH.append( '%s/maya/%s/include'  % ( libs, maya ) )
#LOCATE_DEPENDENCY_LIBPATH.append( '%s/maya/%s/lib'      % ( libs, maya ) )

# LOCATE_DEPENDENCY_CPPPATH.append( '%s/nuke/%s/include'  % ( libs, nuke ) )
# LOCATE_DEPENDENCY_LIBPATH.append( '%s/nuke/%s/lib'      % ( libs, nuke ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'                  % ( os.environ['CORTEX_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/boost%s'              % ( os.environ['CORTEX_TARGET_FOLDER'], boost ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib/boost%s/python%s'     % ( os.environ['CORTEX_TARGET_FOLDER'], boost, '.'.join(python.split('.')[:2]) ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/alembic/%s/lib'           % ( os.environ['CORTEX_TARGET_FOLDER'], abc ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/alembic/%s/lib/python%s'  % ( os.environ['CORTEX_TARGET_FOLDER'], abc, '.'.join(python.split('.')[:2]) ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/maya/%s/lib'              % ( os.environ['CORTEX_TARGET_FOLDER'], maya ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/nuke/%s/lib'              % ( os.environ['CORTEX_TARGET_FOLDER'], nuke ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/prman/%s/lib'             % ( os.environ['CORTEX_TARGET_FOLDER'], prman ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/houdini/%s/lib'           % ( os.environ['CORTEX_TARGET_FOLDER'], houdini ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['QT_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['QT_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['PYQT_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['PYQT_TARGET_FOLDER'] ) )

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OIIO_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OIIO_TARGET_FOLDER'] ) )
OIIO_LIB_SUFFIX = ''

LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OCIO_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OCIO_TARGET_FOLDER'] ) )


LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['LLVM_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['LLVM_TARGET_FOLDER'] ) )


LOCATE_DEPENDENCY_CPPPATH.append( '%s/include'          % ( os.environ['OSL_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_CPPPATH.append( '%s/include/OSL'      % ( os.environ['OSL_TARGET_FOLDER'] ) )
LOCATE_DEPENDENCY_LIBPATH.append( '%s/lib'              % ( os.environ['OSL_TARGET_FOLDER'] ) )




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
print LINKFLAGS
# SHLINKFLAGS=LINKFLAGS

ENV_VARS_TO_IMPORT="PATH"

#INSTALL_DIR="/atomo/pipeline/libs/linux/x86_64/gcc-%s/gaffer/%s/" % (gcc, getCortexVersion())
#INSTALL_DIR="/atomo/apps/linux/x86_64/gaffer/%s/" % getCortexVersion()
