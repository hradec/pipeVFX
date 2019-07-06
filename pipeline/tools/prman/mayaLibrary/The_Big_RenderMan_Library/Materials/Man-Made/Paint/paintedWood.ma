//Maya ASCII 2014 scene
//Name: paintWood.ma
//Last modified: Mon, Mar 16, 2015 01:08:23 AM
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
createNode place3dTexture -n "wood:place3dTexture42";
	setAttr ".r" -type "double3" 0 90 0 ;
createNode shadingEngine -n "wood:PxrLMPlasticWood1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode materialInfo -n "materialInfo66";
createNode PxrLMPlastic -n "wood:PxrLMPlasticWood1";
	setAttr ".clearcoatRoughness" 0.043370787054300308;
	setAttr ".clearcoatThickness" 0.28089886903762817;
	setAttr ".clearcoatNn" -type "float3" 1 1 1 ;
createNode wood -n "wood:wood2";
	setAttr ".ag" 0.69172930717468262;
	setAttr ".fc" -type "float3" 0.90399998 0.82904029 0.74127996 ;
	setAttr ".vc" -type "float3" 0.80900002 0.70091695 0.60432297 ;
	setAttr ".ls" 0.053383458405733109;
	setAttr ".a" 33.082706451416016;
	setAttr ".gc" -type "float3" 0.118 0.068704598 0.044367999 ;
	setAttr ".gx" 0.4285714328289032;
	setAttr ".gs" 0.017293233424425125;
createNode blendColors -n "wood:blendColors10";
createNode PxrRemap -n "wood:PxrRemap10";
	setAttr ".outputMax" 0.5;
createNode PxrVoronoise -n "wood:PxrVoronoise3";
	setAttr ".frequency" 2.8202247619628906;
	setAttr ".octaves" 2;
	setAttr ".gain" 2;
	setAttr ".jitter" 1;
	setAttr ".smoothness" 0;
createNode PxrBump -n "wood:PxrBump9";
	setAttr ".scale" 0.0040000001899898052;
createNode PxrToFloat -n "PxrToFloat5";
	setAttr ".mode" 3;
createNode PxrBlend -n "PxrBlend3";
	setAttr ".topA" 0.483146071434021;
createNode PxrBlend -n "PxrBlend2";
	setAttr ".topA" 0.30000001192092896;
createNode PxrWorley -n "PxrWorley1";
	setAttr ".jitter" 1;
	setAttr ".c1" 1;
	setAttr ".c2" -0.89999997615814209;
createNode PxrToFloat -n "PxrToFloat1";
createNode PxrRemap -n "PxrRemap3";
	setAttr ".outputMin" 0.34999999403953552;
	setAttr ".outputMax" 0.44999998807907104;
createNode PxrVoronoise -n "PxrVoronoise3";
	setAttr ".frequency" 5.2471909523010254;
	setAttr ".gain" 1.5507864952087402;
	setAttr ".jitter" 1;
	setAttr ".smoothness" 0.23595505952835083;
createNode PxrManifold2D -n "PxrManifold2D1";
	setAttr ".angle" 56.629215240478516;
	setAttr ".scaleS" 20;
	setAttr ".scaleT" 12;
	setAttr ".offsetS" 1.4606741666793823;
createNode PxrWorley -n "PxrWorley2";
	setAttr ".distancemetric" 1;
	setAttr ".jitter" 1;
	setAttr ".c1" 1;
	setAttr ".c2" -0.89999997615814209;
createNode PxrToFloat -n "PxrToFloat3";
createNode PxrRemap -n "PxrRemap6";
	setAttr ".outputMin" 0.34999999403953552;
	setAttr ".outputMax" 0.44999998807907104;
createNode PxrVoronoise -n "PxrVoronoise4";
	setAttr ".frequency" 6.865168571472168;
	setAttr ".gain" 1.2363370656967163;
	setAttr ".lacunarity" 2.2000000476837158;
	setAttr ".jitter" 1;
	setAttr ".smoothness" 0.23595505952835083;
createNode PxrManifold2D -n "PxrManifold2D2";
	setAttr ".angle" 52.584270477294922;
	setAttr ".scaleS" 50;
	setAttr ".scaleT" 50;
	setAttr ".offsetS" 1.4606741666793823;
