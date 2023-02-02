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

import sys, os, traceback, glob

# build all pkgs, if not already built!
import build
from build import pkgs, ARGUMENTS
build.s_print('build.installRoot() = '+build.installRoot())

# get installed app versions using pipe
import pipe

# cortex versions we build for now.
def cortex_download(pkgs):
    download = [[
        'https://github.com/ImageEngine/cortex/archive/9.18.0.tar.gz',
        'cortex-9.18.0.tar.gz',
        '9.18.0',
        'b3c55cc5e0e95668208713a01a145869',
        { pkgs.gcc: '4.1.2', },
        # we introduce a 5th element to the download array here, the compatibility
        # dictionary, which tells the min and max version of a compatible
        # package, so we don't build if that version is imcompatible.
        {"boost" : ("0.0.0", "1.51.0"),
         "maya"  : ("2016", "2016.99")}
     ],[
        'https://github.com/ImageEngine/cortex/archive/refs/tags/10.2.3.1.tar.gz',
        'cortex-10.2.3.1.tar.gz',
        '10.2.3.1',
        '1a09b3ac5d59c43c36d958ea7875d532',
        { pkgs.gcc: '6.3.1', },
        {"boost" : ("1.66.0", "1.66.0"),
         "oiio"  : ("2.2.15.1", "2.2.15.1"),
         "maya"  : ("2018", "2018.99"),
         "usd"   : ("21.5.0", "21.5.0")}
     ],[
        'https://github.com/ImageEngine/cortex/archive/refs/tags/10.3.2.1.tar.gz',
        'cortex-10.3.2.1.tar.gz',
        '10.3.2.1',
        '4437543f90238f69082b7ac0178d9115',
        { pkgs.gcc: '6.3.1', },
        {"boost" : ("1.66.0", "99.99.99"),
         "usd"   : ("21.5.0", "21.5.0"),
         "maya"  : ("2018", "2018.99"),
         "oiio"  : ("2.2.15.1", "2.2.15.1")}
     ],[
        'https://github.com/ImageEngine/cortex/archive/refs/tags/10.3.6.1.tar.gz',
        'cortex-10.3.6.1.tar.gz',
        '10.3.6.1',
        '884dc61c6c624b96e3e6acc45468fff0',
        { pkgs.gcc: '6.3.1', },
        {"boost" : ("1.66.0", "99.99.99"),
         "oiio"  : ("2.2.15.1", "2.2.15.1"),
         "maya"  : ("2018", "2018.99"),
         "usd"   : ("21.5.0", "21.5.0")}
     ],[
        'https://github.com/ImageEngine/cortex/archive/refs/tags/10.4.0.0.tar.gz',
        'cortex-10.4.0.0.tar.gz',
        '10.4.0.0',
        '550795bccb6fda410f88eacafcf0e76e',
        { pkgs.gcc: '9.3.1', },
        {"boost" : ("1.76.0", "99.99.99"),
         "maya"  : ("2018", "2018.99"),
         "usd"   : ("21.11.0", "21.11.0")}
     ],[
        'https://github.com/ImageEngine/cortex/archive/refs/tags/10.4.1.2.tar.gz',
        'cortex-10.4.1.2.tar.gz',
        '10.4.1.2',
        '599b5964d81fb4345f41c07fa3151c26',
        { pkgs.gcc: '9.3.1', },
        {"boost" : ("1.76.0", "99.99.99"),
         "maya"  : ("2022", "2022.99"),
         "usd"   : ("21.11.0", "21.11.0")}
     ],[
        'https://github.com/ImageEngine/cortex/archive/refs/tags/10.4.2.1.tar.gz',
        'cortex-10.4.2.1.tar.gz',
        '10.4.2.1',
        '699adf93be240a8cce458ac492188125',
        { pkgs.gcc: '9.3.1',
          pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
          pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
          pkgs.ocio: '2.1.1',
          # pkgs.python: '3.9.13',
        },
        {"boost" : ("1.76.0", "99.99.99"),
         "maya"  : ("2022", "2023.99"),
         "usd"   : ("21.11.0", "21.11.0")}
    ]]
    return download

def cortex_depency(pkgs):
    return [
        pkgs.icu, pkgs.tbb, pkgs.jpeg, pkgs.libraw,
        pkgs.freeglut, pkgs.freetype, pkgs.libpng,
        pkgs.tiff, pkgs.jpeg, pkgs.openssl,
        pkgs.glew, pkgs.blosc, pkgs.ptex,  #, pkgs.appleseed
    ]

