#include "Sting_config_macros.hpp"

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

#define STING_DISASSEMBLE(BAGCLASS) \
	class assembleInfo \
	{ \
		primary = 0; \
		base = ""; \
		assembleTo = ""; \
		dissasembleTo[] = { BAGCLASS }; \
		displayName = ""; \
	};

#define STING_BAG(BAGCLASS, BAGBASE, DISPLAY, TOCLASS) \
	class BAGCLASS: BAGBASE \
	{ \
		scope = 2; \
		scopeCurator = 2; \
		displayName = DISPLAY; \
		author = "DarkBall"; \
		class assembleInfo \
		{ \
			assembleTo = TOCLASS; \
			base = ""; \
			displayName = DISPLAY; \
			dissasembleTo[] = {}; \
			primary = 1; \
		}; \
	};

#define STING_SIDE_DRONE(CLASSNAME, BASECLASS, SIDEID, FACTIONID, CREWCLASS, DISPLAY, ITEMCLASS, BAGCLASS) \
	class CLASSNAME: BASECLASS \
	{ \
		scope = 2; \
		scopeCurator = 2; \
		side = SIDEID; \
		faction = FACTIONID; \
		crew = CREWCLASS; \
		typicalCargo[] = { CREWCLASS }; \
		displayName = DISPLAY; \
		DB_stingItem = ITEMCLASS; \
		STING_DISASSEMBLE(BAGCLASS) \
	};

