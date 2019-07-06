//Maya ASCII 2014 scene
//Name: Metal_NonFerrous_Copper.ma
//Last modified: Sun, Feb 01, 2015 03:36:21 AM
//Codeset: 1252
requires maya "2014";
requires -nodeType "mentalrayFramebuffer" -nodeType "mentalrayOutputPass" -nodeType "mentalrayRenderPass"
		 -nodeType "mentalrayUserBuffer" -nodeType "mentalraySubdivApprox" -nodeType "mentalrayCurveApprox"
		 -nodeType "mentalraySurfaceApprox" -nodeType "mentalrayDisplaceApprox" -nodeType "mentalrayOptions"
		 -nodeType "mentalrayGlobals" -nodeType "mentalrayItemsList" -nodeType "mentalrayShader"
		 -nodeType "mentalrayUserData" -nodeType "mentalrayText" -nodeType "mentalrayTessellation"
		 -nodeType "mentalrayPhenomenon" -nodeType "mentalrayLightProfile" -nodeType "mentalrayVertexColors"
		 -nodeType "mentalrayIblShape" -nodeType "mapVizShape" -nodeType "mentalrayCCMeshProxy"
		 -nodeType "cylindricalLightLocator" -nodeType "discLightLocator" -nodeType "rectangularLightLocator"
		 -nodeType "sphericalLightLocator" -nodeType "abcimport" -nodeType "mia_physicalsun"
		 -nodeType "mia_physicalsky" -nodeType "mia_material" -nodeType "mia_material_x" -nodeType "mia_roundcorners"
		 -nodeType "mia_exposure_simple" -nodeType "mia_portal_light" -nodeType "mia_light_surface"
		 -nodeType "mia_exposure_photographic" -nodeType "mia_exposure_photographic_rev" -nodeType "mia_lens_bokeh"
		 -nodeType "mia_envblur" -nodeType "mia_ciesky" -nodeType "mia_photometric_light"
		 -nodeType "mib_texture_vector" -nodeType "mib_texture_remap" -nodeType "mib_texture_rotate"
		 -nodeType "mib_bump_basis" -nodeType "mib_bump_map" -nodeType "mib_passthrough_bump_map"
		 -nodeType "mib_bump_map2" -nodeType "mib_lookup_spherical" -nodeType "mib_lookup_cube1"
		 -nodeType "mib_lookup_cube6" -nodeType "mib_lookup_background" -nodeType "mib_lookup_cylindrical"
		 -nodeType "mib_texture_lookup" -nodeType "mib_texture_lookup2" -nodeType "mib_texture_filter_lookup"
		 -nodeType "mib_texture_checkerboard" -nodeType "mib_texture_polkadot" -nodeType "mib_texture_polkasphere"
		 -nodeType "mib_texture_turbulence" -nodeType "mib_texture_wave" -nodeType "mib_reflect"
		 -nodeType "mib_refract" -nodeType "mib_transparency" -nodeType "mib_continue" -nodeType "mib_opacity"
		 -nodeType "mib_twosided" -nodeType "mib_refraction_index" -nodeType "mib_dielectric"
		 -nodeType "mib_ray_marcher" -nodeType "mib_illum_lambert" -nodeType "mib_illum_phong"
		 -nodeType "mib_illum_ward" -nodeType "mib_illum_ward_deriv" -nodeType "mib_illum_blinn"
		 -nodeType "mib_illum_cooktorr" -nodeType "mib_illum_hair" -nodeType "mib_volume"
		 -nodeType "mib_color_alpha" -nodeType "mib_color_average" -nodeType "mib_color_intensity"
		 -nodeType "mib_color_interpolate" -nodeType "mib_color_mix" -nodeType "mib_color_spread"
		 -nodeType "mib_geo_cube" -nodeType "mib_geo_torus" -nodeType "mib_geo_sphere" -nodeType "mib_geo_cone"
		 -nodeType "mib_geo_cylinder" -nodeType "mib_geo_square" -nodeType "mib_geo_instance"
		 -nodeType "mib_geo_instance_mlist" -nodeType "mib_geo_add_uv_texsurf" -nodeType "mib_photon_basic"
		 -nodeType "mib_light_infinite" -nodeType "mib_light_point" -nodeType "mib_light_spot"
		 -nodeType "mib_light_photometric" -nodeType "mib_cie_d" -nodeType "mib_blackbody"
		 -nodeType "mib_shadow_transparency" -nodeType "mib_lens_stencil" -nodeType "mib_lens_clamp"
		 -nodeType "mib_lightmap_write" -nodeType "mib_lightmap_sample" -nodeType "mib_amb_occlusion"
		 -nodeType "mib_fast_occlusion" -nodeType "mib_map_get_scalar" -nodeType "mib_map_get_integer"
		 -nodeType "mib_map_get_vector" -nodeType "mib_map_get_color" -nodeType "mib_map_get_transform"
		 -nodeType "mib_map_get_scalar_array" -nodeType "mib_map_get_integer_array" -nodeType "mib_fg_occlusion"
		 -nodeType "mib_bent_normal_env" -nodeType "mib_glossy_reflection" -nodeType "mib_glossy_refraction"
		 -nodeType "builtin_bsdf_architectural" -nodeType "builtin_bsdf_architectural_comp"
		 -nodeType "builtin_bsdf_carpaint" -nodeType "builtin_bsdf_ashikhmin" -nodeType "builtin_bsdf_lambert"
		 -nodeType "builtin_bsdf_mirror" -nodeType "builtin_bsdf_phong" -nodeType "contour_store_function"
		 -nodeType "contour_store_function_simple" -nodeType "contour_contrast_function_levels"
		 -nodeType "contour_contrast_function_simple" -nodeType "contour_shader_simple" -nodeType "contour_shader_silhouette"
		 -nodeType "contour_shader_maxcolor" -nodeType "contour_shader_curvature" -nodeType "contour_shader_factorcolor"
		 -nodeType "contour_shader_depthfade" -nodeType "contour_shader_framefade" -nodeType "contour_shader_layerthinner"
		 -nodeType "contour_shader_widthfromcolor" -nodeType "contour_shader_widthfromlightdir"
		 -nodeType "contour_shader_widthfromlight" -nodeType "contour_shader_combi" -nodeType "contour_only"
		 -nodeType "contour_composite" -nodeType "contour_ps" -nodeType "mi_metallic_paint"
		 -nodeType "mi_metallic_paint_x" -nodeType "mi_bump_flakes" -nodeType "mi_car_paint_phen"
		 -nodeType "mi_metallic_paint_output_mixer" -nodeType "mi_car_paint_phen_x" -nodeType "physical_lens_dof"
		 -nodeType "physical_light" -nodeType "dgs_material" -nodeType "dgs_material_photon"
		 -nodeType "dielectric_material" -nodeType "dielectric_material_photon" -nodeType "oversampling_lens"
		 -nodeType "path_material" -nodeType "parti_volume" -nodeType "parti_volume_photon"
		 -nodeType "transmat" -nodeType "transmat_photon" -nodeType "mip_rayswitch" -nodeType "mip_rayswitch_advanced"
		 -nodeType "mip_rayswitch_environment" -nodeType "mip_card_opacity" -nodeType "mip_motionblur"
		 -nodeType "mip_motion_vector" -nodeType "mip_matteshadow" -nodeType "mip_cameramap"
		 -nodeType "mip_mirrorball" -nodeType "mip_grayball" -nodeType "mip_gamma_gain" -nodeType "mip_render_subset"
		 -nodeType "mip_matteshadow_mtl" -nodeType "mip_binaryproxy" -nodeType "mip_rayswitch_stage"
		 -nodeType "mip_fgshooter" -nodeType "mib_ptex_lookup" -nodeType "misss_physical"
		 -nodeType "misss_physical_phen" -nodeType "misss_fast_shader" -nodeType "misss_fast_shader_x"
		 -nodeType "misss_fast_shader2" -nodeType "misss_fast_shader2_x" -nodeType "misss_skin_specular"
		 -nodeType "misss_lightmap_write" -nodeType "misss_lambert_gamma" -nodeType "misss_call_shader"
		 -nodeType "misss_set_normal" -nodeType "misss_fast_lmap_maya" -nodeType "misss_fast_simple_maya"
		 -nodeType "misss_fast_skin_maya" -nodeType "misss_fast_skin_phen" -nodeType "misss_fast_skin_phen_d"
		 -nodeType "misss_mia_skin2_phen" -nodeType "misss_mia_skin2_phen_d" -nodeType "misss_lightmap_phen"
		 -nodeType "misss_mia_skin2_surface_phen" -nodeType "surfaceSampler" -nodeType "mib_data_bool"
		 -nodeType "mib_data_int" -nodeType "mib_data_scalar" -nodeType "mib_data_vector"
		 -nodeType "mib_data_color" -nodeType "mib_data_string" -nodeType "mib_data_texture"
		 -nodeType "mib_data_shader" -nodeType "mib_data_bool_array" -nodeType "mib_data_int_array"
		 -nodeType "mib_data_scalar_array" -nodeType "mib_data_vector_array" -nodeType "mib_data_color_array"
		 -nodeType "mib_data_string_array" -nodeType "mib_data_texture_array" -nodeType "mib_data_shader_array"
		 -nodeType "mib_data_get_bool" -nodeType "mib_data_get_int" -nodeType "mib_data_get_scalar"
		 -nodeType "mib_data_get_vector" -nodeType "mib_data_get_color" -nodeType "mib_data_get_string"
		 -nodeType "mib_data_get_texture" -nodeType "mib_data_get_shader" -nodeType "mib_data_get_shader_bool"
		 -nodeType "mib_data_get_shader_int" -nodeType "mib_data_get_shader_scalar" -nodeType "mib_data_get_shader_vector"
		 -nodeType "mib_data_get_shader_color" -nodeType "user_ibl_env" -nodeType "user_ibl_rect"
		 -nodeType "mia_material_x_passes" -nodeType "mi_metallic_paint_x_passes" -nodeType "mi_car_paint_phen_x_passes"
		 -nodeType "misss_fast_shader_x_passes" -dataType "byteArray" "Mayatomr" "2014.0 - 3.11.1.4 ";
