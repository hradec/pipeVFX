//Maya ASCII 2014 scene
//Name: characterPackAssetsTestScene.ma
//Last modified: Fri, Jun 03, 2016 04:57:29 PM
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
	setAttr ".t" -type "double3" -0.73796085895034924 10.960226642586123 11.47589930524742 ;
	setAttr ".r" -type "double3" -19.396639727388266 -1.112520256510646 0 ;
	setAttr ".rpt" -type "double3" 6.424230116498845e-015 3.7942236709291177e-015 -4.5719965969744273e-016 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999979;
	setAttr ".coi" 10.718983511649451;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" -0.0086010766906738922 2.3506776558795295 4.5842410326004028 ;
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
	setAttr ".gdt" 2;
createNode transform -n "crowdManager";
	addAttr -ci true -sn "trBETabs" -ln "trBETabs" -nn "Behavior Editor Tabs" -dt "string";
	addAttr -ci true -sn "trBECTab" -ln "trBECTab" -nn "Behavior Editor Current Tab" 
		-at "float";
	setAttr ".trBETabs" -type "string" "entityTypeContainerShape1#";
createNode CrowdManagerNode -n "crowdManagerShape" -p "crowdManager";
	setAttr -k off ".v";
	setAttr -s 6 ".ine";
	setAttr ".esf" 1;
	setAttr ".eef" 24;
	setAttr ".ecf" -type "string" "crowdField1";
	setAttr ".pec" -type "string" "";
	setAttr ".poc" -type "string" "";
	setAttr ".escn" -type "string" "characterPackAssetsTestScene";
	setAttr ".escod" -type "string" "C:/Users/apillon/Documents/maya/projects/default/export/characterPackAssetsTestScene/cache";
	setAttr ".escaa" -type "string" "particleId;glmEntityType";
	setAttr ".efbxod" -type "string" "C:/Users/apillon/Documents/maya/projects/default/export/characterPackAssetsTestScene/fbx";
	setAttr ".eribod" -type "string" "C:/Users/apillon/Documents/maya/projects/default/export/characterPackAssetsTestScene/rib";
	setAttr ".eribp" -type "string" "glmCrowdRMSPlugin";
	setAttr ".eribwsz" 1;
	setAttr ".emrod" -type "string" "C:/Users/apillon/Documents/maya/projects/default/export/characterPackAssetsTestScene/mentalRay";
	setAttr ".emrwsz" 1;
	setAttr ".evrod" -type "string" "C:/Users/apillon/Documents/maya/projects/default/export/characterPackAssetsTestScene/vray";
	setAttr ".eassod" -type "string" "C:/Users/apillon/Documents/maya/projects/default/export/characterPackAssetsTestScene/arnold";
	setAttr ".easswsz" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/romanSoldier.gcha;/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/fortressSoldier.gcha;/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/horseAndRider.gcha;/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan.gcha;/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdWoman.gcha;/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".drm" -type "string" "";
lockNode -l 1 ;
createNode transform -n "romanSoldier";
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
createNode CrowdEntityTypeNode -n "romanSoldierShape" -p "romanSoldier";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -l on ".etid" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/romanSoldier.gcha";
	setAttr ".rti" -type "Int32Array" 4 0 1 2 3 ;
	setAttr ".rtwe" -type "Int32Array" 4 50 50 50 11 ;
	setAttr ".bf" 3;
createNode transform -n "crowdBehaviors";
createNode transform -n "entityTypeContainer1" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape1" -p "entityTypeContainer1";
	setAttr -k off ".v";
createNode transform -n "entityTypeContainer2" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape2" -p "entityTypeContainer2";
	setAttr -k off ".v";
createNode transform -n "entityTypeContainer3" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape3" -p "entityTypeContainer3";
	setAttr -k off ".v";
createNode transform -n "entityTypeContainer4" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape4" -p "entityTypeContainer4";
	setAttr -k off ".v";
createNode transform -n "entityTypeContainer5" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape5" -p "entityTypeContainer5";
	setAttr -k off ".v";
createNode transform -n "entityTypeContainer6" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape6" -p "entityTypeContainer6";
	setAttr -k off ".v";
createNode transform -n "romanSoldierPopTool";
	setAttr ".t" -type "double3" 0 0 -23.926138488591508 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "romanSoldierPopToolShape" -p "romanSoldierPopTool";
	setAttr -k off ".v";
	setAttr ".np" 49;
	setAttr ".npp" 16;
	setAttr ".dst" 1.7;
	setAttr ".o" 270;
	setAttr ".nr" 4;
	setAttr ".nc" 4;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "romanSoldierParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 16 2.5515000820159912 0 -26.477638244628906 -0.85050004720687866
		 0 -26.477638244628906 2.5515000820159912 0 -23.075637817382812 -0.85050004720687866
		 0 -21.374637603759766 -2.5515000820159912 0 -23.075637817382812 -0.85050004720687866
		 0 -24.776638031005859 0.85050004720687866 0 -26.477638244628906 2.5515000820159912
		 0 -21.374637603759766 -2.5515000820159912 0 -26.477638244628906 -2.5515000820159912
		 0 -24.776638031005859 -0.85050004720687866 0 -23.075637817382812 0.85050004720687866
		 0 -23.075637817382812 0.85050004720687866 0 -24.776638031005859 2.5515000820159912
		 0 -24.776638031005859 -2.5515000820159912 0 -21.374637603759766 0.85050004720687866
		 0 -21.374637603759766 ;
	setAttr ".pto" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 16 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".poo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 16 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".get" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 16 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ;
	setAttr ".etc" -type "vectorArray" 16 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1
		 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "annotationLocator1" -p "romanSoldierPopTool";
createNode locator -n "annotationLocator1Shape" -p "annotationLocator1";
	setAttr -k off ".v";
createNode transform -n "annotation1" -p "annotationLocator1";
	setAttr ".t" -type "double3" 1 4.701355311759059 1 ;
createNode annotationShape -n "annotationShape1" -p "annotation1";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Roman Soldier";
createNode transform -n "romanSoldierParticle";
createNode particle -n "romanSoldierParticleShape" -p "romanSoldierParticle";
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
	setAttr ".pos0" -type "vectorArray" 49 2.5515000820159912 0 -26.477638244628903 -0.85050004720687877
		 0 -26.477638244628903 2.5515000820159912 0 -23.075637817382812 -0.85050004720687877
		 0 -21.374637603759769 -2.5515000820159912 0 -23.075637817382812 -0.85050004720687877
		 0 -24.776638031005859 0.85050004720687877 0 -26.477638244628903 2.5515000820159912
		 0 -21.374637603759769 -2.5515000820159912 0 -26.477638244628903 -2.5515000820159912
		 0 -24.776638031005859 -0.85050004720687877 0 -23.075637817382812 0.85050004720687877
		 0 -23.075637817382812 0.85050004720687877 0 -24.776638031005859 2.5515000820159912
		 0 -24.776638031005859 -2.5515000820159912 0 -21.374637603759769 0.85050004720687877
		 0 -21.374637603759769 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".vel0" -type "vectorArray" 49 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 ;
	setAttr ".acc0" -type "vectorArray" 49 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "characterPackAssetsTestScene_startup";
	setAttr ".mas0" -type "doubleArray" 49 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 49 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 ;
	setAttr ".nid" 49;
	setAttr ".nid0" 49;
	setAttr ".bt0" -type "doubleArray" 49 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667 -4.041666666666667
		 -4.041666666666667 ;
	setAttr ".ag0" -type "doubleArray" 49 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667 5.041666666666667
		 5.041666666666667 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".glmInitDirection0" -type "vectorArray" 49 4.0133926404450904e-007 0
		 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".glmEntityType0" -type "doubleArray" 49 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 49 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".rgbPP0" -type "vectorArray" 49 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 49 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".populationGroupId0" -type "doubleArray" 49 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 49 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".glmEntityId0" -type "doubleArray" 49 1001 2001 3001 4001 5001 6001
		 7001 8001 9001 10001 11001 12001 13001 14001 15001 16001 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".glmGroupId0" -type "doubleArray" 49 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr -k on ".lifespan" 1;
createNode CrowdField -n "crowdField1";
	setAttr -s 6 ".ind";
	setAttr -s 6 ".of";
	setAttr -s 6 ".ppda";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr -l on ".cfid" 1;
	setAttr -l on ".noe" 122;
createNode transform -n "fortressSoldierPopTool";
	setAttr ".t" -type "double3" -10.239008945811229 0 -23.926138488591508 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "fortressSoldierPopToolShape" -p "fortressSoldierPopTool";
	setAttr -k off ".v";
	setAttr ".np" 49;
	setAttr ".npp" 16;
	setAttr ".dst" 1.7;
	setAttr ".o" 270;
	setAttr ".nr" 4;
	setAttr ".nc" 4;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "fortressSoldierParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 16 -7.6875085830688477 0 -26.477638244628906 -11.089509010314941
		 0 -26.477638244628906 -7.6875085830688477 0 -23.075637817382812 -11.089509010314941
		 0 -21.374637603759766 -12.790509223937988 0 -23.075637817382812 -11.089509010314941
		 0 -24.776638031005859 -9.3885087966918945 0 -26.477638244628906 -7.6875085830688477
		 0 -21.374637603759766 -12.790509223937988 0 -26.477638244628906 -12.790509223937988
		 0 -24.776638031005859 -11.089509010314941 0 -23.075637817382812 -9.3885087966918945
		 0 -23.075637817382812 -9.3885087966918945 0 -24.776638031005859 -7.6875085830688477
		 0 -24.776638031005859 -12.790509223937988 0 -21.374637603759766 -9.3885087966918945
		 0 -21.374637603759766 ;
	setAttr ".pto" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 16 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".poo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 16 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 16 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ;
	setAttr ".get" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 16 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ;
	setAttr ".etc" -type "vectorArray" 16 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1
		 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "annotationLocator2" -p "fortressSoldierPopTool";