def gaffer_download(pkgs):
    ret = [[
    #     'https://github.com/hradec/gaffer/archive/refs/tags/0.61.1.1-gaffercortex.tar.gz',
    #     'gaffer-0.61.1.1-gaffercortex.tar.gz',
    #     '0.61.1.1',
    #     '31b22fb2999873c92aeefea4999ccc3e',
    #     { pkgs.gcc: '6.3.1', pkgs.ocio: '1.1.1',
    #       pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
    #       pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
    #       # pkgs.python: '2.7.16',
    #     },
    #     {"boost" : ("1.66.0", "1.66.0"),
    #      "usd"   : ("21.5.0", "21.5.0"),
    #      "cortex": "10.3.2.1",
    #     }
    # ],[
    #     'https://github.com/hradec/gaffer/archive/refs/tags/0.61.14.0-gafferCortex.tar.gz',
    #     'gaffer-0.61.14.0-gafferCortex.tar.gz',
    #     '0.61.14.0',
    #     'a9509c23d97a4d0d3a602d4668a901d4',
    #     { pkgs.gcc: '6.3.1', pkgs.ocio: '1.1.1',
    #       pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
    #       pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
    #       # pkgs.python: '2.7.16',
    #     },
    #     {"boost" : ("1.66.0", "1.66.0"),
    #      "usd"   : ("21.5.0", "21.5.0"),
    #      "cortex": "10.3.6.1",
    #     }
    # ],[
    #     'https://github.com/hradec/gaffer/archive/refs/tags/1.0.1.0_gafferCortex.tar.gz',
    #     'gaffer-1.0.1.0_gafferCortex.tar.gz',
    #     '1.0.1.0',
    #     '266f24c33f8998b579f42d6ad79d7b1b',
    #     { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
    #       pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
    #       pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
    #       # pkgs.python: '2.7.16',
    #     },
    #     {"boost" : ("1.76.0", "1.76.0"),
    #      "usd"   : ("21.11.0", "21.11.0"),
    #      "cortex": "10.4.1.2",
    #     }
    # ],[
    #     'https://github.com/hradec/gaffer/archive/refs/tags/1.1.1.0_gafferCortex.tar.gz',
    #     'gaffer-1.1.1.0_gafferCortex.tar.gz',
    #     '1.1.1.0',
    #     '50004958b149259517b022408ae28ecf',
    #     { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
    #       pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
    #       pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
    #       pkgs.llvm: '10.0.1',
    #       # pkgs.python: '3.9.13',
    #     },
    #     {"boost" : ("1.76.0", "1.76.0"),
    #      "usd"   : ("21.11.0", "21.11.0"),
    #      "cortex": "10.4.2.1",
    #     }
    # ],[
    #     'https://github.com/hradec/gaffer/archive/refs/tags/1.1.2.0_gafferCortex.tar.gz',
    #     'gaffer-1.1.2.0_gafferCortex.tar.gz',
    #     '1.1.2.0',
    #     '10a3e649e6fe79db8a2c2ef0e3c9845a',
    #     { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
    #       pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
    #       pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
    #       pkgs.llvm: '10.0.1',
    #       # pkgs.python: '3.9.13',
    #     },
    #     {"boost" : ("1.76.0", "1.76.0"),
    #      "usd"   : ("21.11.0", "21.11.0"),
    #      "cortex": "10.4.2.1",
    #     }
    # ],[
        'https://github.com/hradec/gaffer/archive/refs/tags/1.1.4.0_gafferCortex.tar.gz',
        'gaffer-1.1.4.0_gafferCortex.tar.gz',
        '1.1.4.0',
        'bc0967da4305103bfeac98db08af6b86',
        { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
          pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
          pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
          pkgs.llvm: '10.0.1',
          # pkgs.python: '3.9.13',
        },
        {"boost" : ("1.76.0", "1.76.0"),
         "usd"   : ("21.11.0", "21.11.0"),
         "cortex": "10.4.2.1",
        }
    # ],[
    #     'https://github.com/hradec/gaffer/archive/refs/tags/1.1.5.0_gafferCortex.tar.gz',
    #     'gaffer-1.1.5.0_gafferCortex.tar.gz',
    #     '1.1.5.0',
    #     'bc0967da4305103bfeac98db08af6b86',
    #     { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
    #       pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
    #       pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
    #       pkgs.llvm: '10.0.1',
    #       # pkgs.python: '3.9.13',
    #     },
    #     {"boost" : ("1.76.0", "1.76.0"),
    #      "usd"   : ("21.11.0", "21.11.0"),
    #      "cortex": "10.4.2.1",
    #     }
    ],[
        'https://github.com/hradec/gaffer/archive/refs/tags/1.1.5.1_gafferCortex.tar.gz',
        'gaffer-1.1.5.1_gafferCortex.tar.gz',
        '1.1.5.1',
        '0f5ab76d5cd6301ff946f2dce269199f',
        { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
          pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
          pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
          pkgs.llvm: '10.0.1',
          # pkgs.python: '3.9.13',
        },
        {"boost" : ("1.76.0", "1.76.0"),
         "usd"   : ("21.11.0", "21.11.0"),
         "cortex": "10.4.2.1",
        }
    ],[
        'https://github.com/hradec/gaffer/archive/refs/tags/1.1.7.0_gafferCortex.tar.gz',
        'gaffer-1.1.7.0_gafferCortex.tar.gz',
        '1.1.7.0',
        '5dd05ae740e07ab61d3c62d2d2545e2d',
        { pkgs.gcc: '9.3.1', pkgs.ocio: '2.1.1',
          pkgs.openjpeg: '2.4.0', pkgs.glog: '0.5.0',
          pkgs.gflags: '2.2.2', pkgs.oidn: '1.4.3',
          pkgs.llvm: '10.0.1',
          # pkgs.python: '3.9.13',
        },
        {"boost" : ("1.76.0", "1.76.0"),
         "usd"   : ("21.11.0", "21.11.0"),
         "cortex": "10.4.2.1",
        }
    ]]
    for n in range(len(ret)):
        ret[n][4] = ret[n][4].copy()
    return ret

def cycles_download(pkgs):
    return [[
        'https://github.com/blender/cycles/archive/refs/tags/v3.2.0.tar.gz',
        'cycles-3.2.0.tar.gz',
        '3.2.0',
        'e21382fbde81d7419617d60d00e90daa',
        {},
        {"gaffer" : ("1.0.4.0", "9.9.9.9")}
    # ],[
    #     'https://github.com/blender/cycles/archive/refs/tags/v3.4.0.tar.gz',
    #     'cycles-3.4.0.tar.gz',
    #     '3.4.0',
    #     'e21382fbde81d7419617d60d00e90daa',
    #     {},
    #     {"gaffer" : ("1.0.4.0", "9.9.9.9")}
    ]]

# download and install arnold versions to build arnold gaffer extension
arnold_versions = {
    '7.0.0.0' : {'gaffer': ['0.61.1.1']},
    "7.1.1.0" : {'gaffer': ['0.61.14.0', '1.0.4.0']},
    '7.1.2.0' : {'gaffer': ['1.1.1.0']},
    # '7.1.2.0' : {'gaffer': ['1.1.1.0', '1.1.2.0']},
    '7.1.3.2' : {'gaffer': ['1.1.2.0', '1.1.4.0', '1.1.5.1']},
    '7.1.4.1' : {'gaffer': ['1.1.7.0']},
}
mtoa_versions = {
    '5.0.0.2' : {'maya' : ['2022'        ], 'arnold' : '7.0.0.0'},
    '5.1.1'   : {'maya' : ['2022', '2023'], 'arnold' : '7.1.1.0'},
    '5.1.3'   : {'maya' : ['2022', '2023'], 'arnold' : '7.1.2.0'},
    '5.2.1.1' : {'maya' : ['2022', '2023'], 'arnold' : '7.1.3.2'},
    '5.2.2.1' : {'maya' : ['2022', '2023'], 'arnold' : '7.1.4.1'},
}
# download and install arnold for us, based on the table above
for arnold_version in arnold_versions:
    if not glob.glob( '/%s/apps/linux/x86_64/arnold/%s/*' % (os.environ['STUDIO'], arnold_version) ):
        error = os.system('''
            sh /.github/workflows/main/installArnold.sh %s
            mkdir -p /$STUDIO/apps/linux/x86_64/arnold/
            mv arnoldRoot/%s /$STUDIO/apps/linux/x86_64/arnold/
            ls -l /$STUDIO/apps/linux/x86_64/arnold/
            ls -l /$STUDIO/apps/linux/x86_64/arnold/%s/
        ''' % (arnold_version, arnold_version, arnold_version))
        if error != 0:
            Exception("Error downloading Arnold!")

