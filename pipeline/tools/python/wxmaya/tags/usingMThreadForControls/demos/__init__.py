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


import wxmaya
import wx

from dockingWindowDemo import  dockingWindowDemo


class controls(wxmaya.app):
    def OnInitUI(self):
        self.cb1 = wxmaya.checkbox(self.panel, 'testing wxmaya.checkbox', 'perspShape.renderable')
        self.b1  = wxmaya.button(self.panel, 'testing wxmaya.checkbox')
        




# helloWorldGL need pyOpenGl to work, so if pyOpenGL is not installed, 
# we just ignore it. 
# TODO: add a class to initialize opengl using either Maya OpenMayaRender or Python OpenGL
try:
    import helloWorldGL
    reload(helloWorldGL)
    from helloWorldGL import helloWorldGL
except:
    pass
        


