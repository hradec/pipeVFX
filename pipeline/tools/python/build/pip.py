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


class pip(generic):
    src = 'setup.py'
    cmd = [
        '$PYTHON_TARGET_FOLDER/bin/pip install --prefix=$INSTALL_TARGET_FOLDER $DOWNLOAD_FILE',
    ]
    download_cmd = "pip download '$url' -d $(dirname $save) >$log.log 2>&1"


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
