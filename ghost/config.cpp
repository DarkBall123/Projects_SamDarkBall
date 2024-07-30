#include "basicdefines_a3.hpp"
	
class CfgPatches {
	class ghost_M
	{
		author = "Sam";
		authorUrl = "";
		version = 0.1;
		
		units[]	= 
		{
		"ghost_M"
		};
		weapons[] =  
		{
		
		};
		
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Air_F", "A3_Characters_F_Gamma"};
		
	};
};


class ViewPilot;
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

class CfgVehicles {

	class Air;
	class Civilian_F;
	class C_man_w_worker_F;

	// ****** Base Plane ********************************************************

	class Plane: Air	{
		class NewTurret;
		class Sounds;
		class AnimationSources;	
		class HitPoints
			{
				class HitHull;
			};
	};
	
// ****** Base JN-4 ****************************************************************
		
	class ghost_M_BASE : Plane {
			
		displayName = "ghost";								
		model = "ghost\ghost.p3d";													
		icon = "ghost\data\map_ghost_ca.paa"; 
		picture = "ghost\data\map_ghost_ca.paa"; 
		// editorPreview = "\sab_fk9\previewicons\icon_1.paa";
		mapSize = 15;
	    flaps = 0;
		simulation = "airplanex";
		crew = "C_man_shorts_2_F";
		cabinOpening = false;
		gearRetracting  = false;
		
		// pilot  ***************************
		
		driverCompartments = "Compartment1";
		driverAction = "Chopperlight_L_Static_H";
		
		driverIsCommander = true;	
		ejectDeadDriver = true;
		hideWeaponsDriver = true;
		hideWeaponsCargo = true;
		
		memoryPointsGetInDriver = "pos driver";
		memoryPointsGetInDriverDir = "pos driver dir";
		
		driverLeftHandAnimName = "";
		driverRightHandAnimName = "stick_pilot";
		driverLeftLegAnimName = "";
		driverRightLegAnimName = "";
			
		// cargo *************************** 

		// passengers + cargo *************************** 


		getInAction = "GetInLow";
		getOutAction = "GetOutLow";
		
		class Turrets {
		};	
		
		transportMaxWeapons = 2;
		transportMaxMagazines = 6;
		transportMaxBackpacks = 1;
		
		// Armor, Weapons, Vulnerability, etc ***************************
		
		fuelCapacity = 450;
		fov = 0.7;
		maxFordingDepth = 0.3;
		passThrough = 0.7;
		crewVulnerable = "true";
		accuracy = 0.2;	
		cost = 1000;
		laserScanner = 0;			
		gunAimDown = 0.029000;	
		minFireTime = 30;	
		threat[]={0.1, 1, 0.7};		
		type=VAir;
		ejectSpeed[] = {0, 0, 0};
		armor = 15;
		damageResistance = 0.0001;
		destrType = DestructWreck;	
		irScanRangeMin = 50;		
		irScanRangeMax = 5000;		
		irScanToEyeFactor = 2;	
		damageEffect = "DamageSmokePlane";
		weapons[] = {};
		magazines[] = {};
	
		// textures, camera ***************************
		
		hiddenSelections[] =  {"camo1"};	
		extCameraPosition[] = {0,0.5,-10};
		
		// flight, swim and drive Model ***************************
		
		#include "ghostflightmodel.hpp"	

		// sounds ***************************

		insideSoundCoef = 0.8;
		nameSound = "plane";
		attenuationEffectType = "OpenHeliAttenuation";
			
		soundGetIn[]={};
		soundGetOut[]={};
		soundDammage[]={};
		
		soundEngineOnInt[] = {"\ghost\data\zavod.wss", 6, 1.0};
		soundEngineOnExt[] = {"\ghost\data\zavod.wss", 10, 1.0, 400};
		soundEngineOffInt[] = {"A3\Sounds_F\air\UAV_02\UAV_02_stop_int", 0.707946, 1.0};
		soundEngineOffExt[] = {"A3\Sounds_F\air\UAV_02\UAV_02_stop_ext", 0.707946, 1.0, 400};
		
		
				