class CfgVehicles
{
	class Air;
	class Helicopter: Air
	{
		class Turrets;
		class HitPoints;
	};
	class Helicopter_Base_F: Helicopter
	{
		class Turrets: Turrets
		{
			class MainTurret;
		};
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
	class sting_drone_base_F: Helicopter_Base_F
	{
		features = "Randomization: No<br />Script animations: None<br />Executed scripts: None<br />Firing from vehicles: No";
		author = "DarkBall & Sam";
		mapSize = 4;
		scope = 0;
		scopeCurator = 0;
		displayName = "Sting UAV";
		editorSubcategory = "EdSubcat_Drones";
		isUav = 1;
		uavCameraDriverPos = "pip_pilot_pos";
		uavCameraDriverDir = "pip_pilot_dir";
		uavCameraGunnerPos = "";
		uavCameraGunnerDir = "";
		extCameraPosition[] = {0, -0.25, -2.35};
		extCameraParams[] = {0.93, 10, 30, 0.25, 1, 10, 30, 0, 1};
		formationX = 10;
		formationZ = 10;
		memoryPointTaskMarker = "TaskMarker_1_pos";
		memoryPointDriverOptics = "pip_pilot_pos";
		memoryPointsGetInDriver = "pos_driver";
		memoryPointsGetInDriverDir = "pos_driver_dir";
		driverOpticsModel = QSTING_CFG_PATH(empty_hud.p3d);
		GunnerOpticsModel = QSTING_CFG_PATH(empty_hud.p3d);
		driverForceOptics = 1;
		driverCanSee = 63;
		forceHideDriver = 0;
		disableInventory = 1;
		unitInfoType = "RscOptics_AV_airplane_pilot";
		unitInfoTypeRTD = "RscOptics_AV_airplane_pilot";
		driverWeaponsInfoType = "RscOptics_AV_airplane_pilot";
		getInRadius = 0;
		preciseGetInOut = 1;
		damageEffect = "UAVDestructionEffects";
		damageTexDelay = 0.5;
		dustEffect = "UAVDust";
		waterEffect = "UAVWater";
		washDownDiameter = "10.0f";
		washDownStrength = "0.25f";
		killFriendlyExpCoef = 0;
		accuracy = 1.5;
		camouflage = 0.2;
		audible = 0.1;
		armor = 0.5;
		cost = 20000;
		altFullForce = 3000;
		altNoForce = 5000;
		LODTurnedIn = -1;
		LODTurnedOut = -1;
		epeImpulseDamageCoef = 5;
		fuelExplosionPower = 0;
		vehicleClass = "Autonomous";
		model = QSTING_CFG_PATH(drone_inter.p3d);
		icon = QSTING_CFG_DATA(drononmap.paa);
		picture = QSTING_CFG_DATA(drononmap.paa);
		hiddenSelections[] =
		{
			"body_0",
			"camera_0",
			"vint1_0",
			"vint2_0",
			"vint3_0",
			"vint4_0"
		};
		hiddenSelectionsTextures[] =
		{
			QSTING_CFG_PATH(mat0_co.paa),
			QSTING_CFG_PATH(mat0_co.paa),
			QSTING_CFG_PATH(mat0_co.paa),
			QSTING_CFG_PATH(mat0_co.paa),
			QSTING_CFG_PATH(mat0_co.paa),
			QSTING_CFG_PATH(mat0_co.paa)
		};
		DB_stingItem = "";
		DB_stingPayloadAmmo = "R_TBG32V_F";
		class Reflectors
		{
		};
		startDuration = 3;
		simulation = "airplanex";
		maxSpeed = 900;
		landingAoa = 0;
		landingSpeed = 110;
		stallSpeed = 70;
		stallWarningTreshold = 0.04;
		wheelSteeringSensitivity = 0.8;
		airBrake = 0;
		flaps = 0;
		gearsUpFrictionCoef = 0;
		airFrictionCoefs0[] = {0, 0, 0};
		airFrictionCoefs1[] = {0.08, 0.55, 0.0025};
		airFrictionCoefs2[] = {0.0007, 0.0065, 0.00002};
		angleOfIndicence = 0;
		envelope[] = {0.0, 0.12, 0.55, 1.25, 2.1, 2.7, 3.05, 3.15, 3.2, 3.15, 3.0, 2.4, 1.8};
		thrustCoef[] = {2.2, 2.15, 2.05, 1.95, 1.85, 1.75, 1.65, 1.5, 1.35, 1.1, 0.8, 0.35, 0.0};
		aileronSensitivity = 0.45;
		aileronCoef[] = {0.18, 0.28, 0.4, 0.5, 0.56, 0.6, 0.62, 0.61, 0.58, 0.53, 0.47, 0.4, 0.32};
		elevatorSensitivity = 0.55;
		elevatorCoef[] = {0.25, 0.38, 0.5, 0.58, 0.63, 0.66, 0.68, 0.67, 0.64, 0.6, 0.55, 0.48, 0.4};
		rudderInfluence = 0.88;
		rudderCoef[] = {0.25, 0.45, 0.7, 0.95, 1.15, 1.28, 1.38, 1.45, 1.48, 1.46, 1.4, 1.28, 1.1};
		aileronControlsSensitivityCoef = 1.4;
		elevatorControlsSensitivityCoef = 1.6;
		rudderControlsSensitivityCoef = 2.2;
		draconicForceXCoef = 4.5;
		draconicForceYCoef = 0.9;
		draconicForceZCoef = 0.8;
		draconicTorqueXCoef[] = {1.0, 1.2, 1.5, 1.8, 2.1, 2.3, 2.45, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8};
		draconicTorqueYCoef[] = {8, 6, 3.5, 1.8, 0.9, 0.4, 0.2, 0.1, 0, 0, 0, 0, 0};
		maxOmega = 4000;
		engineMoi = 0.08;
		dampingRateFullThrottle = 0.015;
		dampingRateZeroThrottleClutchEngaged = 0.03;
		dampingRateZeroThrottleClutchDisengaged = 0.03;
		precision = 4;
		// AI steering look-ahead and turn prediction distances in meters.
		steerAheadSimul = 1.2;
		steerAheadPlan = 1.5;
		predictTurnPlan = 3.8;
		predictTurnSimul = 3.2;
		fuelCapacity = 3.0;
		maxFordingDepth = 0.3;
		threat[] = {0, 0, 0};
		maxMainRotorDive = 0;
		minMainRotorDive = 0;
		neutralMainRotorDive = 0;
		gearRetracting = 0;
		mainRotorSpeed = -7;
		backRotorSpeed = 7;
		tailBladeVertical = 0;
		radarTarget = 0;
		radarTargetSize = 0.02;
		visualTargetSize = 0.05;
		irTarget = 0;
		irTargetSize = 0.01;
		lockDetectionSystem = 0;
		incomingMissileDetectionSystem = 0;
		weapons[] = {};
		magazines[] = {};
		irScanRangeMin = 0;
		irScanRangeMax = 0;
		irScanToEyeFactor = 1;
		class TransportItems
		{
		};
		destrType = "DestructDefault";
		driverCompartments = "Compartment3";
		cargoCompartments[] =
		{
			"Compartment2"
		};
		class HitPoints: HitPoints
		{
			class HitHull: HitHull
			{
				armor = 0.1;
			};
			class HitHRotor: HitHRotor
			{
				armor = 0.3;
			};
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
			minFov = 0.25;
			maxFov = 1.25;
			initFov = 1;
			initAngleX = 0;
			minAngleX = -65;
			maxAngleX = 85;
			initAngleY = 0;
			minAngleY = -150;
			maxAngleY = 150;
		};
		class ViewOptics: ViewOptics
		{
			initAngleX = 0;
			minAngleX = 0;
			maxAngleX = 0;
			initAngleY = 0;
			minAngleY = 0;
			maxAngleY = 0;
			minFov = 1.25;
			maxFov = 1.25;
			initFov = 1.25;
			visionMode[] =
			{
				"Normal"
			};
			thermalMode[] = {};
		};
		class MFD
		{
		};
		class PilotCamera
		{
			minTurn = -27;
			maxTurn = 27;
			initTurn = 0;
			minElev = -35;
			maxElev = 90;
			initElev = 0;
			maxXRotSpeed = 1;
			maxYRotSpeed = 1;
			maxMouseXRotSpeed = 0.5;
			maxMouseYRotSpeed = 0.5;
			pilotOpticsShowCursor = 1;
			controllable = 1;
			class OpticsIn
			{
				class Wide
				{
					opticsDisplayName = "WFOV";
					initAngleX = 0;
					minAngleX = 0;
					maxAngleX = 0;
					initAngleY = 0;
					minAngleY = 0;
					maxAngleY = 0;
					initFov = 0.8;
					minFov = 0.028;
					maxFov = 0.8;
					directionStabilized = 1;
					visionMode[] =
					{
						"Normal"
					};
					thermalMode[] = {};
					gunnerOpticsModel = QSTING_CFG_PATH(empty_hud.p3d);
					opticsPPEffects[] =
					{
						"OpticsCHAbera2",
						"OpticsBlur2"
					};
				};
				class Medium: Wide
				{
					opticsDisplayName = "MFOV";
					initFov = 0.25;
					minFov = 0.25;
					maxFov = 0.25;
					gunnerOpticsModel = QSTING_CFG_PATH(empty_hud.p3d);
				};
				class Narrow: Wide
				{
					opticsDisplayName = "NFOV";
					initFov = 0.08;
					minFov = 0.08;
					maxFov = 0.08;
					gunnerOpticsModel = QSTING_CFG_PATH(empty_hud.p3d);
				};
				showMiniMapInOptics = 1;
				showUAVViewInOptics = 0;
				showSlingLoadManagerInOptics = 0;
			};
		};
		enableManualFire = 1;
		reportRemoteTargets = 1;
		reportOwnPosition = 1;
		class Components: Components
		{
			class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft
			{
				class components
				{
				};
			};
			class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight
			{
				class components
				{
				};
			};
		};
		class Turrets
		{
		};
		class EventHandlers
		{
			class Sting
			{
				hit = "_this call DB_fnc_sting_onDestroy";
				init = "(_this # 0) call DB_fnc_sting_droneInit;";
			};
		};
		attenuationEffectType = "OpenHeliAttenuation";
		soundGetIn[] = {"", 1, 1};
		soundGetOut[] = {"", 1, 1, 50};
		soundEnviron[] = {"", 0.031622775, 1};
		soundDammage[] = {"", 0.56234133, 1};
		soundEngineOnInt[] = {QSTING_CFG_SOUND(quad_start_full_int.wav), 0.56234133, 1};
		soundEngineOnExt[] = {QSTING_CFG_SOUND(quad_start_full_01.wav), 0.56234133, 1, 200};
		soundEngineOffInt[] = {QSTING_CFG_SOUND(quad_stop_full_int.wav), 0.56234133, 1};
		soundEngineOffExt[] = {QSTING_CFG_SOUND(quad_stop_full_01.wav), 0.56234133, 1, 200};
		class Exhausts
		{
			class Exhaust_1
			{
				position = "pos_pilotcamera";
				direction = "pos_pilotcamera_dir";
				effect = "ExhaustsEffectDrone";
			};
		};
		class Sounds
		{
			class Engine
			{
				sound[] = {QSTING_CFG_SOUND(quad_engine_full_01.wav), 0.44668359, 1, 200};
				frequency = "rotorSpeed";
				volume = "camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorLowOut
			{
				sound[] = {"A3\Sounds_F\air\Uav_01\blade", 0.31622776, 1, 200};
				frequency = "rotorSpeed";
				volume = "camPos*(0 max (rotorSpeed-0.1))";
				cone[] = {1.6, 3.14, 1.6, 0.95};
			};
			class RotorHighOut
			{
				sound[] = {"A3\Sounds_F\air\Uav_01\blade_high", 0.31622776, 1, 250};
				frequency = "rotorSpeed";
				volume = "camPos*10*(0 max (rotorThrust-0.9))";
				cone[] = {1.6, 3.14, 1.6, 0.95};
			};
			class EngineIn
			{
				sound[] = {QSTING_CFG_SOUND(quad_engine_full_int.wav), 0.56234133, 1};
				frequency = "rotorSpeed";
				volume = "(1-camPos)*((rotorSpeed-0.75)*4)";
			};
			class RotorLowIn
			{
				sound[] = {"", 0.56234133, 1};
				frequency = "rotorSpeed";
				volume = "(1-camPos)*(0 max (rotorSpeed-0.1))";
			};
			class RotorHighIn
			{
				sound[] = {"", 0.56234133, 1};
				frequency = "rotorSpeed";
				volume = "(1-camPos)*3*(rotorThrust-0.9)";
			};
		};
		class UserActions
		{
			class DisassembleUAV
			{
				displayName = "Put in inventory";
				priority = 0.5;
				radius = 7;
				position = "";
				showWindow = 0;
				onlyForPlayer = 1;
				icon = "";
				condition = "[this] call DB_fnc_sting_canDisassembly";
				statement = "[this, player] call DB_fnc_sting_addUavToInventory";
			};
		};
	};
	class sting_drone_ti_base_F: sting_drone_base_F
	{
		displayName = "Sting UAV TI";
		class ViewOptics: ViewOptics
		{
			visionMode[] =
			{
				"Normal",
				"TI"
			};
			thermalMode[] = {0, 1};
		};
		class PilotCamera: PilotCamera
		{
			class OpticsIn: OpticsIn
			{
				class Wide: Wide
				{
					visionMode[] =
					{
						"Normal",
						"TI"
					};
					thermalMode[] = {0, 1};
				};
				class Medium: Medium
				{
					visionMode[] =
					{
						"Normal",
						"TI"
					};
					thermalMode[] = {0, 1};
				};
				class Narrow: Narrow
				{
					visionMode[] =
					{
						"Normal",
						"TI"
					};
					thermalMode[] = {0, 1};
				};
			};
		};
	};
	class B_UAV_01_backpack_F;
	class O_UAV_01_backpack_F;
	class I_UAV_01_backpack_F;

