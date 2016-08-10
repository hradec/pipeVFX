
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import pipe
import os,sys
from pipe.bcolors import bcolors


class configure(generic):
    src = 'configure'
    cmd = [
        './configure  --enable-shared',
        'make -j $DCORES',
        'make -j $DCORES install',
    ]

    def fixCMD(self, cmd):
        if 'configure' in cmd and '--prefix=' not in cmd:
            cmd = cmd.replace('configure', 'configure --prefix=$TARGET_FOLDER ')
        if 'make' in cmd and 'cmake' not in cmd:
            if not '-j' in cmd:
                cmd = cmd.replace('make', "make -j $DCORES")
#            cmd = cmd.replace('make', "make CC=$CC CXX=$CXX CFLAGS='$CFLAGS' CXXFLAGS='$CXXFLAGS' ")
        return cmd


class gccBuild(configure):
    src = 'configure'
    cmd = [
        './configure  --enable-shared',
        'make -j $DCORES',
        'make -j $DCORES install',
    ]

    def fixCMD(self, cmd):
        if self.versionMajor < 5.0:
            cmd = ' && '.join([
                # got this build options for arch AUR-mirror for gcc 4.1
                # " sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in",
                ''' sed -i -e 's@\./fixinc\.sh@-c true@' gcc/Makefile.in ''',
                ''' sed -i -e 's/echo \$ldver |/echo \$ldver | cut -d"\)" -f2 | /' ./libstdc++-v3/configure''', # fix wrong LD version detection
                # 'export CFLAGS="-fgnu89-inline -g -O2 $CFLAGS"',
                # 'export CXXFLAGS="-fgnu89-inline -g -O2 $CXXFLAGS"',
                "mkdir -p build",
                "cd build",
                '../configure  --prefix=$TARGET_FOLDER '
                    '--mandir=$TARGET_FOLDER/share/man '
                    '--libdir=$TARGET_FOLDER/lib '
                    '--infodir=$TARGET_FOLDER/share/info '
                    '--libexecdir=$TARGET_FOLDER/lib '
                    '--enable-languages=c,c++ '
                    '--enable-__cxa_atexit  '
                    '--disable-multilib '
                    '--enable-clocale=gnu '
                    '--disable-libstdcxx-pch '
                    '--disable-werror '
                    '--enable-threads=posix '
                    '--enable-version-specific-runtime-libs '
                    '--enable-checking=release '
                    '--program-suffix=-$(basename $TARGET_FOLDER)',
                'sed -i.bak -e "s/CC = gcc/CC = gcc -fgnu89-inline/" -e "s/CXX = g++/CXX = g++ -fgnu89-inline/" Makefile',
                'make -j $DCORES',
                'make install',
            ])
        return cmd




class openssl(configure):
    ''' a make class to exclusively build openssl package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    src='config'
    cmd=[
        # './config no-shared no-idea no-mdc2 no-rc5 zlib enable-tlsext no-ssl2 --prefix=$TARGET_FOLDER',
        # 'make depend && make && make install',
        './config shared enable-tlsext --prefix=$TARGET_FOLDER',
        'make -j $DCORES && make -j $DCORES install',
    ]
    def installer(self, target, source, env): # noqa
        targetFolder = os.path.dirname(str(target[0]))
        ret = os.popen("ln -s libssl.so %s/lib/libssl.so.10" % targetFolder).readlines()
        ret += os.popen("ln -s libcrypto.so %s/lib/libcrypto.so.10" % targetFolder).readlines()
        return ret



class freetype(configure):
    ''' a make class to exclusively build freetype package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    def installer(self, target, source, env): # noqa
        ret = []
        t = os.path.dirname(str(target[0]))
        if os.path.exists( "%s/include/freetype2" % t):
            if not os.path.exists( "%s/include/freetype" % t):
                ret = os.popen("ln -s freetype2 %s/include/freetype" % t).readlines()
        return ret



class boost(configure):
    src = './bootstrap.sh'
    environ = {
        'CC'        : '$CC -fPIC',
        'CPP'       : '$CPP -fPIC',
        'CXX'       : '$CXX -fPIC',
        'CXXCPP'    : '$CXXPP -fPIC',
    }

    def fixCMD(self, cmd):
        # generic build command for versions 1.58 and up
        cmd = [
            './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
            './b2 -j $DCORES cxxflags="-fPIC  -D__AA__USE_BSD $CPPFLAGS" linkflags="$LDFLAGS" -d+2 install',
        ]
        # if version is below 1.58, use this build commands
        if self.versionMajor < 1.58:
            cmd = [
                './bootstrap.sh --libdir=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ --prefix=$TARGET_FOLDER',
                'echo -e "using gcc : : $CXX : <archiver>$AR ;"  > ./user-config.jam && cp ./user-config.jam ./user-config2.jam ',
                './b2 -j $DCORES --user-config=./user-config.jam cxxflags="-fPIC  -D__AA__USE_BSD $CPPFLAGS -std=gnu++11" linkflags="$LDFLAGS" -d+2 install',
            ]
        return ' && '.join(cmd)