createNode locator -n "annotationLocator2Shape" -p "annotationLocator2";
	setAttr -k off ".v";
createNode transform -n "annotation2" -p "annotationLocator2";
	setAttr ".t" -type "double3" 1.4460426915638891 4.0507293722414186 0 ;
createNode annotationShape -n "annotationShape2" -p "annotation2";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Fortress Soldier";
createNode transform -n "FortressSoldier";
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
createNode CrowdEntityTypeNode -n "FortressSoldierShape" -p "FortressSoldier";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dc" -type "float3" 0 1 1 ;
	setAttr -l on ".etid" 2;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/fortressSoldier.gcha";
	setAttr ".rti" -type "Int32Array" 5 0 1 2 3 4 ;
	setAttr ".rtwe" -type "Int32Array" 5 50 50 50 50 50 ;
	setAttr ".bf" 3;
createNode transform -n "fortressSoldierParticle";
createNode particle -n "fortressSoldierParticleShape" -p "fortressSoldierParticle";
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
	setAttr ".pos0" -type "vectorArray" 16 -7.6875085830688477 0 -26.477638244628903 -11.08950901031494
		 0 -26.477638244628903 -7.6875085830688477 0 -23.075637817382812 -11.08950901031494
		 0 -21.374637603759769 -12.790509223937988 0 -23.075637817382812 -11.08950901031494
		 0 -24.776638031005859 -9.3885087966918945 0 -26.477638244628903 -7.6875085830688477
		 0 -21.374637603759769 -12.790509223937988 0 -26.477638244628903 -12.790509223937988
		 0 -24.776638031005859 -11.08950901031494 0 -23.075637817382812 -9.3885087966918945
		 0 -23.075637817382812 -9.3885087966918945 0 -24.776638031005859 -7.6875085830688477
		 0 -24.776638031005859 -12.790509223937988 0 -21.374637603759769 -9.3885087966918945
		 0 -21.374637603759769 ;
	setAttr ".vel0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "characterPackAssetsTestScene_startup";
	setAttr ".mas0" -type "doubleArray" 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ;
	setAttr ".nid" 16;
	setAttr ".nid0" 16;
	setAttr ".bt0" -type "doubleArray" 16 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 ;
	setAttr ".ag0" -type "doubleArray" 16 1.9166666666666667 1.9166666666666667 1.9166666666666667
		 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667
		 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667
		 1.9166666666666667 1.9166666666666667 1.9166666666666667 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".glmInitDirection0" -type "vectorArray" 16 4.0133926404450904e-007 0
		 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 ;
	setAttr ".glmEntityType0" -type "doubleArray" 16 2 2 2 2 2 2 2 2 2 2 2 2 2 2
		 2 2 ;
	setAttr ".groupEntityType0" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 16 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 ;
	setAttr ".radiusPP0" -type "doubleArray" 16 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 16 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 16 50001 51001 52001 53001 54001
		 55001 56001 57001 58001 59001 60001 61001 62001 63001 64001 65001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "horseAndRider";
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
createNode CrowdEntityTypeNode -n "horseAndRiderShape" -p "horseAndRider";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dc" -type "float3" 1 1 0 ;
	setAttr -l on ".etid" 3;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/horseAndRider.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "horseAndRiderPopTool";
	setAttr ".t" -type "double3" 10.352951904561074 0 -23.926138488591508 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "horseAndRiderPopToolShape" -p "horseAndRiderPopTool";
	setAttr -k off ".v";
	setAttr ".np" 49;
	setAttr ".npp" 9;
	setAttr ".r" 1;
	setAttr ".dst" 2.4193548363062645;
	setAttr ".o" 270;
	setAttr ".nr" 3;
	setAttr ".nc" 3;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "horseAndRiderParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 9 12.773306846618652 0 -26.346492767333984 10.352952003479004
		 0 -26.346492767333984 12.773306846618652 0 -21.505783081054688 7.9325971603393555
		 0 -21.505783081054688 7.9325971603393555 0 -23.926137924194336 12.773306846618652
		 0 -23.926137924194336 10.352952003479004 0 -23.926137924194336 10.352952003479004
		 0 -21.505783081054688 7.9325971603393555 0 -26.346492767333984 ;
	setAttr ".pto" -type "vectorArray" 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 9 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".poo" -type "doubleArray" 9 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 9 0 0 0 0 0 0
		 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 9 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 9 3 3 3 3 3 3 3 3 3 ;
	setAttr ".get" -type "doubleArray" 9 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 9 1 2 3 4 5 6 7 8 9 ;
	setAttr ".etc" -type "vectorArray" 9 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1
		 0 1 1 0 1 1 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "annotationLocator3" -p "horseAndRiderPopTool";
createNode locator -n "annotationLocator3Shape" -p "annotationLocator3";
	setAttr -k off ".v";
createNode transform -n "annotation3" -p "annotationLocator3";
	setAttr ".t" -type "double3" 0.84978571657931035 3.7970382172939008 0 ;
createNode annotationShape -n "annotationShape3" -p "annotation3";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Horse and Rider";
createNode transform -n "horseAndRiderParticle";
createNode particle -n "horseAndRiderParticleShape" -p "horseAndRiderParticle";
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
	setAttr ".pos0" -type "vectorArray" 9 12.773306846618652 0 -26.346492767333984 10.352952003479004
		 0 -26.346492767333984 12.773306846618652 0 -21.505783081054688 7.9325971603393555
		 0 -21.505783081054688 7.9325971603393555 0 -23.926137924194336 12.773306846618652
		 0 -23.926137924194336 10.352952003479004 0 -23.926137924194336 10.352952003479004
		 0 -21.505783081054688 7.9325971603393555 0 -26.346492767333984 ;
	setAttr ".vel0" -type "vectorArray" 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "characterPackAssetsTestScene_startup";
	setAttr ".mas0" -type "doubleArray" 9 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 9 0 1 2 3 4 5 6 7 8 ;
	setAttr ".nid" 9;
	setAttr ".nid0" 9;
	setAttr ".bt0" -type "doubleArray" 9 -1.6666666666666667 -1.6666666666666667
		 -1.6666666666666667 -1.6666666666666667 -1.6666666666666667 -1.6666666666666667 -1.6666666666666667
		 -1.6666666666666667 -1.6666666666666667 ;
	setAttr ".ag0" -type "doubleArray" 9 2.666666666666667 2.666666666666667 2.666666666666667
		 2.666666666666667 2.666666666666667 2.666666666666667 2.666666666666667 2.666666666666667
		 2.666666666666667 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".glmInitDirection0" -type "vectorArray" 9 4.0133926404450904e-007 0
		 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".glmEntityType0" -type "doubleArray" 9 3 3 3 3 3 3 3 3 3 ;
	setAttr ".groupEntityType0" -type "doubleArray" 9 0 0 0 0 0 0 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 9 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1
		 1 0 1 1 0 1 1 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 9 1 1 1 1 1 1 1 1 1 ;
	setAttr ".populationGroupId0" -type "doubleArray" 9 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 9 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 9 66001 67001 68001 69001 70001
		 71001 72001 73001 74001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 9 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "CrowdManPopTool";
	setAttr ".t" -type "double3" 0 0 -14.75765684157466 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "CrowdManPopToolShape" -p "CrowdManPopTool";
	setAttr -k off ".v";
	setAttr ".np" 49;
	setAttr ".npp" 16;
	setAttr ".dst" 1.7;
	setAttr ".o" 270;
	setAttr ".nr" 4;
	setAttr ".nc" 4;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "crowdManParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 16 2.5515000820159912 0 -17.30915641784668 -0.85050004720687866
		 0 -17.30915641784668 2.5515000820159912 0 -13.907156944274902 -0.85050004720687866
		 0 -12.206156730651855 -2.5515000820159912 0 -13.907156944274902 -0.85050004720687866
		 0 -15.608157157897949 0.85050004720687866 0 -17.30915641784668 2.5515000820159912
		 0 -12.206156730651855 -2.5515000820159912 0 -17.30915641784668 -2.5515000820159912
		 0 -15.608157157897949 -0.85050004720687866 0 -13.907156944274902 0.85050004720687866
		 0 -13.907156944274902 0.85050004720687866 0 -15.608157157897949 2.5515000820159912
		 0 -15.608157157897949 -2.5515000820159912 0 -12.206156730651855 0.85050004720687866
		 0 -12.206156730651855 ;
	setAttr ".pto" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 16 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".poo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 16 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 16 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 ;
	setAttr ".get" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 16 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ;
	setAttr ".etc" -type "vectorArray" 16 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0
		 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "annotationLocator4" -p "CrowdManPopTool";
createNode locator -n "annotationLocator4Shape" -p "annotationLocator4";
	setAttr -k off ".v";
createNode transform -n "annotation4" -p "annotationLocator4";
	setAttr ".t" -type "double3" 1.2558281881394864 3.7025516772535081 0 ;
