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