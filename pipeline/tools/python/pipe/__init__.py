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


from __future__ import print_function
import os, glob, sys, traceback
import log
import base
from base import roots, platform, bits, LD_LIBRARY_PATH, depotRoot
from base import getPackage, win, osx, lin, name
from base import distro as gcc
from base import distroName as distro
import baseApp
from baseApp import version, versionLib, appsDB, app, libsDB, lib
from baseApp import baseLib, disable

from output import output
import frame
import build
import cached
import farm
import apps
import libs
try:
    import admin
except:
    admin=None


# avoid creating .pyc since it can cause trouble between Intel and AMD
sys.dont_write_bytecode = True

# make sure sys has argv
if not hasattr(sys,'argv'):
    sys.argv = []

# set the folder of this source file at the top of pythonpath
moduleRootPath = os.path.abspath( os.path.dirname(__file__) )
sys.path.insert(0,moduleRootPath)

# store the current dir, just in case
curdir = os.getcwd()

# read config files, like versions.py and license.py
baseApp.baseApp.configFiles()


# we need this in OSX to force setup brew pythonpath, just in case!
if osx:
    # we only set brew pythonpath if running system python!
    if sys.executable == '/usr/bin/python':
        sys.path.insert(0, '/usr/local/lib/python$PYTHON_VERSION_MAJOR/site-packages/gtk-2.0/')
        sys.path.insert(0, '/usr/local/lib/python$PYTHON_VERSION_MAJOR/site-packages/')

    # load dbus session, if needed!
    if not ''.join(os.popen('launchctl list | grep "dbus-session" 2>&1').readlines()).strip():
        os.system('launchctl load /usr/local/Cellar/d-bus/org.freedesktop.dbus-session.plist')

# deal with QT
global _Qt
global _QtCore
global _QtGui
global _QtWidgets
def importQt(ret=None):
    ''' import QT from the system or from gaffer, if it's available '''
    global _Qt
    global _QtCore
    global _QtGui
    global _QtWidgets
    try:
        import Qt
        from Qt import QtCore, QtGui, QtWidgets
        for c in [ x for x in dir(QtWidgets) if x[0]=='Q' ]:
            exec( 'QtGui.%s = QtWidgets.%s' % (c, c) )
        QtCore.SIGNAL = QtCore.Signal
        _Qt        = Qt
        _QtCore    = QtCore
        _QtGui     = QtGui
        _QtWidgets = QtWidgets
    except:
        import GafferUI
        QtGui = GafferUI._qtImport( "QtGui" )
        QtCore = GafferUI._qtImport( "QtCore" )
        _Qt        = None
        _QtCore    = QtCore
        _QtGui     = QtGui
        _QtWidgets = None

    if ret:
        if 'QtWidgets' in ret:
            return _QtWidgets

    return QtCore, QtGui


def whatQt():
    ''' return what python qt we're using '''
    if _Qt:
        return "pyside"
    return "pyqt"


def versionMajor(versionString):
    ''' return the version major of a normal version number '''
    if not versionString:
        return 0.0
    return float('.'.join(versionString.split('.')[:2]))


def versionSort(versions):
    ''' sort a list of versions properly (versions as ##.##.##) '''
    def method(v):
        v = filter(lambda x: x.isdigit() or x in '.', v.split('b')[0])
        return str(float(v.split('.')[0])*10000+float(v.split('.')[:2][-1])) + v.split('b')[-1]
    return sorted( versions, key=method, reverse=True )


