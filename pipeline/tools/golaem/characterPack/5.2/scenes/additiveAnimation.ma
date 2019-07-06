//Maya ASCII 2014 scene
//Name: additiveAnimation.ma
//Last modified: Fri, Jun 03, 2016 04:55:57 PM
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
		 -nodeType "sphericalLightLocator" -nodeType "CrowdProcMentalRay" -nodeType "CrowdSwitchShaderMentalRay"
		 -nodeType "CrowdHSLShaderMentalRay" -nodeType "CrowdGetUserDataScalarMentalRay" -nodeType "CrowdGetUserDataIntMentalRay"
		 -nodeType "CrowdGetUserDataVectorMentalRay" -nodeType "abcimport" -nodeType "mia_physicalsun"
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
requires -nodeType "PaintLocator" -nodeType "CrowdManagerNode" -nodeType "CrowdField"
		 -nodeType "CrowdArchiverNode" -nodeType "CrowdEntityTypeAttributeNode" -nodeType "CrowdBeTrigger"
		 -nodeType "CrowdStickyNotesNode" -nodeType "MotionClip" -nodeType "CrowdRamp" -nodeType "CrowdRigidBody"
		 -nodeType "MotionLocator" -nodeType "TerrainLocator" -nodeType "PhysicsLocator" -nodeType "FlockLocator"
		 -nodeType "PopulationToolLocator" -nodeType "PopulationToolManipulator" -nodeType "CrowdTargetLocator"
		 -nodeType "ExternalEntityLocator" -nodeType "VectorFieldLocator" -nodeType "PaintedZoneLocator"
		 -nodeType "CharacterMakerLocator" -nodeType "ClothLocator" -nodeType "AbstractCrowdBe"
		 -nodeType "AbstractCrowdBeUser" -nodeType "AbstractCrowdBeContainer" -nodeType "CrowdBeGoto"
		 -nodeType "CrowdBeNavigation" -nodeType "CrowdBeMotion" -nodeType "CrowdBeLocomotion"
		 -nodeType "CrowdBeSyncMotion" -nodeType "CrowdBePhysicalize" -nodeType "CrowdBeForce"
		 -nodeType "CrowdBeDetach" -nodeType "CrowdBeCharacterController" -nodeType "CrowdBeLookAt"
		 -nodeType "CrowdBeIK" -nodeType "CrowdBeAdaptGround" -nodeType "CrowdBeAdaptPosition"
		 -nodeType "CrowdBeAdaptOrientation" -nodeType "CrowdBeSetFormation" -nodeType "CrowdBeGeometry"
		 -nodeType "CrowdBeConstraint" -nodeType "CrowdBeMasterSlave" -nodeType "CrowdBeAttribute"
		 -nodeType "CrowdBeScript" -nodeType "CrowdBeSteer" -nodeType "CrowdBeFlock" -nodeType "CrowdBePerchOn"
		 -nodeType "CrowdBeSetBone" -nodeType "CrowdBeContainer" -nodeType "CrowdBeOpLoop"
		 -nodeType "CrowdBeOpParallel" -nodeType "CrowdBeOpNoOrder" -nodeType "CrowdBeOpAlternative"
		 -nodeType "CrowdBeOpRandom" -nodeType "CrowdBeOpBlock" -nodeType "CrowdBeOpAnchor"
		 -nodeType "CrowdBeOpCondition" -nodeType "CrowdBeCloth" -nodeType "CrowdBeUVPin"
		 -nodeType "CrowdBeApexCloth" -nodeType "AbstractCrowdTri" -nodeType "AbstractSingleCrowdTri"
		 -nodeType "AbstractCompositeCrowdTri" -nodeType "CrowdTriFrame" -nodeType "CrowdTriRandom"
		 -nodeType "CrowdTriPolygonZone" -nodeType "CrowdTriPaintedZone" -nodeType "CrowdTriDistance"
		 -nodeType "CrowdTriPPAttribute" -nodeType "CrowdTriDrivenAttribute" -nodeType "CrowdTriExpression"
		 -nodeType "CrowdTriScript" -nodeType "CrowdTriBehaviorTime" -nodeType "CrowdTriMotionTime"
		 -nodeType "CrowdTriCollision" -nodeType "CrowdTriFade" -nodeType "CrowdTriBoolean"
		 -nodeType "CrowdTriContainer" -nodeType "CrowdTriOpNot" -nodeType "CrowdTriOpAnd"
		 -nodeType "CrowdTriOpOr" -nodeType "CrowdTriOpXor" -nodeType "CrowdPaintManipulator"
		 -nodeType "CrowdEntityTypeNode" -nodeType "CrowdGroupEntityTypeNode" -nodeType "SimulationCacheProxy"
		 -nodeType "CrowdRenderProxy" -nodeType "CrowdProxyVRay" -nodeType "CrowdProxyRendermanStudio"
		 -nodeType "CrowdSwitchShaderVRay" -nodeType "CrowdHSLShaderVRay" -nodeType "CrowdSwitchShader3Delight"
		 -nodeType "CrowdHSLShader3Delight" -nodeType "CrowdGetUserDataFloat3Delight" -nodeType "CrowdGetUserDataVector3Delight"
		 "glmCrowd" "5.2[PR367]-2016/05/30";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014";
fileInfo "cutIdentifier" "201401300447-905052";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 4.9023347917866049 5.6181237437140075 0.033970058839329992 ;
	setAttr ".r" -type "double3" -17.738352728674137 89.399999999979116 1.5186307538648371e-013 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 18.486828515890981;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "terrain1";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode TerrainLocator -n "terrainShape1" -p "terrain1";
	setAttr -k off ".v";
createNode transform -n "crowdManagerNode";
	addAttr -ci true -sn "trBETabs" -ln "trBETabs" -nn "Behavior Editor Tabs" -dt "string";
	addAttr -ci true -sn "trBECTab" -ln "trBECTab" -nn "Behavior Editor Current Tab" 
		-at "float";
	addAttr -ci true -sn "trTriTabs" -ln "trTriTabs" -nn "Trigger Editor Tabs" -dt "string";
	addAttr -ci true -sn "trTriCTab" -ln "trTriCTab" -nn "Trigger Editor Current Tab" 
		-at "float";
	setAttr ".trBETabs" -type "string" "standingRandomEntityTypeContainerShape#sittingEntityTypeContainerShape#additiveEntityTypeContainerShape#sittingAdditiveEntityTypeContainerShape#standingEntityTypeContainerShape#wavingEntityTypeContainerShape#standingAdditiveEntityTypeContainerShape#wavingAdditiveEntityTypeContainerShape#additiveContainerShape#";
	setAttr ".trBECTab" 8;
	setAttr ".trTriTabs" -type "string" "";
	setAttr ".trTriCTab" -1;
createNode CrowdManagerNode -n "crowdManagerNodeShape" -p "crowdManagerNode";
	setAttr -k off ".v";
	setAttr -s 8 ".ine";
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".amwtidx" 1;
	setAttr ".drm" -type "string" "";
lockNode -l 1 ;
createNode transform -n "crowdBehaviors";
createNode transform -n "entityTypeContainer1" -p "crowdBehaviors";
createNode CrowdBeContainer -n "sittingEntityTypeContainerShape" -p "entityTypeContainer1";
	setAttr -k off ".v";
createNode transform -n "crowdTriggers" -p "crowdBehaviors";
createNode transform -n "beMotion1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion1StartTriggerShape" -p "beMotion1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd1" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape1" -p "triOpAnd1";
	setAttr -k off ".v";
createNode transform -n "triBool1" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape1" -p "triBool1";
	setAttr -k off ".v";
createNode transform -n "beMotion1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion1StopTriggerShape" -p "beMotion1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd2" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape2" -p "triOpAnd2";
	setAttr -k off ".v";
createNode transform -n "triBool2" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape2" -p "triBool2";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion2StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion2StartTriggerShape" -p "beMotion2StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd3" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape3" -p "triOpAnd3";
	setAttr -k off ".v";
createNode transform -n "triBool3" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape3" -p "triBool3";
	setAttr -k off ".v";
createNode transform -n "beMotion2StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion2StopTriggerShape" -p "beMotion2StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd4" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape4" -p "triOpAnd4";
	setAttr -k off ".v";
createNode transform -n "triBool4" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape4" -p "triBool4";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion3StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion3StartTriggerShape" -p "beMotion3StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd5" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape5" -p "triOpAnd5";
	setAttr -k off ".v";
createNode transform -n "triBool5" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape5" -p "triBool5";
	setAttr -k off ".v";
createNode transform -n "beMotion3StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion3StopTriggerShape" -p "beMotion3StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd6" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape6" -p "triOpAnd6";
	setAttr -k off ".v";
createNode transform -n "triBool6" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape6" -p "triBool6";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion4StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion4StartTriggerShape" -p "beMotion4StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd7" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape7" -p "triOpAnd7";
	setAttr -k off ".v";
createNode transform -n "triBool7" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape7" -p "triBool7";
	setAttr -k off ".v";
createNode transform -n "beMotion4StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion4StopTriggerShape" -p "beMotion4StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd8" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape8" -p "triOpAnd8";
	setAttr -k off ".v";
createNode transform -n "triBool8" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape8" -p "triBool8";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion5StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion5StartTriggerShape" -p "beMotion5StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd9" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape9" -p "triOpAnd9";
	setAttr -k off ".v";
createNode transform -n "triBool9" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape9" -p "triBool9";
	setAttr -k off ".v";
createNode transform -n "beMotion5StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion5StopTriggerShape" -p "beMotion5StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd10" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape10" -p "triOpAnd10";
	setAttr -k off ".v";
createNode transform -n "triBool10" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape10" -p "triBool10";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion6StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion6StartTriggerShape" -p "beMotion6StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd11" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape11" -p "triOpAnd11";
	setAttr -k off ".v";
createNode transform -n "triBool11" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape11" -p "triBool11";
	setAttr -k off ".v";
createNode transform -n "beMotion6StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion6StopTriggerShape" -p "beMotion6StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd12" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape12" -p "triOpAnd12";
	setAttr -k off ".v";
createNode transform -n "triBool12" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape12" -p "triBool12";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion7StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion7StartTriggerShape" -p "beMotion7StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd13" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape13" -p "triOpAnd13";
	setAttr -k off ".v";
createNode transform -n "triBool13" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape13" -p "triBool13";
	setAttr -k off ".v";
createNode transform -n "beMotion7StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion7StopTriggerShape" -p "beMotion7StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd14" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape14" -p "triOpAnd14";
	setAttr -k off ".v";
createNode transform -n "triBool14" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape14" -p "triBool14";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion8StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion8StartTriggerShape" -p "beMotion8StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd15" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape15" -p "triOpAnd15";
	setAttr -k off ".v";
createNode transform -n "triBool15" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape15" -p "triBool15";
	setAttr -k off ".v";
createNode transform -n "beMotion8StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion8StopTriggerShape" -p "beMotion8StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd16" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape16" -p "triOpAnd16";
	setAttr -k off ".v";
createNode transform -n "triBool16" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape16" -p "triBool16";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion9StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion9StartTriggerShape" -p "beMotion9StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd17" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape17" -p "triOpAnd17";
	setAttr -k off ".v";
createNode transform -n "triBool17" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape17" -p "triBool17";
	setAttr -k off ".v";
createNode transform -n "beMotion9StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion9StopTriggerShape" -p "beMotion9StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd18" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape18" -p "triOpAnd18";
	setAttr -k off ".v";
createNode transform -n "triBool18" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape18" -p "triBool18";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion10StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion10StartTriggerShape" -p "beMotion10StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd19" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape19" -p "triOpAnd19";
	setAttr -k off ".v";
createNode transform -n "triBool19" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape19" -p "triBool19";
	setAttr -k off ".v";
createNode transform -n "beMotion10StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion10StopTriggerShape" -p "beMotion10StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd20" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape20" -p "triOpAnd20";
	setAttr -k off ".v";
createNode transform -n "triBool20" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape20" -p "triBool20";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion11StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion11StartTriggerShape" -p "beMotion11StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd21" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape21" -p "triOpAnd21";
	setAttr -k off ".v";
createNode transform -n "triBool21" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape21" -p "triBool21";
	setAttr -k off ".v";
createNode transform -n "beMotion11StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion11StopTriggerShape" -p "beMotion11StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd22" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape22" -p "triOpAnd22";
	setAttr -k off ".v";
createNode transform -n "triBool22" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape22" -p "triBool22";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion12StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion12StartTriggerShape" -p "beMotion12StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd23" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape23" -p "triOpAnd23";
	setAttr -k off ".v";
createNode transform -n "triBool23" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape23" -p "triBool23";
	setAttr -k off ".v";
createNode transform -n "beMotion12StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion12StopTriggerShape" -p "beMotion12StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd24" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape24" -p "triOpAnd24";
	setAttr -k off ".v";
createNode transform -n "triBool24" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape24" -p "triBool24";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion13StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion13StartTriggerShape" -p "beMotion13StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd25" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape25" -p "triOpAnd25";
	setAttr -k off ".v";
createNode transform -n "triBool25" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape25" -p "triBool25";
	setAttr -k off ".v";
createNode transform -n "beMotion13StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion13StopTriggerShape" -p "beMotion13StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd26" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape26" -p "triOpAnd26";
	setAttr -k off ".v";
createNode transform -n "triBool26" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape26" -p "triBool26";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion14StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion14StartTriggerShape" -p "beMotion14StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd27" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape27" -p "triOpAnd27";
	setAttr -k off ".v";
createNode transform -n "triBool27" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape27" -p "triBool27";
	setAttr -k off ".v";
createNode transform -n "beMotion14StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion14StopTriggerShape" -p "beMotion14StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd28" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape28" -p "triOpAnd28";
	setAttr -k off ".v";
createNode transform -n "triBool28" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape28" -p "triBool28";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion15StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion15StartTriggerShape" -p "beMotion15StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd29" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape29" -p "triOpAnd29";
	setAttr -k off ".v";
createNode transform -n "triBool29" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape29" -p "triBool29";
	setAttr -k off ".v";
createNode transform -n "beMotion15StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion15StopTriggerShape" -p "beMotion15StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd30" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape30" -p "triOpAnd30";
	setAttr -k off ".v";
createNode transform -n "triBool30" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape30" -p "triBool30";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion16StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion16StartTriggerShape" -p "beMotion16StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd31" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape31" -p "triOpAnd31";
	setAttr -k off ".v";
createNode transform -n "triBool31" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape31" -p "triBool31";
	setAttr -k off ".v";
createNode transform -n "beMotion16StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion16StopTriggerShape" -p "beMotion16StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd32" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape32" -p "triOpAnd32";
	setAttr -k off ".v";
createNode transform -n "triBool32" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape32" -p "triBool32";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion18StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion18StartTriggerShape" -p "beMotion18StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd33" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape33" -p "triOpAnd33";
	setAttr -k off ".v";
createNode transform -n "triBool33" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape33" -p "triBool33";
	setAttr -k off ".v";
createNode transform -n "beMotion18StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion18StopTriggerShape" -p "beMotion18StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd34" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape34" -p "triOpAnd34";
	setAttr -k off ".v";
createNode transform -n "triBool34" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape34" -p "triBool34";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion19StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion19StartTriggerShape" -p "beMotion19StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd35" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape35" -p "triOpAnd35";
	setAttr -k off ".v";
createNode transform -n "triBool35" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape35" -p "triBool35";
	setAttr -k off ".v";
createNode transform -n "beMotion19StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion19StopTriggerShape" -p "beMotion19StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd36" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape36" -p "triOpAnd36";
	setAttr -k off ".v";
createNode transform -n "triBool36" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape36" -p "triBool36";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion20StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion20StartTriggerShape" -p "beMotion20StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd37" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape37" -p "triOpAnd37";
	setAttr -k off ".v";
createNode transform -n "triBool37" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape37" -p "triBool37";
	setAttr -k off ".v";
createNode transform -n "beMotion20StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion20StopTriggerShape" -p "beMotion20StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd38" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape38" -p "triOpAnd38";
	setAttr -k off ".v";
createNode transform -n "triBool38" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape38" -p "triBool38";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion21StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion21StartTriggerShape" -p "beMotion21StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd39" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape39" -p "triOpAnd39";
	setAttr -k off ".v";
createNode transform -n "triBool39" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape39" -p "triBool39";
	setAttr -k off ".v";
createNode transform -n "beMotion21StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion21StopTriggerShape" -p "beMotion21StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd40" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape40" -p "triOpAnd40";
	setAttr -k off ".v";
createNode transform -n "triBool40" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape40" -p "triBool40";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beOpAlternative1Trigger1" -p "crowdTriggers";
createNode CrowdTriContainer -n "beOpAlternative1TriggerShape1" -p "beOpAlternative1Trigger1";
	setAttr -k off ".v";
createNode transform -n "triOpAnd41" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape41" -p "triOpAnd41";
	setAttr -k off ".v";
createNode transform -n "triBool41" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape41" -p "triBool41";
	setAttr -k off ".v";
createNode transform -n "beMotion1" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape1" -p "beMotion1";
	setAttr -k off ".v";
	setAttr ".bpx" 51.322406768798828;
	setAttr ".bpy" -18.288190841674805;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmf" -type "string" "";
createNode transform -n "crowdMotionClips" -p "crowdBehaviors";
createNode transform -n "CMAN_SitWatching_11" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_SitWatching_Shape11" -p "CMAN_SitWatching_11";
	setAttr -k off ".v";
	setAttr ".mcid" 1;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Audience/Loop/CMAN_SitWatching_1.gmo";
	setAttr -l on ".fn" 821;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot";
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -1.0672166e-007 1.7075466e-006 1.0672166e-007 ;
	setAttr ".rvl" -type "float3" -3.1235607e-009 4.9976972e-008 3.1235607e-009 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".com" yes;
	setAttr ".csa" 295;
	setAttr ".cso" 296;
	setAttr ".edm" yes;
	setAttr ".aur" yes;
createNode transform -n "CMAN_AddLeftRightHighSwing_UpperBody1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_AddLeftRightHighSwing_UpperBodyShape1" -p "CMAN_AddLeftRightHighSwing_UpperBody1";
	setAttr -k off ".v";
	setAttr ".mcid" 2;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Additive/CMAN_AddLeftRightHighSwing_UpperBody.gmo";
	setAttr -l on ".fn" 888;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot";
	setAttr -l on ".vl";
	setAttr -l on ".ror";
	setAttr -l on ".rvl";
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".aur" yes;
createNode transform -n "CMAN_StandWatching1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_StandWatchingShape1" -p "CMAN_StandWatching1";
	setAttr -k off ".v";
	setAttr ".mcid" 3;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Audience/Loop/CMAN_StandWatching.gmo";
	setAttr -l on ".fn" 879;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot";
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 0.0011064061 -0.078992546 0.0531343 ;
	setAttr ".rvl" -type "float3" 3.0243446e-005 -0.0021592495 0.0014524182 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".com" yes;
	setAttr ".csa" 342;
	setAttr ".cso" 343;
	setAttr ".edm" yes;
	setAttr ".aur" yes;
