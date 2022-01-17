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


import build, devRoot
import SCons, os
from pipe import versionSort, distro



mem = ''.join(os.popen("grep MemTotal /proc/meminfo | awk '{print $(NF-1)}'").readlines()).strip()

SCons.Script.SetOption('warn', 'no-all')
#SCons.Script.SetOption('num_jobs', 8)

# def versionSort(versions):
#     def method(v):
#         v = filter(lambda x: x.isdigit() or x in '.', v.split('b')[0])
#         return str(float(v.split('.')[0])*10000+float(v.split('.')[:2][-1])) + v.split('b')[-1]
#     tmp =  sorted( versions, key=method, reverse=True )
#     # print tmp
#     return tmp


class all: # noqa
    ''' a unique class to hold all packages and versions build in pipeVFX '''

    def cmake_prefix(self):
        ret = []
        ret += ['$OIIO_TARGET_FOLDER/cmake/Modules/']
        ret += ['$OIIO_TARGET_FOLDER/share/cmake/Modules/']
        ret += ['$PUGIXML_TARGET_FOLDER/lib64/cmake/pugixml/']
        ret += ['$MATERIALX_TARGET_FOLDER/cmake/']
        ret += ['$QT_TARGET_FOLDER/lib/cmake/']
        ret += ['$QT_TARGET_FOLDER/lib/cmake/Qt5*/']
        ret += ['$PTEX_TARGET_FOLDER/share/cmake/Ptex/']
        return ':'.join(ret)

    def rpath( self, l ):
        self._rpath += l

    # -D_GLIBCXX_USE_CXX11_ABI=0 is ultra important to make strings on newer
    # gcc versions compatible with strings in older versions.
    # Without it, we can see errors of unknown symbols on libraries at
    # runtime, and it can be very confusing and time consuming to
    # figure out!
    # because of that, we're adding it as default to rpath_environ, which
    # is used as a base environment on lots of packages!
    def rpath_environ( self, rpath=[] ):
        if not rpath:
            rpath = self._rpath

        zrpath   = build.rpath_environ( rpath )
        zlib     = build.lib_environ( rpath )
        zinclude = build.include_environ( [ x.split('lib')[0]+'/include' for x in rpath] )
        self._rpath_environ = build.update_environ_dict( self._rpath_environ, zrpath )
        self._rpath_environ = build.update_environ_dict( self._rpath_environ, zlib )
        self._rpath_environ = build.update_environ_dict( self._rpath_environ, zinclude )
        self._rpath_environ = build.removeDuplicatedEntriesEnvVars( self._rpath_environ )
        return self._rpath_environ

    def __init__(self,ARGUMENTS):
        ''' Build all basic packages needed by pipeVFX, with multiple versions for each.

        Packages can receive dependency to other packages by specifying then in the depend parameter or
        by adding a 4th dict element in the download tupple, where keys are pkg and value is its version.

        Using the 4th element has the advantage to add a specific package version dependency to a specific
        version of the package.

        You can also use it to specify a dependency for only one version and not for another (see python)
        One can also specify a pkg to be a dependency of ALL subsequent packages, by adding it to the
        build.allDepend list. ex: build.allDepend.append(python)

        To build a package with a specific version of GCC, just add gcc as a dependency to the package. (see python again!)
        '''
        self._rpath = []
        self._rpath_environ = {}
        self.all_env_vars = {}
        self.allDepend = []
        self.masterVersion = {}

        # we start by uncompressing a binary tarball of gcc 4.1.2, to use
        # as cold start compiler to build other gcc's
        gcc_4_1_2 = build.gccBuild(
                ARGUMENTS,
                'gcc',
                targetSuffix = "pre",
                download=[(
                    # CY2014
                    # although we have the URL for the source code of 4.1.2,
                    # we are using a pre-build tarball done in arch since
                    # building it in centos 7 breaks something, and some shared
                    # libraries build with 4.1.2 will complain about needing
                    # objects compiled with -fPIC, when they actually have being!
                    # the pre-built tarball.
                    # the bin tarball is already in the build docker image!
                    # original source md5: 'dd2a7f4dcd33808d344949fcec87aa86',
                    # origial source file: 'gcc-4.1.2.tar.gz',
                    # bin tarball md5: 'bf35fabc47ead3b1f743492052296336',
                    # bin tarball file: '4.1.2.tar.gz',
                    '--ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.1.2/gcc-4.1.2.tar.gz',
                    '4.1.2.tar.gz',
                    '4.1.2',
                    '094fa468653d11cf65df94cc41fb257c',
                )],
                # we need this since gcc 4.1.2 is binary and its just copied over
                # without it the build would fail due to being less than 5 secs
                noMinTime=True,
                dontUseTargetSuffixForFolders = 1,
        )
        self.gcc_4_1_2 = gcc_4_1_2

        # zlib = build.configure(
        #     ARGUMENTS,
        #     'zlib',
        #     download=[(
        #         'http://zlib.net/fossils/zlib-1.2.8.tar.gz',
        #         'zlib-1.2.8.tar.gz',
        #         '1.2.8',
        #         '44d667c142d7cda120332623eab69f40'
        #     ),(
        #         'http://zlib.net/zlib-1.2.11.tar.gz',
        #         'zlib-1.2.11.tar.gz',
        #         '1.2.11',
        #         '1c9f62f0778697a09d36121ead88e08e'
        #     )],
        # )
        # build.globalDependency(zlib)

        # curl = build.configure(
        #        ARGUMENTS,
        #        'curl',
        #        download=[
        #          (
        #            'http://curl.haxx.se/download/curl-7.42.1.tar.gz',
        #            'curl-7.42.1.tar.gz',
        #            '7.42.1',
        #            '8df5874c4a67ad55496bf3af548d99a2'
        #          ),
        #        ],
        # )
        # build.allDepend.append(curl)

        # =============================================================================================================================================
        # this is needed by gcc
        # =============================================================================================================================================
        gmp = build.configure(
           ARGUMENTS,
           'gmp',
           download=[(
                'https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2',
                'gmp-6.1.2.tar.gz',
                '6.1.2',
                '8ddbb26dc3bd4e2302984debba1406a5'
            # ),(
            #     'https://gmplib.org/download/gmp/archive/gmp-4.2.1.tar.bz2',
            #     'gmp-4.2.1.tar.gz',
            #     '4.2.1',
            #     '091c56e0e1cca6b09b17b69d47ef18e3'
            # ),(
            #     'https://gmplib.org/download/gmp/archive/gmp-4.3.2.tar.bz2',
            #     'gmp-4.3.2.tar.gz',
            #     '4.3.2',
            #     'dd60683d7057917e34630b4a787932e8'
            )],
            depend = [self.gcc_4_1_2],
            environ = { 'LD' : 'ld' },
            globalDependency = True,
        )
        build.github_phase(gmp)

        mpfr = build.configure(
            ARGUMENTS,
            'mpfr',
            download=[(
                'https://www.mpfr.org/mpfr-3.1.6/mpfr-3.1.6.tar.gz',
                'mpfr-3.1.6.tar.gz',
                '3.1.6',
                '95dcfd8629937996f826667b9e24f6ff',
            )],
            depend = [gmp, self.gcc_4_1_2],
            environ = { 'LD' : 'ld' },
            globalDependency = True,
        )
        build.github_phase(mpfr)

        mpc = build.configure(
            ARGUMENTS,
            'mpc',
            download=[(
               'https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz',
               'mpc-1.0.3.tar.gz',
               '1.0.3',
               'd6a1d5f8ddea3abd2cc3e98f58352d26',
            )],
            depend = [mpfr, gmp, self.gcc_4_1_2],
            environ = { 'LD' : 'ld' },
            globalDependency = True,
        )
        flex = build.configure(
            ARGUMENTS,
            'flex',
            download=[(
                'http://downloads.sourceforge.net/project/flex/flex-2.5.39.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fflex%2Ffiles%2F&ts=1433811270&use_mirror=iweb',
                'flex-2.5.39.tar.gz',
                '2.5.39',
                'e133e9ead8ec0a58d81166b461244fde'
            )],
            depend = [mpc, mpfr, gmp, self.gcc_4_1_2],
            environ = { 'LD' : 'ld' },
            globalDependency = True,
        )

        # =============================================================================================================================================
        # wee need to build gcc 4.8.5 to build glibc 2.17, which in turn we will use to build gcc 6.3.1
        # =============================================================================================================================================
        binutils = build.configure(
            ARGUMENTS,
            'binutils',
            sed = { '0.0.0' : {
                'gprof/Makefile.in' : [
                    ('SUFFIXES = .m','SUFFIXES ='),
                    ('.SUFFIXES: .m ','.SUFFIXES: '),
                ],
            }},
            # binutils-2.17 is the best for gcc 4.1.2
            # but it doesn't work with shared libs in centos 7.
            download=[(
            #     'https://mirror.its.dal.ca/gnu/binutils/binutils-2.17a.tar.bz2',
            #     'binutils-2.17.tar.gz',
            #     '2.17.1',
            #     '1d81edd0569de4d84091526fd578dd7b'
            # ),(
            # We need 2.20 to build glibc 2.17
            #     'https://mirror.its.dal.ca/gnu/binutils/binutils-2.20.1a.tar.bz2',
            #     'binutils-2.20.1.tar.gz',
            #     '2.20.1a',
            #     '2b9dc8f2b7dbd5ec5992c6e29de0b764'
            # ),(
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.22.tar.gz',
                'binutils-2.22.tar.gz',
                '2.22.0',
                '8b3ad7090e3989810943aa19103fdb83'
            ),(
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.24.tar.gz',
                'binutils-2.24.tar.gz',
                '2.24.0',
                'a5dd5dd2d212a282cc1d4a84633e0d88'
            ),(
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.27.tar.gz',
                'binutils-2.27.tar.gz',
                '2.27.0',
                '41b053ed4fb2c6a8173ef421460fbb28'
            ),(
            # so we're defaulting to 2.33.1 for now.
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.33.1.tar.gz',
                'binutils-2.33.1.tar.gz',
                '2.33.1',
                '1a6b16bcc926e312633fcc3fae14ba0a'

            )],
            depend = [self.gcc_4_1_2],
        )
        self.binutils = binutils

        # self.gcc_4_8_5 = build.gccBuild(
        #         ARGUMENTS,
        #         'gcc',
        #         targetSuffix='pre_glibc_gcc485',
        #         download=[(
        #             # CY2015
        #             'ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.8.5/gcc-4.8.5.tar.gz',
        #             'gcc-4.8.5.tar.gz',
        #             '4.8.5',
        #             'bfe56e74d31d25009c8fb55fd3ca7e01',
        #             # { binutils : '2.22.0' }
        #         )],
        #         # depend = [self.gcc_4_1_2],
        #         environ = { 'LD' : 'ld' },
        #         dontUseTargetSuffixForFolders = 1,
        # )
        # self.gcc_6_3_1 = build.gccBuild(
        #         ARGUMENTS,
        #         'gcc',
        #         targetSuffix='pre_glibc_gcc631',
        #         download=[(
        #             # CY2018 GCC 6.3.1 source code.
        #            'http://vault.centos.org/7.5.1804/sclo/Source/rh/devtoolset-6/devtoolset-6-gcc-6.3.1-3.1.el7.src.rpm',
        #            'gcc-6.3.1.rpm.tar.gz',
        #            '6.3.1',
        #            'f6f508c03da14106554604b1ad3a5aab',
        #            { build.override.src: 'gcc.spec' } #, self.gcc_4_1_2: None }
        #         )],
        #         depend = [self.gcc_4_1_2],
        #         environ = {"LD" : "ld"},
        #         dontUseTargetSuffixForFolders = 1,
        # )


        # =============================================================================================================================================
        # the main glibc used in all CY versions of VFX Platform
        # =============================================================================================================================================
        self.make = build.configure(
            ARGUMENTS,
            'make',
            sed = { '0.0.0' : {
                'glob/glob.c' : [
                    ('_GNU_GLOB_INTERFACE_VERSION .. GLOB_INTERFACE_VERSION','_GNU_GLOB_INTERFACE_VERSION >= GLOB_INTERFACE_VERSION'),
            ]}, '4.3.0' : {()}},
            download=[(
                'http://ftp.gnu.org/gnu/make/make-3.79.tar.gz',
                'make-3.79.tar.gz',
                '3.79.0',
                'a59cc0e5792474f6809131650d2fff5a',
            ),(
                'https://ftp.gnu.org/gnu/make/make-3.80.tar.gz',
                'make-3.80.tar.gz',
                '3.80.0',
                'c68540da9302a48068d5cce1f0099477',
            ),(
                'https://ftp.gnu.org/gnu/make/make-3.81.tar.gz',
                'make-3.81.tar.gz',
                '3.81.0',
                'a4e9494ac6dc3f6b0c5ff75c5d52abba',
            ),(
                'https://ftp.gnu.org/gnu/make/make-3.82.tar.gz',
                'make-3.82.tar.gz',
                '3.82.0',
                '7f7c000e3b30c6840f2e9cf86b254fac',
            ),(
                'https://ftp.gnu.org/gnu/make/make-4.0.tar.gz',
                'make-4.0.tar.gz',
                '4.0.0',
                'b5e558f981326d9ca1bfdb841640721a',
            # ),(
            #     'https://ftp.gnu.org/gnu/make/make-4.3.tar.gz',
            #     'make-4.3.tar.gz',
            #     '4.3.0',
            #     'fc7a67ea86ace13195b0bce683fd4469',
            )],
            cmd = [
                'mkdir -p build',
                'cd build',
                '../configure --prefix=$INSTALL_FOLDER',
                'make -j $DCORES CFLAGS="$CFLAGS -fPIC" PREFIX=$INSTALL_FOLDER',
                'make -j $DCORES PREFIX=$INSTALL_FOLDER install',
                'rm -rf  $INSTALL_FOLDER/bin/gmake && ln -s make $INSTALL_FOLDER/bin/gmake',
            ],
            depend = [self.gcc_4_1_2],
            noMinTime=True,
        )

        self.autoconf = build.configure(
            ARGUMENTS,
            'autoconf',
            download=[(
                'http://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz',
                'autoconf-2.71.tar.gz',
                '2.71.0',
                'f64e38d671fdec06077a41eb4d5ee476',
            ),(
                'http://ftp.gnu.org/gnu/autoconf/autoconf-2.68.tar.gz',
                'autoconf-2.68.tar.gz',
                '2.68.0',
                'c3b5247592ce694f7097873aa07d66fe',
            )],
            cmd = [
                'mkdir -p build',
                'cd build',
                '../configure --prefix=$INSTALL_FOLDER',
                'make -j $DCORES CFLAGS="$CFLAGS -fPIC" PREFIX=$INSTALL_FOLDER',
                'make -j $DCORES PREFIX=$INSTALL_FOLDER install',
            ],
            depend = [self.gcc_4_1_2],
            noMinTime=True,
        )

        # glibc = build.configure(
        #     ARGUMENTS,
        #     'glibc',
        #     sed = { '0.0.0' : {
        #         'malloc/obstack.c' : [
        #             ('struct obstack ._obstack_compat','struct obstack *_obstack_compat=0'),
        #         ],
        #     }},
        #     download=[(
        #         'http://ftp.gnu.org/gnu/glibc/glibc-2.17.tar.gz',
        #         'glibc-2.17.tar.gz',
        #         '2.17.0',
        #         '8a7f11b9ac5d0d5efa4c82175b5a9c1b',
        #         { self.gcc_6_3_1: '6.3.1', self.autoconf : '2.68.0',
        #           self.make : '3.81.0', self.binutils : '2.27.0'  }
        #     )],
        #     cmd = [
        #         'mkdir -p build',
        #         'cd build',
        #         '''export LD_LIBRARY_PATH=$(echo $(echo $LD_LIBRARY_PATH | sed 's/:/\\n/g' | egrep -v 'build|^\.') | sed 's/ /:/g')''',
        #         ''' ../configure --prefix=$INSTALL_FOLDER --with-binutils=$BINUTILS_TARGET_FOLDER ; echo "$(cat ./Makefile | sed 's/\f//g')" > Makefile''',
        #         '''make -j $DCORES CFLAGS="$CFLAGS -fPIC" PREFIX=$INSTALL_FOLDER ''',
        #         '''LD_LIBRARY_PATH=/lib64/:$/usr/lib64/:/lib/:/usr/lib/:$$LD_LIBRARY_PATH make -j $DCORES PREFIX=$INSTALL_FOLDER install''',
        #     ],
        #     depend = [self.gcc_6_3_1],
        #     environ = {
        #         "LD" : "/usr/bin/ld"
        #     },
        #     # globalDependency = 'NORPATH NOLIB',
        # )
        # self.glibc = glibc

        # build.globalDependency(self.binutils)
        # build.globalDependency(self.autoconf)


        # =============================================================================================================================================
        # now we build GCC using glibc built above
        # =============================================================================================================================================
        # gcc 4.8.5 build fails in fedora 35
        gcc = build.gccBuild(
                ARGUMENTS,
                'gcc',
                download=[(
                    # CY2014
                    # although we have the URL for the source code of 4.1.2,
                    # we are using a pre-build tarball done in arch since
                    # building it in centos 7 breaks something, and some shared
                    # libraries build with 4.1.2 will complain about needing
                    # objects compiled with -fPIC, when they actually have being!
                    # the pre-built tarball.
                    # the bin tarball is already in the build docker image!
                    # original source md5: 'dd2a7f4dcd33808d344949fcec87aa86',
                    # origial source file: 'gcc-4.1.2.tar.gz',
                    # bin tarball md5: 'bf35fabc47ead3b1f743492052296336',
                    # bin tarball file: '4.1.2.tar.gz',
                    '--ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.1.2/gcc-4.1.2.tar.gz',
                    '4.1.2.tar.gz',
                    '4.1.2',
                    '094fa468653d11cf65df94cc41fb257c',
                    # { binutils : '2.22.0' }
                ),(
                    # CY2015
                    'ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.8.5/gcc-4.8.5.tar.gz',
                    'gcc-4.8.5.tar.gz',
                    '4.8.5',
                    'bfe56e74d31d25009c8fb55fd3ca7e01',
                    # { binutils : '2.22.0' }
                ),(
                    # CY2018 GCC 6.3.1 source code.
                   'http://vault.centos.org/7.5.1804/sclo/Source/rh/devtoolset-6/devtoolset-6-gcc-6.3.1-3.1.el7.src.rpm',
                   'gcc-6.3.1.rpm.tar.gz',
                   '6.3.1',
                   'f6f508c03da14106554604b1ad3a5aab',
                   { build.override.src: 'gcc.spec' } #, self.gcc_4_1_2: None }
                )],
                depend = [self.gcc_4_1_2],
                environ = {"LD" : "ld"},
                # globalDependency = True,
        )
        self.gcc = gcc
        build.globalDependency(self.gcc)

        # a dummy build that stalls until the passed build is done!
        # everythin will depend on this dummy post-gcc build, so everything
        # will wait for gcc to finish before start.
        # this is essential when building packages in parallel (scons -j)
        build.github_phase(self.gcc, version='6.3.1')


        self.patchelf = build.configure(
            ARGUMENTS,
            'patchelf',
            sed={'0.0.0':{
                'src/patchelf.cc' : [
                    ('include .optional.','include <experimental/optional>'),
                    ('std..optional','std::experimental::optional'),
            ]}},
            download=[(
                'https://github.com/NixOS/patchelf/releases/download/0.14.3/patchelf-0.14.3.tar.gz',
                'patchelf-0.14.3.tar.gz',
                '0.14.3',
                '3e0e8c12ede45843269b0a1ef457dd4a',
                { self.gcc : '6.3.1'}
            )],
            cmd = [
                './configure',
                'make',
                # 'make check',
                'make install',
            ],
            environ = {
                # 'CXX' : '$CXX  -std=c++11 ',
                # 'CPATH' : '$CPATH:$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/experimental/',
            },
        )

        # =============================================================================================================================================
        # wee need icu, bzip2, readline and openssl for python
        # =============================================================================================================================================
        icu = build.configure(
            ARGUMENTS,
            'icu',
            download=[(
                'http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz',
                'icu.tar.gz',
                '57.1',
                '976734806026a4ef8bdd17937c8898b9',
                { self.gcc : '4.1.2' }
            )],
            src = 'icu4c.css',
            cmd = ['cd ./source/'] + build.configure.cmd,
            environ = {
                'LD_PRELOAD': ':'.join([
                    '$LATESTGCC_TARGET_FOLDER/lib64/libstdc++.so.6',
                    '$LATESTGCC_TARGET_FOLDER/lib64/libgcc_s.so.1',
                ]),
            },
        )
        self.icu = icu

        bzip2 = build.make(
            ARGUMENTS,
            'bzip2',
            download=[(
                'https://downloads.sourceforge.net/project/bzip2/bzip2-1.0.6.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbzip2%2Ffiles%2Fbzip2-1.0.6.tar.gz%2Fdownload&ts=1557548225',
                'bzip2-1.0.6.tar.gz',
                '1.0.6',
                '00b516f4704d4a7cb50a1d97e6e8e15b',
                { self.gcc : '4.1.2' }
            )],
            cmd = [
                'make -j $DCORES CFLAGS="$CFLAGS -O2 -fPIC" PREFIX=$INSTALL_FOLDER',
                'make -j $DCORES PREFIX=$INSTALL_FOLDER install',
                'make -j $DCORES -f Makefile-libbz2_so CFLAGS="$CFLAGS -O2 -fPIC" PREFIX=$INSTALL_FOLDER',
                'cp -rfuv ./libbz2.so.* $INSTALL_FOLDER/lib64/'
            ],
            # bzip2 builds real fast!!
            noMinTime=True,
            globalDependency = True,
        )
        self.bzip2 = bzip2

        readline = build.configure(
            ARGUMENTS,
            'readline',
            download=[(
                'http://ftp.gnu.org/gnu/readline/readline-5.2.tar.gz',
                'readline-5.2.tar.gz',
                '5.2.0',
                'e39331f32ad14009b9ff49cc10c5e751',
                { self.gcc : '4.1.2' }
            ),(
                'https://ftp.gnu.org/gnu/readline/readline-7.0.tar.gz',
                'readline-7.0.tar.gz',
                '7.0.0',
                '205b03a87fc83dab653b628c59b9fc91',
                { self.gcc : '4.1.2' }
            )],
            cmd = [
                './configure ',
                'make -j $DCORES SHLIB_LIBS="-lncurses" CFLAGS="$CFLAGS -fPIC" PREFIX=$INSTALL_FOLDER',
                'make -j $DCORES PREFIX=$INSTALL_FOLDER install',
            ],
            globalDependency = True,
        )
        self.readline = readline

        openssl = build.openssl(
            ARGUMENTS,
            'openssl',
            download=[(
            #     'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2h.tar.gz',
            #     'openssl-OpenSSL_1_0_2h.tar.gz',
            #     '1.0.2h',
            #     'bd70ca76ef00c9b65a927883f62998d9',
            # ),(
                'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2s.tar.gz',
                'openssl-OpenSSL_1_0_2s.tar.gz',
                '1.0.2s',
                '24886418211ec05e3f1c764a489b29c1',
            )],
            parallel = 0,
            globalDependency = True,
        )
        self.openssl = openssl

        build.globalDependency(self.patchelf)
        build.globalDependency(self.bzip2)
        build.globalDependency(self.openssl)
        build.globalDependency(self.readline)

        # =============================================================================================================================================
        # build python now!
        # =============================================================================================================================================
        python = build.python(
            ARGUMENTS,
            'python',
            download=[(
                    # CY2015 - CY2019
                    'http://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz',
                    'Python-2.7.16.tar.gz',
                    '2.7.16',
                    'f1a2ace631068444831d01485466ece0',
                    { self.gcc : '4.1.2', readline : '7.0.0', openssl : '1.0.2s' },
                ),(
                    # CY2020
                    'https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz',
                    'Python-3.7.5.tar.gz',
                    '3.7.5',
                    '1cd071f78ff6d9c7524c95303a3057aa',
                    { self.gcc : '4.8.5', readline : '7.0.0', openssl : '1.0.2s' },
            )],
            # this fixes https not finding certificate in easy_install
            environ = {
                "PYTHONHTTPSVERIFY" : "0",
                'LD' : 'ld',
            },
            depend = [readline,bzip2,icu],
            # globalDependency = True,
        )
        self.python = python
        build.globalDependency(self.python)

        # install extra python modules using pip, for all python versions
        # installed by python build.
        self.pip = [ build.pip( ARGUMENTS, p, self.python ) for p in [
            'readline',
            'epydoc',
            'PyOpenGL',
            'PyOpenGL-accelerate',
            'cython',
            'subprocess32',
            'numpy',
            'scons',
            'jinja2',   # needed by USD
            'sphinx',   # needed by pyside
            # 'pybind11[Global]',
        ]]

        tbb = build.tbb(
            ARGUMENTS,
            'tbb',
            download=[(
                # CY2016
                'https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb43_20150611oss_src.tgz',
                'tbb43_20150611oss.tar.gz',
                '4.3.6',
                'bb144ec868c53244ea6be11921d86f03',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2017
                'https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb44_20160526oss_src_0.tgz',
                'tbb44_20160526oss.tar.gz',
                '4.4.r20160526oss',
                '6309541504a819dabe352130f27e57d5',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2018
                'https://github.com/intel/tbb.git',
                'tbb-2017_U6.zip',
                '2017_U6',
                None,
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2019
                'https://github.com/intel/tbb.git',
                'tbb-2018.zip',
                '2018',
                None,
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2020
                'https://github.com/intel/tbb.git',
                'tbb-2019_U6.zip',
                '2019_U6',
                None,
                { self.gcc : '6.3.1', python: '2.7.16' }
            ),(
                # CY2021
                'https://github.com/intel/tbb.git',
                'tbb-2020_U2.zip',
                '2020_U2',
                None,
                { self.gcc : '6.3.1', python: '2.7.16' }
            ),(
                # CY2022
                'https://github.com/intel/tbb.git',
                'tbb-2020_U3.zip',
                '2020_U3',
                None,
                { self.gcc : '6.3.1', python: '2.7.16' }
            ),(
                # USD / maya 2018
                'https://github.com/intel/tbb/archive/4.4.6.tar.gz',
                'tbb-4.4.6.tar.gz',
                '4.4.6',
                '20e15206f70c2651bfc964e451a443a0',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
        )
        self.tbb = tbb

        cmake = build.configure(
            ARGUMENTS,
            'cmake',
            download=[(
                'http://www.cmake.org/files/v3.4/cmake-3.4.3.tar.gz',
                'cmake-3.4.3.tar.gz',
                '3.4.3',
                '4cb3ff35b2472aae70f542116d616e63',
                { self.gcc : '4.1.2' }
            ),(
                'https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz',
                'cmake-3.8.2.tar.gz',
                '3.8.2',
                'b5dff61f6a7f1305271ab3f6ae261419',
                { self.gcc : '4.1.2' }
            ),(
                'https://cmake.org/files/v3.9/cmake-3.9.0.tar.gz',
                'cmake-3.9.0.tar.gz',
                '3.9.0',
                '180e23b4c9b55915d271b315297f6951',
                { self.gcc : '4.8.5' }
            ),(
                'https://cmake.org/files/v3.9/cmake-3.9.6.tar.gz',
                'cmake-3.9.6.tar.gz',
                '3.9.6',
                '084b1c8b2efc1c1ba432dea37243c0ae',
                { self.gcc : '4.8.5' }
            ),(
                'https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2.tar.gz',
                'cmake-3.18.2.tar.gz',
                '3.18.2',
                '7a882b3764f42981705286ac9daa29c2',
                { self.gcc : '6.3.1' }
            )],
            cmd = [
                "mkdir ./build",
                "mount -t tmpfs tmpfs ./build",
                "cd ./build",
                "../configure --system-curl --no-system-libs --parallel=$DCORES",
                "./Bootstrap.cmk/cmake",
                "make -j $DCORES VERBOSE=1",
                "make -j $DCORES install",
                "cd ../",
                "umount ./build",
            ],
            sed = { '0.0.0' : {
                'Source/kwsys/Terminal.c' : [
                    ('/* If running inside emacs the terminal is not VT100.  Some emacs','return 1;'),
                # ]}, '3.18.2': {
                # './Source/Checks/cm_cxx17_check.cpp' : [
                #     ('include .optional.','include <experimental/optional>'),
                #     ('std..optional','std::experimental::optional'),
                ]},
            },
            # environ={
            #     # 'LDFLAGS' : "-Wl,-rpath-link,/usr/lib64/ -Wl,-rpath,/usr/lib64/ $LDFLAGS",
            #     'LD'      : 'ld',
            # },
        )
        self.cmake = cmake

        for pip in self.pip:
            build.globalDependency(pip)
        build.globalDependency(self.tbb)
        build.globalDependency(self.cmake)

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.cmake)


        # =============================================================================================================================================
        # build all other generic packages
        glew = build.glew(
            ARGUMENTS,
            'glew',
            download=[(
                'http://downloads.sourceforge.net/glew/glew-1.13.0.tgz',
                'glew-1.13.0.tar.gz',
                '1.13.0',
                '7cbada3166d2aadfc4169c4283701066',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                'https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.tgz',
                'glew-2.1.0.tar.gz',
                '2.1.0',
                'b2ab12331033ddfaa50dc39345343980',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
        )
        self.glew = glew
        build.globalDependency(self.glew)

        freeglut = build.configure(
            ARGUMENTS,
            'freeglut',
            download=[(
                'http://downloads.sourceforge.net/project/freeglut/freeglut/2.8.1/freeglut-2.8.1.tar.gz?r=http%3A%2F%2Ffreeglut.sourceforge.net%2Findex.php&ts=1432619092&use_mirror=hivelocity',
                'freeglut-2.8.1.tar.gz',
                '2.8.1',
                '918ffbddcffbac83c218bc52355b6d5a',
                { self.gcc : '4.1.2', python: '2.7.16' }
            # ),(
            #     'https://github.com/dcnieho/FreeGLUT/archive/FG_3_2_1.tar.gz',
            #     'FreeGLUT-FG_3_2_1.tar.gz',
            #     '3.2.1',
            #     '90c3ca4dd9d51cf32276bc5344ec9754',
            )],
            environ = {
                'LDFLAGS' : '$LDFLAGS -lm -lGL ',
                'LD' : 'ld',
            },
        )
        self.freeglut = freeglut
        build.globalDependency(self.freeglut)

        jpeg = build.configure(
            ARGUMENTS,
            'jpeg',
            download=[(
                'http://www.ijg.org/files/jpegsrc.v6b.tar.gz',
                'jpeg-6b.tar.gz',
                '6b',
                'dbd5f3b47ed13132f04c685d608a7547',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://www.ijg.org/files/jpegsrc.v9a.tar.gz',
                'jpeg-9a.tar.gz',
                '9a',
                '3353992aecaee1805ef4109aadd433e7',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
            cmd = [
                './configure --enable-shared --prefix=$INSTALL_FOLDER',
                'make install INSTALL="/usr/bin/install -D"',
            ],
            environ = { 'LD' : 'ld' },
            noMinTime=True,
        )
        self.jpeg = jpeg


        jasper = build.configure(
            ARGUMENTS,
            'jasper',
            download=[(
                'http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip', # http://www.ece.uvic.ca/~frodo/jasper/
                'jasper-1.900.1.zip',
                '1.900.1',
                'a342b2b4495b3e1394e161eb5d85d754',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
            environ = { 'LD' : 'ld' , 'LD_LIBRARY_PATH' : '$GCC_TARGET_FOLDER/lib64/' },
        )
        self.jasper = jasper

        libraw = build.configure(
            ARGUMENTS,
            'libraw',
            src='mkdist.sh',
            download=[(
                'https://github.com/LibRaw/LibRaw/archive/0.17.2.tar.gz',
                'LibRaw-0.17.2.tar.gz',
                '0.17.2',
                '7de042bcffb58864fd93d5209620e08d',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
            depend=[gcc],
            cmd = [
                './mkdist.sh',
                './configure --enable-shared --prefix=$INSTALL_FOLDER',
                # it seems there's UTF-8 characters in the source code, so we need to clena it up!
                'cp src/../internal/libraw_x3f.cpp ./xx',
                'iconv -f UTF-8 -t ASCII -c ./xx -o src/../internal/libraw_x3f.cpp',
                'sed -i.bak $SOURCE_FOLDER/internal/dcraw_common.cpp -e "s/powf64/dc_powf64/g"' if 'fedora' in distro else '',
                'make install INSTALL="/usr/bin/install -D"',
            ],
            environ = { 'LD' : 'ld' },
        )
        self.libraw = libraw

        tiff = build.configure(
            ARGUMENTS,
            'tiff',
            download=[(
                'http://download.osgeo.org/libtiff/old/tiff-3.8.2.tar.gz',
                'tiff-3.8.2.tar.gz',
                '3.8.2',
                'fbb6f446ea4ed18955e2714934e5b698',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://download.osgeo.org/libtiff/old/tiff-4.0.3.tar.gz',
                'tiff-4.0.3.tar.gz',
                '4.0.3',
                '051c1068e6a0627f461948c365290410',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://download.osgeo.org/libtiff/tiff-4.0.6.tar.gz',
                'tiff-4.0.6.tar.gz',
                '4.0.6',
                'd1d2e940dea0b5ad435f21f03d96dd72',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
            depend=[jpeg, libraw],
            environ = { 'LD' : 'ld', 'LD_LIBRARY_PATH' : '$GCC_TARGET_FOLDER/lib64/'  },
            parallel=0,
        )
        self.tiff = tiff

        libpng = build.configure(
            ARGUMENTS,
            'libpng',
            download=[(
                'http://ftp.osuosl.org/pub/blfs/conglomeration/libpng/libpng-1.6.23.tar.xz',
                'libpng-1.6.23.tar.gz',
                '1.6.23',
                '9b320a05ed4db1f3f0865c8a951fd9aa',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
            environ = { 'LD' : 'ld' },
        )
        self.libpng = libpng

        build.globalDependency(self.jasper)
        build.globalDependency(self.jpeg)
        build.globalDependency(self.tiff)
        build.globalDependency(self.libpng)


        freetype = build.freetype(
            ARGUMENTS,
            'freetype',
            download=[(
                'http://mirror.csclub.uwaterloo.ca/nongnu//freetype/freetype-2.5.5.tar.gz',
                'freetype-2.5.5.tar.gz',
                '2.5.5',
                '7448edfbd40c7aa5088684b0a3edb2b8',
                { self.gcc : '4.1.2', python: '2.7.16' }
            ),(
                'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.0.tar.gz',
                'freetype-2.10.0.tar.gz',
                '2.10.0',
                '58d56c9ad775326d6c9c5417c462a527',
                { self.gcc : '4.1.2', python: '2.7.16' }
            )],
            environ = { 'LD' : 'ld' },
        )
        self.freetype = freetype
        build.globalDependency(self.freetype)

        gperf = build.configure(
            ARGUMENTS,
            'gperf',
            download=[(
                'https://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz',
                'gperf-3.1.tar.gz',
                '3.1.0',
                '9e251c0a618ad0824b51117d5d9db87e'
            )],
            noMinTime=True,
            environ = { 'LD' : 'ld' },
        )
        self.gperf = gperf
        fontconfig = build.configure(
            ARGUMENTS,
            'fontconfig',
            download=[(
                'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.92.tar.gz',
                'fontconfig-2.13.92.tar.gz',
                '2.13.92',
                'eda1551685c25c4588da39222142f063'
            ) if 'fedora' in distro else (
                'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.1.tar.gz',
                'fontconfig-2.12.1.tar.gz',
                '2.12.1',
                'ce55e525c37147eee14cc2de6cc09f6c'
            )],
            depend = [gperf],
            environ = { 'LD' : 'ld' },
        )
        self.fontconfig = fontconfig
        build.globalDependency(self.fontconfig)

        doxigen = build.cmake(
            ARGUMENTS,
            'doxigen',
            download=[(
                'https://github.com/doxygen/doxygen/archive/refs/tags/Release_1_8_17.tar.gz',
                'doxygen-Release_1_8_17.tar.gz',
                '1.8.17',
                '20c15411be1d11378bc7fae7a846df46',
                { self.gcc: '6.3.1' }
            )],
            environ = { 'LD' : 'ld' },
        )
        self.doxigen = doxigen
        build.globalDependency(self.doxigen)




        # python modules
        # ============================================================================================================================================
        dbus = build.configure(
            ARGUMENTS,
            'dbus',
            download=[(
            #     'https://pypi.python.org/packages/source/d/dbus-python/dbus-python-0.84.0.tar.gz#md5=fe69a2613e824463e74f10913708c88a',
            #     'dbus-python-0.84.0.tar.gz',
            #     '0.84.0',
            #     'fe69a2613e824463e74f10913708c88a',
            #     { self.gcc : '4.8.5', python: '2.7.16' }
            # ),(
                'https://files.pythonhosted.org/packages/b6/85/7b46d31f15a970665533ad5956adee013f03f0ad4421c3c83304ae9c9906/dbus-python-1.2.12.tar.gz',
                'dbus-python-1.2.12.tar.gz',
                '1.2.12',
                '428b7a9e7e2d154a7ceb3e13536283e4',
                { self.gcc : '4.8.5' }
            )],
            baseLibs=[python],
            depend=[python, openssl],
            environ = { 'LD' : 'ld' },
        )
        self.dbus = dbus

        # cython = build.pythonSetup(
        #    ARGUMENTS,
        #    'cython',
        #    download=[(
        #        'https://github.com/cython/cython/archive/0.24.1.tar.gz',
        #        'cython-0.24.1.tar.gz',
        #        '0.24.1',
        #        'ba3474937557f210acb45852e9ebb0fc'
        #    )],
        #    baseLibs=[python],
        # )
        # self.cython = cython

        # numpy = build.pythonSetup(
        #     ARGUMENTS,
        #     'numpy',
        #     download=[(
        #         # CY 2016 and 2017
        #         'https://github.com/numpy/numpy/archive/v1.9.2.tar.gz',
        #         'numpy-1.9.2.tar.gz',
        #         '1.9.2',
        #         '90f7434759088acccfddf5ba61b1f908'
        #     ),(
        #         # CY 2018
        #         'https://github.com/numpy/numpy/archive/v1.12.1.tar.gz',
        #         'numpy-1.12.1.tar.gz',
        #         '1.12.1',
        #         '90f7434759088acccfddf5ba61b1f908'
        #     ),(
        #         # CY 2019
        #         'https://github.com/numpy/numpy/archive/v1.14.x.tar.gz',
        #         'numpy-1.14.x.tar.gz',
        #         '1.14.x',
        #         '90f7434759088acccfddf5ba61b1f908'
        #     ),(
        #         # CY 2020
        #         'https://github.com/numpy/numpy/archive/v1.17.x.tar.gz',
        #         'numpy-1.17.x.tar.gz',
        #         '1.17.x',
        #         '90f7434759088acccfddf5ba61b1f908'
        #     )],
        #     baseLibs=[python],
        #     depend=[python, openssl],
        # )
        # self.numpy = numpy
        # build.allDepend.append(numpy)

        # build pycairo beforehand since pygobject depends on it
        self.pycairo = build.pythonSetup(
            ARGUMENTS,
            'pycairo',
            download=[(
                'https://files.pythonhosted.org/packages/3c/1a/c0478ecab31baae50fda9956547788afbd0ca563adc52c9b03cab30f17eb/pycairo-1.18.2.tar.gz',
                'pycairo-1.18.2.tar.gz',
                '1.18.2',
                'be2ba51f234270dec340f28f1695a95e',
                {self.gcc: '4.8.5'}
            )],
            baseLibs=[python],
            depend=[python],
            noMinTime=True,
        )

        self.pygobject = build.pythonSetup(
            ARGUMENTS,
            'pygobject',
            download=[(
                'https://files.pythonhosted.org/packages/46/8a/b183f3edc812d4d28c8b671a922b5bc2863be5d38c56b3ad9155815e78dd/PyGObject-3.34.0.tar.gz',
                'PyGObject-3.34.0.tar.gz',
                '3.34.0',
                '1860bdb63c8db0826fb310444271e9b0',
                {self.gcc: '4.8.5'}
            )],
            baseLibs=[python],
            depend=[python, self.pycairo],
            environ={
                # not sure why python is not importing cairo from it's egg, but
                # adding the egg to PYTHONPATH seems to fix it.
                'PYTHONPATH' : ':'.join([
                    '$PYTHONPATH',
                    '$PYCAIRO_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/pycairo-$PYCAIRO_VERSION-py$PYTHON_VERSION_MAJOR-linux-x86_64.egg/',
                    '$PYCAIRO_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/pycairo-$PYCAIRO_VERSION-py$PYTHON_VERSION_MAJOR-linux-x86_64.egg/cairo/',
                ])
            },
            noMinTime=True,
        )

        self.pythonldap = build.pythonSetup(
            ARGUMENTS,
            'pythonldap',
            download=[(
                # this version only builds for python 2.7
                'https://pypi.python.org/packages/source/p/python-ldap/python-ldap-2.4.19.tar.gz#md5=b941bf31d09739492aa19ef679e94ae3',
                'python-ldap-2.4.19.tar.gz',
                '2.4.19',
                'b941bf31d09739492aa19ef679e94ae3',
                { python: '2.7.6' }
            )],
            # baseLibs=[python],
            depend=[python],
            noMinTime=True,
        )

        self.pybind = build.cmake(
            ARGUMENTS,
            'pybind',
            download=[(
                'https://github.com/pybind/pybind11/archive/v2.6.2.tar.gz',
                'pybind11-2.6.2.tar.gz',
                '2.6.2',
                'c5ea9c4c57082e05efe14e4b34323bfd',
            )],
            flags = [
                # "-D CMAKE_INSTALL_PREFIX=/atomo/pipeline/build/.build/OpenShadingLanguage-Release-1.11.14.1.noBaseLib-boost.1.66.0/ext/dist ",
                "-D CMAKE_INSTALL_PREFIX=$INSTALL_FOLDER",
                "-D CMAKE_BUILD_TYPE=Release",
                "-D PYBIND11_TEST=OFF",
                "-D PYBIND11_FINDPYTHON=1",
                "-D PYBIND11_PYTHON_VERSION=$PYTHON_VERSION_MAJOR",
                "-D Python_ROOT_DIR=$PYTHON_TARGET_FOLDER",
                "-D Python_FIND_STRATEGY=LOCATION",
            ],
            baseLibs=[python],
            depend=[python],
            noMinTime=True,
        )
        build.globalDependency(self.pybind)




        # build all simple python modules here.
        # since its just a matter of running setup.py (hence "simple"),
        # we put all name/version/download infor in a dict for easy maintainance,
        # and run each one through the same pythonSetup builder class,
        # without any special setup.
        simpleModules = {
            'pil' : [(
                'https://github.com/python-pillow/Pillow/archive/6.2.1.tar.gz',
                'Pillow-6.2.1.tar.gz',
                '6.2.1',
                '14711cb3ff6bbd9634aad3bbcb2d935d',
                {self.gcc: '4.8.5'}
            )],
            # 'wxpython' : [(
            #     'https://pypi.python.org/packages/source/P/PyOpenGL/PyOpenGL-3.1.0.tar.gz#md5=0de021941018d46d91e5a8c11c071693',
            #     'PyOpenGL-3.1.0.tar.gz',
            #     '3.1.0',
            #     '0de021941018d46d91e5a8c11c071693'
            # )],
        }
        # run the builders for each module in the dict
        simpleModulesBuilders = []
        for module in simpleModules:
            # we store the builder in a local dict first
            simpleModulesBuilders.append(
                build.pythonSetup(
                    ARGUMENTS,
                    module,
                    download=simpleModules[module],
                    baseLibs=[python],
                    depend=[self.pycairo],
                )
            )
        # add all builders to the global dependency at once here
        # so they can all be built in parallel by scons, since theres no
        # dependency between then.
        for each in simpleModulesBuilders:
            build.globalDependency(each)

        build.globalDependency(self.dbus)
        build.globalDependency(self.pycairo)
        build.globalDependency(self.pygobject)
        build.globalDependency(self.pythonldap)

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.pythonldap)


        # ============================================================================================================================================
        # boost build - this one is very important since there are multiple builds of other packages built for each version of boost.
        boost = build.boost(
            ARGUMENTS,
            'boost',
            download=[(
                # we build this from before vfxplatform...
                'http://downloads.sourceforge.net/project/boost/boost/1.51.0/boost_1_51_0.tar.gz',
                'boost_1_51_0.tar.gz',
                '1.51.0',
                '6a1f32d902203ac70fbec78af95b3cf8',
                { self.gcc : '4.8.5' },
            ),(
                # we build this from before vfxplatform...
                'http://downloads.sourceforge.net/project/boost/boost/1.54.0/boost_1_54_0.tar.gz',
                'boost_1_54_0.tar.gz',
                '1.54.0',
                'efbfbff5a85a9330951f243d0a46e4b9',
                { self.gcc : '4.8.5' },
            ),(
                # CY2014
                'http://downloads.sourceforge.net/project/boost/boost/1.53.0/boost_1_53_0.tar.gz',
                'boost_1_53_0.tar.gz',
                '1.53.0',
                '57a9e2047c0f511c4dfcf00eb5eb2fbb',
                { self.gcc : '4.8.5' },
            ),(
                # CY2015 - CY2016
                'http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz', # houdini!!!
                'boost_1_55_0.tar.gz',
                '1.55.0',
                '93780777cfbf999a600f62883bd54b17',
                { self.gcc : '4.8.5' },
            ),(
                # we build this from before vfxplatform... for houdini 15
                'http://downloads.sourceforge.net/project/boost/boost/1.56.0/boost_1_56_0.tar.gz',
                'boost_1_56_0.tar.gz',
                '1.56.0',
                '8c54705c424513fa2be0042696a3a162',
                { self.gcc : '4.8.5' },
            ),(
                # CY2017 - CY2018
                'http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.gz',
                'boost_1_61_0.tar.gz',
                '1.61.0',
                '874805ba2e2ee415b1877ef3297bf8ad',
                { self.gcc :  '6.3.1' }
            ),(
                # CY2019
                'http://downloads.sourceforge.net/project/boost/boost/1.66.0/boost_1_66_0.tar.gz',
                'boost_1_66_0.tar.gz',
                '1.66.0',
                'd275cd85b00022313c171f602db59fc5',
                { self.gcc : '6.3.1' }
            # ),(
            #     # CY2020
            #     'http://downloads.sourceforge.net/project/boost/boost/1.70.0/boost_1_70_0.tar.gz',
            #     'boost_1_70_0.tar.gz',
            #     '1.70.0',
            #     'fea771fe8176828fabf9c09242ee8c26',
            #     { self.gcc :  '6.3.1' }
            )],
            baseLibs=[python],
            depend=[python, openssl, bzip2, icu],
        )
        self.boost = boost

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.boost)


        # =============================================================================================================================================
        # update rpath for all packages from here
        # =============================================================================================================================================
        # build flags used to build everything
        self.rpath( [
            '$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            '$TIFF_TARGET_FOLDER/lib/',
            '$JPEG_TARGET_FOLDER/lib/',
            '$LIBPNG_TARGET_FOLDER/lib/',
            '$INSTALL_FOLDER/lib/',
            '$LIBRAW_TARGET_FOLDER/lib/',
            '$OPENEXR_TARGET_FOLDER/lib/',
            '$ILMBASE_TARGET_FOLDER/lib/',
            '$HDF5_TARGET_FOLDER/lib/',
            '$GLFW_TARGET_FOLDER/lib/',
            '$ALEMBIC_TARGET_FOLDER/lib/',
            '$USD_TARGET_FOLDER/lib/',
            '$OPENVDB_TARGET_FOLDER/lib/',
            '$OSL_TARGET_FOLDER/lib/',
            '$OPENSUBDIV_TARGET_FOLDER/lib/',
            '$PTEX_TARGET_FOLDER/lib/',
            '$OIIO_TARGET_FOLDER/lib/',
            '$APPLESEED_TARGET_FOLDER/lib/',
            '$TBB_TARGET_FOLDER/lib/',
            '$CLEW_TARGET_FOLDER/lib',
            '$OPENSUBDIV_TARGET_FOLDER/lib',
            '$QT_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            '$INSTALL_FOLDER/lib/',
        ] )
        self.exr_rpath_environ = self.rpath_environ()


        # =============================================================================================================================================
        # build LLVM now so we can use it on all packages build from now

        # use the download action as we only need this package to build llvm!
        # download action will avoid installing this package!
        # we also set keep_source_folder=True so the source folder is not
        # deleted after the build ends.
        clang = build.download(
            ARGUMENTS,
            'clang',
            download=[(
                'http://releases.llvm.org/9.0.0/cfe-9.0.0.src.tar.xz',
                'cfe-9.0.0.src.tar.gz',
                '9.0.0',
                '0df6971e2f99b1e99e7bfb533e4067af',
            ),(
                'https://github.com/llvm/llvm-project/releases/download/llvmorg-7.1.0/cfe-7.1.0.src.tar.xz',
                'cfe-7.1.0.src.tar.gz',
                '7.1.0',
                '2a3651e54e1a9c512d4ee6bd84183cf6',
            ),(
                'http://releases.llvm.org/3.9.1/cfe-3.9.1.src.tar.xz',
                'cfe-3.9.1.src.tar.gz',
                '3.9.1',
                '45713ec5c417ed9cad614cd283d786a1',
            ),(
                'https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang-10.0.1.src.tar.xz',
                'clang-10.0.1.src.tar.gz',
                '10.0.1',
                '6c8b56f531876fd24e06257a2d8ce422',

            )],
        )
        self.clang = clang

        # build llvm using clang source folder that has being
        # just downloaded and uncompressed
        _mem = int(mem)/1024/1024
        llvm_environ = self.exr_rpath_environ.copy()
        llvm_environ['DCORES'] = os.environ['DCORES']
        if 'LLVM_CORES' in ARGUMENTS:
            llvm_environ['CORES']  = str(int(ARGUMENTS['LLVM_CORES'])/2)
            llvm_environ['DCORES'] = ARGUMENTS['LLVM_CORES']
            llvm_environ['HCORES'] = str(int(ARGUMENTS['LLVM_CORES'])/4)
            llvm_environ['LINK_CORES'] = 2
        if 'TRAVIS' in os.environ and os.environ['TRAVIS']=='1':
            llvm_environ['CORES']  = 1
            llvm_environ['DCORES'] = 2
            llvm_environ['HCORES'] = 1
            llvm_environ['LINK_CORES'] = 1
        llvm = build.cmake(
            ARGUMENTS,
            'llvm',
            download=[(
                'http://releases.llvm.org/3.9.1/llvm-3.9.1.src.tar.xz',
                'llvm-3.9.1.src.tar.gz',
                '3.9.1',
                '3259018a7437e157f3642df80f1983ea',
                { self.gcc : '6.3.1', clang : '3.9.1', boost: '1.61.0' }
            ),(
                'https://github.com/llvm/llvm-project/releases/download/llvmorg-7.1.0/llvm-7.1.0.src.tar.xz',
                'llvm-7.1.0.src.tar.gz',
                '7.1.0',
                '26844e21dbad09dc7f9b37b89d7a2e48',
                { self.gcc : '6.3.1', clang : '7.1.0', boost: '1.61.0' }
            ),(
                'http://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz',
                'llvm-9.0.0.src.tar.gz',
                '9.0.0',
                '0fd4283ff485dffb71a4f1cc8fd3fc72',
                { self.gcc : '6.3.1', clang : '9.0.0', boost: '1.61.0'}
            ),(
                'https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/llvm-10.0.1.src.tar.xz',
                'llvm-10.0.1.src.tar.gz',
                '10.0.1',
                '71c68c526cbbf1674b5aafc5542b336c',
                { self.gcc : '6.3.1', clang : '10.0.1', boost: '1.61.0'}
            )],
            sed = {
                '3.5.2' : {
                    # fix 3.5.2 with gcc 5!!
                    'include/llvm/ADT/IntrusiveRefCntPtr.h' : [
                        ('IntrusiveRefCntPtr.IntrusiveRefCntPtr.X.','friend class IntrusiveRefCntPtr;\ntemplate <class X> \nIntrusiveRefCntPtr(IntrusiveRefCntPtr<X>'),
                    ],
                },
            },
            depend=[python, boost, clang],
            cmd = [
                # mv clang to the tools folder so LLVM can automatically build it!
                'mkdir -p $SOURCE_FOLDER/tools/clang/',
                'cp -rfuv $CLANG_TARGET_FOLDER/* $SOURCE_FOLDER/tools/clang/',
                'mkdir -p build && cd build',
                # since llvm link uses lots of memory, we define the number
                # of threads by dividing the ammount of memory in GB by 12
                # 'export DCORES=%s' % LLVM_CORES,
                # 'export MAKE_PARALLEL=" VERBOSE=1 "',
                ' && '.join(build.cmake.cmd),
            ],
            flags = [
                '-DCMAKE_BUILD_TYPE=Release',
                '-DLLVM_ENABLE_RTTI=1',
                '-DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=1',
                '-DLLVM_PARALLEL_COMPILE_JOBS=$DCORES',
                '-DLLVM_PARALLEL_LINK_JOBS=$LINK_CORES',
                '-DGCC_INSTALL_PREFIX=$GCC_TARGET_FOLDER',
            ]+build.cmake.flags,
            environ = llvm_environ,
        )
        self.llvm = llvm

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.llvm, version=['3.9.1', '7.1.0'])
        build.github_phase(self.llvm, version=['9.0.0', '10.0.1'])


        # ============================================================================================================================================
        # build ilmbase/openexr/pyilmbase for each version of boost.
        # we run one loop for each package, so if one package fails, we don't
        # have to rebuild the others next time...
        self.openexr ={}
        self.ilmbase = {}
        self.pyilmbase = {}
        environ = self.exr_rpath_environ.copy()
        environ.update({
            'LDFLAGS' : "$LDFLAGS -Wl,-rpath-link,$ILMBASE_TARGET_FOLDER/lib/:$OPENEXR_TARGET_FOLDER/lib/ ",
            'LD'      : 'ld',
        })
        for boost_version in self.boost.versions:
            gcc_version = '6.3.1'
            sufix = "boost.%s" % boost_version
            ilmbase = build.configure(
                ARGUMENTS,
                'ilmbase',
                targetSuffix=sufix,
                download=[(
                    'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.0.0.tar.gz',
                    'ilmbase-2.0.0.tar.gz',
                    '2.0.0',
                    '70f1413840c2a228783d1332b8b168e6',
                    { self.gcc : gcc_version, python: '2.7.16', boost: boost_version }
                ),(
                    'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.1.0.tar.gz',
                    'ilmbase-2.1.0.tar.gz',
                    '2.1.0',
                    '8ba2f608191ad020e50277d8a3ba0850',
                    { self.gcc : gcc_version, python: '2.7.16', boost: boost_version }
                ),(
                    # CY2016 - CY2018
                    'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz',
                    'ilmbase-2.2.0.tar.gz',
                    '2.2.0',
                    'b540db502c5fa42078249f43d18a4652',
                    { self.gcc : gcc_version, python: '2.7.16', boost: boost_version }
                # ),(
                #     # CY2019 -  *** A compiler with support for C++14 language features is required.
                #     'https://github.com/AcademySoftwareFoundation/openexr/releases/download/v2.3.0/ilmbase-2.3.0.tar.gz',
                #     'ilmbase-2.3.0.tar.gz',
                #     '2.3.0',
                #     '354bf86de3b930ab87ac63619d60c860',
                #     { self.gcc : '6.3.1', python: '2.7.16' }
                )],
                depend=[gcc, python, openssl],
                environ=environ,
                cmd = [
                    './configure  --enable-shared ',
                    'make -j $DCORES',
                    'make -j $DCORES install',
                ],
            )
            self.ilmbase[sufix] = ilmbase

        for boost_version in self.boost.versions:
            gcc_version = '4.1.2' if build.versionMajor(boost_version) < 1.61 else '6.3.1'
            sufix = "boost.%s" % boost_version
            openexr = build.configure(
                ARGUMENTS,
                'openexr',
                targetSuffix=sufix,
                download=[(
                    'http://download.savannah.nongnu.org/releases/openexr/openexr-2.0.0.tar.gz',
                    'openexr-2.0.0.tar.gz',
                    '2.0.0',
                    '0820e1a8665236cb9e728534ebf8df18',
                    { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.0.0', boost: boost_version }
                ),(
                    'http://download.savannah.nongnu.org/releases/openexr/openexr-2.1.0.tar.gz',
                    'openexr-2.1.0.tar.gz',
                    '2.1.0',
                    '33735d37d2ee01c6d8fbd0df94fb8b43',
                    { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.1.0', boost: boost_version }
                ),(
                    # CY2016 - CY2018
                    'http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz',
                    'openexr-2.2.0.tar.gz',
                    '2.2.0',
                    'b64e931c82aa3790329c21418373db4e',
                    { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.2.0', boost: boost_version }
                # ),(
                #     # CY2019
                #     'https://github.com/AcademySoftwareFoundation/openexr/releases/download/v2.3.0/openexr-2.3.0.tar.gz',
                #     'openexr-2.3.0.tar.gz',
                #     '2.3.0',
                #     'a157e8a46596bc185f2472a5a4682174',
                #     { self.gcc : '6.3.1', python: '2.7.16' }
                # ),(
                #     # CY2020 - starting with 2.4.0, seems ilmbase and pyilmbase is included in openexr
                #     'https://github.com/AcademySoftwareFoundation/openexr/archive/v2.4.0.tar.gz',
                #     'openexr-2.4.0.tar.gz',
                #     '2.4.0',
                #     '9e4d69cf2a12c6fb19b98af7c5e0eaee',
                #     { self.gcc : '6.3.1', python: '2.7.16' }
                )],
                sed = { '0.0.0' : { './configure' : [('-L/usr/lib64','')]}}, # disable looking for system  ilmbase
                depend=[gcc, python, openssl],
                environ=environ,
                cmd = [
                    './configure  --enable-shared --with-ilmbase-prefix=$ILMBASE_TARGET_FOLDER',
                    'make -j $DCORES',
                    'make -j $DCORES install',
                ],
            )
            self.openexr[sufix] = openexr

        environ = self.exr_rpath_environ.copy()
        environ.update({
            'LDFLAGS'   : "$LDFLAGS  -Wl,-rpath-link,$ILMBASE_TARGET_FOLDER/lib/:$OPENEXR_TARGET_FOLDER/lib/ ",
            'CFLAGS'    : '$CFLAGS   -std=c++11 -I$BOOST_TARGET_FOLDER/include/boost/ -I$BOOST_TARGET_FOLDER/include/boost/python $CFLAGS ',
            'CXXFLAGS'  : '$CXXFLAGS -std=c++11 -I$BOOST_TARGET_FOLDER/include/boost/ -I$BOOST_TARGET_FOLDER/include/boost/python $CXXFLAGS ',
            'LD'        : 'ld',
            'LDFLAGS'   : '$LDFLAGS -L$TARGET_FOLDER/lib/ -L$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            + '-Wl,-rpath,$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ -L$SOURCE_FOLDER/PyImath/.libs/ ',
            'CPATH' : self.exr_rpath_environ['CPATH'],
            'RPATH' : self.exr_rpath_environ['RPATH'],
        })

        for boost_version in self.boost.versions:
            gcc_version = '4.8.5' if build.versionMajor(boost_version) < 1.61 else '6.3.1' #'4.8.5'
            sufix = "boost.%s" % boost_version
            pyilmbase = build.configure(
                ARGUMENTS,
                'pyilmbase',
                targetSuffix=sufix,
                sed={ '0.0.0' : { 'PyImath/PyImathFixedArray.h' : [
                    ('return _indices;','return _indices!=NULL;')
                ]}},
                download=[(
                    'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.0.0.tar.gz',
                    'pyilmbase-2.0.0.tar.gz',
                    '2.0.0',
                    '4585eba94a82f0b0916445990a47d143',
                    { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.0.0', self.openexr[sufix]: '2.0.0', boost: boost_version }
                ),(
                    'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.1.0.tar.gz',
                    'pyilmbase-2.1.0.tar.gz',
                    '2.1.0',
                    'af1115f4d759c574ce84efcde9845d29',
                    { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.1.0', self.openexr[sufix]: '2.1.0', boost: boost_version }
                ),(
                    'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz',
                    'pyilmbase-2.2.0.tar.gz',
                    '2.2.0',
                    'e84a6a4462f90b5e14d83d67253d8e5a',
                    { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.2.0', self.openexr[sufix]: '2.2.0', boost: boost_version }
                # ),(
                #     'https://github.com/openexr/openexr/releases/download/v2.3.0/pyilmbase-2.3.0.tar.gz',
                #     'pyilmbase-2.3.0.tar.gz',
                #     '2.3.0',
                #     '7ec7fef6f65594acd612bbe9fbefcea3',
                #     { self.gcc : gcc_version, python: '2.7.16', self.ilmbase[sufix]: '2.3.0', openexr: '2.3.0', boost: "1.55.0" }
                )],
                # baseLibs=[python],
                depend=[python, gcc, python],
                environ=environ,
                cmd = [
                    'LD_LIBRARY_PATH=$OPENSSL_TARGET_FOLDER/lib:$LD_LIBRARY_PATH  ./configure  --enable-shared --disable-boostpythontest ',
                    # we have to forcely build libPyImath first, since the build
                    # tries to build imathmodule with libPyImath before
                    # libPyImath is done!
                    # 'cd $SOURCE_FOLDER/PyIex && make -j $DCORES install',
                    # 'sleep 30',
                    # 'cd $SOURCE_FOLDER/PyImath && make libPyImath.la -j $DCORES',
                    # 'sleep 30',
                    # 'cd $SOURCE_FOLDER/PyImath && make imathmodule.la -j $DCORES',
                    # 'sleep 30',
                    # 'cd $SOURCE_FOLDER/ && make -j $DCORES ',
                    # 'sleep 30',
                    # now we can build normaly and install!
                    # 'export DCORES=2',
                    'cd $SOURCE_FOLDER && make install -j $DCORES ; make install  -j $DCORES',
                ],
            )
            self.pyilmbase[sufix] = pyilmbase
        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.pyilmbase[sufix])



        # =============================================================================================================================================
        # Sony Imageworks packages
        # =============================================================================================================================================
        yasm= build.configure(
            ARGUMENTS,
            'yasm',
            download=[(
                'http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz',
                'yasm-1.3.0.tar.gz',
                '1.3.0',
                'fc9e586751ff789b34b1f21d572d96af',
                { self.gcc : '4.1.2', python : '2.7.16'}
            )],
            environ = { 'LD' : 'ld' },
        )
        self.yasm = yasm
        build.globalDependency(self.yasm)

        hdf5 = build.configure(
            ARGUMENTS,
            'hdf5',
            download=[(
                # this is the version tested with USD
                # https://github.com/PixarAnimationStudios/USD/blob/master/VERSIONS.md
                'https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.11/src/hdf5-1.8.11.tar.gz',
                'hdf5-1.8.11.tar.gz',
                '1.8.11',
                '1a4cc04f7dbe34e072ddcf3325717504',
                { self.gcc : '4.8.5', python: '2.7.16' }
            ),(
                'https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.17/src/hdf5-1.8.17.tar.gz',
                'hdf5-1.8.17.tar.gz',
                '1.8.17',
                '7d572f8f3b798a628b8245af0391a0ca',
                { self.gcc : '4.8.5', python: '2.7.16' }
            ),(
                'https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.20/src/hdf5-1.8.20.tar.gz',
                'hdf5-1.8.20.tar.gz',
                '1.8.20',
                '7f2d3fd67106968eb45d133f5a22150f',
                { self.gcc : '4.8.5', python: '2.7.16' }
            )],
            cmd = [
                'unset RPATH', # configure fails if RPATH is defined!
                './configure --enable-shared --enable-cxx --enable-production --with-pthread=/usr/include',
                'make -j $DCORES',
                'make -j $DCORES install',
            ],
            environ = {'LD' : 'ld'},
        )
        self.hdf5 = hdf5

        ocio = build.cmake(
            ARGUMENTS,
            'ocio',
            # ocio for some reason doesn't add -fPIC when building the static external libraries,
            # so we have to patch it or build fail with gcc 4.1.2
            # also, we have to remove -fvisibility-inlines-hidden when building with gcc 4.1.2
            sed = {'0.0.0' : {
                'src/core/Display.h' : [
                    ('endif','endif\n\n')
                ],
                'src/core/Display.cpp' : [
                    ('OCIO_UNIT_TEST','OCIO_UNIT_TEST\n\n')
                ],
            },'1.0.9' : {
                'src/core/CMakeLists.txt' : [
                    ('-Werror', '-Wno-error'),
                ],
                'src/pyglue/CMakeLists.txt' : [
                    ('-Werror', '-Wno-error'),
                ],
                # 'src/core/OCIOYaml.cpp' : [
                #     ('ifndef WIN32', 'if 0'), # disable a block of code
                #     ('ifndef WINDOWS', 'if 0'), # disable a block of code
                # ],
                'ext/tinyxml_2_6_1.patch' : [
                    # ('+    tinystr.cpp','+ '),
                    ('-fPIC', ' -fPIC -DPIC '),
                    # ('-DTIXML_USE_STL', '' ),
                    (' -fvisibility-inlines-hidden', ' -fPIC -Wno-unused -fvisibility=default '),
                    ('-fvisibility=hidden', '  '),
                ],
                'ext/yaml-cpp-0.3.0.patch' : [
                    ('-fPIC', '-fPIC -DPIC '),
                    (' -fvisibility-inlines-hidden', ' -fPIC -Wno-unused -fvisibility=default '),
                    ('-fvisibility=hidden', '  '),
                ],
            },'1.1.0' : {
                'src/core/Display.h' : [
                    ('endif','endif\n\n')
                ],
                'src/core/Display.cpp' : [
                    ('OCIO_UNIT_TEST','OCIO_UNIT_TEST\n\n')
                ],
            }},
            download = [(
                # CY2015 - CY2018
                'https://github.com/imageworks/OpenColorIO/archive/v1.0.9.tar.gz',
                'OpenColorIO-1.0.9.tar.gz',
                '1.0.9',
                '06d0efe9cc1b32d7b14134779c9d1251',
                { self.gcc : '4.1.2' }
            ),(
                # CY2019
                'https://github.com/imageworks/OpenColorIO/archive/v1.1.0.tar.gz',
                'OpenColorIO-1.1.0.tar.gz',
                '1.1.0',
                '802d8f5b1d1fe316ec5f76511aa611b8',
                { self.gcc : '4.1.2' }
            ),(
                # CY2020
                'https://github.com/imageworks/OpenColorIO/archive/v1.1.1.tar.gz',
                'OpenColorIO-1.1.1.tar.gz',
                '1.1.1',
                '23d8b9ac81599305539a5a8674b94a3d',
                { self.gcc : '4.8.5' }
            )],
            baseLibs = [python],
            depend   = [yasm,boost,gcc,python,self.binutils],
            flags    = build.cmake.flags+[
                '-DOCIO_BUILD_APPS=0',
                '-D OCIO_USE_BOOST_PTR=1',
                'OCIO_BUILD_TRUELIGHT=OFF',
                'OCIO_BUILD_NUKE=OFF',
                'CMAKE_AR=$BINUTILS_TARGET_FOLDER/bin/ar'
            ] # -DUSE_EXTERNAL_TINYXML=1  -DUSE_EXTERNAL_YAML=1']
        )
        self.ocio = ocio




        # =============================================================================================================================================
        # build one OIIO version for each boost version.
        exr_version = '2.2.0'
        oiio_version = '2.0.11'
        self.oiio = {}
        self.field3d = {}

        environ = self.exr_rpath_environ.copy()
        for boost_version in self.boost.versions:
            gcc_version = '6.3.1'
            sufix = "boost.%s" % boost_version

            # build sony field3d used by oiio 2.x
            field3d_dependency_versions = {
                hdf5 : '1.8.11',
                boost : boost_version,
                gcc: gcc_version,
                self.ilmbase  [sufix] : exr_version,
                self.pyilmbase[sufix] : exr_version,
                self.openexr  [sufix] : exr_version,
            }
            field3d = build.cmake(
                ARGUMENTS,
                'field3d',
                targetSuffix=sufix,
                download=[(
                    'https://github.com/imageworks/Field3D/archive/v1.7.2.tar.gz',
                    'Field3D-1.7.2.tar.gz',
                    '1.7.2',
                    '61660c2400213ca9adbb3e17782cccfb',
                    field3d_dependency_versions,
                )],
                depend   = [icu],
                environ = environ,
            )
            self.field3d[sufix] = field3d

        # build OIIO for all boost versions
        for boost_version in self.boost.versions:
            gcc_version = '4.1.2' if build.versionMajor(boost_version) < 1.61 else '6.3.1'
            sufix = "boost.%s" % boost_version

            # here we select the versions of OIIO to build for each boost.
            # not all versions build against all boost versions.
            download=[]
            if build.versionMajor(boost_version) <= 1.54:
                download += [[
                    'https://github.com/OpenImageIO/oiio/archive/Release-1.5.24.tar.gz',
                    'oiio-Release-1.5.24.tar.gz',
                    '1.5.24',
                    '8c1f9a0ec5b55a18eeea76d33ca7a02c',
                    { self.gcc : gcc_version,  boost : boost_version, python: '2.7.16', }
                    # { self.gcc : '4.1.2',  boost : "1.51.0", python: '2.7.16', }
                ]]
            if build.versionMajor(boost_version) >= 1.51 and build.versionMajor(boost_version) < 1.70:
                if build.versionMajor(boost_version) != 1.54:
                    download += [[
                            'https://github.com/OpenImageIO/oiio/archive/Release-1.6.15.tar.gz',
                            'oiio-Release-1.6.15.tar.gz',
                            '1.6.15',
                            '3fe2cef4fb5f7bc78b136d2837e1062f',
                            { self.gcc : gcc_version, boost : boost_version, python: '2.7.16',}
                            # { self.gcc : '4.1.2', boost : "1.51.0", python: '2.7.16',}
                    ]]
            if build.versionMajor(boost_version) > 1.53:
                download += [[
                        'https://github.com/OpenImageIO/oiio/archive/Release-1.8.10.tar.gz',
                        'oiio-Release-1.8.10.tar.gz',
                        '1.8.10',
                        'a129a4caa39d7ad79aa1a3dc60cb0418',
                        { self.gcc : gcc_version, boost : boost_version, python: '2.7.16',}
                        # { self.gcc : '6.3.1', boost : bv, python: '2.7.16',}
                    ],[
                        'https://github.com/OpenImageIO/oiio/archive/Release-2.0.11.tar.gz',
                        'oiio-Release-2.0.11.tar.gz',
                        '2.0.11',
                        '4fa0ce4538fb2d7eb72f54f4036972d5',
                        { self.gcc : gcc_version, boost : boost_version, python: '2.7.16',}
                        # { self.gcc : '6.3.1', boost : bv, python: '2.7.16',}
                ]]

            # add the version of exr pkgs (build for the current boost) to all versions
            # we also need to set the current boost version to all versions since we're building
            # one for each boost.
            _download = []+download
            for n in range(len(_download)):

                _download[n][4] = _download[n][4].copy()
                _download[n][4][ boost ] = boost_version
                if build.versionMajor( _download[n][4][ gcc ] ) < 4.8:
                    _download[n][4][ gcc ] = '4.8.5'
                _download[n][4][ self.ilmbase  [sufix] ] = exr_version
                _download[n][4][ self.pyilmbase[sufix] ] = exr_version
                _download[n][4][ self.openexr  [sufix] ] = exr_version
                _download[n][4][ self.field3d  [sufix] ] = '1.7.2'

            oiio = build.cmake(
                ARGUMENTS,
                'oiio',
                targetSuffix=sufix,
                # oiio has some hard-coded path to find python, and the only
                # way to make it respect the PYTHON related environment variables,
                # is to patch some files to force it!
                sed = {
                    '0.0.0' : {
                        'src/python/CMakeLists.txt' : [
                            ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                            ('unset.*PYTHON_INCLUDE','#unset( PYTHON_INCLUDE'),
                            ('unset.*PYTHON_LIBRARY','#unset( PYTHON_LIBRARY'),
                            ('/usr/include/python','${PYTHON_ROOT}/include/python'),
                        ],
                        'CMakeLists.txt' : [
                            ('lib/python/site-packages','lib/python${PYTHON_VERSION_MAJOR}/site-packages'),
                            ('-std=c++11',''), # we need this to build with gcc 4.1.2
                        ],
                    },
                },
                download = _download,
                depend=[ocio, python, boost, freetype, gcc, icu, cmake, openssl, bzip2, libraw, libpng, tbb],
                cmd = 'mkdir -p build && cd build && '+' && '.join(build.cmake.cmd),
                flags = [
                    '-DUSE_PYTHON=0',
                    '-DUSE_PTEX=0',
                    '-DUSE_OCIO=0',
                    '-DCMAKE_PREFIX_PATH='+"';'".join([
                        '$OPENEXR_TARGET_FOLDER',
                        '$ILMBASE_TARGET_FOLDER',
                        '$JPEG_TARGET_FOLDER',
                        '$LIBRAW_TARGET_FOLDER',
                        '$LIBPNG_TARGET_FOLDER',
                        '$LIBTIFF_TARGET_FOLDER',
                    ])
                ]+build.cmake.flags,
                environ = environ,
            )
            self.oiio[sufix] = oiio




        # bison = build.configure(
        #     ARGUMENTS,
        #     'bison',
        #     download=[(
        #         'http://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.gz',
        #         'bison-3.0.4.tar.gz',
        #         '3.0.4',
        #         'a586e11cd4aff49c3ff6d3b6a4c9ccf8'
        #     ),(
        #         'http://ftp.gnu.org/gnu/bison/bison-3.4.tar.gz',
        #         'bison-3.4.0.tar.gz',
        #         '3.4.0',
        #         'a586e11cd4aff49c3ff6d3b6a4c9ccf8'
        #     )],
        # )
        # self.bison = bison
        # build.allDepend.append(bison)

        pugixml = build.cmake(
            ARGUMENTS,
            'pugixml',
            download=[(
                'https://github.com/zeux/pugixml/archive/v1.10.tar.gz',
                'pugixml-1.10.tar.gz',
                '1.10.0',
                '0c208b0664c7fb822bf1b49ad035e8fd',
                { self.gcc : '4.8.5', python: '2.7.16' },
            )],
            environ = { 'LD' : 'ld' },
        )
        self.pugixml = pugixml

        glfw = build.glfw(
            ARGUMENTS,
            'glfw',
            download=[(
                'https://github.com/glfw/glfw/archive/3.3.tar.gz',
                'glfw-3.3.tar.gz',
                '3.3.0',
                '5be03812f5d109817e6558c3fab7bbe1',
                { self.gcc : '4.1.2' },
            )],
            depend=[python, glew],
            flags = [
                '-DBUILD_SHARED_LIBS=1',
            ]+build.glfw.flags
        )
        self.glfw = glfw

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.glfw)


        #
        # nanogui_glfw = build.download(
        #     ARGUMENTS,
        #     'nanogui_glfw',
        #     download=[(
        #         'https://github.com/wjakob/glfw/archive/6a0dde2a65448bb54dee7a45979f3ebe72253a19.zip',
        #         'glfw-6a0dde2a65448bb54dee7a45979f3ebe72253a19.zip',
        #         '6a0dde',
        #         '56f932e0a7e0ccc0dff4ed338e93e2d3',
        #     )],
        #     keep_source_folder=True,
        # )
        # nanogui = build.cmake(
        #     ARGUMENTS,
        #     'nanogui',
        #     sed = {'0.0.0' : {
        #         'CMakeLists.txt' : [
        #             ('PythonLibsNew','PythonLibs'),
        #         ],
        #     },},
        #     download=[(
        #         'https://github.com/wjakob/nanogui.git',
        #         'nanogui-e9ec8.zip',
        #         'e9ec8',
        #         None, # git clonned zip gives a different md5sum everytime, so disable it for now.
        #         { self.gcc : '4.8.5', python: '3.7.5' },
        #     )],
        #     depend=[python, freeglut],
        #     flags = [
        #         '-DCMAKE_PREFIX_PATH=$PYTHON_TARGET_FOLDER',
        #         '-DNANOGUI_PYTHON_VERSION=$PYTHON_VERSION',
        #
        #     ],
        # )
        # self.nanogui = nanogui

        qt = build.configure(
            ARGUMENTS,
            'qt',
            download=[(
            #     # VFXPLATFORM CY2014
            #     'https://download.qt.io/archive/qt/4.8/4.8.5/qt-everywhere-opensource-src-4.8.5.tar.gz',
            #     'qt-everywhere-opensource-src-4.8.5.tar.gz',
            #     '4.8.5',
            #     '89c5ecba180cae74c66260ac732dc5cb',
            # ),(
                # VFXPLATFORM CY2015 (maya 2016)
                'http://ftp.fau.de/qtproject/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz',
                'qt-everywhere-opensource-src-4.8.7.tar.gz',
                '4.8.7',
                'd990ee66bf7ab0c785589776f35ba6ad',
                { self.gcc : '4.1.2' }
            ),(
                # VFXPLATFORM CY2016-CY2018 (maya 2018)
                # http://www.autodesk.com/lgplsource
                # 'http://mirror.csclub.uwaterloo.ca/qtproject/archive/qt/5.6/5.6.1/single/qt-everywhere-opensource-src-5.6.1.tar.gz',
                # 'qt-everywhere-opensource-src-5.6.1.tar.gz',
                # 'ed16ef2a30c674f91f8615678005d44c',
                'https://damassets.autodesk.net/content/dam/autodesk/www/Company/files/2018/Qt561ForMaya2018Update4.zip',
                'qt-adsk-5.6.1-vfx.zip',
                '5.6.1',
                '5e4de3cef0225d094c1ab718c1fc468b',
                { self.gcc : '4.8.5' }
            ),(
                # VFXPLATFORM CY2019-CY2020 (maya 2022??)
                'http://download.qt.io/official_releases/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.tar.xz',
                'qt-everywhere-src-5.15.2.tar.gz',
                '5.15.2',
                'e1447db4f06c841d8947f0a6ce83a7b5',
                { self.gcc : '6.3.1' }
            )],
            sed = { '5.6.1' : {
                'qtserialbus/src/plugins/canbus/socketcan/socketcanbackend.cpp': [
                    ('.ifndef CANFD_MTU','#include <linux\/sockios.h>\\n\\n#ifndef CANFD_MTU')
                ]
            }} if 'fedora' in  distro else {},
            environ = {
                'LD' : '$CXX -fPIC -L$SOURCE_FOLDER/lib/',
                'CC' : '$CC -fPIC',
                'CXX' : '$CXX -fPIC',
                'LD_LIBRARY_PATH' : '$SOURCE_FOLDER/lib/:$LD_LIBRARY_PATH',
                'LDFLAGS' : '$LDFLAGS -ljpeg'
            },
            cmd = [
                # if building 5.6.1, we have to use autodesk qt patches to be
                # VFXPLATFORM complaint (CY2016 to CY2018)
                # https://vfxplatform.com/#footnote-qt
                # it also helps with maya compatibility.
                # We have to create a different configure line for each version,
                # since QT loves to keep changing the configure options on almost
                # every release, and configure fails if you leave options it
                # doesnt known!
                '( [ "$(basename $TARGET_FOLDER)" == "4.8.7" ] && '
                    './configure  -opensource -shared --confirm-license  -no-webkit -silent '
                '|| true ; [ "$(basename $TARGET_FOLDER)" == "5.6.1" ] && '
                    './configure -plugindir $INSTALL_FOLDER/qt/plugins -release -opensource --confirm-license '
                    '-no-rpath -no-gtkstyle -no-audio-backend -no-dbus '
                    '-skip qtconnectivity -skip qtwebengine -skip qt3d -skip qtdeclarative '
                    '-no-libudev -no-gstreamer -no-icu -qt-pcre -qt-xcb '
                    '-nomake examples -nomake tests -c++std c++11 '
                '|| true ; [ "$(basename $TARGET_FOLDER)" == "5.15.2" ] && '
                    './configure -plugindir $INSTALL_FOLDER/qt/plugins -release -opensource --confirm-license '
                    # '-skip qtconnectivity -skip qtwebengine -skip qt3d -skip qtdeclarative '
                    # '-no-libudev -no-gstreamer '
                    '-qt-pcre -no-dbus '
                    '-nomake examples -nomake tests -c++std c++11 -sse2 -no-sse3 '
                '|| true )',
                'make -j $DCORES',
                'make -j $DCORES install',
            ],
            depend=[
                self.tiff, self.jpeg, self.libpng, self.freetype,
                self.freeglut, self.glew, self.gcc, self.icu
                # qtMaya, qtMayaDeclarative, qtMayaX11Extras,
            # ]+[ x for x in self.allDepend if python != x ],
            ],
            verbose=1,
            # we need this since we're not building QT 5.6.1 yet.
            # without it the build would fail due to being less than 5 secs
            noMinTime=True,
        )
        self.qt = qt
        self.rpath( [
            '$QT_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
        ] )
        self.qt_rpath_environ = self.rpath_environ()

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.qt)


        # qt packages
        # =============================================================================================================================================
        qtpy = build.download(
            ARGUMENTS,
            'qtpy',
            download=[(
                'https://github.com/mottosso/Qt.py/archive/1.1.0.b3.tar.gz',
                'Qt.py-1.1.0.b3.tar.gz',
                '1.1.0.b3',
                '5c1acbf9bdec2359d414cc7d2a2b6b7f',
            ),(
                'https://github.com/mottosso/Qt.py/archive/1.2.5.tar.gz',
                'Qt.py-1.2.5.tar.gz',
                '1.2.5',
                'a10bc14327d7c38fb3611b4d0daf58fb',
            )],
            cmd = [
                'rm -rf $INSTALL_FOLDER/*',
                'mkdir -p $INSTALL_FOLDER/lib/python/site-packages/src',
                'ln -s python $INSTALL_FOLDER/lib/python2.6',
                'ln -s python $INSTALL_FOLDER/lib/python2.7',
                'ln -s python $INSTALL_FOLDER/lib/python3.5',
                'ln -s python $INSTALL_FOLDER/lib/python3.6',
                'ln -s python $INSTALL_FOLDER/lib/python3.7',
                'ln -s python $INSTALL_FOLDER/lib/python3.8',
                'ln -s lib $INSTALL_FOLDER/lib64',
                'cp -rf ./Qt.py $INSTALL_FOLDER/lib/python/site-packages/',
                'cp -rf ./* $INSTALL_FOLDER/lib/python/site-packages/src/',
                'echo "This build was done suscessfully!!"',
            ],
            src = 'Qt.py',
            noMinTime=True,
        )
        self.qtpy = qtpy

        sip = build.pythonSetup(
            ARGUMENTS,
            'sip',
            download=[(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.15.5/sip-4.15.5.tar.gz',
                'sip-4.15.5.tar.gz',
                '4.15.5',
                '4c95447c7b0391b7f183cf9f92ae9bc6',
                { self.gcc : '4.1.2', qt : '4.8.7' }
            ),(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.16.7/sip-4.16.7.tar.gz',
                'sip-4.16.7.tar.gz',
                '4.16.7',
                '32abc003980599d33ffd789734de4c36',
                { self.gcc : '4.1.2', qt : '4.8.7' }
            ),(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.16.4/sip-4.16.4.tar.gz',
                'sip-4.16.4.tar.gz',
                '4.16.4',
                'a9840670a064dbf8f63a8f653776fec9',
                { self.gcc : '4.1.2', qt : '4.8.7' }
            ),(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.18/sip-4.18.tar.gz',
                'sip-4.18.tar.gz',
                '4.18.0',
                '78724bf2a79878201c3bc81a1d8248ea',
                { self.gcc : '4.8.5', qt : '5.6.0' }
            ),(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.18.1/sip-4.18.1.tar.gz',
                'sip-4.18.1.tar.gz',
                '4.18.1',
                '9d664c33e8d0eabf1238a7ff44a399e9',
                { self.gcc : '4.8.5', qt : '5.12.0' }
            # ),(
            #     'https://sourceforge.net/project/pyqt/files/sip/sip-4.19.13/sip-4.19.13.tar.gz',
            #     'sip-4.19.13.tar.gz',
            #     '4.19.13',
            #     '9124cb8978742685747a5415179a9890',
            #     { self.gcc : '4.1.2' }
            )],
            baseLibs=[python],
            src = 'configure.py',
            cmd = [
                # 'python configure.py --sysroot=$INSTALL_FOLDER CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" ',
                # '( [ "$(basename $TARGET_FOLDER)" == "4.16.7" ]',
                'python configure.py '
                '-b $INSTALL_FOLDER/bin '
                '-d $INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ '
                '-e $INSTALL_FOLDER/include/python$PYTHON_VERSION_MAJOR/ '
                '-v $INSTALL_FOLDER/share/sip/ '
                'CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" ',
                'mv specs specs__ ',
                'make -j $DCORES && make -j $DCORES install'
                # ' ) || echo -e "\n\nnot building sip for qt 5 for now!!\n\n" ',
            ],
            depend = [qt],
            noMinTime=True,
        )
        self.sip = sip

        pyqt = build.pythonSetup(
            ARGUMENTS,
            'pyqt',
            download=[(
                # CY 2014-2015
                'http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz',
                'PyQt-x11-gpl-4.11.4.tar.gz',
                '4.11.4',
                '2fe8265b2ae2fc593241c2c84d09d481',
                { qt:'4.8.7', sip: '4.16.7', self.gcc : '4.8.5'},
            ),(
                # CY 2016-2018
                'https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.6/PyQt5_gpl-5.6.tar.gz',
                'PyQt5_gpl-5.6.tar.gz',
                '5.6.0',
                'dbfc885c0548e024ba5260c4f44e0481',
                { qt:'5.6.1', sip: '4.18.0', self.gcc : '4.8.5' },
            ),(
                # CY 2019-2020
                'https://www.riverbankcomputing.com/static/Downloads/PyQt5/5.12/PyQt5_gpl-5.12.tar.gz',
                'PyQt5_gpl-5.12.tar.gz',
                '5.12.0',
                '0d839c6218a4287d51bf79d6195016f0',
                { qt:'5.12.0', sip: '4.18.1', self.gcc : '4.8.5' },
            )],
            baseLibs=[python],
            depend=[sip, qt, gcc],
            src = 'configure.py',
            cmd = [
                '( [ "$(basename $TARGET_FOLDER)" == "4.11.4" ]  && '
                        'python configure.py --confirm-license --assume-shared --protected-is-public  CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" '
                        '-b $INSTALL_FOLDER/bin -d $INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages '
                        '-p $INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/plugins '
                        '&& make -j $DCORES '
                            'CFLAGS="$CFLAGS -DPYTHON_LIB=\\\\\\\"libpython$PYTHON_VERSION_MAJOR.so\\\\\\\"" '
                            'CXXFLAGS="$CXXFLAGS -DPYTHON_LIB=\\\\\\\"libpython$PYTHON_VERSION_MAJOR.so\\\\\\\"" '
                        '&& make -j $DCORES CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" install '
                    # =======================================================
                    # TODO: PyQt5 is failing to build, not sure why.
                    # for now, we will be using PySide2 for maya 2018 and up,
                    # since it build without problems!
                    # =======================================================
                    # '|| '
                    #     'python configure.py --confirm-license --verbose --no-designer-plugin -w --protected-is-public  --sysroot=$INSTALL_FOLDER '
                    #     '-b $INSTALL_FOLDER/bin '
                    #     '-d $INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ '
                    #     "-v $INSTALL_FOLDER/share/sip/PyQt$(echo $QT_VERSION | awk -F'.' '{print $1}') "
                    #     'CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" '
                    #     '&& make -j $DCORES CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" '
                    #     '&& make -j $DCORES CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" install '
                ')'
                # we return true if pyqt 5 since we want to download
                # the pkgs to keep then around, but not build then.
                ' || echo -e "\n\n NOT BUILDING PYQT5 FOR NOW! (more info in pkgs.py)\n\n"'
            ],
            noMinTime=True,
        )
        self.pyqt = pyqt

        pyside = build.pythonSetup(
            ARGUMENTS,
            'pyside',
            # install is broken in pyside2 2.0.18, and it won't install sub-modules.
            # this patch fixes that, and USD can be built now!
            sed = { '2.0.18' : { './setup.py' : [
                ('packages.....PySide2.*pyside2uic.\]','''packages = \['PySide2', 'pyside2uic', 'pyside2uic.Compiler', 'pyside2uic.port_v2'\]'''),
                ('OPTION_VERSION = ','OPTION_VERSION = False #'),
            # ]}, '2.0.19' : { './setup.py' : [
            #     ('packages.....PySide2.*pyside2uic.\]','''packages = \['PySide2', 'pyside2uic', 'pyside2uic.Compiler', 'pyside2uic.port_v2', 'pyside2uic.port_v3'\]'''),
            ]}},
            download=[(
               # CY 2016-2018 (maya 2018.4)
               'https://www.autodesk.com/content/dam/autodesk/www/Company/files/pyside2-maya2018.4.zip',
               'pyside2-maya2018.4.zip',
               '2.0.18',
               'aa93469f528db7ce9a596f36828102dc',
               { self.qt: '5.6.1', self.gcc : '6.3.1',
               self.python: '2.7.16', self.llvm: '7.1.0' },
            ),(
               # CY 2016-2018 (maya 2018.6 and maya 2019.1)
               'https://www.autodesk.com/content/dam/autodesk/www/Company/files/PySide2-Maya-2018_6.tgz',
               'pyside2-maya2018.6.tar.gz',
               '2.0.19',
               '84558ad5952c5d86a648f319978413e9',
               { self.qt: '5.6.1', self.gcc : '6.3.1',
               self.python: '2.7.16', self.llvm: '7.1.0' },
            ),(
               # CY 2019-2020 (maya 2022??)
               'https://download.qt.io/official_releases/QtForPython/pyside2/PySide2-5.15.2-src/pyside-setup-opensource-src-5.15.2.tar.xz',
               'pyside-setup-opensource-src-5.15.2.tar.gz',
               '5.15.2',
               'e9bb6b57d39eb6cf1720cd3589a8b76a',
               { self.qt: '5.15.2', self.gcc : '6.3.1',
               self.python: '2.7.16', self.llvm: '7.1.0' },
            )],
            # since booth files create the same path, we have to instruct the
            # decompressor to use the same folder name for booth.
            uncompressed_path = {
                'pyside2-maya2018.4' : 'pyside-setup',
                'pyside2-maya2018.6' : 'pyside-setup',
            },
            # baseLibs=[python],
            depend=[self.qt, self.gcc, self.patchelf],
            environ={
                # to be able to use gcc and llvm togheter, we have to add
                # GCC search paths in CC/CXX/LD env vars, since LLVM
                # search path is added by the system first than GCC.
                # As we're using -nostdinc, we have to tell GCC where the
                # correct includes are!
                # we add the main system one for last!
                # we also use -isystem so these come before any *_INCLUDE_PATH
                # env vars searchpath.
                # We only have to do this with OSL, since it's the only one
                # that uses gcc and llvm on the same build!
                'CXX':  'g++  -isystem$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/'
                            ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/'
                            ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/x86_64-pc-linux-gnu/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/x86_64-pc-linux-gnu/'
                            ' -isystem/usr/include',
                'CC' :  'gcc -isystem$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/'
                            ' -isystem/usr/include',
                'LD' :  'g++ '
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',

                'LDFLAGS' : ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',
                'RPATH'   : self.qt_rpath_environ['RPATH'],
                'CPATH'   : self.qt_rpath_environ['CPATH'],
            },
            cmd = [
                # we need to setup differently for pyside < 5
                '''[ $(basename $TARGET_FOLDER | awk -F'.' '{print $1}') -lt 5 ] ''',
                # since pyside 5 needs llvm, patchelf won't build in pyside 2
                # so we use the one we already have in the pipe by symlinking it
                '(rm -rf ./patchelf ',
                'ln -s $PATCHELF_TARGET_FOLDER/bin/patchelf ./',
                "sed -i.bak -e 's/self.build_patchelf/#self.build_patchelf/' ./setup.py",
                build.pythonSetup.cmd[0]+' --jobs=$DCORES ) || true',
                '''[ $(basename $TARGET_FOLDER | awk -F'.' '{print $1}') -ge 5 ] ''',
                '(mkdir build',
                'cd build',
                'cmake ../ -DCMAKE_INSTALL_PREFIX=$INSTALL_FOLDER -DQT_SRC_DIR=$QT_TARGET_FOLDER/',
                'make -j $DCORES install ) || true',
                # create symbolic links of the libraries in the correct place,
                # so pipeVFX can find it - this is needed when building maya related
                # code to avoid picking up maya version of those libraries.
                '[ -e $INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/PySide2/lib ]',
                'ln -s $INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/PySide2/lib* '
                      '$INSTALL_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ || true'
            ],
        )
        self.pyside = pyside
        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.pyside)


        log4cplus = build.configure(
            ARGUMENTS,
            'log4cplus',
            download=[(
                'https://github.com/log4cplus/log4cplus/archive/REL_1_2_0.tar.gz',
                'log4cplus-REL_1_2_0.tar.gz',
                '1.2.0',
                'b39900d6b504726a20819f2ad73f5877',
                { self.gcc : '4.1.2' }
            )],
            depend=[gcc],
        )
        self.log4cplus = log4cplus
        build.globalDependency(self.log4cplus)

        blosc = build.cmake(
            ARGUMENTS,
            'blosc',
            download=[(
                'https://github.com/Blosc/c-blosc/archive/1.15.1.tar.gz',
                'c-blosc-1.15.1.tar.gz',
                '1.15.1',
                'ff2f5a0fe5c7a8a9e2eb0c6f224e2823',
                { self.gcc : '4.8.5' }
            ),(
                'https://github.com/Blosc/c-blosc/archive/refs/tags/v1.5.0.tar.gz',
                'c-blosc-1.5.0.tar.gz',
                '1.5.0',
                '6e4a49c8c06f05aa543f3312cfce3d55',
                { self.gcc : '4.8.5' }
            )],
            depend=[gcc],
            flags=['-DCMAKE_INSTALL_PREFIX=$INSTALL_FOLDER '],
            # environ = { 'LD' : 'ld', 'LD_LIBRARY_PATH' : '$GCC_TARGET_FOLDER/lib64/:$LD_LIBRARY_PATH'  },
            noMinTime=True,
        )
        self.blosc = blosc
        build.globalDependency(self.blosc)

        ptex = build.cmake(
            ARGUMENTS,
            'ptex',
            sed = {},
            download=[(
                # CY 2020
                'https://github.com/wdas/ptex/archive/v2.3.2.tar.gz',
                'ptex-2.3.2.tar.gz',
                '2.3.2',
                'd409eecde96f89517bc271b1d4909bc5',
                { cmake: '3.8.2', self.gcc : '6.3.1' }
            ),(
                # CY 2019
                'https://github.com/wdas/ptex/archive/v2.1.33.tar.gz',
                'ptex-2.1.33.tar.gz',
                '2.1.33',
                'ce1f1af2a151a2bf1057e0456c91dbb6',
                { cmake: '3.8.2', self.gcc : '4.1.2' }
            ),(
                # CY 2017-2018
                'https://github.com/wdas/ptex/archive/v2.1.28.tar.gz',
                'ptex-2.1.28.tar.gz',
                '2.1.28',
                'ce4eb665f686f8391968fa137113bc69',
                { cmake: '3.8.2', self.gcc : '4.1.2' }
            ),(
                # CY 2016
                'https://github.com/wdas/ptex/archive/v2.0.42.tar.gz',
                'ptex-2.0.42.tar.gz',
                '2.0.42',
                '09450bd49dab3db878504a6e51c0745d',
                { cmake: '3.8.2', self.gcc : '4.1.2' }
            )],
            src = 'README',
            environ={
                'C_INCLUDE_PATH'     : '$C_INCLUDE_PATH:$ILMBASE_TARGET_FOLDER/include/OpenEXR/',
                'CPLUS_INCLUDE_PATH' : '$CPLUS_INCLUDE_PATH:$ILMBASE_TARGET_FOLDER/include/OpenEXR/',
                'CPATH' : self.exr_rpath_environ['CPATH'],
                'RPATH' : self.exr_rpath_environ['RPATH'],
            },
            cmd = [
                '( [ "$(basename $TARGET_FOLDER)" == "2.0.42" ] ',
                    'cd src',
                    'make',
                    'cp -rfuv ../install/* $INSTALL_FOLDER/',
                    'cp $INSTALL_FOLDER/lib/* $INSTALL_FOLDER/lib64/'
                ' ) || ( '+\
                    ' && '.join(build.cmake.cmd).replace('cmake','cmake -DPTEX_VER=$(basename $TARGET_FOLDER)'),
                    'cp $INSTALL_FOLDER/lib64/* $INSTALL_FOLDER/lib/'
                ' )'
            ]
        )
        self.ptex = ptex
        build.globalDependency(self.ptex)

        # alternative for glibc malloc in USD.
        # USD relies on deprecated mallocHook, not available in newer GLIBC
        self.jemalloc = build.configure(
            ARGUMENTS,
            'jemalloc',
            download=[(
                'https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2',
                'jemalloc-5.2.1.tar.gz',
                '5.2.1',
                '3d41fbf006e6ebffd489bdb304d009ae',
                { self.gcc : '6.3.1' }
            )],
        )

        embree = build.download(
            ARGUMENTS,
            'embree',
            src='embree-config.cmake',
            download=[(
                'https://github.com/embree/embree/releases/download/v3.5.2/embree-3.5.2.x86_64.linux.tar.gz',
                'embree-3.5.2.x86_64.linux.tar.gz',
                '3.5.2',
                '67c768858956f1257ac71cfeb5d607cf',
            ),(
                'https://github.com/embree/embree/releases/download/v3.6.1/embree-3.6.1.x86_64.linux.tar.gz',
                'embree-3.6.1.x86_64.linux.tar.gz',
                '3.6.1',
                '3b6012add9dfc9ea8137ada5e0bd27b9',
            ),(
                'https://github.com/embree/embree/releases/download/v3.2.2/embree-3.2.2.x86_64.linux.tar.gz',
                'embree-3.2.2.x86_64.linux.tar.gz',
                '3.2.2',
                '7d79863211c0b5d8061dd738c600a2b6',
            )],
            environ = environ,
        )
        self.embree = embree



        # =============================================================================================================================================
        # from now on, we build all packages for boost version > 1.60
        # for bv in [ x for x in self.boost.versions if build.versionMajor(x) > 1.60 ]:
        self.osl = {}
        self.materialx = {}
        self.openvdb = {}
        self.alembic = {}
        self.clew = {}
        self.opensubdiv = {}
        self.lz4 = {}
        self.seexpr = {}
        self.xerces = {}
        self.usd = {}

        environ = self.exr_rpath_environ.copy()
        environ.update( {
                # to be able to use gcc and llvm togheter, we have to add
                # GCC search paths in CC/CXX/LD env vars, since LLVM
                # search path is added by the system first than GCC.
                # As we're using -nostdinc, we have to tell GCC where the
                # correct includes are!
                # we add the main system one for last!
                # we also use -isystem so these come before any *_INCLUDE_PATH
                # env vars searchpath.
                # We only have to do this with OSL, since it's the only one
                # that uses gcc and llvm on the same build!
                'CXX':  'g++  -isystem$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/'
                            ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/'
                            ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/x86_64-pc-linux-gnu/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/x86_64-pc-linux-gnu/'
                            ' -isystem/usr/include',
                'CC' :  'gcc -isystem$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/'
                            ' -isystem/usr/include',
                'LD' :  'g++ '
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',

                'LDFLAGS' : ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',
                'CPATH' : self.exr_rpath_environ['CPATH'],
                'RPATH' : self.exr_rpath_environ['RPATH'],
        })

        for bv in ['1.66.0']:
            bsufix = "boost.%s" % bv

            osl = build.cmake(
                ARGUMENTS,
                'osl',
                targetSuffix=bsufix,
                sed = {
                    '0.0.0' : {
                        'CMakeLists.txt' : [
                            ('add_definitions.*Wno.error=strict.overflow','#add_definitions ("-Wno-error=strict-overflow")'),
                        ],
                        'src/cmake/externalpackages.cmake' : [
                            ('--libfiles', '--libfiles --system-libs'),
                            ('string (REPLACE " " ";" LLVM_LIBRARY ${LLVM_LIBRARY})', 'string (REPLACE "\\\\\\n" " " LLVM_LIBRARY ${LLVM_LIBRARY})\nstring (REPLACE " " ";" LLVM_LIBRARY ${LLVM_LIBRARY})'),
                        ]
                    },
                    '1.10.0' : {
                    },
                },
                download=[(
                    'https://github.com/imageworks/OpenShadingLanguage/archive/Release-1.10.7.tar.gz',
                    'OpenShadingLanguage-Release-1.10.7.tar.gz',
                    '1.10.7',
                    '53f66e12c3e29c62dc51b070f027a0ad',
                    { self.llvm: "7.1.0", self.gcc: "6.3.1",
                    self.boost: bv, self.qt: '5.6.1',
                    self.oiio[bsufix]:"1.8.10",
                    self.oiio[bsufix]["1.8.10"]['ilmbase'].obj:  self.oiio[bsufix]["1.8.10"]['ilmbase'],
                    self.oiio[bsufix]["1.8.10"]['openexr'].obj:  self.oiio[bsufix]["1.8.10"]['ilmbase']}
                ),(
                    'https://github.com/imageworks/OpenShadingLanguage/archive/Release-1.11.14.1.tar.gz',
                    'OpenShadingLanguage-Release-1.11.14.1.tar.gz',
                    '1.11.14',
                    '1abd7ce40481771a9fa937f19595d2f2',
                    { self.llvm: "7.1.0", self.gcc: "6.3.1",
                    self.boost: bv, self.qt: '5.6.1',
                    self.oiio[bsufix]:oiio_version,
                    self.oiio[bsufix][oiio_version]['ilmbase'].obj:  self.oiio[bsufix][oiio_version]['ilmbase'],
                    self.oiio[bsufix][oiio_version]['openexr'].obj:  self.oiio[bsufix][oiio_version]['ilmbase']}
                )],
                depend=[self.icu, self.cmake, self.pugixml, self.freetype,
                        self.openssl, self.bzip2, self.libraw, self.pybind],
                cmd = [
                    'make '
                    'USE_CPP11=1 '
                    'INSTALLDIR=$INSTALL_FOLDER '
                    'INSTALL_PREFIX=$INSTALL_FOLDER '
                    'OPENIMAGEHOME=$OIIO_TARGET_FOLDER'
                    'BOOST_ROOT=$BOOST_TARGET_FOLDER '
                    'LLVM_DIRECTORY=$LLVM_TARGET_FOLDER '
                    'LLVM_STATIC=0 '
                    'OSL_BUILD_MATERIALX=1 '
                    'OSL_SHADER_INSTALL_DIR=$INSTALL_FOLDER/shaders '
                    'Python_ROOT_DIR=$PYTHON_TARGET_FOLDER/ '
                    'Python_FIND_STRATEGY=LOCATION '
                    'pybind11_ROOT=$PYBIND_TARGET_FOLDER/ '
                    'PARTIO_HOME="" '
                    'STOP_ON_WARNING=0 '
                    'ILMBASE_HOME=$ILMBASE_TARGET_FOLDER '
                    'OPENEXR_HOME=$OPENEXR_TARGET_FOLDER '
                    'BOOST_HOME=$BOOST_TARGET_FOLDER '
                    'USE_LIBCPLUSPLUS=0 '
                    'HIDE_SYMBOLS=0 '
                    'MY_CMAKE_FLAGS="-DENABLERTTI=1 -DPUGIXML_HOME=$PUGIXML_TARGET_FOLDER -DLLVM_STATIC=0  -DOSL_BUILD_CPP11=1 '+" ".join(build.cmake.flags).replace('"','\\"').replace(';',"';'").replace(" ';' "," ; ")+'" '
                    'MY_MAKE_FLAGS=" USE_CPP11=1 '+" ".join(map(lambda x: x.replace('-D',''),build.cmake.flags)).replace('"','\\"').replace(';',"';'").replace(" ';' "," ; ").replace("CMAKE_VERBOSE","MAKE_VERBOSE")+' ENABLERTTI=1" '
                    # 'install '
                ],
                environ = environ,
                verbose=1,
            )
            self.osl[bsufix] = osl
            latest_osl = self.osl[bsufix][ self.osl[bsufix].keys()[-1] ]

            # materialx don't need boost.
            materialx = build.cmake(
                ARGUMENTS,
                'materialx',
                download=[(
                #     'https://github.com/materialx/MaterialX.git',
                #     'MaterialX-v1.36.4.zip',
                #     'v1.36.4',
                #     None,
                #     { self.gcc : '6.3.1', python: '2.7.6' },
                # ),(
                    # used by USD 20.8
                    'https://github.com/materialx/MaterialX/releases/download/v1.37.4/MaterialX-1.37.4.tar.gz',
                    'MaterialX-1.37.4.tar.gz',
                    '1.37.4',
                    'fdc0efb49f3170fc1e7baaf714df3e31',
                    { self.gcc : '6.3.1', python: '2.7.6', osl: '1.10.7',
                    latest_osl['oiio'   ].obj: latest_osl['oiio'],
                    latest_osl['openexr'].obj: latest_osl['openexr'],
                    latest_osl['ilmbase'].obj: latest_osl['ilmbase']}
                ),(
                    # USD 21.X moved to 1.38.0
                    'https://github.com/materialx/MaterialX/releases/download/v1.38.0/MaterialX-1.38.0.tar.gz',
                    'MaterialX-1.38.0.tar.gz',
                    '1.38.0',
                    'b8bc253454164b0c19600eb0f925d654',
                    { self.gcc : '6.3.1', python: '2.7.6', osl: '1.10.7',
                    latest_osl['oiio'   ].obj: latest_osl['oiio'],
                    latest_osl['openexr'].obj: latest_osl['openexr'],
                    latest_osl['ilmbase'].obj: latest_osl['ilmbase']}

                ),(
                    'https://github.com/materialx/MaterialX/releases/download/v1.38.1/MaterialX-1.38.1.tar.gz',
                    'MaterialX-1.38.1.tar.gz',
                    '1.38.1',
                    '578a1b63263281414e1594d44409b882',
                    { self.gcc : '6.3.1', python: '2.7.6', osl: '1.10.7',
                    latest_osl['oiio'   ].obj: latest_osl['oiio'],
                    latest_osl['openexr'].obj: latest_osl['openexr'],
                    latest_osl['ilmbase'].obj: latest_osl['ilmbase']}

                ),(
                    'https://github.com/materialx/MaterialX/releases/download/v1.38.2/MaterialX-1.38.2.tar.gz',
                    'MaterialX-1.38.2.tar.gz',
                    '1.38.2',
                    '9916b1d732ffe43a6f1c6822e6da1d28',
                    { self.gcc : '6.3.1', python: '3.7.5', osl: '1.10.7',
                    latest_osl['oiio'   ].obj: latest_osl['oiio'],
                    latest_osl['openexr'].obj: latest_osl['openexr'],
                    latest_osl['ilmbase'].obj: latest_osl['ilmbase']}

                )],
                depend=[self.python, self.freeglut],
                flags = [
                    '-DMATERIALX_BUILD_SHARED_LIBS=1', ## we need this to build in fedora!!
                    '-DMATERIALX_BUILD_PYTHON=1',
                    '-DMATERIALX_BUILD_VIEWER=1',
                    # '-DMATERIALX_BUILD_DOCS=1',
                    '-DMATERIALX_BUILD_OIIO=1',
                    '-DMATERIALX_BUILD_GEN_GLSL=1',
                    '-DMATERIALX_BUILD_GEN_OSL=1',
                    '-DMATERIALX_BUILD_GEN_MDL=1',
                    '-DMATERIALX_BUILD_RENDER=1',
                    '-DMATERIALX_OIIO_DIR=$OIIO_TARGET_FOLDER',
                    '-DMATERIALX_OSLC_EXECUTABLE=$OSL_TARGET_FOLDER/bin/oslc',
                    '-DMATERIALX_TESTRENDER_EXECUTABLE=$OSL_TARGET_FOLDER/bin/testrender'
                    '-DMATERIALX_OSL_INCLUDE_PATH=$OSL_TARGET_FOLDER/shaders/',
                    '-DMATERIALX_PYTHON_PYBIND11_DIR=$SOURCE_FOLDER/source/PyMaterialX/PyBind11/',
                    # Material X needs this to be compatible with gaffer strings
                    '-D_GLIBCXX_USE_CXX11_ABI=0',
                    '-DOpenGL_GL_PREFERENCE=GLVND',
                    '-DMATERIALX_PYTHON_EXECUTABLE=$PYTHONHOME/bin/python',
                ],
                environ = build.update_environ_dict(
                    build.update_environ_dict( build.include_environ(disable='NOBOOST'), build.rpath_environ(disable='NOBOOST') ),
                    {
                        'LD_LIBRARY_PATH' : '/lib64/:$/usr/lib64/:/lib/:/usr/lib/:$LD_LIBRARY_PATH',
                    }
                ),
            )
            self.materialx[bsufix] = materialx

            download_openvdb = []
            if bv == "1.70.0":
                download_openvdb += [(
                    # CY 2022
                    'https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v9.0.0.tar.gz',
                    'openvdb-9.0.0.tar.gz',
                    '9.0.0',
                    '684ce40c2f74f3a0c9cac530e1c7b07e',
                    { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '2020_U3',
                    self.ilmbase[bsufix]: exr_version,
                    self.openexr[bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version,}
                )]
            elif bv == "1.66.0":
                download_openvdb += [(
                    # CY 2021
                    'https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v8.2.0.tar.gz',
                    'openvdb-8.2.0.tar.gz',
                    '8.2.0',
                    '2852fe7176071eaa18ab9ccfad5ec403',
                    { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '2019_U6',
                    self.ilmbase[bsufix]: exr_version,
                    self.openexr[bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version,}
                ),(
                    # CY 2020
                    'https://github.com/AcademySoftwareFoundation/openvdb/archive/v7.0.0.tar.gz',
                    'openvdb-7.0.0.tar.gz',
                    '7.0.0',
                    'fd6c4f168282f7e0e494d290cd531fa8',
                    { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '4.4.6',
                    self.ilmbase[bsufix]: exr_version,
                    self.openexr[bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version,}
                ),(
                    # CY 2019
                    'https://github.com/AcademySoftwareFoundation/openvdb/archive/v6.0.0.tar.gz',
                    'openvdb-6.0.0.tar.gz',
                    '6.0.0',
                    '43604208441b1f3625c479ef0a36d7ad',
                    { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '4.4.6',
                    self.ilmbase[bsufix]: exr_version,
                    self.openexr[bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version,}
                ),(
                    # CY 2018
                    'https://github.com/AcademySoftwareFoundation/openvdb/archive/v5.0.0.tar.gz',
                    'openvdb-5.0.0.tar.gz',
                    '5.0.0',
                    '9ba08c29dda60ec625acb8a5928875e5',
                    { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '4.4.6',
                    self.ilmbase[bsufix]: exr_version,
                    self.openexr[bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version,}
                # ),(
                #     # CY 2017
                #     'https://github.com/AcademySoftwareFoundation/openvdb/archive/v4.0.0.tar.gz',
                #     'openvdb-4.0.0.tar.gz',
                #     '4.0.0',
                #     'c56d8a1a460f1d3327f2568e3934ca6a',
                #     { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '4.4.6',
                #     self.ilmbase[bsufix]: exr_version, self.openexr[bsufix]: exr_version,  self.pyilmbase[bsufix]: exr_version,}
                # ),(
                #     # CY 2015-2016
                #     'https://github.com/AcademySoftwareFoundation/openvdb/archive/v3.0.0.tar.gz',
                #     'openvdb-3.0.0.tar.gz',
                #     '3.0.0',
                #     '3ca8f930ddf759763088e265654f4084',
                #     { self.gcc : '6.3.1', boost : bv, python: '2.7.16', tbb: '4.4.6', build.override.src: 'README',
                #     self.ilmbase[bsufix]: exr_version, self.openexr[bsufix]: exr_version, self.pyilmbase[bsufix]: exr_version, }
                )]

            openvdb_environ = {
                # this fixes the problem with missing stdlib.h
                'CXX':  'g++'
                            ' -isystem$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/'
                            ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/'
                            ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/x86_64-pc-linux-gnu/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/x86_64-pc-linux-gnu/'
                            ' -isystem/usr/include',
                'CC' :  'gcc -isystem$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/'
                            ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/'
                            ' -isystem/usr/include',
                'LD' :  'g++ '
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',

                'LDFLAGS' : ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/'
                            ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',
                'RPATH'     : self.exr_rpath_environ['RPATH'],
                # we need to add the python$VERSION_MAJOR to include path for openvdb 7
                'CPATH'     : '$PYTHON_TARGET_FOLDER/include/python$PYTHON_VERSION_MAJOR/:'+self.exr_rpath_environ['CPATH'],
            }
            if 'OPENVDB_CORES' in ARGUMENTS:
                openvdb_environ['CORES']  = str(int(ARGUMENTS['OPENVDB_CORES'])/2)
                openvdb_environ['DCORES'] = ARGUMENTS['OPENVDB_CORES']
                openvdb_environ['HCORES'] = str(int(ARGUMENTS['OPENVDB_CORES'])/4)

            openvdb = build.cmake(
                ARGUMENTS,
                'openvdb',
                targetSuffix=bsufix,
                download = download_openvdb,
                environ = openvdb_environ,
                depend=[self.glfw, self.jemalloc],
                src = "README.md",
                cmake_prefix = self.cmake_prefix(),
                cmd = [
                    "[ -d openvdb/openvdb ] "
                    "&& ( "
                        "mkdir ./build",
                        "cd ./build",
                        "cmake ../ -DCONCURRENT_MALLOC=Jemalloc",
                        "make -j $DCORES VERBOSE=1",
                        "make -j $DCORES install"
                    ") || ( cd openvdb ",
                        " make install -j $DCORES"
            			" DESTDIR=$INSTALL_FOLDER"
            			" BOOST_INCL_DIR=$BOOST_TARGET_FOLDER/include"
            			" BOOST_LIB_DIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR"
            			" BOOST_PYTHON_LIB_DIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR"
            			" BOOST_PYTHON_LIB=-lboost_python"
            			" EXR_INCL_DIR=$OPENEXR_TARGET_FOLDER/include"
            			" EXR_LIB_DIR=$OPENEXR_TARGET_FOLDER/lib"
            			" TBB_INCL_DIR=$TBB_TARGET_FOLDER/include/tbb"
            			" TBB_LIB_DIR=$TBB_TARGET_FOLDER/lib"
            			" PYTHON_VERSION=$PYTHON_VERSION_MAJOR"
            			" PYTHON_INCL_DIR=$PYTHON_TARGET_FOLDER/include"
            			" PYTHON_LIB_DIR=$PYTHON_TARGET_FOLDER/lib"
            			" BLOSC_INCL_DIR=$BLOSC_TARGET_FOLDER/include"
            			" BLOSC_LIB_DIR=$BLOSC_TARGET_FOLDER/lib"
            			" NUMPY_INCL_DIR=$PYTHON_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/numpy/core/include/numpy/"
            			" CONCURRENT_MALLOC_LIB="
            			" GLFW_INCL_DIR=$GLFW_TARGET_FOLDER/include"
            			" LOG4CPLUS_INCL_DIR="
            			" EPYDOC= ",
                        "cp $INSTALL_FOLDER/python/lib/python$PYTHON_VERSION_MAJOR/pyopenvdb.so $INSTALL_FOLDER/python",
            		    "cp $INSTALL_FOLDER/python/include/python$PYTHON_VERSION_MAJOR/pyopenvdb.h $INSTALL_FOLDER/include )",
                ]
            )
            self.openvdb[bsufix] = openvdb

        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.openvdb[sufix])


        # =============================================================================================================================================
        # ALEMBIC needs boost 1.51.0 for cortex 9
        # =============================================================================================================================================
        for bv in ['1.51.0', '1.66.0']:
            bsufix = "boost.%s" % bv
            # build alembic without apps plugins
            download=[]
            if bv == '1.51.0':
                download += [(
                    # CY2014 - CY2016
                    'https://github.com/alembic/alembic/archive/1.5.8.tar.gz',
                    'alembic-1.5.8.tar.gz',
                    '1.5.8',
                    'a70ba5f2e80b47d346d15d797c28731a',
                    {self.gcc: '6.3.1', self.boost: '1.51.0', self.hdf5: '1.8.11',
                    self.ilmbase  ['boost.1.51.0']: exr_version,
                    self.openexr  ['boost.1.51.0']: exr_version,
                    self.pyilmbase['boost.1.51.0']: exr_version },
                )]
            elif bv == '1.55.0':
                download += [(
                    # CY2017
                    'https://github.com/alembic/alembic/archive/1.6.1.tar.gz',
                    'alembic-1.6.1.tar.gz',
                    '1.6.1',
                    'e1f9f2cbe1899d3d55b58708b9307482',
                    {self.gcc: '6.3.1', self.boost: '1.55.0', self.hdf5: '1.8.11',
                    self.ilmbase  ['boost.1.55.0']: exr_version,
                    self.openexr  ['boost.1.55.0']: exr_version,
                    self.pyilmbase['boost.1.55.0']: exr_version },
                )]
            else:
                download += [(
                    # CY2018 - CY2020
                    'https://github.com/alembic/alembic/archive/1.7.11.tar.gz',
                    'alembic-1.7.11.tar.gz',
                    '1.7.11',
                    'e156568a8d8b48c4da4fe2496386243d',
                    {self.gcc: '6.3.1', self.boost: bv, self.hdf5: '1.8.11',
                    self.ilmbase  [bsufix]: exr_version,
                    self.openexr  [bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version },
                ),(
                    # CY2018 - CY2020 (USD Version)
                    'https://github.com/alembic/alembic/archive/1.7.1.tar.gz',
                    'alembic-1.7.1.tar.gz',
                    '1.7.1',
                    'c8e2c8f951af09cfdacb2ca1fd5823a5',
                    {self.gcc: '6.3.1', self.boost: bv, self.hdf5: '1.8.11',
                    self.ilmbase  [bsufix]: exr_version,
                    self.openexr  [bsufix]: exr_version,
                    self.pyilmbase[bsufix]: exr_version },
                )]

            alembic = build.alembic(
                ARGUMENTS,
                'alembic',
                targetSuffix=bsufix,
                sed = {'1.5.8' : {
                    'lib/AbcOpenGL/Foundation.h' : [
                        ('.include .GL.glext.h.',''),
                    ],
                    'CMakeLists.txt' : [
                        ('/alembic-${VERSION}',' '),
                        ('.std.c..11',''),
                    ],
                    'build/AlembicBoost.cmake' : [
                        ('SET. Boost_USE_STATIC_LIBS ', '#SET. Boost_USE_STATIC_LIBS '),
                    ]
                },'1.7.0' : {}
                },
                download=download,
                # baseLibs=[python],
                depend=[hdf5],
                environ = {
                    # 'CXXFLAGS'  : '$CXXFLAGS -std=c++0x',
                    'CPATH' : self.exr_rpath_environ['CPATH'],
                    'RPATH' : self.exr_rpath_environ['RPATH'],
                    'LDFLAGS'   : ' -L$GLEW_TARGET_FOLDER/lib -lhdf5_hl $LDFLAGS ',
                    'LD_PRELOAD': ':'.join([
                        '$LATESTGCC_TARGET_FOLDER/lib64/libstdc++.so.6',
                        '$LATESTGCC_TARGET_FOLDER/lib64/libgcc_s.so.1',
                    ]),
                },
            )
            self.alembic[bsufix] = alembic
        # =============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.alembic[bsufix])


        # =============================================================================================================================================
        # resume building the boost for loop
        # =============================================================================================================================================
        for bv in ['1.66.0']:
            bsufix = "boost.%s" % bv

            clew = build.cmake(
                ARGUMENTS,
                'clew',
                targetSuffix=bsufix,
                download=[(
                    'https://github.com/hradec/clew.git',
                    'clew-0.10.2016.zip',
                    '0.10.2016',
                    None,
                    {gcc: '4.8.5', boost: bv},
                )],
                depend=[boost, glfw, glew],
                verbose=1,
                environ = { 'LD' : 'ld' },
                flags = [
                    '-DBUILD_SHARED_LIBRARY=1',
                    '-DINSTALL_CL_HEADER=1',
                ],
                noMinTime=True,
            )
            self.clew[bsufix] = clew

            # build opensubdiv
            download = []
            if bv == '1.51.0':
                download += [(
                #     # CY 2014
                #     'https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v2_3_3.tar.gz',
                #     'OpenSubdiv-2_3_3.tar.gz',
                #     '2.3.3',
                #     'b7312b63bf6dfb38b49b17f15c976849',
                #     {gcc: '6.3.1' if 'fedora' in distro else '4.8.5', boost: '1.51.0', ptex: '2.0.42', tbb: '4.4.6'},
                # ),(
                #     # CY 2015
                #     'https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v2_5_1.tar.gz',
                #     'OpenSubdiv-2_5_1.tar.gz',
                #     '2.5.1',
                #     '73da98bdb1e944b3ec5b046b3d8008d6',
                #     {gcc: '6.3.1' if 'fedora' in distro else '4.8.5', boost: '1.51.0', ptex: '2.0.42'},
                # ),(
                #     # CY 2016
                #     'https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_0_5.tar.gz',
                #     'OpenSubdiv-3_0_5.tar.gz',
                #     '3.0.5',
                #     'f16fa309b3fa3d400e6dcbf59d316dfe',
                #     {gcc: '6.3.1' if 'fedora' in distro else '4.8.5', boost: '1.51.0', ptex: '2.0.42'},
                # ),(
                    # CY 2017
                    'https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_1_1.tar.gz',
                    'OpenSubdiv-3_1_1.tar.gz',
                    '3.1.1',
                    '0f50e6aaca1d174d6b878433d13faa7f',
                    {self.gcc: '6.3.1', self.boost: '1.51.0', self.ptex: '2.1.28',
                    self.hdf5: self.alembic[bsufix]['1.7.11']['hdf5']},
                )]

            elif bv == '1.55.0':
                download += [(
                    # CY 2018-2019
                    'https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_3_3.tar.gz',
                    'OpenSubdiv-3_3_3.tar.gz',
                    '3.3.3',
                    '29c79dc01ef616aab02670bed5544ddd',
                    {self.gcc: '6.3.1', self.boost: '1.55.0', self.ptex: '2.1.33',
                    self.hdf5: self.alembic[bsufix]['1.7.11']['hdf5']},
                )]
            else:
                download += [(
                    # CY 2020
                    'https://github.com/PixarAnimationStudios/OpenSubdiv/archive/v3_4_0.tar.gz',
                    'OpenSubdiv-3_4_0.tar.gz',
                    '3.4.0',
                    '2eea21ef2d85bcbbcee94e287c34a07e',
                    {self.gcc: '6.3.1', self.boost: bv, self.ptex: '2.3.2',
                    self.hdf5: self.alembic[bsufix]['1.7.11']['hdf5']},
                )]

            opensubdiv = build.cmake(
                ARGUMENTS,
                'opensubdiv',
                targetSuffix=bsufix,
                # fix for cuda 10
                sed = { '0.0.0' : { 'opensubdiv/osd/CMakeLists.txt' : [
                    ('compute_11','compute_30'),
                ], './opensubdiv/CMakeLists.txt' : [
                    ('compute_11','compute_30'),
                ], './CMakeLists.txt' : [
                    ('compute_20','compute_30'),
                ]}},
                download=download,
                # baseLibs=[python],
                depend=[self.hdf5, self.glfw, self.glew, self.clew[bsufix]],
                flags=[
                    "-D GLEW_LOCATION=$GLEW_TARGET_FOLDER/",
                    "-D VERBOSE=1",
                ],
                environ = {
                    'CLEW_LOCATION' : '$CLEW_TARGET_FOLDER/',
                    'CFLAGS'        : ' -fopenmp $CFLAGS ',
                    'CXXFLAGS'      : ' -fopenmp $CXXFLAGS ',
                    'LDFLAGS'       : ' -lX11 -lclew -lPtex $LDFLAGS ',
                    'CPATH'         : self.exr_rpath_environ['CPATH'],
                    'RPATH'         : self.exr_rpath_environ['RPATH'],
                },
                verbose=1,
            )
            self.opensubdiv[bsufix] = opensubdiv

            # =============================================================================================================================================
            # USD
            # =============================================================================================================================================
            environ = self.exr_rpath_environ.copy()
            lz4 = build.make(
                ARGUMENTS,
                'lz4',
                targetSuffix=bsufix,
                download=[(
                    'https://github.com/lz4/lz4/archive/v1.9.2.tar.gz',
                    'lz4-1.9.2.tar.gz',
                    '1.9.2',
                    '3898c56c82fb3d9455aefd48db48eaad',
                    { gcc: '6.3.1', cmake: '3.9.0', tbb: '4.4.6',
                    qt: '5.6.1', boost: bv, },
                )],
                depend = [python],
                cmd=[
                    'make',
                    'mkdir -p $INSTALL_FOLDER/bin/',
                    'mkdir -p $INSTALL_FOLDER/lib/',
                    'mkdir -p $INSTALL_FOLDER/lib64/',
                    'mkdir -p $INSTALL_FOLDER/include/',
                    'find . -name "*.h" -exec cp -rf {} $INSTALL_FOLDER/include/ \;',
                    'cp -rf lib/lib* $INSTALL_FOLDER/lib/',
                    'cp -rf lz4 $INSTALL_FOLDER/bin/',
                ],
                environ = environ,
            )
            self.lz4[bsufix] = lz4
            seexpr = build.cmake(
                ARGUMENTS,
                'seexpr',
                targetSuffix=bsufix,
                download=[(
                #     'https://github.com/appleseedhq/SeExpr/archive/v2.0-beta.2.tar.gz',
                #     'SeExpr-2.0-beta.2.tar.gz',
                #     '2.0.0.beta2',
                #     '528037ccab6034504a057e68cb455bd8',
                #     { gcc: '6.3.1', cmake: '3.9.0', tbb: '4.4.6',
                #     qt: '5.6.1', boost: bv, },
                # ),(
                #     'https://github.com/appleseedhq/SeExpr/archive/v2.11.tar.gz',
                #     'SeExpr-2.11.tar.gz',
                #     '2.11.0',
                #     '9c3c98c1c988c7901200600b8a542cc9',
                #     { gcc: 6.3.1', cmake: '3.9.0', tbb: '4.4.6',
                #     qt: '5.6.1', boost: bv, },
                # ),(
                    'https://github.com/appleseedhq/SeExpr/archive/appleseed-qt5.zip',
                    'SeExpr-appleseed-qt5.zip',
                    '2.1.0.beta',
                    'c73820b50ebb15ce8a5affcab60722a2',
                    { gcc: '6.3.1', cmake: '3.9.0', tbb: '4.4.6',
                    qt: '5.6.1', boost: bv, },
                )],
                depend = [python, qt],
                flags = [
                    '-Wno-error',
                    '-DCMAKE_PREFIX_PATH=$QT_TARGET_FOLDER',
                    '-DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0',
                ],
                cmd=[
                    # not sure why, but the build doesn't create this folder and fails.
                    # creating it before starting sorts out the problem.
                    'cmake $SOURCE_FOLDER -DCMAKE_INSTALL_PREFIX=$INSTALL_FOLDER',
                    'make $MAKE_PARALLEL $MAKE_VERBOSE',
                    'touch $SOURCE_FOLDER/src/doc/html',
                    'touch  $SOURCE_FOLDER/src/doc/SeExpr',
                    'mkdir -p $INSTALL_FOLDER/share/doc/SeExpr',
                    'make install',
                ],
                environ = environ,
            )
            self.seexpr[bsufix] = seexpr
            xerces = build.cmake(
                ARGUMENTS,
                'xerces',
                targetSuffix=bsufix,
                download=[(
                    'https://github.com/apache/xerces-c/archive/v3.2.2.tar.gz',
                    'xerces-c-3.2.2.tar.gz',
                    '3.2.2',
                    'bd91a5583212e77035a5d524eda17555',
                    { gcc: '6.3.1', cmake: '3.9.0', tbb: '4.4.6',
                    qt: '5.6.1', boost: bv, },
                )],
                depend = [python],
                flags = [
                    '-Wno-error',
                    '-DCMAKE_PREFIX_PATH=$QT_TARGET_FOLDER',
                    '-DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0',
                ],
                environ = environ,
            )
            self.xerces[bsufix] = xerces

            # build USD without applications plugins
            # dependency version table:
            # https://github.com/PixarAnimationStudios/USD/blob/master/VERSIONS.md
            usd_sed = {
                # malloc_hook was removed on glib 2.24.
                # this patch makes it possible to build USD with newer glibc.
                # it disables the malloc_hook functionality, just like it does in
                # other platforms, like OSX and Windows.
                '20.8.0' : {
                    'pxr/base/arch/mallocHook.cpp' : {
                        ('.if !defined.ARCH_OS_WINDOWS.', '#if 0'),
                        ('.if defined.ARCH_COMPILER_GCC.*', '#if 0'),
                        ('defined.ARCH_COMPILER_CLANG.', ''),
                        ('.if defined.ARCH_OS_LINUX.', "#if 0"),
                        ('.if !defined.ARCH_OS_LINUX.', "#if 1"),
                    }
                }
            }
            usd_sed['21.5.0']  = usd_sed['20.8.0']
            usd_sed['21.11.0'] = usd_sed['20.8.0']
            usd = build.cmake(
                ARGUMENTS,
                'usd',
                sed = usd_sed,
                targetSuffix=bsufix,
                download=[(
                #     # theres no CY for USD - not in VFX Platform yet.
                #     # so lets build the one in Gaffer dependencies
                #     'https://github.com/PixarAnimationStudios/USD/archive/v18.09.tar.gz',
                #     'USD-18.09.tar.gz',
                #     '18.9.0',
                #     '10a06767c6a9c69733bb5f9fbadcb52a',
                #     {gcc: '6.3.1' if 'fedora' in distro else '4.8.5', opensubdiv: '3.3.3', alembic: '1.6.1',
                #     hdf5: '1.8.11', cmake: '3.8.2', tbb: '4.4.6',
                #     boost: '1.55.0',
                #     self.ilmbase['boost.1.55.0']: exr_version,
                #     self.openexr['boost.1.55.0']: exr_version,
                #     self.oiio['boost.1.55.0']: '1.6.15' },
                # ),(
                #     # this is the latest for now - nov/2019
                #     'https://github.com/PixarAnimationStudios/USD/archive/v19.07.tar.gz',
                #     'USD-19.07.tar.gz',
                #     '19.7.0',
                #     '8d274089364cfed23004ae52fa3d258f',
                #     {gcc: '6.3.1', opensubdiv: '3.4.0', alembic: '1.7.11', hdf5: '1.8.11',
                #     cmake: '3.18.2', tbb: '4.4.6',
                #     boost: bv,
                #     self.ilmbase[bsufix]: exr_version,
                #     self.openexr[bsufix]: exr_version,
                #     self.oiio   [bsufix]: '1.8.10'},
                #
                # ),(
                    # this is the latest for now - sept/2020
                    'https://github.com/PixarAnimationStudios/USD/archive/v20.08.tar.gz',
                    'USD-20.08.tar.gz',
                    '20.8.0',
                    'e7f31719ef2359c939d23871333a763a',
                    {self.gcc: '6.3.1', self.cmake: '3.18.2',
                    self.tbb: '2019_U6', self.embree: '3.2.2',
                    self.boost: bv,
                    self.opensubdiv[bsufix]: '3.4.0',
                    self.materialx[bsufix] : '1.37.4',
                    self.openvdb[bsufix] : '7.0.0',
                    self.alembic[bsufix] : '1.7.11',
                    self.alembic[bsufix]['1.7.11']['hdf5'].obj : self.alembic[bsufix]['1.7.11']['hdf5'],
                    latest_osl.obj : latest_osl.version,
                    latest_osl['oiio'     ].obj: latest_osl['oiio'],
                    latest_osl['ilmbase'  ].obj: latest_osl['ilmbase'],
                    latest_osl['openexr'  ].obj: latest_osl['ilmbase'],
                    self.pyilmbase[bsufix]     : latest_osl['ilmbase']}
                ),(
                    # this is the latest for now - sept/2020
                    'https://github.com/PixarAnimationStudios/USD/archive/refs/tags/v21.05.tar.gz',
                    'USD-21.05.tar.gz',
                    '21.5.0',
                    'f63736f66fe7f81d17c7a046cb6dbc39',
                    {self.gcc: '6.3.1', self.cmake: '3.18.2',
                    self.tbb: '2019_U6', self.embree: '3.2.2',
                    self.boost: bv,
                    self.opensubdiv[bsufix]: '3.4.0',
                    self.materialx[bsufix] : '1.38.0',
                    self.openvdb[bsufix] : '8.2.0',
                    self.alembic[bsufix] : '1.7.11',
                    self.alembic[bsufix]['1.7.11']['hdf5'].obj : self.alembic[bsufix]['1.7.11']['hdf5'],
                    latest_osl.obj : latest_osl.version,
                    latest_osl['oiio'     ].obj: latest_osl['oiio'],
                    latest_osl['ilmbase'  ].obj: latest_osl['ilmbase'],
                    latest_osl['openexr'  ].obj: latest_osl['ilmbase'],
                    self.pyilmbase[bsufix]     : latest_osl['ilmbase']}
                ),(
                    # this is the latest for now - sept/2020
                    'https://github.com/PixarAnimationStudios/USD/archive/refs/tags/v21.11.tar.gz',
                    'USD-21.11.tar.gz',
                    '21.11.0',
                    '7fe232df5c732fedf466d33ff431ce33',
                    {self.gcc: '6.3.1', self.cmake: '3.18.2',
                    self.tbb: '2019_U6', self.embree: '3.2.2',
                    self.boost: bv,
                    self.opensubdiv[bsufix]: '3.4.0',
                    self.materialx[bsufix] : '1.37.4',
                    self.openvdb[bsufix] : '8.2.0',
                    self.alembic[bsufix] : '1.7.11',
                    self.alembic[bsufix]['1.7.11']['hdf5'].obj : self.alembic[bsufix]['1.7.11']['hdf5'],
                    latest_osl.obj : latest_osl.version,
                    latest_osl['oiio'     ].obj: latest_osl['oiio'],
                    latest_osl['ilmbase'  ].obj: latest_osl['ilmbase'],
                    latest_osl['openexr'  ].obj: latest_osl['ilmbase'],
                    self.pyilmbase[bsufix]     : latest_osl['ilmbase']}
                )],
                # baseLibs=[python],
                depend=[
                    self.clew[bsufix], self.lz4[bsufix], self.clew[bsufix],
                    self.seexpr[bsufix], self.xerces[bsufix],
                    self.icu, self.embree, self.ocio,
                    self.hdf5, self.glfw, self.glew, self.ptex,
                    self.pyside, self.qt, self.python, self.jemalloc
                ],
                cmd = [
                    "mkdir build",
                    "cd build",
                    # we need to do this since USD 21 will insist in using the system tbb!!
                    "mv /usr/lib64/libtbb.so.2 /usr/lib64/__libtbb.so.2__",
                    # "export LD_LIBRARY_PATH=%s:$LD_LIBRARY_PATH" % os.popen("dirname $(ldconfig -p | grep libc.so.6 | awk '{print $(NF)}')").readlines()[0].strip(),
                    # "echo $LD_LIBRARY_PATH",
                    "cmake"
                    " --build --target install --parallel $DCORES ..",
                    # patch generated files to remove any "-isystem /usr/include" from the build cmd lines, to avoid gcc errors!
                    "( grep '.isystem /usr/include' ./* -R | awk -F':' '{print $1}' | while read p ; do sed -i.bak -e 's/.isystem .usr.include/-I \/usr\/include/g' $p ; done )",
                    # now we can build!
                    "make -j $DCORES",
                    "make -j $DCORES install",
                    "ln -s lib/python/pxr $INSTALL_FOLDER/python || true",
                    # now we can return the system tbb back
                    "mv /usr/lib64/__libtbb.so.2__ /usr/lib64/libtbb.so.2",

                ],
                flags=[
                    # installation prefix
                    "-D CMAKE_INSTALL_PREFIX=$INSTALL_FOLDER",
                    "-D CMAKE_PREFIX_PATH=$INSTALL_FOLDER",

                    # libraries locations
                    "-D TBB_ROOT_DIR=$TBB_TARGET_FOLDER",
                    "-D BOOST_ROOT=$BOOST_TARGET_FOLDER",
                    "-D BOOST_LIBRARYDIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR",
                    "-D ALEMBIC_DIR=$ALEMBIC_TARGET_FOLDER",
                    "-D HDF5_LOCATION=$HDF5_TARGET_FOLDER",
                    "-D OPENEXR_LOCATION=$OPENEXR_TARGET_FOLDER/lib",
                    "-D GLEW_LOCATION=$GLEW_TARGET_FOLDER/",
                    "-D OPENSUBDIV_ROOT_DIR=$OPENSUBDIV_TARGET_FOLDER",
                    "-D OIIO_LOCATION=$OIIO_TARGET_FOLDER",
                    "-D OSL_LOCATION=$OSL_TARGET_FOLDER",
                    "-D PTEX_LOCATION=$PTEX_TARGET_FOLDER",
                    "-D MATERIALX_ROOT=$MATERIALX_TARGET_FOLDER",
                    "-D MATERIALX_LIB_DIRS=$MATERIALX_TARGET_FOLDER/lib/",
                    "-D MATERIALX_STDLIB_DIR=$MATERIALX_TARGET_FOLDER/Libraries/",
                    "-D PYSIDEUICBINARY=$PYSIDE_TARGET_FOLDER/bin/uic",

                    # boost options
                    "-D Boost_NO_SYSTEM_PATHS=ON",
                    "-D Boost_NO_BOOST_CMAKE=ON",

                    # fix malloc problem with newer glibc (better performance too)
                    "-D PXR_MALLOC_LIBRARY:path=$JEMALLOC_TARGET_FOLDER/lib/libjemalloc.so",
                    "-D PXR_MALLOC_LIBRARY=$JEMALLOC_TARGET_FOLDER/lib/libjemalloc.so",

                    # embree
                    # " -D PXR_BUILD_EMBREE_PLUGIN=ON"
                    # " -D EMBREE_LOCATION=$EMBREE_TARGET_FOLDER"

                    # enable plugins
                    "-D PXR_BUILD_ALEMBIC_PLUGIN=ON",
                    "-D PXR_BUILD_OPENIMAGEIO_PLUGIN=ON",
                    "-D PXR_BUILD_OPENCOLORIO_PLUGIN=ON",
                    "-D PXR_BUILD_MATERIALX_PLUGIN=ON",
                    "-D PXR_BUILD_IMAGING=ON",
                    "-D PXR_BUILD_USD_IMAGING=ON",

                    # enable support to different components.
                    "-D PXR_BUILD_TESTS=ON",
                    "-D PXR_BUILD_GPU_SUPPORT=ON",
                    "-D PXR_ENABLE_HDF5_SUPPORT=ON",
                    "-D PXR_ENABLE_OSL_SUPPORT=ON",
                    "-D PXR_ENABLE_PTEX_SUPPORT=ON",

                    # build options to improve compatibility (gaffer/cortex)
                    "-D PXR_BUILD_MONOLITHIC=ON",
                    "-D VERBOSE=1",
                    "-D CMAKE_CXX_STANDARD=11",
                    "-D CMAKE_CXX_STANDARD_COMPUTED_DEFAULT=11",
                    "-D_GLIBCXX_USE_CXX11_ABI=0",
                ],
                environ = {
                    # we need boost first of everything else since icu also has regex.h
                    'LD'        : 'ld',
                    'CFLAGS'    : ' '.join([
                        ' -D_GLIBCXX_USE_CXX11_ABI=0 -fopenmp -O2 -fPIC -w ',#'-isystem $BOOST_TARGET_FOLDER/include/boost ',
                    ]),
                    'CXXFLAGS'  : ' '.join([
                        ' -D_GLIBCXX_USE_CXX11_ABI=0 -fopenmp -O2 -fPIC -w ',#'-isystem $BOOST_TARGET_FOLDER/include/boost -lboost_program_options ',
                    ]),
                    'LDFLAGS'   : ' '.join([
                        '$LDFLAGS -lboost_regex -lboost_program_options',
                    ]),
                    'LD_PRELOAD': ':'.join([
                        '$LATESTGCC_TARGET_FOLDER/lib64/libstdc++.so.6',
                        '$LATESTGCC_TARGET_FOLDER/lib64/libgcc_s.so.1',
                    ]),
                    'CPATH' : self.exr_rpath_environ['CPATH'],
                    'RPATH' : self.exr_rpath_environ['RPATH'],
                },
                # verbose=1,
            )
            self.usd[bsufix] = usd
            self.masterVersion['usd'] = '21.11.0'



        # ============================================================================================================================================
        # github build point so we can split the build in multiple matrix jobs in github actions
        # ============================================================================================================================================
        build.github_phase(self.usd[bsufix])



            # =============================================================================================================================================
            # APPLESEED, a open source ray tracer that works in gaffer
            # =============================================================================================================================================
            # environ = self.exr_rpath_environ.copy()
            # environ.update({
            #     # as we use the embree tarball, it comes with it's only tbb,
            #     # so we put it to the top of the list
            #     # so the linker uses embree's one instead of pipeVFX one.
            #     # we need to see if things will work OK with this.
            #     'LIBRARY_PATH' : '$EMBREE_TARGET_FOLDER/lib:$LIBRARY_PATH',
            #     'LDFLAGS' : ' -lembree3 -lSeExpr -ltbb '+ self.exr_rpath_environ['LDFLAGS'],
            #     'LDSHAREDFLAGS' : ' -lembree3 -lSeExpr -ltbb '+self.exr_rpath_environ['LDFLAGS'],
            # })
            # appleseed = build.cmake(
            #     ARGUMENTS,
            #     'appleseed',
            #     download=[(
            #     #     'https://github.com/appleseedhq/appleseed/archive/2.1.0-beta.tar.gz',
            #     #     'appleseed-2.1.0-beta.tar.gz',
            #     #     '2.1.0.beta',
            #     #     '4413d83ee8d6fc379f4a914381f1c7a4',
            #     #     { gcc: '6.3.1', opensubdiv: '3.4.0', alembic: '1.7.11',
            #     #     hdf5: '1.8.11', cmake: '3.9.6', tbb: '2019_U6',  qt: '5.6.1',
            #     #     self.boost: bv, embree: '3.6.1',
            #     #     self.ilmbase[bsufix]: exr_version,
            #     #     self.openexr[bsufix]: exr_version,
            #     #     self.oiio[bsufix]: '1.8.10' },
            #     # ),(
            #         'https://github.com/appleseedhq/appleseed/archive/2.0.5-beta.tar.gz',
            #         'appleseed-2.0.5-beta.tar.gz',
            #         '2.0.5.beta',
            #         '8fd84ddd180abc8fba75163b67419e3e',
            #         { gcc: '6.3.1', opensubdiv: '3.4.0', alembic: '1.7.11',
            #         hdf5: '1.8.11', cmake: '3.9.6', tbb: '2019_U6',  qt: '4.8.7',
            #         self.boost: bv, embree: '3.5.2',
            #         self.ilmbase[bsufix]: exr_version,
            #         self.openexr[bsufix]: exr_version,
            #         self.oiio   [bsufix]: '1.8.10' },
            #     )],
            #     depend=[usd, seexpr, lz4, osl, xerces, python,  ocio],
            #     flags = [
            #         '-Wno-error',
            #         '-DCMAKE_PREFIX_PATH=$QT_TARGET_FOLDER',
            #         '-DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0',
            #         '-DWITH_DISNEY_MATERIAL=ON',
            #         '-DWITH_EMBREE=ON',
            #         '-DUSE_SSE42=ON',
            #         '-DUSE_SSE=ON',
            #         '-DUSE_STATIC_BOOST=OFF',
            #         '-DBOOST_INCLUDEDIR=$BOOST_TARGET_FOLDER/include/',
            #         '-DBOOST_LIBRARYDIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            #         '-DBoost_NO_SYSTEM_PATHS=ON',
            #         # '-DBoost_ATOMIC_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_atomic-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_CHRONO_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_chrono-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_DATE_TIME_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_date_time-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_FILESYSTEM_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_filesystem-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_PYTHON_LIBRARY=$APPLESEED_DEPENDENCIES/lib/libboost_python-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_PYTHON_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_python-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_REGEX_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_regex-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_SYSTEM_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_system-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_THREAD_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_thread-gcc63-mt-1_61.so.1.61.0',
            #         # '-DBoost_WAVE_LIBRARY_RELEASE=$APPLESEED_DEPENDENCIES/lib/libboost_wave-gcc63-mt-1_61.so.1.61.0',
            #         '-DEMBREE_INCLUDE_DIR=$EMBREE_TARGET_FOLDER/include',
            #         '-DEMBREE_LIBRARY=$EMBREE_TARGET_FOLDER/lib/libembree3.so',
            #         '-DLZ4_INCLUDE_DIR=$LZ4_TARGET_FOLDER/include',
            #         '-DLZ4_LIBRARY=$LZ4_TARGET_FOLDER/lib/liblz4.so',
            #         '-DOPENIMAGEIO_OIIOTOOL=$OIIO_TARGET_FOLDER/bin/oiiotool',
            #         '-DOPENIMAGEIO_IDIFF=$OIIO_TARGET_FOLDER/bin/idiff',
            #         '-DOSL_COMPILER=$OSL_TARGET_FOLDER/bin/oslc',
            #         '-DOSL_MAKETX=$OIIO_TARGET_FOLDER/bin/maketx',
            #         '-DOSL_QUERY_INFO=$OSL_TARGET_FOLDER/bin/oslinfo',
            #         '-DSEEXPR_INCLUDE_DIR=$SEEXPR_TARGET_FOLDER/include',
            #         '-DSEEXPR_LIBRARY=$SEEXPR_TARGET_FOLDER/lib/libSeExpr.so',
            #         '-DSEEXPREDITOR_INCLUDE_DIR=$SEEXPR_TARGET_FOLDER/include',
            #         '-DSEEXPREDITOR_LIBRARY=$SEEXPR_TARGET_FOLDER/lib/libSeExprEditor.so',
            #         '-DPYTHON_EXECUTABLE=$PYTHON_ROOT/bin/python',
            #         " -D USE_STATIC_BOOST=OFF",
        	# 		" -D USE_STATIC_OIIO=OFF",
        	# 		" -D USE_STATIC_OSL=OFF",
        	# 		" -D USE_EXTERNAL_ZLIB=ON",
        	# 		" -D USE_EXTERNAL_EXR=ON",
        	# 		" -D USE_EXTERNAL_PNG=ON",
        	# 		" -D USE_EXTERNAL_XERCES=ON",
        	# 		" -D USE_EXTERNAL_OSL=ON",
        	# 		" -D USE_EXTERNAL_OIIO=ON",
            #         " -D WITH_CLI=ON",
            #         " -D WITH_STUDIO=OFF",
        	# 		" -D WITH_TOOLS=OFF",
        	# 		" -D WITH_TESTS=OFF",
        	# 		" -D WITH_PYTHON=ON",
            #         ' -D WARNINGS_AS_ERRORS=OFF',
            #     ],
            #     cmd = [
            #         'mkdir -p $SOURCE_FOLDER/build',
            #         'cd $SOURCE_FOLDER/build',
            #         'cmake $SOURCE_FOLDER -DCMAKE_INSTALL_PREFIX=$INSTALL_FOLDER',
            #         # not sure why, but version 2.0.5.beta needs libSeExpr,
            #         # libembree3 and libtbb added to the link.txt file or else it
            #         # fails linking.
            #         # '( '
            #         # '   c=$(cat src/appleseed.cli/CMakeFiles/appleseed.cli.dir/link.txt | tr -d "\\n") ;'
            #         # '   echo "$c -lembree3 -lSeExpr -ltbb" > src/appleseed.cli/CMakeFiles/appleseed.cli.dir/link.txt '
            #         # ')',
            #         # after this patch, we can build and everything works.
            #         'make $MAKE_PARALLEL $MAKE_VERBOSE &&  make install',
            #         'ln -s $APPLESEED_TARGET_FOLDER/include/foundation/utility/version.h $APPLESEED_TARGET_FOLDER/include/renderer/api/version.h || true',
            #     ],
            #     environ = environ,
            # )
            # self.appleseed = appleseed
            # =============================================================================================================================================

            # if all build is done correctly, make install folder ready!
            # SCons.Script.Alias( 'install',
            #     SCons.Script.Command(
            #         target = os.path.join( devRoot.installRoot(ARGUMENTS), '.done'),
            #         source = self.qt.installAll + self.osl.installAll + self.boost.installAll ,
            #         action = "touch $TARGET"
            #     )
            # )
