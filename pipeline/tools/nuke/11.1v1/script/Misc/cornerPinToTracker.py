###    CornerPin to tracker 
###    
###    ---------------------------------------------------------
###    cornerPintoTracker.py
###    Created: 10/05/2011
###    Modified: 20/06/2011
###    Written by BLUE FACES
###    info@bluefaces.eu
### 
###    Usefull for converting CornerPin node imported from Mocha to tracker node
###    Script set transform mode to matchmove and reference frame to current frame	
### 


import nuke

def cornerPinToTracker():

    cp = nuke.selectedNode()
 
    cp1= cp['to1'].animations()
    cp2= cp['to2'].animations()
    cp3= cp['to3'].animations()
    cp4= cp['to4'].animations()


    tr=nuke.createNode("Tracker3")
    tr.knob('enable2').setValue('True')
    tr.knob('enable3').setValue('True')
    tr.knob('enable4').setValue('True')
    tr.knob('warp').setValue('srt')
    tr.knob('transform').setValue('match-move')
    tr.knob('use_for1').setValue('all')
    tr.knob('use_for2').setValue('all')
    tr.knob('use_for3').setValue('all')
    tr.knob('use_for4').setValue('all')
    tr.knob('reference_frame').setValue(nuke.frame())
   

    nuke.toNode(tr.knob('name').value())['track1'].copyAnimations(cp1)
    nuke.toNode(tr.knob('name').value())['track2'].copyAnimations(cp2)
    nuke.toNode(tr.knob('name').value())['track3'].copyAnimations(cp3)
    nuke.toNode(tr.knob('name').value())['track4'].copyAnimations(cp4)