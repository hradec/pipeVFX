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
from pipe.bcolors import bcolors


class configure(generic):
    ''' a generic build class to build packages with configure scripts and make'''
    src = 'configure'
    cmd = [
        './configure  --enable-shared',
        'make -j $DCORES',
        'make -j $DCORES install',
    ]

    def fixCMD(self, cmd):
        if 'configure' in cmd and '--prefix=' not in cmd:
            cmd = cmd.replace('configure', 'configure --prefix=$TARGET_FOLDER ')
        if 'configure' in cmd and self.name not in ['zlib','binutils','cmake', 'qt']:
            cmd = cmd.replace('configure', 'configure --disable-werror ')
        if 'parallel' not in self.kargs or self.kargs['parallel'] == 1:
            if 'make' in cmd and 'cmake' not in cmd:
                if not '-j' in cmd:
                    cmd = cmd.replace('make', "make -j $DCORES")
                    # cmd = cmd.replace('make', "make CC=$CC CXX=$CXX CFLAGS='$CFLAGS' CXXFLAGS='$CXXFLAGS' ")
        return cmd


class gccBuild(configure):
    ''' build class designed to build differente versions of GCC '''
    # we're using a tarball for 4.1.2 made on arch linux, since
    # building it in centos makes some shared libraries build
    # fail complaining about the need of -fPIC on objects.
    # It only happens when building gcc 4.1.2 in centos 7 (gcc 4.8.5)
    # Until we can figure out and fix the build in centos, we're
    # relying in this 4.1.2 binary tarball.
    use_bin_tarball = 1

    src = 'configure'
    cmd = [
        './configure  --enable-shared',
        'make -j $DCORES',
        'make -j $DCORES install',
    ]
    # sed = {'4.1.2' : {
    #     # disable -fvisibility-inlines-hidden since it causes a
    #     # lot of issues with shared libraries (it will always be disabled)
    #     'gcc/c-opts.c' : [
    #         ('visibility_options.inlines_hidden = value', 'visibility_options.inlines_hidden = 0')
    #     ],
    # }}
    # sed = {'4.8.3' : {
    #     'gmp-4.3.2/configure.in' : [
    #         ('M4.m4.not.required','M4=m4')
    #     ],
    #     'gmp-4.3.2/configure' : [
    #         ('M4.m4.not.required','M4=m4')
    #     ],
    # }},

    def uncompressor( self, target, source, env):
        ''' we just need this for the 4.1.2 binary tarball!'''
        t = os.path.abspath(str(target[0]))
        v = '.'.join(os.path.basename(os.path.dirname(t)).split('-')[-1].split('.')[:2])
        if self.use_bin_tarball and float(v) == 4.1:
            # change the target for the gcc 4.1.2 version, since we're using
            # a binary tarball
            tt = '/'.join([os.path.dirname(t),'bin'])
            configure.uncompressor( self, [tt], source, env)
        else:
            configure.uncompressor( self, target, source, env)

    def fixCMD(self, cmd):
        if self.versionMajor == 4.1:
            if self.use_bin_tarball:
                cmd = 'cp -ruvf ./* $TARGET_FOLDER/'
            else:
                cmd = ' && '.join([
                    # got this build options for arch AUR-mirror for gcc 4.1
                    # " sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in",
                    ''' sed -i -e 's@\./fixinc\.sh@-c true@' gcc/Makefile.in ''',
                    ''' sed -i -e 's/echo \$ldver |/echo \$ldver | cut -d"\)" -f2 | /' ./libstdc++-v3/configure''', # fix wrong LD version detection
                    # 'export CFLAGS="-fgnu89-inline -g -O2 $CFLAGS"',
                    # 'export CXXFLAGS="-fgnu89-inline -g -O2 $CXXFLAGS"',
                    "mkdir -p build",
                    'source scl_source enable devtoolset-6',
                    'export CC="$CC -fgnu89-inline -fPIC -O2"',
                    'export CXX="$CC -fgnu89-inline -fPIC -O2"',
                    "cd build",
                    '../configure  --prefix=$TARGET_FOLDER '
                        '--mandir=$TARGET_FOLDER/share/man '
                        '--libdir=$TARGET_FOLDER/lib '
                        '--infodir=$TARGET_FOLDER/share/info '
                        '--libexecdir=$TARGET_FOLDER/lib '
                        '--enable-languages=c,c++ '
                        '--enable-__cxa_atexit  '
                        '--disable-multilib '
                        '--enable-clocale=gnu '
                        '--disable-libstdcxx-pch '
                        '--disable-werror '
                        '--enable-threads=posix '
                        '--enable-version-specific-runtime-libs '
                        '--enable-checking=release '
                        '--program-suffix=-$(basename $TARGET_FOLDER)',
                    # 'sed -i.bak -e "s/CC = gcc/CC = gcc -fgnu89-inline/" -e "s/CXX = g++/CXX = g++ -fgnu89-inline/" Makefile',
                    'make -j $DCORES',
                    'make install',
                ])

        elif self.versionMajor == 4.8:
            # extract from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gcc48
            distroSpecific = []
            distroSpecificConfigure = ''
            if 'arch' in pipe.distro:
                distroSpecific = [
                    # Do not run fixincludes
                    "sed -i -e 's@\./fixinc\.sh@-c true@' 'gcc/Makefile.in'",
                    # fix build with GCC 6
                    "curl -L -s 'https://aur.archlinux.org/cgit/aur.git/plain/gcc-4.9-fix-build-with-gcc-6.patch?h=gcc48' | sed 's/--- a/--- ./g' | sed 's/+++ b/+++ ./g' | patch -p1",
                    # Arch Linux installs x86_64 libraries /lib
                    "sed -i -e '/m64=/s/lib64/lib/' 'gcc/config/i386/t-linux64'",
                    # hack! - some configure tests for header files using "$CPP $CPPFLAGS"
                    "sed -i -e '/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/' {libiberty,gcc}/configure",
                    # installing libiberty headers is broken
                    # http://gcc.gnu.org/bugzilla/show_bug.cgi?id=56780#c6
                    # "sed -i -e 's#@target_header_dir@#libiberty#' 'libiberty/Makefile.in'",
                ]
                distroSpecificConfigure = ' '.join([
                    '--disable-libstdcxx-pch '
                    '--disable-libunwind-exceptions '
                    '--disable-multilib '
                    '--disable-werror '
                    '--enable-__cxa_atexit '
                    '--enable-checking=release '
                    '--enable-clocale=gnu '
                    '--enable-cloog-backend=isl '
                    '--enable-gnu-unique-object '
                    '--enable-gold '
                    '--enable-languages="c,c++" '
                    '--enable-plugin '
                    '--enable-fdpic '
                    '--enable-shared '
                    '--enable-threads=posix '
                    '--enable-version-specific-runtime-libs '
                    '--infodir="$TARGET_FOLDER/share/info" '
                    '--libdir="$TARGET_FOLDER/lib" '
                    '--libexecdir="$TARGET_FOLDER/lib" '
                    '--mandir=$TARGET_FOLDER/share/man '
                    "--program-suffix=$(basename $TARGET_FOLDER) "
                    "--with-ppl "
                    "--with-system-zlib "
                ])


            cmd = ' && '.join(distroSpecific+[
                # "./contrib/download_prerequisites",
                "mkdir -p build",
                "cd build",
                "ulimit -s 32768",
                '../configure '
                        '--disable-multilib '
                        '--disable-werror '
                        '--enable-languages="c,c++" '
                        "--with-ppl "
                        '--disable-werror '
                        '--enable-fdpic '
                        "--with-system-zlib "
                        '--with-gmp=$GMP_TARGET_FOLDER '
                        '--with-mpfr=$MPFR_TARGET_FOLDER '
                        '--with-mpc=$MPC_TARGET_FOLDER '
                        '--infodir="$TARGET_FOLDER/share/info" '
                        '--libdir="$TARGET_FOLDER/lib" '
                        '--libexecdir="$TARGET_FOLDER/lib" '
                        '--mandir=$TARGET_FOLDER/share/man '
                        "--program-suffix=$(basename $TARGET_FOLDER) "
                        "%s --prefix=$TARGET_FOLDER " % distroSpecificConfigure,
                'make -j $DCORES',
                'make install',
            ])
        else:
            cmd = ' && '.join([
                "mkdir -p build",
                "cd build",
                '../configure  --prefix=$TARGET_FOLDER '
                    '--mandir=$TARGET_FOLDER/share/man '
                    '--libdir=$TARGET_FOLDER/lib '
                    '--infodir=$TARGET_FOLDER/share/info '
                    '--libexecdir=$TARGET_FOLDER/lib '
                    '--enable-languages=c,c++ '
                    '--enable-__cxa_atexit  '
                    '--disable-multilib '
                    "--with-ppl "
                    '--enable-clocale=gnu '
                    '--disable-libstdcxx-pch '
                    '--enable-fdpic '
                    '--disable-werror '
                    '--enable-shared '
                    '--enable-threads=posix '
                    '--enable-version-specific-runtime-libs '
                    '--enable-checking=release '
                    "--with-system-zlib "
                    '--with-gmp=$GMP_TARGET_FOLDER '
                    '--with-mpfr=$MPFR_TARGET_FOLDER '
                    '--with-mpc=$MPC_TARGET_FOLDER '
                    '--program-suffix=-$(basename $TARGET_FOLDER)',
                'make -j $DCORES',
                'make install',
            ])

        # make sure we're using the distros GCC to build GCC
        cmd = ';'.join([
            'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin"',
            'unset LD_LIBRARY_PATH',
            cmd
        ])
        return cmd

    def installer(self, target, source, env): # noqa
        targetFolder = os.path.dirname(str(target[0]))
        versionMajor = float( '.'.join( os.path.basename(targetFolder).split('.')[:2] ) )
        ret = []
        for each in glob("%s/bin/*" % targetFolder):
            each = os.path.basename(each)
            if 'linux-gnu' not in each:
                if versionMajor == 4.1:
                    ret += os.popen( "ln -s %s %s/bin/%s 2>&1" % (each, targetFolder, each.split('-')[0]) ).readlines()
                if versionMajor == 4.8:
                    ret += os.popen( "ln -s %s %s/bin/%s 2>&1" % (each, targetFolder, ''.join( [ c for c in each if not c.isdigit() and c not in ['.'] ] )) ).readlines()
                else:
                    ret += os.popen( "ln -s %s %s/bin/%s 2>&1" % (each, targetFolder, each.split('-')[0]) ).readlines()

            # we add a couple of wrappers to ar and ranlib, so we don't have to build then.
            # the wrapper make sure they can load the correct libstdc++ from system
            ret += os.popen( 'echo "LD_LIBRARY_PATH=/usr/lib:\\$LD_LIBRARY_PATH /usr/sbin/ar \\$@" > %s/bin/ar ; chmod a+x %s/bin/ar' % (targetFolder,targetFolder) ).readlines()
            ret += os.popen( 'echo "LD_LIBRARY_PATH=/usr/lib:\\$LD_LIBRARY_PATH /usr/sbin/ranlib \\$@" > %s/bin/ranlib ; chmod a+x %s/bin/ranlib' % (targetFolder,targetFolder) ).readlines()
        return ret



