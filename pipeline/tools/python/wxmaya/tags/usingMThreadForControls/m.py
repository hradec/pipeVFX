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



isMayaRunning = False
try:
    # if outside maya, init maya!
    #try:
    #    import maya.standalone maya.standalone.initialize( )
    #except:
    #    pass

    # now import the modules we need into m
    from maya.cmds import * 
    from maya import utils
    from maya.mel import eval as mel
    
    # trying to fix OSX
    import sys
    sys.stdin.write = lambda self, data: utils.executeDeferred(data)
    sys.stdin.flush = lambda self: None
    
    isMayaRunning = True
except:
    isMayaRunning = False





