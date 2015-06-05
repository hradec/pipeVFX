pipeVFX
=======

A Visual Effects pipeline to manage jobs, shots and software assignment, with a "simple asset manager" called SAM.

It comes with wrappers for the most common 3D and 2D softwares and renderers in the VFX market, with integrated version control, user folder management, proper file permissions setting, etc.

Its extensively integrated with CortexVFX and Gaffer, setting up the environment correctly to run ops, gaffer apps, etc.

SAM (the "simple asset manager") uses CortexVFX and Gaffer for it's UI, and its capable of publish CortexVFX assets, as well as Alembic, Maya, Nuke, Texture, Image Sequence, etc; all versioned and properly tracked.

SAM is also integrated with pipeVFX's renderfarm frontend, so publishing can trigger renderfarm actions. For example, when publishing Maya render assets, SAM sends a Maya scene to the farm, and publishes back the rendered frames into the render asset.

If you want to give it a try, simply fork and clone pipeVFX and run in a bash shell:

```
#!bash


   . pipeline/tools/init/bash

```

after that, your shell will be running inside pipeVFX!