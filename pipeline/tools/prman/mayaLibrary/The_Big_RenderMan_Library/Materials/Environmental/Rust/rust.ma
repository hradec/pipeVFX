//Maya ASCII 2014 scene
//Name: rust.ma
//Last modified: Sat, Mar 14, 2015 09:14:51 PM
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
createNode place3dTexture -n "rusty_metal_shader01:place3dTexture02";
	setAttr ".ove" yes;
	setAttr ".s" -type "double3" 0.6 0.6 0.6 ;
createNode place3dTexture -n "rusty_metal_shader01:place3dTexture01";
	setAttr ".ove" yes;
	setAttr ".s" -type "double3" 0.6 0.6 0.6 ;
createNode place3dTexture -n "rusty_metal_shader01:place3dTexture04";
	setAttr ".ove" yes;
	setAttr ".s" -type "double3" 0.6 0.6 0.6 ;
createNode place3dTexture -n "rusty_metal_shader01:place3dTexture03";
	setAttr ".ove" yes;
	setAttr ".s" -type "double3" 0.6 0.6 0.6 ;
createNode place3dTexture -n "place3dTexture5";
	setAttr ".s" -type "double3" 0.5 0.5 0.5 ;
createNode place3dTexture -n "place3dTexture6";
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture28";
	setAttr ".s" -type "double3" 20 0.1 1 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture29";
	setAttr ".r" -type "double3" 0 45 0 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture30";
	setAttr ".t" -type "double3" -2 0 0 ;
	setAttr ".r" -type "double3" 22.5 180 14 ;
	setAttr ".s" -type "double3" 20 10 0.1 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture33";
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture34";
	setAttr ".s" -type "double3" 2 2 2 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture35";
	setAttr ".t" -type "double3" -2 2 2 ;
	setAttr ".r" -type "double3" 22.5 250.00000000000003 14 ;
	setAttr ".s" -type "double3" 20 10 0.1 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture36";
	setAttr ".t" -type "double3" -2 2 2 ;
	setAttr ".r" -type "double3" 90 10 45 ;
	setAttr ".s" -type "double3" 20 10 0.1 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture37";
	setAttr ".t" -type "double3" -2 2 2 ;
	setAttr ".r" -type "double3" 5 45 90 ;
	setAttr ".s" -type "double3" 20 10 0.02 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture38";
	setAttr ".t" -type "double3" -20 0 20 ;
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture39";
createNode place3dTexture -n "Metal_Ferrous_Scratched:place3dTexture40";
	setAttr ".t" -type "double3" 1 1 1 ;
createNode PxrLMMetal -n "Metal_Ferrous_Scratched:PxrLMMetalScratchedrust";
	setAttr ".eta" -type "float3" 1.6574579 0.88036698 0.52122903 ;
	setAttr ".kappa" -type "float3" 9.2238741 6.2695212 4.8370152 ;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sd" -type "string" "#\n# generated by slim for Harsh at Sat Mar 14 5:32:41 PM China Standard Time 2015\n#\nslim 2 TOR slim {\n}\n";
	setAttr ".sr" -type "string" "";
createNode blendColors -n "Metal_Ferrous_Scratched:blendColors4";
	setAttr ".c1" -type "float3" 1 1 1 ;
createNode PxrGamma -n "Metal_Ferrous_Scratched:PxrGamma9";
	setAttr ".gamma" 2.2000000476837158;
createNode blendColors -n "Metal_Ferrous_Scratched:blendColors7";
createNode volumeNoise -n "Metal_Ferrous_Scratched:volumeNoise7";
	setAttr ".ail" yes;
	setAttr ".ao" -0.5;
	setAttr ".ra" 0.86259543895721436;
	setAttr ".d" 0.022900763899087906;
	setAttr ".sp" 1;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode stucco -n "Metal_Ferrous_Scratched:stucco5";
