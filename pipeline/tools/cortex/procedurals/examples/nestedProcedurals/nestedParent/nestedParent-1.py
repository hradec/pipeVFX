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
# Nested Parent
#
# This cookbook example demonstrates how to inject many child procedurals from
# a single parent procedural.
#
# Here we create a random point cloud and inject the nestedChild procedural
# for each point.
#
#=====

from IECore import *
from random import *
import IECoreGL

class nestedParent(ParameterisedProcedural) :

        def __init__(self) :
                ParameterisedProcedural.__init__( self, "Description here." )
                self.__pdata = []
                seed(0)
                for i in range(100):
                        self.__pdata.append( V3f( random()*10, random()*10, random()*10 ) )

        def doBound(self, args) :
                return Box3f( V3f( 0 ), V3f( 10 ) )

        def doRenderState(self, renderer, args) :
                pass

        def doRender(self, renderer, args) :
                # loop through our points
                for p in self.__pdata:

                        # push the transform state
                        renderer.transformBegin()

                        # concatenate a transformation matrix
                        renderer.concatTransform( M44f().createTranslated( p ) )

                        # create an instance of our child procedural
                        procedural = ClassLoader.defaultProceduralLoader().load( "nestedProcedurals/nestedChild", 1 )()

                        # do we want to draw our child procedural immediately or defer
                        # until later?
                        immediate_draw = False
                        if renderer.typeId()==IECoreGL.Renderer.staticTypeId():
                                immediate_draw = True

                        # render our child procedural
                        procedural.render( renderer, withGeometry=True, immediateGeometry=immediate_draw )

                        # pop the transform state
                        renderer.transformEnd()

# register
registerRunTimeTyped( nestedParent )