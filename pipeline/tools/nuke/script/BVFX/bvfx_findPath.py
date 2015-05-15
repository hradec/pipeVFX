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

# Version 1.11
#
# For greeting, bugs, and requests email me at mborgo[at]boundaryvfx.com
#
# If you like it and use it frequently, please consider a small donation to the author,
# via Paypal on the email mborgo[at]boundaryvfx.com

#===============================================================================
# This script is an extension/inspired by the work of my friend Dubi, original at http://www.nukepedia.com/python/misc/findpath/
#===============================================================================

#===============================================================================
# Version Log
# v1 (2012/11/23)
# All Nodes that own a file propertie will be searched
# Single os.walk for faster searchs
# Changed the %0d to a more generic search
# Added task progress that can cancel the search
# Added loop breaks to speed script velocity
#===============================================================================

#===============================================================================
# TO DO LIST
# Options to make paths relative from script location
#===============================================================================


# Copyright (c) 2012, Magno Borgo
# All rights reserved.
#
# BSD-style license:
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Magno Borgo or its contributors may be used to
#       endorse or promote products derived from this software without
#       specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
#PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
#BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
#OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
#OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
#EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import nuke
import fnmatch
import os
import time

def bvfx_findPath(write=True):

	
	basePath = nuke.getFilename('Select Directory to Search assets', " ", type = 'open')
	start_time = time.time()
	if basePath != None:
		path = os.path.join(basePath)
	else:
		finalmessage = "No folder was selected!"
	finalmessage = ""
	newfindname = ""
	cancel = False	

	errors = [node for node in nuke.allNodes() if node.error() == True]
	nodes = [node for node in errors for n in range(node.getNumKnobs()) if node.knob(n).name() == "file"]
	
	#===========================================================================
	# write parameter will define if write nodes should be changed or not 
	#===========================================================================
	if not write:
		nodes = [node for node in nodes if node.Class() != "Write"]
		
	
	if len(nodes) == 0:
		finalmessage = "You don't have any nodes with read file errors!"
	else:
		task = nuke.ProgressTask('Searching files in path\n' + str(path))
		nodecount = 0

		#=======================================================================
		# generate a list with masked search names
		#=======================================================================
		nodefilenames = []
		
		for node in nodes:
			findFile = ""
			oldpath = node['file'].value()
			oldfilename = os.path.basename(oldpath)
			fileExt = oldfilename[-3:]
			fileName = oldfilename[:-4]
			if fileName.find("%") != -1:
				fileName = fileName[:fileName.find("%")+1]
				newfindname = fileName.replace("%","*")
			else:
				newfindname = fileName
			findFile = newfindname + "." + fileExt
			nodefilenames.append([node,findFile])
			
		for r,d,f in os.walk(path):
			cancelwalk = False
			#===============================================================
			# user can Cancel the task if its taking too long
			#===============================================================
			if task.isCancelled():
				cancel = True
				break				
			if cancel:
				break
			if len(nodefilenames) == 0:
				break
				
			#===============================================================================
			# simple string formatting for progress window
			#===============================================================================
			if len(r)> 20:
				rstring = r[:20]+"..."+r[-20:]
			else:
				rstring = r
			#===============================================================================
			task.setMessage('Searching ' + rstring )    
			subpath = r
			for file in os.listdir(subpath):
				#===============================================================
				# user can Cancel the task if its taking too long
				#===============================================================
				if task.isCancelled():
					cancel = True
					break				
				if cancel:
					break
				#===============================================================
				
				for findFile in nodefilenames:
					if fnmatch.fnmatch(file, findFile[1]):
						reformatPath = subpath.replace("\\","/")
						oldpath = findFile[0]['file'].value()
						oldfilename = os.path.basename(oldpath)
						findFile[0]['file'].setValue(reformatPath +'/'+ oldfilename)
						finalmessage = findFile[0].name() + " - " + " Found Successfully!\n" + finalmessage
						nodefilenames.remove(findFile)
						nodecount +=1

			task.setProgress(int(float(nodecount)/len(nodes) * 100  ))


		if len(nodefilenames) > 0:
			for node in nodefilenames:
				finalmessage = node[0].name() +" - " +  " Not Found!\n" + finalmessage
				
			
	print "Time elapsed:",time.time() - start_time, "seconds"
	nuke.message(finalmessage)


if __name__ == '__main__':
	bvfx_findPath(False)