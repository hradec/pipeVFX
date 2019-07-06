//Maya ASCII 2014 scene
//Name: physics.ma
//Last modified: Fri, Jun 03, 2016 04:58:18 PM
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
	setAttr ".t" -type "double3" -55.485888328397436 12.572513858360695 32.378327150847937 ;
	setAttr ".r" -type "double3" -26.13835272960122 14.999999999999993 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 39.704786260158798;
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
	setAttr -k off ".v";
createNode transform -n "crowdManager";
	addAttr -ci true -sn "trBETabs" -ln "trBETabs" -nn "Behavior Editor Tabs" -dt "string";
	addAttr -ci true -sn "trBECTab" -ln "trBECTab" -nn "Behavior Editor Current Tab" 
		-at "float";
	setAttr ".trBETabs" -type "string" "entityTypeContainerShape2#entityTypeContainerShape3#entityTypeContainerShape3#";
createNode CrowdManagerNode -n "crowdManagerShape" -p "crowdManager";
	setAttr -k off ".v";
	setAttr ".dsc" -type "string" "";
	setAttr ".dsp" -type "string" "cacheProxyShape1";
	setAttr -s 2 ".ine";
	setAttr ".pps" -type "string" "particleShape2";
	setAttr ".ppid" 5;
	setAttr ".ptv" yes;
	setAttr ".esf" 1;
	setAttr ".eef" 600;
	setAttr ".ecf" -type "string" "crowdField1";
	setAttr ".escn" -type "string" "";
	setAttr ".escod" -type "string" "";
	setAttr ".escaa" -type "string" "particleId;glmEntityType";
	setAttr ".efbxod" -type "string" "";
	setAttr ".eribod" -type "string" "";
	setAttr ".eribp" -type "string" "glmCrowdRMSPlugin";
	setAttr ".eribwsz" 1;
	setAttr ".emrod" -type "string" "";
	setAttr ".emrwsz" 1;
	setAttr ".evrod" -type "string" "";
	setAttr ".eassod" -type "string" "";
	setAttr ".easswsz" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/ball.gcha;/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/fortressSoldier.gcha";
	setAttr ".drm" -type "string" "";
lockNode -l 1 ;
createNode transform -n "crowdBehaviors";
createNode transform -n "entityTypeContainer2" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape2" -p "entityTypeContainer2";
	setAttr -k off ".v";
	setAttr ".ipx" 95;
	setAttr ".ipy" 161;
	setAttr ".fpx" 732;
	setAttr ".fpy" 168;
createNode transform -n "notes5" -p "entityTypeContainer2";
createNode CrowdStickyNotesNode -n "Physicalize_ball_and_lauch_it" -p "notes5";
	setAttr -k off ".v";
	setAttr ".px" 186;
	setAttr ".py" 78;
	setAttr ".hgt" 178;
	setAttr ".wth" 456;
	setAttr ".col" -type "float3" 0 0 1 ;
createNode transform -n "crowdTriggers" -p "crowdBehaviors";
createNode transform -n "beForce1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce1StartTriggerShape" -p "beForce1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd1" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape1" -p "triOpAnd1";
	setAttr -k off ".v";
createNode transform -n "triBool1" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape1" -p "triBool1";
	setAttr -k off ".v";
createNode transform -n "beForce1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce1StopTriggerShape" -p "beForce1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd2" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape2" -p "triOpAnd2";
	setAttr -k off ".v";
createNode transform -n "triBool2" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape2" -p "triBool2";
	setAttr -k off ".v";
createNode transform -n "beForce2StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce2StartTriggerShape" -p "beForce2StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd3" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape3" -p "triOpAnd3";
	setAttr -k off ".v";
	setAttr -s 3 ".prt";
createNode transform -n "triFrame1" -p "crowdTriggers";
createNode CrowdTriFrame -n "triFrameShape1" -p "triFrame1";
	setAttr -k off ".v";
	setAttr ".val" 300;
createNode transform -n "triDistance1" -p "crowdTriggers";
createNode CrowdTriDistance -n "triDistanceShape1" -p "triDistance1";
	setAttr -k off ".v";
	setAttr ".opr" 2;
	setAttr ".val" 10;
createNode transform -n "triBool3" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape3" -p "triBool3";
	setAttr -k off ".v";
createNode transform -n "beForce2StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce2StopTriggerShape" -p "beForce2StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd4" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape4" -p "triOpAnd4";
	setAttr -k off ".v";
createNode transform -n "triBool4" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape4" -p "triBool4";
	setAttr -k off ".v";
createNode transform -n "beForce3StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce3StartTriggerShape" -p "beForce3StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd5" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape5" -p "triOpAnd5";
	setAttr -k off ".v";
	setAttr -s 2 ".prt";
createNode transform -n "triFrame2" -p "crowdTriggers";
createNode CrowdTriFrame -n "triFrameShape2" -p "triFrame2";
	setAttr -k off ".v";
	setAttr ".opr" 5;
	setAttr ".val" 360;
createNode transform -n "triBool5" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape5" -p "triBool5";
	setAttr -k off ".v";
createNode transform -n "beForce3StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beForce3StopTriggerShape" -p "beForce3StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd6" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape6" -p "triOpAnd6";
	setAttr -k off ".v";
createNode transform -n "triBeTime1" -p "crowdTriggers";
createNode CrowdTriBehaviorTime -n "triBeTimeShape1" -p "triBeTime1";
	setAttr -k off ".v";
	setAttr ".fra" 100;
createNode transform -n "beGoto1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beGoto1StartTriggerShape" -p "beGoto1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd7" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape7" -p "triOpAnd7";
	setAttr -k off ".v";
createNode transform -n "triBool6" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape6" -p "triBool6";
	setAttr -k off ".v";
createNode transform -n "beGoto1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beGoto1StopTriggerShape" -p "beGoto1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd8" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape8" -p "triOpAnd8";
	setAttr -k off ".v";
createNode transform -n "triBool7" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape7" -p "triBool7";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beLocomotion1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beLocomotion1StartTriggerShape" -p "beLocomotion1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd9" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape9" -p "triOpAnd9";
	setAttr -k off ".v";
createNode transform -n "triBool8" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape8" -p "triBool8";
	setAttr -k off ".v";
createNode transform -n "beLocomotion1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beLocomotion1StopTriggerShape" -p "beLocomotion1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd10" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape10" -p "triOpAnd10";
	setAttr -k off ".v";
createNode transform -n "triBool9" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape9" -p "triBool9";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beNavigation1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beNavigation1StartTriggerShape" -p "beNavigation1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd11" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape11" -p "triOpAnd11";
	setAttr -k off ".v";
createNode transform -n "triBool10" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape10" -p "triBool10";
	setAttr -k off ".v";
createNode transform -n "beNavigation1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "beNavigation1StopTriggerShape" -p "beNavigation1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd12" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape12" -p "triOpAnd12";
	setAttr -k off ".v";
createNode transform -n "triBool11" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape11" -p "triBool11";
	setAttr -k off ".v";
	setAttr ".val" no;
createNode transform -n "beOpAlternative1Trigger1" -p "crowdTriggers";
createNode CrowdTriContainer -n "beOpAlternative1TriggerShape1" -p "beOpAlternative1Trigger1";
	setAttr -k off ".v";
createNode transform -n "triOpAnd13" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape13" -p "triOpAnd13";
	setAttr -k off ".v";
	setAttr -s 2 ".prt";
createNode transform -n "triFrame3" -p "crowdTriggers";
createNode CrowdTriFrame -n "triFrameShape3" -p "triFrame3";
	setAttr -k off ".v";
	setAttr ".opr" 5;
	setAttr ".val" 80;
createNode transform -n "triBool12" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape12" -p "triBool12";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize1StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize1StartTriggerShape" -p "bePhysicalize1StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd14" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape14" -p "triOpAnd14";
	setAttr -k off ".v";
createNode transform -n "triBool13" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape13" -p "triBool13";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize1StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize1StopTriggerShape" -p "bePhysicalize1StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd15" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape15" -p "triOpAnd15";
	setAttr -k off ".v";
createNode transform -n "triBool14" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape14" -p "triBool14";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize2StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize2StartTriggerShape" -p "bePhysicalize2StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd16" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape16" -p "triOpAnd16";
	setAttr -k off ".v";
createNode transform -n "triBool15" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape15" -p "triBool15";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize2StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize2StopTriggerShape" -p "bePhysicalize2StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpOr1" -p "crowdTriggers";
createNode CrowdTriOpOr -n "triOpOrShape1" -p "triOpOr1";
	setAttr -k off ".v";
	setAttr -s 2 ".prt";
createNode transform -n "triFrame4" -p "crowdTriggers";
createNode CrowdTriFrame -n "triFrameShape4" -p "triFrame4";
	setAttr -k off ".v";
	setAttr ".opr" 5;
	setAttr ".val" 80;
createNode transform -n "triCollision1" -p "crowdTriggers";
createNode CrowdTriCollision -n "triCollisionShape1" -p "triCollision1";
	setAttr -k off ".v";
	setAttr ".opr" 1;
	setAttr ".iva" 2;
createNode transform -n "bePhysicalize3StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize3StartTriggerShape" -p "bePhysicalize3StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd17" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape17" -p "triOpAnd17";
	setAttr -k off ".v";
createNode transform -n "triCollision2" -p "crowdTriggers";
createNode CrowdTriCollision -n "triCollisionShape2" -p "triCollision2";
	setAttr -k off ".v";
	setAttr ".cmo" 3;
	setAttr ".opr" 5;
	setAttr ".iva" 1;
createNode transform -n "bePhysicalize3StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize3StopTriggerShape" -p "bePhysicalize3StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd18" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape18" -p "triOpAnd18";
	setAttr -k off ".v";
createNode transform -n "triBool16" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape16" -p "triBool16";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize4StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize4StopTriggerShape" -p "bePhysicalize4StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd19" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape19" -p "triOpAnd19";
	setAttr -k off ".v";
createNode transform -n "triBool17" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape17" -p "triBool17";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize5StartTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize5StartTriggerShape" -p "bePhysicalize5StartTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd20" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape20" -p "triOpAnd20";
	setAttr -k off ".v";
	setAttr -s 2 ".prt";
createNode transform -n "triFrame5" -p "crowdTriggers";
createNode CrowdTriFrame -n "triFrameShape5" -p "triFrame5";
	setAttr -k off ".v";
	setAttr ".opr" 5;
	setAttr ".val" 300;
createNode transform -n "triCollision3" -p "crowdTriggers";
createNode CrowdTriCollision -n "triCollisionShape3" -p "triCollision3";
	setAttr -k off ".v";
	setAttr ".cmo" 3;
	setAttr ".opr" 5;
	setAttr ".iva" 2;
createNode transform -n "bePhysicalize5StopTrigger" -p "crowdTriggers";
createNode CrowdTriContainer -n "bePhysicalize5StopTriggerShape" -p "bePhysicalize5StopTrigger";
	setAttr -k off ".v";
createNode transform -n "triOpAnd21" -p "crowdTriggers";
createNode CrowdTriOpAnd -n "triOpAndShape21" -p "triOpAnd21";
	setAttr -k off ".v";
createNode transform -n "triBool18" -p "crowdTriggers";
createNode CrowdTriBoolean -n "triBoolShape18" -p "triBool18";
	setAttr -k off ".v";
createNode transform -n "bePhysicalize1" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape1" -p "bePhysicalize1";
	setAttr -k off ".v";
	setAttr ".bpx" 289;
	setAttr ".bpy" 165;
createNode transform -n "beForce1" -p "crowdBehaviors";
createNode CrowdBeForce -n "beForceShape1" -p "beForce1";
	setAttr -k off ".v";
	setAttr ".bpx" 533;
	setAttr ".bpy" 166;
	setAttr ".dc" -type "float3" 0 1 1 ;
	setAttr ".fds" -type "float3" -1 -1 0 ;
	setAttr ".fis" 250;
createNode transform -n "entityTypeContainer3" -p "crowdBehaviors";
createNode CrowdBeContainer -n "entityTypeContainerShape3" -p "entityTypeContainer3";
	setAttr -k off ".v";
	setAttr ".ipx" -13;
	setAttr ".ipy" 203;
	setAttr ".fpx" 679;
	setAttr ".fpy" 202;
createNode transform -n "crowdMotionClips" -p "crowdBehaviors";
createNode transform -n "CMAN_RunNormal_Leftfoot2" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_RunNormal_LeftfootShape2" -p "CMAN_RunNormal_Leftfoot2";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 3;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_RunNormal_Leftfoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkTurnRight45_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkTurnRight45_LeftFootShape1" -p "CMAN_WalkTurnRight45_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 5;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight45_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkTurnRight90_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkTurnRight90_LeftFootShape1" -p "CMAN_WalkTurnRight90_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 6;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight90_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkTurnRight135_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkTurnRight135_LeftFootShape1" -p "CMAN_WalkTurnRight135_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 7;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight135_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkTurnRight180_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkTurnRight180_LeftFootShape1" -p "CMAN_WalkTurnRight180_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 8;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight180_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "motionClip2" -p "crowdMotionClips";
createNode MotionClip -n "motionClipShape2" -p "motionClip2";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 9;
	setAttr ".gmo" -type "string" "";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkNormal_Leftfoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkNormal_LeftfootShape1" -p "CMAN_WalkNormal_Leftfoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 10;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkNormal_Leftfoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkTurnRight45_LeftFoot2" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkTurnRight45_LeftFootShape2" -p "CMAN_WalkTurnRight45_LeftFoot2";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 11;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkTurnRight45_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_WalkSlow_Leftfoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_WalkSlow_LeftfootShape1" -p "CMAN_WalkSlow_Leftfoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 12;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_WalkSlow_Leftfoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_StandOrientLeft45_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_StandOrientLeft45_LeftFootShape1" -p "CMAN_StandOrientLeft45_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 13;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft45_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_StandOrientLeft90_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_StandOrientLeft90_LeftFootShape1" -p "CMAN_StandOrientLeft90_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 14;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft90_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_StandOrientLeft135_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_StandOrientLeft135_LeftFootShape1" -p "CMAN_StandOrientLeft135_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 15;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft135_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "CMAN_StandOrientLeft180_LeftFoot1" -p "crowdMotionClips";
createNode MotionClip -n "CMAN_StandOrientLeft180_LeftFootShape1" -p "CMAN_StandOrientLeft180_LeftFoot1";
	setAttr -k off ".v";
	setAttr -l on ".mcid" 16;
	setAttr ".gmo" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/motions/Locomotion/CMAN_StandOrientLeft180_LeftFoot.gmo";
	setAttr ".aur" yes;
createNode transform -n "bePhysicalize2" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape2" -p "bePhysicalize2";
	setAttr -k off ".v";
	setAttr ".bpx" 129;
	setAttr ".bpy" 201.90908813476562;
	setAttr ".dc" -type "float3" 1 0 0 ;
	setAttr ".phm" 1;
createNode transform -n "PhysicsContainer" -p "crowdBehaviors";
createNode CrowdBeContainer -n "PhysicsContainerShape" -p "PhysicsContainer";
	setAttr -k off ".v";
	setAttr ".bpy" -123;
	setAttr ".ipx" -4.9999961853027344;
	setAttr ".ipy" 201.09089660644531;
	setAttr ".fpx" 955.3636474609375;
	setAttr ".fpy" 186.18182373046875;
createNode transform -n "notes1" -p "PhysicsContainer";
createNode CrowdStickyNotesNode -n "KinematicMode" -p "notes1";
	setAttr -k off ".v";
	setAttr ".txt" -type "string" "";
	setAttr ".px" 34.545452117919922;
	setAttr ".py" 110.90908813476562;
	setAttr ".hgt" 216.36363220214844;
	setAttr ".wth" 186.36363220214844;
	setAttr ".col" -type "float3" 0 1 0 ;
createNode transform -n "notes2" -p "PhysicsContainer";
createNode CrowdStickyNotesNode -n "CollisionWithBall" -p "notes2";
	setAttr -k off ".v";
	setAttr ".px" 373.6363525390625;
	setAttr ".py" 50;
	setAttr ".hgt" 134.54545593261719;
	setAttr ".wth" 216.36363220214844;
	setAttr ".col" -type "float3" 0 1 1 ;
