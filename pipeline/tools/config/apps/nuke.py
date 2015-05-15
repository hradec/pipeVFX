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
        macfixData['subpath'] = self.path('Nuke%s.app/Contents/MacOS/' % self.version())

    def environ(self):
        if self.osx:
            osxPath = self.mac()['subpath']
            self.replace(
                NUKE_ROOT           = osxPath,
                LIB                 = osxPath,
                LD_LIBRARY_PATH     = osxPath,
                PATH                = osxPath,
                NUKE_BIN            = osxPath,
                INCLUDE             = '%s/include' % osxPath,
            )
            
        nukeMajorVersion = int(self.version().split('.')[0])
        if self.parent() in ['nuke']:
            if nukeMajorVersion >= 8:
                pipe.version.set( python = '2.7.6' )
                pipe.libs.version.set( python = '2.7.6' )
            else:
                pipe.version.set( python = '2.6.8' )
                pipe.libs.version.set( python = '2.6.8' )
            
            #self.update( hiero() )
            
        self.update( python() )

        # we need this to force this app to read standard python from its installation
        # or else we see a error on os module were it can't find urandom!!
        self.insert('PYTHONPATH',0, self.path('lib/python$PYTHON_VERSION_MAJOR' ))
        self.insert('PYTHONPATH',0, self.path('lib/python$PYTHON_VERSION_MAJOR/lib-dynload/' ))
        
        # add the plugins path to pythonpath so we can find nuke python module
        for each in self.toolsPaths():
            nuke.addon(self, nukepath = '%s/nuke/gizmo' % each )
            nuke.addon(self, nukepath = '%s/nuke/script' % each )
        
        # avoid setting nuke default plugins folder since it comes with 
        # pyside and it breaks our own pyside implementation!!
        if self.parent() in ['nuke']:
            nuke.addon(self, script = self.path('plugins') )

        # configure cortex
        self.update( cortex() )
        self.update( gaffer() )
        self.update( rv() )
        self.update( genarts_monsters_gt_ofx() )
        
        # rvNuke plugin needs this to find rv wrapper!
        self['RV_PATH'] = '%s/scripts/rv' % roots.tools()
        
        # disable CUDA
#        self['FN_NUKE_DISABLE_CUDA'] = 1
#        self['NUKE_USE_FAST_ALLOCATOR'] = 1

        # set nuke cache dir!
        cache_dir = '/tmp/nuke_%s' % pipe.admin.username()
        # check if sd mount exists
        if os.path.exists('/nuke_sd_cache'):
            cache_dir = '/nuke_sd_cache/nuke_%s' % pipe.admin.username()
        
        if not os.path.exists(cache_dir):
            os.makedirs(cache_dir)
            
        self['NUKE_TEMP_DIR'] = cache_dir
        
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
        ]
        
    def run(self, app):
        from glob import glob
        import os
        cmd = app.split(' ')
        baseApp.run( self, os.path.basename(glob('%s/Nuke*.*' % self.bin())[0]) + ' ' + ' '.join(cmd[1:]) )

