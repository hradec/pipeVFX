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

##########################################################################
#
#  Copyright (c) 2010, Roberto Hradec. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of Image Engine Design nor the names of any
#       other contributors to this software may be used to endorse or
#       promote products derived from this software without specific prior
#       written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

#
# A class to monitor nodes in realtime
#
# it monitors nodes in maya, returning updated values everytime
# its accessed!
#

import os
import maya.cmds as m

class nodeWatcher:
    def __init__(self, nodetype, attribute):
        self.list = {}
        self.path = {}
        self.nodetype = nodetype
        self.attribute = attribute
        self.__listAll()

    def __cleanList__(self):
        for each in self.list:
            x = []
            x.extend(self.list[each])
            for index in x:
                self.list[each].remove(index)
        
    def __listAll(self):
        self.__cleanList__()
        for each in m.ls(type=self.nodetype):
            cgfx = m.getAttr('%s.%s' % (each, self.attribute) )
            cgfxName = os.path.basename(cgfx)
            if cgfxName not in self.list:
                self.list[cgfxName]=[]
            if each not in self.path:
                self.path[each]=cgfx
            if each not in self.list[cgfxName]:
                self.list[cgfxName].append(each)
            
    
    def refresh(self):
        self.__listAll()

    def __getitem__(self, key):
        self.__listAll()
        return self.list[key]

    def __str__(self):
        self.__listAll()
        return str(self.list)

    def attachedGeo(self, node):
        shapez = {}
        sgs = m.connectionInfo( "%s.outColor" % node, dfs=True )
        for sg in sgs:
            sg = sg.split('.')[0]
            for index in m.getAttr( "%s.dagSetMembers" % sg, mi=True ):
                shape = m.connectionInfo( "%s.dagSetMembers[%s]" % (sg,index), sfd=True ).split('.')[0]
                shapez[shape] = m.listRelatives( shape, p=True)
        return shapez