class openssl(configure):
    ''' a make class to exclusively build openssl package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    src='config'
    cmd=[
        # './config no-shared no-idea no-mdc2 no-rc5 zlib enable-tlsext no-ssl2 --prefix=$TARGET_FOLDER',
        # 'make depend && make && make install',
        '''echo "OPENSSL_$(basename $TARGET_FOLDER | awk -F'.' '{print $1.$2.$3}') { global: *;};" | tee ./openssl.ld''',
        '''echo "OPENSSL_$(basename $TARGET_FOLDER | awk -F'.' '{print $1.$2.0}') { global: *;};" | tee -a ./openssl.ld''',
        './config shared enable-tlsext --prefix=$TARGET_FOLDER -Wl,--version-script=$(pwd)/openssl.ld -Wl,-Bsymbolic-functions',
        'make && make install',
    ]
    def installer(self, target, source, env): # noqa
        targetFolder = os.path.dirname(str(target[0]))
        ret = ''
        # ret = os.popen("ln -s libssl.so %s/lib/libssl.so.10" % targetFolder).readlines()
        # ret += os.popen("ln -s libcrypto.so %s/lib/libcrypto.so.10" % targetFolder).readlines()
        return ret


class freetype(configure):
    ''' a make class to exclusively build freetype package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    def installer(self, target, source, env): # noqa
        ret = []
        t = os.path.dirname(str(target[0]))
        if os.path.exists( "%s/include/freetype2" % t):
            if not os.path.exists( "%s/include/freetype" % t):
                ret = os.popen("ln -s freetype2 %s/include/freetype" % t).readlines()
        return ret



