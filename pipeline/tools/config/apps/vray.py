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


class vray(baseApp):
    def environ(self):
        # configure maya plugin/scripts/icons
        maya.addon ( self,
            module = self.path('autodesk/maya$MAYA_VERSION/VRayForMaya.module'),
            plugin = [
                self.path('autodesk/maya$MAYA_VERSION/plug-ins/'),
                self.path('autodesk/maya$MAYA_VERSION/plug-ins/xgen/presets/plugins/'),
                self.path('autodesk/maya$MAYA_VERSION/vray/plug-ins/'),
            ],
            script = [
                self.path('autodesk/maya$MAYA_VERSION/scripts/others/'),
                self.path('autodesk/maya$MAYA_VERSION/vray/scripts/'),
            ],
            icon   = [
                self.path('autodesk/maya$MAYA_VERSION/vray/icons'),
            ],
            preset = self.path('autodesk/maya$MAYA_VERSION/presets'),
            renderDesc = self.path('autodesk/maya$MAYA_VERSION/bin/rendererDesc/'),
        )

        mv = maya().version().replace('.','_')
        self['VRAY_FOR_MAYA%s_MAIN_x64' % mv] = self.path('autodesk/maya$MAYA_VERSION/vray/')
        self['VRAY_FOR_MAYA%s_PLUGINS_x64' % mv] = self.path('autodesk/maya$MAYA_VERSION/vray/vrayplugins/')
        self['VRAY_OSL_PATH_MAYA%s_x64' % mv] = self.path('autodesk/maya$MAYA_VERSION/opensl/')

        self['PATH'] = self.path('autodesk/maya$MAYA_VERSION/bin/')
        self['PATH'] = self.path('autodesk/maya$MAYA_VERSION/vray/bin/')

        self['LD_LIBRARY_PATH'] = self.path('autodesk/maya$MAYA_VERSION/lib/')
        self['LD_LIBRARY_PATH'] = self.path('autodesk/maya$MAYA_VERSION/lib/linux_x64/gcc-4.4/')

        self['PYTHONPATH'] = self.path('autodesk/maya$MAYA_VERSION/vray/scripts/')

        self['VRAY_OPENCL_PLATFORMS_x64']='gpu'

    def bins(self):
        return [( 'vrayslave','/autodesk/maya2016.5/bin/vrayslave' )]

    def license( self ):
        # os.popen( '%s/autodesk/maya$MAYA_VERSION/vbin/setvrlservice -server=192.168.0.17 -port=30304' % self.path() )
        # f = os.popen( '%s/.ChaosGroup/vrlclient.xml' % os.environ["HOME"] )
        # os.popen( '%s/autodesk/maya%s/vray/bin/setvrlservice -server=192.168.0.17 -port=30304' % (self.path(), maya().version() ) ).readlines()
        os.popen( '%s/autodesk/maya%s/vray/bin/setvrlservice -server=127.0.0.1 -port=30305 -server1=0.0.0.0 -port1=30306  -server2=192.168.0.17 -port2=30306' % (self.path(), maya().version() ) ).readlines()
        os.system( '%s/docker/start.sh &' % self.path() )
