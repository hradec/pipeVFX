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