createNode annotationShape -n "annotationShape4" -p "annotation4";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "Crowd Man";
createNode transform -n "CrowdMan";
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
createNode CrowdEntityTypeNode -n "CrowdManShape" -p "CrowdMan";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dc" -type "float3" 1 0 0 ;
	setAttr -l on ".etid" 4;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "crowdManParticle";
createNode particle -n "crowdManParticleShape" -p "crowdManParticle";
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
	setAttr ".pos0" -type "vectorArray" 16 2.5515000820159912 0 -17.30915641784668 -0.85050004720687877
		 0 -17.30915641784668 2.5515000820159912 0 -13.907156944274902 -0.85050004720687877
		 0 -12.206156730651855 -2.5515000820159912 0 -13.907156944274902 -0.85050004720687877
		 0 -15.608157157897947 0.85050004720687877 0 -17.30915641784668 2.5515000820159912
		 0 -12.206156730651855 -2.5515000820159912 0 -17.30915641784668 -2.5515000820159912
		 0 -15.608157157897947 -0.85050004720687877 0 -13.907156944274902 0.85050004720687877
		 0 -13.907156944274902 0.85050004720687877 0 -15.608157157897947 2.5515000820159912
		 0 -15.608157157897947 -2.5515000820159912 0 -12.206156730651855 0.85050004720687877
		 0 -12.206156730651855 ;
	setAttr ".vel0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "characterPackAssetsTestScene_startup";
	setAttr ".mas0" -type "doubleArray" 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ;
	setAttr ".nid" 16;
	setAttr ".nid0" 16;
	setAttr ".bt0" -type "doubleArray" 16 -2.791666666666667 -2.791666666666667 -2.791666666666667
		 -2.791666666666667 -2.791666666666667 -2.791666666666667 -2.791666666666667 -2.791666666666667
		 -2.791666666666667 -2.791666666666667 -2.791666666666667 -2.791666666666667 -2.791666666666667
		 -2.791666666666667 -2.791666666666667 -2.791666666666667 ;
	setAttr ".ag0" -type "doubleArray" 16 3.791666666666667 3.791666666666667 3.791666666666667
		 3.791666666666667 3.791666666666667 3.791666666666667 3.791666666666667 3.791666666666667
		 3.791666666666667 3.791666666666667 3.791666666666667 3.791666666666667 3.791666666666667
		 3.791666666666667 3.791666666666667 3.791666666666667 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".glmInitDirection0" -type "vectorArray" 16 4.0133926404450904e-007 0
		 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 ;
	setAttr ".glmEntityType0" -type "doubleArray" 16 4 4 4 4 4 4 4 4 4 4 4 4 4 4
		 4 4 ;
	setAttr ".groupEntityType0" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 16 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1
		 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 16 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 16 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 16 75001 76001 77001 78001 79001
		 80001 81001 82001 83001 84001 85001 86001 87001 88001 89001 90001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "CrowdWomanPopTool";
	setAttr ".t" -type "double3" -10.239 0 -14.75765684157466 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "CrowdWomanPopToolShape" -p "CrowdWomanPopTool";
	setAttr -k off ".v";
	setAttr ".np" 49;
	setAttr ".npp" 16;
	setAttr ".dst" 1.7;
	setAttr ".o" 270;
	setAttr ".nr" 4;
	setAttr ".nc" 4;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "crowdWomanParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 16 -7.6875 0 -17.30915641784668 -11.089500427246094
		 0 -17.30915641784668 -7.6875 0 -13.907156944274902 -11.089500427246094 0 -12.206156730651855 -12.790500640869141
		 0 -13.907156944274902 -11.089500427246094 0 -15.608157157897949 -9.3885002136230469
		 0 -17.30915641784668 -7.6875 0 -12.206156730651855 -12.790500640869141 0 -17.30915641784668 -12.790500640869141
		 0 -15.608157157897949 -11.089500427246094 0 -13.907156944274902 -9.3885002136230469
		 0 -13.907156944274902 -9.3885002136230469 0 -15.608157157897949 -7.6875 0 -15.608157157897949 -12.790500640869141
		 0 -12.206156730651855 -9.3885002136230469 0 -12.206156730651855 ;
	setAttr ".pto" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 16 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".poo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 16 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 16 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 ;
	setAttr ".get" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 16 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ;
	setAttr ".etc" -type "vectorArray" 16 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0
		 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "annotationLocator5" -p "CrowdWomanPopTool";
createNode locator -n "annotationLocator5Shape" -p "annotationLocator5";
	setAttr -k off ".v";
createNode transform -n "annotation5" -p "annotationLocator5";
	setAttr ".t" -type "double3" 2.1155652811203236 2.6287634855252722 0 ;
createNode annotationShape -n "annotationShape5" -p "annotation5";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "CrowdWoman";
createNode transform -n "CrowdWoman";
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
createNode CrowdEntityTypeNode -n "CrowdWomanShape" -p "CrowdWoman";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dc" -type "float3" 0 0 1 ;
	setAttr -l on ".etid" 5;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdWoman.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "crowdWomanParticle";
createNode particle -n "crowdWomanParticleShape" -p "crowdWomanParticle";
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
	setAttr ".pos0" -type "vectorArray" 16 -7.6875 0 -17.30915641784668 -11.089500427246094
		 0 -17.30915641784668 -7.6875 0 -13.907156944274902 -11.089500427246094 0 -12.206156730651855 -12.790500640869141
		 0 -13.907156944274902 -11.089500427246094 0 -15.608157157897947 -9.3885002136230469
		 0 -17.30915641784668 -7.6875 0 -12.206156730651855 -12.790500640869141 0 -17.30915641784668 -12.790500640869141
		 0 -15.608157157897947 -11.089500427246094 0 -13.907156944274902 -9.3885002136230469
		 0 -13.907156944274902 -9.3885002136230469 0 -15.608157157897947 -7.6875 0 -15.608157157897947 -12.790500640869141
		 0 -12.206156730651855 -9.3885002136230469 0 -12.206156730651855 ;
	setAttr ".vel0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "characterPackAssetsTestScene_startup";
	setAttr ".mas0" -type "doubleArray" 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ;
	setAttr ".nid" 16;
	setAttr ".nid0" 16;
	setAttr ".bt0" -type "doubleArray" 16 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674 -0.91666666666666674
		 -0.91666666666666674 -0.91666666666666674 ;
	setAttr ".ag0" -type "doubleArray" 16 1.9166666666666667 1.9166666666666667 1.9166666666666667
		 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667
		 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667 1.9166666666666667
		 1.9166666666666667 1.9166666666666667 1.9166666666666667 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".glmInitDirection0" -type "vectorArray" 16 4.0133926404450904e-007 0
		 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 ;
	setAttr ".glmEntityType0" -type "doubleArray" 16 5 5 5 5 5 5 5 5 5 5 5 5 5 5
		 5 5 ;
	setAttr ".groupEntityType0" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 16 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0
		 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 ;
	setAttr ".radiusPP0" -type "doubleArray" 16 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 16 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 16 91001 92001 93001 94001 95001
		 96001 97001 98001 99001 100001 101001 102001 103001 104001 105001 106001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "CrowdManLightPopTool";
	setAttr ".t" -type "double3" 10.353 0 -14.75765684157466 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "CrowdManLightPopToolShape" -p "CrowdManLightPopTool";
	setAttr -k off ".v";
	setAttr ".np" 49;
	setAttr ".npp" 16;
	setAttr ".dst" 1.7;
	setAttr ".o" 270;
	setAttr ".nr" 4;
	setAttr ".nc" 4;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "crowdManLightParticleShape";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 16 12.904500007629395 0 -17.30915641784668 9.5024995803833008
		 0 -17.30915641784668 12.904500007629395 0 -13.907156944274902 9.5024995803833008
		 0 -12.206156730651855 7.8014993667602539 0 -13.907156944274902 9.5024995803833008
		 0 -15.608157157897949 11.203499794006348 0 -17.30915641784668 12.904500007629395
		 0 -12.206156730651855 7.8014993667602539 0 -17.30915641784668 7.8014993667602539
		 0 -15.608157157897949 9.5024995803833008 0 -13.907156944274902 11.203499794006348
		 0 -13.907156944274902 11.203499794006348 0 -15.608157157897949 12.904500007629395
		 0 -15.608157157897949 7.8014993667602539 0 -12.206156730651855 11.203499794006348
		 0 -12.206156730651855 ;
	setAttr ".pto" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 16 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 ;
	setAttr ".poo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".pgo" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 16 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpp" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".ldr" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".et" -type "doubleArray" 16 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 ;
	setAttr ".get" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 16 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ;
	setAttr ".etc" -type "vectorArray" 16 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "annotationLocator6" -p "CrowdManLightPopTool";
createNode locator -n "annotationLocator6Shape" -p "annotationLocator6";
	setAttr -k off ".v";
createNode transform -n "annotation6" -p "annotationLocator6";
	setAttr ".t" -type "double3" 0.8011156572369913 3.1780783913621846 0 ;
createNode annotationShape -n "annotationShape6" -p "annotation6";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "CrowdMan Light";
createNode transform -n "CrowdManLight";
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
createNode CrowdEntityTypeNode -n "CrowdManLightShape" -p "CrowdManLight";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dc" -type "float3" 1 0 1 ;
	setAttr -l on ".etid" 6;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "crowdManLightParticle";
