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

#=====
# Nested Child
#
# This cookbook example renders a unit cube. It is designed to be called by
# the nestedParent example to demonstrate how to inject nested procedurals.
#
#=====

from IECore import *

class nestedChild(ParameterisedProcedural) :

        def __init__(self) :
                ParameterisedProcedural.__init__( self, "Child procedural." )

        def doBound(self, args) :
                return Box3f( V3f( -.5 ), V3f( .5 ) )

        def doRenderState(self, renderer, args) :
                pass

        def doRender(self, renderer, args) :
                MeshPrimitive.createBox( Box3f( V3f( -.5 ), V3f( .5 ) ) ).render( renderer )

# register
registerRunTimeTyped( nestedChild )