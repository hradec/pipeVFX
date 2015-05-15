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

#dw_GlobalDirReadSetup.py  v1.1
#
#Written by:  Dave Windhorst    08/25/2012
#                               08/22/2012  v1.0
#
#Script contains 3 main functions to access and use:
#
#		globalDirSep()
#		gdReadSel()
#		gdReadSetup()
#
#
#
#
#
#


#BEGIN SCRIPT


#GlobalDirectoryNode.py  v1.1
#
#Written by:  Dave Windhorst    08/25/2012
#                               08/21/2012  v1.0
#
#Creates a NoOp node with a file directory used for association with Read Nodes. Requires user to manually
#enter association code (below) or use the GD-Read Select or GD-Read Setup scripts provided. Multiple Read
#nodes can be associated to one GLOBAL_DIRECTORY.  GLOBAL_DIRECTORY nodes can be nested to mimic OS folder
#structures inside the Nuke DAG (must associate to Read node first, then work up the 'tree' if using auto 
#scripts)
#
#NOTE:  User can manually associate to Read nodes using the following:
#
#		[value GLOBAL_DIRECTORY#.projDir]   where # is the number in the name of the desired GD node 
#
#
#
#Example:  <GLOBAL_DIRECTORY1> to be associated with <Read1>
#
#Before association:
#
#<GLOBAL_DIRECTORY1> proj dir = 'C:/Users/Dave/Projects/'
#
#<Read1> file = 'C:/Users/Dave/Projects/IM/shot_001/shot_001.%04d.exr'
#
#
#After association:
#
#<Read1> file = '[value GLOBAL_DIRECTORY1.projDir]IM/shot_001/shot_001.%04d.exr'
#
#


#Required modules imported
import nuke


#Create GLOBAL_DIRECTORY node
def globalDirSep():
	#Create 'GLOBAL_DIRECTORY' Node (NoOp Node)
	dirNode = nuke.nodes.NoOp()

	#Create 'directory' tab
	projDirTab = nuke.Tab_Knob("directory")

	#Create File Directory knob
	projDirKnob = nuke.File_Knob("projDir","proj dir")
	projDirKnob.setTooltip("Set main project directory")

	#Create Divider Knob
	projDivKnob = nuke.Text_Knob("","","")

	#Create 'Written by' Knob
	projByName = "GLOBAL_DIRECTORY"
	projByVer = "v1.1"
	projByAut = "Dave Windhorst"
	projByDate = "08/25/2012"
	projByText = projByName + " : " + projByVer + "\n\nWritten by: " + projByAut + "    " + projByDate
	projByKnob = nuke.Text_Knob("","", projByText)

	#Store all knobs into array and add each to 'GLOBAL_DIRECTORY' Node
	dirKnobArray = [projDirTab, projDirKnob, projDivKnob, projByKnob]

	for i in dirKnobArray:
		dirNode.addKnob(i)

	#Check NoOp nodes to see if 'GLOBAL_DIRECTORY' Nodes exist or not (if so, count them and add one to name number)
	#IMPORTANT! This allows multiple 'GLOBAL_DIRECTORY' Nodes to exist within the same Nukescript and DAG!
	selNoOp = nuke.allNodes("NoOp")
	finNum = 0
	for i in selNoOp:
		if "GLOBAL_DIRECTORY" in i['name'].value():
			tempNum = int ( i['name'].value().split( "GLOBAL_DIRECTORY" )[-1] )
			if tempNum > finNum:
				finNum = tempNum
	finNum = finNum + 1
	#Change NoOp name to "GLOBAL_DIRECTORY#" and set the label to the file directory value
	dirName = "GLOBAL_DIRECTORY" + str(finNum)
	dirNode["name"].setValue( dirName )
	dirNode["label"].setValue("[value " + dirName + ".projDir]")
	dirNode["hide_input"].setValue(1)
	
	#Show properties panel for node
	dirNode.showControlPanel()

	
#gdReadSel.py  v1.1
#
#Written by:  Dave Windhorst    08/25/2012
#                               08/22/2012  v1.0
#
#Associates selected Read nodes to selected GLOBAL_DIRECTORY node. Requires a Read node and GLOBAL_DIRECTORY
#node to be selected. GLOBAL_DIRECTORY node's directory must be entirely within the Read node directory; however, 
#the Read node directory can descend into subfolders of root directory.
#
#NOTE:  Similar to the GD-Read Setup script, but only works on existing nodes in Nuke DAG.
#
#


#Required modules imported
import nuke
import os
import re
import threading
import time


