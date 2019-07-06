#
# bgNukes.py
#
# v1.2
#
# Tim BOWMAN [puffy@netherlogic.com]
#
# A script for launching single-core command-line Nuke renderers 
# in the background from inside the Nuke UI.
# 
# Saves log files of each render instance's output to the same folder
# where the Nuke script lives. 
#
# Thanks go to Nathan Dunsworth. His localRender.py was (and continues 
# to be) an excellent reference.
#

# From Python
import os
import subprocess
# From Nuke
import nuke

def launch_nukes(nodes=[]):
    """
    Launch single-core command-line Nuke renderers from inside the Nuke UI.
    """
    
    if nuke.root().knob('name').value() == '':
        nuke.message('This script is not named. Please save it and try again.')
        return
    
    # Select Write nodes.
    nodelist = ''
    if nodes != []:
        nodelist = ','.join([n.name() for n in nodes if n.Class() == "Write"])
    
    start = int(nuke.knob("first_frame"))
    end = int(nuke.knob("last_frame"))
    instances = nuke.env['numCPUs']
    framerange = str(start) + "-" + str(end)
    p = nuke.Panel("Launch Nukes")
    p.addSingleLineInput("Frames to execute:", framerange)
    p.addSingleLineInput("Node(s) to execute:", nodelist)
    p.addSingleLineInput("Number of background procs:", instances)
    p.addButton("Cancel")
    p.addButton("OK")
    result = p.show()
    
    if not result: return
    framerange = p.value("Frames to execute:")
    nodelist = p.value("Node(s) to execute:").replace(' ', '')
    inst = int(p.value("Number of background procs:"))
    if framerange is None: 
        return
    if inst is None: 
        return

    (scriptpath, scriptname) = os.path.split(nuke.value("root.name"))
    flags = "-ixm 1"
    if nodelist != '': flags += " -X " + nodelist
    
    r = nuke.FrameRanges()
    r.add(framerange)
    r.compact()
    frame_list = r.toFrameList()
    print frame_list
    
    # Create lists of frames to render for each instance.
    inst_frame_list = []
    for i in range(inst): inst_frame_list.append([])
    print inst_frame_list
    cnt = 0
    for frame in frame_list:
        inst_frame_list[cnt].append(str(frame))
        cnt += 1
        if cnt == inst: cnt = 0
    print inst_frame_list
    
    print ">>> launching", inst, "nuke instances"
    
    # Launch each renderer
    logs = []
    for i in range(inst):
        instRange = ' '.join(inst_frame_list[i])

        print ">>> frame list for instance", i, "is:", instRange
        
        logFile = "%s/%s_log%02d.log" % (scriptpath, scriptname, i)
        logs.append(logFile)
        
        cmd = " ".join([nuke.env['ExecutablePath'], flags, '-F', '"' + instRange + '"', nuke.value("root.name"), '&>', logFile])
        print ">>> starting instance %d" % (i, )
        print "command: " + cmd
        subprocess.Popen(cmd, shell=True)
    
    nuke.message(str(inst) + ' renderers launched in the background.\nLog files: ' + ', '.join(logs))
    
# Add BG Render to the Render menu
menubar=nuke.menu("Nuke")
m = menubar.findItem('Render')
if not m.findItem('BG Render'):
    m.addCommand('-', '')
    m.addCommand('BG Render', 'bgNukes.launch_nukes(nuke.selectedNodes())')
