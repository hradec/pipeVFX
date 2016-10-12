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
import os

version = '!VERSION!'

class ftp:

	def __init__ ( self, args, src=[], target=None,sed=[] ):
		self.args = args
		self.version = version
		self.src = src # if source is a tuple, [0] is source and [1] target name in the ftp
		self.target = target
		self.env=Environment()
		self.sed = sed
		self.sed.append('s/!%s!/%s/g' % ('VERSION',self.version) )

	@staticmethod
	def ftpInstaller( target, source, env):
		import  ftpRsync
		target=str(target[0])
		source=str(source[0])
		ftpRsync.rsync(source, target.replace('ftp:/','ftp://'))
		os.system('rm -rf "ftp:"')

	def finalize(self):
		# build intermediate source
		bld = Builder(action = ftp.ftpInstaller)
		self.env.Append(BUILDERS = {'ftpInstaller' : bld})

		registerSedBuilder(self.env, self.sed)
		src=[]
		for each in self.src:
			if type(each)==type(()):
				target = each[1]
				each = each[0]
			else:
				target = each
			new = os.path.join(buildFolder(self.args), os.path.basename(target))
			self.env.sedBuilder( new, each)
			src.append(new)

		# install
		for each in src:
			inst = "%s/%s" % (self.target,os.path.basename(each))
			self.env.Alias( 'install', self.env.ftpInstaller( inst, each ) )
