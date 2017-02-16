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


from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys


class pythonSetup(generic):
    src = 'setup.py'
    cmd = [
        'python setup.py install --prefix=$TARGET_FOLDER',
    ]

    def fixCMD(self, cmd):
        if hasattr(self, 'apps'):
            # update the buld environment with all the enviroment variables
            # specified in apps argument!
            if self.baseLibs:
                pipe.version.set(python=self.os_environ['PYTHON_VERSION'])
                pipe.versionLib.set(python=self.os_environ['PYTHON_VERSION'])

            print bcolors.WARNING+": ", bcolors.BLUE+"  apps: ",
            for (app, version) in self.apps:
                className = str(app).split('.')[-1].split("'")[0]
                pipe.version.set({className:version})
                app = app()
                app.fullEnvironment()
                print "%s(%s)" % (className, version)
                # get all vars from app class and add to cmd environ
                for each in app:
                    if each not in ['LD_PRELOAD','PYTHON_VERSION','PYTHON_VERSION_MAJOR']:
                        v = app[each]
                        if type(v) == str:
                            v=[v]
                        if each not in self.os_environ:
                            self.os_environ[each] = ''
                        # if var value is paths
                        if 'ROOT' in each:
                            self.os_environ[each] = v[0]
                        elif '/' in str(v):
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

        mkdir = 'mkdir -p $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/'
        if mkdir.replace(' ','').lower() not in cmd.replace(' ','').lower():
            cmd = "%s && %s" % (mkdir,cmd)
        return cmd











#    def action(self, target, source):
#        self.registerSconsBuilder(self.pythonSetup)
#        return self.env.pythonSetup( target, source )


#    def pythonSetup(self, target, source, env):
#        dirLevels = '..%s' % os.sep * (len(str(source[0]).split(os.sep))-1)
#        installDir = os.path.dirname(str(target[0]))
#        pythonVersion = str(target[0]).split('python')[-1].split('.done')[0]
#        site_packages = os.path.join(dirLevels,installDir,'lib/python$PYTHON_VERSION_MAJOR/site-packages')


#        cmd = 'python %s build' % (
#            env['CMD'],
#        )
#        print bcolors.GREEN+'\tbuilding...'+bcolors.END
#        self.runCMD(cmd,target,source)

##        cmd = 'cd "%s"; ppython %s install --prefix=%s' % (os.path.dirname(source), os.path.basename(source), os.path.join(dirLevels,installDir))
#        cmd = 'mkdir -p $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ &&  python %s install --prefix=$TARGET_FOLDER' % (
#            env['CMD'],
#        )
#        print bcolors.GREEN+'\tinstalling...'+bcolors.END
#        self.runCMD(cmd,target,source)

#        cmd = 'ppython --python_version %s %s clean 2>&1' % (
#            pythonVersion,
#            os.path.basename(source)
#        )
#        print 'cleaning up...'
#        runCMD(cmd,target)
