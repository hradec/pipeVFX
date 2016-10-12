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
import os, sys

version = '!VERSION!'

DELIGHT=None
if os.environ.has_key('DELIGHT'):
	DELIGHT=os.environ['DELIGHT']

DL_SHADER_PATH=None
if os.environ.has_key('DL_SHADER_PATH'):
	DL_SHADER_PATH=os.environ['DL_SHADER_PATH']

class sl:

	def __init__ 	( self, args,
						version='1.0.0',
						dlpath=DELIGHT,
						include=DL_SHADER_PATH,
						options='',
						#versionControled=os.environ.has_key('PIPE_DEP'),
						versionControled=False,
						env=None,
						prefix=None,
						src=[],
						sed=[]
					):

		self.args = args
		self.version = version
		self.dlpath = os.popen('eval echo "%s"' % dlpath).readlines()[0].strip()
		if not dlpath:
			raise Exception("cant find 3delight. Set DELIGHT to the 3delight install path")
		self.include = os.popen('eval echo "%s"' % include).readlines()[0].strip()
		self.options = options
		self.src = src
		self.installPath = os.path.join( central('tools',args,prefix=prefix), 'shaders', '3delight' )
		if versionControled:
			self.installPath = os.path.join(self.installPath, name, self.version)
		self.env=env
		if not env:
			self.env=Environment()
		self.sed = sed
		self.sed.append('s/!%s!/%s/g' % ('VERSION',self.version) )

		self.env.Append(include=self.include)
		self.env.Append(dlpath=self.dlpath)
		self.env.Append(options=self.options)


	@staticmethod
	def builder( target, source, env):
		target=str(target[0])
		source=str(source[0])

		dlpath = filter(lambda x:x[0]=='dlpath', env.items())[0][1]
		include = filter(lambda x:x[0]=='include', env.items())[0][1].split(':')
		options = filter(lambda x:x[0]=='options', env.items())[0][1]

		shaderdl = os.path.join(dlpath,'bin','shaderdl')
		include = '-I'.join(include)

		os.system('%s %s -I%s %s -o %s' % (shaderdl, options, include, source, target)  )


	def finalize(self):
		bld = Builder(action = sl.builder)
		self.env.Append(BUILDERS = {'slBuilder' : bld})

		# build intermediate source
		registerSedBuilder(self.env, self.sed)
		src=[]
		for each in self.src:
			new = os.path.join(buildFolder(self.args), os.path.basename(each))
			sdl = new.replace('.sl','.sdl')
			print >>sys.stderr, new,sdl
			self.env.sedBuilder( new, each)
			self.env.slBuilder( sdl, new  )
			src.append(sdl)

		# install
		install = []
		for each in src:
			name = os.path.splitext(os.path.basename(each))[0]
			install.append( self.env.Install( self.installPath , each) )

		self.env.Alias( 'install', install )
