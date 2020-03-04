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

class redshift(baseApp):
    def environ(self):
        self['PYTHONPATH'] = self.path("redshift4maya/common/scripts")
        self['REDSHIFT_COREDATAPATH'] = self.path()
        self['REDSHIFT_PLUG_IN_PATH'] = '$REDSHIFT_COREDATAPATH/redshift4maya/$MAYA_VERSION'
        self['REDSHIFT_SCRIPT_PATH'] = '$REDSHIFT_COREDATAPATH/redshift4maya/common/scripts'
        self['REDSHIFT_XBMLANGPATH'] = '$REDSHIFT_COREDATAPATH/redshift4maya/common/icons'
        self['REDSHIFT_RENDER_DESC_PATH'] = '$REDSHIFT_COREDATAPATH/redshift4maya/common/rendererDesc'
        self['REDSHIFT_CUSTOM_TEMPLATE_PATH'] = '$REDSHIFT_COREDATAPATH/redshift4maya/common/scripts/NETemplates'
        self['REDSHIFT_MAYAEXTENSIONSPATH'] = '$REDSHIFT_PLUG_IN_PATH/extensions'
        self['REDSHIFT_PROCEDURALSPATH'] = '$REDSHIFT_COREDATAPATH/procedurals'
        # self['REDSHIFT_DISABLELICENSECHECKOUTONINIT'] = '1'

        # self['REDSHIFT_LOCALDATAPATH'] =
        # self['REDSHIFT_LICENSERETURNTIMEOUT'] =

        # MAYA_PLUG_IN_PATH = $REDSHIFT_PLUG_IN_PATH
        # MAYA_SCRIPT_PATH = $REDSHIFT_SCRIPT_PATH
        # PYTHONPATH = $REDSHIFT_SCRIPT_PATH
        # XBMLANGPATH = $REDSHIFT_XBMLANGPATH
        # MAYA_RENDER_DESC_PATH = $REDSHIFT_RENDER_DESC_PATH
        # MAYA_CUSTOM_TEMPLATE_PATH = $REDSHIFT_CUSTOM_TEMPLATE_PATH

        maya.addon(self,
            plugin = self.path("redshift4maya/$MAYA_VERSION"),
            script = self.path("redshift4maya/common/scripts"),
            icon = self.path("redshift4maya/common/icons"),
            renderDesc = self.path('redshift4maya/common/rendererDesc'),
            lib = [
                self.path('redshift4maya/$MAYA_VERSION/extensions'),
                self.path('bin'),
            ],
            preset = '',
            module = '',
            shelves = self.path('redshift4maya/common/shelves/$MAYA_VERSION_MAJOR'),
            templates = self.path('redshift4maya/common/scripts/NETemplates'),
        )



    def bins(self):
        ret = [
            ('redshiftCmdLine', 'redshiftCmdLine'),
            ('redshiftTextureProcessor', 'redshiftTextureProcessor'),
            ('redshiftLicensingTool', 'redshiftLicensingTool'),
        ]
        return ret

    def run(self, app):
        import os, sys, glob


        if 'redshiftLicensingTool' in app:
            #proxy for redshift licenseManager
            self['http_proxy'] = 'http://%s' % os.environ['PIPE_PROXY_SERVER']

        baseApp.run( self, app )

    def license(self):
        # setup for floating licenses - no internet needed!!
        # self['redshift_LICENSE'] = os.environ['PIPE_REDSHIFT_LICENSE']
        # self['RLM_LICENSE_PASSWORD'] = '1'

        # locked node license - this damn thing needs internet to run in locked node!!
        self['http_proxy']  = 'http://%s' % os.environ['PIPE_PROXY_SERVER']
        self['https_proxy'] = 'http://%s' % os.environ['PIPE_PROXY_SERVER']
