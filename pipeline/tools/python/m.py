import sys, os, glob
mayaPath = os.path.abspath( '%s/tools/maya/plugins' % os.environ['HOME'] )
sys.path.append( mayaPath )
print mayaPath
for a in glob.glob(mayaPath+'/*'):
    print a

import hradecCustomization 

msocket=hradecCustomization.msocket()
mel = msocket.mel
connect = msocket.connect 
save = msocket.save
load = msocket.load

try:
    msocket.connect()
except Exception, msg: 
    print "can't connect to server %s\n\t%s" % ( str(msocket.url) , str(msg))
    print "starting server instead..."
    msocket.bind()
    print "m module running as server."

del a, mayaPath, sys, os, glob, hradecCustomization