createNode stucco -n "Metal_Ferrous_Scratched:stucco7";
	setAttr ".sh" 7.5187969207763672;
createNode volumeNoise -n "Metal_Ferrous_Scratched:volumeNoise5";
	setAttr ".ail" yes;
	setAttr ".ao" -0.5;
	setAttr ".ra" 0.74045801162719727;
	setAttr ".d" 0.053435113281011581;
	setAttr ".sp" 0.98473280668258667;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode volumeNoise -n "Metal_Ferrous_Scratched:volumeNoise6";
	setAttr ".ail" yes;
	setAttr ".ao" -0.5;
	setAttr ".ra" 0.86259543895721436;
	setAttr ".d" 0.022900763899087906;
	setAttr ".sp" 1;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode stucco -n "Metal_Ferrous_Scratched:stucco6";
createNode volumeNoise -n "Metal_Ferrous_Scratched:volumeNoise3";
	setAttr ".ail" yes;
	setAttr ".ao" -0.5;
	setAttr ".ra" 0.74045801162719727;
	setAttr ".d" 0.053435113281011581;
	setAttr ".sp" 0.98473280668258667;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode unitConversion -n "Metal_Ferrous_Scratched:unitConversion1";
	setAttr ".cf" 0.017453292519943295;
createNode solidFractal -n "Metal_Ferrous_Scratched:solidFractal3";
	setAttr ".ail" yes;
	setAttr ".cg" -type "float3" 22.5 45 14 ;
	setAttr ".dc" -type "float3" 0.51908141 0.51908141 0.51908141 ;
	setAttr ".a" 46;
	setAttr ".th" 46;
createNode brownian -n "Metal_Ferrous_Scratched:brownian4";
	setAttr ".ail" yes;
	setAttr ".cg" -type "float3" 45 180 50 ;
	setAttr ".ag" 45;
	setAttr ".l" 4.4586467742919922;
	setAttr ".ic" 0.15037594735622406;
	setAttr ".oct" 1.6917293071746826;
createNode unitConversion -n "Metal_Ferrous_Scratched:unitConversion2";
	setAttr ".cf" 0.017453292519943295;
createNode unitConversion -n "Metal_Ferrous_Scratched:unitConversion3";
	setAttr ".cf" 0.017453292519943295;
createNode volumeNoise -n "Metal_Ferrous_Scratched:volumeNoise4";
	setAttr ".ail" yes;
	setAttr ".ao" -0.5;
	setAttr ".ra" 0.74045801162719727;
	setAttr ".d" 0.053435113281011581;
	setAttr ".sp" 0.98473280668258667;
	setAttr ".sr" 1;
	setAttr ".fof" 0;
createNode stucco -n "Metal_Ferrous_Scratched:stucco8";
	setAttr ".c2" -type "float3" 0.36841384 0.36841384 0.36841384 ;
createNode cloud -n "Metal_Ferrous_Scratched:cloud6";
	setAttr ".ail" yes;
	setAttr ".cg" -type "float3" 0.5114519 0.5114519 0.5114519 ;
	setAttr ".co" -type "float3" 0.41985199 0.41985199 0.41985199 ;
	setAttr ".dc" -type "float3" 0.49617761 0.49617761 0.49617761 ;
	setAttr ".c1" -type "float3" 0.1804532 0.1804532 0.1804532 ;
	setAttr ".c" 0.50381678342819214;
	setAttr ".ct" 0.038167938590049744;
	setAttr ".et" 1.1145038604736328;
	setAttr ".a" 3.4351143836975098;
	setAttr ".ra" 0.45801526308059692;
createNode blendColors -n "Metal_Ferrous_Scratched:blendColors9";
	setAttr ".c1" -type "float3" 1 1 1 ;
createNode blendColors -n "Metal_Ferrous_Scratched:blendColors8";
createNode blendColors -n "Metal_Ferrous_Scratched:blendColors5";
	setAttr ".c1" -type "float3" 0.12030213 0.12030213 0.12030213 ;
	setAttr ".c2" -type "float3" 0.63999999 0.63999999 0.63999999 ;
