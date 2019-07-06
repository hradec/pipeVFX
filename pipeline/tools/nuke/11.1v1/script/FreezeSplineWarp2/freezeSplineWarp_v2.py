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

import nuke, nukescripts, time, threading, nuke.splinewarp as sw, _curveknob as ck

def fws_walker(obj, list):
    for i in obj:
        if isinstance(i, sw.Shape) or isinstance(i, ck.Stroke):
            list.append(i) 
        else:
            fws_walker(i, list)
    return list
    
def checkAB(shapeList):
    a= 0
    b =0
    for shape in shapeList:
        shapeattr = shape.getAttributes()   
        abvalue = shapeattr.getValue(0, "ab")      
        if abvalue  == 1.0:
            a +=1
        elif abvalue == 2.0:
            b+= 1
        if a > 0 and b > 0:
            break
    if a > 0 and b > 0:
        return True
    else:
        return False

def set_inputs(node, *inputs):
    """
    Sets inputs of the passed node in the order of the passed input nodes.
    The first node will become input 0 and so on
    This code was borrowed from Julik Tarkhanov projectionist, thank you :)
    """
    for idx, one_input in enumerate(inputs):
        node.setInput(idx, one_input)
        

def keyFreeze(shape,ab,freezeFrame,task):
    global cancel
    shapeattr = shape.getAttributes()
    if shapeattr.getValue(0, "ab") == float(ab):
        sourcecurve = shape
        if shape.name.count("[F]") <= 0:
            shape.name = shape.name + "[F]"     
        freezeX = []
        freezeY = []
        
        if isinstance(shape, sw.Shape):
            keyFrames = shape[0].center.getControlPointKeyTimes() #all keyframes of the curve's points
            transf = shape.getTransform()
            transf.addTransformKey(freezeFrame)
            for key in transf.getTransformKeyTimes():
                 if not key == freezeFrame:
                    transf.removeTransformKey(key)
            for p in shape:
                task.setMessage( 'Removing keys from' + shape.name)   
                if task.isCancelled():
                    cancel = True
                if cancel:
                    return
                elements = [p.center, p.featherCenter, p.leftTangent, p.rightTangent]
                animCurves = []
                for el in elements:
                    animCurves.append([el.getPositionAnimCurve(0),el.getPositionAnimCurve(1)])
                for curve in animCurves:
                    curve[0].addKey(freezeFrame)
                    curve[1].addKey(freezeFrame)
             
            for key in keyFrames:
                if task.isCancelled():
                    cancel = True
                if cancel:
                    return
                for p in sourcecurve:
                    elements = [p.center, p.leftTangent, p.rightTangent, p.featherCenter]
                    animCurves = []
                    for el in elements:
                        animCurves.append([el.getPositionAnimCurve(0),el.getPositionAnimCurve(1)])
                    if not key == freezeFrame:
                        n = 0
                        while n < len(animCurves)-1:
                            animCurves[n][0].removeKey(key)
                            animCurves[n][1].removeKey(key)
                            n+=1

        if isinstance(shape, ck.Stroke):
            transf = shape.getTransform()
            transf.addTransformKey(freezeFrame)
            for key in transf.getTransformKeyTimes():
                 if not key == float(freezeFrame):
                    transf.removeTransformKey(key)

            for p in shape:
                if task.isCancelled():
                    cancel = True
                if cancel:
                    return
                
                elements = [p]
                animCurves = []
                fp = p.getPosition(freezeFrame)
                p.addPositionKey(freezeFrame,fp)
                keyFrames = p.getControlPointKeyTimes()
                for key in keyFrames:
                    if not key == float(freezeFrame):
                        p.removePositionKey(key)


def expressionLock(shape,ab,freezeFrame,node,task):
    global cancel
    if task.isCancelled():
        cancel = True
    shapeattr = shape.getAttributes()
    task.setMessage( 'Setting expressions on' + shape.name)   
    if shapeattr.getValue(0, "ab") == float(ab):
        if shape.name.count("[F]") <= 0:
            shape.name = shape.name + "[F]"    
        if isinstance(shape, ck.Stroke):
            for point in shape:
                if task.isCancelled():
                    cancel = True
                if cancel:
                    return
                newcurve = point.getPositionAnimCurve(0)
                newcurve.useExpression = True
                newcurve.expressionString = "curve([value fframe])" 
                newcurve = point.getPositionAnimCurve(1)
                newcurve.useExpression = True
                newcurve.expressionString = "curve([value fframe])" 
        if isinstance(shape, sw.Shape):
            for point in shape:
                if task.isCancelled():
                    cancel = True
                if cancel:
                    return
                newcurve = point.center.getPositionAnimCurve(0)
                newcurve.useExpression = True
                newcurve.expressionString = "curve([value fframe])" 
                newcurve = point.center.getPositionAnimCurve(1)
                newcurve.useExpression = True
                newcurve.expressionString = "curve([value fframe])" 
            

