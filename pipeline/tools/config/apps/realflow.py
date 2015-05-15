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

class realflow(baseApp):
    def environ(self):
        self.p=python()
        self.update(cortex())
        self.update(gaffer())
        self['PYTHONHOME'] = self.p.path()
        self['PYTHONPATH'] = self.p.path('lib/python$PYTHON_VERSION_MAJOR')
        self['LD_PRELOAD'] = self.p.path('lib/libpython$PYTHON_VERSION_MAJOR.so.1.0')
        self['LD_PRELOAD'] = '/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/pyside/1.1.2/lib/libpyside-python$PYTHON_VERSION_MAJOR.so.1.1'
        self['RF_2012_PATH'] = self.path()
        
        
   
    def bins(self):
        return [('realflow', 'realflow.bin')]    
        
    def userSetup(self, jobuser):
        self['RFSCENESPATH'] = jobuser.path('realflow')


    def bin(self):
        return "env LD_LIBRARY_PATH=%s:$LD_LIBRARY_PATH  %s" % ( 
            self.p.path('lib/python$PYTHON_VERSION_MAJOR/lib-dynload'), self.path('bin') )
        
        


