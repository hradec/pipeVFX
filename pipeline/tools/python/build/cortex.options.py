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

import os, sys, pipe


# just a couple of methods to dump out what this
# option file is setting up!
def pushPrint(d=locals()):
    print '='*80
    globals()['oldDir'] = d.copy()

def popPrint(msg,dd=locals()):
    d = dd.copy()
    print msg
    print '='*80
    pp=[]
    for each in d:
        if str(each) not in ['oldDir','msg','cmd']:
            if each not in globals()['oldDir']:
                pp.append( '%s@%s' % (each, eval(each,d.copy())) )
            elif str(globals()['oldDir'][each]) != str(d[each]):
                pp.append( '%s@%s' % (each, eval(each,d.copy())) )
    pp.sort()
    for each in pp:
        print '% 25s = %s' % tuple(each.split('@')[:2])
    print '='*80
    globals()['oldDir'] = d.copy()


# reset dump cache to track all registered variables from here down!
pushPrint()


def app_environ(name):
    import os
    if name in os.environ:
        return os.environ[name]
    return '0.0.0'

# library verions
# =============================================================================================================================================================
prmanName       = 'prman'

# version setup
jpeg      = os.environ['LIBPNG_VERSION']
png      = os.environ['LIBPNG_VERSION']
freetype = os.environ['FREETYPE_VERSION']
python   = os.environ['PYTHON_VERSION']
tbb      = os.environ['TBB_VERSION']
boost    = os.environ['BOOST_VERSION']
openexr  = os.environ['OPENEXR_VERSION']
ilmbase  = os.environ['ILMBASE_VERSION']
glew     = os.environ['GLEW_VERSION']
glut     = os.environ['FREEGLUT_VERSION']
abc      = os.environ['ALEMBIC_VERSION']
hdf5     = os.environ['HDF5_VERSION']
prman    = app_environ('PRMAN_VERSION')
maya     = app_environ('MAYA_VERSION')
nuke     = app_environ('NUKE_VERSION')
houdini  = app_environ('HOUDINI_VERSION')
arnold   = app_environ('ARNOLD_VERSION')

popPrint('Versions being used to build cortex...')


# python
# =============================================================================================================================================================
PYTHON_ROOT 		    = os.environ['PYTHON_TARGET_FOLDER']
PYTHON 			        = 'env LD_LIBRARY_PATH=%s/lib:./lib:$LD_LIBRARY_PATH %s/bin/python' % (PYTHON_ROOT,PYTHON_ROOT)
PYTHON_CONFIG 		    = '%s %s/bin/python-config' % (PYTHON, PYTHON_ROOT)
PYTHON_INCLUDE_PATH 	= os.popen( '%s --includes' % PYTHON_CONFIG ).readlines()[0].strip().split(' ')[0][2:]
PYTHON_LINK_FLAGS 	    = os.popen( '%s --ldflags' % PYTHON_CONFIG ).readlines()[0].strip()
cmd 			        = '%s -c "import sys;print sys.version[:3]"' % PYTHON
PYTHON_MAJOR_VERSION 	= os.popen( cmd ).readlines()[0].strip()
try:
    PYTHON_LIB_PATH = filter( lambda x: '-L' in x, PYTHON_LINK_FLAGS.split(' ') )[0][2:]
except:
#    PYTHON_LIB_PATH = '%s/config' % PYTHON_INCLUDE_PATH.replace('include','lib')
    PYTHON_LIB_PATH = '%s/lib' % PYTHON_ROOT
    PYTHON_LINK_FLAGS = '-L%s %s' % (PYTHON_LIB_PATH, PYTHON_LINK_FLAGS)

# =============================================================================================================================================================
WITH_GL                 = 1
WITH_MANTRA             = True
WITH_MAYA_PLUGIN_LOADER = 1
ENV_VARS_TO_IMPORT      = "PATH PYTHONPATH"


