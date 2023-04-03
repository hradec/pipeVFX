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


class keentools(baseApp):
    def environ(self):
        ''' set all environment variables is here '''
        #License server: GENARTS_LICENSE = 5053@192.168.0.249
        #Plugin Path: OFX_PLUGINS_PATH = /path/to/Monsters.ofx.bundle (/usr/genarts/OFX default)
        #Libs: LD_LIBRARY_PATH = /path/to/genarts/monsters-ofx64/lib64
        #Nuke: NUKE_PATH = /path/to/genarts/OFX/Plugins
        #Also symbolic link to both libcudart.so.2.2 → libcudart.so.2 and libcufft.so.2.2 → libcufft.so.2 which hare in monsters-ofx64/lib64 folder.
        nuke.addon ( self,
            nukepath = [
                self.path('$NUKE_VERSION/'),
                self.path('$NUKE_VERSION/manual/KeenTools/'),
            ],
            lib      = [
                self.path('$NUKE_VERSION/plugin_libs/'),
                self.path('$NUKE_VERSION/manual/KeenTools/libs/'),
            ]
        )

        # self['KEENTOOLS_DATA_PATH'] = self.path('$NUKE_VERSION/manual/KeenTools/data/')
        self['KEENTOOLS_DATA_PATH'] = self.path('$NUKE_VERSION/data/')


    def bins(self):
        return []

    def license(self):
        import shutil
        # cleanup leftover files
        shutil.rmtree(os.environ["HOME"]+"/.config/.keentools", ignore_errors=True)

        self['genarts_LICENSE']=os.environ['PIPE_GENARTS_LICENSE']

    def userSetup(self, jobuser):
        os.chdir( jobuser.pwd )