createNode transform -n "notes3" -p "PhysicsContainer";
createNode CrowdStickyNotesNode -n "Explosion" -p "notes3";
	setAttr -k off ".v";
	setAttr ".px" 341.81817626953125;
	setAttr ".py" 233.63636779785156;
	setAttr ".hgt" 196.36363220214844;
	setAttr ".wth" 312.18182373046875;
createNode transform -n "notes4" -p "PhysicsContainer";
createNode CrowdStickyNotesNode -n "SoldierAspiration" -p "notes4";
	setAttr -k off ".v";
	setAttr ".px" 723;
	setAttr ".py" 110;
	setAttr ".hgt" 151;
	setAttr ".wth" 182;
	setAttr ".col" -type "float3" 1 0 0 ;
createNode transform -n "bePhysicalize3" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape3" -p "bePhysicalize3";
	setAttr -k off ".v";
	setAttr ".bpx" 473.63632202148437;
	setAttr ".bpy" 126.27273559570312;
	setAttr ".dc" -type "float3" 0 0 1 ;
createNode transform -n "beGoto1" -p "crowdBehaviors";
createNode CrowdBeGoto -n "beGotoShape1" -p "beGoto1";
	setAttr -k off ".v";
	setAttr ".bpy" 133;
	setAttr ".dc" -type "float3" 1 0 1 ;
	setAttr ".tm" 1;
createNode transform -n "beNavigation1" -p "crowdBehaviors";
createNode CrowdBeNavigation -n "beNavigationShape1" -p "beNavigation1";
	setAttr -k off ".v";
	setAttr ".bpy" 51;
	setAttr ".dc" -type "float3" 1 0.5 0 ;
createNode transform -n "beOpParallel2" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape2" -p "beOpParallel2";
	setAttr -k off ".v";
	setAttr ".bpx" 337.81817626953125;
	setAttr ".bpy" 205.27272033691406;
createNode transform -n "beLocomotion1" -p "crowdBehaviors";
createNode CrowdBeLocomotion -n "beLocomotionShape1" -p "beLocomotion1";
	setAttr -k off ".v";
	setAttr ".bpy" -31;
	setAttr ".dc" -type "float3" 1 0 0.5 ;
	setAttr ".spma" 1;
	setAttr -s 11 ".mcp";
	setAttr -s 10 ".gmi[2:11]"  2 2 2 2 0 0 
		2 2 2 2;
createNode transform -n "beOpAlternative1" -p "crowdBehaviors";
createNode CrowdBeOpAlternative -n "beOpAlternativeShape1" -p "beOpAlternative1";
	setAttr -k off ".v";
	setAttr ".bpx" 326.3636474609375;
	setAttr ".bpy" 205.45452880859375;
createNode transform -n "bePhysicalize4" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape4" -p "bePhysicalize4";
	setAttr -k off ".v";
	setAttr ".bpy" -82;
	setAttr ".dc" -type "float3" 0 0.5 0 ;
createNode transform -n "beForce2" -p "crowdBehaviors";
createNode CrowdBeForce -n "beForceShape2" -p "beForce2";
	setAttr -k off ".v";
	setAttr ".dc" -type "float3" 0 0.5 0.5 ;
	setAttr ".fds" -type "float3" 0 1 0 ;
	setAttr ".fdn" -type "float3" 0.1 0.1 0.1 ;
	setAttr ".fimi" 5;
	setAttr ".fiMd" 11;
	setAttr ".fiMi" 15;
	setAttr ".fin" 0.84905660152435303;
	setAttr ".bmm" 1;
	setAttr ".bmmi" 0.98113209009170532;
	setAttr ".bmma" 1.5283018350601196;
createNode transform -n "beOpParallel3" -p "crowdBehaviors";
createNode CrowdBeOpParallel -n "beOpParallelShape3" -p "beOpParallel3";
	setAttr -k off ".v";
	setAttr ".bpx" 500.81817626953125;
	setAttr ".bpy" 388.45449829101563;
	setAttr ".em" 1;
createNode transform -n "beForce3" -p "crowdBehaviors";
createNode CrowdBeForce -n "beForceShape3" -p "beForce3";
	setAttr -k off ".v";
	setAttr -s 2 ".prb";
	setAttr ".bpx" 812.09088134765625;
	setAttr ".bpy" 185.36363220214844;
	setAttr ".dc" -type "float3" 0.5 0.5 0 ;
	setAttr ".fom" 1;
	setAttr ".fis" -20;
	setAttr ".bmm" 0;
createNode transform -n "bePhysicalize5" -p "crowdBehaviors";
createNode CrowdBePhysicalize -n "bePhysicalizeShape5" -p "bePhysicalize5";
	setAttr -k off ".v";
	setAttr ".bpy" 82;
	setAttr ".dc" -type "float3" 0.5 0 0 ;
createNode transform -n "popTool1";
	setAttr ".t" -type "double3" 12.687999725341797 13.021979552846419 3.5012099742889404 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "popToolShape1" -p "popTool1";
	setAttr -k off ".v";
	setAttr ".np" 1;
	setAttr ".npp" 1;
	setAttr ".nr" 1;
	setAttr ".nc" 1;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "particleShape1";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 1 12.687999725341797 13.021979331970215 3.5012099742889404 ;
	setAttr ".pto" -type "vectorArray" 1 0 0 0 ;
	setAttr ".dr" -type "vectorArray" 1 1 0 -1.5099580252808664e-007 ;
	setAttr ".poo" -type "doubleArray" 1 0 ;
	setAttr ".pgo" -type "vectorArray" 1 0 0 0 ;
	setAttr ".lpt" -type "Int32Array" 1 0 ;
	setAttr ".lpp" -type "vectorArray" 1 0 0 0 ;
	setAttr ".lpo" -type "doubleArray" 1 0 ;
	setAttr ".ldr" -type "vectorArray" 1 0 0 0 ;
	setAttr ".et" -type "doubleArray" 1 1 ;
	setAttr ".get" -type "doubleArray" 1 0 ;
	setAttr ".gpid" -type "doubleArray" 1 1 ;
	setAttr ".etc" -type "vectorArray" 1 0 1 0 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
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
	setAttr ".pos0" -type "vectorArray" 1 12.687999725341797 13.021979331970217
		 3.5012099742889404 ;
	setAttr ".vel0" -type "vectorArray" 1 -102.36677704055435 -48.043473241122129
		 0 ;
	setAttr ".acc0" -type "vectorArray" 1 -2456.8026489733047 -1153.0433577869312
		 0 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "physics_startup";
	setAttr ".mas0" -type "doubleArray" 1 1 ;
	setAttr ".id0" -type "doubleArray" 1 0 ;
	setAttr ".nid" 1;
	setAttr ".nid0" 1;
	setAttr ".bt0" -type "doubleArray" 1 -0.41666666666666663 ;
	setAttr ".ag0" -type "doubleArray" 1 0.91666666666666652 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 600;
	setAttr ".glmInitDirection0" -type "vectorArray" 1 1 0 -1.5099580252808664e-007 ;
	setAttr ".glmEntityType0" -type "doubleArray" 1 1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 1 0 ;
	setAttr ".rgbPP0" -type "vectorArray" 1 0 1 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 1 0.30000001192092896 ;
	setAttr ".populationGroupId0" -type "doubleArray" 1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 1 1.7976931348623157e+308 ;
	setAttr ".glmEntityId0" -type "doubleArray" 1 1001 ;
	setAttr ".glmGroupId0" -type "doubleArray" 1 -1 ;
	setAttr -k on ".lifespan" 1;
createNode CrowdField -n "crowdField1";
	setAttr -s 2 ".ind";
	setAttr -s 2 ".of";
	setAttr -s 2 ".ppda";
	setAttr ".fc[0]"  0 1 1;
	setAttr ".amag[0]"  0 1 1;
	setAttr ".crad[0]"  0 1 1;
	setAttr -l on ".cfid" 1;
	setAttr -l on ".noe" 461;
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
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -l on ".etid" 1;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/ball.gcha";
	setAttr ".scrmi" 5;
	setAttr ".scrma" 5;
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
createNode transform -n "entityType2";
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
createNode CrowdEntityTypeNode -n "entityTypeShape2" -p "entityType2";
	setAttr -k off ".v";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dc" -type "float3" 0 1 1 ;
	setAttr -l on ".etid" 2;
	setAttr ".gch" -type "string" "/atomo/pipeline/tools/golaem/characterPack/5.2/golaem/characters/fortressSoldier.gcha";
	setAttr ".rti" -type "Int32Array" 1 0 ;
	setAttr ".rtwe" -type "Int32Array" 1 50 ;
	setAttr ".bf" 3;
	setAttr ".tsd" yes;
createNode transform -n "popTool2";
	setAttr ".t" -type "double3" -72.387901306152358 0 0 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode PopulationToolLocator -n "popToolShape2" -p "popTool2";
	setAttr -k off ".v";
	setAttr ".np" 75;
	setAttr ".npp" 75;
	setAttr ".dst" 1;
	setAttr ".nr" 46;
	setAttr ".cfn" -type "string" "crowdField1";
	setAttr ".psn" -type "string" "particleShape2";
	setAttr ".etw" -type "Int32Array" 1 50 ;
	setAttr ".etp" -type "doubleArray" 1 100 ;
	setAttr ".ethk" -type "Int32Array" 0 ;
	setAttr ".ethi" -type "Int32Array" 0 ;
	setAttr ".ethc" -type "vectorArray" 0 ;
	setAttr ".getw" -type "Int32Array" 0 ;
	setAttr ".getp" -type "doubleArray" 0 ;
	setAttr ".sb" -type "Int32Array" 0 ;
	setAttr ".pt" -type "vectorArray" 75 -69.885398864746094 0 -22.522499084472656 -74.890403747558594
		 0 -22.522499084472656 -72.888404846191406 0 15.515501022338867 -68.8843994140625
		 0 20.520500183105469 -76.892402648925781 0 3.5034997463226318 -75.891403198242187
		 0 21.521499633789063 -67.883399963378906 0 -4.5045003890991211 -75.891403198242187
		 0 5.5054998397827148 -68.8843994140625 0 0.50049972534179688 -75.891403198242187
		 0 -9.5095005035400391 -68.8843994140625 0 -0.50050032138824463 -72.888404846191406
		 0 8.5084991455078125 -76.892402648925781 0 -6.506500244140625 -69.885398864746094
		 0 -11.511501312255859 -71.887397766113281 0 11.511499404907227 -73.889404296875 0
		 -18.518501281738281 -67.883399963378906 0 6.5064997673034668 -71.887397766113281
		 0 -4.5045003890991211 -69.885398864746094 0 -12.512500762939453 -72.888404846191406
		 0 -9.5095005035400391 -76.892402648925781 0 14.514499664306641 -72.888404846191406
		 0 9.5095005035400391 -69.885398864746094 0 -5.505500316619873 -75.891403198242187
		 0 -10.510499954223633 -72.888404846191406 0 4.5044994354248047 -72.888404846191406
		 0 3.5034997463226318 -75.891403198242187 0 -8.5085010528564453 -69.885398864746094
		 0 -2.5025002956390381 -70.886398315429688 0 -10.510499954223633 -75.891403198242187
		 0 19.519500732421875 -70.886398315429688 0 19.519500732421875 -75.891403198242187
		 0 12.512500762939453 -72.888404846191406 0 -11.511501312255859 -74.890403747558594
		 0 13.513500213623047 -75.891403198242187 0 -6.506500244140625 -72.888404846191406
		 0 -7.5075006484985352 -67.883399963378906 0 -2.5025002956390381 -76.892402648925781
		 0 20.520500183105469 -71.887397766113281 0 7.5074996948242187 -69.885398864746094
		 0 -19.519500732421875 -68.8843994140625 0 5.5054998397827148 -71.887397766113281
		 0 19.519500732421875 -75.891403198242187 0 9.5095005035400391 -73.889404296875 0
		 -10.510499954223633 -70.886398315429688 0 -7.5075006484985352 -70.886398315429688
		 0 -17.517501831054687 -68.8843994140625 0 -17.517501831054687 -76.892402648925781
		 0 -16.516500473022461 -75.891403198242187 0 -5.505500316619873 -75.891403198242187
		 0 2.5024998188018799 -70.886398315429688 0 -5.505500316619873 -72.888404846191406
		 0 22.522499084472656 -72.888404846191406 0 -4.5045003890991211 -69.885398864746094
		 0 6.5064997673034668 -71.887397766113281 0 22.522499084472656 -67.883399963378906
		 0 -9.5095005035400391 -72.888404846191406 0 -17.517501831054687 -76.892402648925781
		 0 16.516500473022461 -67.883399963378906 0 4.5044994354248047 -68.8843994140625 0
		 11.511499404907227 -71.887397766113281 0 8.5084991455078125 -73.889404296875 0 6.5064997673034668 -76.892402648925781
		 0 -13.513500213623047 -68.8843994140625 0 9.5095005035400391 -68.8843994140625 0
		 -10.510499954223633 -72.888404846191406 0 -12.512500762939453 -70.886398315429688
		 0 14.514499664306641 -73.889404296875 0 -0.50050032138824463 -74.890403747558594
		 0 -0.50050032138824463 -76.892402648925781 0 -9.5095005035400391 -72.888404846191406
		 0 5.5054998397827148 -71.887397766113281 0 1.5014997720718384 -70.886398315429688
		 0 12.512500762939453 -68.8843994140625 0 -13.513500213623047 -69.885398864746094
		 0 12.512500762939453 ;
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
	setAttr ".et" -type "doubleArray" 75 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
		 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
		 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ;
	setAttr ".get" -type "doubleArray" 75 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".gpid" -type "doubleArray" 75 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 ;
	setAttr ".etc" -type "vectorArray" 75 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1
		 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 ;
	setAttr ".s" -type "vectorArray" 0 ;
	setAttr ".ply" -type "vectorArray" 0 ;
	setAttr ".tri" -type "vectorArray" 0 ;
	setAttr ".mp" -type "vectorArray" 0 ;