INSTALL_IECORE_OPS      = [
    ('IECore.SequenceLsOp', 'common/fileSystem/seqLs'),
    ('IECore.SequenceCpOp', 'common/fileSystem/seqCp'),
    ('IECore.SequenceMvOp', 'common/fileSystem/seqMv'),
    ('IECore.SequenceRmOp', 'common/fileSystem/Rm'),
    ('IECore.SequenceRenumberOp', 'common/fileSystem/seqRenumber'),
    ('IECore.SequenceConvertOp', 'common/fileSystem/seqConvert'),
    ('IECore.SequenceCatOp', 'common/fileSystem/seqCat'),
    ('IECore.RemovePrimitiveVariables', 'common/primitive/removeVariables'),
    ('IECore.RenamePrimitiveVariables', 'common/primitive/renameVariables'),
    ('IECore.PointsExpressionOp', 'common/primitive/pointsExpression'),
    ('IECore.ClassLsOp', 'common/classes/classLs'),
    ('IECore.FileDependenciesOp', 'common/fileSystem/depLs'),
    ('IECore.CheckFileDependenciesOp', 'common/fileSystem/depCheck'),
    ('IECore.LsHeaderOp', 'common/fileSystem/lsHeader'),
    ('IECore.SearchReplaceOp', 'common/fileSystem/searchReplace'),
    ('IECore.CheckImagesOp', 'common/fileSystem/checkImages'),
    ('IECore.FileSequenceGraphOp', 'common/fileSystem/fileSequenceGraph'),
    ('IECore.MeshPrimitiveImplicitSurfaceOp', 'common/primitive/mesh/implicitSurface'),
    ('IECore.MeshVertexReorderOp', 'common/primitive/mesh/vertexReorder'),
    ('IECore.MeshPrimitiveShrinkWrapOp', 'common/primitive/mesh/shrinkWrap'),
    ('IECore.Grade', 'common/colorSpace/grade'),
    ('IECore.CubeColorTransformOp', 'common/colorSpace/cubeColorTransform'),
    ('IECore.CineonToLinearOp', 'common/colorSpace/cineonToLinear'),
    ('IECore.LinearToCineonOp', 'common/colorSpace/linearToCineon'),
    ('IECore.SRGBToLinearOp', 'common/colorSpace/SRGBToLinear'),
    ('IECore.LinearToSRGBOp', 'common/colorSpace/linearToSRGB'),
    ('IECore.Rec709ToLinearOp', 'common/colorSpace/Rec709ToLinear'),
    ('IECore.LinearToRec709Op', 'common/colorSpace/linearToRec709'),
    ('IECore.PanalogToLinearOp', 'common/colorSpace/PanalogToLinear'),
    ('IECore.LinearToPanalogOp', 'common/colorSpace/linearToPanalog'),
    ('IECore.UVDistortOp', 'common/2d/image/uvDistort'),
    ('IECore.ImageCompositeOp', 'common/2d/image/imageComposite'),
    ('IECore.ImageConvolveOp', 'common/2d/image/imageConvolve'),
    ('IECore.AddSmoothSkinningInfluencesOp', 'rigging/smoothSkinning/addInfluences'),
    ('IECore.RemoveSmoothSkinningInfluencesOp', 'rigging/smoothSkinning/removeInfluences'),
    ('IECore.CompressSmoothSkinningDataOp', 'rigging/smoothSkinning/compress'),
    ('IECore.DecompressSmoothSkinningDataOp', 'rigging/smoothSkinning/decompress'),
    ('IECore.NormalizeSmoothSkinningWeightsOp', 'rigging/smoothSkinning/normalizeWeights'),
    ('IECore.ReorderSmoothSkinningInfluencesOp', 'rigging/smoothSkinning/reorderInfluences'),
    ('IECore.SmoothSmoothSkinningWeightsOp', 'rigging/smoothSkinning/smoothWeights'),
    ('IECore.LimitSmoothSkinningInfluencesOp', 'rigging/smoothSkinning/limitInfluences')
]