createNode PxrRemap -n "Metal_Ferrous_Scratched:PxrRemap9";
	setAttr ".outputMin" 0.5;
	setAttr ".outputMax" 0.80000001192092896;
createNode volumeNoise -n "Metal_Ferrous_Scratched:volumeNoise8";
	setAttr ".a" 0.21374045312404633;
	setAttr ".ra" 0.6106870174407959;
	setAttr ".dm" 2;
	setAttr ".fq" 9.9236640930175781;
	setAttr ".fr" 1.4809160232543945;
	setAttr ".d" 0.099236644804477692;
	setAttr ".sp" 1;
	setAttr ".sr" 1;
	setAttr ".fof" 3;
	setAttr ".imp" -0.2671755850315094;
createNode unitConversion -n "Metal_Ferrous_Scratched:unitConversion4";
	setAttr ".cf" 0.017453292519943295;
createNode PxrBump -n "Metal_Ferrous_Scratched:PxrBump8";
	setAttr ".scale" 0.004999999888241291;
createNode PxrLMLayer -n "PxrLMLayer7";
	setAttr ".diffuseRoughness" 0.56179773807525635;
	setAttr ".specularColor" -type "float3" 0.85392541 0.85392541 0.85392541 ;
createNode PxrToFloat -n "PxrToFloat4";
createNode PxrInvert -n "PxrInvert1";
createNode PxrBlend -n "PxrBlend4";
	setAttr ".operation" 23;
createNode clamp -n "rusty_metal_shader01:noise_amplitude_clamp";
	setAttr ".mx" -type "float3" 1 1 1 ;
createNode volumeNoise -n "rusty_metal_shader01:mask_out_rust_noise";
	setAttr ".f" 0.10000000149011612;
	setAttr ".ail" yes;
	setAttr ".co" -type "float3" 0.00019999999 0.00019999999 0.00019999999 ;
	setAttr ".a" 30;
	setAttr ".ra" 0.5;
	setAttr ".th" 0.49618321657180786;
	setAttr ".dm" 8;
	setAttr ".fq" 0.40000000596046448;
	setAttr ".fr" 4;
	setAttr ".ti" 20;
	setAttr ".nty" 0;
createNode granite -n "rusty_metal_shader01:bump_dots";
	setAttr ".i" yes;
	setAttr ".ail" yes;
	setAttr ".c2" -type "float3" 1 1 1 ;
	setAttr ".c3" -type "float3" 1 1 1 ;
	setAttr ".fc" -type "float3" 1 1 1 ;
	setAttr ".cs" 0.5;
	setAttr ".dy" 0.10000000149011612;
	setAttr ".mr" 1;
	setAttr ".s" 1;
	setAttr ".th" 1;
	setAttr ".c" no;
createNode fractal -n "rusty_metal_shader01:fractal_for_dots";
	setAttr ".a" 0.1550000011920929;
	setAttr ".ra" 1;
	setAttr ".th" 0.37000000476837158;
	setAttr ".bs" 0.38844001293182373;
	setAttr ".in" yes;
createNode place2dTexture -n "rusty_metal_shader01:place2dTexture05";
createNode PxrBlend -n "PxrBlend3";
	setAttr ".operation" 23;
createNode PxrBlend -n "PxrBlend2";
	setAttr ".topRGB" -type "float3" 1 1 1 ;
createNode solidFractal -n "rusty_metal_shader01:rust_color_SolidFractal_texture";
	setAttr ".co" -type "float3" 0.022478081 0.039854851 0.08264 ;
	setAttr ".dc" -type "float3" 0.5413596 0.5413596 0.5413596 ;
	setAttr ".a" 0.71428573131561279;
	setAttr ".ra" 1;
	setAttr ".th" 0.1428571492433548;
	setAttr ".d" -type "float2" 4 8 ;
	setAttr ".fr" 4.5187969207763672;