class boost(configure):
    ''' A build class to build different versions of BOOST library
    the patch links can be found at: http://www.boost.org/patches/
    '''
    src = './bootstrap.sh'
    def fixCMD(self, cmd):
        # generic build command for versions 1.58 and up
        cmd = [
            './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
            './b2 -j $CORES variant=release cxxflags="-fPIC -fpermissive -D__AA__USE_BSD $CPPFLAGS" linkflags="$LDFLAGS" -d+2 install',
        ]
        # if version is below 1.58, use this build commands
        if self.versionMajor < 1.58 and  self.versionMajor > 1.55 :
            cmd = [
                './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER ',
                'echo -e "using gcc : : $CXX : <archiver>$AR ;"  > ./user-config.jam && cp ./user-config.jam ./user-config2.jam ',
                './b2 -j $CORES  --without-log threading=multi  variant=release  --user-config=./user-config.jam cxxflags="-fPIC -fpermissive  -D__AA__USE_BSD $CPPFLAGS " linkflags="$LDFLAGS" -d+2 --without-mpi -sICU_PATH=/tmp -sNO_BZIP2=1  -q --layout=tagged  --debug-configuration install',
                # './b2 -j $DCORES --user-config=./user-config.jam cxxflags="-fPIC  -D__AA__USE_BSD $CPPFLAGS -std=gnu++11" linkflags="$LDFLAGS" -d+2 install',
            ]


        if self.versionMajor == 1.58:
            cmd = [
                "curl -L -s 'http://www.boost.org/patches/1_58_0/0001-Fix-exec_file-for-Python-3-3.4.patch'            | sed 's/--- a/--- ./g' | sed 's/+++ b/+++ ./g' | patch -p1",
                "curl -L -s 'http://www.boost.org/patches/1_58_0/0002-Fix-a-regression-with-non-constexpr-types.patch' | sed 's/--- a/--- ./g' | sed 's/+++ b/+++ ./g' | patch -p1",
            ] + cmd

        if self.versionMajor == 1.55:
            cmd = [
                "curl -L -s 'http://www.boost.org/patches/1_55_0/001-log_fix_dump_avx2.patch' | sed 's/libs/.\/libs/g'| patch -p1",
                './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
                './b2 -j $CORES  --without-log  threading=multi  variant=release  cxxflags="-fPIC -fpermissive  -D__GLIBC_HAVE_LONG_LONG -D__AA__USE_BSD $CPPFLAGS" linkflags="$LDFLAGS" -d+2 install',
            ]

        if self.versionMajor == 1.54:
            cmd = [
                "curl -L -s 'http://www.boost.org/patches/1_54_0/001-coroutine.patch' | sed 's/1_54_0/./g' | patch -p1",
                "curl -L -s 'http://www.boost.org/patches/1_54_0/002-date-time.patch' | sed 's/1_54_0/./g' | patch -p1",
                "curl -L -s 'http://www.boost.org/patches/1_54_0/003-log.patch'       | sed 's/1_54_0/./g' | patch -p1",
                "curl -L -s 'http://www.boost.org/patches/1_54_0/004-thread.patch'    | sed 's/1_54_0/./g' | patch -p1",
                './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
                './b2 -j $CORES  --without-log  variant=release cxxflags="-fPIC -fpermissive  -D__GLIBC_HAVE_LONG_LONG -D__AA__USE_BSD $CPPFLAGS" linkflags="$LDFLAGS" -d+2 install',
            ]

        if self.versionMajor == 1.51:
            cmd = [
                './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
                './b2 -j $CORES   variant=release cxxflags="-fPIC -fpermissive  -D__GLIBC_HAVE_LONG_LONG -D__AA__USE_BSD $CPPFLAGS" linkflags="$LDFLAGS" -d+2 install',
            ]



        # if we need to build with system gcc
        if self.versionMajor in []:
            cmd = [
                "export PATH=$(echo $PATH | sed 's/gcc.4.1.2.bin//g')",
            ] + cmd

        return ' && '.join(cmd)