GLEW_INCLUDE_PATH       = "%s/include/GL" % os.environ['GLEW_TARGET_FOLDER']
GLEW_LIB_PATH           = "%s/lib"        % os.environ['GLEW_TARGET_FOLDER']

GLUT_INCLUDE_PATH       = "%s/include/"   % os.environ['FREEGLUT_TARGET_FOLDER']
GLUT_LIB_PATH           = "%s/lib/"       % os.environ['FREEGLUT_TARGET_FOLDER']

TIFF_INCLUDE_PATH       = "%s/include" % os.environ['TIFF_TARGET_FOLDER']
TIFF_LIB_PATH           = "%s/lib"     % os.environ['TIFF_TARGET_FOLDER']

PNG_INCLUDE_PATH        = "%s/include" % os.environ['LIBPNG_TARGET_FOLDER']
PNG_LIB_PATH            = "%s/lib"     % os.environ['LIBPNG_TARGET_FOLDER']

JPEG_INCLUDE_PATH       = "%s/include" % os.environ['JPEG_TARGET_FOLDER']
JPEG_LIB_PATH           = "%s/lib"     % os.environ['JPEG_TARGET_FOLDER']

BOOST_INCLUDE_PATH      = "%s/include" % os.environ['BOOST_TARGET_FOLDER']
BOOST_LIB_PATH          = "%s/lib/python%s/"  % (os.environ['BOOST_TARGET_FOLDER'], PYTHON_MAJOR_VERSION)
BOOST_LIB_SUFFIX        = ""
if os.environ['BOOST_VERSION'] == "1.56.0": # 1.56 seems to be the last version that uses -mt as suffix.
    BOOST_LIB_SUFFIX        = "-mt"

TBB_INCLUDE_PATH        = "%s/include" % os.environ['TBB_TARGET_FOLDER']
TBB_LIB_PATH 	        = "%s/lib"     % os.environ['TBB_TARGET_FOLDER']

OPENEXR_INCLUDE_PATH    = "%s/include" % os.environ['OPENEXR_TARGET_FOLDER']
OPENEXR_LIB_PATH 	    = "%s/lib"     % os.environ['OPENEXR_TARGET_FOLDER']

ILMBASE_INCLUDE_PATH    = "%s/include" % os.environ['ILMBASE_TARGET_FOLDER']
ILMBASE_LIB_PATH        = "%s/lib"     % os.environ['ILMBASE_TARGET_FOLDER']

FREETYPE_INCLUDE_PATH   = "%s/include/freetype/" % os.environ['FREETYPE_TARGET_FOLDER']
FREETYPE_LIB_PATH 	    = "%s/lib"     % os.environ['FREETYPE_TARGET_FOLDER']

HDF5_INCLUDE_PATH       = "%s/include" % os.environ['HDF5_TARGET_FOLDER']
HDF5_LIB_PATH           = "%s/lib"     % os.environ['HDF5_TARGET_FOLDER']
HDF5_LIB_SUFFIX         = ''

if 'ALEMBIC_TARGET_FOLDER' in os.environ:
    ALEMBIC_INCLUDE_PATH    = "%s/include" % os.environ['ALEMBIC_TARGET_FOLDER']
    ALEMBIC_LIB_PATH        = "%s/lib/python%s" % ( os.environ['ALEMBIC_TARGET_FOLDER'], PYTHON_MAJOR_VERSION)
    ALEMBIC_LIB_SUFFIX      = ''



# app paths
# =============================================================================================================================================================
apps                    = pipe.roots().apps()
MAYA_ROOT               = apps+"/maya/%s/"   % maya
RMAN_ROOT               = apps+"/%s/%s/RenderManProServer-%s"  % (prmanName, prman, prman)
NUKE_ROOT		        = apps+"/nuke/%s/"   % nuke
HOUDINI_ROOT	        = apps+"/houdini/%s/" % houdini
# ARNOLD_ROOT             = apps+"/arnold/%s/" % arnold
# MTOA_ROOT               = ARNOLD_ROOT+"/mtoadeploy/%s/" % maya
# MTOA_SOURCE_ROOT        = ARNOLD_ROOT+"/mtoadeploy/%s/scripts/mtoa/" % maya


