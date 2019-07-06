//Maya ASCII 2014 scene
//Name: physicsFlyingSaucer.ma
//Last modified: Wed, Mar 30, 2016 11:45:13 PM
//Codeset: 1252
requires maya "2014";
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
		 -nodeType "CrowdBeScript" -nodeType "CrowdBeSteer" -nodeType "CrowdBeFlock" -nodeType "CrowdBeSetBone"
		 -nodeType "CrowdBeContainer" -nodeType "CrowdBeOpLoop" -nodeType "CrowdBeOpParallel"
		 -nodeType "CrowdBeOpNoOrder" -nodeType "CrowdBeOpAlternative" -nodeType "CrowdBeOpRandom"
		 -nodeType "CrowdBeOpBlock" -nodeType "CrowdBeOpAnchor" -nodeType "CrowdBeOpCondition"
		 -nodeType "CrowdBeCloth" -nodeType "CrowdBeUVPin" -nodeType "AbstractCrowdTri" -nodeType "AbstractSingleCrowdTri"
		 -nodeType "AbstractCompositeCrowdTri" -nodeType "CrowdTriFrame" -nodeType "CrowdTriRandom"
		 -nodeType "CrowdTriPolygonZone" -nodeType "CrowdTriPaintedZone" -nodeType "CrowdTriDistance"
		 -nodeType "CrowdTriPPAttribute" -nodeType "CrowdTriDrivenAttribute" -nodeType "CrowdTriExpression"
		 -nodeType "CrowdTriScript" -nodeType "CrowdTriBehaviorTime" -nodeType "CrowdTriMotionTime"
		 -nodeType "CrowdTriCollision" -nodeType "CrowdTriFade" -nodeType "CrowdTriBoolean"
		 -nodeType "CrowdTriContainer" -nodeType "CrowdTriOpNot" -nodeType "CrowdTriOpAnd"
		 -nodeType "CrowdTriOpOr" -nodeType "CrowdTriOpXor" -nodeType "CrowdPaintManipulator"
		 -nodeType "CrowdEntityTypeNode" -nodeType "CrowdGroupEntityTypeNode" -nodeType "SimulationCacheProxy"
		 -nodeType "CrowdProxyVRay" -nodeType "CrowdProxyRendermanStudio" -nodeType "CrowdSwitchShaderVRay"
		 -nodeType "CrowdHSLShaderVRay" -nodeType "CrowdSwitchShader3Delight" -nodeType "CrowdHSLShader3Delight"
		 -nodeType "CrowdGetUserDataFloat3Delight" -nodeType "CrowdGetUserDataVector3Delight"
		 "glmCrowd" "5.0.4[PR246]-2016/03/30";
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
		 -nodeType "misss_fast_shader_x_passes" -dataType "byteArray" "Mayatomr" "2014.0 - 3.11.1.9 ";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014";
fileInfo "cutIdentifier" "201307170459-880822";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode transform -n "pSphere1";
	setAttr ".s" -type "double3" 1.0208437223176217 1.0208437223176217 1.0208437223176217 ;
