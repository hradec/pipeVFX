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

#import bgNukes

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

menubar.addCommand('Atomo/Burnator (Nuke 8 ONLY)', 'nuke.createNode("Burnator")')
# Boundary VFX Tools

#toolbar = nuke.menu("Nodes")
#bvfxt = toolbar.addMenu("BoundaryVFX Tools")
#bvfxt.addCommand('Locate files paths', "bvfx_findPath(False)")
#bvfxt.addCommand('Make paths relative',"bvfx_relativize()") 