class LD_PRELOAD:
    ''' a class to setup LD_PRELOAD with some base shared libraries '''
    from baseApp import baseLib
    class gcc:
        class latest(baseLib):
            ''' use the latest gcc shared libraries from the pipe
            we need this when the system libraries are lower version than
            the latest pipe gcc '''
            force_enable = True
            def environ(self):
                self['LD_PRELOAD'] = LD_PRELOAD.latestGCCLibrary("libstdc++.so.6")
                self['LD_PRELOAD'] = LD_PRELOAD.latestGCCLibrary("libgcc_s.so.1")

        class system(baseLib):
            ''' use the system gcc shared libraries
            we need this if the system gcc version is bigger than our latest
            pipe gcc '''
            force_enable = True
            def environ(self):
                self['LD_PRELOAD'] = LD_PRELOAD.systemGCCLibrary("libstdc++.so.6")
                self['LD_PRELOAD'] = LD_PRELOAD.systemGCCLibrary("libgcc_s.so.1")

    @staticmethod
    def latestGCCLibrary(libname):
        ''' return the path for the latest pipe gcc requested library '''
        import os, libs
        _lib = libs.gcc().path('lib/%s' % libname)
        if not os.path.exists(_lib):
            _lib = base.findSharedLibrary(libname)
        return _lib

    @staticmethod
    def systemGCCLibrary(libname):
        ''' return the path for the system gcc requested library '''
        import os, log
        extra = "(libc6)"
        if os.uname()[-1] == 'x86_64':
            extra = "x86-64"
        if 'ldconfig' not in globals():
            globals()['ldconfig'] = cached.popen("ldconfig -p").readlines()
        l = [ x.strip().split()[-1] for x in globals()['ldconfig'] if libname in x.strip()[len(x.strip())-len(libname):] and extra in x ]
        if not l:
            log.error("can't find system library %s" % libname)
            return ""
        return l[0]

def findLibrary(libname):
    ''' find a shared library '''
    return base.findSharedLibrary(libname)

def _force_os_environ(print_traceback=None):
    ''' this is a hack to restart a running python to account for a new os.environ
    (mostly updates to LD_LIBRARY_PATH) but it can cause misbehavior compared to
    having the environment properly set before running python.
    So used it carefully!!!'''
    if print_traceback:
        print (traceback.print_exc())
    import os
    try:
        os.execv(sys.argv[0], sys.argv)
    except (Exception, exc):
        print ('Failed re-exec:', exc)
        sys.exit(1)

def studio(name=None):
    ''' studio is already set at initialization, based on .root file location!
    it's actually $(basename $ROOT), were ROOT env var is the path of .root
    file!'''
    import os
    return os.environ['STUDIO']

def include(currentFile):
    ''' need description!!! '''
    import os, sys
    version = currentFile.split('/')[-1].split('-')[-1].split('.')[0]
    f = ''.join( open( '%s/../include/%s.py' % ( os.path.dirname(currentFile), version ), 'r' ).readlines() )
    return f

def alias(withlibs=True):
    ''' returns bash aliases to initialze every binary executable in the pipe '''
    from glob import glob
    import os
    import apps, libs
    SHLIB = [
        '.dylib',
        '.dll',
        '.so',
        '.la',
        '.lib',
        '.a',
    ]
    aliasScript = []

    pythonBin = "/usr/bin/python2"
    if osx:
        paths = cached.glob( '%s/python/2.*' % roots.libs() )
        if paths:
            paths.sort()
            pythonBin = "%s/bin/python" % paths[-1]


    for appname in baseApp._libsDB:
        classType = 'apps'
        try:
#            sys.stderr.write("%s\n" % appname)
            appClass = eval("apps.%s()" % appname)
        except:
            appClass = None

        if withlibs or os.environ.has_key('PIPE_RUN_WITH_LIBS'):
            try:
                classType = 'libs'
                appClass = eval("libs.%s()" % appname)
            except:
                appClass = None

        if appClass:
            for each in appClass.bins():
                aliasScript.append('''alias %s='env LD_PRELOAD="" %s -c "import pipe;pipe.%s.%s().run(\\"%s\\")"' ''' % (each[0].replace(' ','_'), pythonBin, classType,appname, each[1]) )

    for appname in baseApp._appsDB:
        try:
            appClass = eval("apps.%s()" % appname)
        except:
            appClass = None
        if appClass:
            try:
                for each in appClass.bins():
                    aliasScript.append('''alias %s='env LD_PRELOAD="" %s -c "import pipe;pipe.apps.%s().run(\\"%s\\")"' ''' % (each[0].replace(' ','_'), pythonBin, appname, each[1]) )
            except:
                log.error(
                    log.traceback()+
                    "\n\nERROR: Application %s %s doesnt exist in the current job/shot!!\n\n" % (appname, appClass.version())
                )
                # import bcolors
                # from bcolors import bcolors
                # sys.stderr.write(bcolors.FAIL+"="*80)
                # sys.stderr.write("\n%s\n" % traceback.print_exc())
                # sys.stderr.write("\n\nERROR: Application %s %s doesnt exist in the current job/shot!!\n\n" % (appname, appClass.version()))
                # sys.stderr.write("="*80+bcolors.END)


    return '\n'.join(aliasScript)