# download and install mtoa versions for us, based on the table above
for mtoa_version in mtoa_versions:
    for maya_version in mtoa_versions[mtoa_version]['maya']:
        if not glob.glob( '/%s/apps/linux/x86_64/mtoa/%s/%s/*' % (os.environ['STUDIO'], mtoa_version, maya_version) ):
            error = os.system('''
                    rm -rf mtoaRoot
                    sh /.github/workflows/main/installmtoa.sh %s %s
                    mkdir -p /$STUDIO/apps/linux/x86_64/mtoa/%s
                    mv mtoaRoot/%s/install /$STUDIO/apps/linux/x86_64/mtoa/%s/%s
                    ln -s ../../mtoa/%s  /$STUDIO/apps/linux/x86_64/arnold/%s/mtoadeploy
                    ls -l /$STUDIO/apps/linux/x86_64/mtoa/
                    ls -l /$STUDIO/apps/linux/x86_64/mtoa/%s/
                ''' % (
                mtoa_version, maya_version,
                mtoa_version,
                mtoa_version, mtoa_version, maya_version,
                mtoa_version, mtoa_versions[mtoa_version]['arnold'],
                mtoa_version
            ))
            if error != 0:
                Exception("Error downloading Arnold!")



# ===========================================================================================
# CORTEX VFX
# ===========================================================================================
# we use this to apply patches created when developing cortex
devPatch = []
patchFile = os.environ['HOME']+'/dev/cortex.git/patch'
if os.path.exists( patchFile ):
    devPatch = [ ''.join(open(patchFile).readlines()) ]


def cortex(apps=[], boost=None, usd=None, pkgs=None, __download__=None, usd_monolithic=False):
    ''' build cortex '''
    if not hasattr(pkgs, 'cortex'):
        pkgs.cortex = {}

    if not usd:
        usd = pkgs.masterVersion['usd']
    if not boost:
        boost = pkgs.masterVersion['boost']

    legacy(pkgs=pkgs)
    depend = cortex_depency(pkgs)
    boost_version = boost
    bsufix = "boost.%s" % boost_version
    extraInstall = ""

    # only build versions that are compatible with the current boost!
    download = []+cortex_download(pkgs)
    _download = download
    _download = [ []+x for x in _download if build.vComp(boost_version) >= build.vComp(x[5]["boost"][0]) and build.vComp(boost_version) <= build.vComp(x[5]["boost"][1])   ]
    _download = [ []+x for x in _download if build.vComp(usd) >= build.vComp(x[5]["usd"][0]) and build.vComp(usd) <= build.vComp(x[5]["usd"][1])   ]

    cortex_environ = pkgs.exr_rpath_environ.copy()

    # build the usd cortex only for the boost version used to build the current usd version.
    usd_version = usd
    usd = pkgs.usd[bsufix][usd_version]
    usd_non_monolithic = pkgs.usd_non_monolithic[bsufix][usd_version]

    sufix = ''
    dontUseTargetSuffixForFolders = 1
    if apps:
        version = apps[0][1]
        sufix = "-%s.%s" % (str(apps[0][0]).split("'")[1].split(".")[-1], version)
        dontUseTargetSuffixForFolders = 1
        print('############>', build.vComp(version))
        for x in _download:
            if "maya" in x[5]:
                print('################>', build.vComp(version), build.vComp(version) >= build.vComp(x[5]["maya"][0]), build.vComp(version) <= build.vComp(x[5]["maya"][1]), x[2] )
        _download = [ []+x for x in _download
            if "maya" in x[5] and
            build.vComp(version) >= build.vComp(x[5]["maya"][0]) and
            build.vComp(version) <= build.vComp(x[5]["maya"][1])
        ]
    print(_download)

    sufix = "boost.%s-usd.%s%s" % (boost_version, usd_version, sufix)
    # build.s_print( "cortex: "+sufix, __download )

    # since USD was introduced in cortex 10, only build for version >= 10
    # we select only the cortex version that uses the current version of USD to build in this step
    # the []+x is to create a new list!
    __download = [ []+x for x in _download if build.versionMajor(x[2]) >= 10.0 ]

    # retrieve the latest version of the package, no matter what boost version
    openvdbOBJ = build.pkgVersions('openvdb').latestVersionOBJ()
    # we dont need to remove usd, alembic or openvdb since the _download won't have it!
    for n in range(len(__download)):
        # set the version of usd for all versions of cortex >= 10
        if usd_monolithic:
            osl = usd['osl'].obj[usd['osl'].version]
            alembic = usd['alembic'].obj[usd['alembic'].version]
            oiio_version = usd['oiio'].version
            if 'oiio' in __download[n][5]:
                oiio_version = __download[n][5]['oiio'][0]
            oiio = usd['oiio'].obj[oiio_version]
            __download[n][4] = __download[n][4].copy()
            # __download[n][4][ pkgs.gcc              ] = pkgs.boost[boost_version]['gcc'].version
            # __download[n][4][ pkgs.gcc              ] = usd['gcc'       ].version
            __download[n][4][ pkgs.boost            ] = boost_version
            __download[n][4][ usd.obj               ] = usd.version
            __download[n][4][ alembic.obj           ] = alembic.version
            __download[n][4][ oiio['openvdb'  ].obj ] = oiio['openvdb'  ].version
            __download[n][4][ alembic['hdf5'  ].obj ] = alembic['hdf5'  ].version
            __download[n][4][ usd['python'    ].obj ] = usd['python'    ].version
            __download[n][4][ usd['osl'       ].obj ] = usd['osl'       ].version
            __download[n][4][ usd['oiio'      ].obj ] = oiio_version
            __download[n][4][ usd['ilmbase'   ].obj ] = usd['openexr'   ].version
            __download[n][4][ usd['openexr'   ].obj ] = usd['openexr'   ].version
            __download[n][4][ usd['pyilmbase' ].obj ] = usd['openexr'   ].version
            __download[n][4][ usd['tbb'       ].obj ] = usd['tbb'       ].version
            # __download[n][4][ usd['ocio'      ].obj ] = usd['ocio'      ].version
            __download[n][4][ usd['opensubdiv'].obj ] = usd['opensubdiv'].version
        else:
            osl = usd_non_monolithic['osl'].obj[usd_non_monolithic['osl'].version]
            oiio_version = usd_non_monolithic['oiio'].version
            if 'oiio' in __download[n][5]:
                oiio_version = __download[n][5]['oiio'][0]
            oiio = usd_non_monolithic['oiio'].obj[oiio_version]
            # print usd_non_monolithic['alembic'], usd_non_monolithic['alembic'].obj.versions, boost_version, usd_version, __download[n][2]
            alembic = usd_non_monolithic['alembic'].obj[usd_non_monolithic['alembic'].version]
            __download[n][4] = __download[n][4].copy()
            # __download[n][4][ pkgs.gcc                       ] = pkgs.boost[boost_version]['gcc'].version
            # __download[n][4][ pkgs.gcc                       ] = usd_non_monolithic['gcc'       ].version
            __download[n][4][ pkgs.boost                     ] = boost_version
            __download[n][4][ usd_non_monolithic.obj         ] = usd_non_monolithic.version
            __download[n][4][ alembic.obj                    ] = alembic.version
            __download[n][4][ oiio['openvdb'                 ].obj ] = oiio['openvdb'                 ].version
            __download[n][4][ alembic['hdf5'                 ].obj ] = alembic['hdf5'                 ].version
            __download[n][4][ usd_non_monolithic['python'    ].obj ] = usd_non_monolithic['python'    ].version
            __download[n][4][ usd_non_monolithic['osl'       ].obj ] = usd_non_monolithic['osl'       ].version
            __download[n][4][ usd_non_monolithic['oiio'      ].obj ] = oiio_version
            __download[n][4][ usd_non_monolithic['ilmbase'   ].obj ] = usd_non_monolithic['openexr'   ].version
            __download[n][4][ usd_non_monolithic['openexr'   ].obj ] = usd_non_monolithic['openexr'   ].version
            __download[n][4][ usd_non_monolithic['pyilmbase' ].obj ] = usd_non_monolithic['openexr'   ].version
            __download[n][4][ usd_non_monolithic['tbb'       ].obj ] = usd_non_monolithic['tbb'       ].version
            # __download[n][4][ usd_non_monolithic['ocio'      ].obj ] = usd_non_monolithic['ocio'      ].version
            __download[n][4][ usd_non_monolithic['opensubdiv'].obj ] = usd_non_monolithic['opensubdiv'].version
            cortex_environ['USD_VERSION'] = usd_non_monolithic.version

        # we need this in cortex_options.py, so RPATH works!
        cortex_environ['CORTEX_TARGET_FOLDER'] = '$INSTALL_TARGET'

        # build.s_print( "cortex version: %s (%s)" % ( __download[n][2], sufix ) )

    # now build the version of cortex with the usd version
    pkgs.cortex[sufix] = build._cortex(
        ARGUMENTS, # noqa
        'cortex',
        targetSuffix = sufix,
        download = __download,
        # sed = build._cortex.onlyIECoreExtraSED(),
        # baseLibs = [pkgs.python],
        depend = depend+[pkgs.python],
        patch = devPatch,
        dontUseTargetSuffixForFolders = dontUseTargetSuffixForFolders,
        cmd = [
            # fixes for cortex version < 10.4
            '''if awk "BEGIN {exit !($VERSION_MAJOR < 10.4)}" ; then
                # Boost removed signals library starting on 1.69.0
                if awk "BEGIN {exit !($BOOST_VERSION_MAJOR >= 1.70)}" ; then
                    sed -i.bak -e 's/boost_signals//g' SConstruct
                fi
                # fix ambiguous ifstream on boost 1.70
                if awk "BEGIN {exit !($BOOST_VERSION_MAJOR >= 1.70)}" ; then
                    sed -i.bak -e 's/ifstream/std::ifstream/' src/IECoreGL/ShaderLoader.cpp
                fi
            fi''',
            # IECoreArnold is broken for newer arnold versions
            'unset ARNOLD_ROOT',
            'unset ARNOLD_VERSION',
            'export DCORES=$CORES',
            # build cortex
            build._cortex.cmd[0]+"installLib"+";"+\
            build._cortex.cmd[0]+"installCore"+";"+\
            build._cortex.cmd[0]+"installVDB"+";"+\
            build._cortex.cmd[0]+";"+\
            build._cortex.cmd[0]+" build ;"+\
            build._cortex.cmd[0]+" install",
        ],
        environ = cortex_environ,
        apps = apps,
    )
    for v in pkgs.cortex[sufix].keys():
        build.github_phase_one_version(ARGUMENTS, {pkgs.cortex[sufix] : v})

    return pkgs.cortex


