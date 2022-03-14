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
    def environ(self):
        self['PYTHONPATH'] = self.path('lib/python')

        self.update( pipe.libs.opensubdiv() )
        self.update( pipe.libs.alembic() )
        self.update( pipe.libs.ptex() )

        if self.parent() in ['usd']:
            self.update( pipe.libs.pyside() )
            self.update( pipe.libs.oiio() )

        pipe.apps.maya.addon ( self,
            plugin     = self.path('maya.$MAYA_VERSION/third_party/maya/plugin'),
            script     = self.path('maya.$MAYA_VERSION/third_party/maya/lib/usd/usdMaya/resources/'),
            lib        = [
                self.path('lib'),
                self.path('maya.$MAYA_VERSION/third_party/maya/lib'),
            ],
        )

        if self.parent() in ['gaffer','python']:
            self['LD_PRELOAD'] = pipe.libs.ptex().LD_PRELOAD()
        #     self['LD_PRELOAD'] = pipe.libs.ocio().LD_PRELOAD()
        #     self['LD_PRELOAD'] = pipe.libs.qt().LD_PRELOAD()
