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



class delight(baseApp):
    def environ(self):
        # configure maya plugin/scripts/icons
        maya.addon ( self,
            plugin = self.path('maya/$MAYA_VERSION/plug-ins'),
            script = self.path('maya/$MAYA_VERSION/scripts'),
            icon   = [
                self.path('maya/$MAYA_VERSION/icons'),
                self.path('maya/icons'),
            ]
        )
        
        self['DL_SEARCHPATH_DEBUG'] = '1'
#        self['DL_DUMP_DEFAULTS'] = '0'

        #add tools paths
        for each in self.toolsPaths():  
            self['DL_SHADERS_PATH']     = '%s/shaders/delight/%s' % ( each, self.version() )
            self['DL_SHADERS_PATH']     = '%s/shaders/delight' % each
            self['_3DFM_SL_INCLUDE_PATH']  = '%s/shaders/delight/maya_rsl/%s' % ( each, self.version() )
            self['_3DFM_SL_INCLUDE_PATH']  = '%s/shaders/delight/maya_rsl' % each
            self['DL_TEXTURES_PATH']    = '%s/textures' % each
            
        self['DL_SHADERS_PATH']     = self.path('shaders')
        self['DL_TEXTURES_PATH']    = self.path('examples/textures')
        self['DL_DISPLAYS_PATH']    = self.path('displays')
        self['_3DFM_SL_INCLUDE_PATH']  =  self.path('maya/rsl')
        

        if self.inFarm():
            self['_3DFM_SHADERS_PATH']      = "%s/delight/" % self['HOME']
            self['_3DFM_SHADOWMAPS_PATH']   = "%s/delight/" % self['HOME']
            self['_3DFM_TEXTURES_PATH']     = "%s/delight/" % self['HOME']
        
        
        
#        self["_3DFM_USE_DEPRECATED_SHADING"]=
#        self["_3DFM_DONT_USE_TRANSMISSION_SUBSET"]=
#        self["_3DFM_NO_DEFAULT_RT_VISIBILITY"]=

        # if we're in a job/shot
#        job = pipe.admin.job.current()
#        if job:
#            # create standard delight user folder!
#            baseApp.userSetup(self)
#            # now make 3DFM use our own 3delight user folder instead of maya one!
#            self["_3DFM_OUTPUT_PATH"]       = job.shot.user().path('delight')
#            self["_3DFM_FLUIDS_PATH"]       = job.shot.user().path('delight')
#            self["_3DFM_FURFILES_PATH"]     = job.shot.user().path('delight')
#            self["_3DFM_PHOTON_MAPS_PATH"]  = job.shot.user().path('delight')
#            self["_3DFM_POINTCLOUDS_PATH"]  = job.shot.user().path('delight')
#            self["_3DFM_RIBFRAGMENTS_PATH"] = job.shot.user().path('delight')
#            self["_3DFM_SHADERS_PATH"]      = job.shot.user().path('delight')
#            self["_3DFM_SHADOWMAPS_PATH"]   = job.shot.user().path('delight')
#            self["_3DFM_TEMPLATES_PATH"]    = job.shot.user().path('delight')
#            self["_3DFM_TEXTURES_PATH"]     = job.shot.user().path('delight')

        self['RMANTREE'] = self.path()
        self['DELIGHT'] = self.path()
        self['FRAMEBUFFER'] = 'i-display'

        self.update( python() )
        self.update( cortex() )
        self.update( gaffer() )
        self.update( slum() )
    
    def versions(self):
        ''' set wine version in case we want to run 3delight windows in linux'''
        pipe.version.set( wine = '1.5.29.win64' )
    
    @staticmethod
    def addon( caller, shader='', procedurals='', script='', display='', texture='', lib='', rsl='' ):
        #caller['DL_PROCEDURALS_PATH'] = script
        caller['DL_PROCEDURALS_PATH'] = procedurals
        caller['DL_DISPLAYS_PATH'] = display
        caller['DL_SHADERS_PATH'] = shader
        caller['DL_TEXTURES_PATH'] = texture
        caller['LD_LIBRARY_PATH'] = lib
        caller['_3DFM_SL_INCLUDE_PATH'] = rsl

    def bins(self):
        ''' we check if it's a windows 3delight in linux, and if so,
        set it to run with wine!'''
        ret = baseApp.bins(self)
        if os.path.exists(self.path('drive_c')):
            newRet = []
            for each in ret:
                newRet.append( ( each[0].replace('.exe',''), each[1] ) )
            ret = newRet
