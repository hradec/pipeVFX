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


class cortex(baseLib):
    def versions(self):
        # if float(pipe.libs.version.get('openexr')[:3]) < 2.2:
        #     pipe.libs.version.set( openexr='2.2')
        #     pipe.libs.version.set( ilmbase='2.2')

        if float(pipe.libs.version.get('cortex')[:4]) >= 10.0:
            if float(pipe.libs.version.get('boost')[:4]) < 1.55:
                pipe.libs.version.set( boost='1.55')


    #     if self.parent() in 'gaffer':
    #         if float(pipe.version.get('gaffer')[:3]) < 2.0  and float(pipe.version.get('gaffer')[:3])!=0.30:
    #             if float(pipe.libs.version.get('cortex')[:1]) >= 9:
    #                 pipe.libs.version.set(  cortex = '8.4.7' )
    #                 pipe.libs.version.set(  boost = '1.5.2' )
    #                 pipe.libs.version.set(  tbb = '2.2.004' )

    def environ(self):
        parent = self.parent()

        self['PYTHON_VERSION_MAJOR'] = '.'.join(pipe.libs.version.get('python').split('.')[:2])

        # workaround to prevent a bug in environ class!! TODO: Fix the bug!!
        if type(self['PYTHONPATH']) == str:
            self['PYTHONPATH'] = '/1'
            self['PYTHONPATH'] = '/2'

        # we add this env var for easy copy/paste of houdini paths into other apps/cortex!
        if pipe.admin.job.current():
            self['HIP'] = '$SHOT/houdini'


        # configure maya plugin/scripts/icons
        if parent in ['maya', 'python']:
            pipe.apps.maya.addon ( self,
                plugin = self.path('maya/$MAYA_VERSION/plugins'),
                script = self.path('maya/$MAYA_VERSION/mel'),
                icon   = self.path('maya/$MAYA_VERSION/icons'),
                lib = [
                    self.path('maya/$MAYA_VERSION/lib/python$PYTHON_VERSION_MAJOR'),
                    self.path('maya/$MAYA_VERSION/lib'),
                ],

            )
            self['PYTHONPATH'].insert( 0, self.path('maya/$MAYA_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages') )

        # configure delight - crashes maya if no arnold in the searchpath!!
        if parent in ['delight', 'maya', 'python', 'gaffer'] and os.path.exists(self.path( 'delight/%s' % pipe.apps.version.get('delight') )):
            pipe.apps.delight.addon( self,
                shader=self.path('delight/$DELIGHT_VERSION/rsl'),
                rsl=self.path('delight/$DELIGHT_VERSION/rsl'),
                procedurals=self.path('delight/$DELIGHT_VERSION/procedurals'),
                display=self.path('delight/$DELIGHT_VERSION/displays'),
                texture='',
                lib = [
                    self.path('delight/$DELIGHT_VERSION/lib'),
                    self.path('delight/$DELIGHT_VERSION/lib/python$PYTHON_VERSION_MAJOR'),
                ],
            )
            self['PYTHONPATH'].insert( 0,self.path('delight/$DELIGHT_VERSION/lib/python$PYTHON_VERSION_MAJOR') )
            self['PYTHONPATH'].insert( 0,self.path('delight/$DELIGHT_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages') )

        # configure prman
        if parent in ['prman', 'maya', 'gaffer', 'python', 'houdini'] and os.path.exists(self.path( 'prman/%s' % pipe.apps.version.get('prman') )):
            pipe.apps.prman.addon( self,
                shader=self.path('prman/$PRMAN_VERSION/rsl'),
                rsl=self.path('prman/$PRMAN_VERSION/rsl'),
                procedurals=self.path('prman/$PRMAN_VERSION/procedurals'),
                display=self.path('prman/$PRMAN_VERSION/displays'),
                texture='',
                lib = [
                    self.path('prman/$PRMAN_VERSION/lib'),
                    self.path('prman/$PRMAN_VERSION/lib/python$PYTHON_VERSION_MAJOR'),
                ],
            )
            self['PYTHONPATH'].insert( 0,self.path('prman/$PRMAN_VERSION/lib/python$PYTHON_VERSION_MAJOR') )
            self['PYTHONPATH'].insert( 0,self.path('prman/$PRMAN_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages') )

        #configure arnold - crashes maya if no arnold in the searchpath!!
        # if parent in ['arnold', 'maya']  and os.path.exists(self.path( 'arnold/%s' % pipe.apps.version.get('arnold') )):
        #     arnold.addon( self,
        #         procedurals=self.path('arnold/$ARNOLD_VERSION/procedurals'),
        #         display=self.path('arnold/$ARNOLD_VERSION/displays'),
        #         extensions=self.path('arnold/$ARNOLD_VERSION/mtoaExtensions/$MAYA_VERSION/'),
        #         lib = [
        #             self.path('arnold/$ARNOLD_VERSION/lib/python$PYTHON_VERSION_MAJOR'),
        #             self.path('arnold/$ARNOLD_VERSION/lib'),
        #         ],
        #     )
        #     self['PYTHONPATH'] = self.path('arnold/$ARNOLD_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages')

        # configure nuke
        if parent == 'nuke':
            pipe.apps.nuke.addon( self,
                nukepath = self.path('nuke/$NUKE_VERSION/plugins'),
                lib = [
                    self.path('nuke/$NUKE_VERSION/lib/python$PYTHON_VERSION_MAJOR'),
                    self.path('nuke/$NUKE_VERSION/lib'),
                ],
            )
            self['PYTHONPATH'].insert( 0,self.path('nuke/$NUKE_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages') )

        #configure houdini
        if parent in ['houdini', 'python']:
            pipe.apps.houdini.addon(self,
                otl=self.path('houdini/$HOUDINI_VERSION/otls'),
                toolbar=self.path('houdini/$HOUDINI_VERSION/toolbar'),
                icon=self.path('houdini/$HOUDINI_VERSION/icons'),
                lib = [
                    self.path('houdini/$HOUDINI_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages/IECoreHoudini'),
                    self.path('houdini/$HOUDINI_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages/IECoreMantra'),
                    self.path('houdini/$HOUDINI_VERSION/lib'),
                    self.path('alembic/$ALEMBIC_VERSION/lib'),
                ],
                dso=[
                    self.path('houdini/$HOUDINI_VERSION/dso'),
                    # self.path('houdini/$HOUDINI_VERSION/dso/mantra'),
                ],
            )
            self['PYTHONPATH'] = self.path('houdini/$HOUDINI_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages')

        #configure python
        self['PYTHONPATH'] = self.path('lib/python$PYTHON_VERSION_MAJOR/site-packages')
        self['PYTHONPATH'] = self.path('lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages')
        self['PYTHONPATH'] = self.path('lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages')
        self['PYTHONPATH'] = self.path('alembic/$ALEMBIC_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages')


        #add cortex paths
        cortex.addon(self,
            # scripts = self.path('lib/python$PYTHON_VERSION_MAJOR/site-packages'),
            procedurals = self.path('procedurals'),
            ops = self.path('ops'),
            glsl = self.path('glsl'),
            glslInclude = [
                self.path('glsl'),
                self.path('glsl/IECoreGL'),
            ],
            lib = [
                self.path('lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR'),
                self.path('lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR'),
                self.path('lib/boost$BOOST_VERSION'),
                self.path('lib/boost.$BOOST_VERSION'),
                self.path('lib/python$PYTHON_VERSION_MAJOR'),
                self.path('lib'),
                self.path('alembic/$ALEMBIC_VERSION/lib/boost$BOOST_VERSION/'),
                self.path('alembic/$ALEMBIC_VERSION/lib/boost.$BOOST_VERSION/'),
                self.path('alembic/$ALEMBIC_VERSION'),
                self.path('openvdb/$OPENVDB_VERSION/lib/boost$BOOST_VERSION/'),
                self.path('openvdb/$OPENVDB_VERSION/lib/boost.$BOOST_VERSION/'),
                self.path('openvdb/$OPENVDB_VERSION'),
                self.path('usd/$USD_VERSION/lib/boost$BOOST_VERSION/'),
                self.path('usd/$USD_VERSION/lib/boost.$BOOST_VERSION/'),
                self.path('usd/$USD_VERSION'),
                self.path('appleseed/$APPLESEED_VERSION/lib/'),
                self.path('appleseed/$APPLESEED_VERSION'),
            ],
            scripts = [
                self.path('lib/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('alembic/$ALEMBIC_VERSION/lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('alembic/$ALEMBIC_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('openvdb/$OPENVDB_VERSION/lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('openvdb/$OPENVDB_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('openvdb/$OPENVDB_VERSION/python'),
                self.path('usd/$USD_VERSION/lib/boost$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('usd/$USD_VERSION/lib/boost.$BOOST_VERSION/python$PYTHON_VERSION_MAJOR/site-packages'),
                self.path('appleseed/$APPLESEED_VERSION/lib/python$PYTHON_VERSION_MAJOR/site-packages'),
            ],
        )
        appleseed.addon( self, display=self.path('appleseed/$APPLESEED_VERSION/displays/') )


        #add tools paths
        for each in self.toolsPaths():
            studio = ""
#            studio = "$STUDIO"
            if 'jobs' in each:
                studio = ""
            cortex.addon(self,
                procedurals = [
                        '%s/cortex/procedurals/%s' % (each, studio),
                        '%s/cortex/$CORTEX_VERSION/procedurals/%s' % (each, studio),
                ],
                ops = [
                       '%s/cortex/ops/%s' % (each, studio),
                       '%s/cortex/$CORTEX_VERSION/ops/%s' % (each, studio),
                ],
                glsl = '%s/cortex/glsl' % each,
                glslInclude = '%s/cortex/glsl/include' % each,
                glFonts = '%s/cortex/fonts' % each,
                scripts = '%s/cortex/python' % each,
            )
            self['IECORE_ASSET_OP_PATHS'] = '%s/config/assets' % each

        self['IECORE_OP_PRESET_PATHS'] = '%s/.config/cortex/preset' % os.environ['HOME']
        self['IECORE_PROCEDURAL_PRESET_PATHS'] = '%s/.config/cortex/preset' % os.environ['HOME']

        try: self.update( pipe.libs.pyilmbase() )
        except: pass
        try: self.update( pipe.libs.openvdb() )
        except: pass
        try: self.update( pipe.libs.alembic() )
        except: pass
        try: self.update( pipe.libs.usd() )
        except: pass

    def bins(self):
        # return [('cpython', 'cpython')]
        return []


    @staticmethod
    def addon(caller, ops="", procedurals="", scripts="", glsl="", glslInclude="", glslTextures="", glFonts="", lib="", display=""):
        caller['IECORE_PROCEDURAL_PATHS'] = procedurals
        caller['IECORE_OP_PATHS']  = ops
        caller['PYTHONPATH']  = scripts
        caller['IECOREGL_SHADER_PATHS'] = glsl
        caller['IECOREGL_SHADER_INCLUDE_PATHS'] = glslInclude
        caller['IECOREGL_TEXTURE_PATHS'] = glslTextures
        caller['IECORE_FONT_PATHS'] = glFonts
        caller['LD_LIBRARY_PATH'] = lib
        caller['DISPLAY'] = display
