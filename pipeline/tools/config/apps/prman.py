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
    def RMAN_MAYA_NAME(self):
        RMAN_MAYA_NAME = 'RenderManStudio'
        if float(self.version()) >= 21.0:
            RMAN_MAYA_NAME = 'RenderManForMaya'
        return RMAN_MAYA_NAME


    def environ(self):
        import socket
        from glob import glob



        mayaPluginName = 'RenderManForMaya'

        folders=[]
        rmantree = self.path('RenderManProServer-$PRMAN_VERSION')
        self['RMANTREE'] = rmantree
        self['LD_LIBRARY_PATH'] = "%s/lib" % rmantree

        if self.parent() in ['prman','houdini','gaffer']:
            pipe.version.set( python = '2.7' )
            pipe.libs.version.set( python = '2.7' )
            self.update( cortex() )

            folders.append(rmantree)
            self['PATH']            = "%s/bin" % rmantree
            self['PYTHONPATH']      = "%s/bin" % rmantree
            self['LD_LIBRARY_PATH'] = "%s/lib" % rmantree
            self['LD_LIBRARY_PATH'] = "%s/lib/rif" % rmantree
            self['LD_LIBRARY_PATH'] = "%s/bin" % rmantree
            self['LD_LIBRARY_PATH'] = "%s/etc" % rmantree
            self.update( golaem() )
            self.update( shave() )
            if self.parent() not in ['gaffer']:
                self.update( maya() )

            if self.parent() in ['prman','gaffer']:
                self['LD_PRELOAD'] = pipe.libs.python().LD_PRELOAD()

        # setup main renderman env vars!
        rmstree = self.path('%s-$PRMAN_VERSION-maya$MAYA_VERSION' % self.RMAN_MAYA_NAME())
        if not os.path.exists(rmstree):
            rmstree = self.path('%s-$PRMAN_VERSION' % self.RMAN_MAYA_NAME())
        if self.parent() not in ['houdini']:
            folders.append(rmstree)
            self['RMSTREE']  = rmstree
            self['PATH']     = "%s/bin" % rmstree
            self['PATH']     = "%s/rmantree/bin" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/lib/rif" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/lib" % rmstree
            self['LD_LIBRARY_PATH'] = "%s/rmantree/lib" % rmstree
            self['RMS_SCRIPT_PATHS'] = '%s/etc/'     % rmstree

            # self['LD_LIBRARY_PATH'] = "%s/rmantree/lib" % rmstree
            # self['LD_LIBRARY_PATH'] = "%s/bin" % rmstree
            # self['LD_LIBRARY_PATH'] = "%s/etc" % rmstree
            # self['LD_LIBRARY_PATH'] = "%s/rmantree/bin" % rmstree
            # self['LD_LIBRARY_PATH'] = "%s/rmantree/etc" % rmstree
            maya.addon(self,
                    plugin      = '%s/plug-ins' % rmstree,
                    script      = '%s/scripts'  % rmstree,
                    icon        = '%s/icons'    % rmstree,
                    renderDesc  = '%s/etc'      % rmstree,
                    lib         = '%s/lib'      % rmstree,
                    preset      = '%s/presets'  % rmstree,
                    module      = '%s/etc'      % rmstree,
                )

        prman.addon(self,
            shader = [
                "%s/lib/plugins/" % rmstree,
                "%s/lib/plugins/" % rmantree,
                "%s/lib/shaders/" % rmstree,
                "%s/lib/shaders/" % rmantree,
            ],
            lib = [
                "%s/lib/plugins/" % rmstree,
                "%s/lib/plugins/" % rmantree,
                "%s/lib/shaders/" % rmstree,
                "%s/lib/shaders/" % rmantree,
            ],
            procedurals = [
                    '%s/rmantree/etc' % rmstree,
                    '%s/etc' % rmantree,
                    "%s/lib/plugins/" % rmantree,
        ])


        for p in glob("%s/prman/mayaLibrary/*"  % pipe.roots().tools()):
            self['MAYA_SHADER_LIBRARY_PATH'] = p

        #if self.parent  in ['nuke']:
        for each in folders:
            prman.addon(self,
                python=[
                    '%s/scripts'        % each,
                    '%s/rfm'            % each,
                    '%s/lib/it/python/' % each,
                    '%s/lib/python2.7/' % each,
                    '%s/lib/python2.7/site-packages' % each,
                ],shader=[
                    '%s/lib/shaders'     % each,
                    '%s/lib/rsl/shaders' % each,
                    '%s/lib/textures'    % each,
            ])

        # add tools paths
        self['CUSTOM_RENDERMAN_PATH'] = '%s/prman/'         % pipe.roots().tools()
        self['RMS_SCRIPT_PATHS']      = '%s/prman/scripts/' % pipe.roots().tools()
        self['RMS_SCRIPT_PATHS']      = '%s/prman/etc/%s'   % (pipe.roots().tools(), self.version())
        self['RMS_SCRIPT_PATHS']      = '%s/prman/etc/'     % pipe.roots().tools()
        self['RDIR'] 		          = '%s/prman/etc/%s'   % (pipe.roots().tools(), self.version())
        self['RDIR'] 		          = '%s/prman/etc/'     % pipe.roots().tools()
        self['RMAN_CONFIG_OVERRIDE']  = '%s/prman/etc/%s'   % (pipe.roots().tools(), self.version())
        self['RMAN_CONFIG_OVERRIDE']  = '%s/prman/etc/'     % pipe.roots().tools()
        for each in self.toolsPaths():
            prman.addon(self,
                python = '%s/prman/python'      % each,
                shader = [
                    '%s/prman/shaders'     % each,
                    '%s/prman/ris/$PRMAN_VERSION/pattern' % each,
                    '%s/prman/ris/$PRMAN_VERSION/integrator' % each,
                ],
                procedurals = [
                    '%s/prman/procedurals' % each,
                    '%s/prman/procedurals/$PRMAN_VERSION' % each,
                    '%s/prman/ris/$PRMAN_VERSION/integrator' % each,
                ]
            )


        # add houdini setup to use prman
        # http://archive.sidefx.com/docs/houdini15.0/render/renderman
        self['HOUDINI_DEFAULT_RIB_RENDERER']="prman%s" % self.version()
        # HOUDINI_VIEW_RMAN=renderdl
        # HOUDINI_RI_SHADERPATH
        #HOUDINI_RI_RIXPLUGINPATH

        # self['RMSDEBUG'] = '1'

        # self.ignorePipeLib( "libpng" )

    @staticmethod
    def addon( caller, shader='', procedurals='', script='',python='', display='', texture='', lib='', rsl='' ):
        caller['PYTHONPATH'] = script
        caller['PYTHONPATH'] = python
        caller['SHADERS_PATH'] = shader
        caller['SHADERS_PATH'] = display
        caller['DISPLAYS_PATH'] = display
        caller['DISPLAY_PATH'] = display
        caller['PROCEDURALS_PATH'] = procedurals
        caller['PROCEDURAL_PATH'] = procedurals
        caller['RMS_SHADER_PATH'] = shader
        caller['RMS_DISPLAYS_PATH'] = display
        caller['RMS_PROCEDURAL_PATH'] = procedurals
        caller['TEXTURES_PATH'] = texture
        caller['LD_LIBRARY_PATH'] = display
        caller['LD_LIBRARY_PATH'] = lib
        # gaffer hack
        caller['DL_SHADERS_PATH'] = shader
        caller['DL_DISPLAYS_PATH'] = display


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
        RMAN_MAYA_NAME = self.RMAN_MAYA_NAME()
        ret = []
        idx = {}
        for f in glob(self.path('%s-%s-maya%s/bin/*' % (RMAN_MAYA_NAME,v,mv))):
            bf = os.path.basename(f).strip()
            if len(bf.split('.'))<2:
                idx[bf] = '%s-%s-maya%s/bin/%s' % (RMAN_MAYA_NAME,v,mv,bf)

        for f in glob(self.path('%s-%s-maya%s/rmantree/bin/*' % (RMAN_MAYA_NAME,v,mv))):
            bf = os.path.basename(f).strip()
            if len(bf.split('.'))<2:
                idx[bf] = '%s-%s-maya%s/rmantree/bin/%s' % (RMAN_MAYA_NAME,v,mv,bf)

        for f in glob(self.path('RenderManProServer-%s/bin/*' % v)):
            bf = os.path.basename(f).strip()
            if bf not in idx:
                if len(bf.split('.'))<2:
                    idx[bf] = 'RenderManProServer-%s/bin/%s' % (v,bf)

        return map(lambda x: (x, idx[x]), idx.keys() )


    def license(self):
        import socket
        pv = float( pipe.version.get('prman') )
        if pv > 20.0:
            license = '%s/licenses/prman/generic.license.r%s' % (pipe.roots().tools(), int(pv))
            if not os.path.exists(self['PIXAR_LICENSE_FILE']):
                license = '%s/licenses/prman/generic.license.r%s' % (pipe.roots().tools(), pv)
            self['PIXAR_LICENSE_FILE'] = license
        else:
            self['PIXAR_LICENSE_FILE'] = '%s/licenses/prman/generic.license' % pipe.roots().tools()


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

        # remove maya shelf so it's recreated when maya starts
        os.system( 'find $HOME/maya/ -name "shelf_RenderMan*" -exec rm {} \;' )

        # cleanup env vars if they already exist, to avoid problems
        if self.parent() in ['prman']:
            for env in ['RMANTREE', 'RMSTREE', 'SHADERS_PATH', 'TEXTURES_PATH' ]:
                if os.environ.has_key(env):
                    del os.environ[env]
