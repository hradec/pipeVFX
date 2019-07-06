//Maya ASCII 2014 scene
//Name: Env_RGB_Sharp.ma
//Last modified: Tue, Oct 08, 2013 08:55:31 AM
//Codeset: UTF-8
requires maya "2014";
requires -nodeType "RenderMan" -nodeType "RenderManEnvLightShape" -nodeType "RenderManArchive"
		 -nodeType "RenderManVolume" -nodeType "RenderManLight" -nodeType "RenderManShaderObject"
		 -nodeType "RenderManDisplacement" -nodeType "RenderManShader" -nodeType "rmanWaveletNoise3d"
		 -nodeType "RMSGPSurface" -nodeType "rmanCellNoise" -nodeType "RMSEnvLight" -nodeType "RMSCausticLight"
		 -nodeType "rmanPrimVarFloat2" -nodeType "rmanPrimVarFloat3" -nodeType "RMSGeoLightBlocker"
		 -nodeType "rmanPrimVarPoint" -nodeType "RMSLightBlocker" -nodeType "rmanOcclusion"
		 -nodeType "rmanPrimVarFloat" -nodeType "rmanSideMask" -nodeType "rmanAOV" -nodeType "RMSMatte"
		 -nodeType "rmanPrimVarVector" -nodeType "rmanImageFile" -nodeType "RMSAreaLight"
		 -nodeType "RMSAreaLightManip" -nodeType "RMSGeoAreaLight" -nodeType "RMSGeoAreaLightManip"
		 -nodeType "rmanPrimVarColor" -nodeType "RMSHair" -nodeType "rmanTexture3d" -nodeType "RMSGIPtcLight"
		 -nodeType "RMSGlass" -nodeType "rmanManifold2d" -nodeType "rmanWorleyTexture" -nodeType "rmanManifold3d"
		 -nodeType "RMSHoldOut" -nodeType "rmanPrimVarNormal" -nodeType "RMSOcean" -nodeType "RMSGILight"
		 -nodeType "RMSPointLight" -nodeType "RMSShaveHair" "RenderMan_for_Maya" "5.5b3";
requires "stereoCamera" "10.0";
requires "RenderMan_for_Maya" "5.5b2";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014 x64";
fileInfo "cutIdentifier" "201303010035-864206";
fileInfo "osv" "Mac OS X 10.8.4";
createNode transform -n "Env_RGB";
	setAttr ".r" -type "double3" -90 0 0 ;
	setAttr ".s" -type "double3" -230.2299964904785 230.2299964904785 230.2299964904785 ;
createNode RMSEnvLight -n "Env_RGB_Shape" -p "Env_RGB";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".ShadingRate" 1;
	setAttr ".nts" -type "string" "LIGHT TEMPERATURE GUIDE\n1,700 K\t. . . . . . Match Light\n1,850 K . . . . . . Candle Light & Sunset/rise\n2,700 to 3,300 K . .Incandescent Lamp\n3,000 K . . . . . . Soft Fluorescent Lamp\n3,200 K\t. . . . . . Studio Lamp & Photoflood\n3,350 K\t. . . . . . Studio CP Light\n4,100 K\t. . . . . . Moonlight\n5,000 K\t. . . . . . Horizon Daylight\n5,000 K . . . . . . Daylight Fluorescent Lamp\n5,500–6,000 K . . . Vertical Daylight & Camera Flash\n6,200 K\t. . . . . . Xenon Short-Arc Lamp\n6,500 K\t. . . . . . Overcast Daylight\n5,500–10,500 K\t. . LCD Screen\n15,000–27,000 K\t. . Clear Blue Poleward Sky";
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode layeredTexture -n "Env_RGB_Sharp_RGBLighting";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -s 4 ".cs";
	setAttr ".cs[4].c" -type "float3" 100 0 0 ;
	setAttr ".cs[4].bm" 4;
	setAttr ".cs[4].iv" yes;
	setAttr ".cs[9].c" -type "float3" 0 0 100 ;
	setAttr ".cs[9].bm" 4;
	setAttr ".cs[9].iv" yes;
	setAttr ".cs[11].c" -type "float3" 0 100 0 ;
	setAttr ".cs[11].bm" 4;
	setAttr ".cs[11].iv" yes;
	setAttr ".cs[13].a" 1;
	setAttr ".cs[13].bm" 0;
	setAttr ".cs[13].iv" yes;
	setAttr ".nts" -type "string" "To change the intensity of the lights, adjust the Color parameter for that layer. Color values are overdriven. ";
createNode ramp -n "Env_RGB_Sharp_ramp_Red";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".t" 4;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0.014999999664723873;
	setAttr ".cel[0].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[1].ep" 0.045000001788139343;
	setAttr ".cel[1].ec" -type "float3" 0.615385 0.615385 0.615385 ;
	setAttr ".cel[2].ep" 0.054999999701976776;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".n" 0.0095238098874688148;
	setAttr ".nf" 0.15238095819950104;
	setAttr ".nts" -type "string" "Controls alpha for Red Light";
