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



import log
import m
import app
import wx

from controlBase import controlBase

class checkbox(controlBase):
    def __init__(self, panel, name='teste', attr=None):
        controlBase.__init__(self, panel, attr)
        self.control = wx.CheckBox(self.panel, -1, attr)#, (65, 40), (150, 20), wx.NO_BORDER)
        self.control.SetValue( bool(self.getAttr()) )

        self.panel.Bind(wx.EVT_CHECKBOX, self.callback, self.control)


    def callback(self, event):
        log.write('checkbox.callback: %d' % event.IsChecked())
        if self.attr and m.isMayaRunning:
            self.setAttr( int(event.IsChecked()) )
            
    def refresh(self, event):
        log.write('checkbox.refresh: %d' % event)
        if self.attr and m.isMayaRunning:
            value = self.getAttr()
            if self.attrValue != value:
                self.control.SetValue( bool(value) )
                self.attrValue = value

    def thread(self):
        if self.attr and m.isMayaRunning:
            value = self.getAttr()
            if self.attrValue != value:
                log.write( 'checkbox.thread: attr %s changed outside %s to %d' % (self.attr, __name__, value) )
                self.control.SetValue( bool(value) )
                self.attrValue = value
