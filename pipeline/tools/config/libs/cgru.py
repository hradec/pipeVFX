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


class cgru(baseLib):

    def environ(self):
        import sys

        if self.parent() in ['cgru']:
            pipe.apps.version.set( python = '2.7' )
            pipe.libs.version.set( python = '2.7' )
            # it seems the new compiled python 2.7.12 is causing trouble here. so lets use the system python for now!
            self.ignorePipeLib( "readline" )
            self.ignorePipeLib( "python" )

        # Set CGRU root:
        self['CGRU_LOCATION']=self.path()
        self['HOME_CGRU']=self.path()

        # Add CGRU bin to path:
        self['PATH'] = self.path('bin')
        self['AF_ROOT'] = self.path('afanasy')


        # Add software to PATH:
        for each in self.toolsPaths():
            self['PATH']="%s/cgru/software/" % each

        # add global cgru python override!
        self['PYTHONPATH'] = '%s/cgru/python/' % self.toolsPaths()[-1]

        # Python module path:
        self['CGRU_PYTHON'] = self.path("lib/python")
        self['PYTHONPATH']  = self.path("afanasy/python")
        self['PYTHONPATH']  = self.path("lib/python")

        # Get CGRU version:
        self['CGRU_VERSION']=self.version()

        # set afanasy username
        self['AF_USERNAME'] = pipe.admin.username()

        # nuke plugin setup
        self['NUKE_CGRU_PATH'] = self.path('plugins/nuke')
        pipe.apps.nuke.addon(self, nukepath=self.path('plugins/nuke'))

        if self.parent() in ['houdini']:
            # Setup CGRU houdini scripts location:
            self['HOUDINI_CGRU_PATH']=self.path('plugins/houdini')
            self['PYTHONPATH']=self.path('plugins/houdini')

            # Define OTL scan path:
            self['HOUDINI_CGRU_OTLSCAN_PATH']=self.path('plugins/houdini')
            #$HIH/otls:$HOUDINI_CGRU_PATH:$HH/otls

            pipe.apps.houdini.addon(self, otl=self.path('plugins/houdini'))


        pipe.apps.natron.addon(self, plugins=self.path('plugins/natron'))
        pipe.apps.blender.addon(self, plugin=self.path('plugins/blender'))
        pipe.apps.blender.addon(self, plugin=self.path('plugins/blender/addons'))

        #sys.stderr.write('CGRU_VERSION %s : %s\n' %  (self.version(), self.path()))
        #self.update( python() )

    def bins(self):
        return [
            ('afrender', '../start/AFANASY/_afrender.sh'),
            ('afserver', '../start/AFANASY/_afserver.sh'),
            ('afstarter', '../utilities/afstarter/afstarter.py'),
            ('af', '../start/AFANASY/afwatch.sh'),
        ]
