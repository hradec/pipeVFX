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


import IECore
from IECore import *
import Asset
import os, time, sys

class shave(ParameterisedProcedural) :

    def __init__(self) :
        ParameterisedProcedural.__init__( self, "shave procedural." )


        meshList = IECore.CompoundParameter("meshCutoutList","A list of meshes that cutout the hair when they get close to it.",
        [
            IECore.FloatParameter(
    			name = "maxDistance",
    			description = "the maximum distance of the meshes from the hair",
    			defaultValue = 1,
    		),
            IECore.FloatParameter(
    			name = "maxDistanceTip",
    			description = "the maximum distance of the meshes from the hair",
    			defaultValue = 2,
    		),
            BoolParameter("debugRender", "Set this to render the curves as RED instead of hidding then.",False)
        ]+[
            IECore.MeshPrimitiveParameter(
    	        "mesh%02d" % n,
    	        "The target mesh to cutout curves.",
    	        MeshPrimitive()
    	    )
        for n in range(10)])

        path = FileSequenceParameter(
            name = "path",
            description = "A file sequence of animation caches to be applied. "
                          "Use # characters to specify the frame number.",
            userData = {"UI":{ "invertEnabled" : BoolData(True) }},
            check = FileSequenceParameter.CheckType.DontCare,
            extensions="pdc cob abc ptc",
        )

        self.asset = Asset.AssetParameter(publish=False)

        startFrame  = IntParameter(
            name="startFrame",
            description = "The frame were this cache will start to show up.",
            defaultValue = 0,
        )
        startCacheFrame  = IntParameter(
            name="cacheFrameOffset",
            description = "Offset the start of a file cache. For example, if cacheFrameOffset=10 and startFrame=20, the procedural will start showing the cache frame 10, at frame 20. Nothing will be showed before that!",
            defaultValue = 0,
        )
        rootWidth = IECore.FloatParameter(
			name = "rootWidth",
			description = "size of each hair at root.",
			defaultValue = 0.05,
		)
        tipWidth = IECore.FloatParameter(
			name = "tipWidth",
			description = "size of each hair at tip.",
		    defaultValue = 0.001,
		)
        mblur = FloatParameter("motionBlurMult", "Multiply the motion vector to attenuate or exagerate final motion blur.",1.0)
        dice  = BoolParameter("diceAsHair", "Denpending on the shader used, this can improve the quality of the hair/fur",True)
        round = BoolParameter("curvesAsTubes", "Render each hair as round tubes. This creates proper Normals for the curves, and can improve vibility of individual strands.\n Good to simulate cotton and other fibers that are not so translucent as hair and fur.\n Turn this on to use standard shaders with the curves!",False)

        curveType = IntParameter("curvesType", "Choose how to interpolate the curves ate rendertime.", 1, presets = [
            ('linear',0),
            ('b-spline',1),
            # ('bezier',2),
            ('catmull-rom',3),
        ],presetsOnly = True)


        shaveName= StringParameter("shaveName", "identifier name used in the rib to attach shaders to, using dinamic rules.","shaveShape")
        camera   = BoolParameter("visibilityCamera", "camera visibility",True)
        indirect = BoolParameter("visibilityIndirect", "visible for indirect rays, like indirect specular, indirect diffuse, refraction and subsurface.",True)
        transmis = BoolParameter("visibilityTransmission", "visible for shadow rays.",True)
        maxDiff  = FloatParameter("maxDiffuseDepth", "maximun depth a ray will go to get indirect diffuse",4)
        maxSpec  = FloatParameter("maxSpecularDepth", "maximun depth a ray will go to get indirect specular",4)
        traceset = StringParameter("traceset", "traceset group to isolate this object for raytrace.\nThe name used here can be used in shaders to specify if the shader can use or ignore this when doing tracing operations.\nThe default +reflection,refraction,shadow makes this object visible to these type of rays.\nFor example, removing reflection will make it disapear from all reflections!","+reflection,refraction,shadow")
        passID   = StringParameter("IDPrimvarName", "the name of a primvar which will hold a value of 1.0 for all the curves in the procedural, so it can be used by PxrPrimvar to output an ID AOV for the node!", "shaveID")

        gl = CompoundParameter("viewportDisplay","",[
            BoolParameter("debugCutoutGeometry", "Display cuted out curves as red in the viewport.",False),
            IntParameter("displayPercentage", "The percentage of hairs to show in the viewport. Use this to be able to see a cache when there's too much curves!",100,userData = { "UI": {"visible" : BoolData(False)}}),
            IECore.FloatParameter(
    			name = "Kd",
    			description = "How much diffuse to have.",
    			defaultValue = 1,
    		),
            BoolParameter("displayHairColors", "Display the rootColor and tipColor primitive variables stored on each hair, instead of the constant values below!",False),
    		IECore.Color3fParameter(
    			name = "rootColor",
    			description = "The colour of the hair root.",
    			defaultValue = IECore.Color3f( 0 ),
    		),
    		IECore.Color3fParameter(
    			name = "tipColor",
    			description = "The colour of the hair tip.",
    			defaultValue = IECore.Color3f( 1 ),
    		),
            BoolParameter("velocity", "display velocity vector, used for motion blur.",False)
        ])

        hidden = CompoundParameter("dataFromHostApp","",[
            FloatParameter("frame", "",1, userData=CompoundObject({"maya" : {"defaultConnection" : StringData( "time1.outTime" )}}))
        ],userData = { "UI": {"visible" : BoolData(False)}})

        self.parameters().addParameters([
            self.asset,
            path,
            startFrame,
            startCacheFrame,
            mblur,
            rootWidth,
            tipWidth,
            round,
            dice,
            curveType,
            shaveName,
            passID,
            camera,indirect,transmis,maxDiff,maxSpec,traceset,
            meshList,
            gl,
            hidden
        ])

    def _file(self, args, frame=None):
        if not frame:
            frame = int(args['dataFromHostApp']['frame'].value)
        start = args['startFrame'].value
        offset = args['cacheFrameOffset'].value
        path = args['path'].value

        if '$F4' in path:
            path = path.replace('$F4', '####' )

        if '###' in path:
            path = FileSequence( path ).fileNameForFrame(frame+offset)

        # if file doesn't exist, get the first or last of the cache, depending of the frame position.
        if not os.path.exists(path):
            from glob import glob
            files = glob( "%s.*.cob" % os.path.splitext(os.path.splitext(str(args['path']))[0])[0] )
            if files:
                files.sort()
                frames = { int(x.split('.')[-2]):x for x in files }
                path = frames[ min(frames, key=lambda s:abs(s-frame)) ]
                # print '''SHAVE PROCEDURAL WARNING: Cache for frame %s doesn't exist. Using %s instead!''' % (frame, path)
        return path

    def _read(self, args, renderer):
        cf = None
        f = self._file(args)
        fp = self._file(args, int(args['dataFromHostApp']['frame'].value)-1)
        if f:
            # print f
            cf = Reader.create( f ).read()
            cf.shutter = self.shutter(renderer)
            if ( cf.shutter or args["viewportDisplay"]["velocity"].value ) and fp!=f:
                t=time.time()
                print "Calculating velocity vector using previous frame..."
                pf = Reader.create( fp ).read()
                v = [ cf['P'].data[n] - pf['P'].data[n] for n in range(len(cf['P'].data)) ]
                print "Calculating velocity vector using previous frame took: %.02f secs" % float(time.time()-t)
                cf['velocity'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, V3fVectorData(v) )

            cf.name = os.path.basename(fp)
        return cf


    def shutter(self, renderer):
        shutterArea = 0.0
        if renderer.typeName() == "IECoreRI::Renderer":
            # get the shutter open/close values from the renderer
            try:
                shutter = renderer.getOption('shutter').value # this is a V2f
                shutterArea = shutter[1] - shutter[0]
            except:
                shutterArea = 0.0

        return shutterArea

    def doBound(self, args) :
        f = self._file(args)
        if f:
            geo = Reader.create( f ).read()
            return geo.bound()
        else:
            return Box3f(V3f(1,1,1), V3f(-1,-1,-1))

    def doRenderState(self, renderer, args) :
        pass

    def _log( self, geo, msg ):
        print "CORTEX SHAVE PROCEDURAL: %s - %s" % (geo.name, msg)
        sys.stdout.flush()

    def fillMeshWithParticles( self,  mesh, numParticles ) :

    	# mesh = IECore.Reader.create( meshFile ).read()
    	# mesh = IECore.TriangulateOp()( input=mesh, throwExceptions=False )
    	meshEvaluator = IECore.MeshPrimitiveEvaluator( mesh )

    	bound = mesh.bound()
    	boundMin = bound.min
    	boundMax = bound.max
    	boundSize = bound.size()

    	positions = IECore.V3fVectorData()
    	radii = IECore.DoubleVectorData()
    	particleBound = IECore.Box3f()

    	random = IECore.Rand32()

    	while len(positions) < numParticles :

    		p = random.nextV3f() * boundSize + boundMin
    		d = meshEvaluator.signedDistance( p )

    		if d < 0.0 :
    			p = IECore.V3f( p )
    			positions.append( p )
    			particleBound.extendBy( p )
    			radii.append( 1.0 )

    	particles = IECore.PointsPrimitive( len(positions) )
    	particles['P'] = IECore.PrimitiveVariable( IECore.PrimitiveVariable.Interpolation.Vertex, positions )
    	particles['radius'] = IECore.PrimitiveVariable( IECore.PrimitiveVariable.Interpolation.Vertex, radii )
    	particles['boundMin'] = IECore.PrimitiveVariable( IECore.PrimitiveVariable.Interpolation.Constant, IECore.V3d( boundMin ) )
    	particles['boundMax'] = IECore.PrimitiveVariable( IECore.PrimitiveVariable.Interpolation.Constant, IECore.V3d( boundMax ) )

    	return particles

    def _hide( self, geo, args ):
        import IECore,  os
        # os.environ["CORTEX_POINTDISTRIBUTION_TILESET"] = "/atomo/home/rhradec/dev/pipevfx.git/pipeline/build/.build/cortex-9.13.2.python2.7.12core_boost_1_56_0/test/IECore/data/pointDistributions/pointDistributionTileSet2048.dat"
        t = time.time()

        pe=[]
        per=[]
        points=[]
        pointsE=[]
        pointsR=[]
        for n in range(10):
            mesh = args["meshCutoutList"]["mesh%02d" % n]
            # print mesh.keys()
            if 'P' in mesh.keys() and len(mesh['P'].data):
                mesh = TriangulateOp()( input = mesh, throwExceptions=0 )
                pe  += [ IECore.PrimitiveEvaluator.create(mesh) ]
                per += [ pe[-1].createResult() ]

                points  += [self.fillMeshWithParticles( mesh, 10000 )]
                pointsE += [ IECore.PrimitiveEvaluator.create(points[-1]) ]
                pointsR += [ pointsE[-1].createResult() ]




        c=geo
        hide=[0.0] * c.numCurves()
        if pe:
            self._log( c, "removing curves occluded by cutout geometry." )
            maxDist = args["meshCutoutList"]["maxDistance"].value
            maxDistTip = args["meshCutoutList"]["maxDistanceTip"].value
            debugRender = float(args["meshCutoutList"]["debugRender"].value)
            # cos = args["meshCutoutList"]["hairMeshNormalCosine"].value
            root=args['rootWidth'].value
            tip = args['tipWidth'].value
            size = root - tip
            w=[]
            cv=0
            vpc = c.verticesPerCurve()
            for n in range(c.numCurves()):
                nv = vpc[n]
                tip = c['P'].data[cv+nv-1]
                base = c['P'].data[cv]
                middle = c['P'].data[cv+int(nv/2)]

                hide[n] = 0.0
                for m in range(len(pe)):
                    if hide[n]!=0.0:
                        break

                    # N   = (base-tip).normalize()

                    # cDir = base-tip
                    # cDirMiddle = base-middle
                    #
                    # # find the closest point on the mesh to the BASE of the curve
                    # pe[m].closestPoint(base, per[m])
                    # baseMeshP = per[m].point()
                    # B2M  = baseMeshP - base
                    # # T2BM = baseMeshP -tip
                    #
                    # # # find the closest point on the mesh to the TIP of the curve
                    # pe[m].closestPoint(tip, per[m])
                    # tipMeshP = per[m].point()
                    # T2M = tip - tipMeshP
                    # #
                    # # # find the closest point on the mesh to the TIP of the curve
                    # pe[m].closestPoint(middle, per[m])
                    # middleMeshP = per[m].point()
                    # M2M = middle - middleMeshP
                    #
                    #
                    # # find the closest point on the filled points to the BASE of the curve
                    # pointsE[m].closestPoint(base, pointsR[m])
                    # basePointsP = pointsR[m].point()
                    # B2P  = basePointsP - base


                    # trace a ray and find intersection with the mesh
                    # if B2M.length() < maxDist or T2M.length() < maxDistTip or M2M.length() < maxDistTip  or B2P.length() < maxDistTip:


                    #''' signedDistance  is better than closestPoint, since it calculates the distance from the point to the mesh, not the vertices.
                    #if distance is < 0, means the point is inside the mesh.
                    #'''
                    baseDist = pe[m].signedDistance( base )
                    if baseDist <  0.0:
                        hide[n] = 0.1+abs(baseDist)
                    else:
                        middleDist = pe[m].signedDistance( middle )
                        if middleDist < 0.0:
                            hide[n] = 0.1+abs(middleDist)
                        else:
                            tipDist = pe[m].signedDistance( tip )
                            if tipDist < 0.0:
                                hide[n] = 0.1+abs(tipDist)

                    #''' if distance to base/middle/tip is bigger than 0, then we trace a ray to see if the curve intersects the surface! '''
                    if hide[n] < 0.1:
                        if baseDist < maxDist or middleDist < maxDistTip or tipDist < maxDistTip:
                            # hide[n] = 0.09
                            direction = tip - base
                            if pe[m].intersectionPoint( base-direction.normalize()*6, direction.normalize(), per[m], direction.length()+6 ):
                                hide[n] = 0.1+( per[m].point() - base ).length()

                            else:
                                direction = middle - base
                                if pe[m].intersectionPoint( base-direction.normalize()*6, direction.normalize(), per[m], direction.length()+6 ):
                                    hide[n] = 0.1+( per[m].point() - base ).length()


                    # visible = 0 if hide[n] < 0.1 else ((1-debugRender)*root)
                    # step = float(size) / (c.numSegments(n) - adjust)
                    # w += [ max(root - x*step - visible, 0) for x in range( vpc[n] ) ]



                        # if pe[m].intersectionPoints( base, -direction ):
                        #      hide[n] = 1
                            #
                            # for hit in  pe[m].intersectionPoints( base, direction ):
                            #     # print (base - per[m].point()).length(), cDir.length()
                            #     rayV = base - hit.point()
                            #     # rayN = hit.normal().normalize()
                            #     # if rayV.length() / (tip-base).length() < 1.0 and rayN.dot(rayV) < 0.0:
                            #     hide[n] += rayV.length() / direction.length()
                            #     # break

                        # if pe[m].intersectionPoint( middle, middle-base, per[m] ):
                        #     rayV = (middle - per[m].point()).normalize()
                        #     rayN = per[m].normal().normalize()
                        #     # if rayV.length() / (tip-base).length() < 1.0 and rayN.dot(rayV) < 0.0:
                        #     hide[n] = -rayN.dot(rayV)

                        #     hide[n] = (base - per[m].point()).length() / cDirMiddle.length()


                    # if abs(B2M.length()) < maxDist or abs(T2BM.length()) < maxDist:
                    #     hide[n] = 1
                    #
                    # elif abs(T2M.length()) < maxDistTip and T2M.normalize().dot((base-tipMeshP).normalize())<0.0:
                    #     hide[n] = 1
                    #
                    # elif abs(M2M.length()) < maxDistTip and M2M.normalize().dot((base-middleMeshP).normalize())<0.0:
                    #     hide[n] = 1

                        # N   = (tip-base).normalize()
                        # Ng  = per[m].normal().normalize()
                        # B2Mn = V3f(B2M).normalize()
                        #
                        #
                        # if T2Mn.dot(Ng) < cos or B2Mn.dot(Ng) < cos:
                        #     hide[n] = 0.1+abs(T2Mn.dot(Ng))
                        #     # self._log( c, " ".join([
                        #     #     "T2Mn.dot(Ng): %   3.02f" % T2Mn.dot(Ng),
                        #     #     "B2Mn.dot(Ng): %   3.02f" % B2Mn.dot(Ng),
                        #     #     "N.dot(Ng): %   3.02f" % N.dot(Ng),
                        #     # ]) )
                        #
                        # elif T2Mn.dot(N) < cos or B2Mn.dot(N) < cos:
                        #     hide[n] = 0.1+abs(T2Mn.dot(N))
                        #     # self._log( c, " ".join([
                        #     #     "T2Mn.dot(N): %   3.02f" % T2Mn.dot(N),
                        #     #     "B2Mn.dot(N): %   3.02f" % B2Mn.dot(N),
                        #     #     "N.dot(Ng): %   3.02f" % N.dot(Ng),
                        #     # ]) )
                        # elif N.dot(Ng) > cos:
                        #     hide[n] = 0.1+abs(N.dot(Ng))
                    # else:
                    #     self._log( c, " ".join([
                    #         ": %   3.02f" % (baseMeshP - tipMeshP).length(),
                    #     ]) )

                        # self._log( c, " ".join([
                        #     "T2M.length(): %   3.02f" % T2M.length(),
                        #     "B2M.length(): %   3.02f" % B2M.length(),
                        #     "T2Mn.dot(Ng): %   3.02f" % T2Mn.dot(Ng),
                        #     "T2Mn.dot(N) : %   3.02f" % T2Mn.dot(N),
                        #     "B2Mn.dot(Ng): %   3.02f" % B2Mn.dot(Ng),
                        #     "B2Mn.dot(N) : %   3.02f" % B2Mn.dot(N),
                        # ]) )
                    # else:
                cv += nv

            self._log( c, "took %.02f secs to calculate what curves are hidden by cutout geometry." % (time.time()-t) )
        return IECore.PrimitiveVariable( IECore.PrimitiveVariable.Interpolation.Uniform, IECore.FloatVectorData( hide ) )
        # IECore.Writer.create(c,'/tmp/aa.0001.cob').write()

    def doRender(self, renderer, args):
        geo = self._read(args, renderer)
        if not geo:
            geo = IECore.CurvesPrimitive(

            			IECore.IntVectorData( [ 10 ] ),
            			IECore.CubicBasisf.linear(),
            			False,
            			IECore.V3fVectorData( [ x-IECore.V3f( 0.5, 0.5, 0 ) for x in
            				[
            					IECore.V3f( 0.8, -0.2, 0 ),
            					IECore.V3f( 0.8, -0.2, 0 ),
            					IECore.V3f( 0.8, -0.2, 0 ),
            					IECore.V3f( 0.8, 0.2, 0 ),
            					IECore.V3f( 0.2, 0.2, 0 ),
            					IECore.V3f( 0.2, 0.8, 0 ),
            					IECore.V3f( 0.8, 0.8, 0 ),
            					IECore.V3f( 0.8, 1.2, 0 ),
            					IECore.V3f( 0.8, 1.2, 0 ),
            					IECore.V3f( 0.8, 1.2, 0 ),
            				]]
            			)

            		)
            geo.shutter = 0

        # geo['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(args['setupParticles']['width'].value) )
        # print geo.cubicRibbonsGeometrySource()
        debugRender = float(args["meshCutoutList"]["debugRender"].value)
        with AttributeBlock( renderer ) :
            if renderer.typeName()!="IECoreRI::Renderer" :
                # uv=[]
                # t=time.time()
                # for c in geo.verticesPerCurve():
                #     stepUV = 1.0 / c
                #     uv += [ V3f(x*stepUV) for x in range( c ) ]
                # geo['uv'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, V3fVectorData( uv ) )
                # print "CORTEX PROCEDURAL: took %.02f secs to create curves uv data" % (time.time()-t)

                p=IECore.CurvesPrimitive(geo.verticesPerCurve(), IECore.CubicBasisf.linear())
                p.name          = geo.name
                # p=IECore.CurvesPrimitive(geo.verticesPerCurve(), IECore.CubicBasisf.bSpline())
                p['P']          = geo['P']

                if args["viewportDisplay"]["displayHairColors"].value:
                    p['rootColor']  = geo['rootColor']
                    p['tipColor']   = geo['tipColor']


                if 'U' in geo.keys():
                    p['U']          = geo['U']

                if 'uv' in geo.keys():
                    p['uv']          = geo['uv']

                if 'velocity' in geo.keys():
                    p['velocity']    = geo['velocity']


                if int(args["viewportDisplay"]["debugCutoutGeometry"].value) > 0:
                    p['hide'] = self._hide(p, args)
                # p = pp

                group = Group()
                group.addChild( p )
                # Set up how our hair will render
                self.__setupGLRenderer( renderer )

                # Set up our shading
                numcv = len(geo['P'].data)
                perc = float(args["viewportDisplay"]["displayPercentage"].value) / 100.0
                shader = self.__setupGLShader( args, 'U' in p.keys() )
                group.addState( shader )
                shader.parameters["Kd"] = args["viewportDisplay"]["Kd"]
                shader.parameters["rootColor"] = args["viewportDisplay"]["rootColor"]
                shader.parameters["tipColor"] = args["viewportDisplay"]["tipColor"]
                shader.parameters["perc"] = perc
                shader.parameters["numCurves"] = numcv
                shader.parameters["bla"] = (numcv / (numcv * perc)) if args["viewportDisplay"]["displayPercentage"].value < 100.0 else 1.0
                shader.parameters["displayPrimVarColors"] = float(args["viewportDisplay"]["displayHairColors"].value )
                shader.parameters["displayVelocity"] = float(args["viewportDisplay"]["velocity"].value )
                shader.parameters["debugHide"] = float(args["viewportDisplay"]["debugCutoutGeometry"].value)
                shader.parameters["debugHideRender"] = float(debugRender)





                # print args['dataFromHostApp']['frame'].value
                group.render( renderer )

            else:
                t = time.time()

                root=args['rootWidth'].value
                tip = args['tipWidth'].value
                adjust = 0

                if args['curvesType'].value == 0:
                    p=IECore.CurvesPrimitive(geo.verticesPerCurve(), IECore.CubicBasisf.linear())
                    adjust = 2
                elif args['curvesType'].value == 1:
                    p=IECore.CurvesPrimitive(geo.verticesPerCurve(), IECore.CubicBasisf.bSpline())
                elif args['curvesType'].value == 2:
                    p=IECore.CurvesPrimitive(geo.verticesPerCurve(), IECore.CubicBasisf.bezier())
                elif args['curvesType'].value == 3:
                    p=IECore.CurvesPrimitive(geo.verticesPerCurve(), IECore.CubicBasisf.catmullRom())

                p.name          = geo.name
                p['P']          = geo['P']
                if 'tipColor' in geo.keys():
                    p['tip']   = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, DataConvertOp()( data = geo['tipColor'].data, targetType = Color3fVectorData.staticTypeId() ) )
                if 'rootColor' in geo.keys():
                    p['root']  = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, DataConvertOp()( data = geo['rootColor'].data, targetType = Color3fVectorData.staticTypeId() ) )


                p['hide'] = self._hide(p, args)
                p[ args["IDPrimvarName"].value ] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData( 1.0 ) )

                size = root - tip
                vpc = p.verticesPerCurve()
                w=[]
                # uv=[]

                for n in range(p.numCurves()):
                    visible = 0 if p['hide'].data[n] < 0.1 else ((1-debugRender)*root)
                    step = float(size) / (p.numSegments(n) - adjust)
                    w += [ max(root - x*step - visible, 0) for x in range( vpc[n] ) ]
                    # stepUV = 1.0 / (c-1)
                    # uv += [ V2f(x*stepUV) for x in range( c ) ]
                # geo['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, FloatVectorData( w ) )
                # geo['uv'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, V2fVectorData( uv ) )

                p['width']      = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, FloatVectorData( w ) )
                # p['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, FloatData( 0.1 ) )

                self._log( p, "time to setup curves width: %.02f secs" % (time.time()-t) )

                groups =  args['shaveName'].value.split('/')

                _g = Group()
                g = _g
                for group in groups:
                    ng = Group()
                    g.addChild( ng )
                    g = ng
                    g.setAttribute( "ri:identifier:name", StringData( group ) )

                g.setAttribute( "ri:dice:hair", FloatData( args['diceAsHair'].value ) )
                g.setAttribute( "ri:dice:roundcurve", FloatData( args['curvesAsTubes'].value ) )
                g.setAttribute( "ri:visibility:camera", FloatData( args['visibilityCamera'].value ) )
                g.setAttribute( "ri:visibility:indirect", FloatData( args['visibilityIndirect'].value ) )
                g.setAttribute( "ri:visibility:transmission", FloatData( args['visibilityTransmission'].value ) )
                g.setAttribute( "ri:trace:maxdiffusedepth", FloatData( args['maxDiffuseDepth'].value ) )
                g.setAttribute( "ri:trace:maxspeculardepth", FloatData( args['maxSpecularDepth'].value ) )
                g.setAttribute( "ri:shade:transmissionhitmode", 'shader' )
                g.setAttribute( "ri:grouping:membership", StringData( args['traceset'].value ) )
                g.addChild(p)

                if not debugRender:
                    _g.render( renderer )
                else:
                    rib = '''
                        Pattern "PxrVariable" "primvar" "string variable" [""] "string name" ["hide"] "string type" ["float"] "string coordsys" [""]
                        Pattern "PxrMix" "mix" [0.081466 0.081466 0.161] "color color2" [1 0 0] "reference float mix" ["primvar:resultR"]
                        Bxdf "PxrConstant" "constant" "reference color emitColor" ["mix:resultRGB"] "float presence" [1]'''
                    renderer.setAttribute( "ri:identifier:name", StringData( "______DEBUG______" ) )
                    renderer.command( "ri:archiveRecord", { "type" : IECore.StringData( "verbatim" ), "record" : IECore.StringData( rib ) } )
                    p.render( renderer )

    ## This simply sets up a couple of attributes to control how things will render
    def __setupGLRenderer( self, renderer ):

        renderer.setAttribute( "gl:curvesPrimitive:useGLLines", BoolData( True ) )
        renderer.setAttribute( "gl:curvesPrimitive:ignoreBasis", BoolData( True ) )
        # renderer.setAttribute( "gl:curvesPrimitive:glLineWidth", IECore.FloatData( 0.1 ) )

        ## The draw states prevent the wireframe being drawn on top of the hair
        ## when selected, which obscures it.
        renderer.setAttribute( "gl:primitive:wireframe", BoolData( False ) )
        renderer.setAttribute( "gl:primitive:solid", BoolData( True ) )

    def __setupGLShader( self, args, useU=True ):
        declare = 'in vec3 vertexuv;'
        setvar  = 'U=vertexuv.z;'
        if useU:
            declare = 'in float vertexU;'
            setvar  = 'U=vertexU;'
        vertexSource = """#version 120

            #if __VERSION__ <= 120
                #define in attribute
                #define out varying
            #endif

            in vec3 vertexP;
            in vec3 vertextipColor;
            in vec3 vertexrootColor;
            %s
            in vec3 vertexvelocity;
            in float vertexhide;
            in vec3 vertexsurfaceN;
            in vec3 vertexwidth;
            in float vertexhairID;

            out vec3 P;
            out vec3 tip;
            out vec3 root;
            out float U;
            out vec3 uv;
            out vec3 velocity;
            out vec3 N;
            out vec3 width;
            out float ID;
            out float hide;

            void main()
            {
            	vec4 pCam = gl_ModelViewMatrix * vec4( vertexP , 1 );
                gl_Position = gl_ProjectionMatrix * pCam ;

                P = vertexP;
                root = vertexrootColor;
                tip = vertextipColor;
                velocity = vertexvelocity;
                N = vertexsurfaceN;
                width = vertexwidth;
                ID = vertexhairID;
                hide = vertexhide;
                %s
            }
        """ % (declare, setvar)

        fragmentSource = """#version 120

            #if __VERSION__ <= 120
                #define in varying
            #endif

            uniform float numCurves;
            uniform float perc;
            uniform float Kd;
            uniform float bla;
            uniform vec3 rootColor;
            uniform vec3 tipColor;
            uniform float displayPrimVarColors;
            uniform float displayVelocity;
            uniform float debugHide;
            uniform float debugHideRender;

            in vec3 P;
            in vec3 tip;
            in vec3 root;
            in float U;
            in vec3 uv;
            in vec3 velocity;
            in vec3 N;
            in float width;
            in float ID;
            in float hide;

            void main()
            {
                /* if(bla==1.0){
                    float tmp = ID / bla;
                    if( tmp - int(tmp) > 0.0 ){
                        discard;
                    }
                }*/

                vec3 cor = mix(rootColor,tipColor,U);
                if ( displayPrimVarColors > 0.0 ){
                    cor = mix(root,tip,U);
                }

            	vec3 d = Kd * cor;
                if (displayVelocity>0.0){
                    d=velocity;
                }

                if (debugHide>0.0){
                    if (debugHideRender>0.0){
                        d = vec3(hide,0.0,0.0);
                        if(hide<0.1)
                            d += vec3(0.0,0.0,0.3);
                    }else{
                        if(hide>=0.1)
                            discard;
                    }
                }
            	gl_FragColor = vec4( d , 1.0 );
            }
        """

        s = IECore.Shader( "surface", "surface" )
        s.parameters["gl:vertexSource"] = vertexSource
        s.parameters["gl:fragmentSource"] = fragmentSource

        # print s.parameters["gl:vertexSource"]

        return s

        #
        # s = IECoreGL.ShaderStateComponent().shaderSetup().shader()
        # # print s.vertexSource()
        # renderer.shader(
        #     "surface",
        #     "test",
        #     {
        #         "Kd" : args["viewportDisplay"]["Kd"],
        #         "colour" : args["viewportDisplay"]["colour"],
        #         "hairID" : 5.0,
        #         # "useTexture" : IECore.BoolData( True if args["texture"].value else False ),
        #         # "texture" : args["texture"],
        #         "gl:vertexSource" : "", #IECore.StringData( vertexSource ),
        #         "gl:fragmentSource" : IECore.StringData( fragmentSource ),
        #     }
        # )

#register
registerRunTimeTyped( shave )
