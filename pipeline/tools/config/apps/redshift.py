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
from __future__ import print_function

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

        try:
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

            # add ranch renderfarm to redshift setup!
            self.update( ranch() )
        except:
            pass

    def bins(self):
        ret = [
            ('redshiftCmdLine', 'redshiftCmdLine'),
            ('redshiftTextureProcessor', 'redshiftTextureProcessor'),
            ('redshiftLicensingTool', 'redshiftLicensingTool'),
        ]
        return ret

    def run(self, app):
        import os, sys, glob, time, socket
        from pipe.bcolors import bcolors as b

        licenses=[ [ l for l in x.split('/') if '.local' in l ][0] for x in glob.glob("%s/licenses/redshift/*/*/" % pipe.roots().tools()) ]
        if not licenses:
            print ("\n\nRedshift is not currently licensed on any machine!\n\n")
        else:
            if socket.gethostname() not in licenses:
                print ("\n\nRedshift has license files on this machine(s):"+b.FAIL)
                for l in licenses:
                    print ("\t%s" % l)
                print (b.END+"\nYou need to deactivate first before activating here.")

                if '--force' not in sys.argv:
                    print (b.END+"\nRun this tool again with "+b.GREEN+" --force "+b.END+" to force open the license tool to reset the license.")
                    print (b.WARNING+"(avoid using --force or else we will have to manually erase the license found at %s/licenses/redshift/%s)\n\n%s" % (pipe.roots().tools(), licenses[0], b.END))
                    sys.exit(-1)

        if 'redshiftLicensingTool' in app:
            while not os.path.exists('/var/tmp/redshift'):
                print ("Linux still finishing boot... waiting fixed license path to become available. (press CTRL+C to cancel)")
                time.sleep(5)

            # proxy for redshift licenseManager
            # locked node license - this damn thing needs internet to run in locked node!!
            self['http_proxy']  = 'http://%s' % os.environ['PIPE_PROXY_SERVER']
            self['https_proxy'] = 'http://%s' % os.environ['PIPE_PROXY_SERVER']

        baseApp.run( self, app )

    def license(self):
        pass
        # setup for floating licenses - no internet needed!!
        # self['redshift_LICENSE'] = os.environ['PIPE_REDSHIFT_LICENSE']
        # self['RLM_LICENSE_PASSWORD'] = '1'
