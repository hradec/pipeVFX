//Maya ASCII 2014 scene
//Name: Env_80s_Airbrush.ma
//Last modified: Tue, Oct 08, 2013 08:52:35 AM
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
createNode transform -n "Env_80s_Airbrush";
	setAttr ".r" -type "double3" -90 0 0 ;
	setAttr ".s" -type "double3" -230.2299964904785 230.2299964904785 230.2299964904785 ;
createNode RMSEnvLight -n "Env_80s_Airbrush_Shape" -p "Env_80s_Airbrush";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".ShadingRate" 1;
	setAttr ".nts" -type "string" "LIGHT TEMPERATURE GUIDE\n1,700 K\t. . . . . . Match Light\n1,850 K . . . . . . Candle Light & Sunset/rise\n2,700 to 3,300 K. .Incandescent Lamp\n3,000 K . . . . . . Soft Fluorescent Lamp\n3,200 K\t. . . . . . Studio Lamp & Photoflood\n3,350 K\t. . . . . . Studio CP Light\n4,100 K\t. . . . . . Moonlight\n5,000 K\t. . . . . . Horizon Daylight\n5,000 K . . . . . . Daylight Fluorescent Lamp\n5,500–6,000 K . . . Vertical Daylight & Camera Flash\n6,200 K\t. . . . . . Xenon Short-Arc Lamp\n6,500 K\t. . . . . . Overcast Daylight\n5,500–10,500 K\t. . LCD Screen\n15,000–27,000 K\t. . Clear Blue Poleward Sky";
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode layeredTexture -n "procedural_env_layer";
	setAttr -s 3 ".cs";
	setAttr ".cs[0].bm" 1;
	setAttr ".cs[0].iv" yes;
	setAttr ".cs[1].bm" 1;
	setAttr ".cs[1].iv" yes;
	setAttr ".cs[2].c" -type "float3" 0.095455997 0.19796482 0.60799998 ;
	setAttr ".cs[2].a" 1;
	setAttr ".cs[2].bm" 0;
	setAttr ".cs[2].iv" yes;
createNode ramp -n "ramp_ground";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".in" 2;
	setAttr -s 6 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0.86274511 0.82506788 0.69357944 ;
	setAttr ".cel[1].ep" 0.65499997138977051;
	setAttr ".cel[1].ec" -type "float3" 1 0.39456666 0.11400002 ;
	setAttr ".cel[2].ep" 0.90499997138977051;
	setAttr ".cel[2].ec" -type "float3" 0.86614197 0.82625699 0.69127703 ;
	setAttr ".cel[3].ep" 0.46000000834465027;
	setAttr ".cel[3].ec" -type "float3" 1 0.52746671 0.11400002 ;
	setAttr ".cel[4].ep" 0.32499998807907104;
	setAttr ".cel[4].ec" -type "float3" 0.96700001 0.75969136 0.312341 ;
	setAttr ".cel[5].ep" 0.1550000011920929;
	setAttr ".cel[5].ec" -type "float3" 0.95200002 0.85632402 0.63308001 ;
	setAttr ".vw" 0.029999999329447746;
	setAttr ".n" 0.05714285746216774;
	setAttr ".nf" 1.5;
	setAttr ".nts" -type "string" "Ramp controls color of ground";
createNode place2dTexture -n "place2dTexture1";
createNode ramp -n "ramp2";
	setAttr -s 2 ".cel";
	setAttr ".cel[1].ep" 0.5;
	setAttr ".cel[1].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[2].ep" 0.41999998688697815;
	setAttr ".cel[2].ec" -type "float3" 1 1 1 ;
