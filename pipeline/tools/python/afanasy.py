#!/usr/bin/env ppython


import sys, os
import pipe

pipe.apps.cgru().expand()
import af
import afnetwork

#
# del os.environ['DISPLAY']
#
# import IECore
# from assetUtils import assetOP
# a=assetOP(sys.argv[1])
# a.data['assetClass']['RenderEngine']= IECore.StringData('renderManRIS')
# result=a.submission()
#[ x for x in af.Cmd().getJobList(False) if x.has_key('folders') and a.data['publishPath'] in x['folders']['output'] ]


#reload( afanasy );af=afanasy.simple();af.skipTask( 10, 0, 19)
#reload( afanasy );af=afanasy.simple();af.skipTask( 'jacquin_andando_01.01.00', 0, 18)

class simple( object ):
    def _getJobList(self, filter=''):
        self.list = [x for x in af.Cmd().getJobList(False) if filter.lower() in x['name'].lower() ]
        return self.list

    def getRunningJobs(self, filter=''):
        self._getJobList(filter)
        return [ x for x in self.list if x.has_key('state') and ('RUN' in x['state'] or 'RDY' in x['state']) ]

    def getJobsByID(self, id):
        self._getJobList()
        return [ x for x in self.list if x['id']==id ]

    def skipTask( self, jobID, blockID, taskID ):
        # json to skip a task
        if type(taskID) is not list:
            taskID = [taskID]

        if type(jobID) is int:
            job = self.getJobsByID(jobID)
        else:
            job = self._getJobList(jobID)

        assert( job )
        assert( len(job) == 1 )


        firstFrame = job[0]['blocks'][blockID]['frame_first']
        taskID = [ x-firstFrame for x in taskID ]
        jobID = job[0]['id']

        json =  {
            "action": {
                "user_name":"coord",
                "host_name":"pc",
                "type":"jobs",
                "ids":[jobID],
                "block_ids":[blockID],
                "operation":{
                    "type":"skip",
                    "task_ids":taskID
                },
            }
        }

        return afnetwork.sendServer(af.json.dumps(json), False)



#
# print '-'*80
# #print af.Cmd().data(r[0]['id'])
# print '-'*80
# print type(r[0])
# for n in r[0].keys():
# 	print '-'*80
# 	print n
# 	print r[0][n]

#af.Cmd().action('jobs', [r[0]['id']], 'S', [3])
