
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