requires -nodeType "RenderMan" -nodeType "RenderManEnvLightShape" -nodeType "RenderManArchive"
		 -nodeType "RenderManVolume" -nodeType "RenderManLight" -nodeType "RenderManShaderObject"
		 -nodeType "RenderManDisplacement" -nodeType "RenderManShader" -nodeType "PxrLMLayer"
		 -nodeType "PxrLMMixer" -nodeType "PxrOSL" -nodeType "PxrWorley" -nodeType "rmanAOV"
		 -nodeType "RMSLightBlocker" -nodeType "PxrFractal" -nodeType "PxrSkin" -nodeType "PxrTangentField"
		 -nodeType "rmanSideMask" -nodeType "PxrPtexture" -nodeType "PxrProjectionStack" -nodeType "PxrSeExpr"
		 -nodeType "PxrRoundCube" -nodeType "RMSGIPtcLight" -nodeType "RMSMeshLight" -nodeType "RMSGeoLightBlocker"
		 -nodeType "PxrManifold3D" -nodeType "PxrToFloat" -nodeType "PxrCross" -nodeType "rmanDayLight"
		 -nodeType "PxrGlass" -nodeType "PxrDiffuse" -nodeType "rmanPrimVarFloat3" -nodeType "RMSGILight"
		 -nodeType "RMSHair" -nodeType "PxrAttribute" -nodeType "PxrInvert" -nodeType "PxrVoronoise"
		 -nodeType "rmanPrimVarColor" -nodeType "PxrLMGlass" -nodeType "PxrManifold3DN" -nodeType "rmanPrimVarPoint"
		 -nodeType "PxrNormalMap" -nodeType "PxrLMDiffuse" -nodeType "PxrHSL" -nodeType "RMSMatte"
		 -nodeType "PxrLMSubsurface" -nodeType "PxrProjector" -nodeType "PxrToFloat3" -nodeType "RMSCausticLight"
		 -nodeType "rmanTexture3d" -nodeType "PxrBxdfBlend" -nodeType "RMSDisplacement" -nodeType "PxrLMPlastic"
		 -nodeType "PxrPrimvar" -nodeType "PxrThreshold" -nodeType "PxrMix" -nodeType "rmanCellNoise"
		 -nodeType "rmanWorleyTexture" -nodeType "PxrProjectionLayer" -nodeType "PxrVary"
		 -nodeType "PxrClamp" -nodeType "PxrFractalize" -nodeType "rmanManifold3d" -nodeType "PxrTexture"
		 -nodeType "RMSAreaLight" -nodeType "RMSAreaLightManip" -nodeType "rmanPrimVarFloat2"
		 -nodeType "PxrFlakes" -nodeType "rmanPrimVarNormal" -nodeType "PxrDisney" -nodeType "RMSPointLight"
		 -nodeType "PxrLMMetal" -nodeType "PxrBlend" -nodeType "RMSOcean" -nodeType "PxrBlackBody"
		 -nodeType "rmanPrimVarFloat" -nodeType "RMSGPSurface" -nodeType "rmanManifold2d"
		 -nodeType "rmanPrimVarVector" -nodeType "PxrDot" -nodeType "PxrLightEmission" -nodeType "RMSShaveHair"
		 -nodeType "PxrVolume" -nodeType "PxrConstant" -nodeType "PxrBump" -nodeType "RMSGeoAreaLight"
		 -nodeType "RMSGeoAreaLightManip" -nodeType "PxrRemap" -nodeType "RMSEnvLight" -nodeType "rmanWaveletNoise3d"
		 -nodeType "RMSGlass" -nodeType "PxrExposure" -nodeType "PxrFacingRatio" -nodeType "RMSHoldOut"
		 -nodeType "PxrGamma" -nodeType "rmanImageFile" -nodeType "rmanOcclusion" -nodeType "PxrManifold2D"
		 -nodeType "PxrRamp" -nodeType "PxrMatteID" -nodeType "PxrThinFilm" -nodeType "PxrHair"
		 "RenderMan_for_Maya" "5.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014 x64";
