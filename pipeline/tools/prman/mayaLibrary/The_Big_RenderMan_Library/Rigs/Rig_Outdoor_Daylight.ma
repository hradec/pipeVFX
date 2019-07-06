//Maya ASCII 2014 scene
//Name: Rig_Outdoor_Daylight.ma
//Last modified: Fri, Apr 17, 2015 09:20:05 AM
//Codeset: UTF-8
requires maya "2014";
requires -nodeType "RenderMan" -nodeType "RenderManEnvLightShape" -nodeType "RenderManArchive"
		 -nodeType "RenderManVolume" -nodeType "RenderManLight" -nodeType "RenderManShaderObject"
		 -nodeType "RenderManDisplacement" -nodeType "RenderManShader" -nodeType "RMSHoldOut"
		 -nodeType "RMSGeoAreaLight" -nodeType "RMSGeoAreaLightManip" -nodeType "PxrFacingRatio"
		 -nodeType "PxrBxdfBlend" -nodeType "RMSMeshLight" -nodeType "rmanCellNoise" -nodeType "PxrToFloat"
		 -nodeType "PxrDisney" -nodeType "RMSGPSurface" -nodeType "PxrProjectionLayer" -nodeType "PxrThinFilm"
		 -nodeType "PxrAttribute" -nodeType "RMSGILight" -nodeType "RMSLightBlocker" -nodeType "rmanPrimVarNormal"
		 -nodeType "PxrSeExpr" -nodeType "RMSCausticLight" -nodeType "RMSAreaLight" -nodeType "RMSAreaLightManip"
		 -nodeType "rmanPrimVarVector" -nodeType "PxrVary" -nodeType "rmanWaveletNoise3d"
		 -nodeType "PxrThreshold" -nodeType "PxrDot" -nodeType "PxrTexture" -nodeType "RMSShaveHair"
		 -nodeType "RMSMatte" -nodeType "PxrDiffuse" -nodeType "rmanPrimVarPoint" -nodeType "rmanAOV"
		 -nodeType "PxrNormalMap" -nodeType "PxrPtexture" -nodeType "PxrBlackBody" -nodeType "PxrExposure"
		 -nodeType "PxrLMLayer" -nodeType "rmanPrimVarFloat2" -nodeType "rmanPrimVarFloat3"
		 -nodeType "PxrRemap" -nodeType "PxrOSL" -nodeType "rmanPrimVarFloat" -nodeType "rmanImageFile"
		 -nodeType "PxrGlass" -nodeType "RMSGIPtcLight" -nodeType "PxrPrimvar" -nodeType "PxrLMMixer"
		 -nodeType "PxrToFloat3" -nodeType "PxrLMGlass" -nodeType "PxrHair" -nodeType "rmanPrimVarColor"
		 -nodeType "PxrConstant" -nodeType "PxrVolume" -nodeType "PxrGamma" -nodeType "PxrBlend"
		 -nodeType "PxrLMDiffuse" -nodeType "PxrFractal" -nodeType "RMSHair" -nodeType "PxrVoronoise"
		 -nodeType "RMSPointLight" -nodeType "PxrLMPlastic" -nodeType "PxrTangentField" -nodeType "rmanDayLight"
		 -nodeType "RMSEnvLight" -nodeType "PxrMix" -nodeType "PxrSkin" -nodeType "PxrManifold2D"
		 -nodeType "PxrManifold3D" -nodeType "PxrRoundCube" -nodeType "rmanSideMask" -nodeType "PxrProjector"
		 -nodeType "PxrRamp" -nodeType "PxrInvert" -nodeType "PxrMatteID" -nodeType "PxrLMSubsurface"
		 -nodeType "PxrProjectionStack" -nodeType "rmanTexture3d" -nodeType "PxrCross" -nodeType "PxrLightEmission"
		 -nodeType "RMSDisplacement" -nodeType "PxrLMMetal" -nodeType "RMSOcean" -nodeType "rmanOcclusion"
		 -nodeType "PxrManifold3DN" -nodeType "PxrWorley" -nodeType "RMSGlass" -nodeType "PxrBump"
		 -nodeType "rmanManifold2d" -nodeType "RMSGeoLightBlocker" -nodeType "PxrClamp" -nodeType "rmanManifold3d"
		 -nodeType "rmanWorleyTexture" -nodeType "PxrFractalize" -nodeType "PxrHSL" -nodeType "PxrFlakes"
		 "RenderMan_for_Maya" "5.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014";
fileInfo "cutIdentifier" "201310090405-890429";
fileInfo "osv" "Mac OS X 10.9.5";
createNode transform -s -n "persp";
	setAttr ".t" -type "double3" 7.9934761424200804 0.79564771165912385 -14.753456571328609 ;
	setAttr ".r" -type "double3" 189.69520135431048 29.400000000020881 -179.99999999999943 ;
	setAttr ".rp" -type "double3" 1.7763568394002505e-15 2.2204460492503131e-16 -3.5527136788005009e-15 ;
	setAttr ".rpt" -type "double3" -6.0264423521419651e-13 2.3003761748941046e-13 6.2690007644272398e-13 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v";
	setAttr ".cap" -type "double2" 2.066 0.906 ;
	setAttr ".ovr" 1.3;
	setAttr ".fl" 35.297629989801138;
	setAttr ".coi" 15.949579150886866;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" -1.8823146820068359 11.970704094423361 -0.34758448600769043 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".dr" yes;
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 3074.462501340573;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v";
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
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "RMSEnvLight_Daylight";
	setAttr ".r" -type "double3" -90 0 0 ;
	setAttr ".s" -type "double3" -1000 1000 1000 ;
createNode RMSEnvLight -n "RMSEnvLight_DaylightShape" -p "RMSEnvLight_Daylight";
	setAttr -k off ".v";
	setAttr ".ShadingRate" 1;
	setAttr ".proceduralResolution" -type "float2" 2048 1024 ;
createNode transform -n "proxy_object";
	setAttr ".t" -type "double3" -0.070192047754261466 2.3741923753477772 -0.31249488546882276 ;
	setAttr ".s" -type "double3" 1.5241087741251278 1.5241087741251278 1.5241087741251278 ;
	setAttr ".rp" -type "double3" 0.070192047754261466 -2.3741923753477772 0 ;
	setAttr ".sp" -type "double3" 0.070192047754261466 -2.3741923753477772 0 ;
createNode nurbsSurface -n "proxy_objectShape" -p "proxy_object";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode place3dTexture -n "place3dTexture2";
	setAttr ".t" -type "double3" 0 -584.95752496624993 0 ;
	setAttr ".s" -type "double3" 455.09725507203353 455.09725507203353 455.09725507203353 ;
createNode transform -n "ground";
	setAttr ".r" -type "double3" 0 90 0 ;
	setAttr ".s" -type "double3" 1 0.64847619511853483 1 ;
createNode mesh -n "groundShape" -p "ground";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dr" 3;
	setAttr ".dsm" 2;
createNode place3dTexture -n "place3dTexture3";
createNode place3dTexture -n "place3dTexture4";
createNode RenderMan -s -n "renderManRISGlobals";
	addAttr -ci true -h true -sn "rman__torattr___class" -ln "rman__torattr___class" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___task" -ln "rman__torattr___task" -dt "string";
	addAttr -ci true -k true -sn "rman__toropt___renderDataCleanupJob" -ln "rman__toropt___renderDataCleanupJob" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___shaderCleanupJob" -ln "rman__toropt___shaderCleanupJob" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___textureCleanupJob" -ln "rman__toropt___textureCleanupJob" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___ribCleanupJob" -ln "rman__toropt___ribCleanupJob" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___ribFlatten" -ln "rman__toropt___ribFlatten" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___renderDataCleanupFrame" -ln "rman__toropt___renderDataCleanupFrame" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___textureCleanupFrame" -ln "rman__toropt___textureCleanupFrame" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___ribCleanupFrame" -ln "rman__toropt___ribCleanupFrame" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__toropt___primaryCamera" -ln "rman__toropt___primaryCamera" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__toropt___enableRenderLayers" -ln "rman__toropt___enableRenderLayers" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__toropt___renderLayer" -ln "rman__toropt___renderLayer" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__toropt___motionBlurType" -ln "rman__toropt___motionBlurType" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__toropt___shutterAngle" -ln "rman__toropt___shutterAngle" 
		-dv -1 -at "float";
	addAttr -ci true -h true -sn "rman__toropt___shutterTiming" -ln "rman__toropt___shutterTiming" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__toropt___cacheCrew" -ln "rman__toropt___cacheCrew" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__toropt___renumber" -ln "rman__toropt___renumber" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___renumberStart" -ln "rman__toropt___renumberStart" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___renumberBy" -ln "rman__toropt___renumberBy" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___lazyRibGen" -ln "rman__toropt___lazyRibGen" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___lazyRender" -ln "rman__toropt___lazyRender" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___bakeMode" -ln "rman__toropt___bakeMode" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___furChunkSize" -ln "rman__toropt___furChunkSize" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___enableRifs" -ln "rman__torattr___enableRifs" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__toropt___nativeShadingSupport" -ln "rman__toropt___nativeShadingSupport" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___motionSamples" -ln "rman__torattr___motionSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___referenceFrame" -ln "rman__torattr___referenceFrame" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___motionBlur" -ln "rman__torattr___motionBlur" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___mapResolution" -ln "rman__torattr___mapResolution" 
		-at "long2" -nc 2;
	addAttr -ci true -k true -sn "rman__torattr___mapResolution0" -ln "rman__torattr___mapResolution0" 
		-dv -1 -at "long" -p "rman__torattr___mapResolution";
	addAttr -ci true -k true -sn "rman__torattr___mapResolution1" -ln "rman__torattr___mapResolution1" 
		-dv -1 -at "long" -p "rman__torattr___mapResolution";
	addAttr -ci true -k true -sn "rman__torattr___depthOfField" -ln "rman__torattr___depthOfField" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___cameraBlur" -ln "rman__torattr___cameraBlur" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___frontPlane" -ln "rman__torattr___frontPlane" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___backPlane" -ln "rman__torattr___backPlane" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___passCommand" -ln "rman__torattr___passCommand" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___crop" -ln "rman__torattr___crop" -dv 
		-1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___passExtFormat" -ln "rman__torattr___passExtFormat" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___passNameFormat" -ln "rman__torattr___passNameFormat" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___previewPass" -ln "rman__torattr___previewPass" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___defaultDisplacementShader" -ln "rman__torattr___defaultDisplacementShader" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___defaultAtmosphereShader" -ln "rman__torattr___defaultAtmosphereShader" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___defaultInteriorShader" -ln "rman__torattr___defaultInteriorShader" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___outputSurfaceShaders" -ln "rman__torattr___outputSurfaceShaders" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___outputDisplacementShaders" -ln "rman__torattr___outputDisplacementShaders" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___outputLightShaders" -ln "rman__torattr___outputLightShaders" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___outputVolumeShaders" -ln "rman__torattr___outputVolumeShaders" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___outputImagerShaders" -ln "rman__torattr___outputImagerShaders" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__toropt___preFrameScript" -ln "rman__toropt___preFrameScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__toropt___postFrameScript" -ln "rman__toropt___postFrameScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___preRenderScript" -ln "rman__torattr___preRenderScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___postRenderScript" -ln "rman__torattr___postRenderScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___defaultRiOptionsScript" -ln "rman__torattr___defaultRiOptionsScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___defaultRiAttributesScript" -ln "rman__torattr___defaultRiAttributesScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___renderBeginScript" -ln "rman__torattr___renderBeginScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___transformBeginScript" -ln "rman__torattr___transformBeginScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___transformEndScript" -ln "rman__torattr___transformEndScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___postTransformScript" -ln "rman__torattr___postTransformScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___preShapeScript" -ln "rman__torattr___preShapeScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___postShapeScript" -ln "rman__torattr___postShapeScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___cacheShapeScript" -ln "rman__torattr___cacheShapeScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___bakeChannels" -ln "rman__torattr___bakeChannels" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___bakeCrew" -ln "rman__torattr___bakeCrew" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___bakeOutputFile" -ln "rman__torattr___bakeOutputFile" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___customShadingGroup" -ln "rman__torattr___customShadingGroup" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___shaderBindingStrength" -ln "rman__torattr___shaderBindingStrength" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___computeBehavior" -ln "rman__torattr___computeBehavior" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___enableObjectInstancing" -ln "rman__torattr___enableObjectInstancing" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___impliedSSBakeMode" -ln "rman__torattr___impliedSSBakeMode" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__toropt___JOBSTYLE" -ln "rman__toropt___JOBSTYLE" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___deformationBlurStyle" -ln "rman__torattr___deformationBlurStyle" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___deformationBlurScale" -ln "rman__torattr___deformationBlurScale" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__torattr___enableMfcProcPrim" -ln "rman__torattr___enableMfcProcPrim" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___linearizeColors" -ln "rman__torattr___linearizeColors" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___rayTracing" -ln "rman__torattr___rayTracing" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___referenceCamera" -ln "rman__torattr___referenceCamera" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__toropt___enableRIS" -ln "rman__toropt___enableRIS" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___defaultSurfaceShader" -ln "rman__torattr___defaultSurfaceShader" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__trace_maxdepth" -ln "rman__riopt__trace_maxdepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt___PixelVariance" -ln "rman__riopt___PixelVariance" 
		-dv -1 -at "float";
	addAttr -ci true -h true -sn "rman__riopt__bucket_order" -ln "rman__riopt__bucket_order" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__limits_bucketsize" -ln "rman__riopt__limits_bucketsize" 
		-at "long2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__limits_bucketsize0" -ln "rman__riopt__limits_bucketsize0" 
		-dv -1 -at "long" -p "rman__riopt__limits_bucketsize";
	addAttr -ci true -k true -sn "rman__riopt__limits_bucketsize1" -ln "rman__riopt__limits_bucketsize1" 
		-dv -1 -at "long" -p "rman__riopt__limits_bucketsize";
	addAttr -ci true -k true -sn "rman__riopt__limits_gridsize" -ln "rman__riopt__limits_gridsize" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__trace_decimationrate" -ln "rman__riopt__trace_decimationrate" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__limits_threads" -ln "rman__riopt__limits_threads" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Camera_shutteropening" -ln "rman__riopt__Camera_shutteropening" 
		-at "float2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Camera_shutteropening0" -ln "rman__riopt__Camera_shutteropening0" 
		-dv -1 -at "float" -p "rman__riopt__Camera_shutteropening";
	addAttr -ci true -k true -sn "rman__riopt__Camera_shutteropening1" -ln "rman__riopt__Camera_shutteropening1" 
		-dv -1 -at "float" -p "rman__riopt__Camera_shutteropening";
	addAttr -ci true -k true -sn "rman__riopt__Format_resolution" -ln "rman__riopt__Format_resolution" 
		-at "long2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Format_resolution0" -ln "rman__riopt__Format_resolution0" 
		-dv -1 -at "long" -p "rman__riopt__Format_resolution";
	addAttr -ci true -k true -sn "rman__riopt__Format_resolution1" -ln "rman__riopt__Format_resolution1" 
		-dv -1 -at "long" -p "rman__riopt__Format_resolution";
	addAttr -ci true -k true -sn "rman__riopt__Format_pixelaspectratio" -ln "rman__riopt__Format_pixelaspectratio" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__hair_minwidth" -ln "rman__riopt__hair_minwidth" 
		-dv -1 -at "float";
	addAttr -ci true -h true -sn "rman__riopt__rib_compression" -ln "rman__riopt__rib_compression" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__rib_format" -ln "rman__riopt__rib_format" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__rib_precision" -ln "rman__riopt__rib_precision" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__statistics_level" -ln "rman__riopt__statistics_level" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__statistics_filename" -ln "rman__riopt__statistics_filename" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__statistics_xmlfilename" -ln "rman__riopt__statistics_xmlfilename" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Projection_name" -ln "rman__riopt__Projection_name" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Projection2_name" -ln "rman__riopt__Projection2_name" 
		-dt "string";
	addAttr -ci true -uac -k true -sn "rman__riopt__limits_zthreshold" -ln "rman__riopt__limits_zthreshold" 
		-at "float3" -nc 3;
	addAttr -ci true -k true -sn "rman__riopt__limits_zthresholdr" -ln "rman__riopt__limits_zthresholdR" 
		-dv -1 -at "float" -p "rman__riopt__limits_zthreshold";
	addAttr -ci true -k true -sn "rman__riopt__limits_zthresholdg" -ln "rman__riopt__limits_zthresholdG" 
		-dv -1 -at "float" -p "rman__riopt__limits_zthreshold";
	addAttr -ci true -k true -sn "rman__riopt__limits_zthresholdb" -ln "rman__riopt__limits_zthresholdB" 
		-dv -1 -at "float" -p "rman__riopt__limits_zthreshold";
	addAttr -ci true -uac -k true -sn "rman__riopt__limits_othreshold" -ln "rman__riopt__limits_othreshold" 
		-at "float3" -nc 3;
	addAttr -ci true -k true -sn "rman__riopt__limits_othresholdr" -ln "rman__riopt__limits_othresholdR" 
		-dv -1 -at "float" -p "rman__riopt__limits_othreshold";
	addAttr -ci true -k true -sn "rman__riopt__limits_othresholdg" -ln "rman__riopt__limits_othresholdG" 
		-dv -1 -at "float" -p "rman__riopt__limits_othreshold";
	addAttr -ci true -k true -sn "rman__riopt__limits_othresholdb" -ln "rman__riopt__limits_othresholdB" 
		-dv -1 -at "float" -p "rman__riopt__limits_othreshold";
	addAttr -ci true -k true -sn "rman__riopt__limits_texturememory" -ln "rman__riopt__limits_texturememory" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__limits_geocachememory" -ln "rman__riopt__limits_geocachememory" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__limits_proceduralmemory" -ln "rman__riopt__limits_proceduralmemory" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__limits_deepshadowtiles" -ln "rman__riopt__limits_deepshadowtiles" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__limits_deepshadowmemory" -ln "rman__riopt__limits_deepshadowmemory" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__limits_radiositycachememory" -ln "rman__riopt__limits_radiositycachememory" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__limits_brickmemory" -ln "rman__riopt__limits_brickmemory" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Hider_name" -ln "rman__riopt__Hider_name" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Hider_minsamples" -ln "rman__riopt__Hider_minsamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Hider_maxsamples" -ln "rman__riopt__Hider_maxsamples" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Integrator_name" -ln "rman__riopt__Integrator_name" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riattr__trace_maxdiffusedepth" -ln "rman__riattr__trace_maxdiffusedepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riattr__trace_maxspeculardepth" -ln "rman__riattr__trace_maxspeculardepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riattr__trace_samplemotion" -ln "rman__riattr__trace_samplemotion" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riattr__dice_referencecamera" -ln "rman__riattr__dice_referencecamera" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riattr__dice_minlength" -ln "rman__riattr__dice_minlength" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riattr___ShadingRate" -ln "rman__riattr___ShadingRate" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riattr__trace_autobias" -ln "rman__riattr__trace_autobias" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riattr__trace_bias" -ln "rman__riattr__trace_bias" 
		-dv -1 -at "float";
	addAttr -ci true -h true -sn "rman__riattr__displacementbound_coordinatesystem" 
		-ln "rman__riattr__displacementbound_coordinatesystem" -dt "string";
	addAttr -ci true -k true -sn "rman__riattr__displacementbound_sphere" -ln "rman__riattr__displacementbound_sphere" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riattr__trace_displacements" -ln "rman__riattr__trace_displacements" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Projection_fov" -ln "rman__riopt__Projection_fov" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Projection_hsweep" -ln "rman__riopt__Projection_hsweep" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Projection_vsweep" -ln "rman__riopt__Projection_vsweep" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Projection_minor" -ln "rman__riopt__Projection_minor" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Projection2_angle" -ln "rman__riopt__Projection2_angle" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Hider_adaptall" -ln "rman__riopt__Hider_adaptall" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Hider_integrationmode" -ln "rman__riopt__Hider_integrationmode" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Hider_incremental" -ln "rman__riopt__Hider_incremental" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_mergePaths" -ln "rman__riopt__Integrator_mergePaths" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_mergeRadiusScale" -ln "rman__riopt__Integrator_mergeRadiusScale" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_timeRadius" -ln "rman__riopt__Integrator_timeRadius" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_reduceRadius" -ln "rman__riopt__Integrator_reduceRadius" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_connectPaths" -ln "rman__riopt__Integrator_connectPaths" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_maxPathLength" -ln "rman__riopt__Integrator_maxPathLength" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Integrator_sampleMode" -ln "rman__riopt__Integrator_sampleMode" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numLightSamples" -ln "rman__riopt__Integrator_numLightSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numBxdfSamples" -ln "rman__riopt__Integrator_numBxdfSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numIndirectSamples" -ln "rman__riopt__Integrator_numIndirectSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numDiffuseSamples" -ln "rman__riopt__Integrator_numDiffuseSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numSpecularSamples" -ln "rman__riopt__Integrator_numSpecularSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numSubsurfaceSamples" -ln "rman__riopt__Integrator_numSubsurfaceSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numRefractionSamples" -ln "rman__riopt__Integrator_numRefractionSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_rouletteDepth" -ln "rman__riopt__Integrator_rouletteDepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_rouletteThreshold" -ln "rman__riopt__Integrator_rouletteThreshold" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_clampDepth" -ln "rman__riopt__Integrator_clampDepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_clampLuminance" -ln "rman__riopt__Integrator_clampLuminance" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_allowCaustics" -ln "rman__riopt__Integrator_allowCaustics" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numSamples" -ln "rman__riopt__Integrator_numSamples" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Integrator_viewchannel" -ln "rman__riopt__Integrator_viewchannel" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__EnvLight" -ln "rman__EnvLight" -dt "string";
	addAttr -ci true -h true -m -im false -sn "d" -ln "display" -at "message";
	addAttr -ci true -h true -m -im false -sn "c" -ln "channel" -at "message";
	addAttr -ci true -h true -m -im false -sn "rif" -ln "rif" -at "message";
	addAttr -ci true -h true -m -im false -sn "p" -ln "passes" -at "message";
	addAttr -ci true -h true -m -im false -sn "sh" -ln "shared" -at "message";
	addAttr -ci true -k true -sn "rman__riopt__Projection_angle" -ln "rman__riopt__Projection_angle" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__statistics_endofframe" -ln "rman__riopt__statistics_endofframe" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___preWorldBeginScript" -ln "rman__torattr___preWorldBeginScript" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___postWorldBeginScript" -ln "rman__torattr___postWorldBeginScript" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__param__limits_threads" -ln "rman__param__limits_threads" 
		-dv -1 -at "long";
	setAttr ".nt" -type "string" "settings:job";
	setAttr ".rman__torattr___class" -type "string" "RISJob";
	setAttr ".rman__torattr___task" -type "string" "job";
	setAttr -k on ".rman__toropt___renderDataCleanupJob" 0;
	setAttr -k on ".rman__toropt___shaderCleanupJob" 0;
	setAttr -k on ".rman__toropt___textureCleanupJob" 0;
	setAttr -k on ".rman__toropt___ribCleanupJob" 0;
	setAttr -k on ".rman__toropt___ribFlatten" 0;
	setAttr -k on ".rman__toropt___renderDataCleanupFrame" 0;
	setAttr -k on ".rman__toropt___textureCleanupFrame" 0;
	setAttr -k on ".rman__toropt___ribCleanupFrame" 0;
	setAttr ".rman__toropt___primaryCamera" -type "string" "";
	setAttr -k on ".rman__toropt___enableRenderLayers" 0;
	setAttr ".rman__toropt___renderLayer" -type "string" "";
	setAttr ".rman__toropt___motionBlurType" -type "string" "frame";
	setAttr -k on ".rman__toropt___shutterAngle" 80;
	setAttr ".rman__toropt___shutterTiming" -type "string" "frameOpen";
	setAttr ".rman__toropt___cacheCrew" -type "string" "";
	setAttr -k on ".rman__toropt___renumber" 0;
	setAttr -k on ".rman__toropt___renumberStart" 1;
	setAttr -k on ".rman__toropt___renumberBy" 1;
	setAttr -k on ".rman__toropt___lazyRibGen" 0;
	setAttr -k on ".rman__toropt___lazyRender" 0;
	setAttr -k on ".rman__toropt___bakeMode" 0;
	setAttr -k on ".rman__toropt___furChunkSize" 10000;
	setAttr -k on ".rman__torattr___enableRifs" 1;
	setAttr -k on ".rman__toropt___nativeShadingSupport" 0;
	setAttr -k on ".rman__torattr___motionSamples" 2;
	setAttr -k on ".rman__torattr___referenceFrame" 0;
	setAttr -k on ".rman__torattr___motionBlur" 0;
	setAttr -k on ".rman__torattr___mapResolution" -type "long2" 0 0 ;
	setAttr -k on ".rman__torattr___depthOfField" 0;
	setAttr -k on ".rman__torattr___cameraBlur" 0;
	setAttr -k on ".rman__torattr___frontPlane" 0;
	setAttr -k on ".rman__torattr___backPlane" 0;
	setAttr ".rman__torattr___passCommand" -type "string" "";
	setAttr -k on ".rman__torattr___crop" 0;
	setAttr ".rman__torattr___passExtFormat" -type "string" "";
	setAttr ".rman__torattr___passNameFormat" -type "string" "";
	setAttr -k on ".rman__torattr___previewPass" 0;
	setAttr ".rman__torattr___defaultDisplacementShader" -type "string" "";
	setAttr ".rman__torattr___defaultAtmosphereShader" -type "string" "";
	setAttr ".rman__torattr___defaultInteriorShader" -type "string" "";
	setAttr -k on ".rman__torattr___outputSurfaceShaders" 1;
	setAttr -k on ".rman__torattr___outputDisplacementShaders" 1;
	setAttr -k on ".rman__torattr___outputLightShaders" 1;
	setAttr -k on ".rman__torattr___outputVolumeShaders" 1;
	setAttr -k on ".rman__torattr___outputImagerShaders" 1;
	setAttr ".rman__toropt___preFrameScript" -type "string" "";
	setAttr ".rman__toropt___postFrameScript" -type "string" "";
	setAttr ".rman__torattr___preRenderScript" -type "string" "";
	setAttr ".rman__torattr___postRenderScript" -type "string" "";
	setAttr ".rman__torattr___defaultRiOptionsScript" -type "string" "";
	setAttr ".rman__torattr___defaultRiAttributesScript" -type "string" "";
	setAttr ".rman__torattr___renderBeginScript" -type "string" "rmanTimeStampScript";
	setAttr ".rman__torattr___transformBeginScript" -type "string" "";
	setAttr ".rman__torattr___transformEndScript" -type "string" "";
	setAttr ".rman__torattr___postTransformScript" -type "string" "";
	setAttr ".rman__torattr___preShapeScript" -type "string" "";
	setAttr ".rman__torattr___postShapeScript" -type "string" "";
	setAttr ".rman__torattr___cacheShapeScript" -type "string" "";
	setAttr ".rman__torattr___bakeChannels" -type "string" "";
	setAttr ".rman__torattr___bakeCrew" -type "string" "";
	setAttr ".rman__torattr___bakeOutputFile" -type "string" "";
	setAttr ".rman__torattr___customShadingGroup" -type "string" "";
	setAttr -k on ".rman__torattr___shaderBindingStrength" 1;
	setAttr -k on ".rman__torattr___computeBehavior" 1;
	setAttr -k on ".rman__torattr___enableObjectInstancing" 1;
	setAttr ".rman__torattr___impliedSSBakeMode" -type "string" "SSDiffuse";
	setAttr ".rman__toropt___JOBSTYLE" -type "string" "";
	setAttr ".rman__torattr___deformationBlurStyle" -type "string" "none";
	setAttr -k on ".rman__torattr___deformationBlurScale" 1;
	setAttr -k on ".rman__torattr___enableMfcProcPrim" 0;
	setAttr -k on ".rman__torattr___linearizeColors" 1;
	setAttr -k on ".rman__torattr___rayTracing" 1;
	setAttr ".rman__torattr___referenceCamera" -type "string" "";
	setAttr -k on ".rman__toropt___enableRIS" 1;
	setAttr ".rman__torattr___defaultSurfaceShader" -type "string" "PxrDiffuse";
	setAttr -k on ".rman__riopt__trace_maxdepth" 10;
	setAttr -k on ".rman__riopt___PixelVariance" 9.9999997473787516e-05;
	setAttr ".rman__riopt__bucket_order" -type "string" "spiral";
	setAttr -k on ".rman__riopt__limits_bucketsize" -type "long2" 16 16 ;
	setAttr -k on ".rman__riopt__limits_gridsize" 256;
	setAttr -k on ".rman__riopt__trace_decimationrate" 1;
	setAttr -k on ".rman__riopt__limits_threads" 0;
	setAttr -k on ".rman__riopt__Camera_shutteropening" -type "float2" 0 1 ;
	setAttr -k on ".rman__riopt__Format_resolution" -type "long2" 1280 720 ;
	setAttr -k on ".rman__riopt__Format_pixelaspectratio" 1;
	setAttr -k on ".rman__riopt__hair_minwidth" 0.5;
	setAttr ".rman__riopt__rib_compression" -type "string" "none";
	setAttr ".rman__riopt__rib_format" -type "string" "ascii";
	setAttr ".rman__riopt__rib_precision" -type "string" "6";
	setAttr -k on ".rman__riopt__statistics_level" 1;
	setAttr ".rman__riopt__statistics_filename" -type "string" "stdout";
	setAttr ".rman__riopt__statistics_xmlfilename" -type "string" "[AssetRef -cls rmanstat]";
	setAttr ".rman__riopt__Projection_name" -type "string" "";
	setAttr ".rman__riopt__Projection2_name" -type "string" "";
	setAttr -k on ".rman__riopt__limits_zthreshold" -type "float3" 0.99599999 0.99599999 
		0.99599999 ;
	setAttr -k on ".rman__riopt__limits_othreshold" -type "float3" 0.99599999 0.99599999 
		0.99599999 ;
	setAttr -k on ".rman__riopt__limits_texturememory" 2097152;
	setAttr -k on ".rman__riopt__limits_geocachememory" 2097152;
	setAttr -k on ".rman__riopt__limits_proceduralmemory" 0;
	setAttr -k on ".rman__riopt__limits_deepshadowtiles" 1000;
	setAttr -k on ".rman__riopt__limits_deepshadowmemory" 102400;
	setAttr -k on ".rman__riopt__limits_radiositycachememory" 102400;
	setAttr -k on ".rman__riopt__limits_brickmemory" 10240;
	setAttr ".rman__riopt__Hider_name" -type "string" "raytrace";
	setAttr -k on ".rman__riopt__Hider_minsamples" 0;
	setAttr -k on ".rman__riopt__Hider_maxsamples" 256;
	setAttr ".rman__riopt__Integrator_name" -type "string" "PxrPathTracer";
	setAttr -k on ".rman__riattr__trace_maxdiffusedepth" 1;
	setAttr -k on ".rman__riattr__trace_maxspeculardepth" 2;
	setAttr -k on ".rman__riattr__trace_samplemotion" 1;
	setAttr ".rman__riattr__dice_referencecamera" -type "string" "worldcamera";
	setAttr -k on ".rman__riattr___ShadingRate" 1;
	setAttr -k on ".rman__riattr__trace_autobias" 1;
	setAttr -k on ".rman__riattr__trace_bias" 0.0010000000474974513;
	setAttr ".rman__riattr__displacementbound_coordinatesystem" -type "string" "shader";
	setAttr -k on ".rman__riattr__displacementbound_sphere" 0;
	setAttr -k on ".rman__riattr__trace_displacements" 1;
	setAttr -k on ".rman__riopt__Projection_fov" 90;
	setAttr -k on ".rman__riopt__Projection_hsweep" 360;
	setAttr -k on ".rman__riopt__Projection_vsweep" 180;
	setAttr -k on ".rman__riopt__Projection_minor" 0.25;
	setAttr -k on ".rman__riopt__Projection2_angle" 90;
	setAttr -k on ".rman__riopt__Hider_adaptall" 0;
	setAttr ".rman__riopt__Hider_integrationmode" -type "string" "path";
	setAttr -k on ".rman__riopt__Hider_incremental" 0;
	setAttr -k on ".rman__riopt__Integrator_mergePaths" 1;
	setAttr -k on ".rman__riopt__Integrator_mergeRadiusScale" 5;
	setAttr -k on ".rman__riopt__Integrator_timeRadius" 1;
	setAttr -k on ".rman__riopt__Integrator_reduceRadius" 1;
	setAttr -k on ".rman__riopt__Integrator_connectPaths" 1;
	setAttr -k on ".rman__riopt__Integrator_maxPathLength" 10;
	setAttr ".rman__riopt__Integrator_sampleMode" -type "string" "bxdf";
	setAttr -k on ".rman__riopt__Integrator_numLightSamples" 8;
	setAttr -k on ".rman__riopt__Integrator_numBxdfSamples" 8;
	setAttr -k on ".rman__riopt__Integrator_numIndirectSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numDiffuseSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numSpecularSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numSubsurfaceSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numRefractionSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_rouletteDepth" 4;
	setAttr -k on ".rman__riopt__Integrator_rouletteThreshold" 0.20000000298023224;
	setAttr -k on ".rman__riopt__Integrator_clampDepth" 2;
	setAttr -k on ".rman__riopt__Integrator_clampLuminance" 10;
	setAttr -k on ".rman__riopt__Integrator_allowCaustics" 0;
	setAttr -k on ".rman__riopt__Integrator_numSamples" 4;
	setAttr ".rman__riopt__Integrator_viewchannel" -type "string" "Nn";
	setAttr ".rman__EnvLight" -type "string" "";
	setAttr -s 2 ".p";
	setAttr -k on ".rman__riopt__Projection_angle" 90;
	setAttr -k on ".rman__riopt__statistics_endofframe" 0;
	setAttr ".rman__torattr___preWorldBeginScript" -type "string" "";
	setAttr ".rman__torattr___postWorldBeginScript" -type "string" "";
	setAttr -k on ".rman__param__limits_threads" 0;