createNode transform -n "CMAN_SitWave_11" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_SitWave_Shape11" -p "CMAN_SitWave_11";
	setAttr -k off ".v";
	setAttr ".mcid" 4;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Audience/OneShot/CMAN_SitWave_1.gmo";
	setAttr -l on ".fn" 161;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot";
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -0.048548765 -1.6517249 0.20075056 ;
	setAttr ".rvl" -type "float3" -0.0072823139 -0.24775873 0.030112583 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".com" yes;
	setAttr ".csa" 48;
	setAttr ".cso" 49;
	setAttr ".edm" yes;
	setAttr ".aur" yes;
createNode transform -n "CMAN_AddBackFrontLittleSwing_UpperBody1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_AddBackFrontLittleSwing_UpperBodyShape1" -p "CMAN_AddBackFrontLittleSwing_UpperBody1";
	setAttr -k off ".v";
	setAttr ".mcid" 5;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Additive/CMAN_AddBackFrontLittleSwing_UpperBody.gmo";
	setAttr -l on ".fn" 511;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot";
	setAttr -l on ".vl";
	setAttr -l on ".ror";
	setAttr -l on ".rvl";
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".aur" yes;
createNode transform -n "CMAN_AddLeftHighSwing_FullBody1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_AddLeftHighSwing_FullBodyShape1" -p "CMAN_AddLeftHighSwing_FullBody1";
	setAttr -k off ".v";
	setAttr ".mcid" 6;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Additive/CMAN_AddLeftHighSwing_FullBody.gmo";
	setAttr -l on ".fn" 755;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 1.6472095e-006 0 -3.5369412e-006 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 5.2431069e-008 0 -1.1258168e-007 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -0.012043897 -1.646754e-005 -1.4504209e-005 ;
	setAttr ".rvl" -type "float3" -0.00038336011 -5.2416573e-007 -4.6167241e-007 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".aur" yes;
createNode transform -n "CMAN_AddLeftRightAverageSwing_FullBody1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_AddLeftRightAverageSwing_FullBodyShape1" -p "CMAN_AddLeftRightAverageSwing_FullBody1";
	setAttr -k off ".v";
	setAttr ".mcid" 7;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Additive/CMAN_AddLeftRightAverageSwing_FullBody.gmo";
	setAttr -l on ".fn" 400;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" -5.5777491e-008 0 -2.0815787e-007 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" -3.3550371e-009 0 -1.2520775e-008 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 0.00079626724 1.1380287e-006 6.6196553e-006 ;
	setAttr ".rvl" -type "float3" 4.7895774e-005 6.8452856e-008 3.9817476e-007 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".aur" yes;
createNode transform -n "CMAN_AddRightLeftLittleSwing_UpperBody1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_AddRightLeftLittleSwing_UpperBodyShape1" -p "CMAN_AddRightLeftLittleSwing_UpperBody1";
	setAttr -k off ".v";
	setAttr ".mcid" 8;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Additive/CMAN_AddRightLeftLittleSwing_UpperBody.gmo";
	setAttr -l on ".fn";
	setAttr -l on ".fr";
	setAttr -l on ".rot";
	setAttr -l on ".vl";
	setAttr -l on ".ror";
	setAttr -l on ".rvl";
	setAttr -l on ".ic";
	setAttr -l on ".il";
	setAttr -l on ".ili";
	setAttr -l on ".hed";
	setAttr ".aur" yes;
createNode transform -n "entityTypeContainer2" -p "crowdBehaviors";
createNode CrowdBeContainer -n "additiveEntityTypeContainerShape" -p "entityTypeContainer2";
	setAttr -k off ".v";
createNode transform -n "beMotion2" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape2" -p "beMotion2";
	setAttr -k off ".v";
	setAttr ".bpx" 28.002738952636719;
	setAttr ".bpy" -12.155733108520508;
	setAttr ".dc" -type "float3" 0 1 1 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".blm" 1;
createNode transform -n "entityTypeContainer3" -p "crowdBehaviors";
createNode CrowdBeContainer -n "sittingAdditiveEntityTypeContainerShape" -p "entityTypeContainer3";
	setAttr -k off ".v";
createNode transform -n "beMotion3" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape3" -p "beMotion3";
	setAttr -k off ".v";
	setAttr ".bpy" -41;
	setAttr ".dc" -type "float3" 1 1 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmf" -type "string" "";
createNode transform -n "beMotion4" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape4" -p "beMotion4";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".dc" -type "float3" 1 0 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".blm" 1;
createNode transform -n "beOpParallel1" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape1" -p "beOpParallel1";
	setAttr -k off ".v";
	setAttr ".bpx" 51.096664428710937;
	setAttr ".bpy" 43.210456848144531;
createNode transform -n "entityTypeContainer4" -p "crowdBehaviors";
createNode CrowdBeContainer -n "standingEntityTypeContainerShape" -p "entityTypeContainer4";
	setAttr -k off ".v";
createNode transform -n "beMotion5" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape5" -p "beMotion5";
	setAttr -k off ".v";
	setAttr ".bpx" 117.55667114257812;
	setAttr ".bpy" -7.2692255973815918;
	setAttr ".dc" -type "float3" 0 0 1 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmf" -type "string" "";
createNode transform -n "entityTypeContainer5" -p "crowdBehaviors";
createNode CrowdBeContainer -n "wavingEntityTypeContainerShape" -p "entityTypeContainer5";
	setAttr -k off ".v";
createNode transform -n "beMotion6" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape6" -p "beMotion6";
	setAttr -k off ".v";
	setAttr ".bpx" 37.010932922363281;
	setAttr ".bpy" 1.8961764574050903;
	setAttr ".dc" -type "float3" 1 0 1 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmf" -type "string" "";
createNode transform -n "entityTypeContainer6" -p "crowdBehaviors";
createNode CrowdBeContainer -n "standingAdditiveEntityTypeContainerShape" -p "entityTypeContainer6";
	setAttr -k off ".v";
createNode transform -n "beMotion7" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape7" -p "beMotion7";
	setAttr -k off ".v";
	setAttr ".bpy" -41;
	setAttr ".dc" -type "float3" 1 0.5 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
createNode transform -n "beMotion8" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape8" -p "beMotion8";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".dc" -type "float3" 1 0 0.5 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".blm" 1;
createNode transform -n "beOpParallel2" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape2" -p "beOpParallel2";
	setAttr -k off ".v";
	setAttr ".bpx" 113;
	setAttr ".bpy" 16;
createNode transform -n "entityTypeContainer7" -p "crowdBehaviors";
createNode CrowdBeContainer -n "wavingAdditiveEntityTypeContainerShape" -p "entityTypeContainer7";
	setAttr -k off ".v";
createNode transform -n "beMotion9" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape9" -p "beMotion9";
	setAttr -k off ".v";
	setAttr ".bpy" -41;
	setAttr ".dc" -type "float3" 0 0.5 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmf" -type "string" "";
createNode transform -n "beMotion10" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape10" -p "beMotion10";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".dc" -type "float3" 0 0.5 0.5 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".blm" 1;
createNode transform -n "beOpParallel3" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape3" -p "beOpParallel3";
	setAttr -k off ".v";
	setAttr ".bpx" 79;
	setAttr ".bpy" 5;
createNode transform -n "entityTypeContainer8" -p "crowdBehaviors";
createNode CrowdBeContainer -n "standingRandomEntityTypeContainerShape" -p "entityTypeContainer8";
	setAttr -k off ".v";
	setAttr ".bpx" 403;
	setAttr ".bpy" 186;
	setAttr ".fpx" 600;
createNode transform -n "standMotion" -p "crowdBehaviors";
createNode CrowdBeMotion -n "standMotionShape" -p "standMotion";
	setAttr -k off ".v";
	setAttr ".bpy" -92;
	setAttr ".dc" -type "float3" 0.5 0.5 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmf" -type "string" "";
createNode transform -n "addLeftRightMotion1" -p "crowdBehaviors";
createNode CrowdBeMotion -n "addLeftRightMotionShape1" -p "addLeftRightMotion1";
	setAttr -k off ".v";
	setAttr ".bpx" 394;
	setAttr ".bpy" 307;
	setAttr ".dc" -type "float3" 0.5 0 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 0.10000000149011612;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.75;
	setAttr ".srma" 1.25;
	setAttr ".armi" 1.5;
	setAttr ".arma" 2;
createNode transform -n "beOpParallel4" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape4" -p "beOpParallel4";
	setAttr -k off ".v";
	setAttr ".bpx" 92;
	setAttr ".bpy" 45;
createNode transform -n "entityTypeContainer9" -p "crowdBehaviors";
createNode CrowdBeContainer -n "sittingRandomEntityTypeContainerShape" -p "entityTypeContainer9";
	setAttr -k off ".v";
createNode transform -n "entityTypeContainer10" -p "crowdBehaviors";
createNode CrowdBeContainer -n "wavingRandomEntityTypeContainerShape" -p "entityTypeContainer10";
	setAttr -k off ".v";
createNode transform -n "beMotion13" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape13" -p "beMotion13";
	setAttr -k off ".v";
	setAttr ".bpy" -41;
	setAttr ".dc" -type "float3" 0 0 0.5 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmm" 2;
	setAttr ".mmf" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_replay_CMAN.gmm";
createNode transform -n "beMotion14" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape14" -p "beMotion14";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".dc" -type "float3" 0.5 0 0.5 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 1;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.75;
	setAttr ".srma" 1.25;
	setAttr ".armi" 0.75;
	setAttr ".arma" 1.25;
createNode transform -n "beOpParallel5" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape5" -p "beOpParallel5";
	setAttr -k off ".v";
	setAttr ".bpx" 403;
	setAttr ".bpy" 186;
createNode transform -n "beMotion15" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape15" -p "beMotion15";
	setAttr -k off ".v";
	setAttr ".bpy" -41;
	setAttr ".dc" -type "float3" 0.5 0.25 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".mmm" 2;
	setAttr ".mmf" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_replay_CMAN.gmm";
createNode transform -n "beMotion16" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape16" -p "beMotion16";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".dc" -type "float3" 0.5 0 0.25 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 1;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.75;
	setAttr ".srma" 1.25;
	setAttr ".armi" 0.75;
	setAttr ".arma" 1.25;
createNode transform -n "beOpParallel6" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape6" -p "beOpParallel6";
	setAttr -k off ".v";
	setAttr ".bpx" 406;
	setAttr ".bpy" 191;
createNode transform -n "additiveContainer" -p "crowdBehaviors";
createNode CrowdBeContainer -n "additiveContainerShape" -p "additiveContainer";
	setAttr -k off ".v";
	setAttr ".ipx" 54.572605133056641;
	setAttr ".ipy" 282.22201538085937;
	setAttr ".fpx" 778.6131591796875;
	setAttr ".fpy" 101.47199249267578;
createNode transform -n "beOpRandom1" -p "crowdBehaviors";
createNode CrowdBeOpRandom -n "beOpRandomShape1" -p "beOpRandom1";
	setAttr -k off ".v";
	setAttr -s 2 ".prb";
	setAttr ".bpx" 155.62811279296875;
	setAttr ".bpy" 281.22201538085937;
	setAttr -s 4 ".cnd";
createNode transform -n "beOpAlternative1" -p "crowdBehaviors";
createNode CrowdBeOpAlternative -n "beOpAlternativeShape1" -p "beOpAlternative1";
	setAttr -k off ".v";
	setAttr -s 4 ".prb";
	setAttr ".bpx" 680.5211181640625;
	setAttr ".bpy" 101.47199249267578;
createNode transform -n "addLeftRightMotion2" -p "crowdBehaviors";
createNode CrowdBeMotion -n "addLeftRightMotionShape2" -p "addLeftRightMotion2";
	setAttr -k off ".v";
	setAttr ".bpx" 394;
	setAttr ".bpy" 383;
	setAttr ".dc" -type "float3" 0.5 0.5 0.5 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 0.10000000149011612;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.75;
	setAttr ".srma" 1.25;
	setAttr ".armi" 1.5;
	setAttr ".arma" 2;
createNode transform -n "addLeftRightMotion3" -p "crowdBehaviors";
createNode CrowdBeMotion -n "addLeftRightMotionShape3" -p "addLeftRightMotion3";
	setAttr -k off ".v";
	setAttr ".bpx" 393;
	setAttr ".bpy" 458;
	setAttr ".dc" -type "float3" 0 0 0 ;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 0.10000000149011612;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.75;
	setAttr ".srma" 1.25;
	setAttr ".armi" 1.5;
	setAttr ".arma" 2;
createNode transform -n "addLeftRightMotion4" -p "crowdBehaviors";
createNode CrowdBeMotion -n "addLeftRightMotionShape4" -p "addLeftRightMotion4";
	setAttr -k off ".v";
	setAttr ".bpx" 393;
	setAttr ".bpy" 531.6534423828125;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 0.10000000149011612;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.75;
	setAttr ".srma" 1.25;
	setAttr ".armi" 1.5;
	setAttr ".arma" 2;
createNode transform -n "addBackFrontMotion" -p "crowdBehaviors";
createNode CrowdBeMotion -n "addBackFrontMotionShape" -p "addBackFrontMotion";
	setAttr -k off ".v";
	setAttr ".bpy" 92;
	setAttr ".sta" 0;
	setAttr ".sto" 0;
	setAttr ".spma" 1;
	setAttr ".blm" 1;
	setAttr ".srmi" 0.25;
	setAttr ".srma" 0.5;
	setAttr ".armi" 0.75;
	setAttr ".arma" 1.25;
createNode CrowdField -n "crowdField1";
	setAttr -s 4 ".ind";
	setAttr -s 4 ".of";
	setAttr -s 4 ".ppda";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr ".cfid" 1;
	setAttr ".noe" 201;
createNode transform -n "additiveEntityType";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "additiveEntityTypeShape" -p "additiveEntityType";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 1 1 0 ;
	setAttr -l on ".etid" 2;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".scrmi" 1;
	setAttr ".scrma" 1;
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "sitting";
createNode transform -n "sittingAdditiveEntityType" -p "sitting";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "sittingAdditiveEntityTypeShape" -p "sittingAdditiveEntityType";
	setAttr -k off ".v";
	setAttr -l on ".etid" 3;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "sittingEntityType" -p "sitting";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "sittingEntityTypeShape" -p "sittingEntityType";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 1 0 0 ;
	setAttr -l on ".etid" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".scrmi" 1;
	setAttr ".scrma" 1;
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "sittingPopTool" -p "sitting";
	setAttr ".t" -type "double3" -6.5 0 4.0004997253417969 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "sittingPopToolShape" -p "sittingPopTool";
	setAttr -k off ".v";
	setAttr ".np" 3;
	setAttr ".npp" 3;
	setAttr ".nr" 1;
	setAttr ".nc" 1;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "sittingParticleShape";
	setAttr -s 3 ".ine";
	setAttr ".etw" -type "Int32Array" 3 28 17 38 ;
	setAttr ".etp" -type "doubleArray" 3 33.734939759036145 20.481927710843372 45.783132530120483 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 3 -6 0 4 -7 0 4.6999998092651367 -7 0 3.3010001182556152 ;
	setAttr ".pto" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 ;
	setAttr ".poo" -type "doubleArray" 3 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 3 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 3 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 3 3 1 2 ;
	setAttr ".get" -type "doubleArray" 3 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 3 1 2 3 ;
	setAttr ".etc" -type "vectorArray" 3 0 1 0 1 0 0 1 1 0 ;
	setAttr ".sh" 5;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 3 0.5 -0.69949960708618164 0 0.5 0.69950008392333984
		 0 -0.5 -0.000499725341796875 0 ;
createNode transform -n "sittingParticle" -p "sitting";
createNode particle -n "sittingParticleShape" -p "sittingParticle";
	addAttr -ci true -sn "initDirection" -ln "initDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "initDirection0" -ln "initDirection0" -dt "vectorArray";
	addAttr -ci true -sn "entityType" -ln "entityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityType0" -ln "entityType0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityType" -ln "groupEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityType0" -ln "groupEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "entityRadius" -ln "entityRadius" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityRadius0" -ln "entityRadius0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityId" -ln "groupEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityId0" -ln "groupEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "glmEntityId" -ln "glmEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityId0" -ln "glmEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "glmInitDirection" -ln "glmInitDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "glmInitDirection0" -ln "glmInitDirection0" -dt "vectorArray";
	addAttr -ci true -sn "glmEntityType" -ln "glmEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityType0" -ln "glmEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -ci true -sn "populationGroupId" -ln "populationGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "populationGroupId0" -ln "populationGroupId0" -dt "doubleArray";
	addAttr -ci true -sn "glmGroupId" -ln "glmGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmGroupId0" -ln "glmGroupId0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 3 -6 0 4 -7 0 4.6999998092651367 -7 0 3.3010001182556152 ;
	setAttr ".vel0" -type "vectorArray" 3 0 0 0 0 0 0 0 1.4305113893442505e-006
		 0 ;
	setAttr ".acc0" -type "vectorArray" 3 0 0 0 0 0 0 0 3.4332273344262009e-005
		 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "additiveAnimation_startup";
	setAttr ".mas0" -type "doubleArray" 3 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 3 0 1 2 ;
	setAttr ".nid" 3;
	setAttr ".nid0" 3;
	setAttr ".bt0" -type "doubleArray" 3 -10.416666666666666 -10.416666666666666
		 -10.416666666666666 ;
	setAttr ".ag0" -type "doubleArray" 3 12.416666666666666 12.416666666666666 12.416666666666666 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 500;
	setAttr ".initDirection0" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".entityType0" -type "doubleArray" 3 2 1 3 ;
	setAttr ".groupEntityType0" -type "doubleArray" 3 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 3 0 1 0 1 0 0 1 1 0 ;
	setAttr ".entityRadius0" -type "doubleArray" 3 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 ;
	setAttr ".groupEntityId0" -type "doubleArray" 3 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 3 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 3 1001 2001 3001 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".glmInitDirection0" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".glmEntityType0" -type "doubleArray" 3 3 1 2 ;
	setAttr ".radiusPP0" -type "doubleArray" 3 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 3 -1 -1 -1 ;
	setAttr ".glmGroupId0" -type "doubleArray" 3 -1 -1 -1 ;
createNode transform -n "annotations" -p "sitting";
	setAttr ".t" -type "double3" -13 0 0 ;
createNode transform -n "inputAnnotation" -p "|sitting|annotations";
	setAttr ".t" -type "double3" 6 0 4.7 ;
createNode locator -n "inputAnnotationShape" -p "inputAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation3" -p "inputAnnotation";
	setAttr ".t" -type "double3" 0 1.25 -0.1 ;
createNode annotationShape -n "annotationShape3" -p "annotation3";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".txt" -type "string" "Sitting input animation";
createNode transform -n "outputAnnotation" -p "|sitting|annotations";
	setAttr ".t" -type "double3" 7 0 4 ;
createNode locator -n "outputAnnotationShape" -p "|sitting|annotations|outputAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation9" -p "|sitting|annotations|outputAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 0 ;
createNode annotationShape -n "annotationShape9" -p "annotation9";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 14;
	setAttr ".txt" -type "string" "Sitting output animation";
createNode transform -n "additiveAnnotation" -p "|sitting|annotations";
	setAttr ".t" -type "double3" 6 0 3.3 ;
createNode locator -n "additiveAnnotationShape" -p "|sitting|annotations|additiveAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation5" -p "|sitting|annotations|additiveAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 0 ;
createNode annotationShape -n "annotationShape5" -p "annotation5";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 17;
	setAttr ".txt" -type "string" "Additive animation";
