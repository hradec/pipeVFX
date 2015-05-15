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

from IECore import * 
import os, sys



class mergeParticles(ParameterisedProcedural) : 

    def __init__(self) : 
        ParameterisedProcedural.__init__( self, "Reads particle/point caches supported by Cortex (Cortex COB, PDC, PTC, etc)." )
        path = CompoundVectorParameter("particlePaths","",[
            FileSequenceVectorParameter( 
                    name = "path", 
                    description = "A file sequence of particle caches to be applied. Use # characters to specify the frame number.", 
                    defaultValue=StringVectorData(["cache.####.cob 0-100"]),  
                    allowEmptyList=True,
                    check = FileSequenceVectorParameter.CheckType.MustExist,
            ),
            IntVectorParameter(
                    name="startFrame",
                    description = "The frame were this cache will start to show up.",
                    defaultValue = IntVectorData([0]),
            ),
        ])
        
        preview = CompoundParameter("glPreview","",[   
                CompoundParameter("glPoints","",[   
                    BoolParameter("glEnabled", "Enable of disable this preview method",True),
                    FloatParameter("glPointSize", "The size to display each particle in opengl viewport",5),
                    StringParameter("glPrimVarColor", "select the primitive variable to display as colors.",
                        defaultValue = "velocity",
                        presets = [
#                            ('_has_previous_sim_position','_has_previous_sim_position'),
#                            ('_previous_sim_position','_previous_sim_position'),
#                            ('accel','accel'),
#                            ('born','born'),
#                            ('constantwidth','constantwidth'),
                            ('density','density'),
#                            ('dopobject','dopobject'),
#                            ('dopobjectIndices','dopobjectIndices'),
#                            ('event','event'),
#                            ('force','force'),
#                            ('generator','generator'),
#                            ('generatorIndices','generatorIndices'),
#                            ('id','id'),
#                            ('life','life'),
#                            ('mass','mass'),
#                            ('nextid','nextid'),
#                            ('pstate', 'pstate'),
#                            ('source','source'),
#                            ('underresolved', 'underresolved'),
#                            ('v', 'v'),
#                            ('varmap','varmap'),
                            ('velocity', 'velocity'),
#                            ('width','width'),
                        ],
                        presetsOnly = False,
                    ),                
                ]),
                CompoundParameter("mesh","",[   
                    BoolParameter("glEnabled", "Enable of disable this preview method",False),
                    FloatParameter("glResolutionMultiplier", "a multiplier for the mesh grid resolution, so it generates faster for gl preview",0.25),
                ],userData = { "UI": {"visible" : BoolData(False)}} ),
            ],userData = { "UI": {"collapsed" : BoolData(False)}})
            

        render = CompoundParameter("render","",[   
                FloatParameter("motionBlurMult", "Multiply the motion vector to attenuate or exagerate final motion blur.",1),
                CompoundParameter("particles","",[   
                    BoolParameter("enabled", "Enable of disable mesh generation at render time.",False),
                    IntParameter(
                        name="renderAs",
                        description = "how to render particles",
                        defaultValue = 1,
                        presets = [
                            ('points',0),
                            ('blobby',1),
                            ('discs',2),
                            ('spheres',3),
                        ],
                        presetsOnly = True,
                    ),                
                    FloatParameter("densityPDC", "a density multiplier for PDC caches",1.0),
                    FloatParameter("densityCOB", "a density multiplier for COB caches",1.0),
                    FloatParameter("widthLowDensity", "the width of each particle. If particle type is blobby, this is the blob field radius.",1),
                    FloatParameter("widthHighDensity", "the width of each particle. If particle type is blobby, this is the blob field radius.",0.5),
                    SplineffParameter(
                        name = "widthDensitySpline",
                        description = "A curve spline to define width when density is High (Right) and Low (Left).",
                        defaultValue = SplineffData(
                                            Splineff(
                                                CubicBasisf.catmullRom(),
                                                (
                                                    ( 0, 1 ),
                                                    ( 0, 1 ),
                                                    ( 1, 0 ),
                                                    ( 1, 0 ),
                                                ),
                                            ),
                                        ),
                    ),
                    FloatParameter("threshold", "the strength of each particle when generating the mesh",1.0),
                ]),
                CompoundParameter("mesh","",[   
                    BoolParameter("enabled", "Enable of disable mesh generation at render time.",False),
                    FloatParameter("radius", "the radius of each particle when generating the mesh",0.15),
                    FloatParameter("strength", "the strength of each particle when generating the mesh",1),
                    FloatParameter("threshold", "the strength of each particle when generating the mesh",2.4),
                    V3iParameter("resolution", "The grid resolution to tesselate the mesh",V3i(200,200,200)),
                ],userData = { "UI": {"visible" : BoolData(False)}} ),
            ],userData = { "UI": {"collapsed" : BoolData(False)}})
        
        
        frame = CompoundParameter("frame","",[  
                    Box3fParameter( "meshBB","", Box3f() ),
                    FloatParameter("current", "The frame number of the cache to render.",1,
                           userData=CompoundObject({"maya" : {"defaultConnection" : StringData( "time1.outTime" )}}))
                ],userData = { "UI": {"visible" : BoolData(False)}})


                
        self.parameters().addParameters([
            path,
            render,
            preview,
            frame,
        ])
        
    def __read(self, args, gl=False):
        retz = None
        
        for each in range(0,len(args['particlePaths']['path'])):
            if args['particlePaths']['path'][each]:
                fs = FileSequence(args['particlePaths']['path'][each])
                f = int(args['frame']['current'].value)  
                frames = [f, f-1]
                if gl or os.path.splitext( fs.fileNameForFrame(f) )[1].lower() == '.pdc':
                    frames = [f]
                for frame in frames:
                    try: startFrame = args['particlePaths']['startFrame'][each]
                    except: startFrame = 0
                    extension = ""
                    if frame >= startFrame:
                        filename = fs.fileNameForFrame(frame-startFrame)
                        extension = os.path.splitext(filename)
                        if os.path.exists(filename):
                            sys.stdout.write( "\tReading cache %s\n" % filename )
                            reader =  Reader.create( filename  )
                            
                            # set convertion to V3f, needed by our preocedural (0=V3d, 1=V3f)
                            try: reader.parameters()['realType'].setValue(1)
                            except: pass
                            
                            ret = reader.read()
                            
                            if ret.typeName()!="PointsPrimitive":
                                raise Exception("Cache is not a particle/point cache format.")

            #                ret['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(0.1) )
    #                        ret['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(args['render']['particles']['particleWidth'].value) )
    #                        ret['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(args['render']['particles']['particleWidth'].value) )
                            ret['__threshold'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(args['render']['particles']['threshold'].value) )
                             #"float __energyscale"
                            
                            density = 1.0
                            if extension[1].lower()=='.pdc':
                                density = args['render']['particles']['densityPDC'].value
                            if extension[1].lower()=='.cob':
                                density = args['render']['particles']['densityCOB'].value

                            # calculate density
                            if not gl or args['glPreview']['glPoints']['glPrimVarColor'].value == "density":
                                d=PointDensitiesOp()(points=ret['P'].data, numNeighbours=200, multiplier=0.001*density )        
                                ret['density'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, d )    

                            # attach velocity as a Cs primitive variable
                            velocity = self.velocityVector(ret)
                            if velocity:
                                dc = DataConvertOp()
                                dc.parameters()['data']=ret[velocity].data
                                dc.parameters()['targetType']=TypeId.V3fVectorData
                                ret['velocity'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, dc() )            
                                
                            if not retz:
                                retz = [ret]
                            else:
                                for key in retz[0].keys() :
                                    if str( retz[0][key].interpolation ) in ( "Vertex", "Varying" ) : 
                                        if key in ret.keys():
                                            retz[0][key].data.extend( ret[key].data )
                                retz[0].numPoints += ret.numPoints
                                
        
        return retz

    def velocityVector(self,  obj ):
        velocity = None
        if 'v' in obj.keys():
            velocity = 'v'
        if 'velocity' in obj.keys():
            velocity = 'velocity'
        return velocity 

    def __motionBlur(self, args, geo1, shutter=0.1, velocityPrimVar='velocity'):
        # read same geo again, so we can
        # grab it's velocity prim var and 
        # deform to fake a second motion sample
        # with the same number of frames!
        geo2 = geo1.copy()
        for n in range(len(geo2['P'].data)):
            geo2['P'].data[n] += geo2[velocityPrimVar].data[n] * shutter * args['render']['motionBlurMult'].value
        return geo2
                
    def doBound(self, args) : 
        bbox = Box3f()
        for geo in self.__read(args, gl=True):
            bbox.extendBy( geo.bound() )
