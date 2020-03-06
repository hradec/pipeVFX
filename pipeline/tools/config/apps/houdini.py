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


class houdini(baseApp):
    def versions(self):
        ''' set the pipe python version according to houdinis python version '''
        if self.parent() in ['houdini']:
            pv = '2.7'
            if float(pipe.version.get('houdini')[3:].split('.')[0]) < 14.0:
                pv = '2.6'

            pipe.libs.version.set(  python = pv )
            pipe.version.set(  python = pipe.libs.version.get('python') )

            pipe.libs.version.set(  boost = '1.55.0' )

    def environ(self):

        self['HFS'] = self.path()
        self['HOUDINI_PYTHON_VERSION'] = '.'.join( pipe.libs.version.get( 'python' ).split('.')[:2] )
        if self.parent() in ['houdini']:
            self['PYTHON_VERSION_MAJOR'] = self['HOUDINI_PYTHON_VERSION']

        pipe_root = pipe.roots.jobs()
        try:
            pipe_job = os.environ['PIPE_JOB']
            # pipe_shot = os.environ['PIPE_SHOT'].split('@')[1]
            # pipe_user = os.environ['USER']
            self['HSITE'] = '%s/%s/tools/houdini' % (pipe_root,pipe_job)
        except:
            pass

        # self['LD_PRELOAD'] = pipe.libs.boost().LD_PRELOAD()
        # self['LD_PRELOAD'] = pipe.libs.python().LD_PRELOAD()

        # set alembic version since gaffer needs it.
        if self.parent() in ['houdini']:
            # fix for: symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
            self.ignorePipeLib( "freetype" )

            self.ignorePipeLib( "zlib" )
            self.ignorePipeLib( "alembic" )
            self['ALEMBIC_VERSION'] = pipe.libs.version.get( 'alembic' )

            if int(self.version().split('.')[0].replace('hfs','')) == 14:
                self.ignorePipeLib( "qt" )
                self.ignorePipeLib( "tbb" )
                self.ignorePipeLib( "hdf5" )
            else:
                self['LD_PRELOAD'] = "/usr/lib/libstdc++.so.6"
                self.ignorePipeLib( "qt" )
                self.ignorePipeLib( "openssl" )
                self.ignorePipeLib( "tbb" )
                self.ignorePipeLib( "freetype" )
                self.ignorePipeLib( "python" )
                self['LD_PRELOAD'] = self.path('python/lib/libpython2.7.so')
                self['PYTHONHOME'] = self.path('python')

            # add cortex to houdini
            # self.update( prman() )
            self.update( cortex() )
            self.update( gaffer() )
            self.update( cgru() )

            # we need to force houdini python paths to the top
            self.insert('PYTHONPATH',0, self.path('houdini/python%slibs' % '.'.join(pipe.libs.version.get('python').split('.')[:2]) ))
            self.insert('PYTHONPATH',0, self.path('python/lib/python$PYTHON_VERSION_MAJOR/site-packages'))
            self.insert('PYTHONPATH',0, self.path('python/lib/python$PYTHON_VERSION_MAJOR/'))
            # self.insert('PYTHONPATH',0, self.path('dsolib'))

        else:
            # we need to force houdini python paths to the top
            self['PYTHONPATH'] = self.path('houdini/python%slibs' % '.'.join(pipe.libs.version.get('python').split('.')[:2]))
            self['PYTHONPATH'] = self.path('python/lib/python$PYTHON_VERSION_MAJOR/site-packages')
            self['PYTHONPATH'] = self.path('python/lib/python$PYTHON_VERSION_MAJOR/')
            # self['PYTHONPATH'] = self.path('dsolib')


        # more console output when crashes happen
        self['HOUDINI_VERBOSE_ERROR'] = '1'
        self['HOUDINI_DSO_ERROR'] = '1'

        # improves shared libraries conflict handling!
        # self['HOUDINI_DSO_DEEPBIND'] = '1'

        maya.addon(self,
           module      = '%s/engine/maya/' % self.path(),
           plugin      = '%s/engine/maya/maya$MAYA_VERSION_MAJOR/plug-ins/' % self.path(),
           script      = '%s/engine/maya/maya$MAYA_VERSION_MAJOR/scripts/' % self.path(),
        )



    def bins(self):
        # we want to limit houdini wrappers to just houdini!
        return [
            ('houdini'  ,'houdini-bin -foreground'),
            ('hbatch'   ,'hbatch'),
            ('hscript'  ,'hscript'),
            ('hython'   ,'hython'),
            ('hrender'  ,'hrender'),
            ('hconfig'  ,'hconfig'),
            ('hserver'  ,'hserver'),
            ('mantra'   ,'mantra'),
            ('hcustom'  ,'hcustom'),
            ('mplay'    ,'mplay-bin'),
        ]

    def preRun(self, cmd):
        # we need to fix left zeros in numbers, since hrender is picky
        # and doesn't like then!!
        newcmd  = cmd
        if 'hrender' in cmd and '-f' in cmd:
            tmp = cmd.split(' ')
            # look for the frame range...
            # __TODO: a proper fix for all numbers starting with 0!
            valuesToReplace = [
                tmp[tmp.index('"-f"')+1],
                tmp[tmp.index('"-f"')+2],
            ]

            # replace value by a simple integer
            for each in valuesToReplace:
                newcmd = newcmd.replace(each, str(int(each.replace('"',''))))

            # command do hbatch pra pegar a expresao q define o nome do arquivo
            # a ser rendido!
            # opparm out/mantra__letra vm_picture ( '$HIP/render/$HIPNAME/$OS/$OS.$F4.exr' )

        # make sure character '&' is at the end of all houdini env vars!
        for each in ['HOUDINI_SCRIPT_PATH','HOUDINI_OTLSCAN_PATH','HOUDINI_DSO_PATH','HOUDINI_TOOLBAR_PATH','HOUDINI_UI_ICON_PATH']:
            if each in os.environ:
                os.environ[each] = ':'.join([os.environ[each],'&'])
            else:
                os.environ[each] = '&'

        return newcmd


    def postRun(self, cmd, returnCode, returnLog):
        ''' this is called after a binary of this class has exited.
        it's the perfect method to do postRender checks, for example!'''
        error = returnCode!=0
        if 'hrender' in cmd:
            import os

            if 'StackTrace()' in str(returnCode):
                return 255

            displays = {}
            if 'hrender' in cmd and '-o' in cmd and '-f' in cmd:
                tmp = cmd.split(' ')
                for f in range(int(tmp[tmp.index('"-f"')+1]), int(tmp[tmp.index('"-f"')+2])+1):
                    file = tmp[tmp.index('"-o"')+1].replace("\\","").replace("$F4", "%04d" % f )
                    ext = os.path.splitext(file)
                    if not displays.has_key(ext):
                        displays[ext] = []
                    displays[ext].append(file)


            if "WRITING FILE:" in returnLog:
                files = map(lambda a: a.split("WRITING FILE:")[-1].strip(), filter(lambda x: "WRITING FILE:" in x, returnLog.split('\n')) )
                for f in files:
                    # if the file doesn;t exist, erro! this should report error for cache generation!!
                    if os.path.exists(f):
                        print( "HOUDINI CREATED FILE: %s" % f )
                    else:
                        print( "HOUDINI FAILED TO CREATED FILE: %s" % f )
                        print( '[PARSER ERROR]' )


            try:
                images=[]
                if 'Generating Image:' in returnLog:
                    # collect image files from output log
                    images = map(lambda a: a.split('(')[0],
                             map(lambda x: x.split('Generating Image:')[-1].replace(' ',''),
                             filter(lambda x: 'Generating Image:' in x, returnLog.split('\n'))) )
                    if 'Generating deep camera image:' in returnLog:
                        # collect deep image files from houdini output log
                        images += map(lambda c: c.split(':')[-1],
                                  map(lambda a: a.split('Generating deep camera image:')[-1].replace(' ',''),
                                  filter(lambda x: 'Generating deep camera image:' in x, returnLog.split('\n'))) )

                if images:
                    error = pipe.frame.check(images)
                    if not error:
                        if not self.asset:
                            assetPath = None
                            for each in cmd.split(' '):
                                each = each.replace('"','')
                                if os.path.splitext(each.lower())[-1] in ['.hip']:
                                    assetPath = each
                                    break
                            pipe.frame.publish(images,assetPath)
                        else:
                            pipe.frame.publish(images,self.asset)
                pipe.frame.publishLog(returnLog,self.asset,self.className)
            except UnboundLocalError as e:
                print( 'Catching exception for images var: %s' % e )
                error=True

            if filter( lambda x: x!='.idisplay', displays.keys() ):
                print( '='*80 )
                print( 'Checking rendered displays...\n' )

                openexr = pipe.libs.openexr()
                # we add here a list of commands to execute for each filetype, to check if the file is readable!
                checks={
                    '.exr' : '''%s %%s 2>&1 | grep \.exr''' % openexr.path('bin/%s' % filter( lambda x: 'exrheader2.0.0' in x,openexr.bins() )[0][1]),
                }
                # this is the string list for each filetype to search for errors in the check command result lines
                errors={
                    '.exr' : 'Cannot read',
                }

                results = {}
                for filetype in displays:
                    if filetype != '.idisplay':
                        # check if file exist and its not < 35K
                        for d in displays[filetype]:
                            results[d] = True
                            if not os.path.exists( d ):
                                results[d] = False
                                error = True
                            elif os.stat( d ).st_size <= (35*1024+1):
                                results[d] = False
                                error = True

                        # run check
                        if not error:
                            # if passed basic check, do a filetype check
                            if filetype in checks.keys():
                                checkCmd = checks[filetype] % ' '.join(displays[filetype])
                                lines = os.popen( checkCmd ).readlines()
                                # check if we have the "errors" string in the result lines of our check
                                # if so, it's error!
                                if errors[filetype] in ''.join(lines):
                                    error = True

                                # check which display failed!
                                for d in displays[filetype]:
                                    line = filter( lambda x: d in x, lines )
                                    results[d] = False
                                    if line and errors[filetype] not in line[0]:
                                        results[d] = True

                        # print result for each display
                        res = ['ERROR', 'OK']
                        for d in displays[filetype]:
                            print( "% 10s -> %s" % (res[ results[d] ], d) )
                            if 'ERROR' in res[ results[d] ]:
                                error = True


                # REMOVE ME! Temp fix for qube proxy mode
                self.preRun(cmd)


        # fatal errors - must fail even if images were generated!!
        fatalErrors = [
                'OSError: [Errno 13] Permission denied',
                'Zip Read Error',
                'cannot be opened by RiReadArchive',
                '(core dumped)',
                'dbus.exceptions.DBusException',
                'RuntimeError',
                'fatal interrupt',
                'encountered a fatal error',
                'Error saving geome',
                'hou.OperationFailed: The attempted operation failed.',
                "can't open file '/hrender_af.py'",
		'ImportError',
        ]
        for s in fatalErrors:
            if s in str(returnLog) and not 'This may be caused by launching an app from inside a running app, which in this case, ignore this error!' in str(returnLog):
                error = True
                break

        # return an posix error code
        print( '\n','='*80 )
        return int(error)*255


    def license(self):
        # make sure we have PIPE_HOUDINI_LICENSE_SERVERS env var set
        major_version = self.version().replace('hfs','').split('.')[0]
        if 'PIPE_HOUDINI_LICENSE_SERVERS_%s' % major_version in os.environ:
            env_var = 'PIPE_HOUDINI_LICENSE_SERVERS_%s' % major_version
        elif int(major_version) >= 16 and 'PIPE_HOUDINI_LICENSE_SERVERS_16' in os.environ:
            env_var = 'PIPE_HOUDINI_LICENSE_SERVERS_16'
        elif 'PIPE_HOUDINI_LICENSE_SERVERS' in os.environ:
            env_var = 'PIPE_HOUDINI_LICENSE_SERVERS'
        else:
            raise Exception('No Houdini server setup! Please set houdini license server IP into PIPE_HOUDINI_LICENSE_SERVERS environment variable!')

        # kill a running hserver, everytime!
        os.system( '%s/bin/hserver -q' % self.path() )

        # write the file needed by hserver into user home folder, so it can find
        # the license server specified in PIPE_HOUDINI_LICENSE_SERVERS environment variable!
        f=open( "%s/.sesi_licenses.pref" % os.environ['HOME'] , 'w' )
        f.write("serverhost=%s\n" % os.environ[env_var])
        f.close()

    @staticmethod
    def addon( caller, script='', otl='', dso='', toolbar='', icon='', lib='' ):
        caller['HOUDINI_SCRIPT_PATH'] = script
        caller['HOUDINI_OTLSCAN_PATH'] = otl
        # caller['HOUDINI_OTL_PATH'] = otl
        caller['HOUDINI_DSO_PATH'] = dso
        # caller['HAPI_DSO_PATH'] = dso
        caller['HOUDINI_TOOLBAR_PATH'] = toolbar
        caller['HOUDINI_UI_ICON_PATH'] = icon
        caller['LD_LIBRARY_PATH'] = lib


    def userSetup(self, jobuser):
        ''' this method is implemented when we want to do especial folder structure creation and setup
        for a user in a shot'''
        self['HIP'] = jobuser.path('houdini')
