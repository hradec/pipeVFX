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
#  Created by jack on 17/01/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.


import xml.etree.ElementTree as ET

import nuke
import nukescripts

class parseDialogue(nukescripts.PythonPanel): 
    """Dialogue used to display CDL params found in ASC CDL files.
    
    Displays, and allows user to select desired ASC CDL corrections, via ID tags.
    Grabs data from an associated parser instance, containing a colourcorrectionvalues
    dict which outlines all the ids found. The dialogue calls the parsers parseElement() 
    method, passing the currently selected ID to get it to fill in the defining ASC CDL
    characteristics found in the selected file. On if the client selects a different ID
    parseElement() is called again, dynamically, to fill in the new correction details.
    
    
    """

    def __init__(self): 
        nukescripts.PythonPanel.__init__( self, "CDL Options", "com.blogspot.major-kong.J_Ops.J_3Way.CDLOptions" )
        self.cdlcorrectionvalues={}
        self.ASCCDLNS = "{urn:ASC:CDL:v1.01}"
        self.parser = None

    def knobChanged(self, knob):
        """Called from parent panel method when user changes knob value on panel.
        
        Fires off parseElement() method on associated parser instance, so as to dynamically update the parser
        managed colourcorrectionvalues dict with newly selected CC ID, then updates the panel knobs to only
        show the relevant ones, and to update with new CC details.
        
        """
        
        if knob == self.cdlcorrectionid or knob == self.extrefsearchpath or knob == self.extrefpath: 
            self.updateDesc()
        
    def showModalDialog(self, parser):
        """Called to display the dialogue to the user."""
        
        self.parser = parser
        
        self.cdlcorrectionid = nuke.Enumeration_Knob("cdlcorrectionid", "ID", sorted(self.parser.cdlcorrectionvalues.keys()))
        self.addKnob(self.cdlcorrectionid)

        self.dividerone = nuke.Text_Knob("dividerone", "")
        self.addKnob(self.dividerone)
        
        self.cdlcorrectiondesc = nuke.Multiline_Eval_String_Knob("cdlcorrectiondesc", "Description", "")
        self.addKnob(self.cdlcorrectiondesc)
        self.cdlcorrectiondesc.setFlag(nuke.DISABLED)
        
        self.dividertwo = nuke.Text_Knob("dividertwo", "")
        self.addKnob(self.dividertwo)
        
        self.extrefsearchpath = nuke.Enumeration_Knob("extrefsearchpath", "Ref Search", \
                                    ["Same Name, Same Dir", "Any Name, Same Dir", "Specified"]) 
        self.addKnob(self.extrefsearchpath)
        
        self.extrefpath = nuke.File_Knob("extrefpath", "Ref Path")
        self.addKnob(self.extrefpath)
        
        self.dividerthree = nuke.Text_Knob("dividerthree", "")
        self.addKnob(self.dividerthree)
        
        self.cdloffset = nuke.Color_Knob("cdloffset", "Offset")
        self.addKnob(self.cdloffset)
        self.cdloffset.setFlag(nuke.DISABLED)
        
        self.cdlslope = nuke.Color_Knob("cdlslope", "Slope")
        self.addKnob(self.cdlslope)
        self.cdlslope.setFlag(nuke.DISABLED)
                        
        self.cdlpower = nuke.Color_Knob("cdlpower", "Power")
        self.addKnob(self.cdlpower)
        self.cdlpower.setFlag(nuke.DISABLED)
                
        self.cdlsaturation = nuke.Double_Knob("cdlsaturation", "Saturation")
        self.addKnob(self.cdlsaturation)
        self.cdlsaturation.setFlag(nuke.DISABLED)

        self.dividerfour = nuke.Text_Knob("dividerfour", "")
        self.addKnob(self.dividerfour)
        
        self.updateDesc()
        return nukescripts.PythonPanel.showModalDialog( self ), self.cdlcorrectionid.value()
        
    def updateDesc(self):
        """Utility function to update parser instance with any required data, and to coax it
        into dynamically updating its colourcorrectionvalues dict with any newly selected 
        colour correction ID data.
        
        It updates the parser object with info regarding the current search scheme, and search 
        path. Used if the selected ID is an external ref, otherwise of no significance.
        
        """
        
        # Update parser instance with relevant data.
        self.parser.searchStrat=self.extrefsearchpath.getValue()
        self.parser.specifiedPath=self.extrefpath.getValue()
        self.parser.parseElement(self.cdlcorrectionid.value())
        
        # Set the panels CDL param description/values knobs based on the currently held 
        # parser values.
        o=self.parser.cdlcorrectionvalues[self.cdlcorrectionid.value()]
        self.cdlcorrectiondesc.setValue(o["description"])
        self.cdloffset.setValue([o["offsetR"], o["offsetG"], o["offsetB"]])
        self.cdlslope.setValue([o["slopeR"], o["slopeG"], o["slopeB"]])
        self.cdlpower.setValue( [o["powerR"], o["powerG"], o["powerB"]])
        self.cdlsaturation.setValue( o["saturation"])
        
        # Set the panels knobs visibility depending on if the currently selected ID
        # is an internal or external reference. For ext refs, show search strategy 
        # and, if necessary, path knobs.
        if o["type"] == "int":
            self.dividertwo.setVisible(False)
            self.extrefsearchpath.setVisible(False)
            self.extrefpath.setVisible(False)
            self.dividerthree.setVisible(False)
        else:
            self.dividertwo.setVisible(True)
            self.extrefsearchpath.setVisible(True)
            if self.extrefsearchpath.getValue()==2.0:
                self.extrefpath.setVisible(True)
            else:
                self.extrefpath.setVisible(False)
            self.dividerthree.setVisible(True)
        return