createNode mesh -n "pSphereShape1" -p "pSphere1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 382 ".pt";
	setAttr ".pt[0:165]" -type "float3"  -4.5519144e-014 7.5905566 1.5543122e-015 
		-4.5519144e-014 7.5905566 0 -4.5519144e-014 7.5905566 1.4901161e-008 -4.5519144e-014 
		7.5905566 1.4901161e-008 -3.7253374e-009 7.5905566 7.4505806e-009 -4.8627768e-014 
		7.5905566 -3.1086245e-015 1.8625934e-009 7.5905566 -3.1086245e-015 -5.7953642e-014 
		7.5905566 0 9.3126462e-010 7.5905566 -1.8626436e-009 -1.8627062e-009 7.5905566 3.7252947e-009 
		3.7252261e-009 7.5905566 7.4505806e-009 -6.4170891e-014 7.5905566 7.4505806e-009 
		7.4505166e-009 7.5905566 9.3258734e-015 -6.4170891e-014 7.5905566 9.3258734e-015 
		-6.2572181e-014 7.5905566 9.3258734e-015 -6.1062266e-014 7.5905566 7.450593e-009 
		3.7252323e-009 7.5905566 9.3258734e-015 -5.1736393e-014 7.5905566 6.2172489e-015 
		-5.1736393e-014 7.5905566 4.6629367e-015 -1.8626938e-009 7.5905566 3.209476e-015 
		-3.4194869e-014 7.3090343 -1.4901161e-008 -7.4506126e-009 7.3090343 1.4901161e-008 
		-3.4194869e-014 7.3090343 -6.6613381e-015 -3.4194869e-014 7.3090343 -2.9802322e-008 
		-3.7746648e-014 7.3090343 -6.6613381e-015 7.4505406e-009 7.3090343 -6.6613381e-015 
		-4.6629367e-014 7.3090343 -7.4505824e-009 1.8625861e-009 7.3090343 3.7252899e-009 
		-5.9063865e-014 7.3090343 0 -3.7253556e-009 7.3090343 7.4505806e-009 -7.1498363e-014 
		7.3090343 -1.4901161e-008 -7.1498363e-014 7.3090343 -1.490115e-008 -1.4901236e-008 
		7.3090343 1.8207658e-014 -7.1498363e-014 7.3090343 2.9802322e-008 -6.800612e-014 
		7.3090343 1.4901184e-008 -6.5281114e-014 7.3090343 1.8207658e-014 3.7252312e-009 
		7.3090343 1.8207658e-014 -1.8626918e-009 7.3090343 -3.7252783e-009 1.8625985e-009 
		7.3090343 6.2172489e-015 -4.0412118e-014 7.3090343 3.3210296e-015 -1.4901186e-008 
		6.8475409 -2.9802322e-008 -2.4868996e-014 6.8475409 -6.2172489e-015 1.4901138e-008 
		6.8475409 0 -2.1538327e-014 6.8475409 0 -2.7309979e-014 6.8475409 0 -3.3972825e-014 
		6.8475409 0 -4.3520743e-014 6.8475409 0 -4.9737992e-014 6.8475409 -6.2172489e-015 
		-4.9737992e-014 6.8475409 -7.4505806e-009 7.4505184e-009 6.8475409 3.5038983e-015 
		1.4901087e-008 6.8475409 9.3258734e-015 -7.4606987e-014 6.8475409 2.9802322e-008 
		-8.0824236e-014 6.8475409 -2.9802298e-008 -1.4901236e-008 6.8475409 2.9802322e-008 
		-1.4901236e-008 6.8475409 2.4868996e-014 -6.5059069e-014 6.8475409 2.4868996e-014 
		-5.595524e-014 6.8475409 2.4868996e-014 3.7252406e-009 6.8475409 -3.7252716e-009 
		-4.9737992e-014 6.8475409 3.7253027e-009 -3.7303494e-014 6.8475409 1.4901161e-008 
		-8.8817842e-015 6.2174368 0 2.9802305e-008 6.2174368 2.9802322e-008 -8.8817842e-015 
		6.2174368 2.9802322e-008 -2.9802322e-008 6.2174368 -2.4868996e-014 -1.4901186e-008 
		6.2174368 -2.4868996e-014 -2.6645353e-014 6.2174368 -2.4868996e-014 -3.375078e-014 
		6.2174368 -1.4901161e-008 -4.6185278e-014 6.2174368 0 -5.8619776e-014 6.2174368 0 
		-7.4506517e-009 6.2174368 3.7535782e-015 1.4901078e-008 6.2174368 1.2434498e-014 
		-1.4901229e-008 6.2174368 -2.9802298e-008 -8.3488771e-014 6.2174368 -2.9802298e-008 
		2.9802248e-008 6.2174368 2.9802322e-008 1.4901087e-008 6.2174368 2.4868996e-014 1.4901095e-008 
		6.2174368 2.9802322e-008 7.450522e-009 6.2174368 -1.4901136e-008 -4.6185278e-014 
		6.2174368 -7.4505557e-009 -3.375078e-014 6.2174368 7.450593e-009 7.4505593e-009 6.2174368 
		3.7535782e-015 -1.9539925e-014 5.434238 2.9802322e-008 1.2434498e-014 5.434238 0 
		0 5.434238 -5.9604645e-008 -2.9802322e-008 5.434238 5.9604645e-008 -2.9802322e-008 
		5.434238 -2.4868996e-014 -1.4654944e-014 5.434238 -2.4868996e-014 -2.4868996e-014 
		5.434238 -2.4868996e-014 -3.7303494e-014 5.434238 0 3.725221e-009 5.434238 0 -6.9277917e-014 
		5.434238 4.0639214e-015 -6.9277917e-014 5.434238 1.2434498e-014 -2.9802422e-008 5.434238 
		-5.9604645e-008 -7.4606987e-014 5.434238 2.4868996e-014 -2.9802422e-008 5.434238 
		5.9604645e-008 -7.3933921e-014 5.434238 5.9604645e-008 -1.4901222e-008 5.434238 2.4868996e-014 
		-4.9737992e-014 5.434238 2.4868996e-014 3.725253e-009 5.434238 2.4868996e-014 -1.9539925e-014 
		5.434238 1.2434498e-014 1.4901142e-008 5.434238 2.9802322e-008 -1.4901161e-008 4.517231 
		5.9604645e-008 1.5099033e-014 4.517231 5.9604645e-008 1.5099033e-014 4.517231 -2.4868996e-014 
		1.7319479e-014 4.517231 -2.4868996e-014 6.9307704e-015 4.517231 5.9604645e-008 -7.5495166e-015 
		4.517231 -2.9802322e-008 1.4901151e-008 4.517231 -2.4868996e-014 -3.4638958e-014 
		4.517231 0 3.7252406e-009 4.517231 -6.2172489e-015 -2.9802372e-008 4.517231 4.4272875e-015 
		1.4901111e-008 4.517231 -2.9802298e-008 -8.437695e-014 4.517231 2.4868996e-014 2.9802228e-008 
		4.517231 2.4868996e-014 -8.2156504e-014 4.517231 2.4868996e-014 -7.2289553e-014 4.517231 
		2.4868996e-014 -5.7287508e-014 4.517231 -2.9802298e-008 1.4901102e-008 4.517231 2.4868996e-014 
		-3.7253249e-009 4.517231 2.4868996e-014 0 4.517231 -7.4505619e-009 0 4.517231 2.9802322e-008 
		4.3130746 3.657304 -1.8614447 3.6689208 3.4889956 -3.5406806 2.6656239 3.4889956 
		-4.8733301 1.401401 3.4889956 -5.728941 6.5565109e-007 3.4889956 -2.8525989 -1.4014001 
		3.4889956 -5.7289419 -2.6656275 3.4889956 -4.8733263 -3.6689155 3.4889956 -3.5406795 
		-4.313076 3.4889956 -1.8614446 -1.4185436 3.4889956 1.0728836e-006 -4.3130751 3.4889956 
		1.8614465 -3.6689124 3.4889956 3.5406811 -2.6656277 3.4889956 4.8733306 -1.4013996 
		3.4889956 5.728941 4.7683716e-007 3.4889956 2.7432499 1.4014006 3.4889956 5.7289419 
		2.6656275 3.4889956 4.8733282 3.6689153 3.4889956 3.5406806 4.3130765 3.4889956 1.8614463 
		1.4185448 3.4889956 1.1026859e-006 4.6037631 2.3748491 -1.9868984 3.9161959 2.3748491 
		-3.7793064 2.845283 2.3748491 -5.2017689 1.495852 2.3748491 -6.1150465 5.6624413e-007 
		2.3748491 -3.258579 -1.4958515 2.3748491 -6.1150465 -2.8452806 2.3748491 -5.2017679 
		-3.9161873 2.3748491 -3.7793059 -4.6037564 2.3748491 -1.9868979 -1.7241869 2.3748491 
		1.0728836e-006 -4.6037569 2.3748491 1.9869004 -3.9161839 2.3748491 3.7793071 -2.8452797 
		2.3748491 5.2017689 -1.4958528 2.3748491 6.115047 4.1723251e-007 2.3748491 3.149229 
		1.4958508 2.3748491 6.115046 2.8452799 2.3748491 5.2017684 3.9161873 2.3748491 3.7793069 
		4.603756 2.3748491 1.9869001 1.7241871 2.3748491 1.1026859e-006 4.7810812 1.2022253 
		-2.0634279 4.0670357 1.2022253 -3.9248757 2.9548714 1.2022253 -5.4021277 1.5534707 
		1.2022253 -6.3505812 5.6624413e-007 1.2022253 -3.5062351 -1.5534714 1.2022253 -6.3505802;
	setAttr ".pt[166:331]" -2.9548724 1.2022253 -5.4021244 -4.0670276 1.2022253 
		-3.9248734 -4.7810831 1.2022253 -2.0634277 -1.9106387 1.2022253 1.0728836e-006 -4.7810826 
		1.2022253 2.0634291 -4.0670266 1.2022253 3.9248753 -2.9548728 1.2022253 5.4021273 
		-1.5534678 1.2022253 6.3505797 4.4703484e-007 1.2022253 3.3968856 1.5534704 1.2022253 
		6.3505807 2.9548724 1.2022253 5.4021254 4.0670271 1.2022253 3.924876 4.7810831 1.2022253 
		2.0634291 1.9106388 1.2022253 1.0728836e-006 4.8406806 -9.9162967e-014 -2.0891483 
		4.1177311 -1.8421602e-013 -3.9737978 2.9917026 -2.5123678e-013 -5.4694653 1.5728347 
		-2.9366464e-013 -6.4297419 5.9604645e-007 -2.5539502e-013 -3.5894713 -1.5728289 -2.9094335e-013 
		-6.4297423 -2.9917054 -2.460605e-013 -5.4694638 -4.1177297 -1.7709148e-013 -3.9737961 
		-4.8406768 -9.0787648e-014 -2.0891483 -1.9732945 3.6002085e-015 1.0728836e-006 -4.8406773 
		9.916294e-014 2.0891502 -4.1177249 1.8421599e-013 3.9737997 -2.9917045 2.5123664e-013 
		5.4694653 -1.5728283 2.9366453e-013 6.4297414 4.7683716e-007 2.5360351e-013 3.4801214 
		1.5728277 2.9094329e-013 6.4297419 2.991703 2.4606041e-013 5.4694638 4.1177297 1.7709154e-013 
		3.9737992 4.8406773 9.0787661e-014 2.0891497 1.9732945 -3.6001729e-015 1.0430813e-006 
		4.7810812 -1.2022253 -2.0634279 4.0670357 -1.2022253 -3.9248757 2.9548714 -1.2022253 
		-5.4021277 1.5534707 -1.2022253 -6.3505812 5.6624413e-007 -1.2022253 -3.5062351 -1.5534714 
		-1.2022253 -6.3505802 -2.9548724 -1.2022253 -5.4021244 -4.0670276 -1.2022253 -3.9248734 
		-4.7810831 -1.2022253 -2.0634277 -1.9106387 -1.2022253 1.0728836e-006 -4.7810826 
		-1.2022253 2.0634291 -4.0670266 -1.2022253 3.9248753 -2.9548728 -1.2022253 5.4021273 
		-1.5534678 -1.2022253 6.3505797 4.4703484e-007 -1.2022253 3.3968856 1.5534704 -1.2022253 
		6.3505807 2.9548724 -1.2022253 5.4021254 4.0670271 -1.2022253 3.924876 4.7810831 
		-1.2022253 2.0634291 1.9106388 -1.2022253 1.0728836e-006 4.6037631 -2.3748491 -1.9868984 
		3.9161959 -2.3748491 -3.7793064 2.845283 -2.3748491 -5.2017689 1.495852 -2.3748491 
		-6.1150465 5.6624413e-007 -2.3748491 -3.258579 -1.4958515 -2.3748491 -6.1150465 -2.8452806 
		-2.3748491 -5.2017679 -3.9161873 -2.3748491 -3.7793059 -4.6037564 -2.3748491 -1.9868979 
		-1.7241869 -2.3748491 1.0728836e-006 -4.6037569 -2.3748491 1.9869004 -3.9161839 -2.3748491 
		3.7793071 -2.8452797 -2.3748491 5.2017689 -1.4958528 -2.3748491 6.115047 4.1723251e-007 
		-2.3748491 3.149229 1.4958508 -2.3748491 6.115046 2.8452799 -2.3748491 5.2017684 
		3.9161873 -2.3748491 3.7793069 4.603756 -2.3748491 1.9869001 1.7241871 -2.3748491 
		1.1026859e-006 4.3130746 -3.4889956 -1.8614447 3.6689208 -3.4889956 -3.5406806 2.6656239 
		-3.4889956 -4.8733301 1.401401 -3.4889956 -5.728941 6.5565109e-007 -3.4889956 -2.8525989 
		-1.4014001 -3.4889956 -5.7289419 -2.6656275 -3.4889956 -4.8733263 -3.6689155 -3.4889956 
		-3.5406795 -4.313076 -3.4889956 -1.8614446 -1.4185436 -3.4889956 1.0728836e-006 -4.3130751 
		-3.4889956 1.8614465 -3.6689124 -3.4889956 3.5406811 -2.6656277 -3.4889956 4.8733306 
		-1.4013996 -3.4889956 5.728941 4.7683716e-007 -3.4889956 2.7432499 1.4014006 -3.4889956 
		5.7289419 2.6656275 -3.4889956 4.8733282 3.6689153 -3.4889956 3.5406806 4.3130765 
		-3.4889956 1.8614463 1.4185448 -3.4889956 1.1026859e-006 -1.4901111e-008 -4.517231 
		5.9604645e-008 8.437695e-014 -4.517231 5.9604645e-008 8.437695e-014 -4.517231 -2.4868996e-014 
		8.2156504e-014 -4.517231 -2.4868996e-014 7.2289566e-014 -4.517231 5.9604645e-008 
		5.7287508e-014 -4.517231 -2.9802322e-008 1.4901211e-008 -4.517231 -2.4868996e-014 
		3.4638958e-014 -4.517231 0 3.7252903e-009 -4.517231 -6.2172489e-015 -2.9802322e-008 
		-4.517231 8.0072108e-015 1.4901161e-008 -4.517231 -2.9802298e-008 -1.5099033e-014 
		-4.517231 2.4868996e-014 2.9802317e-008 -4.517231 2.4868996e-014 -1.7319479e-014 
		-4.517231 2.4868996e-014 -6.930756e-015 -4.517231 2.4868996e-014 7.5495166e-015 -4.517231 
		-2.9802298e-008 1.4901161e-008 -4.517231 2.4868996e-014 -3.7252557e-009 -4.517231 
		2.4868996e-014 4.9737992e-014 -4.517231 -7.4505619e-009 4.9737992e-014 -4.517231 
		2.9802322e-008 8.3488771e-014 -3.7769678 2.9802322e-008 1.110223e-013 -3.7769678 
		0 9.8587805e-014 -3.7769678 -5.9604645e-008 -2.9802223e-008 -3.7769678 5.9604645e-008 
		-2.9802223e-008 -3.8109839 -2.4868996e-014 8.5265128e-014 -3.7769678 -2.4868996e-014 
		7.3718809e-014 -3.7769678 -2.4868996e-014 6.1284311e-014 -3.7769678 0 3.725324e-009 
		-3.7769678 5.3290705e-015 3.375078e-014 -3.7769678 9.5402244e-015 3.375078e-014 -3.7769678 
		1.7763568e-014 -2.9802322e-008 -3.7769678 -5.9604645e-008 2.3980817e-014 -3.7769678 
		2.4868996e-014 -2.9802298e-008 -3.7769678 5.9604645e-008 2.6047141e-014 -3.7769678 
		5.9604645e-008 -1.4901127e-008 -3.7769678 2.4868996e-014 4.8849813e-014 -3.7769678 
		2.4868996e-014 3.7253516e-009 -3.7769678 2.4868996e-014 8.3488771e-014 -3.7769678 
		1.7763568e-014 1.4901245e-008 -3.7769678 2.9802322e-008 1.0391688e-013 -4.5601664 
		6.2172489e-015 2.9802422e-008 -4.5601664 2.9802322e-008 1.0391688e-013 -4.5601664 
		2.9802322e-008 -2.9802223e-008 -4.5601664 -2.4868996e-014 -1.4901066e-008 -4.5601664 
		-2.4868996e-014 8.4821039e-014 -4.5601664 -2.4868996e-014 7.9047879e-014 -4.5601664 
		-1.4901161e-008 6.6613381e-014 -4.5601664 0 5.4178884e-014 -4.5601664 6.2172489e-015 
		-7.4505389e-009 -4.5601664 9.8505671e-015 1.4901195e-008 -4.5601664 1.8651747e-014 
		-1.4901119e-008 -4.5601664 -2.9802298e-008 2.9309888e-014 -4.5601664 -2.9802298e-008 
		2.9802372e-008 -4.5601664 2.9802322e-008 1.4901198e-008 -4.5601664 2.4868996e-014 
		1.4901211e-008 -4.5601664 2.9802322e-008 7.4506348e-009 -4.5601664 -1.4901136e-008 
		6.6613381e-014 -4.5601664 -7.4505557e-009 7.9047879e-014 -4.5601664 7.4506055e-009 
		7.4506721e-009 -4.5601664 9.8505671e-015 -1.4901065e-008 -5.1902699 -2.9802322e-008 
		9.5923269e-014 -5.1902699 0 1.4901261e-008 -5.1902699 0 9.8809849e-014 -5.1902699 
		0 9.3119807e-014 -5.1902699 0 8.6375351e-014 -5.1902699 0 7.6827433e-014 -5.1902699 
		0 7.1054274e-014 -5.1902699 0 7.1054274e-014 -5.1902699 -7.4505806e-009 7.4506392e-009 
		-5.1902699 1.0100247e-014 1.4901211e-008 -5.1902699 1.5543122e-014 4.6185278e-014 
		-5.1902699 2.9802322e-008;
	setAttr ".pt[332:381]" 3.952394e-014 -5.1902699 -2.9802298e-008 -1.4901117e-008 
		-5.1902699 2.9802322e-008 -1.4901112e-008 -5.1902699 2.4868996e-014 5.5289107e-014 
		-5.1902699 2.4868996e-014 6.4392935e-014 -5.1902699 2.4868996e-014 3.7253614e-009 
		-5.1902699 -3.7252654e-009 7.1054274e-014 -5.1902699 3.7253027e-009 8.3488771e-014 
		-5.1902699 1.4901161e-008 9.2814645e-014 -5.6517649 -1.4901161e-008 -7.4504878e-009 
		-5.6517649 1.4901161e-008 9.2814645e-014 -5.6517649 0 9.3036689e-014 -5.6517649 -2.9802322e-008 
		8.9360417e-014 -5.6517649 0 7.4506676e-009 -5.6517649 0 8.0380147e-014 -5.6517649 
		-7.4505806e-009 1.8627131e-009 -5.6517649 3.7252965e-009 6.7945649e-014 -5.6517649 
		6.2172489e-015 -3.7252286e-009 -5.6517649 7.450593e-009 5.5511151e-014 -5.6517649 
		-1.4901149e-008 5.5511151e-014 -5.6517649 -1.4901136e-008 -1.4901108e-008 -5.6517649 
		2.4868996e-014 5.5733196e-014 -5.6517649 2.9802322e-008 5.9100945e-014 -5.6517649 
		1.4901186e-008 6.1950445e-014 -5.6517649 2.4868996e-014 3.7253582e-009 -5.6517649 
		2.4868996e-014 -1.8625648e-009 -5.6517649 -3.7252716e-009 1.8627255e-009 -5.6517649 
		1.2434498e-014 8.6597396e-014 -5.6517649 1.0283116e-014 8.5487173e-014 -5.9332871 
		9.1038288e-015 8.5487173e-014 -5.9332871 6.2172489e-015 8.5487173e-014 -5.9332871 
		1.4901161e-008 8.5709218e-014 -5.9332871 1.4901161e-008 -3.7252064e-009 -5.9332871 
		7.4505806e-009 8.2600593e-014 -5.9332871 3.1086245e-015 1.8627244e-009 -5.9332871 
		3.1086245e-015 7.3052675e-014 -5.9332871 6.2172489e-015 9.3139563e-010 -5.9332871 
		-1.862636e-009 -1.8625752e-009 -5.9332871 3.7253027e-009 3.7253578e-009 -5.9332871 
		7.450593e-009 6.6835426e-014 -5.9332871 7.450593e-009 7.450649e-009 -5.9332871 1.5543122e-014 
		6.7057471e-014 -5.9332871 1.5543122e-014 6.8608144e-014 -5.9332871 1.5543122e-014 
		7.0166095e-014 -5.9332871 7.450593e-009 3.725364e-009 -5.9332871 1.5543122e-014 7.9269924e-014 
		-5.9332871 1.2434498e-014 7.9269924e-014 -5.9332871 1.2212453e-014 -1.8625628e-009 
		-5.9332871 1.0394669e-014 -5.5597501e-014 7.6851754 3.1719853e-015 7.6951798e-014 
		-6.0279045 1.0432159e-014;
	setAttr ".vnm" 0;
