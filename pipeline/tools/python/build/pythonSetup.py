
from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import utils
import pipe
import os,sys

version = '!VERSION!'


class pythonSetup:

    def __init__ ( self,
                  args,
                  name,
                  version='1.0.0',
                  env=None,
                  pythonVersion=pipe.libs.version.get('python'),
                  src=None,
                  url="",
                  svn=False,
                  extractFolder=None, # the folder where the compressed files are exported to
                  installModuleFile=None, # put here the relative isntallation path+one file from the module
                  installBin=False,
                  sed=[],
                  
                ):
        self.name = name
        self.args = args
        self.version = version
        self.pythonVersion = pythonVersion
        self.src = os.path.join(name,src)
        self.url = url
        self.svn = svn
        self.installPath = installRoot(self.args)
        self.env=env
        if env==None:
            self.env = Environment()
        self.sed = sed
        self.version = version
        self.clean = []
        self.extractFolder=''
        if extractFolder!=None:
            self.extractFolder = extractFolder
        self.installModuleFile = os.path.join( self.name, '__init__.py' )
        if installModuleFile!=None:
            self.installModuleFile = installModuleFile
        self.installBin = installBin
        self.sed.append('s/!%s!/%s/g' % ('VERSION',self.version) )
        # create our custom build folder
        os.system('mkdir -p "%s"' % name )

    @staticmethod
    def builder( target, source, env):
        target=str(target[0])
        source=str(source[0])
        sed = filter(lambda x:x[0]=='SED', env.items())[0][1]
        sed = eval(sed)

        installDir = os.path.dirname(target)
        if not os.path.exists(installDir):
            os.makedirs(installDir)

        #cmd = 'sed "%s" %s > %s' % ( ';'.join(sed), source, target )
        #print '\t', cmd
        print source
        dirLevels = '..%s' % os.sep * (len(source.split(os.sep))-1)

        cmd = 'cd "%s"; ppython %s install --prefix=%s' % (os.path.dirname(source), os.path.basename(source), os.path.join(dirLevels,installDir))
        print cmd
        if os.system(cmd)==0:
            os.system( 'echo a >> "%s"' % target )
        else:
            raise 'Error executing setup.py'

    @staticmethod
    def installer( target, source, env):
        os.system( 'rm -rf "%s"' % os.path.dirname(str(target[0])) ) # remove folder created by scons

        sed = eval(filter(lambda x:x[0]=='SED', env.items())[0][1])
        installBin = filter(lambda x:x[0]=='INSTALLBIN', env.items())[0][1]
        args = filter(lambda x:x[0]=='ARGS', env.items())[0][1]
        p = filter(lambda x:x[0]=='PYTHON_VERSION', env.items())[0][1]

        registerSedBuilder(env, sed)

        target=os.path.dirname(os.path.dirname(str(target[0])))
        source=str(source[0])
        builderFolder = os.path.dirname(source)
        tmp = builderFolder #os.path.join(os.path.dirname(source), 'lib', 'python%s' % p, 'site-packages')
        moduleBuildDir = tmp
        clean=[]
        os.system('mkdir -p "%s"' % target)
        for each in os.listdir(moduleBuildDir):
            source = os.path.join( moduleBuildDir, each )
            print 'Install file: "%s" as "%s"' % (source, os.path.join(target, each))
            registerSedBuilder.builder([os.path.join(target, each)], [source], env)
            #os.system( 'cp -rf "%s" "%s"' % (source, target) )
            clean.append(os.path.join(target, each))
            #env.Command( target, source, Copy ("$TARGET", "$SOURCE") )

