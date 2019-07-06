//Maya ASCII 2014 scene
//Name: LunaLook.ma
//Last modified: Mon, Mar 09, 2015 11:32:17 AM
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
fileInfo "osv" "Mac OS X 10.9.5";
createNode place3dTexture -n "place3dTexture10";
createNode ramp -n "ramp11";
	setAttr ".in" 6;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.2475971 0.25979775 0.27450982 ;
createNode ramp -n "ramp12";
	setAttr ".in" 3;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 1;
	setAttr ".cel[0].ec" -type "float3" 0.81342793 0.81342793 0.81342793 ;
	setAttr ".cel[1].ep" 0.079999998211860657;
	setAttr ".cel[1].ec" -type "float3" 0 0 0 ;
createNode remapValue -n "remapValue3";
	setAttr -s 2 ".vl[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBlend -n "PxrBlend_CreatorCombo";
	setAttr ".operation" 12;
createNode PxrBump -n "PxrBumpDiffuse";
	setAttr ".scale" 0.20000000298023224;
createNode ramp -n "rampSpecColor";
	setAttr ".in" 3;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.62687111 0.62687111 0.62687111 ;
	setAttr ".cel[1].ep" 0.28999999165534973;
	setAttr ".cel[1].ec" -type "float3" 0.20395 0.20395 0.222496 ;
	setAttr ".cel[2].ep" 0.9649999737739563;
	setAttr ".cel[2].ec" -type "float3" 0.06491188 0.06491188 0.089555196 ;
createNode remapValue -n "remapDiffuseRoughness";
	setAttr -s 2 ".vl[0:1]"  0 0 2 1 0.94 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrLMPlastic -n "LM_LunaLook";
	setAttr ".sheen" -type "float3" 2 2 2 ;
	setAttr ".specularRoughness" 0.29577463865280151;
createNode remapValue -n "remapValue_rimoutside";
	setAttr -s 4 ".vl[2:5]"  1 0 2 0 0 1 0.18260869 1 2 0.09565217
		 0.5 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 2;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBlend -n "PxrBlendDiffuseColor";
	setAttr ".operation" 12;
createNode remapValue -n "remapValue_rim_inside3";
	setAttr ".omx" 0.15000000596046448;
	setAttr -s 4 ".vl[0:3]"  0 0 1 1 0 1 0.77391303 0.69999999 
		2 0.30434781 0.18000001 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBlend -n "PxrBlend3";
	setAttr ".operation" 12;
createNode remapValue -n "remapValue_rimoutside1";
	setAttr ".omx" 0.80000001192092896;
	setAttr -s 4 ".vl[2:5]"  1 0 2 0 0 1 0.18260869 1 2 0.09565217
		 0.5 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 2;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode volumeNoise -n "volumeNoiseCraterMaker1";
	setAttr ".dm" 5;
	setAttr ".fq" 1;
	setAttr ".d" 4;
	setAttr ".sp" 1;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode volumeNoise -n "volumeNoiseCraterMaker3";
	setAttr ".dm" 2;
	setAttr ".fq" 12;
	setAttr ".d" 7;
	setAttr ".sp" 1;
	setAttr ".sr" 0.44915252923965454;
	setAttr ".rn" 0.76271188259124756;
	setAttr ".fof" 0;
createNode volumeNoise -n "volumeNoiseCraterMaker2";
	setAttr ".dm" 2;
	setAttr ".d" 4;
	setAttr ".sp" 0.32203391194343567;
	setAttr ".sr" 0.34745761752128601;
	setAttr ".fof" 1;
createNode PxrBlend -n "PxrBlend_Crater3";
	setAttr ".operation" 12;
createNode PxrBump -n "PxrBumpSpec";
	setAttr ".scale" 0.029999999329447746;
createNode volumeNoise -n "volumeNoise_fine_noise";
	setAttr ".a" 0.83050847053527832;
	setAttr ".ra" 0.59322035312652588;
	setAttr ".dm" 4;
	setAttr ".fq" 4;
	setAttr ".fr" 4;
	setAttr ".ti" 5;
	setAttr ".nty" 0;