# ===========================================================================================
# GAFFER
# ===========================================================================================
def gaffer(apps=[], boost=None, usd=None, pkgs=None, __download__=None, usd_monolithic=False):
    if not hasattr(pkgs, 'gaffer'):
        pkgs.gaffer = {}

    if not usd:
        usd = pkgs.masterVersion['usd']
    if not boost:
        boost = pkgs.masterVersion['boost']

    depend = cortex_depency(pkgs)
    version=0
    suffix = ''
    dontUseTargetSuffixForFolders = 1
    if apps:
        version = apps[0][1]
        suffix = "-%s.%s" % (str(apps[0][0]).split("'")[1].split(".")[-1], version)
        dontUseTargetSuffixForFolders = 1

    # grab the latest version of cortex to build gaffer.
    download = cortex_download(pkgs)
    _downloadCortex9 = [ []+x for x in download if build.versionMajor(x[2]) < 10.0 ]
    cortex9version = _downloadCortex9[-1][2]
    _downloadCortex10 = [ []+x for x in download if build.versionMajor(x[2]) >= 10.0 ]
    cortex10version = _downloadCortex10[-1][2]

    # define sufix from required boost/usd versions
    suffix = "boost.%s-usd.%s%s" % (boost, usd, suffix)
    # build.s_print( "gaffer: "+suffix )

    # replace the whole dowload list with a custom one
    _download = []+gaffer_download(pkgs)
    if __download__:
        _download=__download__

    # only build versions that are compatible with the current boost!
    _download = [ list(x) for x in _download if build.vComp(boost) >= build.vComp(x[5]["boost"][0]) and build.vComp(boost) <= build.vComp(x[5]["boost"][1]) ]
    _download = [ list(x) for x in _download if build.vComp(usd) >= build.vComp(x[5]["usd"][0]) and build.vComp(usd) <= build.vComp(x[5]["usd"][1]) ]
    # build.s_print( '::---->', boost, usd, [ x[0] for x in _download ])

    # only build versions that are compatible with the current arnold:
    for classe, av in apps:
        if 'arnold' in str(classe):
            _download = [ list(x) for x in _download if x[2] in arnold_versions[av]['gaffer'] ]

    # update dependencies, retrieving the versions from the boost/usd main versions
    # only build gaffer for the allowed cortex version
    _download = [ list(x) for x in _download if x[5]['cortex'] in pkgs.cortex["boost.%s-usd.%s" % (boost, usd)].versions ]
    if _download:
        for n in range(len(_download)):
            gaffer_version = _download[n][2]
            cortexOBJ = pkgs.cortex["boost.%s-usd.%s" % (boost, usd)][_download[n][5]['cortex']]

            # default packages for gaffer
            # _download[n][4].update( gaffer_dependency_dict(pkgs, _download[n][2]) )

            if usd_monolithic:
                usdOBJ = cortexOBJ['usd'].obj[ cortexOBJ['usd'].version ]
            else:
                usdOBJ = cortexOBJ['usd_non_monolithic'].obj[ cortexOBJ['usd_non_monolithic'].version ]

            # print(_download[n][4][pkgs.ocio])
            ocio    = pkgs.ocio[ _download[n][4][pkgs.ocio] ]
            osl     = usdOBJ['osl'          ].obj[ usdOBJ['osl'          ].version ]
            oiio    = usdOBJ['oiio'         ].obj[ usdOBJ['oiio'         ].version ]
            embree  = usdOBJ['embree'       ].obj[ usdOBJ['embree'       ].version ]
            # openvdb = usdOBJ['openvdb'      ].obj[ usdOBJ['openvdb'      ].version ]
            openvdb = cortexOBJ['openvdb'   ].obj[ cortexOBJ['openvdb'   ].version ]

            # pull gaffer defaults from package versions used by usd and cortex
            _download[n][4].update({
                pkgs.boost: boost,
                # pkgs.ocio: usdOBJ['ocio'].version,
                usdOBJ.obj                 : usdOBJ.version,
                usdOBJ['jemalloc'     ].obj: usdOBJ['jemalloc'     ].version,
                usdOBJ['embree'       ].obj: usdOBJ['embree'       ].version,
                usdOBJ['tbb'          ].obj: usdOBJ['tbb'          ].version,
                usdOBJ['osl'          ].obj: usdOBJ['osl'          ].version,
                usdOBJ['qt'           ].obj: usdOBJ['qt'           ].version,
                usdOBJ['pyside'       ].obj: usdOBJ['pyside'       ].version,
                usdOBJ['python'       ].obj: usdOBJ['python'       ].version,
                # usdOBJ['ocio'         ].obj: usdOBJ['ocio'         ].version,
                cortexOBJ.obj              : cortexOBJ.version,
                cortexOBJ['hdf5'      ].obj: cortexOBJ['hdf5'      ].version,
                cortexOBJ['alembic'   ].obj: cortexOBJ['alembic'   ].version,
                cortexOBJ['oiio'      ].obj: cortexOBJ['oiio'      ].version,
                cortexOBJ['openexr'   ].obj: cortexOBJ['openexr'   ].version,
                cortexOBJ['ilmbase'   ].obj: cortexOBJ['openexr'   ].version,
                cortexOBJ['pyilmbase' ].obj: cortexOBJ['openexr'   ].version,
                cortexOBJ['openvdb'   ].obj: cortexOBJ['openvdb'   ].version,
                cortexOBJ['opensubdiv'].obj: cortexOBJ['opensubdiv'].version,
                # pkgs.llvm     : osl['llvm'].version,
                # pkgs.clang    : osl['llvm'].version,
                pkgs.yaml     : ocio['yaml'].version,
                pkgs.yaml_cpp : ocio['yaml_cpp'].version,
                pkgs.pugixml  : oiio['pugixml'],
                pkgs.jpeg     : oiio['jpeg'].version,
                pkgs.glew     : embree['glew'].version,
                pkgs.ispc     : embree['ispc'].version,
                pkgs.cuda     : openvdb['cuda'].version,
                pkgs.optix    : openvdb['optix'].version,
            })

            # build.s_print( "gaffer version: %s (%s)" % (_download[n][2], suffix))
            print( "::======> build.vComp(%s) <= build.vComp('9.9.9.9') = %s" % (gaffer_version, build.vComp(gaffer_version) <= build.vComp('9.9.9.9')) )
            cyclesOBJ = None
            if build.vComp(gaffer_version) >= build.vComp('1.0.3.0') and build.vComp(gaffer_version) <= build.vComp('9.9.9.9'):
                # build cycles for the given boost/usd/gaffer version
                deps = {}
                deps.update(_download[n][4].copy())
                cyclesOBJ = cycles(boost, usd, pkgs, deps, gaffer_version, llvm='10.0.1')
                # and it to as dependencie to gaffer
                _download[n][4].update({
                    cyclesOBJ : cyclesOBJ.latestVersion(),
                })

        pkgs.gaffer[ suffix ] =  build._gaffer(
            ARGUMENTS, # noqa
            'gaffer',
            targetSuffix = suffix,
            sed=build._gaffer.sed,
            # baseLibs = [pkgs.python],
            download = _download,
            depend =  depend + [
                pkgs.qt, pkgs.pyside,
                pkgs.qtpy, pkgs.fonts,
                pkgs.ocio_profiles, pkgs.gaffer_resources
            ],
            apps = apps,
            cmd = ['''
                # patch SConstruct for cycles with cuda/hip support
                if python -c "exit(0 if $VERSION_MAJOR >= 1.1 else 1)" ; then
                    if [ "$(grep embree3 SConstruct)" != "" ] &&  [ "$(egrep 'embree3.*cuda' SConstruct)" == "" ]  ; then
                        sed -i.bak SConstruct -e 's/.embree3../"embree3", "cuda", "extern_cuew", "extern_hipew", "glog", "gflags",/'
                    fi
                fi
                '''+\
                build._gaffer.cmd[0]+";"+\
                build._gaffer.cmd[0]+' build ;'+\
                build._gaffer.cmd[0]+' install',
            ],
            dontUseTargetSuffixForFolders = dontUseTargetSuffixForFolders,
            dontAddLLVMtoEnviron = 1,
            environ = {
                'BUILD_TYPE' : 'DEBUG',
                'CXXFLAGS' : ' '.join([
                    # '-isystem $GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/',
                    # '-isystem $GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/',
                    # '-isystem $GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/',
                    # '-isystem $GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/x86_64-pc-linux-gnu/',
                    # '-isystem $GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/tr1/',
                    # '-isystem $GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/',
                    # '-isystem $GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/x86_64-pc-linux-gnu/',
                    '-I$FREETYPE_TARGET_FOLDER/include/freetype2/',
                    '-fno-strict-aliasing',
                    '-D_GLIBCXX_USE_CXX11_ABI=0',
                    pkgs.exr_rpath_environ['CXXFLAGS'],
                    '$CXXFLAGS',
                ]),
                # # we need this for pre-compiled appleseed (binary tarball),
                # # since centos 7 libc is too old
                'LD_PRELOAD': ':'.join([
                    '/usr/lib64/libstdc++.so.6',
                    '/lib64/libexpat.so.1',
                    # '$GCC_TARGET_FOLDER/lib64/libstdc++.so.6',
                    # '$GCC_TARGET_FOLDER/lib64/libgcc_s.so.1'
                ]) if 'fedora' in  pipe.distro else '',
                'LDFLAGS': pkgs.exr_rpath_environ['LDFLAGS'],
                'USD_VERSION': usd,
                'DCORES' : os.environ['MEMGB'] if int(os.environ['MEMGB']) < int(os.environ['CORES']) else os.environ['CORES'],
                # 'DCORES' : '1',
            },
        )
        # for v in pkgs.gaffer[suffix].keys():
        #     build.github_phase_one_version(ARGUMENTS, {pkgs.gaffer[suffix] : v})

    return pkgs.gaffer

