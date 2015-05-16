
from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *
from pythonModule import *
from utils import *
import pipe
import os

version = '!VERSION!'

class mayaPython(pythonModule):

	def __init__ ( self, args, name, version='1.0.0',  mayaVersion=pipe.apps.version.get("maya"), env=None, pythonVersion='', src=[{'path':'','installPath':''}], installPrefix=None, sed=[] ):
		pythonModule.__init__ ( self,
								args,
								name,
								version,
								env,
								pythonVersion,
								src,
								os.path.join(central('tools', args), 'maya', mayaVersion),
								sed
							)