#    def installer(self, target, source, env):
#        os.popen("rm -rf %s/lib/python*/*.a" % env['TARGET_FOLDER']).readlines()



class python(configure):
    ''' a dedicated build class to build differente versions of python '''
    sed = {'0.0.0' :{
        'setup.py' : [("ndbm_libs = \[", "ndbm_libs = \['gdbm', 'gdbm_compat',")],
        'Modules/Setup.dist' : [
            ('#_socket socketmodule.c','_socket socketmodule.c'),
            ('#SSL','SSL'),
            ('#_ssl _ssl','_ssl _ssl'),
            ('#	-DUSE_SSL','	-DUSE_SSL'),
            ('#	-L..SSL','	-L$(SSL'),
        ],

    }}
    cmd = [
        'env',
        'LD_LIBRARY_PATH=/usr/lib64:/usr/lib:$LD_LIBRARY_PATH wget "http://bootstrap.pypa.io/ez_setup.py"',
        './configure  --enable-shared --enable-unicode=ucs4',
        '''for mfile in $(find . -name 'Makefile'); do sed -i 's/SHLIB_LIBS =/SHLIB_LIBS = -ltinfo/g' "$mfile" ; done''',
        'make -j $DCORES',
        'make -j $DCORES install',
        '( [ ! -e  $TARGET_FOLDER/bin/easy_install ] && $TARGET_FOLDER/bin/python$PYTHON_VERSION_MAJOR ./ez_setup.py || true)',
        'ln -s python$PYTHON_VERSION_MAJOR  $TARGET_FOLDER/bin/python || true',
        'ln -s python3.7$PYTHON_VERSION_MAJOR-config  $TARGET_FOLDER/bin/python-config || true',
        "[ $( echo $PYTHON_VERSION_MAJOR | awk -F'.' '{print $1}') -lt 3 ] && $TARGET_FOLDER/bin/easy_install hashlib || true",
        '( [ ! -e  $TARGET_FOLDER/bin/pip$PYTHON_VERSION_MAJOR ] && $TARGET_FOLDER/bin/easy_install pip || true)',
        'ln -s pip$PYTHON_VERSION_MAJOR  $TARGET_FOLDER/bin/pip || true',
        "( [ $( echo $PYTHON_VERSION_MAJOR | awk -F'.' '{print $1}') -lt 3 ] && $TARGET_FOLDER/bin/pip install  readline || true)",
        # '$TARGET_FOLDER/bin/easy_install scons',
    ]
    def fixCMD(self, cmd):
        cmd = configure.fixCMD(self,cmd)
        if self.kargs.has_key('easy_install'):
            for each in self.kargs['easy_install']:
                cmd += ' && $TARGET_FOLDER/bin/easy_install %s ' % each
        if self.kargs.has_key('pip'):
            for each in self.kargs['pip']:
                if int(pipe.apps.version.get('python').split('.')[0]) < 3 or 'PyOpenGL-accelerate' not in each:
                    cmd += ' && $TARGET_FOLDER/bin/pip install %s ' % each
        return cmd

    # def installer(self, target, source, env): # noqa
    #     ''' create the bin apps without the version numbers '''
    #     ret=[]
    #     for each in ['python', 'pip']:
    #             ret += os.popen( 'sudo ln -s %s$PYTHON_VERSION_MAJOR  $TARGET_FOLDER/bin/%s' % (each, each) ).readlines()
    #     return ret


