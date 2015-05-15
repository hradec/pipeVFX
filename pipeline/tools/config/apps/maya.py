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



class maya(baseApp):
    def environ(self, allPlugs=True):
        ''' this is the main method in a class to setup environment variables for an app.
        if not implemented, the pipe will try to figure it automatically from the folder structure'''
        
        if self.osx:
            self['PATH'] = '/Library/Application Support/DirectConnect/8.0/bin/Aruba/bin/'
            self['LD_LIBRARY_PATH'] = '/Library/Application Support/DirectConnect/8.0/bin/Aruba/bin/'
            self['LD_LIBRARY_PATH'] = '/Library/Application Support/DirectConnect/8.0/bin/Aruba/bin/plug-ins/translators/'
        # maya needs csh, libXp6 and libtiff3 installed to run!
        
        # we set this to avoid maya csh script to deal with LD_LIBRARY_PATH
        # since its' too big for it to handle 
        #(fix "word too long" error on some systems, like debian!!)
        self['LD_LIBRARYN32_PATH'] = self.path("lib")
        self['libn32'] = '1'
        
        
#        if pipe.OSX:
#            self.replace( MAYA_LOCATION = self.path() )
        
#        pipe.libs.version.set( qt = '4.8.4' )
#        self['LD_PRELOAD'] = pipe.libs.qt().LD_PRELOAD()
        
        # set the proper python version for the current maya version!
        if self.parent() in ['maya','arnold']:
            if int(self.version().split('.')[0]) >= 2014:
                pipe.version.set( python = '2.7.6' )
                pipe.libs.version.set( python = '2.7.6' )
            else:
                pipe.version.set( python = '2.6.8' )
                pipe.libs.version.set( python = '2.6.8' )
                
        # we need this to force maya to read its own python distribution files
        # or else we see a error on os module were it can't find urandom!!
        pythonVer = ''.join(pipe.libs.version.get( 'python' )[:3])
        self.insert('PYTHONPATH',0, self.path('lib/python%s/' % pythonVer))
        self.insert('PYTHONPATH',0, self.path('lib/python%s/lib-dynload/' % pythonVer))
        self.insert('PYTHONPATH',0, self.path('lib/python%s.zip' % pythonVer.replace('.','')))
        self['LD_PRELOAD'] = self.path('lib/libpython%s.so' % pythonVer)
        
        # plugins
        if allPlugs:
            self.update( delight() )
            self.update( arnold() )
            self.update( prman() )
            self.update( cortex() )
            self.update( shave() )
            self.update( slum() )
            self.update( yeti() )

        #add tools paths
        for each in self.toolsPaths():        
            maya.addon( self, 
                plugin = '%s/maya/$MAYA_VERSION/plugins' % each ,
                script = '%s/maya/$MAYA_VERSION/scripts' % each ,
                icon   = '%s/maya/$MAYA_VERSION/icons' % each , 
                module   = '%s/maya/$MAYA_VERSION/modules' % each 
            )
            maya.addon( self, 
                plugin = '%s/maya/plugins' % each ,
                script = '%s/maya/scripts' % each ,
                icon   = '%s/maya/icons' % each ,
                module = '%s/maya/modules' % each 
            )
            self['PYTHONPATH'] = '%s/maya/plugins' % each 
            self['PYTHONPATH'] = '%s/maya/scripts' % each 
        
        self['PYTHONPATH'] = self.path('scripts')
        self['PYTHONPATH'] = self.path('plugins')

        # force the load of the support libraries that come with maya
        # this fixes problems in python with hashlib/md5!!
        if self.parent() in ['maya']:
            self['LD_PRELOAD'] = self.path('support/openssl/libcrypto.so.6')
            self['LD_PRELOAD'] = self.path('support/openssl/libssl.so.6')
        
        # our custom zlib give some error messages at startup of 
        # maya 2014!
        if int(self.version().split('.')[0]) >= 2014:
            self.ignorePipeLib( "zlib" )
        

    def version(self, v=None):
        if v:
            if v[0] not in '0123456789':
                v = None
            #v = filter( lambda x: x in '0123456789.-', v )
        return baseApp.version(self, v)


    def bins(self):
        ''' we override this method to return the commands we want to be visible for the users
        firt element is the command the user will type, and second is the command line executed'''
        return [
            ('maya', 'maya'),
            ('mayapy', 'mayapy'),
            ('Render', 'Render'),
            ('fcheck', 'fcheck'),
        ]

    def bg(self,cmd,bin):
        ''' return True if a cmd or binary should run in background '''
        if bin[0] == 'maya':
            return False
        return False
    
    @staticmethod
    def addon(caller, plugin="", script="", icon="", renderDesc='', lib='', preset='',module=''):
        ''' the addon method MUST be implemented for all classes so other apps can set up 
        searchpaths for this app. For example, another app which has plugins for this one!'''
        if not pipe.osx:
            if type(icon) == type([]):
                icon = map( lambda x: x+"/%B", icon )
            else:
                icon = icon+"/%B"
        caller['MAYA_PLUG_IN_PATH']     = plugin
        caller['MAYA_SCRIPT_PATH']      = script
        caller['XBMLANGPATH']           = icon
        caller['MAYA_RENDER_DESC_PATH'] = renderDesc
        caller['LD_LIBRARY_PATH']       = lib
        caller['MAYA_PRESET_PATH']      = preset
        caller['MAYA_MODULE_PATH']      = module
  
    
    def postRun(self, cmd, returnCode, returnLog=""):
        ''' this is called after a binary of this class has exited. 
        it's the perfect method to do post render frame checks, for example!'''
        error = returnCode!=0
        images=[]
                
        # if Render in cmd 
        if 'Render' in cmd:
            
            # and 'Finished Rendering' in the log, do a frame check!
            if 'Finished Rendering' in returnLog:

                # collect image files from output log                
                images = map(lambda z: z.split('Finished Rendering ')[-1].split()[0].strip().strip('.'),
                               filter(lambda x: 'Finished Rendering ' in x,returnLog.split('\n')) ) 
                               
            # and Mental Ray Render in the log, do a frame check!
            if 'image file' in returnLog and 'Mayatomr.Nodes' in returnLog:

                # collect image files from output log                
                images = map(lambda z: z.split('image file')[-1].split()[0],
                               filter(lambda x: 'image file' in x,returnLog.split('\n')) ) 
                               
            # or Arnold Render in the log, do a frame check!
            if 'writing file' in returnLog and 'mtoa_shaders.so' in returnLog:
                
                # collect image files from output log                
                images = map(lambda z: z.split('writing file')[-1].replace('`','').replace("'",'').strip(),
                               filter(lambda x: 'writing file' in x,returnLog.split('\n')) ) 
                               
        # run our pipe.frame.check generic frame check for the gathered image list
        if images:
            error = pipe.frame.check( images )        
            
            # move rendered frames to asset, if this render is an asset!
            if not error:
                if not self.asset:
                    # If we dont have an asset, try figure it out from the maya scene path
                    # find maya scene file
                    assetPath = None
                    for each in cmd.split(' '):
                        each = each.replace('"','')
                        if os.path.splitext(each.lower())[-1] in ['.mb','.ma']:
                            assetPath = each
                            break
                    pipe.frame.publish( images, assetPath, returnLog )
                else:
                    # if we have an asset reference already, use it!
                    pipe.frame.publish( images, self.asset )
                
        # publish output log
        pipe.frame.publishLog(returnLog, self.asset, self.className)
        
        # return a posix error code if we got an error, so the farm engine 
        # will get a proper error!
        return int(error)*255


        
    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        self['MAYA_PROJECT'] = jobuser.path('maya')
        if not os.path.exists( jobuser.path('maya/workspace.mel') ):
            jobuser.mkdir( 'maya' )
            jobuser.mkdir( 'maya/scenes' )
            jobuser.mkdir( 'maya/3dPaintTextures' )
            jobuser.mkdir( 'maya/sourceimages' )
            jobuser.mkdir( 'maya/images' )
            jobuser.mkdir( 'maya/data' )
            jobuser.mkdir( 'maya/cache' )
            jobuser.mkdir( 'maya/particles' )
            jobuser.mkdir( 'maya/scripts' )

            jobuser.toFile( [
                'workspace -fr "scene" "scenes";',
                'workspace -fr "3dPaintTextures" "sourceimages/3dPaintTextures";',
                'workspace -fr "eps" "data";',
                'workspace -fr "mentalRay" "renderData/mentalray";',
                'workspace -fr "OBJexport" "data";',
                'workspace -fr "mel" "scripts";',
                'workspace -fr "particles" "particles";',
                'workspace -fr "PhysX" "data";',
                'workspace -fr "STEP_DC" "data";',
                'workspace -fr "CATIAV5_DC" "data";',
                'workspace -fr "sound" "sound";',
                'workspace -fr "furFiles" "renderData/fur/furFiles";',
                'workspace -fr "depth" "renderData/depth";',
                'workspace -fr "CATIAV4_DC" "data";',
                'workspace -fr "autoSave" "autosave";',
                'workspace -fr "diskCache" "cache";',
                'workspace -fr "IPT_DC" "data";',
                'workspace -fr "SW_DC" "data";',
                'workspace -fr "DAE_FBX export" "data";',
                'workspace -fr "DAE_FBX" "data";',
                'workspace -fr "mayaAscii" "scenes";',
                'workspace -fr "iprImages" "renderData/iprImages";',
                'workspace -fr "move" "data";',
                'workspace -fr "mayaBinary" "scenes";',
                'workspace -fr "fluidCache" "cache/fluid";',
                'workspace -fr "clips" "clips";',
                'workspace -fr "animExport" "data";',
                'workspace -fr "templates" "assets";',
                'workspace -fr "DWG_DC" "data";',
                'workspace -fr "translatorData" "data";',
                'workspace -fr "offlineEdit" "scenes/edits";',
                'workspace -fr "DXF_DC" "data";',
                'workspace -fr "renderData" "renderData";',
                'workspace -fr "furShadowMap" "renderData/fur/furShadowMap";',
                'workspace -fr "audio" "sound";',
                'workspace -fr "IV_DC" "data";',
                'workspace -fr "scripts" "scripts";',
                'workspace -fr "studioImport" "data";',
                'workspace -fr "furAttrMap" "renderData/fur/furAttrMap";',
                'workspace -fr "FBX export" "data";',
                'workspace -fr "JT_DC" "data";',
                'workspace -fr "sourceImages" "sourceimages";',
                'workspace -fr "apexClothingExporter" "data";',
                'workspace -fr "animImport" "data";',
                'workspace -fr "FBX" "data";',
                'workspace -fr "movie" "movies";',
                'workspace -fr "furImages" "renderData/fur/furImages";',
                'workspace -fr "IGES_DC" "data";',
                'workspace -fr "illustrator" "data";',
                'workspace -fr "furEqualMap" "renderData/fur/furEqualMap";',
                'workspace -fr "images" "images";',
                'workspace -fr "SPF_DC" "data";',
                'workspace -fr "PTC_DC" "data";',
                'workspace -fr "OBJ" "data";',
                'workspace -fr "CSB_DC" "data";',
                'workspace -fr "STL_DC" "data";',
                'workspace -fr "shaders" "renderData/shaders";',
            ], 'maya/workspace.mel' )
            jobuser.create()


