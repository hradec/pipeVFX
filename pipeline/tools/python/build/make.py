
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class make(generic):
    ''' a class to handle make installs '''
    src = 'Makefile'
    cmd = 'make CC=$CC CXX=$CXX CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" && make install'


class cmake(make):
    ''' a class to handle cmake installs '''
    src = 'CMakeLists.txt'
    cmd = 'cmake $SOURCE_FOLDER'
    
    def fixCMD(self, cmd):
        if 'cmake' in cmd and 'CMAKE_INSTALL_PREFIX' not in cmd:
            cmd = 'rm -rf CMakeCache.txt && '+cmd.replace('cmake','cmake -DCMAKE_INSTALL_PREFIX=$TARGET_FOLDER')
        return cmd 


class glew(make):
    ''' a make class to exclusively build glew package
    glew requires a bunch of make calls to construct the source and build.
    also, it install its libs in the lib64 folder, so we use a custom 
    installer method to create a link lib -> lib64'''
    cmd = ' && '.join([
        'make -C auto clean', 
        'make clean', 
        'make extensions', 
        'make GLEW_DEST=$TARGET_FOLDER CC=$(which gcc) CXX=$(which g++) LD=$(which gcc)',
        'make GLEW_DEST=$TARGET_FOLDER CC=$(which gcc) CXX=$(which g++) LD=$(which gcc) install',
    ])
    
    def installer(self, target, source, env):
        targetFolder = os.path.dirname(str(target[0]))
        if not os.path.exists("%s/lib" % targetFolder):
            if os.path.exists("%s/lib64" % targetFolder):
                os.popen("ln -s lib64 %s/lib" % targetFolder).readlines()

class tbb(make):
    ''' a make class to exclusively build intels TBB package
    since we need to handle the installation by ourselfs, we override
    installer() method'''
    cmd = ['make']

    def installer(self, target, source, env):
        '''we use this method to do a custom tbb install 
        by copying files over.'''
        import pipe, build, os
        for n in range(len(self.buildFolder)):
            lines = os.popen( "rsync -avWpP $SOURCE_FOLDER/include/* $TARGET_FOLDER/include/ 2>&1" ).readlines()
            for SHLIBEXT in build.SHLIBEXT:
               lines += os.popen( "rsync -aW --delete $SOURCE_FOLDER/build/*_release/*%s* $TARGET_FOLDER/lib/ 2>&1" % (SHLIBEXT) ).readlines()
               lines += os.popen( "rsync -aW --delete $SOURCE_FOLDER/build/*_release/*%s* $TARGET_FOLDER/bin/ 2>&1" % (SHLIBEXT) ).readlines()
        return lines
