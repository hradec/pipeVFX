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






#RMANTREE - establishes the location of your PRMan distribution.
#RMANFB - establishes your framebuffer display program.
#RDIR - speficies a directory where additional configuration files can be found, e.g. a site-specific rendermn.ini file.
#PIXAR_LICENSE_FILE - can be used by systems administrators to define a location other than the default for the software license. This will normally point to a pixar.license file on a centrally mounted network drive.



class prman(baseApp):
    def environ(self):
        import socket
        from glob import glob

        if int(os.popen('ifconfig hostid0 2>&1 | wc -l').readlines()[0].strip()) > 1:
            self['PIXAR_LICENSE_FILE'] = '%s/licenses/prman/generic.license' % self.toolsPaths()[-1]
        else:
            for each in ['%s/tools/licenses/prman/' % os.environ['HOME']]+self.toolsPaths():
                p = '%s/licenses/prman/%s.license' % (each, socket.gethostname())
                if os.path.exists(p):
                    self['PIXAR_LICENSE_FILE'] = p
                    break

        # cleanup env vars if they already exist, to avoid problems!
        for env in ['RMANTREE', 'RMSTREE', 'SHADERS_PATH', 'TEXTURES_PATH' ]:
            if os.environ.has_key(env):
                del os.environ[env]

        if self.parent() in ['prman']:
            pipe.version.set( python = '2.7.6' )
            pipe.libs.version.set( python = '2.7.6' )
            self['LD_PRELOAD'] = pipe.libs.python().LD_PRELOAD()

            self.update( cortex() )
            

        folders=[]
            
        rmantree = self.path('RenderManProServer-$PRMAN_VERSION')
        folders.append(rmantree)
        self['RMANTREE']        = rmantree
        self['PATH']            = "%s/bin" % rmantree
        self['PYTHONPATH']      = "%s/bin" % rmantree
        self['LD_LIBRARY_PATH'] = "%s/lib/rif" % rmantree
        self['LD_LIBRARY_PATH'] = "%s/bin" % rmantree
        self['LD_LIBRARY_PATH'] = "%s/lib" % rmantree
        self['LD_LIBRARY_PATH'] = "%s/etc" % rmantree


        # setup main renderman env vars!
        if self.parent() not in ['houdini']:
            rmstree = self.path('RenderManStudio-$PRMAN_VERSION-maya$MAYA_VERSION')
            folders.append(rmstree)
            self['RMSTREE']  = rmstree
            self['PATH']     = "%s/bin" % rmstree
            self['PATH']     = "%s/rmantree/bin" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/lib/rif" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/lib" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/bin" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/etc" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/rmantree/lib" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/rmantree/bin" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/rmantree/etc" % rmstree

            self.update( maya() )
            maya.addon(self,
                    plugin      = '%s/plug-ins' % rmstree,
                    script      = '%s/scripts'  % rmstree,
                    icon        = '%s/icons'    % rmstree,
                    renderDesc  = '%s/etc'      % rmstree,
                    lib         = '%s/lib'      % rmstree,
                    preset      = '%s/presets'  % rmstree,
                    module      = '%s/etc'      % rmstree,
                )
            

        for p in glob("%s/prman/mayaLibrary/*"  % self.toolsPaths()[-1]):
            self['MAYA_SHADER_LIBRARY_PATH'] = p

        #if self.parent  in ['nuke']:
        for each in folders:
            prman.addon(self,
                python=[
                    '%s/scripts'        % each,
                    '%s/rfm'            % each,
                    '%s/lib/it/python/' % each,
                    '%s/lib/python2.7/' % each,
                ],shader=[
                    '%s/lib/shaders'     % each,
                    '%s/lib/rsl/shaders' % each,
                    '%s/lib/textures'    % each,
            ])

        # add tools paths
        self['RMS_SCRIPT_PATHS'] = '%s/prman/scripts/' % self.toolsPaths()[-1]
        self['RMS_SCRIPT_PATHS'] = '%s/prman/etc/' % self.toolsPaths()[-1]
        self['RDIR'] 		 = '%s/prman/etc/' % self.toolsPaths()[-1]

        for each in self.toolsPaths():
            prman.addon(self,
                python = '%s/prman/python'        % each,
                shader = '%s/prman/shaders'     % each,
            )


        # add houdini setup to use prman
        # http://archive.sidefx.com/docs/houdini15.0/render/renderman
        self['HOUDINI_DEFAULT_RIB_RENDERER']="prman%s" % self.version()
        #HOUDINI_VIEW_RMAN=renderdl
        #HOUDINI_RI_SHADERPATH
        #HOUDINI_RI_RIXPLUGINPATH

        self.update( golaem() )

        self.ignorePipeLib( "libpng" )

    @staticmethod
    def addon( caller, shader='', procedurals='', script='',python='', display='', texture='', lib='', rsl='' ):
        caller['PYTHONPATH'] = script
        caller['PYTHONPATH'] = python
        caller['SHADERS_PATH'] = shader
        caller['RMS_SHADER_PATH'] = shader
        caller['TEXTURES_PATH'] = texture
        caller['PROCEDURALS_PATH'] = procedurals
        caller['PROCEDURAL_PATH'] = procedurals
        caller['RMS_PROCEDURAL_PATH'] = procedurals
        caller['LD_LIBRARY_PATH'] = display
        caller['LD_LIBRARY_PATH'] = lib

    def bg(self,cmd,bin):
        ''' return True if a cmd or binary should run in background '''
        if bin[0] == 'it':
            return True
        return False

    def bins(self):
        from glob import glob
        import sys
        v = self.version()
        mv = maya().version()
        ret = []
        idx = {}
        for f in glob(self.path('RenderManStudio-%s-maya%s/bin/*' % (v,mv))):
            bf = os.path.basename(f).strip()
            if len(bf.split('.'))<2:
                idx[bf] = 'RenderManStudio-%s-maya%s/bin/%s' % (v,mv,bf)

        for f in glob(self.path('RenderManStudio-%s-maya%s/rmantree/bin/*' % (v,mv))):
            bf = os.path.basename(f).strip()
            if len(bf.split('.'))<2:
                idx[bf] = 'RenderManStudio-%s-maya%s/rmantree/bin/%s' % (v,mv,bf)

        for f in glob(self.path('RenderManProServer-%s/bin/*' % v)):
            bf = os.path.basename(f).strip()
            if bf not in idx:
                if len(bf.split('.'))<2:
                    idx[bf] = 'RenderManProServer-%s/bin/%s' % (v,bf)

        return map(lambda x: (x, idx[x]), idx.keys() )

    def userSetup(self, jobuser):
        import os, sys
        # make sure pipe doesn't change the folder from the current folder
        os.chdir( jobuser.pwd )
        # BUT, maya exports rib with relative paths inside, so if a rib comes
        # from a maya subfolder, we must make sure we run prman from within maya
        # project subfolder.
        # for that, we try to guess all that from the rib path!
        for n in range(len(sys.argv)):
            r = os.path.abspath(sys.argv[n])
            if os.path.exists( r ):
                if os.path.splitext( r )[-1].lower() == '.rib':
                    sys.argv[n] = r
                if '/maya/' in r:
                    r = r.split('/maya/')
                    if len(r) > 1:
                        os.chdir(  "%s/maya/" %  r[0]  )
        sys.stderr.write("\n%s\n" %  os.getcwd())
        
        os.system( 'find $HOME/maya/ -name "shelf_RenderMan*" -exec rm {} \;' )
