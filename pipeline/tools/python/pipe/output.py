#!/usr/bin/env python
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


class output(object):
    class resolution():
        pass

    __outputs = {}
    __outputs_count = 90
    @classmethod
    def register( cls, label, w, h, apps, seqFileType='exr', pad=5, id=None ) :
        if not id:
            id = cls.__outputs_count
            cls.__outputs_count += 1
        label = "%03d.%s" % (id, label)
        cls.__outputs[label] = output.resolution()
        cls.__outputs[label].id = id
        cls.__outputs[label].x = w
        cls.__outputs[label].y = h
        cls.__outputs[label].xy = "%dx%d" % (w,h)
        cls.__outputs[label].hlabel = "%s - %dx%d - %s" % (label[4:], w, h, seqFileType.upper())
        cls.__outputs[label].apps = apps
        cls.__outputs[label].ext = seqFileType
        cls.__outputs[label].pad = pad

    def labels(self):
        ids = self.__outputs.keys()
        ids.sort()
        ret = map( lambda x: self.__outputs[x].hlabel, ids )
        return ret

    def keys( self ):
        return self.__outputs.keys()

    def asPreset(self):
        return tuple( map( lambda x: (x,x), self.labels() ) )

    def __getitem__(self, key):
        ret = None
        if key in self.keys():
            ret = self.__outputs[key]
            
        if key in self.labels():
            ret = filter( lambda x: key == self.__outputs[x].hlabel, self.__outputs.keys() )[0]
            ret = self.__outputs[ret]
                
        return ret


output.register('Full HD', 1920, 1080, ['nuke', 'maya', 'gaffer'], 'exr')
output.register('Half HD', 1280,  720, ['nuke', 'maya', 'gaffer'], 'exr')
output.register('Full SD',  640,  480, ['nuke', 'maya', 'gaffer'], 'exr')
output.register('Half SD',  320,  240, ['nuke', 'maya', 'gaffer'], 'exr')
output.register('Double HD', 1920*2, 1080*2, ['nuke', 'maya', 'gaffer'], 'exr')
output.register('Triple HD', 1920*3, 1080*3, ['nuke', 'maya', 'gaffer'], 'exr')
output.register('Quadruple HD', 1920*4, 1080*4, ['nuke', 'maya', 'gaffer'], 'exr')
