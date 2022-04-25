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

class maya(baseApp):

    def macfix(self, macfixData):
        '''
        new format for maya folder structure
        now we put the same folder structure extracted from maya RPM files
        this makes it simple to install new versions of maya.
        '''
        if not os.path.exists(self.path("bin")) and os.path.exists(self.path("usr")):
            # now we can update maya root properly.
            mv = self.version().split('.')[0]
            macfixData['subpath'] = 'usr/autodesk/maya%s/' % mv
            if not os.path.exists( self.path( 'bin/maya' ) ):
                self.maya_bin = "bin/maya%s" % mv

    def environ(self, allPlugs=True):
        ''' this is the main method in a class to setup environment variables for an app.
        if not implemented, the pipe will try to figure it automatically from the folder structure
        '''

        if self.osx:
            self['PATH'] = '/Library/Application Support/DirectConnect/8.0/bin/Aruba/bin/'
            self['LD_LIBRARY_PATH'] = '/Library/Application Support/DirectConnect/8.0/bin/Aruba/bin/'
            self['LD_LIBRARY_PATH'] = '/Library/Application Support/DirectConnect/8.0/bin/Aruba/bin/plug-ins/translators/'

        # maya needs csh, libXp6 and libtiff3 installed to run!
        mv = float(self.version().split('.')[0])
        if mv <= 2016:
            # we set this to avoid maya csh script to deal with LD_LIBRARY_PATH
            # since its' too big for it to handle
            #(fix "word too long" error on some systems, like debian!!)
            self['LD_LIBRARYN32_PATH'] = self.path("lib")
            self['libn32'] = '1'

            # pipeline alembic plugins!
            self.update( pipe.libs.alembic() )
        # else:
        #     self['PYTHONHOME'] = self.path()

        # set the proper python version for the current maya version!
        if self.parent() in ['maya','arnold']:
            if mv >= 2014:
                pipe.version.set( python = '2.7' )
                pipe.libs.version.set( python = '2.7' )
                # set the python version to use with maya
                self['MAYA_PYTHON_VERSION'] = "2"
            else:
                pipe.version.set( python = '2.6' )
                pipe.libs.version.set( python = '2.6' )


        # grab current python version
        pythonVer = ''.join(pipe.libs.version.get( 'python' )[:3])

        # log.debug( "@@@@@ %s, %s %s" % ( 'MAYA_USE_VRAY' in os.environ, mv > 2016, allPlugs ) )
        # plugins
        if allPlugs:
            self.update( studiolibrary() )
            self.update( prman() )
            self.update( cortex() )
            self.update( gaffer() )
            self.update( golaem() )
            self.update( shave() )
            self.update( substance() )
            self.update( mgear() )

            if mv > 2016:
                self.update( pipe.libs.usd() )

                # substance that comes with maya
                maya.addon(self, module = self.path("../../../opt/Allegorithmic/Substance_in_Maya/$MAYA_VERSION/") )

                # bifrost in later mayas
                for each in cached.glob(self.path("../bifrost/maya*/*/*")):
                    maya.addonModule( self, each )
                    if os.path.basename(each) == 'bifrost':
                        self['MAYA_CONTENT_PATH']             = each+'/examples/Bifrost_Fluids'
                        self['MAYA_MODULE_UI_WORKSPACE_PATH'] = each+'/resources/workspaces'
                        self['MAYA_TOOLCLIPS_PATH']           = each+'/resources/toolclips'
                        self['BIFROST_LIB_CONFIG_FILES']      = each+'/resources/plugin_config.json'



                # maya.addon(self,
                #     plugin  = self.path("../../../opt/rokoko_motion_library/maya/$MAYA_VERSION/plug-ins/"),
                #     lib     = self.path("../../../opt/rokoko_motion_library/maya/$MAYA_VERSION/lib/"),
                #     script  = self.path("../../../opt/rokoko_motion_library/maya/$MAYA_VERSION/scripts/"),
                #     qml     = self.path("../../../opt/rokoko_motion_library/maya/$MAYA_VERSION/qml-modules-linux/"),
                #
                # )

                if pipe.libs.mayausd().keys():
                    self.update( pipe.libs.mayausd() )
                else:
                    # setup maya usd that comes with maya!
                    if hasattr(self, 'maya_bin'):
                        for usdVersion in cached.glob(self.path('../mayausd/maya%d/*' % mv)):
                            maya.addon(self,
                                plugin = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/plugin/adsk/plugin",
                                script = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/plugin/adsk/scripts",
                                icon = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/plugin/adsk/icons",
                            )
                            maya.addon(self,
                                plugin = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/lib/maya",
                                lib = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/lib/",
                                script = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/lib/python/",
                                icon = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/lib/icons/",
                            )
                            self['PATH'] = usdVersion+"/mayausd/USD$MAYA_PYTHON_VERSION/bin"
                            self['LD_LIBRARY_PATH'] = usdVersion+"/mayausd/USD$MAYA_PYTHON_VERSION/lib"
                            self['LD_LIBRARY_PATH'] = usdVersion+"/mayausd/USD$MAYA_PYTHON_VERSION/lib64"
                            self['PXR_PLUGINPATH_NAME'] = usdVersion+"/mayausd/MayaUSD$MAYA_PYTHON_VERSION/lib/usd"
                            self['MAYAUSD_VERSION'] = '.'.join(os.path.basename(usdVersion).split('.')[:2])


            if 'PIPE_REDSHIFT' in os.environ and os.environ['PIPE_REDSHIFT']=='1':
                self.update( redshift() )

            if 'PIPE_MAYA_ZYNC' in os.environ and os.environ['PIPE_MAYA_ZYNC']=='1':
                self.update( zync() )
            if mv <= 2015:
                self.update( arnold() )
            if mv <= 2014:
                self.update( delight() )
                self.update( yeti() )
            if mv <= 2017:
                if 'PIPE_MAYA_FABRICENGINE' in os.environ and os.environ['PIPE_MAYA_FABRICENGINE']=='1':
                    self.update( fabricEngine() )
            if mv >= 2016:
                if 'PIPE_MAYA_ARNOLD' in os.environ and os.environ['PIPE_MAYA_ARNOLD']=='1':
                    self.update( arnold() )
                if 'PIPE_MAYA_VRAY' in os.environ and os.environ['PIPE_MAYA_VRAY']=='1':
                    self.update( vray() )
                if 'PIPE_MAYA_OCTANE' in os.environ and os.environ['PIPE_MAYA_OCTANE']=='1':
                    self.update( octane() )
                if 'PIPE_MAYA_HOUDINI' in os.environ and os.environ['PIPE_MAYA_HOUDINI']=='1':
                    self.update( houdini() )


        # add tools paths
        for each in self.toolsPaths():
            maya.addon( self,
                plugin = '%s/maya/$MAYA_VERSION/plugins' % each ,
                script = '%s/maya/$MAYA_VERSION/scripts' % each ,
                icon   = '%s/maya/$MAYA_VERSION/icons' % each ,
                module = '%s/maya/$MAYA_VERSION/modules' % each,
                shelves= '%s/maya/$MAYA_VERSION/shelves' % each,
            )
            maya.addon( self,
                plugin = '%s/maya/plugins' % each ,
                script = '%s/maya/scripts' % each ,
                icon   = '%s/maya/icons' % each ,
                module = '%s/maya/modules' % each,
                shelves= '%s/maya/shelves' % each,
            )
            self['PYTHONPATH'] = '%s/maya/plugins' % each
            self['PYTHONPATH'] = '%s/maya/scripts' % each

        # add this only to the global one (last 'each')
        if float(self.version()) == 2016:
            self['AUTODESK_ADLM_THINCLIENT_ENV'] = "%s/licenses/maya/2016_config.xml" % each

        # don't use pipe openvdb since prman 21 comes with its own.
        prman_version = float(pipe.version.get('prman'))
        if prman_version >= 21.0 and prman_version < 22.0:
            self.ignorePipeLib( "openvdb" )
        else:
            self.update(pipe.libs.openvdb())

        self['PYTHONPATH'] = self.path('scripts')
        self['PYTHONPATH'] = self.path('plugins')
        # self['PYTHONPATH'] = pipe.libs.python().path('lib/python$PYTHON_VERSION_MAJOR/site-packages')

        # force the load of the support libraries that come with maya
        # this fixes problems in python with hashlib/md5!!
        if self.parent() in ['maya']:
            if os.path.exists(self.path('support/openssl/libcrypto.so.6')):
                # self['LD_PRELOAD'] = self.path('support/openssl/libcrypto.so.6')
                # self['LD_PRELOAD'] = self.path('support/openssl/libssl.so.6')
                self['LD_PRELOAD'] = '/usr/lib/libjpeg.so.62'
            if 'fedora' not in pipe.distro:
                if os.path.exists(self.path('../../libs/libcrypto.so.10')):
                    self['LD_PRELOAD'] = self.path('../../libs/libcrypto.so.10')
            if os.path.exists(self.path('../../libs/libfontconfig.so.1')):
                self['LD_PRELOAD'] = self.path('../../libs/libfontconfig.so.1')
                self['LD_PRELOAD'] = self.path('../../libs/libharfbuzz.so.0')
                self['LD_LIBRARY_PATH'] = self.path('../../libs')
        #

        # our custom zlib give some error messages at startup of
        # maya 2014!
        if mv >= 2014:
            self.ignorePipeLib( "zlib" )
            self.ignorePipeLib( "tbb" )
            self.ignorePipeLib( "openssl" )
            if mv<=2017:
                self.ignorePipeLib( "qt" )
            if mv==2014:
                self.ignorePipeLib( "hdf5" )
            if mv>2014:
                if 'centos' not in pipe.distro:
                    self.ignorePipeLib( "libpng" )
                    # self.ignorePipeLib( "jpeg" )
                    # self.ignorePipeLib( "tiff" )

                # freetype setup
                # self.ignorePipeLib( "freetype" )

        if self.parent() in ['maya']:
            if mv > 2017:
                self.ignorePipeLib( "qt" )
                self.ignorePipeLib( "pyqt" )
                self.ignorePipeLib( "sip" )
                self.ignorePipeLib( "pyside" )
                # self.update(pipe.libs.pyside())
                # pipe.libs.version.set( pyqt = '5.12.0' )
                self.ignorePipeLib( "fontconfig" )

                # maya 2022 doesn't need system freetype
                if mv < 2022 or 'gcc-multi' in os.environ["GCC_VERSION"]:
                    if os.path.exists('/usr/lib/libfreetype.so.6'):
                        self['LD_PRELOAD'] = '/usr/lib/libfreetype.so.6'

            # set the proper sip/pyqt so gaffer works
            elif mv > 2015:
                pipe.libs.version.set( sip  = '4.16.7.maya%s' % self.version() )
                pipe.libs.version.set( pyqt = '4.11.4.maya%s' % self.version() )


        # force to use mayas python
        if self.parent() in ['maya','arnold']:
            # or else we see a error on os module were it can't find urandom!!
            # we need this to force maya to read its own python distribution files
            self['LD_PRELOAD'] = self.path('lib/libpython%s.so' % pythonVer)

            if int(self['MAYA_PYTHON_VERSION']) == 2:
                maya_support_python = cached.glob( self.path('support/python/%s*/' % pythonVer ) )
                if maya_support_python:
                    self.insert('PYTHONPATH',0, maya_support_python[0])
                self.insert('PYTHONPATH',0, self.path('lib/python%s/' % pythonVer))
                self.insert('PYTHONPATH',0, self.path('lib/python%s/site-packages/' % pythonVer))
                self.insert('PYTHONPATH',0, self.path('lib/python%s/lib-dynload/' % pythonVer))
                self.insert('PYTHONPATH',0, self.path('lib/python%s.zip' % pythonVer.replace('.','')))
                self.insert('LD_LIBRARY_PATH',0, self.path('lib/python%s/lib-dynload/' % pythonVer))

        # xgen libraries
        self['XGEN_GLOBAL'] = self.path('plug-ins/xgen/')
        maya.addon( self, lib=self.path('plug-ins/xgen/lib/') )
        maya.addon( self, script=self.path('plug-ins/xgen/scripts/') )
        maya.addon( self, icon=self.path('plug-ins/xgen/icons/') )

        # it seems these are no set by default when running in mayapy
        for p in cached.glob( self.path('plug-ins/*') ):
            self['PATH'] = "%s/bin" % p
            self['PYTHONPATH'] = "%s/scripts" % p

        # change mouse window modifier to Super Key (Windows/apple cmd key) so ALT is free to be used by maya
        if 'super' not in ''.join(cached.popen('gsettings get org.gnome.desktop.wm.preferences mouse-button-modifier').readlines()).strip().lower():
            os.system('gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"')

        self['LC_ALL'] = 'C'
        self['MAYA_IP_TYPE'] = 'ipv4'
        self['MAYA_OPENCL_ALLOW_SSH_OPENCL'] = '1'

        # fix slow shutdown by disabling internet report uploads
        self['MAYA_DISABLE_CIP']='1'
        self['MAYA_DISABLE_CER']='1'
        self['MAYA_FORCE_SHOW_ACTIVATE'] = '1'
        self['MAYA_DEBUG_ENABLE_CRASH_REPORTING'] = '1'
        self['MAYA_ENABLE_LEGACY_RENDER_LAYERS'] = '1'
        self['MAYA_OPENCL_IGNORE_DRIVER_VERSION'] = '1'
        # self['MAYA_USE_MALLOC'] = '1'
        # self['MAYA_DISABLE_CASCADING'] = '1'
        self['MAYA_LOCATION'] = self.path()
        self['MAYA_NO_WARNING_FOR_MISSING_DEFAULT_RENDERER'] = '1'
        self['MAYA_WORKSPACES_ALWAYS_SHOW_TAB'] = '1'

        # If you are running Maya off a network, set this variable to the location
        # of the Maya .syncfg file. It must be set to enable the Send to commands.
        self['SYNHUB_CONFIG_PATH'] = self.path('../../../opt/Autodesk/Synergy/')
        self['MAYA_SYNSUITE_CONFIG_PATH'] = self.path('../../../opt/Autodesk/Synergy/')

        # Specifies the location of the common network repository where files
        # reside during live character streaming between two different workstations.
        # self['ONECLICK_TEMP_DIR']

        if mv > 2014:
            self['MAYA_ALLOW_RENDER_LAYER_SWITCHING'] = '1'
            # this bellow prevents the privacy window to show up when starting maya or the firt time!
            # this windown actually can create some problems of getting maya stuck forever at startup in some cases!
            if not os.path.exists( "%s/Adlm" % os.environ["HOME"] ):
                os.mkdir( "%s/Adlm" % os.environ["HOME"] )
            Adlm = open( "%s/Adlm/AdlmUserSettings.xml" % os.environ["HOME"], "w" )
            Adlm.write('''<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
                <AdlmSettings>
                    <Section Name="PrivacyPolicyConsent">
                        <Data Key="%d.0.0.F">1</Data>
                    </Section>
                </AdlmSettings>\n''' % mv )
            Adlm.close()

        # we run this to make sure Asset module works when importing IECore
        # for maya 2018 and up, since it comes with pyilmbase, which doens't match
        # the version we use in pipeVFX.
        if mv >= 2018:
            # as maya comes with pyilmbase, we want to force it to load ours instead, so IECore works,
            # as well alembic and pyalembic latest versions.
            if hasattr(pipe.libs, 'pyilmbase'):
                for p in pipe.libs.pyilmbase()['PYTHONPATH']:
                    self.insert('PYTHONPATH',0, p)
            for p in pipe.libs.boost()['LD_LIBRARY_PATH']:
                self.insert('PYTHONPATH',0, p)

            # we also need to make sure our oiio libraries are loaded,
            # not the ones that come with maya, or else IECoreImage will
            # cause a lockup in maya!
            self['LD_PRELOAD'] = pipe.libs.oiio().LD_PRELOAD()
            if hasattr(pipe.libs, 'ptex'):
                self['LD_PRELOAD'] = pipe.libs.ptex().LD_PRELOAD()

        self['EDITOR'] = 'atom'

    def version(self, v=None):
        if v:
            if v[0] not in '0123456789':
                v = None
            #v = filter( lambda x: x in '0123456789.-', v )
        return baseApp.version(self, v)


    def bins(self):
        ''' we override this method to return the commands we want to be visible for the users
        firt element is the command the user will type, and second is the command line executed
        '''
        ret = [
            ('maya', 'maya'),
            ('mayapy', 'mayapy'),
            ('Render', 'Render'),
            ('fcheck', 'fcheck'),
        ]
        return ret


    def run(self, app):
        import os, sys, glob
        mv = float(self.version().split('.')[0])

        m = self.path('bin/maya.bin')
        if hasattr(self, 'maya_bin'):
            # m = app.replace('maya', self.maya_bin)
            m = self.path(self.maya_bin)

        if '--debug' in sys.argv:
            self['MAYA_DEBUG_NO_SIGNAL_HANDLERS'] = '1'

        pythonVer = ''.join(pipe.libs.version.get( 'python' )[:3])
        self.insert('LD_LIBRARY_PATH',0, self.path('lib/python%s/lib-dynload/' % pythonVer))
        self.insert('PYTHONPATH',0, self.path('lib/python%s.zip' % pythonVer))
        cmd = app.split(' ')

        __run = app
        if 'Render' not in app and 'mayapy' not in app and os.path.exists(m):
            __run = os.path.basename(m) + '  ' + ' '.join(cmd[1:])
        elif 'mayapy' in app:
            # it seems these are no set by default when running in mayapy
            for p in cached.glob( self.path('plug-ins/*') ):
                maya.addon(self,
                    plugin = "%s/plug-ins" % p,
                    script = "%s/scripts" % p,
                    lib = "%s/lib" % p,
                    preset = "%s/presets" % p,
                    icon = "%s/icons" % p,
                )
                self['PATH'] = "%s/bin" % p
                self['PYTHONPATH'] = "%s/scripts" % p

            # if we are running version 2, and there's a mayapy2,
            # set mayapy to mayapy2
            if int(self['MAYA_PYTHON_VERSION']) == 2:
                if os.path.exists(self.path('bin/mayapy2')):
                    __run = app.replace('mayapy', 'mayapy2')

            # __run = app.replace('mayapy','bin/mayapy')
        else:
            pass

        # if 'mayapy' not in app and float(self.version().split('.')[0]) >= 2022:
        #     __run += ' -pythonver 2'
        baseApp.run( self, __run )


    def license(self):
        # if float(self.version()) >= 2016.5:
        #     self['MAYA_LICENSE_METHOD']='standalone'
        self['MAYA_LICENSE']='unlimited'
        if 'LM_LICENSE_FILE' in self:
            del self['LM_LICENSE_FILE']
        self['MAYA_ALT_EN'] = '/var/flexlm/maya.lic'

        # else:
        #     self['LM_LICENSE_FILE'] = "%s/licenses/%s/%s" % (roots.tools(), self.className.lower(), self.appFromDB.version() )

    # def bg(self,cmd,bin):
    #     ''' return True if a cmd or binary should run in background '''
    #     if 'maya' in bin[0]:
    #         return True
    #     return False

    @staticmethod
    def addon(caller, plugin="", script="", icon="", renderDesc='', lib='', preset='',module='', shelves='', templates='', qml='', content='', toolclips='', workspace=''):
        ''' the addon method MUST be implemented for all classes so other apps can set up
        searchpaths for this app. For example, another app which has plugins for this one!'''
        if not pipe.osx:
            if type(icon) == type([]):
                icon = map( lambda x: x+"/%B", icon )
            else:
                icon = icon+"/%B"
        caller['MAYA_PLUG_IN_PATH']             = plugin
        caller['MAYA_SCRIPT_PATH']              = script
        caller['PYTHONPATH']                    = script
        caller['XBMLANGPATH']                   = icon
        caller['MAYA_RENDER_DESC_PATH']         = renderDesc
        caller['LD_LIBRARY_PATH']               = lib
        caller['MAYA_PRESET_PATH']              = preset
        caller['MAYA_MODULE_PATH']              = module
        caller['MAYA_SHELF_PATH']               = shelves
        caller['MAYA_CUSTOM_TEMPLATE_PATH']     = templates
        caller['QML2_IMPORT_PATH']              = qml
        caller['MAYA_CONTENT_PATH']             = content
        caller['MAYA_MODULE_UI_WORKSPACE_PATH'] = workspace
        caller['MAYA_TOOLCLIPS_PATH']           = toolclips

    @staticmethod
    def addonModule(caller, path):
        maya.addon(caller,
            script = path+'/scripts',
            preset = path+'/presets',
            icon   = path+'/icons',
            plugin = path+'/plug-ins',
            # = "%s/%s" % (path, 'bin/image')
            # = "%s/%s" % (path, 'shaders'),
            # = "%s/%s" % (path, 'shaders/include'),
            # = "%s/%s" % (path, 'devkit'),
        )
        caller['PATH'] = path+'/bin'
        caller['PATH'] = path+'/lib'
        caller['PYTHONPATH'] = path+'/scripts'
        caller['PYTHONPATH'] = path+'/python'
        caller['PYTHONPATH'] = path+'/python/site-packages'
        caller['MAYA_PLUG_IN_RESOURCE_PATH'] = path+'/resources'


    def preRun(self, cmd):
        if self.parent() in ['maya','arnold']:
            mv = float(self.version().split('.')[0])
            if mv >= 2018:
                top = []
                # as maya comes with pyilmbase and alembic python, we want to
                # force it to load ours instead, so IECore and renderman works,
                # as well alembic and pyalembic latest versions.
                if hasattr(pipe.libs, 'pyilmbase'):
                    top += [ os.path.expandvars(x) for x in pipe.libs.pyilmbase()['PYTHONPATH'] ]
                top += [ os.path.expandvars(x) for x in pipe.libs.alembic()['PYTHONPATH'] ]
                pythonVer = ''.join(pipe.libs.version.get( 'python' )[:3])
                os.environ['PYTHONPATH'] = ':'.join(top+[
                    # we need this to force maya to read its own python distribution files
                    # or else we see a error on os module were it can't find urandom!!
                    self.path('lib/python%s.zip:' % pythonVer.replace('.','')),
                    os.environ['PYTHONPATH']
                ])

        return cmd


    def postRun(self, cmd, returnCode, returnLog=""):
        ''' this is called after a binary of this class has exited.
        it's the perfect method to do post render frame checks, for example!'''
        error = returnCode!=0
        extensions = [
            '.exr',
            '.tif',
            '.jpg',
            '.dpx',
        ]
        images=[]

        # list of substrings to find files in the same folder where
        # images that appear in the logs are.
        # (for those images that don't show up in the log!)
        extra_images_filesystem_search = [
            # as cryptomate in renderman doesn't show up in the log, we have to look
            # for it in the same path where rendered images are.
            # we assume they have a filename that contains "cryptomate" in it!
            'cryptomate',
            'cryptomatte',
        ]

        # publish output log
        if hasattr(self, 'asset'):
            pipe.frame.publishLog(returnLog, self.asset, self.className)

        # if Render in cmd
        if 'Render' in cmd:

            # and 'Finished Rendering' in the log, do a frame check!
            if 'Finished Rendering' in returnLog:

                # collect image files from output log
                images = map(lambda z: z.split('Finished Rendering ')[-1].split()[0].strip().strip('.'),
                               filter(lambda x: 'Finished Rendering ' in x,returnLog.split('\n')) )

            # and Mental Ray Render in the log, do a frame check!
            if 'image file' in returnLog and 'Mayatomr.Nodes' in returnLog:

                # collect image files from output log
                images = map(lambda z: z.split('image file')[-1].split()[0],
                               filter(lambda x: 'image file' in x,returnLog.split('\n')) )

            # or Arnold Render in the log, do a frame check!
            if 'writing file' in returnLog and 'mtoa_shaders.so' in returnLog:

                # collect image files from output log
                images = map(lambda z: z.split('writing file')[-1].replace('`','').replace("'",'').strip(),
                               filter(lambda x: 'writing file' in x,returnLog.split('\n')) )

            # or V-RAY Render in the log, do a frame check!
            if 'Successfully written image file' in returnLog and 'V-Ray' in returnLog:

                # collect image files from output log
                images = map(lambda z: z.split('Successfully written image file')[-1].replace('`','').replace("'",'').replace('"','').strip(),
                               filter(lambda x: 'Successfully written image file' in x,returnLog.split('\n')) )



            # or prman Render in the log, do a frame check!
            if '(mode = ' in returnLog and 'Pixar PhotoRealistic RenderMan' in returnLog:

                # collect image files from output log
                unfiltered = []
                for line in [ x for x in returnLog.replace('\r',"").replace('\n\n',"\n").replace('\n\n',"\n").replace('R90000 PROGRESS: 100%\n',"").split('\n') if '(mode = ' in x ]:
                    sline = line.split('"')
                    print( line )

                    # line is ok, so just grab index 1 of the split, which is the path!
                    if len(sline) > 2 :
                        if os.path.splitext(sline[1])[-1].lower() in extensions:
                            unfiltered += [sline[1].strip()]

                    # line is broken by a late 100% message from prman (line doesn't have 2 " )
                    # try to find the initial part of the path
                    else:
                        endPath = sline[0].strip()
                        startPath = [ x for x in returnLog.split('"') if endPath in x and 'R90000' in x]
                        if startPath:
                            path = startPath[0].split('R90000')[0].strip() + endPath
                            if os.path.splitext(path)[-1].lower() in extensions:
                                unfiltered += [path]


                # if using denoise, return the filtered images.
                # (if no error during denoise!)
                filtered = []
                if "Error reading EXR 'renderman" not in returnLog:
                    if 'Filtering to produce ' in returnLog:
                        filtered = map(lambda z: z.split('Filtering to produce ')[1].strip(),
                            filter(lambda x: 'Filtering to produce ' in x,returnLog.split('\n')) )

                images = unfiltered + filtered

        # after we have some images from the log, we can look on the same
        # paths where they are, looking for extra images that may not show up
        # in the logs (like cryptomate in renderman!)
        for path in set([ os.path.dirname(x) for x in images ]):
            for substr in extra_images_filesystem_search:
                images += cached.glob( "%s/*%s*" % (path, substr) )

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
                    pipe.frame.publish( images, assetPath ) #, returnLog )
                else:
                    # if we have an asset reference already, use it!
                    pipe.frame.publish( images, self.asset )

        # if no images and one of those strings found, fail frame render!
        else:
            errors = [
                'RuntimeError',
                'fatal interrupt',
                'encountered a fatal error',
                'ImportError:',
                'Maya exited with status',
                "can't create directory",
                "Can't create file",
                '(core dumped)',
                'dbus.exceptions.DBusException',
                'because of an override to a missing node within a referenced scene',
                'A08022 Broken pipe',
                'ERROR | [driver_exr]',
                'H5FD_sec2_open',
                'OpenEXR exception',
            ]
            for s in errors:
                if s in str(returnLog):
                    line = '\n'.join(filter(lambda x: s in x, str(returnLog).split('\n')))
                    if 'was not found on MAYA_PLUG_IN_PATH' not in line:
                        error = True
                        break

        # fatal errors - must fail even if images were generated!!
        fatalErrors = [
                'Zip Read Error',
                'cannot be opened by RiReadArchive',
                "Cannot load scene",
                'Error: T03007 Bad texture data in ',
                # 'Error: X00002 Plugin error: ',
                "Error: T02001 Can't open texture ",
                "Error: R50005 License error",
                # "Error reading EXR 'renderman", # denoise error when prman crashes
                'ERROR | [driver_exr]',
                'H5FD_sec2_open',
                'OpenEXR exception',
                '* CRASHED',
                'render terminating early:  received abort signal',
                'Maya exited with status',
        ]
        for s in fatalErrors:
            if s in str(returnLog):
                error = True
                print( filter(lambda x: s in x, str(returnLog).split('\n')) )
                break


        # return a posix error code if we got an error, so the farm engine
        # will get a proper error!
        return int(error)*255



    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        self['MAYA_PROJECT'] = jobuser.path('maya')
        if not os.path.exists( jobuser.path('maya/workspace.mel') ):
            jobuser.mkdir( 'maya' )
            jobuser.mkdir( 'maya/scenes' )
            jobuser.mkdir( 'maya/3dPaintTextures' )
            jobuser.mkdir( 'maya/sourceimages' )
            jobuser.mkdir( 'maya/images' )
            jobuser.mkdir( 'maya/data' )
            jobuser.mkdir( 'maya/cache' )
            jobuser.mkdir( 'maya/particles' )
            jobuser.mkdir( 'maya/scripts' )

            jobuser.toFile( [
                'workspace -fr "scene" "scenes";',
                'workspace -fr "3dPaintTextures" "sourceimages/3dPaintTextures";',
                'workspace -fr "eps" "data";',
                'workspace -fr "mentalRay" "renderData/mentalray";',
                'workspace -fr "OBJexport" "data";',
                'workspace -fr "mel" "scripts";',
                'workspace -fr "particles" "particles";',
                'workspace -fr "PhysX" "data";',
                'workspace -fr "STEP_DC" "data";',
                'workspace -fr "CATIAV5_DC" "data";',
                'workspace -fr "sound" "sound";',
                'workspace -fr "furFiles" "renderData/fur/furFiles";',
                'workspace -fr "depth" "renderData/depth";',
                'workspace -fr "CATIAV4_DC" "data";',
                'workspace -fr "autoSave" "autosave";',
                'workspace -fr "diskCache" "cache";',
                'workspace -fr "IPT_DC" "data";',
                'workspace -fr "SW_DC" "data";',
                'workspace -fr "DAE_FBX export" "data";',
                'workspace -fr "DAE_FBX" "data";',
                'workspace -fr "mayaAscii" "scenes";',
                'workspace -fr "iprImages" "renderData/iprImages";',
                'workspace -fr "move" "data";',
                'workspace -fr "mayaBinary" "scenes";',
                'workspace -fr "fluidCache" "cache/fluid";',
                'workspace -fr "clips" "clips";',
                'workspace -fr "animExport" "data";',
                'workspace -fr "templates" "assets";',
                'workspace -fr "DWG_DC" "data";',
                'workspace -fr "translatorData" "data";',
                'workspace -fr "offlineEdit" "scenes/edits";',
                'workspace -fr "DXF_DC" "data";',
                'workspace -fr "renderData" "renderData";',
                'workspace -fr "furShadowMap" "renderData/fur/furShadowMap";',
                'workspace -fr "audio" "sound";',
                'workspace -fr "IV_DC" "data";',
                'workspace -fr "scripts" "scripts";',
                'workspace -fr "studioImport" "data";',
                'workspace -fr "furAttrMap" "renderData/fur/furAttrMap";',
                'workspace -fr "FBX export" "data";',
                'workspace -fr "JT_DC" "data";',
                'workspace -fr "sourceImages" "sourceimages";',
                'workspace -fr "apexClothingExporter" "data";',
                'workspace -fr "animImport" "data";',
                'workspace -fr "FBX" "data";',
                'workspace -fr "movie" "movies";',
                'workspace -fr "furImages" "renderData/fur/furImages";',
                'workspace -fr "IGES_DC" "data";',
                'workspace -fr "illustrator" "data";',
                'workspace -fr "furEqualMap" "renderData/fur/furEqualMap";',
                'workspace -fr "images" "images";',
                'workspace -fr "SPF_DC" "data";',
                'workspace -fr "PTC_DC" "data";',
                'workspace -fr "OBJ" "data";',
                'workspace -fr "CSB_DC" "data";',
                'workspace -fr "STL_DC" "data";',
                'workspace -fr "shaders" "renderData/shaders";',
            ], 'maya/workspace.mel' )
            jobuser.create()