createNode transform -n "standing";
createNode transform -n "standingEntityType" -p "standing";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "standingEntityTypeShape" -p "standingEntityType";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 1 0 0 ;
	setAttr -l on ".etid" 4;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".scrmi" 1;
	setAttr ".scrma" 1;
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "standingAdditiveEntityType" -p "standing";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "standingAdditiveEntityTypeShape" -p "standingAdditiveEntityType";
	setAttr -k off ".v";
	setAttr -l on ".etid" 6;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "standingPopTool" -p "standing";
	setAttr ".t" -type "double3" -6.5 0 0 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "standingPopToolShape" -p "standingPopTool";
	setAttr -k off ".v";
	setAttr ".np" 3;
	setAttr ".npp" 3;
	setAttr ".nr" 1;
	setAttr ".nc" 1;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "standingParticleShape";
	setAttr -s 3 ".ine";
	setAttr ".etw" -type "Int32Array" 3 37 98 100 ;
	setAttr ".etp" -type "doubleArray" 3 15.74468085106383 41.702127659574465 42.553191489361708 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 3 -6 0 0 -7 0 0.69999998807907104 -7 0 -0.69999998807907104 ;
	setAttr ".pto" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 ;
	setAttr ".poo" -type "doubleArray" 3 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 3 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 3 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 3 6 4 2 ;
	setAttr ".get" -type "doubleArray" 3 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 3 1 2 3 ;
	setAttr ".etc" -type "vectorArray" 3 0 1 0 1 0 0 1 1 0 ;
	setAttr ".sh" 5;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 3 0.5 -0.69999998807907104 0 0.5 0.69999998807907104
		 0 -0.5 0 0 ;
createNode transform -n "standingParticle" -p "standing";
createNode particle -n "standingParticleShape" -p "standingParticle";
	addAttr -ci true -sn "initDirection" -ln "initDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "initDirection0" -ln "initDirection0" -dt "vectorArray";
	addAttr -ci true -sn "entityType" -ln "entityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityType0" -ln "entityType0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityType" -ln "groupEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityType0" -ln "groupEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "entityRadius" -ln "entityRadius" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityRadius0" -ln "entityRadius0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityId" -ln "groupEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityId0" -ln "groupEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "glmEntityId" -ln "glmEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityId0" -ln "glmEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "glmInitDirection" -ln "glmInitDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "glmInitDirection0" -ln "glmInitDirection0" -dt "vectorArray";
	addAttr -ci true -sn "glmEntityType" -ln "glmEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityType0" -ln "glmEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -ci true -sn "populationGroupId" -ln "populationGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "populationGroupId0" -ln "populationGroupId0" -dt "doubleArray";
	addAttr -ci true -sn "glmGroupId" -ln "glmGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmGroupId0" -ln "glmGroupId0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 3 -6 0 0 -7 0 0.69999998807907104 -7 0 -0.69999998807907104 ;
	setAttr ".vel0" -type "vectorArray" 3 0 0 0 0 -1.1444091114754002e-005 0 0 -7.1525569467212522e-006
		 0 ;
	setAttr ".acc0" -type "vectorArray" 3 0 0 0 0 -0.00027465818675409607 0 0 -0.00017166136672131007
		 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "additiveAnimation_startup";
	setAttr ".mas0" -type "doubleArray" 3 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 3 0 1 2 ;
	setAttr ".nid" 3;
	setAttr ".nid0" 3;
	setAttr ".bt0" -type "doubleArray" 3 -9.25 -9.25 -9.25 ;
	setAttr ".ag0" -type "doubleArray" 3 11.25 11.25 11.25 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 500;
	setAttr ".initDirection0" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".entityType0" -type "doubleArray" 3 2 4 6 ;
	setAttr ".groupEntityType0" -type "doubleArray" 3 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 3 0 1 0 1 0 0 1 1 0 ;
	setAttr ".entityRadius0" -type "doubleArray" 3 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 ;
	setAttr ".groupEntityId0" -type "doubleArray" 3 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 3 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 3 4001 5001 6001 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".glmInitDirection0" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".glmEntityType0" -type "doubleArray" 3 6 4 2 ;
	setAttr ".radiusPP0" -type "doubleArray" 3 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 3 -1 -1 -1 ;
	setAttr ".glmGroupId0" -type "doubleArray" 3 -1 -1 -1 ;
createNode transform -n "annotations" -p "standing";
	setAttr ".t" -type "double3" -13 0 0 ;
createNode transform -n "standingAnnotation" -p "|standing|annotations";
	setAttr ".t" -type "double3" 6 0 0.7 ;
createNode locator -n "standingAnnotationShape" -p "standingAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "standingAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 0.5 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".txt" -type "string" "Standing input animation";
createNode transform -n "outputAnnotation" -p "|standing|annotations";
	setAttr ".t" -type "double3" 7 0 0 ;
createNode locator -n "outputAnnotationShape" -p "|standing|annotations|outputAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation7" -p "|standing|annotations|outputAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 0 ;
createNode annotationShape -n "annotationShape7" -p "annotation7";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 14;
	setAttr ".txt" -type "string" "Standing output animation";
createNode transform -n "additiveAnnotation" -p "|standing|annotations";
	setAttr ".t" -type "double3" 6 0 -0.7 ;
createNode locator -n "additiveAnnotationShape" -p "|standing|annotations|additiveAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation4" -p "|standing|annotations|additiveAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 -0.5 ;
createNode annotationShape -n "annotationShape4" -p "annotation4";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 17;
	setAttr ".txt" -type "string" "Additive animation";
createNode transform -n "waving";
createNode transform -n "wavingEntityType" -p "waving";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "wavingEntityTypeShape" -p "wavingEntityType";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 1 0 0 ;
	setAttr -l on ".etid" 5;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".scrmi" 1;
	setAttr ".scrma" 1;
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "wavingAdditiveEntityType" -p "waving";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "wavingAdditiveEntityTypeShape" -p "wavingAdditiveEntityType";
	setAttr -k off ".v";
	setAttr -l on ".etid" 7;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "wavingPopTool" -p "waving";
	setAttr ".t" -type "double3" -6.5 0 -4.0005002021789551 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "wavingPopToolShape" -p "wavingPopTool";
	setAttr -k off ".v";
	setAttr ".np" 3;
	setAttr ".npp" 3;
	setAttr ".nr" 1;
	setAttr ".nc" 1;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "wavingParticleShape";
	setAttr -s 3 ".ine";
	setAttr ".etw" -type "Int32Array" 3 51 54 65 ;
	setAttr ".etp" -type "doubleArray" 3 30 31.764705882352942 38.235294117647058 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 3 -6 0 -4 -7 0 -3.2999999523162842 -7 0 -4.7010002136230469 ;
	setAttr ".pto" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 ;
	setAttr ".poo" -type "doubleArray" 3 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 3 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 3 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 3 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 3 7 5 2 ;
	setAttr ".get" -type "doubleArray" 3 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 3 1 2 3 ;
	setAttr ".etc" -type "vectorArray" 3 0 1 0 1 0 0 1 1 0 ;
	setAttr ".sh" 5;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 3 0.5 -0.7005000114440918 0 0.5 0.7005002498626709
		 0 -0.5 0.00050020217895507813 0 ;
createNode transform -n "wavingParticle" -p "waving";
createNode particle -n "wavingParticleShape" -p "wavingParticle";
	addAttr -ci true -sn "initDirection" -ln "initDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "initDirection0" -ln "initDirection0" -dt "vectorArray";
	addAttr -ci true -sn "entityType" -ln "entityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityType0" -ln "entityType0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityType" -ln "groupEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityType0" -ln "groupEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "entityRadius" -ln "entityRadius" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityRadius0" -ln "entityRadius0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityId" -ln "groupEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityId0" -ln "groupEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "glmEntityId" -ln "glmEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityId0" -ln "glmEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "glmInitDirection" -ln "glmInitDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "glmInitDirection0" -ln "glmInitDirection0" -dt "vectorArray";
	addAttr -ci true -sn "glmEntityType" -ln "glmEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityType0" -ln "glmEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -ci true -sn "populationGroupId" -ln "populationGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "populationGroupId0" -ln "populationGroupId0" -dt "doubleArray";
	addAttr -ci true -sn "glmGroupId" -ln "glmGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmGroupId0" -ln "glmGroupId0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 3 -6 0 -4 -7 0 -3.2999999523162842 -7 0
		 -4.7010002136230469 ;
	setAttr ".vel0" -type "vectorArray" 3 0 0 0 0 -8.5830683360655023e-006 0 0 -7.1525569467212522e-006
		 0 ;
	setAttr ".acc0" -type "vectorArray" 3 0 0 0 0 -0.00020599364006557207 0 0 -0.00017166136672131007
		 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "additiveAnimation_startup";
	setAttr ".mas0" -type "doubleArray" 3 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 3 0 1 2 ;
	setAttr ".nid" 3;
	setAttr ".nid0" 3;
	setAttr ".bt0" -type "doubleArray" 3 -9.25 -9.25 -9.25 ;
	setAttr ".ag0" -type "doubleArray" 3 11.25 11.25 11.25 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 500;
	setAttr ".initDirection0" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".entityType0" -type "doubleArray" 3 2 5 7 ;
	setAttr ".groupEntityType0" -type "doubleArray" 3 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 3 0 1 0 1 0 0 1 1 0 ;
	setAttr ".entityRadius0" -type "doubleArray" 3 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 ;
	setAttr ".groupEntityId0" -type "doubleArray" 3 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 3 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 3 7001 8001 9001 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".glmInitDirection0" -type "vectorArray" 3 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".glmEntityType0" -type "doubleArray" 3 7 5 2 ;
	setAttr ".radiusPP0" -type "doubleArray" 3 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 3 -1 -1 -1 ;
	setAttr ".glmGroupId0" -type "doubleArray" 3 -1 -1 -1 ;
createNode transform -n "annotations" -p "waving";
	setAttr ".t" -type "double3" -13 0 0 ;
createNode transform -n "additiveAnnotation" -p "|waving|annotations";
	setAttr ".t" -type "double3" 6 0 -4.7 ;
createNode locator -n "additiveAnnotationShape" -p "|waving|annotations|additiveAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation6" -p "|waving|annotations|additiveAnnotation";
	setAttr ".t" -type "double3" 0 -0.41551934426938875 -0.91978924793187844 ;
createNode annotationShape -n "annotationShape6" -p "annotation6";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 17;
	setAttr ".txt" -type "string" "Additive animation";
createNode transform -n "wavingAnnotation" -p "|waving|annotations";
	setAttr ".t" -type "double3" 6 0 -3.3 ;
createNode locator -n "wavingAnnotationShape" -p "wavingAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation2" -p "wavingAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 0 ;
createNode annotationShape -n "annotationShape2" -p "annotation2";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".txt" -type "string" "Waving input animation";
createNode transform -n "outputAnnotation" -p "|waving|annotations";
	setAttr ".t" -type "double3" 7 0 -4 ;
createNode locator -n "outputAnnotationShape" -p "|waving|annotations|outputAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation8" -p "|waving|annotations|outputAnnotation";
	setAttr ".t" -type "double3" 0 -0.5 0 ;
createNode annotationShape -n "annotationShape8" -p "annotation8";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 14;
	setAttr ".txt" -type "string" "Waving output animation";
createNode transform -n "standingRandom";
createNode transform -n "standingRandomEntityType" -p "standingRandom";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdEntityTypeNode -n "standingRandomEntityTypeShape" -p "standingRandomEntityType";
	setAttr -k off ".v";
	setAttr -l on ".etid" 8;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "standingRandomParticle" -p "standingRandom";