class cortex(configure):
    ''' a build class to exclusively build differente versions of cortex-vfx package
    its a good example on a class that uses SCons to build'''
    src='SConstruct'
    environ = {
    }
    cmd=[
        'scons OPTIONS=%s/cortex.options.py -j $DCORES'         % os.path.abspath( os.path.dirname(__file__)),
        'scons OPTIONS=%s/cortex.options.py -j $DCORES'         % os.path.abspath( os.path.dirname(__file__)),
        # 'scons OPTIONS=%s/cortex.options.py -j $DCORES install' % os.path.abspath( os.path.dirname(__file__)),
    ]
    apps=[]
    sconsInstall=""
    # cortex patches
    sed = { "0.0.0" : {
        # patch IECoreRI to build with prman 20!
        'src/IECoreRI/RendererImplementation.cpp' : [
            ('RiProceduralV( data, riBound, procSubdivide, procFree, 1, tokens, values );','''
                // prman 20.2 doesn't have RiProceduralV, only RiProcedural2V. So for now, just revert to RiProcedural as workaroud
                #ifdef RiProceduralV
                                RiProceduralV( data, riBound, procSubdivide, procFree, 1, tokens, values );
                #else
                                RiProcedural( data, riBound, procSubdivide, procFree );
                #endif'''
            ),('// RiProcDelayedReadArchive','''
                // prman 20.2 doesn't have RiProcFree anymore, so just use c++ free in its place
                #ifndef RiProcFree
                                #define RiProcFree free
                #endif
                // RiProcDelayedReadArchive'''
            ),
        ],
        # fixes to option vars being treated as strings or lists.
        'SConstruct' : [
            ('houdiniEnv.Prepend( SHLINKFLAGS = "$HOUDINI_LINK_FLAGS" )', 'houdiniEnv.Prepend( SHLINKFLAGS = ["$HOUDINI_LINK_FLAGS"] )'),
            ('CPPFLAGS = "-DIECOREALEMBIC_WITH_OGAWA"', 'CPPFLAGS = ["-DIECOREALEMBIC_WITH_OGAWA"]'),
            ('testEnv.Prepend( CXXFLAGS = " ".join( dependencyIncludes ) )', 'testEnv.Prepend( CXXFLAGS = dependencyIncludes )'),
            # ('riTestEnv.Depends( riTest, [ corePythonModule + riPythonProceduralForTest + riDisplayDriverForTest ] )',''),
            # ('glTestEnv.Depends( glTest, corePythonModule )',''),
            # ('mayaPluginEnv.Depends( mayaPlugin, corePythonModule )',''),
            # ('nukePythonModuleEnv.Depends( nukePythonModule, corePythonModule )',''),
            # ('houdiniPluginEnv.Depends( houdiniPlugin, corePythonModule )',''),
            # ('truelightPythonModuleEnv.Depends( truelightPythonModule, corePythonModule )',''),
            # ('truelightEnv.Depends( truelightLibrary, coreLibrary )',''),
            # ('corePythonModule + riPythonProceduralForTest + riDisplayDriverForTest','riPythonProceduralForTest + riDisplayDriverForTest'),
            # ('Default(', '#Default('),
        ],
        'mel/IECoreMaya/ieProceduralHolder.mel' : [
            ('return $node;','''
                addAttr -ln "rman__torattr___preShapeScript"  -dt "string"  $node;
                setAttr -e-keyable true ($node+".rman__torattr___preShapeScript");
                setAttr -type "string" ($node+".rman__torattr___preShapeScript") "python(\\"import IECoreMaya;IECoreMaya.ieExportPythonProcedural()\\")";

                return $node;
            ''')
        ],
        'python/IECoreMaya/__init__.py' : [
            ('from FnSceneShape import FnSceneShape','''from FnSceneShape import FnSceneShape;from ieRMS import *''')
        ],
        'python/IECoreMaya/ieRMS.py' : [
            ('','''def ieExportPythonProcedural():
                import IECore
                import IECoreRI
                import IECoreMaya
                import maya.cmds as m
                from maya.mel import eval as meval
                import os


                bb = IECore.Box3f( IECore.V3f( 999999 ), IECore.V3f( 999999 ) )
                converter = IECoreMaya.FromMayaDagNodeConverter.create('genericShape')
                proc = converter.convert()
                serialize = IECore.ParameterParser().serialise(proc.parameters(), proc.parameters().getValue())
                pythonString = "IECoreRI.executeProcedural( '%s', %s, %s )" % (proc.path, proc.version, serialize)
                meval('RiProcedural "DynamicLoad" "iePython" %f %f %f %f %f %f "%s";'  % (bb.min[0], bb.max[0], bb.min[1], bb.max[1], bb.min[2], bb.max[2], pythonString ))
            ''')
        ],



    }}


    @staticmethod
    def noIECoreSED():
        self = cortex
        # noIECoreSED adds some extra patches to SConstruct to avoid re-building IECore, IECorePython, IECoreGL
        noIECoreSED = {}
        for v in self.sed:
            noIECoreSED[v] = self.sed[v].copy()
            for each in self.sed[v]:
                noIECoreSED[v][each] = []
                noIECoreSED[v][each].extend( self.sed[v][each] )
                if each == 'SConstruct':
                    noIECoreSED[v][each] += [
                        ('coreLibrary = ','coreLibrary = "" #'),
                        ('corePythonLibrary = ','corePythonLibrary = "" #'),
                        ('corePythonModule = ','corePythonModule = [] #'),
                        ('glLibrary = ','glLibrary = "" #'),
                        ('glPythonModule = ','glPythonModule = [] #'),
                        ('Default. coreLibrary','#Default( coreLibrary'),
                        ('Default. . glLibrary','#Default( [ glLibrary'),
                        ('INSTALL_PYTHON_DIR/IECoreMaya',    'INSTALL_MAYAPYTHON_DIR/IECoreMaya'),
                        ('INSTALL_PYTHON_DIR/IECoreHoudini', 'INSTALL_HOUDINIPYTHON_DIR/IECoreHoudini'),
                        ('INSTALL_PYTHON_DIR/IECoreMantra',  'INSTALL_HOUDINIPYTHON_DIR/IECoreMantra'),
                        ('INSTALL_PYTHON_DIR/IECoreRI',      'INSTALL_RMANPYTHON_DIR/IECoreRI'),
                        ('INSTALL_PYTHON_DIR/IECoreAlembic', 'INSTALL_ALEMBICPYTHON_DIR/IECoreAlembic'),
                        ('# Documentation options',
                            'o.Add("INSTALL_MAYAPYTHON_DIR","","")\n'
                            'o.Add("INSTALL_HOUDINIPYTHON_DIR","","")\n'
                            'o.Add("INSTALL_PRMANPYTHON_DIR","","")\n'
                            'o.Add("INSTALL_ALEMBICPYTHON_DIR","","")\n'
                            'o.Add("INSTALL_RMANPYTHON_DIR","","")\n'
                            '# Documentation options'
                        )
                    ]
        return noIECoreSED

    def init(self):
        ''' we make sure to setup the right python version for the app version, according to
        what pipeVFX tells us, only if building without baseLibs'''
        if self.baseLibs == None:
            if self.apps:
                import build
                app, version = self.apps
                className = str(app).split('.')[-1].split("'")[0]
                # now set the version of the apps
                pipe.version.set( {className : version} )
                # and create an app class
                app = pipe.apps.baseApp(className)

                # fix dependency version to the app default version!
                for lib in ['python']:
                    self.download = build.cortex.pkg(self.download, [ d for d in self.depend if d.name==lib ][0], pipe.libs.version.get(lib))

    def fixCMD(self, cmd):
        # update the buld environment with all the enviroment variables
        # specified in apps argument!
        pipe.version.set(python=self.os_environ['PYTHON_VERSION'])
        pipe.versionLib.set(python=self.os_environ['PYTHON_VERSION'])
        print bcolors.WARNING+": ", bcolors.BLUE+"  apps: ",

        # cleanup any app env var leftover from the build
        for each in self.os_environ.keys():
            if True in [ found in each for found in ['MAYA', 'NUKE', 'PRMAN', 'ARNOLD', 'HOUDINI'] ]:
                del self.os_environ[each]

        # add apps env vars to our build
        if self.apps:
            app, version = self.apps
            className = str(app).split('.')[-1].split("'")[0]
            # now set the version of the apps
            pipe.version.set( {className : version} )
            # and create an app class
            app = getattr(pipe.apps, className)()
            # if 'houdini' in className:
            #     app.fullEnvironment()
            print "%s(%s)" % (className, pipe.version.get(className)),
            # get all vars from app class and add to cmd environ
            for each in app:
                if each not in ['LD_PRELOAD','PYTHON_VERSION','PYTHON_VERSION_MAJOR']:
                    v = app[each]
                    if v:
                        if type(v) == str:
                            v=[v]
                        if each not in self.os_environ:
                            self.os_environ[each] = ''
                        # if var value is paths
                        if '/' in str(v):
                            self.os_environ[each] = "%s:%s" % (self.os_environ[each], ':'.join(v))
                        else:
                            self.os_environ[each] = ' '.join(v)

        # remove python paths that are not the same version!
        for each in self.os_environ:
            if '/' in str(self.os_environ[each]):
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

        self.os_environ['LD_PRELOAD'] = ''.join(os.popen("ldconfig -p | grep libstdc++.so.6 | grep x86-64 | cut -d'>' -f2").readlines()).strip()
        self.os_environ['LD_PRELOAD'] += ':'+''.join(os.popen("ldconfig -p | grep libgcc_s.so.1 | grep x86-64 | cut -d'>' -f2").readlines()).strip()

        #self.os_environ['LD_LIBRARY_PATH'] = '/usr/lib/:%s' % self.os_environ['LD_LIBRARY_PATH']
        print
        return cmd + " " + self.sconsInstall



