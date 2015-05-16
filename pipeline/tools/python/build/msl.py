
from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *
from utils import *
from genericBuilders import *
import os

version = '!VERSION!'

class msl:

	def __init__ ( self, args, version='1.0.0', versionControled=False, env=None, prefix=None, src=[], sed=[] ):
		self.args = args
		self.version = version
		self.src = src
		self.installPath = os.path.join( central('tools',args,prefix=prefix), 'shaders','3delight' )
		if versionControled:
			self.installPath = os.path.join(self.installPath, name, self.version)

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
			new = os.path.join(buildFolder(self.args), os.path.basename(each))
			self.env.sedBuilder( new, each)
			src.append(new)

		# install
		install = []
		for each in src:
			name = os.path.splitext(os.path.basename(each))[0]
			install.append( self.env.Install( self.installPath, each) )

		self.env.Alias( 'install', install )