	STING_SIDE_DRONE(O_Sting_F, sting_drone_base_F, 0, "OPF_F", "O_UAV_AI", "Sting UAV (OPFOR)", "Item_Sting", O_Sting_Bag)
	STING_SIDE_DRONE(B_Sting_F, sting_drone_base_F, 1, "BLU_F", "B_UAV_AI", "Sting UAV (BLUFOR)", "Item_Sting", B_Sting_Bag)
	STING_SIDE_DRONE(I_Sting_F, sting_drone_base_F, 2, "IND_F", "I_UAV_AI", "Sting UAV (Independent)", "Item_Sting", I_Sting_Bag)
	STING_SIDE_DRONE(O_Sting_TI_F, sting_drone_ti_base_F, 0, "OPF_F", "O_UAV_AI", "Sting UAV TI (OPFOR)", "Item_Sting_TI", O_Sting_TI_Bag)
	STING_SIDE_DRONE(B_Sting_TI_F, sting_drone_ti_base_F, 1, "BLU_F", "B_UAV_AI", "Sting UAV TI (BLUFOR)", "Item_Sting_TI", B_Sting_TI_Bag)
	STING_SIDE_DRONE(I_Sting_TI_F, sting_drone_ti_base_F, 2, "IND_F", "I_UAV_AI", "Sting UAV TI (Independent)", "Item_Sting_TI", I_Sting_TI_Bag)

	STING_BAG(O_Sting_Bag, O_UAV_01_backpack_F, "Sting Bag OPFOR", "O_Sting_F")
	STING_BAG(B_Sting_Bag, B_UAV_01_backpack_F, "Sting Bag BLUFOR", "B_Sting_F")
	STING_BAG(I_Sting_Bag, I_UAV_01_backpack_F, "Sting Bag IND", "I_Sting_F")
	STING_BAG(O_Sting_TI_Bag, O_UAV_01_backpack_F, "Sting TI Bag OPFOR", "O_Sting_TI_F")
	STING_BAG(B_Sting_TI_Bag, B_UAV_01_backpack_F, "Sting TI Bag BLUFOR", "B_Sting_TI_F")
	STING_BAG(I_Sting_TI_Bag, I_UAV_01_backpack_F, "Sting TI Bag IND", "I_Sting_TI_F")
};