#Manually associate files not fixed by auto selection commands
def getSeq( gdInject, gdDir, tempReadDir, baseFile, fixNum, curNum, i ):
	#Display error and ask if user would like to try and connect association manually
	askMsg = "File '" + baseFile + "' does not associate to selected GD Node (either missing subfolders or does not exist in directory).\n\nSelected GD Directory: " + gdDir + "\n\n\nRead Directory: " + tempReadDir + "\n\n\nAttempt to connect manually?     (ERROR: " + curNum + " of " + fixNum + ")"
	if nuke.ask( askMsg ):
		#If user selects yes, user is given Sequence Dialog box to locate file
		seqPath = nuke.getClipname( "Connect Read File: " + baseFile )
		
		#Isolate portion of directory not found in root directory or base filename
		seqMain = seqPath.split( gdDir )[-1]
		seqMid = seqMain.split( "/" )
		del seqMid[-1]
		seqMid = "/".join( seqMid )
		seqMid = seqMid + "/"
		
		#Rebuild new directory to include GD node root, mid isolated directory, and filename
		newFile = gdInject + seqMid + baseFile
		
		#Set new file directory for read node
		i['file'].setValue( newFile )
	
	return
	

#Create association between files	
def associateFiles( gdDir, gdName, gdInject, rNode, numNode ):	 
	#If no errors occur, proceed with association...
	fixFiles = []
	for i in rNode:
		#if task.isCancelled():
		#	nuke.executeInMainThread( nuke.message, args=( "Cancelled Association" ) )
		#	break;
		#task.setProgress( int( float( rNode.index(i) + 1 )/numNode * 100 ) )
		#time.sleep( 0.1 )
		#Retrieve Read file directory
		readDir = i['file'].value()
		
		#Remove the base file name from the Read file directory
		tempReadDir = readDir.split( "/" )
		del tempReadDir[-1]
		tempReadDir = "/".join( tempReadDir )
		tempRootDir = gdDir.rstrip( "/" )
		
		seqMain = readDir.split( gdDir )[-1]
		seqMid = seqMain.split( "/" )
		del seqMid[-1]
		seqMid = "/".join( seqMid )
		seqMid = seqMid + "/"
		
		existDir = gdDir + seqMid
		
		if re.match( tempRootDir, tempReadDir ):
			if os.path.isdir( existDir ):
				#If the Read file root directory and GLOBAL_DIRECTORY directory match, create new directory with GD injection code and place in Read node
				baseFile = readDir.split( gdDir )[-1]
				newFile = gdInject + baseFile
				i['file'].setValue( newFile )
			else:
				fixFiles.append(i)
		else:
			#Else, store error files for manual connection prompt later
			fixFiles.append(i)
	
	if fixFiles != []:
		#If there are errors, find out how many require fixing
		fixNum = str( len( fixFiles ) )
		for i in fixFiles:
			#For each file that needs fixed, retrieve name and error number and send to user prompt
			curNum = str( fixFiles.index(i) + 1 )
			fixName = i['file'].value()
			baseFile = fixName.split( "/" )[-1]
			getSeq( gdInject, gdDir, tempReadDir, baseFile, fixNum, curNum, i )
			
			
#Associate selected Read nodes to selected GLOBAL_DIRECTORY node
def gdReadSel():
	#Filter out selected Read and NoOp (GLOBAL_DIRECTORY) nodes
	rNode = nuke.selectedNodes("Read")
	gdNode = nuke.selectedNodes("NoOp")
	
	#Begin Association...
	if not rNode or not gdNode:
		#If no Read or NoOp nodes are selected, error message 
		nuke.message( "Must select at least one GLOBAL_DIRECTORY \nnode and one Read node!" )
		
	elif "GLOBAL_DIRECTORY" not in gdNode[0]['name'].value():
		#If no NoOp node selected is a "GLOBAL_DIRECTORY" node, error message
		nuke.message( "Must select an existing \nGLOBAL_DIRECTORY node!" )
		
	elif len(gdNode) > 1:
		#If more than one "GLOBAL_DIRECTORY" node is selected, error message
		nuke.message( "Must select only one \nGLOBAL_DIRECTORY node!" )
		
	else:
		#Retrieve GLOBAL_DIRECTORY directory and name, then create injection code for Read file directory
		gdDir = gdNode[0]['projDir'].value()
		gdName = gdNode[0]['name'].value()
		gdInject = "[value " + gdName + ".projDir]"
		
		if gdDir == "":
			#If the GLOBAL_DIRECTORY directory is empty, error message
			nuke.message( "GLOBAL_DIRECTORY node directory is empty.\n\nCannot associate Read files with no directory specified." )
			
		else:
			#If no errors, send information to _associateFiles to generate connections and show progress
			numNode = len( rNode )
			fixFiles= associateFiles( gdDir, gdName, gdInject, rNode, numNode )
					
						
