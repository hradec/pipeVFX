

import sys
import maya.OpenMaya as OpenMaya
import maya.OpenMayaMPx as OpenMayaMPx

# make sure your node id is unique
# change node type name to desired name

nodes = [
    "sam_model_alembic",
    "sam_animation_alembic",
    "sam_model_maya",
    "sam_animation_maya",
    "sam_lighting_maya",
    "sam_camera_alembic",
    "sam_shaders_maya",
]
start_node_id = 0x8700
kTransformMatrixID = 0x87015
# node_type = OpenMayaMPx.MPxObjectSet
node_type = OpenMayaMPx.MPxTransform

# node definition
class custom_node(node_type):
    def __init__(self):
        # if node_type == OpenMayaMPx.MPxObjectSet:
        #     OpenMayaMPx.MPxObjectSet.__init__(self)
        # elif node_type == OpenMayaMPx.MPxTransform:
            OpenMayaMPx.MPxTransform.__init__(self)


# creator
def creator():
    return OpenMayaMPx.asMPxPtr( custom_node() )

# initializer
def initializer():
    pass

# initialize the script plug-in
def initializePlugin(mobject):
    mplugin = OpenMayaMPx.MFnPlugin (mobject,"AtomoVFX","1.0")
    matrix = OpenMayaMPx.MPxTransformationMatrix

    try:
        nid=0
        for n in nodes:
            node_id = OpenMaya.MTypeId(start_node_id+nid)
            # if node_type==OpenMayaMPx.MPxObjectSet:
            #     mplugin.registerNode(n,node_id,creator,initializer, OpenMayaMPx.MPxNode.kObjectSet)
            # elif node_type==OpenMayaMPx.MPxTransform:
            mplugin.registerTransform(n,node_id,creator,initializer,matrix, OpenMaya.MTypeId(kTransformMatrixID))
            nid += 1
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeTypeName)
        raise

# uninitialize the script plug-in
def uninitializePlugin(mobject):
    mplugin = OpenMayaMPx.MFnPlugin(mobject)
    try:
        nid=0
        for n in nodes:
            node_id = OpenMaya.MTypeId(start_node_id+nid)
            mplugin.deregisterNode( node_id )
            nid += 1
    except:
        sys.stderr.write( "Failed to register node: %s" % kPluginNodeTypeName)
        raise
