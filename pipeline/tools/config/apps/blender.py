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


class blender(baseApp):

    def environ(self):
        # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
        # self.ignorePipeLib( "freetype" )

        self.insert('PATH',0, self.path('$BLENDER_VERSION_MAJOR/python/bin'))
        self.insert('PYTHONPATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/python3.7/'))
        self.insert('PYTHONPATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/python3.7/site-packages/'))
        self.insert('PYTHONPATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/python3.7/lib-dynload/'))
        self.insert('LD_LIBRARY_PATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/python3.7/lib-dynload/'))

        self.update(cgru())
        self.update(cortex())
        self.update(gaffer())

    @staticmethod
    def addon(caller, plugin="", script="", icon="", lib=''):
        ''' the addon method MUST be implemented for all classes so other apps can set up
        searchpaths for this app. For example, another app which has plugins for this one!'''
        caller['BLENDER_USER_SCRIPTS']      = plugin
        caller['BLENDER_USER_SCRIPTS']      = script
        caller['LD_LIBRARY_PATH']           = lib


    def preRun(self, cmd):
        l=os.environ['LD_LIBRARY_PATH'].split(':')
        os.environ['LD_LIBRARY_PATH'] = ''
        for each in l:
            if self.path('lib') not in each:
                os.environ['LD_LIBRARY_PATH'] = ':'.join([ each, os.environ['LD_LIBRARY_PATH'] ])

        return cmd

    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        # self['XDG_CONFIG_HOME'] = jobuser.path()



        # self.ignorePipeLib( "tiff" )
        # self.ignorePipeLib( "libpng" )
        # self.ignorePipeLib( "jpeg" )
        # self.ignorePipeLib( "log4cplus" )
        # self.ignorePipeLib( "libraw" )
        # self.ignorePipeLib( "tbb" )
        # self.ignorePipeLib( "qt" )
        # self.ignorePipeLib( "oiio" )
        # self.ignorePipeLib( "ocio" )
        # self.ignorePipeLib( "python" )
        # self.ignorePipeLib( "jasper" )
        # self.ignorePipeLib( "gmp" )
        # self.ignorePipeLib( "osl" )
        # self.ignorePipeLib( "openvdb" )
        # self.ignorePipeLib( "cortex" )
        # self.ignorePipeLib( "glfw" )
        # self.ignorePipeLib( "glew" )
        # self.ignorePipeLib( "freeglut" )
        # self.ignorePipeLib( "openssl" )
        # self.ignorePipeLib( "hdf5" )
        # self.ignorePipeLib( "mpc" )
        # self.ignorePipeLib( "llvm" )
        # self.ignorePipeLib( "flex" )
        # self.ignorePipeLib( "icu" )
        # self.ignorePipeLib( "mpfr" )
        # self.ignorePipeLib( "ilmbase" )
        # self.ignorePipeLib( "openexr" )
        # self.ignorePipeLib( "freetype" )
        # self.ignorePipeLib( "libaudio" )
        # self.ignorePipeLib( "gaffer" )
        # self.ignorePipeLib( "boost" )


    # def bg(self, cmd, bin):
    #     ''' return True if a cmd or binary should run in background '''
    #     return True
