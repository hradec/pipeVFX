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
# Point Render
#
# This cookbook example demonstrates how to create and render a Cortex
# PointsPrimitive. The procedural creates a points primitive and fills it with
# a specified number of points, within a specified bounding box.
#
#=====
from IECore import * 
from random import *

#generate a points primitive filling the bbox with npoints
def generatePoints( bbox, npoints ):
        seed(0)
        size = bbox.size()
        pdata = V3fVectorData()
        for i in range(npoints):
                pdata.append( V3f( random() * size.x + bbox.min.x,
                                                random() * size.y + bbox.min.y,
                                                random() * size.z + bbox.min.z ) )
        return PointsPrimitive( pdata )

#our point render procedural
class pointRender(ParameterisedProcedural) :
        def __init__(self) : 
                ParameterisedProcedural.__init__( self, "Description here." )
                bbox = Box3fParameter( "bbox", "Bounds for points.", Box3f(V3f(0), V3f(1)) )
                npoints = IntParameter( "npoints", "Number of points.", 100, minValue=0, maxValue=10000 )
                width = FloatParameter( "width", "Point width", 0.05  )
                self.parameters().addParameters( [ bbox, npoints, width ] )
                self.__points = None
                self.__npoints = None
                self.__bbox = None

        def generatePoints(self, args): 
                if args['npoints'].value!=self.__npoints or args['bbox'].value!=self.__bbox:
                        self.__points = generatePoints( args['bbox'].value, args['npoints'].value )
                        self.__npoints = args['npoints'].value
                        self.__bbox = args['bbox'].value
                return self.__points

        def doBound(self, args) : 
                self.generatePoints(args)
                return self.__points.bound()

        def doRenderState(self, renderer, args) : 
                pass

        def doRender(self, renderer, args) : 
                self.generatePoints(args)
                self.__points['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, args['width'] )
                self.__points.render( renderer )

#register
registerRunTimeTyped( pointRender )