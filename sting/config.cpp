#define QSTR(x) #x
#define QSTING(P) QSTR(\sting\P)
#define QSTING_SOUND(P) QSTR(\sting\sounds\P)
#define QSTING_UI(P) QSTR(\sting\ui\P)

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
	class All;
	class AllVehicles: All
	{
		class NewTurret;
	};
	class UAV;
	class UAV_02_base_F: UAV
	{
		class NewTurret;
		class ViewPilot;
		class ViewOptics;
		class AnimationSources;
		class Components;
		class TextureSources;
		class Sounds;
	};

	class sting_drone_base_F: UAV_02_base_F
	{
		scope = 0;
		scopeCurator = 0;
		forceInGarage = 1;
		author = "Sam";
		displayName = "Sting UAV";
		editorSubcategory = "EdSubcat_Drones";
		vehicleClass = "Autonomous";
		model = QSTING(drone_inter.p3d);
		icon = QSTING_UI(drononmap.paa);
		picture = QSTING_UI(drononmap.paa);
		mapSize = 6;
		destrType = "DestructWreck";
		animated = 1;
		simulation = "airplaneX";
		attenuationEffectType = "PlaneAttenuation";
		isUav = 1;
		uavCameraDriverPos = "PiP0_pos";
		uavCameraDriverDir = "PiP0_dir";
		uavCameraGunnerPos = "";
		uavCameraGunnerDir = "";
		memoryPointDriverOptics = "PiP0_pos";
		memoryPointTaskMarker = "TaskMarker_1_pos";
		driverOpticsModel = "A3\drones_f\Weapons_F_Gamma\Reticle\UGV_01_Optics_Driver_F.p3d";
		driverForceOptics = 1;
		getInRadius = 0;
		unitInfoType = "RscOptics_AV_airplane_pilot";
		unitInfoTypeRTD = "RscOptics_AV_airplane_pilot";
		driverWeaponsInfoType = "RscOptics_Offroad_01";
		weapons[] = {};
		magazines[] = {};
		accuracy = 0.5;
		camouflage = 0.25;
		audible = 0.1;
		armor = 0.4;
		cost = 12000;
		maxSpeed = 180;
		stallSpeed = 55;
		landingSpeed = 70;
		landingAoa = 0.1309;
		stallWarningTreshold = 0.07;
		altNoForce = 3500;
		altFullForce = 1500;
		fuelCapacity = 1.2;
		killFriendlyExpCoef = 0;
		threat[] = {0.1, 0.1, 0.1};
		irTarget = 0;
		irTargetSize = 0.02;
		radarTarget = 0;
		radarTargetSize = 0.05;
		visualTargetSize = 0.08;
		lockDetectionSystem = 0;
		incomingMissileDetectionSystem = 0;
		reportRemoteTargets = 1;
		reportOwnPosition = 1;
		soundGetIn[] = {"", 0.56234133, 1};
		soundGetOut[] = {"", 0.56234133, 1, 40};
		soundDammage[] = {"", 0.56234133, 1};
		soundLocked[] = {"\A3\Sounds_F\weapons\Rockets\opfor_lock_1", 1, 1};
		soundIncommingMissile[] = {"\A3\Sounds_F\vehicles\air\noises\alarm_locked_by_missile_5", 0.39810717, 1};
		soundEngineOnInt[] = {QSTING_SOUND(quad_start_full_int.wav), 0.70794576, 1};
		soundEngineOnExt[] = {QSTING_SOUND(quad_start_full_01.wav), 0.70794576, 1, 250};
		soundEngineOffInt[] = {QSTING_SOUND(quad_stop_full_int.wav), 0.70794576, 1};
		soundEngineOffExt[] = {QSTING_SOUND(quad_stop_full_01.wav), 0.70794576, 1, 250};
		soundGearUp[] = {"", 1, 1, 120};
		soundGearDown[] = {"", 1, 1, 120};
		soundFlapsUp[] = {"", 1, 1, 100};
		soundFlapsDown[] = {"", 1, 1, 100};
		driveOnComponent[] = {};

		class ViewPilot: ViewPilot
		{
			minFov = 0.25;
			maxFov = 1.1;
			initFov = 0.75;
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
			minFov = 0.25;
			maxFov = 1.1;
			initFov = 0.75;
			visionMode[] =
			{
				"Normal",
				"NVG"
			};
			thermalMode[] = {0, 1};
		};

		class Sounds: Sounds
		{
			class EngineLowOut
			{
				sound[] = {QSTING_SOUND(quad_engine_full_01.wav), 0.70794576, 1, 350};
				frequency = "1.0 min (rpm + 0.5)";
				volume = "camPos*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			class EngineHighOut
			{
				sound[] = {QSTING_SOUND(quad_engine_full_01.wav), 1, 1, 500};
				frequency = "(rpm factor[0.5, 1.0])";
				volume = "camPos*(rpm factor[0.2, 1.0])";
			};
			class WindNoiseOut
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\noise", 0.31622776, 1, 150};
				frequency = "(0.3+(1.005*(speed factor[1, 50])))";
				volume = "camPos*(speed factor[1, 50])";
			};
			class EngineLowIn
			{
				sound[] = {QSTING_SOUND(quad_engine_full_int.wav), 1, 1};
				frequency = "1.0 min (rpm + 0.5)";
				volume = "(1-camPos)*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			class EngineHighIn
			{
				sound[] = {QSTING_SOUND(quad_engine_full_int.wav), 1, 1};
				frequency = "(rpm factor[0.5, 1.0])";
				volume = "(1-camPos)*(rpm factor[0.2, 1.0])";
			};
			class WindNoiseIn
			{
				sound[] = {"A3\Sounds_F\air\UAV_02\noise", 0.25118864, 1};
				frequency = "(0.3+(1.005*(speed factor[1, 50])))";
				volume = "(1-camPos)*(speed factor[1, 50])";
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
