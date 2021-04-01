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


class python(baseLib):
    '''
    WARNING: in newer debian/ubuntu distros, we need this to make things work correctly:
        sudo ln -s /usr/lib/python2.7/config-x86_64-linux-gnu/ /usr/lib/python2.7/config

    when python complains it cant open config/Makefile!
    '''
    def environ(self):
        from glob import glob
        parent = self.parent()
        # force the system libraries to be preloaded since we have OIIO and OCIO
        # compiled with the system libraries.
        # we have to remove this once OIIO and OCIO are properly build with the pipe gcc!
        if self.parent() not in ['nuke']:
            self['LD_PRELOAD'] = pipe.latestGCCLibrary("libstdc++.so.6")
            self['LD_PRELOAD'] = pipe.latestGCCLibrary("libgcc_s.so.1")
            
        # if nuke version < 8.0 or gaffer, force to load our libpython shared lib
        if parent in ['nuke','gaffer']:
            sharedLib = self.path('lib/libpython%s.so.1.0' % pipe.libs.version.get('python')[:3])
            if os.path.exists(sharedLib):
                if (self.parent()=='nuke' and float(pipe.version.get('nuke')[:3])<8) or self.parent() in ['gaffer']:
                    self['LD_PRELOAD'] = sharedLib


        # set PYTHONHOME for some apps...
        if self.parent() in ['python','delight','houdini','cortex', 'qube', 'unreal']:
            self['PYTHONHOME'] = self.path()
            # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
            self.ignorePipeLib( "freetype" )

        if self.parent() in ['python','cortex','gaffer']:
            # if self.parent() in ['python']:
            #     self.update( maya() )
            #     self.ignorePipeLib( "qt" )

            # initialize cortex environment so we can load its modules.
            # self.update( cortex() )
            # self.update( gaffer() )
            self.update( pipe.libs.cortex() )
            self.update( pipe.libs.gaffer() )

            # also, initialize buildStuff in case theres some pythonmodules there.
            self.update( buildStuff() )

            # also, initialize wx
            self.update( wxpython() )
            self.update( qube() )
            self.update( cgru() )

        self['PYTHONPATH'] = self.path('/lib/python2.7/lib-dynload/')

        if self.parent() in ['maya']:
            for each in glob('%s/lib/python*/site-packages/*.egg' % self.path()):
                self['PYTHONPATH'] = each

    def bins(self):
        return [('python', 'python')]
