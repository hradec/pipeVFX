#!/bin/env python2
# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================


import os, sys, socket, time, re
from pprint import pprint
from glob import glob

# import latest pipeVFX tag
latest = [ x for x in glob('/atomo/pipeline/tags/*.*.*') if len(os.path.basename(x).split('.'))==3 ]
latest.sort()
sys.path.insert(0, latest[-1]+'/python/')
print "importing pipe python module from:", latest[-1]
import pipe

CD=os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
print "running this script from:", CD

# preventing from running more than once, when called from cron!
processes = os.popen( "ps -AHfc | grep %s | grep -v grep | grep -v tail" % os.path.basename( __file__ ) ).readlines()
# print len(processes), processes
if len( processes ) > 2:
    exit(0)

def restartAFBrokenTasks( filter = "" ):
    # error list to check in log.
    errors = [
        '.*OSError.*',
        '^runuser..user.*does not exist$',
        "^ERROR..Can't get file.$",
        '^Traceback..most recent call last..$',
    ]
    timer = time.time()
    hostname = socket.gethostname()

    # collect errored frames and the name of the render node to see
    # if it need to be restarted
    render_nodes_err = {}
    # get all jobs
    jobs = {}
    for j in  [ x for x in pipe.farm.current.engine().list() if
                not 'hidden' in x
                or not x['hidden']
                # or ('state' in x and 'OFF' not in x['state'])
                # or ( '' in x['need_os']  and '668.avon' in x['name']] )
                ]:
        # filter offline jobs out!
        if 'OFF' in j['state']:
            continue
        # filter out jobs that don't match filter
        elif not re.match('^%s' % filter, j['name']):
            continue
        # only check jobs created in the last 7 days
        elif 'time_creation' in j and time.time()-j['time_creation'] > 60*60*24*7:
            continue
        jobs[ j['time_creation'] ] = j


    msgs = []
    # run over the first 100 jobs... max!
    jobs_index = jobs.keys()
    jobs_index.sort()
    jobs_index.reverse()
    for job_name in jobs_index:
        j = jobs[ job_name ]
        # print j['name']
        # loop over the job blocks
        for b in j['blocks']:
            print j['name']
            # retrieve the progress of the block
            json = {"get":{"type":"jobs","ids":[j['id']],"mode":"progress"}}
            progress = pipe.farm.current.engine()._runJSON(json)
            # task list id
            tid = progress['job_progress']['id']
            # the list of frame numbers
            framez = range(b['frame_first'], b['frame_last']+1, b['frames_inc'] )
            # and our frame/task counter!
            frames = 0
            # list of images to check
            task_images = {}

            # list of tasks to restart
            restart = []
            # now, run over the progress list
            for jobTasks in  progress['job_progress']['progress']:
                # and run over all tasks in the progress, to check for the suscessfull ones,
                # which rendered too fast and examine the logs for uncatched errors!
                for task in jobTasks:
                    # frameID is the actual frame number. Afanasy index tasks using
                    # a sequential number from 0 to <number of frames>.
                    # so to get the actual frame number, we use the index to pick it
                    # from the range() list we created above.
                    frameID = framez[frames]

                    # for all done frames, which were not skipped.
                    # DON, RDY, RER
                    if 'DON' in task['state'] and not 'SKP' in task['state']:
                        secs = task['tdn']-task['tst']
                        # if it took less than this amount of seconds...
                        #print frameID, secs
                        if secs < 200:
                            # we check it's log... only retrieve the ones
                            # that took less than minimun amount of seconds,
                            # so we not hammer the server!
                            log = pipe.farm.current.engine().jobsLogByID( j['id'], frames, b['block_num'] )[frames][1]

                            # grab the name of the gfarm machine, if running there.
                            gfarm = [ x for x in log['task']['data'][:2000].split('\n') if 'google' in x or 'render' in x ]
                            if gfarm:
                                # check if we're in a gfarm machine, and reset if it can't see the scene file!
                                if  [ x for x in log['task']['data'][:2000].split('\n') if 'Please check the scene name.' in x ]:
                                    cmd = 'googlefarm.sh reset '+gfarm
                                    print cmd
                                    os.system(cmd)
                                    restart += [frames]

                            # if the log is less than 20 lines, it's wrong and
                            # needs to be restarted
                            if len(log['task']['data'].split('\n')) < 20:
                                restart += [frames]

                            else:
                                # check the first 2000 lines
                                for line in log['task']['data'][:2000].split('\n'):
                                    # against our error list initiated above!
                                    for error in errors:
                                        if re.match(error, line):
                                            print j['name'], len( log['task']['data'] )
                                            print frameID, task, secs/60, ':', secs - int(secs/60)*60, secs,
                                            print line #log['task']['data'][:2000]
                                            if task['hst'] not in render_nodes_err:
                                                render_nodes_err[ task['hst'] ] = 0
                                            render_nodes_err[ task['hst'] ] += 1
                                            restart += [frames]


                        # verify if images exist for tasks from jobs finished with less than 48 horas!
                        if 'time_done' in j and time.time()-j['time_done'] < 60*60*24:
                            # check rendered files on disk (need to run on site)
                            # and gather their names
                            task_images[frames] = []

                            # first check if the files specified in the job block
                            # "files" entry exist!
                            for path in b['files']:
                                if os.path.exists(path):
                                    task_images[frames] += [path]

                            # if they don't exist, try to gather files with
                            # the frame number in the folder specified by the
                            # job block "files" entry
                            if not task_images[frames]:
                                for path in b['files']:
                                    task_images[frames] += glob( '%s/*.%04d.*' % ( os.path.dirname(path), frameID ) )

                            # if we couldn't find images where they should be, last
                            # resort is to try to pick then up from the afanasy
                            # task log!
                            if not task_images[frames]:
                                # retrieve log
                                log = pipe.farm.current.engine().jobsLogByID( j['id'], frames, b['block_num'] )[frames][1]
                                # if theres a log, gather image files from it
                                if len(log['task']['data']) > 2000:
                                    # print log['task']['data'].split('\n')
                                    samPath  = ''
                                    # we gather at least one @IMAGE!@ line to extract the final path for the rendered frames
                                    image = [ x.split('@IMAGE!@')[-1].strip().split('"')[1] for x in log['task']['data'].split('\n') if '@IMAGE!@' in x ]
                                    if image:
                                        samPath = os.path.dirname(image[0])
                                    else:
                                        print "\nERROR: Can't find any @IMAGE!@ from log!!!\n"

                                    # now we extract all the rendered frame filenames, since sometimes the log doesn't have @IMAGE!@ for all of then for some reason!
                                    for ok in [ x for x in log['task']['data'].split('\n') if x.strip() and 'OK -> ' in x ]:
                                        ok = ok.split('OK -> ')[-1].replace('"','').strip()
                                        print "-"+ok+'-'
                                        # construct the final filename using the dirname from @IMAGE!@ and the basename from "OK -> "
                                        image = '/'.join([ samPath, os.path.basename(ok) ])
                                        # if the file exists, add it to the list
                                        if os.path.exists(image):
                                            task_images[frames] += [image]

                    # for running jobs, try to check if it got stuck
                    if 'RUN' in task['state'] and not 'SKP' in task['state']:
                        # if percentage of render is 0 or not exist
                        if 'per' not in task or task['per'] == 0:
                            secs = task['tdn']-task['tst']
                            # and it has being more than 20 mins
                            if secs > 60*20:
                                # restart it
                                restart += [frames]

                                # TODO
                                # check the last line with a time stamp and
                                # compare the time with the task elapsed time
                                # afanasy reports.
                                # if the difference is more than 15 minutes,
                                # assume the render froze and restart it!
                                # json = {"get":{"type":"jobs","ids":[j['id']],"mode":"output","block_ids":[b['block_num']],"task_ids":[frames],"mon_id":1}}
                                # log = pipe.farm.current.engine()._runJSON( json )
                                # lines = [ x for x in log['task']['data'].split('\n') if re.match('^.*|.*pipeLog.*$', x) ]
                                # if lines:
                                #     print frameID, task, lines[-1]



                    # next task/frame
                    frames += 1

            # now we check if there's any frame with less images than the rest!
            # get the max number of images in a frame...
            max = 0
            for frame in task_images:
                if len(task_images[frame]) > max:
                    max = len(task_images[frame])

            # now check the ones who have less images than the max images
            for frame in task_images:
                # double check if the the images exist
                count = 0
                for image in task_images[frame]:
                    # check if file exists
                    if os.path.exists( image ):
                        # check if the file has something inside!!
                        if os.path.getsize( image ) > 10:
                            # file is good, has more than 10 bytes,
                            # so we have it!
                            count += 1
                            # TODO: this is a great oportunity to generate
                            # thumbnails for images to be used by webplayer
                            # instead of doing it after render, which
                            # takes a lot of time. Also, this script runs
                            # as root, so we dont need to keep using the
                            # dbus service to do it!

                # if there's less than the max images for a frame,
                # add this frame to the restart list
                if count < max:
                    restart += [frame]
                    msgs += ["less images than it should have - frame "+str(framez[frame])+
                             " has "+str(len(task_images[frame]))+" but should have "+str(max)]

            # so if we have frames to restart,
            # do it here... one json call for all of then!
            if restart:
                json = {"action":{
                    "user_name":"coord",
                    "host_name":"pc",
                    "type":"jobs",
                    "ids":[ j['id'] ],
                    "operation":{
                        "type":"restart",
                        "task_ids":restart
                    },
                    "block_ids":[ b['block_num'] ]
                }}
                print '='*160
                # pprint(j)
                print j['name'], j['state']
                print '\n'.join(msgs)
                pprint(render_nodes_err)
                print json
                # finally run the JSON above to restart all the frames
                # that need to be re-rendered!
                result = pipe.farm.current.engine()._runJSON(json)


