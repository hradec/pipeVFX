
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
