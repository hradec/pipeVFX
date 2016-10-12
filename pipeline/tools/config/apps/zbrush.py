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

class zbrush(baseApp):
    def environ(self):
#        self['__GL_ALWAYS_HANDLE_FORK'] = '1' 
        self['__GL_SYNC_TO_VBLANK'] = '0'
        
        
    def versions(self):
#        pipe.version.set( wine = '1.4' )
        pipe.version.set( zbrush = '4.0.r4' )
    
'''    def localCache(self, binFullName):
        # we use this method just to make some a writable ZStartup
        # folder in the user home folder wine cache
        from glob import glob
        import shutil
        prefix = wine.cachePrefix(self.path())
        progFiles = '%s/drive_c/Program Files/' % prefix
        pixologic = '%sPixologic/' % progFiles
        zbrush = os.path.basename(glob( "%s/drive_c/Program Files/Pixologic/*" % self.path() )[0])+'/'
        
        # make a local copy of zbrush with symlinks to all folders but ZStartup.
        # zbrush needs to be able to write to ZStartup folder for some stupid reason!
        # Isn't ProgramFiles supposed to be writeable only by Administrators in real windows?
        # if so, how normal users can run zbrush at all?
        if not os.path.exists(pixologic+zbrush):
            os.makedirs(pixologic+zbrush)
        copyFolders = ['ZStartup', 'ZScripts']
        for each in glob( '%s/drive_c/Program Files/Pixologic/%s/*' % (self.path(), zbrush) ):
            beach = os.path.basename(each)
            if not os.path.exists(pixologic+zbrush+beach):
                if beach not in copyFolders:
                    os.symlink( each, pixologic+zbrush+beach )
                else:
                    shutil.copytree( each, pixologic+zbrush+beach, True )
        
        return binFullName
'''