createNode transform -n "particle2";
createNode particle -n "particleShape2" -p "particle2";
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
	setAttr ".pos0" -type "vectorArray" 460 -69.885398864746094 0 -22.522499084472656 -74.890403747558594
		 0 -22.522499084472656 -72.888404846191406 0 15.515501022338867 -68.8843994140625
		 0 20.520500183105469 -76.892402648925781 0 3.5034997463226318 -75.891403198242187
		 0 21.521499633789063 -67.883399963378906 0 -4.5045003890991211 -75.891403198242187
		 0 5.5054998397827148 -68.8843994140625 0 0.50049972534179688 -75.891403198242187
		 0 -9.5095005035400391 -68.8843994140625 0 -0.50050032138824463 -72.888404846191406
		 0 8.5084991455078125 -76.892402648925781 0 -6.506500244140625 -69.885398864746094
		 0 -11.511501312255859 -71.887397766113281 0 11.511499404907228 -73.889404296875 0
		 -18.518501281738281 -67.883399963378906 0 6.5064997673034668 -71.887397766113281
		 0 -4.5045003890991211 -69.885398864746094 0 -12.512500762939451 -72.888404846191406
		 0 -9.5095005035400391 -76.892402648925781 0 14.514499664306641 -72.888404846191406
		 0 9.5095005035400391 -69.885398864746094 0 -5.505500316619873 -75.891403198242187
		 0 -10.510499954223633 -72.888404846191406 0 4.5044994354248047 -72.888404846191406
		 0 3.5034997463226318 -75.891403198242187 0 -8.5085010528564453 -69.885398864746094
		 0 -2.5025002956390381 -70.886398315429688 0 -10.510499954223633 -75.891403198242187
		 0 19.519500732421875 -70.886398315429688 0 19.519500732421875 -75.891403198242187
		 0 12.512500762939451 -72.888404846191406 0 -11.511501312255859 -74.890403747558594
		 0 13.513500213623049 -75.891403198242187 0 -6.506500244140625 -72.888404846191406
		 0 -7.5075006484985343 -67.883399963378906 0 -2.5025002956390381 -76.892402648925781
		 0 20.520500183105469 -71.887397766113281 0 7.5074996948242196 -69.885398864746094
		 0 -19.519500732421875 -68.8843994140625 0 5.5054998397827148 -71.887397766113281
		 0 19.519500732421875 -75.891403198242187 0 9.5095005035400391 -73.889404296875 0
		 -10.510499954223633 -70.886398315429688 0 -7.5075006484985343 -70.886398315429688
		 0 -17.517501831054687 -68.8843994140625 0 -17.517501831054687 -76.892402648925781
		 0 -16.516500473022461 -75.891403198242187 0 -5.505500316619873 -75.891403198242187
		 0 2.5024998188018799 -70.886398315429688 0 -5.505500316619873 -72.888404846191406
		 0 22.522499084472656 -72.888404846191406 0 -4.5045003890991211 -69.885398864746094
		 0 6.5064997673034668 -71.887397766113281 0 22.522499084472656 -67.883399963378906
		 0 -9.5095005035400391 -72.888404846191406 0 -17.517501831054687 -76.892402648925781
		 0 16.516500473022461 -67.883399963378906 0 4.5044994354248047 -68.8843994140625 0
		 11.511499404907228 -71.887397766113281 0 8.5084991455078125 -73.889404296875 0 6.5064997673034668 -76.892402648925781
		 0 -13.513500213623049 -68.8843994140625 0 9.5095005035400391 -68.8843994140625 0
		 -10.510499954223633 -72.888404846191406 0 -12.512500762939451 -70.886398315429688
		 0 14.514499664306641 -73.889404296875 0 -0.50050032138824463 -74.890403747558594
		 0 -0.50050032138824463 -76.892402648925781 0 -9.5095005035400391 -72.888404846191406
		 0 5.5054998397827148 -71.887397766113281 0 1.5014997720718384 -70.886398315429688
		 0 12.512500762939451 -68.8843994140625 0 -13.513500213623049 -69.885398864746094
		 0 12.512500762939451 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".vel0" -type "vectorArray" 460 1.2676390845990717 -0.27650640746912886
		 -0.16639708480852322 1.1942137960068098 -0.26050041553375602 -0.15678404827212986 1.2310179930318583
		 -0.26853130647353463 -0.16159056654032652 1.4447020623265454 -0.31511877089030887
		 -0.18965147795370335 1.3712767737342837 -0.29910276537521063 -0.17999266505285097 1.2941893759853007
		 -0.28229425655041568 -0.16987608850740843 1.2529906479721864 -0.27332065860505922
		 -0.16447447750124455 1.2026366470672687 -0.26234434471462076 -0.15787123692803148 1.1940306905489737
		 -0.26046751377180111 -0.15674470920892289 1.2344969967307438 -0.26927374188460429
		 -0.16204833018491668 1.3245848819860877 -0.28892610735141566 -0.17387007630645759 1.2099608653807112
		 -0.2639264903112355 -0.15882109649055606 1.3033446488771041 -0.28429983351827631
		 -0.17108916216557235 1.3374022640346119 -0.29173849274286645 -0.17555235770032643 1.3190917182510056
		 -0.28772304727297715 -0.17314909856622809 1.3454589041793987 -0.29349516072898119
		 -0.17660521408288379 1.3062743362024811 -0.28494356364348128 -0.17147826126347401 1.4155882945306113
		 -0.30879304952662856 -0.1858291515213755 1.3009642779252353 -0.28376339174727222
		 -0.17076872761435924 1.283386153972973 -0.27996538400856325 -0.16847990939140844 1.2670897682255633
		 -0.27638910553520263 -0.1663284202618347 1.3220214055763826 -0.28836248586401403
		 -0.1735381976641297 1.4106444471690376 -0.30769155575683349 -0.18516539423671977 1.3383177913237922
		 -0.29194162536015333 -0.17568968679370348 1.3211058782872025 -0.288183671940346 -0.17342375675298216 1.3330077330465464
		 -0.29075143988421892 -0.17496870905347398 1.3994750142410377 -0.30525396434939089
		 -0.18370055057403128 1.215087818200121 -0.26506517737715352 -0.15951346400299868 1.3038939652506121
		 -0.28440998289525582 -0.17115782671226087 1.2030028579829408 -0.26241157874991994
		 -0.15792845738360525 1.440673742254152 -0.31426332507948102 -0.18910216158019516 1.2711180882979567
		 -0.27726028697131327 -0.16685484845311338 1.2440184805382193 -0.27135370544471088
		 -0.16328429202531014 1.4177855600246441 -0.30927370135344823 -0.18610380970812959 1.3796996247947426
		 -0.30095956915857947 -0.18111418598209689 1.3615721844689723 -0.29698560851898115
		 -0.17872237093911328 1.2843016812621533 -0.28015278100056734 -0.16858862825699861 1.380798257541759
		 -0.30117986791253848 -0.1812286268932444 1.1927489523441213 -0.26018570302810029
		 -0.15657805463206428 1.3410643731913332 -0.29253671809812054 -0.1760558977093756 1.1872557886090394
		 -0.25897978192688309 -0.15584563280072 1.2147216072844489 -0.2649578890229527 -0.15943907741075278 1.443420324121693
		 -0.31487272293134166 -0.1894912606780968 1.3509520679144806 -0.29469106825047298
		 -0.17733763591422805 1.2451171132852354 -0.2715968923808994 -0.1634445093009167 1.1905516868500885
		 -0.25968073250766177 -0.15628050826308068 1.4300536256996603 -0.31194303560596459
		 -0.18772887064642468 1.25189201522517 -0.27307461064609201 -0.16433714840786753 1.3141478708894321
		 -0.28664730270819028 -0.17249678537268709 1.2304686766583504 -0.26839826891432561
		 -0.16151617994808062 1.2209471928508753 -0.26631401382005104 -0.16026305197101506 1.2335814694415634
		 -0.26909778898371495 -0.16195677745599865 1.2165526618628095 -0.26537273732586253
		 -0.15969084741527736 1.1975096942478587 -0.26121137969426012 -0.157196035552261 1.4289549929526439
		 -0.31168840457866132 -0.18759154155304764 1.4005736469880541 -0.3055000123083581
		 -0.1838378796674083 1.2696532446352682 -0.27695844906816164 -0.16667174299527732 1.3108519726483827
		 -0.28595064366157963 -0.17207335400144119 1.2500609606468094 -0.27268122001402234
		 -0.16409682249445767 1.4370116330974307 -0.31343935051921873 -0.18862150975337549 1.2141722909109407
		 -0.26482914299791172 -0.15937041286406425 1.3414305841070051 -0.292596799576473 -0.17607878589160511 1.3033446488771041
		 -0.28429840300688697 -0.17108916216557235 1.2407225822971699 -0.27064703281837477
		 -0.16287230474517897 1.2398070550079896 -0.27043960866691985 -0.16273497565180192 1.2667235573098912
		 -0.27630184434045263 -0.16628264389737568 1.2154540291157931 -0.26511524527578056
		 -0.15953063013967081 1.3901366358913985 -0.30322549919930075 -0.18247603282475255 1.1984252215370392
		 -0.26141594282293634 -0.15731476799757657 1.3602904462641201 -0.29672239442334181
		 -0.17857359775462148 1.3831786284936278 -0.30170629610381716 -0.18156050553557224 1.3612059735533002
		 -0.29691122192673525 -0.17867659457465426 1.3267821474801202 -0.28941534224657139
		 -0.17415617858432644 1.3015135942987432 -0.28389499879509189 -0.17083739216104776 1.4364623167239223
		 -0.31331632653973512 -0.18855284520668697 1.2097777599228752 -0.26388643599233386
		 -0.15879820830832655 1.2301024657426782 -0.26832817385624774 -0.16147612562917898 1.4121092908317261
		 -0.30802915644471873 -0.18537138787678537 1.4351805785190701 -0.31304452937575972
		 -0.18838118383996569 1.2907103722864155 -0.28153894653684192 -0.16942404690837565 1.2075804944288424
		 -0.26341150621107157 -0.15852355012157246 1.2751464083703501 -0.27813432943020261
		 -0.16737555459883469 1.4150389781571031 -0.30866144247880889 -0.18573759879245744 1.2925414268647759
		 -0.28194378126002634 -0.16967009486734286 1.1876219995247117 -0.25905702954190768
		 -0.15589140916517902 1.3676146645775624 -0.29831884513384999 -0.17953490140826081 1.2872313685875303
		 -0.28076647038659602 -0.16896056121822811 1.2555541243818913 -0.27386568344439938
		 -0.16481780023468717 1.2147216072844489 -0.26497505515962483 -0.15946196559298229 1.2297362548270061
		 -0.26824806521844446 -0.16143034926471997 1.3573607589387429 -0.2960786642981369
		 -0.17816161047449031 1.2229613528870718 -0.26677893002158792 -0.16054271694763186 1.3126830272267431
		 -0.28635118685059602 -0.1723194019604084 1.3584593916857592 -0.29631612918876804
		 -0.17829893956786738 1.3048094925397924 -0.2846002409100386 -0.17127226762340839 1.2595824444542849
		 -0.27475689203996084 -0.16534422842596586 1.2130736581639243 -0.26461027475534205
		 -0.15925597195291671 1.3793334138790705 -0.30086801642966143 -0.18106840961763784 1.2742308810811698
		 -0.27793262732430507 -0.16724394755101502 1.3397826349864808 -0.29223058866080087
		 -0.17587279225153954 1.1852416285728429 -0.25855205902146916 -0.15559386279619539 1.4046019670604477
		 -0.30638406834697285 -0.1843871960409165 1.3004149615517269 -0.28365753390446075
		 -0.17070006306767072 1.1932982687176297 -0.26030729649619455 -0.15664671917875281 1.2731322483341534
		 -0.27772520317285015 -0.16712950663986748 1.4139403454100867 -0.30842969963373512
		 -0.18561171379019517 1.2440184805382193 -0.27135799697887891 -0.16329859713920358 1.2280883057064815
		 -0.26786611867748955 -0.16120146744242489 1.3269652529379563 -0.28946970167936648
		 -0.17419623290322808 1.3965453269156607 -0.30464170547475156 -0.18333433965835913 1.414855872699267
		 -0.30861852713712856 -0.18572615470134271 1.2301024657426782 -0.26830814669679692
		 -0.16146468153806423 1.2786254120692353 -0.27890966660322719 -0.16786192847121173 1.3383177913237922
		 -0.29191587615514514 -0.17568968679370348 1.4088133925906767 -0.30730531768171054
		 -0.18493651241442469 1.4271239383742833 -0.31128213934408755 -0.18731688336629351 1.3934325341324476
		 -0.30394933796230894 -0.18292235237822799 1.3571776534809068 -0.29603574895645657
		 -0.17816161047449031 1.3980101705783492 -0.30496214002596467 -0.18351744511619519 1.4274901492899554
		 -0.3113937192324564 -0.18738554791298204 1.2355956294777599 -0.26953409495746494
		 -0.16218565927829373 1.1894530541030719 -0.25945757273092407 -0.15614317916970361 1.2024535416094326
		 -0.26228283272487896 -0.15783690465468722 1.3714598791921198 -0.29915426378522703
		 -0.18003844141731001 1.2453002187430715 -0.27165268232508383 -0.1634673974831462 1.1938475850911376
		 -0.26041315433900603 -0.15669249554321182 1.2432860587068748 -0.27118061356660023
		 -0.16319273929639208 1.3961791159999886 -0.30453584763194008 -0.18326567511167061 1.2832030485151369
		 -0.27988813639353866 -0.16843413302694943 1.1942137960068098 -0.26050756809070275
		 -0.1567726041810151 1.4042357561447754 -0.30632398686862039 -0.18434141967645748 1.2674559791412354
		 -0.27648494979828869 -0.16639708480852322 1.3225707219498908 -0.28848980137766567
		 -0.17362975039304776 1.4379271603866113 -0.31366537131873512 -0.18873595066452303 1.2780760956957271
		 -0.27877805955540752 -0.1677703757422937 1.3042601761662842 -0.28449295255583779
		 -0.17120360307671989 1.2024535416094326 -0.26229141579321502 -0.15783690465468722 1.2002562761154001
		 -0.26180504192083798 -0.15756224646793313 1.4448851677843817 -0.31516740827754658
		 -0.18966292204481813 1.3108519726483827 -0.28594206059324356 -0.17207335400144119 1.3401488459021529
		 -0.29234502957194841 -0.17591856861599856 1.3428954277696938 -0.29292867821880086
		 -0.17627905748611333 1.2590331280807765 -0.27462099345797314 -0.16525267569704782 1.3209227728293662
		 -0.28812788199616157 -0.17340086857075265 1.2601317608277929 -0.27488849908778051
		 -0.16541289297265438 1.2370604731404486 -0.26985452950867805 -0.1623916529183593 1.2161864509471374
		 -0.26529692022222728 -0.1596565151419331 1.3927001123011034 -0.30379770375503845
		 -0.18283079964930996 1.4443358514108733 -0.31505582838917773 -0.18960570158924431 1.2000731706575638
		 -0.26177786220444044 -0.15753935828570362 1.2401732659236615 -0.27052973088444854
		 -0.16280006392001709 1.41192618537389 -0.30799196314859578 -0.18534849969455583 1.3264159365644479
		 -0.28932665054043205 -0.17411040221986743 1.3377684749502841 -0.29179571319844022
		 -0.17559813406478544 1.2509764879359897 -0.27286861700602644 -0.16419981931449046 1.4302367311574964
		 -0.31198881197042361 -0.18772887064642468 1.4430541132060208 -0.3147640040657515
		 -0.18942259613140827 1.4240111455910702 -0.31061266001387444 -0.1869220622228345 1.323120038323399
		 -0.28861997791409599 -0.17367552675750678 1.328979412974153 -0.28987310589116155
		 -0.17444228086219529 1.3403319513599887 -0.2923478905947271 -0.17591856861599856 1.3359374203719234
		 -0.29141090563470662 -0.17536925224249036 1.2722167210449733 -0.27750919595305917
		 -0.16700362163760518 1.2625121317796617 -0.27540062216516575 -0.16571043934163798 1.3496703297096282
		 -0.29440782699538282 -0.17716597454750674 1.3027953325035957 -0.28416822647045664
		 -0.17099760943665432 1.2097777599228752 -0.2638878665037232 -0.15879820830832655 1.3672484536618903
		 -0.29825876365549753 -0.17948912504380179 1.4214476691813651 -0.31006048261758756
		 -0.18658446153494929 1.3932494286746115 -0.30391786671174337 -0.18289231163905176 1.2718505101293007
		 -0.27742479578108786 -0.16694640118203141 1.2031859634407769 -0.26246307715993633
		 -0.15792845738360525 1.3617552899268084 -0.29705713408844836 -0.17875670321245754 1.354980387986874
		 -0.29558370735742379 -0.17788695228773624 1.2249755129232685 -0.26719950037005513
		 -0.16078948016229375 1.2053832289348096 -0.26293371540703059 -0.15822600375258886 1.2026366470672687
		 -0.26233576164628469 -0.15787123692803148 1.3441771659745465 -0.29320333640555496
		 -0.17644499680727724 1.2941893759853007 -0.28229854808458371 -0.16988753259852318 1.3357543149140874
		 -0.29136226824746891 -0.17532347587803135 1.4166869272776277 -0.30903337544003839
		 -0.18598936879698205 1.2985839069733662 -0.28327558736350583 -0.17047118124537564 1.3108519726483827
		 -0.2859334775249075 -0.17207335400144119 1.4143065563257589 -0.30850122520320233
		 -0.18564604606353943 1.3247679874439235 -0.28896473115892796 -0.17390440857980186 1.2482299060684483
		 -0.27227924631361661 -0.16385077453549046 1.2645262918158584 -0.27581403995668624
		 -0.16598509752839208 1.2561034407553997 -0.27400444304916577 -0.1648864647813757 1.2385253168031372
		 -0.27014349280932559 -0.16256331428508061 1.2317504148632028 -0.26867864914663708
		 -0.16168211926924456 1.3710936682764476 -0.29905985003353031 -0.17996977687062146 1.2344969967307438
		 -0.26929376904405511 -0.16205977427603144 1.2141722909109407 -0.26486347527125598
		 -0.15939330104629376 1.4274901492899554 -0.3113679700274482 -0.18738554791298204 1.4357298948925783
		 -0.31317899744635808 -0.18846415350054763 1.3472899587577594 -0.29388425982688282
		 -0.17683409590517887 1.4179686654824799 -0.30931089464957118 -0.1861266978903591 1.2048339125613017
		 -0.26280926091615764 -0.15815733920590033 1.2139891854531046 -0.26480196328151417
		 -0.15934752468183477 1.1927489523441213 -0.26017711995976422 -0.15657805463206428 1.4174193491089719
		 -0.3091821486245302 -0.18605803334367055 1.3901366358913985 -0.30321119408540731
		 -0.18246458873363783 1.2088622326336949 -0.26370905258005517 -0.15870665557940852 1.4340819457720535
		 -0.31283281369013677 -0.18825529883770337 1.2480468006106125 -0.272243483528883 -0.16382788635326095 1.274780197454678
		 -0.27804849874684195 -0.16732405618881829 1.3513182788301528 -0.29477975995661232
		 -0.17739485636980182 1.3610228680954639 -0.29686544556227623 -0.17864226230131 1.3172606636726447
		 -0.28733394817507552 -0.17292021674393299 1.3428954277696938 -0.29292581719602218
		 -0.17628477953167068 1.3796996247947426 -0.30093381995357127 -0.18109129779986735 1.3822631012044475
		 -0.30152891269153848 -0.18145750871553948 1.2566527571289077 -0.27409742628947315
		 -0.16493224114583471 1.3395995295286447 -0.29221628354690743 -0.17584990406931003 1.3643187663365133
		 -0.29760358943917786 -0.17907713776367065 1.3331908385043825 -0.29081009085118203
		 -0.17500304132681824 1.2910765832020876 -0.28162620773159192 -0.16946410122727729 1.2564696516710716
		 -0.27405594145918216 -0.16493224114583471 1.3320922057573661 -0.29056404289221482
		 -0.17485426814232644 1.3163451363834646 -0.28714225964890339 -0.17280577583278545 1.4371947385552668
		 -0.31347940483812037 -0.188644397935605 1.3848265776141524 -0.30207250701948929 -0.18177794326675259 1.2370604731404486
		 -0.26984451592895264 -0.1623916529183593 1.1918334250549407 -0.25995396018302652
		 -0.15643500349312986 1.4360961058082504 -0.3132734111980548 -0.18852995702445743 1.3738402501439886
		 -0.29968069197650571 -0.18034170983185097 1.3496703297096282 -0.29441927108649757
		 -0.17715453045639198 1.217834400067662 -0.26562879886455515 -0.15985106469088392 1.3829955230357918
		 -0.30166910280769421 -0.18154906144445751 1.4353636839769062 -0.31310174983133349
		 -0.18841551611330992 1.3370360531189398 -0.29165552308228448 -0.17550658133586741 1.3082884962386778
		 -0.28537843910584193 -0.17173003126799857 1.3798827302525789 -0.30098531836358766
		 -0.18113707416432637 1.4218138800970377 -0.31014917432372691 -0.18663023789940827 1.2528075425143503
		 -0.27328918735449365 -0.16445158931901505 1.3315428893838579 -0.29045389351523532
		 -0.17477415950452316 1.4216307746392014 -0.31011484205038264 -0.18663023789940827 1.4014891742772344
		 -0.30570886697120236 -0.18397520876078535 1.2694701391774319 -0.27689121503286246
		 -0.1666259666308183 1.241088793212842 -0.27073715503590345 -0.16291808110963801 1.363586344505169
		 -0.29745481625468606 -0.17898558503475262 1.3121337108532352 -0.28620098315471487
		 -0.17223071025426906 1.3093871289856942 -0.2856101819509157 -0.17186736036137562 1.2976683796841859
		 -0.28306530218927223 -0.17034529624311334 1.400390541530218 -0.30545423594389909
		 -0.1838378796674083 1.4307860475310046 -0.31210325288157115 -0.18782042337534272 1.4282225711212997
		 -0.31155393650806296 -0.1874999888241296 1.4309691529888406 -0.31215189026880885
		 -0.18784760309174023 1.3747557774331689 -0.29988668561657128 -0.18046187278855588 1.2500609606468094
		 -0.27265976234318218 -0.16408251738056423 1.2445677969117273 -0.27146814635585842
		 -0.16336440066311342 1.3084716016965141 -0.2854356595614157 -0.17176436354134283 1.2713011937557928
		 -0.27731178538132967 -0.1669006248175724 1.3163451363834646 -0.28715370374001814
		 -0.17280577583278545 1.194946217838154 -0.26064775820685848 -0.15685271281881838 1.4247435674224145
		 -0.31078146035781706 -0.18704222517953945 1.1854247340306787 -0.25857494720369867
		 -0.15559386279619539 1.2984008015155302 -0.2832326720218255 -0.17042540488091662 1.2453002187430715
		 -0.27162407209729694 -0.16345595339203145 1.1859740504041869 -0.25870512374012899
		 -0.15568541552511345 1.2713011937557928 -0.27731321589271901 -0.16688059765812158 1.3390502131551365
		 -0.29209325956742382 -0.17578123952262151 1.3557128098182183 -0.29571245338246477
		 -0.17793272865219523 1.2608641826591371 -0.27502010613560018 -0.16550444570157241 1.3615721844689723
		 -0.29700563567843197 -0.17873238451883869 1.3740233556018246 -0.29971788527262866
		 -0.18036459801408047 1.2324828366945473 -0.26882313079696085 -0.16177367199816259 1.3377684749502841
		 -0.29178999115288284 -0.17559813406478544 1.4183348763981525 -0.30936525408236626
		 -0.18617247425481812 1.3472899587577594 -0.29387853778132544 -0.17683409590517887 1.2269896729594651
		 -0.26766012503742398 -0.16106413834904784 1.2328490476102192 -0.26893041915116167
		 -0.16183661449929371 1.1987914324527114 -0.261501773506297 -0.15735625282786755 1.2050170180191375
		 -0.26284216267811256 -0.15815733920590033 1.3855589994454969 -0.3022441683862106
		 -0.18188666213234275 1.3679808754932343 -0.29837892661220244 -0.17955778959049032 1.36633292637271
		 -0.29803560387875982 -0.17935179595042475 1.1887206322717281 -0.25929020289837079
		 -0.15604018234967082 1.3112181835640548 -0.28601072513993209 -0.17211913036590021 1.2328490476102192
		 -0.26891897506004692 -0.1618194483626216 1.2877806849610385 -0.28089521641163701
		 -0.16905211394714614 1.2854003140091697 -0.28039739844814521 -0.16873167939593303 1.4304198366153325
		 -0.31202886628932525 -0.1877746470108837 1.3344725767092347 -0.29110334568599761
		 -0.1751861467846543 1.2897948449972352 -0.28136013261317389 -0.16932677213390024 1.4058837052652999
		 -0.3066701706248417 -0.18454741331652305 1.28631584129835 -0.28056476828069848 -0.16884612030708057 1.3747557774331689
		 -0.29987810254823521 -0.18046187278855588 1.2077635998866785 -0.26344440797302648
		 -0.15854643830380197 1.3835448394093 -0.30180070985551388 -0.18161772599114603 1.2932738486961204
		 -0.28210113751285421 -0.16976164759626089 1.3214720892028744 -0.28826664160092796
		 -0.17347382465160921 1.2782592011535632 -0.27882383591986654 -0.1677703757422937 1.3005980670095627
		 -0.28369043566641566 -0.17072295124990022 1.2088622326336949 -0.26367042877254288
		 -0.15866087921494951 1.1854247340306787 -0.25857780822647736 -0.15559386279619539 1.2623290263218256
		 -0.27536485938043215 -0.16571043934163798 1.2745970919968419 -0.2780370546557272
		 -0.16731833414326092 1.3645018717943491 -0.29762647762140737 -0.17912291412812967 1.4260253056272667
		 -0.31106470161290722 -0.18720244245514597 1.3364867367454316 -0.29153249910280088
		 -0.17543791678917889 1.34912101333612 -0.29426763687922708 -0.17708586590970346 1.2262572511281209
		 -0.26748846367070267 -0.16097258562012981 1.2531737534300225 -0.27336500445812889
		 -0.16450880977458882 1.3216551946607105 -0.28827951620343206 -0.17349242129967068 1.3742064610596607
		 -0.29975507856875161 -0.1803817641507526 1.4011229633615625 -0.30561445321950564
		 -0.18390654421409683 1.2930907432382843 -0.28207538830784601 -0.16975020350514614 1.3542479661555298
		 -0.29540060189958772 -0.17774962319435919 1.2531737534300225 -0.27335212985562479
		 -0.16449736568347406 1.2290038329956618 -0.26806782078338709 -0.16131590835357243 1.4309691529888406
		 -0.31211755799546459 -0.18782042337534272 1.3390502131551365 -0.29209039854464514
		 -0.17578123952262151 1.3943480614216279 -0.30414388751125976 -0.18303107124381815 1.3687132973245788
		 -0.29856775411559588 -0.17967223050163786 1.3952635887108082 -0.30435560319688271
		 -0.18315123420052307 1.4077147598436606 -0.30707357483663678 -0.18479918332104764 1.3987425924096937
		 -0.3051280793471286 -0.18360899784511325 1.2828368375994648 -0.27981231928990341
		 -0.16838835666249041 1.2260741456702848 -0.2674569924201371 -0.1609496974379003 1.31469718726294
		 -0.28678177077878864 -0.17257689401049037 1.2258910402124488 -0.26739977196456333
		 -0.16090392107344129 1.4042357561447754 -0.30630109868639088 -0.18432425353978535 1.4282225711212997
		 -0.31154535343972689 -0.1874999888241296 1.2476805896949403 -0.27214191722023956
		 -0.16378783203435932 1.3553465989025462 -0.29563520576744018 -0.17790984046996575 1.3154296090942843
		 -0.28691766936077634 -0.17265700264829364 1.251708909767334 -0.27303026479302234
		 -0.16429137204340849 1.2244261965497605 -0.26709364252724366 -0.16073225970671998 1.3584593916857592
		 -0.29632757327988279 -0.17832182775009689 1.4450682732422175 -0.31523035077867773
		 -0.18969725431816237 1.3341063657935628 -0.29102037602541564 -0.17512892632908053 1.3379515804081199
		 -0.29183004547178448 -0.17561530020145755 1.3947142723373001 -0.30424688433129254
		 -0.18308829169939192 1.2387084222609732 -0.27021215735601412 -0.16259764655842487 1.4276732547477915
		 -0.31143377355135804 -0.18740843609521152 1.215087818200121 -0.26506088584298548
		 -0.1595077419574413 1.266357346394219 -0.27624748490765755 -0.16623686753291669 1.3835448394093
		 -0.30177496065050569 -0.18159483780891653 1.212158130874744 -0.26439569804694041
		 -0.15910791402411958 1.3053588089133006 -0.28473613949202636 -0.17134093217009694 1.3840941557828079
		 -0.30190084565276798 -0.18168639053783456 1.3064574416603172 -0.28498934000794029
		 -0.17150114944570349 1.4058837052652999 -0.30668447573873514 -0.18454741331652305 1.3399657404443168
		 -0.2922992532074894 -0.17589568043376905 1.1987914324527114 -0.26149319043796093
		 -0.15737914101009706 1.2284545166221537 -0.26798199010002643 -0.16126727096633472 1.4174193491089719
		 -0.30917642657897282 -0.18605803334367055 1.2169188727784817 -0.26546142903200187
		 -0.15975951196196589 1.4029540179399227 -0.30603502356797285 -0.18415831421862144 1.2537230698035309
		 -0.27345655718704692 -0.16456603023016261 1.186157155862023 -0.2587280119223585 -0.15570830370734295 1.3928832177589394
		 -0.30382631398282534 -0.18283079964930996 1.3097533399013663 -0.28571317877094848
		 -0.17193602490806414 1.2233275638027441 -0.26684044201132973 -0.16058348652222815 1.3855589994454969
		 -0.30221269713564503 -0.18186949599567065 1.2412718986706781 -0.27075002963840755
		 -0.16291808110963801 1.366516031830546 -0.29808996331155491 -0.17937468413265426 1.2879637904188743
		 -0.28092811817359192 -0.16905211394714614 1.3615721844689723 -0.29700277465565328
		 -0.17871092684799852 1.2421874259598584 -0.27094887072152646 -0.16305541020301503 1.4454344841578897
		 -0.31527612714313674 -0.18973158659150663 1.2346801021885798 -0.26931379620350593
		 -0.16204833018491668 1.2991332233468744 -0.28339002827465337 -0.17051695760983465 1.3775023593007101
		 -0.30047033426342373 -0.18081663961311328 1.2800902557319238 -0.27920864348360014
		 -0.16802214574681829 1.1954955342116622 -0.2607807957660675 -0.15693282145662166 1.2912596886599237
		 -0.28164480437965339 -0.16948698940950679 1.3742064610596607 -0.29974935652319423
		 -0.1803817641507526 1.1848754176571703 -0.25847624191783392 -0.1555480864317364 1.386474526734677
		 -0.30245016202627617 -0.18200682508904767 1.2581176007915962 -0.27442930493180101
		 -0.16514967887701504 1.4375609494709387 -0.31358526268093184 -0.18869017430006399 1.2923583214069401
		 -0.2819037269411247 -0.16964434566233466 1.2275389893329731 -0.26774452520939529
		 -0.16112135880462161 1.2630614481531699 -0.27551363256492395 -0.16580199207055599 1.2542723861770388
		 -0.2736110524170961 -0.16465758295908062 1.3060912307446453 -0.28487776011957144
		 -0.17143248489901497 1.2407225822971699 -0.2706513243525428 -0.16287230474517897 1.3209227728293662
		 -0.28813074301894026 -0.17339514652519528 1.3093871289856942 -0.28562019553064111
		 -0.17189024854360513 1.4410399531698239 -0.31433485064894823 -0.18917082612688368 1.3758544101801853
		 -0.30013559459831718 -0.18061064597304768 1.2073973889710063 -0.26338146547189534
		 -0.15847777375711344 1.2489623278997928 -0.27242515847532972 -0.16393946624162981 1.3410643731913332
		 -0.29252813502978448 -0.1760558977093756 1.3914183740962509 -0.30351732352272698
		 -0.18264769419147389 1.4022215961085789 -0.30588052833792367 -0.18406676148970336 1.1876219995247117
		 -0.25906847363302243 -0.15591429734740853 1.4454344841578897 -0.31527326612035805
		 -0.18972014250039188 1.3181761909618253 -0.28754280283791978 -0.17303465765508053 1.2879637904188743
		 -0.28094814533304274 -0.16907500212937565 1.4452513787000536 -0.31523321180145641
		 -0.18969725431816237 1.2116088145012358 -0.26428411815857156 -0.15902709013062163 1.2447509023695631
		 -0.27151678374309612 -0.16339873293645768 1.3950804832529722 -0.30429552171853025
		 -0.1831169019271788 1.3811644684574311 -0.30128286473257126 -0.18132017962216243 1.3996581196988738
		 -0.30529115764551384 -0.18372343875626077 1.4395751095071356 -0.31400297200662036
		 -0.18896483248681811 1.2670897682255633 -0.27639196655798132 -0.16630553207960519 1.3002318560938908
		 -0.28360460498305501 -0.1706542867032117 1.1898192650187442 -0.25952194574344456
		 -0.15617751144304787 1.2923583214069401 -0.28190086591834601 -0.16964720668511335 1.360656657179792
		 -0.29678247590169426 -0.17859648593685098 1.2127074472482522 -0.26452444407198139
		 -0.15918730740622819 1.2839354703464811 -0.28006981133998538 -0.16854857393809697 1.4051512834339557
		 -0.30648706516700563 -0.18443297240537551 1.2355956294777599 -0.26953838649163298
		 -0.16220854746052324 1.280639572105432 -0.27935169462253456 -0.16809081029350681 1.3293456238898251
		 -0.28998182475675172 -0.17449950131776906 1.2897948449972352 -0.28134725801066979
		 -0.16930388395167073 1.2854003140091697 -0.2804002594709239 -0.16873167939593303 1.3937987450481195
		 -0.30404089069122697 -0.182968128742687 1.2877806849610385 -0.28088949436607963 -0.16902922576491664 1.3353881039984152
		 -0.29130647830328449 -0.17532347587803135 1.4208983528078571 -0.30994318068366133
		 -0.18653868517049024 1.2225951419713996 -0.26667879422433383 -0.16049193379331014 1.3200072455401859
		 -0.28793619346998944 -0.17328642765960511 1.1846923121993345 -0.25841043839392408
		 -0.15550231006727738 1.2705687719244485 -0.27714727657155508 -0.16676329572419535 1.3170775582148089
		 -0.28729103283339519 -0.17288588447058872 1.2214965092243832 -0.26642988524258793
		 -0.1603546046999331 1.2586669171651044 -0.27453945430878052 -0.16520689933258881 1.2938231650696286
		 -0.2822398971176206 -0.16985320032517892 1.443420324121693 -0.31486700088578429 -0.18946837249586729 1.3143309763472679
		 -0.28671167572071077 -0.17253111764603135 1.2399901604658257 -0.27049825963388296
		 -0.16278075201626094 1.3421630059383496 -0.29275987787485824 -0.17617606066608052 1.1998900651997275
		 -0.26172207226025601 -0.15751647010347411 1.423278723759726 -0.31046388682938264
		 -0.18681334335724431 1.3829955230357918 -0.30169199098992372 -0.1815519224672362 1.3302611511790057
		 -0.29017780481709188 -0.17463683041114611 1.2971190633106775 -0.28295086127812469
		 -0.17027663169642482 1.1936644796333016 -0.26038883564538717 -0.15669249554321182 1.3236693546969072
		 -0.28874014087080091 -0.17375563539531003 1.2117919199590721 -0.26433847759136664
		 -0.15907286649508065 1.4086302871328409 -0.30727384643114497 -0.18489073604996567 1.1914672141392688
		 -0.25991247535273554 -0.15641783735645773 1.4042357561447754 -0.30630395970916957
		 -0.18432711456256404 1.2929076377804485 -0.28203533398894437 -0.16972159327735925 1.1923827414284491
		 -0.26011417745863308 -0.15653227826760527 1.3958129050843164 -0.30446718308525156
		 -0.18321989874721159 1.3156127145521204 -0.28698776441885421 -0.17270277901275266 1.2116088145012358
		 -0.26427124355606746 -0.15902709013062163 1.4141234508679228 -0.30845258781596463
		 -0.18562315788130992 1.3502196460831364 -0.29450796279263691 -0.17722891704863789 1.1857909449463508
		 -0.25866506942122736 -0.15566252734288394 1.2420043205020224 -0.27093027407346498
		 -0.16303252202078553 1.3341063657935628 -0.29099891835457548 -0.17511748223796578 1.3504027515409724
		 -0.29457948836210412 -0.17729185954976903 1.1969603778743507 -0.26109264724894454
		 -0.15711592691445772 1.294921797816645 -0.28245161280324355 -0.16997336328188384 1.2984008015155302
		 -0.28322694997626813 -0.17044829306314613 1.3053588089133006 -0.28475187511730915
		 -0.17134093217009694 1.4183348763981525 -0.30938528124181708 -0.18618105732315415 1.374938882891005
		 -0.29991815686713685 -0.18049620506190017 1.3981932760361853 -0.30499361127653024
		 -0.18351744511619519 1.3412474786491693 -0.29258535548535824 -0.17606734180049036 1.3557128098182183
		 -0.29571245338246477 -0.17793272865219523 1.2767943574908749 -0.27851198443698949
		 -0.16758727028445763 ;
	setAttr ".acc0" -type "vectorArray" 460 30.423338030377717 -6.636153779259093
		 -3.9935300354045578 28.661131104163431 -6.2520099728101455 -3.7628171585311168 29.544431832764609
		 -6.4447513553648319 -3.8781735969678368 34.672849495837092 -7.5628505013674125 -4.5516354708888809 32.910642569622809
		 -7.1784663690050561 -4.3198239612684235 31.060545023647219 -6.7750621572099767 -4.0770261241778023 30.071775551332475
		 -6.5596958065214217 -3.9473874600298697 28.863279529614452 -6.2962642731508991 -3.7889096862727558 28.656736573175369
		 -6.2512203305232275 -3.7618730210141496 29.627927921537857 -6.4625698052305038 -3.8891599244380006 31.7900371676661
		 -6.9342265764339759 -4.1728818313549825 29.039060769137073 -6.3342357674696528 -3.8117063157733457 31.280271573050495
		 -6.8231960044386319 -4.1061398919737364 32.097654336830686 -7.0017238258287948 -4.2132565848078345 31.658201238024137
		 -6.9053531345514516 -4.1555783655894736 32.29101370030557 -7.0438838574955485 -4.2385251379892113 31.350584068859547
		 -6.8386455274435507 -4.1154782703233757 33.974119068734673 -7.4110331886390863 -4.4598996365130121 31.223142670205643
		 -6.8103214019345337 -4.0984494627446217 30.801267695351353 -6.7191692162055183 -4.0435178253938027 30.410154437413521
		 -6.6333385328448635 -3.9918820862840327 31.728513733833186 -6.9206996607363367 -4.1649167439391128 33.855466732056904
		 -7.3845973381640047 -4.4439694616812746 32.119626991771014 -7.00659900864368 -4.2165524830488836 31.706541078892855
		 -6.9164081265683039 -4.1621701620715719 31.992185593117114 -6.9780345572212541 -4.1992490172833756 33.587400341784907
		 -7.3260951443853823 -4.4088132137767504 29.162107636802908 -6.3615642570516853 -3.8283231360719689 31.293455166014692
		 -6.8258395894861401 -4.107787841094261 28.872068591590583 -6.2978778899980794 -3.7902829772065263 34.57616981409965
		 -7.5423198019075457 -4.5384518779246843 30.506834119150959 -6.654246887311519 -4.0045163628747211 29.856443532917261
		 -6.5124889306730616 -3.9188230086074434 34.026853440591459 -7.4225688324827583 -4.4664914329951104 33.112790995073823
		 -7.2230296598059089 -4.3467404635703248 32.677732427255336 -7.1276546044555475 -4.2893369025387189 30.82324035029168
		 -6.7236667440136166 -4.0461270781679666 33.139158181002216 -7.2283168299009244 -4.3494870454378658 28.62597485625891
		 -6.2444568726744079 -3.757873311169543 32.185544956591997 -7.020881234354893 -4.2253415450250147 28.494138926616944
		 -6.2155147662451951 -3.7402951872172809 29.153318574826777 -6.3589893365508656 -3.8265378578580673 34.642087778920633
		 -7.5569453503522004 -4.5477902562743235 32.422849629947535 -7.0725856380113514 -4.2561032619414734 29.882810718845658
		 -6.5183254171415861 -3.9226682232220007 28.573240484402124 -6.2323375801838834 -3.750732198313937 34.32128701679185
		 -7.4866328545431502 -4.5054928955141929 30.045408365404079 -6.5537906555062087 -3.9440915617888201 31.539548901346365
		 -6.8795352649965666 -4.1399228489444901 29.531248239800412 -6.4415584539438155 -3.8763883187539352 29.302732628421005
		 -6.3915363316812259 -3.8463132473043617 29.60595526659753 -6.4583469356091596 -3.8869626589439679 29.197263884707432
		 -6.3689456958207016 -3.832580337966657 28.740232661948617 -6.2690731126622437 -3.7727048532542642 34.294919830863456
		 -7.4805217098878716 -4.5021969972731437 33.6137675277133 -7.3320002954005954 -4.4121091120177995 30.471677871246438
		 -6.6470027776358798 -4.0001218318866556 31.460447343561185 -6.8628154478779111 -4.1297604960345886 30.001463055523427
		 -6.5443492803365366 -3.9383237398669841 34.48827919433834 -7.5225444124612499 -4.5269162340810123 29.14013498186258
		 -6.3558994319498821 -3.8248899087375423 32.194334018568128 -7.022323189835352 -4.2258908613985229 31.280271573050495
		 -6.8231616721652877 -4.1061398919737364 29.777341975132082 -6.4955287876409953 -3.908935313884295 29.75536932019175
		 -6.4905506080060773 -3.9056394156432463 30.40136537543739 -6.6312442641708635 -3.9907834535370159 29.170896698779039
		 -6.3627658866187344 -3.8287351233520992 33.363279261393565 -7.2774119807832189 -4.3794247877940622 28.762205316888945
		 -6.2739826277504731 -3.7755544319418375 32.646970710338877 -7.1213374661602034 -4.2857663461109157 33.196287083847068
		 -7.2409511064916128 -4.3574521328537346 32.668943365279205 -7.1258693262416459 -4.2882382697917025 31.842771539522889
		 -6.9459682139177135 -4.1797482860238349 31.23632626316984 -6.8134799710822058 -4.1000974118651463 34.475095601374143
		 -7.5195918369536434 -4.5252682849604877 29.034666238149008 -6.3332744638160134 -3.8111569993998375 29.522459177824281
		 -6.4398761725499467 -3.8754270151002959 33.890622979961428 -7.3926997546732514 -4.4489133090428483 34.444333884457684
		 -7.5130687050182337 -4.5211484121591763 30.977048934873977 -6.7569347168842064 -4.0661771258010155 28.981931866292221
		 -6.3218761490657185 -3.8045652029177393 30.603513800888404 -6.6752239063248631 -4.0170133103720325 33.960935475770476
		 -7.4078746194914142 -4.4577023710189794 31.020994244754629 -6.7666507502406326 -4.0720822768162286 28.502927988593076
		 -6.2173687090057852 -3.7413938199642969 32.822751949861498 -7.1596522832123997 -4.3088376337982597 30.893552846100729
		 -6.738395289278305 -4.0550534692374747 30.133298985165393 -6.5727764026655855 -3.9556272056324921 29.153318574826777
		 -6.3594013238309968 -3.8270871742315751 29.51367011584815 -6.437953565242668 -3.874328382353279 32.576658214529829
		 -7.1058879431552855 -4.2758786513877682 29.351072469289729 -6.402694320518111 -3.853025206743165 31.50439265344184
		 -6.8724284844143044 -4.1356656470498017 32.603025400458222 -7.111587100530433 -4.2791745496288174 31.315427820955019
		 -6.8304057818409269 -4.1105344229618019 30.229978666902831 -6.5941654089590607 -3.968261482223181 29.113767795934187
		 -6.35064659412821 -3.8221433268700018 33.104001933097692 -7.2208323943118753 -4.3456418308233085 30.581541145948076
		 -6.6703830557833221 -4.0138547412243604 32.154783239675538 -7.0135341278592209 -4.2209470140369492 28.445799085748224
		 -6.2052494165152607 -3.7342527071086904 33.710447209450741 -7.3532176403273484 -4.4252927049819961 31.209959077241447
		 -6.8077808137070583 -4.0968015136240972 28.639158449223107 -6.2473751159086701 -3.7595212602900672 30.555173960019683
		 -6.6654048761484042 -4.0111081593568194 33.934568289842083 -7.4023127912096429 -4.4546811309646843 29.856443532917261
		 -6.5125919274930943 -3.919166331340886 29.47411933695556 -6.4287868482597501 -3.8688352186181976 31.847166070510951
		 -6.9472728403047954 -4.1807095896774742 33.517087845975858 -7.3114009313940382 -4.4000241518006193 33.956540944782411
		 -7.4068446512910864 -4.4574277128322253 29.522459177824281 -6.439395520723127 -3.8751523569135418 30.687009889661649
		 -6.693831998477453 -4.0286862833090815 32.119626991771014 -7.0059810277234833 -4.2165524830488836 33.811521422176249
		 -7.3753276243610548 -4.4384762979461927 34.250974520982801 -7.4707713442581021 -4.4956052007910445 33.442380819178744
		 -7.2947841110954164 -4.3901364570774719 32.572263683541763 -7.1048579749549576 -4.2758786513877682 33.552244093880383
		 -7.3190913606231538 -4.4044186827886849 34.259763582958932 -7.4734492615789554 -4.4972531499115691 29.654295107466247
		 -6.4688182789791595 -3.8924558226790498 28.546873298473731 -6.2269817455421785 -3.747436300072887 28.858884998626387
		 -6.2947879853970958 -3.7880857117124935 32.915037100610874 -7.1797023308454495 -4.3209225940154399 29.88720524983372
		 -6.5196643758020123 -3.9232175395955089 28.652342042187303 -6.2499157041361455 -3.760619893037084 29.838865408964999
		 -6.5083347255984059 -3.9166257431134106 33.508298783999727 -7.3088603431665629 -4.3983762026800948 30.796873164363287
		 -6.7173152734449282 -4.0424191926467863 28.661131104163431 -6.2521816341768668 -3.7625425003443622 33.70165814747461
		 -7.3517756848468894 -4.4241940722349797 30.418943499389652 -6.6356387951589291 -3.9935300354045578 31.741697326797379
		 -6.923755233063976 -4.1671140094331465 34.510251849278667 -7.5279689116496433 -4.5296628159485532 30.673826296697452
		 -6.6906734293297809 -4.0264890178150488 31.302244227990823 -6.8278308613401073 -4.1088864738412774 28.858884998626387
		 -6.2949939790371614 -3.7880857117124935 28.8061506267696 -6.2833210061001123 -3.7814939152303952 34.677244026825157
		 -7.5640177986611183 -4.551910129075635 31.460447343561185 -6.8626094542378455 -4.1297604960345886 32.163572301651669
		 -7.0162807097267619 -4.2220456467839655 32.229490266472652 -7.0302882772512207 -4.2306973796667195 30.216795073938641
		 -6.5909038429913558 -3.9660642167291482 31.702146547904789 -6.9150691679078777 -4.1616208456980637 30.243162259867031
		 -6.5973239781067328 -3.9699094313437047 29.689451355370771 -6.4765087082082742 -3.897399670040623 29.188474822731301
		 -6.3671260853334557 -3.8317563634063943 33.424802695226482 -7.2911448901209228 -4.3879391915834391 34.664060433860961
		 -7.5613398813402659 -4.5505368381418645 28.801756095781535 -6.2826686929065714 -3.7809445988568871 29.764158382167885
		 -6.4927135412267658 -3.9072015340804103 33.886228448973363 -7.3918071155662988 -4.4483639926693401 31.833982477546755
		 -6.9438396129703692 -4.1786496532768185 32.106443398806817 -7.0030971167625653 -4.2143552175548509 30.023435710463755
		 -6.5488468081446349 -3.940795663547771 34.325681547779915 -7.4877314872901684 -4.5054928955141929 34.633298716944502
		 -7.5543360975780365 -4.546142307153799 34.176267494185687 -7.4547038403329875 -4.4861294933480282 31.754880919761575
		 -6.9268794699383038 -4.1682126421801629 31.895505911379672 -6.9569545413878773 -4.1866147406926872 32.167966832639735
		 -7.0163493742734504 -4.2220456467839655 32.062498088926162 -6.9938617352329588 -4.208862053819769 30.533201305079356
		 -6.6602207028734206 -4.0080869193025244 30.300291162711883 -6.6096149319639785 -3.977050544199312 32.392087913031077
		 -7.0657878478891876 -4.2519833891401619 31.267087980086295 -6.8200374352909598 -4.1039426264797036 29.034666238149008
		 -6.3333087960893577 -3.8111569993998375 32.813962887885367 -7.1582103277319407 -4.3077390010512433 34.11474406035277
		 -7.4414515828221024 -4.4780270768387824 33.437986288190679 -7.2940288010818417 -4.3894154793372424 30.524412243103225
		 -6.6581950987461092 -4.0067136283687539 28.876463122578649 -6.2991138518384728 -3.7902829772065263 32.682126958243401
		 -7.1293712181227606 -4.2901608770989812 32.519529311684977 -7.0940089765781709 -4.2692868549056699 29.399412310158446
		 -6.4127880088813241 -3.8589475238950506 28.929197494435435 -6.310409169768735 -3.7974240900621328 28.863279529614452
		 -6.2960582795108335 -3.7889096862727558 32.260251983389111 -7.036880073733319 -4.2346799233746539 31.060545023647219
		 -6.7751651540300095 -4.0773007823645564 32.058103557938097 -6.9926944379392539 -4.2077634210727526 34.000486254663066
		 -7.4168010105609214 -4.4637448511275695 31.166013767360791 -6.7986140967241404 -4.0913083498890153 31.460447343561185
		 -6.8624034605977799 -4.1297604960345886 33.943357351818214 -7.4040294048768578 -4.4555051055249466 31.794431698654165
		 -6.935153547814271 -4.1737058059152448 29.957517745642768 -6.534701911526799 -3.9324185888517711 30.348631003580604
		 -6.6195369589604702 -3.9836423406814094 30.146482578129589 -6.5761066331799789 -3.9572751547530167 29.724607603275295
		 -6.4834438274238151 -3.9015195428419354 29.562009956716871 -6.4482875795192909 -3.8803708624618696 32.906248038634743
		 -7.1774364008047282 -4.3192746448949153 29.627927921537857 -6.4630504570573235 -3.8894345826247543 29.14013498186258
		 -6.3567234065101443 -3.8254392251110505 34.259763582958932 -7.4728312806587587 -4.4972531499115691 34.457517477421881
		 -7.5162959387125934 -4.5231396840131435 32.334959010186225 -7.0532222358451877 -4.2440183017242932 34.031247971579525
		 -7.4234614715897091 -4.4670407493686186 28.916013901471239 -6.3074222619877842 -3.7957761409416082 29.135740450874515
		 -6.3552471187563411 -3.8243405923640346 28.62597485625891 -6.2442508790343423 -3.757873311169543 34.018064378615328
		 -7.4203715669887265 -4.465392800248094 33.363279261393565 -7.2770686580497763 -4.3791501296073081 29.01269358320868
		 -6.329017261921325 -3.8089597339058048 34.417966698529291 -7.5079875285632829 -4.5181271721048812 29.953123214654703
		 -6.5338436046931925 -3.9318692724782633 30.594724738912273 -6.6731639699242074 -4.015777348531639 32.431638691923666
		 -7.0747142389586957 -4.2574765528752438 32.664548834291139 -7.1247706934946295 -4.2874142952314402 31.614255928143479
		 -6.8960147562018124 -4.1500852018543917 32.229490266472652 -7.0302196127045322 -4.2308347087600966 33.112790995073823
		 -7.2224116788857122 -4.3461911471968167 33.17431442890674 -7.2366939045969252 -4.3549802091729477 30.159666171093782
		 -6.5783382309473559 -3.9583737875000327 32.150388708687473 -7.0131908051257783 -4.220397697663441 32.743650392076319
		 -7.1424861465402687 -4.2978513063280959 31.996580124105179 -6.9794421804283688 -4.2000729918436379 30.985837996850105
		 -6.7590289855582064 -4.0671384294546549 30.15527164010572 -6.5773425950203723 -3.9583737875000327 31.970212938176783
		 -6.9735370294131558 -4.1965024354158347 31.592283273203151 -6.8914142315736813 -4.1473386199868507 34.492673725326405
		 -7.5235057161148893 -4.5274655504545205 33.235837862739658 -7.2497401684677438 -4.3626706384020624 29.689451355370771
		 -6.4762683822948643 -3.897399670040623 28.604002201318583 -6.2388950443926374 -3.7544400838351168 34.466306539398012
		 -7.5185618687533156 -4.5247189685869795 32.972166003455726 -7.1923366074361379 -4.3282010359644234 32.392087913031077
		 -7.0660625060759417 -4.2517087309534078 29.228025601623891 -6.3750911727493245 -3.8364255525812143 33.191892552859002
		 -7.240058467384662 -4.3571774746669805 34.44872841544575 -7.514441995952005 -4.5219723867194386 32.088865274854555
		 -6.9997325539748276 -4.2121579520608181 31.398923909728268 -6.8490825385402063 -4.1215207504319658 33.117185526061888
		 -7.2236476407261057 -4.347289779943833 34.123533122328901 -7.4435801837694466 -4.4791257095857988 30.06738102034441
		 -6.5589404965078479 -3.9468381436563607 31.95702934521259 -6.9708934443656476 -4.194579828108556 34.119138591340835
		 -7.4427562092091843 -4.4791257095857988 33.635740182653628 -7.3370128073088576 -4.4154050102588487 30.467283340258373
		 -6.6453891607886995 -3.9990231991396392 29.786131037108213 -6.4976917208616838 -3.9100339466313119 32.726072268124057
		 -7.1389155901124655 -4.2956540408340631 31.491209060477644 -6.8688235957131569 -4.1335370461024574 31.425291095656661
		 -6.8546443668219768 -4.1248166486730149 31.144041112420464 -6.7935672525425339 -4.0882871098347202 33.609372996725234
		 -7.330901662653579 -4.4121091120177995 34.338865140744112 -7.4904780691577084 -4.5076901610082256 34.277341706911194
		 -7.4772944761935118 -4.4999997317791101 34.343259671732177 -7.4916453664514124 -4.5083424742017666 32.994138658396054
		 -7.1972804547977116 -4.3310849469253414 30.001463055523427 -6.5438342962363727 -3.9379804171335415 29.869627125881458
		 -6.5152355125406025 -3.920745615914722 31.403318440716333 -6.8504558294739768 -4.122344724992228 30.511228650139028
		 -6.6554828491519125 -4.0056149956217375 31.592283273203151 -6.8916888897604354 -4.1473386199868507 28.6787092281157
		 -6.2555461969646045 -3.7644651076516418 34.193845618137949 -7.4587550485876095 -4.4890134043089462 28.450193616736289
		 -6.2057987328887689 -3.7342527071086904 31.161619236372729 -6.7975841285238126 -4.0902097171419989 29.88720524983372
		 -6.5189777303351271 -3.9229428814087552 28.463377209700489 -6.2089229697630968 -3.7364499726027232 30.511228650139028
		 -6.6555171814252567 -4.0051343437949178 32.137205115723276 -7.0102382296181718 -4.2187497485429164 32.537107435637239
		 -7.0970988811791544 -4.2703854876526863 30.260740383819293 -6.6004825472544049 -3.9721066968377374 32.677732427255336
		 -7.1281352562823672 -4.2895772284521287 32.976560534443792 -7.1932292465430887 -4.3287503523379316 29.579588080669133
		 -6.4517551391270613 -3.8825681279559023 32.106443398806817 -7.0029597876691883 -4.2143552175548509 34.040037033555656
		 -7.4247660979767902 -4.468139382115635 32.334959010186225 -7.0530849067518107 -4.2440183017242932 29.447752151027167
		 -6.4238430008981764 -3.8655393203771489 29.588377142645264 -6.454330059627881 -3.8840787479830494 28.770994378865076
		 -6.2760425641511288 -3.7765500678688215 28.920408432459304 -6.3082119042747022 -3.7957761409416082 33.25341598669192
		 -7.2538600412690561 -4.3652798911762263 32.831541011837629 -7.1610942386928587 -4.3093869501717679 32.791990232945039
		 -7.1528544930902358 -4.3044431028101942 28.529295174521469 -6.2229648695608999 -3.7449643763921001 31.469236405537316
		 -6.8642574033583701 -4.130859128781605 29.588377142645264 -6.4540554014411269 -3.8836667607029183 30.906736439064925
		 -6.7414851938792886 -4.0572507347315074 30.849607536220073 -6.7295375627554854 -4.0495603055023928 34.330076078767981
		 -7.4886927909438068 -4.5065915282612092 32.027341841021638 -6.9864802964639425 -4.2044675228317034 30.95507627993365
		 -6.7526431827161737 -4.0638425312136057 33.7412089263672 -7.3600840949962016 -4.4291379195965535 30.871580191160401
		 -6.7335544387367641 -4.0523068873699337 32.994138658396054 -7.197074461157646 -4.3310849469253414 28.986326397280287
		 -6.3226657913526365 -3.805114519291247 33.205076145823199 -7.2432170365323341 -4.358825423787505 31.038572368706891
		 -6.7704273003085014 -4.0742795423102613 31.715330140868986 -6.9183993984222711 -4.163371791638621 30.678220827685521
		 -6.6917720620767973 -4.0264890178150488 31.214353608229512 -6.8085704559939764 -4.0973508299976054 29.01269358320868
		 -6.3280902905410299 -3.8078611011587888 28.450193616736289 -6.2058673974354575 -3.7342527071086904 30.295896631723817
		 -6.608756625130372 -3.977050544199312 30.590330207924207 -6.6728893117374533 -4.015640019438262 32.748044923064384
		 -7.1430354629137769 -4.2989499390751122 34.224607335054408 -7.4655528387097743 -4.4928586189235036 32.075681681890359
		 -6.9967799784672211 -4.2105100029402935 32.37890432006688 -7.0624232851014499 -4.2500607818328833 29.430174027074905
		 -6.419723128096865 -3.8633420548831161 30.076170082320541 -6.5607601069950938 -3.9482114345901311 31.719724671857051
		 -6.9187083888823695 -4.1638181111920964 32.980955065431857 -7.1941218856500395 -4.3291623396180627 33.626951120677496
		 -7.3347468772681363 -4.4137570611383241 31.034177837718826 -6.7698093193883047 -4.0740048841235073 32.501951187732715
		 -7.0896144455901053 -4.2659909566646208 30.076170082320541 -6.5604511165349955 -3.9479367764033775 29.496091991895888
		 -6.433627698801291 -3.8715818004857385 34.343259671732177 -7.490821391891151 -4.5076901610082256 32.137205115723276
		 -7.0101695650714833 -4.2187497485429164 33.464353474119072 -7.2994533002702351 -4.3927457098516358 32.849119135789891
		 -7.1656260987743012 -4.3121335320393088 33.4863261290594 -7.3045344767251859 -4.3956296208125538 33.785154236247855
		 -7.3697657960792835 -4.4351803997051444 33.569822217832645 -7.3230739043310882 -4.4066159482827176 30.788084102387156
		 -6.7154956629576823 -4.0413205598997699 29.42577949608684 -6.4189678180832912 -3.862792738509607 31.552732494310561
		 -6.8827624986909273 -4.1418454562517688 29.421384965098778 -6.4175945271495207 -3.8616941057625911 33.70165814747461
		 -7.3512263684733821 -4.4237820849548486 34.277341706911194 -7.4770884825534463 -4.4999997317791101 29.944334152678572
		 -6.5314060132857499 -3.930907968824624 32.528318373661108 -7.0952449384185643 -4.2698361712791781 31.570310618262823
		 -6.8860240646586321 -4.1437680635590475 30.041013834416017 -6.5527263550325365 -3.9429929290418042 29.38622871719425
		 -6.4102474206538487 -3.8575742329612801 32.603025400458222 -7.1118617587171871 -4.2797238660023256 34.681638557813223
		 -7.5655284186882659 -4.5527341036358973 32.018552779045507 -6.9844890246099753 -4.203094231897933 32.110837929794883
		 -7.0039210913228276 -4.214767204834982 33.473142536095203 -7.3019252239510228 -4.3941190007854063 29.729002134263361
		 -6.4850917765443397 -3.9023435174021968 34.264158113946998 -7.4744105652325938 -4.4978024662850773 29.162107636802908
		 -6.3614612602316525 -3.828185806978591 30.392576313461259 -6.6299396377837816 -3.98968482079 33.205076145823199
		 -7.2425990556121373 -4.3582761074139968 29.09179514099386 -6.3454967531265707 -3.8185899365788702 31.328611413919216
		 -6.8336673478086327 -4.1121823720823265 33.218259738787395 -7.2456202956664324 -4.3604733729080296 31.354978599847612
		 -6.8397441601905671 -4.1160275866968838 33.7412089263672 -7.3604274177296451 -4.4291379195965535 32.159177770663604
		 -7.0151820769797455 -4.2214963304104574 28.770994378865076 -6.2758365705110633 -3.7770993842423297 29.482908398931691
		 -6.4315677624006353 -3.8704145031920336 34.018064378615328 -7.4202342378953485 -4.465392800248094 29.206052946683563
		 -6.3710742967680458 -3.8342282870871816 33.670896430558152 -7.3448405656313485 -4.4197995412469142 30.089353675284737
		 -6.5629573724891266 -3.9495847255239025 28.467771740688551 -6.209472286136605 -3.7369992889762313 33.429197226214548
		 -7.2918315355878098 -4.3879391915834391 31.434080157632792 -6.8571162905027636 -4.1264645977935395 29.359861531265857
		 -6.4041706082719143 -3.8540036765334769 33.25341598669192 -7.2531047312554815 -4.3648679038960951 29.790525568096282
		 -6.4980007113217821 -3.9100339466313119 32.796384763933105 -7.1541591194773178 -4.3049924191837023 30.911130970052991
		 -6.7422748361662066 -4.0572507347315074 32.677732427255336 -7.1280665917356787 -4.2890622443519648 29.812498223036609
		 -6.5027728973166354 -3.913329844872361 34.690427619789354 -7.5666270514352814 -4.5535580781961595 29.632322452525919
		 -6.4635311088841432 -3.8891599244380006 31.179197360324988 -6.8013606785916814 -4.0924069826360316 33.060056623217037
		 -7.2112880223221714 -4.3395993507147184 30.722166137566173 -6.7010074436064038 -4.0325314979236389 28.691892821079897
		 -6.2587390983856208 -3.76638771495892 30.99023252783817 -6.7594753051116818 -4.0676877458281631 32.980955065431857
		 -7.1939845565566625 -4.3291623396180627 28.437010023772093 -6.2034298060280149 -3.733154074361674 33.275388641632247
		 -7.258803888630629 -4.3681638021371443 30.19482241899831 -6.5863033183632247 -3.9635922930483609 34.501462787302536
		 -7.5260463043423647 -4.5285641832015369 31.016599713766563 -6.7656894465869932 -4.0714642958960319 29.460935743991364
		 -6.4258686050254878 -3.8669126113109193 30.313474755676079 -6.6123271815581752 -3.9792478096933439 30.102537268248938
		 -6.5666652580103069 -3.9517819910179344 31.346189537871481 -6.8370662428697146 -4.1143796375763593 29.777341975132082
		 -6.4956317844610281 -3.908935313884295 31.702146547904789 -6.9151378324545663 -4.1614835166046866 31.425291095656661
		 -6.8548846927353866 -4.1253659650465231 34.584958876075781 -7.5440364155747588 -4.5400998270452089 33.020505844324447
		 -7.2032542703596132 -4.3346555033531446 28.977537335304156 -6.321155171325489 -3.8034665701707233 29.97509586959503
		 -6.5382038034079137 -3.9345471897991153 32.185544956591997 -7.0206752407148274 -4.2253415450250147 33.394040978310024
		 -7.2844157645454484 -4.3835446605953736 33.65331830660589 -7.34113268011017 -4.4176022757528814 28.502927988593076
		 -6.2176433671925393 -3.7419431363378046 34.690427619789354 -7.5665583868885937 -4.5532834200094054 31.63622858308381
		 -6.9010272681100746 -4.1528317837219326 30.911130970052991 -6.7427554879930263 -4.0578000511050156 34.686033088801288
		 -7.5655970832349535 -4.5527341036358973 29.078611548029663 -6.3428188358057183 -3.816650163134919 29.874021656869523
		 -6.5164028098343074 -3.9215695904749839 33.481931598071334 -7.303092521244726 -4.3948056462522915 33.147947242978347
		 -7.2307887535817121 -4.3516843109318986 33.591794872772972 -7.3269877834923332 -4.4093625301502586 34.549802628171257
		 -7.53607132815889 -4.5351559796836352 30.410154437413521 -6.633407197391552 -3.991332769910525 31.205564546253381
		 -6.8065105195933207 -4.0957028808770808 28.555662360449865 -6.2285266978426703 -3.7482602746331497 31.016599713766563
		 -6.7656207820403047 -4.0715329604427204 32.655759772315008 -7.1227794216406624 -4.2863156624844239 29.104978733958056
		 -6.3485866577275543 -3.8204953777494768 30.814451288315549 -6.7216754721596494 -4.0451657745143272 33.723630802414938
		 -7.3556895640081361 -4.4263913377290125 29.654295107466247 -6.4689212757991923 -3.893005139052558 30.73534973053037
		 -6.70444067094083 -4.0341794470441634 31.904294973355803 -6.9595637941620412 -4.1879880316264577 30.95507627993365
		 -6.7523341922560753 -4.0632932148400975 30.849607536220073 -6.7296062273021739 -4.0495603055023928 33.451169881154875
		 -7.2969813765894482 -4.3912350898244883 30.906736439064925 -6.7413478647859115 -4.0567014183579992 32.049314495961966
		 -6.9913554792788277 -4.2077634210727526 34.101560467388573 -7.4386363364078738 -4.476928444091766 29.342283407313595
		 -6.4002910613840127 -3.8518064110394441 31.680173892964461 -6.9104686432797466 -4.1588742638305227 28.432615492784027
		 -6.2018505214541788 -3.7320554416146576 30.493650526186769 -6.6515346377173223 -4.0023190973806884 31.609861397155413
		 -6.8949847880014845 -4.1492612272941294 29.315916221385201 -6.3943172458221111 -3.8485105127983945 30.208006011962507
		 -6.5889469034107329 -3.9649655839821314 31.051755961671088 -6.7737575308228948 -4.0764768078042941 34.642087778920633
		 -7.5568080212588242 -4.5472409399008153 31.54394343233443 -6.8810802172970584 -4.1407468235047524 29.759763851179819
		 -6.491958231213192 -3.9067380483902623 32.21191214252039 -7.0262370689965978 -4.2282254559859327 28.797361564793469
		 -6.2813297342461452 -3.7803952824833793 34.158689370233425 -7.4511332839051843 -4.4835202405738643 33.191892552859002
		 -7.2406077837581693 -4.357246139213669 31.926267628296131 -6.9642673156102051 -4.1912839298675069 31.130857519456267
		 -6.790820670674993 -4.0866391607141956 28.647947511199241 -6.249332055489293 -3.760619893037084 31.768064512725772
		 -6.9297633808992218 -4.1701352494874415 29.083006079017728 -6.3441234621928002 -3.8177487958819358 33.807126891188183
		 -7.3745723143474802 -4.4373776651991763 28.595213139342452 -6.2378994084656538 -3.7540280965549857 33.70165814747461
		 -7.3512950330200706 -4.4238507495015371 31.02978330673076 -6.7688480157346653 -4.073318238656622 28.617185794282779
		 -6.2427402590071948 -3.7567746784225262 33.499509722023596 -7.3072123940460383 -4.3972775699330784 31.574705149250889
		 -6.887706346052501 -4.1448666963060639 29.078611548029663 -6.3425098453456199 -3.816650163134919 33.938962820830149
		 -7.402862107583152 -4.4549557891514384 32.405271505995273 -7.0681911070232859 -4.2534940091673095 28.45898267871242
		 -6.2079616661094574 -3.735900656229215 29.80810369204854 -6.50232657776316 -3.9127805284988528 32.018552779045507
		 -6.9839740405098114 -4.2028195737111789 32.409666036983339 -7.069907720690499 -4.255004629194457 28.727049068984421
		 -6.2662235339746699 -3.7707822459469855 31.078123147599481 -6.7788387072778455 -4.0793607187652121 31.161619236372729
		 -6.7974467994304355 -4.0907590335155071 31.328611413919216 -6.8340450028154196 -4.1121823720823265 34.040037033555656
		 -7.4252467498036108 -4.4683453757557006 32.998533189384119 -7.1980357648112854 -4.3319089214856037 33.556638624868448
		 -7.3198466706367267 -4.4044186827886849 32.189939487580062 -7.0220485316485979 -4.2256162032117688 32.537107435637239
		 -7.0970988811791544 -4.2703854876526863 30.643064579780994 -6.6842876264877482 -4.0220944868269832 ;
	setAttr ".usc" yes;
	setAttr ".scp" -type "string" "physics_startup";
	setAttr ".mas0" -type "doubleArray" 460 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 460 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97
		 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
		 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139
		 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160
		 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181
		 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202
		 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223
		 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244
		 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265
		 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286
		 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307
		 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328
		 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349
		 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370
		 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391
		 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412
		 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433
		 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454
		 455 456 457 458 459 ;
	setAttr ".nid" 460;
	setAttr ".nid0" 460;
	setAttr ".bt0" -type "doubleArray" 460 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989 -0.24999999999999989
		 -0.24999999999999989 -0.24999999999999989 ;
	setAttr ".ag0" -type "doubleArray" 460 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326 0.58333333333333326
		 0.58333333333333326 0.58333333333333326 0.58333333333333326 ;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".con" 0;
	setAttr ".cts" 1;
	setAttr ".chw" 600;
	setAttr ".glmInitDirection0" -type "vectorArray" 460 1 0 -1.5099580252808664e-007 1
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
		 0 -1.5099580252808664e-007 1 0 -1.5099580252808664e-007 0 0 0 0 0 0 0 0 0 0 0 0 0
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
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 ;
	setAttr ".glmEntityType0" -type "doubleArray" 460 2 2 2 2 2 2 2 2 2 2 2 2 2 2
		 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
		 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".groupEntityType0" -type "doubleArray" 460 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".rgbPP0" -type "vectorArray" 460 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0
		 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 0 0 0
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
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".radiusPP0" -type "doubleArray" 460 0.30000001192092896 0.30000001192092896
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
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 ;
	setAttr ".populationGroupId0" -type "doubleArray" 460 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ;
	setAttr ".lifespanPP0" -type "doubleArray" 460 1.7976931348623157e+308 1.7976931348623157e+308
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
		 1.7976931348623157e+308 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr ".glmEntityId0" -type "doubleArray" 460 2001 3001 4001 5001 6001 7001
		 8001 9001 10001 11001 12001 13001 14001 15001 16001 17001 18001 19001 20001 21001
		 22001 23001 24001 25001 26001 27001 28001 29001 30001 31001 32001 33001 34001 35001
		 36001 37001 38001 39001 40001 41001 42001 43001 44001 45001 46001 47001 48001 49001
		 50001 51001 52001 53001 54001 55001 56001 57001 58001 59001 60001 61001 62001 63001
		 64001 65001 66001 67001 68001 69001 70001 71001 72001 73001 74001 75001 76001 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 ;
	setAttr ".glmGroupId0" -type "doubleArray" 460 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
		 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
	setAttr -k on ".lifespan" 1;
