//Maya ASCII 2014 scene
//Name: BeetleBack.ma
//Last modified: Wed, Feb 25, 2015 02:51:05 PM
//Codeset: UTF-8
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
		 -nodeType "misss_fast_shader_x_passes" -dataType "byteArray" "Mayatomr" "2014.0 - 3.11.1.13 ";
requires -nodeType "RenderMan" -nodeType "RenderManEnvLightShape" -nodeType "RenderManArchive"
		 -nodeType "RenderManVolume" -nodeType "RenderManLight" -nodeType "RenderManShaderObject"
		 -nodeType "RenderManDisplacement" -nodeType "RenderManShader" -nodeType "RMSHoldOut"
		 -nodeType "RMSGeoAreaLight" -nodeType "RMSGeoAreaLightManip" -nodeType "PxrFacingRatio"
		 -nodeType "PxrBxdfBlend" -nodeType "RMSMeshLight" -nodeType "rmanCellNoise" -nodeType "PxrToFloat"
		 -nodeType "PxrDisney" -nodeType "RMSGPSurface" -nodeType "PxrProjectionLayer" -nodeType "PxrThinFilm"
		 -nodeType "PxrAttribute" -nodeType "RMSGILight" -nodeType "RMSLightBlocker" -nodeType "rmanPrimVarNormal"
		 -nodeType "PxrSeExpr" -nodeType "RMSCausticLight" -nodeType "RMSAreaLight" -nodeType "RMSAreaLightManip"
		 -nodeType "rmanPrimVarVector" -nodeType "PxrVary" -nodeType "rmanWaveletNoise3d"
		 -nodeType "PxrThreshold" -nodeType "PxrDot" -nodeType "PxrTexture" -nodeType "RMSShaveHair"
		 -nodeType "RMSMatte" -nodeType "PxrDiffuse" -nodeType "rmanPrimVarPoint" -nodeType "rmanAOV"
		 -nodeType "PxrNormalMap" -nodeType "PxrPtexture" -nodeType "PxrBlackBody" -nodeType "PxrExposure"
		 -nodeType "PxrLMLayer" -nodeType "rmanPrimVarFloat2" -nodeType "rmanPrimVarFloat3"
		 -nodeType "PxrRemap" -nodeType "PxrOSL" -nodeType "rmanPrimVarFloat" -nodeType "rmanImageFile"
		 -nodeType "PxrGlass" -nodeType "RMSGIPtcLight" -nodeType "PxrPrimvar" -nodeType "PxrLMMixer"
		 -nodeType "PxrToFloat3" -nodeType "PxrLMGlass" -nodeType "PxrHair" -nodeType "rmanPrimVarColor"
		 -nodeType "PxrConstant" -nodeType "PxrVolume" -nodeType "PxrGamma" -nodeType "PxrBlend"
		 -nodeType "PxrLMDiffuse" -nodeType "PxrFractal" -nodeType "RMSHair" -nodeType "PxrVoronoise"
		 -nodeType "RMSPointLight" -nodeType "PxrLMPlastic" -nodeType "PxrTangentField" -nodeType "rmanDayLight"
		 -nodeType "RMSEnvLight" -nodeType "PxrMix" -nodeType "PxrSkin" -nodeType "PxrManifold2D"
		 -nodeType "PxrManifold3D" -nodeType "PxrRoundCube" -nodeType "rmanSideMask" -nodeType "PxrProjector"
		 -nodeType "PxrRamp" -nodeType "PxrInvert" -nodeType "PxrMatteID" -nodeType "PxrLMSubsurface"
		 -nodeType "PxrProjectionStack" -nodeType "rmanTexture3d" -nodeType "PxrCross" -nodeType "PxrLightEmission"
		 -nodeType "RMSDisplacement" -nodeType "PxrLMMetal" -nodeType "RMSOcean" -nodeType "rmanOcclusion"
		 -nodeType "PxrManifold3DN" -nodeType "PxrWorley" -nodeType "RMSGlass" -nodeType "PxrBump"
		 -nodeType "rmanManifold2d" -nodeType "RMSGeoLightBlocker" -nodeType "PxrClamp" -nodeType "rmanManifold3d"
		 -nodeType "rmanWorleyTexture" -nodeType "PxrFractalize" -nodeType "PxrHSL" -nodeType "PxrFlakes"
		 "RenderMan_for_Maya" "5.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014";
fileInfo "cutIdentifier" "201310090405-890429";
fileInfo "osv" "Mac OS X 10.9.2";
createNode place3dTexture -n "place3dTexture11";
	setAttr ".s" -type "double3" 0.4 0.4 0.4 ;
