//Maya ASCII 2014 scene
//Name: particular_concrete.ma
//Last modified: Fri, Feb 20, 2015 03:59:56 AM
//Codeset: 1252
requires maya "2014";
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
createNode place3dTexture -n "particular_concrete:place3dTexture8";
	setAttr ".s" -type "double3" 0.5 0.5 0.5 ;
createNode place3dTexture -n "particular_concrete:place3dTexture9";
	setAttr ".t" -type "double3" 0 1 0 ;
	setAttr ".s" -type "double3" 0.2 0.2 0.2 ;
createNode place3dTexture -n "particular_concrete:place3dTexture10";
	setAttr ".s" -type "double3" 0.2 0.2 0.2 ;
createNode PxrLMPlastic -n "particular_concrete:PxrLMPlasticConcrete";
	setAttr ".diffuseRoughness" 1;
	setAttr ".specularColor" -type "float3" 0.73034257 0.73034257 0.73034257 ;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode PxrBlend -n "particular_concrete:PxrBlend2";
createNode fractal -n "particular_concrete:fractal10";
	setAttr ".ail" yes;
	setAttr ".ag" 0.40000000596046448;
	setAttr ".a" 0.58646619319915771;
	setAttr ".ra" 0.72180449962615967;
	setAttr ".lmx" 19.360902786254883;
	setAttr ".fr" 1.8796992301940918;
createNode place2dTexture -n "particular_concrete:place2dTexture14";
	setAttr ".rf" 18.9473682405871;
createNode fractal -n "particular_concrete:fractal11";
	setAttr ".ail" yes;
	setAttr ".an" yes;
createNode place2dTexture -n "particular_concrete:place2dTexture15";
	setAttr ".re" -type "float2" 2 2 ;
createNode fractal -n "particular_concrete:fractal12";
	setAttr ".ail" yes;
	setAttr ".an" yes;
	setAttr ".ti" 31.666666030883789;
createNode stucco -n "particular_concrete:stucco1";
	setAttr ".sh" 2.8571429252624512;
	setAttr ".c1" -type "float3" 0.41600001 0.33761477 0.30867201 ;
	setAttr ".c2" -type "float3" 0.326583 0.36613432 0.39300001 ;
	setAttr ".nm" 0.18796992301940918;
	setAttr ".nd" 0.78947365283966064;
createNode stucco -n "particular_concrete:stucco2";
	setAttr ".sh" 1;
	setAttr ".c1" -type "float3" 0.88800001 0.84065688 0.82317603 ;
	setAttr ".c2" -type "float3" 0.39899999 0.36170062 0.23301598 ;
	setAttr ".nm" 0.18796992301940918;
	setAttr ".nd" 0.78947365283966064;
createNode PxrToFloat -n "particular_concrete:PxrToFloat4";
	setAttr ".mode" 3;
createNode PxrRemap -n "particular_concrete:PxrRemap4";
createNode PxrVoronoise -n "particular_concrete:PxrVoronoise2";
	setAttr ".frequency" 5.8539323806762695;
	setAttr ".octaves" 6;
	setAttr ".gain" 1.1689550876617432;
	setAttr ".lacunarity" 2.067415714263916;
createNode PxrBump -n "particular_concrete:PxrBump4";
	setAttr ".center" 0.5;
	setAttr ".scale" 0.30000001192092896;
createNode PxrToFloat -n "particular_concrete:PxrToFloat5";
	setAttr ".mode" 3;
createNode PxrBlend -n "particular_concrete:PxrBlend4";
	setAttr ".topA" 0.483146071434021;
createNode PxrRemap -n "particular_concrete:PxrRemap5";
createNode PxrBlend -n "particular_concrete:PxrBlend3";
createNode PxrHSL -n "particular_concrete:PxrHSL1";
createNode PxrWorley -n "particular_concrete:PxrWorley1";
	setAttr ".frequency" 50;
	setAttr ".distancemetric" 4;
	setAttr ".jitter" 4;
	setAttr ".minkowskiExponent" 1;
	setAttr ".shape" 1;
	setAttr ".invert" yes;
