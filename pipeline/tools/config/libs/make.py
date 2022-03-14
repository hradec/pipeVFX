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



class make(baseLib):
    flags = []
    def versions(self):
        if self.parent()  in ["make"]:
            pipe.libs.version.set( python='2.7.6' )

    def environ(self):
        # update with all env vars for all libraries
        # env = {
        #     'RPATH'     : [],
        #     'CPATH'     : [],
        #     'CFLAGS'    : [ '-O2 -fPIC -w -nostdinc -Wno-error -DBOOST_LOG_DYN_LINK ',
        #         ' -isystem$BOOST_TARGET_FOLDER/include/ ',
        #         ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/',
        #         ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/',
        #         ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/',
        #     ],
        #     'CXXFLAGS'  : [ '-O2 -fPIC -w -nostdinc -nostdinc++ -Wno-error -DBOOST_LOG_DYN_LINK ',
        #         ' -isystem$BOOST_TARGET_FOLDER/include/ ',
        #         ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include-fixed/',
        #         ' -I$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/',
        #         ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/',
        #         ' -isystem$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/x86_64-pc-linux-gnu/',
        #         ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/',
        #         ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++',
        #         ' -isystem$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/include/c++/x86_64-pc-linux-gnu/',
        #         ' -isystem/usr/include',
        #     ],
        #     'LDFLAGS'   : [
        #         ' -Wl,-rpath=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
        #         ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/',
        #         ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib/gcc/x86_64-pc-linux-gnu/lib64/',
        #         ' -Wl,-rpath=$GCC_TARGET_FOLDER/lib64/ ',
        #     ],
        #     'NVCCFLAGS': [
        #         # '-I$GCC_TARGET_FOLDER/include/c++/$GCC_VERSION/',
        #         '-std=c++17',
        #         '-ccbin g++',
        #     ],
        # }
        # import inspect
        # for each in  [ x for x in [ eval("pipe.libs."+c) for c in dir(pipe.libs)] if inspect.isclass(x) ]:
        #     obj = each()
        #     if hasattr(obj,'path') and obj.className.upper() not in ['ALLLIBS', 'OPENSSL', 'TIFF', 'JPEG']:
        #         self.update( obj )
        #         # print obj.className.upper()
        #         self["%s_TARGET_FOLDER" % obj.className.upper()] = obj.path()
        #         root = obj.path()
        #         lib = "%s/lib" % root
        #         include = "%s/include" % root
        #         if cached.glob(lib+'/*'):
        #             env['RPATH'    ] += ["%s/lib" % root]
        #             env['RPATH'    ] += ["%s/lib/python$PYTHON_VERSION_MAJOR" % root]
        #             env['LDFLAGS'  ] += ["-Wl,-rpath,%s/lib" % root]
        #             env['LDFLAGS'  ] += ["-Wl,-rpath,%s/lib/python$PYTHON_VERSION_MAJOR" % root]
        #             env['LDFLAGS'  ] += ["-Wl,-rpath-link,%s/lib" % root]
        #             env['LDFLAGS'  ] += ["-Wl,-rpath-link,%s/lib/python$PYTHON_VERSION_MAJOR" % root]
        #         if cached.glob(include+'/*'):
        #             env['CPATH'    ] += ["%s/include" % root]
        #             env['CFLAGS'   ] += ["-I%s/include" % root]
        #             env['CXXFLAGS' ] += ["-I%s/include" % root]
        #
        # for each in ['CFLAGS', 'CXXFLAGS', 'LDFLAGS', 'NVCCFLAGS']:
        #     if each in os.environ:
        #         env[each] += [os.environ[each]]
        #
        # self['BOOST_LIBRARYDIR'] = "$BOOST_ROOT/lib/python$PYTHON_VERSION_MAJOR/"
        # self['PATH'            ] = "$GCC_ROOT/bin/"
        # self['CC'              ] = "$GCC_ROOT/bin/gcc"
        # self['CXX'             ] = "$GCC_ROOT/bin/g++"
        # self['LD'              ] = "$GCC_ROOT/bin/g++"
        # self['LD_LIBRARY_PATH' ] = ':'.join(env['RPATH']+["$GCC_ROOT/lib/","/lib64"])
        # self['RPATH'           ] = ':'.join(env['RPATH']+["$GCC_ROOT/lib/","/lib64"])
        # self['CPATH'           ] = ':'.join(env['CPATH'])
        # self['CFLAGS'          ] = ' '.join(env['CFLAGS']+['-I/usr/include'])
        # self['CXXFLAGS'        ] = ' '.join(env['CXXFLAGS']+['-I/usr/include'])
        # self['LDFLAGS'         ] = ' '.join(env['LDFLAGS']+["-L/lib64"])
        # self['NVCCFLAGS'       ] = ' '.join(env['NVCCFLAGS'])

        self.update(pipe.libs.cmake())
        self.flags = [
            'CC=$CC',
            'CXX=$CXX',
            'CPP=$CPP',
            'LD=$LD',
            'SHARED_LD=$LD',
            'CCFLAGS="$CCFLAGS"',
            'CXXFLAGS="$CXXFLAGS"',
            'LDFLAGS="$LDFLAGS"',
            'NVCCFLAGS="$NVCCFLAGS"',
        ]

    def run(self, app):
        if self.flags:
            app = app.replace("make", "make "+" ".join(self.flags))
        baseLib.run(self, app)

    def runUserSetup(self, jobuser):
        ''' don't create a make folder in the user folder!!'''
        return False

    def needJob(self):
        ''' we don't need a job/shot setup to run this '''
        return False