createNode transform -n "crowdTarget1";
	setAttr ".t" -type "double3" -54.300738675306349 0 0 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr -l on ".shxy";
	setAttr -l on ".shxz";
	setAttr -l on ".shyz";
createNode CrowdTargetLocator -n "crowdTargetShape1" -p "crowdTarget1";
	setAttr -k off ".v";
	setAttr -l on ".tid" 1;
	setAttr ".rad" 10;
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
createNode transform -n "pPlane1";
	setAttr ".t" -type "double3" -47.313166436506897 0 5.3212681347788191 ;
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
createNode transform -n "locator1";
createNode locator -n "locatorShape1" -p "locator1";
	setAttr -k off ".v";
createNode lightLinker -s -n "lightLinker1";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 600 -ast 1 -aet 600 ";
	setAttr ".st" 6;
createNode polyPlane -n "polyPlane1";
	setAttr ".w" 180.69621969579961;
	setAttr ".h" 94.857532159745404;
	setAttr ".sw" 1;
	setAttr ".sh" 1;
	setAttr ".cuv" 2;
createNode CrowdBeOpCondition -n "beOpCondition1";
createNode animCurveTL -n "locator1_translateX";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 -69.765543902072423 501 -69.765543902072423;
createNode animCurveTL -n "locator1_translateY";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 0 501 10.058639417611795;
createNode animCurveTL -n "locator1_translateZ";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 0 501 0;
createNode animCurveTU -n "locator1_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 1 501 1;
	setAttr -s 2 ".kot[0:1]"  5 5;
