#!/usr/bin/env python2

import sys, os, argparse
from glob import glob
import pipe, traceback
# print sys.argv

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
parser.add_argument('-ip', dest='playblast_assets', action='append', help='path completo do asset (ex: model/alembic/sala) para importar somente durante o render do playblast. (voce pode usar -i varias vezes para importar mais de um asset)')
parser.add_argument('-o', dest='animation_alembic', help='o nome do asset animation/alembic para publicar os assets rig/maya animados q foram importados com o parametro -i.')
parser.add_argument('--farm', dest='farm', action='store_true', help='faz a importacao e publicacao no farm.')
parser.add_argument('-c', dest='camera', action='store_true', default=False, help='publica todas as cameras com nome "camera*" que tiverem na cena de animacao setada pelo parametro -m')
parser.add_argument('-n', dest='ndryrun', action='store_true', default=False, help='nao faz nada! so simula o resultado sem fazer nada.')
parser.add_argument('--hide', dest='hide', action='append', help='nome de um mesh q precisa ser hiden no render do playblas.')
parser.add_argument('--start', dest='start', help='start frame override.')
parser.add_argument('--end', dest='end', help='end frame override.')
parser.add_argument('--maxdist', dest='maxdist', help='max distance for occlusion. Se nao for especificado, o script tenta calcular com base no primeiro asset.')


args = parser.parse_args()


if 'FARM' not in os.environ and args.farm:
    try:
        import assetUtils
    except:
        # restarts python using the new os.environ.
        pipe.apps.gaffer().expand()
        pipe._force_os_environ()



print args.farm

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

    playblast_assets = ''
    if args.playblast_assets:
        playblast_assets = '-i '+' -i '.join(args.playblast_assets)

    j = args.job
    s = args.shot
    scenes = glob(args.maya_scene)
    if not scenes:
        raise Exception("[PARSE ERROR] - no file to load!!")
    for args.maya_scene in scenes:

        maya_scene = os.path.abspath(args.maya_scene)

        if not j:
            if 'PIPE_JOB' in os.environ:
                args.job = os.environ['PIPE_JOB']

        if not s:
            args.shot = os.path.basename(maya_scene).lower().split("shot_")[1].split('_')[0]

        if args.farm:
            pipe.admin.job(args.job).shot(args.shot).apply()
            asset = assetUtils.assetOP( '/'.join(anim), 'maya' )
            asset.loadOP()
            asset.setNew()
            properName = asset.parameters()['Asset']['info']['name'].getValue()
            properVersion = asset.parameters()['Asset']['info']['version'].getValue().value
            asset.printParameters()
            assetVersion = '%d.%d.%d' % (properVersion.x, properVersion.y, properVersion.z)

            # cmd = " ".join([ x for x in sys.argv if '--farm' not in x ])
            genericCmd = ' '+' '.join(['--start %s' % str(args.start) if args.start else '',
                            '--end %s' % str(args.end) if args.end else '',
                            '--hide ' if args.hide else '',
                            ' --hide '.join(args.hide) if args.hide else '',
                            '--maxdist %s' % str(args.maxdist) if args.maxdist else '',
            ])
            precmd  = 'export FARM=1 && source %s/scripts/go %s shot %s && ' % (pipe.roots.tools(), args.job, args.shot)
            cmd = precmd + ' '.join([
                sys.argv[0],
                '-m', maya_scene,
                '-j', args.job, '-s', args.shot,
                '-i', ' -i '.join(args.rig_maya),
                '-o', args.animation_alembic,
                '-c' if args.camera else '',
                ])+genericCmd
            cmdplayblast = 'samMayaPublishPlayblast.py -j %s -s %s -i %s -i camera/alembic/camera %s %s' % (args.job, args.shot, '/'.join(anim), playblast_assets, genericCmd)
            postCmd = {
                'name': "playblast publish",
                # 'cmd': "/usr/sbin/runuser -l rhradec --session-command '" + precmd + cmdplayblast + "-v %s " % assetVersion + " > /dev/null && echo DONE || exit -1 '"
                'cmd': "/usr/sbin/runuser -l rhradec --session-command '" + precmd + cmdplayblast + " > /dev/null && echo DONE || exit -1 '"
            }
            print cmd
            print postCmd
            title = "publishing asset %s/%s/%s/%s" % ( anim[0], anim[1], properName, assetVersion )
            description =  "using animation from maya scene %s" %  maya_scene
            print 'title:', title
            print 'description:', description
            if not args.ndryrun:
                pipe.farm.cmds(title, [cmd], [maya_scene], capacity=1000, description=description, postCmd=postCmd).submit()

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
                _start = %s
                _end = %s
            '''.split('\n')]) % (args.job, args.shot, str(rigs), str(anim), str(maya_scene), str(args.camera), str(sys.argv[0]), str(args.start), str(args.end) ))
            f.write( '\n'.join([ x[4*4:] for x in '''
                import os, sys, traceback, math
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

                # get time range for the given assets only
                sceneRange = genericAsset.maya.frameRange()
                range = [999999999, -999999999 ,sceneRange[2]]
                for each in rigs:
                    asset = assetUtils.assetOP( each, 'maya' )
                    asset.getCurrent()
                    r = asset.frameRange()
                    range = [
                        min(range[0], r[0]),
                        max(range[1], r[1]),
                        range[2]
                    ]
                range = IECore.V3fData( IECore.V3f( range[0], range[1], range[2] ) )
                if range.value.x < 0:
                    range = IECore.V3fData( IECore.V3f( 0, range.value.y, range.value.z ) )
                    genericAsset.maya.setOneNucleus(0)
                if _start:
                    range = IECore.V3fData( IECore.V3f( _start, range.value.y, range.value.z ) )
                    genericAsset.maya.setOneNucleus(_start)
                if _end:
                    range = IECore.V3fData( IECore.V3f( range.value.x, _end, range.value.z ) )
                print '====> assets time range:', range


                # save scene right after connect the animation!
                m.file( rename=mayaSceneDependency )
                m.file( save=True )

                # create the publish op using assetUtils.assetOP class
                print "="*120
                print "start:", range.value.x
                print "end:", range.value.y
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
                asset.op.parameters()['Asset']['type']['FrameRange']['range'].setValue(range)

                # make sure parameters are OK, and increase version to publish!
                asset.setNew()

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
                            asset.setNew()

                            print "="*120
                            for each in  asset.op.parameters()['Asset']['type'].keys():
                                print 'Asset type',each, asset.op.parameters()['Asset']['type'][each].getValue()
                            for each in  asset.op.parameters()['Asset']['info'].keys():
                                print 'Asset info', each, asset.op.parameters()['Asset']['info'][each].getValue()
                            print "="*120

                            asset.op()



            '''.split('\n')]) )
            f.close()
            cmd_extra = ""
            # cmd_extra = '&& [ "$FARM" != "1" ] '+cmdplayblast
            cmd = "xvfb-run --auto-servernum bash -c 'source /atomo/pipeline/tools/scripts/go %s shot %s && run mayapy %s >/tmp/samMayaPublish_%s_last.log 2>&1 ; cat /tmp/samMayaPublish_%s_last.log ; rm %s %s'" % (args.job, args.shot, tmpfile, os.environ['USER'], os.environ['USER'], tmpfile, cmd_extra)
            print cmd
            if not args.ndryrun:
                os.system( cmd )
