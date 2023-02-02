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
        ''' set the pipe python version according to houdinis python version '''
        if self.parent() in ['gaffer']:
            gv = pipe.libs.version.get( 'gaffer' )
            if pipe.versionBiggerEqualThan( gv, '1.1.0.0'):
                # default libraries set
                pipe.version.set( python = '3.9.7' )
                pipe.libs.version.set( python = '3.9.7' )
                pipe.libs.version.set( cortex = '10.4.2.1' )
                # if self.parent in ['maya']:
                #     pipe.version.set( python = '3.9.7' )
                #     pipe.libs.version.set( python = '3.9.7' )
                # else:
                #     pipe.version.set( python = '3.7.5' )
                #     pipe.libs.version.set( python = '3.7.5' )
                pipe.libs.version.set( openexr = '2.4.1' )
                pipe.libs.version.set( usd = '21.11.1' )
                pipe.libs.version.set( usd_non_monolithic = '21.11.1' )
                pipe.libs.version.set( boost = '1.76.0' )
                if pipe.versionBiggerEqualThan( gv, '1.1.7.0'):
                    pipe.apps.version.set( arnold = '7.1.4.1' )
                else:
                    pipe.apps.version.set( arnold = '7.1.3.2' )
            else:
                pipe.version.set( python = '2.7' )
                pipe.libs.version.set( python = '2.7' )
                pipe.libs.version.set( openexr = '2.4.0' )
                pipe.libs.version.set( openvdb = '8.2.0' )
                pipe.libs.version.set( boost = '1.66.0' )

    def vglrun(self, vglrun_cmd ):
        ''' adjust the vglrun command line when running on a remote connection '''
        return vglrun_cmd + ' -nodl '

    def environ(self):
        ''' as this is a python application, we don't have to setup anything
            since python is already setting it for us! '''

        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        self.ignorePipeLib( "freetype" )

        self['PYTHONPATH'] = self.path('python')

                # if self.parent() not in ['maya']:
        #     # gaffer can't inherit it's env vars from a call app, so we're forced to
        #     # clean then up here from os.environ to make sure!
        #     for each in filter(lambda x: 'GAFFER' in x, os.environ.keys()):
        #         del os.environ[each]

        # our standard OCIO color space
        self.update( pipe.libs.ocio() )
        self.update( pipe.libs.cuda() )
        self.update( pipe.libs.cycles() )

        # if hasattr( pipe.apps, 'LDTGaffer' ):
        #     self.update( pipe.apps.LDTGaffer() )

        # add all versions of OIIO libraries to search path
        if hasattr(pipe.libs, 'oiio'):
            for each in cached.glob( "%s/*" % os.path.dirname(pipe.libs.oiio().path()) ):
                self['LD_LIBRARY_PATH'] = '%s/lib/' % each

        self['GAFFERUI_IMAGECACHE_MEMORY'] = '2000'
        if pipe.versionMajor(self.version())>0.5 and pipe.versionMajor(self.version())<2.0:
            # gaffer 0.55 and up is using PySide2, because Maya2018
            self['GAFFERUI_QT_BINDINGS'] = 'PySide2'
        # else:
        #     # any other version (old gaffer), uses PyQt4
        #     self['GAFFERUI_QT_BINDINGS'] = 'PyQt4'

        if self.parent() in ['gaffer']:
            self['PYTHONHOME'] = pipe.libs.python().path()

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
                    '%s/gaffer/python/nodes' % each,
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

        self.update( pipe.libs.cortex() )
        cortex.addon(self,
            procedurals = self.path('procedurals'),
            ops = self.path('ops'),
            glsl = self.path('glsl'),
        )

        if hasattr(pipe.apps, 'prman'):
            pipe.apps.prman.addon(self,
                display = self.path( "renderMan/displayDrivers" ),
            	procedurals = self.path( "renderMan/procedurals" ),
                shader = self.path( "shaders" ),
            )

        self['OSLHOME'] = self.path()
        self['QT_QWS_FONTDIR'] = self.path('fonts')
        self['QT_QPA_FONTDIR'] = self.path('fonts')

        # plugins
        if hasattr( pipe.libs, 'gaffer_cycles'):
            self.update( pipe.libs.gaffer_cycles() )
        if hasattr( pipe.libs, 'gaffer_heaven'):
            self.update( pipe.libs.gaffer_heaven() )

        if hasattr( pipe.apps, 'arnold'):
            self.update( pipe.apps.arnold() )
            gaffer.addon(self,
                libs = self.path('arnold/$ARNOLD_VERSION_MAJOR/lib'),
                scripts = self.path('arnold/$ARNOLD_VERSION_MAJOR/python'),
                startups = self.path('arnold/$ARNOLD_VERSION_MAJOR/startup'),
            )
            if self.parent() in ['gaffer','python']:
                pipe.apps.arnold.addon( self,
                    plugins = self.path('arnold/$ARNOLD_VERSION_MAJOR/arnoldPlugins'),
                )

        # adjustments to the environment
        if self.parent() in ['gaffer','python']:
            self.update( top=pipe.libs.pyside() )
            self.update( pipe.apps.python() )
            # hack to enable renderman in gaffer!
            self['DELIGHT'] = '0'
            # self['LD_PRELOAD'] = pipe.libs.ocio().LD_PRELOAD()
            # self['LD_PRELOAD'] = pipe.libs.oiio().LD_PRELOAD()
            self['LD_PRELOAD'] = pipe.libs.qt().LD_PRELOAD()

            # set jemalloc for gaffer
            self['GAFFER_JEMALLOC'] = '0'
            # self['LD_PRELOAD'] = pipe.libs.jemalloc().LD_PRELOAD()

        # to enable cycles
        if self.path('lib/libGafferUSD.so'):
            self['GAFFERCYCLES_FEATURE_PREVIEW'] = '1'
            # $CYCLES_ROOT/$(ldd  $GAFFER_ROOT/lib/libGafferUSD.so  | grep -i usd | awk '{print $(NF-1)}' | awk -F'/' '{print $(NF-2)"-usd."$(NF-3)"-gaffer."}' | sort | uniq)$GAFFER_VERSION/
            self['CYCLES_TARGET_FOLDER'] = ''.join([
                pipe.libs.cycles().path(),
                '/',
                cached.popen('''ldd  %s  | grep -i usd | awk '{print $(NF-1)}' | awk -F'/' '{print $(NF-2)"-usd."$(NF-3)"-gaffer."}' | sort | uniq''' % self.path('lib/libGafferUSD.so')).readlines()[0].strip(),
                self.version().strip(),
            ]).replace(' ','').strip()
            self['GAFFERCYCLES'] = '1'

        # self['LD_PRELOAD'] = pipe.LD_PRELOAD.latestGCCLibrary("libstdc++.so.6")
        # self['LD_PRELOAD'] = pipe.LD_PRELOAD.latestGCCLibrary("libgcc_s.so.1")

        # workaround to avoid loading mesa llvm
        self['LIBGL_ALWAYS_INDIRECT'] = '1'



    def preRun(self, cmd):
        os.environ['CYCLES_ROOT'] = self['CYCLES_TARGET_FOLDER']
        # # workaround to avoid loading mesa llvm
        # os.environ['LIBGL_ALWAYS_INDIRECT'] = '1'

        # os.environ['PATH'] = self.path('bin')+':'+os.environ['PATH']


        # if running the gaffer wrapper, add /bin/bash to the command line
        # this fixes running with gdb!
        new = []
        for each in cmd.split(' '):
            if 'bin/gaffer' in each[-12:]:
                new += ['/bin/bash']
            new += [each]
        return ' '.join(new)


    def postRun(self, cmd, ret, returnLog=''):
        import glob
        images = []
        error = False
        logError = False

        if 'execute' in cmd:
            # grab images from log for checking
            if 'writing file' in returnLog:
                # collect image files from output log
                images += [ z.split('writing file')[-1].replace('`','').replace("'",'').strip() for z in returnLog.split('\n') if 'writing file' in z ]

                # run our pipe.frame.check generic frame check for the gathered image list
                if images:
                    error = pipe.frame.check( images )

                    # move rendered frames to asset, if this render is an asset!
                    if not error:
                        if not self.asset:
                            # If we dont have an asset, try figure it out from the maya scene path
                            # find maya scene file
                            assetPath = None
                            for each in cmd.split(' '):
                                each = each.replace('"','')
                                if os.path.splitext(each.lower())[-1] in ['.mb','.ma']:
                                    assetPath = each
                                    break
                            if assetPath:
                                pipe.frame.publish( images, assetPath ) #, returnLog )
                        else:
                            # if we have an asset reference already, use it!
                            pipe.frame.publish( images, self.asset )

        # if images are broken, fail right away
        if  error:
            print('ERROR: At least one of the rendered images is broken. Render failed!' % ret)
            ret = -1

        # if no images or images are ok, check log for errors
        else:
            # only fail if no images where generated
            if not images:
                errors = [
                ]
                if returnLog:
                    for s in errors:
                        if s in str(returnLog):
                            logError = True
                            ret = -1
                            for line in [ x for x in str(returnLog).split('\n') if s in x ]:
                                print( '[ SOFT   ERROR ] - caused by: "'+line+'"' )
                            break

            # fatal errors - must fail even if images were generated!!
            # theses errors cause the rendered image to be wrong.
            fatalErrors = [
                'ERROR : gaffer execute',
            ]
            for s in fatalErrors:
                if s in str(returnLog):
                    logError = True
                    ret = -1
                    for line in [ x for x in str(returnLog).split('\n') if s in x ]:
                        print( '[ FATAL  ERROR ] - caused by: "'+line+'"' )
                    break

        # if no logError, and running gaffer gui, throw a WARNING informing
        # a wrong segfault, but return 0
        if self.parent() in ['gaffer'] and not logError:
            if ret != 0:
                print('WARNING: Gaffer exited with error code %d, but due to some segfaults caused by Arnold, we have to assume return code 0 or else renders will fail!' % ret)
                ret = 0

        return ret

    def runUserSetup(self, bin):
        ''' only create a user folder structure if it's the main gaffer app.'''
        ret = bin[0] in ['gaffer', 'bundle']
        if self.parent() in ['gaffer']:
            ret = True
        return ret

    @staticmethod
    def addon(caller, ops="", procedurals="", apps="", graphics="", scripts="", startups="", shaders="", libs="", extensions=""):
        caller['GAFFER_APP_PATHS'] = apps
        caller['GAFFERUI_IMAGE_PATHS'] = graphics
        caller['PYTHONPATH'] = scripts
        caller['GAFFER_STARTUP_PATHS'] = startups
        caller['OSL_SHADER_PATHS'] = shaders
        caller['LD_LIBRARY_PATH'] = libs
        caller['GAFFER_EXTENSION_PATHS'] = extensions

    def bins(self):
        ''' we make our wrapper without the .py just to keep
            things more professional! lol '''
        gaffer_bin = 'gaffer.py'
        if self.path('bin/gaffer'):
            gaffer_bin = 'gaffer'

        # temp hack
        return [
            # ==================================================================
            # temp HACK disabling gaffer alias in favor of gaffer wrapper
            # script, to set pipevfx to 5.0.1 until we fix maya 2023 gaffer
            # ==================================================================
            ['gaffer',  gaffer_bin],
            ['opa',     gaffer_bin+' opa -gui 1'],
            ['browser', gaffer_bin+' browser'],
            ['sam',     gaffer_bin+' sam'],
            # ['bundle',  gaffer_bin+' test'],
        ]


    def bg(self, cmd, bin):
        ''' return True if a cmd or binary should run in background '''
        return True
