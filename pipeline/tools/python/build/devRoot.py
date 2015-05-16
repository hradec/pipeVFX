


import os, pipe


def installRoot(args={}):
    dev = pipe.build.devInstall()
    if args.has_key('PREFIX'):
        dev = args['PREFIX']
    os.system("mkdir -p %s" % dev)
    return dev

def buildFolder(args={}):
	build = '.build'

	if args.has_key('BUILD_FOLDER'):
		build = args['BUILD_FOLDER']

	return build