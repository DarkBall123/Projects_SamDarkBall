class SensorTemplatePassiveRadar;
class SensorTemplateAntiRadiation;
class SensorTemplateActiveRadar;
class SensorTemplateIR;
class SensorTemplateVisual;
class SensorTemplateMan;
class SensorTemplateLaser;
class SensorTemplateNV;
class SensorTemplateDataLink;

class DefaultVehicleSystemsDisplayManagerLeft  { class components; };
class DefaultVehicleSystemsDisplayManagerRight { class components; };

class CfgVehicles
{
	// ===== VANILLA BASES =====
	class Air;
	class Helicopter: Air
	{
		class Turrets;
		class HitPoints;
	};
	class Helicopter_Base_F: Helicopter
	{
		class Turrets: Turrets { class MainTurret; };
		class HitPoints: HitPoints
		{
			class HitHRotor;
			class HitHull;
		};
		class AnimationSources;
		class EventHandlers;
		class ViewOptics;
		class ViewPilot;
		class Components;
	};

	// =====================================================================
	// vnd BASE DRONE
	// =====================================================================
	class drone_fpv_base_F: Helicopter_Base_F
	{
		features = "Randomization: No<br />Camo selections: 1 - the whole body<br />Script door sources: None<br />Script animations: None<br />Executed scripts: None<br />Firing from vehicles: No<br />Slingload: No<br />Cargo proxy indexes: None";
		author = "$Sam";
		mapSize = 4;

		class SpeechVariants
		{
			class Default
			{
				speechSingular[] = {"veh_air_UAV_s"};
				speechPlural[]   = {"veh_air_UAV_p"};
			};
		};
		textSingular = "$STR_A3_nameSound_veh_air_UAV_s";
		textPlural   = "$STR_A3_nameSound_veh_air_UAV_p";
		nameSound    = "veh_air_UAV_s";

		_generalMacro     = "drone_fpv_base_F";
		editorSubcategory = "EdSubcat_Drones";
		scope = 0;

		displayName = "$STR_A3_CfgVehicles_UAV_01_base0";
		isUav = 1;

		uavCameraDriverPos = "pip_pilot_pos";
		uavCameraDriverDir = "pip_pilot_dir";
		uavCameraGunnerPos = "";
		uavCameraGunnerDir = "";

		extCameraPosition[] = {0,-0.25,-2.3499999};
		extCameraParams[]   = {0.93,10,30,0.25,1,10,30,0,1};

		formationX = 10;
		formationZ = 10;

		memoryPointTaskMarker   = "TaskMarker_1_pos";
		memoryPointDriverOptics = "pip_pilot_pos";

		driverOpticsModel = "\vnd_main\empty_hud.p3d";
		GunnerOpticsModel = "\vnd_main\empty_hud.p3d";

		driverForceOptics = 1;
		disableInventory  = 1;

		unitInfoType          = "RscUnitInfoParachute";
		unitInfoTypeRTD       = "RscUnitInfoParachute";
		driverWeaponsInfoType = "RscOptics_Offroad_01";

		getInRadius = 0;

		damageEffect   = "UAVDestructionEffects";
		damageTexDelay = 0.5;
		dustEffect  = "UAVDust";
		waterEffect = "UAVWater";

		washDownDiameter = "10.0f";
		washDownStrength = "0.25f";

		killFriendlyExpCoef = 0.1;

		accuracy   = 1.5;
		camouflage = 0.5;
		audible    = 0.1;
		armor      = 0.5;
		cost       = 20000;

		altFullForce = 1400;
		altNoForce   = 2600;

		LODTurnedIn  = -1;
		LODTurnedOut = -1;

		epeImpulseDamageCoef = 5;
		fuelExplosionPower   = 0;

		vehicleClass = "Autonomous";

		model   = "\vnd_main\drone.p3d";
		icon    = "\vnd_main\data\drononmap.paa";
		picture = "\vnd_main\data\drononmap.paa";

		startDuration = 3.8;
		maxSpeed      = 145;
		precision     = 20;

