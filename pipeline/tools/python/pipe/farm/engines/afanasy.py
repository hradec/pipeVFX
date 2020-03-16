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


import pipe, os, sys
from pipe.farm.baseClass import baseFarmJobClass

class job(baseFarmJobClass):

    def _init(self):
        ''' import afanasy python module '''
        osback = os.environ.copy()
        pipe.apps.cgru().expand()
        import af
        import afnetwork
        self.af = af
        self.afnetwork = afnetwork
        os.environ.update(osback)

    def _runJSON(self, json):
        ret = self.afnetwork.sendServer( self.af.json.dumps(json), False )
        if ret[0]:
            return ret[1]
        return []

    @staticmethod
    def farmCmd(cmd):
        return "/usr/sbin/runuser -l %s --session-command  'export PIPE_FARM_USER=%s ; unset LD_LIBRARY_PATH ;  unset LD_PRELOAD;  echo $HOSTNAME ; " % (pipe.admin.username(),pipe.admin.username())  + cmd.replace("'","\\'") + " || echo '[PARSER ERROR]' ; echo $? ' ; echo $?"

    def _list(self, filter='', mode="full"):
        json = {"get":{"type":"jobs", "mode":mode}}
        return [ x for x in self._runJSON(json)['jobs'] if filter in x['name'] ]

    def list(self, filter=''):
        # return [x for x in self.af.Cmd().getJobList(False) if filter.lower() in x['name'].lower() ]
        return self._list(filter)

    def listTasks(self, filter=''):
        ret=[]
        for each in self._list(filter):
            ret += [{
                'name'   : each['name'],
                'job'    : each,
                'tasks'  : self._runJSON({"get":{
                    "type":"jobs",
                    "ids":[each['id']],
                    "mode":"progress",
                }}),
            }]
        return ret

    def runningJobs(self, filter=''):
        ret=[ x for x in self.list(filter) if x.has_key('state') and ('OFF' not in x['state'] and ('RDY' in x['state'] or 'RUN' in x['state'])) ]
        for r in ret:
            for b in r['blocks']:
                if not b.has_key('p_tasks_done'):
                    b['p_tasks_done'] = 0
                if not b.has_key('running_tasks_counter'):
                    b['running_tasks_counter'] = 0
        return ret

    def runningJobsFramesToFinish(self, filter='', need_os='google'):
        ret = 0
        for x in self.runningJobs(filter):
            if x.has_key('need_os') and need_os in x['need_os']:
                for b in x['blocks']:
                    ret +=  int(b['frame_last']) \
                            - int(b['frame_first']) \
                            - int(b['p_tasks_done']) \
                            #- int(b['running_tasks_counter'])
        if ret<0:
            ret = 0
        return ret

    def _totalTasksToRun(self, filter=''):
        jobs = [ x for x in self.list(filter) if x.has_key('state') and ('OFF' not in x['state'] and ('RDY' in x['state'] or 'RUN' in x['state'])) ]
        tasks = 0
        for j in jobs:
            for b in j['blocks']:
                if 'p_tasks_done' not in b:
                    tasks += b['tasks_num']
                else:
                    tasks += b['tasks_num'] - b['p_tasks_done']
        return tasks

    def _renderNodes(self, name='', state=''):
        ''' returns a dictionary with all information for render nodes '''
        json = {"get":{"type":"renders"}}
        ret =   self._runJSON(json)
        if not ret:
            return []

        fret = []
        for r in ret['renders']:
            if name in r['name'] and state in r['state']:
                fret += [r]
        return fret


    def _renderNodesResources(self, name='', state=''):
        ''' returns a dictionary with all information for render nodes '''
        resources = {}
        for r in  self._renderNodes(name, state):
            json = {"get":{"type":"renders", "ids":[r['id']], "mode":"resources"}}
            ret =   self._runJSON(json)
            resources[r['name']] = {
                'data' : r,
                'resources' : ret,
                'json' : json
            }
        return resources


    def _renderNodeSet(self, name='', param='', value=None):
        ''' set a parameter into a render node '''
        ret = {}
        for rn in self._renderNodes(name):
            json = {"action":{
                "user_name":"coord",
                "host_name":"pc",
                "type":"renders",
                "ids":[rn['id']],
                "params":{param:str(value)
            }}}
            # print( json )
            ret[rn['name']] = self._runJSON(json)
        return ret
