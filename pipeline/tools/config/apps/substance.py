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


class substance(baseApp):
    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        '''' arch dependencies:
                openmotif

        '''

        self['LD_LIBRARY_PATH'] = self.path('painter/')
        self['PATH']            = self.path('painter/')
        self['QML_IMPORT_PATH'] = self.path('painter/qml/')
        self['QML_IMPORT_PATH'] = self.path('painter/resources/')
        self['QT_PLUGIN_PATH']  = self.path('painter/')
        self['QT_PLUGIN_PATH']  = self.path('painter/qml/')
        self['QT_PLUGIN_PATH']  = self.path('painter/resources/')
        
        # self.ignorePipeLib( "readline" )
        # self.ignorePipeLib( "log4cplus" )
        # self['LD_PRELOAD'] = '/usr/lib/liblog4cplus-1.2.so.5'


    def bins(self):
        return [
            ('spainter','painter/Substance\ Painter\ 2'),
            ('sdesigner', 'designer/Substance\ Designer'),
        ]

    def license(self):
        self['SUBSTANCE_PAINTER_2_LICENSE'] = '%s/licenses/substance/painter2/SubstancePainter2.key' % pipe.roots.tools()
        self['SUBSTANCE_DESIGNER_6_LICENSE'] = '%s/licenses/substance/painter2/SubstanceDesigner6.key' % pipe.roots.tools()

    def userSetup(self, jobuser):
        self['__USER_FOLDER__'] = jobuser.path('substance')

    def preRun(self,cmd):
        shot =  pipe.admin.job().shot()
        return 'export HOME=$__USER_FOLDER__ ; '+cmd
