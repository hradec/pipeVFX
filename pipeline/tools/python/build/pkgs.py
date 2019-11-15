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


mem = ''.join(os.popen("grep MemTotal /proc/meminfo | awk '{print $(NF-1)}'").readlines()).strip()

SCons.Script.SetOption('warn', 'no-all')
#SCons.Script.SetOption('num_jobs', 8)

def versionSort(versions):
    def method(v):
        v = filter(lambda x: x.isdigit() or x in '.', v.split('b')[0])
        return str(float(v.split('.')[0])*10000+float(v.split('.')[:2][-1])) + v.split('b')[-1]
    tmp =  sorted( versions, key=method, reverse=True )
    # print tmp
    return tmp


class all: # noqa
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

        allDepend = []

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
        # allDepend += [zlib]

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

        gmp = build.configure(
           ARGUMENTS,
           'gmp',
           download=[(
                 'https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2',
                 'gmp-6.1.2.tar.gz',
                 '6.1.2',
                 '8ddbb26dc3bd4e2302984debba1406a5'
            )],
            depend = allDepend
        )
        allDepend += [gmp]

        mpfr = build.configure(
            ARGUMENTS,
            'mpfr',
            download=[(
                'https://www.mpfr.org/mpfr-3.1.6/mpfr-3.1.6.tar.gz',
                'mpfr-3.1.6.tar.gz',
                '3.1.6',
                '95dcfd8629937996f826667b9e24f6ff',
            )],
            depend = allDepend,
        )
        allDepend += [mpfr]

        mpc = build.configure(
            ARGUMENTS,
            'mpc',
            download=[(
               'https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz',
               'mpc-1.0.3.tar.gz',
               '1.0.3',
               'd6a1d5f8ddea3abd2cc3e98f58352d26',
            )],
            depend = allDepend,
        )
        allDepend += [mpc]

        flex = build.configure(
            ARGUMENTS,
            'flex',
            download=[(
                'http://downloads.sourceforge.net/project/flex/flex-2.5.39.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fflex%2Ffiles%2F&ts=1433811270&use_mirror=iweb',
                'flex-2.5.39.tar.gz',
                '2.5.39',
                'e133e9ead8ec0a58d81166b461244fde'
            )],
        )
        self.flex = flex
        allDepend += [flex]


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
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.17a.tar.bz2',
                'binutils-2.17.tar.gz',
                '2.17.1',
                '1d81edd0569de4d84091526fd578dd7b'
            ),(
            # so we're defaulting to 2.22.0 for now.
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.22.tar.gz',
                'binutils-2.22.tar.gz',
                '2.22.0',
                '8b3ad7090e3989810943aa19103fdb83'
            ),(
            # so we're defaulting to 2.22.0 for now.
                'https://mirror.its.dal.ca/gnu/binutils/binutils-2.33.1.tar.gz',
                'binutils-2.33.1.tar.gz',
                '2.33.1',
                '1a6b16bcc926e312633fcc3fae14ba0a'

            )],
            depend = allDepend,
        )
        self.binutils = binutils
        # allDepend += [binutils]


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
                    'ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.1.2/gcc-4.1.2.tar.gz',
                    '4.1.2.tar.gz',
                    '4.1.2',
                    'bf35fabc47ead3b1f743492052296336',
                    { binutils : '2.22.0' }
                ),(
                    # CY2015
                    'ftp://ftp.lip6.fr/pub/gcc/releases/gcc-4.8.5/gcc-4.8.5.tar.gz',
                    'gcc-4.8.5.tar.gz',
                    '4.8.5',
                    'bfe56e74d31d25009c8fb55fd3ca7e01',
                    { binutils : '2.22.0' }
                # ),(
                #     # CY2018 GCC 6.3.1 source code.
                #    'http://vault.centos.org/7.5.1804/sclo/Source/rh/devtoolset-6/devtoolset-6-gcc-6.3.1-3.1.el7.src.rpm',
                #    'gcc-6.3.1.tar.gz',
                #    '6.3.0',
                #    '6e5ea04789678f1250c1b30c4d9ec417'
                )],
                depend = allDepend,
        )
        self.gcc = gcc
        # lets use our own latest GCC to build everything!!!
        allDepend += [gcc]


        icu = build.configure(
            ARGUMENTS,
            'icu',
            download=[(
                'http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz',
                'icu.tar.gz',
                '57.1',
                '976734806026a4ef8bdd17937c8898b9',
                { gcc : '4.1.2' }
            )],
            src = 'icu4c.css',
            cmd = ['cd ./source/'] + build.configure.cmd,
            depend = allDepend,
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
                { gcc : '4.1.2' }
            )],
            cmd = [
                'make -j $DCORES CFLAGS="$CFLAGS -O2 -fPIC" PREFIX=$TARGET_FOLDER',
                'make -j $DCORES PREFIX=$TARGET_FOLDER install',
            ],
            depend = allDepend,
        )
        self.bzip2 = bzip2
        allDepend += [bzip2]

        readline = build.configure(
            ARGUMENTS,
            'readline',
            download=[(
                'http://ftp.gnu.org/gnu/readline/readline-5.2.tar.gz',
                'readline-5.2.tar.gz',
                '5.2.0',
                'e39331f32ad14009b9ff49cc10c5e751',
                { gcc : '4.1.2' }
            ),(
                'https://ftp.gnu.org/gnu/readline/readline-7.0.tar.gz',
                'readline-7.0.tar.gz',
                '7.0.0',
                '205b03a87fc83dab653b628c59b9fc91',
                { gcc : '4.1.2' }
            )],
            cmd = [
                './configure ',
                'make -j $DCORES SHLIB_LIBS="-lncurses" CFLAGS="$CFLAGS -fPIC" PREFIX=$TARGET_FOLDER',
                'make -j $DCORES PREFIX=$TARGET_FOLDER install',
            ],
            depend = allDepend,
        )
        self.readline = readline
        allDepend += [readline]

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
            depend = allDepend,
            parallel = 0,
        )
        self.openssl = openssl
        allDepend += [openssl]

        python = build.python(
            ARGUMENTS,
            'python',
            download=[(
                    # 'http://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz',
                    # 'Python-2.6.9.tar.gz',
                    # '2.6.9',
                    # 'bddbd64bf6f5344fc55bbe49a72fe4f3',
                    # { readline : '7.0.0', openssl : '1.0.2h' },
                # ),(
                #     'http://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz',
                #     'Python-2.7.12.tar.gz',
                #     '2.7.12',
                #     '88d61f82e3616a4be952828b3694109d',
                #     { readline : '7.0.0', openssl : '1.0.2s' },
                # ),(
                    # CY2015 - CY2019
                    'http://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz',
                    'Python-2.7.16.tar.gz',
                    '2.7.16',
                    'f1a2ace631068444831d01485466ece0',
                    { gcc : '4.1.2', readline : '7.0.0', openssl : '1.0.2s' },
                ),(
                    # CY2020
                    'https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz',
                    'Python-3.7.5.tar.gz',
                    '3.7.5',
                    '1cd071f78ff6d9c7524c95303a3057aa',
                    { gcc : '4.8.5', readline : '7.0.0', openssl : '1.0.2s' },
            )],
            # this fixes https not finding certificate in easy_install
            environ = {"PYTHONHTTPSVERIFY" : "0"},
            depend = allDepend+[readline,bzip2], #,openssl],
            pip = [
                'epydoc',
                'PyOpenGL',
                'PyOpenGL-accelerate',
                'cython',
                'subprocess32',
                'numpy',
                'dbus-python',
                'scons'
            ]
        )
        self.python = python
        allDepend += [python]

        tbb = build.tbb(
            ARGUMENTS,
            'tbb',
            download=[(
                # CY2016
                'https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb43_20150611oss_src.tgz',
                'tbb43_20150611oss.tar.gz',
                '4.3.6',
                'bb144ec868c53244ea6be11921d86f03',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2017
                'https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb44_20160526oss_src_0.tgz',
                'tbb44_20160526oss.tar.gz',
                '4.4.r20160526oss',
                '6309541504a819dabe352130f27e57d5',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2018
                'https://github.com/intel/tbb.git',
                'tbb-2017_U6.zip',
                '2017_U6',
                None,
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2019
                'https://github.com/intel/tbb.git',
                'tbb-2018.zip',
                '2018',
                None,
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2020
                'https://github.com/intel/tbb.git',
                'tbb-2019_U6.zip',
                '2019_U6',
                None,
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'https://github.com/intel/tbb.git',
                'tbb-2019_U9.zip',
                '2019_U9',
                None,
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend = allDepend,
        )
        self.tbb = tbb
        allDepend += [tbb]

        cmake = build.configure(
            ARGUMENTS,
            'cmake',
            download=[(
                'http://www.cmake.org/files/v3.4/cmake-3.4.3.tar.gz',
                'cmake-3.4.3.tar.gz',
                '3.4.3',
                '4cb3ff35b2472aae70f542116d616e63',
                { gcc : '4.1.2' }
            )],
            cmd = [
                "./configure --system-curl",
                "./Bootstrap.cmk/cmake",
                "make -j $DCORES VERBOSE=1",
                "make -j $DCORES install",
            ],
            sed = { '0.0.0' : {
                'Source/kwsys/Terminal.c' : [
                    ('/* If running inside emacs the terminal is not VT100.  Some emacs','return 1;'),
                ],
            }},
            depend=[gcc, openssl]+allDepend,
        )
        self.cmake = cmake
        allDepend += [cmake]

        glew = build.glew(
            ARGUMENTS,
            'glew',
            download=[(
                'http://downloads.sourceforge.net/glew/glew-1.13.0.tgz',
                'glew-1.13.0.tar.gz',
                '1.13.0',
                '7cbada3166d2aadfc4169c4283701066',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend = allDepend,
        )
        self.glew = glew
        allDepend += [glew]

        freeglut = build.configure(
            ARGUMENTS,
            'freeglut',
            download=[(
                'http://downloads.sourceforge.net/project/freeglut/freeglut/2.8.1/freeglut-2.8.1.tar.gz?r=http%3A%2F%2Ffreeglut.sourceforge.net%2Findex.php&ts=1432619092&use_mirror=hivelocity',
                'freeglut-2.8.1.tar.gz',
                '2.8.1',
                '918ffbddcffbac83c218bc52355b6d5a',
                { gcc : '4.1.2', python: '2.7.16' }
            # ),(
            #     'https://github.com/dcnieho/FreeGLUT/archive/FG_3_2_1.tar.gz',
            #     'FreeGLUT-FG_3_2_1.tar.gz',
            #     '3.2.1',
            #     '90c3ca4dd9d51cf32276bc5344ec9754',
            )],
            environ = {
                'LDFLAGS' : '$LDFLAGS -lm -lGL ',
            },
            depend = allDepend,
        )
        self.freeglut = freeglut
        allDepend += [freeglut]

        jpeg = build.configure(
            ARGUMENTS,
            'jpeg',
            download=[(
                'http://www.ijg.org/files/jpegsrc.v6b.tar.gz',
                'jpeg-6b.tar.gz',
                '6b',
                'dbd5f3b47ed13132f04c685d608a7547',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://www.ijg.org/files/jpegsrc.v9a.tar.gz',
                'jpeg-9a.tar.gz',
                '9a',
                '3353992aecaee1805ef4109aadd433e7',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            cmd = [
                './configure --enable-shared --prefix=$TARGET_FOLDER',
                'make install INSTALL="/usr/bin/install -D"',
            ],
            depend = allDepend,
        )
        self.jpeg = jpeg
        allDepend += [jpeg]

        jasper = build.configure(
            ARGUMENTS,
            'jasper',
            download=[(
                'http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip', # http://www.ece.uvic.ca/~frodo/jasper/
                'jasper-1.900.1.zip',
                '1.900.1',
                'a342b2b4495b3e1394e161eb5d85d754',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend = allDepend,
        )
        self.jasper = jasper
        allDepend += [jasper]

        libraw = build.configure(
            ARGUMENTS,
            'libraw',
            src='mkdist.sh',
            download=[(
                'https://github.com/LibRaw/LibRaw/archive/0.17.2.tar.gz',
                'LibRaw-0.17.2.tar.gz',
                '0.17.2',
                '7de042bcffb58864fd93d5209620e08d',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend=[gcc]+allDepend,
            cmd = [
                './mkdist.sh',
                './configure --enable-shared --prefix=$TARGET_FOLDER',
                # it seems there's UTF-8 characters in the source code, so we need to clena it up!
                'cp src/../internal/libraw_x3f.cpp ./xx',
                'iconv -f UTF-8 -t ASCII -c ./xx -o src/../internal/libraw_x3f.cpp',
                'make install INSTALL="/usr/bin/install -D"',
            ]
        )
        # build.allDepend.append(libraw)
        self.libraw = libraw

        tiff = build.configure(
            ARGUMENTS,
            'tiff',
            download=[(
                'http://download.osgeo.org/libtiff/old/tiff-3.8.2.tar.gz',
                'tiff-3.8.2.tar.gz',
                '3.8.2',
                'fbb6f446ea4ed18955e2714934e5b698',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://download.osgeo.org/libtiff/old/tiff-4.0.3.tar.gz',
                'tiff-4.0.3.tar.gz',
                '4.0.3',
                '051c1068e6a0627f461948c365290410',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://download.osgeo.org/libtiff/tiff-4.0.6.tar.gz',
                'tiff-4.0.6.tar.gz',
                '4.0.6',
                'd1d2e940dea0b5ad435f21f03d96dd72',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend=[jpeg, libraw]+allDepend,
            parallel=0,
        )
        self.tiff = tiff
        allDepend += [tiff]

        libpng = build.configure(
            ARGUMENTS,
            'libpng',
            download=[(
                'http://ftp.osuosl.org/pub/blfs/conglomeration/libpng/libpng-1.6.23.tar.xz',
                'libpng-1.6.23.tar.gz',
                '1.6.23',
                '9b320a05ed4db1f3f0865c8a951fd9aa',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend = allDepend,
        )
        self.libpng = libpng
        allDepend += [libpng]

        freetype = build.freetype(
            ARGUMENTS,
            'freetype',
            download=[(
                'http://mirror.csclub.uwaterloo.ca/nongnu//freetype/freetype-2.5.5.tar.gz',
                'freetype-2.5.5.tar.gz',
                '2.5.5',
                '7448edfbd40c7aa5088684b0a3edb2b8',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.0.tar.gz',
                'freetype-2.10.0.tar.gz',
                '2.10.0',
                '58d56c9ad775326d6c9c5417c462a527',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend = allDepend,
        )
        self.freetype = freetype
        allDepend += [freetype]

        gperf = build.configure(
            ARGUMENTS,
            'gperf',
            download=[(
                'https://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz',
                'gperf-3.1.tar.gz',
                '3.1.0',
                '9e251c0a618ad0824b51117d5d9db87e'
            )],
            depend = allDepend,
        )
        self.gperf = gperf
        allDepend += [gperf]

        fontconfig = build.configure(
            ARGUMENTS,
            'fontconfig',
            download=[(
                'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.92.tar.gz',
                'fontconfig-2.13.92.tar.gz',
                '2.13.92',
                'eda1551685c25c4588da39222142f063'
            )],
            depend = allDepend,
        )
        self.fontconfig = fontconfig
        allDepend += [fontconfig]



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
            #     { gcc : '4.1.2', python: '2.7.16' }
            # ),(
                'https://files.pythonhosted.org/packages/b6/85/7b46d31f15a970665533ad5956adee013f03f0ad4421c3c83304ae9c9906/dbus-python-1.2.12.tar.gz',
                'dbus-python-1.2.12.tar.gz',
                '1.2.12',
                '428b7a9e7e2d154a7ceb3e13536283e4',
            )],
            baseLibs=[python],
            depend=[gcc, python, openssl]+allDepend,
        )
        self.dbus = dbus
        allDepend += [dbus]

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
        #         'https://github.com/numpy/numpy/archive/v1.9.2.tar.gz',
        #         'numpy-1.9.2.tar.gz',
        #         '1.9.2',
        #         '90f7434759088acccfddf5ba61b1f908'
        #     )],
        #     baseLibs=[python],
        #     depend=[python, openssl],
        # )
        # self.numpy = numpy
        # build.allDepend.append(numpy)

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
            )],
            # 'pythonldap' : [(
            #     'https://pypi.python.org/packages/source/p/python-ldap/python-ldap-2.4.19.tar.gz#md5=b941bf31d09739492aa19ef679e94ae3',
            #     'python-ldap-2.4.19.tar.gz',
            #     '2.4.19',
            #     'b941bf31d09739492aa19ef679e94ae3'
            # )],
            # 'pygobject' : [(
            #     'https://pypi.python.org/packages/source/P/PyGObject/pygobject-2.28.3.tar.bz2#md5=aa64900b274c4661a5c32e52922977f9',
            #     'pygobject-2.28.3.tar.gz',
            #     '2.28.3',
            #     'aa64900b274c4661a5c32e52922977f9'
            # )],
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
                    depend=[python]+allDepend,
                )
            )
        # add all builders to the global dependency at once here
        # so they can all be built in parallel by scons, since theres no
        # dependency between then.
        build.allDepend.extend( simpleModulesBuilders )
        # ============================================================================================================================================

        boost = build.boost(
            ARGUMENTS,
            'boost',
            download=[(
                'http://downloads.sourceforge.net/project/boost/boost/1.51.0/boost_1_51_0.tar.gz',
                'boost_1_51_0.tar.gz',
                '1.51.0',
                '6a1f32d902203ac70fbec78af95b3cf8',
                # { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://downloads.sourceforge.net/project/boost/boost/1.54.0/boost_1_54_0.tar.gz',
                'boost_1_54_0.tar.gz',
                '1.54.0',
                'efbfbff5a85a9330951f243d0a46e4b9',
                # { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2015 - CY2016
                'http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz', # houdini!!!
                'boost_1_55_0.tar.gz',
                '1.55.0',
                '93780777cfbf999a600f62883bd54b17',
                # { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # not sure why we build this yet...
                'http://downloads.sourceforge.net/project/boost/boost/1.56.0/boost_1_56_0.tar.gz',
                'boost_1_56_0.tar.gz',
                '1.56.0',
                '8c54705c424513fa2be0042696a3a162',
                # { gcc : '4.1.2', python: '2.7.16' }
            # ),(
            #     # CY2017 - CY2018
            #     'http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.gz',
            #     'boost_1_61_0.tar.gz',
            #     '1.61.0',
            #     '874805ba2e2ee415b1877ef3297bf8ad',
            #     { gcc : '4.1.2' }
            # ),(
            #     # CY2019
            #     'http://downloads.sourceforge.net/project/boost/boost/1.66.0/boost_1_66_0.tar.gz',
            #     'boost_1_66_0.tar.gz',
            #     '1.66.0',
            #     '874805ba2e2ee415b1877ef3297bf8ad',
            #     { gcc : '4.1.2' }
            # ),(
            #     # CY2020
            #     'http://downloads.sourceforge.net/project/boost/boost/1.70.0/boost_1_70_0.tar.gz',
            #     'boost_1_70_0.tar.gz',
            #     '1.70.0',
            #     '874805ba2e2ee415b1877ef3297bf8ad',
            #     { gcc : '4.1.2' }
            )],
            baseLibs=[python],
            depend=[python, openssl, bzip2]+allDepend,
        )
        self.boost = boost
        # build.allDepend.append(boost)

        ilmbase = build.configure(
            ARGUMENTS,
            'ilmbase',
            download=[(
                'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.0.0.tar.gz',
                'ilmbase-2.0.0.tar.gz',
                '2.0.0',
                '70f1413840c2a228783d1332b8b168e6',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.1.0.tar.gz',
                'ilmbase-2.1.0.tar.gz',
                '2.1.0',
                '8ba2f608191ad020e50277d8a3ba0850',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2016 - CY2018
                'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz',
                'ilmbase-2.2.0.tar.gz',
                '2.2.0',
                'b540db502c5fa42078249f43d18a4652',
                { gcc : '4.1.2', python: '2.7.16' }
            # ),(
            #     # CY2019
            #     'https://github.com/openexr/openexr/releases/download/v2.3.0/ilmbase-2.3.0.tar.gz',
            #     'ilmbase-2.3.0.tar.gz',
            #     '2.3.0',
            #     '354bf86de3b930ab87ac63619d60c860',
            #     { gcc : '4.8.5' }
            # ),(
            #     # CY2020
            #     'https://github.com/openexr/openexr/releases/download/v2.4.0/ilmbase-2.4.0.tar.gz',
            #     'ilmbase-2.4.0.tar.gz',
            #     '2.4.0',
            #     '354bf86de3b930ab87ac63619d60c860',
            #     { gcc : '4.8.5' }
            )],
            depend=[gcc, python, openssl]+allDepend,
            environ={
                'LDFLAGS' : "$LDFLAGS -Wl,-rpath-link,$ILMBASE_TARGET_FOLDER/lib/:$OPENEXR_TARGET_FOLDER/lib/",
            },
            cmd = [
                './configure  --enable-shared ',
                'make -j $DCORES',
                'make -j $DCORES install',
            ],
        )
        self.ilmbase = ilmbase


        openexr = build.configure(
            ARGUMENTS,
            'openexr',
            download=[(
                'http://download.savannah.nongnu.org/releases/openexr/openexr-2.0.0.tar.gz',
                'openexr-2.0.0.tar.gz',
                '2.0.0',
                '0820e1a8665236cb9e728534ebf8df18',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                'http://download.savannah.nongnu.org/releases/openexr/openexr-2.1.0.tar.gz',
                'openexr-2.1.0.tar.gz',
                '2.1.0',
                '33735d37d2ee01c6d8fbd0df94fb8b43',
                { gcc : '4.1.2', python: '2.7.16' }
            ),(
                # CY2016 - CY2018
                'http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz',
                'openexr-2.2.0.tar.gz',
                '2.2.0',
                'b64e931c82aa3790329c21418373db4e',
                { gcc : '4.1.2', python: '2.7.16' }
            # ),(
            #     # CY2019
            #     'https://github.com/openexr/openexr/releases/download/v2.3.0/openexr-2.3.0.tar.gz',
            #     'openexr-2.3.0.tar.gz',
            #     '2.3.0',
            #     'a157e8a46596bc185f2472a5a4682174',
            #     { gcc : '4.8.5' }
            # ),(
            #     # CY2020
            #     'https://github.com/openexr/openexr/releases/download/v2.4.0/openexr-2.4.0.tar.gz',
            #     'openexr-2.4.0.tar.gz',
            #     '2.4.0',
            #     'a157e8a46596bc185f2472a5a4682174',
            #     { gcc : '4.8.5' }
            )],
            sed = { '0.0.0' : { './configure' : [('-L/usr/lib64','')]}}, # disable looking for system  ilmbase
            depend=[ilmbase, gcc, python, openssl]+allDepend,
            environ={
                'LDFLAGS' : "$LDFLAGS -Wl,-rpath-link,$ILMBASE_TARGET_FOLDER/lib/:$OPENEXR_TARGET_FOLDER/lib/",
            },
            cmd = [
                './configure  --enable-shared --with-ilmbase-prefix=$ILMBASE_TARGET_FOLDER',
                'make -j $DCORES',
                'make -j $DCORES install',
            ],
        )
        self.openexr = openexr

        # pyilmbase = build.configure(
        #     ARGUMENTS,
        #     'pyilmbase',
        #     download=[(
        #         'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.0.0.tar.gz',
        #         'pyilmbase-2.0.0.tar.gz',
        #         '2.0.0',
        #         '4585eba94a82f0b0916445990a47d143',
        #         { gcc : '4.1.2', python: '2.7.16' }
        #     ),(
        #         'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.1.0.tar.gz',
        #         'pyilmbase-2.1.0.tar.gz',
        #         '2.1.0',
        #         'af1115f4d759c574ce84efcde9845d29',
        #         { gcc : '4.1.2', python: '2.7.16' }
        #     ),(
        #         'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz',
        #         'pyilmbase-2.2.0.tar.gz',
        #         '2.2.0',
        #         'e84a6a4462f90b5e14d83d67253d8e5a',
        #         { gcc : '4.1.2', python: '2.7.16' }
        #     ),(
        #         'https://github.com/openexr/openexr/releases/download/v2.3.0/pyilmbase-2.3.0.tar.gz',
        #         'pyilmbase-2.3.0.tar.gz',
        #         '2.3.0',
        #         'e84a6a4462f90b5e14d83d67253d8e5a',
        #         { gcc : '4.1.2', python: '2.7.16' }
        #     )],
        #     baseLibs=[python],
        #     depend=[ilmbase,openexr,boost,python,numpy,gcc],
        #     environ={'DCORES' : 1, 'CORES' : 1},
        #     cmd = [
        #         'LD_LIBRARY_PATH=$OPENSSL_TARGET_FOLDER/lib:$LD_LIBRARY_PATH  ./configure  --enable-shared --disable-boostpythontest ',
        #         'make -j $DCORES',
        #         'make -j $DCORES install',
        #     ],
        # )
        # self.pyilmbase = pyilmbase
        # build.allDepend.extend([
        #     ilmbase,
        #     openexr,
        # ])


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
                { gcc : '4.1.2', python : '2.7.16'}
            )],
            depend = allDepend,
        )
        self.yasm = yasm
        allDepend += [yasm]

        hdf5 = build.configure(
            ARGUMENTS,
            'hdf5',
            download=[(
                'https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.17/src/hdf5-1.8.17.tar.gz',
                'hdf5-1.8.17.tar.gz',
                '1.8.17',
                '7d572f8f3b798a628b8245af0391a0ca',
                { gcc : '4.1.2', python: '2.7.16' }
            )],
            depend = allDepend,
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
            }},
            download = [(
                # CY2015 - CY2018
                'https://github.com/imageworks/OpenColorIO/archive/v1.0.9.tar.gz',
                'OpenColorIO-1.0.9.tar.gz',
                '1.0.9',
                '06d0efe9cc1b32d7b14134779c9d1251',
                { gcc : '4.1.2' }
            ),(
                # CY2019
                'https://github.com/imageworks/OpenColorIO/archive/v1.1.0.tar.gz',
                'OpenColorIO-1.1.0.tar.gz',
                '1.1.0',
                '802d8f5b1d1fe316ec5f76511aa611b8',
                { gcc : '4.8.5' }
            ),(
                # CY2020
                'https://github.com/imageworks/OpenColorIO/archive/v1.1.1.tar.gz',
                'OpenColorIO-1.1.1.tar.gz',
                '1.1.1',
                '23d8b9ac81599305539a5a8674b94a3d',
                { gcc : '4.8.5' }
            )],
            baseLibs = [python],
            depend   = [yasm,boost,gcc,python]+allDepend,
            flags    = build.cmake.flags+['-DOCIO_BUILD_APPS=0','-D OCIO_USE_BOOST_PTR=1', 'OCIO_BUILD_TRUELIGHT=OFF', 'OCIO_BUILD_NUKE=OFF'] # -DUSE_EXTERNAL_TINYXML=1  -DUSE_EXTERNAL_YAML=1']
        )
        self.ocio = ocio

        oiio = build.cmake(
            ARGUMENTS,
            'oiio',
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
            download=[(
                'https://github.com/OpenImageIO/oiio/archive/Release-1.5.24.tar.gz',
                'oiio-Release-1.5.24.tar.gz',
                '1.5.24',
                '8c1f9a0ec5b55a18eeea76d33ca7a02c',
                { gcc : '4.1.2',  boost : "1.51.0", python: '2.7.16' }
            ),(
                'https://github.com/OpenImageIO/oiio/archive/Release-1.6.15.tar.gz',
                'oiio-Release-1.6.15.tar.gz',
                '1.6.15',
                '3fe2cef4fb5f7bc78b136d2837e1062f',
                { gcc : '4.1.2', boost : "1.51.0", python: '2.7.16' }
            ),(
                'https://github.com/OpenImageIO/oiio/archive/Release-2.0.11.tar.gz',
                'oiio-Release-2.0.11.tar.gz',
                '2.0.11',
                '4fa0ce4538fb2d7eb72f54f4036972d5',
                { gcc : '4.8.5', boost : "1.56.0", python: '2.7.16' }
            )],
            depend=[ocio, python, boost, freetype, openexr, ilmbase, gcc, icu, cmake, openssl, bzip2, libraw]+allDepend,
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
                ])
            ]+build.cmake.flags,
        )
        self.oiio = oiio

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

            )],
        )
        self.clang = clang

        # build llvm using clang source folder that has being
        # just downloaded and uncompressed
        _mem = int(mem)/1024/1024
        llvm = build.cmake(
            ARGUMENTS,
            'llvm',
            download=[(
                'http://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz',
                'llvm-9.0.0.src.tar.gz',
                '9.0.0',
                '0fd4283ff485dffb71a4f1cc8fd3fc72',
                { gcc : '4.8.5', clang : '9.0.0' }
            ),(
                'https://github.com/llvm/llvm-project/releases/download/llvmorg-7.1.0/llvm-7.1.0.src.tar.xz',
                'llvm-7.1.0.src.tar.gz',
                '7.1.0',
                '26844e21dbad09dc7f9b37b89d7a2e48',
                { gcc : '4.8.5', clang : '7.1.0' }
            ),(
                'http://releases.llvm.org/3.9.1/llvm-3.9.1.src.tar.xz',
                'llvm-3.9.1.src.tar.gz',
                '3.9.1',
                '3259018a7437e157f3642df80f1983ea',
                { gcc : '4.8.5', clang : '3.9.1' }
            )],
            sed = {
                '3.5.2' : {
                    # fix 3.5.2 with gcc 5!!
                    'include/llvm/ADT/IntrusiveRefCntPtr.h' : [
                        ('IntrusiveRefCntPtr.IntrusiveRefCntPtr.X.','friend class IntrusiveRefCntPtr;\ntemplate <class X> \nIntrusiveRefCntPtr(IntrusiveRefCntPtr<X>'),
                    ],
                },
            },
            depend=[python, boost, clang]+allDepend,
            parallel=1,
            cmd = [
                # mv clang to the tools folder so LLVM can automatically build it!
                'mkdir -p $SOURCE_FOLDER/tools/clang/',
                'cp -rfuv $CLANG_TARGET_FOLDER/* $SOURCE_FOLDER/tools/clang/',
                'mkdir -p build && cd build',
                # since llvm link uses lots of memory, we define the number
                # of threads by dividing the ammount of memory in GB by 12
                'export MAKE_PARALLEL="-j %s"' % (str(_mem/12) if _mem < 35 else "$CORES" ),
                ' && '.join(build.cmake.cmd),
            ],
            flags = [
                '-DCMAKE_BUILD_TYPE=Release',
                '-DLLVM_ENABLE_RTTI=1',
                '-DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=1',
                '-DGCC_INSTALL_PREFIX=$GCC_TARGET_FOLDER',
            ]+build.cmake.flags
        )
        self.llvm = llvm
        # build.allDepend.append(llvm)

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
                { gcc : '4.8.5', python: '2.7.16' },
            )],
            depend = allDepend,
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
                { gcc : '4.8.5' },
            )],
            depend=[python, glew]+allDepend,
            baseLibs=[python],
            flags = [
                '-DBUILD_SHARED_LIBS=1',
            ]+build.glfw.flags
        )
        self.glfw = glfw

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
        #         { gcc : '4.8.5', python: '3.7.5' },
        #     )],
        #     depend=[python, freeglut],
        #     flags = [
        #         '-DCMAKE_PREFIX_PATH=$PYTHON_TARGET_FOLDER',
        #         '-DNANOGUI_PYTHON_VERSION=$PYTHON_VERSION',
        #
        #     ],
        # )
        # self.nanogui = nanogui


        materialx = build.cmake(
            ARGUMENTS,
            'materialx',
            download=[(
                'https://github.com/materialx/MaterialX.git',
                'MaterialX-v1.36.4.zip',
                'v1.36.4',
                None,
                { gcc : '4.8.5', python: '3.7.5' },
            )],
            depend=[python, freeglut]+allDepend,
            flags = [
                '-DMATERIALX_BUILD_PYTHON=1',
                '-DMATERIALX_BUILD_VIEWER=1',
            ],
        )
        self.materialx = materialx

        qt = build.configure(
            ARGUMENTS,
            'qt',
            download=[(
            #     'https://download.qt.io/archive/qt/4.8/4.8.4/qt-everywhere-opensource-src-4.8.4.tar.gz',
            #     'qt-everywhere-opensource-src-4.8.4.tar.gz',
            #     '4.8.4',
            #     '89c5ecba180cae74c66260ac732dc5cb',
            # ),(
            #     'http://download.qt.io/archive/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz',
            #     'qt-everywhere-opensource-src-4.8.6.tar.gz',
            #     '4.8.6',
            #     '2edbe4d6c2eff33ef91732602f3518eb',
            # ),(
                # VFXPLATFORM CY2015
                'http://ftp.fau.de/qtproject/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz',
                'qt-everywhere-opensource-src-4.8.7.tar.gz',
                '4.8.7',
                'd990ee66bf7ab0c785589776f35ba6ad',
                { gcc : '4.1.2' }
            ),(
                # VFXPLATFORM CY2016-CY2018
                # 'http://mirror.csclub.uwaterloo.ca/qtproject/archive/qt/5.6/5.6.1/single/qt-everywhere-opensource-src-5.6.1.tar.gz',
                # 'qt-everywhere-opensource-src-5.6.1.tar.gz',
                # 'ed16ef2a30c674f91f8615678005d44c',
                'https://damassets.autodesk.net/content/dam/autodesk/www/Company/files/2018/Qt561ForMaya2018Update4.zip',
                'qt-adsk-5.6.1-vfx.zip',
                '5.6.1',
                '5e4de3cef0225d094c1ab718c1fc468b',
                { gcc : '4.8.5' }

            )],
            environ = {
                'LD' : '$CXX -fPIC -L$SOURCE_FOLDER/lib/',
                'CC' : '$CC -fPIC',
                'CXX' : '$CXX -fPIC',
                'LD_LIBRARY_PATH' : '$SOURCE_FOLDER/lib/:$LD_LIBRARY_PATH',
            },
            cmd = [
                # if building 5.6.1, we have to use autodesk qt patches to be
                # VFXPLATFORM complaint (CY2016 to CY2018)
                # https://vfxplatform.com/#footnote-qt
                # it also helps with maya compatibility.
                # '( [ "$(basename $TARGET_FOLDER)" == "5.6.1" ] && cp -rfuv $QTMAYA_TARGET_FOLDER/* qtbase/ )',
                # '( [ "$(basename $TARGET_FOLDER)" == "5.6.1" ] && cp -rfuv $QTMAYA_DECLARATIVE_TARGET_FOLDER/* qtdeclarative/ )',
                # '( [ "$(basename $TARGET_FOLDER)" == "5.6.1" ] && cp -rfuv $QTMAYA_X11EXTRAS_TARGET_FOLDER/* qtx11extras/ )',
                # './configure  -opensource -shared --confirm-license  -no-webkit -silent',
                './configure -release -opensource -shared --confirm-license -v -no-warnings-are-errors -nomake examples -nomake tests -c++std c++11 '
                '-no-gtkstyle -no-dbus -skip qtconnectivity -no-libudev -no-gstreamer -no-icu -qt-pcre ',
                'make -j $DCORES',
                'make -j $DCORES install',
            ],
            depend=[
                tiff,jpeg,libpng,freetype,freeglut,glew,gcc,
                # qtMaya, qtMayaDeclarative, qtMayaX11Extras,
            ]+[ x for x in allDepend if python != x ],
            verbose=1,
        )
        self.qt = qt
        # allDepend += [qt]


        # =============================================================================================================================================
        osl = build.cmake(
            ARGUMENTS,
            'osl',
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
                {oiio: "2.0.11", llvm : "7.1.0", gcc: "4.8.5", boost: "1.56.0"},
            # ),(
            #     'https://github.com/imageworks/OpenShadingLanguage/archive/Release-1.7.5.tar.gz',
            #     'OpenShadingLanguage-Release-1.7.5.tar.gz',
            #     '1.7.5',
            #     '8b15d13c3fa510b421834d32338304c8',
            #     {oiio: "1.6.15", llvm : "3.9.1", gcc: "4.8.5", boost: "1.51.0"},
            )],
            depend=[llvm, oiio, boost, ilmbase, openexr, icu, cmake, pugixml, freetype, gcc, openssl, bzip2, libraw]+allDepend,
            cmd = [
                # we have to use the devtoolset-6 gcc
                # 'source scl_source enable devtoolset-6',
                'make -j $DCORES '
                'USE_CPP11=1 '
                'INSTALLDIR=$TARGET_FOLDER '
                'MY_CMAKE_FLAGS="-DENABLERTTI=0 -DPUGIXML_HOME=$PUGIXML_TARGET_FOLDER -DLLVM_STATIC=1  -DOSL_BUILD_CPP11=1 '+" ".join(build.cmake.flags).replace('"',"\\'").replace(';',"';'").replace(" ';' "," ; ")+'" '
                'MY_MAKE_FLAGS=" USE_CPP11=1 '+" ".join(map(lambda x: x.replace('-D',''),build.cmake.flags)).replace('"',"\\'").replace(';',"';'").replace(" ';' "," ; ").replace("CMAKE_VERBOSE","MAKE_VERBOSE")+' ENABLERTTI=1" '
                'OPENIMAGEHOME=$OIIO_TARGET_FOLDER'
                'BOOST_ROOT=$BOOST_TARGET_FOLDER '
                'LLVM_DIRECTORY=$LLVM_TARGET_FOLDER '
                'LLVM_STATIC=0 '
                'PARTIO_HOME="" '
                'STOP_ON_WARNING=0 '
                'ILMBASE_HOME=$ILMBASE_TARGET_FOLDER '
                'OPENEXR_HOME=$OPENEXR_TARGET_FOLDER '
                'BOOST_HOME=$BOOST_TARGET_FOLDER '
                # 'VERBOS=1 '
                'USE_LIBCPLUSPLUS=0 '
                'HIDE_SYMBOLS=0 '
                # 'install '
            ],
            verbose=1,
        )
        self.osl = osl



        # qt packages
        # =============================================================================================================================================
        sip = build.pythonSetup(
            ARGUMENTS,
            'sip',
            download=[(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.15.5/sip-4.15.5.tar.gz',
                'sip-4.15.5.tar.gz',
                '4.15.5',
                '4c95447c7b0391b7f183cf9f92ae9bc6',
                { gcc : '4.1.2' }
            ),(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.16.4/sip-4.16.4.tar.gz',
                'sip-4.16.4.tar.gz',
                '4.16.4',
                'a9840670a064dbf8f63a8f653776fec9',
                { gcc : '4.1.2' }
            ),(
                'https://sourceforge.net/projects/pyqt/files/sip/sip-4.18.1/sip-4.18.1.tar.gz',
                'sip-4.18.1.tar.gz',
                '4.18.1',
                '9d664c33e8d0eabf1238a7ff44a399e9',
                { gcc : '4.1.2' }
            )],
            baseLibs=[python],
            src = 'configure.py',
            cmd = [
                # 'python configure.py --sysroot=$TARGET_FOLDER CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" ',
                'python configure.py '
                '-b $TARGET_FOLDER/bin '
                '-d $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ '
                '-e $TARGET_FOLDER/include/python$PYTHON_VERSION_MAJOR/ '
                '-v $TARGET_FOLDER/share/sip/ '
                'CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" ',
                'make -j $DCORES && make -j $DCORES install',
            ],
            depend = allDepend,
        )
        self.sip = sip

        pyqt = build.pythonSetup(
            ARGUMENTS,
            'pyqt',
            download=[(
                'http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz',
                'PyQt-x11-gpl-4.11.4.tar.gz',
                '4.11.4',
                '2fe8265b2ae2fc593241c2c84d09d481',
                {qt:'4.8.7', sip: '4.16.4', gcc : '4.1.2'},
                # ),(
                #     'https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.7/PyQt5_gpl-5.7.tar.gz',
                #     'PyQt5_gpl-5.7.tar.gz',
                #     '5.7.0',
                #     '2fe8265b2ae2fc593241c2c84d09d481',
                #     {qt:'5.7.0', sip: '4.18.1', gcc : '4.8.5' },
            )],
            baseLibs=[python],
            depend=[sip,qt, gcc]+allDepend,
            src = 'configure-ng.py',
            cmd = [
                # 'python configure-ng.py --confirm-license --assume-shared --protected-is-public --designer-plugindir=$QT_TARGET_FOLDER/plugins/designer/ --sysroot=$TARGET_FOLDER CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS"',
                'python configure.py --confirm-license --assume-shared --verbose --no-designer-plugin '
                '-b $TARGET_FOLDER/bin '
                '-d $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ '
                '-v $TARGET_FOLDER/share/sip/PyQt4 '
                'CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS"',
                'make -j $DCORES CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" ',
                'make -j $DCORES CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" install',
            ],
        )
        self.pyqt = pyqt
        allDepend += [pyqt]



        log4cplus = build.configure(
            ARGUMENTS,
            'log4cplus',
            download=[(
                'https://github.com/log4cplus/log4cplus/archive/REL_1_2_0.tar.gz',
                'log4cplus-REL_1_2_0.tar.gz',
                '1.2.0',
                'b39900d6b504726a20819f2ad73f5877',
                { gcc : '4.1.2' }
            )],
            depend=[gcc]+allDepend,
        )
        self.log4cplus = log4cplus
        allDepend += [log4cplus]

        # blosc = build.cmake(
        #     ARGUMENTS,
        #     'blosc',
        #     download=[(
        #         'https://github.com/Blosc/c-blosc/archive/v1.11.1.tar.gz',
        #         'c-blosc-1.11.1.tar.gz',
        #         '1.11.1',
        #         'e236550640afa50155f3881f2d300206',
        #     )],
        #     depend=[gcc],
        #     flags=['-DCMAKE_INSTALL_PREFIX=$TARGET_FOLDER '],
        # )
        # self.blosc = blosc





        # if all build is done correctly, make install folder ready!
        SCons.Script.Alias( 'install',
            SCons.Script.Command(
                target = os.path.join( devRoot.installRoot(ARGUMENTS), '.done'),
                source = self.qt.installAll + self.osl.installAll + self.boost.installAll + self.ilmbase.installAll + self.openexr.installAll,
                action = "touch $TARGET"
            )
        )


        # =============================================================================================================================================

        ##appleseed = build.cmake(
        ##        ARGUMENTS,
        ##        'appleseed',
        ##        download=[
        ##          (
        ##            'https://github.com/appleseedhq/appleseed/archive/1.1.0-beta.tar.gz',
        ##            'appleseed-1.1.0-beta.tar.gz',
        ##            '1.0.0b',
        ##            'ad6eb4d6d58743a3192098bff9da15ab'
        ##          ),
        ##        ],
        ##)
