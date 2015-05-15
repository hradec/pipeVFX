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



#if os.environ['USER']=='3d':
## === QUBE SimpleCmd: BEGIN ===
qube_nukepath = os.path.expanduser('/atomo/pipeline/tools/nuke/script/qube')
if qube_nukepath not in sys.path:
    sys.path.append( qube_nukepath )
import qubeSimpleCmd_menu
qubeSimpleCmd_menu.addMenuItems()
## === QUBE SimpleCmd: END ===


