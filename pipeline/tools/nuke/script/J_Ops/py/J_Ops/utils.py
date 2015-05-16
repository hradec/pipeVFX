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

#  utils.py
#  J_Ops
#
#  Created by Jack Binks on 13/01/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.

import nuke
import os, webbrowser

def createNode(name):
    """Convience function, wrapping standard Nuke createNode with a little more helpful error messages.
    
    If the function is unable to find the node in question it pops up a Nuke dialogue with a few possible
    root causes.
    
    """
    
    try:
        nuke.createNode(name)
    except RuntimeError:
        msg="""
        Node creation failed with runtime error.
        This is usually down to one of the following:
        
        1) You tried to create a node not currently 
        in the NUKE_PATH.
        
        2) The binary of the plug-in found is not
        compatible with the version, or 32/64bit-
        ness of Nuke/OS. Check you have the
        right version installed.
        """
        nuke.message(msg)

def launchHelp():
    """J_Ops in gui help system. Searches for help file in the Nuke
    plug-in path, and if found fires up web browser pointing to it.
    
    Failure to find the file results in a Nuke error message.
    
    """
    
   
    for possible in nuke.pluginPath():
        if possible.find("J_Ops"):
            url = os.path.expanduser(possible[0:possible.rfind("J_Ops")+6]) + "docs/index.html"
            if os.path.exists(url): 
                break
    try:
        webbrowser.open("file://"+url)
    except:
        nuke.message("J_Ops install/browser not found. Docs can be found in the directory\
                            you selected when installing. If not, it's time for a reinstall.")         