createNode particle -n "crowdManLightParticleShape" -p "crowdManLightParticle";
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
	setAttr ".pos0" -type "vectorArray" 16 12.904500007629396 0 -17.30915641784668 9.5024995803833008
		 0 -17.30915641784668 12.904500007629396 0 -13.907156944274902 9.5024995803833008
		 0 -12.206156730651855 7.8014993667602548 0 -13.907156944274902 9.5024995803833008
		 0 -15.608157157897947 11.203499794006348 0 -17.30915641784668 12.904500007629396
		 0 -12.206156730651855 7.8014993667602548 0 -17.30915641784668 7.8014993667602548
		 0 -15.608157157897947 9.5024995803833008 0 -13.907156944274902 11.203499794006348
		 0 -13.907156944274902 11.203499794006348 0 -15.608157157897947 12.904500007629396
		 0 -15.608157157897947 7.8014993667602548 0 -12.206156730651855 11.203499794006348
		 0 -12.206156730651855 ;
	setAttr ".vel0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".acc0" -type "vectorArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "characterPackAssetsTestScene_startup";
	setAttr ".mas0" -type "doubleArray" 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ;
	setAttr ".nid" 16;
	setAttr ".nid0" 16;
	setAttr ".bt0" -type "doubleArray" 16 -1.875 -1.875 -1.875 -1.875 -1.875 -1.875
		 -1.875 -1.875 -1.875 -1.875 -1.875 -1.875 -1.875 -1.875 -1.875 -1.875 ;
	setAttr ".ag0" -type "doubleArray" 16 2.875 2.875 2.875 2.875 2.875 2.875 2.875
		 2.875 2.875 2.875 2.875 2.875 2.875 2.875 2.875 2.875 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 24;
	setAttr ".glmInitDirection0" -type "vectorArray" 16 4.0133926404450904e-007 0
		 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007 0 1 4.0133926404450904e-007
		 0 1 ;
	setAttr ".glmEntityType0" -type "doubleArray" 16 6 6 6 6 6 6 6 6 6 6 6 6 6 6
		 6 6 ;
	setAttr ".groupEntityType0" -type "doubleArray" 16 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 16 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1
		 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 ;
	setAttr ".radiusPP0" -type "doubleArray" 16 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 16 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308
		 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 16 107001 108001 109001 110001 111001
		 112001 113001 114001 115001 116001 117001 118001 119001 120001 121001 122001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 16 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "locator1";
	setAttr ".t" -type "double3" 0 0 -39.694339745156775 ;
createNode locator -n "locatorShape1" -p "locator1";
	setAttr -k off ".v";
createNode transform -n "annotationLocator7" -p "locator1";
createNode locator -n "annotationLocator7Shape" -p "annotationLocator7";
	setAttr -k off ".v";
createNode transform -n "annotation7" -p "annotationLocator7";
	setAttr ".t" -type "double3" 0.96104619957222781 -4.6982112536516656 -60.188580674735597 ;
createNode annotationShape -n "annotationShape7" -p "annotation7";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "This scene loads several high diversity characters so it may takes longer than usual when you import shaders, or press play";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	setAttr -s 15 ".dli[1:14]"  5 6 3 7 2 9 10 11 
		12 13 14 15 1 4;
	setAttr -s 15 ".dli";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode CrowdArchiverNode -n "crowdArchiver";
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode displayLayer -n "body_lay";
	addAttr -ci true -h true -sn "mtoaVersion" -ln "mtoaVersion" -dt "string";
	setAttr ".do" 4;
	setAttr ".mtoaVersion" -type "string" "1.4.0";
createNode displayLayer -n "head_lay";
	addAttr -ci true -h true -sn "mtoaVersion" -ln "mtoaVersion" -dt "string";
	setAttr ".do" 3;
	setAttr ".mtoaVersion" -type "string" "1.4.0";
createNode displayLayer -n "torso_lay";
	addAttr -ci true -h true -sn "mtoaVersion" -ln "mtoaVersion" -dt "string";
	setAttr ".do" 2;
	setAttr ".mtoaVersion" -type "string" "1.4.0";
createNode displayLayer -n "legs_lay";
	addAttr -ci true -h true -sn "mtoaVersion" -ln "mtoaVersion" -dt "string";
	setAttr ".do" 1;
	setAttr ".mtoaVersion" -type "string" "1.4.0";
createNode displayLayer -n "skel_lay";
	addAttr -ci true -h true -sn "mtoaVersion" -ln "mtoaVersion" -dt "string";
	setAttr ".do" 5;
	setAttr ".mtoaVersion" -type "string" "1.4.0";
createNode hyperGraphInfo -n "nodeEditorPanel1Info";
createNode hyperView -n "hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr ".anf" yes;
createNode groupId -n "groupId105";
	setAttr ".ihi" 0;
createNode groupId -n "groupId106";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "cheval_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode groupId -n "groupId112";
	setAttr ".ihi" 0;
createNode groupId -n "groupId113";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "polyBridgeEdge3";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "cheval_polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "polyBridgeEdge4";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode groupId -n "groupId120";
	setAttr ".ihi" 0;
createNode groupId -n "groupId121";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "polyBridgeEdge5";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "equipements_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode brush -n "equipements_art3dPaintLastPaintBrush";
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode polyBridgeEdge -n "equipements_polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode brush -n "equipements_art3dPaintLastPaintBrush1";
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode hyperGraphInfo -n "HorseAndRiderMR_nodeEditorPanel1Info";
createNode hyperView -n "HorseAndRiderMR_hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "HorseAndRiderMR_hyperLayout1";
	setAttr ".ihi" 0;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel2Info";
createNode hyperView -n "hyperView2";
	setAttr ".vl" -type "double2" -114.28571428571428 -288.09523809523813 ;
	setAttr ".vh" -type "double2" 441.66666666666674 30.952380952380956 ;
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout2";
	setAttr ".ihi" 0;
	setAttr -s 3 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel3Info";
createNode hyperView -n "hyperView3";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout3";
	setAttr ".ihi" 0;
	setAttr -s 6 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel4Info";
createNode hyperView -n "hyperView4";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout4";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel5Info";
createNode hyperView -n "hyperView5";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout5";
	setAttr ".ihi" 0;
	setAttr -s 12 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel6Info";
createNode hyperView -n "hyperView6";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout6";
	setAttr ".ihi" 0;
	setAttr -s 15 ".hyp";
	setAttr ".anf" yes;
createNode groupId -n "groupId543";
	setAttr ".ihi" 0;
createNode groupId -n "groupId544";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "polyBridgeEdge6";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "equipements_polyBridgeEdge3";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode brush -n "equipements_art3dPaintLastPaintBrush2";
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode polyBridgeEdge -n "equipements_polyBridgeEdge4";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode brush -n "equipements_art3dPaintLastPaintBrush3";
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode hyperGraphInfo -n "nodeEditorPanel1Info1";
createNode hyperView -n "hyperView7";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout7";
	setAttr ".ihi" 0;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel2Info1";
createNode hyperView -n "hyperView8";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout8";
	setAttr ".ihi" 0;
	setAttr -s 3 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel3Info1";
createNode hyperView -n "hyperView9";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout9";
	setAttr ".ihi" 0;
	setAttr -s 6 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel4Info1";
createNode hyperView -n "hyperView10";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout10";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel5Info1";
createNode hyperView -n "hyperView11";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout11";
	setAttr ".ihi" 0;
	setAttr -s 12 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "nodeEditorPanel6Info1";
createNode hyperView -n "hyperView12";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout12";
	setAttr ".ihi" 0;
	setAttr -s 15 ".hyp";
	setAttr ".anf" yes;
createNode groupId -n "su_Cheval_HD_Param:groupId2";
	setAttr ".ihi" 0;
