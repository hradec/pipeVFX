
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
    cmd = 'make && make install'
    
    def action(self, target, source):
        # register builder
        bld = Builder(action = self.make)
        self.env.Append(BUILDERS = {'make' : bld})
        return self.env.make( target, source )
        

    def make(self, target, source, env):

        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
        installDir = os.path.dirname(str(target[0]))
        
        os.environ['CC'] = ''.join(os.popen('which gcc').readlines()).strip()
        os.environ['CXX'] = ''.join(os.popen('which g++').readlines()).strip()
        os.environ['LD'] = ''.join(os.popen('which gcc').readlines()).strip()
        
        cmd = 'export CC=$(which gcc) && export CXX=$(which g++) && export LD=$(which gcc) && %s %s' % (env['CMD'], env['EXTRA'])
        print bcolors.GREEN+'\t%s...' % env['CMD']+bcolors.END
        self.runCMD(cmd, target, source)
        



class cmake(make):
    ''' a class to handle cmake installs '''
    src = 'CMakeLists.txt'
    cmd = 'cmake $SOURCE_FOLDER'
    
    def make(self, target, source, env):
        ''' override the make builder to adjust the command line a bit for cmake to work.
        first we cleanup the cache so everytime whe run it, it starts fresh.
        last, we add CMAKE_INSTALL_PREFIX to automatically set the installation folder.
        '''
        env['CMD'] = 'rm -rf CMakeCache.txt && '+env['CMD'].replace('cmake','cmake -D CMAKE_INSTALL_PREFIX=$TARGET_FOLDER')
        make.make(self, target, source, env)


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
                os.popen("ln -s lib64 %s/lib" % targetFolder) 

class tbb(make):
    ''' a make class to exclusively build intels TBB package
    since we need to handle the installation by ourselfs, we override
    installer() method'''
    cmd = 'make'

    def installer(self, target, source, env):
        '''we use this method to do a custom tbb install 
        by copying files over.'''
        import pipe, build, os
        for n in range(len(self.buildFolder)):
            lines = os.popen( "rsync -avWpP %s/include/* %s/include/ 2>&1" % (self.buildFolder[n], self.targetFolder[n] ) ).readlines()
            for SHLIBEXT in build.SHLIBEXT:
               os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/lib/ 2>&1" % (self.buildFolder[n], SHLIBEXT, self.targetFolder[n]) ).readlines()
               os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/bin/ 2>&1" % (self.buildFolder[n], SHLIBEXT, self.targetFolder[n]) ).readlines()


class alembic(cmake):
    ''' as alembic has some very special requirements to build properly,
    we derivated the cmake class to setup it correctly for it. 
    '''
    cmd = ' '.join([
        'HDF5_ROOT=$HDF5_TARGET_FOLDER &&',
        'HDF5_INCLUDE_DIR=$HDF5_TARGET_FOLDER/include &&',
        'HDF5_LIBRARIES=$HDF5_TARGET_FOLDER/lib/libhdf5.so &&',
        'OPENEXR_INCLUDE_PATHS=$OPENEXR_TARGET_FOLDER/include &&',
        'OPENEXR_LIBRARIES=$OPENEXR_TARGET_FOLDER/lib/libIlmImf.so &&',
        'cmake', 
        '-D LIBPYTHON_VERSION=$PYTHON_VERSION_MAJOR',
        '-D PYTHON_ROOT=$PYTHON_ROOT',
        '-D ALEMBIC_PYTHON_LIBRARY=$PYTHON_ROOT/lib/libpython$PYTHON_VERSION_MAJOR.so',
        '-D BOOST_ROOT=$BOOST_TARGET_FOLDER',
        '-D BOOST_LIBRARYDIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
        '-D ILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
        '-D MAYA_ROOT=%s' % pipe.apps.maya().path(''),
        '-D ARNOLD_ROOT=%s' % pipe.apps.arnold().path(''),
        '-D PRMAN_ROOT=%s' % pipe.apps.delight().path(''),
        '-D USE_PYILMBASE=1',
        '. && make && make install',
    ])





