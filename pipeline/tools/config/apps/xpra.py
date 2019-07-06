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


class xpra(baseApp):
    def versions(self):
        pipe.version.set( python='2.7.6' )
        pipe.libs.version.set( python='2.7.6' )
    def environ(self):
        self.forcePython = True

        self.ignorePipeLib( "freetype" )

        self['XPRA_UI_THREAD_POLLING']='1'
        self['XPRA_SOCKET_TIMEOUT']='10000'

        p = python()
        self['PYTHONPATH'] = p.path("lib/python$PYTHON_VERSION_MAJOR/")
        self['PYTHONPATH'] = p.path("lib/python$PYTHON_VERSION_MAJOR/site-packages/")

        self['PYTHONPATH'] = self.path("lib64/python/")
        self['PYTHONPATH'] = self.path("lib64/python/site-packages/")
        self['PYTHONPATH'] = self.path("lib64/python$PYTHON_VERSION_MAJOR/")
        self['PYTHONPATH'] = self.path("lib64/python$PYTHON_VERSION_MAJOR//site-packages/")
        if self.parent() == 'xpra':
            # self['PYTHONPATH'] = '/usr/lib/python2.7/dist-packages/'
            # self['PYTHONPATH'] = '/usr/lib/pymodules/python2.7/'
            # self['PYTHONPATH'] = '/usr/lib64/python2.7/site-packages/'
            # self['PYTHONPATH'] = '/usr/lib64/python2.7'
            self['PYTHONPATH'] = self.path('lib64/python2.7/site-packages')
            self['PYTHONPATH'] = '/usr/lib64/python2.7/site-packages'
            self['PYTHONPATH'] = '/usr/lib64/python2.7/site-packages/gtk-2.0'
            self['PYTHONPATH'] = '/usr/lib64/python2.7/site-packages/gtk-2.0/gtk'

            self['PYTHONPATH'] = '/usr/lib/python2.7/site-packages/gtk-2.0'
            self['PYTHONPATH'] = '/usr/lib/python2.7/dist-packages/gtk-2.0'

    def bins(self):
        return [('xpra', 'xpra')]
