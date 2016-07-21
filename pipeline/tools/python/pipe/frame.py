# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================

import pipe
import os,sys, time


def check(frames, returnLog=""):
    error = False

    displays = frames
    if type(frames) == type([]):
        frames.sort( cmp=lambda x,y: -1 if 'beauty' in os.path.basename(x) else cmp( x.lower(), y.lower() ) )
        frames.sort( cmp=lambda x,y: cmp( os.path.basename(x), os.path.basename(y)) )
        # arrange list in a dict, using extension as keys!
        displays = {}
        for each in frames:
            each = each.strip()
            ext = os.path.splitext(each)[-1]
            if not displays.has_key(ext):
                displays[ext] = []
            displays[ext].append(each)

    
    print '='*300
    print 'Checking rendered images...\n'
    if displays:

        openexr = pipe.libs.openexr()
        # we add here a list of commands to execute for each filetype, to check if the file is readable!
        checks={
            '.exr' : '''%s %%s 2>&1 | grep \.exr''' % openexr.path('bin/%s' % filter( lambda x: 'exrheader2.0.0' in x,openexr.bins() )[0][1]),
            '.tif' : '''%s %%s 2>&1 ''' % pipe.libs.tiff().path('bin/tiffinfo'),
        }
        # this is the string list for each filetype to search for errors in the check command result lines
        errors={
            '.exr' : 'Cannot read',
            '.tif' : 'Cannot',
        }

        results = {}
        for filetype in displays:
            if filetype != '.idisplay':
                # check if file exist and its not < 35K
                for d in displays[filetype]:
                    results[d] = True
                    if not os.path.exists( os.path.abspath(d) ):
                        results[d] = False
                        error = True
#                    elif os.stat( d ).st_size <= (32*1024):
#                        results[d] = False
#                        error = True

                # run check
                if not error:
                    # if passed basic check, do a filetype check
                    if filetype in checks.keys():
                        # check which display failed!
                        for d in displays[filetype]:
                            results[d] = True
                            checkCmd = checks[filetype] % os.path.abspath(d)
                            lines = os.popen( checkCmd ).readlines()
#                            print "check log for:",d
#                            for l in lines:
#                                print '\t%s' % l.strip()
                            # check if we have the "errors" string in the result lines of our check
                            # if so, it's error!
                            if errors[filetype] in ''.join(lines):
                                error = True
                                results[d] = False

                print '\n','='*300
                res = ['ERROR', 'OK']
                for d in displays[filetype]:
                    print "% 10s -> %s" % (res[ results[d] ], os.path.abspath(d))
                sys.stdout.flush()
                #time.sleep(15)

    else:
        error = True

    if error:
        print '[ PARSER ERROR ]'
        print "ERROR - No Images rendered!!"

    print '\n','='*300
    return error


def publish(frames, assetPath):
    # using the file path, check if its a valid asset
    import Asset, pipe, filecmp, time, glob
    asset = Asset.AssetParameter(assetPath)
    # if we have asset data, means this maya scene is an asset, so
    # we move the images to its folder
    if asset.isValid():
        print "Publishing images to render asset %s...\n" % asset.path
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
        
        # check all published versions for sequences, and store all the latest ones!
        symlinks = {}
        published_images = {}
        versions = glob.glob( "%s/??.??.??" % str(os.path.dirname(asset.getFilePath().rstrip('/'))) )
        versions.sort()
        for v in versions:
            for each in glob.glob( "%s/images/*" % v):
                symlinks[ os.path.basename(each) ] = each
        
        # if found images on previous versions, symlink the latest ones in the current version
        symlink_images = []
