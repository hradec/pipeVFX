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



class cmake(baseLib):
    def environ(self):
        self['PYTHONPATH'] = self.path('python')
        self.update( pipe.apps.python() )
        for lib in [ x for x in dir( pipe.libs ) if '__' not in x and 'all' not in x ]:
            try:
                self.update( eval( "pipe.libs.%s()" % lib ) )
            except: pass

    def bins(self):
        return [
            ('cmake','cmake'),
            ('make','make'),
        ]

    def preRun(self, cmd):
        os.environ['PATH'] = ':'.join([ pipe.build.gcc(), os.environ['PATH'] ])
        os.environ['LIBRARY_PATH'] = os.environ['LD_LIBRARY_PATH']
        os.environ['CC'] = pipe.build.gcc()+'/gcc'
        os.environ['CXX'] = pipe.build.gcc()+'/g++'
