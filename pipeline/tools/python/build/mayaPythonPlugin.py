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
from utils import *
from genericBuilders import *
import pipe
import os

version = '!VERSION!'

class mayaPythonPlugin:

	def __init__ ( self, args, version='1.0.0', mayaVersion=pipe.apps.version.get("maya"),  env=None, prefix=None, src=[], sed=[] ):
		self.args = args
		self.version = version
		self.src = src
		self.installPath = os.path.join(central('tools', args), 'maya', mayaVersion,'plugins')

		self.env=env
		if not env:
			self.env=Environment()

		self.sed = sed
		self.sed.append('s/!%s!/%s/g' % ('VERSION',self.version) )

	def finalize(self):
		# build intermediate source
		registerSedBuilder(self.env, self.sed)
		src=[]
		for each in self.src:
			semSuffix = each.strip(os.path.sep).split(os.path.sep)
			new = os.path.join( buildFolder(self.args), os.path.sep.join( semSuffix[1:]) )
			self.env.sedBuilder( new, each)
			src.append(new)

		# install
		install = []
		for each in src:
			name = os.path.splitext(os.path.basename(each))[0]
			semSuffix = each.strip(os.path.sep).split(os.path.sep)

			self.env.Alias( 'install', self.env.InstallAs( os.path.join(self.installPath, os.path.sep.join( semSuffix[1:])), each) )
