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
    cmd = 'make -j $DCORES && make install'
    _parallel=''
    _verbose=''
    _verbose_cmake=''
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
        if 'verbose' in kargs and kargs['verbose'] == 1:
            self._verbose = 'VERBOSE=1'
            self._verbose_cmake = '-DVERBOSE=1'

    def fixCMD(self, cmd, environ=[]):
        ''' cmake is kindy picky with environment variables and has lots of
        variables override to force it to find packages in non-usual places.
        So here we force some env vars and command line overrides to make sure
        cmake finds pipeVFX packages first!'''
        environ = [
            'export MAKE_PARALLEL="$(echo %s)"' % self._parallel,
            'export MAKE_VERBOSE="$(echo %s)"' % self._verbose,
            'export CMAKE_VERBOSE="$(echo %s)"' % self._verbose_cmake,
        ]
        return cmd


class cmake(make):
    ''' a class to handle cmake installs '''
    src = 'CMakeLists.txt'
    cmd = [
        'cmake $SOURCE_FOLDER -DCMAKE_INSTALL_PREFIX=$TARGET_FOLDER && '
        'make $MAKE_PARALLEL $MAKE_VERBOSE && make install'
    ]
    flags = [
            '-Wno-dev',
            '-DUSE_SIMD=0',
            '-DUSE_FFMPEG=0',
            '-DUSE_OPENCV=0',
#            '-DCMAKE_CC_COMPILER=$CC',
#            '-DCMAKE_CXX_COMPILER=$CXX',
#            '-DCMAKE_CPP_COMPILER=$CPP',
#            '-DCMAKE_CC_LINKER_PREFERENCE=$LD',
#            '-DCMAKE_CXX_LINKER_PREFERENCE=$LD',
#            '-DCMAKE_LINKER=$LD',
            '-DOPENIMAGEIOHOME=$OIIO_TARGET_FOLDER',
            '-DOIIO_INCLUDES=$OIIO_TARGET_FOLDER/include/',
            '-DOIIO_LIBRARIES=$OIIO_TARGET_FOLDER/lib/libOpenImageIO.so',
            '-DSTOP_ON_WARNING=0',
            '-DBoost_NO_SYSTEM_PATHS=1',
            '-DBoost_DETAILED_FAILURE_MSG=1',
            '-DBoost_USE_STATIC_LIBS=false',
#            '-DBoost_USE_MULTITHREADED=false',
#            '-DBoost_USE_STATIC_RUNTIME=false',
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

    def fixCMD(self, cmd, environ=[]):
        ''' cmake is kindy picky with environment variables and has lots of
        variables override to force it to find packages in non-usual places.
        So here we force some env vars and command line overrides to make sure
        cmake finds pipeVFX packages first!'''
        environ += [
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
        'cmake $SOURCE_FOLDER -DCMAKE_INSTALL_PREFIX=$TARGET_FOLDER && '
        'make $MAKE_PARALLEL $MAKE_VERBOSE  && make install',
        '( [ "$(basename $TARGET_FOLDER)" == "1.5.8" ] ',
        '( mkdir -p $TARGET_FOLDER/bin/',
        '  mkdir -p $TARGET_FOLDER/include/',
        '  mkdir -p $TARGET_FOLDER/lib/',
        '  mv -v $TARGET_FOLDER/alembic-$(basename $TARGET_FOLDER)/bin/* $TARGET_FOLDER/bin/',
        '  mv -v $TARGET_FOLDER/alembic-$(basename $TARGET_FOLDER)/include/* $TARGET_FOLDER/include/',
        '  mv -v $TARGET_FOLDER/alembic-$(basename $TARGET_FOLDER)/lib/* $TARGET_FOLDER/lib/',
        '  rm -rf $TARGET_FOLDER/alembic-$(basename $TARGET_FOLDER) '
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
            'python/PyAlembic/CMakeLists.txt' : [
                ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
                ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
                ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            ],
            'CMakeLists.txt' : [
                ('/alembic-${VERSION}',' '),
            ],
        },
    }

    def preSED(self, pkgVersion, lastlog):
        if float( '.'.join(pkgVersion.split('.')[:2]) ) < 1.60:
            from subprocess import Popen
            cmd = 'python ./build/bootstrap/alembic_bootstrap.py . > %s 2>&1' % lastlog
            proc = Popen(cmd, bufsize=-1, shell=True, executable='/bin/sh', env=self.os_environ, close_fds=True)
            proc.wait()

    def fixCMD(self, cmd):
        # update the buld environment with all the enviroment variables
        # specified in apps argument!
        environ = []

        pipe.version.set(python=self.os_environ['PYTHON_VERSION'])
        pipe.versionLib.set(python=self.os_environ['PYTHON_VERSION'])
        print bcolors.WARNING+": ", bcolors.BLUE+"  apps: ",
        if hasattr(self, 'apps'):
            for (app, version) in self.apps:
                className = str(app).split('.')[-1].split("'")[0]
                pipe.version.set({className:version})
                app = app()
                app.fullEnvironment()
                print "%s(%s)" % (className, version),
                # get all vars from app class and add to cmd environ
                for each in app:
                    if each not in ['LD_PRELOAD','PYTHON_VERSION','PYTHON_VERSION_MAJOR']:
                        v = app[each]
                        if type(v) == str:
                            v=[v]
                        if each not in self.os_environ:
                            self.os_environ[each] = ''
                        # if var value is paths
                        if 'ROOT' in each:
                            self.os_environ[each] = v[0]
                        elif '/' in str(v):
                            self.os_environ[each] = "%s:%s" % (self.os_environ[each], ':'.join(v))
                        else:
                            self.os_environ[each] = ' '.join(v)

            # remove python paths that are not the same version!
            for each in self.os_environ:
                if '/' in str(v):
                    cleanSearchPath = []
                    for path in self.os_environ[each].split(':'):
                        if not path.strip():
                            continue
                        if '/python' in path and self.os_environ['PYTHON_TARGET_FOLDER'] not in path:
                            pathVersion1 = path.split('/python/')[-1].split('/')[0].strip()
                            pathVersion2 = path.split('/python')[-1].split('/')[0].strip()
                            # print each, pathVersion1+'='+pathVersion2, path, self.os_environ['PYTHON_VERSION_MAJOR'], path.split('/python/')[-1].split('/')[0] != self.os_environ['PYTHON_VERSION_MAJOR'], path.split('/python')[-1].split('/')[0] != self.os_environ['PYTHON_VERSION_MAJOR']
                            if pathVersion1:
                                if pathVersion1 != self.os_environ['PYTHON_VERSION']:
                                    continue
                            if pathVersion2:
                                if pathVersion2 != self.os_environ['PYTHON_VERSION_MAJOR']:
                                    continue
                        cleanSearchPath.append(path)
                    self.os_environ[each] = ':'.join(cleanSearchPath)

        # self.os_environ['LD_PRELOAD'] = ''.join(os.popen("ldconfig -p | grep libstdc++.so.6 | grep x86-64 | cut -d'>' -f2").readlines()).strip()
        # self.os_environ['LD_PRELOAD'] += ':'+''.join(os.popen("ldconfig -p | grep libgcc_s.so.1 | grep x86-64 | cut -d'>' -f2").readlines()).strip()

        self.flags += [
            '-DUSE_PYALEMBIC=0', # disable python bindings
            '-DALEMBIC_PYTHON_ROOT=$PYTHON_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/config',
            '-DALEMBIC_PYTHON_LIBRARY=$PYTHON_TARGET_FOLDER/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DALEMBIC_SHARED_LIBS=1',
            '-DUSE_PRMAN=1',
            '-DUSE_MAYA=1',
            '-DBUILD_SHARED_LIBS:BOOL="TRUE"',
            '-DBUILD_STATIC_LIBS:BOOL="FALSE" ',
        ]

        cmd = cmd.replace('cmake', 'cmake  -DBUILD_SHARED_LIBS:BOOL="TRUE"  -DBUILD_STATIC_LIBS:BOOL="FALSE" ')

        return cmake.fixCMD(self, cmd, [
            'export PRMAN_ROOT=$PRMAN_ROOT/RenderManProServer-$PRMAN_VERSION'
        ])