createNode animCurveTA -n "locator1_rotateX";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 0 501 0;
createNode animCurveTA -n "locator1_rotateY";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 0 501 0;
createNode animCurveTA -n "locator1_rotateZ";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 0 501 0;
createNode animCurveTU -n "locator1_scaleX";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 1 501 1;
createNode animCurveTU -n "locator1_scaleY";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 1 501 1;
createNode animCurveTU -n "locator1_scaleZ";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  360 1 501 1;
createNode script -n "script1";
	addAttr -ci true -sn "crnd" -ln "currentRenderer" -dt "string";
	addAttr -ci true -sn "sstp" -ln "shadersStartPath" -dt "string";
	addAttr -ci true -sn "lprp" -ln "isLightProps" -dt "string";
	addAttr -ci true -sn "ecdlg" -ln "enableConfirmDialog" -dt "string";
	setAttr ".b" -type "string" "string $packdir = `dirmap -cd \"/atomo/pipeline/tools/golaem/characterPack/5.2/\"`;string $scriptName = $packdir + \"script/sampleGUI.mel\";eval(\"source \\\"\" + $scriptName + \"\\\"\");glmCrowdSampleConfig(\"\")";
	setAttr ".a" -type "string" "glmDeleteSampleConfigWindow()";
	setAttr ".st" 2;
	setAttr -k on ".crnd" -type "string" "";
	setAttr ".sstp" -type "string" "golaem/shaders/FortressSoldier";
	setAttr ".ecdlg" -type "string" "1";
