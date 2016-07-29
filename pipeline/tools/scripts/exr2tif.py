#!/usr/bin/env ppython


import IECore, sys, os

# load image
envMap = IECore.Reader.create( sys.argv[1] )()


# save to disk
print sys.argv[2], os.getcwd()
IECore.Writer.create( envMap, sys.argv[2] )()