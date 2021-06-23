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

# =================================================================================
# Point Render
#
# This cookbook example demonstrates how to create and render a Cortex
# PointsPrimitive. The procedural creates a points primitive and fills it with
# a specified number of points, within a specified bounding box.
#
# =================================================================================

'''
# to test in maya (copy/paste)
# =================================================================================

import IECoreMaya
import maya.cmds as m
import pipe

execfile( pipe.roots().tools()+"/cortex/procedurals/examples/pointRender/pointRender-1.py" )
m.delete( [ m.listRelatives(x, p=1)[0] for x in m.ls(type="ieProceduralHolder") ] )
p = m.createNode( "ieProceduralHolder" )
fp = IECoreMaya.FnProceduralHolder( "ieProceduralHolder1" )
fp.setParameterised( pointRender() )

# =================================================================================
''' 

import os
from IECore import *
from random import *

global linesRead, rdata, pdata, ndata, cdata
linesRead = 0
rdata = FloatVectorData()
pdata = V3fVectorData()
ndata = V3fVectorData()
cdata = Color3fVectorData()
idata = Color3fVectorData()

#generate a points primitive filling the bbox with npoints
def generatePoints( bbox, npoints ):
    # for i in range(npoints):
    #         pdata.append( V3f( random() * size.x + bbox.min.x,
    #                                         random() * size.y + bbox.min.y,
    #                                         random() * size.z + bbox.min.z ) )

        global linesRead, rdata, pdata, ndata, cdata
        seed(0)
        size = bbox.size()
        # rdata = FloatVectorData()
        # pdata = V3fVectorData()
        # ndata = V3fVectorData()
        # cdata = Color3fVectorData()
        ptc = open("/tmp/zz.ptc", "r")
        ptc.seek(linesRead)

        oldp = V3f( 0, 0, 0 )
        oldc = Color3f(0,0,0)
        oldcount = 0
        _n=0
        _nold=0
        for l in ptc:
            l = eval(l)
            if len(l) > 4:
                pp = l[1]
                p = V3f( float(pp[0]), float(pp[1]), float(pp[2]) )

                if p != oldp:
                    _n = _n+1
                    if _n/1000 > _nold:
                        _nold = _n/1000
                        print _n

                    r = float(l[0])
                    nn = l[2]
                    cc = l[3]
                    id = l[4]
                    c = Color3f( float(cc[0]), float(cc[1]), float(cc[2]) )
                    if id>0:
                        n = V3f( float(nn[0]), float(nn[1]), float(nn[2]) )
                        pdata.append(p)
                        rdata.append(r)
                        ndata.append(n)
                        cdata.append(c)
                        idata.append(Color3f( float(id)/10, float(id)/10, float(id)/10 ))
                        oldc = Color3f(0,0,0)
                        oldcount = 0

                    oldc = oldc+c
                oldp = p
                oldcount += 1


        linesRead = ptc.tell()
        ptc.close()
        return PointsPrimitive( pdata ), cdata, ndata, rdata, idata

#our point render procedural
class pointRender(ParameterisedProcedural) :
        def __init__(self) :
                ParameterisedProcedural.__init__( self, "Description here." )
                bbox = Box3fParameter( "bbox", "Bounds for points.", Box3f(V3f(-100), V3f(100)) )
                npoints = IntParameter( "npoints", "Number of points.", 100, minValue=0, maxValue=10000 )
                width = FloatParameter( "width", "Point width", 100.0  )
                widthmax = FloatParameter( "widthmax", "Max Point width", 0.10  )
                self.parameters().addParameters( [ bbox, npoints, width, widthmax ] )
                self.__points = None
                self.__npoints = None
                self.__bbox = None
                self.__color = None
                self.__normal = None
                self.__width = None
                self.__radius = None
                self.__widthMax = None


        def generatePoints(self, args):
                w=0
                if self.__width != args['width'].value or self.__widthMax != args['widthmax'].value:
                    w=1
                if args['npoints'].value!=self.__npoints or args['bbox'].value!=self.__bbox:
                        self.__npoints = args['npoints'].value
                        # self.__points, self.__color, self.__normal, self.__radius, self.__id = generatePoints( args['bbox'].value, args['npoints'].value )
                        self.__points = IECore.Reader.create("/tmp/ptc.cob").read()
                        self.__color = self.__points['Cs'].data
                        self.__normal = self.__points['N'].data
                        self.__radius = self.__points['width'].data
                        self.id = self.__points['id'].data
                        self.__bbox = args['bbox'].value
                        w=1

                if w>0:
                    self.__widthMax = args['widthmax'].value
                    self.__width = args['width'].value
                    self.radius = FloatVectorData()
                    for n in self.__radius:
                        s = n * self.__width
                        if s > self.__widthMax:
                            s = self.__widthMax;
                        self.radius.append( s )

                return self.__points

        def doBound(self, args) :
                self.generatePoints(args)
                return self.__points.bound()

        def doRenderState(self, renderer, args) :
                pass

        def doRender(self, renderer, args) :
                self.generatePoints(args)
                self.__points['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, self.radius )
                # self.__points['type'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "gl:point" ) )
                # if self.__npoints < 9000:
                #     self.__points['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, self.__color )
                # else:
                #     self.__points['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, self.__id )
                self.__points.render( renderer )
                print dir(self.__points)
                if os.path.exists("/tmp/ptc.cob"):
                    os.remove("/tmp/ptc.cob")
                IECore.Writer.create( self.__points, "/tmp/ptc.cob" ).write()


#register
registerRunTimeTyped( pointRender )