createNode groupId -n "su_Cheval_HD_Param:groupId4";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "su_Cheval_HD_Param:polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode reference -n "su_Cheval_HD_Param:cavalierRN";
	setAttr -s 3 ".fn";
	setAttr ".fn[0]" -type "string" "N:/assets/alesiaCharacters/su_Romain_HD_Param.mb";
	setAttr ".fn[1]" -type "string" "V:/alesia/b_prepa/3d_pr//scenes/2anim/su_Romain.mb";
	setAttr ".fn[2]" -type "string" "V:/alesia/b_prepa/3d_pr//scenes/2anim/su_perso.mb";
	setAttr -s 14 ".phl";
	setAttr ".phl[1]" 1;
	setAttr ".phl[2]" 1;
	setAttr ".phl[3]" 1;
	setAttr ".phl[4]" 0.6736554857661109;
	setAttr ".phl[5]" 2.4651903288156619e-032;
	setAttr ".phl[6]" 0;
	setAttr ".phl[7]" 0;
	setAttr ".phl[8]" 0;
	setAttr ".phl[9]" 0;
	setAttr ".phl[10]" 0;
	setAttr ".phl[11]" 0;
	setAttr ".phl[12]" 0;
	setAttr ".phl[13]" 0;
	setAttr ".phl[14]" 0;
	setAttr ".ed" -type "dataReferenceEdits" 
		"su_Cheval_HD_Param:cavalierRN"
		"cavalierRN" 57
		0 "|cavalierRNfosterParent1|cavalier:Main_scaleConstraint1" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main" 
		"-s -r "
		0 "|cavalierRNfosterParent1|cavalier:Main_parentConstraint1" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main" 
		"-s -r "
		2 "|cavalierRNgroup|cavalier:equipements_romain:TENUE_ROMAIN|cavalier:equipements_romain:GRP_ENSEIGNE_DE_COHORTE" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:equipements_romain:TENUE_ROMAIN|cavalier:equipements_romain:glaive" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:equipements_romain:TENUE_ROMAIN|cavalier:equipements_romain:GRP_BOUCLIER_FANTASSIN" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:equipements_romain:TENUE_ROMAIN|cavalier:equipements_romain:GRP_LANCE_fantassin" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKSystem|cavalier:RootCenterBtwLegsBlended_M|cavalier:CenterOffset_M|cavalier:CenterExtra_M|cavalier:Center_M" 
		"CenterBtwFeet" " -k 1 10"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKSystem|cavalier:RootCenterBtwLegsBlended_M|cavalier:CenterOffset_M|cavalier:CenterExtra_M|cavalier:Center_M|cavalier:FKOffsetRoot_M|cavalier:FKExtraRoot_M|cavalier:FKRoot_M|cavalier:HipSwingerGroupRoot_M|cavalier:FKXRoot_M|cavalier:HipSwingerStabalizeRoot_M|cavalier:FKOffsetBackA_M|cavalier:FKExtraBackA_M|cavalier:FKBackA_M" 
		"rotate" " -type \"double3\" 0 0 8.187805"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKSystem|cavalier:RootCenterBtwLegsBlended_M|cavalier:CenterOffset_M|cavalier:CenterExtra_M|cavalier:Center_M|cavalier:FKOffsetRoot_M|cavalier:FKExtraRoot_M|cavalier:FKRoot_M|cavalier:HipSwingerGroupRoot_M|cavalier:FKXRoot_M|cavalier:HipSwingerStabalizeRoot_M|cavalier:FKOffsetBackA_M|cavalier:FKExtraBackA_M|cavalier:FKBackA_M|cavalier:FKXBackA_M|cavalier:FKOffsetBackB_M|cavalier:FKExtraBackB_M|cavalier:FKBackB_M" 
		"translate" " -type \"double3\" 0 0 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKSystem|cavalier:RootCenterBtwLegsBlended_M|cavalier:CenterOffset_M|cavalier:CenterExtra_M|cavalier:Center_M|cavalier:FKOffsetRoot_M|cavalier:FKExtraRoot_M|cavalier:FKRoot_M|cavalier:HipSwingerGroupRoot_M|cavalier:FKXRoot_M|cavalier:HipSwingerStabalizeRoot_M|cavalier:FKOffsetBackA_M|cavalier:FKExtraBackA_M|cavalier:FKBackA_M|cavalier:FKXBackA_M|cavalier:FKOffsetBackB_M|cavalier:FKExtraBackB_M|cavalier:FKBackB_M" 
		"rotate" " -type \"double3\" 0 0 8.187805"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKSystem|cavalier:RootCenterBtwLegsBlended_M|cavalier:CenterOffset_M|cavalier:CenterExtra_M|cavalier:Center_M|cavalier:FKOffsetRoot_M|cavalier:FKExtraRoot_M|cavalier:FKRoot_M|cavalier:HipSwingerGroupRoot_M|cavalier:FKXRoot_M|cavalier:HipSwingerStabalizeRoot_M|cavalier:FKOffsetBackA_M|cavalier:FKExtraBackA_M|cavalier:FKBackA_M|cavalier:FKXBackA_M|cavalier:FKOffsetBackB_M|cavalier:FKExtraBackB_M|cavalier:FKBackB_M|cavalier:FKXBackB_M|cavalier:FKOffsetChest_M|cavalier:FKExtraChest_M|cavalier:FKChest_M" 
		"rotate" " -type \"double3\" 0 0 8.187805"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKSystem|cavalier:RootCenterBtwLegsBlended_M|cavalier:CenterOffset_M|cavalier:CenterExtra_M|cavalier:Center_M|cavalier:HipSwingerOffsetRoot_M|cavalier:HipSwingerRoot_M" 
		"rotate" " -type \"double3\" 3.077593 2.28932 -12.943787"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintArm_R|cavalier:IKExtraArm_R|cavalier:IKArm_R" 
		"translate" " -type \"double3\" 0 0 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintArm_R|cavalier:IKExtraArm_R|cavalier:IKArm_R" 
		"rotate" " -type \"double3\" 0 0 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintArm_R|cavalier:IKExtraArm_R|cavalier:IKArm_R" 
		"rotateOrder" " 5"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintLeg_R|cavalier:IKExtraLeg_R|cavalier:IKLeg_R" 
		"translate" " -type \"double3\" -0.210556 0.133992 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintLeg_R|cavalier:IKExtraLeg_R|cavalier:IKLeg_R" 
		"rotate" " -type \"double3\" 26.018124 -27.086372 5.997276"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintLeg_R|cavalier:IKExtraLeg_R|cavalier:IKLeg_R" 
		"rotateOrder" " 3"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintSpine4_M|cavalier:IKExtraSpine4_M|cavalier:IKSpine4_M|cavalier:IKXSpineHandle_M" 
		"translate" " -type \"double3\" 0 0.673665 -4.07341e-005"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintSpine4_M|cavalier:IKExtraSpine4_M|cavalier:IKSpine4_M|cavalier:IKXSpineHandle_M" 
		"rotate" " -type \"double3\" 90 4.411771 90"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintArm_L|cavalier:IKExtraArm_L|cavalier:IKArm_L" 
		"translate" " -type \"double3\" 0 0 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintArm_L|cavalier:IKExtraArm_L|cavalier:IKArm_L" 
		"rotate" " -type \"double3\" 0 0 0"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintArm_L|cavalier:IKExtraArm_L|cavalier:IKArm_L" 
		"rotateOrder" " 5"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintLeg_L|cavalier:IKExtraLeg_L|cavalier:IKLeg_L" 
		"translate" " -type \"double3\" 0.209769 0.159728 0.00252807"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintLeg_L|cavalier:IKExtraLeg_L|cavalier:IKLeg_L" 
		"rotate" " -type \"double3\" 32.106564 32.162711 -2.102036"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:IKSystem|cavalier:IKHandle|cavalier:IKParentConstraintLeg_L|cavalier:IKExtraLeg_L|cavalier:IKLeg_L" 
		"rotateOrder" " 3"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKIKSystem|cavalier:FKIKParentConstraintArm_R|cavalier:FKIKArm_R" 
		"FKIKBlend" " -k 1 10"
		2 "|cavalierRNgroup|cavalier:PERSO|cavalier:Main|cavalier:MotionSystem|cavalier:FKIKSystem|cavalier:FKIKParentConstraintArm_L|cavalier:FKIKArm_L" 
		"FKIKBlend" " -k 1 10"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:equipements_T_Shirt_gaulois" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:equipements_cheveux_gaulois" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_ARC" "visibility" 
		" 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_BOUCLIER_GAULOIS_RECTANGLE" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_GLAIVE_GAULOIS" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_FLECHE_01" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_ENSEIGNE_GAULOISE_01" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_ENSEIGNE_GAULOISE_02" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_ENSEIGNE_GAULOISE_03" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_CARNYX" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_BOUCLIER_GAULOIS_TRAITRE_RECTANGLE" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_BOUCLIER_GAULOIS_TRAITRE_OVAL" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_BOUCLIER_GERMAIN_OVAL" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_BOUCLIER_GERMAIN_RECTANGLE" 
		"visibility" " 0"
		2 "|cavalierRNgroup|cavalier:GRP_ACCESSOIRS_GAULOIS|cavalier:GRP_CARQUOIS" 
		"visibility" " 0"
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.scaleX" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[1]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.scaleY" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[2]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.scaleZ" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[3]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.translateY" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[4]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.translateX" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[5]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.translateZ" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[6]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.rotateX" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[7]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.rotateY" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[8]" ""
		5 4 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.rotateZ" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[9]" ""
		5 3 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.rotateOrder" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[10]" ""
		5 3 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.parentInverseMatrix" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[11]" ""
		5 3 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.parentInverseMatrix" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[12]" ""
		5 3 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.rotatePivot" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[13]" ""
		5 3 "su_Cheval_HD_Param:cavalierRN" "|cavalierRNgroup|cavalier:PERSO|cavalier:Main.rotatePivotTranslate" 
		"su_Cheval_HD_Param:cavalierRN.placeHolderList[14]" "";
	setAttr ".ptag" -type "string" "";
lockNode -l 1 ;
createNode polyBridgeEdge -n "su_Cheval_HD_Param:cheval_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "su_Cheval_HD_Param:polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode reference -n "su_Cheval_HD_Param:sharedReferenceNode";
	setAttr ".ed" -type "dataReferenceEdits" 
		"su_Cheval_HD_Param:sharedReferenceNode";
createNode groupId -n "su_Gaulois_Cavalier_HD_Param:groupId2";
	setAttr ".ihi" 0;
createNode groupId -n "su_Gaulois_Cavalier_HD_Param:groupId4";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "su_Gaulois_Cavalier_HD_Param:polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "su_Gaulois_Cavalier_HD_Param:cheval_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "su_Gaulois_Cavalier_HD_Param:polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode groupId -n "su_Gaulois_Cavalier_HD_Param:cavalier:groupId2";
	setAttr ".ihi" 0;
createNode groupId -n "su_Gaulois_Cavalier_HD_Param:cavalier:groupId4";
	setAttr ".ihi" 0;
