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
import os,sys


def check(frames, returnLog=""):
    error = False

    if returnLog:
        if 'ImportError: : No module named' in str(returnLog):
            error = True
    
    displays = frames
    if type(frames) == type([]):
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
                    if not os.path.exists( d ):
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
                            checkCmd = checks[filetype] % d
                            lines = os.popen( checkCmd ).readlines()
#                            print "check log for:",d
#                            for l in lines:
#                                print '\t%s' % l.strip()
                            # check if we have the "errors" string in the result lines of our check
                            # if so, it's error!
                            if errors[filetype] in ''.join(lines):
                                error = True
                                results[d] = False
                                
                # print result for each display
                res = ['ERROR', 'OK']
                for d in displays[filetype]:
                    print "% 10s -> %s" % (res[ results[d] ], d)
    else:
        print "ERROR - No Images rendered!!"
        error = True
            
    print '\n','='*300
    return error
                    
                    
def publish(frames, assetPath):
    # using the file path, check if its a valid asset
    import Asset, pipe, filecmp, time
    asset = Asset.AssetParameter(assetPath)
    # if we have asset data, means this maya scene is an asset, so 
    # we move the images to its folder
    if asset.isValid():
        print "Publishing images to render asset %s...\n" % asset.path
        imagePath = "%s/images/" % asset.getFilePath()
        sudo = pipe.admin.sudo()
        sudo.mkdir( imagePath )
        sudo.run()
        
        # mangle images into a list, if a dict 
        images = frames
        if type(frames) == type({}):
            images = []
            for ext in frames:
                for each in frames[ext]:
                    images.append(each)
        
        basenames = map(lambda x: os.path.basename(x), images)
        for n in range(0,len(images)):
            basename = basenames[n]
            
            # if we have images with same file name, 
            # create unique names from the difference in folder name
            equals = filter(lambda z: basenames[n] in z, images)
            if len(equals) > 1:
                 for t in range(len(equals[0])):
                    if equals[0][t] != equals[1][t]:
                        basename = images[n][t:].replace('/','_')
                        break
                    
            # publish the file!!
            target = "%s%s" % (imagePath, basename)
            print "\t%s" % target
            for tries in range(5):
                if tries>0:
                    print "\t\t trying to copy again..."
                    time.sleep(3)
                    
                sudo = pipe.admin.sudo()
                sudo.cp( images[n], target )
                sudo.run()
                if os.path.exists( target ):
                    if filecmp.cmp( images[n], target ):
                        break
            
        # check if frame was copied suscessfully and remove it from original folder!
        for each in images:
            if os.path.exists( "%s%s" % (imagePath, os.path.basename(each)) ):
                if filecmp.cmp( each, "%s%s" % (imagePath, os.path.basename(each)) ):
                    # we need to use pipe.admin.system to properly handle 
                    # if this will be running in the farm!
                    pipe.admin.system( "rm %s" % each )
        
        print '\n','='*300
        
        
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
    
                    
                    