# installation paths
# =============================================================================================================================================================
installRoot = "" #os.environ['TARGET_FOLDER']
installRootMaya   = "/maya/%s" % maya
installRootNuke   = "/nuke/%s" % nuke
installRootPrman  = "/%s/%s" % (prmanName, prman)
installRootArnold = "/arnold/%s" % arnold

extraInstallPath  = '/boost%s' % os.environ['BOOST_VERSION']

# install prefixes with per package version numbers!
# =============================================================================================================================================================
INSTALL_PREFIX                  = os.environ['TARGET_FOLDER']

# if houdini != '0.0.0':
#     # if we're installing houdini, make installPrefix be the houdini folder+version
#     # so we can build the whole IECore* libraries with the houdini dependency!
#     INSTALL_PREFIX                  = os.environ['TARGET_FOLDER'] + '/houdini/%s' % houdini
#     extraInstallPath                = ""


INSTALL_LIB_NAME                = "$INSTALL_PREFIX%s/lib%s/$IECORE_NAME" % (installRoot, extraInstallPath)
INSTALL_PYTHONLIB_NAME          = "$INSTALL_PREFIX%s/lib%s/python%s/$IECORE_NAME" % (installRoot, extraInstallPath, PYTHON_MAJOR_VERSION)
INSTALL_PYTHON_DIR              = "$INSTALL_PREFIX%s/lib%s/python%s/site-packages" % (installRoot, extraInstallPath, PYTHON_MAJOR_VERSION)

INSTALL_NUKELIB_NAME            = "$INSTALL_PREFIX%s/lib/$IECORE_NAME" % installRootNuke
INSTALL_NUKEPLUGIN_NAME         = "$INSTALL_PREFIX%s/plugins/$IECORE_NAME" % installRootNuke
INSTALL_NUKEPYTHON_DIR          = "$INSTALL_PREFIX%s/lib/python%s/site-packages" % (installRootNuke, PYTHON_MAJOR_VERSION)

INSTALL_MAYALIB_NAME            = "$INSTALL_PREFIX%s/lib/$IECORE_NAME" % installRootMaya
INSTALL_MAYAICON_DIR            = "$INSTALL_PREFIX%s/icons" % installRootMaya
INSTALL_MAYAPLUGIN_NAME         = "$INSTALL_PREFIX%s/plugins/$IECORE_NAME" % installRootMaya
INSTALL_MEL_DIR                 = "$INSTALL_PREFIX%s/mel/$IECORE_NAME" % installRootMaya
INSTALL_MAYAPYTHON_DIR          = "$INSTALL_PREFIX%s/lib/python%s/site-packages" % (installRootMaya, PYTHON_MAJOR_VERSION)

INSTALL_RMANLIB_NAME            = "$INSTALL_PREFIX%s/lib/$IECORE_NAME" % installRootPrman
INSTALL_RMANPROCEDURAL_NAME     = "$INSTALL_PREFIX%s/procedurals/$IECORE_NAME" % installRootPrman
INSTALL_RMANDISPLAY_NAME        = "$INSTALL_PREFIX%s/displays/$IECORE_NAME" % installRootPrman
INSTALL_RSL_HEADER_DIR          = "$INSTALL_PREFIX%s/rsl" % installRootPrman
INSTALL_RMANPYTHON_DIR          = "$INSTALL_PREFIX%s/lib/python%s/site-packages" % (installRootPrman, PYTHON_MAJOR_VERSION)

