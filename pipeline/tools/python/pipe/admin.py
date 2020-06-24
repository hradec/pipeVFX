# -*- coding: utf-8 -*-
#!/usr/bin/env ppython
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



import os, shutil, glob, sys, time, traceback
from base import roots, runProcess
import log

import pwd, grp

from multiprocessing import Process

QtCore = None
try:
    from PySide.QtCore import *
except:
    pass


def system(cmd):
    ''' this function acts just like os.system, but it's able to capture the output and return as
    text.
    it also properly handles farm execution, running the command as the proper user!'''
    if 'PIPE_FARM_USER' in os.environ:
        # if running in the farm, we need to use sudo to run as
        # the original user
        s = sudo()
        s.cmd( "su -l %s -s /bin/bash -c '%s'" % (os.environ['PIPE_FARM_USER'], cmd) )
        return s.run()
    else:
        # if running as the user, just run the cmd
        return runProcess( cmd )




class sudo():
    def __init__(self):
#        self.___sudo = 'ssh root@atomoweb.local "%s" 2>&1'
#        self.___sudo = 'ssh root@localhost "%s" 2>&1'
        self.__cmdbuffer = []


    def cmd(self, cmd):
        self.__cmdbuffer.append(cmd)

    def run(self):
        import tempfile
        import signal
        ret  = ''
        try:
            import dbus
            from dbus.mainloop.glib import DBusGMainLoop
        except:
            traceback.print_exc()
            traceback.print_stack()
            print( "No Dbus can be imported at the moment" )
            print( "This may be caused by launching an app from inside a running app, which in this case, ignore this error!")
            print( "If this was caused by launching an app, please contact someone responsible for the pipeline and report this at once!!!")
            dbus=None

        if dbus:
            done = False
            cmd  = ' ;; '.join(self.__cmdbuffer)

            # cache executed cmds to avoid running more than once!
            if not hasattr(dbus, '_cmd_history'):
                dbus._cmd_history = []
            if cmd in dbus._cmd_history:
                return 'DONE'

            DBusGMainLoop(set_as_default=True)
            self.__hasService = True
            try:
                __bus                 = dbus.SystemBus()
                self.__admServiceBus  = __bus.get_object('org.pipe.adminservice', '/org/pipe/adminservice')
                self.__admServiceSudo = self.__admServiceBus.get_dbus_method('sudo', 'org.pipe.adminservice')
                self.__admServiceKill = self.__admServiceBus.get_dbus_method('killThread', 'org.pipe.adminservice')
            except:
                self.__hasService = False

            if self.__hasService:
                # create a tempfile to use as a comunication pipe to
                # dbusPipeService sudo method, which runs in background!!
                file = tempfile.mkstemp("","dbusPipe_")
                file = file[1]
                # open("%s" % file,'w').close() # touch it so we can delete later!
                # open("%s_log" % file,'w').close() # touch it so we can delete later!
                # os.system('chmod 0777  %s' % file)
                # os.system('chmod 0777  %s_log' % file)

                # call dbusPipeService sudo method, passing our tempfile
                # so it can run in background and return the output to us through
                # the temp file!
                # this call will return right away, so no dbus annoying timeout will happen!
                # the return value is the PID of the process forked by dbus!
                pid = self.__admServiceSudo([cmd,  file, str(os.getpid())])

                # we use this signal handler to cleanup the temp file
                # in case our script ended up by a signal in the farm!
                def handler(signum=-1, frame=0):
                    self.__admServiceKill(pid)
                    if os.path.exists(file):
                        try: os.remove(file)
                        except: pass
                    if os.path.exists("%s_log" % file):
                        try: os.remove("%s_log" % file)
                        except: pass
                    raise Exception("[PARSER ERROR]: The process was killed!! If runing in the farm, this is probably an job eject/stop/restart, BUT it can be a CRASH of a running render!")


                # Set the signal handler and a 5-second alarm
                try:
                    signal.signal(signal.SIGTERM, handler)
                    signal.signal(signal.SIGABRT, handler)
                    signal.signal(signal.SIGQUIT, handler)
                except:
                     pass

                # run a loop monitoring our tmp file for a DONE line.
                # dbus will add a DONE line to the file when it's done
                # running in background!
                try:
                    import datetime,time
                    lastLines = []
                    _start = time.time()
                    prefix = ''
                    while( 1 ):

                        # little tricky to display log live on farm
                        if os.path.exists("%s_log" % file):
                            f = open( "%s_log" % file, 'r' )
                            llog = f.readlines()
                            f.close()
                            for l in filter(lambda x: x not in lastLines, llog):
                                std=l
                                if std.strip():
                                    if '%' in std:
                                        if 'progr:' in std:
                                            std = std.replace('progr:', 'PROGRESS:')
                                        else:
                                            std = filter(lambda x: x.strip(), std.strip().split(' '))
                                            #std = ' '.join(std[:-1]+['PROGRESS: ']+[std[-1]])+"\n"
                                            std = map(lambda x: "PROGRESS: "+x if '%' in x else x, std)
                                            std = ' '.join(std)+"\n"
                                    secs = '%s | ' % str(datetime.timedelta( seconds = int(time.time()-_start) ))
                                    sys.stdout.write( secs + prefix + std )
                                    sys.stdout.flush()
                                    sys.stdout.flush()
                            lastLines = llog

                        # real log pulling to check if sudo thread finished or not!
                        f = open( file, 'r' )
                        lines = f.readlines()
                        f.close()
                        if filter( lambda x: 'DONE' in x, lines ):
                            ret = cmd+' -> '+''.join(lines)
                            os.remove( file )
                            break
                        else:
                            time.sleep(0.5)

                except:
                     handler()
                     raise
            else:
                ret = "ERROR: No org.pipe.adminservice DBUS service available.\n"

            log.debug(ret)
        return ret

    def chown(self, owner, path, recursive=False):
        if os.path.exists(path):
            u = owner
            g=None
            if ':' in owner:
                u,g= owner.split(':')
            stat = os.stat(path)
            try:
                user = pwd.getpwuid(stat.st_uid)[0]
                group = grp.getgrgid(stat.st_gid)[0]
                if recursive:
                    owner = '-R %s' % owner
                if user != u:
                    self.cmd( "chown %s '%s'" % (owner, path) )
            except: pass
        else:
                self.cmd( "chown %s '%s'" % (owner, path) )

    def chmod(self, perm, path):
