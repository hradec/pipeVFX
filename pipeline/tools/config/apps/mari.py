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


class mari(baseApp):
    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''
                        
        #MARI_DEFAULT_CAMERA_PATH
        #MARI_DEFAULT_RENDER_PATH
        #MARI_DEFAULT_SHELF_PATH
        #MARI_DEFAULT_ARCHIVE_PATH
        #MARI_DEFAULT_GEOMETRY_PATH
        #MARI_DEFAULT_IMAGE_PATH
        #MARI_DEFAULT_IMPORT_PATH
        #MARI_DEFAULT_EXPORT_PATH
        #MARI_PLUGINS_PATH
        #MARI_SCRIPT_PATH
        #MARI_USER_PATH
        #MARI_WORKING_DIR
        #MARI_LOG_FILE
        #MARI_LOG_PATH
        #MARI_CACHE
        #MARI_NO_EXAMPLE_PROJECT
                
        #MARI_ATLAS_SIZE
        #MARI_ATLAS_FORMAT
        #MARI_ACTION_LOG
        #MARI_PAINT_BUFFER_SIZE
        #MARI_PAINT_BUFFER_FORMAT
        #MARI__DISABLE_WARNING_DIALOGS
        #MARI_CUSTOM_PLUGINS_PATH
        #MARI_DEFAULT_EXPORT_PATH
        #MARI_DEFAULT_IMPORT_PATH
        #MARI_DEFAULT_IMAGE_PATH
        #MARI_DEFAULT_GEOMETRY_PATH
        #MARI_DEFAULT_ARCHIVE_PATH
        #MARI_DEFAULT_SHELF_PATH
        #MARI_DEFAULT_RENDER_PATH
        #MARI_DEFAULT_CAMERA_PATH
        #MARI_USER_PATH
        #MARI_LOG_PATH
        #MARI_SCRIPT_PATH
        #MARI_PLUGINS_PATH

        self['MARI__DISABLE_WARNING_DIALOGS'] = '1'
        
        self['MARI_CACHE']                  = "%s/mari/cache" % os.environ['HOME']
        self['MARI_USER_PATH']              = "%s/mari" % os.environ['HOME']
        self['MARI_LOG_PATH']               = "%s/mari/log" % os.environ['HOME']
        self['MARI_ACTION_LOG']             = "%s/mari/log/action.log" % os.environ['HOME']
        self['MARI_DEFAULT_EXPORT_PATH']    = "%s/mari/export" % os.environ['HOME']
        self['MARI_DEFAULT_IMPORT_PATH']    = "%s/mari/import" % os.environ['HOME']
        self['MARI_DEFAULT_IMAGE_PATH']     = "%s/mari/image" % os.environ['HOME']
        self['MARI_DEFAULT_GEOMETRY_PATH']  = "%s/mari/geometry" % os.environ['HOME']
        self['MARI_DEFAULT_ARCHIVE_PATH']   = "%s/mari/archive" % os.environ['HOME']
        self['MARI_DEFAULT_SHELF_PATH']     = "%s/mari/shelf" % os.environ['HOME']
        self['MARI_DEFAULT_RENDER_PATH']    = "%s/mari/render" % os.environ['HOME']
        
        
    def __mkdirs(self):
        ''' central method to create mari folders used by environ and userSetup methods '''
        cache.makedirs( self['MARI_CACHE'] )
        cache.makedirs( self['MARI_LOG_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_EXPORT_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_IMPORT_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_IMAGE_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_GEOMETRY_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_ARCHIVE_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_SHELF_PATH'] )
        cache.makedirs( self['MARI_DEFAULT_RENDER_PATH'] )
        
        # write cacheLocations.ini file to force cache location!
        cache.makedirs('%s/.config/TheFoundry' % os.environ['HOME'])
        cacheLocationFile = open( '%s/.config/TheFoundry/CacheLocations.ini' % os.environ['HOME'], 'w' )
        cacheLocationFile.write( '[CacheRoots]\nsize=1\n1\Path=%s' % self['MARI_CACHE'] )
        cacheLocationFile.close()
        
    def license(self):
        self.__mkdirs()
        if os.environ.has_key('PIPE_MARI_LICENSE_SERVERS'):
            self['foundry_LICENSE'] = os.environ['PIPE_MARI_LICENSE_SERVERS']

    def bins(self):
        ''' we make our wrapper without the .py just to keep
            things more professional! lol '''
        return [('mari','../mari')]

    def userSetup(self, jobuser):
        ''' setup env vars and folders when shell is in a job/shot environ
        so mari will save inside job/shot structure automagically.'''
        self.replace( {
            'MARI_USER_PATH'              : "%s/mari" % jobuser.path(),
            'MARI_CACHE'                  : "%s/mari/cache" % jobuser.path(),
            'MARI_LOG_PATH'               : "%s/mari/log" % jobuser.path(),
            'MARI_ACTION_LOG'             : "%s/mari/log/action.log" % jobuser.path(),
            'MARI_DEFAULT_EXPORT_PATH'    : "%s/mari/export" % jobuser.path(),
            'MARI_DEFAULT_IMPORT_PATH'    : "%s/mari/import" % jobuser.path(),
            'MARI_DEFAULT_IMAGE_PATH'     : "%s/mari/image" % jobuser.path(),
            'MARI_DEFAULT_GEOMETRY_PATH'  : "%s/mari/geometry" % jobuser.path(),
            'MARI_DEFAULT_ARCHIVE_PATH'   : "%s/mari/archive" % jobuser.path(),
            'MARI_DEFAULT_SHELF_PATH'     : "%s/mari/shelf" % jobuser.path(),
            'MARI_DEFAULT_RENDER_PATH'    : "%s/mari/render" % jobuser.path(),
        } )
        jobuser.mkdir( 'mari' )
        jobuser.create()
        self.__mkdirs()
        
