#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import hou
import pipe
import pickle
import subprocess

def houdini_one():

    values_node_frames = []            
    for each in hou.node('/out').children():
        values_node_frames.append(
            [each.name(), 
            str(int(hou.parm('/out/'+ each.name() +'/f1').eval())),
            str(int(hou.parm('/out/'+ each.name() +'/f2').eval()))]
                           )

    nodes       = [i[0] for i in values_node_frames]
    frame_start = [i[1] for i in values_node_frames]    
    frame_end   = [i[2] for i in values_node_frames]

    filename = os.path.abspath(hou.hipFile.name())

    settings    = {
                   "output":      nodes,
                   "frame_start": frame_start[0],
                   "frame_end":   frame_end[0],
                   "hipfile":     filename
                   }  

    save = pickle.dump(
              settings,open('%s/%s/shots/%s/users/%s/houdini/.publish_data' % 
                (pipe.roots.jobs(),os.environ['PIPE_JOB'],os.environ['PIPE_SHOT'].split('@')[1],os.environ['USER']),'w'))
    subprocess.Popen("run opa publish -arguments -Asset.type render\/houdini 1 IECORE_ASSET_OP_PATHS",shell=True)
    return settings

nodeNode = hou.node('/out').children()
if nodeNode:
    houdini_one()
else:
    print 'Not complete'
