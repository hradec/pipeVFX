//Maya ASCII 2014 scene
//Name: velvet.ma
//Last modified: Sun, Mar 15, 2015 03:32:09 PM
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
createNode place3dTexture -n "Harsh_20150315_1359:Harsh_20150315_1345:place3dTexture11";
createNode place3dTexture -n "Harsh_20150315_1359:Harsh_20150315_1345:place3dTexture12";
createNode shadingEngine -n "PxrLMPlasticVelvetSG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode materialInfo -n "Harsh_20150315_1359:Harsh_20150315_1345:materialInfo81";
createNode PxrLMPlastic -n "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet";
	setAttr ".diffuseRoughness" 0.66292136907577515;
	setAttr ".translucence" 0.17977528274059296;
	setAttr ".sheen" -type "float3" 1 1 1 ;
	setAttr ".specularRoughness" 0.40449437499046326;
	setAttr ".clearcoatColor" -type "float3" 0.37077898 0.37077898 0.37077898 ;
	setAttr ".clearcoatRoughness" 0.46606740355491638;
	setAttr ".clearcoatEta" 1.5299999713897705;
	setAttr ".clearcoatThickness" 0.2247190922498703;
createNode ramp -n "Harsh_20150315_1359:Harsh_20150315_1345:ramp6";
	setAttr ".in" 3;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.85337597 0.87374073 0.94400001 ;
	setAttr ".cel[2].ep" 0.93000000715255737;
createNode PxrFacingRatio -n "Harsh_20150315_1359:Harsh_20150315_1345:PxrFacingRatio2";
	setAttr ".gamma" 5;
createNode cloth -n "Harsh_20150315_1359:Harsh_20150315_1345:cloth2";
	setAttr ".cg" -type "float3" 0.12314031 0.18509194 0.39848936 ;
	setAttr ".vc" -type "float3" 0.86500001 0.75466847 0.64182997 ;
	setAttr ".uwi" 0.96240603923797607;
	setAttr ".vwi" 0.94736844301223755;
	setAttr ".uwa" 0.048872180283069611;
	setAttr ".vwa" 0.033834587782621384;
	setAttr ".r" 0.060150377452373505;
	setAttr ".ws" 0.045112781226634979;
	setAttr ".bs" 0.66917294263839722;
createNode place2dTexture -n "Harsh_20150315_1359:Harsh_20150315_1345:place2dTexture10";
	setAttr ".re" -type "float2" 500 500 ;
createNode ramp -n "Harsh_20150315_1359:Harsh_20150315_1345:ramp7";
	setAttr ".in" 3;
	setAttr -s 2 ".cel";
	setAttr ".cel[0].ep" 0.064999997615814209;
	setAttr ".cel[0].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.14048982 0.14048982 0.14048982 ;
createNode PxrBump -n "Harsh_20150315_1359:Harsh_20150315_1345:PxrBump14";
	setAttr ".scale" 0.019999999552965164;
createNode PxrToFloat -n "Harsh_20150315_1359:Harsh_20150315_1345:PxrToFloat12";
createNode PxrBlend -n "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12";
	setAttr ".topA" 0.47191011905670166;
	setAttr ".bottomA" 0.91011238098144531;
createNode brownian -n "Harsh_20150315_1359:Harsh_20150315_1345:brownian1";
	setAttr ".co" -type "float3" 0.21805142 0.21805142 0.21805142 ;
	setAttr ".ag" 0.49624061584472656;
	setAttr ".l" 2.864661693572998;
	setAttr ".ic" 0.23100000619888306;
	setAttr ".oct" 4.7610001564025879;
createNode RMSDisplacement -n "Harsh_20150315_1359:Harsh_20150315_1345:RMSDisplacement3";
	setAttr ".sphere" 0.15000000596046448;
	setAttr ".displacementAmount" 0.039999999105930328;
