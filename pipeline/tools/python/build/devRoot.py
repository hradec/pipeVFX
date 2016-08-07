


import os, pipe


def installRoot(args={}):
    if args.has_key('DOIT'):
        # DOIT will install properly in the right place,
        # respecting the ROOT env var as the path for the pipeVFX root!
        dev = pipe.build.install()
    else:
        # we mangle the ROOT env var so we can get a install
        # folder local to the current folder, by default!
        tmp = None
        if os.environ.has_key('ROOT'):
            tmp = os.environ['ROOT']
            del os.environ['ROOT']
        dev = pipe.build.devInstall()
        if tmp:
            os.environ['ROOT'] = tmp
    if args.has_key('PREFIX'):
        dev = args['PREFIX']
    os.system("mkdir -p %s" % dev)
    return dev

def buildFolder(args={}):
    build = '.build'

    if args.has_key('BUILD_FOLDER'):
        build = args['BUILD_FOLDER']

    return build
