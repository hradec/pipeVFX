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

#  J_Ops
#
#  Created by Jack Binks on 13/01/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.


import os
import sys
import glob

import nuke
import nukescripts

from J_Ops.J_3Way.CDLUtils import *

#additional imports inline


class importCDL( CDLImporter ):
    """Manages the CCC import process"""
    
    
    def parse( self, cdlfilename ):
        """Called by import dispatch script if it encounters a file with a .cdl extension.
        
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


    def parseIDs( self ):
        """Get initial colour correction id data out of CDL XML.
        
        Called by parse method to fill in the slef.colourcorrectionvalues dict object
        with just keys, where the keys are the id's found in the file specified
        by self.filename.
        
        """
        
        # Call parent utility function to grab an element tree representation of the
        # file specified in self.filename (set via parse())
        CDLImporter.getXMLTree( self )
        
        # As CDL formats have ColourCorrections as direct children of the "ColorDecision"
        # elements present in the tree, iterate over all of those found and use the parent
        # utility function, to grab the ColorCorrection ID elements from each
        iter = self.tree.getroot().findall(self.ASCCDLNS + "ColorDecision")
        for element in iter:
            CDLImporter.parseColorCorrectionIDs( self, element )

        return

    def parseElement( self, cccname ):
        """Get an individual elements colour correction parameters dynamically. 
        
        Called by panel on the fly, and should fill in the appropriate colour correction 
        id in the self.colourcorrectionvalues dict with all the relevant grade details
        from the CDL file. 
        
        cccname should be a valid id, gathered from the parseID() function.
        
        Returns true or false depending on if the cccname is found.
        
        The difficulty here is that some elements are internal, and some are external refs, 
        where externals can be located in any other ccc file, by any name. The only link
        is the ID name itself. If the ref is external, you'll need to set self.searchStrat
        to: 
        0.0 - to check in the same path and under the same file name as self.cdlfilename 
            (with extension replaced by .ccc)
        1.0 - to check in the same path, under *.ccc
        2.0 - to check in a specified file. If this is selected, self.specifiedPath should
            be filled in with the file to be checked.
        
        """
    
        # Get internal element variables first
        elementlist = self.tree.getroot().findall(self.ASCCDLNS + "ColorDecision")
        for element in elementlist:
            result = CDLImporter.parseColorCorrectionElement( self, element, cccname )
            if result is True: 
                break

        # Then if it's external, go find the remainder.
        # This uses instances of the parseCCC class to do the heavy lifting.
        if self.cdlcorrectionvalues[cccname]["type"] == "ext":
            
            if self.searchStrat == 0.0:  
                # Same name, same dir
                # Grab the split filename, and pass it to the parseExtCCC function
                # which manages all the running of the CCC parser to do the real work
                cdlfilenamebase, tempStore = os.path.splitext(self.cdlfilename)
                return self.parseExtCCC( cdlfilenamebase + ".ccc", cccname)
                
            elif self.searchStrat == 1.0:
                # Any name, same dir
                # Grab the pathname and glob to grab all the ccc files contained
                # therein. Fire up the external CCC parser management function
                # with each file found, and check to see if its managed to find
                # the id. If multiple ccc files contain the ID it reports a problem
                filepath, filename = os.path.split(self.cdlfilename)
                successfullIDMatches = 0
                for file in glob.glob(filepath+"/*.ccc"):
                    result = self.parseExtCCC( file, cccname )
                    if result is True:
                        successfullIDMatches += 1
                        if successfullIDMatches == 2:
                            self.cdlcorrectionvalues[cccname]["description"] = \
                                "Multiple successful ID matches. Please use specific path \
                                 to identify which particular grade you're after" 
                            return False
                return result
            
            elif self.searchStrat == 2.0:    
                # Specified file
                # Fires up the external CCC parser management function, pointing
                # it at the file specified by the user in the cdl parser dialogue.
                return self.parseExtCCC( self.specifiedPath, cccname)
                
        return result
            
    def parseExtCCC( self, filename, cccname ):
        """Grab the CDL params from an external ref and a CCC file.
        
        Manages a CCC parser instance, so that CDL external references can be tracked down.
        Hand it a filename and a CCC id and it'll fill in self.cdlcorrectionvalues[cccname]
        with the params from the ColourCorrection tag found, or with the defaults if the no
        corresponding ID found.
        Returns true or false depending on if it manages to find the ID passed in the file 
        in question.
        
        """
        
        # Check file exists before bothering
        if os.path.exists(filename) is not True:
            return False
            
        # Create an instance of the CCC parsing class
        import J_Ops.J_3Way.parseCCC
        cccparser = J_Ops.J_3Way.importCCC()
        
        # Set the required variables and call with id
        cccparser.cdlfilename = filename
        cccparser.parseIDs()
        result = cccparser.parseElement(cccname)
        
        # Copy over variables
        for element in self.correctionValuesOnly:
            self.cdlcorrectionvalues[cccname][element] = cccparser.cdlcorrectionvalues[cccname][element]
        
        # Add to description to explain whats going on
        if result is True:
            desc = "External CCC reference. Matching ID found in: " + filename
        else:
            desc = "External CCC reference. No matching ID found. "
        
        self.cdlcorrectionvalues[cccname]["description"] = desc + "\n" 
        self.cdlcorrectionvalues[cccname]["type"] = "ext"
        
        return result
        
class exportCDL():
    pass