def deleteAFOfflineRenderNodes( filter = "" ):
    rnodes = [ x for x in pipe.farm.current.engine()._renderNodes( state="OFF" ) if re.match('^%s' % filter, x['name']) ]
    # wait 10 seconds after gathering nodes to see if they come back
    time.sleep(10)
    for rn in rnodes:
        # check againg if node is still offline after waiting the time above!
        if 'OFF' in pipe.farm.current.engine()._renderNodes(rn['name'])[0]['state']:
            pipe.farm.current.engine()._renderNodeDelete( rn['name'] )


    rnodes = [ x for x in pipe.farm.current.engine()._renderNodes() if re.match('^%s' % filter, x['name']) ]
    for rn in rnodes:
        pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'priority', 250 )

    # cleanup vmware testing just in case
    pipe.farm.current.engine()._renderNodeDelete( 'vmware-testing.local' )

    # running machines
    running_machines = len([ x for x in pipe.farm.current.engine()._renderNodes() if re.match('^%s' % filter, x['name']) ] )
    print filter, '=', running_machines
    return running_machines



def pauseAFStorageServes( title = "", filter = 'google.*setup' ):
    nodes = pipe.farm.current.engine()._renderNodes()
    for rn in [ x for x in nodes if re.match('^%s' % filter, x['name']) ] :
        # pipe.farm.current.engine()._renderEjectAll( rn['name'] )
        hidden = False
        # if 'state' in rn and 'OFF' in rn['state']:
        #     hidden = True

        pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'paused', True )
        pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'capacity', 1 )
        pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'max_tasks', 1 )
        pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'priority', 255 )
        # pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'annotation', title )
        pipe.farm.current.engine()._renderNodeSetParameter( rn['name'], 'hidden', hidden )