fileInfo "cutIdentifier" "201303010241-864206";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode PxrLMMetal -n "PxrLMMetalCopper";
	setAttr ".eta" -type "float3" 0 0.86170602 0.99599999 ;
	setAttr ".kappa" -type "float3" 2.506 1.3674334 1.1251941 ;
	setAttr ".roughness" 0.25;
	setAttr ".anisotropy" -0.34999999403953552;
	setAttr ".specularColor" -type "float3" 1 0.92516798 0.90999997 ;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" (
		"slimcache 1\n{\n{000008000eWFBxCK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface TechSuitBase (material) [SetSlimInstance material surface {TechSuitBase} 000008000eWFBxCK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000eWFBxCK\"\nSurface \"slim/shaders/GPShaderBall/TechSuitBase\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.675 0.725 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0672 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_Space\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000eWFBxCK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000018000eGAqRBK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Soap (material) [SetSlimInstance material surface {Soap} 000018000eGAqRBK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000eGAqRBK\"\n"
		+ "Surface \"slim/shaders/GPShaderBall/Soap\" \"color emission\" \\[ 0.0534540503254 0.035264 0.058 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssAlbedo\" \\[ 0.535 0.535 0.535 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0.693 0.693 0.693 \\] \"color sssTint\" \\[ 1 0.73125 1 \\] \"color surfaceColor\" \\[ 1 0.5625 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float Enable\" \\[ 1 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.80 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectIrradiance\" \\[ 0 \\] \"float indirectSpecularScale\" \\[ 0.299 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.1494 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 0.49 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 5.00 \\] \"float sssOutsideRays\" \\[ 0 \\] \"float sssSamples\" \\[ 256 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"[bakepassclass impliedSS]\" \\] \"string sssMap\" \\[ \"[bakemap -atlas _sss -chan _radiance_t -map $INSTANCENAME  -crew $SHADERGROUP -style impliedSS -disable 0]\" \\] \"string sssOutputFile\" \\[ \"[ptcfile _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssPassID\" \\[ \"[bakepassid _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000eGAqRBK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000018000eGNmqBK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface GlossyTiled (material) [SetSlimInstance material surface {GlossyTiled} 000018000eGNmqBK {}]\nTransformBegin\nAttribute \"displacementbound\" \\\"sphere\\\" \\[3.000\\] \\\"coordinatesystem\\\" \\[\\\"shader\\\"\\]\nAttribute \"user\" \"string SlimSurfId\" \"000018000eGNmqBK\"\n"
		+ "Surface \"slim/shaders/GPShaderBall/GlossyTiled\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.000 0.000 0.000 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float Tile_Jitter\" \\[ 0 \\] \"float Tile_period\" \\[ 0.88 \\] \"float Tile_randomz\" \\[ 0 \\] \"float Tile_rowoffset\" \\[ 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float backSideReflections\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.80 \\] \"float diffuseRoughness\" \\[ 0.00 \\] \"float dispMode\" \\[ 1 \\] \"float displacementAmount\" \\[ 0.10 \\] \"float enableDisplacement\" \\[ 0 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0200 \\] \"float roughnessB\" \\[ 0.0088 \\] \"float specularBlend\" \\[ 0.00 \\] \"float specularBroadening\" \\[ 1 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"point Tile_Frequency\" \\[ 16 16 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000eGNmqBK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000018000emPmqBK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface GlossyBlack (material) [SetSlimInstance material surface {GlossyBlack} 000018000emPmqBK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000emPmqBK\"\nSurface \"slim/shaders/GPShaderBall/GlossyBlack\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.000 0.000 0.000 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.80 \\] \"float diffuseRoughness\" \\[ 0.00 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0001 \\] \"float roughnessB\" \\[ 0.0088 \\] \"float specularBlend\" \\[ 0.00 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000emPmqBK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000emsbwCK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface GPSurface (material) [SetSlimInstance material surface {GPSurface} 000008000emsbwCK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000emsbwCK\"\nSurface \"slim/shaders/GPShaderBall/GPSurface\" \"color emission\" \\[ 0.090 0.090 0.090 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 1 0.06875 0.06875 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000emsbwCK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000018000eGiR5DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Sapphire (material) [SetSlimInstance material surface {Sapphire} 000018000eGiR5DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000eGiR5DK\"\nSurface \"slim/shaders/GPShaderBall/Sapphire\" \"color specularColor\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 1.000 0.928133050053 0.425 \\] \"float __computesOpacity\" \\[ 1 \\] \"float anisotropy\" \\[ 0 \\] \"float beersUnitScale\" \\[ 0.950 \\] \"float compositionRule\" \\[ 1 \\] \"float computeBeers\" \\[ 1 \\] \"float dispMode\" \\[ 1 \\] \"float internalReflectionAttenuation\" \\[ 0.90 \\] \"float internalReflectionLimit\" \\[ 4 \\] \"float ior\" \\[ 1.63 \\] \"float maxSpecularSamples\" \\[ 8 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float roughness\" \\[ .0001 \\] \"float specularClamp\" \\[ 100 \\] \"float specularGain\" \\[ 1 \\] \"string displacementMap\" \\[ \"\" \\] \"string roughnessMap\" \\[ \"\" \\] \"string specularMap\" \\[ \"\" \\] \"string surfaceMap\" \\[ \"\" \\] \"__instanceid\" \"000018000eGiR5DK\"\n\nTransformEnd\n"
		+ "IfEnd\n}}\n{\n{zz0} surface}\n{\n{000008000eG6E5DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Ceramic_Green (material) [SetSlimInstance material surface {Ceramic_Green} 000008000eG6E5DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000eG6E5DK\"\nSurface \"slim/shaders/GPShaderBall/Ceramic_Green\" \"color emission\" \\[ 0.00950033079873 0.010 0.0075 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 0.918 1 0.939161660645 \\] \"color sssDmfp\" \\[ 1 1 0.8625 \\] \"color sssMix\" \\[ 0.179 0.179 0.179 \\] \"color sssTint\" \\[ 0.917998016327 1.0 0.939147020676 \\] \"color translucentColor\" \\[ 0.0 0.000 0.0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ 0.01 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.64 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0.05 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ 0.05 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1.50 \\] \"float sssSamples\" \\[ 64 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"[bakepassclass impliedSS]\" \\] \"string sssMap\" \\[ \"[bakemap -atlas _sss -chan _radiance_t -map $INSTANCENAME  -crew $SHADERGROUP -style impliedSS -disable 0]\" \\] \"string sssOutputFile\" \\[ \"[ptcfile _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssPassID\" \\[ \"[bakepassid _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000eG6E5DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000eWUnQDK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface GPSurface (material) [SetSlimInstance material surface {GPSurface} 000008000eWUnQDK {}]\nTransformBegin\nAttribute \"displacementbound\" \\\"sphere\\\" \\[1.000\\] \\\"coordinatesystem\\\" \\[\\\"shader\\\"\\]\nAttribute \"user\" \"string SlimSurfId\" \"000008000eWUnQDK\"\nSurface \"slim/shaders/GPShaderBall/GPSurface\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 1 1 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_2_Space\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000eWUnQDK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000018000eWsOvCK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Milk (material) [SetSlimInstance material surface {Milk} 000018000eWsOvCK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000eWsOvCK\"\n"
		+ "Surface \"slim/shaders/GPShaderBall/Milk\" \"color emission\" \\[ 0.022 0.022 0.022 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssAlbedo\" \\[ 0.964 0.964 0.964 \\] \"color sssDmfp\" \\[ 1.0 1.0 0.906248569467 \\] \"color sssMix\" \\[ 0.672 0.672 0.672 \\] \"color sssTint\" \\[ 1 1 0.90625 \\] \"color surfaceColor\" \\[ 1 1 0.95625 \\] \"color translucentColor\" \\[ 0.044 0.044 0.044 \\] \"float Enable\" \\[ 1 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 1.00 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectIrradiance\" \\[ 1 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.35 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 5.00 \\] \"float sssMaxDist\" \\[ 10 \\] \"float sssOutsideRays\" \\[ 0 \\] \"float sssSamples\" \\[ 128 \\] \"float sssUnitlen\" \\[ .1 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"[bakepassclass impliedSS]\" \\] \"string sssMap\" \\[ \"[bakemap -atlas _sss -chan _radiance_t -map $INSTANCENAME  -crew $SHADERGROUP -style impliedSS -disable 0]\" \\] \"string sssOutputFile\" \\[ \"[ptcfile _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssPassID\" \\[ \"[bakepassid _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000eWsOvCK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000e03b4DK} class surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Metal_CarRim (material) [SetSlimInstance material surface {Metal_CarRim} 000008000e03b4DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000e03b4DK\"\nSurface \"slim/shaders/GPShaderBall/Metal_CarRim\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.425952 0.464370087204 0.522 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0.0000 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 1.00 \\] \"float diffuseRoughness\" \\[ 0.00 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 0.00 \\] \"float indirectSpecularScale\" \\[ 0.600 \\] \"float ior\" \\[ 2.36 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0.78 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0650 \\] \"float roughnessB\" \\[ 0.0200 \\] \"float specularBlend\" \\[ 0.16 \\] \"float specularGain\" \\[ 0.50 \\] \"float specularGainB\" \\[ 0.075 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000e03b4DK\"\n"
		+ "TransformEnd\nIfEnd\n} coshader {IfBegin \"!defined(user:RATFilterShader)\"\n#slim coshader Metal_CarRim (material) [SetSlimInstance material coshader {Metal_CarRim} 000008000e03b4DK {}]\nTransformBegin\nShader \"slim/shaders/GPShaderBall/Metal_CarRim\" \"000008000e03b4DK\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.425952 0.464370087204 0.522 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0.0000 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 1.00 \\] \"float diffuseRoughness\" \\[ 0.00 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 0.00 \\] \"float indirectSpecularScale\" \\[ 0.600 \\] \"float ior\" \\[ 2.36 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0.78 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0650 \\] \"float roughnessB\" \\[ 0.0200 \\] \"float specularBlend\" \\[ 0.16 \\] \"float specularGain\" \\[ 0.50 \\] \"float specularGainB\" \\[ 0.075 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000e03b4DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000e05ExCK} class coshader {IfBegin \"!defined(user:RATFilterShader)\"\n#slim coshader TechSuitSeams (material) [SetSlimInstance material coshader {TechSuitSeams} 000008000e05ExCK {}]\nTransformBegin\nShader \"slim/shaders/GPShaderBall/TechSuitSeams\" \"000008000e05ExCK\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.1125 0.1125 0.1125 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 1 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0650 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_Space\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000e05ExCK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000e0IRcCK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Marble_GlossyHardCut (material) [SetSlimInstance material surface {Marble_GlossyHardCut} 000008000e0IRcCK {}]\nTransformBegin\nAttribute \"displacementbound\" \\\"sphere\\\" \\[3.000\\] \\\"coordinatesystem\\\" \\[\\\"shader\\\"\\]\nAttribute \"user\" \"string SlimSurfId\" \"000008000e0IRcCK\"\n"
		+ "Surface \"slim/shaders/GPShaderBall/Marble_GlossyHardCut\" \"color specColorB\" \\[ 1 1 1 \\] \"color sssAlbedo\" \\[ 0.34875 0.458671875 0.6 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0.161 0.161 0.161 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float Enable\" \\[ 1 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.80 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float displacementAmount\" \\[ 0.01 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectIrradiance\" \\[ 1 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.50 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0561 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 3.00 \\] \"float sssOutsideRays\" \\[ 0 \\] \"float sssSamples\" \\[ 16 \\] \"float sssUnitlen\" \\[ .1 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"[bakepassclass impliedSS]\" \\] \"string sssMap\" \\[ \"[bakemap -atlas _sss -chan _radiance_t -map $INSTANCENAME  -crew $SHADERGROUP -style impliedSS -disable 0]\" \\] \"string sssOutputFile\" \\[ \"[ptcfile _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssPassID\" \\[ \"[bakepassid _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000e0IRcCK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000eGrExCK} surface surface {TransformBegin\nAttribute \"sides\"  \\\"int doubleshaded\\\" \\[0\\]\nScale 1 1 1\nAttribute \"displacementbound\" \\\"sphere\\\" \\[3.000\\] \\\"coordinatesystem\\\" \\[\\\"shader\\\"\\]\nOpacity \\[1 1 1\\]\nAttribute \"shade\" \\\"string transmissionhitmode\\\" \\[\\\"primitive\\\"\\] \\\"float volumeintersectionpriority\\\" \\[0\\]\nColor \\[1 1 1\\]\nAttribute \"trace\"  \\\"int samplemotion\\\" \\[0\\] \\\"int displacements\\\" \\[0\\]\nIfBegin \"!defined(user:RATFilterShader)\"\n#slim coshader TechSuitSeams (material) [SetSlimInstance material coshader {TechSuitSeams} 000008000e05ExCK {}]\nTransformBegin\n"
		+ "Shader \"slim/shaders/GPShaderBall/TechSuitSeams\" \"000008000e05ExCK\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.1125 0.1125 0.1125 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float SurfacePt_Frequency\" \\[ 1.000 \\] \"float SurfacePt_IgnorePref\" \\[ 0 \\] \"float SurfacePt_mode\" \\[ 0 \\] \"float __computesOpacity\" \\[ 1 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0650 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_Space\" \\[ \"world\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000e05ExCK\"\n"
		+ "TransformEnd\nIfEnd\nIfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface TechSuitBase (material) [SetSlimInstance material surface {TechSuitBase} 000008000eWFBxCK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000eWFBxCK\"\nSurface \"slim/shaders/GPShaderBall/TechSuitBase\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.675 0.725 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float SurfacePt_Frequency\" \\[ 1.000 \\] \"float SurfacePt_IgnorePref\" \\[ 0 \\] \"float SurfacePt_mode\" \\[ 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0672 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_Space\" \\[ \"world\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"string\\[1\\] __coshaders\" \\[ \"000008000e05ExCK\" \\] \"__instanceid\" \"000008000eWFBxCK\"\n"
		+ "TransformEnd\nIfEnd\nTransformEnd\n}}\n{\n{000018000eGIWbCK} surface}\n{\n{000018000emBL5DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Ceramic_Green (material) [SetSlimInstance material surface {Ceramic_Green} 000018000emBL5DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000emBL5DK\"\n"
		+ "Surface \"slim/shaders/GPShaderBall/Ceramic_Green\" \"color emission\" \\[ 0.00950033079873 0.010 0.0075 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 0.918 1 0.939161660645 \\] \"color sssDmfp\" \\[ 1 1 0.8625 \\] \"color sssMix\" \\[ 0.179 0.179 0.179 \\] \"color sssTint\" \\[ 0.917998016327 1.0 0.939147020676 \\] \"color translucentColor\" \\[ 0.0 0.000 0.0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ 0.01 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.64 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0.05 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ 0.05 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1.50 \\] \"float sssSamples\" \\[ 64 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"[bakepassclass impliedSS]\" \\] \"string sssMap\" \\[ \"[bakemap -atlas _sss -chan _radiance_t -map $INSTANCENAME  -crew $SHADERGROUP -style impliedSS -disable 0]\" \\] \"string sssOutputFile\" \\[ \"[ptcfile _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssPassID\" \\[ \"[bakepassid _sss $INSTANCENAME impliedSS $SHADERGROUP]\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000emBL5DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000018000emSmqBK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Whitewash (material) [SetSlimInstance material surface {Whitewash} 000018000emSmqBK {}]\nTransformBegin\nAttribute \"displacementbound\" \\\"sphere\\\" \\[1.000\\] \\\"coordinatesystem\\\" \\[\\\"shader\\\"\\]\nAttribute \"user\" \"string SlimSurfId\" \"000018000emSmqBK\"\n"
		+ "Surface \"slim/shaders/GPShaderBall/Whitewash\" \"color emission\" \\[ 0.0826527213663 0.087 0.0652499999999 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssAlbedo\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0.062 0.062 0.062 \\] \"color sssTint\" \\[ 0.856214236667 0.856214236667 0.690318150607 \\] \"color surfaceColor\" \\[ 1 1 0.91875 \\] \"color translucentColor\" \\[ 0.000 0.000 0.000 \\] \"float Enable\" \\[ 0 \\] \"float Whitewash_Step_softness\" \\[ 0.14 \\] \"float Whitewash_Step_threshold\" \\[ 0.30 \\] \"float Whitewash_Turbulence_baseFrequency\" \\[ 15.891 \\] \"float Whitewash_Turbulence_gain\" \\[ 1.10 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 1.00 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float displacementAmount\" \\[ 0.01 \\] \"float enableDisplacement\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectIrradiance\" \\[ 0 \\] \"float indirectSpecularScale\" \\[ 0.075 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0748 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 0.66 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 2.00 \\] \"float sssOutsideRays\" \\[ 0 \\] \"float sssSamples\" \\[ 16 \\] \"float sssUnitlen\" \\[ .1 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_Space\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000emSmqBK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{0} surface}\n{\n{000018000e00B5DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface BrassMediumBlur (material) [SetSlimInstance material surface {BrassMediumBlur} 000018000e00B5DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000e00B5DK\"\nSurface \"slim/shaders/GPShaderBall/BrassMediumBlur\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 0.754 0.718084639717 0.538557731782 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.119 0.0862752290755 0.02900625 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 0.784 \\] \"float ior\" \\[ 2.43 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0.46 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0400 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 0.89 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000018000e00B5DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{render_swatch_harsh2:RMSMatte3SG} surface}\n{\n{render_swatch_harsh2:RenderManShader1SG} surface}\n{\n{000008000e0jL5DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Garnet (material) [SetSlimInstance material surface {Garnet} 000008000e0jL5DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000e0jL5DK\"\nSurface \"slim/shaders/GPShaderBall/Garnet\" \"color specularColor\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.45 0.0 0.0 \\] \"float __computesOpacity\" \\[ 1 \\] \"float anisotropy\" \\[ 0 \\] \"float beersUnitScale\" \\[ 1.300 \\] \"float compositionRule\" \\[ 1 \\] \"float computeBeers\" \\[ 1 \\] \"float dispMode\" \\[ 1 \\] \"float internalReflectionAttenuation\" \\[ 0.90 \\] \"float internalReflectionLimit\" \\[ 4 \\] \"float ior\" \\[ 1.63 \\] \"float maxSpecularSamples\" \\[ 8 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float roughness\" \\[ .0001 \\] \"float specularClamp\" \\[ 100 \\] \"float specularGain\" \\[ 1 \\] \"string displacementMap\" \\[ \"\" \\] \"string roughnessMap\" \\[ \"\" \\] \"string specularMap\" \\[ \"\" \\] \"string surfaceMap\" \\[ \"\" \\] \"__instanceid\" \"000008000e0jL5DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000eGR0FDK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface TestSurface (material) [SetSlimInstance material surface {TestSurface} 000008000eGR0FDK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000eGR0FDK\"\nSurface \"slim/shaders/GPShaderBall/TestSurface\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 1 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string SurfacePt_Space\" \\[ \"OuterRing_coordsys\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000eGR0FDK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000eGiLxCK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface CheckTest (material) [SetSlimInstance material surface {CheckTest} 000008000eGiLxCK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000eGiLxCK\"\nSurface \"slim/shaders/GPShaderBall/CheckTest\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 1 1 1 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 1 \\] \"float ior\" \\[ 1.5 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ .008 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 1 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000eGiLxCK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{render_swatch_harsh2:RMSMatte2SG} surface}\n{\n{000018000eGZV5DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface SapphireBlue (material) [SetSlimInstance material surface {SapphireBlue} 000018000eGZV5DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000018000eGZV5DK\"\nSurface \"slim/shaders/GPShaderBall/SapphireBlue\" \"color specularColor\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.323 0.54302002405 1.000 \\] \"float __computesOpacity\" \\[ 1 \\] \"float anisotropy\" \\[ 0 \\] \"float beersUnitScale\" \\[ 1.250 \\] \"float compositionRule\" \\[ 1 \\] \"float computeBeers\" \\[ 1 \\] \"float dispMode\" \\[ 1 \\] \"float internalReflectionAttenuation\" \\[ 0.90 \\] \"float internalReflectionLimit\" \\[ 4 \\] \"float ior\" \\[ 1.63 \\] \"float maxSpecularSamples\" \\[ 8 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float roughness\" \\[ .0001 \\] \"float specularClamp\" \\[ 100 \\] \"float specularGain\" \\[ 1 \\] \"string displacementMap\" \\[ \"\" \\] \"string roughnessMap\" \\[ \"\" \\] \"string specularMap\" \\[ \"\" \\] \"string surfaceMap\" \\[ \"\" \\] \"__instanceid\" \"000018000eGZV5DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n{\n{000008000e0f35DK} surface surface {IfBegin \"!defined(user:RATFilterSurface)\"\n#slim surface Brass (material) [SetSlimInstance material surface {Brass} 000008000e0f35DK {}]\nTransformBegin\nAttribute \"user\" \"string SlimSurfId\" \"000008000e0f35DK\"\nSurface \"slim/shaders/GPShaderBall/Brass\" \"color emission\" \\[ 0 0 0 \\] \"color specColorB\" \\[ 1 1 1 \\] \"color specularColor\" \\[ 0.754 0.718084639717 0.538557731782 \\] \"color sssDmfp\" \\[ 1 1 1 \\] \"color sssMix\" \\[ 0 0 0 \\] \"color sssTint\" \\[ 1 1 1 \\] \"color surfaceColor\" \\[ 0.119 0.0862752290755 0.02900625 \\] \"color translucentColor\" \\[ 0 0 0 \\] \"float __computesOpacity\" \\[ 0 \\] \"float anisotropy\" \\[ 0 \\] \"float anisotropyB\" \\[ 0 \\] \"float compositionRule\" \\[ 1 \\] \"float diffuseGain\" \\[ 0.88 \\] \"float diffuseRoughness\" \\[ .1 \\] \"float dispMode\" \\[ 1 \\] \"float flakeAmount\" \\[ 0 \\] \"float flakeScale\" \\[ 10 \\] \"float indirectSpecularScale\" \\[ 0.784 \\] \"float ior\" \\[ 2.43 \\] \"float maxLightSamples\" \\[ 16 \\] \"float maxSpecularSamples\" \\[ 16 \\] \"float metallic\" \\[ 0.46 \\] \"float minLightSamples\" \\[ 1 \\] \"float minSpecularSamples\" \\[ 1 \\] \"float purity\" \\[ .002 \\] \"float roughness\" \\[ 0.0400 \\] \"float roughnessB\" \\[ .008 \\] \"float specularBlend\" \\[ 0 \\] \"float specularGain\" \\[ 0.89 \\] \"float specularGainB\" \\[ 1 \\] \"float sssDmfpScale\" \\[ 1 \\] \"float sssSamples\" \\[ 16 \\] \"string DisplacementMap\" \\[ \"\" \\] \"string MaskMap\" \\[ \"\" \\] \"string RoughnessMap\" \\[ \"\" \\] \"string SpecularMap\" \\[ \"\" \\] \"string SpecularMapB\" \\[ \"\" \\] \"string SurfaceMap\" \\[ \"\" \\] \"string __category\" \\[ \"RMSGPLayer\" \\] \"string sssConversionClass\" \\[ \"\" \\] \"string sssMap\" \\[ \"\" \\] \"string sssOutputFile\" \\[ \"\" \\] \"string sssPassID\" \\[ \"\" \\] \"string sssSpace\" \\[ \"world\" \\] \"__instanceid\" \"000008000e0f35DK\"\n"
		+ "TransformEnd\nIfEnd\n}}\n");
