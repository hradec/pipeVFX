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



class alembic(baseLib):
    # def versions(self):
    #     pipe.libs.version.set( hdf5='1.8.11' )

    def environ(self):
        # we don't need to care about the maya version, since
        # the lib class will set the correct maya.<version>
        # subfolder automatically based on self.parent()
        # self.update( pipe.libs.hdf5() )

        pipe.apps.maya.addon ( self,
            plugin = self.path('maya/plug-ins/'),
            lib = self.path('lib'),
        )

        self['HDF5_DISABLE_VERSION_CHECK'] = '1'
