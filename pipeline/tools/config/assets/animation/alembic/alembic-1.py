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


import IECore, pipe

try: from importlib import reload
except: pass

import genericAsset
reload(genericAsset)

class alembic( genericAsset.alembic ) :
    _color = IECore.Color3f( 0.15, 0.5, 0.75 )

    def __init__( self ) :
        genericAsset.alembic.__init__(self, 'alembic' ,nameGroup='Mesh', )
        # self.setSubDivMeshesMask("*")
        # self.setImportAsGPU(True)

    def doImportMaya(self, filename, nodeName ):
        if genericAsset.m:
            # cleanup shading leftovers
            genericAsset.maya.cleanUnusedShadingNodes()

        return genericAsset.alembic.doImportMaya(self, filename, nodeName )

IECore.registerRunTimeTyped( alembic )