createNode hyperGraphInfo -n "nodeEditorPanel1Info";
createNode hyperView -n "hyperView1";
	setAttr ".dag" no;
createNode hyperLayout -n "hyperLayout1";
	setAttr ".ihi" 0;
	setAttr -s 22 ".hyp";
	setAttr ".anf" yes;
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
createNode CrowdBeOpCondition -n "beOpCondition2";
createNode CrowdBeOpCondition -n "beOpCondition3";
createNode CrowdBeOpCondition -n "beOpCondition4";
createNode CrowdBeOpCondition -n "beOpCondition5";
createNode CrowdBeOpCondition -n "beOpCondition6";
createNode CrowdBeOpCondition -n "beOpCondition7";
createNode CrowdBeOpCondition -n "beOpCondition8";
createNode CrowdBeOpCondition -n "beOpCondition9";
createNode CrowdBeOpCondition -n "beOpCondition10";
	setAttr ".ofo" yes;
createNode CrowdBeOpCondition -n "beOpCondition11";
createNode CrowdBeOpCondition -n "beOpCondition12";
	setAttr ".ofo" yes;
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
connectAttr "physicsShape1.msg" "crowdManagerShape.phy";
connectAttr "entityTypeShape1.msg" "crowdManagerShape.ine[0]";
connectAttr "entityTypeShape2.msg" "crowdManagerShape.ine[1]";
connectAttr "terrainShape1.msg" "crowdManagerShape.trr";
connectAttr ":time1.o" "crowdManagerShape.ct";
connectAttr "beForceShape1.nb" "entityTypeContainerShape2.fb[0]";
connectAttr "entityTypeContainerShape2.msg" "Physicalize_ball_and_lauch_it.inc";
connectAttr "triOpAndShape1.msg" "beForce1StartTriggerShape.tro";
connectAttr "beForce1StartTriggerShape.ctr" "triOpAndShape1.pco";
connectAttr "triBoolShape1.net" "triOpAndShape1.prt[0]";
connectAttr "beForce1StartTriggerShape.ctr" "triBoolShape1.pco";
connectAttr "triOpAndShape2.msg" "beForce1StopTriggerShape.tro";
connectAttr "beForce1StopTriggerShape.ctr" "triOpAndShape2.pco";
connectAttr "triBoolShape2.net" "triOpAndShape2.prt[0]";
connectAttr "beForce1StopTriggerShape.ctr" "triBoolShape2.pco";
connectAttr "triOpAndShape3.msg" "beForce2StartTriggerShape.tro";
connectAttr "beForce2StartTriggerShape.ctr" "triOpAndShape3.pco";
connectAttr "triFrameShape1.net" "triOpAndShape3.prt[0]";
connectAttr "triDistanceShape1.net" "triOpAndShape3.prt[1]";
connectAttr "triBoolShape3.net" "triOpAndShape3.prt[2]";
connectAttr "beForce2StartTriggerShape.ctr" "triFrameShape1.pco";
connectAttr "crowdTarget1.msg" "triDistanceShape1.ino[0]";
connectAttr "beForce2StartTriggerShape.ctr" "triDistanceShape1.pco";
connectAttr "beForce2StartTriggerShape.ctr" "triBoolShape3.pco";
connectAttr "triOpAndShape4.msg" "beForce2StopTriggerShape.tro";
connectAttr "beForce2StopTriggerShape.ctr" "triOpAndShape4.pco";
connectAttr "triBoolShape4.net" "triOpAndShape4.prt[0]";
connectAttr "beForce2StopTriggerShape.ctr" "triBoolShape4.pco";
connectAttr "triOpAndShape5.msg" "beForce3StartTriggerShape.tro";
connectAttr "beForce3StartTriggerShape.ctr" "triOpAndShape5.pco";
connectAttr "triFrameShape2.net" "triOpAndShape5.prt[0]";
connectAttr "triBoolShape5.net" "triOpAndShape5.prt[1]";
connectAttr "beForce3StartTriggerShape.ctr" "triFrameShape2.pco";
connectAttr "beForce3StartTriggerShape.ctr" "triBoolShape5.pco";
connectAttr "triOpAndShape6.msg" "beForce3StopTriggerShape.tro";
connectAttr "beForce3StopTriggerShape.ctr" "triOpAndShape6.pco";
connectAttr "triBeTimeShape1.net" "triOpAndShape6.prt[0]";
connectAttr "beForce3StopTriggerShape.ctr" "triBeTimeShape1.pco";
connectAttr "triOpAndShape7.msg" "beGoto1StartTriggerShape.tro";
connectAttr "beGoto1StartTriggerShape.ctr" "triOpAndShape7.pco";
connectAttr "triBoolShape6.net" "triOpAndShape7.prt[0]";
connectAttr "beGoto1StartTriggerShape.ctr" "triBoolShape6.pco";
connectAttr "triOpAndShape8.msg" "beGoto1StopTriggerShape.tro";
connectAttr "beGoto1StopTriggerShape.ctr" "triOpAndShape8.pco";
connectAttr "triBoolShape7.net" "triOpAndShape8.prt[0]";
connectAttr "beGoto1StopTriggerShape.ctr" "triBoolShape7.pco";
connectAttr "triOpAndShape9.msg" "beLocomotion1StartTriggerShape.tro";
connectAttr "beLocomotion1StartTriggerShape.ctr" "triOpAndShape9.pco";
connectAttr "triBoolShape8.net" "triOpAndShape9.prt[0]";
connectAttr "beLocomotion1StartTriggerShape.ctr" "triBoolShape8.pco";
connectAttr "triOpAndShape10.msg" "beLocomotion1StopTriggerShape.tro";
connectAttr "beLocomotion1StopTriggerShape.ctr" "triOpAndShape10.pco";
connectAttr "triBoolShape9.net" "triOpAndShape10.prt[0]";
connectAttr "beLocomotion1StopTriggerShape.ctr" "triBoolShape9.pco";
connectAttr "triOpAndShape11.msg" "beNavigation1StartTriggerShape.tro";
connectAttr "beNavigation1StartTriggerShape.ctr" "triOpAndShape11.pco";
connectAttr "triBoolShape10.net" "triOpAndShape11.prt[0]";
connectAttr "beNavigation1StartTriggerShape.ctr" "triBoolShape10.pco";
connectAttr "triOpAndShape12.msg" "beNavigation1StopTriggerShape.tro";
connectAttr "beNavigation1StopTriggerShape.ctr" "triOpAndShape12.pco";
connectAttr "triBoolShape11.net" "triOpAndShape12.prt[0]";
connectAttr "beNavigation1StopTriggerShape.ctr" "triBoolShape11.pco";
connectAttr "triOpAndShape13.msg" "beOpAlternative1TriggerShape1.tro";
connectAttr "beOpAlternative1TriggerShape1.ctr" "triOpAndShape13.pco";
connectAttr "triFrameShape3.net" "triOpAndShape13.prt[0]";
connectAttr "triBoolShape12.net" "triOpAndShape13.prt[1]";
connectAttr "beOpAlternative1TriggerShape1.ctr" "triFrameShape3.pco";
connectAttr "beOpAlternative1TriggerShape1.ctr" "triBoolShape12.pco";
connectAttr "triOpAndShape14.msg" "bePhysicalize1StartTriggerShape.tro";
connectAttr "bePhysicalize1StartTriggerShape.ctr" "triOpAndShape14.pco";
connectAttr "triBoolShape13.net" "triOpAndShape14.prt[0]";
connectAttr "bePhysicalize1StartTriggerShape.ctr" "triBoolShape13.pco";
connectAttr "triOpAndShape15.msg" "bePhysicalize1StopTriggerShape.tro";
connectAttr "bePhysicalize1StopTriggerShape.ctr" "triOpAndShape15.pco";
connectAttr "triBoolShape14.net" "triOpAndShape15.prt[0]";
connectAttr "bePhysicalize1StopTriggerShape.ctr" "triBoolShape14.pco";
connectAttr "triOpAndShape16.msg" "bePhysicalize2StartTriggerShape.tro";
connectAttr "bePhysicalize2StartTriggerShape.ctr" "triOpAndShape16.pco";
connectAttr "triBoolShape15.net" "triOpAndShape16.prt[0]";
connectAttr "bePhysicalize2StartTriggerShape.ctr" "triBoolShape15.pco";
connectAttr "triOpOrShape1.msg" "bePhysicalize2StopTriggerShape.tro";
connectAttr "bePhysicalize2StopTriggerShape.ctr" "triOpOrShape1.pco";
connectAttr "triFrameShape4.net" "triOpOrShape1.prt[0]";
connectAttr "triCollisionShape1.net" "triOpOrShape1.prt[1]";
connectAttr "bePhysicalize2StopTriggerShape.ctr" "triFrameShape4.pco";
connectAttr "bePhysicalize2StopTriggerShape.ctr" "triCollisionShape1.pco";
connectAttr "triOpAndShape17.msg" "bePhysicalize3StartTriggerShape.tro";
connectAttr "bePhysicalize3StartTriggerShape.ctr" "triOpAndShape17.pco";
connectAttr "triCollisionShape2.net" "triOpAndShape17.prt[0]";
connectAttr "bePhysicalize3StartTriggerShape.ctr" "triCollisionShape2.pco";
connectAttr "triOpAndShape18.msg" "bePhysicalize3StopTriggerShape.tro";
connectAttr "bePhysicalize3StopTriggerShape.ctr" "triOpAndShape18.pco";
connectAttr "triBoolShape16.net" "triOpAndShape18.prt[0]";
connectAttr "bePhysicalize3StopTriggerShape.ctr" "triBoolShape16.pco";
connectAttr "triOpAndShape19.msg" "bePhysicalize4StopTriggerShape.tro";
connectAttr "bePhysicalize4StopTriggerShape.ctr" "triOpAndShape19.pco";
connectAttr "triBoolShape17.net" "triOpAndShape19.prt[0]";
connectAttr "bePhysicalize4StopTriggerShape.ctr" "triBoolShape17.pco";
connectAttr "triOpAndShape20.msg" "bePhysicalize5StartTriggerShape.tro";
connectAttr "bePhysicalize5StartTriggerShape.ctr" "triOpAndShape20.pco";
connectAttr "triFrameShape5.net" "triOpAndShape20.prt[0]";
connectAttr "triCollisionShape3.net" "triOpAndShape20.prt[1]";
connectAttr "bePhysicalize5StartTriggerShape.ctr" "triFrameShape5.pco";
connectAttr "bePhysicalize5StartTriggerShape.ctr" "triCollisionShape3.pco";
connectAttr "triOpAndShape21.msg" "bePhysicalize5StopTriggerShape.tro";
connectAttr "bePhysicalize5StopTriggerShape.ctr" "triOpAndShape21.pco";
connectAttr "triBoolShape18.net" "triOpAndShape21.prt[0]";
connectAttr "bePhysicalize5StopTriggerShape.ctr" "triBoolShape18.pco";
connectAttr "entityTypeContainerShape2.chb" "bePhysicalizeShape1.pb";
connectAttr "entityTypeContainerShape2.ib" "bePhysicalizeShape1.prb[0]";
connectAttr "bePhysicalize1StartTriggerShape.msg" "bePhysicalizeShape1.isac";
connectAttr "beOpCondition5.msg" "bePhysicalizeShape1.scnd" -na;
connectAttr "beOpCondition5.msg" "bePhysicalizeShape1.fcnd";
connectAttr "beOpCondition5.msg" "bePhysicalizeShape1.lcnd";
connectAttr "entityTypeContainerShape2.chb" "beForceShape1.pb";
connectAttr "bePhysicalizeShape1.nb" "beForceShape1.prb[0]";
connectAttr "beForce1StartTriggerShape.msg" "beForceShape1.isac";
connectAttr "beOpCondition10.msg" "beForceShape1.scnd" -na;
connectAttr "beOpCondition10.msg" "beForceShape1.fcnd";
connectAttr "beOpCondition10.msg" "beForceShape1.lcnd";
connectAttr "beOpParallelShape2.nb" "entityTypeContainerShape3.fb[0]";
connectAttr "PhysicsContainerShape.chb" "bePhysicalizeShape2.pb";
connectAttr "PhysicsContainerShape.ib" "bePhysicalizeShape2.prb[0]";
connectAttr "bePhysicalize2StartTriggerShape.msg" "bePhysicalizeShape2.isac";
connectAttr "beOpCondition6.msg" "bePhysicalizeShape2.scnd" -na;
connectAttr "beOpCondition6.msg" "bePhysicalizeShape2.fcnd";
connectAttr "beOpCondition6.msg" "bePhysicalizeShape2.lcnd";
connectAttr "beForceShape3.nb" "PhysicsContainerShape.fb[0]";
connectAttr "beOpParallelShape2.chb" "PhysicsContainerShape.pb";
connectAttr "PhysicsContainerShape.msg" "KinematicMode.inc";
connectAttr "PhysicsContainerShape.msg" "CollisionWithBall.inc";
connectAttr "PhysicsContainerShape.msg" "Explosion.inc";
connectAttr "PhysicsContainerShape.msg" "SoldierAspiration.inc";
connectAttr "PhysicsContainerShape.chb" "bePhysicalizeShape3.pb";
connectAttr "beOpAlternativeShape1.db" "bePhysicalizeShape3.prb[0]";
connectAttr "bePhysicalize3StartTriggerShape.msg" "bePhysicalizeShape3.isac";
connectAttr "beOpCondition7.msg" "bePhysicalizeShape3.scnd" -na;
connectAttr "beOpCondition7.msg" "bePhysicalizeShape3.fcnd";
connectAttr "beOpCondition7.msg" "bePhysicalizeShape3.lcnd";
connectAttr "beOpParallelShape2.chb" "beGotoShape1.pb";
connectAttr "crowdTargetShape1.msg" "beGotoShape1.itl";
connectAttr "beGoto1StartTriggerShape.msg" "beGotoShape1.isac";
connectAttr "beOpCondition2.msg" "beGotoShape1.scnd" -na;
connectAttr "beOpCondition2.msg" "beGotoShape1.fcnd";
connectAttr "beOpCondition2.msg" "beGotoShape1.lcnd";
connectAttr "beOpParallelShape2.chb" "beNavigationShape1.pb";
connectAttr "beNavigation1StartTriggerShape.msg" "beNavigationShape1.isac";
connectAttr "beOpCondition3.msg" "beNavigationShape1.scnd" -na;
connectAttr "beOpCondition3.msg" "beNavigationShape1.fcnd";
connectAttr "beOpCondition3.msg" "beNavigationShape1.lcnd";
connectAttr "entityTypeContainerShape3.chb" "beOpParallelShape2.pb";
connectAttr "entityTypeContainerShape3.ib" "beOpParallelShape2.prb[0]";
connectAttr "CMAN_RunNormal_LeftfootShape2.msg" "beLocomotionShape1.mcp[0]";
connectAttr "CMAN_WalkTurnRight45_LeftFootShape1.msg" "beLocomotionShape1.mcp[2]"
		;
