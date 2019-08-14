#!/usr/bin/env python2
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


import sys, os, traceback, time, subprocess
sys.path.insert(0, os.path.abspath( "%s/../python" % os.path.dirname( __file__ ) ) )
import pipe

import gobject
import pwd
import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from multiprocessing import Process

pidof = 'pidof -x %s' % __file__
if pipe.base.osx:
    pidof = 'pidof %s' % __file__

pids = os.popen(pidof).readlines()
if pids:
    if len(pids[0].split()) > 1:
        sys.exit(0)

administrators = [
]

nonAdmCmds = [
    'ln',
    'mkdir',
    'chmod',
    'chown',
    'write',
    'cp',
    'rm',
    'su',
    'setfacl',
    'getfacl',
    'convert',
    'montage',
]


_ps = 'ps -AHfc'
_ps2 = 'ps -Hfcp'
# write a new rule and put it /etc/dbus-1/system.d/ (fedora only?)
# so we can create our systemBus service as root user!
# this rule allows our service name to be created by root,
# and also allows anyone to access it!
punchRule = '''
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
        <policy user="root">
                <allow own="org.pipe.adminservice"/>
        </policy>
        <policy context="default">
                <deny own="org.pipe.adminservice"/>
                <allow send_destination="org.pipe.adminservice"/>
                <allow receive_sender="org.pipe.adminservice"/>
        </policy>
</busconfig>
'''

if pipe.base.osx:
    '''
        As OSX doesn't have DBUS, we rely on "brew" to install a OSX port of the
        linux dbus message system.

        We only need to install it once, using brew like this:

           brew install homebrew/python/python-dbus
           brew install pygtk
           brew install pidof

        This script will take care of run system wide dbus when it starts up.
        Installing system dbus using OSX launcher is too messy and complicated, so I've decided
        to just run it from here instead, which seems to work perfectly!

        The only thing needed, after manually installing dbus and dependencies with brew, is
        startup this dbusService.py script at boot as root, just like we do in linux!
    '''


    # make sure OSX messagebus user exists and is properly setup,
    # so we can run system dbus instead of session dbus!
    os.system('''
        dscl . -create /Users/messagebus
        dscl . -create /Users/messagebus UserShell /bin/bash
        dscl . -create /Users/messagebus UniqueID 9000
        dscl . -create /Users/messagebus PrimaryGroupID 1000
        dscl . -passwd /Users/messagebus 3datomo
    ''')

    _ps = 'ps -Aj'
    _ps2 = 'ps -fp'

    # in OSX, punchRule lives inside brew path, since
    # pipe uses brew dbus as dbus backend in OSX!
    os.system('mkdir -p /usr/local/etc/dbus-1/session.d/')
    os.system('mkdir -p /usr/local/etc/dbus-1/system.d/')
    os.system('mkdir -p /usr/local/var/run/dbus/')
    f=open('/usr/local/etc/dbus-1/session.d/org.pipe.adminservice.conf', 'w')
    f.write( punchRule )
    f.close( )
    f=open('/usr/local/etc/dbus-1/system.d/org.pipe.adminservice.conf', 'w')
    f.write( punchRule )
    f.close( )
    # also, setup brew dbus to run system dbus properly.
    # this way we don't need to manually setup dbus system!
    systemPlist = '/usr/local/Cellar/d-bus/org.freedesktop.dbus-system.plist'
    f=open(systemPlist , 'w')
    f.write( '''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>org.freedesktop.dbus-system</string>
            <key>ProgramArguments</key>
            <array>
                <string>/usr/local/bin/dbus-daemon</string>
                <string>--nofork</string>
                <string>--system</string>
            </array>
            <key>ServiceIPC</key>
            <true/>
            <key>Sockets</key>
            <dict>
                <key>unix_domain_listener</key>
                <dict>
                    <key>SecureSocketWithKey</key>
                    <string>DBUS_LAUNCHD_SESSION_BUS_SOCKET</string>
                </dict>
            </dict>
        </dict>
        </plist>
    ''' )
    f.close( )
#    os.system('launchctl unload -w  %s' % systemPlist  )
#    os.system('launchctl load -w  %s' % systemPlist  )
#    os.system('launchctl start org.freedesktop.dbus-system' )
    os.system('''
        killall -9 dbus-daemon
        rm -rf /usr/local/var/run/dbus/*
        /usr/local/bin/dbus-daemon --nofork --system &
    ''' )
    time.sleep(5)
    # and setup dbus session to be used by users launchctl
    sessionPlist = '/usr/local/Cellar/d-bus/org.freedesktop.dbus-session.plist'
    f=open(sessionPlist , 'w')
    f.write( '''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>org.freedesktop.dbus-session</string>
            <key>ProgramArguments</key>
            <array>
                <string>/usr/local/bin/dbus-daemon</string>
                <string>--nofork</string>
                <string>--session</string>
            </array>
            <key>ServiceIPC</key>
            <true/>
            <key>Sockets</key>
            <dict>
                <key>unix_domain_listener</key>
                <dict>
                    <key>SecureSocketWithKey</key>
                    <string>DBUS_LAUNCHD_SESSION_BUS_SOCKET</string>
                </dict>
            </dict>
        </dict>
        </plist>
    ''' )
    f.close( )


