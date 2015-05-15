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


import IECore, pipe, os
exec( pipe.include( __file__ ) )


class maya( render ) :
    
    def __init__( self ) :
        self.bkp = {}
        start = 0
        end = 0
        byFrameStep = 1
        override = 0
        currentRenderer = '3delight'
        if m:
            override = 1
            start = m.getAttr('defaultRenderGlobals.startFrame')
            end = m.getAttr('defaultRenderGlobals.endFrame')
            byFrameStep = m.getAttr('defaultRenderGlobals.byFrameStep')
            currentRenderer = str(m.getAttr('defaultRenderGlobals.currentRenderer')).replace('_','')
            if currentRenderer != '3delight':
                currentRenderer = 'other'
        
        filter='*'
        if os.environ.has_key('IECORE_ASSET_RENDER_MAYA_OP_FILTER'): 
            filter = os.environ['IECORE_ASSET_RENDER_MAYA_OP_FILTER'] 
        if not os.environ.has_key('IECORE_ASSET_RENDER_MAYA_OP_PATHS'): 
            os.environ['IECORE_ASSET_RENDER_MAYA_OP_PATHS'] = "%s/renderer" % os.path.dirname(__file__)
            
#        self.classLoader = IECore.ClassLoader.defaultLoader( "IECORE_ASSET_RENDER_MAYA_OP_PATHS" )
        
        disabled={"UI":{ "invertEnabled" : IECore.BoolData(True) }}
        pars = [
            IECore.CompoundParameter("FrameRange","",[   
#                IECore.BoolParameter("override","Check this to override the frame range defined in the file.",override),
                IECore.V3fParameter("range","Inicio, fim e 'step' da sequencia a ser rendida.",IECore.V3f(start, end, byFrameStep), userData=disabled),
            ],userData = { "UI": {"collapsed" : IECore.BoolData(False)}}),
            IECore.StringParameter(
                name="RenderEngine",
                description = "Configuracao do render a ser usado.",
                defaultValue = currentRenderer,
                presets = [('3delight','3delight'),('other','other')],
                presetsOnly = True,
            ),
        ]
            
        if m and currentRenderer == '3delight':
            rps = []
            for each in m.ls(type='delightRenderPass'):
                if 'default' not in each.lower():
                    rps.append(
                        IECore.BoolParameter(
                            name=each,
                            description = "Check this to render.",
                            defaultValue = IECore.BoolData(True),
                        )
                    )
            pars.append( IECore.CompoundParameter("RenderPasses","",rps,userData = { "UI": {"collapsed" : IECore.BoolData(False)}}) )
                
#            IECore.ClassParameter(
#                    "Renderer",
#                    "O renderer a ser usado",
#                    "IECORE_ASSET_RENDER_MAYA_OP_PATHS",
#                    userData = { "UI": {
#                        "collapsed" : IECore.BoolData(False),
#                        "classNameFilter" : IECore.StringData(filter),
#                    }},
#            ),

        render.__init__(self, 'maya', '', 'maya/scenes',   pars )

    def parameterChanged(self, parameter):
        print parameter