createNode place2dTexture -n "place2dTexture2";
createNode ramp -n "ramp_sky";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -s 8 ".cel";
	setAttr ".cel[0].ep" 0.125;
	setAttr ".cel[0].ec" -type "float3" 1 0 0 ;
	setAttr ".cel[1].ep" 0.51399999856948853;
	setAttr ".cel[1].ec" -type "float3" 0.19607843 0.14504585 0.1230296 ;
	setAttr ".cel[2].ep" 0.51999998092651367;
	setAttr ".cel[2].ec" -type "float3" 1 0.898 0.898 ;
	setAttr ".cel[3].ep" 0.05000000074505806;
	setAttr ".cel[3].ec" -type "float3" 0.095347941 0.19173735 0.60784316 ;
	setAttr ".cel[4].ep" 1;
	setAttr ".cel[4].ec" -type "float3" 0.095455997 0.19796482 0.60799998 ;
	setAttr ".cel[5].ep" 0.67500001192092896;
	setAttr ".cel[6].ep" 0.89999997615814209;
	setAttr ".cel[6].ec" -type "float3" 0.31339499 0.380126 0.72850698 ;
	setAttr ".cel[7].ep" 0.55000001192092896;
	setAttr ".cel[7].ec" -type "float3" 0.80393702 0.80393702 1 ;
	setAttr ".vw" 0.019999999552965164;
	setAttr ".n" 0.019999999552965164;
	setAttr ".nf" 2;
	setAttr ".nts" -type "string" "ramp for the control of the sky\n";
createNode place2dTexture -n "place2dTexture3";
createNode ramp -n "ramp_sun_flare";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".t" 1;
	setAttr ".in" 4;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0.20000000298023224;
	setAttr ".cel[0].ec" -type "float3" 0.80400002 0.80400002 1 ;
	setAttr ".cel[1].ep" 0.5;
	setAttr ".cel[1].ec" -type "float3" 2.5 2.4673333 2.01 ;
	setAttr ".cel[2].ep" 0.82499998807907104;
	setAttr ".cel[2].ec" -type "float3" 0.80400002 0.80400002 1 ;
	setAttr ".nts" -type "string" "Ramp for the placement of the sun glow\nThe value of the flare is overdriven to 2.5";
createNode place2dTexture -n "place2dTexture4";
createNode ramp -n "ramp5";
	setAttr ".in" 2;
	setAttr -s 2 ".cel";
	setAttr ".cel[1].ep" 0.47499999403953552;
	setAttr ".cel[1].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[2].ep" 0.98500001430511475;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
createNode place2dTexture -n "place2dTexture5";
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
	setAttr -s 6 ".tx";
select -ne :lightList1;
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 5 ".u";
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
connectAttr "procedural_env_layer.oc" "Env_80s_Airbrush_Shape.lightcolor";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "ramp_ground.oc" "procedural_env_layer.cs[0].c";
connectAttr "ramp2.oa" "procedural_env_layer.cs[0].a";
connectAttr "ramp_sky.oc" "procedural_env_layer.cs[1].c";
connectAttr "ramp5.oa" "procedural_env_layer.cs[1].a";
connectAttr "place2dTexture1.o" "ramp_ground.uv";
connectAttr "place2dTexture1.ofs" "ramp_ground.fs";
connectAttr "place2dTexture2.o" "ramp2.uv";
connectAttr "place2dTexture2.ofs" "ramp2.fs";
connectAttr "place2dTexture3.o" "ramp_sky.uv";
connectAttr "place2dTexture3.ofs" "ramp_sky.fs";
connectAttr "ramp_sun_flare.oc" "ramp_sky.cel[5].ec";
connectAttr "place2dTexture4.o" "ramp_sun_flare.uv";
connectAttr "place2dTexture4.ofs" "ramp_sun_flare.fs";
connectAttr "place2dTexture5.o" "ramp5.uv";
connectAttr "place2dTexture5.ofs" "ramp5.fs";
connectAttr "procedural_env_layer.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp_ground.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp2.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp_sky.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp_sun_flare.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp5.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_80s_Airbrush_Shape.ltd" ":lightList1.l" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture4.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture5.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "Env_80s_Airbrush.iog" ":defaultLightSet.dsm" -na;
// End of Env_80s_Airbrush.ma