#        self.cmd( "setfacl -b %s" % path )
        self.cmd( "chmod %s '%s'" % (perm, path) )

    def chmodStiky(self, path):
        u = "$(getfacl %s 2>&1 | grep '^user::' | cut -d':' -f3 | sed 's/---/@/' | sed 's/-//g' | sed 's/@/-/')" % path
        g = "$(getfacl %s 2>&1 | grep '^group::' | cut -d':' -f3 | sed 's/---/@/' | sed 's/-//g' | sed 's/@/-/')" % path
        o = "$(getfacl %s 2>&1 | grep '^other::' | cut -d':' -f3 | sed 's/---/@/' | sed 's/-//g' | sed 's/@/-/')" % path

        #self.cmd( "setfacl -m d:u::%s,d:g::%s,d:g:artists:%s,o::%s %s" % (u,g,g,o,path) )
#        self.cmd( "chmod %s '%s'" % (perm, path) )

    def mkdir(self, path):
        if not os.path.exists(path):
            self.cmd( "mkdir -p '%s'" % path )

    def cp(self, fromPath, toPath):
        if os.path.exists(fromPath):
            self.cmd( "cp -rf '%s' '%s'" % (fromPath, toPath) )

    def cpmvlink(self, fromPath, toPath, fromUser, toUser):
        if os.path.exists(fromPath):
            self.rm( "rm -rf '%s'" % (toPath) )
            self.cmd( "su -c 'mv %s %s'" % (fromPath, toPath) )
            self.cmd( "su -c 'ln -s %s  %s'" % (toPath,fromPath) )
            self.cmd( "su -c 'chown %s  %s'" % (fromUser, fromPath) )
            self.cmd( "su -c 'chown %s  %s'" % (toUser, toPath) )

    def mv(self, fromPath, toPath):
        if os.path.exists(fromPath):
            self.cmd( "mv '%s' '%s'" % (fromPath, toPath) )

    def rm(self, file):
        if os.path.exists(file):
            self.cmd( "rm -f '%s'" % (file) )

    def ln(self, fromPath, toPath):
        # if os.path.exists(fromPath):
            self.cmd( "ln -s '%s' '%s'" % (fromPath, toPath) )

    def toFile(self, txt, toPath):