class gaffer(cortex):
    ''' a make class to exclusively build gaffer package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    src='SConstruct'
    environ = {
    }
    cmd=[
        'scons OPTIONS=%s/gaffer.options.py -j $DCORES' % os.path.abspath( os.path.dirname(__file__)),
        'scons OPTIONS=%s/gaffer.options.py -j $DCORES' % os.path.abspath( os.path.dirname(__file__)),
    ]
    # disable Appleseed build since we don't have it building yet!
    sed={'0.0.0' : {
        'SConstruct' : [
            ('if not haveRequiredOptions ', 'if not haveRequiredOptions or "applesed" in libraryName.lower() '),
            ('"GafferAppleseed" : {',"''' "),
            ('"GafferAppleseedUITest',"''' #")
        ]
    }}
    def installer(self, target, source, env): # noqa
        ''' we create/update the /atomo/app/.../gaffer folder since gaffer is also an app! '''
        targetFolder = os.path.dirname(str(target[0]))
        versionMajor = float( '.'.join( os.path.basename(targetFolder).split('.')[:2] ) )
        app = '%s/%s' % (pipe.roots.apps(), '/'.join(targetFolder.split('/')[-2:]))
        ret = []
        if not os.path.exists( app ):
            ret += os.popen( 'sudo ln -s $TARGET_FOLDER  %s' % app ).readlines()
        # for each in glob("%s/bin/*" % targetFolder):
        #     each = os.path.basename(each)
        #     if 'linux-gnu' not in each:
        #         if versionMajor == 4.1:
        #             ret += os.popen( "ln -s %s %s/bin/%s 2>&1" % (each, targetFolder, each.split('-')[0]) ).readlines()
        #         if versionMajor == 4.8:
        #             ret += os.popen( "ln -s %s %s/bin/%s 2>&1" % (each, targetFolder, ''.join( [ c for c in each if not c.isdigit() and c not in ['.'] ] )) ).readlines()
        #         else:
        #             ret += os.popen( "ln -s %s %s/bin/%s 2>&1" % (each, targetFolder, each.split('-')[0]) ).readlines()
        #
        #     # we add a couple of wrappers to ar and ranlib, so we don't have to build then.
        #     # the wrapper make sure they can load the correct libstdc++ from system
        #     ret += os.popen( 'echo "LD_LIBRARY_PATH=/usr/lib:\\$LD_LIBRARY_PATH /usr/sbin/ar \\$@" > %s/bin/ar ; chmod a+x %s/bin/ar' % (targetFolder,targetFolder) ).readlines()
        #     ret += os.popen( 'echo "LD_LIBRARY_PATH=/usr/lib:\\$LD_LIBRARY_PATH /usr/sbin/ranlib \\$@" > %s/bin/ranlib ; chmod a+x %s/bin/ranlib' % (targetFolder,targetFolder) ).readlines()
        return ret
