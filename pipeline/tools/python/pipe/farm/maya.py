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

import current
import os


class maya(current.engine):
    def __init__(self, scene, project, asset=None, renderer='3delight', ribs=[], name='', extra='', CPUS=0, priority=9999, range=range(1,10), group='pipe'):
        self.renderer = renderer
        self.project = project
        self.scene =  os.path.abspath( scene )
        self.ribs = ribs
        current.engine.__init__(self, scene, name, CPUS, extra, priority, range, group,asset=asset)
        
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
            self.name += " | MAYA v%s" % pipe.apps.maya().version()
            self.cmd = ' '.join([
                'run Render -s %s -e %s' % (self.frameNumber(), self.frameNumber()),
                '-proj "%s"' % self.project,
#                '-renderer "%s"' % self.renderer,
                '"%s"' % self.scene,
                asset,
            ])
        
            