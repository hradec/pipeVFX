# this doesnt work yet!!

# <pep8 compliant>
import bpy

def paths():
    # RELEASE SCRIPTS: official scripts distributed in Blender releases
    addon_paths = _bpy.utils.script_paths(subdir="addons")

    # CONTRIB SCRIPTS: good for testing but not official scripts yet
    # if folder addons_contrib/ exists, scripts in there will be loaded too
    addon_paths += _bpy.utils.script_paths(subdir="addons_contrib")

    # EXTRA SCRIPTS
    import os
    if 'BLENDER_SCRIPTS' in os.environ:
        envpaths = os.environ['BLENDER_SCRIPTS'].split(os.pathsep)
        for p in envpaths:
            if os.path.isdir(p):
                addon_paths.append(os.path.normpath(p))

    return addon_paths
