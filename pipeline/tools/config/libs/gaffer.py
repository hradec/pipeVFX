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


class gaffer(baseLib):

    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        # self.ignorePipeLib( "freetype" )

        # self['PYTHONPATH'] = pipe.libs.python.path('lib/python$PYTHON_VERSION_MAJOR/site-packages')
        self['PYTHONPATH'] = self.path('python')

        if self.parent() not in ['maya']:
            # gaffer can't inherit it's env vars from a call app, so we're forced to
            # clean then up here from os.environ to make sure!

            for each in filter(lambda x: 'GAFFER' in x, os.environ.keys()):
                del os.environ[each]

            # if hasattr( pipe.libs, 'ocio' ):
            #     # self['LD_PRELOAD'] = pipe.libs.ocio().path('lib/libOpenColorIO.so.1')
            #     self['LD_PRELOAD'] = pipe.latestGCCLibrary("libstdc++.so.6")
            #     self['LD_PRELOAD'] = pipe.latestGCCLibrary("libgcc_s.so.1")
            #     self.insert( 'LD_LIBRARY_PATH', 0,  pipe.libs.ocio().path('lib/python$PYTHON_VERSION_MAJOR/site-packages') )

            # our standard OCIO color space
            if self.parent() in ["gaffer", 'maya', 'houdini']:
                self['OCIO'] = '%s/ocio/config.ocio' % pipe.roots().tools()

        # add all versions of OIIO libraries to search path
        for each in cached.glob( "%s/*" % os.path.dirname(pipe.libs.oiio().path()) ):
            self['LD_LIBRARY_PATH'] = '%s/lib/' % each

        self['GAFFERUI_IMAGECACHE_MEMORY'] = '2000'
        if pipe.versionMajor(self.version())>0.5 and pipe.versionMajor(self.version())<2.0:
            # gaffer 0.55 and up is using PySide2, because Maya2018
            self['GAFFERUI_QT_BINDINGS'] = 'PySide2'
        # else:
        #     # any other version (old gaffer), uses PyQt4
        #     self['GAFFERUI_QT_BINDINGS'] = 'PyQt4'

        if self.parent() in ['maya']:
            if int(pipe.apps.version.get('maya').split('.')[0]) < 2014:
                self['GAFFERUI_QT_BINDINGS'] = 'PySide'
                if hasattr( pipe.libs, 'pyside' ):
                    self.insert( 'LD_LIBRARY_PATH', 0,  pipe.libs.pyside().path('lib') )
                    self.insert( 'PYTHONPATHPATH', 0,  pipe.libs.pyside().path('lib/python$PYTHON_VERSION_MAJOR/site-packages') )

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
                shaders = [
                    "%s/gaffer/shaders/" % each,
                    "%s/osl/shaders/" % each,
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
                shaders = [
                    "%s/gaffer/shaders/" % os.environ['HOME'],
                    self.path('shaders'),
                    self.path('shaders/'),
                ],
        )

        cortex.addon(self,
            procedurals = self.path('procedurals'),
            ops = self.path('ops'),
            glsl = self.path('glsl'),
        )

        pipe.apps.prman.addon(self,
            display = self.path( "renderMan/displayDrivers" ),
        	procedurals = self.path( "renderMan/procedurals" ),
            shader = self.path( "shaders" ),
        )

        self['OSLHOME'] = self.path()
        self['QT_QWS_FONTDIR'] = self.path('fonts')
        self['QT_QPA_FONTDIR'] = self.path('fonts')


        self.update( pipe.apps.arnold() )
        pipe.apps.arnold.addon( self,
            plugins = self.path('arnold/$ARNOLD_VERSION_MAJOR/arnoldPlugins'),
        )
        gaffer.addon(self,
            libs = self.path('arnold/$ARNOLD_VERSION_MAJOR/lib'),
            scripts = self.path('arnold/$ARNOLD_VERSION_MAJOR/python'),
            startups = self.path('arnold/$ARNOLD_VERSION_MAJOR/startup'),
        )


        if self.parent() in ['gaffer','python']:
            # if os.path.exists(self.path("lib/libtbb.so.2")):
            #     self['LD_PRELOAD'] = self.path("lib/libtbb.so.2")
            # else:
            #     self['LD_PRELOAD'] = pipe.libs.tbb().path("lib/libtbb.so.2")

            # preload Qt
            # for each in cached.glob(pipe.libs.qt().path("lib/*.so*")):
            #     if os.path.isfile(each):
            #         self['LD_PRELOAD'] = each

            self.update( top=pipe.libs.pyside() )
            self.update( pipe.apps.python() )

            # hack to enable renderman in gaffer!
            self['DELIGHT'] = '0'

            # self['LD_PRELOAD'] = pipe.libs.ocio().LD_PRELOAD()
            # self['LD_PRELOAD'] = pipe.libs.oiio().LD_PRELOAD()
            self['LD_PRELOAD'] = pipe.libs.qt().LD_PRELOAD()

            self['GAFFER_JEMALLOC'] = '0'




    # def runUserSetup(self, bin):
    #     ''' only create a user folder structure if it's the main gaffer app.'''
    #     return bin[0] in ['gaffer', 'bundle']

    @staticmethod
    def addon(caller, ops="", procedurals="", apps="", graphics="", scripts="", startups="", shaders="", libs=""):
        caller['GAFFER_APP_PATHS'] = apps
        caller['GAFFERUI_IMAGE_PATHS'] = graphics
        caller['PYTHONPATH'] = scripts
        caller['GAFFER_STARTUP_PATHS'] = startups
        caller['OSL_SHADER_PATHS'] = shaders
        caller['LD_LIBRARY_PATH'] = libs

    def bins(self):
        ''' we make our wrapper without the .py just to keep
            things more professional! lol '''
        gaffer_bin = 'gaffer.py'
        if self.path('bin/gaffer'):
            gaffer_bin = 'gaffer'

        return [
            ['gaffer',  gaffer_bin],
            ['opa',     gaffer_bin+' opa -gui 1'],
            ['browser', gaffer_bin+' browser'],
            ['sam',     gaffer_bin+' sam'],
            ['bundle',  gaffer_bin+' test'],
        ]


    def bg(self, cmd, bin):
        ''' return True if a cmd or binary should run in background '''
        return True