createNode particle -n "standingRandomParticleShape" -p "standingRandomParticle";
	addAttr -ci true -sn "initDirection" -ln "initDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "initDirection0" -ln "initDirection0" -dt "vectorArray";
	addAttr -ci true -sn "entityType" -ln "entityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityType0" -ln "entityType0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityType" -ln "groupEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityType0" -ln "groupEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "entityRadius" -ln "entityRadius" -dt "doubleArray";
	addAttr -ci true -h true -sn "entityRadius0" -ln "entityRadius0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityId" -ln "groupEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityId0" -ln "groupEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "glmEntityId" -ln "glmEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityId0" -ln "glmEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	addAttr -ci true -sn "glmInitDirection" -ln "glmInitDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "glmInitDirection0" -ln "glmInitDirection0" -dt "vectorArray";
	addAttr -ci true -sn "glmEntityType" -ln "glmEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityType0" -ln "glmEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -ci true -sn "populationGroupId" -ln "populationGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "populationGroupId0" -ln "populationGroupId0" -dt "doubleArray";
	addAttr -ci true -sn "glmGroupId" -ln "glmGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmGroupId0" -ln "glmGroupId0" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 192 -22.853368759155273 0 -6.7534470558166504 -18.304723739624023
		 0 -7.1569700241088867 -16.69849967956543 0 -3.6030001640319824 -18.229852676391602
		 0 -4.7092113494873047 -22.241338729858398 0 1.4639781713485718 -18.584686279296875
		 0 -8.2778558731079102 -19.100500106811523 0 4.8040003776550293 -24.271736145019531
		 0 8.487579345703125 -14.195436477661133 0 -5.3593330383300781 -24.489959716796875
		 0 6.966031551361084 -13.505473136901855 0 -4.3947300910949707 -14.930551528930664
		 0 6.125007152557373 -16.060060501098633 0 -6.0304164886474609 -18.47210693359375
		 0 3.0850656032562256 -12.689811706542969 0 6.7072267532348633 -19.266374588012695
		 0 -1.6086506843566897 -22.878822326660156 0 -4.5088353157043457 -20.913021087646484
		 0 1.4010829925537107 -16.211750030517578 0 -8.3522872924804687 -17.153396606445313
		 0 8.3199739456176758 -22.18358039855957 0 6.1351914405822754 -20.586675643920895
		 0 4.1783480644226074 -17.132369995117188 0 -5.9221129417419434 -17.899499893188477
		 0 8.4070005416870117 -20.619403839111328 0 -2.8955950736999512 -14.317937850952148
		 0 -1.7291711568832395 -16.058887481689453 0 -3.9451954364776607 -22.574682235717773
		 0 -3.7300703525543217 -18.870695114135746 0 -6.8977537155151367 -18.051727294921875
		 0 -2.8740799427032471 -24.034524917602539 0 -6.3372249603271484 -21.275123596191406
		 0 -5.2915463447570801 -14.722883224487305 0 -8.0069131851196289 -14.188756942749023
		 0 -2.6261200904846191 -13.095499038696287 0 4.8040003776550293 -22.093545913696289
		 0 2.1462745666503902 -19.584211349487305 0 -3.2026665210723877 -17.85594367980957
		 0 5.8232240676879883 -19.182666778564453 0 -2.6826527118682861 -16.360416412353516
		 0 0.58860874176025391 -13.258289337158203 0 4.044501781463623 -17.391422271728516
		 0 -8.7930812835693359 -23.699127197265625 0 3.5294966697692871 -20.653942108154297
		 0 -7.8112859725952148 -21.988374710083008 0 3.1483421325683594 -19.922080993652344
		 0 6.9068126678466797 -23.294160842895508 0 0.059956192970275879 -22.19880485534668
		 0 -6.3500442504882812 -14.919191360473633 0 -6.7099752426147461 -15.370504379272459
		 0 -5.1521835327148437 -22.703498840332031 0 4.8040003776550293 -13.819036483764648
		 0 5.7512097358703613 -23.382469177246097 0 1.656907320022583 -14.19920539855957 0
		 0.1585058718919754 -24.351280212402344 0 6.1446661949157715 -15.552132606506348 0
		 0.13541121780872345 -18.148168563842773 0 5.2374963760375977 -20.577398300170895
		 0 -5.1340198516845703 -22.782810211181641 0 4.1316976547241211 -18.406776428222656
		 0 2.4415929317474365 -18.658260345458984 0 8.4891767501831055 -13.833686828613279
		 0 1.370506763458252 -14.456893920898436 0 1.8645133972167969 -12.664668083190918
		 0 0.23169665038585663 -14.634777069091797 0 3.038095235824585 -19.812068939208984
		 0 5.1227154731750488 -18.471515655517575 0 -1.7266387939453125 -21.952980041503903
		 0 7.3973503112792978 -13.824783325195313 0 8.3238363265991211 -16.57530403137207
		 0 -2.8505079746246338 -19.100500106811523 0 1.2010002136230469 -21.828163146972656
		 0 -7.8223943710327148 -14.9488525390625 0 -8.9487190246582031 -21.128017425537109
		 0 -2.5414834022521973 -21.920316696166992 0 -3.626802921295166 -22.402488708496097
		 0 -2.5248379707336426 -20.30150032043457 0 2.4020001888275142 -13.889863967895508
		 0 6.6205868721008301 -20.808750152587891 0 -1.5278722047805786 -16.63264274597168
		 0 -0.60265058279037476 -19.138357162475582 0 -4.4937863349914551 -22.368719100952148
		 0 -8.6199235916137695 -16.077974319458008 0 7.4852128028869629 -22.942913055419918
		 0 6.6544833183288574 -19.267799377441406 0 0.40045469999313354 -15.667280197143556
		 0 8.1297445297241211 -20.36097526550293 0 8.387578010559082 -23.904499053955082 0
		 5.9604644775390625e-008 -20.328548431396484 0 0.78280854225158691 -13.094518661499023
		 0 -2.9220478534698486 -24.395368576049805 0 -5.257868766784668 -21.983438491821289
		 0 -0.94212758541107189 -23.560087203979492 0 -2.3397297859191895 -17.016349792480469
		 0 -4.8030657768249512 -19.202705383300781 0 -5.4929685592651367 -20.904266357421875
		 0 -6.1981840133666992 -19.036314010620117 0 2.7334225177764893 -17.662912368774414
		 0 -3.6000645160675049 -23.330711364746097 0 2.9889085292816162 -23.172374725341797
		 0 -1.2499868869781494 -16.768611907958984 0 4.1454019546508789 -19.912448883056641
		 0 -5.6415472030639648 -23.896852493286133 0 -0.68585443496704102 -21.873199462890625
		 0 -6.8748617172241211 -15.397838592529297 0 1.9073909521102903 -15.169134140014648
		 0 1.3450489044189451 -20.972898483276367 0 8.3007278442382812 -13.111854553222656
		 0 8.4017763137817383 -16.325595855712891 0 5.845395565032959 -14.848733901977541
		 0 -7.3848090171813965 -16.117197036743164 0 1.8042912483215332 -22.602907180786133
		 0 8.8086481094360352 -20.867362976074219 0 0.4979682862758637 -15.199174880981444
		 0 4.4799361228942871 -13.580467224121094 0 -6.040644645690918 -23.515708923339844
		 0 4.8847308158874512 -17.643756866455078 0 1.6174982786178589 -17.261541366577148
		 0 4.6995501518249512 -23.404214859008789 0 -4.0291709899902344 -12.734635353088381
		 0 -7.275761604309082 -16.71245002746582 0 1.5007429122924805 -23.604644775390625
		 0 -8.9463653564453125 -13.504199981689451 0 -1.3779525756835935 -17.758567810058594
		 0 -6.457362174987793 -14.828915596008301 0 -5.5059061050415039 -24.373342514038089
		 0 -6.9279332160949707 -20.30150032043457 0 -3.6030001640319824 -21.283760070800781
		 0 -0.35048913955688477 -21.282787322998047 0 5.5014286041259766 -19.644927978515625
		 0 3.0080838203430176 -17.291830062866211 0 -7.6652126312255859 -15.421957015991213
		 0 -2.9409785270690918 -18.794891357421875 0 7.1735029220581055 -21.83806037902832
		 0 5.2126564979553223 -17.951831817626953 0 6.8737974166870117 -19.084903717041016
		 0 6.3830966949462891 -13.088543891906738 0 5.4509062767028809 -12.577075958251951
		 0 -8.2721900939941406 -22.703498840332031 0 2.4020001888275142 -14.29344367980957
		 0 -4.2009806632995605 -20.701446533203125 0 -6.9236140251159668 -16.073066711425781
		 0 3.7595252990722656 -15.001038551330566 0 -1.1329827308654783 -13.562067985534668
		 0 0.66930639743804932 -12.756424903869627 0 2.3033838272094727 -19.77001953125 0
		 5.7335753440856934 -13.095499038696287 0 -3.6030001640319824 -16.831579208374023
		 0 7.7637372016906738 -14.296499252319336 0 4.8040003776550293 -18.213348388671875
		 0 0.29639995098114014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".vel0" -type "vectorArray" 192 0 0 0 0.0057907101040655254 -0.0002374648906311456
		 -0.0021629332206885067 0 0 0 0.0027923582319999769 -0.00024604795896721108 0.0016522406546926093 -0.0040397641635081631
		 0.00021171570745082062 -0.0095787042630491002 0 0 0 0.0024490354985573569 -0.0001673698325532773
		 0.00043487546236065214 0 0 0 0 0 0 0 0 0 0.0025205610680245692 -0.00040197370040573441
		 -0.0008583068336065503 0 0 0 9.155272891803202e-005 -0.00014019011615573656 0.0060081478352458518 0.0058822628329835581
		 -7.7247615024589498e-005 0.0069236751244261723 0 0 0 -0.001214705335217395 0.00030326841454098106
		 -0.0070953364911474819 0 0 0 0.0055961605551147079 0.00091123575501228754 -0.00022888182229508007 0.0010070800180983523
		 0.00051784512294261861 0.0038337705234425916 0.0013046263870819565 0.00016164778699590031
		 0.00058364864685245418 0 0 0 0 0 0 0 0 0 0.0030212400542950569 -8.4400171971310773e-005
		 0.00025177000452458807 0.0026321409563934209 -0.00046205517875819288 -0.0042457578035737355 0
		 0 0 0.0055618282817704459 -0.00023746493428688869 0.0023117064051803088 0 0 0 0.0022659300407212929
		 0.00090408319806556631 0.0004806518268196682 0.0039482114345901313 0.00056648251018032321
		 0.0050811764549507773 0 0 0 0.0030784605098688267 -0.0002861022778688501 0.0032844541499343991 0
		 0 0 0 0 0 -0.00013160704781967102 -0.00020313261728688357 0.008480071516032717 -0.0010299682003278602
		 9.155272891803202e-005 -0.010047911998754017 0.0028023718117253867 -0.00039196012068032457
		 -0.0028038023231147309 0 0 0 -0.0060424801085901137 0.00047492978126229121 -0.0058364864685245413 -0.0042572018946884895
		 2.4318693618852255e-005 -0.0083885187871146835 0.0014991759360327745 0.00036621091567212808
		 -0.00097846979031146735 0 0 0 0.0015077590043688399 0.0002861022778688501 0.00047492978126229121 0
		 0 0 0 0 0 0.0047163960506679935 -0.00018453599105327985 0.00013732909337704804 0
		 0 0 0.00022888182229508007 -0.00082683558304097677 -0.0009555816080819594 0 0 0 -0.00027465818675409607
		 0.00010013581908196908 -0.0041427609835409489 0 0 0 0.0049209591793442217 -0.00039339028282372426
		 -0.00054931637350819215 -0.0015506743460491673 0.00074672694523769873 -0.0012702941137376943 -0.0015220641182622824
		 0.00057935711268442143 -0.0014533995715737583 0 0 0 0 0 0 -0.0044174191702950451
		 0.00021314619701229333 -0.010316848139950737 0 0 0 0 0 0 0 0 0 -0.0026893614119671908
		 -0.00030469892593032531 -0.0062336238110885667 0 0 0 0 0 0 0 0 0 -0.0021286009473442447
		 0.00019025836402872996 8.0108637803278033e-005 -0.0019226073072786728 0.0004305839281926194
		 -0.00055503841906556913 0 0 0 0.00086514646618685248 0.00015449523004917905 0.0010610818230460978 -0.00083541865137704225
		 -0.00032758710815983336 0.00068664546688524026 -0.0012817382048524485 0.00014019011615573656
		 -0.0082511896937376358 0 0 0 0 0 0 0.0016365050294098226 0.0005207061457213071 -0.00030040739176229257 0.0026035307286065359
		 -0.00049781796349179916 -0.0038223264323278376 0 0 0 0.0039253232523606234 -0.00018882752522131259
		 0.0035161969950081675 0 0 0 0 0 0 0.0031356809654425966 0.00096702569919671338 0.00086975092472130428 -0.0019683836717376887
		 6.8664546688524018e-005 -0.0058135982862950334 0 0 0 0.0010185241092131063 0.00085544581082786181
		 -0.00026321409563934204 0 0 0 0.0023231504962950627 0.00044918057625409466 0.00038909909790163608 0
		 0 0 0.0044288632614097991 -0.00024747847035655533 0.0010528563825573682 0 0 0 0 0
		 0 0.0006179809201967162 0.00034046171066393164 0.0015792845738360527 0 0 0 -0.0018196104872458866
		 -9.155272891803202e-005 -0.0071754451289507606 0 0 0 0 0 0 -0.003730773703409805
		 0.00020599364006557207 -0.0033903119927458738 0 0 0 0 0 0 0 0 0 0.00043487546236065214
		 0.00048923506977870601 0.0030269620998524338 0 0 0 0.0012359618403934324 0.00016164778699590031
		 -0.010505675643344176 0 0 0 0.0031585691476721054 -6.2942501131147018e-005 0.0010757445647868763 0
		 0 0 0 0 0 0 0 0 -0.00075531001357376421 7.7247620481557411e-005 -0.00410270666463931 0
		 0 0 -0.0020484923095409665 0.0010185241092131063 0.00066375728465573221 -0.0017623900316721165
		 -1.4305113893442504e-005 -0.0012359618403934324 0 0 0 -0.0014505385487950698 0.00055503846272131222
		 -0.0022315977673770309 0.0032730100588196451 -0.00018310545783606404 0.0012474059315081864 -0.0027923582319999769
		 -2.7179716397540759e-005 -0.0072898860400983003 -0.003730773703409805 2.8610227786885009e-005
		 -0.0081481928737048501 0.00099563592698359831 7.7247615024589498e-005 -0.0016250609382950686 0
		 0 0 0 0 0 0 0 0 0.0018081663961311326 -0.00013589823274175913 0.0019111632161639188 0
		 0 0 0 0 0 0.00036621091567212808 0.00058078762407376568 -0.00062942501131147018 0
		 0 0 0.0023574827696393246 -0.00044918057625409466 3.4332273344262009e-005 0.0027923582319999769
		 -0.00059795410999184131 -0.0021858214029180146 0.0029067991431475167 -1.2874602504098254e-005
		 0.0094528192607868065 0 0 0 0 0 0 0 0 0 -0.0016937254849835927 0.00030612943731966961
		 -0.0016479491205245765 0.0016479491205245765 0.00080537791220081307 0.0060596462452622447 -0.0034332273344262012
		 0.00021314637163526566 -0.003707885521180297 0 0 0 0 0 0 0 0 0 0.0030269620998524338
		 -0.00020742415145491631 0.0062198635208688003 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 -0.00051498410016393012 0.0001673698325532773 -0.0050525662271638924 0
		 0 0 0 0 0 0 0 0 0.0010242461547704832 -0.00013017636180735444 0.0057678219218360175 -0.00035190580177868561
		 0.00061798096385245929 -0.0015563963916065443 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 192 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "additiveAnimation_startup";
	setAttr ".mas0" -type "doubleArray" 192 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 192 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97
		 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
		 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139
		 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160
		 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181
		 182 183 184 185 186 187 188 189 190 191 ;
	setAttr ".nid" 192;
	setAttr ".nid0" 192;
	setAttr ".bt0" -type "doubleArray" 192 -27.291666666666664 -27.291666666666664
		 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664
		 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664
		 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664
		 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664 -27.291666666666664
		 -27.291666666666664 -27.291666666666664 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652
		 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 -7.2916666666666652 ;
	setAttr ".ag0" -type "doubleArray" 192 27.333333333333332 27.333333333333332 27.333333333333332
		 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332
		 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332
		 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332
		 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332 27.333333333333332
		 27.333333333333332 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333
		 7.333333333333333 7.333333333333333 7.333333333333333 7.333333333333333 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 500;
	setAttr ".initDirection0" -type "vectorArray" 192 0.96644854545593262 0 0.25686019659042358 0.92084133625030506
		 0 -0.38993743062019343 0.96924513578414917 0 -0.24609731137752533 0.98181247711181652
		 0 0.18985311686992645 0.99337494373321533 0 0.11491855978965761 0.97285926342010498
		 0 0.23139755427837372 0.97508865594863892 0 -0.22181542217731476 0.91700285673141468
		 0 -0.39888066053390503 0.8952406644821167 0 0.44558292627334595 0.98427939414978027
		 0 -0.17661838233470917 0.94422525167465199 0 0.32930022478103638 0.92571598291397084
		 0 0.37821948528289789 0.9629700779914856 0 0.26960837841033936 0.94099467992782593
		 0 -0.33842143416404724 0.93015581369400036 0 0.36716499924659729 0.94818669557571411
		 0 0.31771361827850342 0.99570363759994507 0 -0.092597596347332001 0.99053806066513062
		 0 -0.13723832368850708 0.99248045682907104 0 0.122403122484684 0.93163061141967773
		 0 -0.36340662837028503 0.92643892765045166 0 0.37644517421722418 0.94574028253555298
		 0 0.32492351531982422 0.99612855911254883 0 0.087908521294593811 0.99580252170562755
		 0 0.091528080403804779 0.99991810321807861 0 -0.012799064628779888 0.99370336532592773
		 0 0.11204285174608232 0.98714393377304077 0 0.15983389317989349 0.99229788780212402
		 0 -0.12387432903051376 0.99738299846649148 0 -0.072299197316169739 0.9987453818321228
		 0 -0.050076186656951904 0.98587304353713989 0 0.16749422252178192 0.92530691623687744
		 0 -0.37921905517578131 0.98475855588912964 0 -0.17392699420452118 0.93472033739089966
		 0 -0.35538417100906372 0.95728355646133423 0 0.28915080428123474 0.97632020711898804
		 0 0.21633031964302063 0.95608013868331909 0 -0.29310545325279236 0.90904676914215088
		 0 -0.41669416427612305 0.9789571762084962 0 -0.20406579971313477 0.91639238595962524
		 0 -0.40028119087219238 0.99565005302429199 0 0.093171596527099609 0.90099388360977173
		 0 0.4338318407535553 0.99516803026199341 0 0.098186500370502458 0.99776065349578869
		 0 -0.066885478794574738 0.89824235439300548 0 -0.43950051069259649 0.92907339334487915
		 0 -0.36989536881446838 0.99506372213363647 0 -0.099238254129886627 0.9791419506072998
		 0 -0.20317739248275757 0.96169453859329213 0 0.27412325143814087 0.95854097604751587
		 0 0.28495469689369202 0.98093879222869873 0 0.19431695342063904 0.89543765783309937
		 0 0.44518694281578064 0.94230806827545166 0 -0.33474692702293396 0.98067164421081532
		 0 -0.19566060602664948 0.96664452552795388 0 0.25612184405326843 0.9614081382751466
		 0 0.27512624859809875 0.95948481559753429 0 -0.28176027536392212 0.98974072933197021
		 0 -0.14287492632865906 0.91482573747634877 0 0.40384882688522333 0.93536740541458108
		 0 -0.35367763042449951 0.97087424993515004 0 0.23958975076675415 0.89435213804244995
		 0 -0.44736364483833313 0.95960444211959839 0 -0.28135260939598083 0.99345523118972789
		 0 -0.11422222107648848 0.92397302389144897 0 -0.38245770335197449 0.95881962776184082
		 0 -0.28401574492454529 0.97511547803878784 0 0.22169755399227145 0.99559921026229858
		 0 0.093713290989398956 0.96130490303039551 0 0.27548655867576599 0.99972617626190197
		 0 -0.023399274796247479 0.91508281230926514 0 -0.40326595306396479 0.98489660024642944
		 0 0.17314368486404419 0.97399896383285522 0 0.2265525758266449 0.92468357086181652
		 0 -0.38073655962944031 0.98057758808135986 0 -0.19613148272037503 0.92929494380950928
		 0 0.36933842301368713 0.89846104383468628 0 0.43905329704284674 0.90525776147842396
		 0 -0.42486274242401117 0.98619747161865234 0 0.16557353734970093 0.95343124866485596
		 0 0.30161049962043762 0.95222395658493042 0 0.30540063977241516 0.99965965747833252
		 0 0.026087574660778049 0.95807605981826782 0 0.28651407361030579 0.99396538734436035
		 0 0.1096939817070961 0.99249225854873668 0 -0.12230752408504486 0.99988543987274159
		 0 0.015136768110096456 0.99971097707748413 0 -0.024040203541517258 0.99772483110427856
		 0 -0.067417621612548828 0.89253753423690796 0 -0.4509731531143189 0.99145370721817028
		 0 -0.13045895099639893 0.90947562456130981 0 0.41575720906257629 0.955100417137146
		 0 0.2962823212146759 0.95918780565261841 0 -0.28276985883712769 0.96654021739959717
		 0 -0.25651523470878601 0.95923388004302979 0 -0.28261345624923706 0.99995815753936768
		 0 0.0091500515118241327 0.95270758867263794 0 -0.30388849973678589 0.99974370002746571
		 0 0.022638922557234764 0.94490635395050049 0 0.3273407518863678 0.91662526130676292
		 0 0.3997475802898407 0.99961572885513317 0 -0.027720388025045395 0.99998784065246571
		 0 -0.0049363491125404835 0.98658448457717884 0 -0.16325166821479797 0.99786698818206787
		 0 -0.065280385315418243 0.94350844621658325 0 0.33134850859642029 0.98546147346496571
		 0 0.16989898681640625 0.96526718139648438 0 -0.26126474142074585 0.9424949884414674
		 0 0.33422026038169861 0.90003758668899536 0 0.43581223487853998 0.99999696016311646
		 0 0.0024735028855502605 0.99386411905288707 0 0.11060796678066254 0.97960293292999268
		 0 0.20094302296638489 0.96643340587615967 0 0.2569173276424408 0.98869693279266357
		 0 -0.14992775022983551 0.94872534275054932 0 -0.3161015510559082 0.99977284669876099
		 0 -0.021312443539500237 0.99558520317077637 0 -0.093862354755401611 0.97759509086608876
		 0 -0.21049413084983823 0.90632939338684082 0 0.42257186770439154 0.95107352733612061
		 0 0.30896463990211487 0.99655997753143311 0 0.082874417304992676 0.95493894815444946
		 0 -0.29680237174034119 0.99818372726440452 0 0.060243260115385056 0.97389596700668335
		 0 -0.22699491679668429 0.99987208843231201 0 -0.015994017943739891 0.99968671798706044
		 0 -0.02502862736582756 0.98976683616638172 0 -0.14269416034221649 0.95242094993591309
		 0 -0.30478578805923462 0.94430565834045388 0 -0.32906970381736755 0.98903489112854004
		 0 -0.14768210053443909 0.9939720630645752 0 0.10963378846645357 0.98367112874984741
		 0 -0.1799752414226532 0.98724406957626332 0 -0.15921416878700256 0.95782375335693359
		 0 -0.28735637664794922 0.98950815200805664 0 -0.14447721838951111 0.94456595182418812
		 0 -0.32832169532775879 0.9113929271697998 0 -0.41153725981712341 0.96602791547775269
		 0 0.25843775272369385 0.99997818470001221 0 0.0066076354123651981 0.91432666778564453
		 0 0.4049774706363678 0.97206521034240723 0 0.23471097648143768 0.97338199615478516
		 0 0.22918881475925448 0.91490948200225841 0 0.40365907549858093 0.95811468362808228
		 0 0.28638479113578796 0.94790196418762207 0 0.31856215000152588 0.99777179956436157
		 0 -0.066719435155391693 0.96616983413696289 0 -0.25790658593177795 0.99741190671920765
		 0 0.071899458765983582 0.99351757764816284 0 0.11367885023355484 0.96680629253387451
		 0 0.2555103600025177 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".entityType0" -type "doubleArray" 192 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 192 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".rgbPP0" -type "vectorArray" 192 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".entityRadius0" -type "doubleArray" 192 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".groupEntityId0" -type "doubleArray" 192 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 192 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 ;
	setAttr ".glmEntityId0" -type "doubleArray" 192 10001 11001 12001 13001 14001
		 15001 16001 17001 18001 19001 20001 21001 22001 23001 24001 25001 26001 27001 28001
		 29001 30001 31001 32001 33001 34001 35001 36001 37001 38001 39001 40001 41001 42001
		 43001 44001 45001 46001 47001 48001 49001 50001 51001 52001 53001 54001 55001 56001
		 57001 58001 59001 60001 61001 62001 63001 64001 65001 66001 67001 68001 69001 70001
		 71001 72001 73001 74001 75001 76001 77001 78001 79001 80001 81001 82001 83001 84001
		 85001 86001 87001 88001 89001 90001 91001 92001 93001 94001 95001 96001 97001 98001
		 99001 100001 101001 102001 103001 104001 105001 106001 107001 108001 109001 110001
		 111001 112001 113001 114001 115001 116001 117001 118001 119001 120001 121001 122001
		 123001 124001 125001 126001 127001 128001 129001 130001 131001 132001 133001 134001
		 135001 136001 137001 138001 139001 140001 141001 142001 143001 144001 145001 146001
		 147001 148001 149001 150001 151001 152001 153001 154001 155001 156001 157001 158001
		 159001 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
	setAttr ".glmInitDirection0" -type "vectorArray" 192 0.99994981288909923 0 0.010020000860095024 0.99537402391433716
		 0 0.096075795590877533 0.96790075302124012 0 -0.25133264064788818 0.98614645004272461
		 0 0.1658768504858017 0.93473440408706676 0 0.35534718632698059 0.9280739426612854
		 0 0.37239596247673035 0.94506943225860596 0 -0.32686963677406311 0.92845356464385986
		 0 -0.37144848704338074 0.98564571142196655 0 0.16882704198360443 0.90194696187973022
		 0 0.43184676766395569 0.91536515951156605 0 0.40262463688850397 0.99438273906707764
		 0 0.1058441400527954 0.96965199708938588 0 0.24448929727077484 0.95325195789337147
		 0 -0.30217671394348145 0.89671695232391357 0 0.44260445237159729 0.96353054046630859
		 0 0.26759842038154602 0.91719263792037964 0 -0.39844402670860291 0.96320140361785889
		 0 -0.26878061890602112 0.96866434812545776 0 0.24837352335453031 0.90893334150314331
		 0 0.41694143414497375 0.97477751970291138 0 0.22317869961261749 0.9633128046989442
		 0 -0.26838123798370361 0.97530329227447521 0 0.22086982429027557 0.95816242694854736
		 0 -0.28622511029243469 0.99181556701660156 0 -0.12767884135246277 0.99981021881103516
		 0 0.019482484087347984 0.99789953231811523 0 -0.064780533313751221 0.96912133693695068
		 0 -0.24658440053462985 0.99704545736312866 0 0.076813928782939911 0.9177435040473938
		 0 0.39717355370521545 0.95406824350357056 0 -0.29958945512771606 0.99621313810348511
		 0 -0.086944490671157837 0.9342796802520752 0 -0.35654094815254211 0.99462926387786865
		 0 -0.10350198298692705 0.9509260058403014 0 0.30941835045814514 0.91906410455703724
		 0 -0.39410805702209473 0.99969267845153809 0 -0.024789091199636459 0.99787229299545277
		 0 -0.06519925594329834 0.93917614221572876 0 0.34343576431274414 0.96609789133071899
		 0 0.25817608833312988 0.91997170448303212 0 -0.39198482036590576 0.93868482112884533
		 0 -0.344776451587677 0.99844437837600708 0 0.055756401270627975 0.99999016523361195
		 0 0.004428523126989603 0.99907898902893078 0 0.042908754199743271 0.99258285760879517
		 0 0.1215701624751091 0.89136672019958496 0 -0.45328283309936518 0.98076981306076028
		 0 -0.19516818225383761 0.907035231590271 0 0.42105478048324585 0.91400116682052612
		 0 0.40571153163909912 0.98884290456771851 0 -0.14896193146705627 0.99916344881057739
		 0 -0.040894459933042526 0.96082431077957153 0 0.27715808153152466 0.91020190715789795
		 0 0.41416478157043457 0.99604636430740356 0 -0.088834717869758606 0.99986219406127919
		 0 0.016601428389549255 0.97624760866165172 0 0.21665781736373901 0.95968341827392578
		 0 -0.28108307719230652 0.99145001173019409 0 -0.13048708438873291 0.97513633966445923
		 0 -0.22160571813583377 0.95994478464126587 0 0.28018924593925476 0.98690074682235707
		 0 0.16132867336273193 0.98274284601211548 0 -0.1849769651889801 0.9984496831893922
		 0 0.055661894381046295 0.99777805805206299 0 0.066624991595745087 0.92578917741775524
		 0 0.37804025411605829 0.97233206033706676 0 0.23360301554203031 0.95141524076461792
		 0 -0.3079107403755188 0.99079459905624401 0 0.13537357747554779 0.90551185607910156
		 0 -0.42432093620300299 0.98191273212432861 0 -0.18933412432670593 0.98104023933410645
		 0 0.19380427896976471 0.92183268070220947 0 0.38758811354637146 0.99690061807632446
		 0 -0.078671053051948547 0.99945932626724243 0 -0.032879061996936798 0.93202388286590576
		 0 -0.36239689588546753 0.9972878098487854 0 -0.073600590229034438 0.99614763259887695
		 0 0.087691925466060638 0.98859471082687378 0 0.15060047805309296 0.92631077766418468
		 0 -0.376760333776474 0.99388068914413452 0 0.11045891791582108 0.99288678169250499
		 0 -0.11906222999095915 0.95572495460510254 0 0.2942613959312439 0.99989563226699829
		 0 0.014448529109358788 0.95970100164413452 0 0.28102314472198486 0.9486101269721986
		 0 0.31644716858863831 0.99125903844833374 0 -0.13193003833293915 0.89106500148773204
		 0 -0.45387566089630127 0.97061026096344005 0 0.24065692722797391 0.97887849807739269
		 0 0.20444296300411224 0.99999648332595825 0 -0.0026561308186501265 0.98916542530059803
		 0 -0.14680509269237518 0.99564403295516957 0 -0.093235932290554047 0.94478398561477661
		 0 0.32769376039505005 0.90859764814376831 0 0.41767245531082153 0.93530589342117332
		 0 -0.35384020209312439 0.99132084846496571 0 -0.13146491348743439 0.99557423591613758
		 0 -0.093978665769100189 0.99624514579772949 0 0.086577042937278748 0.92789030075073253
		 0 0.37285327911376953 0.95965790748596191 0 0.28117024898529053 0.95283776521682739
		 0 0.30348005890846252 0.96166610717773438 0 -0.27422299981117249 0.98981541395187378
		 0 0.14235670864582062 0.94859695434570324 0 0.31648674607276917 0.96792787313461315
		 0 -0.25122833251953125 0.98796379566192627 0 0.15468525886535645 0.99924522638320923
		 0 0.038845926523208618 0.89476239681243908 0 -0.44654250144958496 0.98588383197784413
		 0 0.16743075847625732 0.99942022562026978 0 0.034046895802021027 0.99924951791763317
		 0 0.038735147565603256 0.99696183204650879 0 -0.077891677618026733 0.9595181941986084
		 0 0.28164657950401306 0.90436154603958108 0 -0.42676714062690735 0.97619527578353893
		 0 -0.21689359843730929 0.98230439424514771 0 0.18729136884212497 0.98450893163681041
		 0 0.17533434927463531 0.96860396862030029 0 -0.2486088424921036 0.99617677927017212
		 0 -0.087360374629497542 0.96965861320495605 0 -0.24446295201778412 0.91592735052108765
		 0 0.40134406089782709 0.97630453109741211 0 -0.21640108525753021 0.92101120948791504
		 0 0.389536052942276 0.99927109479904175 0 0.038173846900463104 0.98136818408966064
		 0 -0.19213654100894928 0.91426610946655285 0 -0.40511414408683777 0.92134779691696156
		 0 0.38873925805091858 0.98816615343093872 0 -0.15338724851608276 0.92470359802246094
		 0 -0.38068783283233643 0.985512375831604 0 -0.16960364580154419 0.94102948904037476
		 0 0.33832451701164246 0.99645620584487915 0 -0.084112957119941711 0.9909200668334962
		 0 0.13445223867893219 0.93549442291259755 0 -0.35334151983261108 0.96589952707290661
		 0 -0.25891724228858948 0.93707484006881714 0 0.34912854433059692 0.99983566999435425
		 0 -0.018127791583538055 0.99556553363800049 0 0.094070523977279663 0.99101567268371582
		 0 -0.13374558091163635 0.94767594337463379 0 -0.31923395395278931 0.94643688201904308
		 0 0.32288891077041626 0.9260953664779662 0 -0.37728944420814514 0.99462401866912853
		 0 -0.10355249047279358 0.99965214729309093 0 -0.026373578235507011 0.98087459802627563
		 0 0.1946408599615097 0.90855783224105835 0 -0.41775912046432495 0.99895823001861572
		 0 -0.045634541660547256 0.9592779278755188 0 -0.28246387839317322 0.90616673231124878
		 0 -0.4229205846786499 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".glmEntityType0" -type "doubleArray" 192 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".radiusPP0" -type "doubleArray" 192 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".populationGroupId0" -type "doubleArray" 192 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".glmGroupId0" -type "doubleArray" 192 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
