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


class houdini(current.engine):
    def __init__(self, scene, driver, renderer='mantra', outFile='', name='', extra='', CPUS=0, priority=9999, range=range(1,10), group='pipe'):
        self.renderer = renderer
        self.output_driver = driver
        self.output_filename = outFile
        self.scene =  os.path.abspath( scene )
        if not os.path.exists(self.scene):
            raise Exception("Can find the file %s!!!" % self.scene)
        current.engine.__init__(self, scene, name, CPUS, extra, priority, range, group)
        
    def cook(self):
        # if no output filename, create a default one based on 
        # scene name and output driver node name!
        if not self.output_filename:
            self.output_filename = os.path.join(
                os.path.dirname(self.scene),
                'render',
                os.path.splitext(os.path.basename(self.scene))[0],
                '%s.$F4.exr' % os.path.basename(self.output_driver)
            )
            
        # escape $F used by houdini 
        self.output_filename = self.output_filename.replace("$F","\\\\\\\\\\$\\\\\\F")
        
        # if renderer os mantra, do a hrender normally. 
        # we can setup here different renders to do simulation, for example!
        if self.renderer == 'mantra': 
            self.name += " | MANTRA v%s" % ''.join(filter( lambda x: x.isdigit(), pipe.apps.houdini().version() ))
            #self.licenses['mantra'] = True
            
        self.cmd = ' '.join([
            'run hrender -e -f %s %s' % (self.frameNumber(),self.frameNumber()),
            '-d "%s"' % self.output_driver,
#            '-o "%s"' % self.output_filename,
            '\\\'%s\\\'' % self.scene
        ])
        