def freezeWarp_v2():   
    try:
        node = nuke.selectedNode()
        if node.Class() not in ('SplineWarp3'):
            if nuke.GUI:
                nuke.message( 'Unsupported node type. Node must be SplineWarp' )
            return
    except:
        if nuke.GUI:
            nuke.message('Select a SplineWarp Node')
            return

    shapeList = []    
    curves = node['curves']
    nodeRoot = curves.rootLayer
    shapeList = fws_walker(nodeRoot, shapeList)
    
    #===========================================================================
    # panel setup
    #===========================================================================
    p = nukescripts.panels.PythonPanel("Freeze Splinewarp")
    k = nuke.Int_Knob("freezeframe","Freezeframe")
    k.setFlag(nuke.STARTLINE)    
    k.setTooltip("Set the frame to freeze the shapes positions")
    p.addKnob(k)
    k.setValue(nuke.root().firstFrame())
    k = nuke.Enumeration_Knob( 'outputcurve', 'Curves to Freeze', ['A', 'B'])
    k.setFlag(nuke.STARTLINE)
    k.setTooltip("Freeze all the curves on the A or B output")
    p.addKnob(k)
    
    k = nuke.Boolean_Knob("mt", "MultiThread")
    k.setFlag(nuke.STARTLINE)
    k.setTooltip("This will speed up the script but without an accurate progress bar")
    p.addKnob(k)
    k.setValue(True)
    k = nuke.Boolean_Knob("exp", "Use Expression to Freeze")
    k.setFlag(nuke.STARTLINE)
    k.setTooltip("Instead of deleting keyframes, it will use expressions on the shapes and also add a frame control on the node")
    p.addKnob(k)
    k.setValue(True)
    k = nuke.Boolean_Knob("fh", "Create FrameHold")
    k.setFlag(nuke.STARTLINE)
    k.setTooltip("This will create a Framehold Node and set it to the Freezeframe value, if you use expressions mode it will be linked")
    p.addKnob(k)
    k.setValue(True)
    
    if not checkAB(shapeList):
        p.addKnob( nuke.Text_Knob("","","\nWARNING: your node has only\ncurves on A or B outputs\n")) 
    
    #===========================================================================
    # end of panel setup
    #===========================================================================
    result = p.showModalDialog()    
    if result == 0:
        return # Canceled


    freezeFrame = p.knobs()["freezeframe"].value()
    ab = 1.0 if p.knobs()["outputcurve"].value() == "A" else 2.0
    exp = p.knobs()["exp"].value()
    mt = p.knobs()["mt"].value()
    if nuke.NUKE_VERSION_MAJOR > 6:
        #=======================================================================
        # task setup
        #=======================================================================
        global cancel
        cancel = False
        task = nuke.ProgressTask( 'Freeze SplineWarp' )
        n = 0
        #=======================================================================
        # task end
        #=======================================================================
        if exp:
            names = []
            for i in node.allKnobs():
                names.append(i.name())
            if "FreezeFrame" not in names: #avoid creating the pane if it already exists
                tab = nuke.Tab_Knob('FreezeFrame') 
                node.addKnob(tab)
                ff = nuke.Int_Knob('fframe',"Freeze Frame")
                node.addKnob(ff)
                try:
                    ff.setValue(freezeFrame)
                except:
                    pass

            for shape in shapeList:
                if cancel:
                    return
                task.setMessage('Processing ' + shape.name)
                task.setProgress((int(n/len(shapeList)*100)))
                if mt:
                    threading.Thread(None,expressionLock, args=(shape,ab,freezeFrame,node,task)).start() 
                else:
                    expressionLock(shape,ab,freezeFrame,node,task)
                n+=1
        else:
            for shape in shapeList:
                if cancel:
                    return
                task.setMessage('Processing ' + shape.name)
                task.setProgress((int(n/len(shapeList)*100)))
                if mt:
                    threading.Thread(None,keyFreeze, args=(shape,ab,freezeFrame,task)).start() 
                else:
                    keyFreeze(shape,ab,freezeFrame,task)
                n+=1
                
        #===========================================================================
        #  join existing threads (to wait completion before continue)
        #===========================================================================
        main_thread = threading.currentThread()
        for t in threading.enumerate():
            if t is main_thread:
                continue
            t.join()

        curves.changed()
    else:
        nuke.message( 'This version is for Nuke v7, use v1.1 with Nuke v6.3 from Nukepedia' ) 

 
    fh = p.knobs()["fh"].value()
    if fh:
        framehold = nuke.nodes.FrameHold()
        if exp:
            framehold["first_frame"].setExpression(node.name() + ".fframe")

        else:
            framehold.knob("first_frame").setValue(freezeFrame)
        #=======================================================================
        # some layout beautyfication
        #=======================================================================
        framehold["xpos"].setValue(node["xpos"].getValue() - 100)
        framehold["ypos"].setValue(node["ypos"].getValue() - 80)
        dot = nuke.nodes.Dot()
        dot["xpos"].setValue(node["xpos"].getValue()+35)
        dot["ypos"].setValue(framehold["ypos"].getValue()+11)
        set_inputs(node,dot)
        set_inputs(dot,framehold)
    
    label = "FreezeF: [value fframe]" if exp else "FreezeF:" + str(freezeFrame)
    node.knob('label').setValue(label)
    node.knob('filter').setValue('Mitchell') #less smoother than cubic
    print "FreezeSplineWarp Finished,", len(shapeList), "shape(s) at frame", freezeFrame 

if __name__ == '__main__':
    freezeWarp_v2()