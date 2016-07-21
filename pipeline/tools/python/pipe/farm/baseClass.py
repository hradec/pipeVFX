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


import os, pipe

class baseFarmJobClass(object):
    ''' Base farm class which is used by all farm jobs and engines classes '''
    def __init__(self, cmdLine, name='', CPUS=0, extra={}, priority = 9999, range = range(1,11,1), group = 'pipe', pad=4, asset='', retry=5):
        self.job        = "NO_JOB"
        self.shot       = "NO_SHOT"
        if os.environ.has_key('PIPE_JOB'):
            self.job    = os.environ['PIPE_JOB']
        if os.environ.has_key('PIPE_SHOT'):
            self.shot   = os.environ['PIPE_SHOT'].split('@')
        self.name       = name
        self.asset      = asset
        self.cpus       = CPUS
        self.priority   = priority
        self.group      = group
        self.cmd        = cmdLine
        self.extra      = extra
        self.pad        = pad
        self.__range    = range
        self._range    = range
        self.licenses   = {}
        self.retry      = retry
        self.user       = pipe.admin.username()

        # call the method that configures the job
        self.cook()

        # add pipe job/shot setup before the command line (run go)
        self.cmd = ' '.join([
            'source /atomo/pipeline/tools/scripts/go %s %s %s && export FRAME_NUMBER=%s && ' % (self.job, self.shot[0], self.shot[1], self.frameNumber()),
            self.cmd,
        ])

        # setup frame range
        self.name = self.name.replace('  ',' ').replace(' :',':')
        self.name = ' %s_%s_%s | ' % (self.job, self.shot[0], self.shot[1]) + self.name

    def range(self):
        ''' this method returns the frame range in the right order
        it can be used to calculate different orders, like
        ascending, descending, binary, etc'''

        # uncoment this to return ascending range
        #return self.__range

        # binary order range!
        r = self.__range
        nv=[]
        n=(0, len(r)-1)
        count = len(r)
        while count:
            nn=[]
            old=None
            for each in n:
                try: nv.index(r[each])
                except:
                    nv.append( r[each] )
                if old != None:
                    f=old+float(each-old)/2
                    f=int(f)
                    try: nn.index(f)
                    except:
                        nn.append( f )

                try: nn.index(each)
                except:
                    nn.append( each )
                old = each
            #print n, nn
            n=nn
            count -= 1

        return nv

    def cook(self):
        ''' this method is called before subjobs to generate a cmd line used by each subjob
            This method MUST be implemented by JOB classes
        '''
        pass

    def submit(self):
        ''' this method is called when the whole job is ready to be sent to the farm
            This method MUST be implemented by FARM ENGINE classes
        '''
        pass

    @staticmethod
    def frameNumber():
        ''' this method should return the expresion a farm engine uses to represent
        the current render frame in a command line.
        ex: qube uses QB_FRAME_NUMBER
        '''
        return "FRAME_NUMBER"