#        self.cmd( "cat > %s << EOF @ %s @ EOF @  @ " % (toPath, str(txt) ) )
        self.cmd( "write\t%s\t%s" % (toPath, str(txt)) )

def username():
    user = pwd.getpwuid( os.getuid() )[ 0 ]
    #if user == 'qubeproxy' and os.environ.has_key('PIPE_FARM_USER'):
    if 'PIPE_FARM_USER' in os.environ:
        user = os.environ['PIPE_FARM_USER']
    return user


def go(job,shot):
    pass


def jobs():
    return { os.path.basename(x):x for x in glob.glob("%s/*" % roots.jobs()) }

class job(sudo):

    def shots(self):
        return { os.path.basename(x):x for x in glob.glob("%s/shots/*" % self.path()) }

    def assets(self):
        return { os.path.basename(x):x for x in glob.glob("%s/assets/*" % self.path()) }

    def __init__(self, projectID=None, projectName=None, adminUser=":artists"):
        if not projectID:
            if 'PIPE_JOB' in os.environ:
                tmp = os.environ['PIPE_JOB'].split('.')
                projectID = int(tmp[0])
                projectName = '.'.join(tmp[1:])
            else:
                raise Exception("ERROR: No Job Set!!")

        if type(projectID) == type(""):
            job = [ x for x in jobs() if projectID in x ]
            if job and len(job[0].split('.'))>1:
                projectID, projectName = job[0].split('.')
                projectID = int(projectID)

        sudo.__init__(self)
        self.root = roots.jobs()
        self.proj = "%04d.%s" % (int(projectID), projectName.lower())
        self.__user = adminUser
        self.projPath = "%s/%s" % (self.root, self.proj)

        self.shot.job = self
        self.asset.job = self

    def path(self, subpath=''):
        ret = "%s/%s" % (self.root, self.proj)
        if subpath:
            ret = "%s/%s" % (ret, subpath)
        return ret

    def fixPerm(self, path, perms=["u+rwx","a+rx"], recursive=False):
        self.chown( self.__user, path, recursive )
        self.chmod( "a-rwx", path )
        for perm in perms:
            self.chmod( perm, path )
        #self.chmodStiky(path)

    def cp(self, fromPath, toPath, username='', perm=[]):
        perms=["u+rwx","a+rx"]
        perms.extend( perm )
        sudo.cp(self, fromPath, toPath)
        self.fixPerm(toPath, perms)
        if username:
            self.chown( "%s:artists" % username, toPath )

    def mkdir(self, path, username='', perm=[]):
        perms=["u+rwx","a+rx"]
        perms.extend( perm )
        sudo.mkdir(self, path)
        self.fixPerm(path, perms)
        if username:
            self.chown( "%s:artists" % username, path )

    def symlink(self, source, target):
        sudo.ln(self, source, target)

    def _mktools(self, path='tools', username=''):
        ''' create the tools folder as a copy of pipeline/tools '''
        ignore = ['init', 'licenses']
        for each in glob.glob( "%s/*" % roots.tools() ):
            beach = os.path.basename(each)
            if os.path.isdir(each) and beach not in ignore:
                self.mkdir( "%s/%s" % (path, beach), username )

    def mktools(self, path='tools', username=''):
        ''' create the tools folder as a link to the latest tag of pipeline/tools '''
        from distutils.version import StrictVersion
        if not os.path.exists( path ):
            tags = [ x.split('/')[-1] for x in glob.glob( "%s/*.*.*" % roots.tags() ) if x.split('/')[-1][0].isdigit() ]
            tags.sort(key=StrictVersion)
            print tags
            self.symlink( '%s/%s' % (roots.tags(), tags[-1]), path )

    def mkpublished(self, path):
