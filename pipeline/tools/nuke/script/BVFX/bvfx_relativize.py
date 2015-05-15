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

# Version 1.1
#
# For greeting, bugs, and requests email me at mborgo[at]boundaryvfx.com
#
# If you like it and use it frequently, please consider a small donation to the author,
# via Paypal on the email mborgo[at]boundaryvfx.com

#===============================================================================
# This script will add a TCL expression to make all the file paths relatives in the script
# and keep original TCL/python functions in the file names
#===============================================================================

#===============================================================================
# Version Log
# v1 (2012/11/23)
# v1.1 (2012/12/19)
# Fixed script to work on windows
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

import nuke, os, platform

def  bvfx_relativize():
    scriptpath = nuke.root().knob("name").getValue()
    nodes = [node for node in nuke.allNodes() for n in range(node.getNumKnobs()) if node.knob(n).name() == "file"]

    for node in nodes:
        if  nuke.filename(node) != None: # some nodes have file but no input
            try: #if win path is not on the same drive letter
                relpath=os.path.relpath(nuke.filename(node),scriptpath)
    
                if platform.system() in ( 'Windows', 'Microsoft' ):
                    separator = "\\" 
                else:
                    separator = "/"
                originalfilename = node['file'].getValue() # this will keep fancy tcl/python filename formatting for write nodes
                relpath = "[file dirname [value root.name]]"+separator+relpath[3:relpath.rfind("/")]+originalfilename[originalfilename.rfind(separator):]
                if platform.system() in ( 'Windows', 'Microsoft' ):
                    relpath = relpath.replace("\\", "/") 
                node['file'].setValue(relpath)
            except:
                print node.name(), ":Not converted, probably on another disk (WINDOWS)\n"
                pass
if __name__ == '__main__':
    bvfx_relativize()