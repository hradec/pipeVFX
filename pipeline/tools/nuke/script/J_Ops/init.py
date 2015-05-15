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

#  init.py
#  J_Ops
#
#  Created by Jack Binks on 14/02/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.
import sys, nuke, os

for path in nuke.pluginPath():
    if os.path.exists(os.path.normpath(path+"/J_Ops/py")):
        sys.path.append(path+"/J_Ops/py")
    if os.path.exists(os.path.normpath(path+"/../J_Ops/py")):
        sys.path.append(path+"/py")
    if os.path.exists(os.path.normpath(path+"/../J_Ops/ndk")):
        nuke.pluginAddPath(path+"/ndk")
    if os.path.exists(os.path.normpath(path+"/../J_Ops/icons")):         
        nuke.pluginAddPath(path+"/icons")
        
        