#        ret.append( ( 'renderdl.exe','renderdl.exe') )

        try:
            del ret[ret.index(('licserver','licserver'))]
#            del ret[ret.index(('shaderdl','shaderdl'))]
#            del ret[ret.index(('licutils','licutils'))]
        except:
            pass
        
        return ret

    def runUserSetup(self, bin):
        ''' only create a user folder structure if it's the main gaffer app.'''
        return  bin[0] == 'renderdl'
    
    def userSetup(self, jobuser):
        ''' we don't want to change folder when running 3delight, since it's
        called by other softwares, so we user userSetup() to move back to 
        the original folder it was when it was called!'''
        os.chdir( jobuser.pwd )
        if os.path.exists( jobuser.path('maya') ):
            if not os.path.exists( jobuser.path('maya/3delight') ):
                os.makedirs( jobuser.path('maya/3delight') )
                
            if not os.path.exists( jobuser.path('delight/3dfm') ):
                os.symlink( jobuser.path('maya/3delight'), jobuser.path('delight/3dfm') )
        
        
    def getDisplaysFromRib( self, cmd ):
        ''' internal delight class function used to get all display drivers from a rib command line parameter '''
        if hasattr(self, 'displays'):
            return self.displays
        else:
            import os
            displays={}
            rib = filter( lambda x: '.rib' in x.lower(), cmd.split() )
            if rib:
                rib = os.path.abspath(rib[0].replace('"',''))
                if os.path.exists(rib):
                    # first we run renderdl catrib to grab all the file displays in the rib!
                    error = False
                    grabDisplays = "%s -catrib %s 2>/dev/null " % (self.path('/bin/renderdl'), rib)
                    displayLines = os.popen( grabDisplays ).readlines()
                    for display in displayLines:
                        displayFile = None
                        # images
                        if 'Display ' in display and '.tdl.' not in display:
                            displayFile = display.split('"')[1].replace('+','')
                                
                        # ptc files            
                        elif 'Option "user" "string bake_file"' in display:
                            if '.ptc' in display.lower():
                                displayFile = filter( lambda x: '.ptc' in x.lower(), display.split('"') )[0]
                    
                        if displayFile:
                            if displayFile[0]=='/':
                                # if file don't exist, already failed!!
                                if not os.path.exists(displayFile):
                                    error = True
                                # create a dictionary per filetype
                                ext = os.path.splitext(displayFile)[-1].lower()
                                if not displays.has_key( ext ):
                                    displays[ext] = {}
                                displays[ext][displayFile] = False
            self.displays = displays
            return displays
        
        
    def preRun(self, cmd):
        ''' this is called before a binary of this class runs. 
        it's the perfect method to do pre render checks and setups, for example!'''
        newCmd = cmd
        if 'renderdl' in cmd:
            from pipe import admin
            from glob import glob
            print '='*80
            
            # REMOVE ME! Temp fix for qube proxy mode
            displays = self.getDisplaysFromRib(cmd)
            if displays :
                sudo = admin.sudo()
                for filetype in displays:
                    for d in displays[filetype]:
                        sudo.chmod( "a+rwx", os.path.dirname(d) )
                        for each in glob( "%s*" % d ):
                            sudo.chmod( "a+rwx", each )
                sudo.run()
                
            newCmd = cmd.replace("renderdl ", "renderdl -progress -stats3 ")

            # setup netrender to use ssh!