createNode shadingEngine -n "LM_BeetleBack1";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode PxrLMPlastic -n "LM_BeetleBack";
	setAttr ".diffuseColor" -type "float3" 0 0 0 ;
	setAttr ".incandescence" -type "float3" -0.038591385 -0.038591385 -0.038591385 ;
	setAttr ".specularColor" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".specularAnisotropy" -0.94366198778152466;
	setAttr ".specularEta" -type "float3" 0.155265 0.116723 0.138381 ;
	setAttr ".clearcoatRoughness" 0.20000000298023224;
	setAttr ".clearcoatEta" 1.3999999761581421;
createNode place2dTexture -n "place2dTexture13";
createNode remapValue -n "remapValue14";
	setAttr -s 2 ".vl[0:1]"  0 1 1 1 15 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode ramp -n "ramp_dot_remap";
	setAttr ".in" 2;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.93300003 0.87800902 0.79305005 ;
createNode volumeNoise -n "volumeNoise_Dots";
	setAttr ".ra" 1;
	setAttr ".dm" 1;
	setAttr ".d" 0.80508476495742798;
	setAttr ".sp" 0;
	setAttr ".sr" 0.44067797064781189;
	setAttr ".rn" 0.38999998569488525;
	setAttr ".fof" 1;
createNode remapValue -n "remapValue13";
	setAttr -s 2 ".vl[0:1]"  0.22608696 2.16499996 2 1 2.20000005 
		1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBump -n "PxrBumpDots";
	setAttr ".scale" -0.0080000003799796104;
createNode volumeNoise -n "volumeNoise_Shell";
	setAttr ".ra" 0.62711864709854126;
	setAttr ".dm" 4;
	setAttr ".fq" 3;
	setAttr ".nty" 2;
createNode remapValue -n "remapValue_Spec1";
	setAttr -s 2 ".vl[0:1]"  0 0.62 1 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "remapValue12";
	setAttr -s 2 ".vl[0:1]"  0 0.56 2 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "remapValue_BumpDots";
	setAttr -s 2 ".vl[0:1]"  0 0 2 1 0.2 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrThinFilm -n "PxrThinFilm1";
	setAttr ".spread" 0.039999999105930328;
	setAttr ".thickness" 8260;
createNode volumeNoise -n "volumeNoise_Thickness";
	setAttr ".fq" 2;
	setAttr ".nty" 3;
createNode blendColors -n "blendColors_Spec1";
	setAttr ".c1" -type "float3" 0 0 0 ;
createNode remapValue -n "remapValue_Spec_Roughness";
	setAttr -s 3 ".vl[0:2]"  0 0.54000002 1 1 0.1 1 0.26956522
		 0.34 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBump -n "PxrBump_Spec1";
	setAttr ".scale" 0.0030000000260770321;
createNode remapValue -n "remapValue16";
	setAttr -s 2 ".vl[0:1]"  0 0.156 1 1 0.15700001 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "slimcache 1\n{\n{RMSMatte3SG} surface}\n{\n{RenderManShader1SG} surface}\n{\n{RMSMatte2SG} surface}\n";
	setAttr ".rd" -type "string" (
		"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n<RenderManLookFile Version=\"1\" Format=\"RenderMan Look Data\" AssemblyName=\"\">\n    <RuleSet>\n        <Rule FlowControl=\"0\" MatchPhase=\"0\" MatchMethod=\"3\" Id=\"RMSMatte2SG\"><![CDATA[//off]]>            <UserData>\n                <UserDatum Key=\"memo\"><![CDATA[Occlusion]]></UserDatum>\n                <UserDatum Key=\"rowcolor\"><![CDATA[#fff8fd]]></UserDatum>\n            </UserData>\n        </Rule>\n        <Rule FlowControl=\"0\" MatchPhase=\"0\" MatchMethod=\"3\" Id=\"RMSMatte3SG\"><![CDATA[//off]]>            <UserData>\n                <UserDatum Key=\"memo\"><![CDATA[Pattern]]></UserDatum>\n                <UserDatum Key=\"rowcolor\"><![CDATA[#fffabd]]></UserDatum>\n            </UserData>\n        </Rule>\n        <Rule FlowControl=\"0\" MatchPhase=\"0\" MatchMethod=\"3\" Id=\"RenderManShader1SG\"><![CDATA[//off]]>            <UserData>\n                <UserDatum Key=\"memo\"><![CDATA[Grid]]></UserDatum>\n                <UserDatum Key=\"rowcolor\"><![CDATA[#ff9dab]]></UserDatum>\n            </UserData>\n"
		+ "        </Rule>\n    </RuleSet>\n    <InjectablePayloads>\n        <Payload Id=\"RMSMatte3SG\" Label=\"Pattern\" Source=\"1\" Content=\"1\"><![CDATA[#payload provided at runtime by RFM]]></Payload>\n        <Payload Id=\"RenderManShader1SG\" Label=\"RenderManShader_Grid\" Source=\"1\" Content=\"1\"><![CDATA[#payload provided at runtime by RFM]]></Payload>\n        <Payload Id=\"RMSMatte2SG\" Label=\"GP_Matte_Occlusion\" Source=\"1\" Content=\"1\"><![CDATA[#payload provided at runtime by RFM]]></Payload>\n    </InjectablePayloads>\n</RenderManLookFile>\n");