createNode remapValue -n "remapValue9";
	setAttr -s 2 ".vl[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBlend -n "PxrBlend_Crater";
	setAttr ".operation" 17;
	setAttr ".bottomRGB" -type "float3" 0.95255399 0.95255399 0.95255399 ;
	setAttr ".bottomA" 0.54210561513900757;
createNode remapValue -n "remapValue8";
	setAttr -s 2 ".vl[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode volumeNoise -n "volumeNoiseCraterMaker";
	setAttr ".ag" 2;
	setAttr ".dm" 4;
	setAttr ".fq" 0.5;
	setAttr ".d" 2;
	setAttr ".sp" 1;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode PxrBlend -n "PxrBlend_Crater1";
	setAttr ".operation" 17;
createNode remapValue -n "remapValue_rimoutside3";
	setAttr ".omx" 0.15000000596046448;
	setAttr -s 4 ".vl[2:5]"  1 0 2 0 0 1 0.40869564 0.75999999 
		2 0.11304348 0.28 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 2;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "remapValue_rim_inside2";
	setAttr ".omx" 0.30000001192092896;
	setAttr -s 3 ".vl[0:2]"  0 0.2 2 1 0 1 0.48695651 0.62 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBlend -n "PxrBlend_Crater2";
	setAttr ".operation" 12;
createNode remapValue -n "remapValue_rim_inside1";
	setAttr ".omx" 0.80000001192092896;
	setAttr -s 4 ".vl[0:3]"  0 0 1 1 0 1 0.9130435 0.74000001 2
		 0.78260869 0.079999998 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "remapValue10";
	setAttr -s 2 ".vl[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBlend -n "PxrBlend2";
	setAttr ".operation" 12;
