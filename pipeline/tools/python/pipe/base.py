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


import os,sys,glob,shutil

def runProcess(exe):
    ''' run a shell command and captures the output at
    the same time it displays it in the shell log.
    returns a tupple with exit code and log!'''

    import subprocess
    log = ''
    ret = None
    p = subprocess.Popen(exe, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True, close_fds=True,bufsize = 1)
    prefix = 'pipeLog: '
    if os.environ.has_key('PIPE_FARM_USER'):
        prefix = '\tpipeLog: '
    while(True):
      std, err = (None,None)
      for std in iter(p.stdout.readline,''):
          if std:
              if '%' in std:
                    if 'progr:' in std:
                        std = std.replace('progr:', 'PROGRESS:')
                    else:
                        std = filter(lambda x: x.strip(), std.strip().split(' '))
                        #std = ' '.join(std[:-1]+['PROGRESS: ']+[std[-1]])+"\n"
                        std = map(lambda x: "PROGRESS: "+x if '%' in x else x, std)
                        std = ' '.join(std)+"\n"
              sys.stdout.write( prefix + std )
              log += std
              sys.stdout.flush()
          if err:
              sys.stderr.write( "ERROR: " + err )
              log += "ERROR: " + std
              sys.stderr.flush()

      retcode = p.poll() #returns None while subprocess is running
      if(p.returncode is not None):
        try:
            p.send_signal(9)
            p.terminate()
            p.kill()
        except:
            pass
        break

    ret = p.returncode
    if 'OSError' in log:
        ret = 255
    if 'PARSE ERROR' in log:
        ret = 255
    return (ret,log)



bits = os.popen('uname -m').readlines()[0].strip().lower()
arch='x86_64'
if bits[0]=='i':
    arch='x86_32'

if '--arch' in sys.argv:
    index = sys.argv.index('--arch')
    arch=sys.argv[index+1]
    del sys.argv[index]
    del sys.argv[index]

WIN='mingw'
OSX='darwin'
LIN='linux'
taskset = ''.join(os.popen('which taskset').readlines()).strip()
vglrun  = ''.join(os.popen('which vglrun').readlines()).strip()

osx=False
lin=False
win=False

py = sys.version[0:3]

platform = WIN
LD_LIBRARY_PATH = 'PATH'
if OSX in sys.platform.lower():
    platform = OSX
    LD_LIBRARY_PATH = 'DYLD_LIBRARY_PATH'
    osx=True
elif LIN in sys.platform.lower():
    platform = LIN
    LD_LIBRARY_PATH = 'LD_LIBRARY_PATH'
    lin=True




__ldconfigLog = map(lambda x: x.strip(), os.popen('/sbin/ldconfig -p').readlines())
ldconfig = {
   'x86_64' :  filter( lambda x: 'x86-64' in x,  __ldconfigLog ),
   'x86_32' :  filter( lambda x: 'x86-64' not in x,  __ldconfigLog ),
}
def findSharedLibrary(libname):
    libs = filter( lambda x: libname in x, ldconfig[arch] )
    return map(lambda x: x.split(' => ')[-1].strip(), libs)


def depotRoot(forceScan=False):
    root = os.path.dirname(__file__)
    if not os.environ.has_key('ROOT') or forceScan:
        while(root.split('/')[1]):
            if os.path.exists( '%s/.root' % root ):
                break
            root = os.path.dirname(root)
        if root=='/':
            raise Exception('missing .root file at the depot root!')
    else:
        root = os.environ['ROOT']
    return os.path.abspath(root)


def name():
    root = depotRoot()
    return root.strip('/').split('/')[0]

def expandVars():
    global apps
    global buildStuff
    global platform
    global LD_LIBRARY_PATH
    apps        = os.path.abspath( '%s/pipeline/apps/%s/%s' % (depotRoot(), platform, bits) )
    buildStuff  = os.path.abspath( '%s/buildStuff' % apps )
expandVars()

def crossCompileWin():
    global platform
    global LD_LIBRARY_PATH
    platform = 'mingw'
    LD_LIBRARY_PATH = 'PATH'
    expandVars()