#           bbox.extendBy( self.__motionBlur(args).bound() )
        return bbox

    def doRenderState(self, renderer, args) : 
        pass
    
    
    def applyPrimVar( self, pointPrimitive, mesh, primVarName ):
        tree=V3fTree(pointPrimitive['P'].data)
        
        velName = primVarName 
        vel = []
        for each in mesh['P'].data:
            id = tree.nearestNeighbour(each)
            vel.append( pointPrimitive[velName].data[id] )
        return vel 
            

    def doRender(self, renderer, args) : 
#        if args['frame']['meshBB'].value == Box3f():
#            # push the transform state
#            renderer.transformBegin()
            
#            box = self.doBound(args)
#            for A in box.split():
#             for B in A.split():
#              for C in B.split():
#               for D in C.split():
#                for each in D.split():

#                    # concatenate a transformation matrix
#                    #renderer.concatTransform( M44f().createTranslated( p ) )

#                    # create an instance of our child procedural
#                    #procedural = ClassLoader.defaultProceduralLoader().load( "simpleParticleProcedural", 1 )()
#                    procedural = simpleParticleProcedural()
#                    s = ParameterParser().serialise( self.parameters() )
#                    ParameterParser().parse( s, procedural.parameters() )

#                    procedural.parameters()['frame']['meshBB'] = each

