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

class fabricEngine(baseApp):
    def environ(self):
        maya.addon( self,
            plugin      = self.path("DCCIntegrations/FabricMaya$MAYA_VERSION/plug-ins/"),
            script      = [
                self.path("DCCIntegrations/FabricMaya$MAYA_VERSION/scripts/"),
                self.path("DCCIntegrations/FabricMaya$MAYA_VERSION/python/"),
            ],
            icon        = self.path("DCCIntegrations/FabricMaya$MAYA_VERSION/icons/"),
            lib         = self.path("lib"),
            module      = self.path("DCCIntegrations/FabricMaya$MAYA_VERSION/"),
        )

        self['FABRIC_DIR'] = self.path()
        self['FABRIC_EXTS_PATH'] = self.path('Exts')
        self['FABRIC_DFG_PATH'] = self.path('Presets/DFG')
        self['PYTHONPATH'] = self.path('Python/$PYTHON_VERSION_MAJOR')
        self['PYTHONPATH'] = self.path('DCCIntegrations/FabricMaya$MAYA_VERSION/scripts/')
        self['PYTHONPATH'] = self.path('DCCIntegrations/FabricMaya$MAYA_VERSION/python/')


        # add tools paths
        for each in self.toolsPaths():
            maya.addon( self,
                script = '%s/fabric/python/' % each ,
            )

    @staticmethod
    def addon(caller, extensions="", dfg=""):
        self['FABRIC_EXTS_PATH'] = self.path(extensions)
        self['FABRIC_DFG_PATH'] = self.path(dfg)

    def bins(self):
        return [
            ('canvas','canvas.py'),
            # ('canvasGUIDFixup', 'canvasGUIDFixup'),
            # ('canvasGUIDGen', 'canvasGUIDGen'),
            # ('canvasGUIDReplace', 'canvasGUIDReplace'),
            ('kl', 'kl'),
            ('kl2dfg', 'kl2dfg'),
            ('kl2edk', 'kl2edk'),
            ('kludge', 'kludge'),
            ('parseJSON', 'parseJSON'),
        ]


    def license(self):
        self['fabricinc_LICENSE'] = os.environ['PIPE_FABRIC_ENGINE_LICENSE']
