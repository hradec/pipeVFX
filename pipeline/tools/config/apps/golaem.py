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



    
class golaem(baseApp):
    def environ(self):
        maya.addon( self, 
            plugin      = self.path("maya.$MAYA_VERSION/plug-ins/"),
            script      = self.path("maya.$MAYA_VERSION/scripts/"),
            icon        = self.path("maya.$MAYA_VERSION/icons/"), 
            lib         = self.path("maya.$MAYA_VERSION/lib/"), 
            #module      = self.path("maya.$MAYA_VERSION") 
            #renderDesc  = self.path("maya.$MAYA_VERSION/scripts/"), 
            #preset      = self.path("maya.$MAYA_VERSION/scripts/")
        )
        
        self['PATH'] = self.path("maya.$MAYA_VERSION/bin")
        self['LD_LIBRARY_PATH'] = self.path("maya.$MAYA_VERSION/lib")
        
        self['ARNOLD_PROCEDURAL_PATH']          = self.path("maya.$MAYA_VERSION/procedurals")
        self['DL_PROCEDURALS_PATH']             = self.path("maya.$MAYA_VERSION/procedurals")
        self['ARNOLD_PLUGIN_PATH']              = self.path("maya.$MAYA_VERSION/shaders")
        self['MI_CUSTOM_SHADER_PATH']           = self.path("maya.$MAYA_VERSION/procedurals")
        self['RMS_PROCEDURAL_PATH']             = self.path("maya.$MAYA_VERSION/procedurals")
        #self['RMS_SCRIPT_PATHS']                = self.path("maya.$MAYA_VERSION/procedurals")
        self['RMS_SHADER_PATH']                 = self.path("maya.$MAYA_VERSION/shaders")
        self['VRAY_PLUGINS_x64']                = self.path("maya.$MAYA_VERSION/procedurals")
        self['VRAY_FOR_MAYA2014_PLUGINS_x64']   = self.path("maya.$MAYA_VERSION/procedurals")
        self['VRAY_FOR_MAYA_SHADERS']           = self.path("maya.$MAYA_VERSION/shaders")

        prman.addon( self, 
            procedurals = self.path("maya.$MAYA_VERSION/procedurals"),
            shader      = self.path("maya.$MAYA_VERSION/shaders"),
        )
        
        # add tools paths
        for each in self.toolsPaths():
            maya.addon( self,
                script = '%s/golaem/scripts/$GOLAEM_VERSION/' % each ,
            )

    def bins(self):
        return [
            ('glmCrowdSimulationCacheTool','maya.$MAYA_VERSION/bin/glmCrowdSimulationCacheTool'),
        ]


    def license(self):
        self['golaem_LICENSE'] = os.environ['PIPE_GOLAEM_LICENSE']

