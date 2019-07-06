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
# Mesh Render
#
# This cookbook example demonstrates how to load & render a mesh primitive from
# disk using a path specified through a path parameter.
#
#=====

from IECore import * 

class meshRender(ParameterisedProcedural) : 

        def __init__(self) : 
                ParameterisedProcedural.__init__( self, "Renders a mesh." )
                path = PathParameter( "path", "Path", "" )
                self.parameters().addParameter( path )

        def doBound(self, args) : 
                geo = Reader.create( args['path'].value ).read()
                return geo.bound()

        def doRenderState(self, renderer, args) : 
                pass

        def doRender(self, renderer, args) : 
                geo = Reader.create( args['path'].value ).read()
                geo.render( renderer )

#register
registerRunTimeTyped( meshRender )