else:
    os.system('mkdir -p /etc/dbus-1/system.d/')
    f=open('/etc/dbus-1/system.d/org.pipe.adminservice.conf', 'w')
    f.write( punchRule )
    f.close( )


# our service class!
class pipeAdminDBUSService(dbus.service.Object):
    def __init__(self):
        self.pids = {}
        bus_name = dbus.service.BusName('org.pipe.adminservice', bus=dbus.SystemBus())
        dbus.service.Object.__init__(self, bus_name, '/org/pipe/adminservice')


    def __runCMD(self, each, firstCmd, tmpfile):
        ret = ''
        if firstCmd == 'write':
            name = each.split('\t')
            f = open( name[1], 'w' )
            f.write( '\t'.join(name[2:]) )
            f.write( '\n' )
            f.close()
        else:
            ret = ''.join( os.popen("%s 2>&1 " % (each)).readlines() )
            print '---',ret
            f=open("%s_log" % tmpfile,'w')
            f.write(ret+'\n')
            f.close()
#            exitCode, ret = pipe.base.runProcess(each)
        return ret


    def killPIDandChildren(self, pid2kill):
        # a function to recursively gather all children of the given pid!
        def getChildren(__pid, l=[]):
            print _ps+' | egrep -v "UID|grep|USER" | grep %s  | while read l ; do echo $l ; done' % __pid
            for each in filter( lambda x: x.strip(), os.popen( _ps+' | egrep -v "UID|grep|USER" | grep %s  | while read l ; do echo $l ; done' % __pid ).readlines() ) :
                print each
#                pid = each[9:15].strip()
#                ppid = each[15:21].strip()
                pid = each.strip().split()[1]
                ppid = each.strip().split()[2]
                if pid not in l:
                    l.append(pid)
                    getChildren(pid, l)
            return l

        # kill all children
        for each in getChildren(pid2kill):
            print  'kill -9 %s' % each
            os.system( 'kill -9 %s' % each )

    def loadCFG(self):
        # read administrators from dbusService.cfg file, if one exists!
        path = os.path.dirname(os.path.abspath( __file__ ))
        if os.path.exists( "%s/dbusService.cfg" % path ):
            x=open("%s/dbusService.cfg" % path ).readlines()
            flag=False
            self.administrators  = []
            for l in x:
                if 'administrators:' in l:
                    flag='adm'
                elif l[0] != ' ':
                    flag=False
                elif flag=='adm':
                    if '#' not in l:
                        self.administrators.append(l.strip())

            return self.administrators


    @dbus.service.method('org.pipe.adminservice', in_signature='s', out_signature='s', sender_keyword='sender')
    def killThread(self, pid, sender):
        if pid in self.pids.keys():
            self.killPIDandChildren(pid)
            del self.pids[pid]
        return ""


    @dbus.service.method('org.pipe.adminservice', in_signature='as', out_signature='s', sender_keyword='sender')
    def sudo(self, array, sender):
        cmd = array[0]
        tmpfile = array[1]
        caller_pid = array[2]
        bus = dbus.SystemBus().get_object('org.freedesktop.DBus', '/org/freedesktop/DBus')
        uid = dbus.Interface(bus, 'org.freedesktop.DBus').GetConnectionUnixUser(sender)
        uname = pwd.getpwuid( uid )[ 0 ]

        administrators = self.loadCFG()

        def threadedMainLoop():
            ret = ' '
            current = ''
            try:
                for c in cmd.split(' ;; '):
                    for each in c.split('&&'):
                        print each
                        each = each.strip()
                        firstCmd = each.split()[0].strip()

                        # check the specified paths and see if we can execute the command
                        # on those paths!
                        pathsOK = True
                        for path in filter( lambda x: x.strip()[0]=='/', each.replace('\ ','').split() ):
                            # check if the path is /tmp/<something or a job path
                            if  path[0:5] not in ['/tmp/','/opt/','/var/','/usr/', '/Libr', '/dev/'] \
                                and  path[0:len(pipe.roots.jobs())]!=pipe.roots.jobs() \
                                and path[0:30] not in ['/atomo/pipeline/tools/licenses']:
                                    pathsOK = False
                            print path,firstCmd,pathsOK

                        # if any of the paths is not in /tmp/ or in /<studio>/jobs/
                        # don't do it!!

                        # if first cmd is any of those 3...
                        if pathsOK and firstCmd in ['mkdir','chmod','chown', 'su', 'cp', 'rm'] or firstCmd in ['su', 'runuser', 'convert', 'montage']:
                            print "__runCMD", each, '|', firstCmd, '|', tmpfile
                            ret += self.__runCMD(each, firstCmd, tmpfile)
                            print '|',ret,'|'
                        elif pathsOK:
                            ret += '-------------\n%s\n------------' %  each.split('taskset')[-1]
                            path = each.split('taskset')[-1].split(pipe.roots.jobs())[1].split()[0].strip()
                            pathLevels = len(path.split('/users/')[0].split('/'))
                            SAMpathLevels = len(path.split('/sam/')[0].split('/'))
                            basePath = '%s%s' % (pipe.roots.jobs(), path.split('/users/')[0])
                            if '/sam/' in path:
                                basePath = '%s%s' % (pipe.roots.jobs(), path.split('/sam/')[0])
                            if firstCmd in nonAdmCmds:
                                ret += '='*200+'\n'
                                ret += each+'\n'
                                ret += '-'*200+'\n'
                                if uname in administrators:
                                    # administrative functions only!
                                    ret += self.__runCMD(each, firstCmd, tmpfile)
                                else:
                                    # anyone can create a folder in "users" subfolder of a job.
                                    # but we need to make sure they are doing only that!!
                                    if pathLevels == 4 or SAMpathLevels == 2:
                                        if os.path.exists( basePath  ):
