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


from app import *
import m
import wx, time

class progress(app):
    def __init__(self, max=10, title="Go get a cofee! =)", msg="Please wait...", size=(400,220), onTop=True):
        dlg = progress.getCurrent()
        if dlg:
            dlg.close()
        self.max = max
        self.title = title
        self.msg = msg
        self.count = 1
        self.onTop = onTop
        app.__init__(self, title, size=size, hidden=True)

    @staticmethod
    def getCurrent():
        dlg = filter( lambda x: type(x) is progress, wxmayaApps)
        if dlg:
            return dlg[0]
        else:
            return None


    def MainLoop(self):
        self.runInMaya()
        
    def OnInit(self):
        if not hasattr(self, 'dlg'):
            self.frame = wx.Frame(None, 0, "", (0,0), (0,0), wx.STAY_ON_TOP)
            self.dlg = wx.ProgressDialog(self.title,
                self.msg,
                maximum = self.max,
                parent=self.frame,
                style = wx.PD_CAN_ABORT
                | wx.PD_AUTO_HIDE
                | wx.STAY_ON_TOP
                #| wx.DIALOG_NO_PARENT
                | wx.PD_SMOOTH
                | wx.PD_ELAPSED_TIME
                | wx.PD_ESTIMATED_TIME
                | wx.PD_REMAINING_TIME
            )
        self.dlg.SetSize(self.size)
        self.dlg.CentreOnScreen()

        self.dlg.Show(True)
        self.dlg.Refresh()
        self.SetTopWindow(self.dlg)

        self.__hideFrame()
        return True
    
    def __hideFrame(self):
        self.frame.Move((-10000,-10000))
        self.frame.Hide()
    
    def checkMayaIsDone(self):
        if m.isMayaRunning:
            count = 0
            while(not hasattr(self,'dlg')):
                m.utils.processIdleEvents()
                count += 1 
                if count>10:
                    raise Exception("ERROR: wxmaya got stuck on progress class")
        self.__hideFrame()
   
    def setMsg(self, msg):
        self.update( msg=msg )
        
    def update(self, msg=None, count=None):
        self.checkMayaIsDone()

        ret = True
        if count:
            self.count=count
        if msg:
            self.msg = msg
        else:
            self.count += 1
            
        if self.count<=self.max:
            ret = self.dlg.Update(self.count, newmsg=self.msg)
            if not ret[0]:
                self.close()
                raise Exception("Execution aborted by user!")
        else:
            self.close()
        
        
    def close(self, event=None):
        if event:
            event.Skip()
        self.checkMayaIsDone()
        app.close(self, event)


if __name__ == '__main__':
    progress()