		class Sounds {
		
		
			class EngineLowIn {
				sound[] = {"\ghost\data\fly.wss", db0, 1.0};
				frequency = "1.0 min (rpm + 0.5)";
				volume = "(1-camPos)*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			
			class EngineLowOut {
				sound[] = {"\ghost\data\fly.wss", db-3, 1.0, 450};
				frequency = "1.0 min (rpm + 0.5)";
				volume = "camPos*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			
			class EngineHighIn {
				sound[] = {"\ghost\data\fly.wss", db0, 1.0};
				frequency = "(0.1+(1.005*(speed factor[1, 50])))";
				volume = "(1-camPos)*(rpm factor[0.2, 1.0])";
			};
			
			class EngineHighOut {
				sound[] = {"\ghost\data\fly.wss", db0, 1.0, 650};
				frequency = "(0.1+(1.005*(speed factor[1, 50])))";
				volume = "camPos*(rpm factor[0.2, 1.0])";
			};

			class ForsageIn {
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_forsage_int", 0.630957, 1.0};
				frequency = "1";
				volume = "engineOn*(1-camPos)*(thrust factor[0.6, 1.0])";
			};
			
			class ForsageOut {
				sound[] = {"A3\Sounds_F\air\UAV_02\UAV_02_forsage_ext", db1, 1.0, 900};
				frequency = "1";
				volume = "engineOn*camPos*(thrust factor[0.6, 1.0])";
				cone[] = {3.14, 3.92, 2.0, 0.5};
			};
			
			class WindNoiseIn {
				sound[] = {"A3\Sounds_F\air\UAV_02\noise", db-12, 1.0};
				frequency = "(0.3+(1.005*(speed factor[1, 50])))";
				volume = "(1-camPos)*(speed factor[1, 50])";
			};	
			
			class WindNoiseOut {
				sound[] = {"A3\Sounds_F\air\UAV_02\noise", db -10, 1.0, 150};
				frequency = "(0.3+(1.005*(speed factor[1, 50])))";
				volume = "camPos*(speed factor[1,  50])";
			};
		};
			
		class Exhausts {
			class Exhaust1 
			{
				position = "exhaust";  	
				direction = "exhaust_dir";	
				effect = "ExhaustsEffectPlane";	
			};
			
		};
			
		class Reflectors {};	
	
		class MarkerLights {};
			
		class AnimationSources {
			
			
		};

		
		
		
			
		
	};
	
// ****** Base ****************************************************************
	class ghost_M_OPF: ghost_M_BASE {
		