createNode stucco -n "stucco3";
	setAttr ".sh" 28.872180938720703;
	setAttr ".c1" -type "float3" 0.58646524 0.30261692 0.11854734 ;
	setAttr ".c2" -type "float3" 0.72179753 0.43265432 0.16145571 ;
createNode PxrToFloat -n "PxrToFloat3";
	setAttr ".mode" 3;
createNode PxrBump -n "PxrBump6";
	setAttr ".scale" 0.059999998658895493;
createNode PxrToFloat -n "PxrToFloat6";
	setAttr ".mode" 3;
createNode PxrBlend -n "PxrBlend6";
	setAttr ".operation" 17;
	setAttr ".bottomRGB" -type "float3" 0.28090334 0.28090334 0.28090334 ;
createNode PxrBlend -n "PxrBlend5";
	setAttr ".operation" 23;
	setAttr ".topA" 0.70786517858505249;
createNode solidFractal -n "rusty_metal_shader01:reflection_blur_SolidFractal_texture";
	setAttr ".ail" yes;
	setAttr ".cg" -type "float3" 0.80451667 0.80451667 0.80451667 ;
	setAttr ".ag" 0.60150372982025146;
	setAttr ".a" 0.69999998807907104;
	setAttr ".ra" 0.69999998807907104;
	setAttr ".th" 0.10000000149011612;
	setAttr ".r" -type "float3" 2 2 2 ;
	setAttr ".d" -type "float2" 5 8 ;
createNode cloud -n "cloud1";
	setAttr ".c" 0.58646619319915771;
	setAttr ".tr" 0.58646619319915771;
	setAttr ".ct" 0.11278195679187775;
	setAttr ".et" 1.1879699230194092;
createNode noise -n "noise1";
	setAttr ".a" 0.70085471868515015;
	setAttr ".th" 0.1111111119389534;
	setAttr ".dm" 4;
	setAttr ".fq" 88.034187316894531;
	setAttr ".fr" 2.384615421295166;
	setAttr ".sp" 0.95726495981216431;
	setAttr ".sr" 0.97435897588729858;
	setAttr ".fof" 3;
createNode place2dTexture -n "place2dTexture8";
createNode PxrToFloat -n "PxrToFloat7";
	setAttr ".mode" 3;
createNode PxrRemap -n "PxrRemap3";
	setAttr ".bias" -type "float3" 0.62922102 0.62922102 0.62922102 ;
	setAttr ".gain" -type "float3" 0.25842679 0.25842679 0.25842679 ;
	setAttr ".outputMin" 0.20000000298023224;
	setAttr ".outputMax" 0.80000001192092896;
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
	setAttr -s 41 ".st";
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
	setAttr -s 12 ".gn";
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
	setAttr -s 32 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 124 ".tx";
select -ne :lightList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".l";
select -ne :lambert1;
	setAttr ".miic" -type "float3" 3.1415927 3.1415927 3.1415927 ;
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
	setAttr -s 69 ".u";
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
	setAttr ".w" 720;
	setAttr ".h" 720;
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
connectAttr "Metal_Ferrous_Scratched:unitConversion1.o" "Metal_Ferrous_Scratched:place3dTexture28.rx"
		;
connectAttr "Metal_Ferrous_Scratched:unitConversion2.o" "Metal_Ferrous_Scratched:place3dTexture28.ry"
		;
connectAttr "Metal_Ferrous_Scratched:unitConversion3.o" "Metal_Ferrous_Scratched:place3dTexture28.rz"
		;
connectAttr "Metal_Ferrous_Scratched:unitConversion4.o" "Metal_Ferrous_Scratched:place3dTexture40.r"
		;
connectAttr "Metal_Ferrous_Scratched:blendColors4.op" "Metal_Ferrous_Scratched:PxrLMMetalScratchedrust.specularColor"
		;
