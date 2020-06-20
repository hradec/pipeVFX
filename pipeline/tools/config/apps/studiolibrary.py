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


class studiolibrary(baseApp):

    def environ(self):
        self['PYTHONPATH'] = self.path('src/')
        maya.addon( self, script = self.path('src/') )


    def startup(self):
        if self.parent() in ['maya']:
            job = pipe.admin.job.current()
            shot = pipe.admin.job.shot.current()

            userLib = os.path.abspath("%s/studiolibrary/" % os.environ["HOME"])
            if not os.path.exists(userLib):
                os.makedirs(userLib)

            shotShared = os.path.abspath(shot.path("/published/studiolibrary/"))
            if not os.path.exists(shotShared):
                os.makedirs(shotShared)

            jobShared = os.path.abspath(job.path("/ARTWORKS/studiolibrary/"))
            if not os.path.exists(jobShared):
                os.makedirs(jobShared)

            globalShared = os.path.abspath("%s/../studiolibrary/" % pipe.roots.tools())

            import studiolibrary
            import assetUtils
            class studioLibraryShelf(assetUtils.shelf):
                def __init__(self):
                    super(studioLibraryShelf, self).__init__('StudioLibrary')
                    self.addShelfButton(
                        '',
                        'Global Shared Library',
                        cmd='import studiolibrary;studiolibrary.main(name="Global Shared Library", path="%s" )' % globalShared,
                        icon='/atomo/pipeline/tools/maya/icons/slglobal.bmp',
                        # menu=[('RELOAD SHELF', 'import pipe;reload(pipe.apps);pipe.apps.studiolibrary().startup()')]
                    )
                    self.addShelfButton(
                        '',
                        'Job Shared Library',
                        cmd='import studiolibrary;studiolibrary.main(name="Job Shared Library", path="%s" )' % jobShared,
                        icon='/atomo/pipeline/tools/maya/icons/sljob.bmp',
                        # menu=[('RELOAD SHELF', 'import pipe;reload(pipe.apps);pipe.apps.studiolibrary().startup()')]
                    )
                    self.addShelfButton(
                        '',
                        'Shot/Asset Shared Library',
                        cmd='import studiolibrary;studiolibrary.main(name="Shot/Asset Shared Library", path="%s" )' % shotShared,
                        icon='/atomo/pipeline/tools/maya/icons/slshot.bmp',
                        # menu=[('RELOAD SHELF', 'import pipe;reload(pipe.apps);pipe.apps.studiolibrary().startup()')]
                    )
                    self.addShelfButton(
                        '',
                        'Global User Library',
                        cmd='import studiolibrary;studiolibrary.main(name="Global User Library", path="%s" )' % userLib,
                        icon='/atomo/pipeline/tools/maya/icons/sluser.bmp',
                        # menu=[('RELOAD SHELF', 'import pipe;reload(pipe.apps);pipe.apps.studiolibrary().startup()')]
                    )
                    self.create()
            studioLibraryShelf()