createNode polyBridgeEdge -n "su_Gaulois_Cavalier_HD_Param:cavalier:polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "su_Gaulois_Cavalier_HD_Param:cavalier:equipements_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode brush -n "su_Gaulois_Cavalier_HD_Param:cavalier:equipements_art3dPaintLastPaintBrush";
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode polyBridgeEdge -n "su_Gaulois_Cavalier_HD_Param:cavalier:equipements_polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode brush -n "su_Gaulois_Cavalier_HD_Param:cavalier:equipements_art3dPaintLastPaintBrush1";
	setAttr ".lcl[0]"  0 0.5 1;
	setAttr ".pcl[0]"  0 0.5 1;
	setAttr ".wsc[0]"  0 1 1;
	setAttr ".lws[0]"  0 1 1;
	setAttr ".pws[0]"  0 1 1;
	setAttr ".tls[0]"  0 1 1;
	setAttr -s 3 ".env";
	setAttr ".env[0].envp" 0.20000000298023224;
	setAttr ".env[0].envc" -type "float3" 0 0 0.15000001 ;
	setAttr ".env[0].envi" 2;
	setAttr ".env[1].envp" 0.5;
	setAttr ".env[1].envc" -type "float3" 0.47999999 0.55000001 0.69999999 ;
	setAttr ".env[1].envi" 2;
	setAttr ".env[2].envp" 1;
	setAttr ".env[2].envc" -type "float3" 0 0.1 0.44999999 ;
	setAttr ".env[2].envi" 2;
	setAttr ".rro[0]"  0 1 1;
createNode hyperGraphInfo -n "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info";
createNode hyperView -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1";
	setAttr ".ihi" 0;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel2Info";
createNode hyperView -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2";
	setAttr ".dag" no;
createNode hyperLayout -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2";
	setAttr ".ihi" 0;
	setAttr -s 3 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel3Info";
createNode hyperView -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView3";
	setAttr ".dag" no;
createNode hyperLayout -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3";
	setAttr ".ihi" 0;
	setAttr -s 6 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel4Info";
createNode hyperView -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView4";
	setAttr ".dag" no;
createNode hyperLayout -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel5Info";
createNode hyperView -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView5";
	setAttr ".dag" no;
createNode hyperLayout -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5";
	setAttr ".ihi" 0;
	setAttr -s 12 ".hyp";
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel6Info";
createNode hyperView -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView6";
	setAttr ".dag" no;
createNode hyperLayout -n "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6";
	setAttr ".ihi" 0;
	setAttr -s 15 ".hyp";
	setAttr ".anf" yes;
createNode displayLayer -n "DL_Horse_MDL";
	setAttr ".do" 1;
createNode displayLayer -n "DL_Horse_SKLTN";
	setAttr ".v" no;
	setAttr ".c" 2;
	setAttr ".do" 2;
createNode displayLayer -n "DL_Horse_CTRLs";
	setAttr ".do" 3;
createNode displayLayer -n "DL_Rider_MDL";
	setAttr ".do" 4;
createNode displayLayer -n "DL_Rider_SKLTN";
	setAttr ".v" no;
	setAttr ".c" 2;
	setAttr ".do" 5;
createNode displayLayer -n "DL_Rider_CTRLs";
	setAttr ".do" 6;
createNode displayLayer -n "DL_Crowd_SKLT";
	setAttr ".do" 7;
createNode displayLayer -n "jointLayer";
	setAttr ".do" 1;
createNode displayLayer -n "FortressSoldier_jointLayer1";
	setAttr ".do" 2;
createNode polyBridgeEdge -n "RomanSoldier_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "RomanSoldier_polyBridgeEdge2";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode polyBridgeEdge -n "_Perso_Apoils_256_TX_polyBridgeEdge1";
	setAttr ".c[0]"  0 1 1;
	setAttr ".dv" 5;
createNode hyperGraphInfo -n "RomanSoldier_nodeEditorPanel1Info";
createNode hyperView -n "RomanSoldier_hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "RomanSoldier_hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "RomanSoldier_nodeEditorPanel2Info";
createNode hyperView -n "RomanSoldier_hyperView2";
	setAttr ".dag" no;
createNode hyperLayout -n "RomanSoldier_hyperLayout2";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "RomanSoldier_nodeEditorPanel3Info";
createNode hyperView -n "RomanSoldier_hyperView3";
	setAttr ".dag" no;
createNode hyperLayout -n "RomanSoldier_hyperLayout3";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "RomanSoldier_nodeEditorPanel4Info";
createNode hyperView -n "RomanSoldier_hyperView4";
	setAttr ".dag" no;
createNode hyperLayout -n "RomanSoldier_hyperLayout4";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "RomanSoldier_nodeEditorPanel5Info";
createNode hyperView -n "RomanSoldier_hyperView5";
	setAttr ".dag" no;
createNode hyperLayout -n "RomanSoldier_hyperLayout5";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".anf" yes;
createNode hyperGraphInfo -n "RomanSoldier_nodeEditorPanel6Info";
createNode hyperView -n "RomanSoldier_hyperView6";
	setAttr ".dag" no;
createNode hyperLayout -n "RomanSoldier_hyperLayout6";
	setAttr ".ihi" 0;
	setAttr -s 9 ".hyp";
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".anf" yes;
createNode script -n "script1";
	addAttr -ci true -sn "crnd" -ln "currentRenderer" -dt "string";
	addAttr -ci true -sn "sstp" -ln "shadersStartPath" -dt "string";
	addAttr -ci true -sn "lprp" -ln "isLightProps" -dt "string";
	addAttr -ci true -sn "ecdlg" -ln "enableConfirmDialog" -dt "string";
	setAttr ".b" -type "string" "string $packdir = `dirmap -cd \"/atomo/pipeline/tools/golaem/characterPack/5.2/\"`;string $scriptName = $packdir + \"script/sampleGUI.mel\";eval(\"source \\\"\" + $scriptName + \"\\\"\");glmCrowdSampleConfig(\"\");";
	setAttr ".a" -type "string" "glmDeleteSampleConfigWindow()";
	setAttr ".st" 2;
	setAttr ".sstp" -type "string" "golaem/shaders/CMO-man_golaem;golaem/shaders/CMO-wom_golaem;golaem/shaders/CMO-man_golaem-light;golaem/shaders/HorseAndRider;golaem/shaders/FortressSoldier;golaem/shaders/RomanSoldier";
	setAttr ".ecdlg" -type "string" "1";
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
		+ "                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n"
		+ "                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n"
		+ "                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n"
		+ "            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n"
		+ "            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n"
		+ "            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n                -docTag \"isolOutln_fromSeln\" \n                -showShapes 0\n"
		+ "                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 1\n                -showPublishedAsConnected 0\n                -showContainerContents 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n"
		+ "                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n"
		+ "            -showReferenceNodes 0\n            -showReferenceMembers 0\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 0\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n"
		+ "            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n"
		+ "                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n"
		+ "                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n"
		+ "                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n"
		+ "                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n"
		+ "                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n"
		+ "                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n"
		+ "                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n"
		+ "                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n"
		+ "                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n"
		+ "                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"sequenceEditorPanel\" -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n"
		+ "                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n"
		+ "                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -ignoreAssets 1\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -keyReleaseCommand \"nodeEdKeyReleaseCommand\" \n                -nodeTitleMode \"name\" \n"
		+ "                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -island 0\n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -syncedSelection 1\n                -extendToShapes 1\n                $editorName;\n\t\t\tif (`objExists nodeEditorPanel1Info`) nodeEditor -e -restoreInfo nodeEditorPanel1Info $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -ignoreAssets 1\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n"
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
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"wireframe\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"wireframe\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
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
	setAttr -s 6 ".dsm";
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
connectAttr ":time1.o" "crowdManagerShape.ct";
connectAttr "crowdArchiver.msg" "crowdManagerShape.car";
connectAttr "terrainShape1.msg" "crowdManagerShape.trr";
connectAttr "romanSoldierShape.msg" "crowdManagerShape.ine[0]";
connectAttr "FortressSoldierShape.msg" "crowdManagerShape.ine[1]";
connectAttr "horseAndRiderShape.msg" "crowdManagerShape.ine[2]";
connectAttr "CrowdManShape.msg" "crowdManagerShape.ine[3]";
connectAttr "CrowdWomanShape.msg" "crowdManagerShape.ine[4]";
connectAttr "CrowdManLightShape.msg" "crowdManagerShape.ine[5]";
connectAttr "entityTypeContainerShape1.msg" "romanSoldierShape.ibc";
connectAttr "entityTypeContainerShape1.ib" "entityTypeContainerShape1.fb[0]";
connectAttr "entityTypeContainerShape2.ib" "entityTypeContainerShape2.fb[0]";
connectAttr "entityTypeContainerShape3.ib" "entityTypeContainerShape3.fb[0]";
connectAttr "entityTypeContainerShape4.ib" "entityTypeContainerShape4.fb[0]";
connectAttr "entityTypeContainerShape5.ib" "entityTypeContainerShape5.fb[0]";
connectAttr "entityTypeContainerShape6.ib" "entityTypeContainerShape6.fb[0]";
connectAttr "terrainShape1.msg" "romanSoldierPopToolShape.int";
connectAttr "romanSoldierShape.msg" "romanSoldierPopToolShape.ine" -na;
connectAttr "crowdManagerShape.rgs" "romanSoldierPopToolShape.ps";
connectAttr "annotationLocator1Shape.wm" "annotationShape1.dom" -na;
connectAttr ":time1.o" "romanSoldierParticleShape.cti";
connectAttr "crowdManagerShape.sf" "romanSoldierParticleShape.stf";
connectAttr "crowdField1.of[0]" "romanSoldierParticleShape.ifc[0]";
connectAttr "crowdManagerShape.sf" "crowdField1.sf";
connectAttr "crowdManagerShape.sep" "crowdField1.sep";
connectAttr "crowdManagerShape.dep" "crowdField1.dep";
connectAttr "crowdManagerShape.scl" "crowdField1.scl";
connectAttr "romanSoldierParticleShape.fd" "crowdField1.ind[0]";
connectAttr "fortressSoldierParticleShape.fd" "crowdField1.ind[1]";
connectAttr "horseAndRiderParticleShape.fd" "crowdField1.ind[2]";
connectAttr "crowdManParticleShape.fd" "crowdField1.ind[3]";
connectAttr "crowdWomanParticleShape.fd" "crowdField1.ind[4]";
connectAttr "crowdManLightParticleShape.fd" "crowdField1.ind[5]";
connectAttr "romanSoldierParticleShape.ppfd[0]" "crowdField1.ppda[0]";
connectAttr "fortressSoldierParticleShape.ppfd[0]" "crowdField1.ppda[1]";
connectAttr "horseAndRiderParticleShape.ppfd[0]" "crowdField1.ppda[2]";
connectAttr "crowdManParticleShape.ppfd[0]" "crowdField1.ppda[3]";
connectAttr "crowdWomanParticleShape.ppfd[0]" "crowdField1.ppda[4]";
connectAttr "crowdManLightParticleShape.ppfd[0]" "crowdField1.ppda[5]";
connectAttr "FortressSoldierShape.msg" "fortressSoldierPopToolShape.ine" -na;
connectAttr "annotationLocator2Shape.wm" "annotationShape2.dom" -na;
connectAttr "entityTypeContainerShape2.msg" "FortressSoldierShape.ibc";
connectAttr ":time1.o" "fortressSoldierParticleShape.cti";
connectAttr "crowdManagerShape.sf" "fortressSoldierParticleShape.stf";
connectAttr "crowdField1.of[1]" "fortressSoldierParticleShape.ifc[0]";
connectAttr "entityTypeContainerShape3.msg" "horseAndRiderShape.ibc";
connectAttr "horseAndRiderShape.msg" "horseAndRiderPopToolShape.ine" -na;
connectAttr "annotationLocator3Shape.wm" "annotationShape3.dom" -na;
connectAttr ":time1.o" "horseAndRiderParticleShape.cti";
connectAttr "crowdManagerShape.sf" "horseAndRiderParticleShape.stf";
connectAttr "crowdField1.of[2]" "horseAndRiderParticleShape.ifc[0]";
connectAttr "CrowdManShape.msg" "CrowdManPopToolShape.ine" -na;
connectAttr "annotationLocator4Shape.wm" "annotationShape4.dom" -na;
connectAttr "entityTypeContainerShape4.msg" "CrowdManShape.ibc";
connectAttr ":time1.o" "crowdManParticleShape.cti";
connectAttr "crowdManagerShape.sf" "crowdManParticleShape.stf";
connectAttr "crowdField1.of[3]" "crowdManParticleShape.ifc[0]";
connectAttr "CrowdWomanShape.msg" "CrowdWomanPopToolShape.ine" -na;
connectAttr "annotationLocator5Shape.wm" "annotationShape5.dom" -na;
connectAttr "entityTypeContainerShape5.msg" "CrowdWomanShape.ibc";
connectAttr ":time1.o" "crowdWomanParticleShape.cti";
connectAttr "crowdManagerShape.sf" "crowdWomanParticleShape.stf";
connectAttr "crowdField1.of[4]" "crowdWomanParticleShape.ifc[0]";
connectAttr "CrowdManLightShape.msg" "CrowdManLightPopToolShape.ine" -na;
connectAttr "annotationLocator6Shape.wm" "annotationShape6.dom" -na;
connectAttr "entityTypeContainerShape6.msg" "CrowdManLightShape.ibc";
connectAttr ":time1.o" "crowdManLightParticleShape.cti";
connectAttr "crowdManagerShape.sf" "crowdManLightParticleShape.stf";
connectAttr "crowdField1.of[5]" "crowdManLightParticleShape.ifc[0]";
connectAttr "annotationLocator7Shape.wm" "annotationShape7.dom" -na;
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "layerManager.dli[1]" "body_lay.id";
connectAttr "layerManager.dli[2]" "head_lay.id";
connectAttr "layerManager.dli[3]" "torso_lay.id";
connectAttr "layerManager.dli[4]" "legs_lay.id";
connectAttr "layerManager.dli[5]" "skel_lay.id";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "hyperLayout1.msg" "hyperView1.hl";
connectAttr "HorseAndRiderMR_hyperView1.msg" "HorseAndRiderMR_nodeEditorPanel1Info.b[0]"
		;
