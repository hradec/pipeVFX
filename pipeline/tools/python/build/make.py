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
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import pipe
import os,sys



class make(generic):
    ''' a class to handle make installs '''
    src = 'Makefile'
    cmd = ' make -j $DCORES && make install'
    _parallel=''
    _verbose=''
    _verbose_cmake=''
    flags=[]
    def __init__(self, args, name, download, baseLibs=None, env=None, depend={}, GCCFLAGS=[], sed=None, environ=[], compiler=gcc.system, **kargs):
        generic.__init__(self, args, name, download, baseLibs, env, depend, GCCFLAGS, sed, environ, compiler, **kargs)
        # some extra parameters to control log output and parallel building
        # default uses the double of cores to build,
        # 1 uses the number of cores and 0 builds single threaded
        self._parallel = '-j $DCORES'
        if 'parallel' in kargs and kargs['parallel'] == 0:
            self._parallel = ''
        if 'parallel' in kargs and kargs['parallel'] == 1:
            self._parallel = '-j $CORES'

        # default builds without verbose (nice and clean cmake output)
        # verbose=1 show the command lines in cmake
        self._verbose = ''
        self._verbose_cmake = ''
        if hasattr(self, 'verbose') and self.verbose>0:
            self._verbose = ' VERBOSE=1 '
            self._verbose_cmake = ' -DVERBOSE=1 '

    def fixCMD(self, cmd, os_environ, environ=[]):
        ''' cmake is kindy picky with environment variables and has lots of
        variables override to force it to find packages in non-usual places.
        So here we force some env vars and command line overrides to make sure
        cmake finds pipeVFX packages first!'''
        environ = [
            'export MAKE_PARALLEL="%s"' % self._parallel,
            'export MAKE_VERBOSE="%s"' % self._verbose,
            'export CMAKE_VERBOSE="%s"' % self._verbose_cmake,
        ]
        for each in self.flags:
            if 'make' in cmd and each.split('=')[0] not in cmd:
                cmd = cmd.replace('make','make '+each+' ')

        return cmd


