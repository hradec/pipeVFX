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

from __future__ import with_statement

from IECore import *
import random

class shadedFurExample( ParameterisedProcedural ) :

        def __init__( self ) :

                ParameterisedProcedural.__init__( self )

                self.parameters().addParameters(

                        [
                                ## Connect your own mesh to grow hair on here, if you like.
                                ObjectParameter(
                                        name = "mesh",
                                        description = "The mesh to grow hair on, it should have well laid out UVs.",
                                        defaultValue = MeshPrimitive.createPlane( Box2f( V2f( -2.0 ), V2f( 2.0 ) ) ),
                                        types = [TypeId.MeshPrimitive]
                                ),
                                                                                                        
                                ## Add in some controls for the glsl shader parameters.
                                
                                FloatParameter(
                                        name = "diffuse",
                                        description = "Strength of the 'fake' diffuse shading.",
                                        defaultValue = 0.4,
                                        minValue = 0.0,
                                        maxValue = 1.0
                                ),
                                
                                FloatParameter(
                                        name = "whiteSpec",
                                        description = "The strength of the shading conrtribution from the 'R' component of the Marschner model.",
                                        defaultValue = 2.5,
                                        minValue = 0.0,
                                        maxValue = 5.0
                                ),
                                
                                FloatParameter(
                                        name = "backlight",
                                        description = "The strength of the shading conrtribution from the 'TT' component of the Marschner model.",
                                        defaultValue = 0.9,
                                        minValue = 0.0,
                                        maxValue = 5.0
                                ),
                                
                                FloatParameter(
                                        name = "colouredSpec",
                                        description = "The strength of the shading conrtribution from the 'TRT' component of the Marschner model.",
                                        defaultValue = 1.0,
                                        minValue = 0.0,
                                        maxValue = 5.0
                                ),
                                
                                ## We can take advantage of the MarschnerParameter to add in the controls for the base
                                ## Spec model, which is used to generate the lookup tables for GPU shading.
                                
                                MarschnerParameter( name = "marschnerParameters" ),
                                
                                ## Add some controls for hair generation.
                                
                                CompoundParameter( 
                                
                                        name = "hair",
                                        members = [
                                
                                                FloatParameter(
                                                        name = "length",
                                                        description = "The length of the hair, in world units.",
                                                        defaultValue = 4.0
                                                ),
                                                
                                                FloatParameter(
                                                        name = "width",
                                                        description = "The width of the hair, in world units.",
                                                        defaultValue = 0.1
                                                ),

                                                IntParameter(
                                                        name = "count",
                                                        description = "The numbe of hairs to generate.",
                                                        defaultValue = 5000
                                                ),

                                                FloatParameter(
                                                        name = "frizz",
                                                        description = "The amount of frizz in the hair.",
                                                        defaultValue = 0.1,
                                                        minValue = 0.0,
                                                        maxValue = 1.0 
                                                ),

                                                FloatParameter(
                                                        name = "gravity",
                                                        description = "How strong gravity is.",
                                                        defaultValue = 1.0,
                                                        minValue = -1.0,
                                                        maxValue = 1.0
                                                )
                                        ]
                                )
                        ]
                )
                
                ## Change the default colour for the hair in the marschner model.
                self.parameters()["marschnerParameters"]["color"].setTypedValue( Color3f( 0.4, 0.2, 0.05 ) )
                
                ## We are going to cache our lookup tables, and the hair, so were
                ## not needlessly re-calculating things that haven't changed.
                self.__hairChecksum = -1
                self.__shadingChecksum = -1


        def doBound( self, args ) :
                
                ## We don't actually know where the hair will be, but
                ## we do know it can't get any longer than a certain length
                ## so just expand the bounding box by that amount to be safe.
                
                box = args["mesh"].bound()
                box.min -= V3f( args["hair"]["length"].value );
                box.max += V3f( args["hair"]["length"].value );
                return box


        def doRenderState( self, renderer, args ) :
                pass


        def doRender( self, renderer, args ) :

                args["mesh"].render( renderer )
                
                ## See if we need to re-calculate the hair. The host layer should be
                ## keeping track on the update counts of parameters, so we'll use those
                ## as a checksum to see if anything relevant has been altered. If the 
                ## checksum is different to last time, we need to re-calculate.
                
                hairChecksum = 0        
                
                if "updateCount" in self.parameters()["hair"].userData() :
                        hairChecksum += self.parameters()["hair"].userData()["updateCount"].value
                
                if "updateCount" in self.parameters()["mesh"].userData() :
                        hairChecksum += self.parameters()["mesh"].userData()["updateCount"].value
                        
                if hairChecksum != self.__hairChecksum :
                                        
                        self.hair = self.generateHair( args["mesh"], args["hair"] )
                        self.__hairChecksum = hairChecksum
                
                ## For now, set a very basic constant color on the hair, using the color set in 
                ## the shading model.
                self.hair["Cs"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, args["marschnerParameters"]["color"] )
                
                ## Using a scoped attribute block to make sure the any changes we make are contained.
                ## This isn't strictly necessary as the procedural implementation should preserve/restore
                ## state either side of the entry/exit into each individual procedural.
                with AttributeBlock( renderer ) :
                        
                        if renderer.typeName()=="IECoreGL::Renderer" :

                                # Set up how our hair will render
                                self.__setupGLRenderer( renderer )

                                # Set up our shading
                                self.__setupGLShader( renderer, args )
                        else :
                                renderer.setAttribute( "ri:dice:hair", FloatData( 1 ) )
                        
                        # Render the hair we calculated earlier 
                        self.hair.render( renderer )

        
        ## This simply sets up a couple of attributes to control how things will render
        def __setupGLRenderer( self, renderer ):
                        
                renderer.setAttribute( "gl:curvesPrimitive:useGLLines", BoolData( True ) )
                renderer.setAttribute( "gl:curvesPrimitive:ignoreBasis", BoolData( True ) )
                
                ## The draw states prevent the wireframe being drawn on top of the hair 
                ## when selected, which obscures it.
                renderer.setAttribute( "gl:primitive:wireframe", BoolData( False ) )
                renderer.setAttribute( "gl:primitive:solid", BoolData( True ) )


        def __setupGLShader( self, renderer, args ):
                
                ## Do the same checksumming we did with the hair for the Marschner parameters
                ## to allow us to re-use the lookup tables where possible.
                
                shadingChecksum = 0
        
                shadingParam = self.parameters()["marschnerParameters"]
                if "updateCount" in shadingParam.userData() :
                        shadingChecksum = shadingParam.userData()["updateCount"].value
                
                if shadingChecksum != self.__shadingChecksum :
                
                        ## This will returns us an image, with all of the required channels for
                        ## the lookup. We need to split these up into separate RGBA textures 
                        ## so we can send them to the graphics card.
                        lookup = MarschnerLookupTableOp()( model=args["marschnerParameters"] )

                        ## Currently, there is no easy way to take an ImagePrimitive and set it as
                        ## a shader parameter. There is however an implicit conversion in the GL renderer 
                        ## between a CompoundData object with the right hierarchy, and a gl texture. 
                        ## So, we need to take the channel data out of the image primitive, and build a 
                        ## a compound data representation, and feed that into the appropriate shader parameter.

                        dw = Box2iData( lookup.dataWindow )

                        tex1 = CompoundData()
                        tex2 = CompoundData()
                        tex3 = CompoundData()

                        tex1["displayWindow"] = dw
                        tex1["dataWindow"] = dw
                        tex2["displayWindow"] = dw
                        tex2["dataWindow"] = dw
                        tex3["displayWindow"] = dw
                        tex3["dataWindow"] = dw

                        tex1["channels"] = CompoundData()
                        tex2["channels"] = CompoundData()
                        tex3["channels"] = CompoundData()

                        tex1["channels"]["R"] = lookup["MR"].data
                        tex1["channels"]["G"] = lookup["MTT"].data
                        tex1["channels"]["B"] = lookup["MTRT"].data
                        tex1["channels"]["A"] = lookup["cosDiffTheta"].data

                        tex2["channels"]["R"] = lookup["NTT.r"].data
                        tex2["channels"]["G"] = lookup["NTT.g"].data
                        tex2["channels"]["B"] = lookup["NTT.b"].data
                        tex2["channels"]["A"] = lookup["NR"].data

                        tex3["channels"]["R"] = lookup["NTRT.r"].data
                        tex3["channels"]["G"] = lookup["NTRT.g"].data
                        tex3["channels"]["B"] = lookup["NTRT.b"].data

                        ## Store these so we can re-use them later if we want to save some time
                        self.__lookup1 = tex1
                        self.__lookup2 = tex2
                        self.__lookup3 = tex3
                        
                        self.__shadingChecksum = shadingChecksum

                ## We can now feed these image representations to the shader via its parameters
                ## These names need to match those declared in the vert/frag glsl shader.
                shaderArgs = {
                        "lookupM" : self.__lookup1,
                        "lookupN" : self.__lookup2,
                        "lookupNTRT" : self.__lookup3,
                        "scaleR" : args["whiteSpec"],
                        "scaleTT" : args["backlight"],
                        "scaleTRT" : args["colouredSpec"],
                        "scaleDiffuse" : args["diffuse"],
                        "diffuseFalloff" : FloatData( 0.4 ),
                        "diffuseAzimuthFalloff" : FloatData( 0.4 )
                }
                
                ## You may need to adjust this shader path, depending on your cortex installation.
                renderer.shader( "surface", "ieMarschnerHair", shaderArgs )


        ## A super-simple hair system, that simply grows along the normals, 
        ## with a little gravity and frizz. 
        
        def generateHair( self, mesh, args ) :
                                
                ## The evaluator needs a triangulated mesh
                meshTri = TriangulateOp()( input=mesh, throwExceptions=False )
                
                ## This returns us a PointsPrimtive, which we are going to use as follicles
                seeds = UniformRandomPointDistributionOp()( mesh=meshTri, numPoints=args["count"].value )
                
                meshEvaluator = MeshPrimitiveEvaluator( meshTri )
                result = meshEvaluator.createResult()
        
                ## These are going to hold the data for our CurvesPrimtive
                p = V3fVectorData()
                vpc = IntVectorData()
                
                ## We don't want the geometric normal in result.normal(), so we find this in advance.
                if "N" not in meshTri :
                        meshTri = MeshNormalsOp()( input=meshTri )
                
                normalsPrimVar = meshTri["N"]
                
                ## Make sure our frizz will be based on the same sequence of random numbers, though
                ## we aren't necessarily sure the follicle seeds will be in the same order...
                random.seed( 0 )
                
                ## Work out the CVs for a hair for each point, and push them onto the p data array.
                for i in range( seeds.numPoints ):
                        meshEvaluator.closestPoint( seeds["P"].data[i], result ) 
                        numCvs = self.__hairCVs( result.point(), result.vectorPrimVar( normalsPrimVar ), args, p )
                        vpc.append( numCvs )
                        
                curves = CurvesPrimitive( vpc, CubicBasisf.catmullRom(), False, p )
                curves["constantwidth"] = PrimitiveVariable( PrimitiveVariable.Interpolation.Constant, args["width"].value )
                
                ## We need vTangents for the Marschner shading model.
                curves = CurveTangentsOp()( input=curves )
                                
                return curves


        def __hairCVs( self, origin, direction, args, pointsData ):
                
                segments = 10
                segLength = args["length"].value/float(segments+1)
                
                growth = direction.normalized()
                                
                pointsData.append( origin )
                
                lastP = origin
                for i in range(segments+1):
                        
                        # basic Gravity
                        growth += V3f( 0.0, -args["gravity"].value * max( 0.0, float(i+1)/float(segments) ), 0.0 )
                                                        
                        thisP = lastP + growth.normalized() * segLength
                        lastP = thisP
                        
                        # Basic frizz, we set lastP first, so we dont accumulate the drift.
                        # Note: This will potentially cause us to exceed our bounds...
                        thisP += V3f( random.random()-0.5, random.random()-0.5, random.random()-0.5 ) * args["frizz"].value
                        
                        pointsData.append( thisP )
                
                return segments + 2

registerRunTimeTyped( shadedFurExample )
