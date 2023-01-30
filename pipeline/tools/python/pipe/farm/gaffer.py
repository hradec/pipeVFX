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

from pipe.farm import current
import os


class gaffer(current.engine):
    def __init__(self, scene, project=None, asset=None, name='', extra='', CPUS=0, priority=9999, range=range(1,10), group='pipe', description=''):
        self.project = project
        if not self.project:
            self.project = os.path.dirname(os.path.dirname(scene))
        self.scene =  os.path.abspath( scene )
        current.engine.__init__(self, scene, name, CPUS, extra, priority, range, group,asset=asset, description=description)
        self.description = description

    def cook(self):
        import pipe.apps
        asset=''
        if self.asset:
            asset= '--asset "%s"' % self.asset

        pipe_asset = "_".join(self.asset.strip('/').split('/')[-2:]).replace('.','_')

        extra = ''
        pre = ''
        pos = ''
        print( "\n\n\n ======>%s \n\n\n" % self.renderer )

        self.name += " | GAFFER v%s" % (pipe.libs.gaffer().version())
        self.cmd = ' '.join([
            'export SAM_ASSET="%s" && ' % asset ,
            'export PIPE_ASSET="%s_%s" && ' % (pipe_asset, self.frameNumber()) ,
            pre,
            'gaffer --execute -frames %s-%s ' % (self.frameNumber(), self.frameNumber()),
            '-proj "%s"' % self.project,
            extra,
            '-script "%s"' % self.scene,
            # asset,
            pos
        ])

        #mel rmanSpoolImmediateRIBLocalRender()

        self.files = ["%s/images/none" % self.asset]
        # add an extra postCmd to cleanup the pipe_asset folder inside renderman, if any!
        # self.postCmd = {
        #     'name' : "(post cleanup)",
        #     'cmd'  : 'rm -rf "%s/renderman/%s"' % ( self.project, pipe_asset ),
        # }

    # mount a ramdisk to the renderman folder, so render is faster and
    # hopefully minimize problems at googlefarm
    # def farmSetupPre(self):
    #     preFarmCmd = ''
    #     if 'renderMan' in self.renderer:
    #         if self.asset:
    #            pipe_asset = "_".join(self.asset.strip('/').split('/')[-2:]).replace('.','_')
    #            batchContext = "%s_%s" % (pipe_asset, self.frameNumber())
    #            preFarmCmd += '''mount | egrep 'tmpfs.*renderman' | awk '{print $3}' | while read p ; do umount $p ; done ; '''
    #            preFarmCmd += 'mkdir -p  %s/renderman/%s_%s ; ' % (self.project, self.asset.strip('/').split('/')[-2], batchContext)
    #            preFarmCmd += 'mount -t tmpfs tmpfs  %s/renderman/%s_%s ; df -h ; ' % (self.project, self.asset.strip('/').split('/')[-2], batchContext)
    #            preFarmCmd += 'chown %s:%s -R %s/renderman/%s_%s ; ' % (os.getuid(), os.getgid(), self.project, self.asset.strip('/').split('/')[-2], batchContext)
    #            preFarmCmd += 'chmod a+rwx -R %s/renderman/%s_%s ; ' % (self.project, self.asset.strip('/').split('/')[-2], batchContext)
    #            preFarmCmd += 'ls -la %s/renderman/%s_%s/ ' % (self.project, self.asset.strip('/').split('/')[-2], batchContext)
    #     return preFarmCmd
    #
    # def farmSetupPos(self):
    #     posFarmCmd = ''
    #     if 'renderMan' in self.renderer:
    #         posFarmCmd  = '''mount | egrep 'tmpfs.*renderman' | awk '{print $3}' | while read p ; do umount $p ; done ; df -h '''
    #     return posFarmCmd