createNode transform -n "locator1";
	setAttr ".t" -type "double3" 0 19.694526280635177 0 ;
createNode locator -n "locatorShape1" -p "locator1";
	setAttr -k off ".v";
createNode transform -n "pPlane1";
createNode mesh -n "pPlaneShape1" -p "pPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".vnm" 0;
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 68.248508337869239 28.907683378644233 -0.26680233577401508 ;
	setAttr ".r" -type "double3" -19.53835272959828 90.199999999997686 4.5799987413074647e-013 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 74.52086477466392;
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
	addAttr -ci true -sn "trBETabs" -ln "trBETabs" -nn "Behavior Editor Tabs" -dt "string";
	addAttr -ci true -sn "trBECTab" -ln "trBECTab" -nn "Behavior Editor Current Tab" 
		-at "float";
	addAttr -ci true -sn "trTriTabs" -ln "trTriTabs" -nn "Trigger Editor Tabs" -dt "string";
	addAttr -ci true -sn "trTriCTab" -ln "trTriCTab" -nn "Trigger Editor Current Tab" 
		-at "float";
	setAttr ".trBETabs" -type "string" "beContainerShape1#entityTypeContainerShape2#";
	setAttr ".trBECTab" 1;
	setAttr ".trTriTabs" -type "string" "bePhysicalize1StartTriggerShape#beDynamics1StartTriggerShape#";
	setAttr ".trTriCTab" 1;
createNode CrowdManagerNode -n "crowdManagerNodeShape" -p "crowdManagerNode";
	setAttr -k off ".v";
	setAttr -s 2 ".ine";
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".amwtidx" 1;
	setAttr ".drm" -type "string" "";
lockNode -l 1 ;
createNode transform -n "entityType1";
createNode CrowdEntityTypeNode -n "entityTypeShape1" -p "entityType1";
	setAttr -k off ".v";
	setAttr -l on ".etid" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 71 ;
	setAttr ".bf" 2;
createNode transform -n "crowdBehaviors";
createNode transform -n "entityTypeContainer1" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape1" -p "entityTypeContainer1";
	setAttr -k off ".v";
	setAttr ".bpx" 367;
	setAttr ".bpy" 210;
	setAttr ".ipx" 204;
	setAttr ".ipy" 194;
	setAttr ".fpx" 633;
	setAttr ".fpy" 195;