#        self.mkdir( self.path("%s/published" % path) )
        # temp hack - everyone from group can write here!
        self.mkdir( self.path("%s/published" % path), perm=["a+rwx"] )
        self.mkdir( self.path("%s/published/ref" % path), perm=["a+rwx"] )

    def mkfootage(self, path):
        self.mkdir( self.path("%s/footage" % path), perm=["a+rwx"] )

    def mkshot(self, path):
        self.mkdir( self.path(path) )
        self.mkdir( self.path("%s/users" % path) )
        self.mkdir( self.path("%s/users/MAC" % path), perm=["a+rwx"] )
        self.mkpublished( path )
        self.mkfootage( path )


    def mkreference(self, path=''):
        self.mkdir( self.path("reference"), perm=["g+w"] )

    def mkarchive(self, path=''):
        self.mkdir( self.path("archive"), perm=["a+rwx"] )

    def mkref_artwork(self, path=''):
        folders='''
            ref_artwork
            ref_artwork/01_RECEBIDOS
            ref_artwork/01_RECEBIDOS/BOARDS
            ref_artwork/01_RECEBIDOS/CRONOGRAMA
            ref_artwork/01_RECEBIDOS/REFERENCIAS
            ref_artwork/01_RECEBIDOS/ROTEIROS
            ref_artwork/01_RECEBIDOS/STILL
            ref_artwork/02_OFFLINE_XML
            ref_artwork/02_OFFLINE_XML/MOVS
            ref_artwork/02_OFFLINE_XML/XML
            ref_artwork/02_OFFLINE_XML/PROJETO_MM
            ref_artwork/03_ARTES_FONTES
            ref_artwork/03_ARTES_FONTES/CARTELAS
            ref_artwork/03_ARTES_FONTES/CLAQUETES
            ref_artwork/03_ARTES_FONTES/FONTES
            ref_artwork/03_ARTES_FONTES/IMGs
            ref_artwork/03_ARTES_FONTES/LOGO_ASSINATURA
            ref_artwork/04_AUDIOS
            ref_artwork/05_RELATORIOS
            ref_artwork/05_RELATORIOS/DECUPAGEM
        '''
        for each in folders.split():
            self.mkdir( self.path(each), perm=["a+rwx"] )

    def mksaidas(self, path=''):
        folders='''
            saidas
            saidas/3D
            saidas/AFTER
            saidas/GOU_FACTORY
            saidas/MASTER
            saidas/NUKE
            saidas/PHOTOSHOP
            saidas/SMOKE
            saidas/WIP
        '''
        for each in folders.split():
            self.mkdir( self.path(each), perm=["a+rwx"] )

    def mkPROJETO(self, path=''):
        structure='''
── PROJETO
│   ├── ARTWORKS
│   │   ├── CONCEPTS
│   │   │   └── _data
│   │   │       └── _hora
│   │   └── MATERIAL
│   │       ├── 3D
│   │       │   └── _data
│   │       │       └── _hora
│   │       ├── AUDIOS
│   │       │   └── _data
│   │       │       └── _hora
│   │       ├── FONTES
│   │       │   └── _data
│   │       │       └── _hora
│   │       ├── FOOTAGES
│   │       │   └── _data
│   │       │       └── _hora
│   │       └── IMAGENS
│   │           ├── CARTELAS
│   │           │   └── _data
│   │           │       └── _hora
│   │           ├── LOGOS
│   │           │   └── _data
│   │           │       └── _hora
│   │           └── SOURCEIMAGES
│   │               └── _data
│   │                   └── _hora
│   ├── MASTER
│   │   ├── BASE_LIMPA
│   │   └── _versao
│   ├── OFFLINE_XML
│   │   └── _data
│   ├── PRODUCAO
│   │   ├── COPIA
│   │   │   ├── CLAQUETES
│   │   │   └── PEDIDOS
│   │   ├── CRONOGRAMA
│   │   ├── REFERENCIAS
│   │   │   ├── BOARDS
│   │   │   └── MONSTRO
│   │   ├── RELATORIOS
│   │   └── ROTEIRO
│   │       └── DATA_NOME
│   └── SAIDAS
│       ├── OFFLINE
│       │   └── _data
│       │       └── _hora
│       │           └── _projeto_info_data_hora
│       ├── ONLINE
│       │   └── _data
│       │       └── _hora
│       │           └── _projeto_info_data_hora
│       └── WIP
│           ├── 3D
│           │   └── _data
│           │       └── _hora
│           │           └── _projeto_info_data_hora
│           ├── AFTER_EFFECTS
│           │   └── _data
│           │       └── _hora
│           │           └── _projeto_info_data_hora
│           ├── DAVINCI
│           │   └── _data
│           │       └── _hora
│           │           └── _projeto_info_data_hora
│           ├── NUKE
│           │   └── _data
│           │       └── _hora
│           │           └── _projeto_info_data_hora
│           ├── PHOTOSHOP
│           │   └── _data
│           │       └── _hora
│           │           └── _projeto_info_data_hora
│           ├── PREMIERE
│           │   └── _data
│           │       └── _hora
│           │           └── _projeto_info_data_hora
│           └── SMOKE
│               └── _data
│                   └── _hora
│                       └── _projeto_info_data_hora
'''
        clean = ['|','└','─','├','│','\xc2','\xa0','\xc2','\xa0']
        for each in clean:
            structure = structure.replace(each,' ')

        # parse the folder structure in the string above
        # and store in a dict
        # it also creates a mkdirs dict with all folders that need to be created!
        zstruct = {}
        mkdirs = {}
        index = {}
        old = ''
        oldSpaces = 0
        oldSpacesId = {}
        mkdir = ""
        mkdirList = []
        for l in structure.split('\n'):
            spaces = l.count(' ')
            #print l,spaces
            l = l.strip()
            if spaces>0:
                if spaces > oldSpaces:
                    sid = oldSpaces
                    oldSpacesId[spaces] = oldSpaces
                    mkdirs[spaces] = mkdir
                else:
                    sid = oldSpacesId[spaces]
                    mkdirList.append(mkdir)
                    mkdir = mkdirs[spaces]
                if spaces < 4:
                    sid = spaces
                    oldSpacesId[spaces] = oldSpaces
                    oldSpaces = spaces
                    zstruct[l] = {}
                    old = zstruct[l]
                    index[sid] = zstruct[l]
                    mkdir = l
                    mkdirs[spaces] = mkdir
                else:
                    index[sid][l] = {}
                    index[spaces] = index[sid][l]
                    oldSpaces = spaces
                    mkdir += "/"+l

        #from pprint import pprint
        #pprint( zstruct )

        # create folders!!
        for d in mkdirList:
            path = "."
            for p in d.split('/')[1:]:
                path = path+'/'+p
                self.mkdir( self.path(path), perm=["a+rwx"] )

    def mkuser(self, path, subpath="", user=None):
        if not user:
            user = username()
        basePath = self.path("%s/users/%s" % (path, user))
        self.mkdir( basePath, user )
        self.mkdir( "%s/%s"        % (basePath, subpath), user )
