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

#  parseCCC.py
#  J_Ops
#
#  Created by Jack Binks on 13/01/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.

import os
import sys

import nuke
import nukescripts

from J_Ops.J_3Way.CDLUtils import *

# Additional imports inline


class importCCC( CDLImporter ):
    """Manages the CCC import process"""
    
    
    def parse( self, cdlfilename ):
        """Called by import dispatch script if it encounters a file with a .ccc extension.
        
        Main entry function. This grabs the relevant id details from the specified file,
        presents the user with a Nuke Panel so they can check the details, then sets the 
        CDL knobs on the calling node.
        Passed cdlfilename must be checked existence. 
        
        """

        self.cdlfilename = cdlfilename
        
        # Get the initial colour correction IDs from the xml file
        self.parseIDs()
        
        # Show user the options available.
        result, self.cdlcorrectionid = parseDialogue().showModalDialog( self )

        # If they hit ok then set the J_3Way values appropriately.
        if result==True:
            CDLImporter.setCDLValues( self )
        
        return result

    def parseIDs( self ):
        """Get initial colour correction id data out of CCC XML.
        
        Called by parse method to fill in the slef.colourcorrectionvalues dict object
        with just keys, where the keys are the id's found in the file specified
        by self.filename.
        
        """
        
        # Call parent utility function to grab an element tree representation of the
        # file specified in self.filename (set via parse())
        CDLImporter.getXMLTree( self )

        # As CCC formats have ColourCorrections as direct children of the root we
        # use the parent utility function and directly pass the root element of the tree.
        CDLImporter.parseColorCorrectionIDs( self, self.tree.getroot() )

        return
        
        
    def parseElement( self, cccname):
        """Get an individual elements colour correction parameters dynamically. 
        
        Called by panel on the fly, and should fill in the appropriate colour correction 
        id in the parser dict with all the relevant grade details from the CCC file.
        
        cccname should be a valid id, gathered from the parseID() function.
        
        Returns true or false depending on if the cccname is found.
        
        """
        
        return CDLImporter.parseColorCorrectionElement( self, self.tree.getroot(), cccname )
        

class exportCCC():
    pass
    