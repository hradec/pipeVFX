

import build


def gafferCycles(boost='1.66.0', usd=None, pkgs=None):
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
    pkgs.cuda = build.download(
        build.ARGUMENTS,
        'cuda',
        src='cuda-11.5.1-1.x86_64.rpm',
        download=[(
            'https://developer.download.nvidia.com/compute/cuda/11.5.1/local_installers/cuda-repo-rhel7-11-5-local-11.5.1_495.29.05-1.x86_64.rpm',
            'cuda-repo-rhel7-11-5-local-11.5.1_495.29.05-1.x86_64.rpm',
            '11.5.1.nv495.29.05-1',
            'b26ee5949096d2c98ef628a9b51e5f46',
        )],
    )
    pkgs.ispc = build.download(
        build.ARGUMENTS,
        'ispc',
        src='CMakeLists.txt',
        download=[(
            'https://github.com/ispc/ispc/releases/download/v1.16.1/ispc-v1.16.1-linux.tar.gz',
            'ispc-v1.16.1-linux.tar.gz',
            '1.16.1',
            '4665c577541003e31c8ce0afd64b6952',
        )],
    )


    pkgs.gafferCyclesx = build.cmake(
        build.ARGUMENTS,
        'gaffer',
        targetSuffix = 'boost.%s-usd.%s' % (boost, usd)
        download=[(
            'https://github.com/boberfly/GafferCycles/archive/refs/tags/0.22.1.tar.gz',
            'GafferCycles-0.22.1.tar.gz',
            '0.22.1',
            'a623952094e2f953d05eca62f16e664a',
            { pkgs.boost: boost, pkgs.usd: usd, pkgs.cyclesx: '0.24.0' }
        )],
        flags = [
        	" -D CMAKE_BUILD_TYPE=RELEASE"
    		" -D GAFFER_ROOT=$GAFFER_TARGET_FOLDER"
    		" -D CMAKE_CXX_COMPILER=$CXX"
    		" -D WITH_CYCLES_DEVICE_CUDA=ON"
    		" -D WITH_CYCLES_CUDA_BINARIES=ON"
    		" -D OPTIX_ROOT_DIR={optixPath}"
    		" -D WITH_CYCLES_DEVICE_OPTIX={withOptix}"
    		" -D WITH_CYCLES_EMBREE=ON"
    		" -D WITH_CYCLES_OPENSUBDIV=ON"
    		" -D WITH_CYCLES_LOGGING=ON"
    		" -D WITH_CYCLES_TEXTURE_CACHE=OFF"
    		" -D WITH_CYCLES_LIGHTGROUPS=ON"
    		" -D WITH_OPENIMAGEDENOISE=ON"
    		" -D WITH_NANOVDB=ON"
    		" -D WITH_CYCLES_SDF=OFF"
    		" -D WITH_CYCLES_CORNER_NORMALS=ON"
            " -D WITH_CYCLES_DEVICE_HIP=ON"
            " -D WITH_CYCLES_HIP_BINARIES=ON"
            " -D WITH_HIP_DYNLOAD=ON"
    		" -D PYTHON_VARIANT={pythonVariant}"
        ],
    )
