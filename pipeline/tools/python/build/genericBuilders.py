from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *

import os

class registerSedBuilder:

	def __init__(self,  env, sed ):
		bld = Builder(action = registerSedBuilder.builder)
		env.Append(sedBuilderSED=sed)
		env.Append(BUILDERS = {'sedBuilder' : bld})

	@staticmethod
	def builder( target, source, env):
		target=str(target[0])
		source=str(source[0])
		sed = filter(lambda x:x[0]=='sedBuilderSED', env.items())[0][1]

		def _sed(target,source,sed):
			installDir = os.path.dirname(target)
			if not os.path.exists(installDir):
				#env.Execute( Mkdir(installDir) )
				os.makedirs(installDir)

			if os.path.isfile(source):
				cmd = 'sed \'%s\' %s > %s' % ( ';'.join(sed), source, target )
				#print '\t', cmd
				os.system( cmd )

			if os.path.isdir(source):
				for each in os.listdir(source):
					if each[0] != '.':
						_sed( os.path.join(target, each), os.path.join(source, each), sed )

		_sed( target, source, sed )
