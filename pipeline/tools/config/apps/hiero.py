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



class hiero(baseApp):
    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        for each in self.toolsPaths():
            hiero.addon( self,
                plugin = [
                    '%s/hiero/$HIERO_VERSION/' % each ,
                    '%s/hiero/' % each ,
                ]
            )

        # dont use pipe python and pyside
        if self.parent() in ['hiero']:
            self.ignorePipeLib( 'python' )
            self.ignorePipeLib( 'pyside' )

        # add gaffer to hiero, so we can publish hiero projects
        self.update(gaffer())

#        self['__GL_SYNC_DISPLAY_DEVICE']
#        self['HIERO_DISABLE_THUMBNAIL_CACHE']
#        self['HIERO_SINGLE_THREADED_PLAYBACK']
#        self['FOUNDRY_LOG_FILE']
#        self['FOUNDRY_LOG_LEVEL'] # error, warning, message, verbose
#        self['OCIO']


    @staticmethod
    def addon(caller, plugin=""):
        ''' the addon method MUST be implemented for all classes so other apps can set up
        searchpaths for this app. For example, another app which has plugins for this one!'''
        caller['HIERO_PLUGIN_PATH'] = plugin

    def bins(self):
        from glob import glob
        return [('hiero_old', '%s' % os.path.basename( glob('%s/Hiero*.*' % self.bin())[0] ) )]

    def license(self):
        if os.environ.has_key('PIPE_HIERO_LICENSE_SERVERS'):
            self['foundry_LICENSE'] = os.environ['PIPE_HIERO_LICENSE_SERVERS']

        # remove file browser last folder from user preference file
        # so the file browser for save and open, shows the current shot folder
        # instead of the last one!
        # also, setup hiero to use our nuke wrapper instead of their default path to application
        os.system( '''
            cp -rf $HOME/.hiero/uistate.ini $HOME/.hiero/uistate.bak
            cat $HOME/.hiero/uistate.bak \
                | grep -v 'ProjectSavingBrowser.directory' \
                | grep -v 'ProjectBrowser.directory' \
                | grep -v 'DirectoryBrowser.directory' \
                | grep -v 'NukePath' \
            > $HOME/.hiero/uistate.ini
            echo ' ' >> $HOME/.hiero/uistate.ini
            echo '[FileBrowser]' >> $HOME/.hiero/uistate.ini
            echo 'DirectoryBrowser.directory=%s/scripts/run nuke' >> $HOME/.hiero/uistate.ini
            echo '[General]' >> $HOME/.hiero/uistate.ini
            echo 'nukePathLinux=%s/scripts/nukeHiero/nukeHiero' >> $HOME/.hiero/uistate.ini
            echo 'nukePathOSX=%s/scripts/nukeHiero' >> $HOME/.hiero/uistate.ini

        ''' % ( pipe.roots().tools(), pipe.roots().tools(), pipe.roots().tools() ) )