createNode remapValue -n "remapValue_rimoutside2";
	setAttr ".omx" 0.30000001192092896;
	setAttr -s 2 ".vl[2:3]"  1 0.18000001 2 0.17391305 1 2;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 2;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
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
	setAttr -s 2 ".st";
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
	setAttr -s 3 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 18 ".tx";
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
	setAttr -s 15 ".u";
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
connectAttr "volumeNoiseCraterMaker.oa" "ramp11.v";
connectAttr "volumeNoise_fine_noise.oc" "ramp11.cel[0].ec";
connectAttr "PxrBlend_CreatorCombo.resultR" "ramp12.v";
connectAttr "PxrBlend_CreatorCombo.resultR" "remapValue3.i";
connectAttr "PxrBlend2.resultRGB" "PxrBlend_CreatorCombo.topRGB";
connectAttr "PxrBlend3.resultRGB" "PxrBlend_CreatorCombo.bottomRGB";
connectAttr "remapValue3.ov" "PxrBumpDiffuse.inputBump";
connectAttr "PxrBlend_CreatorCombo.resultR" "rampSpecColor.v";
connectAttr "volumeNoise_fine_noise.oa" "remapDiffuseRoughness.i";
connectAttr "remapDiffuseRoughness.ov" "LM_LunaLook.diffuseRoughness";
connectAttr "PxrBumpDiffuse.resultN" "LM_LunaLook.diffuseNn";
connectAttr "PxrBumpSpec.resultN" "LM_LunaLook.specularNn";
connectAttr "rampSpecColor.oc" "LM_LunaLook.specularColor";
connectAttr "PxrBlendDiffuseColor.resultRGB" "LM_LunaLook.diffuseColor";
connectAttr "volumeNoiseCraterMaker.oa" "remapValue_rimoutside.i";
connectAttr "ramp11.oc" "PxrBlendDiffuseColor.topRGB";
connectAttr "ramp12.oc" "PxrBlendDiffuseColor.bottomRGB";
connectAttr "remapValue10.ov" "remapValue_rim_inside3.i";
connectAttr "PxrBlend_Crater2.resultRGB" "PxrBlend3.topRGB";
connectAttr "PxrBlend_Crater3.resultRGB" "PxrBlend3.bottomRGB";
connectAttr "volumeNoiseCraterMaker1.oa" "remapValue_rimoutside1.i";
connectAttr "place3dTexture10.wim" "volumeNoiseCraterMaker1.pm";
connectAttr "place3dTexture10.wim" "volumeNoiseCraterMaker3.pm";
connectAttr "place3dTexture10.wim" "volumeNoiseCraterMaker2.pm";
connectAttr "volumeNoise_fine_noise.oa" "PxrBlend_Crater3.topA";
connectAttr "volumeNoise_fine_noise.oa" "PxrBlend_Crater3.bottomA";
connectAttr "remapValue_rimoutside3.oc" "PxrBlend_Crater3.topRGB";
connectAttr "remapValue_rim_inside3.oc" "PxrBlend_Crater3.bottomRGB";
connectAttr "volumeNoise_fine_noise.oa" "PxrBumpSpec.inputBump";
connectAttr "place3dTexture10.wim" "volumeNoise_fine_noise.pm";
connectAttr "volumeNoiseCraterMaker2.oa" "remapValue9.i";
connectAttr "volumeNoiseCraterMaker.oa" "PxrBlend_Crater.topA";
connectAttr "remapValue_rimoutside.oc" "PxrBlend_Crater.topRGB";
connectAttr "volumeNoiseCraterMaker1.oa" "remapValue8.i";
connectAttr "place3dTexture10.wim" "volumeNoiseCraterMaker.pm";
connectAttr "volumeNoiseCraterMaker1.oa" "PxrBlend_Crater1.topA";
connectAttr "remapValue_rim_inside1.ov" "PxrBlend_Crater1.bottomA";
connectAttr "remapValue_rimoutside1.oc" "PxrBlend_Crater1.topRGB";
connectAttr "remapValue_rim_inside1.oc" "PxrBlend_Crater1.bottomRGB";
connectAttr "volumeNoiseCraterMaker3.oa" "remapValue_rimoutside3.i";
connectAttr "remapValue9.ov" "remapValue_rim_inside2.i";
connectAttr "volumeNoise_fine_noise.oa" "PxrBlend_Crater2.topA";
connectAttr "volumeNoise_fine_noise.oa" "PxrBlend_Crater2.bottomA";
connectAttr "remapValue_rimoutside2.oc" "PxrBlend_Crater2.topRGB";
connectAttr "remapValue_rim_inside2.oc" "PxrBlend_Crater2.bottomRGB";
connectAttr "remapValue8.ov" "remapValue_rim_inside1.i";
connectAttr "volumeNoiseCraterMaker3.oa" "remapValue10.i";
connectAttr "PxrBlend_Crater.resultRGB" "PxrBlend2.topRGB";
connectAttr "PxrBlend_Crater1.resultRGB" "PxrBlend2.bottomRGB";
connectAttr "volumeNoiseCraterMaker2.oa" "remapValue_rimoutside2.i";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "LM_LunaLook.msg" ":defaultShaderList1.s" -na;
connectAttr "PxrBumpDiffuse.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoise_fine_noise.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoiseCraterMaker.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend_Crater.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend_Crater1.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoiseCraterMaker1.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend_Crater2.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoiseCraterMaker2.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend_Crater3.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoiseCraterMaker3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend_CreatorCombo.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend2.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBumpSpec.msg" ":defaultTextureList1.tx" -na;
connectAttr "rampSpecColor.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlendDiffuseColor.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp11.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp12.msg" ":defaultTextureList1.tx" -na;
connectAttr "remapDiffuseRoughness.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rimoutside.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rim_inside1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue8.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rimoutside1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rim_inside2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue9.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rimoutside2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture10.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rim_inside3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue10.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue_rimoutside3.msg" ":defaultRenderUtilityList1.u" -na;
// End of LunaLook.ma
