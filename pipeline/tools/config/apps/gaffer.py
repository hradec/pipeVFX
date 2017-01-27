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


class gaffer(baseApp):
    # def versions(self):
    #     if self.parent()  in ["gaffer"]:
    #         pipe.libs.version.set( python='2.7.6' )
    #         pipe.version.set( python='2.7.6' )
    #         if float(pipe.version.get('gaffer')[:3]) >= 2.0:
    #             pipe.libs.version.set( cortex='9.0.0.git_Oct_10_2014' )
    #     elif self.parent()  in ["maya", "houdini", "nuke"]:
    #         if float(pipe.libs.version.get('python')[:3]) < 2.7:
    #             if float(pipe.version.get('gaffer')[:3]) >= 2.0:
    #                 pipe.version.set( gaffer='0.95.0')


    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        # gaffer can't inherit it's env vars from a call app, so we're forced to
        # clean then up here from os.environ to make sure!
        for each in filter(lambda x: 'GAFFER' in x, os.environ.keys()):
            del os.environ[each]

        pipe.libs.version.set( qt = '4.7.1' )
#        pipe.libs.version.set( python = '2.7.6' )

        for boostPython in  ['lib','lib/python%s' % pipe.libs.version.get('python')[:3]]:
            boostPython = "%s/libboost_python-mt.so" % pipe.libs.boost().path(boostPython)
            if os.path.exists(boostPython):
                self['LD_PRELOAD'] = boostPython
                break

        self['GAFFERUI_IMAGECACHE_MEMORY'] = '2000'

        self.update( python()  )
        self.update( cortex()  )
        self.update( delight() )
        self.insert( 'LD_LIBRARY_PATH', 0,  maya().path('support/openssl') )

        self['GAFFERUI_QT_BINDINGS'] = 'PyQt4'

        if self.parent() in ['maya']:
            if int(maya().version().split('.')[0]) < 2014:
                self['GAFFERUI_QT_BINDINGS'] = 'PySide'
                if hasattr( pipe.libs, 'pyside' ):
                    self.insert( 'LD_LIBRARY_PATH', 0,  pipe.libs.pyside().path('lib') )
                    self.insert( 'PYTHONPATHPATH', 0,  pipe.libs.pyside().path('lib/python$PYTHON_VERSION_MAJOR/site-packages') )

        if hasattr( pipe.libs, 'ocio' ):
#            self['LD_PRELOAD'] = pipe.libs.ocio().path('lib/libOpenColorIO.so.1')
            self.insert( 'LD_LIBRARY_PATH', 0,  pipe.libs.ocio().path('lib/python$PYTHON_VERSION_MAJOR/site-packages') )

        # our standard OCIO color space
        if self.parent() == "gaffer":
            self['OCIO'] = '/atomo/pipeline/tools/ocio/config.ocio'

        #add tools paths
        for each in self.toolsPaths():
            gaffer.addon(self,
                apps = [
                    '%s/gaffer/apps' % each,
                ],
                graphics = [
                    '%s/gaffer/graphics' % each,
                ],
                scripts = [
                    '%s/gaffer/python' % each,
                ],
                startups = [
                    '%s/gaffer/startup' % each,
                ],
            )

        # add main app and home paths!
        gaffer.addon(self,
                apps = [
                    self.path('apps'),
                ],
                graphics = [
                    self.path('graphics'),
                ],
                scripts = [
                    self.path('python'),
                ],
                startups = [
                    "%s/gaffer/startup/" % os.environ['HOME'],
                    self.path('startup'),
                ],
        )

        cortex.addon(self,
            procedurals = self.path('procedurals'),
            ops = self.path('ops'),
        )

    def runUserSetup(self, bin):
        ''' only create a user folder structure if it's the main gaffer app.'''
        return bin[0] == 'gaffer'

    @staticmethod
    def addon(caller, ops="", procedurals="", apps="", graphics="", scripts="", startups=""):
        caller['GAFFER_APP_PATHS'] = apps
        caller['GAFFERUI_IMAGE_PATHS'] = graphics
        caller['PYTHONPATH'] = scripts
        caller['GAFFER_STARTUP_PATHS'] = startups

    def bins(self):
        ''' we make our wrapper without the .py just to keep
            things more professional! lol '''
        return [
            ('gaffer','gaffer.py'),
#            ('op','gaffer.py op -gui 1'),
            ('opa','gaffer.py opa -gui 1'),
            ('browser','gaffer.py browser'),
        ]