connectAttr "Metal_Ferrous_Scratched:blendColors9.opr" "Metal_Ferrous_Scratched:PxrLMMetalScratchedrust.roughness"
		;
connectAttr "Metal_Ferrous_Scratched:PxrBump8.resultN" "Metal_Ferrous_Scratched:PxrLMMetalScratchedrust.bumpNormal"
		;
connectAttr "PxrLMLayer7.result" "Metal_Ferrous_Scratched:PxrLMMetalScratchedrust.lmlayer"
		;
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "Metal_Ferrous_Scratched:PxrGamma9.resultR" "Metal_Ferrous_Scratched:blendColors4.b"
		;
connectAttr "Metal_Ferrous_Scratched:stucco8.oc" "Metal_Ferrous_Scratched:blendColors4.c2"
		;
connectAttr "Metal_Ferrous_Scratched:blendColors7.op" "Metal_Ferrous_Scratched:PxrGamma9.inputRGB"
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise7.oc" "Metal_Ferrous_Scratched:blendColors7.c1"
		;
connectAttr "Metal_Ferrous_Scratched:stucco5.oc" "Metal_Ferrous_Scratched:blendColors7.c2"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture37.wim" "Metal_Ferrous_Scratched:volumeNoise7.pm"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture34.wim" "Metal_Ferrous_Scratched:stucco5.pm"
		;
connectAttr "Metal_Ferrous_Scratched:stucco7.oc" "Metal_Ferrous_Scratched:stucco5.c1"
		;
connectAttr "Metal_Ferrous_Scratched:stucco6.oc" "Metal_Ferrous_Scratched:stucco5.c2"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture33.wim" "Metal_Ferrous_Scratched:stucco7.pm"
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise5.oc" "Metal_Ferrous_Scratched:stucco7.c1"
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise6.oc" "Metal_Ferrous_Scratched:stucco7.c2"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture35.wim" "Metal_Ferrous_Scratched:volumeNoise5.pm"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture36.wim" "Metal_Ferrous_Scratched:volumeNoise6.pm"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture33.wim" "Metal_Ferrous_Scratched:stucco6.pm"
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise3.oc" "Metal_Ferrous_Scratched:stucco6.c1"
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise4.oc" "Metal_Ferrous_Scratched:stucco6.c2"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture28.wim" "Metal_Ferrous_Scratched:volumeNoise3.pm"
		;
connectAttr "Metal_Ferrous_Scratched:solidFractal3.ocr" "Metal_Ferrous_Scratched:unitConversion1.i"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture29.wim" "Metal_Ferrous_Scratched:solidFractal3.pm"
		;
connectAttr "Metal_Ferrous_Scratched:brownian4.oa" "Metal_Ferrous_Scratched:solidFractal3.cgr"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture29.wim" "Metal_Ferrous_Scratched:brownian4.pm"
		;
connectAttr "Metal_Ferrous_Scratched:solidFractal3.ocg" "Metal_Ferrous_Scratched:unitConversion2.i"
		;
connectAttr "Metal_Ferrous_Scratched:solidFractal3.ocb" "Metal_Ferrous_Scratched:unitConversion3.i"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture30.wim" "Metal_Ferrous_Scratched:volumeNoise4.pm"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture39.wim" "Metal_Ferrous_Scratched:stucco8.pm"
		;
connectAttr "Metal_Ferrous_Scratched:cloud6.oc" "Metal_Ferrous_Scratched:stucco8.c1"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture38.wim" "Metal_Ferrous_Scratched:cloud6.pm"
		;
connectAttr "Metal_Ferrous_Scratched:blendColors8.op" "Metal_Ferrous_Scratched:blendColors9.c2"
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise8.oa" "Metal_Ferrous_Scratched:blendColors9.b"
		;
connectAttr "Metal_Ferrous_Scratched:blendColors5.op" "Metal_Ferrous_Scratched:blendColors8.c1"
		;