connectAttr "HorseAndRiderMR_hyperLayout1.msg" "HorseAndRiderMR_hyperView1.hl";
connectAttr "hyperView2.msg" "nodeEditorPanel2Info.b[0]";
connectAttr "hyperLayout2.msg" "hyperView2.hl";
connectAttr "HorseAndRiderMR_nodeEditorPanel1Info.msg" "hyperLayout2.hyp[15].dn"
		;
connectAttr "HorseAndRiderMR_hyperView1.msg" "hyperLayout2.hyp[16].dn";
connectAttr "HorseAndRiderMR_hyperLayout1.msg" "hyperLayout2.hyp[17].dn";
connectAttr "hyperView3.msg" "nodeEditorPanel3Info.b[0]";
connectAttr "hyperLayout3.msg" "hyperView3.hl";
connectAttr "HorseAndRiderMR_nodeEditorPanel1Info.msg" "hyperLayout3.hyp[15].dn"
		;
connectAttr "HorseAndRiderMR_hyperView1.msg" "hyperLayout3.hyp[16].dn";
connectAttr "HorseAndRiderMR_hyperLayout1.msg" "hyperLayout3.hyp[17].dn";
connectAttr "nodeEditorPanel2Info.msg" "hyperLayout3.hyp[18].dn";
connectAttr "hyperView2.msg" "hyperLayout3.hyp[19].dn";
connectAttr "hyperLayout2.msg" "hyperLayout3.hyp[20].dn";
connectAttr "hyperView4.msg" "nodeEditorPanel4Info.b[0]";
connectAttr "hyperLayout4.msg" "hyperView4.hl";
connectAttr "HorseAndRiderMR_nodeEditorPanel1Info.msg" "hyperLayout4.hyp[15].dn"
		;
connectAttr "HorseAndRiderMR_hyperView1.msg" "hyperLayout4.hyp[16].dn";
connectAttr "HorseAndRiderMR_hyperLayout1.msg" "hyperLayout4.hyp[17].dn";
connectAttr "nodeEditorPanel2Info.msg" "hyperLayout4.hyp[18].dn";
connectAttr "hyperView2.msg" "hyperLayout4.hyp[19].dn";
connectAttr "hyperLayout2.msg" "hyperLayout4.hyp[20].dn";
connectAttr "nodeEditorPanel3Info.msg" "hyperLayout4.hyp[21].dn";
connectAttr "hyperView3.msg" "hyperLayout4.hyp[22].dn";
connectAttr "hyperLayout3.msg" "hyperLayout4.hyp[23].dn";
connectAttr "hyperView5.msg" "nodeEditorPanel5Info.b[0]";
connectAttr "hyperLayout5.msg" "hyperView5.hl";
connectAttr "HorseAndRiderMR_nodeEditorPanel1Info.msg" "hyperLayout5.hyp[15].dn"
		;
connectAttr "HorseAndRiderMR_hyperView1.msg" "hyperLayout5.hyp[16].dn";
connectAttr "HorseAndRiderMR_hyperLayout1.msg" "hyperLayout5.hyp[17].dn";
connectAttr "nodeEditorPanel2Info.msg" "hyperLayout5.hyp[18].dn";
connectAttr "hyperView2.msg" "hyperLayout5.hyp[19].dn";
connectAttr "hyperLayout2.msg" "hyperLayout5.hyp[20].dn";
connectAttr "nodeEditorPanel3Info.msg" "hyperLayout5.hyp[21].dn";
connectAttr "hyperView3.msg" "hyperLayout5.hyp[22].dn";
connectAttr "hyperLayout3.msg" "hyperLayout5.hyp[23].dn";
connectAttr "nodeEditorPanel4Info.msg" "hyperLayout5.hyp[24].dn";
connectAttr "hyperView4.msg" "hyperLayout5.hyp[25].dn";
connectAttr "hyperLayout4.msg" "hyperLayout5.hyp[26].dn";
connectAttr "hyperView6.msg" "nodeEditorPanel6Info.b[0]";
connectAttr "hyperLayout6.msg" "hyperView6.hl";
connectAttr "HorseAndRiderMR_nodeEditorPanel1Info.msg" "hyperLayout6.hyp[15].dn"
		;
