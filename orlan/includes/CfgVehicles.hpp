class SensorTemplatePassiveRadar;
class SensorTemplateAntiRadiation;
class SensorTemplateActiveRadar;
class SensorTemplateIR;
class SensorTemplateVisual;
class SensorTemplateMan;
class SensorTemplateLaser;
class SensorTemplateNV;
class SensorTemplateDataLink;
class DefaultVehicleSystemsDisplayManagerLeft
{
	class components;
};
class DefaultVehicleSystemsDisplayManagerRight
{
	class components;
};
class CfgVehicles
{
	class All
	{
	};
	class AllVehicles: All
	{
		class NewTurret
		{
		};
	};
	class Land: AllVehicles
	{
	};
	class LandVehicle: Land
	{
	};
	class StaticWeapon: LandVehicle
	{
		class Turrets
		{
			class MainTurret: NewTurret
			{
			};
		};
	};

	class orlan_tripod_launcher_OPF: StaticWeapon
	{
		model="\orlan\tripod\orlan_tripod.p3d";
		destrType="DestructWreck";
		crew = "O_soldier_UAV_F";
		_generalmacro="orlan_tripod_launcher";
		displayName="Orlan Tripod Launcher";
		editorSubcategory = "EdSubcat_Turrets";
		editorPreview = "\orlan\pictures\preview_tripod.jpg";
		icon = "\orlan\pictures\map_tripod.paa";
		scopecurator=2;
		simulation = "tank";
		scope=2;
		side = 0;
		faction = "OPF_F";
		artilleryScanner=0;
		fireDustEffect = "";
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				LODTurnedIn = 0;
				LODTurnedOut = 0;
				LODOpticsIn = 0;
				LODOpticsOut = 0;
				gunnerOpticsModel="\A3\weapons_f\reticle\optics_empty";
				//turretInfoType="RscOptics_Offroad_01";
				weapons[]=
				{
					"orlan_Launcher_Weap"
				};
				magazines[]=
				{
					"FakeMagazine"
				};
				cameraDir="look";
				gunnerAction="Mortar_Gunner";
				gunnergetInAction="";
				gunnergetOutAction="";
				elevationMode=1;
				initCamElev=0;
				minCamElev=-35;
				maxCamElev=35;
				initElev=0;
				minTurn=-180;
				maxTurn=180;
				initTurn=0;
				discreteDistance[]={100,200,300,400,500,700,1000,1600,2000,2400,2800};
				discreteDistanceCameraPoint[]=
				{
					"otocvez"
				};
				discreteDistanceInitIndex=5;
				gunnerForceOptics=0;
				memoryPointGunnerOptics="otocvez";
				disableSoundAttenuation=1;
				class ViewOptics
				{
					initAngleX=0;
					minAngleX=-30;
					maxAngleX=30;
					initAngleY=0;
					minAngleY=-100;
					maxAngleY=100;
					initFov=0.17399999;
					minFov=0.0077777999;
					maxFov=0.14;
					visionMode[]=
					{
						"Normal"
					};
				};
				minelev=-30;
				maxelev=13;
				ejectDeadGunner=1;
				usepip=2;
			};
		};

		hiddenSelections[]={};
		hiddenSelectionsTextures[]={};

		class UserActions
		{
			class ReloadAction
			{
				displayName="Reload";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				condition="this call orlan_fnc_canReload";
				statement="this spawn orlan_fnc_handleAnim";
				icon="";
			};
		};

		class AnimationSources
		{
			class luch_anim
			{
				source = "user";
				animPeriod = 1;
				initPhase = 0;
			};
			class reload_uav
			{
				source = "user";
				animPeriod = 1;
				initPhase = 0;
			};
		};
		/*
		class EventHandlers
		{
			class orlan_events
			{
				//init="systemChat 'init'; _this call orlan_fnc_initializeTripod";
				//init="_this execvm 'fn_handleAnim.sqf'";
				//fired="_this spawn orlan_fnc_init_launcher_tripod";
				//killed = "detach ((_this # 0) getVariable ['proxy', objNull]); ((_this # 0) getVariable ['proxy', objNull]) setVelocity [1, 2, 1]";
				//deleted = "deleteVehicle ((_this # 0) getVariable ['proxy', objNull])";
			};
		};
		*/
		class GunParticles
        {
            class FirstEffect
            {
                directionName="konec hlavne";
                effectName="";
                positionName="usti hlavne";
            };
		};
	};

	class orlan_tripod_launcher_BLU: orlan_tripod_launcher_OPF
	{
		side=1;
		faction = "BLU_F";
		crew = "B_soldier_UAV_F";
	};

	class orlan_tripod_launcher_IND: orlan_tripod_launcher_OPF
	{
		side=2;
		faction = "IND_F";
		crew = "I_soldier_UAV_F";
	};

	class UAV;
	class UAV_02_base_F:UAV
	{
		class NewTurret;
		class ViewPilot;
		class ViewOptics;
		class AnimationSources;
		class Components;
	};
	class orlan_F_OPF: UAV_02_base_F
	{
		extCameraPosition[] = {0,0,-3};
		scope=2;
		scopeCurator=2;
		forceInGarage=1;
		vehicleClass="Autonomous";
		_generalMacro="orlan_F";
		side=0;
		faction = "OPF_F";
		displayName="Orlan-30";
		author="B01/Sam";
		unitInfoType="RscUnitInfoNoWeapon";
		simulation="airplaneX";
		crew = "O_UAV_AI";
		editorPreview = "\orlan\pictures\preview_orlan.jpg";
		icon = "\orlan\pictures\map_orlan.paa";
		mapSize=6;
		model="\orlan\orlan.p3d";
		destrType="DestructWreck";
		animated=1;
		attenuationEffectType = "OpenHeliAttenuation";
		soundGetIn[] = {"",0.56234133,1};
		soundGetOut[] = {"",0.56234133,1,40};
		soundDammage[] = {"",0.56234133,1};
		soundLocked[] = {"\A3\Sounds_F\weapons\Rockets\opfor_lock_1",1.0,1};
		soundIncommingMissile[] = {"\A3\Sounds_F\vehicles\air\noises\alarm_locked_by_missile_5",0.39810717,1};
		soundEngineOnInt[] = {"A3\Sounds_F\air\UAV_02\UAV_02_start_ext",0.70794576,1.0};
		soundEngineOnExt[] = {"A3\Sounds_F\air\UAV_02\UAV_02_start_int",0.70794576,1.0,400};
		soundEngineOffInt[] = {"A3\Sounds_F\air\UAV_02\UAV_02_stop_int",0.70794576,1.0};
		soundEngineOffExt[] = {"A3\Sounds_F\air\UAV_02\UAV_02_stop_ext",0.70794576,1.0,400};
		soundGearUp[] = {"A3\Sounds_F\vehicles\air\noises\drone_gear_up",1.0,1.0,120};
		soundGearDown[] = {"A3\Sounds_F\vehicles\air\noises\drone_gear_down",1.0,1.0,120};
		soundFlapsUp[] = {"A3\Sounds_F_EPC\CAS_01\Flaps_Up",0.63095737,1.0,100};
		soundFlapsDown[] = {"A3\Sounds_F_EPC\CAS_01\Flaps_Down",0.63095737,1.0,100};
		soundBushCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",1.0,1,100};
		soundBushCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",1.0,1,100};
		soundBushCollision3[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",1.0,1,100};
		soundBushCrash[] = {"soundBushCollision1",0.33,"soundBushCollision2",0.33,"soundBushCollision3",0.33};
		soundWaterCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",1.0,1,100};
		soundWaterCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",1.0,1,100};
		soundWaterCrashes[] = {"soundWaterCollision1",0.5,"soundWaterCollision2",0.5};
		Crash0[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1",1.0,1,900};
		Crash1[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2",1.0,1,900};
		Crash2[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3",1.0,1,900};
		Crash3[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4",1.0,1,900};
		soundCrashes[] = {"Crash0",0.25,"Crash1",0.25,"Crash2",0.25,"Crash3",0.25};
		class Sounds
		{
			class EngineLowOut
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_low_ext",0.70794576,1.0,450};
				frequency = "1.0 min (rpm + 0.5)";
				volume = "camPos*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			class EngineHighOut
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_high_ext",1.0,1.0,650};
				frequency = "(rpm factor[0.5, 1.0])";
				volume = "camPos*(rpm factor[0.2, 1.0])";
			};
			class ForsageOut
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_forsage_ext",1.1220185,1.0,900};
				frequency = "1";
				volume = "engineOn*camPos*(thrust factor[0.6, 1.0])";
				cone[] = {3.14,3.92,2.0,0.5};
			};
			class WindNoiseOut
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\noise",0.31622776,1.0,150};
				frequency = "(0.3+(1.005*(speed factor[1, 50])))";
				volume = "camPos*(speed factor[1,  50])";
			};
			class EngineLowIn
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_low_int",1.0,1.0};
				frequency = "1.0 min (rpm + 0.5)";
				volume = "(1-camPos)*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			class EngineHighIn
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_high_int",1.0,1.0};
				frequency = "(rpm factor[0.5, 1.0])";
				volume = "(1-camPos)*(rpm factor[0.2, 1.0])";
			};
			class ForsageIn
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_forsage_int",0.63095737,1.0};
				frequency = "1";
				volume = "engineOn*(1-camPos)*(thrust factor[0.6, 1.0])";
			};
			class WindNoiseIn
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\noise",0.25118864,1.0};
				frequency = "(0.3+(1.005*(speed factor[1, 50])))";
				volume = "(1-camPos)*(speed factor[1, 50])";
			};
			class scrubLandInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\wheelsInt",1.0,1.0,100};
				frequency = 1;
				volume = "2 * (1-camPos) * (scrubLand factor[0.02, 0.05]) * (1 - (lateralMovement factor [0.7,1]))";
			};
			class scrubLandExt
			{
				sound[] = {"A3\Sounds_F\dummysound",1.0,1.0,100};
				frequency = 1;
				volume = "camPos * (scrubLand factor[0.02, 0.05]) * (1 - (lateralMovement factor [0.7,1]))";
			};
			class scrubBuildingInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\wheelsInt",1.0,1.0,100};
				frequency = 1;
				volume = "(1-camPos) * (scrubBuilding factor[0.02, 0.05]) * (1 - (lateralMovement factor [0.7,1]))";
			};
			class scrubBuildingExt
			{
				sound[] = {"A3\Sounds_F\dummysound",1.0,1.0,100};
				frequency = 1;
				volume = "camPos * (scrubBuilding factor[0.02, 0.05])";
			};
			class RainExt
			{
				sound[] = {"A3\Sounds_F\vehicles\noises\rain2_ext",1.0,1.0,100};
				frequency = 1;
				volume = "camPos * (rain - rotorSpeed/2) * 2";
			};
			class RainInt
			{
				sound[] = {"A3\Sounds_F\vehicles\noises\rain2_ext",1.0,1.0,100};
				frequency = 1;
				volume = "(1-camPos)*(rain - rotorSpeed/2)*2";
			};
		};
		memoryPointTaskMarker = "TaskMarker_1_pos";
		slingLoadCargoMemoryPoints[] = {"SlingLoadCargo1","SlingLoadCargo2","SlingLoadCargo3","SlingLoadCargo4"};
		formationX = 30;
		formationZ = 30;
		class HitPoints
		{
			class HitHull
			{
				armor = 3;
				explosionShielding = 5;
				name = "HitHull";
				passThrough = 0.5;
				visual = "Hit_Hull";
				radius = 0.25;
				minimalHit = 0.02;
				depends = "Total";
				material = -1;
			};
			class HitEngine: HitHull
			{
				armor = 1.5;
				explosionShielding = 2;
				name = "HitEngine";
				passThrough = 0.5;
				visual = "Hit_Engine";
				radius = 0.25;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitFuel: HitHull
			{
				armor = 3;
				explosionShielding = 4;
				name = "HitFuel";
				passThrough = 0.5;
				visual = "Hit_Fuel";
				radius = 0.3;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitLAileron: HitHull
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitLAileron";
				passThrough = 0.1;
				visual = "Hit_AileronL";
				radius = 0.2;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitRAileron: HitLAileron
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitRAileron";
				passThrough = 0.1;
				visual = "Hit_AileronR";
				radius = 0.2;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitLCRudder: HitHull
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitLCRudder";
				passThrough = 0.1;
				visual = "Hit_RudderL";
				radius = 0.15;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitRRudder: HitLCRudder
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitRRudder";
				passThrough = 0.1;
				visual = "Hit_RudderR";
				radius = 0.15;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitLCElevator: HitHull
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitLCElevator";
				passThrough = 0.1;
				visual = "Hit_ElevatorL";
				radius = 0.2;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitRElevator: HitLCElevator
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitRElevator";
				passThrough = 0.1;
				visual = "Hit_ElevatorR";
				radius = 0.2;
				minimalHit = 0.1;
				depends = "0";
			};
			class HitOptic
			{
				armor = 0.5;
				explosionShielding = 0.5;
				name = "HitOptic";
				passThrough = 0.8;
				visual = "glass_optic";
				radius = 0.16;
				minimalHit = 0.1;
				depends = "0";
			};
		};
		class Exhausts
		{
			class Exhaust_Left
			{
				position = "pos_ExhaustsL_start_center";
				direction = "pos_ExhaustsL_end_center";
				effect = "ExhaustsEffectHeliComHP";
			};
			class Exhaust_Right
			{
				position = "pos_ExhaustsR_start_center";
				direction = "pos_ExhaustsR_end_center";
				effect = "ExhaustsEffectHeliComHP";
			};
		};
		class Armory
		{
			description = "$STR_A3_CfgVehicles_UAV_02_base_Armory0";
		};
		driveOnComponent[] = {};
		maximumLoad = 5;
		class TransportItems{};
		uavCameraDriverPos = "PiP0_pos";
		uavCameraDriverDir = "PiP0_dir";
		uavCameraGunnerPos = "laserstart";
		uavCameraGunnerDir = "commanderview";
		LODTurnedIn = 0;
		LODTurnedOut = 0;
		memoryPointLDust = "DustLeft";
		memoryPointRDust = "DustRight";
		memoryPointDriverOptics = "PiP0_pos";
		driverOpticsModel = "\orlan\2.p3d";
		driverForceOptics = 1;
		getInRadius = 0;
		class WingVortices{};
		class ViewPilot: ViewPilot
		{
			minFov = 0.25;
			maxFov = 1.25;
			initFov = 0.75;
			initAngleX = 0;
			minAngleX = -65;
			maxAngleX = 85;
			initAngleY = 0;
			minAngleY = -150;
			maxAngleY = 150;
		};
		class Viewoptics: ViewOptics
		{
			initAngleX = 0;
			minAngleX = 0;
			maxAngleX = 0;
			initAngleY = 0;
			minAngleY = 0;
			maxAngleY = 0;
			minFov = 0.25;
			maxFov = 1.25;
			initFov = 0.75;
			visionMode[] = {"Normal","Ti"};
			thermalMode[] = {0,1};
		};
		class AnimationSources {
			class mainturret_hide
			{
				source = "user";
				animPeriod = 1;
				initPhase = 0;
			};
			class optic_hit
			{
				source = "Hit";
				hitpoint = "HitOptic";
				raw = 1;
			};

		};
		class camShakeGForce
		{
			distance = 0;
			frequency = 2;
			minSpeed = 1;
			power = 0.1;
		};

		damageEffect = "UAVDestructionEffects";
		accuracy=0.2;
		aileronCoef[]={};
		aileronControlsSensitivityCoef=3;
		aileronSensitivity=1;
		airBrake=1;
		airBrakeFrictionCoef=20;
		airCapacity=10;
		airFriction0[]={100,50,12};
		airFriction1[]={100,50,12};
		airFriction2[]={100,50,12};
		altFullForce=2000;
		altNoForce=3000;
		angleOfIndicence=0;
		antiRollbarForceCoef=1;
		antiRollbarForceLimit=2;
		antiRollbarSpeedMax=179;
		antiRollbarSpeedMin=10;
		armor=1;
		armorLights=0.40000001;
		armorStructural=1;
		artilleryTarget=0;
		attendant=0;
		audible=0.1;
		autocenter=1;
		brakeDistance=500;
		cameraSmoothSpeed=5;
		camShakeCoef=0;
		canHideDriver=-1;
		canUseScanners=0;
		cargoAction[]={};
		cargoCanEject=1;
		cargoCompartments[]={0};
		cargoDoors[]={};
		cargoGetInAction[]=
		{
			"GetInHigh"
		};
		cargoGetOutAction[]=
		{
			"GetOutHigh"
		};
		cargoIsCoDriver[]={0};
		cargoPreciseGetInOut[]={0};
		cargoProxyIndexes[]={};
		castCargoShadow=0;
		castDriverShadow=0;
		coefInside=2;
		coefInsideHeur=2;
		coefSpeedInside=1;
		commanderCanSee=31;
		cost=10000;
		countermeasureActivationRadius=1;
		countsForScoreboard=1;
		crewCrashProtection=0.16;
		crewVulnerable=1;
		detectSkill=10;
		draconicForceXCoef=8;
		draconicForceYCoef=1;
		draconicForceZCoef=1;
		draconicTorqueXCoef=0.15000001;
		draconicTorqueYCoef=0;
		elevatorControlsSensitivityCoef=1.2;
		elevatorSensitivity=0.3;
		elevatorCoef[]={0,0.80000001,0.89999998,1,1.1,1.2,1.2,1.3,1.3,1.3,1.4,1.4,1.4};
		envelope[]={0,2.5999999,2.8,2.5,2,1.8200001,1.75,1.63,1.55,2,2,2,1,1};
		epeImpulseDamageCoef=100;
		expansion=3;
		explosionShielding=2;
		flaps=1;
		flapsFrictionCoef=0.5;
		flareVelocity=100;
		forceHideDriver=0;
		formationTime=10;
		fuelCapacity=2863;
        fuelConsumptionRate=0.0099999998;
		fuelExplosionPower=0;
		gearAnimations[]={};
		gearDownTime=2;
		gearRetracting=0;
		gearsUpFrictionCoef=0.5;
		gearUpTime=3.3299999;
		headGforceLeaningFactor[]={0.0049999999,0.001,0.025};
		htMax=1800;
		htMin=60;
		impactEffectSpeedLimit=8;
		indirectHitCivilianCoefAI=-20;
		indirectHitEnemyCoefAI=10;
		indirectHitFriendlyCoefAI=-20;
		indirectHitUnknownCoefAI=-0.5;
		insideDetectCoef=0.0099999998;
		insideSoundCoef=0.0116228;
		isbackpack=0;
		isUav=1;
		killFriendlyExpCoef=1;
		landingAoa=0;
		landingSpeed=0;
		laserTarget=0;
		limitedSpeedCoef=1;
		maxFordingDepth=0.001;
		maxGForce=2;
		maxSpeed=179;
		mFact=0;
		mfMax=50;
		normalSpeedForwardCoef=1;
		noseDownCoef=0;
		numberPhysicalWheels=0;
		nvScanner=0;
		nvTarget=0;
		precision=200;
		predictTurnPlan=1;
		predictTurnSimul=1.2;
		preferRoads=0;
		radarTarget=1;
		rudderCoef[]={0.80000001,1,1,0.89999998,0.80000001,0.69999999,0.60000002};
		rudderControlsSensitivityCoef=4;
		rudderInfluence=0.96194702;
		secondaryExplosion=-1;
		sensitivity=2.5;
		sensitivityEar=0.0074999998;
		showCrewAim=0;
		stallSpeed=140;
		steerAheadPlan=2;
		steerAheadSimul=1;
		supplyRadius=1.2;
		tailHook=0;
		tBody=0;
		threat[]={0.5,1,0.1};
		thrustCoef[]={0,4.8000002,4.1999998,3.4000001,3.2,2.8,2.7,2.5999999,1.8,1.4,0.75,0.5,0,0,0,0};
		throttleToThrustLogFactor = 1;
		type=2;
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		visualTarget=1;
		vtol=0;
		VTOLPitchInfluence=2;
		VTOLRollInfluence=2;
		VTOLYawInfluence=2;
		waterAngularDampingCoef=0;
		waterDamageEngine=0.2;
		waterEffect="HeliWater";
		waterLeakiness=100;
		waterLinearDampingCoefX=0;
		waterLinearDampingCoefY=0;
		waterPPInVehicle=1;
		waterResistance=1;
		waterResistanceCoef=0.5;
		weaponsGroup1="";
		weaponsGroup2="";
		weaponsGroup3="";
		weaponsGroup4="";
		weaponSlots=0;
		wheelCircumference=1;
		wheelSteeringSensitivity=0.5;
		windSockExist=0;
		selectionDamage= "damage";
		class Damage
		{
			tex[] = {

			};
			mat[] = {
				"A3\air_f_heli\heli_transport_04\data\heli_transport_04_glass.rvmat", // material mapped in model
				"A3\air_f_heli\heli_transport_04\data\heli_transport_04_glass_damage.rvmat", // changes to this one once damage of the part reaches 0.5
				"A3\Air_F\Heli_Light_02\Data\Heli_Light_02_glass_destruct.rvmat", // changes to this one once damage of the part reaches 1
				"orlan\textures\cam.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_damage.rvmat",
				"a3\data_f\destruct\default_destruct_exterior.rvmat",
				"orlan\textures\orlan.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_damage.rvmat",
				"a3\data_f\destruct\default_destruct_exterior.rvmat"
			};
		};
		hiddenSelections[] = {"camo1"};
		hiddenSelectionsTextures[] = {"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_CO.paa"};
		weapons[]={};
		magazines[]={};
		hideWeaponsDriver = 1;
		radarTargetSize = 1;
		visualTargetSize = 1;
		irTargetSize = 1;
		lockDetectionSystem = 0;
		incomingMissileDetectionSystem = "0";
		laserscanner = 1;
		showAllTargets = 4;
		receiveRemoteTargets = 1;
		reportRemoteTargets = 1;
		reportOwnPosition = 1;
		class EventHandlers
		{
			class orlan_events
			{
				init="_this spawn orlan_fnc_opticAnim";
				killed = "(missionNamespace getVariable [""bis_fnc_moduleRemoteControl_unit"", player]) connectTerminalToUAV objNull";
			};
		};
		class Components: Components
		{
			class SensorsManagerComponent
			{
				class Components
				{
					class IRSensorComponent: SensorTemplateIR
					{
						class AirTarget
						{
							minRange = 1;
							maxRange = 5;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = 1;
						};
						class GroundTarget
						{
							minRange = 1;
							maxRange = 5;
							objectDistanceLimitCoef = 1;
							viewDistanceLimitCoef = 1;
						};
						maxTrackableSpeed = 50;
						angleRangeHorizontal = 51;
						angleRangeVertical = 37;
						animDirection = "mainGun";
						aimDown = -0.5;
					};
					class VisualSensorComponent: SensorTemplateVisual
					{
						class AirTarget
						{
							minRange = 1;
							maxRange = 5;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = 1;
						};
						class GroundTarget
						{
							minRange = 1;
							maxRange = 5;
							objectDistanceLimitCoef = 1;
							viewDistanceLimitCoef = 1;
						};
						maxTrackableSpeed = 50;
						angleRangeHorizontal = 51;
						angleRangeVertical = 37;
						animDirection = "mainGun";
						aimDown = -0.5;
					};
					class PassiveRadarSensorComponent: SensorTemplatePassiveRadar
					{
						class AirTarget
						{
							minRange = 1;
							maxRange = 5;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = -1;
						};
						class GroundTarget
						{
							minRange = 1;
							maxRange = 5;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = -1;
						};
					};
					class LaserSensorComponent: SensorTemplateLaser{};
					class NVSensorComponent: SensorTemplateNV{};
				};
			};
			class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft
			{
				class components
				{
					class EmptyDisplay
					{
						componentType = "EmptyDisplayComponent";
					};
				};
			};
			class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight
			{
				defaultDisplay = "SensorDisplay";
				class components
				{
					class EmptyDisplay
					{
						componentType = "EmptyDisplayComponent";
					};
				};
			};
		};
		class Turrets
		{
			class MainTurret: NewTurret
			{
				isCopilot = 0;
				minElev = -85;
				maxElev = 1;
				initElev = 0;
				minTurn = -360;
				maxTurn = 360;
				initTurn = 0;
				maxHorizontalRotSpeed = 10.0;
				maxVerticalRotSpeed = 10.0;
				outGunnerMayFire = 1;
				inGunnerMayFire = 1;
				commanding = -1;
				body = "mainTurret";
				gun = "mainGun";
				animationSourceBody = "mainTurret";
				animationSourceGun = "mainGun";
				memoryPointGun = "laserstart";
				memoryPointGunnerOptics = "commanderview";
				gunBeg = "commanderview";
				gunEnd = "laserstart";
				gunnerOpticsModel = "A3\drones_f\Weapons_F_Gamma\Reticle\UGV_01_Optics_Gunner_F.p3d";
				gunnerForceOptics = 1;
				turretInfoType="RscOptics_Offroad_01";
				stabilizedInAxes = 3;
				enableManualFire = 0;
				showAllTargets = 4;
				weapons[] = {"Laserdesignator_mounted"};
				magazines[] = {"Laserbatteries"};
				soundServo[] = {"A3\Sounds_F\vehicles\air\noises\servo_drone_turret_2",0.05623413,1,10};
				soundServoVertical[] = {"A3\Sounds_F\vehicles\air\noises\servo_drone_turret_2",0.05623413,1,10};
				GunnerCompartments = "Compartment1";
				startEngine = 0;
				LODTurnedIn = 0;
				LODTurnedOut = 0;
				class OpticsIn
				{
					class Wide
					{
						opticsDisplayName = "0.5x";
						initAngleX = 0;
						minAngleX = -30;
						maxAngleX = 30;
						initAngleY = 0;
						minAngleY = -100;
						maxAngleY = 100;
						initFov = 0.5;
						minFov = 0.5;
						maxFov = 0.5;
						directionStabilized = 1;
						visionMode[] = {"Normal","Ti"};
						thermalMode[] = {0,1};
						gunnerOpticsModel = "\orlan\1.p3d";
					};
					class Medium: Wide
					{
						opticsDisplayName = "2.5x";
						initFov = 0.1;
						minFov = 0.1;
						maxFov = 0.1;
						gunnerOpticsModel = "\orlan\1.p3d";
					};
					class Narrow: Wide
					{
						opticsDisplayName = "5x";
						initFov = 0.05;
						minFov = 0.05;
						maxFov = 0.05;
						gunnerOpticsModel = "\orlan\1.p3d";
					};
					class Close: Wide
					{
						opticsDisplayName = "10x";
						initFov = 0.025;
						minFov = 0.025;
						maxFov = 0.025;
						gunnerOpticsModel = "\orlan\1.p3d";
					};
					class SupClose: Wide
					{
						opticsDisplayName = "20x";
						initFov = 0.0125;
						minFov = 0.0125;
						maxFov = 0.0125;
						gunnerOpticsModel = "\orlan\3.p3d";
					};
				};
				class OpticsOut
				{
					class Monocular
					{
						initAngleX = 0;
						minAngleX = -30;
						maxAngleX = 30;
						initAngleY = 0;
						minAngleY = -100;
						maxAngleY = 100;
						initFov = 1.1;
						minFov = 0.133;
						maxFov = 1.1;
						visionMode[] = {"Normal","Ti"};
						gunnerOpticsModel = "";
						gunnerOpticsEffect[] = {};
					};
				};
				class Components
				{
					class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft
					{
						class components
						{
							class EmptyDisplay
							{
								componentType = "EmptyDisplayComponent";
							};
						};
					};
					class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight
					{
						defaultDisplay = "SensorDisplay";
						class components
						{
							class EmptyDisplay
							{
								componentType = "EmptyDisplayComponent";
							};
						};
					};
				};
			};
		};
	};

	class orlan_F_BLU: orlan_F_OPF
	{
		side=1;
		faction = "BLU_F";
		crew = "B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
	};

	class orlan_F_IND: orlan_F_OPF
	{
		side=2;
		faction = "IND_F";
		crew = "I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
	};

	class Box_EAF_WpsSpecial_F;
	class orlan_reloadBox : Box_EAF_WpsSpecial_F
	{
		displayName = "Orlan Box";

		ace_dragging_canDrag = 1;  // Can be dragged (0-no, 1-yes)
        ace_dragging_ignoreWeight = 1; // Ignore weight limitation for dragging (0-no, 1-yes)

        ace_dragging_canCarry = 0;  // Can be carried (0-no, 1-yes)
        ace_dragging_ignoreWeightCarry = 0; // Ignore weight limitation for carrying (0-no, 1-yes)

		class EventHandlers
		{
			class orlan_events
			{
				init = "(_this # 0) setVariable ['used', false, true]; clearWeaponCargoGlobal (_this # 0); clearItemCargoGlobal (_this # 0); clearMagazineCargoGlobal (_this # 0);";
			};
		};
	};
};