INSTALL_ARNOLDLIB_NAME          = "$INSTALL_PREFIX%s/lib/$IECORE_NAME" % installRootArnold
INSTALL_ARNOLDPROCEDURAL_NAME   = "$INSTALL_PREFIX%s/procedurals/$IECORE_NAME" % installRootArnold
INSTALL_ARNOLDOUTPUTDRIVER_NAME = "$INSTALL_PREFIX%s/displays/$IECORE_NAME" % installRootArnold
INSTALL_ARNOLDPYTHON_DIR        = "$INSTALL_PREFIX%s/lib/python%s/site-packages" % (installRootArnold, PYTHON_MAJOR_VERSION)
INSTALL_MTOAEXTENSION_NAME      = "$INSTALL_PREFIX%s/mtoaExtensions/%s/$IECORE_NAME" % (installRootArnold, maya)

INSTALL_ALEMBICLIB_NAME         = "$INSTALL_PREFIX/alembic/%s/lib/$IECORE_NAME" % abc
INSTALL_ALEMBICPYTHON_DIR       = "$INSTALL_PREFIX/alembic/%s/lib/python%s/site-packages" % (abc, PYTHON_MAJOR_VERSION)

INSTALL_HOUDINILIB_NAME         = "$INSTALL_PREFIX/lib/$IECORE_NAME"
INSTALL_HOUDINIOTL_DIR          = "$INSTALL_PREFIX/otls/"
INSTALL_HOUDINIICON_DIR         = "$INSTALL_PREFIX/icons"
INSTALL_HOUDINITOOLBAR_DIR      = "$INSTALL_PREFIX/toolbar"
INSTALL_HOUDINIPLUGIN_NAME      = "$INSTALL_PREFIX/dso/$IECORE_NAME"
INSTALL_HOUDINIPYTHON_DIR       = "$INSTALL_PREFIX/lib/python%s/site-packages" % (PYTHON_MAJOR_VERSION)

INSTALL_MANTRALIB_NAME          = "$INSTALL_PREFIX/lib/$IECORE_NAME"
INSTALL_MANTRAPROCEDURAL_NAME   = "$INSTALL_PREFIX/dso/mantra/$IECORE_NAME"
INSTALL_HOUDINIMENU_DIR         = "$INSTALL_PREFIX/dso/"

os.environ['PYTHONPATH'] = INSTALL_PYTHON_DIR

# build flags
# =============================================================================================================================================================
# we use houdinis hcustom command to figure out the cxx/link flags needed for the current houdini version
# hcustom = os.popen('''touch /tmp/test.cpp ; python -c "import pipe;pipe.apps.houdini().run('hcustom')" -t -e -i /tmp /tmp/test.cpp''').readlines()
# for l in hcustom:
#     if '-o /tmp/test.o' in l:
#         os.environ['HOUDINI_CXX_FLAGS'] = l.split('g++')[-1].split('-o')[0]
#     if '-shared' in l:
#         os.environ['HOUDINI_LINK_FLAGS'] = l.split('test.o')[-1].split('-o')[0]