#        self.parameters()['delightRenderPasses'].userData()['UI']['visible'] = IECore.BoolData(False)
#        if parameter.name == 'RenderEngine':
#            if m:
#                renderPasses = m.ls(type='delightRenderPass')
#                print renderPasses 
#            self.parameters()['delightRenderPasses'].userData()['UI']['visible'] = IECore.BoolData(True)
#        self.parameters().addParameters([
#            IECore.BoolParameter(
#                name="teste",
#                description = "Check this to render.",
#                defaultValue = IECore.BoolData(True),
#            )])

        
    def projectRoot(self, path=None):
        path = str(path)
        if path == '/':
            return path
        if os.path.exists( '%s/workspace.mel' % path ):
            return path
        return self.projectRoot(os.path.dirname(path))
        
    def preUI(self, parameters):
        pass
    
    def msetAttr(self, par, value):
        ''' set an attr in a maya node, and save the original value to be restored later '''
        if m:
            if m.objExists(par):
                # save only if not already saved. this avoid destroying
                # an originally saved value if we set it more than once!
                if par not in self.bkp.keys():
                    self.bkp[par] = m.getAttr( par )
                    
                if type(value) in [type(u''), type('')]:
                    m.setAttr( par, value, type="string" )
                else:
                    m.setAttr( par, value )                
                
            
    
    def prePublish( self, operands ):
        ''' publish runs this method before publishing an asset.
        we can use it to prepare the asset to be published! '''
        pass

    def postPublish(self, operands, finishedSuscessfuly=False):
        ''' publish runs this method after publishing an asset or after an error. 
        we can use it to restore the asset to original state! '''
        
        render       = str(operands['Asset']['type']['RenderEngine'])
        
        # we restore the displays to the proper display driver 
        # if we indeed backed it up!
        if m and render == '3delight':
            for rp in self.bkp:
                if type(self.bkp[rp]) == type(u'') or type(self.bkp[rp]) == type(''):
                    if 'displayDrivers' in rp:
                        m.setAttr( rp, "idisplay", type="string" )
                    else:
                        m.setAttr( rp, self.bkp[rp], type="string" )
                else:
                    m.setAttr( rp, self.bkp[rp])

                # export ribs and render
                m.setAttr( rp.split('.')[0]+".renderMode", 3 )

                # restore rib file name
                m.setAttr( "%s.ribFilename" % rp.split('.')[0], '3delight/<scene>/rib/<scene>_<pass>_#.rib', type="string"  )
                m.setAttr( "%s.renderLogFilename" % rp.split('.')[0], '3delight/<scene>/rib/<scene>_<pass>_#.log', type="string"  )

        # if publish was suscessfull, run this! 
        if finishedSuscessfuly:
            if m:
                # set the current published asset info for next time the asset publish runs
                if not m.objExists( "defaultRenderGlobals.pipe_asset_name" ):
                    m.addAttr( "defaultRenderGlobals", ln="pipe_asset_name", dt="string" )
                m.setAttr( "defaultRenderGlobals.pipe_asset_name", str(operands['Asset']['info']['name']), type='string')

                if not m.objExists( "defaultRenderGlobals.pipe_asset_version" ):
                    m.addAttr( "defaultRenderGlobals", ln="pipe_asset_version", dt="string" )
                assetVersion = map(lambda x: '%02d' % int(x), str(operands['Asset']['info']['version']).split())
                m.setAttr( "defaultRenderGlobals.pipe_asset_version", '.'.join(assetVersion), type='string')

                if not m.objExists( "defaultRenderGlobals.pipe_asset_description" ):
                    m.addAttr( "defaultRenderGlobals", ln="pipe_asset_description", dt="string" )
                desc = str(operands['Asset']['info']['description'])
                m.setAttr( "defaultRenderGlobals.pipe_asset_description", desc, type='string')
                
                
        if m:
            # save to repair the working scene as it was before.
            # at this point, the scene has already being published, so 
            # we can save it safely without affecting the published asset!
            m.file(s=1)
        
                    
    def doOperation( self, operands ):
        sceneName           = str(operands['mayaScene'])
        mayaOutput          = str(operands['mayaOutput'])
        frameRange          = operands['FrameRange']['range'].value
        render              = str(operands['RenderEngine'])
        self.renderPasses   = []
        self.ribs           = []

        if not m:
            return IECore.StringData( 'ERROR - We need to submit from within maya!' )


        if render != '3delight':
            # set proper verbosity and others for arnold!
            self.msetAttr("defaultArnoldRenderOptions.shaderNanChecks", 1)
            self.msetAttr("defaultArnoldRenderOptions.log_verbosity", 1)
            self.msetAttr("defaultArnoldRenderOptions.log_to_console", 1)
            m.file(s=1)
        
        else:
            # self.files will be used by submission method 
            self.files      = []
            
            # gather selected renderpasses for rib generation
            if 'RenderPasses' in operands.keys():
                for each in operands['RenderPasses'].keys():
                    if operands['RenderPasses'][each].value:
                        self.renderPasses.append(each)
                        
            # generate rib files for submission
            from glob import glob
            
            # first, save the current scene name and change it to the name of our asset, 
            # so 3delight will generate its files with this name! 
            bkpSceneName = m.file( q=1, sn=1 )
