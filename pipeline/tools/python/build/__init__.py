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

from devRoot import *
from ftp import *
from genericBuilders import *
from mayaPlugin import *
from mayaPython import *
from mayaPythonPlugin import *
from configure import *
from configure import cortex as _cortex
from configure import gaffer as _gaffer
from make import *
from msl import *
from pythonModule import *
from pythonSetup import *
from sl import *
from utils import *

# pkgs will have all scons builds as its parameters
# ex: to use boost, just add pkgs.boost as a dependency
import pkgs


# prevent importing build.gaffer when running inside a build
# for example, cortex_options.py and gaffer_options.py import
# this build module when running cortex and gaffer scons build.
# we don't want to import the gaffer py in this situation.
if 'BUILD_RUNNING' not in os.environ:
    from gaffer import gaffer, cortex
    from gafferCycles import gafferCycles



SHLIBEXT=[
    '.so',
    '.dylib',
]
