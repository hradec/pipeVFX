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

class button(controlBase):
    def __init__(self, panel, name='teste', default=False, attr=None, pos=[0,0], size=[10,200], style=0, validator=wx.Validator()):
        controlBase.__init__(self, panel, attr)
        self.name = name
        self.control = wx.Button(self.panel, -1, name, pos, size, style, validator, name)#, (65, 40), (150, 20), wx.NO_BORDER)
        
        #self.control.SetDefault(default)
        
        self.panel.Bind(wx.EVT_BUTTON, self.callback, self.control)


    def callback(self, event):
        log.write('button.callback: %s' % (self.name) )
        if self.attr and m.isMayaRunning:
            self.setAttr( int(event.IsChecked()) )
            