#                assetSceneName = '%s_%s' % (self.data['assetName'], self.data['assetVersion']) 
            assetSceneName = self.data['assetName']
            
            # source DL_renderPass just in case, to garantee we have 
            # DRP_setDisplayQuantizeAttrs
            meval("source DL_renderPass") 

            for each in self.renderPasses:
                # interact over all displays of renderpass
                # and set then to EXR 32bits float
                renderables = meval('DRP_getDisplayIndices("%s")' % each)
                for n in range(len(renderables)):
                        # set display driver to exr
                        self.msetAttr( '%s.displayDrivers[%s]' % (each, str(n)), "exr" )
                            
                        # set display depth to 32 bit float
                        meval('DRP_setDisplayQuantizeAttrs( "%s", %s, 0,0,0,0,0)' % (each,str(n)) )

                # now configure 
                self.msetAttr("%s.renderMode" % each, 1)
                self.msetAttr("%s.animation"  % each, 1)
                self.msetAttr("%s.startFrame" % each, frameRange.x)
                self.msetAttr("%s.endFrame"   % each, frameRange.y)
                self.msetAttr("%s.increment"  % each, frameRange.z)
                
                self.msetAttr("%s.binaryRib" % each, 1)
                self.msetAttr("%s.compressedRib" % each, 1)
                self.msetAttr("%s.progressiveRender" % each, 0)
                
                # make a list of the created ribs for submission
                self.files.append("%s/3delight/%s/rib/%s_%s_#.rib" % (
                    pipe.admin.job().shot.user().path('maya'),
                    assetSceneName,
                    assetSceneName,
                    each
                ))
                
                self.msetAttr( "%s.ribFilename" % each, self.files[-1] )
                self.msetAttr( "%s.renderLogFilename" % each, self.files[-1].replace('.rib','.log') )
                
                # set animation to zero to generate rib on the fly
                self.msetAttr("%s.animation"  % each, 0)

#                    # generate ribs!
#                    meval("delightRenderMenuItemCommand %s" % each)
                
#                    # check if all ribs are there, otherwise, it was cancelled!
#                    nribs = len( glob( self.files[-1].replace('_#.rib', '_*.rib') ) )
#                    nframes = len( range( frameRange.x, frameRange.y, frameRange.z ) )+1
#                    print nribs, nframes
#                    if nribs !=  nframes:
#                        from  shutil import rmtree
#                        rmtree(self.files[-1].split('/rib/')[0], True)
#                        return IECore.StringData( "ERROR: RIB generation was not completed. Can't publish asset!" )

            
            # delete this to force submission to submit the maya scene instead of ribs!!
            self.ribs = self.files
            del self.files
            # save file so it can be published!
            m.file(s=1)
        
        return IECore.StringData( 'done' )
        
        
        
        
    def gather(self, operands):
        ''' gather op calls this method to gather the asset!'''
        if m:
            path = "%s/%s/%s" % ( operands["Asset"]["type"], operands["Asset"]["info"]["name"], operands["Asset"]["info"]["version"] )
            data = Asset.AssetParameter(path).getData()
            m.file(f=1, o=data['publishFile'])
            m.file(rn=pipe.admin.job().shot.user().path('maya/scenes/%s' % os.path.basename(data['publishFile']) ))
        
        
    def submission( self, operands ):
        ''' publish calls submission to send to farm'''
        data = self.data
        assetPath           = str(data['assetPath'])
        publishFile         = str(data['publishFile'])
        publishPath         = str(data['publishPath'])
        mayaOutput          = str(operands['mayaOutput'])
        render              = str(operands['RenderEngine'])
        frameRange          = operands['FrameRange']['range'].value
        
        if not hasattr( self, 'files' ):
            self.files = [publishFile]
            
        
        jobids = []
        # interact over rib files
        for each in self.files:
            while '##' in each:
                each.replace('##','#')
            jobid = pipe.farm.maya(
                scene       = each.replace( '#', pipe.farm.maya.frameNumber() ), 
                ribs        = map(lambda x: x.replace( '#', pipe.farm.maya.frameNumber() ), self.ribs),
                asset       = publishPath,
                project     = self.projectRoot(assetPath), 
                extra       = self.renderPasses,
                renderer    = render, 
                name        = 'RENDER ASSET: %s_%s' % (data['assetName'],data['assetVersion']) , 
                CPUS        = 9999, 
                priority    = 9999, 
                range       = range(int(frameRange.x), int(frameRange.y+frameRange.z), int(frameRange.z)), 
                group       = 'pipe'
            ).submit()
            print 'job id: %s' % str(jobid)
            jobids.append(str(jobid))


        '''
            TODO:
            We need to first generate rib, running maya with a script to generate then at the given 
            framerange and renderpass, OR generate rib inside prePublish, and publish the whole 3dfm
            folder together with maya scene (then farm will actually just be run renderdl)!!!
          
        '''

        return IECore.StringData( ','.join(jobids) )

IECore.registerRunTimeTyped( maya )
