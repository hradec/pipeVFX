pipeVFX
=======
![Badge](http://192.168.10.52:8080/job/pipeVFX/job/pipeVFX/job/devel/badge/icon?build=last)

A Visual Effects pipeline to manage jobs, shots and software assignment, with a "simple asset manager" called SAM.

To run it, one first need to build it!

To build it, after cloning this depot, just run:

```
    make.sh
```

This will build all libraries needed (multiple versions of the libraries, actually), to support multiple versions of VFX softwares, like Maya, Houdini, Nuke, etc.

It will also build CortexVFX and Gaffer, with different versions for each of the VFX Softwares you have instaled in apps/linux/x86_64/. (Did I mention the thirdy-party softwares go in apps/linux/x86_64/ ?)

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