		author = "Sam";
		scope = 2;	
		displayName = "Ghost of Malden";
		hiddenSelectionsTextures[] =        {""};
		side = 0;						
		faction = "OPF_F";	
		crew = "O_Pilot_F";	
		irTarget = 1;
		irTargetSize = 1;
		irScanToEyeFactor = 2;
		irScanGround = 1;
		irScanRangeMax = 5000;
		irScanRangeMin = 500;
		lockDetectionSystem = 8;
		unitInfoType = "RscOptics_CAS_Pilot";		
		vehicleClass = "air";		
		precisegetinout=1;
		driverCanEject=0;
		viewDriverShadowDiff=0.5;
		viewDriverShadowAmb=0.5;
		incomingMissileDetectionSystem="8 + 16";
		class Components
		{
			class TransportCountermeasuresComponent {};
			class SensorsManagerComponent
			{
				class Components
				{
					class IRSensorComponent: SensorTemplateIR
					{
						class AirTarget
						{
							minRange=500;
							maxRange=5000;
							objectDistanceLimitCoef=-1;
							viewDistanceLimitCoef=1;
						};
						class GroundTarget
						{
							minRange=500;
							maxRange=4000;
							objectDistanceLimitCoef=1;
							viewDistanceLimitCoef=1;
						};
						angleRangeHorizontal=50;
						angleRangeVertical=37;
						maxTrackableSpeed=100;
						animDirection="PilotCamera_V";
					};
					class VisualSensorComponent: SensorTemplateVisual
					{
						class AirTarget
						{
							minRange=500;
							maxRange=4000;
							objectDistanceLimitCoef=-1;
							viewDistanceLimitCoef=1;
						};
						class GroundTarget
						{
							minRange=500;
							maxRange=3000;
							objectDistanceLimitCoef=1;
							viewDistanceLimitCoef=1;
						};
						angleRangeHorizontal=50;
						angleRangeVertical=37;
						maxTrackableSpeed=100;
						animDirection="PilotCamera_V";
					};
					class AntiRadiationSensorComponent: SensorTemplateAntiRadiation
					{
					};
					class PassiveRadarSensorComponent: SensorTemplatePassiveRadar
					{
					};
					class LaserSensorComponent: SensorTemplateLaser
					{
					};
					class NVSensorComponent: SensorTemplateNV
					{
					};
				};
			};
			class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft
			{
				class Components
				{
					class EmptyDisplay
					{
						componentType="EmptyDisplayComponent";
					};
					class MinimapDisplay
					{
						componentType="MinimapDisplayComponent";
						resource="RscCustomInfoAirborneMiniMap";
					};
					class UAVDisplay
					{
						componentType="UAVFeedDisplayComponent";
					};
					class VehicleDriverDisplay
					{
						componentType="TransportFeedDisplayComponent";
						source="Driver";
					};
					class VehicleMissileDisplay
					{
						componentType="TransportFeedDisplayComponent";
						source="Missile";
					};
					class SensorDisplay
					{
						componentType="SensorsDisplayComponent";
						range[]={4000,2000,16000,8000};
						resource="RscCustomInfoSensors";
					};
				};
			};
			class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight
			{
				defaultDisplay="SensorDisplay";
				class Components
				{
					class EmptyDisplay
					{
						componentType="EmptyDisplayComponent";
					};
					class MinimapDisplay
					{
						componentType="MinimapDisplayComponent";
						resource="RscCustomInfoAirborneMiniMap";
					};
					class UAVDisplay
					{
						componentType="UAVFeedDisplayComponent";
					};
					class VehicleDriverDisplay
					{
						componentType="TransportFeedDisplayComponent";
						source="Driver";
					};
					class VehicleMissileDisplay
					{
						componentType="TransportFeedDisplayComponent";
						source="Missile";
					};
					class SensorDisplay
					{
						componentType="SensorsDisplayComponent";
						range[]={4000,2000,16000,8000};
						resource="RscCustomInfoSensors";
					};
				};
			};
			class TransportPylonsComponent
			{
				uiPicture="";
				class Pylons
				{
					class Pylons1
					{
						hardpoints[]=
						{
							"O_MISSILE_PYLON",
							"UNI_SCALPEL"
						};
						attachment="PylonRack_1Rnd_Missile_AA_03_F";
						priority=5;
						maxweight=150;
						UIposition[]={0.34999999,0};
					};
					class Pylons2: Pylons1
					{
						priority=4;
						attachment="PylonRack_1Rnd_Missile_AGM_01_F";
						maxweight=500;
						UIposition[]={0.345,0.050000001};
					};
					class Pylons3: Pylons1
					{
						hardpoints[]=
						{
							"O_BOMB_PYLON",
							"O_MISSILE_PYLON",
							"UNI_SCALPEL"
						};
						priority=3;
						attachment="PylonRack_20Rnd_Rocket_03_HE_F";
						maxweight=1050;
						UIposition[]={0.34,0.1};
					};
					class Pylons4: Pylons1
					{
						hardpoints[]=
						{
							"O_BOMB_PYLON",
							"O_MISSILE_PYLON",
							"UNI_SCALPEL"
						};
						priority=2;
						attachment="PylonRack_1Rnd_Missile_AGM_01_F";
						maxweight=1200;
						UIposition[]={0.33000001,0.2};
					};
					class Pylons5: Pylons1
					{
						hardpoints[]=
						{
							"O_BOMB_PYLON",
							"O_MISSILE_PYLON",
							"UNI_SCALPEL"
						};
						priority=1;
						attachment="PylonMissile_1Rnd_Bomb_03_F";
						maxweight=1200;
						UIposition[]={0.33000001,0.25};
					};
					class Pylons6: Pylons5
					{
						UIposition[]={0.33000001,0.30000001};
						mirroredMissilePos=5;
					};
					class Pylons7: Pylons4
					{
						UIposition[]={0.33000001,0.34999999};
						mirroredMissilePos=4;
					};
					class Pylons8: Pylons3
					{
						UIposition[]={0.34,0.44999999};
						mirroredMissilePos=3;
						attachment="PylonRack_20Rnd_Rocket_03_AP_F";
					};
					class Pylons9: Pylons2
					{
						UIposition[]={0.345,0.5};
						mirroredMissilePos=2;
					};
					class Pylons10: Pylons1
					{
						UIposition[]={0.34999999,0.55000001};
						mirroredMissilePos=1;
					};
				};
				class Presets
				{
					class Empty
					{
						displayName="$STR_empty";
						attachment[]={};
					};
					class Default
					{
						displayName="$STR_vehicle_default";
						attachment[]=
						{
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_20Rnd_Rocket_03_HE_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonMissile_1Rnd_Bomb_03_F",
							"PylonMissile_1Rnd_Bomb_03_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_20Rnd_Rocket_03_HE_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_1Rnd_Missile_AA_03_F"
						};
					};
					class AA
					{
						displayName="$STR_A3_cfgmagazines_titan_aa_dns";
						attachment[]=
						{
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_1Rnd_Missile_AA_03_F"
						};
					};
					class AT
					{
						displayName="$STR_A3_cfgmagazines_titan_at_dns";
						attachment[]=
						{
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_20Rnd_Rocket_03_AP_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_20Rnd_Rocket_03_AP_F",
							"PylonRack_1Rnd_Missile_AA_03_F"
						};
					};
					class CAS
					{
						displayName="$STR_A3_CAS_PRESET_DISPLAYNAME";
						attachment[]=
						{
							"PylonRack_1Rnd_Missile_AA_03_F",
							"PylonRack_20Rnd_Rocket_03_HE_F",
							"PylonRack_20Rnd_Rocket_03_AP_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonMissile_1Rnd_Bomb_03_F",
							"PylonMissile_1Rnd_Bomb_03_F",
							"PylonRack_1Rnd_Missile_AGM_01_F",
							"PylonRack_20Rnd_Rocket_03_AP_F",
							"PylonRack_20Rnd_Rocket_03_HE_F",
							"PylonRack_1Rnd_Missile_AA_03_F"
						};
					};
				};
			};
		};
		weapons[]=
		{
			"Cannon_30mm_Plane_CAS_02_F",
			"Missile_AA_03_Plane_CAS_02_F",
			"Missile_AGM_01_Plane_CAS_02_F",
			"Rocket_03_HE_Plane_CAS_02_F",
			"Rocket_03_AP_Plane_CAS_02_F",
			"Bomb_03_Plane_CAS_02_F",
			"Laserdesignator_pilotCamera",
			"CMFlareLauncher"
		};
		magazines[]=
		{
			"500Rnd_Cannon_30mm_Plane_CAS_02_F",
			"2Rnd_Missile_AA_03_F",
			"4Rnd_Missile_AGM_01_F",
			"2Rnd_Bomb_03_F",
			"20Rnd_Rocket_03_HE_F",
			"20Rnd_Rocket_03_AP_F",
			"Laserbatteries",
			"120Rnd_CMFlare_Chaff_Magazine"
		};
	
	};

