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


import IECore, pipe, tempfile

try: from importlib import reload
except: pass

import genericAsset
reload(genericAsset)

class gaffer( genericAsset.gaffer ) :
    _color = IECore.Color3f( 0.15 )

    def __init__( self ) :
        genericAsset.gaffer.__init__( self, 'bundle' )
        self.parameters()["%s%s" % (self.prefix, self.nameGroup)].userData().update({"UI" : {"visible" :  IECore.BoolData(False)}})


IECore.registerRunTimeTyped( gaffer )
