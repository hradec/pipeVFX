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
    def environ(self):
        self['PYTHON_VERSION_MAJOR'] = '2.6'
        self['HOUDINI_PYTHON_VERSION'] = '2.6'
#        pipe.libs.version.set( python = '2.7.6' )
        
        self['PYTHONHOME'] = self.path('python')
        self['HFS'] = self.path()

        # force loading houdini tbb
#        self['LD_PRELOAD'] = self.path('dsolib/libtbb.so.2')
#        self['LD_PRELOAD'] = self.path('dsolib/libtbbmalloc.so.2')
        self['LD_PRELOAD'] = self.path('dsolib/libjpeg.so.62.0.0')
        self['LD_PRELOAD'] = self.path('dsolib/libpng12.so.0.44.0')

        # force our alembic libraries to be used!
#        pipe.libs.alembic().LD_PRELOAD()
        
#        self.ignorePipeLib( "zlib" )
        self.ignorePipeLib( "alembic" )
        if int(self.version().split('.')[0].replace('hfs','')) >= 14:
            self.ignorePipeLib( "qt" )
            self.ignorePipeLib( "tbb" )
        else:
            self.ignorePipeLib( "tbb" )


        # hou python module path!
        self['PYTHONPATH'] = self.path('houdini/python%slibs' % '.'.join(pipe.libs.version.get('python').split('.')[:2]) )
#        self.insert('PYTHONPATH',0, self.path('houdini/python%slibs' % '.'.join(pipe.libs.version.get('python').split('.')[:2]) ))

        # sets default houdini search paths
        houdini.addon( self, 
            script = '&',
            toolbar = '&',
            otl = '&',
            dso = '&',
            icon = '&',
        )
        
        # add cortex to houdini
        self.update( python() )
        self.update( cortex() )
        self.update( gaffer() )
        
        # we need to force houdini python paths to the top
        self.insert('PYTHONPATH',0, self.path('python/lib/python$PYTHON_VERSION_MAJOR/site-packages'))
        self.insert('PYTHONPATH',0, self.path('python/lib/python$PYTHON_VERSION_MAJOR/'))

    def bins(self):
        # we want to limit houdini wrappers to just houdini!
        return [
            ('houdini'  ,'houdini'),
            ('hbatch'   ,'hbatch'),
            ('hscript'  ,'hscript'),
            ('hython'   ,'hython'),
            ('hrender'  ,'hrender'),
            ('hconfig'  ,'hconfig'),
            ('hserver'  ,'hserver'),
            ('mantra'   ,'mantra'),
        ]
        
    def preRun(self, cmd):
        # we need to fix left zeros in numbers, since hrender is picky
        # and doesn't like then!!
        newcmd  = cmd
        if 'hrender' in cmd and '-f' in cmd:
            tmp = cmd.split(' ')
            # look for the frame range... 
            # TODO: a proper fix for all numbers starting with 0!
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

            if filter( lambda x: x!='.idisplay', displays.keys() ):
                print '='*80
                print 'Checking rendered displays...\n'
                
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
                            print "% 10s -> %s" % (res[ results[d] ], d)
                        
                
                # REMOVE ME! Temp fix for qube proxy mode
                self.preRun(cmd)
            
        # return an posix error code
        print '\n','='*80
        return int(error)*255    
    
    
    def license(self):
        # make sure we have PIPE_HOUDINI_LICENSE_SERVERS env var set
        if 'PIPE_HOUDINI_LICENSE_SERVERS' not in os.environ.keys():
            raise Exception('No Houdini server setup! Please set houdini license server IP into PIPE_HOUDINI_LICENSE_SERVERS environment variable!')
            
        # kill a current running hserver, if different than the current set version!
        import shutil
        if os.popen('pidof hserver').readlines():
            serverVersion = os.popen("echo $(%s/bin/hserver -l | grep ^Version) | cut -d' ' -f2 | sed 's/Houdini/hfs/'" % self.path()).readlines()[0].strip()
            if serverVersion != self.version():
                os.system( '%s/bin/hserver -q' % self.path() )
        
        # write the file needed by hserver into user home folder, so it can find
        # the license server specified in PIPE_HOUDINI_LICENSE_SERVERS environment variable!
        f=open( "%s/.sesi_licenses.pref" % os.environ['HOME'] , 'w' )
        f.write("serverhost=%s\n" % os.environ['PIPE_HOUDINI_LICENSE_SERVERS'])
        f.close()

    @staticmethod
    def addon( caller, script='', otl='', dso='', toolbar='', icon='', lib='' ):
        caller['HOUDINI_SCRIPT_PATH'] = script
        caller['HOUDINI_OTLSCAN_PATH'] = otl
#        caller['HOUDINI_OTL_PATH'] = otl
        caller['HOUDINI_DSO_PATH'] = dso
        caller['HOUDINI_TOOLBAR_PATH'] = toolbar
        caller['HOUDINI_UI_ICON_PATH'] = icon
        caller['LD_LIBRARY_PATH'] = lib