	class ghost_M_BLU_F : ghost_M_OPF
	{
		side = 1;						
		faction = "BLU_F";	
		crew = "B_Pilot_F";
	};

	class ghost_M_IND_F : ghost_M_OPF
	{
		side = 2;						
		faction = "IND_F";	
		crew = "I_Pilot_F";
	};
	
	
	class PlaneWreck;

	class ghost_M_wreck: PlaneWreck
	{
		scope = 1;
		model = "ghost\ghostwreck.p3d";
		typicalCargo[] = {};
		irTarget = 0;
		transportAmmo = 0;
		transportRepair = 0;
		transportFuel = 0;
		transportSoldier = 1;
		class Eventhandlers{};
	};
};	


class CfgSounds
{
	sounds[] = {};

	class Cough_1
	{
		name = "Cough_1";						// display name
		sound[] = { "\ghost\sounds\Cough_1.ogg", 100, 1, 100 };	// file, volume, pitch, maxDistance
		titles[] = { };			// subtitles
	};

	class Cough_2
	{
		name = "Cough_2";						// display name
		sound[] = { "\ghost\sounds\Cough_2.ogg", 100, 1, 100 };	// file, volume, pitch, maxDistance
		titles[] = { };			// subtitles
	};

	class Cough_3
	{
		name = "Cough_3";						// display name
		sound[] = { "\ghost\sounds\Cough_3.ogg", 100, 1, 100 };	// file, volume, pitch, maxDistance
		titles[] = { };			// subtitles
	};
};


class CfgFunctions
{
	class ghost
	{
		class ghost_functions
		{
            file = "\ghost";

			class initializeSounds { postInit = 1; };
		};
	};
};
