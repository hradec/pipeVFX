#! /usr/bin/python2
# -*- coding: utf-8 -*-


import os
import sys
import pipe




cluster_size = 10

local = False

crop = 'setAttr rmanFinalGlobals.rman__riopt___CropWindowX0 %s;setAttr rmanFinalGlobals.rman__riopt___CropWindowX1 %s;setAttr rmanFinalGlobals.rman__riopt___CropWindowY0 %s;setAttr rmanFinalGlobals.rman__riopt___CropWindowY1 %s;'
res  = 'setAttr defaultResolution.width %s;setAttr defaultResolution.height %s;'
image= 'setAttr defaultRenderGlobals.imageFormat 40;setAttr defaultRenderGlobals.animation 0;setAttr -type "string" defaultRenderGlobals.imageFilePrefix "%s";'

j = os.environ['PIPE_JOB']
s = os.environ['PIPE_SHOT'].replace('@',' ')
go= 'source /atomo/pipeline/tools/scripts/go %s %s ;' % (j,s)


# Calculate tile positions based on resolution and size input
def stripes(res_x,res_y,tile_x_res):
	tiles = {}
	coords = [0,0,tile_x_res,res_y]
	for i,each in enumerate( range(res_x/tile_x_res-1) ):
		coords[0] = coords[0]+tile_x_res
		coords[2] = coords[2]+tile_x_res
		if coords[2] > res_x:
			coords[2]  = coords[2]
		# print coords[0], coords[1], coords[2], coords[3]
		tiles[0] = 0,0,tile_x_res,res_y
		tiles[i+1] = coords[0],coords[1],coords[2],coords[3]
	return tiles

def main(resx, resy, output_path, scene_file, frame):
	cmds=[]
	imgs=[]
	if int(resx) % cluster_size != 0:
	    import sys; sys.tracebacklimit=0
	    raise TypeError('Invalid resolution specified')

	tiles = stripes(int(resx), int(resy), int(resx) / cluster_size )


	for index,region in tiles.iteritems():
		img_name = '/%s_%s' % (os.path.splitext(os.path.basename(scene_file))[0],index)
		output = output_path + img_name

		c = crop % (str(float(region[0])/float(resx)),str(float(region[2])/float(resx)),str(float(region[1])/float(resy)),str(float(region[3])/float(resy)),)
		r = res % (resx, resy)
		i = image.replace('"','\\\\\\"',) % output

		kick_cmd = go+'/atomo/pipeline/tools/scripts/run Render -s %s -e %s  -r rman -ris -preRender "%s" "%s"' % (frame,frame,c+r+i, scene_file)
		# kick_cmd = go+'/atomo/pipeline/tools/scripts/run Render --help'

		# print kick_cmd
		cmds.append(kick_cmd)
		imgs.append(output)

	return (cmds,imgs)




if len(sys.argv)<2:
	print '''

	prmanCropAF - submit one frame to render in multiple machines on the farm (maya prman file)


	    example: prmanCropAF  <path to mb/ma file> <frame> <resolution X> <resolution Y>  <number of tiles>


	'''
else:

	path_f = os.path.abspath(sys.argv[1]) #'/mnt/Render/Render/lg_concorrencia/file_maya/v2/render_cozinha_sala_DAN_v001_frame_cozinha.ass'
	#path = os.path.abspath(sys.argv[2]) # '/mnt/Render/Render/lg_concorrencia/files_render_v2'
	path = os.path.dirname(path_f) # '/mnt/Render/Render/lg_concorrencia/files_render_v2'

	res_x = 4100
	res_y = 2306

	frame = sys.argv[2]

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
	    "cmd"  : "/usr/sbin/runuser -l rhradec --session-command  '"+go+" convert "+" -page +0+0 ".join(map(lambda x: x+'.exr',files)) +
				 " -flatten %s/%s.exr" % (path, os.path.basename(os.path.splitext(path_f)[0])) +
				 " && rm -rf "+" && rm -rf ".join(map(lambda x: x+'.exr',files)) + "'",
	}

	os.environ['LD_LIBRARY_PATH'] = ""
	#print cmds[-1]
	print pipe.farm.cmds("prmanCropAF: " + os.path.basename(path_f),cmds, files,postCmd).submit()
