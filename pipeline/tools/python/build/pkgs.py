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


import build, devRoot, pipe
import SCons, os

SCons.Script.SetOption('warn', 'no-all')
#SCons.Script.SetOption('num_jobs', 8)

#zlib = build.configure(
#        ARGUMENTS,
#        'zlib',
#        download=[
#          (
#            'http://zlib.net/zlib-1.2.8.tar.gz',
#            'zlib-1.2.8.tar.gz',
#            '1.2.8',
#            '44d667c142d7cda120332623eab69f40'
#          ),
#        ],
#)
#build.allDepend.append(zlib)
#curl = build.configure(
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
#)
#build.allDepend.append(curl)

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

        gmp = build.configure(
               ARGUMENTS,
               'gmp',
               download=[
                 (
                   'https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2',
                   'gmp-6.0.0.tar.gz',
                   '6.0.0',
                   'b7ff2d88cae7f8085bd5006096eed470'
                 ),
               ],
        )
        mpc = build.configure(
               ARGUMENTS,
               'mpc',
               download=[
                 (
                   'ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz',
                   'mpc-1.0.3.tar.gz',
                   '1.0.3',
                   'd6a1d5f8ddea3abd2cc3e98f58352d26'
                 ),
               ],
        )
        mpfr = build.configure(
               ARGUMENTS,
               'mpfr',
               download=[
                 (
                   'http://www.mpfr.org/mpfr-current/mpfr-3.1.4.tar.gz',
                   'mpfr-3.1.4.tar.gz',
                   '3.1.4',
                   '482ab3c120ffc959f631b4ba9ec59a46'
                 ),
               ],
        )
        gcc = build.gccBuild(
                ARGUMENTS,
                'gcc',
                download=[
                (
                #    'http://gcc.parentingamerica.com/releases/gcc-5.4.0/gcc-5.4.0.tar.gz',
                #    'gcc-5.4.0.tar.gz',
                #    '5.4.0',
                #    'f2b4d5a580061711e68f0f506e402e1c'
                # ),(
                #    'http://gcc.parentingamerica.com/releases/gcc-4.8.5/gcc-4.8.5.tar.gz',
                #    'gcc-4.8.5.tar.gz',
                #    '4.8.5',
                #    'bfe56e74d31d25009c8fb55fd3ca7e01'
                # ),(
                   'http://gcc.parentingamerica.com/releases/gcc-4.8.3/gcc-4.8.3.tar.gz',
                   'gcc-4.8.3.tar.gz',
                   '4.8.3',
                   'bfe56e74d31d25009c8fb55fd3ca7e01'
                ),(
                   'http://gcc.parentingamerica.com/releases/gcc-4.1.2/gcc-4.1.2.tar.gz',
                   'gcc-4.1.2.tar.gz',
                   '4.1.2',
                   'dd2a7f4dcd33808d344949fcec87aa86'
                )],
                depend = [ mpfr, mpc, gmp ],
        )
        self.gcc = gcc
        # lets use our own latest GCC to build everything!!!
        build.allDepend.append(gcc)


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
        )
        self.icu = icu


        bzip2 = build.make(
            ARGUMENTS,
            'bzip2',
            download=[(
                'http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz',
                'bzip2-1.0.6.tar.gz',
                '1.0.6',
                '00b516f4704d4a7cb50a1d97e6e8e15b'
            )],
            cmd = [
                'make -j $DCORES CFLAGS="$CFLAGS -O2 -fPIC" PREFIX=$TARGET_FOLDER',
                'make -j $DCORES PREFIX=$TARGET_FOLDER install',
            ],
        )
        self.bzip2 = bzip2

        # ncurses = build.configure(
        #         ARGUMENTS,
        #         'ncurses',
        #         download=[(
        #             'http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz',
        #             'ncurses-5.9.tar.gz',
        #             '5.9.0',
        #             '8cb9c412e5f2d96bc6f459aa8c6282a1'
        #         )],
        #         environ = {"CPPFLAGS" : "-P $CPPFLAGS",},
        #         #        cmd=[
        #         #            './configure --with-shared',
        #         #            'make -j $DCORES && make -j $DCORES install',
        #         #        ]
        # )
        # all['ncurses'] = ncurses

        readline = build.configure(
            ARGUMENTS,
            'readline',
            download=[(
                'http://ftp.gnu.org/gnu/readline/readline-5.2.tar.gz',
                'readline-5.2.tar.gz',
                '5.2.0',
                'e39331f32ad14009b9ff49cc10c5e751'
            ),(
                'ftp://ftp.cwru.edu/pub/bash/readline-7.0-rc1.tar.gz',
                'readline-7.0-rc1.tar.gz',
                '7.0.0rc1',
                'c5ed4d0fd48ec6c940d6da375e3f1b50'
            )],
            cmd = [
                './configure',
                'make -j $DCORES CFLAGS="$CFLAGS -fPIC" PREFIX=$TARGET_FOLDER',
                'make -j $DCORES PREFIX=$TARGET_FOLDER install',
            ],
        )
        self.readline = readline

        openssl = build.openssl(
            ARGUMENTS,
            'openssl',
            download=[(
                'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2h.tar.gz',
                'openssl-OpenSSL_1_0_2h.tar.gz',
                '1.0.2h',
                'bd70ca76ef00c9b65a927883f62998d9'
            )],
        )
        self.openssl = openssl

        python = build.python(
            ARGUMENTS,
            'python',
            download=[(
                'https://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz',
                'Python-2.6.9.tar.gz',
                '2.6.9',
                'bddbd64bf6f5344fc55bbe49a72fe4f3',
                { readline : '5.2.0', openssl : '1.0.2h' },
            ),(
                'https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz',
                'Python-2.7.12.tar.gz',
                '2.7.12',
                '88d61f82e3616a4be952828b3694109d',
                { readline : '5.2.0', openssl : None },
                # ),(
                #     'https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz',
                #     'Python-3.5.2.tar.gz',
                #     '3.5.2',
                #     '3fe8434643a78630c61c6464fe2e7e72',
                #     { readline : '5.2.0', openssl : None },
            )],
            depend = [readline,bzip2],
            pip = [
                'epydoc',
                'PyOpenGL',
                'PyOpenGL-accelerate',
                'cython',
                'subprocess32',
            ]
        )
        self.python = python
        #build.allDepend.append(python)

        tbb = build.tbb(
            ARGUMENTS,
            'tbb',
            download=[(
                'https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb44_20160526oss_src_0.tgz',
                'tbb44_20160526oss.tar.gz',
                '4.4.r20160526oss',
                '6309541504a819dabe352130f27e57d5',
                # { gcc : '4.1.2' }
            ),(
                'https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb43_20150611oss_src.tgz',
                'tbb43_20150611oss.tar.gz',
                '4.3.6',
                'bb144ec868c53244ea6be11921d86f03',
            )],
        )
        self.tbb = tbb

        cmake = build.configure(
            ARGUMENTS,
            'cmake',
            download=[(
                'http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz',
                'cmake-3.2.2.tar.gz',
                '3.2.2',
                '2da57308071ea98b10253a87d2419281'
            )],
            cmd = [
                "./configure --system-curl",
                "./Bootstrap.cmk/cmake",
                "make -j $DCORES VERBOSE=1",
                "make -j $DCORES install",
            ],
            sed = {
                '0.0.0' : {
                    'Source/kwsys/Terminal.c' : [
                        ('/* If running inside emacs the terminal is not VT100.  Some emacs','return 1;'),
                    ],
                },
            },
            # depend = [gcc],
        )
        # build.allDepend.append(cmake)
        self.cmake = cmake

        glew = build.glew(
            ARGUMENTS,
            'glew',
            download=[(
                'http://downloads.sourceforge.net/glew/glew-1.13.0.tgz',
                'glew-1.13.0.tar.gz',
                '1.13.0',
                '7cbada3166d2aadfc4169c4283701066'
            )],
        )
        build.allDepend.append(glew)
        self.glew = glew

        freeglut = build.configure(
            ARGUMENTS,
            'freeglut',
            download=[(
            #     'http://downloads.sourceforge.net/project/freeglut/freeglut/2.6.0/freeglut-2.6.0.tar.gz?r=http%3A%2F%2Ffreeglut.sourceforge.net%2Findex.php&ts=1432619050&use_mirror=iweb',
            #     'freeglut-2.6.0.tar.gz',
            #     '2.6.0',
            #     '39f0f2de89f399529d2b981188082218'
            # ),(
                'http://downloads.sourceforge.net/project/freeglut/freeglut/2.8.1/freeglut-2.8.1.tar.gz?r=http%3A%2F%2Ffreeglut.sourceforge.net%2Findex.php&ts=1432619092&use_mirror=hivelocity',
                'freeglut-2.8.1.tar.gz',
                '2.8.1',
                '918ffbddcffbac83c218bc52355b6d5a',
                # ),(
                # 'http://downloads.sourceforge.net/project/freeglut/freeglut/3.0.0/freeglut-3.0.0.tar.gz?r=http%3A%2F%2Ffreeglut.sourceforge.net%2Findex.php&ts=1432619114&use_mirror=hivelocity',
                # 'freeglut-3.0.0.tar.gz',
                # '3.0.0',
                # '90c3ca4dd9d51cf32276bc5344ec9754',
            )],
            environ = {'LDFLAGS' : '$LDFLAGS -lm -lGL'}
        )
        build.allDepend.append(freeglut)
        self.freeglut = freeglut

        jpeg = build.configure(
            ARGUMENTS,
            'jpeg',
            download=[(
                'http://www.ijg.org/files/jpegsrc.v6b.tar.gz',
                'jpeg-6b.tar.gz',
                '6b',
                'dbd5f3b47ed13132f04c685d608a7547'
            ),(
                'http://www.ijg.org/files/jpegsrc.v9a.tar.gz',
                'jpeg-9a.tar.gz',
                '9a',
                '3353992aecaee1805ef4109aadd433e7',
            )],
            cmd = [
                './configure --enable-shared --prefix=$TARGET_FOLDER',
                'make install INSTALL="/usr/bin/install -D"',
            ]
        )
        build.allDepend.append(jpeg)
        self.jpeg = jpeg



        jasper = build.configure(
            ARGUMENTS,
            'jasper',
            download=[(
                'http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip', # http://www.ece.uvic.ca/~frodo/jasper/
                'jasper-1.900.1.zip',
                '1.900.1',
                'a342b2b4495b3e1394e161eb5d85d754'
            )],
        )
        build.allDepend.append(jasper)
        self.jasper = jasper


        libraw = build.configure(
            ARGUMENTS,
            'libraw',
            src='mkdist.sh',
            download=[(
                'https://github.com/LibRaw/LibRaw/archive/0.17.2.tar.gz',
                'LibRaw-0.17.2.tar.gz',
                '0.17.2',
                '7de042bcffb58864fd93d5209620e08d'
            )],
            depend=[gcc],
            cmd = [
                './mkdist.sh',
                './configure --enable-shared --prefix=$TARGET_FOLDER',
                # it seems there's UTF-8 characters in the source code, so we need to clena it up!
                'cp src/../internal/libraw_x3f.cpp ./xx',
                'iconv -f UTF-8 -t ASCII -c ./xx -o src/../internal/libraw_x3f.cpp',
                'make install INSTALL="/usr/bin/install -D"',
            ]
        )
        build.allDepend.append(libraw)
        self.libraw = libraw

        tiff = build.configure(
            ARGUMENTS,
            'tiff',
            download=[(
                'ftp://ftp.remotesensing.org/pub/libtiff/old/tiff-3.8.2.tar.gz',
                'tiff-3.8.2.tar.gz',
                '3.8.2',
                'fbb6f446ea4ed18955e2714934e5b698'
            ),(
                'ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.3.tar.gz',
                'tiff-4.0.3.tar.gz',
                '4.0.3',
                '051c1068e6a0627f461948c365290410',
            ),(
                'ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.6.tar.gz',
                'tiff-4.0.6.tar.gz',
                '4.0.6',
                'd1d2e940dea0b5ad435f21f03d96dd72',
            )],
            depend=[jpeg],
        )
        build.allDepend.append(tiff)
        self.tiff = tiff

        libpng = build.configure(
            ARGUMENTS,
            'libpng',
            download=[(
                'http://downloads.sourceforge.net/project/libpng/libpng16/1.6.23/libpng-1.6.23.tar.gz',
                'libpng-1.6.23.tar.gz',
                '1.6.23',
                'a49e4cc48d968c79def53d082809c9f2'
            )],
        )
        build.allDepend.append(libpng)
        self.libpng = libpng

        freetype = build.freetype(
            ARGUMENTS,
            'freetype',
            download=[(
                'http://mirror.csclub.uwaterloo.ca/nongnu//freetype/freetype-2.4.0.tar.gz',
                'freetype-2.4.0.tar.gz',
                '2.4.0',
                'f900148ae8e258803eb1ab9f564f2151'
            ),(
                'http://mirror.csclub.uwaterloo.ca/nongnu//freetype/freetype-2.5.5.tar.gz',
                'freetype-2.5.5.tar.gz',
                '2.5.5',
                '7448edfbd40c7aa5088684b0a3edb2b8',
            )],
        )
        build.allDepend.append(freetype)
        self.freetype = freetype

        # python modules
        # ============================================================================================================================================
        dbus = build.configure(
            ARGUMENTS,
            'dbus',
            download=[(
                'https://pypi.python.org/packages/source/d/dbus-python/dbus-python-0.84.0.tar.gz#md5=fe69a2613e824463e74f10913708c88a',
                'dbus-python-0.84.0.tar.gz',
                '0.84.0',
                'fe69a2613e824463e74f10913708c88a'
            )],
            baseLibs=[python],
        )
        self.dbus = dbus

