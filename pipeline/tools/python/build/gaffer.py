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


# we're setting boostMasterVersion as the main default boost version
# although we try to build cortex with all the available boost versions,
# but because of boost is used by other cortex dependencies, we have
# to build only the boost versions we have dependencies built for.
boostMasterVersion = "1.66.0"

# cortex versions we build for now.
download = [[
    'https://github.com/ImageEngine/cortex/archive/9.18.0.tar.gz',
    'cortex-9.18.0.tar.gz',
    '9.18.0',
    'b3c55cc5e0e95668208713a01a145869',
    {}
 ],[
    'https://github.com/ImageEngine/cortex/archive/refs/tags/10.2.3.1.tar.gz',
    'cortex-10.2.3.1.tar.gz',
    '10.2.3.1',
    '1a09b3ac5d59c43c36d958ea7875d532',
    {}
]]
def cortex_depency(pkgs):
    return [
        pkgs.icu, pkgs.tbb, pkgs.jpeg, pkgs.libraw,
        pkgs.freeglut, pkgs.freetype, pkgs.libpng,
        pkgs.tiff, pkgs.jpeg, pkgs.openssl,
        pkgs.glew, pkgs.blosc, pkgs.opensubdiv,
        pkgs.ptex,  #, pkgs.appleseed
    ]




# gcc_version = ''.join(os.popen("gcc --version | head -1 | awk '{print $(NF)}' | awk -F'-' '{print $1}'").readlines())
# os.environ['GCC_VERSION'] = 'gcc-%s' % gcc_version
# os.environ['GCC_VERSION'] = 'gcc-multi'


# download and install arnold versions to build arnold gaffer extension
arnold_versions = ['7.0.0.0']
for arnold_version in arnold_versions:
    if not glob.glob( '/%s/apps/linux/x86_64/arnold/%s/*' % (os.environ['STUDIO'], arnold_version) ):
        error = os.system('''
            sh /.github/workflows/main/installArnold.sh %s
            mkdir -p /$STUDIO/apps/linux/x86_64/arnold/
            mv arnoldRoot/%s /$STUDIO/apps/linux/x86_64/arnold/
            ls -l /$STUDIO/apps/linux/x86_64/arnold/
            ls -l /$STUDIO/apps/linux/x86_64/arnold/%s/
        ''' % (arnold_version, arnold_version, arnold_version))



# ===========================================================================================
# CORTEX VFX
# ===========================================================================================

# we use this to apply patches created when developing cortex
devPatch = []
patchFile = os.environ['HOME']+'/dev/cortex.git/patch'
if os.path.exists( patchFile ):
    devPatch = [ ''.join(open(patchFile).readlines()) ]


# ===========================================================================================
# CORTEX CORE for each boost
# ===========================================================================================
# build one version of IECore, IECorePython and IECoreGL libraries for each boost version
# print "pkgs.boost.versions:",pkgs.boost.versions