def init():
    import os
    if os.environ.has_key('UID'):
        #only run if enviroment is set and not root!
        if os.environ['UID'] == '0':
            return ""

    from base import depotRoot
    root = os.path.abspath("%s/../../" % moduleRootPath)

    curdir = os.getcwd()
    os.chdir(root)

    pythonpath = ''
    path = ''

    # user level:
    if  os.environ.has_key('HOME'):
        user_pythonpath = '%s/tools/python' % os.environ['HOME']
        if os.path.exists(user_pythonpath):
            pythonpath += user_pythonpath+':'

        user_path = '%s/tools/scripts' % os.environ['HOME']
        if os.path.exists(user_path):
            path += user_path+':'

    pythonpath += '%s/python' % root
    if os.environ.has_key('PYTHONPATH'):
        tmp = os.environ['PYTHONPATH']
        tmp = tmp.replace(pythonpath,'').replace('::',':')
        pythonpath += ':%s' % tmp

    # custom init for OSX
    # sets pythonpath to use pipe python-dbus so things work
    # without having to install python-dbus into the machine itself!
    if osx:
        import glob
        paths = glob.glob( '%s/python-dbus/*' % roots.libs() )
        if paths:
            paths.sort()
            pythonpath += ':%s/lib/python$PYTHON_VERSION_MAJOR/site-packages/' % paths[-1]

    # add central bin/scripts folders
    path += '%s/bin:%s/scripts' % (root,root)

    envs = '''
        alias go="source %s/scripts/go"
        export VGLCLIENT=$(which vglclient 2>/dev/null)
        export ROOT=%s
        export STUDIO=$(basename $ROOT)
        %s
        export __PATH_HOME=%s
        export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$__PATH_HOME
        export PYTHONPATH=%s
        export __PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
        export __PYTHONPATH=$PYTHONPATH
        export EDITOR=nano
    ''' % (root, depotRoot(), alias(), path, pythonpath)

    if '___PATH' not in os.environ.keys():
        envs += '''
            export ___PATH=$PATH
        '''
    if '___PYTHONPATH' not in os.environ.keys():
        envs += '''
            export ___PYTHONPATH=$PYTHONPATH
        '''

    if osx:
        envs += '''
                export CLICOLOR=1
                export LSCOLORS=GxFxCxDxBxegedabagaced
                alias ls='ls -GFh'
                alias l='ls -lh'
        '''
    else:
        envs += '''
                alias l="ls -lh --color=yes"
        '''



    # if running in Qube, set PIPE_FARM_USER
    if os.environ.has_key('QBJOBID'):
        user = ''
        for line in os.popen('%s/qube/current/qube-core/local/pfx/qube/bin/qbjobs --expression "id==%s" --user "" ' % (pipe.roots().apps(), os.environ['QBJOBID']).readlines()):
            if os.environ['QBJOBID'] in line:
                user = line.split()[6].strip()
        envs += '\nexport PIPE_FARM_USER=%s' % user
        envs += '\nexport PIPE_FARM_JOBID=%s' % os.environ['QBJOBID']

    return envs

