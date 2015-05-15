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


import os, glob, sys
if not hasattr(sys,'argv'):
    sys.argv = []

moduleRootPath = os.path.abspath( os.path.dirname(__file__) )
sys.path.insert(0,moduleRootPath)

curdir = os.getcwd()
os.chdir(moduleRootPath)
#os.system('rm %s/*.pyc' % moduleRootPath)
'''
for each in glob.glob('%s/*.py' %  moduleRootPath):
    module = os.path.splitext(os.path.basename(each))[0]
    if module not in __file__:
        exec( 'import %s;reload(%s);del %s' %  (module,module,module) )
    del each, module
'''
os.chdir(curdir)

from base import roots, platform, bits, LD_LIBRARY_PATH, depotRoot, getPackage, win, osx, lin, name

# we need this in OSX to force setup brew pythonpath, just in case!
if osx:
    # we only set brew pythonpath if running system python!
    if sys.executable == '/usr/bin/python':
        sys.path.insert(0, '/usr/local/lib/python2.7/site-packages/gtk-2.0/')
        sys.path.insert(0, '/usr/local/lib/python2.7/site-packages/')
        
    # load dbus session, if needed!
    if not ''.join(os.popen('launchctl list | grep "dbus-session" 2>&1').readlines()).strip():
        os.system('launchctl load /usr/local/Cellar/d-bus/org.freedesktop.dbus-session.plist')

import log
from baseApp import version, versionLib, appsDB, app, libsDB, lib, baseApp, baseLib, disable, roots
try:
    import admin 
except:
    admin=None
import apps
import bcolors
from base import distro as gcc
del os, glob
import farm
import frame

import job
from output import output
import frame




def studio(name=None):
    import os
    #os.environ['STUDIO'] = name
    # studio is already set at initialization, based on .root file location! 
    # it's actually $(basename $ROOT), were ROOT env var is the path of .root file!
    return os.environ['STUDIO']

def include(currentFile):
    import os, sys
    version = currentFile.split('/')[-1].split('-')[-1].split('.')[0]
    f = ''.join( open( '%s/../include/%s.py' % ( os.path.dirname(currentFile), version ), 'r' ).readlines() )
    return f

        
def alias(withlibs=True):
    from glob import glob
    import os
    SHLIB = [
        '.dylib',
        '.dll',
        '.so',
        '.la',
        '.lib',
        '.a',
    ]
    aliasScript = []
    
    pythonBin = "/usr/bin/python"
#    if osx:
#        import glob
#        paths = glob.glob( '%s/python/2.6*' % roots.libs() )
#        if paths:
#            paths.sort()
#            pythonBin = "%s/bin/python" % paths[-1]
        
        
        
    for appname in libsDB():
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
            
#        import sys
#        print >>sys.stderr, appname, classType
        if appClass:
            for each in appClass.bins():
#                print >>sys.stderr, each
                aliasScript.append('''alias %s='env LD_PRELOAD="" %s -c "import pipe;pipe.%s.%s().run(\\"%s\\")"' ''' % (each[0].replace(' ','_'), pythonBin, classType,appname, each[1]) )

    for appname in appsDB():
        try:
            appClass = eval("apps.%s()" % appname)
        except:
            appClass = None
        if appClass:
            try:
                for each in appClass.bins():
                    aliasScript.append('''alias %s='env LD_PRELOAD="" %s -c "import pipe;pipe.apps.%s().run(\\"%s\\")"' ''' % (each[0].replace(' ','_'), pythonBin, appname, each[1]) )
            except:
                from bcolors import bcolors
                sys.stderr.write(bcolors.FAIL)
                sys.stderr.write("\nERROR: Application %s %s doesnt exist in the current job/shot!!\n" % (appname, appClass.version()))
                sys.stderr.write(bcolors.END)


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
            pythonpath += ':%s/lib/python2.6/site-packages/' % paths[-1]
    
    path += '%s/bin:%s/scripts' % (root,root)
    if os.environ.has_key('HOME'):
        path = '%s/tools/scripts:%s' % (os.environ['HOME'],path)
#    if os.environ.has_key('PATH'):
#        tmp = os.environ['PATH']
#        tmp = tmp.replace(path,'').replace('::',':')
#        path += ':%s' % tmp
#    print path


    envs = '''
        alias go="source %s/scripts/go"
        export VGLCLIENT=$(which vglclient 2>/dev/null)
        export ROOT=%s
        export STUDIO=$(basename $ROOT)
        %s
        export PATH=%s:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
        export PYTHONPATH=%s
        export __PATH=$PATH
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
        for line in os.popen('/atomo/apps/linux/x86_64/qube/current/qube-core/local/pfx/qube/bin/qbjobs --expression "id==%s" --user "" ' % os.environ['QBJOBID']).readlines():
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
                    print >>sys.stderr,'\t%d = go %s' % (id, ' '.join(each[1:]))
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
                result = filter(lambda x: args[1] in x[1], argsHist)
                if result:
                    newArgs = result[-1]
                    
    # if we have new arguments from the history, use then 
    # and skip creating a new history for then
    if newArgs:
        args = newArgs
            
    # if we have no arguments from history, create a new history entry
    # for the passed ones!
    f = open( goHist, 'w' )
    if lines:
        for each in lines[-20:]:
            if str(args) != each.strip():
                print >>f, each.strip()
    print >>f, args
    f.close()
        
       
            
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
    
    reserved = ['asset', 'shot', 'shot']
    
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
                try:
                    value = args[args.index(each)+1]
                    if not os.path.exists('%s/%s/%ss/%s' % (roots.jobs(), job, each, value) ):
                        raise
                    shot = "%s@%s" %  (each, value)
                    env.append( 'export PIPE_SHOT="%s"' %  shot )
                    
                except:
                    ret = ["echo 'ERROR: %s %s doesnt exist!\n\nOptions are:'" % (each, value)]
                    
                    for l in glob( '%s/%s/%ss/*' % (roots.jobs(), job, each) ):
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
    env.append( 'export PATH=%s:$__PATH' % path )
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
        
        
    env.append( 'export PATH=%s:$__PATH' % path )
    env.append( 'export PYTHONPATH=%s:$__PYTHONPATH' % pythonpath )
        
    env.append( 'echo "Job: %s\n%s: %s\nPath: $(pwd)"' % (job, values[0], values[1] ) )
    
    env.append( '''PROMPT_COMMAND='echo -ne "\033]0;Job: %s | %s: %s\007"' ''' % (job, values[0], values[1]) )
    

    # if running in Qube, set PIPE_FARM_USER
    if os.environ.has_key('QBJOBID'):
        user = ''
        for line in os.popen('/atomo/apps/linux/x86_64/qube/current/qube-core/local/pfx/qube/bin/qbjobs --expression "id==%s" --user "" ' % os.environ['QBJOBID']).readlines():
            if os.environ['QBJOBID'] in line:
                user = line[38:48].strip()
        env.append( 'export PIPE_FARM_USER=%s' % user )
        env.append( 'export PIPE_FARM_JOBID=%s' % os.environ['QBJOBID'] )

        
       
    return '%s \n %s' % (init(), '\n'.join(env))



