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




class mgear(baseApp):
    def environ(self):
        if cached.exists(self.path('release')):
            maya.addon( self,
                plugin      = self.path("release/platforms/$MAYA_VERSION_MAJOR_ONLY/linux/x64/plug-ins/"),
                script      = self.path("release/scripts/"),
                icon        = self.path("release/icons/"),
            )
        else:
            maya.addon( self,
                plugin      = self.path("platforms/$MAYA_VERSION_MAJOR/linux/x64/plug-ins/"),
                script      = self.path("scripts/"),
                #icon        = self.path("maya.$MAYA_VERSION/icons/"),
                #lib         = self.path("maya.$MAYA_VERSION/lib/"),
                #module      = self.path("maya.$MAYA_VERSION")
                #renderDesc  = self.path("maya.$MAYA_VERSION/scripts/"),
                #preset      = self.path("maya.$MAYA_VERSION/scripts/")
            )


    def bins(self):
        return []


    def license(self):
        pass
