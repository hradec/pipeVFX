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


class wine(baseApp):
    def environ(self):
        from sys import argv

        # disable cache by specifying --nocache on the command line!
        # usefull to configure default settings for wine apps
        if '--nocache' in argv:
            self['NOCACHE']='1'
            del argv[argv.index('--nocache')]

        # this is a NVidia var. It disables VBLANK, which
        # seems to make opengl apps more stable under wine.
        self['__GL_SYNC_TO_VBLANK'] = '0'

        # we need to set this to force wine to use our wine instead
        # of system wine, if it needs to spaw another process.
        self['WINELOADER'] = self.path('bin/wine')

        # check if wacon is attached
        if wacom():
            # if not, disables wintab32, so wine won't show up
            # the annoying wintab warning dialog!
            self['WINEDLLOVERRIDES'] = 'wintab32=n'

    def versions(self):
        if os.environ.has_key('WINE_VERSION'):
            pipe.version.set( wine = os.environ['WINE_VERSION'] )

    @staticmethod
    def username():
        return os.popen("run wine 'cmd /c echo %USERNAME%'").readlines()[0].strip()

    @staticmethod
    def cachePrefix(p):
        ''' A static method to return the cache version of a wine prefix
        This can be called by other app classes if they need to edit
        the wine local cache in some way! '''
#        return '/tmp/pipe_%s/%s' % ( os.environ['USER'], p.split('apps/')[1])
        return '%s/wine/cache/%s/' % ( os.environ['HOME'], p.split('apps/')[1])

    def localCache(self, binFullName):
        # we must have a local copy since wine needs the files
        # owned by the user
        from glob import glob
        import shutil

        if os.environ.has_key('WINEPREFIX'):
            prefixFrom = os.environ['WINEPREFIX']
            if '/apps/' in prefixFrom and 'NOCACHE' not in os.environ:
                if not os.environ.has_key('WINEDEBUG'):
                    os.environ['WINEDEBUG'] = ''
                os.environ['WINEDEBUG'] = '-all,%s' % os.environ['WINEDEBUG']
                prefix = wine.cachePrefix(prefixFrom)

                # we make a global windows users folder in ~/wine
                # to be shared by all wine apps
                # this way the user can have itś own settings for windows apps
                # locally saved
                wineHome = '%s/wine/users' % os.environ['HOME']
                if not os.path.exists(wineHome):
                    os.makedirs(wineHome)

                # we create the local cache for the current WINEPREFIX
                # inside ~/wine/cache, as returned by wine.prefix()
                if not os.path.exists('%s/drive_c' % prefix):
                    os.makedirs('%s/drive_c' % prefix)
                if not os.path.exists('%s/bin' % prefix):
                    os.makedirs('%s/bin' % prefix)
                dontSymlink = ['bin','dosdevices']
                for each in glob('%s/*' % prefixFrom):
                    beach = os.path.basename( each )
                    if not os.path.exists('%s/%s' % (prefix, beach)):
                        if os.path.isfile(each):
                            shutil.copy2( each, '%s/%s' % (prefix, beach) )
                        elif os.path.isdir(each) and beach not in dontSymlink:
                             os.symlink(each, '%s/%s' % (prefix, beach) )

                # make a symlink in this cache to our global users folder in ~/wine/users
                if not os.path.exists('%s/drive_c/users' % prefix):
                    os.symlink(wineHome, '%s/drive_c/users' % prefix)

                # we control the exposed paths to wine here
                # c: as drive_c
                # j: as atomo/jobs
                # h: as unix home folder
                if os.path.exists('%s/dosdevices' % prefix):
                    shutil.rmtree( '%s/dosdevices' % prefix)
                wineTMP = '/tmp/wine_tmp_%s' % os.environ['USER']
                if not os.path.exists(wineTMP):
                    os.makedirs(wineTMP)
                os.makedirs('%s/dosdevices' % prefix)
                os.symlink('%s/drive_c' % prefix, '%s/dosdevices/c:' % prefix)
                os.symlink( pipe.roots().jobs(), '%s/dosdevices/j:' % prefix)
                os.symlink('/mnt', '%s/dosdevices/m:' % prefix)
                os.symlink(os.environ['HOME'], '%s/dosdevices/h:' % prefix)
                os.symlink(wineTMP, '%s/dosdevices/z:' % prefix)

                # cache everything in "c:/Program Files" as symlink
                # if one is not already there.
                progFiles = '%s/drive_c/Program Files/' % prefix
                if not os.path.exists(progFiles):
                    os.makedirs(progFiles)
                for each in glob('%s/drive_c/Program Files/*' % prefixFrom):
                    beach = os.path.basename( each )
                    if not os.path.exists(progFiles+beach):
                        os.symlink(each, progFiles+beach)

                # cache windows folder as symlink
                win = '%s/drive_c/windows/' % prefix
                if not os.path.exists(win):
                    os.makedirs(win)
                copy = ['system32']
                for each in glob('%s/drive_c/windows/*' % prefixFrom):
                    beach = os.path.basename( each )
                    if not os.path.exists( win+beach ):
                        if beach not in copy:
                            os.symlink( each, win+beach )
                        else:
                            shutil.copytree( each, win+beach, True )

                # fix binFullName to the local cache
                binFullName = binFullName.replace(os.environ['WINEPREFIX'], prefix)

                # point WINEPREFIX to the local cache as well
                os.environ['WINEPREFIX'] = prefix

                # we need to preload wineserver here or else
                # wine will load the system one!
                binFullName = '%s/bin/wineserver -d 3 -k -p1 \n ' % self.path() + binFullName

                # now return the local cache binFullName
                log.debug( 'cached binary path name: %s' % binFullName )
        return  binFullName

    def bins(self):
        return [('wine', 'wine')]

    def extraCommandLine(self, binName):

        # add this for vglrun since wine uses
        # 32bit opengl libraries, we need to sign
        # virtualGL to intercept 32 bit opengl libs
        return ['-32']
