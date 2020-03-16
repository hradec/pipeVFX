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
import tempfile, filecmp

PIPE_DISABLE_THREADS=1
if 'PIPE_DISABLE_THREADS' in os.environ:
    PIPE_DISABLE_THREADS = int(os.environ['PIPE_DISABLE_THREADS'])

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


    print( '='*300 )
    print( 'Checking rendered images...\n' )
    if displays:

        openexr = pipe.libs.openexr()
        # we add here a list of commands to execute for each filetype, to check if the file is readable!
        checks={
            '.exr' : '''%s %%s 2>&1 | grep \.exr''' % openexr.path('bin/%s' % filter( lambda x: 'exrheader' in x,openexr.bins() )[0][1]),
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

                print( '\n','='*300 )
                res = ['ERROR', 'OK']
                for d in displays[filetype]:
                    print( "% 10s -> %s" % (res[ results[d] ], os.path.abspath(d)) )
                sys.stdout.flush()
                #time.sleep(15)

    else:
        error = True

    if error:
        print( '[ PARSER ERROR ]' )
        print( "ERROR - No Images rendered!!" )

    print( '\n','='*300 )
    return error




def publish(frames, assetPath):
    # using the file path, check if its a valid asset
    import Asset, pipe, filecmp, time, glob
    from threading import Thread
    from Queue import Queue
    import multiprocessing

    asset = Asset.AssetParameter(assetPath)
    # if we have asset data, means this maya scene is an asset, so
    # we move the images to its folder
    if asset.isValid():
        print( "Publishing images to render asset %s...\n" % asset.path )
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
        # versions = glob.glob( "%s/??.??.??" % str(os.path.dirname(asset.getFilePath().rstrip('/'))) )
        # versions.sort()
        # for v in versions:
        #     for each in glob.glob( "%s/images/*" % v):
        #         symlinks[ os.path.basename(each) ] = each

        # if found images on previous versions, symlink the latest ones in the current version
        symlink_images = []
        # if symlinks:
        #     # now gather all files in current version!
        #     for each in symlinks:
        #         symlink_images.append( "%s/%s" % (imagePath, each) )

        # mangle images into a list, if a dict
        images = frames
        if type(frames) == type({}):
            images = []
            for ext in frames:
                for each in frames[ext]:
                    images.append(each)

        montageImages  = []
        images.sort()
        for img in  images:
            print( img )
        basenames = map(lambda x: os.path.basename(x), images)

        def __thread01__(n, threads_return):
                basename = basenames[n]
                print( n )
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
                target = "%s%s" % (imagePath, basename.lstrip('_'))
                published_images[ basename ] = target
                print( "\n@IMAGE!@\"%s\"" % target )
                print( "\n@IMAGE@\"%s\""  % target )
                sys.stdout.flush()
                time.sleep(1)
                sucess=False
                fileTemp = tempfile.mktemp()
                for tries in range(5):
                    if tries>1:
                        print( "\t\t trying to copy again..." )
                        time.sleep(tries*tries)

                    # this is were we publish our images.
                    sudo = pipe.admin.sudo()
                    # sudo.rm( target )
                    sudo.cp( os.path.abspath(images[n]), fileTemp )
                    sudo.cp( fileTemp, target )
                    cmd = ""

                    # generate jpg preview images
                    for cmd in webplayer(images[n], '%s/.webplayer' % imagePath, montageImages ):
                        sudo.cmd( cmd )

                    # execute commands as root
                    print( sudo.run() )

                    # check if publish was done suscessfuly
                    if os.path.exists( target ):
                        if filecmp.cmp( os.path.abspath(images[n]), target ):
                            sucess=True
                            break


                sudo = pipe.admin.sudo()
                sudo.rm( fileTemp )
                print( sudo.run() )
                if not sucess:
                    threads_return.put(False)



        threads = []
        threads_return = Queue()

        if PIPE_DISABLE_THREADS:
            # single thread
            for n in range(0,len(images)):
                __thread01__(n, threads_return)
        else:
            # multi threaded
            threadMax=multiprocessing.cpu_count()
            threads = []
            for n in range(0,len(images)):
                threads += [ Thread(target=__thread01__, args=(n,threads_return,)) ]
                threads[-1].start()

                # wait so only maxThreads at a time!!
                while len([ x for x in threads if x.isAlive() ]) >= threadMax:
                    time.sleep(1)


            # wait for threads to finish!
            print( "Waiting threads to finish..." )
            for t in threads:
                t.join()

        # now check if we got a false success, and raise exception if any!
        while not threads_return.empty():
            if not threads_return.get():
                print( '[ PARSER ERROR ]' )
                raise Exception("SAM Error: Can't publish image since destination folder is unavailable")


        # if we have at least one filtered images, use only then for montage!
        onlyFiltered = filter(lambda img: 'filtered' in img, montageImages)
        if onlyFiltered:
            montageImages = onlyFiltered

        montageImages.sort()

        def __threadedSudoCmd__(cmd):
            sudo = pipe.admin.sudo()
            sudo.cmd( cmd )
            print( sudo.run() )

        # run montage commands as root
        if PIPE_DISABLE_THREADS:
            # single thread
            for cmd in webplayerMontage(montageImages, '%s/.webplayer_montage' % imagePath):
                __threadedSudoCmd__(cmd)

            # fix filenames for webplayer
            for cmd in fixFilenamesForWebplayer(montageImages, imagePath):
                __threadedSudoCmd__(cmd)

            # remove montageImages
            for each in montageImages:
                __threadedSudoCmd__("rm -rf %s" % each)
        else:
            #multi thread
            threads = []
            for cmd in webplayerMontage(montageImages, '%s/.webplayer_montage' % imagePath):
                threads += [ Thread(target=__threadedSudoCmd__, args=(cmd,)) ]
                threads[-1].start()

                # wait so only maxThreads at a time!!
                while len([ x for x in threads if x.isAlive() ]) >= threadMax:
                    time.sleep(1)


            # fix filenames for webplayer
            for cmd in fixFilenamesForWebplayer(montageImages, imagePath):
                threads += [ Thread(target=__threadedSudoCmd__, args=(cmd,)) ]
                threads[-1].start()
                # wait so only maxThreads at a time!!
                while len([ x for x in threads if x.isAlive() ]) >= threadMax:
                    time.sleep(1)

            print( "Waiting threads to finish..." )
            for t in threads:
                t.join()

            # remove montageImages after all threads have finished!
            for each in montageImages:
                threads += [ Thread(target=__threadedSudoCmd__, args=("rm -rf %s" % each,)) ]
                threads[-1].start()
                # wait so only maxThreads at a time!!
                while len([ x for x in threads if x.isAlive() ]) >= threadMax:
                    time.sleep(1)

            print( "Waiting threads to finish..." )
            for t in threads:
                t.join()


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
        # if symlinks:
        #     sudo = pipe.admin.sudo()
        #     for each in symlinks:
        #         # compare the symlink basename -9 charactes from the end, so we cut out extension + frame number!
        #         x = filter( lambda x: each[:-9] in x, published_images )
        #         if not x:
        #             if not os.path.exists( "%s/%s" % (imagePath, os.path.basename(each)) ):
        #                 sudo.ln( symlinks[each], imagePath )
        #     sudo.run()


        print( '\n','='*300 )


def publishLog(log, assetPath, className):
    import Asset
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
        print( "\nstoring render log at %s" % logFile )
        sudo = pipe.admin.sudo()
        sudo.mkdir( logPath )
        sudo.cp( file, logFile )
        sudo.run()
        os.remove(file)
        print( '\n','='*300 )

        # store pixar statisc job file
        # if 'Pixar PhotoRealistic RenderMan' in log:
        #     imagePath = [ l for l in log.split('\n') if 'renderman/' in l and '(mode =' in l ]
        #     if imagePath:
        #         logXML = os.path.abspath( os.path.dirname( os.path.dirname( imagePath[0] ) ) )




def webplayer(img, toFolder='.', montage=[]):
    ''' generate jpg preview images '''
    import tempfile
    cmd = []
    fileTemp = os.path.abspath( img )
    hasLayers = False

    # if EXR, look if it has layers. If so, use exr2tif to fix RGB layer for jpg preview
    if '.exr' in os.path.abspath(img).lower():
        if not len( os.popen("exrheader '%s' | egrep 'R,|G,|B,' | grep sampling" % fileTemp).readlines() ):
            hasLayers = True
    if hasLayers:
        # if not RGB layer, we convert to tiff to get exr channels as RGB channels, so convert works properly on diffuse/specular/etc
        ret = -1
        count = 0
        # fileTemp = "/tmp/PIPE_TMP_%s.tif" % (
        #     os.path.abspath( img ).split('jobs/')[1].replace('/','_').replace(':','_').replace('__','_')
        # )
        fileTemp = tempfile.mktemp('.tif')

        while ret < 0 :
            ret = os.system("exr2tif.py '%s' '%s' " %  ( os.path.abspath( img ), fileTemp ) )
            count += 1
            if count > 10:
                # raise Exception("[ PARSER ERROR ]\n\nIOError: \n\n")
                break

        # if our conversion failed, revert to the original exr
        if not os.path.exists( fileTemp ):
            fileTemp = img

    # generate jpeg preview for our rendered images
    # we use imagemagick convert - this is the conver line
    cmd.append(
        "convert '%s' -fill white  -undercolor '#00000080'  -gravity South -pointsize 30 -annotate +5+5  '   %s - %sMB   ' " % (
            fileTemp,
            os.path.basename(img),
            str(os.path.getsize(os.path.abspath( img ))/1024/1024)
        )
    )

    # images to use in the montage image
    samImage = "%s/%s" % (
        toFolder,
        os.path.abspath( img ).split('jobs/')[1].replace('/','_').replace(':','_').replace('__','_').replace('exr','jpg').replace('EXR','jpg')
    )
    # tmpImage = "/tmp/PIPE_TMP_%s" % (
    #     os.path.abspath( img ).split('jobs/')[1].replace('/','_').replace(':','_').replace('__','_').replace('exr','jpg').replace('EXR','jpg')
    # )
    tmpImage = tempfile.mktemp('.%s.jpg' % img.split('.')[-2], os.path.basename(img)+'.'  )


    # only use filtered images for montage!
    montage.append( tmpImage )

    cmd[-1] += ' "%s" && cp -rfv "%s" "%s"' % (tmpImage, tmpImage, samImage)

    # remove fileTemp if it's the converted (RGB fixed) TIF image
    if hasLayers:
        cmd.append( "rm -rf %s" % fileTemp )
        if 'filtered' not in img:
            cmd.append( "rm -rf %s" % tmpImage )

    return cmd


# build pass montage sequence
def webplayerMontage(_montageImages, toFolder='.'):
    ''' generate a 1080p montage of a bunch of images '''


    # use filtered images ONLY for montage, if any!
    montageImages = [n.strip() for n in _montageImages if 'filtered' in n or not [m for m in _montageImages if os.path.splitext(os.path.splitext(n)[0])[0]+'_filtered' in m or '_variance' in n] ]

    if len(montageImages)<1:
        montageImages = _montageImages

    if len(montageImages)<1:
        return []

    cmd=[]
    def getMontageArray(numberOfImages):
        import math
        sqrt = math.sqrt(numberOfImages)
        print( "sqrt:", sqrt )
        x=int(sqrt)
        y=x
        # if we have a non-integer sqrt(), we have to add empty spaces!
        if sqrt-x > 0.0:
            x += 1
            y = int(sqrt+0.475)
        if x < 1:
            x=1
            y=1
        return (x,y)

    nonDuplicated = {}
    for each in montageImages:
        if each.strip():
            nonDuplicated[each.strip()] = 1
    montageImages = nonDuplicated.keys()
    montageImages.sort()
    montage = getMontageArray( len(montageImages) )
    if len(montageImages) <= montage[0]*montage[0]:
        montageImages += ['null:'] * (montage[0]*montage[0]-len(montageImages))

    # imagemagick montage command
    montageCmd = '''montage %s -tile %sx  -geometry '%sx%s'   -background 'rgb(30,30,30)' ''' % (
        ' '.join(montageImages),
        str(montage[0]),
        str(int(1920/montage[0])),
        str(int(1080/montage[0])),
    )
    frame = os.path.basename(montageImages[0]).split('.')[-2]
    cmd.append( montageCmd + '"%s/montage.%s.jpg"' % (toFolder, frame) )
    # for each in montageImages:
    #     cmd.append( "rm -rf %s" % each )
    return cmd


def fixFilenamesForWebplayer(montageImages, imagePath):
    cmd=[]
    for image in montageImages:
        if '_images_' in image:
            prefix = imagePath.split('jobs/')[-1].replace('/','_').replace(':','_')
            webPlayer_image = '%s/.webplayer/%s' % (imagePath, "%s_%s" % (prefix, image.split('_images_')[-1]))
            webPlayer_image = webPlayer_image.replace('__','_')
            cmd += [ "rm -rf %s" % webPlayer_image ]
            cmd += [ "ln -s %s %s" % (image, webPlayer_image) ]
    return cmd