# /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/cycles/3.2.0/.build.noBaseLib-boost.1.76.0-usd.21.11.0-gaffer.1.1.5.0.done ->
# /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/cycles/3.2.0/.build.noBaseLib-boost.1.76.0-usd.21.11.0-gaffer.1.1.5.0.done
# /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/cycles/3.2.0/.install.noBaseLib-boost.1.76.0-usd.21.11.0-gaffer.1.1.5.0.done ->
# .build/gaffer-1.0.1.0_gafferCortex.noBaseLib-boost.1.76.0-usd.21.11.0/SConstruct ->
# /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/gaffer/1.0.1.0/.build.noBaseLib-boost.1.76.0-usd.21.11.0.done ->
# /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/gaffer/1.0.1.0/.install.noBaseLib-boost.1.76.0-usd.21.11.0.done ->
# .build/wait4.phase64.1.0.1.0/configure -> /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/gaffer/1.0.1.0/.build.noBaseLib-phase64.done ->
# /frankbarton/pipeline/libs/linux/x86_64/pipevfx.5.0.1/gaffer/1.0.1.0/.install.noBaseLib-phase64.done ->
# .build/cycles-3.2.0.noBaseLib-boost.1.76.0-usd.21.11.0-gaffer.1.1.5.0/CMakeLists.txt ->