LIBPATH = []
if houdini != '0.0.0':
    # INSTALL_LIB_NAME                = "$INSTALL_PREFIX%s/houdini/%s/lib/$IECORE_NAME" % (installRoot, houdini)
    # INSTALL_PYTHONLIB_NAME          = "$INSTALL_PREFIX%s/houdini/%s/lib/python%s/$IECORE_NAME" % (installRoot, houdini, PYTHON_MAJOR_VERSION)
    # INSTALL_PYTHON_DIR              = "$INSTALL_PREFIX%s/houdini/%s/lib/python%s/site-packages" % (installRoot, houdini, PYTHON_MAJOR_VERSION)


    # BOOST_INCLUDE_PATH      = "%s/toolkit/include/boost/" % os.environ['HOUDINI_ROOT']
    # BOOST_LIB_PATH          = "%s/lib/python%s/"  % (os.environ['BOOST_TARGET_FOLDER'], PYTHON_MAJOR_VERSION)
    # BOOST_LIB_SUFFIX        = ""
    # if os.environ['BOOST_VERSION'] == "1.56.0": # 1.56 seems to be the last version that uses -mt as suffix.
    #     BOOST_LIB_SUFFIX        = "-mt"


    os.environ['HOUDINI_CXX_FLAGS']  = [ l for l in os.popen('hcustom -c').readlines() if '-DVERSION' in l ][0].replace('pipeLog: ','').replace('-std=c++0x','').strip()
    os.environ['HOUDINI_LINK_FLAGS'] = [ l for l in os.popen('hcustom -m').readlines() if '-L' in l ][0].replace('pipeLog: ','').strip()

    if 'GCC_VERSION' in os.environ:
        if os.environ['GCC_VERSION'] == '4.1.2':
            os.environ['HOUDINI_CXX_FLAGS'] += " -isystem %s/lib/gcc/x86_64-pc-linux-gnu/%s/include/c++/tr1/" % (os.environ['GCC_TARGET_FOLDER'], os.environ['GCC_VERSION'])
            os.environ['HOUDINI_CXX_FLAGS'] = os.environ['HOUDINI_CXX_FLAGS'].replace('-Wno-unused-local-typedefs','')
        elif os.environ['GCC_VERSION'] == '4.8.5':
            os.environ['HOUDINI_CXX_FLAGS'] += " -std=c++11 -fexceptions "

    os.environ['HOUDINI_CXX_FLAGS'] += ' -DDLLEXPORT= '
    os.environ['HOUDINI_LINK_FLAGS'] += ' '+' '.join([
        '-Wl,-rpath,%s/dsolib' % HOUDINI_ROOT,
        '-Wl,-rpath,%s/python/lib/' % HOUDINI_ROOT,
        '-Wl,-rpath,%s' % os.path.dirname(INSTALL_LIB_NAME),
        '-Wl,-rpath,%s' % os.path.dirname(INSTALL_PYTHONLIB_NAME),
    ])

    if boost == '1.51.0':
        os.environ['HOUDINI_CXX_FLAGS'] += " -D__GLIBC_HAVE_LONG_LONG"


    HOUDINI_CXX_FLAGS = os.environ['HOUDINI_CXX_FLAGS']
    HOUDINI_LINK_FLAGS = os.environ['HOUDINI_LINK_FLAGS']

    if 'GCC_VERSION' in os.environ:
        HOUDINI_LINK_FLAGS = " ".join([
            os.environ['HOUDINI_LINK_FLAGS'],
            "-Wl,-rpath,%s/lib/gcc/x86_64-pc-linux-gnu/%s/"  % ( os.environ['GCC_TARGET_FOLDER'], os.environ['GCC_VERSION']),
            "-Wl,-rpath,%s/lib/"  % os.environ['GCC_TARGET_FOLDER'],
        ])


if 'GCC_VERSION' in os.environ:
    PYTHON_LINK_FLAGS += ' '+' '.join([
        "-Wl,-rpath,%s/lib/gcc/x86_64-pc-linux-gnu/%s/"  % ( os.environ['GCC_TARGET_FOLDER'], os.environ['GCC_VERSION']),
        "-Wl,-rpath,%s/lib/"  % os.environ['GCC_TARGET_FOLDER'],
    #     '-Wl,-rpath /lib64',
    #     '-Wl,-rpath /usr/lib64/',
    #     # '-Wl,-rpath %s/dsolib' % HOUDINI_ROOT,
    #     # '-Wl,-rpath %s/python/lib/' % HOUDINI_ROOT,
    ])

    # LIBPATH is default to /usr/lib, so we make it look for the current GCC being used to build.
    LIBPATH = [
        "%s/lib/gcc/x86_64-pc-linux-gnu/%s/"  % ( os.environ['GCC_TARGET_FOLDER'], os.environ['GCC_VERSION']),
        "%s/lib/"  % os.environ['GCC_TARGET_FOLDER'],
    ]

    LINKFLAGS = [
        "-Wl,-rpath,%s/lib/gcc/x86_64-pc-linux-gnu/%s/"  % ( os.environ['GCC_TARGET_FOLDER'], os.environ['GCC_VERSION']),
        "-Wl,-rpath,%s/lib/"  % os.environ['GCC_TARGET_FOLDER'],
    ]