createNode transform -n "entityTypeContainer2" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape2" -p "entityTypeContainer2";
	setAttr -k off ".v";
createNode transform -n "crowdTriggers" -p "crowdBehaviors";
createNode transform -n "beDynamics1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beDynamics1StartTriggerShape" -p "beDynamics1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd1" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape1" -p "triOpAnd1";
	setAttr -k off ".v";
	setAttr ".tpx" 88;
	setAttr ".tpy" -16;
	setAttr -s 2 ".prt";
createNode transform -n "triRandom1" -p "crowdTriggers";
createNode CrowdTriRandom -n "triRandomShape1" -p "triRandom1";
	setAttr -k off ".v";
	setAttr ".tpx" -160;
	setAttr ".tpy" -26;
	setAttr ".prb" 10;
createNode transform -n "triDriven1" -p "crowdTriggers";
createNode CrowdTriDrivenAttribute -n "triDrivenShape1" -p "triDriven1";
	setAttr -k off ".v";
	setAttr ".tpx" -160;
	setAttr ".tpy" 26;
	setAttr ".opr" 5;
	setAttr ".val" 150;
createNode transform -n "beForce1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce1StartTriggerShape" -p "beForce1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd2" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape2" -p "triOpAnd2";
	setAttr -k off ".v";
createNode transform -n "triBool1" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape1" -p "triBool1";
	setAttr -k off ".v";
createNode transform -n "beForce1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce1StopTriggerShape" -p "beForce1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd3" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape3" -p "triOpAnd3";
	setAttr -k off ".v";
createNode transform -n "triBool2" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape2" -p "triBool2";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion1StartTriggerShape" -p "beMotion1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd4" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape4" -p "triOpAnd4";
	setAttr -k off ".v";
createNode transform -n "triBool3" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape3" -p "triBool3";
	setAttr -k off ".v";
createNode transform -n "beMotion1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion1StopTriggerShape" -p "beMotion1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd5" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape5" -p "triOpAnd5";
	setAttr -k off ".v";
createNode transform -n "triBool4" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape4" -p "triBool4";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beMotion2StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion2StartTriggerShape" -p "beMotion2StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd6" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape6" -p "triOpAnd6";
	setAttr -k off ".v";
createNode transform -n "triBool5" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape5" -p "triBool5";
	setAttr -k off ".v";
createNode transform -n "beMotion2StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beMotion2StopTriggerShape" -p "beMotion2StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd7" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape7" -p "triOpAnd7";
	setAttr -k off ".v";
createNode transform -n "triBool6" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape6" -p "triBool6";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "bePhysicalize1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize1StartTriggerShape" -p "bePhysicalize1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd8" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape8" -p "triOpAnd8";
	setAttr -k off ".v";
createNode transform -n "triBool7" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape7" -p "triBool7";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize1StopTriggerShape" -p "bePhysicalize1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd9" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape9" -p "triOpAnd9";
	setAttr -k off ".v";
createNode transform -n "triPolyZone1" -p "crowdTriggers";
createNode CrowdTriPolygonZone -n "triPolyZoneShape1" -p "triPolyZone1";
	setAttr -k off ".v";
	setAttr ".dim" 1;
createNode transform -n "bePhysicalize3StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize3StartTriggerShape" -p "bePhysicalize3StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd10" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape10" -p "triOpAnd10";
	setAttr -k off ".v";
createNode transform -n "triBool8" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape8" -p "triBool8";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize3StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize3StopTriggerShape" -p "bePhysicalize3StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd11" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape11" -p "triOpAnd11";
	setAttr -k off ".v";
createNode transform -n "triBool9" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape9" -p "triBool9";
	setAttr -k off ".v";
createNode transform -n "beMotion1" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape1" -p "beMotion1";
	setAttr -k off ".v";
	setAttr ".bpy" -51;
createNode transform -n "crowdMotionClips" -p "crowdBehaviors";
createNode transform -n "CMAN_SitWatching_1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_SitWatching_Shape1" -p "CMAN_SitWatching_1";
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
createNode transform -n "beMotion2" -p "crowdBehaviors";
createNode CrowdBeMotion -n "beMotionShape2" -p "beMotion2";
	setAttr -k off ".v";
	setAttr ".bpx" 405;
	setAttr ".bpy" 208;
createNode transform -n "bePhysicalize1" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape1" -p "bePhysicalize1";
	setAttr -k off ".v";
	setAttr ".bpx" 268;
	setAttr ".bpy" 213;
createNode transform -n "beOpParallel1" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape1" -p "beOpParallel1";
	setAttr -k off ".v";
	setAttr ".bpx" 420;
	setAttr ".bpy" 195;
createNode transform -n "beForce1" -p "crowdBehaviors";
createNode CrowdBeForce -n "beForceShape1" -p "beForce1";
	setAttr -k off ".v";
	setAttr ".bpx" 441;
	setAttr ".bpy" 214;
	setAttr ".fom" 1;
	setAttr ".mal" -type "string" "";
	setAttr ".mae" -type "string" "";
	setAttr ".fdn" -type "float3" 1 0 1 ;
	setAttr ".fiMd" 46.25;
	setAttr ".fiMi" -2500;
	setAttr ".bmm" 1;
createNode transform -n "beContainer1" -p "crowdBehaviors";
createNode CrowdBeContainer -n "beContainerShape1" -p "beContainer1";
	setAttr -k off ".v";
	setAttr ".bpy" 41;
	setAttr ".ipx" 150;
	setAttr ".ipy" 213;
	setAttr ".fpx" 738;
	setAttr ".fpy" 215;
createNode transform -n "bePhysicalize3" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape3" -p "bePhysicalize3";
	setAttr -k off ".v";
	setAttr ".bpx" 620;
	setAttr ".bpy" 213;
	setAttr ".bhm" 1;
	setAttr ".lps" yes;
createNode transform -n "entityType2";
createNode CrowdEntityTypeNode -n "entityTypeShape2" -p "entityType2";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 0 1 1 ;
	setAttr -l on ".etid" 2;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/crowdMan_light.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "populationTool1";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -0.11675699800252914 3.5527100789104763e-015 -0.0028281500563025475 ;
