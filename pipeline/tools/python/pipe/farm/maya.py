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

import pipe.apps
import current
import os


class maya(current.engine):
    def __init__(self, scene, project=None, asset=None, renderer=None, ribs=[], name='', extra='', CPUS=0, priority=9999, range=range(1,10), group='pipe', description=''):
        self.renderer = renderer
        self.project = project
        if not self.project:
            self.project = os.path.dirname(os.path.dirname(scene))
        self.scene =  os.path.abspath( scene )
        self.ribs = ribs
        current.engine.__init__(self, scene, name, CPUS, extra, priority, range, group,asset=asset, description=description)
        self.description = description

    def cook(self):
        asset=''
        if self.asset:
            asset= '--asset "%s"' % self.asset

        if self.renderer == '3delight':
            self.name += " | 3DELIGHT v%s" % pipe.apps.delight().version()
            self.licenses['delight'] = True
            self.cmd = [
                'run Render -s %s -e %s' % (self.frameNumber(), self.frameNumber()),
                "-preRender \\'currentTime %s\\'" % self.frameNumber(),
                '-proj "%s"' % self.project,
#                '-renderer "%s"' % self.renderer,
                '"%s"' % self.scene,
                asset,
            ]


            for each in self.ribs:
                self.cmd.append( '; run renderdl "%s" %s ' % (each, asset) )

            self.cmd = ' '.join(self.cmd)

        else:
            pipe_asset = "_".join(self.asset.strip('/').split('/')[-2:]).replace('.','_')

            extra = ''
            pre = ''
            pos = ''
            print( "\n\n\n ======>%s \n\n\n" % self.renderer )
            if 'renderMan' in self.renderer:
                batchContext = "%s_%s" % (pipe_asset, self.frameNumber())
                extra = '-r rman -batchContext %s' % batchContext
                if 'RIS' in self.renderer:
                    extra = extra+' -ris '

                pre = 'rm -rfv %s/renderman/%s_%s ; export error=$? ; echo $error ; [ $error -ne 0 ] && echo "[PARSER ERROR]" || ' % (self.project, self.asset.strip('/').split('/')[-2], batchContext)
                pos = ' && rm -rfv %s/renderman/%s_%s ' % (self.project, self.asset.strip('/').split('/')[-2], batchContext)

            if 'mentalRay' in  self.renderer:
                extra = ' -mr:v 5 '

            self.name += " | MAYA v%s (%s)" % (pipe.apps.maya().version(), self.renderer)
            self.cmd = ' '.join([
                'export PIPE_ASSET="%s_%s" && ' % (pipe_asset, self.frameNumber()) ,
                pre,
                'run Render -s %s -e %s ' % (self.frameNumber(), self.frameNumber()),
                '-proj "%s"' % self.project,
#                '-renderer "%s"' % self.renderer,
                extra,
                '"%s"' % self.scene,
                asset,
                pos
            ])

            #mel rmanSpoolImmediateRIBLocalRender()

            self.files = ["%s/images/none" % self.asset]
            # add an extra postCmd to cleanup the pipe_asset folder inside renderman, if any!
#            self.postCmd = {
#                'name' : "(post cleanup)",
#                'cmd'  : 'rm -rf "%s/renderman/%s"' % ( self.project, pipe_asset ),
#            }