connectAttr "HorseAndRiderMR_hyperView1.msg" "hyperLayout6.hyp[16].dn";
connectAttr "HorseAndRiderMR_hyperLayout1.msg" "hyperLayout6.hyp[17].dn";
connectAttr "nodeEditorPanel2Info.msg" "hyperLayout6.hyp[18].dn";
connectAttr "hyperView2.msg" "hyperLayout6.hyp[19].dn";
connectAttr "hyperLayout2.msg" "hyperLayout6.hyp[20].dn";
connectAttr "nodeEditorPanel3Info.msg" "hyperLayout6.hyp[21].dn";
connectAttr "hyperView3.msg" "hyperLayout6.hyp[22].dn";
connectAttr "hyperLayout3.msg" "hyperLayout6.hyp[23].dn";
connectAttr "nodeEditorPanel4Info.msg" "hyperLayout6.hyp[24].dn";
connectAttr "hyperView4.msg" "hyperLayout6.hyp[25].dn";
connectAttr "hyperLayout4.msg" "hyperLayout6.hyp[26].dn";
connectAttr "nodeEditorPanel5Info.msg" "hyperLayout6.hyp[27].dn";
connectAttr "hyperView5.msg" "hyperLayout6.hyp[28].dn";
connectAttr "hyperLayout5.msg" "hyperLayout6.hyp[29].dn";
connectAttr "hyperView7.msg" "nodeEditorPanel1Info1.b[0]";
connectAttr "hyperLayout7.msg" "hyperView7.hl";
connectAttr "hyperView8.msg" "nodeEditorPanel2Info1.b[0]";
connectAttr "hyperLayout8.msg" "hyperView8.hl";
connectAttr "nodeEditorPanel1Info1.msg" "hyperLayout8.hyp[15].dn";
connectAttr "hyperView7.msg" "hyperLayout8.hyp[16].dn";
connectAttr "hyperLayout7.msg" "hyperLayout8.hyp[17].dn";
connectAttr "hyperView9.msg" "nodeEditorPanel3Info1.b[0]";
connectAttr "hyperLayout9.msg" "hyperView9.hl";
connectAttr "nodeEditorPanel1Info1.msg" "hyperLayout9.hyp[15].dn";
connectAttr "hyperView7.msg" "hyperLayout9.hyp[16].dn";
connectAttr "hyperLayout7.msg" "hyperLayout9.hyp[17].dn";
connectAttr "nodeEditorPanel2Info1.msg" "hyperLayout9.hyp[18].dn";
connectAttr "hyperView8.msg" "hyperLayout9.hyp[19].dn";
connectAttr "hyperLayout8.msg" "hyperLayout9.hyp[20].dn";
connectAttr "hyperView10.msg" "nodeEditorPanel4Info1.b[0]";
connectAttr "hyperLayout10.msg" "hyperView10.hl";
connectAttr "nodeEditorPanel1Info1.msg" "hyperLayout10.hyp[15].dn";
connectAttr "hyperView7.msg" "hyperLayout10.hyp[16].dn";
connectAttr "hyperLayout7.msg" "hyperLayout10.hyp[17].dn";
connectAttr "nodeEditorPanel2Info1.msg" "hyperLayout10.hyp[18].dn";
connectAttr "hyperView8.msg" "hyperLayout10.hyp[19].dn";
connectAttr "hyperLayout8.msg" "hyperLayout10.hyp[20].dn";
connectAttr "nodeEditorPanel3Info1.msg" "hyperLayout10.hyp[21].dn";
connectAttr "hyperView9.msg" "hyperLayout10.hyp[22].dn";
connectAttr "hyperLayout9.msg" "hyperLayout10.hyp[23].dn";
connectAttr "hyperView11.msg" "nodeEditorPanel5Info1.b[0]";
connectAttr "hyperLayout11.msg" "hyperView11.hl";
connectAttr "nodeEditorPanel1Info1.msg" "hyperLayout11.hyp[15].dn";
connectAttr "hyperView7.msg" "hyperLayout11.hyp[16].dn";
connectAttr "hyperLayout7.msg" "hyperLayout11.hyp[17].dn";
connectAttr "nodeEditorPanel2Info1.msg" "hyperLayout11.hyp[18].dn";
connectAttr "hyperView8.msg" "hyperLayout11.hyp[19].dn";
connectAttr "hyperLayout8.msg" "hyperLayout11.hyp[20].dn";
connectAttr "nodeEditorPanel3Info1.msg" "hyperLayout11.hyp[21].dn";
connectAttr "hyperView9.msg" "hyperLayout11.hyp[22].dn";
connectAttr "hyperLayout9.msg" "hyperLayout11.hyp[23].dn";
connectAttr "nodeEditorPanel4Info1.msg" "hyperLayout11.hyp[24].dn";
connectAttr "hyperView10.msg" "hyperLayout11.hyp[25].dn";
connectAttr "hyperLayout10.msg" "hyperLayout11.hyp[26].dn";
connectAttr "hyperView12.msg" "nodeEditorPanel6Info1.b[0]";
connectAttr "hyperLayout12.msg" "hyperView12.hl";
connectAttr "nodeEditorPanel1Info1.msg" "hyperLayout12.hyp[15].dn";
connectAttr "hyperView7.msg" "hyperLayout12.hyp[16].dn";
connectAttr "hyperLayout7.msg" "hyperLayout12.hyp[17].dn";
connectAttr "nodeEditorPanel2Info1.msg" "hyperLayout12.hyp[18].dn";
connectAttr "hyperView8.msg" "hyperLayout12.hyp[19].dn";
connectAttr "hyperLayout8.msg" "hyperLayout12.hyp[20].dn";
connectAttr "nodeEditorPanel3Info1.msg" "hyperLayout12.hyp[21].dn";
connectAttr "hyperView9.msg" "hyperLayout12.hyp[22].dn";
connectAttr "hyperLayout9.msg" "hyperLayout12.hyp[23].dn";
connectAttr "nodeEditorPanel4Info1.msg" "hyperLayout12.hyp[24].dn";
connectAttr "hyperView10.msg" "hyperLayout12.hyp[25].dn";
connectAttr "hyperLayout10.msg" "hyperLayout12.hyp[26].dn";
connectAttr "nodeEditorPanel5Info1.msg" "hyperLayout12.hyp[27].dn";
connectAttr "hyperView11.msg" "hyperLayout12.hyp[28].dn";
connectAttr "hyperLayout11.msg" "hyperLayout12.hyp[29].dn";
connectAttr "su_Cheval_HD_Param:sharedReferenceNode.sr" "su_Cheval_HD_Param:cavalierRN.sr"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info.b[0]"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.hl"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel2Info.b[0]"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2.hl"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.hyp[15].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.hyp[16].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.hyp[17].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel3Info.b[0]"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView3.hl"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.hyp[15].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.hyp[16].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.hyp[17].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel2Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.hyp[18].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.hyp[19].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.hyp[20].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView4.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel4Info.b[0]"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView4.hl"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[15].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[16].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[17].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel2Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[18].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[19].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[20].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel3Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[21].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[22].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.hyp[23].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView5.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel5Info.b[0]"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView5.hl"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[15].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[16].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[17].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel2Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[18].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[19].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[20].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel3Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[21].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[22].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[23].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel4Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[24].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView4.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[25].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.hyp[26].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView6.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel6Info.b[0]"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView6.hl"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel1Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[15].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[16].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout1.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[17].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel2Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[18].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[19].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout2.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[20].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel3Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[21].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[22].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout3.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[23].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel4Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[24].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView4.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[25].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout4.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[26].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:nodeEditorPanel5Info.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[27].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperView5.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[28].dn"
		;
connectAttr "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout5.msg" "su_Gaulois_Cavalier_HD_Param:cavalier:hyperLayout6.hyp[29].dn"
		;
connectAttr "layerManager.dli[6]" "DL_Horse_MDL.id";
connectAttr "layerManager.dli[7]" "DL_Horse_SKLTN.id";
connectAttr "layerManager.dli[8]" "DL_Horse_CTRLs.id";
connectAttr "layerManager.dli[9]" "DL_Rider_MDL.id";
connectAttr "layerManager.dli[10]" "DL_Rider_SKLTN.id";
connectAttr "layerManager.dli[11]" "DL_Rider_CTRLs.id";
connectAttr "layerManager.dli[12]" "DL_Crowd_SKLT.id";
connectAttr "layerManager.dli[13]" "jointLayer.id";
connectAttr "layerManager.dli[14]" "FortressSoldier_jointLayer1.id";
connectAttr "RomanSoldier_hyperView1.msg" "RomanSoldier_nodeEditorPanel1Info.b[0]"
		;
connectAttr "RomanSoldier_hyperLayout1.msg" "RomanSoldier_hyperView1.hl";
connectAttr "RomanSoldier_hyperView2.msg" "RomanSoldier_nodeEditorPanel2Info.b[0]"
		;
connectAttr "RomanSoldier_hyperLayout2.msg" "RomanSoldier_hyperView2.hl";
connectAttr "RomanSoldier_hyperView3.msg" "RomanSoldier_nodeEditorPanel3Info.b[0]"
		;
connectAttr "RomanSoldier_hyperLayout3.msg" "RomanSoldier_hyperView3.hl";
connectAttr "RomanSoldier_hyperView4.msg" "RomanSoldier_nodeEditorPanel4Info.b[0]"
		;
connectAttr "RomanSoldier_hyperLayout4.msg" "RomanSoldier_hyperView4.hl";
connectAttr "RomanSoldier_hyperView5.msg" "RomanSoldier_nodeEditorPanel5Info.b[0]"
		;
connectAttr "RomanSoldier_hyperLayout5.msg" "RomanSoldier_hyperView5.hl";
connectAttr "RomanSoldier_hyperView6.msg" "RomanSoldier_nodeEditorPanel6Info.b[0]"
		;
connectAttr "RomanSoldier_hyperLayout6.msg" "RomanSoldier_hyperView6.hl";
connectAttr "romanSoldierParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "fortressSoldierParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "horseAndRiderParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "crowdManParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "crowdWomanParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "crowdManLightParticleShape.iog" ":initialParticleSE.dsm" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr ":perspShape.msg" ":defaultRenderGlobals.sc";
// End of characterPackAssetsTestScene.ma
