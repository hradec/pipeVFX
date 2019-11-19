pipeVFX
=======
![Build Status](http://jenkins.hradec.com:62346/buildStatus/icon?job=pipeVFX%2FpipeVFX%2Fdevel)

A Visual Effects pipeline to manage jobs, shots and software assignment, with a "simple asset manager" called SAM.

PipeVFX is compliant with [VFX Platform](https://vfxplatform.com/), and it builds all CYs from  CY2016 to CY2018, and some packages also CY2014/2015 and CY2019/2020.

The only packages from VFX Platform not built by PipeVFX yet are glibc, FBX, ACES and Intel MKL. All others are fully supported from CY2016 to CY2018.

The goal is to fully build all packages in the VFX Platform, from CY2014 to CY2020. (and future ones as they become available.)

Bellow you can see the VFX Platform table, and crosshatched are the versions not build by PipeVFX yet:

|           |   CY2020  |   CY2019  |   CY2018  |   CY2017  |   CY2016  |   CY2015  |   CY2014  |
| :----     | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: |
| gcc       | ~~6.3.1~~ | ~~6.3.1~~ | ~~6.3.1~~ | 4.8.2/3   | 4.8.2/3   | 4.8.2	    | 4.1.2     |
| glibc     | ~~2.17~~  | ~~2.17~~  | ~~2.17~~  | ~~2.12~~  | ~~2.12~~  | ~~2.12~~  |           |
| Python    | 3.7.x     | 2.7.latst | 2.7.latst | 2.7.latst | 2.7.latst | 2.7.x	    | ~~2.7.3~~ |
| Qt        | 5.12.x    | 5.12.x	| 5.6.1(adk)| 5.6.1(adk)| 5.6.1(adk)| 4.8.x     | ~~4.8.5~~ |
| PyQt	    | ~~5.12~~  | ~~5.12~~  | ~~5.6~~   | ~~5.6~~   | ~~5.6~~ 	|           |           |
| PySide	| 5.12 brnch| 5.12 brnch| 2.0.x     | 2.0.x     | 2.0       | ~~1.2.x~~ | ~~1.2~~   |
| NumPy     | 1.17.x	| 1.14.x	| 1.12.1	| 1.9.2	    | 1.9.2	 	|           |           |
| OpenEXR	| ~~2.4.x~~ | ~~2.3.x~~ | 2.2.x     | 2.2.x     | 2.2.x     | 2.2.x     | 2.0.1     |
| Ptex      | 2.3.2     | 2.1.33	| 2.1.28	| 2.1.28	| 2.0.42	|           |           |
| OpenSubdiv| 3.4.x     | 3.3.x     | 3.3.x     | 3.1.x     | 3.0.x     | 2.5.x     | 2.3.3     |
| OpenVDB   | ~~7.x~~   | 6.x       | 5.x       | 4.x       | 3.x       | 3.0.x	    |           |
| Alembic	| 1.7.x     | 1.7.x     | 1.7.x     | 1.6.x     | 1.5.8     | 1.5.x     | 1.5.x     |
| FBX       | ~~2020.x~~| ~~2019.x~~| ~~2018.x~~|~~latest~~ | ~~latest~~| ~~latest~~| ~~2015~~  |
| OpenColrIO| 1.1.x     | 1.1.0     | 1.0.9     | 1.0.9     | 1.0.9     | 1.0.9     | ~~1.0.7~~ |
| ACES      | ~~1.1~~   | ~~1.1~~ |~~1.0.latst~~| ~~1.0.x~~ | ~~1.0~~ 	|           |           |
| Boost     | ~~1.70~~  | ~~1.66~~  | ~~1.61~~  | ~~1.61~~  | 1.55      | 1.55      | 1.53      |
| Intel TBB | 2019 U6   | 2018      | 2017 U6   | 4.4       | 4.3       | 4.2       | 4.1       |
| Intel MKL	| ~~2019~~  | ~~2018~~  | ~~2017U2~~| ~~11.3~~  | ~~11.3~~  |           |           |	 	 
| C++API/SDK| C++14     | C++14     | C++14     | C++11     | C++11	 	|           |           |

PipeVFX will also build plugins for different VFX applications, like Maya, Houdini, Renderman, etc; as long as they are installed in the /atomo/apps/linux/x86_64/<apps>/<versions>
folder structure. PipeVFX build will gather all applications and versions from /atomo/apps, and build plugins from packages like USD, OpenSubdiv, Alembic, etc.
ex: If Maya 2016 and 2018 are installed, PipeVFX will build the USD plugin for booth maya versions, from all opensubdiv CY versions!



Build
=====

On any linux distro with docker installed and running, just run:
```
    make.sh
```

and it will build all libraries needed (multiple versions of the libraries, actually), to support multiple versions of most common VFX softwares like Maya, Houdini, Nuke, etc.

It will also build CortexVFX and Gaffer, with different versions for each of the VFX Softwares you have instaled in apps/linux/x86_64/. (Did I mention the thirdy-party softwares go in apps/linux/x86_64/ ?)


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