		steerAheadSimul = 0.85;
		steerAheadPlan  = 0.95;
		predictTurnPlan = 3.5;
		predictTurnSimul= 1.3;

		liftForceCoef          = 1.65;
		cyclicAsideForceCoef   = 0.35;
		cyclicForwardForceCoef = 0.6;
		bodyFrictionCoef       = 0.25;
		backRotorForceCoef     = 10.0;
		rudderInfluence        = 1.0;

		fuelCapacity    = 30;
		fuelUsageCoef = 0;
		maxFordingDepth = 0.3;

		threat[] = {0.1,0.1,0.1};

		maxMainRotorDive     = 0;
		minMainRotorDive     = 0;
		neutralMainRotorDive = 0;

		gearRetracting   = 0;
		mainRotorSpeed   = -7;
		backRotorSpeed   = 7;
		tailBladeVertical= 0;

		radarTargetSize  = 0.1;
		visualTargetSize = 0.1;
		irTarget = 0;

		lockDetectionSystem            = 0;
		incomingMissileDetectionSystem = 0;

		weapons[]   = {};
		magazines[] = {};

		irScanRangeMin    = 0;
		irScanRangeMax    = 0;
		irScanToEyeFactor = 1;

		class TransportItems {};

		destrType = "DestructDefault";

		driverCompartments = "Compartment3";
		cargoCompartments[] = {"Compartment2"};

		class HitPoints: HitPoints
		{
			class HitHull:   HitHull   { armor = 0.1; };
			class HitHRotor: HitHRotor { armor = 0.3; };
		};

		class Damage
		{
			tex[] = {};
			mat[] =
			{
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01_damage.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01_destruct.rvmat"
			};
		};

		class ViewPilot: ViewPilot
		{
			minFov=0.25; maxFov=1.25; initFov=1;
			initAngleX=0; minAngleX=-65; maxAngleX=85;
			initAngleY=0; minAngleY=-150; maxAngleY=150;
		};
		class ViewOptics: ViewOptics
		{
			initAngleX=0; minAngleX=0; maxAngleX=0;
			initAngleY=0; minAngleY=0; maxAngleY=0;
			minFov=1.25; maxFov=1.25; initFov=1.25;
			visionMode[]  = {"Normal"};
			thermalMode[] = {0,1};
		};

		class MFD {};

		enableManualFire    = 1;
		reportRemoteTargets = 1;
		reportOwnPosition   = 1;

		class Components: Components
		{
			class VehicleSystemsDisplayManagerComponentLeft:  DefaultVehicleSystemsDisplayManagerLeft  { class components {}; };
			class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight { class components {}; };
		};

		class Turrets {};

		attenuationEffectType = "OpenHeliAttenuation";

		soundGetIn[]   = {"",1,1};
		soundGetOut[]  = {"",1,1,50};
		soundEnviron[] = {"",0.031622775,1};
		soundDammage[] = {"",0.56234133,1};

		soundEngineOnInt[]  = {"vnd_main\sounds\quad_start_full_int.wav",0.56234133,1};
		soundEngineOnExt[]  = {"vnd_main\sounds\quad_start_full_01.wav",0.56234133,1,200};
		soundEngineOffInt[] = {"vnd_main\sounds\quad_stop_full_int.wav",0.56234133,1};
		soundEngineOffExt[] = {"vnd_main\sounds\quad_stop_full_01.wav",0.56234133,1,200};

		soundBushCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",1,1,100};
		soundBushCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",1,1,100};
		soundBushCollision3[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",1,1,100};
		soundBushCrash[]      = {"soundBushCollision1",0.33,"soundBushCollision2",0.33,"soundBushCollision3",0.33};

		soundWaterCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",1,1,100};
		soundWaterCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",1,1,100};
		soundWaterCrashes[]    = {"soundWaterCollision1",0.5,"soundWaterCollision2",0.5};

		Crash0[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1",1,1,900};
		Crash1[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2",1,1,900};
		Crash2[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3",1,1,900};
		Crash3[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4",1,1,900};
		soundCrashes[] = {"Crash0",0.25,"Crash1",0.25,"Crash2",0.25,"Crash3",0.25};

		class Sounds
		{
			class Engine
			{
				sound[]   = {"vnd_main\sounds\quad_engine_full_01.wav",0.44668359,1,200};
				frequency = "rotorSpeed";
				volume    = "camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorLowOut
			{
				sound[]   = {"A3\Sounds_F\air\Uav_01\blade",0.31622776,1,200};
				frequency = "rotorSpeed";
				volume    = "camPos*(0 max (rotorSpeed-0.1))";
				cone[]    = {1.6,3.14,1.6,0.95};
			};
			class RotorHighOut
			{
				sound[]   = {"A3\Sounds_F\air\Uav_01\blade_high",0.31622776,1,250};
				frequency = "rotorSpeed";
				volume    = "camPos*10*(0 max (rotorThrust-0.9))";
				cone[]    = {1.6,3.14,1.6,0.95};
			};
			class EngineIn
			{
				sound[]   = {"vnd_main\sounds\quad_engine_full_int.wav",0.56234133,1};
				frequency = "rotorSpeed";
				volume    = "(1-camPos)*((rotorSpeed-0.75)*4)";
			};
			class RotorLowIn
			{
				sound[]   = {"",0.56234133,1};
				frequency = "rotorSpeed";
				volume    = "(1-camPos)*(0 max (rotorSpeed-0.1))";
			};
			class RotorHighIn
			{
				sound[]   = {"",0.56234133,1};
				frequency = "rotorSpeed";
				volume    = "(1-camPos)*3*(rotorThrust-0.9)";
			};
		};

		class Exhausts
		{
			class Exhaust_1
			{
				position  = "Exhaust_1_pos";
				direction = "Exhaust_1_dir";
				effect    = "ExhaustsEffectDrone";
			};
		};

		class Library { libTextDesc = "$STR_A3_CfgVehicles_UAV_01_base_Library0"; };
	};

	// =====================================================================
	// vnd KVN BASE
	// =====================================================================
	class vnd_KVN_Base: drone_fpv_base_F
	{
		scope = 0;

		class SimpleObject
		{
			eden = 1;
			animate[] =
			{
				{"damagehide",0},
				{"rotorimpacthide",0},
				{"tailrotorimpacthide",0},
				{"propeller1_rotation",0},
				{"propeller1_blur_rotation",0},
				{"propeller2_rotation",0},
				{"propeller2_blur_rotation",0},
				{"propeller3_rotation",0},
				{"propeller3_blur_rotation",0},
				{"propeller4_rotation",0},
				{"propeller4_blur_rotation",0},
				{"propeller1_hide",0},
				{"propeller1_blur_hide",0},
				{"propeller2_hide",0},
				{"propeller2_blur_hide",0},
				{"propeller3_hide",0},
				{"propeller3_blur_hide",0},
				{"propeller4_hide",0},
				{"propeller4_blur_hide",0},
				{"mainturret",0},
				{"maingun",-0.05}
			};
			hide[] = {"zasleh","tail rotor blur","main rotor blur","zadni svetlo","clan","podsvit pristroju","poskozeni"};
			verticalOffset      = 0.15;
			verticalOffsetWorld = -0.001;
			init = "''";
		};

		textureList[] = {"Indep",1};

		class EventHandlers
		{
			class vnd
			{
				hit  = "_this call DB_vnd_fnc_fpv_onDestroy";
				init = "(_this # 0) spawn DB_vnd_fnc_fpv_droneInit;";
			};
		};
	};

	// ================== BAG MACROS ==================
	#define KVN_BAG(BAGCLASS, BAGBASE, DISPLAY, TOCLASS) \
	class BAGCLASS: BAGBASE { \
		scope = 2; scopeCurator = 2; \
		displayName = DISPLAY; \
		author = "DarkBall"; \
		class assembleInfo { \
			assembleTo     = TOCLASS; \
			base           = ""; \
			displayName    = DISPLAY; \
			dissasembleTo[] = {}; \
			primary        = 1; \
		}; \
	};

	#define KVN_TI_BAG(BAGCLASS, BAGBASE, DISPLAY, TOCLASS) \
	class BAGCLASS: BAGBASE { \
		scope = 2; scopeCurator = 2; \
		displayName = DISPLAY; \
		author = "DarkBall; Sam"; \
		class assembleInfo { \
			assembleTo     = TOCLASS; \
			base           = ""; \
			displayName    = DISPLAY; \
			dissasembleTo[] = {}; \
			primary        = 1; \
		}; \
	};

	// ================== DRONE MACRO ==================
	#define KVN_VARIANT(CLASS, BASE, SIDEID, FACTION, CREW, DNAME, PREVIEW, MODEL_PATH, BAGCLASS) \
	class CLASS: BASE { \
		scope = 2; scopeCurator = 2; \
		side = SIDEID; faction = FACTION; crew = CREW; typicalCargo[] = {CREW}; \
		displayName = DNAME; editorPreview = PREVIEW; model = MODEL_PATH; \
		author = "DarkBall; Sam"; \
		class assembleInfo { \
			primary = 0; \
			base = ""; \
			assembleTo = ""; \
			dissasembleTo[] = { BAGCLASS }; \
			displayName = ""; \
		}; \
	};

	// TI = Thermal variant (adds thermal vision)
	#define KVN_TI(CLASS, BASE, SIDEID, FACTION, CREW, DNAME, PREVIEW, MODEL_PATH, BAGCLASS) \
	class CLASS: BASE { \
		scope = 2; scopeCurator = 2; \
		side = SIDEID; faction = FACTION; crew = CREW; typicalCargo[] = {CREW}; \
		displayName = DNAME; editorPreview = PREVIEW; model = MODEL_PATH; \
		author = "DarkBall; Sam"; \
		class assembleInfo { \
			primary = 0; \
			base = ""; \
			assembleTo = ""; \
			dissasembleTo[] = { BAGCLASS }; \
			displayName = ""; \
		}; \
		class ViewOptics: ViewOptics { visionMode[] = {"Normal", "Ti"}; thermalMode[] = {0,1}; }; \
	};

	// ================== BASE BACKPACKS ==================
	class B_UAV_01_backpack_F;
	class O_UAV_01_backpack_F;
	class I_UAV_01_backpack_F;

	// ================== DRONES ==================
	// CSAT (OPFOR)
	KVN_VARIANT(O_KVN_AT, vnd_KVN_Base, 0, "OPF_F", "O_UAV_AI", "KVN AT", "\vnd_main\data\AT.jpg", "\vnd_main\drone.p3d",  O_KVN_AT_Bag)
	KVN_VARIANT(O_KVN_AP, O_KVN_AT,      0, "OPF_F", "O_UAV_AI", "KVN AP", "\vnd_main\data\AP.jpg",   "\vnd_main\drone2\drone2.p3d", O_KVN_AP_Bag)
	KVN_TI(O_KVN_AT_TI, O_KVN_AT,   0, "OPF_F", "O_UAV_AI", "KVN AT TI", "\vnd_main\data\AT.jpg", "\vnd_main\drone.p3d",  O_KVN_AT_TI_Bag)
	KVN_TI(O_KVN_AP_TI, O_KVN_AP,   0, "OPF_F", "O_UAV_AI", "KVN AP TI", "\vnd_main\data\AP.jpg",   "\vnd_main\drone2\drone2.p3d", O_KVN_AP_TI_Bag)

	// NATO (BLUFOR)
	KVN_VARIANT(B_KVN_AT, vnd_KVN_Base, 1, "BLU_F", "B_UAV_AI", "KVN AT", "\vnd_main\data\AT.jpg", "\vnd_main\drone.p3d",  B_KVN_AT_Bag)
	KVN_VARIANT(B_KVN_AP, B_KVN_AT,      1, "BLU_F", "B_UAV_AI", "KVN AP", "\vnd_main\data\AP.jpg",   "\vnd_main\drone2\drone2.p3d", B_KVN_AP_Bag)
	KVN_TI(B_KVN_AT_TI, B_KVN_AT,   1, "BLU_F", "B_UAV_AI", "KVN AT TI", "\vnd_main\data\AT.jpg", "\vnd_main\drone.p3d",  B_KVN_AT_TI_Bag)
	KVN_TI(B_KVN_AP_TI, B_KVN_AP,   1, "BLU_F", "B_UAV_AI", "KVN AP TI", "\vnd_main\data\AP.jpg",   "\vnd_main\drone2\drone2.p3d", B_KVN_AP_TI_Bag)

	// AAF (INDEP)
	KVN_VARIANT(I_KVN_AT, vnd_KVN_Base, 2, "IND_F", "I_UAV_AI", "KVN AT", "\vnd_main\data\AT.jpg", "\vnd_main\drone.p3d",  I_KVN_AT_Bag)
	KVN_VARIANT(I_KVN_AP, I_KVN_AT,      2, "IND_F", "I_UAV_AI", "KVN AP", "\vnd_main\data\AP.jpg",   "\vnd_main\drone2\drone2.p3d", I_KVN_AP_Bag)
	KVN_TI(I_KVN_AT_TI, I_KVN_AT,   2, "IND_F", "I_UAV_AI", "KVN AT TI", "\vnd_main\data\AT.jpg", "\vnd_main\drone.p3d",  I_KVN_AT_TI_Bag)
	KVN_TI(I_KVN_AP_TI, I_KVN_AP,   2, "IND_F", "I_UAV_AI", "KVN AP TI", "\vnd_main\data\AP.jpg",   "\vnd_main\drone2\drone2.p3d", I_KVN_AP_TI_Bag)

	// ================== BAGS ==================
	// OPFOR
	KVN_BAG(O_KVN_AT_Bag,    O_UAV_01_backpack_F, "KVN AT Bag OPFOR",     "O_KVN_AT")
	KVN_BAG(O_KVN_AP_Bag,    O_UAV_01_backpack_F, "KVN AP Bag OPFOR",     "O_KVN_AP")
	KVN_TI_BAG(O_KVN_AT_TI_Bag, O_UAV_01_backpack_F, "KVN AT TI Bag OPFOR",  "O_KVN_AT_TI")
	KVN_TI_BAG(O_KVN_AP_TI_Bag, O_UAV_01_backpack_F, "KVN AP TI Bag OPFOR",  "O_KVN_AP_TI")

	// BLUFOR
	KVN_BAG(B_KVN_AT_Bag,    B_UAV_01_backpack_F, "KVN AT Bag BLUFOR",    "B_KVN_AT")
	KVN_BAG(B_KVN_AP_Bag,    B_UAV_01_backpack_F, "KVN AP Bag BLUFOR",    "B_KVN_AP")
	KVN_TI_BAG(B_KVN_AT_TI_Bag, B_UAV_01_backpack_F, "KVN AT TI Bag BLUFOR", "B_KVN_AT_TI")
	KVN_TI_BAG(B_KVN_AP_TI_Bag, B_UAV_01_backpack_F, "KVN AP TI Bag BLUFOR", "B_KVN_AP_TI")

	// INDEP
	KVN_BAG(I_KVN_AT_Bag,    I_UAV_01_backpack_F, "KVN AT Bag IND",       "I_KVN_AT")
	KVN_BAG(I_KVN_AP_Bag,    I_UAV_01_backpack_F, "KVN AP Bag IND",       "I_KVN_AP")
	KVN_TI_BAG(I_KVN_AT_TI_Bag, I_UAV_01_backpack_F, "KVN AT TI Bag IND",    "I_KVN_AT_TI")
	KVN_TI_BAG(I_KVN_AP_TI_Bag, I_UAV_01_backpack_F, "KVN AP TI Bag IND",    "I_KVN_AP_TI")


	
};