# start or stop gfarm 2.0 machines, depending of if there's
# jobs to render in afanasy
def startStopGFarm(forceStop=False):
    regions = [
        'us-central1-a',
        'us-east1-b',
        'us-east4-b',
        'us-west1-b',
    ]

    # find googlefarm.sh script
    path = os.path.dirname( os.path.dirname( os.path.abspath( __file__ ) ) )
    googlefarm_sh = "%s/%s" % (path, "proxmox-vm/googlefarm.sh")
    if not os.path.exists( googlefarm_sh ):
        if os.path.exists( "/bin/googlefarm.sh" ):
            googlefarm_sh = "/bin/googlefarm.sh"
        else:
            googlefarm_sh = "%s/scripts/googlefarm.sh" % pipe.roots().tools()

    print "using googlefarm.sh located at:", googlefarm_sh
    region = regions[0]

    instances = [ x.split() for x in os.popen( '%s list | grep RUNNING' % googlefarm_sh ).readlines() ]
    ig = [ x.split() for x in os.popen( '%s list_ig' % googlefarm_sh ).readlines() if 'ig-' in str(x) ]

    # we have frames to render on google, so lets do it
    if forceStop:
        frames_to_render = 0
        max_nodes = 0
    else:
        frames_to_render = pipe.farm.current.engine().runningJobsFramesToFinish()
        os.system("echo %s >> /dev/shm/frames_to_render" % str(frames_to_render+1))

        # grab the number of frames we had to render 10 minutes ago, so
        # we give 10 minutes to nodes upload data to buffer bucket
        # before they go down.
        max_nodes = int(''.join(os.popen("tail -n 10 /dev/shm/frames_to_render | head -n 1").readlines()))

    if frames_to_render and not forceStop:
        os.system("echo 0 > /dev/shm/stopGFarm")
        storage = [ x for x in instances if 'storage' in str(x) and region in str(x) ]
        # so no server running, start one!
        if not storage:
            os.system( 'timeout 30 %s create_storage -z="%s"' % (googlefarm_sh, region) )

        # start/update instance group with the number of frames to render!
        # limit it to a max of nodes due here
        if max_nodes > 20:
            max_nodes = 20

        # get the current number of nodes we have
        nodes = 0
        for n in ig:
            nodes += int(n[-1])
        print "frames_to_render:", frames_to_render
        print "max_nodes:", max_nodes
        print "current number of nodes:", nodes
        if nodes != max_nodes:
            os.system( 'timeout 30 %s create_instance_group 32 %s' % (googlefarm_sh, max_nodes) )

        # keep the frames_to_render log in a sane size
        os.system( "tail -n 1000  /dev/shm/frames_to_render > /tmp/__frames_to_render && mv -f /tmp/__frames_to_render /dev/shm/frames_to_render")


    # no more frames to render, so delete everything at google
    # frames will come from the bucket, so we dont need anything there!
    else:
        os.system("echo 1 >> /dev/shm/stopGFarm")

        if forceStop or len(open('/dev/shm/stopGFarm').readlines()) > 45:
            print "Stooping storage servers and instance groups..."
            # stop instance groups and storage servers
            instances = [ x.split() for x in os.popen( '%s list | grep RUNNING' % googlefarm_sh ).readlines() ]
            for instance in [ x for x in instances if 'storage' in str(x) ]:
                os.system( 'echo Y | timeout 30 %s delete %s' % (googlefarm_sh, instance[0]) )

            for instance in [ x for x in ig if 'ig-' in str(x) ]:
                os.system( 'echo Y | timeout 30 %s delete_instance_group %s' % (googlefarm_sh, instance[0]) )

            # for instance in [ x for x in instances if 'rnode' in str(x) ]:
            #     os.system( 'echo Y | %s delete %s' % (googlefarm_sh, instance[0]) )
            print "Done!"



if __name__ == "__main__":
    # start gfarm if we have something to render
    forceStop = '--forceStop' in sys.argv
    startStopGFarm(forceStop)

    if not forceStop:
        # delete offline render nodes
        running_machines = deleteAFOfflineRenderNodes( 'google.*cores' )
        running_machines = deleteAFOfflineRenderNodes( 'render.*' )

        # make sure storage server is paused
        pauseAFStorageServes( "running %s google machines..." % running_machines )

        # check the first 100 jobs in afanasy for
        # DON tasks which actually failed and restart it!
        # for now, just check maya renders
        restartAFBrokenTasks('SAM.*MAYA.*')




























#