connectAttr "Metal_Ferrous_Scratched:PxrRemap9.resultRGB" "Metal_Ferrous_Scratched:blendColors8.c2"
		;
connectAttr "Metal_Ferrous_Scratched:PxrGamma9.resultR" "Metal_Ferrous_Scratched:blendColors5.b"
		;
connectAttr "Metal_Ferrous_Scratched:stucco8.oc" "Metal_Ferrous_Scratched:PxrRemap9.inputRGB"
		;
connectAttr "Metal_Ferrous_Scratched:place3dTexture40.wim" "Metal_Ferrous_Scratched:volumeNoise8.pm"
		;
connectAttr "Metal_Ferrous_Scratched:stucco8.oc" "Metal_Ferrous_Scratched:unitConversion4.i"
		;
connectAttr "Metal_Ferrous_Scratched:blendColors5.opr" "Metal_Ferrous_Scratched:PxrBump8.inputBump"
		;
connectAttr "PxrToFloat4.resultF" "PxrLMLayer7.layerMask";
connectAttr "PxrBlend3.resultRGB" "PxrLMLayer7.diffuseColor";
connectAttr "PxrBump6.resultN" "PxrLMLayer7.diffuseNn";
connectAttr "PxrBump6.resultN" "PxrLMLayer7.specularNn";
connectAttr "PxrToFloat7.resultF" "PxrLMLayer7.specularRoughness";
connectAttr "PxrInvert1.resultRGB" "PxrToFloat4.input";
connectAttr "PxrBlend4.resultRGB" "PxrInvert1.inputRGB";
connectAttr "rusty_metal_shader01:noise_amplitude_clamp.op" "PxrBlend4.topRGB";
connectAttr "rusty_metal_shader01:bump_dots.oc" "PxrBlend4.bottomRGB";
connectAttr "rusty_metal_shader01:mask_out_rust_noise.oc" "rusty_metal_shader01:noise_amplitude_clamp.ip"
		;
connectAttr "rusty_metal_shader01:place3dTexture03.wim" "rusty_metal_shader01:mask_out_rust_noise.pm"
		;
connectAttr "rusty_metal_shader01:place3dTexture04.wim" "rusty_metal_shader01:bump_dots.pm"
		;
connectAttr "rusty_metal_shader01:fractal_for_dots.oc" "rusty_metal_shader01:bump_dots.c1"
		;
connectAttr "rusty_metal_shader01:place2dTexture05.o" "rusty_metal_shader01:fractal_for_dots.uv"
		;
connectAttr "rusty_metal_shader01:place2dTexture05.ofs" "rusty_metal_shader01:fractal_for_dots.fs"
		;
connectAttr "PxrBlend2.resultRGB" "PxrBlend3.topRGB";
connectAttr "rusty_metal_shader01:bump_dots.oc" "PxrBlend3.bottomRGB";
connectAttr "rusty_metal_shader01:rust_color_SolidFractal_texture.oc" "PxrBlend2.bottomRGB"
		;
connectAttr "PxrToFloat3.resultF" "PxrBlend2.topA";
connectAttr "rusty_metal_shader01:place3dTexture02.wim" "rusty_metal_shader01:rust_color_SolidFractal_texture.pm"
		;
connectAttr "stucco3.oc" "rusty_metal_shader01:rust_color_SolidFractal_texture.cg"
		;
connectAttr "place3dTexture5.wim" "stucco3.pm";
connectAttr "rusty_metal_shader01:noise_amplitude_clamp.op" "PxrToFloat3.input";
connectAttr "PxrToFloat6.resultF" "PxrBump6.inputBump";
connectAttr "PxrBlend6.resultRGB" "PxrToFloat6.input";
connectAttr "PxrBlend5.resultRGB" "PxrBlend6.topRGB";
connectAttr "noise1.oa" "PxrBlend6.topA";
connectAttr "rusty_metal_shader01:reflection_blur_SolidFractal_texture.oc" "PxrBlend5.topRGB"
		;