#{"action":{"user_name":"coord","host_name":"pc","type":"renders","ids":[65],"params":{"annotation":"machines: 0 cores: 96"}}}

    def _renderNodeOperation(self, name='', operation='delete'):
        ''' execute operations on render nodes '''
        '''ex: {"action":{"user_name":"coord","host_name":"pc","type":"renders","ids":[10],"operation":{"type":"eject_tasks"}}} '''
        ret = {}
        for rn in self._renderNodes(name):
            json = {"action":{
                "user_name":"coord",
                "host_name":"pc",
                "type":"renders",
                "ids":[rn['id']],
                "operation":{ "type": operation }
            }}
            # print( json )
            ret[rn['name']] = self._runJSON(json)
        return ret


    def _renderNodeDelete(self, name=''):
        ''' delete a render node '''
        return self._renderNodeOperation(name, 'delete')

    def _renderEjectAll(self, name=''):
        ''' eject all tasks in a render node '''
        return self._renderNodeOperation(name, 'eject_tasks')



    def _renderNodesIdleTime(self, name='', bash=False):
        ''' return the render nodes that are idle, with the number of MINUTES they are idle for!'''
        import time
        tmp = self._renderNodes(name,state='ON')
        ret={}
        for r in tmp:

            if not r.has_key('tasks'): # no tasks running
                ret[ r['name'] ] = {
                    'idle_minutes' : ( time.time() - r['task_start_finish_time'] ) / 60.0,
                }
            # else:
            #     ret[ r['name'] ] = {
            #         'idle_minutes' : ( time.time() - r['task_start_finish_time'] ) / 60.0,
            #     }

        if bash:
            string = ''
            for r in ret:
                string += ' '.join([str(r), str(int(ret[r]['idle_minutes'])), "\n"])
            return string.strip()

        return ret

    def _setParameter(self, par='', value='', jobs=''):
        if not jobs:
            jobs = self.runningJobs(jobs)
        for j in jobs:
            # print( j['name'] )
            addValue = '+' in value
            remValue = '-' in value
            value = value.replace('+','').replace('-','')
            v = value
            if j.has_key(par):
                v = j[par]
                if addValue and value not in v:
                    v += '|'+value
                if remValue and value in v:
                    v = v.replace(value,'').replace('||','|').strip('|')

            # print( par, v, None if not j.has_key(par) else j[par] )
            if not j.has_key(par) or v != j[par]:
                json = {"action":{
                    "user_name":"coord",
                    "host_name":"pc",
                    "type":"jobs",
                    "ids":[j['id']],
                    "params":{
                        par : v
                    }
                }}
                self._runJSON(json)

    def _renderNodeSetParameter(self, name, par='', value=''):
        tmp = self._renderNodes(name)
        for j in tmp:
            # print( j['name'] )
            v = value

            # print par, v, None if not j.has_key(par) else j[par]
            if not j.has_key(par) or v != j[par]:
                json = {"action":{
                    "user_name":"coord",
                    "host_name":"pc",
                    "type":"renders",
                    "ids":[j['id']],
                    "params":{
                        par : v
                    }
                }}
                # print( json )
                self._runJSON(json)