class cmake(make):
    ''' a class to handle cmake installs '''
    src = 'CMakeLists.txt'
    cmd = [
        ' cmake $SOURCE_FOLDER -DCMAKE_INSTALL_PREFIX=$INSTALL_FOLDER && '
        ' make $MAKE_PARALLEL $MAKE_VERBOSE &&  make install'
    ]
    flags = [
            '-Wno-dev',
            '-DUSE_SIMD=0',
            '-DUSE_FFMPEG=0',
            '-DUSE_OPENCV=0',
            # '-DCMAKE_CC_COMPILER=$CC',
            # '-DCMAKE_CXX_COMPILER=$CXX',
            # '-DCMAKE_CPP_COMPILER=$CPP',
            '-DCMAKE_CC_FLAGS="$CFLAGS"',
            '-DCMAKE_CXX_FLAGS="$CXXFLAGS"',
            '-DCMAKE_CPP_FLAGS="$CPPFLAGS"',
            # '-DCMAKE_CC_LINKER_PREFERENCE=$LD',
            # '-DCMAKE_CXX_LINKER_PREFERENCE=$LD',
            # '-DCMAKE_LINKER=$LD',
            '-DOPENIMAGEIOHOME=$OIIO_TARGET_FOLDER',
            '-DOIIO_INCLUDES=$OIIO_TARGET_FOLDER/include/',
            '-DOIIO_LIBRARIES=$OIIO_TARGET_FOLDER/lib/libOpenImageIO.so',
            '-DSTOP_ON_WARNING=0',
            '-DBoost_NO_SYSTEM_PATHS=1',
            '-DBoost_DETAILED_FAILURE_MSG=1',
            '-DBoost_USE_STATIC_LIBS=false',
            # '-DBoost_USE_MULTITHREADED=false',
            # '-DBoost_USE_STATIC_RUNTIME=false',
            '-DLIBPYTHON_VERSION=$PYTHON_VERSION_MAJOR',
            '-DPYTHON_ROOT=$PYTHON_TARGET_FOLDER',
            '-DPYTHON_INCLUDE_DIR=$PYTHON_TARGET_FOLDER/include/python$PYTHON_VERSION_MAJOR/',
            '-DPYTHON_LIBRARY=$PYTHON_TARGET_FOLDER/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DBOOST_HOME=$BOOST_TARGET_FOLDER',
            '-DBOOST_ROOT=$BOOST_TARGET_FOLDER',
            '-DBOOST_INCLUDEDIR=$BOOST_TARGET_FOLDER/include',
            '''-DBOOST_LIBRARYDIR=$( if [ \"$(ls -l $BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ 2>/dev/null)\" == '' ] ; then ls -d  $BOOST_TARGET_FOLDER/lib/python* 2>/dev/null | tail -1 ; else echo $BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ ; fi)/ ''',
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            '$CMAKE_VERBOSE ',
            # '-DMAYA_ROOT=$MAYA_ROOT',
            # '-DARNOLD_ROOT=$ARNOLD_ROOT',
            # '-DPRMAN_ROOT=$PRMAN_ROOT',
            '-DOPENEXR_ROOT=$OPENEXR_TARGET_FOLDER',
            '-DILMBASE_HOME=$ILMBASE_TARGET_FOLDER',
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            # '''-DILMBASE_LIBRARIES=$(echo \"${ILMBASE_TARGET_FOLDER}/lib/libImath.so';'${ILMBASE_TARGET_FOLDER}/lib/libIex.so';'${ILMBASE_TARGET_FOLDER}/lib/libHalf.so';'${ILMBASE_TARGET_FOLDER}/lib/libIlmThread.so';'-lpthread\") '''
            '''-DILMBASE_LIBRARIES=$(echo \"${ILMBASE_TARGET_FOLDER}/lib/libImath.so;${ILMBASE_TARGET_FOLDER}/lib/libIex.so;${ILMBASE_TARGET_FOLDER}/lib/libHalf.so;${ILMBASE_TARGET_FOLDER}/lib/libIlmThread.so;-lpthread\") '''
            '-DPYILMBASE_ROOT=$PYILMBASE_TARGET_FOLDER',
            '-DPYILMBASE_LIBRARY_DIR=$PYILMBASE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            # '-DGCC_VERSION=%s' % pipe.build.distro.split('-')[-1],
            '-DGCC_VERSION=$GCC_VERSION',
            # we need libXmi and libXi from the main system
            "-DGLUT_Xmu_LIBRARY=$(echo $(ldconfig -p | grep 'libXmu.so ' | cut -d'>' -f2))",
            "-DGLUT_Xi_LIBRARY=$(echo $(ldconfig -p | grep 'libXi.so ' | cut -d'>' -f2))",
        ]

    def __init__(self, args, name, download, baseLibs=None, env=None, depend={}, GCCFLAGS=[], sed=None, environ=[], compiler=gcc.system, **kargs):
        make.__init__(self, args, name, download, baseLibs, env, depend, GCCFLAGS, sed, environ, compiler, **kargs)

    def fixCMD(self, cmd, os_environ, environ=[]):
        ''' cmake is kindy picky with environment variables and has lots of
        variables override to force it to find packages in non-usual places.
        So here we force some env vars and command line overrides to make sure
        cmake finds pipeVFX packages first!'''
        environ = [
            'export MAKE_PARALLEL="$(echo %s)"' % self._parallel,
            'export MAKE_VERBOSE="$(echo %s)"' % self._verbose,
            'export CMAKE_VERBOSE="$(echo %s)"' % self._verbose_cmake,
            'export HDF5_ROOT=$HDF5_TARGET_FOLDER',
            'export HDF5_INCLUDE_DIR=$HDF5_TARGET_FOLDER/include',
            'export HDF5_LIBRARIES=$HDF5_TARGET_FOLDER/lib/libhdf5.so',
            'export OPENEXR_INCLUDE_PATHS=$OPENEXR_TARGET_FOLDER/include',
            'export OPENEXR_LIBRARIES=$OPENEXR_TARGET_FOLDER/lib/libIlmImf.so',
            'export OPENIMAGEHOME=$OIIO_TARGET_FOLDER',
        ]
        for each in self.flags:
            if 'cmake' in cmd and each.split('=')[0] not in cmd:
                cmd = cmd.replace('cmake','cmake '+each+' ')

        if 'cmake' in cmd and os.environ.has_key('CMAKE_TARGET_FOLDER'):
            cmd = cmd.replace('cmake','$CMAKE_TARGET_FOLDER/bin/cmake')

        cmd = ' && '.join(environ)+" && "+cmd
        #cmd = 'find ./ -name CMakeCache.txt -exec rm -rf {} \; && '+cmd
        return cmd