connectAttr "cloud1.oc" "PxrBlend5.bottomRGB";
connectAttr "rusty_metal_shader01:place3dTexture01.wim" "rusty_metal_shader01:reflection_blur_SolidFractal_texture.pm"
		;
connectAttr "place3dTexture6.wim" "cloud1.pm";
connectAttr "place2dTexture8.o" "noise1.uv";
connectAttr "place2dTexture8.ofs" "noise1.fs";
connectAttr "PxrRemap3.resultRGB" "PxrToFloat7.input";
connectAttr "PxrBlend6.resultRGB" "PxrRemap3.inputRGB";
connectAttr "Metal_Ferrous_Scratched:PxrLMMetalScratchedrust.msg" ":defaultShaderList1.s"
		 -na;
connectAttr "rusty_metal_shader01:rust_color_SolidFractal_texture.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "rusty_metal_shader01:reflection_blur_SolidFractal_texture.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "rusty_metal_shader01:bump_dots.msg" ":defaultTextureList1.tx" -na;
connectAttr "rusty_metal_shader01:fractal_for_dots.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "rusty_metal_shader01:mask_out_rust_noise.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "PxrBlend2.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend4.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat4.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrInvert1.msg" ":defaultTextureList1.tx" -na;
connectAttr "stucco3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBump6.msg" ":defaultTextureList1.tx" -na;
connectAttr "cloud1.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend5.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat6.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrRemap3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrToFloat7.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBlend6.msg" ":defaultTextureList1.tx" -na;
connectAttr "Metal_Ferrous_Scratched:volumeNoise3.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Metal_Ferrous_Scratched:solidFractal3.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Metal_Ferrous_Scratched:brownian4.msg" ":defaultTextureList1.tx" -na
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise4.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Metal_Ferrous_Scratched:stucco5.msg" ":defaultTextureList1.tx" -na;
connectAttr "Metal_Ferrous_Scratched:stucco6.msg" ":defaultTextureList1.tx" -na;
connectAttr "Metal_Ferrous_Scratched:stucco7.msg" ":defaultTextureList1.tx" -na;
connectAttr "Metal_Ferrous_Scratched:volumeNoise5.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Metal_Ferrous_Scratched:volumeNoise6.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Metal_Ferrous_Scratched:volumeNoise7.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Metal_Ferrous_Scratched:PxrGamma9.msg" ":defaultTextureList1.tx" -na
		;
connectAttr "Metal_Ferrous_Scratched:PxrBump8.msg" ":defaultTextureList1.tx" -na
		;
connectAttr "Metal_Ferrous_Scratched:cloud6.msg" ":defaultTextureList1.tx" -na;
connectAttr "Metal_Ferrous_Scratched:stucco8.msg" ":defaultTextureList1.tx" -na;
connectAttr "Metal_Ferrous_Scratched:PxrRemap9.msg" ":defaultTextureList1.tx" -na
		;
connectAttr "Metal_Ferrous_Scratched:volumeNoise8.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "noise1.msg" ":defaultTextureList1.tx" -na;
connectAttr "rusty_metal_shader01:place3dTexture02.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "rusty_metal_shader01:place3dTexture01.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "rusty_metal_shader01:place3dTexture04.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "rusty_metal_shader01:place3dTexture03.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "rusty_metal_shader01:place2dTexture05.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "rusty_metal_shader01:noise_amplitude_clamp.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "place3dTexture5.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture6.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture28.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture29.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture30.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture33.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture34.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture35.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture36.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture37.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:blendColors4.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:blendColors5.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:blendColors7.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture38.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture39.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:blendColors8.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:place3dTexture40.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Metal_Ferrous_Scratched:blendColors9.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "place2dTexture8.msg" ":defaultRenderUtilityList1.u" -na;
// End of rust.ma