createNode PxrBump -n "copper1:PxrBump2";
	setAttr ".scale" 0.0010000000474974513;
createNode noise -n "copper1:noise1";
	setAttr ".ail" yes;
	setAttr ".ag" 0.039999999105930328;
	setAttr ".ra" 0.82051283121109009;
	setAttr ".th" 0.17948718369007111;
	setAttr ".dm" 5;
	setAttr ".fq" 17.094017028808594;
	setAttr ".nty" 0;
createNode place2dTexture -n "copper1:place2dTexture2";
	setAttr ".re" -type "float2" 1 7 ;
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 1;
	setAttr -av ".unw" 1;
select -ne :renderPartition;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 33 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
select -ne :initialShadingGroup;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
	setAttr -cb on ".mimt";
	setAttr -cb on ".miop";
	setAttr -k on ".mico";
	setAttr -cb on ".mise";
	setAttr -cb on ".mism";
	setAttr -cb on ".mice";
	setAttr -av -cb on ".micc";
	setAttr -k on ".micr";
	setAttr -k on ".micg";
	setAttr -k on ".micb";
	setAttr -cb on ".mica";
	setAttr -cb on ".micw";
	setAttr -cb on ".mirw";
select -ne :initialParticleSE;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
	setAttr -cb on ".mimt";
	setAttr -cb on ".miop";
	setAttr -k on ".mico";
	setAttr -cb on ".mise";
	setAttr -cb on ".mism";
	setAttr -cb on ".mice";
	setAttr -av -cb on ".micc";
	setAttr -k on ".micr";
	setAttr -k on ".micg";
	setAttr -k on ".micb";
	setAttr -cb on ".mica";
	setAttr -av -cb on ".micw";
	setAttr -cb on ".mirw";
