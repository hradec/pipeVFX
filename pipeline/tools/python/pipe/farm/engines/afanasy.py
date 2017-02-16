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
            # create an afanasy job block
            block1 = af.Block("main", className )
            block1.setParser('generic')
            #block1.setCommand("none")
            if hasattr( self, "files" ):
                #block1.setFiles([os.path.dirname(self.files[0])+"/*"])
                block1.setFiles(self.files)

            blocks = [block1]
            n = 1
            for cmd in self.cmd:
                task = af.Task("%s" % (str(n))) #, cmd.split('run')[-1].replace('/','_')))
                realcmd = "/usr/sbin/runuser -l %s --session-command  ' PIPE_FARM_USER=%s ; unset NOPIPE ; unset USE_SYSTEM_LIBRARY ; unset LD_LIBRARY_PATH ;  unset LD_PRELOAD;  echo $HOSTNAME ; " % (pipe.admin.username(),pipe.admin.username())  + cmd.replace("'","\\'") + "  || echo [PARSER ERROR] ; echo $? ' ; echo $?"
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

            print '='*80
            print job.output(1)
            print '='*80

            return job.send()

        else:

            # we use su to run the tasks as the user who submitted it!
            cmd = "/usr/sbin/runuser -l %s --session-command  ' PIPE_FARM_USER=%s ; unset LD_LIBRARY_PATH ;  unset LD_PRELOAD;  echo $HOSTNAME ; " % (pipe.admin.username(),pipe.admin.username())  + self.cmd.replace("'","\\'") + " || echo '[PARSER ERROR]' ; echo $? ' ; echo $?"
            #cmd = "/usr/sbin/runuser -l %s --session-command  'export PIPE_FARM_USER=%s ; " % ('pkg',pipe.admin.username())  + self.cmd.replace("'","\\'") + "'"
            job = af.Job( "SAM %s" % self.name )


            # make sure r in a range list!
            r = self.range()
            if type(self._range)==type(""):
                rs = self._range.split('-')
                r=int(rs[0])
                if len(rs)>1:
                    r = range(int(rs[0]),int(rs[1]))

            # create an afanasy job block
            block1 = af.Block(self.name, className )
            block1.setParser('generic')
            block1.setCommand(cmd)
            if hasattr( self, "files" ):
                block1.setFiles(self.files)


            r.sort()
            block1.setNumeric(r[0], r[-1], r[1]-r[0])
            block1.setSequential(0)
            job.blocks.append(block1)


            if hasattr( self, "postCmd" ):
                block2 = af.Block( self.postCmd['name'] )
                block2.setDependMask( self.name )
                block2.setDependSubTask()
                task   =  af.Task( self.postCmd['cmd'] )
                task.setCommand( self.postCmd['cmd'] )
                block2.tasks.append(task)
                job.blocks.append(block2)


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
            job.blocks.append(block3)
            job.blocks.append(block4)
            #job.blocks.append(block3)
            '''


            print '='*80
            print job.output(1)
            print '='*80

            return job.send()
