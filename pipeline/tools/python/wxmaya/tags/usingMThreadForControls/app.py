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


import sys, os
import wx
import threading, time

import m, platform


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
        wxmayaApps = []
    wxmayaApps.append(app)

def wxmayaAppsDel(app):
    global wxmayaApps 
    try: 
        del wxmayaApps[wxmayaApps.index(app)]
    except:
        pass

class frame(wx.Frame):
    def __init__(self, title, size):
        wx.Frame.__init__(self, None, -1, "Hello from wxPython", size=size)

class app(wx.App):
    def __init__(self, size=(800,500) ):
        self.size = size
        if m.isMayaRunning :
            m.utils.executeDeferred(wx.App.__init__,self,0)
            self.runInMaya()
        else:
            wx.App.__init__(self,0)
            self.MainLoop()
        wxmayaAppsAdd(self)
        
        
    def OnInit(self):
        self.menu_bar  = wx.MenuBar()
        #self.frame = wx.Frame(None, -1, "Hello from wxmaya", size=self.size)
        self.frame = frame("Hello from wxPython", size=self.size)
        self.panel = wx.Panel(self.frame, -1)
        self.sizer = wx.BoxSizer(wx.VERTICAL)
        self.sizer.gap = 0
        
        if hasattr(self,'OnInitUI'):
            self.OnInitUI()
        
        panelChildren = self.panel.GetChildren()
        if len(panelChildren):
            for each in panelChildren:
                self.sizer.Add( each, 1, wx.EXPAND |wx.ALL, self.sizer.gap )
            self.panel.SetSizer(self.sizer)
        else:
            self.frame.RemoveChild(self.panel)

        self.frame.SendSizeEvent()
        self.frame.Show(True)
        self.SetTopWindow(self.frame)
        sys.displayhook = self.displayHook
        
        self.frame.Bind(wx.EVT_CLOSE, self.close) 
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
        self.keepGoing=False
        self.frame.Destroy()
        if event:
            event.Skip()
        wxmayaAppsDel(self)

if __name__ == '__main__':
    app()