createNode PxrLMLayer -n "PxrLMLayer1";
	setAttr ".diffuseRoughness" 0.60674154758453369;
	setAttr ".specularColor" -type "float3" 0.9101091 0.9101091 0.9101091 ;
	setAttr ".specularRoughness" 0.30000001192092896;
	setAttr ".clearcoatBehavior" yes;
	setAttr ".clearcoatColor" -type "float3" 0.93258566 0.93258566 0.93258566 ;
	setAttr ".clearcoatEta" 1.4900000095367432;
	setAttr ".clearcoatRoughness" 0.079999998211860657;
	setAttr ".clearcoatThickness" 0.20000000298023224;
createNode PxrRemap -n "PxrRemap5";
	setAttr ".bias" -type "float3" 0.078644998 0.078644998 0.078644998 ;
	setAttr ".gain" -type "float3" 0.067414358 0.067414358 0.067414358 ;
createNode PxrToFloat -n "PxrToFloat2";
	setAttr ".mode" 3;
createNode PxrRemap -n "PxrRemap4";
	setAttr ".bias" -type "float3" 1 1 1 ;
	setAttr ".gain" -type "float3" 1 1 1 ;
createNode PxrBlend -n "PxrBlend1";
	setAttr ".operation" 25;
	setAttr ".bottomRGB" -type "float3" 0.25850308 0.25850308 0.25850308 ;
	setAttr ".bottomA" 0.20000000298023224;
createNode PxrBlend -n "PxrBlend4";
	setAttr ".topRGB" -type "float3" 0.19894798 0.56199998 0.53752422 ;
	setAttr ".bottomRGB" -type "float3" 0.70005339 0.98876935 0.94010836 ;
createNode RMSDisplacement -n "RMSDisplacement1";
	setAttr ".sphere" 0.10000000149011612;
	setAttr ".displacementAmount" -0.079999998211860657;
	setAttr ".displacementCenter" 0;
createNode PxrToFloat -n "PxrToFloat4";
	setAttr ".mode" 3;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 26 ".lnk";
	setAttr -s 26 ".slnk";
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
	setAttr -s 26 ".st";
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
	setAttr -s 13 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 36 ".tx";
select -ne :lightList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".l";
select -ne :lambert1;
	setAttr ".miic" -type "float3" 9.8696051 9.8696051 9.8696051 ;
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
connectAttr "wood:PxrLMPlasticWood1.oc" "wood:PxrLMPlasticWood1SG.ss";
connectAttr "swatch_teapotShape.iog" "wood:PxrLMPlasticWood1SG.dsm" -na;
connectAttr "RMSDisplacement1.oc" "wood:PxrLMPlasticWood1SG.ds";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "wood:PxrLMPlasticWood1SG.msg" "materialInfo66.sg";
connectAttr "wood:PxrLMPlasticWood1.msg" "materialInfo66.m";
connectAttr "wood:PxrLMPlasticWood1.msg" "materialInfo66.t" -na;
connectAttr "wood:wood2.oc" "wood:PxrLMPlasticWood1.diffuseColor";
connectAttr "wood:blendColors10.opr" "wood:PxrLMPlasticWood1.specularRoughness";
connectAttr "wood:blendColors10.op" "wood:PxrLMPlasticWood1.specularColor";
connectAttr "wood:PxrVoronoise3.resultF" "wood:PxrLMPlasticWood1.specularColorr"
		;
connectAttr "wood:PxrVoronoise3.resultF" "wood:PxrLMPlasticWood1.specularColorg"
		;
connectAttr "wood:PxrVoronoise3.resultF" "wood:PxrLMPlasticWood1.specularColorb"
		;