#                                            print each, basePath, path, pathLevels
                                            ret += self.__runCMD(each, firstCmd, tmpfile)
                                        else:
                                            ret += 'ERROR: User %s has no administrative rights to create %s (%s)!!\n' % (uname, basePath, each)
                                    else:
                                        ret += 'ERROR: User %s has no administrative rights to execute (%s)!!\n' % (uname, each)
                            else:
                                ret += 'ERROR: The org.pipe.adminservice DBUS can only do these operations: %s - (%s)!!\n' % (', '.join(nonAdmCmds), each)
                        else:
                            ret += 'ERROR: The org.pipe.adminservice DBUS can only do operations in %s - (%s)!!\n' % (pipe.roots.jobs(), each)
            except:
                ret += "\n\t".join(traceback.format_exc().split('\n'))

            ret += '\n\nDONE\n'
            # only write if the file exists, to avoid writing files to dead caller processes, which
            # won't be cleaned up later!
            print tmpfile
            # if os.path.exists(tmpfile):
            # os.system('chown root:artists  %s' % tmpfile)
            os.system('chown %s  %s' % ('root', tmpfile))
            os.system('chown %s  %s_log' % ('root', tmpfile))
            os.system('chmod a+rwx  %s' % tmpfile)
            os.system('chmod a+rwx  %s_log' % tmpfile)
            f=open(tmpfile, 'w')
            f.write(ret)
            f.close()
            os.system('chmod a+rwx  %s' % tmpfile)
            os.system('chown %s  %s' % (uname, tmpfile))
            os.system('chown %s  %s_log' % (uname, tmpfile))


        # start the execution in a different thread, so we can return as soon as possible and avoid
        # dbus timeout annoying problem!!!
        p = Process(target=threadedMainLoop)
        print "\ndbusPipe: %s, %s, %s" % (tmpfile, uid, uname)
#        for each in cmd.split(';;'):
#            print "\t\t%s" % each
        p.start()

        # monitor the caller process. If it dies before the thread is finished, we kill the thread
        # as well!!
        def threadedMonitorCaller():
            monitor = True
            pp = p
            is_alive = True
            # a loop to monitor if the process is alive and if the caller process is also alive!
            while( monitor and is_alive ):
                monitor  = filter( lambda x: x.strip(), os.popen( _ps2+' %s | grep -v UID | grep -v USER' % caller_pid ).readlines() )
                is_alive = filter( lambda x: x.strip(), os.popen( _ps2+' %s | grep -v UID | grep -v USER' % pp.pid ).readlines() )
                time.sleep(10)
            if is_alive:
                # kill the process and all children!
                self.killPIDandChildren(pp.pid)

        # run monitor is a separated thread as well!
        pm = Process(target=threadedMonitorCaller)
        pm.start()

        # keep the pid so we can kill it if requested!
        self.pids[p.pid] = p
        self.pids[pm.pid] = pm

        # cleanup pids dictionary!
        for each in self.pids.keys():
            if not self.pids[each].is_alive():
                del self.pids[each]

        return str(p.pid)

DBusGMainLoop(set_as_default=True)
pipeAdminService = pipeAdminDBUSService()
#gtk.main()

mainloop = gobject.MainLoop ()
mainloop.run ()



#from socket import *
#import thread

#BUFF = 1024
#HOST = '0.0.0.0'# must be input parameter @TODO
#PORT = 9999 # must be input parameter @TODO
#def response(key):
#    return 'Server response: ' + key

#def handler(clientsock,addr):
#    while 1:
#        data = clientsock.recv(BUFF)
#        if not data: break
#        print repr(addr) + ' recv:' + repr(data)
#        clientsock.send(response(data))
#        print repr(addr) + ' sent:' + repr(response(data))
#        if "close" == data.rstrip(): break # type 'close' on client console to close connection from the server side

#    clientsock.close()
#    print addr, "- closed connection" #log on console

#if __name__=='__main__':
#    ADDR = (HOST, PORT)
#    serversock = socket(AF_INET, SOCK_STREAM)
#    serversock.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
#    serversock.bind(ADDR)
#    serversock.listen(5)
#    while 1:
#        print 'waiting for connection... listening on port', PORT
#        clientsock, addr = serversock.accept()
#        print '...connected from:', addr
#        thread.start_new_thread(handler, (clientsock, addr))
