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
from devRoot import *
from pythonModule import *
from utils import *
import pipe
import os

version = '!VERSION!'

class mayaPython(pythonModule):

	def __init__ ( self, args, name, version='1.0.0',  mayaVersion=pipe.apps.version.get("maya"), env=None, pythonVersion='', src=[{'path':'','installPath':''}], installPrefix=None, sed=[] ):
		pythonModule.__init__ ( self,
								args,
								name,
								version,
								env,
								pythonVersion,
								src,
								os.path.join(central('tools', args), 'maya', mayaVersion),
								sed
							)
