#!/usr/bin/env python2.5
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

#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of Image Engine Design nor the names of any
#       other contributors to this software may be used to endorse or
#       promote products derived from this software without specific prior
#       written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

from m import isMayaRunning
if isMayaRunning:

    import log

    global callbacks
    try: 
        callbacks
    except:
        callbacks=[]

    from m import MObject
    from m import MPlug
    from m import OpenMaya


    class mayaCallBack:
        def __init__(self, callbackID = None):
            if type(callbackID)==type([]):
                self.callbackID = callbackID
            else:
                self.callbackID = [callbackID]
        def remove(self):
            for each in self.callbackID:
                if each:
                    callbacks.append(each) # add callback ID here so swig object memory doesnt leak!
                    OpenMaya.MMessage.removeCallback(each)
                    log.write("mayaRemoveCallback: callbackID %d removed" % each)
                    

    class mayaConnectionCallback(mayaCallBack):
        def __init__(self, func):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addConnectionCallback( func ) )

    class mayaTimeChangeCallback(mayaCallBack):
        def __init__(self, func):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addTimeChangeCallback( func ) )

    class mayaNodeAddedCallback(mayaCallBack):
        def __init__(self, func, nodetype = "dependNode"):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addNodeAddedCallback( func, nodetype ) )

    class mayaNodeRemovedCallback(mayaCallBack):
        def __init__(self, func, nodetype = "dependNode"):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addNodeRemovedCallback( func, nodetype ) )

    class mayaNodeRemovedCallback(mayaCallBack):
        def __init__(self, func, nodetype = "dependNode"):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addNameChangedCallback( func, nodetype ) )

    class mayaAddForceUpdateCallback(mayaCallBack):
        def __init__( self, func ):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addForceUpdateCallback( func ) )

    class mayaAddTimeChangeCallback(mayaCallBack):
        def __init__( self, func ):
            mayaCallBack.__init__(self, OpenMaya.MDGMessage.addTimeChangeCallback( func ) )





    class mayaNodeChangeCallback(mayaCallBack):
        def __init__(self, nodeAttr, callbackFunc):
            node, attr = nodeAttr.split('.')
            mobj = MObject(node)
            self.node = node
            self.attr = attr
            self.callbackFunc = callbackFunc

            callbackIDs = [
                OpenMaya.MNodeMessage.addAttributeChangedCallback( mobj, mayaNodeChangeCallback.attrChangedCallback, self ),
                OpenMaya.MNodeMessage.addNameChangedCallback(      mobj, mayaNodeChangeCallback.nameChangedCallback, self ),
                OpenMaya.MNodeMessage.addNodeAboutToDeleteCallback(   mobj, mayaNodeChangeCallback.deleteCallback, self  ),
            ]
            # add the callback list to be removed automatically when the class is deleted.
            mayaCallBack.__init__(self, callbackIDs)
        
        @staticmethod
        def attrChangedCallback( *args ):
            msg         = args[0]
            mplug       = args[1]
            otherMPlug  = args[2]
            self        = args[3]
            node, attr = mplug.name().split('.')
            
            logMsg = 'mayaNodeChangeCallback.attrChangedCallback: '
            
            # if attr changed
            if msg & OpenMaya.MNodeMessage.kAttributeSet:
                logMsg += '%s.%s -> OpenMaya.MNodeMessage.kAttributeSet' % (node, attr)
                self.callbackFunc()
            
            ''' TODO: add callbacks for all the possivel changes in a node, so the controls can reflect that change of state automatically 
                msg Mask for all possible change types:
                  kConnectionMade = 0x01, kConnectionBroken = 0x02, kAttributeEval = 0x04, kAttributeSet = 0x08,
                  kAttributeLocked = 0x10, kAttributeUnlocked = 0x20, kAttributeAdded = 0x40, kAttributeRemoved = 0x80,
                  kAttributeRenamed = 0x100, kAttributeKeyable = 0x200, kAttributeUnkeyable = 0x400, kIncomingDirection = 0x800,
                  kAttributeArrayAdded = 0x1000, kAttributeArrayRemoved = 0x2000, kOtherPlugSet = 0x4000, kLast = 0x8000
            '''
            
            log.write(logMsg)

        @staticmethod
        def nameChangedCallback( *args ):
            print 'nameChangedCallback:',args
            
     
        @staticmethod
        def deleteCallback( *args ):
            print 'deleteCallback:',args
            
     
     
     
     