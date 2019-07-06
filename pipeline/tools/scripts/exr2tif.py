#!/bin/python2
import sys, os
sys.path.append('/atomo/pipeline/tools/python/')

import pipe
from pprint import pprint

cortex=pipe.apps.cortex()
cortex.update( pipe.libs.boost()  )
cortex.update( pipe.libs.jpeg() )
cortex.fullEnvironment()
cortex.expand()
sys.path += cortex['PYTHONPATH']

# print sys.argv
try:
    import IECore
except:
    if '--second' not in sys.argv:
        os.environ['PYTHONHOME'] = '/usr/'
        sys.exit( os.system( '"%s" "%s" "%s"  --second' % (sys.argv[0], sys.argv[1], sys.argv[2]) ) )

# load image
i = IECore.Reader.create( sys.argv[1] )()

names =  i.channelNames()
if names[0].split('.')[0] not in ['R','G','B','Z']:
    for n in names[:3]:
        print i[n].interpolation
        i[n.split('.')[-1].upper()] = i[n]
        #del i[n]


# save to disk
print 'EXR2TIF:', sys.argv[1], '===>', sys.argv[2]
IECore.Writer.create( i, sys.argv[2] )()