LIBPATH += [
    "%s/lib/" % os.environ['ICU_TARGET_FOLDER']
]
LINKFLAGS += [
    '-L%s' % FREETYPE_LIB_PATH, # we do this or else cortex will use maya's!!!
    '-L%s' % TBB_LIB_PATH,      # we do this or else cortex will use maya's!!!
    "-Wl,-rpath,%s/lib/"  % os.environ['ICU_TARGET_FOLDER'],
    '-Wl,-rpath,%s' % BOOST_LIB_PATH,
    # '-Wl,-rpath,%s' % PYTHON_LIB_PATH,
    # '-Wl,-rpath,%s' % PNG_LIB_PATH,
    # "-Wl,-rpath,/atomo/pipeline/libs/linux/x86_64/gcc-%s/zlib/1.2.3/lib/"  % GCC,
    # "-Wl,-rpath,/atomo/pipeline/libs/linux/x86_64/gcc-%s/jpeg/6b/lib/"  % GCC,
    '-Wl,-rpath,%s' % OPENEXR_LIB_PATH,
    '-Wl,-rpath,%s' % ILMBASE_LIB_PATH,
    # '-Wl,-rpath,%s' % GLEW_LIB_PATH,
    # '-Wl,-rpath,%s' % TIFF_LIB_PATH,
    # '-Wl,-rpath,%s/lib' % RMAN_ROOT, # IECoreMaya links against libprman, so we can't make its path static! :(
    # '-Wl,-rpath,%s/lib/linux_x64/gcc-4.1/' % VRAY_ROOT,
    # '-Wl,-rpath,/lib64',
    # '-Wl,-rpath,/usr/lib64',
]
#LINKFLAGS.append('-Wl,-rpath,%s' % os.path.dirname(INSTALL_NUKELIB_NAME))
#LINKFLAGS.append('-Wl,-rpath %s' % NUKE_ROOT)
#LINKFLAGS.append('-Wl,-rpath,%s' % os.path.dirname(INSTALL_RMANLIB_NAME))
#LINKFLAGS.append('-Wl,-rpath,%s' % os.path.dirname(INSTALL_ARNOLDLIB_NAME))
#LINKFLAGS.append('-Wl,-rpath %s/bin' % ARNOLD_ROOT)
#LINKFLAGS.append('-Wl,-rpath,%s' % os.path.dirname(INSTALL_MAYALIB_NAME))
#LINKFLAGS.append('-Wl,-rpath %s/lib' % MAYA_ROOT)


LINKFLAGS.append("-L%s" % os.path.dirname(INSTALL_LIB_NAME) )
LINKFLAGS.append("-L%s" % os.path.dirname(INSTALL_PYTHONLIB_NAME) )
LINKFLAGS.append('-L%s' % NUKE_ROOT)
LINKFLAGS.append('-L%s' % os.path.dirname(INSTALL_NUKELIB_NAME))
LINKFLAGS.append('-L%s' % os.path.dirname(INSTALL_RMANLIB_NAME))
LINKFLAGS.append('-L%s/lib' % MAYA_ROOT)
LINKFLAGS.append('-L%s' % os.path.dirname(INSTALL_MAYALIB_NAME))
LINKFLAGS.append('-L%s' % os.path.dirname(INSTALL_HOUDINILIB_NAME))
LINKFLAGS.append('-L%s/bin' % ARNOLD_ROOT)
LINKFLAGS.append('-L%s' % os.path.dirname(INSTALL_ARNOLDLIB_NAME))
LINKFLAGS.append('-L%s' % os.path.dirname(INSTALL_ALEMBICLIB_NAME))

