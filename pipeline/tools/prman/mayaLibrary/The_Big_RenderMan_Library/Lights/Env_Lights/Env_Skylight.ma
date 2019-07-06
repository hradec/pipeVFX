//Maya ASCII 2014 scene
//Name: Env_Skylight.ma
//Last modified: Tue, Oct 08, 2013 08:55:51 AM
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
createNode transform -n "group";
createNode transform -n "group3" -p "group";
createNode transform -n "Env_Skylight" -p "group3";
	setAttr ".r" -type "double3" -90 0 0 ;
	setAttr ".s" -type "double3" -230.2299964904785 230.2299964904785 230.2299964904785 ;
createNode RMSEnvLight -n "Env_Skylight_Shape" -p "Env_Skylight";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".ShadingRate" 1;
	setAttr ".temperature" 5500;
	setAttr ".nts" -type "string" "LIGHT TEMPERATURE GUIDE\n1,700 K\t. . . . . . Match Light\n1,850 K . . . . . . Candle Light & Sunset/rise\n2,700 to 3,300 K . .Incandescent Lamp\n3,000 K . . . . . . Soft Fluorescent Lamp\n3,200 K\t. . . . . . Studio Lamp & Photoflood\n3,350 K\t. . . . . . Studio CP Light\n4,100 K\t. . . . . . Moonlight\n5,000 K\t. . . . . . Horizon Daylight\n5,000 K . . . . . . Daylight Fluorescent Lamp\n5,500–6,000 K . . . Vertical Daylight & Camera Flash\n6,200 K\t. . . . . . Xenon Short-Arc Lamp\n6,500 K\t. . . . . . Overcast Daylight\n5,500–10,500 K\t. . LCD Screen\n15,000–27,000 K\t. . Clear Blue Poleward Sky";
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode ramp -n "ramp_Skylight";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".in" 4;
	setAttr -s 6 ".cel";
	setAttr ".cel[2].ep" 0;
	setAttr ".cel[2].ec" -type "float3" 0.28099489 0.25108722 0.23378347 ;
	setAttr ".cel[3].ep" 0.85500001907348633;
	setAttr ".cel[3].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[4].ep" 0.88499999046325684;
	setAttr ".cel[4].ec" -type "float3" 3.1135499 3.1856999 3.3299999 ;
	setAttr ".cel[5].ep" 0.55500000715255737;
	setAttr ".cel[5].ec" -type "float3" 0.055062 0.072796494 0.126 ;
	setAttr ".cel[7].ep" 0.74000000953674316;
	setAttr ".cel[7].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[8].ep" 0.86000001430511475;
	setAttr ".cel[8].ec" -type "float3" 1 1 1 ;
	setAttr ".nf" 0;
	setAttr ".nts" -type "string" "Ramp controls color of ground";
createNode place2dTexture -n "_place2dTexture2";
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
	setAttr -s 22 ".tx";
select -ne :lightList1;
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 19 ".u";
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
connectAttr "ramp_Skylight.oc" "Env_Skylight_Shape.lightcolor";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "_place2dTexture2.o" "ramp_Skylight.uv";
connectAttr "_place2dTexture2.ofs" "ramp_Skylight.fs";
connectAttr "ramp_Skylight.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_Skylight_Shape.ltd" ":lightList1.l" -na;
connectAttr "_place2dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "Env_Skylight.iog" ":defaultLightSet.dsm" -na;
// End of Env_Skylight.ma
