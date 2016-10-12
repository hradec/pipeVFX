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



class qube(baseApp):
    def environ(self):

        if self.parent() in ['qube']:
            import platform
#            if os.popen('cat /proc/version | egrep "Debian|Ubuntu"').readlines():
            if platform.dist()[0].lower() not in ['fedora']:
                pipe.version.set( python = '2.7.6' )
                pipe.libs.version.set( python = '2.7.6' )
                self.update( python() )


        self['QB_SUPERVISOR'] = '192.168.0.80'
        self['QB_DOMAIN'] = 'qubelinux'
        self['PATH'] = self.path('qube-core/local/pfx/qube/bin/')
        self['LD_LIBRARY_PATH'] = self.path('qube-core/local/pfx/qube/lib/')

        self['PYTHONPATH'] = self.path('qubegui/local/pfx/qube/api/python/')
        self['PYTHONPATH'] = self.path('qubegui/local/pfx/qube/bin/AppUI')
        self['PYTHONPATH'] = self.path('qubegui/local/pfx/qube/bin/simplecmds')
        self['PYTHONPATH'] = self.path('qube-core/local/pfx/qube/api/python/')
        self['PYTHONPATH'] = self.path('qubegui/local/pfx/qube/api/python')
        self['PYTHONPATH'] = self.path('qubegui/local/pfx/qube/api/python/qb/gui')
        
        if self.parent() == 'qube':
            self['PYTHONPATH'] = '/usr/lib/python2.7/dist-packages/'
            self['PYTHONPATH'] = '/usr/lib/pymodules/python2.7/'
            self['PYTHONPATH'] = '/usr/lib64/python2.7/site-packages/'
        
        self['QB_ICONS'] = self.path('qubegui/local/pfx/qube/api/python/qb/gui/')

    def logFolder(self):
        import os
        path = "/%s/netboot/qube/" % (pipe.studio())
        if not os.path.exists( path ):
            os.mkdir( path )
        os.chmod( path, 677 )
        return path

    def extraCommandLine(self, binName):
        from sys import argv
        ret = []
        if '--help' not in argv:
            if 'sbin/worker' in binName:
                ret = [ '--supervisor $QB_SUPERVISOR --logfile /tmp/qbworker.log' ]
            elif 'utils/install_worker' in binName:
                ret = [ '--prefix', self.path('qube-worker/local/pfx/qube') ]
        return ret

    def preRun(self,cmd):
        import platform
        if cmd.split('/')[-1].strip() in ['qube','qbgui']:
            print self.toolsPaths()
            for each in self.toolsPaths():
                qube = '%s/qube/qube.py' % each
                tmp=os.popen("ldconfig -p | grep libfreetype.so.6 | cut -d'>' -f2").readlines()
                preload=''
                if tmp:
                    preload = 'LD_PRELOAD=%s ' % tmp[0].strip()
#                    preload = 'LD_PRELOAD=/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/freetype/2.4.4/lib/libfreetype.so.6 '
                    if 'arch' in platform.release().lower():
#                        preload += '; export LD_PRELOAD=/usr/lib/libpng12.so:$LD_PRELOAD ; '
                        preload += 'LD_LIBRARY_PATH=/atomo/pipeline/libs/linux/x86_64/gcc-4.1.2/libpng/1.4.0/lib:/usr/lib/:$LD_LIBRARY_PATH '
                    print preload
                if os.path.exists(qube):
                    if 'arch' not in platform.release().lower():
                        return preload+''' PYTHONPATH=/usr/lib64/python2.7/:$PYTHONPATH /usr/bin/python -c 'import wxversion;wxversion.select(wxversion.getInstalled());exec "".join(open("%s").readlines())' ''' % qube

        return cmd

    def bins(self):
        ret = [
            ('qube', 'qubegui/local/pfx/qube/bin/qube'),
            ('qbgui', 'qubegui/local/pfx/qube/bin/qube'),
            ('qblock', 'qube-core/local/pfx/qube/bin/qblock'),
            ('qbworker', 'qube-worker/local/pfx/qube/sbin/worker'),
#            ('qbupgrade-worker', 'qube-worker/local/pfx/qube/utils/upgrade_worker'),
#            ('qbinstall_worker', 'qube-worker/local/pfx/qube/utils/install_worker'),
#            ('qbuninstall_worker', 'qube-worker/local/pfx/qube/utils/uninstall_worker'),
        ]
#        from glob import glob
#        for each in glob( "%s/*" % self.path('qube-core/local/pfx/qube/bin') ):
#            name = os.path.basename(each)
#            ret.append( (name, 'qube-core/local/pfx/qube/bin/%s' % name) )

        return ret