connectAttr "CMAN_WalkTurnRight90_LeftFootShape1.msg" "beLocomotionShape1.mcp[3]"
		;
connectAttr "CMAN_WalkTurnRight135_LeftFootShape1.msg" "beLocomotionShape1.mcp[4]"
		;
connectAttr "CMAN_WalkTurnRight180_LeftFootShape1.msg" "beLocomotionShape1.mcp[5]"
		;
connectAttr "CMAN_WalkNormal_LeftfootShape1.msg" "beLocomotionShape1.mcp[6]";
connectAttr "CMAN_WalkSlow_LeftfootShape1.msg" "beLocomotionShape1.mcp[7]";
connectAttr "CMAN_StandOrientLeft45_LeftFootShape1.msg" "beLocomotionShape1.mcp[8]"
		;
connectAttr "CMAN_StandOrientLeft90_LeftFootShape1.msg" "beLocomotionShape1.mcp[9]"
		;
connectAttr "CMAN_StandOrientLeft135_LeftFootShape1.msg" "beLocomotionShape1.mcp[10]"
		;
connectAttr "CMAN_StandOrientLeft180_LeftFootShape1.msg" "beLocomotionShape1.mcp[11]"
		;
connectAttr "beOpParallelShape2.chb" "beLocomotionShape1.pb";
connectAttr "beLocomotion1StartTriggerShape.msg" "beLocomotionShape1.isac";
connectAttr "beOpCondition4.msg" "beLocomotionShape1.scnd" -na;
connectAttr "beOpCondition4.msg" "beLocomotionShape1.fcnd";
connectAttr "beOpCondition4.msg" "beLocomotionShape1.lcnd";
connectAttr "PhysicsContainerShape.chb" "beOpAlternativeShape1.pb";
connectAttr "bePhysicalizeShape2.nb" "beOpAlternativeShape1.prb[0]";
connectAttr "beOpCondition1.msg" "beOpAlternativeShape1.cnd" -na;
connectAttr "beOpCondition1.msg" "beOpAlternativeShape1.fcnd";
connectAttr "beOpCondition1.msg" "beOpAlternativeShape1.lcnd";
connectAttr "beOpParallelShape3.chb" "bePhysicalizeShape4.pb";
connectAttr "beForce2StartTriggerShape.msg" "bePhysicalizeShape4.isac";
connectAttr "beOpCondition8.msg" "bePhysicalizeShape4.scnd" -na;
connectAttr "beOpCondition8.msg" "bePhysicalizeShape4.fcnd";
connectAttr "beOpCondition8.msg" "bePhysicalizeShape4.lcnd";
connectAttr "crowdTarget1.t" "beForce2.t";
connectAttr "beOpParallelShape3.chb" "beForceShape2.pb";
connectAttr "crowdTargetShape1.msg" "beForceShape2.fdl";
connectAttr "crowdTargetShape1.msg" "beForceShape2.fil";
connectAttr "beForce2StartTriggerShape.msg" "beForceShape2.isac";
connectAttr "beOpCondition11.msg" "beForceShape2.scnd" -na;
connectAttr "beOpCondition11.msg" "beForceShape2.fcnd";
connectAttr "beOpCondition11.msg" "beForceShape2.lcnd";
connectAttr "PhysicsContainerShape.chb" "beOpParallelShape3.pb";
connectAttr "beOpAlternativeShape1.nb" "beOpParallelShape3.prb[0]";
connectAttr "PhysicsContainerShape.chb" "beForceShape3.pb";
connectAttr "bePhysicalizeShape3.nb" "beForceShape3.prb[0]";
connectAttr "beOpParallelShape3.nb" "beForceShape3.prb[1]";
connectAttr "locatorShape1.msg" "beForceShape3.fdl";
connectAttr "beForce3StartTriggerShape.msg" "beForceShape3.isac";
connectAttr "beOpCondition12.msg" "beForceShape3.scnd" -na;
connectAttr "beOpCondition12.msg" "beForceShape3.fcnd";
connectAttr "beOpCondition12.msg" "beForceShape3.lcnd";
connectAttr "beOpParallelShape3.chb" "bePhysicalizeShape5.pb";
connectAttr "bePhysicalize5StartTriggerShape.msg" "bePhysicalizeShape5.isac";
connectAttr "beOpCondition9.msg" "bePhysicalizeShape5.scnd" -na;
connectAttr "beOpCondition9.msg" "bePhysicalizeShape5.fcnd";
connectAttr "beOpCondition9.msg" "bePhysicalizeShape5.lcnd";
connectAttr "crowdManagerShape.rgs" "popToolShape1.ps";
connectAttr "entityTypeShape1.msg" "popToolShape1.ine" -na;
connectAttr ":time1.o" "particleShape1.cti";
connectAttr "crowdManagerShape.sf" "particleShape1.stf";
connectAttr "crowdField1.of[0]" "particleShape1.ifc[0]";
connectAttr "crowdManagerShape.sf" "crowdField1.sf";
connectAttr "particleShape1.fd" "crowdField1.ind[0]";
connectAttr "particleShape2.fd" "crowdField1.ind[1]";
connectAttr "particleShape1.ppfd[0]" "crowdField1.ppda[0]";
connectAttr "particleShape2.ppfd[0]" "crowdField1.ppda[1]";
connectAttr "entityTypeContainerShape2.msg" "entityTypeShape1.ibc";
connectAttr "entityTypeContainerShape3.msg" "entityTypeShape2.ibc";
connectAttr "entityTypeShape2.msg" "popToolShape2.ine" -na;
connectAttr "crowdManagerShape.rgs" "popToolShape2.ps";
connectAttr ":time1.o" "particleShape2.cti";
connectAttr "crowdManagerShape.sf" "particleShape2.stf";
connectAttr "crowdField1.of[1]" "particleShape2.ifc[0]";
connectAttr "polyPlane1.out" "pPlaneShape1.i";
connectAttr "locator1_translateX.o" "locator1.tx";
connectAttr "locator1_translateY.o" "locator1.ty";
connectAttr "locator1_translateZ.o" "locator1.tz";
connectAttr "locator1_visibility.o" "locator1.v";
connectAttr "locator1_rotateX.o" "locator1.rx";
connectAttr "locator1_rotateY.o" "locator1.ry";
connectAttr "locator1_rotateZ.o" "locator1.rz";
connectAttr "locator1_scaleX.o" "locator1.sx";
connectAttr "locator1_scaleY.o" "locator1.sy";
connectAttr "locator1_scaleZ.o" "locator1.sz";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "beOpParallelShape3.msg" "beOpCondition1.cndb";
connectAttr "beOpAlternative1TriggerShape1.msg" "beOpCondition1.ctri";
connectAttr "hyperView1.msg" "nodeEditorPanel1Info.b[0]";
connectAttr "hyperLayout1.msg" "hyperView1.hl";
connectAttr "notes4.msg" "hyperLayout1.hyp[0].dn";
connectAttr "SoldierAspiration.msg" "hyperLayout1.hyp[1].dn";
connectAttr "bePhysicalize5.msg" "hyperLayout1.hyp[2].dn";
connectAttr "bePhysicalizeShape5.msg" "hyperLayout1.hyp[3].dn";
connectAttr "notes5.msg" "hyperLayout1.hyp[8].dn";
connectAttr "Physicalize_ball_and_lauch_it.msg" "hyperLayout1.hyp[9].dn";
connectAttr "motionClip2.msg" "hyperLayout1.hyp[10].dn";
connectAttr "motionClipShape2.msg" "hyperLayout1.hyp[11].dn";
connectAttr "CMAN_WalkNormal_Leftfoot1.msg" "hyperLayout1.hyp[12].dn";
connectAttr "CMAN_WalkNormal_LeftfootShape1.msg" "hyperLayout1.hyp[13].dn";
connectAttr "CMAN_WalkTurnRight45_LeftFoot2.msg" "hyperLayout1.hyp[14].dn";
connectAttr "CMAN_WalkTurnRight45_LeftFootShape2.msg" "hyperLayout1.hyp[15].dn";
connectAttr "CMAN_WalkSlow_Leftfoot1.msg" "hyperLayout1.hyp[16].dn";
connectAttr "CMAN_WalkSlow_LeftfootShape1.msg" "hyperLayout1.hyp[17].dn";
connectAttr "CMAN_StandOrientLeft45_LeftFoot1.msg" "hyperLayout1.hyp[18].dn";
connectAttr "CMAN_StandOrientLeft45_LeftFootShape1.msg" "hyperLayout1.hyp[19].dn"
		;
