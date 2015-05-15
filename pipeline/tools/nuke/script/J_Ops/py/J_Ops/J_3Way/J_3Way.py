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

#  J_3Way.py
#  J_Ops
#
#  Created by Jack Binks on 07/01/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.

import os
import sys

import nuke
import nukescripts

# Additional imports inline.

def importCDLButton():
    """entry function from J_3Way on Import button push. 
    
    Note that if the J_Ops J_3Way framework is not found it'll cause a crash.
    This should call all required functions and set the CDL knobs on thisNode()
    before returning.
    
    """
    
    # Grab the parent nodes current file string
    cdlfilename=nuke.thisNode().knob("cdlfile").getValue()

    # Check file exists, then call relevant parsing modules dependant on selected 
    # file's extension.    
    if os.path.exists(cdlfilename) == True:
        cdlfileext=os.path.splitext(cdlfilename)[1].lstrip('.')

        if cdlfileext == 'ccc':
            # Simple colour correction container
            import J_Ops.J_3Way.parseCCC
            J_Ops.J_3Way.importCCC().parse(cdlfilename)

        elif cdlfileext == 'cdl': 
            # Colour decision list
            import J_Ops.J_3Way.parseCDL
            J_Ops.J_3Way.importCDL().parse(cdlfilename)
        
        # Implement others here.
                
        else:
            nuke.message("Parser does not yet exist for filetype: " + cdlfileext + ".\n"
                "Check out the manual for information on implementing a parser inside the J_3Way framework")
    
    else:
        nuke.message("File does not exist")
    
    return   
        
def exportCDLButton():
    """entry function from J_3Way on Export button push. Not yet implemented, please feel free.
    """
    
    # Grab the parent nodes current file string
    cdlfilename=nuke.thisNode().knob("cdlfile").getValue()

    # Check file exists, ask if ok to overwrite then call relevant parsing modules dependant on selected 
    # file's extension.    
    if os.path.exists(cdlfilename) == True:
        cdlfileext=os.path.splitext(cdlfilename)[1].lstrip('.')
        # TODO: pop up panel to check overwrite ok
        
    if cdlfileext == 'ccc':
        # Simple colour correction container
        import J_Ops.J_3Way.parseCCC
        pass
        #J_Ops.J_3Way.exportCCC().parse(cdlfilename)

    elif cdlfileext == 'cdl': 
        # Colour decision list
        import J_Ops.J_3Way.parseCDL
        pass
        #J_Ops.J_3Way.exportCDL().parse(cdlfilename)
    
    # Implement others here.
            
    else:
        nuke.message("Parser does not yet exist for filetype: " + cdlfileext + ".\n"
            "Check out the manual for information on implementing a parser inside the J_3Way framework")
    
    return