select -ne :defaultShaderList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 31 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 118 ".tx";
select -ne :lightList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".l";
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 51 ".u";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".macc";
	setAttr -k on ".macd";
	setAttr -k on ".macq";
	setAttr -k on ".mcfr";
	setAttr -cb on ".ifg";
	setAttr -k on ".clip";
	setAttr -k on ".edm";
	setAttr -k on ".edl";
	setAttr -cb on ".ren" -type "string" "renderManRIS";
	setAttr -av -k on ".esr";
	setAttr -k on ".ors";
	setAttr -cb on ".sdf";
	setAttr -av -k on ".outf";
	setAttr -k on ".imfkey";
	setAttr -k on ".gama";
	setAttr -k on ".an";
	setAttr -cb on ".ar";
	setAttr -k on ".fs";
	setAttr -k on ".ef";
	setAttr -av -k on ".bfs";
	setAttr -cb on ".me";
	setAttr -cb on ".se";
	setAttr -k on ".be";
	setAttr -cb on ".ep";
	setAttr -k on ".fec";
	setAttr -k on ".ofc";
	setAttr -cb on ".ofe";
	setAttr -cb on ".efe";
	setAttr -cb on ".oft";
	setAttr -cb on ".umfn";
	setAttr -cb on ".ufe";
	setAttr -cb on ".pff";
	setAttr -k on ".peie";
	setAttr -cb on ".ifp";
	setAttr -k on ".comp";
	setAttr -k on ".cth";
	setAttr -k on ".soll";
	setAttr -cb on ".sosl";
	setAttr -k on ".rd";
	setAttr -k on ".lp";
	setAttr -av -k on ".sp";
	setAttr -k on ".shs";
	setAttr -k on ".lpr";
	setAttr -cb on ".gv";
	setAttr -cb on ".sv";
	setAttr -k on ".mm";
	setAttr -k on ".npu";
	setAttr -k on ".itf";
	setAttr -k on ".shp";
	setAttr -cb on ".isp";
	setAttr -k on ".uf";
	setAttr -k on ".oi";
	setAttr -k on ".rut";
	setAttr -cb on ".mb";
	setAttr -av -k on ".mbf";
	setAttr -k on ".afp";
	setAttr -k on ".pfb";
	setAttr -k on ".pram";
	setAttr -k on ".poam";
	setAttr -k on ".prlm";
	setAttr -k on ".polm";
	setAttr -cb on ".prm";
	setAttr -cb on ".pom";
	setAttr -cb on ".pfrm";
	setAttr -cb on ".pfom";
	setAttr -av -k on ".bll";
	setAttr -av -k on ".bls";
	setAttr -av -k on ".smv";
	setAttr -k on ".ubc";
	setAttr -k on ".mbc";
	setAttr -cb on ".mbt";
	setAttr -k on ".udbx";
	setAttr -k on ".smc";
	setAttr -k on ".kmv";
	setAttr -cb on ".isl";
	setAttr -cb on ".ism";
	setAttr -cb on ".imb";
	setAttr -k on ".rlen";
	setAttr -av -k on ".frts";
	setAttr -k on ".tlwd";
	setAttr -k on ".tlht";
	setAttr -k on ".jfc";
	setAttr -cb on ".rsb";
	setAttr -k on ".ope";
	setAttr -k on ".oppf";
	setAttr -cb on ".hbl";