createNode materialInfo -n "materialInfo672";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 18 ".lnk";
	setAttr -s 18 ".slnk";
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 360;
	setAttr -av ".unw" 360;
select -ne :renderPartition;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 18 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
lockNode -l 1 ;
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
	setAttr -s 17 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 43 ".tx";
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
	setAttr -s 59 ".u";
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
	setAttr -k on ".edl" no;
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
	setAttr ".cpe" yes;
	setAttr -cb on ".hbl";
select -ne :defaultResolution;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av ".w" 1024;
	setAttr -av ".h" 1024;
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
select -ne :defaultViewColorManager;
	setAttr ".ip" 2;
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
connectAttr "LM_BeetleBack.oc" "LM_BeetleBack1.ss";
connectAttr "swatch_teapotShape.iog" "LM_BeetleBack1.dsm" -na;
connectAttr "PxrThinFilm1.resultRGB" "LM_BeetleBack.clearcoatTransmission";
connectAttr "PxrBump_Spec1.resultN" "LM_BeetleBack.specularNn";
connectAttr "PxrBumpDots.resultN" "LM_BeetleBack.diffuseNn";
connectAttr "PxrBumpDots.resultN" "LM_BeetleBack.clearcoatNn";
connectAttr "remapValue_Spec_Roughness.ov" "LM_BeetleBack.specularRoughness";
connectAttr "remapValue12.oc" "LM_BeetleBack.clearcoatColor";
connectAttr "remapValue14.ov" "LM_BeetleBack.clearcoatThickness";
connectAttr "volumeNoise_Thickness.oa" "remapValue14.i";
connectAttr "place2dTexture13.ou" "ramp_dot_remap.u";
connectAttr "volumeNoise_Dots.oa" "ramp_dot_remap.v";
connectAttr "place2dTexture13.ofs" "ramp_dot_remap.fs";
connectAttr "place3dTexture11.wim" "volumeNoise_Dots.pm";
connectAttr "volumeNoise_Dots.oa" "remapValue13.i";
connectAttr "remapValue_BumpDots.ov" "PxrBumpDots.inputBump";
connectAttr "place3dTexture11.wim" "volumeNoise_Shell.pm";
connectAttr "volumeNoise_Shell.oa" "remapValue_Spec1.i";
connectAttr "volumeNoise_Shell.oa" "remapValue12.i";
connectAttr "volumeNoise_Dots.oa" "remapValue_BumpDots.i";
connectAttr "ramp_dot_remap.oc" "PxrThinFilm1.inputRGB";
connectAttr "remapValue13.ov" "PxrThinFilm1.eta";
connectAttr "remapValue16.ov" "PxrThinFilm1.thicknessScale";
connectAttr "place3dTexture11.wim" "volumeNoise_Thickness.pm";
connectAttr "volumeNoise_Dots.oa" "blendColors_Spec1.b";
connectAttr "remapValue_Spec1.oc" "blendColors_Spec1.c2";
connectAttr "blendColors_Spec1.opr" "remapValue_Spec_Roughness.i";
connectAttr "blendColors_Spec1.opr" "PxrBump_Spec1.inputBump";
connectAttr "volumeNoise_Thickness.oa" "remapValue16.i";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "LM_BeetleBack1.msg" "materialInfo672.sg";
connectAttr "LM_BeetleBack.msg" "materialInfo672.m";
connectAttr "LM_BeetleBack.msg" "materialInfo672.t" -na;
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "LM_BeetleBack1.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "LM_BeetleBack1.message" ":defaultLightSet.message";
connectAttr "LM_BeetleBack1.pa" ":renderPartition.st" -na;
connectAttr "LM_BeetleBack.msg" ":defaultShaderList1.s" -na;
connectAttr "PxrThinFilm1.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoise_Dots.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBumpDots.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp_dot_remap.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBump_Spec1.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoise_Shell.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoise_Thickness.msg" ":defaultTextureList1.tx" -na;
connectAttr "remapValue_BumpDots.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture13.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture11.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "blendColors_Spec1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_Spec1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_Spec_Roughness.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue12.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue13.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue14.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue16.msg" ":defaultRenderUtilityList1.u" -na;
// End of BeetleBack.ma
