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

# setup license servers for apps
# ===================================================================

import os

os.environ['PIPE_HIERO_LICENSE_SERVERS']   = '4101@192.168.0.249'
os.environ['PIPE_MODO_LICENSE_SERVERS']    = '4101@192.168.0.249'
os.environ['PIPE_NUKE_LICENSE_SERVERS']    = '@192.168.0.249'
os.environ['PIPE_MARI_LICENSE_SERVERS']    = '4101@192.168.0.249'

#os.environ['PIPE_NUKE_LICENSE_SERVERS']    = 'LM:@192.168.0.249,4101@192.168.0.249'

os.environ['PIPE_DELIGHT_LICENSE_SERVERS'] = '192.168.0.249'
os.environ['PIPE_HOUDINI_LICENSE_SERVERS'] = '192.168.0.249'


os.environ['PIPE_GENARTS_LICENSE']  = '2701@192.168.0.249'
os.environ['PIPE_YETI_LICENSE']     = '8833@192.168.0.2'