def initBash():
    import os
    envs = init()
    initBash = '/tmp/initBash_%s.sh' % os.environ['USER']
    if os.path.exists( initBash ):
        os.remove(initBash)
    f = open(initBash,'w')
    f.write( envs )
    f.close()
    os.system("chown %s %s" % (os.environ['USER'], initBash))
    os.chdir(curdir)
#    return tmp


def go():
    import sys, os
    goHist=None
    if os.environ.has_key('HOME'):
        goHist = '%s/.go' % os.environ['HOME']
    args = sys.argv[sys.argv.index(filter(lambda x: '/scripts/go' in x,sys.argv)[0]):]

    job = None
    if os.environ.has_key('PIPE_JOB'):
        job = os.environ['PIPE_JOB']

    shot = None
    if os.environ.has_key('PIPE_SHOT'):
        shot = os.environ['PIPE_SHOT']

    # if go was called without any arguments, and we have PIPE_JOB and PIPE_SHOT set,
    # use it!
    newArgs  = []
    if len(args) < 2:
        if job:
            newArgs.append( job )
        if shot:
            shot = shot.split('@')
            newArgs.append( shot[0] )
            newArgs.append( shot[1] )

    # if we have a history file
    if goHist:
        lines = None
        argsHist = []

        # and the history file exists...
        if os.path.exists( goHist ):
            # read it and store in a list called argsHist
            f = open( goHist, 'r' )
            lines = f.readlines()
            for each in lines:
                each = each.strip()
                if each:
                    try:
                        argsHist.append( eval( each ) )
                    except:
                        pass
            f.close()

            # show the history list
            if '-h' in args:
                id=0-len(argsHist)
                for each in argsHist:
                    sys.stderr.write('\t%d = go %s\n' % (id, ' '.join(each[1:])))
                    id += 1
                return ''

            # if go was called without arguments, grab the last one from the history
            elif len(args) < 2:
                newArgs = argsHist[-1]

            # if a -N argument is passed, use the -N element of the history as arguments
            elif args[1][0] == '-':
                id = int(args[1])
                if id < 0:
                    newArgs = argsHist[id]

            # if go was called with only one argument (a job),
            # find the last entry with that job in the list and use it
            elif len(args) < 3:
                try:
                    result = filter(lambda x: args[1] in x[1], argsHist)
                    if result:
                        newArgs = result[-1]
                except:
                    pass

    # if we have new arguments from the history, use then
    # and skip creating a new history for then
    if newArgs:
        args = newArgs

    # if we have no arguments from history, create a new history entry
    # for the passed ones!
    try:
        f = open( goHist, 'w' )
        if lines:
            for each in lines[-20:]:
                if str(args) != each.strip():
                    f.write("%s\n" % each.strip())
        f.write("%s\n" % args)
        f.close()
    except:
        pass



    return __go(args)

def __go(args):
    import sys, os
    from glob import glob
    from  job import current as currentJob
    from  job import currentShot

    args = map( lambda x: x.lower(), args )

    if 'reset' in args or '-r' in args:
        return "\n".join([
            'unset PIPE_JOB',
            'unset PIPE_SHOT',
            '''PROMPT_COMMAND='echo -ne "\033]0;No Job/Shot set!!\007"' ''',
        ])

    reserved = ['asset', 'assets', 'shot', 'shots']

    job = None
#    if os.environ.has_key('PIPE_JOB'):
#        job = os.environ['PIPE_JOB']

    shot = None