def legacy(pkgs):
    # build cortex matrix
    if not hasattr(pkgs, 'cortex'):
        pkgs.cortex = {}
    if not hasattr(pkgs, 'gaffer'):
        pkgs.gaffer = {}

    depend = cortex_depency(pkgs)
    for boost_version in pkgs.boost.versions:
        cortex_sufix = "boost.%s" % boost_version
        _download = []
        extraInstall = ""
        # build versions that match boost 1.51 and the masterVersion of boost.
        if build.versionMajor(boost_version) <= 1.51:
            _download = [ []+x for x in download if build.versionMajor(x[2]) < 10.0 ]

        # build all versions newer than 10.0 with boost 1.55 and up.
        elif build.versionMajor(boost_version) >= 1.6:
            # this forces to build only versions 10.0 and up!
            # so versions below 10.0 will only build for boost versions below this one
            _download = [ []+x for x in download if build.versionMajor(x[2]) >= 10.0 ]
            if _download:
                # if we have cortex >= 10 to build, add some installs!
                extraInstall += " installImage installScene "
                # skip boost versions that don't build with cortex 10 at the moment
                # if boost_version in ['1.66.0']:
                #     continue

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
                oiio = pkgs.oiio[cortex_sufix][latest_osl_oiio_version]
            else:
                oiio = pkgs.oiio[cortex_sufix]['1.6.15']

            _download[n][4][ oiio.obj ] = oiio.version
            _download[n][4][ oiio['openexr'  ].obj ] = oiio['openexr'].version
            _download[n][4][ oiio['ilmbase'  ].obj ] = oiio['openexr'].version
            _download[n][4][ oiio['pyilmbase'].obj ] = oiio['openexr'].version

        if _download:
            __download = []+_download
            cortex_environ = pkgs.exr_rpath_environ.copy()
            pkgs.cortex[cortex_sufix] = build._cortex(
                ARGUMENTS, # noqa
                'cortex',
                targetSuffix = cortex_sufix,
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
            # CORTEX ALEMBIC for each boost it is available
            # ===========================================================================================
            if cortex_sufix in pkgs.alembic:
                for alembic_version in pkgs.alembic[cortex_sufix].versions:
                    # build the alembic cortex only for the boost version used to build the current alembic version.
                    alembic = pkgs.alembic[cortex_sufix][alembic_version]
                    # alembic_boost = [ x[4][pkgs.boost] for x in pkgs.alembic.download if x[2] == alembic_version ][0]
                    if 'boost' in alembic and alembic['boost'] == boost_version:
                        sufix = "boost.%s-alembic.%s" % (boost_version, alembic_version)
                        build.s_print( sufix )

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
                            __download[n][4][ pkgs.cortex[cortex_sufix]     ] = __download[n][2]

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


            # ===========================================================================================
            # CORTEX USD+ALEMBIC+OPENVDB for each boost it is available (only for cortex >= 10)
            # ===========================================================================================
            if cortex_sufix in pkgs.usd:
                for usd_version in pkgs.usd[cortex_sufix].versions:

                    # cortex is not compatible with USD 21.11 yet
                    if usd_version == '21.11.0':
                        continue

                    # build the usd cortex only for the boost version used to build the current usd version.
                    usd = pkgs.usd[cortex_sufix][usd_version]
                    # usd_boost = [ x[4][pkgs.boost] for x in pkgs.usd.download if x[2] == usd_version ][0]
                    if 'boost' in usd and usd['boost'] == boost_version:
                        sufix = "boost.%s-usd.%s" % (boost_version, usd_version)
                        build.s_print( sufix )

                        # since USD was introduced in cortex 10, only build for version >= 10
                        # we select only the cortex version that uses the current version of USD to build in this step
                        # the []+x is to create a new list!
                        __download = [ []+x for x in _download if build.versionMajor(x[2]) >= 10.0 ] # if x[4][pkgs.usd[cortex_sufix]] == usd_version ]

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
                            __download[n][4][ pkgs.cortex[cortex_sufix] ] = __download[n][2]

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

    '''
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
                        __download[n][4][ pkgs.alembic[cortex_sufix]   ] = None
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


def cortex(apps=[], boost='1.66.0', usd=None, pkgs=None, __download__=None):
    legacy(pkgs=pkgs)
    depend = cortex_depency(pkgs)
    boost_version = boost
    cortex_sufix = "boost.%s" % boost_version
    _download = []
    extraInstall = ""
    # build versions that match boost 1.51 and the masterVersion of boost.
    if build.versionMajor(boost_version) <= 1.51:
        _download = [ []+x for x in download if build.versionMajor(x[2]) < 10.0 ]

    # build all versions newer than 10.0 with boost 1.55 and up.
    elif build.versionMajor(boost_version) >= 1.6:
        # this forces to build only versions 10.0 and up!
        # so versions below 10.0 will only build for boost versions below this one
        _download = [ []+x for x in download if build.versionMajor(x[2]) >= 10.0 ]
        if _download:
            # if we have cortex >= 10 to build, add some installs!
            extraInstall += " installImage installScene "
            # skip boost versions that don't build with cortex 10 at the moment
            # if boost_version in ['1.66.0']:
            #     continue

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
            oiio = pkgs.oiio[cortex_sufix][latest_osl_oiio_version]
        else:
            oiio = pkgs.oiio[cortex_sufix]['1.6.15']

        _download[n][4][ oiio.obj ] = oiio.version
        _download[n][4][ oiio['openexr'  ].obj ] = oiio['openexr'].version
        _download[n][4][ oiio['ilmbase'  ].obj ] = oiio['openexr'].version
        _download[n][4][ oiio['pyilmbase'].obj ] = oiio['openexr'].version

    cortex_environ = pkgs.exr_rpath_environ.copy()

    # ===========================================================================================
    # CORTEX APP
    # ===========================================================================================
    usd_version = usd
    # build the usd cortex only for the boost version used to build the current usd version.
    usd = pkgs.usd[cortex_sufix][usd_version]
    # usd_boost = [ x[4][pkgs.boost] for x in pkgs.usd.download if x[2] == usd_version ][0]
    if 'boost' in usd and usd['boost'] == boost_version:
        suffix = ''
        dontUseTargetSuffixForFolders = 1
        if apps:
            version = apps[0][1]
            suffix = "-%s.%s" % (str(apps[0][0]).split("'")[1].split(".")[-1], version)
            dontUseTargetSuffixForFolders = 1

        sufix = "boost.%s-usd.%s%s" % (boost_version, usd_version, suffix)
        build.s_print( sufix )

        # since USD was introduced in cortex 10, only build for version >= 10
        # we select only the cortex version that uses the current version of USD to build in this step
        # the []+x is to create a new list!
        __download = [ []+x for x in _download if build.versionMajor(x[2]) >= 10.0 ] # if x[4][pkgs.usd[cortex_sufix]] == usd_version ]

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
            __download[n][4][ pkgs.cortex[cortex_sufix] ] = __download[n][2]

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
                build._cortex.cmd[0]+" install",
            ],
            environ = cortex_environ,
            apps = apps,
            # environ = { 'LD' : 'ld' },
        )
        return pkgs.cortex[sufix]


# ===========================================================================================
# GAFFER
# ===========================================================================================
def gaffer(apps=[], boost='1.66.0', usd=None, pkgs=None, __download__=None):
    depend = cortex_depency(pkgs)
    version=0
    suffix = ''
    dontUseTargetSuffixForFolders = 1
    if apps:
        version = apps[0][1]
        suffix = "-%s.%s" % (str(apps[0][0]).split("'")[1].split(".")[-1], version)
        dontUseTargetSuffixForFolders = 1

    # grab the latest version of cortex to build gaffer.
    _downloadCortex9 = [ []+x for x in download if build.versionMajor(x[2]) < 10.0 ]
    cortex9version = _downloadCortex9[-1][2]
    _downloadCortex10 = [ []+x for x in download if build.versionMajor(x[2]) >= 10.0 ]
    cortex10version = _downloadCortex10[-1][2]
    build.s_print( "CortexVFX used to build Gaffer:", cortex10version )

    # use a cortex build without applessed.
    usd_version = usd
    if not usd_version:
        usd_version = pkgs.masterVersion['usd']

    suffix = "boost.%s-usd.%s%s" % (boost, usd_version, suffix)
    cortexOBJ = pkgs.cortex["boost.%s-usd.%s" % (boost, usd_version)][cortex10version]

    usd = cortexOBJ['usd'].obj[ cortexOBJ['usd'].version ]
    gaffer_download = [[
        'https://github.com/hradec/gaffer/archive/refs/tags/0.61.1.1-gaffercortex.tar.gz',
        'gaffer-0.61.1.1-gaffercortex.tar.gz',
        '0.61.1.1',
        '31b22fb2999873c92aeefea4999ccc3e',
        {pkgs.ocio: '1.0.9', pkgs.pyside: '5.15.2', pkgs.qt: '5.15.2',
        pkgs.tbb: '2019_U6', pkgs.llvm: '10.0.1', pkgs.gcc : '6.3.1',
        pkgs.boost: boost,
        usd['osl'].obj: usd['osl'].version,
        cortexOBJ.obj: cortexOBJ.version,
        cortexOBJ['usd'      ].obj: cortexOBJ['usd'      ].version,
        cortexOBJ['openvdb'  ].obj: cortexOBJ['openvdb'  ].version,
        cortexOBJ['hdf5'     ].obj: cortexOBJ['hdf5'     ].version,
        cortexOBJ['alembic'  ].obj: cortexOBJ['alembic'  ].version,
        cortexOBJ['oiio'     ].obj: cortexOBJ['oiio'     ].version,
        cortexOBJ['openexr'  ].obj: cortexOBJ['openexr'  ].version,
        cortexOBJ['ilmbase'  ].obj: cortexOBJ['openexr'  ].version,
        cortexOBJ['pyilmbase'].obj: cortexOBJ['openexr'  ].version}
    ]]
    if __download__:
        gaffer_download=__download__

    pkgs.gaffer[ suffix ] =  build._gaffer(
        ARGUMENTS, # noqa
        'gaffer',
        targetSuffix = suffix,
        sed=build._gaffer.sed,
        # baseLibs = [pkgs.python],
        download = gaffer_download,
        depend =  depend + [
            pkgs.qt, pkgs.pyside, pkgs.osl,
            pkgs.oiio, pkgs.ocio, pkgs.llvm,
            pkgs.python, pkgs.qtpy, pkgs.fonts,
            pkgs.ocio_profiles, pkgs.gaffer_resources
        ],
        apps = apps,
        cmd = [
            build._gaffer.cmd[0],
            build._gaffer.cmd[0]+' build',
            build._gaffer.cmd[0]+' install',
        ],
        dontUseTargetSuffixForFolders = dontUseTargetSuffixForFolders,
        dontAddLLVMtoEnviron = 1,
        environ = {
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
            # we need this for pre-compiled appleseed (binary tarball),
            # since centos 7 libc is too old
            'LD_PRELOAD': ':'.join([
                '/usr/lib64/libstdc++.so.6',
                '/lib64/libexpat.so.1',
                # '$GCC_TARGET_FOLDER/lib64/libstdc++.so.6',
                # '$GCC_TARGET_FOLDER/lib64/libgcc_s.so.1'
            ]) if 'fedora' in  pipe.distro else '',
            'LDFLAGS': pkgs.exr_rpath_environ['LDFLAGS'],
            'DCORES' : os.environ['CORES'],
            # 'DCORES' : '1',
            # 'LD' : 'ld'
        },
    )
    return pkgs.gaffer[ suffix ]