connectAttr "CMAN_StandOrientLeft90_LeftFoot1.msg" "hyperLayout1.hyp[20].dn";
connectAttr "CMAN_StandOrientLeft90_LeftFootShape1.msg" "hyperLayout1.hyp[21].dn"
		;
connectAttr "CMAN_StandOrientLeft135_LeftFoot1.msg" "hyperLayout1.hyp[22].dn";
connectAttr "CMAN_StandOrientLeft135_LeftFootShape1.msg" "hyperLayout1.hyp[23].dn"
		;
connectAttr "CMAN_StandOrientLeft180_LeftFoot1.msg" "hyperLayout1.hyp[24].dn";
connectAttr "CMAN_StandOrientLeft180_LeftFootShape1.msg" "hyperLayout1.hyp[25].dn"
		;
connectAttr "beGoto1StopTriggerShape.msg" "beOpCondition2.ctri";
connectAttr "beNavigation1StopTriggerShape.msg" "beOpCondition3.ctri";
connectAttr "beLocomotion1StopTriggerShape.msg" "beOpCondition4.ctri";
connectAttr "bePhysicalize1StopTriggerShape.msg" "beOpCondition5.ctri";
connectAttr "beForceShape1.msg" "beOpCondition5.cndb";
connectAttr "bePhysicalize2StopTriggerShape.msg" "beOpCondition6.ctri";
connectAttr "beOpAlternativeShape1.msg" "beOpCondition6.cndb";
connectAttr "bePhysicalize3StopTriggerShape.msg" "beOpCondition7.ctri";
connectAttr "beForceShape3.msg" "beOpCondition7.cndb";
connectAttr "bePhysicalize4StopTriggerShape.msg" "beOpCondition8.ctri";
connectAttr "bePhysicalize5StopTriggerShape.msg" "beOpCondition9.ctri";
connectAttr "beForce1StopTriggerShape.msg" "beOpCondition10.ctri";
connectAttr "entityTypeContainerShape2.msg" "beOpCondition10.cndb";
connectAttr "beForce2StopTriggerShape.msg" "beOpCondition11.ctri";
connectAttr "beForce3StopTriggerShape.msg" "beOpCondition12.ctri";
connectAttr "PhysicsContainerShape.msg" "beOpCondition12.cndb";
connectAttr "pPlaneShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "particleShape1.iog" ":initialParticleSE.dsm" -na;
connectAttr "particleShape2.iog" ":initialParticleSE.dsm" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of physics.ma