createNode PopulationToolLocator -n "populationToolShape1" -p "populationTool1";
	setAttr -k off ".v";
	setAttr ".np" 150;
	setAttr ".npp" 150;
	setAttr ".dst" 3.687500001280569;
	setAttr ".n" 5.1874999984866008;
	setAttr ".nr" 16;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr -s 2 ".ine";
	setAttr ".etw" -type "Int32Array" 2 100 100 ;
	setAttr ".etp" -type "doubleArray" 2 50 50 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 150 -13.570720672607422 3.5527100789104763e-015
		 -22.334745407104492 -0.3746083676815033 3.5527100789104763e-015 -23.723733901977539 7.114501953125
		 3.5527100789104763e-015 -13.00993824005127 0.013784803450107574 3.5527100789104763e-015
		 -16.109365463256836 -11.428199768066406 3.5527100789104763e-015 2.7508871555328369 -1.0690810680389404
		 3.5527100789104763e-015 -27.443265914916992 -3.7930350303649902 3.5527100789104763e-015
		 13.102200508117676 -11.309470176696776 3.5527100789104763e-015 28.204673767089844 13.107551574707031
		 3.5527100789104763e-015 -18.329553604125977 4.9787697792053223 3.5527100789104763e-015
		 22.11631965637207 14.673766136169434 3.5527100789104763e-015 -14.796456336975098 8.2237548828125
		 3.5527100789104763e-015 22.534158706665039 7.6453495025634766 3.5527100789104763e-015
		 -20.355503082275391 0.98489278554916382 3.5527100789104763e-015 8.5467252731323242 17.533746719360352
		 3.5527100789104763e-015 18.990228652954105 -2.6924095153808594 3.5527100789104763e-015
		 -7.3330631256103516 -14.117893218994141 3.5527100789104763e-015 -14.763679504394531 -8.9557676315307617
		 3.5527100789104763e-015 1.9711630344390867 7.099332332611084 3.5527100789104763e-015
		 -27.477363586425781 16.750680923461914 3.5527100789104763e-015 27.152381896972656 -6.2665719985961914
		 3.5527100789104763e-015 23.770914077758789 -5.9184813499450684 3.5527100789104763e-015
		 9.7610797882080078 3.6154289245605473 3.5527100789104763e-015 -19.945598602294918 -0.12571081519126892
		 3.5527100789104763e-015 24.313453674316406 -6.7489266395568848 3.5527100789104763e-015
		 -10.931095123291016 12.720705986022947 3.5527100789104763e-015 -7.316504955291748 7.357172966003418
		 3.5527100789104763e-015 -13.9776611328125 -11.947675704956056 3.5527100789104763e-015
		 16.865570068359375 0.42322245240211487 3.5527100789104763e-015 -20.780019760131836 1.1747125387191772
		 3.5527100789104763e-015 -10.938318252563477 -17.389511108398438 3.5527100789104763e-015
		 -22.012994766235352 -8.7482519149780273 3.5527100789104763e-015 -17.865653991699219 12.571805953979492
		 3.5527100789104763e-015 -27.459033966064453 12.848883628845217 3.5527100789104763e-015
		 -9.3403415679931641 -0.85244041681289684 3.5527100789104763e-015 17.404443740844727 -2.730982780456543
		 3.5527100789104763e-015 0.58494198322296143 -14.928370475769045 3.5527100789104763e-015
		 -8.9010534286499023 2.1793873310089111 3.5527100789104763e-015 14.70949649810791 -2.472503662109375
		 3.5527100789104763e-015 -10.971141815185549 6.2928943634033203 3.5527100789104763e-015
		 -0.32037439942359924 12.52302074432373 3.5527100789104763e-015 8.7675848007202148 3.4406671524047852
		 3.5527100789104763e-015 -28.968393325805664 -16.004764556884766 3.5527100789104763e-015
		 8.9642229080200195 -6.6550717353820801 3.5527100789104763e-015 -25.966930389404297 -10.976315498352053
		 3.5527100789104763e-015 7.6853723526000977 -3.8780965805053711 3.5527100789104763e-015
		 18.887090682983398 -14.047860145568848 3.5527100789104763e-015 -1.7434039115905762 -14.89984130859375
		 3.5527100789104763e-015 13.283831596374512 10.904475212097168 3.5527100789104763e-015
		 -22.434200286865231 9.7632761001586914 3.5527100789104763e-015 -18.407283782958984 -16.059768676757813
		 3.5527100789104763e-015 25.857082366943359 14.444220542907717 3.5527100789104763e-015
		 15.717731475830078 -14.954789161682127 3.5527100789104763e-015 3.3786830902099609 12.843463897705078
		 3.5527100789104763e-015 -1.7648532390594482 -18.45326042175293 3.5527100789104763e-015
		 17.138811111450195 9.0761499404907227 3.5527100789104763e-015 -1.7768335342407229 0.37952592968940735
		 3.5527100789104763e-015 25.892889022827148 -7.0807309150695801 3.5527100789104763e-015
		 -18.313058853149418 -13.144060134887695 3.5527100789104763e-015 10.00202751159668 0.4117448627948761
		 3.5527100789104763e-015 5.6326155662536621 -2.0284144878387451 3.5527100789104763e-015
		 28.380210876464844 5.2712621688842773 3.5527100789104763e-015 4.9512524604797363 15.193833351135254
		 3.5527100789104763e-015 2.7207369804382324 18.269443511962891 3.5527100789104763e-015
		 -0.88553774356842052 11.021028518676758 3.5527100789104763e-015 12.445178985595703 -7.6651816368103027
		 3.5527100789104763e-015 27.835269927978516 1.4151409864425659 3.5527100789104763e-015
		 -5.8226046562194824 -10.973816871643066 3.5527100789104763e-015 20.978761672973633 13.611763000488279
		 3.5527100789104763e-015 27.07716178894043 5.8633441925048828 3.5527100789104763e-015
		 -10.85272216796875 -10.360025405883787 3.5527100789104763e-015 5.0877294540405273 -9.5158376693725586
		 3.5527100789104763e-015 -27.347352981567383 9.3891019821166992 3.5527100789104763e-015
		 -27.947595596313477 -3.633841991424561 3.5527100789104763e-015 -11.528091430664064 -11.07194709777832
		 3.5527100789104763e-015 -13.011360168457031 -11.308863639831545 3.5527100789104763e-015
		 -9.9250240325927734 -8.5401773452758789 3.5527100789104763e-015 14.766829490661619 14.05864429473877
		 3.5527100789104763e-015 18.461822509765625 -7.4914588928222656 3.5527100789104763e-015
		 -6.7225327491760254 5.4919114112854004 3.5527100789104763e-015 -4.8458142280578613 -18.497472763061523
		 3.5527100789104763e-015 -18.249191284179688 -11.289838790893556 3.5527100789104763e-015
		 -28.771114349365231 7.3586201667785645 3.5527100789104763e-015 29.401157379150391 -13.252318382263184
		 3.5527100789104763e-015 19.763740539550781 -2.6986923217773442 3.5527100789104763e-015
		 -0.081323534250259386 3.6039769649505615 3.5527100789104763e-015 27.301996231079105 16.47300910949707
		 3.5527100789104763e-015 23.969711303710938 -18.429536819458008 3.5527100789104763e-015
		 24.348625183105469 -3.8467283248901367 3.5527100789104763e-015 6.9288396835327148 16.486579895019531
		 3.5527100789104763e-015 -11.92182731628418 -14.850722312927246 3.5527100789104763e-015
		 -5.726168155670166 -11.001255989074709 3.5527100789104763e-015 -4.6403112411499023 -18.539096832275391
		 3.5527100789104763e-015 -22.896223068237305 3.6022660732269287 3.5527100789104763e-015
		 -16.595748901367187 -2.3056302070617676 3.5527100789104763e-015 -18.563072204589844 -7.6311702728271484
		 3.5527100789104763e-015 -20.840757369995117 -1.6280410289764404 3.5527100789104763e-015
		 7.2491745948791504 1.8502216339111328 3.5527100789104763e-015 -12.911055564880373 -16.289789199829102
		 3.5527100789104763e-015 5.9648628234863281 -18.537246704101563 3.5527100789104763e-015
		 19.537019729614254 5.2705092430114746 3.5527100789104763e-015 10.343905448913574 -3.8331301212310791
		 3.5527100789104763e-015 -18.592708587646484 -15.689477920532228 3.5527100789104763e-015
		 -0.13645973801612854 -11.164864540100098 3.5527100789104763e-015 -22.346187591552734 9.2768220901489258
		 3.5527100789104763e-015 4.6746602058410645 12.511279106140137 3.5527100789104763e-015
		 3.3359270095825195 3.4628362655639648 3.5527100789104763e-015 23.91472053527832 4.1181125640869141
		 3.5527100789104763e-015 23.724124908447266 10.869114875793455 3.5527100789104763e-015
		 16.968944549560547 11.647107124328612 3.5527100789104763e-015 -24.34910774230957 8.4315023422241211
		 3.5527100789104763e-015 2.4293069839477539 7.9000058174133292 3.5527100789104763e-015
		 20.863286972045895 -6.2365913391113281 3.5527100789104763e-015 -1.3304359912872314 -5.3956155776977539
		 3.5527100789104763e-015 13.07225513458252 14.720456123352053 3.5527100789104763e-015
		 -20.419013977050781 -12.58295726776123 3.5527100789104763e-015 25.743434906005859 -5.6962795257568359
		 3.5527100789104763e-015 1.1182987689971924 4.2476797103881836 3.5527100789104763e-015
		 12.690187454223633 -16.455484390258789 3.5527100789104763e-015 -13.133654594421388 18.166276931762695
		 3.5527100789104763e-015 -24.303777694702148 7.6116147041320801 3.5527100789104763e-015
		 9.6244087219238281 -11.190535545349119 3.5527100789104763e-015 7.019935131072998 14.785387992858888
		 3.5527100789104763e-015 -6.2699308395385742 -2.1770341396331787 3.5527100789104763e-015
		 -14.830924987792969 12.003875732421877 3.5527100789104763e-015 -19.549850463867188 -11.193835258483888
		 3.5527100789104763e-015 -21.542520523071289 -7.4337053298950195 3.5527100789104763e-015
		 -11.776327133178713 -7.3092894554138175 3.5527100789104763e-015 -22.806175231933594 -13.489334106445313
		 3.5527100789104763e-015 11.931529998779297 -3.5143322944641113 3.5527100789104763e-015
		 7.521052360534668 3.3640551567077637 3.5527100789104763e-015 -25.566186904907227 9.3004293441772461
		 3.5527100789104763e-015 -10.622055053710938 -3.928680419921875 3.5527100789104763e-015
		 26.995180130004883 -10.817619323730469 3.5527100789104763e-015 14.70883846282959 1.1845384836196899
		 3.5527100789104763e-015 16.837316513061523 -1.7991974353790283 3.5527100789104763e-015
		 20.518173217773441 16.489511489868164 3.5527100789104763e-015 15.95667552947998 17.377933502197266
		 3.5527100789104763e-015 -27.433467864990231 -15.70393180847168 3.5527100789104763e-015
		 -29.485250473022461 12.800918579101564 3.5527100789104763e-015 -14.463589668273926 -16.699138641357422
		 3.5527100789104763e-015 -4.466651439666748 10.65204906463623 3.5527100789104763e-015
		 11.225837707519531 -8.2032918930053711 3.5527100789104763e-015 -3.6652402877807617 -11.690025329589844
		 3.5527100789104763e-015 -14.230930328369141 12.46017360687256 3.5527100789104763e-015
		 4.4146370887756348 -3.8114752769470215 3.5527100789104763e-015 15.656744956970217 -0.063410244882106781
		 3.5527100789104763e-015 -0.15574672818183899 -7.506472110748291 3.5527100789104763e-015
		 23.604892730712891 17.588136672973633 3.5527100789104763e-015 14.62412166595459 -8.366694450378418
		 3.5527100789104763e-015 -9.5858650207519531 ;
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
	setAttr ".dr" -type "vectorArray" 150 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
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
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 ;
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
	setAttr ".et" -type "doubleArray" 150 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
		 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1
		 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
		 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1
		 2 1 2 1 2 1 2 ;
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
	setAttr ".etc" -type "vectorArray" 150 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1
		 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "physics1";
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
createNode PhysicsLocator -n "physicsShape1" -p "physics1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".nts" -type "string" "Notice that the crowd entity elements of the \"Display Attributes\" of this locator will only be updated when a new frame is computed. If the simulation is paused, nothing will happen.";
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
	setAttr ".pos0" -type "vectorArray" 150 -13.570721000000001 0 -22.334745000000002 -0.374608
		 0 -23.723734 7.1145019999999999 0 -13.009938 0.0137848 0 -16.109365 -11.4282 0 2.7508870000000001 -1.0690809999999999
		 0 -27.443266000000001 -3.7930350000000002 0 13.102201000000001 -11.309469999999999
		 0 28.204674000000001 13.107552 0 -18.329554000000002 4.9787699999999999 0 22.116320000000002 14.673766000000001
		 0 -14.796455999999999 8.2237550000000006 0 22.534158999999999 7.6453499999999996
		 0 -20.355502999999999 0.98489300000000002 0 8.5467250000000003 17.533747000000002
		 0 18.990228999999999 -2.6924100000000002 0 -7.3330630000000001 -14.117893 0 -14.763680000000001 -8.9557680000000008
		 0 1.971163 7.0993320000000004 0 -27.477364000000001 16.750681 0 27.152381999999999 -6.266572
		 0 23.770914000000001 -5.9184809999999999 0 9.7610799999999998 3.6154289999999998
		 0 -19.945599000000001 -0.12571099999999999 0 24.313454 -6.7489270000000001 0 -10.931094999999999 12.720706
		 0 -7.3165050000000003 7.3571730000000004 0 -13.977660999999999 -11.947676 0 16.865570000000002 0.42322199999999999
		 0 -20.78002 1.1747129999999999 0 -10.938318000000001 -17.389510999999999 0 -22.012995 -8.7482520000000008
		 0 -17.865653999999999 12.571806 0 -27.459033999999999 12.848884 0 -9.3403419999999997 -0.85243999999999998
		 0 17.404444000000002 -2.7309830000000002 0 0.58494199999999996 -14.928369999999999
		 0 -8.9010529999999992 2.1793870000000002 0 14.709496 -2.4725039999999998 0 -10.971142 6.2928940000000004
		 0 -0.32037399999999999 12.523021 0 8.7675850000000004 3.4406669999999999 0 -28.968392999999999 -16.004764999999999
		 0 8.9642230000000005 -6.6550719999999997 0 -25.966930000000001 -10.976315 0 7.6853720000000001 -3.8780969999999999
		 0 18.887091000000002 -14.04786 0 -1.743404 -14.899841 0 13.283832 10.904475 0 -22.434200000000001 9.7632759999999994
		 0 -18.407284000000001 -16.059768999999999 0 25.857081999999998 14.444221000000001
		 0 15.717731000000001 -14.954789 0 3.3786830000000001 12.843464000000001 0 -1.764853 -18.45326
		 0 17.138811 9.0761500000000002 0 -1.776834 0.37952599999999997 0 25.892889 -7.0807310000000001
		 0 -18.313058999999999 -13.14406 0 10.002027999999999 0.41174500000000003 0 5.6326159999999996 -2.0284140000000002
		 0 28.380210999999999 5.2712620000000001 0 4.9512520000000002 15.193833 0 2.7207370000000002 18.269444
		 0 -0.88553800000000005 11.021029 0 12.445179 -7.6651819999999997 0 27.835270000000001 1.415141
		 0 -5.8226050000000003 -10.973817 0 20.978762 13.611763 0 27.077162000000001 5.8633439999999997
		 0 -10.852722 -10.360025 0 5.0877290000000004 -9.5158380000000005 0 -27.347352999999998 9.3891019999999994
		 0 -27.947596000000001 -3.633842 0 -11.528091 -11.071947 0 -13.01136 -11.308864 0
		 -9.9250240000000005 -8.5401769999999999 0 14.766829 14.058643999999999 0 18.461822999999999 -7.4914589999999999
		 0 -6.7225330000000003 5.491911 0 -4.8458139999999998 -18.497472999999999 0 -18.249191 -11.289839000000001
		 0 -28.771114000000001 7.3586200000000002 0 29.401157000000001 -13.252318000000001
		 0 19.763741 -2.6986919999999999 0 -0.081323500000000007 3.603977 0 27.301995999999999 16.473009000000001
		 0 23.969711 -18.429537 0 24.348624999999998 -3.8467280000000001 0 6.9288400000000001 16.48658
		 0 -11.921827 -14.850721999999999 0 -5.7261680000000004 -11.001256 0 -4.6403109999999996 -18.539097000000002
		 0 -22.896222999999999 3.6022660000000002 0 -16.595749000000001 -2.3056299999999998
		 0 -18.563071999999998 -7.63117 0 -20.840757 -1.6280410000000001 0 7.2491750000000001 1.850222
		 0 -12.911056 -16.289788999999999 0 5.9648630000000002 -18.537247000000001 0 19.537019999999998 5.2705089999999997
		 0 10.343904999999999 -3.8331300000000001 0 -18.592708999999999 -15.689477999999999
		 0 -0.13646 -11.164865000000001 0 -22.346188000000001 9.2768219999999992 0 4.6746600000000003 12.511279
		 0 3.3359269999999999 3.4628359999999998 0 23.914721 4.1181130000000001 0 23.724125000000001 10.869115000000001
		 0 16.968945000000001 11.647107 0 -24.349108000000001 8.4315020000000001 0 2.4293070000000001 7.9000060000000003
		 0 20.863287 -6.2365909999999998 0 -1.330436 -5.3956160000000004 0 13.072255 14.720456
		 0 -20.419014000000001 -12.582957 0 25.743435000000002 -5.6962799999999998 0 1.1182989999999999 4.2476799999999999
		 0 12.690187 -16.455483999999998 0 -13.133654999999999 18.166277000000001 0 -24.303778000000001 7.6116149999999996
		 0 9.624409 -11.190536 0 7.0199350000000003 14.785387999999999 0 -6.2699309999999997 -2.1770339999999999
		 0 -14.830925000000001 12.003876 0 -19.549849999999999 -11.193835 0 -21.542521000000001 -7.4337049999999998
		 0 -11.776327 -7.3092889999999997 0 -22.806175 -13.489333999999999 0 11.93153 -3.514332
		 0 7.5210520000000001 3.364055 0 -25.566186999999999 9.3004289999999994 0 -10.622055 -3.9286799999999999
		 0 26.995180000000001 -10.817619000000001 0 14.708838 1.1845380000000001 0 16.837316999999999 -1.7991969999999999
		 0 20.518173000000001 16.489511 0 15.956676 17.377934 0 -27.433468000000001 -15.703932
		 0 -29.485250000000001 12.800919 0 -14.46359 -16.699138999999999 0 -4.4666509999999997 10.652049
		 0 11.225838 -8.2032919999999994 0 -3.6652399999999998 -11.690025 0 -14.230930000000001 12.460174
		 0 4.4146369999999999 -3.8114750000000002 0 15.656745000000001 -0.0634102 0 -0.155747 -7.5064719999999996
		 0 23.604893000000001 17.588137 0 14.624122 -8.3666940000000007 0 -9.5858650000000001 ;
	setAttr ".vel0" -type "vectorArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
	setAttr ".acc0" -type "vectorArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
	setAttr ".scp" -type "string" "physicsFlyingSaucer_startup";
	setAttr ".mas0" -type "doubleArray" 150 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 150 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97
		 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
		 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139
		 140 141 142 143 144 145 146 147 148 149 ;
	setAttr ".nid" 150;
	setAttr ".nid0" 150;
	setAttr ".bt0" -type "doubleArray" 150 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075
		 0.041666666666666075 0.041666666666666075 0.041666666666666075 0.041666666666666075 ;
	setAttr ".ag0" -type "doubleArray" 150 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339 8.0833333333333339
		 8.0833333333333339 8.0833333333333339 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 240;
	setAttr ".glmInitDirection0" -type "vectorArray" 150 1 0 -1.5099580252808664e-007 1
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
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 1
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 ;
	setAttr ".glmEntityType0" -type "doubleArray" 150 1 2 1 2 1 2 1 2 1 2 1 2 1 2
		 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1
		 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
		 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1
		 2 1 2 1 2 1 2 1 2 1 2 1 2 ;
	setAttr ".groupEntityType0" -type "doubleArray" 150 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 150 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0
		 1 0 0 1 1 0 1 0 0 1 1 ;
	setAttr ".radiusPP0" -type "doubleArray" 150 0.30000001192092896 0.30000001192092896
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
		 0.30000001192092896 0.30000001192092896 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 150 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 150 1.7976931348623157e+308 1.7976931348623157e+308
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
		 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 150 1001 2001 3001 4001 5001 6001
		 7001 8001 9001 10001 11001 12001 13001 14001 15001 16001 17001 18001 19001 20001
		 21001 22001 23001 24001 25001 26001 27001 28001 29001 30001 31001 32001 33001 34001
		 35001 36001 37001 38001 39001 40001 41001 42001 43001 44001 45001 46001 47001 48001
		 49001 50001 51001 52001 53001 54001 55001 56001 57001 58001 59001 60001 61001 62001
		 63001 64001 65001 66001 67001 68001 69001 70001 71001 72001 73001 74001 75001 76001
		 77001 78001 79001 80001 81001 82001 83001 84001 85001 86001 87001 88001 89001 90001
		 91001 92001 93001 94001 95001 96001 97001 98001 99001 100001 101001 102001 103001
		 104001 105001 106001 107001 108001 109001 110001 111001 112001 113001 114001 115001
		 116001 117001 118001 119001 120001 121001 122001 123001 124001 125001 126001 127001
		 128001 129001 130001 131001 132001 133001 134001 135001 136001 137001 138001 139001
		 140001 141001 142001 143001 144001 145001 146001 147001 148001 149001 150001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 150 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
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
	setAttr -l on ".noe" 150;
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
createNode mentalrayItemsList -s -n "mentalrayItemsList";
createNode mentalrayGlobals -s -n "mentalrayGlobals";
	setAttr ".rvb" 3;
	setAttr ".ivb" no;
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
	setAttr ".maxr" 2;
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
createNode animCurveTL -n "pSphere1_translateX";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 3.0531733693003957 54 3.0531733693003957;
createNode animCurveTL -n "pSphere1_translateY";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 23.039157503441075 54 18.883365565005896;
createNode animCurveTL -n "pSphere1_translateZ";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 60.823059417686373 54 0.3853001275405461;
createNode animCurveTU -n "pSphere1_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 54 1;
	setAttr -s 2 ".kot[0:1]"  5 5;