class alembic(cmake):
    ''' a dedicated build class for alembic versions'''
    cmd = [
        ' cmake $SOURCE_FOLDER -DCMAKE_INSTALL_PREFIX=$INSTALL_FOLDER '
        ' && '
        ' make $MAKE_PARALLEL $MAKE_VERBOSE  &&  make install',
        '( [ "$(basename $TARGET_FOLDER)" == "1.5.8" ] ',
        '( mkdir -p $INSTALL_FOLDER/bin/',
        '  mkdir -p $INSTALL_FOLDER/include/',
        '  mkdir -p $INSTALL_FOLDER/lib/',
        '  mv -v $INSTALL_FOLDER/alembic-$(basename $TARGET_FOLDER)/* $INSTALL_FOLDER/',
        # '  mv -v $INSTALL_FOLDER/alembic-$(basename $TARGET_FOLDER)/bin/* $INSTALL_FOLDER/bin/',
        # '  mv -v $INSTALL_FOLDER/alembic-$(basename $TARGET_FOLDER)/include/* $INSTALL_FOLDER/include/',
        # '  mv -v $INSTALL_FOLDER/alembic-$(basename $TARGET_FOLDER)/lib/* $INSTALL_FOLDER/lib/',
        '  rm -rf $INSTALL_FOLDER/alembic-$(basename $TARGET_FOLDER) '
        ') || true )'
    ]
    # alembic has some hard-coded path to find python, and the only
    # way to make it respect the PYTHON related environment variables,
    # is to patch some files to force it!
    sed = {
        '1.5.0' : {
            'python/PyAbcOpenGL/CMakeLists.txt' : [
                ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
                ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
                ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            ],
            'python/PyAlembic/CMakeLists.txt' : [
                ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
                ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
                ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            ],
            'CMakeLists.txt' : [
                ('/alembic-${VERSION}',' '),
                ('.std.c..11',''),
            ],
            'maya/AbcImport/CMakeLists.txt' : [
                ('maya/plug-ins', 'maya/$ENV{MAYA_VERSION}/plugins'),
            ],
            'maya/AbcExport/CMakeLists.txt' : [
                ('maya/plug-ins', 'maya/$ENV{MAYA_VERSION}/plugins'),
            ],
            'arnold/Procedural/CMakeLists.txt' : [
                ('arnold/procedurals', 'arnold/$ENV{ARNOLD_VERSION}/procedurals'),
            ],
            'prman/Procedural/CMakeLists.txt' : [
                ('prman/procedurals', 'prman/$ENV{PRMAN_VERSION}/procedurals'),
            ],

        },
        '1.6.0' : {
            # 'python/PyAlembic/CMakeLists.txt' : [
            #     ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
            #     ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
            #     ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
            #     ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            # ],
            'CMakeLists.txt' : [
                ('/alembic-${VERSION}',' '),
            ],
        },
    }

    def preSED(self, pkgVersion, lastlog, os_environ):
        if float( '.'.join(pkgVersion.split('.')[:2]) ) < 1.60:
            from subprocess import Popen
            cmd = 'python ./build/bootstrap/alembic_bootstrap.py . > %s 2>&1' % lastlog
            proc = Popen(cmd, bufsize=-1, shell=True, executable='/bin/sh', env=os_environ, close_fds=True)
            proc.wait()

    def fixCMD(self, cmd, os_environ):
        # update the buld environment with all the enviroment variables
        # specified in apps argument!
        environ = []

        extra_flags = [
            '-Wno-dev',
            # '-DUSE_PYALEMBIC=0', # disable python bindings
            '-DUSE_PYALEMBIC=1',
            '-DALEMBIC_PYILMBASE_ROOT=$PYILMBASE_TARGET_FOLDER/',
            '-DALEMBIC_PYILMBASE_MODULE_DIRECTORY=$PYILMBASE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/',
            '-DALEMBIC_PYILMBASE_PYIMATH_MODULE=$PYILMBASE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/imathmodule.so',
            '-DALEMBIC_PYILMBASE_INCLUDE_DIRECTORY=$PYILMBASE_TARGET_FOLDER/include/OpenEXR/',
            '-DPYILMBASE_LIBRARY_DIR=$PYILMBASE_TARGET_FOLDER/lib/',
            '-DALEMBIC_PYTHON_ROOT=$PYTHON_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/config',
            '-DALEMBIC_PYTHON_LIBRARY=$PYTHON_TARGET_FOLDER/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DPYTHON_INCLUDE_DIRS=$PYTHON_TARGET_FOLDER/include',
            '-DPYTHON_EXECUTABLE=$PYTHON_ROOT/bin/python',
            '-DBOOST_ROOT=$BOOST_TARGET_FOLDER/',
            '-DBOOST_LIBRARYDIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            '-DBoost_NO_SYSTEM_PATHS=1',
            '-DBoost_PYTHON_LIBRARY=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/libboost_python.so',
            '-DBoost_USE_MULTITHREADED=0',
            '-DBoost_USE_STATIC_LIBS=0',
            # '-DBOOST LIBRARIES="$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/libboost_thread.so:$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/libboost_program_options.so"',
            '-DALEMBIC_SHARED_LIBS=1',
            '-DALEMBIC_LIB_USES_BOOST=1',
            '-DBUILD_SHARED_LIBS:BOOL="TRUE"',
            '-DBUILD_STATIC_LIBS:BOOL="FALSE" ',
            "-DUSE_HDF5=ON",
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            '-DOPENEXR_ROOT=$OPENEXR_TARGET_FOLDER',
        ]

        cmd = cmd.replace('cmake', 'cmake  -DBUILD_SHARED_LIBS:BOOL="TRUE"  -DBUILD_STATIC_LIBS:BOOL="FALSE" ')

        for each in self.flags+extra_flags:
            if 'cmake' in cmd and each.split('=')[0] not in cmd:
                cmd = cmd.replace('cmake','cmake '+each+' ')

        return cmake.fixCMD(self, cmd, os_environ, [
            'export PRMAN_ROOT=$PRMAN_ROOT/RenderManProServer-$PRMAN_VERSION'
        ])


