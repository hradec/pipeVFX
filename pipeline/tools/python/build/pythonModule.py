
from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *
from utils import *

version = '!VERSION!'

class pythonModule:

	def __init__ ( self, args, name, version='1.0.0',  env=None, pythonVersion='2.5', src=[{'path':'','installPath':''}], installPrefix=None, sed=[] ):
		self.name = name
		self.args = args
		self.version = version
		self.pythonVersion = pythonVersion
		self.src = src
		if not installPrefix:
			self.installPath = installRoot(self.args)
		else:
			self.installPath = installPrefix
		self.env=env
		if self.env==None:
			self.env = Environment()
		self.sed = sed
		self.sed.append('s/!%s!/%s/g' % ('VERSION',self.version) )

	@staticmethod
	def pythonModuleBuilder( target, source, env):
		target=str(target[0])
		source=str(source[0])
		sed = filter(lambda x:x[0]=='pythonModuleSED', env.items())[0][1]

		installDir = os.path.dirname(target)
		if not os.path.exists(installDir):
			env.Execute( Mkdir(installDir) )
			os.makedirs(installDir)

		cmd = 'sed "%s" %s > %s' % ( ';'.join(sed), source, target )
		#print '\t', cmd
		os.system( cmd )


	def finalize(self):

		bld = Builder(action = pythonModule.pythonModuleBuilder)
		self.env.Append(pythonModuleSED=self.sed)
		self.env.Append(BUILDERS = {'pythonModuleBuilder' : bld})

		installPath = os.path.join( self.installPath, 'python', self.pythonVersion, self.name )
		install=[]
		for each in self.src:
			if type(each) == dict:
				each = each['path']

			p = each.split(os.path.sep)
			if len(p)>1:
				del p[0]
			target = os.path.join( buildFolder(self.args) , os.path.sep.join(p) )
			self.env.pythonModuleBuilder( target, each )

			install.append( self.env.Install( os.path.join(installPath, os.path.sep.join(os.path.dirname(target).split(os.path.sep)[1:]) ) , target ) )

		self.env.Alias( 'install', install)