select -ne :defaultResolution;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av ".w" 720;
	setAttr -av ".h" 720;
	setAttr -av -k on ".pa" 1;
	setAttr -av -k on ".al" yes;
	setAttr -av ".dar" 1;
	setAttr -av -k on ".ldar";
	setAttr -k on ".dpi";
	setAttr -av -k on ".off";
	setAttr -av -k on ".fld";
	setAttr -av -k on ".zsl";
	setAttr -k on ".isu";
	setAttr -k on ".pdu";
select -ne :defaultLightSet;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -s 2 ".dsm";
	setAttr -k on ".mwc";
	setAttr -k on ".an";
	setAttr -k on ".il";
	setAttr -k on ".vo";
	setAttr -k on ".eo";
	setAttr -k on ".fo";
	setAttr -k on ".epo";
	setAttr -k on ".ro" yes;
select -ne :defaultObjectSet;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -k on ".mwc";
	setAttr -k on ".an";
	setAttr -k on ".il";
	setAttr -k on ".vo";
	setAttr -k on ".eo";
	setAttr -k on ".fo";
	setAttr -k on ".epo";
	setAttr ".ro" yes;
select -ne :hardwareRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr ".ctrs" 256;
	setAttr -av ".btrs" 512;
	setAttr -k off ".fbfm";
	setAttr -k off -cb on ".ehql";
	setAttr -k off -cb on ".eams";
	setAttr -k off -cb on ".eeaa";
	setAttr -k off -cb on ".engm";
	setAttr -k off -cb on ".mes";
	setAttr -k off -cb on ".emb";
	setAttr -av -k off -cb on ".mbbf";
	setAttr -k off -cb on ".mbs";
	setAttr -k off -cb on ".trm";
	setAttr -k off -cb on ".tshc";
	setAttr -k off ".enpt";
	setAttr -k off -cb on ".clmt";
	setAttr -k off -cb on ".tcov";
	setAttr -k off -cb on ".lith";
	setAttr -k off -cb on ".sobc";
	setAttr -k off -cb on ".cuth";
	setAttr -k off -cb on ".hgcd";
	setAttr -k off -cb on ".hgci";
	setAttr -k off -cb on ".mgcs";
	setAttr -k off -cb on ".twa";
	setAttr -k off -cb on ".twz";
	setAttr -k on ".hwcc";
	setAttr -k on ".hwdp";
	setAttr -k on ".hwql";
	setAttr -k on ".hwfr";
	setAttr -k on ".soll";
	setAttr -k on ".sosl";
	setAttr -k on ".bswa";
	setAttr -k on ".shml";
	setAttr -k on ".hwel";
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 18 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surfaces" "Particles" "Fluids" "Image Planes" "UI:" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 18 0 1 1 1 1 1
		 1 0 0 0 0 0 0 0 0 0 0 0 ;
