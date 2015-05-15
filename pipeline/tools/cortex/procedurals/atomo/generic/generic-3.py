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

#import IECore
import Asset
from IECore import * 
import os, random, math
from multiprocessing import Pool

#def displaceVelocity(n, data, shutter, args):
#    from IECore import * 
#    data[n] += geo['velocity'].data[n] * shutter * args['motionBlurMult'].value



def applyFunction2Type(root, func, type="MeshPrimitive"):
    if hasattr( root, 'children' ):
        for each in root.children():
            if each.typeName()==type or type.lower() == 'all':
                func(each)
            if each.typeName()=='Group':
                applyFunction2Type(each, func, type)
    else:
        if root.typeName()==type or type.lower() == 'all':
            func(root)


class generic(ParameterisedProcedural) : 


    def __init__(self) : 
        ParameterisedProcedural.__init__( self, "Reads any format supported by Cortex (Cortex COB, Alembic, Houdini particles, realflow, etc)." )
#        path = PathParameter( "path", "Path", "" )
        path = FileSequenceParameter( 
                name = "path", 
                description = "A file sequence of animation caches to be applied. "
                              "Use # characters to specify the frame number.",
                userData = {"UI":{ "invertEnabled" : BoolData(True) }},
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
        rightHand  = BoolParameter("rightHandedOrientation", "set this if the cache has being generated from a right handed software (if you have to scale Z to -1 to make it orient correcly, chances are it need this turn this OFF).",True)
        mblur  = FloatParameter("motionBlurMult", "Multiply the motion vector to attenuate or exagerate final motion blur.",0.15)
        
        
        hidden = CompoundParameter("dataFromHostApp","",[  
            FloatParameter("frame", "",1,userData=CompoundObject({"maya" : {"defaultConnection" : StringData( "time1.outTime" )}}))
        ],userData = { "UI": {"visible" : BoolData(True)}})

        
        mesh = CompoundParameter("setupMesh","Setup render for all meshes in the cache.",[  
            BoolParameter( "subdiv", "Subdiv", True  )
        ])
        
        points = CompoundParameter("setupParticles","Setup render for all particles in the cache.",[  
            FloatParameter("width", "the width of each particle. (if the input data is particles)",1),
            FloatParameter("blobbyThreshold", "The threshold used to calculate the blob isosurface.",1),
            IntParameter("type", "how to render particles.", 0, presets = [
                ('points',0),
                ('blobby',1),
                ('discs',2),
                ('spheres',3),
                ('procedural',4),
            ],presetsOnly = True),
            ClassParameter(
                "procedural",
                "procedural to instance on each particle",
                "IECORE_PROCEDURAL_PATHS",
                userData = { "UI": {
                    "collapsed" : BoolData(False),
#                    "classNameFilter" : StringData(filter),
                }},
            ),
            IntParameter("proceduralRotate", "how to rotate the particles.", 1, presets = [
                ('none',0),
                ('random based on ID',1),
                ('rotatePP',2),
            ],presetsOnly = True),
        ])

        self.parameters().addParameters([
            self.asset,
            path,
            startFrame,
            startCacheFrame,
            rightHand,
            mblur,
            mesh, 
            points,
            hidden
        ])
        
    def expandvars(self, path):
        if '$F4' in path:
            path = path.replace('$F4', '####' )
        return os.path.expandvars(path)
        
        
    def __read(self, args):
      file=None
      file = str(args['path'].value).strip()
      data = self.asset.getDataDict()
      if data:
        name = data['publishFile']
        file = name
        if 'assetClass' in data.keys():
            fsequence=True
            sequence = "%d-%d" % ( data['assetClass']['FrameRange']['range'].value.x, data['assetClass']['FrameRange']['range'].value.y)
            file = name.split('%')[0] + '#'*int(name.split('%')[-1].split('d')[0]) + os.path.splitext(name)[-1] + " %s" % sequence

      if file:
        fsequence='###' in file
        frame = int(args['dataFromHostApp']['frame'].value)
        start = args['startFrame'].value
        offset = args['cacheFrameOffset'].value
        ret = None
        cache = None
        
        if frame >= start:
            frame = frame - start
            if fsequence:
                fs = FileSequence(self.expandvars(file))
                file = fs.fileNameForFrame(frame+offset) 
                
            if os.path.exists( file ):
                # create a cortex reader class, used to read data
                reader =  Reader.create( file )
                
                # set convertion to V3f in the reader class 
                # same caches have V3d instead of V3f, so we need this to
                # convert the data to V3f, used by our renderer classes
                try: reader.parameters()['realType'].setValue(1)
                except: pass
                
                # effectively read data
                cache = reader.read()
                
                
                # fixCache apply some fixes to the read cache, so this procedural can 
                # work properly!
                def fixCache(ret):

                    # remove prefix of primvars, if any!
                    if hasattr( ret, 'keys' ):
                        for each in ret.keys():
                            ret[each.split('_')[-1]] =  ret[each]

                        if 'vel' in ret.keys():
                            ret['velocity'] = ret['vel']  
                        if 'v' in ret.keys():
                            ret['velocity'] = ret['v']  


                    if ret.typeName()=="MeshPrimitive":
                        # convert houdini 'vel' primvar to velocity
    #                    for each in ret.keys():
    #                        print each

                        # render as subdiv or not?
                        if args['setupMesh']['subdiv'].value:
                            ret.interpolation = "catmullClark"
                            
                        
                    # if cache is a particle/point cache, do some stuff to it!
                    if ret.typeName()=="PointsPrimitive":
                        
                        # if cache has radiusPP, make it width
                        if 'radiusPP' in ret.keys():
                            for n in range(len(ret['radiusPP'].data)):
                                ret['radiusPP'].data[n] = ret['radiusPP'].data[n] * args['setupParticles']['width'].value
                            ret['width'] = ret['radiusPP']
                        else:
                            #set constant width
                            ret['constantwidth'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(args['setupParticles']['width'].value) )
                            ret['__threshold'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, FloatData(args['setupParticles']['blobbyThreshold'].value) )

                        # set render type
                        if args['setupParticles']['type'].value == 1:
                            ret["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "blobby" ) )
                        elif args['setupParticles']['type'].value == 2:
                            ret["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "disc" ) )
                        elif args['setupParticles']['type'].value == 3:
                            ret["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "sphere" ) )
                        elif args['setupParticles']['type'].value == 0:
                            ret["type"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "point" ) )

                        # attach velocity as a Cs primitive variable 
                        try:
                            dc = DataConvertOp()
                            dc.parameters()['data']=ret['velocity'].data
                            dc.parameters()['targetType']=TypeId.Color3fVectorData
                            ret['Cs'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, dc() )            
                        except:
                            pass

                        # make sure rgbPP is a varying color!
                        if 'rgbPP' in ret.keys():
                            dc = DataConvertOp()
                            dc.parameters()['data']=ret['rgbPP'].data
                            dc.parameters()['targetType']=TypeId.Color3fVectorData
                            ret['rgbPP'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Varying, dc() )            

                # traverse the cache geometry and apply the fixCache function to every node
                # inside the cache!
                applyFunction2Type(cache, fixCache, 'all')
                
        return cache
    
        

    def __motionBlur(self, args, shutter=0.1):
        # read same geo again, so we can
        # grab it's velocity prim var and 
        # deform to fake a second motion sample
        # with the same number of frames!
        self.flag=False

        def createMotionBlutFromVelocity(node):
            # use velocity primvar to deform geo2 to create 
            # fake deformation motion blur
            if hasattr( node, 'keys'):
                if 'velocity' in node.keys():
                    self.flag = True
                    for n in range(len(node['P'].data)):
                        node['P'].data[n] += node['velocity'].data[n] * shutter * args['motionBlurMult'].value
#                    p = Pool(8)
#                    p.map( displaceVelocity, 
#                        map( 
#                            lambda x: (x, geo2['P'].data, shutter, args), 
#                            range(len(geo2['P'].data))
#                        ) 
#                    )
                    
        geo2 = self.__read(args)
        if geo2:
            applyFunction2Type(geo2, createMotionBlutFromVelocity, 'all')
            
            
        if not self.flag:
            geo2 = None
        return geo2
                
    def doBound(self, args) : 
#        self.asset.parameterChanged(self.asset['info']['name'])
        bbox = Box3f()
        obj = self.__read(args)
        if obj:
            bbox.extendBy( obj.bound() )
            b=bbox
            bbox.extendBy( Box3f(
                b.min*1.2,
                b.max*1.2,
            ) )
            bbox.extendBy( Box3f(
                b.min*0.8,
                b.max*0.8,
            ) )
#        bbox.extendBy( self.__motionBlur(args).bound() )
        return bbox

    def doRenderState(self, renderer, args) : 
        pass

    def doRender(self, renderer, args) : 


        vertexSource = """
            #include "IECoreGL/PointsPrimitive.h"
            IECOREGL_POINTSPRIMITIVE_DECLAREVERTEXPARAMETERS
            in vec3 instanceP;
            in vec3 velocity;
            in float rfPressure;
            varying out vec3 ParticleColor;
            void main()
            {
                mat4 instanceMatrix = IECOREGL_POINTSPRIMITIVE_INSTANCEMATRIX;
                vec4 pCam = instanceMatrix * vec4( instanceP, 1 );
                //gl_Position = gl_ProjectionMatrix * pCam;
                gl_Position = ftransform();
                ParticleColor = vec3(length(velocity), 0, rfPressure);
            }
        """
        fragmentSource = """
            in vec3 ParticleColor;
            void main()
            {
                gl_FragColor = vec4( ParticleColor, 1.0 )+vec4(0,1,0,0);
            }
        """

        geo1 = self.__read(args)
        if geo1:
            
            # get the shutter open/close values from the renderer
            shutter = renderer.getOption('shutter').value # this is a V2f
            shutterArea = shutter[1] - shutter[0]
            
            # if motion blur is not enabled then both shutter open & close will
            # be zero.
            do_moblur = shutterArea>0.0
            
            with AttributeBlock( renderer ) :
                #renderer.shader( "surface", "test", { "gl:fragmentSource" : fragmentSource } )
#                renderer.shader( "surface", "test", { 
#                    "gl:vertexSource" : vertexSource, 
#                    "gl:fragmentSource" : fragmentSource, 
#                } )
                
#                renderer.setAttribute( "gl:pointsPrimitive:glPointWidth", IECore.FloatData( FloatData(20) ) )

                if not args['rightHandedOrientation'].value:
                    renderer.setAttribute( "rightHandedOrientation", BoolData( True ) )
                    renderer.concatTransform( M44f.createScaled( V3f( 1, 1, -1 ) ) )
     
                if renderer.typeName() == "IECoreGL::Renderer":
                    if geo1.typeName()=="PointsPrimitive":
                        geo1['type'] = PrimitiveVariable( PrimitiveVariable.Interpolation.Uniform, StringData( "gl:point" ) )
                        do_moblur = False
                else:
                    renderer.setAttribute( "rightHandedOrientation", BoolData( args['rightHandedOrientation'].value ) )

                # render as subdiv or not?
                if args['setupMesh']['subdiv'].value:
                    geo1.interpolation = "catmullClark"

                # deal with mblur
                geoNext = None
                if do_moblur:
                    geoNext = self.__motionBlur(args, shutterArea)
                    # render as subdiv or not?
                    if args['setupMesh']['subdiv'].value:
                        if geoNext:
                            geoNext.interpolation = "catmullClark"


                # if nested procedural
                if args['setupParticles']['type'].value == 4:
                    # create an instance of our child procedural
                    procedural = self.parameters()['setupParticles']['procedural'].getClass()
                    if not procedural:
                        procedural = ClassLoader.defaultProceduralLoader().load( "examples/nestedProcedurals/nestedChild", 1 )()
                    
                    # loop through our points
                    for n in range(len(geo1['P'].data)):
                            p = geo1['P'].data[n]
                            
                            # concatenate a transformation matrix
                            renderer.transformBegin()
                            
                            if geoNext:
                                p2 = geoNext['P'].data[n]
                                m = MatrixMotionTransform()
                                m[0] = M44f().createTranslated( p )
                                m[1] = M44f().createTranslated( p2 )
                                m.render( renderer )
                            else:
                                renderer.concatTransform( M44f().createTranslated( p ) )
                            
                            renderer.concatTransform( M44f().createScaled(  V3f(geo1['width'].data[n]) ) )
                            if args['setupParticles']['proceduralRotate'].value == 1:
                                random.seed(geo1['id'].data[n])
                                renderer.concatTransform( M44f().createRotated(  
                                    V3f(
                                        random.random()*math.pi, 
                                        random.random()*math.pi, 
                                        random.random()*math.pi) 
                                    ) 
                                )
                                
                            

                            # do we want to draw our child procedural immediately or defer
                            # until later?
                            immediate_draw = False
                            if renderer.typeName() == "IECoreGL::Renderer":
                                immediate_draw = True

                            # render our child procedural
                            procedural.render( renderer, withGeometry=True, immediateGeometry=immediate_draw )

                            # pop the transform state
                            renderer.transformEnd()
                            
                            
                else:
                    if geoNext:
                        # inject the motion samples
                        renderer.motionBegin( [ -shutterArea, shutterArea  ] )
                        geo1.render( renderer )
                        geoNext.render( renderer )
                        renderer.motionEnd()
                    else:
                        geo1.render( renderer )

registerRunTimeTyped( generic )
