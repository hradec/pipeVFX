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


import pipe, os
from pipe.farm.baseClass import baseFarmJobClass

class job(baseFarmJobClass):
    
    @staticmethod
    def updateLicenseUsage(app, used, total):
        updateresources = pipe.apps.qube().path('qube-core/local/pfx/qube/sbin/qbupdateresource')
        os.system("%s --name license.%s --used %s --total %s" % (updateresources, app, used, total) )
    
    @staticmethod
    def frameNumber():
        return 'QB_FRAME_NUMBER'

    def submit(self, depend=None):
        self.reservations = ['host.processors=1+']
        
        # add license registration
        for each in self.licenses:
            self.reservations.append('license.%s' % each)
        
        from sys import path
        path.insert(0, pipe.apps.qube().path('qube-core/local/pfx/qube/api/python/') )
        import qb
        #print dir(qb)
        self.qb = qb.Job()
        self.qb['name']      = self.name
        self.qb['prototype'] = 'cmdrange'
        self.qb['package']   = {
#            'cmdline' : 'echo "Frame QB_FRAME_NUMBER" ; echo $HOME ; echo $USER ; cd ; echo `pwd` ; sleep 10',
            'cmdline' : self.cmd,
            'padding' : self.pad,
            'range'   : str(self.range())[1:-1], 
        }
        self.qb['agenda']         = qb.genframes( self.qb['package']['range'] )
        self.qb['cpus']           = self.cpus
        self.qb['hosts']          = ""
        self.qb['groups']         = self.group
        self.qb['cluster']        = "/pipe"
        self.qb['priority']       = self.priority
        self.qb['reservations']   = ','.join(self.reservations)
        self.qb['retrywork']      = self.retry
        self.qb['retrywork_delay']= 15
        self.qb['retrysubjob']    = self.retry
        self.qb['flags']          = 'auto_wrangling,migrate_on_frame_retry'

        return qb.submit(self.qb)[0]['id']
        
         
