

import build


def gafferCycles(boost=None, usd=None, pkgs=None):
    if not usd:
        usd = pkgs.masterVersion['usd']
    if not boost:
        usd = pkgs.masterVersion['boost']

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
    pkgs.ispc = build.download(
        build.ARGUMENTS,
        'ispc',
        src='ReleaseNotes.txt',
        download=[(
            'https://github.com/ispc/ispc/releases/download/v1.16.1/ispc-v1.16.1-linux.tar.gz',
            'ispc-v1.16.1-linux.tar.gz',
            '1.16.1',
            '4665c577541003e31c8ce0afd64b6952',
        )],
    )

    usdOBJ = pkgs.usd['boost.%s' % boost][usd]
    gaffer_suffix = "boost.%s-usd.%s" % (boost, usd)
    gafferVersion = pkgs.gaffer[gaffer_suffix].latestVersion()
    gafferOBJ = pkgs.gaffer[gaffer_suffix][gafferVersion]
    oslOBJ = gafferOBJ['osl'].obj[ gafferOBJ['osl'].version ]
    pkgs.gafferCyclesx = build.cmake(
        build.ARGUMENTS,
        'gaffer',
        targetSuffix = 'boost.%s-usd.%s-cyclesx.%s' % (boost, usd, pkgs.cyclesx.latestVersion()),
        download=[(
            'https://github.com/boberfly/GafferCycles/archive/refs/tags/0.22.1.tar.gz',
            'GafferCycles-0.22.1.tar.gz',
            '0.22.1',
            '203152c7abd0d2aa304309a8779665d5',
            { pkgs.boost: boost, usdOBJ.obj: usd,
            gafferOBJ.obj: gafferOBJ.version,
            gafferOBJ['cortex'].obj: gafferOBJ['cortex'].version,
            gafferOBJ['openexr'].obj: gafferOBJ['openexr'].version,
            gafferOBJ['oiio'].obj: gafferOBJ['oiio'].version,
            gafferOBJ['ocio'].obj: gafferOBJ['ocio'].version,
            gafferOBJ['osl'].obj: gafferOBJ['osl'].version,
            gafferOBJ['openvdb'].obj: gafferOBJ['openvdb'].version,
            gafferOBJ['tbb'].obj: gafferOBJ['tbb'].version,
            usdOBJ['blosc'].obj: usdOBJ['blosc'].version,
            usdOBJ['embree'].obj: usdOBJ['embree'].version,
            usdOBJ['opensubdiv'].obj: usdOBJ['opensubdiv'].version,
            oslOBJ['pugixml'].obj: oslOBJ['pugixml'].version,
            pkgs.jpeg: pkgs.jpeg.latestVersion(),
            pkgs.glew: pkgs.glew.latestVersion(),
            pkgs.cuda: pkgs.cuda.latestVersion(),
            pkgs.optix: pkgs.optix.latestVersion(),
            pkgs.ispc: pkgs.ispc.latestVersion(),
            pkgs.glog: pkgs.glog.latestVersion(),
            pkgs.gflags: pkgs.gflags.latestVersion(),
            pkgs.cyclesx: pkgs.cyclesx.latestVersion() }
        )],
        flags = [
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
            " -D CORTEX_LOCATION=$CORTEX_TARGET_FOLDER"
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
    		" -D WITH_NANOVDB=OFF"
    		" -D WITH_CYCLES_SDF=OFF"
    		" -D WITH_CYCLES_CORNER_NORMALS=ON"
            " -D WITH_CYCLES_DEVICE_HIP=ON"
            " -D WITH_CYCLES_HIP_BINARIES=ON"
            " -D WITH_HIP_DYNLOAD=ON"
    		" -D PYTHON_VARIANT=$PYTHON_VERSION_MAJOR"
            " -D WITH_CYCLES_DEVICE_CUDA=ON"
            # instruct cmake to use new behaviour (which is to use pkg_ROOT as pkg root folders)
            " -D CMAKE_POLICY_DEFAULT_CMP0074=NEW"
            # experimental
            # " -D WITH_CYCLES_TEXTURE_CACHE=ON"
    		# " -D WITH_CYCLES_LIGHTGROUPS=ON"
        ],
        cmd = [
            # put our pre-downloaded version of cyclesx as the cycles folder
            # in this source folder
            'rmdir cycles',
            'ln -s $CYCLESX_TARGET_FOLDER ./cycles',
            # now we can build!
            'mkdir build',
            'cd build',
            'cmake ..',
            'make -j $DCORES',
        ]
    )