#{"action":{"user_name":"coord","host_name":"pc","type":"renders","ids":[21],"params":{"capacity":1200}}}
#{"action":{"user_name":"coord","host_name":"pc","type":"renders","ids":[8],"params":{"NIMBY":true}}}

    def _renderNodeNIMBY(self, name, bool=''):
        self._renderNodeSetParameter(name, 'NIMBY', bool)

    def _renderNodeDelete(self, name):
        #{"action":{"user_name":"coord","host_name":"pc","type":"renders","ids":[29],"operation":{"type":"delete"}}}
        for tmp in self._renderNodes(name):
            if 'storage' not in tmp['name'] and 'setup' not in tmp['name']:
                # print(tmp['name'])
                json = {"action":{
                    "user_name":"coord",
                    "host_name":"pc",
                    "type":"renders",
                    "ids":[tmp['id']],
                    "operation":{"type":"delete"}
                }}
                print( json )
                print( self._runJSON(json) )


    def jobsByID(self, id):
        return [ x for x in self.list() if x['id']==id ]

    def setDescription( self, jobID, text ):
        if type(jobID) is int:
            j = self.jobsByID(jobID)
        else:
            j = self.list(jobID)

        assert( j )
        assert( len(j) is 1 )

        jobID = j[0]['id']

        json =  {
            "action":{
                "user_name":"coord",
                "host_name":"pc",
                "type":"jobs",
                "ids":[jobID],
                "params":{
                    "annotation": text
                }
            }
        }
        return self.afnetwork.sendServer( self.af.json.dumps(json), False )

    def jobsLogByID(self, id, task_id, block=0):
        if type(task_id) != type([]):
            task_id=[int(task_id)]

        logs={}
        for _task_id in task_id:
            for each in [ x for x in self.list() if x['id']==id ]:
                json = {"get":{"type":"jobs","ids":[each['id']],"mode":"output","block_ids":[block],"task_ids":[_task_id],"mon_id":1}}
                logs[_task_id] = self.afnetwork.sendServer( self.af.json.dumps(json), False )
        return logs

    def skipTask( self, jobID, blockID, frame ):
        # json to skip a task
        return self._taskAction(  jobID, frame, taskID, 'skip' )

    def restartTask( self, jobID, blockID, frame ):
        # json to skip a task
        return self._taskAction(  jobID, blockID, frame, 'restart' )

    def _taskAction( self, jobID, blockID, taskID, action='skip' ):
        # json to skip a task
        if type(taskID) is not list:
            taskID = [taskID]

        if type(jobID) is int:
            j = self.jobsByID(jobID)
        else:
            j = self.list(jobID)

        assert( j )
        assert( len(j) is 1 )


        firstFrame = j[0]['blocks'][blockID]['frame_first']
        taskID = [ x-firstFrame for x in taskID ]
        jobID = j[0]['id']

        json =  {
            "action": {
                "user_name":"coord",
                "host_name":"pc",
                "type":"jobs",
                "ids":[jobID],
                "block_ids":[blockID],
                "operation":{
                    "type":action,
                    "task_ids":taskID
                },
            }
        }

        return self.afnetwork.sendServer( self.af.json.dumps(json), False )


    @staticmethod
    def updateLicenseUsage(app, used, total):
        updateresources = pipe.apps.qube().path('qube-core/local/pfx/qube/sbin/qbupdateresource')
        os.system("%s --name license.%s --used %s --total %s" % (updateresources, app, used, total) )

    @staticmethod
    def frameNumber():
        return '@#@'

    def submit(self, depend=None):
        self.reservations = ['host.processors=1+']

        # add license registration
        for each in self.licenses:
            self.reservations.append('license.%s' % each)

        className = str(self).split()[0].split('.')[-1]
        if 'houdini' in className:
            className = 'hbatch'

        # import afanasy python module
        osback = os.environ.copy()
        pipe.apps.cgru().expand()
        import af
        os.environ.update(osback)

        if type(self.cmd) is type([]):

            job = af.Job( "Command List: %s" % self.name )
            job.setNeedOS('linux')
            # create an afanasy job block
            block1 = af.Block("main", className )
            block1.setParser('generic')
            #block1.setCommand("none")
            if hasattr( self, "files" ):
                #block1.setFiles([os.path.dirname(self.files[0])+"/*"])
                block1.setFiles(self.files)

            block1.setTasksMaxRunTime(self.maxRunTime)

            blocks = [block1]
            n = 1
            for cmd in self.cmd:
                task = af.Task("%s" % (str(n))) #, cmd.split('run')[-1].replace('/','_')))
                realcmd = "/usr/sbin/runuser -l %s --session-command  'export PIPE_FARM_USER=%s ; unset NOPIPE ; unset USE_SYSTEM_LIBRARY ; unset LD_LIBRARY_PATH ;  unset LD_PRELOAD;  echo $HOSTNAME ; " % (pipe.admin.username(),pipe.admin.username())  + cmd.replace("'","\\'") + "  || echo [PARSER ERROR] ; echo $? ' ; echo $?"
                task.setCommand(realcmd)
                if hasattr( self, "files" ):
                    task.setFiles([self.files[n-1]])
                block1.tasks.append(task)
                n += 1


            if hasattr( self, "postCmd" ):
                block2 = af.Block( self.postCmd['name'] )
                block2.setDependMask( "main" )
                #block2.setTasksDependMask( "main" )
                task = af.Task( self.postCmd['cmd'] )
                task.setCommand( self.postCmd['cmd'] )
                block2.tasks.append(task)

                blocks.append(block2)
                #mask = map( lambda n: "%s" % str(n+1), range(len( self.cmd )) )
                #block2.setDependMask( self.postCmd['name'] )
                #block2.setDependSubTask()


            for b in blocks:
                job.blocks.append(b)

            print( '='*80 )
            print( job.output(1) )
            print( '='*80 )

            return job.send()

        else:

            # we use su to run the tasks as the user who submitted it!
            cmd = self.farmCmd(self.cmd)
            #cmd = "/usr/sbin/runuser -l %s --session-command  'export PIPE_FARM_USER=%s ; " % ('pkg',pipe.admin.username())  + self.cmd.replace("'","\\'") + "'"
            _job = af.Job( "SAM %s" % self.name )
            _job.setNeedOS('linux')

            # make sure r in a range list!
            r = self.range()
            if type(self._range)==type(""):
                rs = self._range.split('-')
                r=int(rs[0])
                if len(rs)>1:
                    r = range(int(rs[0]),int(rs[1]))

            # create an afanasy job block
            block1 = af.Block("main", className )
            block1.setParser('generic')
            block1.setCommand(cmd)
            if hasattr( self, "files" ):
                block1.setFiles(self.files)

            r.sort()
            block1.setNumeric(r[0], r[-1], r[1]-r[0])
            block1.setSequential(0)
            block1.setTasksMaxRunTime(self.maxRunTime)
            _job.blocks.append(block1)

            if hasattr( self, "postCmd" ):
                block2 = af.Block( self.postCmd['name'] )
                block2.setDependMask( "main" )
                block2.setDependSubTask()
                task   =  af.Task( self.postCmd['cmd'] )
                task.setCommand( self.postCmd['cmd'] )
                block2.tasks.append(task)
                _job.blocks.append(block2)

            if hasattr( self, "taskPostCmd" ):
                block3 = af.Block( self.taskPostCmd['name'] )
                block3.setTasksDependMask( "main" )
                block3.setDependSubTask()
                task   =  af.Task( _job.farmCmd( self.postCmd['cmd'] ) )
                task.setCommand( _job.farmCmd( self.postCmd['cmd'] ) )
                block3.tasks.append(task)
                _job.blocks.append(block3)


            '''
            for f in r:
                    task = af.Task('frame %d' % f)
                    task.setCommand(cmd.replace('@#@', str(f)))
                    #task.setFiles(['image_%d.exr' % f])
                    block1.tasks.append(task)

            #block1.setFiles(['render/preview.%04d.jpg'])
            #block1.setPostCommand("echo DONE!!")
            block3 = af.Block('makeDaily', 'generic')
            block3.setTasksDependMask('SAM')
            block3.setCommand('make daily')
            block3.setFiles(['render/key.%04d.exr'])

            block1.setTasksDependMask('key|back')
            block3 = af.Block('key', 'nuke')
            block3.setCommand('nuke -X key -x scene.nk %1,%2')
            block3.setNumeric(1, 20, 3)
            block3.setFiles(['render/key.%04d.exr'])

            block4 = af.Block('back', 'nuke')
            block4.setCommand('nuke -X back -x scene.nk %1,%2')
            block4.setNumeric(1, 20, 3)
            block4.setFiles(['render/back.%04d.exr'])
            _job.blocks.append(block3)
            _job.blocks.append(block4)
            #_job.blocks.append(block3)
            '''
            #set the description as annotation on the farm!
            if hasattr(self, 'description'):
                _job.setAnnotation( self.description )
            else:
                _job.setAnnotation( self.asset )

            print( '='*80 )
            print( _job.output(1) )
            print( '='*80 )

            return _job.send()
