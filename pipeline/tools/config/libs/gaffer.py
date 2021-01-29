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
    def versions(self):
        if self.parent()  in ["gaffer"]:
            pipe.libs.version.set( python='2.7.6' )
            pipe.version.set( python='2.7.6' )
            if float(pipe.libs.version.get('gaffer')[:4]) >= 0.55:
                pipe.libs.version.set( cortex='10.0' )
                pipe.libs.version.set( boost='1.61.0' )
                pipe.libs.version.set( oiio='2.0.11' )
                pipe.libs.version.set( tbb='2019_U9' )
            # if float(pipe.version.get('gaffer')[:3]) >= 2.0:
            #     pipe.libs.version.set( cortex='9.0.0.git_Oct_10_2014' )
#        elif self.parent()  in ["maya", "houdini", "nuke"]:
#            if float(pipe.libs.version.get('python')[:3]) < 2.7:
#                if float(pipe.version.get('gaffer')[:3]) >= 2.0:
#                    pipe.version.set( gaffer='0.95.0')
        # fix a wrong gaffer version
        # if float(pipe.version.get('gaffer')[:3]) == 2.0:
        #     pipe.version.set( gaffer='0.31')
        #     pipe.libs.version.set( gaffer='0.31')


    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        # self.ignorePipeLib( "freetype" )

        self['PYTHONPATH'] = python().path('lib/python$PYTHON_VERSION_MAJOR/site-packages')
        self['PYTHONPATH'] = self.path('python')

        if self.parent() not in ['maya']:
            # gaffer can't inherit it's env vars from a call app, so we're forced to
            # clean then up here from os.environ to make sure!

            for each in filter(lambda x: 'GAFFER' in x, os.environ.keys()):
                del os.environ[each]

            if hasattr( pipe.libs, 'ocio' ):
                # self['LD_PRELOAD'] = pipe.libs.ocio().path('lib/libOpenColorIO.so.1')
                self['LD_PRELOAD'] = pipe.latestGCCLibrary("libstdc++.so.6")
                self['LD_PRELOAD'] = pipe.latestGCCLibrary("libgcc_s.so.1")
                self.insert( 'LD_LIBRARY_PATH', 0,  pipe.libs.ocio().path('lib/python$PYTHON_VERSION_MAJOR/site-packages') )

            # our standard OCIO color space
            if self.parent() in ["gaffer", 'maya', 'houdini']:
                self['OCIO'] = '/atomo/pipeline/tools/ocio/config.ocio'

        self.update( pipe.libs.openvdb() )
        self.update( pipe.libs.qtpy() )

        # add all versions of OIIO libraries to search path
        for each in glob.glob( "%s/*" % os.path.dirname(pipe.libs.oiio().path()) ):
            # print each
            self['LD_LIBRARY_PATH'] = '%s/lib/' % each

        if self.parent() in ['gaffer']:
            self.update( pipe.libs.python() )
            self.update( pipe.apps.prman() )
            self.update( pipe.libs.cortex() )
            self.update( pipe.libs.appleseed() )
            self.update( pipe.libs.alembic() )
            # self.update( maya() )

            # hack to enable renderman in gaffer!
            self['DELIGHT'] = '1'
            # self.update( maya() )
            # self.ignorePipeLib( "qt" )

            for boostPython in  ['lib','lib/python%s' % pipe.libs.version.get('python')[:3]]:
                boostPython = "%s/libboost_python-mt.so" % pipe.libs.boost().path(boostPython)
                if os.path.exists(boostPython):
                    self['LD_PRELOAD'] = boostPython


        self['GAFFERUI_IMAGECACHE_MEMORY'] = '2000'
        if pipe.versionMajor(self.version())>0.5 and pipe.versionMajor(self.version())<2.0:
            # gaffer 0.55 and up is using PySide2, because Maya2018
            self['GAFFERUI_QT_BINDINGS'] = 'PySide2'
        else:
            # any other version (old gaffer), uses PyQt4
            self['GAFFERUI_QT_BINDINGS'] = 'PyQt4'


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

    # def runUserSetup(self, bin):
    #     ''' only create a user folder structure if it's the main gaffer app.'''
    #     return bin[0] in ['gaffer', 'bundle']

    @staticmethod
    def addon(caller, ops="", procedurals="", apps="", graphics="", scripts="", startups="", shaders=""):
        caller['GAFFER_APP_PATHS'] = apps
        caller['GAFFERUI_IMAGE_PATHS'] = graphics
        caller['PYTHONPATH'] = scripts
        caller['GAFFER_STARTUP_PATHS'] = startups
        caller['OSL_SHADER_PATHS'] = shaders

    def bins(self):
        ''' we make our wrapper without the .py just to keep
            things more professional! lol '''
        return [
            ('gaffer','gaffer.py'),
            ('opa','gaffer.py opa -gui 1'),
            ('browser','gaffer.py browser'),
            ('sam','gaffer.py sam'),
            ('bundle','gaffer.py test'),
        ]

    def bg(self, cmd, bin):
        ''' return True if a cmd or binary should run in background '''
        return True
