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



vertexSource = """
varying vec3 P;
varying vec3 N;
		
void main()
{
	vec4 pCam = gl_ModelViewMatrix * gl_Vertex;
	P = pCam.xyz;
	gl_Position = gl_ProjectionMatrix * pCam;
	N = normalize( gl_NormalMatrix * gl_Normal );
	gl_TexCoord[0] = gl_MultiTexCoord0;
}
"""

fragmentSource = """

#include "IECoreGL/Diffuse.h"
#include "IECoreGL/Lights.h"

varying vec3 N;
varying vec3 P;

varying vec2 textureCoordinates;

uniform float Kd;
uniform vec3 colour;

uniform bool useTexture;
uniform sampler2D texture;

void main()
{
	vec3 Cl[gl_MaxLights];
	vec3 L[gl_MaxLights];
	
	lights( P, Cl, L, 4 );
	vec3 d = Kd * colour * ieDiffuse( P, N, Cl, L, 4 );
	
	if( useTexture )
	{
		d *= texture2D( texture, gl_TexCoord[0].xy ).rgb;
	}
	
	gl_FragColor = vec4( d, 1.0 );
}
"""

class glslExample( IECore.ParameterisedProcedural ) :

	def __init__( self ) :

		IECore.ParameterisedProcedural.__init__( self )

		self.parameters().addParameters(

			[
				
				IECore.FloatParameter(
					name = "Kd",
					description = "How much diffuse to have.",
					defaultValue = 1,
				),
								
				IECore.Color3fParameter(
					name = "colour",
					description = "The colour of the objects.",
					defaultValue = IECore.Color3f( 1 ),
				),
				
				IECore.FileNameParameter(
					name = "texture",
					description = "A texture to apply.",
					defaultValue = "",
				),

			],
			
		)
		
	def doBound( self, args ) :

		return IECore.Box3f( IECore.V3f( -1 ), IECore.V3f( 1 ) )

	def doRenderState( self, renderer, args ) :
	
		pass

	def doRender( self, renderer, args ) :

		print args["colour"].typeName()

		if renderer.typeName() == "IECoreGL::Renderer" :
		
			# Shaders are specified to the OpenGL renderer in exactly
			# the same manner as they are to RenderMan or Arnold, using
			# the shader method.
			renderer.shader(
				"surface",
				# In this case the name of our shader is irrelevant, as
				# we're providing the source code in the "gl:vertexSource"
				# and "gl:fragmentSource" parameters below. If we didn't
				# provide those parameters, then the name would specify
				# the name of the shaders to load from the IECOREGL_SHADER_PATHS
				# on disk.
				"test",
				# Parameters passed to the shader call are automatically mapped
				# to uniform parameters of the GLSL shader. Textures are automatically
				# loaded from disk as necessary and provided to samplers in the shader.
				# Although not demonstrated here, you can also pass SplineData as a
				# shader parameter, and it'll automatically be rasterised and converted
				# to a texture too.
				{
					"Kd" : args["Kd"],
					"colour" : args["colour"],
					"useTexture" : IECore.BoolData( True if args["texture"].value else False ),
					"texture" : args["texture"],
					"gl:vertexSource" : IECore.StringData( vertexSource ),
					"gl:fragmentSource" : IECore.StringData( fragmentSource ),			
				}
			)

		# A sphere!
		renderer.sphere( 1, -1, 1, 360, {} )
		
IECore.registerRunTimeTyped( glslExample )