#            if '-hosts' in cmd:
#                x = newCmd.replace('"','').split(' ')
#                id = x.index( filter(lambda z: '-hosts' in z.lower(), x)[0] )
#                x.insert(id+2,'-ssh')
#                newCmd = ' '.join(x)
                
            # if no i-display running, remove any .idisplay.address file leftover!
#            if not os.popen('pidof i-display 2>&1').readlines():
#                idisplay_address = '%s/.idisplay.address' % os.environ['HOME']
#                if os.path.exists(idisplay_address):
#                    os.remove( idisplay_address )            

        # shader compilation
        if 'shaderdl' in cmd:
            newCmd = cmd.replace("shaderdl", "shaderdl -I./ -I%s/include/ -I%s/maya/rsl/" % (self.path(),self.path()))


        return newCmd 
    
    def postRun(self, cmd, returnCode, returnLog=""):
        ''' this is called after a binary of this class has exited. 
        it's the perfect method to do postRender checks, for example!'''
        error = returnCode!=0
        if 'renderdl' in cmd:
            
            # parse rib file to get displays
            displays = self.getDisplaysFromRib(cmd)

            # run generic frame check for our displays
            error = pipe.frame.check( displays, returnLog )

            # move rendered frames to asset, if this render is an asset!
            if not error:
                # if an --asset was passed on, we have self.asset!
                pipe.frame.publish( displays, self.asset)
                
            # publish output log
            pipe.frame.publishLog(returnLog, self.asset, self.className)
                
            # cleanup ribs to save space
            for each in cmd.split(' '):
                each = each.replace('"','')
                if os.path.splitext(each.lower())[-1] in ['.rib']:
                    # we need to use pipe.admin.system to properly handle 
                    # if this will be running in the farm!
                    pipe.admin.system( "rm -rf %s" % each )

            # if running in the farm, remove 3delight temp folders
            if self.inFarm():
                for each in ['_3DFM_SHADERS_PATH', '_3DFM_SHADOWMAPS_PATH', '_3DFM_TEXTURES_PATH']:
                    pipe.admin.system( "rm -rf %s" % self[each] )

            
        
        # return an posix error code
        return int(error)*255            

            
    def getLicenses(self):
        ''' talk to a list of services and return the live ones, with all license info. 
        Use PIPE_DELIGHT_LICENSE_SERVERS env var to setup a list of servers on the fly,
        separating then with spaces.
        ex: export PIPE_DELIGHT_LICENSE_SERVERS="server1 server2 server3" ''' 
        
        # list of license servers to query for available licenses
        licenseServers = ['atomoweb.local']
        if os.environ.has_key('PIPE_DELIGHT_LICENSE_SERVERS'):
            licenseServers = os.environ['PIPE_DELIGHT_LICENSE_SERVERS'].split()
        
        # run over all license servers and find an available license for us. 
        # if no license available:
        #   * and running interactivelly, set the demo version!
        #   * and running in the farm, set the license anyways and let renderdl handle the license waiting.
        serverz={}
        for each in licenseServers:
            # check if server is running
            if os.popen(" ping -c 1 -t 5  192.168.0.249 | grep ' 0%'").readlines():
                running = os.popen('%s serverstatus @%s' % (self.path('bin/licutils'), each) ).readlines()
                if filter(lambda x: 'running' in x, running):

                    # check if there are licenses available
                    nlicenses = os.popen('%s serverlicenses @%s' % (self.path('bin/licutils'), each) ).readlines()
                    totalLicenses       = int(filter(lambda x: 'total licenses' in x, nlicenses )[0].split(':')[-1])
                    usedLicenses        = int(filter(lambda x: 'used licenses' in x, nlicenses )[0].split(':')[-1])
                    waitingLicenses     = int(filter(lambda x: 'waiting for licenses' in x, nlicenses )[0].split(':')[-1])
                    availableLicenses   = totalLicenses - usedLicenses - waitingLicenses
                    serverz[each] = {
                        'total'     : totalLicenses,
                        'used'      : usedLicenses,
                        'waiting'   : waitingLicenses,
                        'available' : availableLicenses,
                    }
        return serverz


    def license(self):
        ''' 3delight license method is a bit smart. It can look over
        a list of servers and talk to the license server to find
        how busy a server is. 
        *If not running on the farm and theres no free licenses available,
        it fallsback to no server and renders with watermarks.
        *If it's running on the farm, it will pick the least busy server
        since we can't let a farm render output watermarks! 
        Use PIPE_DELIGHT_LICENSE_SERVERS to setup a list of servers on the fly,
        separating then with spaces.
        ex: export PIPE_DELIGHT_LICENSE_SERVERS="server1 server2 server3" ''' 
        import sys
        