# CC = os.environ['CC']
# CPP = os.environ['CPP']
# CXX = os.environ['CXX']
CXXFLAGS = ['-pipe', '-Wall', '-O2', '-DNDEBUG', '-g', '-DBOOST_DISABLE_ASSERTS', '-fpermissive', '-DAtUInt=AtUInt32']  + os.environ['CXXFLAGS'].split(' ')
if boost == '1.51.0':
    CXXFLAGS += ["-D__GLIBC_HAVE_LONG_LONG"]
TESTCXXFLAGS = ['-pipe', '-Wall', '-O0'] + os.environ['CXXFLAGS'].split(' ')
PYTHONCXXFLAGS = ['-pipe', '-Wall', '-O2', '-DNDEBUG', '-g', '-DBOOST_DISABLE_ASSERTS', '-fpermissive'] + os.environ['CXXFLAGS'].split(' ')

os.environ['LD_LIBRARY_PATH'] = '%s:%s' % (BOOST_LIB_PATH, os.environ['LD_LIBRARY_PATH'])


os.environ['LIBRARY_PATH'] += " /usr/lib/gcc/x86_64-pc-linux-gnu/6.2.1/"

popPrint('All Cortex Paths...')
# =============================================================================================================================================================
# LD_LIBRARY_PATH for testings...
# we only need python lib folder since all others lib folders are included into
# the compiled binaries with -Wl,-rpath link option.
TEST_LIBPATH = ':'.join([PYTHON_LIB_PATH])


# install a cortexPython wrapper to simplify our lives!!
# =============================================================================================================================================================
cortexPython = '%s/bin/cortexPython%s' % (INSTALL_PREFIX,PYTHON_MAJOR_VERSION)
os.system( 'rm -rf %s/bin' % INSTALL_PREFIX )
os.system( 'mkdir -p %s/bin' % INSTALL_PREFIX )
f=open( cortexPython, 'w' )
f.write( '''#!/bin/bash
CORTEX_ROOT=`dirname $0`/..
#CORTEX_ROOT=`path $CORTEX_ROOT`
export HOUDINI_SCRIPT_PATH=%s/houdini/scripts
export LD_LIBRARY_PATH=%s:$CORTEX_ROOT/lib:$CORTEX_ROOT/lib/python%s:$CORTEX_ROOT/lib/maya/%s:$CORTEX_ROOT/lib/nuke/%s:$CORTEX_ROOT/lib/houdini/%s:%s/python/lib
export LD_LIBRARY_PATH=$CORTEX_ROOT/lib/rman/%s:$CORTEX_ROOT/lib/arnold/%s:$LD_LIBRARY_PATH
export PYTHONPATH=/tools/extension/python/2.5/lib/python2.5/:$PYTHONPATH
export PYTHONPATH=$CORTEX_ROOT/lib/python%s/site-packages:%s/python/lib/python%s/:$PYTHONPATH
export PYTHONPATH=%s/lib/python2.6/site-packages/:$PYTHONPATH
export PYTHONPATH=%s/plugins:%s/houdini/python2.6libs:$PYTHONPATH
%s $@
''' % ( HOUDINI_ROOT, PYTHON_LIB_PATH, PYTHON_MAJOR_VERSION, maya, nuke, houdini, HOUDINI_ROOT, prman, arnold,
        PYTHON_MAJOR_VERSION, HOUDINI_ROOT,PYTHON_MAJOR_VERSION,
        MAYA_ROOT,NUKE_ROOT,HOUDINI_ROOT,
        PYTHON, ) )
f.flush();f.close()
os.system( 'chmod a+x %s' % cortexPython )
os.system( 'ln -s cortexPython%s %s/bin/cortexPython ' % (PYTHON_MAJOR_VERSION,INSTALL_PREFIX) )
os.system( 'ln -s cortexPython%s %s/bin/cpython ' % (PYTHON_MAJOR_VERSION,INSTALL_PREFIX) )

TEST_LIBPATH='./lib'
DOXYGEN=os.popen('which doxygen').readlines()[0].strip()
#
# BUILD_CACHEDIR = "/tmp/"
