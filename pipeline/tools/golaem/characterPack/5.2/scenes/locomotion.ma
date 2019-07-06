//Maya ASCII 2014 scene
//Name: locomotion.ma
//Last modified: Fri, Jun 03, 2016 04:57:59 PM
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
	setAttr ".t" -type "double3" 48.178349832526223 22.525954050990642 3.2983179800083371 ;
	setAttr ".r" -type "double3" -29.738352729542019 -270.60000000000167 -3.0372615078267937e-013 ;
	setAttr ".rp" -type "double3" 0 0 3.5527136788005009e-015 ;
	setAttr ".rpt" -type "double3" 0 3.5527136788005017e-015 -3.5527136788005017e-015 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999986;
	setAttr ".coi" 55.832252186784565;
	setAttr ".ow" 101.63515948324527;
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
createNode transform -n "crowdManagerNode";
	addAttr -ci true -sn "trCAMPath" -ln "trCAMPath" -nn "Asset Management File" -dt "string";
	addAttr -ci true -sn "trCAAPath" -ln "trCAAPath" -nn "Asset Association File" -dt "string";
	addAttr -ci true -sn "trSCName" -ln "trSCName" -nn "Simulation Cache Name" -dt "string";
	addAttr -ci true -sn "trSCOutDir" -ln "trSCOutDir" -nn "Simulation Cache Output Directory" 
		-dt "string";
	addAttr -ci true -sn "trFbxOutDir" -ln "trFbxOutDir" -nn "FBX Output Directory" 
		-dt "string";
	addAttr -ci true -sn "trRibOutDir" -ln "trRibOutDir" -nn "RIB Output Directory" 
		-dt "string";
	addAttr -ci true -sn "trMRayOutDir" -ln "trMRayOutDir" -nn "MentalRay Output Directory" 
		-dt "string";
	addAttr -ci true -sn "trVRayOutDir" -ln "trVRayOutDir" -nn "V-Ray Output Directory" 
		-dt "string";
	addAttr -ci true -sn "trArnoldOutDir" -ln "trArnoldOutDir" -nn "Arnold Output Directory" 
		-dt "string";
	addAttr -ci true -sn "trBETabs" -ln "trBETabs" -nn "Behavior Editor Tabs" -dt "string";
	addAttr -ci true -sn "trBECTab" -ln "trBECTab" -nn "Behavior Editor Current Tab" 
		-at "float";
	addAttr -ci true -sn "trTriTabs" -ln "trTriTabs" -nn "Trigger Editor Tabs" -dt "string";
	addAttr -ci true -sn "trTriCTab" -ln "trTriCTab" -nn "Trigger Editor Current Tab" 
		-at "float";
	setAttr ".trCAMPath" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan.cam";
	setAttr ".trBETabs" -type "string" "entityTypeContainerShape1#";
	setAttr ".trTriTabs" -type "string" "";
	setAttr ".trTriCTab" -1;
createNode CrowdManagerNode -n "crowdManagerNodeShape" -p "crowdManagerNode";
	setAttr -k off ".v";
	setAttr ".dsc" -type "string" "";
	setAttr ".dsp" -type "string" "";
	setAttr ".pps" -type "string" "particleShape3";
	setAttr ".ppid" 12;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".amwtidx" 1;
	setAttr ".drm" -type "string" "";
lockNode -l 1 ;
createNode transform -n "entityType1";
createNode CrowdEntityTypeNode -n "entityTypeShape1" -p "entityType1";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 1 0.49803922 0 ;
	setAttr -l on ".etid" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 44 ;
	setAttr ".bf" 3;
createNode transform -n "crowdBehaviors";
createNode transform -n "entityTypeContainer1" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape1" -p "entityTypeContainer1";
	setAttr -k off ".v";
	setAttr ".fpx" 600;
createNode transform -n "crowdTriggers" -p "crowdBehaviors";
createNode transform -n "CrowdManLocomotion:beLocomotion1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "CrowdManLocomotion:beLocomotion1StartTriggerShape" 
		-p "CrowdManLocomotion:beLocomotion1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd1" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape1" -p "triOpAnd1";
	setAttr -k off ".v";
createNode transform -n "triBool1" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape1" -p "triBool1";
	setAttr -k off ".v";
createNode transform -n "CrowdManLocomotion:beLocomotion1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "CrowdManLocomotion:beLocomotion1StopTriggerShape" 
		-p "CrowdManLocomotion:beLocomotion1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd2" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape2" -p "triOpAnd2";
	setAttr -k off ".v";
createNode transform -n "triBool2" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape2" -p "triBool2";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beAdaptGround1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beAdaptGround1StartTriggerShape" -p "beAdaptGround1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd3" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape3" -p "triOpAnd3";
	setAttr -k off ".v";
createNode transform -n "triBool3" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape3" -p "triBool3";
	setAttr -k off ".v";
createNode transform -n "beAdaptGround1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beAdaptGround1StopTriggerShape" -p "beAdaptGround1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd4" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape4" -p "triOpAnd4";
	setAttr -k off ".v";
createNode transform -n "triBool4" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape4" -p "triBool4";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beGoto1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beGoto1StartTriggerShape" -p "beGoto1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd5" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape5" -p "triOpAnd5";
	setAttr -k off ".v";
createNode transform -n "triBool5" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape5" -p "triBool5";
	setAttr -k off ".v";
createNode transform -n "beGoto1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beGoto1StopTriggerShape" -p "beGoto1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd6" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape6" -p "triOpAnd6";
	setAttr -k off ".v";
createNode transform -n "triBool6" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape6" -p "triBool6";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beNavigation1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beNavigation1StartTriggerShape" -p "beNavigation1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd7" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape7" -p "triOpAnd7";
	setAttr -k off ".v";
createNode transform -n "triBool7" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape7" -p "triBool7";
	setAttr -k off ".v";
createNode transform -n "beNavigation1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beNavigation1StopTriggerShape" -p "beNavigation1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd8" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape8" -p "triOpAnd8";
	setAttr -k off ".v";
createNode transform -n "triBool8" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape8" -p "triBool8";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beNavigation1" -p "crowdBehaviors";
createNode CrowdBeNavigation -n "beNavigationShape1" -p "beNavigation1";
	setAttr -k off ".v";
	setAttr ".bpy" -82;
createNode transform -n "beGoto1" -p "crowdBehaviors";
createNode CrowdBeGoto -n "beGotoShape1" -p "beGoto1";
	setAttr -k off ".v";
	setAttr ".tm" 2;
createNode transform -n "beOpParallel1" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape1" -p "beOpParallel1";
	setAttr -k off ".v";
	setAttr ".bpx" 116;
	setAttr ".bpy" 99;
createNode transform -n "beAdaptGround1" -p "crowdBehaviors";
createNode CrowdBeAdaptGround -n "beAdaptGroundShape1" -p "beAdaptGround1";
	setAttr -k off ".v";
	setAttr ".bpy" 31;
createNode transform -n "crowdMotionClips" -p "crowdBehaviors";
createNode transform -n "StandClip" -p "crowdMotionClips";
createNode MotionClip -n "Stand" -p "StandClip";
	setAttr -k off ".v";
	setAttr ".mcid" 1;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_Stand.gmo";
	setAttr -l on ".fn" 119;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 1.3784529e-012 0 1.4708235e-012 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 2.803633e-013 0 2.9915052e-013 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 6.2120209e-018 2.1344334e-007 -3.3350522e-009 ;
	setAttr ".rvl" -type "float3" 1.2634618e-018 4.3412204e-008 -6.7831568e-010 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 2.8036292e-013 -3.5173402e-022 2.9915068e-013 ;
createNode transform -n "StandOrientLeft45_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "StandOrientLeft45_LeftFoot" -p "StandOrientLeft45_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 2;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft45_LeftFoot.gmo";
	setAttr -l on ".fn" 31;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 5.2154064e-008 0 2.0489097e-008 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 4.1723251e-008 0 1.6391278e-008 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 38.500805 0.33329034 -0.89114529 ;
	setAttr ".rvl" -type "float3" 30.800642 0.26663229 -0.71291625 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 3.7015841e-008 -2.7629229e-012 1.5041744e-008 ;
createNode transform -n "StandOrientLeft90_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "StandOrientLeft90_LeftFoot" -p "StandOrientLeft90_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 3;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft90_LeftFoot.gmo";
	setAttr -l on ".fn" 31;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" -0.020771252 0 -1.1175871e-008 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" -0.016617002 0 -8.9406971e-009 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 79.92041 -1.3191996 -2.6760547 ;
	setAttr ".rvl" -type "float3" 63.936329 -1.0553596 -2.1408439 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" -0.0097516179 1.0181068e-005 -0.00027275042 ;
createNode transform -n "StandOrientLeft135_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "StandOrientLeft135_LeftFoot" -p "StandOrientLeft135_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 4;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft135_LeftFoot.gmo";
	setAttr -l on ".fn" 31;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 0.093471259 0 0.13501379 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 0.074777007 0 0.10801103 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 119.94749 -0.96965635 -3.0861912 ;
	setAttr ".rvl" -type "float3" 95.958 -0.77572507 -2.4689529 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 0.017135222 1.2481906e-009 0.028082043 ;
createNode transform -n "StandOrientLeft180_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "StandOrientLeft180_LeftFoot" -p "StandOrientLeft180_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 5;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft180_LeftFoot.gmo";
	setAttr -l on ".fn" 57;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 0.12462829 0 -0.051928535 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 0.053412121 0 -0.022255085 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 179.96841 -4.2138391 -0.85884053 ;
	setAttr ".rvl" -type "float3" 77.129311 -1.8059309 -0.36807451 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 4.1692863e-010 5.6006383e-010 -2.5940275e-010 ;
createNode transform -n "WalkSlow_LeftfootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkSlow_Leftfoot" -p "WalkSlow_LeftfootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 6;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkSlow_Leftfoot.gmo";
	setAttr -l on ".fn" 54;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" -0.70217568 0 0 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" -0.31796631 0 0 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -0.00059950451 -0.064354867 0.098539665 ;
	setAttr ".rvl" -type "float3" -0.00027147372 -0.029141823 0.044621732 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" -0.31796634 -3.5518358e-006 -3.0595655e-007 ;
createNode transform -n "WalkNormal_LeftfootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkNormal_Leftfoot" -p "WalkNormal_LeftfootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 7;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkNormal_Leftfoot.gmo";
	setAttr -l on ".fn" 31;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" -1.4115177 0 0 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" -1.1292142 0 0 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 3.9756934e-016 -2.1344336e-007 2.1344336e-007 ;
	setAttr ".rvl" -type "float3" 3.1805547e-016 -1.7075469e-007 1.7075469e-007 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" -1.129214 1.1546945e-008 6.4657191e-009 ;
createNode transform -n "WalkFast_LeftfootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkFast_Leftfoot" -p "WalkFast_LeftfootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 8;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkFast_Leftfoot.gmo";
	setAttr -l on ".fn" 27;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" -1.5725996 0 0 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" -1.4516304 0 0 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" 3.9756934e-016 -2.1344336e-007 2.1344336e-007 ;
	setAttr ".rvl" -type "float3" 3.6698706e-016 -1.9702463e-007 1.9702463e-007 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" -1.4516301 1.009679e-008 4.083911e-009 ;
createNode transform -n "WalkTurnRight45_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkTurnRight45_LeftFoot" -p "WalkTurnRight45_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 9;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight45_LeftFoot.gmo";
	setAttr -l on ".fn" 37;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 0.73644066 0 -0.94563055 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 0.49096045 0 -0.63042039 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -41.792686 2.3707871 -1.9675457 ;
	setAttr ".rvl" -type "float3" -27.861792 1.5805247 -1.3116971 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 0.42222151 -0.00012535146 -0.55422843 ;
createNode transform -n "WalkTurnRight90_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkTurnRight90_LeftFoot" -p "WalkTurnRight90_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 10;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight90_LeftFoot.gmo";
	setAttr -l on ".fn" 37;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 0.33423871 0 -0.88622046 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 0.22282581 0 -0.59081364 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -73.460754 4.9355907 -1.4922906 ;
	setAttr ".rvl" -type "float3" -48.973835 3.2903938 -0.99486041 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 0.13484441 -0.00042073108 -0.38138556 ;
createNode transform -n "WalkTurnRight135_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkTurnRight135_LeftFoot" -p "WalkTurnRight135_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 11;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight135_LeftFoot.gmo";
	setAttr -l on ".fn" 35;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 0.57104135 0 -0.15126705 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 0.40308797 0 -0.10677674 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -105.10561 5.3777766 -12.391813 ;
	setAttr ".rvl" -type "float3" -74.192192 3.7960775 -8.7471619 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 0.14350349 -5.4004409e-005 -0.044102773 ;
createNode transform -n "WalkTurnRight180_LeftFootClip" -p "crowdMotionClips";
createNode MotionClip -n "WalkTurnRight180_LeftFoot" -p "WalkTurnRight180_LeftFootClip";
	setAttr -k off ".v";
	setAttr ".mcid" 12;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight180_LeftFoot.gmo";
	setAttr -l on ".fn" 32;
	setAttr -l on ".fr" 24;
	setAttr -l on ".rot" -type "float3" 0.23533964 0 -1.2039217e-007 ;
	setAttr -l on ".rot";
	setAttr -l on ".vl" -type "float3" 0.18219842 0 -9.3206836e-008 ;
	setAttr -l on ".vl";
	setAttr ".ror" -type "float3" -179.67018 9.895505 -3.8085349 ;
	setAttr ".rvl" -type "float3" -139.09949 7.6610355 -2.9485431 ;
	setAttr -l on ".ic" -type "float3" 0 1 0 ;
	setAttr -l on ".ic";
	setAttr -l on ".il" -type "float3" 0 1 0 ;
	setAttr -l on ".il";
	setAttr -l on ".ili" -type "float3" 0 1 0 ;
	setAttr -l on ".ili";
	setAttr ".hed" -type "float3" 2.1601152e-009 -4.5990536e-009 2.3885005e-010 ;
createNode transform -n "pPlane1";
createNode mesh -n "pPlaneShape1" -p "pPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 2112 ".uvst[0].uvsp";
	setAttr ".uvst[0].uvsp[0:249]" -type "float2" 0 0 0.02 0 0.039999999 0 0.059999999
		 0 0.079999998 0 0.099999994 0 0.12 0 0.14 0 0.16 0 0.17999999 0 0.19999999 0 0.22
		 0 0.23999999 0 0.25999999 0 0.28 0 0.29999998 0 0.31999999 0 0.34 0 0.35999998 0
		 0.38 0 0.39999998 0 0.41999999 0 0.44 0 0.45999998 0 0.47999999 0 0.5 0 0.51999998
		 0 0.53999996 0 0.56 0 0.57999998 0 0.59999996 0 0.62 0 0.63999999 0 0.65999997 0
		 0.68000001 0 0.69999999 0 0.71999997 0 0.74000001 0 0.75999999 0 0.77999997 0 0.79999995
		 0 0.81999999 0 0.83999997 0 0.85999995 0 0.88 0 0.89999998 0 0.91999996 0 0.94 0
		 0.95999998 0 0.97999996 0 1 0 0 0.02 0.02 0.02 0.039999999 0.02 0.059999999 0.02
		 0.079999998 0.02 0.099999994 0.02 0.12 0.02 0.14 0.02 0.16 0.02 0.17999999 0.02 0.19999999
		 0.02 0.22 0.02 0.23999999 0.02 0.25999999 0.02 0.28 0.02 0.29999998 0.02 0.31999999
		 0.02 0.34 0.02 0.35999998 0.02 0.38 0.02 0.39999998 0.02 0.41999999 0.02 0.44 0.02
		 0.45999998 0.02 0.47999999 0.02 0.5 0.02 0.51999998 0.02 0.53999996 0.02 0.56 0.02
		 0.57999998 0.02 0.59999996 0.02 0.62 0.02 0.63999999 0.02 0.65999997 0.02 0.68000001
		 0.02 0.69999999 0.02 0.71999997 0.02 0.74000001 0.02 0.75999999 0.02 0.77999997 0.02
		 0.79999995 0.02 0.81999999 0.02 0.83999997 0.02 0.85999995 0.02 0.88 0.02 0.89999998
		 0.02 0.91999996 0.02 0.94 0.02 0.95999998 0.02 0.97999996 0.02 1 0.02 0 0.039999999
		 0.02 0.039999999 0.039999999 0.039999999 0.059999999 0.039999999 0.079999998 0.039999999
		 0.099999994 0.039999999 0.12 0.039999999 0.14 0.039999999 0.16 0.039999999 0.17999999
		 0.039999999 0.19999999 0.039999999 0.22 0.039999999 0.23999999 0.039999999 0.25999999
		 0.039999999 0.28 0.039999999 0.29999998 0.039999999 0.31999999 0.039999999 0.34 0.039999999
		 0.35999998 0.039999999 0.38 0.039999999 0.39999998 0.039999999 0.41999999 0.039999999
		 0.44 0.039999999 0.45999998 0.039999999 0.47999999 0.039999999 0.5 0.039999999 0.51999998
		 0.039999999 0.53999996 0.039999999 0.56 0.039999999 0.57999998 0.039999999 0.59999996
		 0.039999999 0.62 0.039999999 0.63999999 0.039999999 0.65999997 0.039999999 0.68000001
		 0.039999999 0.69999999 0.039999999 0.71999997 0.039999999 0.74000001 0.039999999
		 0.75999999 0.039999999 0.77999997 0.039999999 0.79999995 0.039999999 0.81999999 0.039999999
		 0.83999997 0.039999999 0.85999995 0.039999999 0.88 0.039999999 0.89999998 0.039999999
		 0.91999996 0.039999999 0.94 0.039999999 0.95999998 0.039999999 0.97999996 0.039999999
		 1 0.039999999 0 0.059999999 0.02 0.059999999 0.039999999 0.059999999 0.059999999
		 0.059999999 0.079999998 0.059999999 0.099999994 0.059999999 0.12 0.059999999 0.14
		 0.059999999 0.16 0.059999999 0.17999999 0.059999999 0.19999999 0.059999999 0.22 0.059999999
		 0.23999999 0.059999999 0.25999999 0.059999999 0.28 0.059999999 0.29999998 0.059999999
		 0.31999999 0.059999999 0.34 0.059999999 0.35999998 0.059999999 0.38 0.059999999 0.39999998
		 0.059999999 0.41999999 0.059999999 0.44 0.059999999 0.45999998 0.059999999 0.47999999
		 0.059999999 0.5 0.059999999 0.51999998 0.059999999 0.53999996 0.059999999 0.56 0.059999999
		 0.57999998 0.059999999 0.59999996 0.059999999 0.62 0.059999999 0.63999999 0.059999999
		 0.65999997 0.059999999 0.68000001 0.059999999 0.69999999 0.059999999 0.71999997 0.059999999
		 0.74000001 0.059999999 0.75999999 0.059999999 0.77999997 0.059999999 0.79999995 0.059999999
		 0.81999999 0.059999999 0.83999997 0.059999999 0.85999995 0.059999999 0.88 0.059999999
		 0.89999998 0.059999999 0.91999996 0.059999999 0.94 0.059999999 0.95999998 0.059999999
		 0.97999996 0.059999999 1 0.059999999 0 0.079999998 0.02 0.079999998 0.039999999 0.079999998
		 0.059999999 0.079999998 0.079999998 0.079999998 0.099999994 0.079999998 0.12 0.079999998
		 0.14 0.079999998 0.16 0.079999998 0.17999999 0.079999998 0.19999999 0.079999998 0.22
		 0.079999998 0.23999999 0.079999998 0.25999999 0.079999998 0.28 0.079999998 0.29999998
		 0.079999998 0.31999999 0.079999998 0.34 0.079999998 0.35999998 0.079999998 0.38 0.079999998
		 0.39999998 0.079999998 0.41999999 0.079999998 0.44 0.079999998 0.45999998 0.079999998
		 0.47999999 0.079999998 0.5 0.079999998 0.51999998 0.079999998 0.53999996 0.079999998
		 0.56 0.079999998 0.57999998 0.079999998 0.59999996 0.079999998 0.62 0.079999998 0.63999999
		 0.079999998 0.65999997 0.079999998 0.68000001 0.079999998 0.69999999 0.079999998
		 0.71999997 0.079999998 0.74000001 0.079999998 0.75999999 0.079999998 0.77999997 0.079999998
		 0.79999995 0.079999998 0.81999999 0.079999998 0.83999997 0.079999998 0.85999995 0.079999998
		 0.88 0.079999998 0.89999998 0.079999998;
	setAttr ".uvst[0].uvsp[250:499]" 0.91999996 0.079999998 0.94 0.079999998 0.95999998
		 0.079999998 0.97999996 0.079999998 1 0.079999998 0 0.099999994 0.02 0.099999994 0.039999999
		 0.099999994 0.059999999 0.099999994 0.079999998 0.099999994 0.099999994 0.099999994
		 0.12 0.099999994 0.14 0.099999994 0.16 0.099999994 0.17999999 0.099999994 0.19999999
		 0.099999994 0.22 0.099999994 0.23999999 0.099999994 0.25999999 0.099999994 0.28 0.099999994
		 0.29999998 0.099999994 0.31999999 0.099999994 0.34 0.099999994 0.35999998 0.099999994
		 0.38 0.099999994 0.39999998 0.099999994 0.41999999 0.099999994 0.44 0.099999994 0.45999998
		 0.099999994 0.47999999 0.099999994 0.5 0.099999994 0.51999998 0.099999994 0.53999996
		 0.099999994 0.56 0.099999994 0.57999998 0.099999994 0.59999996 0.099999994 0.62 0.099999994
		 0.63999999 0.099999994 0.65999997 0.099999994 0.68000001 0.099999994 0.69999999 0.099999994
		 0.71999997 0.099999994 0.74000001 0.099999994 0.75999999 0.099999994 0.77999997 0.099999994
		 0.79999995 0.099999994 0.81999999 0.099999994 0.83999997 0.099999994 0.85999995 0.099999994
		 0.88 0.099999994 0.89999998 0.099999994 0.91999996 0.099999994 0.94 0.099999994 0.95999998
		 0.099999994 0.97999996 0.099999994 1 0.099999994 0 0.12 0.02 0.12 0.039999999 0.12
		 0.059999999 0.12 0.079999998 0.12 0.099999994 0.12 0.12 0.12 0.14 0.12 0.16 0.12
		 0.17999999 0.12 0.19999999 0.12 0.22 0.12 0.23999999 0.12 0.25999999 0.12 0.28 0.12
		 0.29999998 0.12 0.31999999 0.12 0.34 0.12 0.35999998 0.12 0.38 0.12 0.39999998 0.12
		 0.41999999 0.12 0.44 0.12 0.45999998 0.12 0.47999999 0.12 0.5 0.12 0.51999998 0.12
		 0.53999996 0.12 0.56 0.12 0.57999998 0.12 0.59999996 0.12 0.62 0.12 0.63999999 0.12
		 0.65999997 0.12 0.68000001 0.12 0.69999999 0.12 0.71999997 0.12 0.74000001 0.12 0.75999999
		 0.12 0.77999997 0.12 0.79999995 0.12 0.81999999 0.12 0.83999997 0.12 0.85999995 0.12
		 0.88 0.12 0.89999998 0.12 0.91999996 0.12 0.94 0.12 0.95999998 0.12 0.97999996 0.12
		 1 0.12 0 0.14 0.02 0.14 0.039999999 0.14 0.059999999 0.14 0.079999998 0.14 0.099999994
		 0.14 0.12 0.14 0.14 0.14 0.16 0.14 0.17999999 0.14 0.19999999 0.14 0.22 0.14 0.23999999
		 0.14 0.25999999 0.14 0.28 0.14 0.29999998 0.14 0.31999999 0.14 0.34 0.14 0.35999998
		 0.14 0.38 0.14 0.39999998 0.14 0.41999999 0.14 0.44 0.14 0.45999998 0.14 0.47999999
		 0.14 0.5 0.14 0.51999998 0.14 0.53999996 0.14 0.56 0.14 0.57999998 0.14 0.59999996
		 0.14 0.62 0.14 0.63999999 0.14 0.65999997 0.14 0.68000001 0.14 0.69999999 0.14 0.71999997
		 0.14 0.74000001 0.14 0.75999999 0.14 0.77999997 0.14 0.79999995 0.14 0.81999999 0.14
		 0.83999997 0.14 0.85999995 0.14 0.88 0.14 0.89999998 0.14 0.91999996 0.14 0.94 0.14
		 0.95999998 0.14 0.97999996 0.14 1 0.14 0 0.16 0.02 0.16 0.039999999 0.16 0.059999999
		 0.16 0.079999998 0.16 0.099999994 0.16 0.12 0.16 0.14 0.16 0.16 0.16 0.17999999 0.16
		 0.19999999 0.16 0.22 0.16 0.23999999 0.16 0.25999999 0.16 0.28 0.16 0.29999998 0.16
		 0.31999999 0.16 0.34 0.16 0.35999998 0.16 0.38 0.16 0.39999998 0.16 0.41999999 0.16
		 0.44 0.16 0.45999998 0.16 0.47999999 0.16 0.5 0.16 0.51999998 0.16 0.53999996 0.16
		 0.56 0.16 0.57999998 0.16 0.59999996 0.16 0.62 0.16 0.63999999 0.16 0.65999997 0.16
		 0.68000001 0.16 0.69999999 0.16 0.71999997 0.16 0.74000001 0.16 0.75999999 0.16 0.77999997
		 0.16 0.79999995 0.16 0.81999999 0.16 0.83999997 0.16 0.85999995 0.16 0.88 0.16 0.89999998
		 0.16 0.91999996 0.16 0.94 0.16 0.95999998 0.16 0.97999996 0.16 1 0.16 0 0.17999999
		 0.02 0.17999999 0.039999999 0.17999999 0.059999999 0.17999999 0.079999998 0.17999999
		 0.099999994 0.17999999 0.12 0.17999999 0.14 0.17999999 0.16 0.17999999 0.17999999
		 0.17999999 0.19999999 0.17999999 0.22 0.17999999 0.23999999 0.17999999 0.25999999
		 0.17999999 0.28 0.17999999 0.29999998 0.17999999 0.31999999 0.17999999 0.34 0.17999999
		 0.35999998 0.17999999 0.38 0.17999999 0.39999998 0.17999999 0.41999999 0.17999999
		 0.83999997 0.17999999 0.85999995 0.17999999 0.88 0.17999999 0.89999998 0.17999999
		 0.91999996 0.17999999 0.94 0.17999999 0.95999998 0.17999999 0.97999996 0.17999999
		 1 0.17999999 0 0.19999999 0.02 0.19999999 0.039999999 0.19999999 0.059999999 0.19999999
		 0.079999998 0.19999999 0.099999994 0.19999999 0.12 0.19999999 0.14 0.19999999 0.16
		 0.19999999 0.17999999 0.19999999;
	setAttr ".uvst[0].uvsp[500:749]" 0.19999999 0.19999999 0.22 0.19999999 0.23999999
		 0.19999999 0.25999999 0.19999999 0.28 0.19999999 0.29999998 0.19999999 0.31999999
		 0.19999999 0.34 0.19999999 0.35999998 0.19999999 0.38 0.19999999 0.39999998 0.19999999
		 0.41999999 0.19999999 0.83999997 0.19999999 0.85999995 0.19999999 0.88 0.19999999
		 0.89999998 0.19999999 0.91999996 0.19999999 0.94 0.19999999 0.95999998 0.19999999
		 0.97999996 0.19999999 1 0.19999999 0 0.22 0.02 0.22 0.039999999 0.22 0.059999999
		 0.22 0.079999998 0.22 0.099999994 0.22 0.12 0.22 0.14 0.22 0.16 0.22 0.17999999 0.22
		 0.19999999 0.22 0.22 0.22 0.23999999 0.22 0.25999999 0.22 0.28 0.22 0.29999998 0.22
		 0.31999999 0.22 0.34 0.22 0.35999998 0.22 0.38 0.22 0.39999998 0.22 0.41999999 0.22
		 0.83999997 0.22 0.85999995 0.22 0.88 0.22 0.89999998 0.22 0.91999996 0.22 0.94 0.22
		 0.95999998 0.22 0.97999996 0.22 1 0.22 0 0.23999999 0.02 0.23999999 0.039999999 0.23999999
		 0.059999999 0.23999999 0.079999998 0.23999999 0.099999994 0.23999999 0.12 0.23999999
		 0.14 0.23999999 0.16 0.23999999 0.17999999 0.23999999 0.19999999 0.23999999 0.22
		 0.23999999 0.23999999 0.23999999 0.25999999 0.23999999 0.28 0.23999999 0.29999998
		 0.23999999 0.31999999 0.23999999 0.34 0.23999999 0.35999998 0.23999999 0.38 0.23999999
		 0.39999998 0.23999999 0.41999999 0.23999999 0.83999997 0.23999999 0.85999995 0.23999999
		 0.88 0.23999999 0.89999998 0.23999999 0.91999996 0.23999999 0.94 0.23999999 0.95999998
		 0.23999999 0.97999996 0.23999999 1 0.23999999 0 0.25999999 0.02 0.25999999 0.039999999
		 0.25999999 0.059999999 0.25999999 0.079999998 0.25999999 0.099999994 0.25999999 0.12
		 0.25999999 0.14 0.25999999 0.16 0.25999999 0.17999999 0.25999999 0.19999999 0.25999999
		 0.22 0.25999999 0.23999999 0.25999999 0.25999999 0.25999999 0.28 0.25999999 0.29999998
		 0.25999999 0.31999999 0.25999999 0.34 0.25999999 0.35999998 0.25999999 0.38 0.25999999
		 0.39999998 0.25999999 0.41999999 0.25999999 0.83999997 0.25999999 0.85999995 0.25999999
		 0.88 0.25999999 0.89999998 0.25999999 0.91999996 0.25999999 0.94 0.25999999 0.95999998
		 0.25999999 0.97999996 0.25999999 1 0.25999999 0 0.28 0.02 0.28 0.039999999 0.28 0.059999999
		 0.28 0.079999998 0.28 0.099999994 0.28 0.12 0.28 0.14 0.28 0.16 0.28 0.17999999 0.28
		 0.19999999 0.28 0.22 0.28 0.23999999 0.28 0.25999999 0.28 0.28 0.28 0.29999998 0.28
		 0.31999999 0.28 0.34 0.28 0.35999998 0.28 0.38 0.28 0.39999998 0.28 0.41999999 0.28
		 0.44 0.28 0.45999998 0.28 0.47999999 0.28 0.5 0.28 0.51999998 0.28 0.53999996 0.28
		 0.56 0.28 0.57999998 0.28 0.59999996 0.28 0.62 0.28 0.63999999 0.28 0.65999997 0.28
		 0.68000001 0.28 0.69999999 0.28 0.71999997 0.28 0.74000001 0.28 0.75999999 0.28 0.77999997
		 0.28 0.79999995 0.28 0.81999999 0.28 0.83999997 0.28 0.85999995 0.28 0.88 0.28 0.89999998
		 0.28 0.91999996 0.28 0.94 0.28 0.95999998 0.28 0.97999996 0.28 1 0.28 0 0.29999998
		 0.02 0.29999998 0.039999999 0.29999998 0.059999999 0.29999998 0.079999998 0.29999998
		 0.099999994 0.29999998 0.12 0.29999998 0.14 0.29999998 0.16 0.29999998 0.17999999
		 0.29999998 0.19999999 0.29999998 0.22 0.29999998 0.23999999 0.29999998 0.25999999
		 0.29999998 0.28 0.29999998 0.29999998 0.29999998 0.31999999 0.29999998 0.34 0.29999998
		 0.35999998 0.29999998 0.38 0.29999998 0.39999998 0.29999998 0.41999999 0.29999998
		 0.44 0.29999998 0.45999998 0.29999998 0.47999999 0.29999998 0.5 0.29999998 0.51999998
		 0.29999998 0.53999996 0.29999998 0.56 0.29999998 0.57999998 0.29999998 0.59999996
		 0.29999998 0.62 0.29999998 0.63999999 0.29999998 0.65999997 0.29999998 0.68000001
		 0.29999998 0.69999999 0.29999998 0.71999997 0.29999998 0.74000001 0.29999998 0.75999999
		 0.29999998 0.77999997 0.29999998 0.79999995 0.29999998 0.81999999 0.29999998 0.83999997
		 0.29999998 0.85999995 0.29999998 0.88 0.29999998 0.89999998 0.29999998 0.91999996
		 0.29999998 0.94 0.29999998 0.95999998 0.29999998 0.97999996 0.29999998 1 0.29999998
		 0 0.31999999 0.02 0.31999999 0.039999999 0.31999999 0.059999999 0.31999999 0.079999998
		 0.31999999 0.099999994 0.31999999 0.12 0.31999999 0.14 0.31999999 0.16 0.31999999
		 0.17999999 0.31999999 0.19999999 0.31999999 0.22 0.31999999 0.23999999 0.31999999
		 0.25999999 0.31999999 0.28 0.31999999 0.29999998 0.31999999 0.31999999 0.31999999
		 0.34 0.31999999 0.35999998 0.31999999 0.38 0.31999999 0.39999998 0.31999999 0.41999999
		 0.31999999 0.44 0.31999999 0.45999998 0.31999999 0.47999999 0.31999999 0.5 0.31999999
		 0.51999998 0.31999999 0.53999996 0.31999999 0.56 0.31999999 0.57999998 0.31999999
		 0.59999996 0.31999999 0.62 0.31999999 0.63999999 0.31999999 0.65999997 0.31999999;
	setAttr ".uvst[0].uvsp[750:999]" 0.68000001 0.31999999 0.69999999 0.31999999
		 0.71999997 0.31999999 0.74000001 0.31999999 0.75999999 0.31999999 0.77999997 0.31999999
		 0.79999995 0.31999999 0.81999999 0.31999999 0.83999997 0.31999999 0.85999995 0.31999999
		 0.88 0.31999999 0.89999998 0.31999999 0.91999996 0.31999999 0.94 0.31999999 0.95999998
		 0.31999999 0.97999996 0.31999999 1 0.31999999 0 0.34 0.02 0.34 0.039999999 0.34 0.059999999
		 0.34 0.079999998 0.34 0.099999994 0.34 0.12 0.34 0.14 0.34 0.16 0.34 0.17999999 0.34
		 0.19999999 0.34 0.22 0.34 0.23999999 0.34 0.25999999 0.34 0.28 0.34 0.29999998 0.34
		 0.31999999 0.34 0.34 0.34 0.35999998 0.34 0.38 0.34 0.39999998 0.34 0.41999999 0.34
		 0.44 0.34 0.45999998 0.34 0.47999999 0.34 0.5 0.34 0.51999998 0.34 0.53999996 0.34
		 0.56 0.34 0.57999998 0.34 0.59999996 0.34 0.62 0.34 0.63999999 0.34 0.65999997 0.34
		 0.68000001 0.34 0.69999999 0.34 0.71999997 0.34 0.74000001 0.34 0.75999999 0.34 0.77999997
		 0.34 0.79999995 0.34 0.81999999 0.34 0.83999997 0.34 0.85999995 0.34 0.88 0.34 0.89999998
		 0.34 0.91999996 0.34 0.94 0.34 0.95999998 0.34 0.97999996 0.34 1 0.34 0 0.35999998
		 0.02 0.35999998 0.039999999 0.35999998 0.059999999 0.35999998 0.079999998 0.35999998
		 0.099999994 0.35999998 0.12 0.35999998 0.14 0.35999998 0.16 0.35999998 0.17999999
		 0.35999998 0.19999999 0.35999998 0.22 0.35999998 0.23999999 0.35999998 0.25999999
		 0.35999998 0.28 0.35999998 0.29999998 0.35999998 0.31999999 0.35999998 0.34 0.35999998
		 0.35999998 0.35999998 0.38 0.35999998 0.39999998 0.35999998 0.41999999 0.35999998
		 0.44 0.35999998 0.45999998 0.35999998 0.47999999 0.35999998 0.5 0.35999998 0.51999998
		 0.35999998 0.53999996 0.35999998 0.56 0.35999998 0.57999998 0.35999998 0.59999996
		 0.35999998 0.62 0.35999998 0.63999999 0.35999998 0.65999997 0.35999998 0.68000001
		 0.35999998 0.69999999 0.35999998 0.71999997 0.35999998 0.74000001 0.35999998 0.75999999
		 0.35999998 0.77999997 0.35999998 0.79999995 0.35999998 0.81999999 0.35999998 0.83999997
		 0.35999998 0.85999995 0.35999998 0.88 0.35999998 0.89999998 0.35999998 0.91999996
		 0.35999998 0.94 0.35999998 0.95999998 0.35999998 0.97999996 0.35999998 1 0.35999998
		 0 0.38 0.02 0.38 0.039999999 0.38 0.059999999 0.38 0.079999998 0.38 0.099999994 0.38
		 0.45999998 0.38 0.47999999 0.38 0.5 0.38 0.51999998 0.38 0.53999996 0.38 0.56 0.38
		 0.57999998 0.38 0.59999996 0.38 0.62 0.38 0.63999999 0.38 0.65999997 0.38 0.68000001
		 0.38 0.69999999 0.38 0.83999997 0.38 0.85999995 0.38 0.88 0.38 0.89999998 0.38 0.91999996
		 0.38 0.94 0.38 0.95999998 0.38 0.97999996 0.38 1 0.38 0 0.39999998 0.02 0.39999998
		 0.039999999 0.39999998 0.059999999 0.39999998 0.079999998 0.39999998 0.099999994
		 0.39999998 0.45999998 0.39999998 0.47999999 0.39999998 0.5 0.39999998 0.51999998
		 0.39999998 0.53999996 0.39999998 0.56 0.39999998 0.57999998 0.39999998 0.59999996
		 0.39999998 0.62 0.39999998 0.63999999 0.39999998 0.65999997 0.39999998 0.68000001
		 0.39999998 0.69999999 0.39999998 0.83999997 0.39999998 0.85999995 0.39999998 0.88
		 0.39999998 0.89999998 0.39999998 0.91999996 0.39999998 0.94 0.39999998 0.95999998
		 0.39999998 0.97999996 0.39999998 1 0.39999998 0 0.41999999 0.02 0.41999999 0.039999999
		 0.41999999 0.059999999 0.41999999 0.079999998 0.41999999 0.099999994 0.41999999 0.45999998
		 0.41999999 0.47999999 0.41999999 0.5 0.41999999 0.51999998 0.41999999 0.53999996
		 0.41999999 0.56 0.41999999 0.57999998 0.41999999 0.59999996 0.41999999 0.62 0.41999999
		 0.63999999 0.41999999 0.65999997 0.41999999 0.68000001 0.41999999 0.69999999 0.41999999
		 0.83999997 0.41999999 0.85999995 0.41999999 0.88 0.41999999 0.89999998 0.41999999
		 0.91999996 0.41999999 0.94 0.41999999 0.95999998 0.41999999 0.97999996 0.41999999
		 1 0.41999999 0 0.44 0.02 0.44 0.039999999 0.44 0.059999999 0.44 0.079999998 0.44
		 0.099999994 0.44 0.45999998 0.44 0.47999999 0.44 0.5 0.44 0.51999998 0.44 0.53999996
		 0.44 0.56 0.44 0.57999998 0.44 0.59999996 0.44 0.62 0.44 0.63999999 0.44 0.65999997
		 0.44 0.68000001 0.44 0.69999999 0.44 0.83999997 0.44 0.85999995 0.44 0.88 0.44 0.89999998
		 0.44 0.91999996 0.44 0.94 0.44 0.95999998 0.44 0.97999996 0.44 1 0.44 0 0.45999998
		 0.02 0.45999998 0.039999999 0.45999998 0.059999999 0.45999998 0.079999998 0.45999998
		 0.099999994 0.45999998 0.12 0.45999998 0.14 0.45999998 0.16 0.45999998 0.17999999
		 0.45999998 0.19999999 0.45999998 0.22 0.45999998 0.23999999 0.45999998 0.25999999
		 0.45999998 0.28 0.45999998 0.29999998 0.45999998 0.31999999 0.45999998 0.34 0.45999998
		 0.35999998 0.45999998;
	setAttr ".uvst[0].uvsp[1000:1249]" 0.38 0.45999998 0.39999998 0.45999998 0.41999999
		 0.45999998 0.44 0.45999998 0.45999998 0.45999998 0.47999999 0.45999998 0.5 0.45999998
		 0.51999998 0.45999998 0.53999996 0.45999998 0.56 0.45999998 0.57999998 0.45999998
		 0.59999996 0.45999998 0.62 0.45999998 0.63999999 0.45999998 0.65999997 0.45999998
		 0.68000001 0.45999998 0.69999999 0.45999998 0.83999997 0.45999998 0.85999995 0.45999998
		 0.88 0.45999998 0.89999998 0.45999998 0.91999996 0.45999998 0.94 0.45999998 0.95999998
		 0.45999998 0.97999996 0.45999998 1 0.45999998 0 0.47999999 0.02 0.47999999 0.039999999
		 0.47999999 0.059999999 0.47999999 0.079999998 0.47999999 0.099999994 0.47999999 0.12
		 0.47999999 0.14 0.47999999 0.16 0.47999999 0.17999999 0.47999999 0.19999999 0.47999999
		 0.22 0.47999999 0.23999999 0.47999999 0.25999999 0.47999999 0.28 0.47999999 0.29999998
		 0.47999999 0.31999999 0.47999999 0.34 0.47999999 0.35999998 0.47999999 0.38 0.47999999
		 0.39999998 0.47999999 0.41999999 0.47999999 0.44 0.47999999 0.45999998 0.47999999
		 0.47999999 0.47999999 0.5 0.47999999 0.51999998 0.47999999 0.53999996 0.47999999
		 0.56 0.47999999 0.57999998 0.47999999 0.59999996 0.47999999 0.62 0.47999999 0.63999999
		 0.47999999 0.65999997 0.47999999 0.68000001 0.47999999 0.69999999 0.47999999 0.83999997
		 0.47999999 0.85999995 0.47999999 0.88 0.47999999 0.89999998 0.47999999 0.91999996
		 0.47999999 0.94 0.47999999 0.95999998 0.47999999 0.97999996 0.47999999 1 0.47999999
		 0 0.5 0.02 0.5 0.039999999 0.5 0.059999999 0.5 0.079999998 0.5 0.099999994 0.5 0.12
		 0.5 0.14 0.5 0.16 0.5 0.17999999 0.5 0.19999999 0.5 0.22 0.5 0.23999999 0.5 0.25999999
		 0.5 0.28 0.5 0.29999998 0.5 0.31999999 0.5 0.34 0.5 0.35999998 0.5 0.38 0.5 0.39999998
		 0.5 0.41999999 0.5 0.44 0.5 0.45999998 0.5 0.47999999 0.5 0.5 0.5 0.51999998 0.5
		 0.53999996 0.5 0.56 0.5 0.57999998 0.5 0.59999996 0.5 0.62 0.5 0.63999999 0.5 0.65999997
		 0.5 0.68000001 0.5 0.69999999 0.5 0.83999997 0.5 0.85999995 0.5 0.88 0.5 0.89999998
		 0.5 0.91999996 0.5 0.94 0.5 0.95999998 0.5 0.97999996 0.5 1 0.5 0 0.51999998 0.02
		 0.51999998 0.039999999 0.51999998 0.059999999 0.51999998 0.079999998 0.51999998 0.099999994
		 0.51999998 0.12 0.51999998 0.14 0.51999998 0.16 0.51999998 0.17999999 0.51999998
		 0.19999999 0.51999998 0.22 0.51999998 0.23999999 0.51999998 0.25999999 0.51999998
		 0.28 0.51999998 0.29999998 0.51999998 0.31999999 0.51999998 0.34 0.51999998 0.35999998
		 0.51999998 0.38 0.51999998 0.39999998 0.51999998 0.41999999 0.51999998 0.44 0.51999998
		 0.45999998 0.51999998 0.47999999 0.51999998 0.5 0.51999998 0.51999998 0.51999998
		 0.53999996 0.51999998 0.56 0.51999998 0.57999998 0.51999998 0.59999996 0.51999998
		 0.62 0.51999998 0.63999999 0.51999998 0.65999997 0.51999998 0.68000001 0.51999998
		 0.69999999 0.51999998 0.83999997 0.51999998 0.85999995 0.51999998 0.88 0.51999998
		 0.89999998 0.51999998 0.91999996 0.51999998 0.94 0.51999998 0.95999998 0.51999998
		 0.97999996 0.51999998 1 0.51999998 0 0.53999996 0.02 0.53999996 0.039999999 0.53999996
		 0.059999999 0.53999996 0.079999998 0.53999996 0.099999994 0.53999996 0.12 0.53999996
		 0.14 0.53999996 0.16 0.53999996 0.17999999 0.53999996 0.19999999 0.53999996 0.22
		 0.53999996 0.23999999 0.53999996 0.25999999 0.53999996 0.28 0.53999996 0.29999998
		 0.53999996 0.31999999 0.53999996 0.34 0.53999996 0.35999998 0.53999996 0.38 0.53999996
		 0.39999998 0.53999996 0.41999999 0.53999996 0.44 0.53999996 0.45999998 0.53999996
		 0.47999999 0.53999996 0.5 0.53999996 0.51999998 0.53999996 0.53999996 0.53999996
		 0.56 0.53999996 0.57999998 0.53999996 0.59999996 0.53999996 0.62 0.53999996 0.63999999
		 0.53999996 0.65999997 0.53999996 0.68000001 0.53999996 0.69999999 0.53999996 0.83999997
		 0.53999996 0.85999995 0.53999996 0.88 0.53999996 0.89999998 0.53999996 0.91999996
		 0.53999996 0.94 0.53999996 0.95999998 0.53999996 0.97999996 0.53999996 1 0.53999996
		 0 0.56 0.02 0.56 0.039999999 0.56 0.059999999 0.56 0.079999998 0.56 0.099999994 0.56
		 0.12 0.56 0.14 0.56 0.16 0.56 0.17999999 0.56 0.19999999 0.56 0.22 0.56 0.23999999
		 0.56 0.25999999 0.56 0.28 0.56 0.29999998 0.56 0.31999999 0.56 0.34 0.56 0.35999998
		 0.56 0.38 0.56 0.39999998 0.56 0.41999999 0.56 0.44 0.56 0.45999998 0.56 0.47999999
		 0.56 0.5 0.56 0.51999998 0.56 0.53999996 0.56 0.56 0.56 0.57999998 0.56 0.59999996
		 0.56 0.62 0.56 0.63999999 0.56 0.65999997 0.56 0.68000001 0.56 0.69999999 0.56 0.83999997
		 0.56 0.85999995 0.56 0.88 0.56 0.89999998 0.56 0.91999996 0.56 0.94 0.56 0.95999998
		 0.56 0.97999996 0.56;
	setAttr ".uvst[0].uvsp[1250:1499]" 1 0.56 0 0.57999998 0.02 0.57999998 0.039999999
		 0.57999998 0.059999999 0.57999998 0.079999998 0.57999998 0.099999994 0.57999998 0.12
		 0.57999998 0.14 0.57999998 0.16 0.57999998 0.17999999 0.57999998 0.19999999 0.57999998
		 0.22 0.57999998 0.23999999 0.57999998 0.25999999 0.57999998 0.28 0.57999998 0.29999998
		 0.57999998 0.31999999 0.57999998 0.34 0.57999998 0.35999998 0.57999998 0.38 0.57999998
		 0.39999998 0.57999998 0.41999999 0.57999998 0.44 0.57999998 0.45999998 0.57999998
		 0.47999999 0.57999998 0.5 0.57999998 0.51999998 0.57999998 0.53999996 0.57999998
		 0.56 0.57999998 0.57999998 0.57999998 0.59999996 0.57999998 0.62 0.57999998 0.63999999
		 0.57999998 0.65999997 0.57999998 0.68000001 0.57999998 0.69999999 0.57999998 0.83999997
		 0.57999998 0.85999995 0.57999998 0.88 0.57999998 0.89999998 0.57999998 0.91999996
		 0.57999998 0.94 0.57999998 0.95999998 0.57999998 0.97999996 0.57999998 1 0.57999998
		 0 0.59999996 0.02 0.59999996 0.039999999 0.59999996 0.059999999 0.59999996 0.079999998
		 0.59999996 0.099999994 0.59999996 0.12 0.59999996 0.14 0.59999996 0.16 0.59999996
		 0.17999999 0.59999996 0.19999999 0.59999996 0.22 0.59999996 0.23999999 0.59999996
		 0.25999999 0.59999996 0.28 0.59999996 0.29999998 0.59999996 0.31999999 0.59999996
		 0.34 0.59999996 0.35999998 0.59999996 0.38 0.59999996 0.39999998 0.59999996 0.41999999
		 0.59999996 0.44 0.59999996 0.45999998 0.59999996 0.47999999 0.59999996 0.5 0.59999996
		 0.51999998 0.59999996 0.53999996 0.59999996 0.56 0.59999996 0.57999998 0.59999996
		 0.59999996 0.59999996 0.62 0.59999996 0.63999999 0.59999996 0.65999997 0.59999996
		 0.68000001 0.59999996 0.69999999 0.59999996 0.83999997 0.59999996 0.85999995 0.59999996
		 0.88 0.59999996 0.89999998 0.59999996 0.91999996 0.59999996 0.94 0.59999996 0.95999998
		 0.59999996 0.97999996 0.59999996 1 0.59999996 0 0.62 0.02 0.62 0.039999999 0.62 0.059999999
		 0.62 0.079999998 0.62 0.099999994 0.62 0.12 0.62 0.14 0.62 0.16 0.62 0.17999999 0.62
		 0.19999999 0.62 0.22 0.62 0.56 0.62 0.57999998 0.62 0.59999996 0.62 0.62 0.62 0.63999999
		 0.62 0.65999997 0.62 0.68000001 0.62 0.69999999 0.62 0.83999997 0.62 0.85999995 0.62
		 0.88 0.62 0.89999998 0.62 0.91999996 0.62 0.94 0.62 0.95999998 0.62 0.97999996 0.62
		 1 0.62 0 0.63999999 0.02 0.63999999 0.039999999 0.63999999 0.059999999 0.63999999
		 0.079999998 0.63999999 0.099999994 0.63999999 0.12 0.63999999 0.14 0.63999999 0.16
		 0.63999999 0.17999999 0.63999999 0.19999999 0.63999999 0.22 0.63999999 0.56 0.63999999
		 0.57999998 0.63999999 0.59999996 0.63999999 0.62 0.63999999 0.63999999 0.63999999
		 0.65999997 0.63999999 0.68000001 0.63999999 0.69999999 0.63999999 0.83999997 0.63999999
		 0.85999995 0.63999999 0.88 0.63999999 0.89999998 0.63999999 0.91999996 0.63999999
		 0.94 0.63999999 0.95999998 0.63999999 0.97999996 0.63999999 1 0.63999999 0 0.65999997
		 0.02 0.65999997 0.039999999 0.65999997 0.059999999 0.65999997 0.079999998 0.65999997
		 0.099999994 0.65999997 0.12 0.65999997 0.14 0.65999997 0.16 0.65999997 0.17999999
		 0.65999997 0.19999999 0.65999997 0.22 0.65999997 0.56 0.65999997 0.57999998 0.65999997
		 0.59999996 0.65999997 0.62 0.65999997 0.63999999 0.65999997 0.65999997 0.65999997
		 0.68000001 0.65999997 0.69999999 0.65999997 0.83999997 0.65999997 0.85999995 0.65999997
		 0.88 0.65999997 0.89999998 0.65999997 0.91999996 0.65999997 0.94 0.65999997 0.95999998
		 0.65999997 0.97999996 0.65999997 1 0.65999997 0 0.68000001 0.02 0.68000001 0.039999999
		 0.68000001 0.059999999 0.68000001 0.079999998 0.68000001 0.099999994 0.68000001 0.12
		 0.68000001 0.14 0.68000001 0.16 0.68000001 0.17999999 0.68000001 0.19999999 0.68000001
		 0.22 0.68000001 0.56 0.68000001 0.57999998 0.68000001 0.59999996 0.68000001 0.62
		 0.68000001 0.63999999 0.68000001 0.65999997 0.68000001 0.68000001 0.68000001 0.69999999
		 0.68000001 0.83999997 0.68000001 0.85999995 0.68000001 0.88 0.68000001 0.89999998
		 0.68000001 0.91999996 0.68000001 0.94 0.68000001 0.95999998 0.68000001 0.97999996
		 0.68000001 1 0.68000001 0 0.69999999 0.02 0.69999999 0.039999999 0.69999999 0.059999999
		 0.69999999 0.079999998 0.69999999 0.099999994 0.69999999 0.12 0.69999999 0.14 0.69999999
		 0.16 0.69999999 0.17999999 0.69999999 0.19999999 0.69999999 0.22 0.69999999 0.56
		 0.69999999 0.57999998 0.69999999 0.59999996 0.69999999 0.62 0.69999999 0.63999999
		 0.69999999 0.65999997 0.69999999 0.68000001 0.69999999 0.69999999 0.69999999 0.83999997
		 0.69999999 0.85999995 0.69999999 0.88 0.69999999 0.89999998 0.69999999 0.91999996
		 0.69999999 0.94 0.69999999 0.95999998 0.69999999 0.97999996 0.69999999 1 0.69999999
		 0 0.71999997 0.02 0.71999997 0.039999999 0.71999997 0.059999999 0.71999997 0.079999998
		 0.71999997 0.099999994 0.71999997 0.12 0.71999997 0.14 0.71999997 0.16 0.71999997
		 0.17999999 0.71999997 0.19999999 0.71999997 0.22 0.71999997 0.56 0.71999997 0.57999998
		 0.71999997;
	setAttr ".uvst[0].uvsp[1500:1749]" 0.59999996 0.71999997 0.62 0.71999997 0.63999999
		 0.71999997 0.65999997 0.71999997 0.68000001 0.71999997 0.69999999 0.71999997 0.71999997
		 0.71999997 0.74000001 0.71999997 0.75999999 0.71999997 0.77999997 0.71999997 0.79999995
		 0.71999997 0.81999999 0.71999997 0.83999997 0.71999997 0.85999995 0.71999997 0.88
		 0.71999997 0.89999998 0.71999997 0.91999996 0.71999997 0.94 0.71999997 0.95999998
		 0.71999997 0.97999996 0.71999997 1 0.71999997 0 0.74000001 0.02 0.74000001 0.039999999
		 0.74000001 0.059999999 0.74000001 0.079999998 0.74000001 0.099999994 0.74000001 0.12
		 0.74000001 0.14 0.74000001 0.16 0.74000001 0.17999999 0.74000001 0.19999999 0.74000001
		 0.22 0.74000001 0.23999999 0.74000001 0.25999999 0.74000001 0.28 0.74000001 0.29999998
		 0.74000001 0.31999999 0.74000001 0.34 0.74000001 0.35999998 0.74000001 0.38 0.74000001
		 0.39999998 0.74000001 0.41999999 0.74000001 0.44 0.74000001 0.45999998 0.74000001
		 0.47999999 0.74000001 0.5 0.74000001 0.51999998 0.74000001 0.53999996 0.74000001
		 0.56 0.74000001 0.57999998 0.74000001 0.59999996 0.74000001 0.62 0.74000001 0.63999999
		 0.74000001 0.65999997 0.74000001 0.68000001 0.74000001 0.69999999 0.74000001 0.71999997
		 0.74000001 0.74000001 0.74000001 0.75999999 0.74000001 0.77999997 0.74000001 0.79999995
		 0.74000001 0.81999999 0.74000001 0.83999997 0.74000001 0.85999995 0.74000001 0.88
		 0.74000001 0.89999998 0.74000001 0.91999996 0.74000001 0.94 0.74000001 0.95999998
		 0.74000001 0.97999996 0.74000001 1 0.74000001 0 0.75999999 0.02 0.75999999 0.039999999
		 0.75999999 0.059999999 0.75999999 0.079999998 0.75999999 0.099999994 0.75999999 0.12
		 0.75999999 0.14 0.75999999 0.16 0.75999999 0.17999999 0.75999999 0.19999999 0.75999999
		 0.22 0.75999999 0.23999999 0.75999999 0.25999999 0.75999999 0.28 0.75999999 0.29999998
		 0.75999999 0.31999999 0.75999999 0.34 0.75999999 0.35999998 0.75999999 0.38 0.75999999
		 0.39999998 0.75999999 0.41999999 0.75999999 0.44 0.75999999 0.45999998 0.75999999
		 0.47999999 0.75999999 0.5 0.75999999 0.51999998 0.75999999 0.53999996 0.75999999
		 0.56 0.75999999 0.57999998 0.75999999 0.59999996 0.75999999 0.62 0.75999999 0.63999999
		 0.75999999 0.65999997 0.75999999 0.68000001 0.75999999 0.69999999 0.75999999 0.71999997
		 0.75999999 0.74000001 0.75999999 0.75999999 0.75999999 0.77999997 0.75999999 0.79999995
		 0.75999999 0.81999999 0.75999999 0.83999997 0.75999999 0.85999995 0.75999999 0.88
		 0.75999999 0.89999998 0.75999999 0.91999996 0.75999999 0.94 0.75999999 0.95999998
		 0.75999999 0.97999996 0.75999999 1 0.75999999 0 0.77999997 0.02 0.77999997 0.039999999
		 0.77999997 0.059999999 0.77999997 0.079999998 0.77999997 0.099999994 0.77999997 0.12
		 0.77999997 0.14 0.77999997 0.16 0.77999997 0.17999999 0.77999997 0.19999999 0.77999997
		 0.22 0.77999997 0.23999999 0.77999997 0.25999999 0.77999997 0.28 0.77999997 0.29999998
		 0.77999997 0.31999999 0.77999997 0.34 0.77999997 0.35999998 0.77999997 0.38 0.77999997
		 0.39999998 0.77999997 0.41999999 0.77999997 0.44 0.77999997 0.45999998 0.77999997
		 0.47999999 0.77999997 0.5 0.77999997 0.51999998 0.77999997 0.53999996 0.77999997
		 0.56 0.77999997 0.57999998 0.77999997 0.59999996 0.77999997 0.62 0.77999997 0.63999999
		 0.77999997 0.65999997 0.77999997 0.68000001 0.77999997 0.69999999 0.77999997 0.71999997
		 0.77999997 0.74000001 0.77999997 0.75999999 0.77999997 0.77999997 0.77999997 0.79999995
		 0.77999997 0.81999999 0.77999997 0.83999997 0.77999997 0.85999995 0.77999997 0.88
		 0.77999997 0.89999998 0.77999997 0.91999996 0.77999997 0.94 0.77999997 0.95999998
		 0.77999997 0.97999996 0.77999997 1 0.77999997 0 0.79999995 0.02 0.79999995 0.039999999
		 0.79999995 0.059999999 0.79999995 0.079999998 0.79999995 0.099999994 0.79999995 0.12
		 0.79999995 0.14 0.79999995 0.16 0.79999995 0.17999999 0.79999995 0.19999999 0.79999995
		 0.22 0.79999995 0.23999999 0.79999995 0.25999999 0.79999995 0.28 0.79999995 0.29999998
		 0.79999995 0.31999999 0.79999995 0.34 0.79999995 0.35999998 0.79999995 0.38 0.79999995
		 0.39999998 0.79999995 0.41999999 0.79999995 0.44 0.79999995 0.45999998 0.79999995
		 0.47999999 0.79999995 0.5 0.79999995 0.51999998 0.79999995 0.53999996 0.79999995
		 0.56 0.79999995 0.57999998 0.79999995 0.59999996 0.79999995 0.62 0.79999995 0.63999999
		 0.79999995 0.65999997 0.79999995 0.68000001 0.79999995 0.69999999 0.79999995 0.71999997
		 0.79999995 0.74000001 0.79999995 0.75999999 0.79999995 0.77999997 0.79999995 0.79999995
		 0.79999995 0.81999999 0.79999995 0.83999997 0.79999995 0.85999995 0.79999995 0.88
		 0.79999995 0.89999998 0.79999995 0.91999996 0.79999995 0.94 0.79999995 0.95999998
		 0.79999995 0.97999996 0.79999995 1 0.79999995 0 0.81999999 0.02 0.81999999 0.039999999
		 0.81999999 0.059999999 0.81999999 0.079999998 0.81999999 0.099999994 0.81999999 0.12
		 0.81999999 0.14 0.81999999 0.16 0.81999999 0.17999999 0.81999999 0.19999999 0.81999999
		 0.22 0.81999999 0.23999999 0.81999999 0.25999999 0.81999999 0.28 0.81999999 0.29999998
		 0.81999999 0.31999999 0.81999999 0.34 0.81999999 0.35999998 0.81999999 0.38 0.81999999
		 0.39999998 0.81999999 0.41999999 0.81999999 0.44 0.81999999 0.45999998 0.81999999
		 0.47999999 0.81999999;
	setAttr ".uvst[0].uvsp[1750:1999]" 0.5 0.81999999 0.51999998 0.81999999 0.53999996
		 0.81999999 0.56 0.81999999 0.57999998 0.81999999 0.59999996 0.81999999 0.62 0.81999999
		 0.63999999 0.81999999 0.65999997 0.81999999 0.68000001 0.81999999 0.69999999 0.81999999
		 0.71999997 0.81999999 0.74000001 0.81999999 0.75999999 0.81999999 0.77999997 0.81999999
		 0.79999995 0.81999999 0.81999999 0.81999999 0.83999997 0.81999999 0.85999995 0.81999999
		 0.88 0.81999999 0.89999998 0.81999999 0.91999996 0.81999999 0.94 0.81999999 0.95999998
		 0.81999999 0.97999996 0.81999999 1 0.81999999 0 0.83999997 0.02 0.83999997 0.039999999
		 0.83999997 0.059999999 0.83999997 0.45999998 0.83999997 0.47999999 0.83999997 0.5
		 0.83999997 0.51999998 0.83999997 0.53999996 0.83999997 0.56 0.83999997 0.57999998
		 0.83999997 0.59999996 0.83999997 0.62 0.83999997 0.63999999 0.83999997 0.65999997
		 0.83999997 0.68000001 0.83999997 0.69999999 0.83999997 0.71999997 0.83999997 0.74000001
		 0.83999997 0.75999999 0.83999997 0.77999997 0.83999997 0.79999995 0.83999997 0.81999999
		 0.83999997 0.83999997 0.83999997 0.85999995 0.83999997 0.88 0.83999997 0.89999998
		 0.83999997 0.91999996 0.83999997 0.94 0.83999997 0.95999998 0.83999997 0.97999996
		 0.83999997 1 0.83999997 0 0.85999995 0.02 0.85999995 0.039999999 0.85999995 0.059999999
		 0.85999995 0.45999998 0.85999995 0.47999999 0.85999995 0.5 0.85999995 0.51999998
		 0.85999995 0.53999996 0.85999995 0.56 0.85999995 0.57999998 0.85999995 0.59999996
		 0.85999995 0.62 0.85999995 0.63999999 0.85999995 0.65999997 0.85999995 0.68000001
		 0.85999995 0.69999999 0.85999995 0.71999997 0.85999995 0.74000001 0.85999995 0.75999999
		 0.85999995 0.77999997 0.85999995 0.79999995 0.85999995 0.81999999 0.85999995 0.83999997
		 0.85999995 0.85999995 0.85999995 0.88 0.85999995 0.89999998 0.85999995 0.91999996
		 0.85999995 0.94 0.85999995 0.95999998 0.85999995 0.97999996 0.85999995 1 0.85999995
		 0 0.88 0.02 0.88 0.039999999 0.88 0.059999999 0.88 0.45999998 0.88 0.47999999 0.88
		 0.5 0.88 0.51999998 0.88 0.53999996 0.88 0.56 0.88 0.57999998 0.88 0.59999996 0.88
		 0.62 0.88 0.91999996 0.88 0.94 0.88 0.95999998 0.88 0.97999996 0.88 1 0.88 0 0.89999998
		 0.02 0.89999998 0.039999999 0.89999998 0.059999999 0.89999998 0.45999998 0.89999998
		 0.47999999 0.89999998 0.5 0.89999998 0.51999998 0.89999998 0.53999996 0.89999998
		 0.56 0.89999998 0.57999998 0.89999998 0.59999996 0.89999998 0.62 0.89999998 0.91999996
		 0.89999998 0.94 0.89999998 0.95999998 0.89999998 0.97999996 0.89999998 1 0.89999998
		 0 0.91999996 0.02 0.91999996 0.039999999 0.91999996 0.059999999 0.91999996 0.45999998
		 0.91999996 0.47999999 0.91999996 0.5 0.91999996 0.51999998 0.91999996 0.53999996
		 0.91999996 0.56 0.91999996 0.57999998 0.91999996 0.59999996 0.91999996 0.62 0.91999996
		 0.63999999 0.91999996 0.65999997 0.91999996 0.68000001 0.91999996 0.69999999 0.91999996
		 0.71999997 0.91999996 0.74000001 0.91999996 0.75999999 0.91999996 0.77999997 0.91999996
		 0.79999995 0.91999996 0.81999999 0.91999996 0.83999997 0.91999996 0.85999995 0.91999996
		 0.88 0.91999996 0.89999998 0.91999996 0.91999996 0.91999996 0.94 0.91999996 0.95999998
		 0.91999996 0.97999996 0.91999996 1 0.91999996 0 0.94 0.02 0.94 0.039999999 0.94 0.059999999
		 0.94 0.079999998 0.94 0.099999994 0.94 0.12 0.94 0.14 0.94 0.16 0.94 0.17999999 0.94
		 0.19999999 0.94 0.22 0.94 0.23999999 0.94 0.25999999 0.94 0.28 0.94 0.29999998 0.94
		 0.31999999 0.94 0.34 0.94 0.35999998 0.94 0.38 0.94 0.39999998 0.94 0.41999999 0.94
		 0.44 0.94 0.45999998 0.94 0.47999999 0.94 0.5 0.94 0.51999998 0.94 0.53999996 0.94
		 0.56 0.94 0.57999998 0.94 0.59999996 0.94 0.62 0.94 0.63999999 0.94 0.65999997 0.94
		 0.68000001 0.94 0.69999999 0.94 0.71999997 0.94 0.74000001 0.94 0.75999999 0.94 0.77999997
		 0.94 0.79999995 0.94 0.81999999 0.94 0.83999997 0.94 0.85999995 0.94 0.88 0.94 0.89999998
		 0.94 0.91999996 0.94 0.94 0.94 0.95999998 0.94 0.97999996 0.94 1 0.94 0 0.95999998
		 0.02 0.95999998 0.039999999 0.95999998 0.059999999 0.95999998 0.079999998 0.95999998
		 0.099999994 0.95999998 0.12 0.95999998 0.14 0.95999998 0.16 0.95999998 0.17999999
		 0.95999998 0.19999999 0.95999998 0.22 0.95999998 0.23999999 0.95999998 0.25999999
		 0.95999998 0.28 0.95999998 0.29999998 0.95999998 0.31999999 0.95999998 0.34 0.95999998
		 0.35999998 0.95999998 0.38 0.95999998 0.39999998 0.95999998 0.41999999 0.95999998
		 0.44 0.95999998 0.45999998 0.95999998 0.47999999 0.95999998 0.5 0.95999998 0.51999998
		 0.95999998 0.53999996 0.95999998 0.56 0.95999998 0.57999998 0.95999998 0.59999996
		 0.95999998 0.62 0.95999998 0.63999999 0.95999998 0.65999997 0.95999998 0.68000001
		 0.95999998 0.69999999 0.95999998 0.71999997 0.95999998 0.74000001 0.95999998 0.75999999
		 0.95999998 0.77999997 0.95999998 0.79999995 0.95999998;
	setAttr ".uvst[0].uvsp[2000:2111]" 0.81999999 0.95999998 0.83999997 0.95999998
		 0.85999995 0.95999998 0.88 0.95999998 0.89999998 0.95999998 0.91999996 0.95999998
		 0.94 0.95999998 0.95999998 0.95999998 0.97999996 0.95999998 1 0.95999998 0 0.97999996
		 0.02 0.97999996 0.039999999 0.97999996 0.059999999 0.97999996 0.079999998 0.97999996
		 0.099999994 0.97999996 0.12 0.97999996 0.14 0.97999996 0.16 0.97999996 0.17999999
		 0.97999996 0.19999999 0.97999996 0.22 0.97999996 0.23999999 0.97999996 0.25999999
		 0.97999996 0.28 0.97999996 0.29999998 0.97999996 0.31999999 0.97999996 0.34 0.97999996
		 0.35999998 0.97999996 0.38 0.97999996 0.39999998 0.97999996 0.41999999 0.97999996
		 0.44 0.97999996 0.45999998 0.97999996 0.47999999 0.97999996 0.5 0.97999996 0.51999998
		 0.97999996 0.53999996 0.97999996 0.56 0.97999996 0.57999998 0.97999996 0.59999996
		 0.97999996 0.62 0.97999996 0.63999999 0.97999996 0.65999997 0.97999996 0.68000001
		 0.97999996 0.69999999 0.97999996 0.71999997 0.97999996 0.74000001 0.97999996 0.75999999
		 0.97999996 0.77999997 0.97999996 0.79999995 0.97999996 0.81999999 0.97999996 0.83999997
		 0.97999996 0.85999995 0.97999996 0.88 0.97999996 0.89999998 0.97999996 0.91999996
		 0.97999996 0.94 0.97999996 0.95999998 0.97999996 0.97999996 0.97999996 1 0.97999996
		 0 1 0.02 1 0.039999999 1 0.059999999 1 0.079999998 1 0.099999994 1 0.12 1 0.14 1
		 0.16 1 0.17999999 1 0.19999999 1 0.22 1 0.23999999 1 0.25999999 1 0.28 1 0.29999998
		 1 0.31999999 1 0.34 1 0.35999998 1 0.38 1 0.39999998 1 0.41999999 1 0.44 1 0.45999998
		 1 0.47999999 1 0.5 1 0.51999998 1 0.53999996 1 0.56 1 0.57999998 1 0.59999996 1 0.62
		 1 0.63999999 1 0.65999997 1 0.68000001 1 0.69999999 1 0.71999997 1 0.74000001 1 0.75999999
		 1 0.77999997 1 0.79999995 1 0.81999999 1 0.83999997 1 0.85999995 1 0.88 1 0.89999998
		 1 0.91999996 1 0.94 1 0.95999998 1 0.97999996 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 2112 ".vt";
	setAttr ".vt[0:165]"  -25 -5.5511151e-015 25 -24 -5.5511151e-015 25 -23 -5.5511151e-015 25
		 -22 -5.5511151e-015 25 -21 -5.5511151e-015 25 -20 -5.5511151e-015 25 -19 -5.5511151e-015 25
		 -18 -5.5511151e-015 25 -17 -5.5511151e-015 25 -16 -5.5511151e-015 25 -15 -5.5511151e-015 25
		 -14 -5.5511151e-015 25 -13 -5.5511151e-015 25 -12 -5.5511151e-015 25 -11 -5.5511151e-015 25
		 -10 -5.5511151e-015 25 -9 -5.5511151e-015 25 -8 -5.5511151e-015 25 -7 -5.5511151e-015 25
		 -6 -5.5511151e-015 25 -5 -5.5511151e-015 25 -4 -5.5511151e-015 25 -3 -5.5511151e-015 25
		 -2 -5.5511151e-015 25 -1 -5.5511151e-015 25 0 -5.5511151e-015 25 1 -5.5511151e-015 25
		 2 -5.5511151e-015 25 3 -5.5511151e-015 25 4 -5.5511151e-015 25 5 -5.5511151e-015 25
		 6 -5.5511151e-015 25 7 -5.5511151e-015 25 8 -5.5511151e-015 25 9 -5.5511151e-015 25
		 10 -5.5511151e-015 25 11 -5.5511151e-015 25 12 -5.5511151e-015 25 13 -5.5511151e-015 25
		 14 -5.5511151e-015 25 15 -5.5511151e-015 25 16 -5.5511151e-015 25 17 -5.5511151e-015 25
		 18 -5.5511151e-015 25 19 -5.5511151e-015 25 20 -5.5511151e-015 25 21 -5.5511151e-015 25
		 22 -5.5511151e-015 25 23 -5.5511151e-015 25 24 -5.5511151e-015 25 25 -5.5511151e-015 25
		 -25 -5.3290705e-015 24 -24 -5.3290705e-015 24 -23 -5.3290705e-015 24 -22 -5.3290705e-015 24
		 -21 -5.3290705e-015 24 -20 -5.3290705e-015 24 -19 -5.3290705e-015 24 -18 -5.3290705e-015 24
		 -17 -5.3290705e-015 24 -16 -5.3290705e-015 24 -15 -5.3290705e-015 24 -14 -5.3290705e-015 24
		 -13 -5.3290705e-015 24 -12 -5.3290705e-015 24 -11 -5.3290705e-015 24 -10 -5.3290705e-015 24
		 -9 -5.3290705e-015 24 -8 -5.3290705e-015 24 -7 -5.3290705e-015 24 -6 -5.3290705e-015 24
		 -5 -5.3290705e-015 24 -4 -5.3290705e-015 24 -3 -5.3290705e-015 24 -2 -5.3290705e-015 24
		 -1 -5.3290705e-015 24 0 -5.3290705e-015 24 1 -5.3290705e-015 24 2 -5.3290705e-015 24
		 3 -5.3290705e-015 24 4 -5.3290705e-015 24 5 -5.3290705e-015 24 6 -5.3290705e-015 24
		 7 -5.3290705e-015 24 8 -5.3290705e-015 24 9 -5.3290705e-015 24 10 -5.3290705e-015 24
		 11 -5.3290705e-015 24 12 -5.3290705e-015 24 13 -5.3290705e-015 24 14 -5.3290705e-015 24
		 15 -5.3290705e-015 24 16 -5.3290705e-015 24 17 -5.3290705e-015 24 18 -5.3290705e-015 24
		 19 -5.3290705e-015 24 20 -5.3290705e-015 24 21 -5.3290705e-015 24 22 -5.3290705e-015 24
		 23 -5.3290705e-015 24 24 -5.3290705e-015 24 25 -5.3290705e-015 24 -25 -5.1070259e-015 23
		 -24 -5.1070259e-015 23 -23 -5.1070259e-015 23 -22 -5.1070259e-015 23 -21 -5.1070259e-015 23
		 -20 -5.1070259e-015 23 -19 -5.1070259e-015 23 -18 -5.1070259e-015 23 -17 -5.1070259e-015 23
		 -16 -5.1070259e-015 23 -15 -5.1070259e-015 23 -14 -5.1070259e-015 23 -13 -5.1070259e-015 23
		 -12 -5.1070259e-015 23 -11 -5.1070259e-015 23 -10 -5.1070259e-015 23 -9 -5.1070259e-015 23
		 -8 -5.1070259e-015 23 -7 -5.1070259e-015 23 -6 -5.1070259e-015 23 -5 -5.1070259e-015 23
		 -4 -5.1070259e-015 23 -3 -5.1070259e-015 23 -2 -5.1070259e-015 23 -1 -5.1070259e-015 23
		 0 -5.1070259e-015 23 1 -5.1070259e-015 23 2 -5.1070259e-015 23 3 -5.1070259e-015 23
		 4 -5.1070259e-015 23 5 -5.1070259e-015 23 6 -5.1070259e-015 23 7 -5.1070259e-015 23
		 8 -5.1070259e-015 23 9 -5.1070259e-015 23 10 -5.1070259e-015 23 11 -5.1070259e-015 23
		 12 -5.1070259e-015 23 13 -5.1070259e-015 23 14 -5.1070259e-015 23 15 -5.1070259e-015 23
		 16 -5.1070259e-015 23 17 -5.1070259e-015 23 18 -5.1070259e-015 23 19 -5.1070259e-015 23
		 20 -5.1070259e-015 23 21 -5.1070259e-015 23 22 -5.1070259e-015 23 23 -5.1070259e-015 23
		 24 -5.1070259e-015 23 25 -5.1070259e-015 23 -25 -4.8849813e-015 22 -24 -4.8849813e-015 22
		 -23 -4.8849813e-015 22 -22 -4.8849813e-015 22 -21 -4.8849813e-015 22 -20 -4.8849813e-015 22
		 -19 -4.8849813e-015 22 -18 -4.8849813e-015 22 -17 -4.8849813e-015 22 -16 -4.8849813e-015 22
		 -15 -4.8849813e-015 22 -14 -4.8849813e-015 22 -13 -4.8849813e-015 22;
	setAttr ".vt[166:331]" -12 -4.8849813e-015 22 -11 -4.8849813e-015 22 -10 -4.8849813e-015 22
		 -9 -4.8849813e-015 22 -8 -4.8849813e-015 22 -7 -4.8849813e-015 22 -6 -4.8849813e-015 22
		 -5 -4.8849813e-015 22 -4 -4.8849813e-015 22 -3 -4.8849813e-015 22 -2 -4.8849813e-015 22
		 -1 -4.8849813e-015 22 0 -4.8849813e-015 22 1 -4.8849813e-015 22 2 -4.8849813e-015 22
		 3 -4.8849813e-015 22 4 -4.8849813e-015 22 5 -4.8849813e-015 22 6 -4.8849813e-015 22
		 7 -4.8849813e-015 22 8 -4.8849813e-015 22 9 -4.8849813e-015 22 10 -4.8849813e-015 22
		 11 -4.8849813e-015 22 12 -4.8849813e-015 22 13 -4.8849813e-015 22 14 -4.8849813e-015 22
		 15 -4.8849813e-015 22 16 -4.8849813e-015 22 17 -4.8849813e-015 22 18 -4.8849813e-015 22
		 19 -4.8849813e-015 22 20 -4.8849813e-015 22 21 -4.8849813e-015 22 22 -4.8849813e-015 22
		 23 -4.8849813e-015 22 24 -4.8849813e-015 22 25 -4.8849813e-015 22 -25 -4.6629367e-015 21
		 -24 -4.6629367e-015 21 -23 -4.6629367e-015 21 -22 -4.6629367e-015 21 -21 -4.6629367e-015 21
		 -20 -4.6629367e-015 21 -19 -4.6629367e-015 21 -18 -4.6629367e-015 21 -17 -4.6629367e-015 21
		 -16 -4.6629367e-015 21 -15 -4.6629367e-015 21 -14 -4.6629367e-015 21 -13 -4.6629367e-015 21
		 -12 -4.6629367e-015 21 -11 -4.6629367e-015 21 -10 -4.6629367e-015 21 -9 -4.6629367e-015 21
		 -8 -4.6629367e-015 21 -7 -4.6629367e-015 21 -6 -4.6629367e-015 21 -5 -4.6629367e-015 21
		 -4 -4.6629367e-015 21 -3 -4.6629367e-015 21 -2 -4.6629367e-015 21 -1 -4.6629367e-015 21
		 0 -4.6629367e-015 21 1 -4.6629367e-015 21 2 -4.6629367e-015 21 3 -4.6629367e-015 21
		 4 -4.6629367e-015 21 5 -4.6629367e-015 21 6 -4.6629367e-015 21 7 -4.6629367e-015 21
		 8 -4.6629367e-015 21 9 -4.6629367e-015 21 10 -4.6629367e-015 21 11 -4.6629367e-015 21
		 12 -4.6629367e-015 21 13 -4.6629367e-015 21 14 -4.6629367e-015 21 15 -4.6629367e-015 21
		 16 -4.6629367e-015 21 17 -4.6629367e-015 21 18 -4.6629367e-015 21 19 -4.6629367e-015 21
		 20 -4.6629367e-015 21 21 -4.6629367e-015 21 22 -4.6629367e-015 21 23 -4.6629367e-015 21
		 24 -4.6629367e-015 21 25 -4.6629367e-015 21 -25 -4.4408921e-015 20 -24 -4.4408921e-015 20
		 -23 -4.4408921e-015 20 -22 -4.4408921e-015 20 -21 -4.4408921e-015 20 -20 -4.4408921e-015 20
		 -19 -4.4408921e-015 20 -18 -4.4408921e-015 20 -17 -4.4408921e-015 20 -16 -4.4408921e-015 20
		 -15 -4.4408921e-015 20 -14 -4.4408921e-015 20 -13 -4.4408921e-015 20 -12 -4.4408921e-015 20
		 -11 -4.4408921e-015 20 -10 -4.4408921e-015 20 -9 -4.4408921e-015 20 -8 -4.4408921e-015 20
		 -7 -4.4408921e-015 20 -6 -4.4408921e-015 20 -5 -4.4408921e-015 20 -4 -4.4408921e-015 20
		 -3 -4.4408921e-015 20 -2 -4.4408921e-015 20 -1 -4.4408921e-015 20 0 -4.4408921e-015 20
		 1 -4.4408921e-015 20 2 -4.4408921e-015 20 3 -4.4408921e-015 20 4 -4.4408921e-015 20
		 5 -4.4408921e-015 20 6 -4.4408921e-015 20 7 -4.4408921e-015 20 8 -4.4408921e-015 20
		 9 -4.4408921e-015 20 10 -4.4408921e-015 20 11 -4.4408921e-015 20 12 -4.4408921e-015 20
		 13 -4.4408921e-015 20 14 -4.4408921e-015 20 15 -4.4408921e-015 20 16 -4.4408921e-015 20
		 17 -4.4408921e-015 20 18 -4.4408921e-015 20 19 -4.4408921e-015 20 20 -4.4408921e-015 20
		 21 -4.4408921e-015 20 22 -4.4408921e-015 20 23 -4.4408921e-015 20 24 -4.4408921e-015 20
		 25 -4.4408921e-015 20 -25 -4.2188475e-015 19 -24 -4.2188475e-015 19 -23 -4.2188475e-015 19
		 -22 -4.2188475e-015 19 -21 -4.2188475e-015 19 -20 -4.2188475e-015 19 -19 -4.2188475e-015 19
		 -18 -4.2188475e-015 19 -17 -4.2188475e-015 19 -16 -4.2188475e-015 19 -15 -4.2188475e-015 19
		 -14 -4.2188475e-015 19 -13 -4.2188475e-015 19 -12 -4.2188475e-015 19 -11 -4.2188475e-015 19
		 -10 -4.2188475e-015 19 -9 -4.2188475e-015 19 -8 -4.2188475e-015 19 -7 -4.2188475e-015 19
		 -6 -4.2188475e-015 19 -5 -4.2188475e-015 19 -4 -4.2188475e-015 19 -3 -4.2188475e-015 19
		 -2 -4.2188475e-015 19 -1 -4.2188475e-015 19 0 -4.2188475e-015 19;
	setAttr ".vt[332:497]" 1 -4.2188475e-015 19 2 -4.2188475e-015 19 3 -4.2188475e-015 19
		 4 -4.2188475e-015 19 5 -4.2188475e-015 19 6 -4.2188475e-015 19 7 -4.2188475e-015 19
		 8 -4.2188475e-015 19 9 -4.2188475e-015 19 10 -4.2188475e-015 19 11 -4.2188475e-015 19
		 12 -4.2188475e-015 19 13 -4.2188475e-015 19 14 -4.2188475e-015 19 15 -4.2188475e-015 19
		 16 -4.2188475e-015 19 17 -4.2188475e-015 19 18 -4.2188475e-015 19 19 -4.2188475e-015 19
		 20 -4.2188475e-015 19 21 -4.2188475e-015 19 22 -4.2188475e-015 19 23 -4.2188475e-015 19
		 24 -4.2188475e-015 19 25 -4.2188475e-015 19 -25 -3.9968029e-015 18 -24 -3.9968029e-015 18
		 -23 -3.9968029e-015 18 -22 -3.9968029e-015 18 -21 -3.9968029e-015 18 -20 -3.9968029e-015 18
		 -19 -3.9968029e-015 18 -18 -3.9968029e-015 18 -17 -3.9968029e-015 18 -16 -3.9968029e-015 18
		 -15 -3.9968029e-015 18 -14 -3.9968029e-015 18 -13 -3.9968029e-015 18 -12 -3.9968029e-015 18
		 -11 -3.9968029e-015 18 -10 -3.9968029e-015 18 -9 -3.9968029e-015 18 -8 -3.9968029e-015 18
		 -7 -3.9968029e-015 18 -6 -3.9968029e-015 18 -5 -3.9968029e-015 18 -4 -3.9968029e-015 18
		 -3 -3.9968029e-015 18 -2 -3.9968029e-015 18 -1 -3.9968029e-015 18 0 -3.9968029e-015 18
		 1 -3.9968029e-015 18 2 -3.9968029e-015 18 3 -3.9968029e-015 18 4 -3.9968029e-015 18
		 5 -3.9968029e-015 18 6 -3.9968029e-015 18 7 -3.9968029e-015 18 8 -3.9968029e-015 18
		 9 -3.9968029e-015 18 10 -3.9968029e-015 18 11 -3.9968029e-015 18 12 -3.9968029e-015 18
		 13 -3.9968029e-015 18 14 -3.9968029e-015 18 15 -3.9968029e-015 18 16 -3.9968029e-015 18
		 17 -3.9968029e-015 18 18 -3.9968029e-015 18 19 -3.9968029e-015 18 20 -3.9968029e-015 18
		 21 -3.9968029e-015 18 22 -3.9968029e-015 18 23 -3.9968029e-015 18 24 -3.9968029e-015 18
		 25 -3.9968029e-015 18 -25 -3.7747583e-015 17 -24 -3.7747583e-015 17 -23 -3.7747583e-015 17
		 -22 -3.7747583e-015 17 -21 -3.7747583e-015 17 -20 -3.7747583e-015 17 -19 -3.7747583e-015 17
		 -18 -3.7747583e-015 17 -17 -3.7747583e-015 17 -16 -3.7747583e-015 17 -15 -3.7747583e-015 17
		 -14 -3.7747583e-015 17 -13 -3.7747583e-015 17 -12 -3.7747583e-015 17 -11 -3.7747583e-015 17
		 -10 -3.7747583e-015 17 -9 -3.7747583e-015 17 -8 -3.7747583e-015 17 -7 -3.7747583e-015 17
		 -6 -3.7747583e-015 17 -5 -3.7747583e-015 17 -4 -3.7747583e-015 17 -3 -3.7747583e-015 17
		 -2 -3.7747583e-015 17 -1 -3.7747583e-015 17 0 -3.7747583e-015 17 1 -3.7747583e-015 17
		 2 -3.7747583e-015 17 3 -3.7747583e-015 17 4 -3.7747583e-015 17 5 -3.7747583e-015 17
		 6 -3.7747583e-015 17 7 -3.7747583e-015 17 8 -3.7747583e-015 17 9 -3.7747583e-015 17
		 10 -3.7747583e-015 17 11 -3.7747583e-015 17 12 -3.7747583e-015 17 13 -3.7747583e-015 17
		 14 -3.7747583e-015 17 15 -3.7747583e-015 17 16 -3.7747583e-015 17 17 -3.7747583e-015 17
		 18 -3.7747583e-015 17 19 -3.7747583e-015 17 20 -3.7747583e-015 17 21 -3.7747583e-015 17
		 22 -3.7747583e-015 17 23 -3.7747583e-015 17 24 -3.7747583e-015 17 25 -3.7747583e-015 17
		 -25 -3.5527137e-015 16 -24 -3.5527137e-015 16 -23 -3.5527137e-015 16 -22 -3.5527137e-015 16
		 -21 -3.5527137e-015 16 -20 -3.5527137e-015 16 -19 -3.5527137e-015 16 -18 -3.5527137e-015 16
		 -17 -3.5527137e-015 16 -16 -3.5527137e-015 16 -15 -3.5527137e-015 16 -14 -3.5527137e-015 16
		 -13 -3.5527137e-015 16 -12 -3.5527137e-015 16 -11 -3.5527137e-015 16 -10 -3.5527137e-015 16
		 -9 -3.5527137e-015 16 -8 -3.5527137e-015 16 -7 -3.5527137e-015 16 -6 -3.5527137e-015 16
		 -5 -3.5527137e-015 16 -4 -3.5527137e-015 16 17 -3.5527137e-015 16 18 -3.5527137e-015 16
		 19 -3.5527137e-015 16 20 -3.5527137e-015 16 21 -3.5527137e-015 16 22 -3.5527137e-015 16
		 23 -3.5527137e-015 16 24 -3.5527137e-015 16 25 -3.5527137e-015 16 -25 -3.3306691e-015 15
		 -24 -3.3306691e-015 15 -23 -3.3306691e-015 15 -22 -3.3306691e-015 15 -21 -3.3306691e-015 15
		 -20 -3.3306691e-015 15 -19 -3.3306691e-015 15 -18 -3.3306691e-015 15;
	setAttr ".vt[498:663]" -17 -3.3306691e-015 15 -16 -3.3306691e-015 15 -15 -3.3306691e-015 15
		 -14 -3.3306691e-015 15 -13 -3.3306691e-015 15 -12 -3.3306691e-015 15 -11 -3.3306691e-015 15
		 -10 -3.3306691e-015 15 -9 -3.3306691e-015 15 -8 -3.3306691e-015 15 -7 -3.3306691e-015 15
		 -6 -3.3306691e-015 15 -5 -3.3306691e-015 15 -4 -3.3306691e-015 15 17 -3.3306691e-015 15
		 18 -3.3306691e-015 15 19 -3.3306691e-015 15 20 -3.3306691e-015 15 21 -3.3306691e-015 15
		 22 -3.3306691e-015 15 23 -3.3306691e-015 15 24 -3.3306691e-015 15 25 -3.3306691e-015 15
		 -25 -3.1086245e-015 14 -24 -3.1086245e-015 14 -23 -3.1086245e-015 14 -22 -3.1086245e-015 14
		 -21 -3.1086245e-015 14 -20 -3.1086245e-015 14 -19 -3.1086245e-015 14 -18 -3.1086245e-015 14
		 -17 -3.1086245e-015 14 -16 -3.1086245e-015 14 -15 -3.1086245e-015 14 -14 -3.1086245e-015 14
		 -13 -3.1086245e-015 14 -12 -3.1086245e-015 14 -11 -3.1086245e-015 14 -10 -3.1086245e-015 14
		 -9 -3.1086245e-015 14 -8 -3.1086245e-015 14 -7 -3.1086245e-015 14 -6 -3.1086245e-015 14
		 -5 -3.1086245e-015 14 -4 -3.1086245e-015 14 17 -3.1086245e-015 14 18 -3.1086245e-015 14
		 19 -3.1086245e-015 14 20 -3.1086245e-015 14 21 -3.1086245e-015 14 22 -3.1086245e-015 14
		 23 -3.1086245e-015 14 24 -3.1086245e-015 14 25 -3.1086245e-015 14 -25 -2.8865799e-015 13
		 -24 -2.8865799e-015 13 -23 -2.8865799e-015 13 -22 -2.8865799e-015 13 -21 -2.8865799e-015 13
		 -20 -2.8865799e-015 13 -19 -2.8865799e-015 13 -18 -2.8865799e-015 13 -17 -2.8865799e-015 13
		 -16 -2.8865799e-015 13 -15 -2.8865799e-015 13 -14 -2.8865799e-015 13 -13 -2.8865799e-015 13
		 -12 -2.8865799e-015 13 -11 -2.8865799e-015 13 -10 -2.8865799e-015 13 -9 -2.8865799e-015 13
		 -8 -2.8865799e-015 13 -7 -2.8865799e-015 13 -6 -2.8865799e-015 13 -5 -2.8865799e-015 13
		 -4 -2.8865799e-015 13 17 -2.8865799e-015 13 18 -2.8865799e-015 13 19 -2.8865799e-015 13
		 20 -2.8865799e-015 13 21 -2.8865799e-015 13 22 -2.8865799e-015 13 23 -2.8865799e-015 13
		 24 -2.8865799e-015 13 25 -2.8865799e-015 13 -25 -2.6645353e-015 12 -24 -2.6645353e-015 12
		 -23 -2.6645353e-015 12 -22 -2.6645353e-015 12 -21 -2.6645353e-015 12 -20 -2.6645353e-015 12
		 -19 -2.6645353e-015 12 -18 -2.6645353e-015 12 -17 -2.6645353e-015 12 -16 -2.6645353e-015 12
		 -15 -2.6645353e-015 12 -14 -2.6645353e-015 12 -13 -2.6645353e-015 12 -12 -2.6645353e-015 12
		 -11 -2.6645353e-015 12 -10 -2.6645353e-015 12 -9 -2.6645353e-015 12 -8 -2.6645353e-015 12
		 -7 -2.6645353e-015 12 -6 -2.6645353e-015 12 -5 -2.6645353e-015 12 -4 -2.6645353e-015 12
		 17 -2.6645353e-015 12 18 -2.6645353e-015 12 19 -2.6645353e-015 12 20 -2.6645353e-015 12
		 21 -2.6645353e-015 12 22 -2.6645353e-015 12 23 -2.6645353e-015 12 24 -2.6645353e-015 12
		 25 -2.6645353e-015 12 -25 -2.4424907e-015 11 -24 -2.4424907e-015 11 -23 -2.4424907e-015 11
		 -22 -2.4424907e-015 11 -21 -2.4424907e-015 11 -20 -2.4424907e-015 11 -19 -2.4424907e-015 11
		 -18 -2.4424907e-015 11 -17 -2.4424907e-015 11 -16 -2.4424907e-015 11 -15 -2.4424907e-015 11
		 -14 -2.4424907e-015 11 -13 -2.4424907e-015 11 -12 -2.4424907e-015 11 -11 -2.4424907e-015 11
		 -10 -2.4424907e-015 11 -9 -2.4424907e-015 11 -8 -2.4424907e-015 11 -7 -2.4424907e-015 11
		 -6 -2.4424907e-015 11 -5 -2.4424907e-015 11 -4 -2.4424907e-015 11 -3 -2.4424907e-015 11
		 -2 -2.4424907e-015 11 -1 -2.4424907e-015 11 0 -2.4424907e-015 11 1 -2.4424907e-015 11
		 2 -2.4424907e-015 11 3 -2.4424907e-015 11 4 -2.4424907e-015 11 5 -2.4424907e-015 11
		 6 -2.4424907e-015 11 7 -2.4424907e-015 11 8 -2.4424907e-015 11 9 -2.4424907e-015 11
		 10 -2.4424907e-015 11 11 -2.4424907e-015 11 12 -2.4424907e-015 11 13 -2.4424907e-015 11
		 14 -2.4424907e-015 11 15 -2.4424907e-015 11 16 -2.4424907e-015 11 17 -2.4424907e-015 11
		 18 -2.4424907e-015 11 19 -2.4424907e-015 11 20 -2.4424907e-015 11 21 -2.4424907e-015 11
		 22 -2.4424907e-015 11 23 -2.4424907e-015 11 24 -2.4424907e-015 11;
	setAttr ".vt[664:829]" 25 -2.4424907e-015 11 -25 -2.220446e-015 10 -24 -2.220446e-015 10
		 -23 -2.220446e-015 10 -22 -2.220446e-015 10 -21 -2.220446e-015 10 -20 -2.220446e-015 10
		 -19 -2.220446e-015 10 -18 -2.220446e-015 10 -17 -2.220446e-015 10 -16 -2.220446e-015 10
		 -15 -2.220446e-015 10 -14 -2.220446e-015 10 -13 -2.220446e-015 10 -12 -2.220446e-015 10
		 -11 -2.220446e-015 10 -10 -2.220446e-015 10 -9 -2.220446e-015 10 -8 -2.220446e-015 10
		 -7 -2.220446e-015 10 -6 -2.220446e-015 10 -5 -2.220446e-015 10 -4 -2.220446e-015 10
		 -3 -2.220446e-015 10 -2 -2.220446e-015 10 -1 -2.220446e-015 10 0 -2.220446e-015 10
		 1 -2.220446e-015 10 2 -2.220446e-015 10 3 -2.220446e-015 10 4 -2.220446e-015 10 5 -2.220446e-015 10
		 6 -2.220446e-015 10 7 -2.220446e-015 10 8 -2.220446e-015 10 9 -2.220446e-015 10 10 -2.220446e-015 10
		 11 -2.220446e-015 10 12 -2.220446e-015 10 13 -2.220446e-015 10 14 -2.220446e-015 10
		 15 -2.220446e-015 10 16 -2.220446e-015 10 17 -2.220446e-015 10 18 -2.220446e-015 10
		 19 -2.220446e-015 10 20 -2.220446e-015 10 21 -2.220446e-015 10 22 -2.220446e-015 10
		 23 -2.220446e-015 10 24 -2.220446e-015 10 25 -2.220446e-015 10 -25 -1.9984014e-015 9
		 -24 -1.9984014e-015 9 -23 -1.9984014e-015 9 -22 -1.9984014e-015 9 -21 -1.9984014e-015 9
		 -20 -1.9984014e-015 9 -19 -1.9984014e-015 9 -18 -1.9984014e-015 9 -17 -1.9984014e-015 9
		 -16 -1.9984014e-015 9 -15 -1.9984014e-015 9 -14 -1.9984014e-015 9 -13 -1.9984014e-015 9
		 -12 -1.9984014e-015 9 -11 -1.9984014e-015 9 -10 -1.9984014e-015 9 -9 -1.9984014e-015 9
		 -8 -1.9984014e-015 9 -7 -1.9984014e-015 9 -6 -1.9984014e-015 9 -5 -1.9984014e-015 9
		 -4 -1.9984014e-015 9 -3 -1.9984014e-015 9 -2 -1.9984014e-015 9 -1 -1.9984014e-015 9
		 0 -1.9984014e-015 9 1 -1.9984014e-015 9 2 -1.9984014e-015 9 3 -1.9984014e-015 9 4 -1.9984014e-015 9
		 5 -1.9984014e-015 9 6 -1.9984014e-015 9 7 -1.9984014e-015 9 8 -1.9984014e-015 9 9 -1.9984014e-015 9
		 10 -1.9984014e-015 9 11 -1.9984014e-015 9 12 -1.9984014e-015 9 13 -1.9984014e-015 9
		 14 -1.9984014e-015 9 15 -1.9984014e-015 9 16 -1.9984014e-015 9 17 -1.9984014e-015 9
		 18 -1.9984014e-015 9 19 -1.9984014e-015 9 20 -1.9984014e-015 9 21 -1.9984014e-015 9
		 22 -1.9984014e-015 9 23 -1.9984014e-015 9 24 -1.9984014e-015 9 25 -1.9984014e-015 9
		 -25 -1.7763568e-015 8 -24 -1.7763568e-015 8 -23 -1.7763568e-015 8 -22 -1.7763568e-015 8
		 -21 -1.7763568e-015 8 -20 -1.7763568e-015 8 -19 -1.7763568e-015 8 -18 -1.7763568e-015 8
		 -17 -1.7763568e-015 8 -16 -1.7763568e-015 8 -15 -1.7763568e-015 8 -14 -1.7763568e-015 8
		 -13 -1.7763568e-015 8 -12 -1.7763568e-015 8 -11 -1.7763568e-015 8 -10 -1.7763568e-015 8
		 -9 -1.7763568e-015 8 -8 -1.7763568e-015 8 -7 -1.7763568e-015 8 -6 -1.7763568e-015 8
		 -5 -1.7763568e-015 8 -4 -1.7763568e-015 8 -3 -1.7763568e-015 8 -2 -1.7763568e-015 8
		 -1 -1.7763568e-015 8 0 -1.7763568e-015 8 1 -1.7763568e-015 8 2 -1.7763568e-015 8
		 3 -1.7763568e-015 8 4 -1.7763568e-015 8 5 -1.7763568e-015 8 6 -1.7763568e-015 8 7 -1.7763568e-015 8
		 8 -1.7763568e-015 8 9 -1.7763568e-015 8 10 -1.7763568e-015 8 11 -1.7763568e-015 8
		 12 -1.7763568e-015 8 13 -1.7763568e-015 8 14 -1.7763568e-015 8 15 -1.7763568e-015 8
		 16 -1.7763568e-015 8 17 -1.7763568e-015 8 18 -1.7763568e-015 8 19 -1.7763568e-015 8
		 20 -1.7763568e-015 8 21 -1.7763568e-015 8 22 -1.7763568e-015 8 23 -1.7763568e-015 8
		 24 -1.7763568e-015 8 25 -1.7763568e-015 8 -25 -1.5543122e-015 7 -24 -1.5543122e-015 7
		 -23 -1.5543122e-015 7 -22 -1.5543122e-015 7 -21 -1.5543122e-015 7 -20 -1.5543122e-015 7
		 -19 -1.5543122e-015 7 -18 -1.5543122e-015 7 -17 -1.5543122e-015 7 -16 -1.5543122e-015 7
		 -15 -1.5543122e-015 7 -14 -1.5543122e-015 7;
	setAttr ".vt[830:995]" -13 -1.5543122e-015 7 -12 -1.5543122e-015 7 -11 -1.5543122e-015 7
		 -10 -1.5543122e-015 7 -9 -1.5543122e-015 7 -8 -1.5543122e-015 7 -7 -1.5543122e-015 7
		 -6 -1.5543122e-015 7 -5 -1.5543122e-015 7 -4 -1.5543122e-015 7 -3 -1.5543122e-015 7
		 -2 -1.5543122e-015 7 -1 -1.5543122e-015 7 0 -1.5543122e-015 7 1 -1.5543122e-015 7
		 2 -1.5543122e-015 7 3 -1.5543122e-015 7 4 -1.5543122e-015 7 5 -1.5543122e-015 7 6 -1.5543122e-015 7
		 7 -1.5543122e-015 7 8 -1.5543122e-015 7 9 -1.5543122e-015 7 10 -1.5543122e-015 7
		 11 -1.5543122e-015 7 12 -1.5543122e-015 7 13 -1.5543122e-015 7 14 -1.5543122e-015 7
		 15 -1.5543122e-015 7 16 -1.5543122e-015 7 17 -1.5543122e-015 7 18 -1.5543122e-015 7
		 19 -1.5543122e-015 7 20 -1.5543122e-015 7 21 -1.5543122e-015 7 22 -1.5543122e-015 7
		 23 -1.5543122e-015 7 24 -1.5543122e-015 7 25 -1.5543122e-015 7 -25 -1.3322676e-015 6
		 -24 -1.3322676e-015 6 -23 -1.3322676e-015 6 -22 -1.3322676e-015 6 -21 -1.3322676e-015 6
		 -20 -1.3322676e-015 6 -2 -1.3322676e-015 6 -1 -1.3322676e-015 6 0 -1.3322676e-015 6
		 1 -1.3322676e-015 6 2 -1.3322676e-015 6 3 -1.3322676e-015 6 4 -1.3322676e-015 6 5 -1.3322676e-015 6
		 6 -1.3322676e-015 6 7 -1.3322676e-015 6 8 -1.3322676e-015 6 9 -1.3322676e-015 6 10 -1.3322676e-015 6
		 17 -1.3322676e-015 6 18 -1.3322676e-015 6 19 -1.3322676e-015 6 20 -1.3322676e-015 6
		 21 -1.3322676e-015 6 22 -1.3322676e-015 6 23 -1.3322676e-015 6 24 -1.3322676e-015 6
		 25 -1.3322676e-015 6 -25 -1.110223e-015 5 -24 -1.110223e-015 5 -23 -1.110223e-015 5
		 -22 -1.110223e-015 5 -21 -1.110223e-015 5 -20 -1.110223e-015 5 -2 -1.110223e-015 5
		 -1 -1.110223e-015 5 0 -1.110223e-015 5 1 -1.110223e-015 5 2 -1.110223e-015 5 3 -1.110223e-015 5
		 4 -1.110223e-015 5 5 -1.110223e-015 5 6 -1.110223e-015 5 7 -1.110223e-015 5 8 -1.110223e-015 5
		 9 -1.110223e-015 5 10 -1.110223e-015 5 17 -1.110223e-015 5 18 -1.110223e-015 5 19 -1.110223e-015 5
		 20 -1.110223e-015 5 21 -1.110223e-015 5 22 -1.110223e-015 5 23 -1.110223e-015 5 24 -1.110223e-015 5
		 25 -1.110223e-015 5 -25 -8.8817842e-016 4 -24 -8.8817842e-016 4 -23 -8.8817842e-016 4
		 -22 -8.8817842e-016 4 -21 -8.8817842e-016 4 -20 -8.8817842e-016 4 -2 -8.8817842e-016 4
		 -1 -8.8817842e-016 4 0 -8.8817842e-016 4 1 -8.8817842e-016 4 2 -8.8817842e-016 4
		 3 -8.8817842e-016 4 4 -8.8817842e-016 4 5 -8.8817842e-016 4 6 -8.8817842e-016 4 7 -8.8817842e-016 4
		 8 -8.8817842e-016 4 9 -8.8817842e-016 4 10 -8.8817842e-016 4 17 -8.8817842e-016 4
		 18 -8.8817842e-016 4 19 -8.8817842e-016 4 20 -8.8817842e-016 4 21 -8.8817842e-016 4
		 22 -8.8817842e-016 4 23 -8.8817842e-016 4 24 -8.8817842e-016 4 25 -8.8817842e-016 4
		 -25 -6.6613381e-016 3 -24 -6.6613381e-016 3 -23 -6.6613381e-016 3 -22 -6.6613381e-016 3
		 -21 -6.6613381e-016 3 -20 -6.6613381e-016 3 -2 -6.6613381e-016 3 -1 -6.6613381e-016 3
		 0 -6.6613381e-016 3 1 -6.6613381e-016 3 2 -6.6613381e-016 3 3 -6.6613381e-016 3 4 -6.6613381e-016 3
		 5 -6.6613381e-016 3 6 -6.6613381e-016 3 7 -6.6613381e-016 3 8 -6.6613381e-016 3 9 -6.6613381e-016 3
		 10 -6.6613381e-016 3 17 -6.6613381e-016 3 18 -6.6613381e-016 3 19 -6.6613381e-016 3
		 20 -6.6613381e-016 3 21 -6.6613381e-016 3 22 -6.6613381e-016 3 23 -6.6613381e-016 3
		 24 -6.6613381e-016 3 25 -6.6613381e-016 3 -25 -4.4408921e-016 2 -24 -4.4408921e-016 2
		 -23 -4.4408921e-016 2 -22 -4.4408921e-016 2 -21 -4.4408921e-016 2 -20 -4.4408921e-016 2
		 -19 -4.4408921e-016 2 -18 -4.4408921e-016 2 -17 -4.4408921e-016 2 -16 -4.4408921e-016 2
		 -15 -4.4408921e-016 2 -14 -4.4408921e-016 2 -13 -4.4408921e-016 2 -12 -4.4408921e-016 2
		 -11 -4.4408921e-016 2;
	setAttr ".vt[996:1161]" -10 -4.4408921e-016 2 -9 -4.4408921e-016 2 -8 -4.4408921e-016 2
		 -7 -4.4408921e-016 2 -6 -4.4408921e-016 2 -5 -4.4408921e-016 2 -4 -4.4408921e-016 2
		 -3 -4.4408921e-016 2 -2 -4.4408921e-016 2 -1 -4.4408921e-016 2 0 -4.4408921e-016 2
		 1 -4.4408921e-016 2 2 -4.4408921e-016 2 3 -4.4408921e-016 2 4 -4.4408921e-016 2 5 -4.4408921e-016 2
		 6 -4.4408921e-016 2 7 -4.4408921e-016 2 8 -4.4408921e-016 2 9 -4.4408921e-016 2 10 -4.4408921e-016 2
		 17 -4.4408921e-016 2 18 -4.4408921e-016 2 19 -4.4408921e-016 2 20 -4.4408921e-016 2
		 21 -4.4408921e-016 2 22 -4.4408921e-016 2 23 -4.4408921e-016 2 24 -4.4408921e-016 2
		 25 -4.4408921e-016 2 -25 -2.220446e-016 1 -24 -2.220446e-016 1 -23 -2.220446e-016 1
		 -22 -2.220446e-016 1 -21 -2.220446e-016 1 -20 -2.220446e-016 1 -19 -2.220446e-016 1
		 -18 -2.220446e-016 1 -17 -2.220446e-016 1 -16 -2.220446e-016 1 -15 -2.220446e-016 1
		 -14 -2.220446e-016 1 -13 -2.220446e-016 1 -12 -2.220446e-016 1 -11 -2.220446e-016 1
		 -10 -2.220446e-016 1 -9 -2.220446e-016 1 -8 -2.220446e-016 1 -7 -2.220446e-016 1
		 -6 -2.220446e-016 1 -5 -2.220446e-016 1 -4 -2.220446e-016 1 -3 -2.220446e-016 1 -2 -2.220446e-016 1
		 -1 -2.220446e-016 1 0 -2.220446e-016 1 1 -2.220446e-016 1 2 -2.220446e-016 1 3 -2.220446e-016 1
		 4 -2.220446e-016 1 5 -2.220446e-016 1 6 -2.220446e-016 1 7 -2.220446e-016 1 8 -2.220446e-016 1
		 9 -2.220446e-016 1 10 -2.220446e-016 1 17 -2.220446e-016 1 18 -2.220446e-016 1 19 -2.220446e-016 1
		 20 -2.220446e-016 1 21 -2.220446e-016 1 22 -2.220446e-016 1 23 -2.220446e-016 1 24 -2.220446e-016 1
		 25 -2.220446e-016 1 -25 0 0 -24 0 0 -23 0 0 -22 0 0 -21 0 0 -20 0 0 -19 0 0 -18 0 0
		 -17 0 0 -16 0 0 -15 0 0 -14 0 0 -13 0 0 -12 0 0 -11 0 0 -10 0 0 -9 0 0 -8 0 0 -7 0 0
		 -6 0 0 -5 0 0 -4 0 0 -3 0 0 -2 0 0 -1 0 0 0 0 0 1 0 0 2 0 0 3 0 0 4 0 0 5 0 0 6 0 0
		 7 0 0 8 0 0 9 0 0 10 0 0 17 0 0 18 0 0 19 0 0 20 0 0 21 0 0 22 0 0 23 0 0 24 0 0
		 25 0 0 -25 2.220446e-016 -1 -24 2.220446e-016 -1 -23 2.220446e-016 -1 -22 2.220446e-016 -1
		 -21 2.220446e-016 -1 -20 2.220446e-016 -1 -19 2.220446e-016 -1 -18 2.220446e-016 -1
		 -17 2.220446e-016 -1 -16 2.220446e-016 -1 -15 2.220446e-016 -1 -14 2.220446e-016 -1
		 -13 2.220446e-016 -1 -12 2.220446e-016 -1 -11 2.220446e-016 -1 -10 2.220446e-016 -1
		 -9 2.220446e-016 -1 -8 2.220446e-016 -1 -7 2.220446e-016 -1 -6 2.220446e-016 -1 -5 2.220446e-016 -1
		 -4 2.220446e-016 -1 -3 2.220446e-016 -1 -2 2.220446e-016 -1 -1 2.220446e-016 -1 0 2.220446e-016 -1
		 1 2.220446e-016 -1 2 2.220446e-016 -1 3 2.220446e-016 -1 4 2.220446e-016 -1 5 2.220446e-016 -1
		 6 2.220446e-016 -1 7 2.220446e-016 -1 8 2.220446e-016 -1 9 2.220446e-016 -1 10 2.220446e-016 -1
		 17 2.220446e-016 -1 18 2.220446e-016 -1 19 2.220446e-016 -1 20 2.220446e-016 -1 21 2.220446e-016 -1
		 22 2.220446e-016 -1 23 2.220446e-016 -1 24 2.220446e-016 -1 25 2.220446e-016 -1 -25 4.4408921e-016 -2;
	setAttr ".vt[1162:1327]" -24 4.4408921e-016 -2 -23 4.4408921e-016 -2 -22 4.4408921e-016 -2
		 -21 4.4408921e-016 -2 -20 4.4408921e-016 -2 -19 4.4408921e-016 -2 -18 4.4408921e-016 -2
		 -17 4.4408921e-016 -2 -16 4.4408921e-016 -2 -15 4.4408921e-016 -2 -14 4.4408921e-016 -2
		 -13 4.4408921e-016 -2 -12 4.4408921e-016 -2 -11 4.4408921e-016 -2 -10 4.4408921e-016 -2
		 -9 4.4408921e-016 -2 -8 4.4408921e-016 -2 -7 4.4408921e-016 -2 -6 4.4408921e-016 -2
		 -5 4.4408921e-016 -2 -4 4.4408921e-016 -2 -3 4.4408921e-016 -2 -2 4.4408921e-016 -2
		 -1 4.4408921e-016 -2 0 4.4408921e-016 -2 1 4.4408921e-016 -2 2 4.4408921e-016 -2
		 3 4.4408921e-016 -2 4 4.4408921e-016 -2 5 4.4408921e-016 -2 6 4.4408921e-016 -2 7 4.4408921e-016 -2
		 8 4.4408921e-016 -2 9 4.4408921e-016 -2 10 4.4408921e-016 -2 17 4.4408921e-016 -2
		 18 4.4408921e-016 -2 19 4.4408921e-016 -2 20 4.4408921e-016 -2 21 4.4408921e-016 -2
		 22 4.4408921e-016 -2 23 4.4408921e-016 -2 24 4.4408921e-016 -2 25 4.4408921e-016 -2
		 -25 6.6613381e-016 -3 -24 6.6613381e-016 -3 -23 6.6613381e-016 -3 -22 6.6613381e-016 -3
		 -21 6.6613381e-016 -3 -20 6.6613381e-016 -3 -19 6.6613381e-016 -3 -18 6.6613381e-016 -3
		 -17 6.6613381e-016 -3 -16 6.6613381e-016 -3 -15 6.6613381e-016 -3 -14 6.6613381e-016 -3
		 -13 6.6613381e-016 -3 -12 6.6613381e-016 -3 -11 6.6613381e-016 -3 -10 6.6613381e-016 -3
		 -9 6.6613381e-016 -3 -8 6.6613381e-016 -3 -7 6.6613381e-016 -3 -6 6.6613381e-016 -3
		 -5 6.6613381e-016 -3 -4 6.6613381e-016 -3 -3 6.6613381e-016 -3 -2 6.6613381e-016 -3
		 -1 6.6613381e-016 -3 0 6.6613381e-016 -3 1 6.6613381e-016 -3 2 6.6613381e-016 -3
		 3 6.6613381e-016 -3 4 6.6613381e-016 -3 5 6.6613381e-016 -3 6 6.6613381e-016 -3 7 6.6613381e-016 -3
		 8 6.6613381e-016 -3 9 6.6613381e-016 -3 10 6.6613381e-016 -3 17 6.6613381e-016 -3
		 18 6.6613381e-016 -3 19 6.6613381e-016 -3 20 6.6613381e-016 -3 21 6.6613381e-016 -3
		 22 6.6613381e-016 -3 23 6.6613381e-016 -3 24 6.6613381e-016 -3 25 6.6613381e-016 -3
		 -25 8.8817842e-016 -4 -24 8.8817842e-016 -4 -23 8.8817842e-016 -4 -22 8.8817842e-016 -4
		 -21 8.8817842e-016 -4 -20 8.8817842e-016 -4 -19 8.8817842e-016 -4 -18 8.8817842e-016 -4
		 -17 8.8817842e-016 -4 -16 8.8817842e-016 -4 -15 8.8817842e-016 -4 -14 8.8817842e-016 -4
		 -13 8.8817842e-016 -4 -12 8.8817842e-016 -4 -11 8.8817842e-016 -4 -10 8.8817842e-016 -4
		 -9 8.8817842e-016 -4 -8 8.8817842e-016 -4 -7 8.8817842e-016 -4 -6 8.8817842e-016 -4
		 -5 8.8817842e-016 -4 -4 8.8817842e-016 -4 -3 8.8817842e-016 -4 -2 8.8817842e-016 -4
		 -1 8.8817842e-016 -4 0 8.8817842e-016 -4 1 8.8817842e-016 -4 2 8.8817842e-016 -4
		 3 8.8817842e-016 -4 4 8.8817842e-016 -4 5 8.8817842e-016 -4 6 8.8817842e-016 -4 7 8.8817842e-016 -4
		 8 8.8817842e-016 -4 9 8.8817842e-016 -4 10 8.8817842e-016 -4 17 8.8817842e-016 -4
		 18 8.8817842e-016 -4 19 8.8817842e-016 -4 20 8.8817842e-016 -4 21 8.8817842e-016 -4
		 22 8.8817842e-016 -4 23 8.8817842e-016 -4 24 8.8817842e-016 -4 25 8.8817842e-016 -4
		 -25 1.110223e-015 -5 -24 1.110223e-015 -5 -23 1.110223e-015 -5 -22 1.110223e-015 -5
		 -21 1.110223e-015 -5 -20 1.110223e-015 -5 -19 1.110223e-015 -5 -18 1.110223e-015 -5
		 -17 1.110223e-015 -5 -16 1.110223e-015 -5 -15 1.110223e-015 -5 -14 1.110223e-015 -5
		 -13 1.110223e-015 -5 -12 1.110223e-015 -5 -11 1.110223e-015 -5 -10 1.110223e-015 -5
		 -9 1.110223e-015 -5 -8 1.110223e-015 -5 -7 1.110223e-015 -5 -6 1.110223e-015 -5 -5 1.110223e-015 -5
		 -4 1.110223e-015 -5 -3 1.110223e-015 -5 -2 1.110223e-015 -5 -1 1.110223e-015 -5 0 1.110223e-015 -5
		 1 1.110223e-015 -5 2 1.110223e-015 -5 3 1.110223e-015 -5 4 1.110223e-015 -5 5 1.110223e-015 -5
		 6 1.110223e-015 -5;
	setAttr ".vt[1328:1493]" 7 1.110223e-015 -5 8 1.110223e-015 -5 9 1.110223e-015 -5
		 10 1.110223e-015 -5 17 1.110223e-015 -5 18 1.110223e-015 -5 19 1.110223e-015 -5 20 1.110223e-015 -5
		 21 1.110223e-015 -5 22 1.110223e-015 -5 23 1.110223e-015 -5 24 1.110223e-015 -5 25 1.110223e-015 -5
		 -25 1.3322676e-015 -6 -24 1.3322676e-015 -6 -23 1.3322676e-015 -6 -22 1.3322676e-015 -6
		 -21 1.3322676e-015 -6 -20 1.3322676e-015 -6 -19 1.3322676e-015 -6 -18 1.3322676e-015 -6
		 -17 1.3322676e-015 -6 -16 1.3322676e-015 -6 -15 1.3322676e-015 -6 -14 1.3322676e-015 -6
		 3 1.3322676e-015 -6 4 1.3322676e-015 -6 5 1.3322676e-015 -6 6 1.3322676e-015 -6 7 1.3322676e-015 -6
		 8 1.3322676e-015 -6 9 1.3322676e-015 -6 10 1.3322676e-015 -6 17 1.3322676e-015 -6
		 18 1.3322676e-015 -6 19 1.3322676e-015 -6 20 1.3322676e-015 -6 21 1.3322676e-015 -6
		 22 1.3322676e-015 -6 23 1.3322676e-015 -6 24 1.3322676e-015 -6 25 1.3322676e-015 -6
		 -25 1.5543122e-015 -7 -24 1.5543122e-015 -7 -23 1.5543122e-015 -7 -22 1.5543122e-015 -7
		 -21 1.5543122e-015 -7 -20 1.5543122e-015 -7 -19 1.5543122e-015 -7 -18 1.5543122e-015 -7
		 -17 1.5543122e-015 -7 -16 1.5543122e-015 -7 -15 1.5543122e-015 -7 -14 1.5543122e-015 -7
		 3 1.5543122e-015 -7 4 1.5543122e-015 -7 5 1.5543122e-015 -7 6 1.5543122e-015 -7 7 1.5543122e-015 -7
		 8 1.5543122e-015 -7 9 1.5543122e-015 -7 10 1.5543122e-015 -7 17 1.5543122e-015 -7
		 18 1.5543122e-015 -7 19 1.5543122e-015 -7 20 1.5543122e-015 -7 21 1.5543122e-015 -7
		 22 1.5543122e-015 -7 23 1.5543122e-015 -7 24 1.5543122e-015 -7 25 1.5543122e-015 -7
		 -25 1.7763568e-015 -8 -24 1.7763568e-015 -8 -23 1.7763568e-015 -8 -22 1.7763568e-015 -8
		 -21 1.7763568e-015 -8 -20 1.7763568e-015 -8 -19 1.7763568e-015 -8 -18 1.7763568e-015 -8
		 -17 1.7763568e-015 -8 -16 1.7763568e-015 -8 -15 1.7763568e-015 -8 -14 1.7763568e-015 -8
		 3 1.7763568e-015 -8 4 1.7763568e-015 -8 5 1.7763568e-015 -8 6 1.7763568e-015 -8 7 1.7763568e-015 -8
		 8 1.7763568e-015 -8 9 1.7763568e-015 -8 10 1.7763568e-015 -8 17 1.7763568e-015 -8
		 18 1.7763568e-015 -8 19 1.7763568e-015 -8 20 1.7763568e-015 -8 21 1.7763568e-015 -8
		 22 1.7763568e-015 -8 23 1.7763568e-015 -8 24 1.7763568e-015 -8 25 1.7763568e-015 -8
		 -25 1.9984014e-015 -9 -24 1.9984014e-015 -9 -23 1.9984014e-015 -9 -22 1.9984014e-015 -9
		 -21 1.9984014e-015 -9 -20 1.9984014e-015 -9 -19 1.9984014e-015 -9 -18 1.9984014e-015 -9
		 -17 1.9984014e-015 -9 -16 1.9984014e-015 -9 -15 1.9984014e-015 -9 -14 1.9984014e-015 -9
		 3 1.9984014e-015 -9 4 1.9984014e-015 -9 5 1.9984014e-015 -9 6 1.9984014e-015 -9 7 1.9984014e-015 -9
		 8 1.9984014e-015 -9 9 1.9984014e-015 -9 10 1.9984014e-015 -9 17 1.9984014e-015 -9
		 18 1.9984014e-015 -9 19 1.9984014e-015 -9 20 1.9984014e-015 -9 21 1.9984014e-015 -9
		 22 1.9984014e-015 -9 23 1.9984014e-015 -9 24 1.9984014e-015 -9 25 1.9984014e-015 -9
		 -25 2.220446e-015 -10 -24 2.220446e-015 -10 -23 2.220446e-015 -10 -22 2.220446e-015 -10
		 -21 2.220446e-015 -10 -20 2.220446e-015 -10 -19 2.220446e-015 -10 -18 2.220446e-015 -10
		 -17 2.220446e-015 -10 -16 2.220446e-015 -10 -15 2.220446e-015 -10 -14 2.220446e-015 -10
		 3 2.220446e-015 -10 4 2.220446e-015 -10 5 2.220446e-015 -10 6 2.220446e-015 -10 7 2.220446e-015 -10
		 8 2.220446e-015 -10 9 2.220446e-015 -10 10 2.220446e-015 -10 17 2.220446e-015 -10
		 18 2.220446e-015 -10 19 2.220446e-015 -10 20 2.220446e-015 -10 21 2.220446e-015 -10
		 22 2.220446e-015 -10 23 2.220446e-015 -10 24 2.220446e-015 -10 25 2.220446e-015 -10
		 -25 2.4424907e-015 -11 -24 2.4424907e-015 -11 -23 2.4424907e-015 -11 -22 2.4424907e-015 -11
		 -21 2.4424907e-015 -11 -20 2.4424907e-015 -11 -19 2.4424907e-015 -11 -18 2.4424907e-015 -11;
	setAttr ".vt[1494:1659]" -17 2.4424907e-015 -11 -16 2.4424907e-015 -11 -15 2.4424907e-015 -11
		 -14 2.4424907e-015 -11 3 2.4424907e-015 -11 4 2.4424907e-015 -11 5 2.4424907e-015 -11
		 6 2.4424907e-015 -11 7 2.4424907e-015 -11 8 2.4424907e-015 -11 9 2.4424907e-015 -11
		 10 2.4424907e-015 -11 11 2.4424907e-015 -11 12 2.4424907e-015 -11 13 2.4424907e-015 -11
		 14 2.4424907e-015 -11 15 2.4424907e-015 -11 16 2.4424907e-015 -11 17 2.4424907e-015 -11
		 18 2.4424907e-015 -11 19 2.4424907e-015 -11 20 2.4424907e-015 -11 21 2.4424907e-015 -11
		 22 2.4424907e-015 -11 23 2.4424907e-015 -11 24 2.4424907e-015 -11 25 2.4424907e-015 -11
		 -25 2.6645353e-015 -12 -24 2.6645353e-015 -12 -23 2.6645353e-015 -12 -22 2.6645353e-015 -12
		 -21 2.6645353e-015 -12 -20 2.6645353e-015 -12 -19 2.6645353e-015 -12 -18 2.6645353e-015 -12
		 -17 2.6645353e-015 -12 -16 2.6645353e-015 -12 -15 2.6645353e-015 -12 -14 2.6645353e-015 -12
		 -13 2.6645353e-015 -12 -12 2.6645353e-015 -12 -11 2.6645353e-015 -12 -10 2.6645353e-015 -12
		 -9 2.6645353e-015 -12 -8 2.6645353e-015 -12 -7 2.6645353e-015 -12 -6 2.6645353e-015 -12
		 -5 2.6645353e-015 -12 -4 2.6645353e-015 -12 -3 2.6645353e-015 -12 -2 2.6645353e-015 -12
		 -1 2.6645353e-015 -12 0 2.6645353e-015 -12 1 2.6645353e-015 -12 2 2.6645353e-015 -12
		 3 2.6645353e-015 -12 4 2.6645353e-015 -12 5 2.6645353e-015 -12 6 2.6645353e-015 -12
		 7 2.6645353e-015 -12 8 2.6645353e-015 -12 9 2.6645353e-015 -12 10 2.6645353e-015 -12
		 11 2.6645353e-015 -12 12 2.6645353e-015 -12 13 2.6645353e-015 -12 14 2.6645353e-015 -12
		 15 2.6645353e-015 -12 16 2.6645353e-015 -12 17 2.6645353e-015 -12 18 2.6645353e-015 -12
		 19 2.6645353e-015 -12 20 2.6645353e-015 -12 21 2.6645353e-015 -12 22 2.6645353e-015 -12
		 23 2.6645353e-015 -12 24 2.6645353e-015 -12 25 2.6645353e-015 -12 -25 2.8865799e-015 -13
		 -24 2.8865799e-015 -13 -23 2.8865799e-015 -13 -22 2.8865799e-015 -13 -21 2.8865799e-015 -13
		 -20 2.8865799e-015 -13 -19 2.8865799e-015 -13 -18 2.8865799e-015 -13 -17 2.8865799e-015 -13
		 -16 2.8865799e-015 -13 -15 2.8865799e-015 -13 -14 2.8865799e-015 -13 -13 2.8865799e-015 -13
		 -12 2.8865799e-015 -13 -11 2.8865799e-015 -13 -10 2.8865799e-015 -13 -9 2.8865799e-015 -13
		 -8 2.8865799e-015 -13 -7 2.8865799e-015 -13 -6 2.8865799e-015 -13 -5 2.8865799e-015 -13
		 -4 2.8865799e-015 -13 -3 2.8865799e-015 -13 -2 2.8865799e-015 -13 -1 2.8865799e-015 -13
		 0 2.8865799e-015 -13 1 2.8865799e-015 -13 2 2.8865799e-015 -13 3 2.8865799e-015 -13
		 4 2.8865799e-015 -13 5 2.8865799e-015 -13 6 2.8865799e-015 -13 7 2.8865799e-015 -13
		 8 2.8865799e-015 -13 9 2.8865799e-015 -13 10 2.8865799e-015 -13 11 2.8865799e-015 -13
		 12 2.8865799e-015 -13 13 2.8865799e-015 -13 14 2.8865799e-015 -13 15 2.8865799e-015 -13
		 16 2.8865799e-015 -13 17 2.8865799e-015 -13 18 2.8865799e-015 -13 19 2.8865799e-015 -13
		 20 2.8865799e-015 -13 21 2.8865799e-015 -13 22 2.8865799e-015 -13 23 2.8865799e-015 -13
		 24 2.8865799e-015 -13 25 2.8865799e-015 -13 -25 3.1086245e-015 -14 -24 3.1086245e-015 -14
		 -23 3.1086245e-015 -14 -22 3.1086245e-015 -14 -21 3.1086245e-015 -14 -20 3.1086245e-015 -14
		 -19 3.1086245e-015 -14 -18 3.1086245e-015 -14 -17 3.1086245e-015 -14 -16 3.1086245e-015 -14
		 -15 3.1086245e-015 -14 -14 3.1086245e-015 -14 -13 3.1086245e-015 -14 -12 3.1086245e-015 -14
		 -11 3.1086245e-015 -14 -10 3.1086245e-015 -14 -9 3.1086245e-015 -14 -8 3.1086245e-015 -14
		 -7 3.1086245e-015 -14 -6 3.1086245e-015 -14 -5 3.1086245e-015 -14 -4 3.1086245e-015 -14
		 -3 3.1086245e-015 -14 -2 3.1086245e-015 -14 -1 3.1086245e-015 -14 0 3.1086245e-015 -14
		 1 3.1086245e-015 -14 2 3.1086245e-015 -14 3 3.1086245e-015 -14 4 3.1086245e-015 -14
		 5 3.1086245e-015 -14 6 3.1086245e-015 -14 7 3.1086245e-015 -14 8 3.1086245e-015 -14
		 9 3.1086245e-015 -14 10 3.1086245e-015 -14 11 3.1086245e-015 -14;
	setAttr ".vt[1660:1825]" 12 3.1086245e-015 -14 13 3.1086245e-015 -14 14 3.1086245e-015 -14
		 15 3.1086245e-015 -14 16 3.1086245e-015 -14 17 3.1086245e-015 -14 18 3.1086245e-015 -14
		 19 3.1086245e-015 -14 20 3.1086245e-015 -14 21 3.1086245e-015 -14 22 3.1086245e-015 -14
		 23 3.1086245e-015 -14 24 3.1086245e-015 -14 25 3.1086245e-015 -14 -25 3.3306691e-015 -15
		 -24 3.3306691e-015 -15 -23 3.3306691e-015 -15 -22 3.3306691e-015 -15 -21 3.3306691e-015 -15
		 -20 3.3306691e-015 -15 -19 3.3306691e-015 -15 -18 3.3306691e-015 -15 -17 3.3306691e-015 -15
		 -16 3.3306691e-015 -15 -15 3.3306691e-015 -15 -14 3.3306691e-015 -15 -13 3.3306691e-015 -15
		 -12 3.3306691e-015 -15 -11 3.3306691e-015 -15 -10 3.3306691e-015 -15 -9 3.3306691e-015 -15
		 -8 3.3306691e-015 -15 -7 3.3306691e-015 -15 -6 3.3306691e-015 -15 -5 3.3306691e-015 -15
		 -4 3.3306691e-015 -15 -3 3.3306691e-015 -15 -2 3.3306691e-015 -15 -1 3.3306691e-015 -15
		 0 3.3306691e-015 -15 1 3.3306691e-015 -15 2 3.3306691e-015 -15 3 3.3306691e-015 -15
		 4 3.3306691e-015 -15 5 3.3306691e-015 -15 6 3.3306691e-015 -15 7 3.3306691e-015 -15
		 8 3.3306691e-015 -15 9 3.3306691e-015 -15 10 3.3306691e-015 -15 11 3.3306691e-015 -15
		 12 3.3306691e-015 -15 13 3.3306691e-015 -15 14 3.3306691e-015 -15 15 3.3306691e-015 -15
		 16 3.3306691e-015 -15 17 3.3306691e-015 -15 18 3.3306691e-015 -15 19 3.3306691e-015 -15
		 20 3.3306691e-015 -15 21 3.3306691e-015 -15 22 3.3306691e-015 -15 23 3.3306691e-015 -15
		 24 3.3306691e-015 -15 25 3.3306691e-015 -15 -25 3.5527137e-015 -16 -24 3.5527137e-015 -16
		 -23 3.5527137e-015 -16 -22 3.5527137e-015 -16 -21 3.5527137e-015 -16 -20 3.5527137e-015 -16
		 -19 3.5527137e-015 -16 -18 3.5527137e-015 -16 -17 3.5527137e-015 -16 -16 3.5527137e-015 -16
		 -15 3.5527137e-015 -16 -14 3.5527137e-015 -16 -13 3.5527137e-015 -16 -12 3.5527137e-015 -16
		 -11 3.5527137e-015 -16 -10 3.5527137e-015 -16 -9 3.5527137e-015 -16 -8 3.5527137e-015 -16
		 -7 3.5527137e-015 -16 -6 3.5527137e-015 -16 -5 3.5527137e-015 -16 -4 3.5527137e-015 -16
		 -3 3.5527137e-015 -16 -2 3.5527137e-015 -16 -1 3.5527137e-015 -16 0 3.5527137e-015 -16
		 1 3.5527137e-015 -16 2 3.5527137e-015 -16 3 3.5527137e-015 -16 4 3.5527137e-015 -16
		 5 3.5527137e-015 -16 6 3.5527137e-015 -16 7 3.5527137e-015 -16 8 3.5527137e-015 -16
		 9 3.5527137e-015 -16 10 3.5527137e-015 -16 11 3.5527137e-015 -16 12 3.5527137e-015 -16
		 13 3.5527137e-015 -16 14 3.5527137e-015 -16 15 3.5527137e-015 -16 16 3.5527137e-015 -16
		 17 3.5527137e-015 -16 18 3.5527137e-015 -16 19 3.5527137e-015 -16 20 3.5527137e-015 -16
		 21 3.5527137e-015 -16 22 3.5527137e-015 -16 23 3.5527137e-015 -16 24 3.5527137e-015 -16
		 25 3.5527137e-015 -16 -25 3.7747583e-015 -17 -24 3.7747583e-015 -17 -23 3.7747583e-015 -17
		 -22 3.7747583e-015 -17 -2 3.7747583e-015 -17 -1 3.7747583e-015 -17 0 3.7747583e-015 -17
		 1 3.7747583e-015 -17 2 3.7747583e-015 -17 3 3.7747583e-015 -17 4 3.7747583e-015 -17
		 5 3.7747583e-015 -17 6 3.7747583e-015 -17 7 3.7747583e-015 -17 8 3.7747583e-015 -17
		 9 3.7747583e-015 -17 10 3.7747583e-015 -17 11 3.7747583e-015 -17 12 3.7747583e-015 -17
		 13 3.7747583e-015 -17 14 3.7747583e-015 -17 15 3.7747583e-015 -17 16 3.7747583e-015 -17
		 17 3.7747583e-015 -17 18 3.7747583e-015 -17 19 3.7747583e-015 -17 20 3.7747583e-015 -17
		 21 3.7747583e-015 -17 22 3.7747583e-015 -17 23 3.7747583e-015 -17 24 3.7747583e-015 -17
		 25 3.7747583e-015 -17 -25 3.9968029e-015 -18 -24 3.9968029e-015 -18 -23 3.9968029e-015 -18
		 -22 3.9968029e-015 -18 -2 3.9968029e-015 -18 -1 3.9968029e-015 -18 0 3.9968029e-015 -18
		 1 3.9968029e-015 -18 2 3.9968029e-015 -18 3 3.9968029e-015 -18 4 3.9968029e-015 -18
		 5 3.9968029e-015 -18 6 3.9968029e-015 -18 7 3.9968029e-015 -18 8 3.9968029e-015 -18
		 9 3.9968029e-015 -18 10 3.9968029e-015 -18 11 3.9968029e-015 -18;
	setAttr ".vt[1826:1991]" 12 3.9968029e-015 -18 13 3.9968029e-015 -18 14 3.9968029e-015 -18
		 15 3.9968029e-015 -18 16 3.9968029e-015 -18 17 3.9968029e-015 -18 18 3.9968029e-015 -18
		 19 3.9968029e-015 -18 20 3.9968029e-015 -18 21 3.9968029e-015 -18 22 3.9968029e-015 -18
		 23 3.9968029e-015 -18 24 3.9968029e-015 -18 25 3.9968029e-015 -18 -25 4.2188475e-015 -19
		 -24 4.2188475e-015 -19 -23 4.2188475e-015 -19 -22 4.2188475e-015 -19 -2 4.2188475e-015 -19
		 -1 4.2188475e-015 -19 0 4.2188475e-015 -19 1 4.2188475e-015 -19 2 4.2188475e-015 -19
		 3 4.2188475e-015 -19 4 4.2188475e-015 -19 5 4.2188475e-015 -19 6 4.2188475e-015 -19
		 21 4.2188475e-015 -19 22 4.2188475e-015 -19 23 4.2188475e-015 -19 24 4.2188475e-015 -19
		 25 4.2188475e-015 -19 -25 4.4408921e-015 -20 -24 4.4408921e-015 -20 -23 4.4408921e-015 -20
		 -22 4.4408921e-015 -20 -2 4.4408921e-015 -20 -1 4.4408921e-015 -20 0 4.4408921e-015 -20
		 1 4.4408921e-015 -20 2 4.4408921e-015 -20 3 4.4408921e-015 -20 4 4.4408921e-015 -20
		 5 4.4408921e-015 -20 6 4.4408921e-015 -20 21 4.4408921e-015 -20 22 4.4408921e-015 -20
		 23 4.4408921e-015 -20 24 4.4408921e-015 -20 25 4.4408921e-015 -20 -25 4.6629367e-015 -21
		 -24 4.6629367e-015 -21 -23 4.6629367e-015 -21 -22 4.6629367e-015 -21 -2 4.6629367e-015 -21
		 -1 4.6629367e-015 -21 0 4.6629367e-015 -21 1 4.6629367e-015 -21 2 4.6629367e-015 -21
		 3 4.6629367e-015 -21 4 4.6629367e-015 -21 5 4.6629367e-015 -21 6 4.6629367e-015 -21
		 7 4.6629367e-015 -21 8 4.6629367e-015 -21 9 4.6629367e-015 -21 10 4.6629367e-015 -21
		 11 4.6629367e-015 -21 12 4.6629367e-015 -21 13 4.6629367e-015 -21 14 4.6629367e-015 -21
		 15 4.6629367e-015 -21 16 4.6629367e-015 -21 17 4.6629367e-015 -21 18 4.6629367e-015 -21
		 19 4.6629367e-015 -21 20 4.6629367e-015 -21 21 4.6629367e-015 -21 22 4.6629367e-015 -21
		 23 4.6629367e-015 -21 24 4.6629367e-015 -21 25 4.6629367e-015 -21 -25 4.8849813e-015 -22
		 -24 4.8849813e-015 -22 -23 4.8849813e-015 -22 -22 4.8849813e-015 -22 -21 4.8849813e-015 -22
		 -20 4.8849813e-015 -22 -19 4.8849813e-015 -22 -18 4.8849813e-015 -22 -17 4.8849813e-015 -22
		 -16 4.8849813e-015 -22 -15 4.8849813e-015 -22 -14 4.8849813e-015 -22 -13 4.8849813e-015 -22
		 -12 4.8849813e-015 -22 -11 4.8849813e-015 -22 -10 4.8849813e-015 -22 -9 4.8849813e-015 -22
		 -8 4.8849813e-015 -22 -7 4.8849813e-015 -22 -6 4.8849813e-015 -22 -5 4.8849813e-015 -22
		 -4 4.8849813e-015 -22 -3 4.8849813e-015 -22 -2 4.8849813e-015 -22 -1 4.8849813e-015 -22
		 0 4.8849813e-015 -22 1 4.8849813e-015 -22 2 4.8849813e-015 -22 3 4.8849813e-015 -22
		 4 4.8849813e-015 -22 5 4.8849813e-015 -22 6 4.8849813e-015 -22 7 4.8849813e-015 -22
		 8 4.8849813e-015 -22 9 4.8849813e-015 -22 10 4.8849813e-015 -22 11 4.8849813e-015 -22
		 12 4.8849813e-015 -22 13 4.8849813e-015 -22 14 4.8849813e-015 -22 15 4.8849813e-015 -22
		 16 4.8849813e-015 -22 17 4.8849813e-015 -22 18 4.8849813e-015 -22 19 4.8849813e-015 -22
		 20 4.8849813e-015 -22 21 4.8849813e-015 -22 22 4.8849813e-015 -22 23 4.8849813e-015 -22
		 24 4.8849813e-015 -22 25 4.8849813e-015 -22 -25 5.1070259e-015 -23 -24 5.1070259e-015 -23
		 -23 5.1070259e-015 -23 -22 5.1070259e-015 -23 -21 5.1070259e-015 -23 -20 5.1070259e-015 -23
		 -19 5.1070259e-015 -23 -18 5.1070259e-015 -23 -17 5.1070259e-015 -23 -16 5.1070259e-015 -23
		 -15 5.1070259e-015 -23 -14 5.1070259e-015 -23 -13 5.1070259e-015 -23 -12 5.1070259e-015 -23
		 -11 5.1070259e-015 -23 -10 5.1070259e-015 -23 -9 5.1070259e-015 -23 -8 5.1070259e-015 -23
		 -7 5.1070259e-015 -23 -6 5.1070259e-015 -23 -5 5.1070259e-015 -23 -4 5.1070259e-015 -23
		 -3 5.1070259e-015 -23 -2 5.1070259e-015 -23 -1 5.1070259e-015 -23 0 5.1070259e-015 -23
		 1 5.1070259e-015 -23 2 5.1070259e-015 -23 3 5.1070259e-015 -23 4 5.1070259e-015 -23
		 5 5.1070259e-015 -23 6 5.1070259e-015 -23 7 5.1070259e-015 -23;
	setAttr ".vt[1992:2111]" 8 5.1070259e-015 -23 9 5.1070259e-015 -23 10 5.1070259e-015 -23
		 11 5.1070259e-015 -23 12 5.1070259e-015 -23 13 5.1070259e-015 -23 14 5.1070259e-015 -23
		 15 5.1070259e-015 -23 16 5.1070259e-015 -23 17 5.1070259e-015 -23 18 5.1070259e-015 -23
		 19 5.1070259e-015 -23 20 5.1070259e-015 -23 21 5.1070259e-015 -23 22 5.1070259e-015 -23
		 23 5.1070259e-015 -23 24 5.1070259e-015 -23 25 5.1070259e-015 -23 -25 5.3290705e-015 -24
		 -24 5.3290705e-015 -24 -23 5.3290705e-015 -24 -22 5.3290705e-015 -24 -21 5.3290705e-015 -24
		 -20 5.3290705e-015 -24 -19 5.3290705e-015 -24 -18 5.3290705e-015 -24 -17 5.3290705e-015 -24
		 -16 5.3290705e-015 -24 -15 5.3290705e-015 -24 -14 5.3290705e-015 -24 -13 5.3290705e-015 -24
		 -12 5.3290705e-015 -24 -11 5.3290705e-015 -24 -10 5.3290705e-015 -24 -9 5.3290705e-015 -24
		 -8 5.3290705e-015 -24 -7 5.3290705e-015 -24 -6 5.3290705e-015 -24 -5 5.3290705e-015 -24
		 -4 5.3290705e-015 -24 -3 5.3290705e-015 -24 -2 5.3290705e-015 -24 -1 5.3290705e-015 -24
		 0 5.3290705e-015 -24 1 5.3290705e-015 -24 2 5.3290705e-015 -24 3 5.3290705e-015 -24
		 4 5.3290705e-015 -24 5 5.3290705e-015 -24 6 5.3290705e-015 -24 7 5.3290705e-015 -24
		 8 5.3290705e-015 -24 9 5.3290705e-015 -24 10 5.3290705e-015 -24 11 5.3290705e-015 -24
		 12 5.3290705e-015 -24 13 5.3290705e-015 -24 14 5.3290705e-015 -24 15 5.3290705e-015 -24
		 16 5.3290705e-015 -24 17 5.3290705e-015 -24 18 5.3290705e-015 -24 19 5.3290705e-015 -24
		 20 5.3290705e-015 -24 21 5.3290705e-015 -24 22 5.3290705e-015 -24 23 5.3290705e-015 -24
		 24 5.3290705e-015 -24 25 5.3290705e-015 -24 -25 5.5511151e-015 -25 -24 5.5511151e-015 -25
		 -23 5.5511151e-015 -25 -22 5.5511151e-015 -25 -21 5.5511151e-015 -25 -20 5.5511151e-015 -25
		 -19 5.5511151e-015 -25 -18 5.5511151e-015 -25 -17 5.5511151e-015 -25 -16 5.5511151e-015 -25
		 -15 5.5511151e-015 -25 -14 5.5511151e-015 -25 -13 5.5511151e-015 -25 -12 5.5511151e-015 -25
		 -11 5.5511151e-015 -25 -10 5.5511151e-015 -25 -9 5.5511151e-015 -25 -8 5.5511151e-015 -25
		 -7 5.5511151e-015 -25 -6 5.5511151e-015 -25 -5 5.5511151e-015 -25 -4 5.5511151e-015 -25
		 -3 5.5511151e-015 -25 -2 5.5511151e-015 -25 -1 5.5511151e-015 -25 0 5.5511151e-015 -25
		 1 5.5511151e-015 -25 2 5.5511151e-015 -25 3 5.5511151e-015 -25 4 5.5511151e-015 -25
		 5 5.5511151e-015 -25 6 5.5511151e-015 -25 7 5.5511151e-015 -25 8 5.5511151e-015 -25
		 9 5.5511151e-015 -25 10 5.5511151e-015 -25 11 5.5511151e-015 -25 12 5.5511151e-015 -25
		 13 5.5511151e-015 -25 14 5.5511151e-015 -25 15 5.5511151e-015 -25 16 5.5511151e-015 -25
		 17 5.5511151e-015 -25 18 5.5511151e-015 -25 19 5.5511151e-015 -25 20 5.5511151e-015 -25
		 21 5.5511151e-015 -25 22 5.5511151e-015 -25 23 5.5511151e-015 -25 24 5.5511151e-015 -25
		 25 5.5511151e-015 -25;
	setAttr -s 3991 ".ed";
	setAttr ".ed[0:165]"  0 1 0 0 51 0 1 2 0 1 52 1 2 3 0 2 53 1 3 4 0 3 54 1
		 4 5 0 4 55 1 5 6 0 5 56 1 6 7 0 6 57 1 7 8 0 7 58 1 8 9 0 8 59 1 9 10 0 9 60 1 10 11 0
		 10 61 1 11 12 0 11 62 1 12 13 0 12 63 1 13 14 0 13 64 1 14 15 0 14 65 1 15 16 0 15 66 1
		 16 17 0 16 67 1 17 18 0 17 68 1 18 19 0 18 69 1 19 20 0 19 70 1 20 21 0 20 71 1 21 22 0
		 21 72 1 22 23 0 22 73 1 23 24 0 23 74 1 24 25 0 24 75 1 25 26 0 25 76 1 26 27 0 26 77 1
		 27 28 0 27 78 1 28 29 0 28 79 1 29 30 0 29 80 1 30 31 0 30 81 1 31 32 0 31 82 1 32 33 0
		 32 83 1 33 34 0 33 84 1 34 35 0 34 85 1 35 36 0 35 86 1 36 37 0 36 87 1 37 38 0 37 88 1
		 38 39 0 38 89 1 39 40 0 39 90 1 40 41 0 40 91 1 41 42 0 41 92 1 42 43 0 42 93 1 43 44 0
		 43 94 1 44 45 0 44 95 1 45 46 0 45 96 1 46 47 0 46 97 1 47 48 0 47 98 1 48 49 0 48 99 1
		 49 50 0 49 100 1 50 101 0 51 52 1 51 102 0 52 53 1 52 103 1 53 54 1 53 104 1 54 55 1
		 54 105 1 55 56 1 55 106 1 56 57 1 56 107 1 57 58 1 57 108 1 58 59 1 58 109 1 59 60 1
		 59 110 1 60 61 1 60 111 1 61 62 1 61 112 1 62 63 1 62 113 1 63 64 1 63 114 1 64 65 1
		 64 115 1 65 66 1 65 116 1 66 67 1 66 117 1 67 68 1 67 118 1 68 69 1 68 119 1 69 70 1
		 69 120 1 70 71 1 70 121 1 71 72 1 71 122 1 72 73 1 72 123 1 73 74 1 73 124 1 74 75 1
		 74 125 1 75 76 1 75 126 1 76 77 1 76 127 1 77 78 1 77 128 1 78 79 1 78 129 1 79 80 1
		 79 130 1 80 81 1 80 131 1 81 82 1 81 132 1 82 83 1 82 133 1 83 84 1;
	setAttr ".ed[166:331]" 83 134 1 84 85 1 84 135 1 85 86 1 85 136 1 86 87 1 86 137 1
		 87 88 1 87 138 1 88 89 1 88 139 1 89 90 1 89 140 1 90 91 1 90 141 1 91 92 1 91 142 1
		 92 93 1 92 143 1 93 94 1 93 144 1 94 95 1 94 145 1 95 96 1 95 146 1 96 97 1 96 147 1
		 97 98 1 97 148 1 98 99 1 98 149 1 99 100 1 99 150 1 100 101 1 100 151 1 101 152 0
		 102 103 1 102 153 0 103 104 1 103 154 1 104 105 1 104 155 1 105 106 1 105 156 1 106 107 1
		 106 157 1 107 108 1 107 158 1 108 109 1 108 159 1 109 110 1 109 160 1 110 111 1 110 161 1
		 111 112 1 111 162 1 112 113 1 112 163 1 113 114 1 113 164 1 114 115 1 114 165 1 115 116 1
		 115 166 1 116 117 1 116 167 1 117 118 1 117 168 1 118 119 1 118 169 1 119 120 1 119 170 1
		 120 121 1 120 171 1 121 122 1 121 172 1 122 123 1 122 173 1 123 124 1 123 174 1 124 125 1
		 124 175 1 125 126 1 125 176 1 126 127 1 126 177 1 127 128 1 127 178 1 128 129 1 128 179 1
		 129 130 1 129 180 1 130 131 1 130 181 1 131 132 1 131 182 1 132 133 1 132 183 1 133 134 1
		 133 184 1 134 135 1 134 185 1 135 136 1 135 186 1 136 137 1 136 187 1 137 138 1 137 188 1
		 138 139 1 138 189 1 139 140 1 139 190 1 140 141 1 140 191 1 141 142 1 141 192 1 142 143 1
		 142 193 1 143 144 1 143 194 1 144 145 1 144 195 1 145 146 1 145 196 1 146 147 1 146 197 1
		 147 148 1 147 198 1 148 149 1 148 199 1 149 150 1 149 200 1 150 151 1 150 201 1 151 152 1
		 151 202 1 152 203 0 153 154 1 153 204 0 154 155 1 154 205 1 155 156 1 155 206 1 156 157 1
		 156 207 1 157 158 1 157 208 1 158 159 1 158 209 1 159 160 1 159 210 1 160 161 1 160 211 1
		 161 162 1 161 212 1 162 163 1 162 213 1 163 164 1 163 214 1 164 165 1 164 215 1 165 166 1
		 165 216 1 166 167 1 166 217 1 167 168 1;
	setAttr ".ed[332:497]" 167 218 1 168 169 1 168 219 1 169 170 1 169 220 1 170 171 1
		 170 221 1 171 172 1 171 222 1 172 173 1 172 223 1 173 174 1 173 224 1 174 175 1 174 225 1
		 175 176 1 175 226 1 176 177 1 176 227 1 177 178 1 177 228 1 178 179 1 178 229 1 179 180 1
		 179 230 1 180 181 1 180 231 1 181 182 1 181 232 1 182 183 1 182 233 1 183 184 1 183 234 1
		 184 185 1 184 235 1 185 186 1 185 236 1 186 187 1 186 237 1 187 188 1 187 238 1 188 189 1
		 188 239 1 189 190 1 189 240 1 190 191 1 190 241 1 191 192 1 191 242 1 192 193 1 192 243 1
		 193 194 1 193 244 1 194 195 1 194 245 1 195 196 1 195 246 1 196 197 1 196 247 1 197 198 1
		 197 248 1 198 199 1 198 249 1 199 200 1 199 250 1 200 201 1 200 251 1 201 202 1 201 252 1
		 202 203 1 202 253 1 203 254 0 204 205 1 204 255 0 205 206 1 205 256 1 206 207 1 206 257 1
		 207 208 1 207 258 1 208 209 1 208 259 1 209 210 1 209 260 1 210 211 1 210 261 1 211 212 1
		 211 262 1 212 213 1 212 263 1 213 214 1 213 264 1 214 215 1 214 265 1 215 216 1 215 266 1
		 216 217 1 216 267 1 217 218 1 217 268 1 218 219 1 218 269 1 219 220 1 219 270 1 220 221 1
		 220 271 1 221 222 1 221 272 1 222 223 1 222 273 1 223 224 1 223 274 1 224 225 1 224 275 1
		 225 226 1 225 276 1 226 227 1 226 277 1 227 228 1 227 278 1 228 229 1 228 279 1 229 230 1
		 229 280 1 230 231 1 230 281 1 231 232 1 231 282 1 232 233 1 232 283 1 233 234 1 233 284 1
		 234 235 1 234 285 1 235 236 1 235 286 1 236 237 1 236 287 1 237 238 1 237 288 1 238 239 1
		 238 289 1 239 240 1 239 290 1 240 241 1 240 291 1 241 242 1 241 292 1 242 243 1 242 293 1
		 243 244 1 243 294 1 244 245 1 244 295 1 245 246 1 245 296 1 246 247 1 246 297 1 247 248 1
		 247 298 1 248 249 1 248 299 1 249 250 1 249 300 1 250 251 1 250 301 1;
	setAttr ".ed[498:663]" 251 252 1 251 302 1 252 253 1 252 303 1 253 254 1 253 304 1
		 254 305 0 255 256 1 255 306 0 256 257 1 256 307 1 257 258 1 257 308 1 258 259 1 258 309 1
		 259 260 1 259 310 1 260 261 1 260 311 1 261 262 1 261 312 1 262 263 1 262 313 1 263 264 1
		 263 314 1 264 265 1 264 315 1 265 266 1 265 316 1 266 267 1 266 317 1 267 268 1 267 318 1
		 268 269 1 268 319 1 269 270 1 269 320 1 270 271 1 270 321 1 271 272 1 271 322 1 272 273 1
		 272 323 1 273 274 1 273 324 1 274 275 1 274 325 1 275 276 1 275 326 1 276 277 1 276 327 1
		 277 278 1 277 328 1 278 279 1 278 329 1 279 280 1 279 330 1 280 281 1 280 331 1 281 282 1
		 281 332 1 282 283 1 282 333 1 283 284 1 283 334 1 284 285 1 284 335 1 285 286 1 285 336 1
		 286 287 1 286 337 1 287 288 1 287 338 1 288 289 1 288 339 1 289 290 1 289 340 1 290 291 1
		 290 341 1 291 292 1 291 342 1 292 293 1 292 343 1 293 294 1 293 344 1 294 295 1 294 345 1
		 295 296 1 295 346 1 296 297 1 296 347 1 297 298 1 297 348 1 298 299 1 298 349 1 299 300 1
		 299 350 1 300 301 1 300 351 1 301 302 1 301 352 1 302 303 1 302 353 1 303 304 1 303 354 1
		 304 305 1 304 355 1 305 356 0 306 307 1 306 357 0 307 308 1 307 358 1 308 309 1 308 359 1
		 309 310 1 309 360 1 310 311 1 310 361 1 311 312 1 311 362 1 312 313 1 312 363 1 313 314 1
		 313 364 1 314 315 1 314 365 1 315 316 1 315 366 1 316 317 1 316 367 1 317 318 1 317 368 1
		 318 319 1 318 369 1 319 320 1 319 370 1 320 321 1 320 371 1 321 322 1 321 372 1 322 323 1
		 322 373 1 323 324 1 323 374 1 324 325 1 324 375 1 325 326 1 325 376 1 326 327 1 326 377 1
		 327 328 1 327 378 1 328 329 1 328 379 1 329 330 1 329 380 1 330 331 1 330 381 1 331 332 1
		 331 382 1 332 333 1 332 383 1 333 334 1 333 384 1 334 335 1 334 385 1;
	setAttr ".ed[664:829]" 335 336 1 335 386 1 336 337 1 336 387 1 337 338 1 337 388 1
		 338 339 1 338 389 1 339 340 1 339 390 1 340 341 1 340 391 1 341 342 1 341 392 1 342 343 1
		 342 393 1 343 344 1 343 394 1 344 345 1 344 395 1 345 346 1 345 396 1 346 347 1 346 397 1
		 347 348 1 347 398 1 348 349 1 348 399 1 349 350 1 349 400 1 350 351 1 350 401 1 351 352 1
		 351 402 1 352 353 1 352 403 1 353 354 1 353 404 1 354 355 1 354 405 1 355 356 1 355 406 1
		 356 407 0 357 358 1 357 408 0 358 359 1 358 409 1 359 360 1 359 410 1 360 361 1 360 411 1
		 361 362 1 361 412 1 362 363 1 362 413 1 363 364 1 363 414 1 364 365 1 364 415 1 365 366 1
		 365 416 1 366 367 1 366 417 1 367 368 1 367 418 1 368 369 1 368 419 1 369 370 1 369 420 1
		 370 371 1 370 421 1 371 372 1 371 422 1 372 373 1 372 423 1 373 374 1 373 424 1 374 375 1
		 374 425 1 375 376 1 375 426 1 376 377 1 376 427 1 377 378 1 377 428 1 378 379 1 378 429 1
		 379 380 1 379 430 1 380 381 1 380 431 1 381 382 1 381 432 1 382 383 1 382 433 1 383 384 1
		 383 434 1 384 385 1 384 435 1 385 386 1 385 436 1 386 387 1 386 437 1 387 388 1 387 438 1
		 388 389 1 388 439 1 389 390 1 389 440 1 390 391 1 390 441 1 391 392 1 391 442 1 392 393 1
		 392 443 1 393 394 1 393 444 1 394 395 1 394 445 1 395 396 1 395 446 1 396 397 1 396 447 1
		 397 398 1 397 448 1 398 399 1 398 449 1 399 400 1 399 450 1 400 401 1 400 451 1 401 402 1
		 401 452 1 402 403 1 402 453 1 403 404 1 403 454 1 404 405 1 404 455 1 405 406 1 405 456 1
		 406 407 1 406 457 1 407 458 0 408 409 1 408 459 0 409 410 1 409 460 1 410 411 1 410 461 1
		 411 412 1 411 462 1 412 413 1 412 463 1 413 414 1 413 464 1 414 415 1 414 465 1 415 416 1
		 415 466 1 416 417 1 416 467 1 417 418 1 417 468 1 418 419 1 418 469 1;
	setAttr ".ed[830:995]" 419 420 1 419 470 1 420 421 1 420 471 1 421 422 1 421 472 1
		 422 423 1 422 473 1 423 424 1 423 474 1 424 425 1 424 475 1 425 426 1 425 476 1 426 427 1
		 426 477 1 427 428 1 427 478 1 428 429 1 428 479 1 429 430 0 429 480 0 430 431 0 431 432 0
		 432 433 0 433 434 0 434 435 0 435 436 0 436 437 0 437 438 0 438 439 0 439 440 0 440 441 0
		 441 442 0 442 443 0 443 444 0 444 445 0 445 446 0 446 447 0 447 448 0 448 449 0 449 450 0
		 450 451 1 450 481 0 451 452 1 451 482 1 452 453 1 452 483 1 453 454 1 453 484 1 454 455 1
		 454 485 1 455 456 1 455 486 1 456 457 1 456 487 1 457 458 1 457 488 1 458 489 0 459 460 1
		 459 490 0 460 461 1 460 491 1 461 462 1 461 492 1 462 463 1 462 493 1 463 464 1 463 494 1
		 464 465 1 464 495 1 465 466 1 465 496 1 466 467 1 466 497 1 467 468 1 467 498 1 468 469 1
		 468 499 1 469 470 1 469 500 1 470 471 1 470 501 1 471 472 1 471 502 1 472 473 1 472 503 1
		 473 474 1 473 504 1 474 475 1 474 505 1 475 476 1 475 506 1 476 477 1 476 507 1 477 478 1
		 477 508 1 478 479 1 478 509 1 479 480 1 479 510 1 480 511 0 481 482 1 481 512 0 482 483 1
		 482 513 1 483 484 1 483 514 1 484 485 1 484 515 1 485 486 1 485 516 1 486 487 1 486 517 1
		 487 488 1 487 518 1 488 489 1 488 519 1 489 520 0 490 491 1 490 521 0 491 492 1 491 522 1
		 492 493 1 492 523 1 493 494 1 493 524 1 494 495 1 494 525 1 495 496 1 495 526 1 496 497 1
		 496 527 1 497 498 1 497 528 1 498 499 1 498 529 1 499 500 1 499 530 1 500 501 1 500 531 1
		 501 502 1 501 532 1 502 503 1 502 533 1 503 504 1 503 534 1 504 505 1 504 535 1 505 506 1
		 505 536 1 506 507 1 506 537 1 507 508 1 507 538 1 508 509 1 508 539 1 509 510 1 509 540 1
		 510 511 1 510 541 1 511 542 0 512 513 1 512 543 0 513 514 1 513 544 1;
	setAttr ".ed[996:1161]" 514 515 1 514 545 1 515 516 1 515 546 1 516 517 1 516 547 1
		 517 518 1 517 548 1 518 519 1 518 549 1 519 520 1 519 550 1 520 551 0 521 522 1 521 552 0
		 522 523 1 522 553 1 523 524 1 523 554 1 524 525 1 524 555 1 525 526 1 525 556 1 526 527 1
		 526 557 1 527 528 1 527 558 1 528 529 1 528 559 1 529 530 1 529 560 1 530 531 1 530 561 1
		 531 532 1 531 562 1 532 533 1 532 563 1 533 534 1 533 564 1 534 535 1 534 565 1 535 536 1
		 535 566 1 536 537 1 536 567 1 537 538 1 537 568 1 538 539 1 538 569 1 539 540 1 539 570 1
		 540 541 1 540 571 1 541 542 1 541 572 1 542 573 0 543 544 1 543 574 0 544 545 1 544 575 1
		 545 546 1 545 576 1 546 547 1 546 577 1 547 548 1 547 578 1 548 549 1 548 579 1 549 550 1
		 549 580 1 550 551 1 550 581 1 551 582 0 552 553 1 552 583 0 553 554 1 553 584 1 554 555 1
		 554 585 1 555 556 1 555 586 1 556 557 1 556 587 1 557 558 1 557 588 1 558 559 1 558 589 1
		 559 560 1 559 590 1 560 561 1 560 591 1 561 562 1 561 592 1 562 563 1 562 593 1 563 564 1
		 563 594 1 564 565 1 564 595 1 565 566 1 565 596 1 566 567 1 566 597 1 567 568 1 567 598 1
		 568 569 1 568 599 1 569 570 1 569 600 1 570 571 1 570 601 1 571 572 1 571 602 1 572 573 1
		 572 603 1 573 604 0 574 575 1 574 605 0 575 576 1 575 606 1 576 577 1 576 607 1 577 578 1
		 577 608 1 578 579 1 578 609 1 579 580 1 579 610 1 580 581 1 580 611 1 581 582 1 581 612 1
		 582 613 0 583 584 1 583 614 0 584 585 1 584 615 1 585 586 1 585 616 1 586 587 1 586 617 1
		 587 588 1 587 618 1 588 589 1 588 619 1 589 590 1 589 620 1 590 591 1 590 621 1 591 592 1
		 591 622 1 592 593 1 592 623 1 593 594 1 593 624 1 594 595 1 594 625 1 595 596 1 595 626 1
		 596 597 1 596 627 1 597 598 1 597 628 1 598 599 1 598 629 1 599 600 1;
	setAttr ".ed[1162:1327]" 599 630 1 600 601 1 600 631 1 601 602 1 601 632 1 602 603 1
		 602 633 1 603 604 1 603 634 1 604 635 0 605 606 1 605 656 0 606 607 1 606 657 1 607 608 1
		 607 658 1 608 609 1 608 659 1 609 610 1 609 660 1 610 611 1 610 661 1 611 612 1 611 662 1
		 612 613 1 612 663 1 613 664 0 614 615 1 614 665 0 615 616 1 615 666 1 616 617 1 616 667 1
		 617 618 1 617 668 1 618 619 1 618 669 1 619 620 1 619 670 1 620 621 1 620 671 1 621 622 1
		 621 672 1 622 623 1 622 673 1 623 624 1 623 674 1 624 625 1 624 675 1 625 626 1 625 676 1
		 626 627 1 626 677 1 627 628 1 627 678 1 628 629 1 628 679 1 629 630 1 629 680 1 630 631 1
		 630 681 1 631 632 1 631 682 1 632 633 1 632 683 1 633 634 1 633 684 1 634 635 1 634 685 1
		 635 636 0 635 686 1 636 637 0 636 687 1 637 638 0 637 688 1 638 639 0 638 689 1 639 640 0
		 639 690 1 640 641 0 640 691 1 641 642 0 641 692 1 642 643 0 642 693 1 643 644 0 643 694 1
		 644 645 0 644 695 1 645 646 0 645 696 1 646 647 0 646 697 1 647 648 0 647 698 1 648 649 0
		 648 699 1 649 650 0 649 700 1 650 651 0 650 701 1 651 652 0 651 702 1 652 653 0 652 703 1
		 653 654 0 653 704 1 654 655 0 654 705 1 655 656 0 655 706 1 656 657 1 656 707 1 657 658 1
		 657 708 1 658 659 1 658 709 1 659 660 1 659 710 1 660 661 1 660 711 1 661 662 1 661 712 1
		 662 663 1 662 713 1 663 664 1 663 714 1 664 715 0 665 666 1 665 716 0 666 667 1 666 717 1
		 667 668 1 667 718 1 668 669 1 668 719 1 669 670 1 669 720 1 670 671 1 670 721 1 671 672 1
		 671 722 1 672 673 1 672 723 1 673 674 1 673 724 1 674 675 1 674 725 1 675 676 1 675 726 1
		 676 677 1 676 727 1 677 678 1 677 728 1 678 679 1 678 729 1 679 680 1 679 730 1 680 681 1
		 680 731 1 681 682 1 681 732 1 682 683 1 682 733 1 683 684 1 683 734 1;
	setAttr ".ed[1328:1493]" 684 685 1 684 735 1 685 686 1 685 736 1 686 687 1 686 737 1
		 687 688 1 687 738 1 688 689 1 688 739 1 689 690 1 689 740 1 690 691 1 690 741 1 691 692 1
		 691 742 1 692 693 1 692 743 1 693 694 1 693 744 1 694 695 1 694 745 1 695 696 1 695 746 1
		 696 697 1 696 747 1 697 698 1 697 748 1 698 699 1 698 749 1 699 700 1 699 750 1 700 701 1
		 700 751 1 701 702 1 701 752 1 702 703 1 702 753 1 703 704 1 703 754 1 704 705 1 704 755 1
		 705 706 1 705 756 1 706 707 1 706 757 1 707 708 1 707 758 1 708 709 1 708 759 1 709 710 1
		 709 760 1 710 711 1 710 761 1 711 712 1 711 762 1 712 713 1 712 763 1 713 714 1 713 764 1
		 714 715 1 714 765 1 715 766 0 716 717 1 716 767 0 717 718 1 717 768 1 718 719 1 718 769 1
		 719 720 1 719 770 1 720 721 1 720 771 1 721 722 1 721 772 1 722 723 1 722 773 1 723 724 1
		 723 774 1 724 725 1 724 775 1 725 726 1 725 776 1 726 727 1 726 777 1 727 728 1 727 778 1
		 728 729 1 728 779 1 729 730 1 729 780 1 730 731 1 730 781 1 731 732 1 731 782 1 732 733 1
		 732 783 1 733 734 1 733 784 1 734 735 1 734 785 1 735 736 1 735 786 1 736 737 1 736 787 1
		 737 738 1 737 788 1 738 739 1 738 789 1 739 740 1 739 790 1 740 741 1 740 791 1 741 742 1
		 741 792 1 742 743 1 742 793 1 743 744 1 743 794 1 744 745 1 744 795 1 745 746 1 745 796 1
		 746 747 1 746 797 1 747 748 1 747 798 1 748 749 1 748 799 1 749 750 1 749 800 1 750 751 1
		 750 801 1 751 752 1 751 802 1 752 753 1 752 803 1 753 754 1 753 804 1 754 755 1 754 805 1
		 755 756 1 755 806 1 756 757 1 756 807 1 757 758 1 757 808 1 758 759 1 758 809 1 759 760 1
		 759 810 1 760 761 1 760 811 1 761 762 1 761 812 1 762 763 1 762 813 1 763 764 1 763 814 1
		 764 765 1 764 815 1 765 766 1 765 816 1 766 817 0 767 768 1 767 818 0;
	setAttr ".ed[1494:1659]" 768 769 1 768 819 1 769 770 1 769 820 1 770 771 1 770 821 1
		 771 772 1 771 822 1 772 773 1 772 823 1 773 774 1 773 824 1 774 775 1 774 825 1 775 776 1
		 775 826 1 776 777 1 776 827 1 777 778 1 777 828 1 778 779 1 778 829 1 779 780 1 779 830 1
		 780 781 1 780 831 1 781 782 1 781 832 1 782 783 1 782 833 1 783 784 1 783 834 1 784 785 1
		 784 835 1 785 786 1 785 836 1 786 787 1 786 837 1 787 788 1 787 838 1 788 789 1 788 839 1
		 789 790 1 789 840 1 790 791 1 790 841 1 791 792 1 791 842 1 792 793 1 792 843 1 793 794 1
		 793 844 1 794 795 1 794 845 1 795 796 1 795 846 1 796 797 1 796 847 1 797 798 1 797 848 1
		 798 799 1 798 849 1 799 800 1 799 850 1 800 801 1 800 851 1 801 802 1 801 852 1 802 803 1
		 802 853 1 803 804 1 803 854 1 804 805 1 804 855 1 805 806 1 805 856 1 806 807 1 806 857 1
		 807 808 1 807 858 1 808 809 1 808 859 1 809 810 1 809 860 1 810 811 1 810 861 1 811 812 1
		 811 862 1 812 813 1 812 863 1 813 814 1 813 864 1 814 815 1 814 865 1 815 816 1 815 866 1
		 816 817 1 816 867 1 817 868 0 818 819 1 818 869 0 819 820 1 819 870 1 820 821 1 820 871 1
		 821 822 1 821 872 1 822 823 1 822 873 1 823 824 0 823 874 0 824 825 0 825 826 0 826 827 0
		 827 828 0 828 829 0 829 830 0 830 831 0 831 832 0 832 833 0 833 834 0 834 835 0 835 836 0
		 836 837 0 837 838 0 838 839 0 839 840 0 840 841 0 841 842 1 841 875 0 842 843 1 842 876 1
		 843 844 1 843 877 1 844 845 1 844 878 1 845 846 1 845 879 1 846 847 1 846 880 1 847 848 1
		 847 881 1 848 849 1 848 882 1 849 850 1 849 883 1 850 851 1 850 884 1 851 852 1 851 885 1
		 852 853 1 852 886 1 853 854 0 853 887 0 854 855 0 855 856 0 856 857 0 857 858 0 858 859 0
		 859 860 0 860 861 1 860 888 0 861 862 1 861 889 1 862 863 1 862 890 1;
	setAttr ".ed[1660:1825]" 863 864 1 863 891 1 864 865 1 864 892 1 865 866 1 865 893 1
		 866 867 1 866 894 1 867 868 1 867 895 1 868 896 0 869 870 1 869 897 0 870 871 1 870 898 1
		 871 872 1 871 899 1 872 873 1 872 900 1 873 874 1 873 901 1 874 902 0 875 876 1 875 903 0
		 876 877 1 876 904 1 877 878 1 877 905 1 878 879 1 878 906 1 879 880 1 879 907 1 880 881 1
		 880 908 1 881 882 1 881 909 1 882 883 1 882 910 1 883 884 1 883 911 1 884 885 1 884 912 1
		 885 886 1 885 913 1 886 887 1 886 914 1 887 915 0 888 889 1 888 916 0 889 890 1 889 917 1
		 890 891 1 890 918 1 891 892 1 891 919 1 892 893 1 892 920 1 893 894 1 893 921 1 894 895 1
		 894 922 1 895 896 1 895 923 1 896 924 0 897 898 1 897 925 0 898 899 1 898 926 1 899 900 1
		 899 927 1 900 901 1 900 928 1 901 902 1 901 929 1 902 930 0 903 904 1 903 931 0 904 905 1
		 904 932 1 905 906 1 905 933 1 906 907 1 906 934 1 907 908 1 907 935 1 908 909 1 908 936 1
		 909 910 1 909 937 1 910 911 1 910 938 1 911 912 1 911 939 1 912 913 1 912 940 1 913 914 1
		 913 941 1 914 915 1 914 942 1 915 943 0 916 917 1 916 944 0 917 918 1 917 945 1 918 919 1
		 918 946 1 919 920 1 919 947 1 920 921 1 920 948 1 921 922 1 921 949 1 922 923 1 922 950 1
		 923 924 1 923 951 1 924 952 0 925 926 1 925 953 0 926 927 1 926 954 1 927 928 1 927 955 1
		 928 929 1 928 956 1 929 930 1 929 957 1 930 958 0 931 932 1 931 959 0 932 933 1 932 960 1
		 933 934 1 933 961 1 934 935 1 934 962 1 935 936 1 935 963 1 936 937 1 936 964 1 937 938 1
		 937 965 1 938 939 1 938 966 1 939 940 1 939 967 1 940 941 1 940 968 1 941 942 1 941 969 1
		 942 943 1 942 970 1 943 971 0 944 945 1 944 972 0 945 946 1 945 973 1 946 947 1 946 974 1
		 947 948 1 947 975 1 948 949 1 948 976 1 949 950 1 949 977 1 950 951 1;
	setAttr ".ed[1826:1991]" 950 978 1 951 952 1 951 979 1 952 980 0 953 954 1 953 981 0
		 954 955 1 954 982 1 955 956 1 955 983 1 956 957 1 956 984 1 957 958 1 957 985 1 958 986 0
		 959 960 1 959 1004 0 960 961 1 960 1005 1 961 962 1 961 1006 1 962 963 1 962 1007 1
		 963 964 1 963 1008 1 964 965 1 964 1009 1 965 966 1 965 1010 1 966 967 1 966 1011 1
		 967 968 1 967 1012 1 968 969 1 968 1013 1 969 970 1 969 1014 1 970 971 1 970 1015 1
		 971 1016 0 972 973 1 972 1017 0 973 974 1 973 1018 1 974 975 1 974 1019 1 975 976 1
		 975 1020 1 976 977 1 976 1021 1 977 978 1 977 1022 1 978 979 1 978 1023 1 979 980 1
		 979 1024 1 980 1025 0 981 982 1 981 1026 0 982 983 1 982 1027 1 983 984 1 983 1028 1
		 984 985 1 984 1029 1 985 986 1 985 1030 1 986 987 0 986 1031 1 987 988 0 987 1032 1
		 988 989 0 988 1033 1 989 990 0 989 1034 1 990 991 0 990 1035 1 991 992 0 991 1036 1
		 992 993 0 992 1037 1 993 994 0 993 1038 1 994 995 0 994 1039 1 995 996 0 995 1040 1
		 996 997 0 996 1041 1 997 998 0 997 1042 1 998 999 0 998 1043 1 999 1000 0 999 1044 1
		 1000 1001 0 1000 1045 1 1001 1002 0 1001 1046 1 1002 1003 0 1002 1047 1 1003 1004 0
		 1003 1048 1 1004 1005 1 1004 1049 1 1005 1006 1 1005 1050 1 1006 1007 1 1006 1051 1
		 1007 1008 1 1007 1052 1 1008 1009 1 1008 1053 1 1009 1010 1 1009 1054 1 1010 1011 1
		 1010 1055 1 1011 1012 1 1011 1056 1 1012 1013 1 1012 1057 1 1013 1014 1 1013 1058 1
		 1014 1015 1 1014 1059 1 1015 1016 1 1015 1060 1 1016 1061 0 1017 1018 1 1017 1062 0
		 1018 1019 1 1018 1063 1 1019 1020 1 1019 1064 1 1020 1021 1 1020 1065 1 1021 1022 1
		 1021 1066 1 1022 1023 1 1022 1067 1 1023 1024 1 1023 1068 1 1024 1025 1 1024 1069 1
		 1025 1070 0 1026 1027 1 1026 1071 0 1027 1028 1 1027 1072 1 1028 1029 1 1028 1073 1
		 1029 1030 1 1029 1074 1 1030 1031 1 1030 1075 1 1031 1032 1 1031 1076 1 1032 1033 1
		 1032 1077 1 1033 1034 1 1033 1078 1 1034 1035 1 1034 1079 1 1035 1036 1 1035 1080 1
		 1036 1037 1;
	setAttr ".ed[1992:2157]" 1036 1081 1 1037 1038 1 1037 1082 1 1038 1039 1 1038 1083 1
		 1039 1040 1 1039 1084 1 1040 1041 1 1040 1085 1 1041 1042 1 1041 1086 1 1042 1043 1
		 1042 1087 1 1043 1044 1 1043 1088 1 1044 1045 1 1044 1089 1 1045 1046 1 1045 1090 1
		 1046 1047 1 1046 1091 1 1047 1048 1 1047 1092 1 1048 1049 1 1048 1093 1 1049 1050 1
		 1049 1094 1 1050 1051 1 1050 1095 1 1051 1052 1 1051 1096 1 1052 1053 1 1052 1097 1
		 1053 1054 1 1053 1098 1 1054 1055 1 1054 1099 1 1055 1056 1 1055 1100 1 1056 1057 1
		 1056 1101 1 1057 1058 1 1057 1102 1 1058 1059 1 1058 1103 1 1059 1060 1 1059 1104 1
		 1060 1061 1 1060 1105 1 1061 1106 0 1062 1063 1 1062 1107 0 1063 1064 1 1063 1108 1
		 1064 1065 1 1064 1109 1 1065 1066 1 1065 1110 1 1066 1067 1 1066 1111 1 1067 1068 1
		 1067 1112 1 1068 1069 1 1068 1113 1 1069 1070 1 1069 1114 1 1070 1115 0 1071 1072 1
		 1071 1116 0 1072 1073 1 1072 1117 1 1073 1074 1 1073 1118 1 1074 1075 1 1074 1119 1
		 1075 1076 1 1075 1120 1 1076 1077 1 1076 1121 1 1077 1078 1 1077 1122 1 1078 1079 1
		 1078 1123 1 1079 1080 1 1079 1124 1 1080 1081 1 1080 1125 1 1081 1082 1 1081 1126 1
		 1082 1083 1 1082 1127 1 1083 1084 1 1083 1128 1 1084 1085 1 1084 1129 1 1085 1086 1
		 1085 1130 1 1086 1087 1 1086 1131 1 1087 1088 1 1087 1132 1 1088 1089 1 1088 1133 1
		 1089 1090 1 1089 1134 1 1090 1091 1 1090 1135 1 1091 1092 1 1091 1136 1 1092 1093 1
		 1092 1137 1 1093 1094 1 1093 1138 1 1094 1095 1 1094 1139 1 1095 1096 1 1095 1140 1
		 1096 1097 1 1096 1141 1 1097 1098 1 1097 1142 1 1098 1099 1 1098 1143 1 1099 1100 1
		 1099 1144 1 1100 1101 1 1100 1145 1 1101 1102 1 1101 1146 1 1102 1103 1 1102 1147 1
		 1103 1104 1 1103 1148 1 1104 1105 1 1104 1149 1 1105 1106 1 1105 1150 1 1106 1151 0
		 1107 1108 1 1107 1152 0 1108 1109 1 1108 1153 1 1109 1110 1 1109 1154 1 1110 1111 1
		 1110 1155 1 1111 1112 1 1111 1156 1 1112 1113 1 1112 1157 1 1113 1114 1 1113 1158 1
		 1114 1115 1 1114 1159 1 1115 1160 0 1116 1117 1 1116 1161 0 1117 1118 1 1117 1162 1
		 1118 1119 1 1118 1163 1 1119 1120 1 1119 1164 1 1120 1121 1 1120 1165 1 1121 1122 1;
	setAttr ".ed[2158:2323]" 1121 1166 1 1122 1123 1 1122 1167 1 1123 1124 1 1123 1168 1
		 1124 1125 1 1124 1169 1 1125 1126 1 1125 1170 1 1126 1127 1 1126 1171 1 1127 1128 1
		 1127 1172 1 1128 1129 1 1128 1173 1 1129 1130 1 1129 1174 1 1130 1131 1 1130 1175 1
		 1131 1132 1 1131 1176 1 1132 1133 1 1132 1177 1 1133 1134 1 1133 1178 1 1134 1135 1
		 1134 1179 1 1135 1136 1 1135 1180 1 1136 1137 1 1136 1181 1 1137 1138 1 1137 1182 1
		 1138 1139 1 1138 1183 1 1139 1140 1 1139 1184 1 1140 1141 1 1140 1185 1 1141 1142 1
		 1141 1186 1 1142 1143 1 1142 1187 1 1143 1144 1 1143 1188 1 1144 1145 1 1144 1189 1
		 1145 1146 1 1145 1190 1 1146 1147 1 1146 1191 1 1147 1148 1 1147 1192 1 1148 1149 1
		 1148 1193 1 1149 1150 1 1149 1194 1 1150 1151 1 1150 1195 1 1151 1196 0 1152 1153 1
		 1152 1197 0 1153 1154 1 1153 1198 1 1154 1155 1 1154 1199 1 1155 1156 1 1155 1200 1
		 1156 1157 1 1156 1201 1 1157 1158 1 1157 1202 1 1158 1159 1 1158 1203 1 1159 1160 1
		 1159 1204 1 1160 1205 0 1161 1162 1 1161 1206 0 1162 1163 1 1162 1207 1 1163 1164 1
		 1163 1208 1 1164 1165 1 1164 1209 1 1165 1166 1 1165 1210 1 1166 1167 1 1166 1211 1
		 1167 1168 1 1167 1212 1 1168 1169 1 1168 1213 1 1169 1170 1 1169 1214 1 1170 1171 1
		 1170 1215 1 1171 1172 1 1171 1216 1 1172 1173 1 1172 1217 1 1173 1174 1 1173 1218 1
		 1174 1175 1 1174 1219 1 1175 1176 1 1175 1220 1 1176 1177 1 1176 1221 1 1177 1178 1
		 1177 1222 1 1178 1179 1 1178 1223 1 1179 1180 1 1179 1224 1 1180 1181 1 1180 1225 1
		 1181 1182 1 1181 1226 1 1182 1183 1 1182 1227 1 1183 1184 1 1183 1228 1 1184 1185 1
		 1184 1229 1 1185 1186 1 1185 1230 1 1186 1187 1 1186 1231 1 1187 1188 1 1187 1232 1
		 1188 1189 1 1188 1233 1 1189 1190 1 1189 1234 1 1190 1191 1 1190 1235 1 1191 1192 1
		 1191 1236 1 1192 1193 1 1192 1237 1 1193 1194 1 1193 1238 1 1194 1195 1 1194 1239 1
		 1195 1196 1 1195 1240 1 1196 1241 0 1197 1198 1 1197 1242 0 1198 1199 1 1198 1243 1
		 1199 1200 1 1199 1244 1 1200 1201 1 1200 1245 1 1201 1202 1 1201 1246 1 1202 1203 1
		 1202 1247 1 1203 1204 1 1203 1248 1 1204 1205 1 1204 1249 1 1205 1250 0 1206 1207 1;
	setAttr ".ed[2324:2489]" 1206 1251 0 1207 1208 1 1207 1252 1 1208 1209 1 1208 1253 1
		 1209 1210 1 1209 1254 1 1210 1211 1 1210 1255 1 1211 1212 1 1211 1256 1 1212 1213 1
		 1212 1257 1 1213 1214 1 1213 1258 1 1214 1215 1 1214 1259 1 1215 1216 1 1215 1260 1
		 1216 1217 1 1216 1261 1 1217 1218 1 1217 1262 1 1218 1219 1 1218 1263 1 1219 1220 1
		 1219 1264 1 1220 1221 1 1220 1265 1 1221 1222 1 1221 1266 1 1222 1223 1 1222 1267 1
		 1223 1224 1 1223 1268 1 1224 1225 1 1224 1269 1 1225 1226 1 1225 1270 1 1226 1227 1
		 1226 1271 1 1227 1228 1 1227 1272 1 1228 1229 1 1228 1273 1 1229 1230 1 1229 1274 1
		 1230 1231 1 1230 1275 1 1231 1232 1 1231 1276 1 1232 1233 1 1232 1277 1 1233 1234 1
		 1233 1278 1 1234 1235 1 1234 1279 1 1235 1236 1 1235 1280 1 1236 1237 1 1236 1281 1
		 1237 1238 1 1237 1282 1 1238 1239 1 1238 1283 1 1239 1240 1 1239 1284 1 1240 1241 1
		 1240 1285 1 1241 1286 0 1242 1243 1 1242 1287 0 1243 1244 1 1243 1288 1 1244 1245 1
		 1244 1289 1 1245 1246 1 1245 1290 1 1246 1247 1 1246 1291 1 1247 1248 1 1247 1292 1
		 1248 1249 1 1248 1293 1 1249 1250 1 1249 1294 1 1250 1295 0 1251 1252 1 1251 1296 0
		 1252 1253 1 1252 1297 1 1253 1254 1 1253 1298 1 1254 1255 1 1254 1299 1 1255 1256 1
		 1255 1300 1 1256 1257 1 1256 1301 1 1257 1258 1 1257 1302 1 1258 1259 1 1258 1303 1
		 1259 1260 1 1259 1304 1 1260 1261 1 1260 1305 1 1261 1262 1 1261 1306 1 1262 1263 1
		 1262 1307 1 1263 1264 1 1263 1308 1 1264 1265 1 1264 1309 1 1265 1266 1 1265 1310 1
		 1266 1267 1 1266 1311 1 1267 1268 1 1267 1312 1 1268 1269 1 1268 1313 1 1269 1270 1
		 1269 1314 1 1270 1271 1 1270 1315 1 1271 1272 1 1271 1316 1 1272 1273 1 1272 1317 1
		 1273 1274 1 1273 1318 1 1274 1275 1 1274 1319 1 1275 1276 1 1275 1320 1 1276 1277 1
		 1276 1321 1 1277 1278 1 1277 1322 1 1278 1279 1 1278 1323 1 1279 1280 1 1279 1324 1
		 1280 1281 1 1280 1325 1 1281 1282 1 1281 1326 1 1282 1283 1 1282 1327 1 1283 1284 1
		 1283 1328 1 1284 1285 1 1284 1329 1 1285 1286 1 1285 1330 1 1286 1331 0 1287 1288 1
		 1287 1332 0 1288 1289 1 1288 1333 1 1289 1290 1 1289 1334 1 1290 1291 1 1290 1335 1;
	setAttr ".ed[2490:2655]" 1291 1292 1 1291 1336 1 1292 1293 1 1292 1337 1 1293 1294 1
		 1293 1338 1 1294 1295 1 1294 1339 1 1295 1340 0 1296 1297 1 1296 1341 0 1297 1298 1
		 1297 1342 1 1298 1299 1 1298 1343 1 1299 1300 1 1299 1344 1 1300 1301 1 1300 1345 1
		 1301 1302 1 1301 1346 1 1302 1303 1 1302 1347 1 1303 1304 1 1303 1348 1 1304 1305 1
		 1304 1349 1 1305 1306 1 1305 1350 1 1306 1307 1 1306 1351 1 1307 1308 0 1307 1352 0
		 1308 1309 0 1309 1310 0 1310 1311 0 1311 1312 0 1312 1313 0 1313 1314 0 1314 1315 0
		 1315 1316 0 1316 1317 0 1317 1318 0 1318 1319 0 1319 1320 0 1320 1321 0 1321 1322 0
		 1322 1323 0 1323 1324 0 1324 1325 1 1324 1353 0 1325 1326 1 1325 1354 1 1326 1327 1
		 1326 1355 1 1327 1328 1 1327 1356 1 1328 1329 1 1328 1357 1 1329 1330 1 1329 1358 1
		 1330 1331 1 1330 1359 1 1331 1360 0 1332 1333 1 1332 1361 0 1333 1334 1 1333 1362 1
		 1334 1335 1 1334 1363 1 1335 1336 1 1335 1364 1 1336 1337 1 1336 1365 1 1337 1338 1
		 1337 1366 1 1338 1339 1 1338 1367 1 1339 1340 1 1339 1368 1 1340 1369 0 1341 1342 1
		 1341 1370 0 1342 1343 1 1342 1371 1 1343 1344 1 1343 1372 1 1344 1345 1 1344 1373 1
		 1345 1346 1 1345 1374 1 1346 1347 1 1346 1375 1 1347 1348 1 1347 1376 1 1348 1349 1
		 1348 1377 1 1349 1350 1 1349 1378 1 1350 1351 1 1350 1379 1 1351 1352 1 1351 1380 1
		 1352 1381 0 1353 1354 1 1353 1382 0 1354 1355 1 1354 1383 1 1355 1356 1 1355 1384 1
		 1356 1357 1 1356 1385 1 1357 1358 1 1357 1386 1 1358 1359 1 1358 1387 1 1359 1360 1
		 1359 1388 1 1360 1389 0 1361 1362 1 1361 1390 0 1362 1363 1 1362 1391 1 1363 1364 1
		 1363 1392 1 1364 1365 1 1364 1393 1 1365 1366 1 1365 1394 1 1366 1367 1 1366 1395 1
		 1367 1368 1 1367 1396 1 1368 1369 1 1368 1397 1 1369 1398 0 1370 1371 1 1370 1399 0
		 1371 1372 1 1371 1400 1 1372 1373 1 1372 1401 1 1373 1374 1 1373 1402 1 1374 1375 1
		 1374 1403 1 1375 1376 1 1375 1404 1 1376 1377 1 1376 1405 1 1377 1378 1 1377 1406 1
		 1378 1379 1 1378 1407 1 1379 1380 1 1379 1408 1 1380 1381 1 1380 1409 1 1381 1410 0
		 1382 1383 1 1382 1411 0 1383 1384 1 1383 1412 1 1384 1385 1 1384 1413 1 1385 1386 1;
	setAttr ".ed[2656:2821]" 1385 1414 1 1386 1387 1 1386 1415 1 1387 1388 1 1387 1416 1
		 1388 1389 1 1388 1417 1 1389 1418 0 1390 1391 1 1390 1419 0 1391 1392 1 1391 1420 1
		 1392 1393 1 1392 1421 1 1393 1394 1 1393 1422 1 1394 1395 1 1394 1423 1 1395 1396 1
		 1395 1424 1 1396 1397 1 1396 1425 1 1397 1398 1 1397 1426 1 1398 1427 0 1399 1400 1
		 1399 1428 0 1400 1401 1 1400 1429 1 1401 1402 1 1401 1430 1 1402 1403 1 1402 1431 1
		 1403 1404 1 1403 1432 1 1404 1405 1 1404 1433 1 1405 1406 1 1405 1434 1 1406 1407 1
		 1406 1435 1 1407 1408 1 1407 1436 1 1408 1409 1 1408 1437 1 1409 1410 1 1409 1438 1
		 1410 1439 0 1411 1412 1 1411 1440 0 1412 1413 1 1412 1441 1 1413 1414 1 1413 1442 1
		 1414 1415 1 1414 1443 1 1415 1416 1 1415 1444 1 1416 1417 1 1416 1445 1 1417 1418 1
		 1417 1446 1 1418 1447 0 1419 1420 1 1419 1448 0 1420 1421 1 1420 1449 1 1421 1422 1
		 1421 1450 1 1422 1423 1 1422 1451 1 1423 1424 1 1423 1452 1 1424 1425 1 1424 1453 1
		 1425 1426 1 1425 1454 1 1426 1427 1 1426 1455 1 1427 1456 0 1428 1429 1 1428 1457 0
		 1429 1430 1 1429 1458 1 1430 1431 1 1430 1459 1 1431 1432 1 1431 1460 1 1432 1433 1
		 1432 1461 1 1433 1434 1 1433 1462 1 1434 1435 1 1434 1463 1 1435 1436 1 1435 1464 1
		 1436 1437 1 1436 1465 1 1437 1438 1 1437 1466 1 1438 1439 1 1438 1467 1 1439 1468 0
		 1440 1441 1 1440 1469 0 1441 1442 1 1441 1470 1 1442 1443 1 1442 1471 1 1443 1444 1
		 1443 1472 1 1444 1445 1 1444 1473 1 1445 1446 1 1445 1474 1 1446 1447 1 1446 1475 1
		 1447 1476 0 1448 1449 1 1448 1477 0 1449 1450 1 1449 1478 1 1450 1451 1 1450 1479 1
		 1451 1452 1 1451 1480 1 1452 1453 1 1452 1481 1 1453 1454 1 1453 1482 1 1454 1455 1
		 1454 1483 1 1455 1456 1 1455 1484 1 1456 1485 0 1457 1458 1 1457 1486 0 1458 1459 1
		 1458 1487 1 1459 1460 1 1459 1488 1 1460 1461 1 1460 1489 1 1461 1462 1 1461 1490 1
		 1462 1463 1 1462 1491 1 1463 1464 1 1463 1492 1 1464 1465 1 1464 1493 1 1465 1466 1
		 1465 1494 1 1466 1467 1 1466 1495 1 1467 1468 1 1467 1496 1 1468 1497 0 1469 1470 1
		 1469 1498 0 1470 1471 1 1470 1499 1 1471 1472 1 1471 1500 1 1472 1473 1 1472 1501 1;
	setAttr ".ed[2822:2987]" 1473 1474 1 1473 1502 1 1474 1475 1 1474 1503 1 1475 1476 1
		 1475 1504 1 1476 1505 0 1477 1478 1 1477 1512 0 1478 1479 1 1478 1513 1 1479 1480 1
		 1479 1514 1 1480 1481 1 1480 1515 1 1481 1482 1 1481 1516 1 1482 1483 1 1482 1517 1
		 1483 1484 1 1483 1518 1 1484 1485 1 1484 1519 1 1485 1520 0 1486 1487 1 1486 1521 0
		 1487 1488 1 1487 1522 1 1488 1489 1 1488 1523 1 1489 1490 1 1489 1524 1 1490 1491 1
		 1490 1525 1 1491 1492 1 1491 1526 1 1492 1493 1 1492 1527 1 1493 1494 1 1493 1528 1
		 1494 1495 1 1494 1529 1 1495 1496 1 1495 1530 1 1496 1497 1 1496 1531 1 1497 1532 0
		 1498 1499 1 1498 1549 0 1499 1500 1 1499 1550 1 1500 1501 1 1500 1551 1 1501 1502 1
		 1501 1552 1 1502 1503 1 1502 1553 1 1503 1504 1 1503 1554 1 1504 1505 1 1504 1555 1
		 1505 1506 0 1505 1556 1 1506 1507 0 1506 1557 1 1507 1508 0 1507 1558 1 1508 1509 0
		 1508 1559 1 1509 1510 0 1509 1560 1 1510 1511 0 1510 1561 1 1511 1512 0 1511 1562 1
		 1512 1513 1 1512 1563 1 1513 1514 1 1513 1564 1 1514 1515 1 1514 1565 1 1515 1516 1
		 1515 1566 1 1516 1517 1 1516 1567 1 1517 1518 1 1517 1568 1 1518 1519 1 1518 1569 1
		 1519 1520 1 1519 1570 1 1520 1571 0 1521 1522 1 1521 1572 0 1522 1523 1 1522 1573 1
		 1523 1524 1 1523 1574 1 1524 1525 1 1524 1575 1 1525 1526 1 1525 1576 1 1526 1527 1
		 1526 1577 1 1527 1528 1 1527 1578 1 1528 1529 1 1528 1579 1 1529 1530 1 1529 1580 1
		 1530 1531 1 1530 1581 1 1531 1532 1 1531 1582 1 1532 1533 0 1532 1583 1 1533 1534 0
		 1533 1584 1 1534 1535 0 1534 1585 1 1535 1536 0 1535 1586 1 1536 1537 0 1536 1587 1
		 1537 1538 0 1537 1588 1 1538 1539 0 1538 1589 1 1539 1540 0 1539 1590 1 1540 1541 0
		 1540 1591 1 1541 1542 0 1541 1592 1 1542 1543 0 1542 1593 1 1543 1544 0 1543 1594 1
		 1544 1545 0 1544 1595 1 1545 1546 0 1545 1596 1 1546 1547 0 1546 1597 1 1547 1548 0
		 1547 1598 1 1548 1549 0 1548 1599 1 1549 1550 1 1549 1600 1 1550 1551 1 1550 1601 1
		 1551 1552 1 1551 1602 1 1552 1553 1 1552 1603 1 1553 1554 1 1553 1604 1 1554 1555 1
		 1554 1605 1 1555 1556 1 1555 1606 1 1556 1557 1 1556 1607 1 1557 1558 1 1557 1608 1;
	setAttr ".ed[2988:3153]" 1558 1559 1 1558 1609 1 1559 1560 1 1559 1610 1 1560 1561 1
		 1560 1611 1 1561 1562 1 1561 1612 1 1562 1563 1 1562 1613 1 1563 1564 1 1563 1614 1
		 1564 1565 1 1564 1615 1 1565 1566 1 1565 1616 1 1566 1567 1 1566 1617 1 1567 1568 1
		 1567 1618 1 1568 1569 1 1568 1619 1 1569 1570 1 1569 1620 1 1570 1571 1 1570 1621 1
		 1571 1622 0 1572 1573 1 1572 1623 0 1573 1574 1 1573 1624 1 1574 1575 1 1574 1625 1
		 1575 1576 1 1575 1626 1 1576 1577 1 1576 1627 1 1577 1578 1 1577 1628 1 1578 1579 1
		 1578 1629 1 1579 1580 1 1579 1630 1 1580 1581 1 1580 1631 1 1581 1582 1 1581 1632 1
		 1582 1583 1 1582 1633 1 1583 1584 1 1583 1634 1 1584 1585 1 1584 1635 1 1585 1586 1
		 1585 1636 1 1586 1587 1 1586 1637 1 1587 1588 1 1587 1638 1 1588 1589 1 1588 1639 1
		 1589 1590 1 1589 1640 1 1590 1591 1 1590 1641 1 1591 1592 1 1591 1642 1 1592 1593 1
		 1592 1643 1 1593 1594 1 1593 1644 1 1594 1595 1 1594 1645 1 1595 1596 1 1595 1646 1
		 1596 1597 1 1596 1647 1 1597 1598 1 1597 1648 1 1598 1599 1 1598 1649 1 1599 1600 1
		 1599 1650 1 1600 1601 1 1600 1651 1 1601 1602 1 1601 1652 1 1602 1603 1 1602 1653 1
		 1603 1604 1 1603 1654 1 1604 1605 1 1604 1655 1 1605 1606 1 1605 1656 1 1606 1607 1
		 1606 1657 1 1607 1608 1 1607 1658 1 1608 1609 1 1608 1659 1 1609 1610 1 1609 1660 1
		 1610 1611 1 1610 1661 1 1611 1612 1 1611 1662 1 1612 1613 1 1612 1663 1 1613 1614 1
		 1613 1664 1 1614 1615 1 1614 1665 1 1615 1616 1 1615 1666 1 1616 1617 1 1616 1667 1
		 1617 1618 1 1617 1668 1 1618 1619 1 1618 1669 1 1619 1620 1 1619 1670 1 1620 1621 1
		 1620 1671 1 1621 1622 1 1621 1672 1 1622 1673 0 1623 1624 1 1623 1674 0 1624 1625 1
		 1624 1675 1 1625 1626 1 1625 1676 1 1626 1627 1 1626 1677 1 1627 1628 1 1627 1678 1
		 1628 1629 1 1628 1679 1 1629 1630 1 1629 1680 1 1630 1631 1 1630 1681 1 1631 1632 1
		 1631 1682 1 1632 1633 1 1632 1683 1 1633 1634 1 1633 1684 1 1634 1635 1 1634 1685 1
		 1635 1636 1 1635 1686 1 1636 1637 1 1636 1687 1 1637 1638 1 1637 1688 1 1638 1639 1
		 1638 1689 1 1639 1640 1 1639 1690 1 1640 1641 1 1640 1691 1 1641 1642 1 1641 1692 1;
	setAttr ".ed[3154:3319]" 1642 1643 1 1642 1693 1 1643 1644 1 1643 1694 1 1644 1645 1
		 1644 1695 1 1645 1646 1 1645 1696 1 1646 1647 1 1646 1697 1 1647 1648 1 1647 1698 1
		 1648 1649 1 1648 1699 1 1649 1650 1 1649 1700 1 1650 1651 1 1650 1701 1 1651 1652 1
		 1651 1702 1 1652 1653 1 1652 1703 1 1653 1654 1 1653 1704 1 1654 1655 1 1654 1705 1
		 1655 1656 1 1655 1706 1 1656 1657 1 1656 1707 1 1657 1658 1 1657 1708 1 1658 1659 1
		 1658 1709 1 1659 1660 1 1659 1710 1 1660 1661 1 1660 1711 1 1661 1662 1 1661 1712 1
		 1662 1663 1 1662 1713 1 1663 1664 1 1663 1714 1 1664 1665 1 1664 1715 1 1665 1666 1
		 1665 1716 1 1666 1667 1 1666 1717 1 1667 1668 1 1667 1718 1 1668 1669 1 1668 1719 1
		 1669 1670 1 1669 1720 1 1670 1671 1 1670 1721 1 1671 1672 1 1671 1722 1 1672 1673 1
		 1672 1723 1 1673 1724 0 1674 1675 1 1674 1725 0 1675 1676 1 1675 1726 1 1676 1677 1
		 1676 1727 1 1677 1678 1 1677 1728 1 1678 1679 1 1678 1729 1 1679 1680 1 1679 1730 1
		 1680 1681 1 1680 1731 1 1681 1682 1 1681 1732 1 1682 1683 1 1682 1733 1 1683 1684 1
		 1683 1734 1 1684 1685 1 1684 1735 1 1685 1686 1 1685 1736 1 1686 1687 1 1686 1737 1
		 1687 1688 1 1687 1738 1 1688 1689 1 1688 1739 1 1689 1690 1 1689 1740 1 1690 1691 1
		 1690 1741 1 1691 1692 1 1691 1742 1 1692 1693 1 1692 1743 1 1693 1694 1 1693 1744 1
		 1694 1695 1 1694 1745 1 1695 1696 1 1695 1746 1 1696 1697 1 1696 1747 1 1697 1698 1
		 1697 1748 1 1698 1699 1 1698 1749 1 1699 1700 1 1699 1750 1 1700 1701 1 1700 1751 1
		 1701 1702 1 1701 1752 1 1702 1703 1 1702 1753 1 1703 1704 1 1703 1754 1 1704 1705 1
		 1704 1755 1 1705 1706 1 1705 1756 1 1706 1707 1 1706 1757 1 1707 1708 1 1707 1758 1
		 1708 1709 1 1708 1759 1 1709 1710 1 1709 1760 1 1710 1711 1 1710 1761 1 1711 1712 1
		 1711 1762 1 1712 1713 1 1712 1763 1 1713 1714 1 1713 1764 1 1714 1715 1 1714 1765 1
		 1715 1716 1 1715 1766 1 1716 1717 1 1716 1767 1 1717 1718 1 1717 1768 1 1718 1719 1
		 1718 1769 1 1719 1720 1 1719 1770 1 1720 1721 1 1720 1771 1 1721 1722 1 1721 1772 1
		 1722 1723 1 1722 1773 1 1723 1724 1 1723 1774 1 1724 1775 0 1725 1726 1 1725 1776 0;
	setAttr ".ed[3320:3485]" 1726 1727 1 1726 1777 1 1727 1728 1 1727 1778 1 1728 1729 0
		 1728 1779 0 1729 1730 0 1730 1731 0 1731 1732 0 1732 1733 0 1733 1734 0 1734 1735 0
		 1735 1736 0 1736 1737 0 1737 1738 0 1738 1739 0 1739 1740 0 1740 1741 0 1741 1742 0
		 1742 1743 0 1743 1744 0 1744 1745 0 1745 1746 0 1746 1747 0 1747 1748 0 1748 1749 1
		 1748 1780 0 1749 1750 1 1749 1781 1 1750 1751 1 1750 1782 1 1751 1752 1 1751 1783 1
		 1752 1753 1 1752 1784 1 1753 1754 1 1753 1785 1 1754 1755 1 1754 1786 1 1755 1756 1
		 1755 1787 1 1756 1757 1 1756 1788 1 1757 1758 1 1757 1789 1 1758 1759 1 1758 1790 1
		 1759 1760 1 1759 1791 1 1760 1761 1 1760 1792 1 1761 1762 1 1761 1793 1 1762 1763 1
		 1762 1794 1 1763 1764 1 1763 1795 1 1764 1765 1 1764 1796 1 1765 1766 1 1765 1797 1
		 1766 1767 1 1766 1798 1 1767 1768 1 1767 1799 1 1768 1769 1 1768 1800 1 1769 1770 1
		 1769 1801 1 1770 1771 1 1770 1802 1 1771 1772 1 1771 1803 1 1772 1773 1 1772 1804 1
		 1773 1774 1 1773 1805 1 1774 1775 1 1774 1806 1 1775 1807 0 1776 1777 1 1776 1808 0
		 1777 1778 1 1777 1809 1 1778 1779 1 1778 1810 1 1779 1811 0 1780 1781 1 1780 1812 0
		 1781 1782 1 1781 1813 1 1782 1783 1 1782 1814 1 1783 1784 1 1783 1815 1 1784 1785 1
		 1784 1816 1 1785 1786 1 1785 1817 1 1786 1787 1 1786 1818 1 1787 1788 1 1787 1819 1
		 1788 1789 1 1788 1820 1 1789 1790 1 1789 1821 1 1790 1791 1 1790 1822 1 1791 1792 1
		 1791 1823 1 1792 1793 1 1792 1824 1 1793 1794 1 1793 1825 1 1794 1795 1 1794 1826 1
		 1795 1796 1 1795 1827 1 1796 1797 1 1796 1828 1 1797 1798 1 1797 1829 1 1798 1799 1
		 1798 1830 1 1799 1800 1 1799 1831 1 1800 1801 1 1800 1832 1 1801 1802 1 1801 1833 1
		 1802 1803 1 1802 1834 1 1803 1804 1 1803 1835 1 1804 1805 1 1804 1836 1 1805 1806 1
		 1805 1837 1 1806 1807 1 1806 1838 1 1807 1839 0 1808 1809 1 1808 1840 0 1809 1810 1
		 1809 1841 1 1810 1811 1 1810 1842 1 1811 1843 0 1812 1813 1 1812 1844 0 1813 1814 1
		 1813 1845 1 1814 1815 1 1814 1846 1 1815 1816 1 1815 1847 1 1816 1817 1 1816 1848 1
		 1817 1818 1 1817 1849 1 1818 1819 1 1818 1850 1 1819 1820 1 1819 1851 1 1820 1821 0;
	setAttr ".ed[3486:3651]" 1820 1852 0 1821 1822 0 1822 1823 0 1823 1824 0 1824 1825 0
		 1825 1826 0 1826 1827 0 1827 1828 0 1828 1829 0 1829 1830 0 1830 1831 0 1831 1832 0
		 1832 1833 0 1833 1834 0 1834 1835 0 1835 1836 1 1835 1853 0 1836 1837 1 1836 1854 1
		 1837 1838 1 1837 1855 1 1838 1839 1 1838 1856 1 1839 1857 0 1840 1841 1 1840 1858 0
		 1841 1842 1 1841 1859 1 1842 1843 1 1842 1860 1 1843 1861 0 1844 1845 1 1844 1862 0
		 1845 1846 1 1845 1863 1 1846 1847 1 1846 1864 1 1847 1848 1 1847 1865 1 1848 1849 1
		 1848 1866 1 1849 1850 1 1849 1867 1 1850 1851 1 1850 1868 1 1851 1852 1 1851 1869 1
		 1852 1870 0 1853 1854 1 1853 1871 0 1854 1855 1 1854 1872 1 1855 1856 1 1855 1873 1
		 1856 1857 1 1856 1874 1 1857 1875 0 1858 1859 1 1858 1876 0 1859 1860 1 1859 1877 1
		 1860 1861 1 1860 1878 1 1861 1879 0 1862 1863 1 1862 1880 0 1863 1864 1 1863 1881 1
		 1864 1865 1 1864 1882 1 1865 1866 1 1865 1883 1 1866 1867 1 1866 1884 1 1867 1868 1
		 1867 1885 1 1868 1869 1 1868 1886 1 1869 1870 1 1869 1887 1 1870 1888 0 1871 1872 1
		 1871 1903 0 1872 1873 1 1872 1904 1 1873 1874 1 1873 1905 1 1874 1875 1 1874 1906 1
		 1875 1907 0 1876 1877 1 1876 1908 0 1877 1878 1 1877 1909 1 1878 1879 1 1878 1910 1
		 1879 1911 0 1880 1881 1 1880 1931 0 1881 1882 1 1881 1932 1 1882 1883 1 1882 1933 1
		 1883 1884 1 1883 1934 1 1884 1885 1 1884 1935 1 1885 1886 1 1885 1936 1 1886 1887 1
		 1886 1937 1 1887 1888 1 1887 1938 1 1888 1889 0 1888 1939 1 1889 1890 0 1889 1940 1
		 1890 1891 0 1890 1941 1 1891 1892 0 1891 1942 1 1892 1893 0 1892 1943 1 1893 1894 0
		 1893 1944 1 1894 1895 0 1894 1945 1 1895 1896 0 1895 1946 1 1896 1897 0 1896 1947 1
		 1897 1898 0 1897 1948 1 1898 1899 0 1898 1949 1 1899 1900 0 1899 1950 1 1900 1901 0
		 1900 1951 1 1901 1902 0 1901 1952 1 1902 1903 0 1902 1953 1 1903 1904 1 1903 1954 1
		 1904 1905 1 1904 1955 1 1905 1906 1 1905 1956 1 1906 1907 1 1906 1957 1 1907 1958 0
		 1908 1909 1 1908 1959 0 1909 1910 1 1909 1960 1 1910 1911 1 1910 1961 1 1911 1912 0
		 1911 1962 1 1912 1913 0 1912 1963 1 1913 1914 0 1913 1964 1 1914 1915 0 1914 1965 1;
	setAttr ".ed[3652:3817]" 1915 1916 0 1915 1966 1 1916 1917 0 1916 1967 1 1917 1918 0
		 1917 1968 1 1918 1919 0 1918 1969 1 1919 1920 0 1919 1970 1 1920 1921 0 1920 1971 1
		 1921 1922 0 1921 1972 1 1922 1923 0 1922 1973 1 1923 1924 0 1923 1974 1 1924 1925 0
		 1924 1975 1 1925 1926 0 1925 1976 1 1926 1927 0 1926 1977 1 1927 1928 0 1927 1978 1
		 1928 1929 0 1928 1979 1 1929 1930 0 1929 1980 1 1930 1931 0 1930 1981 1 1931 1932 1
		 1931 1982 1 1932 1933 1 1932 1983 1 1933 1934 1 1933 1984 1 1934 1935 1 1934 1985 1
		 1935 1936 1 1935 1986 1 1936 1937 1 1936 1987 1 1937 1938 1 1937 1988 1 1938 1939 1
		 1938 1989 1 1939 1940 1 1939 1990 1 1940 1941 1 1940 1991 1 1941 1942 1 1941 1992 1
		 1942 1943 1 1942 1993 1 1943 1944 1 1943 1994 1 1944 1945 1 1944 1995 1 1945 1946 1
		 1945 1996 1 1946 1947 1 1946 1997 1 1947 1948 1 1947 1998 1 1948 1949 1 1948 1999 1
		 1949 1950 1 1949 2000 1 1950 1951 1 1950 2001 1 1951 1952 1 1951 2002 1 1952 1953 1
		 1952 2003 1 1953 1954 1 1953 2004 1 1954 1955 1 1954 2005 1 1955 1956 1 1955 2006 1
		 1956 1957 1 1956 2007 1 1957 1958 1 1957 2008 1 1958 2009 0 1959 1960 1 1959 2010 0
		 1960 1961 1 1960 2011 1 1961 1962 1 1961 2012 1 1962 1963 1 1962 2013 1 1963 1964 1
		 1963 2014 1 1964 1965 1 1964 2015 1 1965 1966 1 1965 2016 1 1966 1967 1 1966 2017 1
		 1967 1968 1 1967 2018 1 1968 1969 1 1968 2019 1 1969 1970 1 1969 2020 1 1970 1971 1
		 1970 2021 1 1971 1972 1 1971 2022 1 1972 1973 1 1972 2023 1 1973 1974 1 1973 2024 1
		 1974 1975 1 1974 2025 1 1975 1976 1 1975 2026 1 1976 1977 1 1976 2027 1 1977 1978 1
		 1977 2028 1 1978 1979 1 1978 2029 1 1979 1980 1 1979 2030 1 1980 1981 1 1980 2031 1
		 1981 1982 1 1981 2032 1 1982 1983 1 1982 2033 1 1983 1984 1 1983 2034 1 1984 1985 1
		 1984 2035 1 1985 1986 1 1985 2036 1 1986 1987 1 1986 2037 1 1987 1988 1 1987 2038 1
		 1988 1989 1 1988 2039 1 1989 1990 1 1989 2040 1 1990 1991 1 1990 2041 1 1991 1992 1
		 1991 2042 1 1992 1993 1 1992 2043 1 1993 1994 1 1993 2044 1 1994 1995 1 1994 2045 1
		 1995 1996 1 1995 2046 1 1996 1997 1 1996 2047 1 1997 1998 1 1997 2048 1 1998 1999 1;
	setAttr ".ed[3818:3983]" 1998 2049 1 1999 2000 1 1999 2050 1 2000 2001 1 2000 2051 1
		 2001 2002 1 2001 2052 1 2002 2003 1 2002 2053 1 2003 2004 1 2003 2054 1 2004 2005 1
		 2004 2055 1 2005 2006 1 2005 2056 1 2006 2007 1 2006 2057 1 2007 2008 1 2007 2058 1
		 2008 2009 1 2008 2059 1 2009 2060 0 2010 2011 1 2010 2061 0 2011 2012 1 2011 2062 1
		 2012 2013 1 2012 2063 1 2013 2014 1 2013 2064 1 2014 2015 1 2014 2065 1 2015 2016 1
		 2015 2066 1 2016 2017 1 2016 2067 1 2017 2018 1 2017 2068 1 2018 2019 1 2018 2069 1
		 2019 2020 1 2019 2070 1 2020 2021 1 2020 2071 1 2021 2022 1 2021 2072 1 2022 2023 1
		 2022 2073 1 2023 2024 1 2023 2074 1 2024 2025 1 2024 2075 1 2025 2026 1 2025 2076 1
		 2026 2027 1 2026 2077 1 2027 2028 1 2027 2078 1 2028 2029 1 2028 2079 1 2029 2030 1
		 2029 2080 1 2030 2031 1 2030 2081 1 2031 2032 1 2031 2082 1 2032 2033 1 2032 2083 1
		 2033 2034 1 2033 2084 1 2034 2035 1 2034 2085 1 2035 2036 1 2035 2086 1 2036 2037 1
		 2036 2087 1 2037 2038 1 2037 2088 1 2038 2039 1 2038 2089 1 2039 2040 1 2039 2090 1
		 2040 2041 1 2040 2091 1 2041 2042 1 2041 2092 1 2042 2043 1 2042 2093 1 2043 2044 1
		 2043 2094 1 2044 2045 1 2044 2095 1 2045 2046 1 2045 2096 1 2046 2047 1 2046 2097 1
		 2047 2048 1 2047 2098 1 2048 2049 1 2048 2099 1 2049 2050 1 2049 2100 1 2050 2051 1
		 2050 2101 1 2051 2052 1 2051 2102 1 2052 2053 1 2052 2103 1 2053 2054 1 2053 2104 1
		 2054 2055 1 2054 2105 1 2055 2056 1 2055 2106 1 2056 2057 1 2056 2107 1 2057 2058 1
		 2057 2108 1 2058 2059 1 2058 2109 1 2059 2060 1 2059 2110 1 2060 2111 0 2061 2062 0
		 2062 2063 0 2063 2064 0 2064 2065 0 2065 2066 0 2066 2067 0 2067 2068 0 2068 2069 0
		 2069 2070 0 2070 2071 0 2071 2072 0 2072 2073 0 2073 2074 0 2074 2075 0 2075 2076 0
		 2076 2077 0 2077 2078 0 2078 2079 0 2079 2080 0 2080 2081 0 2081 2082 0 2082 2083 0
		 2083 2084 0 2084 2085 0 2085 2086 0 2086 2087 0 2087 2088 0 2088 2089 0 2089 2090 0
		 2090 2091 0 2091 2092 0 2092 2093 0 2093 2094 0 2094 2095 0 2095 2096 0 2096 2097 0
		 2097 2098 0 2098 2099 0 2099 2100 0 2100 2101 0 2101 2102 0 2102 2103 0 2103 2104 0;
	setAttr ".ed[3984:3990]" 2104 2105 0 2105 2106 0 2106 2107 0 2107 2108 0 2108 2109 0
		 2109 2110 0 2110 2111 0;
	setAttr -s 1874 -ch 7496 ".fc";
	setAttr ".fc[0:499]" -type "polyFaces" 
		f 4 0 3 -102 -2
		mu 0 4 0 1 52 51
		f 4 2 5 -104 -4
		mu 0 4 1 2 53 52
		f 4 4 7 -106 -6
		mu 0 4 2 3 54 53
		f 4 6 9 -108 -8
		mu 0 4 3 4 55 54
		f 4 8 11 -110 -10
		mu 0 4 4 5 56 55
		f 4 10 13 -112 -12
		mu 0 4 5 6 57 56
		f 4 12 15 -114 -14
		mu 0 4 6 7 58 57
		f 4 14 17 -116 -16
		mu 0 4 7 8 59 58
		f 4 16 19 -118 -18
		mu 0 4 8 9 60 59
		f 4 18 21 -120 -20
		mu 0 4 9 10 61 60
		f 4 20 23 -122 -22
		mu 0 4 10 11 62 61
		f 4 22 25 -124 -24
		mu 0 4 11 12 63 62
		f 4 24 27 -126 -26
		mu 0 4 12 13 64 63
		f 4 26 29 -128 -28
		mu 0 4 13 14 65 64
		f 4 28 31 -130 -30
		mu 0 4 14 15 66 65
		f 4 30 33 -132 -32
		mu 0 4 15 16 67 66
		f 4 32 35 -134 -34
		mu 0 4 16 17 68 67
		f 4 34 37 -136 -36
		mu 0 4 17 18 69 68
		f 4 36 39 -138 -38
		mu 0 4 18 19 70 69
		f 4 38 41 -140 -40
		mu 0 4 19 20 71 70
		f 4 40 43 -142 -42
		mu 0 4 20 21 72 71
		f 4 42 45 -144 -44
		mu 0 4 21 22 73 72
		f 4 44 47 -146 -46
		mu 0 4 22 23 74 73
		f 4 46 49 -148 -48
		mu 0 4 23 24 75 74
		f 4 48 51 -150 -50
		mu 0 4 24 25 76 75
		f 4 50 53 -152 -52
		mu 0 4 25 26 77 76
		f 4 52 55 -154 -54
		mu 0 4 26 27 78 77
		f 4 54 57 -156 -56
		mu 0 4 27 28 79 78
		f 4 56 59 -158 -58
		mu 0 4 28 29 80 79
		f 4 58 61 -160 -60
		mu 0 4 29 30 81 80
		f 4 60 63 -162 -62
		mu 0 4 30 31 82 81
		f 4 62 65 -164 -64
		mu 0 4 31 32 83 82
		f 4 64 67 -166 -66
		mu 0 4 32 33 84 83
		f 4 66 69 -168 -68
		mu 0 4 33 34 85 84
		f 4 68 71 -170 -70
		mu 0 4 34 35 86 85
		f 4 70 73 -172 -72
		mu 0 4 35 36 87 86
		f 4 72 75 -174 -74
		mu 0 4 36 37 88 87
		f 4 74 77 -176 -76
		mu 0 4 37 38 89 88
		f 4 76 79 -178 -78
		mu 0 4 38 39 90 89
		f 4 78 81 -180 -80
		mu 0 4 39 40 91 90
		f 4 80 83 -182 -82
		mu 0 4 40 41 92 91
		f 4 82 85 -184 -84
		mu 0 4 41 42 93 92
		f 4 84 87 -186 -86
		mu 0 4 42 43 94 93
		f 4 86 89 -188 -88
		mu 0 4 43 44 95 94
		f 4 88 91 -190 -90
		mu 0 4 44 45 96 95
		f 4 90 93 -192 -92
		mu 0 4 45 46 97 96
		f 4 92 95 -194 -94
		mu 0 4 46 47 98 97
		f 4 94 97 -196 -96
		mu 0 4 47 48 99 98
		f 4 96 99 -198 -98
		mu 0 4 48 49 100 99
		f 4 98 100 -200 -100
		mu 0 4 49 50 101 100
		f 4 101 104 -203 -103
		mu 0 4 51 52 103 102
		f 4 103 106 -205 -105
		mu 0 4 52 53 104 103
		f 4 105 108 -207 -107
		mu 0 4 53 54 105 104
		f 4 107 110 -209 -109
		mu 0 4 54 55 106 105
		f 4 109 112 -211 -111
		mu 0 4 55 56 107 106
		f 4 111 114 -213 -113
		mu 0 4 56 57 108 107
		f 4 113 116 -215 -115
		mu 0 4 57 58 109 108
		f 4 115 118 -217 -117
		mu 0 4 58 59 110 109
		f 4 117 120 -219 -119
		mu 0 4 59 60 111 110
		f 4 119 122 -221 -121
		mu 0 4 60 61 112 111
		f 4 121 124 -223 -123
		mu 0 4 61 62 113 112
		f 4 123 126 -225 -125
		mu 0 4 62 63 114 113
		f 4 125 128 -227 -127
		mu 0 4 63 64 115 114
		f 4 127 130 -229 -129
		mu 0 4 64 65 116 115
		f 4 129 132 -231 -131
		mu 0 4 65 66 117 116
		f 4 131 134 -233 -133
		mu 0 4 66 67 118 117
		f 4 133 136 -235 -135
		mu 0 4 67 68 119 118
		f 4 135 138 -237 -137
		mu 0 4 68 69 120 119
		f 4 137 140 -239 -139
		mu 0 4 69 70 121 120
		f 4 139 142 -241 -141
		mu 0 4 70 71 122 121
		f 4 141 144 -243 -143
		mu 0 4 71 72 123 122
		f 4 143 146 -245 -145
		mu 0 4 72 73 124 123
		f 4 145 148 -247 -147
		mu 0 4 73 74 125 124
		f 4 147 150 -249 -149
		mu 0 4 74 75 126 125
		f 4 149 152 -251 -151
		mu 0 4 75 76 127 126
		f 4 151 154 -253 -153
		mu 0 4 76 77 128 127
		f 4 153 156 -255 -155
		mu 0 4 77 78 129 128
		f 4 155 158 -257 -157
		mu 0 4 78 79 130 129
		f 4 157 160 -259 -159
		mu 0 4 79 80 131 130
		f 4 159 162 -261 -161
		mu 0 4 80 81 132 131
		f 4 161 164 -263 -163
		mu 0 4 81 82 133 132
		f 4 163 166 -265 -165
		mu 0 4 82 83 134 133
		f 4 165 168 -267 -167
		mu 0 4 83 84 135 134
		f 4 167 170 -269 -169
		mu 0 4 84 85 136 135
		f 4 169 172 -271 -171
		mu 0 4 85 86 137 136
		f 4 171 174 -273 -173
		mu 0 4 86 87 138 137
		f 4 173 176 -275 -175
		mu 0 4 87 88 139 138
		f 4 175 178 -277 -177
		mu 0 4 88 89 140 139
		f 4 177 180 -279 -179
		mu 0 4 89 90 141 140
		f 4 179 182 -281 -181
		mu 0 4 90 91 142 141
		f 4 181 184 -283 -183
		mu 0 4 91 92 143 142
		f 4 183 186 -285 -185
		mu 0 4 92 93 144 143
		f 4 185 188 -287 -187
		mu 0 4 93 94 145 144
		f 4 187 190 -289 -189
		mu 0 4 94 95 146 145
		f 4 189 192 -291 -191
		mu 0 4 95 96 147 146
		f 4 191 194 -293 -193
		mu 0 4 96 97 148 147
		f 4 193 196 -295 -195
		mu 0 4 97 98 149 148
		f 4 195 198 -297 -197
		mu 0 4 98 99 150 149
		f 4 197 200 -299 -199
		mu 0 4 99 100 151 150
		f 4 199 201 -301 -201
		mu 0 4 100 101 152 151
		f 4 202 205 -304 -204
		mu 0 4 102 103 154 153
		f 4 204 207 -306 -206
		mu 0 4 103 104 155 154
		f 4 206 209 -308 -208
		mu 0 4 104 105 156 155
		f 4 208 211 -310 -210
		mu 0 4 105 106 157 156
		f 4 210 213 -312 -212
		mu 0 4 106 107 158 157
		f 4 212 215 -314 -214
		mu 0 4 107 108 159 158
		f 4 214 217 -316 -216
		mu 0 4 108 109 160 159
		f 4 216 219 -318 -218
		mu 0 4 109 110 161 160
		f 4 218 221 -320 -220
		mu 0 4 110 111 162 161
		f 4 220 223 -322 -222
		mu 0 4 111 112 163 162
		f 4 222 225 -324 -224
		mu 0 4 112 113 164 163
		f 4 224 227 -326 -226
		mu 0 4 113 114 165 164
		f 4 226 229 -328 -228
		mu 0 4 114 115 166 165
		f 4 228 231 -330 -230
		mu 0 4 115 116 167 166
		f 4 230 233 -332 -232
		mu 0 4 116 117 168 167
		f 4 232 235 -334 -234
		mu 0 4 117 118 169 168
		f 4 234 237 -336 -236
		mu 0 4 118 119 170 169
		f 4 236 239 -338 -238
		mu 0 4 119 120 171 170
		f 4 238 241 -340 -240
		mu 0 4 120 121 172 171
		f 4 240 243 -342 -242
		mu 0 4 121 122 173 172
		f 4 242 245 -344 -244
		mu 0 4 122 123 174 173
		f 4 244 247 -346 -246
		mu 0 4 123 124 175 174
		f 4 246 249 -348 -248
		mu 0 4 124 125 176 175
		f 4 248 251 -350 -250
		mu 0 4 125 126 177 176
		f 4 250 253 -352 -252
		mu 0 4 126 127 178 177
		f 4 252 255 -354 -254
		mu 0 4 127 128 179 178
		f 4 254 257 -356 -256
		mu 0 4 128 129 180 179
		f 4 256 259 -358 -258
		mu 0 4 129 130 181 180
		f 4 258 261 -360 -260
		mu 0 4 130 131 182 181
		f 4 260 263 -362 -262
		mu 0 4 131 132 183 182
		f 4 262 265 -364 -264
		mu 0 4 132 133 184 183
		f 4 264 267 -366 -266
		mu 0 4 133 134 185 184
		f 4 266 269 -368 -268
		mu 0 4 134 135 186 185
		f 4 268 271 -370 -270
		mu 0 4 135 136 187 186
		f 4 270 273 -372 -272
		mu 0 4 136 137 188 187
		f 4 272 275 -374 -274
		mu 0 4 137 138 189 188
		f 4 274 277 -376 -276
		mu 0 4 138 139 190 189
		f 4 276 279 -378 -278
		mu 0 4 139 140 191 190
		f 4 278 281 -380 -280
		mu 0 4 140 141 192 191
		f 4 280 283 -382 -282
		mu 0 4 141 142 193 192
		f 4 282 285 -384 -284
		mu 0 4 142 143 194 193
		f 4 284 287 -386 -286
		mu 0 4 143 144 195 194
		f 4 286 289 -388 -288
		mu 0 4 144 145 196 195
		f 4 288 291 -390 -290
		mu 0 4 145 146 197 196
		f 4 290 293 -392 -292
		mu 0 4 146 147 198 197
		f 4 292 295 -394 -294
		mu 0 4 147 148 199 198
		f 4 294 297 -396 -296
		mu 0 4 148 149 200 199
		f 4 296 299 -398 -298
		mu 0 4 149 150 201 200
		f 4 298 301 -400 -300
		mu 0 4 150 151 202 201
		f 4 300 302 -402 -302
		mu 0 4 151 152 203 202
		f 4 303 306 -405 -305
		mu 0 4 153 154 205 204
		f 4 305 308 -407 -307
		mu 0 4 154 155 206 205
		f 4 307 310 -409 -309
		mu 0 4 155 156 207 206
		f 4 309 312 -411 -311
		mu 0 4 156 157 208 207
		f 4 311 314 -413 -313
		mu 0 4 157 158 209 208
		f 4 313 316 -415 -315
		mu 0 4 158 159 210 209
		f 4 315 318 -417 -317
		mu 0 4 159 160 211 210
		f 4 317 320 -419 -319
		mu 0 4 160 161 212 211
		f 4 319 322 -421 -321
		mu 0 4 161 162 213 212
		f 4 321 324 -423 -323
		mu 0 4 162 163 214 213
		f 4 323 326 -425 -325
		mu 0 4 163 164 215 214
		f 4 325 328 -427 -327
		mu 0 4 164 165 216 215
		f 4 327 330 -429 -329
		mu 0 4 165 166 217 216
		f 4 329 332 -431 -331
		mu 0 4 166 167 218 217
		f 4 331 334 -433 -333
		mu 0 4 167 168 219 218
		f 4 333 336 -435 -335
		mu 0 4 168 169 220 219
		f 4 335 338 -437 -337
		mu 0 4 169 170 221 220
		f 4 337 340 -439 -339
		mu 0 4 170 171 222 221
		f 4 339 342 -441 -341
		mu 0 4 171 172 223 222
		f 4 341 344 -443 -343
		mu 0 4 172 173 224 223
		f 4 343 346 -445 -345
		mu 0 4 173 174 225 224
		f 4 345 348 -447 -347
		mu 0 4 174 175 226 225
		f 4 347 350 -449 -349
		mu 0 4 175 176 227 226
		f 4 349 352 -451 -351
		mu 0 4 176 177 228 227
		f 4 351 354 -453 -353
		mu 0 4 177 178 229 228
		f 4 353 356 -455 -355
		mu 0 4 178 179 230 229
		f 4 355 358 -457 -357
		mu 0 4 179 180 231 230
		f 4 357 360 -459 -359
		mu 0 4 180 181 232 231
		f 4 359 362 -461 -361
		mu 0 4 181 182 233 232
		f 4 361 364 -463 -363
		mu 0 4 182 183 234 233
		f 4 363 366 -465 -365
		mu 0 4 183 184 235 234
		f 4 365 368 -467 -367
		mu 0 4 184 185 236 235
		f 4 367 370 -469 -369
		mu 0 4 185 186 237 236
		f 4 369 372 -471 -371
		mu 0 4 186 187 238 237
		f 4 371 374 -473 -373
		mu 0 4 187 188 239 238
		f 4 373 376 -475 -375
		mu 0 4 188 189 240 239
		f 4 375 378 -477 -377
		mu 0 4 189 190 241 240
		f 4 377 380 -479 -379
		mu 0 4 190 191 242 241
		f 4 379 382 -481 -381
		mu 0 4 191 192 243 242
		f 4 381 384 -483 -383
		mu 0 4 192 193 244 243
		f 4 383 386 -485 -385
		mu 0 4 193 194 245 244
		f 4 385 388 -487 -387
		mu 0 4 194 195 246 245
		f 4 387 390 -489 -389
		mu 0 4 195 196 247 246
		f 4 389 392 -491 -391
		mu 0 4 196 197 248 247
		f 4 391 394 -493 -393
		mu 0 4 197 198 249 248
		f 4 393 396 -495 -395
		mu 0 4 198 199 250 249
		f 4 395 398 -497 -397
		mu 0 4 199 200 251 250
		f 4 397 400 -499 -399
		mu 0 4 200 201 252 251
		f 4 399 402 -501 -401
		mu 0 4 201 202 253 252
		f 4 401 403 -503 -403
		mu 0 4 202 203 254 253
		f 4 404 407 -506 -406
		mu 0 4 204 205 256 255
		f 4 406 409 -508 -408
		mu 0 4 205 206 257 256
		f 4 408 411 -510 -410
		mu 0 4 206 207 258 257
		f 4 410 413 -512 -412
		mu 0 4 207 208 259 258
		f 4 412 415 -514 -414
		mu 0 4 208 209 260 259
		f 4 414 417 -516 -416
		mu 0 4 209 210 261 260
		f 4 416 419 -518 -418
		mu 0 4 210 211 262 261
		f 4 418 421 -520 -420
		mu 0 4 211 212 263 262
		f 4 420 423 -522 -422
		mu 0 4 212 213 264 263
		f 4 422 425 -524 -424
		mu 0 4 213 214 265 264
		f 4 424 427 -526 -426
		mu 0 4 214 215 266 265
		f 4 426 429 -528 -428
		mu 0 4 215 216 267 266
		f 4 428 431 -530 -430
		mu 0 4 216 217 268 267
		f 4 430 433 -532 -432
		mu 0 4 217 218 269 268
		f 4 432 435 -534 -434
		mu 0 4 218 219 270 269
		f 4 434 437 -536 -436
		mu 0 4 219 220 271 270
		f 4 436 439 -538 -438
		mu 0 4 220 221 272 271
		f 4 438 441 -540 -440
		mu 0 4 221 222 273 272
		f 4 440 443 -542 -442
		mu 0 4 222 223 274 273
		f 4 442 445 -544 -444
		mu 0 4 223 224 275 274
		f 4 444 447 -546 -446
		mu 0 4 224 225 276 275
		f 4 446 449 -548 -448
		mu 0 4 225 226 277 276
		f 4 448 451 -550 -450
		mu 0 4 226 227 278 277
		f 4 450 453 -552 -452
		mu 0 4 227 228 279 278
		f 4 452 455 -554 -454
		mu 0 4 228 229 280 279
		f 4 454 457 -556 -456
		mu 0 4 229 230 281 280
		f 4 456 459 -558 -458
		mu 0 4 230 231 282 281
		f 4 458 461 -560 -460
		mu 0 4 231 232 283 282
		f 4 460 463 -562 -462
		mu 0 4 232 233 284 283
		f 4 462 465 -564 -464
		mu 0 4 233 234 285 284
		f 4 464 467 -566 -466
		mu 0 4 234 235 286 285
		f 4 466 469 -568 -468
		mu 0 4 235 236 287 286
		f 4 468 471 -570 -470
		mu 0 4 236 237 288 287
		f 4 470 473 -572 -472
		mu 0 4 237 238 289 288
		f 4 472 475 -574 -474
		mu 0 4 238 239 290 289
		f 4 474 477 -576 -476
		mu 0 4 239 240 291 290
		f 4 476 479 -578 -478
		mu 0 4 240 241 292 291
		f 4 478 481 -580 -480
		mu 0 4 241 242 293 292
		f 4 480 483 -582 -482
		mu 0 4 242 243 294 293
		f 4 482 485 -584 -484
		mu 0 4 243 244 295 294
		f 4 484 487 -586 -486
		mu 0 4 244 245 296 295
		f 4 486 489 -588 -488
		mu 0 4 245 246 297 296
		f 4 488 491 -590 -490
		mu 0 4 246 247 298 297
		f 4 490 493 -592 -492
		mu 0 4 247 248 299 298
		f 4 492 495 -594 -494
		mu 0 4 248 249 300 299
		f 4 494 497 -596 -496
		mu 0 4 249 250 301 300
		f 4 496 499 -598 -498
		mu 0 4 250 251 302 301
		f 4 498 501 -600 -500
		mu 0 4 251 252 303 302
		f 4 500 503 -602 -502
		mu 0 4 252 253 304 303
		f 4 502 504 -604 -504
		mu 0 4 253 254 305 304
		f 4 505 508 -607 -507
		mu 0 4 255 256 307 306
		f 4 507 510 -609 -509
		mu 0 4 256 257 308 307
		f 4 509 512 -611 -511
		mu 0 4 257 258 309 308
		f 4 511 514 -613 -513
		mu 0 4 258 259 310 309
		f 4 513 516 -615 -515
		mu 0 4 259 260 311 310
		f 4 515 518 -617 -517
		mu 0 4 260 261 312 311
		f 4 517 520 -619 -519
		mu 0 4 261 262 313 312
		f 4 519 522 -621 -521
		mu 0 4 262 263 314 313
		f 4 521 524 -623 -523
		mu 0 4 263 264 315 314
		f 4 523 526 -625 -525
		mu 0 4 264 265 316 315
		f 4 525 528 -627 -527
		mu 0 4 265 266 317 316
		f 4 527 530 -629 -529
		mu 0 4 266 267 318 317
		f 4 529 532 -631 -531
		mu 0 4 267 268 319 318
		f 4 531 534 -633 -533
		mu 0 4 268 269 320 319
		f 4 533 536 -635 -535
		mu 0 4 269 270 321 320
		f 4 535 538 -637 -537
		mu 0 4 270 271 322 321
		f 4 537 540 -639 -539
		mu 0 4 271 272 323 322
		f 4 539 542 -641 -541
		mu 0 4 272 273 324 323
		f 4 541 544 -643 -543
		mu 0 4 273 274 325 324
		f 4 543 546 -645 -545
		mu 0 4 274 275 326 325
		f 4 545 548 -647 -547
		mu 0 4 275 276 327 326
		f 4 547 550 -649 -549
		mu 0 4 276 277 328 327
		f 4 549 552 -651 -551
		mu 0 4 277 278 329 328
		f 4 551 554 -653 -553
		mu 0 4 278 279 330 329
		f 4 553 556 -655 -555
		mu 0 4 279 280 331 330
		f 4 555 558 -657 -557
		mu 0 4 280 281 332 331
		f 4 557 560 -659 -559
		mu 0 4 281 282 333 332
		f 4 559 562 -661 -561
		mu 0 4 282 283 334 333
		f 4 561 564 -663 -563
		mu 0 4 283 284 335 334
		f 4 563 566 -665 -565
		mu 0 4 284 285 336 335
		f 4 565 568 -667 -567
		mu 0 4 285 286 337 336
		f 4 567 570 -669 -569
		mu 0 4 286 287 338 337
		f 4 569 572 -671 -571
		mu 0 4 287 288 339 338
		f 4 571 574 -673 -573
		mu 0 4 288 289 340 339
		f 4 573 576 -675 -575
		mu 0 4 289 290 341 340
		f 4 575 578 -677 -577
		mu 0 4 290 291 342 341
		f 4 577 580 -679 -579
		mu 0 4 291 292 343 342
		f 4 579 582 -681 -581
		mu 0 4 292 293 344 343
		f 4 581 584 -683 -583
		mu 0 4 293 294 345 344
		f 4 583 586 -685 -585
		mu 0 4 294 295 346 345
		f 4 585 588 -687 -587
		mu 0 4 295 296 347 346
		f 4 587 590 -689 -589
		mu 0 4 296 297 348 347
		f 4 589 592 -691 -591
		mu 0 4 297 298 349 348
		f 4 591 594 -693 -593
		mu 0 4 298 299 350 349
		f 4 593 596 -695 -595
		mu 0 4 299 300 351 350
		f 4 595 598 -697 -597
		mu 0 4 300 301 352 351
		f 4 597 600 -699 -599
		mu 0 4 301 302 353 352
		f 4 599 602 -701 -601
		mu 0 4 302 303 354 353
		f 4 601 604 -703 -603
		mu 0 4 303 304 355 354
		f 4 603 605 -705 -605
		mu 0 4 304 305 356 355
		f 4 606 609 -708 -608
		mu 0 4 306 307 358 357
		f 4 608 611 -710 -610
		mu 0 4 307 308 359 358
		f 4 610 613 -712 -612
		mu 0 4 308 309 360 359
		f 4 612 615 -714 -614
		mu 0 4 309 310 361 360
		f 4 614 617 -716 -616
		mu 0 4 310 311 362 361
		f 4 616 619 -718 -618
		mu 0 4 311 312 363 362
		f 4 618 621 -720 -620
		mu 0 4 312 313 364 363
		f 4 620 623 -722 -622
		mu 0 4 313 314 365 364
		f 4 622 625 -724 -624
		mu 0 4 314 315 366 365
		f 4 624 627 -726 -626
		mu 0 4 315 316 367 366
		f 4 626 629 -728 -628
		mu 0 4 316 317 368 367
		f 4 628 631 -730 -630
		mu 0 4 317 318 369 368
		f 4 630 633 -732 -632
		mu 0 4 318 319 370 369
		f 4 632 635 -734 -634
		mu 0 4 319 320 371 370
		f 4 634 637 -736 -636
		mu 0 4 320 321 372 371
		f 4 636 639 -738 -638
		mu 0 4 321 322 373 372
		f 4 638 641 -740 -640
		mu 0 4 322 323 374 373
		f 4 640 643 -742 -642
		mu 0 4 323 324 375 374
		f 4 642 645 -744 -644
		mu 0 4 324 325 376 375
		f 4 644 647 -746 -646
		mu 0 4 325 326 377 376
		f 4 646 649 -748 -648
		mu 0 4 326 327 378 377
		f 4 648 651 -750 -650
		mu 0 4 327 328 379 378
		f 4 650 653 -752 -652
		mu 0 4 328 329 380 379
		f 4 652 655 -754 -654
		mu 0 4 329 330 381 380
		f 4 654 657 -756 -656
		mu 0 4 330 331 382 381
		f 4 656 659 -758 -658
		mu 0 4 331 332 383 382
		f 4 658 661 -760 -660
		mu 0 4 332 333 384 383
		f 4 660 663 -762 -662
		mu 0 4 333 334 385 384
		f 4 662 665 -764 -664
		mu 0 4 334 335 386 385
		f 4 664 667 -766 -666
		mu 0 4 335 336 387 386
		f 4 666 669 -768 -668
		mu 0 4 336 337 388 387
		f 4 668 671 -770 -670
		mu 0 4 337 338 389 388
		f 4 670 673 -772 -672
		mu 0 4 338 339 390 389
		f 4 672 675 -774 -674
		mu 0 4 339 340 391 390
		f 4 674 677 -776 -676
		mu 0 4 340 341 392 391
		f 4 676 679 -778 -678
		mu 0 4 341 342 393 392
		f 4 678 681 -780 -680
		mu 0 4 342 343 394 393
		f 4 680 683 -782 -682
		mu 0 4 343 344 395 394
		f 4 682 685 -784 -684
		mu 0 4 344 345 396 395
		f 4 684 687 -786 -686
		mu 0 4 345 346 397 396
		f 4 686 689 -788 -688
		mu 0 4 346 347 398 397
		f 4 688 691 -790 -690
		mu 0 4 347 348 399 398
		f 4 690 693 -792 -692
		mu 0 4 348 349 400 399
		f 4 692 695 -794 -694
		mu 0 4 349 350 401 400
		f 4 694 697 -796 -696
		mu 0 4 350 351 402 401
		f 4 696 699 -798 -698
		mu 0 4 351 352 403 402
		f 4 698 701 -800 -700
		mu 0 4 352 353 404 403
		f 4 700 703 -802 -702
		mu 0 4 353 354 405 404
		f 4 702 705 -804 -704
		mu 0 4 354 355 406 405
		f 4 704 706 -806 -706
		mu 0 4 355 356 407 406
		f 4 707 710 -809 -709
		mu 0 4 357 358 409 408
		f 4 709 712 -811 -711
		mu 0 4 358 359 410 409
		f 4 711 714 -813 -713
		mu 0 4 359 360 411 410
		f 4 713 716 -815 -715
		mu 0 4 360 361 412 411
		f 4 715 718 -817 -717
		mu 0 4 361 362 413 412
		f 4 717 720 -819 -719
		mu 0 4 362 363 414 413
		f 4 719 722 -821 -721
		mu 0 4 363 364 415 414
		f 4 721 724 -823 -723
		mu 0 4 364 365 416 415
		f 4 723 726 -825 -725
		mu 0 4 365 366 417 416
		f 4 725 728 -827 -727
		mu 0 4 366 367 418 417
		f 4 727 730 -829 -729
		mu 0 4 367 368 419 418
		f 4 729 732 -831 -731
		mu 0 4 368 369 420 419
		f 4 731 734 -833 -733
		mu 0 4 369 370 421 420
		f 4 733 736 -835 -735
		mu 0 4 370 371 422 421
		f 4 735 738 -837 -737
		mu 0 4 371 372 423 422
		f 4 737 740 -839 -739
		mu 0 4 372 373 424 423
		f 4 739 742 -841 -741
		mu 0 4 373 374 425 424
		f 4 741 744 -843 -743
		mu 0 4 374 375 426 425
		f 4 743 746 -845 -745
		mu 0 4 375 376 427 426
		f 4 745 748 -847 -747
		mu 0 4 376 377 428 427
		f 4 747 750 -849 -749
		mu 0 4 377 378 429 428
		f 4 749 752 -851 -751
		mu 0 4 378 379 430 429
		f 4 751 754 -853 -753
		mu 0 4 379 380 431 430
		f 4 753 756 -854 -755
		mu 0 4 380 381 432 431
		f 4 755 758 -855 -757
		mu 0 4 381 382 433 432
		f 4 757 760 -856 -759
		mu 0 4 382 383 434 433
		f 4 759 762 -857 -761
		mu 0 4 383 384 435 434
		f 4 761 764 -858 -763
		mu 0 4 384 385 436 435
		f 4 763 766 -859 -765
		mu 0 4 385 386 437 436
		f 4 765 768 -860 -767
		mu 0 4 386 387 438 437
		f 4 767 770 -861 -769
		mu 0 4 387 388 439 438
		f 4 769 772 -862 -771
		mu 0 4 388 389 440 439
		f 4 771 774 -863 -773
		mu 0 4 389 390 441 440
		f 4 773 776 -864 -775
		mu 0 4 390 391 442 441
		f 4 775 778 -865 -777
		mu 0 4 391 392 443 442
		f 4 777 780 -866 -779
		mu 0 4 392 393 444 443
		f 4 779 782 -867 -781
		mu 0 4 393 394 445 444
		f 4 781 784 -868 -783
		mu 0 4 394 395 446 445
		f 4 783 786 -869 -785
		mu 0 4 395 396 447 446
		f 4 785 788 -870 -787
		mu 0 4 396 397 448 447
		f 4 787 790 -871 -789
		mu 0 4 397 398 449 448
		f 4 789 792 -872 -791
		mu 0 4 398 399 450 449
		f 4 791 794 -873 -793
		mu 0 4 399 400 451 450
		f 4 793 796 -875 -795
		mu 0 4 400 401 452 451
		f 4 795 798 -877 -797
		mu 0 4 401 402 453 452
		f 4 797 800 -879 -799
		mu 0 4 402 403 454 453
		f 4 799 802 -881 -801
		mu 0 4 403 404 455 454
		f 4 801 804 -883 -803
		mu 0 4 404 405 456 455
		f 4 803 806 -885 -805
		mu 0 4 405 406 457 456
		f 4 805 807 -887 -807
		mu 0 4 406 407 458 457
		f 4 808 811 -890 -810
		mu 0 4 408 409 460 459
		f 4 810 813 -892 -812
		mu 0 4 409 410 461 460
		f 4 812 815 -894 -814
		mu 0 4 410 411 462 461
		f 4 814 817 -896 -816
		mu 0 4 411 412 463 462
		f 4 816 819 -898 -818
		mu 0 4 412 413 464 463
		f 4 818 821 -900 -820
		mu 0 4 413 414 465 464
		f 4 820 823 -902 -822
		mu 0 4 414 415 466 465
		f 4 822 825 -904 -824
		mu 0 4 415 416 467 466
		f 4 824 827 -906 -826
		mu 0 4 416 417 468 467
		f 4 826 829 -908 -828
		mu 0 4 417 418 469 468
		f 4 828 831 -910 -830
		mu 0 4 418 419 470 469
		f 4 830 833 -912 -832
		mu 0 4 419 420 471 470
		f 4 832 835 -914 -834
		mu 0 4 420 421 472 471
		f 4 834 837 -916 -836
		mu 0 4 421 422 473 472
		f 4 836 839 -918 -838
		mu 0 4 422 423 474 473
		f 4 838 841 -920 -840
		mu 0 4 423 424 475 474
		f 4 840 843 -922 -842
		mu 0 4 424 425 476 475
		f 4 842 845 -924 -844
		mu 0 4 425 426 477 476
		f 4 844 847 -926 -846
		mu 0 4 426 427 478 477
		f 4 846 849 -928 -848
		mu 0 4 427 428 479 478
		f 4 848 851 -930 -850
		mu 0 4 428 429 480 479
		f 4 872 875 -933 -874
		mu 0 4 450 451 482 481
		f 4 874 877 -935 -876
		mu 0 4 451 452 483 482
		f 4 876 879 -937 -878
		mu 0 4 452 453 484 483
		f 4 878 881 -939 -880
		mu 0 4 453 454 485 484
		f 4 880 883 -941 -882
		mu 0 4 454 455 486 485
		f 4 882 885 -943 -884
		mu 0 4 455 456 487 486
		f 4 884 887 -945 -886
		mu 0 4 456 457 488 487
		f 4 886 888 -947 -888
		mu 0 4 457 458 489 488
		f 4 889 892 -950 -891
		mu 0 4 459 460 491 490
		f 4 891 894 -952 -893
		mu 0 4 460 461 492 491
		f 4 893 896 -954 -895
		mu 0 4 461 462 493 492
		f 4 895 898 -956 -897
		mu 0 4 462 463 494 493
		f 4 897 900 -958 -899
		mu 0 4 463 464 495 494
		f 4 899 902 -960 -901
		mu 0 4 464 465 496 495
		f 4 901 904 -962 -903
		mu 0 4 465 466 497 496
		f 4 903 906 -964 -905
		mu 0 4 466 467 498 497
		f 4 905 908 -966 -907
		mu 0 4 467 468 499 498
		f 4 907 910 -968 -909
		mu 0 4 468 469 500 499
		f 4 909 912 -970 -911
		mu 0 4 469 470 501 500
		f 4 911 914 -972 -913
		mu 0 4 470 471 502 501
		f 4 913 916 -974 -915
		mu 0 4 471 472 503 502
		f 4 915 918 -976 -917
		mu 0 4 472 473 504 503
		f 4 917 920 -978 -919
		mu 0 4 473 474 505 504
		f 4 919 922 -980 -921
		mu 0 4 474 475 506 505
		f 4 921 924 -982 -923
		mu 0 4 475 476 507 506
		f 4 923 926 -984 -925
		mu 0 4 476 477 508 507
		f 4 925 928 -986 -927
		mu 0 4 477 478 509 508
		f 4 927 930 -988 -929
		mu 0 4 478 479 510 509
		f 4 929 931 -990 -931
		mu 0 4 479 480 511 510
		f 4 932 935 -993 -934
		mu 0 4 481 482 513 512
		f 4 934 937 -995 -936
		mu 0 4 482 483 514 513
		f 4 936 939 -997 -938
		mu 0 4 483 484 515 514
		f 4 938 941 -999 -940
		mu 0 4 484 485 516 515
		f 4 940 943 -1001 -942
		mu 0 4 485 486 517 516
		f 4 942 945 -1003 -944
		mu 0 4 486 487 518 517
		f 4 944 947 -1005 -946
		mu 0 4 487 488 519 518
		f 4 946 948 -1007 -948
		mu 0 4 488 489 520 519
		f 4 949 952 -1010 -951
		mu 0 4 490 491 522 521
		f 4 951 954 -1012 -953
		mu 0 4 491 492 523 522
		f 4 953 956 -1014 -955
		mu 0 4 492 493 524 523
		f 4 955 958 -1016 -957
		mu 0 4 493 494 525 524
		f 4 957 960 -1018 -959
		mu 0 4 494 495 526 525
		f 4 959 962 -1020 -961
		mu 0 4 495 496 527 526
		f 4 961 964 -1022 -963
		mu 0 4 496 497 528 527
		f 4 963 966 -1024 -965
		mu 0 4 497 498 529 528
		f 4 965 968 -1026 -967
		mu 0 4 498 499 530 529
		f 4 967 970 -1028 -969
		mu 0 4 499 500 531 530
		f 4 969 972 -1030 -971
		mu 0 4 500 501 532 531
		f 4 971 974 -1032 -973
		mu 0 4 501 502 533 532
		f 4 973 976 -1034 -975
		mu 0 4 502 503 534 533
		f 4 975 978 -1036 -977
		mu 0 4 503 504 535 534
		f 4 977 980 -1038 -979
		mu 0 4 504 505 536 535
		f 4 979 982 -1040 -981
		mu 0 4 505 506 537 536
		f 4 981 984 -1042 -983
		mu 0 4 506 507 538 537
		f 4 983 986 -1044 -985
		mu 0 4 507 508 539 538
		f 4 985 988 -1046 -987
		mu 0 4 508 509 540 539
		f 4 987 990 -1048 -989
		mu 0 4 509 510 541 540
		f 4 989 991 -1050 -991
		mu 0 4 510 511 542 541
		f 4 992 995 -1053 -994
		mu 0 4 512 513 544 543
		f 4 994 997 -1055 -996
		mu 0 4 513 514 545 544
		f 4 996 999 -1057 -998
		mu 0 4 514 515 546 545
		f 4 998 1001 -1059 -1000
		mu 0 4 515 516 547 546
		f 4 1000 1003 -1061 -1002
		mu 0 4 516 517 548 547
		f 4 1002 1005 -1063 -1004
		mu 0 4 517 518 549 548
		f 4 1004 1007 -1065 -1006
		mu 0 4 518 519 550 549
		f 4 1006 1008 -1067 -1008
		mu 0 4 519 520 551 550
		f 4 1009 1012 -1070 -1011
		mu 0 4 521 522 553 552
		f 4 1011 1014 -1072 -1013
		mu 0 4 522 523 554 553
		f 4 1013 1016 -1074 -1015
		mu 0 4 523 524 555 554
		f 4 1015 1018 -1076 -1017
		mu 0 4 524 525 556 555
		f 4 1017 1020 -1078 -1019
		mu 0 4 525 526 557 556
		f 4 1019 1022 -1080 -1021
		mu 0 4 526 527 558 557
		f 4 1021 1024 -1082 -1023
		mu 0 4 527 528 559 558
		f 4 1023 1026 -1084 -1025
		mu 0 4 528 529 560 559
		f 4 1025 1028 -1086 -1027
		mu 0 4 529 530 561 560
		f 4 1027 1030 -1088 -1029
		mu 0 4 530 531 562 561
		f 4 1029 1032 -1090 -1031
		mu 0 4 531 532 563 562
		f 4 1031 1034 -1092 -1033
		mu 0 4 532 533 564 563
		f 4 1033 1036 -1094 -1035
		mu 0 4 533 534 565 564;
	setAttr ".fc[500:999]"
		f 4 1035 1038 -1096 -1037
		mu 0 4 534 535 566 565
		f 4 1037 1040 -1098 -1039
		mu 0 4 535 536 567 566
		f 4 1039 1042 -1100 -1041
		mu 0 4 536 537 568 567
		f 4 1041 1044 -1102 -1043
		mu 0 4 537 538 569 568
		f 4 1043 1046 -1104 -1045
		mu 0 4 538 539 570 569
		f 4 1045 1048 -1106 -1047
		mu 0 4 539 540 571 570
		f 4 1047 1050 -1108 -1049
		mu 0 4 540 541 572 571
		f 4 1049 1051 -1110 -1051
		mu 0 4 541 542 573 572
		f 4 1052 1055 -1113 -1054
		mu 0 4 543 544 575 574
		f 4 1054 1057 -1115 -1056
		mu 0 4 544 545 576 575
		f 4 1056 1059 -1117 -1058
		mu 0 4 545 546 577 576
		f 4 1058 1061 -1119 -1060
		mu 0 4 546 547 578 577
		f 4 1060 1063 -1121 -1062
		mu 0 4 547 548 579 578
		f 4 1062 1065 -1123 -1064
		mu 0 4 548 549 580 579
		f 4 1064 1067 -1125 -1066
		mu 0 4 549 550 581 580
		f 4 1066 1068 -1127 -1068
		mu 0 4 550 551 582 581
		f 4 1069 1072 -1130 -1071
		mu 0 4 552 553 584 583
		f 4 1071 1074 -1132 -1073
		mu 0 4 553 554 585 584
		f 4 1073 1076 -1134 -1075
		mu 0 4 554 555 586 585
		f 4 1075 1078 -1136 -1077
		mu 0 4 555 556 587 586
		f 4 1077 1080 -1138 -1079
		mu 0 4 556 557 588 587
		f 4 1079 1082 -1140 -1081
		mu 0 4 557 558 589 588
		f 4 1081 1084 -1142 -1083
		mu 0 4 558 559 590 589
		f 4 1083 1086 -1144 -1085
		mu 0 4 559 560 591 590
		f 4 1085 1088 -1146 -1087
		mu 0 4 560 561 592 591
		f 4 1087 1090 -1148 -1089
		mu 0 4 561 562 593 592
		f 4 1089 1092 -1150 -1091
		mu 0 4 562 563 594 593
		f 4 1091 1094 -1152 -1093
		mu 0 4 563 564 595 594
		f 4 1093 1096 -1154 -1095
		mu 0 4 564 565 596 595
		f 4 1095 1098 -1156 -1097
		mu 0 4 565 566 597 596
		f 4 1097 1100 -1158 -1099
		mu 0 4 566 567 598 597
		f 4 1099 1102 -1160 -1101
		mu 0 4 567 568 599 598
		f 4 1101 1104 -1162 -1103
		mu 0 4 568 569 600 599
		f 4 1103 1106 -1164 -1105
		mu 0 4 569 570 601 600
		f 4 1105 1108 -1166 -1107
		mu 0 4 570 571 602 601
		f 4 1107 1110 -1168 -1109
		mu 0 4 571 572 603 602
		f 4 1109 1111 -1170 -1111
		mu 0 4 572 573 604 603
		f 4 1112 1115 -1173 -1114
		mu 0 4 574 575 606 605
		f 4 1114 1117 -1175 -1116
		mu 0 4 575 576 607 606
		f 4 1116 1119 -1177 -1118
		mu 0 4 576 577 608 607
		f 4 1118 1121 -1179 -1120
		mu 0 4 577 578 609 608
		f 4 1120 1123 -1181 -1122
		mu 0 4 578 579 610 609
		f 4 1122 1125 -1183 -1124
		mu 0 4 579 580 611 610
		f 4 1124 1127 -1185 -1126
		mu 0 4 580 581 612 611
		f 4 1126 1128 -1187 -1128
		mu 0 4 581 582 613 612
		f 4 1129 1132 -1190 -1131
		mu 0 4 583 584 615 614
		f 4 1131 1134 -1192 -1133
		mu 0 4 584 585 616 615
		f 4 1133 1136 -1194 -1135
		mu 0 4 585 586 617 616
		f 4 1135 1138 -1196 -1137
		mu 0 4 586 587 618 617
		f 4 1137 1140 -1198 -1139
		mu 0 4 587 588 619 618
		f 4 1139 1142 -1200 -1141
		mu 0 4 588 589 620 619
		f 4 1141 1144 -1202 -1143
		mu 0 4 589 590 621 620
		f 4 1143 1146 -1204 -1145
		mu 0 4 590 591 622 621
		f 4 1145 1148 -1206 -1147
		mu 0 4 591 592 623 622
		f 4 1147 1150 -1208 -1149
		mu 0 4 592 593 624 623
		f 4 1149 1152 -1210 -1151
		mu 0 4 593 594 625 624
		f 4 1151 1154 -1212 -1153
		mu 0 4 594 595 626 625
		f 4 1153 1156 -1214 -1155
		mu 0 4 595 596 627 626
		f 4 1155 1158 -1216 -1157
		mu 0 4 596 597 628 627
		f 4 1157 1160 -1218 -1159
		mu 0 4 597 598 629 628
		f 4 1159 1162 -1220 -1161
		mu 0 4 598 599 630 629
		f 4 1161 1164 -1222 -1163
		mu 0 4 599 600 631 630
		f 4 1163 1166 -1224 -1165
		mu 0 4 600 601 632 631
		f 4 1165 1168 -1226 -1167
		mu 0 4 601 602 633 632
		f 4 1167 1170 -1228 -1169
		mu 0 4 602 603 634 633
		f 4 1169 1171 -1230 -1171
		mu 0 4 603 604 635 634
		f 4 1172 1175 -1274 -1174
		mu 0 4 605 606 657 656
		f 4 1174 1177 -1276 -1176
		mu 0 4 606 607 658 657
		f 4 1176 1179 -1278 -1178
		mu 0 4 607 608 659 658
		f 4 1178 1181 -1280 -1180
		mu 0 4 608 609 660 659
		f 4 1180 1183 -1282 -1182
		mu 0 4 609 610 661 660
		f 4 1182 1185 -1284 -1184
		mu 0 4 610 611 662 661
		f 4 1184 1187 -1286 -1186
		mu 0 4 611 612 663 662
		f 4 1186 1188 -1288 -1188
		mu 0 4 612 613 664 663
		f 4 1189 1192 -1291 -1191
		mu 0 4 614 615 666 665
		f 4 1191 1194 -1293 -1193
		mu 0 4 615 616 667 666
		f 4 1193 1196 -1295 -1195
		mu 0 4 616 617 668 667
		f 4 1195 1198 -1297 -1197
		mu 0 4 617 618 669 668
		f 4 1197 1200 -1299 -1199
		mu 0 4 618 619 670 669
		f 4 1199 1202 -1301 -1201
		mu 0 4 619 620 671 670
		f 4 1201 1204 -1303 -1203
		mu 0 4 620 621 672 671
		f 4 1203 1206 -1305 -1205
		mu 0 4 621 622 673 672
		f 4 1205 1208 -1307 -1207
		mu 0 4 622 623 674 673
		f 4 1207 1210 -1309 -1209
		mu 0 4 623 624 675 674
		f 4 1209 1212 -1311 -1211
		mu 0 4 624 625 676 675
		f 4 1211 1214 -1313 -1213
		mu 0 4 625 626 677 676
		f 4 1213 1216 -1315 -1215
		mu 0 4 626 627 678 677
		f 4 1215 1218 -1317 -1217
		mu 0 4 627 628 679 678
		f 4 1217 1220 -1319 -1219
		mu 0 4 628 629 680 679
		f 4 1219 1222 -1321 -1221
		mu 0 4 629 630 681 680
		f 4 1221 1224 -1323 -1223
		mu 0 4 630 631 682 681
		f 4 1223 1226 -1325 -1225
		mu 0 4 631 632 683 682
		f 4 1225 1228 -1327 -1227
		mu 0 4 632 633 684 683
		f 4 1227 1230 -1329 -1229
		mu 0 4 633 634 685 684
		f 4 1229 1232 -1331 -1231
		mu 0 4 634 635 686 685
		f 4 1231 1234 -1333 -1233
		mu 0 4 635 636 687 686
		f 4 1233 1236 -1335 -1235
		mu 0 4 636 637 688 687
		f 4 1235 1238 -1337 -1237
		mu 0 4 637 638 689 688
		f 4 1237 1240 -1339 -1239
		mu 0 4 638 639 690 689
		f 4 1239 1242 -1341 -1241
		mu 0 4 639 640 691 690
		f 4 1241 1244 -1343 -1243
		mu 0 4 640 641 692 691
		f 4 1243 1246 -1345 -1245
		mu 0 4 641 642 693 692
		f 4 1245 1248 -1347 -1247
		mu 0 4 642 643 694 693
		f 4 1247 1250 -1349 -1249
		mu 0 4 643 644 695 694
		f 4 1249 1252 -1351 -1251
		mu 0 4 644 645 696 695
		f 4 1251 1254 -1353 -1253
		mu 0 4 645 646 697 696
		f 4 1253 1256 -1355 -1255
		mu 0 4 646 647 698 697
		f 4 1255 1258 -1357 -1257
		mu 0 4 647 648 699 698
		f 4 1257 1260 -1359 -1259
		mu 0 4 648 649 700 699
		f 4 1259 1262 -1361 -1261
		mu 0 4 649 650 701 700
		f 4 1261 1264 -1363 -1263
		mu 0 4 650 651 702 701
		f 4 1263 1266 -1365 -1265
		mu 0 4 651 652 703 702
		f 4 1265 1268 -1367 -1267
		mu 0 4 652 653 704 703
		f 4 1267 1270 -1369 -1269
		mu 0 4 653 654 705 704
		f 4 1269 1272 -1371 -1271
		mu 0 4 654 655 706 705
		f 4 1271 1274 -1373 -1273
		mu 0 4 655 656 707 706
		f 4 1273 1276 -1375 -1275
		mu 0 4 656 657 708 707
		f 4 1275 1278 -1377 -1277
		mu 0 4 657 658 709 708
		f 4 1277 1280 -1379 -1279
		mu 0 4 658 659 710 709
		f 4 1279 1282 -1381 -1281
		mu 0 4 659 660 711 710
		f 4 1281 1284 -1383 -1283
		mu 0 4 660 661 712 711
		f 4 1283 1286 -1385 -1285
		mu 0 4 661 662 713 712
		f 4 1285 1288 -1387 -1287
		mu 0 4 662 663 714 713
		f 4 1287 1289 -1389 -1289
		mu 0 4 663 664 715 714
		f 4 1290 1293 -1392 -1292
		mu 0 4 665 666 717 716
		f 4 1292 1295 -1394 -1294
		mu 0 4 666 667 718 717
		f 4 1294 1297 -1396 -1296
		mu 0 4 667 668 719 718
		f 4 1296 1299 -1398 -1298
		mu 0 4 668 669 720 719
		f 4 1298 1301 -1400 -1300
		mu 0 4 669 670 721 720
		f 4 1300 1303 -1402 -1302
		mu 0 4 670 671 722 721
		f 4 1302 1305 -1404 -1304
		mu 0 4 671 672 723 722
		f 4 1304 1307 -1406 -1306
		mu 0 4 672 673 724 723
		f 4 1306 1309 -1408 -1308
		mu 0 4 673 674 725 724
		f 4 1308 1311 -1410 -1310
		mu 0 4 674 675 726 725
		f 4 1310 1313 -1412 -1312
		mu 0 4 675 676 727 726
		f 4 1312 1315 -1414 -1314
		mu 0 4 676 677 728 727
		f 4 1314 1317 -1416 -1316
		mu 0 4 677 678 729 728
		f 4 1316 1319 -1418 -1318
		mu 0 4 678 679 730 729
		f 4 1318 1321 -1420 -1320
		mu 0 4 679 680 731 730
		f 4 1320 1323 -1422 -1322
		mu 0 4 680 681 732 731
		f 4 1322 1325 -1424 -1324
		mu 0 4 681 682 733 732
		f 4 1324 1327 -1426 -1326
		mu 0 4 682 683 734 733
		f 4 1326 1329 -1428 -1328
		mu 0 4 683 684 735 734
		f 4 1328 1331 -1430 -1330
		mu 0 4 684 685 736 735
		f 4 1330 1333 -1432 -1332
		mu 0 4 685 686 737 736
		f 4 1332 1335 -1434 -1334
		mu 0 4 686 687 738 737
		f 4 1334 1337 -1436 -1336
		mu 0 4 687 688 739 738
		f 4 1336 1339 -1438 -1338
		mu 0 4 688 689 740 739
		f 4 1338 1341 -1440 -1340
		mu 0 4 689 690 741 740
		f 4 1340 1343 -1442 -1342
		mu 0 4 690 691 742 741
		f 4 1342 1345 -1444 -1344
		mu 0 4 691 692 743 742
		f 4 1344 1347 -1446 -1346
		mu 0 4 692 693 744 743
		f 4 1346 1349 -1448 -1348
		mu 0 4 693 694 745 744
		f 4 1348 1351 -1450 -1350
		mu 0 4 694 695 746 745
		f 4 1350 1353 -1452 -1352
		mu 0 4 695 696 747 746
		f 4 1352 1355 -1454 -1354
		mu 0 4 696 697 748 747
		f 4 1354 1357 -1456 -1356
		mu 0 4 697 698 749 748
		f 4 1356 1359 -1458 -1358
		mu 0 4 698 699 750 749
		f 4 1358 1361 -1460 -1360
		mu 0 4 699 700 751 750
		f 4 1360 1363 -1462 -1362
		mu 0 4 700 701 752 751
		f 4 1362 1365 -1464 -1364
		mu 0 4 701 702 753 752
		f 4 1364 1367 -1466 -1366
		mu 0 4 702 703 754 753
		f 4 1366 1369 -1468 -1368
		mu 0 4 703 704 755 754
		f 4 1368 1371 -1470 -1370
		mu 0 4 704 705 756 755
		f 4 1370 1373 -1472 -1372
		mu 0 4 705 706 757 756
		f 4 1372 1375 -1474 -1374
		mu 0 4 706 707 758 757
		f 4 1374 1377 -1476 -1376
		mu 0 4 707 708 759 758
		f 4 1376 1379 -1478 -1378
		mu 0 4 708 709 760 759
		f 4 1378 1381 -1480 -1380
		mu 0 4 709 710 761 760
		f 4 1380 1383 -1482 -1382
		mu 0 4 710 711 762 761
		f 4 1382 1385 -1484 -1384
		mu 0 4 711 712 763 762
		f 4 1384 1387 -1486 -1386
		mu 0 4 712 713 764 763
		f 4 1386 1389 -1488 -1388
		mu 0 4 713 714 765 764
		f 4 1388 1390 -1490 -1390
		mu 0 4 714 715 766 765
		f 4 1391 1394 -1493 -1393
		mu 0 4 716 717 768 767
		f 4 1393 1396 -1495 -1395
		mu 0 4 717 718 769 768
		f 4 1395 1398 -1497 -1397
		mu 0 4 718 719 770 769
		f 4 1397 1400 -1499 -1399
		mu 0 4 719 720 771 770
		f 4 1399 1402 -1501 -1401
		mu 0 4 720 721 772 771
		f 4 1401 1404 -1503 -1403
		mu 0 4 721 722 773 772
		f 4 1403 1406 -1505 -1405
		mu 0 4 722 723 774 773
		f 4 1405 1408 -1507 -1407
		mu 0 4 723 724 775 774
		f 4 1407 1410 -1509 -1409
		mu 0 4 724 725 776 775
		f 4 1409 1412 -1511 -1411
		mu 0 4 725 726 777 776
		f 4 1411 1414 -1513 -1413
		mu 0 4 726 727 778 777
		f 4 1413 1416 -1515 -1415
		mu 0 4 727 728 779 778
		f 4 1415 1418 -1517 -1417
		mu 0 4 728 729 780 779
		f 4 1417 1420 -1519 -1419
		mu 0 4 729 730 781 780
		f 4 1419 1422 -1521 -1421
		mu 0 4 730 731 782 781
		f 4 1421 1424 -1523 -1423
		mu 0 4 731 732 783 782
		f 4 1423 1426 -1525 -1425
		mu 0 4 732 733 784 783
		f 4 1425 1428 -1527 -1427
		mu 0 4 733 734 785 784
		f 4 1427 1430 -1529 -1429
		mu 0 4 734 735 786 785
		f 4 1429 1432 -1531 -1431
		mu 0 4 735 736 787 786
		f 4 1431 1434 -1533 -1433
		mu 0 4 736 737 788 787
		f 4 1433 1436 -1535 -1435
		mu 0 4 737 738 789 788
		f 4 1435 1438 -1537 -1437
		mu 0 4 738 739 790 789
		f 4 1437 1440 -1539 -1439
		mu 0 4 739 740 791 790
		f 4 1439 1442 -1541 -1441
		mu 0 4 740 741 792 791
		f 4 1441 1444 -1543 -1443
		mu 0 4 741 742 793 792
		f 4 1443 1446 -1545 -1445
		mu 0 4 742 743 794 793
		f 4 1445 1448 -1547 -1447
		mu 0 4 743 744 795 794
		f 4 1447 1450 -1549 -1449
		mu 0 4 744 745 796 795
		f 4 1449 1452 -1551 -1451
		mu 0 4 745 746 797 796
		f 4 1451 1454 -1553 -1453
		mu 0 4 746 747 798 797
		f 4 1453 1456 -1555 -1455
		mu 0 4 747 748 799 798
		f 4 1455 1458 -1557 -1457
		mu 0 4 748 749 800 799
		f 4 1457 1460 -1559 -1459
		mu 0 4 749 750 801 800
		f 4 1459 1462 -1561 -1461
		mu 0 4 750 751 802 801
		f 4 1461 1464 -1563 -1463
		mu 0 4 751 752 803 802
		f 4 1463 1466 -1565 -1465
		mu 0 4 752 753 804 803
		f 4 1465 1468 -1567 -1467
		mu 0 4 753 754 805 804
		f 4 1467 1470 -1569 -1469
		mu 0 4 754 755 806 805
		f 4 1469 1472 -1571 -1471
		mu 0 4 755 756 807 806
		f 4 1471 1474 -1573 -1473
		mu 0 4 756 757 808 807
		f 4 1473 1476 -1575 -1475
		mu 0 4 757 758 809 808
		f 4 1475 1478 -1577 -1477
		mu 0 4 758 759 810 809
		f 4 1477 1480 -1579 -1479
		mu 0 4 759 760 811 810
		f 4 1479 1482 -1581 -1481
		mu 0 4 760 761 812 811
		f 4 1481 1484 -1583 -1483
		mu 0 4 761 762 813 812
		f 4 1483 1486 -1585 -1485
		mu 0 4 762 763 814 813
		f 4 1485 1488 -1587 -1487
		mu 0 4 763 764 815 814
		f 4 1487 1490 -1589 -1489
		mu 0 4 764 765 816 815
		f 4 1489 1491 -1591 -1491
		mu 0 4 765 766 817 816
		f 4 1492 1495 -1594 -1494
		mu 0 4 767 768 819 818
		f 4 1494 1497 -1596 -1496
		mu 0 4 768 769 820 819
		f 4 1496 1499 -1598 -1498
		mu 0 4 769 770 821 820
		f 4 1498 1501 -1600 -1500
		mu 0 4 770 771 822 821
		f 4 1500 1503 -1602 -1502
		mu 0 4 771 772 823 822
		f 4 1502 1505 -1604 -1504
		mu 0 4 772 773 824 823
		f 4 1504 1507 -1606 -1506
		mu 0 4 773 774 825 824
		f 4 1506 1509 -1607 -1508
		mu 0 4 774 775 826 825
		f 4 1508 1511 -1608 -1510
		mu 0 4 775 776 827 826
		f 4 1510 1513 -1609 -1512
		mu 0 4 776 777 828 827
		f 4 1512 1515 -1610 -1514
		mu 0 4 777 778 829 828
		f 4 1514 1517 -1611 -1516
		mu 0 4 778 779 830 829
		f 4 1516 1519 -1612 -1518
		mu 0 4 779 780 831 830
		f 4 1518 1521 -1613 -1520
		mu 0 4 780 781 832 831
		f 4 1520 1523 -1614 -1522
		mu 0 4 781 782 833 832
		f 4 1522 1525 -1615 -1524
		mu 0 4 782 783 834 833
		f 4 1524 1527 -1616 -1526
		mu 0 4 783 784 835 834
		f 4 1526 1529 -1617 -1528
		mu 0 4 784 785 836 835
		f 4 1528 1531 -1618 -1530
		mu 0 4 785 786 837 836
		f 4 1530 1533 -1619 -1532
		mu 0 4 786 787 838 837
		f 4 1532 1535 -1620 -1534
		mu 0 4 787 788 839 838
		f 4 1534 1537 -1621 -1536
		mu 0 4 788 789 840 839
		f 4 1536 1539 -1622 -1538
		mu 0 4 789 790 841 840
		f 4 1538 1541 -1623 -1540
		mu 0 4 790 791 842 841
		f 4 1540 1543 -1625 -1542
		mu 0 4 791 792 843 842
		f 4 1542 1545 -1627 -1544
		mu 0 4 792 793 844 843
		f 4 1544 1547 -1629 -1546
		mu 0 4 793 794 845 844
		f 4 1546 1549 -1631 -1548
		mu 0 4 794 795 846 845
		f 4 1548 1551 -1633 -1550
		mu 0 4 795 796 847 846
		f 4 1550 1553 -1635 -1552
		mu 0 4 796 797 848 847
		f 4 1552 1555 -1637 -1554
		mu 0 4 797 798 849 848
		f 4 1554 1557 -1639 -1556
		mu 0 4 798 799 850 849
		f 4 1556 1559 -1641 -1558
		mu 0 4 799 800 851 850
		f 4 1558 1561 -1643 -1560
		mu 0 4 800 801 852 851
		f 4 1560 1563 -1645 -1562
		mu 0 4 801 802 853 852
		f 4 1562 1565 -1647 -1564
		mu 0 4 802 803 854 853
		f 4 1564 1567 -1649 -1566
		mu 0 4 803 804 855 854
		f 4 1566 1569 -1650 -1568
		mu 0 4 804 805 856 855
		f 4 1568 1571 -1651 -1570
		mu 0 4 805 806 857 856
		f 4 1570 1573 -1652 -1572
		mu 0 4 806 807 858 857
		f 4 1572 1575 -1653 -1574
		mu 0 4 807 808 859 858
		f 4 1574 1577 -1654 -1576
		mu 0 4 808 809 860 859
		f 4 1576 1579 -1655 -1578
		mu 0 4 809 810 861 860
		f 4 1578 1581 -1657 -1580
		mu 0 4 810 811 862 861
		f 4 1580 1583 -1659 -1582
		mu 0 4 811 812 863 862
		f 4 1582 1585 -1661 -1584
		mu 0 4 812 813 864 863
		f 4 1584 1587 -1663 -1586
		mu 0 4 813 814 865 864
		f 4 1586 1589 -1665 -1588
		mu 0 4 814 815 866 865
		f 4 1588 1591 -1667 -1590
		mu 0 4 815 816 867 866
		f 4 1590 1592 -1669 -1592
		mu 0 4 816 817 868 867
		f 4 1593 1596 -1672 -1595
		mu 0 4 818 819 870 869
		f 4 1595 1598 -1674 -1597
		mu 0 4 819 820 871 870
		f 4 1597 1600 -1676 -1599
		mu 0 4 820 821 872 871
		f 4 1599 1602 -1678 -1601
		mu 0 4 821 822 873 872
		f 4 1601 1604 -1680 -1603
		mu 0 4 822 823 874 873
		f 4 1622 1625 -1683 -1624
		mu 0 4 841 842 876 875
		f 4 1624 1627 -1685 -1626
		mu 0 4 842 843 877 876
		f 4 1626 1629 -1687 -1628
		mu 0 4 843 844 878 877
		f 4 1628 1631 -1689 -1630
		mu 0 4 844 845 879 878
		f 4 1630 1633 -1691 -1632
		mu 0 4 845 846 880 879
		f 4 1632 1635 -1693 -1634
		mu 0 4 846 847 881 880
		f 4 1634 1637 -1695 -1636
		mu 0 4 847 848 882 881
		f 4 1636 1639 -1697 -1638
		mu 0 4 848 849 883 882
		f 4 1638 1641 -1699 -1640
		mu 0 4 849 850 884 883
		f 4 1640 1643 -1701 -1642
		mu 0 4 850 851 885 884
		f 4 1642 1645 -1703 -1644
		mu 0 4 851 852 886 885
		f 4 1644 1647 -1705 -1646
		mu 0 4 852 853 887 886
		f 4 1654 1657 -1708 -1656
		mu 0 4 860 861 889 888
		f 4 1656 1659 -1710 -1658
		mu 0 4 861 862 890 889
		f 4 1658 1661 -1712 -1660
		mu 0 4 862 863 891 890
		f 4 1660 1663 -1714 -1662
		mu 0 4 863 864 892 891
		f 4 1662 1665 -1716 -1664
		mu 0 4 864 865 893 892
		f 4 1664 1667 -1718 -1666
		mu 0 4 865 866 894 893
		f 4 1666 1669 -1720 -1668
		mu 0 4 866 867 895 894
		f 4 1668 1670 -1722 -1670
		mu 0 4 867 868 896 895
		f 4 1671 1674 -1725 -1673
		mu 0 4 869 870 898 897
		f 4 1673 1676 -1727 -1675
		mu 0 4 870 871 899 898
		f 4 1675 1678 -1729 -1677
		mu 0 4 871 872 900 899
		f 4 1677 1680 -1731 -1679
		mu 0 4 872 873 901 900
		f 4 1679 1681 -1733 -1681
		mu 0 4 873 874 902 901
		f 4 1682 1685 -1736 -1684
		mu 0 4 875 876 904 903
		f 4 1684 1687 -1738 -1686
		mu 0 4 876 877 905 904
		f 4 1686 1689 -1740 -1688
		mu 0 4 877 878 906 905
		f 4 1688 1691 -1742 -1690
		mu 0 4 878 879 907 906
		f 4 1690 1693 -1744 -1692
		mu 0 4 879 880 908 907
		f 4 1692 1695 -1746 -1694
		mu 0 4 880 881 909 908
		f 4 1694 1697 -1748 -1696
		mu 0 4 881 882 910 909
		f 4 1696 1699 -1750 -1698
		mu 0 4 882 883 911 910
		f 4 1698 1701 -1752 -1700
		mu 0 4 883 884 912 911
		f 4 1700 1703 -1754 -1702
		mu 0 4 884 885 913 912
		f 4 1702 1705 -1756 -1704
		mu 0 4 885 886 914 913
		f 4 1704 1706 -1758 -1706
		mu 0 4 886 887 915 914
		f 4 1707 1710 -1761 -1709
		mu 0 4 888 889 917 916
		f 4 1709 1712 -1763 -1711
		mu 0 4 889 890 918 917
		f 4 1711 1714 -1765 -1713
		mu 0 4 890 891 919 918
		f 4 1713 1716 -1767 -1715
		mu 0 4 891 892 920 919
		f 4 1715 1718 -1769 -1717
		mu 0 4 892 893 921 920
		f 4 1717 1720 -1771 -1719
		mu 0 4 893 894 922 921
		f 4 1719 1722 -1773 -1721
		mu 0 4 894 895 923 922
		f 4 1721 1723 -1775 -1723
		mu 0 4 895 896 924 923
		f 4 1724 1727 -1778 -1726
		mu 0 4 897 898 926 925
		f 4 1726 1729 -1780 -1728
		mu 0 4 898 899 927 926
		f 4 1728 1731 -1782 -1730
		mu 0 4 899 900 928 927
		f 4 1730 1733 -1784 -1732
		mu 0 4 900 901 929 928
		f 4 1732 1734 -1786 -1734
		mu 0 4 901 902 930 929
		f 4 1735 1738 -1789 -1737
		mu 0 4 903 904 932 931
		f 4 1737 1740 -1791 -1739
		mu 0 4 904 905 933 932
		f 4 1739 1742 -1793 -1741
		mu 0 4 905 906 934 933
		f 4 1741 1744 -1795 -1743
		mu 0 4 906 907 935 934
		f 4 1743 1746 -1797 -1745
		mu 0 4 907 908 936 935
		f 4 1745 1748 -1799 -1747
		mu 0 4 908 909 937 936
		f 4 1747 1750 -1801 -1749
		mu 0 4 909 910 938 937
		f 4 1749 1752 -1803 -1751
		mu 0 4 910 911 939 938
		f 4 1751 1754 -1805 -1753
		mu 0 4 911 912 940 939
		f 4 1753 1756 -1807 -1755
		mu 0 4 912 913 941 940
		f 4 1755 1758 -1809 -1757
		mu 0 4 913 914 942 941
		f 4 1757 1759 -1811 -1759
		mu 0 4 914 915 943 942
		f 4 1760 1763 -1814 -1762
		mu 0 4 916 917 945 944
		f 4 1762 1765 -1816 -1764
		mu 0 4 917 918 946 945
		f 4 1764 1767 -1818 -1766
		mu 0 4 918 919 947 946
		f 4 1766 1769 -1820 -1768
		mu 0 4 919 920 948 947
		f 4 1768 1771 -1822 -1770
		mu 0 4 920 921 949 948
		f 4 1770 1773 -1824 -1772
		mu 0 4 921 922 950 949
		f 4 1772 1775 -1826 -1774
		mu 0 4 922 923 951 950
		f 4 1774 1776 -1828 -1776
		mu 0 4 923 924 952 951
		f 4 1777 1780 -1831 -1779
		mu 0 4 925 926 954 953
		f 4 1779 1782 -1833 -1781
		mu 0 4 926 927 955 954
		f 4 1781 1784 -1835 -1783
		mu 0 4 927 928 956 955
		f 4 1783 1786 -1837 -1785
		mu 0 4 928 929 957 956
		f 4 1785 1787 -1839 -1787
		mu 0 4 929 930 958 957
		f 4 1788 1791 -1842 -1790
		mu 0 4 931 932 960 959
		f 4 1790 1793 -1844 -1792
		mu 0 4 932 933 961 960
		f 4 1792 1795 -1846 -1794
		mu 0 4 933 934 962 961
		f 4 1794 1797 -1848 -1796
		mu 0 4 934 935 963 962
		f 4 1796 1799 -1850 -1798
		mu 0 4 935 936 964 963
		f 4 1798 1801 -1852 -1800
		mu 0 4 936 937 965 964
		f 4 1800 1803 -1854 -1802
		mu 0 4 937 938 966 965
		f 4 1802 1805 -1856 -1804
		mu 0 4 938 939 967 966
		f 4 1804 1807 -1858 -1806
		mu 0 4 939 940 968 967
		f 4 1806 1809 -1860 -1808
		mu 0 4 940 941 969 968
		f 4 1808 1811 -1862 -1810
		mu 0 4 941 942 970 969
		f 4 1810 1812 -1864 -1812
		mu 0 4 942 943 971 970
		f 4 1813 1816 -1867 -1815
		mu 0 4 944 945 973 972
		f 4 1815 1818 -1869 -1817
		mu 0 4 945 946 974 973
		f 4 1817 1820 -1871 -1819
		mu 0 4 946 947 975 974
		f 4 1819 1822 -1873 -1821
		mu 0 4 947 948 976 975
		f 4 1821 1824 -1875 -1823
		mu 0 4 948 949 977 976
		f 4 1823 1826 -1877 -1825
		mu 0 4 949 950 978 977
		f 4 1825 1828 -1879 -1827
		mu 0 4 950 951 979 978
		f 4 1827 1829 -1881 -1829
		mu 0 4 951 952 980 979
		f 4 1830 1833 -1884 -1832
		mu 0 4 953 954 982 981
		f 4 1832 1835 -1886 -1834
		mu 0 4 954 955 983 982
		f 4 1834 1837 -1888 -1836
		mu 0 4 955 956 984 983
		f 4 1836 1839 -1890 -1838
		mu 0 4 956 957 985 984
		f 4 1838 1840 -1892 -1840
		mu 0 4 957 958 986 985
		f 4 1841 1844 -1930 -1843
		mu 0 4 959 960 1005 1004
		f 4 1843 1846 -1932 -1845
		mu 0 4 960 961 1006 1005
		f 4 1845 1848 -1934 -1847
		mu 0 4 961 962 1007 1006
		f 4 1847 1850 -1936 -1849
		mu 0 4 962 963 1008 1007
		f 4 1849 1852 -1938 -1851
		mu 0 4 963 964 1009 1008
		f 4 1851 1854 -1940 -1853
		mu 0 4 964 965 1010 1009
		f 4 1853 1856 -1942 -1855
		mu 0 4 965 966 1011 1010
		f 4 1855 1858 -1944 -1857
		mu 0 4 966 967 1012 1011
		f 4 1857 1860 -1946 -1859
		mu 0 4 967 968 1013 1012
		f 4 1859 1862 -1948 -1861
		mu 0 4 968 969 1014 1013
		f 4 1861 1864 -1950 -1863
		mu 0 4 969 970 1015 1014
		f 4 1863 1865 -1952 -1865
		mu 0 4 970 971 1016 1015
		f 4 1866 1869 -1955 -1868
		mu 0 4 972 973 1018 1017
		f 4 1868 1871 -1957 -1870
		mu 0 4 973 974 1019 1018
		f 4 1870 1873 -1959 -1872
		mu 0 4 974 975 1020 1019
		f 4 1872 1875 -1961 -1874
		mu 0 4 975 976 1021 1020
		f 4 1874 1877 -1963 -1876
		mu 0 4 976 977 1022 1021
		f 4 1876 1879 -1965 -1878
		mu 0 4 977 978 1023 1022
		f 4 1878 1881 -1967 -1880
		mu 0 4 978 979 1024 1023
		f 4 1880 1882 -1969 -1882
		mu 0 4 979 980 1025 1024
		f 4 1883 1886 -1972 -1885
		mu 0 4 981 982 1027 1026
		f 4 1885 1888 -1974 -1887
		mu 0 4 982 983 1028 1027
		f 4 1887 1890 -1976 -1889
		mu 0 4 983 984 1029 1028
		f 4 1889 1892 -1978 -1891
		mu 0 4 984 985 1030 1029
		f 4 1891 1894 -1980 -1893
		mu 0 4 985 986 1031 1030
		f 4 1893 1896 -1982 -1895
		mu 0 4 986 987 1032 1031
		f 4 1895 1898 -1984 -1897
		mu 0 4 987 988 1033 1032
		f 4 1897 1900 -1986 -1899
		mu 0 4 988 989 1034 1033
		f 4 1899 1902 -1988 -1901
		mu 0 4 989 990 1035 1034
		f 4 1901 1904 -1990 -1903
		mu 0 4 990 991 1036 1035
		f 4 1903 1906 -1992 -1905
		mu 0 4 991 992 1037 1036
		f 4 1905 1908 -1994 -1907
		mu 0 4 992 993 1038 1037
		f 4 1907 1910 -1996 -1909
		mu 0 4 993 994 1039 1038
		f 4 1909 1912 -1998 -1911
		mu 0 4 994 995 1040 1039
		f 4 1911 1914 -2000 -1913
		mu 0 4 995 996 1041 1040
		f 4 1913 1916 -2002 -1915
		mu 0 4 996 997 1042 1041
		f 4 1915 1918 -2004 -1917
		mu 0 4 997 998 1043 1042
		f 4 1917 1920 -2006 -1919
		mu 0 4 998 999 1044 1043
		f 4 1919 1922 -2008 -1921
		mu 0 4 999 1000 1045 1044
		f 4 1921 1924 -2010 -1923
		mu 0 4 1000 1001 1046 1045
		f 4 1923 1926 -2012 -1925
		mu 0 4 1001 1002 1047 1046
		f 4 1925 1928 -2014 -1927
		mu 0 4 1002 1003 1048 1047
		f 4 1927 1930 -2016 -1929
		mu 0 4 1003 1004 1049 1048
		f 4 1929 1932 -2018 -1931
		mu 0 4 1004 1005 1050 1049
		f 4 1931 1934 -2020 -1933
		mu 0 4 1005 1006 1051 1050
		f 4 1933 1936 -2022 -1935
		mu 0 4 1006 1007 1052 1051
		f 4 1935 1938 -2024 -1937
		mu 0 4 1007 1008 1053 1052
		f 4 1937 1940 -2026 -1939
		mu 0 4 1008 1009 1054 1053
		f 4 1939 1942 -2028 -1941
		mu 0 4 1009 1010 1055 1054
		f 4 1941 1944 -2030 -1943
		mu 0 4 1010 1011 1056 1055
		f 4 1943 1946 -2032 -1945
		mu 0 4 1011 1012 1057 1056
		f 4 1945 1948 -2034 -1947
		mu 0 4 1012 1013 1058 1057
		f 4 1947 1950 -2036 -1949
		mu 0 4 1013 1014 1059 1058
		f 4 1949 1952 -2038 -1951
		mu 0 4 1014 1015 1060 1059
		f 4 1951 1953 -2040 -1953
		mu 0 4 1015 1016 1061 1060
		f 4 1954 1957 -2043 -1956
		mu 0 4 1017 1018 1063 1062
		f 4 1956 1959 -2045 -1958
		mu 0 4 1018 1019 1064 1063
		f 4 1958 1961 -2047 -1960
		mu 0 4 1019 1020 1065 1064
		f 4 1960 1963 -2049 -1962
		mu 0 4 1020 1021 1066 1065
		f 4 1962 1965 -2051 -1964
		mu 0 4 1021 1022 1067 1066
		f 4 1964 1967 -2053 -1966
		mu 0 4 1022 1023 1068 1067
		f 4 1966 1969 -2055 -1968
		mu 0 4 1023 1024 1069 1068
		f 4 1968 1970 -2057 -1970
		mu 0 4 1024 1025 1070 1069
		f 4 1971 1974 -2060 -1973
		mu 0 4 1026 1027 1072 1071
		f 4 1973 1976 -2062 -1975
		mu 0 4 1027 1028 1073 1072
		f 4 1975 1978 -2064 -1977
		mu 0 4 1028 1029 1074 1073
		f 4 1977 1980 -2066 -1979
		mu 0 4 1029 1030 1075 1074
		f 4 1979 1982 -2068 -1981
		mu 0 4 1030 1031 1076 1075
		f 4 1981 1984 -2070 -1983
		mu 0 4 1031 1032 1077 1076
		f 4 1983 1986 -2072 -1985
		mu 0 4 1032 1033 1078 1077
		f 4 1985 1988 -2074 -1987
		mu 0 4 1033 1034 1079 1078
		f 4 1987 1990 -2076 -1989
		mu 0 4 1034 1035 1080 1079
		f 4 1989 1992 -2078 -1991
		mu 0 4 1035 1036 1081 1080
		f 4 1991 1994 -2080 -1993
		mu 0 4 1036 1037 1082 1081
		f 4 1993 1996 -2082 -1995
		mu 0 4 1037 1038 1083 1082
		f 4 1995 1998 -2084 -1997
		mu 0 4 1038 1039 1084 1083
		f 4 1997 2000 -2086 -1999
		mu 0 4 1039 1040 1085 1084
		f 4 1999 2002 -2088 -2001
		mu 0 4 1040 1041 1086 1085
		f 4 2001 2004 -2090 -2003
		mu 0 4 1041 1042 1087 1086
		f 4 2003 2006 -2092 -2005
		mu 0 4 1042 1043 1088 1087
		f 4 2005 2008 -2094 -2007
		mu 0 4 1043 1044 1089 1088
		f 4 2007 2010 -2096 -2009
		mu 0 4 1044 1045 1090 1089
		f 4 2009 2012 -2098 -2011
		mu 0 4 1045 1046 1091 1090
		f 4 2011 2014 -2100 -2013
		mu 0 4 1046 1047 1092 1091
		f 4 2013 2016 -2102 -2015
		mu 0 4 1047 1048 1093 1092
		f 4 2015 2018 -2104 -2017
		mu 0 4 1048 1049 1094 1093
		f 4 2017 2020 -2106 -2019
		mu 0 4 1049 1050 1095 1094
		f 4 2019 2022 -2108 -2021
		mu 0 4 1050 1051 1096 1095
		f 4 2021 2024 -2110 -2023
		mu 0 4 1051 1052 1097 1096
		f 4 2023 2026 -2112 -2025
		mu 0 4 1052 1053 1098 1097
		f 4 2025 2028 -2114 -2027
		mu 0 4 1053 1054 1099 1098
		f 4 2027 2030 -2116 -2029
		mu 0 4 1054 1055 1100 1099
		f 4 2029 2032 -2118 -2031
		mu 0 4 1055 1056 1101 1100
		f 4 2031 2034 -2120 -2033
		mu 0 4 1056 1057 1102 1101
		f 4 2033 2036 -2122 -2035
		mu 0 4 1057 1058 1103 1102
		f 4 2035 2038 -2124 -2037
		mu 0 4 1058 1059 1104 1103
		f 4 2037 2040 -2126 -2039
		mu 0 4 1059 1060 1105 1104
		f 4 2039 2041 -2128 -2041
		mu 0 4 1060 1061 1106 1105
		f 4 2042 2045 -2131 -2044
		mu 0 4 1062 1063 1108 1107
		f 4 2044 2047 -2133 -2046
		mu 0 4 1063 1064 1109 1108
		f 4 2046 2049 -2135 -2048
		mu 0 4 1064 1065 1110 1109
		f 4 2048 2051 -2137 -2050
		mu 0 4 1065 1066 1111 1110
		f 4 2050 2053 -2139 -2052
		mu 0 4 1066 1067 1112 1111
		f 4 2052 2055 -2141 -2054
		mu 0 4 1067 1068 1113 1112
		f 4 2054 2057 -2143 -2056
		mu 0 4 1068 1069 1114 1113
		f 4 2056 2058 -2145 -2058
		mu 0 4 1069 1070 1115 1114
		f 4 2059 2062 -2148 -2061
		mu 0 4 1071 1072 1117 1116
		f 4 2061 2064 -2150 -2063
		mu 0 4 1072 1073 1118 1117
		f 4 2063 2066 -2152 -2065
		mu 0 4 1073 1074 1119 1118
		f 4 2065 2068 -2154 -2067
		mu 0 4 1074 1075 1120 1119
		f 4 2067 2070 -2156 -2069
		mu 0 4 1075 1076 1121 1120
		f 4 2069 2072 -2158 -2071
		mu 0 4 1076 1077 1122 1121
		f 4 2071 2074 -2160 -2073
		mu 0 4 1077 1078 1123 1122
		f 4 2073 2076 -2162 -2075
		mu 0 4 1078 1079 1124 1123
		f 4 2075 2078 -2164 -2077
		mu 0 4 1079 1080 1125 1124
		f 4 2077 2080 -2166 -2079
		mu 0 4 1080 1081 1126 1125
		f 4 2079 2082 -2168 -2081
		mu 0 4 1081 1082 1127 1126
		f 4 2081 2084 -2170 -2083
		mu 0 4 1082 1083 1128 1127
		f 4 2083 2086 -2172 -2085
		mu 0 4 1083 1084 1129 1128
		f 4 2085 2088 -2174 -2087
		mu 0 4 1084 1085 1130 1129
		f 4 2087 2090 -2176 -2089
		mu 0 4 1085 1086 1131 1130;
	setAttr ".fc[1000:1499]"
		f 4 2089 2092 -2178 -2091
		mu 0 4 1086 1087 1132 1131
		f 4 2091 2094 -2180 -2093
		mu 0 4 1087 1088 1133 1132
		f 4 2093 2096 -2182 -2095
		mu 0 4 1088 1089 1134 1133
		f 4 2095 2098 -2184 -2097
		mu 0 4 1089 1090 1135 1134
		f 4 2097 2100 -2186 -2099
		mu 0 4 1090 1091 1136 1135
		f 4 2099 2102 -2188 -2101
		mu 0 4 1091 1092 1137 1136
		f 4 2101 2104 -2190 -2103
		mu 0 4 1092 1093 1138 1137
		f 4 2103 2106 -2192 -2105
		mu 0 4 1093 1094 1139 1138
		f 4 2105 2108 -2194 -2107
		mu 0 4 1094 1095 1140 1139
		f 4 2107 2110 -2196 -2109
		mu 0 4 1095 1096 1141 1140
		f 4 2109 2112 -2198 -2111
		mu 0 4 1096 1097 1142 1141
		f 4 2111 2114 -2200 -2113
		mu 0 4 1097 1098 1143 1142
		f 4 2113 2116 -2202 -2115
		mu 0 4 1098 1099 1144 1143
		f 4 2115 2118 -2204 -2117
		mu 0 4 1099 1100 1145 1144
		f 4 2117 2120 -2206 -2119
		mu 0 4 1100 1101 1146 1145
		f 4 2119 2122 -2208 -2121
		mu 0 4 1101 1102 1147 1146
		f 4 2121 2124 -2210 -2123
		mu 0 4 1102 1103 1148 1147
		f 4 2123 2126 -2212 -2125
		mu 0 4 1103 1104 1149 1148
		f 4 2125 2128 -2214 -2127
		mu 0 4 1104 1105 1150 1149
		f 4 2127 2129 -2216 -2129
		mu 0 4 1105 1106 1151 1150
		f 4 2130 2133 -2219 -2132
		mu 0 4 1107 1108 1153 1152
		f 4 2132 2135 -2221 -2134
		mu 0 4 1108 1109 1154 1153
		f 4 2134 2137 -2223 -2136
		mu 0 4 1109 1110 1155 1154
		f 4 2136 2139 -2225 -2138
		mu 0 4 1110 1111 1156 1155
		f 4 2138 2141 -2227 -2140
		mu 0 4 1111 1112 1157 1156
		f 4 2140 2143 -2229 -2142
		mu 0 4 1112 1113 1158 1157
		f 4 2142 2145 -2231 -2144
		mu 0 4 1113 1114 1159 1158
		f 4 2144 2146 -2233 -2146
		mu 0 4 1114 1115 1160 1159
		f 4 2147 2150 -2236 -2149
		mu 0 4 1116 1117 1162 1161
		f 4 2149 2152 -2238 -2151
		mu 0 4 1117 1118 1163 1162
		f 4 2151 2154 -2240 -2153
		mu 0 4 1118 1119 1164 1163
		f 4 2153 2156 -2242 -2155
		mu 0 4 1119 1120 1165 1164
		f 4 2155 2158 -2244 -2157
		mu 0 4 1120 1121 1166 1165
		f 4 2157 2160 -2246 -2159
		mu 0 4 1121 1122 1167 1166
		f 4 2159 2162 -2248 -2161
		mu 0 4 1122 1123 1168 1167
		f 4 2161 2164 -2250 -2163
		mu 0 4 1123 1124 1169 1168
		f 4 2163 2166 -2252 -2165
		mu 0 4 1124 1125 1170 1169
		f 4 2165 2168 -2254 -2167
		mu 0 4 1125 1126 1171 1170
		f 4 2167 2170 -2256 -2169
		mu 0 4 1126 1127 1172 1171
		f 4 2169 2172 -2258 -2171
		mu 0 4 1127 1128 1173 1172
		f 4 2171 2174 -2260 -2173
		mu 0 4 1128 1129 1174 1173
		f 4 2173 2176 -2262 -2175
		mu 0 4 1129 1130 1175 1174
		f 4 2175 2178 -2264 -2177
		mu 0 4 1130 1131 1176 1175
		f 4 2177 2180 -2266 -2179
		mu 0 4 1131 1132 1177 1176
		f 4 2179 2182 -2268 -2181
		mu 0 4 1132 1133 1178 1177
		f 4 2181 2184 -2270 -2183
		mu 0 4 1133 1134 1179 1178
		f 4 2183 2186 -2272 -2185
		mu 0 4 1134 1135 1180 1179
		f 4 2185 2188 -2274 -2187
		mu 0 4 1135 1136 1181 1180
		f 4 2187 2190 -2276 -2189
		mu 0 4 1136 1137 1182 1181
		f 4 2189 2192 -2278 -2191
		mu 0 4 1137 1138 1183 1182
		f 4 2191 2194 -2280 -2193
		mu 0 4 1138 1139 1184 1183
		f 4 2193 2196 -2282 -2195
		mu 0 4 1139 1140 1185 1184
		f 4 2195 2198 -2284 -2197
		mu 0 4 1140 1141 1186 1185
		f 4 2197 2200 -2286 -2199
		mu 0 4 1141 1142 1187 1186
		f 4 2199 2202 -2288 -2201
		mu 0 4 1142 1143 1188 1187
		f 4 2201 2204 -2290 -2203
		mu 0 4 1143 1144 1189 1188
		f 4 2203 2206 -2292 -2205
		mu 0 4 1144 1145 1190 1189
		f 4 2205 2208 -2294 -2207
		mu 0 4 1145 1146 1191 1190
		f 4 2207 2210 -2296 -2209
		mu 0 4 1146 1147 1192 1191
		f 4 2209 2212 -2298 -2211
		mu 0 4 1147 1148 1193 1192
		f 4 2211 2214 -2300 -2213
		mu 0 4 1148 1149 1194 1193
		f 4 2213 2216 -2302 -2215
		mu 0 4 1149 1150 1195 1194
		f 4 2215 2217 -2304 -2217
		mu 0 4 1150 1151 1196 1195
		f 4 2218 2221 -2307 -2220
		mu 0 4 1152 1153 1198 1197
		f 4 2220 2223 -2309 -2222
		mu 0 4 1153 1154 1199 1198
		f 4 2222 2225 -2311 -2224
		mu 0 4 1154 1155 1200 1199
		f 4 2224 2227 -2313 -2226
		mu 0 4 1155 1156 1201 1200
		f 4 2226 2229 -2315 -2228
		mu 0 4 1156 1157 1202 1201
		f 4 2228 2231 -2317 -2230
		mu 0 4 1157 1158 1203 1202
		f 4 2230 2233 -2319 -2232
		mu 0 4 1158 1159 1204 1203
		f 4 2232 2234 -2321 -2234
		mu 0 4 1159 1160 1205 1204
		f 4 2235 2238 -2324 -2237
		mu 0 4 1161 1162 1207 1206
		f 4 2237 2240 -2326 -2239
		mu 0 4 1162 1163 1208 1207
		f 4 2239 2242 -2328 -2241
		mu 0 4 1163 1164 1209 1208
		f 4 2241 2244 -2330 -2243
		mu 0 4 1164 1165 1210 1209
		f 4 2243 2246 -2332 -2245
		mu 0 4 1165 1166 1211 1210
		f 4 2245 2248 -2334 -2247
		mu 0 4 1166 1167 1212 1211
		f 4 2247 2250 -2336 -2249
		mu 0 4 1167 1168 1213 1212
		f 4 2249 2252 -2338 -2251
		mu 0 4 1168 1169 1214 1213
		f 4 2251 2254 -2340 -2253
		mu 0 4 1169 1170 1215 1214
		f 4 2253 2256 -2342 -2255
		mu 0 4 1170 1171 1216 1215
		f 4 2255 2258 -2344 -2257
		mu 0 4 1171 1172 1217 1216
		f 4 2257 2260 -2346 -2259
		mu 0 4 1172 1173 1218 1217
		f 4 2259 2262 -2348 -2261
		mu 0 4 1173 1174 1219 1218
		f 4 2261 2264 -2350 -2263
		mu 0 4 1174 1175 1220 1219
		f 4 2263 2266 -2352 -2265
		mu 0 4 1175 1176 1221 1220
		f 4 2265 2268 -2354 -2267
		mu 0 4 1176 1177 1222 1221
		f 4 2267 2270 -2356 -2269
		mu 0 4 1177 1178 1223 1222
		f 4 2269 2272 -2358 -2271
		mu 0 4 1178 1179 1224 1223
		f 4 2271 2274 -2360 -2273
		mu 0 4 1179 1180 1225 1224
		f 4 2273 2276 -2362 -2275
		mu 0 4 1180 1181 1226 1225
		f 4 2275 2278 -2364 -2277
		mu 0 4 1181 1182 1227 1226
		f 4 2277 2280 -2366 -2279
		mu 0 4 1182 1183 1228 1227
		f 4 2279 2282 -2368 -2281
		mu 0 4 1183 1184 1229 1228
		f 4 2281 2284 -2370 -2283
		mu 0 4 1184 1185 1230 1229
		f 4 2283 2286 -2372 -2285
		mu 0 4 1185 1186 1231 1230
		f 4 2285 2288 -2374 -2287
		mu 0 4 1186 1187 1232 1231
		f 4 2287 2290 -2376 -2289
		mu 0 4 1187 1188 1233 1232
		f 4 2289 2292 -2378 -2291
		mu 0 4 1188 1189 1234 1233
		f 4 2291 2294 -2380 -2293
		mu 0 4 1189 1190 1235 1234
		f 4 2293 2296 -2382 -2295
		mu 0 4 1190 1191 1236 1235
		f 4 2295 2298 -2384 -2297
		mu 0 4 1191 1192 1237 1236
		f 4 2297 2300 -2386 -2299
		mu 0 4 1192 1193 1238 1237
		f 4 2299 2302 -2388 -2301
		mu 0 4 1193 1194 1239 1238
		f 4 2301 2304 -2390 -2303
		mu 0 4 1194 1195 1240 1239
		f 4 2303 2305 -2392 -2305
		mu 0 4 1195 1196 1241 1240
		f 4 2306 2309 -2395 -2308
		mu 0 4 1197 1198 1243 1242
		f 4 2308 2311 -2397 -2310
		mu 0 4 1198 1199 1244 1243
		f 4 2310 2313 -2399 -2312
		mu 0 4 1199 1200 1245 1244
		f 4 2312 2315 -2401 -2314
		mu 0 4 1200 1201 1246 1245
		f 4 2314 2317 -2403 -2316
		mu 0 4 1201 1202 1247 1246
		f 4 2316 2319 -2405 -2318
		mu 0 4 1202 1203 1248 1247
		f 4 2318 2321 -2407 -2320
		mu 0 4 1203 1204 1249 1248
		f 4 2320 2322 -2409 -2322
		mu 0 4 1204 1205 1250 1249
		f 4 2323 2326 -2412 -2325
		mu 0 4 1206 1207 1252 1251
		f 4 2325 2328 -2414 -2327
		mu 0 4 1207 1208 1253 1252
		f 4 2327 2330 -2416 -2329
		mu 0 4 1208 1209 1254 1253
		f 4 2329 2332 -2418 -2331
		mu 0 4 1209 1210 1255 1254
		f 4 2331 2334 -2420 -2333
		mu 0 4 1210 1211 1256 1255
		f 4 2333 2336 -2422 -2335
		mu 0 4 1211 1212 1257 1256
		f 4 2335 2338 -2424 -2337
		mu 0 4 1212 1213 1258 1257
		f 4 2337 2340 -2426 -2339
		mu 0 4 1213 1214 1259 1258
		f 4 2339 2342 -2428 -2341
		mu 0 4 1214 1215 1260 1259
		f 4 2341 2344 -2430 -2343
		mu 0 4 1215 1216 1261 1260
		f 4 2343 2346 -2432 -2345
		mu 0 4 1216 1217 1262 1261
		f 4 2345 2348 -2434 -2347
		mu 0 4 1217 1218 1263 1262
		f 4 2347 2350 -2436 -2349
		mu 0 4 1218 1219 1264 1263
		f 4 2349 2352 -2438 -2351
		mu 0 4 1219 1220 1265 1264
		f 4 2351 2354 -2440 -2353
		mu 0 4 1220 1221 1266 1265
		f 4 2353 2356 -2442 -2355
		mu 0 4 1221 1222 1267 1266
		f 4 2355 2358 -2444 -2357
		mu 0 4 1222 1223 1268 1267
		f 4 2357 2360 -2446 -2359
		mu 0 4 1223 1224 1269 1268
		f 4 2359 2362 -2448 -2361
		mu 0 4 1224 1225 1270 1269
		f 4 2361 2364 -2450 -2363
		mu 0 4 1225 1226 1271 1270
		f 4 2363 2366 -2452 -2365
		mu 0 4 1226 1227 1272 1271
		f 4 2365 2368 -2454 -2367
		mu 0 4 1227 1228 1273 1272
		f 4 2367 2370 -2456 -2369
		mu 0 4 1228 1229 1274 1273
		f 4 2369 2372 -2458 -2371
		mu 0 4 1229 1230 1275 1274
		f 4 2371 2374 -2460 -2373
		mu 0 4 1230 1231 1276 1275
		f 4 2373 2376 -2462 -2375
		mu 0 4 1231 1232 1277 1276
		f 4 2375 2378 -2464 -2377
		mu 0 4 1232 1233 1278 1277
		f 4 2377 2380 -2466 -2379
		mu 0 4 1233 1234 1279 1278
		f 4 2379 2382 -2468 -2381
		mu 0 4 1234 1235 1280 1279
		f 4 2381 2384 -2470 -2383
		mu 0 4 1235 1236 1281 1280
		f 4 2383 2386 -2472 -2385
		mu 0 4 1236 1237 1282 1281
		f 4 2385 2388 -2474 -2387
		mu 0 4 1237 1238 1283 1282
		f 4 2387 2390 -2476 -2389
		mu 0 4 1238 1239 1284 1283
		f 4 2389 2392 -2478 -2391
		mu 0 4 1239 1240 1285 1284
		f 4 2391 2393 -2480 -2393
		mu 0 4 1240 1241 1286 1285
		f 4 2394 2397 -2483 -2396
		mu 0 4 1242 1243 1288 1287
		f 4 2396 2399 -2485 -2398
		mu 0 4 1243 1244 1289 1288
		f 4 2398 2401 -2487 -2400
		mu 0 4 1244 1245 1290 1289
		f 4 2400 2403 -2489 -2402
		mu 0 4 1245 1246 1291 1290
		f 4 2402 2405 -2491 -2404
		mu 0 4 1246 1247 1292 1291
		f 4 2404 2407 -2493 -2406
		mu 0 4 1247 1248 1293 1292
		f 4 2406 2409 -2495 -2408
		mu 0 4 1248 1249 1294 1293
		f 4 2408 2410 -2497 -2410
		mu 0 4 1249 1250 1295 1294
		f 4 2411 2414 -2500 -2413
		mu 0 4 1251 1252 1297 1296
		f 4 2413 2416 -2502 -2415
		mu 0 4 1252 1253 1298 1297
		f 4 2415 2418 -2504 -2417
		mu 0 4 1253 1254 1299 1298
		f 4 2417 2420 -2506 -2419
		mu 0 4 1254 1255 1300 1299
		f 4 2419 2422 -2508 -2421
		mu 0 4 1255 1256 1301 1300
		f 4 2421 2424 -2510 -2423
		mu 0 4 1256 1257 1302 1301
		f 4 2423 2426 -2512 -2425
		mu 0 4 1257 1258 1303 1302
		f 4 2425 2428 -2514 -2427
		mu 0 4 1258 1259 1304 1303
		f 4 2427 2430 -2516 -2429
		mu 0 4 1259 1260 1305 1304
		f 4 2429 2432 -2518 -2431
		mu 0 4 1260 1261 1306 1305
		f 4 2431 2434 -2520 -2433
		mu 0 4 1261 1262 1307 1306
		f 4 2433 2436 -2522 -2435
		mu 0 4 1262 1263 1308 1307
		f 4 2435 2438 -2524 -2437
		mu 0 4 1263 1264 1309 1308
		f 4 2437 2440 -2525 -2439
		mu 0 4 1264 1265 1310 1309
		f 4 2439 2442 -2526 -2441
		mu 0 4 1265 1266 1311 1310
		f 4 2441 2444 -2527 -2443
		mu 0 4 1266 1267 1312 1311
		f 4 2443 2446 -2528 -2445
		mu 0 4 1267 1268 1313 1312
		f 4 2445 2448 -2529 -2447
		mu 0 4 1268 1269 1314 1313
		f 4 2447 2450 -2530 -2449
		mu 0 4 1269 1270 1315 1314
		f 4 2449 2452 -2531 -2451
		mu 0 4 1270 1271 1316 1315
		f 4 2451 2454 -2532 -2453
		mu 0 4 1271 1272 1317 1316
		f 4 2453 2456 -2533 -2455
		mu 0 4 1272 1273 1318 1317
		f 4 2455 2458 -2534 -2457
		mu 0 4 1273 1274 1319 1318
		f 4 2457 2460 -2535 -2459
		mu 0 4 1274 1275 1320 1319
		f 4 2459 2462 -2536 -2461
		mu 0 4 1275 1276 1321 1320
		f 4 2461 2464 -2537 -2463
		mu 0 4 1276 1277 1322 1321
		f 4 2463 2466 -2538 -2465
		mu 0 4 1277 1278 1323 1322
		f 4 2465 2468 -2539 -2467
		mu 0 4 1278 1279 1324 1323
		f 4 2467 2470 -2540 -2469
		mu 0 4 1279 1280 1325 1324
		f 4 2469 2472 -2542 -2471
		mu 0 4 1280 1281 1326 1325
		f 4 2471 2474 -2544 -2473
		mu 0 4 1281 1282 1327 1326
		f 4 2473 2476 -2546 -2475
		mu 0 4 1282 1283 1328 1327
		f 4 2475 2478 -2548 -2477
		mu 0 4 1283 1284 1329 1328
		f 4 2477 2480 -2550 -2479
		mu 0 4 1284 1285 1330 1329
		f 4 2479 2481 -2552 -2481
		mu 0 4 1285 1286 1331 1330
		f 4 2482 2485 -2555 -2484
		mu 0 4 1287 1288 1333 1332
		f 4 2484 2487 -2557 -2486
		mu 0 4 1288 1289 1334 1333
		f 4 2486 2489 -2559 -2488
		mu 0 4 1289 1290 1335 1334
		f 4 2488 2491 -2561 -2490
		mu 0 4 1290 1291 1336 1335
		f 4 2490 2493 -2563 -2492
		mu 0 4 1291 1292 1337 1336
		f 4 2492 2495 -2565 -2494
		mu 0 4 1292 1293 1338 1337
		f 4 2494 2497 -2567 -2496
		mu 0 4 1293 1294 1339 1338
		f 4 2496 2498 -2569 -2498
		mu 0 4 1294 1295 1340 1339
		f 4 2499 2502 -2572 -2501
		mu 0 4 1296 1297 1342 1341
		f 4 2501 2504 -2574 -2503
		mu 0 4 1297 1298 1343 1342
		f 4 2503 2506 -2576 -2505
		mu 0 4 1298 1299 1344 1343
		f 4 2505 2508 -2578 -2507
		mu 0 4 1299 1300 1345 1344
		f 4 2507 2510 -2580 -2509
		mu 0 4 1300 1301 1346 1345
		f 4 2509 2512 -2582 -2511
		mu 0 4 1301 1302 1347 1346
		f 4 2511 2514 -2584 -2513
		mu 0 4 1302 1303 1348 1347
		f 4 2513 2516 -2586 -2515
		mu 0 4 1303 1304 1349 1348
		f 4 2515 2518 -2588 -2517
		mu 0 4 1304 1305 1350 1349
		f 4 2517 2520 -2590 -2519
		mu 0 4 1305 1306 1351 1350
		f 4 2519 2522 -2592 -2521
		mu 0 4 1306 1307 1352 1351
		f 4 2539 2542 -2595 -2541
		mu 0 4 1324 1325 1354 1353
		f 4 2541 2544 -2597 -2543
		mu 0 4 1325 1326 1355 1354
		f 4 2543 2546 -2599 -2545
		mu 0 4 1326 1327 1356 1355
		f 4 2545 2548 -2601 -2547
		mu 0 4 1327 1328 1357 1356
		f 4 2547 2550 -2603 -2549
		mu 0 4 1328 1329 1358 1357
		f 4 2549 2552 -2605 -2551
		mu 0 4 1329 1330 1359 1358
		f 4 2551 2553 -2607 -2553
		mu 0 4 1330 1331 1360 1359
		f 4 2554 2557 -2610 -2556
		mu 0 4 1332 1333 1362 1361
		f 4 2556 2559 -2612 -2558
		mu 0 4 1333 1334 1363 1362
		f 4 2558 2561 -2614 -2560
		mu 0 4 1334 1335 1364 1363
		f 4 2560 2563 -2616 -2562
		mu 0 4 1335 1336 1365 1364
		f 4 2562 2565 -2618 -2564
		mu 0 4 1336 1337 1366 1365
		f 4 2564 2567 -2620 -2566
		mu 0 4 1337 1338 1367 1366
		f 4 2566 2569 -2622 -2568
		mu 0 4 1338 1339 1368 1367
		f 4 2568 2570 -2624 -2570
		mu 0 4 1339 1340 1369 1368
		f 4 2571 2574 -2627 -2573
		mu 0 4 1341 1342 1371 1370
		f 4 2573 2576 -2629 -2575
		mu 0 4 1342 1343 1372 1371
		f 4 2575 2578 -2631 -2577
		mu 0 4 1343 1344 1373 1372
		f 4 2577 2580 -2633 -2579
		mu 0 4 1344 1345 1374 1373
		f 4 2579 2582 -2635 -2581
		mu 0 4 1345 1346 1375 1374
		f 4 2581 2584 -2637 -2583
		mu 0 4 1346 1347 1376 1375
		f 4 2583 2586 -2639 -2585
		mu 0 4 1347 1348 1377 1376
		f 4 2585 2588 -2641 -2587
		mu 0 4 1348 1349 1378 1377
		f 4 2587 2590 -2643 -2589
		mu 0 4 1349 1350 1379 1378
		f 4 2589 2592 -2645 -2591
		mu 0 4 1350 1351 1380 1379
		f 4 2591 2593 -2647 -2593
		mu 0 4 1351 1352 1381 1380
		f 4 2594 2597 -2650 -2596
		mu 0 4 1353 1354 1383 1382
		f 4 2596 2599 -2652 -2598
		mu 0 4 1354 1355 1384 1383
		f 4 2598 2601 -2654 -2600
		mu 0 4 1355 1356 1385 1384
		f 4 2600 2603 -2656 -2602
		mu 0 4 1356 1357 1386 1385
		f 4 2602 2605 -2658 -2604
		mu 0 4 1357 1358 1387 1386
		f 4 2604 2607 -2660 -2606
		mu 0 4 1358 1359 1388 1387
		f 4 2606 2608 -2662 -2608
		mu 0 4 1359 1360 1389 1388
		f 4 2609 2612 -2665 -2611
		mu 0 4 1361 1362 1391 1390
		f 4 2611 2614 -2667 -2613
		mu 0 4 1362 1363 1392 1391
		f 4 2613 2616 -2669 -2615
		mu 0 4 1363 1364 1393 1392
		f 4 2615 2618 -2671 -2617
		mu 0 4 1364 1365 1394 1393
		f 4 2617 2620 -2673 -2619
		mu 0 4 1365 1366 1395 1394
		f 4 2619 2622 -2675 -2621
		mu 0 4 1366 1367 1396 1395
		f 4 2621 2624 -2677 -2623
		mu 0 4 1367 1368 1397 1396
		f 4 2623 2625 -2679 -2625
		mu 0 4 1368 1369 1398 1397
		f 4 2626 2629 -2682 -2628
		mu 0 4 1370 1371 1400 1399
		f 4 2628 2631 -2684 -2630
		mu 0 4 1371 1372 1401 1400
		f 4 2630 2633 -2686 -2632
		mu 0 4 1372 1373 1402 1401
		f 4 2632 2635 -2688 -2634
		mu 0 4 1373 1374 1403 1402
		f 4 2634 2637 -2690 -2636
		mu 0 4 1374 1375 1404 1403
		f 4 2636 2639 -2692 -2638
		mu 0 4 1375 1376 1405 1404
		f 4 2638 2641 -2694 -2640
		mu 0 4 1376 1377 1406 1405
		f 4 2640 2643 -2696 -2642
		mu 0 4 1377 1378 1407 1406
		f 4 2642 2645 -2698 -2644
		mu 0 4 1378 1379 1408 1407
		f 4 2644 2647 -2700 -2646
		mu 0 4 1379 1380 1409 1408
		f 4 2646 2648 -2702 -2648
		mu 0 4 1380 1381 1410 1409
		f 4 2649 2652 -2705 -2651
		mu 0 4 1382 1383 1412 1411
		f 4 2651 2654 -2707 -2653
		mu 0 4 1383 1384 1413 1412
		f 4 2653 2656 -2709 -2655
		mu 0 4 1384 1385 1414 1413
		f 4 2655 2658 -2711 -2657
		mu 0 4 1385 1386 1415 1414
		f 4 2657 2660 -2713 -2659
		mu 0 4 1386 1387 1416 1415
		f 4 2659 2662 -2715 -2661
		mu 0 4 1387 1388 1417 1416
		f 4 2661 2663 -2717 -2663
		mu 0 4 1388 1389 1418 1417
		f 4 2664 2667 -2720 -2666
		mu 0 4 1390 1391 1420 1419
		f 4 2666 2669 -2722 -2668
		mu 0 4 1391 1392 1421 1420
		f 4 2668 2671 -2724 -2670
		mu 0 4 1392 1393 1422 1421
		f 4 2670 2673 -2726 -2672
		mu 0 4 1393 1394 1423 1422
		f 4 2672 2675 -2728 -2674
		mu 0 4 1394 1395 1424 1423
		f 4 2674 2677 -2730 -2676
		mu 0 4 1395 1396 1425 1424
		f 4 2676 2679 -2732 -2678
		mu 0 4 1396 1397 1426 1425
		f 4 2678 2680 -2734 -2680
		mu 0 4 1397 1398 1427 1426
		f 4 2681 2684 -2737 -2683
		mu 0 4 1399 1400 1429 1428
		f 4 2683 2686 -2739 -2685
		mu 0 4 1400 1401 1430 1429
		f 4 2685 2688 -2741 -2687
		mu 0 4 1401 1402 1431 1430
		f 4 2687 2690 -2743 -2689
		mu 0 4 1402 1403 1432 1431
		f 4 2689 2692 -2745 -2691
		mu 0 4 1403 1404 1433 1432
		f 4 2691 2694 -2747 -2693
		mu 0 4 1404 1405 1434 1433
		f 4 2693 2696 -2749 -2695
		mu 0 4 1405 1406 1435 1434
		f 4 2695 2698 -2751 -2697
		mu 0 4 1406 1407 1436 1435
		f 4 2697 2700 -2753 -2699
		mu 0 4 1407 1408 1437 1436
		f 4 2699 2702 -2755 -2701
		mu 0 4 1408 1409 1438 1437
		f 4 2701 2703 -2757 -2703
		mu 0 4 1409 1410 1439 1438
		f 4 2704 2707 -2760 -2706
		mu 0 4 1411 1412 1441 1440
		f 4 2706 2709 -2762 -2708
		mu 0 4 1412 1413 1442 1441
		f 4 2708 2711 -2764 -2710
		mu 0 4 1413 1414 1443 1442
		f 4 2710 2713 -2766 -2712
		mu 0 4 1414 1415 1444 1443
		f 4 2712 2715 -2768 -2714
		mu 0 4 1415 1416 1445 1444
		f 4 2714 2717 -2770 -2716
		mu 0 4 1416 1417 1446 1445
		f 4 2716 2718 -2772 -2718
		mu 0 4 1417 1418 1447 1446
		f 4 2719 2722 -2775 -2721
		mu 0 4 1419 1420 1449 1448
		f 4 2721 2724 -2777 -2723
		mu 0 4 1420 1421 1450 1449
		f 4 2723 2726 -2779 -2725
		mu 0 4 1421 1422 1451 1450
		f 4 2725 2728 -2781 -2727
		mu 0 4 1422 1423 1452 1451
		f 4 2727 2730 -2783 -2729
		mu 0 4 1423 1424 1453 1452
		f 4 2729 2732 -2785 -2731
		mu 0 4 1424 1425 1454 1453
		f 4 2731 2734 -2787 -2733
		mu 0 4 1425 1426 1455 1454
		f 4 2733 2735 -2789 -2735
		mu 0 4 1426 1427 1456 1455
		f 4 2736 2739 -2792 -2738
		mu 0 4 1428 1429 1458 1457
		f 4 2738 2741 -2794 -2740
		mu 0 4 1429 1430 1459 1458
		f 4 2740 2743 -2796 -2742
		mu 0 4 1430 1431 1460 1459
		f 4 2742 2745 -2798 -2744
		mu 0 4 1431 1432 1461 1460
		f 4 2744 2747 -2800 -2746
		mu 0 4 1432 1433 1462 1461
		f 4 2746 2749 -2802 -2748
		mu 0 4 1433 1434 1463 1462
		f 4 2748 2751 -2804 -2750
		mu 0 4 1434 1435 1464 1463
		f 4 2750 2753 -2806 -2752
		mu 0 4 1435 1436 1465 1464
		f 4 2752 2755 -2808 -2754
		mu 0 4 1436 1437 1466 1465
		f 4 2754 2757 -2810 -2756
		mu 0 4 1437 1438 1467 1466
		f 4 2756 2758 -2812 -2758
		mu 0 4 1438 1439 1468 1467
		f 4 2759 2762 -2815 -2761
		mu 0 4 1440 1441 1470 1469
		f 4 2761 2764 -2817 -2763
		mu 0 4 1441 1442 1471 1470
		f 4 2763 2766 -2819 -2765
		mu 0 4 1442 1443 1472 1471
		f 4 2765 2768 -2821 -2767
		mu 0 4 1443 1444 1473 1472
		f 4 2767 2770 -2823 -2769
		mu 0 4 1444 1445 1474 1473
		f 4 2769 2772 -2825 -2771
		mu 0 4 1445 1446 1475 1474
		f 4 2771 2773 -2827 -2773
		mu 0 4 1446 1447 1476 1475
		f 4 2774 2777 -2830 -2776
		mu 0 4 1448 1449 1478 1477
		f 4 2776 2779 -2832 -2778
		mu 0 4 1449 1450 1479 1478
		f 4 2778 2781 -2834 -2780
		mu 0 4 1450 1451 1480 1479
		f 4 2780 2783 -2836 -2782
		mu 0 4 1451 1452 1481 1480
		f 4 2782 2785 -2838 -2784
		mu 0 4 1452 1453 1482 1481
		f 4 2784 2787 -2840 -2786
		mu 0 4 1453 1454 1483 1482
		f 4 2786 2789 -2842 -2788
		mu 0 4 1454 1455 1484 1483
		f 4 2788 2790 -2844 -2790
		mu 0 4 1455 1456 1485 1484
		f 4 2791 2794 -2847 -2793
		mu 0 4 1457 1458 1487 1486
		f 4 2793 2796 -2849 -2795
		mu 0 4 1458 1459 1488 1487
		f 4 2795 2798 -2851 -2797
		mu 0 4 1459 1460 1489 1488
		f 4 2797 2800 -2853 -2799
		mu 0 4 1460 1461 1490 1489
		f 4 2799 2802 -2855 -2801
		mu 0 4 1461 1462 1491 1490
		f 4 2801 2804 -2857 -2803
		mu 0 4 1462 1463 1492 1491
		f 4 2803 2806 -2859 -2805
		mu 0 4 1463 1464 1493 1492
		f 4 2805 2808 -2861 -2807
		mu 0 4 1464 1465 1494 1493
		f 4 2807 2810 -2863 -2809
		mu 0 4 1465 1466 1495 1494
		f 4 2809 2812 -2865 -2811
		mu 0 4 1466 1467 1496 1495
		f 4 2811 2813 -2867 -2813
		mu 0 4 1467 1468 1497 1496
		f 4 2814 2817 -2870 -2816
		mu 0 4 1469 1470 1499 1498
		f 4 2816 2819 -2872 -2818
		mu 0 4 1470 1471 1500 1499
		f 4 2818 2821 -2874 -2820
		mu 0 4 1471 1472 1501 1500
		f 4 2820 2823 -2876 -2822
		mu 0 4 1472 1473 1502 1501
		f 4 2822 2825 -2878 -2824
		mu 0 4 1473 1474 1503 1502
		f 4 2824 2827 -2880 -2826
		mu 0 4 1474 1475 1504 1503
		f 4 2826 2828 -2882 -2828
		mu 0 4 1475 1476 1505 1504
		f 4 2829 2832 -2898 -2831
		mu 0 4 1477 1478 1513 1512
		f 4 2831 2834 -2900 -2833
		mu 0 4 1478 1479 1514 1513
		f 4 2833 2836 -2902 -2835
		mu 0 4 1479 1480 1515 1514
		f 4 2835 2838 -2904 -2837
		mu 0 4 1480 1481 1516 1515
		f 4 2837 2840 -2906 -2839
		mu 0 4 1481 1482 1517 1516
		f 4 2839 2842 -2908 -2841
		mu 0 4 1482 1483 1518 1517
		f 4 2841 2844 -2910 -2843
		mu 0 4 1483 1484 1519 1518
		f 4 2843 2845 -2912 -2845
		mu 0 4 1484 1485 1520 1519
		f 4 2846 2849 -2915 -2848
		mu 0 4 1486 1487 1522 1521
		f 4 2848 2851 -2917 -2850
		mu 0 4 1487 1488 1523 1522
		f 4 2850 2853 -2919 -2852
		mu 0 4 1488 1489 1524 1523
		f 4 2852 2855 -2921 -2854
		mu 0 4 1489 1490 1525 1524
		f 4 2854 2857 -2923 -2856
		mu 0 4 1490 1491 1526 1525
		f 4 2856 2859 -2925 -2858
		mu 0 4 1491 1492 1527 1526
		f 4 2858 2861 -2927 -2860
		mu 0 4 1492 1493 1528 1527
		f 4 2860 2863 -2929 -2862
		mu 0 4 1493 1494 1529 1528
		f 4 2862 2865 -2931 -2864
		mu 0 4 1494 1495 1530 1529
		f 4 2864 2867 -2933 -2866
		mu 0 4 1495 1496 1531 1530
		f 4 2866 2868 -2935 -2868
		mu 0 4 1496 1497 1532 1531
		f 4 2869 2872 -2971 -2871
		mu 0 4 1498 1499 1550 1549
		f 4 2871 2874 -2973 -2873
		mu 0 4 1499 1500 1551 1550
		f 4 2873 2876 -2975 -2875
		mu 0 4 1500 1501 1552 1551
		f 4 2875 2878 -2977 -2877
		mu 0 4 1501 1502 1553 1552
		f 4 2877 2880 -2979 -2879
		mu 0 4 1502 1503 1554 1553
		f 4 2879 2882 -2981 -2881
		mu 0 4 1503 1504 1555 1554
		f 4 2881 2884 -2983 -2883
		mu 0 4 1504 1505 1556 1555
		f 4 2883 2886 -2985 -2885
		mu 0 4 1505 1506 1557 1556
		f 4 2885 2888 -2987 -2887
		mu 0 4 1506 1507 1558 1557
		f 4 2887 2890 -2989 -2889
		mu 0 4 1507 1508 1559 1558
		f 4 2889 2892 -2991 -2891
		mu 0 4 1508 1509 1560 1559
		f 4 2891 2894 -2993 -2893
		mu 0 4 1509 1510 1561 1560
		f 4 2893 2896 -2995 -2895
		mu 0 4 1510 1511 1562 1561
		f 4 2895 2898 -2997 -2897
		mu 0 4 1511 1512 1563 1562
		f 4 2897 2900 -2999 -2899
		mu 0 4 1512 1513 1564 1563
		f 4 2899 2902 -3001 -2901
		mu 0 4 1513 1514 1565 1564
		f 4 2901 2904 -3003 -2903
		mu 0 4 1514 1515 1566 1565
		f 4 2903 2906 -3005 -2905
		mu 0 4 1515 1516 1567 1566
		f 4 2905 2908 -3007 -2907
		mu 0 4 1516 1517 1568 1567
		f 4 2907 2910 -3009 -2909
		mu 0 4 1517 1518 1569 1568
		f 4 2909 2912 -3011 -2911
		mu 0 4 1518 1519 1570 1569
		f 4 2911 2913 -3013 -2913
		mu 0 4 1519 1520 1571 1570
		f 4 2914 2917 -3016 -2916
		mu 0 4 1521 1522 1573 1572
		f 4 2916 2919 -3018 -2918
		mu 0 4 1522 1523 1574 1573
		f 4 2918 2921 -3020 -2920
		mu 0 4 1523 1524 1575 1574
		f 4 2920 2923 -3022 -2922
		mu 0 4 1524 1525 1576 1575
		f 4 2922 2925 -3024 -2924
		mu 0 4 1525 1526 1577 1576
		f 4 2924 2927 -3026 -2926
		mu 0 4 1526 1527 1578 1577
		f 4 2926 2929 -3028 -2928
		mu 0 4 1527 1528 1579 1578
		f 4 2928 2931 -3030 -2930
		mu 0 4 1528 1529 1580 1579
		f 4 2930 2933 -3032 -2932
		mu 0 4 1529 1530 1581 1580
		f 4 2932 2935 -3034 -2934
		mu 0 4 1530 1531 1582 1581
		f 4 2934 2937 -3036 -2936
		mu 0 4 1531 1532 1583 1582
		f 4 2936 2939 -3038 -2938
		mu 0 4 1532 1533 1584 1583
		f 4 2938 2941 -3040 -2940
		mu 0 4 1533 1534 1585 1584
		f 4 2940 2943 -3042 -2942
		mu 0 4 1534 1535 1586 1585
		f 4 2942 2945 -3044 -2944
		mu 0 4 1535 1536 1587 1586
		f 4 2944 2947 -3046 -2946
		mu 0 4 1536 1537 1588 1587
		f 4 2946 2949 -3048 -2948
		mu 0 4 1537 1538 1589 1588
		f 4 2948 2951 -3050 -2950
		mu 0 4 1538 1539 1590 1589
		f 4 2950 2953 -3052 -2952
		mu 0 4 1539 1540 1591 1590
		f 4 2952 2955 -3054 -2954
		mu 0 4 1540 1541 1592 1591
		f 4 2954 2957 -3056 -2956
		mu 0 4 1541 1542 1593 1592
		f 4 2956 2959 -3058 -2958
		mu 0 4 1542 1543 1594 1593
		f 4 2958 2961 -3060 -2960
		mu 0 4 1543 1544 1595 1594
		f 4 2960 2963 -3062 -2962
		mu 0 4 1544 1545 1596 1595
		f 4 2962 2965 -3064 -2964
		mu 0 4 1545 1546 1597 1596
		f 4 2964 2967 -3066 -2966
		mu 0 4 1546 1547 1598 1597
		f 4 2966 2969 -3068 -2968
		mu 0 4 1547 1548 1599 1598
		f 4 2968 2971 -3070 -2970
		mu 0 4 1548 1549 1600 1599
		f 4 2970 2973 -3072 -2972
		mu 0 4 1549 1550 1601 1600
		f 4 2972 2975 -3074 -2974
		mu 0 4 1550 1551 1602 1601
		f 4 2974 2977 -3076 -2976
		mu 0 4 1551 1552 1603 1602
		f 4 2976 2979 -3078 -2978
		mu 0 4 1552 1553 1604 1603
		f 4 2978 2981 -3080 -2980
		mu 0 4 1553 1554 1605 1604
		f 4 2980 2983 -3082 -2982
		mu 0 4 1554 1555 1606 1605
		f 4 2982 2985 -3084 -2984
		mu 0 4 1555 1556 1607 1606
		f 4 2984 2987 -3086 -2986
		mu 0 4 1556 1557 1608 1607
		f 4 2986 2989 -3088 -2988
		mu 0 4 1557 1558 1609 1608
		f 4 2988 2991 -3090 -2990
		mu 0 4 1558 1559 1610 1609
		f 4 2990 2993 -3092 -2992
		mu 0 4 1559 1560 1611 1610
		f 4 2992 2995 -3094 -2994
		mu 0 4 1560 1561 1612 1611
		f 4 2994 2997 -3096 -2996
		mu 0 4 1561 1562 1613 1612
		f 4 2996 2999 -3098 -2998
		mu 0 4 1562 1563 1614 1613
		f 4 2998 3001 -3100 -3000
		mu 0 4 1563 1564 1615 1614
		f 4 3000 3003 -3102 -3002
		mu 0 4 1564 1565 1616 1615
		f 4 3002 3005 -3104 -3004
		mu 0 4 1565 1566 1617 1616
		f 4 3004 3007 -3106 -3006
		mu 0 4 1566 1567 1618 1617
		f 4 3006 3009 -3108 -3008
		mu 0 4 1567 1568 1619 1618
		f 4 3008 3011 -3110 -3010
		mu 0 4 1568 1569 1620 1619
		f 4 3010 3013 -3112 -3012
		mu 0 4 1569 1570 1621 1620
		f 4 3012 3014 -3114 -3014
		mu 0 4 1570 1571 1622 1621
		f 4 3015 3018 -3117 -3017
		mu 0 4 1572 1573 1624 1623
		f 4 3017 3020 -3119 -3019
		mu 0 4 1573 1574 1625 1624
		f 4 3019 3022 -3121 -3021
		mu 0 4 1574 1575 1626 1625
		f 4 3021 3024 -3123 -3023
		mu 0 4 1575 1576 1627 1626
		f 4 3023 3026 -3125 -3025
		mu 0 4 1576 1577 1628 1627
		f 4 3025 3028 -3127 -3027
		mu 0 4 1577 1578 1629 1628
		f 4 3027 3030 -3129 -3029
		mu 0 4 1578 1579 1630 1629
		f 4 3029 3032 -3131 -3031
		mu 0 4 1579 1580 1631 1630
		f 4 3031 3034 -3133 -3033
		mu 0 4 1580 1581 1632 1631
		f 4 3033 3036 -3135 -3035
		mu 0 4 1581 1582 1633 1632
		f 4 3035 3038 -3137 -3037
		mu 0 4 1582 1583 1634 1633
		f 4 3037 3040 -3139 -3039
		mu 0 4 1583 1584 1635 1634
		f 4 3039 3042 -3141 -3041
		mu 0 4 1584 1585 1636 1635
		f 4 3041 3044 -3143 -3043
		mu 0 4 1585 1586 1637 1636
		f 4 3043 3046 -3145 -3045
		mu 0 4 1586 1587 1638 1637
		f 4 3045 3048 -3147 -3047
		mu 0 4 1587 1588 1639 1638
		f 4 3047 3050 -3149 -3049
		mu 0 4 1588 1589 1640 1639
		f 4 3049 3052 -3151 -3051
		mu 0 4 1589 1590 1641 1640
		f 4 3051 3054 -3153 -3053
		mu 0 4 1590 1591 1642 1641
		f 4 3053 3056 -3155 -3055
		mu 0 4 1591 1592 1643 1642
		f 4 3055 3058 -3157 -3057
		mu 0 4 1592 1593 1644 1643
		f 4 3057 3060 -3159 -3059
		mu 0 4 1593 1594 1645 1644
		f 4 3059 3062 -3161 -3061
		mu 0 4 1594 1595 1646 1645
		f 4 3061 3064 -3163 -3063
		mu 0 4 1595 1596 1647 1646
		f 4 3063 3066 -3165 -3065
		mu 0 4 1596 1597 1648 1647
		f 4 3065 3068 -3167 -3067
		mu 0 4 1597 1598 1649 1648
		f 4 3067 3070 -3169 -3069
		mu 0 4 1598 1599 1650 1649
		f 4 3069 3072 -3171 -3071
		mu 0 4 1599 1600 1651 1650
		f 4 3071 3074 -3173 -3073
		mu 0 4 1600 1601 1652 1651
		f 4 3073 3076 -3175 -3075
		mu 0 4 1601 1602 1653 1652
		f 4 3075 3078 -3177 -3077
		mu 0 4 1602 1603 1654 1653
		f 4 3077 3080 -3179 -3079
		mu 0 4 1603 1604 1655 1654
		f 4 3079 3082 -3181 -3081
		mu 0 4 1604 1605 1656 1655
		f 4 3081 3084 -3183 -3083
		mu 0 4 1605 1606 1657 1656
		f 4 3083 3086 -3185 -3085
		mu 0 4 1606 1607 1658 1657
		f 4 3085 3088 -3187 -3087
		mu 0 4 1607 1608 1659 1658
		f 4 3087 3090 -3189 -3089
		mu 0 4 1608 1609 1660 1659
		f 4 3089 3092 -3191 -3091
		mu 0 4 1609 1610 1661 1660
		f 4 3091 3094 -3193 -3093
		mu 0 4 1610 1611 1662 1661
		f 4 3093 3096 -3195 -3095
		mu 0 4 1611 1612 1663 1662
		f 4 3095 3098 -3197 -3097
		mu 0 4 1612 1613 1664 1663
		f 4 3097 3100 -3199 -3099
		mu 0 4 1613 1614 1665 1664
		f 4 3099 3102 -3201 -3101
		mu 0 4 1614 1615 1666 1665
		f 4 3101 3104 -3203 -3103
		mu 0 4 1615 1616 1667 1666
		f 4 3103 3106 -3205 -3105
		mu 0 4 1616 1617 1668 1667
		f 4 3105 3108 -3207 -3107
		mu 0 4 1617 1618 1669 1668
		f 4 3107 3110 -3209 -3109
		mu 0 4 1618 1619 1670 1669
		f 4 3109 3112 -3211 -3111
		mu 0 4 1619 1620 1671 1670
		f 4 3111 3114 -3213 -3113
		mu 0 4 1620 1621 1672 1671
		f 4 3113 3115 -3215 -3115
		mu 0 4 1621 1622 1673 1672
		f 4 3116 3119 -3218 -3118
		mu 0 4 1623 1624 1675 1674
		f 4 3118 3121 -3220 -3120
		mu 0 4 1624 1625 1676 1675
		f 4 3120 3123 -3222 -3122
		mu 0 4 1625 1626 1677 1676
		f 4 3122 3125 -3224 -3124
		mu 0 4 1626 1627 1678 1677
		f 4 3124 3127 -3226 -3126
		mu 0 4 1627 1628 1679 1678
		f 4 3126 3129 -3228 -3128
		mu 0 4 1628 1629 1680 1679
		f 4 3128 3131 -3230 -3130
		mu 0 4 1629 1630 1681 1680
		f 4 3130 3133 -3232 -3132
		mu 0 4 1630 1631 1682 1681
		f 4 3132 3135 -3234 -3134
		mu 0 4 1631 1632 1683 1682
		f 4 3134 3137 -3236 -3136
		mu 0 4 1632 1633 1684 1683
		f 4 3136 3139 -3238 -3138
		mu 0 4 1633 1634 1685 1684;
	setAttr ".fc[1500:1873]"
		f 4 3138 3141 -3240 -3140
		mu 0 4 1634 1635 1686 1685
		f 4 3140 3143 -3242 -3142
		mu 0 4 1635 1636 1687 1686
		f 4 3142 3145 -3244 -3144
		mu 0 4 1636 1637 1688 1687
		f 4 3144 3147 -3246 -3146
		mu 0 4 1637 1638 1689 1688
		f 4 3146 3149 -3248 -3148
		mu 0 4 1638 1639 1690 1689
		f 4 3148 3151 -3250 -3150
		mu 0 4 1639 1640 1691 1690
		f 4 3150 3153 -3252 -3152
		mu 0 4 1640 1641 1692 1691
		f 4 3152 3155 -3254 -3154
		mu 0 4 1641 1642 1693 1692
		f 4 3154 3157 -3256 -3156
		mu 0 4 1642 1643 1694 1693
		f 4 3156 3159 -3258 -3158
		mu 0 4 1643 1644 1695 1694
		f 4 3158 3161 -3260 -3160
		mu 0 4 1644 1645 1696 1695
		f 4 3160 3163 -3262 -3162
		mu 0 4 1645 1646 1697 1696
		f 4 3162 3165 -3264 -3164
		mu 0 4 1646 1647 1698 1697
		f 4 3164 3167 -3266 -3166
		mu 0 4 1647 1648 1699 1698
		f 4 3166 3169 -3268 -3168
		mu 0 4 1648 1649 1700 1699
		f 4 3168 3171 -3270 -3170
		mu 0 4 1649 1650 1701 1700
		f 4 3170 3173 -3272 -3172
		mu 0 4 1650 1651 1702 1701
		f 4 3172 3175 -3274 -3174
		mu 0 4 1651 1652 1703 1702
		f 4 3174 3177 -3276 -3176
		mu 0 4 1652 1653 1704 1703
		f 4 3176 3179 -3278 -3178
		mu 0 4 1653 1654 1705 1704
		f 4 3178 3181 -3280 -3180
		mu 0 4 1654 1655 1706 1705
		f 4 3180 3183 -3282 -3182
		mu 0 4 1655 1656 1707 1706
		f 4 3182 3185 -3284 -3184
		mu 0 4 1656 1657 1708 1707
		f 4 3184 3187 -3286 -3186
		mu 0 4 1657 1658 1709 1708
		f 4 3186 3189 -3288 -3188
		mu 0 4 1658 1659 1710 1709
		f 4 3188 3191 -3290 -3190
		mu 0 4 1659 1660 1711 1710
		f 4 3190 3193 -3292 -3192
		mu 0 4 1660 1661 1712 1711
		f 4 3192 3195 -3294 -3194
		mu 0 4 1661 1662 1713 1712
		f 4 3194 3197 -3296 -3196
		mu 0 4 1662 1663 1714 1713
		f 4 3196 3199 -3298 -3198
		mu 0 4 1663 1664 1715 1714
		f 4 3198 3201 -3300 -3200
		mu 0 4 1664 1665 1716 1715
		f 4 3200 3203 -3302 -3202
		mu 0 4 1665 1666 1717 1716
		f 4 3202 3205 -3304 -3204
		mu 0 4 1666 1667 1718 1717
		f 4 3204 3207 -3306 -3206
		mu 0 4 1667 1668 1719 1718
		f 4 3206 3209 -3308 -3208
		mu 0 4 1668 1669 1720 1719
		f 4 3208 3211 -3310 -3210
		mu 0 4 1669 1670 1721 1720
		f 4 3210 3213 -3312 -3212
		mu 0 4 1670 1671 1722 1721
		f 4 3212 3215 -3314 -3214
		mu 0 4 1671 1672 1723 1722
		f 4 3214 3216 -3316 -3216
		mu 0 4 1672 1673 1724 1723
		f 4 3217 3220 -3319 -3219
		mu 0 4 1674 1675 1726 1725
		f 4 3219 3222 -3321 -3221
		mu 0 4 1675 1676 1727 1726
		f 4 3221 3224 -3323 -3223
		mu 0 4 1676 1677 1728 1727
		f 4 3223 3226 -3325 -3225
		mu 0 4 1677 1678 1729 1728
		f 4 3225 3228 -3327 -3227
		mu 0 4 1678 1679 1730 1729
		f 4 3227 3230 -3328 -3229
		mu 0 4 1679 1680 1731 1730
		f 4 3229 3232 -3329 -3231
		mu 0 4 1680 1681 1732 1731
		f 4 3231 3234 -3330 -3233
		mu 0 4 1681 1682 1733 1732
		f 4 3233 3236 -3331 -3235
		mu 0 4 1682 1683 1734 1733
		f 4 3235 3238 -3332 -3237
		mu 0 4 1683 1684 1735 1734
		f 4 3237 3240 -3333 -3239
		mu 0 4 1684 1685 1736 1735
		f 4 3239 3242 -3334 -3241
		mu 0 4 1685 1686 1737 1736
		f 4 3241 3244 -3335 -3243
		mu 0 4 1686 1687 1738 1737
		f 4 3243 3246 -3336 -3245
		mu 0 4 1687 1688 1739 1738
		f 4 3245 3248 -3337 -3247
		mu 0 4 1688 1689 1740 1739
		f 4 3247 3250 -3338 -3249
		mu 0 4 1689 1690 1741 1740
		f 4 3249 3252 -3339 -3251
		mu 0 4 1690 1691 1742 1741
		f 4 3251 3254 -3340 -3253
		mu 0 4 1691 1692 1743 1742
		f 4 3253 3256 -3341 -3255
		mu 0 4 1692 1693 1744 1743
		f 4 3255 3258 -3342 -3257
		mu 0 4 1693 1694 1745 1744
		f 4 3257 3260 -3343 -3259
		mu 0 4 1694 1695 1746 1745
		f 4 3259 3262 -3344 -3261
		mu 0 4 1695 1696 1747 1746
		f 4 3261 3264 -3345 -3263
		mu 0 4 1696 1697 1748 1747
		f 4 3263 3266 -3346 -3265
		mu 0 4 1697 1698 1749 1748
		f 4 3265 3268 -3348 -3267
		mu 0 4 1698 1699 1750 1749
		f 4 3267 3270 -3350 -3269
		mu 0 4 1699 1700 1751 1750
		f 4 3269 3272 -3352 -3271
		mu 0 4 1700 1701 1752 1751
		f 4 3271 3274 -3354 -3273
		mu 0 4 1701 1702 1753 1752
		f 4 3273 3276 -3356 -3275
		mu 0 4 1702 1703 1754 1753
		f 4 3275 3278 -3358 -3277
		mu 0 4 1703 1704 1755 1754
		f 4 3277 3280 -3360 -3279
		mu 0 4 1704 1705 1756 1755
		f 4 3279 3282 -3362 -3281
		mu 0 4 1705 1706 1757 1756
		f 4 3281 3284 -3364 -3283
		mu 0 4 1706 1707 1758 1757
		f 4 3283 3286 -3366 -3285
		mu 0 4 1707 1708 1759 1758
		f 4 3285 3288 -3368 -3287
		mu 0 4 1708 1709 1760 1759
		f 4 3287 3290 -3370 -3289
		mu 0 4 1709 1710 1761 1760
		f 4 3289 3292 -3372 -3291
		mu 0 4 1710 1711 1762 1761
		f 4 3291 3294 -3374 -3293
		mu 0 4 1711 1712 1763 1762
		f 4 3293 3296 -3376 -3295
		mu 0 4 1712 1713 1764 1763
		f 4 3295 3298 -3378 -3297
		mu 0 4 1713 1714 1765 1764
		f 4 3297 3300 -3380 -3299
		mu 0 4 1714 1715 1766 1765
		f 4 3299 3302 -3382 -3301
		mu 0 4 1715 1716 1767 1766
		f 4 3301 3304 -3384 -3303
		mu 0 4 1716 1717 1768 1767
		f 4 3303 3306 -3386 -3305
		mu 0 4 1717 1718 1769 1768
		f 4 3305 3308 -3388 -3307
		mu 0 4 1718 1719 1770 1769
		f 4 3307 3310 -3390 -3309
		mu 0 4 1719 1720 1771 1770
		f 4 3309 3312 -3392 -3311
		mu 0 4 1720 1721 1772 1771
		f 4 3311 3314 -3394 -3313
		mu 0 4 1721 1722 1773 1772
		f 4 3313 3316 -3396 -3315
		mu 0 4 1722 1723 1774 1773
		f 4 3315 3317 -3398 -3317
		mu 0 4 1723 1724 1775 1774
		f 4 3318 3321 -3401 -3320
		mu 0 4 1725 1726 1777 1776
		f 4 3320 3323 -3403 -3322
		mu 0 4 1726 1727 1778 1777
		f 4 3322 3325 -3405 -3324
		mu 0 4 1727 1728 1779 1778
		f 4 3345 3348 -3408 -3347
		mu 0 4 1748 1749 1781 1780
		f 4 3347 3350 -3410 -3349
		mu 0 4 1749 1750 1782 1781
		f 4 3349 3352 -3412 -3351
		mu 0 4 1750 1751 1783 1782
		f 4 3351 3354 -3414 -3353
		mu 0 4 1751 1752 1784 1783
		f 4 3353 3356 -3416 -3355
		mu 0 4 1752 1753 1785 1784
		f 4 3355 3358 -3418 -3357
		mu 0 4 1753 1754 1786 1785
		f 4 3357 3360 -3420 -3359
		mu 0 4 1754 1755 1787 1786
		f 4 3359 3362 -3422 -3361
		mu 0 4 1755 1756 1788 1787
		f 4 3361 3364 -3424 -3363
		mu 0 4 1756 1757 1789 1788
		f 4 3363 3366 -3426 -3365
		mu 0 4 1757 1758 1790 1789
		f 4 3365 3368 -3428 -3367
		mu 0 4 1758 1759 1791 1790
		f 4 3367 3370 -3430 -3369
		mu 0 4 1759 1760 1792 1791
		f 4 3369 3372 -3432 -3371
		mu 0 4 1760 1761 1793 1792
		f 4 3371 3374 -3434 -3373
		mu 0 4 1761 1762 1794 1793
		f 4 3373 3376 -3436 -3375
		mu 0 4 1762 1763 1795 1794
		f 4 3375 3378 -3438 -3377
		mu 0 4 1763 1764 1796 1795
		f 4 3377 3380 -3440 -3379
		mu 0 4 1764 1765 1797 1796
		f 4 3379 3382 -3442 -3381
		mu 0 4 1765 1766 1798 1797
		f 4 3381 3384 -3444 -3383
		mu 0 4 1766 1767 1799 1798
		f 4 3383 3386 -3446 -3385
		mu 0 4 1767 1768 1800 1799
		f 4 3385 3388 -3448 -3387
		mu 0 4 1768 1769 1801 1800
		f 4 3387 3390 -3450 -3389
		mu 0 4 1769 1770 1802 1801
		f 4 3389 3392 -3452 -3391
		mu 0 4 1770 1771 1803 1802
		f 4 3391 3394 -3454 -3393
		mu 0 4 1771 1772 1804 1803
		f 4 3393 3396 -3456 -3395
		mu 0 4 1772 1773 1805 1804
		f 4 3395 3398 -3458 -3397
		mu 0 4 1773 1774 1806 1805
		f 4 3397 3399 -3460 -3399
		mu 0 4 1774 1775 1807 1806
		f 4 3400 3403 -3463 -3402
		mu 0 4 1776 1777 1809 1808
		f 4 3402 3405 -3465 -3404
		mu 0 4 1777 1778 1810 1809
		f 4 3404 3406 -3467 -3406
		mu 0 4 1778 1779 1811 1810
		f 4 3407 3410 -3470 -3409
		mu 0 4 1780 1781 1813 1812
		f 4 3409 3412 -3472 -3411
		mu 0 4 1781 1782 1814 1813
		f 4 3411 3414 -3474 -3413
		mu 0 4 1782 1783 1815 1814
		f 4 3413 3416 -3476 -3415
		mu 0 4 1783 1784 1816 1815
		f 4 3415 3418 -3478 -3417
		mu 0 4 1784 1785 1817 1816
		f 4 3417 3420 -3480 -3419
		mu 0 4 1785 1786 1818 1817
		f 4 3419 3422 -3482 -3421
		mu 0 4 1786 1787 1819 1818
		f 4 3421 3424 -3484 -3423
		mu 0 4 1787 1788 1820 1819
		f 4 3423 3426 -3486 -3425
		mu 0 4 1788 1789 1821 1820
		f 4 3425 3428 -3488 -3427
		mu 0 4 1789 1790 1822 1821
		f 4 3427 3430 -3489 -3429
		mu 0 4 1790 1791 1823 1822
		f 4 3429 3432 -3490 -3431
		mu 0 4 1791 1792 1824 1823
		f 4 3431 3434 -3491 -3433
		mu 0 4 1792 1793 1825 1824
		f 4 3433 3436 -3492 -3435
		mu 0 4 1793 1794 1826 1825
		f 4 3435 3438 -3493 -3437
		mu 0 4 1794 1795 1827 1826
		f 4 3437 3440 -3494 -3439
		mu 0 4 1795 1796 1828 1827
		f 4 3439 3442 -3495 -3441
		mu 0 4 1796 1797 1829 1828
		f 4 3441 3444 -3496 -3443
		mu 0 4 1797 1798 1830 1829
		f 4 3443 3446 -3497 -3445
		mu 0 4 1798 1799 1831 1830
		f 4 3445 3448 -3498 -3447
		mu 0 4 1799 1800 1832 1831
		f 4 3447 3450 -3499 -3449
		mu 0 4 1800 1801 1833 1832
		f 4 3449 3452 -3500 -3451
		mu 0 4 1801 1802 1834 1833
		f 4 3451 3454 -3501 -3453
		mu 0 4 1802 1803 1835 1834
		f 4 3453 3456 -3502 -3455
		mu 0 4 1803 1804 1836 1835
		f 4 3455 3458 -3504 -3457
		mu 0 4 1804 1805 1837 1836
		f 4 3457 3460 -3506 -3459
		mu 0 4 1805 1806 1838 1837
		f 4 3459 3461 -3508 -3461
		mu 0 4 1806 1807 1839 1838
		f 4 3462 3465 -3511 -3464
		mu 0 4 1808 1809 1841 1840
		f 4 3464 3467 -3513 -3466
		mu 0 4 1809 1810 1842 1841
		f 4 3466 3468 -3515 -3468
		mu 0 4 1810 1811 1843 1842
		f 4 3469 3472 -3518 -3471
		mu 0 4 1812 1813 1845 1844
		f 4 3471 3474 -3520 -3473
		mu 0 4 1813 1814 1846 1845
		f 4 3473 3476 -3522 -3475
		mu 0 4 1814 1815 1847 1846
		f 4 3475 3478 -3524 -3477
		mu 0 4 1815 1816 1848 1847
		f 4 3477 3480 -3526 -3479
		mu 0 4 1816 1817 1849 1848
		f 4 3479 3482 -3528 -3481
		mu 0 4 1817 1818 1850 1849
		f 4 3481 3484 -3530 -3483
		mu 0 4 1818 1819 1851 1850
		f 4 3483 3486 -3532 -3485
		mu 0 4 1819 1820 1852 1851
		f 4 3501 3504 -3535 -3503
		mu 0 4 1835 1836 1854 1853
		f 4 3503 3506 -3537 -3505
		mu 0 4 1836 1837 1855 1854
		f 4 3505 3508 -3539 -3507
		mu 0 4 1837 1838 1856 1855
		f 4 3507 3509 -3541 -3509
		mu 0 4 1838 1839 1857 1856
		f 4 3510 3513 -3544 -3512
		mu 0 4 1840 1841 1859 1858
		f 4 3512 3515 -3546 -3514
		mu 0 4 1841 1842 1860 1859
		f 4 3514 3516 -3548 -3516
		mu 0 4 1842 1843 1861 1860
		f 4 3517 3520 -3551 -3519
		mu 0 4 1844 1845 1863 1862
		f 4 3519 3522 -3553 -3521
		mu 0 4 1845 1846 1864 1863
		f 4 3521 3524 -3555 -3523
		mu 0 4 1846 1847 1865 1864
		f 4 3523 3526 -3557 -3525
		mu 0 4 1847 1848 1866 1865
		f 4 3525 3528 -3559 -3527
		mu 0 4 1848 1849 1867 1866
		f 4 3527 3530 -3561 -3529
		mu 0 4 1849 1850 1868 1867
		f 4 3529 3532 -3563 -3531
		mu 0 4 1850 1851 1869 1868
		f 4 3531 3533 -3565 -3533
		mu 0 4 1851 1852 1870 1869
		f 4 3534 3537 -3568 -3536
		mu 0 4 1853 1854 1872 1871
		f 4 3536 3539 -3570 -3538
		mu 0 4 1854 1855 1873 1872
		f 4 3538 3541 -3572 -3540
		mu 0 4 1855 1856 1874 1873
		f 4 3540 3542 -3574 -3542
		mu 0 4 1856 1857 1875 1874
		f 4 3543 3546 -3577 -3545
		mu 0 4 1858 1859 1877 1876
		f 4 3545 3548 -3579 -3547
		mu 0 4 1859 1860 1878 1877
		f 4 3547 3549 -3581 -3549
		mu 0 4 1860 1861 1879 1878
		f 4 3550 3553 -3584 -3552
		mu 0 4 1862 1863 1881 1880
		f 4 3552 3555 -3586 -3554
		mu 0 4 1863 1864 1882 1881
		f 4 3554 3557 -3588 -3556
		mu 0 4 1864 1865 1883 1882
		f 4 3556 3559 -3590 -3558
		mu 0 4 1865 1866 1884 1883
		f 4 3558 3561 -3592 -3560
		mu 0 4 1866 1867 1885 1884
		f 4 3560 3563 -3594 -3562
		mu 0 4 1867 1868 1886 1885
		f 4 3562 3565 -3596 -3564
		mu 0 4 1868 1869 1887 1886
		f 4 3564 3566 -3598 -3566
		mu 0 4 1869 1870 1888 1887
		f 4 3567 3570 -3630 -3569
		mu 0 4 1871 1872 1904 1903
		f 4 3569 3572 -3632 -3571
		mu 0 4 1872 1873 1905 1904
		f 4 3571 3574 -3634 -3573
		mu 0 4 1873 1874 1906 1905
		f 4 3573 3575 -3636 -3575
		mu 0 4 1874 1875 1907 1906
		f 4 3576 3579 -3639 -3578
		mu 0 4 1876 1877 1909 1908
		f 4 3578 3581 -3641 -3580
		mu 0 4 1877 1878 1910 1909
		f 4 3580 3582 -3643 -3582
		mu 0 4 1878 1879 1911 1910
		f 4 3583 3586 -3685 -3585
		mu 0 4 1880 1881 1932 1931
		f 4 3585 3588 -3687 -3587
		mu 0 4 1881 1882 1933 1932
		f 4 3587 3590 -3689 -3589
		mu 0 4 1882 1883 1934 1933
		f 4 3589 3592 -3691 -3591
		mu 0 4 1883 1884 1935 1934
		f 4 3591 3594 -3693 -3593
		mu 0 4 1884 1885 1936 1935
		f 4 3593 3596 -3695 -3595
		mu 0 4 1885 1886 1937 1936
		f 4 3595 3598 -3697 -3597
		mu 0 4 1886 1887 1938 1937
		f 4 3597 3600 -3699 -3599
		mu 0 4 1887 1888 1939 1938
		f 4 3599 3602 -3701 -3601
		mu 0 4 1888 1889 1940 1939
		f 4 3601 3604 -3703 -3603
		mu 0 4 1889 1890 1941 1940
		f 4 3603 3606 -3705 -3605
		mu 0 4 1890 1891 1942 1941
		f 4 3605 3608 -3707 -3607
		mu 0 4 1891 1892 1943 1942
		f 4 3607 3610 -3709 -3609
		mu 0 4 1892 1893 1944 1943
		f 4 3609 3612 -3711 -3611
		mu 0 4 1893 1894 1945 1944
		f 4 3611 3614 -3713 -3613
		mu 0 4 1894 1895 1946 1945
		f 4 3613 3616 -3715 -3615
		mu 0 4 1895 1896 1947 1946
		f 4 3615 3618 -3717 -3617
		mu 0 4 1896 1897 1948 1947
		f 4 3617 3620 -3719 -3619
		mu 0 4 1897 1898 1949 1948
		f 4 3619 3622 -3721 -3621
		mu 0 4 1898 1899 1950 1949
		f 4 3621 3624 -3723 -3623
		mu 0 4 1899 1900 1951 1950
		f 4 3623 3626 -3725 -3625
		mu 0 4 1900 1901 1952 1951
		f 4 3625 3628 -3727 -3627
		mu 0 4 1901 1902 1953 1952
		f 4 3627 3630 -3729 -3629
		mu 0 4 1902 1903 1954 1953
		f 4 3629 3632 -3731 -3631
		mu 0 4 1903 1904 1955 1954
		f 4 3631 3634 -3733 -3633
		mu 0 4 1904 1905 1956 1955
		f 4 3633 3636 -3735 -3635
		mu 0 4 1905 1906 1957 1956
		f 4 3635 3637 -3737 -3637
		mu 0 4 1906 1907 1958 1957
		f 4 3638 3641 -3740 -3640
		mu 0 4 1908 1909 1960 1959
		f 4 3640 3643 -3742 -3642
		mu 0 4 1909 1910 1961 1960
		f 4 3642 3645 -3744 -3644
		mu 0 4 1910 1911 1962 1961
		f 4 3644 3647 -3746 -3646
		mu 0 4 1911 1912 1963 1962
		f 4 3646 3649 -3748 -3648
		mu 0 4 1912 1913 1964 1963
		f 4 3648 3651 -3750 -3650
		mu 0 4 1913 1914 1965 1964
		f 4 3650 3653 -3752 -3652
		mu 0 4 1914 1915 1966 1965
		f 4 3652 3655 -3754 -3654
		mu 0 4 1915 1916 1967 1966
		f 4 3654 3657 -3756 -3656
		mu 0 4 1916 1917 1968 1967
		f 4 3656 3659 -3758 -3658
		mu 0 4 1917 1918 1969 1968
		f 4 3658 3661 -3760 -3660
		mu 0 4 1918 1919 1970 1969
		f 4 3660 3663 -3762 -3662
		mu 0 4 1919 1920 1971 1970
		f 4 3662 3665 -3764 -3664
		mu 0 4 1920 1921 1972 1971
		f 4 3664 3667 -3766 -3666
		mu 0 4 1921 1922 1973 1972
		f 4 3666 3669 -3768 -3668
		mu 0 4 1922 1923 1974 1973
		f 4 3668 3671 -3770 -3670
		mu 0 4 1923 1924 1975 1974
		f 4 3670 3673 -3772 -3672
		mu 0 4 1924 1925 1976 1975
		f 4 3672 3675 -3774 -3674
		mu 0 4 1925 1926 1977 1976
		f 4 3674 3677 -3776 -3676
		mu 0 4 1926 1927 1978 1977
		f 4 3676 3679 -3778 -3678
		mu 0 4 1927 1928 1979 1978
		f 4 3678 3681 -3780 -3680
		mu 0 4 1928 1929 1980 1979
		f 4 3680 3683 -3782 -3682
		mu 0 4 1929 1930 1981 1980
		f 4 3682 3685 -3784 -3684
		mu 0 4 1930 1931 1982 1981
		f 4 3684 3687 -3786 -3686
		mu 0 4 1931 1932 1983 1982
		f 4 3686 3689 -3788 -3688
		mu 0 4 1932 1933 1984 1983
		f 4 3688 3691 -3790 -3690
		mu 0 4 1933 1934 1985 1984
		f 4 3690 3693 -3792 -3692
		mu 0 4 1934 1935 1986 1985
		f 4 3692 3695 -3794 -3694
		mu 0 4 1935 1936 1987 1986
		f 4 3694 3697 -3796 -3696
		mu 0 4 1936 1937 1988 1987
		f 4 3696 3699 -3798 -3698
		mu 0 4 1937 1938 1989 1988
		f 4 3698 3701 -3800 -3700
		mu 0 4 1938 1939 1990 1989
		f 4 3700 3703 -3802 -3702
		mu 0 4 1939 1940 1991 1990
		f 4 3702 3705 -3804 -3704
		mu 0 4 1940 1941 1992 1991
		f 4 3704 3707 -3806 -3706
		mu 0 4 1941 1942 1993 1992
		f 4 3706 3709 -3808 -3708
		mu 0 4 1942 1943 1994 1993
		f 4 3708 3711 -3810 -3710
		mu 0 4 1943 1944 1995 1994
		f 4 3710 3713 -3812 -3712
		mu 0 4 1944 1945 1996 1995
		f 4 3712 3715 -3814 -3714
		mu 0 4 1945 1946 1997 1996
		f 4 3714 3717 -3816 -3716
		mu 0 4 1946 1947 1998 1997
		f 4 3716 3719 -3818 -3718
		mu 0 4 1947 1948 1999 1998
		f 4 3718 3721 -3820 -3720
		mu 0 4 1948 1949 2000 1999
		f 4 3720 3723 -3822 -3722
		mu 0 4 1949 1950 2001 2000
		f 4 3722 3725 -3824 -3724
		mu 0 4 1950 1951 2002 2001
		f 4 3724 3727 -3826 -3726
		mu 0 4 1951 1952 2003 2002
		f 4 3726 3729 -3828 -3728
		mu 0 4 1952 1953 2004 2003
		f 4 3728 3731 -3830 -3730
		mu 0 4 1953 1954 2005 2004
		f 4 3730 3733 -3832 -3732
		mu 0 4 1954 1955 2006 2005
		f 4 3732 3735 -3834 -3734
		mu 0 4 1955 1956 2007 2006
		f 4 3734 3737 -3836 -3736
		mu 0 4 1956 1957 2008 2007
		f 4 3736 3738 -3838 -3738
		mu 0 4 1957 1958 2009 2008
		f 4 3739 3742 -3841 -3741
		mu 0 4 1959 1960 2011 2010
		f 4 3741 3744 -3843 -3743
		mu 0 4 1960 1961 2012 2011
		f 4 3743 3746 -3845 -3745
		mu 0 4 1961 1962 2013 2012
		f 4 3745 3748 -3847 -3747
		mu 0 4 1962 1963 2014 2013
		f 4 3747 3750 -3849 -3749
		mu 0 4 1963 1964 2015 2014
		f 4 3749 3752 -3851 -3751
		mu 0 4 1964 1965 2016 2015
		f 4 3751 3754 -3853 -3753
		mu 0 4 1965 1966 2017 2016
		f 4 3753 3756 -3855 -3755
		mu 0 4 1966 1967 2018 2017
		f 4 3755 3758 -3857 -3757
		mu 0 4 1967 1968 2019 2018
		f 4 3757 3760 -3859 -3759
		mu 0 4 1968 1969 2020 2019
		f 4 3759 3762 -3861 -3761
		mu 0 4 1969 1970 2021 2020
		f 4 3761 3764 -3863 -3763
		mu 0 4 1970 1971 2022 2021
		f 4 3763 3766 -3865 -3765
		mu 0 4 1971 1972 2023 2022
		f 4 3765 3768 -3867 -3767
		mu 0 4 1972 1973 2024 2023
		f 4 3767 3770 -3869 -3769
		mu 0 4 1973 1974 2025 2024
		f 4 3769 3772 -3871 -3771
		mu 0 4 1974 1975 2026 2025
		f 4 3771 3774 -3873 -3773
		mu 0 4 1975 1976 2027 2026
		f 4 3773 3776 -3875 -3775
		mu 0 4 1976 1977 2028 2027
		f 4 3775 3778 -3877 -3777
		mu 0 4 1977 1978 2029 2028
		f 4 3777 3780 -3879 -3779
		mu 0 4 1978 1979 2030 2029
		f 4 3779 3782 -3881 -3781
		mu 0 4 1979 1980 2031 2030
		f 4 3781 3784 -3883 -3783
		mu 0 4 1980 1981 2032 2031
		f 4 3783 3786 -3885 -3785
		mu 0 4 1981 1982 2033 2032
		f 4 3785 3788 -3887 -3787
		mu 0 4 1982 1983 2034 2033
		f 4 3787 3790 -3889 -3789
		mu 0 4 1983 1984 2035 2034
		f 4 3789 3792 -3891 -3791
		mu 0 4 1984 1985 2036 2035
		f 4 3791 3794 -3893 -3793
		mu 0 4 1985 1986 2037 2036
		f 4 3793 3796 -3895 -3795
		mu 0 4 1986 1987 2038 2037
		f 4 3795 3798 -3897 -3797
		mu 0 4 1987 1988 2039 2038
		f 4 3797 3800 -3899 -3799
		mu 0 4 1988 1989 2040 2039
		f 4 3799 3802 -3901 -3801
		mu 0 4 1989 1990 2041 2040
		f 4 3801 3804 -3903 -3803
		mu 0 4 1990 1991 2042 2041
		f 4 3803 3806 -3905 -3805
		mu 0 4 1991 1992 2043 2042
		f 4 3805 3808 -3907 -3807
		mu 0 4 1992 1993 2044 2043
		f 4 3807 3810 -3909 -3809
		mu 0 4 1993 1994 2045 2044
		f 4 3809 3812 -3911 -3811
		mu 0 4 1994 1995 2046 2045
		f 4 3811 3814 -3913 -3813
		mu 0 4 1995 1996 2047 2046
		f 4 3813 3816 -3915 -3815
		mu 0 4 1996 1997 2048 2047
		f 4 3815 3818 -3917 -3817
		mu 0 4 1997 1998 2049 2048
		f 4 3817 3820 -3919 -3819
		mu 0 4 1998 1999 2050 2049
		f 4 3819 3822 -3921 -3821
		mu 0 4 1999 2000 2051 2050
		f 4 3821 3824 -3923 -3823
		mu 0 4 2000 2001 2052 2051
		f 4 3823 3826 -3925 -3825
		mu 0 4 2001 2002 2053 2052
		f 4 3825 3828 -3927 -3827
		mu 0 4 2002 2003 2054 2053
		f 4 3827 3830 -3929 -3829
		mu 0 4 2003 2004 2055 2054
		f 4 3829 3832 -3931 -3831
		mu 0 4 2004 2005 2056 2055
		f 4 3831 3834 -3933 -3833
		mu 0 4 2005 2006 2057 2056
		f 4 3833 3836 -3935 -3835
		mu 0 4 2006 2007 2058 2057
		f 4 3835 3838 -3937 -3837
		mu 0 4 2007 2008 2059 2058
		f 4 3837 3839 -3939 -3839
		mu 0 4 2008 2009 2060 2059
		f 4 3840 3843 -3942 -3842
		mu 0 4 2010 2011 2062 2061
		f 4 3842 3845 -3943 -3844
		mu 0 4 2011 2012 2063 2062
		f 4 3844 3847 -3944 -3846
		mu 0 4 2012 2013 2064 2063
		f 4 3846 3849 -3945 -3848
		mu 0 4 2013 2014 2065 2064
		f 4 3848 3851 -3946 -3850
		mu 0 4 2014 2015 2066 2065
		f 4 3850 3853 -3947 -3852
		mu 0 4 2015 2016 2067 2066
		f 4 3852 3855 -3948 -3854
		mu 0 4 2016 2017 2068 2067
		f 4 3854 3857 -3949 -3856
		mu 0 4 2017 2018 2069 2068
		f 4 3856 3859 -3950 -3858
		mu 0 4 2018 2019 2070 2069
		f 4 3858 3861 -3951 -3860
		mu 0 4 2019 2020 2071 2070
		f 4 3860 3863 -3952 -3862
		mu 0 4 2020 2021 2072 2071
		f 4 3862 3865 -3953 -3864
		mu 0 4 2021 2022 2073 2072
		f 4 3864 3867 -3954 -3866
		mu 0 4 2022 2023 2074 2073
		f 4 3866 3869 -3955 -3868
		mu 0 4 2023 2024 2075 2074
		f 4 3868 3871 -3956 -3870
		mu 0 4 2024 2025 2076 2075
		f 4 3870 3873 -3957 -3872
		mu 0 4 2025 2026 2077 2076
		f 4 3872 3875 -3958 -3874
		mu 0 4 2026 2027 2078 2077
		f 4 3874 3877 -3959 -3876
		mu 0 4 2027 2028 2079 2078
		f 4 3876 3879 -3960 -3878
		mu 0 4 2028 2029 2080 2079
		f 4 3878 3881 -3961 -3880
		mu 0 4 2029 2030 2081 2080
		f 4 3880 3883 -3962 -3882
		mu 0 4 2030 2031 2082 2081
		f 4 3882 3885 -3963 -3884
		mu 0 4 2031 2032 2083 2082
		f 4 3884 3887 -3964 -3886
		mu 0 4 2032 2033 2084 2083
		f 4 3886 3889 -3965 -3888
		mu 0 4 2033 2034 2085 2084
		f 4 3888 3891 -3966 -3890
		mu 0 4 2034 2035 2086 2085
		f 4 3890 3893 -3967 -3892
		mu 0 4 2035 2036 2087 2086
		f 4 3892 3895 -3968 -3894
		mu 0 4 2036 2037 2088 2087
		f 4 3894 3897 -3969 -3896
		mu 0 4 2037 2038 2089 2088
		f 4 3896 3899 -3970 -3898
		mu 0 4 2038 2039 2090 2089
		f 4 3898 3901 -3971 -3900
		mu 0 4 2039 2040 2091 2090
		f 4 3900 3903 -3972 -3902
		mu 0 4 2040 2041 2092 2091
		f 4 3902 3905 -3973 -3904
		mu 0 4 2041 2042 2093 2092
		f 4 3904 3907 -3974 -3906
		mu 0 4 2042 2043 2094 2093
		f 4 3906 3909 -3975 -3908
		mu 0 4 2043 2044 2095 2094
		f 4 3908 3911 -3976 -3910
		mu 0 4 2044 2045 2096 2095
		f 4 3910 3913 -3977 -3912
		mu 0 4 2045 2046 2097 2096
		f 4 3912 3915 -3978 -3914
		mu 0 4 2046 2047 2098 2097
		f 4 3914 3917 -3979 -3916
		mu 0 4 2047 2048 2099 2098
		f 4 3916 3919 -3980 -3918
		mu 0 4 2048 2049 2100 2099
		f 4 3918 3921 -3981 -3920
		mu 0 4 2049 2050 2101 2100
		f 4 3920 3923 -3982 -3922
		mu 0 4 2050 2051 2102 2101
		f 4 3922 3925 -3983 -3924
		mu 0 4 2051 2052 2103 2102
		f 4 3924 3927 -3984 -3926
		mu 0 4 2052 2053 2104 2103
		f 4 3926 3929 -3985 -3928
		mu 0 4 2053 2054 2105 2104
		f 4 3928 3931 -3986 -3930
		mu 0 4 2054 2055 2106 2105
		f 4 3930 3933 -3987 -3932
		mu 0 4 2055 2056 2107 2106
		f 4 3932 3935 -3988 -3934
		mu 0 4 2056 2057 2108 2107
		f 4 3934 3937 -3989 -3936
		mu 0 4 2057 2058 2109 2108
		f 4 3936 3939 -3990 -3938
		mu 0 4 2058 2059 2110 2109
		f 4 3938 3940 -3991 -3940
		mu 0 4 2059 2060 2111 2110;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".vnm" 0;
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
	setAttr ".nmt" 1;
	setAttr ".nmf" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/scenes/locomotion.gse";
	setAttr ".gdt" 2;
createNode transform -n "populationTool1";
	setAttr ".t" -type "double3" 0 0.01 0 ;
createNode PopulationToolLocator -n "populationToolShape1" -p "populationTool1";
	setAttr -k off ".v";
	setAttr ".np" 96;
	setAttr ".npp" 96;
	setAttr ".dst" 2.5;
	setAttr ".n" 2;
	setAttr ".qp" yes;
	setAttr ".on" 1;
	setAttr ".nr" 32;
	setAttr ".nc" 32;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".etw" -type "Int32Array" 1 100 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 96 11.020029067993164 5.0018434794680492e-015
		 -22.526300430297852 -23.008050918579102 -3.8185536987468422e-015 17.197237014770508 -22.341033935546875
		 -7.1086456592840946e-016 3.2014493942260742 19.303440093994141 -4.4398917525899188e-015
		 19.995494842529297 -21.797645568847656 2.6764775766237141e-015 -12.053783416748047 -19.678138732910156
		 -3.4076461575725196e-015 15.346673965454102 24.059123992919922 8.9099964821941289e-017
		 -0.40127056837081909 18.469766616821289 -2.1549587557245309e-015 9.7050714492797852 21.147388458251953
		 -1.5066438671817073e-015 6.7853207588195801 0.34232223033905029 5.3933315197771461e-015
		 -24.289405822753906 -8.361912727355957 5.452100359723544e-015 -24.5540771484375 -24.553277969360352
		 -1.3668676548961051e-015 6.1558246612548828 19.428501129150391 -7.2010887175650608e-016
		 3.2430820465087891 -8.0411195755004883 9.9669858683645168e-016 -4.4887313842773437 -13.690621376037598
		 -3.7304919183855489e-015 16.800642013549805 2.6486763954162598 4.5143726301914103e-015
		 -20.330926895141602 -21.31474494934082 -5.3059435541253936e-015 23.895845413208008 3.3550729751586914
		 -7.1159889055411973e-016 3.204756498336792 -22.986415863037109 3.3223761978053764e-015
		 -14.962652206420898 5.5562286376953125 1.6741521499186521e-015 -7.5397109985351563 -13.660059928894043
		 -2.6990363404101418e-016 1.2155379056930542 17.631481170654297 1.077753737127837e-016
		 -0.48537713289260864 -18.80168342590332 3.0581406700193716e-015 -13.772641181945801 -16.859100341796875
		 -5.4386109365220456e-015 24.493326187133789 -13.099732398986816 3.2839975584817577e-015
		 -14.789810180664063 -1.7618930339813232 -4.1979782958211434e-015 18.906013488769531 -5.0103302001953125
		 4.9012428586303136e-016 -2.2073235511779785 22.580879211425781 -3.130648596128471e-015
		 14.099187850952148 -24.347915649414063 9.8305627418797392e-016 -4.4272918701171875 -3.6523227691650391
		 8.0448023544573083e-016 -3.6230568885803223 1.4815711975097656 3.9000755377223851e-015
		 -17.56437873840332 -23.397760391235352 4.1783512718838404e-015 -18.817621231079102 -14.568368911743164
		 5.4147474772990502e-015 -24.385854721069336 -23.270298004150391 -3.2045204570408867e-016
		 1.4431877136230469 22.156028747558594 -4.8669323067941205e-015 21.91871452331543 13.633033752441406
		 -3.8923154453761148e-015 17.529430389404297 -16.159748077392578 1.657142246030128e-015
		 -7.4631052017211914 -8.1749286651611328 -2.7599522500591517e-015 12.429719924926758 -21.295509338378906
		 -2.1002912493087384e-015 9.4588708877563477 -22.534515380859375 -4.7869092926187441e-015
		 21.558322906494141 3.4872293472290039 -1.9254630137207403e-015 8.6715145111083984 17.941261291503906
		 2.590257881164462e-015 -11.665484428405762 -1.1800758838653564 -5.4354756440677839e-015
		 24.479206085205078 2.1241052150726318 -1.4044951877537461e-015 6.3252840042114258 20.470224380493164
		 7.1923108092535461e-016 -3.2391288280487061 -3.0650436878204346 5.3824255470647734e-015
		 -24.240287780761719 -12.885135650634766 7.189470601902284e-016 -3.2378497123718262 12.417105674743652
		 3.3197703009431485e-015 -14.950916290283203 7.5038394927978516 -1.9899463614457893e-015
		 8.9619216918945313 -21.420890808105469 3.813262389804463e-016 -1.7173407077789307 -18.091119766235352
		 -2.421849731800178e-015 10.907041549682617 19.956043243408203 3.5559171574070167e-015
		 -16.014427185058594 -21.852193832397461 1.6555802113962727e-015 -7.4560704231262207 4.1314468383789062
		 1.5185168338824892e-015 -6.8387918472290039 5.5813794136047363 2.8728545421480983e-015
		 -12.938186645507813 -1.282907247543335 4.9781650969440289e-015 -22.419662475585938 8.1450271606445313
		 3.7678608944360405e-015 -16.968936920166016 -9.7550210952758789 -1.0889716297230362e-016
		 0.49042922258377075 23.940258026123047 4.6875519043893411e-015 -21.110857009887695 -1.4943172931671143
		 -7.8600840562980507e-016 3.5398671627044678 5.849360466003418 5.3588284797036895e-015
		 -24.134017944335937 7.4617724418640137 8.050147661750075e-016 -3.6254642009735107 -3.5140397548675537
		 -3.2157060565049717e-016 1.4482252597808838 -3.7649338245391846 2.8710821257059687e-015
		 -12.930204391479492 -10.76759147644043 9.5232112783148e-017 -0.42888730764389038 9.2273502349853516
		 -5.0013466946444846e-015 22.524063110351563 8.9443569183349609 -4.4265124436715635e-015
		 19.935239791870117 21.990100860595703 -2.6610734354449474e-015 11.984409332275391 -18.350471496582031
		 1.8635067887938245e-015 -8.3924884796142578 -20.847131729125977 -2.9847810522818079e-015
		 13.442258834838867 -1.2570747137069702 2.7248308759341994e-016 -1.2271547317504883 23.553932189941406
		 -6.4564138786349303e-016 2.9077103137969971 5.6083621978759766 -4.7823175270116786e-015
		 21.537643432617188 -16.749897003173828 -3.9059912158260091e-015 17.591020584106445 7.8926095962524414
		 1.2238769525756729e-015 -5.5118517875671387 24.452884674072266 2.459731586300232e-015
		 -11.077646255493164 -10.841206550598145 -4.4277054895777712e-015 19.94061279296875 21.739728927612305
		 5.4468817897355103e-015 -24.530574798583984 16.980257034301758 5.451653973360341e-015
		 -24.552066802978516 24.472761154174805 -1.9609651291554835e-015 8.8314018249511719 7.7484407424926758
		 2.3524423697945029e-015 -10.59445858001709 -11.114952087402344 -5.0065843228738315e-015
		 22.547651290893555 17.563308715820313 -5.4142689036838516e-015 24.383699417114258 15.615642547607422
		 -4.5700286240566487e-015 20.581579208374023 1.5881253480911255 -6.5639706516728734e-017
		 0.29561495780944824 22.49107551574707 3.3271380052766033e-015 -14.984097480773926 23.98040771484375
		 3.5734702211729676e-015 -16.093479156494141 -3.4527919292449951 -4.8796217073769372e-015
		 21.975862503051758 -6.2384147644042969 -5.2768560192002073e-015 23.764846801757813 20.665533065795898
		 -3.3807471440248016e-015 15.225531578063965 21.144451141357422 -2.5079470309985518e-016
		 1.129478931427002 17.912172317504883 1.1118095173353638e-015 -5.0071449279785156 -24.572538375854492
		 -2.3029070360061242e-015 10.371371269226074 -13.254856109619141 -2.675992650261411e-015
		 12.051599502563477 3.410773754119873 3.3348144531193322e-015 -15.018669128417969 -18.574863433837891
		 9.2003141131897842e-016 -4.1434531211853027 ;
	setAttr ".pto" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 96 0.95241940021514893 0 0.30479055643081665 0.81207114458084106
		 0 -0.58355844020843506 -0.14514924585819244 0 -0.98940974473953247 -0.6278347373008728
		 0 0.77834665775299072 -0.87897026538848877 0 -0.47687661647796631 0.91046667098999023
		 0 -0.41358247399330139 -0.76014697551727295 0 0.64975118637084961 -0.51460176706314087
		 0 0.85742932558059692 -0.93367213010787964 0 -0.35812896490097046 0.92492508888244629
		 0 -0.38014939427375793 -0.28565558791160583 0 -0.958332359790802 0.40661287307739258
		 0 0.91360056400299072 0.50687634944915771 0 0.86201876401901245 -0.2256951630115509
		 0 0.97419798374176025 -0.58763021230697632 0 0.80912959575653076 -0.97713780403137207
		 0 0.21260702610015869 0.99342453479766846 0 0.11448868364095688 -0.27942809462547302
		 0 -0.96016663312911987 -0.011112417094409466 0 -0.9999382495880127 0.11461209505796432
		 0 0.99341034889221191 0.58192920684814453 0 -0.8132394552230835 0.68521422147750854
		 0 -0.72834157943725586 -0.73374068737030029 0 0.67942959070205688 0.65411710739135742
		 0 -0.75639331340789795 -0.95598167181015015 0 0.29342645406723022 0.89954245090484619
		 0 -0.43683338165283203 0.65953749418258667 0 -0.75167167186737061 4.7250588977476582e-005
		 0 -1 -0.88384485244750977 0 0.46778017282485962 0.64672517776489258 0 0.76272308826446533 0.63793987035751343
		 0 -0.77008616924285889 0.43939363956451416 0 0.89829462766647339 0.79164481163024902
		 0 0.61098158359527588 0.71691948175430298 0 -0.69715595245361328 -0.82417035102844238
		 0 -0.56634199619293213 -0.67000484466552734 0 -0.74235677719116211 -0.14265857636928558
		 0 -0.98977196216583252 -0.79761451482772827 0 -0.60316753387451172 -0.84329336881637573
		 0 0.53745347261428833 0.51258498430252075 0 -0.85863649845123291 -0.57699805498123169
		 0 -0.81674551963806152 0.99987715482711792 0 -0.015675291419029236 -0.88265395164489746
		 0 -0.47002339363098145 -0.93815946578979492 0 0.3462035059928894 0.95196658372879028
		 0 0.30620193481445313 0.56467735767364502 0 -0.82531172037124634 0.98490208387374878
		 0 -0.17311222851276398 0.97434067726135254 0 0.22507818043231964 -0.97412198781967163
		 0 0.22602292895317078 -0.15522116422653198 0 -0.98787975311279297 0.94512069225311279
		 0 0.32672137022018433 0.96538263559341431 0 0.26083779335021973 -0.99493867158889771
		 0 0.10048425197601318 0.72753274440765381 0 0.6860729455947876 0.62233656644821167
		 0 0.78274977207183838 0.83490622043609619 0 0.55039221048355103 -0.64553123712539673
		 0 0.76373386383056641 -0.52053165435791016 0 -0.85384237766265869 0.99717307090759277
		 0 0.075138881802558899 0.94824641942977905 0 -0.31753548979759216 -0.99699270725250244
		 0 0.077495761215686798 -0.72184908390045166 0 0.6920505166053772 -0.98401707410812378
		 0 0.17807415127754211 0.99566030502319336 0 -0.093062400817871094 -0.54718202352523804
		 0 -0.83701366186141968 0.99972432851791382 0 -0.02347840927541256 -0.78146952390670776
		 0 0.62394344806671143 -0.92735880613327026 0 -0.37417331337928772 0.87217700481414795
		 0 0.48919036984443665 -0.99615806341171265 0 -0.08757355809211731 0.73036873340606689
		 0 0.68305307626724243 -0.10656357556581497 0 -0.99430590867996216 0.31863471865653992
		 0 -0.94787758588790894 0.78210479021072388 0 0.62314689159393311 0.92152416706085205
		 0 0.38832095265388489 -0.2688976526260376 0 -0.96316874027252197 0.78708291053771973
		 0 -0.61684721708297729 -0.88706874847412109 0 0.46163731813430786 -0.15569926798343658
		 0 0.98780453205108643 -0.85045844316482544 0 -0.52604222297668457 -0.81994408369064331
		 0 0.57244360446929932 0.69316506385803223 0 0.72077888250350952 0.62568372488021851
		 0 -0.78007686138153076 -0.74651765823364258 0 0.66536563634872437 0.72008925676345825
		 0 -0.69388145208358765 0.98169350624084473 0 0.19046753644943237 0.93061459064483643
		 0 -0.36600065231323242 0.81725549697875977 0 0.5762755274772644 0.65324580669403076
		 0 -0.75714588165283203 -0.6811138391494751 0 -0.7321774959564209 0.99547791481018066
		 0 0.09499310702085495 0.78361999988555908 0 0.62124049663543701 0.96595263481140137
		 0 0.25871896743774414 0.99673020839691162 0 -0.080801665782928467 0.25518754124641418
		 0 0.9668915867805481 0.28196984529495239 0 -0.9594232439994812 ;
	setAttr ".poo" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 96 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 96 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".get" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 96 1 2 4 5 7 14 17 20 21 22 25 28 40 50 56
		 58 60 70 73 75 78 90 92 94 97 109 117 118 119 130 134 138 139 148 158 160 161 166
		 169 173 174 182 189 194 199 203 204 205 207 208 209 224 227 231 234 237 239 240 241
		 247 252 254 256 266 267 269 270 278 280 281 283 286 287 288 292 295 296 299 304 307
		 310 315 316 320 323 326 328 335 337 339 343 344 350 353 355 366 ;
	setAttr ".etc" -type "vectorArray" 96 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "CrowdManLocomotion:crowdBehaviors";
createNode transform -n "CrowdManLocomotion:crowdTriggers" -p "CrowdManLocomotion:crowdBehaviors";
createNode transform -n "CrowdManLocomotion:beLocomotion1" -p "CrowdManLocomotion:crowdBehaviors";
createNode CrowdBeLocomotion -n "CrowdManLocomotion:beLocomotionShape1" -p "CrowdManLocomotion:beLocomotion1";
	setAttr -k off ".v";
	setAttr ".bpy" 82;
	setAttr -s 13 ".mcp";
	setAttr ".gms[12]"  1.3;
	setAttr -s 8 ".gmi";
	setAttr ".gmi[1]" 2;
	setAttr ".gmi[3]" 2;
	setAttr ".gmi[6]" 2;
	setAttr ".gmi[7]" 2;
	setAttr ".gmi[13]" 2;
	setAttr ".gmi[14]" 2;
	setAttr ".gmi[15]" 2;
	setAttr ".gmi[16]" 2;
	setAttr ".gmm[0]" -type "string" "";
createNode transform -n "populationTool2";
	setAttr ".t" -type "double3" 0 0.01 0 ;
createNode PopulationToolLocator -n "populationToolShape2" -p "populationTool2";
	setAttr -k off ".v";
	setAttr ".np" 96;
	setAttr ".npp" 96;
	setAttr ".dst" 2.5;
	setAttr ".n" 2;
	setAttr ".on" 1;
	setAttr ".nr" 32;
	setAttr ".nc" 32;
	setAttr ".etw" -type "Int32Array" 1 100 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 96 11.020029067993164 5.0018434794680492e-015
		 -22.526300430297852 -23.008050918579102 -3.8185536987468422e-015 17.197237014770508 -22.341033935546875
		 -7.1086456592840946e-016 3.2014493942260742 19.485418319702148 -4.5315216592415209e-015
		 20.408159255981445 -24.078786849975586 2.4944885244996282e-015 -11.234177589416504 17.949983596801758
		 -5.5058327417655678e-016 2.4796066284179687 -15.727168083190918 -3.8873776668100959e-015
		 17.507192611694336 16.803016662597656 -1.6738679703648483e-015 7.5384311676025391 23.894569396972656
		 -1.2573646119036085e-015 5.6626667976379395 3.6679253578186035 5.1823529767915186e-015
		 -23.339242935180664 -5.9037137031555176 5.2964669495115125e-015 -23.853166580200195 -24.553277969360352
		 -1.3668676548961051e-015 6.1558246612548828 -23.66798210144043 4.9772939235577778e-015
		 -22.415739059448242 10.907116889953613 -4.0652393391404484e-015 18.308210372924805 19.428501129150391
		 -7.2010887175650608e-016 3.2430820465087891 -6.6800804138183594 8.14431866724344e-016
		 -3.6678750514984131 -19.678138732910156 -3.4076461575725196e-015 15.346673965454102 18.584850311279297
		 5.3205633427950028e-015 -23.961687088012695 -21.31474494934082 -5.3059435541253936e-015
		 23.895845413208008 0.34232223033905029 5.3933315197771461e-015 -24.289405822753906 0.94729357957839966
		 -9.2331662860490422e-016 4.1582484245300293 -21.248563766479492 3.0198477927816623e-015
		 -13.600185394287109 5.2578268051147461 1.5586455491542538e-015 -7.0195155143737793 -13.660059928894043
		 -2.6990363404101418e-016 1.2155379056930542 -22.539295196533203 3.5229701168576662e-015
		 -15.866046905517578 -18.80168342590332 3.0581406700193716e-015 -13.772641181945801 -16.859100341796875
		 -5.4386109365220456e-015 24.493326187133789 -13.099732398986816 3.2839975584817577e-015
		 -14.789810180664063 20.470224380493164 7.1923108092535461e-016 -3.2391288280487061 -1.7618930339813232
		 -4.1979782958211434e-015 18.906013488769531 22.010471343994141 -3.2699971626548282e-015
		 14.726758003234863 -5.0103302001953125 4.9012428586303136e-016 -2.2073235511779785 -24.347915649414063
		 9.8305627418797392e-016 -4.4272918701171875 0.071624517440795898 4.8317368172862835e-015
		 -21.760208129882812 -1.3908398151397705 8.7776033796537097e-016 -3.9530811309814453 1.5072457790374756
		 3.8706394487394036e-015 -17.43181037902832 -23.397760391235352 4.1783512718838404e-015
		 -18.817621231079102 -1.282907247543335 4.9781650969440289e-015 -22.419662475585938 -21.081293106079102
		 -3.3304083465463929e-016 1.4998825788497925 21.959932327270508 -4.730629458987853e-015
		 21.304861068725586 24.441009521484375 -4.0441511833691317e-015 18.213237762451172 -18.993022918701172
		 1.3491284556399951e-015 -6.0759344100952148 19.944328308105469 -3.9151569593482479e-015
		 17.632299423217773 -17.833927154541016 2.6819115047385872e-015 -12.078255653381348 -24.583047866821289
		 -1.9340991498927084e-015 8.7104082107543945 -23.944643020629883 -5.1056562610000099e-015
		 22.993831634521484 3.4872293472290039 -1.9254630137207403e-015 8.6715145111083984 13.633033752441406
		 -3.8923154453761148e-015 17.529430389404297 -2.3420565128326416 -5.2911933223819072e-015
		 23.829416275024414 2.1241052150726318 -1.4044951877537461e-015 6.3252840042114258 24.059123992919922
		 8.9099964821941289e-017 -0.40127056837081909 -3.0650436878204346 5.3824255470647734e-015
		 -24.240287780761719 -11.153154373168945 9.8859163449828077e-016 -4.4522209167480469 13.699699401855469
		 2.7881093192917792e-015 -12.556528091430664 7.3405671119689941 -1.6765567705767886e-015
		 7.5505404472351074 -21.420890808105469 3.813262389804463e-016 -1.7173407077789307 -18.121160507202148
		 -4.5444566993790413e-015 20.466413497924805 -21.956962585449219 1.702741417712616e-015
		 -7.6684656143188477 -14.512876510620117 -4.7062573564800314e-015 21.195098876953125 5.5813794136047363
		 2.8728545421480983e-015 -12.938186645507813 7.7035923004150391 3.3731200358512502e-015
		 -15.191182136535645 23.940258026123047 4.6875519043893411e-015 -21.110857009887695 -17.257049560546875
		 5.2291578998744231e-015 -23.550033569335938 5.849360466003418 5.3588284797036895e-015
		 -24.134017944335937 -0.050388216972351074 -6.2251918834846354e-016 2.803577184677124 -3.7649338245391846
		 2.8710821257059687e-015 -12.930204391479492 -13.12004280090332 5.3959810388361576e-016
		 -2.4301338195800781 -24.466665267944336 -4.2040498279870622e-015 18.933357238769531 6.3205013275146484
		 -3.9750718348722808e-015 17.902132034301758 22.235458374023438 -2.7748687120185368e-015
		 12.49689769744873 -4.9408783912658691 1.5357150702528794e-016 -0.69162458181381226 23.000797271728516
		 -8.2381206840091573e-016 3.7101197242736816 -13.690621376037598 -3.7304919183855489e-015
		 16.800642013549805 24.208278656005859 -5.2119483079685839e-015 23.472528457641602 7.1093621253967285
		 -1.4257625968725255e-015 6.4210638999938965 21.28767204284668 2.4668691094302704e-015
		 -11.109790802001953 -10.073760032653809 -3.6535038232601846e-015 16.45391845703125 23.98040771484375
		 3.5734702211729676e-015 -16.093479156494141 21.94578742980957 -2.0863276994150144e-015
		 9.3959846496582031 7.8789262771606445 3.2360521055353753e-015 -14.573883056640625 -14.568368911743164
		 5.4147474772990502e-015 -24.385854721069336 14.046982765197754 5.0055268022391845e-015
		 -22.542888641357422 -11.099447250366211 -4.9766857539016492e-015 22.413000106811523 -21.874908447265625
		 -4.8227574210124406e-015 21.719768524169922 15.615642547607422 -4.5700286240566487e-015
		 20.581579208374023 3.3550729751586914 -7.1159889055411973e-016 3.204756498336792 7.1838912963867187
		 1.906517851305977e-015 -8.5861930847167969 -1.8817212581634521 -4.8749524382551979e-015
		 21.954833984375 -21.295509338378906 -2.1002912493087384e-015 9.4588708877563477 22.487129211425781
		 -3.4047317289592543e-015 15.333548545837402 21.144451141357422 -2.5079470309985518e-016
		 1.129478931427002 -20.847131729125977 -2.9847810522818079e-015 13.442258834838867 9.0079755783081055
		 -4.5136827218558717e-015 20.32781982421875 -13.254856109619141 -2.675992650261411e-015
		 12.051599502563477 -12.885135650634766 7.189470601902284e-016 -3.2378497123718262 -18.183811187744141
		 -2.7770019644961967e-015 12.506505012512207 ;
	setAttr ".pto" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 96 0.95241940021514893 0 0.30479055643081665 0.81207114458084106
		 0 -0.58355844020843506 -0.14514924585819244 0 -0.98940974473953247 -0.6278347373008728
		 0 0.77834665775299072 0.96950548887252808 0 0.24506953358650208 -0.87171673774719238
		 0 0.49001017212867737 0.73911792039871216 0 -0.67357605695724487 0.80247956514358521
		 0 0.59667956829071045 0.010022516362369061 0 -0.99994975328445435 -0.91608512401580811
		 0 0.4009837806224823 -0.66852492094039917 0 0.74368971586227417 0.40661287307739258
		 0 0.91360056400299072 -0.48644658923149109 0 -0.87371033430099487 0.61902254819869995
		 0 0.78537321090698242 0.50687634944915771 0 0.86201876401901245 -0.63814550638198853
		 0 -0.76991575956344604 0.91046667098999023 0 -0.41358247399330139 -0.97401142120361328
		 0 0.2264987975358963 0.99342453479766846 0 0.11448868364095688 0.92492508888244629
		 0 -0.38014939427375793 -0.99756979942321777 0 -0.069674558937549591 0.50106406211853027
		 0 -0.8654102087020874 0.11461209505796432 0 0.99341034889221191 0.58192920684814453
		 0 -0.8132394552230835 0.97137761116027832 0 -0.23754066228866577 -0.73374068737030029
		 0 0.67942959070205688 0.65411710739135742 0 -0.75639331340789795 -0.95598167181015015
		 0 0.29342645406723022 0.95196658372879028 0 0.30620193481445313 0.89954245090484619
		 0 -0.43683338165283203 0.87886697053909302 0 -0.47706693410873413 0.65953749418258667
		 0 -0.75167167186737061 -0.88384485244750977 0 0.46778017282485962 0.97311067581176758
		 0 -0.23033811151981354 0.94737786054611206 0 0.32011747360229492 0.63793987035751343
		 0 -0.77008616924285889 0.43939363956451416 0 0.89829462766647339 0.83490622043609619
		 0 0.55039221048355103 0.78418666124343872 0 -0.62052500247955322 -0.72688329219818115
		 0 -0.68676102161407471 -0.37193018198013306 0 0.9282606840133667 0.8021397590637207
		 0 -0.59713637828826904 0.6282467246055603 0 0.77801418304443359 -0.8235514760017395
		 0 -0.56724154949188232 0.82771795988082886 0 0.56114429235458374 0.36723566055297852
		 0 0.93012791872024536 -0.57699805498123169 0 -0.81674551963806152 -0.67000484466552734
		 0 -0.74235677719116211 0.76533627510070801 0 0.64363068342208862 -0.93815946578979492
		 0 0.3462035059928894 -0.76014697551727295 0 0.64975118637084961 0.56467735767364502
		 0 -0.82531172037124634 -0.87514358758926392 0 -0.48386329412460327 -0.075570069253444672
		 0 -0.99714046716690063 0.99083787202835083 0 0.13505655527114868 -0.15522116422653198
		 0 -0.98787975311279297 0.55279117822647095 0 -0.83331984281539917 -0.99493867158889771
		 0 0.10048425197601318 -0.55326402187347412 0 0.83300596475601196 0.62233656644821167
		 0 0.78274977207183838 0.064001701772212982 0 -0.99794977903366089 0.99717307090759277
		 0 0.075138881802558899 0.92752301692962646 0 0.37376609444618225 -0.99699270725250244
		 0 0.077495761215686798 0.59772640466690063 0 -0.8017001748085022 0.99566030502319336
		 0 -0.093062400817871094 0.83116185665130615 0 0.55603057146072388 -0.40644952654838562
		 0 0.91367322206497192 0.99200236797332764 0 0.12621922791004181 0.48222818970680237
		 0 0.87604564428329468 0.6114966869354248 0 -0.79124695062637329 0.69229686260223389
		 0 0.72161281108856201 -0.58763021230697632 0 0.80912959575653076 0.97191500663757324
		 0 -0.23533226549625397 0.18857896327972412 0 -0.98205804824829102 0.25422671437263489
		 0 0.9671446681022644 0.85921788215637207 0 0.51160979270935059 0.93061459064483643
		 0 -0.36600065231323242 0.96206724643707275 0 0.27281239628791809 0.95933860540390015
		 0 0.2822577953338623 0.79164481163024902 0 0.61098158359527588 0.41955080628395081
		 0 -0.90773183107376099 0.69316506385803223 0 0.72077888250350952 0.51258498430252075
		 0 -0.85863649845123291 -0.74651765823364258 0 0.66536563634872437 -0.27942809462547302
		 0 -0.96016663312911987 -0.60449540615081787 0 -0.79660862684249878 -0.39069738984107971
		 0 -0.92051917314529419 -0.84329336881637573 0 0.53745347261428833 0.87451988458633423
		 0 -0.4849897027015686 0.99547791481018066 0 0.09499310702085495 -0.99615806341171265
		 0 -0.08757355809211731 -0.78146952390670776 0 0.62394344806671143 0.99673020839691162
		 0 -0.080801665782928467 0.98490208387374878 0 -0.17311222851276398 0.99164265394210815
		 0 0.1290149986743927 ;
	setAttr ".poo" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 96 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 96 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".get" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 96 1 2 4 5 7 8 14 20 21 22 25 28 31 39 40
		 50 56 58 60 68 70 73 75 78 91 92 94 97 103 109 115 117 119 120 130 134 138 139 148
		 158 160 161 165 168 169 173 174 181 189 194 199 203 204 205 207 208 209 227 233 234
		 239 241 244 252 256 266 267 268 270 278 283 286 288 291 294 295 296 298 307 310 311
		 313 315 316 320 323 334 335 338 339 343 350 351 353 366 368 ;
	setAttr ".etc" -type "vectorArray" 96 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636 0 1 0.49803921580314636
		 0 1 0.49803921580314636 0 1 0.49803921580314636 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "particle2";
createNode particle -n "particleShape2" -p "particle2";
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
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 96 -6.1628259999999999 0 -13.690308999999999 -8.487387
		 0 13.904641 -19.971447000000001 0 -13.950367999999999 6.6715960000000001 0 -12.14781 -15.481092
		 0 10.048514000000001 3.5587770000000001 0 -10.030524 2.6019700000000001 0 2.1965680000000001 -9.0023040000000005
		 0 24.458705999999999 4.5252299999999996 0 -16.590229000000001 -13.743575 0 14.814989000000001 1.9460999999999999
		 0 -21.522753000000002 -12.839546 0 9.8719839999999994 -1.378617 0 -15.393784 24.493116000000001
		 0 -11.559780999999999 -14.791247 0 -24.588025999999999 -21.431059000000001 0 6.4313289999999999 23.728756000000001
		 0 -23.765491000000001 24.163898 0 16.396231 -23.769258000000001 0 -16.475902999999999 -18.518689999999999
		 0 21.284303999999999 -8.6555739999999997 0 -13.978332 -14.133048 0 -3.7692809999999999 -13.798904
		 0 15.481503999999999 -20.115555000000001 0 21.015108000000001 0.256021 0 9.9643999999999995 21.462769999999999
		 0 -17.141722000000001 11.156105 0 17.561312000000001 22.512450999999999 0 24.227900000000002 1.3570009999999999
		 0 0.59092 4.4524710000000001 0 21.520911999999999 -22.14377 0 17.590098999999999 0.066955200000000006
		 0 4.6017999999999999 -11.240005 0 -1.2589980000000001 7.2406439999999996 0 -14.092340999999999 -16.94482
		 0 -1.3978409999999999 -8.9191269999999996 0 22.493254 -14.303088000000001 0 -1.272813 21.521557000000001
		 0 10.360620000000001 22.671036000000001 0 14.021727 -15.372417 0 7.5088530000000002 11.258061
		 0 21.261590999999999 19.244215000000001 0 6.3776200000000003 -24.580805000000002
		 0 3.6041259999999999 -21.762595999999998 0 -11.193410999999999 24.310825000000001
		 0 7.0051209999999999 -16.816579999999998 0 -22.528427000000001 7.0443420000000003
		 0 7.0284509999999996 5.1471390000000001 0 2.3424900000000002 -13.946384 0 18.519390000000001 -21.963851999999999
		 0 14.692121999999999 -12.459641 0 20.818650999999999 19.335965999999999 0 15.898724 -1.6956150000000001
		 0 18.861155 -21.400824 0 -23.229050000000001 22.463605999999999 0 5.7451160000000003 -23.266535000000001
		 0 23.430506000000001 11.356545000000001 0 -23.746952 11.881144000000001 0 23.074598000000002 -6.217568
		 0 -22.571204999999999 -17.548148999999999 0 -23.98197 -24.425184000000002 0 6.8693210000000002 21.733643000000001
		 0 -4.0527300000000004 -23.74831 0 -1.526942 -13.871491000000001 0 -14.107010000000001 16.638774999999999
		 0 9.5909809999999993 3.8188330000000001 0 19.043078999999999 -21.816029 0 23.550771999999998 9.9374380000000002
		 0 23.277111000000001 -2.100114 0 24.488254999999999 -8.1932880000000008 0 -24.541640999999998 -20.083960999999999
		 0 8.8098100000000006 -11.006162 0 17.07762 22.230473 0 -13.976566999999999 0.881911
		 0 -18.955542000000001 -8.8554820000000003 0 -3.128098 -20.221352 0 -1.1825939999999999 -2.114725
		 0 -2.838619 21.466127 0 18.097078 -17.637194000000001 0 11.23068 16.256989999999998
		 0 -24.598043000000001 18.276539 0 -13.209410999999999 -4.6314130000000002 0 23.165672000000001 -1.6633800000000001
		 0 -22.360426 21.588536999999999 0 -11.136998999999999 -1.2289049999999999 0 1.3040909999999999 20.883237999999999
		 0 -9.5837909999999997 -18.50338 0 -6.5465949999999999 8.4655769999999997 0 -22.508040999999999 8.7544850000000007
		 0 -11.298945 -24.375558999999999 0 21.428885999999999 16.843482999999999 0 -12.392716 -7.9982220000000002
		 0 11.529754000000001 -21.459054999999999 0 10.917816 -23.893395999999999 0 1.64093 -17.809196
		 0 9.4216379999999997 -11.026823 0 14.985142 ;
	setAttr ".vel0" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "locomotion_startup";
	setAttr ".mas0" -type "doubleArray" 96 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 96 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 ;
	setAttr ".nid" 96;
	setAttr ".nid0" 96;
	setAttr ".bt0" -type "doubleArray" 96 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 0.041666666666666519 0.041666666666666519
		 0.041666666666666519 0.041666666666666519 ;
	setAttr ".ag0" -type "doubleArray" 96 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5
		 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5
		 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5
		 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5
		 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5 3.5
		 3.5 3.5 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 1000;
	setAttr ".initDirection0" -type "vectorArray" 96 -0.99764970708744261 0 -0.06852052209623119 0.9880350667352632
		 0 -0.15422939700797603 -0.96793333992337516 0 0.25120718434149053 0.90665480071855764
		 0 -0.42187328942941238 -0.97328744289493663 0 -0.22958996821079841 -0.10616969085005268
		 0 0.9943480259671682 -0.05096040434331095 0 -0.99870067447116795 -0.49046656417169782
		 0 0.87146001022973507 -0.81274491556903916 0 0.58261968917697537 -0.84178017995251697
		 0 0.53982045963367109 0.30253266071334506 0 -0.95313901882238772 0.89947788436700948
		 0 -0.43696628649662295 -0.84963542969152672 0 -0.52737049274006087 -0.42615522511634918
		 0 -0.90465005615764693 -0.54870121403320304 0 0.83601852713829805 0.30240556688810671
		 0 0.95317934992061326 -0.80495501131337122 0 0.59333584904461201 -0.84705583601085477
		 0 -0.53150391407773467 0.36713208324081442 0 0.93016881986833988 0.25821031664680488
		 0 0.96608872903950027 0.23757594508047453 0 -0.97136896713819265 -0.80835094589505729
		 0 0.58870089881922749 0.27296862308562536 0 0.96202293673838035 0.2697948704851833
		 0 -0.96291781988905101 -0.48530000154821318 0 -0.87434770457599109 -0.33082132779590934
		 0 0.94369340840940052 -0.76204137501253133 0 -0.64752833356464856 -0.68827778762387126
		 0 -0.72544723244601972 -0.39837331141214222 0 0.91722336688209394 0.64293834122988047
		 0 -0.76591793906173133 -0.04764488532686495 0 0.99886433758653637 0.99711875415514173
		 0 0.075856378189957302 -0.72779595741470693 0 -0.68579373310844005 -0.97296623563225404
		 0 0.23094740595988697 0.99408581245504668 0 0.10859741007772648 -0.056858570892821425
		 0 0.99838224288897759 0.48791580416999814 0 0.8728906965028006 0.77755433172660238
		 0 -0.62881576094528413 0.19375470038971748 0 0.98105000691957134 -0.54834318080115652
		 0 0.83625340421960015 0.68925609752265693 0 -0.72451779276139072 0.2656846514135483
		 0 0.96405999087362881 0.21107080346822277 0 -0.97747077497144574 0.5380641371199425
		 0 0.84290389982807157 -0.12100648247432216 0 0.99265171696783572 0.77651161174917294
		 0 -0.63010294144584178 -0.005500960420147083 0 0.99998486960276356 0.075547454183206464
		 0 0.99714220759450156 0.47421982829497328 0 -0.88040647115516235 -0.80795168715869536
		 0 -0.58924873459127391 -0.93458675966579252 0 -0.35573527890468509 0.65766180503452643
		 0 0.75331331476267471 0.98504552024496017 0 0.17229429196968693 -0.59124990539783739
		 0 0.80648840621985907 -0.41125044494936541 0 0.91152239222574716 -0.97757626506829964
		 0 -0.21058168480452791 0.96207611008819804 0 -0.27278115476982912 -0.12784795022881862
		 0 0.99179377978604477 0.2334545410724771 0 0.97236771709710668 0.66228155406616696
		 0 -0.74925505880421184 0.76648152873354469 0 -0.64226635137634946 0.7947272665402938
		 0 -0.6069666974533221 -0.12720096286785937 0 0.99187696567945838 -0.8519335282040601
		 0 -0.52364994368545681 -0.92503505491922644 0 0.37988175419541192 -0.31061680782614248
		 0 0.95053521696773413 -0.87680307963767812 0 -0.48084962258265718 -0.70482223003942024
		 0 0.7093839750390889 -0.83974743295705123 0 0.54297720840017094 0.67674654962799341
		 0 0.73621607396647215 -0.76572444670659845 0 0.64316877389676963 0.54674049663238855
		 0 -0.83730211354216044 -0.73729724864890811 0 0.67556847701380363 0.26389216937357302
		 0 0.96455218777591778 -0.32182623742789268 0 -0.94679874994795243 0.73871858941925117
		 0 -0.67401398030488313 -0.75135827615709572 0 0.65989449221086682 0.8839373556519341
		 0 -0.46760533709856877 -0.74882919713622287 0 0.66276302968430556 0.56330790476960457
		 0 -0.82624706016062677 0.90255666646434674 0 -0.43057109032163993 0.93426396713848747
		 0 0.35658216403327692 0.94704758218588658 0 -0.32109325292797158 -0.68438277914872669
		 0 0.72912290569194516 0.75796489372632003 0 -0.65229534712310222 -0.98221478924460603
		 0 0.18776077276463859 0.57979444422531645 0 -0.81476278906529365 0.20531464458036269
		 0 -0.97869601854755661 -0.87907460775891377 0 -0.47668420782894816 -0.26029702525027493
		 0 0.96552859027884719 -0.61678965995298629 0 -0.78712801714529235 -0.95356550262838846
		 0 0.30118571047954579 -0.18148383062941664 0 -0.98339392880985044 -0.43600500887984978
		 0 -0.89994423840129234 0.99543513801003125 0 0.095440484150856125 -0.52375653189582172
		 0 -0.8518680034468139 ;
	setAttr ".entityType0" -type "doubleArray" 96 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 96 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 ;
	setAttr ".entityRadius0" -type "doubleArray" 96 0.30000001192092896 0.30000001192092896
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
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".groupEntityId0" -type "doubleArray" 96 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 96 1.7976931348623157e+308 1.7976931348623157e+308
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
		 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 96 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "locator1";
createNode locator -n "locatorShape1" -p "locator1";
	setAttr -k off ".v";
createNode transform -n "annotationLocator1" -p "locator1";
createNode locator -n "annotationLocator1Shape" -p "annotationLocator1";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "annotationLocator1";
	setAttr ".t" -type "double3" 1 8.9924352255375837 3.57440334172014 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "To know how to save the pre-configured Locomotion Node as a template and use it in your own scene, click the Open In Browser button and check the Locomotion Setup section";
createNode transform -n "particle3";
createNode particle -n "particleShape3" -p "particle3";
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
	setAttr ".pos0" -type "vectorArray" 96 11.020028999999999 0 -22.526299999999999 -23.008050999999998
		 0 17.197237000000001 -22.341034000000001 0 3.2014490000000002 19.303439999999998
		 0 19.995494999999998 -21.797646 0 -12.053782999999999 -19.678139000000002 0 15.346674 24.059124000000001
		 0 -0.40127099999999999 18.469767000000001 0 9.7050710000000002 21.147387999999999
		 0 6.7853209999999997 0.34232200000000002 0 -24.289406 -8.3619129999999995 0 -24.554076999999999 -24.553277999999999
		 0 6.1558250000000001 19.428501000000001 0 3.2430819999999998 -8.0411199999999994
		 0 -4.4887309999999996 -13.690621 0 16.800642 2.648676 0 -20.330926999999999 -21.314744999999998
		 0 23.895845000000001 3.355073 0 3.2047560000000002 -22.986415999999998 0 -14.962652 5.5562290000000001
		 0 -7.5397109999999996 -13.66006 0 1.215538 17.631481000000001 0 -0.485377 -18.801683000000001
		 0 -13.772641 -16.859100000000002 0 24.493326 -13.099731999999999 0 -14.789809999999999 -1.7618929999999999
		 0 18.906013000000002 -5.0103299999999997 0 -2.2073239999999998 22.580878999999999
		 0 14.099188 -24.347916000000001 0 -4.4272919999999996 -3.652323 0 -3.6230570000000002 1.481571
		 0 -17.564378999999999 -23.397760000000002 0 -18.817620999999999 -14.568369000000001
		 0 -24.385854999999999 -23.270298 0 1.4431879999999999 22.156029 0 21.918714999999999 13.633034
		 0 17.529430000000001 -16.159748 0 -7.4631049999999997 -8.1749290000000006 0 12.42972 -21.295508999999999
		 0 9.4588710000000003 -22.534514999999999 0 21.558323000000001 3.4872290000000001
		 0 8.6715149999999994 17.941261000000001 0 -11.665483999999999 -1.1800759999999999
		 0 24.479206000000001 2.1241050000000001 0 6.3252839999999999 20.470224000000002 0
		 -3.2391290000000001 -3.0650439999999999 0 -24.240288 -12.885135999999999 0 -3.2378499999999999 12.417106
		 0 -14.950915999999999 7.5038390000000001 0 8.9619219999999995 -21.420891000000001
		 0 -1.717341 -18.09112 0 10.907042000000001 19.956043000000001 0 -16.014427000000001 -21.852194000000001
		 0 -7.4560700000000004 4.1314469999999996 0 -6.8387919999999998 5.5813790000000001
		 0 -12.938186999999999 -1.282907 0 -22.419661999999999 8.1450270000000007 0 -16.968937 -9.7550209999999993
		 0 0.490429 23.940258 0 -21.110856999999999 -1.4943169999999999 0 3.5398670000000001 5.8493599999999999
		 0 -24.134018000000001 7.4617719999999998 0 -3.625464 -3.5140400000000001 0 1.4482250000000001 -3.7649339999999998
		 0 -12.930204 -10.767590999999999 0 -0.42888700000000002 9.2273499999999995 0 22.524063000000002 8.9443570000000001
		 0 19.93524 21.990100999999999 0 11.984408999999999 -18.350470999999999 0 -8.3924880000000002 -20.847131999999998
		 0 13.442259 -1.2570749999999999 0 -1.227155 23.553932 0 2.9077099999999998 5.6083619999999996
		 0 21.537642999999999 -16.749897000000001 0 17.591021000000001 7.8926100000000003
		 0 -5.5118520000000002 24.452884999999998 0 -11.077646 -10.841207000000001 0 19.940612999999999 21.739729000000001
		 0 -24.530574999999999 16.980257000000002 0 -24.552067000000001 24.472760999999998
		 0 8.8314020000000006 7.7484409999999997 0 -10.594459000000001 -11.114952000000001
		 0 22.547650999999998 17.563309 0 24.383699 15.615643 0 20.581579000000001 1.588125
		 0 0.29561500000000002 22.491076 0 -14.984097 23.980408000000001 0 -16.093478999999999 -3.4527920000000001
		 0 21.975863 -6.2384149999999998 0 23.764847 20.665533 0 15.225531999999999 21.144451
		 0 1.1294789999999999 17.912172000000002 0 -5.0071450000000004 -24.572538000000002
		 0 10.371371 -13.254856 0 12.051600000000001 3.410774 0 -15.018668999999999 -18.574863000000001
		 0 -4.1434530000000001 ;
	setAttr ".vel0" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "locomotion_startup";
	setAttr ".mas0" -type "doubleArray" 96 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 96 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 ;
	setAttr ".nid" 96;
	setAttr ".nid0" 96;
	setAttr ".bt0" -type "doubleArray" 96 0.041666666666666664 0.041666666666666664
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
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 ;
	setAttr ".ag0" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 1000;
	setAttr ".glmInitDirection0" -type "vectorArray" 96 0.95241940021514893 0 0.30479055643081665 0.81207114458084118
		 0 -0.58355844020843506 -0.14514924585819244 0 -0.98940974473953247 -0.6278347373008728
		 0 0.77834665775299072 -0.87897026538848877 0 -0.47687661647796631 0.91046667098999023
		 0 -0.41358247399330134 -0.76014697551727295 0 0.64975118637084961 -0.51460176706314087
		 0 0.85742932558059692 -0.93367213010787964 0 -0.35812896490097046 0.92492508888244629
		 0 -0.38014939427375793 -0.28565558791160583 0 -0.958332359790802 0.40661287307739258
		 0 0.91360056400299072 0.50687634944915771 0 0.86201876401901245 -0.2256951630115509
		 0 0.97419798374176036 -0.58763021230697632 0 0.80912959575653076 -0.97713780403137196
		 0 0.21260702610015869 0.99342453479766846 0 0.11448868364095688 -0.27942809462547302
		 0 -0.96016663312911987 -0.011112417094409466 0 -0.99993824958801281 0.11461209505796432
		 0 0.9934103488922118 0.58192920684814453 0 -0.8132394552230835 0.68521422147750854
		 0 -0.72834157943725586 -0.73374068737030029 0 0.67942959070205688 0.65411710739135742
		 0 -0.75639331340789795 -0.95598167181015004 0 0.29342645406723022 0.89954245090484619
		 0 -0.43683338165283198 0.65953749418258667 0 -0.75167167186737061 4.7250588977476582e-005
		 0 -1 -0.88384485244750977 0 0.46778017282485962 0.64672517776489258 0 0.76272308826446533 0.63793987035751343
		 0 -0.77008616924285889 0.43939363956451416 0 0.89829462766647339 0.79164481163024891
		 0 0.61098158359527588 0.71691948175430298 0 -0.69715595245361328 -0.82417035102844238
		 0 -0.56634199619293213 -0.67000484466552734 0 -0.74235677719116211 -0.14265857636928558
		 0 -0.98977196216583252 -0.79761451482772827 0 -0.60316753387451172 -0.84329336881637573
		 0 0.53745347261428833 0.51258498430252075 0 -0.85863649845123291 -0.57699805498123169
		 0 -0.81674551963806141 0.99987715482711792 0 -0.015675291419029236 -0.88265395164489746
		 0 -0.47002339363098145 -0.93815946578979492 0 0.3462035059928894 0.95196658372879028
		 0 0.30620193481445313 0.56467735767364502 0 -0.82531172037124645 0.98490208387374878
		 0 -0.17311222851276398 0.97434067726135243 0 0.22507818043231964 -0.97412198781967163
		 0 0.2260229289531708 -0.15522116422653198 0 -0.98787975311279297 0.94512069225311279
		 0 0.32672137022018433 0.9653826355934142 0 0.26083779335021973 -0.99493867158889771
		 0 0.10048425197601318 0.72753274440765381 0 0.6860729455947876 0.62233656644821167
		 0 0.78274977207183838 0.83490622043609619 0 0.55039221048355103 -0.64553123712539673
		 0 0.76373386383056641 -0.52053165435791016 0 -0.85384237766265869 0.99717307090759277
		 0 0.075138881802558899 0.94824641942977905 0 -0.31753548979759216 -0.99699270725250244
		 0 0.077495761215686798 -0.72184908390045166 0 0.6920505166053772 -0.98401707410812389
		 0 0.17807415127754211 0.99566030502319325 0 -0.093062400817871094 -0.54718202352523804
		 0 -0.83701366186141968 0.99972432851791371 0 -0.02347840927541256 -0.78146952390670787
		 0 0.62394344806671143 -0.92735880613327026 0 -0.37417331337928766 0.87217700481414795
		 0 0.48919036984443665 -0.99615806341171265 0 -0.08757355809211731 0.73036873340606689
		 0 0.68305307626724243 -0.10656357556581496 0 -0.99430590867996227 0.31863471865653992
		 0 -0.94787758588790894 0.78210479021072388 0 0.62314689159393311 0.92152416706085205
		 0 0.38832095265388489 -0.2688976526260376 0 -0.96316874027252197 0.78708291053771973
		 0 -0.61684721708297729 -0.88706874847412109 0 0.46163731813430786 -0.15569926798343658
		 0 0.98780453205108643 -0.85045844316482544 0 -0.52604222297668457 -0.81994408369064331
		 0 0.57244360446929932 0.69316506385803223 0 0.72077888250350941 0.62568372488021851
		 0 -0.78007686138153076 -0.74651765823364258 0 0.66536563634872437 0.72008925676345825
		 0 -0.69388145208358765 0.98169350624084484 0 0.19046753644943237 0.93061459064483643
		 0 -0.36600065231323242 0.81725549697875988 0 0.5762755274772644 0.65324580669403076
		 0 -0.75714588165283203 -0.6811138391494751 0 -0.7321774959564209 0.99547791481018066
		 0 0.094993107020854964 0.78361999988555908 0 0.62124049663543701 0.96595263481140148
		 0 0.25871896743774414 0.99673020839691173 0 -0.080801665782928467 0.25518754124641418
		 0 0.96689158678054798 0.28196984529495239 0 -0.9594232439994812 ;
	setAttr ".glmEntityType0" -type "doubleArray" 96 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 96 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 96 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642 0 1 0.49803921580314642
		 0 1 0.49803921580314642 0 1 0.49803921580314642 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 96 0.30000001192092896 0.30000001192092896
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
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 96 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 96 1.7976931348623157e+308 1.7976931348623157e+308
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
		 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 96 1001 2001 3001 4001 5001 6001
		 7001 8001 9001 10001 11001 12001 13001 14001 15001 16001 17001 18001 19001 20001
		 21001 22001 23001 24001 25001 26001 27001 28001 29001 30001 31001 32001 33001 34001
		 35001 36001 37001 38001 39001 40001 41001 42001 43001 44001 45001 46001 47001 48001
		 49001 50001 51001 52001 53001 54001 55001 56001 57001 58001 59001 60001 61001 62001
		 63001 64001 65001 66001 67001 68001 69001 70001 71001 72001 73001 74001 75001 76001
		 77001 78001 79001 80001 81001 82001 83001 84001 85001 86001 87001 88001 89001 90001
		 91001 92001 93001 94001 95001 96001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 96 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode CrowdField -n "crowdField1";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr -l on ".cfid" 1;
	setAttr -l on ".noe" 96;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 3 ".lnk";
	setAttr -s 3 ".slnk";
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
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\tif ($useSceneConfig) {\n\t\tscriptedPanel -e -to $panelName;\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"Stereo\" -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels `;\n"
		+ "string $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n"
		+ "                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n"
		+ "\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n"
		+ "                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -displayMode \"centerEye\" \n"
		+ "                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.xC:/Golaem/GolaemCrowdSamples-3.5.1/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 1000 -ast 1 -aet 2000 ";
	setAttr ".st" 6;
createNode hyperGraphInfo -n "nodeEditorPanel1Info";
createNode hyperView -n "hyperView1";
	setAttr ".dag" no;
createNode script -n "script1";
	addAttr -ci true -sn "crnd" -ln "currentRenderer" -dt "string";
	addAttr -ci true -sn "sstp" -ln "shadersStartPath" -dt "string";
	addAttr -ci true -sn "lprp" -ln "isLightProps" -dt "string";
	addAttr -ci true -sn "ecdlg" -ln "enableConfirmDialog" -dt "string";
	setAttr ".b" -type "string" "string $packdir = `dirmap -cd \"/atomo/pipeline/tools/golaem/characterPack/5.2/\"`;string $scriptName = $packdir + \"script/sampleGUI.mel\";eval(\"source \\\"\" + $scriptName + \"\\\"\");glmCrowdSampleConfigCrowdMan(\"http://golaem.com/content/doc/golaem-crowd-documentation/populate-city-streets\",1);";
	setAttr ".a" -type "string" "glmDeleteSampleConfigWindow()";
	setAttr ".st" 2;
	setAttr ".sstp" -type "string" "golaem/shaders/CMO-man_golaem-light";
	setAttr ".ecdlg" -type "string" "1";
createNode CrowdBeOpCondition -n "beOpCondition1";
createNode CrowdBeOpCondition -n "beOpCondition2";
createNode CrowdBeOpCondition -n "beOpCondition3";
createNode CrowdBeOpCondition -n "beOpCondition4";
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
	setAttr -s 3 ".st";
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
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av ".w" 640;
	setAttr -av ".h" 480;
	setAttr -av -k on ".pa" 1;
	setAttr -av -k on ".al";
	setAttr -av ".dar" 1.3333332538604736;
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
connectAttr "entityTypeShape1.msg" "crowdManagerNodeShape.ine[0]";
connectAttr "terrainShape1.msg" "crowdManagerNodeShape.trr";
connectAttr ":time1.o" "crowdManagerNodeShape.ct";
connectAttr "entityTypeContainerShape1.msg" "entityTypeShape1.ibc";
connectAttr "beOpParallelShape1.nb" "entityTypeContainerShape1.fb[0]";
connectAttr "triOpAndShape1.msg" "CrowdManLocomotion:beLocomotion1StartTriggerShape.tro"
		;
connectAttr "CrowdManLocomotion:beLocomotion1StartTriggerShape.ctr" "triOpAndShape1.pco"
		;
connectAttr "triBoolShape1.net" "triOpAndShape1.prt[0]";
connectAttr "CrowdManLocomotion:beLocomotion1StartTriggerShape.ctr" "triBoolShape1.pco"
		;
connectAttr "triOpAndShape2.msg" "CrowdManLocomotion:beLocomotion1StopTriggerShape.tro"
		;
connectAttr "CrowdManLocomotion:beLocomotion1StopTriggerShape.ctr" "triOpAndShape2.pco"
		;
connectAttr "triBoolShape2.net" "triOpAndShape2.prt[0]";
connectAttr "CrowdManLocomotion:beLocomotion1StopTriggerShape.ctr" "triBoolShape2.pco"
		;
connectAttr "triOpAndShape3.msg" "beAdaptGround1StartTriggerShape.tro";
connectAttr "beAdaptGround1StartTriggerShape.ctr" "triOpAndShape3.pco";
connectAttr "triBoolShape3.net" "triOpAndShape3.prt[0]";
connectAttr "beAdaptGround1StartTriggerShape.ctr" "triBoolShape3.pco";
connectAttr "triOpAndShape4.msg" "beAdaptGround1StopTriggerShape.tro";
connectAttr "beAdaptGround1StopTriggerShape.ctr" "triOpAndShape4.pco";
connectAttr "triBoolShape4.net" "triOpAndShape4.prt[0]";
connectAttr "beAdaptGround1StopTriggerShape.ctr" "triBoolShape4.pco";
connectAttr "triOpAndShape5.msg" "beGoto1StartTriggerShape.tro";
connectAttr "beGoto1StartTriggerShape.ctr" "triOpAndShape5.pco";
connectAttr "triBoolShape5.net" "triOpAndShape5.prt[0]";
connectAttr "beGoto1StartTriggerShape.ctr" "triBoolShape5.pco";
connectAttr "triOpAndShape6.msg" "beGoto1StopTriggerShape.tro";
connectAttr "beGoto1StopTriggerShape.ctr" "triOpAndShape6.pco";
connectAttr "triBoolShape6.net" "triOpAndShape6.prt[0]";
connectAttr "beGoto1StopTriggerShape.ctr" "triBoolShape6.pco";
connectAttr "triOpAndShape7.msg" "beNavigation1StartTriggerShape.tro";
connectAttr "beNavigation1StartTriggerShape.ctr" "triOpAndShape7.pco";
connectAttr "triBoolShape7.net" "triOpAndShape7.prt[0]";
connectAttr "beNavigation1StartTriggerShape.ctr" "triBoolShape7.pco";
connectAttr "triOpAndShape8.msg" "beNavigation1StopTriggerShape.tro";
connectAttr "beNavigation1StopTriggerShape.ctr" "triOpAndShape8.pco";
connectAttr "triBoolShape8.net" "triOpAndShape8.prt[0]";
connectAttr "beNavigation1StopTriggerShape.ctr" "triBoolShape8.pco";
connectAttr "beOpParallelShape1.chb" "beNavigationShape1.pb";
connectAttr "beNavigation1StartTriggerShape.msg" "beNavigationShape1.isac";
connectAttr "beOpCondition2.msg" "beNavigationShape1.scnd" -na;
connectAttr "beOpCondition2.msg" "beNavigationShape1.fcnd";
connectAttr "beOpCondition2.msg" "beNavigationShape1.lcnd";
connectAttr "beOpParallelShape1.chb" "beGotoShape1.pb";
connectAttr "particleShape2.msg" "beGotoShape1.tps";
connectAttr "beGoto1StartTriggerShape.msg" "beGotoShape1.isac";
connectAttr "beOpCondition1.msg" "beGotoShape1.scnd" -na;
connectAttr "beOpCondition1.msg" "beGotoShape1.fcnd";
connectAttr "beOpCondition1.msg" "beGotoShape1.lcnd";
connectAttr "entityTypeContainerShape1.chb" "beOpParallelShape1.pb";
connectAttr "entityTypeContainerShape1.ib" "beOpParallelShape1.prb[0]";
connectAttr "beAdaptGround1StartTriggerShape.msg" "beAdaptGroundShape1.isac";
connectAttr "beOpCondition4.msg" "beAdaptGroundShape1.scnd" -na;
connectAttr "beOpCondition4.msg" "beAdaptGroundShape1.fcnd";
connectAttr "beOpCondition4.msg" "beAdaptGroundShape1.lcnd";
connectAttr "pPlane1.msg" "terrainShape1.mgg[0]";
connectAttr "terrainShape1.msg" "populationToolShape1.int";
connectAttr "entityTypeShape1.msg" "populationToolShape1.ine" -na;
connectAttr "beOpParallelShape1.chb" "CrowdManLocomotion:beLocomotionShape1.pb";
connectAttr "Stand.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[0]";
connectAttr "StandOrientLeft45_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[1]"
		;
connectAttr "StandOrientLeft90_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[3]"
		;
connectAttr "StandOrientLeft135_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[6]"
		;
connectAttr "StandOrientLeft180_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[7]"
		;
connectAttr "WalkSlow_Leftfoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[9]"
		;
connectAttr "WalkNormal_Leftfoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[10]"
		;
connectAttr "WalkFast_Leftfoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[11]"
		;
connectAttr "WalkFast_Leftfoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[12]"
		;
connectAttr "WalkTurnRight45_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[13]"
		;
connectAttr "WalkTurnRight90_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[14]"
		;
connectAttr "WalkTurnRight135_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[15]"
		;
connectAttr "WalkTurnRight180_LeftFoot.msg" "CrowdManLocomotion:beLocomotionShape1.mcp[16]"
		;
connectAttr "CrowdManLocomotion:beLocomotion1StartTriggerShape.msg" "CrowdManLocomotion:beLocomotionShape1.isac"
		;
connectAttr "beOpCondition3.msg" "CrowdManLocomotion:beLocomotionShape1.scnd" -na
		;
connectAttr "beOpCondition3.msg" "CrowdManLocomotion:beLocomotionShape1.fcnd";
connectAttr "beOpCondition3.msg" "CrowdManLocomotion:beLocomotionShape1.lcnd";
connectAttr "terrainShape1.msg" "populationToolShape2.int";
connectAttr "entityTypeShape1.msg" "populationToolShape2.ine" -na;
connectAttr ":time1.o" "particleShape2.cti";
connectAttr "annotationLocator1Shape.wm" "annotationShape1.dom" -na;
connectAttr ":time1.o" "particleShape3.cti";
connectAttr "crowdManagerNodeShape.sf" "particleShape3.stf";
connectAttr "crowdField1.of[0]" "particleShape3.ifc[0]";
connectAttr "crowdManagerNodeShape.sf" "crowdField1.sf";
connectAttr "particleShape3.fd" "crowdField1.ind[0]";
connectAttr "particleShape3.ppfd[0]" "crowdField1.ppda[0]";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "entityTypeShape1.dc" "crowdLambert1.c";
connectAttr "crowdLambert1.oc" "crowdLambert1SG.ss";
connectAttr "crowdLambert1SG.msg" "materialInfo1.sg";
connectAttr "crowdLambert1.msg" "materialInfo1.m";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "beGoto1StopTriggerShape.msg" "beOpCondition1.ctri";
connectAttr "beNavigation1StopTriggerShape.msg" "beOpCondition2.ctri";
connectAttr "CrowdManLocomotion:beLocomotion1StopTriggerShape.msg" "beOpCondition3.ctri"
		;
connectAttr "beAdaptGround1StopTriggerShape.msg" "beOpCondition4.ctri";
connectAttr "crowdLambert1SG.pa" ":renderPartition.st" -na;
connectAttr "pPlaneShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "particleShape2.iog" ":initialParticleSE.dsm" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of locomotion.ma
