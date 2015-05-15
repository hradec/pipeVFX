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

#  menu.py
#  J_Ops
#
#  Created by Jack Binks on 07/01/2010.
#  Copyright (c) 2010 Jack Binks. All rights reserved.
import nuke
import os.path
import J_Ops

toolbar = nuke.menu("Nodes")
n = toolbar.addMenu("J_Ops", "J_Ops.png")
n.addCommand("J_3Way", "J_Ops.createNode(\"J_3Way\")", "", "J_3Way.png")
n.addCommand("J_GeoManager", "J_Ops.createNode(\"J_GeoManager\")", "", "J_GeoManager.png")
n.addCommand("J_GotSomeID", "J_Ops.createNode(\"J_GotSomeID\")", "", "J_GotSomeID.png")
n.addCommand("J_ICCkyProfile", "J_Ops.createNode(\"J_ICCkyProfile\")", "", "J_ICCkyProfile.png")
n.addCommand("J_MergeHDR", "J_Ops.createNode(\"J_MergeHDR\")", "", "J_MergeHDR.png")
m = n.addMenu("J_Mullet", "J_Mullet.png")
m.addCommand("J_MulletBody", "J_Ops.createNode(\"J_MulletBody\")", "", "J_MulletBody.png")
m.addCommand("J_MulletCompound", "J_Ops.createNode(\"J_MulletCompound\")", "", "J_MulletCompound.png")
m.addCommand("J_MulletConstraint", "J_Ops.createNode(\"J_MulletConstraint\")", "", "J_MulletConstraint.png")
m.addCommand("J_MulletForce", "J_Ops.createNode(\"J_MulletForce\")", "", "J_MulletForce.png")
m.addCommand("J_MulletSolver", "J_Ops.createNode(\"J_MulletSolver\")", "", "J_MulletSolver.png")
n.addCommand("J_Scopes", "J_Ops.createNode(\"J_Scopes\")", "", "J_Scopes.png")
n.addCommand("J_ZKeyer", "J_Ops.createNode(\"J_ZKeyer\")", "", "J_ZKeyer.png")
n.addCommand("J_ZMaths", "J_Ops.createNode(\"J_ZMaths\")", "", "J_Zmaths.png")
n.addCommand("J_Ops Help", "J_Ops.launchHelp()", "", "J_Ops_Help.png")


###################################################################################
#Customised drag and drop, adding support for geos, luts and chans.

import nukescripts, nuke, os

def jopsFileHandler(dropdata):
    filePath=dropdata
    fileRange= ''
    
    if not os.path.isfile(filePath):
        filePath, sep, fileRange = filePath.rpartition(' ')

    fileName, fileExt = os.path.splitext(filePath)
    fileExt = fileExt.lower()
    
    if fileExt == '.obj':
        r = nuke.createNode("ReadGeo2", inpanel=False)
        r["file"].fromUserText(dropdata)
        r["selected"].setValue(0)
        return True

    if fileExt == '.fbx':
        r = nuke.createNode("ReadGeo2", inpanel=False)
        r["file"].fromUserText(dropdata)
        r["selected"].setValue(0) 
        r = nuke.createNode("Camera2", 'read_from_file 1 file '+dropdata, inpanel=False)
        r["selected"].setValue(0)
        r = nuke.createNode("Light2", 'read_from_file 1 file '+dropdata, inpanel=False)
        r["selected"].setValue(0)        
        return True
    
    if fileExt == '.3dl' or fileExt == '.blur' or fileExt == '.csp' or fileExt == '.cub' or fileExt == '.cube' or fileExt == '.vf' or fileExt == '.vfz':
        r = nuke.createNode("Vectorfield", inpanel=False)
        r["vfield_file"].setValue(dropdata)
        r["selected"].setValue(0)
        return True

    if fileExt == '.chan':
        r = nuke.createNode("Camera2", inpanel=False)
        nuke.tcl('in %s {import_chan_file %s }' %(r.name(), dropdata))
        r["selected"].setValue(0)
        return True

    r = nuke.createNode("Read", inpanel=False)
    r["file"].fromUserText(dropdata)
    return True

def jopsPathHandler(dropdata):
    if os.path.isdir(dropdata):

        recurse = False

        try:
            recurse = nuke.toNode('preferences')["j_ops_drop_recurse"].getValue()
        except (SyntaxError, NameError):
            pass
        
        for each in nuke.getFileNameList(dropdata, False, False, bool(recurse), False):
            jopsPathHandler(os.path.join(dropdata,each))
        return True
    else:
        return jopsFileHandler(dropdata)

def jopsDropHandler(droptype, dropdata):
    #Fix filename for linux drops
    if dropdata.startswith("file://"):
        dropdata = dropdata[7:]
    if os.path.isfile(dropdata) or os.path.isdir(dropdata):
        return jopsPathHandler(dropdata)
    return False

###################################################################################
#Preferences

def preferencesCreatedCallback():
    p = nuke.toNode('preferences')
    
    #Setup J_Ops prefs knobs if they don't exist.
    try:
        jopsKnobsPresent = p["J_Ops"]
    except (SyntaxError, NameError):
        k = nuke.Tab_Knob("J_Ops")
        k.setFlag(nuke.ALWAYS_SAVE)
        p.addKnob(k)

        v = nuke.Double_Knob("j_ops_ver", "j_ops_ver")
        v.setFlag(nuke.ALWAYS_SAVE)
        v.setFlag(nuke.INVISIBLE)
        v.setValue(2.0101)
        p.addKnob(v)
        
        k = nuke.Boolean_Knob("j_ops_enable_drop", "Improved drag and drop")
        k.setFlag(nuke.ALWAYS_SAVE)
        k.setFlag(nuke.STARTLINE)
        k.setValue(1.0)
        k.setTooltip("Enable/disable a somewhat improved drag and drop behaviour. Requires Nuke restart to take effect. Adds creation of geo, camera, light and vectorfield nodes based on incoming file extensions, as well as support for sequences when dropping folders onto DAG. Warning: does not observe hash vs regex file path expression, due to Nuke python functions ignoring it.")
        p.addKnob(k)

        k = nuke.Text_Knob("j_ops_dropdivider_label", "Drag And Drop")
        k.setFlag(nuke.ALWAYS_SAVE)
        p.addKnob(k)

        k = nuke.Boolean_Knob("j_ops_drop_recurse", "Recurse directories")
        k.setFlag(nuke.ALWAYS_SAVE)
        k.setValue(1.0)
        k.setTooltip("Enable/disable recursion into directories dropped on DAG. When enabled will result in entire directory structure being imported into DAG, when disabled only the directory dropped will be imported (ie none of its sub directories)")
        p.addKnob(k)
    
    #Knobs created. Hide obselete ones, update ver
    #2.1
	try:
		p["j_ops_ver"].setValue(2.0201)
		try:
			p["j_ops_enable_bookmark"].setFlag(nuke.INVISIBLE)
		except Exception:
			pass
	except Exception:
		pass
                    
    #Check for preference setting, and if drop enabled add its callback/
    dropEnabled = False
    try:
        dropEnabled = nuke.toNode('preferences')["j_ops_enable_drop"].getValue()
    except (SyntaxError, NameError):
        pass

    if dropEnabled == True:
        nukescripts.drop.addDropDataCallback(jopsDropHandler)

#Adding callbacks to ensure knobs added if needed, and interpreted. 
#Root is done to catch the case where there are no custom prefs,
#so no creation callback for it.
nuke.addOnCreate(preferencesCreatedCallback, nodeClass='Preferences')
nuke.addOnCreate(preferencesCreatedCallback, nodeClass='Root')
