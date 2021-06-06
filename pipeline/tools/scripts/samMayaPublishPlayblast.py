#!/usr/bin/env python2

import sys, os, argparse, math
from glob import glob
import pipe


if len(sys.argv)<2:
    sys.argv += ['-h']

# parser = argparse.ArgumentParser(description='Apply character animation from maya scenes to rig/maya assets, and publish to animation/alembic.')
# parser.add_argument('-m', dest='maya_scene', help='the maya scene file to read the animation from')
# parser.add_argument('-j', dest='job', help='set the job to use during publish')
# parser.add_argument('-s', dest='shot', help='set the shot to use during publish')
# parser.add_argument('-i', dest='rig_maya', action='append', help='the rig/maya asset to import and apply the animation from the maya scene specified in -m parameter. (you can use -i multiple times)')
# parser.add_argument('-o', dest='animation_alembic', help='the animation/alembic asset name to publish the animated rig/maya assets imported using -i.')
# parser.add_argument('--farm', dest='farm', action='store_true', help='execute the publishing on the farm')

parser = argparse.ArgumentParser(description='Gera cena de playblasts e publicha em maya/render/<shot>.playblast. Use -i para importar um asset/alembic/camera para usar como camera do playblast!')
parser.add_argument('-j', dest='job', help='seta o job para usar durante a publicacao')
parser.add_argument('-s', dest='shot', help='seta o shot para usar durante a publicao')
parser.add_argument('-i', dest='asset', action='append', help='nome do asset para importar antes de gerar o playblast. O nome do primeiro asset sera usado no nome do playblast! ex. -i animation/alembic/personagens => render/maya/playblast_personagens (use -i varias vezes para importar mais de um asset)')
parser.add_argument('--hide', dest='hide', action='append', help='nome de um mesh q precisa ser hiden no render do playblas.')
parser.add_argument('--start', dest='start', help='start frame override.')
parser.add_argument('--end', dest='end', help='end frame override.')
parser.add_argument('--maxdist', dest='maxdist', help='max distance for occlusion. Se nao for especificado, o script tenta calcular com base no primeiro asset.')


# parser.add_argument('--farm', dest='farm', action='store_true', help='faz a importacao e publicacao no farm.')

parser.add_argument('-v', dest='version', help='versao do playblast a ser publicado, ao inves de usar a ultima versao +0.1.0.')
parser.add_argument('-n', dest='ndryrun', action='store_true', default=False, help='nao faz nada! so simula o resultado sem fazer nada.')
parser.add_argument('-lj', dest='listJobs', action='store_true', default=False, help='lista todos os jobs')
parser.add_argument('-ls', dest='listShots', action='store_true', default=False, help='lista todos os shots no job')


args = parser.parse_args()

prman=1
resolution=(1920,1080)


if args.listJobs:
    for each in pipe.admin.jobs():
        print each

elif args.listShots:
    a=pipe.admin.job(args.job).assets()
    ai = a.keys()
    ai.sort()
    for each in ai:
        print ' '.join( a[each].split('/')[-2:] )
    s=pipe.admin.job(args.job).shots()
    si = s.keys()
    si.sort()
    for each in si:
        print ' '.join( s[each].split('/')[-2:] )