class download(make):
    '''
    a simple class to download and uncompress packages, so they can be used by other packages for building
    the build is just copying over the uncompressed source to the target folder to be used later by other builds
    '''
    src='CMakeLists.txt'
    cmd=['mkdir -p $INSTALL_FOLDER ; cp -rfuv $SOURCE_FOLDER/* $INSTALL_FOLDER/ && echo $? && echo Done']
    # this package will finih pretty fast!
    noMinTime=True

class displayDB(make):
    '''
    a simple class to display the DB after all builds
    '''
    src='CMakeLists.txt'
    cmd=['mkdir -p $INSTALL_FOLDER ; cp -rfuv $SOURCE_FOLDER/* $INSTALL_FOLDER/ && echo $? && echo Done']
    # this package will finih pretty fast!
    noMinTime=True



class glew(make):
    ''' a make class to exclusively build glew package
    glew requires a bunch of make calls to construct the source and build.
    also, it install its libs in the lib64 folder, so we use a custom
    installer method to create a link lib -> lib64'''
    cmd = ' && '.join([
#        './cmake-testbuild.sh'
#        'cd auto && make destroy && make && cd ..',
        ' make CC="$CC" CFLAGS="$CFLAGS -Iinclude" GLEW_DEST=$INSTALL_FOLDER install.all',
    ])
    sed = {
        '0.0.0' : {
            'config/Makefile.linux' : [
                ('lib64','lib'),
            ],
        },
    }
    def installer(self, target, source, os_environ):
        ''' just a small installation patch to link lib64 to lib, which is the
        expected shared library folder name, since pipeVFX organize packages in
        arch specific hierarchy - linux/x86_64/package '''
        ret = []
        targetFolder = os_environ['INSTALL_FOLDER']
        versionMajor = float( os_environ['VERSION_MAJOR'] )
        if not os.path.exists("%s/lib" % targetFolder):
            if os.path.exists("%s/lib64" % targetFolder):
                ret = os.popen("ln -s lib64 %s/lib" % targetFolder).readlines()
        return ret

class glfw(cmake):
    ''' a make class to exclusively build glfw package
    coz it install its libs in the lib64 folder, so we use a custom
    installer method to create a link lib -> lib64'''
    # sed = {
    #     '0.0.0' : {
    #         'config/Makefile.linux' : [
    #             ('lib64','lib'),
    #         ],
    #     },
    # }
    def installer(self, target, source, os_environ):
        ''' just a small installation patch to link lib64 to lib, which is the
        expected shared library folder name, since pipeVFX organize packages in
        arch specific hierarchy - linux/x86_64/package '''
        ret = []
        targetFolder = os_environ['INSTALL_FOLDER']
        versionMajor = float( os_environ['VERSION_MAJOR'] )
        if os.path.exists("%s/lib" % targetFolder):
            if os.path.exists("%s/lib64" % targetFolder):
                ret = os.popen("rm -rf  %s/lib" % targetFolder).readlines()
                ret = os.popen("ln -s lib64 %s/lib" % targetFolder).readlines()
        return ret



class tbb(make):
    ''' a make class to exclusively build intels TBB package
    since we need to handle the installation by ourselfs, we override
    installer() method'''
    cmd = [' make -j $DCORES ']

    def installer(self, target, source, os_environ):
        '''we use this method to do a custom tbb install
        by copying files over.'''
        import build
        lines = []
        sourceFolder = os_environ['SOURCE_FOLDER']
        targetFolder = os_environ['INSTALL_FOLDER']
        versionMajor = float( os_environ['VERSION_MAJOR'] )
        lines += os.popen( "rsync -avWpP %s/include/* %s/include/ 2>&1" % (sourceFolder, targetFolder)).readlines()
        for SHLIBEXT in build.SHLIBEXT:
            lines += os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/lib/ 2>&1" % (sourceFolder, SHLIBEXT, targetFolder) ).readlines()
            lines += os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/bin/ 2>&1" % (sourceFolder, SHLIBEXT, targetFolder) ).readlines()
        return lines