#TODO: INSTALLER NEED TO SED!!!!!!!
#        if installBin:
#            bin = os.path.join( builderFolder, 'bin' )
#            for each in os.listdir(bin):
#                if each[0]!='.':
#                    registerSedBuilder.builder( [os.path.join(utils.central('apps',args), 'bin', each)], [os.path.join(bin, each)], env)
#                    os.system( 'chmod a+x "%s"' % os.path.join(utils.central('apps',args), 'bin', each) )
                    #self.env.Alias( 'install', self.env.Install( os.path.join(os.path.dirname(self.installPath), 'bin'), each ) )

    @staticmethod
    def downloader( target, source, env):
        target=(str(target[0]))
        source=str(source[0])
        extractedFolder = filter(lambda x:x[0]=='EXTRACTFOLDER', env.items())[0][1]
        name = filter(lambda x:x[0]=='NAME', env.items())[0][1]
        svn = filter(lambda x:x[0]=='SVN', env.items())[0][1]
        buildFolder = os.path.basename(name)
        cmd='svn'
        if not svn:
            source = 'http:/'+source.split('http:')[1]
            # add our custom build folder to the download file (we want to download inside the build folder)
            file = os.path.join(buildFolder, os.path.basename(source))
            fileNoExt = os.path.splitext(file)
            ext = fileNoExt[1]
            if not os.path.exists(os.path.join('.',file)):
                os.system('cd "%s"; wget %s' % (buildFolder, source))

            if ext == '.zip':
                os.system('cd "%s"; unzip -o "%s"' % (buildFolder , os.path.basename(file) ) )
            else:
                tarOpts = '-xzf'
                if ext == '.bz2':
                    tarOpts = '-xjf'
                os.system('cd "%s"; tar %s "%s"' % (buildFolder , tarOpts, os.path.basename(file) ) )

            os.system( 'rm -rf "%s"' %  name) # remove folder created by scons
            if len(extractedFolder)==0:
                extractedFolder = filter( lambda x:os.path.isdir(os.path.join(buildFolder, x)) and x[0]!='.' and x!='http:', os.listdir(buildFolder))[0]
                os.system('mv "%s" "%s"' % (os.path.join(buildFolder,extractedFolder), os.path.dirname(target)) )

        else:
            os.system('rm -rf "%s"' % os.path.dirname(target))
            tmp = source.split(':')
            protocol = tmp[0].split(os.path.sep)
            print source
#            source = protocol[len(protocol)-1]+':/'+tmp[1]
            print 'svn co %s  %s' % (source, buildFolder ) 
            os.system( 'svn co %s  %s' % (source, buildFolder ) )
        return True


    def finalize(self):
        self.env.Append(SED=str(self.sed)) # send SED to the environment so the builder can pick it up!
        self.env.Append(EXTRACTFOLDER=self.extractFolder)
        self.env.Append(NAME=self.name)
        self.env.Append(SVN=self.svn)
        self.env.Append(ARGS=self.args)
        self.env.Append(PYTHON_VERSION=self.pythonVersion[:3])
        self.env.Append(INSTALLBIN=self.installBin)
        bld = Builder(action = pythonSetup.builder)
        self.env.Append(BUILDERS = {'pythonSetup' : bld})
        bld = Builder(action = pythonSetup.installer)
        self.env.Append(BUILDERS = {'pythonSetupInstall' : bld})
        bld = Builder(action = pythonSetup.downloader)
        self.env.Append(BUILDERS = {'pythonSetupDownload' : bld})

        # if the download file dont exists, touch it so the builder can download it!
        os.system('mkdir -p  "%s"' % os.path.dirname(self.src) )
        os.system('touch "%s"' % self.src )
        setup_py = os.path.join( self.name, 'setup.py' )
        if len(self.extractFolder)>0:
            setup_py = os.path.join( self.extractFolder, 'setup.py' )
#        d = self.env.pythonSetupDownload( setup_py, self.url)
#        # add files to be cleaned later
#        self.env.Clean(d, os.path.basename(self.name))
        pythonSetup.downloader([setup_py], [self.url], self.env)

        # build it running setup.py
        # installation folder
        installPath = os.path.join( self.installPath,  self.name, self.version( os.path.join( self.name, buildFolder() ) ), 'install.done' )

        target = installPath # os.path.join( os.path.dirname(self.name), buildFolder(), 'setup.py.done' )
        t = self.env.pythonSetup( target, self.src )
        #self.env.Clean(t,  buildFolder(self.args))

        # custom build for install
        #install = self.env.pythonSetupInstall(installPath, t)
        # as our install is a custom builder, we need to tell scons what to remove if cleaned
        #self.env.Clean(install, os.path.dirname(installPath) )


        self.env.Alias( 'install', t )