#    def installer(self, target, source, env):
#        os.popen("rm -rf %s/lib/python*/*.a" % env['TARGET_FOLDER']).readlines()



class python(configure):
    sed = {'0.0.0' :{
        'setup.py' : [("ndbm_libs = \[", "ndbm_libs = \['gdbm', 'gdbm_compat'")],
        'Modules/Setup.dist' : [
            ('#_socket socketmodule.c','_socket socketmodule.c'),
            ('#SSL','SSL'),
            ('#_ssl _ssl','_ssl _ssl'),
            ('#	-DUSE_SSL','	-DUSE_SSL'),
            ('#	-L..SSL','	-L$(SSL'),
        ]
    }}
    cmd = [
        'wget "https://bootstrap.pypa.io/ez_setup.py"',
        './configure  --enable-shared --enable-unicode=ucs4',
        'make -j $DCORES',
        'make -j $DCORES install',
        '$TARGET_FOLDER/bin/python ./ez_setup.py',
        '$TARGET_FOLDER/bin/easy_install hashlib',
        # '$TARGET_FOLDER/bin/easy_install scons',
        '$TARGET_FOLDER/bin/easy_install pip',
        '$TARGET_FOLDER/bin/pip install readline',
    ]
    def fixCMD(self, cmd):
        cmd = configure.fixCMD(self,cmd)
        if self.kargs.has_key('pip'):
            for each in self.kargs['pip']:
                cmd += '&& $TARGET_FOLDER/bin/pip install %s' % each
        return cmd



class cortex(configure):
    ''' a make class to exclusively build openssl package
    we need this just to add some links to the shared libraries, in order to support redhat and ubuntu distros'''
    src='SConstruct'
    environ = {
    }
    cmd=[
        # 'scons OPTIONS=%s/cortex.options.py -j $DCORES'         % os.path.abspath( os.path.dirname(__file__)),
        'scons OPTIONS=%s/cortex.options.py -j $DCORES install' % os.path.abspath( os.path.dirname(__file__)),
    ]

    def fixCMD(self, cmd):
        # update the buld environment with all the enviroment variables
        # specified in apps argument!
        pipe.version.set(python=self.os_environ['PYTHON_VERSION'])
        pipe.versionLib.set(python=self.os_environ['PYTHON_VERSION'])
        print bcolors.WARNING+": ", bcolors.BLUE+"  apps: ",
        for (app, version) in self.apps:
            className = str(app).split('.')[-1].split("'")[0]
            pipe.version.set({className:version})
            app = app()
            app.fullEnvironment()
            print "%s(%s)" % (className, version),
            # get all vars from app class and add to cmd environ
            for each in app:
                if each not in ['LD_PRELOAD','PYTHON_VERSION','PYTHON_VERSION_MAJOR']:
                    v = app[each]
                    if type(v) == str:
                        v=[v]
                    if each not in self.os_environ:
                        self.os_environ[each] = ''
                    # if var value is paths
                    if '/' in str(v):
                        self.os_environ[each] = "%s:%s" % (self.os_environ[each], ':'.join(v))
                    else:
                        self.os_environ[each] = ' '.join(v)

        # remove python paths that are not the same version!
        for each in self.os_environ:
            if '/' in str(v):
                cleanSearchPath = []
                for path in self.os_environ[each].split(':'):
                    if not path.strip():
                        continue
                    if '/python' in path and self.os_environ['PYTHON_TARGET_FOLDER'] not in path:
                        pathVersion1 = path.split('/python/')[-1].split('/')[0].strip()
                        pathVersion2 = path.split('/python')[-1].split('/')[0].strip()
                        # print each, pathVersion1+'='+pathVersion2, path, self.os_environ['PYTHON_VERSION_MAJOR'], path.split('/python/')[-1].split('/')[0] != self.os_environ['PYTHON_VERSION_MAJOR'], path.split('/python')[-1].split('/')[0] != self.os_environ['PYTHON_VERSION_MAJOR']
                        if pathVersion1:
                            if pathVersion1 != self.os_environ['PYTHON_VERSION']:
                                continue
                        if pathVersion2:
                            if pathVersion2 != self.os_environ['PYTHON_VERSION_MAJOR']:
                                continue
                    cleanSearchPath.append(path)
                self.os_environ[each] = ':'.join(cleanSearchPath)

        self.os_environ['LD_PRELOAD'] = ''.join(os.popen("ldconfig -p | grep libstdc++.so.6 | grep x86-64 | cut -d'>' -f2").readlines()).strip()
        self.os_environ['LD_PRELOAD'] += ':'+''.join(os.popen("ldconfig -p | grep libgcc_s.so.1 | grep x86-64 | cut -d'>' -f2").readlines()).strip()

        print
        #self.os_environ['LD_LIBRARY_PATH'] = '/usr/lib/:%s' % self.os_environ['LD_LIBRARY_PATH']
        return cmd