#        if 'newfarm' in ''.join(os.popen("hostname").readlines()):
#            os.environ['PIPE_DELIGHT_LICENSE_SERVERS']
        
        
        # if running on the farm, we need to setup a license server, even 
        # if they are all busy!
        runningOnFarm = self.inFarm()

        # set renderman.ini to run our license scheme
        userConfig = '%s/rendermn.ini' % os.environ['HOME']
            
        # remove userConfig anyway, so if no license available, renders with watermark!
        #cache.rmtree( userConfig )
        os.system( "rm -f '%s'" % userConfig )

        message = "RUNNING WITH WATERMARK"
        previous_availableLicenses = -999
        if 'DELIGHT_FORCE_DEMO' in os.environ.keys():
            pass
        else:
         # list of license servers to query for available licenses
         licenseServers = self.getLicenses()

         # run over all license servers and find an available license for us. 
         # if no license available:
         #   * and running interactivelly, set the demo version!
         #   * and running in the farm, set the license anyways and let renderdl handle the license waiting.
         for each in licenseServers:
            
            # if running on the farm, we need to setup a license server, even 
            # if they are all busy!
            if runningOnFarm:
                # set config file for current user to the available license server
                # if running on the farm, set the least queued server
                userConfig =  '%s/rendermn.ini' %  self['HOME'] 

                cache.copy( self.path('rendermn.ini'), userConfig ) 
                f = open( userConfig, 'a' )
                f.write( '\n\n/3delight/licserver %s\n' % each)
                f.write( '\n\n/3delight/licserver %s\n' % each)
                f.close()
                message = ""
                    
            else:
                # check if server is running
                running = os.popen('%s serverstatus @%s' % (self.path('bin/licutils'), each) ).readlines()
                if filter(lambda x: 'running' in x, running):

                    # check if there are licenses available
                    nlicenses = os.popen('%s serverlicenses @%s' % (self.path('bin/licutils'), each) ).readlines()
                    totalLicenses       = int(filter(lambda x: 'total licenses' in x, nlicenses )[0].split(':')[-1])
                    usedLicenses        = int(filter(lambda x: 'used licenses' in x, nlicenses )[0].split(':')[-1])
                    waitingLicenses     = int(filter(lambda x: 'waiting for licenses' in x, nlicenses )[0].split(':')[-1])
                    availableLicenses   = totalLicenses - usedLicenses
                    
                    # if we have licenses available (or in the farm), set the license server
                    if availableLicenses >=2: # and availableLicenses > previous_availableLicenses):
                        # set config file for current user to the available license server
                        # if running on the farm, set the least queued server
                        cache.copy( self.path('rendermn.ini'), userConfig ) 
                        f = open( userConfig, 'a' )
                        f.write( '\n\n/3delight/licserver %s\n' % each)
                        f.close()
                        message = ""
                    
                
                # use this to compare with the next server. if the next is less busy,
                # switch to that server.
                previous_availableLicenses = availableLicenses
        if message:
            print >>sys.stderr,message 
        