elif args.asset:

    # procura um camera asset
    camera = [ x for x in args.asset if 'camera' in x]
    if not camera:
        raise Exception("Coloque pelo menos um asset camera para usar como camera do playblast!")

    j = args.job
    s = args.shot
    if not j:
        j = pipe.admin.job.current().name()
    if not s:
        s = pipe.admin.job.shot.current().name()

    if 0: #args.farm:
        import pipe
        # cmd = " ".join([ x for x in sys.argv if '--farm' not in x ])
        cmd = 'export FARM=1 && ' + ' '.join([ x for x in sys.argv if '--farm' not in x ])
        print cmd
        title = "SAM %s_%s %s: playblast %s" % ( j, s, os.path.basename(sys.argv[0]), ', '.join(args.asset) )
        print title
        if not args.ndryrun:
            pipe.farm.cmds(title, [cmd], [''], capacity=1000).submit()
    else:
        try:
            import pymel.core as pm
        except:
            # if we're not in mayapy, restart the script running inside mayapy!
            cmd  = "xvfb-run --auto-servernum  bash -c 'source /atomo/pipeline/tools/scripts/go %s shot %s && run mayapy " % (j, s)
            cmd += ' '.join(sys.argv)
            cmd += "'"
            if args.ndryrun:
                print cmd
            os.system(cmd)
            sys.exit(0)

        import maya.cmds as m
        import assetUtils, genericAsset

        # load everything in the maya scene
        # this also sets the time slider frame range!
        cameraAsset=None
        for each in args.asset:
            print each
            asset = assetUtils.assetOP( each, 'maya' )
            asset.getCurrent()
            # asset.loadOP()
            # asset.parameters()['Asset']['info']['name'].setValue( IECore.StringData( os.path.basename(each) ) )
            if asset.doesAssetExistOnDisk():
                asset.doImport()

            if 'camera' in each:
                cameraAsset = asset

        # retrieve frame range after importing assets!
        range = genericAsset.maya.frameRange(V3fData=True)
        if args.start:
            range = IECore.V3fData( IECore.V3f( float(args.start), range.value.y, range.value.z ) )
        if args.end:
            range = IECore.V3fData( IECore.V3f( range.value.x, float(args.end), range.value.z ) )


        # prepare the render!
        rg=pm.ls("defaultRenderGlobals")[0]
        rg.setAttr('currentRenderer', 'mayaSoftware')
        if prman:
            rg.setAttr('currentRenderer', 'renderManRIS')
            pr=pm.ls("renderManRISGlobals")[0]
            pr.setAttr("rman__riopt__Integrator_name", "PxrOcclusion")
            pr.setAttr("rman__riopt__Format_resolution0", resolution[0])
            pr.setAttr("rman__riopt__Format_resolution1", resolution[1])
            pr.setAttr("rman__riopt___PixelVariance", 0.02)
            pr.setAttr("rman__riopt__Hider_maxsamples", 128)
            pr.setAttr("rman__torattr___denoise", 0)

            # set maxdistance from first asset, the same used for the playblast name!
            print args.asset[0]
            a=assetUtils.assetOP(args.asset[0], 'maya')
            a.getCurrent()
            a.printParameters()
            print a.data, a.nodeName()
            bbox = m.exactWorldBoundingBox(m.ls(a.nodeName()+"*"))
            bbox = IECore.Box3f(IECore.V3f(bbox[0], bbox[1], bbox[2]),IECore.V3f(bbox[3], bbox[4], bbox[5]))
            pxrOcc=pm.ls("PxrOcclusion")[0]
            pxrOcc.setAttr("numSamples", 1)
            maxdist = bbox.size().length()
            if args.maxdist:
                maxdist = float(args.maxdist)
            print '='*20, "maxDistance:", maxdist, '='*20
            pxrOcc.setAttr("maxDistance", maxdist)

        rg.setAttr('imageFormat', 32)
        rg.setAttr('animationRange', 0)
        rg.setAttr('startFrame', range.value.x)
        rg.setAttr('endFrame', range.value.y)
        rg.setAttr('byFrameStep', range.value.z)
        rg.setAttr('animation', 1)
        rg.setAttr('outFormatControl', 0)
        rg.setAttr('useMayaFileName', 1)
        dr=pm.ls('defaultResolution')[0]
        dr.setAttr('width', resolution[0])
        dr.setAttr('height', resolution[1])
        persp=pm.ls('perspShape')[0]
        persp.setAttr('renderable', 0)

        if not cameraAsset:
            print "ERROR???"

        # set camera to be renderable
        cameraAsset.selectNodes()
        for each in pm.ls(sl=1, dag=1, type='camera'):
            each.setAttr('renderable', 1)

        # hide objects specified in the comand line
        if args.hide:
            for each in args.hide:
                print '+'*200
                for node in m.ls("*", dag=1,l=1, type='mesh'):
                    if each in node:
                        print node
                        for pmnode in pm.ls(node):
                            for n in pmnode.listRelatives(p=1):
                                print n
                                n.setAttr('visibility', 0)
                                print n, 'visibility', n.getAttr('visibility')

        # save scene right after connect the animation!
        mayaSceneDependency = "%s/scenes/%s_last_playblast.mb" % (
            m.workspace(q=True, rootDirectory=True),
            os.path.splitext(os.path.basename(sys.argv[0]))[0]
        )
        m.file( rename=mayaSceneDependency )
        m.file( save=True )

        # publish!!
        asset = assetUtils.assetOP( 'render/maya/playblast', 'maya' )
        asset.loadOP()
        asset.setNew()

        # now we fill up the op parameters, like we do using the UI
        asset.op.parameters()['Asset']['type']['mayaScene'].setValue( IECore.StringData( mayaSceneDependency ) )
        asset.op.parameters()['Asset']['info']['name'].setValue( IECore.StringData( "playblast_%s" % args.asset[0].split('/')[-1].split('.')[-1] ) )
        # asset.op.parameters()['Asset']['info']['name'].setValue( IECore.StringData( "playblast" ) )

        # set time range
        asset.op.parameters()['Asset']['type']['FrameRange']['range'].setValue(range)


        # make sure parameters are OK, and increase version to publish!
        asset.setNew()

        # if we specify the version, use it now!
        if args.version:
            v = args.version.split('.')
            v = IECore.V3iData( IECore.V3i( int(v[0]), int(v[1]), int(v[2]) ) )
            asset.op.parameters()['Asset']['info']['version'].setValue( v )
            asset.printParameters()


        if not args.ndryrun:
            asset.op()

else:
    raise Exception("We need a at least one asset camera to render a playblast!!")