class CDLImporter() :
    """Parent class for XML CDL importers (CCC & CDL filetypes).
    
    Implements a number of common utility functions used by both file importers.
    
    """
    
    
    def __init__( self ):
        self.cdlcorrectionvalues={}
        # Define default XML CDL namespace. Note this is redefined in the parser class if
        # a different one is encountered.
        self.ASCCDLNS = "{urn:ASC:CDL:v1.01}"
        self.cdlcorrectionid = ""
        self.tree = None
        self.cdlfilename = ""
        # Define the CDL correction part only values, so that we can figure out which parts of the parser's cdlcorrectionvalues
        # dict relate to identification, description, tags, etc and which related to the underlying correction
        self.correctionValuesOnly = ("offsetR", "offsetG", "offsetB", "slopeR", "slopeG", "slopeB", \
                                                            "powerR", "powerG", "powerB", "saturation")
        
    def setCDLValues( self ):
        """Sets the CDL params on the current 'thisNode' (ie the node from which the function is called)
        based on the current parsers self.cdlcorrectionvalues dict, for the self.cdlcorrectionid
        
        Make sure both self.cdlcorrectionid self.correctionvalues(self.cdlcorrectionid) are defined before
        calling. Dict should contain at least all the cdl transfer function characteristics.
        
        """
        
        #set 3Way params. Child classes should set self.cdlcorrectionvalues up, and set self.cdlcorrectionid to the string of the key.
        nuke.thisNode()["cdloffset"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["offsetR"],0)
        nuke.thisNode()["cdloffset"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["offsetG"],1)
        nuke.thisNode()["cdloffset"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["offsetB"],2)

        nuke.thisNode()["cdlslope"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["slopeR"],0)
        nuke.thisNode()["cdlslope"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["slopeG"],1)
        nuke.thisNode()["cdlslope"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["slopeB"],2)

        nuke.thisNode()["cdlpower"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["powerR"],0)
        nuke.thisNode()["cdlpower"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["powerG"],1)
        nuke.thisNode()["cdlpower"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["powerB"],2)

        nuke.thisNode()["cdlsaturation"].setValue(self.cdlcorrectionvalues[self.cdlcorrectionid]["saturation"],0)
        return

    def getXMLTree( self ):
        """Extracts an element tree object to self.tree from the file defined in self.cdlfilename.
        
        Ensure cdlfilename exists before calling. Will throw exceptions on unparseable file. Also
        remaps the self.ASCCDLNS string to the namespace defined. This is nasty, and should probably
        use a heriarchy of parser classes for each different namespace.
        Needs to do xml validation pass as well.
        
        """
         
        try:
            self.tree = ET.parse(self.cdlfilename)
        except Exception, inst:
            print "Unexpected error opening %s: %s" % (self.cdlfilename, inst)
            return
        
        doc = self.tree.getroot()

        #do something bad to get the namespace (should really be handling these separately for when the asc cdl spec updates).
        try:
            self.ASCCDLNS = str(doc.tag)[str(doc.tag).index("{"):str(doc.tag).index("}")+1]
        except ValueError:
            nuke.tprint("badly formatted xml, no namespace. Attempting to continue without namespace. Unlikely to work.")
            self.ASCCDLNS = ""
        
        return
        
    def parseColorCorrectionIDs( self, rootelem ):
        """Grabs ColorCorrection and ColorCorrectionRef children of rootelem, and bungs IDs into colourcorrectionvalues
        dict keys, with associated internal or external (ref) information as under a 'type' tag in the corresponding
        colourcorrectionvalue value dict.
        
        ColorCorrection tags define a CDL transfer function contained within that XML element.
        ColorCorrectionRef tags define a CDL transfer function by ID, which is contained within some other CCC file. Ref
        elements should theoretically only be present in CDL files.
        
        Rootelem should be a element tree element, with all desired colour correction and colour correction ref tags as
        direct children.
        
        Writes error message to terminal if no colourcorrection/ref elements found.
        
        """
        
        iter=rootelem.findall(self.ASCCDLNS+"ColorCorrection")
        iterref=rootelem.findall(self.ASCCDLNS+"ColorCorrectionRef")
        if iter==0 and iterref==0:
            nuke.tprint("No colour corrections found in file")
        
        cdlcorrectionlist=[]
        cccname=0
         
        # Get internal CCC container ID's
        for element in iter:
            if element.keys():
               for name, value in element.items():
                    cccname=value
                                   
            self.cdlcorrectionvalues[cccname]=dict({"type": "int"})

        # Get external CCC container ID's (theoretically should only be present in CDLs)
        for element in iterref:
            if element.keys():
               for name, value in element.items():
                    cccname=value
                                   
            self.cdlcorrectionvalues[cccname]=dict({"type": "ext"})
        return

    def parseColorCorrectionElement( self, rootelem, cccname ):
        """Pulls CDL transfer function params by searching the tree contained under rootelem for a ColourCorrection
        element identifed by cccname and inserts them into self.colourcorrectionvalues[cccname], retaining only the type
        entry from any pre-existing dictionary entry found under ...[cccname].
        
        Returns true if successful and false if not. Sets colourcorrectionvalues regardless, with transfer function unity if false.
        
        """
        
        # Grab all ColorCorrection elements and see if they have the id of cccname.
        # Would be nice to use the xpath element tree search options, but the python 2.5 bundled elementtree is 1.2,
        # which doesn't support it. Pah.
        iter = rootelem.findall(self.ASCCDLNS+"ColorCorrection")
        for element in iter:
                if element.keys():
                    for name, value in element.items():
                        if value==cccname:
                        
                            # Now element should be the item we want, in which case set the CDL transfer function data
                            # to default, incase various elements are not contained in the underlying SOP/Sat nodes.
                            cccvalues={"offsetR":0.0, "offsetG":0.0, "offsetB":0.0, "slopeR":1.0, "slopeG":1.0, "slopeB":1.0,\
                                                        "powerR":1.0, "powerG":1.0, "powerB":1.0, "saturation":1.0, "description":""}
                            
                            # Construct the first part of the transfer function description, by grabbing overall description
                            # data from parent elements children with the string "Description" in their tag names.
                            for desc in self.tree.getroot():
                                if desc.tag.find("Description") is not -1:
                                    try:
                                        cccvalues["description"] += str(desc.tag).strip() + ": " + str(desc.text).strip() + "\n"
                                    except AttributeError:
                                        cccvalues["description"] += str(desc.tag).strip() + ": No description" + "\n"
                                                                    
                            for desc in element:
                                if desc.tag.find("Description") is not -1:
                                    try:
                                        cccvalues["description"] += str(desc.tag).strip() + ": " + str(desc.text).strip() + "\n"
                                    except AttributeError:
                                        cccvalues["description"] += str(desc.tag).strip() + ": No description" + "\n"
                                                                    
                            # Get the individual transfer function node descriptions and values and add to the current cccvalue dict.
                            SOPNode = element.find(self.ASCCDLNS+"SOPNode")
                            if SOPNode != None:
                                # Get all offset/slope/power values
                                try:
                                    cccvalues["description"] += "\n SOPNode:" + SOPNode.find(self.ASCCDLNS+"Description").text + " " 
                                except AttributeError:
                                    cccvalues["description"] += "\n SoOPNode: No description"
                                    
                                for node in ['Offset', 'Slope', 'Power']:
                                    nodeL = node.lower()
                                    correctionNode=SOPNode.find(self.ASCCDLNS+node)
                                    if correctionNode != None:
                                        r, g, b = correctionNode.text.lstrip().rstrip().split(' ')
                                        cccvalues[nodeL+"R"] = float(r) 
                                        cccvalues[nodeL+"G"] = float(g)
                                        cccvalues[nodeL+"B"] = float(b)
                                    
                            
                            SatNode = element.find(self.ASCCDLNS+"SatNode")
                            if SatNode !=None:
                                # Get saturation values
                                try:
                                    cccvalues["description"] += "\n SatNode:" + SatNode.find(self.ASCCDLNS+"Description").text + " " 
                                except AttributeError:
                                    cccvalues["description"] += "\n SatNode: No description "
                                
                                correctionNode=SatNode.find(self.ASCCDLNS+"Saturation")
                                if correctionNode != None:
                                    cccvalues["saturation"] = float(correctionNode.text.lstrip().rstrip())
                            cccvalues["type"]=self.cdlcorrectionvalues[cccname]["type"]
                            self.cdlcorrectionvalues[cccname]=cccvalues
                            return True
        
        # No corresponding ColourCorrection element found, so set the colourcorrectionvalues for the id to defaults, with description
        # giving some information about lack of cc element found.
        cccvalues={"offsetR":0.0, "offsetG":0.0, "offsetB":0.0, "slopeR":1.0, "slopeG":1.0, "slopeB":1.0,\
                "powerR":1.0, "powerG":1.0, "powerB":1.0, "saturation":1.0, "description":"No ColorCorrection data found for " + cccname}
        cccvalues["type"]=self.cdlcorrectionvalues[cccname]["type"]
        self.cdlcorrectionvalues[cccname]=cccvalues
        return False