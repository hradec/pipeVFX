#!/usr/bin/env python2

import sys, os, argparse
from glob import glob


if len(sys.argv)<2:
    sys.argv += ['-h']

# parser = argparse.ArgumentParser(description='Apply character animation from maya scenes to rig/maya assets, and publish to animation/alembic.')
# parser.add_argument('-m', dest='maya_scene', help='the maya scene file to read the animation from')
# parser.add_argument('-j', dest='job', help='set the job to use during publish')
# parser.add_argument('-s', dest='shot', help='set the shot to use during publish')
# parser.add_argument('-i', dest='rig_maya', action='append', help='the rig/maya asset to import and apply the animation from the maya scene specified in -m parameter. (you can use -i multiple times)')
# parser.add_argument('-o', dest='animation_alembic', help='the animation/alembic asset name to publish the animated rig/maya assets imported using -i.')
# parser.add_argument('--farm', dest='farm', action='store_true', help='execute the publishing on the farm')

parser = argparse.ArgumentParser(description='Aplica animacoes de character de uma cena normmal de maya nas ultimas versoes dos rigging/maya, e publica como animation/alembic.')
parser.add_argument('-m', dest='maya_scene', help='a cena de maya com animacao para aplicar')
parser.add_argument('-j', dest='job', help='seta o job para usar durante a publicacao')
parser.add_argument('-s', dest='shot', help='seta o shot para usar durante a publicao')
parser.add_argument('-i', dest='rig_maya', action='append', help='o nome do asset rig/maya para importar e aplicar a animacao da cena de maya setada pelo parametro -m. (voce pode usar -i varias vezes para importar mais de um rig)')
parser.add_argument('-o', dest='animation_alembic', help='o nome do asset animation/alembic para publicar os assets rig/maya animados q foram importados com o parametro -i.')
parser.add_argument('--farm', dest='farm', action='store_true', help='faz a importacao e publicacao no farm.')
parser.add_argument('-c', dest='camera', action='store_true', default=False, help='publica todas as cameras com nome "camera*" que tiverem na cena de animacao setada pelo parametro -m')
parser.add_argument('-n', dest='ndryrun', action='store_true', default=False, help='nao faz nada! so simula o resultado sem fazer nada.')


args = parser.parse_args()



