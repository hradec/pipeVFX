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

class photoshop(baseApp):
    def environ(self):
        self['__GL_ALWAYS_HANDLE_FORK'] = '1'
        self['__GL_SYNC_TO_VBLANK'] = '0'

        # this disables tablet support!!
        # self['WINEDLLOVERRIDES'] = ';'.join([
        #    'gdiplus=n',
        #    'odbcint=n',
        #    'odbcint=n',
        #    'msvcr100=n',
        #    'msvcr80=n',
        #    'msvcr90=n',
        #    'msxml3=n',
        #    'msxml6=n',
        # ])

    def versions(self):
#        pipe.version.set( wine = '1.3.33' )
        pipe.version.set( wine = '1.5.29.photoshopMouseFix' )
        pass

    def localCache(self, binFullName):

        # get username according to wine interpretation
        wineUsername =  wine.username()

        # now copy our default user files from the installation to the user folder
        user = '%s/wine/users/%s' % ( os.environ['HOME'], wineUsername )
        public = '%s/wine/users/Public' % os.environ['HOME']
        cacheprefix = wine.cachePrefix(self.path())
        cache.copytree( '%s/drive_c/users/600' % self.path(), user, fileToCheck='%s/Templates' % user )
        cache.copytree( '%s/drive_c/users/Public' % self.path(), public, fileToCheck='%s/Templates' % public )

        # progFilesFrom = '%s/drive_c/Program Files/Common Files' % self.path()
        # progFiles = '%s/drive_c/Program Files/Common Files' % prefix
        # makedirs(os.path.dirname(progFiles))
        # makedirs('%s/drive_c/temp' % prefix)
        # copytree( progFilesFrom, progFiles )
        #
        # usersPublicFrom = '%s/drive_c/users/Public/Application Data' % self.path()
        # usersPublic = '%s/wine/users/Public/Application Data' % os.environ['HOME']
        # rmtree( "%s/Adobe" % usersPublic)
        # rmtree( "%s/Adobe-BackupByPhotoshopCS6Portable" % usersPublic)
        # makedirs(usersPublic)
        # os.symlink( "%s/Adobe" % usersPublicFrom, "%s/Adobe" % usersPublic )
        # os.symlink( "%s/Adobe-BackupByPhotoshopCS6Portable" % usersPublicFrom,
        #            "%s/Adobe-BackupByPhotoshopCS6Portable" % usersPublic )

        return binFullName
