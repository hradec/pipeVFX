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


class flame(baseApp):
    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        '''' arch dependencies:
                openmotif

        '''

        self['LD_LIBRARY_PATH'] = self.path('usr/lib')
        self['LD_LIBRARY_PATH'] = self.path('usr/lib64')
        self['LD_LIBRARY_PATH'] = self.path('usr/discreet/lib')
        self['LD_LIBRARY_PATH'] = self.path('usr/discreet/lib64')

        self['PATH']            = self.path('usr/autodesk/lustrepremium_2015.3/')
        self['LD_LIBRARY_PATH'] = self.path('usr/lib64/lib/lustrepremium2015.3.0.47/')
        self['LD_LIBRARY_PATH'] = self.path('usr/lib64/lib/lustrepremium2015.3.0.47/')


        self['PATH']            = self.path('usr/discreet/io/2015.3/bin/')
        self['LD_LIBRARY_PATH'] = self.path('usr/discreet/io/2015.3/bin/')

        self['PATH']            = self.path('usr/discreet/backburner/')

        self['PATH']            = self.path('usr/discreet/flamepremium_2015.3/bin/')
        self['LD_LIBRARY_PATH'] = self.path('usr/discreet/lib64/')
        self['LD_LIBRARY_PATH'] = self.path('usr/discreet/lib64/2015.3/')


        self['PYTHONHOME']      = self.path('usr/discreet/Python-2.6.9')
        self['PATH']            = self.path('usr/discreet/Python-2.6.9/bin/')
        self['LD_LIBRARY_PATH'] = self.path('usr/discreet/Python-2.6.9/lib/')




        self['DL_MSG_LEVEL'] = 'debug'
        self['DL_MSG_ECHO_TO_SHELL'] = 'debug'
        # DL_PYTHON_HOOK_PATH

    def bins(self):
        return [('flame','/usr/discreet/flamepremium_2015.3/bin/flamepremium_LINUX_2.6_x86_64')]

    # def license(self):
    #     self['RV_LICENSE_FILE'] = "/tmp/rv_license_%s.txt" % os.environ['USER']

    # def userSetup(self, jobuser):
    #     os.chdir( jobuser.pwd )

    # def runUserSetup(self, jobuser):
    #     return False