createNode transform -n "standingRandomPopTool" -p "standingRandom";
	setAttr ".t" -type "double3" -18.5 0 0 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "standingRandomPopToolShape" -p "standingRandomPopTool";
	setAttr -k off ".v";
	setAttr ".np" 192;
	setAttr ".npp" 150;
	setAttr ".dst" 1.2;
	setAttr ".n" 10;
	setAttr ".on" 0.15;
	setAttr ".nr" 15;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "standingRandomParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 150 -22.853368759155273 0 -6.7534470558166504 -18.304723739624023
		 0 -7.1569700241088867 -16.69849967956543 0 -3.6030001640319824 -18.229852676391602
		 0 -4.7092113494873047 -22.241338729858398 0 1.4639781713485718 -18.584686279296875
		 0 -8.2778558731079102 -19.100500106811523 0 4.8040003776550293 -24.271736145019531
		 0 8.487579345703125 -14.195436477661133 0 -5.3593330383300781 -24.489959716796875
		 0 6.966031551361084 -13.505473136901855 0 -4.3947300910949707 -14.930551528930664
		 0 6.125007152557373 -16.060060501098633 0 -6.0304164886474609 -18.47210693359375
		 0 3.0850656032562256 -12.689811706542969 0 6.7072267532348633 -19.266374588012695
		 0 -1.6086506843566895 -22.878822326660156 0 -4.5088353157043457 -20.913021087646484
		 0 1.4010829925537109 -16.211750030517578 0 -8.3522872924804687 -17.153396606445313
		 0 8.3199739456176758 -22.18358039855957 0 6.1351914405822754 -20.586675643920898
		 0 4.1783480644226074 -17.132369995117188 0 -5.9221129417419434 -17.899499893188477
		 0 8.4070005416870117 -20.619403839111328 0 -2.8955950736999512 -14.317937850952148
		 0 -1.7291711568832397 -16.058887481689453 0 -3.9451954364776611 -22.574682235717773
		 0 -3.7300703525543213 -18.870695114135742 0 -6.8977537155151367 -18.051727294921875
		 0 -2.8740799427032471 -24.034524917602539 0 -6.3372249603271484 -21.275123596191406
		 0 -5.2915463447570801 -14.722883224487305 0 -8.0069131851196289 -14.188756942749023
		 0 -2.6261200904846191 -13.095499038696289 0 4.8040003776550293 -22.093545913696289
		 0 2.1462745666503906 -19.584211349487305 0 -3.2026665210723877 -17.85594367980957
		 0 5.8232240676879883 -19.182666778564453 0 -2.6826527118682861 -16.360416412353516
		 0 0.58860874176025391 -13.258289337158203 0 4.044501781463623 -17.391422271728516
		 0 -8.7930812835693359 -23.699127197265625 0 3.5294966697692871 -20.653942108154297
		 0 -7.8112859725952148 -21.988374710083008 0 3.1483421325683594 -19.922080993652344
		 0 6.9068126678466797 -23.294160842895508 0 0.059956192970275879 -22.19880485534668
		 0 -6.3500442504882812 -14.919191360473633 0 -6.7099752426147461 -15.370504379272461
		 0 -5.1521835327148437 -22.703498840332031 0 4.8040003776550293 -13.819036483764648
		 0 5.7512097358703613 -23.382469177246094 0 1.656907320022583 -14.19920539855957 0
		 0.1585058718919754 -24.351280212402344 0 6.1446661949157715 -15.552132606506348 0
		 0.13541121780872345 -18.148168563842773 0 5.2374963760375977 -20.577398300170898
		 0 -5.1340198516845703 -22.782810211181641 0 4.1316976547241211 -18.406776428222656
		 0 2.4415929317474365 -18.658260345458984 0 8.4891767501831055 -13.833686828613281
		 0 1.370506763458252 -14.456893920898437 0 1.8645133972167969 -12.664668083190918
		 0 0.23169665038585663 -14.634777069091797 0 3.038095235824585 -19.812068939208984
		 0 5.1227154731750488 -18.471515655517578 0 -1.7266387939453125 -21.952980041503906
		 0 7.3973503112792969 -13.824783325195313 0 8.3238363265991211 -16.57530403137207
		 0 -2.8505079746246338 -19.100500106811523 0 1.2010002136230469 -21.828163146972656
		 0 -7.8223943710327148 -14.9488525390625 0 -8.9487190246582031 -21.128017425537109
		 0 -2.5414834022521973 -21.920316696166992 0 -3.626802921295166 -22.402488708496094
		 0 -2.5248379707336426 -20.30150032043457 0 2.4020001888275146 -13.889863967895508
		 0 6.6205868721008301 -20.808750152587891 0 -1.5278722047805786 -16.63264274597168
		 0 -0.60265058279037476 -19.138357162475586 0 -4.4937863349914551 -22.368719100952148
		 0 -8.6199235916137695 -16.077974319458008 0 7.4852128028869629 -22.942913055419922
		 0 6.6544833183288574 -19.267799377441406 0 0.40045469999313354 -15.667280197143555
		 0 8.1297445297241211 -20.36097526550293 0 8.387578010559082 -23.904499053955078 0
		 5.9604644775390625e-008 -20.328548431396484 0 0.78280854225158691 -13.094518661499023
		 0 -2.9220478534698486 -24.395368576049805 0 -5.257868766784668 -21.983438491821289
		 0 -0.94212758541107178 -23.560087203979492 0 -2.3397297859191895 -17.016349792480469
		 0 -4.8030657768249512 -19.202705383300781 0 -5.4929685592651367 -20.904266357421875
		 0 -6.1981840133666992 -19.036314010620117 0 2.7334225177764893 -17.662912368774414
		 0 -3.6000645160675049 -23.330711364746094 0 2.9889085292816162 -23.172374725341797
		 0 -1.2499868869781494 -16.768611907958984 0 4.1454019546508789 -19.912448883056641
		 0 -5.6415472030639648 -23.896852493286133 0 -0.68585443496704102 -21.873199462890625
		 0 -6.8748617172241211 -15.397838592529297 0 1.9073909521102905 -15.169134140014648
		 0 1.3450489044189453 -20.972898483276367 0 8.3007278442382812 -13.111854553222656
		 0 8.4017763137817383 -16.325595855712891 0 5.845395565032959 -14.848733901977539
		 0 -7.3848090171813965 -16.117197036743164 0 1.8042912483215332 -22.602907180786133
		 0 8.8086481094360352 -20.867362976074219 0 0.49796828627586365 -15.199174880981445
		 0 4.4799361228942871 -13.580467224121094 0 -6.040644645690918 -23.515708923339844
		 0 4.8847308158874512 -17.643756866455078 0 1.6174982786178589 -17.261541366577148
		 0 4.6995501518249512 -23.404214859008789 0 -4.0291709899902344 -12.734635353088379
		 0 -7.275761604309082 -16.71245002746582 0 1.5007429122924805 -23.604644775390625
		 0 -8.9463653564453125 -13.504199981689453 0 -1.3779525756835937 -17.758567810058594
		 0 -6.457362174987793 -14.828915596008301 0 -5.5059061050415039 -24.373342514038086
		 0 -6.9279332160949707 -20.30150032043457 0 -3.6030001640319824 -21.283760070800781
		 0 -0.35048913955688477 -21.282787322998047 0 5.5014286041259766 -19.644927978515625
		 0 3.0080838203430176 -17.291830062866211 0 -7.6652126312255859 -15.421957015991211
		 0 -2.9409785270690918 -18.794891357421875 0 7.1735029220581055 -21.83806037902832
		 0 5.2126564979553223 -17.951831817626953 0 6.8737974166870117 -19.084903717041016
		 0 6.3830966949462891 -13.088543891906738 0 5.4509062767028809 -12.577075958251953
		 0 -8.2721900939941406 -22.703498840332031 0 2.4020001888275146 -14.29344367980957
		 0 -4.2009806632995605 -20.701446533203125 0 -6.9236140251159668 -16.073066711425781
		 0 3.7595252990722656 -15.001038551330566 0 -1.1329827308654785 -13.562067985534668
		 0 0.66930639743804932 -12.756424903869629 0 2.3033838272094727 -19.77001953125 0
		 5.7335753440856934 -13.095499038696289 0 -3.6030001640319824 -16.831579208374023
		 0 7.7637372016906738 -14.296499252319336 0 4.8040003776550293 -18.213348388671875
		 0 0.29639995098114014 ;
	setAttr ".pto" -type "vectorArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 150 0.99994981288909912 0 0.010020000860095024 0.99537402391433716
		 0 0.096075795590877533 0.96790075302124023 0 -0.25133264064788818 0.98614645004272461
		 0 0.1658768504858017 0.93473440408706665 0 0.35534718632698059 0.9280739426612854
		 0 0.37239596247673035 0.94506943225860596 0 -0.32686963677406311 0.92845356464385986
		 0 -0.37144848704338074 0.98564571142196655 0 0.16882704198360443 0.90194696187973022
		 0 0.43184676766395569 0.91536515951156616 0 0.40262463688850403 0.99438273906707764
		 0 0.10584414005279541 0.96965199708938599 0 0.24448929727077484 0.95325195789337158
		 0 -0.30217671394348145 0.89671695232391357 0 0.44260445237159729 0.96353054046630859
		 0 0.26759842038154602 0.91719263792037964 0 -0.39844402670860291 0.96320140361785889
		 0 -0.26878061890602112 0.96866434812545776 0 0.24837352335453033 0.90893334150314331
		 0 0.41694143414497375 0.97477751970291138 0 0.22317869961261749 0.96331280469894409
		 0 -0.26838123798370361 0.9753032922744751 0 0.22086982429027557 0.95816242694854736
		 0 -0.28622511029243469 0.99181556701660156 0 -0.12767884135246277 0.99981021881103516
		 0 0.019482484087347984 0.99789953231811523 0 -0.064780533313751221 0.96912133693695068
		 0 -0.24658440053462982 0.99704545736312866 0 0.076813928782939911 0.9177435040473938
		 0 0.39717355370521545 0.95406824350357056 0 -0.29958945512771606 0.99621313810348511
		 0 -0.086944490671157837 0.9342796802520752 0 -0.35654094815254211 0.99462926387786865
		 0 -0.10350198298692703 0.95092600584030151 0 0.30941835045814514 0.91906410455703735
		 0 -0.39410805702209473 0.99969267845153809 0 -0.024789091199636459 0.99787229299545288
		 0 -0.06519925594329834 0.93917614221572876 0 0.34343576431274414 0.96609789133071899
		 0 0.25817608833312988 0.91997170448303223 0 -0.39198482036590576 0.93868482112884521
		 0 -0.344776451587677 0.99844437837600708 0 0.055756401270627975 0.99999016523361206
		 0 0.004428523126989603 0.99907898902893066 0 0.042908754199743271 0.99258285760879517
		 0 0.1215701624751091 0.89136672019958496 0 -0.45328283309936523 0.9807698130607605
		 0 -0.19516818225383759 0.907035231590271 0 0.42105478048324585 0.91400116682052612
		 0 0.40571153163909912 0.98884290456771851 0 -0.14896193146705627 0.99916344881057739
		 0 -0.040894459933042526 0.96082431077957153 0 0.27715808153152466 0.91020190715789795
		 0 0.41416478157043457 0.99604636430740356 0 -0.088834717869758606 0.9998621940612793
		 0 0.016601428389549255 0.97624760866165161 0 0.21665781736373901 0.95968341827392578
		 0 -0.28108307719230652 0.99145001173019409 0 -0.13048708438873291 0.97513633966445923
		 0 -0.22160571813583374 0.95994478464126587 0 0.28018924593925476 0.98690074682235718
		 0 0.16132867336273193 0.98274284601211548 0 -0.1849769651889801 0.99844968318939209
		 0 0.055661894381046295 0.99777805805206299 0 0.066624991595745087 0.92578917741775513
		 0 0.37804025411605835 0.97233206033706665 0 0.23360301554203033 0.95141524076461792
		 0 -0.3079107403755188 0.9907945990562439 0 0.13537357747554779 0.90551185607910156
		 0 -0.42432093620300293 0.98191273212432861 0 -0.18933412432670593 0.98104023933410645
		 0 0.19380427896976471 0.92183268070220947 0 0.38758811354637146 0.99690061807632446
		 0 -0.078671053051948547 0.99945932626724243 0 -0.032879061996936798 0.93202388286590576
		 0 -0.36239689588546753 0.9972878098487854 0 -0.073600590229034424 0.99614763259887695
		 0 0.087691925466060638 0.98859471082687378 0 0.15060047805309296 0.92631077766418457
		 0 -0.376760333776474 0.99388068914413452 0 0.11045891791582108 0.99288678169250488
		 0 -0.11906222999095917 0.95572495460510254 0 0.2942613959312439 0.99989563226699829
		 0 0.014448529109358788 0.95970100164413452 0 0.28102314472198486 0.94861012697219849
		 0 0.31644716858863831 0.99125903844833374 0 -0.13193003833293915 0.89106500148773193
		 0 -0.45387566089630127 0.97061026096343994 0 0.24065692722797394 0.97887849807739258
		 0 0.20444296300411224 0.99999648332595825 0 -0.0026561308186501265 0.98916542530059814
		 0 -0.14680509269237518 0.99564403295516968 0 -0.093235932290554047 0.94478398561477661
		 0 0.32769376039505005 0.90859764814376831 0 0.41767245531082153 0.9353058934211731
		 0 -0.35384020209312439 0.99132084846496582 0 -0.13146491348743439 0.9955742359161377
		 0 -0.093978665769100189 0.99624514579772949 0 0.086577042937278748 0.92789030075073242
		 0 0.37285327911376953 0.95965790748596191 0 0.28117024898529053 0.95283776521682739
		 0 0.30348005890846252 0.96166610717773438 0 -0.27422299981117249 0.98981541395187378
		 0 0.14235670864582062 0.94859695434570313 0 0.31648674607276917 0.96792787313461304
		 0 -0.25122833251953125 0.98796379566192627 0 0.15468525886535645 0.99924522638320923
		 0 0.038845926523208618 0.89476239681243896 0 -0.44654250144958496 0.98588383197784424
		 0 0.16743075847625732 0.99942022562026978 0 0.034046895802021027 0.99924951791763306
		 0 0.038735147565603256 0.99696183204650879 0 -0.077891677618026733 0.9595181941986084
		 0 0.28164657950401306 0.9043615460395813 0 -0.42676714062690735 0.97619527578353882
		 0 -0.21689359843730927 0.98230439424514771 0 0.18729136884212494 0.9845089316368103
		 0 0.17533434927463531 0.96860396862030029 0 -0.24860884249210358 0.99617677927017212
		 0 -0.087360374629497528 0.96965861320495605 0 -0.24446295201778412 0.91592735052108765
		 0 0.40134406089782715 0.97630453109741211 0 -0.21640108525753021 0.92101120948791504
		 0 0.389536052942276 0.99927109479904175 0 0.038173846900463104 0.98136818408966064
		 0 -0.19213654100894928 0.91426610946655273 0 -0.40511414408683777 0.92134779691696167
		 0 0.38873925805091858 0.98816615343093872 0 -0.15338724851608276 0.92470359802246094
		 0 -0.38068783283233643 0.985512375831604 0 -0.16960364580154419 0.94102948904037476
		 0 0.33832451701164246 0.99645620584487915 0 -0.084112957119941711 0.99092006683349609
		 0 0.13445223867893219 0.93549442291259766 0 -0.35334151983261108 0.96589952707290649
		 0 -0.25891724228858948 0.93707484006881714 0 0.34912854433059692 0.99983566999435425
		 0 -0.018127791583538055 0.99556553363800049 0 0.094070523977279663 0.99101567268371582
		 0 -0.13374558091163635 0.94767594337463379 0 -0.31923395395278931 0.94643688201904297
		 0 0.32288891077041626 0.92609536647796631 0 -0.37728944420814514 0.99462401866912842
		 0 -0.10355249047279358 0.99965214729309082 0 -0.026373578235507011 0.98087459802627563
		 0 0.1946408599615097 0.90855783224105835 0 -0.41775912046432495 0.99895823001861572
		 0 -0.045634541660547256 0.9592779278755188 0 -0.28246387839317322 0.90616673231124878
		 0 -0.4229205846786499 ;
	setAttr ".poo" -type "doubleArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 150 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 150 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
		 8 8 8 8 8 8 8 ;
	setAttr ".get" -type "doubleArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 150 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97
		 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
		 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139
		 140 141 142 143 144 145 146 147 148 149 150 ;
	setAttr ".etc" -type "vectorArray" 150 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1
		 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "standingRandomAnnotation" -p "standingRandom";
	setAttr ".t" -type "double3" -18.362655126820151 0 0 ;
