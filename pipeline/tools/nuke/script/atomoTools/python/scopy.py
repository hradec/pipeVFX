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

#scopy.py  v1.1
#Required modules imported
import os
import nuke

def scopy():
	a = nuke.selectedNode()
	if a is not None:
		#a = nuke.selectedNode()
		name = a.name()
		print name
		b = nuke.nodes.PostageStamp(name= name)
		b.setInput(0, nuke.toNode(name) )
		for n in  nuke.allNodes():
			if n.Class() in ('PostageStamp'):
				n.knob('hide_input').setValue(True)
				n.knob('postage_stamp').setValue(True)
				n.knob('label').setValue("Copy")
		return
	
	else:
		nuke.message("Nenhum Node foi selecionado!")