connectAttr "wood:PxrBump9.resultN" "wood:PxrLMPlasticWood1.specularNn";
connectAttr "wood:PxrBump9.resultN" "wood:PxrLMPlasticWood1.diffuseNn";
connectAttr "PxrLMLayer1.result" "wood:PxrLMPlasticWood1.lmlayer";
connectAttr "wood:place3dTexture42.wim" "wood:wood2.pm";
connectAttr "wood:PxrRemap10.resultRGB" "wood:blendColors10.c1";
connectAttr "wood:wood2.oa" "wood:blendColors10.c2r";
connectAttr "wood:wood2.oa" "wood:blendColors10.c2g";
connectAttr "wood:wood2.oa" "wood:blendColors10.c2b";
connectAttr "wood:PxrVoronoise3.resultF" "wood:PxrRemap10.inputRGBr";
connectAttr "wood:PxrVoronoise3.resultF" "wood:PxrRemap10.inputRGBg";
connectAttr "wood:PxrVoronoise3.resultF" "wood:PxrRemap10.inputRGBb";
connectAttr "PxrToFloat5.resultF" "wood:PxrBump9.inputBump";
connectAttr "PxrBlend3.resultRGB" "PxrToFloat5.input";
connectAttr "wood:wood2.oa" "PxrBlend3.topRGBr";
connectAttr "wood:wood2.oa" "PxrBlend3.topRGBg";
connectAttr "wood:wood2.oa" "PxrBlend3.topRGBb";
connectAttr "PxrBlend2.resultRGB" "PxrBlend3.bottomRGB";
connectAttr "PxrWorley1.resultF" "PxrBlend2.bottomRGBr";
connectAttr "PxrWorley1.resultF" "PxrBlend2.bottomRGBg";
connectAttr "PxrWorley1.resultF" "PxrBlend2.bottomRGBb";
connectAttr "PxrWorley2.resultF" "PxrBlend2.topRGBr";
connectAttr "PxrWorley2.resultF" "PxrBlend2.topRGBg";
connectAttr "PxrWorley2.resultF" "PxrBlend2.topRGBb";
connectAttr "PxrToFloat1.resultF" "PxrWorley1.frequency";
connectAttr "PxrManifold2D1.result" "PxrWorley1.manifold";
connectAttr "PxrRemap3.resultRGB" "PxrToFloat1.input";
connectAttr "PxrVoronoise3.resultF" "PxrRemap3.inputRGBr";
connectAttr "PxrVoronoise3.resultF" "PxrRemap3.inputRGBg";
connectAttr "PxrVoronoise3.resultF" "PxrRemap3.inputRGBb";
connectAttr "PxrToFloat3.resultF" "PxrWorley2.frequency";
connectAttr "PxrManifold2D2.result" "PxrWorley2.manifold";
connectAttr "PxrRemap6.resultRGB" "PxrToFloat3.input";
connectAttr "PxrVoronoise4.resultF" "PxrRemap6.inputRGBr";
connectAttr "PxrVoronoise4.resultF" "PxrRemap6.inputRGBg";
connectAttr "PxrVoronoise4.resultF" "PxrRemap6.inputRGBb";
connectAttr "wood:PxrBump9.resultN" "PxrLMLayer1.diffuseNn";
connectAttr "wood:PxrBump9.resultN" "PxrLMLayer1.specularNn";
connectAttr "PxrRemap5.resultRGBr" "PxrLMLayer1.layerMask";
connectAttr "wood:PxrBump9.resultN" "PxrLMLayer1.clearcoatNn";
connectAttr "PxrBlend4.resultRGB" "PxrLMLayer1.diffuseColor";
connectAttr "PxrToFloat2.resultF" "PxrRemap5.inputRGBr";
connectAttr "PxrToFloat2.resultF" "PxrRemap5.inputRGBg";
connectAttr "PxrToFloat2.resultF" "PxrRemap5.inputRGBb";
connectAttr "PxrRemap4.resultRGB" "PxrToFloat2.input";
connectAttr "PxrBlend1.resultRGB" "PxrRemap4.inputRGB";
connectAttr "PxrWorley1.resultF" "PxrBlend1.topRGBr";
connectAttr "PxrWorley1.resultF" "PxrBlend1.topRGBg";
connectAttr "PxrWorley1.resultF" "PxrBlend1.topRGBb";
connectAttr "PxrToFloat5.resultF" "PxrBlend4.topA";
connectAttr "PxrToFloat4.resultF" "RMSDisplacement1.displacementScalar";
connectAttr "PxrBlend2.resultRGB" "PxrToFloat4.input";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "wood:PxrLMPlasticWood1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "wood:PxrLMPlasticWood1SG.message" ":defaultLightSet.message";
connectAttr "wood:PxrLMPlasticWood1SG.pa" ":renderPartition.st" -na;
connectAttr "wood:PxrLMPlasticWood1.msg" ":defaultShaderList1.s" -na;
connectAttr "RMSDisplacement1.msg" ":defaultShaderList1.s" -na;
connectAttr "PxrVoronoise3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrRemap3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat1.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrWorley1.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrRemap4.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat2.msg" ":defaultTextureList1.tx" -na;
connectAttr "wood:PxrRemap10.msg" ":defaultTextureList1.tx" -na;
connectAttr "wood:PxrBump9.msg" ":defaultTextureList1.tx" -na;
connectAttr "wood:wood2.msg" ":defaultTextureList1.tx" -na;
connectAttr "wood:PxrVoronoise3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend1.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrRemap5.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrWorley2.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrRemap6.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrVoronoise4.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend2.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat4.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat5.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend4.msg" ":defaultTextureList1.tx" -na;
connectAttr "wood:place3dTexture42.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "wood:blendColors10.msg" ":defaultRenderUtilityList1.u" -na;
// End of paintWood.ma
