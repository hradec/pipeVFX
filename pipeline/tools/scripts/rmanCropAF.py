#! /usr/bin/env ppython
# -*- coding: utf-8 -*-

import subprocess
import os
import sys
import pipe




cluster_size = 10
tiles = {}
local = False
# Calculate tile positions based on resolution and size input
def stripes(res_x,res_y,tile_x_res):
	coords = [0,0,tile_x_res,res_y-1]
	for i,each in enumerate( range(res_x/tile_x_res-1) ):
		coords[0] = coords[0]+tile_x_res
		coords[2] = coords[2]+tile_x_res
		if coords[2] > res_x-1:
			coords[2]  = coords[2]-1
		# print coords[0], coords[1], coords[2], coords[3]
		tiles[0] = 0,0,tile_x_res,res_y-1
		tiles[i+1] = coords[0],coords[1],coords[2],coords[3]
	return tiles

def main(resx, resy, output_path, scene_file, frame):
    cmds=[]
    imgs=[]
    if int(resx) % cluster_size != 0:
        import sys; sys.tracebacklimit=0
        raise TypeError('Invalid resolution specified')
    stripes(int(resx), int(resy), int(resx) / cluster_size )
    # stripes(2048,2300,256)
#    rvdriver_libs = os.environ['LD_LIBRARY_PATH'] = '/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/python/2.6.8/lib:/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/boost/1.46.1/lib'
    for index,region in tiles.iteritems():
        img_name = '/%s_%s.exr' % (os.path.splitext(os.path.basename(scene_file))[0],index)
        output = output_path + img_name
        region = str(region).replace('(','').replace(')','').replace(',','')
        qubecmd = '/atomo/apps/linux/x86_64/qube/current/qube-core/local/pfx/qube/bin/qbsub --user %s --name "[ HD ] Arnold Tile Render: %s %s/%s" --cpus 1 --reservations host.processors=1+ ' % (os.environ['USER'],scene_file.split('/')[-1],index,len(tiles))

#        kick_cmd = 'export LD_LIBRARY_PATH=%s ; /atomo/pipeline/tools/scripts/run kick -i "%s" -v 6 -l /atomo/apps/linux/x86_64/arnold/1.4.2.4.1/mtoadeploy/2014/shaders/ -as 5 -bc top -bs 48 -v 3 -dp -dw -rg %s -r %s %s -o  "%s" -nstdin   ' % (rvdriver_libs, scene_file, region,str(resx), str(resy), output)

        kick_cmd = ' '.join([
            'run Render -r rman -ris -s %s -e %s -crop %s' % (frame, frame, region),
            '-proj %s' % os.path.dirname(os.path.dirname(scene_file)),
            '-im %s' % img_name,
            scene_file
        ])
        cmds.append(kick_cmd)
        imgs.append(output)
        
    return (cmds,imgs)




if len(sys.argv)<2:
    print '''
    
    rmanCropAF - submit one frame to render in multiple machines on the farm (arnold ass file)
    
    
        example: rmanCropAF  <path to ma/mb file> <frame> <resolution X> <resolution Y>  <number of tiles>
        
        
    '''
else:

    path_f = os.path.abspath(sys.argv[1]) #'/mnt/Render/Render/lg_concorrencia/file_maya/v2/render_cozinha_sala_DAN_v001_frame_cozinha.ass'
    #path = os.path.abspath(sys.argv[2]) # '/mnt/Render/Render/lg_concorrencia/files_render_v2'
    path = os.path.dirname(path_f) # '/mnt/Render/Render/lg_concorrencia/files_render_v2'
    
    res_x = 4100
    res_y = 2306
    frame=1
    if len(sys.argv)>=3:
        res_x = sys.argv[2]
    if len(sys.argv)>=4:
        res_x = sys.argv[3]
    if len(sys.argv)>=5:
        res_y = sys.argv[4]
    if len(sys.argv)>=6:
        cluster_size = int(sys.argv[5])

    if not os.path.exists(path_f):
        raise Exception( "file %s doesn't exist!" % path_f )

    if not os.path.exists(path):
        os.mkdir(path)


    cmds, files = main(res_x, res_y, path, path_f, frame )
    
    # comp frames at the end!
    postCmd = {
        "name" : "stich tiles",
        "cmd"  : "convert "+" -page +0+0 ".join(files)+" -flatten %s/%s.exr" % (path, os.path.basename(os.path.splitext(path_f)[0])) + " && rm -rf "+" && rm -rf ".join(files),
    }
    
    
    #print cmds[-1]
    print pipe.farm.cmds("kickCropAF: " + os.path.basename(path_f),cmds, files,postCmd).submit()



