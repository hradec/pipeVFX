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