#        cython = build.pythonSetup(
#            ARGUMENTS,
#            'cython',
#            download=[(
#                'https://github.com/cython/cython/archive/0.24.1.tar.gz',
#                'cython-0.24.1.tar.gz',
#                '0.24.1',
#                'ba3474937557f210acb45852e9ebb0fc'
#            )],
#            baseLibs=[python],
#        )
#        self.cython = cython

        numpy = build.pythonSetup(
            ARGUMENTS,
            'numpy',
            download=[(
                'https://github.com/numpy/numpy/archive/v1.9.2.tar.gz',
                'numpy-1.9.2.tar.gz',
                '1.9.2',
                '90f7434759088acccfddf5ba61b1f908'
            )],
            baseLibs=[python],
            # depend=[cython],
        )
        self.numpy = numpy

        self.scons = build.pythonSetup(
            ARGUMENTS,
            'scons',
            download=[(
                'http://downloads.sourceforge.net/project/scons/scons/1.0.0/scons-1.0.0.tar.gz',
                'scons-1.0.0.tar.gz',
                '1.0.0',
                '9afdfe0cc6d957568cc4386567a7c19e'
            )],
            baseLibs=[python],
        )

        # build all simple python modules here.
        # since its just a matter of running setup.py (hence "simple"),
        # we put all name/version/download infor in a dict for easy maintainance,
        # and run each one through the same pythonSetup builder class,
        # without any special setup.
        simpleModules = {
            'pil' : [(
                'http://effbot.org/downloads/Imaging-1.1.7.tar.gz',
                'Imaging-1.1.7.tar.gz',
                '1.1.7',
                'fc14a54e1ce02a0225be8854bfba478e'
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
                    depend=[python,numpy],
                )
            )
        # add all builders to the global dependency at once here
        # so they can all be built in parallel by scons, since theres no
        # dependency between then.
        #build.allDepend.extend( simpleModulesBuilders )
        # ============================================================================================================================================


        boost = build.boost(
            ARGUMENTS,
            'boost',
            download=[(
                'http://downloads.sourceforge.net/project/boost/boost/1.51.0/boost_1_51_0.tar.gz',
                'boost_1_51_0.tar.gz',
                '1.51.0',
                '6a1f32d902203ac70fbec78af95b3cf8',
                { gcc : '4.1.2' }
            ),(
                'http://downloads.sourceforge.net/project/boost/boost/1.54.0/boost_1_54_0.tar.gz',
                'boost_1_54_0.tar.gz',
                '1.54.0',
                'efbfbff5a85a9330951f243d0a46e4b9',
                { gcc : '4.1.2' }
            ),(
                'http://downloads.sourceforge.net/project/boost/boost/1.56.0/boost_1_56_0.tar.gz',
                'boost_1_56_0.tar.gz',
                '1.56.0',
                '8c54705c424513fa2be0042696a3a162',
                { gcc : '4.1.2' }
            ),(
                'http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.gz',
                'boost_1_61_0.tar.gz',
                '1.61.0',
                '874805ba2e2ee415b1877ef3297bf8ad',
                { gcc : '4.1.2' }
            ),(
                'http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz', # houdini!!!
                'boost_1_55_0.tar.gz',
                '1.55.0',
                '93780777cfbf999a600f62883bd54b17',
                { gcc : '4.1.2' }
            )],
            baseLibs=[python],
            # depend=[gcc],
        )
        self.boost = boost

        ilmbase = build.configure(
            ARGUMENTS,
            'ilmbase',
            download=[(
                'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.0.0.tar.gz',
                'ilmbase-2.0.0.tar.gz',
                '2.0.0',
                '70f1413840c2a228783d1332b8b168e6',
                { gcc : '4.1.2' }
            ),(
                'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.1.0.tar.gz',
                'ilmbase-2.1.0.tar.gz',
                '2.1.0',
                '8ba2f608191ad020e50277d8a3ba0850',
                { gcc : '4.1.2' }
            ),(
                'http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz',
                'ilmbase-2.2.0.tar.gz',
                '2.2.0',
                'b540db502c5fa42078249f43d18a4652',
                { gcc : '4.1.2' }
            )],
            depend=[gcc],
            environ={
                'LDFLAGS' : "-Wl,-rpath-link,$ILMBASE_TARGET_FOLDER/lib/:$OPENEXR_TARGET_FOLDER/lib/",
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
                { gcc : '4.1.2' }
            ),(
                'http://download.savannah.nongnu.org/releases/openexr/openexr-2.1.0.tar.gz',
                'openexr-2.1.0.tar.gz',
                '2.1.0',
                '33735d37d2ee01c6d8fbd0df94fb8b43',
                { gcc : '4.1.2' }
            ),(
                'http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz',
                'openexr-2.2.0.tar.gz',
                '2.2.0',
                'b64e931c82aa3790329c21418373db4e',
                { gcc : '4.1.2' }
            )],
            sed = { '0.0.0' : { './configure' : [('-L/usr/lib64','')]}}, # disable looking for system  ilmbase
            depend=[ilmbase,gcc],
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
        #         '4585eba94a82f0b0916445990a47d143'
        #     ),(
        #         'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.1.0.tar.gz',
        #         'pyilmbase-2.1.0.tar.gz',
        #         '2.1.0',
        #         'af1115f4d759c574ce84efcde9845d29'
        #     ),(
        #         'http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz',
        #         'pyilmbase-2.2.0.tar.gz',
        #         '2.2.0',
        #         'e84a6a4462f90b5e14d83d67253d8e5a'
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
                'fc9e586751ff789b34b1f21d572d96af'
            )],
        )
        self.yasm = yasm
        #build.allDepend.append(yasm)

        hdf5 = build.configure(
            ARGUMENTS,
            'hdf5',
            download=[(
                'https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.17/src/hdf5-1.8.17.tar.gz',
                'hdf5-1.8.17.tar.gz',
                '1.8.17',
                '7d572f8f3b798a628b8245af0391a0ca'
            )],
        )
        self.hdf5 = hdf5
        # build.allDepend.append(hdf5)

        # build alembic for each version of maya and prman!
        maya = pipe.apps.maya()
        prman = pipe.apps.prman()
        mv = versionSort( maya.versionList() )
        pv = versionSort( prman.versionList() )
        pipe.version.set(python='1.0.0')
        alembic = []
        for n in range(2):
            pipe.version.set( maya  = mv[0] if len(mv)<=n else mv[n] )
            pipe.version.set( prman = pv[0] if len(pv)<=n else pv[n] )

            alembic.append( build.alembic(
                ARGUMENTS,
                'alembic',
                targetSuffix = "maya%sprman%s" % (pipe.version.get('maya'),pipe.version.get('prman')),
                download=[(
                #     'https://github.com/alembic/alembic/archive/1.6.1.tar.gz',
                #     'alembic-1.6.1.tar.gz',
                #     '1.6.1',
                #     'e1f9f2cbe1899d3d55b58708b9307482',
                #     {ilmbase: "2.2.0", openexr: "2.2.0"},
                # ),(
                    'https://github.com/alembic/alembic/archive/1.5.8.tar.gz',
                    'alembic-1.5.8.tar.gz',
                    '1.5.8',
                    'a70ba5f2e80b47d346d15d797c28731a',
                    {ilmbase: "2.2.0", openexr: "2.2.0", gcc: '4.1.2'},
                )],
                baseLibs=[python],
                depend=[hdf5,python,yasm,boost],
                apps = [
                    ( pipe.apps.maya, pipe.version.get('maya')),
                    ( pipe.apps.prman, pipe.version.get('prman')),
                ]
            ))
        self.alembic = alembic[-1]

        ocio = build.cmake(
            ARGUMENTS,
            'ocio',
            # ocio for some reason doesn't add -fPIC when building the static external libraries,
            # so we have to patch it or build fail with gcc 4.1.2
            # also, we have to remove -fvisibility-inlines-hidden when building with gcc 4.1.2
            sed = {'0.0.0' : {
                'ext/tinyxml_2_6_1.patch' : [
                    ('-fPIC', '-fPIC -DPIC'),
                    (' -fvisibility-inlines-hidden -fvisibility=hidden', ''),
                ],
                'ext/yaml-cpp-0.3.0.patch' : [
                    ('-fPIC', '-fPIC -DPIC'),
                    (' -fvisibility-inlines-hidden -fvisibility=hidden', ''),
                ],
            }},
            download = [(
                'https://github.com/imageworks/OpenColorIO/archive/v1.0.9.tar.gz',
                'OpenColorIO-1.0.9.tar.gz',
                '1.0.9',
                '06d0efe9cc1b32d7b14134779c9d1251',
                { gcc : '4.1.2' }
            )],
            baseLibs = [python],
            depend   = [yasm,boost,gcc],
            flags    = build.cmake.flags+['-DOCIO_BUILD_APPS=0 ']
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
                { gcc : '4.1.2' }
            ),(
                'https://github.com/OpenImageIO/oiio/archive/Release-1.6.15.tar.gz',
                'oiio-Release-1.6.15.tar.gz',
                '1.6.15',
                '3fe2cef4fb5f7bc78b136d2837e1062f',
                { gcc : '4.1.2' }
            # ),(
            #     'https://github.com/OpenImageIO/oiio/archive/Release-1.7.3dev.tar.gz',
            #     'oiio-Release-1.7.3dev.tar.gz',
            #     '1.7.3dev',
            #     'bcef05f5ff7f15ac580d9b3b4b6f690b',
            #     { gcc : '4.1.2' }
            )],
            depend=[ocio, python, boost, freetype, openexr, ilmbase, gcc, icu],
            cmd = 'mkdir -p build && cd build && '+' && '.join(build.cmake.cmd),
            flags = ['-DUSE_PYTHON=0','-DUSE_PTEX=0','-DUSE_OCIO=0']+build.cmake.flags,
        )
        self.oiio = oiio


        # use the download action as we only need this package to build llvm!
        # download action will avoid installing this package!
        clang = build.download(
            ARGUMENTS,
            'clang',
            download=[(
                'http://llvm.org/releases/3.5.2/cfe-3.5.2.src.tar.xz',
                'cfe-3.5.2.src.tar.gz',
                '3.5.2',
                'aba5d02251bf7845a2013d6bb0702ac7',
            ),(
                'http://llvm.org/releases/3.4.2/cfe-3.4.2.src.tar.gz',
                'cfe-3.4.2.src.tar.gz',
                '3.4.2',
                '87945973b7c73038871c5f849a818588',
            )],
        )
        self.clang = clang

        llvm = build.configure(
            ARGUMENTS,
            'llvm',
            download=[(
                'http://llvm.org/releases/3.5.2/llvm-3.5.2.src.tar.xz',
                'llvm-3.5.2.src.tar.gz',
                '3.5.2',
                'f5a4dc595f7e8bd23397684d0906d014',
                { clang: '3.5.2' }
            )],
            sed = {'3.5.0' : {
                # fix 3.5.2 with gcc 5!!
                'include/llvm/ADT/IntrusiveRefCntPtr.h' : [
                    ('IntrusiveRefCntPtr.IntrusiveRefCntPtr.X.','friend class IntrusiveRefCntPtr;\ntemplate <class X> \nIntrusiveRefCntPtr(IntrusiveRefCntPtr<X>'),
                ],
            },},
            depend=[python, clang],
            compiler = build.gcc.system,
            # now we use the $CLANG_SRC_FOLDER env var to create a symlink
            # of clang into tools/clang folder, so llvm will build clang as well for us!
            cmd = [
                'ln -s $CLANG_SRC_FOLDER ./tools/clang',
                'mkdir -p build && cd build',
                ' && '.join(build.configure.cmd).replace('./configure','../configure --disable-docs'),
                #'cmake .. && make -j $DCORES  install',
            ]
        )
        self.llvm = llvm

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

        bison = build.configure(
            ARGUMENTS,
            'bison',
            download=[(
                'http://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.gz',
                'bison-3.0.4.tar.gz',
                '3.0.4',
                'a586e11cd4aff49c3ff6d3b6a4c9ccf8'
            )],
        )
        self.bison = bison

        osl = build.cmake(
            ARGUMENTS,
            'osl',
            download=[(
                'https://github.com/imageworks/OpenShadingLanguage/archive/Release-1.7.3.tar.gz',
                'OpenShadingLanguage-Release-1.7.3.tar.gz',
                '1.7.3',
                '42215e190d565c862043c0b02eca089b',
                {oiio: "1.6.15", llvm : "3.5.2"},
            # ),(
            #     'https://github.com/imageworks/OpenShadingLanguage/archive/Release-1.8.0dev.tar.gz',
            #     'OpenShadingLanguage-Release-1.8.0dev.tar.gz',
            #     '1.8.0dev',
            #     '167c049c96deae9edcb76a14651069fd',
            #     {oiio: "1.6.15", llvm : "3.5.2"},
            )],
            depend=[llvm, flex, bison, oiio, boost, ilmbase, openexr, icu],
            sed = {
                '0.0.0' : {
                    'CMakeLists.txt' : [
                        ('add_definitions.*Wno.error=strict.overflow','#add_definitions ("-Wno-error=strict-overflow")'),
                    ],
                },
            },
            cmd = [
                'make -j $DCORES '
                'USE_CPP11=1 '
                'INSTALLDIR=$TARGET_FOLDER '
                'MY_CMAKE_FLAGS="  -DOSL_BUILD_CPP11:BOOL=1 '+" ".join(build.cmake.flags)+'" '
                'MY_MAKE_FLAGS=" USE_CPP11=1 '+" ".join(map(lambda x: x.replace('-D',''),build.cmake.flags))+' ENABLERTTI=1" '
                'ILMBASE_HOME=$ILMBASE_TARGET_FOLDER '
                'OPENIMAGEHOME=$OIIO_TARGET_FOLDER'
                'BOOST_HOME=$BOOST_TARGET_FOLDER '
                'LLVM_DIRECTORY=$LLVM_TARGET_FOLDER '
                'PARTIO_HOME="" '
                'STOP_ON_WARNING=0 '
            ],
        )
        self.osl = osl
        # =============================================================================================================================================



        # qt packages
        # =============================================================================================================================================
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
                'http://download.qt.io/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz',
                'qt-everywhere-opensource-src-4.8.7.tar.gz',
                '4.8.7',
                'd990ee66bf7ab0c785589776f35ba6ad',
                { gcc : '4.1.2' }
            # ),(
            #     'http://download.qt.io/official_releases/qt/5.7/5.7.0/single/qt-everywhere-opensource-src-5.7.0.tar.gz',
            #     'qt-everywhere-opensource-src-5.7.0.tar.gz',
            #     '5.7.0',
            #     'd990ee66bf7ab0c785589776f35ba6ad',
            )],
            environ = {'LD' : 'g++'},
            cmd = [
                # './configure  -opensource -shared --confirm-license  -no-webkit -silent',
                './configure  -opensource -shared --confirm-license -silent',
                'make -j $DCORES',
                'make -j $DCORES install',
            ],
            depend=[tiff,jpeg,libpng,freetype,freeglut,glew,gcc],
        )
        self.qt = qt

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
                #     {qt:'5.7.0', sip: '4.18.1'},
            )],
            baseLibs=[python],
            depend=[sip,qt, gcc],
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

        # if all build is done correctly, make install folder ready!
        SCons.Script.Alias( 'install',
            SCons.Script.Command(
                target = os.path.join( devRoot.installRoot(ARGUMENTS), '.ready'),
                source = self.qt.installAll + self.osl.installAll + self.alembic.installAll + self.boost.installAll + self.ilmbase.installAll + self.openexr.installAll,
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
