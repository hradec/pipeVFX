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


class pftrack(baseApp):
    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''
            
#        self['FGL_DYNAMIC_TEXIMAGE'] = '1'
#        self['MALLOC_CHECK_'] = '0'

        self['PYTHONPATH'] = self.path('lib')
       
        self['PIXELFARM_SYS_DIR'] = self.path()
        self['PIXELFARM_KEEP_PYTHONPATH'] = '1'
        self['PIXELFARM_SPLASH_DURATION'] = '0'        
#        self['PF_DATA_HOME'] = self.path()