select -ne :defaultHardwareRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -av -k on ".rp";
	setAttr -k on ".cai";
	setAttr -k on ".coi";
	setAttr -cb on ".bc";
	setAttr -av -k on ".bcb";
	setAttr -av -k on ".bcg";
	setAttr -av -k on ".bcr";
	setAttr -k on ".ei";
	setAttr -av -k on ".ex";
	setAttr -av -k on ".es";
	setAttr -av -k on ".ef";
	setAttr -av -k on ".bf";
	setAttr -k on ".fii";
	setAttr -av -k on ".sf";
	setAttr -k on ".gr";
	setAttr -k on ".li";
	setAttr -k on ".ls";
	setAttr -av -k on ".mb";
	setAttr -k on ".ti";
	setAttr -k on ".txt";
	setAttr -k on ".mpr";
	setAttr -k on ".wzd";
	setAttr -k on ".fn" -type "string" "im";
	setAttr -k on ".if";
	setAttr -k on ".res" -type "string" "ntsc_4d 646 485 1.333";
	setAttr -k on ".as";
	setAttr -k on ".ds";
	setAttr -k on ".lm";
	setAttr -av -k on ".fir";
	setAttr -k on ".aap";
	setAttr -av -k on ".gh";
	setAttr -cb on ".sd";
connectAttr "copper1:PxrBump2.resultN" "PxrLMMetalCopper.bumpNormal";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "copper1:noise1.oa" "copper1:PxrBump2.inputBump";
connectAttr "copper1:place2dTexture2.o" "copper1:noise1.uv";
connectAttr "copper1:place2dTexture2.ofs" "copper1:noise1.fs";
connectAttr "PxrLMMetalCopper.msg" ":defaultShaderList1.s" -na;
connectAttr "copper1:PxrBump2.msg" ":defaultTextureList1.tx" -na;
connectAttr "copper1:noise1.msg" ":defaultTextureList1.tx" -na;
connectAttr "copper1:place2dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
// End of Metal_NonFerrous_Copper.ma