createNode RenderMan -s -n "rmanFinalGlobals";
	addAttr -ci true -h true -sn "t" -ln "isTemplate" -at "long";
	addAttr -ci true -h true -sn "rman__torattr___class" -ln "rman__torattr___class" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___task" -ln "rman__torattr___task" -dt "string";
	addAttr -ci true -h true -sn "rman__torattr___phase" -ln "rman__torattr___phase" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___computeBehavior" -ln "rman__torattr___computeBehavior" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___passLayer" -ln "rman__torattr___passLayer" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___camera" -ln "rman__torattr___camera" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___crew" -ln "rman__torattr___crew" -dt "string";
	addAttr -ci true -h true -sn "rman__torattr___flavor" -ln "rman__torattr___flavor" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___cameraFlavor" -ln "rman__torattr___cameraFlavor" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___lightcrew" -ln "rman__torattr___lightcrew" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___depthOfField" -ln "rman__torattr___depthOfField" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt___CropWindow" -ln "rman__riopt___CropWindow" 
		-at "compound" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt___CropWindowX" -ln "rman__riopt___CropWindowX" 
		-at "float2" -p "rman__riopt___CropWindow" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt___CropWindowX0" -ln "rman__riopt___CropWindowX0" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowX";
	addAttr -ci true -k true -sn "rman__riopt___CropWindowX1" -ln "rman__riopt___CropWindowX1" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowX";
	addAttr -ci true -k true -sn "rman__riopt___CropWindowY" -ln "rman__riopt___CropWindowY" 
		-at "float2" -p "rman__riopt___CropWindow" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt___CropWindowY0" -ln "rman__riopt___CropWindowY0" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowY";
	addAttr -ci true -k true -sn "rman__riopt___CropWindowY1" -ln "rman__riopt___CropWindowY1" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowY";
	addAttr -ci true -h true -sn "rman__riopt__photon_lifetime" -ln "rman__riopt__photon_lifetime" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__photon_emit" -ln "rman__riopt__photon_emit" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riattr__photon_causticmap" -ln "rman__riattr__photon_causticmap" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riattr__photon_globalmap" -ln "rman__riattr__photon_globalmap" 
		-dt "string";
	addAttr -ci true -h true -m -im false -sn "d" -ln "display" -at "message";
	addAttr -ci true -h true -m -im false -sn "c" -ln "channel" -at "message";
	addAttr -ci true -h true -m -im false -sn "rif" -ln "rif" -at "message";
	addAttr -ci true -h true -m -im false -sn "p" -ln "passes" -at "message";
	addAttr -ci true -h true -m -im false -sn "sh" -ln "shared" -at "message";
	setAttr ".nt" -type "string" "pass:render";
	setAttr ".t" 1;
	setAttr ".rman__torattr___class" -type "string" "Final";
	setAttr ".rman__torattr___task" -type "string" "render";
	setAttr ".rman__torattr___phase" -type "string" "/Job/Frames/Images";
	setAttr -k on ".rman__torattr___computeBehavior" 1;
	setAttr ".rman__torattr___passLayer" -type "string" "";
	setAttr ".rman__torattr___camera" -type "string" "";
	setAttr ".rman__torattr___crew" -type "string" "";
	setAttr ".rman__torattr___flavor" -type "string" "";
	setAttr ".rman__torattr___cameraFlavor" -type "string" "";
	setAttr ".rman__torattr___lightcrew" -type "string" "";
	setAttr -k on ".rman__torattr___depthOfField" 1;
	setAttr -k on ".rman__riopt___CropWindowX" -type "float2" 0 1 ;
	setAttr -k on ".rman__riopt___CropWindowY" -type "float2" 0 1 ;
	setAttr ".rman__riopt__photon_lifetime" -type "string" "transient";
	setAttr -k on ".rman__riopt__photon_emit" 0;
	setAttr ".rman__riattr__photon_causticmap" -type "string" "";
	setAttr ".rman__riattr__photon_globalmap" -type "string" "";
createNode RenderMan -s -n "rmanFinalOutputGlobals0";
	addAttr -ci true -h true -sn "t" -ln "isTemplate" -at "long";
	addAttr -ci true -h true -sn "rman__torattr___class" -ln "rman__torattr___class" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___task" -ln "rman__torattr___task" -dt "string";
	addAttr -ci true -k true -sn "rman__torattr___computeBehavior" -ln "rman__torattr___computeBehavior" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___primaryDisplay" -ln "rman__torattr___primaryDisplay" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___dspyID" -ln "rman__torattr___dspyID" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___dspyGetChannelsFromCamera" -ln "rman__torattr___dspyGetChannelsFromCamera" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Display_name" -ln "rman__riopt__Display_name" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Display_type" -ln "rman__riopt__Display_type" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Display_mode" -ln "rman__riopt__Display_mode" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Display_filter" -ln "rman__riopt__Display_filter" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Display_filterwidth" -ln "rman__riopt__Display_filterwidth" 
		-at "float2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_filterwidth0" -ln "rman__riopt__Display_filterwidth0" 
		-dv -1 -at "float" -p "rman__riopt__Display_filterwidth";
	addAttr -ci true -k true -sn "rman__riopt__Display_filterwidth1" -ln "rman__riopt__Display_filterwidth1" 
		-dv -1 -at "float" -p "rman__riopt__Display_filterwidth";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantize" -ln "rman__riopt__Display_quantize" 
		-at "compound" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeX" -ln "rman__riopt__Display_quantizeX" 
		-at "long2" -p "rman__riopt__Display_quantize" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeX0" -ln "rman__riopt__Display_quantizeX0" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeX";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeX1" -ln "rman__riopt__Display_quantizeX1" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeX";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeY" -ln "rman__riopt__Display_quantizeY" 
		-at "long2" -p "rman__riopt__Display_quantize" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeY0" -ln "rman__riopt__Display_quantizeY0" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeY";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeY1" -ln "rman__riopt__Display_quantizeY1" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeY";
	addAttr -ci true -k true -sn "rman__riopt__Display_dither" -ln "rman__riopt__Display_dither" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Display_exposure" -ln "rman__riopt__Display_exposure" 
		-at "float2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_exposure0" -ln "rman__riopt__Display_exposure0" 
		-dv -1 -at "float" -p "rman__riopt__Display_exposure";
	addAttr -ci true -k true -sn "rman__riopt__Display_exposure1" -ln "rman__riopt__Display_exposure1" 
		-dv -1 -at "float" -p "rman__riopt__Display_exposure";
	addAttr -ci true -k true -sn "rman__riopt__Display_remap" -ln "rman__riopt__Display_remap" 
		-at "float3" -nc 3;
	addAttr -ci true -k true -sn "rman__riopt__Display_remap0" -ln "rman__riopt__Display_remap0" 
		-dv -1 -at "float" -p "rman__riopt__Display_remap";
	addAttr -ci true -k true -sn "rman__riopt__Display_remap1" -ln "rman__riopt__Display_remap1" 
		-dv -1 -at "float" -p "rman__riopt__Display_remap";
	addAttr -ci true -k true -sn "rman__riopt__Display_remap2" -ln "rman__riopt__Display_remap2" 
		-dv -1 -at "float" -p "rman__riopt__Display_remap";
	addAttr -ci true -h true -m -im false -sn "d" -ln "display" -at "message";
	addAttr -ci true -h true -m -im false -sn "c" -ln "channel" -at "message";
	addAttr -ci true -h true -m -im false -sn "rif" -ln "rif" -at "message";
	addAttr -ci true -h true -m -im false -sn "p" -ln "passes" -at "message";
	addAttr -ci true -h true -m -im false -sn "sh" -ln "shared" -at "message";
	setAttr ".nt" -type "string" "settings:display";
	setAttr ".t" 1;
	setAttr ".rman__torattr___class" -type "string" "Primary";
	setAttr ".rman__torattr___task" -type "string" "display";
	setAttr -k on ".rman__torattr___computeBehavior" 1;
	setAttr -k on ".rman__torattr___primaryDisplay" 1;
	setAttr ".rman__torattr___dspyID" -type "string" "";
	setAttr -k on ".rman__torattr___dspyGetChannelsFromCamera" 1;
	setAttr ".rman__riopt__Display_name" -type "string" "[passinfo this filename]";
	setAttr ".rman__riopt__Display_type" -type "string" "openexr";
	setAttr ".rman__riopt__Display_mode" -type "string" "rgba";
	setAttr ".rman__riopt__Display_filter" -type "string" "gaussian";
	setAttr -k on ".rman__riopt__Display_filterwidth" -type "float2" 2 2 ;
	setAttr -k on ".rman__riopt__Display_quantizeX" -type "long2" 0 0 ;
	setAttr -k on ".rman__riopt__Display_quantizeY" -type "long2" 0 0 ;
	setAttr -k on ".rman__riopt__Display_dither" 0;
	setAttr -k on ".rman__riopt__Display_exposure" -type "float2" 1 1 ;
	setAttr -k on ".rman__riopt__Display_remap" -type "float3" 0 0 0 ;
createNode RenderMan -s -n "rmanRerenderRISGlobals";
	addAttr -ci true -h true -sn "t" -ln "isTemplate" -at "long";
	addAttr -ci true -h true -sn "rman__torattr___class" -ln "rman__torattr___class" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___task" -ln "rman__torattr___task" -dt "string";
	addAttr -ci true -h true -sn "rman__torattr___phase" -ln "rman__torattr___phase" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___previewPass" -ln "rman__torattr___previewPass" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___motionBlur" -ln "rman__torattr___motionBlur" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___computeBehavior" -ln "rman__torattr___computeBehavior" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___passLayer" -ln "rman__torattr___passLayer" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___camera" -ln "rman__torattr___camera" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___crew" -ln "rman__torattr___crew" -dt "string";
	addAttr -ci true -h true -sn "rman__torattr___flavor" -ln "rman__torattr___flavor" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___cameraFlavor" -ln "rman__torattr___cameraFlavor" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___lightcrew" -ln "rman__torattr___lightcrew" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___depthOfField" -ln "rman__torattr___depthOfField" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___passNameFormat" -ln "rman__torattr___passNameFormat" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__shading_directlightingsamples" -ln "rman__riopt__shading_directlightingsamples" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__bucket_order" -ln "rman__riopt__bucket_order" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__limits_bucketsize" -ln "rman__riopt__limits_bucketsize" 
		-at "long2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__limits_bucketsize0" -ln "rman__riopt__limits_bucketsize0" 
		-dv -1 -at "long" -p "rman__riopt__limits_bucketsize";
	addAttr -ci true -k true -sn "rman__riopt__limits_bucketsize1" -ln "rman__riopt__limits_bucketsize1" 
		-dv -1 -at "long" -p "rman__riopt__limits_bucketsize";
	addAttr -ci true -k true -sn "rman__riopt___PixelVariance" -ln "rman__riopt___PixelVariance" 
		-dv -1 -at "float";
	addAttr -ci true -h true -sn "rman__riopt__Hider_name" -ln "rman__riopt__Hider_name" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Hider_minsamples" -ln "rman__riopt__Hider_minsamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Hider_maxsamples" -ln "rman__riopt__Hider_maxsamples" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Integrator_name" -ln "rman__riopt__Integrator_name" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt___CropWindow" -ln "rman__riopt___CropWindow" 
		-at "compound" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt___CropWindowX" -ln "rman__riopt___CropWindowX" 
		-at "float2" -p "rman__riopt___CropWindow" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt___CropWindowX0" -ln "rman__riopt___CropWindowX0" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowX";
	addAttr -ci true -k true -sn "rman__riopt___CropWindowX1" -ln "rman__riopt___CropWindowX1" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowX";
	addAttr -ci true -k true -sn "rman__riopt___CropWindowY" -ln "rman__riopt___CropWindowY" 
		-at "float2" -p "rman__riopt___CropWindow" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt___CropWindowY0" -ln "rman__riopt___CropWindowY0" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowY";
	addAttr -ci true -k true -sn "rman__riopt___CropWindowY1" -ln "rman__riopt___CropWindowY1" 
		-dv -1 -at "float" -p "rman__riopt___CropWindowY";
	addAttr -ci true -h true -sn "rman__riopt__photon_lifetime" -ln "rman__riopt__photon_lifetime" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__photon_emit" -ln "rman__riopt__photon_emit" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riattr__trace_maxspeculardepth" -ln "rman__riattr__trace_maxspeculardepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riattr__trace_maxdiffusedepth" -ln "rman__riattr__trace_maxdiffusedepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riattr__trace_displacements" -ln "rman__riattr__trace_displacements" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riattr__photon_causticmap" -ln "rman__riattr__photon_causticmap" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riattr__photon_globalmap" -ln "rman__riattr__photon_globalmap" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Hider_integrationmode" -ln "rman__riopt__Hider_integrationmode" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_mergePaths" -ln "rman__riopt__Integrator_mergePaths" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_mergeRadiusScale" -ln "rman__riopt__Integrator_mergeRadiusScale" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_timeRadius" -ln "rman__riopt__Integrator_timeRadius" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_reduceRadius" -ln "rman__riopt__Integrator_reduceRadius" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_connectPaths" -ln "rman__riopt__Integrator_connectPaths" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_maxPathLength" -ln "rman__riopt__Integrator_maxPathLength" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Integrator_sampleMode" -ln "rman__riopt__Integrator_sampleMode" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numLightSamples" -ln "rman__riopt__Integrator_numLightSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numBxdfSamples" -ln "rman__riopt__Integrator_numBxdfSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numIndirectSamples" -ln "rman__riopt__Integrator_numIndirectSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numDiffuseSamples" -ln "rman__riopt__Integrator_numDiffuseSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numSpecularSamples" -ln "rman__riopt__Integrator_numSpecularSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numSubsurfaceSamples" -ln "rman__riopt__Integrator_numSubsurfaceSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numRefractionSamples" -ln "rman__riopt__Integrator_numRefractionSamples" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_rouletteDepth" -ln "rman__riopt__Integrator_rouletteDepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_rouletteThreshold" -ln "rman__riopt__Integrator_rouletteThreshold" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_clampDepth" -ln "rman__riopt__Integrator_clampDepth" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_clampLuminance" -ln "rman__riopt__Integrator_clampLuminance" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_allowCaustics" -ln "rman__riopt__Integrator_allowCaustics" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__riopt__Integrator_numSamples" -ln "rman__riopt__Integrator_numSamples" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Integrator_viewchannel" -ln "rman__riopt__Integrator_viewchannel" 
		-dt "string";
	addAttr -ci true -h true -m -im false -sn "d" -ln "display" -at "message";
	addAttr -ci true -h true -m -im false -sn "c" -ln "channel" -at "message";
	addAttr -ci true -h true -m -im false -sn "rif" -ln "rif" -at "message";
	addAttr -ci true -h true -m -im false -sn "p" -ln "passes" -at "message";
	addAttr -ci true -h true -m -im false -sn "sh" -ln "shared" -at "message";
	addAttr -ci true -h true -sn "rman__riopt__Hider_samplemode" -ln "rman__riopt__Hider_samplemode" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Hider_incremental" -ln "rman__riopt__Hider_incremental" 
		-dv -1 -at "long";
	setAttr ".nt" -type "string" "pass:render";
	setAttr ".t" 1;
	setAttr ".rman__torattr___class" -type "string" "RerenderRIS";
	setAttr ".rman__torattr___task" -type "string" "render";
	setAttr ".rman__torattr___phase" -type "string" "/Job/Frames/Images";
	setAttr -k on ".rman__torattr___previewPass" 1;
	setAttr -k on ".rman__torattr___motionBlur" 0;
	setAttr -k on ".rman__torattr___computeBehavior" 1;
	setAttr ".rman__torattr___passLayer" -type "string" "";
	setAttr ".rman__torattr___camera" -type "string" "";
	setAttr ".rman__torattr___crew" -type "string" "";
	setAttr ".rman__torattr___flavor" -type "string" "";
	setAttr ".rman__torattr___cameraFlavor" -type "string" "";
	setAttr ".rman__torattr___lightcrew" -type "string" "";
	setAttr -k on ".rman__torattr___depthOfField" 1;
	setAttr ".rman__torattr___passNameFormat" -type "string" "";
	setAttr -k on ".rman__riopt__shading_directlightingsamples" 4;
	setAttr ".rman__riopt__bucket_order" -type "string" "spiral";
	setAttr -k on ".rman__riopt__limits_bucketsize" -type "long2" 16 16 ;
	setAttr -k on ".rman__riopt___PixelVariance" 0.0099999997764825821;
	setAttr ".rman__riopt__Hider_name" -type "string" "raytrace";
	setAttr -k on ".rman__riopt__Hider_minsamples" 0;
	setAttr -k on ".rman__riopt__Hider_maxsamples" 256;
	setAttr ".rman__riopt__Integrator_name" -type "string" "PxrPathTracer";
	setAttr -k on ".rman__riopt___CropWindowX" -type "float2" 0 1 ;
	setAttr -k on ".rman__riopt___CropWindowY" -type "float2" 0 1 ;
	setAttr ".rman__riopt__photon_lifetime" -type "string" "transient";
	setAttr -k on ".rman__riopt__photon_emit" 0;
	setAttr -k on ".rman__riattr__trace_maxspeculardepth" 2;
	setAttr -k on ".rman__riattr__trace_maxdiffusedepth" 1;
	setAttr -k on ".rman__riattr__trace_displacements" 1;
	setAttr ".rman__riattr__photon_causticmap" -type "string" "";
	setAttr ".rman__riattr__photon_globalmap" -type "string" "";
	setAttr ".rman__riopt__Hider_integrationmode" -type "string" "path";
	setAttr -k on ".rman__riopt__Integrator_mergePaths" 1;
	setAttr -k on ".rman__riopt__Integrator_mergeRadiusScale" 5;
	setAttr -k on ".rman__riopt__Integrator_timeRadius" 1;
	setAttr -k on ".rman__riopt__Integrator_reduceRadius" 1;
	setAttr -k on ".rman__riopt__Integrator_connectPaths" 1;
	setAttr -k on ".rman__riopt__Integrator_maxPathLength" 10;
	setAttr ".rman__riopt__Integrator_sampleMode" -type "string" "bxdf";
	setAttr -k on ".rman__riopt__Integrator_numLightSamples" 8;
	setAttr -k on ".rman__riopt__Integrator_numBxdfSamples" 8;
	setAttr -k on ".rman__riopt__Integrator_numIndirectSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numDiffuseSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numSpecularSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numSubsurfaceSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_numRefractionSamples" 1;
	setAttr -k on ".rman__riopt__Integrator_rouletteDepth" 4;
	setAttr -k on ".rman__riopt__Integrator_rouletteThreshold" 0.20000000298023224;
	setAttr -k on ".rman__riopt__Integrator_clampDepth" 2;
	setAttr -k on ".rman__riopt__Integrator_clampLuminance" 10;
	setAttr -k on ".rman__riopt__Integrator_allowCaustics" 0;
	setAttr -k on ".rman__riopt__Integrator_numSamples" 4;
	setAttr ".rman__riopt__Integrator_viewchannel" -type "string" "Nn";
	setAttr ".rman__riopt__Hider_samplemode" -type "string" "";
	setAttr -k on ".rman__riopt__Hider_incremental" 1;
