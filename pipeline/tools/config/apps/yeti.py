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



class yeti(baseApp):
    def environ(self):
        ''' set all environment variables is here '''

        maya.addon ( self,
            plugin = self.path('$MAYA_VERSION_MAJOR_ONLY/plug-ins'),
            script = self.path('$MAYA_VERSION_MAJOR_ONLY/scripts'),
            icon   = self.path('$MAYA_VERSION_MAJOR_ONLY/icons'),
            renderDesc = self.path('mtoadeploy/$MAYA_VERSION_MAJOR_ONLY/'),
        )

        delight.addon( self,
            shader = self.path('$MAYA_VERSION_MAJOR_ONLY/shaders')
        )
        arnold.addon( self,
            shader = self.path('$MAYA_VERSION_MAJOR_ONLY/shaders'),
            extensions = [
                self.path('$MAYA_VERSION_MAJOR_ONLY/bin'),
                self.path('$MAYA_VERSION_MAJOR_ONLY/plug-ins'),
            ],
            plugins = [
                self.path('$MAYA_VERSION_MAJOR_ONLY/bin'),
                self.path('$MAYA_VERSION_MAJOR_ONLY/plug-ins'),
            ],
        )

        # set yeti temp folder to a local disk, if any
        for tmp in ['/nuke_sd_cache/', '/mnt/CACHE/']:
            if os.path.exists(tmp):
                self['YETI_TMP'] = tmp
                break

        self['LD_LIBRARY_PATH'] = self.path('$MAYA_VERSION_MAJOR_ONLY/bin')
        self['LD_LIBRARY_PATH'] = self.path('$MAYA_VERSION_MAJOR_ONLY/lib')

    def bins(self):
        return []

    def license(self):
        self['peregrinel_LICENSE']=os.environ['PIPE_YETI_LICENSE']

    def userSetup(self, jobuser):
        os.chdir( jobuser.pwd )