class roots:
    @staticmethod
    def apps(plat=platform, arch=bits):
        ret =  os.path.abspath( '%s/pipeline/apps/%s/%s' % (depotRoot(), plat, arch) )
        if not os.path.exists(ret):
            ret = os.path.abspath( '%s/apps/%s/%s' % (depotRoot(), plat, arch) )
        return ret


    @staticmethod
    def buildStuff(plat=platform, subpath=''):
        if subpath:
            subpath = '/%s' % subpath
        return os.path.abspath( '%s/buildStuff%s' % (roots.apps(plat), subpath) )

    @staticmethod
    def libs(plat=platform, arch=bits, distro=None, subpath=''):
        if not distro:
            distro = getDistro()
        if subpath:
            subpath = '/%s' % subpath
        return os.path.abspath( '%s/pipeline/libs/%s/%s/%s' % (depotRoot(), plat, arch, distro) )

    @staticmethod
    def jobs(subpath=''):
        if subpath:
            subpath = '/%s' % subpath
        return os.path.abspath( '%s/jobs%s' % (depotRoot(), subpath) )

    @staticmethod
    def tools(plat=None, subpath=''):
        if subpath:
            subpath = '/%s' % subpath

        root = depotRoot()
        if plat:
            root = roots.apps(plat)

        return os.path.abspath( '%s/pipeline/tools/%s' % (root, subpath) )


# hardcoded for now!!
exec( ''.join( [ p for p in open( "%s/config/versions.py" % roots.tools() ).readlines() if 'os.environ[' in p ] ) )
def getDistro(check=True):
    if platform == OSX:
        distro = 'gcc-llvm5.1'
    else:
        version = ['4.1.2']
        distro = 'gcc-%s' % version[-1]

        # autodetect most up2date gcc version
        # try:
        #     version.append( filter( lambda x: x.isdigit() or x=='.', os.popen('gcc --version').readlines()[0] ) )
        # except: pass
        #
        # if check:
        #     version.sort()
        #     for v in version:
        #         if os.path.exists("%s/.ready" % roots.libs(distro='gcc-%s' % v)):
        #             distro = 'gcc-%s' % v
        # else:
        #     distro = 'gcc-%s' % version[-1]

        # we can specify our current gcc version in versions.py, globally or on an per job/user basis!!
        if 'GCC_VERSION' in os.environ:
            distro = os.environ['GCC_VERSION']
    return distro

distro = getDistro()





apps        = os.path.abspath( '%s/pipeline/apps/darwin/%s' % (depotRoot(), bits) )
if not os.path.exists(apps):
    apps        = os.path.abspath( '%s/apps/darwin/%s' % (depotRoot(), bits) )

buildStuff  = os.path.abspath( '%s/buildStuff' % apps )


# add pipeline python modules to the path
#os.environ['PYTHONPATH'] = os.path.pathsep.join( [
#    '%s/python' % buildStuff,
#    os.path.dirname( os.path.abspath(__file__) ),
#] )
#os.environ['PATH']          = os.path.pathsep.join( [ '%s/bin' % buildStuff, os.environ['PATH'] ] )
#os.environ[LD_LIBRARY_PATH] = '%s/lib' % buildStuff


#os.environ['DELIGHT']       = "%s/delight/9.0.1" % apps
#os.environ['MAYA_LOCATION'] = "%s/maya/2011installed/Maya.app/Contents" % apps

# generic download function
def getPackage(url, newFolder = None):
    dirs = glob.glob('*')
    ext = os.path.splitext(url)
    base = os.path.basename(url)

    if url[0:3]=='git':
        if not os.path.exists(base):
            os.system( 'git clone %s %s' % (url, base) )
        else:
            os.system( 'cd %s && git pull 2>&1 > /dev/null' % base )
        newFolder = base
    else:
        decompress = 'tar -xf'
        dir = os.path.splitext( base )[0]
        if 'tar.gz' in url:
            decompress = 'tar -xzf'
        if '.tbz' in url:
            decompress = 'tar -xjf'

        if not os.path.exists( dir ):
            dir = os.path.splitext( dir )[0]
            os.system('wget %s ; %s %s; rm -rf %s' % (url, decompress, base, base) )
        newFolder = dir

    return newFolder