createNode RenderMan -s -n "rmanRerenderRISOutputGlobals0";
	addAttr -ci true -h true -sn "t" -ln "isTemplate" -at "long";
	addAttr -ci true -h true -sn "rman__torattr___class" -ln "rman__torattr___class" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__torattr___task" -ln "rman__torattr___task" -dt "string";
	addAttr -ci true -k true -sn "rman__torattr___computeBehavior" -ln "rman__torattr___computeBehavior" 
		-dv -1 -at "long";
	addAttr -ci true -k true -sn "rman__torattr___primaryDisplay" -ln "rman__torattr___primaryDisplay" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__torattr___dspyID" -ln "rman__torattr___dspyID" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__torattr___dspyGetChannelsFromCamera" -ln "rman__torattr___dspyGetChannelsFromCamera" 
		-dv -1 -at "long";
	addAttr -ci true -h true -sn "rman__riopt__Display_name" -ln "rman__riopt__Display_name" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Display_type" -ln "rman__riopt__Display_type" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Display_mode" -ln "rman__riopt__Display_mode" 
		-dt "string";
	addAttr -ci true -h true -sn "rman__riopt__Display_filter" -ln "rman__riopt__Display_filter" 
		-dt "string";
	addAttr -ci true -k true -sn "rman__riopt__Display_filterwidth" -ln "rman__riopt__Display_filterwidth" 
		-at "float2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_filterwidth0" -ln "rman__riopt__Display_filterwidth0" 
		-dv -1 -at "float" -p "rman__riopt__Display_filterwidth";
	addAttr -ci true -k true -sn "rman__riopt__Display_filterwidth1" -ln "rman__riopt__Display_filterwidth1" 
		-dv -1 -at "float" -p "rman__riopt__Display_filterwidth";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantize" -ln "rman__riopt__Display_quantize" 
		-at "compound" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeX" -ln "rman__riopt__Display_quantizeX" 
		-at "long2" -p "rman__riopt__Display_quantize" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeX0" -ln "rman__riopt__Display_quantizeX0" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeX";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeX1" -ln "rman__riopt__Display_quantizeX1" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeX";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeY" -ln "rman__riopt__Display_quantizeY" 
		-at "long2" -p "rman__riopt__Display_quantize" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeY0" -ln "rman__riopt__Display_quantizeY0" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeY";
	addAttr -ci true -k true -sn "rman__riopt__Display_quantizeY1" -ln "rman__riopt__Display_quantizeY1" 
		-dv -1 -at "long" -p "rman__riopt__Display_quantizeY";
	addAttr -ci true -k true -sn "rman__riopt__Display_dither" -ln "rman__riopt__Display_dither" 
		-dv -1 -at "float";
	addAttr -ci true -k true -sn "rman__riopt__Display_exposure" -ln "rman__riopt__Display_exposure" 
		-at "float2" -nc 2;
	addAttr -ci true -k true -sn "rman__riopt__Display_exposure0" -ln "rman__riopt__Display_exposure0" 
		-dv -1 -at "float" -p "rman__riopt__Display_exposure";
	addAttr -ci true -k true -sn "rman__riopt__Display_exposure1" -ln "rman__riopt__Display_exposure1" 
		-dv -1 -at "float" -p "rman__riopt__Display_exposure";
	addAttr -ci true -k true -sn "rman__riopt__Display_remap" -ln "rman__riopt__Display_remap" 
		-at "float3" -nc 3;
	addAttr -ci true -k true -sn "rman__riopt__Display_remap0" -ln "rman__riopt__Display_remap0" 
		-dv -1 -at "float" -p "rman__riopt__Display_remap";
	addAttr -ci true -k true -sn "rman__riopt__Display_remap1" -ln "rman__riopt__Display_remap1" 
		-dv -1 -at "float" -p "rman__riopt__Display_remap";
	addAttr -ci true -k true -sn "rman__riopt__Display_remap2" -ln "rman__riopt__Display_remap2" 
		-dv -1 -at "float" -p "rman__riopt__Display_remap";
	addAttr -ci true -h true -m -im false -sn "d" -ln "display" -at "message";
	addAttr -ci true -h true -m -im false -sn "c" -ln "channel" -at "message";
	addAttr -ci true -h true -m -im false -sn "rif" -ln "rif" -at "message";
	addAttr -ci true -h true -m -im false -sn "p" -ln "passes" -at "message";
	addAttr -ci true -h true -m -im false -sn "sh" -ln "shared" -at "message";
	setAttr ".nt" -type "string" "settings:display";
	setAttr ".t" 1;
	setAttr ".rman__torattr___class" -type "string" "PrimaryRerender";
	setAttr ".rman__torattr___task" -type "string" "display";
	setAttr -k on ".rman__torattr___computeBehavior" 1;
	setAttr -k on ".rman__torattr___primaryDisplay" 1;
	setAttr ".rman__torattr___dspyID" -type "string" "";
	setAttr -k on ".rman__torattr___dspyGetChannelsFromCamera" 1;
	setAttr ".rman__riopt__Display_name" -type "string" "[passinfo this filename]";
	setAttr ".rman__riopt__Display_type" -type "string" "openexr";
	setAttr ".rman__riopt__Display_mode" -type "string" "rgba";
	setAttr ".rman__riopt__Display_filter" -type "string" "gaussian";
	setAttr -k on ".rman__riopt__Display_filterwidth" -type "float2" 2 2 ;
	setAttr -k on ".rman__riopt__Display_quantizeX" -type "long2" 0 0 ;
	setAttr -k on ".rman__riopt__Display_quantizeY" -type "long2" 0 0 ;
	setAttr -k on ".rman__riopt__Display_dither" 0;
	setAttr -k on ".rman__riopt__Display_exposure" -type "float2" 1 1 ;
	setAttr -k on ".rman__riopt__Display_remap" -type "float3" 0 0 0 ;
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 5 ".lnk";
	setAttr -s 5 ".slnk";
createNode displayLayerManager -n "layerManager";
	setAttr ".cdl" 1;
	setAttr -s 2 ".dli[1]"  1;
	setAttr -s 2 ".dli";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode rmanDayLight -n "rmanDayLight";
	setAttr ".direction" -type "float3" 0 1 0 ;
createNode PxrLMDiffuse -n "PxrLM_Ground";
	setAttr ".frontColor" -type "float3" 1 1 1 ;
	setAttr ".backColor" -type "float3" 1 1 1 ;
createNode shadingEngine -n "PxrLMDiffuse1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode ramp -n "ramp1";
	setAttr ".t" 4;
	setAttr ".in" 3;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0.064999997615814209;
	setAttr ".cel[0].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[1].ep" 0.875;
	setAttr ".cel[1].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[2].ep" 0.69499999284744263;
	setAttr ".cel[2].ec" -type "float3" 0.36708629 0.36708629 0.36708629 ;
createNode place2dTexture -n "place2dTexture1";
createNode ramp -n "ramp2";
	setAttr ".t" 4;
	setAttr ".in" 3;
	setAttr -s 3 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[2].ep" 0.69499999284744263;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[3].ep" 0.67000001668930054;
createNode place2dTexture -n "place2dTexture2";
createNode solidFractal -n "solidFractal1";
	setAttr ".ra" 1;
	setAttr ".fr" 0.20000000298023224;
createNode RMSDisplacement -n "RMSDisplacement_Ground";
	setAttr ".displacementAmount" 6;
	setAttr ".displacementCenter" 0;
createNode shadingEngine -n "RMSDisplacement1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 2.3428718790045338;
createNode PxrLMMetal -n "PxrLMMetal_Proxy_Object";
createNode shadingEngine -n "PxrLMMetal1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode solidFractal -n "solidFractal2";
	setAttr ".ra" 1;
	setAttr ".fr" 1.5;
createNode polyPlane -n "polyPlane1";
	setAttr ".sw" 40;
	setAttr ".sh" 40;
	setAttr ".cuv" 2;
