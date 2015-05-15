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

##########################################################################
#
#  Copyright (c) 2010, Roberto Hradec. All rights reserved.
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


import log, m, app, wx, callbackManager
import mthread
from mthread import mthread



import  wx.lib.newevent
mayaUpdate, EVT_MAYA_UPDATE = wx.lib.newevent.NewEvent()


global attrsToWatch
try: 
    attrsToWatch
except:
    attrsToWatch={}

def attrsToWatchAdd( key, obj):
    '''
    add nodes and attributes to be watched by wxmaya thread. if any change is detected from outside wxmaya, 
    it will trigger a refresh of the correspondent control. 
    This allows realtime sync of controls and maya. (mimics maya UI behaviour)
    '''
    global attrsToWatch
    if key:
        if key not in attrsToWatch.keys():
            attrsToWatch[key] = {}
            
        attrsToWatch[key][obj]=True


'''
TODO: add suport to node wildcards, allowing one control to be "connected" to more than one node. 
Also, allows for dinamic attachment of the control to nodes created after the UI. 
Wildcard need to be implemented as a class that gets dinamicaly updated, so everything will be in realtime.
'''
class controlBase(wx.Control):
    '''
    controlBase class - the base class for a wxmaya controls
                        this class brings some safe methods to interact with maya from within threads. 
                        getAttr and setAttr, for example, make sure that maya calls are executed using maya.utils 
                        executeInMainThreadWithResult and executeDeferred.
                        The idea is use this methods to automatically set/get values of attributes in nodes from
                        inside a callback method of a control, making the wxmaya UI "live" updating maya parameters.
    '''
    def __init__(self, panel, attr):
        #mthread.__init__(self)
        #attrsToWatchAdd( attr, self )
        wx.Control.__init__(self, panel, style=wx.BORDER_NONE )
        self.Hide()
        self.attr = attr
        self.attrValue = None
        self.mayaNodeChangeCallback = None
        if self.attr:
            self.attrValue = self.getAttr()
            self.mayaNodeChangeCallback = callbackManager.mayaNodeChangeCallback( attr , self.attrCallback )

        self.panel = panel
        
        wx.Control.Bind( self, EVT_MAYA_UPDATE, self.refreshUI )
        wx.Control.Bind( self, wx.EVT_WINDOW_DESTROY, self.close ) 

        
    def refreshUI(self):
        print "SSSSS"

    def refresh(self):
        '''
        this function will be called if wxmaya detects that this control needs to be updated.
        '''
        
        
    def getAttr(self):
        '''
        if class has self.attr defined, it runs getAttr safely in maya to query the node attribute.
        '''
        ret = None
        if self.attr:
            def attach():
                return m.getAttr( self.attr )
            ret = m.utils.executeInMainThreadWithResult(attach)
        return ret

    def setAttr(self, value):
        '''
        if class has self.attr defined, it runs setAttr safely in maya to se the node attribute value.
        '''
        if self.attr:
            def attach():
                m.setAttr( self.attr, value )
            m.utils.executeDeferred( attach )

    def attrCallback(self, *args):
        self.refresh()

    def thread(self):
        self.refresh()

    def close(self, event):
        if self.mayaNodeChangeCallback:
            self.mayaNodeChangeCallback.remove()


