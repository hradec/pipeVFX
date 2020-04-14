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
			defaultValue = 0.8,
		)
        tipWidth = IECore.FloatParameter(
			name = "tipWidth",
			description = "size of each hair at tip.",
		    defaultValue = 0.02,
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
        indirect = BoolParameter("visibilityIndirect", "visible for indirect rays, like indirect specular, indirect diffuse, refraction and subsurface.",False)
        transmis = BoolParameter("visibilityTransmission", "visible for shadow rays.",True)
        maxDiff  = FloatParameter("maxDiffuseDepth", "maximun depth a ray will go to get indirect diffuse",0)
        maxSpec  = FloatParameter("maxSpecularDepth", "maximun depth a ray will go to get indirect specular",0)
        traceset = StringParameter("traceset", "traceset group to isolate this object for raytrace.\nThe name used here can be used in shaders to specify if the shader can use or ignore this when doing tracing operations.\nThe default +reflection,refraction,shadow makes this object visible to these type of rays.\nFor example, removing reflection will make it disapear from all reflections!","+reflection,refraction,shadow")
        passID   = StringParameter("IDPrimvarName", "the name of a primvar which will hold a value of 1.0 for all the curves in the procedural, so it can be used by PxrPrimvar to output an ID AOV for the node!", "shaveID")

        gl = CompoundParameter("viewportDisplay","",[
            IntParameter("displayPercentage", "The percentage of hairs to show in the viewport. Use this to be able to see a cache when there's too much curves!",100),
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
        ],userData = { "UI": {"visible" : BoolData(True)}})

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

        if not os.path.exists(path):
            from glob import glob
            files = glob( "%s.*.cob" % os.path.splitext(os.path.splitext(str(args['path']))[0])[0] )
            if files:
                files.sort()
                path=files[0]
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

                p['P']          = geo['P']
                if 'tipColor' in geo.keys():
                    p['tip']   = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, DataConvertOp()( data = geo['tipColor'].data, targetType = Color3fVectorData.staticTypeId() ) )
                if 'rootColor' in geo.keys():
                    p['root']  = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, DataConvertOp()( data = geo['rootColor'].data, targetType = Color3fVectorData.staticTypeId() ) )
                # if 'U' in geo.keys():
                #     p['U']          = geo['U']
                # if 'uv' in geo.keys():
                #     p['uv']          = geo['uv']


                p[ args["IDPrimvarName"].value ] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData( 1.0 ) )


                size = root - tip
                vpc = p.verticesPerCurve()
                w=[]
                uv=[]
                for n in range(p.numCurves()):
                    step = float(size) / (p.numSegments(n) - adjust)
                    w += [ max(root - x*step, 0) for x in range( vpc[n] ) ]
                    # stepUV = 1.0 / (c-1)
                    # uv += [ V2f(x*stepUV) for x in range( c ) ]
                # geo['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, FloatVectorData( w ) )
                # geo['uv'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, V2fVectorData( uv ) )

                # p['uv']         = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, V2fVectorData( uv ) )
                p['width']      = PrimitiveVariable( PrimitiveVariable.Interpolation.Vertex, FloatVectorData( w ) )
                # p['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, FloatData( 0.1 ) )

                print "SHAVE CORTEX PROCEDURAL: time to setup curves width: %.02f secs" % (time.time()-t)
                sys.stdout.flush()
                # p = pp

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
                # g.setAttribute( "ri:visibility:camera", FloatData( args['visibilityCamera'].value ) )
                # g.setAttribute( "ri:visibility:indirect", FloatData( args['visibilityIndirect'].value ) )
                # g.setAttribute( "ri:visibility:transmission", FloatData( args['visibilityTransmission'].value ) )
                g.setAttribute( "ri:trace:maxdiffusedepth", FloatData( args['maxDiffuseDepth'].value ) )
                g.setAttribute( "ri:trace:maxspeculardepth", FloatData( args['maxSpecularDepth'].value ) )
                # g.setAttribute( "ri:shade:transmissionhitmode", 'shader' )
                # g.setAttribute( "ri:grouping:membership", StringData( args['traceset'].value ) )
                g.addChild(p)

                _g.render( renderer )


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

            in vec3 P;
            in vec3 tip;
            in vec3 root;
            in float U;
            in vec3 uv;
            in vec3 velocity;
            in vec3 N;
            in float width;
            in float ID;

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
                if (displayVelocity>0.0)
                    d=velocity;
            	gl_FragColor = vec4( d, 1.0 );
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