createNode polyTweak -n "polyTweak1";
	setAttr ".uopa" yes;
	setAttr -s 1272 ".tk";
	setAttr ".tk[20]" -type "float3" 0 0.0017938053 0 ;
	setAttr ".tk[21]" -type "float3" 0 0.0037498395 0 ;
	setAttr ".tk[22]" -type "float3" 0 0.00050795852 0 ;
	setAttr ".tk[24]" -type "float3" 0 0.00019607844 0 ;
	setAttr ".tk[47]" -type "float3" 1.9377106e-07 8.9669044e-08 -6.9058092e-07 ;
	setAttr ".tk[48]" -type "float3" 1.1515789e-08 6.4124109e-08 -5.7625323e-07 ;
	setAttr ".tk[49]" -type "float3" -3.4422008e-08 1.388918e-08 -1.3571231e-07 ;
	setAttr ".tk[53]" -type "float3" 0 0.00027450983 0 ;
	setAttr ".tk[59]" -type "float3" -1.65575e-06 0.00092591613 2.453045e-06 ;
	setAttr ".tk[60]" -type "float3" -3.1451382e-06 0.006667152 5.7394886e-06 ;
	setAttr ".tk[61]" -type "float3" -1.278025e-08 0.009885218 -2.8426976e-07 ;
	setAttr ".tk[62]" -type "float3" -2.2466056e-09 0.0099815903 -6.2086478e-09 ;
	setAttr ".tk[63]" -type "float3" 0 0.002307574 0 ;
	setAttr ".tk[64]" -type "float3" 0.00010113958 0.003835256 -6.7288847e-06 ;
	setAttr ".tk[65]" -type "float3" 0 0.0080229724 0 ;
	setAttr ".tk[66]" -type "float3" -1.1580906e-06 0.00073986757 1.1580908e-06 ;
	setAttr ".tk[68]" -type "float3" -0.00014860366 0.003966236 0.0001795014 ;
	setAttr ".tk[69]" -type "float3" -3.3607391e-06 0.0074167927 0.00049339561 ;
	setAttr ".tk[70]" -type "float3" 4.6505345e-05 0.0017664755 0.00014209804 ;
	setAttr ".tk[71]" -type "float3" 3.2935946e-05 0.00090317492 0.00021872335 ;
	setAttr ".tk[72]" -type "float3" 9.4624374e-06 0.00026889774 4.4802968e-05 ;
	setAttr ".tk[86]" -type "float3" 2.7768186e-07 7.8481091e-05 -4.8067614e-07 ;
	setAttr ".tk[87]" -type "float3" 1.3293614e-05 0.0018381865 -2.0414454e-05 ;
	setAttr ".tk[88]" -type "float3" 3.549051e-05 0.00036891116 -8.5493601e-05 ;
	setAttr ".tk[89]" -type "float3" 2.218517e-05 9.3063951e-05 -0.0001222657 ;
	setAttr ".tk[90]" -type "float3" -7.262805e-06 6.2735885e-06 -9.2503418e-05 ;
	setAttr ".tk[91]" -type "float3" -8.3786053e-06 1.4025902e-06 -3.1565916e-05 ;
	setAttr ".tk[92]" -type "float3" -1.0275913e-06 1.4194372e-07 -2.6362511e-06 ;
	setAttr ".tk[93]" -type "float3" -1.2901819e-09 0.0024285002 -2.7887737e-09 ;
	setAttr ".tk[94]" -type "float3" 0 0.0087464135 0 ;
	setAttr ".tk[95]" -type "float3" 0 0.0019797003 0 ;
	setAttr ".tk[99]" -type "float3" -1.9673807e-05 0.0025817978 2.8186785e-05 ;
	setAttr ".tk[100]" -type "float3" -3.6141821e-05 0.0098125096 4.403073e-05 ;
	setAttr ".tk[101]" -type "float3" -4.6817695e-06 0.010549853 -4.5687568e-05 ;
	setAttr ".tk[102]" -type "float3" -1.0011686e-05 0.0097744139 -6.4114385e-05 ;
	setAttr ".tk[103]" -type "float3" 0.00014137135 0.0065220734 -9.2611561e-05 ;
	setAttr ".tk[104]" -type "float3" -1.6429667e-05 0.0087353494 0.0003489198 ;
	setAttr ".tk[105]" -type "float3" -0.00043865596 0.017456478 0.00052934967 ;
	setAttr ".tk[106]" -type "float3" 0.00044959746 0.012711963 -1.7614668e-05 ;
	setAttr ".tk[107]" -type "float3" -3.0942495e-06 0.00098835898 -1.3278201e-10 ;
	setAttr ".tk[108]" -type "float3" -1.8875471e-05 0.00031295771 -2.1090425e-06 ;
	setAttr ".tk[109]" -type "float3" -0.0012761113 0.015002851 -9.8129465e-05 ;
	setAttr ".tk[110]" -type "float3" -0.00069089112 0.019942295 0.00045343224 ;
	setAttr ".tk[111]" -type "float3" 0.00029545065 0.020450857 0.0016518065 ;
	setAttr ".tk[112]" -type "float3" 0.00097251893 0.026035931 0.0050812834 ;
	setAttr ".tk[113]" -type "float3" 0.0010053441 0.019845461 0.0041013639 ;
	setAttr ".tk[114]" -type "float3" 0.00042719801 0.0090999557 0.0014683598 ;
	setAttr ".tk[115]" -type "float3" 0.00011878424 0.0026089863 0.00037957862 ;
	setAttr ".tk[116]" -type "float3" 1.6584349e-06 3.9061175e-05 3.0568688e-06 ;
	setAttr ".tk[126]" -type "float3" 2.0376265e-06 1.0275659e-06 -1.6706097e-06 ;
	setAttr ".tk[127]" -type "float3" -0.00010238824 0.0051656263 0.00010799263 ;
	setAttr ".tk[128]" -type "float3" -0.00024931543 0.01028026 0.00084446889 ;
	setAttr ".tk[129]" -type "float3" 0.0012804292 0.010032075 0.00091646303 ;
	setAttr ".tk[130]" -type "float3" 0.0012400466 0.0083906306 -0.00019201753 ;
	setAttr ".tk[131]" -type "float3" 2.6707321e-05 0.0019081259 -0.00073298375 ;
	setAttr ".tk[132]" -type "float3" -8.406979e-05 4.9148148e-05 -0.00051659351 ;
	setAttr ".tk[133]" -type "float3" -5.9029288e-05 0.0010388063 -0.00021527783 ;
	setAttr ".tk[134]" -type "float3" -1.7504652e-05 0.0093702525 -4.7296769e-05 ;
	setAttr ".tk[135]" -type "float3" -1.3947727e-06 0.0099270688 -2.351868e-06 ;
	setAttr ".tk[136]" -type "float3" 0 0.0020168184 0 ;
	setAttr ".tk[137]" -type "float3" -5.3795486e-07 3.6059762e-05 1.4350899e-06 ;
	setAttr ".tk[138]" -type "float3" -1.6314219e-05 0.00056731486 1.9918765e-05 ;
	setAttr ".tk[139]" -type "float3" -5.800401e-05 0.0065556169 9.5128744e-05 ;
	setAttr ".tk[140]" -type "float3" -7.1764025e-06 0.011651888 4.6808658e-05 ;
	setAttr ".tk[141]" -type "float3" 0.00010989601 0.01270377 -0.0002641874 ;
	setAttr ".tk[142]" -type "float3" 1.232855e-05 0.0098420838 -0.00023242712 ;
	setAttr ".tk[143]" -type "float3" -3.3412001e-05 0.0094142631 -0.00011854648 ;
	setAttr ".tk[144]" -type "float3" -0.00021100476 0.016923474 0.00024400644 ;
	setAttr ".tk[145]" -type "float3" -7.4698153e-05 0.019855782 0.00029095073 ;
	setAttr ".tk[146]" -type "float3" 0.00060863642 0.019811235 -0.00091487577 ;
	setAttr ".tk[147]" -type "float3" 0.00073235662 0.0094868718 -0.00068878283 ;
	setAttr ".tk[148]" -type "float3" -5.3928097e-06 2.6821967e-06 -1.1753869e-05 ;
	setAttr ".tk[149]" -type "float3" -3.9729548e-07 1.4468002e-07 -5.9198197e-07 ;
	setAttr ".tk[150]" -type "float3" -0.00021131447 0.0025785125 -0.00022698275 ;
	setAttr ".tk[151]" -type "float3" -0.00079375872 0.013128889 -0.0012831378 ;
	setAttr ".tk[152]" -type "float3" -0.00037425882 0.01918086 -0.0016263077 ;
	setAttr ".tk[153]" -type "float3" -0.00050811854 0.031181304 -0.0041307546 ;
	setAttr ".tk[154]" -type "float3" -0.00011101788 0.030234797 -0.0011837991 ;
	setAttr ".tk[155]" -type "float3" 0.00013834688 0.025149647 0.0015668122 ;
	setAttr ".tk[156]" -type "float3" 0.00061889662 0.018459801 0.0018460508 ;
	setAttr ".tk[157]" -type "float3" 0.00066370226 0.01088979 0.0014100327 ;
	setAttr ".tk[158]" -type "float3" 2.2433407e-05 0.00034742369 3.594848e-05 ;
	setAttr ".tk[166]" -type "float3" 5.7317004e-07 3.4193752e-07 -3.3893298e-07 ;
	setAttr ".tk[167]" -type "float3" 2.5083968e-05 0.0011081519 -4.1064172e-06 ;
	setAttr ".tk[168]" -type "float3" -0.0013027716 0.01167507 0.0010223408 ;
	setAttr ".tk[169]" -type "float3" -0.0007647156 0.024304939 0.00286606 ;
	setAttr ".tk[170]" -type "float3" 0.0039684568 0.02201486 0.0011153036 ;
	setAttr ".tk[171]" -type "float3" 0.0024130405 0.010378968 -0.00032041618 ;
	setAttr ".tk[172]" -type "float3" 0.00011077925 0.0035956157 -0.00064688007 ;
	setAttr ".tk[173]" -type "float3" -6.9117821e-05 0.0002894013 -0.00083948299 ;
	setAttr ".tk[174]" -type "float3" -0.00016253229 0.0076202825 -0.00082314055 ;
	setAttr ".tk[175]" -type "float3" -0.00016714893 0.0099894637 -0.00047562507 ;
	setAttr ".tk[176]" -type "float3" -4.5400884e-05 0.0063065495 -0.00013757827 ;
	setAttr ".tk[177]" -type "float3" 3.8781247e-05 0.00058377115 -1.5562771e-05 ;
	setAttr ".tk[178]" -type "float3" -0.00012146208 0.0013695095 0.00013391476 ;
	setAttr ".tk[179]" -type "float3" -0.00026611492 0.0097507285 0.00030752702 ;
	setAttr ".tk[180]" -type "float3" 5.2271775e-05 0.013237175 6.8088717e-05 ;
	setAttr ".tk[181]" -type "float3" 0.00038153684 0.013804308 -0.00033587101 ;
	setAttr ".tk[182]" -type "float3" 2.7917098e-05 0.010933405 -0.00014463151 ;
	setAttr ".tk[183]" -type "float3" -1.503255e-05 0.02011523 0.00033253778 ;
	setAttr ".tk[184]" -type "float3" -7.1861679e-05 0.02220895 0.00050070795 ;
	setAttr ".tk[185]" -type "float3" 3.4533485e-05 0.019708652 -0.0006709671 ;
	setAttr ".tk[186]" -type "float3" 0.0002452757 0.013214459 -0.0011645734 ;
	setAttr ".tk[187]" -type "float3" -4.0225277e-06 0.0050772158 -0.00076528115 ;
	setAttr ".tk[188]" -type "float3" -0.00019300004 0.00021107587 -0.00042952466 ;
	setAttr ".tk[189]" -type "float3" -0.00018696891 9.6010335e-05 -0.000279031 ;
	setAttr ".tk[190]" -type "float3" -6.6709465e-05 2.948258e-05 -8.5204578e-05 ;
	setAttr ".tk[191]" -type "float3" -5.0558192e-06 1.8504811e-06 -6.5628437e-06 ;
	setAttr ".tk[192]" -type "float3" -3.6471115e-09 7.8017898e-10 -6.2765575e-09 ;
	setAttr ".tk[193]" -type "float3" -6.4945743e-06 0.00080511294 -2.6597085e-05 ;
	setAttr ".tk[194]" -type "float3" -0.00018680152 0.0045893569 -0.00095764897 ;
	setAttr ".tk[195]" -type "float3" -0.00092303718 0.014150584 -0.003436341 ;
	setAttr ".tk[196]" -type "float3" -0.0015500949 0.021820329 -0.0039725159 ;
	setAttr ".tk[197]" -type "float3" -0.0015223003 0.026602805 -0.0017558986 ;
	setAttr ".tk[198]" -type "float3" -0.00079144014 0.021555534 0.0024044928 ;
	setAttr ".tk[199]" -type "float3" 0.00080520095 0.014270658 0.0025361311 ;
	setAttr ".tk[200]" -type "float3" 1.7950399e-05 0.00072994095 1.8767763e-05 ;
	setAttr ".tk[207]" -type "float3" 9.1484899e-06 0.0001650292 -3.0522276e-06 ;
	setAttr ".tk[208]" -type "float3" -0.0015925685 0.012102488 0.0010784137 ;
	setAttr ".tk[209]" -type "float3" -0.004581572 0.023586694 0.0038515432 ;
	setAttr ".tk[210]" -type "float3" 0.00044233221 0.035111893 0.0033611136 ;
	setAttr ".tk[211]" -type "float3" 0.0045267544 0.020145657 0.00031127661 ;
	setAttr ".tk[212]" -type "float3" 0.0017544306 0.006448552 0.00039583334 ;
	setAttr ".tk[213]" -type "float3" 0.00038849449 0.00025440863 0.00029091904 ;
	setAttr ".tk[214]" -type "float3" 0.00025440642 0.0035207211 -0.00012056718 ;
	setAttr ".tk[215]" -type "float3" 3.1247619e-05 0.0098411329 -0.00058802927 ;
	setAttr ".tk[216]" -type "float3" -0.00018985038 0.0092526702 -0.00087203883 ;
	setAttr ".tk[217]" -type "float3" -7.731482e-05 0.0022463275 -0.00072904275 ;
	setAttr ".tk[218]" -type "float3" -0.00035372016 0.003669655 2.1854965e-05 ;
	setAttr ".tk[219]" -type "float3" -0.00080320006 0.011010682 0.00062408688 ;
	setAttr ".tk[220]" -type "float3" -0.00018897015 0.016150862 0.00038534263 ;
	setAttr ".tk[221]" -type "float3" 0.00074466143 0.015864084 -0.00022450782 ;
	setAttr ".tk[222]" -type "float3" -0.0001855648 0.011701636 -0.00016660499 ;
	setAttr ".tk[223]" -type "float3" -0.00088157447 0.023243846 0.00020165101 ;
	setAttr ".tk[224]" -type "float3" 0.00042454849 0.024290096 -0.00020216621 ;
	setAttr ".tk[225]" -type "float3" 0.00083927502 0.019396143 -0.0018016361 ;
	setAttr ".tk[226]" -type "float3" 0.00019110643 0.0076788645 -0.00096653693 ;
	setAttr ".tk[227]" -type "float3" -0.00010686371 0.0010579723 -0.00068782322 ;
	setAttr ".tk[228]" -type "float3" -0.00017867632 0.0026380122 -0.00072579592 ;
	setAttr ".tk[229]" -type "float3" -0.00038783241 0.0081738401 7.9685968e-05 ;
	setAttr ".tk[230]" -type "float3" -0.00042261774 0.011777081 0.0012980516 ;
	setAttr ".tk[231]" -type "float3" 4.5453402e-05 0.0077394978 0.00067807641 ;
	setAttr ".tk[232]" -type "float3" -7.0975053e-05 0.0012514376 -6.5811182e-05 ;
	setAttr ".tk[233]" -type "float3" -1.3939361e-05 3.0095857e-06 -1.4072084e-05 ;
	setAttr ".tk[234]" -type "float3" 3.2209642e-05 -0.0013391725 3.306412e-05 ;
	setAttr ".tk[235]" -type "float3" 0.00044309776 -0.0044914368 0.00040488364 ;
	setAttr ".tk[236]" -type "float3" 0.000715086 -0.003527859 0.0009238153 ;
	setAttr ".tk[237]" -type "float3" 0.00011527729 0.0035265821 -3.2930334e-06 ;
	setAttr ".tk[238]" -type "float3" -0.0024994013 0.012283447 -0.0024951773 ;
	setAttr ".tk[239]" -type "float3" -0.0062173624 0.029760502 -0.0016018046 ;
	setAttr ".tk[240]" -type "float3" 2.661442e-05 0.029704902 0.0018868084 ;
	setAttr ".tk[241]" -type "float3" 0.0016793081 0.014612276 0.00094514497 ;
	setAttr ".tk[242]" -type "float3" 1.015091e-05 0.00023353919 7.1304576e-06 ;
	setAttr ".tk[247]" -type "float3" 1.9180084e-06 1.1822049e-06 -7.9812264e-07 ;
	setAttr ".tk[248]" -type "float3" -4.1291245e-05 0.0010840576 4.90729e-05 ;
	setAttr ".tk[249]" -type "float3" -0.0048603313 0.018158149 0.0032204681 ;
	setAttr ".tk[250]" -type "float3" -0.0056152358 0.039842144 0.0049089519 ;
	setAttr ".tk[251]" -type "float3" 0.0059500365 0.038822647 -0.00063168665 ;
	setAttr ".tk[252]" -type "float3" 0.0034824463 0.014845809 -0.00029730197 ;
	setAttr ".tk[253]" -type "float3" 0.00031106218 0.0003670193 0.00088394637 ;
	setAttr ".tk[254]" -type "float3" 0.00047408388 0.00063300569 0.0007271049 ;
	setAttr ".tk[255]" -type "float3" 0.00067666714 0.0092661697 0.00054804218 ;
	setAttr ".tk[256]" -type "float3" 0.00059260416 0.010053036 6.4791107e-05 ;
	setAttr ".tk[257]" -type "float3" 0.00043889202 0.004908856 -0.00067649159 ;
	setAttr ".tk[258]" -type "float3" -0.00019124748 0.0056406539 -0.00085867895 ;
	setAttr ".tk[259]" -type "float3" -0.00049376138 0.0050459523 -0.00076416158 ;
	setAttr ".tk[260]" -type "float3" -0.00034080568 0.015737146 -0.00035175483 ;
	setAttr ".tk[261]" -type "float3" 0.00089327531 0.018379031 -0.00064883736 ;
	setAttr ".tk[262]" -type "float3" 0.0013295228 0.016742805 -0.0011054794 ;
	setAttr ".tk[263]" -type "float3" -0.0016433074 0.019592168 -0.0011029494 ;
	setAttr ".tk[264]" -type "float3" -0.0011130279 0.02384086 -0.0014271772 ;
	setAttr ".tk[265]" -type "float3" 0.0011985623 0.015867077 -0.0014703979 ;
	setAttr ".tk[266]" -type "float3" 0.00060739915 0.0036839903 -0.00075738539 ;
	setAttr ".tk[267]" -type "float3" 2.2356595e-05 0.0025411458 -0.00040961587 ;
	setAttr ".tk[268]" -type "float3" -0.00080960983 0.015867041 0.0011364516 ;
	setAttr ".tk[269]" -type "float3" -0.00039585435 0.023296336 0.0022678063 ;
	setAttr ".tk[270]" -type "float3" 0.00022570416 0.024105409 0.00063097937 ;
	setAttr ".tk[271]" -type "float3" -0.00014964638 0.022797097 -0.00046834128 ;
	setAttr ".tk[272]" -type "float3" 0.00096818892 0.023215853 -0.00041633871 ;
	setAttr ".tk[273]" -type "float3" 0.0010230596 0.011814096 -0.00051732239 ;
	setAttr ".tk[274]" -type "float3" 0.00023060357 0.0039198692 -0.00039113517 ;
	setAttr ".tk[275]" -type "float3" 2.5892236e-06 -0.00026688003 -9.9899553e-06 ;
	setAttr ".tk[276]" -type "float3" 0.00018495975 -0.0012209314 -0.00014840135 ;
	setAttr ".tk[277]" -type "float3" 0.00022334201 0.0019403864 -0.00027807307 ;
	setAttr ".tk[278]" -type "float3" 0.00017809693 -0.0024525819 -0.00027021306 ;
	setAttr ".tk[279]" -type "float3" 0.00057607121 -0.00099842029 0.0006623746 ;
	setAttr ".tk[280]" -type "float3" -0.0042317989 0.016812926 -0.0032520602 ;
	setAttr ".tk[281]" -type "float3" -0.0028808492 0.03157194 -0.0048871255 ;
	setAttr ".tk[282]" -type "float3" 0.0025720571 0.024530787 -0.00014881568 ;
	setAttr ".tk[283]" -type "float3" 0.00030812609 0.0061149737 0.00018492466 ;
	setAttr ".tk[288]" -type "float3" 1.0971562e-05 7.0891638e-06 -1.1499958e-06 ;
	setAttr ".tk[289]" -type "float3" -0.0005977297 0.0044377977 0.00061090902 ;
	setAttr ".tk[290]" -type "float3" -0.0055318596 0.027061593 0.0042203111 ;
	setAttr ".tk[291]" -type "float3" 0.0013763024 0.044585068 0.00022215093 ;
	setAttr ".tk[292]" -type "float3" 0.0051084924 0.025568239 -0.0025307545 ;
	setAttr ".tk[293]" -type "float3" 0.00024572382 0.0021338973 4.6403529e-05 ;
	setAttr ".tk[294]" -type "float3" 2.980208e-05 1.5242676e-05 0.00010961842 ;
	setAttr ".tk[295]" -type "float3" 0.00010865942 0.0038872836 0.00017284216 ;
	setAttr ".tk[296]" -type "float3" 0.00043151312 0.0099565452 0.00033765874 ;
	setAttr ".tk[297]" -type "float3" 0.0010159939 0.0083712367 0.00026937595 ;
	setAttr ".tk[298]" -type "float3" 0.0011234282 0.0051940121 -0.00015463585 ;
	setAttr ".tk[299]" -type "float3" -0.00050331617 0.0079653095 -0.00023526762 ;
	setAttr ".tk[300]" -type "float3" -0.00054466602 0.010707607 -0.00054255233 ;
	setAttr ".tk[301]" -type "float3" 0.00037952833 0.018114585 -0.00095134845 ;
	setAttr ".tk[302]" -type "float3" 0.0011578689 0.014780756 -0.0014477586 ;
	setAttr ".tk[303]" -type "float3" 0.00051427988 0.016327253 -0.0017189746 ;
	setAttr ".tk[304]" -type "float3" -0.0011149017 0.01169047 -0.00059191679 ;
	setAttr ".tk[305]" -type "float3" -0.00067956245 0.0051522586 0.00052132807 ;
	setAttr ".tk[306]" -type "float3" -0.00027294256 -0.0010675667 0.00081189605 ;
	setAttr ".tk[307]" -type "float3" 0.00028801517 0.0014396439 -4.0726543e-05 ;
	setAttr ".tk[308]" -type "float3" -0.00057285395 0.010768621 0.00021095043 ;
	setAttr ".tk[309]" -type "float3" -0.0012927065 0.023573773 -0.00077628082 ;
	setAttr ".tk[310]" -type "float3" 0.0013098405 0.020650847 -0.0016575345 ;
	setAttr ".tk[311]" -type "float3" 0.001002603 0.011545875 -0.00079278555 ;
	setAttr ".tk[312]" -type "float3" -5.6266381e-05 0.006939068 0.00023102858 ;
	setAttr ".tk[313]" -type "float3" -0.00083144632 0.008316719 -4.4269211e-05 ;
	setAttr ".tk[314]" -type "float3" -0.0013825877 -0.00043675356 0.00025693697 ;
	setAttr ".tk[315]" -type "float3" -0.00033515066 1.6495418e-05 -0.00027768657 ;
	setAttr ".tk[316]" -type "float3" -9.8726978e-06 -0.0026506186 -0.00014891583 ;
	setAttr ".tk[317]" -type "float3" 2.1422262e-05 0.0028280718 -1.3112186e-05 ;
	setAttr ".tk[318]" -type "float3" -0.0010481945 0.014534351 0.0006250419 ;
	setAttr ".tk[319]" -type "float3" 0.00016163103 0.018482076 0.0019227657 ;
	setAttr ".tk[320]" -type "float3" 0.00010840044 0.005864189 7.2790557e-05 ;
	setAttr ".tk[321]" -type "float3" -0.00016242714 0.0016395524 -0.00019058281 ;
	setAttr ".tk[322]" -type "float3" -0.0029130294 0.015829144 -0.003668918 ;
	setAttr ".tk[323]" -type "float3" -0.00089871604 0.029326739 -0.0031748977 ;
	setAttr ".tk[324]" -type "float3" 0.0018029277 0.017935794 0.0001697941 ;
	setAttr ".tk[325]" -type "float3" 0.00010715464 0.0027525348 4.9942228e-05 ;
	setAttr ".tk[329]" -type "float3" -7.4794632e-05 0.00072566059 6.3022744e-05 ;
	setAttr ".tk[330]" -type "float3" -0.0036628107 0.015183525 0.0024995946 ;
	setAttr ".tk[331]" -type "float3" -0.0047121663 0.047260631 0.0024917326 ;
	setAttr ".tk[332]" -type "float3" 0.006577631 0.034237467 -0.0042931242 ;
	setAttr ".tk[333]" -type "float3" 0.00036860531 0.0058246348 -0.0003734192 ;
	setAttr ".tk[334]" -type "float3" -4.5295983e-05 3.0105932e-05 1.5336158e-05 ;
	setAttr ".tk[336]" -type "float3" 6.5534829e-07 0.0070668058 1.2410479e-06 ;
	setAttr ".tk[337]" -type "float3" 7.6537232e-05 0.010479512 3.5150231e-05 ;
	setAttr ".tk[338]" -type "float3" 0.0010087438 0.0063383467 5.3516156e-05 ;
	setAttr ".tk[339]" -type "float3" 0.0010093766 0.0079146028 0.00028719008 ;
	setAttr ".tk[340]" -type "float3" -0.00016585036 0.008470688 0.00017832959 ;
	setAttr ".tk[341]" -type "float3" -0.00032836624 0.0093452865 -0.00010801931 ;
	setAttr ".tk[342]" -type "float3" 0.00045728128 0.010981225 -0.00016015177 ;
	setAttr ".tk[343]" -type "float3" 0.00047455737 0.006515603 -4.4161021e-05 ;
	setAttr ".tk[344]" -type "float3" -0.00030377239 0.0044551869 0.00039139448 ;
	setAttr ".tk[345]" -type "float3" -0.00060235563 0.00085739937 0.00084123824 ;
	setAttr ".tk[346]" -type "float3" -0.00052861392 -0.0018599794 0.00071665813 ;
	setAttr ".tk[347]" -type "float3" 0.0001036024 -0.00048445765 0.00019508427 ;
	setAttr ".tk[348]" -type "float3" 0.00016882273 0.00017316437 0.00028125735 ;
	setAttr ".tk[349]" -type "float3" -0.00020357192 0.0027991605 0.00045360692 ;
	setAttr ".tk[350]" -type "float3" -3.4505647e-06 0.0065058903 0.00032522081 ;
	setAttr ".tk[351]" -type "float3" 0.00084479462 0.0010781048 0.00096820149 ;
	setAttr ".tk[352]" -type "float3" 0.00071191066 -0.0040418599 0.002039009 ;
	setAttr ".tk[353]" -type "float3" -0.00011756889 -0.0031380514 0.0016614955 ;
	setAttr ".tk[354]" -type "float3" -0.00091819291 -0.0026188395 0.0013275492 ;
	setAttr ".tk[355]" -type "float3" -0.00091275584 -0.0030643682 0.00077148684 ;
	setAttr ".tk[356]" -type "float3" -0.00019950037 0.0028401087 0.00048184395 ;
	setAttr ".tk[357]" -type "float3" -4.1540602e-06 0.00017414048 0.00029474069 ;
	setAttr ".tk[358]" -type "float3" 0.00035811038 -0.0034278077 0.00030025627 ;
	setAttr ".tk[359]" -type "float3" -0.0011946964 0.0086270133 -0.00044714342 ;
	setAttr ".tk[360]" -type "float3" -0.0015560063 0.024220433 -0.00055994227 ;
	setAttr ".tk[361]" -type "float3" 0.0010749294 0.01943774 0.00087056303 ;
	setAttr ".tk[362]" -type "float3" 2.4439141e-05 0.002354844 1.6567512e-05 ;
	setAttr ".tk[363]" -type "float3" -0.00018282534 0.0018103039 -0.00017320555 ;
	setAttr ".tk[364]" -type "float3" -0.0019470439 0.015742702 -0.0019871881 ;
	setAttr ".tk[365]" -type "float3" 0.00060336263 0.020234246 -0.00046656976 ;
	setAttr ".tk[366]" -type "float3" 0.00087234785 0.011123317 0.00024400243 ;
	setAttr ".tk[370]" -type "float3" -0.00041714442 0.0021317063 0.00024661442 ;
	setAttr ".tk[371]" -type "float3" -0.0080842059 0.032901973 0.0021268879 ;
	setAttr ".tk[372]" -type "float3" 0.0032211314 0.036050126 -0.0027552231 ;
	setAttr ".tk[373]" -type "float3" 0.00061767182 0.010128745 -0.00033638946 ;
	setAttr ".tk[374]" -type "float3" -0.00047700395 0.00034248436 -4.8869388e-05 ;
	setAttr ".tk[375]" -type "float3" -0.00011047626 7.0766982e-05 -1.8824794e-05 ;
	setAttr ".tk[376]" -type "float3" -4.0868563e-06 1.7917924e-05 4.0401019e-07 ;
	setAttr ".tk[377]" -type "float3" -3.9077742e-05 0.0087988703 7.1269615e-06 ;
	setAttr ".tk[378]" -type "float3" 0.00021405931 0.012017743 1.9819039e-05 ;
	setAttr ".tk[379]" -type "float3" 0.0011308058 0.0080779986 -4.3223696e-05 ;
	setAttr ".tk[380]" -type "float3" 0.00045859275 0.0051266011 0.00010292236 ;
	setAttr ".tk[381]" -type "float3" 0.00022749857 0.0046575442 0.00039091276 ;
	setAttr ".tk[382]" -type "float3" -0.00011012733 0.0048359935 0.00025999494 ;
	setAttr ".tk[383]" -type "float3" 0.0002389148 0.0070148916 0.00016866346 ;
	setAttr ".tk[384]" -type "float3" -0.00015100472 0.0029089467 0.00080331851 ;
	setAttr ".tk[385]" -type "float3" -0.00040954741 0.00098459434 0.00070949894 ;
	setAttr ".tk[386]" -type "float3" -0.00017941729 0.0017315273 0.00023158894 ;
	setAttr ".tk[387]" -type "float3" -1.2662349e-05 0.00073896104 2.3939872e-05 ;
	setAttr ".tk[388]" -type "float3" 4.8507565e-05 2.0701607e-05 5.4171931e-05 ;
	setAttr ".tk[389]" -type "float3" 3.7806181e-05 9.9844001e-06 0.00017050326 ;
	setAttr ".tk[390]" -type "float3" -6.797065e-05 1.4867062e-05 0.00020799489 ;
	setAttr ".tk[391]" -type "float3" 7.0006769e-05 3.2452088e-05 0.00031314784 ;
	setAttr ".tk[392]" -type "float3" 0.00079935475 4.5880042e-05 0.00070130714 ;
	setAttr ".tk[393]" -type "float3" 0.00079834077 -0.0004187845 0.0010822967 ;
	setAttr ".tk[394]" -type "float3" -0.00015660877 0.00017801908 0.0011814614 ;
	setAttr ".tk[395]" -type "float3" -0.00094873802 0.00015103079 0.00094727159 ;
	setAttr ".tk[396]" -type "float3" -0.00072998274 7.5109783e-05 0.00044452865 ;
	setAttr ".tk[397]" -type "float3" -0.00023747479 0.00043572966 8.5915235e-05 ;
	setAttr ".tk[398]" -type "float3" -8.0324457e-07 0.0023530985 0.00014706822 ;
	setAttr ".tk[399]" -type "float3" -1.200605e-05 5.3312564e-05 1.6695602e-05 ;
	setAttr ".tk[400]" -type "float3" -1.495131e-05 0.00015479491 -1.5138096e-05 ;
	setAttr ".tk[401]" -type "float3" -0.0016999135 0.014045773 -0.0013084821 ;
	setAttr ".tk[402]" -type "float3" -0.00047072422 0.019980336 -0.00029163054 ;
	setAttr ".tk[403]" -type "float3" 0.00075063173 0.01505525 0.00058936171 ;
	setAttr ".tk[404]" -type "float3" -1.9837355e-05 0.0011833456 -2.9055192e-05 ;
	setAttr ".tk[405]" -type "float3" -0.0016366468 0.012164211 0.00017214422 ;
	setAttr ".tk[406]" -type "float3" -0.00049414102 0.021001816 0.00039054075 ;
	setAttr ".tk[407]" -type "float3" 0.0010345688 0.011982438 0.00017402128 ;
	setAttr ".tk[411]" -type "float3" -0.00089104852 0.0054048905 0.00031749139 ;
	setAttr ".tk[412]" -type "float3" -0.0032131784 0.031219762 0.00022639925 ;
	setAttr ".tk[413]" -type "float3" 0.0040895459 0.023085505 -0.0010866506 ;
	setAttr ".tk[414]" -type "float3" -0.00017720688 0.0013100749 8.2684521e-05 ;
	setAttr ".tk[415]" -type "float3" -0.00073937891 0.0039983168 0.00014563603 ;
	setAttr ".tk[416]" -type "float3" -0.00023771271 0.0025199307 0.00012842065 ;
	setAttr ".tk[417]" -type "float3" 6.0648854e-06 0.0014390699 9.353811e-05 ;
	setAttr ".tk[418]" -type "float3" -0.00016578697 0.010967099 4.7301022e-05 ;
	setAttr ".tk[419]" -type "float3" 0.00061461399 0.013879396 -0.00011130384 ;
	setAttr ".tk[420]" -type "float3" 0.00093579356 0.0053795874 -0.00023551953 ;
	setAttr ".tk[421]" -type "float3" 8.2958737e-05 0.0045991293 -3.2993325e-05 ;
	setAttr ".tk[422]" -type "float3" -2.3474695e-05 0.0050121755 0.00012309947 ;
	setAttr ".tk[423]" -type "float3" -3.1597199e-05 0.0075776833 0.00015835962 ;
	setAttr ".tk[424]" -type "float3" 3.0139963e-05 0.0072883274 0.00011548814 ;
	setAttr ".tk[425]" -type "float3" -7.0869122e-05 0.0041528866 0.00015349322 ;
	setAttr ".tk[426]" -type "float3" -7.4183583e-05 0.0028230492 8.8472785e-05 ;
	setAttr ".tk[427]" -type "float3" -9.6275096e-07 0.0014461598 2.2521062e-06 ;
	setAttr ".tk[428]" -type "float3" 1.1001444e-08 0.0001955534 1.1612531e-08 ;
	setAttr ".tk[429]" -type "float3" 1.8738079e-06 8.077366e-08 3.5244818e-06 ;
	setAttr ".tk[430]" -type "float3" 1.8185624e-06 3.8320115e-07 1.5326219e-05 ;
	setAttr ".tk[431]" -type "float3" -3.5839487e-06 3.9742019e-07 1.3273385e-05 ;
	setAttr ".tk[432]" -type "float3" 3.1597185e-05 2.9697453e-06 4.839748e-05 ;
	setAttr ".tk[433]" -type "float3" 0.00040067287 2.3566645e-05 0.00046937441 ;
	setAttr ".tk[434]" -type "float3" 0.00061673764 4.9483442e-05 0.0010901125 ;
	setAttr ".tk[435]" -type "float3" 1.2811952e-06 5.196291e-05 0.0010368156 ;
	setAttr ".tk[436]" -type "float3" -0.00069538184 4.049328e-05 0.00051527424 ;
	setAttr ".tk[437]" -type "float3" -0.00078791403 2.0681919e-05 -0.00010579891 ;
	setAttr ".tk[438]" -type "float3" -0.00046967802 4.2448214e-06 -0.00040507247 ;
	setAttr ".tk[439]" -type "float3" -0.00025071405 4.2491962e-08 -0.00033844562 ;
	setAttr ".tk[440]" -type "float3" -0.00011359812 1.1536844e-08 -0.00013006275 ;
	setAttr ".tk[441]" -type "float3" -1.6140273e-05 3.4403853e-09 -1.5690026e-05 ;
	setAttr ".tk[442]" -type "float3" -0.00015096624 0.00130182 -0.00010737354 ;
	setAttr ".tk[443]" -type "float3" -0.0015096954 0.017078588 -0.00092939049 ;
	setAttr ".tk[444]" -type "float3" 9.3201175e-05 0.019979551 -8.6137443e-05 ;
	setAttr ".tk[445]" -type "float3" -0.00018415591 0.0089427456 -0.00019213972 ;
	setAttr ".tk[446]" -type "float3" -0.00038516879 0.0070085041 0.00014927008 ;
	setAttr ".tk[447]" -type "float3" -0.00021595029 0.018186497 0.00018714761 ;
	setAttr ".tk[448]" -type "float3" 0.00041291374 0.0086443303 6.1410508e-05 ;
	setAttr ".tk[452]" -type "float3" -0.0040359111 0.016851164 0.0011642575 ;
	setAttr ".tk[453]" -type "float3" 0.0004221923 0.035031799 0.0011664113 ;
	setAttr ".tk[454]" -type "float3" 0.0026164504 0.01176406 -8.2598854e-05 ;
	setAttr ".tk[455]" -type "float3" -2.635272e-05 0.0019463305 0.00026449055 ;
	setAttr ".tk[456]" -type "float3" -0.0011719654 0.012040621 0.00052604621 ;
	setAttr ".tk[457]" -type "float3" -9.8596764e-05 0.012011875 0.00046082964 ;
	setAttr ".tk[458]" -type "float3" 0.00033784923 0.0062419064 0.0005187912 ;
	setAttr ".tk[459]" -type "float3" -9.5904295e-05 0.013027367 0.00012985467 ;
	setAttr ".tk[460]" -type "float3" 0.00090685039 0.012662333 -0.00040889511 ;
	setAttr ".tk[461]" -type "float3" 0.00058209139 0.0043912483 -0.00018041424 ;
	setAttr ".tk[462]" -type "float3" -3.7068883e-05 0.0050671734 2.8355151e-05 ;
	setAttr ".tk[463]" -type "float3" 1.3864573e-06 0.0088626919 -5.2515329e-06 ;
	setAttr ".tk[464]" -type "float3" 1.7069658e-05 0.0073727095 -2.220888e-05 ;
	setAttr ".tk[465]" -type "float3" 2.0293983e-05 0.005430025 -2.4031904e-05 ;
	setAttr ".tk[466]" -type "float3" 3.4635063e-06 0.0038035524 -3.7346158e-06 ;
	setAttr ".tk[467]" -type "float3" 0 0.0017289725 0 ;
	setAttr ".tk[468]" -type "float3" 0 0.00033371372 0 ;
	setAttr ".tk[473]" -type "float3" 3.3867263e-07 9.8413755e-10 1.8980809e-07 ;
	setAttr ".tk[474]" -type "float3" 9.1000111e-05 7.2182416e-07 8.202243e-05 ;
	setAttr ".tk[475]" -type "float3" 0.00039782459 4.1934568e-06 0.00052547362 ;
	setAttr ".tk[476]" -type "float3" 0.00026705454 5.8433652e-06 0.00074899895 ;
	setAttr ".tk[477]" -type "float3" -0.00018378325 3.5401783e-06 0.0004729426 ;
	setAttr ".tk[478]" -type "float3" -0.00042839005 9.1223649e-07 8.3243889e-05 ;
	setAttr ".tk[479]" -type "float3" -0.00042718841 2.1743627e-08 -0.00020262654 ;
	setAttr ".tk[480]" -type "float3" -0.00047210327 1.7809808e-07 -0.0003706346 ;
	setAttr ".tk[481]" -type "float3" -0.00047685823 3.7234847e-07 -0.00034086112 ;
	setAttr ".tk[482]" -type "float3" -0.00020384601 2.9616663e-07 -0.00013637896 ;
	setAttr ".tk[483]" -type "float3" 5.2668463e-05 2.3771079e-05 -4.1659277e-05 ;
	setAttr ".tk[484]" -type "float3" -0.00043385124 0.006537904 -0.00055236649 ;
	setAttr ".tk[485]" -type "float3" -0.00094583863 0.020628978 -0.00065258448 ;
	setAttr ".tk[486]" -type "float3" 0.00027099595 0.016483974 -0.00059375004 ;
	setAttr ".tk[487]" -type "float3" -0.00016925613 0.0039496762 -0.00024667344 ;
	setAttr ".tk[488]" -type "float3" 0.00024287785 0.012012837 -8.3009763e-05 ;
	setAttr ".tk[489]" -type "float3" 0.00029115367 0.0078101764 -1.984602e-05 ;
	setAttr ".tk[490]" -type "float3" -1.6728674e-08 2.7218399e-09 -1.3203645e-08 ;
	setAttr ".tk[492]" -type "float3" -3.2634489e-05 7.1120128e-05 2.0733755e-06 ;
	setAttr ".tk[493]" -type "float3" -0.0041539683 0.020328633 0.00034844558 ;
	setAttr ".tk[494]" -type "float3" 0.0022656838 0.030267254 9.0810136e-05 ;
	setAttr ".tk[495]" -type "float3" 0.0025263615 0.0086396998 -5.4120101e-06 ;
	setAttr ".tk[496]" -type "float3" -0.00010638438 0.0028868779 0.00029268445 ;
	setAttr ".tk[497]" -type "float3" -0.001599425 0.012021642 0.00038816611 ;
	setAttr ".tk[498]" -type "float3" -0.00037748457 0.014606334 0.00046891533 ;
	setAttr ".tk[499]" -type "float3" 0.0010654075 0.013070057 0.000798336 ;
	setAttr ".tk[500]" -type "float3" 0.00070991745 0.014701688 0.00021777915 ;
	setAttr ".tk[501]" -type "float3" 0.00085363886 0.0088499198 -0.00044348638 ;
	setAttr ".tk[502]" -type "float3" 0.00023454416 0.0038412765 -8.6395208e-05 ;
	setAttr ".tk[503]" -type "float3" -0.00010093342 0.0070226057 -5.0705647e-05 ;
	setAttr ".tk[504]" -type "float3" 1.4408611e-05 0.0076224878 -0.00011216662 ;
	setAttr ".tk[505]" -type "float3" 2.0594462e-05 0.0053448202 -4.7437145e-05 ;
	setAttr ".tk[506]" -type "float3" 3.7992309e-06 0.0035274643 -5.8124447e-06 ;
	setAttr ".tk[507]" -type "float3" 0 0.0015760578 0 ;
	setAttr ".tk[508]" -type "float3" 0 0.00035078597 0 ;
	setAttr ".tk[515]" -type "float3" 8.1738781e-06 -1.4113876e-21 6.3563248e-06 ;
	setAttr ".tk[516]" -type "float3" 0.00011808817 -3.3152691e-20 0.00014930645 ;
	setAttr ".tk[517]" -type "float3" 0.00020026798 -1.1662197e-19 0.00052521867 ;
	setAttr ".tk[518]" -type "float3" 1.2549974e-05 -1.6151543e-19 0.00072740082 ;
	setAttr ".tk[519]" -type "float3" -0.00015090164 2.7957672e-09 0.00071149226 ;
	setAttr ".tk[520]" -type "float3" -0.00012045584 1.3247288e-07 0.00055683323 ;
	setAttr ".tk[521]" -type "float3" -0.00020039348 1.1453504e-06 0.00022659 ;
	setAttr ".tk[522]" -type "float3" -0.00050720054 3.3777978e-06 -0.00014070008 ;
	setAttr ".tk[523]" -type "float3" -0.00055740704 4.3262089e-06 -0.00024917736 ;
	setAttr ".tk[524]" -type "float3" -4.2681284e-05 6.7759873e-05 -0.00023504031 ;
	setAttr ".tk[525]" -type "float3" 0.0004554014 0.0026885229 -0.00066572503 ;
	setAttr ".tk[526]" -type "float3" -0.0018259684 0.020900343 -0.00021682767 ;
	setAttr ".tk[527]" -type "float3" 0.00025457676 0.016931489 0.00010704096 ;
	setAttr ".tk[528]" -type "float3" -0.00051341124 0.0043538846 -0.00051668979 ;
	setAttr ".tk[529]" -type "float3" 0.00024381925 0.011964149 -0.0001291896 ;
	setAttr ".tk[530]" -type "float3" 0.00018917544 0.0080769565 -0.00012576536 ;
	setAttr ".tk[531]" -type "float3" -7.5127123e-06 1.3145739e-06 -4.3900118e-06 ;
	setAttr ".tk[533]" -type "float3" -5.1912364e-05 0.00022256417 1.1977254e-06 ;
	setAttr ".tk[534]" -type "float3" -0.0039379178 0.02106471 0.00010222594 ;
	setAttr ".tk[535]" -type "float3" 0.0031019249 0.028856173 -6.6434819e-05 ;
	setAttr ".tk[536]" -type "float3" 0.0029205601 0.0086746765 7.4635071e-05 ;
	setAttr ".tk[537]" -type "float3" -0.00037821417 0.0040518953 0.00048037627 ;
	setAttr ".tk[538]" -type "float3" -0.0026357502 0.013149727 0.00069071242 ;
	setAttr ".tk[539]" -type "float3" -0.001012494 0.017103676 0.0010527858 ;
	setAttr ".tk[540]" -type "float3" 0.0020090498 0.01850534 0.0013119072 ;
	setAttr ".tk[541]" -type "float3" 0.0018612784 0.014722508 0.00029452317 ;
	setAttr ".tk[542]" -type "float3" 6.3857857e-05 0.0016531574 -3.419002e-05 ;
	setAttr ".tk[543]" -type "float3" -5.1751049e-05 0.0017326386 3.1019004e-05 ;
	setAttr ".tk[544]" -type "float3" -7.6854951e-05 0.0062523889 -0.00026069363 ;
	setAttr ".tk[545]" -type "float3" 1.1238692e-05 0.0044375579 -0.00011642696 ;
	setAttr ".tk[546]" -type "float3" 3.9702149e-06 0.0023491357 -1.1113044e-05 ;
	setAttr ".tk[547]" -type "float3" 0 0.0010076865 0 ;
	setAttr ".tk[548]" -type "float3" 0 0.00019555316 0 ;
	setAttr ".tk[556]" -type "float3" 1.9604341e-08 -4.7807109e-24 2.1530408e-08 ;
	setAttr ".tk[557]" -type "float3" 7.2605321e-06 -2.4107204e-21 1.0856919e-05 ;
	setAttr ".tk[558]" -type "float3" 3.0983778e-05 -2.1492511e-20 9.6793665e-05 ;
	setAttr ".tk[559]" -type "float3" 1.1352735e-05 -5.2845183e-20 0.00023799355 ;
	setAttr ".tk[560]" -type "float3" -9.0209069e-06 2.791998e-09 0.00039549021 ;
	setAttr ".tk[561]" -type "float3" 0.00010753434 2.6223387e-07 0.00061297446 ;
	setAttr ".tk[562]" -type "float3" 0.00021121422 9.082022e-05 0.00066530978 ;
	setAttr ".tk[563]" -type "float3" -9.7662072e-05 0.00018617493 0.00028502039 ;
	setAttr ".tk[564]" -type "float3" -0.00054576766 0.00016704507 -0.00016647269 ;
	setAttr ".tk[565]" -type "float3" -0.00025129056 0.00022101015 -0.00069732469 ;
	setAttr ".tk[566]" -type "float3" 0.00050530786 0.0011088955 -0.0013020041 ;
	setAttr ".tk[567]" -type "float3" -0.0017176572 0.016088594 -0.0001649975 ;
	setAttr ".tk[568]" -type "float3" -0.00029338681 0.02115719 0.0007832296 ;
	setAttr ".tk[569]" -type "float3" -0.00056132273 0.0097132344 -0.00025897368 ;
	setAttr ".tk[570]" -type "float3" 0.00067689433 0.011576197 7.6343247e-05 ;
	setAttr ".tk[571]" -type "float3" -8.6751701e-05 0.0095397551 -0.00018585002 ;
	setAttr ".tk[572]" -type "float3" -5.8404497e-05 0.00051049236 -1.655628e-05 ;
	setAttr ".tk[573]" -type "float3" -2.7113592e-07 3.5262516e-08 -6.813837e-08 ;
	setAttr ".tk[574]" -type "float3" -8.861583e-05 0.00040676096 2.3388252e-06 ;
	setAttr ".tk[575]" -type "float3" -0.0037598473 0.021452857 7.1026523e-05 ;
	setAttr ".tk[576]" -type "float3" 0.0037734753 0.028875448 -8.1895741e-05 ;
	setAttr ".tk[577]" -type "float3" 0.0030353365 0.009023834 0.00015660306 ;
	setAttr ".tk[578]" -type "float3" -0.00065698137 0.0049686898 0.00034340841 ;
	setAttr ".tk[579]" -type "float3" -0.0044112182 0.016420225 6.3712003e-05 ;
	setAttr ".tk[580]" -type "float3" -0.0036170366 0.025498264 0.0009388178 ;
	setAttr ".tk[581]" -type "float3" 0.0030048585 0.023329597 0.0013049331 ;
	setAttr ".tk[582]" -type "float3" 0.0015894772 0.010054941 0.00025949287 ;
	setAttr ".tk[583]" -type "float3" -5.6853241e-05 0.00018603941 2.5556101e-05 ;
	setAttr ".tk[584]" -type "float3" -5.2167296e-05 0.0042916606 -0.00015134814 ;
	setAttr ".tk[585]" -type "float3" -2.1467175e-05 0.0028442892 -0.00012274498 ;
	setAttr ".tk[586]" -type "float3" 2.0359651e-06 0.0009219505 -2.3957929e-05 ;
	setAttr ".tk[587]" -type "float3" 0 0.00031718676 0 ;
	setAttr ".tk[588]" -type "float3" 0 3.6092319e-05 0 ;
	setAttr ".tk[599]" -type "float3" 1.5177994e-07 -1.2457452e-22 5.6103374e-07 ;
	setAttr ".tk[600]" -type "float3" 2.6889677e-07 -8.6481804e-22 3.8947942e-06 ;
	setAttr ".tk[601]" -type "float3" 2.0214395e-06 2.1257114e-10 1.6107631e-05 ;
	setAttr ".tk[602]" -type "float3" 6.7740082e-05 0.00016121042 0.00012697781 ;
	setAttr ".tk[603]" -type "float3" 0.00032511353 0.00078036619 0.00048202966 ;
	setAttr ".tk[604]" -type "float3" 0.00033329549 0.0014869841 0.00056332292 ;
	setAttr ".tk[605]" -type "float3" -6.2962528e-05 0.0012274674 9.4043513e-05 ;
	setAttr ".tk[606]" -type "float3" -0.0001135942 0.00080485753 -0.00070149405 ;
	setAttr ".tk[607]" -type "float3" -0.00013958878 0.0050558508 -0.00092377886 ;
	setAttr ".tk[608]" -type "float3" -0.0011078269 0.016613124 0.00034445382 ;
	setAttr ".tk[609]" -type "float3" 2.3995344e-05 0.02113764 0.00057203142 ;
	setAttr ".tk[610]" -type "float3" -3.6905272e-05 0.012789278 -6.0396145e-05 ;
	setAttr ".tk[611]" -type "float3" 0.00081163406 0.0090516228 0.00021530078 ;
	setAttr ".tk[612]" -type "float3" -0.00027541243 0.0099827005 6.8798479e-05 ;
	setAttr ".tk[613]" -type "float3" -0.00011706026 0.0039008199 5.9947297e-06 ;
	setAttr ".tk[614]" -type "float3" -1.0326385e-06 1.2342871e-07 9.1757428e-09 ;
	setAttr ".tk[615]" -type "float3" -7.4729563e-05 0.00037073938 2.9421788e-06 ;
	setAttr ".tk[616]" -type "float3" -0.0036666638 0.022323428 0.00012907069 ;
	setAttr ".tk[617]" -type "float3" 0.0043049804 0.029251693 1.2560798e-05 ;
	setAttr ".tk[618]" -type "float3" 0.0028836462 0.0089680143 0.00029344345 ;
	setAttr ".tk[619]" -type "float3" -0.00068102125 0.0046869754 0.00029793207 ;
	setAttr ".tk[620]" -type "float3" -0.0036647331 0.010356922 -0.00029259647 ;
	setAttr ".tk[621]" -type "float3" -0.0047648596 0.026225142 -0.00091296504 ;
	setAttr ".tk[622]" -type "float3" 0.0036286647 0.027620437 -0.00042481927 ;
	setAttr ".tk[623]" -type "float3" 0.00086197047 0.0056123487 2.5620795e-06 ;
	setAttr ".tk[624]" -type "float3" -0.00011611897 -7.4767078e-05 5.0451526e-05 ;
	setAttr ".tk[625]" -type "float3" -5.1866184e-05 0.0039557512 -3.19219e-05 ;
	setAttr ".tk[626]" -type "float3" -1.488551e-06 0.0012459616 -1.0465441e-05 ;
	setAttr ".tk[627]" -type "float3" 6.9108175e-08 8.9662237e-05 -7.9112431e-07 ;
	setAttr ".tk[642]" -type "float3" 0 3.6021549e-05 0 ;
	setAttr ".tk[643]" -type "float3" 3.7550806e-06 0.00078783819 3.2440403e-06 ;
	setAttr ".tk[644]" -type "float3" 0.00013321554 0.0025947173 0.00014099311 ;
	setAttr ".tk[645]" -type "float3" 0.00043245338 0.0039320639 0.0005145676 ;
	setAttr ".tk[646]" -type "float3" 0.00030851277 0.0034936301 0.00046636775 ;
	setAttr ".tk[647]" -type "float3" -0.00021400953 0.0025911548 1.9571202e-05 ;
	setAttr ".tk[648]" -type "float3" -0.0017981986 0.015746212 0.00054326566 ;
	setAttr ".tk[649]" -type "float3" -0.00066596142 0.017838353 0.00038014413 ;
	setAttr ".tk[650]" -type "float3" -9.0342823e-05 0.011511927 0.00042815192 ;
	setAttr ".tk[651]" -type "float3" 5.6782861e-05 0.010772415 0.00047909276 ;
	setAttr ".tk[652]" -type "float3" -3.3350811e-05 0.0043450589 0.000584864 ;
	setAttr ".tk[653]" -type "float3" -0.00013821272 0.0099488962 0.00030330897 ;
	setAttr ".tk[654]" -type "float3" -9.1084257e-05 0.0083118724 3.3876277e-05 ;
	setAttr ".tk[655]" -type "float3" -5.1659612e-07 5.2245035e-08 1.1205773e-07 ;
	setAttr ".tk[656]" -type "float3" -0.00011866636 0.00039603608 3.8088901e-06 ;
	setAttr ".tk[657]" -type "float3" -0.0037397973 0.023559736 0.00015295715 ;
	setAttr ".tk[658]" -type "float3" 0.0045828074 0.029525211 0.00019287709 ;
	setAttr ".tk[659]" -type "float3" 0.00065588026 0.0043450356 0.00047324065 ;
	setAttr ".tk[660]" -type "float3" -0.00055158202 0.0043721627 0.00055817695 ;
	setAttr ".tk[661]" -type "float3" -0.0028767381 0.0081800008 -0.00015493658 ;
	setAttr ".tk[662]" -type "float3" -0.0038712565 0.024909647 -0.0027141331 ;
	setAttr ".tk[663]" -type "float3" 0.0014270948 0.019476321 -0.0020488207 ;
	setAttr ".tk[664]" -type "float3" -0.00059065397 0.00010850655 0.00020877 ;
	setAttr ".tk[665]" -type "float3" -0.00024526095 0.0024351396 -5.0882241e-05 ;
	setAttr ".tk[666]" -type "float3" -0.00013484976 0.0067777638 -5.4157776e-05 ;
	setAttr ".tk[667]" -type "float3" 0.00011091875 0.0029109349 -3.4432756e-05 ;
	setAttr ".tk[683]" -type "float3" 0 0.00012519414 0 ;
	setAttr ".tk[684]" -type "float3" 4.0093791e-09 0.0016120226 -2.310153e-09 ;
	setAttr ".tk[685]" -type "float3" 3.2350574e-05 0.0040328945 1.3925397e-06 ;
	setAttr ".tk[686]" -type "float3" 0.00029977443 0.0046267533 4.7597889e-05 ;
	setAttr ".tk[687]" -type "float3" -7.0589478e-05 0.0045407484 0.00045431333 ;
	setAttr ".tk[688]" -type "float3" -0.0014829402 0.0086207138 0.00095874845 ;
	setAttr ".tk[689]" -type "float3" -0.0021200669 0.023415668 0.00086066796 ;
	setAttr ".tk[690]" -type "float3" 0.00082970405 0.020244163 -0.00038882883 ;
	setAttr ".tk[691]" -type "float3" -0.00014611194 0.0077872812 0.00057133095 ;
	setAttr ".tk[692]" -type "float3" -5.047696e-05 0.010011958 0.00064472872 ;
	setAttr ".tk[693]" -type "float3" -0.00018321643 -1.9002007e-05 0.00067152997 ;
	setAttr ".tk[694]" -type "float3" 3.044207e-05 0.0098885428 0.00011832581 ;
	setAttr ".tk[695]" -type "float3" -4.1460748e-07 0.0095872683 1.5506514e-05 ;
	setAttr ".tk[696]" -type "float3" -5.8587113e-09 0.00027220897 2.8565561e-09 ;
	setAttr ".tk[697]" -type "float3" -0.00016657937 0.00041839894 6.1064247e-06 ;
	setAttr ".tk[698]" -type "float3" -0.0038091431 0.024286903 0.00028738883 ;
	setAttr ".tk[699]" -type "float3" 0.0039985571 0.027253384 0.00026563052 ;
	setAttr ".tk[700]" -type "float3" 0.00070951466 0.0048495075 0.00043514872 ;
	setAttr ".tk[701]" -type "float3" -0.00045916854 0.0024143581 0.00029799592 ;
	setAttr ".tk[702]" -type "float3" -0.0022037572 0.0095797321 -0.00051628955 ;
	setAttr ".tk[703]" -type "float3" -0.001932453 0.019176329 -0.0031245896 ;
	setAttr ".tk[704]" -type "float3" -0.00028936786 0.0082465196 -0.00043351669 ;
	setAttr ".tk[705]" -type "float3" -0.00041841945 -0.001268817 0.00021999881 ;
	setAttr ".tk[706]" -type "float3" -0.00044086654 0.0046672411 0.00022487232 ;
	setAttr ".tk[707]" -type "float3" 4.0989398e-05 0.0067077721 3.465189e-05 ;
	setAttr ".tk[708]" -type "float3" 9.4457107e-05 0.0028245414 -2.346144e-05 ;
	setAttr ".tk[724]" -type "float3" 0 0.00029970534 0 ;
	setAttr ".tk[725]" -type "float3" 3.3153842e-06 0.0023013216 -2.1027445e-06 ;
	setAttr ".tk[726]" -type "float3" 0.00011878006 0.0044104364 -0.00010243494 ;
	setAttr ".tk[727]" -type "float3" 0.00026764895 0.004732511 -0.00034548857 ;
	setAttr ".tk[728]" -type "float3" -0.00088415598 0.0052587767 0.0001058762 ;
	setAttr ".tk[729]" -type "float3" -0.0032381411 0.019215355 0.0013541288 ;
	setAttr ".tk[730]" -type "float3" 0.00032876187 0.023508783 5.5256187e-05 ;
	setAttr ".tk[731]" -type "float3" 0.00079292478 0.01064459 -0.00022158113 ;
	setAttr ".tk[732]" -type "float3" -0.00028173465 0.0018770929 0.0004435039 ;
	setAttr ".tk[733]" -type "float3" -0.00035115343 0.0014970045 0.00055433443 ;
	setAttr ".tk[734]" -type "float3" 0.00011356921 -0.0018099752 1.125835e-05 ;
	setAttr ".tk[735]" -type "float3" -0.0002032544 0.011117871 -7.372383e-05 ;
	setAttr ".tk[736]" -type "float3" 0.00012464078 0.010244356 4.7562594e-09 ;
	setAttr ".tk[737]" -type "float3" 3.7382095e-05 0.00045012415 -3.6023085e-08 ;
	setAttr ".tk[738]" -type "float3" -0.0002859472 0.00060514 1.5591144e-05 ;
	setAttr ".tk[739]" -type "float3" -0.0041499948 0.025925327 0.00052253425 ;
	setAttr ".tk[740]" -type "float3" 0.0040871454 0.026451912 0.00032004243 ;
	setAttr ".tk[741]" -type "float3" 0.0017304862 0.0066813505 0.00027366649 ;
	setAttr ".tk[742]" -type "float3" -0.00047431252 0.0043570362 7.6834389e-05 ;
	setAttr ".tk[743]" -type "float3" -0.0010971325 0.0090469122 -0.0006001392 ;
	setAttr ".tk[744]" -type "float3" -0.00043941833 0.0088323187 -0.00098833407 ;
	setAttr ".tk[745]" -type "float3" -0.00097424607 -0.0031937901 0.0007424574 ;
	setAttr ".tk[746]" -type "float3" -0.00027755907 0.0037780807 6.9574657e-05 ;
	setAttr ".tk[747]" -type "float3" -5.9584101e-05 0.0079778899 0.00017133572 ;
	setAttr ".tk[748]" -type "float3" 0.00019092407 0.005756604 -4.4960256e-05 ;
	setAttr ".tk[749]" -type "float3" 2.7627934e-06 0.000215097 -1.2844811e-06 ;
	setAttr ".tk[765]" -type "float3" 8.2577865e-09 0.00041780228 -3.0127008e-09 ;
	setAttr ".tk[766]" -type "float3" 3.2549746e-05 0.0027289607 -1.8045006e-05 ;
	setAttr ".tk[767]" -type "float3" 0.00029883735 0.0045495015 -0.00023323954 ;
	setAttr ".tk[768]" -type "float3" 0.00011521053 0.0050272224 -0.00039966538 ;
	setAttr ".tk[769]" -type "float3" -0.0019410084 0.0094526233 0.00011919336 ;
	setAttr ".tk[770]" -type "float3" -0.0026011008 0.02451285 0.00032346713 ;
	setAttr ".tk[771]" -type "float3" 0.0020674709 0.020511772 -0.00052958488 ;
	setAttr ".tk[772]" -type "float3" 0.0003702039 0.003497177 0.00032465547 ;
	setAttr ".tk[773]" -type "float3" -0.00037790713 0.0012925745 0.00043464437 ;
	setAttr ".tk[774]" -type "float3" -0.00022236457 -0.00053739542 6.2791019e-05 ;
	setAttr ".tk[775]" -type "float3" -0.0003840329 0.003255053 0.00010063861 ;
	setAttr ".tk[776]" -type "float3" -0.00044667535 0.013590994 0.00014832275 ;
	setAttr ".tk[777]" -type "float3" 0.00031811072 0.011167751 -3.5467532e-05 ;
	setAttr ".tk[778]" -type "float3" 0.00011187301 0.00059247686 -7.8720941e-06 ;
	setAttr ".tk[779]" -type "float3" -0.00056706771 0.00099801843 3.9187871e-05 ;
	setAttr ".tk[780]" -type "float3" -0.0045628091 0.028078306 0.000549666 ;
	setAttr ".tk[781]" -type "float3" 0.0048957421 0.02698889 0.00029303474 ;
	setAttr ".tk[782]" -type "float3" 0.0016579729 0.0055460646 9.906145e-05 ;
	setAttr ".tk[783]" -type "float3" -0.0006358159 0.0048599066 6.6677079e-05 ;
	setAttr ".tk[784]" -type "float3" -0.00045407566 0.0088353269 -0.00011422632 ;
	setAttr ".tk[785]" -type "float3" -0.00065090711 0.00066171109 7.1932873e-06 ;
	setAttr ".tk[786]" -type "float3" -0.00042372712 -0.0030378497 4.7768492e-05 ;
	setAttr ".tk[787]" -type "float3" -9.0198388e-05 0.0051249969 1.1143145e-06 ;
	setAttr ".tk[788]" -type "float3" 0.0001156729 0.0051045716 -0.0002655772 ;
	setAttr ".tk[789]" -type "float3" 0.00031453292 0.0052228966 -0.00039869495 ;
	setAttr ".tk[806]" -type "float3" 8.7158998e-07 0.00069467898 -2.3850055e-07 ;
	setAttr ".tk[807]" -type "float3" 0.00010334034 0.0032250227 -4.099718e-05 ;
	setAttr ".tk[808]" -type "float3" 0.00051351811 0.0046967948 -0.00034730657 ;
	setAttr ".tk[809]" -type "float3" -8.0120284e-05 0.0064548962 -0.00046914502 ;
	setAttr ".tk[810]" -type "float3" -0.0032703415 0.015583493 7.9318095e-05 ;
	setAttr ".tk[811]" -type "float3" -0.0015868815 0.029814133 -0.00100371 ;
	setAttr ".tk[812]" -type "float3" 0.002234116 0.015855264 -0.00033356436 ;
	setAttr ".tk[813]" -type "float3" 0.00056265999 0.0029772981 0.00055896823 ;
	setAttr ".tk[814]" -type "float3" -0.0002606253 -0.0001013462 0.00036820266 ;
	setAttr ".tk[815]" -type "float3" -0.00032347062 0.0035110358 0.0001573655 ;
	setAttr ".tk[816]" -type "float3" -0.00067460909 0.014007038 0.00025763089 ;
	setAttr ".tk[817]" -type "float3" 6.8175104e-05 0.014251209 -0.00020663762 ;
	setAttr ".tk[818]" -type "float3" 0.00036799489 0.009534603 -0.00022913431 ;
	setAttr ".tk[819]" -type "float3" 0.00010077492 0.00045087317 -3.7453705e-05 ;
	setAttr ".tk[820]" -type "float3" -0.0023056876 0.0046177944 0.0003091392 ;
	setAttr ".tk[821]" -type "float3" -0.0040931581 0.029877812 0.00046137688 ;
	setAttr ".tk[822]" -type "float3" 0.0052697374 0.025507811 -0.00028947863 ;
	setAttr ".tk[823]" -type "float3" 0.0013092405 0.0041502928 9.6087033e-06 ;
	setAttr ".tk[824]" -type "float3" -0.00091694033 0.0047583408 0.00023057508 ;
	setAttr ".tk[825]" -type "float3" -0.00081831781 0.0088001834 0.00086968194 ;
	setAttr ".tk[826]" -type "float3" -0.00046068698 0.0021467833 9.1190406e-05 ;
	setAttr ".tk[827]" -type "float3" -0.00018830653 -8.5827982e-05 4.4041783e-05 ;
	setAttr ".tk[828]" -type "float3" 6.0538791e-06 0.0016576455 6.0538641e-06 ;
	setAttr ".tk[829]" -type "float3" 5.753171e-05 0.0020980157 -9.5296826e-05 ;
	setAttr ".tk[830]" -type "float3" 7.7629622e-05 0.0038727615 -0.00010302998 ;
	setAttr ".tk[846]" -type "float3" 0 1.8046159e-05 4.0070523e-21 ;
	setAttr ".tk[847]" -type "float3" 3.1233776e-06 0.0011481593 -3.8169347e-07 ;
	setAttr ".tk[848]" -type "float3" 0.00017755985 0.0037493652 -3.0451098e-05 ;
	setAttr ".tk[849]" -type "float3" 0.00074609893 0.0051492662 -0.00024573071 ;
	setAttr ".tk[850]" -type "float3" -0.00011970984 0.0070989737 -0.00029882725 ;
	setAttr ".tk[851]" -type "float3" -0.0050135045 0.023919359 -0.00068642758 ;
	setAttr ".tk[852]" -type "float3" 0.00091120711 0.032096494 -0.0028606586 ;
	setAttr ".tk[853]" -type "float3" 0.0026991381 0.014056655 -0.0011285016 ;
	setAttr ".tk[854]" -type "float3" 0.00029968558 0.003456769 3.2433323e-05 ;
	setAttr ".tk[855]" -type "float3" -0.00010665509 0.00022660216 -2.316443e-05 ;
	setAttr ".tk[856]" -type "float3" -0.00033071413 0.0044312971 -7.8837955e-05 ;
	setAttr ".tk[857]" -type "float3" -0.00029083519 0.012390849 -0.00059154344 ;
	setAttr ".tk[858]" -type "float3" 0.00028855595 0.0091301557 -0.00060824788 ;
	setAttr ".tk[859]" -type "float3" 0.00015003167 0.0020952446 -0.00017342879 ;
	setAttr ".tk[860]" -type "float3" 1.6964048e-05 0.00019554397 -1.4445606e-05 ;
	setAttr ".tk[861]" -type "float3" -0.0038765192 0.013066703 0.0005683272 ;
	setAttr ".tk[862]" -type "float3" -0.0016902173 0.031410422 -0.00066309416 ;
	setAttr ".tk[863]" -type "float3" 0.0040453323 0.018164121 -0.00082069216 ;
	setAttr ".tk[864]" -type "float3" 0.0010635761 0.0037090802 1.4439836e-05 ;
	setAttr ".tk[865]" -type "float3" -0.0015473205 0.0066000754 0.00061605411 ;
	setAttr ".tk[866]" -type "float3" -0.00129924 0.014010514 0.0016326641 ;
	setAttr ".tk[867]" -type "float3" -0.00040979372 0.0090951063 0.00024543409 ;
	setAttr ".tk[868]" -type "float3" -0.0001983226 0.00031824579 5.1226885e-05 ;
	setAttr ".tk[869]" -type "float3" 2.284839e-06 0.00019582026 1.1773923e-06 ;
	setAttr ".tk[870]" -type "float3" 3.1530334e-14 1.8046137e-05 2.8307552e-08 ;
	setAttr ".tk[871]" -type "float3" 7.5900608e-08 1.734694e-05 -2.7096332e-08 ;
	setAttr ".tk[887]" -type "float3" 0 0.00012526408 0 ;
	setAttr ".tk[888]" -type "float3" 3.5620922e-06 0.0018287498 1.9238067e-07 ;
	setAttr ".tk[889]" -type "float3" 0.00012306868 0.0042368486 2.3980434e-05 ;
	setAttr ".tk[890]" -type "float3" 0.00057843921 0.0057671168 0.00015700664 ;
	setAttr ".tk[891]" -type "float3" -0.00045832919 0.0079174303 0.00049848028 ;
	setAttr ".tk[892]" -type "float3" -0.0024244038 0.023273602 -0.00036535281 ;
	setAttr ".tk[893]" -type "float3" 0.0019413495 0.021918925 -0.0017650833 ;
	setAttr ".tk[894]" -type "float3" 0.00052954355 0.006162547 -0.00072553841 ;
	setAttr ".tk[895]" -type "float3" -9.6264986e-05 0.0060795802 -0.00079220865 ;
	setAttr ".tk[896]" -type "float3" -0.00036455315 0.003676058 -0.00042903807 ;
	setAttr ".tk[897]" -type "float3" -0.00024548575 0.00083134434 -4.6990368e-05 ;
	setAttr ".tk[898]" -type "float3" 0.00013933897 0.0034688942 -1.4602438e-05 ;
	setAttr ".tk[899]" -type "float3" 0.00010370183 0.0015315471 -0.00010903445 ;
	setAttr ".tk[900]" -type "float3" 1.1055829e-05 0.0003867629 -1.3698687e-05 ;
	setAttr ".tk[902]" -type "float3" -0.0020074847 0.014904706 -0.0014556721 ;
	setAttr ".tk[903]" -type "float3" 0.00082123675 0.026333148 -0.003317313 ;
	setAttr ".tk[904]" -type "float3" 0.0018227821 0.0065335282 -0.00018043473 ;
	setAttr ".tk[905]" -type "float3" 0.00062721327 0.0038596769 8.7885834e-05 ;
	setAttr ".tk[906]" -type "float3" -0.0024032197 0.012752598 0.00072540756 ;
	setAttr ".tk[907]" -type "float3" -0.00069105916 0.019912483 0.0017162993 ;
	setAttr ".tk[908]" -type "float3" -0.00026690899 0.0084197698 0.00039591448 ;
	setAttr ".tk[909]" -type "float3" -0.00077134743 -0.0016122162 2.7903912e-05 ;
	setAttr ".tk[910]" -type "float3" -0.00030433279 0.0042775087 0.00013134893 ;
	setAttr ".tk[911]" -type "float3" -2.9648237e-07 0.00031734712 1.4535995e-05 ;
	setAttr ".tk[928]" -type "float3" 0 0.00041813595 0 ;
	setAttr ".tk[929]" -type "float3" 6.7308997e-07 0.0026500928 2.8557469e-07 ;
	setAttr ".tk[930]" -type "float3" -2.3616602e-05 0.0044711675 3.6817299e-05 ;
	setAttr ".tk[931]" -type "float3" 8.2748644e-05 0.0062629292 0.00022070677 ;
	setAttr ".tk[932]" -type "float3" -0.0010435276 0.010743066 0.0005509762 ;
	setAttr ".tk[933]" -type "float3" -0.00035456262 0.023989536 -1.1875672e-06 ;
	setAttr ".tk[934]" -type "float3" 0.0020547083 0.016603405 -0.00029663843 ;
	setAttr ".tk[935]" -type "float3" 0.0003785787 0.0024505083 -6.2872889e-05 ;
	setAttr ".tk[936]" -type "float3" -0.00061537704 0.0048416075 -0.00030296206 ;
	setAttr ".tk[937]" -type "float3" -0.0010638825 0.0080907084 0.00012350499 ;
	setAttr ".tk[938]" -type "float3" -0.000131885 0.013931533 0.00028858916 ;
	setAttr ".tk[939]" -type "float3" 0.00018791732 0.0067826277 0.00017054923 ;
	setAttr ".tk[940]" -type "float3" 1.4900312e-05 0.00017946769 1.0837006e-05 ;
	setAttr ".tk[943]" -type "float3" -7.706105e-05 0.0024403911 -0.00019514316 ;
	setAttr ".tk[944]" -type "float3" 0.00035052476 0.0064012287 -0.00071239867 ;
	setAttr ".tk[945]" -type "float3" 0.00089039345 0.00043509889 0.00036125001 ;
	setAttr ".tk[946]" -type "float3" 9.2493668e-05 0.0053304378 9.7066404e-05 ;
	setAttr ".tk[947]" -type "float3" -0.0021213207 0.0150574 -6.6297136e-05 ;
	setAttr ".tk[948]" -type "float3" -0.00013165802 0.022859572 0.00040791009 ;
	setAttr ".tk[949]" -type "float3" 0.00025651886 0.0096157696 0.00026170487 ;
	setAttr ".tk[950]" -type "float3" -0.00095085759 -0.0031181825 -3.8899369e-05 ;
	setAttr ".tk[951]" -type "float3" -0.00074127445 0.0057443534 0.00041362186 ;
	setAttr ".tk[952]" -type "float3" -1.3376662e-05 0.0087929042 0.00014668523 ;
	setAttr ".tk[953]" -type "float3" 0 0.0018322601 0 ;
	setAttr ".tk[969]" -type "float3" 0 0.00083683612 0 ;
	setAttr ".tk[970]" -type "float3" -2.6456925e-07 0.0033732536 3.9269976e-13 ;
	setAttr ".tk[971]" -type "float3" -9.1965267e-05 0.0045716628 -2.2724227e-05 ;
	setAttr ".tk[972]" -type "float3" -0.00017340218 0.006166331 -8.5287371e-05 ;
	setAttr ".tk[973]" -type "float3" -0.00092481199 0.007548945 -0.00020357057 ;
	setAttr ".tk[974]" -type "float3" 0.000243064 0.017311741 -0.0012384536 ;
	setAttr ".tk[975]" -type "float3" 0.0015979204 0.010418165 -0.00046124621 ;
	setAttr ".tk[976]" -type "float3" 0.0003478298 0.0012046285 0.00044575662 ;
	setAttr ".tk[977]" -type "float3" -0.00030933836 0.0024291116 0.00010441586 ;
	setAttr ".tk[978]" -type "float3" -0.0028250983 0.018430613 -1.1732112e-05 ;
	setAttr ".tk[979]" -type "float3" -0.0012860498 0.020955287 -0.0002127162 ;
	setAttr ".tk[980]" -type "float3" 0.0010990701 0.017326621 -0.00012084174 ;
	setAttr ".tk[981]" -type "float3" 0.00019261675 0.0024457281 -7.6687298e-05 ;
	setAttr ".tk[982]" -type "float3" -1.9893982e-06 1.0039727e-06 -1.8476406e-06 ;
	setAttr ".tk[984]" -type "float3" -1.197778e-05 0.00041638708 -2.9468882e-05 ;
	setAttr ".tk[985]" -type "float3" 7.2274059e-05 0.0027535341 -0.00014801703 ;
	setAttr ".tk[986]" -type "float3" 0.00074574072 4.6561385e-05 0.00025275419 ;
	setAttr ".tk[987]" -type "float3" 0.00068337785 0.0022521943 0.00027322967 ;
	setAttr ".tk[988]" -type "float3" -0.0017415988 0.012775573 -0.0001947697 ;
	setAttr ".tk[989]" -type "float3" -0.00048220489 0.022124339 -0.00039098848 ;
	setAttr ".tk[990]" -type "float3" 0.00099116203 0.012250268 -0.00012108912 ;
	setAttr ".tk[991]" -type "float3" -0.00023951173 7.3690928e-05 -3.4330184e-05 ;
	setAttr ".tk[992]" -type "float3" -0.00093987194 0.0078898575 0.00020713943 ;
	setAttr ".tk[993]" -type "float3" 1.4313299e-05 0.012723952 9.5179268e-05 ;
	setAttr ".tk[994]" -type "float3" 0 0.0050152913 0 ;
	setAttr ".tk[1009]" -type "float3" 0 7.1831346e-05 0 ;
	setAttr ".tk[1010]" -type "float3" 0 0.0014099139 0 ;
	setAttr ".tk[1011]" -type "float3" -1.5479209e-07 0.0039471937 -1.5479172e-07 ;
	setAttr ".tk[1012]" -type "float3" -4.3115215e-05 0.0045918012 -3.5460187e-05 ;
	setAttr ".tk[1013]" -type "float3" -0.00010092654 0.0047662216 -0.00012835453 ;
	setAttr ".tk[1014]" -type "float3" -0.0007164962 0.0044989237 -0.00019255152 ;
	setAttr ".tk[1015]" -type "float3" 0.00025292378 0.010470408 -0.00046019893 ;
	setAttr ".tk[1016]" -type "float3" 0.00081092282 0.0096874014 0.00023241586 ;
	setAttr ".tk[1017]" -type "float3" 0.00020429796 0.0010151798 0.00032673695 ;
	setAttr ".tk[1018]" -type "float3" 0.0002791539 0.0012782481 -0.000255583 ;
	setAttr ".tk[1019]" -type "float3" -0.0014732314 0.018673083 -0.00090098917 ;
	setAttr ".tk[1020]" -type "float3" -0.0022424746 0.026591755 -0.0020079408 ;
	setAttr ".tk[1021]" -type "float3" 0.0018493468 0.029597998 -0.0015340832 ;
	setAttr ".tk[1022]" -type "float3" 0.0013327175 0.01627643 -0.0010945378 ;
	setAttr ".tk[1023]" -type "float3" -8.085258e-05 0.00085420592 -9.3956973e-05 ;
	setAttr ".tk[1024]" -type "float3" -3.8592219e-07 1.6586279e-07 -2.4063883e-07 ;
	setAttr ".tk[1025]" -type "float3" 0 0.00058136065 0 ;
	setAttr ".tk[1026]" -type "float3" -3.4767985e-05 0.0029384412 5.4730717e-05 ;
	setAttr ".tk[1027]" -type "float3" 0.00046398136 0.0024556774 0.00032665589 ;
	setAttr ".tk[1028]" -type "float3" 0.00060661428 0.0028933552 0.00038940742 ;
	setAttr ".tk[1029]" -type "float3" -0.0021675304 0.015507638 0.00074291584 ;
	setAttr ".tk[1030]" -type "float3" -0.00057563535 0.021811521 6.1091399e-05 ;
	setAttr ".tk[1031]" -type "float3" 0.00026172795 0.0093655819 -7.7050419e-05 ;
	setAttr ".tk[1032]" -type "float3" -0.00011476642 -0.00084149197 -1.0267246e-05 ;
	setAttr ".tk[1033]" -type "float3" -0.0010182525 0.0098650251 0.00017842572 ;
	setAttr ".tk[1034]" -type "float3" 0.00022580143 0.012250286 -8.9646412e-05 ;
	setAttr ".tk[1035]" -type "float3" -0.0007247043 0.00084825221 0.00012599044 ;
	setAttr ".tk[1036]" -type "float3" -1.3787071e-05 -0.0001784175 3.0529052e-06 ;
	setAttr ".tk[1050]" -type "float3" 0 0.00046669409 0 ;
	setAttr ".tk[1051]" -type "float3" 0 0.0025031725 0 ;
	setAttr ".tk[1052]" -type "float3" 0 0.00437498 0 ;
	setAttr ".tk[1053]" -type "float3" -4.0644595e-06 0.0046015261 -4.0644718e-06 ;
	setAttr ".tk[1054]" -type "float3" -2.642097e-05 0.0045463457 -2.1973035e-05 ;
	setAttr ".tk[1055]" -type "float3" -0.0005381325 0.0033114422 -4.886249e-05 ;
	setAttr ".tk[1056]" -type "float3" -0.00017539451 0.0096330848 0.00041715734 ;
	setAttr ".tk[1057]" -type "float3" 0.00012848061 0.0095457556 0.0015103627 ;
	setAttr ".tk[1058]" -type "float3" 0.0003844655 0.002559881 4.2569151e-05 ;
	setAttr ".tk[1059]" -type "float3" 0.00041587386 0.009068978 -0.0007435712 ;
	setAttr ".tk[1060]" -type "float3" 0.0012209213 0.012965401 -0.0012670539 ;
	setAttr ".tk[1061]" -type "float3" -0.00065745006 0.022531623 -0.0028813176 ;
	setAttr ".tk[1062]" -type "float3" -0.00034525362 0.030288244 -0.0047345366 ;
	setAttr ".tk[1063]" -type "float3" 0.0011216626 0.023934089 -0.0025110892 ;
	setAttr ".tk[1064]" -type "float3" -0.00088904705 0.0051748152 -0.00082095474 ;
	setAttr ".tk[1065]" -type "float3" -5.4512944e-05 2.2530929e-05 -3.416726e-05 ;
	setAttr ".tk[1066]" -type "float3" 0 0.00085462932 0 ;
	setAttr ".tk[1067]" -type "float3" -0.00018934385 0.0031898497 9.5831994e-05 ;
	setAttr ".tk[1068]" -type "float3" -0.00035844359 0.0079020495 0.00071617414 ;
	setAttr ".tk[1069]" -type "float3" -0.0030272845 0.014206204 0.0019800595 ;
	setAttr ".tk[1070]" -type "float3" -0.0030800155 0.023505015 0.0016601565 ;
	setAttr ".tk[1071]" -type "float3" 2.4107063e-05 0.021415185 0.00030883888 ;
	setAttr ".tk[1072]" -type "float3" -0.0003695515 0.0046514147 9.9266406e-05 ;
	setAttr ".tk[1073]" -type "float3" -0.00016948434 0.0015699867 1.0263127e-05 ;
	setAttr ".tk[1074]" -type "float3" -0.00078802515 0.013186004 0.00016642358 ;
	setAttr ".tk[1075]" -type "float3" -5.6361445e-05 0.0088148275 -2.5869824e-05 ;
	setAttr ".tk[1076]" -type "float3" -0.00085892936 -0.0029347723 0.00022418673 ;
	setAttr ".tk[1077]" -type "float3" -3.3065477e-05 -0.00085110415 1.8366454e-05 ;
	setAttr ".tk[1090]" -type "float3" 0 0.0001079231 0 ;
	setAttr ".tk[1091]" -type "float3" 0 0.0012032934 0 ;
	setAttr ".tk[1092]" -type "float3" 2.8543651e-08 0.0036738547 -7.0744171e-08 ;
	setAttr ".tk[1093]" -type "float3" 2.5826137e-07 0.0045649097 -1.4667432e-06 ;
	setAttr ".tk[1094]" -type "float3" -2.2782507e-07 0.0046014963 -3.2683411e-06 ;
	setAttr ".tk[1095]" -type "float3" -8.8812712e-06 0.0043869517 -4.881942e-06 ;
	setAttr ".tk[1096]" -type "float3" -7.9720747e-05 -0.0011820067 9.2592156e-05 ;
	setAttr ".tk[1097]" -type "float3" -3.5115459e-05 0.0037167431 0.0011074668 ;
	setAttr ".tk[1098]" -type "float3" 0.00037706643 0.013538515 0.0015328602 ;
	setAttr ".tk[1099]" -type "float3" 0.00093589147 0.0098742759 -0.00047757788 ;
	setAttr ".tk[1100]" -type "float3" 1.7856713e-05 0.011322804 -0.00062844442 ;
	setAttr ".tk[1101]" -type "float3" 0.0006521988 0.012870595 -0.00011565215 ;
	setAttr ".tk[1102]" -type "float3" 0.0010004522 0.011109287 -0.00047997516 ;
	setAttr ".tk[1103]" -type "float3" -0.001952659 0.024002362 -0.0030762611 ;
	setAttr ".tk[1104]" -type "float3" 0.00016033117 0.028878495 -0.002380261 ;
	setAttr ".tk[1105]" -type "float3" -0.0011040329 0.010634573 -0.0010145978 ;
	setAttr ".tk[1106]" -type "float3" -0.00040103093 0.00017624855 -0.0001838858 ;
	setAttr ".tk[1107]" -type "float3" -8.3967525e-06 0.00100123 8.3967589e-06 ;
	setAttr ".tk[1108]" -type "float3" -0.00040193548 0.0032954435 0.00013213546 ;
	setAttr ".tk[1109]" -type "float3" -0.0017579682 0.010506283 0.0012394515 ;
	setAttr ".tk[1110]" -type "float3" -0.0041996874 0.018494451 0.0031963484 ;
	setAttr ".tk[1111]" -type "float3" -0.0013424431 0.026025716 0.0012816408 ;
	setAttr ".tk[1112]" -type "float3" 0.00058257993 0.018879117 -9.3470029e-05 ;
	setAttr ".tk[1113]" -type "float3" -0.00047001833 0.0010762204 6.4297266e-05 ;
	setAttr ".tk[1114]" -type "float3" -1.4825583e-05 0.00024107812 -7.2081151e-05 ;
	setAttr ".tk[1115]" -type "float3" -0.00023673456 0.011337413 -0.00065737497 ;
	setAttr ".tk[1116]" -type "float3" -0.00062542706 0.00441156 0.00048187686 ;
	setAttr ".tk[1117]" -type "float3" -0.00062055298 -0.0042474219 0.0002510573 ;
	setAttr ".tk[1118]" -type "float3" -1.5968094e-06 -0.00015991363 1.1303946e-06 ;
	setAttr ".tk[1131]" -type "float3" 0 0.00025031084 0 ;
	setAttr ".tk[1132]" -type "float3" 3.065637e-06 0.0020252001 -6.8312634e-06 ;
	setAttr ".tk[1133]" -type "float3" 1.4997535e-05 0.0043328702 -5.5988054e-05 ;
	setAttr ".tk[1134]" -type "float3" 1.1608982e-05 0.0046039112 -0.00015248569 ;
	setAttr ".tk[1135]" -type "float3" -1.0761098e-05 0.0045798076 -0.00024880495 ;
	setAttr ".tk[1136]" -type "float3" -0.00011448839 0.0030207944 -0.00026388574 ;
	setAttr ".tk[1137]" -type "float3" 0.0003564861 -0.0032131702 -0.00025719922 ;
	setAttr ".tk[1138]" -type "float3" 0.00012170368 0.0092836507 5.5924025e-05 ;
	setAttr ".tk[1139]" -type "float3" 0.0018915446 0.012700206 -0.00029645755 ;
	setAttr ".tk[1140]" -type "float3" 0.0013624807 0.0090838876 -0.00041146917 ;
	setAttr ".tk[1141]" -type "float3" -0.00054945465 0.0059808302 0.00070202444 ;
	setAttr ".tk[1142]" -type "float3" -0.00077273068 0.0032987671 0.001430291 ;
	setAttr ".tk[1143]" -type "float3" 0.0017354796 0.0033061653 0.0017983775 ;
	setAttr ".tk[1144]" -type "float3" -0.0016331089 0.019547382 -1.7088199e-05 ;
	setAttr ".tk[1145]" -type "float3" -0.00054473802 0.029303873 -0.0009545834 ;
	setAttr ".tk[1146]" -type "float3" -0.00026663212 0.014804056 -0.00091453956 ;
	setAttr ".tk[1147]" -type "float3" -0.00096821337 0.00045259722 -0.0002648925 ;
	setAttr ".tk[1148]" -type "float3" -2.4089497e-05 0.00068741135 1.2555527e-05 ;
	setAttr ".tk[1149]" -type "float3" -0.00052999449 0.0034181601 0.00016999093 ;
	setAttr ".tk[1150]" -type "float3" -0.0041243145 0.012984797 0.0016852121 ;
	setAttr ".tk[1151]" -type "float3" -0.005712701 0.033383418 0.0035126312 ;
	setAttr ".tk[1152]" -type "float3" 0.0019961311 0.02499599 0.00032249794 ;
	setAttr ".tk[1153]" -type "float3" 0.00027116784 0.0088758059 -0.00012235854 ;
	setAttr ".tk[1154]" -type "float3" -0.00045429761 0.00028405781 -6.750349e-05 ;
	setAttr ".tk[1155]" -type "float3" 8.9049732e-05 -0.0019430862 -0.00040707944 ;
	setAttr ".tk[1156]" -type "float3" 0.00032282685 -0.0038307679 -7.4719836e-05 ;
	setAttr ".tk[1157]" -type "float3" -0.00032139555 -0.0030020557 0.00010982177 ;
	setAttr ".tk[1158]" -type "float3" -5.6339923e-05 -0.00013078013 -0.00011130607 ;
	setAttr ".tk[1159]" -type "float3" -1.0532565e-05 1.1196464e-06 -1.1653977e-05 ;
	setAttr ".tk[1160]" -type "float3" -1.3644166e-07 7.8766851e-09 -9.0388184e-08 ;
	setAttr ".tk[1171]" -type "float3" 1.1302944e-07 3.0057045e-08 -1.2211551e-07 ;
	setAttr ".tk[1172]" -type "float3" 1.5129805e-05 0.00031011604 -2.2786524e-05 ;
	setAttr ".tk[1173]" -type "float3" 8.309634e-05 0.0019943502 -0.00019772015 ;
	setAttr ".tk[1174]" -type "float3" 0.00019318322 0.0042951601 -0.00057405268 ;
	setAttr ".tk[1175]" -type "float3" 0.00027247518 0.0046017794 -0.0011105142 ;
	setAttr ".tk[1176]" -type "float3" 0.00012480511 0.0040756296 -0.0015715727 ;
	setAttr ".tk[1177]" -type "float3" -0.00038171138 -0.0019546398 -0.0016092323 ;
	setAttr ".tk[1178]" -type "float3" 0.00054424396 -0.0024446032 -0.0017359229 ;
	setAttr ".tk[1179]" -type "float3" -0.0011227934 0.01888912 -0.00088615814 ;
	setAttr ".tk[1180]" -type "float3" 0.0030595255 0.017163783 -0.00072608178 ;
	setAttr ".tk[1181]" -type "float3" 0.00070555077 -0.0014852519 0.00045841746 ;
	setAttr ".tk[1182]" -type "float3" -0.00068156997 -0.001117133 0.0014092189 ;
	setAttr ".tk[1183]" -type "float3" -0.001639328 -5.0758503e-05 0.001704485 ;
	setAttr ".tk[1184]" -type "float3" 0.0025023238 9.8225944e-05 0.0016603214 ;
	setAttr ".tk[1185]" -type "float3" -0.00014684675 0.017839111 0.0010666327 ;
	setAttr ".tk[1186]" -type "float3" 0.00066762965 0.029311625 -0.00015114827 ;
	setAttr ".tk[1187]" -type "float3" 4.6793815e-05 0.014465007 -0.000724543 ;
	setAttr ".tk[1188]" -type "float3" -0.0011764894 0.00057457399 -7.5532043e-05 ;
	setAttr ".tk[1189]" -type "float3" -1.144002e-05 0.0001981759 8.7277311e-07 ;
	setAttr ".tk[1190]" -type "float3" -0.00042428498 0.0028784303 9.4119263e-05 ;
	setAttr ".tk[1191]" -type "float3" -0.0060048001 0.018175812 0.00055835483 ;
	setAttr ".tk[1192]" -type "float3" -0.0025926509 0.038350843 -0.0015343454 ;
	setAttr ".tk[1193]" -type "float3" 0.0054751206 0.023745591 -0.0016042748 ;
	setAttr ".tk[1194]" -type "float3" -0.00011630435 0.001379188 0.00012606363 ;
	setAttr ".tk[1195]" -type "float3" -0.00037296981 0.00019281112 -0.00010751394 ;
	setAttr ".tk[1196]" -type "float3" 0.00049244292 6.6699955e-05 -0.00072881323 ;
	setAttr ".tk[1197]" -type "float3" 0.00040402956 -0.00027689961 -0.0014107974 ;
	setAttr ".tk[1198]" -type "float3" -0.00021778164 0.001656235 -0.0013190592 ;
	setAttr ".tk[1199]" -type "float3" -0.00036805787 0.00086161052 -0.00062570121 ;
	setAttr ".tk[1200]" -type "float3" -0.00013437474 1.9344603e-05 -9.5745738e-05 ;
	setAttr ".tk[1201]" -type "float3" -4.0250402e-06 2.8226648e-07 -1.3976662e-06 ;
	setAttr ".tk[1211]" -type "float3" 4.5609212e-08 1.7772111e-08 -4.5449124e-08 ;
	setAttr ".tk[1212]" -type "float3" 2.9168721e-05 1.2441756e-05 -3.0722596e-05 ;
	setAttr ".tk[1213]" -type "float3" 0.00027234945 0.00029722444 -0.00039196503 ;
	setAttr ".tk[1214]" -type "float3" 0.00061913766 0.0014722937 -0.0011410534 ;
	setAttr ".tk[1215]" -type "float3" 0.00070782145 0.0055844784 -0.0015160661 ;
	setAttr ".tk[1216]" -type "float3" 0.00075082306 0.005160444 -0.0017870774 ;
	setAttr ".tk[1217]" -type "float3" 0.00036086075 0.0020361668 -0.002232661 ;
	setAttr ".tk[1218]" -type "float3" -0.00010045653 -0.0032524511 -0.0023794398 ;
	setAttr ".tk[1219]" -type "float3" -0.00062842958 0.0023963128 -0.0022941509 ;
	setAttr ".tk[1220]" -type "float3" -0.0027738127 0.022405375 -0.0017855833 ;
	setAttr ".tk[1221]" -type "float3" 0.0025012337 0.017204929 -0.00037485184 ;
	setAttr ".tk[1222]" -type "float3" -0.00034427099 -0.002849641 0.00047958863 ;
	setAttr ".tk[1223]" -type "float3" -0.0012518237 -0.00047172693 0.00089810288 ;
	setAttr ".tk[1224]" -type "float3" -0.0015619883 0.00071477052 0.00023419125 ;
	setAttr ".tk[1225]" -type "float3" 0.001221589 0.0039816448 0.0001666171 ;
	setAttr ".tk[1226]" -type "float3" -0.00028281769 0.024274189 0.0010062876 ;
	setAttr ".tk[1227]" -type "float3" 0.0024753071 0.028696084 -0.00024086362 ;
	setAttr ".tk[1228]" -type "float3" 0.00054145063 0.012006942 -0.00034280258 ;
	setAttr ".tk[1229]" -type "float3" -0.00090138993 0.00084968674 7.6738477e-05 ;
	setAttr ".tk[1230]" -type "float3" -8.0332546e-07 1.802553e-05 -3.1433041e-07 ;
	setAttr ".tk[1231]" -type "float3" -0.00018927583 0.0014265727 7.8674639e-06 ;
	setAttr ".tk[1232]" -type "float3" -0.0054838313 0.021687778 -0.0016061219 ;
	setAttr ".tk[1233]" -type "float3" 0.0011822397 0.029087415 -0.003836409 ;
	setAttr ".tk[1234]" -type "float3" 0.0034148092 0.010228514 -0.0011391153 ;
	setAttr ".tk[1235]" -type "float3" 0.00016362536 0.0014961655 -0.00010570233 ;
	setAttr ".tk[1236]" -type "float3" -0.0002874276 -0.00050055765 4.1597406e-05 ;
	setAttr ".tk[1237]" -type "float3" 0.0011187097 0.00035493079 -0.000741033 ;
	setAttr ".tk[1238]" -type "float3" 0.0011494313 0.0024743096 -0.001901977 ;
	setAttr ".tk[1239]" -type "float3" -0.00024055512 0.0054385453 -0.0022416068 ;
	setAttr ".tk[1240]" -type "float3" -0.0010547638 0.0034170782 -0.0012058918 ;
	setAttr ".tk[1241]" -type "float3" -0.00061842229 0.0018457513 -0.00026626099 ;
	setAttr ".tk[1242]" -type "float3" -2.4746054e-05 0.00019074805 -4.195927e-06 ;
	setAttr ".tk[1252]" -type "float3" 2.114923e-05 4.6361969e-05 -1.6704435e-05 ;
	setAttr ".tk[1253]" -type "float3" 0.00037254975 0.00062605133 -0.00036394229 ;
	setAttr ".tk[1254]" -type "float3" 0.00090745726 0.0018845737 -0.0011787602 ;
	setAttr ".tk[1255]" -type "float3" 0.00063156709 0.0084016882 -0.0013606495 ;
	setAttr ".tk[1256]" -type "float3" 0.00053151906 0.012063638 -0.00051289075 ;
	setAttr ".tk[1257]" -type "float3" 0.00092636491 0.01007928 -0.00057896134 ;
	setAttr ".tk[1258]" -type "float3" 0.00012117838 0.0010672833 -0.0010299626 ;
	setAttr ".tk[1259]" -type "float3" 0.00024647094 -0.0033773433 -0.0010860579 ;
	setAttr ".tk[1260]" -type "float3" -0.0016803691 0.0063734832 -0.0014370111 ;
	setAttr ".tk[1261]" -type "float3" -0.0070996867 0.034463726 -0.00045147969 ;
	setAttr ".tk[1262]" -type "float3" 0.0022199654 0.021678928 -9.410151e-05 ;
	setAttr ".tk[1263]" -type "float3" -0.00079978944 -0.0010894011 0.00026742206 ;
	setAttr ".tk[1264]" -type "float3" -0.0014272885 0.0013296294 -0.00017931496 ;
	setAttr ".tk[1265]" -type "float3" -0.0020248794 0.0068674129 0.00024103183 ;
	setAttr ".tk[1266]" -type "float3" -0.00092999922 0.020401906 0.0012488512 ;
	setAttr ".tk[1267]" -type "float3" 0.00061391643 0.029769547 0.00025749288 ;
	setAttr ".tk[1268]" -type "float3" 0.0029367104 0.023643028 -0.00093396206 ;
	setAttr ".tk[1269]" -type "float3" -0.00092464034 0.0041956357 0.00042406286 ;
	setAttr ".tk[1270]" -type "float3" -0.00045238601 0.00025853058 0.0001367946 ;
	setAttr ".tk[1272]" -type "float3" -9.6542844e-06 7.7834535e-05 -2.4730957e-07 ;
	setAttr ".tk[1273]" -type "float3" -0.0014764193 0.012664129 -0.0011236271 ;
	setAttr ".tk[1274]" -type "float3" 0.00091076014 0.014614762 -0.0011745688 ;
	setAttr ".tk[1275]" -type "float3" 0.00034979504 0.00075522298 0.00046328548 ;
	setAttr ".tk[1276]" -type "float3" -3.6744641e-05 5.7049474e-05 0.00044782876 ;
	setAttr ".tk[1277]" -type "float3" -9.6465323e-05 -0.00046542066 0.00011976851 ;
	setAttr ".tk[1278]" -type "float3" 0.0020637708 0.0013414071 -0.0011124571 ;
	setAttr ".tk[1279]" -type "float3" 0.002899236 0.000264128 -0.0027079582 ;
	setAttr ".tk[1280]" -type "float3" -0.00029220793 0.010316124 -0.0028538099 ;
	setAttr ".tk[1281]" -type "float3" -0.0021879487 0.0082398718 -0.0016950966 ;
	setAttr ".tk[1282]" -type "float3" -0.0014630319 0.0022409321 -0.00034842611 ;
	setAttr ".tk[1283]" -type "float3" -9.4896321e-05 0.0017249939 -9.0590265e-06 ;
	setAttr ".tk[1287]" -type "float3" -3.2948912e-05 0.0027096092 8.0148602e-05 ;
	setAttr ".tk[1288]" -type "float3" 1.0535145e-05 0.0048382678 0.00014656331 ;
	setAttr ".tk[1289]" -type "float3" 0 0.00018823531 0 ;
	setAttr ".tk[1292]" -type "float3" -3.5771654e-06 0.00016127584 6.2426816e-06 ;
	setAttr ".tk[1293]" -type "float3" 0.00018962093 0.0011512975 -6.2524094e-05 ;
	setAttr ".tk[1294]" -type "float3" 0.00096241041 0.0050869901 -0.00060379534 ;
	setAttr ".tk[1295]" -type "float3" 0.00018918917 0.012534403 -0.00031871343 ;
	setAttr ".tk[1296]" -type "float3" -0.0024950861 0.020052189 0.0015347897 ;
	setAttr ".tk[1297]" -type "float3" -0.00036920569 0.022908157 0.0014984772 ;
	setAttr ".tk[1298]" -type "float3" 0.00068671908 0.011387409 0.0012920464 ;
	setAttr ".tk[1299]" -type "float3" -0.00060089974 -0.0016228902 0.0013292072 ;
	setAttr ".tk[1300]" -type "float3" 0.00079692702 -0.0032252031 0.0012475088 ;
	setAttr ".tk[1301]" -type "float3" -0.0026445994 0.010371482 -6.1480845e-05 ;
	setAttr ".tk[1302]" -type "float3" -0.0068969135 0.034390196 -0.0031718572 ;
	setAttr ".tk[1303]" -type "float3" 0.0020384633 0.024241352 -0.00092934468 ;
	setAttr ".tk[1304]" -type "float3" -0.00030058186 0.00053323526 0.00025170401 ;
	setAttr ".tk[1305]" -type "float3" -0.002331564 0.011313871 0.002027397 ;
	setAttr ".tk[1306]" -type "float3" -0.0015669328 0.019730505 0.003918245 ;
	setAttr ".tk[1307]" -type "float3" 0.0011526081 0.025069144 0.0012169559 ;
	setAttr ".tk[1308]" -type "float3" 0.0023141217 0.02611056 -0.0013472792 ;
	setAttr ".tk[1309]" -type "float3" -0.00013186444 0.005780655 0.00064898725 ;
	setAttr ".tk[1310]" -type "float3" -0.00073405227 0.0005117738 0.00052274845 ;
	setAttr ".tk[1311]" -type "float3" -8.501218e-05 3.8787286e-05 4.273896e-05 ;
	setAttr ".tk[1314]" -type "float3" 0.00017253535 0.004927461 3.0058278e-05 ;
	setAttr ".tk[1315]" -type "float3" -0.00014635532 0.005525745 0.00013717264 ;
	setAttr ".tk[1316]" -type "float3" -0.00047683244 -0.0010820805 0.00032538373 ;
	setAttr ".tk[1317]" -type "float3" 0.00030896507 -0.00097811443 0.0005962851 ;
	setAttr ".tk[1318]" -type "float3" 0.00045747613 -0.00012435942 4.0204923e-05 ;
	setAttr ".tk[1319]" -type "float3" 0.0034874964 -0.0020946234 -0.0016794384 ;
	setAttr ".tk[1320]" -type "float3" 0.0033953609 0.0032367343 -0.0025083665 ;
	setAttr ".tk[1321]" -type "float3" -0.00078236917 0.010343363 -0.0019146386 ;
	setAttr ".tk[1322]" -type "float3" -0.0032556755 0.0070687518 -0.0010567992 ;
	setAttr ".tk[1323]" -type "float3" -0.0024037694 0.0024125094 -0.00021903723 ;
	setAttr ".tk[1324]" -type "float3" -0.00025526175 0.0012458835 -3.3696931e-05 ;
	setAttr ".tk[1325]" -type "float3" 1.9042605e-05 0.00056291535 -2.8444956e-06 ;
	setAttr ".tk[1326]" -type "float3" -1.4296004e-05 0.0014490179 9.9090494e-06 ;
	setAttr ".tk[1327]" -type "float3" -3.4705328e-05 0.0013744436 2.2567863e-05 ;
	setAttr ".tk[1328]" -type "float3" -1.6706092e-05 0.003027343 6.9445523e-05 ;
	setAttr ".tk[1329]" -type "float3" -0.00013152859 0.0065779486 0.0004349816 ;
	setAttr ".tk[1330]" -type "float3" -3.4850218e-05 0.0043600947 0.00038875887 ;
	setAttr ".tk[1331]" -type "float3" 3.9241422e-06 0.00055587082 2.7597391e-05 ;
	setAttr ".tk[1332]" -type "float3" -8.7070669e-07 0.00015820723 2.8309743e-05 ;
	setAttr ".tk[1333]" -type "float3" -4.4764773e-05 0.0021326009 0.00024305037 ;
	setAttr ".tk[1334]" -type "float3" 0.00075027859 0.010882728 0.00037925001 ;
	setAttr ".tk[1335]" -type "float3" 0.00054488366 0.015397884 0.00079950877 ;
	setAttr ".tk[1336]" -type "float3" -0.003387593 0.024858382 0.0041673752 ;
	setAttr ".tk[1337]" -type "float3" -0.0041777627 0.03534136 0.0041744988 ;
	setAttr ".tk[1338]" -type "float3" 0.00095465389 0.025773145 0.0008804205 ;
	setAttr ".tk[1339]" -type "float3" -0.00043885477 0.0073370081 0.0017030642 ;
	setAttr ".tk[1340]" -type "float3" -0.00072816381 -0.0035856457 0.0022506781 ;
	setAttr ".tk[1341]" -type "float3" 0.0014330085 -0.0011993018 0.0017854273 ;
	setAttr ".tk[1342]" -type "float3" -0.0010159315 0.008689818 9.5035117e-05 ;
	setAttr ".tk[1343]" -type "float3" -0.0036182487 0.027594205 -0.00497144 ;
	setAttr ".tk[1344]" -type "float3" 2.99846e-05 0.016133234 -0.0016279927 ;
	setAttr ".tk[1345]" -type "float3" -0.00027582186 0.0085539492 0.0010100203 ;
	setAttr ".tk[1346]" -type "float3" -0.0075946376 0.032263771 0.0076073315 ;
	setAttr ".tk[1347]" -type "float3" 0.0030677575 0.035766687 0.0043006279 ;
	setAttr ".tk[1348]" -type "float3" 0.001517341 0.014701217 0.00028540142 ;
	setAttr ".tk[1349]" -type "float3" -0.00015290792 0.0049801362 0.00056473352 ;
	setAttr ".tk[1350]" -type "float3" -0.00034796575 0.00033859687 0.00047776257 ;
	setAttr ".tk[1351]" -type "float3" -0.00010972223 6.4234227e-05 9.6965312e-05 ;
	setAttr ".tk[1352]" -type "float3" -2.4155477e-06 1.0135328e-06 1.6197921e-06 ;
	setAttr ".tk[1355]" -type "float3" 0.00035686721 0.001335707 0.00018197746 ;
	setAttr ".tk[1356]" -type "float3" -2.6290736e-05 0.005452516 0.00050116132 ;
	setAttr ".tk[1357]" -type "float3" -0.00060915662 -0.00042989603 0.00047168959 ;
	setAttr ".tk[1358]" -type "float3" 0.00035302393 -0.00089557108 0.00055851595 ;
	setAttr ".tk[1359]" -type "float3" 0.00140789 -0.0013179415 2.9528534e-05 ;
	setAttr ".tk[1360]" -type "float3" 0.0036535561 0.00010351869 -0.0014187765 ;
	setAttr ".tk[1361]" -type "float3" 0.0017782038 0.010124685 -0.0010292998 ;
	setAttr ".tk[1362]" -type "float3" -0.0012924564 0.01207773 0.0001919342 ;
	setAttr ".tk[1363]" -type "float3" -0.0036318828 0.0050952765 0.00058532803 ;
	setAttr ".tk[1364]" -type "float3" -0.0025588616 0.0024427169 0.00035658688 ;
	setAttr ".tk[1365]" -type "float3" -0.00036602284 -0.0031448021 5.5962559e-05 ;
	setAttr ".tk[1366]" -type "float3" 5.3257518e-05 0.0005631019 -2.7204991e-05 ;
	setAttr ".tk[1367]" -type "float3" -4.9083381e-05 0.0019991719 1.5868962e-05 ;
	setAttr ".tk[1368]" -type "float3" -7.9601756e-05 0.0033663404 3.1718413e-05 ;
	setAttr ".tk[1369]" -type "float3" -3.0810344e-05 0.0039987429 1.6141803e-05 ;
	setAttr ".tk[1370]" -type "float3" -0.00028863654 0.0066745649 0.00037070629 ;
	setAttr ".tk[1371]" -type "float3" -0.00021454353 0.014432845 0.0013306323 ;
	setAttr ".tk[1372]" -type "float3" -0.00031654831 0.011508284 0.00090776896 ;
	setAttr ".tk[1373]" -type "float3" -6.7383931e-05 0.0079179322 0.00054710422 ;
	setAttr ".tk[1374]" -type "float3" 5.7423713e-05 0.014755952 0.00087746535 ;
	setAttr ".tk[1375]" -type "float3" 0.00070773705 0.016877878 0.0007993289 ;
	setAttr ".tk[1376]" -type "float3" -0.0016798317 0.024835542 0.0027995838 ;
	setAttr ".tk[1377]" -type "float3" -0.0044024568 0.041268811 0.0045923376 ;
	setAttr ".tk[1378]" -type "float3" 0.00093404489 0.039426632 -0.00021734653 ;
	setAttr ".tk[1379]" -type "float3" 0.0012086866 0.016445832 0.00016791093 ;
	setAttr ".tk[1380]" -type "float3" -0.00019502675 0.0037246996 0.00069092726 ;
	setAttr ".tk[1381]" -type "float3" 4.3113687e-05 0.00048649797 0.0011540541 ;
	setAttr ".tk[1382]" -type "float3" 0.0022043779 0.0027557812 0.00094624545 ;
	setAttr ".tk[1383]" -type "float3" 0.00040887404 0.0093249809 0.00066537986 ;
	setAttr ".tk[1384]" -type "float3" -0.0016567269 0.017381681 -0.0015789568 ;
	setAttr ".tk[1385]" -type "float3" -0.0012695423 0.010570842 -7.840414e-05 ;
	setAttr ".tk[1386]" -type "float3" -0.0067359204 0.019213172 0.0015899057 ;
	setAttr ".tk[1387]" -type "float3" -0.006797432 0.040339068 0.0022919183 ;
	setAttr ".tk[1388]" -type "float3" 0.0029210248 0.025673324 -5.9417034e-05 ;
	setAttr ".tk[1389]" -type "float3" 0.00014551499 0.0045033847 0.00016982909 ;
	setAttr ".tk[1390]" -type "float3" -5.0109647e-05 5.9316899e-05 0.00011769961 ;
	setAttr ".tk[1391]" -type "float3" -2.6518839e-05 1.9934627e-05 4.2129872e-05 ;
	setAttr ".tk[1392]" -type "float3" -1.5829999e-06 8.5375558e-07 1.8942117e-06 ;
	setAttr ".tk[1396]" -type "float3" -4.8217012e-06 0.00042762735 4.8217025e-06 ;
	setAttr ".tk[1397]" -type "float3" 5.1346044e-05 -0.00050368079 0.00050682668 ;
	setAttr ".tk[1398]" -type "float3" -0.00037125131 -0.0022537438 5.4024691e-05 ;
	setAttr ".tk[1399]" -type "float3" 0.00029424482 -0.002303757 -0.00017054801 ;
	setAttr ".tk[1400]" -type "float3" 0.002455872 -0.0028663292 -0.00091154466 ;
	setAttr ".tk[1401]" -type "float3" 0.0015424502 0.0076762871 -0.00020429205 ;
	setAttr ".tk[1402]" -type "float3" -0.00057143462 0.02032516 0.0014042839 ;
	setAttr ".tk[1403]" -type "float3" -0.0017019144 0.012576361 0.0020788619 ;
	setAttr ".tk[1404]" -type "float3" -0.0031752163 0.0034744474 0.0018221944 ;
	setAttr ".tk[1405]" -type "float3" -0.0016683496 0.0020050628 0.00071393361 ;
	setAttr ".tk[1406]" -type "float3" -0.00016562339 -0.0042204545 0.00018817633 ;
	setAttr ".tk[1407]" -type "float3" 0.0001057313 -0.0014370043 7.445817e-05 ;
	setAttr ".tk[1408]" -type "float3" -6.5816341e-05 0.0020066632 1.049657e-06 ;
	setAttr ".tk[1409]" -type "float3" -7.9646154e-05 0.0038739864 2.0204752e-06 ;
	setAttr ".tk[1410]" -type "float3" -2.9490588e-05 0.0041249353 1.0793708e-05 ;
	setAttr ".tk[1411]" -type "float3" -0.00068232761 0.011547211 0.00085997488 ;
	setAttr ".tk[1412]" -type "float3" 0.00010761975 0.01926351 0.001522175 ;
	setAttr ".tk[1413]" -type "float3" -2.1729769e-05 0.014892325 0.00015666368 ;
	setAttr ".tk[1414]" -type "float3" 0.00017567056 0.013117799 -0.00027957896 ;
	setAttr ".tk[1415]" -type "float3" 0.00056163652 0.016466912 -0.00078236562 ;
	setAttr ".tk[1416]" -type "float3" 0.00096225098 0.018258873 -0.0016888297 ;
	setAttr ".tk[1417]" -type "float3" -0.0018108685 0.029951412 -0.0029128976 ;
	setAttr ".tk[1418]" -type "float3" -0.00090581377 0.033811919 -0.0056206482 ;
	setAttr ".tk[1419]" -type "float3" 1.6916558e-05 0.018438775 -0.0024506082 ;
	setAttr ".tk[1420]" -type "float3" 0.0003571233 0.0082240952 -0.00039885554 ;
	setAttr ".tk[1421]" -type "float3" -0.00022476033 0.0021899545 -0.00012097341 ;
	setAttr ".tk[1422]" -type "float3" 0.00051136775 0.0023779504 -0.00035171933 ;
	setAttr ".tk[1423]" -type "float3" 0.0028703483 0.0031653855 -0.00042739738 ;
	setAttr ".tk[1424]" -type "float3" 0.001485687 0.012668191 0.00056127831 ;
	setAttr ".tk[1425]" -type "float3" -0.0009619933 0.016379915 0.001030117 ;
	setAttr ".tk[1426]" -type "float3" -0.0027772558 0.0086704027 0.0010163855 ;
	setAttr ".tk[1427]" -type "float3" -0.0094571672 0.021705957 0.0017381096 ;
	setAttr ".tk[1428]" -type "float3" -0.0032152273 0.03547566 -0.00061788934 ;
	setAttr ".tk[1429]" -type "float3" 0.0035574136 0.021327505 -0.0011526389 ;
	setAttr ".tk[1430]" -type "float3" -1.6562358e-06 0.00010810323 -7.0727219e-06 ;
	setAttr ".tk[1431]" -type "float3" -1.1757127e-06 7.6079317e-07 6.5344636e-07 ;
	setAttr ".tk[1432]" -type "float3" -2.6465585e-08 1.3099901e-08 3.1987906e-08 ;
	setAttr ".tk[1438]" -type "float3" -4.6713376e-05 0.0022002398 5.2607393e-05 ;
	setAttr ".tk[1439]" -type "float3" -0.0012908626 0.0087829689 0.0014393227 ;
	setAttr ".tk[1440]" -type "float3" -0.00075537805 0.0027250114 0.00015941348 ;
	setAttr ".tk[1441]" -type "float3" -0.00068981055 0.012078268 0.0018908768 ;
	setAttr ".tk[1442]" -type "float3" -0.0013150471 0.023092799 0.0029029532 ;
	setAttr ".tk[1443]" -type "float3" -0.00032828934 0.019781372 0.0014941019 ;
	setAttr ".tk[1444]" -type "float3" -0.0017197657 0.01007568 0.002125361 ;
	setAttr ".tk[1445]" -type "float3" -0.0018670278 0.0025086536 0.0014379921 ;
	setAttr ".tk[1446]" -type "float3" -0.0004037843 0.00010725154 0.00028762777 ;
	setAttr ".tk[1447]" -type "float3" -2.225346e-05 -0.0039437204 9.9484649e-05 ;
	setAttr ".tk[1448]" -type "float3" 9.8697135e-05 -0.0036547515 0.00011563351 ;
	setAttr ".tk[1449]" -type "float3" -3.8292641e-05 0.0015898279 -1.5028107e-05 ;
	setAttr ".tk[1450]" -type "float3" -5.7536941e-05 0.0033969192 -5.5289496e-05 ;
	setAttr ".tk[1451]" -type "float3" -0.00015900316 0.0052573821 -1.179249e-05 ;
	setAttr ".tk[1452]" -type "float3" -0.0015363364 0.022228675 0.002455855 ;
	setAttr ".tk[1453]" -type "float3" 0.0012412347 0.024394607 0.0024841418 ;
	setAttr ".tk[1454]" -type "float3" 0.00094444666 0.010356585 0.00034789951 ;
	setAttr ".tk[1455]" -type "float3" 0.00013856933 0.0068613421 0.00010571299 ;
	setAttr ".tk[1456]" -type "float3" 0.0011774836 0.0092998361 4.7401954e-05 ;
	setAttr ".tk[1457]" -type "float3" 0.002605655 0.011148375 -0.00092290848 ;
	setAttr ".tk[1458]" -type "float3" 0.00072141935 0.015149104 -0.0020250962 ;
	setAttr ".tk[1459]" -type "float3" -0.00079552236 0.015144733 -0.0025409295 ;
	setAttr ".tk[1460]" -type "float3" -0.0011951344 0.0058855894 -0.0016094929 ;
	setAttr ".tk[1461]" -type "float3" 0.00035721529 0.0016608606 -0.0012416289 ;
	setAttr ".tk[1462]" -type "float3" 0.00053988839 0.0025168681 -0.0016169294 ;
	setAttr ".tk[1463]" -type "float3" 0.0015169245 0.002491897 -0.0021864066 ;
	setAttr ".tk[1464]" -type "float3" 0.0026248037 0.0035219607 -0.0016424648 ;
	setAttr ".tk[1465]" -type "float3" 0.0010123648 0.010103637 -2.6978312e-05 ;
	setAttr ".tk[1466]" -type "float3" -0.00192636 0.0099399518 0.0013555798 ;
	setAttr ".tk[1467]" -type "float3" -0.0026474567 0.0045148586 0.0012160194 ;
	setAttr ".tk[1468]" -type "float3" -0.0068682469 0.020931924 0.0002390741 ;
	setAttr ".tk[1469]" -type "float3" -0.0016807336 0.032681432 -0.0018200404 ;
	setAttr ".tk[1470]" -type "float3" 0.0021314421 0.014753473 -0.0012642496 ;
	setAttr ".tk[1471]" -type "float3" -0.00018206149 0.00010223428 -0.00042523319 ;
	setAttr ".tk[1472]" -type "float3" -7.7501041e-05 1.6326911e-05 -0.00011603938 ;
	setAttr ".tk[1473]" -type "float3" -8.1829276e-06 3.2907533e-07 -9.9350309e-06 ;
	setAttr ".tk[1474]" -type "float3" -1.2854164e-07 3.3199235e-10 -1.0724384e-07 ;
	setAttr ".tk[1479]" -type "float3" -0.00048205908 0.0028646262 0.00042128118 ;
	setAttr ".tk[1480]" -type "float3" -0.0043883324 0.013480525 0.0045041731 ;
	setAttr ".tk[1481]" -type "float3" -0.0043404512 0.027007392 0.0062689418 ;
	setAttr ".tk[1482]" -type "float3" -0.00097291509 0.028240167 0.003118841 ;
	setAttr ".tk[1483]" -type "float3" 0.00085147738 0.022086566 0.00060422072 ;
	setAttr ".tk[1484]" -type "float3" -8.4496663e-05 0.010834847 0.0012052093 ;
	setAttr ".tk[1485]" -type "float3" -0.00080212054 0.0023675745 0.0010986726 ;
	setAttr ".tk[1486]" -type "float3" -0.00037124354 0.00018631027 0.0002901454 ;
	setAttr ".tk[1487]" -type "float3" -1.9542964e-05 -1.3678853e-05 2.0668109e-05 ;
	setAttr ".tk[1488]" -type "float3" 1.9982686e-05 -0.003844595 -9.9929448e-06 ;
	setAttr ".tk[1489]" -type "float3" 0.00017151314 -0.0039782072 -0.00013315458 ;
	setAttr ".tk[1491]" -type "float3" -0.00038928527 0.0020826706 0.0001908003 ;
	setAttr ".tk[1492]" -type "float3" -0.0024833474 0.017677059 0.00065478194 ;
	setAttr ".tk[1493]" -type "float3" -0.00045919741 0.024329176 0.00042047672 ;
	setAttr ".tk[1494]" -type "float3" 0.0011289028 0.02436335 -5.4262498e-05 ;
	setAttr ".tk[1495]" -type "float3" 0.00058230088 0.016371135 9.845927e-05 ;
	setAttr ".tk[1496]" -type "float3" -0.00022098761 0.016199967 0.0010643812 ;
	setAttr ".tk[1497]" -type "float3" 0.00098378758 0.015058517 0.0018633986 ;
	setAttr ".tk[1498]" -type "float3" 0.0029403514 0.014953446 0.0028786042 ;
	setAttr ".tk[1499]" -type "float3" 0.001689169 0.014407964 0.0027805392 ;
	setAttr ".tk[1500]" -type "float3" -0.00026846578 0.011743203 0.0010135372 ;
	setAttr ".tk[1501]" -type "float3" -0.00046975294 0.0075909384 -0.00063613307 ;
	setAttr ".tk[1502]" -type "float3" 0.0006322785 0.0050826157 -0.0021416789 ;
	setAttr ".tk[1503]" -type "float3" 0.00098631717 0.0038985214 -0.0024135497 ;
	setAttr ".tk[1504]" -type "float3" 0.0013843065 0.0046827691 -0.0020346097 ;
	setAttr ".tk[1505]" -type "float3" 0.0011706519 0.0031018525 -0.00072493043 ;
	setAttr ".tk[1506]" -type "float3" -0.00054425234 0.0032267293 0.00092913455 ;
	setAttr ".tk[1507]" -type "float3" -0.0020441515 0.0043046763 0.0017374657 ;
	setAttr ".tk[1508]" -type "float3" -0.0012928211 0.0060162633 0.00070904876 ;
	setAttr ".tk[1509]" -type "float3" -0.0034527234 0.017266417 -0.0017121634 ;
	setAttr ".tk[1510]" -type "float3" -0.0017272496 0.029784964 -0.0031297153 ;
	setAttr ".tk[1511]" -type "float3" 0.00093152979 0.014976264 -0.0016169123 ;
	setAttr ".tk[1512]" -type "float3" -0.00066962163 0.00054559857 -0.0010062843 ;
	setAttr ".tk[1513]" -type "float3" -0.00053818652 0.00010403777 -0.00042093475 ;
	setAttr ".tk[1514]" -type "float3" -0.00011158871 5.2667287e-06 -6.6727225e-05 ;
	setAttr ".tk[1515]" -type "float3" -4.7874482e-06 1.2328917e-08 -2.070517e-06 ;
	setAttr ".tk[1520]" -type "float3" -0.0022446946 0.0066457749 0.0015058185 ;
	setAttr ".tk[1521]" -type "float3" -0.0079681957 0.032630283 0.0061085387 ;
	setAttr ".tk[1522]" -type "float3" -0.0005994963 0.031931855 0.0010619884 ;
	setAttr ".tk[1523]" -type "float3" 0.00084963441 0.019849483 -0.0012305565 ;
	setAttr ".tk[1524]" -type "float3" 0.00020699081 0.008508265 0.00017505324 ;
	setAttr ".tk[1525]" -type "float3" -5.0277613e-05 0.00150337 0.00041724808 ;
	setAttr ".tk[1526]" -type "float3" -0.00011861463 7.3334333e-05 0.00017503783 ;
	setAttr ".tk[1527]" -type "float3" -5.6964895e-05 -0.0030623844 5.5113407e-05 ;
	setAttr ".tk[1528]" -type "float3" 7.8093499e-06 -0.0045712041 -7.9041411e-06 ;
	setAttr ".tk[1529]" -type "float3" 0.00023758761 -0.0045734434 -0.00022098528 ;
	setAttr ".tk[1530]" -type "float3" 0.00052699109 -0.0035681401 -0.00062437326 ;
	setAttr ".tk[1531]" -type "float3" -0.00073850545 0.011127813 0.00078841927 ;
	setAttr ".tk[1532]" -type "float3" -0.0025815114 0.014378901 0.0002120658 ;
	setAttr ".tk[1533]" -type "float3" -0.0032354083 0.025640242 -0.0017334217 ;
	setAttr ".tk[1534]" -type "float3" 0.00034115498 0.023558641 -0.0025274782 ;
	setAttr ".tk[1535]" -type "float3" 0.00069301156 0.015157319 -0.001917787 ;
	setAttr ".tk[1536]" -type "float3" -0.00021954419 0.015486395 -0.0010265419 ;
	setAttr ".tk[1537]" -type "float3" -0.0011327137 0.018095335 -0.00032318279 ;
	setAttr ".tk[1538]" -type "float3" -0.0029493803 0.028842704 0.0015857224 ;
	setAttr ".tk[1539]" -type "float3" -0.0030760684 0.04418733 0.007060078 ;
	setAttr ".tk[1540]" -type "float3" 0.0014190755 0.041652154 0.007134811 ;
	setAttr ".tk[1541]" -type "float3" 0.0030689826 0.037068743 0.0063047507 ;
	setAttr ".tk[1542]" -type "float3" 0.002933644 0.025096277 0.0026229895 ;
	setAttr ".tk[1543]" -type "float3" 0.00090394437 0.020125315 0.00059349567 ;
	setAttr ".tk[1544]" -type "float3" 0.00033967098 0.012394086 -0.0006650365 ;
	setAttr ".tk[1545]" -type "float3" 0.00031083921 0.011173089 2.9362855e-05 ;
	setAttr ".tk[1546]" -type "float3" -0.00020316163 0.0064311242 0.0013282199 ;
	setAttr ".tk[1547]" -type "float3" -0.0015681984 0.00074701197 0.0022401826 ;
	setAttr ".tk[1548]" -type "float3" -0.0014878561 0.0024962828 0.0022496094 ;
	setAttr ".tk[1549]" -type "float3" -0.00037660022 0.011552332 0.0017237997 ;
	setAttr ".tk[1550]" -type "float3" -0.0020058732 0.017540973 -0.00053063902 ;
	setAttr ".tk[1551]" -type "float3" -0.0012918623 0.022239881 -0.0025674647 ;
	setAttr ".tk[1552]" -type "float3" -0.00029916325 0.012276378 -0.00064457807 ;
	setAttr ".tk[1553]" -type "float3" -0.00093824067 0.00083002838 -0.00017104951 ;
	setAttr ".tk[1554]" -type "float3" -0.00092005142 0.00014891798 -7.5853415e-05 ;
	setAttr ".tk[1555]" -type "float3" -0.0002731811 1.0127824e-05 -1.8711346e-05 ;
	setAttr ".tk[1556]" -type "float3" -1.5021845e-05 3.8334214e-08 -6.3517086e-07 ;
	setAttr ".tk[1560]" -type "float3" -1.7926834e-06 7.8403456e-05 1.0799619e-06 ;
	setAttr ".tk[1561]" -type "float3" -0.0079240799 0.022488395 0.0020374905 ;
	setAttr ".tk[1562]" -type "float3" -0.0045875576 0.039068513 -0.00012490497 ;
	setAttr ".tk[1563]" -type "float3" 0.0017062547 0.020904737 -0.0012906208 ;
	setAttr ".tk[1564]" -type "float3" 5.4302247e-05 0.0025458038 -5.6027144e-05 ;
	setAttr ".tk[1565]" -type "float3" 5.7128345e-06 8.3936568e-05 1.9316503e-05 ;
	setAttr ".tk[1566]" -type "float3" -3.4037912e-06 7.7239965e-06 2.6291227e-05 ;
	setAttr ".tk[1567]" -type "float3" -6.9732423e-06 -0.0003951086 1.0310235e-05 ;
	setAttr ".tk[1568]" -type "float3" -1.9000728e-06 -0.004599405 2.0953239e-06 ;
	setAttr ".tk[1569]" -type "float3" 5.0936866e-05 -0.0024272555 -3.7907565e-05 ;
	setAttr ".tk[1570]" -type "float3" 0.00029427139 -0.0015616402 -0.00015991465 ;
	setAttr ".tk[1571]" -type "float3" 0.00020952565 0.0073249713 -0.0001431047 ;
	setAttr ".tk[1572]" -type "float3" -0.0002417428 0.014587016 0.00010425791 ;
	setAttr ".tk[1573]" -type "float3" -0.0009854848 0.01325654 -0.001274319 ;
	setAttr ".tk[1574]" -type "float3" -0.00063051615 0.010549598 -0.0013789698 ;
	setAttr ".tk[1575]" -type "float3" 0.0001272196 0.0057401415 -0.00080602395 ;
	setAttr ".tk[1576]" -type "float3" 0.00013165205 0.0039691739 -0.00055432389 ;
	setAttr ".tk[1577]" -type "float3" -0.00035502415 0.0049046138 -0.00041825874 ;
	setAttr ".tk[1578]" -type "float3" -0.0010856739 0.0093006995 -0.0012480932 ;
	setAttr ".tk[1579]" -type "float3" -0.0035567444 0.025825825 -0.0031835877 ;
	setAttr ".tk[1580]" -type "float3" -0.0027954641 0.038223889 -0.0063781072 ;
	setAttr ".tk[1581]" -type "float3" 0.0011879097 0.034164388 -0.0047245258 ;
	setAttr ".tk[1582]" -type "float3" 0.0037110164 0.032454912 -0.0039741406 ;
	setAttr ".tk[1583]" -type "float3" 0.0036344798 0.023967395 -0.0016938552 ;
	setAttr ".tk[1584]" -type "float3" 0.0010218339 0.019582564 -0.00040496548 ;
	setAttr ".tk[1585]" -type "float3" -0.0002042772 0.011512843 0.0014670014 ;
	setAttr ".tk[1586]" -type "float3" -0.00049315783 0.0084873876 0.0018723471 ;
	setAttr ".tk[1587]" -type "float3" -0.00059086509 0.0050838119 0.0020682693 ;
	setAttr ".tk[1588]" -type "float3" -0.0012317549 0.0067183757 0.002105566 ;
	setAttr ".tk[1589]" -type "float3" -0.00060135074 0.010215729 0.001883607 ;
	setAttr ".tk[1590]" -type "float3" 0.00080048764 0.018990006 0.0022427982 ;
	setAttr ".tk[1591]" -type "float3" 0.00015446173 0.017009603 0.0009113914 ;
	setAttr ".tk[1592]" -type "float3" -0.00044020137 0.010632889 0.0006153516 ;
	setAttr ".tk[1593]" -type "float3" -0.00036374078 0.0024325573 0.0012755505 ;
	setAttr ".tk[1594]" -type "float3" -0.00073154154 0.00035109383 0.0010065446 ;
	setAttr ".tk[1595]" -type "float3" -0.0006784877 8.9227717e-05 0.00049457449 ;
	setAttr ".tk[1596]" -type "float3" -0.00018852403 3.2668752e-06 8.7729684e-05 ;
	setAttr ".tk[1597]" -type "float3" -8.6359987e-06 2.1843821e-08 2.9210164e-06 ;
	setAttr ".tk[1601]" -type "float3" -8.2915984e-05 0.00061538909 -2.1839878e-05 ;
	setAttr ".tk[1602]" -type "float3" -0.0062694564 0.023154 -0.002895603 ;
	setAttr ".tk[1603]" -type "float3" -0.00039585942 0.029478431 -0.0045302105 ;
	setAttr ".tk[1604]" -type "float3" 0.0002245839 0.0072642374 -0.0001793542 ;
	setAttr ".tk[1606]" -type "float3" 1.1321657e-08 1.1022771e-08 5.3605795e-08 ;
	setAttr ".tk[1607]" -type "float3" -4.1552211e-09 9.0029477e-09 4.3783018e-08 ;
	setAttr ".tk[1608]" -type "float3" -3.4951273e-09 -8.6789114e-05 5.5524079e-09 ;
	setAttr ".tk[1609]" -type "float3" -1.8635939e-08 -0.0017918739 1.9297159e-08 ;
	setAttr ".tk[1611]" -type "float3" 0 0.0031371957 0 ;
	setAttr ".tk[1612]" -type "float3" -4.1104275e-05 0.010399778 -1.4902424e-05 ;
	setAttr ".tk[1613]" -type "float3" 0.0005042082 0.012331286 -0.00063455105 ;
	setAttr ".tk[1614]" -type "float3" 1.0291114e-05 0.00087200309 -6.149002e-05 ;
	setAttr ".tk[1615]" -type "float3" 5.2127626e-07 1.7772381e-05 -3.0878064e-06 ;
	setAttr ".tk[1616]" -type "float3" 5.2942059e-06 0.00012548867 -1.3494045e-05 ;
	setAttr ".tk[1617]" -type "float3" -2.0282992e-05 0.00045754472 -1.4389483e-05 ;
	setAttr ".tk[1618]" -type "float3" -0.00014131868 0.0045558428 -0.00014519045 ;
	setAttr ".tk[1619]" -type "float3" -0.00043930879 0.011480231 -0.00056920934 ;
	setAttr ".tk[1620]" -type "float3" -0.00090702111 0.021540413 -0.0017358916 ;
	setAttr ".tk[1621]" -type "float3" -0.00010803821 0.022606805 -0.0035667834 ;
	setAttr ".tk[1622]" -type "float3" 0.00046619662 0.014332243 -0.0022514889 ;
	setAttr ".tk[1623]" -type "float3" 0.0011137357 0.010292547 -0.00074392412 ;
	setAttr ".tk[1624]" -type "float3" 0.0013663078 0.003517851 0.0010720431 ;
	setAttr ".tk[1625]" -type "float3" 0.00061903842 0.0020047659 0.0025784145 ;
	setAttr ".tk[1626]" -type "float3" -0.00025043628 0.0012384104 0.0025969555 ;
	setAttr ".tk[1627]" -type "float3" -0.00045689612 0.0068076579 0.0014199719 ;
	setAttr ".tk[1628]" -type "float3" -0.0004785753 0.0097495988 0.0013321087 ;
	setAttr ".tk[1629]" -type "float3" -0.00052124058 0.0098670237 0.00095217518 ;
	setAttr ".tk[1630]" -type "float3" -3.3034063e-05 0.0099846451 0.00036212828 ;
	setAttr ".tk[1631]" -type "float3" 0.0003953703 0.010345706 0.00065168948 ;
	setAttr ".tk[1632]" -type "float3" 0.00016887317 0.0076108468 0.0012475669 ;
	setAttr ".tk[1633]" -type "float3" -8.8182525e-05 0.0022009916 0.0012327875 ;
	setAttr ".tk[1634]" -type "float3" -0.00012308314 0.00027193097 0.0010748258 ;
	setAttr ".tk[1635]" -type "float3" -0.00020678909 0.00010193352 0.00077095791 ;
	setAttr ".tk[1636]" -type "float3" -0.00015237751 8.9325968e-06 0.00028301586 ;
	setAttr ".tk[1637]" -type "float3" -3.6365444e-05 1.8156197e-07 3.6988691e-05 ;
	setAttr ".tk[1638]" -type "float3" -4.7053709e-07 1.1792135e-09 3.362033e-07 ;
	setAttr ".tk[1642]" -type "float3" -7.2258485e-06 7.7878125e-05 -5.8537776e-06 ;
	setAttr ".tk[1643]" -type "float3" -0.00059841305 0.0035064674 -0.00069516239 ;
	setAttr ".tk[1644]" -type "float3" 3.924776e-05 0.0074548931 -0.00065575948 ;
	setAttr ".tk[1645]" -type "float3" 0 0.0010724413 0 ;
	setAttr ".tk[1652]" -type "float3" 0 0.0012657136 0 ;
	setAttr ".tk[1653]" -type "float3" 0 0.0064364728 0 ;
	setAttr ".tk[1654]" -type "float3" 2.2229427e-05 0.0012354251 -2.470769e-05 ;
	setAttr ".tk[1659]" -type "float3" -3.8144851e-06 0.0040077902 -3.7979166e-08 ;
	setAttr ".tk[1660]" -type "float3" -9.9895347e-05 0.010640435 -1.5464548e-05 ;
	setAttr ".tk[1661]" -type "float3" 0.00015122589 0.017199228 -0.00038817956 ;
	setAttr ".tk[1662]" -type "float3" 9.1548107e-05 0.012337835 -0.00037206282 ;
	setAttr ".tk[1663]" -type "float3" 7.671088e-05 0.0068348246 6.5103377e-05 ;
	setAttr ".tk[1664]" -type "float3" 0.00033532458 0.002758848 0.00034895714 ;
	setAttr ".tk[1665]" -type "float3" 0.00051928143 0.00023809797 0.00082883332 ;
	setAttr ".tk[1666]" -type "float3" 0.00029860038 0.00024409058 0.0011606603 ;
	setAttr ".tk[1667]" -type "float3" -0.00010685399 0.00020079916 0.0012981163 ;
	setAttr ".tk[1668]" -type "float3" -0.00032025887 0.002327882 0.00096965069 ;
	setAttr ".tk[1669]" -type "float3" -0.000202864 0.0050838534 0.00042463862 ;
	setAttr ".tk[1670]" -type "float3" -4.2274241e-05 0.0026830272 7.3758943e-05 ;
	setAttr ".tk[1671]" -type "float3" 1.2485596e-06 0.0011625496 4.9175733e-06 ;
	setAttr ".tk[1672]" -type "float3" 1.4605961e-05 0.00047546555 4.6973597e-05 ;
	setAttr ".tk[1673]" -type "float3" 9.6330109e-07 2.7947006e-05 9.4746436e-05 ;
	setAttr ".tk[1674]" -type "float3" -1.3740235e-05 2.4022931e-05 8.6652239e-05 ;
	setAttr ".tk[1675]" -type "float3" -5.0196063e-06 1.041434e-05 7.0621973e-05 ;
	setAttr ".tk[1676]" -type "float3" -1.7542069e-06 7.4311356e-07 5.3910611e-05 ;
	setAttr ".tk[1677]" -type "float3" -6.7902824e-06 9.8915841e-08 1.9413661e-05 ;
	setAttr ".tk[1678]" -type "float3" -4.0599323e-07 1.5237742e-09 5.9164637e-07 ;