class download(make):
    '''
    a simple class to download and uncompress packages, so they can be used by other packages for building
    the build is just copying over the uncompressed source to the target folder to be used later by other builds
    '''
    src='CMakeLists.txt'
    cmd=['mkdir -p $TARGET_FOLDER && cp -rfuv $SOURCE_FOLDER/* $TARGET_FOLDER/']
    # as we want this packages just to be used for building other packages, we don't need a installation target_folder
#    def installer(self, target, source, env):
#        os.system("rm -rf %s" % os.path.abspath(os.path.dirname(os.path.dirname(str(target[0])))) )


class glew(make):
    ''' a make class to exclusively build glew package
    glew requires a bunch of make calls to construct the source and build.
    also, it install its libs in the lib64 folder, so we use a custom
    installer method to create a link lib -> lib64'''
    cmd = ' && '.join([
#        './cmake-testbuild.sh'
#        'cd auto && make destroy && make && cd ..',
        'make GLEW_DEST=$TARGET_FOLDER install.all',
    ])
    sed = {
        '0.0.0' : {
            'config/Makefile.linux' : [
                ('lib64','lib'),
            ],
        },
    }
    def installer(self, target, source, env):
        ''' just a small installation patch to link lib64 to lib, which is the
        expected shared library folder name, since pipeVFX organize packages in
        arch specific hierarchy - linux/x86_64/package '''
        ret = []
        targetFolder = os.path.dirname(str(target[0]))
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
    def installer(self, target, source, env):
        ''' just a small installation patch to link lib64 to lib, which is the
        expected shared library folder name, since pipeVFX organize packages in
        arch specific hierarchy - linux/x86_64/package '''
        ret = []
        targetFolder = os.path.dirname(str(target[0]))
        if os.path.exists("%s/lib" % targetFolder):
            if os.path.exists("%s/lib64" % targetFolder):
                ret = os.popen("rm -rf  %s/lib" % targetFolder).readlines()
                ret = os.popen("ln -s lib64 %s/lib" % targetFolder).readlines()
        return ret



class tbb(make):
    ''' a make class to exclusively build intels TBB package
    since we need to handle the installation by ourselfs, we override
    installer() method'''
    cmd = ['make -j $DCORES ']

    def installer(self, target, source, env):
        '''we use this method to do a custom tbb install
        by copying files over.'''
        import build
        path = os.path.abspath( os.path.dirname(str(source[-1])) )
        target = os.path.abspath( os.path.dirname(str(target[0])) )
        for n in range(len(self.buildFolder)): #noqa
            lines = os.popen( "rsync -avWpP %s/include/* %s/include/ 2>&1" % (path, target)).readlines()
            for SHLIBEXT in build.SHLIBEXT:
                lines += os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/lib/ 2>&1" % (path, SHLIBEXT, target) ).readlines()
                lines += os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/bin/ 2>&1" % (path, SHLIBEXT, target) ).readlines()
        return lines