createNode brownian -n "Harsh_20150315_1359:Harsh_20150315_1345:brownian2";
	setAttr ".ail" yes;
	setAttr ".ao" -0.5;
	setAttr ".l" 1.5714285373687744;
	setAttr ".ic" 0.34586465358734131;
	setAttr ".w3" -type "float3" 1.5 1.5 1 ;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 50 ".lnk";
	setAttr -s 49 ".slnk";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 50 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
	setAttr -s 12 ".gn";
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 40 ".s";
select -ne :defaultTextureList1;
	setAttr -s 153 ".tx";
select -ne :lightList1;
	setAttr -s 2 ".l";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 86 ".u";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :defaultRenderGlobals;
	setAttr ".edl" no;
	setAttr ".ren" -type "string" "renderManRIS";
select -ne :defaultResolution;
	setAttr ".w" 720;
	setAttr ".h" 720;
	setAttr ".pa" 1;
	setAttr ".al" yes;
	setAttr ".dar" 1;
select -ne :defaultLightSet;
	setAttr -s 2 ".dsm";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 18 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surfaces" "Particles" "Fluids" "Image Planes" "UI:" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 18 0 1 1 1 1 1
		 1 0 0 0 0 0 0 0 0 0 0 0 ;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.oc" "PxrLMPlasticVelvetSG.ss"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:RMSDisplacement3.oc" "PxrLMPlasticVelvetSG.ds"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:swatch_teapotShape.iog" "PxrLMPlasticVelvetSG.dsm"
		 -na;
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "PxrLMPlasticVelvetSG.msg" "Harsh_20150315_1359:Harsh_20150315_1345:materialInfo81.sg"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.msg" "Harsh_20150315_1359:Harsh_20150315_1345:materialInfo81.m"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.msg" "Harsh_20150315_1359:Harsh_20150315_1345:materialInfo81.t"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:ramp6.oc" "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.diffuseColor"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:ramp7.oc" "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.specularColor"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrBump14.resultN" "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.diffuseNn"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrBump14.resultN" "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.specularNn"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrBump14.resultN" "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.clearcoatNn"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrFacingRatio2.resultF" "Harsh_20150315_1359:Harsh_20150315_1345:ramp6.u"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrFacingRatio2.resultF" "Harsh_20150315_1359:Harsh_20150315_1345:ramp6.v"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.oc" "Harsh_20150315_1359:Harsh_20150315_1345:ramp6.cel[2].ec"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place2dTexture10.o" "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.uv"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place2dTexture10.ofs" "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.fs"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrFacingRatio2.resultF" "Harsh_20150315_1359:Harsh_20150315_1345:ramp7.u"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrFacingRatio2.resultF" "Harsh_20150315_1359:Harsh_20150315_1345:ramp7.v"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrToFloat12.resultF" "Harsh_20150315_1359:Harsh_20150315_1345:PxrBump14.inputBump"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.resultRGB" "Harsh_20150315_1359:Harsh_20150315_1345:PxrToFloat12.input"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:brownian1.oc" "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.bottomRGB"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.oc" "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.topRGB"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.oa" "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.topRGBr"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.oa" "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.topRGBg"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.oa" "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.topRGBb"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place3dTexture11.wim" "Harsh_20150315_1359:Harsh_20150315_1345:brownian1.pm"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:brownian2.oa" "Harsh_20150315_1359:Harsh_20150315_1345:RMSDisplacement3.displacementScalar"
		;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place3dTexture12.wim" "Harsh_20150315_1359:Harsh_20150315_1345:brownian2.pm"
		;
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "PxrLMPlasticVelvetSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "PxrLMPlasticVelvetSG.message" ":defaultLightSet.message";
connectAttr "PxrLMPlasticVelvetSG.pa" ":renderPartition.st" -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrLMPlasticVelvet.msg" ":defaultShaderList1.s"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:RMSDisplacement3.msg" ":defaultShaderList1.s"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrFacingRatio2.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrBump14.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:brownian1.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:cloth2.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:ramp6.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrBlend12.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:PxrToFloat12.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:ramp7.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:brownian2.msg" ":defaultTextureList1.tx"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place3dTexture11.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place2dTexture10.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "Harsh_20150315_1359:Harsh_20150315_1345:place3dTexture12.msg" ":defaultRenderUtilityList1.u"
		 -na;
// End of velvet.ma