def cycles(boost=None, usd=None, pkgs=None, gaffer_dependencies={}, gaffer_version='', llvm='10.0.1'):
    if not hasattr(pkgs, 'cycles'):
        pkgs.cycles = {}

    # derivated package versions from gaffer dependencies
    usdOBJ = [ x for x in gaffer_dependencies.keys() if x and 'usd' in x.name ][0][usd]
    openvdb = [ x for x in gaffer_dependencies.keys() if x and 'openvdb' in x.name ][0]
    openvdbOBJ = openvdb[ gaffer_dependencies[openvdb] ]
    oslOBJ = usdOBJ['osl'].obj[usdOBJ['osl'].version]
    dependencies = gaffer_dependencies.copy()

    suffix = "boost.%s-usd.%s-gaffer.%s" % (boost, usd, gaffer_version)

    # add clang source with the same version as llvm, since cycles need it.
    dependencies[pkgs.clang] = dependencies[pkgs.llvm]

    # build the version compatible with for the requested gaffer
    download = []
    for each in cycles_download(pkgs):
        gaffer_min_version = build.vComp(each[5]['gaffer'][0])
        gaffer_max_version = build.vComp(each[5]['gaffer'][1])
        if build.vComp(gaffer_version) >= gaffer_min_version and build.vComp(gaffer_version) <= gaffer_max_version:
            download += [(
                each[0],
                each[1],
                each[2],
                each[3],
                dependencies.copy(),
            )]

    pkgs.cycles[suffix] = build.cmake(
        build.ARGUMENTS,
        'cycles',
        targetSuffix = suffix,
        # src='build-hradec.sh',
        download=download,
        cmd=['''
            if [ "$USD_NON_MONOLITHIC_TARGET_FOLDER" != "" ] ; then
                export USD_TARGET_FOLDER="$USD_NON_MONOLITHIC_TARGET_FOLDER"
                export USD_VERSION="$USD_NON_MONOLITHIC_VERSION"
            fi ; '''
            "mkdir -p build",
        	"cd build",
    		"cmake"
                ' -D DCMAKE_CC="$CC"'
                ' -D DCMAKE_CXX="$CXX"'
                " -D CMAKE_CXX_COMPILER=$CXX"
    			" -D CMAKE_BUILD_TYPE=Release"
    			" -D WITH_CYCLES_OPENIMAGEDENOISE=ON"
    			" -D WITH_CYCLES_DEVICE_CUDA=ON"
    			" -D WITH_CYCLES_DEVICE_OPTIX=ON"
    			" -D CMAKE_POSITION_INDEPENDENT_CODE=ON"
    			" -D PXR_ROOT=$USD_TARGET_FOLDER"
                " -D OPENSUBDIV_ROOT_DIR=$OPENSUBDIV_TARGET_FOLDER"
                " -D EMBREE_ROOT_DIR=$EMBREE_TARGET_FOLDER"
                " -D BOOST_ROOT=$BOOST_TARGET_FOLDER"
                " -D LLVM_ROOT_DIR=$LLVM_TARGET_FOLDER"
                " -D OPENCOLORIO_ROOT_DIR=$OCIO_TARGET_FOLDER"
                " -D OPENIMAGEIO_ROOT_DIR=$OIIO_TARGET_FOLDER"
                " -D OSL_ROOT_DIR=$OSL_TARGET_FOLDER"
                " -D OPENEXR_ROOT_DIR=$OPENEXR_TARGET_FOLDER"
                " -D JPEG_ROOT_DIR=$JPEG_ROOT_DIR"
                " -D PUGIXML_ROOT_DIR=$PUGIXML_ROOT_DIR"
                " -D WITH_OPENCOLORIO=ON"
                " -D OCIO_PATH=$OCIO_TARGET_FOLDER"
                " -D GLEW_ROOT_DIR=$GLEW_TARGET_FOLDER"
                " -D WITH_OPENVDB=ON"
                " -D BLOSC_ROOT_DIR=$BLOSC_TARGET_FOLDER"
                " -D OPENVDB_ROOT_DIR=$OPENVDB_TARGET_FOLDER"
                " -D TBB_ROOT_DIR=$TBB_TARGET_FOLDER"
                " -D GAFFER_ROOT=$GAFFER_TARGET_FOLDER"
                " -D WITH_CYCLES_DEVICE_CUDA=ON"
                " -D WITH_CYCLES_CUDA_BINARIES=ON"
                " -D WITH_CYCLES_DEVICE_OPTIX=ON"
                " -D OPTIX_ROOT_DIR=$OPTIX_TARGET_FOLDER"
                " -D WITH_CYCLES_DEVICE_CUDA=ON"
                " -D WITH_CYCLES_DEVICE_HIP=OFF"
                " -D WITH_CYCLES_HIP_BINARIES=OFF"
                " -D WITH_HIP_DYNLOAD=OFF"
                " -D WITH_CYCLES_EMBREE=ON"
                " -D WITH_CYCLES_OPENSUBDIV=ON"
                " -D WITH_CYCLES_LOGGING=ON"
                " -D WITH_OPENIMAGEDENOISE=ON"
                " -D WITH_NANOVDB=ON"
                # " -D WITH_CYCLES_SDF=OFF"
                # " -D WITH_CYCLES_CORNER_NORMALS=ON"
                " -D PYTHON_VARIANT=$PYTHON_VERSION_MAJOR"
                # instruct cmake to use new behaviour (which is to use pkg_ROOT as pkg root folders)
                " -D CMAKE_POLICY_DEFAULT_CMP0074=NEW"
    			" ..",
    		"make install -j $DCORES VERBOSE=1",
    		"mkdir -p ${INSTALL_FOLDER}/include",
            "cd ${SOURCE_FOLDER}/src && find . -name '*.h' | cpio -pdm ${INSTALL_FOLDER}/include ",
            "cd ${SOURCE_FOLDER}/",
    		"cp -rfv ${SOURCE_FOLDER}/third_party/atomic/* ${INSTALL_FOLDER}/include",
    		"mkdir -p ${INSTALL_FOLDER}/bin",
    		"mv ${INSTALL_FOLDER}/cycles ${INSTALL_FOLDER}/bin/cycles",
    		"cp -rfv ${SOURCE_FOLDER}/build/lib ${INSTALL_FOLDER}",
        ],
        environ = pkgs.llvm_plus_gcc_adjustment(forCMake=True),
    )
    return pkgs.cycles[suffix]



