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
        'python setup.py install  --prefix=$TARGET_FOLDER',
    ]

    # def uncompressor( self, target, source, env):
    #     ''' pyside2 has the same file name for all package versions - thanks autodesk!'''
    #     t = os.path.abspath(str(target[0]))
    #     if 'pyside' in t:
    #         # copy original to pyside-setup file,
    #         # so uncompressor can work
    #         pyside = os.path.dirname(t)+'pyside-setup'+os.path.splitext(t)[-1]
    #         if os.system( 'cp %s %s' % (t, pyside) ) == 0:
    #             configure.uncompressor( self, [pyside], source, env)
    #         else:
    #             Exception("Can't crete pyside-setup file!")
    #     else:
    #         configure.uncompressor( self, target, source, env)

    def fixCMD(self, cmd):
        mkdir = 'mkdir -p $TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/ && export PYTHONPATH=$TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/site-packages/:$PYTHONPATH'
        if mkdir.replace(' ','').lower() not in cmd.replace(' ','').lower():
            cmd = "%s && %s" % (mkdir,cmd)

        if hasattr(self, 'flags'):
            f = ' '.join(set(self.flags))
            if f not in cmd:
                cmd += ' ' + f
                
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