createNode solidFractal -n "particular_concrete:solidFractal3";
	setAttr ".ail" yes;
	setAttr ".ra" 0.78195488452911377;
	setAttr ".fr" 1.6766917705535889;
	setAttr ".bs" 0.39849624037742615;
	setAttr ".in" yes;
createNode multiplyDivide -n "particular_concrete:multiplyDivide1";
createNode fractal -n "particular_concrete:fractal8";
	setAttr ".ail" yes;
	setAttr ".ag" 0.40000000596046448;
	setAttr ".a" 0.93162393569946289;
	setAttr ".ra" 0.78632479906082153;
	setAttr ".th" 0.76999998092651367;
	setAttr ".lmx" 2;
	setAttr ".fr" 1.692307710647583;
createNode place2dTexture -n "particular_concrete:place2dTexture12";
	setAttr ".re" -type "float2" 40 40 ;
createNode fractal -n "particular_concrete:fractal9";
	setAttr ".ail" yes;
	setAttr ".ag" 0.40000000596046448;
	setAttr ".a" 0.93162393569946289;
	setAttr ".ra" 0.80000001192092896;
	setAttr ".th" 0.87000000476837158;
	setAttr ".lmx" 2;
	setAttr ".fr" 2.076923131942749;
createNode place2dTexture -n "particular_concrete:place2dTexture13";
	setAttr ".rf" 18.9473682405871;
	setAttr ".re" -type "float2" 18 18 ;
createNode remapValue -n "particular_concrete:remapValue1";
	setAttr ".omn" 0.5;
	setAttr ".omx" 0.60000002384185791;
	setAttr -s 2 ".vl[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
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
	setAttr -s 11 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
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
select -ne :defaultShaderList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 10 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 30 ".tx";
select -ne :lightList1;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".l";
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
	setAttr -s 18 ".u";
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
	setAttr -cb on ".hbl";
select -ne :defaultResolution;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr ".w" 1024;
	setAttr ".h" 1024;
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
connectAttr "particular_concrete:PxrBlend2.resultRGB" "particular_concrete:PxrLMPlasticConcrete.diffuseColor"
		;
connectAttr "particular_concrete:PxrBump4.resultN" "particular_concrete:PxrLMPlasticConcrete.diffuseNn"
		;
connectAttr "particular_concrete:PxrBump4.resultN" "particular_concrete:PxrLMPlasticConcrete.specularNn"
		;
connectAttr "particular_concrete:remapValue1.ov" "particular_concrete:PxrLMPlasticConcrete.specularRoughness"
		;
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "particular_concrete:fractal10.oa" "particular_concrete:PxrBlend2.topA"
		;
connectAttr "particular_concrete:stucco1.oc" "particular_concrete:PxrBlend2.bottomRGB"
		;
connectAttr "particular_concrete:stucco2.oc" "particular_concrete:PxrBlend2.topRGB"
		;
connectAttr "particular_concrete:PxrToFloat4.resultF" "particular_concrete:PxrBlend2.bottomA"
		;
connectAttr "particular_concrete:place2dTexture14.o" "particular_concrete:fractal10.uv"
		;
connectAttr "particular_concrete:place2dTexture14.ofs" "particular_concrete:fractal10.fs"
		;
connectAttr "particular_concrete:fractal11.oa" "particular_concrete:place2dTexture14.tfu"
		;
connectAttr "particular_concrete:fractal12.oa" "particular_concrete:place2dTexture14.tfv"
		;
connectAttr "particular_concrete:place2dTexture15.o" "particular_concrete:fractal11.uv"
		;
connectAttr "particular_concrete:place2dTexture15.ofs" "particular_concrete:fractal11.fs"
		;
connectAttr "particular_concrete:place2dTexture15.o" "particular_concrete:fractal12.uv"
		;
connectAttr "particular_concrete:place2dTexture15.ofs" "particular_concrete:fractal12.fs"
		;
