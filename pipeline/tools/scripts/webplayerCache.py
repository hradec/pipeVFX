#!/bin/env python2


import os,sys,glob
import pipe
import Asset

def makeJPG(file):
    return os.path.splitext(file.replace('/','_').replace(':','_').replace('__','_'))[0] + '.jpg'


def getMontageArray(numberOfImages):
    import math
    x=numberOfImages
    y=math.sqrt(x)
    z=int(y)+(1 if y-int(y)>0 else 0)
    zz=int(y+0.475 if (y-int(y))>0.0 else (z))
    #print x,z,zz, z*zz
    return (z,zz)
    
            

assetPath = sys.argv[1]

ap = Asset.AssetParameter( assetPath )
assetPath = assetPath.rstrip('/')
imagePath = assetPath
 
# if asset
if ap.isValid():
        imagePath = "%s/images/" % asset.getFilePath()
        sudo = pipe.admin.sudo()
        sudo.mkdir( imagePath )
        sudo.mkdir( "%s/.rules" % imagePath )
        sudo.chmod( "a+rwx", "%s/.rules" % imagePath )
        
        sudo.mkdir( "%s/.webplayer/" % imagePath ) 
        sudo.chown( "http", "%s/.webplayer/" % imagePath )
        sudo.mkdir( "%s/.webplayer.commented/" % imagePath ) 
        sudo.chmod( "a+rwx", "%s/.webplayer.commented/" % imagePath )
         
        sudo.mkdir( "%s/.webplayer_montage/" % imagePath ) 
        sudo.chown( "http", "%s/.webplayer_montage/" % imagePath ) 
        sudo.mkdir( "%s/.webplayer_montage.commented/" % imagePath ) 
        sudo.chmod( "a+rwx", "%s/.webplayer_montage.commented/" % imagePath )
        sudo.run()
    
    
else:
    for d in ['.rules', '.webplayer', '.webplayer_montage', '.webplayer.commented', '.webplayer_montage.commented']:
        os.system( "mkdir -p %s/%s" % (assetPath, d) )
        os.system( "chmod a+rwx %s/%s" % (assetPath, d) )


webplayerPath = "%s/.webplayer/" % assetPath
webplayerMontagePath = "%s/.webplayer_montage/" % imagePath

montageImages = []
images = glob.glob( "%s/*" % assetPath )
images.sort()
for image in images:
    
    cmd = "convert '%s' -fill white  -undercolor '#00000080'  -gravity South -pointsize 30 -annotate +5+5  '   %s - %sMB   ' " % (os.path.abspath(image), image, str(os.path.getsize(os.path.abspath(image))/1024/1024))
    montageImages.append( "%s/.webplayer/%s" % (imagePath, makeJPG( image.split('jobs/')[1] )) )
    cmd += ' "%s"' % montageImages[-1]
    print '\n'+cmd
    #os.system(cmd )


# build pass montage sequence
montage = getMontageArray( len(montageImages) )
if len(montageImages) <= montage[0]*montage[0]:
    montageImages += ['null:'] * (montage[0]*montage[0]-len(montageImages))
    
montageCmd = '''montage %s -tile %sx  -geometry '%sx%s'   -background 'rgb(30,30,30)' ''' % ( 
    ' '.join(montageImages), 
    str(montage[0]),
    str(int(1920/montage[0])),
    str(int(1080/montage[0])),
)
montageCmd += '"%s/.webplayer_montage/montage.%s.jpg"' % (imagePath, basenames[n].split('.')[-2])

print '\n\n'+montageCmd 
#os.system( montageCmd  )
    
    