createNode transformGeometry -n "transformGeometry1";
	setAttr ".txf" -type "matrix" 1000 0 0 0 0 561.19831744188832 0 0 0 0 1000 0 0 0 0 1;
createNode volumeNoise -n "volumeNoise1";
	setAttr ".sp" 1;
	setAttr ".sr" 0.8309859037399292;
	setAttr ".fof" 1;
createNode remapValue -n "remapValue1";
	setAttr -s 2 ".vl[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode solidFractal -n "solidFractal3";
	setAttr ".ra" 1;
	setAttr ".fr" 3.8521127700805664;
createNode remapValue -n "remapValue2";
	setAttr -s 2 ".vl[1:2]"  1 0.60000002 1 0 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode PxrBump -n "PxrBump1";
	setAttr ".scale" 0.019999999552965164;
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode hyperGraphInfo -n "nodeEditorPanel1Info";
createNode hyperView -n "hyperView1";
	setAttr ".vl" -type "double2" -112.97619047619067 -1111.6692172380951 ;
	setAttr ".vh" -type "double2" 1994.6665238095236 557.58381247619036 ;
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 19 ".hyp";
	setAttr ".hyp[0].x" 1441.4285888671875;
	setAttr ".hyp[0].y" -265.71429443359375;
	setAttr ".hyp[0].nvs" 1920;
	setAttr ".hyp[1].x" 1201.4285888671875;
	setAttr ".hyp[1].y" -265.71429443359375;
	setAttr ".hyp[1].nvs" 1920;
	setAttr ".hyp[2].x" 1681.4285888671875;
	setAttr ".hyp[2].y" -265.71429443359375;
	setAttr ".hyp[2].nvs" 1920;
	setAttr ".hyp[3].x" 481.42855834960938;
	setAttr ".hyp[3].y" -358.57144165039062;
	setAttr ".hyp[3].nvs" 1920;
	setAttr ".hyp[4].x" 241.42857360839844;
	setAttr ".hyp[4].y" -215.71427917480469;
	setAttr ".hyp[4].nvs" 1920;
	setAttr ".hyp[5].x" 1.4285714626312256;
	setAttr ".hyp[5].y" -144.28572082519531;
	setAttr ".hyp[5].nvs" 1920;
	setAttr ".hyp[6].x" 481.42855834960938;
	setAttr ".hyp[6].y" -215.71427917480469;
	setAttr ".hyp[6].nvs" 1920;
	setAttr ".hyp[7].x" 1201.4285888671875;
	setAttr ".hyp[7].y" -408.57144165039062;
	setAttr ".hyp[7].nvs" 1920;
	setAttr ".hyp[8].x" 961.4285888671875;
	setAttr ".hyp[8].y" -215.71427917480469;
	setAttr ".hyp[8].nvs" 1920;
	setAttr ".hyp[9].x" 961.4285888671875;
	setAttr ".hyp[9].y" -408.57144165039062;
	setAttr ".hyp[9].nvs" 1920;
	setAttr ".hyp[10].x" 721.4285888671875;
	setAttr ".hyp[10].y" -215.71427917480469;
	setAttr ".hyp[10].nvs" 1920;
	setAttr ".hyp[11].x" 481.42855834960938;
	setAttr ".hyp[11].y" -72.857139587402344;
	setAttr ".hyp[11].nvs" 1920;
	setAttr ".hyp[12].nvs" 1920;
	setAttr ".hyp[13].nvs" 1920;
	setAttr ".hyp[14].nvs" 1920;
	setAttr ".hyp[15].nvs" 1920;
	setAttr ".hyp[16].nvs" 1920;
	setAttr ".hyp[17].nvs" 1920;
	setAttr ".hyp[18].nvs" 1920;
	setAttr ".anf" yes;
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
		+ "                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n"
		+ "                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                $editorName;\n            modelEditor -e -viewSelected 0 $editorName;\n            modelEditor -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n"
		+ "            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -maxConstantTransparency 1\n            -rendererName \"base_OpenGL_Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n"
		+ "            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n"
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
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l (localizedPanelLabel(\"UV Texture Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Texture Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\tif ($useSceneConfig) {\n\t\tscriptedPanel -e -to $panelName;\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" (localizedPanelLabel(\"Blend Shape\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\tblendShapePanel -unParent -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels ;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tblendShapePanel -edit -l (localizedPanelLabel(\"Blend Shape\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"scriptEditorPanel\" -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderManControlsType\" (localizedPanelLabel(\"RenderMan Controls\")) `;\n\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderManControlsType\" -l (localizedPanelLabel(\"RenderMan Controls\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"RenderMan Controls\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderManLightingType\" (localizedPanelLabel(\"RenderMan Lighting\")) `;\n"
		+ "\tif (\"\" == $panelName) {\n\t\tif ($useSceneConfig) {\n\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderManLightingType\" -l (localizedPanelLabel(\"RenderMan Lighting\")) -mbv $menusOkayInPanels `;\n\t\t}\n\t} else {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"RenderMan Lighting\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -maxConstantTransparency 1\\n    -rendererName \\\"base_OpenGL_Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        setFocus `paneLayout -q -p1 $gMainPane`;\n        sceneUIReplacement -deleteRemaining;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode displayLayer -n "proxy";
	setAttr ".dt" 1;
	setAttr ".do" 1;
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
	setAttr -k on ".ro" yes;
	setAttr -cb on ".mimt";
	setAttr -cb on ".miop";
	setAttr -k on ".mico";
	setAttr -cb on ".mise";
	setAttr -cb on ".mism";
	setAttr -cb on ".mice";
	setAttr -av ".micc";
	setAttr -k on ".micr";
	setAttr -k on ".micg";
	setAttr -k on ".micb";
	setAttr -cb on ".mica";
	setAttr -av -cb on ".micw";
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
	setAttr -k on ".ro" yes;
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
	setAttr -s 5 ".s";
select -ne :defaultTextureList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 8 ".tx";
select -ne :lightList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
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
	setAttr -s 7 ".u";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultRenderGlobals;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -k on ".macc";
	setAttr -k on ".macd";
	setAttr -k on ".macq";
	setAttr -k on ".mcfr";
	setAttr -k on ".ifg";
	setAttr -k on ".clip";
	setAttr -k on ".edm";
	setAttr -k on ".edl";
	setAttr -cb on ".ren" -type "string" "renderManRIS";
	setAttr -av -k on ".esr";
	setAttr -k on ".ors";
	setAttr -k on ".sdf";
	setAttr -av -k on ".outf";
	setAttr -k on ".imfkey";
	setAttr -k on ".gama";
	setAttr -k on ".an";
	setAttr -k on ".ar";
	setAttr -k on ".fs";
	setAttr -k on ".ef";
	setAttr -av -k on ".bfs";
	setAttr -k on ".me";
	setAttr -k on ".se";
	setAttr -k on ".be";
	setAttr -cb on ".ep";
	setAttr -k on ".fec";
	setAttr -k on ".ofc";
	setAttr -k on ".ofe";
	setAttr -k on ".efe";
	setAttr -cb on ".oft";
	setAttr -k on ".umfn";
	setAttr -k on ".ufe";
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
	setAttr -k on ".gv";
	setAttr -k on ".sv";
	setAttr -k on ".mm";
	setAttr -k on ".npu";
	setAttr -k on ".itf";
	setAttr -k on ".shp";
	setAttr -k on ".isp";
	setAttr -k on ".uf";
	setAttr -k on ".oi";
	setAttr -k on ".rut";
	setAttr -k on ".mb";
	setAttr -av -k on ".mbf";
	setAttr -k on ".afp";
	setAttr -k on ".pfb";
	setAttr -k on ".pram";
	setAttr -k on ".poam";
	setAttr -k on ".prlm";
	setAttr -k on ".polm";
	setAttr -cb on ".prm";
	setAttr -cb on ".pom";
	setAttr -k on ".pfrm";
	setAttr -k on ".pfom";
	setAttr -av -k on ".bll";
	setAttr -av -k on ".bls";
	setAttr -av -k on ".smv";
	setAttr -k on ".ubc";
	setAttr -k on ".mbc";
	setAttr -k on ".mbt";
	setAttr -k on ".udbx";
	setAttr -k on ".smc";
	setAttr -k on ".kmv";
	setAttr -k on ".isl";
	setAttr -k on ".ism";
	setAttr -k on ".imb";
	setAttr -k on ".rlen";
	setAttr -av -k on ".frts";
	setAttr -k on ".tlwd";
	setAttr -k on ".tlht";
	setAttr -k on ".jfc";
	setAttr -k on ".rsb";
	setAttr -k on ".ope";
	setAttr -k on ".oppf";
	setAttr ".cpe" yes;
	setAttr -k on ".hbl";
select -ne :defaultResolution;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av ".w" 1280;
	setAttr -av ".h" 720;
	setAttr -av -k on ".pa" 1;
	setAttr -av -k on ".al";
	setAttr -av ".dar" 1.7769999504089355;
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
select -ne :defaultViewColorManager;
	setAttr ".ip" 2;
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
connectAttr "rmanDayLight.oc" "RMSEnvLight_DaylightShape.lightcolor";
connectAttr "proxy.di" "proxy_object.do";
connectAttr "makeNurbSphere1.os" "proxy_objectShape.cr";
connectAttr "transformGeometry1.og" "groundShape.i";
connectAttr ":rmanFinalGlobals.msg" ":renderManRISGlobals.p" -na;
connectAttr ":rmanRerenderRISGlobals.msg" ":renderManRISGlobals.p" -na;
connectAttr ":rmanFinalOutputGlobals0.msg" ":rmanFinalGlobals.d" -na;
connectAttr ":rmanRerenderRISOutputGlobals0.msg" ":rmanRerenderRISGlobals.d" -na
		;
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "PxrLMDiffuse1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "RMSDisplacement1SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "PxrLMMetal1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "PxrLMDiffuse1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "RMSDisplacement1SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "PxrLMMetal1SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "ramp1.oa" "PxrLM_Ground.presence";
connectAttr "remapValue2.ov" "PxrLM_Ground.roughness";
connectAttr "PxrBump1.resultN" "PxrLM_Ground.bumpNormal";
connectAttr "PxrLM_Ground.oc" "PxrLMDiffuse1SG.ss";
connectAttr "groundShape.iog" "PxrLMDiffuse1SG.dsm" -na;
connectAttr "RMSDisplacement_Ground.oc" "PxrLMDiffuse1SG.ds";
connectAttr "PxrLMDiffuse1SG.msg" "materialInfo1.sg";
connectAttr "PxrLM_Ground.msg" "materialInfo1.m";
connectAttr "PxrLM_Ground.msg" "materialInfo1.t" -na;
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "place2dTexture2.o" "ramp2.uv";
connectAttr "place2dTexture2.ofs" "ramp2.fs";
connectAttr "solidFractal2.oc" "ramp2.cel[3].ec";
connectAttr "ramp2.oa" "RMSDisplacement_Ground.displacementScalar";
connectAttr "RMSDisplacement_Ground.oc" "RMSDisplacement1SG.ss";
connectAttr "RMSDisplacement1SG.msg" "materialInfo2.sg";
connectAttr "RMSDisplacement_Ground.msg" "materialInfo2.m";
connectAttr "RMSDisplacement_Ground.msg" "materialInfo2.t" -na;
connectAttr "PxrLMMetal_Proxy_Object.oc" "PxrLMMetal1SG.ss";
connectAttr "proxy_objectShape.iog" "PxrLMMetal1SG.dsm" -na;
connectAttr "PxrLMMetal1SG.msg" "materialInfo3.sg";
connectAttr "PxrLMMetal_Proxy_Object.msg" "materialInfo3.m";
connectAttr "PxrLMMetal_Proxy_Object.msg" "materialInfo3.t" -na;
connectAttr "place3dTexture2.wim" "solidFractal2.pm";
connectAttr "polyPlane1.out" "polyTweak1.ip";
connectAttr "polyTweak1.out" "transformGeometry1.ig";
connectAttr "place3dTexture3.wim" "volumeNoise1.pm";
connectAttr "solidFractal2.oa" "volumeNoise1.ti";
connectAttr "remapValue1.ov" "volumeNoise1.d";
connectAttr "solidFractal3.oa" "remapValue1.i";
connectAttr "place3dTexture2.wim" "solidFractal3.pm";
connectAttr "volumeNoise1.oa" "remapValue2.i";
connectAttr "remapValue2.ov" "PxrBump1.inputBump";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "hyperLayout1.msg" "hyperView1.hl";
connectAttr "PxrLM_Ground.msg" "hyperLayout1.hyp[0].dn";
connectAttr "PxrBump1.msg" "hyperLayout1.hyp[1].dn";
connectAttr "PxrLMDiffuse1SG.msg" "hyperLayout1.hyp[2].dn";
connectAttr "place3dTexture3.msg" "hyperLayout1.hyp[3].dn";
connectAttr "solidFractal3.msg" "hyperLayout1.hyp[4].dn";
connectAttr "place3dTexture2.msg" "hyperLayout1.hyp[5].dn";
connectAttr "remapValue1.msg" "hyperLayout1.hyp[6].dn";
connectAttr "ramp1.msg" "hyperLayout1.hyp[7].dn";
connectAttr "remapValue2.msg" "hyperLayout1.hyp[8].dn";
connectAttr "place2dTexture1.msg" "hyperLayout1.hyp[9].dn";
connectAttr "volumeNoise1.msg" "hyperLayout1.hyp[10].dn";
connectAttr "solidFractal2.msg" "hyperLayout1.hyp[11].dn";
connectAttr "layerManager.dli[1]" "proxy.id";
connectAttr "PxrLMDiffuse1SG.pa" ":renderPartition.st" -na;
connectAttr "RMSDisplacement1SG.pa" ":renderPartition.st" -na;
connectAttr "PxrLMMetal1SG.pa" ":renderPartition.st" -na;
connectAttr "PxrLM_Ground.msg" ":defaultShaderList1.s" -na;
connectAttr "RMSDisplacement_Ground.msg" ":defaultShaderList1.s" -na;
connectAttr "PxrLMMetal_Proxy_Object.msg" ":defaultShaderList1.s" -na;
connectAttr "rmanDayLight.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp2.msg" ":defaultTextureList1.tx" -na;
connectAttr "solidFractal1.msg" ":defaultTextureList1.tx" -na;
connectAttr "solidFractal2.msg" ":defaultTextureList1.tx" -na;
connectAttr "volumeNoise1.msg" ":defaultTextureList1.tx" -na;
connectAttr "solidFractal3.msg" ":defaultTextureList1.tx" -na;
connectAttr "PxrBump1.msg" ":defaultTextureList1.tx" -na;
connectAttr "RMSEnvLight_DaylightShape.ltd" ":lightList1.l" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture3.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place3dTexture4.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "remapValue2.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "RMSEnvLight_Daylight.iog" ":defaultLightSet.dsm" -na;
// End of Rig_Outdoor_Daylight.ma