#gdReadSetup.py  v1.0
#
#Written by:  Dave Windhorst    08/21/2012
#
#
#Associates and/or creates Read and GLOBAL_DIRECTORY nodes. Users can create a new or use existing GLOBAL_DIRECTORY
#node to be associated. The user then specifies and creates the read node to be associated to the GLOBAL_DIRECTORY
#node.  GLOBAL_DIRECTORY node's directory must be entirely within the Read node directory; however, the Read node 
#directory can descend into subfolders of root directory.
#
#NOTE:  Similar to GD-Read Select script, but allows for multiple associations and node creations to occur.
#
#


#Required modules imported
import nuke
import nukescripts
import re
import os
import fnmatch


#Create Project Read Setup Panel to create/associate GLOBAL_DIRECTORY and Read nodes
class ProjectReadPanel( nukescripts.PythonPanel ):
    #BEGIN PANEL BUILD
	def __init__( self ): 
		nukescripts.PythonPanel.__init__( self, "GD-Read Setup", "com.davewindhorst.ProjectReadPanel" )
		self.setMinimumSize(600,300)
		
		#Create Node Selection List and Directory currently selected
		self.modeChoiceKnob = nuke.Enumeration_Knob( "modeChoice", "Node Select: ", self.listNoOp(0) )
		self.modeChoiceKnob.setTooltip( "Select which Node to derive path from or create a new one" )
		self.dirStrKnob = nuke.Text_Knob( "dirStr","\nDirectory: ", "\nNot Created Yet" )
		self.dirStrKnob.setEnabled( False )
		self.dirStrKnob.setTooltip( "Directory associated to currently selected GLOBAL_DIRECTORY node" )
		
		#Create GLOBAL_DIRECTORY File Directory knob
		self.projDirKnob = nuke.File_Knob( "projDir","GD Proj Dir:" )
		self.projDirKnob.setTooltip( "Set main project directory" )
		
		#Create GENERATE button for new GLOBAL_DIRECTORY Node
		self.dirBttnKnob = nuke.PyScript_Knob( "generate", "GENERATE GD NODE" )
		self.dirBttnKnob.setTooltip( "Generate a new GLOBAL_DIRECTORY node with the path directory specified" )
		
		#Create Read File Directory knob
		self.readDirKnob = nuke.File_Knob( "file", "File:" )
		self.readDirKnob.setTooltip( "Filename to read. For frame numbers, you can use # for each digit or use printf-style formatting (eg %04d)." )
		
		#Create GENERATE button for new READ node
		self.openBttnKnob = nuke.PyScript_Knob( "openFile", "GENERATE READ NODE" )
		self.openBttnKnob.setTooltip( "Open the file to be associated with the selected GLOBAL_DIRECTORY node" )
		
		#Create Divider Knobs
		self.projDivKnob = nuke.Text_Knob( "", "", "" )
		self.projDivKnob2 = nuke.Text_Knob( "", "", "" )
		self.projDivKnob3 = nuke.Text_Knob( "", "", "" )
		
		#Create 'Written by' Knob
		projByName = "GD-READ SETUP"
		projByVer = "v1.1"
		projByAut = "Dave Windhorst"
		projByDate = "08/25/2012"
		projByText = projByName + " : " + projByVer + "\n\nWritten by: " + projByAut + "    " + projByDate
		self.projByKnob = nuke.Text_Knob( "","", projByText )
		self.projByKnob.setFlag( nuke.STARTLINE )
		
		#Package knobs into array (panel build order)
		self.knobArray = [self.modeChoiceKnob, self.dirStrKnob, self.projDivKnob2, self.projDirKnob, self.dirBttnKnob, self.projDivKnob3, self.readDirKnob, self.openBttnKnob, self.projDivKnob, self.projByKnob]
		
		#Add Knobs to Panel
		for i in self.knobArray:
			self.addKnob(i)
	
	#END PANEL BUILD

	
	#Create list of GLOBAL_DIRECTORY nodes (If type=0, return node names, else return the nodes themselves)	
	def listNoOp( self, type ):
		#Filter select NoOp (GLOBAL_DIRECTORY) nodes
		selNoOp = nuke.allNodes( "NoOp" )
		selProjDir = []
		
		if type == 0:
			#If type=0, return node names
			for i in selNoOp:
				if "GLOBAL_DIRECTORY" in i['name'].value():
					selProjDir.append(i['name'].value())
			
		else:
			#Return nodes
			for i in selNoOp:
				if "GLOBAL_DIRECTORY" in i['name'].value():
					selProjDir.append(i)
		
		#Add CREATE NEW GD NODE to node list
		selProjDir.append("Create New GD Node")
		selProjDir = selProjDir[::-1]
		
		return selProjDir		
	
	
	#Retrieve directory for selected GLOBAL_DIRECTORY node if it exists
	def dispDir( self, nodes ):
		#Retrieve GLOBAL_DIRECTORY names existing and index of currently selected node
		listNames = self.listNoOp(0)
		selIndex = listNames.index( nodes )
		
		if selIndex == 0:
			#If GLOBAL_DIRECTORY node does not exist in the DAG yet
			selStrDir = "Not Yet Created"
		else:
			#If GLOBAL_DIRECTORY node exists, display it's directory value
			listNodes = self.listNoOp(1)
			selNodeDir = listNodes[selIndex]
			selStrDir = selNodeDir["projDir"].value()
			
		return selStrDir
	
	#Create "GLOBAL_DIRECTORY" Node in Nuke DAG
	def globalDir( self, pathDir ):
		#Create 'GLOBAL_DIRECTORY' Node (NoOp Node)
		dirNode = nuke.nodes.NoOp()

		#Create 'directory' tab
		projDirTab = nuke.Tab_Knob("directory")

		#Create GLOBAL_DIRECTORY File Directory knob
		projDirKnob = nuke.File_Knob("projDir","proj dir")
		projDirKnob.setTooltip("Set main project directory")

		#Create Divider Knob
		projDivKnob = nuke.Text_Knob("","","")

		#Create 'Written by' Knob
		projByName = "GLOBAL_DIRECTORY"
		projByVer = "v1.1"
		projByAut = "Dave Windhorst"
		projByDate = "08/25/2012"
		projByText = projByName + " : " + projByVer + "\n\nWritten by: " + projByAut + "    " + projByDate
		projByKnob = nuke.Text_Knob("","", projByText)

		#Store all knobs into array and add each to 'GLOBAL_DIRECTORY' Node
		dirKnobArray = [projDirTab, projDirKnob, projDivKnob, projByKnob]

		for i in dirKnobArray:
			dirNode.addKnob(i)

		#Check NoOp nodes to see if 'GLOBAL_DIRECTORY' Nodes exist or not (if so, count them and add one to name number)
		#IMPORTANT! This allows multiple 'GLOBAL_DIRECTORY' Nodes to exist within the same Nukescript and DAG!
		selNoOp = nuke.allNodes("NoOp")
		finNum = 0
		for i in selNoOp:
			if "GLOBAL_DIRECTORY" in i['name'].value():
				tempNum = int ( i['name'].value().split( "GLOBAL_DIRECTORY" )[-1] )
				if tempNum > finNum:
					finNum = tempNum
		finNum = finNum + 1
		#Change NoOp name to "GLOBAL_DIRECTORY#" and set the label to the file directory value
		dirName = "GLOBAL_DIRECTORY" + str(finNum)
		dirNode["name"].setValue( dirName )
		dirNode["label"].setValue("[value " + dirName + ".projDir]")
		dirNode["hide_input"].setValue(1)
		dirNode["projDir"].setValue( pathDir )
		
		return
	
	
	#Retrieve File Sequence information from specified read file
	def getFileSeq( self, newFile ):
		#Create temporary root directory from full directory specified
		tempDir = newFile.split( "/" )
		del tempDir[-1]
		dirPath = "/".join(tempDir)
		
		#Create base filename from full directory specified
		rootFile = newFile.split( "/" )[-1]
		basePath = rootFile.split( "." )[0]
			
		readFiles = []
		
		#Traverse OS directory to find all image files matching the specified filename and store to array
		for root, dirnames, filenames in os.walk( dirPath ):
			for fileSequence in fnmatch.filter(filenames, basePath + '*'):
				readFiles.append(fileSequence)
		
		#Retrieve file extension specified and file extension from image array
		getExt = newFile.split( "." )[-1]
		finReadFiles = []
		
		for i in readFiles:
			checkExt = i.split( ".")[-1]
			if checkExt == getExt:
				#If extensions specified and retrieved match, add to final array, else discard
				finReadFiles.append(i)
		
		#BEGIN DEBUG STATEMENT
		#print( "%s sequence found: \n\t%s" % ( len(finReadFiles), "\n\t" .join( finReadFiles ) ) )
        #END DEBUG STATEMENT
		
		#Check if image is single or in a sequence, if single, specify first and last frames as 1
		if len(finReadFiles) == 1:
			first = 1
			last = 1
		else:
			#Rebuild File Name structure for image sequence
			firstString = re.findall( r'\d+', finReadFiles[0] )[-1]
			padding = len (firstString)
			paddingStr = "%02s" % padding
			first = int( firstString )
			last = int( re.findall( r'\d+', finReadFiles[-1] )[-1] )
			ext = os.path.splitext( finReadFiles[0] )[-1]
		
		#Store file sequence information to return
		fileInfo = [first, last, getExt]
		
		return fileInfo
	
	
	#Create Callbacks for when knobs are changed
	def knobChanged( self, knob ):
		#If GD Node Selection or GENERATE GD button have been used
		if knob in (self.modeChoiceKnob, self.dirBttnKnob):
			if knob == self.dirBttnKnob:
				#If generating a new GD node, retrieve directory value, create node, and update node selection to the new node
				newDir = self.projDirKnob.value()
				self.globalDir( newDir )
				newSelNode = self.listNoOp(0)
				self.modeChoiceKnob.setValues( newSelNode )
				selNodeNum = self.modeChoiceKnob.numValues() - 1
				
				#BEGIN DEBUG STATEMENT
				#self.modeChoiceKnob.setFlag( nuke.KNOB_CHANGED_RECURSIVE )
				#END DEBUG STATEMENT
				
				self.modeChoiceKnob.setValue( selNodeNum )
				
				#BEGIN DEBUG STATEMENT
				#self.modeChoiceKnob.clearFlag( nuke.KNOB_CHANGED_RECURSIVE )
				#END DEBUG STATMENT
			
			#Display currently selected GD node's directory value
			selDirVal = self.modeChoiceKnob.value()
			selDispDir = "\n" + self.dispDir( selDirVal )
			self.dirStrKnob.setValue( selDispDir )
			
			#Create array of knobs to be shown/hidden based on mode selection
			newNodeKnobs = [self.projDivKnob2, self.projDirKnob, self.dirBttnKnob]
			
			#Show/Hide knbs based on mode selection
			if selDirVal != "Create New GD Node":
				for i in newNodeKnobs:
					i.setVisible( False )
				
			else:
				for i in newNodeKnobs:
					i.setVisible( True )
		
		#If generate Read button is used
		if knob == self.openBttnKnob:
			
			#Retrieve GD node and Read File directory values
			selDirVal = self.modeChoiceKnob.value()
			rootDir = self.dispDir( selDirVal )
			newFile = self.readDirKnob.value()
			
			if newFile == "":
				#If read file directory is empty, error message
				nuke.message( "Please specify a file to read in!" )
			else:
				
				#Create temporary directories specified and associated to match
				tempReadDir = newFile.split( "/" )
				del tempReadDir[-1]
				tempReadDir = "/".join( tempReadDir )
				tempRootDir = rootDir.rstrip( "/" )
				
				if re.match( tempRootDir, tempReadDir ):
					#If directories match, retrieve file sequence information
					fileSeqArray = self.getFileSeq( newFile )
					
					#Create base filename
					baseFile = newFile.split( rootDir )[-1]
					
					#Create injection code to associate GD node and Read node
					finFileName = "[value " + selDirVal + ".projDir]" + baseFile
					
					#Create Read node and change file directory to the associated directory
					readNode = nuke.nodes.Read()
					readNode['file'].fromUserText( newFile )
					readNode['file'].setValue( finFileName )
					
					#Check to see if Read file is a .mov or .avi
					nonImgSeq = ["mov", "avi"]
					if fileSeqArray[2] not in nonImgSeq:
						#If Read file is not a .mov or .avi, specify file sequence information (first, last, origfirst, origlast)
						readNode['first'].setValue( fileSeqArray[0] )
						readNode['last'].setValue( fileSeqArray[1] )
						readNode['origfirst'].setValue( fileSeqArray[0] )
						readNode['origlast'].setValue( fileSeqArray[1] )			
				else:
					#If Read directory and associated directory do not match, error message
					nuke.message( "Selected GD Node Directory and \nspecified Read File Directory do not match!\n\nCannot make association." )
			
			
#Create modal dialog panel in Nuke	
def gdReadSetup():
	return ProjectReadPanel().showModalDialog()	