connectAttr "particular_concrete:place3dTexture8.wim" "particular_concrete:stucco1.pm"
		;
connectAttr "particular_concrete:place3dTexture9.wim" "particular_concrete:stucco2.pm"
		;
connectAttr "particular_concrete:PxrRemap4.resultRGB" "particular_concrete:PxrToFloat4.input"
		;
connectAttr "particular_concrete:PxrVoronoise2.resultF" "particular_concrete:PxrRemap4.inputRGBr"
		;
connectAttr "particular_concrete:PxrVoronoise2.resultF" "particular_concrete:PxrRemap4.inputRGBg"
		;
connectAttr "particular_concrete:PxrVoronoise2.resultF" "particular_concrete:PxrRemap4.inputRGBb"
		;
connectAttr "particular_concrete:PxrToFloat5.resultF" "particular_concrete:PxrBump4.inputBump"
		;
connectAttr "particular_concrete:PxrBlend4.resultRGB" "particular_concrete:PxrToFloat5.input"
		;
connectAttr "particular_concrete:PxrRemap5.resultRGB" "particular_concrete:PxrBlend4.bottomRGB"
		;
connectAttr "particular_concrete:multiplyDivide1.o" "particular_concrete:PxrBlend4.topRGB"
		;
connectAttr "particular_concrete:PxrBlend3.resultRGB" "particular_concrete:PxrRemap5.inputRGB"
		;
connectAttr "particular_concrete:PxrHSL1.resultRGB" "particular_concrete:PxrBlend3.topRGB"
		;
connectAttr "particular_concrete:solidFractal3.oa" "particular_concrete:PxrBlend3.topA"
		;
connectAttr "particular_concrete:PxrWorley1.resultF" "particular_concrete:PxrHSL1.inputRGBr"
		;
connectAttr "particular_concrete:PxrWorley1.resultF" "particular_concrete:PxrHSL1.inputRGBg"
		;
connectAttr "particular_concrete:PxrWorley1.resultF" "particular_concrete:PxrHSL1.inputRGBb"
		;
connectAttr "particular_concrete:place3dTexture10.wim" "particular_concrete:solidFractal3.pm"
		;
connectAttr "particular_concrete:fractal8.oc" "particular_concrete:multiplyDivide1.i1"
		;
connectAttr "particular_concrete:fractal9.oc" "particular_concrete:multiplyDivide1.i2"
		;
connectAttr "particular_concrete:place2dTexture12.o" "particular_concrete:fractal8.uv"
		;
connectAttr "particular_concrete:place2dTexture12.ofs" "particular_concrete:fractal8.fs"
		;
connectAttr "particular_concrete:place2dTexture13.o" "particular_concrete:fractal9.uv"
		;
connectAttr "particular_concrete:place2dTexture13.ofs" "particular_concrete:fractal9.fs"
		;
connectAttr "particular_concrete:fractal10.oa" "particular_concrete:remapValue1.i"
		;
connectAttr "particular_concrete:PxrLMPlasticConcrete.msg" ":defaultShaderList1.s"
		 -na;
connectAttr "particular_concrete:fractal8.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrBump4.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:fractal9.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:fractal10.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrBlend2.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:fractal11.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:fractal12.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:stucco1.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:stucco2.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrVoronoise2.msg" ":defaultTextureList1.tx" -na
		;
connectAttr "particular_concrete:PxrRemap4.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrToFloat4.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrWorley1.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:solidFractal3.msg" ":defaultTextureList1.tx" -na
		;
connectAttr "particular_concrete:PxrBlend3.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrHSL1.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrRemap5.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrToFloat5.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:PxrBlend4.msg" ":defaultTextureList1.tx" -na;
connectAttr "particular_concrete:place2dTexture12.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:multiplyDivide1.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:place2dTexture13.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:place2dTexture14.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:place2dTexture15.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:place3dTexture8.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:place3dTexture9.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:remapValue1.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "particular_concrete:place3dTexture10.msg" ":defaultRenderUtilityList1.u"
		 -na;
// End of particular_concrete.ma