createNode locator -n "standingRandomAnnotationShape" -p "standingRandomAnnotation";
	setAttr -k off ".v";
createNode transform -n "annotation10" -p "standingRandomAnnotation";
	setAttr ".t" -type "double3" 0.58031712503576927 3.2974347958703705 -0.21030507870501997 ;
createNode annotationShape -n "annotationShape10" -p "annotation10";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 14;
	setAttr ".txt" -type "string" "Standing animation blended additively with plenty of addtive animations played randomly (see BehaviorEditor)";
createNode transform -n "rendererAnnotation";
	setAttr ".t" -type "double3" -18.363 0.018014528872182911 0.024900434940362093 ;
createNode locator -n "rendererAnnotationShape" -p "|rendererAnnotation";
	setAttr -k off ".v";
createNode transform -n "rendererAnnotation" -p "|rendererAnnotation";
	setAttr ".t" -type "double3" 3.433725991912997 4.0860188265082469 0.25627173845537898 ;
createNode annotationShape -n "rendererAnnotationShape" -p "|rendererAnnotation|rendererAnnotation";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 16;
	setAttr ".txt" -type "string" "Select a renderer in the configuration dialog in order to load shaders and create a rendering proxy";
createNode mentalrayItemsList -s -n "mentalrayItemsList";
createNode mentalrayGlobals -s -n "mentalrayGlobals";
createNode mentalrayOptions -s -n "miDefaultOptions";
	addAttr -ci true -m -sn "stringOptions" -ln "stringOptions" -at "compound" -nc 
		3;
	addAttr -ci true -sn "name" -ln "name" -dt "string" -p "stringOptions";
	addAttr -ci true -sn "value" -ln "value" -dt "string" -p "stringOptions";
	addAttr -ci true -sn "type" -ln "type" -dt "string" -p "stringOptions";
	setAttr ".splck" yes;
	setAttr ".fil" 0;
	setAttr ".filw" 1;
	setAttr ".filh" 1;
	setAttr ".rflr" 1;
	setAttr ".rfrr" 1;
	setAttr ".maxr" 1;
	setAttr ".shrd" 2;
	setAttr -s 45 ".stringOptions";
	setAttr ".stringOptions[0].name" -type "string" "rast motion factor";
	setAttr ".stringOptions[0].value" -type "string" "1.0";
	setAttr ".stringOptions[0].type" -type "string" "scalar";
	setAttr ".stringOptions[1].name" -type "string" "rast transparency depth";
	setAttr ".stringOptions[1].value" -type "string" "8";
	setAttr ".stringOptions[1].type" -type "string" "integer";
	setAttr ".stringOptions[2].name" -type "string" "rast useopacity";
	setAttr ".stringOptions[2].value" -type "string" "true";
	setAttr ".stringOptions[2].type" -type "string" "boolean";
	setAttr ".stringOptions[3].name" -type "string" "importon";
	setAttr ".stringOptions[3].value" -type "string" "false";
	setAttr ".stringOptions[3].type" -type "string" "boolean";
	setAttr ".stringOptions[4].name" -type "string" "importon density";
	setAttr ".stringOptions[4].value" -type "string" "1.0";
	setAttr ".stringOptions[4].type" -type "string" "scalar";
	setAttr ".stringOptions[5].name" -type "string" "importon merge";
	setAttr ".stringOptions[5].value" -type "string" "0.0";
	setAttr ".stringOptions[5].type" -type "string" "scalar";
	setAttr ".stringOptions[6].name" -type "string" "importon trace depth";
	setAttr ".stringOptions[6].value" -type "string" "0";
	setAttr ".stringOptions[6].type" -type "string" "integer";
	setAttr ".stringOptions[7].name" -type "string" "importon traverse";
	setAttr ".stringOptions[7].value" -type "string" "true";
	setAttr ".stringOptions[7].type" -type "string" "boolean";
	setAttr ".stringOptions[8].name" -type "string" "shadowmap pixel samples";
	setAttr ".stringOptions[8].value" -type "string" "3";
	setAttr ".stringOptions[8].type" -type "string" "integer";
	setAttr ".stringOptions[9].name" -type "string" "ambient occlusion";
	setAttr ".stringOptions[9].value" -type "string" "false";
	setAttr ".stringOptions[9].type" -type "string" "boolean";
	setAttr ".stringOptions[10].name" -type "string" "ambient occlusion rays";
	setAttr ".stringOptions[10].value" -type "string" "256";
	setAttr ".stringOptions[10].type" -type "string" "integer";
	setAttr ".stringOptions[11].name" -type "string" "ambient occlusion cache";
	setAttr ".stringOptions[11].value" -type "string" "false";
	setAttr ".stringOptions[11].type" -type "string" "boolean";
	setAttr ".stringOptions[12].name" -type "string" "ambient occlusion cache density";
	setAttr ".stringOptions[12].value" -type "string" "1.0";
	setAttr ".stringOptions[12].type" -type "string" "scalar";
	setAttr ".stringOptions[13].name" -type "string" "ambient occlusion cache points";
	setAttr ".stringOptions[13].value" -type "string" "64";
	setAttr ".stringOptions[13].type" -type "string" "integer";
	setAttr ".stringOptions[14].name" -type "string" "irradiance particles";
	setAttr ".stringOptions[14].value" -type "string" "false";
	setAttr ".stringOptions[14].type" -type "string" "boolean";
	setAttr ".stringOptions[15].name" -type "string" "irradiance particles rays";
	setAttr ".stringOptions[15].value" -type "string" "256";
	setAttr ".stringOptions[15].type" -type "string" "integer";
	setAttr ".stringOptions[16].name" -type "string" "irradiance particles interpolate";
	setAttr ".stringOptions[16].value" -type "string" "1";
	setAttr ".stringOptions[16].type" -type "string" "integer";
	setAttr ".stringOptions[17].name" -type "string" "irradiance particles interppoints";
	setAttr ".stringOptions[17].value" -type "string" "64";
	setAttr ".stringOptions[17].type" -type "string" "integer";
	setAttr ".stringOptions[18].name" -type "string" "irradiance particles indirect passes";
	setAttr ".stringOptions[18].value" -type "string" "0";
	setAttr ".stringOptions[18].type" -type "string" "integer";
	setAttr ".stringOptions[19].name" -type "string" "irradiance particles scale";
	setAttr ".stringOptions[19].value" -type "string" "1.0";
	setAttr ".stringOptions[19].type" -type "string" "scalar";
	setAttr ".stringOptions[20].name" -type "string" "irradiance particles env";
	setAttr ".stringOptions[20].value" -type "string" "true";
	setAttr ".stringOptions[20].type" -type "string" "boolean";
	setAttr ".stringOptions[21].name" -type "string" "irradiance particles env rays";
	setAttr ".stringOptions[21].value" -type "string" "256";
	setAttr ".stringOptions[21].type" -type "string" "integer";
	setAttr ".stringOptions[22].name" -type "string" "irradiance particles env scale";
	setAttr ".stringOptions[22].value" -type "string" "1";
	setAttr ".stringOptions[22].type" -type "string" "integer";
	setAttr ".stringOptions[23].name" -type "string" "irradiance particles rebuild";
	setAttr ".stringOptions[23].value" -type "string" "true";
	setAttr ".stringOptions[23].type" -type "string" "boolean";
	setAttr ".stringOptions[24].name" -type "string" "irradiance particles file";
	setAttr ".stringOptions[24].value" -type "string" "";
	setAttr ".stringOptions[24].type" -type "string" "string";
	setAttr ".stringOptions[25].name" -type "string" "geom displace motion factor";
	setAttr ".stringOptions[25].value" -type "string" "1.0";
	setAttr ".stringOptions[25].type" -type "string" "scalar";
	setAttr ".stringOptions[26].name" -type "string" "contrast all buffers";
	setAttr ".stringOptions[26].value" -type "string" "true";
	setAttr ".stringOptions[26].type" -type "string" "boolean";
	setAttr ".stringOptions[27].name" -type "string" "finalgather normal tolerance";
	setAttr ".stringOptions[27].value" -type "string" "25.842";
	setAttr ".stringOptions[27].type" -type "string" "scalar";
	setAttr ".stringOptions[28].name" -type "string" "trace camera clip";
	setAttr ".stringOptions[28].value" -type "string" "false";
	setAttr ".stringOptions[28].type" -type "string" "boolean";
	setAttr ".stringOptions[29].name" -type "string" "unified sampling";
	setAttr ".stringOptions[29].value" -type "string" "true";
	setAttr ".stringOptions[29].type" -type "string" "boolean";
	setAttr ".stringOptions[30].name" -type "string" "samples quality";
	setAttr ".stringOptions[30].value" -type "string" "0.25 0.25 0.25 0.25";
	setAttr ".stringOptions[30].type" -type "string" "color";
	setAttr ".stringOptions[31].name" -type "string" "samples min";
	setAttr ".stringOptions[31].value" -type "string" "1.0";
	setAttr ".stringOptions[31].type" -type "string" "scalar";
	setAttr ".stringOptions[32].name" -type "string" "samples max";
	setAttr ".stringOptions[32].value" -type "string" "100.0";
	setAttr ".stringOptions[32].type" -type "string" "scalar";
	setAttr ".stringOptions[33].name" -type "string" "samples error cutoff";
	setAttr ".stringOptions[33].value" -type "string" "0.0 0.0 0.0 0.0";
	setAttr ".stringOptions[33].type" -type "string" "color";
	setAttr ".stringOptions[34].name" -type "string" "samples per object";
	setAttr ".stringOptions[34].value" -type "string" "false";
	setAttr ".stringOptions[34].type" -type "string" "boolean";
	setAttr ".stringOptions[35].name" -type "string" "progressive";
	setAttr ".stringOptions[35].value" -type "string" "false";
	setAttr ".stringOptions[35].type" -type "string" "boolean";
	setAttr ".stringOptions[36].name" -type "string" "progressive max time";
	setAttr ".stringOptions[36].value" -type "string" "0";
	setAttr ".stringOptions[36].type" -type "string" "integer";
	setAttr ".stringOptions[37].name" -type "string" "progressive subsampling size";
	setAttr ".stringOptions[37].value" -type "string" "1";
	setAttr ".stringOptions[37].type" -type "string" "integer";
	setAttr ".stringOptions[38].name" -type "string" "iray";
	setAttr ".stringOptions[38].value" -type "string" "false";
	setAttr ".stringOptions[38].type" -type "string" "boolean";
	setAttr ".stringOptions[39].name" -type "string" "light relative scale";
	setAttr ".stringOptions[39].value" -type "string" "0.31831";
	setAttr ".stringOptions[39].type" -type "string" "scalar";
	setAttr ".stringOptions[40].name" -type "string" "trace camera motion vectors";
	setAttr ".stringOptions[40].value" -type "string" "false";
	setAttr ".stringOptions[40].type" -type "string" "boolean";
	setAttr ".stringOptions[41].name" -type "string" "ray differentials";
	setAttr ".stringOptions[41].value" -type "string" "true";
	setAttr ".stringOptions[41].type" -type "string" "boolean";
	setAttr ".stringOptions[42].name" -type "string" "environment lighting mode";
	setAttr ".stringOptions[42].value" -type "string" "off";
	setAttr ".stringOptions[42].type" -type "string" "string";
	setAttr ".stringOptions[43].name" -type "string" "environment lighting quality";
	setAttr ".stringOptions[43].value" -type "string" "0.167";
	setAttr ".stringOptions[43].type" -type "string" "scalar";
	setAttr ".stringOptions[44].name" -type "string" "environment lighting shadow";
	setAttr ".stringOptions[44].value" -type "string" "transparent";
	setAttr ".stringOptions[44].type" -type "string" "string";
createNode mentalrayFramebuffer -s -n "miDefaultFramebuffer";
	setAttr ".dat" 2;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 12 ".lnk";
	setAttr -s 12 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode lambert -n "crowdLambert1";
