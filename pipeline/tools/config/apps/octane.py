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


class octane(baseApp):
    def environ(self):
        # configure maya plugin/scripts/icons
        maya.addon ( self,
            plugin     = self.path('usr/autodesk/maya$MAYA_VERSION-x64/bin/plug-ins/'),
            renderDesc = self.path('usr/autodesk/maya2016.5-x64/bin/rendererDesc/'),
        )

        self['LD_LIBRARY_PATH'] = self.path('usr/lib')
        self['LD_LIBRARY_PATH'] = self.path('standalone')
        self['PATH'] = self.path('standalone')

    def license(self):
        if os.path.exists(self.path()) and not os.path.exists( '%s/.OctaneRender/thirdparty/cudnn_7_4_1/libcudnn.so.7.4.1' % os.environ['HOME'] ):
            os.system( 'rsync -avpP  %s/.OctaneRender/ %s/.OctaneRender/ 2>&1' % (self.path(), os.environ['HOME']) )
