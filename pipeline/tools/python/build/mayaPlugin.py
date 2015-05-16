
from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *
from utils import *
from genericBuilders import *
import pipe
import os

version = '!VERSION!'

class mayaPlugin:

	def __init__ ( self, args, name, version='1.0.0',  mayaVersion = pipe.apps.version.get("maya"), env=None, src=[], sed=[], libs=[], includes=[], libPath=[], includePath=[] ):
		self.name = name
		self.args = args
		self.version = version
		self.src = src
		self.installPath = os.path.join( central('tools',args), 'maya', mayaVersion )
		self.env=env
		if not env:
			self.env=Environment()
		self.sed = sed
		self.sed.append('s/!%s!/%s/g' % ('VERSION',self.version) )
		self.libs=libs
		self.includes=includes
		self.libPath = libPath
		self.includePath = includePath

	def finalize(self):

		# find maya path
		maya = pipe.apps.maya().path()

		# add default include/lib paths
		self.env.Append(CPPPATH=[
									buildFolder(),
									'./include',
									os.path.join(maya, 'include'),
								])
		self.env.Append(CPPPATH=self.includePath)

		self.env.Append(LIBPATH=[os.path.join(maya, 'lib')])
		self.env.Append(LIBPATH=self.libPath)

		self.env.Append(LIBS=[
							'OpenMaya',
							'Foundation',
							])
		self.env.Append(LIBS=self.libs)


		self.env.Append(CPPFLAGS=[
									'-DOSMac_',
									'-DMAC_PLUGIN',
									'-D_BOOL',
									'-DREQUIRE_IOSTREAM',
									'-DIE_MAJOR_VERSION=%s' % self.version.split('.')[0],
									'-DIE_MINOR_VERSION=%s' % self.version.split('.')[1],
									'-DIE_PATCH_VERSION=%s' % self.version.split('.')[2],
								])

		self.env.Append(LINKFLAGS=[
#									'-bundle',
								])


		if pipe.platform=='darwin':
			self.env.Append(CPPPATH=[
										'/System/Library/Frameworks/AGL.framework/Versions/A/Headers',
										'/Developer/SDKs/MacOSX10.5.sdk/System/Library/Frameworks/OpenGL.framework/Versions/Current/Headers',
									])


		# build intermediate source
		registerSedBuilder(self.env, self.sed)
		src=[]
		for each in self.src:
			new = os.path.join(buildFolder(self.args), os.path.basename(each))
			self.env.sedBuilder( new, each)
			src.append(new)

		# build it for real!
		plugin = self.env.SharedLibrary(self.name+'.'+self.version, src)
		self.env.Clean(plugin , buildFolder(self.args))

		# install plugin
		installPath = os.path.join( self.installPath, 'plugins' )
		new_plugin = plugin
		if pipe.platform=='darwin':
			new_plugin = self.env.Command( os.path.join(buildFolder(self.args), self.name+'.'+self.version+'.bundle' ), plugin, 'mv $SOURCE $TARGET')
		install = self.env.Install(installPath, new_plugin)
		self.env.Alias( 'install', install )