#        self.mkdir( "%s/tools"      % basePath, user )
#        self.mktools( "%s/users/%s/tools"    % (path, user), user )

    def client( self, name ):
        self.toFile( name, self.path('.cliente') )

    def data( self, data ):
        self.toFile( str(data), self.path('.data') )

    def getData( self ):
        ret = {}
        if os.path.exists(self.path('.data')):
            ret = ''.join( open( self.path('.data'), 'r' ).readlines() )
            ret = eval(ret)
        return ret

    def mkroot(self):
        # main project path
        self.mkdir(self.path())

        #self.mkdir(self.path("archive"))
        #self.mkarchive()

        #self.mkref_artwork()
        #self.mksaidas()
        #self.mkdir(self.path("reference"))
        #self.mkreference()

        self.mkPROJETO()

        self.mkdir(self.path("shots"))

        self.mkdir(self.path("assets"))
#        self.mkshot( "assets" )

        self.mktools( self.path("tools"), 'rhradec' )
        # if not os.path.exists( self.path("tools/config/versions.py") ):
        #     self.cp( "%s/config/versions.py" % roots.tools(), self.path("tools/config/versions.py"), 'rhradec' )

    def create(self):
        return self.run()

    def name(self):
        return self.proj

    @staticmethod
    def current():
        ret = None
        try:
            ret = job()
        finally:
            return ret

    class shot():
        job=None
        def __init__(self, shot=None):
            if not self.job:
                self.job = job()
            self.user._shot = self
            import os
            if 'PIPE_SHOT' in os.environ:
                values = os.environ['PIPE_SHOT']
                values = values.split('@')
                self.basePath = values[0]
                self.shot = values[1]
            else:
                 raise Exception("ERROR: No Shot Set!")

            if shot:
                shot = str(shot)
                self.basePath = str(self).split(' ')[0].split('.')[-1]
                self.shot = shot
                shots = eval('self.job.%ss()' % self.basePath).keys()
                shots.sort()
                s = [ x for x in shots if shot in x ]
                if s:
                    self.shot = s[0]
                else:
                    raise Exception("%s %s doesn't exist in job %s" % (self.basePath, shot, self.job.name()))


        def apply(self):
            os.environ['PIPE_JOB'] = self.job.name()
            os.environ['PIPE_SHOT'] = "%s@%s" % (self.basePath, self.name())

        @staticmethod
        def current():
            ret = None
            try:
                ret = job.shot()
            finally:
                return ret

        def path(self, subpath=''):
            ret = "%s/%ss/%s" % (self.job.path(), self.basePath, self.shot)
            if subpath:
                ret = "%s/%s" % (ret, subpath)
            return ret

        def name(self):
            return self.shot

        class user():
            shot=None
            def __init__(self):
                self.job = self._shot.job
                if not self.job:
                    self.job = job()
                if not self.shot:
                    self.shot = self.job.shot()

            def path(self, subpath=''):
                ret = "%s/users/%s" % (self.shot.path(), username())
                if subpath:
                    ret = "%s/%s" % (ret, subpath)
                return ret

            def mktools(self):
                self.mkdir('tools')
                self.job.mktools( self.path( 'tools' ), username() )

            def mkdir(self, subpath=''):
                self.job.mkdir( self.path( subpath ), username() )
                if not os.path.exists( self.path() ):
                    self.job.fixPerm(self.path(), recursive=True)

            def symlink(self, source, target):
                if not os.path.exists( self.path(target) ):
                    self.job.symlink( self.path(source), self.path(target) )

            def toFile( self, data, file ):
                self.job.toFile( '\n'.join(data), self.path(file) )
                self.job.chown( "%s:artists" % username(), self.path(file) )

            def create(self):
                self.job.create()

    class asset(shot):
        pass

    @staticmethod
    def currentJob(job=None):
        import os
        if not job:
            if 'PIPE_JOB' in os.environ:
                job = os.environ['PIPE_JOB']
        if not job:
            return ''
        return "%s/%s" % (roots.jobs(), job)


    @staticmethod
    def currentShot(j=None, values=None):
        import os
        if not values:
            values='shot@'
            if 'PIPE_SHOT' in os.environ:
                values = os.environ['PIPE_SHOT']
        values = values.split('@')
        return '%s/%ss/%s' % ( job.current(j), values[0], values[1] )


    def listShots(self):
        return [ os.path.basename(x) for x in  glob.glob(self.path('shots/*')) ]

    def listAssets(self):
        return [ os.path.basename(x) for x in  glob.glob(self.path('assets/*')) ]




if __name__=='__main__':
    import sys
    j = job(sys.argv[1])
    j.mkshot( "shots/01" )
    j.mkuser( "shots/01" )
    j.mkshot( "shots/02" )
    j.mkuser( "shots/02" )
    j.create()
