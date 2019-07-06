#mayaImport.py  v1.1

#Required modules imported
import os
import nuke
import nukescripts

class mayaImport(nukescripts.PythonPanel):
    def __init__(self):
        nukescripts.PythonPanel.__init__(self, 'Maya Import')

        self.readDirKnob = nuke.File_Knob("File")
        self.openBttnKnob = nuke.PyScript_Knob( "mImport", "Import" )
        for k in (self.readDirKnob, self.openBttnKnob):
            self.addKnob(k)
	#END PANEL BUILD
	
	#Create Callbacks for when knobs are changed
	def knobChanged(self,knob):
		if knob == self.openBttnKnob:
			nuke.message("esta funfando1")

				
	def mImport():
		nuke.message("esta funfando2")
			
	
def mayaPanel():
	p = mayaImport()
	p.show()