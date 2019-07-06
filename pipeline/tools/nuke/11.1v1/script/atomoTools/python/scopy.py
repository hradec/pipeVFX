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