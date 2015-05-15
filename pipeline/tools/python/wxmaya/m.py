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

##########################################################################
#
#  Copyright (c) 2010, Roberto Hradec. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of Image Engine Design nor the names of any
#       other contributors to this software may be used to endorse or
#       promote products derived from this software without specific prior
#       written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################



isMayaRunning = False
try:
    # if outside maya, init maya!
    try:
        import maya.standalone 
        maya.standalone.initialize( )
    except:
        pass

    # now import the modules we need into m
    from maya.cmds import * 
    from maya import utils
    from maya.mel import eval as mel
    import maya.OpenMaya as OpenMaya
    import math

    # trying to fix OSX
    import sys
    sys.stdin.write = lambda self, data: utils.executeDeferred(data)
    sys.stdin.flush = lambda self: None
    
    isMayaRunning = True


    def MObject(node):
        list = OpenMaya.MSelectionList()
        list.add( node )
        mobj = OpenMaya.MObject()
        list.getDependNode( 0, mobj )
        return mobj

    def MPlug(nodeAttr):
        import maya.OpenMaya as OpenMaya
        node, attr = nodeAttr.split('.')
        mobj  = MObject(node)
        mplug = OpenMaya.MPlug( mobj, MObject(nodeAttr) )
        return  mobj, mplug

    def error( msg ):
        cmd = 'error "%s"' % str(msg).replace('\\','/').replace('"','\\"').replace('\r','/r').replace('\n','\\n')
        print cmd
        try: mel( 'error "%s"' % str(msg).replace('\\','/').replace('"','\\"').replace('\r','/r').replace('\n','\\n') )
        except: pass
        
    def pythonError():
        import traceback
        errorMsg = traceback.format_exc()
        relayoutErrorMsg = errorMsg.find('Exception:')
        error( "%s%s" % (errorMsg[relayoutErrorMsg:], errorMsg[:relayoutErrorMsg]) )



    import os
    global scriptEditorCallbackID
    def redirectScriptEditor( file=os.path.join(os.environ['TMP'], 'mayaScriptEditorOutput.log') ):
        global scriptEditorCallbackID
        def callback(nativeMsg,   messageType, data):
            f=open( file, 'a')
            f.write('%s' % (nativeMsg) )
            f.close()
        
        try: 
            scriptEditorCallbackID
        except:
            import maya.OpenMaya as mo
            f=open( file, 'w')
            f.close()
            scriptEditorCallbackID = mo.MCommandMessage.addCommandOutputCallback(callback, None)

    def redirectScriptEditorStop():
        global scriptEditorCallbackID
        import maya.OpenMaya as mo
        mo.MCommandMessage.removeCallback(scriptEditorCallbackID)
        del scriptEditorCallbackID

    del os
    
    
    
    def isNodeVisible(node, lookUp=False):
        try:
            visibility   = not getAttr ( "%s.visibility" % node )          # the obvious one
            intermediate = getAttr( "%s.intermediateObject" % node)        # if its intermediate, its hidden
            displaylayer = not getAttr ( "%s.overrideVisibility" % node )  # display layer

            if visibility + intermediate + displaylayer:
                raise 

            if lookUp:
                parents = listRelatives( node, parent=True )
                if parents:
                    for parent in parents:
                        if not isNodeVisible( parent ):
                            raise
        except: 
            return False

        return True

    
        
    class meshOperator:
        '''
        a generic class to operate on meshes. It comes with some handy and simple
        methods to gather data, like vertex, normals, uv, etc.
        It also has some methods to modify the geo, for example bake vertex position into vertex color
        more to come...
        '''
        def __init__(self, node):
            ''' 
                meshOperator expects the node to be passes as a MDagPath object, so it
                stays unique even if renamed or parented
                if node parameter is string, we convert it to its apropriate MDagPath
            '''
            self.node = node
            if type(node) in [ str, unicode ]:
                self.node = OpenMaya.MDagPath.getAPathTo( MObject(node) )

            self.mesh = OpenMaya.MFnMesh(self.node)
            self.pointCache = {}
            self._vrtx4reset = vertex = self.getPoints()
            
        def _worldSpace(self, world):
            mspace = OpenMaya.MSpace.kObject
            if world:
                mspace = OpenMaya.MSpace.kWorld
            return mspace

        def _MtoList(self, arg):
            return [arg.x, arg.y, arg.z]

        def _ListToMVector(self, arg):
            return OpenMaya.MVector( arg[0], arg[1], arg[2])

        def _ListToMPoint(self, arg):
            return OpenMaya.MPoint( arg[0], arg[1], arg[2], 1.0)

        def _arrayToList(self, array):
            P=[]
            for n in range( array.length() ):
                P.append( [ array[n][0], array[n][1], array[n][2], array[n][3] ] )
            return P

        def _listToarray(self, P):
            array = OpenMaya.MPointArray()
            for n in P:
                array.append( OpenMaya.MPoint( n[0], n[1], n[2], n[3] ) )
            return array

        @staticmethod
        def PointRotate3D(p1, p2, p0, theta):
            ## Extracted from PointRotate.py Version 1.02 (http://local.wasp.uwa.edu.au/~pbourke/geometry/rotate/PointRotate.py)
            ## Copyright (c) 2006 Bruce Vaughan, BV Detailing & Design, Inc.
            ## All rights reserved.
            ## NOT FOR SALE. The software is provided "as is" without any warranty.
            #############################################################################
            
            p0 = OpenMaya.MPoint(p0[0],p0[1],p0[2],1)
            p1 = OpenMaya.MPoint(p1[0],p1[1],p1[2],1)
            p2 = OpenMaya.MPoint(p2[0],p2[1],p2[2],1)
            
            from math import cos, sin, sqrt

            # Translate so axis is at origin    
            p = p0 - p1
            # Initialize point q
            q = OpenMaya.MVector(0.0,0.0,0.0)
            N = (p2-p1)
            Nm = sqrt(N.x**2 + N.y**2 + N.z**2)
            
            # Rotation axis unit vector
            n = OpenMaya.MPoint(N.x/Nm, N.y/Nm, N.z/Nm)

            # Matrix common factors     
            c = cos(theta)
            t = (1 - cos(theta))
            s = sin(theta)
            X = n.x
            Y = n.y
            Z = n.z

            # Matrix 'M'
            d11 = t*X**2 + c
            d12 = t*X*Y - s*Z
            d13 = t*X*Z + s*Y
            d21 = t*X*Y + s*Z
            d22 = t*Y**2 + c
            d23 = t*Y*Z - s*X
            d31 = t*X*Z - s*Y
            d32 = t*Y*Z + s*X
            d33 = t*Z**2 + c

            #            |p.x|
            # Matrix 'M'*|p.y|
            #            |p.z|
            q.x = d11*p.x + d12*p.y + d13*p.z
            q.y = d21*p.x + d22*p.y + d23*p.z
            q.z = d31*p.x + d32*p.y + d33*p.z

            # Translate axis and rotated point back to original location    
            ret = p1 + q
            return [ret.x, ret.y, ret.z]
            
        def getPoints(self, worldSpace=False, force=True):
            if worldSpace not in self.pointCache or force:
                array = OpenMaya.MPointArray()
                self.mesh.getPoints( array, self._worldSpace(worldSpace) )
                self.pointCache[worldSpace] = self._arrayToList( array )
            return self.pointCache[worldSpace]
        
        def setPoints(self, points, worldSpace=False):
            array = self._listToarray( points )
            self.mesh.setPoints( array, self._worldSpace(worldSpace) )
        
        def getPivot(self, worldSpace=False):
            middle = []
            min, max = self.getBBox(worldSpace)
            for n in range(3):
                middle.append( min[n] + (max[n]-min[n])/2.0 )
            return middle
                
        def getBBox(self, worldSpace=False):
            min = [99999999999999999,99999999999999999,99999999999999999]
            max = [-99999999999999999,-99999999999999999,-99999999999999999]
            for vertex in self.getPoints(worldSpace):
                for n in range(3):
                    if vertex[n] < min[n]: 
                        min[n] = vertex[n]
                    if vertex[n] > max[n]: 
                        max[n] = vertex[n]
            return (min,max)
        
        def getNormals(self, worldSpace=False, angleWeighted=False):
            array = OpenMaya.MFloatVectorArray()
            self.mesh.getVertexNormals( angleWeighted, array, self._worldSpace(worldSpace) )
            return self._arrayToList( array )
            
        def resetPoints(self):
            self.setPoints(self._vrtx4reset)
            
        def bakeLocalPos2CBV(self, colorset = 'colorSet1'):
            name = self.node.fullPathName()
            try: polyColorSet( name, delete = True, colorSet = colorset )
            except: pass
            polyColorSet( name, create = True, colorSet = colorset )
            polyColorSet( name, currentColorSet = True, colorSet = colorset  )

            vtID = 0
            pivot = self.getPivot()

            for vertex in self.getPoints():
                vertexName = '%s.vtx[%d]' % ( name, vtID )
                polyColorPerVertex( vertexName,
                    r=vertex[0]-pivot[0],
                    g=vertex[1]-pivot[1],
                    b=vertex[2]-pivot[2],
                    a = 1
                )
                vtID += 1



        def bakeLocalPos2UV(self):
            name = self.node.fullPathName()

            uvsets = [ "billboardPosXY", "billboardPosZW" ]

            for uv in uvsets:
                try: polyUVSet( name, delete = True, uvSet = uv )
                except: pass

                polyCopyUV( name, uvi=uv, uvs='map1' )
                polyUVSet( name,  currentUVSet = True, uvSet=uv )
                '''
                vtID = 0
                pivot = self.getPivot()
                for vertex in self.getPoints():
                    vertexName =      '%s.vtx[%d]' % ( name, vtID )
                    polyColorPerVertex( vertexName,
                        r=vertex[0]-pivot[0],
                        g=vertex[1]-pivot[1],
                        b=vertex[2]-pivot[2],
                    )
                    vtID += 1
                '''

        def collapsePos2Pivot(self):
            vtID = 0
            pivot = self.getPivot()
            vertex = self.getPoints()
            for i in range(len(vertex)):
                for n in range(3):
                    vertex[i][n] -= (vertex[i][n]-pivot[n])*0.99
            self.setPoints(vertex)
            
        def scale(self, x,y,z):
            vtID = 0
            pivot = self.getPivot()
            vertex = self.getPoints()
            xyz=[x,y,z]
            for i in range(len(vertex)):
                for n in range(3):
                    vertex[i][n] += (vertex[i][n]-pivot[n])*xyz[n]
            self.setPoints(vertex)
            
        def rotate(self, x,y,z):
            worldSpace=True
            pivot = self.getPivot(worldSpace)
            mPivot = OpenMaya.MVector(pivot[0],pivot[1],pivot[2])
            vertex = self.getPoints(worldSpace)

            for i in range(len(vertex)):
                    
                p1 = pivot
                p0 = vertex[i]
                
                p2 = self._MtoList( mPivot + OpenMaya.MVector( 1,0,0 ) )
                p0 = self.PointRotate3D( p1, p2, p0, x )
                
                p2 = self._MtoList( mPivot + OpenMaya.MVector( 0,1,0 ) )
                p0 = self.PointRotate3D( p1, p2, p0, y )
                
                p2 = self._MtoList( mPivot + OpenMaya.MVector( 0,0,1 ) )
                p0 = self.PointRotate3D( p1, p2, p0, z )
                
                for n in range(3):
                    vertex[i][n] = p0[n]
            self.setPoints(vertex)
            
            
        def aimToPoint(self, aimPoint, worldSpace=True):
            pivot = self.getPivot(worldSpace)
            mPivot = OpenMaya.MVector(pivot[0],pivot[1],pivot[2])
            vertex = self.getPoints(worldSpace)
            normals = self.getNormals(worldSpace)
            aim =  mPivot - OpenMaya.MVector(aimPoint[0],aimPoint[1],aimPoint[2])

            # find card direction
            averageNormal = [0.0,0.0,0.0]
            for N in normals:
                for i in range(3):
                    averageNormal[i] += N[i]
            for i in range(3):
                averageNormal[i] /= len(normals)

            mAverageNormal = OpenMaya.MVector( averageNormal[0], averageNormal[1], averageNormal[2] )
            
            mAverageNormal .y = 0
            aim.y = 0

            mAverageNormal.normalize()
            aim.normalize()
            
            cos = mAverageNormal * aim
            angle = math.acos( cos )
            for i in range(len(vertex)):
                axisDir = 1
                if mPivot.x - aim.x < 0:
                    axisDir = -1
                    
                p1 = pivot
                p2 = self._MtoList( mPivot + OpenMaya.MVector( 0,axisDir,0 ) )
                p0 = vertex[i]
                
                newV = self.PointRotate3D( p1, p2, p0, angle )
                for n in range(3):
                    vertex[i][n] = newV[n]
            self.setPoints(vertex)

        
except:
    isMayaRunning = False





