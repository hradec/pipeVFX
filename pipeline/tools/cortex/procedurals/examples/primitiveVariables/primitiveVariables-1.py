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
# Primitive Variables
#
# This cookbook example demonstrates how to assign a primitive variable
# to a renderable. It is based very closely on the Points Render cookbook
# example, but adds an additional Cs primitive variable which shaders can
# use to colour the points.
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

#our primitive variable render procedural
class primitiveVariables(ParameterisedProcedural) :

        def __init__(self): 
                ParameterisedProcedural.__init__( self, "Description here." )
                bbox = Box3fParameter( "bbox", "Bounds for points.", Box3f(V3f(0), V3f(1)) )
                npoints = IntParameter( "npoints", "Number of points.", 100, minValue=0, maxValue=10000 )
                width = FloatParameter( "width", "Point width", 0.05  )
                colorIntensity = FloatParameter( "colorIntensity", "Intensidade da cor", 2.0  )
                self.parameters().addParameters( [ bbox, npoints, width, colorIntensity ] )
                self.__points = None
                self.__npoints = None
                self.__bbox = None

        def generatePoints(self, args): 
                if args['npoints'].value!=self.__npoints or args['bbox'].value!=self.__bbox:
                        self.__points = generatePoints( args['bbox'].value, args['npoints'].value )
                        self.__npoints = args['npoints'].value
                        self.__bbox = args['bbox'].value
                return self.__points

        def doBound(self, args): 
                self.generatePoints(args)
                return self.__points.bound()

        def doRenderState(self, renderer, args):
                pass 

        def doRender(self, renderer, args): 
                self.generatePoints(args)
                self.__points['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, args['width'] )

                # create an array of colours, one per point 
                colours = []
                for i in range( self.__points['P'].data.size() ):
                        colours.append( Color3f( random(), random(), random() ) * args['colorIntensity'].value )
                colour_data = Color3fVectorData( colours )

                # attach as a Cs primitive variable 
                self.__points['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, colour_data )

                # render 
                self.__points.render( renderer )

#register
registerRunTimeTyped( primitiveVariables )