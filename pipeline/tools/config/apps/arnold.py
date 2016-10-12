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



    
class arnold(baseApp):
    def environ(self):
        
        self['PATH'] = self.path('mtoadeploy/$MAYA_VERSION/bin')
        self['LD_LIBRARY_PATH'] = self.path('mtoadeploy/$MAYA_VERSION/bin')
        arnold.addon( self,
            script      = self.path('mtoadeploy/$MAYA_VERSION/scripts'),
            extensions  = self.path('mtoadeploy/$MAYA_VERSION/extensions'),
            shader      = self.path('mtoadeploy/$MAYA_VERSION/shaders'),
        )
        
        self['PYTHONPATH'] = self.path('python')
        if os.path.exists(self.path('mtoadeploy/%s/oldpipe' % maya().version())):
            self['MAYA_MODULE_PATH']=self.path('mtoadeploy/$MAYA_VERSION/oldpipe')
        else:
            maya.addon(self,
                plugin = self.path('mtoadeploy/$MAYA_VERSION/plug-ins'),
                script = self.path('mtoadeploy/$MAYA_VERSION/scripts'),
                renderDesc = self.path('mtoadeploy/$MAYA_VERSION'),
                icon   = [
                    self.path('mtoadeploy/$MAYA_VERSION/icons'),
                ]
            )
        
        self.update( top=maya() )
        self.update( cortex() )

    def bins(self):
        return [
            ('kick','kick'),
            ('maketx','maketx'),
        ]

    @staticmethod
    def addon( caller, script='', extensions='', procedurals='', shader='', display='', lib='' ):
        caller['MTOA_EXTENSIONS_PATH'] = extensions
        caller['LD_LIBRARY_PATH'] = procedurals
        caller['LD_LIBRARY_PATH'] = lib
        caller['ARNOLD_PLUGIN_PATH'] = display
        caller['ARNOLD_PLUGIN_PATH'] = shader
        caller['ARNOLD_PLUGIN_PATH'] = procedurals
        caller['PYTHONPATH'] = script

    def license(self):
        self['solidangle_LICENSE'] = self.path('mtoadeploy/$MAYA_VERSION/license')

