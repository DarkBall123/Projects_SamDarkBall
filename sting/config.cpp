#define QSTR(x) #x
#define QSTING(P) QSTR(\sting\P)
#define QSTING_SOUND(P) QSTR(\sting\sounds\P)
#define QSTING_UI(P) QSTR(\sting\ui\P)

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

class CfgPatches
{
	class sting_data
	{
		addonRootClass = "A3_Drones_F";
		author = "Sam";
		name = "Sting Drone";
		requiredAddons[] =
		{
			"A3_Data_F_AoW_Loadorder",
			"A3_Data_F",
			"A3_Drones_F"
		};
		requiredVersion = 0.1;
		units[] =
		{
			"O_Sting_F",
			"B_Sting_F",
			"I_Sting_F"
		};
		weapons[] = {};
	};
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
		author = "Sam";
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
		extCameraPosition[] = {0,-0.25,-2.35};
		extCameraParams[] = {0.93,10,30,0.25,1,10,30,0,1};
		formationX = 10;
		formationZ = 10;
		memoryPointTaskMarker = "TaskMarker_1_pos";
		memoryPointDriverOptics = "pip_pilot_pos";
		memoryPointsGetInDriver = "pos_driver";
		memoryPointsGetInDriverDir = "pos_driver_dir";
		driverOpticsModel = "A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_wide_F.p3d";
		GunnerOpticsModel = "A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_wide_F.p3d";
		driverForceOptics = 1;
		driverCanSee = 31 + 32;
		forceHideDriver = 0;
		disableInventory = 1;
		unitInfoType = "RscUnitInfoParachute";
		unitInfoTypeRTD = "RscUnitInfoParachute";
		driverWeaponsInfoType = "RscOptics_Offroad_01";
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
		altFullForce = 1000;
		altNoForce = 2000;
		LODTurnedIn = -1;
		LODTurnedOut = -1;
		epeImpulseDamageCoef = 5;
		fuelExplosionPower = 0;
		vehicleClass = "Autonomous";
		model = QSTING(drone_inter.p3d);
		icon = QSTING_UI(drononmap.paa);
		picture = QSTING_UI(drononmap.paa);
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
			QSTING(mat0_co.paa),
			QSTING(mat0_co.paa),
			QSTING(mat0_co.paa),
			QSTING(mat0_co.paa),
			QSTING(mat0_co.paa),
			QSTING(mat0_co.paa)
		};
		class Reflectors
		{
		};
		startDuration = 3;
		maxSpeed = 190;
		precision = 15;
		steerAheadSimul = 0.5;
		steerAheadPlan = 0.7;
		predictTurnPlan = 2;
		predictTurnSimul = 1.5;
		liftForceCoef = 1.8;
		cyclicAsideForceCoef = 0.85;
		cyclicForwardForceCoef = 0.55;
		bodyFrictionCoef = 1.05;
		backRotorForceCoef = 3.5;
		fuelCapacity = 8.5;
		maxFordingDepth = 0.3;
		threat[] = {0,0,0};
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
			thermalMode[] = {0,1};
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
						"Normal",
						"TI"
					};
					thermalMode[] = {0,1};
					gunnerOpticsModel = "A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_wide_F.p3d";
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
					gunnerOpticsModel = "A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_medium_F.p3d";
				};
				class Narrow: Wide
				{
					opticsDisplayName = "NFOV";
					initFov = 0.08;
					minFov = 0.08;
					maxFov = 0.08;
					gunnerOpticsModel = "A3\Drones_F\Weapons_F_Gamma\Reticle\UAV_Optics_Gunner_narrow_F.p3d";
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
					init = "_veh = _this # 0; if (isServer) then {if ((count crew _veh) isEqualTo 0) then {createVehicleCrew _veh;}; _veh disableAI ""ALL"";}; [_veh] spawn {params [""_veh""]; uiSleep 0.05; if (local _veh) then {_veh setCenterOfMass [0,-0.18,0];}; uiSleep 0.15; diag_log format [""[sting] %1 crew=%2 driver=%3 driverVehicle=%4 hasPilotCamera=%5 pilotCamPos=%6 pilotCamDir=%7 pipPos=%8 pilotPos=%9 driverPos=%10 UAVControl=%11 centerOfMass=%12"", typeOf _veh, count crew _veh, driver _veh, vehicle (driver _veh), hasPilotCamera _veh, getPilotCameraPosition _veh, getPilotCameraDirection _veh, _veh selectionPosition [""pip_pilot_pos"", ""Memory""], _veh selectionPosition [""pos_pilotcamera"", ""Memory""], _veh selectionPosition [""pos_driver"", ""Memory""], UAVControl _veh, getCenterOfMass _veh];};";
			};
		};
		attenuationEffectType = "OpenHeliAttenuation";
		soundGetIn[] = {"", 1, 1};
		soundGetOut[] = {"", 1, 1, 50};
		soundEnviron[] = {"", 0.031622775, 1};
		soundDammage[] = {"", 0.56234133, 1};
		soundEngineOnInt[] = {QSTING_SOUND(quad_start_full_int.wav), 0.56234133, 1};
		soundEngineOnExt[] = {QSTING_SOUND(quad_start_full_01.wav), 0.56234133, 1, 200};
		soundEngineOffInt[] = {QSTING_SOUND(quad_stop_full_int.wav), 0.56234133, 1};
		soundEngineOffExt[] = {QSTING_SOUND(quad_stop_full_01.wav), 0.56234133, 1, 200};
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
				sound[] = {QSTING_SOUND(quad_engine_full_01.wav), 0.44668359, 1, 200};
				frequency = "rotorSpeed";
				volume = "camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorLowOut
			{
				sound[] = {"A3\Sounds_F\air\Uav_01\blade", 0.31622776, 1, 200};
				frequency = "rotorSpeed";
				volume = "camPos*(0 max (rotorSpeed-0.1))";
				cone[] = {1.6,3.14,1.6,0.95};
			};
			class RotorHighOut
			{
				sound[] = {"A3\Sounds_F\air\Uav_01\blade_high", 0.31622776, 1, 250};
				frequency = "rotorSpeed";
				volume = "camPos*10*(0 max (rotorThrust-0.9))";
				cone[] = {1.6,3.14,1.6,0.95};
			};
			class EngineIn
			{
				sound[] = {QSTING_SOUND(quad_engine_full_int.wav), 0.56234133, 1};
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
	};

	class O_Sting_F: sting_drone_base_F
	{
		scope = 2;
		scopeCurator = 2;
		side = 0;
		faction = "OPF_F";
		crew = "O_UAV_AI";
		typicalCargo[] = {"O_UAV_AI"};
		displayName = "Sting UAV (OPFOR)";
	};

	class B_Sting_F: sting_drone_base_F
	{
		scope = 2;
		scopeCurator = 2;
		side = 1;
		faction = "BLU_F";
		crew = "B_UAV_AI";
		typicalCargo[] = {"B_UAV_AI"};
		displayName = "Sting UAV (BLUFOR)";
	};

	class I_Sting_F: sting_drone_base_F
	{
		scope = 2;
		scopeCurator = 2;
		side = 2;
		faction = "IND_F";
		crew = "I_UAV_AI";
		typicalCargo[] = {"I_UAV_AI"};
		displayName = "Sting UAV (Independent)";
	};
};

class cfgMods
{
	author = "Sam";
	timepacked = "1774100000";
};
