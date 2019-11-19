pipeVFX
=======
![Build Status](http://jenkins.hradec.com:62346/buildStatus/icon?job=pipeVFX%2FpipeVFX%2Fdevel)

A Visual Effects pipeline to manage jobs, shots and software assignment, with a "simple asset manager" called SAM.

PipeVFX is compliant with [VFX Platform](https://vfxplatform.com/), and the goal is to fully build all packages from CY2014 to CY2020. (and future ones as they become available.)

Bellow you can see the VFX Platform table, and crosshatched are the versions not yet built by PipeVFX:

|           |   CY2020  |   CY2019  |   CY2018  |   CY2017  |   CY2016  |   CY2015  |   CY2014  |
| :----     | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: |
| gcc       | ~~6.3.1~~ | ~~6.3.1~~ | ~~6.3.1~~ | 4.8.2/3   | 4.8.2/3   | 4.8.2	    | 4.1.2     |
| glibc     | ~~2.17~~  | ~~2.17~~  | ~~2.17~~  | ~~2.12~~  | ~~2.12~~  | ~~2.12~~  |           |
| Python    | 3.7.x     | 2.7.latst | 2.7.latst | 2.7.latst | 2.7.latst | 2.7.x	    | ~~2.7.3~~ |
| Qt        | ~~5.12.x~~| ~~5.12.x~~| 5.6.1(adk)| 5.6.1(adk)| 5.6.1(adk)| 4.8.x     | ~~4.8.5~~ |
| PyQt	    | ~~5.12~~  | ~~5.12~~  | ~~5.6~~   | ~~5.6~~   | ~~5.6~~ 	|           |           |
| PySide	| ~~5.12 brnch~~| ~~5.12 brnch~~| 2.0.x(adk)| 2.0.x(adk)| 2.0(adk)  | ~~1.2.x~~ | ~~1.2~~   |
| NumPy     | 1.17.x	| 1.14.x	| 1.12.1	| 1.9.2	    | 1.9.2	 	|           |           |
| OpenEXR	| ~~2.4.x~~ | ~~2.3.x~~ | 2.2.x     | 2.2.x     | 2.2.x     | 2.2.x     | 2.0.1     |
| Ptex      | 2.3.2     | 2.1.33	| 2.1.28	| 2.1.28	| 2.0.42	|           |           |
| OpenSubdiv| 3.4.x     | 3.3.x     | 3.3.x     | 3.1.x     | 3.0.x     | 2.5.x     | 2.3.3     |
| OpenVDB   | ~~7.x~~   | 6.x       | 5.x       | 4.x       | 3.x       | 3.0.x	    |           |
| Alembic	| 1.7.x     | 1.7.x     | 1.7.x     | 1.6.x     | 1.5.8     | 1.5.x     | 1.5.x     |
| FBX       | ~~2020.x~~| ~~2019.x~~| ~~2018.x~~|~~latest~~ | ~~latest~~| ~~latest~~| ~~2015~~  |
|OpenColorIO| 1.1.x     | 1.1.0     | 1.0.9     | 1.0.9     | 1.0.9     | 1.0.9     | ~~1.0.7~~ |
| ACES      | ~~1.1~~   | ~~1.1~~ |~~1.0.latst~~| ~~1.0.x~~ | ~~1.0~~ 	|           |           |
| Boost     | 1.70      | 1.66      | 1.61      | 1.61      | 1.55      | 1.55      | 1.53      |
| Intel TBB | 2019 U6   | 2018      | 2017 U6   | 4.4       | 4.3       | 4.2       | 4.1       |
| Intel MKL	| ~~2019~~  | ~~2018~~  | ~~2017U2~~| ~~11.3~~  | ~~11.3~~  |           |           |	 	 
| C++API/SDK| C++14     | C++14     | C++14     | C++11     | C++11	 	|           |           |

PipeVFX will also build plugins for different VFX applications, like Maya, Houdini, Renderman, etc; as long as they are installed in the /atomo/apps/linux/x86_64/<apps>/<versions>/
folder structure. PipeVFX build will gather all applications and versions from /atomo/apps, and build plugins from packages like USD, OpenSubdiv, Alembic, etc.

ex: If Maya 2016 and 2018 are installed in /atomo/apps/linux/x86_64/maya/2016.5 and /atomo/apps/linux/x86_64/maya/2018, PipeVFX will build the USD plugin for then, one for each CY version of opensubdiv. Later on, PipeVFX can be configured to run a Maya version with a specific version of USD, depending of a job or even a shot. Being set, when Maya runs, PipeVFX will run the Maya version set and the USD plugin of the selected USD version will show up in the plugin manager. This configuration is stored in the job/shot structure, so it will be consistent as long as it's not changed. Even after restoring a job from backup, maya will still run at the version set in the job/shot when it started, toguether with the version of USD plugin, so a job will continue to work, even after years of being finished.

PipeVFX tries to use the lowest version of GCC possible to build packages, so to increase the libstdc++/glibc compatibility with thirdy party software versions.
This way PipeVFX doens't need to have every single package built with different versions of GCC.
Most packages are built with gcc 4.1.2 (CY2014), only going up to 4.8.5 when absolutely necessary (we have choosen to use 4.8.5 instead of 4.8.3 since we had some issues building 4.8.3 with centos7 default 4.8.5 gcc).
So far, we haven't built gcc 6.3.1 yet since we didn't find a package that couldn't be built with 4.1.2 or 4.8.5.

Python 2.7.x is built with gcc 4.1.2, where 3.7.x is built with 4.8.5.
All boost versions are build against booth python 2.7.x and 3.7.x, from 1.51.0 to 1.70.0.
For Python 2.7.x boost builds, we use gcc 4.1.2 up to version 1.66.0, and 4.8.5 only for version 1.70.0 since it won't build with 4.1.2.
For Python 3.7.x boost builds, we use gcc 4.8.5 for all versions, since python 3.7.x was built with it.

Everytime a package is built against booth python 2.7.x and 3.7.x, PipeVFX will try to use the gcc version used for the python version.
So, for all builds against python 2.7.x, gcc 4.1.2 will be used, as long as the package can be build with it.

PipeVFX also builds other packages, not included in the VFX Platform specifications, to decrease the number of dependencies with linux distribution packages. Things like libjpeg, libtiff, libraw, libpng, openssl, llvm, MaterialX, hdf5, libz, bzip2, etc; are all available from PipeVFX, and don't require the linux host distro to have then installed.


Build
=====

On any linux distro with docker installed and running, just run:
```
    ./make.sh
```
And it will build everything in a Centos 7 docker container.
It will also build CortexVFX and Gaffer, with different versions for each of the VFX Softwares you have instaled in /atomo/apps/linux/x86_64/.


Run
===
So, after a suscessfull build, you can run PipeVFX by running:

```
    make.sh -s
```

After running that command, you are inside CentOS 7, properly configured and running inside PipeVFX.

You can see the current software versions by typing `version` and the current versions of libraries by typing `version -l`.

You can create a new job using `opa mkjob`!

And then, you can start working on the job, by typing `go <job number.jobname> shot <shot name>` or `go <job number.jobname> asset <asset name>` to work on something that will be used by all shots.

After that, if you have maya installed in apps/linux, just type `maya`, and it will open Maya. And you'll see it will load cortexVFX in maya, and will show the S.A.M. window docked inside maya!

Or you can type `gaffer` to launch gaffer!

To edit a job, run `browser`.



Installing in your own storage/environment
==========================================

After being built, everything needed to run PipeVFX will be available for you inside the pipeline folder structure.
All libraries will be inside pipeline/libs/linux/x86_64/gcc-multi/.

The simplest way to install PipeVFX in your own environment/storage, is to create a shared storaged mounted as /atomo on all machines.

Inside that /atomo, one will copy the pipeline folder, ending up with /atomo/pipeline.
Don't forget to create your /atomo/apps to store your applications. (the PipeVFX apps folder has a few examples for applications)

After that, just add:

```
source /atomo/pipeline/tools/init/bash
```

to /etc/bashrc and all users in linux will be inside PipeVFX as soon as they open a shell in linux. From there, just type "go job shot shotname" and start working.

PipeVFX should run perfectly in Centos 7. But it can run in other distributions as well, with a few adjustments.


There's also the possibility of run PipeVFX from inside docker containers, using x11docker. This method has the advantage of run Centos 7 inside any distribution, and should run without any adjustment in your distro.
