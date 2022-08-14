

import build


def gafferCycles(boost=None, usd=None, pkgs=None, openvdb_boost=None):
    if not usd:
        usd = pkgs.masterVersion['usd']
    if not boost:
        usd = pkgs.masterVersion['boost']
    if not openvdb_boost:
        openvdb_boost = boost

    pkgs.cyclesx = build.download(
        build.ARGUMENTS,
        'cyclesx',
        src='CMakeLists.txt',
        download=[(
            'https://github.com/boberfly/cycles/archive/refs/tags/0.24.0.tar.gz',
            'cycles-0.24.0.tar.gz',
            '0.24.0',
            'a623952094e2f953d05eca62f16e664a',
        )],
    )

    # special case, since we can't build gaffer with boost.1.70.0 yet,
    # and gaffercycles needs openvdb 9, which needs boost 1.70.0
    openvdbVersion = pkgs.openvdb['boost.%s' % openvdb_boost].latestVersion()
    openvdbOBJ = pkgs.openvdb['boost.%s' % openvdb_boost][openvdbVersion]

    # print "=================>",build.pkgVersions('openvdb').latestVersion(), build.pkgVersions('openvdb').latestVersionOBJ()['boost'].version
    # print "=================>",build.pkgVersions('cortex').latestVersion(), build.pkgVersions('cortex').latestVersionOBJ()

    usd_suffix = "boost.%s" % boost
    gaffer_suffix = "boost.%s-usd.%s" % (boost, usd)
    if usd_suffix not in pkgs.usd or gaffer_suffix not in pkgs.gaffer:
        return
    usdOBJ = pkgs.usd['boost.%s' % boost][usd]

    # gafferVersion = [ x for x in pkgs.gaffer[gaffer_suffix].latestVersion()
    for gafferVersion in pkgs.gaffer[gaffer_suffix].versions:
        if build.vComp(gafferVersion) < build.vComp('0.62'):
            gafferOBJ = pkgs.gaffer[gaffer_suffix][gafferVersion]
            oslOBJ = gafferOBJ['osl'].obj[ gafferOBJ['osl'].version ]

            pkgs.gafferCyclesx = build.cmake(
                build.ARGUMENTS,
                'gaffer_cycles',
                # targetSuffix = 'boost.%s-usd.%s-cyclesx.%s' % (boost, usd, pkgs.cyclesx.latestVersion()),
                download=[(
                    'https://github.com/boberfly/GafferCycles/archive/refs/tags/0.24.0.tar.gz',
                    'GafferCycles-0.24.0.tar.gz',
                    '0.24.0',
                    'a4f431798e073628b363e8fd4f18e5db',
                    {pkgs.boost: boost,
                    usdOBJ.obj: usdOBJ.version,
                    usdOBJ['jemalloc'].obj: usdOBJ['jemalloc' ].version,
                    usdOBJ['blosc'].obj: usdOBJ['blosc'].version,
                    usdOBJ['opensubdiv'].obj: usdOBJ['opensubdiv'].version,
                    usdOBJ['embree'].obj: usdOBJ['embree'].version,
                    gafferOBJ.obj: gafferOBJ.version,
                    gafferOBJ['tbb'].obj: gafferOBJ['tbb'].version,
                    gafferOBJ['cortex'].obj: gafferOBJ['cortex'].version,
                    gafferOBJ['openexr'].obj: gafferOBJ['openexr'].version,
                    gafferOBJ['oiio'].obj: gafferOBJ['oiio'].version,
                    gafferOBJ['ocio'].obj: gafferOBJ['ocio'].version,
                    gafferOBJ['osl'].obj: gafferOBJ['osl'].version,
                    oslOBJ['pugixml'].obj: oslOBJ['pugixml'].version,
                    oslOBJ['llvm'].obj: oslOBJ['llvm'].version,
                    pkgs.jpeg: pkgs.jpeg.latestVersion(),
                    pkgs.glew: pkgs.glew.latestVersion(),
                    pkgs.cuda: pkgs.cuda.latestVersion(),
                    pkgs.optix: pkgs.optix.latestVersion(),
                    pkgs.ispc: pkgs.ispc.latestVersion(),
                    pkgs.glog: pkgs.glog.latestVersion(),
                    pkgs.gflags: pkgs.gflags.latestVersion(),
                    pkgs.cyclesx: pkgs.cyclesx.latestVersion(),
                    # we need the latest gcc, since we're using binary embree/odin
                    pkgs.gcc: pkgs.gcc.latestVersion(),
                    # the tbb version used by embree/odin binaries
                    # pkgs.tbb: '2021.5.0',
                    # embree and oidn are pre-built binaries!!
                    pkgs.oidn: pkgs.oidn.latestVersion(),
                    # we're using the latest openvdb, even if it wasn't build with the
                    # current boost version!
                    openvdbOBJ.obj : openvdbOBJ.obj.latestVersion()}
                    # gafferOBJ['openvdb'].obj: gafferOBJ['openvdb'].version,
                )],
                flags = [
                    ' -D DCMAKE_CC="$CC"'
                    ' -D DCMAKE_CXX="$CXX"'
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
                	" -D CMAKE_BUILD_TYPE=RELEASE"
            		" -D GAFFER_ROOT=$GAFFER_TARGET_FOLDER"
            		" -D CMAKE_CXX_COMPILER=$CXX"
            		" -D WITH_CYCLES_DEVICE_CUDA=ON"
            		" -D WITH_CYCLES_CUDA_BINARIES=ON"
            		" -D OPTIX_ROOT_DIR=$OPTIX_TARGET_FOLDER"
            		" -D WITH_CYCLES_DEVICE_OPTIX=ON"
            		" -D WITH_CYCLES_EMBREE=ON"
            		" -D WITH_CYCLES_OPENSUBDIV=ON"
            		" -D WITH_CYCLES_LOGGING=ON"
            		" -D WITH_OPENIMAGEDENOISE=ON"
            		" -D WITH_NANOVDB=ON"
            		" -D WITH_CYCLES_SDF=OFF"
            		" -D WITH_CYCLES_CORNER_NORMALS=ON"
                    " -D WITH_CYCLES_DEVICE_HIP=ON"
                    " -D WITH_CYCLES_HIP_BINARIES=ON"
                    " -D WITH_HIP_DYNLOAD=ON"
            		" -D PYTHON_VARIANT=$PYTHON_VERSION_MAJOR"
                    " -D WITH_CYCLES_DEVICE_CUDA=ON"
                    # instruct cmake to use new behaviour (which is to use pkg_ROOT as pkg root folders)
                    " -D CMAKE_POLICY_DEFAULT_CMP0074=NEW"
                    # cortex setup
                    " -D CORTEX_LOCATION=$CORTEX_TARGET_FOLDER"
                    " -D Cortex_IECOREIMAGE_LIBRARY=$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/libIECoreImage.so"
                    " -D Cortex_IECOREPYTHON_LIBRARY=$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/libIECorePython.so"
                    " -D Cortex_IECORESCENE_LIBRARY=$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/libIECoreScene.so"
                    " -D Cortex_IECORE_LIBRARY=$CORTEX_TARGET_FOLDER/lib/boost.$BOOST_VERSION/libIECore.so"
                    # experimental
                    # " -D WITH_CYCLES_TEXTURE_CACHE=ON"
            		# " -D WITH_CYCLES_LIGHTGROUPS=ON"
                ],
                cmd = [
                    # put our pre-downloaded version of cyclesx as the cycles folder
                    # in this source folder
                    'mv $OCIO_TARGET_FOLDER/lib/static $OCIO_TARGET_FOLDER/__static',
                    'rmdir cycles',
                    'ln -s $CYCLESX_TARGET_FOLDER ./cycles',
                    # remove yaml and expat libraries from findOpenColorIO, since we only have the shared ocio library
                    "sed -i.bak -e 's/yaml/#yaml/' -e 's/expat/#expat/' ./cycles/src/cm???/Modules/FindOpenColorIO.cmak?",
                    # now we can build!
                    'mkdir build',
                    'cd build',
                    'cmake ..',
                    'make -j $DCORES',
                    'make -j $DCORES install ',
                    'mv $OCIO_TARGET_FOLDER/__static $OCIO_TARGET_FOLDER/lib/static',
                ],
                environ = {
                    'CXXFLAGS' : pkgs.gcc_llvm_environ['CXX'].split('g++')[1]+' $CXXFLAGS -fno-strict-aliasing -D_GLIBCXX_USE_CXX11_ABI=0',
                },
            )
