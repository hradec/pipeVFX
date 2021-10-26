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


class nuke(baseApp):
    def macfix(self, macfixData):
        if pipe.osx:
            macfixData['subpath'] = self.path('Nuke%s.app/Contents/MacOS/' % self.version())
            osxPath = self.mac()['subpath']
            self.replace(
                NUKE_ROOT           = osxPath,
                LIB                 = osxPath,
                LD_LIBRARY_PATH     = osxPath,
                PATH                = osxPath,
                NUKE_BIN            = osxPath,
                INCLUDE             = '%s/include' % osxPath,
            )

    def environ(self):
        nukeMajorVersion = int(self.version().split('.')[0])
        if self.parent() in ['nuke']:
            if nukeMajorVersion >= 8:
                pipe.version.set( python = '2.7.6' )
                pipe.libs.version.set( python = '2.7.6' )
            else:
                pipe.version.set( python = '2.6.8' )
                pipe.libs.version.set( python = '2.6.8' )

            #self.update( hiero() )

        # new in nuke12
        # self['LD_LIBRARY_PATH'] = self.path("arri/GPU")
        self['LD_LIBRARY_PATH'] = self.path("arri/CPUonly")

        self.update( python() )

        # we need this to force this app to read standard python from its installation
        # or else we see a error on os module were it can't find urandom!!
        self.insert('PYTHONPATH',0, self.path('lib/python$PYTHON_VERSION_MAJOR' ))
        self.insert('PYTHONPATH',0, self.path('lib/python$PYTHON_VERSION_MAJOR/lib-dynload/' ))

        # avoid setting nuke default plugins folder since it comes with
        # pyside and it breaks our own pyside implementation!!
        if self.parent() in ['nuke']:
            nuke.addon(self, script = self.path('plugins') )

        # configure cortex
        self.update( prman() )

        # cortex trava
        #  nukex  /atomo/jobs/0528.davene_filme_2/shots/shot_001/users/rafaelz/nuke/script/shot_001_comp_v088.nk
        self.update( cortex() )
        self.update( gaffer() )

        # afanasy farm nodes
        self.update( cgru() )

        if 'PIPE_NUKE_CRYPTOMATTE' not in os.environ or os.environ['PIPE_NUKE_CRYPTOMATTE']=='1':
            self.update( cryptomatte() )

        if 'PIPE_NUKE_GENARTS' not in os.environ or os.environ['PIPE_NUKE_GENARTS']=='1':
            self.update( genarts_monsters_gt_ofx() )

        self.update( keentools() )
        self.update( neat() )

        # rvNuke plugin needs this to find rv wrapper!
        self.update( rv() )
        self['RV_PATH'] = '%s/scripts/rv' % roots.tools()

        # disable CUDA
        #self['FN_NUKE_DISABLE_GPU_ACCELERATION'] = "1"
        #self['NUKE_USE_FAST_ALLOCATOR'] = "1"

        # show memory debug information on console
        #self['NUKE_DEBUG_MEMORY'] = '0'
        #self['FOUNDRY_LOG_LEVEL'] = 'verbose'

        # disable nuke crash handling so we can see crash dumps ourselfs.
        self['FN_CRASH_DUMP_PATH'] = '/tmp/'
        self['NUKE_CRASH_HANDLING'] = '0'

        nuke.addon(self, lib = self.path() )

        # add the plugins path to pythonpath so we can find nuke python module
        for each in self.toolsPaths():
            if int(self.version().split('.')[0]) < 10:
               nuke.addon(self, nukepath = '%s/nuke/gizmo' % each )
               nuke.addon(self, nukepath = '%s/nuke/script' % each )
               nuke.addon(self, lib = '%s/nuke/script' % each )
            else:
               nuke.addon(self, nukepath = '%s/nuke/$NUKE_VERSION/gizmo' % each )
               nuke.addon(self, nukepath = '%s/nuke/$NUKE_VERSION/script' % each )
               nuke.addon(self, lib = '%s/nuke/$NUKE_VERSION/script' % each )
               nuke.addon(self, lib = '%s/nuke/$NUKE_VERSION/plugins' % each )

        # mari bridge
        self.update( mari() )

        # if 'CENTOS' in os.environ:
        #     self.ignorePipeLib( "freetype" )
        #     self.ignorePipeLib( "fontconfig" )

    def dotAppName(self):
        return "Nuke%s.app" % self.version()

    @staticmethod
    def addon(caller, nukepath="", lib='', script=''):
        caller['NUKE_PATH'] = nukepath
        caller['LD_LIBRARY_PATH'] = lib
        caller['PYTHONPATH'] = script

    def license(self):
        lic=[]

        if os.environ.has_key('PIPE_NUKE_LICENSE_SERVERS'):
            for each in os.environ['PIPE_NUKE_LICENSE_SERVERS'].split(','):
                if 'LM:' in each:
                    self['FOUNDRY_LICENSE_FILE'] = each.split('LM:')[-1]
                else:
#                    if each[0]=='@':
#                        each = each[1:]
                    lic.append(each)

        if os.environ.has_key('PIPE_HIERO_LICENSE_SERVERS'):
            lic.append( os.environ['PIPE_HIERO_LICENSE_SERVERS'] )

        self['foundry_LICENSE'] = ':'.join(lic)
        self['LM_LICENSE_FILE'] = self['foundry_LICENSE']
        self['FOUNDRY_LICENSE_FILE'] = ':'.join(lic)

    def bins(self):
        return [
            ('nuke',  'nuke '               ),
            ('nukex', 'nuke --nukex'        ),
            ('nukea', 'nuke --nukeassist'   ),
            ('nukes', 'nuke --studio'       ),
            ('hiero', 'nuke --hiero'        ),
            ('hplayer', 'nuke --player'     ),
        ]

    def run(self, app):
        from glob import glob
        import os

        # set nuke cache dir!
#        self.nuke_dir_name = 'nuke_%s_%s' % (str(os.getpid()), pipe.admin.username())
        self.nuke_dir_name = '%s_%s' % (app.replace(' ','').replace('--','').lower(), pipe.admin.username())
        self.nuke_diskcache_dir_name = 'nukeDiskCache_%s' % 'all' #(pipe.admin.username())
        temp_dir = '/tmp/%s' % self.nuke_dir_name
        cache_dir = '/tmp/%s' % self.nuke_diskcache_dir_name
        # check if sd mount exists
        if os.path.exists('/nuke_sd_cache'):
            temp_dir = '/nuke_sd_cache/%s' % self.nuke_dir_name
            cache_dir = '/nuke_sd_cache/%s' % self.nuke_diskcache_dir_name
        # create folder if none exists
        if not os.path.exists(temp_dir):
            os.makedirs(temp_dir)
        if not os.path.exists(cache_dir):
            os.makedirs(cache_dir)
        # set nuke temp folder in env var
        self['NUKE_TEMP_DIR'] = temp_dir
        self['NUKE_DISK_CACHE'] = cache_dir

        # make nuke_disk_cache rw for everyone
        #sudo = pipe.admin.sudo()
        #sudo.chmod( "a+rwx -R", cache_dir )
        #sudo.run()

        # run the application
        cmd = app.split(' ')
        nukeBin = glob('%s/Nuke*.*' % self.bin())
        if not nukeBin:
            raise Exception( "\n\nCan't find Nuke executable at %s. Are you sure Nuke %s is installed?\n" % ('%s/Nuke*.*' % self.bin(), self.version()) )
            
        if int( self.version().split('.')[0] ) >= 10:
            cmd += ['--disable-nuke-frameserver']

        baseApp.run( self, os.path.basename(nukeBin[0]) + '  ' + ' '.join(cmd[1:]) )


    def preRun(self, cmd):
        del os.environ['LD_PRELOAD']
        # os.environ['LD_PRELOAD'] = pipe.libs.ocio().path('lib/python2.7/libOpenColorIO.so.1')
        return cmd

    def postRun(self, cmd, returnCode, returnLog=""):
        ''' this is called after a binary of this class has exited.
        it's the perfect method to do post render frame checks, for example!'''
        error = returnCode!=0
        images=[]

        # if Render in cmd
        if 'Nuke' in cmd and '-F' in cmd:

            # and 'Writing' in the log, do a frame check!
            if 'Writing' in returnLog:

                # collect image files from output log
                images = map(lambda z: z.split('Writing')[-1].split()[0].strip(),
                               filter(lambda x: 'Writing' in x,returnLog.split('\n')) )

        # run our pipe.frame.check generic frame check for the gathered image list
        if images:
            error = pipe.frame.check( images )

            # move rendered frames to asset, if this render is an asset!
            if not error:
                if not self.asset:
                    # If we dont have an asset, try figure it out from the  scene path
                    assetPath = None
                    for each in cmd.split(' '):
                        each = each.replace('"','')
                        if os.path.splitext(each.lower())[-1] in ['.nk']:
                            assetPath = each
                            break
                    pipe.frame.publish( images, assetPath ) #, returnLog )
                else:
                    # if we have an asset reference already, use it!
                    pipe.frame.publish( images, self.asset )#, returnLog  )

        # publish output log
        pipe.frame.publishLog(returnLog, self.asset, self.className)

        # return a posix error code if we got an error, so the farm engine
        # will get a proper error!
        return int(error)*255




    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        jobuser.mkdir( 'nuke' )
        jobuser.mkdir( 'nuke/render' )
        jobuser.mkdir( 'nuke/script' )
        jobuser.mkdir( 'nuke/precomp' )
        jobuser.symlink( '/../../../../shots/nukestudio/published/nukescripts/%s/' % pipe.admin.job.shot().shot,  'nuke/nukestudio')
        jobuser.create()
