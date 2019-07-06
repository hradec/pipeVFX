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

import os
import os.path
import sys
import nuke

def addMenuItems():
    menubar = nuke.menu('Nuke')

    renderMenu = menubar.findItem('Render')
    if renderMenu is None:
        renderMenu = menubar.addMenu('&Render')

    qubeMenu = renderMenu.findItem('Qube')
    if qubeMenu is None:
        qubeMenu  = renderMenu.addMenu('Qube')

    qubeMenu.addCommand("Render All... (cmdline)"     , "import qubeSimpleCmd_menu; qubeSimpleCmd_menu.submitNukeCmdline_renderAll()", index=0)
    qubeMenu.addCommand("Render Selected... (cmdline)", "import qubeSimpleCmd_menu; qubeSimpleCmd_menu.submitNukeCmdline_renderSelected()", index=1)

    if qubeMenu.findItem('Render All... (loadOnce)'):
        qubeMenu.addCommand('-', '', '', index=2)

    if qubeMenu.findItem('Launch GUI') is None:
        qubeMenu.addCommand('-', '', '')
        qubeMenu.addCommand("Launch GUI"        , "import qubeSimpleCmd_menu; qubeSimpleCmd_menu.launchgui()")

def launchgui(qubeguiPath='', submitDict={}, guiargs=''):
    '''launch the QubeGUI with the specified parameters'''
    # Construct parameter list
    cmdDict = {
                'qubeguiPath': qubeguiPath,
                'qubeguiArgString': '',
              }
    if len(submitDict) > 0:  cmdDict['qubeguiArgString'] += ' --submitDict "%s"'%submitDict
    if len(guiargs) > 0   :  cmdDict['qubeguiArgString'] += ' '+guiargs

    # Construct command for the specific platforms        
    if sys.platform[:3] == 'win':
        if cmdDict['qubeguiPath'] == '': cmdDict['qubeguiPath'] = 'C:/Program Files/pfx/qube/bin/qube.exe'
        if not os.path.exists(cmdDict['qubeguiPath']):
            cmdDict['qubeguiPath'] = 'C:/Program Files (x86)/pfx/qube/bin/qube.exe'
        cmd = r'start "QubeGUI Console" /B "%(qubeguiPath)s" %(qubeguiArgString)s'% cmdDict
    elif sys.platform == 'darwin':
        if cmdDict['qubeguiPath'] == '': cmdDict['qubeguiPath'] = '/atomo/apps/darwin/x86_64/qube/current/qubegui/pfx/qube/qube.app'
        cmd = r'%(qubeguiPath)s/Contents/MacOS/qube %(qubeguiArgString)s >/dev/null 2>&1  &'% cmdDict
    elif sys.platform[:5] == 'linux':
        if cmdDict['qubeguiPath'] == '': cmdDict['qubeguiPath'] = '/atomo/apps/linux/x86_64/qube/current/qubegui/local/pfx/qube/bin/qube'
        cmd = r'%(qubeguiPath)s %(qubeguiArgString)s >/dev/null 2>&1  &'% cmdDict
    else:
        raise "Unknown platform"
    
    # Run command
    print("COMMAND: %s"%cmd)
    nuke.tprint("COMMAND: %s"%cmd)
    #nuke.message("COMMAND: %s"%cmd)
    os.system(cmd)

    
def submitNukeCmdline_render(executeNodes=''):
    '''launch the qubegui submit dialog for nuke'''
    allNodes = nuke.allNodes()
    allNodes_Write  = [str(i.name()) for i in allNodes if i.Class() == 'Write'] 
    allNodes_Viewer = [str(i.name()) for i in allNodes if i.Class() == 'Viewer'] 
    scenefile = '[NUKE NOPIPE] %s' % os.path.basename(str(nuke.root().name()))
    nuke.tprint(allNodes_Write)
    nuke.tprint(allNodes_Viewer)
    range = '%s-%s' % (int(nuke.animationStart()), int(nuke.animationEnd()))
    rangeInc = int(nuke.animationIncrement())
    if rangeInc > 1:
        range += 'x%s' % rangeInc
    submitDict = {
        'name'      : scenefile,
        'prototype' : 'cmdrange',
        'package' : {
            'simpleCmdType': 'Nuke (cmdline)',
            'script': str(nuke.root().name()),
            'range' : range,
            'executeNodes' : executeNodes,
            'allNodes_Write' : ','.join(allNodes_Write),
            'allNodes_Viewer' : ','.join(allNodes_Viewer),
#	    'executable' : '/atomo/apps/linux/x86_64/nuke/8.0v3/Nuke8.0',
        'executable' : '/atomo/apps/linux/x86_64/nuke/9.0v1/Nuke9.0',
            },
	'reservations' : 'host.processors=1+,license.nuke',
        'groups' : 'pipe',
        'cpus' : 6,
        'omithosts' : 'rhradec.local',
        'env': {'foundry_LICENSE':'4101@192.168.0.249','NUKE_PATH':'/atomo/pipeline/tools/nuke/script:/atomo/pipeline/tools/nuke/gizmo:/atomo/apps/linux/x86_64/genarts_monsters_gt_ofx/7.0.229/usr/OFX/Plugins','NUKE_TEMP_DIR':'/tmp/nuke_farm','genarts_LICENSE':'2701@192.168.0.249','LD_LIBRARY_PATH':'/atomo/apps/linux/x86_64/genarts_monsters_gt_ofx/7.0.229/usr/genarts/monsters-ofx64/lib64/'}
        }
    return launchgui(submitDict=submitDict)


def submitNukeCmdline_renderAll():
    return submitNukeCmdline_render(executeNodes='')


def submitNukeCmdline_renderSelected():
    executeNodes = ','.join( sorted([i.name() for i in nuke.selectedNodes() if i.Class() == 'Write']) )
    return submitNukeCmdline_render(executeNodes=executeNodes)