createNode place2dTexture -n "Env_RGB_Sharp_place2dTexture10";
	setAttr ".of" -type "float2" -0.125 -0.15000001 ;
createNode ramp -n "Env_RGB_Sharp_ramp_Blue";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".t" 4;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0.014999999664723873;
	setAttr ".cel[0].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[1].ep" 0.045000001788139343;
	setAttr ".cel[1].ec" -type "float3" 0.615385 0.615385 0.615385 ;
	setAttr ".cel[2].ep" 0.054999999701976776;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".n" 0.0095238098874688148;
	setAttr ".nf" 0.15238095819950104;
	setAttr ".nts" -type "string" "Controls alpha for Blue Light";
createNode place2dTexture -n "Env_RGB_Sharp_place2dTexture12";
	setAttr ".of" -type "float2" -0.25 -0.15000001 ;
createNode ramp -n "Env_RGB_Sharp_ramp_Green";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".t" 4;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0.014999999664723873;
	setAttr ".cel[0].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[1].ep" 0.045000001788139343;
	setAttr ".cel[1].ec" -type "float3" 0.615385 0.615385 0.615385 ;
	setAttr ".cel[2].ep" 0.054999999701976776;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".n" 0.0095238098874688148;
	setAttr ".nf" 0.15238095819950104;
	setAttr ".nts" -type "string" "Controls alpha for Green Light";
createNode place2dTexture -n "Env_RGB_Sharp_place2dTexture11";
	setAttr ".of" -type "float2" -0.375 -0.15000001 ;
createNode ramp -n "Env_RGB_Sharp_ramp_bounce";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".in" 4;
	setAttr -s 2 ".cel";
	setAttr ".cel[1].ep" 0;
	setAttr ".cel[1].ec" -type "float3" 0.22314794 0.22314794 0.22314794 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".nts" -type "string" "Conrtols fake bounce light";
createNode place2dTexture -n "Env_RGB_Sharp_place2dTexture13";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
select -ne :defaultTextureList1;
	setAttr -s 21 ".tx";
select -ne :lightList1;
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 18 ".u";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :defaultRenderGlobals;
	setAttr ".ren" -type "string" "renderMan";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
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
connectAttr "Env_RGB_Sharp_RGBLighting.oc" "Env_RGB_Shape.lightcolor";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "Env_RGB_Sharp_ramp_Red.oa" "Env_RGB_Sharp_RGBLighting.cs[4].a";
connectAttr "Env_RGB_Sharp_ramp_Blue.oa" "Env_RGB_Sharp_RGBLighting.cs[9].a";
connectAttr "Env_RGB_Sharp_ramp_Green.oa" "Env_RGB_Sharp_RGBLighting.cs[11].a";
connectAttr "Env_RGB_Sharp_ramp_bounce.oc" "Env_RGB_Sharp_RGBLighting.cs[13].c";
connectAttr "Env_RGB_Sharp_place2dTexture10.o" "Env_RGB_Sharp_ramp_Red.uv";
connectAttr "Env_RGB_Sharp_place2dTexture10.ofs" "Env_RGB_Sharp_ramp_Red.fs";
connectAttr "Env_RGB_Sharp_place2dTexture12.o" "Env_RGB_Sharp_ramp_Blue.uv";
connectAttr "Env_RGB_Sharp_place2dTexture12.ofs" "Env_RGB_Sharp_ramp_Blue.fs";
connectAttr "Env_RGB_Sharp_place2dTexture11.o" "Env_RGB_Sharp_ramp_Green.uv";
connectAttr "Env_RGB_Sharp_place2dTexture11.ofs" "Env_RGB_Sharp_ramp_Green.fs";
connectAttr "Env_RGB_Sharp_place2dTexture13.o" "Env_RGB_Sharp_ramp_bounce.uv";
connectAttr "Env_RGB_Sharp_place2dTexture13.ofs" "Env_RGB_Sharp_ramp_bounce.fs";
connectAttr "Env_RGB_Sharp_RGBLighting.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_RGB_Sharp_ramp_Blue.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_RGB_Sharp_ramp_bounce.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_RGB_Sharp_ramp_Red.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_RGB_Sharp_ramp_Green.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_RGB_Shape.ltd" ":lightList1.l" -na;
connectAttr "Env_RGB_Sharp_place2dTexture10.msg" ":defaultRenderUtilityList1.u" 
		-na;
connectAttr "Env_RGB_Sharp_place2dTexture11.msg" ":defaultRenderUtilityList1.u" 
		-na;
connectAttr "Env_RGB_Sharp_place2dTexture12.msg" ":defaultRenderUtilityList1.u" 
		-na;
connectAttr "Env_RGB_Sharp_place2dTexture13.msg" ":defaultRenderUtilityList1.u" 
		-na;
connectAttr "Env_RGB.iog" ":defaultLightSet.dsm" -na;
// End of Env_RGB_Sharp.ma