#    if os.environ.has_key('PIPE_SHOT'):
#        shot = os.environ['PIPE_SHOT']

    env = []
    # passed arguments
    if len(args)>1:

        if args[1].lower() not in reserved:
            jobs = filter( lambda x: args[1] in x, glob( "%s/*" % roots.jobs() ) )
            if not jobs:
                ret = ["echo 'ERROR: job %s doesnt exist! \n\nOptions are:'\n" % args[1].lower()]
                for each in glob( '%s/*' % (roots.jobs()) ):
                    beach = os.path.basename(each)
                    if beach[:4] != '0000':
                        ret.append( "echo '\t %s'" % beach )
                ret.append( "echo ' '")
                return "\n".join(ret)
            elif len(jobs)>1:
                ret = ["echo 'WARNING: There is more than one job with `%s` in it! \n\nOptions are:'\n" % args[1].lower()]
                for each in jobs:
                    beach = os.path.basename(each)
                    if beach[:4] != '0000':
                        ret.append( "echo '\t %s'" % beach )
                ret.append( "echo ' '")
                return "\n".join(ret)


            job = os.path.basename(jobs[0])
            env.append( 'export PIPE_JOB="%s"' % job )


        env.append( 'unset PIPE_SHOT' )
        for each in reserved:
            if each in args:
                value = ""
                shotPrefix = each.rstrip('s')
                try:
                    value = args[args.index(each)+1]
                    if not os.path.exists('%s/%s/%ss/%s' % (roots.jobs(), job, shotPrefix, value) ):
                        raise
                    shot = "%s@%s" %  (shotPrefix, value)
                    env.append( 'export PIPE_SHOT="%s"' %  shot )

                except:
                    ret = ["echo 'ERROR: %s %s doesnt exist!\n\nOptions are:'" % (each, value)]

                    for l in glob( '%s/%s/%ss/*' % (roots.jobs(), job, shotPrefix) ):
                        ret.append( "echo '\t%s %s'" % (each, os.path.basename(l)) )
                    ret.append( "echo ' '")
                    return "\n".join(ret)

    if not job:
        return "\n".join([
            "echo 'ERROR: No current job set.'",
            '''PROMPT_COMMAND='echo -ne "\033]0;No Job/Shot set!!\007"' ''',
        ])


    # cd to job
    env.append( 'cd "%s"' % currentJob(job) )
    # add job tools/python to pythonpath
    path = '%s/tools/scripts' % currentJob(job)
    env.append( 'export PATH=$__PATH:%s:$__PATH_HOME' % path )
    pythonpath = '%s/tools/python' % currentJob(job)
    env.append( 'export PYTHONPATH=%s:$__PYTHONPATH' % pythonpath )

    # deal with shot
    values = ['Shot','']
    if shot:
        if os.path.exists( "%s/users/%s" % (currentShot(job, shot), admin.username()) ):
            env.append( 'cd "%s/users/%s"' % (currentShot(job, shot), admin.username()) )
        else:
            env.append( 'cd "%s/users"' % currentShot(job, shot) )
        values = shot.split('@')
        values[0] = "%s%s" % (values[0][0].upper(), values[0][1:])

        # add shot/user/tools/python to pythonpath
        path += ':%s/tools/scripts' % currentShot(job, shot)
        path += ':%s/users/%s/tools/scripts' % (currentShot(job, shot), admin.username())
        pythonpath += ':%s/tools/python' % currentShot(job, shot)
        pythonpath += ':%s/users/%s/tools/python' % (currentShot(job, shot), admin.username())


    env.append( 'export PATH=$__PATH:%s:$__PATH_HOME' % path )
    env.append( 'export PYTHONPATH=%s:$__PYTHONPATH' % pythonpath )

    env.append( 'echo "Job: %s\n%s: %s\nPath: $(pwd)"' % (job, values[0], values[1] ) )

    env.append( '''PROMPT_COMMAND='echo -ne "\033]0;Job: %s | %s: %s\007"' ''' % (job, values[0], values[1]) )


    # if running in Qube, set PIPE_FARM_USER
    if os.environ.has_key('QBJOBID'):
        user = ''
        for line in os.popen('%s/qube/current/qube-core/local/pfx/qube/bin/qbjobs --expression "id==%s" --user "" ' % (pipe.roots().apps(), os.environ['QBJOBID']).readlines()):
            if os.environ['QBJOBID'] in line:
                user = line[38:48].strip()
        env.append( 'export PIPE_FARM_USER=%s' % user )
        env.append( 'export PIPE_FARM_JOBID=%s' % os.environ['QBJOBID'] )



    return '%s \n %s' % (init(), '\n'.join(env))


sys.path.remove(moduleRootPath)
