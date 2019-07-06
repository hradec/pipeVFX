#import bgNukes

import collectFiles

menubar = nuke.menu ('Nuke')
# Nukepedia
menubar.addCommand('Nukepedia/Despill Madness', 'nuke.createNode("DespillMadness2")')
menubar.addCommand('Nukepedia/Prores 422 Filter', 'nuke.createNode("ProRes_422_filter")')
menubar.addCommand('Nukepedia/Edger', 'nuke.createNode("Edger")')
menubar.addCommand('Nukepedia/VE_Edge', 'nuke.createNode("VE_Edge")')
menubar.addCommand('Nukepedia/V_Edge Matte', 'nuke.createNode("V_EdgeMatte")')
menubar.addCommand('Nukepedia/Spill Surpress', 'nuke.createNode("SpillSurpress")')
menubar.addCommand('Nukepedia/Spill Replace', 'nuke.createNode("SpillReplace2")', icon='SpillReplace2.png')
menubar.addCommand('Nukepedia/Kill Spill+', 'nuke.createNode("KillSpillPlus")')
menubar.addCommand('Nukepedia/Kill Outline', 'nuke.createNode("KillOutline")')
menubar.addCommand('Nukepedia/Additive Keyer 2', 'nuke.createNode("AdditiveKeyer2")')
#menubar.addCommand('Nukepedia/Rotopaint to SplineWarp', 'nuke.createNode("RotopaintToSplineWarp_v2")')
# Atomo

menubar.addCommand('Atomo/Collect Files', 'collectFiles.collectFiles()')
# collectFiles()
menubar.addCommand('Atomo/Burnator (Nuke 8 ONLY)', 'nuke.createNode("Burnator")')
# Boundary VFX Tools

#toolbar = nuke.menu("Nodes")
#bvfxt = toolbar.addMenu("BoundaryVFX Tools")
#bvfxt.addCommand('Locate files paths', "bvfx_findPath(False)")
#bvfxt.addCommand('Make paths relative',"bvfx_relativize()") 

# add KeenTools menu to Nodes toolbar
#toolbar = nuke.menu('Nodes')
#kt_menu = toolbar.addMenu('KeenTools', icon='KeenTools.png')
#kt_menu.addCommand('GeoTracker', lambda: nuke.createNode('GeoTracker'), icon='GeoTracker.png')
#kt_menu.addCommand('PinTool', lambda: nuke.createNode('PinTool'), icon='PinTool.png')
#kt_menu.addCommand('ReadRiggedGeo', lambda: nuke.createNode('ReadRiggedGeo'), icon='ReadRiggedGeo.png')
#if 'OFF' == 'ON':
#    kt_menu.addCommand('FlowEvaluationTool', lambda: nuke.createNode('FlowEvaluationTool'), icon='KeenTools.png')
#if 'OFF' == 'ON':
#        kt_menu.addCommand('FlowEvaluationTool', lambda: nuke.createNode('FlowEvaluationTool'), icon='KeenTools.png')
