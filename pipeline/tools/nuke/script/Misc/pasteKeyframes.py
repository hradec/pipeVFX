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

import nuke, os

global keysList
keysList=[]
global exclusionList
exclusionList=['Tracker3', 'Viewer', 'dot','CameraTracker1_0','RotoPaint','Roto','Root']


'''Swap Methods'''
def isNodeAnimated(node):
    return bool(int(node['indicators'].value()) & 1)

''' alternative method

def isNodeAnimated(node):
  return bool(nuke.runIn(node.fullName(), "nuke.expression('keys')")) 
'''


def getOffset(verbose=False):
    numViews=len(nuke.views())
    #sn=nuke.selectedNodes()
    #s=len(sn)
        
    firstKeyFound=0
    offset=0
    keysList=[]

    nuke.root().begin()   
    for node in nuke.allNodes():
        if node.Class() not in exclusionList:
            nodeAnimated=isNodeAnimated(node)
            print node['name'].value(), nodeAnimated
            if nodeAnimated :
                #loop through and find largest offset
                for knob in node.knobs().values():
                    if knob.isAnimated():
                        try:
                            aSize = knob.arraySize()
                            for index in range(aSize):
                                  for vues in range(numViews+1):
                                    anim = knob.animation(index,vues)
                                    numKeys=anim.size()
                                    if numKeys:
                                        for i in range(numKeys):
                                            keySelected= (anim.keys()[i].selected)
                                            if keySelected:
                                                firstKeyFound+=1
                                                keyVals= (anim.keys()[i].x, anim.keys()[i].y)
                                                if firstKeyFound==1:
                                                    offset=nuke.frame()-keyVals[0]
                                                else:
                                                    foundKey=nuke.frame()-keyVals[0]
                                                    if foundKey>offset:
                                                        offset=foundKey
                                                    if verbose:
                                                        print (foundKey,offset)     
                        except:
                            continue
        else:
            print ('Skipped Node ' + str(node['name'].value()))
        if verbose:
            print (' : FirstKeyFound is '+ str(firstKeyFound) + ' : offset is' + str(offset))

    return (offset)
							
							
                                                                               
def pasteSelected(verbose=False):
    numViews=len(nuke.views())
    offset=getOffset(False)
    keysList=[]
    
    nuke.root().begin()
    for node in nuke.allNodes():
        if node.Class() not in exclusionList:
            nodeAnimated=isNodeAnimated(node)        
            if nodeAnimated :
                                                                           
                for knob in node.knobs().values():
                    if knob.isAnimated():
                        try:
                            aSize = knob.arraySize()
                            for index in range(aSize):
                                  for vues in range(numViews+1):
                                    anim = knob.animation(index,vues)
                                    numKeys=anim.size()
                                    if numKeys:
                                        #step through the keys - check if they are selected then paste the values from timebar onwards
                                        for i in range(numKeys):
                                            keySelected= (anim.keys()[i].selected)
                                            if keySelected:
                                                keyVals= (anim.keys()[i].x, anim.keys()[i].y)
                                                if verbose:
                                                    print ('keySelected: '+str(keySelected)+' keyvalues: '+str(keyVals)+' offset: '+str(offset))
                                                anim.setKey(keyVals[0]+offset,keyVals[1])
                                                keysList.append((keyVals[0]+offset,keyVals[1]))
                        except:
                            continue

def copyKeys(verbose=False):
  
	tmpDir = os.environ['NUKE_TEMP_DIR']+'/'
	if verbose:
	  print ('tempDir is '+tmpDir)
	numViews=len(nuke.views())
	keysList=[]

	for node in nuke.allNodes():
	    nodeAnimated=isNodeAnimated(node)        
	    if nodeAnimated :
                                                                       
		for knob in node.knobs().values():
			if knob.isAnimated():
				aSize = knob.arraySize()
				for index in range(aSize):
				      for vues in range(1,numViews+1):
					anim = knob.animation(index,vues)
					try:
						numKeys=anim.size()
					except:
						continue
					if numKeys:
						#step through the keys - check if they are selected then paste the values from timebar onwards
						for i in range(numKeys):
							keySelected= (anim.keys()[i].selected)
							if keySelected:
								keyVals= (anim.keys()[i].x, anim.keys()[i].y)
								if verbose:
									print ('keySelected: '+str(keySelected)+' keyvalues: '+str(keyVals))
								keysList.append((keyVals[0],keyVals[1]))
							i+=1
	if verbose:
	  nuke.message(str(keysList))
	return (keysList)


def pasteKeys():
    (keysList)=copyKeys(verbose=True)
    if keysList:
	nuke.message(str(keysList)+'\nkeys copied - rest to be written')
 
