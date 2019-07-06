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


class natron(baseApp):
    def environ(self):
        # self['LD_PRELOAD']=[
        #      '/usr/lib64/libavcodec.so.52',
        #      '/usr/lib64/libavformat.so.52',
        #      '/usr/lib64/libavutil.so.52',
        # ]

        self.update( cgru() )

        self['OFX_PLUGIN_PATH'] = self.path("Plugins")

        # Add ofx pipe paths
        for each in self.toolsPaths():
            natron.addon(self,
                plugins = "%s/natron/" % each,
                ofx     = "%s/ofx/" % each,
            )

        # we need this for some plugins!
        p = "%s/.config/gmic" % os.environ['HOME']
        if not os.path.exists(p):
            os.makedirs(p)

    def bins(self):
        return [
            ('natron',  'Natron'),
            ('natron_render', 'NatronRenderer'),
        ]

    def preRun(self, cmd):
        cmd = "NATRON_PLUGIN_PATH=$(echo $NATRON_PLUGIN_PATH | sed 's/:/;/g') " + cmd
        return cmd

    @staticmethod
    def addon(caller, plugins="", ofx=""):
        caller['NATRON_PLUGIN_PATH'] = plugins
        caller['PYTHONPATH'] = plugins
        caller['OFX_PLUGIN_PATH'] = ofx