#        if symlinks:
#            # now gather all files in current version!
#            for each in symlinks:
#                symlink_images.append( "%s/%s" % (imagePath, each) )
            
        # mangle images into a list, if a dict
        images = frames
        if type(frames) == type({}):
            images = []
            for ext in frames:
                for each in frames[ext]:
                    images.append(each)

        def getMontageArray(numberOfImages):
            import math
            x=numberOfImages
            y=math.sqrt(x)
            z=int(y)+(1 if y-int(y)>0 else 0)
            zz=int(y+0.475 if (y-int(y))>0.0 else (z))
            #print x,z,zz, z*zz
            return (z,zz)
            

        
        montageImages  = []
        basenames = map(lambda x: os.path.basename(x), images)
        for n in range(0,len(images)):
            basename = basenames[n]
            # if we have images with same file name,
            # create unique names from the difference in folder name
            equals = filter(lambda z: basenames[n] in z, images)
            
            # check if we have images with the same file name in 
            # previous versions as well
            previous_equals = filter(lambda z: basenames[n] in z, symlink_images)
            
            if len(equals) > 1:
                 for t in range(len(equals[0])):
                    if equals[0][t] != equals[1][t]:
                        basename = images[n][t:].replace('/','_').replace(':','_')
                        break
            elif len(previous_equals) > 1:
                # find basename from symlinks based on the first prefix name in the symlink
                for p in previous_equals:
                    prefix = p.split('/')[-1].split(basename)[0].strip('_')
                    if prefix in images[n]:
                        basename = p.split('/')[-1]

            # publish the file!!
            target = "%s%s" % (imagePath, basename)
            published_images[ basename ] = target 
            print "\n@IMAGE!@%s" % target
            print "\n@IMAGE@%s"  % target
            sys.stdout.flush()            
            time.sleep(1)
            sucess=False
            for tries in range(5):
                if tries>1:
                    print "\t\t trying to copy again..."
                    time.sleep(tries*tries)

                sudo = pipe.admin.sudo()
                sudo.rm( target )
                sudo.cp( os.path.abspath(images[n]), target )
                cmd = "convert '%s' -fill white  -undercolor '#00000080'  -gravity South -pointsize 30 -annotate +5+5  '   %s - %sMB   ' " % (os.path.abspath(images[n]), target, str(os.path.getsize(os.path.abspath(images[n]))/1024/1024))
                montageImages.append( "%s/.webplayer/%s" % (imagePath, target.split('jobs/')[1].replace('/','_').replace(':','_').replace('__','_').replace('exr','jpg').replace('EXR','jpg')) )
                cmd += ' "%s"' % montageImages[-1]
                print '\n'+cmd
                sudo.cmd( cmd )
                sudo.run()    
                if os.path.exists( target ):
                    if filecmp.cmp( os.path.abspath(images[n]), target ):
                        sucess=True
                        break



            if not sucess:
                print '[ PARSER ERROR ]'
                raise Exception("SAM Error: Can't publish image since destination folder is unavailable")

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
        sudo = pipe.admin.sudo()
        print '\n\n'+montageCmd + '"%s/.webplayer_montage/montage.%s.jpg"' % (imagePath, basenames[n].split('.')[-2])
        sudo.cmd( montageCmd + '"%s/.webplayer_montage/montage.%s.jpg"' % (imagePath, basenames[n].split('.')[-2]) )
        sudo.run()

        # check if frame was copied suscessfully and remove it from original folder!
        for each in images:
            if os.path.exists( os.path.abspath(each) ):
                if os.path.exists( "%s%s" % (imagePath, os.path.basename(each)) ):
                    if filecmp.cmp( os.path.abspath(each), "%s%s" % (imagePath, os.path.basename(each)) ):
                        # we need to use pipe.admin.system to properly handle
                        # if this will be running in the farm!
                        pipe.admin.system( "rm -f %s" % each )
                    else:
                        Exception( "[ PARSER ERROR ]" )
                    
        # after publish all files, create symlinks for the ones 
        # that did not publish, but exist in previous versions
  #      if symlinks:
  #          sudo = pipe.admin.sudo()
  #          for each in symlinks:    
  #              # compare the symlink basename -9 charactes from the end, so we cut out extension + frame number!
  #              x = filter( lambda x: each[:-9] in x, published_images )
  #              if not x:
  #                  if not os.path.exists( "%s/%s" % (imagePath, os.path.basename(each)) ):
  #                      sudo.ln( symlinks[each], imagePath )
  #          sudo.run()    
                    
        print '\n','='*300




#def webplayerCache(images):
    


def publishLog(log, assetPath, className):
    import Asset, pipe, filecmp
    import tempfile
    asset = Asset.AssetParameter(assetPath)
    # if we have asset data, means this maya scene is an asset, so
    # we move the images to its folder
    if asset.isValid() and os.environ.has_key('FRAME_NUMBER'):
        logPath = "%s/logs/" % asset.getFilePath()

        hostname = ''.join(os.popen('hostname').readlines()).strip()
        (id,file)=tempfile.mkstemp()
        f=open(file,'w')
        f.write( '%s\n' %  ('='*300))
        f.write( 'HOSTNAME: %s\n' %  hostname )
        f.write( '%s\n' %  ('='*300))
        f.write(log)
        f.close()
        os.chmod(file,644)

        logFile = "%s%s_%s.log" % (logPath, className, os.environ['FRAME_NUMBER'])
        print "\nstoring render log at %s" % logFile
        sudo = pipe.admin.sudo()
        sudo.mkdir( logPath )
        sudo.cp( file, logFile )
        sudo.run()
        os.remove(file)
        print '\n','='*300