# ===========================================================================================
# CORTEX CORE for each boost
# ===========================================================================================
# build one version of IECore, IECorePython and IECoreGL libraries for each boost version
# print "pkgs.boost.versions:",pkgs.boost.versions
def legacy(pkgs):
    # build cortex bellow 10
    if not hasattr(pkgs, 'cortex'):
        pkgs.cortex = {}
    if not hasattr(pkgs, 'gaffer'):
        pkgs.gaffer = {}

    depend = cortex_depency(pkgs)
    for boost_version in pkgs.boost.versions:
        bsufix = "boost.%s" % boost_version
        _download = []
        extraInstall = ""

        # only build versions below 10.0 (legacy)
        download = cortex_download(pkgs)
        tmp = [ []+x for x in download if build.versionMajor(x[2]) < 10.0 ]

        # only build the versions that are compatible with the current boost version!
        _download = [ []+x for x in tmp  if build.vComp(boost_version) >= build.vComp(x[5]["boost"][0]) and build.vComp(boost_version) <= build.vComp(x[5]["boost"][1])   ]

        # build versions that match boost 1.51 and the masterVersion of boost.
        # if build.versionMajor(boost_version) <= 1.51:
        #     _download = [ []+x for x in download if build.versionMajor(x[2]) < 10.0 ]
        #
        # # build all versions newer than 10.0 with boost 1.55 and up.
        # elif build.versionMajor(boost_version) >= 1.6:
        #     # this legacy function only builds versions below 10 now!
        #     continue
        #     # # this forces to build only versions 10.0 and up!
        #     # # so versions below 10.0 will only build for boost versions below this one
        #     # _download = [ []+x for x in download if build.versionMajor(x[2]) >= 10.0 ]
        #     # if _download:
        #     #     # if we have cortex >= 10 to build, add some installs!
        #     #     extraInstall += " installImage installScene "
        #     #     # skip boost versions that don't build with cortex 10 at the moment
        #     #     # if boost_version in ['1.66.0']:
        #     #     #     continue

        # set the boost version of all downloads.
        # the variable _download will be use in all cortex builds below
        # as the main downloads template.
        for n in range(len(_download)):
            # delete usd, alembic and openvdb from dependency
            # in the _download template!
            for pkg in _download[n][4].keys():
                if pkg.name in ['usd', 'openvdb', 'alembic']:
                    del _download[n][4][pkg]

            _download[n][4] = _download[n][4].copy()
            _download[n][4][ pkgs.boost     ] = boost_version

            # we use different OIIO versions for cortex 9 and 10
            if build.versionMajor(_download[n][2]) >= 10.0:
                latest_osl_oiio_version = pkgs.latest_osl['oiio']
                oiio = pkgs.oiio[bsufix][latest_osl_oiio_version]
            else:
                oiio = pkgs.oiio[bsufix]['1.6.15']

            _download[n][4][ oiio.obj ] = oiio.version
            _download[n][4][ oiio['openexr'  ].obj ] = oiio['openexr'].version
            _download[n][4][ oiio['ilmbase'  ].obj ] = oiio['openexr'].version
            _download[n][4][ oiio['pyilmbase'].obj ] = oiio['openexr'].version

        if _download:
            __download = []+_download
            cortex_environ = pkgs.exr_rpath_environ.copy()
            pkgs.cortex[bsufix] = build._cortex(
                ARGUMENTS, # noqa
                'cortex',
                targetSuffix = bsufix,
                # build the version that matches the boost version in the loop!
                download = __download,
                # baseLibs = [pkgs.python],
                sed = build._cortex.onlyIECoreSED(),
                depend = depend+[pkgs.python],
                patch = devPatch,
                dontUseTargetSuffixForFolders = 1,
                # environ = { 'LD' : 'ld' },
                cmd = [
                    'export DCORES=$CORES',
                    build._cortex.cmd[0]+"installLib",
                    build._cortex.cmd[0]+"installCore",
                    build._cortex.cmd[0]+extraInstall+"installGL installStubs",
                ],
                environ = cortex_environ,
            )

            # ===========================================================================================
            # CORTEX ALEMBIC/OpenVDB for each boost it is available
            # ===========================================================================================
            if bsufix in pkgs.alembic:
                for alembic_version in pkgs.alembic[bsufix].versions:
                    # build the alembic cortex only for the boost version used to build the current alembic version.
                    alembic = pkgs.alembic[bsufix][alembic_version]
                    # alembic_boost = [ x[4][pkgs.boost] for x in pkgs.alembic.download if x[2] == alembic_version ][0]
                    if 'boost' in alembic and alembic['boost'] == boost_version:
                        sufix = "boost.%s-alembic.%s" % (boost_version, alembic_version)
                        # build.s_print( "cortex (legacy): "+sufix )

                        # cortex 9 is only compatible with alembic below 1.6
                        if build.versionMajor(alembic_version) < 1.6:
                            __download = [ []+x for x in _download if build.versionMajor(x[2]) < 10.0 ]
                        else:
                            __download = [ []+x for x in _download if build.versionMajor(x[2]) >= 10.0 ]

                        # we dont need to remove usd, alembic or openvdb since the _download won't have it!
                        for n in range(len(__download)):
                            # now set the alembic version for all cortex versions
                            __download[n][4] = __download[n][4].copy()
                            __download[n][4][ pkgs.boost               ] = boost_version
                            __download[n][4][ alembic.obj              ] = alembic.version
                            __download[n][4][ alembic['hdf5'].obj      ] = alembic['hdf5'].version
                            __download[n][4][ alembic['ilmbase'].obj   ] = alembic['openexr'].version
                            __download[n][4][ alembic['openexr'].obj   ] = alembic['openexr'].version
                            __download[n][4][ alembic['pyilmbase'].obj ] = alembic['openexr'].version
                            __download[n][4][ pkgs.cortex[bsufix]     ] = __download[n][2]

                        # and build cortex
                        pkgs.cortex[sufix] = build._cortex(
                            ARGUMENTS, # noqa
                            'cortex',
                            targetSuffix = sufix,
                            download = __download,
                            sed = build._cortex.onlyIECoreExtraSED(),
                            # baseLibs = [pkgs.python],
                            depend = depend+[pkgs.python],
                            patch = devPatch,
                            dontUseTargetSuffixForFolders = 1,
                            cmd = [build._cortex.cmd[0]+"installAlembic"],
                            environ = cortex_environ,
                            # environ = { 'LD' : 'ld' },
                        )

            '''
            # ===========================================================================================
            # CORTEX USD+ALEMBIC+OPENVDB for each boost it is available (only for cortex >= 10)
            # ===========================================================================================
            if bsufix in pkgs.usd:
                for usd_version in pkgs.usd[bsufix].versions:

                    # cortex is not compatible with USD 21.11 yet
                    if usd_version == '21.11.0':
                        continue

                    # build the usd cortex only for the boost version used to build the current usd version.
                    usd = pkgs.usd[bsufix][usd_version]
                    # usd_boost = [ x[4][pkgs.boost] for x in pkgs.usd.download if x[2] == usd_version ][0]
                    if 'boost' in usd and usd['boost'] == boost_version:
                        sufix = "boost.%s-usd.%s" % (boost_version, usd_version)
                        build.s_print( sufix )

                        # since USD was introduced in cortex 10, only build for version >= 10
                        # we select only the cortex version that uses the current version of USD to build in this step
                        # the []+x is to create a new list!
                        __download = [ []+x for x in _download if build.versionMajor(x[2]) >= 10.0 ] # if x[4][pkgs.usd[bsufix]] == usd_version ]

                        # we dont need to remove usd, alembic or openvdb since the _download won't have it!
                        for n in range(len(__download)):
                            # set the version of usd for all versions of cortex >= 10
                            __download[n][4] = __download[n][4].copy()
                            __download[n][4][ pkgs.boost     ] = boost_version

                            __download[n][4][ usd.obj ] = usd.version
                            alembic = usd['alembic'].obj[usd['alembic'].version]
                            __download[n][4][ usd['alembic'  ].obj ] = usd['alembic'  ].version
                            __download[n][4][ alembic['hdf5' ].obj ] = alembic['hdf5'].version
                            __download[n][4][ usd['oiio'     ].obj ] = usd['oiio'     ].version
                            __download[n][4][ usd['openvdb'  ].obj ] = usd['openvdb'  ].version
                            __download[n][4][ usd['ilmbase'  ].obj ] = usd['openexr'  ].version
                            __download[n][4][ usd['openexr'  ].obj ] = usd['openexr'  ].version
                            __download[n][4][ usd['pyilmbase'].obj ] = usd['openexr'  ].version
                            __download[n][4][ pkgs.cortex[bsufix] ] = __download[n][2]

                        # now build the version of cortex with the usd version
                        pkgs.cortex[sufix] = build._cortex(
                            ARGUMENTS, # noqa
                            'cortex',
                            targetSuffix = sufix,
                            download = __download,
                            sed = build._cortex.onlyIECoreExtraSED(),
                            # baseLibs = [pkgs.python],
                            depend = depend+[pkgs.python],
                            patch = devPatch,
                            dontUseTargetSuffixForFolders = 1,
                            cmd = [build._cortex.cmd[0]+"installUSD installVDB"],
                            environ = cortex_environ,
                            # environ = { 'LD' : 'ld' },
                        )

            # ===========================================================================================
            # CORTEX APPLESEED
            # ===========================================================================================
            # build the appleseed version for the current boost version, if any!
            appleseed_versions = [ x[2] for x in pkgs.appleseed.download if x[4][pkgs.boost] == boost_version ]
            for appleseed_version in appleseed_versions:
                # build the openvdb cortex only for the boost version used to build the current openvdb version.
                appleseed_boost = [ x[4][pkgs.boost] for x in pkgs.appleseed.download if x[2] == appleseed_version ][0]
                if appleseed_boost and appleseed_boost == boost_version:

                    sufix = "boost.%s.appleseed.%s" % (boost_version, appleseed_version)

                    # since openvdb was introduced in cortex 10, only build for version >= 10
                    __download = [ []+x for x in download if build.versionMajor(x[2]) >= 10.0 ]

                    # set the version of openvdb for all versions of cortex.
                    for n in range(len(__download)):
                        __download[n][4] = __download[n][4].copy()
                        __download[n][4][ pkgs.boost     ] = boost_version
                        __download[n][4][ cortex         ['boost.%s' % boost_version] ] = __download[n][2]
                        __download[n][4][ pkgs.ilmbase   ['boost.%s' % boost_version] ] = exr_version
                        __download[n][4][ pkgs.pyilmbase ['boost.%s' % boost_version] ] = exr_version
                        __download[n][4][ pkgs.openexr   ['boost.%s' % boost_version] ] = exr_version
                        __download[n][4][ pkgs.oiio      ['boost.%s' % boost_version] ] = '1.8.10'
                        __download[n][4][ pkgs.usd       ] = None
                        __download[n][4][ pkgs.alembic[bsufix]   ] = None
                        __download[n][4][ pkgs.openvdb   ] = None

                    # now build the version of cortex with the openvdb version
                    pkgs.cortex[sufix] = build._cortex(
                        ARGUMENTS, # noqa
                        'cortex',
                        targetSuffix = sufix,
                        download = __download,
                        sed = build._cortex.onlyIECoreExtraSED(),
                        # baseLibs = [pkgs.python],
                        depend = depend+[pkgs.python],
                        patch = devPatch,
                        dontUseTargetSuffixForFolders = 1,
                        cmd = [
                            build._cortex.cmd[0]+"installAppleseed",
                        ],
                        environ = cortex_environ,
                    )
            '''
