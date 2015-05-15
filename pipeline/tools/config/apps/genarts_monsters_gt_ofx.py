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


class genarts_monsters_gt_ofx(baseApp):
    def environ(self):
        ''' set all environment variables is here '''
        
#License server: GENARTS_LICENSE = 5053@192.168.0.249
#Plugin Path: OFX_PLUGINS_PATH = /path/to/Monsters.ofx.bundle (/usr/genarts/OFX default)
#Libs: LD_LIBRARY_PATH = /path/to/genarts/monsters-ofx64/lib64
#Nuke: NUKE_PATH = /path/to/genarts/OFX/Plugins
#Also symbolic link to both libcudart.so.2.2 → libcudart.so.2 and libcufft.so.2.2 → libcufft.so.2 which hare in monsters-ofx64/lib64 folder.

        nuke.addon ( self,
            nukepath = self.path('usr/OFX/Plugins/'),
            lib      = self.path('usr/genarts/monsters-ofx64/lib64'),
        )
        
        self['OFX_PLUGINS_PATH'] = self.path('usr/OFX/Plugins/Monsters.ofx.bundle')
        
        
    def bins(self):
        return []
        
    def license(self):
        self['genarts_LICENSE']=os.environ['PIPE_GENARTS_LICENSE']

    def userSetup(self, jobuser):
        os.chdir( jobuser.pwd )