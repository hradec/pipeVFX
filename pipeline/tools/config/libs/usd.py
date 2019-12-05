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



class usd(baseLib):
    def versions(self):
        if self.parent() in ['usd']:
            pipe.libs.version.set( oiio='1.6.15' )
            pipe.libs.version.set( opensubdiv='3.4.0' )
            pipe.libs.version.set( ptex='2.0.42' )

    def environ(self):
        self['PYTHONPATH'] = self.path('lib/python')

        if self.parent() in ['usd']:
            self['LD_PRELOAD'] = ':'.join([
                # '%s/gcc/4.8.5/lib64/libstdc++.so.6' % pipe.build.install(),
                # '%s/gcc/4.8.5/lib64/libgcc_s.so.1' % pipe.build.install(),
                '/usr/lib/libstdc++.so.6', '/usr/lib/libgcc_s.so.1'
            ])
            self.update( pipe.libs.oiio() )
            self.update( pipe.libs.ptex() )


        pipe.apps.maya.addon ( self,
            plugin     = self.path('third_party/maya/plugin'),
        )