createNode animCurveTA -n "pSphere1_rotateX";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 54 0;
createNode animCurveTA -n "pSphere1_rotateY";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 96.008852072332814 54 94.554331631482839
		 194 1500;
createNode animCurveTA -n "pSphere1_rotateZ";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 54 0;
createNode polySphere -n "polySphere1";
	setAttr ".r" 12;
createNode polyPlane -n "polyPlane1";
	setAttr ".w" 48.113918951178348;
	setAttr ".h" 72.66716217441946;
	setAttr ".cuv" 2;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
createNode displayLayerManager -n "layerManager";
	setAttr -s 6 ".dli[1:5]"  5 2 3 6 7;
	setAttr -s 6 ".dli";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"top\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n"
		+ "                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n"
		+ "                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n"
		+ "                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n"
		+ "            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n"
		+ "            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"side\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n"
		+ "                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n"
		+ "                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n"
		+ "                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n"
		+ "            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n"
		+ "            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"front\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n"
		+ "                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n"
		+ "                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n"
		+ "            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n"
		+ "            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n"
		+ "        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `modelPanel -unParent -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            modelEditor -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n"
		+ "                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -maxConstantTransparency 1\n                -rendererName \"base_OpenGL_Renderer\" \n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 256 256 \n                -bumpResolution 512 512 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 1\n                -occlusionCulling 0\n"
		+ "                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 0\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n"
		+ "                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n"
		+ "            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n"
		+ "            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 0\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n"
		+ "            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `outlinerPanel -unParent -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels `;\n\t\t\t$editorName = $panelName;\n            outlinerEditor -e \n                -docTag \"isolOutln_fromSeln\" \n                -showShapes 0\n                -showReferenceNodes 1\n                -showReferenceMembers 1\n                -showAttributes 0\n                -showConnected 0\n                -showAnimCurvesOnly 0\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n"
		+ "                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 1\n                -showAssets 1\n                -showContainedOnly 1\n                -showPublishedAsConnected 0\n                -showContainerContents 1\n                -ignoreDagHierarchy 0\n                -expandConnections 0\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 0\n                -highlightActive 1\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"defaultSetFilter\" \n                -showSetMembers 1\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n"
		+ "                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n"
		+ "            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n"
		+ "            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n"
		+ "                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n"
		+ "                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n"
		+ "                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n"
		+ "                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n"
		+ "                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n"
		+ "                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n"
		+ "                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n"
		+ "                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n"
		+ "                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"sequenceEditorPanel\" -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n"
		+ "                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n"
		+ "                -showConnectionToSelected 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n"
		+ "                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -ignoreAssets 1\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -keyReleaseCommand \"nodeEdKeyReleaseCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -island 0\n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n"
		+ "                -syncedSelection 1\n                -extendToShapes 1\n                $editorName;\n\t\t\tif (`objExists nodeEditorPanel1Info`) nodeEditor -e -restoreInfo nodeEditorPanel1Info $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -defaultPinnedState 0\n                -ignoreAssets 1\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -keyReleaseCommand \"nodeEdKeyReleaseCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n"
		+ "                -island 0\n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -syncedSelection 1\n                -extendToShapes 1\n                $editorName;\n\t\t\tif (`objExists nodeEditorPanel1Info`) nodeEditor -e -restoreInfo nodeEditorPanel1Info $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"createNodePanel\" -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Texture Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l (localizedPanelLabel(\"UV Texture Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Texture Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" (localizedPanelLabel(\"Blend Shape\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.x/atomo/pipeline/tools/golaem/characterPack/5.2/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 0\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 0\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 240 -ast 1 -aet 600 ";
	setAttr ".st" 6;
createNode lambert -n "crowdLambert1";
createNode shadingEngine -n "crowdLambert1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode lambert -n "crowdLambert2";
createNode shadingEngine -n "crowdLambert2SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
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
createNode script -n "script1";
	addAttr -ci true -sn "crnd" -ln "currentRenderer" -dt "string";
	addAttr -ci true -sn "sstp" -ln "shadersStartPath" -dt "string";
	addAttr -ci true -sn "lprp" -ln "isLightProps" -dt "string";
	addAttr -ci true -sn "ecdlg" -ln "enableConfirmDialog" -dt "string";
	setAttr ".ecdlg" -type "string" "1";
	setAttr ".b" -type "string" "string $packdir = `dirmap -cd \"/atomo/pipeline/tools/golaem/characterPack/5.2/\"`;string $scriptName = $packdir + \"script/sampleGUI.mel\";eval(\"source \\\"\" + $scriptName + \"\\\"\");glmCrowdSampleConfigCrowdMan(\"http://golaem.com/content/doc/golaem-crowd-documentation/basic-workflow-0\",1);";
	setAttr ".a" -type "string" "glmDeleteSampleConfigWindow()";
	setAttr ".st" 2;
createNode unitConversion -n "unitConversion1";
	setAttr ".cf" 57.295779513082323;
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
	setAttr -s 4 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
lockNode -l 1 ;
select -ne :initialShadingGroup;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".dsm";
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
	setAttr -cb on ".ren" -type "string" "mentalRay";
	setAttr -av -k on ".esr";
	setAttr -k on ".ors";
	setAttr -cb on ".sdf";
	setAttr -av -k on ".outf";
	setAttr -cb on ".imfkey";
	setAttr -k on ".gama";
	setAttr -k on ".an";
	setAttr -cb on ".ar";
	setAttr -k on ".fs";
	setAttr -k on ".ef";
	setAttr -av -k on ".bfs";
	setAttr -cb on ".me";
	setAttr -cb on ".se";
	setAttr -k on ".be";
	setAttr -cb on ".ep" 1;
	setAttr -k on ".fec";
	setAttr -k on ".ofc";
	setAttr -cb on ".ofe";
	setAttr -cb on ".efe";
	setAttr -cb on ".oft";
	setAttr -cb on ".umfn";
	setAttr -cb on ".ufe";
	setAttr -cb on ".pff";
	setAttr -cb on ".peie";
	setAttr -cb on ".ifp";
	setAttr -k on ".rv";
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
	setAttr -k on ".mot";
	setAttr -av -k on ".mb";
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
	setAttr -av ".w" 640;
	setAttr -av ".h" 480;
	setAttr -av -k on ".pa";
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
connectAttr "pSphere1_translateX.o" "pSphere1.tx";
connectAttr "pSphere1_translateY.o" "pSphere1.ty";
connectAttr "pSphere1_translateZ.o" "pSphere1.tz";
connectAttr "pSphere1_visibility.o" "pSphere1.v";
connectAttr "pSphere1_rotateX.o" "pSphere1.rx";
connectAttr "pSphere1_rotateY.o" "pSphere1.ry";
connectAttr "pSphere1_rotateZ.o" "pSphere1.rz";
connectAttr "polySphere1.out" "pSphereShape1.i";
connectAttr "polyPlane1.out" "pPlaneShape1.i";
connectAttr "entityTypeShape1.msg" "crowdManagerNodeShape.ine[0]";
connectAttr "entityTypeShape2.msg" "crowdManagerNodeShape.ine[1]";
connectAttr "physicsShape1.msg" "crowdManagerNodeShape.phy";
connectAttr "terrainShape1.msg" "crowdManagerNodeShape.trr";
connectAttr ":time1.o" "crowdManagerNodeShape.ct";
connectAttr "entityTypeContainerShape1.msg" "entityTypeShape1.ibc";
connectAttr "beOpParallelShape1.nb" "entityTypeContainerShape1.fb[0]";
connectAttr "beMotionShape2.nb" "entityTypeContainerShape2.fb[0]";
connectAttr "triOpAndShape1.msg" "beDynamics1StartTriggerShape.tro";
connectAttr "beDynamics1StartTriggerShape.ctr" "triOpAndShape1.pco";
connectAttr "triRandomShape1.net" "triOpAndShape1.prt[0]";
connectAttr "triDrivenShape1.net" "triOpAndShape1.prt[1]";
connectAttr "beDynamics1StartTriggerShape.ctr" "triRandomShape1.pco";
connectAttr "beDynamics1StartTriggerShape.ctr" "triDrivenShape1.pco";
connectAttr "unitConversion1.o" "triDrivenShape1.dra";
connectAttr "triOpAndShape2.msg" "beForce1StartTriggerShape.tro";
connectAttr "beForce1StartTriggerShape.ctr" "triOpAndShape2.pco";
connectAttr "triBoolShape1.net" "triOpAndShape2.prt[0]";
connectAttr "beForce1StartTriggerShape.ctr" "triBoolShape1.pco";
connectAttr "triOpAndShape3.msg" "beForce1StopTriggerShape.tro";
connectAttr "beForce1StopTriggerShape.ctr" "triOpAndShape3.pco";
connectAttr "triBoolShape2.net" "triOpAndShape3.prt[0]";
connectAttr "beForce1StopTriggerShape.ctr" "triBoolShape2.pco";
connectAttr "triOpAndShape4.msg" "beMotion1StartTriggerShape.tro";
connectAttr "beMotion1StartTriggerShape.ctr" "triOpAndShape4.pco";
connectAttr "triBoolShape3.net" "triOpAndShape4.prt[0]";
connectAttr "beMotion1StartTriggerShape.ctr" "triBoolShape3.pco";
connectAttr "triOpAndShape5.msg" "beMotion1StopTriggerShape.tro";
connectAttr "beMotion1StopTriggerShape.ctr" "triOpAndShape5.pco";
connectAttr "triBoolShape4.net" "triOpAndShape5.prt[0]";
connectAttr "beMotion1StopTriggerShape.ctr" "triBoolShape4.pco";
connectAttr "triOpAndShape6.msg" "beMotion2StartTriggerShape.tro";
connectAttr "beMotion2StartTriggerShape.ctr" "triOpAndShape6.pco";
connectAttr "triBoolShape5.net" "triOpAndShape6.prt[0]";
connectAttr "beMotion2StartTriggerShape.ctr" "triBoolShape5.pco";
connectAttr "triOpAndShape7.msg" "beMotion2StopTriggerShape.tro";
connectAttr "beMotion2StopTriggerShape.ctr" "triOpAndShape7.pco";
connectAttr "triBoolShape6.net" "triOpAndShape7.prt[0]";
connectAttr "beMotion2StopTriggerShape.ctr" "triBoolShape6.pco";
connectAttr "triOpAndShape8.msg" "bePhysicalize1StartTriggerShape.tro";
connectAttr "bePhysicalize1StartTriggerShape.ctr" "triOpAndShape8.pco";
connectAttr "triBoolShape7.net" "triOpAndShape8.prt[0]";
connectAttr "bePhysicalize1StartTriggerShape.ctr" "triBoolShape7.pco";
connectAttr "triOpAndShape9.msg" "bePhysicalize1StopTriggerShape.tro";
connectAttr "bePhysicalize1StopTriggerShape.ctr" "triOpAndShape9.pco";
connectAttr "triPolyZoneShape1.net" "triOpAndShape9.prt[0]";
connectAttr "pSphereShape1.msg" "triPolyZoneShape1.inp[0]";
connectAttr "bePhysicalize1StopTriggerShape.ctr" "triPolyZoneShape1.pco";
connectAttr "triOpAndShape10.msg" "bePhysicalize3StartTriggerShape.tro";
connectAttr "bePhysicalize3StartTriggerShape.ctr" "triOpAndShape10.pco";
connectAttr "triBoolShape8.net" "triOpAndShape10.prt[0]";
connectAttr "bePhysicalize3StartTriggerShape.ctr" "triBoolShape8.pco";
connectAttr "triOpAndShape11.msg" "bePhysicalize3StopTriggerShape.tro";
connectAttr "bePhysicalize3StopTriggerShape.ctr" "triOpAndShape11.pco";
connectAttr "triBoolShape9.net" "triOpAndShape11.prt[0]";
connectAttr "bePhysicalize3StopTriggerShape.ctr" "triBoolShape9.pco";
connectAttr "CMAN_SitWatching_Shape1.msg" "beMotionShape1.mcp[0]";
connectAttr "beOpParallelShape1.chb" "beMotionShape1.pb";
connectAttr "beMotion1StartTriggerShape.msg" "beMotionShape1.isac";
connectAttr "beMotion1StopTriggerShape.msg" "beMotionShape1.isoc";
connectAttr "CMAN_SitWatching_Shape1.msg" "beMotionShape2.mcp[0]";
connectAttr "entityTypeContainerShape2.chb" "beMotionShape2.pb";
connectAttr "entityTypeContainerShape2.ib" "beMotionShape2.prb[0]";
connectAttr "beMotion2StartTriggerShape.msg" "beMotionShape2.isac";
connectAttr "beMotion2StopTriggerShape.msg" "beMotionShape2.isoc";
connectAttr "beContainerShape1.chb" "bePhysicalizeShape1.pb";
connectAttr "beContainerShape1.ib" "bePhysicalizeShape1.prb[0]";
connectAttr "beDynamics1StartTriggerShape.msg" "bePhysicalizeShape1.isoc";
connectAttr "bePhysicalize1StartTriggerShape.msg" "bePhysicalizeShape1.isac";
connectAttr "entityTypeContainerShape1.chb" "beOpParallelShape1.pb";
connectAttr "entityTypeContainerShape1.ib" "beOpParallelShape1.prb[0]";
connectAttr "locator1.t" "beForce1.t";
connectAttr "beContainerShape1.chb" "beForceShape1.pb";
connectAttr "locatorShape1.msg" "beForceShape1.fdl";
connectAttr "bePhysicalizeShape1.nb" "beForceShape1.prb[0]";
connectAttr "locatorShape1.msg" "beForceShape1.fil";
connectAttr "beForce1StartTriggerShape.msg" "beForceShape1.isac";
connectAttr "bePhysicalize1StopTriggerShape.msg" "beForceShape1.isoc";
connectAttr "bePhysicalizeShape3.nb" "beContainerShape1.fb[0]";
connectAttr "beOpParallelShape1.chb" "beContainerShape1.pb";
connectAttr "beContainerShape1.chb" "bePhysicalizeShape3.pb";
connectAttr "beForceShape1.nb" "bePhysicalizeShape3.prb[0]";
connectAttr "bePhysicalize3StartTriggerShape.msg" "bePhysicalizeShape3.isac";
connectAttr "bePhysicalize3StopTriggerShape.msg" "bePhysicalizeShape3.isoc";
connectAttr "entityTypeContainerShape2.msg" "entityTypeShape2.ibc";
connectAttr "entityTypeShape1.msg" "populationToolShape1.ine" -na;
connectAttr "entityTypeShape2.msg" "populationToolShape1.ine" -na;
connectAttr ":time1.o" "particleShape1.cti";
connectAttr "crowdManagerNodeShape.sf" "particleShape1.stf";
connectAttr "crowdField1.of[0]" "particleShape1.ifc[0]";
connectAttr "crowdManagerNodeShape.sf" "crowdField1.sf";
connectAttr "particleShape1.fd" "crowdField1.ind[0]";
connectAttr "particleShape1.ppfd[0]" "crowdField1.ppda[0]";
connectAttr "pPlane1.msg" "terrainShape1.mgg[0]";
connectAttr ":mentalrayGlobals.msg" ":mentalrayItemsList.glb";
connectAttr ":miDefaultOptions.msg" ":mentalrayItemsList.opt" -na;
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayItemsList.fb" -na;
connectAttr ":miDefaultOptions.msg" ":mentalrayGlobals.opt";
connectAttr ":miDefaultFramebuffer.msg" ":mentalrayGlobals.fb";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "crowdLambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "crowdLambert2SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "entityTypeShape1.dc" "crowdLambert1.c";
connectAttr "crowdLambert1.oc" "crowdLambert1SG.ss";
connectAttr "crowdLambert1SG.msg" "materialInfo1.sg";
connectAttr "crowdLambert1.msg" "materialInfo1.m";
connectAttr "entityTypeShape2.dc" "crowdLambert2.c";
connectAttr "crowdLambert2.oc" "crowdLambert2SG.ss";
connectAttr "crowdLambert2SG.msg" "materialInfo2.sg";
connectAttr "crowdLambert2.msg" "materialInfo2.m";
connectAttr "layerManager.dli[1]" "body_lay.id";
connectAttr "layerManager.dli[4]" "head_lay.id";
connectAttr "layerManager.dli[3]" "torso_lay.id";
connectAttr "layerManager.dli[5]" "legs_lay.id";
connectAttr "layerManager.dli[2]" "skel_lay.id";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "hyperLayout1.msg" "hyperView1.hl";
connectAttr "pSphere1.ry" "unitConversion1.i";
connectAttr "crowdLambert1SG.pa" ":renderPartition.st" -na;
connectAttr "crowdLambert2SG.pa" ":renderPartition.st" -na;
connectAttr "pSphereShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pPlaneShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "particleShape1.iog" ":initialParticleSE.dsm" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of physicsFlyingSaucer.ma
