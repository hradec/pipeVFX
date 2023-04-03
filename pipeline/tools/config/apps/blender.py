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
        from glob import glob

        blenderVersionMajor = '.'.join(pipe.apps.version.get('blender').split('.')[:2])

        pythonVersion = cached.glob( self.path('%s/python/lib/python*' % blenderVersionMajor) )
        if pythonVersion:
                pythonVersion = os.path.basename( pythonVersion[0] )
        else:
                pythonVersion = 'python2.7'

        self.insert('PATH',0, self.path('$BLENDER_VERSION_MAJOR/python/bin'))
        self.insert('PYTHONPATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/%s/' % pythonVersion))
        self.insert('PYTHONPATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/%s/site-packages/' % pythonVersion))
        self.insert('PYTHONPATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/%s/lib-dynload/' % pythonVersion))
        self.insert('LD_LIBRARY_PATH',0, self.path('$BLENDER_VERSION_MAJOR/python/lib/%s/lib-dynload/' % pythonVersion))

        # self['BLENDER_USER_SCRIPTS'] = '%s/blender/' % self.toolsPaths()[-1]

        # for each in self.toolsPaths():
        #     blender.addon(self, plugin='%s/blender/$BLENDER_VERSION_MAJOR/' % each)
        #     blender.addon(self, plugin='%s/blender/$BLENDER_VERSION_MAJOR/addons/' % each)
        #     blender.addon(self, python='%s/blender/$BLENDER_VERSION_MAJOR/python/' % each)
        #     blender.addon(self, plugin='%s/blender/' % each)
        #     blender.addon(self, plugin='%s/blender/addons/' % each)
        #     blender.addon(self, python='%s/blender/python/' % each)

        self.update(cgru())
        self.update(cortex())
        self.update(gaffer())

    @staticmethod
    def addon(caller, plugin="", script="", icon="", lib='', python=''):
        ''' the addon method MUST be implemented for all classes so other apps can set up
        searchpaths for this app. For example, another app which has plugins for this one!'''
        caller['BLENDER_USER_SCRIPTS']      = plugin
        # caller['BLENDER_USER_SCRIPTS']      = script
        caller['BLENDER_SCRIPTS'] = plugin
        caller['BLENDER_SCRIPTS'] = script
        caller['LD_LIBRARY_PATH'] = lib
        caller['PYTHONPATH']      = python
        caller['PYTHONPATH']      = plugin
        caller['PYTHONPATH']      = script

    def bins(self):
        ret = [
            # ('blender', 'blender --python-use-system-env'),
            ('blender', 'blender'),
        ]
        return ret

    def preRun(self, cmd):
        l=os.environ['LD_LIBRARY_PATH'].split(':')
        os.environ['LD_LIBRARY_PATH'] = ''
        for each in l:
            if self.path('lib') not in each:
                os.environ['LD_LIBRARY_PATH'] = ':'.join([ each, os.environ['LD_LIBRARY_PATH'] ])

        return cmd

    def postRun(self, cmd, returnCode, returnLog=""):
        ''' this is called after a binary of this class has exited.
        it's the perfect method to do post render frame checks, for example!'''
        error = returnCode!=0
        images=[]

        # if Render in cmd
        if 'blender' in cmd and '-b' in cmd:

            # and 'Writing' in the log, do a frame check!
            if 'Saved:' in returnLog:

                # collect image files from output log
                images = [ x.split('Saved: ')[-1].strip().strip("'") for x in returnLog.split('\n') if 'Saved:' in x]

        # run our pipe.frame.check generic frame check for the gathered image list
        if images:
            error = pipe.frame.check( images )

        # return a posix error code if we got an error, so the farm engine
        # will get a proper error!
        return int(error)*255

    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        # self['XDG_CONFIG_HOME'] = jobuser.path()
