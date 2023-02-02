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


class mayausd(baseLib):
    def versions(self):
        ''' set the required dependency version '''
        if self.parent() in ['maya']:
            muv = float('.'.join(pipe.libs.version.get( 'mayausd' ).split('.')[:2]))
            if muv >= 0.18:
                pipe.libs.version.set( usd = '21.11' )
                pipe.libs.version.set( usd_non_monolithic = '21.11' )
                pipe.libs.version.set( ptex = '2.3.2' )


    def environ(self):
        if hasattr(pipe.libs, "usd"):
            self.update( pipe.libs.usd() )
        pipe.apps.maya.addon( self, module = self.path("maya.$MAYA_VERSION") )
