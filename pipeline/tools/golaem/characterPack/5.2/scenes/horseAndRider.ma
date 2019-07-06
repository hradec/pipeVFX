//Maya ASCII 2014 scene
//Name: horseAndRider.ma
//Last modified: Fri, Jun 03, 2016 04:57:42 PM
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
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014";
fileInfo "cutIdentifier" "201401300447-905052";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 75.521584836086006 31.598413235073732 0.13412454803664708 ;
	setAttr ".r" -type "double3" -12.338352729552632 87.400000000000844 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 112.04900424621307;
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
	setAttr ".ow" 123.03521129400646;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -1.6018250511549257 15.6131382952839 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 18.059514263134115;
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
	setAttr ".gdt" 2;
createNode transform -n "crowdManagerNode";
	addAttr -ci true -sn "trBETabs" -ln "trBETabs" -nn "Behavior Editor Tabs" -dt "string";
	addAttr -ci true -sn "trBECTab" -ln "trBECTab" -nn "Behavior Editor Current Tab" 
		-at "float";
	setAttr ".trBETabs" -type "string" "entityTypeContainerShape1#";
createNode CrowdManagerNode -n "crowdManagerNodeShape" -p "crowdManagerNode";
	setAttr -k off ".v";
	setAttr ".pps" -type "string" "";
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/horseAndRider.gcha";
	setAttr ".drm" -type "string" "";
lockNode -l 1 ;
createNode transform -n "entityType1";
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
createNode CrowdEntityTypeNode -n "entityTypeShape1" -p "entityType1";
	setAttr -k off ".v";
	setAttr -l on ".etid" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/horseAndRider.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 52 ;
	setAttr ".bf" 3;
createNode transform -n "crowdBehaviors";
createNode transform -n "entityTypeContainer1" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape1" -p "entityTypeContainer1";
	setAttr -k off ".v";
createNode transform -n "crowdTriggers" -p "crowdBehaviors";
createNode transform -n "beAdaptGround1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beAdaptGround1StartTriggerShape" -p "beAdaptGround1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd1" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape1" -p "triOpAnd1";
	setAttr -k off ".v";
createNode transform -n "triBool1" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape1" -p "triBool1";
	setAttr -k off ".v";
createNode transform -n "beAdaptGround1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beAdaptGround1StopTriggerShape" -p "beAdaptGround1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd2" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape2" -p "triOpAnd2";
	setAttr -k off ".v";
createNode transform -n "triBool2" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape2" -p "triBool2";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beAdaptOrientation1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beAdaptOrientation1StartTriggerShape" -p "beAdaptOrientation1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd3" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape3" -p "triOpAnd3";
	setAttr -k off ".v";
createNode transform -n "triBool3" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape3" -p "triBool3";
	setAttr -k off ".v";
createNode transform -n "beAdaptOrientation1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beAdaptOrientation1StopTriggerShape" -p "beAdaptOrientation1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd4" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape4" -p "triOpAnd4";
	setAttr -k off ".v";
createNode transform -n "triBool4" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape4" -p "triBool4";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion1StartTriggerShape" -p "beMotion1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd5" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape5" -p "triOpAnd5";
	setAttr -k off ".v";
createNode transform -n "triBool5" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape5" -p "triBool5";
	setAttr -k off ".v";
createNode transform -n "beMotion1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion1StopTriggerShape" -p "beMotion1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd6" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape6" -p "triOpAnd6";
	setAttr -k off ".v";
createNode transform -n "triBool6" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape6" -p "triBool6";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion1" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape1" -p "beMotion1";
	setAttr -k off ".v";
	setAttr ".bpy" -41;
	setAttr ".spma" 1;
createNode transform -n "crowdMotionClips" -p "crowdBehaviors";
createNode transform -n "horseAndRider_galop1" -p "crowdMotionClips";
createNode MotionClip -n "horseAndRider_galopShape1" -p "horseAndRider_galop1";
	setAttr -k off ".v";
	setAttr ".mcid" 1;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/HorseAndRider/horseAndRider_galop.gmo";
	setAttr ".aur" yes;
createNode transform -n "beAdaptGround1" -p "crowdBehaviors";
createNode CrowdBeAdaptGround -n "beAdaptGroundShape1" -p "beAdaptGround1";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".dc" -type "float3" 0 1 1 ;
	setAttr ".em" 1;
	setAttr ".mlhdr" 0.40000000596046448;
	setAttr ".rclf" 3;
createNode transform -n "beOpParallel1" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape1" -p "beOpParallel1";
	setAttr -k off ".v";
	setAttr ".bpx" 404;
	setAttr ".bpy" 195;
createNode transform -n "beAdaptOrientation1" -p "crowdBehaviors";
createNode CrowdBeAdaptOrientation -n "beAdaptOrientationShape1" -p "beAdaptOrientation1";
	setAttr -k off ".v";
	setAttr ".bpy" 82;
	setAttr ".dc" -type "float3" 1 1 0 ;
	setAttr ".atm" 2;
createNode transform -n "popTool1";
	setAttr ".t" -type "double3" -33.482898712158203 0 -8.2910281079623225 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "popToolShape1" -p "popTool1";
	setAttr -k off ".v";
	setAttr ".np" 75;
	setAttr ".npp" 75;
	setAttr ".r" 1.4;
	setAttr ".dst" 3;
	setAttr ".n" 1.978609621484968;
	setAttr ".qp" yes;
	setAttr ".nr" 30;
	setAttr ".nc" 6;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 75 -26.864400863647461 15.820219993591309 -12.516183853149414 -26.054393768310547
		 17.139926910400391 17.197418212890625 -24.765762329101563 17.073705673217773 28.376914978027344 -38.896232604980469
		 16.176088333129883 -23.814613342285156 -29.418460845947266 17.457365036010742 -51.947044372558594 -25.699359893798828
		 17.736490249633789 -48.853172302246094 -35.132110595703125 16.246089935302734 -23.067417144775391 -37.608516693115234
		 16.757196426391602 10.635451316833496 -39.027904510498047 17.125175476074219 16.226284027099609 -25.559391021728516
		 16.728403091430664 11.216660499572754 -24.544826507568359 16.163599014282227 6.2673959732055664 -37.273468017578125
		 16.453689575195313 5.3088512420654297 -38.267105102539063 16.635814666748047 -35.352714538574219 -33.09637451171875
		 16.955684661865234 17.974411010742188 -26.284078598022461 16.281240463256836 -18.796279907226562 -32.153202056884766
		 15.723841667175293 -6.9905552864074707 -24.507816314697266 16.827192306518555 34.956024169921875 -39.097148895263672
		 16.929698944091797 36.134849548339844 -32.496936798095703 16.382308959960938 -20.109214782714844 -35.42901611328125
		 16.176961898803711 2.1298055648803711 -39.952507019042969 16.425661087036133 -14.89146614074707 -28.960081100463867
		 17.576356887817383 -39.845874786376953 -31.845748901367188 15.827305793762207 0.51006889343261719 -38.373340606689453
		 16.189542770385742 0.62446308135986328 -35.615718841552734 16.530895233154297 26.575473785400391 -32.01611328125
		 16.710353851318359 11.264241218566895 -41.135211944580078 17.2647705078125 -44.575946807861328 -33.807071685791016
		 16.658203125 -28.648277282714844 -41.310554504394531 17.187416076660156 -40.912132263183594 -40.766853332519531
		 16.800199508666992 20.379749298095703 -34.593391418457031 17.277654647827148 -41.221405029296875 -29.711748123168945
		 16.998287200927734 19.104484558105469 -32.099266052246094 16.683450698852539 35.142364501953125 -27.48193359375
		 16.852245330810547 26.656101226806641 -29.108341217041016 15.633248329162598 -4.2149195671081543 -33.419643402099609
		 16.663795471191406 22.634941101074219 -40.714500427246094 16.262479782104492 -9.8884849548339844 -28.669103622436523
		 16.879217147827148 13.993815422058105 -25.735328674316406 16.496366500854492 -24.457969665527344 -30.779769897460938
		 16.960578918457031 -30.304531097412109 -33.123035430908203 17.437627792358398 -47.940555572509766 -31.639963150024414
		 15.826882362365723 -11.363254547119141 -28.838705062866211 16.806991577148437 -28.166065216064453 -34.903793334960938
		 16.867374420166016 20.166118621826172 -39.622482299804688 16.438573837280273 -27.551113128662109 -28.065757751464844
		 16.580942153930664 32.135185241699219 -25.762699127197266 17.196504592895508 23.134151458740234 -32.789905548095703
		 16.294168472290039 4.8068819046020508 -35.766044616699219 17.127771377563477 -52.411262512207031 -34.648933410644531
		 16.76496696472168 -33.217212677001953 -33.560272216796875 16.649959564208984 31.562351226806641 -25.514884948730469
		 17.843849182128906 -43.733955383300781 -36.446144104003906 15.911502838134766 -9.3986873626708984 -39.565055847167969
		 16.724824905395508 25.699977874755859 -32.097381591796875 17.290355682373047 -38.258243560791016 -37.860889434814453
		 16.537134170532227 23.454593658447266 -28.991436004638672 16.417552947998047 -21.173259735107422 -36.241195678710938
		 17.272090911865234 -45.799831390380859 -31.529094696044922 16.457149505615234 -25.067192077636719 -29.48829460144043
		 15.81843090057373 2.0803842544555664 -40.985397338867188 17.006355285644531 14.216471672058105 -39.776039123535156
		 16.608388900756836 8.0858736038208008 -41.316417694091797 16.595073699951172 -33.007183074951172 -34.902290344238281
		 16.152347564697266 -15.619907379150391 -37.053371429443359 16.576848983764648 -31.750148773193359 -40.241237640380859
		 16.911314010620117 31.679882049560547 -31.947904586791992 16.327342987060547 29.264347076416016 -34.005752563476562
		 15.75053882598877 -4.7947664260864258 -28.962146759033203 17.272789001464844 -33.768165588378906 -28.78143310546875
		 17.703334808349609 -46.902317047119141 -36.796321868896484 17.209104537963867 -43.049491882324219 -29.092226028442383
		 15.718238830566406 -10.167970657348633 -36.452064514160156 16.954349517822266 13.925557136535645 -37.190753936767578
		 16.051301956176758 -12.148433685302734 -40.105297088623047 16.241325378417969 -20.327487945556641 ;
	setAttr ".pto" -type "vectorArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 75 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 ;
	setAttr ".poo" -type "doubleArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 75 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 75 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".get" -type "doubleArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 75 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 ;
	setAttr ".etc" -type "vectorArray" 75 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1
		 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "persp1";
	setAttr ".t" -type "double3" 4.8907378924114973 82.407043501294879 100.77523769093092 ;
	setAttr ".r" -type "double3" -29.138352729602367 8.6000000000000174 4.0209028513368361e-016 ;
createNode camera -n "perspShape2" -p "persp1";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 124.53332960780337;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -n "directionalLight1";
	setAttr ".t" -type "double3" 0 49.715022112096861 0 ;
	setAttr ".r" -type "double3" -100.92171769639572 -13.410229086266918 -50.238955247211301 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
	setAttr ".rdl" 1;
	setAttr ".phi" 8000;
createNode transform -n "pPlane1";
	setAttr ".t" -type "double3" -1.1815447814300448 15.93003955481938 -6.140867525426934 ;
	setAttr ".s" -type "double3" 1 0.5 1 ;
createNode mesh -n "pPlane1Shape" -p "pPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 2601 ".uvst[0].uvsp";
	setAttr ".uvst[0].uvsp[0:249]" -type "float2" 0 0 0.02 0 0.039999999 0 0.059999999
		 0 0.079999998 0 0.099999994 0 0.12 0 0.14 0 0.16 0 0.17999999 0 0.19999999 0 0.22
		 0 0.23999999 0 0.25999999 0 0.28 0 0.29999998 0 0.31999999 0 0.34 0 0.35999998 0
		 0.38 0 0.39999998 0 0.41999999 0 0.44 0 0.45999998 0 0.47999999 0 0.5 0 0.51999998
		 0 0.53999996 0 0.56 0 0.57999998 0 0.59999996 0 0.62 0 0.63999999 0 0.65999997 0
		 0.68000001 0 0.69999999 0 0.71999997 0 0.74000001 0 0.75999999 0 0.77999997 0 0.79999995
		 0 0.81999999 0 0.83999997 0 0.85999995 0 0.88 0 0.89999998 0 0.91999996 0 0.94 0
		 0.95999998 0 0.97999996 0 1 0 0 0.013333334 0.02 0.013333334 0.039999999 0.013333334
		 0.059999999 0.013333334 0.079999998 0.013333334 0.099999994 0.013333334 0.12 0.013333334
		 0.14 0.013333334 0.16 0.013333334 0.17999999 0.013333334 0.19999999 0.013333334 0.22
		 0.013333334 0.23999999 0.013333334 0.25999999 0.013333334 0.28 0.013333334 0.29999998
		 0.013333334 0.31999999 0.013333334 0.34 0.013333334 0.35999998 0.013333334 0.38 0.013333334
		 0.39999998 0.013333334 0.41999999 0.013333334 0.44 0.013333334 0.45999998 0.013333334
		 0.47999999 0.013333334 0.5 0.013333334 0.51999998 0.013333334 0.53999996 0.013333334
		 0.56 0.013333334 0.57999998 0.013333334 0.59999996 0.013333334 0.62 0.013333334 0.63999999
		 0.013333334 0.65999997 0.013333334 0.68000001 0.013333334 0.69999999 0.013333334
		 0.71999997 0.013333334 0.74000001 0.013333334 0.75999999 0.013333334 0.77999997 0.013333334
		 0.79999995 0.013333334 0.81999999 0.013333334 0.83999997 0.013333334 0.85999995 0.013333334
		 0.88 0.013333334 0.89999998 0.013333334 0.91999996 0.013333334 0.94 0.013333334 0.95999998
		 0.013333334 0.97999996 0.013333334 1 0.013333334 0 0.026666667 0.02 0.026666667 0.039999999
		 0.026666667 0.059999999 0.026666667 0.079999998 0.026666667 0.099999994 0.026666667
		 0.12 0.026666667 0.14 0.026666667 0.16 0.026666667 0.17999999 0.026666667 0.19999999
		 0.026666667 0.22 0.026666667 0.23999999 0.026666667 0.25999999 0.026666667 0.28 0.026666667
		 0.29999998 0.026666667 0.31999999 0.026666667 0.34 0.026666667 0.35999998 0.026666667
		 0.38 0.026666667 0.39999998 0.026666667 0.41999999 0.026666667 0.44 0.026666667 0.45999998
		 0.026666667 0.47999999 0.026666667 0.5 0.026666667 0.51999998 0.026666667 0.53999996
		 0.026666667 0.56 0.026666667 0.57999998 0.026666667 0.59999996 0.026666667 0.62 0.026666667
		 0.63999999 0.026666667 0.65999997 0.026666667 0.68000001 0.026666667 0.69999999 0.026666667
		 0.71999997 0.026666667 0.74000001 0.026666667 0.75999999 0.026666667 0.77999997 0.026666667
		 0.79999995 0.026666667 0.81999999 0.026666667 0.83999997 0.026666667 0.85999995 0.026666667
		 0.88 0.026666667 0.89999998 0.026666667 0.91999996 0.026666667 0.94 0.026666667 0.95999998
		 0.026666667 0.97999996 0.026666667 1 0.026666667 0 0.039999999 0.02 0.039999999 0.039999999
		 0.039999999 0.059999999 0.039999999 0.079999998 0.039999999 0.099999994 0.039999999
		 0.12 0.039999999 0.14 0.039999999 0.16 0.039999999 0.17999999 0.039999999 0.19999999
		 0.039999999 0.22 0.039999999 0.23999999 0.039999999 0.25999999 0.039999999 0.28 0.039999999
		 0.29999998 0.039999999 0.31999999 0.039999999 0.34 0.039999999 0.35999998 0.039999999
		 0.38 0.039999999 0.39999998 0.039999999 0.41999999 0.039999999 0.44 0.039999999 0.45999998
		 0.039999999 0.47999999 0.039999999 0.5 0.039999999 0.51999998 0.039999999 0.53999996
		 0.039999999 0.56 0.039999999 0.57999998 0.039999999 0.59999996 0.039999999 0.62 0.039999999
		 0.63999999 0.039999999 0.65999997 0.039999999 0.68000001 0.039999999 0.69999999 0.039999999
		 0.71999997 0.039999999 0.74000001 0.039999999 0.75999999 0.039999999 0.77999997 0.039999999
		 0.79999995 0.039999999 0.81999999 0.039999999 0.83999997 0.039999999 0.85999995 0.039999999
		 0.88 0.039999999 0.89999998 0.039999999 0.91999996 0.039999999 0.94 0.039999999 0.95999998
		 0.039999999 0.97999996 0.039999999 1 0.039999999 0 0.053333335 0.02 0.053333335 0.039999999
		 0.053333335 0.059999999 0.053333335 0.079999998 0.053333335 0.099999994 0.053333335
		 0.12 0.053333335 0.14 0.053333335 0.16 0.053333335 0.17999999 0.053333335 0.19999999
		 0.053333335 0.22 0.053333335 0.23999999 0.053333335 0.25999999 0.053333335 0.28 0.053333335
		 0.29999998 0.053333335 0.31999999 0.053333335 0.34 0.053333335 0.35999998 0.053333335
		 0.38 0.053333335 0.39999998 0.053333335 0.41999999 0.053333335 0.44 0.053333335 0.45999998
		 0.053333335 0.47999999 0.053333335 0.5 0.053333335 0.51999998 0.053333335 0.53999996
		 0.053333335 0.56 0.053333335 0.57999998 0.053333335 0.59999996 0.053333335 0.62 0.053333335
		 0.63999999 0.053333335 0.65999997 0.053333335 0.68000001 0.053333335 0.69999999 0.053333335
		 0.71999997 0.053333335 0.74000001 0.053333335 0.75999999 0.053333335 0.77999997 0.053333335
		 0.79999995 0.053333335 0.81999999 0.053333335 0.83999997 0.053333335 0.85999995 0.053333335
		 0.88 0.053333335 0.89999998 0.053333335;
	setAttr ".uvst[0].uvsp[250:499]" 0.91999996 0.053333335 0.94 0.053333335 0.95999998
		 0.053333335 0.97999996 0.053333335 1 0.053333335 0 0.06666667 0.02 0.06666667 0.039999999
		 0.06666667 0.059999999 0.06666667 0.079999998 0.06666667 0.099999994 0.06666667 0.12
		 0.06666667 0.14 0.06666667 0.16 0.06666667 0.17999999 0.06666667 0.19999999 0.06666667
		 0.22 0.06666667 0.23999999 0.06666667 0.25999999 0.06666667 0.28 0.06666667 0.29999998
		 0.06666667 0.31999999 0.06666667 0.34 0.06666667 0.35999998 0.06666667 0.38 0.06666667
		 0.39999998 0.06666667 0.41999999 0.06666667 0.44 0.06666667 0.45999998 0.06666667
		 0.47999999 0.06666667 0.5 0.06666667 0.51999998 0.06666667 0.53999996 0.06666667
		 0.56 0.06666667 0.57999998 0.06666667 0.59999996 0.06666667 0.62 0.06666667 0.63999999
		 0.06666667 0.65999997 0.06666667 0.68000001 0.06666667 0.69999999 0.06666667 0.71999997
		 0.06666667 0.74000001 0.06666667 0.75999999 0.06666667 0.77999997 0.06666667 0.79999995
		 0.06666667 0.81999999 0.06666667 0.83999997 0.06666667 0.85999995 0.06666667 0.88
		 0.06666667 0.89999998 0.06666667 0.91999996 0.06666667 0.94 0.06666667 0.95999998
		 0.06666667 0.97999996 0.06666667 1 0.06666667 0 0.079999998 0.02 0.079999998 0.039999999
		 0.079999998 0.059999999 0.079999998 0.079999998 0.079999998 0.099999994 0.079999998
		 0.12 0.079999998 0.14 0.079999998 0.16 0.079999998 0.17999999 0.079999998 0.19999999
		 0.079999998 0.22 0.079999998 0.23999999 0.079999998 0.25999999 0.079999998 0.28 0.079999998
		 0.29999998 0.079999998 0.31999999 0.079999998 0.34 0.079999998 0.35999998 0.079999998
		 0.38 0.079999998 0.39999998 0.079999998 0.41999999 0.079999998 0.44 0.079999998 0.45999998
		 0.079999998 0.47999999 0.079999998 0.5 0.079999998 0.51999998 0.079999998 0.53999996
		 0.079999998 0.56 0.079999998 0.57999998 0.079999998 0.59999996 0.079999998 0.62 0.079999998
		 0.63999999 0.079999998 0.65999997 0.079999998 0.68000001 0.079999998 0.69999999 0.079999998
		 0.71999997 0.079999998 0.74000001 0.079999998 0.75999999 0.079999998 0.77999997 0.079999998
		 0.79999995 0.079999998 0.81999999 0.079999998 0.83999997 0.079999998 0.85999995 0.079999998
		 0.88 0.079999998 0.89999998 0.079999998 0.91999996 0.079999998 0.94 0.079999998 0.95999998
		 0.079999998 0.97999996 0.079999998 1 0.079999998 0 0.093333334 0.02 0.093333334 0.039999999
		 0.093333334 0.059999999 0.093333334 0.079999998 0.093333334 0.099999994 0.093333334
		 0.12 0.093333334 0.14 0.093333334 0.16 0.093333334 0.17999999 0.093333334 0.19999999
		 0.093333334 0.22 0.093333334 0.23999999 0.093333334 0.25999999 0.093333334 0.28 0.093333334
		 0.29999998 0.093333334 0.31999999 0.093333334 0.34 0.093333334 0.35999998 0.093333334
		 0.38 0.093333334 0.39999998 0.093333334 0.41999999 0.093333334 0.44 0.093333334 0.45999998
		 0.093333334 0.47999999 0.093333334 0.5 0.093333334 0.51999998 0.093333334 0.53999996
		 0.093333334 0.56 0.093333334 0.57999998 0.093333334 0.59999996 0.093333334 0.62 0.093333334
		 0.63999999 0.093333334 0.65999997 0.093333334 0.68000001 0.093333334 0.69999999 0.093333334
		 0.71999997 0.093333334 0.74000001 0.093333334 0.75999999 0.093333334 0.77999997 0.093333334
		 0.79999995 0.093333334 0.81999999 0.093333334 0.83999997 0.093333334 0.85999995 0.093333334
		 0.88 0.093333334 0.89999998 0.093333334 0.91999996 0.093333334 0.94 0.093333334 0.95999998
		 0.093333334 0.97999996 0.093333334 1 0.093333334 0 0.10666667 0.02 0.10666667 0.039999999
		 0.10666667 0.059999999 0.10666667 0.079999998 0.10666667 0.099999994 0.10666667 0.12
		 0.10666667 0.14 0.10666667 0.16 0.10666667 0.17999999 0.10666667 0.19999999 0.10666667
		 0.22 0.10666667 0.23999999 0.10666667 0.25999999 0.10666667 0.28 0.10666667 0.29999998
		 0.10666667 0.31999999 0.10666667 0.34 0.10666667 0.35999998 0.10666667 0.38 0.10666667
		 0.39999998 0.10666667 0.41999999 0.10666667 0.44 0.10666667 0.45999998 0.10666667
		 0.47999999 0.10666667 0.5 0.10666667 0.51999998 0.10666667 0.53999996 0.10666667
		 0.56 0.10666667 0.57999998 0.10666667 0.59999996 0.10666667 0.62 0.10666667 0.63999999
		 0.10666667 0.65999997 0.10666667 0.68000001 0.10666667 0.69999999 0.10666667 0.71999997
		 0.10666667 0.74000001 0.10666667 0.75999999 0.10666667 0.77999997 0.10666667 0.79999995
		 0.10666667 0.81999999 0.10666667 0.83999997 0.10666667 0.85999995 0.10666667 0.88
		 0.10666667 0.89999998 0.10666667 0.91999996 0.10666667 0.94 0.10666667 0.95999998
		 0.10666667 0.97999996 0.10666667 1 0.10666667 0 0.12 0.02 0.12 0.039999999 0.12 0.059999999
		 0.12 0.079999998 0.12 0.099999994 0.12 0.12 0.12 0.14 0.12 0.16 0.12 0.17999999 0.12
		 0.19999999 0.12 0.22 0.12 0.23999999 0.12 0.25999999 0.12 0.28 0.12 0.29999998 0.12
		 0.31999999 0.12 0.34 0.12 0.35999998 0.12 0.38 0.12 0.39999998 0.12 0.41999999 0.12
		 0.44 0.12 0.45999998 0.12 0.47999999 0.12 0.5 0.12 0.51999998 0.12 0.53999996 0.12
		 0.56 0.12 0.57999998 0.12 0.59999996 0.12 0.62 0.12 0.63999999 0.12 0.65999997 0.12
		 0.68000001 0.12 0.69999999 0.12 0.71999997 0.12 0.74000001 0.12 0.75999999 0.12 0.77999997
		 0.12 0.79999995 0.12;
	setAttr ".uvst[0].uvsp[500:749]" 0.81999999 0.12 0.83999997 0.12 0.85999995
		 0.12 0.88 0.12 0.89999998 0.12 0.91999996 0.12 0.94 0.12 0.95999998 0.12 0.97999996
		 0.12 1 0.12 0 0.13333334 0.02 0.13333334 0.039999999 0.13333334 0.059999999 0.13333334
		 0.079999998 0.13333334 0.099999994 0.13333334 0.12 0.13333334 0.14 0.13333334 0.16
		 0.13333334 0.17999999 0.13333334 0.19999999 0.13333334 0.22 0.13333334 0.23999999
		 0.13333334 0.25999999 0.13333334 0.28 0.13333334 0.29999998 0.13333334 0.31999999
		 0.13333334 0.34 0.13333334 0.35999998 0.13333334 0.38 0.13333334 0.39999998 0.13333334
		 0.41999999 0.13333334 0.44 0.13333334 0.45999998 0.13333334 0.47999999 0.13333334
		 0.5 0.13333334 0.51999998 0.13333334 0.53999996 0.13333334 0.56 0.13333334 0.57999998
		 0.13333334 0.59999996 0.13333334 0.62 0.13333334 0.63999999 0.13333334 0.65999997
		 0.13333334 0.68000001 0.13333334 0.69999999 0.13333334 0.71999997 0.13333334 0.74000001
		 0.13333334 0.75999999 0.13333334 0.77999997 0.13333334 0.79999995 0.13333334 0.81999999
		 0.13333334 0.83999997 0.13333334 0.85999995 0.13333334 0.88 0.13333334 0.89999998
		 0.13333334 0.91999996 0.13333334 0.94 0.13333334 0.95999998 0.13333334 0.97999996
		 0.13333334 1 0.13333334 0 0.14666668 0.02 0.14666668 0.039999999 0.14666668 0.059999999
		 0.14666668 0.079999998 0.14666668 0.099999994 0.14666668 0.12 0.14666668 0.14 0.14666668
		 0.16 0.14666668 0.17999999 0.14666668 0.19999999 0.14666668 0.22 0.14666668 0.23999999
		 0.14666668 0.25999999 0.14666668 0.28 0.14666668 0.29999998 0.14666668 0.31999999
		 0.14666668 0.34 0.14666668 0.35999998 0.14666668 0.38 0.14666668 0.39999998 0.14666668
		 0.41999999 0.14666668 0.44 0.14666668 0.45999998 0.14666668 0.47999999 0.14666668
		 0.5 0.14666668 0.51999998 0.14666668 0.53999996 0.14666668 0.56 0.14666668 0.57999998
		 0.14666668 0.59999996 0.14666668 0.62 0.14666668 0.63999999 0.14666668 0.65999997
		 0.14666668 0.68000001 0.14666668 0.69999999 0.14666668 0.71999997 0.14666668 0.74000001
		 0.14666668 0.75999999 0.14666668 0.77999997 0.14666668 0.79999995 0.14666668 0.81999999
		 0.14666668 0.83999997 0.14666668 0.85999995 0.14666668 0.88 0.14666668 0.89999998
		 0.14666668 0.91999996 0.14666668 0.94 0.14666668 0.95999998 0.14666668 0.97999996
		 0.14666668 1 0.14666668 0 0.16 0.02 0.16 0.039999999 0.16 0.059999999 0.16 0.079999998
		 0.16 0.099999994 0.16 0.12 0.16 0.14 0.16 0.16 0.16 0.17999999 0.16 0.19999999 0.16
		 0.22 0.16 0.23999999 0.16 0.25999999 0.16 0.28 0.16 0.29999998 0.16 0.31999999 0.16
		 0.34 0.16 0.35999998 0.16 0.38 0.16 0.39999998 0.16 0.41999999 0.16 0.44 0.16 0.45999998
		 0.16 0.47999999 0.16 0.5 0.16 0.51999998 0.16 0.53999996 0.16 0.56 0.16 0.57999998
		 0.16 0.59999996 0.16 0.62 0.16 0.63999999 0.16 0.65999997 0.16 0.68000001 0.16 0.69999999
		 0.16 0.71999997 0.16 0.74000001 0.16 0.75999999 0.16 0.77999997 0.16 0.79999995 0.16
		 0.81999999 0.16 0.83999997 0.16 0.85999995 0.16 0.88 0.16 0.89999998 0.16 0.91999996
		 0.16 0.94 0.16 0.95999998 0.16 0.97999996 0.16 1 0.16 0 0.17333333 0.02 0.17333333
		 0.039999999 0.17333333 0.059999999 0.17333333 0.079999998 0.17333333 0.099999994
		 0.17333333 0.12 0.17333333 0.14 0.17333333 0.16 0.17333333 0.17999999 0.17333333
		 0.19999999 0.17333333 0.22 0.17333333 0.23999999 0.17333333 0.25999999 0.17333333
		 0.28 0.17333333 0.29999998 0.17333333 0.31999999 0.17333333 0.34 0.17333333 0.35999998
		 0.17333333 0.38 0.17333333 0.39999998 0.17333333 0.41999999 0.17333333 0.44 0.17333333
		 0.45999998 0.17333333 0.47999999 0.17333333 0.5 0.17333333 0.51999998 0.17333333
		 0.53999996 0.17333333 0.56 0.17333333 0.57999998 0.17333333 0.59999996 0.17333333
		 0.62 0.17333333 0.63999999 0.17333333 0.65999997 0.17333333 0.68000001 0.17333333
		 0.69999999 0.17333333 0.71999997 0.17333333 0.74000001 0.17333333 0.75999999 0.17333333
		 0.77999997 0.17333333 0.79999995 0.17333333 0.81999999 0.17333333 0.83999997 0.17333333
		 0.85999995 0.17333333 0.88 0.17333333 0.89999998 0.17333333 0.91999996 0.17333333
		 0.94 0.17333333 0.95999998 0.17333333 0.97999996 0.17333333 1 0.17333333 0 0.18666667
		 0.02 0.18666667 0.039999999 0.18666667 0.059999999 0.18666667 0.079999998 0.18666667
		 0.099999994 0.18666667 0.12 0.18666667 0.14 0.18666667 0.16 0.18666667 0.17999999
		 0.18666667 0.19999999 0.18666667 0.22 0.18666667 0.23999999 0.18666667 0.25999999
		 0.18666667 0.28 0.18666667 0.29999998 0.18666667 0.31999999 0.18666667 0.34 0.18666667
		 0.35999998 0.18666667 0.38 0.18666667 0.39999998 0.18666667 0.41999999 0.18666667
		 0.44 0.18666667 0.45999998 0.18666667 0.47999999 0.18666667 0.5 0.18666667 0.51999998
		 0.18666667 0.53999996 0.18666667 0.56 0.18666667 0.57999998 0.18666667 0.59999996
		 0.18666667 0.62 0.18666667 0.63999999 0.18666667 0.65999997 0.18666667 0.68000001
		 0.18666667 0.69999999 0.18666667;
	setAttr ".uvst[0].uvsp[750:999]" 0.71999997 0.18666667 0.74000001 0.18666667
		 0.75999999 0.18666667 0.77999997 0.18666667 0.79999995 0.18666667 0.81999999 0.18666667
		 0.83999997 0.18666667 0.85999995 0.18666667 0.88 0.18666667 0.89999998 0.18666667
		 0.91999996 0.18666667 0.94 0.18666667 0.95999998 0.18666667 0.97999996 0.18666667
		 1 0.18666667 0 0.2 0.02 0.2 0.039999999 0.2 0.059999999 0.2 0.079999998 0.2 0.099999994
		 0.2 0.12 0.2 0.14 0.2 0.16 0.2 0.17999999 0.2 0.19999999 0.2 0.22 0.2 0.23999999
		 0.2 0.25999999 0.2 0.28 0.2 0.29999998 0.2 0.31999999 0.2 0.34 0.2 0.35999998 0.2
		 0.38 0.2 0.39999998 0.2 0.41999999 0.2 0.44 0.2 0.45999998 0.2 0.47999999 0.2 0.5
		 0.2 0.51999998 0.2 0.53999996 0.2 0.56 0.2 0.57999998 0.2 0.59999996 0.2 0.62 0.2
		 0.63999999 0.2 0.65999997 0.2 0.68000001 0.2 0.69999999 0.2 0.71999997 0.2 0.74000001
		 0.2 0.75999999 0.2 0.77999997 0.2 0.79999995 0.2 0.81999999 0.2 0.83999997 0.2 0.85999995
		 0.2 0.88 0.2 0.89999998 0.2 0.91999996 0.2 0.94 0.2 0.95999998 0.2 0.97999996 0.2
		 1 0.2 0 0.21333334 0.02 0.21333334 0.039999999 0.21333334 0.059999999 0.21333334
		 0.079999998 0.21333334 0.099999994 0.21333334 0.12 0.21333334 0.14 0.21333334 0.16
		 0.21333334 0.17999999 0.21333334 0.19999999 0.21333334 0.22 0.21333334 0.23999999
		 0.21333334 0.25999999 0.21333334 0.28 0.21333334 0.29999998 0.21333334 0.31999999
		 0.21333334 0.34 0.21333334 0.35999998 0.21333334 0.38 0.21333334 0.39999998 0.21333334
		 0.41999999 0.21333334 0.44 0.21333334 0.45999998 0.21333334 0.47999999 0.21333334
		 0.5 0.21333334 0.51999998 0.21333334 0.53999996 0.21333334 0.56 0.21333334 0.57999998
		 0.21333334 0.59999996 0.21333334 0.62 0.21333334 0.63999999 0.21333334 0.65999997
		 0.21333334 0.68000001 0.21333334 0.69999999 0.21333334 0.71999997 0.21333334 0.74000001
		 0.21333334 0.75999999 0.21333334 0.77999997 0.21333334 0.79999995 0.21333334 0.81999999
		 0.21333334 0.83999997 0.21333334 0.85999995 0.21333334 0.88 0.21333334 0.89999998
		 0.21333334 0.91999996 0.21333334 0.94 0.21333334 0.95999998 0.21333334 0.97999996
		 0.21333334 1 0.21333334 0 0.22666667 0.02 0.22666667 0.039999999 0.22666667 0.059999999
		 0.22666667 0.079999998 0.22666667 0.099999994 0.22666667 0.12 0.22666667 0.14 0.22666667
		 0.16 0.22666667 0.17999999 0.22666667 0.19999999 0.22666667 0.22 0.22666667 0.23999999
		 0.22666667 0.25999999 0.22666667 0.28 0.22666667 0.29999998 0.22666667 0.31999999
		 0.22666667 0.34 0.22666667 0.35999998 0.22666667 0.38 0.22666667 0.39999998 0.22666667
		 0.41999999 0.22666667 0.44 0.22666667 0.45999998 0.22666667 0.47999999 0.22666667
		 0.5 0.22666667 0.51999998 0.22666667 0.53999996 0.22666667 0.56 0.22666667 0.57999998
		 0.22666667 0.59999996 0.22666667 0.62 0.22666667 0.63999999 0.22666667 0.65999997
		 0.22666667 0.68000001 0.22666667 0.69999999 0.22666667 0.71999997 0.22666667 0.74000001
		 0.22666667 0.75999999 0.22666667 0.77999997 0.22666667 0.79999995 0.22666667 0.81999999
		 0.22666667 0.83999997 0.22666667 0.85999995 0.22666667 0.88 0.22666667 0.89999998
		 0.22666667 0.91999996 0.22666667 0.94 0.22666667 0.95999998 0.22666667 0.97999996
		 0.22666667 1 0.22666667 0 0.24000001 0.02 0.24000001 0.039999999 0.24000001 0.059999999
		 0.24000001 0.079999998 0.24000001 0.099999994 0.24000001 0.12 0.24000001 0.14 0.24000001
		 0.16 0.24000001 0.17999999 0.24000001 0.19999999 0.24000001 0.22 0.24000001 0.23999999
		 0.24000001 0.25999999 0.24000001 0.28 0.24000001 0.29999998 0.24000001 0.31999999
		 0.24000001 0.34 0.24000001 0.35999998 0.24000001 0.38 0.24000001 0.39999998 0.24000001
		 0.41999999 0.24000001 0.44 0.24000001 0.45999998 0.24000001 0.47999999 0.24000001
		 0.5 0.24000001 0.51999998 0.24000001 0.53999996 0.24000001 0.56 0.24000001 0.57999998
		 0.24000001 0.59999996 0.24000001 0.62 0.24000001 0.63999999 0.24000001 0.65999997
		 0.24000001 0.68000001 0.24000001 0.69999999 0.24000001 0.71999997 0.24000001 0.74000001
		 0.24000001 0.75999999 0.24000001 0.77999997 0.24000001 0.79999995 0.24000001 0.81999999
		 0.24000001 0.83999997 0.24000001 0.85999995 0.24000001 0.88 0.24000001 0.89999998
		 0.24000001 0.91999996 0.24000001 0.94 0.24000001 0.95999998 0.24000001 0.97999996
		 0.24000001 1 0.24000001 0 0.25333333 0.02 0.25333333 0.039999999 0.25333333 0.059999999
		 0.25333333 0.079999998 0.25333333 0.099999994 0.25333333 0.12 0.25333333 0.14 0.25333333
		 0.16 0.25333333 0.17999999 0.25333333 0.19999999 0.25333333 0.22 0.25333333 0.23999999
		 0.25333333 0.25999999 0.25333333 0.28 0.25333333 0.29999998 0.25333333 0.31999999
		 0.25333333 0.34 0.25333333 0.35999998 0.25333333 0.38 0.25333333 0.39999998 0.25333333
		 0.41999999 0.25333333 0.44 0.25333333 0.45999998 0.25333333 0.47999999 0.25333333
		 0.5 0.25333333 0.51999998 0.25333333 0.53999996 0.25333333 0.56 0.25333333 0.57999998
		 0.25333333 0.59999996 0.25333333;
	setAttr ".uvst[0].uvsp[1000:1249]" 0.62 0.25333333 0.63999999 0.25333333 0.65999997
		 0.25333333 0.68000001 0.25333333 0.69999999 0.25333333 0.71999997 0.25333333 0.74000001
		 0.25333333 0.75999999 0.25333333 0.77999997 0.25333333 0.79999995 0.25333333 0.81999999
		 0.25333333 0.83999997 0.25333333 0.85999995 0.25333333 0.88 0.25333333 0.89999998
		 0.25333333 0.91999996 0.25333333 0.94 0.25333333 0.95999998 0.25333333 0.97999996
		 0.25333333 1 0.25333333 0 0.26666668 0.02 0.26666668 0.039999999 0.26666668 0.059999999
		 0.26666668 0.079999998 0.26666668 0.099999994 0.26666668 0.12 0.26666668 0.14 0.26666668
		 0.16 0.26666668 0.17999999 0.26666668 0.19999999 0.26666668 0.22 0.26666668 0.23999999
		 0.26666668 0.25999999 0.26666668 0.28 0.26666668 0.29999998 0.26666668 0.31999999
		 0.26666668 0.34 0.26666668 0.35999998 0.26666668 0.38 0.26666668 0.39999998 0.26666668
		 0.41999999 0.26666668 0.44 0.26666668 0.45999998 0.26666668 0.47999999 0.26666668
		 0.5 0.26666668 0.51999998 0.26666668 0.53999996 0.26666668 0.56 0.26666668 0.57999998
		 0.26666668 0.59999996 0.26666668 0.62 0.26666668 0.63999999 0.26666668 0.65999997
		 0.26666668 0.68000001 0.26666668 0.69999999 0.26666668 0.71999997 0.26666668 0.74000001
		 0.26666668 0.75999999 0.26666668 0.77999997 0.26666668 0.79999995 0.26666668 0.81999999
		 0.26666668 0.83999997 0.26666668 0.85999995 0.26666668 0.88 0.26666668 0.89999998
		 0.26666668 0.91999996 0.26666668 0.94 0.26666668 0.95999998 0.26666668 0.97999996
		 0.26666668 1 0.26666668 0 0.28 0.02 0.28 0.039999999 0.28 0.059999999 0.28 0.079999998
		 0.28 0.099999994 0.28 0.12 0.28 0.14 0.28 0.16 0.28 0.17999999 0.28 0.19999999 0.28
		 0.22 0.28 0.23999999 0.28 0.25999999 0.28 0.28 0.28 0.29999998 0.28 0.31999999 0.28
		 0.34 0.28 0.35999998 0.28 0.38 0.28 0.39999998 0.28 0.41999999 0.28 0.44 0.28 0.45999998
		 0.28 0.47999999 0.28 0.5 0.28 0.51999998 0.28 0.53999996 0.28 0.56 0.28 0.57999998
		 0.28 0.59999996 0.28 0.62 0.28 0.63999999 0.28 0.65999997 0.28 0.68000001 0.28 0.69999999
		 0.28 0.71999997 0.28 0.74000001 0.28 0.75999999 0.28 0.77999997 0.28 0.79999995 0.28
		 0.81999999 0.28 0.83999997 0.28 0.85999995 0.28 0.88 0.28 0.89999998 0.28 0.91999996
		 0.28 0.94 0.28 0.95999998 0.28 0.97999996 0.28 1 0.28 0 0.29333335 0.02 0.29333335
		 0.039999999 0.29333335 0.059999999 0.29333335 0.079999998 0.29333335 0.099999994
		 0.29333335 0.12 0.29333335 0.14 0.29333335 0.16 0.29333335 0.17999999 0.29333335
		 0.19999999 0.29333335 0.22 0.29333335 0.23999999 0.29333335 0.25999999 0.29333335
		 0.28 0.29333335 0.29999998 0.29333335 0.31999999 0.29333335 0.34 0.29333335 0.35999998
		 0.29333335 0.38 0.29333335 0.39999998 0.29333335 0.41999999 0.29333335 0.44 0.29333335
		 0.45999998 0.29333335 0.47999999 0.29333335 0.5 0.29333335 0.51999998 0.29333335
		 0.53999996 0.29333335 0.56 0.29333335 0.57999998 0.29333335 0.59999996 0.29333335
		 0.62 0.29333335 0.63999999 0.29333335 0.65999997 0.29333335 0.68000001 0.29333335
		 0.69999999 0.29333335 0.71999997 0.29333335 0.74000001 0.29333335 0.75999999 0.29333335
		 0.77999997 0.29333335 0.79999995 0.29333335 0.81999999 0.29333335 0.83999997 0.29333335
		 0.85999995 0.29333335 0.88 0.29333335 0.89999998 0.29333335 0.91999996 0.29333335
		 0.94 0.29333335 0.95999998 0.29333335 0.97999996 0.29333335 1 0.29333335 0 0.30666667
		 0.02 0.30666667 0.039999999 0.30666667 0.059999999 0.30666667 0.079999998 0.30666667
		 0.099999994 0.30666667 0.12 0.30666667 0.14 0.30666667 0.16 0.30666667 0.17999999
		 0.30666667 0.19999999 0.30666667 0.22 0.30666667 0.23999999 0.30666667 0.25999999
		 0.30666667 0.28 0.30666667 0.29999998 0.30666667 0.31999999 0.30666667 0.34 0.30666667
		 0.35999998 0.30666667 0.38 0.30666667 0.39999998 0.30666667 0.41999999 0.30666667
		 0.44 0.30666667 0.45999998 0.30666667 0.47999999 0.30666667 0.5 0.30666667 0.51999998
		 0.30666667 0.53999996 0.30666667 0.56 0.30666667 0.57999998 0.30666667 0.59999996
		 0.30666667 0.62 0.30666667 0.63999999 0.30666667 0.65999997 0.30666667 0.68000001
		 0.30666667 0.69999999 0.30666667 0.71999997 0.30666667 0.74000001 0.30666667 0.75999999
		 0.30666667 0.77999997 0.30666667 0.79999995 0.30666667 0.81999999 0.30666667 0.83999997
		 0.30666667 0.85999995 0.30666667 0.88 0.30666667 0.89999998 0.30666667 0.91999996
		 0.30666667 0.94 0.30666667 0.95999998 0.30666667 0.97999996 0.30666667 1 0.30666667
		 0 0.31999999 0.02 0.31999999 0.039999999 0.31999999 0.059999999 0.31999999 0.079999998
		 0.31999999 0.099999994 0.31999999 0.12 0.31999999 0.14 0.31999999 0.16 0.31999999
		 0.17999999 0.31999999 0.19999999 0.31999999 0.22 0.31999999 0.23999999 0.31999999
		 0.25999999 0.31999999 0.28 0.31999999 0.29999998 0.31999999 0.31999999 0.31999999
		 0.34 0.31999999 0.35999998 0.31999999 0.38 0.31999999 0.39999998 0.31999999 0.41999999
		 0.31999999 0.44 0.31999999 0.45999998 0.31999999 0.47999999 0.31999999 0.5 0.31999999;
	setAttr ".uvst[0].uvsp[1250:1499]" 0.51999998 0.31999999 0.53999996 0.31999999
		 0.56 0.31999999 0.57999998 0.31999999 0.59999996 0.31999999 0.62 0.31999999 0.63999999
		 0.31999999 0.65999997 0.31999999 0.68000001 0.31999999 0.69999999 0.31999999 0.71999997
		 0.31999999 0.74000001 0.31999999 0.75999999 0.31999999 0.77999997 0.31999999 0.79999995
		 0.31999999 0.81999999 0.31999999 0.83999997 0.31999999 0.85999995 0.31999999 0.88
		 0.31999999 0.89999998 0.31999999 0.91999996 0.31999999 0.94 0.31999999 0.95999998
		 0.31999999 0.97999996 0.31999999 1 0.31999999 0 0.33333334 0.02 0.33333334 0.039999999
		 0.33333334 0.059999999 0.33333334 0.079999998 0.33333334 0.099999994 0.33333334 0.12
		 0.33333334 0.14 0.33333334 0.16 0.33333334 0.17999999 0.33333334 0.19999999 0.33333334
		 0.22 0.33333334 0.23999999 0.33333334 0.25999999 0.33333334 0.28 0.33333334 0.29999998
		 0.33333334 0.31999999 0.33333334 0.34 0.33333334 0.35999998 0.33333334 0.38 0.33333334
		 0.39999998 0.33333334 0.41999999 0.33333334 0.44 0.33333334 0.45999998 0.33333334
		 0.47999999 0.33333334 0.5 0.33333334 0.51999998 0.33333334 0.53999996 0.33333334
		 0.56 0.33333334 0.57999998 0.33333334 0.59999996 0.33333334 0.62 0.33333334 0.63999999
		 0.33333334 0.65999997 0.33333334 0.68000001 0.33333334 0.69999999 0.33333334 0.71999997
		 0.33333334 0.74000001 0.33333334 0.75999999 0.33333334 0.77999997 0.33333334 0.79999995
		 0.33333334 0.81999999 0.33333334 0.83999997 0.33333334 0.85999995 0.33333334 0.88
		 0.33333334 0.89999998 0.33333334 0.91999996 0.33333334 0.94 0.33333334 0.95999998
		 0.33333334 0.97999996 0.33333334 1 0.33333334 0 0.34666666 0.02 0.34666666 0.039999999
		 0.34666666 0.059999999 0.34666666 0.079999998 0.34666666 0.099999994 0.34666666 0.12
		 0.34666666 0.14 0.34666666 0.16 0.34666666 0.17999999 0.34666666 0.19999999 0.34666666
		 0.22 0.34666666 0.23999999 0.34666666 0.25999999 0.34666666 0.28 0.34666666 0.29999998
		 0.34666666 0.31999999 0.34666666 0.34 0.34666666 0.35999998 0.34666666 0.38 0.34666666
		 0.39999998 0.34666666 0.41999999 0.34666666 0.44 0.34666666 0.45999998 0.34666666
		 0.47999999 0.34666666 0.5 0.34666666 0.51999998 0.34666666 0.53999996 0.34666666
		 0.56 0.34666666 0.57999998 0.34666666 0.59999996 0.34666666 0.62 0.34666666 0.63999999
		 0.34666666 0.65999997 0.34666666 0.68000001 0.34666666 0.69999999 0.34666666 0.71999997
		 0.34666666 0.74000001 0.34666666 0.75999999 0.34666666 0.77999997 0.34666666 0.79999995
		 0.34666666 0.81999999 0.34666666 0.83999997 0.34666666 0.85999995 0.34666666 0.88
		 0.34666666 0.89999998 0.34666666 0.91999996 0.34666666 0.94 0.34666666 0.95999998
		 0.34666666 0.97999996 0.34666666 1 0.34666666 0 0.36000001 0.02 0.36000001 0.039999999
		 0.36000001 0.059999999 0.36000001 0.079999998 0.36000001 0.099999994 0.36000001 0.12
		 0.36000001 0.14 0.36000001 0.16 0.36000001 0.17999999 0.36000001 0.19999999 0.36000001
		 0.22 0.36000001 0.23999999 0.36000001 0.25999999 0.36000001 0.28 0.36000001 0.29999998
		 0.36000001 0.31999999 0.36000001 0.34 0.36000001 0.35999998 0.36000001 0.38 0.36000001
		 0.39999998 0.36000001 0.41999999 0.36000001 0.44 0.36000001 0.45999998 0.36000001
		 0.47999999 0.36000001 0.5 0.36000001 0.51999998 0.36000001 0.53999996 0.36000001
		 0.56 0.36000001 0.57999998 0.36000001 0.59999996 0.36000001 0.62 0.36000001 0.63999999
		 0.36000001 0.65999997 0.36000001 0.68000001 0.36000001 0.69999999 0.36000001 0.71999997
		 0.36000001 0.74000001 0.36000001 0.75999999 0.36000001 0.77999997 0.36000001 0.79999995
		 0.36000001 0.81999999 0.36000001 0.83999997 0.36000001 0.85999995 0.36000001 0.88
		 0.36000001 0.89999998 0.36000001 0.91999996 0.36000001 0.94 0.36000001 0.95999998
		 0.36000001 0.97999996 0.36000001 1 0.36000001 0 0.37333333 0.02 0.37333333 0.039999999
		 0.37333333 0.059999999 0.37333333 0.079999998 0.37333333 0.099999994 0.37333333 0.12
		 0.37333333 0.14 0.37333333 0.16 0.37333333 0.17999999 0.37333333 0.19999999 0.37333333
		 0.22 0.37333333 0.23999999 0.37333333 0.25999999 0.37333333 0.28 0.37333333 0.29999998
		 0.37333333 0.31999999 0.37333333 0.34 0.37333333 0.35999998 0.37333333 0.38 0.37333333
		 0.39999998 0.37333333 0.41999999 0.37333333 0.44 0.37333333 0.45999998 0.37333333
		 0.47999999 0.37333333 0.5 0.37333333 0.51999998 0.37333333 0.53999996 0.37333333
		 0.56 0.37333333 0.57999998 0.37333333 0.59999996 0.37333333 0.62 0.37333333 0.63999999
		 0.37333333 0.65999997 0.37333333 0.68000001 0.37333333 0.69999999 0.37333333 0.71999997
		 0.37333333 0.74000001 0.37333333 0.75999999 0.37333333 0.77999997 0.37333333 0.79999995
		 0.37333333 0.81999999 0.37333333 0.83999997 0.37333333 0.85999995 0.37333333 0.88
		 0.37333333 0.89999998 0.37333333 0.91999996 0.37333333 0.94 0.37333333 0.95999998
		 0.37333333 0.97999996 0.37333333 1 0.37333333 0 0.38666669 0.02 0.38666669 0.039999999
		 0.38666669 0.059999999 0.38666669 0.079999998 0.38666669 0.099999994 0.38666669 0.12
		 0.38666669 0.14 0.38666669 0.16 0.38666669 0.17999999 0.38666669 0.19999999 0.38666669
		 0.22 0.38666669 0.23999999 0.38666669 0.25999999 0.38666669 0.28 0.38666669 0.29999998
		 0.38666669 0.31999999 0.38666669 0.34 0.38666669 0.35999998 0.38666669 0.38 0.38666669
		 0.39999998 0.38666669;
	setAttr ".uvst[0].uvsp[1500:1749]" 0.41999999 0.38666669 0.44 0.38666669 0.45999998
		 0.38666669 0.47999999 0.38666669 0.5 0.38666669 0.51999998 0.38666669 0.53999996
		 0.38666669 0.56 0.38666669 0.57999998 0.38666669 0.59999996 0.38666669 0.62 0.38666669
		 0.63999999 0.38666669 0.65999997 0.38666669 0.68000001 0.38666669 0.69999999 0.38666669
		 0.71999997 0.38666669 0.74000001 0.38666669 0.75999999 0.38666669 0.77999997 0.38666669
		 0.79999995 0.38666669 0.81999999 0.38666669 0.83999997 0.38666669 0.85999995 0.38666669
		 0.88 0.38666669 0.89999998 0.38666669 0.91999996 0.38666669 0.94 0.38666669 0.95999998
		 0.38666669 0.97999996 0.38666669 1 0.38666669 0 0.40000001 0.02 0.40000001 0.039999999
		 0.40000001 0.059999999 0.40000001 0.079999998 0.40000001 0.099999994 0.40000001 0.12
		 0.40000001 0.14 0.40000001 0.16 0.40000001 0.17999999 0.40000001 0.19999999 0.40000001
		 0.22 0.40000001 0.23999999 0.40000001 0.25999999 0.40000001 0.28 0.40000001 0.29999998
		 0.40000001 0.31999999 0.40000001 0.34 0.40000001 0.35999998 0.40000001 0.38 0.40000001
		 0.39999998 0.40000001 0.41999999 0.40000001 0.44 0.40000001 0.45999998 0.40000001
		 0.47999999 0.40000001 0.5 0.40000001 0.51999998 0.40000001 0.53999996 0.40000001
		 0.56 0.40000001 0.57999998 0.40000001 0.59999996 0.40000001 0.62 0.40000001 0.63999999
		 0.40000001 0.65999997 0.40000001 0.68000001 0.40000001 0.69999999 0.40000001 0.71999997
		 0.40000001 0.74000001 0.40000001 0.75999999 0.40000001 0.77999997 0.40000001 0.79999995
		 0.40000001 0.81999999 0.40000001 0.83999997 0.40000001 0.85999995 0.40000001 0.88
		 0.40000001 0.89999998 0.40000001 0.91999996 0.40000001 0.94 0.40000001 0.95999998
		 0.40000001 0.97999996 0.40000001 1 0.40000001 0 0.41333336 0.02 0.41333336 0.039999999
		 0.41333336 0.059999999 0.41333336 0.079999998 0.41333336 0.099999994 0.41333336 0.12
		 0.41333336 0.14 0.41333336 0.16 0.41333336 0.17999999 0.41333336 0.19999999 0.41333336
		 0.22 0.41333336 0.23999999 0.41333336 0.25999999 0.41333336 0.28 0.41333336 0.29999998
		 0.41333336 0.31999999 0.41333336 0.34 0.41333336 0.35999998 0.41333336 0.38 0.41333336
		 0.39999998 0.41333336 0.41999999 0.41333336 0.44 0.41333336 0.45999998 0.41333336
		 0.47999999 0.41333336 0.5 0.41333336 0.51999998 0.41333336 0.53999996 0.41333336
		 0.56 0.41333336 0.57999998 0.41333336 0.59999996 0.41333336 0.62 0.41333336 0.63999999
		 0.41333336 0.65999997 0.41333336 0.68000001 0.41333336 0.69999999 0.41333336 0.71999997
		 0.41333336 0.74000001 0.41333336 0.75999999 0.41333336 0.77999997 0.41333336 0.79999995
		 0.41333336 0.81999999 0.41333336 0.83999997 0.41333336 0.85999995 0.41333336 0.88
		 0.41333336 0.89999998 0.41333336 0.91999996 0.41333336 0.94 0.41333336 0.95999998
		 0.41333336 0.97999996 0.41333336 1 0.41333336 0 0.42666668 0.02 0.42666668 0.039999999
		 0.42666668 0.059999999 0.42666668 0.079999998 0.42666668 0.099999994 0.42666668 0.12
		 0.42666668 0.14 0.42666668 0.16 0.42666668 0.17999999 0.42666668 0.19999999 0.42666668
		 0.22 0.42666668 0.23999999 0.42666668 0.25999999 0.42666668 0.28 0.42666668 0.29999998
		 0.42666668 0.31999999 0.42666668 0.34 0.42666668 0.35999998 0.42666668 0.38 0.42666668
		 0.39999998 0.42666668 0.41999999 0.42666668 0.44 0.42666668 0.45999998 0.42666668
		 0.47999999 0.42666668 0.5 0.42666668 0.51999998 0.42666668 0.53999996 0.42666668
		 0.56 0.42666668 0.57999998 0.42666668 0.59999996 0.42666668 0.62 0.42666668 0.63999999
		 0.42666668 0.65999997 0.42666668 0.68000001 0.42666668 0.69999999 0.42666668 0.71999997
		 0.42666668 0.74000001 0.42666668 0.75999999 0.42666668 0.77999997 0.42666668 0.79999995
		 0.42666668 0.81999999 0.42666668 0.83999997 0.42666668 0.85999995 0.42666668 0.88
		 0.42666668 0.89999998 0.42666668 0.91999996 0.42666668 0.94 0.42666668 0.95999998
		 0.42666668 0.97999996 0.42666668 1 0.42666668 0 0.44 0.02 0.44 0.039999999 0.44 0.059999999
		 0.44 0.079999998 0.44 0.099999994 0.44 0.12 0.44 0.14 0.44 0.16 0.44 0.17999999 0.44
		 0.19999999 0.44 0.22 0.44 0.23999999 0.44 0.25999999 0.44 0.28 0.44 0.29999998 0.44
		 0.31999999 0.44 0.34 0.44 0.35999998 0.44 0.38 0.44 0.39999998 0.44 0.41999999 0.44
		 0.44 0.44 0.45999998 0.44 0.47999999 0.44 0.5 0.44 0.51999998 0.44 0.53999996 0.44
		 0.56 0.44 0.57999998 0.44 0.59999996 0.44 0.62 0.44 0.63999999 0.44 0.65999997 0.44
		 0.68000001 0.44 0.69999999 0.44 0.71999997 0.44 0.74000001 0.44 0.75999999 0.44 0.77999997
		 0.44 0.79999995 0.44 0.81999999 0.44 0.83999997 0.44 0.85999995 0.44 0.88 0.44 0.89999998
		 0.44 0.91999996 0.44 0.94 0.44 0.95999998 0.44 0.97999996 0.44 1 0.44 0 0.45333335
		 0.02 0.45333335 0.039999999 0.45333335 0.059999999 0.45333335 0.079999998 0.45333335
		 0.099999994 0.45333335 0.12 0.45333335 0.14 0.45333335 0.16 0.45333335 0.17999999
		 0.45333335 0.19999999 0.45333335 0.22 0.45333335 0.23999999 0.45333335 0.25999999
		 0.45333335 0.28 0.45333335 0.29999998 0.45333335;
	setAttr ".uvst[0].uvsp[1750:1999]" 0.31999999 0.45333335 0.34 0.45333335 0.35999998
		 0.45333335 0.38 0.45333335 0.39999998 0.45333335 0.41999999 0.45333335 0.44 0.45333335
		 0.45999998 0.45333335 0.47999999 0.45333335 0.5 0.45333335 0.51999998 0.45333335
		 0.53999996 0.45333335 0.56 0.45333335 0.57999998 0.45333335 0.59999996 0.45333335
		 0.62 0.45333335 0.63999999 0.45333335 0.65999997 0.45333335 0.68000001 0.45333335
		 0.69999999 0.45333335 0.71999997 0.45333335 0.74000001 0.45333335 0.75999999 0.45333335
		 0.77999997 0.45333335 0.79999995 0.45333335 0.81999999 0.45333335 0.83999997 0.45333335
		 0.85999995 0.45333335 0.88 0.45333335 0.89999998 0.45333335 0.91999996 0.45333335
		 0.94 0.45333335 0.95999998 0.45333335 0.97999996 0.45333335 1 0.45333335 0 0.46666667
		 0.02 0.46666667 0.039999999 0.46666667 0.059999999 0.46666667 0.079999998 0.46666667
		 0.099999994 0.46666667 0.12 0.46666667 0.14 0.46666667 0.16 0.46666667 0.17999999
		 0.46666667 0.19999999 0.46666667 0.22 0.46666667 0.23999999 0.46666667 0.25999999
		 0.46666667 0.28 0.46666667 0.29999998 0.46666667 0.31999999 0.46666667 0.34 0.46666667
		 0.35999998 0.46666667 0.38 0.46666667 0.39999998 0.46666667 0.41999999 0.46666667
		 0.44 0.46666667 0.45999998 0.46666667 0.47999999 0.46666667 0.5 0.46666667 0.51999998
		 0.46666667 0.53999996 0.46666667 0.56 0.46666667 0.57999998 0.46666667 0.59999996
		 0.46666667 0.62 0.46666667 0.63999999 0.46666667 0.65999997 0.46666667 0.68000001
		 0.46666667 0.69999999 0.46666667 0.71999997 0.46666667 0.74000001 0.46666667 0.75999999
		 0.46666667 0.77999997 0.46666667 0.79999995 0.46666667 0.81999999 0.46666667 0.83999997
		 0.46666667 0.85999995 0.46666667 0.88 0.46666667 0.89999998 0.46666667 0.91999996
		 0.46666667 0.94 0.46666667 0.95999998 0.46666667 0.97999996 0.46666667 1 0.46666667
		 0 0.48000002 0.02 0.48000002 0.039999999 0.48000002 0.059999999 0.48000002 0.079999998
		 0.48000002 0.099999994 0.48000002 0.12 0.48000002 0.14 0.48000002 0.16 0.48000002
		 0.17999999 0.48000002 0.19999999 0.48000002 0.22 0.48000002 0.23999999 0.48000002
		 0.25999999 0.48000002 0.28 0.48000002 0.29999998 0.48000002 0.31999999 0.48000002
		 0.34 0.48000002 0.35999998 0.48000002 0.38 0.48000002 0.39999998 0.48000002 0.41999999
		 0.48000002 0.44 0.48000002 0.45999998 0.48000002 0.47999999 0.48000002 0.5 0.48000002
		 0.51999998 0.48000002 0.53999996 0.48000002 0.56 0.48000002 0.57999998 0.48000002
		 0.59999996 0.48000002 0.62 0.48000002 0.63999999 0.48000002 0.65999997 0.48000002
		 0.68000001 0.48000002 0.69999999 0.48000002 0.71999997 0.48000002 0.74000001 0.48000002
		 0.75999999 0.48000002 0.77999997 0.48000002 0.79999995 0.48000002 0.81999999 0.48000002
		 0.83999997 0.48000002 0.85999995 0.48000002 0.88 0.48000002 0.89999998 0.48000002
		 0.91999996 0.48000002 0.94 0.48000002 0.95999998 0.48000002 0.97999996 0.48000002
		 1 0.48000002 0 0.49333334 0.02 0.49333334 0.039999999 0.49333334 0.059999999 0.49333334
		 0.079999998 0.49333334 0.099999994 0.49333334 0.12 0.49333334 0.14 0.49333334 0.16
		 0.49333334 0.17999999 0.49333334 0.19999999 0.49333334 0.22 0.49333334 0.23999999
		 0.49333334 0.25999999 0.49333334 0.28 0.49333334 0.29999998 0.49333334 0.31999999
		 0.49333334 0.34 0.49333334 0.35999998 0.49333334 0.38 0.49333334 0.39999998 0.49333334
		 0.41999999 0.49333334 0.44 0.49333334 0.45999998 0.49333334 0.47999999 0.49333334
		 0.5 0.49333334 0.51999998 0.49333334 0.53999996 0.49333334 0.56 0.49333334 0.57999998
		 0.49333334 0.59999996 0.49333334 0.62 0.49333334 0.63999999 0.49333334 0.65999997
		 0.49333334 0.68000001 0.49333334 0.69999999 0.49333334 0.71999997 0.49333334 0.74000001
		 0.49333334 0.75999999 0.49333334 0.77999997 0.49333334 0.79999995 0.49333334 0.81999999
		 0.49333334 0.83999997 0.49333334 0.85999995 0.49333334 0.88 0.49333334 0.89999998
		 0.49333334 0.91999996 0.49333334 0.94 0.49333334 0.95999998 0.49333334 0.97999996
		 0.49333334 1 0.49333334 0 0.50666666 0.02 0.50666666 0.039999999 0.50666666 0.059999999
		 0.50666666 0.079999998 0.50666666 0.099999994 0.50666666 0.12 0.50666666 0.14 0.50666666
		 0.16 0.50666666 0.17999999 0.50666666 0.19999999 0.50666666 0.22 0.50666666 0.23999999
		 0.50666666 0.25999999 0.50666666 0.28 0.50666666 0.29999998 0.50666666 0.31999999
		 0.50666666 0.34 0.50666666 0.35999998 0.50666666 0.38 0.50666666 0.39999998 0.50666666
		 0.41999999 0.50666666 0.44 0.50666666 0.45999998 0.50666666 0.47999999 0.50666666
		 0.5 0.50666666 0.51999998 0.50666666 0.53999996 0.50666666 0.56 0.50666666 0.57999998
		 0.50666666 0.59999996 0.50666666 0.62 0.50666666 0.63999999 0.50666666 0.65999997
		 0.50666666 0.68000001 0.50666666 0.69999999 0.50666666 0.71999997 0.50666666 0.74000001
		 0.50666666 0.75999999 0.50666666 0.77999997 0.50666666 0.79999995 0.50666666 0.81999999
		 0.50666666 0.83999997 0.50666666 0.85999995 0.50666666 0.88 0.50666666 0.89999998
		 0.50666666 0.91999996 0.50666666 0.94 0.50666666 0.95999998 0.50666666 0.97999996
		 0.50666666 1 0.50666666 0 0.52000004 0.02 0.52000004 0.039999999 0.52000004 0.059999999
		 0.52000004 0.079999998 0.52000004 0.099999994 0.52000004 0.12 0.52000004 0.14 0.52000004
		 0.16 0.52000004 0.17999999 0.52000004 0.19999999 0.52000004;
	setAttr ".uvst[0].uvsp[2000:2249]" 0.22 0.52000004 0.23999999 0.52000004 0.25999999
		 0.52000004 0.28 0.52000004 0.29999998 0.52000004 0.31999999 0.52000004 0.34 0.52000004
		 0.35999998 0.52000004 0.38 0.52000004 0.39999998 0.52000004 0.41999999 0.52000004
		 0.44 0.52000004 0.45999998 0.52000004 0.47999999 0.52000004 0.5 0.52000004 0.51999998
		 0.52000004 0.53999996 0.52000004 0.56 0.52000004 0.57999998 0.52000004 0.59999996
		 0.52000004 0.62 0.52000004 0.63999999 0.52000004 0.65999997 0.52000004 0.68000001
		 0.52000004 0.69999999 0.52000004 0.71999997 0.52000004 0.74000001 0.52000004 0.75999999
		 0.52000004 0.77999997 0.52000004 0.79999995 0.52000004 0.81999999 0.52000004 0.83999997
		 0.52000004 0.85999995 0.52000004 0.88 0.52000004 0.89999998 0.52000004 0.91999996
		 0.52000004 0.94 0.52000004 0.95999998 0.52000004 0.97999996 0.52000004 1 0.52000004
		 0 0.53333336 0.02 0.53333336 0.039999999 0.53333336 0.059999999 0.53333336 0.079999998
		 0.53333336 0.099999994 0.53333336 0.12 0.53333336 0.14 0.53333336 0.16 0.53333336
		 0.17999999 0.53333336 0.19999999 0.53333336 0.22 0.53333336 0.23999999 0.53333336
		 0.25999999 0.53333336 0.28 0.53333336 0.29999998 0.53333336 0.31999999 0.53333336
		 0.34 0.53333336 0.35999998 0.53333336 0.38 0.53333336 0.39999998 0.53333336 0.41999999
		 0.53333336 0.44 0.53333336 0.45999998 0.53333336 0.47999999 0.53333336 0.5 0.53333336
		 0.51999998 0.53333336 0.53999996 0.53333336 0.56 0.53333336 0.57999998 0.53333336
		 0.59999996 0.53333336 0.62 0.53333336 0.63999999 0.53333336 0.65999997 0.53333336
		 0.68000001 0.53333336 0.69999999 0.53333336 0.71999997 0.53333336 0.74000001 0.53333336
		 0.75999999 0.53333336 0.77999997 0.53333336 0.79999995 0.53333336 0.81999999 0.53333336
		 0.83999997 0.53333336 0.85999995 0.53333336 0.88 0.53333336 0.89999998 0.53333336
		 0.91999996 0.53333336 0.94 0.53333336 0.95999998 0.53333336 0.97999996 0.53333336
		 1 0.53333336 0 0.54666668 0.02 0.54666668 0.039999999 0.54666668 0.059999999 0.54666668
		 0.079999998 0.54666668 0.099999994 0.54666668 0.12 0.54666668 0.14 0.54666668 0.16
		 0.54666668 0.17999999 0.54666668 0.19999999 0.54666668 0.22 0.54666668 0.23999999
		 0.54666668 0.25999999 0.54666668 0.28 0.54666668 0.29999998 0.54666668 0.31999999
		 0.54666668 0.34 0.54666668 0.35999998 0.54666668 0.38 0.54666668 0.39999998 0.54666668
		 0.41999999 0.54666668 0.44 0.54666668 0.45999998 0.54666668 0.47999999 0.54666668
		 0.5 0.54666668 0.51999998 0.54666668 0.53999996 0.54666668 0.56 0.54666668 0.57999998
		 0.54666668 0.59999996 0.54666668 0.62 0.54666668 0.63999999 0.54666668 0.65999997
		 0.54666668 0.68000001 0.54666668 0.69999999 0.54666668 0.71999997 0.54666668 0.74000001
		 0.54666668 0.75999999 0.54666668 0.77999997 0.54666668 0.79999995 0.54666668 0.81999999
		 0.54666668 0.83999997 0.54666668 0.85999995 0.54666668 0.88 0.54666668 0.89999998
		 0.54666668 0.91999996 0.54666668 0.94 0.54666668 0.95999998 0.54666668 0.97999996
		 0.54666668 1 0.54666668 0 0.56 0.02 0.56 0.039999999 0.56 0.059999999 0.56 0.079999998
		 0.56 0.099999994 0.56 0.12 0.56 0.14 0.56 0.16 0.56 0.17999999 0.56 0.19999999 0.56
		 0.22 0.56 0.23999999 0.56 0.25999999 0.56 0.28 0.56 0.29999998 0.56 0.31999999 0.56
		 0.34 0.56 0.35999998 0.56 0.38 0.56 0.39999998 0.56 0.41999999 0.56 0.44 0.56 0.45999998
		 0.56 0.47999999 0.56 0.5 0.56 0.51999998 0.56 0.53999996 0.56 0.56 0.56 0.57999998
		 0.56 0.59999996 0.56 0.62 0.56 0.63999999 0.56 0.65999997 0.56 0.68000001 0.56 0.69999999
		 0.56 0.71999997 0.56 0.74000001 0.56 0.75999999 0.56 0.77999997 0.56 0.79999995 0.56
		 0.81999999 0.56 0.83999997 0.56 0.85999995 0.56 0.88 0.56 0.89999998 0.56 0.91999996
		 0.56 0.94 0.56 0.95999998 0.56 0.97999996 0.56 1 0.56 0 0.57333332 0.02 0.57333332
		 0.039999999 0.57333332 0.059999999 0.57333332 0.079999998 0.57333332 0.099999994
		 0.57333332 0.12 0.57333332 0.14 0.57333332 0.16 0.57333332 0.17999999 0.57333332
		 0.19999999 0.57333332 0.22 0.57333332 0.23999999 0.57333332 0.25999999 0.57333332
		 0.28 0.57333332 0.29999998 0.57333332 0.31999999 0.57333332 0.34 0.57333332 0.35999998
		 0.57333332 0.38 0.57333332 0.39999998 0.57333332 0.41999999 0.57333332 0.44 0.57333332
		 0.45999998 0.57333332 0.47999999 0.57333332 0.5 0.57333332 0.51999998 0.57333332
		 0.53999996 0.57333332 0.56 0.57333332 0.57999998 0.57333332 0.59999996 0.57333332
		 0.62 0.57333332 0.63999999 0.57333332 0.65999997 0.57333332 0.68000001 0.57333332
		 0.69999999 0.57333332 0.71999997 0.57333332 0.74000001 0.57333332 0.75999999 0.57333332
		 0.77999997 0.57333332 0.79999995 0.57333332 0.81999999 0.57333332 0.83999997 0.57333332
		 0.85999995 0.57333332 0.88 0.57333332 0.89999998 0.57333332 0.91999996 0.57333332
		 0.94 0.57333332 0.95999998 0.57333332 0.97999996 0.57333332 1 0.57333332 0 0.5866667
		 0.02 0.5866667 0.039999999 0.5866667 0.059999999 0.5866667 0.079999998 0.5866667
		 0.099999994 0.5866667;
	setAttr ".uvst[0].uvsp[2250:2499]" 0.12 0.5866667 0.14 0.5866667 0.16 0.5866667
		 0.17999999 0.5866667 0.19999999 0.5866667 0.22 0.5866667 0.23999999 0.5866667 0.25999999
		 0.5866667 0.28 0.5866667 0.29999998 0.5866667 0.31999999 0.5866667 0.34 0.5866667
		 0.35999998 0.5866667 0.38 0.5866667 0.39999998 0.5866667 0.41999999 0.5866667 0.44
		 0.5866667 0.45999998 0.5866667 0.47999999 0.5866667 0.5 0.5866667 0.51999998 0.5866667
		 0.53999996 0.5866667 0.56 0.5866667 0.57999998 0.5866667 0.59999996 0.5866667 0.62
		 0.5866667 0.63999999 0.5866667 0.65999997 0.5866667 0.68000001 0.5866667 0.69999999
		 0.5866667 0.71999997 0.5866667 0.74000001 0.5866667 0.75999999 0.5866667 0.77999997
		 0.5866667 0.79999995 0.5866667 0.81999999 0.5866667 0.83999997 0.5866667 0.85999995
		 0.5866667 0.88 0.5866667 0.89999998 0.5866667 0.91999996 0.5866667 0.94 0.5866667
		 0.95999998 0.5866667 0.97999996 0.5866667 1 0.5866667 0 0.60000002 0.02 0.60000002
		 0.039999999 0.60000002 0.059999999 0.60000002 0.079999998 0.60000002 0.099999994
		 0.60000002 0.12 0.60000002 0.14 0.60000002 0.16 0.60000002 0.17999999 0.60000002
		 0.19999999 0.60000002 0.22 0.60000002 0.23999999 0.60000002 0.25999999 0.60000002
		 0.28 0.60000002 0.29999998 0.60000002 0.31999999 0.60000002 0.34 0.60000002 0.35999998
		 0.60000002 0.38 0.60000002 0.39999998 0.60000002 0.41999999 0.60000002 0.44 0.60000002
		 0.45999998 0.60000002 0.47999999 0.60000002 0.5 0.60000002 0.51999998 0.60000002
		 0.53999996 0.60000002 0.56 0.60000002 0.57999998 0.60000002 0.59999996 0.60000002
		 0.62 0.60000002 0.63999999 0.60000002 0.65999997 0.60000002 0.68000001 0.60000002
		 0.69999999 0.60000002 0.71999997 0.60000002 0.74000001 0.60000002 0.75999999 0.60000002
		 0.77999997 0.60000002 0.79999995 0.60000002 0.81999999 0.60000002 0.83999997 0.60000002
		 0.85999995 0.60000002 0.88 0.60000002 0.89999998 0.60000002 0.91999996 0.60000002
		 0.94 0.60000002 0.95999998 0.60000002 0.97999996 0.60000002 1 0.60000002 0 0.61333334
		 0.02 0.61333334 0.039999999 0.61333334 0.059999999 0.61333334 0.079999998 0.61333334
		 0.099999994 0.61333334 0.12 0.61333334 0.14 0.61333334 0.16 0.61333334 0.17999999
		 0.61333334 0.19999999 0.61333334 0.22 0.61333334 0.23999999 0.61333334 0.25999999
		 0.61333334 0.28 0.61333334 0.29999998 0.61333334 0.31999999 0.61333334 0.34 0.61333334
		 0.35999998 0.61333334 0.38 0.61333334 0.39999998 0.61333334 0.41999999 0.61333334
		 0.44 0.61333334 0.45999998 0.61333334 0.47999999 0.61333334 0.5 0.61333334 0.51999998
		 0.61333334 0.53999996 0.61333334 0.56 0.61333334 0.57999998 0.61333334 0.59999996
		 0.61333334 0.62 0.61333334 0.63999999 0.61333334 0.65999997 0.61333334 0.68000001
		 0.61333334 0.69999999 0.61333334 0.71999997 0.61333334 0.74000001 0.61333334 0.75999999
		 0.61333334 0.77999997 0.61333334 0.79999995 0.61333334 0.81999999 0.61333334 0.83999997
		 0.61333334 0.85999995 0.61333334 0.88 0.61333334 0.89999998 0.61333334 0.91999996
		 0.61333334 0.94 0.61333334 0.95999998 0.61333334 0.97999996 0.61333334 1 0.61333334
		 0 0.62666667 0.02 0.62666667 0.039999999 0.62666667 0.059999999 0.62666667 0.079999998
		 0.62666667 0.099999994 0.62666667 0.12 0.62666667 0.14 0.62666667 0.16 0.62666667
		 0.17999999 0.62666667 0.19999999 0.62666667 0.22 0.62666667 0.23999999 0.62666667
		 0.25999999 0.62666667 0.28 0.62666667 0.29999998 0.62666667 0.31999999 0.62666667
		 0.34 0.62666667 0.35999998 0.62666667 0.38 0.62666667 0.39999998 0.62666667 0.41999999
		 0.62666667 0.44 0.62666667 0.45999998 0.62666667 0.47999999 0.62666667 0.5 0.62666667
		 0.51999998 0.62666667 0.53999996 0.62666667 0.56 0.62666667 0.57999998 0.62666667
		 0.59999996 0.62666667 0.62 0.62666667 0.63999999 0.62666667 0.65999997 0.62666667
		 0.68000001 0.62666667 0.69999999 0.62666667 0.71999997 0.62666667 0.74000001 0.62666667
		 0.75999999 0.62666667 0.77999997 0.62666667 0.79999995 0.62666667 0.81999999 0.62666667
		 0.83999997 0.62666667 0.85999995 0.62666667 0.88 0.62666667 0.89999998 0.62666667
		 0.91999996 0.62666667 0.94 0.62666667 0.95999998 0.62666667 0.97999996 0.62666667
		 1 0.62666667 0 0.63999999 0.02 0.63999999 0.039999999 0.63999999 0.059999999 0.63999999
		 0.079999998 0.63999999 0.099999994 0.63999999 0.12 0.63999999 0.14 0.63999999 0.16
		 0.63999999 0.17999999 0.63999999 0.19999999 0.63999999 0.22 0.63999999 0.23999999
		 0.63999999 0.25999999 0.63999999 0.28 0.63999999 0.29999998 0.63999999 0.31999999
		 0.63999999 0.34 0.63999999 0.35999998 0.63999999 0.38 0.63999999 0.39999998 0.63999999
		 0.41999999 0.63999999 0.44 0.63999999 0.45999998 0.63999999 0.47999999 0.63999999
		 0.5 0.63999999 0.51999998 0.63999999 0.53999996 0.63999999 0.56 0.63999999 0.57999998
		 0.63999999 0.59999996 0.63999999 0.62 0.63999999 0.63999999 0.63999999 0.65999997
		 0.63999999 0.68000001 0.63999999 0.69999999 0.63999999 0.71999997 0.63999999 0.74000001
		 0.63999999 0.75999999 0.63999999 0.77999997 0.63999999 0.79999995 0.63999999 0.81999999
		 0.63999999 0.83999997 0.63999999 0.85999995 0.63999999 0.88 0.63999999 0.89999998
		 0.63999999 0.91999996 0.63999999 0.94 0.63999999 0.95999998 0.63999999 0.97999996
		 0.63999999 1 0.63999999 0 0.65333337;
	setAttr ".uvst[0].uvsp[2500:2600]" 0.02 0.65333337 0.039999999 0.65333337 0.059999999
		 0.65333337 0.079999998 0.65333337 0.099999994 0.65333337 0.12 0.65333337 0.14 0.65333337
		 0.16 0.65333337 0.17999999 0.65333337 0.19999999 0.65333337 0.22 0.65333337 0.23999999
		 0.65333337 0.25999999 0.65333337 0.28 0.65333337 0.29999998 0.65333337 0.31999999
		 0.65333337 0.34 0.65333337 0.35999998 0.65333337 0.38 0.65333337 0.39999998 0.65333337
		 0.41999999 0.65333337 0.44 0.65333337 0.45999998 0.65333337 0.47999999 0.65333337
		 0.5 0.65333337 0.51999998 0.65333337 0.53999996 0.65333337 0.56 0.65333337 0.57999998
		 0.65333337 0.59999996 0.65333337 0.62 0.65333337 0.63999999 0.65333337 0.65999997
		 0.65333337 0.68000001 0.65333337 0.69999999 0.65333337 0.71999997 0.65333337 0.74000001
		 0.65333337 0.75999999 0.65333337 0.77999997 0.65333337 0.79999995 0.65333337 0.81999999
		 0.65333337 0.83999997 0.65333337 0.85999995 0.65333337 0.88 0.65333337 0.89999998
		 0.65333337 0.91999996 0.65333337 0.94 0.65333337 0.95999998 0.65333337 0.97999996
		 0.65333337 1 0.65333337 0 0.66666669 0.02 0.66666669 0.039999999 0.66666669 0.059999999
		 0.66666669 0.079999998 0.66666669 0.099999994 0.66666669 0.12 0.66666669 0.14 0.66666669
		 0.16 0.66666669 0.17999999 0.66666669 0.19999999 0.66666669 0.22 0.66666669 0.23999999
		 0.66666669 0.25999999 0.66666669 0.28 0.66666669 0.29999998 0.66666669 0.31999999
		 0.66666669 0.34 0.66666669 0.35999998 0.66666669 0.38 0.66666669 0.39999998 0.66666669
		 0.41999999 0.66666669 0.44 0.66666669 0.45999998 0.66666669 0.47999999 0.66666669
		 0.5 0.66666669 0.51999998 0.66666669 0.53999996 0.66666669 0.56 0.66666669 0.57999998
		 0.66666669 0.59999996 0.66666669 0.62 0.66666669 0.63999999 0.66666669 0.65999997
		 0.66666669 0.68000001 0.66666669 0.69999999 0.66666669 0.71999997 0.66666669 0.74000001
		 0.66666669 0.75999999 0.66666669 0.77999997 0.66666669 0.79999995 0.66666669 0.81999999
		 0.66666669 0.83999997 0.66666669 0.85999995 0.66666669 0.88 0.66666669 0.89999998
		 0.66666669 0.91999996 0.66666669 0.94 0.66666669 0.95999998 0.66666669 0.97999996
		 0.66666669 1 0.66666669;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr -s 1639 ".pt";
	setAttr ".pt[0]" -type "float3" 2.5927496 0.79955047 -1.7795755 ;
	setAttr ".pt[1]" -type "float3" 1.3185458 0.74228114 -1.9620166 ;
	setAttr ".pt[2]" -type "float3" 0.49650067 0.57738936 -1.5618774 ;
	setAttr ".pt[3]" -type "float3" 0.0045308582 0.19950165 -0.31632778 ;
	setAttr ".pt[4]" -type "float3" 0 0.31311101 -0.10310131 ;
	setAttr ".pt[6]" -type "float3" -0.024671771 0.41262853 -0.66374952 ;
	setAttr ".pt[7]" -type "float3" -0.077818833 0.79954326 -0.74179471 ;
	setAttr ".pt[8]" -type "float3" -0.14512351 1.0277059 -0.21763772 ;
	setAttr ".pt[33]" -type "float3" 0.0046492931 0.03136494 -0.093266957 ;
	setAttr ".pt[34]" -type "float3" 0.011597374 0.004235521 -0.23253876 ;
	setAttr ".pt[51]" -type "float3" 2.952009 0.86594534 -0.82034558 ;
	setAttr ".pt[52]" -type "float3" 1.4116005 0.83958799 -0.87553596 ;
	setAttr ".pt[53]" -type "float3" 0.56456834 0.77979761 -0.65691364 ;
	setAttr ".pt[54]" -type "float3" 0.010577677 0.71943915 -0.041243505 ;
	setAttr ".pt[55]" -type "float3" 0.00017337731 0.80374217 -0.013649177 ;
	setAttr ".pt[56]" -type "float3" -0.00011698944 0.30493528 0.00017548417 ;
	setAttr ".pt[57]" -type "float3" -0.039194852 0.66438258 -0.14588588 ;
	setAttr ".pt[58]" -type "float3" -0.092798397 1.0026122 -0.1312144 ;
	setAttr ".pt[59]" -type "float3" -0.16590568 0.88410753 0.13015632 ;
	setAttr ".pt[84]" -type "float3" 0.0075541912 -0.25869432 -0.11200871 ;
	setAttr ".pt[85]" -type "float3" -0.0016102244 -0.28317443 -0.1009201 ;
	setAttr ".pt[87]" -type "float3" -0.042454474 -0.14864857 -0.011812065 ;
	setAttr ".pt[88]" -type "float3" -0.028514091 0.087874271 -0.056607392 ;
	setAttr ".pt[102]" -type "float3" 2.9591737 0.95363241 -0.31406963 ;
	setAttr ".pt[103]" -type "float3" 1.3812778 0.96282655 -0.33784959 ;
	setAttr ".pt[104]" -type "float3" 0.59087485 0.9818669 -0.26165214 ;
	setAttr ".pt[105]" -type "float3" 0.17798105 0.97778869 -0.070697799 ;
	setAttr ".pt[106]" -type "float3" 0.034166615 0.96623564 -0.0021086528 ;
	setAttr ".pt[107]" -type "float3" -0.01339549 0.85425621 0.035331707 ;
	setAttr ".pt[108]" -type "float3" -0.04644246 0.99726182 -0.0027327607 ;
	setAttr ".pt[109]" -type "float3" -0.091594897 1.0363181 0.015911028 ;
	setAttr ".pt[110]" -type "float3" -0.16189378 0.76790988 0.11287978 ;
	setAttr ".pt[134]" -type "float3" 4.2655425e-005 -0.00050311635 -7.8741716e-005 ;
	setAttr ".pt[135]" -type "float3" -0.048321545 -0.33396366 0.025800843 ;
	setAttr ".pt[136]" -type "float3" -0.076821975 -0.40579602 0.063677214 ;
	setAttr ".pt[137]" -type "float3" -0.062904529 -0.22989222 0.080856994 ;
	setAttr ".pt[138]" -type "float3" 0.032472685 -0.32278231 -0.044757675 ;
	setAttr ".pt[139]" -type "float3" 0.093130268 -0.31442305 -0.22340809 ;
	setAttr ".pt[140]" -type "float3" 0.025299156 -0.084187269 -0.10886019 ;
	setAttr ".pt[153]" -type "float3" 2.135227 1.0295966 -0.0016225823 ;
	setAttr ".pt[154]" -type "float3" 1.0244817 1.0828594 -0.060815133 ;
	setAttr ".pt[155]" -type "float3" 0.48591271 1.1795779 -0.053512059 ;
	setAttr ".pt[156]" -type "float3" 0.18806441 1.218082 0.0038158528 ;
	setAttr ".pt[157]" -type "float3" 0.046655394 1.1982896 0.042063605 ;
	setAttr ".pt[158]" -type "float3" -0.015248429 1.1938713 0.062563606 ;
	setAttr ".pt[159]" -type "float3" -0.037641145 1.1369058 0.03857458 ;
	setAttr ".pt[160]" -type "float3" -0.061187461 0.49250406 0.038708415 ;
	setAttr ".pt[161]" -type "float3" -0.078887537 0.5584262 0.05329968 ;
	setAttr ".pt[178]" -type "float3" -0.0023029998 -0.0023974522 -2.8393317e-005 ;
	setAttr ".pt[179]" -type "float3" -0.0076949424 0.019551322 -0.0022646696 ;
	setAttr ".pt[186]" -type "float3" -0.08255405 -0.3443965 0.064033642 ;
	setAttr ".pt[187]" -type "float3" -0.11966406 -0.39995754 0.094448581 ;
	setAttr ".pt[188]" -type "float3" -0.056508772 -0.22187647 0.058823962 ;
	setAttr ".pt[189]" -type "float3" 0.16351758 -0.40482768 -0.11445078 ;
	setAttr ".pt[190]" -type "float3" 0.16477191 -0.73506844 -0.27139819 ;
	setAttr ".pt[191]" -type "float3" -0.058430467 -0.38215289 -0.13582861 ;
	setAttr ".pt[192]" -type "float3" -0.016899828 0.03560767 0.049143054 ;
	setAttr ".pt[204]" -type "float3" 1.1891313 1.0624896 0.079710424 ;
	setAttr ".pt[205]" -type "float3" 0.40445706 1.1678743 0.086798303 ;
	setAttr ".pt[206]" -type "float3" 0.28638831 1.3967644 0.08129669 ;
	setAttr ".pt[207]" -type "float3" 0.12419686 1.4971695 0.086182237 ;
	setAttr ".pt[208]" -type "float3" 0.031137545 1.4844831 0.073512942 ;
	setAttr ".pt[209]" -type "float3" -0.0087529588 1.092236 0.057384163 ;
	setAttr ".pt[210]" -type "float3" -0.024391789 0.48273471 0.039980531 ;
	setAttr ".pt[211]" -type "float3" -0.033789121 0.38631308 0.030741885 ;
	setAttr ".pt[212]" -type "float3" -0.028944861 0.44170359 0.023755975 ;
	setAttr ".pt[229]" -type "float3" -0.010717019 -0.015651604 -0.011867005 ;
	setAttr ".pt[230]" -type "float3" -0.01637331 0.023118136 -0.027024688 ;
	setAttr ".pt[237]" -type "float3" -0.069136083 -0.31343666 0.038612887 ;
	setAttr ".pt[238]" -type "float3" -0.093774647 -0.36018938 0.047660977 ;
	setAttr ".pt[239]" -type "float3" 0.035273984 -0.23919553 -0.01812467 ;
	setAttr ".pt[240]" -type "float3" 0.24514394 -0.51813114 -0.12002097 ;
	setAttr ".pt[241]" -type "float3" 0.1589658 -1.0114793 -0.17455091 ;
	setAttr ".pt[242]" -type "float3" -0.13319957 -0.88428032 -0.099868469 ;
	setAttr ".pt[243]" -type "float3" -0.06442818 -0.013636389 0.017733201 ;
	setAttr ".pt[255]" -type "float3" 1.1329789 1.1797659 0.1735732 ;
	setAttr ".pt[256]" -type "float3" 0.59083074 1.3948039 0.17609528 ;
	setAttr ".pt[257]" -type "float3" 0.27983776 1.619373 0.18106958 ;
	setAttr ".pt[258]" -type "float3" 0.092753328 1.7685188 0.16285884 ;
	setAttr ".pt[259]" -type "float3" 0.01074678 1.4720156 0.079960279 ;
	setAttr ".pt[260]" -type "float3" -0.0060383398 0.72055161 0.046756636 ;
	setAttr ".pt[261]" -type "float3" -0.01421644 0.49263945 0.030496061 ;
	setAttr ".pt[262]" -type "float3" -0.01818485 0.42522788 0.017540313 ;
	setAttr ".pt[263]" -type "float3" -0.01126879 0.41108713 0.0088565312 ;
	setAttr ".pt[280]" -type "float3" -0.013645237 -0.036552563 -0.0090904245 ;
	setAttr ".pt[281]" -type "float3" -0.012270146 3.7973747e-005 -0.016804753 ;
	setAttr ".pt[282]" -type "float3" 0.00422636 -0.026051762 -0.012518724 ;
	setAttr ".pt[288]" -type "float3" -0.0069740117 -0.20438576 0.017576057 ;
	setAttr ".pt[289]" -type "float3" -0.023423467 -0.33524436 0.031325713 ;
	setAttr ".pt[290]" -type "float3" 0.094057769 -0.30470684 -0.0085643176 ;
	setAttr ".pt[291]" -type "float3" 0.22466418 -0.63061661 -0.0078728627 ;
	setAttr ".pt[292]" -type "float3" 0.10132007 -0.96631402 0.051893305 ;
	setAttr ".pt[293]" -type "float3" -0.16411927 -1.1717857 0.062231474 ;
	setAttr ".pt[294]" -type "float3" -0.096228823 -0.25343242 0.025592405 ;
	setAttr ".pt[295]" -type "float3" -0.00025847941 -0.001436236 0.00029963325 ;
	setAttr ".pt[306]" -type "float3" 2.729599 1.6097029 0.19179711 ;
	setAttr ".pt[307]" -type "float3" 1.2300624 1.7392111 0.20751749 ;
	setAttr ".pt[308]" -type "float3" 0.45154536 1.9019505 0.2441417 ;
	setAttr ".pt[309]" -type "float3" 0.013979316 1.9363276 0.30826518 ;
	setAttr ".pt[310]" -type "float3" 0.014438095 1.1153222 0.11992024 ;
	setAttr ".pt[311]" -type "float3" 0.002129138 0.76168191 0.050684948 ;
	setAttr ".pt[312]" -type "float3" -0.0039994563 0.61322618 0.028544893 ;
	setAttr ".pt[313]" -type "float3" -0.0089147398 0.48292813 0.011543595 ;
	setAttr ".pt[314]" -type "float3" -0.0055496618 0.40402105 0.00054170558 ;
	setAttr ".pt[323]" -type "float3" 0.0088115688 -0.015938833 0.0034623696 ;
	setAttr ".pt[324]" -type "float3" 0.0013723201 -0.0069891647 0.00024891287 ;
	setAttr ".pt[331]" -type "float3" -0.016620781 -0.072816901 0.0063893585 ;
	setAttr ".pt[332]" -type "float3" -0.01034081 -0.033471037 0.0038184845 ;
	setAttr ".pt[333]" -type "float3" 0.00062028738 -0.10534531 0.00045403198 ;
	setAttr ".pt[339]" -type "float3" 0.00041941597 -0.0053657363 0.0022192928 ;
	setAttr ".pt[340]" -type "float3" 0.006811481 -0.096645668 0.047727913 ;
	setAttr ".pt[341]" -type "float3" 0.066152662 -0.089867048 0.031097038 ;
	setAttr ".pt[342]" -type "float3" 0.10138968 -0.1367562 0.053948551 ;
	setAttr ".pt[343]" -type "float3" 0.038627878 -0.44949722 0.13974521 ;
	setAttr ".pt[344]" -type "float3" -0.053732149 -0.5609141 0.14691399 ;
	setAttr ".pt[345]" -type "float3" 0.032534424 0.082728043 0.010772344 ;
	setAttr ".pt[346]" -type "float3" 0.041766938 0.29727328 -0.017142486 ;
	setAttr ".pt[357]" -type "float3" 3.66746 2.0110493 0.14672682 ;
	setAttr ".pt[358]" -type "float3" 1.7823176 2.119391 0.1715301 ;
	setAttr ".pt[359]" -type "float3" 0.69277209 2.2724943 0.21991418 ;
	setAttr ".pt[360]" -type "float3" 0.021409076 1.7400894 0.29440096 ;
	setAttr ".pt[361]" -type "float3" 0.026902912 1.1976626 0.1329529 ;
	setAttr ".pt[362]" -type "float3" 0.019708045 0.96211767 0.059555817 ;
	setAttr ".pt[363]" -type "float3" 0.01114661 0.74802339 0.029387061 ;
	setAttr ".pt[364]" -type "float3" -0.00064657792 0.53454787 0.010605546 ;
	setAttr ".pt[365]" -type "float3" -0.0042501292 0.37650058 0.00070612377 ;
	setAttr ".pt[373]" -type "float3" -0.00022697871 0.040264823 0.00054137857 ;
	setAttr ".pt[374]" -type "float3" 0.038288429 -0.18722886 -0.0046620015 ;
	setAttr ".pt[375]" -type "float3" 0.013768711 -0.13567191 0.0073926928 ;
	setAttr ".pt[377]" -type "float3" 0.0024043503 -0.073181711 0.0072642416 ;
	setAttr ".pt[378]" -type "float3" -0.00022509145 -0.00036081896 -5.3686254e-006 ;
	setAttr ".pt[382]" -type "float3" -0.019047163 -0.14516221 0.022364946 ;
	setAttr ".pt[383]" -type "float3" -0.012757116 -0.14268726 0.024785411 ;
	setAttr ".pt[384]" -type "float3" -0.0067119789 -0.17219238 0.038659025 ;
	setAttr ".pt[391]" -type "float3" 0.001866915 -0.020327866 0.042174589 ;
	setAttr ".pt[392]" -type "float3" 0.025517933 -0.042226955 0.046196725 ;
	setAttr ".pt[393]" -type "float3" 0.029913915 -0.045119818 0.058213573 ;
	setAttr ".pt[394]" -type "float3" 0.0021473987 -0.26170006 0.13044839 ;
	setAttr ".pt[395]" -type "float3" -0.026929786 -0.25197065 0.11732361 ;
	setAttr ".pt[396]" -type "float3" 0.011970107 0.063203402 0.028550472 ;
	setAttr ".pt[397]" -type "float3" 0.021210657 0.26507047 -0.0010200222 ;
	setAttr ".pt[398]" -type "float3" -0.0054828022 0.10853632 0.0055516339 ;
	setAttr ".pt[408]" -type "float3" 4.0423427 2.3677065 0.048133589 ;
	setAttr ".pt[409]" -type "float3" 2.0658588 2.5032063 0.077397071 ;
	setAttr ".pt[410]" -type "float3" 0.78840554 2.4483085 0.14070262 ;
	setAttr ".pt[411]" -type "float3" 0.095551051 1.9315169 0.21335481 ;
	setAttr ".pt[412]" -type "float3" 0.070625059 1.5004745 0.10385306 ;
	setAttr ".pt[413]" -type "float3" 0.057103328 1.1894376 0.043280531 ;
	setAttr ".pt[414]" -type "float3" 0.03990227 0.89092916 0.017432703 ;
	setAttr ".pt[415]" -type "float3" 0.015512478 0.59073561 0.0082680406 ;
	setAttr ".pt[416]" -type "float3" -0.0009973601 0.22540429 0.0026347982 ;
	setAttr ".pt[424]" -type "float3" 0.077159315 -0.15989466 -0.018681783 ;
	setAttr ".pt[425]" -type "float3" 0.053154662 -0.36797598 -0.030845014 ;
	setAttr ".pt[426]" -type "float3" -0.012294017 -0.16587581 -0.016409472 ;
	setAttr ".pt[427]" -type "float3" -0.0012860555 -0.01842564 0.002107159 ;
	setAttr ".pt[428]" -type "float3" 0.0074172453 -0.13842404 0.024846056 ;
	setAttr ".pt[429]" -type "float3" 0.0053508724 -0.11086769 0.024166221 ;
	setAttr ".pt[433]" -type "float3" 0.003843419 0.22687235 0.013219202 ;
	setAttr ".pt[434]" -type "float3" 0.014979859 0.47273603 -0.0031086018 ;
	setAttr ".pt[435]" -type "float3" 0.0021133202 0.21066813 0.023031691 ;
	setAttr ".pt[442]" -type "float3" 0.0055049388 -0.046526607 0.010675159 ;
	setAttr ".pt[443]" -type "float3" 0.0097455848 -0.05076322 0.0088870283 ;
	setAttr ".pt[444]" -type "float3" 0.0088037886 -0.058914799 0.030037267 ;
	setAttr ".pt[445]" -type "float3" -0.0057372479 -0.17995073 0.067347072 ;
	setAttr ".pt[446]" -type "float3" -0.009406141 -0.20456347 0.061791778 ;
	setAttr ".pt[447]" -type "float3" 0.0099923154 0.038311105 0.022833569 ;
	setAttr ".pt[448]" -type "float3" 0.015736155 0.28487152 0.0089842658 ;
	setAttr ".pt[449]" -type "float3" -0.010093916 0.16567786 0.012512456 ;
	setAttr ".pt[459]" -type "float3" 4.1166382 2.6736608 -0.10680392 ;
	setAttr ".pt[460]" -type "float3" 2.0051653 2.8536086 -0.069140181 ;
	setAttr ".pt[461]" -type "float3" 0.70055151 2.4645615 0.0078380918 ;
	setAttr ".pt[462]" -type "float3" 0.2821264 2.0881281 0.025781794 ;
	setAttr ".pt[463]" -type "float3" 0.14540111 1.7729471 0.008816706 ;
	setAttr ".pt[464]" -type "float3" 0.10703623 1.3938677 -0.016155841 ;
	setAttr ".pt[465]" -type "float3" 0.082350813 1.043924 -0.019246805 ;
	setAttr ".pt[466]" -type "float3" 0.040463448 0.69676948 -0.0047861431 ;
	setAttr ".pt[474]" -type "float3" -0.01630903 0.21812788 0.0036491356 ;
	setAttr ".pt[475]" -type "float3" 0.22312237 -0.4691456 0.074902579 ;
	setAttr ".pt[476]" -type "float3" 0.12690684 -0.64298743 0.067626774 ;
	setAttr ".pt[477]" -type "float3" 0.0093058432 -0.39084151 0.029543165 ;
	setAttr ".pt[478]" -type "float3" -0.0084807128 -0.30245727 -0.00017065776 ;
	setAttr ".pt[479]" -type "float3" -0.00018235925 -0.06949681 0.0073515009 ;
	setAttr ".pt[480]" -type "float3" 0.01929209 -0.07995946 0.0178461 ;
	setAttr ".pt[484]" -type "float3" -0.0090290476 0.014544079 0.0061025708 ;
	setAttr ".pt[485]" -type "float3" 0.0061157239 0.16920952 0.0086218975 ;
	setAttr ".pt[486]" -type "float3" 0.0049354266 0.056646418 0.010453182 ;
	setAttr ".pt[493]" -type "float3" 0.0041418574 -0.03464615 -0.00027901444 ;
	setAttr ".pt[494]" -type "float3" 0.012988183 -0.090865485 -0.0033945364 ;
	setAttr ".pt[495]" -type "float3" 0.0060383622 -0.1172343 0.0016868878 ;
	setAttr ".pt[496]" -type "float3" -0.0011865858 -0.17755373 0.0039288634 ;
	setAttr ".pt[497]" -type "float3" 0.0091364384 -0.23120226 -0.00044197193 ;
	setAttr ".pt[498]" -type "float3" 0.016158454 -0.035053026 -0.0057493448 ;
	setAttr ".pt[499]" -type "float3" 0.014093179 0.28476319 -0.0033020913 ;
	setAttr ".pt[500]" -type "float3" -0.020882767 0.20195277 -0.00023462361 ;
	setAttr ".pt[510]" -type "float3" 3.7374043 2.85958 -0.3028591 ;
	setAttr ".pt[511]" -type "float3" 1.607008 2.8865488 -0.26530951 ;
	setAttr ".pt[512]" -type "float3" 0.38700938 2.6653349 -0.1898392 ;
	setAttr ".pt[513]" -type "float3" 0.22042789 2.3299162 -0.14887133 ;
	setAttr ".pt[514]" -type "float3" 0.15522322 1.9866439 -0.11587264 ;
	setAttr ".pt[515]" -type "float3" 0.14542589 1.479978 -0.098953769 ;
	setAttr ".pt[516]" -type "float3" 0.13977781 1.1132658 -0.063091747 ;
	setAttr ".pt[517]" -type "float3" 0.097933084 0.99316758 -0.012219376 ;
	setAttr ".pt[525]" -type "float3" 0.022011416 0.057202157 0.050441246 ;
	setAttr ".pt[526]" -type "float3" 0.25261897 -0.38805574 0.11191951 ;
	setAttr ".pt[527]" -type "float3" 0.21671531 -0.72411609 0.057957094 ;
	setAttr ".pt[528]" -type "float3" 0.098123871 -0.78699756 -0.054468304 ;
	setAttr ".pt[529]" -type "float3" 0.045976274 -1.016031 -0.10525408 ;
	setAttr ".pt[530]" -type "float3" -0.0082815634 -0.94175243 -0.091569707 ;
	setAttr ".pt[531]" -type "float3" 0.01425836 -0.24097615 -0.037842616 ;
	setAttr ".pt[532]" -type "float3" 0.014827377 0.060344107 -0.019476999 ;
	setAttr ".pt[534]" -type "float3" -0.015406037 -0.019035194 -0.0037915769 ;
	setAttr ".pt[535]" -type "float3" -0.019999955 -0.011633901 -0.0053510447 ;
	setAttr ".pt[536]" -type "float3" -0.0027503853 0.063822351 -0.0023422365 ;
	setAttr ".pt[537]" -type "float3" 0.0017990717 -0.04912873 0.0010619393 ;
	setAttr ".pt[538]" -type "float3" -0.0010255697 -0.026745286 3.9068698e-005 ;
	setAttr ".pt[544]" -type "float3" 0.0034380676 -0.030754339 -0.0043744948 ;
	setAttr ".pt[545]" -type "float3" 0.013790648 -0.10745292 -0.013573415 ;
	setAttr ".pt[546]" -type "float3" 0.0060253614 -0.12583022 -0.014928098 ;
	setAttr ".pt[547]" -type "float3" 0.0032298476 -0.17503858 -0.035433616 ;
	setAttr ".pt[548]" -type "float3" 0.025760405 -0.23942882 -0.049233157 ;
	setAttr ".pt[549]" -type "float3" 0.023605037 -0.098056979 -0.038601 ;
	setAttr ".pt[550]" -type "float3" 0.00047469104 0.17940266 -0.039887186 ;
	setAttr ".pt[551]" -type "float3" -0.047991849 0.24328165 -0.027142655 ;
	setAttr ".pt[561]" -type "float3" 3.3289983 2.9584732 -0.5112831 ;
	setAttr ".pt[562]" -type "float3" 1.2566999 2.5790021 -0.4800669 ;
	setAttr ".pt[563]" -type "float3" -0.0861912 2.8663836 -0.43627587 ;
	setAttr ".pt[564]" -type "float3" 0.086873002 2.4523859 -0.32602683 ;
	setAttr ".pt[565]" -type "float3" 0.13193908 1.9227084 -0.24308307 ;
	setAttr ".pt[566]" -type "float3" 0.17006005 1.5603435 -0.17260036 ;
	setAttr ".pt[567]" -type "float3" 0.20642228 1.3915894 -0.10775264 ;
	setAttr ".pt[568]" -type "float3" 0.17642042 0.9764052 -0.090123482 ;
	setAttr ".pt[576]" -type "float3" 0.0052615274 0.062752336 -0.017336223 ;
	setAttr ".pt[577]" -type "float3" 0.26456642 -0.28227881 0.018207164 ;
	setAttr ".pt[578]" -type "float3" 0.29021698 -0.72006452 0.0043390524 ;
	setAttr ".pt[579]" -type "float3" 0.17223436 -0.98835725 -0.045948111 ;
	setAttr ".pt[580]" -type "float3" 0.08137048 -1.3741634 -0.066309057 ;
	setAttr ".pt[581]" -type "float3" -0.015000075 -1.4364722 -0.050940625 ;
	setAttr ".pt[582]" -type "float3" -0.059949759 -1.0196943 -0.045512903 ;
	setAttr ".pt[583]" -type "float3" 0.013316502 0.046807248 -0.054589361 ;
	setAttr ".pt[584]" -type "float3" -0.0072469423 0.10115629 -0.021485856 ;
	setAttr ".pt[585]" -type "float3" -0.03818484 -0.021063199 -0.025025947 ;
	setAttr ".pt[586]" -type "float3" -0.033538572 -0.083540924 -0.022484617 ;
	setAttr ".pt[587]" -type "float3" -0.016395459 -0.089893818 -0.012528703 ;
	setAttr ".pt[588]" -type "float3" -0.0031157585 -0.13436384 0.00093352958 ;
	setAttr ".pt[589]" -type "float3" -0.0020125399 -0.11413158 0.0078927884 ;
	setAttr ".pt[595]" -type "float3" 0.0001818593 -0.0060112225 -0.0015867772 ;
	setAttr ".pt[596]" -type "float3" 0.0044973786 -0.065373816 -0.017588992 ;
	setAttr ".pt[597]" -type "float3" 0.0018002545 -0.081579559 -0.015027677 ;
	setAttr ".pt[598]" -type "float3" 0.0057879854 -0.10399029 -0.032859351 ;
	setAttr ".pt[599]" -type "float3" 0.032119703 -0.12150546 -0.039037552 ;
	setAttr ".pt[600]" -type "float3" 0.028204076 -0.051299669 -0.024062043 ;
	setAttr ".pt[601]" -type "float3" -0.0051906467 0.1150851 -0.024052083 ;
	setAttr ".pt[602]" -type "float3" -0.044967487 0.21330349 -0.010846923 ;
	setAttr ".pt[603]" -type "float3" -0.027509663 0.055185962 0.0026956513 ;
	setAttr ".pt[612]" -type "float3" 3.020088 2.9111006 -0.67664218 ;
	setAttr ".pt[613]" -type "float3" 1.1415006 2.3715498 -0.6428985 ;
	setAttr ".pt[614]" -type "float3" 0.11704506 2.7685194 -0.60356271 ;
	setAttr ".pt[615]" -type "float3" 0.10175849 2.2747242 -0.45358917 ;
	setAttr ".pt[616]" -type "float3" 0.13746838 1.9387263 -0.34189355 ;
	setAttr ".pt[617]" -type "float3" 0.2033987 1.8709546 -0.26243657 ;
	setAttr ".pt[618]" -type "float3" 0.28402027 1.6530627 -0.17484461 ;
	setAttr ".pt[619]" -type "float3" 0.22787881 0.96464902 -0.021633621 ;
	setAttr ".pt[627]" -type "float3" 0.001363792 0.064365558 -0.0091391541 ;
	setAttr ".pt[628]" -type "float3" 0.25012565 -0.2508907 -0.0027033589 ;
	setAttr ".pt[629]" -type "float3" 0.30650228 -0.71518111 0.054840066 ;
	setAttr ".pt[630]" -type "float3" 0.18424627 -0.93942809 0.068318106 ;
	setAttr ".pt[631]" -type "float3" 0.08769545 -1.3262184 0.10515546 ;
	setAttr ".pt[632]" -type "float3" -0.012098193 -1.4267615 0.11064412 ;
	setAttr ".pt[633]" -type "float3" -0.078336693 -1.2314903 0.076931469 ;
	setAttr ".pt[634]" -type "float3" -0.058590192 -0.56664038 -0.0031123818 ;
	setAttr ".pt[635]" -type "float3" -0.021518176 0.16973737 -0.079489589 ;
	setAttr ".pt[636]" -type "float3" -0.043862253 0.0067803659 -0.055883098 ;
	setAttr ".pt[637]" -type "float3" -0.040912829 -0.076237924 -0.033905618 ;
	setAttr ".pt[638]" -type "float3" -0.024035549 -0.067626327 -0.01971215 ;
	setAttr ".pt[639]" -type "float3" -0.0041874573 -0.063689627 -0.0053419247 ;
	setAttr ".pt[640]" -type "float3" 0.0023854193 -0.051134214 0.0050033219 ;
	setAttr ".pt[641]" -type "float3" 0.0013323853 0.011614312 -3.4783741e-005 ;
	setAttr ".pt[642]" -type "float3" 0.0054074335 0.048817843 -0.0011500036 ;
	setAttr ".pt[647]" -type "float3" -0.0035474976 -0.038431048 -0.0082673952 ;
	setAttr ".pt[648]" -type "float3" -0.0025488173 -0.053303201 -0.0071385191 ;
	setAttr ".pt[649]" -type "float3" -0.0009832459 -0.043611769 -0.0090690851 ;
	setAttr ".pt[650]" -type "float3" 0.017657731 -0.028806284 -0.015348517 ;
	setAttr ".pt[651]" -type "float3" 0.020410312 -0.028603088 -0.0091407169 ;
	setAttr ".pt[652]" -type "float3" -0.0050261896 0.025271636 -0.0099398736 ;
	setAttr ".pt[653]" -type "float3" -0.029193886 0.11173378 -0.002965827 ;
	setAttr ".pt[654]" -type "float3" -0.024678521 0.037566394 0.0039454321 ;
	setAttr ".pt[663]" -type "float3" 2.5184615 2.3895488 -0.78842294 ;
	setAttr ".pt[664]" -type "float3" 0.98312521 2.2370949 -0.73418564 ;
	setAttr ".pt[665]" -type "float3" 0.30799925 2.4377892 -0.6338315 ;
	setAttr ".pt[666]" -type "float3" 0.12202386 2.343971 -0.52766061 ;
	setAttr ".pt[667]" -type "float3" 0.1507141 2.2148905 -0.46558994 ;
	setAttr ".pt[668]" -type "float3" 0.23774283 2.197819 -0.4399114 ;
	setAttr ".pt[669]" -type "float3" 0.34764233 1.8479468 -0.34146497 ;
	setAttr ".pt[670]" -type "float3" 0.22322555 0.94051534 -0.10041292 ;
	setAttr ".pt[678]" -type "float3" -0.00085632165 0.018671857 -0.0051788241 ;
	setAttr ".pt[679]" -type "float3" 0.14843069 -0.14645119 0.012792771 ;
	setAttr ".pt[680]" -type "float3" 0.23176812 -0.5804922 0.13569734 ;
	setAttr ".pt[681]" -type "float3" 0.14379808 -0.67831695 0.18870123 ;
	setAttr ".pt[682]" -type "float3" 0.077414453 -0.96888185 0.24320421 ;
	setAttr ".pt[683]" -type "float3" 0.0039929994 -1.0579358 0.23725675 ;
	setAttr ".pt[684]" -type "float3" -0.05630653 -1.0091331 0.19091958 ;
	setAttr ".pt[685]" -type "float3" -0.07034795 -0.72599667 0.098282881 ;
	setAttr ".pt[686]" -type "float3" -0.052026343 -0.21479501 -0.016945824 ;
	setAttr ".pt[687]" -type "float3" -0.041555058 0.085190207 -0.063141301 ;
	setAttr ".pt[688]" -type "float3" -0.037703551 0.096834838 -0.048380457 ;
	setAttr ".pt[689]" -type "float3" -0.023017567 0.1030905 -0.034413781 ;
	setAttr ".pt[690]" -type "float3" -0.0014288732 0.1699295 -0.032779839 ;
	setAttr ".pt[691]" -type "float3" 0.0070843832 0.18760349 -0.022023853 ;
	setAttr ".pt[692]" -type "float3" 0.0063923239 0.15142377 -0.011524009 ;
	setAttr ".pt[693]" -type "float3" 0.010566154 0.16619088 -0.0093962494 ;
	setAttr ".pt[694]" -type "float3" 0.0060563483 0.11541025 -0.0072485097 ;
	setAttr ".pt[697]" -type "float3" -0.0036976461 -0.015139129 0.0022799692 ;
	setAttr ".pt[698]" -type "float3" -0.0058197039 -0.027639182 -0.00028016506 ;
	setAttr ".pt[699]" -type "float3" -0.0018538845 -0.039239872 -0.0022828113 ;
	setAttr ".pt[701]" -type "float3" 0.0063525569 0.029907295 -0.01087201 ;
	setAttr ".pt[702]" -type "float3" 0.013100787 -0.0089813853 -0.0076275882 ;
	setAttr ".pt[703]" -type "float3" -0.0014735998 -0.036827095 -0.0049143503 ;
	setAttr ".pt[704]" -type "float3" -0.018760387 0.0065507377 -0.0021691164 ;
	setAttr ".pt[705]" -type "float3" -0.01052958 0.012091316 0.0002592926 ;
	setAttr ".pt[714]" -type "float3" 2.8457277 2.4208851 -0.80472851 ;
	setAttr ".pt[715]" -type "float3" 1.5271531 2.837471 -0.84522468 ;
	setAttr ".pt[716]" -type "float3" 0.59007233 3.1841152 -0.86653161 ;
	setAttr ".pt[717]" -type "float3" 0.043432426 3.2717776 -0.86021948 ;
	setAttr ".pt[718]" -type "float3" 0.14118199 3.0590129 -0.76399076 ;
	setAttr ".pt[719]" -type "float3" 0.22982951 2.7527094 -0.66687804 ;
	setAttr ".pt[720]" -type "float3" 0.35174307 2.1980507 -0.50006104 ;
	setAttr ".pt[721]" -type "float3" 0.17008618 0.93621349 -0.10417616 ;
	setAttr ".pt[729]" -type "float3" -0.00014519595 0.0015564581 -0.0004195254 ;
	setAttr ".pt[730]" -type "float3" 0.063395701 -0.013375329 0.023779754 ;
	setAttr ".pt[731]" -type "float3" 0.13265486 -0.34635279 0.16452961 ;
	setAttr ".pt[732]" -type "float3" 0.096908361 -0.38240209 0.21646369 ;
	setAttr ".pt[733]" -type "float3" 0.067186557 -0.54892528 0.25862458 ;
	setAttr ".pt[734]" -type "float3" 0.023884557 -0.63446403 0.25172696 ;
	setAttr ".pt[735]" -type "float3" -0.021861553 -0.64261955 0.2107909 ;
	setAttr ".pt[736]" -type "float3" -0.048972324 -0.65836006 0.16811696 ;
	setAttr ".pt[737]" -type "float3" -0.054379825 -0.42029586 0.081145041 ;
	setAttr ".pt[738]" -type "float3" -0.050455157 0.067772456 -0.030493939 ;
	setAttr ".pt[739]" -type "float3" -0.03312695 0.312655 -0.069192939 ;
	setAttr ".pt[740]" -type "float3" -0.014901413 0.37695727 -0.063376255 ;
	setAttr ".pt[741]" -type "float3" -0.00046931705 0.38033229 -0.047828991 ;
	setAttr ".pt[742]" -type "float3" 0.0075295018 0.28858346 -0.022270054 ;
	setAttr ".pt[743]" -type "float3" 0.0097416583 0.19888753 -0.0060040057 ;
	setAttr ".pt[744]" -type "float3" 0.013523582 0.17147678 -0.00096940889 ;
	setAttr ".pt[745]" -type "float3" 0.010826857 0.17481306 -0.00013077224 ;
	setAttr ".pt[746]" -type "float3" -0.00016876239 0.025247935 -0.00041821875 ;
	setAttr ".pt[748]" -type "float3" -0.0090748137 0.039648823 -0.0025875478 ;
	setAttr ".pt[749]" -type "float3" -0.0069971718 0.0048495047 -0.00012205228 ;
	setAttr ".pt[750]" -type "float3" 0.00021019479 -0.023270978 7.2711016e-005 ;
	setAttr ".pt[752]" -type "float3" -0.0018900178 0.0022681798 -0.011267463 ;
	setAttr ".pt[753]" -type "float3" 0.0041703451 -0.050976813 -0.0086974055 ;
	setAttr ".pt[754]" -type "float3" -0.00091060938 -0.081994027 -0.0034025076 ;
	setAttr ".pt[755]" -type "float3" -0.0060433494 -0.026523769 -0.0022247646 ;
	setAttr ".pt[765]" -type "float3" 3.0398738 3.3977592 -0.97022307 ;
	setAttr ".pt[766]" -type "float3" 1.9875593 3.8446481 -1.0019037 ;
	setAttr ".pt[767]" -type "float3" 0.94014549 4.1236281 -1.0215713 ;
	setAttr ".pt[768]" -type "float3" 0.079634331 4.1352425 -1.0217637 ;
	setAttr ".pt[769]" -type "float3" 0.15500523 3.8663557 -0.88067788 ;
	setAttr ".pt[770]" -type "float3" 0.15110509 3.2819798 -0.68281001 ;
	setAttr ".pt[771]" -type "float3" 0.14427403 2.1384606 -0.32242677 ;
	setAttr ".pt[772]" -type "float3" 0.13935114 0.98782808 -0.0035596231 ;
	setAttr ".pt[781]" -type "float3" 0.016237289 0.065331824 0.013062602 ;
	setAttr ".pt[782]" -type "float3" 0.042360216 -0.049013048 0.083566204 ;
	setAttr ".pt[783]" -type "float3" 0.053172436 -0.16298556 0.15050645 ;
	setAttr ".pt[784]" -type "float3" 0.056543987 -0.25158522 0.20029344 ;
	setAttr ".pt[785]" -type "float3" 0.037143756 -0.33341932 0.21551581 ;
	setAttr ".pt[786]" -type "float3" 0.0038901921 -0.38077787 0.20417313 ;
	setAttr ".pt[787]" -type "float3" -0.022275766 -0.45193154 0.1890265 ;
	setAttr ".pt[788]" -type "float3" -0.032664973 -0.33352521 0.13438964 ;
	setAttr ".pt[789]" -type "float3" -0.032823302 0.02972259 0.041289084 ;
	setAttr ".pt[790]" -type "float3" -0.025866296 0.43180022 -0.049746506 ;
	setAttr ".pt[791]" -type "float3" -0.013006981 0.40338859 -0.042817771 ;
	setAttr ".pt[792]" -type "float3" -0.00052416569 0.26427609 -0.011770454 ;
	setAttr ".pt[793]" -type "float3" 0.0093275877 0.057388093 0.020666802 ;
	setAttr ".pt[794]" -type "float3" 0.016734058 -0.086054146 0.030711308 ;
	setAttr ".pt[795]" -type "float3" 0.023167813 -0.13456379 0.028862527 ;
	setAttr ".pt[796]" -type "float3" 0.027274644 -0.098604612 0.030013356 ;
	setAttr ".pt[797]" -type "float3" 0.019700645 0.0056907423 0.019807976 ;
	setAttr ".pt[798]" -type "float3" -0.00091250282 0.15766756 -0.0032835878 ;
	setAttr ".pt[799]" -type "float3" -0.013597728 0.17082576 -0.013717005 ;
	setAttr ".pt[800]" -type "float3" -0.0069027022 0.046803743 -0.0043966905 ;
	setAttr ".pt[801]" -type "float3" 0.001076608 -0.016935036 0.0019243229 ;
	setAttr ".pt[804]" -type "float3" -0.0031121022 -0.080022089 -0.0018320857 ;
	setAttr ".pt[805]" -type "float3" -0.0056789443 -0.14150192 0.0019362277 ;
	setAttr ".pt[806]" -type "float3" -0.013386637 -0.12970996 0.0035064598 ;
	setAttr ".pt[816]" -type "float3" 3.1411197 4.3815856 -0.80826104 ;
	setAttr ".pt[817]" -type "float3" 2.2989879 4.6817822 -0.8054384 ;
	setAttr ".pt[818]" -type "float3" 1.2259296 4.8716965 -0.7943905 ;
	setAttr ".pt[819]" -type "float3" 0.29997215 4.831697 -0.76100242 ;
	setAttr ".pt[820]" -type "float3" 0.26285493 4.4962549 -0.65220791 ;
	setAttr ".pt[821]" -type "float3" 0.18258496 3.3959386 -0.41472813 ;
	setAttr ".pt[822]" -type "float3" 0.14104685 2.0079091 -0.16360086 ;
	setAttr ".pt[823]" -type "float3" 0.072144836 0.98125255 -0.022981297 ;
	setAttr ".pt[832]" -type "float3" -0.0021043054 0.063394733 0.0010888947 ;
	setAttr ".pt[833]" -type "float3" 0.0053279074 0.055824596 0.019078171 ;
	setAttr ".pt[834]" -type "float3" 0.02011185 -0.089342557 0.065750793 ;
	setAttr ".pt[835]" -type "float3" 0.036574434 -0.093831003 0.10006217 ;
	setAttr ".pt[836]" -type "float3" 0.034734845 -0.15264769 0.13155185 ;
	setAttr ".pt[837]" -type "float3" 0.014285873 -0.16446511 0.13699712 ;
	setAttr ".pt[838]" -type "float3" -0.0039791102 -0.11700351 0.11720297 ;
	setAttr ".pt[839]" -type "float3" -0.015352277 -0.13320853 0.1059983 ;
	setAttr ".pt[840]" -type "float3" -0.024154883 -0.058581859 0.073930778 ;
	setAttr ".pt[841]" -type "float3" -0.023844359 0.094190694 0.028640632 ;
	setAttr ".pt[842]" -type "float3" -0.0099438047 0.086253189 0.017610602 ;
	setAttr ".pt[843]" -type "float3" 0.0062030512 0.0027696425 0.026141912 ;
	setAttr ".pt[844]" -type "float3" 0.020147907 -0.12862581 0.031872422 ;
	setAttr ".pt[845]" -type "float3" 0.029515751 -0.24358894 0.024019942 ;
	setAttr ".pt[846]" -type "float3" 0.033532966 -0.29070434 0.0089600673 ;
	setAttr ".pt[847]" -type "float3" 0.040853195 -0.27763608 0.0074919378 ;
	setAttr ".pt[848]" -type "float3" 0.044787146 -0.22252892 0.011680545 ;
	setAttr ".pt[849]" -type "float3" 0.023395266 -0.051994152 0.0034055351 ;
	setAttr ".pt[850]" -type "float3" -0.0038558389 0.13532867 -0.014074897 ;
	setAttr ".pt[851]" -type "float3" -0.006113247 0.073014505 -0.010021388 ;
	setAttr ".pt[855]" -type "float3" -0.002327258 0.012769852 -0.012817151 ;
	setAttr ".pt[856]" -type "float3" -0.0021843335 -0.0073861657 -0.020539626 ;
	setAttr ".pt[857]" -type "float3" -0.0077242767 -0.019641895 -0.014100459 ;
	setAttr ".pt[867]" -type "float3" 3.0838568 5.1925793 -0.47780982 ;
	setAttr ".pt[868]" -type "float3" 2.3864088 5.3526506 -0.45592242 ;
	setAttr ".pt[869]" -type "float3" 1.3660779 5.4441223 -0.40623981 ;
	setAttr ".pt[870]" -type "float3" 0.70019025 5.4118366 -0.36246461 ;
	setAttr ".pt[871]" -type "float3" 0.46427968 4.8403926 -0.30765963 ;
	setAttr ".pt[872]" -type "float3" 0.31330535 3.4327972 -0.18049851 ;
	setAttr ".pt[873]" -type "float3" 0.17189418 2.091089 -0.073360123 ;
	setAttr ".pt[874]" -type "float3" 0.047371965 1.0533081 -0.02367712 ;
	setAttr ".pt[883]" -type "float3" -0.0049863872 0.030296883 -0.016909363 ;
	setAttr ".pt[884]" -type "float3" -0.007216387 0.069087826 -0.028735947 ;
	setAttr ".pt[885]" -type "float3" -0.0030479108 -0.013644368 -0.019686213 ;
	setAttr ".pt[886]" -type "float3" 0.017224705 -0.1362775 0.0086263195 ;
	setAttr ".pt[887]" -type "float3" 0.020221116 -0.15000641 0.028400127 ;
	setAttr ".pt[888]" -type "float3" 0.010367301 -0.026628682 0.025548516 ;
	setAttr ".pt[889]" -type "float3" 0.0015476296 0.079071812 0.017940825 ;
	setAttr ".pt[890]" -type "float3" -0.0056897183 0.0060838722 0.037489682 ;
	setAttr ".pt[891]" -type "float3" -0.018275101 -0.048069116 0.044216208 ;
	setAttr ".pt[892]" -type "float3" -0.021519158 -0.022004316 0.034848619 ;
	setAttr ".pt[893]" -type "float3" -0.0071651274 -0.024887912 0.030219201 ;
	setAttr ".pt[894]" -type "float3" 0.012557426 -0.070748895 0.023823192 ;
	setAttr ".pt[895]" -type "float3" 0.035683032 -0.16657868 0.014916621 ;
	setAttr ".pt[896]" -type "float3" 0.043041877 -0.24326147 -0.0019323286 ;
	setAttr ".pt[897]" -type "float3" 0.03549137 -0.26697329 -0.015246919 ;
	setAttr ".pt[898]" -type "float3" 0.032489069 -0.26263198 -0.010322899 ;
	setAttr ".pt[899]" -type "float3" 0.039050017 -0.28977197 0.0099873859 ;
	setAttr ".pt[900]" -type "float3" 0.026906837 -0.19797041 0.016713761 ;
	setAttr ".pt[901]" -type "float3" 0.0010979109 0.053434923 -0.0030287437 ;
	setAttr ".pt[902]" -type "float3" -0.0041476022 0.059031695 -0.0065195975 ;
	setAttr ".pt[907]" -type "float3" 0.0032520394 0.097662754 -0.0243745 ;
	setAttr ".pt[908]" -type "float3" -0.00028591268 0.12327262 -0.023645498 ;
	setAttr ".pt[909]" -type "float3" -0.00033748441 0.0070722075 -0.00093398808 ;
	setAttr ".pt[918]" -type "float3" 2.7410645 5.8030481 -0.14927918 ;
	setAttr ".pt[919]" -type "float3" 2.1676941 5.884654 -0.11531916 ;
	setAttr ".pt[920]" -type "float3" 1.3390049 5.9908319 -0.072156698 ;
	setAttr ".pt[921]" -type "float3" 0.98283136 5.8707209 -0.1141888 ;
	setAttr ".pt[922]" -type "float3" 0.67934257 4.9571218 -0.12325423 ;
	setAttr ".pt[923]" -type "float3" 0.45077467 3.5590322 -0.1051989 ;
	setAttr ".pt[924]" -type "float3" 0.24049532 2.3273525 -0.06327185 ;
	setAttr ".pt[925]" -type "float3" 0.06619212 1.2419348 -0.038009021 ;
	setAttr ".pt[926]" -type "float3" -0.0054816008 0.12191519 -0.0065343874 ;
	setAttr ".pt[927]" -type "float3" 3.2783959e-005 -0.0019597183 -0.00021471137 ;
	setAttr ".pt[934]" -type "float3" 0.00043058058 0.020031605 -0.023315348 ;
	setAttr ".pt[935]" -type "float3" -0.0068819062 0.1212897 -0.049357876 ;
	setAttr ".pt[936]" -type "float3" -0.010820301 0.010873643 -0.045262303 ;
	setAttr ".pt[937]" -type "float3" 0.014429748 -0.30383587 -0.010082551 ;
	setAttr ".pt[938]" -type "float3" 0.011375687 -0.26407695 -0.026021536 ;
	setAttr ".pt[939]" -type "float3" 0.0071777562 -0.066426679 -0.039673854 ;
	setAttr ".pt[940]" -type "float3" 0.00351221 0.084578097 -0.040381823 ;
	setAttr ".pt[941]" -type "float3" -0.0040059071 0.025908215 -0.026205126 ;
	setAttr ".pt[942]" -type "float3" -0.016913505 -0.02259827 -0.0099321008 ;
	setAttr ".pt[943]" -type "float3" -0.022601852 -0.018954601 -0.0024117478 ;
	setAttr ".pt[944]" -type "float3" -0.0083515635 -0.0080597652 0.0038877067 ;
	setAttr ".pt[945]" -type "float3" 0.017251434 -0.048273545 0.0085031502 ;
	setAttr ".pt[946]" -type "float3" 0.039012197 -0.12433109 0.0078744199 ;
	setAttr ".pt[947]" -type "float3" 0.043911085 -0.18248567 0.0057559572 ;
	setAttr ".pt[948]" -type "float3" 0.025801385 -0.17646201 0.0094017824 ;
	setAttr ".pt[949]" -type "float3" 0.0071958993 -0.13081564 0.020505194 ;
	setAttr ".pt[950]" -type "float3" 0.010685973 -0.13565037 0.032775857 ;
	setAttr ".pt[951]" -type "float3" 0.0019900531 -0.021396637 0.0049874266 ;
	setAttr ".pt[958]" -type "float3" 0.0010575517 0.056236759 -0.0086889509 ;
	setAttr ".pt[959]" -type "float3" -0.0047214939 0.031539682 -0.0019218789 ;
	setAttr ".pt[960]" -type "float3" -0.00013271002 -0.00030897549 5.3332678e-005 ;
	setAttr ".pt[963]" -type "float3" -0.012963831 -0.016952487 0.0042400365 ;
	setAttr ".pt[964]" -type "float3" -0.012097009 -0.025654461 0.0034408511 ;
	setAttr ".pt[969]" -type "float3" 2.2155168 6.3142333 0.077657945 ;
	setAttr ".pt[970]" -type "float3" 1.8598856 6.466886 0.097743496 ;
	setAttr ".pt[971]" -type "float3" 1.4123142 6.5656824 0.046346311 ;
	setAttr ".pt[972]" -type "float3" 1.1408495 6.2165089 -0.063463502 ;
	setAttr ".pt[973]" -type "float3" 0.83121175 5.1217747 -0.12303513 ;
	setAttr ".pt[974]" -type "float3" 0.56051725 3.7799282 -0.14629288 ;
	setAttr ".pt[975]" -type "float3" 0.31561148 2.5645998 -0.11547159 ;
	setAttr ".pt[976]" -type "float3" 0.12607804 1.4503294 -0.06795603 ;
	setAttr ".pt[977]" -type "float3" 0.0095767304 0.44187561 -0.017959088 ;
	setAttr ".pt[978]" -type "float3" -0.0011263324 -0.018211173 -0.00085670548 ;
	setAttr ".pt[985]" -type "float3" 0.0052457186 0.075523376 -0.011636212 ;
	setAttr ".pt[986]" -type "float3" -0.0019249257 0.25314513 -0.037285168 ;
	setAttr ".pt[987]" -type "float3" -0.0086424816 0.10512722 -0.033613853 ;
	setAttr ".pt[988]" -type "float3" 0.0069113001 -0.18018945 -0.007829506 ;
	setAttr ".pt[989]" -type "float3" 0.017374074 -0.37416318 -0.020014638 ;
	setAttr ".pt[990]" -type "float3" 0.012476658 -0.17260763 -0.055509664 ;
	setAttr ".pt[991]" -type "float3" 0.0089565041 -0.032667834 -0.073308818 ;
	setAttr ".pt[992]" -type "float3" -0.0036066589 -0.056116182 -0.06400416 ;
	setAttr ".pt[993]" -type "float3" -0.01728772 -0.050887275 -0.042729892 ;
	setAttr ".pt[994]" -type "float3" -0.026288494 -0.026137877 -0.033415135 ;
	setAttr ".pt[995]" -type "float3" -0.013325538 -0.0024736021 -0.023582136 ;
	setAttr ".pt[996]" -type "float3" 0.014466245 -0.023433371 -0.0073063215 ;
	setAttr ".pt[997]" -type "float3" 0.029342692 -0.065717556 0.0093307626 ;
	setAttr ".pt[998]" -type "float3" 0.036834404 -0.092381373 0.025615148 ;
	setAttr ".pt[999]" -type "float3" 0.0086895945 -0.047433175 0.03799475 ;
	setAttr ".pt[1000]" -type "float3" -0.01468768 -0.010861947 0.0469179 ;
	setAttr ".pt[1001]" -type "float3" -0.0033516963 -0.015684076 0.044222489 ;
	setAttr ".pt[1010]" -type "float3" -0.00060997892 -0.0020426975 0.00063461525 ;
	setAttr ".pt[1013]" -type "float3" -0.0047343625 0.0045090616 -0.0016983575 ;
	setAttr ".pt[1014]" -type "float3" -0.067879796 0.043301668 -0.0061593675 ;
	setAttr ".pt[1015]" -type "float3" -0.091672331 -0.015801892 0.0084057972 ;
	setAttr ".pt[1020]" -type "float3" 2.1202543 7.0146232 0.01496935 ;
	setAttr ".pt[1021]" -type "float3" 1.8842292 7.0572047 -0.022050411 ;
	setAttr ".pt[1022]" -type "float3" 1.5927359 6.932806 -0.099265225 ;
	setAttr ".pt[1023]" -type "float3" 1.2746285 6.4075322 -0.17154139 ;
	setAttr ".pt[1024]" -type "float3" 0.93194145 5.2659416 -0.21800108 ;
	setAttr ".pt[1025]" -type "float3" 0.62513775 4.1232719 -0.30231899 ;
	setAttr ".pt[1026]" -type "float3" 0.3657892 2.6400907 -0.1923835 ;
	setAttr ".pt[1027]" -type "float3" 0.16846983 1.4931334 -0.10559523 ;
	setAttr ".pt[1028]" -type "float3" 0.031654608 0.55898672 -0.036552873 ;
	setAttr ".pt[1029]" -type "float3" -0.0029923983 0.0071526975 0.0021396815 ;
	setAttr ".pt[1030]" -type "float3" -4.4023313e-006 -0.00018970686 6.0367483e-007 ;
	setAttr ".pt[1036]" -type "float3" 0.0018427373 0.031405203 -0.0016519721 ;
	setAttr ".pt[1037]" -type "float3" 8.5830688e-005 0.064117461 -0.0032628789 ;
	setAttr ".pt[1038]" -type "float3" -0.00017639656 0.0033502914 -0.0004013491 ;
	setAttr ".pt[1039]" -type "float3" 0.003117302 -0.05748114 -0.0012808676 ;
	setAttr ".pt[1040]" -type "float3" 0.025015971 -0.33940977 -0.0054534888 ;
	setAttr ".pt[1041]" -type "float3" 0.022926182 -0.2661486 -0.041737948 ;
	setAttr ".pt[1042]" -type "float3" 0.014728111 -0.16483951 -0.070733823 ;
	setAttr ".pt[1043]" -type "float3" -0.0066337674 -0.17455003 -0.066989765 ;
	setAttr ".pt[1044]" -type "float3" -0.027695375 -0.13928677 -0.05357945 ;
	setAttr ".pt[1045]" -type "float3" -0.033648994 -0.071990989 -0.042155586 ;
	setAttr ".pt[1046]" -type "float3" -0.019250473 -0.025217975 -0.034975894 ;
	setAttr ".pt[1047]" -type "float3" 0.0080624446 -0.013289744 -0.018910723 ;
	setAttr ".pt[1048]" -type "float3" 0.028099591 -0.025524341 0.001427439 ;
	setAttr ".pt[1049]" -type "float3" 0.027448444 -0.011071235 0.01707742 ;
	setAttr ".pt[1050]" -type "float3" -0.0018795565 0.020439232 0.027055845 ;
	setAttr ".pt[1051]" -type "float3" -0.029776283 0.026976731 0.031163318 ;
	setAttr ".pt[1052]" -type "float3" -0.009770697 0.0087544601 0.033084933 ;
	setAttr ".pt[1064]" -type "float3" -0.015381157 0.0063061109 -0.0023824032 ;
	setAttr ".pt[1065]" -type "float3" -0.12268868 0.039540205 -0.01297347 ;
	setAttr ".pt[1066]" -type "float3" -0.19161645 0.031817146 -0.0083330395 ;
	setAttr ".pt[1067]" -type "float3" -0.14031851 0.025097298 0.0044659516 ;
	setAttr ".pt[1071]" -type "float3" 2.0346584 7.4140253 -0.29558226 ;
	setAttr ".pt[1072]" -type "float3" 1.8389641 7.4811254 -0.30583093 ;
	setAttr ".pt[1073]" -type "float3" 1.6421579 7.1646929 -0.30033857 ;
	setAttr ".pt[1074]" -type "float3" 1.3494334 6.4710836 -0.28243047 ;
	setAttr ".pt[1075]" -type "float3" 0.96751267 5.3193908 -0.28215152 ;
	setAttr ".pt[1076]" -type "float3" 0.59305674 3.9128551 -0.3512246 ;
	setAttr ".pt[1077]" -type "float3" 0.37526545 2.4744079 -0.22161272 ;
	setAttr ".pt[1078]" -type "float3" 0.18764332 1.4045359 -0.13418582 ;
	setAttr ".pt[1079]" -type "float3" 0.056217961 0.5563215 -0.059577588 ;
	setAttr ".pt[1080]" -type "float3" 0.00040403483 -0.0088066058 -0.0032784296 ;
	setAttr ".pt[1081]" -type "float3" 0.00066313252 -0.0041014412 0.0004854931 ;
	setAttr ".pt[1088]" -type "float3" 3.9482118e-005 0.0079936823 -0.00026504011 ;
	setAttr ".pt[1090]" -type "float3" 0.00047423324 0.020715253 -0.00050716463 ;
	setAttr ".pt[1091]" -type "float3" 0.026762208 -0.22486819 -0.00047901325 ;
	setAttr ".pt[1092]" -type "float3" 0.030512108 -0.30433208 -0.028923653 ;
	setAttr ".pt[1093]" -type "float3" 0.017882727 -0.28565216 -0.051689137 ;
	setAttr ".pt[1094]" -type "float3" -0.010261947 -0.27233464 -0.048063498 ;
	setAttr ".pt[1095]" -type "float3" -0.034609243 -0.19114572 -0.037546594 ;
	setAttr ".pt[1096]" -type "float3" -0.040419977 -0.094198756 -0.029204199 ;
	setAttr ".pt[1097]" -type "float3" -0.026925588 -0.024553277 -0.025086448 ;
	setAttr ".pt[1098]" -type "float3" -0.00011694734 0.014614072 -0.013701592 ;
	setAttr ".pt[1099]" -type "float3" 0.023431627 -0.0013229901 -0.00086497841 ;
	setAttr ".pt[1100]" -type "float3" 0.028407076 -0.028861025 0.0046849768 ;
	setAttr ".pt[1101]" -type "float3" -0.0025684908 -0.054233864 0.0037730148 ;
	setAttr ".pt[1102]" -type "float3" -0.042468458 -0.089060776 0.0026565699 ;
	setAttr ".pt[1103]" -type "float3" -0.013876134 -0.091257669 0.01019836 ;
	setAttr ".pt[1104]" -type "float3" 0.017263955 -0.086564653 0.010750916 ;
	setAttr ".pt[1116]" -type "float3" -0.14829911 0.033852912 -0.009499887 ;
	setAttr ".pt[1117]" -type "float3" -0.25403863 0.021797091 -0.018555207 ;
	setAttr ".pt[1118]" -type "float3" -0.24153911 0.0085072387 -0.016841318 ;
	setAttr ".pt[1122]" -type "float3" 2.2296083 7.2806234 -0.55921018 ;
	setAttr ".pt[1123]" -type "float3" 1.9956917 7.4167891 -0.52642775 ;
	setAttr ".pt[1124]" -type "float3" 1.6599163 7.133997 -0.40603539 ;
	setAttr ".pt[1125]" -type "float3" 1.3430647 6.3029222 -0.25141677 ;
	setAttr ".pt[1126]" -type "float3" 0.94255644 5.1918302 -0.19706908 ;
	setAttr ".pt[1127]" -type "float3" 0.54261577 3.5111296 -0.213397 ;
	setAttr ".pt[1128]" -type "float3" 0.35650682 2.2090521 -0.17295903 ;
	setAttr ".pt[1129]" -type "float3" 0.20110466 1.2286479 -0.13216747 ;
	setAttr ".pt[1130]" -type "float3" 0.084506534 0.3730357 -0.07869187 ;
	setAttr ".pt[1131]" -type "float3" 0.015925307 -0.11723083 -0.018125972 ;
	setAttr ".pt[1132]" -type "float3" 0.0064341757 -0.046207465 -0.0021499651 ;
	setAttr ".pt[1142]" -type "float3" 0.026852826 -0.11719127 0.00096335722 ;
	setAttr ".pt[1143]" -type "float3" 0.027950922 -0.23916127 -0.02315025 ;
	setAttr ".pt[1144]" -type "float3" 0.016343527 -0.3458682 -0.031523522 ;
	setAttr ".pt[1145]" -type "float3" -0.013469576 -0.3093468 -0.025091687 ;
	setAttr ".pt[1146]" -type "float3" -0.036921758 -0.17586406 -0.015136293 ;
	setAttr ".pt[1147]" -type "float3" -0.044755444 -0.096682921 -0.014382721 ;
	setAttr ".pt[1148]" -type "float3" -0.034207266 -0.038092006 -0.0098987902 ;
	setAttr ".pt[1149]" -type "float3" -0.0062814648 -0.013451409 -0.00069132569 ;
	setAttr ".pt[1150]" -type "float3" 0.020630686 -0.026375029 0.0054188976 ;
	setAttr ".pt[1151]" -type "float3" 0.036838301 -0.12211198 0.0046839966 ;
	setAttr ".pt[1152]" -type "float3" 0.0089916056 -0.26512298 -0.0004102682 ;
	setAttr ".pt[1153]" -type "float3" -0.036876947 -0.23698799 -0.012284389 ;
	setAttr ".pt[1154]" -type "float3" -0.011831978 -0.16900939 -0.019471502 ;
	setAttr ".pt[1155]" -type "float3" 0.019277925 -0.075148717 -0.016581619 ;
	setAttr ".pt[1167]" -type "float3" -0.15076229 0.034831166 -0.0032476119 ;
	setAttr ".pt[1168]" -type "float3" -0.26867098 0.038313694 -0.013551054 ;
	setAttr ".pt[1169]" -type "float3" -0.29541332 0.019024258 -0.021240745 ;
	setAttr ".pt[1170]" -type "float3" -0.13383813 -0.015031185 -0.013348414 ;
	setAttr ".pt[1173]" -type "float3" 2.0675125 6.6512895 -0.54947144 ;
	setAttr ".pt[1174]" -type "float3" 1.8439693 6.7309194 -0.48315272 ;
	setAttr ".pt[1175]" -type "float3" 1.5534422 6.5122795 -0.30760399 ;
	setAttr ".pt[1176]" -type "float3" 1.2567823 5.9225388 -0.091735348 ;
	setAttr ".pt[1177]" -type "float3" 0.89617699 5.053545 0.012792516 ;
	setAttr ".pt[1178]" -type "float3" 0.49911165 3.4563107 -0.039916445 ;
	setAttr ".pt[1179]" -type "float3" 0.33042574 2.0569036 -0.09241382 ;
	setAttr ".pt[1180]" -type "float3" 0.2347876 0.92306018 -0.097199932 ;
	setAttr ".pt[1181]" -type "float3" 0.11379136 0.13666873 -0.075445585 ;
	setAttr ".pt[1182]" -type "float3" 0.033544268 -0.27259493 -0.027713053 ;
	setAttr ".pt[1183]" -type "float3" 0.010941898 -0.14272769 -0.0071624657 ;
	setAttr ".pt[1193]" -type "float3" 0.020826453 0.017475585 -0.0034614229 ;
	setAttr ".pt[1194]" -type "float3" 0.019764354 -0.085306972 -0.023538793 ;
	setAttr ".pt[1195]" -type "float3" 0.011066817 -0.28763837 -0.01852468 ;
	setAttr ".pt[1196]" -type "float3" -0.013802768 -0.27529955 -0.0082106395 ;
	setAttr ".pt[1197]" -type "float3" -0.025215052 -0.13860033 -0.003217075 ;
	setAttr ".pt[1198]" -type "float3" -0.040575128 -0.13441439 -0.011804298 ;
	setAttr ".pt[1199]" -type "float3" -0.035368357 -0.10529492 -0.012874885 ;
	setAttr ".pt[1200]" -type "float3" -0.010159473 -0.060968924 -0.0050514434 ;
	setAttr ".pt[1201]" -type "float3" 0.012165546 -0.046372883 0.00033637031 ;
	setAttr ".pt[1202]" -type "float3" 0.045303099 -0.26003614 0.0034953339 ;
	setAttr ".pt[1203]" -type "float3" 0.016503278 -0.34885487 0.0061169644 ;
	setAttr ".pt[1204]" -type "float3" -0.019556692 -0.23869333 0.0031044905 ;
	setAttr ".pt[1205]" -type "float3" 0.0030716578 -0.16452014 -0.0063572046 ;
	setAttr ".pt[1206]" -type "float3" 0.028094752 -0.067748606 -0.011627284 ;
	setAttr ".pt[1215]" -type "float3" -0.00856415 0.021995539 -0.0029661166 ;
	setAttr ".pt[1216]" -type "float3" -0.018310698 0.037576817 -0.0023575495 ;
	setAttr ".pt[1218]" -type "float3" -0.15333138 0.026161291 -0.0021921007 ;
	setAttr ".pt[1219]" -type "float3" -0.29527456 0.013721325 -0.010598875 ;
	setAttr ".pt[1220]" -type "float3" -0.33667755 -0.014180705 -0.016808366 ;
	setAttr ".pt[1221]" -type "float3" -0.20055424 -0.021782154 -0.010995905 ;
	setAttr ".pt[1224]" -type "float3" 1.9397552 5.8046074 -0.39261049 ;
	setAttr ".pt[1225]" -type "float3" 1.8174622 5.8952432 -0.27065504 ;
	setAttr ".pt[1226]" -type "float3" 1.5463579 5.8245959 -0.063392907 ;
	setAttr ".pt[1227]" -type "float3" 1.2274317 5.4493461 0.15647249 ;
	setAttr ".pt[1228]" -type "float3" 0.87655306 4.7130756 0.247234 ;
	setAttr ".pt[1229]" -type "float3" 0.45273286 3.5626831 0.18361275 ;
	setAttr ".pt[1230]" -type "float3" 0.32385719 2.2199395 0.049599823 ;
	setAttr ".pt[1231]" -type "float3" 0.25462866 0.86383271 0.011733718 ;
	setAttr ".pt[1232]" -type "float3" 0.14303437 -0.077080868 -0.0094555486 ;
	setAttr ".pt[1233]" -type "float3" 0.047325328 -0.38425735 0.007368674 ;
	setAttr ".pt[1234]" -type "float3" 0.01021928 -0.204252 0.0074842963 ;
	setAttr ".pt[1244]" -type "float3" 0.0069147353 0.11076998 -0.01201131 ;
	setAttr ".pt[1245]" -type "float3" 0.011843137 0.12298705 -0.027441924 ;
	setAttr ".pt[1246]" -type "float3" 0.0052255248 -0.094946824 -0.020244766 ;
	setAttr ".pt[1247]" -type "float3" -0.01560759 -0.16851498 -0.012950898 ;
	setAttr ".pt[1248]" -type "float3" -0.022250831 -0.14899296 -0.012684491 ;
	setAttr ".pt[1249]" -type "float3" -0.03234724 -0.1963746 -0.023747774 ;
	setAttr ".pt[1250]" -type "float3" -0.032179125 -0.23463224 -0.026288506 ;
	setAttr ".pt[1251]" -type "float3" -0.0087473532 -0.16374831 -0.010344721 ;
	setAttr ".pt[1252]" -type "float3" 0.0017005119 -0.016850706 -0.0010330912 ;
	setAttr ".pt[1253]" -type "float3" 0.026848439 -0.12104496 -0.014473631 ;
	setAttr ".pt[1254]" -type "float3" 0.0066283434 -0.13911608 -0.0019691407 ;
	setAttr ".pt[1255]" -type "float3" -0.0066247 -0.065848514 0.0047267065 ;
	setAttr ".pt[1256]" -type "float3" 0.010843753 0.031342227 0.0068351119 ;
	setAttr ".pt[1257]" -type "float3" 0.023403654 0.1275046 0.0042937789 ;
	setAttr ".pt[1258]" -type "float3" 0.0041154544 0.06109038 0.00013464522 ;
	setAttr ".pt[1266]" -type "float3" -0.032285959 0.027935784 -0.012459937 ;
	setAttr ".pt[1267]" -type "float3" -0.04815165 0.044326514 -0.010915595 ;
	setAttr ".pt[1268]" -type "float3" -0.020104874 0.0079228766 -0.0011128439 ;
	setAttr ".pt[1269]" -type "float3" -0.16114359 0.0052775741 -0.0039235484 ;
	setAttr ".pt[1270]" -type "float3" -0.32579723 -0.036342714 -0.010467863 ;
	setAttr ".pt[1271]" -type "float3" -0.41063184 -0.076235496 -0.014768723 ;
	setAttr ".pt[1272]" -type "float3" -0.34702489 -0.055043671 -0.0082434006 ;
	setAttr ".pt[1273]" -type "float3" -0.20320396 0.014189372 0.0018852922 ;
	setAttr ".pt[1275]" -type "float3" 1.7385367 4.9373527 -0.24394864 ;
	setAttr ".pt[1276]" -type "float3" 1.6960024 5.1213517 -0.078369722 ;
	setAttr ".pt[1277]" -type "float3" 1.5130973 5.2075591 0.14186788 ;
	setAttr ".pt[1278]" -type "float3" 1.2287023 4.9806938 0.31212842 ;
	setAttr ".pt[1279]" -type "float3" 0.86408728 4.3887587 0.37502944 ;
	setAttr ".pt[1280]" -type "float3" 0.4935928 3.4220974 0.32598883 ;
	setAttr ".pt[1281]" -type "float3" 0.29442519 2.4108791 0.17975764 ;
	setAttr ".pt[1282]" -type "float3" 0.23947564 1.0007198 0.12747458 ;
	setAttr ".pt[1283]" -type "float3" 0.15050396 -0.083258837 0.11457761 ;
	setAttr ".pt[1284]" -type "float3" 0.053511322 -0.31500679 0.078367658 ;
	setAttr ".pt[1285]" -type "float3" 0.011076277 -0.18627635 0.044419248 ;
	setAttr ".pt[1295]" -type "float3" 0.0047852807 0.063498855 -0.0097852899 ;
	setAttr ".pt[1296]" -type "float3" 0.010237316 0.17894229 -0.025250372 ;
	setAttr ".pt[1297]" -type "float3" 6.733014e-005 0.19554664 -0.026382398 ;
	setAttr ".pt[1298]" -type "float3" -0.015329733 0.049721412 -0.018049642 ;
	setAttr ".pt[1299]" -type "float3" -0.016113903 -0.14736214 -0.01827937 ;
	setAttr ".pt[1300]" -type "float3" -0.018329293 -0.23142758 -0.015169676 ;
	setAttr ".pt[1301]" -type "float3" -0.029045276 -0.18835215 -0.027188065 ;
	setAttr ".pt[1302]" -type "float3" -0.0073611904 0.010433099 -0.020402942 ;
	setAttr ".pt[1303]" -type "float3" -0.00047348667 0.025408398 -0.0020555337 ;
	setAttr ".pt[1304]" -type "float3" -0.0023340415 0.28782552 -0.017502613 ;
	setAttr ".pt[1305]" -type "float3" -0.0056878719 0.25512531 -0.01223725 ;
	setAttr ".pt[1306]" -type "float3" -0.0033549336 0.13667864 -0.00072589196 ;
	setAttr ".pt[1307]" -type "float3" 0.0047878623 0.19600111 0.0064143543 ;
	setAttr ".pt[1308]" -type "float3" 0.012687154 0.19371381 0.0079709506 ;
	setAttr ".pt[1309]" -type "float3" 0.0095162587 0.0032535761 0.0025655599 ;
	setAttr ".pt[1317]" -type "float3" -0.049499705 -0.033042539 -0.016670521 ;
	setAttr ".pt[1318]" -type "float3" -0.07817328 -0.0095547624 -0.015452297 ;
	setAttr ".pt[1319]" -type "float3" -0.07100299 -0.00058572448 -0.0037966233 ;
	setAttr ".pt[1320]" -type "float3" -0.15790719 -0.023265645 -0.0021355683 ;
	setAttr ".pt[1321]" -type "float3" -0.33082658 -0.091984786 -0.0089000454 ;
	setAttr ".pt[1322]" -type "float3" -0.45100772 -0.12506275 -0.015040072 ;
	setAttr ".pt[1323]" -type "float3" -0.45749226 -0.023393743 -0.0073704491 ;
	setAttr ".pt[1324]" -type "float3" -0.46046019 0.11805452 0.0057324101 ;
	setAttr ".pt[1325]" -type "float3" -0.18001357 0.060777642 0.0032861507 ;
	setAttr ".pt[1326]" -type "float3" 1.5775286 4.0830126 -0.092479043 ;
	setAttr ".pt[1327]" -type "float3" 1.5763252 4.3635788 0.048878185 ;
	setAttr ".pt[1328]" -type "float3" 1.4982187 4.6067977 0.24834396 ;
	setAttr ".pt[1329]" -type "float3" 1.2157719 4.508112 0.37586191 ;
	setAttr ".pt[1330]" -type "float3" 0.85170788 4.0272422 0.40887579 ;
	setAttr ".pt[1331]" -type "float3" 0.4742898 3.2348657 0.36781743 ;
	setAttr ".pt[1332]" -type "float3" 0.29240423 2.0624683 0.19304016 ;
	setAttr ".pt[1333]" -type "float3" 0.19915216 0.87504077 0.10594156 ;
	setAttr ".pt[1334]" -type "float3" 0.081946678 0.036033176 0.077198826 ;
	setAttr ".pt[1335]" -type "float3" 0.055704318 -0.099666141 0.076781802 ;
	setAttr ".pt[1336]" -type "float3" 0.017975882 -0.045480255 0.036495142 ;
	setAttr ".pt[1346]" -type "float3" 3.4372541e-005 0.0001536483 -5.0643932e-005 ;
	setAttr ".pt[1347]" -type "float3" 0.0087920595 0.097355954 -0.014887994 ;
	setAttr ".pt[1348]" -type "float3" 0.0018183842 0.07553225 -0.010903433 ;
	setAttr ".pt[1349]" -type "float3" -0.015626701 0.10644383 -0.0053750491 ;
	setAttr ".pt[1350]" -type "float3" -0.029424265 0.18318531 -0.012192843 ;
	setAttr ".pt[1351]" -type "float3" -0.035950825 0.20926863 -0.016079979 ;
	setAttr ".pt[1352]" -type "float3" -0.034617186 0.26061854 -0.017217867 ;
	setAttr ".pt[1353]" -type "float3" -0.02288718 0.21447356 -0.013632956 ;
	setAttr ".pt[1354]" -type "float3" -0.0030908217 0.065385282 -0.0038194642 ;
	setAttr ".pt[1355]" -type "float3" 0.0033949937 0.085334465 -0.0064828652 ;
	setAttr ".pt[1356]" -type "float3" -0.0014764515 0.097733155 -0.0043245219 ;
	setAttr ".pt[1357]" -type "float3" -0.0027662481 0.11760729 -3.6263053e-005 ;
	setAttr ".pt[1358]" -type "float3" 0.00082117668 0.12479059 0.0040912046 ;
	setAttr ".pt[1359]" -type "float3" 0.0065188985 0.14738446 0.0051134056 ;
	setAttr ".pt[1360]" -type "float3" 0.0060259346 0.018328262 0.0016758234 ;
	setAttr ".pt[1368]" -type "float3" -0.053175684 -0.11712032 -0.018553238 ;
	setAttr ".pt[1369]" -type "float3" -0.094409972 -0.10856943 -0.020341406 ;
	setAttr ".pt[1370]" -type "float3" -0.10400431 -0.055537034 -0.0065889983 ;
	setAttr ".pt[1371]" -type "float3" -0.1394674 -0.045102011 0.0016988213 ;
	setAttr ".pt[1372]" -type "float3" -0.30717355 -0.12233786 -0.0039963513 ;
	setAttr ".pt[1373]" -type "float3" -0.46047246 -0.118092 -0.010966313 ;
	setAttr ".pt[1374]" -type "float3" -0.50451326 0.079077691 -0.0021223843 ;
	setAttr ".pt[1375]" -type "float3" -0.61468017 0.16099364 0.0020956085 ;
	setAttr ".pt[1376]" -type "float3" -0.51834702 0.11638586 0.00057683227 ;
	setAttr ".pt[1377]" -type "float3" 1.3195138 3.2516234 0.056180418 ;
	setAttr ".pt[1378]" -type "float3" 1.4032711 3.6207612 0.13226929 ;
	setAttr ".pt[1379]" -type "float3" 1.4397285 3.9883516 0.27084279 ;
	setAttr ".pt[1380]" -type "float3" 1.210976 4.0268464 0.35600999 ;
	setAttr ".pt[1381]" -type "float3" 0.84930176 3.6959572 0.37335864 ;
	setAttr ".pt[1382]" -type "float3" 0.45233795 3.0856507 0.33697081 ;
	setAttr ".pt[1383]" -type "float3" 0.26433191 1.8417645 0.17218976 ;
	setAttr ".pt[1384]" -type "float3" 0.14911538 0.71445513 0.053359505 ;
	setAttr ".pt[1385]" -type "float3" 0.0745866 0.11992942 0.0068140454 ;
	setAttr ".pt[1386]" -type "float3" 0.063124351 -0.049603608 -0.0082716225 ;
	setAttr ".pt[1387]" -type "float3" 0.033128701 -0.026422756 -0.010191341 ;
	setAttr ".pt[1398]" -type "float3" 0.0054814448 0.10486879 -0.012462506 ;
	setAttr ".pt[1399]" -type "float3" -0.0016610273 0.070459895 -0.0066526793 ;
	setAttr ".pt[1400]" -type "float3" -0.017423093 0.015433291 0.0038864766 ;
	setAttr ".pt[1401]" -type "float3" -0.031684645 0.071858659 0.0038089864 ;
	setAttr ".pt[1402]" -type "float3" -0.040883567 0.099481344 -0.0011913977 ;
	setAttr ".pt[1403]" -type "float3" -0.040866826 0.08927089 -0.0053818068 ;
	setAttr ".pt[1404]" -type "float3" -0.027917152 0.084854662 -0.0035455516 ;
	setAttr ".pt[1405]" -type "float3" -0.0065198336 0.030838469 0.0018880919 ;
	setAttr ".pt[1406]" -type "float3" 0.0053815632 0.067370683 0.003529432 ;
	setAttr ".pt[1407]" -type "float3" 0.0044089472 0.087498315 -0.0028299582 ;
	setAttr ".pt[1408]" -type "float3" 0.00038720929 0.11080971 -0.0052207471 ;
	setAttr ".pt[1409]" -type "float3" -0.0010446643 0.094421268 -0.00028465377 ;
	setAttr ".pt[1410]" -type "float3" 1.0435935e-005 0.13077326 -0.0016054109 ;
	setAttr ".pt[1411]" -type "float3" 0.00095209398 0.0097132837 -0.00093655509 ;
	setAttr ".pt[1412]" -type "float3" -0.0029711977 -0.014330478 0.00015828565 ;
	setAttr ".pt[1415]" -type "float3" 0.0011443913 -0.0043557608 -0.00043247122 ;
	setAttr ".pt[1419]" -type "float3" -0.048884485 -0.16527809 -0.018292993 ;
	setAttr ".pt[1420]" -type "float3" -0.099776149 -0.21068706 -0.025814557 ;
	setAttr ".pt[1421]" -type "float3" -0.12375352 -0.14804623 -0.013411512 ;
	setAttr ".pt[1422]" -type "float3" -0.11435045 -0.058153711 0.0024622339 ;
	setAttr ".pt[1423]" -type "float3" -0.27460879 -0.10250723 0.0021621077 ;
	setAttr ".pt[1424]" -type "float3" -0.40918365 -0.030479541 0.0011692015 ;
	setAttr ".pt[1425]" -type "float3" -0.47874439 0.15012273 0.0087126764 ;
	setAttr ".pt[1426]" -type "float3" -0.67849904 0.16296567 0.0092501128 ;
	setAttr ".pt[1427]" -type "float3" -0.76073241 0.14794862 0.0085226269 ;
	setAttr ".pt[1428]" -type "float3" 0.87260252 2.4605222 0.27666619 ;
	setAttr ".pt[1429]" -type "float3" 1.2875 3.0102861 0.23535246 ;
	setAttr ".pt[1430]" -type "float3" 1.4485949 3.4368093 0.25678515 ;
	setAttr ".pt[1431]" -type "float3" 1.2377243 3.5614738 0.27695173 ;
	setAttr ".pt[1432]" -type "float3" 0.87206829 3.3624618 0.26844931 ;
	setAttr ".pt[1433]" -type "float3" 0.46802399 2.9088745 0.23370825 ;
	setAttr ".pt[1434]" -type "float3" 0.25087568 1.7281349 0.099729188 ;
	setAttr ".pt[1435]" -type "float3" 0.1221174 0.63924843 0.0074710399 ;
	setAttr ".pt[1436]" -type "float3" 0.071501516 0.14815518 -0.029766448 ;
	setAttr ".pt[1437]" -type "float3" 0.060224205 -0.040631957 -0.041236226 ;
	setAttr ".pt[1438]" -type "float3" 0.039407544 -0.050562628 -0.028969904 ;
	setAttr ".pt[1445]" -type "float3" 0.00047070166 -0.0064707012 -0.00058865792 ;
	setAttr ".pt[1446]" -type "float3" 0.0045434781 -0.0087468587 0.0013561384 ;
	setAttr ".pt[1449]" -type "float3" 0.0057185856 0.2907767 -0.018370302 ;
	setAttr ".pt[1450]" -type "float3" -0.0037365765 0.25254247 -0.024796544 ;
	setAttr ".pt[1451]" -type "float3" -0.020875039 0.15137975 -0.012524985 ;
	setAttr ".pt[1452]" -type "float3" -0.036923423 0.21855867 -0.0076279119 ;
	setAttr ".pt[1453]" -type "float3" -0.037981946 0.15557498 -0.010244273 ;
	setAttr ".pt[1454]" -type "float3" -0.045178875 0.090909563 -0.010189493 ;
	setAttr ".pt[1455]" -type "float3" -0.032927308 0.081105515 -0.0028202957 ;
	setAttr ".pt[1456]" -type "float3" -0.010484915 0.064281918 0.0027783071 ;
	setAttr ".pt[1457]" -type "float3" 0.0059705786 0.10236592 0.0027075633 ;
	setAttr ".pt[1458]" -type "float3" 0.012730546 0.073812418 -0.011336425 ;
	setAttr ".pt[1459]" -type "float3" 0.0057335985 0.058158439 -0.014588246 ;
	setAttr ".pt[1460]" -type "float3" -0.00031263099 0.0074991463 -0.00090542738 ;
	setAttr ".pt[1461]" -type "float3" -0.0055762106 0.095700018 -0.0073798313 ;
	setAttr ".pt[1462]" -type "float3" -0.0060363533 0.013739677 -0.0062033809 ;
	setAttr ".pt[1463]" -type "float3" -0.010144304 -0.022266513 -0.0031254552 ;
	setAttr ".pt[1465]" -type "float3" 0.00076873379 -0.0029979488 0.00013386225 ;
	setAttr ".pt[1466]" -type "float3" 0.0050585777 -0.019783881 0.0011105476 ;
	setAttr ".pt[1467]" -type "float3" 0.0035404293 -0.013499994 0.0016628751 ;
	setAttr ".pt[1470]" -type "float3" -0.041467857 -0.12604758 -0.011487233 ;
	setAttr ".pt[1471]" -type "float3" -0.092192695 -0.22725156 -0.025797974 ;
	setAttr ".pt[1472]" -type "float3" -0.1185215 -0.20002508 -0.020100199 ;
	setAttr ".pt[1473]" -type "float3" -0.090955608 -0.070011944 -0.00054974208 ;
	setAttr ".pt[1474]" -type "float3" -0.22695602 -0.018411711 0.0079428181 ;
	setAttr ".pt[1475]" -type "float3" -0.38008803 0.14432432 0.018019902 ;
	setAttr ".pt[1476]" -type "float3" -0.50061506 0.17765684 0.01871084 ;
	setAttr ".pt[1477]" -type "float3" -0.79447466 0.17715043 0.020583011 ;
	setAttr ".pt[1478]" -type "float3" -0.86606115 0.16686659 0.019117476 ;
	setAttr ".pt[1479]" -type "float3" 1.0569769 2.4894822 0.52719951 ;
	setAttr ".pt[1480]" -type "float3" 1.4667094 2.7929363 0.32532004 ;
	setAttr ".pt[1481]" -type "float3" 1.6154555 3.0760851 0.21609165 ;
	setAttr ".pt[1482]" -type "float3" 1.343785 3.219831 0.17110786 ;
	setAttr ".pt[1483]" -type "float3" 0.95142889 3.1050339 0.12793839 ;
	setAttr ".pt[1484]" -type "float3" 0.5649941 2.7434378 0.075623117 ;
	setAttr ".pt[1485]" -type "float3" 0.30395219 1.7638915 0.0025970014 ;
	setAttr ".pt[1486]" -type "float3" 0.11461651 0.66755164 -0.029223822 ;
	setAttr ".pt[1487]" -type "float3" 0.093043394 0.1574816 -0.05016705 ;
	setAttr ".pt[1488]" -type "float3" 0.055228747 -0.1178913 -0.054670732 ;
	setAttr ".pt[1489]" -type "float3" 0.035669122 -0.10061841 -0.035264816 ;
	setAttr ".pt[1496]" -type "float3" -0.0049006054 -0.076342717 -0.010156037 ;
	setAttr ".pt[1497]" -type "float3" 0.0024280255 -0.058524877 -0.0033760464 ;
	setAttr ".pt[1498]" -type "float3" 0.012101737 0.066681899 0.0093991421 ;
	setAttr ".pt[1500]" -type "float3" 0.009136227 0.10616077 -0.016114516 ;
	setAttr ".pt[1501]" -type "float3" 0.00067243446 0.21325691 -0.023190502 ;
	setAttr ".pt[1502]" -type "float3" -0.021671191 0.28553855 -0.013829697 ;
	setAttr ".pt[1503]" -type "float3" -0.045092516 0.32328632 -0.0075543695 ;
	setAttr ".pt[1504]" -type "float3" -0.0364783 0.13457687 -0.018868636 ;
	setAttr ".pt[1505]" -type "float3" -0.047887586 0.080530338 -0.014853894 ;
	setAttr ".pt[1506]" -type "float3" -0.034683872 0.068554215 -0.0027280764 ;
	setAttr ".pt[1507]" -type "float3" -0.0099118399 0.047583491 -0.00062092987 ;
	setAttr ".pt[1508]" -type "float3" 0.0082520787 0.070083313 -0.00099283643 ;
	setAttr ".pt[1509]" -type "float3" 0.018925469 0.015868703 -0.016995676 ;
	setAttr ".pt[1510]" -type "float3" 0.0090931607 0.0029525033 -0.017677212 ;
	setAttr ".pt[1512]" -type "float3" -0.0075700996 0.084073767 -0.011467619 ;
	setAttr ".pt[1513]" -type "float3" -0.009687745 0.037051316 -0.018481027 ;
	setAttr ".pt[1514]" -type "float3" -0.012853375 -0.020905081 -0.01676918 ;
	setAttr ".pt[1516]" -type "float3" -0.00058230193 0.0092709968 -0.00056571234 ;
	setAttr ".pt[1517]" -type "float3" 0.01041378 -0.0030767482 0.0045792805 ;
	setAttr ".pt[1518]" -type "float3" 0.015996838 -0.01947552 0.0049576662 ;
	setAttr ".pt[1519]" -type "float3" 0.0055154748 -0.0062394454 0.00080912677 ;
	setAttr ".pt[1520]" -type "float3" 0.001274999 0.0054358742 0.0012552112 ;
	setAttr ".pt[1521]" -type "float3" -0.028341822 -0.070824958 -0.011110675 ;
	setAttr ".pt[1522]" -type "float3" -0.083969474 -0.18025339 -0.030030781 ;
	setAttr ".pt[1523]" -type "float3" -0.10902587 -0.155248 -0.026075281 ;
	setAttr ".pt[1524]" -type "float3" -0.068624623 -0.014999416 -0.0021690805 ;
	setAttr ".pt[1525]" -type "float3" -0.19880116 0.15461193 0.018207399 ;
	setAttr ".pt[1526]" -type "float3" -0.35401276 0.2102858 0.0252741 ;
	setAttr ".pt[1527]" -type "float3" -0.45703602 0.11704624 0.015443632 ;
	setAttr ".pt[1528]" -type "float3" -0.79237229 0.14972292 0.019814169 ;
	setAttr ".pt[1529]" -type "float3" -0.9917866 0.16392156 0.021623526 ;
	setAttr ".pt[1530]" -type "float3" 1.0977328 2.7331898 0.41756874 ;
	setAttr ".pt[1531]" -type "float3" 1.6499823 2.7713056 0.23703936 ;
	setAttr ".pt[1532]" -type "float3" 1.6838374 2.9137385 0.12552014 ;
	setAttr ".pt[1533]" -type "float3" 1.4394088 3.0283785 0.049644873 ;
	setAttr ".pt[1534]" -type "float3" 1.049309 2.9817522 -0.026876209 ;
	setAttr ".pt[1535]" -type "float3" 0.74445802 2.6933818 -0.11598277 ;
	setAttr ".pt[1536]" -type "float3" 0.43562856 1.922119 -0.11437578 ;
	setAttr ".pt[1537]" -type "float3" 0.24811074 0.90342003 -0.072204642 ;
	setAttr ".pt[1538]" -type "float3" 0.14241943 0.16290498 -0.068350613 ;
	setAttr ".pt[1539]" -type "float3" 0.030395465 -0.33745036 -0.056148395 ;
	setAttr ".pt[1540]" -type "float3" 0.023190353 -0.22101305 -0.035214037 ;
	setAttr ".pt[1547]" -type "float3" -0.0090261782 -0.095951609 -0.014260144 ;
	setAttr ".pt[1548]" -type "float3" 0.00094989396 -0.072741859 -0.0042956294 ;
	setAttr ".pt[1549]" -type "float3" 0.019643946 0.094352543 0.018831262 ;
	setAttr ".pt[1551]" -type "float3" 0.0043307231 0.0060247788 -0.0049218265 ;
	setAttr ".pt[1552]" -type "float3" 0.00069714338 0.084717952 -0.0034513804 ;
	setAttr ".pt[1553]" -type "float3" -0.022871923 0.24030872 0.01898336 ;
	setAttr ".pt[1554]" -type "float3" -0.04504754 0.22599973 0.017751101 ;
	setAttr ".pt[1555]" -type "float3" -0.043870278 0.14891084 0.0095538385 ;
	setAttr ".pt[1556]" -type "float3" -0.056754384 0.13439609 0.023295909 ;
	setAttr ".pt[1557]" -type "float3" -0.034851238 0.088859305 0.0221806 ;
	setAttr ".pt[1558]" -type "float3" -0.0076218769 0.046889365 0.011819185 ;
	setAttr ".pt[1559]" -type "float3" 0.0071486342 0.034813873 0.0077394382 ;
	setAttr ".pt[1560]" -type "float3" 0.018471083 -0.027884912 -0.011300085 ;
	setAttr ".pt[1561]" -type "float3" 0.0070290705 -0.020840425 -0.010968194 ;
	setAttr ".pt[1563]" -type "float3" -0.003286167 0.049749848 -0.0071423855 ;
	setAttr ".pt[1564]" -type "float3" -0.0077714184 0.045387682 -0.024649501 ;
	setAttr ".pt[1565]" -type "float3" -0.010702626 -0.021583255 -0.025546206 ;
	setAttr ".pt[1567]" -type "float3" -0.0024137218 0.018100228 -0.0020233407 ;
	setAttr ".pt[1568]" -type "float3" 0.014069539 0.032267261 0.0019554007 ;
	setAttr ".pt[1569]" -type "float3" 0.031075811 -0.0037703491 -0.0015627308 ;
	setAttr ".pt[1570]" -type "float3" 0.024354976 -0.027568776 -0.0091446992 ;
	setAttr ".pt[1571]" -type "float3" 0.007485332 -0.0060756174 -0.0070750853 ;
	setAttr ".pt[1572]" -type "float3" -0.017210292 -0.060842022 -0.021357408 ;
	setAttr ".pt[1573]" -type "float3" -0.080288142 -0.13512605 -0.033282369 ;
	setAttr ".pt[1574]" -type "float3" -0.098766245 -0.048730966 -0.022109022 ;
	setAttr ".pt[1575]" -type "float3" -0.04363066 0.086313128 0.0041680154 ;
	setAttr ".pt[1576]" -type "float3" -0.17714176 0.20586799 0.019463455 ;
	setAttr ".pt[1577]" -type "float3" -0.29793519 0.15516789 0.016423021 ;
	setAttr ".pt[1578]" -type "float3" -0.36846438 0.053081304 0.005284118 ;
	setAttr ".pt[1579]" -type "float3" -0.74396777 0.078384154 0.0083233975 ;
	setAttr ".pt[1580]" -type "float3" -0.91612935 0.083442532 0.0095803654 ;
	setAttr ".pt[1581]" -type "float3" 0.85839355 2.7322648 0.088120766 ;
	setAttr ".pt[1582]" -type "float3" 1.6111218 2.7491512 0.044528291 ;
	setAttr ".pt[1583]" -type "float3" 1.6995651 2.8524129 -0.0014206575 ;
	setAttr ".pt[1584]" -type "float3" 1.4973775 2.9689126 -0.069311135 ;
	setAttr ".pt[1585]" -type "float3" 1.1709291 2.9913011 -0.17473404 ;
	setAttr ".pt[1586]" -type "float3" 0.97231847 2.8075905 -0.31934798 ;
	setAttr ".pt[1587]" -type "float3" 0.56677794 2.2020462 -0.22146267 ;
	setAttr ".pt[1588]" -type "float3" 0.33932301 1.0826509 -0.10902207 ;
	setAttr ".pt[1589]" -type "float3" 0.16561839 0.17691563 -0.058534648 ;
	setAttr ".pt[1590]" -type "float3" 0.016385596 -0.43680385 -0.020537585 ;
	setAttr ".pt[1591]" -type "float3" 0.00031034148 -0.30163392 -0.0040948568 ;
	setAttr ".pt[1598]" -type "float3" -0.003317134 -0.040071093 -0.0056105959 ;
	setAttr ".pt[1599]" -type "float3" 0.0092669921 -0.020622175 0.0097645223 ;
	setAttr ".pt[1600]" -type "float3" 0.031500529 0.144697 0.039743423 ;
	setAttr ".pt[1601]" -type "float3" 0.016602842 0.060401473 0.016378405 ;
	setAttr ".pt[1604]" -type "float3" -0.020008381 0.11788359 0.025863944 ;
	setAttr ".pt[1605]" -type "float3" -0.042234238 0.12395796 0.034910344 ;
	setAttr ".pt[1606]" -type "float3" -0.04810879 0.083772823 0.032676686 ;
	setAttr ".pt[1607]" -type "float3" -0.049778637 0.032513756 0.044137504 ;
	setAttr ".pt[1608]" -type "float3" -0.024035973 -0.010070633 0.042658668 ;
	setAttr ".pt[1609]" -type "float3" 0.0017027524 0.067218646 0.043963525 ;
	setAttr ".pt[1610]" -type "float3" 0.016866697 0.11662882 0.041344974 ;
	setAttr ".pt[1611]" -type "float3" 0.0075248904 0.0020240846 0.0036585224 ;
	setAttr ".pt[1612]" -type "float3" 0.00027438192 -0.0010046007 -0.00021645182 ;
	setAttr ".pt[1615]" -type "float3" -0.0046252646 0.037480202 -0.021307897 ;
	setAttr ".pt[1616]" -type "float3" -0.0089531867 -0.030917089 -0.025760734 ;
	setAttr ".pt[1617]" -type "float3" -0.0064894599 -0.014120868 -0.0079001933 ;
	setAttr ".pt[1619]" -type "float3" 0.016246473 0.034981646 -0.0031719287 ;
	setAttr ".pt[1620]" -type "float3" 0.041710909 -0.016518373 -0.011029628 ;
	setAttr ".pt[1621]" -type "float3" 0.040022962 -0.060334034 -0.019550676 ;
	setAttr ".pt[1622]" -type "float3" 0.020510506 -0.021630809 -0.013543935 ;
	setAttr ".pt[1623]" -type "float3" -0.012039036 -0.068742946 -0.016466008 ;
	setAttr ".pt[1624]" -type "float3" -0.081480801 -0.17027317 -0.025264576 ;
	setAttr ".pt[1625]" -type "float3" -0.11283744 -0.090211459 -0.013814954 ;
	setAttr ".pt[1626]" -type "float3" -0.078005254 0.093262561 0.0098258322 ;
	setAttr ".pt[1627]" -type "float3" -0.14386855 0.14605145 0.018058298 ;
	setAttr ".pt[1628]" -type "float3" -0.21193007 0.077878833 0.009282127 ;
	setAttr ".pt[1629]" -type "float3" -0.21612895 0.00052774214 -0.0006827527 ;
	setAttr ".pt[1630]" -type "float3" -0.50946122 -0.0049637547 -0.0020924371 ;
	setAttr ".pt[1631]" -type "float3" -0.71027708 0.011905743 -0.00048361049 ;
	setAttr ".pt[1632]" -type "float3" 0.98302197 2.9715264 -0.24238393 ;
	setAttr ".pt[1633]" -type "float3" 1.5274397 2.7776744 -0.15702476 ;
	setAttr ".pt[1634]" -type "float3" 1.6846143 2.8286169 -0.11767922 ;
	setAttr ".pt[1635]" -type "float3" 1.5726756 2.964488 -0.14622061 ;
	setAttr ".pt[1636]" -type "float3" 1.3487235 3.0570316 -0.23665558 ;
	setAttr ".pt[1637]" -type "float3" 1.1277094 2.8712275 -0.39332888 ;
	setAttr ".pt[1638]" -type "float3" 0.68862653 2.1785884 -0.27206969 ;
	setAttr ".pt[1639]" -type "float3" 0.35962424 1.202155 -0.11648323 ;
	setAttr ".pt[1640]" -type "float3" 0.12310927 0.20044114 -0.024478538 ;
	setAttr ".pt[1641]" -type "float3" 0.003378836 -0.34517908 0.03524287 ;
	setAttr ".pt[1642]" -type "float3" -0.0089102313 -0.20914432 0.030367745 ;
	setAttr ".pt[1650]" -type "float3" 0.016787838 0.035988659 0.024285544 ;
	setAttr ".pt[1651]" -type "float3" 0.034946643 0.12459344 0.04701997 ;
	setAttr ".pt[1652]" -type "float3" 0.027337274 0.050079841 0.02852457 ;
	setAttr ".pt[1655]" -type "float3" -0.012064223 0.043101389 0.018922396 ;
	setAttr ".pt[1656]" -type "float3" -0.033458278 0.048393063 0.03441745 ;
	setAttr ".pt[1657]" -type "float3" -0.041374657 0.020536054 0.038403623 ;
	setAttr ".pt[1658]" -type "float3" -0.035243183 -0.030092694 0.043148585 ;
	setAttr ".pt[1659]" -type "float3" -0.010544162 -0.063095674 0.043786306 ;
	setAttr ".pt[1660]" -type "float3" 0.014642977 -0.047322582 0.053236812 ;
	setAttr ".pt[1661]" -type "float3" 0.031428367 0.033452269 0.061152056 ;
	setAttr ".pt[1662]" -type "float3" 0.029169502 0.005732364 0.034227673 ;
	setAttr ".pt[1663]" -type "float3" 0.0099339997 0.0053596883 0.0056990753 ;
	setAttr ".pt[1666]" -type "float3" -0.0028259109 0.029619688 -0.0098527679 ;
	setAttr ".pt[1667]" -type "float3" -0.0072387173 -0.0081994394 -0.012166703 ;
	setAttr ".pt[1668]" -type "float3" -0.0039479472 -0.016926486 -0.0039052176 ;
	setAttr ".pt[1670]" -type "float3" 0.011060501 0.010902615 -0.0042216564 ;
	setAttr ".pt[1671]" -type "float3" 0.046352044 -0.047989398 -0.011804716 ;
	setAttr ".pt[1672]" -type "float3" 0.051186983 -0.11097813 -0.017065551 ;
	setAttr ".pt[1673]" -type "float3" 0.032163218 -0.079694353 -0.0054232231 ;
	setAttr ".pt[1674]" -type "float3" -0.0077677849 -0.13191141 0.0054073515 ;
	setAttr ".pt[1675]" -type "float3" -0.077516988 -0.23112577 0.00069943536 ;
	setAttr ".pt[1676]" -type "float3" -0.11418954 -0.20156302 -3.6136225e-005 ;
	setAttr ".pt[1677]" -type "float3" -0.097598985 -0.029667996 0.010520258 ;
	setAttr ".pt[1678]" -type "float3" -0.10070302 0.092051208 0.02011656 ;
	setAttr ".pt[1679]" -type "float3" -0.11690199 0.033792883 0.0084653236 ;
	setAttr ".pt[1680]" -type "float3" -0.041997664 -0.0089478893 -0.00073642371 ;
	setAttr ".pt[1681]" -type "float3" -0.24771583 -0.021558184 -0.0034066634 ;
	setAttr ".pt[1682]" -type "float3" -0.30638093 0.00089266943 -0.0016108407 ;
	setAttr ".pt[1683]" -type "float3" 1.0009106 2.4887722 -0.22195411 ;
	setAttr ".pt[1684]" -type "float3" 0.97886747 2.6637545 -0.24005555 ;
	setAttr ".pt[1685]" -type "float3" 1.4790567 2.8016832 -0.12160651 ;
	setAttr ".pt[1686]" -type "float3" 1.5034872 2.9258425 -0.10762946 ;
	setAttr ".pt[1687]" -type "float3" 1.3325312 2.9649303 -0.14923525 ;
	setAttr ".pt[1688]" -type "float3" 1.0464264 2.746166 -0.19065867 ;
	setAttr ".pt[1689]" -type "float3" 0.69110805 2.0646358 -0.15057035 ;
	setAttr ".pt[1690]" -type "float3" 0.34553573 1.1879681 -0.076161884 ;
	setAttr ".pt[1691]" -type "float3" 0.14734174 0.56345868 -0.019413261 ;
	setAttr ".pt[1692]" -type "float3" 0.024058595 0.041709818 0.012708204 ;
	setAttr ".pt[1693]" -type "float3" -0.0021189731 0.014573128 -0.0007448364 ;
	setAttr ".pt[1698]" -type "float3" -0.0020085899 -0.0013875484 0.00072531193 ;
	setAttr ".pt[1699]" -type "float3" -0.012912664 -0.02582146 0.010881703 ;
	setAttr ".pt[1700]" -type "float3" 0.0027784174 0.034328241 0.021069944 ;
	setAttr ".pt[1701]" -type "float3" 0.018101132 0.08267168 0.0217868 ;
	setAttr ".pt[1702]" -type "float3" 0.030660998 0.055030957 0.024773093 ;
	setAttr ".pt[1703]" -type "float3" 0.030417802 -0.029216621 0.0089822039 ;
	setAttr ".pt[1704]" -type "float3" 0.006386226 -0.021111785 -0.00089770783 ;
	setAttr ".pt[1706]" -type "float3" -0.0013529588 -0.001253518 0.00097639603 ;
	setAttr ".pt[1707]" -type "float3" -0.022444731 -0.017960275 0.016609581 ;
	setAttr ".pt[1708]" -type "float3" -0.027952371 -0.04267979 0.021003775 ;
	setAttr ".pt[1709]" -type "float3" -0.015929839 -0.063587822 0.015486804 ;
	setAttr ".pt[1710]" -type "float3" -0.00032411818 -0.075147577 0.019166971 ;
	setAttr ".pt[1711]" -type "float3" 0.020530716 -0.15202925 0.049329251 ;
	setAttr ".pt[1712]" -type "float3" 0.035663001 -0.1312986 0.075601503 ;
	setAttr ".pt[1713]" -type "float3" 0.039217155 -0.1059102 0.066309795 ;
	setAttr ".pt[1714]" -type "float3" 0.020757642 -0.10232176 0.021930244 ;
	setAttr ".pt[1715]" -type "float3" 0.0080299918 -0.010843998 0.0093832985 ;
	setAttr ".pt[1717]" -type "float3" -0.00057878392 0.0098634781 0.0008833913 ;
	setAttr ".pt[1718]" -type "float3" -0.0093511911 0.070030749 0.0053878441 ;
	setAttr ".pt[1719]" -type "float3" -0.00026818443 0.0015593549 0.00023229077 ;
	setAttr ".pt[1721]" -type "float3" 0.0010174987 0.0016805078 0.00081614265 ;
	setAttr ".pt[1722]" -type "float3" 0.046772681 -0.15015575 -0.0080986768 ;
	setAttr ".pt[1723]" -type "float3" 0.062102899 -0.26396298 -0.011496479 ;
	setAttr ".pt[1724]" -type "float3" 0.043956503 -0.1695246 0.018146574 ;
	setAttr ".pt[1725]" -type "float3" 0.0019469816 -0.11853945 0.039431818 ;
	setAttr ".pt[1726]" -type "float3" -0.069197401 -0.25521192 0.03385365 ;
	setAttr ".pt[1727]" -type "float3" -0.10422251 -0.27785903 0.02309929 ;
	setAttr ".pt[1728]" -type "float3" -0.091739796 -0.14010519 0.023331009 ;
	setAttr ".pt[1729]" -type "float3" -0.074845545 0.0027217418 0.018864349 ;
	setAttr ".pt[1730]" -type "float3" -0.065085024 -0.0039418638 0.0057227127 ;
	setAttr ".pt[1734]" -type "float3" 0.42030573 1.9382055 -0.048698187 ;
	setAttr ".pt[1735]" -type "float3" 0.66561925 2.443392 0.025100723 ;
	setAttr ".pt[1736]" -type "float3" 1.22412 2.6625707 0.11171048 ;
	setAttr ".pt[1737]" -type "float3" 1.3586648 2.769834 0.10131384 ;
	setAttr ".pt[1738]" -type "float3" 1.2401459 2.8176033 0.045562625 ;
	setAttr ".pt[1739]" -type "float3" 0.93268967 2.6245666 0.014951938 ;
	setAttr ".pt[1740]" -type "float3" 0.64791662 1.9750794 0.044097416 ;
	setAttr ".pt[1741]" -type "float3" 0.37244606 1.3665075 0.020908462 ;
	setAttr ".pt[1742]" -type "float3" 0.17771427 0.9315905 0.010556726 ;
	setAttr ".pt[1743]" -type "float3" 0.033693861 0.47367111 0.0012337663 ;
	setAttr ".pt[1744]" -type "float3" -0.0069833761 0.079649225 -0.0095868632 ;
	setAttr ".pt[1749]" -type "float3" -0.053217765 0.096006833 0.027912274 ;
	setAttr ".pt[1750]" -type "float3" -0.031040287 0.069613971 0.044657759 ;
	setAttr ".pt[1751]" -type "float3" 0.0079217386 0.12705176 0.055060383 ;
	setAttr ".pt[1752]" -type "float3" 0.02383139 0.12955971 0.038055543 ;
	setAttr ".pt[1753]" -type "float3" 0.032124102 0.08783029 0.020559156 ;
	setAttr ".pt[1754]" -type "float3" 0.054335743 0.05697488 0.018941514 ;
	setAttr ".pt[1755]" -type "float3" 0.047249161 0.092889622 0.022057666 ;
	setAttr ".pt[1758]" -type "float3" -0.016051902 -0.020920265 0.0059993737 ;
	setAttr ".pt[1759]" -type "float3" -0.022906372 -0.056890823 0.0051961262 ;
	setAttr ".pt[1760]" -type "float3" -0.0090518519 -0.10546609 -0.00093873905 ;
	setAttr ".pt[1761]" -type "float3" 0.00081431901 -0.056524724 0.0017721448 ;
	setAttr ".pt[1762]" -type "float3" 0.014752915 -0.24397641 0.036824334 ;
	setAttr ".pt[1763]" -type "float3" 0.023653505 -0.30060476 0.073726483 ;
	setAttr ".pt[1764]" -type "float3" 0.028907899 -0.26837969 0.09142904 ;
	setAttr ".pt[1765]" -type "float3" 0.031888228 -0.2662273 0.056178007 ;
	setAttr ".pt[1766]" -type "float3" 0.025511304 -0.093501821 0.029368011 ;
	setAttr ".pt[1773]" -type "float3" 0.042277437 -0.1514443 0.019059705 ;
	setAttr ".pt[1774]" -type "float3" 0.078845307 -0.30118531 0.01358951 ;
	setAttr ".pt[1775]" -type "float3" 0.06343852 -0.072811976 0.055647504 ;
	setAttr ".pt[1776]" -type "float3" 0.020117071 0.031710595 0.058125395 ;
	setAttr ".pt[1777]" -type "float3" -0.065187596 -0.24068213 0.051939838 ;
	setAttr ".pt[1778]" -type "float3" -0.099785529 -0.36475617 0.038411893 ;
	setAttr ".pt[1779]" -type "float3" -0.08463534 -0.24534321 0.037216578 ;
	setAttr ".pt[1780]" -type "float3" -0.078292161 -0.16208576 0.024129983 ;
	setAttr ".pt[1781]" -type "float3" -0.035497203 -0.051256262 0.0041959994 ;
	setAttr ".pt[1785]" -type "float3" -0.012479872 1.7086765 0.18211886 ;
	setAttr ".pt[1786]" -type "float3" 0.27393061 2.3072896 0.27875525 ;
	setAttr ".pt[1787]" -type "float3" 0.84339041 2.3704035 0.28370479 ;
	setAttr ".pt[1788]" -type "float3" 1.0884987 2.4114501 0.25158849 ;
	setAttr ".pt[1789]" -type "float3" 1.0585411 2.4502459 0.20150597 ;
	setAttr ".pt[1790]" -type "float3" 0.81056207 2.3346291 0.18967368 ;
	setAttr ".pt[1791]" -type "float3" 0.60040724 1.7245359 0.24748395 ;
	setAttr ".pt[1792]" -type "float3" 0.37850726 1.2061971 0.16951324 ;
	setAttr ".pt[1793]" -type "float3" 0.19352075 0.79853117 0.12648925 ;
	setAttr ".pt[1794]" -type "float3" 0.044569466 0.38706076 0.097785935 ;
	setAttr ".pt[1795]" -type "float3" -0.015665282 -0.048242215 0.034796976 ;
	setAttr ".pt[1799]" -type "float3" -0.035130162 0.043502733 0.01973124 ;
	setAttr ".pt[1800]" -type "float3" -0.079038359 -0.14679979 0.040169936 ;
	setAttr ".pt[1801]" -type "float3" -0.023848068 -0.1930764 0.067785174 ;
	setAttr ".pt[1802]" -type "float3" 0.0203171 -0.099491514 0.080280825 ;
	setAttr ".pt[1803]" -type "float3" 0.023723753 -0.0474419 0.057679296 ;
	setAttr ".pt[1804]" -type "float3" 0.030132936 0.018160954 0.04275655 ;
	setAttr ".pt[1805]" -type "float3" 0.098581411 0.031102536 0.066849567 ;
	setAttr ".pt[1806]" -type "float3" 0.11267643 0.17635262 0.081110656 ;
	setAttr ".pt[1807]" -type "float3" 0.0090526771 0.092827767 0.022291891 ;
	setAttr ".pt[1809]" -type "float3" -0.016430045 0.11913916 0.028143521 ;
	setAttr ".pt[1810]" -type "float3" -0.03895539 0.08798404 0.019550204 ;
	setAttr ".pt[1811]" -type "float3" -0.045461223 -0.1104413 0.010239973 ;
	setAttr ".pt[1812]" -type "float3" -0.012955034 -0.25315899 0.014822588 ;
	setAttr ".pt[1813]" -type "float3" 0.0094631761 -0.29892576 0.024544612 ;
	setAttr ".pt[1814]" -type "float3" 0.0093679484 -0.34484577 0.031987876 ;
	setAttr ".pt[1815]" -type "float3" 0.0075475657 -0.36780351 0.031381343 ;
	setAttr ".pt[1816]" -type "float3" 0.02689554 -0.37534156 0.017583724 ;
	setAttr ".pt[1817]" -type "float3" 0.054688655 -0.14734471 0.0068483818 ;
	setAttr ".pt[1818]" -type "float3" 0.034153905 0.10330617 0.0097192591 ;
	setAttr ".pt[1824]" -type "float3" 0.025533095 -0.14277074 -0.015620974 ;
	setAttr ".pt[1825]" -type "float3" 0.084372632 -0.19621043 -0.0089986157 ;
	setAttr ".pt[1826]" -type "float3" 0.089907102 0.12582406 0.042002123 ;
	setAttr ".pt[1827]" -type "float3" 0.019422563 0.22696319 0.049335446 ;
	setAttr ".pt[1828]" -type "float3" -0.081637368 -0.17341021 0.025410617 ;
	setAttr ".pt[1829]" -type "float3" -0.11355285 -0.42166719 0.0086848279 ;
	setAttr ".pt[1830]" -type "float3" -0.10466261 -0.35351381 0.013625775 ;
	setAttr ".pt[1831]" -type "float3" -0.089610085 -0.19825588 0.02237929 ;
	setAttr ".pt[1832]" -type "float3" -0.046242967 -0.042274795 0.016725011 ;
	setAttr ".pt[1836]" -type "float3" 0.14971885 2.2723291 0.54631245 ;
	setAttr ".pt[1837]" -type "float3" 0.24752718 2.5625765 0.5540759 ;
	setAttr ".pt[1838]" -type "float3" 0.535842 2.4850578 0.37496704 ;
	setAttr ".pt[1839]" -type "float3" 0.8378424 2.4138002 0.25986168 ;
	setAttr ".pt[1840]" -type "float3" 0.85420358 2.3831103 0.19767803 ;
	setAttr ".pt[1841]" -type "float3" 0.65065163 2.1607759 0.18205169 ;
	setAttr ".pt[1842]" -type "float3" 0.4836334 1.4791203 0.19865583 ;
	setAttr ".pt[1843]" -type "float3" 0.33390987 0.97944331 0.13760068 ;
	setAttr ".pt[1844]" -type "float3" 0.1865913 0.55917543 0.09548451 ;
	setAttr ".pt[1845]" -type "float3" 0.055316754 0.12710579 0.060518537 ;
	setAttr ".pt[1846]" -type "float3" -0.016444106 -0.20729724 0.022593606 ;
	setAttr ".pt[1850]" -type "float3" -0.013366135 -0.041916221 0.010220554 ;
	setAttr ".pt[1851]" -type "float3" -0.036048129 -0.38130337 0.0061911945 ;
	setAttr ".pt[1852]" -type "float3" 0.012025837 -0.55735928 0.0019205948 ;
	setAttr ".pt[1853]" -type "float3" 0.028636687 -0.53541988 -0.023468342 ;
	setAttr ".pt[1854]" -type "float3" 0.01305382 -0.43211907 -0.041899554 ;
	setAttr ".pt[1855]" -type "float3" 0.0024179195 -0.31587121 -0.034931373 ;
	setAttr ".pt[1856]" -type "float3" 0.048903927 -0.34539956 -0.020956187 ;
	setAttr ".pt[1857]" -type "float3" 0.086510822 -0.13952771 0.018531216 ;
	setAttr ".pt[1858]" -type "float3" 0.02468894 0.027321128 0.027123764 ;
	setAttr ".pt[1860]" -type "float3" 0.005834756 -0.017945662 0.015128095 ;
	setAttr ".pt[1861]" -type "float3" -0.0040404713 0.053027991 -0.0028827672 ;
	setAttr ".pt[1862]" -type "float3" -0.035702508 -0.020400969 -0.026002748 ;
	setAttr ".pt[1863]" -type "float3" -0.033716716 -0.22342029 -0.050207693 ;
	setAttr ".pt[1864]" -type "float3" 0.011523755 -0.19267856 -0.049230319 ;
	setAttr ".pt[1865]" -type "float3" 0.010549233 -0.10994993 -0.048797522 ;
	setAttr ".pt[1866]" -type "float3" 0.0039734715 -0.16053541 -0.052959688 ;
	setAttr ".pt[1867]" -type "float3" 0.02351257 -0.21933369 -0.056692 ;
	setAttr ".pt[1868]" -type "float3" 0.091253318 -0.11561756 -0.044319704 ;
	setAttr ".pt[1869]" -type "float3" 0.057138797 0.25920647 -0.0017196499 ;
	setAttr ".pt[1870]" -type "float3" -0.030262671 0.13414425 0.0013254459 ;
	setAttr ".pt[1871]" -type "float3" -0.015961044 -0.010988691 -0.01156798 ;
	setAttr ".pt[1872]" -type "float3" 0.0032440822 -0.024851654 -0.027497875 ;
	setAttr ".pt[1875]" -type "float3" 0.00063792814 -0.0058156704 -0.0015706625 ;
	setAttr ".pt[1876]" -type "float3" 0.081731535 -0.13308148 -0.017524457 ;
	setAttr ".pt[1877]" -type "float3" 0.1051589 0.17422035 0.032212172 ;
	setAttr ".pt[1878]" -type "float3" 0.021461695 0.35910335 0.041387476 ;
	setAttr ".pt[1879]" -type "float3" -0.1110679 0.039462425 -0.018872352 ;
	setAttr ".pt[1880]" -type "float3" -0.13947695 -0.23695949 -0.055325884 ;
	setAttr ".pt[1881]" -type "float3" -0.11092608 -0.15999134 -0.045691397 ;
	setAttr ".pt[1882]" -type "float3" -0.08811304 0.025186837 -0.024401698 ;
	setAttr ".pt[1883]" -type "float3" -0.051110826 0.065293193 -0.010989314 ;
	setAttr ".pt[1887]" -type "float3" 0.54867285 2.4140644 0.61828214 ;
	setAttr ".pt[1888]" -type "float3" 0.40454084 2.5429046 0.59385037 ;
	setAttr ".pt[1889]" -type "float3" 0.38437265 2.452527 0.39435253 ;
	setAttr ".pt[1890]" -type "float3" 0.68634754 2.4329464 0.25369629 ;
	setAttr ".pt[1891]" -type "float3" 0.67480344 2.4228694 0.18652013 ;
	setAttr ".pt[1892]" -type "float3" 0.49018067 2.1498709 0.1456154 ;
	setAttr ".pt[1893]" -type "float3" 0.34743616 1.4719043 0.10811698 ;
	setAttr ".pt[1894]" -type "float3" 0.26323915 1.0550276 0.067274027 ;
	setAttr ".pt[1895]" -type "float3" 0.15255468 0.63820189 0.033689383 ;
	setAttr ".pt[1896]" -type "float3" 0.044980131 0.19235025 -0.00070927775 ;
	setAttr ".pt[1897]" -type "float3" -0.018087195 -0.15997747 -0.02965763 ;
	setAttr ".pt[1901]" -type "float3" -0.0018833386 0.0032097406 -0.0011041679 ;
	setAttr ".pt[1902]" -type "float3" -0.025932716 -0.2464543 -0.041660957 ;
	setAttr ".pt[1903]" -type "float3" 0.033939008 -0.38409686 -0.076047517 ;
	setAttr ".pt[1904]" -type "float3" 0.046262547 -0.42584476 -0.11502209 ;
	setAttr ".pt[1905]" -type "float3" 0.024547648 -0.34671888 -0.13241008 ;
	setAttr ".pt[1906]" -type "float3" 0.0049691787 -0.29075336 -0.12327827 ;
	setAttr ".pt[1907]" -type "float3" 0.039487813 -0.31934851 -0.11489605 ;
	setAttr ".pt[1908]" -type "float3" 0.090596721 -0.10901484 -0.062703043 ;
	setAttr ".pt[1909]" -type "float3" 0.046538681 0.13138004 -0.012653453 ;
	setAttr ".pt[1912]" -type "float3" 0.012141497 0.031734932 -0.012191972 ;
	setAttr ".pt[1913]" -type "float3" -0.0043605482 0.0055481018 -0.0054479875 ;
	setAttr ".pt[1914]" -type "float3" -0.036779366 -0.19856876 -0.044245392 ;
	setAttr ".pt[1915]" -type "float3" 0.012419193 -0.16728546 -0.047095634 ;
	setAttr ".pt[1916]" -type "float3" 0.016874591 -0.07820227 -0.049040563 ;
	setAttr ".pt[1917]" -type "float3" 0.0057073366 -0.07175523 -0.055926185 ;
	setAttr ".pt[1918]" -type "float3" 0.016420517 -0.10909364 -0.056837071 ;
	setAttr ".pt[1919]" -type "float3" 0.092660196 -0.076987289 -0.036499336 ;
	setAttr ".pt[1920]" -type "float3" 0.060197208 0.34137362 0.033518169 ;
	setAttr ".pt[1921]" -type "float3" -0.077712752 0.3128078 0.030699855 ;
	setAttr ".pt[1922]" -type "float3" -0.059992757 -0.080507897 -0.033093583 ;
	setAttr ".pt[1923]" -type "float3" 0.0099193584 -0.083714984 -0.036891725 ;
	setAttr ".pt[1924]" -type "float3" 0.023616603 -0.045732502 -0.022626163 ;
	setAttr ".pt[1926]" -type "float3" 0.004695721 -0.010996262 -0.0037502898 ;
	setAttr ".pt[1927]" -type "float3" 0.078655116 -0.099724591 -0.01103347 ;
	setAttr ".pt[1928]" -type "float3" 0.10867769 0.10751957 0.026018258 ;
	setAttr ".pt[1929]" -type "float3" 0.035827778 0.3517614 0.040914305 ;
	setAttr ".pt[1930]" -type "float3" -0.11574992 0.064436071 -0.033280093 ;
	setAttr ".pt[1931]" -type "float3" -0.16746099 -0.2433397 -0.085179396 ;
	setAttr ".pt[1932]" -type "float3" -0.1395651 -0.16413434 -0.073862232 ;
	setAttr ".pt[1933]" -type "float3" -0.1131283 0.028953027 -0.038164772 ;
	setAttr ".pt[1934]" -type "float3" -0.067339905 0.08081948 -0.006174216 ;
	setAttr ".pt[1938]" -type "float3" 0.54290569 1.3458492 0.45555684 ;
	setAttr ".pt[1939]" -type "float3" 0.44339576 1.5823717 0.41822478 ;
	setAttr ".pt[1940]" -type "float3" 0.34041318 2.0669532 0.30643368 ;
	setAttr ".pt[1941]" -type "float3" 0.56229544 2.3456168 0.19227248 ;
	setAttr ".pt[1942]" -type "float3" 0.52716208 2.4268222 0.18707062 ;
	setAttr ".pt[1943]" -type "float3" 0.36175629 2.1496534 0.14857198 ;
	setAttr ".pt[1944]" -type "float3" 0.26028088 1.4997979 0.090166561 ;
	setAttr ".pt[1945]" -type "float3" 0.20124127 1.1628503 0.080654539 ;
	setAttr ".pt[1946]" -type "float3" 0.12014329 0.78589576 0.061895024 ;
	setAttr ".pt[1947]" -type "float3" 0.033821456 0.32657292 0.029439583 ;
	setAttr ".pt[1948]" -type "float3" -0.018467046 -0.082321018 -0.0050446829 ;
	setAttr ".pt[1953]" -type "float3" -0.0053148386 -0.025089707 -0.0015435971 ;
	setAttr ".pt[1954]" -type "float3" 0.031659339 -0.19057332 -0.030409906 ;
	setAttr ".pt[1955]" -type "float3" 0.053382188 -0.24986841 -0.078465171 ;
	setAttr ".pt[1956]" -type "float3" 0.02879394 -0.21674563 -0.098164581 ;
	setAttr ".pt[1957]" -type "float3" 0.0052870074 -0.23988618 -0.1087932 ;
	setAttr ".pt[1958]" -type "float3" 0.03583299 -0.27175304 -0.11194294 ;
	setAttr ".pt[1959]" -type "float3" 0.093310736 -0.058930222 -0.060138892 ;
	setAttr ".pt[1960]" -type "float3" 0.061162628 0.23483258 0.0036841724 ;
	setAttr ".pt[1961]" -type "float3" -0.0023453406 0.073804751 0.00049134408 ;
	setAttr ".pt[1965]" -type "float3" -0.036524884 -0.14387181 -0.023187274 ;
	setAttr ".pt[1966]" -type "float3" 0.014194782 -0.10293268 -0.029314669 ;
	setAttr ".pt[1967]" -type "float3" 0.020017222 -0.009969946 -0.034720302 ;
	setAttr ".pt[1968]" -type "float3" 0.0073222779 0.0083180256 -0.044616114 ;
	setAttr ".pt[1969]" -type "float3" 0.01158289 -0.033327539 -0.047852591 ;
	setAttr ".pt[1970]" -type "float3" 0.068977743 -0.039416552 -0.023691466 ;
	setAttr ".pt[1971]" -type "float3" 0.060500342 0.26654211 0.034181066 ;
	setAttr ".pt[1972]" -type "float3" -0.082956433 0.29391909 0.0296745 ;
	setAttr ".pt[1973]" -type "float3" -0.071073979 -0.13998504 -0.049721602 ;
	setAttr ".pt[1974]" -type "float3" 0.016974008 -0.16664842 -0.05501692 ;
	setAttr ".pt[1975]" -type "float3" 0.033203583 -0.068433523 -0.036083519 ;
	setAttr ".pt[1976]" -type "float3" 0.028463753 -0.038042229 -0.031919021 ;
	setAttr ".pt[1977]" -type "float3" 0.030517057 -0.070033118 -0.030263614 ;
	setAttr ".pt[1978]" -type "float3" 0.08210776 -0.12048952 -0.024435468 ;
	setAttr ".pt[1979]" -type "float3" 0.11986965 0.073524676 0.010250499 ;
	setAttr ".pt[1980]" -type "float3" 0.053237084 0.3273299 0.034247134 ;
	setAttr ".pt[1981]" -type "float3" -0.1156876 0.094922736 -0.032834381 ;
	setAttr ".pt[1982]" -type "float3" -0.19729868 -0.2646884 -0.096781731 ;
	setAttr ".pt[1983]" -type "float3" -0.17400233 -0.17640312 -0.089375243 ;
	setAttr ".pt[1984]" -type "float3" -0.1620788 0.046000555 -0.055571746 ;
	setAttr ".pt[1985]" -type "float3" -0.10788278 0.15825263 -0.013076088 ;
	setAttr ".pt[1989]" -type "float3" 0.74839568 0.75009596 0.47082105 ;
	setAttr ".pt[1990]" -type "float3" 0.54175192 1.0808008 0.40149167 ;
	setAttr ".pt[1991]" -type "float3" 0.28064421 1.7570239 0.30472562 ;
	setAttr ".pt[1992]" -type "float3" 0.44789183 2.3480086 0.24871255 ;
	setAttr ".pt[1993]" -type "float3" 0.40679359 2.3123057 0.21051992 ;
	setAttr ".pt[1994]" -type "float3" 0.25775054 2.0510731 0.16815799 ;
	setAttr ".pt[1995]" -type "float3" 0.18568906 1.4977654 0.12037901 ;
	setAttr ".pt[1996]" -type "float3" 0.15413584 1.2540866 0.12197813 ;
	setAttr ".pt[1997]" -type "float3" 0.090821549 0.94108939 0.11164825 ;
	setAttr ".pt[1998]" -type "float3" 0.025485905 0.4863109 0.073330835 ;
	setAttr ".pt[1999]" -type "float3" -0.010776544 0.058283977 0.022763327 ;
	setAttr ".pt[2003]" -type "float3" -0.047292132 0.12734535 0.022993891 ;
	setAttr ".pt[2004]" -type "float3" -0.050692841 -0.11731647 0.03143882 ;
	setAttr ".pt[2005]" -type "float3" 0.027608149 -0.24830584 0.0051002107 ;
	setAttr ".pt[2006]" -type "float3" 0.058326174 -0.18604514 -0.028428322 ;
	setAttr ".pt[2007]" -type "float3" 0.034817606 -0.14939618 -0.056059241 ;
	setAttr ".pt[2008]" -type "float3" 0.0096544661 -0.24734232 -0.098253451 ;
	setAttr ".pt[2009]" -type "float3" 0.024757983 -0.2471807 -0.10054338 ;
	setAttr ".pt[2010]" -type "float3" 0.087390415 -0.021509806 -0.051518694 ;
	setAttr ".pt[2011]" -type "float3" 0.072389722 0.33838379 0.015782442 ;
	setAttr ".pt[2012]" -type "float3" 0.0062319622 0.22224905 0.011531796 ;
	setAttr ".pt[2017]" -type "float3" 0.022261836 0.017279075 -0.012178786 ;
	setAttr ".pt[2018]" -type "float3" 0.019874314 0.094517834 -0.021818101 ;
	setAttr ".pt[2019]" -type "float3" 0.0076750959 0.11110441 -0.035479553 ;
	setAttr ".pt[2020]" -type "float3" 0.0095452107 0.066487603 -0.043591514 ;
	setAttr ".pt[2021]" -type "float3" 0.060151316 0.034704223 -0.027881823 ;
	setAttr ".pt[2022]" -type "float3" 0.065806836 0.22383702 0.016861426 ;
	setAttr ".pt[2023]" -type "float3" -0.064720288 0.31800032 0.023039132 ;
	setAttr ".pt[2024]" -type "float3" -0.088543624 -0.0039601922 -0.04681915 ;
	setAttr ".pt[2025]" -type "float3" -0.0020265488 -0.081330545 -0.060578424 ;
	setAttr ".pt[2026]" -type "float3" 0.034826558 -0.031348735 -0.058069188 ;
	setAttr ".pt[2027]" -type "float3" 0.039065152 7.8792684e-005 -0.049293086 ;
	setAttr ".pt[2028]" -type "float3" 0.041972466 -0.037023582 -0.046083529 ;
	setAttr ".pt[2029]" -type "float3" 0.079294346 -0.086011752 -0.040015597 ;
	setAttr ".pt[2030]" -type "float3" 0.10924775 0.050352395 -0.01471745 ;
	setAttr ".pt[2031]" -type "float3" 0.038863782 0.28853375 0.009356604 ;
	setAttr ".pt[2032]" -type "float3" -0.11069626 0.11668257 -0.027895123 ;
	setAttr ".pt[2033]" -type "float3" -0.21318159 -0.29552194 -0.09442424 ;
	setAttr ".pt[2034]" -type "float3" -0.19169682 -0.17369068 -0.09268862 ;
	setAttr ".pt[2035]" -type "float3" -0.18322583 0.073303387 -0.068171188 ;
	setAttr ".pt[2036]" -type "float3" -0.11306899 0.22280985 -0.023942757 ;
	setAttr ".pt[2040]" -type "float3" 1.0078869 0.47093722 0.24807176 ;
	setAttr ".pt[2041]" -type "float3" 0.60665184 0.99312556 0.23819134 ;
	setAttr ".pt[2042]" -type "float3" 0.21149513 1.563547 0.21097966 ;
	setAttr ".pt[2043]" -type "float3" 0.36703801 1.648605 0.18537864 ;
	setAttr ".pt[2044]" -type "float3" 0.30698043 1.6742517 0.15748911 ;
	setAttr ".pt[2045]" -type "float3" 0.19338143 1.5695344 0.13816744 ;
	setAttr ".pt[2046]" -type "float3" 0.12740603 1.164909 0.11994084 ;
	setAttr ".pt[2047]" -type "float3" 0.10701797 1.063303 0.12026285 ;
	setAttr ".pt[2048]" -type "float3" 0.060101788 0.88655722 0.1249568 ;
	setAttr ".pt[2049]" -type "float3" 0.013841549 0.53102112 0.094696917 ;
	setAttr ".pt[2050]" -type "float3" -0.0055422504 0.14812015 0.035411134 ;
	setAttr ".pt[2052]" -type "float3" 0.0020797942 0.049595822 0.0021671194 ;
	setAttr ".pt[2053]" -type "float3" -0.032112937 0.197735 0.035058074 ;
	setAttr ".pt[2054]" -type "float3" -0.079394177 0.2345922 0.080692351 ;
	setAttr ".pt[2055]" -type "float3" -0.047708038 -0.14018573 0.091767691 ;
	setAttr ".pt[2056]" -type "float3" 0.049996067 -0.33961675 0.053973399 ;
	setAttr ".pt[2057]" -type "float3" 0.08091069 -0.2504929 -0.0052274396 ;
	setAttr ".pt[2058]" -type "float3" 0.052308105 -0.27628312 -0.058299657 ;
	setAttr ".pt[2059]" -type "float3" 0.0086328369 -0.35534307 -0.097785808 ;
	setAttr ".pt[2060]" -type "float3" 0.0059125978 -0.30385911 -0.096197471 ;
	setAttr ".pt[2061]" -type "float3" 0.063069426 -0.0071946373 -0.045600303 ;
	setAttr ".pt[2062]" -type "float3" 0.065168589 0.3940503 0.01449424 ;
	setAttr ".pt[2063]" -type "float3" 0.007060084 0.32030153 0.013578217 ;
	setAttr ".pt[2064]" -type "float3" 0.0062870616 0.18429454 0.0080069704 ;
	setAttr ".pt[2065]" -type "float3" 0.013774533 0.18971637 0.0083151609 ;
	setAttr ".pt[2066]" -type "float3" -0.028187906 0.20939068 0.006765082 ;
	setAttr ".pt[2067]" -type "float3" -0.051651798 0.049826398 -0.008694673 ;
	setAttr ".pt[2068]" -type "float3" 0.0027293367 0.063287504 -0.017565299 ;
	setAttr ".pt[2069]" -type "float3" 0.018926537 0.16203849 -0.0202244 ;
	setAttr ".pt[2070]" -type "float3" 0.010776522 0.1744334 -0.037133321 ;
	setAttr ".pt[2071]" -type "float3" 0.012683243 0.11767734 -0.053095039 ;
	setAttr ".pt[2072]" -type "float3" 0.052032448 0.05276024 -0.054554034 ;
	setAttr ".pt[2073]" -type "float3" 0.079749778 0.20996939 -0.03041113 ;
	setAttr ".pt[2074]" -type "float3" -0.040229823 0.49266449 -0.0084132301 ;
	setAttr ".pt[2075]" -type "float3" -0.089425638 0.081422359 -0.077175856 ;
	setAttr ".pt[2076]" -type "float3" -0.011510866 -0.10646035 -0.096897654 ;
	setAttr ".pt[2077]" -type "float3" 0.033834949 -0.083502278 -0.08598493 ;
	setAttr ".pt[2078]" -type "float3" 0.04363282 -0.048116587 -0.067820825 ;
	setAttr ".pt[2079]" -type "float3" 0.044248927 -0.064354613 -0.05743606 ;
	setAttr ".pt[2080]" -type "float3" 0.069106199 -0.13303469 -0.054148749 ;
	setAttr ".pt[2081]" -type "float3" 0.088034555 -0.10672582 -0.043668136 ;
	setAttr ".pt[2082]" -type "float3" 0.026595261 0.041104529 -0.022537215 ;
	setAttr ".pt[2083]" -type "float3" -0.092320696 -0.1093254 -0.032855742 ;
	setAttr ".pt[2084]" -type "float3" -0.23540504 -0.63633204 -0.0977863 ;
	setAttr ".pt[2085]" -type "float3" -0.23778486 -0.3945553 -0.10377862 ;
	setAttr ".pt[2086]" -type "float3" -0.24246129 -0.094672449 -0.089849249 ;
	setAttr ".pt[2087]" -type "float3" -0.12007754 0.16694893 -0.034316842 ;
	setAttr ".pt[2091]" -type "float3" 1.2146698 0.70992297 -0.053213142 ;
	setAttr ".pt[2092]" -type "float3" 0.5547542 0.89981127 -0.030100388 ;
	setAttr ".pt[2093]" -type "float3" 0.17740588 1.4878534 0.019227188 ;
	setAttr ".pt[2094]" -type "float3" 0.23560967 1.4041311 0.082812488 ;
	setAttr ".pt[2095]" -type "float3" 0.21555725 1.2933459 0.10598935 ;
	setAttr ".pt[2096]" -type "float3" 0.16065674 0.9714123 0.086936139 ;
	setAttr ".pt[2097]" -type "float3" 0.092649549 0.49963525 0.050162796 ;
	setAttr ".pt[2098]" -type "float3" 0.059542276 0.42013764 0.041215267 ;
	setAttr ".pt[2099]" -type "float3" 0.027532311 0.35720602 0.057972506 ;
	setAttr ".pt[2100]" -type "float3" 0.0003500137 0.15114793 0.053446747 ;
	setAttr ".pt[2101]" -type "float3" -0.00014791818 -0.030493118 0.011623423 ;
	setAttr ".pt[2103]" -type "float3" -0.0055317106 0.24597029 0.043552283 ;
	setAttr ".pt[2104]" -type "float3" -0.013981353 0.11206403 0.076822348 ;
	setAttr ".pt[2105]" -type "float3" -0.016959328 0.04022561 0.13624945 ;
	setAttr ".pt[2106]" -type "float3" 0.058027215 -0.43847236 0.15867586 ;
	setAttr ".pt[2107]" -type "float3" 0.1494714 -0.7408402 0.11003499 ;
	setAttr ".pt[2108]" -type "float3" 0.13628183 -0.62838626 0.00027373107 ;
	setAttr ".pt[2109]" -type "float3" 0.081392772 -0.73168427 -0.069423229 ;
	setAttr ".pt[2110]" -type "float3" -0.0046280585 -0.75485229 -0.10721936 ;
	setAttr ".pt[2111]" -type "float3" -0.056050368 -0.68128568 -0.10570968 ;
	setAttr ".pt[2112]" -type "float3" -0.034039997 -0.27932778 -0.052386746 ;
	setAttr ".pt[2113]" -type "float3" -0.0067709233 0.16821066 -0.0071573104 ;
	setAttr ".pt[2114]" -type "float3" -0.020907171 0.13916498 0.00018526963 ;
	setAttr ".pt[2115]" -type "float3" -0.0084246099 0.11432456 0.003243126 ;
	setAttr ".pt[2116]" -type "float3" 0.0045451373 0.14927602 0.0053515974 ;
	setAttr ".pt[2117]" -type "float3" -0.022905126 0.26873934 0.0050662593 ;
	setAttr ".pt[2118]" -type "float3" -0.035310552 -0.090476453 -0.022830386 ;
	setAttr ".pt[2119]" -type "float3" 0.01052841 -0.19031376 -0.038761951 ;
	setAttr ".pt[2120]" -type "float3" 0.027946815 -0.14474815 -0.050826583 ;
	setAttr ".pt[2121]" -type "float3" 0.02921694 -0.12685412 -0.070521712 ;
	setAttr ".pt[2122]" -type "float3" 0.031597834 -0.15121832 -0.090017952 ;
	setAttr ".pt[2123]" -type "float3" 0.052538279 -0.2727623 -0.10852872 ;
	setAttr ".pt[2124]" -type "float3" 0.069124259 -0.17761305 -0.10911428 ;
	setAttr ".pt[2125]" -type "float3" -0.0082257055 0.24415922 -0.084565073 ;
	setAttr ".pt[2126]" -type "float3" -0.025089104 -0.22547954 -0.13435696 ;
	setAttr ".pt[2127]" -type "float3" 0.035374187 -0.62312627 -0.1481721 ;
	setAttr ".pt[2128]" -type "float3" 0.05271193 -0.6011225 -0.11988407 ;
	setAttr ".pt[2129]" -type "float3" 0.053686071 -0.48821601 -0.075057507 ;
	setAttr ".pt[2130]" -type "float3" 0.044605888 -0.42363229 -0.042028841 ;
	setAttr ".pt[2131]" -type "float3" 0.039711054 -0.45643851 -0.026811536 ;
	setAttr ".pt[2132]" -type "float3" 0.052025359 -0.54359281 -0.035323419 ;
	setAttr ".pt[2133]" -type "float3" 0.015211002 -0.430785 -0.034695584 ;
	setAttr ".pt[2134]" -type "float3" -0.040546123 -0.58555633 -0.026429404 ;
	setAttr ".pt[2135]" -type "float3" -0.26776713 -1.2449429 -0.040479913 ;
	setAttr ".pt[2136]" -type "float3" -0.33845985 -0.76631379 -0.079317182 ;
	setAttr ".pt[2137]" -type "float3" -0.35489023 -0.5105707 -0.10323073 ;
	setAttr ".pt[2138]" -type "float3" -0.22440726 -0.22512703 -0.07908994 ;
	setAttr ".pt[2142]" -type "float3" 2.4704096 1.2692145 -0.11765619 ;
	setAttr ".pt[2143]" -type "float3" 1.0368 1.3584708 -0.12747097 ;
	setAttr ".pt[2144]" -type "float3" 0.10221615 1.5070566 -0.18116677 ;
	setAttr ".pt[2145]" -type "float3" 0.14215146 1.3473736 0.0032691576 ;
	setAttr ".pt[2146]" -type "float3" 0.13643938 1.2276258 0.079254851 ;
	setAttr ".pt[2147]" -type "float3" 0.096927889 0.94568998 0.095664099 ;
	setAttr ".pt[2148]" -type "float3" 0.044579029 0.42535838 0.059254296 ;
	setAttr ".pt[2149]" -type "float3" 0.015166901 0.37002262 0.042059198 ;
	setAttr ".pt[2150]" -type "float3" -0.0051513435 0.33310002 0.03415354 ;
	setAttr ".pt[2151]" -type "float3" -0.0042573572 0.068392225 0.0074217562 ;
	setAttr ".pt[2152]" -type "float3" 3.0385772e-005 -0.0017348053 -0.00045231302 ;
	setAttr ".pt[2154]" -type "float3" -0.017923644 0.24122083 0.025204431 ;
	setAttr ".pt[2155]" -type "float3" -0.016742541 0.078597605 0.048184875 ;
	setAttr ".pt[2156]" -type "float3" -0.013953409 0.10565943 0.085756928 ;
	setAttr ".pt[2157]" -type "float3" 0.073730186 -0.29454422 0.11214151 ;
	setAttr ".pt[2158]" -type "float3" 0.18877493 -0.57177895 0.07414861 ;
	setAttr ".pt[2159]" -type "float3" 0.17809263 -0.58046359 -0.0087240422 ;
	setAttr ".pt[2160]" -type "float3" 0.11682919 -0.83547139 -0.053202275 ;
	setAttr ".pt[2161]" -type "float3" -0.0045787063 -0.93444264 -0.072754227 ;
	setAttr ".pt[2162]" -type "float3" -0.092258655 -0.85667819 -0.065599144 ;
	setAttr ".pt[2163]" -type "float3" -0.098919772 -0.4322778 -0.032239288 ;
	setAttr ".pt[2164]" -type "float3" -0.06227215 0.028209461 -0.0054352744 ;
	setAttr ".pt[2165]" -type "float3" -0.043437809 -0.091369383 -0.004662721 ;
	setAttr ".pt[2166]" -type "float3" -0.030310169 -0.12113219 -0.0059765736 ;
	setAttr ".pt[2167]" -type "float3" -0.011328576 -0.062128805 -0.0079569286 ;
	setAttr ".pt[2168]" -type "float3" 0.0066344813 0.078985274 -0.006008375 ;
	setAttr ".pt[2169]" -type "float3" 0.013959996 -0.26016971 -0.032346025 ;
	setAttr ".pt[2170]" -type "float3" 0.02833079 -0.43893835 -0.063415155 ;
	setAttr ".pt[2171]" -type "float3" 0.03856051 -0.38815656 -0.077550054 ;
	setAttr ".pt[2172]" -type "float3" 0.047013808 -0.38317111 -0.092386805 ;
	setAttr ".pt[2173]" -type "float3" 0.062478196 -0.49013484 -0.12303305 ;
	setAttr ".pt[2174]" -type "float3" 0.066436462 -0.57757485 -0.14011025 ;
	setAttr ".pt[2175]" -type "float3" 0.0507489 -0.50465596 -0.14422338 ;
	setAttr ".pt[2176]" -type "float3" 0.00085276528 0.016775269 -0.11666892 ;
	setAttr ".pt[2177]" -type "float3" 0.015304748 -0.37421227 -0.12995283 ;
	setAttr ".pt[2178]" -type "float3" 0.018809719 -0.65390897 -0.11467714 ;
	setAttr ".pt[2179]" -type "float3" 0.016135873 -0.45159134 -0.07101357 ;
	setAttr ".pt[2180]" -type "float3" 0.0049989256 -0.058144074 -0.0040850104 ;
	setAttr ".pt[2181]" -type "float3" 0.025546286 -0.17327341 -0.00028125761 ;
	setAttr ".pt[2182]" -type "float3" 0.041428864 -0.24997456 0.023431594 ;
	setAttr ".pt[2183]" -type "float3" 0.054381374 -0.27220559 0.01817937 ;
	setAttr ".pt[2184]" -type "float3" 0.02515734 -0.35334992 0.010228532 ;
	setAttr ".pt[2185]" -type "float3" -0.030824514 -0.52200478 0.073127083 ;
	setAttr ".pt[2186]" -type "float3" -0.29311109 -1.1448214 0.23116025 ;
	setAttr ".pt[2187]" -type "float3" -0.28415072 -0.48642576 0.031167373 ;
	setAttr ".pt[2188]" -type "float3" -0.25564706 -0.34725785 -0.097340502 ;
	setAttr ".pt[2189]" -type "float3" -0.16716334 -0.158308 -0.1139733 ;
	setAttr ".pt[2190]" -type "float3" -0.0041174153 -0.00074963609 -0.0014970653 ;
	setAttr ".pt[2193]" -type "float3" 3.7099602 1.4244034 -0.08424668 ;
	setAttr ".pt[2194]" -type "float3" 1.7325749 1.4118521 -0.084567517 ;
	setAttr ".pt[2195]" -type "float3" 0.60937935 1.4025278 -0.071717672 ;
	setAttr ".pt[2196]" -type "float3" 0.08745262 1.3021582 0.012913322 ;
	setAttr ".pt[2197]" -type "float3" 0.070190169 1.191324 0.069720216 ;
	setAttr ".pt[2198]" -type "float3" 0.039648812 0.94186455 0.092974156 ;
	setAttr ".pt[2199]" -type "float3" 0.0067044245 0.36949962 0.065026909 ;
	setAttr ".pt[2200]" -type "float3" -0.013564907 0.34587479 0.045989625 ;
	setAttr ".pt[2201]" -type "float3" -0.021068804 0.35189682 0.031615742 ;
	setAttr ".pt[2204]" -type "float3" 0.00056815788 -0.0075712255 -0.00159487 ;
	setAttr ".pt[2205]" -type "float3" -0.015103916 0.21253093 -0.0051244139 ;
	setAttr ".pt[2206]" -type "float3" -0.03429386 0.11187552 -0.014275935 ;
	setAttr ".pt[2207]" -type "float3" -0.03428958 0.19987451 -0.0069365799 ;
	setAttr ".pt[2208]" -type "float3" 0.058102947 -0.12119625 -0.022191893 ;
	setAttr ".pt[2209]" -type "float3" 0.21290471 -0.37559572 -0.028544379 ;
	setAttr ".pt[2210]" -type "float3" 0.24559192 -0.50415194 -0.023284685 ;
	setAttr ".pt[2211]" -type "float3" 0.15056206 -0.70609283 -0.020478547 ;
	setAttr ".pt[2212]" -type "float3" 0.0079561658 -0.72152036 -0.010486824 ;
	setAttr ".pt[2213]" -type "float3" -0.076665968 -0.62863326 0.0028758477 ;
	setAttr ".pt[2214]" -type "float3" -0.07706929 -0.25587809 0.0046567833 ;
	setAttr ".pt[2215]" -type "float3" -0.050016608 0.14357059 0.0032131465 ;
	setAttr ".pt[2216]" -type "float3" -0.030928535 0.017708655 -0.00021288202 ;
	setAttr ".pt[2217]" -type "float3" -0.016232787 0.00052535778 -0.0052326769 ;
	setAttr ".pt[2218]" -type "float3" -0.0055945716 0.040610597 -0.0089687677 ;
	setAttr ".pt[2219]" -type "float3" 0.0033278349 0.16171122 -0.0071852254 ;
	setAttr ".pt[2220]" -type "float3" 0.0069954828 -0.073689714 -0.027875116 ;
	setAttr ".pt[2221]" -type "float3" 0.022652647 -0.36384755 -0.072238594 ;
	setAttr ".pt[2222]" -type "float3" 0.035100851 -0.33937022 -0.086713672 ;
	setAttr ".pt[2223]" -type "float3" 0.047583818 -0.35191023 -0.097834736 ;
	setAttr ".pt[2224]" -type "float3" 0.059070528 -0.40269515 -0.10453802 ;
	setAttr ".pt[2225]" -type "float3" 0.06582737 -0.48456708 -0.1089564 ;
	setAttr ".pt[2226]" -type "float3" 0.048674252 -0.43749309 -0.10461584 ;
	setAttr ".pt[2227]" -type "float3" -0.004675182 0.032974266 -0.10278251 ;
	setAttr ".pt[2228]" -type "float3" -0.0073366552 -0.22277707 -0.086516939 ;
	setAttr ".pt[2229]" -type "float3" -0.014469417 -0.47349074 -0.040755279 ;
	setAttr ".pt[2230]" -type "float3" -0.0088858223 -0.17105794 -0.0047635552 ;
	setAttr ".pt[2231]" -type "float3" -0.00026145263 -0.004052375 0.00061387831 ;
	setAttr ".pt[2233]" -type "float3" 0.001692282 -0.0091241058 0.0035625307 ;
	setAttr ".pt[2234]" -type "float3" 0.002766961 0.0059970333 0.00079869479 ;
	setAttr ".pt[2235]" -type "float3" 7.8153447e-005 -0.041484632 0.0298688 ;
	setAttr ".pt[2236]" -type "float3" 0.006213834 -0.031775333 0.15649717 ;
	setAttr ".pt[2237]" -type "float3" -0.16768457 -0.59608507 0.41224489 ;
	setAttr ".pt[2238]" -type "float3" -0.089807063 -0.16468005 0.050273899 ;
	setAttr ".pt[2239]" -type "float3" -0.091942742 -0.32808819 -0.16590306 ;
	setAttr ".pt[2240]" -type "float3" -0.14533682 -0.26195809 -0.19418073 ;
	setAttr ".pt[2241]" -type "float3" -0.0540848 -0.058004722 -0.05188803 ;
	setAttr ".pt[2244]" -type "float3" 3.9306605 1.6060297 -0.040287133 ;
	setAttr ".pt[2245]" -type "float3" 1.9783992 1.3983006 -0.045019437 ;
	setAttr ".pt[2246]" -type "float3" 0.82358646 1.3343557 -0.032100253 ;
	setAttr ".pt[2247]" -type "float3" 0.17594749 1.242312 0.017728321 ;
	setAttr ".pt[2248]" -type "float3" 0.016117308 1.1404272 0.061944969 ;
	setAttr ".pt[2249]" -type "float3" -0.01830015 0.93497086 0.086606205 ;
	setAttr ".pt[2250]" -type "float3" -0.028927183 0.37860063 0.056636304 ;
	setAttr ".pt[2251]" -type "float3" -0.037002727 0.3882741 0.037104722 ;
	setAttr ".pt[2252]" -type "float3" -0.033867419 0.54775727 0.02786452 ;
	setAttr ".pt[2253]" -type "float3" -0.0018666313 0.09107279 0.003743934 ;
	setAttr ".pt[2255]" -type "float3" 0.0052738851 -0.063409016 -0.013673258 ;
	setAttr ".pt[2256]" -type "float3" -0.011128935 0.17876568 -0.018431436 ;
	setAttr ".pt[2257]" -type "float3" -0.0031195187 0.0022253245 -0.0035588471 ;
	setAttr ".pt[2258]" -type "float3" -0.0088718031 0.048978865 -0.011141445 ;
	setAttr ".pt[2259]" -type "float3" 0.053807382 -0.12798645 -0.12539944 ;
	setAttr ".pt[2260]" -type "float3" 0.21773355 -0.31753138 -0.053359523 ;
	setAttr ".pt[2261]" -type "float3" 0.29989961 -0.49045533 0.057095479 ;
	setAttr ".pt[2262]" -type "float3" 0.1677248 -0.60327065 0.086412981 ;
	setAttr ".pt[2263]" -type "float3" 0.0064746677 -0.48689803 0.077181734 ;
	setAttr ".pt[2264]" -type "float3" -0.05043263 -0.33927852 0.06329719 ;
	setAttr ".pt[2265]" -type "float3" -0.038901683 -0.095832005 0.020226907 ;
	setAttr ".pt[2266]" -type "float3" -0.035699937 0.1621332 0.0021555468 ;
	setAttr ".pt[2267]" -type "float3" -0.011909947 0.025866833 -0.0041924901 ;
	setAttr ".pt[2268]" -type "float3" -0.0037106774 0.018551551 -0.0085552363 ;
	setAttr ".pt[2269]" -type "float3" 5.7517238e-005 0.00040596339 -0.00025946114 ;
	setAttr ".pt[2271]" -type "float3" 0.0077152606 -0.087614127 -0.044250119 ;
	setAttr ".pt[2272]" -type "float3" 0.017485883 -0.41566539 -0.083928391 ;
	setAttr ".pt[2273]" -type "float3" 0.026042121 -0.36131597 -0.085013852 ;
	setAttr ".pt[2274]" -type "float3" 0.033974741 -0.32696521 -0.077578731 ;
	setAttr ".pt[2275]" -type "float3" 0.041680228 -0.33097392 -0.063761227 ;
	setAttr ".pt[2276]" -type "float3" 0.044801608 -0.35676888 -0.044906631 ;
	setAttr ".pt[2277]" -type "float3" 0.032493234 -0.33395821 -0.025583683 ;
	setAttr ".pt[2278]" -type "float3" -0.011724861 0.067338809 -0.045849498 ;
	setAttr ".pt[2279]" -type "float3" -0.015000925 -0.044554964 -0.025967965 ;
	setAttr ".pt[2280]" -type "float3" -0.020215416 -0.2123425 0.013610177 ;
	setAttr ".pt[2281]" -type "float3" -0.0043989741 -0.031127384 0.0086892974 ;
	setAttr ".pt[2287]" -type "float3" -0.0038511001 0.071640998 0.0005092225 ;
	setAttr ".pt[2288]" -type "float3" -0.0052265776 -0.06526915 0.18945587 ;
	setAttr ".pt[2289]" -type "float3" 0.0018901489 -0.004807462 0.00052311283 ;
	setAttr ".pt[2290]" -type "float3" 0.0078338822 -0.40632465 -0.11780702 ;
	setAttr ".pt[2291]" -type "float3" -0.13491966 -0.39478672 -0.12842992 ;
	setAttr ".pt[2292]" -type "float3" -0.05011899 -0.085297167 -0.019079534 ;
	setAttr ".pt[2295]" -type "float3" 3.4507143 2.0883081 0.00092999265 ;
	setAttr ".pt[2296]" -type "float3" 1.7025582 1.4311075 -0.02204226 ;
	setAttr ".pt[2297]" -type "float3" 0.75823593 1.2664394 -0.031363931 ;
	setAttr ".pt[2298]" -type "float3" 0.19266897 1.1489358 -0.00060454023 ;
	setAttr ".pt[2299]" -type "float3" -0.03506396 1.0429703 0.044176463 ;
	setAttr ".pt[2300]" -type "float3" -0.075905189 0.94025135 0.068758078 ;
	setAttr ".pt[2301]" -type "float3" -0.060914379 0.38084686 0.025638901 ;
	setAttr ".pt[2302]" -type "float3" -0.056858238 0.44535711 -0.0018773336 ;
	setAttr ".pt[2303]" -type "float3" -0.039672904 0.71333307 -0.01193594 ;
	setAttr ".pt[2304]" -type "float3" -0.014067808 0.42942011 0.0030752379 ;
	setAttr ".pt[2306]" -type "float3" 0.00099219731 -0.10868392 -0.0076500983 ;
	setAttr ".pt[2307]" -type "float3" -0.021334678 0.27604753 0.0020453453 ;
	setAttr ".pt[2308]" -type "float3" -0.016030032 0.02833746 0.009238556 ;
	setAttr ".pt[2310]" -type "float3" 0.0067600803 -0.28843674 -0.071417168 ;
	setAttr ".pt[2311]" -type "float3" 0.11057838 -0.32705572 -0.043153957 ;
	setAttr ".pt[2312]" -type "float3" 0.21943556 -0.36220708 0.094467014 ;
	setAttr ".pt[2313]" -type "float3" 0.12768857 -0.43805563 0.20596655 ;
	setAttr ".pt[2314]" -type "float3" -0.024005791 -0.24062097 0.16124961 ;
	setAttr ".pt[2315]" -type "float3" -0.019098483 -0.039538749 0.082589291 ;
	setAttr ".pt[2316]" -type "float3" -0.00037509695 -0.0021100591 0.0014463987 ;
	setAttr ".pt[2317]" -type "float3" -0.020381073 0.1066425 -0.0068437364 ;
	setAttr ".pt[2318]" -type "float3" -0.0005479455 0.00061806443 -0.0026937486 ;
	setAttr ".pt[2321]" -type "float3" 0.0033165095 0.021168452 -0.0097034574 ;
	setAttr ".pt[2322]" -type "float3" 0.0069619999 -0.018422032 -0.039307788 ;
	setAttr ".pt[2323]" -type "float3" 0.0055112978 -0.42113969 -0.056516372 ;
	setAttr ".pt[2324]" -type "float3" 0.0080285324 -0.37609473 -0.045629021 ;
	setAttr ".pt[2325]" -type "float3" 0.0073262812 -0.28839776 -0.015859034 ;
	setAttr ".pt[2326]" -type "float3" 0.0067273565 -0.22838712 0.014130056 ;
	setAttr ".pt[2327]" -type "float3" 3.7614722e-005 -0.15158661 0.042636983 ;
	setAttr ".pt[2328]" -type "float3" 0.0029380443 -0.17906472 0.076465264 ;
	setAttr ".pt[2329]" -type "float3" -0.00072868867 0.026957812 0.017473634 ;
	setAttr ".pt[2330]" -type "float3" -0.0020122724 -0.025982136 0.067211017 ;
	setAttr ".pt[2331]" -type "float3" -0.0003784032 0.0028064179 0.0027229921 ;
	setAttr ".pt[2341]" -type "float3" 0.028573524 -0.13878274 0.020713288 ;
	setAttr ".pt[2342]" -type "float3" -0.079289936 -0.23880857 0.033188388 ;
	setAttr ".pt[2343]" -type "float3" -0.001937971 -0.0022172045 0.0015830452 ;
	setAttr ".pt[2346]" -type "float3" 3.0362206 2.4017074 -0.040468272 ;
	setAttr ".pt[2347]" -type "float3" 1.3040994 1.6980177 -0.040780045 ;
	setAttr ".pt[2348]" -type "float3" 0.48396268 1.2232752 -0.06151323 ;
	setAttr ".pt[2349]" -type "float3" 0.11849479 1.0259091 -0.046524879 ;
	setAttr ".pt[2350]" -type "float3" -0.071462981 0.87607229 0.00631289 ;
	setAttr ".pt[2351]" -type "float3" -0.091157749 0.82649148 0.024013828 ;
	setAttr ".pt[2352]" -type "float3" -0.076378576 0.34953234 -0.028630456 ;
	setAttr ".pt[2353]" -type "float3" -0.071757577 0.48960406 -0.063891433 ;
	setAttr ".pt[2354]" -type "float3" -0.046378598 0.88564187 -0.079553328 ;
	setAttr ".pt[2355]" -type "float3" -0.011957329 0.640625 -0.043834209 ;
	setAttr ".pt[2357]" -type "float3" -0.020807531 -0.077896789 0.03111859 ;
	setAttr ".pt[2358]" -type "float3" -0.04368807 0.51368928 0.044129103 ;
	setAttr ".pt[2359]" -type "float3" 0.0015359116 0.13063414 0.020833446 ;
	setAttr ".pt[2360]" -type "float3" 0.00029575848 0.00082555937 -0.0012334087 ;
	setAttr ".pt[2361]" -type "float3" 0.010769455 -0.40031096 -0.048486426 ;
	setAttr ".pt[2362]" -type "float3" 0.04260812 -0.41195872 -0.091777541 ;
	setAttr ".pt[2363]" -type "float3" 0.091254503 -0.32168856 -0.022437584 ;
	setAttr ".pt[2364]" -type "float3" 0.018889949 -0.24564463 0.1146454 ;
	setAttr ".pt[2365]" -type "float3" -0.07452067 0.032502603 0.13491493 ;
	setAttr ".pt[2366]" -type "float3" -0.007638732 0.12268987 0.062711768 ;
	setAttr ".pt[2368]" -type "float3" 0.00094382203 0.0020809472 -0.0053982455 ;
	setAttr ".pt[2372]" -type "float3" 0.0055807414 0.0018855319 -0.0091204941 ;
	setAttr ".pt[2373]" -type "float3" 0.0020285347 0.020103961 -0.00019524246 ;
	setAttr ".pt[2374]" -type "float3" -0.01085931 -0.38061202 0.015814828 ;
	setAttr ".pt[2375]" -type "float3" -0.01161424 -0.26979715 0.028966049 ;
	setAttr ".pt[2376]" -type "float3" -0.02085142 -0.16717029 0.072168693 ;
	setAttr ".pt[2377]" -type "float3" -0.024858961 -0.06781362 0.084941208 ;
	setAttr ".pt[2397]" -type "float3" 2.4854646 2.6943972 -0.19312495 ;
	setAttr ".pt[2398]" -type "float3" 0.83100194 2.4480352 -0.20294379 ;
	setAttr ".pt[2399]" -type "float3" 0.20179422 1.3853964 -0.073728144 ;
	setAttr ".pt[2400]" -type "float3" 0.049242135 0.91255379 -0.075095929 ;
	setAttr ".pt[2401]" -type "float3" -0.045783155 0.69304931 -0.078002721 ;
	setAttr ".pt[2402]" -type "float3" -0.089062124 0.6354059 -0.029187389 ;
	setAttr ".pt[2403]" -type "float3" -0.075444609 0.27164954 -0.078185737 ;
	setAttr ".pt[2404]" -type "float3" -0.079592764 0.4169575 -0.10498077 ;
	setAttr ".pt[2405]" -type "float3" -0.052047379 0.84664619 -0.12438639 ;
	setAttr ".pt[2406]" -type "float3" -0.013227089 0.65607166 -0.087420568 ;
	setAttr ".pt[2408]" -type "float3" -0.0074476055 0.011047548 0.005520897 ;
	setAttr ".pt[2409]" -type "float3" -0.0063289222 0.38678354 -0.014290987 ;
	setAttr ".pt[2410]" -type "float3" 0.0080345934 0.25452968 0.0028894558 ;
	setAttr ".pt[2411]" -type "float3" -0.00011436675 0.013486692 -0.0018891392 ;
	setAttr ".pt[2412]" -type "float3" 0.03717592 -0.52185696 -0.0075766193 ;
	setAttr ".pt[2413]" -type "float3" 0.028279591 -0.51942909 -0.071726374 ;
	setAttr ".pt[2414]" -type "float3" -0.0033517524 -0.37602097 -0.063389406 ;
	setAttr ".pt[2415]" -type "float3" -0.076148093 -0.1504578 0.003676007 ;
	setAttr ".pt[2416]" -type "float3" -0.068623379 0.12438771 -0.011826419 ;
	setAttr ".pt[2417]" -type "float3" 0.028068248 0.020783966 -0.056421045 ;
	setAttr ".pt[2418]" -type "float3" 0.00012628426 0.00023871931 -0.00019010657 ;
	setAttr ".pt[2423]" -type "float3" -0.0024072777 -0.0006049723 0.028216932 ;
	setAttr ".pt[2424]" -type "float3" -0.0057871696 0.090880118 0.058286823 ;
	setAttr ".pt[2425]" -type "float3" -0.015994409 -0.22814643 0.068182908 ;
	setAttr ".pt[2426]" -type "float3" -0.0036287887 -0.0088556139 0.01583039 ;
	setAttr ".pt[2427]" -type "float3" -0.022849202 0.01252031 0.096550293 ;
	setAttr ".pt[2428]" -type "float3" -0.017501744 0.041332439 0.05690043 ;
	setAttr ".pt[2448]" -type "float3" 2.0793664 3.3360229 -0.52004486 ;
	setAttr ".pt[2449]" -type "float3" 0.47420016 3.247752 -0.5160622 ;
	setAttr ".pt[2450]" -type "float3" -0.0519883 2.4570444 -0.34695005 ;
	setAttr ".pt[2451]" -type "float3" -0.0025722217 1.0842059 -0.079626739 ;
	setAttr ".pt[2452]" -type "float3" -0.021070395 0.54773772 -0.061397798 ;
	setAttr ".pt[2453]" -type "float3" -0.055912182 0.36043683 -0.067276455 ;
	setAttr ".pt[2454]" -type "float3" -0.066014521 0.18292002 -0.036698267 ;
	setAttr ".pt[2455]" -type "float3" -0.087006129 0.30017981 -0.036776602 ;
	setAttr ".pt[2456]" -type "float3" -0.043525044 0.86606407 -0.153082 ;
	setAttr ".pt[2457]" -type "float3" -0.0092492737 0.30082741 -0.067098223 ;
	setAttr ".pt[2460]" -type "float3" -0.006562334 0.23490697 0.003396506 ;
	setAttr ".pt[2461]" -type "float3" -0.0018883825 0.29431048 0.071934864 ;
	setAttr ".pt[2462]" -type "float3" -0.0055207009 0.31161603 0.0018468071 ;
	setAttr ".pt[2463]" -type "float3" 0.037050877 -0.38413313 0.083460122 ;
	setAttr ".pt[2464]" -type "float3" 0.01532779 -0.46847561 0.081294209 ;
	setAttr ".pt[2465]" -type "float3" -0.040732522 -0.30937576 0.077245668 ;
	setAttr ".pt[2466]" -type "float3" -0.045815527 0.003619533 0.024977069 ;
	setAttr ".pt[2467]" -type "float3" -0.013663688 -0.023307716 0.0068994313 ;
	setAttr ".pt[2468]" -type "float3" 0.020901186 -0.21308871 -0.0081128366 ;
	setAttr ".pt[2474]" -type "float3" -0.0001474061 0.00074679713 0.0015952091 ;
	setAttr ".pt[2475]" -type "float3" -0.0017234241 0.09975104 0.034695037 ;
	setAttr ".pt[2477]" -type "float3" -0.00030056783 -0.00019214184 0.0027919926 ;
	setAttr ".pt[2478]" -type "float3" -0.0058169253 0.030787082 0.10730447 ;
	setAttr ".pt[2479]" -type "float3" 0.0044624433 0.034242716 0.055916831 ;
	setAttr ".pt[2499]" -type "float3" 1.462834 3.0526361 -0.97070885 ;
	setAttr ".pt[2500]" -type "float3" 0.015792402 3.117768 -0.99470419 ;
	setAttr ".pt[2501]" -type "float3" -0.24533151 2.599479 -0.70092493 ;
	setAttr ".pt[2502]" -type "float3" -0.086188838 1.9560832 -0.17687209 ;
	setAttr ".pt[2503]" -type "float3" -0.012334004 0.89099461 -0.078680165 ;
	setAttr ".pt[2504]" -type "float3" -0.066316783 0.59985495 -0.20782505 ;
	setAttr ".pt[2505]" -type "float3" -0.044836693 0.25847685 0.06211447 ;
	setAttr ".pt[2506]" -type "float3" -0.062347632 0.2831288 0.047571227 ;
	setAttr ".pt[2507]" -type "float3" -0.01079901 0.72158408 -0.21313313 ;
	setAttr ".pt[2511]" -type "float3" -0.0096841268 0.057025686 0.039184902 ;
	setAttr ".pt[2512]" -type "float3" -0.0016511965 0.15544158 0.30319148 ;
	setAttr ".pt[2513]" -type "float3" 0.0043966654 0.3401823 0.18879169 ;
	setAttr ".pt[2514]" -type "float3" 0.0084793475 -0.099853143 0.1573443 ;
	setAttr ".pt[2515]" -type "float3" 0.0072335196 -0.098277658 0.14044465 ;
	setAttr ".pt[2516]" -type "float3" -0.00097740686 0.0033675209 0.020576261 ;
	setAttr ".pt[2517]" -type "float3" 0.007574921 0.0033031858 0.10095138 ;
	setAttr ".pt[2518]" -type "float3" 0.016796019 -0.20176144 0.25988382 ;
	setAttr ".pt[2519]" -type "float3" -0.036152046 -0.343835 0.24961716 ;
	setAttr ".pt[2528]" -type "float3" 0.00019086755 -0.0018717623 0.009987507 ;
	setAttr ".pt[2529]" -type "float3" 0.0059961909 0.01388933 0.25027162 ;
	setAttr ".pt[2530]" -type "float3" 0.010750806 0.0054955576 0.22846636 ;
	setAttr ".pt[2550]" -type "float3" 1.6321555 2.0330021 -0.15475374 ;
	setAttr ".pt[2551]" -type "float3" 0.12842309 1.9865831 -0.2422837 ;
	setAttr ".pt[2552]" -type "float3" -0.13872352 1.9247811 -0.17735288 ;
	setAttr ".pt[2553]" -type "float3" -0.064977273 1.910988 0.40845495 ;
	setAttr ".pt[2554]" -type "float3" -0.0058863889 1.4010469 0.2502259 ;
	setAttr ".pt[2555]" -type "float3" -0.064661965 0.88274598 -0.0034841895 ;
	setAttr ".pt[2556]" -type "float3" -0.014453309 0.37492967 0.32076234 ;
	setAttr ".pt[2557]" -type "float3" -0.010499737 0.10761379 0.20660615 ;
	setAttr ".pt[2563]" -type "float3" 0.0021989369 0.10573778 1.003343 ;
	setAttr ".pt[2564]" -type "float3" 0.01297453 0.2720944 0.92061472 ;
	setAttr ".pt[2565]" -type "float3" -0.00025414859 -0.00083631725 0.0060835448 ;
	setAttr ".pt[2568]" -type "float3" 0.031807229 -0.0077356119 0.39830539 ;
	setAttr ".pt[2569]" -type "float3" 0.0068367575 -0.22580647 0.86244226 ;
	setAttr ".pt[2570]" -type "float3" -0.063046843 -0.17017248 0.68183351 ;
	setAttr ".pt[2579]" -type "float3" 0.00040417092 -0.0015497628 0.0170692 ;
	setAttr ".pt[2580]" -type "float3" 0.0089305677 -0.0091287866 0.58009803 ;
	setAttr ".pt[2581]" -type "float3" 0.0063157566 -0.0126429 0.54060817 ;
	setAttr -s 2601 ".vt";
	setAttr ".vt[0:165]"  -75 -1.110223e-014 50 -72 -1.110223e-014 50 -69 -1.110223e-014 50
		 -66 -1.110223e-014 50 -63 -1.110223e-014 50 -60 -1.110223e-014 50 -57 -1.110223e-014 50
		 -54 -1.110223e-014 50 -51 -1.110223e-014 50 -48.044376373 1.0037792921 49.91341782
		 -45.029586792 1.7289623 49.59887314 -42.0094795227 1.95264256 49.1556778 -39.0049285889 1.99414325 48.68000793
		 -36.010257721 1.98593032 48.27183151 -33.017559052 1.84783638 47.95023346 -30.012386322 1.38354015 47.74398041
		 -27.0052680969 1.28007638 47.55910873 -24.0047836304 1.45459402 47.52664948 -21.0011005402 1.64579999 47.57810593
		 -17.99437523 1.81424129 47.76746368 -14.98618031 1.92412162 48.010536194 -11.97687531 1.95321405 48.28749466
		 -8.96531582 1.91871691 48.84458542 -5.91746092 2.066301584 49.51185608 -2.81199551 2.12809467 49.87343979
		 0.16987042 1.96368945 49.86706543 3.062350988 1.90404987 49.76657867 6.0057144165 1.80996644 49.73434067
		 8.9998436 1.50366628 49.83390045 12 0.99887514 50 14.9579792 0.99865574 50.014057159
		 17.84618759 1.17973876 50.10850525 20.75864029 1.58806407 50.32441711 23.75511742 2.080157995 50.40632629
		 26.83752823 2.79380941 50.20084381 29.98547363 3.14189005 50.027439117 33.13489532 2.82587576 50.089248657
		 36.073493958 2.035888672 50.19152832 38.89972305 1.94467807 50.34278107 41.94010925 1.99142241 50.46630859
		 45.11714554 1.80824447 50.41241837 48.083633423 1.29403222 50.14479065 51.055091858 1.28047037 49.31034851
		 54.038021088 1.15171623 48.87916946 57.020107269 0.97481662 48.80867004 60.0074119568 0.80233806 48.86132431
		 63.0017242432 0.57513636 48.99816895 66.00022125244 0.28470019 49.20888519 69.000007629395 0.052968547 49.50068665
		 72 0.0010862148 49.88335419 75 -1.110223e-014 50 -75 -1.0658141e-014 48 -72 -1.0658141e-014 48
		 -69 -1.0658141e-014 48 -66 -1.0658141e-014 48 -63 -1.0658141e-014 48 -60 -1.0658141e-014 48
		 -57 -1.0658141e-014 48 -54 -1.0658141e-014 48 -51 0.44623405 48 -48.044551849 1.4597764 48.057697296
		 -45.022312164 1.89386296 48.012516022 -42.0055198669 1.98788583 47.85956192 -39.004032135 2.00045967102 47.64037323
		 -36.010387421 1.9982841 47.40507507 -33.020133972 1.88940597 47.18831635 -30.015958786 1.40869796 47.042812347
		 -27.008638382 1.29022181 46.90896988 -24.0086898804 1.4802357 46.89136887 -21.0040359497 1.68734479 46.93515778
		 -17.99464226 1.86568391 47.075332642 -14.98249054 1.96983397 47.18279648 -11.97099495 1.99066377 47.39131165
		 -8.95832157 1.94062781 47.61271667 -5.91159105 2.28326011 47.90555573 -2.82266212 2.43270469 48.11677933
		 0.1893708 2.21415043 48.14396667 3.090423346 2.013439655 48.07175827 6.012647152 1.92565989 48.012996674
		 8.99787521 1.69507587 48.0045204163 11.99713516 1.12107825 48.0040817261 14.92644978 0.99600786 48.050487518
		 17.78601074 1.27548957 48.20553207 20.72046089 2.22397447 48.41058731 23.78012657 2.91464877 48.41410065
		 26.87222862 3.44865036 48.27100754 29.98762131 3.69021678 48.18870163 33.082332611 3.48999906 48.25896835
		 36.019264221 2.66717386 48.36731339 38.88183975 2.31768775 48.38610077 41.94092178 2.62770081 48.3912468
		 45.11943054 2.45562673 48.33702469 48.090438843 1.90989816 48.2338295 51.069541931 1.60579443 48.0018959045
		 54.051445007 1.33293152 47.81054688 57.029506683 1.090246916 47.76218033 60.011417389 0.89701623 47.77239609
		 63.0028038025 0.67451137 47.82335663 66.0004196167 0.36205667 47.89449692 69.000022888184 0.065055393 47.9683876
		 72 0.0011746855 47.99987411 75 -1.0658141e-014 48 -75 -1.0214052e-014 46 -72 -1.0214052e-014 46
		 -69 -1.0214052e-014 46 -66 -1.0214052e-014 46 -63 -1.0214052e-014 46 -60 -1.0214052e-014 46
		 -57 -1.0214052e-014 46 -54 0.21030265 46 -51 0.87641394 46 -48.021331787 1.67248023 46.028175354
		 -45.007598877 1.95503259 46.010959625 -42.0015983582 1.99784219 45.98282242 -39.0033340454 2.0027649403 45.92268372
		 -36.011146545 2.0070617199 45.83340073 -33.024166107 1.92270958 45.73397446 -30.023115158 1.44866669 45.66635513
		 -27.015930176 1.32138932 45.60179138 -24.017034531 1.53877938 45.60674286 -21.010444641 1.77199209 45.64759827
		 -17.99583817 1.96777105 45.73940277 -14.97644234 2.07003212 45.79177094 -11.95864964 2.074290752 45.85374451
		 -8.94551373 2.0048732758 45.94659424 -5.90119648 2.47400808 46.040084839 -2.84062219 2.61049819 46.10588074
		 0.1894578 2.39660263 46.11909103 3.12665272 2.1016438 46.086166382 6.023431778 1.98558235 46.049827576
		 8.97480679 1.81736839 46.066242218 11.95510101 1.26494455 46.10479736 14.8648119 1.034038305 46.17121124
		 17.72239113 1.95126307 46.29098129 20.74305534 2.87754679 46.30551529 23.84978867 3.44746065 46.21084213
		 26.92544365 3.87846899 46.13335419 29.9474926 4.044169426 46.15611649 32.89651871 3.98788762 46.34065628
		 35.86140442 3.62592387 46.54218292 38.93244934 3.075151682 46.39493179 41.98184586 2.92491746 46.1957016
		 45.090938568 2.6723361 46.16374588 48.092262268 2.28823352 46.16602325 51.087673187 1.9340266 46.11569595
		 54.071578979 1.56713986 46.044498444 57.045070648 1.24720907 46.0055198669 60.019100189 1.01167798 45.98835373
		 63.0054855347 0.79080254 45.98892593 66.0012359619 0.467363 45.99557114 69.000091552734 0.084528357 45.99972534
		 72 0.0010429882 46 75 -1.0214052e-014 46 -75 -9.7699626e-015 44 -72 -9.7699626e-015 44
		 -69 -9.7699626e-015 44 -66 -9.7699626e-015 44 -63 -9.7699626e-015 44 -60 -9.7699626e-015 44
		 -57 0.088350639 44 -54 0.85430157 44 -51 0.99045235 44 -48.0055084229 1.75388873 44.0077285767
		 -45.0012550354 1.97477829 44.0018882751 -42.00050735474 1.99967217 43.99808121 -39.0025253296 2.0025014877 43.98538971;
	setAttr ".vt[166:331]" -36.010951996 2.0081863403 43.95833588 -33.028377533 1.93833673 43.92457199
		 -30.032743454 1.47633028 43.91050339 -27.026630402 1.35746336 43.89696121 -24.029598236 1.61545324 43.91756821
		 -21.020708084 1.88573623 43.95485306 -17.99923706 2.10130906 43.99721909 -14.97027969 2.22044277 44.049926758
		 -11.94373417 2.21229124 44.067989349 -8.92593479 2.12079716 44.084125519 -5.88051748 2.64548087 44.11904144
		 -2.8453064 2.73770666 44.1342926 0.17086524 2.53547716 44.14528275 3.12484837 2.24382782 44.16132736
		 6.0093784332 2.07361722 44.19208145 8.93253803 2.033191919 44.24865723 11.90798283 1.80729771 44.25012207
		 14.85262966 1.81655931 44.19043732 17.76735497 2.43619943 44.16867065 20.80947113 3.14173651 44.11650085
		 23.89774513 3.74201012 44.075176239 26.93250275 4.095803261 44.072620392 29.8409729 4.23608398 44.18516922
		 32.70315552 4.34000587 44.39575577 35.78383636 4.38841343 44.53908157 39.059921265 3.67652512 44.34301376
		 42.062767029 2.97741842 44.08190155 45.088294983 2.7360096 44.062843323 48.092334747 2.46822357 44.083904266
		 51.10105515 2.16369843 44.088756561 54.10251236 1.85437214 44.075393677 57.079216003 1.60428751 44.057537079
		 60.041446686 1.3096168 44.040569305 63.011222839 0.91275394 44.02173996 66.003578186 0.5556981 44.010513306
		 69.00030517578 0.081083946 44.00095367432 72 4.2367046e-005 44 75 -9.7699626e-015 44
		 -75 -9.3258734e-015 42 -72 -9.3258734e-015 42 -69 -9.3258734e-015 42 -66 -9.3258734e-015 42
		 -63 -9.3258734e-015 42 -60 0.31790254 42 -57 0.88624716 42 -54 0.99534988 42 -51 0.99986148 42
		 -48.00073623657 1.77520287 42.0011062622 -45.000072479248 1.98173821 42.000087738037
		 -41.9997406 1.99969041 41.99902725 -38.99930191 1.99914908 41.9930954 -36.0057983398 1.99387217 41.97814178
		 -33.028572083 1.9057883 41.96468735 -30.039222717 1.39641845 41.98239517 -27.039041519 1.37158227 41.99412155
		 -24.044771194 1.68335009 42.018783569 -21.034006119 2.002355814 42.055130005 -18.0066509247 2.26773763 42.10284805
		 -14.96718884 2.39147067 42.12878036 -11.93004799 2.38159585 42.13779831 -8.90397739 2.27730608 42.13573074
		 -5.85541773 2.81731415 42.16019058 -2.8373158 2.88060403 42.1606102 0.15411544 2.70508337 42.16986465
		 3.10422087 2.49908853 42.20875549 5.99995375 2.4245894 42.26657867 8.92966747 2.54083252 42.28985977
		 11.92000771 2.3871789 42.21384811 14.8862257 2.24111056 42.11026001 17.81785965 2.67871666 42.056617737
		 20.8273716 3.25628591 42.019756317 23.89328957 3.8946805 42.0059890747 26.88759995 4.20179796 42.049545288
		 29.72010994 4.36918163 42.18924332 32.59199905 4.625669 42.33687973 35.78852081 4.83556175 42.37308884
		 39.15724182 4.31163979 42.24252319 42.14490509 3.076538086 42.059398651 45.10445404 2.734761 42.015731812
		 48.091400146 2.50777793 42.028968811 51.10955048 2.33491993 42.048332214 54.13301086 2.2047801 42.06287384
		 57.094596863 1.85035813 42.047409058 60.037277222 1.48267698 42.032764435 63.0016860962 1.076242685 42.027275085
		 65.99800873 0.59804356 42.025630951 69.00049591064 0.036496799 42.0015563965 72 -9.3258734e-015 42
		 75 -9.3258734e-015 42 -75 -8.8817842e-015 40 -72 -8.8817842e-015 40 -69 -8.8817842e-015 40
		 -66 -8.8817842e-015 40 -63 0.29855004 40 -60 0.87323952 40 -57 0.99705756 40 -54 0.99997061 40
		 -51 0.99999964 40 -48.000038146973 1.79587984 40.000064849854 -44.99986649 1.97356534 39.99990082
		 -41.99805069 1.99906397 39.99807739 -38.98981094 1.99007297 39.98623276 -35.98994827 1.9449656 39.95956802
		 -33.022117615 1.79592323 39.9466095 -30.044124603 1.25204766 39.98790741 -27.050859451 1.33717537 40.0073699951
		 -24.059614182 1.71274853 40.024829865 -21.051530838 2.11607647 40.052181244 -18.019256592 2.41857076 40.087604523
		 -14.96912289 2.52638292 40.11459351 -11.91983223 2.55028248 40.13569641 -8.88649273 2.42938256 40.1324234
		 -5.83270836 2.94440579 40.15029144 -2.82092476 3.0078949928 40.1426506 0.152986 2.85204935 40.13724136
		 3.097848892 2.70465922 40.15119934 6.016936779 2.74478006 40.17279053 8.96476841 2.83717084 40.16025543
		 11.95611477 2.63595963 40.098892212 14.92463017 2.37673378 40.035926819 17.85419273 2.75820041 39.97969055
		 20.81877136 3.299438 39.93398666 23.84783554 3.91429043 39.91670227 26.82431984 4.20576668 39.9697113
		 29.68021011 4.38114929 40.067783356 32.62187958 4.68834162 40.11763763 35.84498596 4.86466408 40.079597473
		 39.18857956 4.57626915 40.024707794 42.16801071 3.17564178 40.013332367 45.090682983 2.47889447 39.99788284
		 48.079360962 1.98867905 40.00060272217 51.1252861 1.89142537 39.97850037 54.11634064 1.78660595 39.9751091
		 57.060840607 1.57019234 39.98794937 59.99771881 1.33372331 39.99045563 62.9355278 1.0063245296 39.97687912
		 65.89120483 0.44861746 39.97179794 68.95775604 -0.19083057 39.98220062 72 2.3814302e-006 40
		 74.99223328 -8.8817842e-015 40 -75 -8.437695e-015 38 -72 -8.437695e-015 38 -69 -8.437695e-015 38
		 -66 0.095732413 38 -63 0.80536062 38 -60 0.99541712 38 -57 0.9999826 38 -54 0.99999988 38
		 -51 1 38 -48 1.79943705 38 -44.99967957 1.97101605 37.99991226 -41.99354935 1.99763155 37.99600983
		 -38.96961212 1.96335065 37.97232819 -35.9614563 1.81603432 37.92932892 -33.012256622 1.59060812 37.90676498
		 -30.050849915 1.05068934 37.97807693 -27.064113617 1.25033474 37.99444199 -24.10342979 1.92244935 37.99984741
		 -21.097084045 2.46611595 38.012481689 -18.051704407 2.75836921 38.02929306 -14.98485851 2.80603647 38.054679871
		 -11.92275906 2.62352061 38.077533722 -8.8796711 2.51944494 38.08813858 -5.81597328 2.98980188 38.096252441
		 -2.80463719 3.060870171 38.080539703 0.16128975 2.91609025 38.065551758;
	setAttr ".vt[332:497]" 3.10314226 2.78009295 38.060905457 6.040316582 2.87221313 38.051326752
		 8.99825668 2.88407469 38.025829315 11.98509884 2.63958859 37.99264526 14.95947838 2.3162868 37.96002197
		 17.89927101 2.55306172 37.89395142 20.84771347 3.033778667 37.83436203 23.84446716 3.55543804 37.81588745
		 26.82163429 3.81709266 37.86450577 29.75403595 3.9217 37.93618774 32.76695633 4.010230064 37.95775986
		 35.90441895 4.075858116 37.90588379 39.046577454 3.71367145 37.89394379 41.98431778 2.46603775 38.018119812
		 45.019252777 1.78160834 38.038146973 48.099460602 1.52682734 38.014797211 51.15293121 1.72519064 37.98377228
		 54.10878754 1.77917123 37.9936409 57.047176361 1.67900348 38.024494171 59.99608994 1.54627991 38.035324097
		 62.93702698 1.30370998 38.013317108 65.85414124 0.7230401 37.98143387 68.8478241 -0.32350492 37.93461227
		 71.98995209 -0.12058293 37.99374008 74.81084442 8.4279556e-005 38 -75 -7.9936058e-015 36
		 -72 -7.9936058e-015 36 -69 -7.9936058e-015 36 -66 0.6373468 36 -63 0.98124629 36
		 -60 0.99994344 36 -57 1 36 -54 1 36 -51 1 36 -48 1.81322253 36 -44.99960709 1.97335231 36
		 -41.98802185 1.99696016 35.99517441 -38.93833923 1.92342329 35.96347809 -35.92056656 1.60661316 35.90958786
		 -33.0067253113 1.26428688 35.88840866 -30.055789948 0.7565257 35.9828186 -27.1024704 1.3137573 35.98708725
		 -24.15679932 2.25826406 35.99264145 -21.12665558 2.7978611 35.97633362 -18.079282761 3.059724092 35.96538925
		 -15.010587692 3.073449373 35.97911072 -11.93376255 2.80031848 36.0065498352 -8.88257408 2.55758619 36.024902344
		 -5.81355524 2.9378593 36.024749756 -2.79588556 3.026720762 36.0082321167 0.16807474 2.878057 35.99166107
		 3.10846353 2.72753811 35.98303223 6.053204536 2.69984436 35.94528198 9.0065374374 2.58496046 35.92991638
		 11.97704315 2.27967858 35.93270493 14.97247124 1.85594392 35.93586349 17.96230888 1.90568197 35.91700363
		 20.92144775 2.43761802 35.85967255 23.90024567 2.96057653 35.84075928 26.86426544 3.35920143 35.85400009
		 29.83871841 3.55893898 35.88806152 32.86762619 3.63121486 35.89705658 35.95014572 3.61945963 35.87286377
		 39.02583313 3.25526047 35.89523315 42.014305115 2.36460376 36.0015602112 45.048770905 1.78231549 36.037628174
		 48.11790466 1.67432332 36.024612427 51.14960098 1.92534363 36.011558533 54.095909119 1.9811846 36.025806427
		 57.035945892 1.86661446 36.047370911 59.99676514 1.77684593 36.053813934 62.95101547 1.61424243 36.036998749
		 65.84667969 1.021534204 36.0014953613 68.7791748 -0.1436504 35.94003677 71.91937256 -0.23031799 35.98063278
		 74.42996216 0.0072785844 36.000049591064 -75 -7.5495166e-015 34 -72 -7.5495166e-015 34
		 -69 0.25452673 34 -66 0.91450137 34 -63 0.99940228 34 -60 0.99999976 34 -57 1 34
		 -54 1 34 -51 1.051490784 34 -48 1.83263588 34 -44.9995575 1.97242928 34.00035858154
		 -41.98645401 1.9665978 34.0027160645 -38.92342758 1.86111391 34.0047340393 -35.88767242 1.378739 33.98583221
		 -32.99119568 0.96169835 33.96453857 -30.044898987 0.49648055 33.99771881 -27.19798279 1.66847205 33.9997673
		 -24.19020271 2.58799553 34.0021400452 -21.11921883 2.96930504 33.97938156 -18.081737518 3.11862636 33.94771957
		 -15.030153275 3.13244843 33.93029022 -11.96225166 2.91666842 33.93610001 -8.89288044 2.58758378 33.94850159
		 -5.81225395 2.59585571 33.95767975 -2.80042458 2.50134945 33.95976257 0.1424218 2.21172285 33.96593475
		 3.077860832 1.87630486 33.98652267 6.039602757 2.019709587 33.94904709 8.98607445 1.96192706 33.94512177
		 11.93632412 1.68936324 33.96559143 14.9590044 1.44896424 33.98405075 17.97975922 1.52331579 33.99503326
		 20.93992615 2.14745116 33.94509506 23.90441895 2.75879216 33.9156723 26.88597679 3.12576842 33.92223358
		 29.88290215 3.31566167 33.94092941 32.91749573 3.35649037 33.94903564 35.97130585 3.28755927 33.94404602
		 39.014507294 2.96579957 33.96800613 42.031608582 2.28536892 34.032081604 45.070476532 1.75133896 34.060222626
		 48.13712311 1.74390948 34.057834625 51.15113831 2.057199478 34.058029175 54.090454102 2.17120409 34.065700531
		 57.03458786 2.13819146 34.069332123 60.00207901 2.054283857 34.060352325 62.96217728 1.79771411 34.039455414
		 65.83982086 1.17977762 34.0099449158 68.73293304 -0.024074093 33.96034622 71.7967453 -0.28054908 33.97727203
		 74.027107239 -0.093670167 33.99597931 -75 -7.1054274e-015 32 -72 -7.1054274e-015 32
		 -69 0.71285188 32 -66 0.99118048 32 -63 0.99998939 32 -60 1 32 -57 1 32 -54 1 32
		 -50.99962234 1.1732831 31.99985504 -47.99267578 1.77340472 32.00088500977 -44.99692917 1.78827882 32.015338898
		 -41.99001312 1.73641026 32.032051086 -38.95164108 1.65607309 32.046886444 -35.90341568 1.44482768 32.054615021
		 -32.96844482 0.96195829 32.036708832 -30.050640106 0.7129727 31.9665699 -27.35421371 2.21480942 31.88790131
		 -24.28391266 3.046625614 31.88456726 -21.16981888 3.34963346 31.91112137 -18.094865799 3.39724803 31.93439102
		 -15.037336349 3.044479132 31.93009949 -11.99344349 2.85939002 31.92248726 -8.91876221 2.48917556 31.92711639
		 -5.83278179 2.39506102 31.94972801 -2.80945539 2.37838316 31.96496964 0.14624938 2.22941923 31.97174835
		 3.082942963 2.052114487 31.97660637 6.037996769 2.072612524 31.97291946 8.99602032 1.94800675 31.97797012
		 11.95223045 1.66703558 32.0008354187 14.96522236 1.53004193 32.0274086 17.96794891 1.641361 32.037075043
		 20.94329453 2.024834394 32.021549225 23.91464615 2.58669543 32.00051116943 26.90597916 2.93495989 32.0038146973
		 29.90858841 3.14409328 32.019878387 32.94264603 3.19655037 32.038642883 35.98261261 3.10009289 32.054298401
		 39.0094184875 2.82375216 32.076522827;
	setAttr ".vt[498:663]" 42.041679382 2.25402331 32.10400772 45.091457367 1.72560692 32.11641693
		 48.16890335 1.722947 32.12367249 51.17619705 2.047911644 32.13796616 54.10095596 2.15833306 32.13707733
		 57.039909363 2.13560009 32.12593842 60.011390686 2.085927248 32.11023712 62.98188019 1.87385023 32.089557648
		 65.87528229 1.28632534 32.057285309 68.71837616 0.072465122 31.99641228 71.67350006 -0.25963932 31.98363876
		 73.72068787 -0.15418963 31.99443054 -75 -6.6613381e-015 30 -72 0.21513808 30 -69 0.92398602 30
		 -66 0.99962193 30 -63 0.99999976 30 -59.99765015 1.086461425 29.99535179 -56.99584579 1.11287975 29.98285294
		 -54.00024032593 1.12762761 29.97221947 -50.98895264 1.22145939 29.9799099 -47.97740555 1.48305345 30.010295868
		 -44.991539 1.43698323 30.03909111 -41.99330902 1.32716393 30.045578003 -38.97561264 1.22591841 30.032329559
		 -35.95435715 1.18109941 30.01064682 -32.96775818 1.13968611 29.95586395 -30.11866379 1.42187059 29.90104866
		 -27.3985405 2.41823411 29.84027672 -24.38788986 3.29087615 29.87919235 -21.28258896 3.86522126 29.97339439
		 -18.16087151 4.11344719 30.023578644 -15.037742615 3.91692877 30.01773262 -11.9951992 3.054251194 29.97562218
		 -8.93269348 2.54911733 29.97319603 -5.8480587 2.37950397 29.98982239 -2.81752992 2.36836767 30.00051879883
		 0.14553082 2.24627614 30.001707077 3.086887121 2.11254001 30.0013694763 6.04332304 2.15603995 29.99890137
		 9.011262894 2.07370615 30.0020523071 11.97821426 1.82981694 30.020051956 14.97177505 1.65056884 30.045295715
		 17.96751022 1.68112814 30.064903259 20.96006966 1.88634253 30.0698452 23.94175339 2.35279155 30.06637001
		 26.9339695 2.70642948 30.076337814 29.9351368 2.94078279 30.095962524 32.96223068 3.041686058 30.12330627
		 35.99094009 2.94473886 30.15885544 39.007232666 2.71369553 30.17726707 42.049442291 2.24327397 30.18671608
		 45.12182617 1.7775979 30.19239998 48.21334076 1.62425208 30.18906021 51.21707153 1.84522498 30.19219589
		 54.12432098 1.89175177 30.17770576 57.049713135 1.81982315 30.15867233 60.011539459 1.73670876 30.14091682
		 62.96775055 1.57595778 30.12111473 65.87822723 1.1514653 30.091947556 68.75924683 0.30690169 30.044788361
		 71.62536621 -0.18555231 30.00080490112 73.52197266 -0.12319803 29.99668121 -75 -6.2172489e-015 28
		 -72 0.66976964 28 -69 0.98885912 28 -65.99999237 1.016014099 27.99997902 -62.99317551 1.15954018 27.99090576
		 -59.98152542 1.083811522 27.97012901 -56.97751617 0.79810369 27.95372581 -53.9602356 0.65982807 27.95582962
		 -50.93720245 0.83494854 27.98594666 -47.94746399 1.082256675 28.02872467 -44.97160339 1.17262375 28.0473423
		 -41.96920013 1.19574606 28.034303665 -38.94100189 1.33216679 28.022520065 -35.91120529 1.53962207 28.031070709
		 -32.94437027 1.53902912 28.020435333 -30.11411858 1.70998323 28.011043549 -27.41031837 2.48657894 27.94646835
		 -24.46042633 3.36988163 27.92629433 -21.34868431 4.04577589 27.94606018 -18.19491959 4.44111872 27.96696472
		 -15.03302002 4.41236305 27.96326256 -11.92467785 3.86364889 27.97514725 -8.93694496 2.62317133 28.012914658
		 -5.85471964 2.37642479 28.031852722 -2.82087898 2.36924076 28.040075302 0.14530495 2.29844093 28.036865234
		 3.092803717 2.21137786 28.027751923 6.045166969 2.1627903 28.015798569 9.012889862 2.066226482 28.010955811
		 11.98458195 1.84439194 28.025733948 14.9682951 1.57787871 28.052865982 17.97138023 1.51983893 28.07959938
		 20.97484207 1.71349227 28.093902588 23.9698658 2.10425496 28.10048485 26.9689064 2.44004965 28.11644745
		 29.97317886 2.65980101 28.14183426 32.9901619 2.77758479 28.16719627 36.0077781677 2.69901109 28.19669533
		 39.015247345 2.48953152 28.2055397 42.058078766 2.15698528 28.20231438 45.13339615 1.80688322 28.19953537
		 48.20845413 1.57817435 28.1874485 51.20938492 1.65819871 28.17425919 54.14600372 1.67937553 28.158638
		 57.068443298 1.60483122 28.1415062 60.000061035156 1.46880674 28.12138367 62.92798996 1.24214172 28.099304199
		 65.83692169 0.85414946 28.079109192 68.72370148 0.328713 28.048643112 71.45262909 0.060102873 28.008556366
		 73.19942474 -0.016922446 27.99547577 -75 0.084297173 26 -72 0.90015727 26 -69 0.99919146 26
		 -65.99468994 1.18582404 25.98624229 -62.97748566 1.1405828 25.97412872 -59.9684639 0.76934123 25.98190689
		 -56.96887589 0.50626105 25.99224091 -53.94305038 0.43862242 26.019832611 -50.92045593 0.71047169 26.055997849
		 -47.93258667 1.046266794 26.098381042 -44.94395065 1.30247974 26.11325645 -41.92515564 1.59564519 26.10970116
		 -38.88498306 1.95031941 26.1268425 -35.86750412 2.026689291 26.13402176 -32.92221451 1.86135519 26.11620903
		 -30.085035324 1.85750365 26.07324791 -27.3771801 2.52646899 25.99286461 -24.45664215 3.35287094 25.87797356
		 -21.34899521 3.97698569 25.81047058 -18.19295883 4.32463884 25.77873039 -15.0343256 4.38285589 25.78365517
		 -11.9091053 4.065502167 25.83728027 -8.87408924 3.24957752 25.94898796 -5.85905933 2.35534811 26.075708389
		 -2.83532429 2.30192065 26.077018738 0.13720274 2.22073698 26.061613083 3.089810371 2.087224007 26.050437927
		 6.039363384 1.96852183 26.038618088 9.0040025711 1.83652306 26.032499313 11.97793388 1.60269213 26.046796799
		 14.96514034 1.42802334 26.06612587 17.97132874 1.38246477 26.088031769 20.98617172 1.52922249 26.1024971
		 23.99434662 1.85046136 26.10938454 27.00046920776 2.18514991 26.12220764 30.0091819763 2.39526701 26.14777565
		 33.022064209 2.5246017 26.17169762 36.038700104 2.48649216 26.1928463 39.045642853 2.2922554 26.20306206
		 42.076786041 2.077832937 26.20276642 45.13756943 1.84207356 26.20222855 48.18950272 1.60742426 26.1932621
		 51.19273758 1.57083964 26.17860794 54.14365768 1.54528069 26.16075325 57.067687988 1.44672441 26.14246941
		 59.98220444 1.26853025 26.12121964 62.88563156 0.99709183 26.098402023 65.771698 0.62518233 26.074169159
		 68.60415649 0.20026067 26.04552269 71.16486359 -0.043546297 26.0097026825 72.65823364 -0.14120583 25.99371719
		 -75 0.54753017 24;
	setAttr ".vt[664:829]" -72 0.97883946 24 -68.99876404 1.070817709 23.97013283
		 -65.98923492 1.042066574 23.96863937 -62.97094727 0.80309331 24.021373749 -59.96229935 0.40573344 24.099052429
		 -56.95624924 0.27069846 24.1301384 -53.91892242 0.30424517 24.15809441 -50.90401077 0.70572919 24.18205643
		 -47.90716171 1.12198913 24.2162838 -44.9059639 1.53550315 24.21887207 -41.88479996 2.053226471 24.188591
		 -38.85105133 2.39498019 24.18223572 -35.84534454 2.33077741 24.17994881 -32.90164185 2.078912497 24.16503525
		 -30.043100357 1.98015416 24.11168671 -27.24313736 2.39453077 24.00097465515 -24.35374832 3.11838913 23.80551147
		 -21.28185654 3.56215692 23.67933655 -18.16860771 3.82896876 23.63107681 -15.044500351 3.87821722 23.64928436
		 -11.93491936 3.71594453 23.71935844 -8.87693882 3.2799201 23.84745216 -5.86108828 2.59832501 24.004447937
		 -2.85747004 2.10501456 24.087989807 0.11791218 1.9326694 24.086128235 3.076734543 1.79749262 24.077796936
		 6.027839661 1.62443399 24.078107834 8.99397945 1.49193978 24.071111679 11.97386456 1.3854723 24.068798065
		 14.96336937 1.29438865 24.076560974 17.97008514 1.25302935 24.091440201 20.9933548 1.35170698 24.10517502
		 24.011161804 1.61581635 24.11116028 27.022491455 1.93735147 24.1179657 30.03263092 2.1601758 24.13892365
		 33.044033051 2.31390738 24.16347694 36.064647675 2.32646847 24.18792915 39.073890686 2.14382148 24.20748138
		 42.092346191 1.9976666 24.20989418 45.13581467 1.84691286 24.21194458 48.17446136 1.64697039 24.21055984
		 51.17279434 1.48874784 24.2034874 54.12492752 1.41341186 24.18644524 57.048130035 1.28841388 24.16631317
		 59.94701385 1.083246827 24.14379501 62.821064 0.79139864 24.11943245 65.65784454 0.42517811 24.093536377
		 68.39284515 0.037459608 24.065252304 70.80010986 -0.22791101 24.034877777 72.21269226 -0.33775491 24.018556595
		 -74.82440186 0.43404958 22.096895218 -71.99475098 0.21806581 22.18114853 -69.013816833 0.024661995 22.24089432
		 -65.99630737 -0.06761384 22.27019882 -62.97243881 -0.18287538 22.30467606 -59.94947052 -0.3024404 22.33370972
		 -56.91582108 -0.2172723 22.32055664 -53.87063217 0.066191636 22.28783226 -50.86330032 0.58410329 22.2841301
		 -47.8537674 1.015110731 22.30233192 -44.85890198 1.58514261 22.25339699 -41.85900497 2.19187427 22.17510033
		 -38.84724045 2.42991471 22.15061569 -35.85105515 2.32237744 22.1539402 -32.89860916 2.081155062 22.15628815
		 -30.0037593842 1.93151391 22.11933517 -27.12538147 2.13493061 22.00938797 -24.2217617 2.68509817 21.79924202
		 -21.20134354 2.99069762 21.67024231 -18.13964844 3.1721127 21.62973022 -15.05644989 3.21565461 21.65356445
		 -11.97246647 3.1397233 21.71692085 -8.91191006 3.029308796 21.79141235 -5.88260555 2.64011335 21.91398811
		 -2.878299 1.9943651 22.055826187 0.097241163 1.59315443 22.11504555 3.056767941 1.40575969 22.11856079
		 6.016421795 1.34199655 22.10006142 8.98542976 1.35551012 22.074699402 11.96811295 1.36629713 22.061397552
		 14.95836926 1.32555497 22.061796188 17.964077 1.23079383 22.071266174 20.99021339 1.22944891 22.08792305
		 24.018875122 1.39014566 22.10559654 27.035961151 1.67416525 22.11505127 30.04476738 1.93290246 22.12822342
		 33.054733276 2.14399433 22.14820099 36.08146286 2.24900174 22.17630196 39.096244812 2.092655182 22.20648575
		 42.10493088 1.96441603 22.21647453 45.13064575 1.82787979 22.22276688 48.15710449 1.62130797 22.23249054
		 51.15296936 1.38366508 22.23865128 54.10007095 1.24292123 22.22402382 57.011760712 1.079717636 22.20187187
		 59.88826752 0.85402465 22.17762375 62.72403336 0.56524515 22.15212822 65.49354553 0.21512108 22.1269474
		 68.13111877 -0.14051223 22.1008873 70.38642883 -0.40966216 22.075777054 71.70730591 -0.52860177 22.06061554
		 -74.2509613 -0.63299549 20.41597557 -71.8850174 -0.92906791 20.47140503 -68.99362946 -1.13555992 20.51709747
		 -65.98707581 -1.2178992 20.530159 -62.95879745 -1.21343112 20.50553513 -59.91019821 -1.10321403 20.45306015
		 -56.88008499 -0.53083938 20.31155396 -53.85144806 0.012562078 20.22646904 -50.82978439 0.48381934 20.23890877
		 -47.80926132 0.8905825 20.2555542 -44.8367424 1.5490365 20.17817879 -41.85480118 2.03425765 20.12717056
		 -38.86182404 2.18052483 20.11951637 -35.87514496 2.093893528 20.12980652 -32.91550064 1.90440178 20.13915443
		 -29.98110008 1.78236604 20.11812592 -27.048921585 1.84578884 20.0464077 -24.10049248 2.11347818 19.92110825
		 -21.12515831 2.42237377 19.78930092 -18.10845375 2.55510521 19.7358017 -15.061153412 2.64100456 19.72682953
		 -11.99936485 2.64819694 19.75305748 -8.94792175 2.63337255 19.7930851 -5.9207263 2.39757109 19.87805367
		 -2.91529393 1.91282904 19.99538422 0.071020871 1.39223862 20.10214424 3.040793419 1.31290019 20.10289574
		 6.0037865639 1.43122637 20.066522598 8.97215748 1.60251415 20.030456543 11.95320225 1.69897461 20.019584656
		 14.94075775 1.7073288 20.021354675 17.93787003 1.61766267 20.02412796 20.96129417 1.42653728 20.046520233
		 24.0066795349 1.30217445 20.085958481 27.037805557 1.43147898 20.11038208 30.046966553 1.72378385 20.11672974
		 33.054759979 1.99948752 20.12398911 36.084445953 2.1408298 20.14871216 39.10728073 2.0093853474 20.18856049
		 42.10963821 1.85069668 20.21268463 45.1197052 1.73082018 20.22418213 48.13730621 1.57554555 20.23734283
		 51.12628555 1.29915643 20.25679016 54.060958862 1.0072584152 20.26403427 56.95100403 0.7653178 20.24944687
		 59.7995491 0.52347958 20.22449684 62.58629227 0.24497086 20.1957283 65.28013611 -0.046160389 20.16447449
		 67.8031311 -0.33799538 20.13583374 69.89992523 -0.589674 20.1137104 71.099784851 -0.70921534 20.099092484
		 -73.57933044 -1.58208644 18.44089508 -71.63336945 -1.78075099 18.44831657 -68.90736389 -1.94119501 18.45381355
		 -65.9415741 -1.99040127 18.44075012 -62.91888428 -1.93533635 18.39717484 -59.89290237 -1.30464673 18.24691963
		 -56.89756393 -0.42170447 18.11327744 -53.86081696 0.11402175 18.078489304 -50.84584427 0.6391356 18.084177017
		 -47.82891846 1.027103066 18.11887741 -44.84259415 1.45382929 18.12239456 -41.86451721 1.7593329 18.12729263
		 -38.88140869 1.85653985 18.13980293 -35.90141678 1.81133115 18.15068817;
	setAttr ".vt[830:995]" -32.93075943 1.70560098 18.15192223 -29.96854019 1.61069 18.13700104
		 -27.0063323975 1.58443224 18.10270691 -24.036949158 1.68173981 18.044723511 -21.064195633 1.96641743 17.94877434
		 -18.071756363 2.056301117 17.89823151 -15.051152229 2.16271758 17.86359215 -12.0097179413 2.18991423 17.86221123
		 -8.97204208 2.11119771 17.89746094 -5.94790792 2.051674843 17.93365479 -2.93665981 1.89734781 17.98353386
		 0.054635141 1.66916275 18.037115097 3.024131298 1.60265625 18.047580719 5.98332119 1.69968688 18.031291962
		 8.94863129 1.83080268 18.018232346 11.93073082 1.91338444 18.020961761 14.92035866 1.94996345 18.029794693
		 17.91343689 1.91516757 18.028047562 20.92393875 1.78814733 18.029102325 23.97029495 1.55499697 18.051977158
		 27.022800446 1.3606509 18.090772629 30.044641495 1.49269855 18.10775757 33.049354553 1.77706337 18.10602379
		 36.075248718 1.89029706 18.12887764 39.094928741 1.71635401 18.1823616 42.093795776 1.50221026 18.22597122
		 45.092468262 1.35816061 18.24696541 48.094707489 1.21425033 18.25485039 51.075714111 1.022355318 18.26214218
		 54.0091171265 0.79369491 18.26933098 56.88742065 0.59557277 18.26116371 59.69779587 0.29171333 18.2465229
		 62.4271431 0.0029335953 18.21769524 65.029891968 -0.27450868 18.18020821 67.41751099 -0.5275926 18.14503098
		 69.35331726 -0.73084378 18.1191864 70.43041229 -0.84332693 18.1060009 -72.89086914 -2.19510579 16.29695511
		 -71.27575684 -2.29586315 16.27745056 -68.7335434 -2.38345408 16.23693466 -65.85677338 -2.43545985 16.19729614
		 -62.85944366 -2.16356921 16.14686394 -59.88516617 -1.19603419 16.060815811 -56.88824081 -0.40127242 16.019418716
		 -53.85007858 0.072368689 16.035205841 -50.8398819 0.5700478 16.068334579 -47.84947586 1.049366713 16.10375404
		 -44.85580826 1.30377698 16.13864326 -41.87578583 1.50816262 16.16508865 -38.89567184 1.59305394 16.18525124
		 -35.91594315 1.57652462 16.19561958 -32.93853378 1.50031257 16.19281006 -29.9643898 1.39905262 16.1849308
		 -26.98986626 1.3064338 16.17778778 -24.0071220398 1.29352331 16.16129875 -21.021406174 1.48527801 16.11743355
		 -18.039800644 1.73409033 16.065628052 -15.030832291 1.84275413 16.033760071 -12.005525589 1.80162501 16.027889252
		 -8.98062992 1.73702598 16.038379669 -5.96102095 1.77685046 16.039703369 -2.94852114 1.78961909 16.044513702
		 0.04429784 1.73015022 16.05389595 3.010959148 1.71521056 16.050735474 5.9645834 1.78409767 16.042329788
		 8.92700577 1.87848866 16.040121078 11.91179657 1.94662666 16.044811249 14.91167831 1.98608816 16.043369293
		 17.91184807 2.00010752678 16.024288177 20.91680717 1.97114968 15.99775219 23.95330429 1.75818336 15.99880505
		 27.012784958 1.32560813 16.053323746 30.045698166 1.19896281 16.098325729 33.040790558 1.4999938 16.098459244
		 36.059005737 1.546404 16.13177109 39.072868347 1.4212935 16.17725563 42.071311951 1.22125006 16.21717072
		 45.063812256 1.025084138 16.24065208 48.055671692 0.85781521 16.24705124 51.029026031 0.76978648 16.23789024
		 53.96096802 0.73489743 16.21939468 56.82698441 0.64556611 16.20210648 59.61761093 0.47833094 16.19057655
		 62.29352188 0.099404223 16.1844883 64.79727936 -0.37481612 16.17190742 67.043029785 -0.7389099 16.147995
		 68.81918335 -0.92449254 16.1170845 69.7766037 -1.0075457096 16.099210739 -72.23895264 -2.48509669 14.13691711
		 -70.87817383 -2.52596235 14.10563755 -68.50650024 -2.61268806 14.057906151 -65.71401978 -2.67577887 14.026501656
		 -62.79865265 -2.077626467 14.0052423477 -59.8597374 -1.091867924 13.99867344 -56.86571121 -0.42193204 14.0085353851
		 -53.84130478 -0.0030467091 14.045160294 -50.84413147 0.47570848 14.085371971 -47.86074829 0.92676818 14.12163639
		 -44.87262344 1.18335402 14.1564045 -41.88716125 1.28133869 14.19007015 -38.90546799 1.35407007 14.21164894
		 -35.92268753 1.36276281 14.2198925 -32.94244003 1.29708195 14.21875095 -29.96871758 1.14696908 14.223876
		 -26.99223518 0.93329501 14.24098492 -23.99883842 0.79938567 14.25126553 -21.0023670197 1.021443725 14.22258377
		 -18.029634476 1.52372468 14.16144848 -15.018170357 1.63130736 14.1589756 -12.0013008118 1.56252062 14.1649313
		 -8.98375988 1.51539421 14.17015648 -5.96431637 1.60326385 14.15865517 -2.94939756 1.66203594 14.14150906
		 0.045159847 1.65865767 14.12334442 3.010047197 1.65758502 14.10142994 5.96004581 1.72269285 14.077625275
		 8.92052555 1.81798768 14.057479858 11.91022873 1.87857783 14.040026665 14.92232513 1.89682019 14.013128281
		 17.93462563 1.90344751 13.97399235 20.93738556 1.89620185 13.93720341 23.95833588 1.73256516 13.94173431
		 27.01068306 1.28819132 14.0084810257 30.040594101 1.048387289 14.069116592 33.027133942 1.28019631 14.080956459
		 36.039173126 1.31794465 14.11243343 39.052230835 1.24479437 14.14880848 42.054420471 1.089056134 14.17890167
		 45.049556732 0.94687301 14.19176197 48.039665222 0.87172902 14.18625069 51.0018386841 0.80690992 14.18413258
		 53.91727448 0.68166077 14.18576527 56.76465607 0.50203115 14.1786375 59.52960587 0.38564071 14.14882565
		 62.17572784 0.1951192 14.12491226 64.61847687 -0.20749336 14.11967564 66.74616241 -0.65423435 14.11064911
		 68.38082886 -0.96489221 14.092126846 69.23167419 -1.11017299 14.080217361 -71.69050598 -2.54981494 12.045829773
		 -70.45916748 -2.58192015 12.025462151 -68.235466 -2.72321463 12.005692482 -65.56809235 -2.74973106 11.99817657
		 -62.72887421 -2.019222736 11.99786091 -59.82474518 -1.04244864 12.00050354004 -56.84389114 -0.45797744 12.020911217
		 -53.83982849 -0.04422972 12.052192688 -50.85443115 0.39837617 12.083747864 -47.87271881 0.7828567 12.11718178
		 -44.88986969 1.061528563 12.14841747 -41.90134048 1.11345065 12.18427277 -38.91569138 1.13889611 12.20842743
		 -35.92919922 1.13982987 12.21896076 -32.94943619 1.055641651 12.2231617 -29.98167038 0.79463959 12.24199486
		 -27.0058364868 0.3805097 12.27488327 -24.0044460297 0.14121427 12.2955246 -21.0005607605 0.4345628 12.27540684
		 -18.020368576 1.01462388 12.22606659 -15.02321434 1.42021167 12.2129612 -12.0058660507 1.40560663 12.24049091
		 -8.98738289 1.40160418 12.2542448 -5.96148443 1.51831675 12.2428627 -2.94000816 1.58461046 12.22066498
		 0.057583399 1.58410025 12.19174194 3.023727655 1.57677388 12.15791702;
	setAttr ".vt[996:1161]" 5.97231388 1.62430656 12.11678028 8.93214226 1.70381653 12.072691917
		 11.92227173 1.73806047 12.029583931 14.94627571 1.71587956 11.98693848 17.96721268 1.70832312 11.94275284
		 20.95941734 1.70670891 11.91106796 23.960989 1.65390682 11.9212904 27.014162064 1.30359173 11.98118496
		 30.038454056 0.95380145 12.038933754 33.016025543 1.047163486 12.057497978 36.019546509 1.12288547 12.082699776
		 39.032207489 1.11517 12.11049652 42.043983459 1.056932449 12.13196182 45.045070648 0.9966045 12.13733292
		 48.026119232 0.9016785 12.13657951 50.97500229 0.76912558 12.14734077 53.88237381 0.59027344 12.16152096
		 56.72526169 0.37908477 12.16387844 59.47542572 0.19031055 12.1431427 62.094146729 0.055322275 12.10106182
		 64.49237823 -0.19734836 12.071450233 66.55027771 -0.55539548 12.059444427 68.092903137 -0.90022069 12.052564621
		 68.86863708 -1.053620219 12.04592514 -71.30010223 -2.58006358 10.044271469 -70.13240814 -2.68116689 10.04848671
		 -68.053672791 -2.84682131 10.058367729 -65.45886993 -2.79048944 10.062667847 -62.6662941 -2.033280849 10.047312737
		 -59.7920723 -1.073422074 10.041612625 -56.83093262 -0.49936342 10.056031227 -53.84482956 -0.057010919 10.069126129
		 -50.86591339 0.33875483 10.084307671 -47.88876724 0.67584038 10.10806274 -44.90851593 0.93037182 10.1335001
		 -41.92120361 1.054843783 10.15851212 -38.93118668 0.96605331 10.18916512 -35.94372559 0.89812595 10.20991039
		 -32.96578979 0.74782902 10.22558594 -29.99901962 0.3795076 10.25000572 -27.019268036 -0.092711151 10.27904415
		 -24.014541626 -0.2640678 10.29305172 -21.0084228516 -0.0195513 10.28552818 -18.020679474 0.50878555 10.25693226
		 -15.033028603 1.07215929 10.2384901 -12.016194344 1.24462676 10.26830864 -8.9902153 1.30787492 10.28710651
		 -5.95369625 1.45638382 10.27755642 -2.92385578 1.5294255 10.25752163 0.078522287 1.52648973 10.23024559
		 3.046182871 1.50101876 10.19523716 5.99556684 1.51880884 10.15105057 8.95275116 1.56660008 10.10120678
		 11.94221783 1.57557952 10.053595543 14.96796989 1.56190836 10.0099315643 17.99490929 1.57398665 9.96789455
		 20.97466278 1.57943618 9.93261337 23.95656586 1.63086843 9.92417049 27.019195557 1.2521652 9.97238159
		 30.034591675 0.80671906 10.022753716 33.0077438354 0.83655566 10.040153503 36.0018196106 0.93896848 10.056588173
		 39.012691498 1.014343143 10.076107979 42.033172607 1.059389353 10.09359169 45.039108276 1.0070002079 10.10479069
		 48.012031555 0.82882237 10.11372566 50.95482635 0.64043093 10.12533188 53.86294174 0.47714373 10.13588238
		 56.70883942 0.29811072 10.1410408 59.4624176 0.11183644 10.13468742 62.074035645 -0.072370753 10.10858536
		 64.44911957 -0.30874458 10.068306923 66.46837616 -0.58180779 10.037491798 67.96711731 -0.86548525 10.021140099
		 68.70895386 -1.021419764 10.015900612 -71.14912415 -2.69084883 8.082970619 -70.03427124 -2.83746386 8.10337639
		 -67.94567871 -2.96554708 8.11813831 -65.38574982 -2.86671114 8.11827183 -62.60509109 -2.21856451 8.096987724
		 -59.76119614 -1.16580749 8.080945969 -56.82558441 -0.53090912 8.087722778 -53.85279846 -0.070773691 8.09534359
		 -50.88238525 0.32515979 8.098068237 -47.91259766 0.65604979 8.1046114 -44.93415833 0.89322269 8.11684132
		 -41.94313049 0.98680001 8.13479137 -38.95220184 0.83212066 8.16841602 -35.96870041 0.62560993 8.20646
		 -32.99023819 0.38588235 8.23206806 -30.016057968 0.001027124 8.25360394 -27.028978348 -0.37773603 8.27251053
		 -24.025218964 -0.47966921 8.28129387 -21.020324707 -0.34108016 8.28269863 -18.02844429 0.093618922 8.26611519
		 -15.038916588 0.65174198 8.25297928 -12.022527695 1.0059221983 8.27484703 -8.98799229 1.19868731 8.28965473
		 -5.94043732 1.36949277 8.28047562 -2.90316319 1.43687451 8.26301765 0.10374651 1.42568934 8.23899174
		 3.073514223 1.38410711 8.20757484 6.0220294 1.38270199 8.16795731 8.97261906 1.44317079 8.12493324
		 11.95396614 1.49306595 8.086231232 14.98051739 1.53148508 8.05359745 18.019447327 1.57668221 8.022287369
		 20.99261093 1.50929534 7.98899078 23.96257019 1.42263615 7.97156048 27.017749786 1.024870753 7.99546528
		 30.033946991 0.67004383 8.025354385 33.0039215088 0.66848427 8.036345482 35.98744202 0.76951778 8.043872833
		 38.99200058 0.92579406 8.05503273 42.016902924 1.050852656 8.073426247 45.027988434 0.99509037 8.094356537
		 48.0036277771 0.76431566 8.11060047 50.94929886 0.55546927 8.11636066 53.8598938 0.40780243 8.11636162
		 56.71011734 0.25745749 8.1173296 59.46607971 0.084701382 8.1180706 62.085399628 -0.084247679 8.11378098
		 64.46753693 -0.30019557 8.095824242 66.48600769 -0.58148706 8.06152916 67.98666382 -0.85672235 8.028680801
		 68.71904755 -0.99104345 8.015374184 -71.085136414 -2.76718044 6.049512863 -69.98401642 -2.97388577 6.058825493
		 -67.85987854 -3.032681227 6.062648296 -65.29162598 -2.83007693 6.056024551 -62.52125549 -2.37192988 6.057925224
		 -59.70927811 -1.32916403 6.069913387 -56.81284332 -0.59407538 6.087029934 -53.86758041 -0.064467087 6.10643148
		 -50.91560745 0.44056371 6.11155844 -47.94590378 0.76152992 6.10525274 -44.96194077 0.9426288 6.10513639
		 -41.96430206 0.97537923 6.11462736 -38.9694252 0.75044894 6.14672756 -35.99551392 0.32246429 6.20176077
		 -33.014644623 -0.017705521 6.23201656 -30.029640198 -0.3458119 6.24779797 -27.037071228 -0.567581 6.25878286
		 -24.035539627 -0.63380933 6.26690197 -21.03134346 -0.54293036 6.27198076 -18.035356522 -0.24656138 6.26582098
		 -15.042560577 0.23230189 6.25798178 -12.018232346 0.66641444 6.2781086 -8.97850323 1.02763927 6.28159952
		 -5.92207432 1.2265631 6.27326012 -2.87739277 1.29192865 6.2598238 0.13255371 1.27968752 6.24015284
		 3.10480547 1.25836468 6.21160507 6.048324108 1.28601968 6.17636967 8.98859978 1.36112154 6.14099026
		 11.95813656 1.46409571 6.10858154 14.9806509 1.60946321 6.081818104 18.023895264 1.60116971 6.066269875
		 21.0016002655 1.40813923 6.055592537 23.97346306 1.17008483 6.048307896 27.018032074 0.77981752 6.047734261
		 30.034156799 0.5705089 6.049299717 33.004776001 0.56899965 6.049248219 35.9789238 0.64704055 6.046730995
		 38.97435379 0.85825372 6.049650192 41.99571991 1.050066352 6.06588459;
	setAttr ".vt[1162:1327]" 45.012393951 0.99854732 6.092639446 47.99998856 0.76462907 6.1117444
		 50.9568634 0.54763454 6.11449146 53.87298203 0.39078668 6.10730886 56.72784424 0.25394335 6.10160685
		 59.48817825 0.10155978 6.10136509 62.096736908 -0.065409556 6.10350275 64.49319458 -0.25042596 6.10365152
		 66.55957031 -0.44849324 6.094819069 68.094367981 -0.71735913 6.065723896 68.8462677 -0.87151092 6.043452263
		 -70.67030334 -2.51512027 3.87146235 -69.61991882 -2.63010812 3.87391281 -67.62194824 -2.64952064 3.89378428
		 -65.1568222 -2.59227562 3.91162825 -62.43215561 -2.48656917 3.92931581 -59.63157654 -1.65894735 3.99081135
		 -56.78787613 -0.72766316 4.05274868 -53.90764999 0.076049142 4.083235264 -50.95691681 0.59523356 4.095845222
		 -47.97755051 0.91040874 4.088440895 -44.97972488 1.011193752 4.085129261 -41.97500992 0.87490934 4.099368572
		 -38.97702789 0.56791443 4.13028002 -36.0085258484 0.036756624 4.18230009 -33.026851654 -0.311854 4.20482349
		 -30.038385391 -0.51927972 4.21704054 -27.045434952 -0.65045178 4.22967529 -24.045396805 -0.72267234 4.243855
		 -21.040605545 -0.69750619 4.25629187 -18.039157867 -0.52549696 4.26101446 -15.038755417 -0.20213188 4.2606163
		 -12.0073490143 0.22870862 4.27737379 -8.96334743 0.72810173 4.27223778 -5.90112877 1.015834212 4.26710176
		 -2.85123563 1.12304711 4.26144743 0.16240837 1.14142072 4.25120974 3.13640308 1.15015447 4.23140192
		 6.076503277 1.18806314 4.2030282 9.0058164597 1.26674187 4.17089558 11.96407318 1.41498041 4.13219357
		 14.98641109 1.49579084 4.096718788 18.018119812 1.42669225 4.073796749 20.99694824 1.20189536 4.069655895
		 23.97291183 0.97191685 4.072506905 27.012371063 0.68804961 4.069668293 30.032585144 0.64009684 4.069608212
		 33.0098457336 0.64352554 4.063456535 35.97869492 0.64283985 4.051213741 38.96308899 0.81832933 4.049020767
		 41.97535324 1.026331544 4.063734055 44.99464417 1.012736201 4.091087818 47.99805069 0.81763262 4.11171865
		 50.97313309 0.61357647 4.11619949 53.90208054 0.44741738 4.10782528 56.76707458 0.3135657 4.097178936
		 59.53668594 0.18547276 4.091761112 62.16452789 0.041582201 4.091766357 64.5703125 -0.12424743 4.092371941
		 66.65070343 -0.32337251 4.087119102 68.24838257 -0.54790217 4.069831848 69.044029236 -0.71604896 4.049305439
		 -70.32334137 -2.13294959 1.71901047 -69.36129761 -2.22908497 1.71044993 -67.45137024 -2.2994864 1.73147893
		 -65.054695129 -2.3208828 1.75559008 -62.38327789 -2.29738474 1.78489935 -59.5585556 -2.017230749 1.85087502
		 -56.75654984 -1.021395087 1.94978225 -53.93115616 0.032693751 1.98052132 -51.0042953491 0.72821277 2.0099511147
		 -48.00045776367 0.99620962 2.01852107 -44.98338699 0.99039203 2.034609079 -41.97081757 0.71926212 2.069869995
		 -38.97367859 0.30002448 2.11741614 -35.99613571 -0.077635176 2.14711356 -33.029361725 -0.37643349 2.16154099
		 -30.045957565 -0.51879883 2.17056489 -27.054664612 -0.62850016 2.18697858 -24.055967331 -0.73582494 2.21069002
		 -21.050226212 -0.79547411 2.23351336 -18.042739868 -0.7205162 2.24932098 -15.028675079 -0.57961899 2.26139522
		 -11.99674892 -0.27197468 2.26915526 -8.94835949 0.24384868 2.26508379 -5.87931681 0.63610631 2.27076197
		 -2.82611156 0.84383625 2.27224731 0.19031413 0.94613796 2.26912022 3.16887498 1.021871924 2.25454021
		 6.11149263 1.044694424 2.22895265 9.036435127 1.0036963224 2.20464635 12.0030479431 0.95598394 2.16961098
		 15.015352249 0.95308435 2.11942434 18.023792267 0.88645321 2.084568024 21.0015163422 0.73788291 2.069843769
		 23.98726654 0.60393488 2.066367865 27.014472961 0.61553311 2.068428993 30.034313202 0.74663937 2.068395615
		 33.020141602 0.78485113 2.05892396 35.98522186 0.70071346 2.044823647 38.95998001 0.78910434 2.041996002
		 41.96004105 1.0046494007 2.05841732 44.97974777 1.054719567 2.086430788 47.99827957 0.94810045 2.10919785
		 50.99481583 0.77283955 2.11635065 53.94342041 0.60069484 2.10842943 56.82567215 0.45960209 2.094019651
		 59.61307907 0.33803976 2.082814217 62.27140808 0.2090884 2.077406168 64.71677399 0.043708462 2.073070049
		 66.83568573 -0.19954479 2.0602808 68.45106506 -0.51438111 2.034319401 69.25857544 -0.71957618 2.015892267
		 -70.18611908 -1.73097146 -0.35287037 -69.24676514 -1.8451277 -0.3745648 -67.36710358 -1.98069537 -0.37204432
		 -65.01638031 -2.058947086 -0.35993049 -62.36785126 -2.033216 -0.32211986 -59.56235886 -1.83521378 -0.25008839
		 -56.72830963 -1.23916936 -0.16262907 -53.93813705 -0.15691151 -0.13625178 -51.032611847 0.69473732 -0.13194415
		 -48.0093612671 0.91652715 -0.076990403 -44.98025513 0.87109375 -0.020964844 -41.95853806 0.60152 0.042795777
		 -38.95563126 0.21628693 0.1065371 -35.99076462 -0.12801716 0.13428707 -33.033172607 -0.3021245 0.12824565
		 -30.052997589 -0.48049918 0.12853684 -27.063421249 -0.60476404 0.14140348 -24.06710434 -0.70238048 0.16650772
		 -21.060873032 -0.80692637 0.19755571 -18.050081253 -0.82184017 0.21967718 -15.030857086 -0.73362279 0.23340687
		 -11.99514389 -0.59342128 0.24126254 -8.93732262 -0.37857273 0.24581544 -5.8654809 -0.024186805 0.25421315
		 -2.80838108 0.35528398 0.26118162 0.21253079 0.59123266 0.25272271 3.20047045 0.59260297 0.24907328
		 6.15368319 0.3975454 0.2441614 9.098417282 0.11976379 0.21362567 12.065418243 0.05973867 0.17347869
		 15.050337791 0.13774875 0.13260539 18.038520813 0.2313675 0.096680865 21.021413803 0.25874615 0.074267603
		 24.010643005 0.36574906 0.063524097 27.019773483 0.625597 0.062452383 30.042602539 0.74103338 0.059535958
		 33.03238678 0.75300753 0.047965791 35.99311829 0.74928117 0.034541953 38.96116257 0.75903511 0.029097229
		 41.95293427 0.99043816 0.044986878 44.97048569 1.15107274 0.072562516 48.00020980835 1.14176452 0.095684379
		 51.014636993 1.015594959 0.10575139 53.98458481 0.84049249 0.099101633 56.88510895 0.6774857 0.081853583
		 59.70289612 0.53855968 0.065247066 62.39395523 0.40069461 0.056319565 64.8874054 0.20146509 0.050222654
		 67.058334351 -0.15080667 0.031994916 68.72529602 -0.57581514 0.0016677091 69.54756927 -0.78077233 -0.012786586
		 -70.20191956 -1.32422638 -2.33956122 -69.25668335 -1.4564594 -2.36813712;
	setAttr ".vt[1328:1493]" -67.39968872 -1.66808331 -2.39777184 -65.030670166 -1.77330828 -2.40028191
		 -62.38589859 -1.73200703 -2.36702585 -59.58589935 -1.55366063 -2.30089712 -56.76635361 -0.85059971 -2.17815351
		 -53.93855667 -0.014381113 -2.11812329 -51.010726929 0.54645038 -2.10983062 -48.013633728 0.77343947 -2.07741785
		 -44.99066162 0.76528698 -2.011409044 -41.95783615 0.63817948 -1.94611073 -38.93490219 0.34961405 -1.89274466
		 -35.98158264 -0.084150456 -1.88734341 -33.033245087 -0.26081756 -1.90059388 -30.055028915 -0.45310321 -1.90512276
		 -27.067111969 -0.58226418 -1.89803338 -24.076007843 -0.67850012 -1.88094246 -21.074077606 -0.77710211 -1.85361576
		 -18.058294296 -0.85524863 -1.82767677 -15.036502838 -0.82642442 -1.81394911 -11.99899101 -0.74016261 -1.80835438
		 -8.94091225 -0.5565334 -1.81078649 -5.86590004 -0.47450414 -1.80526435 -2.79916596 -0.41878566 -1.79823041
		 0.2365195 -0.3444314 -1.79465449 3.22668171 -0.28178486 -1.79776061 6.18491745 -0.21889697 -1.81014121
		 9.12399197 -0.11938535 -1.83488524 12.078924179 0.013516841 -1.86361599 15.060027122 0.071461648 -1.88902807
		 18.047805786 0.074807055 -1.90962064 21.035488129 0.12876202 -1.9254775 24.027900696 0.29841688 -1.93575144
		 27.033475876 0.57802606 -1.93984079 30.051345825 0.74428493 -1.94410241 33.042133331 0.77798724 -1.95353711
		 36.00081634521 0.81901449 -1.96599782 38.96310043 0.82492083 -1.98080242 41.95111847 0.99443054 -1.97415745
		 44.9659996 1.21707356 -1.95127273 47.99927521 1.31168461 -1.92741609 51.026424408 1.26356363 -1.91214347
		 54.016651154 1.11343133 -1.91447723 56.94496536 0.92450738 -1.93429077 59.78812408 0.74146217 -1.95809865
		 62.50942612 0.55710596 -1.97263467 65.041992188 0.27838117 -1.98221505 67.27532959 -0.18937659 -2.0037794113
		 68.99320221 -0.56106037 -2.023630857 69.82315826 -0.7099781 -2.032833099 -70.30705261 -0.95380551 -4.28414917
		 -69.33343506 -1.081228733 -4.30774975 -67.46072388 -1.30120718 -4.34705305 -65.086181641 -1.44324315 -4.36965466
		 -62.4303894 -1.42214274 -4.35510731 -59.62292099 -1.28767586 -4.30940056 -56.80253601 -0.54305142 -4.1766572
		 -53.94371796 0.2401441 -4.066478252 -51.0018882751 0.66425604 -4.015855312 -48.026737213 0.86963755 -3.98154259
		 -45.017250061 0.8900705 -3.94767213 -41.96691895 0.90131211 -3.91118789 -38.91244507 0.62964088 -3.89344049
		 -35.97041702 0.048241429 -3.90794396 -33.026626587 -0.20598508 -3.91911244 -30.047634125 -0.34391871 -3.92317581
		 -27.061420441 -0.46907169 -3.9226985 -24.074398041 -0.57339883 -3.91576767 -21.080974579 -0.7327109 -3.90291905
		 -18.069749832 -0.92908597 -3.88535428 -15.045042992 -0.9798454 -3.87022662 -12.0051212311 -0.93913043 -3.86281753
		 -8.94506264 -0.78543907 -3.86767197 -5.87042093 -0.66094023 -3.87198281 -2.80206203 -0.59941518 -3.87403774
		 0.23538351 -0.50879681 -3.87072158 3.22881246 -0.36819708 -3.87055254 6.18949652 -0.2785528 -3.87956262
		 9.13219929 -0.18609111 -3.89587617 12.081476212 -0.084260352 -3.9100008 15.057398796 -0.011026209 -3.91338611
		 18.04732132 0.0021929666 -3.91571331 21.042741776 0.080472633 -3.92281485 24.041255951 0.26091027 -3.93204832
		 27.04573822 0.56763327 -3.9411087 30.060819626 0.7700395 -3.94905066 33.049186707 0.84084904 -3.95718098
		 36.0074615479 0.92667592 -3.96662331 38.96829605 1.0094789267 -3.97867632 41.9487915 1.082852602 -3.9919138
		 44.96378708 1.21932566 -3.98248816 47.99763489 1.36160398 -3.9594214 51.03295517 1.4241364 -3.93589807
		 54.04384613 1.35428905 -3.92975259 57.002822876 1.16596627 -3.94843221 59.86624146 0.90897506 -3.9795208
		 62.61481857 0.6238696 -4.0056118965 65.19274139 0.24472255 -4.026219368 67.48896027 -0.22087011 -4.048879623
		 69.24887848 -0.49122712 -4.062483788 70.16117859 -0.61128438 -4.068561077 -70.42710114 -0.62544721 -6.23142529
		 -69.44936371 -0.72017652 -6.2416811 -67.53870392 -0.91732788 -6.27070284 -65.14342499 -1.056478143 -6.29262066
		 -62.4756546 -1.057020068 -6.28906727 -59.66220093 -0.97688061 -6.26553822 -56.83044815 -0.29227948 -6.14922905
		 -53.95999146 0.4872348 -6.040155411 -51.0067253113 0.86704326 -5.979918 -48.033638 1.022820234 -5.94587517
		 -45.035522461 1.080509305 -5.91987514 -41.97667694 1.18025613 -5.8963666 -38.90376663 0.88641149 -5.90069818
		 -35.97200012 0.22688019 -5.93068409 -33.021461487 -0.047546815 -5.93873692 -30.035896301 -0.15358065 -5.93754339
		 -27.046443939 -0.23501019 -5.93640041 -24.061927795 -0.34683806 -5.94016314 -21.079378128 -0.58475935 -5.94687033
		 -18.084280014 -0.9342559 -5.94813728 -15.064943314 -1.18017328 -5.9341774 -12.021752357 -1.27084839 -5.91697693
		 -8.95604706 -1.13227081 -5.9094882 -5.87686872 -0.99752301 -5.91654444 -2.80520082 -0.9274388 -5.92683411
		 0.23170276 -0.73498291 -5.92721319 3.22577596 -0.47659364 -5.93121386 6.18845654 -0.33724752 -5.94202328
		 9.13033676 -0.24556123 -5.95166636 12.073264122 -0.14008911 -5.95052958 15.041708946 -0.0058274688 -5.93374157
		 18.035963058 0.060631208 -5.92240858 21.041500092 0.13246004 -5.92285061 24.048379898 0.2803987 -5.93149424
		 27.055145264 0.55794716 -5.94138813 30.068189621 0.76734489 -5.94895077 33.057891846 0.86930984 -5.95725918
		 36.015163422 0.99139357 -5.97028732 38.97515869 1.12334764 -5.98555279 41.95513916 1.21920264 -6.00024414063
		 44.95994186 1.25769973 -6.011802197 47.99186707 1.30968547 -5.99747896 51.034221649 1.45848215 -5.96597338
		 54.061847687 1.48424828 -5.94987297 57.043296814 1.32839119 -5.96280909 59.93774033 1.015133619 -5.99810219
		 62.7206459 0.60018313 -6.039073467 65.36106873 0.11760896 -6.074687004 67.7427063 -0.20178878 -6.094347
		 69.6136322 -0.39521006 -6.10542679 70.51755524 -0.480452 -6.10818863 -70.65066528 -0.35004005 -8.20323467
		 -69.5797348 -0.41096824 -8.1984272 -67.67460632 -0.56307429 -8.20450878 -65.22451782 -0.69890422 -8.21491718
		 -62.53164291 -0.69813854 -8.21116638 -59.70436096 -0.61461002 -8.19679546 -56.84630966 -0.10950272 -8.12821293
		 -53.97349167 0.66972083 -8.040096283 -51.01732254 1.060855865 -7.9794488 -48.038818359 1.20582116 -7.94600916
		 -45.041816711 1.24604559 -7.93292809 -41.99172211 1.28315711 -7.93221569 -38.92777634 1.0093694925 -7.94752073
		 -35.98361206 0.42157125 -7.97105265 -33.01631546 0.19881958 -7.97127676;
	setAttr ".vt[1494:1659]" -30.021213531 0.12017862 -7.96280193 -27.025354385 0.085071713 -7.95654821
		 -24.042005539 -0.016082712 -7.96279812 -21.070459366 -0.31466705 -7.9868269 -18.096078873 -0.77114171 -8.012261391
		 -15.090051651 -1.060708046 -8.0080442429 -12.047872543 -1.092158794 -7.98550892 -8.97839451 -1.1487633 -7.97934437
		 -5.89138126 -1.17808414 -7.98647642 -2.80859709 -1.091555357 -7.99893522 0.22465925 -0.7545861 -7.99418402
		 3.21817684 -0.45111778 -7.99586582 6.17777491 -0.27485546 -8.0061779022 9.11534405 -0.15808564 -8.0060310364
		 12.052353859 -0.04615055 -7.99333048 15.017547607 0.12310252 -7.96416759 18.01723671 0.2000525 -7.94534492
		 21.031587601 0.22981331 -7.94082737 24.045900345 0.32476693 -7.94042778 27.056783676 0.55445969 -7.9403367
		 30.070304871 0.78259689 -7.94135714 33.06470871 0.90295243 -7.95063257 36.024528503 1.026574731 -7.9708004
		 38.97894669 1.18370664 -7.99152565 41.95372772 1.32300913 -8.0020303726 44.95746231 1.39886045 -8.0031051636
		 47.98293304 1.4274447 -7.99932957 51.030532837 1.52696431 -7.97751951 54.075218201 1.5560081 -7.96286201
		 57.074817657 1.38404715 -7.97745609 59.99217606 1.013626814 -8.018983841 62.81590652 0.52630097 -8.072588921
		 65.53796387 0.16494279 -8.10688496 67.97188568 -0.02451485 -8.11888409 69.92171478 -0.18264526 -8.12758923
		 70.92021942 -0.25637344 -8.13034821 -70.85791779 -0.16539165 -10.18311787 -69.75443268 -0.20430161 -10.17202568
		 -67.7759552 -0.30951691 -10.1592865 -65.32508087 -0.4168579 -10.15329552 -62.59857559 -0.41129875 -10.1453495
		 -59.74769974 -0.31892008 -10.13875198 -56.85583115 0.0078471275 -10.11999321 -53.9790802 0.74889565 -10.058145523
		 -51.028347015 1.2146914 -9.99670315 -48.039478302 1.39347148 -9.96914673 -45.038936615 1.3924036 -9.97907829
		 -42.01153183 1.28983116 -10.0054521561 -38.9690094 1.027894258 -10.022578239 -36.0024986267 0.59358257 -10.023768425
		 -33.013557434 0.45972496 -10.012105942 -30.0055828094 0.43571401 -9.99754429 -27.0054759979 0.41478801 -9.9889307
		 -24.025259018 0.29893622 -9.9979229 -21.06436348 -0.032176368 -10.034250259 -18.10805702 -0.53204536 -10.080723763
		 -15.11069489 -0.79121065 -10.083029747 -12.070943832 -0.86505771 -10.068491936 -8.99858475 -0.99601775 -10.077480316
		 -5.90398645 -1.08082509 -10.099167824 -2.82396388 -0.90125108 -10.1027422 0.2194874 -0.64598542 -10.10492325
		 3.21196818 -0.36791489 -10.10365963 6.16137695 -0.14081667 -10.095079422 9.092953682 0.018201293 -10.079114914
		 12.02659893 0.12862296 -10.056918144 14.99058342 0.30442134 -10.015374184 17.99427605 0.36031806 -9.98925209
		 21.012823105 0.34669453 -9.97650433 24.032409668 0.39798799 -9.96566486 27.048604965 0.58046365 -9.95558262
		 30.064050674 0.82075459 -9.94974518 33.065673828 0.96335286 -9.95630455 36.030517578 1.075616002 -9.97655678
		 38.97898865 1.24275088 -9.9960947 41.94402695 1.43160224 -9.99917412 44.94609833 1.57465029 -9.98943996
		 47.9782486 1.63174713 -9.98246479 51.030471802 1.686432 -9.97524166 54.089939117 1.66436553 -9.97585201
		 57.097633362 1.42049468 -10.0014514923 60.030956268 1.027588487 -10.048477173 62.90408707 0.66543162 -10.092482567
		 65.66553497 0.45170423 -10.11257362 68.19632721 0.29823309 -10.11966133 70.26296234 0.16219094 -10.12491035
		 71.38011932 0.085693255 -10.12766457 -71.061752319 -0.019513601 -12.13884449 -69.95927429 -0.058753029 -12.13104248
		 -67.94941711 -0.15344165 -12.1187973 -65.45480347 -0.24899486 -12.1057291 -62.68915939 -0.26031834 -12.09420681
		 -59.79473495 -0.18848301 -12.096889496 -56.85480499 -0.018277597 -12.1137991 -53.96736145 0.7244463 -12.080528259
		 -51.026176453 1.28687286 -12.045061111 -48.030170441 1.5000006 -12.039415359 -45.029525757 1.43157613 -12.062701225
		 -42.042396545 1.12446523 -12.089665413 -39.027053833 0.89518541 -12.10383606 -36.022464752 0.72076857 -12.077647209
		 -33.0080413818 0.72132611 -12.055860519 -29.99096107 0.76987755 -12.037537575 -26.99122429 0.76090574 -12.029443741
		 -24.018215179 0.59958172 -12.04608345 -21.070016861 0.21068443 -12.098021507 -18.12233543 -0.28115797 -12.15832043
		 -15.12594604 -0.49759832 -12.16493797 -12.090273857 -0.63115424 -12.16480541 -9.01548481 -0.79355109 -12.18301868
		 -5.92238569 -0.74816102 -12.18686485 -2.84622788 -0.56850463 -12.18887997 0.19401616 -0.30542031 -12.18797112
		 3.18634963 -0.021278461 -12.18415642 6.13358259 0.20367105 -12.1723547 9.066786766 0.24481854 -12.16431141
		 12.0024414063 0.28168726 -12.14179611 14.96565342 0.4629716 -12.085907936 17.96938705 0.5184322 -12.048675537
		 20.988657 0.47479343 -12.028877258 24.013179779 0.49166051 -12.010885239 27.036571503 0.6297406 -11.99546337
		 30.055137634 0.87459928 -11.98521423 33.059700012 1.041955709 -11.98787594 36.027206421 1.17004514 -11.99944973
		 38.97231674 1.35811067 -12.0086421967 41.93091583 1.59682095 -12.0033168793 44.93239212 1.79015934 -11.99195385
		 47.9732132 1.84899282 -11.99369717 51.037002563 1.89422691 -11.99652863 54.10622787 1.89654803 -12.0015249252
		 57.12902069 1.68051255 -12.028081894 60.074863434 1.32456589 -12.071107864 62.97790527 1.02204299 -12.1055088
		 65.7855835 0.84287286 -12.11477089 68.39209747 0.70289171 -12.1141119 70.57828522 0.5701189 -12.11280346
		 71.81201935 0.46376845 -12.11414814 -71.33892059 -0.021599105 -14.10907078 -70.246521 -0.012635997 -14.093104362
		 -68.19174194 -0.07839863 -14.079201698 -65.63280487 -0.20953621 -14.065825462 -62.81189728 -0.32161275 -14.05038929
		 -59.84351349 -0.19782777 -14.049608231 -56.86312485 0.067180455 -14.069046021 -53.93390274 0.56946743 -14.08889389
		 -51.0017318726 1.12918282 -14.11088085 -48.016841888 1.35519564 -14.12912369 -45.028873444 1.24714208 -14.14050961
		 -42.063346863 0.9142915 -14.14613819 -39.075119019 0.62207174 -14.15292454 -36.032333374 0.71445704 -14.13229561
		 -32.9914093 0.843701 -14.10913277 -29.96978188 0.97735959 -14.094088554 -26.97880936 0.99438441 -14.089935303
		 -24.018602371 0.80806369 -14.11143017 -21.078577042 0.42163321 -14.16289711 -18.1265564 0.051504087 -14.20920086
		 -15.13272285 -0.12170555 -14.21620369 -12.099476814 -0.27866098 -14.22100449 -9.027098656 -0.39512822 -14.23180676
		 -5.94107628 -0.36152279 -14.23502254 -2.87294316 -0.18778275 -14.23372936 0.16419229 0.072849222 -14.23209763
		 3.15558195 0.35722724 -14.22585106 6.10674763 0.57950467 -14.21910477;
	setAttr ".vt[1660:1825]" 9.041539192 0.65855831 -14.21268654 11.98381329 0.62528181 -14.19684887
		 14.9498024 0.67588711 -14.15369034 17.94684219 0.66898638 -14.11657906 20.96584892 0.60227239 -14.093668938
		 23.9956398 0.58458269 -14.074654579 27.028665543 0.67918259 -14.058745384 30.050844193 0.88922405 -14.048753738
		 33.050811768 1.095379472 -14.046830177 36.015102386 1.29017627 -14.04384613 38.95867157 1.53161931 -14.036920547
		 41.91582108 1.81125021 -14.024558067 44.91993713 2.042773008 -14.017868042 47.97031403 2.12798834 -14.03086853
		 51.043201447 2.17557693 -14.042285919 54.11691666 2.17619491 -14.046177864 57.14991379 2.033286095 -14.05799675
		 60.12009811 1.74357438 -14.087228775 63.041885376 1.42304075 -14.1197834 65.89215851 1.24713337 -14.11998081
		 68.58931732 1.098045707 -14.11124802 70.90390015 0.91299486 -14.10554886 72.36171722 0.73822343 -14.10469818
		 -71.67679596 0.0015224121 -16.16109657 -70.53636932 -0.026730638 -16.13500404 -68.41553497 -0.049118463 -16.088195801
		 -65.78337097 -0.16589864 -16.058115005 -62.90526581 -0.26721823 -16.028499603 -59.87752151 -0.20772523 -16.021627426
		 -56.86220551 0.10156927 -16.047296524 -53.91345215 0.43062475 -16.076400757 -50.97381973 0.68896514 -16.10635185
		 -48.0088615417 0.91643107 -16.12965775 -45.039505005 0.85775262 -16.12897873 -42.083080292 0.61226732 -16.13327026
		 -39.081684113 0.45277661 -16.15049553 -36.019359589 0.47466084 -16.1685009 -32.95100784 0.72433251 -16.15886688
		 -29.92889595 0.93485886 -16.15037918 -26.95988846 1.0078033209 -16.15291023 -24.02180481 0.85470027 -16.17542076
		 -21.085624695 0.59277827 -16.20511055 -18.12660599 0.42464927 -16.21673584 -15.13943958 0.29707691 -16.21883583
		 -12.11040497 0.10403433 -16.23331833 -9.038578987 -0.030156046 -16.24528313 -5.9577136 0.0029301574 -16.24403572
		 -2.89841723 0.17834441 -16.23496246 0.13365811 0.44127196 -16.22627068 3.12884903 0.74707389 -16.22003555
		 6.086672306 0.99090606 -16.22266197 9.028536797 1.095251679 -16.22636986 11.97909737 1.06356132 -16.22546959
		 14.94569778 1.022792697 -16.20094109 17.93936157 0.99915981 -16.15846825 20.95006943 0.82748544 -16.14574242
		 23.98238754 0.6884985 -16.13862801 27.029542923 0.69873691 -16.12781525 30.060705185 0.8297922 -16.12358665
		 33.053108215 1.053330302 -16.12560844 36.0073661804 1.35524213 -16.10793495 38.94698715 1.71978772 -16.081548691
		 41.89794159 2.1294117 -16.049417496 44.90585709 2.39527845 -16.043178558 47.96475601 2.40829611 -16.077308655
		 51.047702789 2.39226604 -16.10020256 54.12638474 2.42477751 -16.094758987 57.16480255 2.34727359 -16.091802597
		 60.15307236 2.12764287 -16.10874176 63.096317291 1.84511697 -16.125597 65.9813385 1.63431609 -16.12206841
		 68.7378006 1.42883039 -16.11316299 71.24874115 1.14839184 -16.10774803 72.95204926 0.84814298 -16.10158157
		 -71.65858459 0.33241904 -18.26200867 -70.60779572 0.26008588 -18.2579937 -68.52233124 0.15251653 -18.21568298
		 -65.89795685 0.022960022 -18.15888786 -62.99492264 -0.14774744 -18.10220528 -59.89693451 -0.15146558 -18.073484421
		 -56.84782791 0.18019429 -18.087018967 -53.92036438 0.34441999 -18.09932518 -50.96915054 0.42321265 -18.10719109
		 -47.99425507 0.5563063 -18.11494827 -45.040718079 0.70369554 -18.11915207 -42.097446442 0.67662591 -18.12350655
		 -39.085300446 0.51065028 -18.140625 -35.99221802 0.46237147 -18.16625023 -32.88684082 0.61209625 -18.18879128
		 -29.86843109 0.89238322 -18.19267845 -26.93656158 1.054192424 -18.20086098 -24.024869919 0.97996742 -18.22028351
		 -21.089406967 0.8519268 -18.22627449 -18.13603783 0.72375524 -18.2253952 -15.17150307 0.53680342 -18.23829079
		 -12.14768696 0.26579377 -18.26463127 -9.056237221 0.12963982 -18.26864815 -5.96790218 0.20951122 -18.25055885
		 -2.91484308 0.41281059 -18.22452927 0.11897104 0.69614816 -18.19994354 3.12177515 1.065054774 -18.18513489
		 6.083944321 1.37370276 -18.19183731 9.031155586 1.49668503 -18.20612144 11.99196339 1.49019098 -18.21577644
		 14.96024799 1.4095614 -18.21888351 17.93681145 1.35429049 -18.18291664 20.93263626 1.10509133 -18.16917801
		 23.96975899 0.86018884 -18.16766739 27.034669876 0.83771706 -18.15983582 30.070861816 1.0070854425 -18.15894318
		 33.04706192 1.20419502 -18.18226242 35.98452759 1.62894356 -18.13157463 38.93069839 2.017458439 -18.09885025
		 41.88453674 2.3937459 -18.07890892 44.87906647 2.65358138 -18.072027206 47.94607162 2.50500154 -18.12184715
		 51.050662994 2.47851467 -18.13868523 54.1419487 2.62529492 -18.12072563 57.18387604 2.64457417 -18.10909271
		 60.17865372 2.44746733 -18.11870384 63.13882065 2.21506 -18.12059593 66.037109375 1.95216691 -18.12164497
		 68.8404007 1.68786108 -18.12440681 71.43483734 1.36238289 -18.11360168 73.33299255 0.95155174 -18.086101532
		 -71.71028137 0.73201066 -20.20803833 -70.6042099 0.70197511 -20.20890427 -68.53244781 0.60864329 -20.19837379
		 -65.91806793 0.45695621 -20.17695045 -63.019412994 0.23982055 -20.1523056 -59.92313766 0.14338833 -20.1482296
		 -56.86531448 0.50509822 -20.17602348 -53.94831467 0.6398257 -20.18486595 -50.98376083 0.72068471 -20.19038963
		 -47.99544144 0.84265482 -20.20010376 -45.042064667 1.033927321 -20.1788044 -42.11578751 1.026599884 -20.16379166
		 -39.087238312 0.75947332 -20.16973686 -35.97119904 0.72269708 -20.18723488 -32.85318375 0.94329083 -20.20333672
		 -29.83763123 1.41435766 -20.19510651 -26.93892479 1.60897672 -20.21011734 -24.031705856 1.54688847 -20.22602272
		 -21.080762863 1.43125236 -20.21699142 -18.12427902 1.24209392 -20.22081757 -15.20475388 0.96254802 -20.25961876
		 -12.21254826 0.48902935 -20.31254005 -9.076448441 0.16269009 -20.32044983 -5.95815802 0.22573894 -20.28429222
		 -2.92022324 0.44031638 -20.2340889 0.12952808 0.71931905 -20.18432236 3.15934181 1.19798994 -20.15151596
		 6.10833359 1.6306107 -20.15001678 9.041712761 1.74607193 -20.15278435 12.0088319778 1.74497104 -20.14429283
		 14.98345375 1.71590948 -20.1340332 17.94307709 1.66289425 -20.11927986 20.90221786 1.3608278 -20.11629295
		 23.94485283 0.97171587 -20.12641144 27.043783188 0.9792825 -20.11115837 30.075864792 1.32760084 -20.072399139
		 33.011512756 1.67024207 -20.049404144 35.95251083 1.96282625 -20.036001205 38.91043472 2.32328916 -20.018281937
		 41.87299728 2.70063233 -20.0050888062 44.8506279 2.79361176 -20.035852432;
	setAttr ".vt[1826:1991]" 47.91461182 2.5066247 -20.098104477 51.058437347 2.45666337 -20.11595726
		 54.17313385 2.74460673 -20.08864212 57.21519852 2.87734652 -20.07261467 60.21170807 2.6927731 -20.081220627
		 63.16569138 2.35926151 -20.096517563 66.053100586 2.0081079006 -20.10823059 68.82525635 1.78852916 -20.1098156
		 71.3221283 1.49589777 -20.096014023 73.19055176 0.96680939 -20.051912308 -71.83614349 0.90177339 -22.091842651
		 -70.66874695 0.81011027 -22.085958481 -68.56092834 0.69863689 -22.079246521 -65.92909241 0.53815335 -22.071220398
		 -63.013072968 0.34840503 -22.073308945 -59.92114639 0.35018143 -22.088214874 -56.89218903 0.80041808 -22.11330414
		 -53.96796799 0.99244028 -22.12248421 -51.00033187866 1.13639772 -22.13139725 -48.015125275 1.32638216 -22.14159203
		 -45.048736572 1.50585341 -22.14927292 -42.11301804 1.50497627 -22.13592339 -39.072349548 1.18167377 -22.13957977
		 -35.96873093 1.17352891 -22.14810753 -32.87600708 1.44059181 -22.15354538 -29.87475014 2.027449846 -22.12693787
		 -26.97084808 2.36713195 -22.10973167 -24.037536621 2.39925981 -22.082439423 -21.064306259 2.27219486 -22.065710068
		 -18.083574295 2.072226286 -22.074670792 -15.13549042 1.7933557 -22.11458778 -12.16512012 1.26164591 -22.18521118
		 -9.077355385 0.79559171 -22.22405052 -5.98176908 0.76145196 -22.20370483 -2.95846653 0.83517128 -22.16711426
		 0.086121649 0.89698642 -22.10886955 3.15446401 1.17744732 -22.050109863 6.12948418 1.60315657 -22.02560997
		 9.046494484 1.70386386 -22.026342392 12.0083456039 1.6979773 -22.022827148 14.98579884 1.70493686 -22.015542984
		 17.94379807 1.70906401 -22.012226105 20.8645916 1.52504432 -22.027511597 23.90854263 1.021684527 -22.071376801
		 27.060861588 1.035073519 -22.062429428 30.085414886 1.56324506 -21.99951935 32.9964447 1.96431863 -21.96545029
		 35.92717743 2.27715421 -21.95342445 38.89085388 2.61780143 -21.94753265 41.86808395 2.91996121 -21.95664787
		 44.83784103 2.97941947 -21.99975204 47.89209747 2.65558386 -22.074548721 51.06193924 2.48849583 -22.090480804
		 54.2166214 2.71394634 -22.035556793 57.25890732 2.86129069 -21.99979401 60.23526764 2.62693143 -22.005777359
		 63.17781067 2.20516729 -22.023628235 66.050674438 1.86499453 -22.040306091 68.78486633 1.63329041 -22.056659698
		 71.16989899 1.37301171 -22.060131073 72.70749664 0.96418297 -22.031524658 -72.10434723 1.19633114 -24.042423248
		 -70.83605957 0.97930503 -24.045671463 -68.64867401 0.75702745 -24.042999268 -65.96607208 0.54373342 -24.035306931
		 -62.99940491 0.3468647 -24.030704498 -59.90497208 0.40086174 -24.03115654 -56.89370346 0.83398485 -24.032888412
		 -53.9735527 1.028223872 -24.034927368 -51.0044403076 1.21722376 -24.043560028 -48.019985199 1.4474467 -24.050706863
		 -45.056587219 1.64567924 -24.052747726 -42.12936783 1.62104404 -24.051223755 -39.067829132 1.25271797 -24.060279846
		 -35.95912933 1.3033874 -24.071590424 -32.87092209 1.58556533 -24.075649261 -29.87745094 2.26309156 -24.028791428
		 -26.9919529 2.65918279 -23.98175049 -24.060848236 2.73471403 -23.94302177 -21.077655792 2.63798594 -23.92045975
		 -18.076982498 2.45566726 -23.92695427 -15.10946083 2.17810297 -23.96706963 -12.14979935 1.64936996 -24.044332504
		 -9.085085869 1.11054063 -24.10277176 -5.99717951 1.010576844 -24.096803665 -2.97695112 1.0053429604 -24.07302475
		 0.052794687 0.99346793 -24.037879944 3.13619328 1.13893008 -24.00046539307 6.14026546 1.61098516 -23.98284912
		 9.052131653 1.7646718 -23.98684883 12.0077733994 1.78352869 -23.98523331 14.98370361 1.80345726 -23.97911835
		 17.94303513 1.81809425 -23.97939491 20.84990311 1.72166526 -24.0031394958 23.8759594 1.19803417 -24.074903488
		 27.066461563 1.21212554 -24.069774628 30.094306946 1.86935496 -23.97901917 32.97680664 2.30892015 -23.9418087
		 35.90444183 2.62186027 -23.93517876 38.87786484 2.88690758 -23.94164467 41.86569214 3.099471092 -23.9607029
		 44.83404922 3.19000101 -23.99880028 47.87416458 2.91236401 -24.067865372 51.050567627 2.69539118 -24.084068298
		 54.23464584 2.89279485 -24.019897461 57.3082695 3.056638718 -23.96720123 60.29020691 2.78352237 -23.96738052
		 63.22777557 2.28976107 -23.99131775 66.077323914 1.82736742 -24.022478104 68.7730484 1.48681998 -24.051086426
		 71.057411194 1.19379425 -24.058073044 72.44216156 0.86443639 -24.036432266 -72.56406403 1.73506892 -26.010482788
		 -71.17747498 1.45006561 -26.016349792 -68.80194092 0.98376191 -26.026275635 -65.99011993 0.64135098 -26.02971077
		 -62.98796844 0.40247458 -26.029661179 -59.89544678 0.47324383 -26.024061203 -56.89580154 0.87301964 -26.015348434
		 -53.97556686 1.053881884 -26.022966385 -51.01008606 1.24061596 -26.041296005 -48.027709961 1.47312438 -26.055715561
		 -45.062503815 1.65658617 -26.061113358 -42.13817215 1.6181618 -26.054697037 -39.074172974 1.17552125 -26.053527832
		 -35.94598007 1.28138018 -26.072977066 -32.85250092 1.62737846 -26.082952499 -29.88954544 2.41064548 -26.039125443
		 -27.017654419 2.84595609 -25.98774147 -24.088050842 2.96863341 -25.94034195 -21.090517044 2.91655183 -25.91121864
		 -18.070074081 2.7653749 -25.91009331 -15.089080811 2.49765825 -25.94151688 -12.13232422 1.9821676 -26.010890961
		 -9.084637642 1.37854052 -26.076969147 -5.99904203 1.20493042 -26.075641632 -2.98076129 1.13611901 -26.060260773
		 0.038247518 1.072018981 -26.037517548 3.13040709 1.1133585 -26.010957718 6.15259981 1.64149439 -25.98353958
		 9.057765961 1.83718729 -25.97725868 12.0075407028 1.88880849 -25.97186089 14.98165798 1.93973684 -25.96439552
		 17.9450531 1.99456823 -25.96377563 20.86313248 1.96464252 -25.99041176 23.87020683 1.6080327 -26.053800583
		 27.0414505 1.57100642 -26.05437851 30.067102432 2.27396417 -25.95677567 32.95718765 2.70984507 -25.92421532
		 35.89035034 2.967453 -25.93053055 38.86502457 3.19035482 -25.94659615 41.8557663 3.38973093 -25.96826172
		 44.83307266 3.48983026 -26.00248909 47.8627739 3.26776147 -26.060596466 51.036270142 2.9816134 -26.087739944
		 54.24785995 3.10494351 -26.03396225 57.36177063 3.30285025 -25.96686172 60.35514069 2.99456882 -25.95598984
		 63.2925415 2.41425896 -25.97466278 66.12391663 1.82585645 -26.0064277649 68.78178406 1.39173818 -26.034351349
		 71.052482605 1.048414707 -26.043848038 72.51231384 0.71218938 -26.030891418 -73.2294693 1.96969759 -27.99715996
		 -71.55708313 1.88975525 -27.99464798 -68.90570831 1.46736348 -28.0012588501;
	setAttr ".vt[1992:2157]" -65.9993515 0.97139919 -28.017282486 -62.97853088 0.64648545 -28.02970314
		 -59.89606094 0.69788969 -28.022075653 -56.9070015 1.034873962 -28.0047702789 -53.98464584 1.16593599 -28.019535065
		 -51.018951416 1.31217945 -28.050285339 -48.038017273 1.5180068 -28.074111938 -45.071731567 1.67197752 -28.087125778
		 -42.14155197 1.62652957 -28.088241577 -39.07541275 1.17898822 -28.087947845 -35.94475937 1.3368088 -28.11205864
		 -32.85934448 1.72048926 -28.13242912 -29.90411186 2.5261476 -28.10354042 -27.042032242 3.040075064 -28.049072266
		 -24.11725235 3.2060616 -27.99065971 -21.10553932 3.19869399 -27.94840622 -18.062215805 3.070333719 -27.93393135
		 -15.057751656 2.81904244 -27.94978523 -12.1020031 2.32309222 -28.0044250488 -9.072313309 1.64774978 -28.069923401
		 -5.99001741 1.40864313 -28.073040009 -2.9751122 1.27993703 -28.06196785 0.035100136 1.16997313 -28.047164917
		 3.12873578 1.1741426 -28.025896072 6.15820169 1.7141645 -27.98832893 9.057880402 1.93271816 -27.97216988
		 12.0067281723 2.021130562 -27.96319199 14.97860432 2.10138178 -27.95435524 17.94514465 2.1915617 -27.95145226
		 20.87190819 2.22755241 -27.97050476 23.85761452 2.0084013939 -28.01676178 27.0063152313 1.88641143 -28.031795502
		 30.055706024 2.55008531 -27.95030022 32.95449829 3.0080289841 -27.92671967 35.88442993 3.26856589 -27.94269753
		 38.85475922 3.48103881 -27.96772957 41.84393692 3.66676736 -27.99489021 44.82818985 3.76688814 -28.026439667
		 47.85933685 3.59262347 -28.073326111 51.024505615 3.2893939 -28.10752678 54.25457764 3.35797477 -28.073513031
		 57.40728378 3.60074401 -27.99928284 60.42189407 3.26103282 -27.97237206 63.36411285 2.614393 -27.97019958
		 66.18478394 1.94585526 -27.98685265 68.83889771 1.43706453 -28.0090427399 71.10951233 1.11433244 -28.021968842
		 72.61346436 0.82330823 -28.021167755 -73.69524384 1.98527181 -29.99555588 -71.79261017 1.97384369 -29.99108505
		 -68.96994019 1.92528093 -29.9803772 -65.98155975 1.72600007 -29.9720993 -62.97750473 1.38317418 -29.98113441
		 -59.92620468 1.32230651 -29.97836304 -56.93225479 1.59933913 -29.95601082 -53.99542236 1.61728358 -29.98417664
		 -51.026554108 1.6629957 -30.025156021 -48.045200348 1.76348972 -30.061878204 -45.074321747 1.86643136 -30.08716011
		 -42.13290787 1.79603398 -30.10454178 -39.065353394 1.30666518 -30.12459755 -35.95594788 1.5071975 -30.15696526
		 -32.89659119 1.91435957 -30.18920135 -29.95912361 2.73634291 -30.18014908 -27.097690582 3.31477499 -30.12903786
		 -24.16088867 3.52386427 -30.055671692 -21.12061882 3.55381107 -29.99836349 -18.046020508 3.46144366 -29.96833229
		 -15.01391983 3.21817183 -29.97074127 -12.046496391 2.71399069 -30.0092029572 -9.032062531 1.96968019 -30.065244675
		 -5.96468735 1.6784476 -30.068216324 -2.96115804 1.48195004 -30.059217453 0.043643672 1.35598898 -30.045259476
		 3.12290001 1.33384299 -30.025182724 6.14932823 1.87686539 -29.98271942 9.056745529 2.14503646 -29.96195793
		 11.9994936 2.25243163 -29.95331192 14.97070503 2.34929132 -29.94480705 17.9419384 2.47078395 -29.94050598
		 20.88462448 2.57708907 -29.94887924 23.85076714 2.45433974 -29.98018074 26.97785187 2.2491219 -30.006980896
		 30.034591675 2.89309883 -29.94397354 32.94664383 3.38861537 -29.93447685 35.87709045 3.67358851 -29.962286
		 38.84059906 3.898803 -29.99949265 41.82493591 4.066499233 -30.038496017 44.81501007 4.17298794 -30.070753098
		 47.86205673 4.046438217 -30.10490417 51.023715973 3.80392694 -30.13936615 54.24121094 3.86806774 -30.12845993
		 57.45810318 4.22097492 -30.051774979 60.53107834 3.81482816 -30.005657196 63.49062347 3.077820301 -29.97380829
		 66.30055237 2.33852506 -29.96601105 68.96324921 1.82125568 -29.97641373 71.3422699 1.54021561 -29.98981667
		 72.91213989 1.25955093 -29.99772072 -73.98669434 1.99331117 -31.99725723 -71.86755371 1.99029541 -31.99481201
		 -68.98493195 1.96934223 -31.98812103 -65.98975372 1.91341686 -31.97862816 -62.98976135 1.83035052 -31.97124672
		 -59.98176193 2.04449439 -31.93875504 -56.97560883 2.47767901 -31.88365364 -53.99929047 2.50055814 -31.89832687
		 -51.02658844 2.48994946 -31.9383316 -48.049129486 2.49363542 -31.98336029 -45.067146301 2.50797796 -32.021377563
		 -42.082099915 2.43951106 -32.058742523 -39.036823273 1.76206124 -32.12607193 -35.99578476 1.99705517 -32.17227173
		 -32.99922943 2.40094686 -32.22966385 -30.1066246 3.2702291 -32.24811935 -27.23493004 3.94876075 -32.20755768
		 -24.25054169 4.18218327 -32.11410522 -21.14939499 4.24451971 -32.04196167 -18.015001297 4.14212513 -32.0045547485
		 -14.92117119 3.93583775 -31.99398422 -11.90527916 3.4258554 -32.013347626 -8.92152691 2.56487751 -32.054969788
		 -5.90623999 2.21834826 -32.054832458 -2.92525077 1.9644655 -32.044967651 0.060493741 1.83175886 -32.029483795
		 3.092694044 1.76819539 -32.010005951 6.096247196 2.36471963 -31.96305847 9.024326324 2.70892644 -31.93776131
		 11.97666359 2.84827423 -31.92816925 14.94742966 2.9520824 -31.9217453 17.92197418 3.066249609 -31.9184494
		 20.88442612 3.25895262 -31.91529465 23.86348724 3.21138549 -31.93438339 26.94420624 2.87039828 -31.97514915
		 29.96362495 3.5225749 -31.94028854 32.8949852 4.2005043 -31.94388008 35.85523987 4.51033401 -31.9937439
		 38.81893539 4.71469831 -32.062171936 41.79294968 4.84451056 -32.12976837 44.79975128 4.93132257 -32.1796608
		 47.87973404 4.71619797 -32.19997025 51.020706177 4.48420763 -32.21282578 54.18476868 4.56426287 -32.22145844
		 57.50996399 5.055192947 -32.19461441 60.68405533 4.51140642 -32.11748886 63.66040802 3.78099632 -32.013893127
		 66.47219086 3.061386347 -31.94607735 69.15109253 2.48863649 -31.93993759 71.59107208 2.027197599 -31.96622658
		 73.14109802 1.59571624 -31.98482513 -74.53832245 1.99250889 -33.99939346 -71.95973969 1.99625015 -33.99839401
		 -68.99653625 1.99027014 -33.99544144 -65.99691772 1.97471416 -33.99142838 -62.99672699 1.94253254 -33.98794174
		 -59.99238968 2.15650702 -33.97108841 -56.98345566 2.68288779 -33.92101288 -53.99497223 2.72713709 -33.91225052
		 -51.014328003 2.71936178 -33.91588211 -48.038524628 2.73380113 -33.92223358 -45.058059692 2.77144647 -33.93384552
		 -42.057540894 2.69932771 -33.96292496 -39.0088615417 2.068854809 -34.045276642 -35.99914169 2.30119181 -34.092136383
		 -33.020427704 2.55536795 -34.14938354 -30.15220642 3.34385753 -34.17958069;
	setAttr ".vt[2158:2323]" -27.30294037 3.98763037 -34.17625809 -24.3234539 4.36034822 -34.14198303
		 -21.18022537 4.5704565 -34.1137352 -17.99121284 4.57154942 -34.099369049 -14.84988117 4.38568878 -34.091262817
		 -11.79719353 3.86051893 -34.085624695 -8.82721806 2.98928499 -34.083610535 -5.85220528 2.7320807 -34.056602478
		 -2.88703227 2.52002001 -34.029098511 0.077516071 2.37046862 -34.0050849915 3.047772169 2.29393983 -33.98811722
		 6.024736404 2.85261106 -33.94553375 8.99194622 3.22398186 -33.92079544 11.95903683 3.34992814 -33.91900635
		 14.92777061 3.48034263 -33.92445374 17.89753151 3.6520648 -33.92971802 20.8789463 3.82176495 -33.93979645
		 23.88628197 3.81731653 -33.95817566 26.93821526 3.34432197 -34.00573349 29.92849922 3.86166239 -34.015571594
		 32.92124557 4.40659475 -34.055633545 35.90428543 4.59420633 -34.12796021 38.86284637 4.66810322 -34.21750641
		 41.81200409 4.71732473 -34.30498886 44.78844833 4.71372652 -34.37065506 47.85437012 4.42673635 -34.36212158
		 50.99263 4.39872169 -34.36259842 54.16179276 4.4777422 -34.42549515 57.53499603 5.014737129 -34.5745697
		 60.64721298 4.39323997 -34.35791016 63.59466171 3.7941947 -34.098350525 66.46553802 3.15134382 -33.95414352
		 69.2390976 2.56539631 -33.94124603 71.73508453 2.02307868 -33.9812851 73.39584351 1.48196089 -34.00022888184
		 -75.000022888184 1.96788585 -36.000019073486 -72.000022888184 1.99716616 -36.000003814697
		 -68.99987793 1.99916816 -35.99959564 -65.99948883 1.99564731 -35.9982338 -62.99943542 1.98735654 -35.99708176
		 -59.99784088 2.19384074 -35.99001312 -56.99264145 2.80889153 -35.957798 -54.00032043457 2.88395214 -35.94105148
		 -51.019184113 2.88909507 -35.92538071 -48.046772003 2.91122746 -35.90450287 -45.064659119 2.94677973 -35.88764572
		 -42.054901123 2.86728144 -35.88866806 -38.99517441 2.22102118 -35.94873047 -35.96810532 2.40166783 -35.96403503
		 -33.0013809204 2.59311748 -35.9855957 -30.14748192 3.33756113 -35.99913788 -27.32946587 3.93358803 -36.066989899
		 -24.36980057 4.35189009 -36.15035629 -21.19034958 4.58914137 -36.21179962 -17.96923828 4.55816603 -36.24298859
		 -14.82738686 4.3555975 -36.24127197 -11.78220749 3.84953809 -36.19490051 -8.81284428 3.018445015 -36.12978745
		 -5.84521198 2.78095961 -36.069915771 -2.89270473 2.59379363 -36.02097702 0.067670137 2.46762609 -35.99100113
		 3.038741589 2.40170264 -35.97809219 6.019529819 2.87383723 -35.95041275 8.99394703 3.3311553 -35.93600082
		 11.96743298 3.46156335 -35.95235062 14.94033527 3.57928896 -35.97956467 17.91460228 3.72722816 -36.015403748
		 20.8938446 3.89732122 -36.05305481 23.89887428 3.91499472 -36.088954926 26.95430183 3.4151032 -36.11066055
		 29.96658134 3.7190156 -36.14710236 32.98070526 4.21112537 -36.22259521 35.97673798 4.36920214 -36.30487442
		 38.93811417 4.36721325 -36.39440918 41.87360764 4.28208494 -36.47050476 44.83437729 4.093571663 -36.49885559
		 47.87699509 3.71616387 -36.43961716 51.01568222 3.7357173 -36.48654556 54.11671066 3.62595582 -36.59901047
		 57.37373352 4.27954865 -36.85117722 60.4028244 4.026323318 -36.50202179 63.4106369 3.79772353 -36.11691666
		 66.44735718 3.25623751 -35.94998169 69.30884552 2.58929324 -35.9719696 71.9631424 1.90140164 -36.023353577
		 74.053321838 1.045154095 -36.019760132 -75.00032806396 1.80154538 -38.00051116943
		 -72.00021362305 1.99073696 -38.00034332275 -69.000015258789 1.99976289 -38.000034332275
		 -66.000007629395 1.99989152 -37.99999237 -63.000011444092 1.99869418 -37.99970245
		 -59.99980927 2.1664412 -37.9977417 -56.99925613 2.8317771 -37.98274231 -54.0079689026 2.96941113 -37.96952057
		 -51.033348083 2.98531795 -37.94839478 -48.073219299 3.030663967 -37.91305161 -45.088024139 3.087435246 -37.88310242
		 -42.058815002 3.011376619 -37.87552261 -38.98630905 2.35926461 -37.90185547 -35.95623779 2.53217888 -37.90771866
		 -32.99409103 2.73373103 -37.8910408 -30.1217041 3.45640421 -37.86562347 -27.30640984 3.95929956 -38.051971436
		 -24.36947632 4.33292246 -38.27653122 -21.16921234 4.52850485 -38.40229416 -17.92700005 4.42032528 -38.44174957
		 -14.81517124 4.16506577 -38.41331863 -11.79324722 3.70809722 -38.30016327 -8.81835175 3.0086259842 -38.16030884
		 -5.86790133 2.83472419 -38.063796997 -2.9155581 2.6885643 -38.0022506714 0.048392579 2.59251666 -37.97694397
		 3.028194904 2.54718041 -37.98207474 6.018150806 2.92113757 -37.97282791 9.0050945282 3.44450903 -37.97440338
		 11.98905468 3.55440974 -38.012718201 14.97164822 3.63486791 -38.065887451 17.95390511 3.73299265 -38.13788986
		 20.93793869 3.85087371 -38.22439575 23.93488312 3.83930612 -38.29880905 26.97683716 3.27155089 -38.28742218
		 29.9949398 3.29479432 -38.30844498 33.016899109 3.59532547 -38.37722015 36.025970459 3.74800372 -38.44294739
		 39.00074005127 3.69211149 -38.4900856 41.94363022 3.5100708 -38.5181694 44.89021683 3.18513608 -38.47409439
		 47.90645981 2.89694953 -38.38655853 51.053825378 2.98910761 -38.4282341 54.1170311 2.78002667 -38.45131683
		 57.12540054 3.34018731 -38.66672516 60.091625214 3.64921975 -38.4863739 63.21041489 3.75067592 -38.21461105
		 66.44404602 3.31795764 -38.094272614 69.39559174 2.49389791 -38.10955048 72.17333984 1.60317183 -38.10202789
		 74.96160889 0.28018084 -38.0013580322 -75.0012969971 1.30264449 -40.002368927 -72.0023040771 1.92658317 -40.0042724609
		 -69.00043487549 1.99696028 -40.00089645386 -66.000076293945 1.99994779 -40.00017929077
		 -63.000049591064 1.99999142 -40.00011825562 -60.000087738037 2.076527834 -39.99991989
		 -57.001247406 2.81261778 -39.99630737 -54.011142731 2.9880116 -39.99060822 -51.048976898 3.017964602 -39.97618484
		 -48.10559845 3.080854416 -39.94926453 -45.11510468 3.17422414 -39.92905807 -42.049064636 3.068371058 -39.94543076
		 -38.97606277 2.36679602 -39.96458817 -35.94949722 2.58147383 -39.97444153 -32.9998436 2.91831374 -39.95161819
		 -30.039815903 3.6129024 -39.96176147 -27.15438461 3.9606874 -40.099571228 -24.23454475 4.15663624 -40.36060333
		 -21.081384659 4.27605724 -40.58433914 -17.86294365 4.062055588 -40.647892 -14.82681656 3.74341345 -40.56528854
		 -11.85173416 3.43484068 -40.35534668 -8.86573792 2.96620131 -40.14458847 -5.91698074 2.90024185 -40.036235809
		 -2.95430541 2.82232881 -39.98460388 0.027108518 2.75272799 -39.9889679 3.018196344 2.70091677 -40.0068588257
		 6.022738457 2.91922736 -40.030387878 9.02761364 3.50280142 -40.057365417;
	setAttr ".vt[2324:2489]" 12.024638176 3.61093211 -40.1118927 15.021509171 3.62582874 -40.1893959
		 18.019313812 3.63649988 -40.29546738 21.02183342 3.64211392 -40.4437294 24.0012779236 3.48121428 -40.55596542
		 26.99540138 2.76472926 -40.52363968 29.99977112 2.74770617 -40.48660278 33.015552521 2.75614238 -40.42732239
		 36.033180237 2.83605552 -40.43780518 39.027873993 2.77339077 -40.44764328 41.98453522 2.50127435 -40.40659332
		 44.92591095 2.16026568 -40.31276321 47.91305542 2.041903257 -40.23799133 51.010009766 2.15782261 -40.16183853
		 54.093013763 2.24450994 -40.17749786 57.0099868774 2.6975925 -40.34651184 59.94457626 3.15347219 -40.38747025
		 63.10040283 3.39645696 -40.37730408 66.40003204 3.042537689 -40.34781647 69.37936401 2.091697216 -40.28437424
		 72.14756012 1.13698149 -40.14460373 75 0.023529412 -40 -75 0.94818294 -42 -72.0094070435 1.62095416 -42.024669647
		 -69.005569458 1.96822119 -42.015750885 -66.0022201538 1.99839044 -42.0057868958 -63.00064468384 1.9998976 -42.0017814636
		 -60.00012588501 2.049004793 -42.0008430481 -56.99921036 2.75512695 -42.00573349 -54.0039749146 2.94969106 -42.015739441
		 -51.05260849 3.0037333965 -42.019939423 -48.14181137 3.071763515 -42.020969391 -45.13453293 3.19974518 -42.042427063
		 -42.0099716187 2.95276761 -42.080688477 -38.95142365 2.071150303 -42.061283112 -35.98404694 2.44594193 -42.020339966
		 -33.0010566711 2.87376237 -41.9969101 -30.02130127 3.64667106 -42.020858765 -27.044502258 3.93567729 -42.080345154
		 -24.054956436 3.99986434 -42.25927734 -20.92145729 3.92426443 -42.5061264 -17.79312897 3.47715092 -42.5917244
		 -14.87912273 3.16981101 -42.47473526 -11.96364594 3.08251071 -42.24742126 -8.96292305 2.95528984 -42.054519653
		 -5.98963356 2.98852134 -42.005355835 -2.99631548 2.98707771 -41.99607849 0.011237604 2.90651441 -42.037258148
		 3.021651506 2.82296872 -42.087791443 6.036509037 2.90998816 -42.13250351 9.0583601 3.49607635 -42.18781662
		 12.065997124 3.54118633 -42.24465179 15.074749947 3.48847318 -42.31449509 18.087020874 3.3903656 -42.40726089
		 21.095149994 3.23738098 -42.50330353 24.048509598 2.89075255 -42.50629425 26.99663734 2.010678053 -42.39672089
		 29.99737549 2.035683393 -42.38893127 33.0066986084 2.022153854 -42.32608414 36.015235901 1.89662313 -42.2805481
		 39.014873505 1.79401863 -42.25801468 41.98873901 1.55051422 -42.20470428 44.94493866 1.33938324 -42.15472031
		 47.8993721 1.32191515 -42.089817047 50.97473145 1.30439866 -42.019031525 54.025920868 1.45101964 -42.051651001
		 56.97584915 2.31757712 -42.12966156 59.96244431 2.74866247 -42.22091293 63.092521667 2.81314778 -42.32628632
		 66.31980896 2.41458821 -42.35980225 69.26595306 1.40509331 -42.24891663 72.065429688 0.57662606 -42.07743454
		 75 9.3258734e-015 -42 -75 0.69185114 -44 -72.0011749268 0.89942986 -44.0069313049
		 -69.028778076 1.74336123 -44.11992645 -66.027351379 1.96212804 -44.076114655 -63.0094642639 1.9936949 -44.030193329
		 -60.0019111633 1.99763882 -44.015357971 -56.99386597 2.62928367 -44.039627075 -53.9813118 2.87556648 -44.087497711
		 -51.026222229 2.92093182 -44.14597321 -48.13357544 2.94579434 -44.18918228 -45.10657501 2.97734213 -44.19686127
		 -41.98705292 2.5768075 -44.126297 -38.98659515 2.0036587715 -44.023662567 -36.00028991699 2.15293145 -43.99949646
		 -33.000030517578 2.63096523 -43.99992371 -30.031679153 3.57521558 -44.077857971 -27.0012226105 3.87753081 -44.10776901
		 -23.92396736 3.90115571 -44.20386124 -20.79509926 3.63430047 -44.32480621 -17.80828667 3.10744166 -44.30944061
		 -14.95014763 2.93289995 -44.20691681 -12.024766922 2.68441081 -44.10450745 -8.98988819 2.87826228 -44.065433502
		 -5.99471903 2.98363328 -44.089618683 -2.98675585 2.98357415 -44.1118927 0.027994815 2.86233091 -44.18517303
		 3.040822268 2.7396524 -44.21994781 6.054607868 2.75434947 -44.24528885 9.079122543 3.34309268 -44.29333115
		 12.087014198 3.36195564 -44.30800629 15.092393875 3.26523805 -44.31790924 18.088247299 3.13405967 -44.29896927
		 21.072399139 3.004778862 -44.23902893 24.030353546 2.78920817 -44.12519836 26.99736786 1.99805903 -44.020832062
		 29.99859238 1.94916785 -44.030319214 33.0023918152 1.57346392 -44.091197968 36.0051269531 1.30350614 -44.096881866
		 39.0048446655 1.13802946 -44.092220306 41.99599457 0.94624501 -44.064357758 44.97099304 0.75999063 -44.048286438
		 47.95095825 0.59083605 -44.030323029 51 0.89710367 -44 53.99876404 1.13274956 -44.0067558289
		 56.97540665 1.85900784 -44.059085846 60.0037879944 2.371701 -44.1407547 63.12393951 2.38822937 -44.21959686
		 66.23743439 1.84586513 -44.22182465 69.14316559 0.89142913 -44.11280441 72.013336182 0.3027603 -44.012825012
		 75 9.7699626e-015 -44 -75 0.058146872 -46 -72 0.12161477 -46 -69.016029358 0.60684735 -46.063941956
		 -66.055328369 1.57979321 -46.17832184 -63.038871765 1.87406301 -46.15241623 -60.010700226 1.94041908 -46.11230469
		 -56.98326111 2.35421205 -46.16639328 -53.94011307 2.60534835 -46.26075363 -50.978302 2.56650615 -46.32816315
		 -48.10426712 2.4919219 -46.30458832 -45.11510086 2.55500698 -46.18406677 -42.033470154 2.36905003 -46.044685364
		 -39.0024795532 1.99999106 -45.99981689 -36.000015258789 1.99999166 -46 -32.99979401 2.24824047 -46.00043869019
		 -30.025432587 3.25612259 -46.16453552 -26.97859764 3.58719516 -46.25975037 -23.8789711 3.58705616 -46.34034729
		 -20.81794167 3.23440337 -46.28384018 -17.87184525 2.98028827 -46.17106247 -14.93661404 2.84594321 -46.15436935
		 -11.9672823 2.31260037 -46.22501755 -8.9760294 2.27100587 -46.29475021 -5.98695755 2.70249796 -46.41587067
		 -2.96733594 2.70660233 -46.43488693 0.039524749 2.53553414 -46.32945251 3.047341347 2.43450928 -46.25892639
		 6.054289818 2.47712755 -46.2130928 9.071084023 3.10951424 -46.24092865 12.071087837 3.15986848 -46.19894791
		 15.063090324 3.095997095 -46.16483688 18.039648056 3.023041725 -46.097408295 21.017936707 2.96497893 -46.033340454
		 24.008310318 2.7831707 -46.010620117 27.00032424927 1.9814688 -46.00056838989 30.0021324158 1.72942197 -46.003780365
		 33.00096130371 1.16242898 -46.0050506592 36.00099945068 0.92811543 -46.0067863464
		 39.00099182129 0.7294994 -46.0065765381 41.99896622 0.55143571 -46.0023803711 44.9945755 0.3074086 -46.0054855347
		 47.99822617 0.049097676 -46.0011177063;
	setAttr ".vt[2490:2600]" 51 0.67720419 -46 54 0.93476325 -46 56.99271011 1.205248 -46.025634766
		 60.012542725 1.70468712 -46.11058426 63.096172333 1.71054518 -46.16478729 66.12570953 1.13526344 -46.12384796
		 69.04473877 0.44546357 -46.034973145 72.0011138916 0.11352743 -46.0012245178 75 1.0214052e-014 -46
		 -75 1.0658141e-014 -48 -72 1.0658141e-014 -48 -69 1.0658141e-014 -48 -66.01915741 0.34854895 -48.05619812
		 -63.042812347 1.17952216 -48.16824722 -60.015209198 1.50498629 -48.21551132 -56.98371887 1.73623431 -48.27739334
		 -53.93067932 1.9117471 -48.31876373 -50.97229767 1.85057616 -48.28289795 -48.12978363 1.95930278 -48.19217682
		 -45.16859055 2.24927402 -48.087902069 -42.057342529 2.18182015 -48.02280426 -39.0043411255 1.99900198 -48.0034599304
		 -36.00016021729 1.99890292 -48.00026702881 -33.000007629395 1.99643254 -48.000038146973
		 -29.98986435 2.73264074 -48.16481018 -26.97285271 2.8670485 -48.26556396 -23.94381714 2.8718915 -48.30255508
		 -20.92735672 2.89881253 -48.22406006 -17.91485786 2.89181662 -48.13187027 -14.85776806 2.62239742 -48.20781708
		 -11.89941406 1.59276366 -48.25736237 -8.98129272 1.055145621 -48.20722961 -5.98906517 1.63799596 -48.29960251
		 -2.97071528 1.87805724 -48.32955933 0.028592667 2.024979353 -48.2084465 3.03412199 2.082735062 -48.051689148
		 6.036364079 2.18006825 -47.91744995 9.041207314 2.88942695 -47.85404968 12.035684586 3.036150455 -47.84738159
		 15.026078224 3.019543409 -47.87574387 18.010923386 2.99352622 -47.93788528 21.0062408447 2.95346522 -47.96029663
		 24.017017365 2.73367596 -47.99634933 27.0043888092 1.89169955 -48.0086517334 30.0082378387 1.39495635 -48.015342712
		 33.00067138672 0.93425 -48.001247406 36.00011444092 0.61144167 -47.96761703 39.000022888184 0.32580495 -47.95930862
		 41.99995422 0.1533723 -47.96234131 44.99953842 0.048373029 -47.97763443 48 0.013864961 -48
		 51 0.31081891 -48 54 0.73888743 -48 57 0.85749215 -48 60.0054779053 0.98365891 -48.032924652
		 63.034618378 0.92141378 -48.061038971 66.035804749 0.51410252 -48.038005829 69.0065689087 0.16241886 -48.0056152344
		 72 1.0658141e-014 -48 75 1.0658141e-014 -48 -75 1.110223e-014 -50 -72 1.110223e-014 -50
		 -69 1.110223e-014 -50 -66 1.110223e-014 -50 -63.0091285706 0.19089508 -50.033565521
		 -60.0082626343 0.56041342 -50.14974594 -56.98873901 0.77503914 -50.20969391 -53.95358658 1.17600012 -50.13180542
		 -50.99419022 1.37877858 -49.99255371 -48.13913727 1.51425433 -49.93963623 -45.16259003 1.85384119 -49.9682579
		 -42.050769806 1.90179896 -50.024814606 -39.0061302185 1.96471298 -50.0058784485 -36.00029373169 1.96475697 -50.00048828125
		 -33.000015258789 1.92433786 -50.000068664551 -29.96300507 2.39862585 -49.88167191
		 -26.96394348 2.32563806 -49.92883301 -24.0055732727 2.3582952 -49.90155792 -20.9987812 2.66055465 -49.89277649
		 -17.91743088 2.72229528 -49.8316803 -14.81589222 2.23534703 -49.97668076 -11.89155865 1.15194941 -50.12368393
		 -8.9855423 0.99701381 -50.075782776 -5.99456215 0.99892575 -50.046016693 -2.98505616 1.37552238 -49.90512848
		 0.012515144 1.72733271 -49.46496582 3.014088869 1.88421249 -49.29397583 6.017521858 2.032300234 -49.039783478
		 9.019411087 2.77773905 -48.83244324 12.014101028 2.96367311 -48.91909027 15.0078201294 2.99809194 -49.20691681
		 18.0036716461 2.98463821 -49.50849152 21.0083446503 2.91843653 -49.64428711 24.02456665 2.60102057 -49.78058624
		 27.0062408447 1.60891616 -50.010547638 30.0033512115 0.99585581 -49.95272446 33.00032424927 0.61426824 -49.80060577
		 36 0.24042511 -49.70588303 39 0.040644802 -49.66797256 42 1.1031408e-014 -49.68104553
		 45 1.1046211e-014 -49.74771118 48 0.00025118547 -49.87189484 51 0.0039215689 -50
		 54 0.3358247 -50 57 0.54069972 -50 60 0.49188775 -50 63 0.27450982 -50 66 1.110223e-014 -50
		 69 1.110223e-014 -50 72 1.110223e-014 -50 75 1.110223e-014 -50;
	setAttr -s 5100 ".ed";
	setAttr ".ed[0:165]"  0 1 0 1 52 1 52 51 1 51 0 0 1 2 0 2 53 1 53 52 1 2 3 0
		 3 54 1 54 53 1 3 4 0 4 55 1 55 54 1 4 5 0 5 56 1 56 55 1 5 6 0 6 57 1 57 56 1 6 7 0
		 7 58 1 58 57 1 7 8 0 8 59 1 59 58 1 8 9 0 9 60 1 60 59 1 9 10 0 10 61 1 61 60 1 10 11 0
		 11 62 1 62 61 1 11 12 0 12 63 1 63 62 1 12 13 0 13 64 1 64 63 1 13 14 0 14 65 1 65 64 1
		 14 15 0 15 66 1 66 65 1 15 16 0 16 67 1 67 66 1 16 17 0 17 68 1 68 67 1 17 18 0 18 69 1
		 69 68 1 18 19 0 19 70 1 70 69 1 19 20 0 20 71 1 71 70 1 20 21 0 21 72 1 72 71 1 21 22 0
		 22 73 1 73 72 1 22 23 0 23 74 1 74 73 1 23 24 0 24 75 1 75 74 1 24 25 0 25 76 1 76 75 1
		 25 26 0 26 77 1 77 76 1 26 27 0 27 78 1 78 77 1 27 28 0 28 79 1 79 78 1 28 29 0 29 80 1
		 80 79 1 29 30 0 30 81 1 81 80 1 30 31 0 31 82 1 82 81 1 31 32 0 32 83 1 83 82 1 32 33 0
		 33 84 1 84 83 1 33 34 0 34 85 1 85 84 1 34 35 0 35 86 1 86 85 1 35 36 0 36 87 1 87 86 1
		 36 37 0 37 88 1 88 87 1 37 38 0 38 89 1 89 88 1 38 39 0 39 90 1 90 89 1 39 40 0 40 91 1
		 91 90 1 40 41 0 41 92 1 92 91 1 41 42 0 42 93 1 93 92 1 42 43 0 43 94 1 94 93 1 43 44 0
		 44 95 1 95 94 1 44 45 0 45 96 1 96 95 1 45 46 0 46 97 1 97 96 1 46 47 0 47 98 1 98 97 1
		 47 48 0 48 99 1 99 98 1 48 49 0 49 100 1 100 99 1 49 50 0 50 101 0 101 100 1 52 103 1
		 103 102 1 102 51 0 53 104 1 104 103 1 54 105 1 105 104 1 55 106 1 106 105 1 56 107 1
		 107 106 1 57 108 1 108 107 1 58 109 1 109 108 1;
	setAttr ".ed[166:331]" 59 110 1 110 109 1 60 111 1 111 110 1 61 112 1 112 111 1
		 62 113 1 113 112 1 63 114 1 114 113 1 64 115 1 115 114 1 65 116 1 116 115 1 66 117 1
		 117 116 1 67 118 1 118 117 1 68 119 1 119 118 1 69 120 1 120 119 1 70 121 1 121 120 1
		 71 122 1 122 121 1 72 123 1 123 122 1 73 124 1 124 123 1 74 125 1 125 124 1 75 126 1
		 126 125 1 76 127 1 127 126 1 77 128 1 128 127 1 78 129 1 129 128 1 79 130 1 130 129 1
		 80 131 1 131 130 1 81 132 1 132 131 1 82 133 1 133 132 1 83 134 1 134 133 1 84 135 1
		 135 134 1 85 136 1 136 135 1 86 137 1 137 136 1 87 138 1 138 137 1 88 139 1 139 138 1
		 89 140 1 140 139 1 90 141 1 141 140 1 91 142 1 142 141 1 92 143 1 143 142 1 93 144 1
		 144 143 1 94 145 1 145 144 1 95 146 1 146 145 1 96 147 1 147 146 1 97 148 1 148 147 1
		 98 149 1 149 148 1 99 150 1 150 149 1 100 151 1 151 150 1 101 152 0 152 151 1 103 154 1
		 154 153 1 153 102 0 104 155 1 155 154 1 105 156 1 156 155 1 106 157 1 157 156 1 107 158 1
		 158 157 1 108 159 1 159 158 1 109 160 1 160 159 1 110 161 1 161 160 1 111 162 1 162 161 1
		 112 163 1 163 162 1 113 164 1 164 163 1 114 165 1 165 164 1 115 166 1 166 165 1 116 167 1
		 167 166 1 117 168 1 168 167 1 118 169 1 169 168 1 119 170 1 170 169 1 120 171 1 171 170 1
		 121 172 1 172 171 1 122 173 1 173 172 1 123 174 1 174 173 1 124 175 1 175 174 1 125 176 1
		 176 175 1 126 177 1 177 176 1 127 178 1 178 177 1 128 179 1 179 178 1 129 180 1 180 179 1
		 130 181 1 181 180 1 131 182 1 182 181 1 132 183 1 183 182 1 133 184 1 184 183 1 134 185 1
		 185 184 1 135 186 1 186 185 1 136 187 1 187 186 1 137 188 1 188 187 1 138 189 1 189 188 1
		 139 190 1 190 189 1 140 191 1 191 190 1 141 192 1 192 191 1 142 193 1;
	setAttr ".ed[332:497]" 193 192 1 143 194 1 194 193 1 144 195 1 195 194 1 145 196 1
		 196 195 1 146 197 1 197 196 1 147 198 1 198 197 1 148 199 1 199 198 1 149 200 1 200 199 1
		 150 201 1 201 200 1 151 202 1 202 201 1 152 203 0 203 202 1 154 205 1 205 204 1 204 153 0
		 155 206 1 206 205 1 156 207 1 207 206 1 157 208 1 208 207 1 158 209 1 209 208 1 159 210 1
		 210 209 1 160 211 1 211 210 1 161 212 1 212 211 1 162 213 1 213 212 1 163 214 1 214 213 1
		 164 215 1 215 214 1 165 216 1 216 215 1 166 217 1 217 216 1 167 218 1 218 217 1 168 219 1
		 219 218 1 169 220 1 220 219 1 170 221 1 221 220 1 171 222 1 222 221 1 172 223 1 223 222 1
		 173 224 1 224 223 1 174 225 1 225 224 1 175 226 1 226 225 1 176 227 1 227 226 1 177 228 1
		 228 227 1 178 229 1 229 228 1 179 230 1 230 229 1 180 231 1 231 230 1 181 232 1 232 231 1
		 182 233 1 233 232 1 183 234 1 234 233 1 184 235 1 235 234 1 185 236 1 236 235 1 186 237 1
		 237 236 1 187 238 1 238 237 1 188 239 1 239 238 1 189 240 1 240 239 1 190 241 1 241 240 1
		 191 242 1 242 241 1 192 243 1 243 242 1 193 244 1 244 243 1 194 245 1 245 244 1 195 246 1
		 246 245 1 196 247 1 247 246 1 197 248 1 248 247 1 198 249 1 249 248 1 199 250 1 250 249 1
		 200 251 1 251 250 1 201 252 1 252 251 1 202 253 1 253 252 1 203 254 0 254 253 1 205 256 1
		 256 255 1 255 204 0 206 257 1 257 256 1 207 258 1 258 257 1 208 259 1 259 258 1 209 260 1
		 260 259 1 210 261 1 261 260 1 211 262 1 262 261 1 212 263 1 263 262 1 213 264 1 264 263 1
		 214 265 1 265 264 1 215 266 1 266 265 1 216 267 1 267 266 1 217 268 1 268 267 1 218 269 1
		 269 268 1 219 270 1 270 269 1 220 271 1 271 270 1 221 272 1 272 271 1 222 273 1 273 272 1
		 223 274 1 274 273 1 224 275 1 275 274 1 225 276 1 276 275 1 226 277 1;
	setAttr ".ed[498:663]" 277 276 1 227 278 1 278 277 1 228 279 1 279 278 1 229 280 1
		 280 279 1 230 281 1 281 280 1 231 282 1 282 281 1 232 283 1 283 282 1 233 284 1 284 283 1
		 234 285 1 285 284 1 235 286 1 286 285 1 236 287 1 287 286 1 237 288 1 288 287 1 238 289 1
		 289 288 1 239 290 1 290 289 1 240 291 1 291 290 1 241 292 1 292 291 1 242 293 1 293 292 1
		 243 294 1 294 293 1 244 295 1 295 294 1 245 296 1 296 295 1 246 297 1 297 296 1 247 298 1
		 298 297 1 248 299 1 299 298 1 249 300 1 300 299 1 250 301 1 301 300 1 251 302 1 302 301 1
		 252 303 1 303 302 1 253 304 1 304 303 1 254 305 0 305 304 1 256 307 1 307 306 1 306 255 0
		 257 308 1 308 307 1 258 309 1 309 308 1 259 310 1 310 309 1 260 311 1 311 310 1 261 312 1
		 312 311 1 262 313 1 313 312 1 263 314 1 314 313 1 264 315 1 315 314 1 265 316 1 316 315 1
		 266 317 1 317 316 1 267 318 1 318 317 1 268 319 1 319 318 1 269 320 1 320 319 1 270 321 1
		 321 320 1 271 322 1 322 321 1 272 323 1 323 322 1 273 324 1 324 323 1 274 325 1 325 324 1
		 275 326 1 326 325 1 276 327 1 327 326 1 277 328 1 328 327 1 278 329 1 329 328 1 279 330 1
		 330 329 1 280 331 1 331 330 1 281 332 1 332 331 1 282 333 1 333 332 1 283 334 1 334 333 1
		 284 335 1 335 334 1 285 336 1 336 335 1 286 337 1 337 336 1 287 338 1 338 337 1 288 339 1
		 339 338 1 289 340 1 340 339 1 290 341 1 341 340 1 291 342 1 342 341 1 292 343 1 343 342 1
		 293 344 1 344 343 1 294 345 1 345 344 1 295 346 1 346 345 1 296 347 1 347 346 1 297 348 1
		 348 347 1 298 349 1 349 348 1 299 350 1 350 349 1 300 351 1 351 350 1 301 352 1 352 351 1
		 302 353 1 353 352 1 303 354 1 354 353 1 304 355 1 355 354 1 305 356 0 356 355 1 307 358 1
		 358 357 1 357 306 0 308 359 1 359 358 1 309 360 1 360 359 1 310 361 1;
	setAttr ".ed[664:829]" 361 360 1 311 362 1 362 361 1 312 363 1 363 362 1 313 364 1
		 364 363 1 314 365 1 365 364 1 315 366 1 366 365 1 316 367 1 367 366 1 317 368 1 368 367 1
		 318 369 1 369 368 1 319 370 1 370 369 1 320 371 1 371 370 1 321 372 1 372 371 1 322 373 1
		 373 372 1 323 374 1 374 373 1 324 375 1 375 374 1 325 376 1 376 375 1 326 377 1 377 376 1
		 327 378 1 378 377 1 328 379 1 379 378 1 329 380 1 380 379 1 330 381 1 381 380 1 331 382 1
		 382 381 1 332 383 1 383 382 1 333 384 1 384 383 1 334 385 1 385 384 1 335 386 1 386 385 1
		 336 387 1 387 386 1 337 388 1 388 387 1 338 389 1 389 388 1 339 390 1 390 389 1 340 391 1
		 391 390 1 341 392 1 392 391 1 342 393 1 393 392 1 343 394 1 394 393 1 344 395 1 395 394 1
		 345 396 1 396 395 1 346 397 1 397 396 1 347 398 1 398 397 1 348 399 1 399 398 1 349 400 1
		 400 399 1 350 401 1 401 400 1 351 402 1 402 401 1 352 403 1 403 402 1 353 404 1 404 403 1
		 354 405 1 405 404 1 355 406 1 406 405 1 356 407 0 407 406 1 358 409 1 409 408 1 408 357 0
		 359 410 1 410 409 1 360 411 1 411 410 1 361 412 1 412 411 1 362 413 1 413 412 1 363 414 1
		 414 413 1 364 415 1 415 414 1 365 416 1 416 415 1 366 417 1 417 416 1 367 418 1 418 417 1
		 368 419 1 419 418 1 369 420 1 420 419 1 370 421 1 421 420 1 371 422 1 422 421 1 372 423 1
		 423 422 1 373 424 1 424 423 1 374 425 1 425 424 1 375 426 1 426 425 1 376 427 1 427 426 1
		 377 428 1 428 427 1 378 429 1 429 428 1 379 430 1 430 429 1 380 431 1 431 430 1 381 432 1
		 432 431 1 382 433 1 433 432 1 383 434 1 434 433 1 384 435 1 435 434 1 385 436 1 436 435 1
		 386 437 1 437 436 1 387 438 1 438 437 1 388 439 1 439 438 1 389 440 1 440 439 1 390 441 1
		 441 440 1 391 442 1 442 441 1 392 443 1 443 442 1 393 444 1 444 443 1;
	setAttr ".ed[830:995]" 394 445 1 445 444 1 395 446 1 446 445 1 396 447 1 447 446 1
		 397 448 1 448 447 1 398 449 1 449 448 1 399 450 1 450 449 1 400 451 1 451 450 1 401 452 1
		 452 451 1 402 453 1 453 452 1 403 454 1 454 453 1 404 455 1 455 454 1 405 456 1 456 455 1
		 406 457 1 457 456 1 407 458 0 458 457 1 409 460 1 460 459 1 459 408 0 410 461 1 461 460 1
		 411 462 1 462 461 1 412 463 1 463 462 1 413 464 1 464 463 1 414 465 1 465 464 1 415 466 1
		 466 465 1 416 467 1 467 466 1 417 468 1 468 467 1 418 469 1 469 468 1 419 470 1 470 469 1
		 420 471 1 471 470 1 421 472 1 472 471 1 422 473 1 473 472 1 423 474 1 474 473 1 424 475 1
		 475 474 1 425 476 1 476 475 1 426 477 1 477 476 1 427 478 1 478 477 1 428 479 1 479 478 1
		 429 480 1 480 479 1 430 481 1 481 480 1 431 482 1 482 481 1 432 483 1 483 482 1 433 484 1
		 484 483 1 434 485 1 485 484 1 435 486 1 486 485 1 436 487 1 487 486 1 437 488 1 488 487 1
		 438 489 1 489 488 1 439 490 1 490 489 1 440 491 1 491 490 1 441 492 1 492 491 1 442 493 1
		 493 492 1 443 494 1 494 493 1 444 495 1 495 494 1 445 496 1 496 495 1 446 497 1 497 496 1
		 447 498 1 498 497 1 448 499 1 499 498 1 449 500 1 500 499 1 450 501 1 501 500 1 451 502 1
		 502 501 1 452 503 1 503 502 1 453 504 1 504 503 1 454 505 1 505 504 1 455 506 1 506 505 1
		 456 507 1 507 506 1 457 508 1 508 507 1 458 509 0 509 508 1 460 511 1 511 510 1 510 459 0
		 461 512 1 512 511 1 462 513 1 513 512 1 463 514 1 514 513 1 464 515 1 515 514 1 465 516 1
		 516 515 1 466 517 1 517 516 1 467 518 1 518 517 1 468 519 1 519 518 1 469 520 1 520 519 1
		 470 521 1 521 520 1 471 522 1 522 521 1 472 523 1 523 522 1 473 524 1 524 523 1 474 525 1
		 525 524 1 475 526 1 526 525 1 476 527 1 527 526 1 477 528 1 528 527 1;
	setAttr ".ed[996:1161]" 478 529 1 529 528 1 479 530 1 530 529 1 480 531 1 531 530 1
		 481 532 1 532 531 1 482 533 1 533 532 1 483 534 1 534 533 1 484 535 1 535 534 1 485 536 1
		 536 535 1 486 537 1 537 536 1 487 538 1 538 537 1 488 539 1 539 538 1 489 540 1 540 539 1
		 490 541 1 541 540 1 491 542 1 542 541 1 492 543 1 543 542 1 493 544 1 544 543 1 494 545 1
		 545 544 1 495 546 1 546 545 1 496 547 1 547 546 1 497 548 1 548 547 1 498 549 1 549 548 1
		 499 550 1 550 549 1 500 551 1 551 550 1 501 552 1 552 551 1 502 553 1 553 552 1 503 554 1
		 554 553 1 504 555 1 555 554 1 505 556 1 556 555 1 506 557 1 557 556 1 507 558 1 558 557 1
		 508 559 1 559 558 1 509 560 0 560 559 1 511 562 1 562 561 1 561 510 0 512 563 1 563 562 1
		 513 564 1 564 563 1 514 565 1 565 564 1 515 566 1 566 565 1 516 567 1 567 566 1 517 568 1
		 568 567 1 518 569 1 569 568 1 519 570 1 570 569 1 520 571 1 571 570 1 521 572 1 572 571 1
		 522 573 1 573 572 1 523 574 1 574 573 1 524 575 1 575 574 1 525 576 1 576 575 1 526 577 1
		 577 576 1 527 578 1 578 577 1 528 579 1 579 578 1 529 580 1 580 579 1 530 581 1 581 580 1
		 531 582 1 582 581 1 532 583 1 583 582 1 533 584 1 584 583 1 534 585 1 585 584 1 535 586 1
		 586 585 1 536 587 1 587 586 1 537 588 1 588 587 1 538 589 1 589 588 1 539 590 1 590 589 1
		 540 591 1 591 590 1 541 592 1 592 591 1 542 593 1 593 592 1 543 594 1 594 593 1 544 595 1
		 595 594 1 545 596 1 596 595 1 546 597 1 597 596 1 547 598 1 598 597 1 548 599 1 599 598 1
		 549 600 1 600 599 1 550 601 1 601 600 1 551 602 1 602 601 1 552 603 1 603 602 1 553 604 1
		 604 603 1 554 605 1 605 604 1 555 606 1 606 605 1 556 607 1 607 606 1 557 608 1 608 607 1
		 558 609 1 609 608 1 559 610 1 610 609 1 560 611 0 611 610 1 562 613 1;
	setAttr ".ed[1162:1327]" 613 612 1 612 561 0 563 614 1 614 613 1 564 615 1 615 614 1
		 565 616 1 616 615 1 566 617 1 617 616 1 567 618 1 618 617 1 568 619 1 619 618 1 569 620 1
		 620 619 1 570 621 1 621 620 1 571 622 1 622 621 1 572 623 1 623 622 1 573 624 1 624 623 1
		 574 625 1 625 624 1 575 626 1 626 625 1 576 627 1 627 626 1 577 628 1 628 627 1 578 629 1
		 629 628 1 579 630 1 630 629 1 580 631 1 631 630 1 581 632 1 632 631 1 582 633 1 633 632 1
		 583 634 1 634 633 1 584 635 1 635 634 1 585 636 1 636 635 1 586 637 1 637 636 1 587 638 1
		 638 637 1 588 639 1 639 638 1 589 640 1 640 639 1 590 641 1 641 640 1 591 642 1 642 641 1
		 592 643 1 643 642 1 593 644 1 644 643 1 594 645 1 645 644 1 595 646 1 646 645 1 596 647 1
		 647 646 1 597 648 1 648 647 1 598 649 1 649 648 1 599 650 1 650 649 1 600 651 1 651 650 1
		 601 652 1 652 651 1 602 653 1 653 652 1 603 654 1 654 653 1 604 655 1 655 654 1 605 656 1
		 656 655 1 606 657 1 657 656 1 607 658 1 658 657 1 608 659 1 659 658 1 609 660 1 660 659 1
		 610 661 1 661 660 1 611 662 0 662 661 1 613 664 1 664 663 1 663 612 0 614 665 1 665 664 1
		 615 666 1 666 665 1 616 667 1 667 666 1 617 668 1 668 667 1 618 669 1 669 668 1 619 670 1
		 670 669 1 620 671 1 671 670 1 621 672 1 672 671 1 622 673 1 673 672 1 623 674 1 674 673 1
		 624 675 1 675 674 1 625 676 1 676 675 1 626 677 1 677 676 1 627 678 1 678 677 1 628 679 1
		 679 678 1 629 680 1 680 679 1 630 681 1 681 680 1 631 682 1 682 681 1 632 683 1 683 682 1
		 633 684 1 684 683 1 634 685 1 685 684 1 635 686 1 686 685 1 636 687 1 687 686 1 637 688 1
		 688 687 1 638 689 1 689 688 1 639 690 1 690 689 1 640 691 1 691 690 1 641 692 1 692 691 1
		 642 693 1 693 692 1 643 694 1 694 693 1 644 695 1 695 694 1 645 696 1;
	setAttr ".ed[1328:1493]" 696 695 1 646 697 1 697 696 1 647 698 1 698 697 1 648 699 1
		 699 698 1 649 700 1 700 699 1 650 701 1 701 700 1 651 702 1 702 701 1 652 703 1 703 702 1
		 653 704 1 704 703 1 654 705 1 705 704 1 655 706 1 706 705 1 656 707 1 707 706 1 657 708 1
		 708 707 1 658 709 1 709 708 1 659 710 1 710 709 1 660 711 1 711 710 1 661 712 1 712 711 1
		 662 713 0 713 712 1 664 715 1 715 714 1 714 663 0 665 716 1 716 715 1 666 717 1 717 716 1
		 667 718 1 718 717 1 668 719 1 719 718 1 669 720 1 720 719 1 670 721 1 721 720 1 671 722 1
		 722 721 1 672 723 1 723 722 1 673 724 1 724 723 1 674 725 1 725 724 1 675 726 1 726 725 1
		 676 727 1 727 726 1 677 728 1 728 727 1 678 729 1 729 728 1 679 730 1 730 729 1 680 731 1
		 731 730 1 681 732 1 732 731 1 682 733 1 733 732 1 683 734 1 734 733 1 684 735 1 735 734 1
		 685 736 1 736 735 1 686 737 1 737 736 1 687 738 1 738 737 1 688 739 1 739 738 1 689 740 1
		 740 739 1 690 741 1 741 740 1 691 742 1 742 741 1 692 743 1 743 742 1 693 744 1 744 743 1
		 694 745 1 745 744 1 695 746 1 746 745 1 696 747 1 747 746 1 697 748 1 748 747 1 698 749 1
		 749 748 1 699 750 1 750 749 1 700 751 1 751 750 1 701 752 1 752 751 1 702 753 1 753 752 1
		 703 754 1 754 753 1 704 755 1 755 754 1 705 756 1 756 755 1 706 757 1 757 756 1 707 758 1
		 758 757 1 708 759 1 759 758 1 709 760 1 760 759 1 710 761 1 761 760 1 711 762 1 762 761 1
		 712 763 1 763 762 1 713 764 0 764 763 1 715 766 1 766 765 1 765 714 0 716 767 1 767 766 1
		 717 768 1 768 767 1 718 769 1 769 768 1 719 770 1 770 769 1 720 771 1 771 770 1 721 772 1
		 772 771 1 722 773 1 773 772 1 723 774 1 774 773 1 724 775 1 775 774 1 725 776 1 776 775 1
		 726 777 1 777 776 1 727 778 1 778 777 1 728 779 1 779 778 1 729 780 1;
	setAttr ".ed[1494:1659]" 780 779 1 730 781 1 781 780 1 731 782 1 782 781 1 732 783 1
		 783 782 1 733 784 1 784 783 1 734 785 1 785 784 1 735 786 1 786 785 1 736 787 1 787 786 1
		 737 788 1 788 787 1 738 789 1 789 788 1 739 790 1 790 789 1 740 791 1 791 790 1 741 792 1
		 792 791 1 742 793 1 793 792 1 743 794 1 794 793 1 744 795 1 795 794 1 745 796 1 796 795 1
		 746 797 1 797 796 1 747 798 1 798 797 1 748 799 1 799 798 1 749 800 1 800 799 1 750 801 1
		 801 800 1 751 802 1 802 801 1 752 803 1 803 802 1 753 804 1 804 803 1 754 805 1 805 804 1
		 755 806 1 806 805 1 756 807 1 807 806 1 757 808 1 808 807 1 758 809 1 809 808 1 759 810 1
		 810 809 1 760 811 1 811 810 1 761 812 1 812 811 1 762 813 1 813 812 1 763 814 1 814 813 1
		 764 815 0 815 814 1 766 817 1 817 816 1 816 765 0 767 818 1 818 817 1 768 819 1 819 818 1
		 769 820 1 820 819 1 770 821 1 821 820 1 771 822 1 822 821 1 772 823 1 823 822 1 773 824 1
		 824 823 1 774 825 1 825 824 1 775 826 1 826 825 1 776 827 1 827 826 1 777 828 1 828 827 1
		 778 829 1 829 828 1 779 830 1 830 829 1 780 831 1 831 830 1 781 832 1 832 831 1 782 833 1
		 833 832 1 783 834 1 834 833 1 784 835 1 835 834 1 785 836 1 836 835 1 786 837 1 837 836 1
		 787 838 1 838 837 1 788 839 1 839 838 1 789 840 1 840 839 1 790 841 1 841 840 1 791 842 1
		 842 841 1 792 843 1 843 842 1 793 844 1 844 843 1 794 845 1 845 844 1 795 846 1 846 845 1
		 796 847 1 847 846 1 797 848 1 848 847 1 798 849 1 849 848 1 799 850 1 850 849 1 800 851 1
		 851 850 1 801 852 1 852 851 1 802 853 1 853 852 1 803 854 1 854 853 1 804 855 1 855 854 1
		 805 856 1 856 855 1 806 857 1 857 856 1 807 858 1 858 857 1 808 859 1 859 858 1 809 860 1
		 860 859 1 810 861 1 861 860 1 811 862 1 862 861 1 812 863 1 863 862 1;
	setAttr ".ed[1660:1825]" 813 864 1 864 863 1 814 865 1 865 864 1 815 866 0 866 865 1
		 817 868 1 868 867 1 867 816 0 818 869 1 869 868 1 819 870 1 870 869 1 820 871 1 871 870 1
		 821 872 1 872 871 1 822 873 1 873 872 1 823 874 1 874 873 1 824 875 1 875 874 1 825 876 1
		 876 875 1 826 877 1 877 876 1 827 878 1 878 877 1 828 879 1 879 878 1 829 880 1 880 879 1
		 830 881 1 881 880 1 831 882 1 882 881 1 832 883 1 883 882 1 833 884 1 884 883 1 834 885 1
		 885 884 1 835 886 1 886 885 1 836 887 1 887 886 1 837 888 1 888 887 1 838 889 1 889 888 1
		 839 890 1 890 889 1 840 891 1 891 890 1 841 892 1 892 891 1 842 893 1 893 892 1 843 894 1
		 894 893 1 844 895 1 895 894 1 845 896 1 896 895 1 846 897 1 897 896 1 847 898 1 898 897 1
		 848 899 1 899 898 1 849 900 1 900 899 1 850 901 1 901 900 1 851 902 1 902 901 1 852 903 1
		 903 902 1 853 904 1 904 903 1 854 905 1 905 904 1 855 906 1 906 905 1 856 907 1 907 906 1
		 857 908 1 908 907 1 858 909 1 909 908 1 859 910 1 910 909 1 860 911 1 911 910 1 861 912 1
		 912 911 1 862 913 1 913 912 1 863 914 1 914 913 1 864 915 1 915 914 1 865 916 1 916 915 1
		 866 917 0 917 916 1 868 919 1 919 918 1 918 867 0 869 920 1 920 919 1 870 921 1 921 920 1
		 871 922 1 922 921 1 872 923 1 923 922 1 873 924 1 924 923 1 874 925 1 925 924 1 875 926 1
		 926 925 1 876 927 1 927 926 1 877 928 1 928 927 1 878 929 1 929 928 1 879 930 1 930 929 1
		 880 931 1 931 930 1 881 932 1 932 931 1 882 933 1 933 932 1 883 934 1 934 933 1 884 935 1
		 935 934 1 885 936 1 936 935 1 886 937 1 937 936 1 887 938 1 938 937 1 888 939 1 939 938 1
		 889 940 1 940 939 1 890 941 1 941 940 1 891 942 1 942 941 1 892 943 1 943 942 1 893 944 1
		 944 943 1 894 945 1 945 944 1 895 946 1 946 945 1 896 947 1 947 946 1;
	setAttr ".ed[1826:1991]" 897 948 1 948 947 1 898 949 1 949 948 1 899 950 1 950 949 1
		 900 951 1 951 950 1 901 952 1 952 951 1 902 953 1 953 952 1 903 954 1 954 953 1 904 955 1
		 955 954 1 905 956 1 956 955 1 906 957 1 957 956 1 907 958 1 958 957 1 908 959 1 959 958 1
		 909 960 1 960 959 1 910 961 1 961 960 1 911 962 1 962 961 1 912 963 1 963 962 1 913 964 1
		 964 963 1 914 965 1 965 964 1 915 966 1 966 965 1 916 967 1 967 966 1 917 968 0 968 967 1
		 919 970 1 970 969 1 969 918 0 920 971 1 971 970 1 921 972 1 972 971 1 922 973 1 973 972 1
		 923 974 1 974 973 1 924 975 1 975 974 1 925 976 1 976 975 1 926 977 1 977 976 1 927 978 1
		 978 977 1 928 979 1 979 978 1 929 980 1 980 979 1 930 981 1 981 980 1 931 982 1 982 981 1
		 932 983 1 983 982 1 933 984 1 984 983 1 934 985 1 985 984 1 935 986 1 986 985 1 936 987 1
		 987 986 1 937 988 1 988 987 1 938 989 1 989 988 1 939 990 1 990 989 1 940 991 1 991 990 1
		 941 992 1 992 991 1 942 993 1 993 992 1 943 994 1 994 993 1 944 995 1 995 994 1 945 996 1
		 996 995 1 946 997 1 997 996 1 947 998 1 998 997 1 948 999 1 999 998 1 949 1000 1
		 1000 999 1 950 1001 1 1001 1000 1 951 1002 1 1002 1001 1 952 1003 1 1003 1002 1 953 1004 1
		 1004 1003 1 954 1005 1 1005 1004 1 955 1006 1 1006 1005 1 956 1007 1 1007 1006 1
		 957 1008 1 1008 1007 1 958 1009 1 1009 1008 1 959 1010 1 1010 1009 1 960 1011 1 1011 1010 1
		 961 1012 1 1012 1011 1 962 1013 1 1013 1012 1 963 1014 1 1014 1013 1 964 1015 1 1015 1014 1
		 965 1016 1 1016 1015 1 966 1017 1 1017 1016 1 967 1018 1 1018 1017 1 968 1019 0 1019 1018 1
		 970 1021 1 1021 1020 1 1020 969 0 971 1022 1 1022 1021 1 972 1023 1 1023 1022 1 973 1024 1
		 1024 1023 1 974 1025 1 1025 1024 1 975 1026 1 1026 1025 1 976 1027 1 1027 1026 1
		 977 1028 1 1028 1027 1 978 1029 1 1029 1028 1 979 1030 1 1030 1029 1 980 1031 1 1031 1030 1;
	setAttr ".ed[1992:2157]" 981 1032 1 1032 1031 1 982 1033 1 1033 1032 1 983 1034 1
		 1034 1033 1 984 1035 1 1035 1034 1 985 1036 1 1036 1035 1 986 1037 1 1037 1036 1
		 987 1038 1 1038 1037 1 988 1039 1 1039 1038 1 989 1040 1 1040 1039 1 990 1041 1 1041 1040 1
		 991 1042 1 1042 1041 1 992 1043 1 1043 1042 1 993 1044 1 1044 1043 1 994 1045 1 1045 1044 1
		 995 1046 1 1046 1045 1 996 1047 1 1047 1046 1 997 1048 1 1048 1047 1 998 1049 1 1049 1048 1
		 999 1050 1 1050 1049 1 1000 1051 1 1051 1050 1 1001 1052 1 1052 1051 1 1002 1053 1
		 1053 1052 1 1003 1054 1 1054 1053 1 1004 1055 1 1055 1054 1 1005 1056 1 1056 1055 1
		 1006 1057 1 1057 1056 1 1007 1058 1 1058 1057 1 1008 1059 1 1059 1058 1 1009 1060 1
		 1060 1059 1 1010 1061 1 1061 1060 1 1011 1062 1 1062 1061 1 1012 1063 1 1063 1062 1
		 1013 1064 1 1064 1063 1 1014 1065 1 1065 1064 1 1015 1066 1 1066 1065 1 1016 1067 1
		 1067 1066 1 1017 1068 1 1068 1067 1 1018 1069 1 1069 1068 1 1019 1070 0 1070 1069 1
		 1021 1072 1 1072 1071 1 1071 1020 0 1022 1073 1 1073 1072 1 1023 1074 1 1074 1073 1
		 1024 1075 1 1075 1074 1 1025 1076 1 1076 1075 1 1026 1077 1 1077 1076 1 1027 1078 1
		 1078 1077 1 1028 1079 1 1079 1078 1 1029 1080 1 1080 1079 1 1030 1081 1 1081 1080 1
		 1031 1082 1 1082 1081 1 1032 1083 1 1083 1082 1 1033 1084 1 1084 1083 1 1034 1085 1
		 1085 1084 1 1035 1086 1 1086 1085 1 1036 1087 1 1087 1086 1 1037 1088 1 1088 1087 1
		 1038 1089 1 1089 1088 1 1039 1090 1 1090 1089 1 1040 1091 1 1091 1090 1 1041 1092 1
		 1092 1091 1 1042 1093 1 1093 1092 1 1043 1094 1 1094 1093 1 1044 1095 1 1095 1094 1
		 1045 1096 1 1096 1095 1 1046 1097 1 1097 1096 1 1047 1098 1 1098 1097 1 1048 1099 1
		 1099 1098 1 1049 1100 1 1100 1099 1 1050 1101 1 1101 1100 1 1051 1102 1 1102 1101 1
		 1052 1103 1 1103 1102 1 1053 1104 1 1104 1103 1 1054 1105 1 1105 1104 1 1055 1106 1
		 1106 1105 1 1056 1107 1 1107 1106 1 1057 1108 1 1108 1107 1 1058 1109 1 1109 1108 1
		 1059 1110 1 1110 1109 1 1060 1111 1 1111 1110 1 1061 1112 1 1112 1111 1 1062 1113 1
		 1113 1112 1 1063 1114 1 1114 1113 1 1064 1115 1;
	setAttr ".ed[2158:2323]" 1115 1114 1 1065 1116 1 1116 1115 1 1066 1117 1 1117 1116 1
		 1067 1118 1 1118 1117 1 1068 1119 1 1119 1118 1 1069 1120 1 1120 1119 1 1070 1121 0
		 1121 1120 1 1072 1123 1 1123 1122 1 1122 1071 0 1073 1124 1 1124 1123 1 1074 1125 1
		 1125 1124 1 1075 1126 1 1126 1125 1 1076 1127 1 1127 1126 1 1077 1128 1 1128 1127 1
		 1078 1129 1 1129 1128 1 1079 1130 1 1130 1129 1 1080 1131 1 1131 1130 1 1081 1132 1
		 1132 1131 1 1082 1133 1 1133 1132 1 1083 1134 1 1134 1133 1 1084 1135 1 1135 1134 1
		 1085 1136 1 1136 1135 1 1086 1137 1 1137 1136 1 1087 1138 1 1138 1137 1 1088 1139 1
		 1139 1138 1 1089 1140 1 1140 1139 1 1090 1141 1 1141 1140 1 1091 1142 1 1142 1141 1
		 1092 1143 1 1143 1142 1 1093 1144 1 1144 1143 1 1094 1145 1 1145 1144 1 1095 1146 1
		 1146 1145 1 1096 1147 1 1147 1146 1 1097 1148 1 1148 1147 1 1098 1149 1 1149 1148 1
		 1099 1150 1 1150 1149 1 1100 1151 1 1151 1150 1 1101 1152 1 1152 1151 1 1102 1153 1
		 1153 1152 1 1103 1154 1 1154 1153 1 1104 1155 1 1155 1154 1 1105 1156 1 1156 1155 1
		 1106 1157 1 1157 1156 1 1107 1158 1 1158 1157 1 1108 1159 1 1159 1158 1 1109 1160 1
		 1160 1159 1 1110 1161 1 1161 1160 1 1111 1162 1 1162 1161 1 1112 1163 1 1163 1162 1
		 1113 1164 1 1164 1163 1 1114 1165 1 1165 1164 1 1115 1166 1 1166 1165 1 1116 1167 1
		 1167 1166 1 1117 1168 1 1168 1167 1 1118 1169 1 1169 1168 1 1119 1170 1 1170 1169 1
		 1120 1171 1 1171 1170 1 1121 1172 0 1172 1171 1 1123 1174 1 1174 1173 1 1173 1122 0
		 1124 1175 1 1175 1174 1 1125 1176 1 1176 1175 1 1126 1177 1 1177 1176 1 1127 1178 1
		 1178 1177 1 1128 1179 1 1179 1178 1 1129 1180 1 1180 1179 1 1130 1181 1 1181 1180 1
		 1131 1182 1 1182 1181 1 1132 1183 1 1183 1182 1 1133 1184 1 1184 1183 1 1134 1185 1
		 1185 1184 1 1135 1186 1 1186 1185 1 1136 1187 1 1187 1186 1 1137 1188 1 1188 1187 1
		 1138 1189 1 1189 1188 1 1139 1190 1 1190 1189 1 1140 1191 1 1191 1190 1 1141 1192 1
		 1192 1191 1 1142 1193 1 1193 1192 1 1143 1194 1 1194 1193 1 1144 1195 1 1195 1194 1
		 1145 1196 1 1196 1195 1 1146 1197 1 1197 1196 1 1147 1198 1 1198 1197 1 1148 1199 1;
	setAttr ".ed[2324:2489]" 1199 1198 1 1149 1200 1 1200 1199 1 1150 1201 1 1201 1200 1
		 1151 1202 1 1202 1201 1 1152 1203 1 1203 1202 1 1153 1204 1 1204 1203 1 1154 1205 1
		 1205 1204 1 1155 1206 1 1206 1205 1 1156 1207 1 1207 1206 1 1157 1208 1 1208 1207 1
		 1158 1209 1 1209 1208 1 1159 1210 1 1210 1209 1 1160 1211 1 1211 1210 1 1161 1212 1
		 1212 1211 1 1162 1213 1 1213 1212 1 1163 1214 1 1214 1213 1 1164 1215 1 1215 1214 1
		 1165 1216 1 1216 1215 1 1166 1217 1 1217 1216 1 1167 1218 1 1218 1217 1 1168 1219 1
		 1219 1218 1 1169 1220 1 1220 1219 1 1170 1221 1 1221 1220 1 1171 1222 1 1222 1221 1
		 1172 1223 0 1223 1222 1 1174 1225 1 1225 1224 1 1224 1173 0 1175 1226 1 1226 1225 1
		 1176 1227 1 1227 1226 1 1177 1228 1 1228 1227 1 1178 1229 1 1229 1228 1 1179 1230 1
		 1230 1229 1 1180 1231 1 1231 1230 1 1181 1232 1 1232 1231 1 1182 1233 1 1233 1232 1
		 1183 1234 1 1234 1233 1 1184 1235 1 1235 1234 1 1185 1236 1 1236 1235 1 1186 1237 1
		 1237 1236 1 1187 1238 1 1238 1237 1 1188 1239 1 1239 1238 1 1189 1240 1 1240 1239 1
		 1190 1241 1 1241 1240 1 1191 1242 1 1242 1241 1 1192 1243 1 1243 1242 1 1193 1244 1
		 1244 1243 1 1194 1245 1 1245 1244 1 1195 1246 1 1246 1245 1 1196 1247 1 1247 1246 1
		 1197 1248 1 1248 1247 1 1198 1249 1 1249 1248 1 1199 1250 1 1250 1249 1 1200 1251 1
		 1251 1250 1 1201 1252 1 1252 1251 1 1202 1253 1 1253 1252 1 1203 1254 1 1254 1253 1
		 1204 1255 1 1255 1254 1 1205 1256 1 1256 1255 1 1206 1257 1 1257 1256 1 1207 1258 1
		 1258 1257 1 1208 1259 1 1259 1258 1 1209 1260 1 1260 1259 1 1210 1261 1 1261 1260 1
		 1211 1262 1 1262 1261 1 1212 1263 1 1263 1262 1 1213 1264 1 1264 1263 1 1214 1265 1
		 1265 1264 1 1215 1266 1 1266 1265 1 1216 1267 1 1267 1266 1 1217 1268 1 1268 1267 1
		 1218 1269 1 1269 1268 1 1219 1270 1 1270 1269 1 1220 1271 1 1271 1270 1 1221 1272 1
		 1272 1271 1 1222 1273 1 1273 1272 1 1223 1274 0 1274 1273 1 1225 1276 1 1276 1275 1
		 1275 1224 0 1226 1277 1 1277 1276 1 1227 1278 1 1278 1277 1 1228 1279 1 1279 1278 1
		 1229 1280 1 1280 1279 1 1230 1281 1 1281 1280 1 1231 1282 1 1282 1281 1 1232 1283 1;
	setAttr ".ed[2490:2655]" 1283 1282 1 1233 1284 1 1284 1283 1 1234 1285 1 1285 1284 1
		 1235 1286 1 1286 1285 1 1236 1287 1 1287 1286 1 1237 1288 1 1288 1287 1 1238 1289 1
		 1289 1288 1 1239 1290 1 1290 1289 1 1240 1291 1 1291 1290 1 1241 1292 1 1292 1291 1
		 1242 1293 1 1293 1292 1 1243 1294 1 1294 1293 1 1244 1295 1 1295 1294 1 1245 1296 1
		 1296 1295 1 1246 1297 1 1297 1296 1 1247 1298 1 1298 1297 1 1248 1299 1 1299 1298 1
		 1249 1300 1 1300 1299 1 1250 1301 1 1301 1300 1 1251 1302 1 1302 1301 1 1252 1303 1
		 1303 1302 1 1253 1304 1 1304 1303 1 1254 1305 1 1305 1304 1 1255 1306 1 1306 1305 1
		 1256 1307 1 1307 1306 1 1257 1308 1 1308 1307 1 1258 1309 1 1309 1308 1 1259 1310 1
		 1310 1309 1 1260 1311 1 1311 1310 1 1261 1312 1 1312 1311 1 1262 1313 1 1313 1312 1
		 1263 1314 1 1314 1313 1 1264 1315 1 1315 1314 1 1265 1316 1 1316 1315 1 1266 1317 1
		 1317 1316 1 1267 1318 1 1318 1317 1 1268 1319 1 1319 1318 1 1269 1320 1 1320 1319 1
		 1270 1321 1 1321 1320 1 1271 1322 1 1322 1321 1 1272 1323 1 1323 1322 1 1273 1324 1
		 1324 1323 1 1274 1325 0 1325 1324 1 1276 1327 1 1327 1326 1 1326 1275 0 1277 1328 1
		 1328 1327 1 1278 1329 1 1329 1328 1 1279 1330 1 1330 1329 1 1280 1331 1 1331 1330 1
		 1281 1332 1 1332 1331 1 1282 1333 1 1333 1332 1 1283 1334 1 1334 1333 1 1284 1335 1
		 1335 1334 1 1285 1336 1 1336 1335 1 1286 1337 1 1337 1336 1 1287 1338 1 1338 1337 1
		 1288 1339 1 1339 1338 1 1289 1340 1 1340 1339 1 1290 1341 1 1341 1340 1 1291 1342 1
		 1342 1341 1 1292 1343 1 1343 1342 1 1293 1344 1 1344 1343 1 1294 1345 1 1345 1344 1
		 1295 1346 1 1346 1345 1 1296 1347 1 1347 1346 1 1297 1348 1 1348 1347 1 1298 1349 1
		 1349 1348 1 1299 1350 1 1350 1349 1 1300 1351 1 1351 1350 1 1301 1352 1 1352 1351 1
		 1302 1353 1 1353 1352 1 1303 1354 1 1354 1353 1 1304 1355 1 1355 1354 1 1305 1356 1
		 1356 1355 1 1306 1357 1 1357 1356 1 1307 1358 1 1358 1357 1 1308 1359 1 1359 1358 1
		 1309 1360 1 1360 1359 1 1310 1361 1 1361 1360 1 1311 1362 1 1362 1361 1 1312 1363 1
		 1363 1362 1 1313 1364 1 1364 1363 1 1314 1365 1 1365 1364 1 1315 1366 1 1366 1365 1;
	setAttr ".ed[2656:2821]" 1316 1367 1 1367 1366 1 1317 1368 1 1368 1367 1 1318 1369 1
		 1369 1368 1 1319 1370 1 1370 1369 1 1320 1371 1 1371 1370 1 1321 1372 1 1372 1371 1
		 1322 1373 1 1373 1372 1 1323 1374 1 1374 1373 1 1324 1375 1 1375 1374 1 1325 1376 0
		 1376 1375 1 1327 1378 1 1378 1377 1 1377 1326 0 1328 1379 1 1379 1378 1 1329 1380 1
		 1380 1379 1 1330 1381 1 1381 1380 1 1331 1382 1 1382 1381 1 1332 1383 1 1383 1382 1
		 1333 1384 1 1384 1383 1 1334 1385 1 1385 1384 1 1335 1386 1 1386 1385 1 1336 1387 1
		 1387 1386 1 1337 1388 1 1388 1387 1 1338 1389 1 1389 1388 1 1339 1390 1 1390 1389 1
		 1340 1391 1 1391 1390 1 1341 1392 1 1392 1391 1 1342 1393 1 1393 1392 1 1343 1394 1
		 1394 1393 1 1344 1395 1 1395 1394 1 1345 1396 1 1396 1395 1 1346 1397 1 1397 1396 1
		 1347 1398 1 1398 1397 1 1348 1399 1 1399 1398 1 1349 1400 1 1400 1399 1 1350 1401 1
		 1401 1400 1 1351 1402 1 1402 1401 1 1352 1403 1 1403 1402 1 1353 1404 1 1404 1403 1
		 1354 1405 1 1405 1404 1 1355 1406 1 1406 1405 1 1356 1407 1 1407 1406 1 1357 1408 1
		 1408 1407 1 1358 1409 1 1409 1408 1 1359 1410 1 1410 1409 1 1360 1411 1 1411 1410 1
		 1361 1412 1 1412 1411 1 1362 1413 1 1413 1412 1 1363 1414 1 1414 1413 1 1364 1415 1
		 1415 1414 1 1365 1416 1 1416 1415 1 1366 1417 1 1417 1416 1 1367 1418 1 1418 1417 1
		 1368 1419 1 1419 1418 1 1369 1420 1 1420 1419 1 1370 1421 1 1421 1420 1 1371 1422 1
		 1422 1421 1 1372 1423 1 1423 1422 1 1373 1424 1 1424 1423 1 1374 1425 1 1425 1424 1
		 1375 1426 1 1426 1425 1 1376 1427 0 1427 1426 1 1378 1429 1 1429 1428 1 1428 1377 0
		 1379 1430 1 1430 1429 1 1380 1431 1 1431 1430 1 1381 1432 1 1432 1431 1 1382 1433 1
		 1433 1432 1 1383 1434 1 1434 1433 1 1384 1435 1 1435 1434 1 1385 1436 1 1436 1435 1
		 1386 1437 1 1437 1436 1 1387 1438 1 1438 1437 1 1388 1439 1 1439 1438 1 1389 1440 1
		 1440 1439 1 1390 1441 1 1441 1440 1 1391 1442 1 1442 1441 1 1392 1443 1 1443 1442 1
		 1393 1444 1 1444 1443 1 1394 1445 1 1445 1444 1 1395 1446 1 1446 1445 1 1396 1447 1
		 1447 1446 1 1397 1448 1 1448 1447 1 1398 1449 1 1449 1448 1 1399 1450 1 1450 1449 1;
	setAttr ".ed[2822:2987]" 1400 1451 1 1451 1450 1 1401 1452 1 1452 1451 1 1402 1453 1
		 1453 1452 1 1403 1454 1 1454 1453 1 1404 1455 1 1455 1454 1 1405 1456 1 1456 1455 1
		 1406 1457 1 1457 1456 1 1407 1458 1 1458 1457 1 1408 1459 1 1459 1458 1 1409 1460 1
		 1460 1459 1 1410 1461 1 1461 1460 1 1411 1462 1 1462 1461 1 1412 1463 1 1463 1462 1
		 1413 1464 1 1464 1463 1 1414 1465 1 1465 1464 1 1415 1466 1 1466 1465 1 1416 1467 1
		 1467 1466 1 1417 1468 1 1468 1467 1 1418 1469 1 1469 1468 1 1419 1470 1 1470 1469 1
		 1420 1471 1 1471 1470 1 1421 1472 1 1472 1471 1 1422 1473 1 1473 1472 1 1423 1474 1
		 1474 1473 1 1424 1475 1 1475 1474 1 1425 1476 1 1476 1475 1 1426 1477 1 1477 1476 1
		 1427 1478 0 1478 1477 1 1429 1480 1 1480 1479 1 1479 1428 0 1430 1481 1 1481 1480 1
		 1431 1482 1 1482 1481 1 1432 1483 1 1483 1482 1 1433 1484 1 1484 1483 1 1434 1485 1
		 1485 1484 1 1435 1486 1 1486 1485 1 1436 1487 1 1487 1486 1 1437 1488 1 1488 1487 1
		 1438 1489 1 1489 1488 1 1439 1490 1 1490 1489 1 1440 1491 1 1491 1490 1 1441 1492 1
		 1492 1491 1 1442 1493 1 1493 1492 1 1443 1494 1 1494 1493 1 1444 1495 1 1495 1494 1
		 1445 1496 1 1496 1495 1 1446 1497 1 1497 1496 1 1447 1498 1 1498 1497 1 1448 1499 1
		 1499 1498 1 1449 1500 1 1500 1499 1 1450 1501 1 1501 1500 1 1451 1502 1 1502 1501 1
		 1452 1503 1 1503 1502 1 1453 1504 1 1504 1503 1 1454 1505 1 1505 1504 1 1455 1506 1
		 1506 1505 1 1456 1507 1 1507 1506 1 1457 1508 1 1508 1507 1 1458 1509 1 1509 1508 1
		 1459 1510 1 1510 1509 1 1460 1511 1 1511 1510 1 1461 1512 1 1512 1511 1 1462 1513 1
		 1513 1512 1 1463 1514 1 1514 1513 1 1464 1515 1 1515 1514 1 1465 1516 1 1516 1515 1
		 1466 1517 1 1517 1516 1 1467 1518 1 1518 1517 1 1468 1519 1 1519 1518 1 1469 1520 1
		 1520 1519 1 1470 1521 1 1521 1520 1 1471 1522 1 1522 1521 1 1472 1523 1 1523 1522 1
		 1473 1524 1 1524 1523 1 1474 1525 1 1525 1524 1 1475 1526 1 1526 1525 1 1476 1527 1
		 1527 1526 1 1477 1528 1 1528 1527 1 1478 1529 0 1529 1528 1 1480 1531 1 1531 1530 1
		 1530 1479 0 1481 1532 1 1532 1531 1 1482 1533 1 1533 1532 1 1483 1534 1 1534 1533 1;
	setAttr ".ed[2988:3153]" 1484 1535 1 1535 1534 1 1485 1536 1 1536 1535 1 1486 1537 1
		 1537 1536 1 1487 1538 1 1538 1537 1 1488 1539 1 1539 1538 1 1489 1540 1 1540 1539 1
		 1490 1541 1 1541 1540 1 1491 1542 1 1542 1541 1 1492 1543 1 1543 1542 1 1493 1544 1
		 1544 1543 1 1494 1545 1 1545 1544 1 1495 1546 1 1546 1545 1 1496 1547 1 1547 1546 1
		 1497 1548 1 1548 1547 1 1498 1549 1 1549 1548 1 1499 1550 1 1550 1549 1 1500 1551 1
		 1551 1550 1 1501 1552 1 1552 1551 1 1502 1553 1 1553 1552 1 1503 1554 1 1554 1553 1
		 1504 1555 1 1555 1554 1 1505 1556 1 1556 1555 1 1506 1557 1 1557 1556 1 1507 1558 1
		 1558 1557 1 1508 1559 1 1559 1558 1 1509 1560 1 1560 1559 1 1510 1561 1 1561 1560 1
		 1511 1562 1 1562 1561 1 1512 1563 1 1563 1562 1 1513 1564 1 1564 1563 1 1514 1565 1
		 1565 1564 1 1515 1566 1 1566 1565 1 1516 1567 1 1567 1566 1 1517 1568 1 1568 1567 1
		 1518 1569 1 1569 1568 1 1519 1570 1 1570 1569 1 1520 1571 1 1571 1570 1 1521 1572 1
		 1572 1571 1 1522 1573 1 1573 1572 1 1523 1574 1 1574 1573 1 1524 1575 1 1575 1574 1
		 1525 1576 1 1576 1575 1 1526 1577 1 1577 1576 1 1527 1578 1 1578 1577 1 1528 1579 1
		 1579 1578 1 1529 1580 0 1580 1579 1 1531 1582 1 1582 1581 1 1581 1530 0 1532 1583 1
		 1583 1582 1 1533 1584 1 1584 1583 1 1534 1585 1 1585 1584 1 1535 1586 1 1586 1585 1
		 1536 1587 1 1587 1586 1 1537 1588 1 1588 1587 1 1538 1589 1 1589 1588 1 1539 1590 1
		 1590 1589 1 1540 1591 1 1591 1590 1 1541 1592 1 1592 1591 1 1542 1593 1 1593 1592 1
		 1543 1594 1 1594 1593 1 1544 1595 1 1595 1594 1 1545 1596 1 1596 1595 1 1546 1597 1
		 1597 1596 1 1547 1598 1 1598 1597 1 1548 1599 1 1599 1598 1 1549 1600 1 1600 1599 1
		 1550 1601 1 1601 1600 1 1551 1602 1 1602 1601 1 1552 1603 1 1603 1602 1 1553 1604 1
		 1604 1603 1 1554 1605 1 1605 1604 1 1555 1606 1 1606 1605 1 1556 1607 1 1607 1606 1
		 1557 1608 1 1608 1607 1 1558 1609 1 1609 1608 1 1559 1610 1 1610 1609 1 1560 1611 1
		 1611 1610 1 1561 1612 1 1612 1611 1 1562 1613 1 1613 1612 1 1563 1614 1 1614 1613 1
		 1564 1615 1 1615 1614 1 1565 1616 1 1616 1615 1 1566 1617 1 1617 1616 1 1567 1618 1;
	setAttr ".ed[3154:3319]" 1618 1617 1 1568 1619 1 1619 1618 1 1569 1620 1 1620 1619 1
		 1570 1621 1 1621 1620 1 1571 1622 1 1622 1621 1 1572 1623 1 1623 1622 1 1573 1624 1
		 1624 1623 1 1574 1625 1 1625 1624 1 1575 1626 1 1626 1625 1 1576 1627 1 1627 1626 1
		 1577 1628 1 1628 1627 1 1578 1629 1 1629 1628 1 1579 1630 1 1630 1629 1 1580 1631 0
		 1631 1630 1 1582 1633 1 1633 1632 1 1632 1581 0 1583 1634 1 1634 1633 1 1584 1635 1
		 1635 1634 1 1585 1636 1 1636 1635 1 1586 1637 1 1637 1636 1 1587 1638 1 1638 1637 1
		 1588 1639 1 1639 1638 1 1589 1640 1 1640 1639 1 1590 1641 1 1641 1640 1 1591 1642 1
		 1642 1641 1 1592 1643 1 1643 1642 1 1593 1644 1 1644 1643 1 1594 1645 1 1645 1644 1
		 1595 1646 1 1646 1645 1 1596 1647 1 1647 1646 1 1597 1648 1 1648 1647 1 1598 1649 1
		 1649 1648 1 1599 1650 1 1650 1649 1 1600 1651 1 1651 1650 1 1601 1652 1 1652 1651 1
		 1602 1653 1 1653 1652 1 1603 1654 1 1654 1653 1 1604 1655 1 1655 1654 1 1605 1656 1
		 1656 1655 1 1606 1657 1 1657 1656 1 1607 1658 1 1658 1657 1 1608 1659 1 1659 1658 1
		 1609 1660 1 1660 1659 1 1610 1661 1 1661 1660 1 1611 1662 1 1662 1661 1 1612 1663 1
		 1663 1662 1 1613 1664 1 1664 1663 1 1614 1665 1 1665 1664 1 1615 1666 1 1666 1665 1
		 1616 1667 1 1667 1666 1 1617 1668 1 1668 1667 1 1618 1669 1 1669 1668 1 1619 1670 1
		 1670 1669 1 1620 1671 1 1671 1670 1 1621 1672 1 1672 1671 1 1622 1673 1 1673 1672 1
		 1623 1674 1 1674 1673 1 1624 1675 1 1675 1674 1 1625 1676 1 1676 1675 1 1626 1677 1
		 1677 1676 1 1627 1678 1 1678 1677 1 1628 1679 1 1679 1678 1 1629 1680 1 1680 1679 1
		 1630 1681 1 1681 1680 1 1631 1682 0 1682 1681 1 1633 1684 1 1684 1683 1 1683 1632 0
		 1634 1685 1 1685 1684 1 1635 1686 1 1686 1685 1 1636 1687 1 1687 1686 1 1637 1688 1
		 1688 1687 1 1638 1689 1 1689 1688 1 1639 1690 1 1690 1689 1 1640 1691 1 1691 1690 1
		 1641 1692 1 1692 1691 1 1642 1693 1 1693 1692 1 1643 1694 1 1694 1693 1 1644 1695 1
		 1695 1694 1 1645 1696 1 1696 1695 1 1646 1697 1 1697 1696 1 1647 1698 1 1698 1697 1
		 1648 1699 1 1699 1698 1 1649 1700 1 1700 1699 1 1650 1701 1 1701 1700 1 1651 1702 1;
	setAttr ".ed[3320:3485]" 1702 1701 1 1652 1703 1 1703 1702 1 1653 1704 1 1704 1703 1
		 1654 1705 1 1705 1704 1 1655 1706 1 1706 1705 1 1656 1707 1 1707 1706 1 1657 1708 1
		 1708 1707 1 1658 1709 1 1709 1708 1 1659 1710 1 1710 1709 1 1660 1711 1 1711 1710 1
		 1661 1712 1 1712 1711 1 1662 1713 1 1713 1712 1 1663 1714 1 1714 1713 1 1664 1715 1
		 1715 1714 1 1665 1716 1 1716 1715 1 1666 1717 1 1717 1716 1 1667 1718 1 1718 1717 1
		 1668 1719 1 1719 1718 1 1669 1720 1 1720 1719 1 1670 1721 1 1721 1720 1 1671 1722 1
		 1722 1721 1 1672 1723 1 1723 1722 1 1673 1724 1 1724 1723 1 1674 1725 1 1725 1724 1
		 1675 1726 1 1726 1725 1 1676 1727 1 1727 1726 1 1677 1728 1 1728 1727 1 1678 1729 1
		 1729 1728 1 1679 1730 1 1730 1729 1 1680 1731 1 1731 1730 1 1681 1732 1 1732 1731 1
		 1682 1733 0 1733 1732 1 1684 1735 1 1735 1734 1 1734 1683 0 1685 1736 1 1736 1735 1
		 1686 1737 1 1737 1736 1 1687 1738 1 1738 1737 1 1688 1739 1 1739 1738 1 1689 1740 1
		 1740 1739 1 1690 1741 1 1741 1740 1 1691 1742 1 1742 1741 1 1692 1743 1 1743 1742 1
		 1693 1744 1 1744 1743 1 1694 1745 1 1745 1744 1 1695 1746 1 1746 1745 1 1696 1747 1
		 1747 1746 1 1697 1748 1 1748 1747 1 1698 1749 1 1749 1748 1 1699 1750 1 1750 1749 1
		 1700 1751 1 1751 1750 1 1701 1752 1 1752 1751 1 1702 1753 1 1753 1752 1 1703 1754 1
		 1754 1753 1 1704 1755 1 1755 1754 1 1705 1756 1 1756 1755 1 1706 1757 1 1757 1756 1
		 1707 1758 1 1758 1757 1 1708 1759 1 1759 1758 1 1709 1760 1 1760 1759 1 1710 1761 1
		 1761 1760 1 1711 1762 1 1762 1761 1 1712 1763 1 1763 1762 1 1713 1764 1 1764 1763 1
		 1714 1765 1 1765 1764 1 1715 1766 1 1766 1765 1 1716 1767 1 1767 1766 1 1717 1768 1
		 1768 1767 1 1718 1769 1 1769 1768 1 1719 1770 1 1770 1769 1 1720 1771 1 1771 1770 1
		 1721 1772 1 1772 1771 1 1722 1773 1 1773 1772 1 1723 1774 1 1774 1773 1 1724 1775 1
		 1775 1774 1 1725 1776 1 1776 1775 1 1726 1777 1 1777 1776 1 1727 1778 1 1778 1777 1
		 1728 1779 1 1779 1778 1 1729 1780 1 1780 1779 1 1730 1781 1 1781 1780 1 1731 1782 1
		 1782 1781 1 1732 1783 1 1783 1782 1 1733 1784 0 1784 1783 1 1735 1786 1 1786 1785 1;
	setAttr ".ed[3486:3651]" 1785 1734 0 1736 1787 1 1787 1786 1 1737 1788 1 1788 1787 1
		 1738 1789 1 1789 1788 1 1739 1790 1 1790 1789 1 1740 1791 1 1791 1790 1 1741 1792 1
		 1792 1791 1 1742 1793 1 1793 1792 1 1743 1794 1 1794 1793 1 1744 1795 1 1795 1794 1
		 1745 1796 1 1796 1795 1 1746 1797 1 1797 1796 1 1747 1798 1 1798 1797 1 1748 1799 1
		 1799 1798 1 1749 1800 1 1800 1799 1 1750 1801 1 1801 1800 1 1751 1802 1 1802 1801 1
		 1752 1803 1 1803 1802 1 1753 1804 1 1804 1803 1 1754 1805 1 1805 1804 1 1755 1806 1
		 1806 1805 1 1756 1807 1 1807 1806 1 1757 1808 1 1808 1807 1 1758 1809 1 1809 1808 1
		 1759 1810 1 1810 1809 1 1760 1811 1 1811 1810 1 1761 1812 1 1812 1811 1 1762 1813 1
		 1813 1812 1 1763 1814 1 1814 1813 1 1764 1815 1 1815 1814 1 1765 1816 1 1816 1815 1
		 1766 1817 1 1817 1816 1 1767 1818 1 1818 1817 1 1768 1819 1 1819 1818 1 1769 1820 1
		 1820 1819 1 1770 1821 1 1821 1820 1 1771 1822 1 1822 1821 1 1772 1823 1 1823 1822 1
		 1773 1824 1 1824 1823 1 1774 1825 1 1825 1824 1 1775 1826 1 1826 1825 1 1776 1827 1
		 1827 1826 1 1777 1828 1 1828 1827 1 1778 1829 1 1829 1828 1 1779 1830 1 1830 1829 1
		 1780 1831 1 1831 1830 1 1781 1832 1 1832 1831 1 1782 1833 1 1833 1832 1 1783 1834 1
		 1834 1833 1 1784 1835 0 1835 1834 1 1786 1837 1 1837 1836 1 1836 1785 0 1787 1838 1
		 1838 1837 1 1788 1839 1 1839 1838 1 1789 1840 1 1840 1839 1 1790 1841 1 1841 1840 1
		 1791 1842 1 1842 1841 1 1792 1843 1 1843 1842 1 1793 1844 1 1844 1843 1 1794 1845 1
		 1845 1844 1 1795 1846 1 1846 1845 1 1796 1847 1 1847 1846 1 1797 1848 1 1848 1847 1
		 1798 1849 1 1849 1848 1 1799 1850 1 1850 1849 1 1800 1851 1 1851 1850 1 1801 1852 1
		 1852 1851 1 1802 1853 1 1853 1852 1 1803 1854 1 1854 1853 1 1804 1855 1 1855 1854 1
		 1805 1856 1 1856 1855 1 1806 1857 1 1857 1856 1 1807 1858 1 1858 1857 1 1808 1859 1
		 1859 1858 1 1809 1860 1 1860 1859 1 1810 1861 1 1861 1860 1 1811 1862 1 1862 1861 1
		 1812 1863 1 1863 1862 1 1813 1864 1 1864 1863 1 1814 1865 1 1865 1864 1 1815 1866 1
		 1866 1865 1 1816 1867 1 1867 1866 1 1817 1868 1 1868 1867 1 1818 1869 1 1869 1868 1;
	setAttr ".ed[3652:3817]" 1819 1870 1 1870 1869 1 1820 1871 1 1871 1870 1 1821 1872 1
		 1872 1871 1 1822 1873 1 1873 1872 1 1823 1874 1 1874 1873 1 1824 1875 1 1875 1874 1
		 1825 1876 1 1876 1875 1 1826 1877 1 1877 1876 1 1827 1878 1 1878 1877 1 1828 1879 1
		 1879 1878 1 1829 1880 1 1880 1879 1 1830 1881 1 1881 1880 1 1831 1882 1 1882 1881 1
		 1832 1883 1 1883 1882 1 1833 1884 1 1884 1883 1 1834 1885 1 1885 1884 1 1835 1886 0
		 1886 1885 1 1837 1888 1 1888 1887 1 1887 1836 0 1838 1889 1 1889 1888 1 1839 1890 1
		 1890 1889 1 1840 1891 1 1891 1890 1 1841 1892 1 1892 1891 1 1842 1893 1 1893 1892 1
		 1843 1894 1 1894 1893 1 1844 1895 1 1895 1894 1 1845 1896 1 1896 1895 1 1846 1897 1
		 1897 1896 1 1847 1898 1 1898 1897 1 1848 1899 1 1899 1898 1 1849 1900 1 1900 1899 1
		 1850 1901 1 1901 1900 1 1851 1902 1 1902 1901 1 1852 1903 1 1903 1902 1 1853 1904 1
		 1904 1903 1 1854 1905 1 1905 1904 1 1855 1906 1 1906 1905 1 1856 1907 1 1907 1906 1
		 1857 1908 1 1908 1907 1 1858 1909 1 1909 1908 1 1859 1910 1 1910 1909 1 1860 1911 1
		 1911 1910 1 1861 1912 1 1912 1911 1 1862 1913 1 1913 1912 1 1863 1914 1 1914 1913 1
		 1864 1915 1 1915 1914 1 1865 1916 1 1916 1915 1 1866 1917 1 1917 1916 1 1867 1918 1
		 1918 1917 1 1868 1919 1 1919 1918 1 1869 1920 1 1920 1919 1 1870 1921 1 1921 1920 1
		 1871 1922 1 1922 1921 1 1872 1923 1 1923 1922 1 1873 1924 1 1924 1923 1 1874 1925 1
		 1925 1924 1 1875 1926 1 1926 1925 1 1876 1927 1 1927 1926 1 1877 1928 1 1928 1927 1
		 1878 1929 1 1929 1928 1 1879 1930 1 1930 1929 1 1880 1931 1 1931 1930 1 1881 1932 1
		 1932 1931 1 1882 1933 1 1933 1932 1 1883 1934 1 1934 1933 1 1884 1935 1 1935 1934 1
		 1885 1936 1 1936 1935 1 1886 1937 0 1937 1936 1 1888 1939 1 1939 1938 1 1938 1887 0
		 1889 1940 1 1940 1939 1 1890 1941 1 1941 1940 1 1891 1942 1 1942 1941 1 1892 1943 1
		 1943 1942 1 1893 1944 1 1944 1943 1 1894 1945 1 1945 1944 1 1895 1946 1 1946 1945 1
		 1896 1947 1 1947 1946 1 1897 1948 1 1948 1947 1 1898 1949 1 1949 1948 1 1899 1950 1
		 1950 1949 1 1900 1951 1 1951 1950 1 1901 1952 1 1952 1951 1 1902 1953 1 1953 1952 1;
	setAttr ".ed[3818:3983]" 1903 1954 1 1954 1953 1 1904 1955 1 1955 1954 1 1905 1956 1
		 1956 1955 1 1906 1957 1 1957 1956 1 1907 1958 1 1958 1957 1 1908 1959 1 1959 1958 1
		 1909 1960 1 1960 1959 1 1910 1961 1 1961 1960 1 1911 1962 1 1962 1961 1 1912 1963 1
		 1963 1962 1 1913 1964 1 1964 1963 1 1914 1965 1 1965 1964 1 1915 1966 1 1966 1965 1
		 1916 1967 1 1967 1966 1 1917 1968 1 1968 1967 1 1918 1969 1 1969 1968 1 1919 1970 1
		 1970 1969 1 1920 1971 1 1971 1970 1 1921 1972 1 1972 1971 1 1922 1973 1 1973 1972 1
		 1923 1974 1 1974 1973 1 1924 1975 1 1975 1974 1 1925 1976 1 1976 1975 1 1926 1977 1
		 1977 1976 1 1927 1978 1 1978 1977 1 1928 1979 1 1979 1978 1 1929 1980 1 1980 1979 1
		 1930 1981 1 1981 1980 1 1931 1982 1 1982 1981 1 1932 1983 1 1983 1982 1 1933 1984 1
		 1984 1983 1 1934 1985 1 1985 1984 1 1935 1986 1 1986 1985 1 1936 1987 1 1987 1986 1
		 1937 1988 0 1988 1987 1 1939 1990 1 1990 1989 1 1989 1938 0 1940 1991 1 1991 1990 1
		 1941 1992 1 1992 1991 1 1942 1993 1 1993 1992 1 1943 1994 1 1994 1993 1 1944 1995 1
		 1995 1994 1 1945 1996 1 1996 1995 1 1946 1997 1 1997 1996 1 1947 1998 1 1998 1997 1
		 1948 1999 1 1999 1998 1 1949 2000 1 2000 1999 1 1950 2001 1 2001 2000 1 1951 2002 1
		 2002 2001 1 1952 2003 1 2003 2002 1 1953 2004 1 2004 2003 1 1954 2005 1 2005 2004 1
		 1955 2006 1 2006 2005 1 1956 2007 1 2007 2006 1 1957 2008 1 2008 2007 1 1958 2009 1
		 2009 2008 1 1959 2010 1 2010 2009 1 1960 2011 1 2011 2010 1 1961 2012 1 2012 2011 1
		 1962 2013 1 2013 2012 1 1963 2014 1 2014 2013 1 1964 2015 1 2015 2014 1 1965 2016 1
		 2016 2015 1 1966 2017 1 2017 2016 1 1967 2018 1 2018 2017 1 1968 2019 1 2019 2018 1
		 1969 2020 1 2020 2019 1 1970 2021 1 2021 2020 1 1971 2022 1 2022 2021 1 1972 2023 1
		 2023 2022 1 1973 2024 1 2024 2023 1 1974 2025 1 2025 2024 1 1975 2026 1 2026 2025 1
		 1976 2027 1 2027 2026 1 1977 2028 1 2028 2027 1 1978 2029 1 2029 2028 1 1979 2030 1
		 2030 2029 1 1980 2031 1 2031 2030 1 1981 2032 1 2032 2031 1 1982 2033 1 2033 2032 1
		 1983 2034 1 2034 2033 1 1984 2035 1 2035 2034 1 1985 2036 1 2036 2035 1 1986 2037 1;
	setAttr ".ed[3984:4149]" 2037 2036 1 1987 2038 1 2038 2037 1 1988 2039 0 2039 2038 1
		 1990 2041 1 2041 2040 1 2040 1989 0 1991 2042 1 2042 2041 1 1992 2043 1 2043 2042 1
		 1993 2044 1 2044 2043 1 1994 2045 1 2045 2044 1 1995 2046 1 2046 2045 1 1996 2047 1
		 2047 2046 1 1997 2048 1 2048 2047 1 1998 2049 1 2049 2048 1 1999 2050 1 2050 2049 1
		 2000 2051 1 2051 2050 1 2001 2052 1 2052 2051 1 2002 2053 1 2053 2052 1 2003 2054 1
		 2054 2053 1 2004 2055 1 2055 2054 1 2005 2056 1 2056 2055 1 2006 2057 1 2057 2056 1
		 2007 2058 1 2058 2057 1 2008 2059 1 2059 2058 1 2009 2060 1 2060 2059 1 2010 2061 1
		 2061 2060 1 2011 2062 1 2062 2061 1 2012 2063 1 2063 2062 1 2013 2064 1 2064 2063 1
		 2014 2065 1 2065 2064 1 2015 2066 1 2066 2065 1 2016 2067 1 2067 2066 1 2017 2068 1
		 2068 2067 1 2018 2069 1 2069 2068 1 2019 2070 1 2070 2069 1 2020 2071 1 2071 2070 1
		 2021 2072 1 2072 2071 1 2022 2073 1 2073 2072 1 2023 2074 1 2074 2073 1 2024 2075 1
		 2075 2074 1 2025 2076 1 2076 2075 1 2026 2077 1 2077 2076 1 2027 2078 1 2078 2077 1
		 2028 2079 1 2079 2078 1 2029 2080 1 2080 2079 1 2030 2081 1 2081 2080 1 2031 2082 1
		 2082 2081 1 2032 2083 1 2083 2082 1 2033 2084 1 2084 2083 1 2034 2085 1 2085 2084 1
		 2035 2086 1 2086 2085 1 2036 2087 1 2087 2086 1 2037 2088 1 2088 2087 1 2038 2089 1
		 2089 2088 1 2039 2090 0 2090 2089 1 2041 2092 1 2092 2091 1 2091 2040 0 2042 2093 1
		 2093 2092 1 2043 2094 1 2094 2093 1 2044 2095 1 2095 2094 1 2045 2096 1 2096 2095 1
		 2046 2097 1 2097 2096 1 2047 2098 1 2098 2097 1 2048 2099 1 2099 2098 1 2049 2100 1
		 2100 2099 1 2050 2101 1 2101 2100 1 2051 2102 1 2102 2101 1 2052 2103 1 2103 2102 1
		 2053 2104 1 2104 2103 1 2054 2105 1 2105 2104 1 2055 2106 1 2106 2105 1 2056 2107 1
		 2107 2106 1 2057 2108 1 2108 2107 1 2058 2109 1 2109 2108 1 2059 2110 1 2110 2109 1
		 2060 2111 1 2111 2110 1 2061 2112 1 2112 2111 1 2062 2113 1 2113 2112 1 2063 2114 1
		 2114 2113 1 2064 2115 1 2115 2114 1 2065 2116 1 2116 2115 1 2066 2117 1 2117 2116 1
		 2067 2118 1 2118 2117 1 2068 2119 1 2119 2118 1 2069 2120 1 2120 2119 1 2070 2121 1;
	setAttr ".ed[4150:4315]" 2121 2120 1 2071 2122 1 2122 2121 1 2072 2123 1 2123 2122 1
		 2073 2124 1 2124 2123 1 2074 2125 1 2125 2124 1 2075 2126 1 2126 2125 1 2076 2127 1
		 2127 2126 1 2077 2128 1 2128 2127 1 2078 2129 1 2129 2128 1 2079 2130 1 2130 2129 1
		 2080 2131 1 2131 2130 1 2081 2132 1 2132 2131 1 2082 2133 1 2133 2132 1 2083 2134 1
		 2134 2133 1 2084 2135 1 2135 2134 1 2085 2136 1 2136 2135 1 2086 2137 1 2137 2136 1
		 2087 2138 1 2138 2137 1 2088 2139 1 2139 2138 1 2089 2140 1 2140 2139 1 2090 2141 0
		 2141 2140 1 2092 2143 1 2143 2142 1 2142 2091 0 2093 2144 1 2144 2143 1 2094 2145 1
		 2145 2144 1 2095 2146 1 2146 2145 1 2096 2147 1 2147 2146 1 2097 2148 1 2148 2147 1
		 2098 2149 1 2149 2148 1 2099 2150 1 2150 2149 1 2100 2151 1 2151 2150 1 2101 2152 1
		 2152 2151 1 2102 2153 1 2153 2152 1 2103 2154 1 2154 2153 1 2104 2155 1 2155 2154 1
		 2105 2156 1 2156 2155 1 2106 2157 1 2157 2156 1 2107 2158 1 2158 2157 1 2108 2159 1
		 2159 2158 1 2109 2160 1 2160 2159 1 2110 2161 1 2161 2160 1 2111 2162 1 2162 2161 1
		 2112 2163 1 2163 2162 1 2113 2164 1 2164 2163 1 2114 2165 1 2165 2164 1 2115 2166 1
		 2166 2165 1 2116 2167 1 2167 2166 1 2117 2168 1 2168 2167 1 2118 2169 1 2169 2168 1
		 2119 2170 1 2170 2169 1 2120 2171 1 2171 2170 1 2121 2172 1 2172 2171 1 2122 2173 1
		 2173 2172 1 2123 2174 1 2174 2173 1 2124 2175 1 2175 2174 1 2125 2176 1 2176 2175 1
		 2126 2177 1 2177 2176 1 2127 2178 1 2178 2177 1 2128 2179 1 2179 2178 1 2129 2180 1
		 2180 2179 1 2130 2181 1 2181 2180 1 2131 2182 1 2182 2181 1 2132 2183 1 2183 2182 1
		 2133 2184 1 2184 2183 1 2134 2185 1 2185 2184 1 2135 2186 1 2186 2185 1 2136 2187 1
		 2187 2186 1 2137 2188 1 2188 2187 1 2138 2189 1 2189 2188 1 2139 2190 1 2190 2189 1
		 2140 2191 1 2191 2190 1 2141 2192 0 2192 2191 1 2143 2194 1 2194 2193 1 2193 2142 0
		 2144 2195 1 2195 2194 1 2145 2196 1 2196 2195 1 2146 2197 1 2197 2196 1 2147 2198 1
		 2198 2197 1 2148 2199 1 2199 2198 1 2149 2200 1 2200 2199 1 2150 2201 1 2201 2200 1
		 2151 2202 1 2202 2201 1 2152 2203 1 2203 2202 1 2153 2204 1 2204 2203 1 2154 2205 1;
	setAttr ".ed[4316:4481]" 2205 2204 1 2155 2206 1 2206 2205 1 2156 2207 1 2207 2206 1
		 2157 2208 1 2208 2207 1 2158 2209 1 2209 2208 1 2159 2210 1 2210 2209 1 2160 2211 1
		 2211 2210 1 2161 2212 1 2212 2211 1 2162 2213 1 2213 2212 1 2163 2214 1 2214 2213 1
		 2164 2215 1 2215 2214 1 2165 2216 1 2216 2215 1 2166 2217 1 2217 2216 1 2167 2218 1
		 2218 2217 1 2168 2219 1 2219 2218 1 2169 2220 1 2220 2219 1 2170 2221 1 2221 2220 1
		 2171 2222 1 2222 2221 1 2172 2223 1 2223 2222 1 2173 2224 1 2224 2223 1 2174 2225 1
		 2225 2224 1 2175 2226 1 2226 2225 1 2176 2227 1 2227 2226 1 2177 2228 1 2228 2227 1
		 2178 2229 1 2229 2228 1 2179 2230 1 2230 2229 1 2180 2231 1 2231 2230 1 2181 2232 1
		 2232 2231 1 2182 2233 1 2233 2232 1 2183 2234 1 2234 2233 1 2184 2235 1 2235 2234 1
		 2185 2236 1 2236 2235 1 2186 2237 1 2237 2236 1 2187 2238 1 2238 2237 1 2188 2239 1
		 2239 2238 1 2189 2240 1 2240 2239 1 2190 2241 1 2241 2240 1 2191 2242 1 2242 2241 1
		 2192 2243 0 2243 2242 1 2194 2245 1 2245 2244 1 2244 2193 0 2195 2246 1 2246 2245 1
		 2196 2247 1 2247 2246 1 2197 2248 1 2248 2247 1 2198 2249 1 2249 2248 1 2199 2250 1
		 2250 2249 1 2200 2251 1 2251 2250 1 2201 2252 1 2252 2251 1 2202 2253 1 2253 2252 1
		 2203 2254 1 2254 2253 1 2204 2255 1 2255 2254 1 2205 2256 1 2256 2255 1 2206 2257 1
		 2257 2256 1 2207 2258 1 2258 2257 1 2208 2259 1 2259 2258 1 2209 2260 1 2260 2259 1
		 2210 2261 1 2261 2260 1 2211 2262 1 2262 2261 1 2212 2263 1 2263 2262 1 2213 2264 1
		 2264 2263 1 2214 2265 1 2265 2264 1 2215 2266 1 2266 2265 1 2216 2267 1 2267 2266 1
		 2217 2268 1 2268 2267 1 2218 2269 1 2269 2268 1 2219 2270 1 2270 2269 1 2220 2271 1
		 2271 2270 1 2221 2272 1 2272 2271 1 2222 2273 1 2273 2272 1 2223 2274 1 2274 2273 1
		 2224 2275 1 2275 2274 1 2225 2276 1 2276 2275 1 2226 2277 1 2277 2276 1 2227 2278 1
		 2278 2277 1 2228 2279 1 2279 2278 1 2229 2280 1 2280 2279 1 2230 2281 1 2281 2280 1
		 2231 2282 1 2282 2281 1 2232 2283 1 2283 2282 1 2233 2284 1 2284 2283 1 2234 2285 1
		 2285 2284 1 2235 2286 1 2286 2285 1 2236 2287 1 2287 2286 1 2237 2288 1 2288 2287 1;
	setAttr ".ed[4482:4647]" 2238 2289 1 2289 2288 1 2239 2290 1 2290 2289 1 2240 2291 1
		 2291 2290 1 2241 2292 1 2292 2291 1 2242 2293 1 2293 2292 1 2243 2294 0 2294 2293 1
		 2245 2296 1 2296 2295 1 2295 2244 0 2246 2297 1 2297 2296 1 2247 2298 1 2298 2297 1
		 2248 2299 1 2299 2298 1 2249 2300 1 2300 2299 1 2250 2301 1 2301 2300 1 2251 2302 1
		 2302 2301 1 2252 2303 1 2303 2302 1 2253 2304 1 2304 2303 1 2254 2305 1 2305 2304 1
		 2255 2306 1 2306 2305 1 2256 2307 1 2307 2306 1 2257 2308 1 2308 2307 1 2258 2309 1
		 2309 2308 1 2259 2310 1 2310 2309 1 2260 2311 1 2311 2310 1 2261 2312 1 2312 2311 1
		 2262 2313 1 2313 2312 1 2263 2314 1 2314 2313 1 2264 2315 1 2315 2314 1 2265 2316 1
		 2316 2315 1 2266 2317 1 2317 2316 1 2267 2318 1 2318 2317 1 2268 2319 1 2319 2318 1
		 2269 2320 1 2320 2319 1 2270 2321 1 2321 2320 1 2271 2322 1 2322 2321 1 2272 2323 1
		 2323 2322 1 2273 2324 1 2324 2323 1 2274 2325 1 2325 2324 1 2275 2326 1 2326 2325 1
		 2276 2327 1 2327 2326 1 2277 2328 1 2328 2327 1 2278 2329 1 2329 2328 1 2279 2330 1
		 2330 2329 1 2280 2331 1 2331 2330 1 2281 2332 1 2332 2331 1 2282 2333 1 2333 2332 1
		 2283 2334 1 2334 2333 1 2284 2335 1 2335 2334 1 2285 2336 1 2336 2335 1 2286 2337 1
		 2337 2336 1 2287 2338 1 2338 2337 1 2288 2339 1 2339 2338 1 2289 2340 1 2340 2339 1
		 2290 2341 1 2341 2340 1 2291 2342 1 2342 2341 1 2292 2343 1 2343 2342 1 2293 2344 1
		 2344 2343 1 2294 2345 0 2345 2344 1 2296 2347 1 2347 2346 1 2346 2295 0 2297 2348 1
		 2348 2347 1 2298 2349 1 2349 2348 1 2299 2350 1 2350 2349 1 2300 2351 1 2351 2350 1
		 2301 2352 1 2352 2351 1 2302 2353 1 2353 2352 1 2303 2354 1 2354 2353 1 2304 2355 1
		 2355 2354 1 2305 2356 1 2356 2355 1 2306 2357 1 2357 2356 1 2307 2358 1 2358 2357 1
		 2308 2359 1 2359 2358 1 2309 2360 1 2360 2359 1 2310 2361 1 2361 2360 1 2311 2362 1
		 2362 2361 1 2312 2363 1 2363 2362 1 2313 2364 1 2364 2363 1 2314 2365 1 2365 2364 1
		 2315 2366 1 2366 2365 1 2316 2367 1 2367 2366 1 2317 2368 1 2368 2367 1 2318 2369 1
		 2369 2368 1 2319 2370 1 2370 2369 1 2320 2371 1 2371 2370 1 2321 2372 1 2372 2371 1;
	setAttr ".ed[4648:4813]" 2322 2373 1 2373 2372 1 2323 2374 1 2374 2373 1 2324 2375 1
		 2375 2374 1 2325 2376 1 2376 2375 1 2326 2377 1 2377 2376 1 2327 2378 1 2378 2377 1
		 2328 2379 1 2379 2378 1 2329 2380 1 2380 2379 1 2330 2381 1 2381 2380 1 2331 2382 1
		 2382 2381 1 2332 2383 1 2383 2382 1 2333 2384 1 2384 2383 1 2334 2385 1 2385 2384 1
		 2335 2386 1 2386 2385 1 2336 2387 1 2387 2386 1 2337 2388 1 2388 2387 1 2338 2389 1
		 2389 2388 1 2339 2390 1 2390 2389 1 2340 2391 1 2391 2390 1 2341 2392 1 2392 2391 1
		 2342 2393 1 2393 2392 1 2343 2394 1 2394 2393 1 2344 2395 1 2395 2394 1 2345 2396 0
		 2396 2395 1 2347 2398 1 2398 2397 1 2397 2346 0 2348 2399 1 2399 2398 1 2349 2400 1
		 2400 2399 1 2350 2401 1 2401 2400 1 2351 2402 1 2402 2401 1 2352 2403 1 2403 2402 1
		 2353 2404 1 2404 2403 1 2354 2405 1 2405 2404 1 2355 2406 1 2406 2405 1 2356 2407 1
		 2407 2406 1 2357 2408 1 2408 2407 1 2358 2409 1 2409 2408 1 2359 2410 1 2410 2409 1
		 2360 2411 1 2411 2410 1 2361 2412 1 2412 2411 1 2362 2413 1 2413 2412 1 2363 2414 1
		 2414 2413 1 2364 2415 1 2415 2414 1 2365 2416 1 2416 2415 1 2366 2417 1 2417 2416 1
		 2367 2418 1 2418 2417 1 2368 2419 1 2419 2418 1 2369 2420 1 2420 2419 1 2370 2421 1
		 2421 2420 1 2371 2422 1 2422 2421 1 2372 2423 1 2423 2422 1 2373 2424 1 2424 2423 1
		 2374 2425 1 2425 2424 1 2375 2426 1 2426 2425 1 2376 2427 1 2427 2426 1 2377 2428 1
		 2428 2427 1 2378 2429 1 2429 2428 1 2379 2430 1 2430 2429 1 2380 2431 1 2431 2430 1
		 2381 2432 1 2432 2431 1 2382 2433 1 2433 2432 1 2383 2434 1 2434 2433 1 2384 2435 1
		 2435 2434 1 2385 2436 1 2436 2435 1 2386 2437 1 2437 2436 1 2387 2438 1 2438 2437 1
		 2388 2439 1 2439 2438 1 2389 2440 1 2440 2439 1 2390 2441 1 2441 2440 1 2391 2442 1
		 2442 2441 1 2392 2443 1 2443 2442 1 2393 2444 1 2444 2443 1 2394 2445 1 2445 2444 1
		 2395 2446 1 2446 2445 1 2396 2447 0 2447 2446 1 2398 2449 1 2449 2448 1 2448 2397 0
		 2399 2450 1 2450 2449 1 2400 2451 1 2451 2450 1 2401 2452 1 2452 2451 1 2402 2453 1
		 2453 2452 1 2403 2454 1 2454 2453 1 2404 2455 1 2455 2454 1 2405 2456 1 2456 2455 1;
	setAttr ".ed[4814:4979]" 2406 2457 1 2457 2456 1 2407 2458 1 2458 2457 1 2408 2459 1
		 2459 2458 1 2409 2460 1 2460 2459 1 2410 2461 1 2461 2460 1 2411 2462 1 2462 2461 1
		 2412 2463 1 2463 2462 1 2413 2464 1 2464 2463 1 2414 2465 1 2465 2464 1 2415 2466 1
		 2466 2465 1 2416 2467 1 2467 2466 1 2417 2468 1 2468 2467 1 2418 2469 1 2469 2468 1
		 2419 2470 1 2470 2469 1 2420 2471 1 2471 2470 1 2421 2472 1 2472 2471 1 2422 2473 1
		 2473 2472 1 2423 2474 1 2474 2473 1 2424 2475 1 2475 2474 1 2425 2476 1 2476 2475 1
		 2426 2477 1 2477 2476 1 2427 2478 1 2478 2477 1 2428 2479 1 2479 2478 1 2429 2480 1
		 2480 2479 1 2430 2481 1 2481 2480 1 2431 2482 1 2482 2481 1 2432 2483 1 2483 2482 1
		 2433 2484 1 2484 2483 1 2434 2485 1 2485 2484 1 2435 2486 1 2486 2485 1 2436 2487 1
		 2487 2486 1 2437 2488 1 2488 2487 1 2438 2489 1 2489 2488 1 2439 2490 1 2490 2489 1
		 2440 2491 1 2491 2490 1 2441 2492 1 2492 2491 1 2442 2493 1 2493 2492 1 2443 2494 1
		 2494 2493 1 2444 2495 1 2495 2494 1 2445 2496 1 2496 2495 1 2446 2497 1 2497 2496 1
		 2447 2498 0 2498 2497 1 2449 2500 1 2500 2499 1 2499 2448 0 2450 2501 1 2501 2500 1
		 2451 2502 1 2502 2501 1 2452 2503 1 2503 2502 1 2453 2504 1 2504 2503 1 2454 2505 1
		 2505 2504 1 2455 2506 1 2506 2505 1 2456 2507 1 2507 2506 1 2457 2508 1 2508 2507 1
		 2458 2509 1 2509 2508 1 2459 2510 1 2510 2509 1 2460 2511 1 2511 2510 1 2461 2512 1
		 2512 2511 1 2462 2513 1 2513 2512 1 2463 2514 1 2514 2513 1 2464 2515 1 2515 2514 1
		 2465 2516 1 2516 2515 1 2466 2517 1 2517 2516 1 2467 2518 1 2518 2517 1 2468 2519 1
		 2519 2518 1 2469 2520 1 2520 2519 1 2470 2521 1 2521 2520 1 2471 2522 1 2522 2521 1
		 2472 2523 1 2523 2522 1 2473 2524 1 2524 2523 1 2474 2525 1 2525 2524 1 2475 2526 1
		 2526 2525 1 2476 2527 1 2527 2526 1 2477 2528 1 2528 2527 1 2478 2529 1 2529 2528 1
		 2479 2530 1 2530 2529 1 2480 2531 1 2531 2530 1 2481 2532 1 2532 2531 1 2482 2533 1
		 2533 2532 1 2483 2534 1 2534 2533 1 2484 2535 1 2535 2534 1 2485 2536 1 2536 2535 1
		 2486 2537 1 2537 2536 1 2487 2538 1 2538 2537 1 2488 2539 1 2539 2538 1 2489 2540 1;
	setAttr ".ed[4980:5099]" 2540 2539 1 2490 2541 1 2541 2540 1 2491 2542 1 2542 2541 1
		 2492 2543 1 2543 2542 1 2493 2544 1 2544 2543 1 2494 2545 1 2545 2544 1 2495 2546 1
		 2546 2545 1 2496 2547 1 2547 2546 1 2497 2548 1 2548 2547 1 2498 2549 0 2549 2548 1
		 2500 2551 1 2551 2550 0 2550 2499 0 2501 2552 1 2552 2551 0 2502 2553 1 2553 2552 0
		 2503 2554 1 2554 2553 0 2504 2555 1 2555 2554 0 2505 2556 1 2556 2555 0 2506 2557 1
		 2557 2556 0 2507 2558 1 2558 2557 0 2508 2559 1 2559 2558 0 2509 2560 1 2560 2559 0
		 2510 2561 1 2561 2560 0 2511 2562 1 2562 2561 0 2512 2563 1 2563 2562 0 2513 2564 1
		 2564 2563 0 2514 2565 1 2565 2564 0 2515 2566 1 2566 2565 0 2516 2567 1 2567 2566 0
		 2517 2568 1 2568 2567 0 2518 2569 1 2569 2568 0 2519 2570 1 2570 2569 0 2520 2571 1
		 2571 2570 0 2521 2572 1 2572 2571 0 2522 2573 1 2573 2572 0 2523 2574 1 2574 2573 0
		 2524 2575 1 2575 2574 0 2525 2576 1 2576 2575 0 2526 2577 1 2577 2576 0 2527 2578 1
		 2578 2577 0 2528 2579 1 2579 2578 0 2529 2580 1 2580 2579 0 2530 2581 1 2581 2580 0
		 2531 2582 1 2582 2581 0 2532 2583 1 2583 2582 0 2533 2584 1 2584 2583 0 2534 2585 1
		 2585 2584 0 2535 2586 1 2586 2585 0 2536 2587 1 2587 2586 0 2537 2588 1 2588 2587 0
		 2538 2589 1 2589 2588 0 2539 2590 1 2590 2589 0 2540 2591 1 2591 2590 0 2541 2592 1
		 2592 2591 0 2542 2593 1 2593 2592 0 2543 2594 1 2594 2593 0 2544 2595 1 2595 2594 0
		 2545 2596 1 2596 2595 0 2546 2597 1 2597 2596 0 2547 2598 1 2598 2597 0 2548 2599 1
		 2599 2598 0 2549 2600 0 2600 2599 0;
	setAttr -s 2601 ".n";
	setAttr ".n[0:165]" -type "float3"  0 1 2.220446e-016 0 1 2.220446e-016 0
		 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016
		 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016
		 0 1 2.220446e-016 -0.0087615447 0.99987525 0.013142277 -0.037102867 0.99776047 0.055654339
		 -0.072995014 0.9940871 0.080391459 -0.1930833 0.96742362 0.16373876 -0.2177113 0.96285748
		 0.1597102 -0.25630412 0.9458679 0.1991038 -0.2275182 0.961887 0.15168647 -0.12359402
		 0.98347116 0.1323213 -0.09195894 0.99247527 0.080847591 -0.030284321 0.99835449 0.048694853
		 -0.01919464 0.99949348 0.0253831 -0.0030222558 0.99988949 0.014558357 -0.001874114
		 0.99997061 0.0074290526 0.020316314 0.99960107 0.019616337 0.01777458 0.99976075
		 0.012744431 0.095757455 0.99467206 0.038184125 0.094813392 0.99516153 0.025768248
		 0.10301387 0.99403089 0.035927571 0.10192313 0.99437243 0.028900182 -0.0088579478
		 0.99959648 0.026993386 -0.011048846 0.99950773 0.029361641 -0.063649423 0.99715161
		 0.040462803 -0.068369605 0.99670017 0.043752626 -0.063910432 0.99605769 0.061518893
		 -0.067364775 0.99574733 0.062843189 -0.048998125 0.99659812 0.066266954 -0.049705882
		 0.99627888 0.070410356 -0.024138631 0.99819374 0.055014044 -0.022246597 0.99773395
		 0.063497715 0.0012066981 0.99934477 0.036175113 0.0037914021 0.99886531 0.047471758
		 -0.055222441 0.99648261 0.063031428 -0.058918137 0.99650294 0.059250232 -0.066013314
		 0.98995 0.12506479 -0.080221854 0.99170524 0.10042558 0.0097539853 0.98777348 0.15559044
		 0.0094088893 0.99251175 0.12178591 0.055452637 0.98962498 0.13254209 0.067402691
		 0.99235439 0.10339054 0.040025227 0.9954868 0.086046256 0.051442996 0.9963522 0.068088122
		 0.060979471 0.99520969 0.076416396 0.055797871 0.99674255 0.058230579 0.1346695 0.98741281
		 0.082945503 0.12966131 0.98914433 0.069148161 0.096227996 0.99385297 0.054740258
		 0.11059187 0.99230474 0.055685282 -0.029994685 0.99915808 0.027990619 -0.055082891
		 0.99566108 0.074998759 -0.16463132 0.97973412 0.11409453 -0.20964397 0.96082747 0.18127331
		 -0.2089065 0.93889546 0.27355704 -0.22706079 0.93350923 0.2774958 -0.17617045 0.92106164
		 0.34728882 -0.17197241 0.94130617 0.29046184 -0.12690495 0.93610173 0.32803747 -0.11377335
		 0.95896786 0.25968492 -0.0045794933 0.95135999 0.30804741 -0.010253986 0.96807986
		 0.2504324 0.1611663 0.93483871 0.31638891 0.12729393 0.94552809 0.29962111 0.14994037
		 0.94637311 0.2861748 0.15895991 0.9287104 0.33500558 -0.0038622115 0.96857876 0.24867734
		 0.031737052 0.95724458 0.28753373 0.0015115733 0.96263218 0.27080798 0.013795359
		 0.97420388 0.22524768 0.11869363 0.94757766 0.29666203 0.11500704 0.97058958 0.21149313
		 0.15266943 0.9445737 0.29064158 0.14243157 0.96489102 0.22067779 0.096218422 0.96232194
		 0.25431967 0.10621635 0.97390544 0.20056486 0.080766328 0.98068672 0.17812993 0.095009699
		 0.98427665 0.14890526 0.066084974 0.99072307 0.11874622 0.076974258 0.99168468 0.10313337
		 0.066220269 0.99360943 0.091406688 0.070051439 0.99446803 0.078269638 0.085345231
		 0.99334884 0.077293873 0.087575778 0.99385238 0.067733943 0.0905568 0.99470687 0.048554491
		 0.10128213 0.99374229 0.047098957 0.047180004 0.99877012 0.015239474 0.059634607
		 0.99806887 0.017381946 0.0086107682 0.99996167 0.0015847376 0.010819411 0.99993938
		 0.0020587889 0.00037637309 1 2.2781345e-005 0.00037294326 0.99999988 -5.4825232e-006
		 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016
		 -0.003681201 0.99997795 0.0055217934 -0.052883629 0.99653763 0.064156465 -0.12719207
		 0.98145169 0.14343892 -0.21524461 0.96727687 0.13433307 -0.18757106 0.97959691 0.072159663
		 -0.059030257 0.99784017 0.028818132 -0.0094753653 0.99993134 0.0068867714 -0.0014853696
		 0.99999732 0.0017668937 0.013645686 0.99989372 0.0051280502 0.091553599 0.99571526
		 0.013000757 0.10028891 0.99476707 0.019509297 -0.015655261 0.99948847 0.027887071
		 -0.076888338 0.99601257 0.045244638 -0.073367149 0.99524939 0.06399975 -0.051957835
		 0.99584293 0.074813835 -0.019884771 0.99695158 0.075445861 0.0095104212 0.99779522
		 0.06568291 -0.068026431 0.99551755 0.06570638 -0.095730364 0.99227476 0.078908026
		 0.012730746 0.9965741 0.081719145 0.080658562 0.9940142 0.07368774 0.067629978 0.99594891
		 0.059262365 0.04677549 0.99731684 0.056313012 0.10428992 0.98966593 0.098412514 0.10217834
		 0.98124802 0.16343777 -0.093993425 0.97187674 0.21591863 -0.25622416 0.93715495 0.23683272
		 -0.23028812 0.9501394 0.21024394 -0.16089731 0.97089016 0.17743857 -0.097564027 0.98306268
		 0.15514232 -0.026692878 0.9868769 0.15925264 0.052152712 0.96886194 0.2420468 0.14305979
		 0.93182558 0.33351913 0.11999156 0.9512769 0.28403211 0.072180569 0.98779678 0.13801233
		 0.10200718 0.99110162 0.085510992 0.12246728 0.98556507 0.1168906 0.11262263 0.9839766
		 0.13822472 0.10417946 0.98478246 0.13910404 0.08807186 0.98742521 0.13128111 0.084767669
		 0.99084342 0.10508993 0.098886296 0.99257183 0.07087075 0.11809679 0.99215215 0.041075829
		 0.076477177 0.99697042 0.014187604 0.013102334 0.99991387 0.00086250552 0.00027525146
		 1 -0.00014154197 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016 0 1 2.220446e-016
		 -0.013242166 0.99971503 0.019863248 -0.04400076 0.99455428 0.094475657 -0.10546338
		 0.9788453 0.17532621 -0.11380621 0.98082519 0.15820929 -0.16627832 0.98364437 0.069247365
		 -0.16532244 0.9860099 0.021282248 -0.043322969 0.99901414 0.009689427 -0.0050337212
		 0.99998593 0.0016786659 -0.00085022784 0.99999899 -0.0011758711;
	setAttr ".n[166:331]" -type "float3"  0.012479405 0.99991757 -0.003012229 0.091686644
		 0.99576503 -0.0067583751 0.096071705 0.99536127 -0.0051136692 -0.027396046 0.99953347
		 0.013501117 -0.089415304 0.99518633 0.040112648 -0.083162867 0.9945398 0.063042946
		 -0.057156991 0.99522591 0.079110518 -0.019064758 0.99621129 0.084850132 0.015101066
		 0.99660391 0.080948904 -0.071678333 0.99442959 0.077279545 -0.10000298 0.99196064
		 0.077546835 0.016555946 0.99701673 0.075388752 0.077815048 0.99369395 0.080729492
		 0.068006665 0.99280304 0.098575957 0.026216162 0.99113131 0.13027501 0.052132502
		 0.97991908 0.19246015 0.06309925 0.96450305 0.25642201 -0.094520323 0.96298474 0.25244072
		 -0.22299947 0.96027237 0.16777459 -0.20947318 0.9720518 0.10600089 -0.15392198 0.98378873
		 0.092020787 -0.08701995 0.99239916 0.087014414 -0.05024844 0.99349183 0.10222072
		 -0.025109245 0.98481828 0.17176318 0.09908776 0.96259433 0.25217804 0.21207915 0.95049912
		 0.22709866 0.1660744 0.98089933 0.10127081 0.091818839 0.99530047 0.030763224 0.094597116
		 0.99401712 0.054602195 0.093324587 0.99042827 0.10169746 0.095361881 0.98531991 0.14160061
		 0.099272691 0.98445344 0.14490081 0.10949437 0.98735857 0.11460418 0.12212276 0.98981941
		 0.073100045 0.14085042 0.98954856 0.030900905 0.090248942 0.99591708 0.0020448235
		 0.011796276 0.99992555 -0.0031321472 9.3976916e-005 1 -0.00013037352 0 1 2.220446e-016
		 0 1 2.220446e-016 0 1 2.220446e-016 -0.012436481 0.99974859 0.018654687 -0.062281184
		 0.99389827 0.091035537 -0.10454306 0.97782153 0.18148205 -0.095439866 0.98031712
		 0.17282876 -0.04695135 0.99605978 0.075235888 -0.13451241 0.99083042 0.012710884
		 -0.16120458 0.98690528 0.0055712149 -0.037379604 0.99929821 0.0023994665 -0.0032958663
		 0.99999416 -0.00092963572 0.0023540836 0.99998206 -0.0055114408 0.018528942 0.99967605
		 -0.017451385 0.10056757 0.99428499 -0.035826322 0.08822944 0.9953444 -0.038796686
		 -0.049052421 0.9987421 -0.010397561 -0.10687124 0.99391496 0.026677951 -0.098086588
		 0.99357355 0.056485411 -0.063381255 0.99518639 0.074746668 -0.019882122 0.99656343
		 0.080410972 0.017252957 0.99650186 0.081770286 -0.070166767 0.99447328 0.078099601
		 -0.09825623 0.99251753 0.072489731 0.017625026 0.99723971 0.072127149 0.064518146
		 0.99434739 0.084325343 0.046022531 0.9920128 0.11744211 -0.0024573221 0.98720974
		 0.1594079 0.01927942 0.98211765 0.18727861 0.056365531 0.98198748 0.1803429 -0.053364877
		 0.98957765 0.13374721 -0.17591882 0.98142821 0.076493464 -0.19683416 0.97932172 0.046744943
		 -0.15249385 0.98758072 0.037815768 -0.082135715 0.99603188 0.034264512 -0.071440741
		 0.99637711 0.046140138 -0.067463681 0.99470538 0.077523746 0.054707538 0.99041736
		 0.12680896 0.25376266 0.9565472 0.14360377 0.25657204 0.96431339 0.06534972 0.11817046
		 0.99182761 -0.048102092 0.080828421 0.99258363 -0.090798825 0.058613561 0.99607205
		 -0.066368997 0.077248357 0.9966715 -0.02604969 0.10299504 0.99465752 -0.006957259
		 0.11789414 0.99301088 0.0055093691 0.14222404 0.98982775 0.0036473661 0.16880465
		 0.98525089 -0.028028507 0.090674102 0.99497384 -0.042487938 -0.0015255364 0.99985456
		 -0.016987044 3.7355776e-006 1 -5.0091326e-006 0 1 2.220446e-016 0 1 2.220446e-016
		 -0.0039887498 0.99997419 0.0059831212 -0.058141984 0.99638063 0.062009718 -0.121659
		 0.98167628 0.14666472 -0.10143315 0.98500621 0.13954943 -0.038858648 0.99763602 0.056677606
		 -0.0049796118 0.99995792 0.0076980456 -0.13100442 0.99138016 0.0017946695 -0.1603418
		 0.98705882 0.0023191653 -0.034504764 0.99940449 3.7285015e-005 -0.0017894199 0.9999935
		 -0.0031497697 0.012118011 0.99980766 -0.015421922 0.035495147 0.99843967 -0.043107226
		 0.11480414 0.9908855 -0.070469782 0.075739697 0.99468905 -0.069694482 -0.086843736
		 0.99600649 -0.020718217 -0.14091137 0.98861831 0.052705221 -0.11662696 0.9878059
		 0.10313836 -0.064013802 0.99139297 0.11420233 -0.010442293 0.99537677 0.095478326
		 0.024201514 0.99724889 0.070064306 -0.065446839 0.99636167 0.054591294 -0.094068415
		 0.99449217 0.046223562 0.015581804 0.99884123 0.045532528 0.053173728 0.99714243
		 0.053661551 0.022021564 0.99708432 0.073059507 -0.018043021 0.99580002 0.089759417
		 0.021267973 0.99641532 0.08187937 0.075940847 0.99555349 0.055734552 -0.018323779
		 0.99969888 0.016323747 -0.15033369 0.98829746 -0.025844438 -0.18574528 0.98111111
		 -0.054034326 -0.14468099 0.98664492 -0.074828163 -0.073076688 0.99308985 -0.091828272
		 -0.065431908 0.99156231 -0.11190581 -0.064666398 0.9883092 -0.13806963 0.030274587
		 0.9884131 -0.14873829 0.25249103 0.95677519 -0.14432397 0.30984586 0.9354161 -0.17027099
		 0.1568301 0.96349406 -0.21698716 0.065493859 0.97435629 -0.21526812 0.018612344 0.98685855
		 -0.16051143 0.049538031 0.99367934 -0.10073402 0.079021364 0.99587297 -0.044639457
		 0.096703611 0.99526471 0.0098254345 0.14624225 0.98858082 0.036349423 0.20728645
		 0.97828013 -0.00063930411 0.093747236 0.99441773 -0.04842262 -0.027580298 0.9989419
		 -0.036801998 -0.0098921852 0.99985474 -0.013883135 0 1 2.220446e-016 0 1 2.220446e-016
		 -0.034486037 0.99861324 0.039778933 -0.11829972 0.9856841 0.12013321 -0.12425609
		 0.9835608 0.13102862 -0.045926455 0.99723244 0.058466963 -0.0056644306 0.99994957
		 0.0082882149 -0.00012403727 1 0.00018761554 -0.13248917 0.99118394 0.0010755925 -0.15997186
		 0.98711938 0.0021254029 -0.032580197 0.99946874 0.00091746042 0.0019804756 0.99998832
		 -0.0043970682 0.032873783 0.99904639 -0.028734699 0.066102907 0.99483788 -0.076994464
		 0.12913708 0.98491836 -0.11514891 0.047608022 0.99434149 -0.094965875 -0.15394941
		 0.9880752 0.0026624838 -0.19175555 0.97529292 0.10969788 -0.12901607 0.97933942 0.15572114
		 -0.055942196 0.98688525 0.15141997 0.015461053 0.99273819 0.11929757 0.047921058
		 0.99634212 0.070752308 -0.051933471 0.99820125 0.029954214 -0.087014534 0.99617589
		 0.0078748828 0.012590853 0.99991465 0.0034993724 0.049151935 0.99877423 0.0058330852;
	setAttr ".n[332:497]" -type "float3"  0.015542033 0.99987781 0.0016481509 -0.0087471046
		 0.99978209 -0.018955955 0.041345529 0.99772835 -0.053184602 0.095962264 0.99151981
		 -0.087633148 0.016082065 0.9904924 -0.13662405 -0.12475476 0.97411227 -0.18852456
		 -0.17295909 0.96171522 -0.21257673 -0.13678554 0.96680725 -0.21580854 -0.070446849
		 0.97595185 -0.2062896 -0.044051457 0.97681081 -0.20952366 -0.034916192 0.96907568
		 -0.24428093 0.037919387 0.95883608 -0.2814168 0.23453194 0.93175441 -0.27717957 0.29416135
		 0.93010163 -0.21995473 0.15115984 0.97620493 -0.15548232 0.022131804 0.99652803 -0.080262877
		 -0.025686594 0.99966449 -0.0033450196 0.019624418 0.99878508 0.045202874 0.047055807
		 0.99589139 0.077369452 0.066159487 0.99143249 0.11262657 0.1384865 0.98065603 0.13833049
		 0.25400656 0.96157706 0.10416473 0.13702133 0.99030858 0.022674656 -0.042254906 0.99884444
		 -0.022896659 -0.040743209 0.99887484 -0.024265511 -0.010603358 0.99981725 0.015905013
		 0 1 2.220446e-016 -0.093957581 0.99218255 0.082132384 -0.14444357 0.98116523 0.1282611
		 -0.07071761 0.99466187 0.075144254 -0.009695665 0.99987233 0.012699815 -0.00019567212
		 1 0.00028858581 -0.0021461584 0.99999255 0.0032192527 -0.13439688 0.99089175 0.0084239561
		 -0.15793942 0.98742133 0.0073674498 -0.029098647 0.99957657 0.00030244191 0.0089160856
		 0.99990851 -0.010173626 0.062652431 0.99717587 -0.041412551 0.10671704 0.98937798
		 -0.098705202 0.14113745 0.98024201 -0.13858496 -0.018390028 0.99656188 -0.080785058
		 -0.24408647 0.96769893 0.06309326 -0.22071405 0.96506613 0.14118293 -0.11991942 0.98483539
		 0.12537386 -0.042996228 0.99458778 0.094585389 0.03429883 0.99631065 0.078668065
		 0.075433061 0.99543089 0.058541153 -0.013262206 0.99991059 0.0017349282 -0.057150662
		 0.99542534 -0.076565877 0.023491962 0.99088329 -0.13265926 0.062502816 0.98305517
		 -0.17232502 0.023409912 0.97914326 -0.20181799 0.0022096164 0.97740436 -0.21136671
		 0.057112169 0.97421288 -0.21828315 0.10320897 0.96940154 -0.22272976 0.039774079
		 0.97275972 -0.22837791 -0.10789167 0.96557873 -0.23667911 -0.17830011 0.95798969
		 -0.22464374 -0.14649792 0.9689399 -0.19923288 -0.085198753 0.98092264 -0.1747344
		 -0.038191561 0.98651052 -0.15918085 -0.010731366 0.98580378 -0.16755812 0.056751579
		 0.98120415 -0.18443905 0.20734966 0.96657526 -0.1507922 0.24693896 0.96668679 -0.067363627
		 0.11682037 0.9931531 0.0001789634 -0.021401625 0.99869126 0.046450771 -0.053876296
		 0.99532533 0.080155425 0.0029812946 0.99502063 0.099625856 0.031525671 0.99296498
		 0.11413416 0.051514082 0.99106842 0.12300339 0.13578254 0.98331201 0.12108054 0.28547117
		 0.95319706 0.099606514 0.19576415 0.97932327 0.051013995 -0.026106801 0.99965894
		 -0.00071241555 -0.075899228 0.99689025 -0.021190096 -0.050796624 0.99771929 0.044451628
		 0 1 2.220446e-016 -0.14216179 0.98377609 0.10942893 -0.11329682 0.98957825 0.088875391
		 -0.022585997 0.99944597 0.024445446 -0.00083165534 0.99999899 0.0011785118 -2.3767354e-006
		 1 3.5365422e-006 -0.011509448 0.99987501 0.010828168 -0.13409376 0.99078846 0.018895159
		 -0.14147282 0.98992532 -0.0057759993 -0.017184613 0.99896729 -0.042059444 0.016709063
		 0.99797386 -0.061392657 0.075667322 0.99527711 -0.060810167 0.13074796 0.98978829
		 -0.056779701 0.14214697 0.98857218 -0.050191976 -0.11865011 0.99230564 0.035378505
		 -0.32086128 0.93364209 0.15924978 -0.20544745 0.96089512 0.18566583 -0.088468716
		 0.986655 0.13669331 -0.011909546 0.99718463 0.074034274 0.048907917 0.99859536 0.020379312
		 0.087801874 0.99613792 0.00026242237 0.039163399 0.99848938 -0.038538355 -0.0079444945
		 0.99393028 -0.10972435 0.040904939 0.98747146 -0.15240379 0.078386903 0.98387027
		 -0.16079435 0.029303117 0.98642045 -0.16160496 0.0015881448 0.98725432 -0.15914293
		 0.061983898 0.98562199 -0.15718578 0.09027756 0.9863714 -0.13755514 0.030533371 0.99479342
		 -0.09723004 -0.10279817 0.99136311 -0.081435248 -0.18541534 0.97818393 -0.093687393
		 -0.15668625 0.98234558 -0.10220907 -0.093473874 0.98995483 -0.10607612 -0.040345807
		 0.99319267 -0.10927275 0.0015842624 0.99318218 -0.11656202 0.062465299 0.9904229
		 -0.12312795 0.16810422 0.98115849 -0.095231816 0.20285612 0.97823942 -0.043554921
		 0.094008125 0.99551904 -0.010209803 -0.043861285 0.99898762 0.0099943718 -0.066972964
		 0.99731708 0.029550603 -0.0082391798 0.99882424 0.047773369 0.021509267 0.99763596
		 0.0652669 0.050411344 0.99608266 0.07265044 0.13986427 0.98774183 0.069310747 0.29705769
		 0.95292687 0.06072114 0.23455653 0.9713425 0.038434099 0.0095968684 0.99993843 0.0055565564
		 -0.080321327 0.99663728 -0.016208874 -0.10712837 0.99191511 0.068029493 -0.017918807
		 0.9994781 0.026878225 -0.15124208 0.9833405 0.10083292 -0.05789879 0.99695092 0.052312505
		 -0.0079119019 0.99991035 0.010793402 -0.0047016647 0.99982941 0.017861106 -0.001668822
		 0.99962431 0.027356248 -0.021078363 0.99922061 0.033375058 -0.11292974 0.99357796
		 0.0070423442 -0.097754143 0.9929902 -0.0664424 0.0044904905 0.99167877 -0.12865843
		 0.024316471 0.98797333 -0.15270093 0.05313956 0.98984671 -0.13183235 0.097785659
		 0.99371523 -0.054480866 0.089428909 0.99381268 0.065870151 -0.19107899 0.96686137
		 0.16931567 -0.3413997 0.92108488 0.18721326 -0.19779179 0.96196634 0.1884124 -0.082496271
		 0.9728207 0.21636616 0.015510926 0.9731847 0.22950163 0.094074503 0.98140156 0.16733479
		 0.12220217 0.99051595 0.062807545 0.07780689 0.99691379 -0.0104392 0.019970914 0.99907279
		 -0.038137756 0.035626482 0.99895781 -0.02853187 0.065006278 0.99782652 0.010788727
		 0.025398998 0.99885476 0.040546712 0.0068020052 0.99920559 0.039266601 0.061760239
		 0.99757159 0.032196693 0.073659375 0.996553 0.038163394 0.014968997 0.99889362 0.044579089
		 -0.079973303 0.99666095 0.016469562 -0.15737817 0.98629528 -0.049535908 -0.14955929
		 0.98402494 -0.096575744 -0.092991225 0.99008137 -0.10531633 -0.044327773 0.99433678
		 -0.096588813 0.0049929959 0.99612194 -0.087841235 0.060463052 0.99480647 -0.081879489
		 0.13922086 0.98858601 -0.057578474;
	setAttr ".n[498:663]" -type "float3"  0.17600533 0.98420751 -0.018913513 0.090139069
		 0.99591035 -0.0061370255 -0.041579902 0.99874723 -0.02784333 -0.065699443 0.99639875
		 -0.053601701 -0.01003491 0.99751729 -0.069702908 0.017189289 0.9967711 -0.078433588
		 0.046048056 0.99616712 -0.074369259 0.12877779 0.9904443 -0.049358882 0.27877006
		 0.96034789 0.0043850942 0.24523681 0.96840101 0.045368426 0.048029669 0.99821347
		 0.035540439 -0.056953881 0.99831325 0.011263846 -0.14587305 0.98431057 0.099265851
		 -0.090972163 0.99238151 0.083083369 -0.11947418 0.98984128 0.077071764 -0.025364893
		 0.9992196 0.0302785 -0.0103614 0.99959153 0.026633972 0.0056350245 0.9999513 0.0081037963
		 0.014191771 0.99907768 -0.040524077 -0.01721495 0.99695402 -0.076067545 -0.077345222
		 0.99125659 -0.10690249 -0.056190681 0.98781556 -0.14513135 0.010480268 0.98815012
		 -0.15313239 0.016429227 0.99192232 -0.12577882 0.010050158 0.99757403 -0.068885319
		 0.028420771 0.99927503 0.025333839 0.0073052361 0.99034059 0.13846339 -0.20421004
		 0.9626739 0.17764385 -0.31693763 0.94137973 0.11556307 -0.22301863 0.96899188 0.10638279
		 -0.12325496 0.9769845 0.17409617 -0.0086589484 0.96758664 0.25239053 0.12532714 0.94940716
		 0.2879568 0.20024657 0.95601976 0.21430737 0.13297039 0.98796439 0.079027012 0.029621249
		 0.99954587 0.0055399649 0.021292124 0.99977142 0.0019391273 0.04214837 0.9989447
		 0.018247932 0.02004168 0.99934083 0.030269867 0.013840433 0.99948549 0.028933488
		 0.057779506 0.99781901 0.031917762 0.073010333 0.99678415 0.033029448 0.026978204
		 0.99958891 0.0096992897 -0.045663148 0.9984405 -0.032113213 -0.11883628 0.98981696
		 -0.078359343 -0.13482206 0.98435825 -0.11341061 -0.093656421 0.98763603 -0.12571262
		 -0.051353347 0.99131733 -0.1210487 0.00075968611 0.99385798 -0.11066063 0.054778095
		 0.99352121 -0.099573731 0.11426142 0.99068171 -0.074121818 0.14759135 0.98866463
		 -0.027548952 0.094677083 0.9954983 -0.0043928768 -0.012887045 0.9991914 -0.038082782
		 -0.044704229 0.9950636 -0.088599607 0.0002698102 0.99308163 -0.11742496 0.024242101
		 0.99066949 -0.13411297 0.045626536 0.98783237 -0.14867882 0.10748297 0.98377228 -0.14366485
		 0.22030953 0.97240955 -0.076702729 0.21341929 0.97669578 0.022748547 0.074125618
		 0.99516141 0.064491227 -0.021839954 0.99826241 0.054728962 -0.15698895 0.98311931
		 0.093972817 -0.19280414 0.97672659 0.09397652 -0.072969042 0.99531412 0.063444287
		 -0.023165556 0.99906242 0.036574475 0.0078862514 0.9999221 0.0096662883 0.051172558
		 0.99637783 -0.067916356 0.046715342 0.98935413 -0.13782622 -0.015018994 0.9876923
		 -0.15568705 -0.072750092 0.98803788 -0.13597256 -0.060318902 0.99339885 -0.097572468
		 -0.024913013 0.99928343 -0.028494569 -0.030300086 0.99703431 0.070742011 -0.03953585
		 0.98612779 0.16121037 -0.0093755694 0.97997344 0.19890732 -0.016033728 0.98441684
		 0.17511849 -0.16817068 0.97973877 0.10876805 -0.28143048 0.95860749 0.04322743 -0.24049661
		 0.97037357 0.023164399 -0.15570508 0.98730367 0.031423662 -0.047688339 0.99710405
		 0.059240494 0.095729671 0.98753488 0.12494323 0.23470093 0.95380872 0.18752182 0.21113685
		 0.96652436 0.14578031 0.066611297 0.9970718 0.037559617 0.017666973 0.99977553 -0.011689214
		 0.033167571 0.99940819 -0.0091327121 0.025856111 0.99952608 -0.01670168 0.024369219
		 0.99889088 -0.040288411 0.055875402 0.996867 -0.055983759 0.075901113 0.99546468
		 -0.057351243 0.042895053 0.99722552 -0.060838524 -0.02480373 0.99695665 -0.073908158
		 -0.095016733 0.99089599 -0.095378272 -0.12002491 0.98564923 -0.11870018 -0.091382049
		 0.98703468 -0.13195413 -0.054328676 0.98945147 -0.13429198 -0.005981938 0.99176222
		 -0.12795323 0.047507122 0.99216032 -0.11558934 0.090174519 0.99178988 -0.090672061
		 0.11168613 0.99285436 -0.042029038 0.09095782 0.99584997 -0.0030885809 0.020350313
		 0.99967998 -0.015027803 -0.017440513 0.9982515 -0.056478348 0.010474497 0.99648774
		 -0.083081499 0.035557218 0.99467957 -0.096686132 0.059116058 0.99135858 -0.11710436
		 0.1028378 0.98562455 -0.13404766 0.16434604 0.98018402 -0.11058804 0.15773176 0.98649615
		 -0.044115029 0.082979076 0.99654031 0.0046791211 0.02422723 0.9994061 0.02450637
		 -0.13684915 0.9875986 0.076949231 -0.22127858 0.96973389 0.1032083 -0.040661942 0.99869215
		 0.03099025 -0.0076885591 0.99987406 -0.013888775 0.057734497 0.99467146 -0.085413449
		 0.089701205 0.98578966 -0.14202942 0.049735345 0.98965263 -0.13458832 -0.035076641
		 0.99534369 -0.089781426 -0.10081627 0.9941535 -0.038665194 -0.097537622 0.99504888
		 0.019081399 -0.087723292 0.99074787 0.1035528 -0.093402393 0.97570497 0.19818115
		 -0.059927143 0.96969759 0.23684436 0.012483051 0.97915322 0.20273928 0.023295119
		 0.99014169 0.13811895 -0.11512657 0.99149251 0.060731672 -0.24880196 0.9683916 -0.017755279
		 -0.22897802 0.97091055 -0.070013508 -0.14810364 0.98305178 -0.10804892 -0.059059255
		 0.98990196 -0.12886493 0.048687506 0.99321437 -0.10561587 0.18470584 0.98272705 -0.011464184
		 0.24114209 0.96687508 0.083684638 0.13481051 0.98949057 0.052293397 0.042331867 0.99820399
		 -0.042388387 0.037314318 0.99532729 -0.089056373 0.039541166 0.99323326 -0.1091979
		 0.039546575 0.9907257 -0.12999459 0.053759422 0.98940712 -0.13484657 0.062995501
		 0.99177665 -0.11140317 0.037798971 0.9959957 -0.081017263 -0.015941413 0.99714506
		 -0.07380873 -0.077307984 0.99271107 -0.092456043 -0.10738078 0.98755103 -0.11494444
		 -0.089151107 0.98822612 -0.12434358 -0.056288153 0.99087554 -0.12246364 -0.015017176
		 0.9936136 -0.11183321 0.038676854 0.99463052 -0.095990568 0.069791451 0.99473274
		 -0.075072691 0.076901518 0.99630827 -0.038156424 0.076285422 0.99708587 -0.00060160831
		 0.043310363 0.99906158 0.00044515042 0.010513279 0.99937898 -0.033633098 0.020934882
		 0.99772847 -0.064028725 0.046104264 0.9956615 -0.080824122 0.074295864 0.99248886
		 -0.097190686 0.10852104 0.98802036 -0.10972194 0.13990173 0.98447508 -0.10600129
		 0.12650207 0.98772132 -0.091671929 0.083907641 0.99283969 -0.085022941 0.059723645
		 0.9946171 -0.084674343 -0.065967686 0.98968512 -0.12716731;
	setAttr ".n[664:829]" -type "float3"  -0.12715136 0.99129868 -0.034052879 -0.0055320999
		 0.96821767 -0.25004792 0.025073098 0.95124477 -0.30741605 0.080054171 0.94426882
		 -0.31929237 0.073084272 0.95860779 -0.27519044 0.0077132755 0.98109984 -0.19334845
		 -0.076708287 0.99119204 -0.10795399 -0.13126595 0.9902944 -0.045675259 -0.13451058
		 0.99090594 0.0034983354 -0.147339 0.98661357 0.069892921 -0.13055354 0.98408395 0.12055913
		 -0.045067381 0.99238271 0.11465441 0.04511917 0.99567854 0.081170239 0.054707702
		 0.99717176 0.051532149 -0.060846951 0.99813724 -0.004450311 -0.1993677 0.97525471
		 -0.095554441 -0.19578128 0.96540457 -0.17223111 -0.11824595 0.96677518 -0.22663526
		 -0.050010227 0.96424037 -0.26026806 0.023445986 0.96586812 -0.25797087 0.10512388
		 0.97557253 -0.19289193 0.18256366 0.98096943 -0.066101246 0.17900144 0.98384613 0.0023298934
		 0.10485048 0.99270755 -0.059482742 0.059217457 0.98830968 -0.14048913 0.046310116
		 0.98534942 -0.16414048 0.037555158 0.9877333 -0.15156662 0.033893235 0.99285549 -0.11440839
		 0.034820169 0.9972083 -0.06605503 0.026021013 0.99897623 -0.037004907 -0.004690134
		 0.99902117 -0.043983947 -0.05542383 0.99561661 -0.075337037 -0.092923507 0.98985445
		 -0.1074858 -0.088742077 0.9887262 -0.12060437 -0.06349773 0.99161059 -0.11258934
		 -0.029783484 0.99544013 -0.090619519 0.026253063 0.99752247 -0.065265849 0.056056518
		 0.99736005 -0.046157267 0.053892668 0.99817705 -0.027167015 0.062156267 0.9980334
		 -0.0081207259 0.059222624 0.99818158 -0.011237859 0.037864208 0.99839425 -0.042132903
		 0.034677438 0.99667895 -0.073679119 0.055974681 0.9941467 -0.092407659 0.083275482
		 0.99103689 -0.10445586 0.11155712 0.98758072 -0.11063192 0.13215354 0.9851709 -0.1094244
		 0.12368287 0.98662955 -0.10613456 0.094377227 0.98971152 -0.10753607 0.07454405 0.99098545
		 -0.11131513 0.037273198 0.89314783 -0.44821608 0.022714613 0.93162805 -0.36270246
		 0.033084717 0.85025054 -0.52533746 0.030244151 0.84513992 -0.53368884 0.03880145
		 0.87453806 -0.48340216 -0.0057968516 0.92847443 -0.37135106 -0.075129338 0.9728452
		 -0.21892433 -0.12650453 0.98655409 -0.1034783 -0.14705276 0.98710245 -0.063279897
		 -0.1604218 0.98602843 -0.044864304 -0.18250248 0.98307687 -0.015900698 -0.13065754
		 0.99129951 -0.015931906 -0.024657024 0.99880272 -0.042249855 0.05411838 0.99710888
		 -0.053340301 0.061379783 0.99692845 -0.048643123 -0.018022265 0.99728388 -0.071415201
		 -0.13492011 0.97941267 -0.15015754 -0.151504 0.9596976 -0.23670001 -0.091521055 0.95443934
		 -0.28402358 -0.03966625 0.95259607 -0.30164087 0.0067080315 0.95597535 -0.29337022
		 0.04402864 0.96831554 -0.24581808 0.10098171 0.98228371 -0.15786491 0.16537131 0.98324102
		 -0.07674294 0.15732381 0.9850964 -0.069529727 0.087734498 0.99009329 -0.10962562
		 0.031972315 0.99380928 -0.10640015 0.0044724648 0.99887109 -0.047291558 -0.003330294
		 0.99976522 0.021408021 0.0063645337 0.99745125 0.071067482 0.020058306 0.99553114
		 0.092279211 0.017033515 0.99709249 0.074272819 -0.015099453 0.9998135 0.012036898
		 -0.060630843 0.99600661 -0.065534726 -0.083873607 0.99050659 -0.10891249 -0.077053428
		 0.9915303 -0.10454863 -0.049557064 0.99577844 -0.077261232 0.011362964 0.99865317
		 -0.050621573 0.04948049 0.99808997 -0.036987428 0.045822416 0.99837875 -0.033766791
		 0.054142863 0.99813038 -0.028358923 0.069590762 0.9971627 -0.028698444 0.065327905
		 0.99636155 -0.054735098 0.05640804 0.99364787 -0.097375549 0.067072429 0.98941487
		 -0.128684 0.087150872 0.98615634 -0.14106958 0.10875342 0.98417556 -0.13989703 0.12389633
		 0.98388326 -0.12893179 0.12235235 0.98545593 -0.11792581 0.10409051 0.98798877 -0.11420739
		 0.085806362 0.98969507 -0.11463422 0.08329007 0.88132632 -0.46510923 0.10254701 0.87201798
		 -0.47861126 0.044593975 0.88713849 -0.45934379 0.012832227 0.89698124 -0.44188237
		 -0.031958789 0.92498952 -0.37864634 -0.12240248 0.96395403 -0.23624219 -0.16808836
		 0.98251724 -0.080038019 -0.1594685 0.98719871 -0.0029137596 -0.14831404 0.98889536
		 0.0094346516 -0.16251485 0.9866972 -0.0041879877 -0.17372555 0.98392606 -0.04133952
		 -0.1047515 0.98986548 -0.095882796 -0.012586429 0.99157989 -0.12888311 0.044211015
		 0.9914909 -0.12243897 0.05108881 0.99380195 -0.098729961 0.0060422877 0.99510336
		 -0.098654516 -0.068541959 0.98520911 -0.15705092 -0.10675861 0.96636456 -0.23397009
		 -0.077445053 0.95949543 -0.27087039 -0.03634578 0.96015114 -0.27710792 -0.010187937
		 0.96407914 -0.26541942 0.013235701 0.96963006 -0.24421772 0.050305691 0.97599983
		 -0.21188124 0.11443654 0.98388296 -0.13739932 0.1442173 0.98855454 -0.044288002 0.08702746
		 0.99611002 0.013821948 0.0062468997 0.99871784 0.050235819 -0.031033531 0.99586695
		 0.085356884 -0.031615786 0.99298149 0.11396562 -0.012235995 0.9908374 0.13450474
		 0.012131827 0.9883554 0.15167898 0.03323365 0.98727024 0.15554073 0.033350274 0.99218696
		 0.12021886 -0.0016016656 0.99938232 0.035105474 -0.054443818 0.99695891 -0.055756591
		 -0.08307834 0.9918943 -0.096144259 -0.063107125 0.99354523 -0.09426181 0.0048613227
		 0.99592555 -0.090048335 0.052842908 0.99385947 -0.097216621 0.049479589 0.99269319
		 -0.11005428 0.049097616 0.99237275 -0.11307412 0.068321101 0.99228191 -0.10348406
		 0.081312798 0.99167949 -0.099800482 0.076163828 0.99091291 -0.1108634 0.079257391
		 0.98873818 -0.12694524 0.09271618 0.98565251 -0.14104235 0.10372284 0.98402184 -0.14471583
		 0.11190666 0.98454279 -0.13473105 0.11463917 0.9860577 -0.12061542 0.10757892 0.98791236
		 -0.11160619 0.095083542 0.98940587 -0.10970445 0.072506562 0.94977552 -0.30441609
		 0.10035967 0.93735862 -0.33359644 0.035518877 0.95831496 -0.2834976 -0.0083514815
		 0.96572894 -0.25941831 -0.11370249 0.97660029 -0.18254751 -0.22385205 0.97291094
		 -0.057745259 -0.21178706 0.97722679 0.013194101 -0.16709107 0.98574471 0.019695116
		 -0.15093294 0.98826241 0.023594789 -0.14171253 0.9898504 0.010665393 -0.12809426
		 0.9904139 -0.051691886 -0.072064973 0.99051303 -0.11700718 -0.0092915948 0.99020326
		 -0.13932361 0.028271759 0.99138469 -0.12789518;
	setAttr ".n[830:995]" -type "float3"  0.037156798 0.99346256 -0.10794152 0.019770227
		 0.99390805 -0.1084247 -0.018000264 0.98896426 -0.14705686 -0.06757506 0.97662443
		 -0.20405507 -0.071638361 0.96987152 -0.2328461 -0.04215591 0.97354472 -0.22457434
		 -0.017958397 0.97626811 -0.21581945 0.010012174 0.97504437 -0.22178432 0.024775444
		 0.97703522 -0.21163258 0.047667906 0.988105 -0.14620695 0.076732419 0.99644536 -0.034768771
		 0.053007752 0.99686837 0.058681585 -0.00610147 0.99570847 0.092344269 -0.037602495
		 0.99558419 0.086012706 -0.035683345 0.99675453 0.072159454 -0.018869629 0.99764681
		 0.065915249 0.00096179976 0.99723524 0.074303091 0.025524152 0.99483275 0.098265715
		 0.051872957 0.99170756 0.11758099 0.060838167 0.99474782 0.082313627 0.011060637
		 0.99979228 -0.017116861 -0.064636841 0.99271029 -0.10172706 -0.063339122 0.98946828
		 -0.13015683 0.0094726747 0.99006492 -0.14029205 0.059188142 0.98719245 -0.14814787
		 0.058635771 0.98569202 -0.15802874 0.050550807 0.98398131 -0.17095466 0.056204911
		 0.98457062 -0.16571629 0.06412752 0.98972046 -0.12783223 0.064507775 0.99506462 -0.075399362
		 0.076039843 0.99641412 -0.037105143 0.10084555 0.99452001 -0.027570453 0.11845271
		 0.99161172 -0.051721267 0.12165231 0.98838961 -0.091031745 0.11228336 0.98725045
		 -0.11282174 0.10296696 0.9883666 -0.11193354 0.09724839 0.9896754 -0.10528761 0.048879892
		 0.98491561 -0.16598769 0.068424612 0.97938812 -0.19004489 0.0272705 0.98770571 -0.15392712
		 -0.041149568 0.99133009 -0.12478523 -0.19353762 0.97992343 -0.047887534 -0.27037847
		 0.96266681 0.012963707 -0.20527671 0.97869545 0.0040678987 -0.15914981 0.98693919
		 -0.024948958 -0.1557779 0.98722368 -0.033508051 -0.12329768 0.99161577 -0.038676705
		 -0.082923137 0.99414176 -0.069324911 -0.04737968 0.99295759 -0.10858358 -0.010708532
		 0.99248827 -0.12186952 0.016559137 0.99330443 -0.11433378 0.032058492 0.99347621
		 -0.10944054 0.036139995 0.99135357 -0.12614258 0.019571397 0.98536921 -0.16930622
		 -0.036142431 0.97553509 -0.21685256 -0.084627837 0.97278023 -0.21572386 -0.065240189
		 0.98356879 -0.16833307 -0.013301889 0.98885053 -0.14831632 0.015916541 0.98721206
		 -0.15861554 0.0066059479 0.98863047 -0.1502202 -0.0010640189 0.99351394 -0.11370577
		 0.017916085 0.99799824 -0.060651738 0.018875442 0.99973631 -0.013080047 -0.0085708471
		 0.99993247 0.0078482069 -0.030207055 0.9995271 0.0057623684 -0.029216854 0.99957079
		 -0.0021819572 -0.017314395 0.99981451 -0.0084328344 -0.0056977593 0.99993873 -0.0094886487
		 0.0078490768 0.99996722 0.001992373 0.041668124 0.99886173 0.023214549 0.094850354
		 0.99521291 0.023550179 0.077058032 0.99671692 -0.024848619 -0.030671382 0.99552345
		 -0.08939968 -0.055418175 0.99079001 -0.12354714 0.011990724 0.99139714 -0.13033752
		 0.053951003 0.99141276 -0.11912206 0.061042454 0.99254918 -0.10545161 0.051531859
		 0.99391854 -0.097315796 0.041159522 0.99585414 -0.081120469 0.036114953 0.99781525
		 -0.055320706 0.04217279 0.99853188 -0.033994287 0.057707328 0.99822605 -0.014649188
		 0.090765305 0.99578142 0.013451868 0.13707402 0.99024373 0.025062095 0.15855177 0.98734385
		 -0.0036635089 0.14088817 0.98879904 -0.049263913 0.11607622 0.98986495 -0.081816025
		 0.10530446 0.98978347 -0.096123032 0.038457099 0.99684924 -0.069373347 0.039016031
		 0.99625272 -0.077188753 0.028727531 0.99695122 -0.072546124 -0.085416913 0.99498111
		 -0.052121207 -0.25186861 0.96776134 -0.00053711736 -0.26971576 0.96276975 0.018106695
		 -0.18177162 0.98331779 -0.0067115668 -0.14838828 0.9885034 -0.029015861 -0.15062164
		 0.98758149 -0.04467573 -0.11607881 0.99153095 -0.058241777 -0.06152118 0.99557745
		 -0.070998073 -0.028711265 0.99528623 -0.092634007 -0.010185352 0.99402547 -0.10867275
		 0.012248833 0.99376601 -0.11081059 0.039894603 0.9918673 -0.12086247 0.066826612
		 0.9846074 -0.16150092 0.060397379 0.97244412 -0.22517684 -0.017334137 0.96353006
		 -0.26703787 -0.11511174 0.96164507 -0.24897408 -0.10705806 0.97682118 -0.18536189
		 -0.022387778 0.99161422 -0.12727909 0.014881097 0.99471807 -0.10156129 -0.0070234193
		 0.99617136 -0.087139226 -0.022086706 0.99734443 -0.069399372 -0.0055910558 0.99857014
		 -0.053164009 0.0035709578 0.99914777 -0.041121073 -0.0097094169 0.99925357 -0.037391998
		 -0.026168711 0.99884653 -0.040260635 -0.025015738 0.99866539 -0.045184139 -0.011975925
		 0.99848908 -0.053629626 -0.0037314359 0.99793839 -0.064070515 0.00028260087 0.99765813
		 -0.068396688 0.026191492 0.99806523 -0.05638852 0.092938565 0.99522346 -0.029878542
		 0.10795967 0.99386913 -0.023850437 0.0046387427 0.99824178 -0.059092671 -0.043200653
		 0.99439019 -0.096550405 0.0044329027 0.99511415 -0.098630928 0.036016479 0.99662024
		 -0.073829882 0.046569362 0.99807894 -0.040862702 0.03988843 0.99914211 -0.011137161
		 0.032059424 0.99948072 0.0032560397 0.034630049 0.9993782 -0.0066229608 0.048481431
		 0.99821728 -0.034813769 0.054947909 0.9966417 -0.060713727 0.067550406 0.99605602
		 -0.057526689 0.11788487 0.99282897 -0.019845098 0.16960174 0.98537713 0.016342731
		 0.18071763 0.98341084 0.015631111 0.16425656 0.98635167 -0.011404641 0.14757168 0.98832035
		 -0.038018782 0.052564595 0.9980799 -0.032762904 0.038603283 0.99900109 -0.022507194
		 0.030621026 0.99866045 -0.041710548 -0.12380243 0.9918133 -0.031291761 -0.28039974
		 0.95983195 -0.0099279042 -0.25883037 0.96590877 -0.0052061174 -0.16872889 0.98557121
		 -0.013413432 -0.14217189 0.98963815 -0.020085385 -0.13714172 0.98992622 -0.035189159
		 -0.1087082 0.99258226 -0.054434434 -0.057524603 0.99651706 -0.060372226 -0.014314492
		 0.99760884 -0.067614935 0.0014656093 0.99585569 -0.090935677 0.018728567 0.9931035
		 -0.11573498 0.059720617 0.98769909 -0.14451276 0.10629135 0.97569406 -0.19163275
		 0.09480615 0.96674383 -0.23752525 -0.010924365 0.96665454 -0.25585073 -0.13254966
		 0.95825595 -0.25333032 -0.15077452 0.96302962 -0.22325069 -0.063752756 0.98599118
		 -0.15413289 -0.0029299227 0.99598932 -0.089423224 -0.019713236 0.99820799 -0.056499571
		 -0.030560456 0.99869817 -0.040839605 -0.010950732 0.99932557 -0.035047565 0.0016891949
		 0.9993692 -0.03547214 -0.0062694293 0.9991188 -0.041501772;
	setAttr ".n[996:1161]" -type "float3"  -0.020969911 0.9984284 -0.051970266 -0.019296577
		 0.99777508 -0.06381648 -0.0050410372 0.99719197 -0.07471858 0.00041112132 0.99669737
		 -0.081204765 -0.00096182403 0.99666613 -0.081583142 0.0090028234 0.99776959 -0.066143043
		 0.072132304 0.99680722 -0.034240555 0.11929155 0.99253219 -0.025480865 0.039365619
		 0.99747711 -0.059075072 -0.030248845 0.99524528 -0.092584386 -0.010767179 0.99607736
		 -0.087829553 0.010459496 0.99851942 -0.053380713 0.022743862 0.99963999 -0.014234068
		 0.031686828 0.99949402 0.0027806759 0.040499289 0.99910754 -0.011999251 0.049641091
		 0.99811614 -0.036054682 0.06186327 0.99689746 -0.048667792 0.064807542 0.99635142
		 -0.055532578 0.060677685 0.99609393 -0.064148799 0.087574437 0.99437863 -0.059513558
		 0.14221117 0.98928821 -0.03293528 0.18470909 0.9827773 -0.0055977101 0.19842741 0.98010951
		 0.0034483527 0.1891403 0.98194933 0.0011654703 0.07494165 0.99585432 -0.051555425
		 0.078881435 0.99609709 -0.039600704 0.021908132 0.99842948 -0.051561791 -0.14204301
		 0.98868829 -0.048158437 -0.28877518 0.95620078 -0.047844213 -0.26082185 0.96468949
		 -0.03668898 -0.17069164 0.98513108 -0.019517206 -0.14047554 0.99000961 -0.012148906
		 -0.12557286 0.99192542 -0.017764622 -0.10047796 0.99449462 -0.029740456 -0.058964722
		 0.9976114 -0.035983592 -0.003088197 0.99898207 -0.045003161 0.027668655 0.99658781
		 -0.077763498 0.040834226 0.99140769 -0.12427055 0.083915971 0.98295242 -0.16359305
		 0.12933631 0.97416943 -0.18511064 0.10009611 0.97862369 -0.17965652 -0.0094404947
		 0.98531818 -0.17046732 -0.1226898 0.97442973 -0.18823935 -0.16969396 0.96387172 -0.20531738
		 -0.11295211 0.97788692 -0.17600884 -0.040196672 0.99304372 -0.11067284 -0.036896002
		 0.99751335 -0.060048986 -0.035801757 0.99851757 -0.040998999 -0.011169498 0.99921131
		 -0.038106434 0.004484565 0.99913079 -0.041443899 0.00013807273 0.99876821 -0.049620066
		 -0.014265468 0.99813205 -0.059404444 -0.015127433 0.99783635 -0.063982211 -0.004591804
		 0.99823004 -0.059292797 -0.0027339361 0.99887419 -0.047357969 -0.00076198066 0.99916029
		 -0.040964428 0.0036447267 0.99884468 -0.047916047 0.063922517 0.99619371 -0.059262242
		 0.12716539 0.98965055 -0.066489018 0.060591098 0.9952721 -0.075908318 -0.021819152
		 0.99603802 -0.086210109 -0.027814036 0.99653006 -0.078448713 -0.018545236 0.99880111
		 -0.04530403 0.002823737 0.99991739 -0.012542907 0.037711833 0.9992463 -0.0091997115
		 0.059040211 0.99778867 -0.03052911 0.05852963 0.99720222 -0.046495691 0.05957444
		 0.99727118 -0.04359993 0.064702861 0.99735397 -0.03314608 0.065090284 0.9974438 -0.029481733
		 0.079943359 0.99632305 -0.030813597 0.11921357 0.99255812 -0.024828138 0.16501249
		 0.98622674 -0.011296722 0.19420066 0.98096174 0.00049023121 0.19666664 0.98044968
		 0.006384064 0.084000923 0.99488348 -0.056131516 0.1327533 0.98967063 -0.05411626
		 0.00088511687 0.99909592 -0.042504434 -0.13724391 0.9895978 -0.043131471 -0.28099394
		 0.95733857 -0.067417458 -0.27768847 0.95860565 -0.062962726 -0.1860214 0.98211151
		 -0.029207826 -0.14926562 0.98879707 0.00024786955 -0.12570035 0.99188638 0.018999131
		 -0.093150616 0.99547082 0.018994223 -0.052345209 0.9986257 0.0025579678 0.011936938
		 0.99967557 -0.022499681 0.064742558 0.99560171 -0.067718349 0.079065017 0.98806196
		 -0.13222075 0.10146581 0.97941917 -0.17447886 0.12091091 0.97878486 -0.16541056 0.078631058
		 0.98888779 -0.12616749 -0.0068316013 0.99420148 -0.10731656 -0.095065467 0.98655778
		 -0.13291427 -0.15737537 0.97203672 -0.17429183 -0.14069188 0.97285312 -0.1837457
		 -0.085648574 0.98635787 -0.14057872 -0.061143268 0.99448675 -0.085191846 -0.039719958
		 0.9973377 -0.061154041 -0.01014515 0.99817693 -0.059498779 0.0064385985 0.99812698
		 -0.060837395 0.0029705351 0.99816346 -0.06050691 -0.012913118 0.99825615 -0.057601288
		 -0.019837601 0.9986614 -0.047769763 -0.017830269 0.99955034 -0.024105698 -0.012603427
		 0.99992031 0.00071077346 0.0093475487 0.99994755 -0.004193258 0.02829729 0.99836135
		 -0.049738258 0.079565719 0.99181807 -0.09983059 0.120005 0.98738831 -0.10326215 0.056032781
		 0.99551821 -0.0761825 -0.016898142 0.99765015 -0.066398203 -0.040712785 0.99721867
		 -0.062428046 -0.044775125 0.99828672 -0.037667077 -0.011106892 0.99987477 -0.011274193
		 0.045431193 0.99895054 -0.0058256527 0.07142774 0.99734086 -0.014466533 0.0612926
		 0.99790138 -0.020880695 0.053402212 0.99839056 -0.019089039 0.057896838 0.99825901
		 -0.011266853 0.063759163 0.99795979 -0.0033093845 0.076870225 0.99703217 0.0042171567
		 0.10632749 0.99418992 0.016758289 0.14940006 0.98825586 0.032093257 0.18441023 0.98196739
		 0.041628268 0.19272669 0.98025286 0.044279348 0.075529739 0.99539775 0.058978051
		 0.15256819 0.98689133 0.052615333 -0.015673906 0.99780679 0.064312309 -0.10450838
		 0.99409306 0.029273922 -0.24244362 0.96868318 -0.053610343 -0.29138267 0.95209563
		 -0.092790321 -0.22372979 0.9735409 -0.046511065 -0.17749214 0.98382676 0.024111245
		 -0.13403648 0.98913991 0.060303215 -0.082878336 0.9949351 0.056879539 -0.030136978
		 0.9992615 0.023841275 0.037216406 0.99903876 -0.02316214 0.10514394 0.99154508 -0.076047339
		 0.11986937 0.98403162 -0.13157956 0.10482258 0.98255515 -0.15361565 0.091549195 0.98810738
		 -0.1235417 0.052581184 0.99534154 -0.080810592 -0.0013832335 0.99762219 -0.068906769
		 -0.063823521 0.99324965 -0.09685868 -0.12458541 0.98088467 -0.14947808 -0.1408312
		 0.97183132 -0.18897155 -0.12289528 0.9766711 -0.17609785 -0.091918305 0.98751193
		 -0.12794991 -0.047671355 0.9945305 -0.092933364 -0.012267092 0.99679613 -0.079038106
		 0.0033654617 0.99755377 -0.069822915 -0.0012854721 0.99822986 -0.059460063 -0.016771792
		 0.99858201 -0.050523039 -0.0297298 0.99877095 -0.039658554 -0.034212548 0.99914449
		 -0.023232743 -0.015386576 0.99970227 -0.018937953 0.029713728 0.99873507 -0.040563311
		 0.061451703 0.99512047 -0.07719411 0.093030378 0.99082541 -0.098032266 0.093438655
		 0.99294829 -0.072959021 0.034253255 0.99905461 -0.026766842 -0.010695918 0.99985832
		 -0.012993429 -0.042225882 0.99881941 -0.024016764 -0.060955506 0.99788767 -0.022463122
		 -0.022478152 0.99971128 -0.0084883552;
	setAttr ".n[1162:1327]" -type "float3"  0.044319242 0.99901021 0.0037850705 0.072941057
		 0.99727243 0.011277276 0.062600695 0.99794924 0.013358401 0.051305249 0.99860352
		 0.01260228 0.051742148 0.99852622 0.016371587 0.058095653 0.99800694 0.024638152
		 0.069503404 0.99700361 0.03395813 0.090970948 0.99471009 0.047707085 0.13196926 0.98899305
		 0.066908859 0.17679352 0.98085666 0.081634864 0.19936284 0.97600251 0.08759927 0.054119267
		 0.98359841 0.1720618 0.12695162 0.9766528 0.1732989 -0.0088890139 0.98812824 0.15337378
		 -0.048201244 0.99384224 0.099771544 -0.16233896 0.98669499 -0.0088911476 -0.27603129
		 0.95518339 -0.10691796 -0.28188148 0.95558983 -0.085970312 -0.22704439 0.97386605
		 0.0059693786 -0.14419733 0.98788619 0.057341378 -0.066365592 0.99654144 0.050005656
		 0.0057159634 0.9999727 0.0046607759 0.073900364 0.99567908 -0.056230795 0.1304998
		 0.98687309 -0.095138565 0.13391604 0.98611915 -0.098160714 0.092851542 0.99254459
		 -0.078955218 0.061808515 0.99697769 -0.047066294 0.038120322 0.99897176 -0.02454187
		 0.010034191 0.99943882 -0.03195858 -0.032817513 0.99723917 -0.066611022 -0.08137136
		 0.98897624 -0.12371176 -0.11553538 0.97584116 -0.18543385 -0.13839975 0.96771282
		 -0.21065919 -0.121404 0.97448629 -0.18877874 -0.066864185 0.98652989 -0.1492914 -0.025413213
		 0.99318105 -0.11377832 -0.0086570214 0.99634027 -0.085035458 -0.008950768 0.99776506
		 -0.066217475 -0.014251991 0.99758136 -0.068031348 -0.024022674 0.99542427 -0.092485242
		 -0.028878739 0.99140191 -0.12762536 -0.0054646824 0.98746288 -0.15775689 0.040092513
		 0.98456663 -0.17035612 0.066780388 0.98450744 -0.1621282 0.073113762 0.98981708 -0.1221328
		 0.045944184 0.99791819 -0.045258779 0.0054090023 0.99966943 0.025134556 -0.0014226992
		 0.9991411 0.04141257 -0.026863961 0.99951267 0.015900737 -0.061299656 0.99808818
		 -0.0078852195 -0.0329751 0.99943662 -0.0062590688 0.031364053 0.99938792 0.015493857
		 0.063712135 0.99715036 0.040396709 0.06168326 0.99668145 0.053115986 0.052086607
		 0.9971835 0.053962484 0.047766998 0.99736649 0.054575682 0.051458422 0.99682474 0.060765211
		 0.062431004 0.99563205 0.069419727 0.083900869 0.99375278 0.073593937 0.12624907
		 0.98943263 0.071302906 0.17952637 0.98151022 0.066391885 0.21769737 0.97413319 0.060600135
		 0.058963809 0.98235399 0.17749347 0.10651085 0.97572201 0.19136819 0.018789666 0.98802763
		 0.15312852 -0.0069571007 0.99199182 0.12611073 -0.08131054 0.99416846 0.070835657
		 -0.21959309 0.97522503 -0.026742017 -0.31356558 0.94578826 -0.084623903 -0.28060108
		 0.95859963 -0.048474476 -0.15948214 0.98720068 0.00055246841 -0.046407983 0.99892175
		 -0.0012158229 0.037610691 0.99874294 -0.033137131 0.1030773 0.99267554 -0.063010126
		 0.1319146 0.98883486 -0.069311582 0.11532947 0.99249005 -0.040776592 0.075051077
		 0.99715835 -0.0065172478 0.047843151 0.99882329 0.0079379687 0.035801191 0.99931794
		 0.0090480894 0.024336692 0.99970275 -0.0015130033 -0.0042670048 0.99952722 -0.030448766
		 -0.04102686 0.99627078 -0.075902864 -0.076189056 0.98808807 -0.13370623 -0.11683524
		 0.973046 -0.19882406 -0.12480755 0.96151584 -0.24476583 -0.091710351 0.96676171 -0.2386651
		 -0.05505896 0.97988313 -0.19182692 -0.026102489 0.98829335 -0.15031587 -0.0029574144
		 0.98836732 -0.1520571 0.014723673 0.97926259 -0.20205942 0.0090484312 0.9628821 -0.26977083
		 -0.0098146051 0.94959611 -0.31332234 -0.0056779319 0.9489634 -0.31533495 0.021920115
		 0.95889223 -0.28292266 0.035437774 0.97374952 -0.22484671 0.016003249 0.99047321
		 -0.13677274 -0.013602002 0.99912959 -0.03943485 -0.017536389 0.99972719 0.01543091
		 0.0034838906 0.99964243 0.026512131 -0.0079199765 0.99983537 0.016323326 -0.051440749
		 0.99867177 -0.0029246863 -0.046509441 0.9989177 0.00065893045 0.0067163254 0.99935967
		 0.035144616 0.045171387 0.9962489 0.073808596 0.05710594 0.99385458 0.094825253 0.054229528
		 0.9937765 0.097300261 0.048178587 0.994515 0.092836507 0.048204757 0.99473065 0.090482764
		 0.060212526 0.99413061 0.089881763 0.093993343 0.99224603 0.08132083 0.15254638 0.98661005
		 0.057707407 0.20876431 0.97746491 0.03129819 0.23663679 0.97146255 0.016236534 0.088042729
		 0.98033756 0.17659748 0.12115258 0.97384262 0.19223054 0.047477957 0.98707068 0.15309235
		 0.0067290193 0.990605 0.13658898 -0.0465509 0.99071771 0.12771653 -0.1662344 0.98108685
		 0.099170513 -0.29561335 0.95427579 0.044390161 -0.29435015 0.9556787 -0.0060213897
		 -0.16238451 0.9859938 -0.038045242 -0.033991747 0.99808019 -0.051774025 0.043691121
		 0.99797529 -0.046220027 0.10016368 0.99476558 -0.020216411 0.12385321 0.99229962
		 0.0013506889 0.097540081 0.99518412 0.009711937 0.063644513 0.99781305 0.017848596
		 0.049248409 0.99862659 0.017871736 0.036901496 0.99923354 0.01306037 0.031833965
		 0.99943459 0.010828461 0.016706897 0.99985719 -0.0025573431 -0.012788053 0.9994536
		 -0.030479515 -0.041719314 0.99688041 -0.067000136 -0.072976373 0.99004483 -0.12035684
		 -0.091640845 0.97740948 -0.1904536 -0.086047836 0.96329373 -0.25428537 -0.065471157
		 0.95483738 -0.28982571 -0.03169569 0.9529261 -0.30154142 0.0056859315 0.95282209
		 -0.30347607 0.030638685 0.95529187 -0.29407254 0.018447293 0.96386397 -0.26575536
		 -0.010680567 0.97207582 -0.23442367 -0.016563414 0.97663242 -0.21427749 -0.0052084136
		 0.9815563 -0.19110295 -0.009439447 0.98950678 -0.14417803 -0.044205718 0.99595302
		 -0.078252479 -0.055407442 0.99817127 -0.024164803 -0.025959695 0.99965781 -0.0032168059
		 -0.0018261526 0.99997842 0.0063221748 -0.0026435957 0.99985993 0.016528668 -0.040279999
		 0.99912608 0.011164108 -0.060023136 0.99813557 0.011065551 -0.023658533 0.99883699
		 0.042010579 0.020422425 0.99615151 0.085235454 0.047537517 0.99225318 0.11477676
		 0.056487922 0.99080306 0.12295616 0.054376721 0.99183464 0.11535619 0.053351875 0.99333596
		 0.10216284 0.068864502 0.99386108 0.086590789 0.11998627 0.99083829 0.061990049 0.18963549
		 0.98125339 0.03435291 0.22641432 0.97375166 0.023328664 0.22539337 0.9738391 0.02890096
		 0.11442839 0.97701222 0.17987038 0.13451922 0.97312212 0.18691696;
	setAttr ".n[1328:1493]" -type "float3"  0.070990235 0.98344898 0.16669877 0.013698879
		 0.98785061 0.15480109 -0.039714105 0.98841113 0.14651401 -0.1541083 0.97695976 0.14764889
		 -0.26939383 0.95243037 0.14248945 -0.25143504 0.96370929 0.089693114 -0.1376954 0.99031544
		 0.017758055 -0.034572985 0.99937904 -0.0067953677 0.022737421 0.99956936 0.018547432
		 0.071289875 0.99532568 0.0651493 0.1248356 0.9888401 0.08131025 0.10808585 0.99269265
		 0.053654265 0.062462609 0.99755722 0.031273711 0.050542511 0.99823546 0.031165691
		 0.037566897 0.99874932 0.032995243 0.035501219 0.99896246 0.028525481 0.034393892
		 0.99935675 0.01015452 0.011382332 0.99965519 -0.023661738 -0.018292226 0.99817902
		 -0.057481654 -0.044441607 0.99568689 -0.081440598 -0.055677205 0.99256831 -0.10820469
		 -0.047685944 0.98640519 -0.15726028 -0.04094182 0.97573972 -0.2150715 -0.030084766
		 0.96980864 -0.24200465 -0.012265678 0.97565979 -0.2189465 -0.0023243183 0.98764539
		 -0.15668787 -0.014516638 0.99615717 -0.086372413 -0.024649279 0.99866521 -0.045389593
		 -0.016257094 0.99900597 -0.041506592 -0.01393856 0.99870771 -0.048874989 -0.035261389
		 0.99844313 -0.043219097 -0.072902307 0.99693906 -0.028246898 -0.073492602 0.99721855
		 -0.01240788 -0.033276912 0.99943238 0.0052541369 -0.013110926 0.99963224 0.023735946
		 -0.011146287 0.99900562 0.043168437 -0.031327639 0.99836105 0.047892854 -0.057694759
		 0.99784964 0.031103868 -0.044178743 0.9986406 0.02766313 -0.0070584421 0.99838096
		 0.056442078 0.02896573 0.99500334 0.095547795 0.053751256 0.9914273 0.11909111 0.0647965
		 0.9910996 0.11628774 0.070011057 0.99325407 0.092438139 0.091482475 0.99408454 0.058541153
		 0.15001997 0.98830944 0.027176436 0.19937162 0.97974843 0.018551137 0.19667128 0.97980917
		 0.035976853 0.17797028 0.98239326 0.056832831 0.11773244 0.97664762 0.17971781 0.12510769
		 0.97684997 0.17352845 0.081425034 0.97965515 0.18342771 0.021708459 0.98350292 0.17958443
		 -0.029436992 0.98562485 0.16636373 -0.15245911 0.97685981 0.15000379 -0.26039839
		 0.95585376 0.13614802 -0.21125019 0.97030312 0.11783563 -0.10913095 0.99004859 0.088849686
		 -0.037645299 0.99662489 0.072950497 -0.004857427 0.99587154 0.090643719 0.045119643
		 0.99157721 0.12140351 0.13890497 0.98312014 0.11908139 0.13483116 0.98726434 0.084436856
		 0.06456621 0.99585032 0.064135887 0.043209448 0.99648315 0.071792811 0.036478303
		 0.99597806 0.081835024 0.044517998 0.99627388 0.073867291 0.061267309 0.99737233
		 0.038662046 0.047235977 0.99868733 -0.019806286 0.010213201 0.99673951 -0.080037139
		 -0.028620869 0.99233586 -0.12021013 -0.044269543 0.99014968 -0.13283011 -0.028912239
		 0.9913137 -0.12830178 -0.028358558 0.99282229 -0.11618771 -0.043275539 0.9950521
		 -0.089434467 -0.041238248 0.99767447 -0.054268368 -0.032208126 0.99891055 -0.033768818
		 -0.034858473 0.99888384 -0.031874511 -0.033056926 0.99896729 -0.031167777 -0.018329609
		 0.99963629 -0.019781077 -0.015854737 0.99985456 -0.0062826318 -0.040056434 0.99919611
		 -0.0015934397 -0.076775424 0.99704212 -0.0035775655 -0.080730326 0.99673265 -0.0025636209
		 -0.043952893 0.99900842 0.0071038166 -0.025622936 0.99939668 0.02344735 -0.026718544
		 0.99859685 0.045720045 -0.029868567 0.9976458 0.061732136 -0.039326552 0.9980365
		 0.048748538 -0.039930109 0.99902779 0.018681545 -0.027207125 0.99952877 0.014211158
		 0.0014265635 0.99890673 0.046726208 0.041297913 0.99568766 0.083069444 0.074476287
		 0.99304163 0.091221921 0.096920133 0.99316186 0.065083966 0.12530088 0.99191868 0.019928532
		 0.1644029 0.98638201 -0.0047067567 0.17084216 0.98519492 0.014279882 0.14575462 0.98810703
		 0.04899073 0.13008827 0.98904687 0.069736719 0.0988729 0.98123312 0.16554672 0.093305707
		 0.98388946 0.15249757 0.077225693 0.98062718 0.18001802 0.026304461 0.9820354 0.18685475
		 -0.019009953 0.98297173 0.18277091 -0.13370948 0.9781298 0.15932339 -0.24679579 0.96123528
		 0.12295797 -0.199338 0.97425121 0.1053508 -0.094954781 0.99066317 0.097827032 -0.03576212
		 0.99534982 0.08944083 -0.018163184 0.99584156 0.089273013 0.035841297 0.99506652
		 0.092510231 0.14907335 0.98457682 0.091573358 0.14722052 0.98475671 0.092630237 0.060860515
		 0.99301916 0.10103892 0.031118326 0.99275053 0.116095 0.031168524 0.9909085 0.1308766
		 0.056812327 0.99016678 0.12783618 0.095144249 0.99100381 0.094123028 0.090398826
		 0.9951449 0.038918417 0.041292056 0.9990992 -0.0097868284 -0.0081376946 0.99893421
		 -0.045432772 -0.030002857 0.99596536 -0.084573627 -0.026600216 0.99313605 -0.11389969
		 -0.0449658 0.99343956 -0.10514794 -0.073184237 0.99523711 -0.064397991 -0.063090481
		 0.99770409 -0.024620246 -0.039701033 0.99920774 -0.0027735007 -0.034761786 0.99937677
		 0.0061329878 -0.039699007 0.99910009 0.014932815 -0.03096379 0.99902898 0.0313439
		 -0.019826299 0.99891347 0.042176358 -0.034140781 0.99880832 0.034875523 -0.068905063
		 0.99748951 0.016330864 -0.080301851 0.99676633 0.0029314095 -0.051718757 0.99865168
		 0.0044754324 -0.035580013 0.99925935 0.014655996 -0.040260747 0.99882215 0.027078934
		 -0.037968688 0.99836218 0.042793367 -0.028796287 0.99824274 0.051791489 -0.023375228
		 0.99887222 0.041327763 -0.03042396 0.99920636 0.025713949 -0.019513067 0.99938232
		 0.02922721 0.027530974 0.99860048 0.04515576 0.081930399 0.99550289 0.047555763 0.12498301
		 0.99185646 0.024498947 0.15099911 0.98853034 -0.0026319602 0.14856857 0.98887473
		 0.0073538884 0.12300309 0.99109566 0.050985903 0.1043742 0.99079341 0.086223491 0.095783912
		 0.99023992 0.10124346 0.071697623 0.98905838 0.12893011 0.058616504 0.99166328 0.1147522
		 0.06454657 0.98701853 0.14706567 0.024776746 0.98675382 0.16032173 -0.01608583 0.98604995
		 0.16567118 -0.1044865 0.98398751 0.14439897 -0.21914761 0.97105342 0.095024563 -0.19896986
		 0.97731584 0.072558917 -0.095347635 0.99202263 0.082461178 -0.032279294 0.99571872
		 0.086616077 -0.0086831711 0.99766666 0.067719676 0.042397104 0.99828267 0.040424854
		 0.1389547 0.98932892 0.043817986 0.13074467 0.98799092 0.082339726 0.047263097 0.99165601
		 0.11993515;
	setAttr ".n[1494:1659]" -type "float3"  0.018658862 0.98963356 0.14239824 0.024895592
		 0.98767 0.1545575 0.066895686 0.98614734 0.15178408 0.12237125 0.98397607 0.12967804
		 0.11772819 0.98758197 0.10402836 0.053452767 0.99408531 0.094537102 0.013441151 0.99670893
		 0.079941764 0.0047525573 0.99935406 0.035621177 -0.01676197 0.99985951 -7.1349074e-005
		 -0.0630394 0.99800378 0.0037815876 -0.093500704 0.99544001 0.018895462 -0.078012697
		 0.99649245 0.030279839 -0.05099678 0.99762636 0.046272118 -0.039418619 0.99740005
		 0.060327165 -0.046458554 0.99660426 0.067981556 -0.039249729 0.99656242 0.072956502
		 -0.016605785 0.99747562 0.069040589 -0.02102294 0.99841529 0.052201368 -0.054160029
		 0.99810052 0.029358232 -0.075519472 0.99705219 0.013554123 -0.057762645 0.99823272
		 0.013960705 -0.040464655 0.99897557 0.020256266 -0.046057485 0.99865764 0.023696184
		 -0.049378004 0.99822319 0.03335093 -0.037355117 0.99784672 0.053913001 -0.020714013
		 0.99710059 0.073220618 -0.023636131 0.99694932 0.074386641 -0.019314539 0.99802887
		 0.059710208 0.028235016 0.99869305 0.042601988 0.092480972 0.99540573 0.024791732
		 0.138368 0.9902727 0.014642664 0.14235391 0.98917913 0.035499629 0.10925452 0.99048275
		 0.083710931 0.084252238 0.98849106 0.12564659 0.079620361 0.98594469 0.14687936 0.075451732
		 0.98462564 0.15754198 0.050961517 0.9948411 0.087716348 0.039461482 0.99589479 0.081464425
		 0.050479066 0.99374467 0.099615917 0.02117409 0.99371296 0.10993695 -0.01552375 0.99358225
		 0.11204135 -0.072818249 0.9934231 0.088363729 -0.1856568 0.98174042 0.041442316 -0.20562305
		 0.97828466 0.026045579 -0.10920936 0.99280953 0.049015939 -0.028687771 0.997729 0.060941104
		 0.021080779 0.99930787 0.030650066 0.06177849 0.99796867 -0.015552804 0.10952133
		 0.99395716 -0.007365129 0.088639177 0.99426669 0.059806336 0.023047529 0.99238324
		 0.12101427 0.0061968262 0.98844874 0.15142874 0.024019383 0.98704773 0.15861845 0.077805772
		 0.98606759 0.14702682 0.1386659 0.98195332 0.12860654 0.12358566 0.98474723 0.12247283
		 0.054674819 0.99086863 0.12324795 0.032146875 0.99352074 0.10900947 0.025899801 0.99516618
		 0.094728157 -0.018678408 0.99450248 0.10303289 -0.070173629 0.99096972 0.11425716
		 -0.092500374 0.98961532 0.11002319 -0.083501838 0.99079758 0.10652494 -0.056471232
		 0.99264777 0.10705755 -0.03630434 0.99464971 0.0967151 -0.046078637 0.99536121 0.084456243
		 -0.040450789 0.99592799 0.080568716 -0.0088936789 0.99719489 0.074320115 -0.0073550781
		 0.99819517 0.059601098 -0.039238967 0.9984138 0.040375873 -0.069751851 0.99723762
		 0.025532 -0.063305326 0.99768639 0.024782561 -0.043792106 0.99853462 0.031796083
		 -0.048552617 0.99812788 0.037193894 -0.060361598 0.99703526 0.047719788 -0.054846633
		 0.99606407 0.069629259 -0.031394251 0.99523526 0.0923094 -0.018804172 0.99484438
		 0.099655069 -0.0099301999 0.99563992 0.092750199 0.036857978 0.99583876 0.083345912
		 0.10067677 0.9918828 0.07767114 0.13025321 0.98742622 0.089573197 0.10985432 0.98596382
		 0.12572719 0.075153776 0.98375171 0.16304757 0.06438753 0.9807604 0.18429101 0.068836235
		 0.97870618 0.19338 0.073732674 0.97758168 0.1972246 0.03739588 0.99827641 0.045230664
		 0.023376051 0.99902391 0.03748212 0.043644667 0.99779975 0.049906977 0.026450943
		 0.9987154 0.043218486 -0.010589965 0.99942744 0.032135848 -0.055256721 0.99813133
		 0.026090397 -0.15539953 0.98784411 0.0038675501 -0.20432776 0.9785862 -0.024882797
		 -0.12419859 0.99196249 -0.024187816 -0.024475781 0.99952996 -0.018458894 0.053533755
		 0.99766773 -0.042347513 0.084849946 0.99325645 -0.079006948 0.070081666 0.99535561
		 -0.065997124 0.029107047 0.99949628 0.012640731 -0.00888409 0.9961952 0.086696282
		 -0.0081520323 0.99227506 0.12378901 0.027014283 0.99067348 0.13355294 0.08980684
		 0.98829389 0.12332876 0.14151798 0.98278272 0.11878852 0.11376484 0.98413897 0.13611816
		 0.055915698 0.987198 0.1493775 0.043515954 0.98843944 0.14523761 0.021945829 0.98857242
		 0.14914075 -0.029726164 0.98598778 0.16414762 -0.070455931 0.98271692 0.17118263
		 -0.088459291 0.98110026 0.17209661 -0.084220834 0.98130655 0.17304441 -0.051565319
		 0.9844051 0.16818935 -0.020599132 0.98850381 0.149786 -0.032469589 0.99218339 0.12048987
		 -0.03267353 0.99510729 0.093241602 -0.00039085886 0.99717623 0.07509584 0.0038157078
		 0.99813396 0.060943916 -0.025791805 0.99868119 0.044392146 -0.06172068 0.99770558
		 0.027823512 -0.067281365 0.99747735 0.022627741 -0.0520726 0.99807966 0.033544987
		 -0.056708984 0.99701929 0.05231265 -0.072907865 0.99469972 0.072504632 -0.071382046
		 0.99301511 0.093945794 -0.042055156 0.99283493 0.11184896 -0.018288225 0.99265468
		 0.11959184 -0.0069733332 0.99258661 0.12133957 0.03458368 0.99093312 0.12982915 0.092838101
		 0.98429358 0.15015706 0.11437427 0.97838259 0.17229618 0.088707767 0.97833085 0.18708235
		 0.060369715 0.97878313 0.19580375 0.059378497 0.97816819 0.19915123 0.074196361 0.97792727
		 0.19532813 0.091971353 0.97796875 0.18739848 0.022853749 0.99969333 0.0095431842
		 0.010821478 0.99993128 0.0045036399 0.039272174 0.99909288 0.016465442 0.037827421
		 0.99919003 0.013723964 -0.0017657843 0.99999446 0.0028250641 -0.058287211 0.99828345
		 0.0057375389 -0.12993768 0.99151182 -0.0045282533 -0.1688737 0.98333907 -0.067275971
		 -0.11820054 0.98480397 -0.12723924 -0.02325332 0.98962361 -0.14178981 0.064347498
		 0.98855436 -0.13645335 0.090412542 0.98799735 -0.12524711 0.038779285 0.99409461
		 -0.10135157 -0.021942014 0.99810129 -0.057552923 -0.042626549 0.9990766 -0.005359259
		 -0.026115349 0.99905401 0.034773145 0.024821891 0.99814969 0.055507336 0.089654885
		 0.99360251 0.068674557 0.11993057 0.9873637 0.10358353 0.087852374 0.98377687 0.15641309
		 0.054618914 0.98158586 0.18304609 0.047568984 0.98201746 0.18269926 0.015800927 0.983132
		 0.18221346 -0.033836782 0.98256457 0.18281639 -0.070429593 0.98074698 0.18213993
		 -0.089796364 0.97890323 0.18353523 -0.085612833 0.97859907 0.18712136 -0.050915319
		 0.97972506 0.19376938;
	setAttr ".n[1660:1825]" -type "float3"  -0.010638885 0.98027247 0.19736442 -0.0090679005
		 0.983778 0.17916073 -0.012830268 0.98954809 0.14363091 0.012472976 0.9935177 0.11299116
		 0.020339346 0.99631339 0.083342604 -0.0076887514 0.99875444 0.049300414 -0.046794601
		 0.99874878 0.017635979 -0.066249669 0.99780297 -0.00050819194 -0.067927845 0.99764138
		 0.0098678805 -0.07831315 0.9958967 0.045352738 -0.09467224 0.99158353 0.088313013
		 -0.088808164 0.98822618 0.12458773 -0.047303714 0.9889338 0.14061373 -0.014182408
		 0.99075711 0.1349048 -0.0061610132 0.99199468 0.12612857 0.022307759 0.9906463 0.13461906
		 0.072211668 0.98415053 0.16196671 0.10055683 0.97681314 0.18900858 0.084271178 0.976327
		 0.19920821 0.061026487 0.97898412 0.19459149 0.069249354 0.98113132 0.18051565 0.099108838
		 0.98211145 0.16010766 0.13036099 0.98151535 0.14011957 0.025108518 0.99757028 0.064985648
		 0.027511241 0.99653202 0.078530669 0.036417998 0.99780524 0.055301812 0.044070039
		 0.99777746 0.049979936 0.010438805 0.99924368 0.037459277 -0.059797715 0.9979192
		 0.024115654 -0.10606527 0.99435395 0.0032407355 -0.10491721 0.99232751 -0.065409794
		 -0.082927667 0.98505646 -0.15095297 -0.031179648 0.98387039 -0.17614459 0.038709577
		 0.99038965 -0.1327775 0.067850038 0.99517858 -0.070823647 0.028130887 0.99861491
		 -0.044461939 -0.035110772 0.9980033 -0.052502781 -0.065738454 0.99656814 -0.050303858
		 -0.048273887 0.99858642 -0.022246664 0.010401581 0.99987113 0.012232029 0.068545461
		 0.9963606 0.050666779 0.079591319 0.99139625 0.10391661 0.060877908 0.9869926 0.14879347
		 0.059190694 0.9862172 0.15450582 0.054538175 0.988864 0.1384688 0.013917478 0.99103689
		 0.13286187 -0.036753278 0.98945946 0.14006823 -0.073158227 0.98616356 0.14875932
		 -0.09553083 0.98264724 0.1589914 -0.094125576 0.97993112 0.17571346 -0.059156056
		 0.9793458 0.19334522 -0.012699082 0.97881562 0.20434988 0.0080837086 0.97956479 0.20096633
		 0.0071899188 0.98308897 0.18298759 0.030113319 0.98698962 0.15793973 0.048617337
		 0.9916836 0.11916415 0.017949324 0.99711609 0.073738992 -0.030319327 0.9986046 0.043236278
		 -0.061744716 0.9976325 0.030283006 -0.086960286 0.99537563 0.040806584 -0.10910951
		 0.99100029 0.077547573 -0.11940753 0.98608857 0.11563407 -0.10395399 0.98493165 0.13821442
		 -0.039606899 0.99031597 0.13306217 0.0028066258 0.99485272 0.10129255 -0.0079212552
		 0.99617755 0.086991623 0.0025676931 0.99388748 0.11036739 0.049825061 0.98815 0.14517996
		 0.085638456 0.9812941 0.17241825 0.083668038 0.97922468 0.18471196 0.073186234 0.98200196
		 0.17411421 0.088877864 0.98463982 0.15028307 0.13292308 0.98305106 0.12626183 0.17421813
		 0.97848111 0.11055626 0.039179113 0.98462743 0.17021692 0.044712953 0.98330384 0.17639221
		 0.042101804 0.98641264 0.15880041 0.051023487 0.98840696 0.14299735 0.028176893 0.99255687
		 0.11847765 -0.052385792 0.99387288 0.097326398 -0.087869987 0.99267292 0.082941346
		 -0.054321405 0.99716669 0.052035548 -0.04676706 0.99882895 0.01239139 -0.044240244
		 0.99901384 0.003749429 -0.0058214297 0.99908167 0.04244893 0.044613566 0.99573559
		 0.080747664 0.035977297 0.99623889 0.078826666 -0.02610687 0.99768567 0.062781855
		 -0.081277229 0.9942441 0.069804937 -0.076152086 0.99136358 0.10676687 -0.008682007
		 0.98947185 0.14446504 0.042547707 0.98415661 0.17212063 0.052093159 0.97957414 0.19421855
		 0.058459256 0.97983146 0.19108285 0.083432361 0.984797 0.15236124 0.079368308 0.99213684
		 0.096773908 0.019264374 0.99799871 0.060227502 -0.042877629 0.99752903 0.05565368
		 -0.078181237 0.99488354 0.063987128 -0.10815588 0.99097842 0.079145588 -0.11657806
		 0.98673767 0.11295326 -0.073404901 0.98614562 0.14875631 -0.017229635 0.98621178
		 0.16458854 0.011372471 0.98539913 0.16988015 0.016142471 0.98514837 0.17094475 0.046610855
		 0.98617578 0.15901203 0.081101604 0.98891449 0.12438091 0.042080987 0.99543405 0.085675269
		 -0.032223448 0.99596322 0.083779663 -0.072996005 0.99033391 0.11794116 -0.10058781
		 0.98396504 0.14729212 -0.12417245 0.98035395 0.15325584 -0.12758216 0.98046768 0.14968614
		 -0.10078543 0.98580515 0.13427761 -0.012207041 0.99576503 0.091120847 0.028180528
		 0.99878824 0.040346526 -0.019798649 0.99923873 0.033615917 -0.028866669 0.99666792
		 0.076286934 0.029005896 0.99218589 0.12134983 0.07843174 0.98756397 0.13625684 0.091785893
		 0.98804218 0.12388682 0.08904843 0.99074006 0.10249249 0.10120702 0.99067467 0.091218345
		 0.16263454 0.98363566 0.077529721 0.21805353 0.97402114 0.061119381 0.047648881 0.98904085
		 0.13974223 0.049831606 0.98905444 0.13888182 0.05081632 0.98931199 0.13667303 0.060433038
		 0.98963845 0.13024403 0.039918158 0.99128228 0.1255627 -0.052203078 0.9899379 0.13152154
		 -0.086882472 0.98532003 0.14695501 -0.041749842 0.98597217 0.16160364 -0.038691718
		 0.98395288 0.17418279 -0.05254763 0.98105395 0.1864728 -0.028320743 0.98034042 0.19527042
		 0.043558843 0.98057181 0.19126323 0.046895798 0.9831028 0.17694552 -0.027762484 0.98325479
		 0.18010858 -0.10543131 0.97104001 0.21439563 -0.10895228 0.95710063 0.26849195 -0.028885787
		 0.94848257 0.31551 0.025992747 0.9403348 0.33925638 0.047010005 0.93830621 0.34259507
		 0.070978336 0.94158632 0.32920709 0.11468546 0.94768226 0.29790184 0.12075398 0.96312028
		 0.24045348 0.041834079 0.98295879 0.17900281 -0.037216168 0.98982507 0.13733716 -0.067443699
		 0.99263322 0.10065097 -0.10375039 0.99283642 0.059258856 -0.13262595 0.99030077 0.041409645
		 -0.086503401 0.99501032 0.049714889 -0.018523948 0.99829096 0.055427402 0.0061832126
		 0.99816805 0.060185317 0.011811761 0.99707031 0.075571917 0.049853623 0.99447328
		 0.092399247 0.10617013 0.99064463 0.085737616 0.061235197 0.99638534 0.058877327
		 -0.057178404 0.99586898 0.070537634 -0.11137497 0.98494577 0.13220184 -0.10956534
		 0.97824746 0.1761456 -0.11628199 0.97825819 0.17172496 -0.12016324 0.98096853 0.15251742
		 -0.080209501 0.98871922 0.12649405 0.023565535 0.9962095 0.083733246;
	setAttr ".n[1826:1991]" -type "float3"  0.054558162 0.99772477 0.039609019 -0.025993075
		 0.9995333 0.016044639 -0.056032233 0.99811745 0.02493592 0.014990956 0.99886072 0.045305032
		 0.088700175 0.99534583 0.037668597 0.11159532 0.99373615 0.0059178672 0.098377928
		 0.99503911 -0.014802074 0.099487245 0.99494302 -0.013806758 0.1753889 0.98438919
		 -0.014720104 0.2522583 0.96748096 -0.018613638 0.073010698 0.99524814 0.06442412
		 0.093775339 0.99159253 0.089165568 0.064124256 0.99718285 0.038915694 0.066188172
		 0.99745238 0.026607903 0.034534272 0.99874914 0.036159035 -0.066864707 0.99587178
		 0.061387885 -0.099901184 0.99147207 0.083683342 -0.053254977 0.9931913 0.1036097
		 -0.053206854 0.99033487 0.12808585 -0.061286662 0.98700857 0.14851937 -0.030255917
		 0.98758096 0.15417019 0.054218121 0.98790479 0.14527421 0.052093573 0.98909122 0.1377854
		 -0.040592372 0.98835868 0.14662679 -0.13462557 0.97583491 0.17211133 -0.14811349
		 0.96545643 0.21437432 -0.057056669 0.9629612 0.26353419 0.014320609 0.95507103 0.29603076
		 0.049010072 0.95002812 0.30829296 0.077830568 0.94733369 0.31064665 0.1320249 0.94252408
		 0.30694908 0.15524039 0.94560361 0.28589192 0.074409038 0.96617323 0.24692611 -0.012164133
		 0.97994161 0.1989135 -0.032523956 0.98935056 0.14187209 -0.065320939 0.99545044 0.069366217
		 -0.12126899 0.99257261 0.0096741104 -0.094010063 0.99555629 -0.005458618 -0.020302903
		 0.99978757 0.0035460349 -0.00053175626 0.99992853 0.011941208 0.00093908119 0.99971312
		 0.023930306 0.033830125 0.99824286 0.048648078 0.11247576 0.99127084 0.068783782
		 0.075276338 0.99503934 0.065039083 -0.085996255 0.99330944 0.077077746 -0.15284111
		 0.98074889 0.12153667 -0.11934263 0.98043686 0.15652743 -0.10602086 0.98148507 0.15952039
		 -0.10354852 0.98501933 0.13789387 -0.061397705 0.99196202 0.11064185 0.039324496
		 0.99423152 0.099785782 0.073803335 0.9932034 0.090000644 -0.013380758 0.99779809
		 0.06496077 -0.062174942 0.9970628 0.044723034 0.013312657 0.99916738 0.038564265
		 0.10894316 0.9938308 0.020777633 0.13493972 0.99077868 -0.012207182 0.11138733 0.99274242
		 -0.045336641 0.10304032 0.99220067 -0.070147552 0.17180078 0.98180634 -0.080875643
		 0.25775731 0.96286011 -0.080384113 0.12981486 0.98353839 0.12569961 0.15934154 0.97310561
		 0.16636041 0.098054014 0.99254733 0.072354712 0.077000529 0.99651152 0.032184821
		 0.026509864 0.99942696 0.021043543 -0.077252217 0.99673766 0.023371214 -0.10381313
		 0.99437797 0.020861596 -0.062248871 0.9978742 0.019289354 -0.066686027 0.99741459
		 0.026780121 -0.068775058 0.99701321 0.035138104 -0.028379027 0.99895239 0.035897423
		 0.066291697 0.997531 0.023177397 0.052740067 0.99852359 0.013008113 -0.055564009
		 0.99814677 0.024813209 -0.15894409 0.98583519 0.053531665 -0.18044905 0.97946835
		 0.089887276 -0.081546061 0.98911744 0.12246182 0.0010884668 0.98942447 0.14504473
		 0.044194929 0.98559397 0.1632527 0.075929537 0.98159629 0.17522381 0.13505575 0.97421068
		 0.18075858 0.17480445 0.96918601 0.17355666 0.10357597 0.9833945 0.14902124 0.016470099
		 0.99336642 0.11380567 0.00074369501 0.99694264 0.078133225 -0.024170132 0.99900281
		 0.037538305 -0.10275247 0.99469 0.0057963226 -0.10531143 0.99439985 0.008860508 -0.029355964
		 0.99907917 0.031290017 -0.0077394168 0.99884474 0.047426492 -0.0079064779 0.998182
		 0.059752643 0.013866077 0.99682981 0.07834556 0.097955763 0.98920959 0.10894521 0.077008955
		 0.98810816 0.13308644 -0.10341097 0.9837563 0.14672928 -0.17791705 0.96993428 0.16605124
		 -0.12332381 0.97607183 0.17909521 -0.095172159 0.98131585 0.16721684 -0.083049126
		 0.98627734 0.14268716 -0.051475793 0.99078989 0.12524195 0.033565126 0.99092406 0.13016471
		 0.080915786 0.98721635 0.13731861 0.0049576866 0.99235636 0.12330516 -0.058081932
		 0.99262929 0.10636523 0.015829042 0.99449182 0.10361239 0.12852803 0.98757499 0.090422072
		 0.16385159 0.98514646 0.051372007 0.14280944 0.98974395 -0.0035306946 0.12540482
		 0.99076366 -0.051585257 0.16940111 0.98266727 -0.075288117 0.23715568 0.96815789
		 -0.080171749 0.15832135 0.97068328 0.18085437 0.14212546 0.97617531 0.16395769 0.1402244
		 0.97732925 0.15863375 0.10198034 0.98830366 0.1133834 0.030682992 0.99613005 0.082362339
		 -0.074277177 0.9949013 0.068220884 -0.094793096 0.99411476 0.052440852 -0.058941059
		 0.99761772 0.035845313 -0.067315958 0.99741763 0.025032159 -0.06783668 0.99755901
		 0.016560785 -0.024196347 0.99967444 0.008103488 0.076857276 0.99703884 -0.0025670272
		 0.051659364 0.99864107 -0.0068799844 -0.071499661 0.99741077 0.0077147228 -0.179553
		 0.98315346 0.034204882 -0.20308244 0.97711432 0.063285492 -0.098618351 0.99083149
		 0.09234409 -0.013336643 0.99316955 0.11591579 0.032990657 0.99021578 0.13558856 0.069492459
		 0.98625511 0.14990567 0.13088854 0.97852033 0.15926774 0.18429424 0.97038245 0.15618414
		 0.12620829 0.98295164 0.13370682 0.038810555 0.99414873 0.10080659 0.021129556 0.99730623
		 0.070241377 0.00042173915 0.99914962 0.041229416 -0.093786918 0.99535555 0.021710034
		 -0.1188587 0.99259591 0.025018932 -0.041634973 0.99823594 0.042326979 -0.017514857
		 0.99810106 0.059054486 -0.017587416 0.99697798 0.075667545 -0.0035274783 0.99527085
		 0.09707503 0.067907162 0.98818195 0.13742298 0.066890851 0.98242629 0.17425315 -0.10339262
		 0.97877717 0.17693311 -0.18709624 0.96777624 0.16853526 -0.12084763 0.9783566 0.1679714
		 -0.083234414 0.98373938 0.1591507 -0.070193507 0.98655009 0.14762023 -0.047843926
		 0.9887616 0.141638 0.023010921 0.98878837 0.1475399 0.080989957 0.98460907 0.15487354
		 0.021982927 0.98945886 0.14313577 -0.053882878 0.99051428 0.12640435 0.015560804
		 0.99191874 0.12591654 0.1459775 0.982391 0.11661286 0.19556513 0.977175 0.082965568
		 0.18022072 0.98292452 0.037147544 0.15125923 0.9884941 0.0001355565 0.17161594 0.98509914
		 -0.011299724 0.21730547 0.97608393 -0.0062096934 0.10278786 0.98626214 0.1293122
		 0.060008168 0.99615169 0.063880786 0.12786411 0.96946156 0.20927279;
	setAttr ".n[1992:2157]" -type "float3"  0.11321854 0.96192944 0.24874353 0.044291817
		 0.97023928 0.23806301 -0.059763409 0.97583967 0.21015532 -0.075351283 0.980986 0.17885326
		 -0.040271923 0.98903233 0.14210279 -0.051954132 0.99299145 0.10615396 -0.055455811
		 0.99558127 0.075779185 -0.016418707 0.99833316 0.055327106 0.084423326 0.99550372
		 0.04295335 0.048708133 0.99797761 0.040842544 -0.085553169 0.99491107 0.053221084
		 -0.19258496 0.97884154 0.069138616 -0.22063394 0.97154665 0.086126588 -0.11733683
		 0.98687017 0.11099242 -0.028496955 0.99054831 0.13417122 0.020372957 0.98805463 0.15275131
		 0.061475214 0.98400301 0.1672089 0.12566805 0.97632754 0.17604569 0.19314347 0.96615458
		 0.17099963 0.14771241 0.97782117 0.14848176 0.059497051 0.99126458 0.117706 0.038106598
		 0.9951793 0.090365574 0.015199125 0.99739361 0.070534423 -0.089019805 0.99424165
		 0.059657034 -0.12797919 0.98984605 0.061856743 -0.052969899 0.99570495 0.075932778
		 -0.027333664 0.99553365 0.09036421 -0.028018311 0.99421853 0.10365521 -0.020884674
		 0.99216288 0.12319344 0.033765901 0.9866811 0.15912332 0.058020018 0.98093033 0.18549736
		 -0.088552214 0.98036081 0.17621358 -0.18693796 0.96932167 0.15959249 -0.12220202
		 0.97881562 0.16427642 -0.079314545 0.98211747 0.17074674 -0.064883791 0.98327267
		 0.17019099 -0.045469146 0.98497409 0.16660908 0.014080727 0.98512238 0.17127649 0.074649066
		 0.97983557 0.18533686 0.031086618 0.9808287 0.1923762 -0.055589031 0.97906387 0.19581589
		 0.010374915 0.97819322 0.2074378 0.16055597 0.96653932 0.20005831 0.21965334 0.9605853
		 0.17037712 0.20562758 0.9686808 0.13919373 0.16100018 0.97910428 0.12423215 0.15861444
		 0.97830945 0.13323684 0.19227339 0.96990913 0.14935604 0.032893531 0.99844742 0.044953745
		 0.012545 0.99985188 0.011785303 0.063495167 0.99020314 0.12436198 0.083247818 0.97233254
		 0.21826409 0.03753338 0.95794022 0.28450313 -0.059506297 0.94471443 0.32244939 -0.060525939
		 0.93924183 0.33787784 -0.013610239 0.94647497 0.3224903 -0.022200489 0.9576686 0.28701538
		 -0.029333396 0.96883154 0.24597763 -0.0030218742 0.9764632 0.21566288 0.098132089
		 0.97706723 0.18896985 0.05361959 0.98545736 0.16124123 -0.093905568 0.98312998 0.15696274
		 -0.19797464 0.96550214 0.16914979 -0.23482639 0.9536131 0.18835767 -0.136309 0.96725017
		 0.21411894 -0.043070462 0.97161776 0.23260219 0.0083623426 0.96930534 0.24571738
		 0.052324239 0.96507961 0.25667772 0.11893745 0.95667893 0.26574302 0.20226233 0.94454628
		 0.25869343 0.16811803 0.95830381 0.23106338 0.078118525 0.97681373 0.19933005 0.0512974
		 0.98308134 0.1758395 0.023377065 0.98668766 0.16093783 -0.08715833 0.9840731 0.15493034
		 -0.13851655 0.97638112 0.16580981 -0.065413684 0.97994095 0.18824694 -0.034474988
		 0.97862053 0.20276383 -0.03431946 0.97714645 0.20977847 -0.036431409 0.97403944 0.22342798
		 0.0044925022 0.9670645 0.2544919 0.05729603 0.96115482 0.26999727 -0.069135234 0.96473587
		 0.25397861 -0.19092591 0.94954652 0.24881469 -0.13169163 0.95234936 0.27511442 -0.077254348
		 0.95394266 0.28987101 -0.056582138 0.95653224 0.28608477 -0.038210969 0.96012527
		 0.27694684 0.0128308 0.9628213 0.26983407 0.066883296 0.96097678 0.26842168 0.028672595
		 0.96100867 0.27502772 -0.067633606 0.95426989 0.29119489 0.0041862 0.950845 0.30963892
		 0.17125651 0.93788022 0.30174807 0.22708164 0.93082535 0.28635314 0.2123733 0.93688929
		 0.27773383 0.1646769 0.95021331 0.26453018 0.1621457 0.95578796 0.24531242 0.20010501
		 0.95287812 0.2279942 0.0053936602 0.99995732 0.0074965623 0.0013339705 0.99999434
		 0.0030950038 0.017863261 0.99952871 0.024961621 0.035918225 0.99694437 0.069368429
		 -0.0022851985 0.99063456 0.13652103 -0.093573555 0.97455019 0.20370515 -0.073047005
		 0.96545213 0.25013262 -0.0026358652 0.96363914 0.26719412 -0.0023165883 0.96560109
		 0.26001784 -0.0090405056 0.96959722 0.24453931 0.0067982669 0.97267693 0.2320632
		 0.11373683 0.96928072 0.21808007 0.06557069 0.97682267 0.20375954 -0.093183868 0.97777867
		 0.18779132 -0.19561745 0.96557909 0.17143759 -0.24655433 0.95565355 0.16105074 -0.15434854
		 0.97268915 0.17335594 -0.061343823 0.97714239 0.20354298 -0.0059671872 0.97194248
		 0.23514296 0.042533666 0.96524364 0.2578674 0.11354477 0.95590681 0.27083161 0.21287727
		 0.93928063 0.26913771 0.18290083 0.94824094 0.25958887 0.085801572 0.96333134 0.25422594
		 0.057636593 0.96574968 0.25299326 0.029389177 0.96878004 0.24617387 -0.085594334
		 0.9668563 0.24054623 -0.14893527 0.95805943 0.24482733 -0.076613054 0.96292192 0.25867313
		 -0.03900896 0.96272248 0.26766357 -0.038945045 0.96077514 0.2745806 -0.047670383
		 0.95738924 0.28483909 -0.016401539 0.95348769 0.30098543 0.065068364 0.95112908 0.30186027
		 -0.043486744 0.96069717 0.27417129 -0.1949525 0.95080668 0.24074934 -0.14017275 0.96296889
		 0.23030962 -0.070424519 0.97468728 0.21219181 -0.045540214 0.98235309 0.18140705
		 -0.028736817 0.98804957 0.15143368 0.024789069 0.99238783 0.1206321 0.064190783 0.9918533
		 0.1100296 0.017086789 0.99154794 0.12861054 -0.085804813 0.98525345 0.14803132 0.0076892856
		 0.98853397 0.15080225 0.1918965 0.96947831 0.15260251 0.22934656 0.95823979 0.17081185
		 0.21821959 0.95649618 0.19363722 0.18827462 0.96525365 0.18121289 0.20803136 0.96808177
		 0.13978787 0.25922111 0.9603073 0.10302559 -0.00014442124 0.99999911 0.0013593325
		 -0.0037347223 0.99998939 -0.0027210715 0.005084285 0.99994445 0.0092336731 0.010230738
		 0.99971008 0.021796983 -0.029028736 0.99900377 0.033894714 -0.12244141 0.9912861
		 0.04857986 -0.095148414 0.99275434 0.07338652 -0.0068234927 0.9957037 0.092345178
		 -0.0010337034 0.99500096 0.099860042 -0.0070592626 0.99433714 0.10603681 0.0076011457
		 0.9938314 0.11064091 0.11906404 0.98635912 0.11366325 0.071876101 0.99080431 0.11463328
		 -0.080758922 0.99215555 0.095422663 -0.17907956 0.98217738 0.057081271 -0.24394718
		 0.96951771 0.0229173;
	setAttr ".n[2158:2323]" -type "float3"  -0.16747944 0.98573548 0.016615618 -0.086308002
		 0.99532241 0.043406509 -0.02367991 0.9967947 0.076416582 0.035447154 0.99495304 0.093872488
		 0.11374281 0.98845977 0.10004909 0.22142252 0.96945238 0.10551823 0.1864492 0.9752627
		 0.11874095 0.080640696 0.98722553 0.13741446 0.058098853 0.98648757 0.15318866 0.033793285
		 0.9868086 0.1583252 -0.080155902 0.98507863 0.15229918 -0.15501797 0.97770214 0.14166126
		 -0.086518489 0.98547012 0.14616136 -0.041784331 0.9875021 0.15196586 -0.045059584
		 0.98705965 0.15389235 -0.053993572 0.98632026 0.15574695 -0.026667384 0.98718596
		 0.1573296 0.075502306 0.98523611 0.15365358 -0.0074506877 0.99265558 0.12074573 -0.17472525
		 0.98310107 0.054619756 -0.12881951 0.99166548 0.0022898305 -0.051233619 0.99799347
		 -0.037203196 -0.023047995 0.99647039 -0.080719009 -0.0043886267 0.99129045 -0.13162103
		 0.050439134 0.98163241 -0.18399376 0.057212502 0.97700107 -0.20541583 0.0023222636
		 0.98074293 -0.19528876 -0.098978743 0.97774309 -0.18499087 -0.0025682473 0.98634976
		 -0.16464342 0.17798886 0.97875482 -0.10177902 0.20076068 0.97939909 -0.021734687
		 0.21361722 0.97649646 0.028676774 0.21413603 0.97645956 0.02593144 0.25959769 0.96570349
		 -0.0050956346 0.32653418 0.94462574 -0.032523405 -0.010998186 0.9998675 -0.012004252
		 -0.022889409 0.99939108 -0.026331222 0.00064221845 0.9999969 0.0024078414 0.0030148339
		 0.9999693 0.0072295847 -0.031058492 0.99947506 0.0092151938 -0.13311663 0.991 0.01410451
		 -0.11393624 0.99290597 0.034005906 -0.014866664 0.99835104 0.055444784 -0.0054262299
		 0.99777985 0.066376343 -0.011619944 0.99722046 0.073595062 0.0057891645 0.99691188
		 0.078315772 0.11780591 0.98995662 0.078152061 0.07570187 0.99449873 0.072398312 -0.066241704
		 0.99598652 0.060190279 -0.16120012 0.98590463 0.044796344 -0.22806527 0.97337067
		 0.023147769 -0.16598989 0.98612577 0.0018594163 -0.09945932 0.99501681 -0.0070282193
		 -0.02767276 0.99950099 -0.01522666 0.039954893 0.99868852 -0.03201497 0.11437196
		 0.99254012 -0.042226568 0.21231198 0.97677565 -0.028860167 0.17297274 0.98492664
		 -0.00029805434 0.068652667 0.99734384 0.024337826 0.051399879 0.99782759 0.041208688
		 0.031274769 0.99804425 0.054125533 -0.068392023 0.99641222 0.04985182 -0.15303902
		 0.98750299 0.037641536 -0.096191123 0.99440849 0.043578427 -0.039207794 0.99809945
		 0.047541045 -0.042139195 0.99848342 0.035427071 -0.049823292 0.99855858 0.019962234
		 -0.026884746 0.99959654 0.0091654481 0.082787268 0.99656683 0.00087866408 0.037233882
		 0.99852699 -0.039463654 -0.12397823 0.98524767 -0.11796754 -0.10486317 0.9791345
		 -0.17406704 -0.03269583 0.97953212 -0.1986144 0.0061423024 0.97357941 -0.22826561
		 0.036681738 0.9593156 -0.27994293 0.081899039 0.94041854 -0.33000848 0.0483074 0.93704933
		 -0.34583932 0.0018634429 0.93688959 -0.34962043 -0.092554912 0.92656428 -0.36457115
		 -0.059101056 0.94110459 -0.33291012 0.09424872 0.9760114 -0.19626243 0.13583347 0.98952967
		 -0.048788451 0.20347886 0.97902489 0.010322338 0.24440347 0.96961087 -0.011034409
		 0.31398335 0.94721919 -0.064730845 0.38974431 0.91510874 -0.10332203 -0.046615072
		 0.99764597 -0.050295182 -0.085675128 0.99211788 -0.09144409 -0.00375467 0.99998319
		 -0.0044140755 0.00045480076 0.99999923 0.0011883834 -0.025328912 0.99966413 -0.0054666698
		 -0.13647012 0.99055433 -0.01334219 -0.13239132 0.99119759 -0.0001790798 -0.024923485
		 0.99946749 0.02106127 -0.010505456 0.99940372 0.032890934 -0.017986361 0.99890321
		 0.043230988 0.0038104935 0.99869198 0.050989021 0.1212536 0.9914726 0.047743596 0.079057567
		 0.99599218 0.041827392 -0.069814898 0.99624014 0.051297344 -0.16069724 0.98475063
		 0.066653118 -0.20603393 0.97718138 0.051639434 -0.14181937 0.98988199 0.0045776558
		 -0.087893903 0.99521041 -0.042790376 -0.013289507 0.99701434 -0.076064378 0.05858925
		 0.99250221 -0.10726891 0.11431729 0.98589516 -0.12223795 0.18440592 0.97876471 -0.089521959
		 0.14226359 0.98948771 -0.025984941 0.050722718 0.99838686 0.025512636 0.039261695
		 0.99779117 0.053582642 0.024840912 0.99736226 0.068202406 -0.051608603 0.99701428
		 0.057438258 -0.14594144 0.98871648 0.033776071 -0.10554403 0.99390537 0.031819586
		 -0.031069014 0.99904734 0.030648429 -0.027079685 0.99959588 0.0086520603 -0.032890879
		 0.99918914 -0.023220738 -0.011835734 0.99820429 -0.058719777 0.1022189 0.99003661
		 -0.096844427 0.083887741 0.98515379 -0.14978278 -0.059318382 0.97175092 -0.22843295
		 -0.069757909 0.94966871 -0.30539033 -0.020297719 0.93764251 -0.34700775 0.030513793
		 0.92763883 -0.37222981 0.074451193 0.90978515 -0.40834773 0.09396591 0.89930272 -0.42711228
		 0.033144623 0.91025299 -0.41272387 0.001505542 0.92140251 -0.38860658 -0.082334511
		 0.92267603 -0.37668261 -0.12734687 0.92982602 -0.34526256 -0.024585364 0.97106373
		 -0.2375513 0.069229282 0.99088579 -0.11555383 0.20134021 0.97647846 -0.077148534
		 0.28217918 0.9535234 -0.10567921 0.35093638 0.92577618 -0.14064924 0.40088969 0.90421158
		 -0.14727101 -0.10708357 0.98925179 -0.099568941 -0.17285091 0.9736858 -0.14852133
		 -0.022189111 0.99939096 -0.026934259 -0.0015274048 0.99999666 -0.0020766077 -0.015422326
		 0.99985468 -0.0072742151 -0.13267545 0.99097419 -0.0191656 -0.14528595 0.98922789
		 -0.017891929 -0.03409319 0.9994002 -0.0060807653 -0.015708456 0.99986982 0.0036859908
		 -0.025944008 0.99957454 0.013330004 0.0069348942 0.99989748 0.012521937 0.13934281
		 0.99011868 -0.015765226 0.082476482 0.99570429 -0.042080075 -0.094966874 0.99529654
		 -0.019131145 -0.17505114 0.98431659 0.021863835 -0.18397167 0.98261356 0.025001382
		 -0.10162959 0.99465239 -0.018385977 -0.054951303 0.99494666 -0.084032357 0.017320767
		 0.98875719 -0.14852357 0.085963935 0.97532815 -0.20333503 0.10520878 0.97116846 -0.21392307
		 0.13067344 0.9807719 -0.14495201 0.089481153 0.99521911 -0.039140433 0.023988614
		 0.99911594 0.034523938 0.025763985 0.99749219 0.065920889 0.023219546 0.99701452
		 0.073640451 -0.027422372 0.9982785 0.051847477 -0.13089423 0.99124444 0.017355781
		 -0.10940746 0.99399 0.0037358971;
	setAttr ".n[2324:2489]" -type "float3"  -0.018129671 0.99980873 -0.0073368256
		 -0.0046028169 0.99926162 -0.038144812 -0.0035904059 0.99644512 -0.084167257 0.023551051
		 0.98914772 -0.14502405 0.1414177 0.96658206 -0.21382228 0.11767224 0.95477915 -0.2730383
		 -0.01051324 0.9496007 -0.31328589 -0.019317957 0.92974323 -0.36770147 0.0014096794
		 0.90639174 -0.4224357 0.047956627 0.8916502 -0.45017788 0.089684777 0.88491774 -0.45703101
		 0.077092603 0.89587724 -0.43756235 0.017404836 0.9101932 -0.41381779 -0.014822097
		 0.91737908 -0.3977384 -0.10497788 0.93182945 -0.34738097 -0.16839786 0.94583243 -0.27756625
		 -0.088623703 0.96673703 -0.23992777 0.037420217 0.97433722 -0.22196147 0.204302 0.95324969
		 -0.22265586 0.30339223 0.9224422 -0.23885866 0.32718608 0.9232294 -0.20148647 0.34245887
		 0.92681962 -0.15403773 -0.15607384 0.97201234 -0.17559324 -0.17584743 0.96429008
		 -0.19804606 -0.078611292 0.99241251 -0.094539203 -0.013161379 0.9997071 -0.020309474
		 -0.0088222641 0.99992913 -0.0079910988 -0.1224039 0.99224746 -0.021501467 -0.14758213
		 0.98845595 -0.034270719 -0.041818667 0.9986431 -0.031032793 -0.01751247 0.99949735
		 -0.026426099 -0.025618007 0.99911815 -0.033267662 0.024527179 0.99791265 -0.059739314
		 0.16085631 0.98284334 -0.090245128 0.079699703 0.99190503 -0.098855585 -0.11497321
		 0.98907775 -0.092230208 -0.20014802 0.97778785 -0.062223513 -0.18265824 0.98277605
		 -0.028059376 -0.068012521 0.99718785 -0.031476595 -0.0086657908 0.99658233 -0.082150877
		 0.069950208 0.98439556 -0.16146889 0.11222395 0.96921468 -0.21915433 0.087418288
		 0.97111607 -0.22201721 0.060319759 0.98505735 -0.16131784 0.021172365 0.99819946
		 -0.056119818 -0.0014650462 0.99989343 0.014527853 0.017964512 0.99935371 0.031136258
		 0.029096773 0.99926251 0.025055697 -0.0026417593 0.99999583 0.0011891936 -0.11378288
		 0.99311882 -0.027724404 -0.10615521 0.99336493 -0.044242147 -0.0024245821 0.99814755
		 -0.060790047 0.018670062 0.99584913 -0.089083649 0.027127445 0.99177116 -0.12511705
		 0.058518391 0.98526239 -0.16072823 0.17857412 0.96606171 -0.18664429 0.13415296 0.96923339
		 -0.20637253 0.01869018 0.97030318 -0.24116886 0.034757748 0.95072258 -0.30808854
		 0.035071362 0.92709476 -0.37318265 0.05668056 0.91530198 -0.39876008 0.080096118
		 0.91983211 -0.38404888 0.056464002 0.93084079 -0.36103651 0.0042084102 0.93878794
		 -0.34447002 -0.036560938 0.9480409 -0.31604072 -0.14359428 0.95228052 -0.26933721
		 -0.19797593 0.95383215 -0.22585358 -0.093259148 0.97084957 -0.22080293 0.046834249
		 0.96613389 -0.2537553 0.21690372 0.93296283 -0.28728566 0.29442808 0.91446894 -0.27759442
		 0.24721853 0.95148569 -0.18318851 0.21732078 0.96989685 -0.10987163 -0.1495561 0.93887812
		 -0.31006575 -0.091953926 0.95370847 -0.28632978 -0.16124305 0.94948435 -0.26922128
		 -0.073108405 0.98794323 -0.13646744 -0.019523688 0.99873644 -0.046307925 -0.10351721
		 0.99361986 -0.044762734 -0.13651465 0.98781663 -0.074713647 -0.045094356 0.99493378
		 -0.089850895 -0.0074392888 0.99454403 -0.10405158 -0.011754788 0.99131083 -0.13101402
		 0.040973295 0.98831189 -0.14683558 0.14804313 0.98212922 -0.11621315 0.073881336
		 0.99448442 -0.074446172 -0.095000483 0.99059039 -0.098516196 -0.21837632 0.96777612
		 -0.12538385 -0.20016681 0.97422326 -0.10403034 -0.056956306 0.99426413 -0.090525016
		 0.030254349 0.99291694 -0.11489409 0.10812312 0.98305309 -0.14804022 0.1071397 0.98504269
		 -0.1349515 0.087079227 0.98799241 -0.12762587 0.040119357 0.98648036 -0.15889275
		 -0.038772233 0.98908013 -0.14218752 -0.030248078 0.99569505 -0.087615892 0.020080298
		 0.99743956 -0.068637721 0.038651045 0.99590456 -0.081732161 0.01146883 0.99547923
		 -0.09428452 -0.10525717 0.98944068 -0.099639416 -0.10474808 0.98969358 -0.097645335
		 0.0068159872 0.99525118 -0.097101197 0.030418348 0.9945671 -0.099554278 0.037401937
		 0.99482167 -0.094502926 0.059730332 0.99562007 -0.071923703 0.17637694 0.9836061
		 -0.037551861 0.14867149 0.98832184 -0.033417862 0.070272259 0.99224639 -0.10251273
		 0.092665143 0.97558451 -0.1991182 0.062621906 0.96601248 -0.2507956 0.059675019 0.96306163
		 -0.2625857 0.068196319 0.96340764 -0.25921968 0.060422614 0.96111161 -0.26946929
		 -0.022380097 0.96572173 -0.25861254 -0.083477207 0.97832501 -0.18950361 -0.14166737
		 0.97503483 -0.17098953 -0.18708046 0.95451546 -0.23216628 -0.087265857 0.95996803
		 -0.26616892 0.071652733 0.95615041 -0.28397578 0.22304673 0.92959613 -0.29342976
		 0.24808075 0.93920332 -0.23738831 0.15520678 0.98034292 -0.12181419 0.10841844 0.99235028
		 -0.059046727 -0.089107335 0.96260619 -0.25583062 -0.027481116 0.98044908 -0.19484441
		 -0.17532147 0.91893351 -0.35330385 -0.15692833 0.92852682 -0.33646914 -0.075864248
		 0.97269076 -0.21935669 -0.089139029 0.98351496 -0.15732929 -0.1090138 0.97622788
		 -0.18733655 -0.037589021 0.97364146 -0.2249652 0.0047536348 0.97043467 -0.24131751
		 -0.013140887 0.97355026 -0.22809482 0.021602849 0.98394018 -0.17718661 0.097415507
		 0.99035126 -0.0985635 0.05591308 0.99778777 -0.035962682 -0.046514608 0.99717331
		 -0.059006922 -0.19420421 0.9712885 -0.13741621 -0.19767641 0.96033466 -0.19667584
		 -0.050413318 0.97215861 -0.22883642 0.034793269 0.97297239 -0.22828557 0.08293847
		 0.98187774 -0.17040335 0.076045275 0.9924534 -0.096194975 0.12624684 0.98535377 -0.11462818
		 0.10976374 0.96242547 -0.24837288 -0.050991554 0.93751299 -0.34419361 -0.074062817
		 0.94599628 -0.31560385 0.0062512388 0.96670085 -0.25583279 0.030682759 0.97765154
		 -0.20798108 0.0077008456 0.98463082 -0.17447841 -0.10931873 0.98267376 -0.14967188
		 -0.11547854 0.98564953 -0.12312485 0.00011965119 0.99551576 -0.094594553 0.023307873
		 0.99746978 -0.067162052 0.025136188 0.9988693 -0.040352594 0.04584267 0.99873185
		 -0.02080697 0.16778277 0.98566705 -0.017590364 0.17560354 0.98313403 -0.051096838
		 0.12363038 0.98563337 -0.11507496 0.12384938 0.97967124 -0.15781535 0.078361087 0.98069263
		 -0.17916903 0.064461887 0.97843373 -0.19624516 0.061573818 0.97883201 -0.19518356
		 0.0616454 0.9827646 -0.17428011 -0.047181983 0.98729056 -0.15176022;
	setAttr ".n[2490:2600]" -type "float3"  -0.12392952 0.98332453 -0.13309474 -0.10601445
		 0.9834699 -0.14679173 -0.12565209 0.96454895 -0.2320707 -0.069241576 0.94515944 -0.31918514
		 0.079856724 0.93474096 -0.34623992 0.1919027 0.9331224 -0.30406567 0.17259666 0.96492803
		 -0.19779839 0.082075037 0.99304599 -0.084400646 0.044165883 0.99830335 -0.03794232
		 -0.023088802 0.99811393 -0.056881696 -0.0052875895 0.99973363 -0.022464221 -0.090781763
		 0.97909421 -0.18202551 -0.15507577 0.93179721 -0.32818502 -0.12940328 0.91799951
		 -0.37487549 -0.090120688 0.9322409 -0.35043588 -0.08509282 0.93361938 -0.34801438
		 -0.040113483 0.93898255 -0.3416177 -0.0072082765 0.95178384 -0.30668473 -0.046065614
		 0.96659291 -0.25214285 -0.023655107 0.98265904 -0.18390696 0.039709341 0.99354064
		 -0.10630215 0.027989479 0.99895591 -0.036106277 -0.0084264074 0.99960488 -0.026815848
		 -0.13141812 0.98647863 -0.097924553 -0.15085907 0.96547073 -0.21238618 -0.029572088
		 0.95318383 -0.30094206 -0.00012411474 0.95827812 -0.28583729 0.016244486 0.98325133
		 -0.18152949 0.056530982 0.99183685 -0.1142971 0.18961956 0.96797264 -0.16454025 0.19463672
		 0.94612521 -0.25877348 -0.016340397 0.94220155 -0.33464804 -0.10054474 0.91831893
		 -0.38285926 -0.04024956 0.93478882 -0.35291639 -0.0071040397 0.96437645 -0.26443815
		 -0.011014415 0.98134369 -0.19194597 -0.11840985 0.98120141 -0.15239042 -0.13409948
		 0.9839384 -0.11782363 -0.016904421 0.99713051 -0.073789261 0.008977131 0.99933082
		 -0.03545814 0.014441809 0.99975896 -0.016534625 0.04745404 0.99863726 -0.021719808
		 0.18147857 0.98212153 -0.05002965 0.2148736 0.97129363 -0.10206871 0.1539827 0.97683311
		 -0.14861479 0.13026468 0.97820419 -0.16170216 0.092255376 0.98067445 -0.17253003
		 0.063526057 0.98250949 -0.17504165 0.042539775 0.98914659 -0.14063907 0.032948177
		 0.99622405 -0.08032494 -0.039002899 0.99682921 -0.069355667 -0.11094392 0.98605216
		 -0.12406737 -0.088535629 0.98376334 -0.15611236 -0.059297591 0.97913629 -0.19436063
		 -0.017971467 0.95997804 -0.27949822 0.07755851 0.94361866 -0.32182086 0.12456986
		 0.9575457 -0.25997803 0.086236633 0.98704624 -0.13528855 0.032206293 0.99859142 -0.042164195
		 0.0094615938 0.99985451 -0.014192346 0 1 2.220446e-016 0 1 2.220446e-016 -0.029257583
		 0.99860799 -0.043886378 -0.11520276 0.97025573 -0.21291323 -0.14042263 0.90894675
		 -0.3925525 -0.094598867 0.88987017 -0.44629824 -0.078925677 0.90095508 -0.42667389
		 -0.052507691 0.92628372 -0.37315053 -0.023183856 0.95589709 -0.29278553 -0.068277612
		 0.96837926 -0.23995765 -0.045722947 0.97935462 -0.19691101 0.011751146 0.99211615
		 -0.12476902 0.010190367 0.99879289 -0.048052043 0.0035852252 0.99975562 -0.021814844
		 -0.091460876 0.99360353 -0.066233516 -0.11138493 0.97791594 -0.17684405 -0.011282232
		 0.960163 -0.27921274 -0.027258253 0.96328175 -0.26710567 -0.028615849 0.98455185
		 -0.17273934 0.056858391 0.98865432 -0.13903092 0.23247574 0.95489299 -0.18475524
		 0.22134964 0.96045303 -0.16892114 0.01188909 0.98695546 -0.16055404 -0.094369806
		 0.96292806 -0.25271294 -0.075768523 0.95031184 -0.30193797 -0.041810494 0.97020662
		 -0.23864394 -0.027460638 0.98476565 -0.1717049 -0.11897653 0.98407942 -0.13203099
		 -0.14866942 0.98352981 -0.10279395 -0.028140975 0.99773431 -0.061109729 0.0012665725
		 0.99974221 -0.0226645 0.012239928 0.99985099 -0.012167417 0.0547047 0.99799424 -0.031858545
		 0.1999819 0.97658366 -0.079319656 0.23193724 0.96291041 -0.13787186 0.16191317 0.97074461
		 -0.17731103 0.1300728 0.97336781 -0.18877539 0.099271692 0.97704989 -0.18846442 0.057971042
		 0.98590302 -0.15695445 0.025660403 0.99544227 -0.091848649 0.010755789 0.99927419
		 -0.036542337 -0.024884403 0.99835283 -0.051696345 -0.089059487 0.98755103 -0.12965931
		 -0.088925809 0.98050344 -0.17522879 -0.033451613 0.98154789 -0.1882678 0.015032943
		 0.97051972 -0.24055246 0.076473266 0.95610744 -0.28286099 0.084649831 0.96985185
		 -0.22852094 0.043128006 0.99351728 -0.10518282 0.013547783 0.99970168 -0.020321677
		 0 1 2.220446e-016;
	setAttr -s 2500 -ch 10000 ".fc";
	setAttr ".fc[0:499]" -type "polyFaces" 
		f 4 0 1 2 3
		mu 0 4 0 1 52 51
		f 4 4 5 6 -2
		mu 0 4 1 2 53 52
		f 4 7 8 9 -6
		mu 0 4 2 3 54 53
		f 4 10 11 12 -9
		mu 0 4 3 4 55 54
		f 4 13 14 15 -12
		mu 0 4 4 5 56 55
		f 4 16 17 18 -15
		mu 0 4 5 6 57 56
		f 4 19 20 21 -18
		mu 0 4 6 7 58 57
		f 4 22 23 24 -21
		mu 0 4 7 8 59 58
		f 4 25 26 27 -24
		mu 0 4 8 9 60 59
		f 4 28 29 30 -27
		mu 0 4 9 10 61 60
		f 4 31 32 33 -30
		mu 0 4 10 11 62 61
		f 4 34 35 36 -33
		mu 0 4 11 12 63 62
		f 4 37 38 39 -36
		mu 0 4 12 13 64 63
		f 4 40 41 42 -39
		mu 0 4 13 14 65 64
		f 4 43 44 45 -42
		mu 0 4 14 15 66 65
		f 4 46 47 48 -45
		mu 0 4 15 16 67 66
		f 4 49 50 51 -48
		mu 0 4 16 17 68 67
		f 4 52 53 54 -51
		mu 0 4 17 18 69 68
		f 4 55 56 57 -54
		mu 0 4 18 19 70 69
		f 4 58 59 60 -57
		mu 0 4 19 20 71 70
		f 4 61 62 63 -60
		mu 0 4 20 21 72 71
		f 4 64 65 66 -63
		mu 0 4 21 22 73 72
		f 4 67 68 69 -66
		mu 0 4 22 23 74 73
		f 4 70 71 72 -69
		mu 0 4 23 24 75 74
		f 4 73 74 75 -72
		mu 0 4 24 25 76 75
		f 4 76 77 78 -75
		mu 0 4 25 26 77 76
		f 4 79 80 81 -78
		mu 0 4 26 27 78 77
		f 4 82 83 84 -81
		mu 0 4 27 28 79 78
		f 4 85 86 87 -84
		mu 0 4 28 29 80 79
		f 4 88 89 90 -87
		mu 0 4 29 30 81 80
		f 4 91 92 93 -90
		mu 0 4 30 31 82 81
		f 4 94 95 96 -93
		mu 0 4 31 32 83 82
		f 4 97 98 99 -96
		mu 0 4 32 33 84 83
		f 4 100 101 102 -99
		mu 0 4 33 34 85 84
		f 4 103 104 105 -102
		mu 0 4 34 35 86 85
		f 4 106 107 108 -105
		mu 0 4 35 36 87 86
		f 4 109 110 111 -108
		mu 0 4 36 37 88 87
		f 4 112 113 114 -111
		mu 0 4 37 38 89 88
		f 4 115 116 117 -114
		mu 0 4 38 39 90 89
		f 4 118 119 120 -117
		mu 0 4 39 40 91 90
		f 4 121 122 123 -120
		mu 0 4 40 41 92 91
		f 4 124 125 126 -123
		mu 0 4 41 42 93 92
		f 4 127 128 129 -126
		mu 0 4 42 43 94 93
		f 4 130 131 132 -129
		mu 0 4 43 44 95 94
		f 4 133 134 135 -132
		mu 0 4 44 45 96 95
		f 4 136 137 138 -135
		mu 0 4 45 46 97 96
		f 4 139 140 141 -138
		mu 0 4 46 47 98 97
		f 4 142 143 144 -141
		mu 0 4 47 48 99 98
		f 4 145 146 147 -144
		mu 0 4 48 49 100 99
		f 4 148 149 150 -147
		mu 0 4 49 50 101 100
		f 4 -3 151 152 153
		mu 0 4 51 52 103 102
		f 4 -7 154 155 -152
		mu 0 4 52 53 104 103
		f 4 -10 156 157 -155
		mu 0 4 53 54 105 104
		f 4 -13 158 159 -157
		mu 0 4 54 55 106 105
		f 4 -16 160 161 -159
		mu 0 4 55 56 107 106
		f 4 -19 162 163 -161
		mu 0 4 56 57 108 107
		f 4 -22 164 165 -163
		mu 0 4 57 58 109 108
		f 4 -25 166 167 -165
		mu 0 4 58 59 110 109
		f 4 -28 168 169 -167
		mu 0 4 59 60 111 110
		f 4 -31 170 171 -169
		mu 0 4 60 61 112 111
		f 4 -34 172 173 -171
		mu 0 4 61 62 113 112
		f 4 -37 174 175 -173
		mu 0 4 62 63 114 113
		f 4 -40 176 177 -175
		mu 0 4 63 64 115 114
		f 4 -43 178 179 -177
		mu 0 4 64 65 116 115
		f 4 -46 180 181 -179
		mu 0 4 65 66 117 116
		f 4 -49 182 183 -181
		mu 0 4 66 67 118 117
		f 4 -52 184 185 -183
		mu 0 4 67 68 119 118
		f 4 -55 186 187 -185
		mu 0 4 68 69 120 119
		f 4 -58 188 189 -187
		mu 0 4 69 70 121 120
		f 4 -61 190 191 -189
		mu 0 4 70 71 122 121
		f 4 -64 192 193 -191
		mu 0 4 71 72 123 122
		f 4 -67 194 195 -193
		mu 0 4 72 73 124 123
		f 4 -70 196 197 -195
		mu 0 4 73 74 125 124
		f 4 -73 198 199 -197
		mu 0 4 74 75 126 125
		f 4 -76 200 201 -199
		mu 0 4 75 76 127 126
		f 4 -79 202 203 -201
		mu 0 4 76 77 128 127
		f 4 -82 204 205 -203
		mu 0 4 77 78 129 128
		f 4 -85 206 207 -205
		mu 0 4 78 79 130 129
		f 4 -88 208 209 -207
		mu 0 4 79 80 131 130
		f 4 -91 210 211 -209
		mu 0 4 80 81 132 131
		f 4 -94 212 213 -211
		mu 0 4 81 82 133 132
		f 4 -97 214 215 -213
		mu 0 4 82 83 134 133
		f 4 -100 216 217 -215
		mu 0 4 83 84 135 134
		f 4 -103 218 219 -217
		mu 0 4 84 85 136 135
		f 4 -106 220 221 -219
		mu 0 4 85 86 137 136
		f 4 -109 222 223 -221
		mu 0 4 86 87 138 137
		f 4 -112 224 225 -223
		mu 0 4 87 88 139 138
		f 4 -115 226 227 -225
		mu 0 4 88 89 140 139
		f 4 -118 228 229 -227
		mu 0 4 89 90 141 140
		f 4 -121 230 231 -229
		mu 0 4 90 91 142 141
		f 4 -124 232 233 -231
		mu 0 4 91 92 143 142
		f 4 -127 234 235 -233
		mu 0 4 92 93 144 143
		f 4 -130 236 237 -235
		mu 0 4 93 94 145 144
		f 4 -133 238 239 -237
		mu 0 4 94 95 146 145
		f 4 -136 240 241 -239
		mu 0 4 95 96 147 146
		f 4 -139 242 243 -241
		mu 0 4 96 97 148 147
		f 4 -142 244 245 -243
		mu 0 4 97 98 149 148
		f 4 -145 246 247 -245
		mu 0 4 98 99 150 149
		f 4 -148 248 249 -247
		mu 0 4 99 100 151 150
		f 4 -151 250 251 -249
		mu 0 4 100 101 152 151
		f 4 -153 252 253 254
		mu 0 4 102 103 154 153
		f 4 -156 255 256 -253
		mu 0 4 103 104 155 154
		f 4 -158 257 258 -256
		mu 0 4 104 105 156 155
		f 4 -160 259 260 -258
		mu 0 4 105 106 157 156
		f 4 -162 261 262 -260
		mu 0 4 106 107 158 157
		f 4 -164 263 264 -262
		mu 0 4 107 108 159 158
		f 4 -166 265 266 -264
		mu 0 4 108 109 160 159
		f 4 -168 267 268 -266
		mu 0 4 109 110 161 160
		f 4 -170 269 270 -268
		mu 0 4 110 111 162 161
		f 4 -172 271 272 -270
		mu 0 4 111 112 163 162
		f 4 -174 273 274 -272
		mu 0 4 112 113 164 163
		f 4 -176 275 276 -274
		mu 0 4 113 114 165 164
		f 4 -178 277 278 -276
		mu 0 4 114 115 166 165
		f 4 -180 279 280 -278
		mu 0 4 115 116 167 166
		f 4 -182 281 282 -280
		mu 0 4 116 117 168 167
		f 4 -184 283 284 -282
		mu 0 4 117 118 169 168
		f 4 -186 285 286 -284
		mu 0 4 118 119 170 169
		f 4 -188 287 288 -286
		mu 0 4 119 120 171 170
		f 4 -190 289 290 -288
		mu 0 4 120 121 172 171
		f 4 -192 291 292 -290
		mu 0 4 121 122 173 172
		f 4 -194 293 294 -292
		mu 0 4 122 123 174 173
		f 4 -196 295 296 -294
		mu 0 4 123 124 175 174
		f 4 -198 297 298 -296
		mu 0 4 124 125 176 175
		f 4 -200 299 300 -298
		mu 0 4 125 126 177 176
		f 4 -202 301 302 -300
		mu 0 4 126 127 178 177
		f 4 -204 303 304 -302
		mu 0 4 127 128 179 178
		f 4 -206 305 306 -304
		mu 0 4 128 129 180 179
		f 4 -208 307 308 -306
		mu 0 4 129 130 181 180
		f 4 -210 309 310 -308
		mu 0 4 130 131 182 181
		f 4 -212 311 312 -310
		mu 0 4 131 132 183 182
		f 4 -214 313 314 -312
		mu 0 4 132 133 184 183
		f 4 -216 315 316 -314
		mu 0 4 133 134 185 184
		f 4 -218 317 318 -316
		mu 0 4 134 135 186 185
		f 4 -220 319 320 -318
		mu 0 4 135 136 187 186
		f 4 -222 321 322 -320
		mu 0 4 136 137 188 187
		f 4 -224 323 324 -322
		mu 0 4 137 138 189 188
		f 4 -226 325 326 -324
		mu 0 4 138 139 190 189
		f 4 -228 327 328 -326
		mu 0 4 139 140 191 190
		f 4 -230 329 330 -328
		mu 0 4 140 141 192 191
		f 4 -232 331 332 -330
		mu 0 4 141 142 193 192
		f 4 -234 333 334 -332
		mu 0 4 142 143 194 193
		f 4 -236 335 336 -334
		mu 0 4 143 144 195 194
		f 4 -238 337 338 -336
		mu 0 4 144 145 196 195
		f 4 -240 339 340 -338
		mu 0 4 145 146 197 196
		f 4 -242 341 342 -340
		mu 0 4 146 147 198 197
		f 4 -244 343 344 -342
		mu 0 4 147 148 199 198
		f 4 -246 345 346 -344
		mu 0 4 148 149 200 199
		f 4 -248 347 348 -346
		mu 0 4 149 150 201 200
		f 4 -250 349 350 -348
		mu 0 4 150 151 202 201
		f 4 -252 351 352 -350
		mu 0 4 151 152 203 202
		f 4 -254 353 354 355
		mu 0 4 153 154 205 204
		f 4 -257 356 357 -354
		mu 0 4 154 155 206 205
		f 4 -259 358 359 -357
		mu 0 4 155 156 207 206
		f 4 -261 360 361 -359
		mu 0 4 156 157 208 207
		f 4 -263 362 363 -361
		mu 0 4 157 158 209 208
		f 4 -265 364 365 -363
		mu 0 4 158 159 210 209
		f 4 -267 366 367 -365
		mu 0 4 159 160 211 210
		f 4 -269 368 369 -367
		mu 0 4 160 161 212 211
		f 4 -271 370 371 -369
		mu 0 4 161 162 213 212
		f 4 -273 372 373 -371
		mu 0 4 162 163 214 213
		f 4 -275 374 375 -373
		mu 0 4 163 164 215 214
		f 4 -277 376 377 -375
		mu 0 4 164 165 216 215
		f 4 -279 378 379 -377
		mu 0 4 165 166 217 216
		f 4 -281 380 381 -379
		mu 0 4 166 167 218 217
		f 4 -283 382 383 -381
		mu 0 4 167 168 219 218
		f 4 -285 384 385 -383
		mu 0 4 168 169 220 219
		f 4 -287 386 387 -385
		mu 0 4 169 170 221 220
		f 4 -289 388 389 -387
		mu 0 4 170 171 222 221
		f 4 -291 390 391 -389
		mu 0 4 171 172 223 222
		f 4 -293 392 393 -391
		mu 0 4 172 173 224 223
		f 4 -295 394 395 -393
		mu 0 4 173 174 225 224
		f 4 -297 396 397 -395
		mu 0 4 174 175 226 225
		f 4 -299 398 399 -397
		mu 0 4 175 176 227 226
		f 4 -301 400 401 -399
		mu 0 4 176 177 228 227
		f 4 -303 402 403 -401
		mu 0 4 177 178 229 228
		f 4 -305 404 405 -403
		mu 0 4 178 179 230 229
		f 4 -307 406 407 -405
		mu 0 4 179 180 231 230
		f 4 -309 408 409 -407
		mu 0 4 180 181 232 231
		f 4 -311 410 411 -409
		mu 0 4 181 182 233 232
		f 4 -313 412 413 -411
		mu 0 4 182 183 234 233
		f 4 -315 414 415 -413
		mu 0 4 183 184 235 234
		f 4 -317 416 417 -415
		mu 0 4 184 185 236 235
		f 4 -319 418 419 -417
		mu 0 4 185 186 237 236
		f 4 -321 420 421 -419
		mu 0 4 186 187 238 237
		f 4 -323 422 423 -421
		mu 0 4 187 188 239 238
		f 4 -325 424 425 -423
		mu 0 4 188 189 240 239
		f 4 -327 426 427 -425
		mu 0 4 189 190 241 240
		f 4 -329 428 429 -427
		mu 0 4 190 191 242 241
		f 4 -331 430 431 -429
		mu 0 4 191 192 243 242
		f 4 -333 432 433 -431
		mu 0 4 192 193 244 243
		f 4 -335 434 435 -433
		mu 0 4 193 194 245 244
		f 4 -337 436 437 -435
		mu 0 4 194 195 246 245
		f 4 -339 438 439 -437
		mu 0 4 195 196 247 246
		f 4 -341 440 441 -439
		mu 0 4 196 197 248 247
		f 4 -343 442 443 -441
		mu 0 4 197 198 249 248
		f 4 -345 444 445 -443
		mu 0 4 198 199 250 249
		f 4 -347 446 447 -445
		mu 0 4 199 200 251 250
		f 4 -349 448 449 -447
		mu 0 4 200 201 252 251
		f 4 -351 450 451 -449
		mu 0 4 201 202 253 252
		f 4 -353 452 453 -451
		mu 0 4 202 203 254 253
		f 4 -355 454 455 456
		mu 0 4 204 205 256 255
		f 4 -358 457 458 -455
		mu 0 4 205 206 257 256
		f 4 -360 459 460 -458
		mu 0 4 206 207 258 257
		f 4 -362 461 462 -460
		mu 0 4 207 208 259 258
		f 4 -364 463 464 -462
		mu 0 4 208 209 260 259
		f 4 -366 465 466 -464
		mu 0 4 209 210 261 260
		f 4 -368 467 468 -466
		mu 0 4 210 211 262 261
		f 4 -370 469 470 -468
		mu 0 4 211 212 263 262
		f 4 -372 471 472 -470
		mu 0 4 212 213 264 263
		f 4 -374 473 474 -472
		mu 0 4 213 214 265 264
		f 4 -376 475 476 -474
		mu 0 4 214 215 266 265
		f 4 -378 477 478 -476
		mu 0 4 215 216 267 266
		f 4 -380 479 480 -478
		mu 0 4 216 217 268 267
		f 4 -382 481 482 -480
		mu 0 4 217 218 269 268
		f 4 -384 483 484 -482
		mu 0 4 218 219 270 269
		f 4 -386 485 486 -484
		mu 0 4 219 220 271 270
		f 4 -388 487 488 -486
		mu 0 4 220 221 272 271
		f 4 -390 489 490 -488
		mu 0 4 221 222 273 272
		f 4 -392 491 492 -490
		mu 0 4 222 223 274 273
		f 4 -394 493 494 -492
		mu 0 4 223 224 275 274
		f 4 -396 495 496 -494
		mu 0 4 224 225 276 275
		f 4 -398 497 498 -496
		mu 0 4 225 226 277 276
		f 4 -400 499 500 -498
		mu 0 4 226 227 278 277
		f 4 -402 501 502 -500
		mu 0 4 227 228 279 278
		f 4 -404 503 504 -502
		mu 0 4 228 229 280 279
		f 4 -406 505 506 -504
		mu 0 4 229 230 281 280
		f 4 -408 507 508 -506
		mu 0 4 230 231 282 281
		f 4 -410 509 510 -508
		mu 0 4 231 232 283 282
		f 4 -412 511 512 -510
		mu 0 4 232 233 284 283
		f 4 -414 513 514 -512
		mu 0 4 233 234 285 284
		f 4 -416 515 516 -514
		mu 0 4 234 235 286 285
		f 4 -418 517 518 -516
		mu 0 4 235 236 287 286
		f 4 -420 519 520 -518
		mu 0 4 236 237 288 287
		f 4 -422 521 522 -520
		mu 0 4 237 238 289 288
		f 4 -424 523 524 -522
		mu 0 4 238 239 290 289
		f 4 -426 525 526 -524
		mu 0 4 239 240 291 290
		f 4 -428 527 528 -526
		mu 0 4 240 241 292 291
		f 4 -430 529 530 -528
		mu 0 4 241 242 293 292
		f 4 -432 531 532 -530
		mu 0 4 242 243 294 293
		f 4 -434 533 534 -532
		mu 0 4 243 244 295 294
		f 4 -436 535 536 -534
		mu 0 4 244 245 296 295
		f 4 -438 537 538 -536
		mu 0 4 245 246 297 296
		f 4 -440 539 540 -538
		mu 0 4 246 247 298 297
		f 4 -442 541 542 -540
		mu 0 4 247 248 299 298
		f 4 -444 543 544 -542
		mu 0 4 248 249 300 299
		f 4 -446 545 546 -544
		mu 0 4 249 250 301 300
		f 4 -448 547 548 -546
		mu 0 4 250 251 302 301
		f 4 -450 549 550 -548
		mu 0 4 251 252 303 302
		f 4 -452 551 552 -550
		mu 0 4 252 253 304 303
		f 4 -454 553 554 -552
		mu 0 4 253 254 305 304
		f 4 -456 555 556 557
		mu 0 4 255 256 307 306
		f 4 -459 558 559 -556
		mu 0 4 256 257 308 307
		f 4 -461 560 561 -559
		mu 0 4 257 258 309 308
		f 4 -463 562 563 -561
		mu 0 4 258 259 310 309
		f 4 -465 564 565 -563
		mu 0 4 259 260 311 310
		f 4 -467 566 567 -565
		mu 0 4 260 261 312 311
		f 4 -469 568 569 -567
		mu 0 4 261 262 313 312
		f 4 -471 570 571 -569
		mu 0 4 262 263 314 313
		f 4 -473 572 573 -571
		mu 0 4 263 264 315 314
		f 4 -475 574 575 -573
		mu 0 4 264 265 316 315
		f 4 -477 576 577 -575
		mu 0 4 265 266 317 316
		f 4 -479 578 579 -577
		mu 0 4 266 267 318 317
		f 4 -481 580 581 -579
		mu 0 4 267 268 319 318
		f 4 -483 582 583 -581
		mu 0 4 268 269 320 319
		f 4 -485 584 585 -583
		mu 0 4 269 270 321 320
		f 4 -487 586 587 -585
		mu 0 4 270 271 322 321
		f 4 -489 588 589 -587
		mu 0 4 271 272 323 322
		f 4 -491 590 591 -589
		mu 0 4 272 273 324 323
		f 4 -493 592 593 -591
		mu 0 4 273 274 325 324
		f 4 -495 594 595 -593
		mu 0 4 274 275 326 325
		f 4 -497 596 597 -595
		mu 0 4 275 276 327 326
		f 4 -499 598 599 -597
		mu 0 4 276 277 328 327
		f 4 -501 600 601 -599
		mu 0 4 277 278 329 328
		f 4 -503 602 603 -601
		mu 0 4 278 279 330 329
		f 4 -505 604 605 -603
		mu 0 4 279 280 331 330
		f 4 -507 606 607 -605
		mu 0 4 280 281 332 331
		f 4 -509 608 609 -607
		mu 0 4 281 282 333 332
		f 4 -511 610 611 -609
		mu 0 4 282 283 334 333
		f 4 -513 612 613 -611
		mu 0 4 283 284 335 334
		f 4 -515 614 615 -613
		mu 0 4 284 285 336 335
		f 4 -517 616 617 -615
		mu 0 4 285 286 337 336
		f 4 -519 618 619 -617
		mu 0 4 286 287 338 337
		f 4 -521 620 621 -619
		mu 0 4 287 288 339 338
		f 4 -523 622 623 -621
		mu 0 4 288 289 340 339
		f 4 -525 624 625 -623
		mu 0 4 289 290 341 340
		f 4 -527 626 627 -625
		mu 0 4 290 291 342 341
		f 4 -529 628 629 -627
		mu 0 4 291 292 343 342
		f 4 -531 630 631 -629
		mu 0 4 292 293 344 343
		f 4 -533 632 633 -631
		mu 0 4 293 294 345 344
		f 4 -535 634 635 -633
		mu 0 4 294 295 346 345
		f 4 -537 636 637 -635
		mu 0 4 295 296 347 346
		f 4 -539 638 639 -637
		mu 0 4 296 297 348 347
		f 4 -541 640 641 -639
		mu 0 4 297 298 349 348
		f 4 -543 642 643 -641
		mu 0 4 298 299 350 349
		f 4 -545 644 645 -643
		mu 0 4 299 300 351 350
		f 4 -547 646 647 -645
		mu 0 4 300 301 352 351
		f 4 -549 648 649 -647
		mu 0 4 301 302 353 352
		f 4 -551 650 651 -649
		mu 0 4 302 303 354 353
		f 4 -553 652 653 -651
		mu 0 4 303 304 355 354
		f 4 -555 654 655 -653
		mu 0 4 304 305 356 355
		f 4 -557 656 657 658
		mu 0 4 306 307 358 357
		f 4 -560 659 660 -657
		mu 0 4 307 308 359 358
		f 4 -562 661 662 -660
		mu 0 4 308 309 360 359
		f 4 -564 663 664 -662
		mu 0 4 309 310 361 360
		f 4 -566 665 666 -664
		mu 0 4 310 311 362 361
		f 4 -568 667 668 -666
		mu 0 4 311 312 363 362
		f 4 -570 669 670 -668
		mu 0 4 312 313 364 363
		f 4 -572 671 672 -670
		mu 0 4 313 314 365 364
		f 4 -574 673 674 -672
		mu 0 4 314 315 366 365
		f 4 -576 675 676 -674
		mu 0 4 315 316 367 366
		f 4 -578 677 678 -676
		mu 0 4 316 317 368 367
		f 4 -580 679 680 -678
		mu 0 4 317 318 369 368
		f 4 -582 681 682 -680
		mu 0 4 318 319 370 369
		f 4 -584 683 684 -682
		mu 0 4 319 320 371 370
		f 4 -586 685 686 -684
		mu 0 4 320 321 372 371
		f 4 -588 687 688 -686
		mu 0 4 321 322 373 372
		f 4 -590 689 690 -688
		mu 0 4 322 323 374 373
		f 4 -592 691 692 -690
		mu 0 4 323 324 375 374
		f 4 -594 693 694 -692
		mu 0 4 324 325 376 375
		f 4 -596 695 696 -694
		mu 0 4 325 326 377 376
		f 4 -598 697 698 -696
		mu 0 4 326 327 378 377
		f 4 -600 699 700 -698
		mu 0 4 327 328 379 378
		f 4 -602 701 702 -700
		mu 0 4 328 329 380 379
		f 4 -604 703 704 -702
		mu 0 4 329 330 381 380
		f 4 -606 705 706 -704
		mu 0 4 330 331 382 381
		f 4 -608 707 708 -706
		mu 0 4 331 332 383 382
		f 4 -610 709 710 -708
		mu 0 4 332 333 384 383
		f 4 -612 711 712 -710
		mu 0 4 333 334 385 384
		f 4 -614 713 714 -712
		mu 0 4 334 335 386 385
		f 4 -616 715 716 -714
		mu 0 4 335 336 387 386
		f 4 -618 717 718 -716
		mu 0 4 336 337 388 387
		f 4 -620 719 720 -718
		mu 0 4 337 338 389 388
		f 4 -622 721 722 -720
		mu 0 4 338 339 390 389
		f 4 -624 723 724 -722
		mu 0 4 339 340 391 390
		f 4 -626 725 726 -724
		mu 0 4 340 341 392 391
		f 4 -628 727 728 -726
		mu 0 4 341 342 393 392
		f 4 -630 729 730 -728
		mu 0 4 342 343 394 393
		f 4 -632 731 732 -730
		mu 0 4 343 344 395 394
		f 4 -634 733 734 -732
		mu 0 4 344 345 396 395
		f 4 -636 735 736 -734
		mu 0 4 345 346 397 396
		f 4 -638 737 738 -736
		mu 0 4 346 347 398 397
		f 4 -640 739 740 -738
		mu 0 4 347 348 399 398
		f 4 -642 741 742 -740
		mu 0 4 348 349 400 399
		f 4 -644 743 744 -742
		mu 0 4 349 350 401 400
		f 4 -646 745 746 -744
		mu 0 4 350 351 402 401
		f 4 -648 747 748 -746
		mu 0 4 351 352 403 402
		f 4 -650 749 750 -748
		mu 0 4 352 353 404 403
		f 4 -652 751 752 -750
		mu 0 4 353 354 405 404
		f 4 -654 753 754 -752
		mu 0 4 354 355 406 405
		f 4 -656 755 756 -754
		mu 0 4 355 356 407 406
		f 4 -658 757 758 759
		mu 0 4 357 358 409 408
		f 4 -661 760 761 -758
		mu 0 4 358 359 410 409
		f 4 -663 762 763 -761
		mu 0 4 359 360 411 410
		f 4 -665 764 765 -763
		mu 0 4 360 361 412 411
		f 4 -667 766 767 -765
		mu 0 4 361 362 413 412
		f 4 -669 768 769 -767
		mu 0 4 362 363 414 413
		f 4 -671 770 771 -769
		mu 0 4 363 364 415 414
		f 4 -673 772 773 -771
		mu 0 4 364 365 416 415
		f 4 -675 774 775 -773
		mu 0 4 365 366 417 416
		f 4 -677 776 777 -775
		mu 0 4 366 367 418 417
		f 4 -679 778 779 -777
		mu 0 4 367 368 419 418
		f 4 -681 780 781 -779
		mu 0 4 368 369 420 419
		f 4 -683 782 783 -781
		mu 0 4 369 370 421 420
		f 4 -685 784 785 -783
		mu 0 4 370 371 422 421
		f 4 -687 786 787 -785
		mu 0 4 371 372 423 422
		f 4 -689 788 789 -787
		mu 0 4 372 373 424 423
		f 4 -691 790 791 -789
		mu 0 4 373 374 425 424
		f 4 -693 792 793 -791
		mu 0 4 374 375 426 425
		f 4 -695 794 795 -793
		mu 0 4 375 376 427 426
		f 4 -697 796 797 -795
		mu 0 4 376 377 428 427
		f 4 -699 798 799 -797
		mu 0 4 377 378 429 428
		f 4 -701 800 801 -799
		mu 0 4 378 379 430 429
		f 4 -703 802 803 -801
		mu 0 4 379 380 431 430
		f 4 -705 804 805 -803
		mu 0 4 380 381 432 431
		f 4 -707 806 807 -805
		mu 0 4 381 382 433 432
		f 4 -709 808 809 -807
		mu 0 4 382 383 434 433
		f 4 -711 810 811 -809
		mu 0 4 383 384 435 434
		f 4 -713 812 813 -811
		mu 0 4 384 385 436 435
		f 4 -715 814 815 -813
		mu 0 4 385 386 437 436
		f 4 -717 816 817 -815
		mu 0 4 386 387 438 437
		f 4 -719 818 819 -817
		mu 0 4 387 388 439 438
		f 4 -721 820 821 -819
		mu 0 4 388 389 440 439
		f 4 -723 822 823 -821
		mu 0 4 389 390 441 440
		f 4 -725 824 825 -823
		mu 0 4 390 391 442 441
		f 4 -727 826 827 -825
		mu 0 4 391 392 443 442
		f 4 -729 828 829 -827
		mu 0 4 392 393 444 443
		f 4 -731 830 831 -829
		mu 0 4 393 394 445 444
		f 4 -733 832 833 -831
		mu 0 4 394 395 446 445
		f 4 -735 834 835 -833
		mu 0 4 395 396 447 446
		f 4 -737 836 837 -835
		mu 0 4 396 397 448 447
		f 4 -739 838 839 -837
		mu 0 4 397 398 449 448
		f 4 -741 840 841 -839
		mu 0 4 398 399 450 449
		f 4 -743 842 843 -841
		mu 0 4 399 400 451 450
		f 4 -745 844 845 -843
		mu 0 4 400 401 452 451
		f 4 -747 846 847 -845
		mu 0 4 401 402 453 452
		f 4 -749 848 849 -847
		mu 0 4 402 403 454 453
		f 4 -751 850 851 -849
		mu 0 4 403 404 455 454
		f 4 -753 852 853 -851
		mu 0 4 404 405 456 455
		f 4 -755 854 855 -853
		mu 0 4 405 406 457 456
		f 4 -757 856 857 -855
		mu 0 4 406 407 458 457
		f 4 -759 858 859 860
		mu 0 4 408 409 460 459
		f 4 -762 861 862 -859
		mu 0 4 409 410 461 460
		f 4 -764 863 864 -862
		mu 0 4 410 411 462 461
		f 4 -766 865 866 -864
		mu 0 4 411 412 463 462
		f 4 -768 867 868 -866
		mu 0 4 412 413 464 463
		f 4 -770 869 870 -868
		mu 0 4 413 414 465 464
		f 4 -772 871 872 -870
		mu 0 4 414 415 466 465
		f 4 -774 873 874 -872
		mu 0 4 415 416 467 466
		f 4 -776 875 876 -874
		mu 0 4 416 417 468 467
		f 4 -778 877 878 -876
		mu 0 4 417 418 469 468
		f 4 -780 879 880 -878
		mu 0 4 418 419 470 469
		f 4 -782 881 882 -880
		mu 0 4 419 420 471 470
		f 4 -784 883 884 -882
		mu 0 4 420 421 472 471
		f 4 -786 885 886 -884
		mu 0 4 421 422 473 472
		f 4 -788 887 888 -886
		mu 0 4 422 423 474 473
		f 4 -790 889 890 -888
		mu 0 4 423 424 475 474
		f 4 -792 891 892 -890
		mu 0 4 424 425 476 475
		f 4 -794 893 894 -892
		mu 0 4 425 426 477 476
		f 4 -796 895 896 -894
		mu 0 4 426 427 478 477
		f 4 -798 897 898 -896
		mu 0 4 427 428 479 478
		f 4 -800 899 900 -898
		mu 0 4 428 429 480 479
		f 4 -802 901 902 -900
		mu 0 4 429 430 481 480
		f 4 -804 903 904 -902
		mu 0 4 430 431 482 481
		f 4 -806 905 906 -904
		mu 0 4 431 432 483 482
		f 4 -808 907 908 -906
		mu 0 4 432 433 484 483
		f 4 -810 909 910 -908
		mu 0 4 433 434 485 484
		f 4 -812 911 912 -910
		mu 0 4 434 435 486 485
		f 4 -814 913 914 -912
		mu 0 4 435 436 487 486
		f 4 -816 915 916 -914
		mu 0 4 436 437 488 487
		f 4 -818 917 918 -916
		mu 0 4 437 438 489 488
		f 4 -820 919 920 -918
		mu 0 4 438 439 490 489
		f 4 -822 921 922 -920
		mu 0 4 439 440 491 490
		f 4 -824 923 924 -922
		mu 0 4 440 441 492 491
		f 4 -826 925 926 -924
		mu 0 4 441 442 493 492
		f 4 -828 927 928 -926
		mu 0 4 442 443 494 493
		f 4 -830 929 930 -928
		mu 0 4 443 444 495 494
		f 4 -832 931 932 -930
		mu 0 4 444 445 496 495
		f 4 -834 933 934 -932
		mu 0 4 445 446 497 496
		f 4 -836 935 936 -934
		mu 0 4 446 447 498 497
		f 4 -838 937 938 -936
		mu 0 4 447 448 499 498
		f 4 -840 939 940 -938
		mu 0 4 448 449 500 499
		f 4 -842 941 942 -940
		mu 0 4 449 450 501 500
		f 4 -844 943 944 -942
		mu 0 4 450 451 502 501
		f 4 -846 945 946 -944
		mu 0 4 451 452 503 502
		f 4 -848 947 948 -946
		mu 0 4 452 453 504 503
		f 4 -850 949 950 -948
		mu 0 4 453 454 505 504
		f 4 -852 951 952 -950
		mu 0 4 454 455 506 505
		f 4 -854 953 954 -952
		mu 0 4 455 456 507 506
		f 4 -856 955 956 -954
		mu 0 4 456 457 508 507
		f 4 -858 957 958 -956
		mu 0 4 457 458 509 508
		f 4 -860 959 960 961
		mu 0 4 459 460 511 510
		f 4 -863 962 963 -960
		mu 0 4 460 461 512 511
		f 4 -865 964 965 -963
		mu 0 4 461 462 513 512
		f 4 -867 966 967 -965
		mu 0 4 462 463 514 513
		f 4 -869 968 969 -967
		mu 0 4 463 464 515 514
		f 4 -871 970 971 -969
		mu 0 4 464 465 516 515
		f 4 -873 972 973 -971
		mu 0 4 465 466 517 516
		f 4 -875 974 975 -973
		mu 0 4 466 467 518 517
		f 4 -877 976 977 -975
		mu 0 4 467 468 519 518
		f 4 -879 978 979 -977
		mu 0 4 468 469 520 519
		f 4 -881 980 981 -979
		mu 0 4 469 470 521 520
		f 4 -883 982 983 -981
		mu 0 4 470 471 522 521
		f 4 -885 984 985 -983
		mu 0 4 471 472 523 522
		f 4 -887 986 987 -985
		mu 0 4 472 473 524 523
		f 4 -889 988 989 -987
		mu 0 4 473 474 525 524
		f 4 -891 990 991 -989
		mu 0 4 474 475 526 525
		f 4 -893 992 993 -991
		mu 0 4 475 476 527 526
		f 4 -895 994 995 -993
		mu 0 4 476 477 528 527
		f 4 -897 996 997 -995
		mu 0 4 477 478 529 528
		f 4 -899 998 999 -997
		mu 0 4 478 479 530 529
		f 4 -901 1000 1001 -999
		mu 0 4 479 480 531 530
		f 4 -903 1002 1003 -1001
		mu 0 4 480 481 532 531
		f 4 -905 1004 1005 -1003
		mu 0 4 481 482 533 532
		f 4 -907 1006 1007 -1005
		mu 0 4 482 483 534 533
		f 4 -909 1008 1009 -1007
		mu 0 4 483 484 535 534
		f 4 -911 1010 1011 -1009
		mu 0 4 484 485 536 535
		f 4 -913 1012 1013 -1011
		mu 0 4 485 486 537 536
		f 4 -915 1014 1015 -1013
		mu 0 4 486 487 538 537
		f 4 -917 1016 1017 -1015
		mu 0 4 487 488 539 538
		f 4 -919 1018 1019 -1017
		mu 0 4 488 489 540 539
		f 4 -921 1020 1021 -1019
		mu 0 4 489 490 541 540
		f 4 -923 1022 1023 -1021
		mu 0 4 490 491 542 541
		f 4 -925 1024 1025 -1023
		mu 0 4 491 492 543 542
		f 4 -927 1026 1027 -1025
		mu 0 4 492 493 544 543
		f 4 -929 1028 1029 -1027
		mu 0 4 493 494 545 544
		f 4 -931 1030 1031 -1029
		mu 0 4 494 495 546 545
		f 4 -933 1032 1033 -1031
		mu 0 4 495 496 547 546
		f 4 -935 1034 1035 -1033
		mu 0 4 496 497 548 547
		f 4 -937 1036 1037 -1035
		mu 0 4 497 498 549 548
		f 4 -939 1038 1039 -1037
		mu 0 4 498 499 550 549
		f 4 -941 1040 1041 -1039
		mu 0 4 499 500 551 550
		f 4 -943 1042 1043 -1041
		mu 0 4 500 501 552 551
		f 4 -945 1044 1045 -1043
		mu 0 4 501 502 553 552
		f 4 -947 1046 1047 -1045
		mu 0 4 502 503 554 553
		f 4 -949 1048 1049 -1047
		mu 0 4 503 504 555 554
		f 4 -951 1050 1051 -1049
		mu 0 4 504 505 556 555
		f 4 -953 1052 1053 -1051
		mu 0 4 505 506 557 556
		f 4 -955 1054 1055 -1053
		mu 0 4 506 507 558 557
		f 4 -957 1056 1057 -1055
		mu 0 4 507 508 559 558
		f 4 -959 1058 1059 -1057
		mu 0 4 508 509 560 559;
	setAttr ".fc[500:999]"
		f 4 -961 1060 1061 1062
		mu 0 4 510 511 562 561
		f 4 -964 1063 1064 -1061
		mu 0 4 511 512 563 562
		f 4 -966 1065 1066 -1064
		mu 0 4 512 513 564 563
		f 4 -968 1067 1068 -1066
		mu 0 4 513 514 565 564
		f 4 -970 1069 1070 -1068
		mu 0 4 514 515 566 565
		f 4 -972 1071 1072 -1070
		mu 0 4 515 516 567 566
		f 4 -974 1073 1074 -1072
		mu 0 4 516 517 568 567
		f 4 -976 1075 1076 -1074
		mu 0 4 517 518 569 568
		f 4 -978 1077 1078 -1076
		mu 0 4 518 519 570 569
		f 4 -980 1079 1080 -1078
		mu 0 4 519 520 571 570
		f 4 -982 1081 1082 -1080
		mu 0 4 520 521 572 571
		f 4 -984 1083 1084 -1082
		mu 0 4 521 522 573 572
		f 4 -986 1085 1086 -1084
		mu 0 4 522 523 574 573
		f 4 -988 1087 1088 -1086
		mu 0 4 523 524 575 574
		f 4 -990 1089 1090 -1088
		mu 0 4 524 525 576 575
		f 4 -992 1091 1092 -1090
		mu 0 4 525 526 577 576
		f 4 -994 1093 1094 -1092
		mu 0 4 526 527 578 577
		f 4 -996 1095 1096 -1094
		mu 0 4 527 528 579 578
		f 4 -998 1097 1098 -1096
		mu 0 4 528 529 580 579
		f 4 -1000 1099 1100 -1098
		mu 0 4 529 530 581 580
		f 4 -1002 1101 1102 -1100
		mu 0 4 530 531 582 581
		f 4 -1004 1103 1104 -1102
		mu 0 4 531 532 583 582
		f 4 -1006 1105 1106 -1104
		mu 0 4 532 533 584 583
		f 4 -1008 1107 1108 -1106
		mu 0 4 533 534 585 584
		f 4 -1010 1109 1110 -1108
		mu 0 4 534 535 586 585
		f 4 -1012 1111 1112 -1110
		mu 0 4 535 536 587 586
		f 4 -1014 1113 1114 -1112
		mu 0 4 536 537 588 587
		f 4 -1016 1115 1116 -1114
		mu 0 4 537 538 589 588
		f 4 -1018 1117 1118 -1116
		mu 0 4 538 539 590 589
		f 4 -1020 1119 1120 -1118
		mu 0 4 539 540 591 590
		f 4 -1022 1121 1122 -1120
		mu 0 4 540 541 592 591
		f 4 -1024 1123 1124 -1122
		mu 0 4 541 542 593 592
		f 4 -1026 1125 1126 -1124
		mu 0 4 542 543 594 593
		f 4 -1028 1127 1128 -1126
		mu 0 4 543 544 595 594
		f 4 -1030 1129 1130 -1128
		mu 0 4 544 545 596 595
		f 4 -1032 1131 1132 -1130
		mu 0 4 545 546 597 596
		f 4 -1034 1133 1134 -1132
		mu 0 4 546 547 598 597
		f 4 -1036 1135 1136 -1134
		mu 0 4 547 548 599 598
		f 4 -1038 1137 1138 -1136
		mu 0 4 548 549 600 599
		f 4 -1040 1139 1140 -1138
		mu 0 4 549 550 601 600
		f 4 -1042 1141 1142 -1140
		mu 0 4 550 551 602 601
		f 4 -1044 1143 1144 -1142
		mu 0 4 551 552 603 602
		f 4 -1046 1145 1146 -1144
		mu 0 4 552 553 604 603
		f 4 -1048 1147 1148 -1146
		mu 0 4 553 554 605 604
		f 4 -1050 1149 1150 -1148
		mu 0 4 554 555 606 605
		f 4 -1052 1151 1152 -1150
		mu 0 4 555 556 607 606
		f 4 -1054 1153 1154 -1152
		mu 0 4 556 557 608 607
		f 4 -1056 1155 1156 -1154
		mu 0 4 557 558 609 608
		f 4 -1058 1157 1158 -1156
		mu 0 4 558 559 610 609
		f 4 -1060 1159 1160 -1158
		mu 0 4 559 560 611 610
		f 4 -1062 1161 1162 1163
		mu 0 4 561 562 613 612
		f 4 -1065 1164 1165 -1162
		mu 0 4 562 563 614 613
		f 4 -1067 1166 1167 -1165
		mu 0 4 563 564 615 614
		f 4 -1069 1168 1169 -1167
		mu 0 4 564 565 616 615
		f 4 -1071 1170 1171 -1169
		mu 0 4 565 566 617 616
		f 4 -1073 1172 1173 -1171
		mu 0 4 566 567 618 617
		f 4 -1075 1174 1175 -1173
		mu 0 4 567 568 619 618
		f 4 -1077 1176 1177 -1175
		mu 0 4 568 569 620 619
		f 4 -1079 1178 1179 -1177
		mu 0 4 569 570 621 620
		f 4 -1081 1180 1181 -1179
		mu 0 4 570 571 622 621
		f 4 -1083 1182 1183 -1181
		mu 0 4 571 572 623 622
		f 4 -1085 1184 1185 -1183
		mu 0 4 572 573 624 623
		f 4 -1087 1186 1187 -1185
		mu 0 4 573 574 625 624
		f 4 -1089 1188 1189 -1187
		mu 0 4 574 575 626 625
		f 4 -1091 1190 1191 -1189
		mu 0 4 575 576 627 626
		f 4 -1093 1192 1193 -1191
		mu 0 4 576 577 628 627
		f 4 -1095 1194 1195 -1193
		mu 0 4 577 578 629 628
		f 4 -1097 1196 1197 -1195
		mu 0 4 578 579 630 629
		f 4 -1099 1198 1199 -1197
		mu 0 4 579 580 631 630
		f 4 -1101 1200 1201 -1199
		mu 0 4 580 581 632 631
		f 4 -1103 1202 1203 -1201
		mu 0 4 581 582 633 632
		f 4 -1105 1204 1205 -1203
		mu 0 4 582 583 634 633
		f 4 -1107 1206 1207 -1205
		mu 0 4 583 584 635 634
		f 4 -1109 1208 1209 -1207
		mu 0 4 584 585 636 635
		f 4 -1111 1210 1211 -1209
		mu 0 4 585 586 637 636
		f 4 -1113 1212 1213 -1211
		mu 0 4 586 587 638 637
		f 4 -1115 1214 1215 -1213
		mu 0 4 587 588 639 638
		f 4 -1117 1216 1217 -1215
		mu 0 4 588 589 640 639
		f 4 -1119 1218 1219 -1217
		mu 0 4 589 590 641 640
		f 4 -1121 1220 1221 -1219
		mu 0 4 590 591 642 641
		f 4 -1123 1222 1223 -1221
		mu 0 4 591 592 643 642
		f 4 -1125 1224 1225 -1223
		mu 0 4 592 593 644 643
		f 4 -1127 1226 1227 -1225
		mu 0 4 593 594 645 644
		f 4 -1129 1228 1229 -1227
		mu 0 4 594 595 646 645
		f 4 -1131 1230 1231 -1229
		mu 0 4 595 596 647 646
		f 4 -1133 1232 1233 -1231
		mu 0 4 596 597 648 647
		f 4 -1135 1234 1235 -1233
		mu 0 4 597 598 649 648
		f 4 -1137 1236 1237 -1235
		mu 0 4 598 599 650 649
		f 4 -1139 1238 1239 -1237
		mu 0 4 599 600 651 650
		f 4 -1141 1240 1241 -1239
		mu 0 4 600 601 652 651
		f 4 -1143 1242 1243 -1241
		mu 0 4 601 602 653 652
		f 4 -1145 1244 1245 -1243
		mu 0 4 602 603 654 653
		f 4 -1147 1246 1247 -1245
		mu 0 4 603 604 655 654
		f 4 -1149 1248 1249 -1247
		mu 0 4 604 605 656 655
		f 4 -1151 1250 1251 -1249
		mu 0 4 605 606 657 656
		f 4 -1153 1252 1253 -1251
		mu 0 4 606 607 658 657
		f 4 -1155 1254 1255 -1253
		mu 0 4 607 608 659 658
		f 4 -1157 1256 1257 -1255
		mu 0 4 608 609 660 659
		f 4 -1159 1258 1259 -1257
		mu 0 4 609 610 661 660
		f 4 -1161 1260 1261 -1259
		mu 0 4 610 611 662 661
		f 4 -1163 1262 1263 1264
		mu 0 4 612 613 664 663
		f 4 -1166 1265 1266 -1263
		mu 0 4 613 614 665 664
		f 4 -1168 1267 1268 -1266
		mu 0 4 614 615 666 665
		f 4 -1170 1269 1270 -1268
		mu 0 4 615 616 667 666
		f 4 -1172 1271 1272 -1270
		mu 0 4 616 617 668 667
		f 4 -1174 1273 1274 -1272
		mu 0 4 617 618 669 668
		f 4 -1176 1275 1276 -1274
		mu 0 4 618 619 670 669
		f 4 -1178 1277 1278 -1276
		mu 0 4 619 620 671 670
		f 4 -1180 1279 1280 -1278
		mu 0 4 620 621 672 671
		f 4 -1182 1281 1282 -1280
		mu 0 4 621 622 673 672
		f 4 -1184 1283 1284 -1282
		mu 0 4 622 623 674 673
		f 4 -1186 1285 1286 -1284
		mu 0 4 623 624 675 674
		f 4 -1188 1287 1288 -1286
		mu 0 4 624 625 676 675
		f 4 -1190 1289 1290 -1288
		mu 0 4 625 626 677 676
		f 4 -1192 1291 1292 -1290
		mu 0 4 626 627 678 677
		f 4 -1194 1293 1294 -1292
		mu 0 4 627 628 679 678
		f 4 -1196 1295 1296 -1294
		mu 0 4 628 629 680 679
		f 4 -1198 1297 1298 -1296
		mu 0 4 629 630 681 680
		f 4 -1200 1299 1300 -1298
		mu 0 4 630 631 682 681
		f 4 -1202 1301 1302 -1300
		mu 0 4 631 632 683 682
		f 4 -1204 1303 1304 -1302
		mu 0 4 632 633 684 683
		f 4 -1206 1305 1306 -1304
		mu 0 4 633 634 685 684
		f 4 -1208 1307 1308 -1306
		mu 0 4 634 635 686 685
		f 4 -1210 1309 1310 -1308
		mu 0 4 635 636 687 686
		f 4 -1212 1311 1312 -1310
		mu 0 4 636 637 688 687
		f 4 -1214 1313 1314 -1312
		mu 0 4 637 638 689 688
		f 4 -1216 1315 1316 -1314
		mu 0 4 638 639 690 689
		f 4 -1218 1317 1318 -1316
		mu 0 4 639 640 691 690
		f 4 -1220 1319 1320 -1318
		mu 0 4 640 641 692 691
		f 4 -1222 1321 1322 -1320
		mu 0 4 641 642 693 692
		f 4 -1224 1323 1324 -1322
		mu 0 4 642 643 694 693
		f 4 -1226 1325 1326 -1324
		mu 0 4 643 644 695 694
		f 4 -1228 1327 1328 -1326
		mu 0 4 644 645 696 695
		f 4 -1230 1329 1330 -1328
		mu 0 4 645 646 697 696
		f 4 -1232 1331 1332 -1330
		mu 0 4 646 647 698 697
		f 4 -1234 1333 1334 -1332
		mu 0 4 647 648 699 698
		f 4 -1236 1335 1336 -1334
		mu 0 4 648 649 700 699
		f 4 -1238 1337 1338 -1336
		mu 0 4 649 650 701 700
		f 4 -1240 1339 1340 -1338
		mu 0 4 650 651 702 701
		f 4 -1242 1341 1342 -1340
		mu 0 4 651 652 703 702
		f 4 -1244 1343 1344 -1342
		mu 0 4 652 653 704 703
		f 4 -1246 1345 1346 -1344
		mu 0 4 653 654 705 704
		f 4 -1248 1347 1348 -1346
		mu 0 4 654 655 706 705
		f 4 -1250 1349 1350 -1348
		mu 0 4 655 656 707 706
		f 4 -1252 1351 1352 -1350
		mu 0 4 656 657 708 707
		f 4 -1254 1353 1354 -1352
		mu 0 4 657 658 709 708
		f 4 -1256 1355 1356 -1354
		mu 0 4 658 659 710 709
		f 4 -1258 1357 1358 -1356
		mu 0 4 659 660 711 710
		f 4 -1260 1359 1360 -1358
		mu 0 4 660 661 712 711
		f 4 -1262 1361 1362 -1360
		mu 0 4 661 662 713 712
		f 4 -1264 1363 1364 1365
		mu 0 4 663 664 715 714
		f 4 -1267 1366 1367 -1364
		mu 0 4 664 665 716 715
		f 4 -1269 1368 1369 -1367
		mu 0 4 665 666 717 716
		f 4 -1271 1370 1371 -1369
		mu 0 4 666 667 718 717
		f 4 -1273 1372 1373 -1371
		mu 0 4 667 668 719 718
		f 4 -1275 1374 1375 -1373
		mu 0 4 668 669 720 719
		f 4 -1277 1376 1377 -1375
		mu 0 4 669 670 721 720
		f 4 -1279 1378 1379 -1377
		mu 0 4 670 671 722 721
		f 4 -1281 1380 1381 -1379
		mu 0 4 671 672 723 722
		f 4 -1283 1382 1383 -1381
		mu 0 4 672 673 724 723
		f 4 -1285 1384 1385 -1383
		mu 0 4 673 674 725 724
		f 4 -1287 1386 1387 -1385
		mu 0 4 674 675 726 725
		f 4 -1289 1388 1389 -1387
		mu 0 4 675 676 727 726
		f 4 -1291 1390 1391 -1389
		mu 0 4 676 677 728 727
		f 4 -1293 1392 1393 -1391
		mu 0 4 677 678 729 728
		f 4 -1295 1394 1395 -1393
		mu 0 4 678 679 730 729
		f 4 -1297 1396 1397 -1395
		mu 0 4 679 680 731 730
		f 4 -1299 1398 1399 -1397
		mu 0 4 680 681 732 731
		f 4 -1301 1400 1401 -1399
		mu 0 4 681 682 733 732
		f 4 -1303 1402 1403 -1401
		mu 0 4 682 683 734 733
		f 4 -1305 1404 1405 -1403
		mu 0 4 683 684 735 734
		f 4 -1307 1406 1407 -1405
		mu 0 4 684 685 736 735
		f 4 -1309 1408 1409 -1407
		mu 0 4 685 686 737 736
		f 4 -1311 1410 1411 -1409
		mu 0 4 686 687 738 737
		f 4 -1313 1412 1413 -1411
		mu 0 4 687 688 739 738
		f 4 -1315 1414 1415 -1413
		mu 0 4 688 689 740 739
		f 4 -1317 1416 1417 -1415
		mu 0 4 689 690 741 740
		f 4 -1319 1418 1419 -1417
		mu 0 4 690 691 742 741
		f 4 -1321 1420 1421 -1419
		mu 0 4 691 692 743 742
		f 4 -1323 1422 1423 -1421
		mu 0 4 692 693 744 743
		f 4 -1325 1424 1425 -1423
		mu 0 4 693 694 745 744
		f 4 -1327 1426 1427 -1425
		mu 0 4 694 695 746 745
		f 4 -1329 1428 1429 -1427
		mu 0 4 695 696 747 746
		f 4 -1331 1430 1431 -1429
		mu 0 4 696 697 748 747
		f 4 -1333 1432 1433 -1431
		mu 0 4 697 698 749 748
		f 4 -1335 1434 1435 -1433
		mu 0 4 698 699 750 749
		f 4 -1337 1436 1437 -1435
		mu 0 4 699 700 751 750
		f 4 -1339 1438 1439 -1437
		mu 0 4 700 701 752 751
		f 4 -1341 1440 1441 -1439
		mu 0 4 701 702 753 752
		f 4 -1343 1442 1443 -1441
		mu 0 4 702 703 754 753
		f 4 -1345 1444 1445 -1443
		mu 0 4 703 704 755 754
		f 4 -1347 1446 1447 -1445
		mu 0 4 704 705 756 755
		f 4 -1349 1448 1449 -1447
		mu 0 4 705 706 757 756
		f 4 -1351 1450 1451 -1449
		mu 0 4 706 707 758 757
		f 4 -1353 1452 1453 -1451
		mu 0 4 707 708 759 758
		f 4 -1355 1454 1455 -1453
		mu 0 4 708 709 760 759
		f 4 -1357 1456 1457 -1455
		mu 0 4 709 710 761 760
		f 4 -1359 1458 1459 -1457
		mu 0 4 710 711 762 761
		f 4 -1361 1460 1461 -1459
		mu 0 4 711 712 763 762
		f 4 -1363 1462 1463 -1461
		mu 0 4 712 713 764 763
		f 4 -1365 1464 1465 1466
		mu 0 4 714 715 766 765
		f 4 -1368 1467 1468 -1465
		mu 0 4 715 716 767 766
		f 4 -1370 1469 1470 -1468
		mu 0 4 716 717 768 767
		f 4 -1372 1471 1472 -1470
		mu 0 4 717 718 769 768
		f 4 -1374 1473 1474 -1472
		mu 0 4 718 719 770 769
		f 4 -1376 1475 1476 -1474
		mu 0 4 719 720 771 770
		f 4 -1378 1477 1478 -1476
		mu 0 4 720 721 772 771
		f 4 -1380 1479 1480 -1478
		mu 0 4 721 722 773 772
		f 4 -1382 1481 1482 -1480
		mu 0 4 722 723 774 773
		f 4 -1384 1483 1484 -1482
		mu 0 4 723 724 775 774
		f 4 -1386 1485 1486 -1484
		mu 0 4 724 725 776 775
		f 4 -1388 1487 1488 -1486
		mu 0 4 725 726 777 776
		f 4 -1390 1489 1490 -1488
		mu 0 4 726 727 778 777
		f 4 -1392 1491 1492 -1490
		mu 0 4 727 728 779 778
		f 4 -1394 1493 1494 -1492
		mu 0 4 728 729 780 779
		f 4 -1396 1495 1496 -1494
		mu 0 4 729 730 781 780
		f 4 -1398 1497 1498 -1496
		mu 0 4 730 731 782 781
		f 4 -1400 1499 1500 -1498
		mu 0 4 731 732 783 782
		f 4 -1402 1501 1502 -1500
		mu 0 4 732 733 784 783
		f 4 -1404 1503 1504 -1502
		mu 0 4 733 734 785 784
		f 4 -1406 1505 1506 -1504
		mu 0 4 734 735 786 785
		f 4 -1408 1507 1508 -1506
		mu 0 4 735 736 787 786
		f 4 -1410 1509 1510 -1508
		mu 0 4 736 737 788 787
		f 4 -1412 1511 1512 -1510
		mu 0 4 737 738 789 788
		f 4 -1414 1513 1514 -1512
		mu 0 4 738 739 790 789
		f 4 -1416 1515 1516 -1514
		mu 0 4 739 740 791 790
		f 4 -1418 1517 1518 -1516
		mu 0 4 740 741 792 791
		f 4 -1420 1519 1520 -1518
		mu 0 4 741 742 793 792
		f 4 -1422 1521 1522 -1520
		mu 0 4 742 743 794 793
		f 4 -1424 1523 1524 -1522
		mu 0 4 743 744 795 794
		f 4 -1426 1525 1526 -1524
		mu 0 4 744 745 796 795
		f 4 -1428 1527 1528 -1526
		mu 0 4 745 746 797 796
		f 4 -1430 1529 1530 -1528
		mu 0 4 746 747 798 797
		f 4 -1432 1531 1532 -1530
		mu 0 4 747 748 799 798
		f 4 -1434 1533 1534 -1532
		mu 0 4 748 749 800 799
		f 4 -1436 1535 1536 -1534
		mu 0 4 749 750 801 800
		f 4 -1438 1537 1538 -1536
		mu 0 4 750 751 802 801
		f 4 -1440 1539 1540 -1538
		mu 0 4 751 752 803 802
		f 4 -1442 1541 1542 -1540
		mu 0 4 752 753 804 803
		f 4 -1444 1543 1544 -1542
		mu 0 4 753 754 805 804
		f 4 -1446 1545 1546 -1544
		mu 0 4 754 755 806 805
		f 4 -1448 1547 1548 -1546
		mu 0 4 755 756 807 806
		f 4 -1450 1549 1550 -1548
		mu 0 4 756 757 808 807
		f 4 -1452 1551 1552 -1550
		mu 0 4 757 758 809 808
		f 4 -1454 1553 1554 -1552
		mu 0 4 758 759 810 809
		f 4 -1456 1555 1556 -1554
		mu 0 4 759 760 811 810
		f 4 -1458 1557 1558 -1556
		mu 0 4 760 761 812 811
		f 4 -1460 1559 1560 -1558
		mu 0 4 761 762 813 812
		f 4 -1462 1561 1562 -1560
		mu 0 4 762 763 814 813
		f 4 -1464 1563 1564 -1562
		mu 0 4 763 764 815 814
		f 4 -1466 1565 1566 1567
		mu 0 4 765 766 817 816
		f 4 -1469 1568 1569 -1566
		mu 0 4 766 767 818 817
		f 4 -1471 1570 1571 -1569
		mu 0 4 767 768 819 818
		f 4 -1473 1572 1573 -1571
		mu 0 4 768 769 820 819
		f 4 -1475 1574 1575 -1573
		mu 0 4 769 770 821 820
		f 4 -1477 1576 1577 -1575
		mu 0 4 770 771 822 821
		f 4 -1479 1578 1579 -1577
		mu 0 4 771 772 823 822
		f 4 -1481 1580 1581 -1579
		mu 0 4 772 773 824 823
		f 4 -1483 1582 1583 -1581
		mu 0 4 773 774 825 824
		f 4 -1485 1584 1585 -1583
		mu 0 4 774 775 826 825
		f 4 -1487 1586 1587 -1585
		mu 0 4 775 776 827 826
		f 4 -1489 1588 1589 -1587
		mu 0 4 776 777 828 827
		f 4 -1491 1590 1591 -1589
		mu 0 4 777 778 829 828
		f 4 -1493 1592 1593 -1591
		mu 0 4 778 779 830 829
		f 4 -1495 1594 1595 -1593
		mu 0 4 779 780 831 830
		f 4 -1497 1596 1597 -1595
		mu 0 4 780 781 832 831
		f 4 -1499 1598 1599 -1597
		mu 0 4 781 782 833 832
		f 4 -1501 1600 1601 -1599
		mu 0 4 782 783 834 833
		f 4 -1503 1602 1603 -1601
		mu 0 4 783 784 835 834
		f 4 -1505 1604 1605 -1603
		mu 0 4 784 785 836 835
		f 4 -1507 1606 1607 -1605
		mu 0 4 785 786 837 836
		f 4 -1509 1608 1609 -1607
		mu 0 4 786 787 838 837
		f 4 -1511 1610 1611 -1609
		mu 0 4 787 788 839 838
		f 4 -1513 1612 1613 -1611
		mu 0 4 788 789 840 839
		f 4 -1515 1614 1615 -1613
		mu 0 4 789 790 841 840
		f 4 -1517 1616 1617 -1615
		mu 0 4 790 791 842 841
		f 4 -1519 1618 1619 -1617
		mu 0 4 791 792 843 842
		f 4 -1521 1620 1621 -1619
		mu 0 4 792 793 844 843
		f 4 -1523 1622 1623 -1621
		mu 0 4 793 794 845 844
		f 4 -1525 1624 1625 -1623
		mu 0 4 794 795 846 845
		f 4 -1527 1626 1627 -1625
		mu 0 4 795 796 847 846
		f 4 -1529 1628 1629 -1627
		mu 0 4 796 797 848 847
		f 4 -1531 1630 1631 -1629
		mu 0 4 797 798 849 848
		f 4 -1533 1632 1633 -1631
		mu 0 4 798 799 850 849
		f 4 -1535 1634 1635 -1633
		mu 0 4 799 800 851 850
		f 4 -1537 1636 1637 -1635
		mu 0 4 800 801 852 851
		f 4 -1539 1638 1639 -1637
		mu 0 4 801 802 853 852
		f 4 -1541 1640 1641 -1639
		mu 0 4 802 803 854 853
		f 4 -1543 1642 1643 -1641
		mu 0 4 803 804 855 854
		f 4 -1545 1644 1645 -1643
		mu 0 4 804 805 856 855
		f 4 -1547 1646 1647 -1645
		mu 0 4 805 806 857 856
		f 4 -1549 1648 1649 -1647
		mu 0 4 806 807 858 857
		f 4 -1551 1650 1651 -1649
		mu 0 4 807 808 859 858
		f 4 -1553 1652 1653 -1651
		mu 0 4 808 809 860 859
		f 4 -1555 1654 1655 -1653
		mu 0 4 809 810 861 860
		f 4 -1557 1656 1657 -1655
		mu 0 4 810 811 862 861
		f 4 -1559 1658 1659 -1657
		mu 0 4 811 812 863 862
		f 4 -1561 1660 1661 -1659
		mu 0 4 812 813 864 863
		f 4 -1563 1662 1663 -1661
		mu 0 4 813 814 865 864
		f 4 -1565 1664 1665 -1663
		mu 0 4 814 815 866 865
		f 4 -1567 1666 1667 1668
		mu 0 4 816 817 868 867
		f 4 -1570 1669 1670 -1667
		mu 0 4 817 818 869 868
		f 4 -1572 1671 1672 -1670
		mu 0 4 818 819 870 869
		f 4 -1574 1673 1674 -1672
		mu 0 4 819 820 871 870
		f 4 -1576 1675 1676 -1674
		mu 0 4 820 821 872 871
		f 4 -1578 1677 1678 -1676
		mu 0 4 821 822 873 872
		f 4 -1580 1679 1680 -1678
		mu 0 4 822 823 874 873
		f 4 -1582 1681 1682 -1680
		mu 0 4 823 824 875 874
		f 4 -1584 1683 1684 -1682
		mu 0 4 824 825 876 875
		f 4 -1586 1685 1686 -1684
		mu 0 4 825 826 877 876
		f 4 -1588 1687 1688 -1686
		mu 0 4 826 827 878 877
		f 4 -1590 1689 1690 -1688
		mu 0 4 827 828 879 878
		f 4 -1592 1691 1692 -1690
		mu 0 4 828 829 880 879
		f 4 -1594 1693 1694 -1692
		mu 0 4 829 830 881 880
		f 4 -1596 1695 1696 -1694
		mu 0 4 830 831 882 881
		f 4 -1598 1697 1698 -1696
		mu 0 4 831 832 883 882
		f 4 -1600 1699 1700 -1698
		mu 0 4 832 833 884 883
		f 4 -1602 1701 1702 -1700
		mu 0 4 833 834 885 884
		f 4 -1604 1703 1704 -1702
		mu 0 4 834 835 886 885
		f 4 -1606 1705 1706 -1704
		mu 0 4 835 836 887 886
		f 4 -1608 1707 1708 -1706
		mu 0 4 836 837 888 887
		f 4 -1610 1709 1710 -1708
		mu 0 4 837 838 889 888
		f 4 -1612 1711 1712 -1710
		mu 0 4 838 839 890 889
		f 4 -1614 1713 1714 -1712
		mu 0 4 839 840 891 890
		f 4 -1616 1715 1716 -1714
		mu 0 4 840 841 892 891
		f 4 -1618 1717 1718 -1716
		mu 0 4 841 842 893 892
		f 4 -1620 1719 1720 -1718
		mu 0 4 842 843 894 893
		f 4 -1622 1721 1722 -1720
		mu 0 4 843 844 895 894
		f 4 -1624 1723 1724 -1722
		mu 0 4 844 845 896 895
		f 4 -1626 1725 1726 -1724
		mu 0 4 845 846 897 896
		f 4 -1628 1727 1728 -1726
		mu 0 4 846 847 898 897
		f 4 -1630 1729 1730 -1728
		mu 0 4 847 848 899 898
		f 4 -1632 1731 1732 -1730
		mu 0 4 848 849 900 899
		f 4 -1634 1733 1734 -1732
		mu 0 4 849 850 901 900
		f 4 -1636 1735 1736 -1734
		mu 0 4 850 851 902 901
		f 4 -1638 1737 1738 -1736
		mu 0 4 851 852 903 902
		f 4 -1640 1739 1740 -1738
		mu 0 4 852 853 904 903
		f 4 -1642 1741 1742 -1740
		mu 0 4 853 854 905 904
		f 4 -1644 1743 1744 -1742
		mu 0 4 854 855 906 905
		f 4 -1646 1745 1746 -1744
		mu 0 4 855 856 907 906
		f 4 -1648 1747 1748 -1746
		mu 0 4 856 857 908 907
		f 4 -1650 1749 1750 -1748
		mu 0 4 857 858 909 908
		f 4 -1652 1751 1752 -1750
		mu 0 4 858 859 910 909
		f 4 -1654 1753 1754 -1752
		mu 0 4 859 860 911 910
		f 4 -1656 1755 1756 -1754
		mu 0 4 860 861 912 911
		f 4 -1658 1757 1758 -1756
		mu 0 4 861 862 913 912
		f 4 -1660 1759 1760 -1758
		mu 0 4 862 863 914 913
		f 4 -1662 1761 1762 -1760
		mu 0 4 863 864 915 914
		f 4 -1664 1763 1764 -1762
		mu 0 4 864 865 916 915
		f 4 -1666 1765 1766 -1764
		mu 0 4 865 866 917 916
		f 4 -1668 1767 1768 1769
		mu 0 4 867 868 919 918
		f 4 -1671 1770 1771 -1768
		mu 0 4 868 869 920 919
		f 4 -1673 1772 1773 -1771
		mu 0 4 869 870 921 920
		f 4 -1675 1774 1775 -1773
		mu 0 4 870 871 922 921
		f 4 -1677 1776 1777 -1775
		mu 0 4 871 872 923 922
		f 4 -1679 1778 1779 -1777
		mu 0 4 872 873 924 923
		f 4 -1681 1780 1781 -1779
		mu 0 4 873 874 925 924
		f 4 -1683 1782 1783 -1781
		mu 0 4 874 875 926 925
		f 4 -1685 1784 1785 -1783
		mu 0 4 875 876 927 926
		f 4 -1687 1786 1787 -1785
		mu 0 4 876 877 928 927
		f 4 -1689 1788 1789 -1787
		mu 0 4 877 878 929 928
		f 4 -1691 1790 1791 -1789
		mu 0 4 878 879 930 929
		f 4 -1693 1792 1793 -1791
		mu 0 4 879 880 931 930
		f 4 -1695 1794 1795 -1793
		mu 0 4 880 881 932 931
		f 4 -1697 1796 1797 -1795
		mu 0 4 881 882 933 932
		f 4 -1699 1798 1799 -1797
		mu 0 4 882 883 934 933
		f 4 -1701 1800 1801 -1799
		mu 0 4 883 884 935 934
		f 4 -1703 1802 1803 -1801
		mu 0 4 884 885 936 935
		f 4 -1705 1804 1805 -1803
		mu 0 4 885 886 937 936
		f 4 -1707 1806 1807 -1805
		mu 0 4 886 887 938 937
		f 4 -1709 1808 1809 -1807
		mu 0 4 887 888 939 938
		f 4 -1711 1810 1811 -1809
		mu 0 4 888 889 940 939
		f 4 -1713 1812 1813 -1811
		mu 0 4 889 890 941 940
		f 4 -1715 1814 1815 -1813
		mu 0 4 890 891 942 941
		f 4 -1717 1816 1817 -1815
		mu 0 4 891 892 943 942
		f 4 -1719 1818 1819 -1817
		mu 0 4 892 893 944 943
		f 4 -1721 1820 1821 -1819
		mu 0 4 893 894 945 944
		f 4 -1723 1822 1823 -1821
		mu 0 4 894 895 946 945
		f 4 -1725 1824 1825 -1823
		mu 0 4 895 896 947 946
		f 4 -1727 1826 1827 -1825
		mu 0 4 896 897 948 947
		f 4 -1729 1828 1829 -1827
		mu 0 4 897 898 949 948
		f 4 -1731 1830 1831 -1829
		mu 0 4 898 899 950 949
		f 4 -1733 1832 1833 -1831
		mu 0 4 899 900 951 950
		f 4 -1735 1834 1835 -1833
		mu 0 4 900 901 952 951
		f 4 -1737 1836 1837 -1835
		mu 0 4 901 902 953 952
		f 4 -1739 1838 1839 -1837
		mu 0 4 902 903 954 953
		f 4 -1741 1840 1841 -1839
		mu 0 4 903 904 955 954
		f 4 -1743 1842 1843 -1841
		mu 0 4 904 905 956 955
		f 4 -1745 1844 1845 -1843
		mu 0 4 905 906 957 956
		f 4 -1747 1846 1847 -1845
		mu 0 4 906 907 958 957
		f 4 -1749 1848 1849 -1847
		mu 0 4 907 908 959 958
		f 4 -1751 1850 1851 -1849
		mu 0 4 908 909 960 959
		f 4 -1753 1852 1853 -1851
		mu 0 4 909 910 961 960
		f 4 -1755 1854 1855 -1853
		mu 0 4 910 911 962 961
		f 4 -1757 1856 1857 -1855
		mu 0 4 911 912 963 962
		f 4 -1759 1858 1859 -1857
		mu 0 4 912 913 964 963
		f 4 -1761 1860 1861 -1859
		mu 0 4 913 914 965 964
		f 4 -1763 1862 1863 -1861
		mu 0 4 914 915 966 965
		f 4 -1765 1864 1865 -1863
		mu 0 4 915 916 967 966
		f 4 -1767 1866 1867 -1865
		mu 0 4 916 917 968 967
		f 4 -1769 1868 1869 1870
		mu 0 4 918 919 970 969
		f 4 -1772 1871 1872 -1869
		mu 0 4 919 920 971 970
		f 4 -1774 1873 1874 -1872
		mu 0 4 920 921 972 971
		f 4 -1776 1875 1876 -1874
		mu 0 4 921 922 973 972
		f 4 -1778 1877 1878 -1876
		mu 0 4 922 923 974 973
		f 4 -1780 1879 1880 -1878
		mu 0 4 923 924 975 974
		f 4 -1782 1881 1882 -1880
		mu 0 4 924 925 976 975
		f 4 -1784 1883 1884 -1882
		mu 0 4 925 926 977 976
		f 4 -1786 1885 1886 -1884
		mu 0 4 926 927 978 977
		f 4 -1788 1887 1888 -1886
		mu 0 4 927 928 979 978
		f 4 -1790 1889 1890 -1888
		mu 0 4 928 929 980 979
		f 4 -1792 1891 1892 -1890
		mu 0 4 929 930 981 980
		f 4 -1794 1893 1894 -1892
		mu 0 4 930 931 982 981
		f 4 -1796 1895 1896 -1894
		mu 0 4 931 932 983 982
		f 4 -1798 1897 1898 -1896
		mu 0 4 932 933 984 983
		f 4 -1800 1899 1900 -1898
		mu 0 4 933 934 985 984
		f 4 -1802 1901 1902 -1900
		mu 0 4 934 935 986 985
		f 4 -1804 1903 1904 -1902
		mu 0 4 935 936 987 986
		f 4 -1806 1905 1906 -1904
		mu 0 4 936 937 988 987
		f 4 -1808 1907 1908 -1906
		mu 0 4 937 938 989 988
		f 4 -1810 1909 1910 -1908
		mu 0 4 938 939 990 989
		f 4 -1812 1911 1912 -1910
		mu 0 4 939 940 991 990
		f 4 -1814 1913 1914 -1912
		mu 0 4 940 941 992 991
		f 4 -1816 1915 1916 -1914
		mu 0 4 941 942 993 992
		f 4 -1818 1917 1918 -1916
		mu 0 4 942 943 994 993
		f 4 -1820 1919 1920 -1918
		mu 0 4 943 944 995 994
		f 4 -1822 1921 1922 -1920
		mu 0 4 944 945 996 995
		f 4 -1824 1923 1924 -1922
		mu 0 4 945 946 997 996
		f 4 -1826 1925 1926 -1924
		mu 0 4 946 947 998 997
		f 4 -1828 1927 1928 -1926
		mu 0 4 947 948 999 998
		f 4 -1830 1929 1930 -1928
		mu 0 4 948 949 1000 999
		f 4 -1832 1931 1932 -1930
		mu 0 4 949 950 1001 1000
		f 4 -1834 1933 1934 -1932
		mu 0 4 950 951 1002 1001
		f 4 -1836 1935 1936 -1934
		mu 0 4 951 952 1003 1002
		f 4 -1838 1937 1938 -1936
		mu 0 4 952 953 1004 1003
		f 4 -1840 1939 1940 -1938
		mu 0 4 953 954 1005 1004
		f 4 -1842 1941 1942 -1940
		mu 0 4 954 955 1006 1005
		f 4 -1844 1943 1944 -1942
		mu 0 4 955 956 1007 1006
		f 4 -1846 1945 1946 -1944
		mu 0 4 956 957 1008 1007
		f 4 -1848 1947 1948 -1946
		mu 0 4 957 958 1009 1008
		f 4 -1850 1949 1950 -1948
		mu 0 4 958 959 1010 1009
		f 4 -1852 1951 1952 -1950
		mu 0 4 959 960 1011 1010
		f 4 -1854 1953 1954 -1952
		mu 0 4 960 961 1012 1011
		f 4 -1856 1955 1956 -1954
		mu 0 4 961 962 1013 1012
		f 4 -1858 1957 1958 -1956
		mu 0 4 962 963 1014 1013
		f 4 -1860 1959 1960 -1958
		mu 0 4 963 964 1015 1014
		f 4 -1862 1961 1962 -1960
		mu 0 4 964 965 1016 1015
		f 4 -1864 1963 1964 -1962
		mu 0 4 965 966 1017 1016
		f 4 -1866 1965 1966 -1964
		mu 0 4 966 967 1018 1017
		f 4 -1868 1967 1968 -1966
		mu 0 4 967 968 1019 1018
		f 4 -1870 1969 1970 1971
		mu 0 4 969 970 1021 1020
		f 4 -1873 1972 1973 -1970
		mu 0 4 970 971 1022 1021
		f 4 -1875 1974 1975 -1973
		mu 0 4 971 972 1023 1022
		f 4 -1877 1976 1977 -1975
		mu 0 4 972 973 1024 1023
		f 4 -1879 1978 1979 -1977
		mu 0 4 973 974 1025 1024
		f 4 -1881 1980 1981 -1979
		mu 0 4 974 975 1026 1025
		f 4 -1883 1982 1983 -1981
		mu 0 4 975 976 1027 1026
		f 4 -1885 1984 1985 -1983
		mu 0 4 976 977 1028 1027
		f 4 -1887 1986 1987 -1985
		mu 0 4 977 978 1029 1028
		f 4 -1889 1988 1989 -1987
		mu 0 4 978 979 1030 1029
		f 4 -1891 1990 1991 -1989
		mu 0 4 979 980 1031 1030
		f 4 -1893 1992 1993 -1991
		mu 0 4 980 981 1032 1031
		f 4 -1895 1994 1995 -1993
		mu 0 4 981 982 1033 1032
		f 4 -1897 1996 1997 -1995
		mu 0 4 982 983 1034 1033
		f 4 -1899 1998 1999 -1997
		mu 0 4 983 984 1035 1034
		f 4 -1901 2000 2001 -1999
		mu 0 4 984 985 1036 1035
		f 4 -1903 2002 2003 -2001
		mu 0 4 985 986 1037 1036
		f 4 -1905 2004 2005 -2003
		mu 0 4 986 987 1038 1037
		f 4 -1907 2006 2007 -2005
		mu 0 4 987 988 1039 1038
		f 4 -1909 2008 2009 -2007
		mu 0 4 988 989 1040 1039
		f 4 -1911 2010 2011 -2009
		mu 0 4 989 990 1041 1040
		f 4 -1913 2012 2013 -2011
		mu 0 4 990 991 1042 1041
		f 4 -1915 2014 2015 -2013
		mu 0 4 991 992 1043 1042
		f 4 -1917 2016 2017 -2015
		mu 0 4 992 993 1044 1043
		f 4 -1919 2018 2019 -2017
		mu 0 4 993 994 1045 1044
		f 4 -1921 2020 2021 -2019
		mu 0 4 994 995 1046 1045
		f 4 -1923 2022 2023 -2021
		mu 0 4 995 996 1047 1046
		f 4 -1925 2024 2025 -2023
		mu 0 4 996 997 1048 1047
		f 4 -1927 2026 2027 -2025
		mu 0 4 997 998 1049 1048
		f 4 -1929 2028 2029 -2027
		mu 0 4 998 999 1050 1049
		f 4 -1931 2030 2031 -2029
		mu 0 4 999 1000 1051 1050
		f 4 -1933 2032 2033 -2031
		mu 0 4 1000 1001 1052 1051
		f 4 -1935 2034 2035 -2033
		mu 0 4 1001 1002 1053 1052
		f 4 -1937 2036 2037 -2035
		mu 0 4 1002 1003 1054 1053
		f 4 -1939 2038 2039 -2037
		mu 0 4 1003 1004 1055 1054
		f 4 -1941 2040 2041 -2039
		mu 0 4 1004 1005 1056 1055
		f 4 -1943 2042 2043 -2041
		mu 0 4 1005 1006 1057 1056
		f 4 -1945 2044 2045 -2043
		mu 0 4 1006 1007 1058 1057
		f 4 -1947 2046 2047 -2045
		mu 0 4 1007 1008 1059 1058
		f 4 -1949 2048 2049 -2047
		mu 0 4 1008 1009 1060 1059
		f 4 -1951 2050 2051 -2049
		mu 0 4 1009 1010 1061 1060
		f 4 -1953 2052 2053 -2051
		mu 0 4 1010 1011 1062 1061
		f 4 -1955 2054 2055 -2053
		mu 0 4 1011 1012 1063 1062
		f 4 -1957 2056 2057 -2055
		mu 0 4 1012 1013 1064 1063
		f 4 -1959 2058 2059 -2057
		mu 0 4 1013 1014 1065 1064
		f 4 -1961 2060 2061 -2059
		mu 0 4 1014 1015 1066 1065
		f 4 -1963 2062 2063 -2061
		mu 0 4 1015 1016 1067 1066
		f 4 -1965 2064 2065 -2063
		mu 0 4 1016 1017 1068 1067
		f 4 -1967 2066 2067 -2065
		mu 0 4 1017 1018 1069 1068
		f 4 -1969 2068 2069 -2067
		mu 0 4 1018 1019 1070 1069;
	setAttr ".fc[1000:1499]"
		f 4 -1971 2070 2071 2072
		mu 0 4 1020 1021 1072 1071
		f 4 -1974 2073 2074 -2071
		mu 0 4 1021 1022 1073 1072
		f 4 -1976 2075 2076 -2074
		mu 0 4 1022 1023 1074 1073
		f 4 -1978 2077 2078 -2076
		mu 0 4 1023 1024 1075 1074
		f 4 -1980 2079 2080 -2078
		mu 0 4 1024 1025 1076 1075
		f 4 -1982 2081 2082 -2080
		mu 0 4 1025 1026 1077 1076
		f 4 -1984 2083 2084 -2082
		mu 0 4 1026 1027 1078 1077
		f 4 -1986 2085 2086 -2084
		mu 0 4 1027 1028 1079 1078
		f 4 -1988 2087 2088 -2086
		mu 0 4 1028 1029 1080 1079
		f 4 -1990 2089 2090 -2088
		mu 0 4 1029 1030 1081 1080
		f 4 -1992 2091 2092 -2090
		mu 0 4 1030 1031 1082 1081
		f 4 -1994 2093 2094 -2092
		mu 0 4 1031 1032 1083 1082
		f 4 -1996 2095 2096 -2094
		mu 0 4 1032 1033 1084 1083
		f 4 -1998 2097 2098 -2096
		mu 0 4 1033 1034 1085 1084
		f 4 -2000 2099 2100 -2098
		mu 0 4 1034 1035 1086 1085
		f 4 -2002 2101 2102 -2100
		mu 0 4 1035 1036 1087 1086
		f 4 -2004 2103 2104 -2102
		mu 0 4 1036 1037 1088 1087
		f 4 -2006 2105 2106 -2104
		mu 0 4 1037 1038 1089 1088
		f 4 -2008 2107 2108 -2106
		mu 0 4 1038 1039 1090 1089
		f 4 -2010 2109 2110 -2108
		mu 0 4 1039 1040 1091 1090
		f 4 -2012 2111 2112 -2110
		mu 0 4 1040 1041 1092 1091
		f 4 -2014 2113 2114 -2112
		mu 0 4 1041 1042 1093 1092
		f 4 -2016 2115 2116 -2114
		mu 0 4 1042 1043 1094 1093
		f 4 -2018 2117 2118 -2116
		mu 0 4 1043 1044 1095 1094
		f 4 -2020 2119 2120 -2118
		mu 0 4 1044 1045 1096 1095
		f 4 -2022 2121 2122 -2120
		mu 0 4 1045 1046 1097 1096
		f 4 -2024 2123 2124 -2122
		mu 0 4 1046 1047 1098 1097
		f 4 -2026 2125 2126 -2124
		mu 0 4 1047 1048 1099 1098
		f 4 -2028 2127 2128 -2126
		mu 0 4 1048 1049 1100 1099
		f 4 -2030 2129 2130 -2128
		mu 0 4 1049 1050 1101 1100
		f 4 -2032 2131 2132 -2130
		mu 0 4 1050 1051 1102 1101
		f 4 -2034 2133 2134 -2132
		mu 0 4 1051 1052 1103 1102
		f 4 -2036 2135 2136 -2134
		mu 0 4 1052 1053 1104 1103
		f 4 -2038 2137 2138 -2136
		mu 0 4 1053 1054 1105 1104
		f 4 -2040 2139 2140 -2138
		mu 0 4 1054 1055 1106 1105
		f 4 -2042 2141 2142 -2140
		mu 0 4 1055 1056 1107 1106
		f 4 -2044 2143 2144 -2142
		mu 0 4 1056 1057 1108 1107
		f 4 -2046 2145 2146 -2144
		mu 0 4 1057 1058 1109 1108
		f 4 -2048 2147 2148 -2146
		mu 0 4 1058 1059 1110 1109
		f 4 -2050 2149 2150 -2148
		mu 0 4 1059 1060 1111 1110
		f 4 -2052 2151 2152 -2150
		mu 0 4 1060 1061 1112 1111
		f 4 -2054 2153 2154 -2152
		mu 0 4 1061 1062 1113 1112
		f 4 -2056 2155 2156 -2154
		mu 0 4 1062 1063 1114 1113
		f 4 -2058 2157 2158 -2156
		mu 0 4 1063 1064 1115 1114
		f 4 -2060 2159 2160 -2158
		mu 0 4 1064 1065 1116 1115
		f 4 -2062 2161 2162 -2160
		mu 0 4 1065 1066 1117 1116
		f 4 -2064 2163 2164 -2162
		mu 0 4 1066 1067 1118 1117
		f 4 -2066 2165 2166 -2164
		mu 0 4 1067 1068 1119 1118
		f 4 -2068 2167 2168 -2166
		mu 0 4 1068 1069 1120 1119
		f 4 -2070 2169 2170 -2168
		mu 0 4 1069 1070 1121 1120
		f 4 -2072 2171 2172 2173
		mu 0 4 1071 1072 1123 1122
		f 4 -2075 2174 2175 -2172
		mu 0 4 1072 1073 1124 1123
		f 4 -2077 2176 2177 -2175
		mu 0 4 1073 1074 1125 1124
		f 4 -2079 2178 2179 -2177
		mu 0 4 1074 1075 1126 1125
		f 4 -2081 2180 2181 -2179
		mu 0 4 1075 1076 1127 1126
		f 4 -2083 2182 2183 -2181
		mu 0 4 1076 1077 1128 1127
		f 4 -2085 2184 2185 -2183
		mu 0 4 1077 1078 1129 1128
		f 4 -2087 2186 2187 -2185
		mu 0 4 1078 1079 1130 1129
		f 4 -2089 2188 2189 -2187
		mu 0 4 1079 1080 1131 1130
		f 4 -2091 2190 2191 -2189
		mu 0 4 1080 1081 1132 1131
		f 4 -2093 2192 2193 -2191
		mu 0 4 1081 1082 1133 1132
		f 4 -2095 2194 2195 -2193
		mu 0 4 1082 1083 1134 1133
		f 4 -2097 2196 2197 -2195
		mu 0 4 1083 1084 1135 1134
		f 4 -2099 2198 2199 -2197
		mu 0 4 1084 1085 1136 1135
		f 4 -2101 2200 2201 -2199
		mu 0 4 1085 1086 1137 1136
		f 4 -2103 2202 2203 -2201
		mu 0 4 1086 1087 1138 1137
		f 4 -2105 2204 2205 -2203
		mu 0 4 1087 1088 1139 1138
		f 4 -2107 2206 2207 -2205
		mu 0 4 1088 1089 1140 1139
		f 4 -2109 2208 2209 -2207
		mu 0 4 1089 1090 1141 1140
		f 4 -2111 2210 2211 -2209
		mu 0 4 1090 1091 1142 1141
		f 4 -2113 2212 2213 -2211
		mu 0 4 1091 1092 1143 1142
		f 4 -2115 2214 2215 -2213
		mu 0 4 1092 1093 1144 1143
		f 4 -2117 2216 2217 -2215
		mu 0 4 1093 1094 1145 1144
		f 4 -2119 2218 2219 -2217
		mu 0 4 1094 1095 1146 1145
		f 4 -2121 2220 2221 -2219
		mu 0 4 1095 1096 1147 1146
		f 4 -2123 2222 2223 -2221
		mu 0 4 1096 1097 1148 1147
		f 4 -2125 2224 2225 -2223
		mu 0 4 1097 1098 1149 1148
		f 4 -2127 2226 2227 -2225
		mu 0 4 1098 1099 1150 1149
		f 4 -2129 2228 2229 -2227
		mu 0 4 1099 1100 1151 1150
		f 4 -2131 2230 2231 -2229
		mu 0 4 1100 1101 1152 1151
		f 4 -2133 2232 2233 -2231
		mu 0 4 1101 1102 1153 1152
		f 4 -2135 2234 2235 -2233
		mu 0 4 1102 1103 1154 1153
		f 4 -2137 2236 2237 -2235
		mu 0 4 1103 1104 1155 1154
		f 4 -2139 2238 2239 -2237
		mu 0 4 1104 1105 1156 1155
		f 4 -2141 2240 2241 -2239
		mu 0 4 1105 1106 1157 1156
		f 4 -2143 2242 2243 -2241
		mu 0 4 1106 1107 1158 1157
		f 4 -2145 2244 2245 -2243
		mu 0 4 1107 1108 1159 1158
		f 4 -2147 2246 2247 -2245
		mu 0 4 1108 1109 1160 1159
		f 4 -2149 2248 2249 -2247
		mu 0 4 1109 1110 1161 1160
		f 4 -2151 2250 2251 -2249
		mu 0 4 1110 1111 1162 1161
		f 4 -2153 2252 2253 -2251
		mu 0 4 1111 1112 1163 1162
		f 4 -2155 2254 2255 -2253
		mu 0 4 1112 1113 1164 1163
		f 4 -2157 2256 2257 -2255
		mu 0 4 1113 1114 1165 1164
		f 4 -2159 2258 2259 -2257
		mu 0 4 1114 1115 1166 1165
		f 4 -2161 2260 2261 -2259
		mu 0 4 1115 1116 1167 1166
		f 4 -2163 2262 2263 -2261
		mu 0 4 1116 1117 1168 1167
		f 4 -2165 2264 2265 -2263
		mu 0 4 1117 1118 1169 1168
		f 4 -2167 2266 2267 -2265
		mu 0 4 1118 1119 1170 1169
		f 4 -2169 2268 2269 -2267
		mu 0 4 1119 1120 1171 1170
		f 4 -2171 2270 2271 -2269
		mu 0 4 1120 1121 1172 1171
		f 4 -2173 2272 2273 2274
		mu 0 4 1122 1123 1174 1173
		f 4 -2176 2275 2276 -2273
		mu 0 4 1123 1124 1175 1174
		f 4 -2178 2277 2278 -2276
		mu 0 4 1124 1125 1176 1175
		f 4 -2180 2279 2280 -2278
		mu 0 4 1125 1126 1177 1176
		f 4 -2182 2281 2282 -2280
		mu 0 4 1126 1127 1178 1177
		f 4 -2184 2283 2284 -2282
		mu 0 4 1127 1128 1179 1178
		f 4 -2186 2285 2286 -2284
		mu 0 4 1128 1129 1180 1179
		f 4 -2188 2287 2288 -2286
		mu 0 4 1129 1130 1181 1180
		f 4 -2190 2289 2290 -2288
		mu 0 4 1130 1131 1182 1181
		f 4 -2192 2291 2292 -2290
		mu 0 4 1131 1132 1183 1182
		f 4 -2194 2293 2294 -2292
		mu 0 4 1132 1133 1184 1183
		f 4 -2196 2295 2296 -2294
		mu 0 4 1133 1134 1185 1184
		f 4 -2198 2297 2298 -2296
		mu 0 4 1134 1135 1186 1185
		f 4 -2200 2299 2300 -2298
		mu 0 4 1135 1136 1187 1186
		f 4 -2202 2301 2302 -2300
		mu 0 4 1136 1137 1188 1187
		f 4 -2204 2303 2304 -2302
		mu 0 4 1137 1138 1189 1188
		f 4 -2206 2305 2306 -2304
		mu 0 4 1138 1139 1190 1189
		f 4 -2208 2307 2308 -2306
		mu 0 4 1139 1140 1191 1190
		f 4 -2210 2309 2310 -2308
		mu 0 4 1140 1141 1192 1191
		f 4 -2212 2311 2312 -2310
		mu 0 4 1141 1142 1193 1192
		f 4 -2214 2313 2314 -2312
		mu 0 4 1142 1143 1194 1193
		f 4 -2216 2315 2316 -2314
		mu 0 4 1143 1144 1195 1194
		f 4 -2218 2317 2318 -2316
		mu 0 4 1144 1145 1196 1195
		f 4 -2220 2319 2320 -2318
		mu 0 4 1145 1146 1197 1196
		f 4 -2222 2321 2322 -2320
		mu 0 4 1146 1147 1198 1197
		f 4 -2224 2323 2324 -2322
		mu 0 4 1147 1148 1199 1198
		f 4 -2226 2325 2326 -2324
		mu 0 4 1148 1149 1200 1199
		f 4 -2228 2327 2328 -2326
		mu 0 4 1149 1150 1201 1200
		f 4 -2230 2329 2330 -2328
		mu 0 4 1150 1151 1202 1201
		f 4 -2232 2331 2332 -2330
		mu 0 4 1151 1152 1203 1202
		f 4 -2234 2333 2334 -2332
		mu 0 4 1152 1153 1204 1203
		f 4 -2236 2335 2336 -2334
		mu 0 4 1153 1154 1205 1204
		f 4 -2238 2337 2338 -2336
		mu 0 4 1154 1155 1206 1205
		f 4 -2240 2339 2340 -2338
		mu 0 4 1155 1156 1207 1206
		f 4 -2242 2341 2342 -2340
		mu 0 4 1156 1157 1208 1207
		f 4 -2244 2343 2344 -2342
		mu 0 4 1157 1158 1209 1208
		f 4 -2246 2345 2346 -2344
		mu 0 4 1158 1159 1210 1209
		f 4 -2248 2347 2348 -2346
		mu 0 4 1159 1160 1211 1210
		f 4 -2250 2349 2350 -2348
		mu 0 4 1160 1161 1212 1211
		f 4 -2252 2351 2352 -2350
		mu 0 4 1161 1162 1213 1212
		f 4 -2254 2353 2354 -2352
		mu 0 4 1162 1163 1214 1213
		f 4 -2256 2355 2356 -2354
		mu 0 4 1163 1164 1215 1214
		f 4 -2258 2357 2358 -2356
		mu 0 4 1164 1165 1216 1215
		f 4 -2260 2359 2360 -2358
		mu 0 4 1165 1166 1217 1216
		f 4 -2262 2361 2362 -2360
		mu 0 4 1166 1167 1218 1217
		f 4 -2264 2363 2364 -2362
		mu 0 4 1167 1168 1219 1218
		f 4 -2266 2365 2366 -2364
		mu 0 4 1168 1169 1220 1219
		f 4 -2268 2367 2368 -2366
		mu 0 4 1169 1170 1221 1220
		f 4 -2270 2369 2370 -2368
		mu 0 4 1170 1171 1222 1221
		f 4 -2272 2371 2372 -2370
		mu 0 4 1171 1172 1223 1222
		f 4 -2274 2373 2374 2375
		mu 0 4 1173 1174 1225 1224
		f 4 -2277 2376 2377 -2374
		mu 0 4 1174 1175 1226 1225
		f 4 -2279 2378 2379 -2377
		mu 0 4 1175 1176 1227 1226
		f 4 -2281 2380 2381 -2379
		mu 0 4 1176 1177 1228 1227
		f 4 -2283 2382 2383 -2381
		mu 0 4 1177 1178 1229 1228
		f 4 -2285 2384 2385 -2383
		mu 0 4 1178 1179 1230 1229
		f 4 -2287 2386 2387 -2385
		mu 0 4 1179 1180 1231 1230
		f 4 -2289 2388 2389 -2387
		mu 0 4 1180 1181 1232 1231
		f 4 -2291 2390 2391 -2389
		mu 0 4 1181 1182 1233 1232
		f 4 -2293 2392 2393 -2391
		mu 0 4 1182 1183 1234 1233
		f 4 -2295 2394 2395 -2393
		mu 0 4 1183 1184 1235 1234
		f 4 -2297 2396 2397 -2395
		mu 0 4 1184 1185 1236 1235
		f 4 -2299 2398 2399 -2397
		mu 0 4 1185 1186 1237 1236
		f 4 -2301 2400 2401 -2399
		mu 0 4 1186 1187 1238 1237
		f 4 -2303 2402 2403 -2401
		mu 0 4 1187 1188 1239 1238
		f 4 -2305 2404 2405 -2403
		mu 0 4 1188 1189 1240 1239
		f 4 -2307 2406 2407 -2405
		mu 0 4 1189 1190 1241 1240
		f 4 -2309 2408 2409 -2407
		mu 0 4 1190 1191 1242 1241
		f 4 -2311 2410 2411 -2409
		mu 0 4 1191 1192 1243 1242
		f 4 -2313 2412 2413 -2411
		mu 0 4 1192 1193 1244 1243
		f 4 -2315 2414 2415 -2413
		mu 0 4 1193 1194 1245 1244
		f 4 -2317 2416 2417 -2415
		mu 0 4 1194 1195 1246 1245
		f 4 -2319 2418 2419 -2417
		mu 0 4 1195 1196 1247 1246
		f 4 -2321 2420 2421 -2419
		mu 0 4 1196 1197 1248 1247
		f 4 -2323 2422 2423 -2421
		mu 0 4 1197 1198 1249 1248
		f 4 -2325 2424 2425 -2423
		mu 0 4 1198 1199 1250 1249
		f 4 -2327 2426 2427 -2425
		mu 0 4 1199 1200 1251 1250
		f 4 -2329 2428 2429 -2427
		mu 0 4 1200 1201 1252 1251
		f 4 -2331 2430 2431 -2429
		mu 0 4 1201 1202 1253 1252
		f 4 -2333 2432 2433 -2431
		mu 0 4 1202 1203 1254 1253
		f 4 -2335 2434 2435 -2433
		mu 0 4 1203 1204 1255 1254
		f 4 -2337 2436 2437 -2435
		mu 0 4 1204 1205 1256 1255
		f 4 -2339 2438 2439 -2437
		mu 0 4 1205 1206 1257 1256
		f 4 -2341 2440 2441 -2439
		mu 0 4 1206 1207 1258 1257
		f 4 -2343 2442 2443 -2441
		mu 0 4 1207 1208 1259 1258
		f 4 -2345 2444 2445 -2443
		mu 0 4 1208 1209 1260 1259
		f 4 -2347 2446 2447 -2445
		mu 0 4 1209 1210 1261 1260
		f 4 -2349 2448 2449 -2447
		mu 0 4 1210 1211 1262 1261
		f 4 -2351 2450 2451 -2449
		mu 0 4 1211 1212 1263 1262
		f 4 -2353 2452 2453 -2451
		mu 0 4 1212 1213 1264 1263
		f 4 -2355 2454 2455 -2453
		mu 0 4 1213 1214 1265 1264
		f 4 -2357 2456 2457 -2455
		mu 0 4 1214 1215 1266 1265
		f 4 -2359 2458 2459 -2457
		mu 0 4 1215 1216 1267 1266
		f 4 -2361 2460 2461 -2459
		mu 0 4 1216 1217 1268 1267
		f 4 -2363 2462 2463 -2461
		mu 0 4 1217 1218 1269 1268
		f 4 -2365 2464 2465 -2463
		mu 0 4 1218 1219 1270 1269
		f 4 -2367 2466 2467 -2465
		mu 0 4 1219 1220 1271 1270
		f 4 -2369 2468 2469 -2467
		mu 0 4 1220 1221 1272 1271
		f 4 -2371 2470 2471 -2469
		mu 0 4 1221 1222 1273 1272
		f 4 -2373 2472 2473 -2471
		mu 0 4 1222 1223 1274 1273
		f 4 -2375 2474 2475 2476
		mu 0 4 1224 1225 1276 1275
		f 4 -2378 2477 2478 -2475
		mu 0 4 1225 1226 1277 1276
		f 4 -2380 2479 2480 -2478
		mu 0 4 1226 1227 1278 1277
		f 4 -2382 2481 2482 -2480
		mu 0 4 1227 1228 1279 1278
		f 4 -2384 2483 2484 -2482
		mu 0 4 1228 1229 1280 1279
		f 4 -2386 2485 2486 -2484
		mu 0 4 1229 1230 1281 1280
		f 4 -2388 2487 2488 -2486
		mu 0 4 1230 1231 1282 1281
		f 4 -2390 2489 2490 -2488
		mu 0 4 1231 1232 1283 1282
		f 4 -2392 2491 2492 -2490
		mu 0 4 1232 1233 1284 1283
		f 4 -2394 2493 2494 -2492
		mu 0 4 1233 1234 1285 1284
		f 4 -2396 2495 2496 -2494
		mu 0 4 1234 1235 1286 1285
		f 4 -2398 2497 2498 -2496
		mu 0 4 1235 1236 1287 1286
		f 4 -2400 2499 2500 -2498
		mu 0 4 1236 1237 1288 1287
		f 4 -2402 2501 2502 -2500
		mu 0 4 1237 1238 1289 1288
		f 4 -2404 2503 2504 -2502
		mu 0 4 1238 1239 1290 1289
		f 4 -2406 2505 2506 -2504
		mu 0 4 1239 1240 1291 1290
		f 4 -2408 2507 2508 -2506
		mu 0 4 1240 1241 1292 1291
		f 4 -2410 2509 2510 -2508
		mu 0 4 1241 1242 1293 1292
		f 4 -2412 2511 2512 -2510
		mu 0 4 1242 1243 1294 1293
		f 4 -2414 2513 2514 -2512
		mu 0 4 1243 1244 1295 1294
		f 4 -2416 2515 2516 -2514
		mu 0 4 1244 1245 1296 1295
		f 4 -2418 2517 2518 -2516
		mu 0 4 1245 1246 1297 1296
		f 4 -2420 2519 2520 -2518
		mu 0 4 1246 1247 1298 1297
		f 4 -2422 2521 2522 -2520
		mu 0 4 1247 1248 1299 1298
		f 4 -2424 2523 2524 -2522
		mu 0 4 1248 1249 1300 1299
		f 4 -2426 2525 2526 -2524
		mu 0 4 1249 1250 1301 1300
		f 4 -2428 2527 2528 -2526
		mu 0 4 1250 1251 1302 1301
		f 4 -2430 2529 2530 -2528
		mu 0 4 1251 1252 1303 1302
		f 4 -2432 2531 2532 -2530
		mu 0 4 1252 1253 1304 1303
		f 4 -2434 2533 2534 -2532
		mu 0 4 1253 1254 1305 1304
		f 4 -2436 2535 2536 -2534
		mu 0 4 1254 1255 1306 1305
		f 4 -2438 2537 2538 -2536
		mu 0 4 1255 1256 1307 1306
		f 4 -2440 2539 2540 -2538
		mu 0 4 1256 1257 1308 1307
		f 4 -2442 2541 2542 -2540
		mu 0 4 1257 1258 1309 1308
		f 4 -2444 2543 2544 -2542
		mu 0 4 1258 1259 1310 1309
		f 4 -2446 2545 2546 -2544
		mu 0 4 1259 1260 1311 1310
		f 4 -2448 2547 2548 -2546
		mu 0 4 1260 1261 1312 1311
		f 4 -2450 2549 2550 -2548
		mu 0 4 1261 1262 1313 1312
		f 4 -2452 2551 2552 -2550
		mu 0 4 1262 1263 1314 1313
		f 4 -2454 2553 2554 -2552
		mu 0 4 1263 1264 1315 1314
		f 4 -2456 2555 2556 -2554
		mu 0 4 1264 1265 1316 1315
		f 4 -2458 2557 2558 -2556
		mu 0 4 1265 1266 1317 1316
		f 4 -2460 2559 2560 -2558
		mu 0 4 1266 1267 1318 1317
		f 4 -2462 2561 2562 -2560
		mu 0 4 1267 1268 1319 1318
		f 4 -2464 2563 2564 -2562
		mu 0 4 1268 1269 1320 1319
		f 4 -2466 2565 2566 -2564
		mu 0 4 1269 1270 1321 1320
		f 4 -2468 2567 2568 -2566
		mu 0 4 1270 1271 1322 1321
		f 4 -2470 2569 2570 -2568
		mu 0 4 1271 1272 1323 1322
		f 4 -2472 2571 2572 -2570
		mu 0 4 1272 1273 1324 1323
		f 4 -2474 2573 2574 -2572
		mu 0 4 1273 1274 1325 1324
		f 4 -2476 2575 2576 2577
		mu 0 4 1275 1276 1327 1326
		f 4 -2479 2578 2579 -2576
		mu 0 4 1276 1277 1328 1327
		f 4 -2481 2580 2581 -2579
		mu 0 4 1277 1278 1329 1328
		f 4 -2483 2582 2583 -2581
		mu 0 4 1278 1279 1330 1329
		f 4 -2485 2584 2585 -2583
		mu 0 4 1279 1280 1331 1330
		f 4 -2487 2586 2587 -2585
		mu 0 4 1280 1281 1332 1331
		f 4 -2489 2588 2589 -2587
		mu 0 4 1281 1282 1333 1332
		f 4 -2491 2590 2591 -2589
		mu 0 4 1282 1283 1334 1333
		f 4 -2493 2592 2593 -2591
		mu 0 4 1283 1284 1335 1334
		f 4 -2495 2594 2595 -2593
		mu 0 4 1284 1285 1336 1335
		f 4 -2497 2596 2597 -2595
		mu 0 4 1285 1286 1337 1336
		f 4 -2499 2598 2599 -2597
		mu 0 4 1286 1287 1338 1337
		f 4 -2501 2600 2601 -2599
		mu 0 4 1287 1288 1339 1338
		f 4 -2503 2602 2603 -2601
		mu 0 4 1288 1289 1340 1339
		f 4 -2505 2604 2605 -2603
		mu 0 4 1289 1290 1341 1340
		f 4 -2507 2606 2607 -2605
		mu 0 4 1290 1291 1342 1341
		f 4 -2509 2608 2609 -2607
		mu 0 4 1291 1292 1343 1342
		f 4 -2511 2610 2611 -2609
		mu 0 4 1292 1293 1344 1343
		f 4 -2513 2612 2613 -2611
		mu 0 4 1293 1294 1345 1344
		f 4 -2515 2614 2615 -2613
		mu 0 4 1294 1295 1346 1345
		f 4 -2517 2616 2617 -2615
		mu 0 4 1295 1296 1347 1346
		f 4 -2519 2618 2619 -2617
		mu 0 4 1296 1297 1348 1347
		f 4 -2521 2620 2621 -2619
		mu 0 4 1297 1298 1349 1348
		f 4 -2523 2622 2623 -2621
		mu 0 4 1298 1299 1350 1349
		f 4 -2525 2624 2625 -2623
		mu 0 4 1299 1300 1351 1350
		f 4 -2527 2626 2627 -2625
		mu 0 4 1300 1301 1352 1351
		f 4 -2529 2628 2629 -2627
		mu 0 4 1301 1302 1353 1352
		f 4 -2531 2630 2631 -2629
		mu 0 4 1302 1303 1354 1353
		f 4 -2533 2632 2633 -2631
		mu 0 4 1303 1304 1355 1354
		f 4 -2535 2634 2635 -2633
		mu 0 4 1304 1305 1356 1355
		f 4 -2537 2636 2637 -2635
		mu 0 4 1305 1306 1357 1356
		f 4 -2539 2638 2639 -2637
		mu 0 4 1306 1307 1358 1357
		f 4 -2541 2640 2641 -2639
		mu 0 4 1307 1308 1359 1358
		f 4 -2543 2642 2643 -2641
		mu 0 4 1308 1309 1360 1359
		f 4 -2545 2644 2645 -2643
		mu 0 4 1309 1310 1361 1360
		f 4 -2547 2646 2647 -2645
		mu 0 4 1310 1311 1362 1361
		f 4 -2549 2648 2649 -2647
		mu 0 4 1311 1312 1363 1362
		f 4 -2551 2650 2651 -2649
		mu 0 4 1312 1313 1364 1363
		f 4 -2553 2652 2653 -2651
		mu 0 4 1313 1314 1365 1364
		f 4 -2555 2654 2655 -2653
		mu 0 4 1314 1315 1366 1365
		f 4 -2557 2656 2657 -2655
		mu 0 4 1315 1316 1367 1366
		f 4 -2559 2658 2659 -2657
		mu 0 4 1316 1317 1368 1367
		f 4 -2561 2660 2661 -2659
		mu 0 4 1317 1318 1369 1368
		f 4 -2563 2662 2663 -2661
		mu 0 4 1318 1319 1370 1369
		f 4 -2565 2664 2665 -2663
		mu 0 4 1319 1320 1371 1370
		f 4 -2567 2666 2667 -2665
		mu 0 4 1320 1321 1372 1371
		f 4 -2569 2668 2669 -2667
		mu 0 4 1321 1322 1373 1372
		f 4 -2571 2670 2671 -2669
		mu 0 4 1322 1323 1374 1373
		f 4 -2573 2672 2673 -2671
		mu 0 4 1323 1324 1375 1374
		f 4 -2575 2674 2675 -2673
		mu 0 4 1324 1325 1376 1375
		f 4 -2577 2676 2677 2678
		mu 0 4 1326 1327 1378 1377
		f 4 -2580 2679 2680 -2677
		mu 0 4 1327 1328 1379 1378
		f 4 -2582 2681 2682 -2680
		mu 0 4 1328 1329 1380 1379
		f 4 -2584 2683 2684 -2682
		mu 0 4 1329 1330 1381 1380
		f 4 -2586 2685 2686 -2684
		mu 0 4 1330 1331 1382 1381
		f 4 -2588 2687 2688 -2686
		mu 0 4 1331 1332 1383 1382
		f 4 -2590 2689 2690 -2688
		mu 0 4 1332 1333 1384 1383
		f 4 -2592 2691 2692 -2690
		mu 0 4 1333 1334 1385 1384
		f 4 -2594 2693 2694 -2692
		mu 0 4 1334 1335 1386 1385
		f 4 -2596 2695 2696 -2694
		mu 0 4 1335 1336 1387 1386
		f 4 -2598 2697 2698 -2696
		mu 0 4 1336 1337 1388 1387
		f 4 -2600 2699 2700 -2698
		mu 0 4 1337 1338 1389 1388
		f 4 -2602 2701 2702 -2700
		mu 0 4 1338 1339 1390 1389
		f 4 -2604 2703 2704 -2702
		mu 0 4 1339 1340 1391 1390
		f 4 -2606 2705 2706 -2704
		mu 0 4 1340 1341 1392 1391
		f 4 -2608 2707 2708 -2706
		mu 0 4 1341 1342 1393 1392
		f 4 -2610 2709 2710 -2708
		mu 0 4 1342 1343 1394 1393
		f 4 -2612 2711 2712 -2710
		mu 0 4 1343 1344 1395 1394
		f 4 -2614 2713 2714 -2712
		mu 0 4 1344 1345 1396 1395
		f 4 -2616 2715 2716 -2714
		mu 0 4 1345 1346 1397 1396
		f 4 -2618 2717 2718 -2716
		mu 0 4 1346 1347 1398 1397
		f 4 -2620 2719 2720 -2718
		mu 0 4 1347 1348 1399 1398
		f 4 -2622 2721 2722 -2720
		mu 0 4 1348 1349 1400 1399
		f 4 -2624 2723 2724 -2722
		mu 0 4 1349 1350 1401 1400
		f 4 -2626 2725 2726 -2724
		mu 0 4 1350 1351 1402 1401
		f 4 -2628 2727 2728 -2726
		mu 0 4 1351 1352 1403 1402
		f 4 -2630 2729 2730 -2728
		mu 0 4 1352 1353 1404 1403
		f 4 -2632 2731 2732 -2730
		mu 0 4 1353 1354 1405 1404
		f 4 -2634 2733 2734 -2732
		mu 0 4 1354 1355 1406 1405
		f 4 -2636 2735 2736 -2734
		mu 0 4 1355 1356 1407 1406
		f 4 -2638 2737 2738 -2736
		mu 0 4 1356 1357 1408 1407
		f 4 -2640 2739 2740 -2738
		mu 0 4 1357 1358 1409 1408
		f 4 -2642 2741 2742 -2740
		mu 0 4 1358 1359 1410 1409
		f 4 -2644 2743 2744 -2742
		mu 0 4 1359 1360 1411 1410
		f 4 -2646 2745 2746 -2744
		mu 0 4 1360 1361 1412 1411
		f 4 -2648 2747 2748 -2746
		mu 0 4 1361 1362 1413 1412
		f 4 -2650 2749 2750 -2748
		mu 0 4 1362 1363 1414 1413
		f 4 -2652 2751 2752 -2750
		mu 0 4 1363 1364 1415 1414
		f 4 -2654 2753 2754 -2752
		mu 0 4 1364 1365 1416 1415
		f 4 -2656 2755 2756 -2754
		mu 0 4 1365 1366 1417 1416
		f 4 -2658 2757 2758 -2756
		mu 0 4 1366 1367 1418 1417
		f 4 -2660 2759 2760 -2758
		mu 0 4 1367 1368 1419 1418
		f 4 -2662 2761 2762 -2760
		mu 0 4 1368 1369 1420 1419
		f 4 -2664 2763 2764 -2762
		mu 0 4 1369 1370 1421 1420
		f 4 -2666 2765 2766 -2764
		mu 0 4 1370 1371 1422 1421
		f 4 -2668 2767 2768 -2766
		mu 0 4 1371 1372 1423 1422
		f 4 -2670 2769 2770 -2768
		mu 0 4 1372 1373 1424 1423
		f 4 -2672 2771 2772 -2770
		mu 0 4 1373 1374 1425 1424
		f 4 -2674 2773 2774 -2772
		mu 0 4 1374 1375 1426 1425
		f 4 -2676 2775 2776 -2774
		mu 0 4 1375 1376 1427 1426
		f 4 -2678 2777 2778 2779
		mu 0 4 1377 1378 1429 1428
		f 4 -2681 2780 2781 -2778
		mu 0 4 1378 1379 1430 1429
		f 4 -2683 2782 2783 -2781
		mu 0 4 1379 1380 1431 1430
		f 4 -2685 2784 2785 -2783
		mu 0 4 1380 1381 1432 1431
		f 4 -2687 2786 2787 -2785
		mu 0 4 1381 1382 1433 1432
		f 4 -2689 2788 2789 -2787
		mu 0 4 1382 1383 1434 1433
		f 4 -2691 2790 2791 -2789
		mu 0 4 1383 1384 1435 1434
		f 4 -2693 2792 2793 -2791
		mu 0 4 1384 1385 1436 1435
		f 4 -2695 2794 2795 -2793
		mu 0 4 1385 1386 1437 1436
		f 4 -2697 2796 2797 -2795
		mu 0 4 1386 1387 1438 1437
		f 4 -2699 2798 2799 -2797
		mu 0 4 1387 1388 1439 1438
		f 4 -2701 2800 2801 -2799
		mu 0 4 1388 1389 1440 1439
		f 4 -2703 2802 2803 -2801
		mu 0 4 1389 1390 1441 1440
		f 4 -2705 2804 2805 -2803
		mu 0 4 1390 1391 1442 1441
		f 4 -2707 2806 2807 -2805
		mu 0 4 1391 1392 1443 1442
		f 4 -2709 2808 2809 -2807
		mu 0 4 1392 1393 1444 1443
		f 4 -2711 2810 2811 -2809
		mu 0 4 1393 1394 1445 1444
		f 4 -2713 2812 2813 -2811
		mu 0 4 1394 1395 1446 1445
		f 4 -2715 2814 2815 -2813
		mu 0 4 1395 1396 1447 1446
		f 4 -2717 2816 2817 -2815
		mu 0 4 1396 1397 1448 1447
		f 4 -2719 2818 2819 -2817
		mu 0 4 1397 1398 1449 1448
		f 4 -2721 2820 2821 -2819
		mu 0 4 1398 1399 1450 1449
		f 4 -2723 2822 2823 -2821
		mu 0 4 1399 1400 1451 1450
		f 4 -2725 2824 2825 -2823
		mu 0 4 1400 1401 1452 1451
		f 4 -2727 2826 2827 -2825
		mu 0 4 1401 1402 1453 1452
		f 4 -2729 2828 2829 -2827
		mu 0 4 1402 1403 1454 1453
		f 4 -2731 2830 2831 -2829
		mu 0 4 1403 1404 1455 1454
		f 4 -2733 2832 2833 -2831
		mu 0 4 1404 1405 1456 1455
		f 4 -2735 2834 2835 -2833
		mu 0 4 1405 1406 1457 1456
		f 4 -2737 2836 2837 -2835
		mu 0 4 1406 1407 1458 1457
		f 4 -2739 2838 2839 -2837
		mu 0 4 1407 1408 1459 1458
		f 4 -2741 2840 2841 -2839
		mu 0 4 1408 1409 1460 1459
		f 4 -2743 2842 2843 -2841
		mu 0 4 1409 1410 1461 1460
		f 4 -2745 2844 2845 -2843
		mu 0 4 1410 1411 1462 1461
		f 4 -2747 2846 2847 -2845
		mu 0 4 1411 1412 1463 1462
		f 4 -2749 2848 2849 -2847
		mu 0 4 1412 1413 1464 1463
		f 4 -2751 2850 2851 -2849
		mu 0 4 1413 1414 1465 1464
		f 4 -2753 2852 2853 -2851
		mu 0 4 1414 1415 1466 1465
		f 4 -2755 2854 2855 -2853
		mu 0 4 1415 1416 1467 1466
		f 4 -2757 2856 2857 -2855
		mu 0 4 1416 1417 1468 1467
		f 4 -2759 2858 2859 -2857
		mu 0 4 1417 1418 1469 1468
		f 4 -2761 2860 2861 -2859
		mu 0 4 1418 1419 1470 1469
		f 4 -2763 2862 2863 -2861
		mu 0 4 1419 1420 1471 1470
		f 4 -2765 2864 2865 -2863
		mu 0 4 1420 1421 1472 1471
		f 4 -2767 2866 2867 -2865
		mu 0 4 1421 1422 1473 1472
		f 4 -2769 2868 2869 -2867
		mu 0 4 1422 1423 1474 1473
		f 4 -2771 2870 2871 -2869
		mu 0 4 1423 1424 1475 1474
		f 4 -2773 2872 2873 -2871
		mu 0 4 1424 1425 1476 1475
		f 4 -2775 2874 2875 -2873
		mu 0 4 1425 1426 1477 1476
		f 4 -2777 2876 2877 -2875
		mu 0 4 1426 1427 1478 1477
		f 4 -2779 2878 2879 2880
		mu 0 4 1428 1429 1480 1479
		f 4 -2782 2881 2882 -2879
		mu 0 4 1429 1430 1481 1480
		f 4 -2784 2883 2884 -2882
		mu 0 4 1430 1431 1482 1481
		f 4 -2786 2885 2886 -2884
		mu 0 4 1431 1432 1483 1482
		f 4 -2788 2887 2888 -2886
		mu 0 4 1432 1433 1484 1483
		f 4 -2790 2889 2890 -2888
		mu 0 4 1433 1434 1485 1484
		f 4 -2792 2891 2892 -2890
		mu 0 4 1434 1435 1486 1485
		f 4 -2794 2893 2894 -2892
		mu 0 4 1435 1436 1487 1486
		f 4 -2796 2895 2896 -2894
		mu 0 4 1436 1437 1488 1487
		f 4 -2798 2897 2898 -2896
		mu 0 4 1437 1438 1489 1488
		f 4 -2800 2899 2900 -2898
		mu 0 4 1438 1439 1490 1489
		f 4 -2802 2901 2902 -2900
		mu 0 4 1439 1440 1491 1490
		f 4 -2804 2903 2904 -2902
		mu 0 4 1440 1441 1492 1491
		f 4 -2806 2905 2906 -2904
		mu 0 4 1441 1442 1493 1492
		f 4 -2808 2907 2908 -2906
		mu 0 4 1442 1443 1494 1493
		f 4 -2810 2909 2910 -2908
		mu 0 4 1443 1444 1495 1494
		f 4 -2812 2911 2912 -2910
		mu 0 4 1444 1445 1496 1495
		f 4 -2814 2913 2914 -2912
		mu 0 4 1445 1446 1497 1496
		f 4 -2816 2915 2916 -2914
		mu 0 4 1446 1447 1498 1497
		f 4 -2818 2917 2918 -2916
		mu 0 4 1447 1448 1499 1498
		f 4 -2820 2919 2920 -2918
		mu 0 4 1448 1449 1500 1499
		f 4 -2822 2921 2922 -2920
		mu 0 4 1449 1450 1501 1500
		f 4 -2824 2923 2924 -2922
		mu 0 4 1450 1451 1502 1501
		f 4 -2826 2925 2926 -2924
		mu 0 4 1451 1452 1503 1502
		f 4 -2828 2927 2928 -2926
		mu 0 4 1452 1453 1504 1503
		f 4 -2830 2929 2930 -2928
		mu 0 4 1453 1454 1505 1504
		f 4 -2832 2931 2932 -2930
		mu 0 4 1454 1455 1506 1505
		f 4 -2834 2933 2934 -2932
		mu 0 4 1455 1456 1507 1506
		f 4 -2836 2935 2936 -2934
		mu 0 4 1456 1457 1508 1507
		f 4 -2838 2937 2938 -2936
		mu 0 4 1457 1458 1509 1508
		f 4 -2840 2939 2940 -2938
		mu 0 4 1458 1459 1510 1509
		f 4 -2842 2941 2942 -2940
		mu 0 4 1459 1460 1511 1510
		f 4 -2844 2943 2944 -2942
		mu 0 4 1460 1461 1512 1511
		f 4 -2846 2945 2946 -2944
		mu 0 4 1461 1462 1513 1512
		f 4 -2848 2947 2948 -2946
		mu 0 4 1462 1463 1514 1513
		f 4 -2850 2949 2950 -2948
		mu 0 4 1463 1464 1515 1514
		f 4 -2852 2951 2952 -2950
		mu 0 4 1464 1465 1516 1515
		f 4 -2854 2953 2954 -2952
		mu 0 4 1465 1466 1517 1516
		f 4 -2856 2955 2956 -2954
		mu 0 4 1466 1467 1518 1517
		f 4 -2858 2957 2958 -2956
		mu 0 4 1467 1468 1519 1518
		f 4 -2860 2959 2960 -2958
		mu 0 4 1468 1469 1520 1519
		f 4 -2862 2961 2962 -2960
		mu 0 4 1469 1470 1521 1520
		f 4 -2864 2963 2964 -2962
		mu 0 4 1470 1471 1522 1521
		f 4 -2866 2965 2966 -2964
		mu 0 4 1471 1472 1523 1522
		f 4 -2868 2967 2968 -2966
		mu 0 4 1472 1473 1524 1523
		f 4 -2870 2969 2970 -2968
		mu 0 4 1473 1474 1525 1524
		f 4 -2872 2971 2972 -2970
		mu 0 4 1474 1475 1526 1525
		f 4 -2874 2973 2974 -2972
		mu 0 4 1475 1476 1527 1526
		f 4 -2876 2975 2976 -2974
		mu 0 4 1476 1477 1528 1527
		f 4 -2878 2977 2978 -2976
		mu 0 4 1477 1478 1529 1528
		f 4 -2880 2979 2980 2981
		mu 0 4 1479 1480 1531 1530
		f 4 -2883 2982 2983 -2980
		mu 0 4 1480 1481 1532 1531
		f 4 -2885 2984 2985 -2983
		mu 0 4 1481 1482 1533 1532
		f 4 -2887 2986 2987 -2985
		mu 0 4 1482 1483 1534 1533
		f 4 -2889 2988 2989 -2987
		mu 0 4 1483 1484 1535 1534
		f 4 -2891 2990 2991 -2989
		mu 0 4 1484 1485 1536 1535
		f 4 -2893 2992 2993 -2991
		mu 0 4 1485 1486 1537 1536
		f 4 -2895 2994 2995 -2993
		mu 0 4 1486 1487 1538 1537
		f 4 -2897 2996 2997 -2995
		mu 0 4 1487 1488 1539 1538
		f 4 -2899 2998 2999 -2997
		mu 0 4 1488 1489 1540 1539
		f 4 -2901 3000 3001 -2999
		mu 0 4 1489 1490 1541 1540
		f 4 -2903 3002 3003 -3001
		mu 0 4 1490 1491 1542 1541
		f 4 -2905 3004 3005 -3003
		mu 0 4 1491 1492 1543 1542
		f 4 -2907 3006 3007 -3005
		mu 0 4 1492 1493 1544 1543
		f 4 -2909 3008 3009 -3007
		mu 0 4 1493 1494 1545 1544
		f 4 -2911 3010 3011 -3009
		mu 0 4 1494 1495 1546 1545
		f 4 -2913 3012 3013 -3011
		mu 0 4 1495 1496 1547 1546
		f 4 -2915 3014 3015 -3013
		mu 0 4 1496 1497 1548 1547
		f 4 -2917 3016 3017 -3015
		mu 0 4 1497 1498 1549 1548
		f 4 -2919 3018 3019 -3017
		mu 0 4 1498 1499 1550 1549
		f 4 -2921 3020 3021 -3019
		mu 0 4 1499 1500 1551 1550
		f 4 -2923 3022 3023 -3021
		mu 0 4 1500 1501 1552 1551
		f 4 -2925 3024 3025 -3023
		mu 0 4 1501 1502 1553 1552
		f 4 -2927 3026 3027 -3025
		mu 0 4 1502 1503 1554 1553
		f 4 -2929 3028 3029 -3027
		mu 0 4 1503 1504 1555 1554
		f 4 -2931 3030 3031 -3029
		mu 0 4 1504 1505 1556 1555
		f 4 -2933 3032 3033 -3031
		mu 0 4 1505 1506 1557 1556
		f 4 -2935 3034 3035 -3033
		mu 0 4 1506 1507 1558 1557
		f 4 -2937 3036 3037 -3035
		mu 0 4 1507 1508 1559 1558
		f 4 -2939 3038 3039 -3037
		mu 0 4 1508 1509 1560 1559
		f 4 -2941 3040 3041 -3039
		mu 0 4 1509 1510 1561 1560
		f 4 -2943 3042 3043 -3041
		mu 0 4 1510 1511 1562 1561
		f 4 -2945 3044 3045 -3043
		mu 0 4 1511 1512 1563 1562
		f 4 -2947 3046 3047 -3045
		mu 0 4 1512 1513 1564 1563
		f 4 -2949 3048 3049 -3047
		mu 0 4 1513 1514 1565 1564
		f 4 -2951 3050 3051 -3049
		mu 0 4 1514 1515 1566 1565
		f 4 -2953 3052 3053 -3051
		mu 0 4 1515 1516 1567 1566
		f 4 -2955 3054 3055 -3053
		mu 0 4 1516 1517 1568 1567
		f 4 -2957 3056 3057 -3055
		mu 0 4 1517 1518 1569 1568
		f 4 -2959 3058 3059 -3057
		mu 0 4 1518 1519 1570 1569
		f 4 -2961 3060 3061 -3059
		mu 0 4 1519 1520 1571 1570
		f 4 -2963 3062 3063 -3061
		mu 0 4 1520 1521 1572 1571
		f 4 -2965 3064 3065 -3063
		mu 0 4 1521 1522 1573 1572
		f 4 -2967 3066 3067 -3065
		mu 0 4 1522 1523 1574 1573
		f 4 -2969 3068 3069 -3067
		mu 0 4 1523 1524 1575 1574
		f 4 -2971 3070 3071 -3069
		mu 0 4 1524 1525 1576 1575
		f 4 -2973 3072 3073 -3071
		mu 0 4 1525 1526 1577 1576
		f 4 -2975 3074 3075 -3073
		mu 0 4 1526 1527 1578 1577
		f 4 -2977 3076 3077 -3075
		mu 0 4 1527 1528 1579 1578
		f 4 -2979 3078 3079 -3077
		mu 0 4 1528 1529 1580 1579;
	setAttr ".fc[1500:1999]"
		f 4 -2981 3080 3081 3082
		mu 0 4 1530 1531 1582 1581
		f 4 -2984 3083 3084 -3081
		mu 0 4 1531 1532 1583 1582
		f 4 -2986 3085 3086 -3084
		mu 0 4 1532 1533 1584 1583
		f 4 -2988 3087 3088 -3086
		mu 0 4 1533 1534 1585 1584
		f 4 -2990 3089 3090 -3088
		mu 0 4 1534 1535 1586 1585
		f 4 -2992 3091 3092 -3090
		mu 0 4 1535 1536 1587 1586
		f 4 -2994 3093 3094 -3092
		mu 0 4 1536 1537 1588 1587
		f 4 -2996 3095 3096 -3094
		mu 0 4 1537 1538 1589 1588
		f 4 -2998 3097 3098 -3096
		mu 0 4 1538 1539 1590 1589
		f 4 -3000 3099 3100 -3098
		mu 0 4 1539 1540 1591 1590
		f 4 -3002 3101 3102 -3100
		mu 0 4 1540 1541 1592 1591
		f 4 -3004 3103 3104 -3102
		mu 0 4 1541 1542 1593 1592
		f 4 -3006 3105 3106 -3104
		mu 0 4 1542 1543 1594 1593
		f 4 -3008 3107 3108 -3106
		mu 0 4 1543 1544 1595 1594
		f 4 -3010 3109 3110 -3108
		mu 0 4 1544 1545 1596 1595
		f 4 -3012 3111 3112 -3110
		mu 0 4 1545 1546 1597 1596
		f 4 -3014 3113 3114 -3112
		mu 0 4 1546 1547 1598 1597
		f 4 -3016 3115 3116 -3114
		mu 0 4 1547 1548 1599 1598
		f 4 -3018 3117 3118 -3116
		mu 0 4 1548 1549 1600 1599
		f 4 -3020 3119 3120 -3118
		mu 0 4 1549 1550 1601 1600
		f 4 -3022 3121 3122 -3120
		mu 0 4 1550 1551 1602 1601
		f 4 -3024 3123 3124 -3122
		mu 0 4 1551 1552 1603 1602
		f 4 -3026 3125 3126 -3124
		mu 0 4 1552 1553 1604 1603
		f 4 -3028 3127 3128 -3126
		mu 0 4 1553 1554 1605 1604
		f 4 -3030 3129 3130 -3128
		mu 0 4 1554 1555 1606 1605
		f 4 -3032 3131 3132 -3130
		mu 0 4 1555 1556 1607 1606
		f 4 -3034 3133 3134 -3132
		mu 0 4 1556 1557 1608 1607
		f 4 -3036 3135 3136 -3134
		mu 0 4 1557 1558 1609 1608
		f 4 -3038 3137 3138 -3136
		mu 0 4 1558 1559 1610 1609
		f 4 -3040 3139 3140 -3138
		mu 0 4 1559 1560 1611 1610
		f 4 -3042 3141 3142 -3140
		mu 0 4 1560 1561 1612 1611
		f 4 -3044 3143 3144 -3142
		mu 0 4 1561 1562 1613 1612
		f 4 -3046 3145 3146 -3144
		mu 0 4 1562 1563 1614 1613
		f 4 -3048 3147 3148 -3146
		mu 0 4 1563 1564 1615 1614
		f 4 -3050 3149 3150 -3148
		mu 0 4 1564 1565 1616 1615
		f 4 -3052 3151 3152 -3150
		mu 0 4 1565 1566 1617 1616
		f 4 -3054 3153 3154 -3152
		mu 0 4 1566 1567 1618 1617
		f 4 -3056 3155 3156 -3154
		mu 0 4 1567 1568 1619 1618
		f 4 -3058 3157 3158 -3156
		mu 0 4 1568 1569 1620 1619
		f 4 -3060 3159 3160 -3158
		mu 0 4 1569 1570 1621 1620
		f 4 -3062 3161 3162 -3160
		mu 0 4 1570 1571 1622 1621
		f 4 -3064 3163 3164 -3162
		mu 0 4 1571 1572 1623 1622
		f 4 -3066 3165 3166 -3164
		mu 0 4 1572 1573 1624 1623
		f 4 -3068 3167 3168 -3166
		mu 0 4 1573 1574 1625 1624
		f 4 -3070 3169 3170 -3168
		mu 0 4 1574 1575 1626 1625
		f 4 -3072 3171 3172 -3170
		mu 0 4 1575 1576 1627 1626
		f 4 -3074 3173 3174 -3172
		mu 0 4 1576 1577 1628 1627
		f 4 -3076 3175 3176 -3174
		mu 0 4 1577 1578 1629 1628
		f 4 -3078 3177 3178 -3176
		mu 0 4 1578 1579 1630 1629
		f 4 -3080 3179 3180 -3178
		mu 0 4 1579 1580 1631 1630
		f 4 -3082 3181 3182 3183
		mu 0 4 1581 1582 1633 1632
		f 4 -3085 3184 3185 -3182
		mu 0 4 1582 1583 1634 1633
		f 4 -3087 3186 3187 -3185
		mu 0 4 1583 1584 1635 1634
		f 4 -3089 3188 3189 -3187
		mu 0 4 1584 1585 1636 1635
		f 4 -3091 3190 3191 -3189
		mu 0 4 1585 1586 1637 1636
		f 4 -3093 3192 3193 -3191
		mu 0 4 1586 1587 1638 1637
		f 4 -3095 3194 3195 -3193
		mu 0 4 1587 1588 1639 1638
		f 4 -3097 3196 3197 -3195
		mu 0 4 1588 1589 1640 1639
		f 4 -3099 3198 3199 -3197
		mu 0 4 1589 1590 1641 1640
		f 4 -3101 3200 3201 -3199
		mu 0 4 1590 1591 1642 1641
		f 4 -3103 3202 3203 -3201
		mu 0 4 1591 1592 1643 1642
		f 4 -3105 3204 3205 -3203
		mu 0 4 1592 1593 1644 1643
		f 4 -3107 3206 3207 -3205
		mu 0 4 1593 1594 1645 1644
		f 4 -3109 3208 3209 -3207
		mu 0 4 1594 1595 1646 1645
		f 4 -3111 3210 3211 -3209
		mu 0 4 1595 1596 1647 1646
		f 4 -3113 3212 3213 -3211
		mu 0 4 1596 1597 1648 1647
		f 4 -3115 3214 3215 -3213
		mu 0 4 1597 1598 1649 1648
		f 4 -3117 3216 3217 -3215
		mu 0 4 1598 1599 1650 1649
		f 4 -3119 3218 3219 -3217
		mu 0 4 1599 1600 1651 1650
		f 4 -3121 3220 3221 -3219
		mu 0 4 1600 1601 1652 1651
		f 4 -3123 3222 3223 -3221
		mu 0 4 1601 1602 1653 1652
		f 4 -3125 3224 3225 -3223
		mu 0 4 1602 1603 1654 1653
		f 4 -3127 3226 3227 -3225
		mu 0 4 1603 1604 1655 1654
		f 4 -3129 3228 3229 -3227
		mu 0 4 1604 1605 1656 1655
		f 4 -3131 3230 3231 -3229
		mu 0 4 1605 1606 1657 1656
		f 4 -3133 3232 3233 -3231
		mu 0 4 1606 1607 1658 1657
		f 4 -3135 3234 3235 -3233
		mu 0 4 1607 1608 1659 1658
		f 4 -3137 3236 3237 -3235
		mu 0 4 1608 1609 1660 1659
		f 4 -3139 3238 3239 -3237
		mu 0 4 1609 1610 1661 1660
		f 4 -3141 3240 3241 -3239
		mu 0 4 1610 1611 1662 1661
		f 4 -3143 3242 3243 -3241
		mu 0 4 1611 1612 1663 1662
		f 4 -3145 3244 3245 -3243
		mu 0 4 1612 1613 1664 1663
		f 4 -3147 3246 3247 -3245
		mu 0 4 1613 1614 1665 1664
		f 4 -3149 3248 3249 -3247
		mu 0 4 1614 1615 1666 1665
		f 4 -3151 3250 3251 -3249
		mu 0 4 1615 1616 1667 1666
		f 4 -3153 3252 3253 -3251
		mu 0 4 1616 1617 1668 1667
		f 4 -3155 3254 3255 -3253
		mu 0 4 1617 1618 1669 1668
		f 4 -3157 3256 3257 -3255
		mu 0 4 1618 1619 1670 1669
		f 4 -3159 3258 3259 -3257
		mu 0 4 1619 1620 1671 1670
		f 4 -3161 3260 3261 -3259
		mu 0 4 1620 1621 1672 1671
		f 4 -3163 3262 3263 -3261
		mu 0 4 1621 1622 1673 1672
		f 4 -3165 3264 3265 -3263
		mu 0 4 1622 1623 1674 1673
		f 4 -3167 3266 3267 -3265
		mu 0 4 1623 1624 1675 1674
		f 4 -3169 3268 3269 -3267
		mu 0 4 1624 1625 1676 1675
		f 4 -3171 3270 3271 -3269
		mu 0 4 1625 1626 1677 1676
		f 4 -3173 3272 3273 -3271
		mu 0 4 1626 1627 1678 1677
		f 4 -3175 3274 3275 -3273
		mu 0 4 1627 1628 1679 1678
		f 4 -3177 3276 3277 -3275
		mu 0 4 1628 1629 1680 1679
		f 4 -3179 3278 3279 -3277
		mu 0 4 1629 1630 1681 1680
		f 4 -3181 3280 3281 -3279
		mu 0 4 1630 1631 1682 1681
		f 4 -3183 3282 3283 3284
		mu 0 4 1632 1633 1684 1683
		f 4 -3186 3285 3286 -3283
		mu 0 4 1633 1634 1685 1684
		f 4 -3188 3287 3288 -3286
		mu 0 4 1634 1635 1686 1685
		f 4 -3190 3289 3290 -3288
		mu 0 4 1635 1636 1687 1686
		f 4 -3192 3291 3292 -3290
		mu 0 4 1636 1637 1688 1687
		f 4 -3194 3293 3294 -3292
		mu 0 4 1637 1638 1689 1688
		f 4 -3196 3295 3296 -3294
		mu 0 4 1638 1639 1690 1689
		f 4 -3198 3297 3298 -3296
		mu 0 4 1639 1640 1691 1690
		f 4 -3200 3299 3300 -3298
		mu 0 4 1640 1641 1692 1691
		f 4 -3202 3301 3302 -3300
		mu 0 4 1641 1642 1693 1692
		f 4 -3204 3303 3304 -3302
		mu 0 4 1642 1643 1694 1693
		f 4 -3206 3305 3306 -3304
		mu 0 4 1643 1644 1695 1694
		f 4 -3208 3307 3308 -3306
		mu 0 4 1644 1645 1696 1695
		f 4 -3210 3309 3310 -3308
		mu 0 4 1645 1646 1697 1696
		f 4 -3212 3311 3312 -3310
		mu 0 4 1646 1647 1698 1697
		f 4 -3214 3313 3314 -3312
		mu 0 4 1647 1648 1699 1698
		f 4 -3216 3315 3316 -3314
		mu 0 4 1648 1649 1700 1699
		f 4 -3218 3317 3318 -3316
		mu 0 4 1649 1650 1701 1700
		f 4 -3220 3319 3320 -3318
		mu 0 4 1650 1651 1702 1701
		f 4 -3222 3321 3322 -3320
		mu 0 4 1651 1652 1703 1702
		f 4 -3224 3323 3324 -3322
		mu 0 4 1652 1653 1704 1703
		f 4 -3226 3325 3326 -3324
		mu 0 4 1653 1654 1705 1704
		f 4 -3228 3327 3328 -3326
		mu 0 4 1654 1655 1706 1705
		f 4 -3230 3329 3330 -3328
		mu 0 4 1655 1656 1707 1706
		f 4 -3232 3331 3332 -3330
		mu 0 4 1656 1657 1708 1707
		f 4 -3234 3333 3334 -3332
		mu 0 4 1657 1658 1709 1708
		f 4 -3236 3335 3336 -3334
		mu 0 4 1658 1659 1710 1709
		f 4 -3238 3337 3338 -3336
		mu 0 4 1659 1660 1711 1710
		f 4 -3240 3339 3340 -3338
		mu 0 4 1660 1661 1712 1711
		f 4 -3242 3341 3342 -3340
		mu 0 4 1661 1662 1713 1712
		f 4 -3244 3343 3344 -3342
		mu 0 4 1662 1663 1714 1713
		f 4 -3246 3345 3346 -3344
		mu 0 4 1663 1664 1715 1714
		f 4 -3248 3347 3348 -3346
		mu 0 4 1664 1665 1716 1715
		f 4 -3250 3349 3350 -3348
		mu 0 4 1665 1666 1717 1716
		f 4 -3252 3351 3352 -3350
		mu 0 4 1666 1667 1718 1717
		f 4 -3254 3353 3354 -3352
		mu 0 4 1667 1668 1719 1718
		f 4 -3256 3355 3356 -3354
		mu 0 4 1668 1669 1720 1719
		f 4 -3258 3357 3358 -3356
		mu 0 4 1669 1670 1721 1720
		f 4 -3260 3359 3360 -3358
		mu 0 4 1670 1671 1722 1721
		f 4 -3262 3361 3362 -3360
		mu 0 4 1671 1672 1723 1722
		f 4 -3264 3363 3364 -3362
		mu 0 4 1672 1673 1724 1723
		f 4 -3266 3365 3366 -3364
		mu 0 4 1673 1674 1725 1724
		f 4 -3268 3367 3368 -3366
		mu 0 4 1674 1675 1726 1725
		f 4 -3270 3369 3370 -3368
		mu 0 4 1675 1676 1727 1726
		f 4 -3272 3371 3372 -3370
		mu 0 4 1676 1677 1728 1727
		f 4 -3274 3373 3374 -3372
		mu 0 4 1677 1678 1729 1728
		f 4 -3276 3375 3376 -3374
		mu 0 4 1678 1679 1730 1729
		f 4 -3278 3377 3378 -3376
		mu 0 4 1679 1680 1731 1730
		f 4 -3280 3379 3380 -3378
		mu 0 4 1680 1681 1732 1731
		f 4 -3282 3381 3382 -3380
		mu 0 4 1681 1682 1733 1732
		f 4 -3284 3383 3384 3385
		mu 0 4 1683 1684 1735 1734
		f 4 -3287 3386 3387 -3384
		mu 0 4 1684 1685 1736 1735
		f 4 -3289 3388 3389 -3387
		mu 0 4 1685 1686 1737 1736
		f 4 -3291 3390 3391 -3389
		mu 0 4 1686 1687 1738 1737
		f 4 -3293 3392 3393 -3391
		mu 0 4 1687 1688 1739 1738
		f 4 -3295 3394 3395 -3393
		mu 0 4 1688 1689 1740 1739
		f 4 -3297 3396 3397 -3395
		mu 0 4 1689 1690 1741 1740
		f 4 -3299 3398 3399 -3397
		mu 0 4 1690 1691 1742 1741
		f 4 -3301 3400 3401 -3399
		mu 0 4 1691 1692 1743 1742
		f 4 -3303 3402 3403 -3401
		mu 0 4 1692 1693 1744 1743
		f 4 -3305 3404 3405 -3403
		mu 0 4 1693 1694 1745 1744
		f 4 -3307 3406 3407 -3405
		mu 0 4 1694 1695 1746 1745
		f 4 -3309 3408 3409 -3407
		mu 0 4 1695 1696 1747 1746
		f 4 -3311 3410 3411 -3409
		mu 0 4 1696 1697 1748 1747
		f 4 -3313 3412 3413 -3411
		mu 0 4 1697 1698 1749 1748
		f 4 -3315 3414 3415 -3413
		mu 0 4 1698 1699 1750 1749
		f 4 -3317 3416 3417 -3415
		mu 0 4 1699 1700 1751 1750
		f 4 -3319 3418 3419 -3417
		mu 0 4 1700 1701 1752 1751
		f 4 -3321 3420 3421 -3419
		mu 0 4 1701 1702 1753 1752
		f 4 -3323 3422 3423 -3421
		mu 0 4 1702 1703 1754 1753
		f 4 -3325 3424 3425 -3423
		mu 0 4 1703 1704 1755 1754
		f 4 -3327 3426 3427 -3425
		mu 0 4 1704 1705 1756 1755
		f 4 -3329 3428 3429 -3427
		mu 0 4 1705 1706 1757 1756
		f 4 -3331 3430 3431 -3429
		mu 0 4 1706 1707 1758 1757
		f 4 -3333 3432 3433 -3431
		mu 0 4 1707 1708 1759 1758
		f 4 -3335 3434 3435 -3433
		mu 0 4 1708 1709 1760 1759
		f 4 -3337 3436 3437 -3435
		mu 0 4 1709 1710 1761 1760
		f 4 -3339 3438 3439 -3437
		mu 0 4 1710 1711 1762 1761
		f 4 -3341 3440 3441 -3439
		mu 0 4 1711 1712 1763 1762
		f 4 -3343 3442 3443 -3441
		mu 0 4 1712 1713 1764 1763
		f 4 -3345 3444 3445 -3443
		mu 0 4 1713 1714 1765 1764
		f 4 -3347 3446 3447 -3445
		mu 0 4 1714 1715 1766 1765
		f 4 -3349 3448 3449 -3447
		mu 0 4 1715 1716 1767 1766
		f 4 -3351 3450 3451 -3449
		mu 0 4 1716 1717 1768 1767
		f 4 -3353 3452 3453 -3451
		mu 0 4 1717 1718 1769 1768
		f 4 -3355 3454 3455 -3453
		mu 0 4 1718 1719 1770 1769
		f 4 -3357 3456 3457 -3455
		mu 0 4 1719 1720 1771 1770
		f 4 -3359 3458 3459 -3457
		mu 0 4 1720 1721 1772 1771
		f 4 -3361 3460 3461 -3459
		mu 0 4 1721 1722 1773 1772
		f 4 -3363 3462 3463 -3461
		mu 0 4 1722 1723 1774 1773
		f 4 -3365 3464 3465 -3463
		mu 0 4 1723 1724 1775 1774
		f 4 -3367 3466 3467 -3465
		mu 0 4 1724 1725 1776 1775
		f 4 -3369 3468 3469 -3467
		mu 0 4 1725 1726 1777 1776
		f 4 -3371 3470 3471 -3469
		mu 0 4 1726 1727 1778 1777
		f 4 -3373 3472 3473 -3471
		mu 0 4 1727 1728 1779 1778
		f 4 -3375 3474 3475 -3473
		mu 0 4 1728 1729 1780 1779
		f 4 -3377 3476 3477 -3475
		mu 0 4 1729 1730 1781 1780
		f 4 -3379 3478 3479 -3477
		mu 0 4 1730 1731 1782 1781
		f 4 -3381 3480 3481 -3479
		mu 0 4 1731 1732 1783 1782
		f 4 -3383 3482 3483 -3481
		mu 0 4 1732 1733 1784 1783
		f 4 -3385 3484 3485 3486
		mu 0 4 1734 1735 1786 1785
		f 4 -3388 3487 3488 -3485
		mu 0 4 1735 1736 1787 1786
		f 4 -3390 3489 3490 -3488
		mu 0 4 1736 1737 1788 1787
		f 4 -3392 3491 3492 -3490
		mu 0 4 1737 1738 1789 1788
		f 4 -3394 3493 3494 -3492
		mu 0 4 1738 1739 1790 1789
		f 4 -3396 3495 3496 -3494
		mu 0 4 1739 1740 1791 1790
		f 4 -3398 3497 3498 -3496
		mu 0 4 1740 1741 1792 1791
		f 4 -3400 3499 3500 -3498
		mu 0 4 1741 1742 1793 1792
		f 4 -3402 3501 3502 -3500
		mu 0 4 1742 1743 1794 1793
		f 4 -3404 3503 3504 -3502
		mu 0 4 1743 1744 1795 1794
		f 4 -3406 3505 3506 -3504
		mu 0 4 1744 1745 1796 1795
		f 4 -3408 3507 3508 -3506
		mu 0 4 1745 1746 1797 1796
		f 4 -3410 3509 3510 -3508
		mu 0 4 1746 1747 1798 1797
		f 4 -3412 3511 3512 -3510
		mu 0 4 1747 1748 1799 1798
		f 4 -3414 3513 3514 -3512
		mu 0 4 1748 1749 1800 1799
		f 4 -3416 3515 3516 -3514
		mu 0 4 1749 1750 1801 1800
		f 4 -3418 3517 3518 -3516
		mu 0 4 1750 1751 1802 1801
		f 4 -3420 3519 3520 -3518
		mu 0 4 1751 1752 1803 1802
		f 4 -3422 3521 3522 -3520
		mu 0 4 1752 1753 1804 1803
		f 4 -3424 3523 3524 -3522
		mu 0 4 1753 1754 1805 1804
		f 4 -3426 3525 3526 -3524
		mu 0 4 1754 1755 1806 1805
		f 4 -3428 3527 3528 -3526
		mu 0 4 1755 1756 1807 1806
		f 4 -3430 3529 3530 -3528
		mu 0 4 1756 1757 1808 1807
		f 4 -3432 3531 3532 -3530
		mu 0 4 1757 1758 1809 1808
		f 4 -3434 3533 3534 -3532
		mu 0 4 1758 1759 1810 1809
		f 4 -3436 3535 3536 -3534
		mu 0 4 1759 1760 1811 1810
		f 4 -3438 3537 3538 -3536
		mu 0 4 1760 1761 1812 1811
		f 4 -3440 3539 3540 -3538
		mu 0 4 1761 1762 1813 1812
		f 4 -3442 3541 3542 -3540
		mu 0 4 1762 1763 1814 1813
		f 4 -3444 3543 3544 -3542
		mu 0 4 1763 1764 1815 1814
		f 4 -3446 3545 3546 -3544
		mu 0 4 1764 1765 1816 1815
		f 4 -3448 3547 3548 -3546
		mu 0 4 1765 1766 1817 1816
		f 4 -3450 3549 3550 -3548
		mu 0 4 1766 1767 1818 1817
		f 4 -3452 3551 3552 -3550
		mu 0 4 1767 1768 1819 1818
		f 4 -3454 3553 3554 -3552
		mu 0 4 1768 1769 1820 1819
		f 4 -3456 3555 3556 -3554
		mu 0 4 1769 1770 1821 1820
		f 4 -3458 3557 3558 -3556
		mu 0 4 1770 1771 1822 1821
		f 4 -3460 3559 3560 -3558
		mu 0 4 1771 1772 1823 1822
		f 4 -3462 3561 3562 -3560
		mu 0 4 1772 1773 1824 1823
		f 4 -3464 3563 3564 -3562
		mu 0 4 1773 1774 1825 1824
		f 4 -3466 3565 3566 -3564
		mu 0 4 1774 1775 1826 1825
		f 4 -3468 3567 3568 -3566
		mu 0 4 1775 1776 1827 1826
		f 4 -3470 3569 3570 -3568
		mu 0 4 1776 1777 1828 1827
		f 4 -3472 3571 3572 -3570
		mu 0 4 1777 1778 1829 1828
		f 4 -3474 3573 3574 -3572
		mu 0 4 1778 1779 1830 1829
		f 4 -3476 3575 3576 -3574
		mu 0 4 1779 1780 1831 1830
		f 4 -3478 3577 3578 -3576
		mu 0 4 1780 1781 1832 1831
		f 4 -3480 3579 3580 -3578
		mu 0 4 1781 1782 1833 1832
		f 4 -3482 3581 3582 -3580
		mu 0 4 1782 1783 1834 1833
		f 4 -3484 3583 3584 -3582
		mu 0 4 1783 1784 1835 1834
		f 4 -3486 3585 3586 3587
		mu 0 4 1785 1786 1837 1836
		f 4 -3489 3588 3589 -3586
		mu 0 4 1786 1787 1838 1837
		f 4 -3491 3590 3591 -3589
		mu 0 4 1787 1788 1839 1838
		f 4 -3493 3592 3593 -3591
		mu 0 4 1788 1789 1840 1839
		f 4 -3495 3594 3595 -3593
		mu 0 4 1789 1790 1841 1840
		f 4 -3497 3596 3597 -3595
		mu 0 4 1790 1791 1842 1841
		f 4 -3499 3598 3599 -3597
		mu 0 4 1791 1792 1843 1842
		f 4 -3501 3600 3601 -3599
		mu 0 4 1792 1793 1844 1843
		f 4 -3503 3602 3603 -3601
		mu 0 4 1793 1794 1845 1844
		f 4 -3505 3604 3605 -3603
		mu 0 4 1794 1795 1846 1845
		f 4 -3507 3606 3607 -3605
		mu 0 4 1795 1796 1847 1846
		f 4 -3509 3608 3609 -3607
		mu 0 4 1796 1797 1848 1847
		f 4 -3511 3610 3611 -3609
		mu 0 4 1797 1798 1849 1848
		f 4 -3513 3612 3613 -3611
		mu 0 4 1798 1799 1850 1849
		f 4 -3515 3614 3615 -3613
		mu 0 4 1799 1800 1851 1850
		f 4 -3517 3616 3617 -3615
		mu 0 4 1800 1801 1852 1851
		f 4 -3519 3618 3619 -3617
		mu 0 4 1801 1802 1853 1852
		f 4 -3521 3620 3621 -3619
		mu 0 4 1802 1803 1854 1853
		f 4 -3523 3622 3623 -3621
		mu 0 4 1803 1804 1855 1854
		f 4 -3525 3624 3625 -3623
		mu 0 4 1804 1805 1856 1855
		f 4 -3527 3626 3627 -3625
		mu 0 4 1805 1806 1857 1856
		f 4 -3529 3628 3629 -3627
		mu 0 4 1806 1807 1858 1857
		f 4 -3531 3630 3631 -3629
		mu 0 4 1807 1808 1859 1858
		f 4 -3533 3632 3633 -3631
		mu 0 4 1808 1809 1860 1859
		f 4 -3535 3634 3635 -3633
		mu 0 4 1809 1810 1861 1860
		f 4 -3537 3636 3637 -3635
		mu 0 4 1810 1811 1862 1861
		f 4 -3539 3638 3639 -3637
		mu 0 4 1811 1812 1863 1862
		f 4 -3541 3640 3641 -3639
		mu 0 4 1812 1813 1864 1863
		f 4 -3543 3642 3643 -3641
		mu 0 4 1813 1814 1865 1864
		f 4 -3545 3644 3645 -3643
		mu 0 4 1814 1815 1866 1865
		f 4 -3547 3646 3647 -3645
		mu 0 4 1815 1816 1867 1866
		f 4 -3549 3648 3649 -3647
		mu 0 4 1816 1817 1868 1867
		f 4 -3551 3650 3651 -3649
		mu 0 4 1817 1818 1869 1868
		f 4 -3553 3652 3653 -3651
		mu 0 4 1818 1819 1870 1869
		f 4 -3555 3654 3655 -3653
		mu 0 4 1819 1820 1871 1870
		f 4 -3557 3656 3657 -3655
		mu 0 4 1820 1821 1872 1871
		f 4 -3559 3658 3659 -3657
		mu 0 4 1821 1822 1873 1872
		f 4 -3561 3660 3661 -3659
		mu 0 4 1822 1823 1874 1873
		f 4 -3563 3662 3663 -3661
		mu 0 4 1823 1824 1875 1874
		f 4 -3565 3664 3665 -3663
		mu 0 4 1824 1825 1876 1875
		f 4 -3567 3666 3667 -3665
		mu 0 4 1825 1826 1877 1876
		f 4 -3569 3668 3669 -3667
		mu 0 4 1826 1827 1878 1877
		f 4 -3571 3670 3671 -3669
		mu 0 4 1827 1828 1879 1878
		f 4 -3573 3672 3673 -3671
		mu 0 4 1828 1829 1880 1879
		f 4 -3575 3674 3675 -3673
		mu 0 4 1829 1830 1881 1880
		f 4 -3577 3676 3677 -3675
		mu 0 4 1830 1831 1882 1881
		f 4 -3579 3678 3679 -3677
		mu 0 4 1831 1832 1883 1882
		f 4 -3581 3680 3681 -3679
		mu 0 4 1832 1833 1884 1883
		f 4 -3583 3682 3683 -3681
		mu 0 4 1833 1834 1885 1884
		f 4 -3585 3684 3685 -3683
		mu 0 4 1834 1835 1886 1885
		f 4 -3587 3686 3687 3688
		mu 0 4 1836 1837 1888 1887
		f 4 -3590 3689 3690 -3687
		mu 0 4 1837 1838 1889 1888
		f 4 -3592 3691 3692 -3690
		mu 0 4 1838 1839 1890 1889
		f 4 -3594 3693 3694 -3692
		mu 0 4 1839 1840 1891 1890
		f 4 -3596 3695 3696 -3694
		mu 0 4 1840 1841 1892 1891
		f 4 -3598 3697 3698 -3696
		mu 0 4 1841 1842 1893 1892
		f 4 -3600 3699 3700 -3698
		mu 0 4 1842 1843 1894 1893
		f 4 -3602 3701 3702 -3700
		mu 0 4 1843 1844 1895 1894
		f 4 -3604 3703 3704 -3702
		mu 0 4 1844 1845 1896 1895
		f 4 -3606 3705 3706 -3704
		mu 0 4 1845 1846 1897 1896
		f 4 -3608 3707 3708 -3706
		mu 0 4 1846 1847 1898 1897
		f 4 -3610 3709 3710 -3708
		mu 0 4 1847 1848 1899 1898
		f 4 -3612 3711 3712 -3710
		mu 0 4 1848 1849 1900 1899
		f 4 -3614 3713 3714 -3712
		mu 0 4 1849 1850 1901 1900
		f 4 -3616 3715 3716 -3714
		mu 0 4 1850 1851 1902 1901
		f 4 -3618 3717 3718 -3716
		mu 0 4 1851 1852 1903 1902
		f 4 -3620 3719 3720 -3718
		mu 0 4 1852 1853 1904 1903
		f 4 -3622 3721 3722 -3720
		mu 0 4 1853 1854 1905 1904
		f 4 -3624 3723 3724 -3722
		mu 0 4 1854 1855 1906 1905
		f 4 -3626 3725 3726 -3724
		mu 0 4 1855 1856 1907 1906
		f 4 -3628 3727 3728 -3726
		mu 0 4 1856 1857 1908 1907
		f 4 -3630 3729 3730 -3728
		mu 0 4 1857 1858 1909 1908
		f 4 -3632 3731 3732 -3730
		mu 0 4 1858 1859 1910 1909
		f 4 -3634 3733 3734 -3732
		mu 0 4 1859 1860 1911 1910
		f 4 -3636 3735 3736 -3734
		mu 0 4 1860 1861 1912 1911
		f 4 -3638 3737 3738 -3736
		mu 0 4 1861 1862 1913 1912
		f 4 -3640 3739 3740 -3738
		mu 0 4 1862 1863 1914 1913
		f 4 -3642 3741 3742 -3740
		mu 0 4 1863 1864 1915 1914
		f 4 -3644 3743 3744 -3742
		mu 0 4 1864 1865 1916 1915
		f 4 -3646 3745 3746 -3744
		mu 0 4 1865 1866 1917 1916
		f 4 -3648 3747 3748 -3746
		mu 0 4 1866 1867 1918 1917
		f 4 -3650 3749 3750 -3748
		mu 0 4 1867 1868 1919 1918
		f 4 -3652 3751 3752 -3750
		mu 0 4 1868 1869 1920 1919
		f 4 -3654 3753 3754 -3752
		mu 0 4 1869 1870 1921 1920
		f 4 -3656 3755 3756 -3754
		mu 0 4 1870 1871 1922 1921
		f 4 -3658 3757 3758 -3756
		mu 0 4 1871 1872 1923 1922
		f 4 -3660 3759 3760 -3758
		mu 0 4 1872 1873 1924 1923
		f 4 -3662 3761 3762 -3760
		mu 0 4 1873 1874 1925 1924
		f 4 -3664 3763 3764 -3762
		mu 0 4 1874 1875 1926 1925
		f 4 -3666 3765 3766 -3764
		mu 0 4 1875 1876 1927 1926
		f 4 -3668 3767 3768 -3766
		mu 0 4 1876 1877 1928 1927
		f 4 -3670 3769 3770 -3768
		mu 0 4 1877 1878 1929 1928
		f 4 -3672 3771 3772 -3770
		mu 0 4 1878 1879 1930 1929
		f 4 -3674 3773 3774 -3772
		mu 0 4 1879 1880 1931 1930
		f 4 -3676 3775 3776 -3774
		mu 0 4 1880 1881 1932 1931
		f 4 -3678 3777 3778 -3776
		mu 0 4 1881 1882 1933 1932
		f 4 -3680 3779 3780 -3778
		mu 0 4 1882 1883 1934 1933
		f 4 -3682 3781 3782 -3780
		mu 0 4 1883 1884 1935 1934
		f 4 -3684 3783 3784 -3782
		mu 0 4 1884 1885 1936 1935
		f 4 -3686 3785 3786 -3784
		mu 0 4 1885 1886 1937 1936
		f 4 -3688 3787 3788 3789
		mu 0 4 1887 1888 1939 1938
		f 4 -3691 3790 3791 -3788
		mu 0 4 1888 1889 1940 1939
		f 4 -3693 3792 3793 -3791
		mu 0 4 1889 1890 1941 1940
		f 4 -3695 3794 3795 -3793
		mu 0 4 1890 1891 1942 1941
		f 4 -3697 3796 3797 -3795
		mu 0 4 1891 1892 1943 1942
		f 4 -3699 3798 3799 -3797
		mu 0 4 1892 1893 1944 1943
		f 4 -3701 3800 3801 -3799
		mu 0 4 1893 1894 1945 1944
		f 4 -3703 3802 3803 -3801
		mu 0 4 1894 1895 1946 1945
		f 4 -3705 3804 3805 -3803
		mu 0 4 1895 1896 1947 1946
		f 4 -3707 3806 3807 -3805
		mu 0 4 1896 1897 1948 1947
		f 4 -3709 3808 3809 -3807
		mu 0 4 1897 1898 1949 1948
		f 4 -3711 3810 3811 -3809
		mu 0 4 1898 1899 1950 1949
		f 4 -3713 3812 3813 -3811
		mu 0 4 1899 1900 1951 1950
		f 4 -3715 3814 3815 -3813
		mu 0 4 1900 1901 1952 1951
		f 4 -3717 3816 3817 -3815
		mu 0 4 1901 1902 1953 1952
		f 4 -3719 3818 3819 -3817
		mu 0 4 1902 1903 1954 1953
		f 4 -3721 3820 3821 -3819
		mu 0 4 1903 1904 1955 1954
		f 4 -3723 3822 3823 -3821
		mu 0 4 1904 1905 1956 1955
		f 4 -3725 3824 3825 -3823
		mu 0 4 1905 1906 1957 1956
		f 4 -3727 3826 3827 -3825
		mu 0 4 1906 1907 1958 1957
		f 4 -3729 3828 3829 -3827
		mu 0 4 1907 1908 1959 1958
		f 4 -3731 3830 3831 -3829
		mu 0 4 1908 1909 1960 1959
		f 4 -3733 3832 3833 -3831
		mu 0 4 1909 1910 1961 1960
		f 4 -3735 3834 3835 -3833
		mu 0 4 1910 1911 1962 1961
		f 4 -3737 3836 3837 -3835
		mu 0 4 1911 1912 1963 1962
		f 4 -3739 3838 3839 -3837
		mu 0 4 1912 1913 1964 1963
		f 4 -3741 3840 3841 -3839
		mu 0 4 1913 1914 1965 1964
		f 4 -3743 3842 3843 -3841
		mu 0 4 1914 1915 1966 1965
		f 4 -3745 3844 3845 -3843
		mu 0 4 1915 1916 1967 1966
		f 4 -3747 3846 3847 -3845
		mu 0 4 1916 1917 1968 1967
		f 4 -3749 3848 3849 -3847
		mu 0 4 1917 1918 1969 1968
		f 4 -3751 3850 3851 -3849
		mu 0 4 1918 1919 1970 1969
		f 4 -3753 3852 3853 -3851
		mu 0 4 1919 1920 1971 1970
		f 4 -3755 3854 3855 -3853
		mu 0 4 1920 1921 1972 1971
		f 4 -3757 3856 3857 -3855
		mu 0 4 1921 1922 1973 1972
		f 4 -3759 3858 3859 -3857
		mu 0 4 1922 1923 1974 1973
		f 4 -3761 3860 3861 -3859
		mu 0 4 1923 1924 1975 1974
		f 4 -3763 3862 3863 -3861
		mu 0 4 1924 1925 1976 1975
		f 4 -3765 3864 3865 -3863
		mu 0 4 1925 1926 1977 1976
		f 4 -3767 3866 3867 -3865
		mu 0 4 1926 1927 1978 1977
		f 4 -3769 3868 3869 -3867
		mu 0 4 1927 1928 1979 1978
		f 4 -3771 3870 3871 -3869
		mu 0 4 1928 1929 1980 1979
		f 4 -3773 3872 3873 -3871
		mu 0 4 1929 1930 1981 1980
		f 4 -3775 3874 3875 -3873
		mu 0 4 1930 1931 1982 1981
		f 4 -3777 3876 3877 -3875
		mu 0 4 1931 1932 1983 1982
		f 4 -3779 3878 3879 -3877
		mu 0 4 1932 1933 1984 1983
		f 4 -3781 3880 3881 -3879
		mu 0 4 1933 1934 1985 1984
		f 4 -3783 3882 3883 -3881
		mu 0 4 1934 1935 1986 1985
		f 4 -3785 3884 3885 -3883
		mu 0 4 1935 1936 1987 1986
		f 4 -3787 3886 3887 -3885
		mu 0 4 1936 1937 1988 1987
		f 4 -3789 3888 3889 3890
		mu 0 4 1938 1939 1990 1989
		f 4 -3792 3891 3892 -3889
		mu 0 4 1939 1940 1991 1990
		f 4 -3794 3893 3894 -3892
		mu 0 4 1940 1941 1992 1991
		f 4 -3796 3895 3896 -3894
		mu 0 4 1941 1942 1993 1992
		f 4 -3798 3897 3898 -3896
		mu 0 4 1942 1943 1994 1993
		f 4 -3800 3899 3900 -3898
		mu 0 4 1943 1944 1995 1994
		f 4 -3802 3901 3902 -3900
		mu 0 4 1944 1945 1996 1995
		f 4 -3804 3903 3904 -3902
		mu 0 4 1945 1946 1997 1996
		f 4 -3806 3905 3906 -3904
		mu 0 4 1946 1947 1998 1997
		f 4 -3808 3907 3908 -3906
		mu 0 4 1947 1948 1999 1998
		f 4 -3810 3909 3910 -3908
		mu 0 4 1948 1949 2000 1999
		f 4 -3812 3911 3912 -3910
		mu 0 4 1949 1950 2001 2000
		f 4 -3814 3913 3914 -3912
		mu 0 4 1950 1951 2002 2001
		f 4 -3816 3915 3916 -3914
		mu 0 4 1951 1952 2003 2002
		f 4 -3818 3917 3918 -3916
		mu 0 4 1952 1953 2004 2003
		f 4 -3820 3919 3920 -3918
		mu 0 4 1953 1954 2005 2004
		f 4 -3822 3921 3922 -3920
		mu 0 4 1954 1955 2006 2005
		f 4 -3824 3923 3924 -3922
		mu 0 4 1955 1956 2007 2006
		f 4 -3826 3925 3926 -3924
		mu 0 4 1956 1957 2008 2007
		f 4 -3828 3927 3928 -3926
		mu 0 4 1957 1958 2009 2008
		f 4 -3830 3929 3930 -3928
		mu 0 4 1958 1959 2010 2009
		f 4 -3832 3931 3932 -3930
		mu 0 4 1959 1960 2011 2010
		f 4 -3834 3933 3934 -3932
		mu 0 4 1960 1961 2012 2011
		f 4 -3836 3935 3936 -3934
		mu 0 4 1961 1962 2013 2012
		f 4 -3838 3937 3938 -3936
		mu 0 4 1962 1963 2014 2013
		f 4 -3840 3939 3940 -3938
		mu 0 4 1963 1964 2015 2014
		f 4 -3842 3941 3942 -3940
		mu 0 4 1964 1965 2016 2015
		f 4 -3844 3943 3944 -3942
		mu 0 4 1965 1966 2017 2016
		f 4 -3846 3945 3946 -3944
		mu 0 4 1966 1967 2018 2017
		f 4 -3848 3947 3948 -3946
		mu 0 4 1967 1968 2019 2018
		f 4 -3850 3949 3950 -3948
		mu 0 4 1968 1969 2020 2019
		f 4 -3852 3951 3952 -3950
		mu 0 4 1969 1970 2021 2020
		f 4 -3854 3953 3954 -3952
		mu 0 4 1970 1971 2022 2021
		f 4 -3856 3955 3956 -3954
		mu 0 4 1971 1972 2023 2022
		f 4 -3858 3957 3958 -3956
		mu 0 4 1972 1973 2024 2023
		f 4 -3860 3959 3960 -3958
		mu 0 4 1973 1974 2025 2024
		f 4 -3862 3961 3962 -3960
		mu 0 4 1974 1975 2026 2025
		f 4 -3864 3963 3964 -3962
		mu 0 4 1975 1976 2027 2026
		f 4 -3866 3965 3966 -3964
		mu 0 4 1976 1977 2028 2027
		f 4 -3868 3967 3968 -3966
		mu 0 4 1977 1978 2029 2028
		f 4 -3870 3969 3970 -3968
		mu 0 4 1978 1979 2030 2029
		f 4 -3872 3971 3972 -3970
		mu 0 4 1979 1980 2031 2030
		f 4 -3874 3973 3974 -3972
		mu 0 4 1980 1981 2032 2031
		f 4 -3876 3975 3976 -3974
		mu 0 4 1981 1982 2033 2032
		f 4 -3878 3977 3978 -3976
		mu 0 4 1982 1983 2034 2033
		f 4 -3880 3979 3980 -3978
		mu 0 4 1983 1984 2035 2034
		f 4 -3882 3981 3982 -3980
		mu 0 4 1984 1985 2036 2035
		f 4 -3884 3983 3984 -3982
		mu 0 4 1985 1986 2037 2036
		f 4 -3886 3985 3986 -3984
		mu 0 4 1986 1987 2038 2037
		f 4 -3888 3987 3988 -3986
		mu 0 4 1987 1988 2039 2038
		f 4 -3890 3989 3990 3991
		mu 0 4 1989 1990 2041 2040
		f 4 -3893 3992 3993 -3990
		mu 0 4 1990 1991 2042 2041
		f 4 -3895 3994 3995 -3993
		mu 0 4 1991 1992 2043 2042
		f 4 -3897 3996 3997 -3995
		mu 0 4 1992 1993 2044 2043
		f 4 -3899 3998 3999 -3997
		mu 0 4 1993 1994 2045 2044
		f 4 -3901 4000 4001 -3999
		mu 0 4 1994 1995 2046 2045
		f 4 -3903 4002 4003 -4001
		mu 0 4 1995 1996 2047 2046
		f 4 -3905 4004 4005 -4003
		mu 0 4 1996 1997 2048 2047
		f 4 -3907 4006 4007 -4005
		mu 0 4 1997 1998 2049 2048
		f 4 -3909 4008 4009 -4007
		mu 0 4 1998 1999 2050 2049
		f 4 -3911 4010 4011 -4009
		mu 0 4 1999 2000 2051 2050
		f 4 -3913 4012 4013 -4011
		mu 0 4 2000 2001 2052 2051
		f 4 -3915 4014 4015 -4013
		mu 0 4 2001 2002 2053 2052
		f 4 -3917 4016 4017 -4015
		mu 0 4 2002 2003 2054 2053
		f 4 -3919 4018 4019 -4017
		mu 0 4 2003 2004 2055 2054
		f 4 -3921 4020 4021 -4019
		mu 0 4 2004 2005 2056 2055
		f 4 -3923 4022 4023 -4021
		mu 0 4 2005 2006 2057 2056
		f 4 -3925 4024 4025 -4023
		mu 0 4 2006 2007 2058 2057
		f 4 -3927 4026 4027 -4025
		mu 0 4 2007 2008 2059 2058
		f 4 -3929 4028 4029 -4027
		mu 0 4 2008 2009 2060 2059
		f 4 -3931 4030 4031 -4029
		mu 0 4 2009 2010 2061 2060
		f 4 -3933 4032 4033 -4031
		mu 0 4 2010 2011 2062 2061
		f 4 -3935 4034 4035 -4033
		mu 0 4 2011 2012 2063 2062
		f 4 -3937 4036 4037 -4035
		mu 0 4 2012 2013 2064 2063
		f 4 -3939 4038 4039 -4037
		mu 0 4 2013 2014 2065 2064
		f 4 -3941 4040 4041 -4039
		mu 0 4 2014 2015 2066 2065
		f 4 -3943 4042 4043 -4041
		mu 0 4 2015 2016 2067 2066
		f 4 -3945 4044 4045 -4043
		mu 0 4 2016 2017 2068 2067
		f 4 -3947 4046 4047 -4045
		mu 0 4 2017 2018 2069 2068
		f 4 -3949 4048 4049 -4047
		mu 0 4 2018 2019 2070 2069
		f 4 -3951 4050 4051 -4049
		mu 0 4 2019 2020 2071 2070
		f 4 -3953 4052 4053 -4051
		mu 0 4 2020 2021 2072 2071
		f 4 -3955 4054 4055 -4053
		mu 0 4 2021 2022 2073 2072
		f 4 -3957 4056 4057 -4055
		mu 0 4 2022 2023 2074 2073
		f 4 -3959 4058 4059 -4057
		mu 0 4 2023 2024 2075 2074
		f 4 -3961 4060 4061 -4059
		mu 0 4 2024 2025 2076 2075
		f 4 -3963 4062 4063 -4061
		mu 0 4 2025 2026 2077 2076
		f 4 -3965 4064 4065 -4063
		mu 0 4 2026 2027 2078 2077
		f 4 -3967 4066 4067 -4065
		mu 0 4 2027 2028 2079 2078
		f 4 -3969 4068 4069 -4067
		mu 0 4 2028 2029 2080 2079
		f 4 -3971 4070 4071 -4069
		mu 0 4 2029 2030 2081 2080
		f 4 -3973 4072 4073 -4071
		mu 0 4 2030 2031 2082 2081
		f 4 -3975 4074 4075 -4073
		mu 0 4 2031 2032 2083 2082
		f 4 -3977 4076 4077 -4075
		mu 0 4 2032 2033 2084 2083
		f 4 -3979 4078 4079 -4077
		mu 0 4 2033 2034 2085 2084
		f 4 -3981 4080 4081 -4079
		mu 0 4 2034 2035 2086 2085
		f 4 -3983 4082 4083 -4081
		mu 0 4 2035 2036 2087 2086
		f 4 -3985 4084 4085 -4083
		mu 0 4 2036 2037 2088 2087
		f 4 -3987 4086 4087 -4085
		mu 0 4 2037 2038 2089 2088
		f 4 -3989 4088 4089 -4087
		mu 0 4 2038 2039 2090 2089;
	setAttr ".fc[2000:2499]"
		f 4 -3991 4090 4091 4092
		mu 0 4 2040 2041 2092 2091
		f 4 -3994 4093 4094 -4091
		mu 0 4 2041 2042 2093 2092
		f 4 -3996 4095 4096 -4094
		mu 0 4 2042 2043 2094 2093
		f 4 -3998 4097 4098 -4096
		mu 0 4 2043 2044 2095 2094
		f 4 -4000 4099 4100 -4098
		mu 0 4 2044 2045 2096 2095
		f 4 -4002 4101 4102 -4100
		mu 0 4 2045 2046 2097 2096
		f 4 -4004 4103 4104 -4102
		mu 0 4 2046 2047 2098 2097
		f 4 -4006 4105 4106 -4104
		mu 0 4 2047 2048 2099 2098
		f 4 -4008 4107 4108 -4106
		mu 0 4 2048 2049 2100 2099
		f 4 -4010 4109 4110 -4108
		mu 0 4 2049 2050 2101 2100
		f 4 -4012 4111 4112 -4110
		mu 0 4 2050 2051 2102 2101
		f 4 -4014 4113 4114 -4112
		mu 0 4 2051 2052 2103 2102
		f 4 -4016 4115 4116 -4114
		mu 0 4 2052 2053 2104 2103
		f 4 -4018 4117 4118 -4116
		mu 0 4 2053 2054 2105 2104
		f 4 -4020 4119 4120 -4118
		mu 0 4 2054 2055 2106 2105
		f 4 -4022 4121 4122 -4120
		mu 0 4 2055 2056 2107 2106
		f 4 -4024 4123 4124 -4122
		mu 0 4 2056 2057 2108 2107
		f 4 -4026 4125 4126 -4124
		mu 0 4 2057 2058 2109 2108
		f 4 -4028 4127 4128 -4126
		mu 0 4 2058 2059 2110 2109
		f 4 -4030 4129 4130 -4128
		mu 0 4 2059 2060 2111 2110
		f 4 -4032 4131 4132 -4130
		mu 0 4 2060 2061 2112 2111
		f 4 -4034 4133 4134 -4132
		mu 0 4 2061 2062 2113 2112
		f 4 -4036 4135 4136 -4134
		mu 0 4 2062 2063 2114 2113
		f 4 -4038 4137 4138 -4136
		mu 0 4 2063 2064 2115 2114
		f 4 -4040 4139 4140 -4138
		mu 0 4 2064 2065 2116 2115
		f 4 -4042 4141 4142 -4140
		mu 0 4 2065 2066 2117 2116
		f 4 -4044 4143 4144 -4142
		mu 0 4 2066 2067 2118 2117
		f 4 -4046 4145 4146 -4144
		mu 0 4 2067 2068 2119 2118
		f 4 -4048 4147 4148 -4146
		mu 0 4 2068 2069 2120 2119
		f 4 -4050 4149 4150 -4148
		mu 0 4 2069 2070 2121 2120
		f 4 -4052 4151 4152 -4150
		mu 0 4 2070 2071 2122 2121
		f 4 -4054 4153 4154 -4152
		mu 0 4 2071 2072 2123 2122
		f 4 -4056 4155 4156 -4154
		mu 0 4 2072 2073 2124 2123
		f 4 -4058 4157 4158 -4156
		mu 0 4 2073 2074 2125 2124
		f 4 -4060 4159 4160 -4158
		mu 0 4 2074 2075 2126 2125
		f 4 -4062 4161 4162 -4160
		mu 0 4 2075 2076 2127 2126
		f 4 -4064 4163 4164 -4162
		mu 0 4 2076 2077 2128 2127
		f 4 -4066 4165 4166 -4164
		mu 0 4 2077 2078 2129 2128
		f 4 -4068 4167 4168 -4166
		mu 0 4 2078 2079 2130 2129
		f 4 -4070 4169 4170 -4168
		mu 0 4 2079 2080 2131 2130
		f 4 -4072 4171 4172 -4170
		mu 0 4 2080 2081 2132 2131
		f 4 -4074 4173 4174 -4172
		mu 0 4 2081 2082 2133 2132
		f 4 -4076 4175 4176 -4174
		mu 0 4 2082 2083 2134 2133
		f 4 -4078 4177 4178 -4176
		mu 0 4 2083 2084 2135 2134
		f 4 -4080 4179 4180 -4178
		mu 0 4 2084 2085 2136 2135
		f 4 -4082 4181 4182 -4180
		mu 0 4 2085 2086 2137 2136
		f 4 -4084 4183 4184 -4182
		mu 0 4 2086 2087 2138 2137
		f 4 -4086 4185 4186 -4184
		mu 0 4 2087 2088 2139 2138
		f 4 -4088 4187 4188 -4186
		mu 0 4 2088 2089 2140 2139
		f 4 -4090 4189 4190 -4188
		mu 0 4 2089 2090 2141 2140
		f 4 -4092 4191 4192 4193
		mu 0 4 2091 2092 2143 2142
		f 4 -4095 4194 4195 -4192
		mu 0 4 2092 2093 2144 2143
		f 4 -4097 4196 4197 -4195
		mu 0 4 2093 2094 2145 2144
		f 4 -4099 4198 4199 -4197
		mu 0 4 2094 2095 2146 2145
		f 4 -4101 4200 4201 -4199
		mu 0 4 2095 2096 2147 2146
		f 4 -4103 4202 4203 -4201
		mu 0 4 2096 2097 2148 2147
		f 4 -4105 4204 4205 -4203
		mu 0 4 2097 2098 2149 2148
		f 4 -4107 4206 4207 -4205
		mu 0 4 2098 2099 2150 2149
		f 4 -4109 4208 4209 -4207
		mu 0 4 2099 2100 2151 2150
		f 4 -4111 4210 4211 -4209
		mu 0 4 2100 2101 2152 2151
		f 4 -4113 4212 4213 -4211
		mu 0 4 2101 2102 2153 2152
		f 4 -4115 4214 4215 -4213
		mu 0 4 2102 2103 2154 2153
		f 4 -4117 4216 4217 -4215
		mu 0 4 2103 2104 2155 2154
		f 4 -4119 4218 4219 -4217
		mu 0 4 2104 2105 2156 2155
		f 4 -4121 4220 4221 -4219
		mu 0 4 2105 2106 2157 2156
		f 4 -4123 4222 4223 -4221
		mu 0 4 2106 2107 2158 2157
		f 4 -4125 4224 4225 -4223
		mu 0 4 2107 2108 2159 2158
		f 4 -4127 4226 4227 -4225
		mu 0 4 2108 2109 2160 2159
		f 4 -4129 4228 4229 -4227
		mu 0 4 2109 2110 2161 2160
		f 4 -4131 4230 4231 -4229
		mu 0 4 2110 2111 2162 2161
		f 4 -4133 4232 4233 -4231
		mu 0 4 2111 2112 2163 2162
		f 4 -4135 4234 4235 -4233
		mu 0 4 2112 2113 2164 2163
		f 4 -4137 4236 4237 -4235
		mu 0 4 2113 2114 2165 2164
		f 4 -4139 4238 4239 -4237
		mu 0 4 2114 2115 2166 2165
		f 4 -4141 4240 4241 -4239
		mu 0 4 2115 2116 2167 2166
		f 4 -4143 4242 4243 -4241
		mu 0 4 2116 2117 2168 2167
		f 4 -4145 4244 4245 -4243
		mu 0 4 2117 2118 2169 2168
		f 4 -4147 4246 4247 -4245
		mu 0 4 2118 2119 2170 2169
		f 4 -4149 4248 4249 -4247
		mu 0 4 2119 2120 2171 2170
		f 4 -4151 4250 4251 -4249
		mu 0 4 2120 2121 2172 2171
		f 4 -4153 4252 4253 -4251
		mu 0 4 2121 2122 2173 2172
		f 4 -4155 4254 4255 -4253
		mu 0 4 2122 2123 2174 2173
		f 4 -4157 4256 4257 -4255
		mu 0 4 2123 2124 2175 2174
		f 4 -4159 4258 4259 -4257
		mu 0 4 2124 2125 2176 2175
		f 4 -4161 4260 4261 -4259
		mu 0 4 2125 2126 2177 2176
		f 4 -4163 4262 4263 -4261
		mu 0 4 2126 2127 2178 2177
		f 4 -4165 4264 4265 -4263
		mu 0 4 2127 2128 2179 2178
		f 4 -4167 4266 4267 -4265
		mu 0 4 2128 2129 2180 2179
		f 4 -4169 4268 4269 -4267
		mu 0 4 2129 2130 2181 2180
		f 4 -4171 4270 4271 -4269
		mu 0 4 2130 2131 2182 2181
		f 4 -4173 4272 4273 -4271
		mu 0 4 2131 2132 2183 2182
		f 4 -4175 4274 4275 -4273
		mu 0 4 2132 2133 2184 2183
		f 4 -4177 4276 4277 -4275
		mu 0 4 2133 2134 2185 2184
		f 4 -4179 4278 4279 -4277
		mu 0 4 2134 2135 2186 2185
		f 4 -4181 4280 4281 -4279
		mu 0 4 2135 2136 2187 2186
		f 4 -4183 4282 4283 -4281
		mu 0 4 2136 2137 2188 2187
		f 4 -4185 4284 4285 -4283
		mu 0 4 2137 2138 2189 2188
		f 4 -4187 4286 4287 -4285
		mu 0 4 2138 2139 2190 2189
		f 4 -4189 4288 4289 -4287
		mu 0 4 2139 2140 2191 2190
		f 4 -4191 4290 4291 -4289
		mu 0 4 2140 2141 2192 2191
		f 4 -4193 4292 4293 4294
		mu 0 4 2142 2143 2194 2193
		f 4 -4196 4295 4296 -4293
		mu 0 4 2143 2144 2195 2194
		f 4 -4198 4297 4298 -4296
		mu 0 4 2144 2145 2196 2195
		f 4 -4200 4299 4300 -4298
		mu 0 4 2145 2146 2197 2196
		f 4 -4202 4301 4302 -4300
		mu 0 4 2146 2147 2198 2197
		f 4 -4204 4303 4304 -4302
		mu 0 4 2147 2148 2199 2198
		f 4 -4206 4305 4306 -4304
		mu 0 4 2148 2149 2200 2199
		f 4 -4208 4307 4308 -4306
		mu 0 4 2149 2150 2201 2200
		f 4 -4210 4309 4310 -4308
		mu 0 4 2150 2151 2202 2201
		f 4 -4212 4311 4312 -4310
		mu 0 4 2151 2152 2203 2202
		f 4 -4214 4313 4314 -4312
		mu 0 4 2152 2153 2204 2203
		f 4 -4216 4315 4316 -4314
		mu 0 4 2153 2154 2205 2204
		f 4 -4218 4317 4318 -4316
		mu 0 4 2154 2155 2206 2205
		f 4 -4220 4319 4320 -4318
		mu 0 4 2155 2156 2207 2206
		f 4 -4222 4321 4322 -4320
		mu 0 4 2156 2157 2208 2207
		f 4 -4224 4323 4324 -4322
		mu 0 4 2157 2158 2209 2208
		f 4 -4226 4325 4326 -4324
		mu 0 4 2158 2159 2210 2209
		f 4 -4228 4327 4328 -4326
		mu 0 4 2159 2160 2211 2210
		f 4 -4230 4329 4330 -4328
		mu 0 4 2160 2161 2212 2211
		f 4 -4232 4331 4332 -4330
		mu 0 4 2161 2162 2213 2212
		f 4 -4234 4333 4334 -4332
		mu 0 4 2162 2163 2214 2213
		f 4 -4236 4335 4336 -4334
		mu 0 4 2163 2164 2215 2214
		f 4 -4238 4337 4338 -4336
		mu 0 4 2164 2165 2216 2215
		f 4 -4240 4339 4340 -4338
		mu 0 4 2165 2166 2217 2216
		f 4 -4242 4341 4342 -4340
		mu 0 4 2166 2167 2218 2217
		f 4 -4244 4343 4344 -4342
		mu 0 4 2167 2168 2219 2218
		f 4 -4246 4345 4346 -4344
		mu 0 4 2168 2169 2220 2219
		f 4 -4248 4347 4348 -4346
		mu 0 4 2169 2170 2221 2220
		f 4 -4250 4349 4350 -4348
		mu 0 4 2170 2171 2222 2221
		f 4 -4252 4351 4352 -4350
		mu 0 4 2171 2172 2223 2222
		f 4 -4254 4353 4354 -4352
		mu 0 4 2172 2173 2224 2223
		f 4 -4256 4355 4356 -4354
		mu 0 4 2173 2174 2225 2224
		f 4 -4258 4357 4358 -4356
		mu 0 4 2174 2175 2226 2225
		f 4 -4260 4359 4360 -4358
		mu 0 4 2175 2176 2227 2226
		f 4 -4262 4361 4362 -4360
		mu 0 4 2176 2177 2228 2227
		f 4 -4264 4363 4364 -4362
		mu 0 4 2177 2178 2229 2228
		f 4 -4266 4365 4366 -4364
		mu 0 4 2178 2179 2230 2229
		f 4 -4268 4367 4368 -4366
		mu 0 4 2179 2180 2231 2230
		f 4 -4270 4369 4370 -4368
		mu 0 4 2180 2181 2232 2231
		f 4 -4272 4371 4372 -4370
		mu 0 4 2181 2182 2233 2232
		f 4 -4274 4373 4374 -4372
		mu 0 4 2182 2183 2234 2233
		f 4 -4276 4375 4376 -4374
		mu 0 4 2183 2184 2235 2234
		f 4 -4278 4377 4378 -4376
		mu 0 4 2184 2185 2236 2235
		f 4 -4280 4379 4380 -4378
		mu 0 4 2185 2186 2237 2236
		f 4 -4282 4381 4382 -4380
		mu 0 4 2186 2187 2238 2237
		f 4 -4284 4383 4384 -4382
		mu 0 4 2187 2188 2239 2238
		f 4 -4286 4385 4386 -4384
		mu 0 4 2188 2189 2240 2239
		f 4 -4288 4387 4388 -4386
		mu 0 4 2189 2190 2241 2240
		f 4 -4290 4389 4390 -4388
		mu 0 4 2190 2191 2242 2241
		f 4 -4292 4391 4392 -4390
		mu 0 4 2191 2192 2243 2242
		f 4 -4294 4393 4394 4395
		mu 0 4 2193 2194 2245 2244
		f 4 -4297 4396 4397 -4394
		mu 0 4 2194 2195 2246 2245
		f 4 -4299 4398 4399 -4397
		mu 0 4 2195 2196 2247 2246
		f 4 -4301 4400 4401 -4399
		mu 0 4 2196 2197 2248 2247
		f 4 -4303 4402 4403 -4401
		mu 0 4 2197 2198 2249 2248
		f 4 -4305 4404 4405 -4403
		mu 0 4 2198 2199 2250 2249
		f 4 -4307 4406 4407 -4405
		mu 0 4 2199 2200 2251 2250
		f 4 -4309 4408 4409 -4407
		mu 0 4 2200 2201 2252 2251
		f 4 -4311 4410 4411 -4409
		mu 0 4 2201 2202 2253 2252
		f 4 -4313 4412 4413 -4411
		mu 0 4 2202 2203 2254 2253
		f 4 -4315 4414 4415 -4413
		mu 0 4 2203 2204 2255 2254
		f 4 -4317 4416 4417 -4415
		mu 0 4 2204 2205 2256 2255
		f 4 -4319 4418 4419 -4417
		mu 0 4 2205 2206 2257 2256
		f 4 -4321 4420 4421 -4419
		mu 0 4 2206 2207 2258 2257
		f 4 -4323 4422 4423 -4421
		mu 0 4 2207 2208 2259 2258
		f 4 -4325 4424 4425 -4423
		mu 0 4 2208 2209 2260 2259
		f 4 -4327 4426 4427 -4425
		mu 0 4 2209 2210 2261 2260
		f 4 -4329 4428 4429 -4427
		mu 0 4 2210 2211 2262 2261
		f 4 -4331 4430 4431 -4429
		mu 0 4 2211 2212 2263 2262
		f 4 -4333 4432 4433 -4431
		mu 0 4 2212 2213 2264 2263
		f 4 -4335 4434 4435 -4433
		mu 0 4 2213 2214 2265 2264
		f 4 -4337 4436 4437 -4435
		mu 0 4 2214 2215 2266 2265
		f 4 -4339 4438 4439 -4437
		mu 0 4 2215 2216 2267 2266
		f 4 -4341 4440 4441 -4439
		mu 0 4 2216 2217 2268 2267
		f 4 -4343 4442 4443 -4441
		mu 0 4 2217 2218 2269 2268
		f 4 -4345 4444 4445 -4443
		mu 0 4 2218 2219 2270 2269
		f 4 -4347 4446 4447 -4445
		mu 0 4 2219 2220 2271 2270
		f 4 -4349 4448 4449 -4447
		mu 0 4 2220 2221 2272 2271
		f 4 -4351 4450 4451 -4449
		mu 0 4 2221 2222 2273 2272
		f 4 -4353 4452 4453 -4451
		mu 0 4 2222 2223 2274 2273
		f 4 -4355 4454 4455 -4453
		mu 0 4 2223 2224 2275 2274
		f 4 -4357 4456 4457 -4455
		mu 0 4 2224 2225 2276 2275
		f 4 -4359 4458 4459 -4457
		mu 0 4 2225 2226 2277 2276
		f 4 -4361 4460 4461 -4459
		mu 0 4 2226 2227 2278 2277
		f 4 -4363 4462 4463 -4461
		mu 0 4 2227 2228 2279 2278
		f 4 -4365 4464 4465 -4463
		mu 0 4 2228 2229 2280 2279
		f 4 -4367 4466 4467 -4465
		mu 0 4 2229 2230 2281 2280
		f 4 -4369 4468 4469 -4467
		mu 0 4 2230 2231 2282 2281
		f 4 -4371 4470 4471 -4469
		mu 0 4 2231 2232 2283 2282
		f 4 -4373 4472 4473 -4471
		mu 0 4 2232 2233 2284 2283
		f 4 -4375 4474 4475 -4473
		mu 0 4 2233 2234 2285 2284
		f 4 -4377 4476 4477 -4475
		mu 0 4 2234 2235 2286 2285
		f 4 -4379 4478 4479 -4477
		mu 0 4 2235 2236 2287 2286
		f 4 -4381 4480 4481 -4479
		mu 0 4 2236 2237 2288 2287
		f 4 -4383 4482 4483 -4481
		mu 0 4 2237 2238 2289 2288
		f 4 -4385 4484 4485 -4483
		mu 0 4 2238 2239 2290 2289
		f 4 -4387 4486 4487 -4485
		mu 0 4 2239 2240 2291 2290
		f 4 -4389 4488 4489 -4487
		mu 0 4 2240 2241 2292 2291
		f 4 -4391 4490 4491 -4489
		mu 0 4 2241 2242 2293 2292
		f 4 -4393 4492 4493 -4491
		mu 0 4 2242 2243 2294 2293
		f 4 -4395 4494 4495 4496
		mu 0 4 2244 2245 2296 2295
		f 4 -4398 4497 4498 -4495
		mu 0 4 2245 2246 2297 2296
		f 4 -4400 4499 4500 -4498
		mu 0 4 2246 2247 2298 2297
		f 4 -4402 4501 4502 -4500
		mu 0 4 2247 2248 2299 2298
		f 4 -4404 4503 4504 -4502
		mu 0 4 2248 2249 2300 2299
		f 4 -4406 4505 4506 -4504
		mu 0 4 2249 2250 2301 2300
		f 4 -4408 4507 4508 -4506
		mu 0 4 2250 2251 2302 2301
		f 4 -4410 4509 4510 -4508
		mu 0 4 2251 2252 2303 2302
		f 4 -4412 4511 4512 -4510
		mu 0 4 2252 2253 2304 2303
		f 4 -4414 4513 4514 -4512
		mu 0 4 2253 2254 2305 2304
		f 4 -4416 4515 4516 -4514
		mu 0 4 2254 2255 2306 2305
		f 4 -4418 4517 4518 -4516
		mu 0 4 2255 2256 2307 2306
		f 4 -4420 4519 4520 -4518
		mu 0 4 2256 2257 2308 2307
		f 4 -4422 4521 4522 -4520
		mu 0 4 2257 2258 2309 2308
		f 4 -4424 4523 4524 -4522
		mu 0 4 2258 2259 2310 2309
		f 4 -4426 4525 4526 -4524
		mu 0 4 2259 2260 2311 2310
		f 4 -4428 4527 4528 -4526
		mu 0 4 2260 2261 2312 2311
		f 4 -4430 4529 4530 -4528
		mu 0 4 2261 2262 2313 2312
		f 4 -4432 4531 4532 -4530
		mu 0 4 2262 2263 2314 2313
		f 4 -4434 4533 4534 -4532
		mu 0 4 2263 2264 2315 2314
		f 4 -4436 4535 4536 -4534
		mu 0 4 2264 2265 2316 2315
		f 4 -4438 4537 4538 -4536
		mu 0 4 2265 2266 2317 2316
		f 4 -4440 4539 4540 -4538
		mu 0 4 2266 2267 2318 2317
		f 4 -4442 4541 4542 -4540
		mu 0 4 2267 2268 2319 2318
		f 4 -4444 4543 4544 -4542
		mu 0 4 2268 2269 2320 2319
		f 4 -4446 4545 4546 -4544
		mu 0 4 2269 2270 2321 2320
		f 4 -4448 4547 4548 -4546
		mu 0 4 2270 2271 2322 2321
		f 4 -4450 4549 4550 -4548
		mu 0 4 2271 2272 2323 2322
		f 4 -4452 4551 4552 -4550
		mu 0 4 2272 2273 2324 2323
		f 4 -4454 4553 4554 -4552
		mu 0 4 2273 2274 2325 2324
		f 4 -4456 4555 4556 -4554
		mu 0 4 2274 2275 2326 2325
		f 4 -4458 4557 4558 -4556
		mu 0 4 2275 2276 2327 2326
		f 4 -4460 4559 4560 -4558
		mu 0 4 2276 2277 2328 2327
		f 4 -4462 4561 4562 -4560
		mu 0 4 2277 2278 2329 2328
		f 4 -4464 4563 4564 -4562
		mu 0 4 2278 2279 2330 2329
		f 4 -4466 4565 4566 -4564
		mu 0 4 2279 2280 2331 2330
		f 4 -4468 4567 4568 -4566
		mu 0 4 2280 2281 2332 2331
		f 4 -4470 4569 4570 -4568
		mu 0 4 2281 2282 2333 2332
		f 4 -4472 4571 4572 -4570
		mu 0 4 2282 2283 2334 2333
		f 4 -4474 4573 4574 -4572
		mu 0 4 2283 2284 2335 2334
		f 4 -4476 4575 4576 -4574
		mu 0 4 2284 2285 2336 2335
		f 4 -4478 4577 4578 -4576
		mu 0 4 2285 2286 2337 2336
		f 4 -4480 4579 4580 -4578
		mu 0 4 2286 2287 2338 2337
		f 4 -4482 4581 4582 -4580
		mu 0 4 2287 2288 2339 2338
		f 4 -4484 4583 4584 -4582
		mu 0 4 2288 2289 2340 2339
		f 4 -4486 4585 4586 -4584
		mu 0 4 2289 2290 2341 2340
		f 4 -4488 4587 4588 -4586
		mu 0 4 2290 2291 2342 2341
		f 4 -4490 4589 4590 -4588
		mu 0 4 2291 2292 2343 2342
		f 4 -4492 4591 4592 -4590
		mu 0 4 2292 2293 2344 2343
		f 4 -4494 4593 4594 -4592
		mu 0 4 2293 2294 2345 2344
		f 4 -4496 4595 4596 4597
		mu 0 4 2295 2296 2347 2346
		f 4 -4499 4598 4599 -4596
		mu 0 4 2296 2297 2348 2347
		f 4 -4501 4600 4601 -4599
		mu 0 4 2297 2298 2349 2348
		f 4 -4503 4602 4603 -4601
		mu 0 4 2298 2299 2350 2349
		f 4 -4505 4604 4605 -4603
		mu 0 4 2299 2300 2351 2350
		f 4 -4507 4606 4607 -4605
		mu 0 4 2300 2301 2352 2351
		f 4 -4509 4608 4609 -4607
		mu 0 4 2301 2302 2353 2352
		f 4 -4511 4610 4611 -4609
		mu 0 4 2302 2303 2354 2353
		f 4 -4513 4612 4613 -4611
		mu 0 4 2303 2304 2355 2354
		f 4 -4515 4614 4615 -4613
		mu 0 4 2304 2305 2356 2355
		f 4 -4517 4616 4617 -4615
		mu 0 4 2305 2306 2357 2356
		f 4 -4519 4618 4619 -4617
		mu 0 4 2306 2307 2358 2357
		f 4 -4521 4620 4621 -4619
		mu 0 4 2307 2308 2359 2358
		f 4 -4523 4622 4623 -4621
		mu 0 4 2308 2309 2360 2359
		f 4 -4525 4624 4625 -4623
		mu 0 4 2309 2310 2361 2360
		f 4 -4527 4626 4627 -4625
		mu 0 4 2310 2311 2362 2361
		f 4 -4529 4628 4629 -4627
		mu 0 4 2311 2312 2363 2362
		f 4 -4531 4630 4631 -4629
		mu 0 4 2312 2313 2364 2363
		f 4 -4533 4632 4633 -4631
		mu 0 4 2313 2314 2365 2364
		f 4 -4535 4634 4635 -4633
		mu 0 4 2314 2315 2366 2365
		f 4 -4537 4636 4637 -4635
		mu 0 4 2315 2316 2367 2366
		f 4 -4539 4638 4639 -4637
		mu 0 4 2316 2317 2368 2367
		f 4 -4541 4640 4641 -4639
		mu 0 4 2317 2318 2369 2368
		f 4 -4543 4642 4643 -4641
		mu 0 4 2318 2319 2370 2369
		f 4 -4545 4644 4645 -4643
		mu 0 4 2319 2320 2371 2370
		f 4 -4547 4646 4647 -4645
		mu 0 4 2320 2321 2372 2371
		f 4 -4549 4648 4649 -4647
		mu 0 4 2321 2322 2373 2372
		f 4 -4551 4650 4651 -4649
		mu 0 4 2322 2323 2374 2373
		f 4 -4553 4652 4653 -4651
		mu 0 4 2323 2324 2375 2374
		f 4 -4555 4654 4655 -4653
		mu 0 4 2324 2325 2376 2375
		f 4 -4557 4656 4657 -4655
		mu 0 4 2325 2326 2377 2376
		f 4 -4559 4658 4659 -4657
		mu 0 4 2326 2327 2378 2377
		f 4 -4561 4660 4661 -4659
		mu 0 4 2327 2328 2379 2378
		f 4 -4563 4662 4663 -4661
		mu 0 4 2328 2329 2380 2379
		f 4 -4565 4664 4665 -4663
		mu 0 4 2329 2330 2381 2380
		f 4 -4567 4666 4667 -4665
		mu 0 4 2330 2331 2382 2381
		f 4 -4569 4668 4669 -4667
		mu 0 4 2331 2332 2383 2382
		f 4 -4571 4670 4671 -4669
		mu 0 4 2332 2333 2384 2383
		f 4 -4573 4672 4673 -4671
		mu 0 4 2333 2334 2385 2384
		f 4 -4575 4674 4675 -4673
		mu 0 4 2334 2335 2386 2385
		f 4 -4577 4676 4677 -4675
		mu 0 4 2335 2336 2387 2386
		f 4 -4579 4678 4679 -4677
		mu 0 4 2336 2337 2388 2387
		f 4 -4581 4680 4681 -4679
		mu 0 4 2337 2338 2389 2388
		f 4 -4583 4682 4683 -4681
		mu 0 4 2338 2339 2390 2389
		f 4 -4585 4684 4685 -4683
		mu 0 4 2339 2340 2391 2390
		f 4 -4587 4686 4687 -4685
		mu 0 4 2340 2341 2392 2391
		f 4 -4589 4688 4689 -4687
		mu 0 4 2341 2342 2393 2392
		f 4 -4591 4690 4691 -4689
		mu 0 4 2342 2343 2394 2393
		f 4 -4593 4692 4693 -4691
		mu 0 4 2343 2344 2395 2394
		f 4 -4595 4694 4695 -4693
		mu 0 4 2344 2345 2396 2395
		f 4 -4597 4696 4697 4698
		mu 0 4 2346 2347 2398 2397
		f 4 -4600 4699 4700 -4697
		mu 0 4 2347 2348 2399 2398
		f 4 -4602 4701 4702 -4700
		mu 0 4 2348 2349 2400 2399
		f 4 -4604 4703 4704 -4702
		mu 0 4 2349 2350 2401 2400
		f 4 -4606 4705 4706 -4704
		mu 0 4 2350 2351 2402 2401
		f 4 -4608 4707 4708 -4706
		mu 0 4 2351 2352 2403 2402
		f 4 -4610 4709 4710 -4708
		mu 0 4 2352 2353 2404 2403
		f 4 -4612 4711 4712 -4710
		mu 0 4 2353 2354 2405 2404
		f 4 -4614 4713 4714 -4712
		mu 0 4 2354 2355 2406 2405
		f 4 -4616 4715 4716 -4714
		mu 0 4 2355 2356 2407 2406
		f 4 -4618 4717 4718 -4716
		mu 0 4 2356 2357 2408 2407
		f 4 -4620 4719 4720 -4718
		mu 0 4 2357 2358 2409 2408
		f 4 -4622 4721 4722 -4720
		mu 0 4 2358 2359 2410 2409
		f 4 -4624 4723 4724 -4722
		mu 0 4 2359 2360 2411 2410
		f 4 -4626 4725 4726 -4724
		mu 0 4 2360 2361 2412 2411
		f 4 -4628 4727 4728 -4726
		mu 0 4 2361 2362 2413 2412
		f 4 -4630 4729 4730 -4728
		mu 0 4 2362 2363 2414 2413
		f 4 -4632 4731 4732 -4730
		mu 0 4 2363 2364 2415 2414
		f 4 -4634 4733 4734 -4732
		mu 0 4 2364 2365 2416 2415
		f 4 -4636 4735 4736 -4734
		mu 0 4 2365 2366 2417 2416
		f 4 -4638 4737 4738 -4736
		mu 0 4 2366 2367 2418 2417
		f 4 -4640 4739 4740 -4738
		mu 0 4 2367 2368 2419 2418
		f 4 -4642 4741 4742 -4740
		mu 0 4 2368 2369 2420 2419
		f 4 -4644 4743 4744 -4742
		mu 0 4 2369 2370 2421 2420
		f 4 -4646 4745 4746 -4744
		mu 0 4 2370 2371 2422 2421
		f 4 -4648 4747 4748 -4746
		mu 0 4 2371 2372 2423 2422
		f 4 -4650 4749 4750 -4748
		mu 0 4 2372 2373 2424 2423
		f 4 -4652 4751 4752 -4750
		mu 0 4 2373 2374 2425 2424
		f 4 -4654 4753 4754 -4752
		mu 0 4 2374 2375 2426 2425
		f 4 -4656 4755 4756 -4754
		mu 0 4 2375 2376 2427 2426
		f 4 -4658 4757 4758 -4756
		mu 0 4 2376 2377 2428 2427
		f 4 -4660 4759 4760 -4758
		mu 0 4 2377 2378 2429 2428
		f 4 -4662 4761 4762 -4760
		mu 0 4 2378 2379 2430 2429
		f 4 -4664 4763 4764 -4762
		mu 0 4 2379 2380 2431 2430
		f 4 -4666 4765 4766 -4764
		mu 0 4 2380 2381 2432 2431
		f 4 -4668 4767 4768 -4766
		mu 0 4 2381 2382 2433 2432
		f 4 -4670 4769 4770 -4768
		mu 0 4 2382 2383 2434 2433
		f 4 -4672 4771 4772 -4770
		mu 0 4 2383 2384 2435 2434
		f 4 -4674 4773 4774 -4772
		mu 0 4 2384 2385 2436 2435
		f 4 -4676 4775 4776 -4774
		mu 0 4 2385 2386 2437 2436
		f 4 -4678 4777 4778 -4776
		mu 0 4 2386 2387 2438 2437
		f 4 -4680 4779 4780 -4778
		mu 0 4 2387 2388 2439 2438
		f 4 -4682 4781 4782 -4780
		mu 0 4 2388 2389 2440 2439
		f 4 -4684 4783 4784 -4782
		mu 0 4 2389 2390 2441 2440
		f 4 -4686 4785 4786 -4784
		mu 0 4 2390 2391 2442 2441
		f 4 -4688 4787 4788 -4786
		mu 0 4 2391 2392 2443 2442
		f 4 -4690 4789 4790 -4788
		mu 0 4 2392 2393 2444 2443
		f 4 -4692 4791 4792 -4790
		mu 0 4 2393 2394 2445 2444
		f 4 -4694 4793 4794 -4792
		mu 0 4 2394 2395 2446 2445
		f 4 -4696 4795 4796 -4794
		mu 0 4 2395 2396 2447 2446
		f 4 -4698 4797 4798 4799
		mu 0 4 2397 2398 2449 2448
		f 4 -4701 4800 4801 -4798
		mu 0 4 2398 2399 2450 2449
		f 4 -4703 4802 4803 -4801
		mu 0 4 2399 2400 2451 2450
		f 4 -4705 4804 4805 -4803
		mu 0 4 2400 2401 2452 2451
		f 4 -4707 4806 4807 -4805
		mu 0 4 2401 2402 2453 2452
		f 4 -4709 4808 4809 -4807
		mu 0 4 2402 2403 2454 2453
		f 4 -4711 4810 4811 -4809
		mu 0 4 2403 2404 2455 2454
		f 4 -4713 4812 4813 -4811
		mu 0 4 2404 2405 2456 2455
		f 4 -4715 4814 4815 -4813
		mu 0 4 2405 2406 2457 2456
		f 4 -4717 4816 4817 -4815
		mu 0 4 2406 2407 2458 2457
		f 4 -4719 4818 4819 -4817
		mu 0 4 2407 2408 2459 2458
		f 4 -4721 4820 4821 -4819
		mu 0 4 2408 2409 2460 2459
		f 4 -4723 4822 4823 -4821
		mu 0 4 2409 2410 2461 2460
		f 4 -4725 4824 4825 -4823
		mu 0 4 2410 2411 2462 2461
		f 4 -4727 4826 4827 -4825
		mu 0 4 2411 2412 2463 2462
		f 4 -4729 4828 4829 -4827
		mu 0 4 2412 2413 2464 2463
		f 4 -4731 4830 4831 -4829
		mu 0 4 2413 2414 2465 2464
		f 4 -4733 4832 4833 -4831
		mu 0 4 2414 2415 2466 2465
		f 4 -4735 4834 4835 -4833
		mu 0 4 2415 2416 2467 2466
		f 4 -4737 4836 4837 -4835
		mu 0 4 2416 2417 2468 2467
		f 4 -4739 4838 4839 -4837
		mu 0 4 2417 2418 2469 2468
		f 4 -4741 4840 4841 -4839
		mu 0 4 2418 2419 2470 2469
		f 4 -4743 4842 4843 -4841
		mu 0 4 2419 2420 2471 2470
		f 4 -4745 4844 4845 -4843
		mu 0 4 2420 2421 2472 2471
		f 4 -4747 4846 4847 -4845
		mu 0 4 2421 2422 2473 2472
		f 4 -4749 4848 4849 -4847
		mu 0 4 2422 2423 2474 2473
		f 4 -4751 4850 4851 -4849
		mu 0 4 2423 2424 2475 2474
		f 4 -4753 4852 4853 -4851
		mu 0 4 2424 2425 2476 2475
		f 4 -4755 4854 4855 -4853
		mu 0 4 2425 2426 2477 2476
		f 4 -4757 4856 4857 -4855
		mu 0 4 2426 2427 2478 2477
		f 4 -4759 4858 4859 -4857
		mu 0 4 2427 2428 2479 2478
		f 4 -4761 4860 4861 -4859
		mu 0 4 2428 2429 2480 2479
		f 4 -4763 4862 4863 -4861
		mu 0 4 2429 2430 2481 2480
		f 4 -4765 4864 4865 -4863
		mu 0 4 2430 2431 2482 2481
		f 4 -4767 4866 4867 -4865
		mu 0 4 2431 2432 2483 2482
		f 4 -4769 4868 4869 -4867
		mu 0 4 2432 2433 2484 2483
		f 4 -4771 4870 4871 -4869
		mu 0 4 2433 2434 2485 2484
		f 4 -4773 4872 4873 -4871
		mu 0 4 2434 2435 2486 2485
		f 4 -4775 4874 4875 -4873
		mu 0 4 2435 2436 2487 2486
		f 4 -4777 4876 4877 -4875
		mu 0 4 2436 2437 2488 2487
		f 4 -4779 4878 4879 -4877
		mu 0 4 2437 2438 2489 2488
		f 4 -4781 4880 4881 -4879
		mu 0 4 2438 2439 2490 2489
		f 4 -4783 4882 4883 -4881
		mu 0 4 2439 2440 2491 2490
		f 4 -4785 4884 4885 -4883
		mu 0 4 2440 2441 2492 2491
		f 4 -4787 4886 4887 -4885
		mu 0 4 2441 2442 2493 2492
		f 4 -4789 4888 4889 -4887
		mu 0 4 2442 2443 2494 2493
		f 4 -4791 4890 4891 -4889
		mu 0 4 2443 2444 2495 2494
		f 4 -4793 4892 4893 -4891
		mu 0 4 2444 2445 2496 2495
		f 4 -4795 4894 4895 -4893
		mu 0 4 2445 2446 2497 2496
		f 4 -4797 4896 4897 -4895
		mu 0 4 2446 2447 2498 2497
		f 4 -4799 4898 4899 4900
		mu 0 4 2448 2449 2500 2499
		f 4 -4802 4901 4902 -4899
		mu 0 4 2449 2450 2501 2500
		f 4 -4804 4903 4904 -4902
		mu 0 4 2450 2451 2502 2501
		f 4 -4806 4905 4906 -4904
		mu 0 4 2451 2452 2503 2502
		f 4 -4808 4907 4908 -4906
		mu 0 4 2452 2453 2504 2503
		f 4 -4810 4909 4910 -4908
		mu 0 4 2453 2454 2505 2504
		f 4 -4812 4911 4912 -4910
		mu 0 4 2454 2455 2506 2505
		f 4 -4814 4913 4914 -4912
		mu 0 4 2455 2456 2507 2506
		f 4 -4816 4915 4916 -4914
		mu 0 4 2456 2457 2508 2507
		f 4 -4818 4917 4918 -4916
		mu 0 4 2457 2458 2509 2508
		f 4 -4820 4919 4920 -4918
		mu 0 4 2458 2459 2510 2509
		f 4 -4822 4921 4922 -4920
		mu 0 4 2459 2460 2511 2510
		f 4 -4824 4923 4924 -4922
		mu 0 4 2460 2461 2512 2511
		f 4 -4826 4925 4926 -4924
		mu 0 4 2461 2462 2513 2512
		f 4 -4828 4927 4928 -4926
		mu 0 4 2462 2463 2514 2513
		f 4 -4830 4929 4930 -4928
		mu 0 4 2463 2464 2515 2514
		f 4 -4832 4931 4932 -4930
		mu 0 4 2464 2465 2516 2515
		f 4 -4834 4933 4934 -4932
		mu 0 4 2465 2466 2517 2516
		f 4 -4836 4935 4936 -4934
		mu 0 4 2466 2467 2518 2517
		f 4 -4838 4937 4938 -4936
		mu 0 4 2467 2468 2519 2518
		f 4 -4840 4939 4940 -4938
		mu 0 4 2468 2469 2520 2519
		f 4 -4842 4941 4942 -4940
		mu 0 4 2469 2470 2521 2520
		f 4 -4844 4943 4944 -4942
		mu 0 4 2470 2471 2522 2521
		f 4 -4846 4945 4946 -4944
		mu 0 4 2471 2472 2523 2522
		f 4 -4848 4947 4948 -4946
		mu 0 4 2472 2473 2524 2523
		f 4 -4850 4949 4950 -4948
		mu 0 4 2473 2474 2525 2524
		f 4 -4852 4951 4952 -4950
		mu 0 4 2474 2475 2526 2525
		f 4 -4854 4953 4954 -4952
		mu 0 4 2475 2476 2527 2526
		f 4 -4856 4955 4956 -4954
		mu 0 4 2476 2477 2528 2527
		f 4 -4858 4957 4958 -4956
		mu 0 4 2477 2478 2529 2528
		f 4 -4860 4959 4960 -4958
		mu 0 4 2478 2479 2530 2529
		f 4 -4862 4961 4962 -4960
		mu 0 4 2479 2480 2531 2530
		f 4 -4864 4963 4964 -4962
		mu 0 4 2480 2481 2532 2531
		f 4 -4866 4965 4966 -4964
		mu 0 4 2481 2482 2533 2532
		f 4 -4868 4967 4968 -4966
		mu 0 4 2482 2483 2534 2533
		f 4 -4870 4969 4970 -4968
		mu 0 4 2483 2484 2535 2534
		f 4 -4872 4971 4972 -4970
		mu 0 4 2484 2485 2536 2535
		f 4 -4874 4973 4974 -4972
		mu 0 4 2485 2486 2537 2536
		f 4 -4876 4975 4976 -4974
		mu 0 4 2486 2487 2538 2537
		f 4 -4878 4977 4978 -4976
		mu 0 4 2487 2488 2539 2538
		f 4 -4880 4979 4980 -4978
		mu 0 4 2488 2489 2540 2539
		f 4 -4882 4981 4982 -4980
		mu 0 4 2489 2490 2541 2540
		f 4 -4884 4983 4984 -4982
		mu 0 4 2490 2491 2542 2541
		f 4 -4886 4985 4986 -4984
		mu 0 4 2491 2492 2543 2542
		f 4 -4888 4987 4988 -4986
		mu 0 4 2492 2493 2544 2543
		f 4 -4890 4989 4990 -4988
		mu 0 4 2493 2494 2545 2544
		f 4 -4892 4991 4992 -4990
		mu 0 4 2494 2495 2546 2545
		f 4 -4894 4993 4994 -4992
		mu 0 4 2495 2496 2547 2546
		f 4 -4896 4995 4996 -4994
		mu 0 4 2496 2497 2548 2547
		f 4 -4898 4997 4998 -4996
		mu 0 4 2497 2498 2549 2548
		f 4 -4900 4999 5000 5001
		mu 0 4 2499 2500 2551 2550
		f 4 -4903 5002 5003 -5000
		mu 0 4 2500 2501 2552 2551
		f 4 -4905 5004 5005 -5003
		mu 0 4 2501 2502 2553 2552
		f 4 -4907 5006 5007 -5005
		mu 0 4 2502 2503 2554 2553
		f 4 -4909 5008 5009 -5007
		mu 0 4 2503 2504 2555 2554
		f 4 -4911 5010 5011 -5009
		mu 0 4 2504 2505 2556 2555
		f 4 -4913 5012 5013 -5011
		mu 0 4 2505 2506 2557 2556
		f 4 -4915 5014 5015 -5013
		mu 0 4 2506 2507 2558 2557
		f 4 -4917 5016 5017 -5015
		mu 0 4 2507 2508 2559 2558
		f 4 -4919 5018 5019 -5017
		mu 0 4 2508 2509 2560 2559
		f 4 -4921 5020 5021 -5019
		mu 0 4 2509 2510 2561 2560
		f 4 -4923 5022 5023 -5021
		mu 0 4 2510 2511 2562 2561
		f 4 -4925 5024 5025 -5023
		mu 0 4 2511 2512 2563 2562
		f 4 -4927 5026 5027 -5025
		mu 0 4 2512 2513 2564 2563
		f 4 -4929 5028 5029 -5027
		mu 0 4 2513 2514 2565 2564
		f 4 -4931 5030 5031 -5029
		mu 0 4 2514 2515 2566 2565
		f 4 -4933 5032 5033 -5031
		mu 0 4 2515 2516 2567 2566
		f 4 -4935 5034 5035 -5033
		mu 0 4 2516 2517 2568 2567
		f 4 -4937 5036 5037 -5035
		mu 0 4 2517 2518 2569 2568
		f 4 -4939 5038 5039 -5037
		mu 0 4 2518 2519 2570 2569
		f 4 -4941 5040 5041 -5039
		mu 0 4 2519 2520 2571 2570
		f 4 -4943 5042 5043 -5041
		mu 0 4 2520 2521 2572 2571
		f 4 -4945 5044 5045 -5043
		mu 0 4 2521 2522 2573 2572
		f 4 -4947 5046 5047 -5045
		mu 0 4 2522 2523 2574 2573
		f 4 -4949 5048 5049 -5047
		mu 0 4 2523 2524 2575 2574
		f 4 -4951 5050 5051 -5049
		mu 0 4 2524 2525 2576 2575
		f 4 -4953 5052 5053 -5051
		mu 0 4 2525 2526 2577 2576
		f 4 -4955 5054 5055 -5053
		mu 0 4 2526 2527 2578 2577
		f 4 -4957 5056 5057 -5055
		mu 0 4 2527 2528 2579 2578
		f 4 -4959 5058 5059 -5057
		mu 0 4 2528 2529 2580 2579
		f 4 -4961 5060 5061 -5059
		mu 0 4 2529 2530 2581 2580
		f 4 -4963 5062 5063 -5061
		mu 0 4 2530 2531 2582 2581
		f 4 -4965 5064 5065 -5063
		mu 0 4 2531 2532 2583 2582
		f 4 -4967 5066 5067 -5065
		mu 0 4 2532 2533 2584 2583
		f 4 -4969 5068 5069 -5067
		mu 0 4 2533 2534 2585 2584
		f 4 -4971 5070 5071 -5069
		mu 0 4 2534 2535 2586 2585
		f 4 -4973 5072 5073 -5071
		mu 0 4 2535 2536 2587 2586
		f 4 -4975 5074 5075 -5073
		mu 0 4 2536 2537 2588 2587
		f 4 -4977 5076 5077 -5075
		mu 0 4 2537 2538 2589 2588
		f 4 -4979 5078 5079 -5077
		mu 0 4 2538 2539 2590 2589
		f 4 -4981 5080 5081 -5079
		mu 0 4 2539 2540 2591 2590
		f 4 -4983 5082 5083 -5081
		mu 0 4 2540 2541 2592 2591
		f 4 -4985 5084 5085 -5083
		mu 0 4 2541 2542 2593 2592
		f 4 -4987 5086 5087 -5085
		mu 0 4 2542 2543 2594 2593
		f 4 -4989 5088 5089 -5087
		mu 0 4 2543 2544 2595 2594
		f 4 -4991 5090 5091 -5089
		mu 0 4 2544 2545 2596 2595
		f 4 -4993 5092 5093 -5091
		mu 0 4 2545 2546 2597 2596
		f 4 -4995 5094 5095 -5093
		mu 0 4 2546 2547 2598 2597
		f 4 -4997 5096 5097 -5095
		mu 0 4 2547 2548 2599 2598
		f 4 -4999 5098 5099 -5097
		mu 0 4 2548 2549 2600 2599;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".vnm" 0;
createNode transform -n "particle1";
createNode particle -n "particleShape1" -p "particle1";
	addAttr -ci true -sn "glmInitDirection" -ln "glmInitDirection" -dt "vectorArray";
	addAttr -ci true -h true -sn "glmInitDirection0" -ln "glmInitDirection0" -dt "vectorArray";
	addAttr -ci true -sn "glmEntityType" -ln "glmEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityType0" -ln "glmEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "groupEntityType" -ln "groupEntityType" -dt "doubleArray";
	addAttr -ci true -h true -sn "groupEntityType0" -ln "groupEntityType0" -dt "doubleArray";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -ci true -sn "populationGroupId" -ln "populationGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "populationGroupId0" -ln "populationGroupId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -dt "doubleArray";
	addAttr -ci true -sn "glmEntityId" -ln "glmEntityId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmEntityId0" -ln "glmEntityId0" -dt "doubleArray";
	addAttr -ci true -sn "glmGroupId" -ln "glmGroupId" -dt "doubleArray";
	addAttr -ci true -h true -sn "glmGroupId0" -ln "glmGroupId0" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -at "double";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 75 -26.864401000000001 15.820220000000001
		 -12.516184000000001 -26.054393999999998 17.139927 17.197417999999999 -24.765761999999999
		 17.073706000000001 28.376915 -38.896233000000002 16.176088 -23.814613000000001 -29.418461000000001
		 17.457364999999999 -51.947043999999998 -25.699359999999999 17.73649 -48.853172000000001 -35.132111000000002
		 16.246089999999999 -23.067416999999999 -37.608516999999999 16.757196 10.635451 -39.027904999999997
		 17.125174999999999 16.226284 -25.559391000000002 16.728403 11.216659999999999 -24.544827000000002
		 16.163599000000001 6.2673959999999997 -37.273468000000001 16.453690000000002 5.3088509999999998 -38.267105000000001
		 16.635815000000001 -35.352715000000003 -33.096375000000002 16.955684999999999 17.974411 -26.284078999999998
		 16.28124 -18.796279999999999 -32.153202 15.723841999999999 -6.9905549999999996 -24.507815999999998
		 16.827192 34.956023999999999 -39.097149000000002 16.929698999999999 36.13485 -32.496937000000003
		 16.382308999999999 -20.109214999999999 -35.429015999999997 16.176962 2.1298059999999999 -39.952506999999997
		 16.425661000000002 -14.891465999999999 -28.960080999999999 17.576357000000002 -39.845874999999999 -31.845749000000001
		 15.827306 0.51006899999999999 -38.373341000000003 16.189543 0.62446299999999999 -35.615718999999999
		 16.530895000000001 26.575474 -32.016112999999997 16.710353999999999 11.264241 -41.135212000000003
		 17.264771 -44.575946999999999 -33.807071999999998 16.658203 -28.648277 -41.310555000000001
		 17.187415999999999 -40.912132 -40.766852999999998 16.8002 20.379749 -34.593390999999997
		 17.277654999999999 -41.221404999999997 -29.711748 16.998287000000001 19.104485 -32.099266
		 16.683451000000002 35.142364999999998 -27.481933999999999 16.852245 26.656101 -29.108340999999999
		 15.633248 -4.2149200000000002 -33.419643000000001 16.663795 22.634941000000001 -40.714500000000001
		 16.26248 -9.8884849999999993 -28.669104000000001 16.879217000000001 13.993815 -25.735329
		 16.496366999999999 -24.45797 -30.779769999999999 16.960578999999999 -30.304531000000001 -33.123035000000002
		 17.437628 -47.940556000000001 -31.639963000000002 15.826881999999999 -11.363255000000001 -28.838705000000001
		 16.806992000000001 -28.166065 -34.903793 16.867374000000002 20.166118999999998 -39.622481999999998
		 16.438573999999999 -27.551113000000001 -28.065757999999999 16.580942 32.135185 -25.762699000000001
		 17.196504999999998 23.134150999999999 -32.789906000000002 16.294167999999999 4.8068819999999999 -35.766044999999998
		 17.127770999999999 -52.411262999999998 -34.648933 16.764966999999999 -33.217213000000001 -33.560271999999998
		 16.64996 31.562351 -25.514885 17.843848999999999 -43.733955000000002 -36.446143999999997
		 15.911503 -9.3986870000000007 -39.565055999999998 16.724824999999999 25.699978000000002 -32.097382000000003
		 17.290355999999999 -38.258243999999998 -37.860889 16.537133999999998 23.454594 -28.991436
		 16.417553000000002 -21.173259999999999 -36.241196000000002 17.272091 -45.799830999999998 -31.529095000000002
		 16.457149999999999 -25.067191999999999 -29.488295000000001 15.818431 2.080384 -40.985396999999999
		 17.006354999999999 14.216472 -39.776038999999997 16.608388999999999 8.0858740000000004 -41.316417999999999
		 16.595074 -33.007182999999998 -34.902290000000001 16.152348 -15.619907 -37.053370999999999
		 16.576848999999999 -31.750149 -40.241238000000003 16.911314000000001 31.679881999999999 -31.947904999999999
		 16.327342999999999 29.264347000000001 -34.005752999999999 15.750539 -4.7947660000000001 -28.962147000000002
		 17.272789 -33.768166000000001 -28.781433 17.703334999999999 -46.902316999999996 -36.796322000000004
		 17.209105000000001 -43.049492000000001 -29.092226 15.718239000000001 -10.167971 -36.452064999999997
		 16.954350000000002 13.925557 -37.190753999999998 16.051302 -12.148434 -40.105297
		 16.241325 -20.327487999999999 ;
	setAttr ".vel0" -type "vectorArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "horseAndRider_startup";
	setAttr ".mas0" -type "doubleArray" 75 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 75 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 ;
	setAttr ".nid" 75;
	setAttr ".nid0" 75;
	setAttr ".bt0" -type "doubleArray" 75 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 ;
	setAttr ".ag0" -type "doubleArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 350;
	setAttr ".glmInitDirection0" -type "vectorArray" 75 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".glmEntityType0" -type "doubleArray" 75 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 75 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 75 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421 1.3999999761581421
		 1.3999999761581421 1.3999999761581421 1.3999999761581421 ;
	setAttr ".populationGroupId0" -type "doubleArray" 75 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 75 1.7976931348623157e+308 1.7976931348623157e+308
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
		 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 75 1001 2001 3001 4001 5001 6001
		 7001 8001 9001 10001 11001 12001 13001 14001 15001 16001 17001 18001 19001 20001
		 21001 22001 23001 24001 25001 26001 27001 28001 29001 30001 31001 32001 33001 34001
		 35001 36001 37001 38001 39001 40001 41001 42001 43001 44001 45001 46001 47001 48001
		 49001 50001 51001 52001 53001 54001 55001 56001 57001 58001 59001 60001 61001 62001
		 63001 64001 65001 66001 67001 68001 69001 70001 71001 72001 73001 74001 75001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 75 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode CrowdField -n "crowdField1";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr -l on ".cfid" 1;
	setAttr -l on ".noe" 75;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 5 ".lnk";
	setAttr -s 5 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode lambert -n "lambert2";
	setAttr ".dc" 0.51265823841094971;
createNode shadingEngine -n "pPlane1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode lambert -n "crowdLambert1";
createNode shadingEngine -n "crowdLambert1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode hyperGraphInfo -n "nodeEditorPanel1Info";
createNode hyperView -n "hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 25 ".hyp";
	setAttr ".anf" yes;
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"top\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n"
		+ "                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 1\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n"
		+ "                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n"
		+ "                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n"
		+ "            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 1\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n"
		+ "            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n"
		+ "            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"side\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n"
		+ "                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 1\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n"
		+ "                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 1\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n"
		+ "            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n"
		+ "            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"front\" \n                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 1\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n"
		+ "                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 1\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n"
		+ "            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n"
		+ "            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n"
		+ "                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 0\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 0\n            -imagePlane 1\n"
		+ "            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n"
		+ "                -docTag \"isolOutln_fromSeln\" \n                -showShapes 0\n                -showReferenceNodes 1\n                -showReferenceMembers 1\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 1\n                -showAssets 1\n                -showContainedOnly 1\n                -showPublishedAsConnected 0\n                -showContainerContents 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n"
		+ "                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n"
		+ "            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n"
		+ "            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\tif ($useSceneConfig) {\n\t\toutlinerPanel -e -to $panelName;\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n"
		+ "                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n"
		+ "                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n"
		+ "                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n"
		+ "                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n"
		+ "                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n"
		+ "                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n"
		+ "                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n"
		+ "                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n"
		+ "                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n"
		+ "                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"sequenceEditorPanel\" -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
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
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\tif ($useSceneConfig) {\n\t\tscriptedPanel -e -to $panelName;\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"Stereo\" -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels `;\n"
		+ "string $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n"
		+ "                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n"
		+ "                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -displayMode \"centerEye\" \n"
		+ "                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.xC:/Golaem/GolaemCrowdSamples-3.5.1/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 0\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 0\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 350 -ast 1 -aet 350 ";
	setAttr ".st" 6;
createNode materialInfo -n "materialInfo3";
createNode shadingEngine -n "pPlane1SG1";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode lambert -n "lambert3";
	setAttr ".dc" 0.51265823841094971;
createNode script -n "script1";
	addAttr -ci true -sn "crnd" -ln "currentRenderer" -dt "string";
	addAttr -ci true -sn "sstp" -ln "shadersStartPath" -dt "string";
	addAttr -ci true -sn "lprp" -ln "isLightProps" -dt "string";
	addAttr -ci true -sn "ecdlg" -ln "enableConfirmDialog" -dt "string";
	setAttr ".b" -type "string" "string $packdir = `dirmap -cd \"/atomo/pipeline/tools/golaem/characterPack/5.2/\"`;string $scriptName = $packdir + \"script/sampleGUI.mel\";eval(\"source \\\"\" + $scriptName + \"\\\"\");glmCrowdSampleConfig(\"\");";
	setAttr ".a" -type "string" "glmDeleteSampleConfigWindow()";
	setAttr ".st" 2;
	setAttr ".sstp" -type "string" "golaem/shaders/HorseAndRider";
	setAttr ".ecdlg" -type "string" "1";
createNode CrowdBeOpCondition -n "beOpCondition1";
createNode CrowdBeOpCondition -n "beOpCondition2";
createNode CrowdBeOpCondition -n "beOpCondition3";
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
	setAttr -s 5 ".st";
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
	setAttr -s 4 ".s";
select -ne :lightList1;
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
connectAttr "pPlane1.msg" "terrainShape1.mgg[0]";
connectAttr "terrainShape1.msg" "crowdManagerNodeShape.trr";
connectAttr "entityTypeShape1.msg" "crowdManagerNodeShape.ine[0]";
connectAttr ":time1.o" "crowdManagerNodeShape.ct";
connectAttr "entityTypeContainerShape1.msg" "entityTypeShape1.ibc";
connectAttr "beOpParallelShape1.nb" "entityTypeContainerShape1.fb[0]";
connectAttr "triOpAndShape1.msg" "beAdaptGround1StartTriggerShape.tro";
connectAttr "beAdaptGround1StartTriggerShape.ctr" "triOpAndShape1.pco";
connectAttr "triBoolShape1.net" "triOpAndShape1.prt[0]";
connectAttr "beAdaptGround1StartTriggerShape.ctr" "triBoolShape1.pco";
connectAttr "triOpAndShape2.msg" "beAdaptGround1StopTriggerShape.tro";
connectAttr "beAdaptGround1StopTriggerShape.ctr" "triOpAndShape2.pco";
connectAttr "triBoolShape2.net" "triOpAndShape2.prt[0]";
connectAttr "beAdaptGround1StopTriggerShape.ctr" "triBoolShape2.pco";
connectAttr "triOpAndShape3.msg" "beAdaptOrientation1StartTriggerShape.tro";
connectAttr "beAdaptOrientation1StartTriggerShape.ctr" "triOpAndShape3.pco";
connectAttr "triBoolShape3.net" "triOpAndShape3.prt[0]";
connectAttr "beAdaptOrientation1StartTriggerShape.ctr" "triBoolShape3.pco";
connectAttr "triOpAndShape4.msg" "beAdaptOrientation1StopTriggerShape.tro";
connectAttr "beAdaptOrientation1StopTriggerShape.ctr" "triOpAndShape4.pco";
connectAttr "triBoolShape4.net" "triOpAndShape4.prt[0]";
connectAttr "beAdaptOrientation1StopTriggerShape.ctr" "triBoolShape4.pco";
connectAttr "triOpAndShape5.msg" "beMotion1StartTriggerShape.tro";
connectAttr "beMotion1StartTriggerShape.ctr" "triOpAndShape5.pco";
connectAttr "triBoolShape5.net" "triOpAndShape5.prt[0]";
connectAttr "beMotion1StartTriggerShape.ctr" "triBoolShape5.pco";
connectAttr "triOpAndShape6.msg" "beMotion1StopTriggerShape.tro";
connectAttr "beMotion1StopTriggerShape.ctr" "triOpAndShape6.pco";
connectAttr "triBoolShape6.net" "triOpAndShape6.prt[0]";
connectAttr "beMotion1StopTriggerShape.ctr" "triBoolShape6.pco";
connectAttr "horseAndRider_galopShape1.msg" "beMotionShape1.mcp[0]";
connectAttr "beOpParallelShape1.chb" "beMotionShape1.pb";
connectAttr "beMotion1StartTriggerShape.msg" "beMotionShape1.isac";
connectAttr "beOpCondition1.msg" "beMotionShape1.scnd" -na;
connectAttr "beOpCondition1.msg" "beMotionShape1.fcnd";
connectAttr "beOpCondition1.msg" "beMotionShape1.lcnd";
connectAttr "beOpParallelShape1.chb" "beAdaptGroundShape1.pb";
connectAttr "beAdaptGround1StartTriggerShape.msg" "beAdaptGroundShape1.isac";
connectAttr "beOpCondition3.msg" "beAdaptGroundShape1.scnd" -na;
connectAttr "beOpCondition3.msg" "beAdaptGroundShape1.fcnd";
connectAttr "beOpCondition3.msg" "beAdaptGroundShape1.lcnd";
connectAttr "entityTypeContainerShape1.chb" "beOpParallelShape1.pb";
connectAttr "entityTypeContainerShape1.ib" "beOpParallelShape1.prb[0]";
connectAttr "beAdaptOrientation1StartTriggerShape.msg" "beAdaptOrientationShape1.isac"
		;
connectAttr "beOpCondition2.msg" "beAdaptOrientationShape1.scnd" -na;
connectAttr "beOpCondition2.msg" "beAdaptOrientationShape1.fcnd";
connectAttr "beOpCondition2.msg" "beAdaptOrientationShape1.lcnd";
connectAttr "terrainShape1.msg" "popToolShape1.int";
connectAttr "entityTypeShape1.msg" "popToolShape1.ine" -na;
connectAttr ":time1.o" "particleShape1.cti";
connectAttr "crowdManagerNodeShape.sf" "particleShape1.stf";
connectAttr "crowdField1.of[0]" "particleShape1.ifc[0]";
connectAttr "crowdManagerNodeShape.sf" "crowdField1.sf";
connectAttr "particleShape1.fd" "crowdField1.ind[0]";
connectAttr "particleShape1.ppfd[0]" "crowdField1.ppda[0]";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "pPlane1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "pPlane1SG1.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "pPlane1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "pPlane1SG1.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "lambert2.oc" "pPlane1SG.ss";
connectAttr "pPlane1SG.msg" "materialInfo1.sg";
connectAttr "lambert2.msg" "materialInfo1.m";
connectAttr "entityTypeShape1.dc" "crowdLambert1.c";
connectAttr "crowdLambert1.oc" "crowdLambert1SG.ss";
connectAttr "crowdLambert1SG.msg" "materialInfo2.sg";
connectAttr "crowdLambert1.msg" "materialInfo2.m";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "hyperLayout1.msg" "hyperView1.hl";
connectAttr "terrain1.msg" "hyperLayout1.hyp[0].dn";
connectAttr "terrainShape1.msg" "hyperLayout1.hyp[1].dn";
connectAttr "crowdManagerNode.msg" "hyperLayout1.hyp[2].dn";
connectAttr "crowdManagerNodeShape.msg" "hyperLayout1.hyp[3].dn";
connectAttr "entityType1.msg" "hyperLayout1.hyp[4].dn";
connectAttr "entityTypeShape1.msg" "hyperLayout1.hyp[5].dn";
connectAttr "entityTypeContainer1.msg" "hyperLayout1.hyp[6].dn";
connectAttr "entityTypeContainerShape1.msg" "hyperLayout1.hyp[7].dn";
connectAttr "crowdBehaviors.msg" "hyperLayout1.hyp[8].dn";
connectAttr "crowdLambert1.msg" "hyperLayout1.hyp[11].dn";
connectAttr "crowdLambert1SG.msg" "hyperLayout1.hyp[12].dn";
connectAttr "popTool1.msg" "hyperLayout1.hyp[14].dn";
connectAttr "popToolShape1.msg" "hyperLayout1.hyp[15].dn";
connectAttr "beMotion1.msg" "hyperLayout1.hyp[19].dn";
connectAttr "beMotionShape1.msg" "hyperLayout1.hyp[20].dn";
connectAttr "crowdTriggers.msg" "hyperLayout1.hyp[23].dn";
connectAttr "horseAndRider_galop1.msg" "hyperLayout1.hyp[26].dn";
connectAttr "horseAndRider_galopShape1.msg" "hyperLayout1.hyp[27].dn";
connectAttr "crowdMotionClips.msg" "hyperLayout1.hyp[28].dn";
connectAttr "persp1.msg" "hyperLayout1.hyp[29].dn";
connectAttr "perspShape2.msg" "hyperLayout1.hyp[30].dn";
connectAttr "directionalLight1.msg" "hyperLayout1.hyp[31].dn";
connectAttr "directionalLightShape1.msg" "hyperLayout1.hyp[32].dn";
connectAttr "uiConfigurationScriptNode.msg" "hyperLayout1.hyp[33].dn";
connectAttr "sceneConfigurationScriptNode.msg" "hyperLayout1.hyp[34].dn";
connectAttr "pPlane1SG1.msg" "materialInfo3.sg";
connectAttr "lambert3.msg" "materialInfo3.m";
connectAttr "lambert3.oc" "pPlane1SG1.ss";
connectAttr "pPlane1Shape.iog" "pPlane1SG1.dsm" -na;
connectAttr "beMotion1StopTriggerShape.msg" "beOpCondition1.ctri";
connectAttr "beAdaptOrientation1StopTriggerShape.msg" "beOpCondition2.ctri";
connectAttr "beAdaptGround1StopTriggerShape.msg" "beOpCondition3.ctri";
connectAttr "pPlane1SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert1SG.pa" ":renderPartition.st" -na;
connectAttr "pPlane1SG1.pa" ":renderPartition.st" -na;
connectAttr "particleShape1.iog" ":initialParticleSE.dsm" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of horseAndRider.ma
