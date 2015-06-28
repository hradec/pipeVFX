
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class make(generic):
    ''' a class to handle make installs '''
    src = 'Makefile'
    cmd = 'make -j $DCORES CC=$CC CXX=$CXX CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" && make install'


class cmake(make):
    ''' a class to handle cmake installs '''
    src = 'CMakeLists.txt'
    cmd = [
        'cmake $SOURCE_FOLDER && '
        'make -j $DCORES VERBOSE=1 && make install'
    ]
    flags = [    
            '-Wno-dev',
            '-DUSE_SIMD=0',
            '-DUSE_FFMPEG=0',
            '-DUSE_OPENCV=0',
            '-DCMAKE_INSTALL_PREFIX=$TARGET_FOLDER',
            '-DCMAKE_CC_COMPILER=$CC',
            '-DCMAKE_CXX_COMPILER=$CXX',
            '-DCMAKE_CPP_COMPILER=$CPP',
            '-DCMAKE_CC_LINKER_PREFERENCE=$LD',
            '-DCMAKE_CXX_LINKER_PREFERENCE=$LD',
            '-DCMAKE_LINKER=$LD',
            '-DSTOP_ON_WARNING=0',
            '-DBoost_NO_SYSTEM_PATHS=1',
            '-DBoost_DETAILED_FAILURE_MSG=1',
            '-DBoost_USE_STATIC_LIBS=false',
#            '-DBoost_USE_MULTITHREADED=false',
#            '-DBoost_USE_STATIC_RUNTIME=false',
            '-DLIBPYTHON_VERSION=$PYTHON_VERSION_MAJOR',
            '-DPYTHON_ROOT=$PYTHON_ROOT',
            '-DPYTHON_INCLUDE_DIR=$PYTHON_ROOT/include/python$PYTHON_VERSION_MAJOR/',
            '-DPYTHON_LIBRARY=$PYTHON_ROOT/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DBOOST_ROOT=$BOOST_TARGET_FOLDER',
            '-DBOOST_LIBRARYDIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            '-Wno-dev',
            '-DVERBOSE=1',
            '-DALEMBIC_PYTHON_ROOT=$PYTHON_ROOT/lib/python$PYTHON_VERSION_MAJOR/config',
            '-DALEMBIC_PYTHON_LIBRARY=$PYTHON_ROOT/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DMAYA_ROOT=$MAYA_ROOT',
            '-DARNOLD_ROOT=$ARNOLD_ROOT',
            '-DPRMAN_ROOT=$PRMAN_ROOT',
            '-DOPENEXR_ROOT=$OPENEXR_TARGET_FOLDER',
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            '-DPYILMBASE_ROOT=$PYILMBASE_TARGET_FOLDER',
            '-DPYILMBASE_LIBRARY_DIR=$PYILMBASE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            '-DGCC_VERSION=%s' % pipe.build.distro.split('-')[-1],
            # we need libXmi and libXi from the main system
            "-DGLUT_Xmu_LIBRARY=$(echo $(ldconfig -p | grep 'libXmu.so ' | cut -d'>' -f2))",
            "-DGLUT_Xi_LIBRARY=$(echo $(ldconfig -p | grep 'libXi.so ' | cut -d'>' -f2))",
        ]
    
    def fixCMD(self, cmd):
        ''' cmake is kindy picky with environment variables and has lots of 
        variables override to force it to find packages in non-usual places.
        So here we force some env vars and command line overrides to make sure 
        cmake finds pipeVFX packages first!'''
        try: maya = pipe.apps.maya().path('')
        except: maya = ""
        try: arnold = pipe.apps.arnold().path('')
        except: arnold = ""
        try: prman = pipe.apps.delight().path('')
        except: prman = ""
        environ = [
            'HDF5_ROOT=$HDF5_TARGET_FOLDER',
            'HDF5_INCLUDE_DIR=$HDF5_TARGET_FOLDER/include',
            'HDF5_LIBRARIES=$HDF5_TARGET_FOLDER/lib/libhdf5.so',
            'OPENEXR_INCLUDE_PATHS=$OPENEXR_TARGET_FOLDER/include',
            'OPENEXR_LIBRARIES=$OPENEXR_TARGET_FOLDER/lib/libIlmImf.so',
            'CMAKE_CC_COMPILER=$CC',
            'CMAKE_CXX_COMPILER=$CXX',
            'CMAKE_CC_LINKER_PREFERENCE=$LD',
            'CMAKE_CXX_LINKER_PREFERENCE=$LD',
            'CMAKE_LINKER=$LD',
        ]
        environ += [
            'MAYA_ROOT=%s'   % maya,
            'ARNOLD_ROOT=%s' % arnold,
            'PRMAN_ROOT=%s'  % prman,
        ]
        for each in self.flags:
            if 'cmake' in cmd and each.split('=')[0] not in cmd:
                cmd = cmd.replace('cmake','cmake '+each+' ')
        
        if 'cmake' in cmd and os.environ.has_key('CMAKE_TARGET_FOLDER'):
            cmd = cmd.replace('cmake','$CMAKE_TARGET_FOLDER/bin/cmake')
         
        cmd = ' && '.join(environ)+" && "+cmd        
        cmd = 'find ./ -name CMakeCache.txt -exec rm -rf {} \; && '+cmd
        return cmd 


class glew(make):
    ''' a make class to exclusively build glew package
    glew requires a bunch of make calls to construct the source and build.
    also, it install its libs in the lib64 folder, so we use a custom 
    installer method to create a link lib -> lib64'''
    cmd = ' && '.join([
        'make extensions', 
        'make GLEW_DEST=$TARGET_FOLDER CC=$(which gcc) CXX=$(which g++) LD=$(which gcc)',
        'make GLEW_DEST=$TARGET_FOLDER CC=$(which gcc) CXX=$(which g++) LD=$(which gcc) install',
    ])
    
    def installer(self, target, source, env):
        ''' just a small installation patch to link lib64 to lib, which is the
        expected shared library folder name, since pipeVFX organize packages in
        arch specific hierarchy - linux/x86_64/package '''
        targetFolder = os.path.dirname(str(target[0]))
        if not os.path.exists("%s/lib" % targetFolder):
            if os.path.exists("%s/lib64" % targetFolder):
                os.popen("ln -s lib64 %s/lib" % targetFolder).readlines()

class tbb(make):
    ''' a make class to exclusively build intels TBB package
    since we need to handle the installation by ourselfs, we override
    installer() method'''
    cmd = ['make -j $DCORES']

    def installer(self, target, source, env):
        '''we use this method to do a custom tbb install 
        by copying files over.'''
        import pipe, build, os
        for n in range(len(self.buildFolder)):
            lines = os.popen( "rsync -avWpP $SOURCE_FOLDER/include/* $TARGET_FOLDER/include/ 2>&1" ).readlines()
            for SHLIBEXT in build.SHLIBEXT:
               lines += os.popen( "rsync -aW --delete $SOURCE_FOLDER/build/*_release/*%s* $TARGET_FOLDER/lib/ 2>&1" % (SHLIBEXT) ).readlines()
               lines += os.popen( "rsync -aW --delete $SOURCE_FOLDER/build/*_release/*%s* $TARGET_FOLDER/bin/ 2>&1" % (SHLIBEXT) ).readlines()
        return lines
