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

    
class prman(baseApp):
    def environ(self):
        
        self['DL_DUMP_DEFAULTS'] = '1'
        self['SHADERS_PATH'] = self.path('shaders')
        self['TEXTURES_PATH'] = self.path('examples/textures')
        self['DISPLAYS_PATH'] = self.path('displays')
        
    def addon( caller, plugin='', script='' ):
        if script:
            self['PROCEDURALS_PATH'] = script
    
    def bins(self):
        return [
            ('prman', 'prman'),
            ('shader', 'shader'),
            ('sho', 'sho'),
        ]

class rmanstudio(baseApp):
    def environ(self):
        
        self['DL_DUMP_DEFAULTS'] = '1'
        self['SHADERS_PATH'] = self.path('shaders')
        self['TEXTURES_PATH'] = self.path('examples/textures')
        self['DISPLAYS_PATH'] = self.path('displays')
        
    def addon( caller, plugin='', script='' ):
        if script:
            self['PROCEDURALS_PATH'] = script
    
    def bins(self):
        return []