if args.maya_scene:
    rigs = []
    for each in args.rig_maya:
        if '/' not in each:
            rigs += ['rigging/maya/%s' % each]
        else:
            rigs += [each]

    anim = args.animation_alembic
    if '/' not in args.animation_alembic:
        anim = 'animation/alembic/%s' % args.animation_alembic
    anim = anim.split('/')

    j = args.job
    s = args.shot
    scenes = glob(args.maya_scene)
    print scenes
    for args.maya_scene in scenes:

        maya_scene = os.path.abspath(args.maya_scene)

        if not j:
            if 'PIPE_JOB' in os.environ:
                args.job = os.environ['PIPE_JOB']

        if not s:
            args.shot = os.path.basename(maya_scene).lower().split("shot_")[1].split('_')[0]

        if args.farm:
            import pipe
            cmd = " ".join([ x for x in sys.argv if '--farm' not in x ])
            cmd = ' '.join([
                sys.argv[0],
                '-m', maya_scene,
                '-j', args.job, '-s', args.shot,
                '-i', ' -i '.join(args.rig_maya),
                '-o', args.animation_alembic,
                '-c' if args.camera else ''
            ])
            print cmd
            title = "SAM %s_%s %s: converting %s to %s" % ( args.job, args.shot, os.path.basename(sys.argv[0]), os.path.basename(maya_scene), '/'.join(anim) )
            print title
            if not args.ndryrun:
                pipe.farm.cmds(title, [cmd], [maya_scene], capacity=1000).submit()

        else:
            import tempfile
            tmpfile = "%s.py" % tempfile.mktemp()

            f = open(tmpfile, 'w')
            f.write( '\n'.join([ x[4*4:] for x in '''
                job = "%s"
                shot = "%s"
                rigs = %s
                anim = %s
                maya_scene = "%s"
                camera = %s
                argv0 = "%s"
            '''.split('\n')]) % (args.job, args.shot, str(rigs), str(anim), str(maya_scene), str(args.camera), str(sys.argv[0])) )
            f.write( '\n'.join([ x[4*4:] for x in '''
                import os, sys, traceback
                import GafferUI, IECore
                GafferUI.EventLoop.mainEventLoop().start()
                import pymel.core as pm
                import maya.cmds as m
                from maya.mel import eval as meval
                m.file(new=1, f=1)

                import assetListWidget, assetUtils, genericAsset

                print genericAsset.m

                # maya scene used to publish new asset version
                mayaSceneDependency = "%s/scenes/%s_%s.mb" % (
                    m.workspace(q=True, rootDirectory=True),
                    os.path.splitext(os.path.basename(argv0))[0],
                    os.path.splitext(os.path.basename(maya_scene))[0]
                )

                # use assetListWidget custom to checkout the rigs and apply the animation
                # TODO: implement the custom functionality in the asset itself, instead of assetListWidget, so we don't need X11 to run.
                alw = assetListWidget.assetListWidget(hostApp='maya')
                print "="*120
                print "applying animation to %s..." % str(rigs)
                print "="*120
                # assetListWidget.custom.checkoutRigAndApplyAnimation(alw, paths=rigs, maya_scene=maya_scene)
                assetListWidget.custom.manualAssetAnimImport( rigs, maya_scene )

                # manualAssetAnimImport sets timeslider to the imported animation range
                # so we can pull the last frame from the timeslider directly!
                genericAsset.maya.setTimeSliderRangeToAvailableAnim()
                startFrame = float(m.playbackOptions( q=1, minTime=1 ))
                endFrame = float(m.playbackOptions( q=1, maxTime=1 ))

                # save scene right after connect the animation!
                m.file( rename=mayaSceneDependency )
                m.file( save=True )

                # create the publish op using assetUtils.assetOP class
                print "="*120
                print "start:", startFrame
                print "end:", endFrame
                print "publishing %s..." % '/'.join(anim)
                print "="*120

                # create the assetOP class wrapper for the anim asset
                asset = assetUtils.assetOP( '/'.join(anim), 'maya' )
                # and loads up the actual cortex op
                asset.loadOP()

                # get all rigs imported to publish animation!
                meshes2publish = ','.join(m.ls("|SAM_rigging_*",l=1))

                # now we fill up the op parameters, like we do using the UI
                asset.op.parameters()['Asset']['type']['alembicMesh'].setValue( IECore.StringData( meshes2publish ) )
                asset.op.parameters()['Asset']['type']['alembicDependency'].setValue( IECore.StringData( mayaSceneDependency ) )
                asset.op.parameters()['Asset']['info']['name'].setValue( IECore.StringData( "%s.%s" % (shot, anim[-1]) ) )

                # set time range
                range = IECore.V3fData( IECore.V3f( startFrame, endFrame, 1 ) )
                asset.op.parameters()['Asset']['type']['FrameRange']['range'].setValue(range)

                # make sure parameters are OK, and increase version to publish!
                asset.op.assetParameter.parameterChanged(asset.op.parameters())

                print "="*120
                for each in  asset.op.parameters()['Asset']['type'].keys():
                    print 'Asset type',each, asset.op.parameters()['Asset']['type'][each].getValue()
                for each in  asset.op.parameters()['Asset']['info'].keys():
                    print 'Asset info', each, asset.op.parameters()['Asset']['info'][each].getValue()
                print "="*120

                asset.op()

                if camera:
                    for camera_asset in [ x for x in m.ls('|__SAM_TMP__*', dag=1, l=1, type='camera') ]:
                        node = m.listRelatives(camera_asset, p=1)[0]
                        name = "%s.%s" % (shot, node)
                        if 'camera' in node.lower():
                            g = m.createNode("transform", n="group_%s" % str(node))
                            m.parent(camera_asset,g)

                            # create the assetOP class wrapper for the camera asset
                            asset = assetUtils.assetOP( 'camera/alembic/%s' % name, 'maya' )
                            # and loads up the actual cortex op
                            asset.loadOP()

                            # now we fill up the op parameters, like we do using the UI
                            asset.op.parameters()['Asset']['type']['cameraGroup'].setValue( IECore.StringData( g ) )
                            asset.op.parameters()['Asset']['type']['cameraDependency'].setValue( IECore.StringData( mayaSceneDependency ) )
                            asset.op.parameters()['Asset']['info']['name'].setValue( IECore.StringData( name ) )

                            # set time range
                            asset.op.parameters()['Asset']['type']['FrameRange']['range'].setValue(range)

                            # make sure parameters are OK, and increase version to publish!
                            asset.op.assetParameter.parameterChanged(asset.op.parameters())

                            print "="*120
                            for each in  asset.op.parameters()['Asset']['type'].keys():
                                print 'Asset type',each, asset.op.parameters()['Asset']['type'][each].getValue()
                            for each in  asset.op.parameters()['Asset']['info'].keys():
                                print 'Asset info', each, asset.op.parameters()['Asset']['info'][each].getValue()
                            print "="*120

                            asset.op()



            '''.split('\n')]) )
            f.close()
            cmd = "xvfb-run bash -c 'source /atomo/pipeline/tools/scripts/go %s shot %s && mayapy %s && rm %s'" % (args.job, args.shot, tmpfile, tmpfile)
            print cmd
            if not args.ndryrun:
                os.system( cmd )
