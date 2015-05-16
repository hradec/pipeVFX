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

import scopy
import mayaImport

toolbar = nuke.menu("Nodes")
aMenu = toolbar.addMenu("Atomo Tools", "a_menu.png")
#dwMenu = toolbar.addMenu("DW Tools", "dw_menu.png")

aMenu.addCommand("2D/Aberration", 'nuke.createNode("Aberration")')
aMenu.addCommand("2D/ChangeOS", 'nuke.createNode("changeOS")')
aMenu.addCommand("2D/Santinho", 'nuke.createNode("Santinho")')
aMenu.addCommand("2D/Share", 'nuke.createNode("Share")')
aMenu.addCommand("2D/SmartCopy", 'scopy.scopy()', "ctrl+shift+C")
aMenu.addCommand("2D/Render", 'nuke.createNode("Render")', "shift+r")
aMenu.addCommand("3D/MayaImport", 'nuke.createNode("mayaImport")', "ctrl+shift+m")
aMenu.addCommand("3D/MayaImport2", "mayaImport.mayaPanel()")
#dwMenu.addCommand("Readers/Global Directory", "dw_globalDirReadSetup_v1_0.globalDirSep()", "a", "dw_globalDirSep.png")
#dwMenu.addCommand("Readers/GD-Read Associate Selected", "dw_globalDirReadSetup_v1_0.gdReadSel()", "ctrl+r", "dw_gdReadSel.png")
#dwMenu.addCommand("Readers/GD-Read Setup", "dw_globalDirReadSetup_v1_0.gdReadSetup()", "shift+r", "dw_gdReadSetup.png")