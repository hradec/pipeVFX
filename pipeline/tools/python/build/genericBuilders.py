from  SCons.Environment import *
from  SCons.Builder import *
from devRoot import *

import os

class generic:

    def __init__(self, args, env, sed=None, download=None ):
        self.args = args
        self.env = env
        if env==None:
            self.env = Environment()
        self.downloadList = download
        self.sed  = sed
        self.installPath = installRoot(self.args)

        
        bld = Builder(action = self.sed)
        self.env.Append(BUILDERS = {'sed' : bld})
        
        bld = Builder(action = self.downloader)
        self.env.Append(BUILDERS = {'downloader' : bld})

        bld = Builder(action = self.uncompressor)
        self.env.Append(BUILDERS = {'uncompressor' : bld})


#    def downloader( self, target, source, env):        
#        for d in self.downloadList:
#            md5 = ''.join(os.popen("cd %s && md5sum %s 2>/dev/null | cut -d' ' -f1" % (buildFolder(self.args), d[1])).readlines()).strip()
#            if md5 != d[3] or not os.path.exists(os.path.join(buildFolder(self.args),d[1])):
#                print "Downloading... please wait..."
#                os.popen("cd %s && wget '%s' -O %s 2>&1" % (buildFolder(self.args), d[0], d[1])).readlines()
#                md5 = ''.join(os.popen("cd %s && md5sum %s 2>/dev/null | cut -d' ' -f1" % (buildFolder(self.args), d[1])).readlines()).strip()
#                print "md5 for file:",d[1], md5
#                if md5 != d[3]:
#                    raise Exception("Download failed! MD5 check didn't match the one described in the Sconstruct file")

    def downloader( self, target, source, env):        
        for n in range(len(source)):
            url = filter(lambda x: os.path.basename(str(target[n])) in x[0], self.downloadList)[0]
            md5 = ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % target[n]).readlines()).strip()
            if md5 != self.downloadList[n][3] or not os.path.exists(target[n]):
                print "\tDownloading %s... please wait..." % target[n]
                os.popen("wget '%s' -O %s 2>&1" % (url[0], target[n])).readlines()
                md5 = ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % target[n]).readlines()).strip()
                print "\tmd5 for file:", url[1], md5
                if md5 != url[3]:
                    raise Exception("\tDownload failed! MD5 check didn't match the one described in the Sconstruct file")
            
    def uncompressor( self, target, source, env):        
        for n in range(len(source)):
            url = filter(lambda x: os.path.basename(str(source[n])) in x[0], self.downloadList)[0]
            print source[n]
            s = os.path.abspath(str(source[n]))
            t = os.path.abspath(str(target[n]))
            md5 = ''.join(os.popen("md5sum %s 2>/dev/null | cut -d' ' -f1" % s).readlines()).strip()
            if md5 == url[3]:
                print "\tMD5 OK for file ", source[n], 
                print "... uncompressing... "
                os.popen( "rm -rf %s 2>&1" % os.path.dirname(t) )
                cmd = "cd %s && tar xf %s 2>&1" % (os.path.dirname(os.path.dirname(str(target[n]))),s)
                print cmd
                lines = os.popen(cmd).readlines()
                cmd =  "mv %s %s 2>&1" % (s.replace('.tar.gz',''), os.path.dirname(t))
                print cmd
                os.system( cmd )
                if not os.path.exists(str(target[n])):
                    print '-'*120
                    for l in lines:
                        print '\t%s' % l.strip()
                    print '-'*120
                    raise Exception("Uncompress failed!")
                    
#            os.system("cd %s && rm -rf %s" % (buildFolder(self.args),d[1]))

    def sed( self, target, source, env):
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

        for n in range(len(target)):
            _sed( target[n], source[n], self.sed )
    
    def download(self,target, source="SConstruct"):
        ret = source
        if self.downloader:
            ret = self.env.downloader( target, ret)
            self.env.Clean( ret, target )
        return ret

    def uncompress(self,target, source):
        ret = self.env.uncompressor( target, source )
        for t in target:
            self.env.Clean( ret, os.path.dirname(t) )
        return ret

    def sed(self,target,source):
        ret=source
        if self.sed:
            ret = self.env.sed( target, ret)
            self.env.Clean(ret, target)
        return ret            
