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


class gaffer_cycles(baseLib):
    disable=True

    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        # gaffer.addon(self,
        #     libs     = self.path("lib"),
        #     scripts  = self.path('python'),
        #     shaders  = self.path("shader"),
        #     startups = self.path('startup'),
        # )

        # if self.parent() in ['gaffer', 'python']:
        #     self['LD_PRELOAD'] = pipe.libs.tbb().LD_PRELOAD()