createNode shadingEngine -n "crowdLambert1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"top\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n"
		+ "                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n"
		+ "                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n"
		+ "                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n"
		+ "            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n"
		+ "            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n"
		+ "            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"side\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n"
		+ "                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n"
		+ "                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n"
		+ "            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n"
		+ "            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"front\" \n                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n"
		+ "                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n"
		+ "            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n"
		+ "            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n"
		+ "                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n"
		+ "            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n"
		+ "                -docTag \"isolOutln_fromSeln\" \n                -showShapes 0\n                -showReferenceNodes 1\n                -showReferenceMembers 1\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 1\n                -showAssets 1\n                -showContainedOnly 1\n                -showPublishedAsConnected 0\n                -showContainerContents 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n"
		+ "                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n"
		+ "            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n"
		+ "            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n"
		+ "            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n"
		+ "                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n"
		+ "                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n"
		+ "                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n"
		+ "                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n"
		+ "                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n"
		+ "                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n"
		+ "                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n"
		+ "                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n"
		+ "                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n"
		+ "                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"sequenceEditorPanel\" -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n"
		+ "                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\t}\n\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n"
		+ "                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -ignoreAssets 1\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -keyReleaseCommand \"nodeEdKeyReleaseCommand\" \n"
		+ "                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -island 0\n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -syncedSelection 1\n                -extendToShapes 1\n                $editorName;\n\t\t\tif (`objExists nodeEditorPanel1Info`) nodeEditor -e -restoreInfo nodeEditorPanel1Info $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -ignoreAssets 1\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n"
		+ "                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -keyReleaseCommand \"nodeEdKeyReleaseCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -island 0\n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -syncedSelection 1\n                -extendToShapes 1\n                $editorName;\n\t\t\tif (`objExists nodeEditorPanel1Info`) nodeEditor -e -restoreInfo nodeEditorPanel1Info $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"createNodePanel\" -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Texture Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l (localizedPanelLabel(\"UV Texture Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Texture Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" (localizedPanelLabel(\"Blend Shape\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"Stereo\" -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels `;\nstring $editorName = ($panelName+\"Editor\");\n"
		+ "            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n"
		+ "                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n"
		+ "                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n"
		+ "                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -displayMode \"centerEye\" \n"
		+ "                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.xC:/Golaem/GolaemCrowdSamples-3.5.1/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 500 -ast 1 -aet 500 ";
	setAttr ".st" 6;
createNode lambert -n "crowdLambert2";
createNode shadingEngine -n "crowdLambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode lambert -n "crowdLambert3";
createNode shadingEngine -n "crowdLambert3SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode lambert -n "crowdLambert4";
createNode shadingEngine -n "crowdLambert4SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
createNode lambert -n "crowdLambert5";
createNode shadingEngine -n "crowdLambert5SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo5";
createNode lambert -n "crowdLambert6";
createNode shadingEngine -n "crowdLambert6SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo6";
createNode lambert -n "crowdLambert7";
createNode shadingEngine -n "crowdLambert7SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo7";
createNode lambert -n "crowdLambert8";
createNode shadingEngine -n "crowdLambert8SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo8";
createNode lambert -n "crowdLambert9";
createNode shadingEngine -n "crowdLambert9SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo9";
createNode lambert -n "crowdLambert10";
createNode shadingEngine -n "crowdLambert10SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo10";
createNode CrowdBeOpCondition -n "beOpCondition1";
createNode CrowdBeOpCondition -n "beOpCondition2";
createNode CrowdBeOpCondition -n "beOpCondition3";
createNode CrowdBeOpCondition -n "beOpCondition4";
createNode CrowdBeOpCondition -n "beOpCondition5";
createNode hyperGraphInfo -n "nodeEditorPanel1Info";
createNode hyperView -n "hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr ".anf" yes;
createNode script -n "script1";
	addAttr -ci true -sn "crnd" -ln "currentRenderer" -dt "string";
	addAttr -ci true -sn "sstp" -ln "shadersStartPath" -dt "string";
	addAttr -ci true -sn "lprp" -ln "isLightProps" -dt "string";
	addAttr -ci true -sn "ecdlg" -ln "enableConfirmDialog" -dt "string";
	setAttr ".b" -type "string" "string $packdir = `dirmap -cd \"/atomo/pipeline/tools/golaem/characterPack/5.2/\"`;string $scriptName = $packdir + \"script/sampleGUI.mel\";eval(\"source \\\"\" + $scriptName + \"\\\"\");glmCrowdSampleConfigCrowdMan(\"\",1);";
	setAttr ".a" -type "string" "glmDeleteSampleConfigWindow()";
	setAttr ".st" 2;
	setAttr ".sstp" -type "string" "golaem/shaders/CMO-man_golaem-light";
	setAttr ".ecdlg" -type "string" "1";
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 1;
	setAttr -av ".unw" 1;
select -ne :renderPartition;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 12 ".st";
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
	setAttr ".ro" yes;
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
	setAttr ".ro" yes;
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
	setAttr -s 2 ".s";
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultRenderGlobals;
	setAttr ".ep" 1;
select -ne :defaultResolution;
	setAttr ".w" 640;
	setAttr ".h" 480;
	setAttr ".dar" 1.3333332538604736;
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
select -ne :defaultHardwareRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -av -k on ".rp";
	setAttr -k on ".cai";
	setAttr -k on ".coi";
	setAttr -cb on ".bc";
	setAttr -av -k on ".bcr";
	setAttr -av -k on ".bcg";
	setAttr -av -k on ".bcb";
	setAttr -k on ".ei";
	setAttr -k on ".ex";
	setAttr -av -k on ".es";
	setAttr -av -k on ".ef";
	setAttr -av -k on ".bf";
	setAttr -k on ".fii";
	setAttr -av -k on ".sf";
	setAttr -k on ".gr";
	setAttr -k on ".li";
	setAttr -k on ".ls";
	setAttr -k on ".mb";
	setAttr -k on ".ti";
	setAttr -k on ".txt";
	setAttr -k on ".mpr";
	setAttr -k on ".wzd";
	setAttr ".fn" -type "string" "im";
	setAttr -k on ".if";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
	setAttr -k on ".as";
	setAttr -k on ".ds";
	setAttr -k on ".lm";
	setAttr -k on ".fir";
	setAttr -k on ".aap";
	setAttr -k on ".gh";
	setAttr -cb on ".sd";
connectAttr "terrainShape1.msg" "crowdManagerNodeShape.trr";
connectAttr "sittingEntityTypeShape.msg" "crowdManagerNodeShape.ine[0]";
connectAttr "additiveEntityTypeShape.msg" "crowdManagerNodeShape.ine[1]";
connectAttr "sittingAdditiveEntityTypeShape.msg" "crowdManagerNodeShape.ine[2]";
connectAttr "standingEntityTypeShape.msg" "crowdManagerNodeShape.ine[3]";
connectAttr "wavingEntityTypeShape.msg" "crowdManagerNodeShape.ine[4]";
connectAttr "standingAdditiveEntityTypeShape.msg" "crowdManagerNodeShape.ine[5]"
		;
connectAttr "wavingAdditiveEntityTypeShape.msg" "crowdManagerNodeShape.ine[6]";
connectAttr "standingRandomEntityTypeShape.msg" "crowdManagerNodeShape.ine[7]";
connectAttr ":time1.o" "crowdManagerNodeShape.ct";
connectAttr "beMotionShape1.nb" "sittingEntityTypeContainerShape.fb[0]";
connectAttr "triOpAndShape1.msg" "beMotion1StartTriggerShape.tro";
connectAttr "beMotion1StartTriggerShape.ctr" "triOpAndShape1.pco";
connectAttr "triBoolShape1.net" "triOpAndShape1.prt[0]";
connectAttr "beMotion1StartTriggerShape.ctr" "triBoolShape1.pco";
connectAttr "triOpAndShape2.msg" "beMotion1StopTriggerShape.tro";
connectAttr "beMotion1StopTriggerShape.ctr" "triOpAndShape2.pco";
connectAttr "triBoolShape2.net" "triOpAndShape2.prt[0]";
connectAttr "beMotion1StopTriggerShape.ctr" "triBoolShape2.pco";
connectAttr "triOpAndShape3.msg" "beMotion2StartTriggerShape.tro";
connectAttr "beMotion2StartTriggerShape.ctr" "triOpAndShape3.pco";
connectAttr "triBoolShape3.net" "triOpAndShape3.prt[0]";
connectAttr "beMotion2StartTriggerShape.ctr" "triBoolShape3.pco";
connectAttr "triOpAndShape4.msg" "beMotion2StopTriggerShape.tro";
connectAttr "beMotion2StopTriggerShape.ctr" "triOpAndShape4.pco";
connectAttr "triBoolShape4.net" "triOpAndShape4.prt[0]";
connectAttr "beMotion2StopTriggerShape.ctr" "triBoolShape4.pco";
connectAttr "triOpAndShape5.msg" "beMotion3StartTriggerShape.tro";
connectAttr "beMotion3StartTriggerShape.ctr" "triOpAndShape5.pco";
connectAttr "triBoolShape5.net" "triOpAndShape5.prt[0]";
connectAttr "beMotion3StartTriggerShape.ctr" "triBoolShape5.pco";
connectAttr "triOpAndShape6.msg" "beMotion3StopTriggerShape.tro";
connectAttr "beMotion3StopTriggerShape.ctr" "triOpAndShape6.pco";
connectAttr "triBoolShape6.net" "triOpAndShape6.prt[0]";
connectAttr "beMotion3StopTriggerShape.ctr" "triBoolShape6.pco";
connectAttr "triOpAndShape7.msg" "beMotion4StartTriggerShape.tro";
connectAttr "beMotion4StartTriggerShape.ctr" "triOpAndShape7.pco";
connectAttr "triBoolShape7.net" "triOpAndShape7.prt[0]";
connectAttr "beMotion4StartTriggerShape.ctr" "triBoolShape7.pco";
connectAttr "triOpAndShape8.msg" "beMotion4StopTriggerShape.tro";
connectAttr "beMotion4StopTriggerShape.ctr" "triOpAndShape8.pco";
connectAttr "triBoolShape8.net" "triOpAndShape8.prt[0]";
connectAttr "beMotion4StopTriggerShape.ctr" "triBoolShape8.pco";
connectAttr "triOpAndShape9.msg" "beMotion5StartTriggerShape.tro";
connectAttr "beMotion5StartTriggerShape.ctr" "triOpAndShape9.pco";
connectAttr "triBoolShape9.net" "triOpAndShape9.prt[0]";
connectAttr "beMotion5StartTriggerShape.ctr" "triBoolShape9.pco";
connectAttr "triOpAndShape10.msg" "beMotion5StopTriggerShape.tro";
connectAttr "beMotion5StopTriggerShape.ctr" "triOpAndShape10.pco";
connectAttr "triBoolShape10.net" "triOpAndShape10.prt[0]";
connectAttr "beMotion5StopTriggerShape.ctr" "triBoolShape10.pco";
connectAttr "triOpAndShape11.msg" "beMotion6StartTriggerShape.tro";
connectAttr "beMotion6StartTriggerShape.ctr" "triOpAndShape11.pco";
connectAttr "triBoolShape11.net" "triOpAndShape11.prt[0]";
connectAttr "beMotion6StartTriggerShape.ctr" "triBoolShape11.pco";
connectAttr "triOpAndShape12.msg" "beMotion6StopTriggerShape.tro";
connectAttr "beMotion6StopTriggerShape.ctr" "triOpAndShape12.pco";
connectAttr "triBoolShape12.net" "triOpAndShape12.prt[0]";
connectAttr "beMotion6StopTriggerShape.ctr" "triBoolShape12.pco";
connectAttr "triOpAndShape13.msg" "beMotion7StartTriggerShape.tro";
connectAttr "beMotion7StartTriggerShape.ctr" "triOpAndShape13.pco";
connectAttr "triBoolShape13.net" "triOpAndShape13.prt[0]";
connectAttr "beMotion7StartTriggerShape.ctr" "triBoolShape13.pco";
connectAttr "triOpAndShape14.msg" "beMotion7StopTriggerShape.tro";
connectAttr "beMotion7StopTriggerShape.ctr" "triOpAndShape14.pco";
connectAttr "triBoolShape14.net" "triOpAndShape14.prt[0]";
connectAttr "beMotion7StopTriggerShape.ctr" "triBoolShape14.pco";
connectAttr "triOpAndShape15.msg" "beMotion8StartTriggerShape.tro";
connectAttr "beMotion8StartTriggerShape.ctr" "triOpAndShape15.pco";
connectAttr "triBoolShape15.net" "triOpAndShape15.prt[0]";
connectAttr "beMotion8StartTriggerShape.ctr" "triBoolShape15.pco";
connectAttr "triOpAndShape16.msg" "beMotion8StopTriggerShape.tro";
connectAttr "beMotion8StopTriggerShape.ctr" "triOpAndShape16.pco";
connectAttr "triBoolShape16.net" "triOpAndShape16.prt[0]";
connectAttr "beMotion8StopTriggerShape.ctr" "triBoolShape16.pco";
connectAttr "triOpAndShape17.msg" "beMotion9StartTriggerShape.tro";
connectAttr "beMotion9StartTriggerShape.ctr" "triOpAndShape17.pco";
connectAttr "triBoolShape17.net" "triOpAndShape17.prt[0]";
connectAttr "beMotion9StartTriggerShape.ctr" "triBoolShape17.pco";
connectAttr "triOpAndShape18.msg" "beMotion9StopTriggerShape.tro";
connectAttr "beMotion9StopTriggerShape.ctr" "triOpAndShape18.pco";
connectAttr "triBoolShape18.net" "triOpAndShape18.prt[0]";
connectAttr "beMotion9StopTriggerShape.ctr" "triBoolShape18.pco";
connectAttr "triOpAndShape19.msg" "beMotion10StartTriggerShape.tro";
connectAttr "beMotion10StartTriggerShape.ctr" "triOpAndShape19.pco";
connectAttr "triBoolShape19.net" "triOpAndShape19.prt[0]";
connectAttr "beMotion10StartTriggerShape.ctr" "triBoolShape19.pco";
connectAttr "triOpAndShape20.msg" "beMotion10StopTriggerShape.tro";
connectAttr "beMotion10StopTriggerShape.ctr" "triOpAndShape20.pco";
connectAttr "triBoolShape20.net" "triOpAndShape20.prt[0]";
connectAttr "beMotion10StopTriggerShape.ctr" "triBoolShape20.pco";
connectAttr "triOpAndShape21.msg" "beMotion11StartTriggerShape.tro";
connectAttr "beMotion11StartTriggerShape.ctr" "triOpAndShape21.pco";
connectAttr "triBoolShape21.net" "triOpAndShape21.prt[0]";
connectAttr "beMotion11StartTriggerShape.ctr" "triBoolShape21.pco";
connectAttr "triOpAndShape22.msg" "beMotion11StopTriggerShape.tro";
connectAttr "beMotion11StopTriggerShape.ctr" "triOpAndShape22.pco";
connectAttr "triBoolShape22.net" "triOpAndShape22.prt[0]";
connectAttr "beMotion11StopTriggerShape.ctr" "triBoolShape22.pco";
connectAttr "triOpAndShape23.msg" "beMotion12StartTriggerShape.tro";
connectAttr "beMotion12StartTriggerShape.ctr" "triOpAndShape23.pco";
connectAttr "triBoolShape23.net" "triOpAndShape23.prt[0]";
connectAttr "beMotion12StartTriggerShape.ctr" "triBoolShape23.pco";
connectAttr "triOpAndShape24.msg" "beMotion12StopTriggerShape.tro";
connectAttr "beMotion12StopTriggerShape.ctr" "triOpAndShape24.pco";
connectAttr "triBoolShape24.net" "triOpAndShape24.prt[0]";
connectAttr "beMotion12StopTriggerShape.ctr" "triBoolShape24.pco";
connectAttr "triOpAndShape25.msg" "beMotion13StartTriggerShape.tro";
connectAttr "beMotion13StartTriggerShape.ctr" "triOpAndShape25.pco";
connectAttr "triBoolShape25.net" "triOpAndShape25.prt[0]";
connectAttr "beMotion13StartTriggerShape.ctr" "triBoolShape25.pco";
connectAttr "triOpAndShape26.msg" "beMotion13StopTriggerShape.tro";
connectAttr "beMotion13StopTriggerShape.ctr" "triOpAndShape26.pco";
connectAttr "triBoolShape26.net" "triOpAndShape26.prt[0]";
connectAttr "beMotion13StopTriggerShape.ctr" "triBoolShape26.pco";
connectAttr "triOpAndShape27.msg" "beMotion14StartTriggerShape.tro";
connectAttr "beMotion14StartTriggerShape.ctr" "triOpAndShape27.pco";
connectAttr "triBoolShape27.net" "triOpAndShape27.prt[0]";
connectAttr "beMotion14StartTriggerShape.ctr" "triBoolShape27.pco";
connectAttr "triOpAndShape28.msg" "beMotion14StopTriggerShape.tro";
connectAttr "beMotion14StopTriggerShape.ctr" "triOpAndShape28.pco";
connectAttr "triBoolShape28.net" "triOpAndShape28.prt[0]";
connectAttr "beMotion14StopTriggerShape.ctr" "triBoolShape28.pco";
connectAttr "triOpAndShape29.msg" "beMotion15StartTriggerShape.tro";
connectAttr "beMotion15StartTriggerShape.ctr" "triOpAndShape29.pco";
connectAttr "triBoolShape29.net" "triOpAndShape29.prt[0]";
connectAttr "beMotion15StartTriggerShape.ctr" "triBoolShape29.pco";
connectAttr "triOpAndShape30.msg" "beMotion15StopTriggerShape.tro";
connectAttr "beMotion15StopTriggerShape.ctr" "triOpAndShape30.pco";
connectAttr "triBoolShape30.net" "triOpAndShape30.prt[0]";
connectAttr "beMotion15StopTriggerShape.ctr" "triBoolShape30.pco";
connectAttr "triOpAndShape31.msg" "beMotion16StartTriggerShape.tro";
connectAttr "beMotion16StartTriggerShape.ctr" "triOpAndShape31.pco";
connectAttr "triBoolShape31.net" "triOpAndShape31.prt[0]";
connectAttr "beMotion16StartTriggerShape.ctr" "triBoolShape31.pco";
connectAttr "triOpAndShape32.msg" "beMotion16StopTriggerShape.tro";
connectAttr "beMotion16StopTriggerShape.ctr" "triOpAndShape32.pco";
connectAttr "triBoolShape32.net" "triOpAndShape32.prt[0]";
connectAttr "beMotion16StopTriggerShape.ctr" "triBoolShape32.pco";
connectAttr "triOpAndShape33.msg" "beMotion18StartTriggerShape.tro";
connectAttr "beMotion18StartTriggerShape.ctr" "triOpAndShape33.pco";
connectAttr "triBoolShape33.net" "triOpAndShape33.prt[0]";
connectAttr "beMotion18StartTriggerShape.ctr" "triBoolShape33.pco";
connectAttr "triOpAndShape34.msg" "beMotion18StopTriggerShape.tro";
connectAttr "beMotion18StopTriggerShape.ctr" "triOpAndShape34.pco";
connectAttr "triBoolShape34.net" "triOpAndShape34.prt[0]";
connectAttr "beMotion18StopTriggerShape.ctr" "triBoolShape34.pco";
connectAttr "triOpAndShape35.msg" "beMotion19StartTriggerShape.tro";
connectAttr "beMotion19StartTriggerShape.ctr" "triOpAndShape35.pco";
connectAttr "triBoolShape35.net" "triOpAndShape35.prt[0]";
connectAttr "beMotion19StartTriggerShape.ctr" "triBoolShape35.pco";
connectAttr "triOpAndShape36.msg" "beMotion19StopTriggerShape.tro";
connectAttr "beMotion19StopTriggerShape.ctr" "triOpAndShape36.pco";
connectAttr "triBoolShape36.net" "triOpAndShape36.prt[0]";
connectAttr "beMotion19StopTriggerShape.ctr" "triBoolShape36.pco";
connectAttr "triOpAndShape37.msg" "beMotion20StartTriggerShape.tro";
connectAttr "beMotion20StartTriggerShape.ctr" "triOpAndShape37.pco";
connectAttr "triBoolShape37.net" "triOpAndShape37.prt[0]";
connectAttr "beMotion20StartTriggerShape.ctr" "triBoolShape37.pco";
connectAttr "triOpAndShape38.msg" "beMotion20StopTriggerShape.tro";
connectAttr "beMotion20StopTriggerShape.ctr" "triOpAndShape38.pco";
connectAttr "triBoolShape38.net" "triOpAndShape38.prt[0]";
connectAttr "beMotion20StopTriggerShape.ctr" "triBoolShape38.pco";
connectAttr "triOpAndShape39.msg" "beMotion21StartTriggerShape.tro";
connectAttr "beMotion21StartTriggerShape.ctr" "triOpAndShape39.pco";
connectAttr "triBoolShape39.net" "triOpAndShape39.prt[0]";
connectAttr "beMotion21StartTriggerShape.ctr" "triBoolShape39.pco";
connectAttr "triOpAndShape40.msg" "beMotion21StopTriggerShape.tro";
connectAttr "beMotion21StopTriggerShape.ctr" "triOpAndShape40.pco";
connectAttr "triBoolShape40.net" "triOpAndShape40.prt[0]";
connectAttr "beMotion21StopTriggerShape.ctr" "triBoolShape40.pco";
connectAttr "triOpAndShape41.msg" "beOpAlternative1TriggerShape1.tro";
connectAttr "beOpAlternative1TriggerShape1.ctr" "triOpAndShape41.pco";
connectAttr "triBoolShape41.net" "triOpAndShape41.prt[0]";
connectAttr "beOpAlternative1TriggerShape1.ctr" "triBoolShape41.pco";
connectAttr "CMAN_SitWatching_Shape11.msg" "beMotionShape1.mcp[0]";
connectAttr "sittingEntityTypeContainerShape.chb" "beMotionShape1.pb";
connectAttr "sittingEntityTypeContainerShape.ib" "beMotionShape1.prb[0]";
connectAttr "beMotion1StartTriggerShape.msg" "beMotionShape1.isac";
connectAttr "beMotion1StopTriggerShape.msg" "beMotionShape1.isoc";
connectAttr "beMotionShape2.nb" "additiveEntityTypeContainerShape.fb[0]";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "beMotionShape2.mcp[0]"
		;
connectAttr "additiveEntityTypeContainerShape.chb" "beMotionShape2.pb";
connectAttr "additiveEntityTypeContainerShape.ib" "beMotionShape2.prb[0]";
connectAttr "beMotion2StartTriggerShape.msg" "beMotionShape2.isac";
connectAttr "beMotion2StopTriggerShape.msg" "beMotionShape2.isoc";
connectAttr "beOpParallelShape1.nb" "sittingAdditiveEntityTypeContainerShape.fb[0]"
		;
connectAttr "CMAN_SitWatching_Shape11.msg" "beMotionShape3.mcp[0]";
connectAttr "beOpParallelShape1.chb" "beMotionShape3.pb";
connectAttr "beMotion3StartTriggerShape.msg" "beMotionShape3.isac";
connectAttr "beMotion3StopTriggerShape.msg" "beMotionShape3.isoc";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "beMotionShape4.mcp[0]"
		;
connectAttr "beOpParallelShape1.chb" "beMotionShape4.pb";
connectAttr "beMotion4StartTriggerShape.msg" "beMotionShape4.isac";
connectAttr "beMotion4StopTriggerShape.msg" "beMotionShape4.isoc";
connectAttr "sittingAdditiveEntityTypeContainerShape.chb" "beOpParallelShape1.pb"
		;
connectAttr "sittingAdditiveEntityTypeContainerShape.ib" "beOpParallelShape1.prb[0]"
		;
connectAttr "beMotionShape5.nb" "standingEntityTypeContainerShape.fb[0]";
connectAttr "CMAN_StandWatchingShape1.msg" "beMotionShape5.mcp[0]";
connectAttr "standingEntityTypeContainerShape.chb" "beMotionShape5.pb";
connectAttr "standingEntityTypeContainerShape.ib" "beMotionShape5.prb[0]";
connectAttr "beMotion5StartTriggerShape.msg" "beMotionShape5.isac";
connectAttr "beMotion5StopTriggerShape.msg" "beMotionShape5.isoc";
connectAttr "beMotionShape6.nb" "wavingEntityTypeContainerShape.fb[0]";
connectAttr "CMAN_SitWave_Shape11.msg" "beMotionShape6.mcp[0]";
connectAttr "wavingEntityTypeContainerShape.chb" "beMotionShape6.pb";
connectAttr "wavingEntityTypeContainerShape.ib" "beMotionShape6.prb[0]";
connectAttr "beMotion6StartTriggerShape.msg" "beMotionShape6.isac";
connectAttr "beMotion6StopTriggerShape.msg" "beMotionShape6.isoc";
connectAttr "beOpParallelShape2.nb" "standingAdditiveEntityTypeContainerShape.fb[0]"
		;
connectAttr "CMAN_StandWatchingShape1.msg" "beMotionShape7.mcp[0]";
connectAttr "beOpParallelShape2.chb" "beMotionShape7.pb";
connectAttr "beMotion7StartTriggerShape.msg" "beMotionShape7.isac";
connectAttr "beMotion7StopTriggerShape.msg" "beMotionShape7.isoc";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "beMotionShape8.mcp[0]"
		;
connectAttr "beOpParallelShape2.chb" "beMotionShape8.pb";
connectAttr "beMotion8StartTriggerShape.msg" "beMotionShape8.isac";
connectAttr "beMotion8StopTriggerShape.msg" "beMotionShape8.isoc";
connectAttr "standingAdditiveEntityTypeContainerShape.chb" "beOpParallelShape2.pb"
		;
connectAttr "standingAdditiveEntityTypeContainerShape.ib" "beOpParallelShape2.prb[0]"
		;
connectAttr "beOpParallelShape3.nb" "wavingAdditiveEntityTypeContainerShape.fb[0]"
		;
connectAttr "CMAN_SitWave_Shape11.msg" "beMotionShape9.mcp[0]";
connectAttr "beOpParallelShape3.chb" "beMotionShape9.pb";
connectAttr "beMotion9StartTriggerShape.msg" "beMotionShape9.isac";
connectAttr "beMotion9StopTriggerShape.msg" "beMotionShape9.isoc";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "beMotionShape10.mcp[0]"
		;
connectAttr "beOpParallelShape3.chb" "beMotionShape10.pb";
connectAttr "beMotion10StartTriggerShape.msg" "beMotionShape10.isac";
connectAttr "beMotion10StopTriggerShape.msg" "beMotionShape10.isoc";
connectAttr "wavingAdditiveEntityTypeContainerShape.chb" "beOpParallelShape3.pb"
		;
connectAttr "wavingAdditiveEntityTypeContainerShape.ib" "beOpParallelShape3.prb[0]"
		;
connectAttr "beOpParallelShape4.nb" "standingRandomEntityTypeContainerShape.fb[0]"
		;
connectAttr "CMAN_StandWatchingShape1.msg" "standMotionShape.mcp[0]";
connectAttr "beOpParallelShape4.chb" "standMotionShape.pb";
connectAttr "beMotion11StartTriggerShape.msg" "standMotionShape.isac";
connectAttr "beMotion11StopTriggerShape.msg" "standMotionShape.isoc";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "addLeftRightMotionShape1.mcp[0]"
		;
connectAttr "additiveContainerShape.chb" "addLeftRightMotionShape1.pb";
connectAttr "beOpRandomShape1.nb" "addLeftRightMotionShape1.prb[0]";
connectAttr "beMotion12StartTriggerShape.msg" "addLeftRightMotionShape1.isac";
connectAttr "beMotion12StopTriggerShape.msg" "addLeftRightMotionShape1.isoc";
connectAttr "standingRandomEntityTypeContainerShape.chb" "beOpParallelShape4.pb"
		;
connectAttr "standingRandomEntityTypeContainerShape.ib" "beOpParallelShape4.prb[0]"
		;
connectAttr "beOpParallelShape5.nb" "sittingRandomEntityTypeContainerShape.fb[0]"
		;
connectAttr "beOpParallelShape6.nb" "wavingRandomEntityTypeContainerShape.fb[0]"
		;
connectAttr "CMAN_SitWatching_Shape11.msg" "beMotionShape13.mcp[0]";
connectAttr "beOpParallelShape5.chb" "beMotionShape13.pb";
connectAttr "beMotion13StartTriggerShape.msg" "beMotionShape13.isac";
connectAttr "beMotion13StopTriggerShape.msg" "beMotionShape13.isoc";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "beMotionShape14.mcp[0]"
		;
connectAttr "beOpParallelShape5.chb" "beMotionShape14.pb";
connectAttr "beMotion14StartTriggerShape.msg" "beMotionShape14.isac";
connectAttr "beMotion14StopTriggerShape.msg" "beMotionShape14.isoc";
connectAttr "sittingRandomEntityTypeContainerShape.chb" "beOpParallelShape5.pb";
connectAttr "sittingRandomEntityTypeContainerShape.ib" "beOpParallelShape5.prb[0]"
		;
connectAttr "CMAN_SitWave_Shape11.msg" "beMotionShape15.mcp[0]";
connectAttr "beOpParallelShape6.chb" "beMotionShape15.pb";
connectAttr "beMotion15StartTriggerShape.msg" "beMotionShape15.isac";
connectAttr "beMotion15StopTriggerShape.msg" "beMotionShape15.isoc";
connectAttr "CMAN_AddLeftRightHighSwing_UpperBodyShape1.msg" "beMotionShape16.mcp[0]"
		;
connectAttr "beOpParallelShape6.chb" "beMotionShape16.pb";
connectAttr "beMotion16StartTriggerShape.msg" "beMotionShape16.isac";
connectAttr "beMotion16StopTriggerShape.msg" "beMotionShape16.isoc";
connectAttr "wavingRandomEntityTypeContainerShape.chb" "beOpParallelShape6.pb";
connectAttr "wavingRandomEntityTypeContainerShape.ib" "beOpParallelShape6.prb[0]"
		;
connectAttr "beOpAlternativeShape1.db" "additiveContainerShape.fb[0]";
connectAttr "beOpParallelShape4.chb" "additiveContainerShape.pb";
connectAttr "additiveContainerShape.chb" "beOpRandomShape1.pb";
connectAttr "additiveContainerShape.ib" "beOpRandomShape1.prb[0]";
connectAttr "beOpAlternativeShape1.nb" "beOpRandomShape1.prb[1]";
connectAttr "beOpCondition1.msg" "beOpRandomShape1.cnd" -na;
connectAttr "beOpCondition3.msg" "beOpRandomShape1.cnd" -na;
connectAttr "beOpCondition4.msg" "beOpRandomShape1.cnd" -na;
connectAttr "beOpCondition5.msg" "beOpRandomShape1.cnd" -na;
connectAttr "beOpCondition1.msg" "beOpRandomShape1.fcnd";
connectAttr "beOpCondition5.msg" "beOpRandomShape1.lcnd";
connectAttr "additiveContainerShape.chb" "beOpAlternativeShape1.pb";
connectAttr "addLeftRightMotionShape1.nb" "beOpAlternativeShape1.prb[0]";
connectAttr "addLeftRightMotionShape2.nb" "beOpAlternativeShape1.prb[1]";
connectAttr "addLeftRightMotionShape3.nb" "beOpAlternativeShape1.prb[2]";
connectAttr "addLeftRightMotionShape4.nb" "beOpAlternativeShape1.prb[3]";
connectAttr "beOpCondition2.msg" "beOpAlternativeShape1.cnd" -na;
connectAttr "beOpCondition2.msg" "beOpAlternativeShape1.fcnd";
connectAttr "beOpCondition2.msg" "beOpAlternativeShape1.lcnd";
connectAttr "CMAN_AddLeftHighSwing_FullBodyShape1.msg" "addLeftRightMotionShape2.mcp[0]"
		;
connectAttr "additiveContainerShape.chb" "addLeftRightMotionShape2.pb";
connectAttr "beOpRandomShape1.nb" "addLeftRightMotionShape2.prb[0]";
connectAttr "beMotion18StartTriggerShape.msg" "addLeftRightMotionShape2.isac";
connectAttr "beMotion18StopTriggerShape.msg" "addLeftRightMotionShape2.isoc";
connectAttr "CMAN_AddLeftRightAverageSwing_FullBodyShape1.msg" "addLeftRightMotionShape3.mcp[0]"
		;
connectAttr "additiveContainerShape.chb" "addLeftRightMotionShape3.pb";
connectAttr "beOpRandomShape1.nb" "addLeftRightMotionShape3.prb[0]";
connectAttr "beMotion19StartTriggerShape.msg" "addLeftRightMotionShape3.isac";
connectAttr "beMotion19StopTriggerShape.msg" "addLeftRightMotionShape3.isoc";
connectAttr "CMAN_AddRightLeftLittleSwing_UpperBodyShape1.msg" "addLeftRightMotionShape4.mcp[0]"
		;
connectAttr "additiveContainerShape.chb" "addLeftRightMotionShape4.pb";
connectAttr "beOpRandomShape1.nb" "addLeftRightMotionShape4.prb[0]";
connectAttr "beMotion20StartTriggerShape.msg" "addLeftRightMotionShape4.isac";
connectAttr "beMotion20StopTriggerShape.msg" "addLeftRightMotionShape4.isoc";
connectAttr "CMAN_AddBackFrontLittleSwing_UpperBodyShape1.msg" "addBackFrontMotionShape.mcp[0]"
		;
connectAttr "beOpParallelShape4.chb" "addBackFrontMotionShape.pb";
connectAttr "beMotion21StartTriggerShape.msg" "addBackFrontMotionShape.isac";
connectAttr "beMotion21StopTriggerShape.msg" "addBackFrontMotionShape.isoc";
connectAttr "crowdManagerNodeShape.sf" "crowdField1.sf";
connectAttr "standingRandomParticleShape.fd" "crowdField1.ind[7]";
connectAttr "sittingParticleShape.fd" "crowdField1.ind[8]";
connectAttr "standingParticleShape.fd" "crowdField1.ind[9]";
connectAttr "wavingParticleShape.fd" "crowdField1.ind[10]";
connectAttr "standingRandomParticleShape.ppfd[0]" "crowdField1.ppda[7]";
connectAttr "sittingParticleShape.ppfd[0]" "crowdField1.ppda[8]";
connectAttr "standingParticleShape.ppfd[0]" "crowdField1.ppda[9]";
connectAttr "wavingParticleShape.ppfd[0]" "crowdField1.ppda[10]";
connectAttr "additiveEntityTypeContainerShape.msg" "additiveEntityTypeShape.ibc"
		;
connectAttr "sittingAdditiveEntityTypeContainerShape.msg" "sittingAdditiveEntityTypeShape.ibc"
		;
connectAttr "sittingEntityTypeContainerShape.msg" "sittingEntityTypeShape.ibc";
connectAttr "terrainShape1.msg" "sittingPopToolShape.int";
connectAttr "sittingEntityTypeShape.msg" "sittingPopToolShape.ine" -na;
connectAttr "additiveEntityTypeShape.msg" "sittingPopToolShape.ine" -na;
connectAttr "sittingAdditiveEntityTypeShape.msg" "sittingPopToolShape.ine" -na;
connectAttr ":time1.o" "sittingParticleShape.cti";
connectAttr "crowdManagerNodeShape.sf" "sittingParticleShape.stf";
connectAttr "crowdField1.of[8]" "sittingParticleShape.ifc[0]";
connectAttr "inputAnnotationShape.wm" "annotationShape3.dom" -na;
connectAttr "|sitting|annotations|outputAnnotation|outputAnnotationShape.wm" "annotationShape9.dom"
		 -na;
connectAttr "|sitting|annotations|additiveAnnotation|additiveAnnotationShape.wm" "annotationShape5.dom"
		 -na;
connectAttr "standingEntityTypeContainerShape.msg" "standingEntityTypeShape.ibc"
		;
connectAttr "standingAdditiveEntityTypeContainerShape.msg" "standingAdditiveEntityTypeShape.ibc"
		;
connectAttr "terrainShape1.msg" "standingPopToolShape.int";
connectAttr "additiveEntityTypeShape.msg" "standingPopToolShape.ine" -na;
connectAttr "standingEntityTypeShape.msg" "standingPopToolShape.ine" -na;
connectAttr "standingAdditiveEntityTypeShape.msg" "standingPopToolShape.ine" -na
		;
connectAttr ":time1.o" "standingParticleShape.cti";
connectAttr "crowdManagerNodeShape.sf" "standingParticleShape.stf";
connectAttr "crowdField1.of[9]" "standingParticleShape.ifc[0]";
connectAttr "standingAnnotationShape.wm" "annotationShape1.dom" -na;
connectAttr "|standing|annotations|outputAnnotation|outputAnnotationShape.wm" "annotationShape7.dom"
		 -na;
connectAttr "|standing|annotations|additiveAnnotation|additiveAnnotationShape.wm" "annotationShape4.dom"
		 -na;
connectAttr "wavingEntityTypeContainerShape.msg" "wavingEntityTypeShape.ibc";
connectAttr "wavingAdditiveEntityTypeContainerShape.msg" "wavingAdditiveEntityTypeShape.ibc"
		;
connectAttr "terrainShape1.msg" "wavingPopToolShape.int";
connectAttr "additiveEntityTypeShape.msg" "wavingPopToolShape.ine" -na;
connectAttr "wavingEntityTypeShape.msg" "wavingPopToolShape.ine" -na;
connectAttr "wavingAdditiveEntityTypeShape.msg" "wavingPopToolShape.ine" -na;
connectAttr ":time1.o" "wavingParticleShape.cti";
connectAttr "crowdManagerNodeShape.sf" "wavingParticleShape.stf";
connectAttr "crowdField1.of[10]" "wavingParticleShape.ifc[0]";
connectAttr "|waving|annotations|additiveAnnotation|additiveAnnotationShape.wm" "annotationShape6.dom"
		 -na;
connectAttr "wavingAnnotationShape.wm" "annotationShape2.dom" -na;
connectAttr "|waving|annotations|outputAnnotation|outputAnnotationShape.wm" "annotationShape8.dom"
		 -na;
connectAttr "standingRandomEntityTypeContainerShape.msg" "standingRandomEntityTypeShape.ibc"
		;
connectAttr ":time1.o" "standingRandomParticleShape.cti";
connectAttr "crowdManagerNodeShape.sf" "standingRandomParticleShape.stf";
connectAttr "crowdField1.of[7]" "standingRandomParticleShape.ifc[0]";
connectAttr "terrainShape1.msg" "standingRandomPopToolShape.int";
connectAttr "standingRandomEntityTypeShape.msg" "standingRandomPopToolShape.ine"
		 -na;
connectAttr "standingRandomAnnotationShape.wm" "annotationShape10.dom" -na;
connectAttr "|rendererAnnotation|rendererAnnotationShape.wm" "|rendererAnnotation|rendererAnnotation|rendererAnnotationShape.dom"
		 -na;
connectAttr ":mentalrayGlobals.msg" ":mentalrayItemsList.glb";
connectAttr ":miDefaultOptions.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayItemsList.fb" -na;
connectAttr ":miDefaultOptions.msg" ":mentalrayGlobals.opt";
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayGlobals.fb";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert3SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert4SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert5SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert6SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert7SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert8SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert9SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert10SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert3SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert4SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert5SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert6SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert7SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert8SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert9SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert10SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "sittingEntityTypeShape.dc" "crowdLambert1.c";
connectAttr "crowdLambert1.oc" "crowdLambert1SG.ss";
connectAttr "crowdLambert1SG.msg" "materialInfo1.sg";
connectAttr "crowdLambert1.msg" "materialInfo1.m";
connectAttr "additiveEntityTypeShape.dc" "crowdLambert2.c";
connectAttr "crowdLambert2.oc" "crowdLambert2SG.ss";
connectAttr "crowdLambert2SG.msg" "materialInfo2.sg";
connectAttr "crowdLambert2.msg" "materialInfo2.m";
connectAttr "sittingAdditiveEntityTypeShape.dc" "crowdLambert3.c";
connectAttr "crowdLambert3.oc" "crowdLambert3SG.ss";
connectAttr "crowdLambert3SG.msg" "materialInfo3.sg";
connectAttr "crowdLambert3.msg" "materialInfo3.m";
connectAttr "standingEntityTypeShape.dc" "crowdLambert4.c";
connectAttr "crowdLambert4.oc" "crowdLambert4SG.ss";
connectAttr "crowdLambert4SG.msg" "materialInfo4.sg";
connectAttr "crowdLambert4.msg" "materialInfo4.m";
connectAttr "wavingEntityTypeShape.dc" "crowdLambert5.c";
connectAttr "crowdLambert5.oc" "crowdLambert5SG.ss";
connectAttr "crowdLambert5SG.msg" "materialInfo5.sg";
connectAttr "crowdLambert5.msg" "materialInfo5.m";
connectAttr "standingAdditiveEntityTypeShape.dc" "crowdLambert6.c";
connectAttr "crowdLambert6.oc" "crowdLambert6SG.ss";
connectAttr "crowdLambert6SG.msg" "materialInfo6.sg";
connectAttr "crowdLambert6.msg" "materialInfo6.m";
connectAttr "wavingAdditiveEntityTypeShape.dc" "crowdLambert7.c";
connectAttr "crowdLambert7.oc" "crowdLambert7SG.ss";
connectAttr "crowdLambert7SG.msg" "materialInfo7.sg";
connectAttr "crowdLambert7.msg" "materialInfo7.m";
connectAttr "standingRandomEntityTypeShape.dc" "crowdLambert8.c";
connectAttr "crowdLambert8.oc" "crowdLambert8SG.ss";
connectAttr "crowdLambert8SG.msg" "materialInfo8.sg";
connectAttr "crowdLambert8.msg" "materialInfo8.m";
connectAttr "crowdLambert9.oc" "crowdLambert9SG.ss";
connectAttr "crowdLambert9SG.msg" "materialInfo9.sg";
connectAttr "crowdLambert9.msg" "materialInfo9.m";
connectAttr "crowdLambert10.oc" "crowdLambert10SG.ss";
connectAttr "crowdLambert10SG.msg" "materialInfo10.sg";
connectAttr "crowdLambert10.msg" "materialInfo10.m";
connectAttr "addLeftRightMotionShape1.msg" "beOpCondition1.cndb";
connectAttr "beOpCondition3.msg" "beOpCondition1.ncnd";
connectAttr "beOpRandomShape1.msg" "beOpCondition2.cndb";
connectAttr "beOpAlternative1TriggerShape1.msg" "beOpCondition2.ctri";
connectAttr "addLeftRightMotionShape2.msg" "beOpCondition3.cndb";
connectAttr "beOpCondition4.msg" "beOpCondition3.ncnd";
connectAttr "addLeftRightMotionShape3.msg" "beOpCondition4.cndb";
connectAttr "beOpCondition5.msg" "beOpCondition4.ncnd";
connectAttr "addLeftRightMotionShape4.msg" "beOpCondition5.cndb";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "hyperLayout1.msg" "hyperView1.hl";
connectAttr "crowdLambert1SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert2SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert3SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert4SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert5SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert6SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert7SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert8SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert9SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert10SG.pa" ":renderPartition.st" -na;
connectAttr "standingRandomParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of additiveAnimation.ma
