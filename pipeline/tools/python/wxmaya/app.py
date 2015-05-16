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


import sys, os
import wx
import threading, time
import log

import m, platform

import callbackManager

class __applist(list):
    def killall(self):
        for each in self:
            each.close()

global wxmayaApps
try: 
    wxmayaApps 
except:
    wxmayaApps = __applist()

class __cleanClass__:
    pass

def wxmayaAppsAdd(app):
    global wxmayaApps 
    try: 
        wxmayaApps 
    except:
        wxmayaApps = __applist()
    wxmayaApps.append(app)

def wxmayaAppsDel(app):
    global wxmayaApps 
    try: 
        del wxmayaApps[wxmayaApps.index(app)]
    except:
        pass
    del app

class frame(wx.Frame):
    def __init__(self, parent):
        wx.Frame.__init__(self, parent, -1, "Hello from wxPython", size=(400,300))

class app(wx.App):
    def __init__(self, title="Hello from wxPython", size=(800,500), frameClass=frame, hidden=False ):
        self.hidden = hidden
        self.size = size
        self.title = title
        self.__frameClass = frameClass
        self.parent = None
        #self.__getMayaParent() 
        self.mayaInitDoneFlag = False
        if m.isMayaRunning :
            m.utils.executeDeferred(self.__mayaInitDone)
            self.runInMaya()
        else:
            self.__mayaInitDone()
            self.MainLoop()
        wxmayaAppsAdd(self)
        
    def __getMayaParent(self):
        ''' 
            parent an app to the main maya windows in windows.
            not working yet!
            http://forums.cgsociety.org/archive/index.php/t-453070.html
        '''
        import traceback
        import win32gui, win32process
        
        def callback(handle,winList):
            winList.append(handle)
            return True

        wins = []

        win32gui.EnumWindows(callback, wins)
        currentId = os.getpid()

        for handle in wins:
            tpid,pid = win32process.GetWindowThreadProcessId(handle)
            if pid == currentId:
                title = win32gui.GetWindowText(handle)
                if title.startswith("Autodesk Maya"):
                    self.parent = handle
                    
        if self.parent:
            app = wx.GetApp()
            top = wx.PreFrame()
            top.AssociateHandle(self.parent)
            top.PostCreate(top)
            app.SetTopWindow(top)
            self.parent = top
    
    def __mayaInitDone(self):
        wx.App.__init__(self,0)
        self.mayaInitDoneFlag = True
        
    def setTitle(self, title):
        self.title = title

    def setFrameClass(self, frameClass):
        self.__frameClass = frameClass

    def setSize(self, size):
        self.size = size
        
    def OnInit(self):
        #self.menu_bar  = wx.MenuBar()
        #self.frame = wx.Frame(None, -1, "Hello from wxmaya", size=self.size)
        self.frame = self.__frameClass(self.parent)
        self.panel = wx.Panel(self.frame, -1)
        self.sizer = wx.BoxSizer(wx.VERTICAL)
        self.sizer.gap = 0
        
        if hasattr(self,'OnInitUI'):
            self.OnInitUI()

        panelChildren = self.panel.GetChildren()
        if len(panelChildren):
            for each in panelChildren:
                try: self.sizer.Add( each, 1, wx.EXPAND |wx.ALL, self.sizer.gap )
                except: pass
            self.panel.SetSizer(self.sizer)
        else:
            self.frame.RemoveChild(self.panel)

        self.frame.SetSize(self.size)
        self.frame.SendSizeEvent()
        self.frame.SetLabel(self.title)
        self.frame.Show(not self.hidden)
        if not self.hidden:
            self.SetTopWindow(self.frame)
        sys.displayhook = self.displayHook
        
        #wx events
        self.frame.Bind(wx.EVT_CLOSE, self.close) 
        
        if hasattr(self, 'idle'):
            self.frame.Bind(wx.EVT_IDLE, self.idle) 
        
        #maya events
        if hasattr(self, 'connectionCallback'):
            def connectionCallback(*args):
                self.connectionCallback(args)
            self.__connectionCallbackOBJ = callbackManager.mayaConnectionCallback(connectionCallback)

        #if hasattr(self, 'nodeAddedCallback'):
        #    def nodeAddedCallback(*args):
        #        self.nodeAddedCallback(args)
        #    self.__nodeAddedCallbackOBJ = callbackManager.mayaNodeAddedCallback(nodeAddedCallback, 'mesh')

        #if hasattr(self, 'nodeRemovedCallback'):
        #    def nodeRemovedCallback(*args):
        #        self.nodeRemovedCallback(args)
        #    self.__nodeRemovedCallbackOBJ = callbackManager.mayaNodeRemovedCallback(nodeRemovedCallback, 'mesh')
            
        if hasattr(self, 'forceUpdateCallback'):
            def forceUpdateCallback(*args):
                self.forceUpdateCallback(args)
            self.__forceUpdateCallbackOBJ = callbackManager.mayaAddForceUpdateCallback(forceUpdateCallback)
            
        if hasattr(self, 'addTimeChangeCallback'):
            def addTimeChangeCallback(*args):
                self.addTimeChangeCallback(args)
            self.__forceUpdateCallbackOBJ = callbackManager.mayaAddTimeChangeCallback(addTimeChangeCallback)
    
        return True


    def displayHook(self, o):
        print o
        
        
    def runInMaya(self):
        evtloop = self
        # this fixes threading problems in OSX, but causes exceptions in Windows
        # so, its a OSX only feature.
        if platform.osx:
            evtloop    = wx.EventLoop()
            oldEvtloop = wx.EventLoop.GetActive()
        self.keepGoing=True
        def process():
                if evtloop != self:
                    wx.EventLoop.SetActive(evtloop)
                while evtloop.Pending():
                    evtloop.Dispatch()
                self.ProcessIdle()
                if evtloop != self:
                    wx.EventLoop.SetActive(oldEvtloop)
                        
        def thread():
            while self.keepGoing:
                time.sleep(0.2)
                m.utils.executeDeferred(process)
        
        self.pumpedThread = threading.Thread(target = thread, args = ())
        self.pumpedThread.start() 

        
    def close(self, event=None):
        log.write('app.close: %s' % str(event))
        self.keepGoing=False
        self.frame.Close(True)
        self.frame.Destroy()
        self.frame.DestroyChildren()
        if event:
            event.Skip()
            
        callbacks = filter(lambda x: '__' in x and 'callback' in x.lower(), dir(self))
        for each in callbacks:
            eval( 'self.%s.remove()' % each )
            
        wxmayaAppsDel(self)

if __name__ == '__main__':
    app()