#                    # do we want to draw our child procedural immediately or defer
#                    # until later?
#                    immediate_draw = False
#                    if renderer.typeId()==Renderer.staticTypeId():
#                        immediate_draw = True

#                    # render our child procedural
#                    procedural.render( renderer, withGeometry=True, immediateGeometry=immediate_draw )

#            # pop the transform state
#            renderer.transformEnd()
#            self.doRenderChild(renderer, args, particles=True, mesh=False) 
#        else:
            sys.stdout.write( '='*80 + "\n" )
            sys.stdout.write( "%s:\n" % self.__class__.__name__ )
            self.doRenderChild(renderer, args, particles=True, mesh=True) 
            sys.stdout.write( '='*80 + "\n" )
        
    def doRenderChild(self, renderer, args, particles=True, mesh=True) : 

        gl = renderer.typeName() == "IECoreGL::Renderer"
        if gl:
            if not args['glPreview']['glPoints']['glEnabled'].value and not args['glPreview']['mesh']['glEnabled'].value:
                return 

        vertexSource = """
            in vec3 P;
            in vec3 velocity;
            in float rfPressure;
            in vec3 Cs;
            in float density;
            varying out vec3 ParticleColor;
            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * vec4( P, 1.0 );
                vec3 pCam = (gl_ModelViewMatrix * vec4( P, 1.0 )).xyz;
                ParticleColor = Cs;
            }
        """
        fragmentSource = """
            varying vec3 Cs ;
            void main()
            {
                gl_FragColor = vec4(gl_Color.rgb,1.0);
            }
        """
        if renderer.typeName() != "IECoreGL::Renderer":
            renderer.setAttribute( "rightHandedOrientation", BoolData( True ) )

        # get the shutter open/close values from the renderer
        shutter = renderer.getOption('shutter').value # this is a V2f
        
        
        # if motion blur is not enabled then both shutter open & close will
        # be zero.
        do_moblur = ( shutter.length() > 0 )
        
        for geo1 in self.__read(args, gl=gl):

                m = None
                if args['render']['mesh']['enabled'].value and mesh:
                    bbExtend = 1.0
                    if renderer.typeName() == "IECoreGL::Renderer":
                        bbExtend = args['glPreview']['mesh']['glResolutionMultiplier'].value
                    if args['glPreview']['mesh']['glEnabled'].value or renderer.typeName() != "IECoreGL::Renderer":
                        m = PointMeshOp()(
                            points = geo1['P'].data,
                            radius = DoubleVectorData( map( lambda x: args['render']['mesh']['radius'].value, range(geo1.numPoints) ) ),
                            strength = DoubleVectorData( map( lambda x: args['render']['mesh']['strength'].value, range(geo1.numPoints) ) ),
                            threshold = args['render']['mesh']['threshold'].value,
#                            bound=Box3f(geo1.bound().min*1.1, geo1.bound().max*1.1),
                            bound=args['frame']['meshBB'].value,
                            resolution = V3i(V3f(args['render']['mesh']['resolution'].value) * bbExtend),
                        )
                        m.interpolation = "catmullClark"
                        m['velocity'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, V3fVectorData(self.applyPrimVar( geo1, m, "velocity" )))

                if gl:
#                    renderer.shader( "surface", "test", { "gl:fragmentSource" : fragmentSource } )
#                    renderer.shader( "surface", "test", { 
#                        "gl:vertexSource" : vertexSource, 
#                        "gl:fragmentSource" : fragmentSource, 
#                    } )
                    
                    if args['glPreview']['glPoints']['glEnabled'].value:
                        if particles:
                            renderer.setAttribute( "gl:pointsPrimitive:glPointWidth", FloatData(args['glPreview']['glPoints']['glPointSize'].value) )
                            geo1['type'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "gl:point" ) )
                            glcolor =  str(args['glPreview']['glPoints']['glPrimVarColor'].value)
                            if ',' in glcolor:
                                if 'velocity' in glcolor:
                                    Cs = geo1['velocity'].data
                                    dc=[]
                                    color = map( lambda x: float(x), glcolor.replace('velocity','').strip().split(',') )
                                    for n in range(len(Cs)):
                                        dc.append(Color3f(color[0],color[1],color[2]) * Cs[n].length()/2.0)
                                    geo1['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, Color3fVectorData(dc) )            
                                else:
                                    dc=[]
                                    Cs = glcolor.split(',')
                                    for n in range(len(geo1['P'].data)):
                                        dc.append(Color3f( float(Cs[0]),float(Cs[1]),float(Cs[2])))
                                    geo1['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, Color3fVectorData(dc) )            
                                
                            else:
                                Cs = geo1[str(args['glPreview']['glPoints']['glPrimVarColor'].value)].data
                                if type(Cs) == FloatVectorData:
                                    dc=[]
                                    for n in range(len(Cs)):
                                        density = Cs[n]*Cs[n]*Cs[n]
                                        dc.append(Color3f(density,density,density))
                                    geo1['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, Color3fVectorData(dc) )            
                                else:
                                    dc = DataConvertOp()
                                    dc.parameters()['data']=Cs
                                    dc.parameters()['targetType']=TypeId.Color3fVectorData
                                    geo1['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, dc() )            
                            geo1.render( renderer )
                    
#                    if mesh:
#                        g = IECore.Group()
#                        g.addChild( MeshPrimitive.createBox( args['frame']['meshBB'].value ) )
#                        g.addState(
#                            IECore.AttributeState(
#                                {
#                                    "gl:primitive:solid" : IECore.BoolData( False ),
#                                    "gl:primitive:wireframe" : IECore.BoolData( True ),
#                                    "gl:primitive:wireframeColor" : IECore.Color4f( 1, 0, 0, 1 ),
#                                    "gl:primitive:wireframeWidth" : 6.0,
#                                }
#                            )
#                        )
                        #g.render( renderer )
#                        MeshPrimitive.createBox( args['frame']['meshBB'].value ).render( renderer )
                                
                    if m:
                        m.render( renderer )
                        
                else:
                        
                        # SSS setup
                        mayaBakePass = renderer.getOption("user:maya_bakepass")
                        if mayaBakePass:
                            renderer.setAttribute( "ri:cull",{
                                "hidden"        : 0,
                                "backfacing"    : 0,
                            },)
                            renderer.setAttribute( "ri:dice",{
                                "rasterorient"  : 0,
                            },)
                        
                        # deal with mblur
                        if do_moblur:
                            motionShutter = (shutter[1]-shutter[0])/2.0
                            if args['render']['particles']['renderAs'].value == 1 and args['render']['particles']['enabled'].value:
                                if particles:
                                    
                                    width=[]
                                    for n in range(len(geo1['P'].data)):
                                        width.append( float( 
#                                            args['render']['particles']['widthDensitySpline'].value.solve(geo1['density'].data[n])[0] 
                                            float(args['render']['particles']['widthLowDensity'].value) * (1.0-geo1['density'].data[n]) +
                                            float(args['render']['particles']['widthHighDensity'].value) * geo1['density'].data[n]
                                        ) )
                                    geo1['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, FloatVectorData( width ) )
                                    
                                    for each in geo1.keys():
                                        if each not in ['width', '__threshold', 'velocity', 'P', 'density']:
                                            del geo1[each]
                                            
                                            
                                    geo2 = self.__motionBlur(args, geo1, shutter[1] - shutter[0])
                                        
                                    # inject the motion samples
                                    geo1["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "blobby" ) )
                                    geo2["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "blobby" ) )
                                    
                                    
                                    renderer.motionBegin( [ -motionShutter , motionShutter  ] )
                                    geo1.render( renderer )
                                    geo2.render( renderer )
                                    renderer.motionEnd()
                                    
                                    if not mayaBakePass :
                                        del geo1["width"]
                                        del geo2["width"]
                                        geo1["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "sphere" ) )
                                        geo2["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "sphere" ) )
                                        geo1['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(0.04) )
                                        geo2['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(0.0) )
                                        geo1['particleIsPoint'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(1.0) )
                                        geo2['particleIsPoint'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(1.0) )

                                        width=[]
                                        width2=[]
                                        for n in range(len(geo1['P'].data)):
                                            width.append( 0.2*float( 
    #                                            args['render']['particles']['widthDensitySpline'].value.solve(geo1['density'].data[n])[0] 
                                                float(args['render']['particles']['widthLowDensity'].value) * (1.0-geo1['density'].data[n]) +
                                                float(args['render']['particles']['widthHighDensity'].value) * geo1['density'].data[n]
                                            ) )
                                            width2.append( 0.05*float( 
    #                                            args['render']['particles']['widthDensitySpline'].value.solve(geo1['density'].data[n])[0] 
                                                float(args['render']['particles']['widthLowDensity'].value) * (1.0-geo1['density'].data[n]) +
                                                float(args['render']['particles']['widthHighDensity'].value) * geo1['density'].data[n]
                                            ) )
                                        geo1['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, FloatVectorData( width ) )
                                        geo1['width'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, FloatVectorData( width2 ) )

                                        renderer.motionBegin( [  -motionShutter , motionShutter  ] )
                                        geo1.render( renderer )
                                        geo2.render( renderer )
                                        renderer.motionEnd()
                                    
                            
                            if m:
                                m2 = self.__motionBlur(args, m, shutter[1] - shutter[0])
                                renderer.motionBegin( [  -motionShutter , motionShutter ] )
                                m.render( renderer )
                                m2.render( renderer )
                                renderer.motionEnd()
                        else:
                            if args['render']['particles']['renderAs'].value == 1 and args['render']['particles']['enabled'].value:
                                if particles:
                                    geo1["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "blobby" ) )
                                    geo1.render( renderer )
                            if m:
                                m.render( renderer )


registerRunTimeTyped( mergeParticles )
