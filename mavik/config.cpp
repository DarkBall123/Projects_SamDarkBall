class CfgPatches
{
	class mavik_Data
	{
		author="DarkBall & Sam";
		name="ArmaFPV";
		url="";
		requiredAddons[]=
		{
            "A3_Data_F_AoW_Loadorder",
			"A3_Data_F",
            "A3_Drones_F",
			"cba_settings"
		};
		requiredVersion=0.1;
		units[]=
		{
			"mavik_3_OPF",
			"mavik_3_BLU",
			"mavik_3_IND",
			"mavik_3T_OPF",
			"mavik_3T_BLU",
			"mavik_3T_IND"
		};
		weapons[]={};
	};
};


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
	class Air;
	class Helicopter: Air
	{
		class Turrets;
		class HitPoints;
		class ACE_Actions {
            class ACE_MainActions {};
        };
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
		class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {};
        };
		class AnimationSources;
		class EventHandlers;
		class Components;
	};

	class UAV_06_base_F : Helicopter_Base_F
	{
		class ViewPilot;
		class ViewOptics;
	};

	class mavic_drone_base_F: UAV_06_base_F
	{
		features="Randomization: No						<br />Camo selections: 1 - the whole body						<br />Script door sources: None						<br />Script animations: None						<br />Executed scripts: None						<br />Firing from vehicles: No						<br />Slingload: No						<br />Cargo proxy indexes: None";
		author="$Sam";
		mapSize=4;
		class SpeechVariants
		{
			class Default
			{
				speechSingular[]=
				{
					"veh_air_UAV_s"
				};
				speechPlural[]=
				{
					"veh_air_UAV_p"
				};
			};
		};
		textSingular="$STR_A3_nameSound_veh_air_UAV_s";
		textPlural="$STR_A3_nameSound_veh_air_UAV_p";
		nameSound="veh_air_UAV_s";
		_generalMacro="mavic_drone_base_F";
		editorSubcategory="EdSubcat_Drones";
		scope=0;
		displayName="$STR_A3_CfgVehicles_UAV_01_base0";
		isUav=1;
		uavCameraDriverPos="pip_pilot_pos";
		uavCameraDriverDir="pip_pilot_dir";
		uavCameraGunnerPos="pos_pilotcamera";
		uavCameraGunnerDir="pos_pilotcamera_dir";
		memoryPointDriverOptics = "pos_pilotcamera";
		driverOpticsModel="\mavik\mavik_hud.p3d";
		GunnerOpticsModel="\mavik\mavik_hud.p3d";
		driverForceOptics=1;
		extCameraPosition[]={0,-0.25,-2.3499999};
		extCameraParams[]={0.93000001,10,30,0.25,1,10,30,0,1};
		formationX=10;
		formationZ=10;
		memoryPointTaskMarker="TaskMarker_1_pos";
		disableInventory=1;
		unitInfoType="RscUnitInfoNoWeapon";
		unitInfoTypeRTD="RscUnitInfoNoWeapon";
		driverWeaponsInfoType = "RscOptics_Offroad_01";
		getInRadius=0;
		damageEffect="UAVDestructionEffects";
		damageTexDelay=0.5;
		dustEffect="UAVDust";
		waterEffect="UAVWater";
		washDownDiameter="10.0f";
		washDownStrength="0.25f";
		killFriendlyExpCoef=0.1;
		accuracy=1.5;
		camouflage=0.5;
		audible=0.1;
		armor=0.5;
		cost=20000;
		altFullForce=1000;
		altNoForce=2000;
		//LODTurnedIn=1100;
		//LODTurnedOut=0;
		epeImpulseDamageCoef=5;
		fuelExplosionPower=0;
		vehicleClass="Autonomous";
		model="\mavik\mavik3.p3d";
		icon="\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\Map_UAV_01_CA.paa";
		picture="\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa";
		class Reflectors
		{
		};
		class MarkerLights
		{
			class NavGreen
			{
				activeLight = 0;
				name = "nav_green";
				color[] = {0.0, 1.0, 0.0};
				ambient[] = {0, 0.1, 0};
				size = 0.200000;
				drawLight = 1;
				drawLightSize = 0.05;
				flareSize = 0.3;
				intensity = 500;
				useFlare = 1;
				dayLight = 1;
				blinking = "false";
			};
			class NavGreenB:NavGreen
			{
				activeLight = 0;
				name = "nav_greenB";
				color[] = {0.0, 1.0, 0.0};
				ambient[] = {0, 0.1, 0};
				size = 0.200000;
				drawLight = 1;
				drawLightSize = 0.05;
				flareSize = 0.3;
				intensity = 500;
				useFlare = 1;
				dayLight = 1;
				blinking = "true";
			};
			class NavRED: NavGreen
			{
				name = "nav_redB";
				color[] = {1.0, 0.0, 0.0};
				drawLight = 1;
				drawLightCenterSize = 0.01;
				ambient[] = {0.1, 0, 0};
			};
		};
		startDuration=3;
		maxSpeed=100;
		precision=15;
		steerAheadSimul=0.5;
		steerAheadPlan=0.69999999;
		predictTurnPlan=2;
		predictTurnSimul=1.5;
		liftForceCoef=1;
		cyclicAsideForceCoef=2;
		cyclicForwardForceCoef=1.2;
		bodyFrictionCoef=0.30000001;
		backRotorForceCoef=5;
		fuelCapacity= 0.5; // 30 мин = 1800 сек
		fuelConsumptionRate = 0.000277;
		maxFordingDepth=0.30000001;
		threat[]={0.1,0.1,0.1};
		maxMainRotorDive=0;
		minMainRotorDive=0;
		neutralMainRotorDive=0;
		gearRetracting=0;
		mainRotorSpeed=7;
		backRotorSpeed=-7;
		mainBladeCenter = "rotor_center";
		mainBladeRadius = 0.35;
		tailBladeCenter = "rotor2_center";
		tailBladeRadius = 0.35;
		tailBladeVertical=0;
		radarTargetSize=0.1;
		visualTargetSize=0.1;
		irTarget=0;
		lockDetectionSystem=0;
		incomingMissileDetectionSystem=0;
		weapons[]={};
		magazines[]={};
		irScanRangeMin=0;
		irScanRangeMax=0;
		irScanToEyeFactor=1;
		class TransportItems
		{
		};
		destrType="DestructWreck";
		driverCompartments="Compartment3";
		cargoCompartments[]=
		{
			"Compartment2"
		};
		// class HitPoints: HitPoints
		// {
		// 	class HitHull: HitHull
		// 	{
		// 		armor=0.1;
		// 	};
		// 	class HitHRotor: HitHRotor
		// 	{
		// 		armor=0.30000001;
		// 	};
		// };

		hiddenSelections[] = {"camo"};
		hiddenSelectionsTextures[] = {"mavik\textures\body_co.paa"};

		selectionDamage= "damage";
		class Damage
		{
			tex[]={};
			mat[]=
			{
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01_damage.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01_destruct.rvmat"
			};
		};
		class ViewPilot: ViewPilot
		{
			minFov=0.25;
            maxFov=0.8;
            initFov=0.8;
            initAngleX=0;
            minAngleX=-65;
            maxAngleX=85;
            initAngleY=0;
            minAngleY=-150;
            maxAngleY=150;
		};
		class Viewoptics: ViewOptics
		{
			initAngleX=0;
			minAngleX=0;
			maxAngleX=0;
			initAngleY=0;
			minAngleY=0;
			maxAngleY=0;
			minFov=0.25;
			maxFov=0.8;
			initFov=0.8;
			visionMode[]=
			{
				"Normal"
			};
			thermalMode[]={0,1};
		};
		class MFD
		{
		};
		enableManualFire=1;
		reportRemoteTargets=1;
		reportOwnPosition=1;
		class PilotCamera
		{
			minTurn=-27;
            maxTurn=27;
            initTurn=0;
            minElev=-35;
            maxElev=90;
            initElev=0;
			maxXRotSpeed=1;
			maxYRotSpeed=1;
			maxMouseXRotSpeed=0.5;
			maxMouseYRotSpeed=0.5;
			pilotOpticsShowCursor=1;
			controllable=1;
			// body="mainTurret";
   //       gun="mainGun";
   //       animationSourceBody="mainTurret";
   //       animationSourceGun="mainGun";
			class OpticsIn
			{
				class Wide
				{
					opticsDisplayName="WFOV";
					initAngleX=0;
					minAngleX=0;
					maxAngleX=0;
					initAngleY=0;
					minAngleY=0;
					maxAngleY=0;
					initFov=0.8;
					minFov=0.028;
					maxFov=0.8;
					directionStabilized=1;
					visionMode[]=
					{
						"Normal",
					};
					thermalMode[]={};
					GunnerOpticsModel="\mavik\mavik_hud.p3d";
					opticsPPEffects[]=
					{
						"OpticsCHAbera2",
						"OpticsBlur2"
					};
				};
				showMiniMapInOptics=1;
				showUAVViewInOptics=0;
				showSlingLoadManagerInOptics=0;
			};
		};
		attenuationEffectType="OpenHeliAttenuation";
		soundGetIn[]=
		{
			"",
			1,
			1
		};
		soundGetOut[]=
		{
			"",
			1,
			1,
			50
		};
		soundEnviron[]=
		{
			"",
			0.031622775,
			1
		};
		soundDammage[]=
		{
			"",
			0.56234133,
			1
		};
		soundEngineOnInt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_start_full_int",
			0,
			2
		};
		soundEngineOnExt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_start_full_01",
			0.56234133,
			3,
			60
		};
		soundEngineOffInt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_stop_full_int",
			0,
			2
		};
		soundEngineOffExt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_stop_full_01",
			0.56234133,
			3,
			60
		};
		soundBushCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",
			1,
			1,
			10
		};
		soundBushCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",
			1,
			1,
			10
		};
		soundBushCollision3[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",
			1,
			1,
			10
		};
		soundBushCrash[]=
		{
			"soundBushCollision1",
			0.33000001,
			"soundBushCollision2",
			0.33000001,
			"soundBushCollision3",
			0.33000001
		};
		soundWaterCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",
			1,
			1,
			10
		};
		soundWaterCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",
			1,
			1,
			10
		};
		soundWaterCrashes[]=
		{
			"soundWaterCollision1",
			0.5,
			"soundWaterCollision2",
			0.5
		};
		Crash0[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1",
			1,
			1,
			90
		};
		Crash1[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2",
			1,
			1,
			90
		};
		Crash2[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3",
			1,
			1,
			90
		};
		Crash3[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4",
			1,
			1,
			90
		};
		soundCrashes[]=
		{
			"Crash0",
			0.25,
			"Crash1",
			0.25,
			"Crash2",
			0.25,
			"Crash3",
			0.25
		};
		class Sounds
		{
			class Engine
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\quad_engine_full_01",
					0.44668359,
					3,
					60
				};
				frequency="rotorSpeed";
				volume="camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorLowOut
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade",
					0.31622776,
					3,
					60
				};
				frequency="rotorSpeed";
				volume="camPos*(0 max (rotorSpeed-0.1))";
				cone[]={1.6,3.1400001,1.6,0.94999999};
			};
			class RotorHighOut
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_high",
					0.31622776,
					3,
					65
				};
				frequency="rotorSpeed";
				volume="camPos*10*(0 max (rotorThrust-0.9))";
				cone[]={1.6,3.1400001,1.6,0.94999999};
			};
			class EngineIn
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\quad_engine_full_int",
					0,
					2
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*((rotorSpeed-0.75)*4)";
			};
			class RotorLowIn
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_int",
					0,
					2
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*(0 max (rotorSpeed-0.1))";
			};
			class RotorHighIn
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_high_int",
					0,
					2
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*3*(rotorThrust-0.9)";
			};
		};
		class Exhausts
		{
			class Exhaust_1
			{
				position="Exhaust_1_pos";
				direction="Exhaust_1_dir";
				effect="ExhaustsEffectDrone";
			};
		};
		class Library
		{
			libTextDesc="$STR_A3_CfgVehicles_UAV_01_base_Library0";
		};
		class EventHandlers
		{
			class Mavic_Events
			{
				killed = "player connectTerminalToUAV objNull; { _x setDamage 1 } forEach (crew (_this # 0));";
				init = "params ['_entity']; if ((isClass(configFile >> ""CfgPatches"" >> ""DB_D37_scripts_mavick_vogs"")) && !(is3DEN)) then { [_entity, 1] spawn mavic_drop_fnc_makeGrenadeDrone; };";
			};
		};
		class UserActions
		{
			class DisassembleUAV
			{
				displayName = "Put in inventory";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition = "[this] call mavic_fnc_canDisassembly";
				statement = "[this, player] call mavic_fnc_addUavToInventory";
			};
			class ChangeBattery
			{
				displayName = "Change Battery";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition = "!(isClass (configFile >> ""CfgPatches"" >> ""ace_main"")) && (alive this) && ([player, ""Laserbatteries""] call BIS_fnc_hasItem) && (cameraOn == player) && {(fuel this) < 1} && {(speed this) < 1} && {!(isEngineOn this)}";
				statement = "[this, player] call mavic_fnc_changeBattery";
			};
		};
		class Turrets {};
		// class Turrets:turrets
		// {
		// 	class mainturret:mainturret
		// 	{
		// 		LODTurnedIn = 0;
		// 		LODTurnedOut = 0;
		// 		maxElev = 35;
		// 		minElev = -90;
		// 		minTurn = -27;
		// 		maxTurn = 27;
		// 		stabilizedInAxes = 3;
		// 		GunnerOpticsModel="\mavik\mavik_hud.p3d";
		// 	};
		// };
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
	};

	class mavic3T_drone_base_F: UAV_06_base_F
	{
		features="Randomization: No						<br />Camo selections: 1 - the whole body						<br />Script door sources: None						<br />Script animations: None						<br />Executed scripts: None						<br />Firing from vehicles: No						<br />Slingload: No						<br />Cargo proxy indexes: None";
		author="$Sam";
		mapSize=4;
		class SpeechVariants
		{
			class Default
			{
				speechSingular[]=
				{
					"veh_air_UAV_s"
				};
				speechPlural[]=
				{
					"veh_air_UAV_p"
				};
			};
		};
		textSingular="$STR_A3_nameSound_veh_air_UAV_s";
		textPlural="$STR_A3_nameSound_veh_air_UAV_p";
		nameSound="veh_air_UAV_s";
		_generalMacro="mavic_drone_base_F";
		editorSubcategory="EdSubcat_Drones";
		scope=0;
		displayName="$STR_A3_CfgVehicles_UAV_01_base0";
		isUav=1;
		uavCameraDriverPos="pip_pilot_pos";
		uavCameraDriverDir="pip_pilot_dir";
		uavCameraGunnerPos="pos_pilotcamera";
		uavCameraGunnerDir="pos_pilotcamera_dir";
		memoryPointDriverOptics = "pos_pilotcamera";
		driverOpticsModel="\mavik\mavik_hud.p3d";
		GunnerOpticsModel="\mavik\mavik_hud.p3d";
		driverForceOptics=1;
		extCameraPosition[]={0,-0.25,-2.3499999};
		extCameraParams[]={0.93000001,10,30,0.25,1,10,30,0,1};
		formationX=10;
		formationZ=10;
		memoryPointTaskMarker="TaskMarker_1_pos";
		disableInventory=1;
		unitInfoType="RscUnitInfoNoWeapon";
		unitInfoTypeRTD="RscUnitInfoNoWeapon";
		driverWeaponsInfoType = "RscOptics_Offroad_01";
		getInRadius=0;
		damageEffect="UAVDestructionEffects";
		damageTexDelay=0.5;
		dustEffect="UAVDust";
		waterEffect="UAVWater";
		washDownDiameter="10.0f";
		washDownStrength="0.25f";
		killFriendlyExpCoef=0.1;
		accuracy=1.5;
		camouflage=0.5;
		audible=0.1;
		armor=0.5;
		cost=20000;
		altFullForce=1000;
		altNoForce=2000;
		//LODTurnedIn=1100;
		//LODTurnedOut=0;
		epeImpulseDamageCoef=5;
		fuelExplosionPower=0;
		vehicleClass="Autonomous";
		model="\mavik\mavik3.p3d";
		icon="\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\Map_UAV_01_CA.paa";
		picture="\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa";
		class Reflectors
		{
		};
		class MarkerLights
		{
			class NavGreen
			{
				activeLight = 0;
				name = "nav_green";
				color[] = {0.0, 1.0, 0.0};
				ambient[] = {0, 0.1, 0};
				size = 0.200000;
				drawLight = 1;
				drawLightSize = 0.05;
				flareSize = 0.3;
				intensity = 500;
				useFlare = 1;
				dayLight = 1;
				blinking = "false";
			};
			class NavGreenB:NavGreen
			{
				activeLight = 0;
				name = "nav_greenB";
				color[] = {0.0, 1.0, 0.0};
				ambient[] = {0, 0.1, 0};
				size = 0.200000;
				drawLight = 1;
				drawLightSize = 0.05;
				flareSize = 0.3;
				intensity = 500;
				useFlare = 1;
				dayLight = 1;
				blinking = "true";
			};
			class NavRED: NavGreen
			{
				name = "nav_redB";
				color[] = {1.0, 0.0, 0.0};
				drawLight = 1;
				drawLightCenterSize = 0.01;
				ambient[] = {0.1, 0, 0};
			};
		};
		startDuration=3;
		maxSpeed=100;
		precision=15;
		steerAheadSimul=0.5;
		steerAheadPlan=0.69999999;
		predictTurnPlan=2;
		predictTurnSimul=1.5;
		liftForceCoef=1;
		cyclicAsideForceCoef=2;
		cyclicForwardForceCoef=1.2;
		bodyFrictionCoef=0.30000001;
		backRotorForceCoef=5;
		fuelCapacity= 0.5; // 30 мин = 1800 сек
		fuelConsumptionRate = 0.000277;
		maxFordingDepth=0.30000001;
		threat[]={0.1,0.1,0.1};
		maxMainRotorDive=0;
		minMainRotorDive=0;
		neutralMainRotorDive=0;
		gearRetracting=0;
		mainRotorSpeed=7;
		backRotorSpeed=-7;
		mainBladeCenter = "rotor_center";
		mainBladeRadius = 0.35;
		tailBladeCenter = "rotor2_center";
		tailBladeRadius = 0.35;
		tailBladeVertical=0;
		radarTargetSize=0.1;
		visualTargetSize=0.1;
		irTarget=0;
		lockDetectionSystem=0;
		incomingMissileDetectionSystem=0;
		weapons[]={};
		magazines[]={};
		irScanRangeMin=0;
		irScanRangeMax=0;
		irScanToEyeFactor=1;
		class TransportItems
		{
		};
		destrType="DestructWreck";
		driverCompartments="Compartment3";
		cargoCompartments[]=
		{
			"Compartment2"
		};
		// class HitPoints: HitPoints
		// {
		// 	class HitHull: HitHull
		// 	{
		// 		armor=0.1;
		// 	};
		// 	class HitHRotor: HitHRotor
		// 	{
		// 		armor=0.30000001;
		// 	};
		// };

		hiddenSelections[] = {"camo"};
		hiddenSelectionsTextures[] = {"mavik\textures\body_co.paa"};

		selectionDamage= "damage";
		class Damage
		{
			tex[]={};
			mat[]=
			{
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01_damage.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_01\Data\UAV_01_destruct.rvmat"
			};
		};
		class ViewPilot: ViewPilot
		{
			minFov=0.25;
            maxFov=0.8;
            initFov=0.8;
            initAngleX=0;
            minAngleX=-65;
            maxAngleX=85;
            initAngleY=0;
            minAngleY=-150;
            maxAngleY=150;
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1,6};
		};
		class Viewoptics: ViewOptics
		{
			initAngleX=0;
			minAngleX=0;
			maxAngleX=0;
			initAngleY=0;
			minAngleY=0;
			maxAngleY=0;
			minFov=0.25;
			maxFov=0.8;
			initFov=0.8;
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1,6};
		};
		class MFD
		{
		};
		enableManualFire=1;
		reportRemoteTargets=1;
		reportOwnPosition=1;
		class PilotCamera
		{
			minTurn=-27;
            maxTurn=27;
            initTurn=0;
            minElev=-35;
            maxElev=90;
            initElev=0;
			maxXRotSpeed=1;
			maxYRotSpeed=1;
			maxMouseXRotSpeed=0.5;
			maxMouseYRotSpeed=0.5;
			pilotOpticsShowCursor=1;
			controllable=1;
			// body="mainTurret";
   //       gun="mainGun";
   //       animationSourceBody="mainTurret";
   //       animationSourceGun="mainGun";
			class OpticsIn
			{
				class Wide
				{
					opticsDisplayName="WFOV";
					initAngleX=0;
					minAngleX=0;
					maxAngleX=0;
					initAngleY=0;
					minAngleY=0;
					maxAngleY=0;
					initFov=0.8;
					minFov=0.028;
					maxFov=0.8;
					directionStabilized=1;
					visionMode[]=
					{
						"Normal",
						"Ti"
					};
					thermalMode[]={0,1,6};
					GunnerOpticsModel="\mavik\mavik_hud.p3d";
					opticsPPEffects[]=
					{
						"OpticsCHAbera2",
						"OpticsBlur2"
					};
				};
				showMiniMapInOptics=1;
				showUAVViewInOptics=0;
				showSlingLoadManagerInOptics=0;
			};
		};
		attenuationEffectType="OpenHeliAttenuation";
		soundGetIn[]=
		{
			"",
			1,
			1
		};
		soundGetOut[]=
		{
			"",
			1,
			1,
			50
		};
		soundEnviron[]=
		{
			"",
			0.031622775,
			1
		};
		soundDammage[]=
		{
			"",
			0.56234133,
			1
		};
		soundEngineOnInt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_start_full_int",
			0,
			2
		};
		soundEngineOnExt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_start_full_01",
			0.56234133,
			3,
			60
		};
		soundEngineOffInt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_stop_full_int",
			0,
			2
		};
		soundEngineOffExt[]=
		{
			"A3\Sounds_F\air\Uav_01\quad_stop_full_01",
			0.56234133,
			3,
			60
		};
		soundBushCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",
			1,
			1,
			10
		};
		soundBushCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",
			1,
			1,
			10
		};
		soundBushCollision3[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",
			1,
			1,
			10
		};
		soundBushCrash[]=
		{
			"soundBushCollision1",
			0.33000001,
			"soundBushCollision2",
			0.33000001,
			"soundBushCollision3",
			0.33000001
		};
		soundWaterCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",
			1,
			1,
			10
		};
		soundWaterCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",
			1,
			1,
			10
		};
		soundWaterCrashes[]=
		{
			"soundWaterCollision1",
			0.5,
			"soundWaterCollision2",
			0.5
		};
		Crash0[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1",
			1,
			1,
			90
		};
		Crash1[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2",
			1,
			1,
			90
		};
		Crash2[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3",
			1,
			1,
			90
		};
		Crash3[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4",
			1,
			1,
			90
		};
		soundCrashes[]=
		{
			"Crash0",
			0.25,
			"Crash1",
			0.25,
			"Crash2",
			0.25,
			"Crash3",
			0.25
		};
		class Sounds
		{
			class Engine
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\quad_engine_full_01",
					0.44668359,
					3,
					60
				};
				frequency="rotorSpeed";
				volume="camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorLowOut
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade",
					0.31622776,
					3,
					60
				};
				frequency="rotorSpeed";
				volume="camPos*(0 max (rotorSpeed-0.1))";
				cone[]={1.6,3.1400001,1.6,0.94999999};
			};
			class RotorHighOut
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_high",
					0.31622776,
					3,
					65
				};
				frequency="rotorSpeed";
				volume="camPos*10*(0 max (rotorThrust-0.9))";
				cone[]={1.6,3.1400001,1.6,0.94999999};
			};
			class EngineIn
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\quad_engine_full_int",
					0,
					2
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*((rotorSpeed-0.75)*4)";
			};
			class RotorLowIn
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_int",
					0,
					2
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*(0 max (rotorSpeed-0.1))";
			};
			class RotorHighIn
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_high_int",
					0,
					2
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*3*(rotorThrust-0.9)";
			};
		};
		class Exhausts
		{
			class Exhaust_1
			{
				position="Exhaust_1_pos";
				direction="Exhaust_1_dir";
				effect="ExhaustsEffectDrone";
			};
		};
		class Library
		{
			libTextDesc="$STR_A3_CfgVehicles_UAV_01_base_Library0";
		};
		class EventHandlers
		{
			class Mavic_Events
			{
				killed = "player connectTerminalToUAV objNull; { _x setDamage 1 } forEach (crew (_this # 0));";
				init = "params ['_entity']; if ((isClass(configFile >> ""CfgPatches"" >> ""DB_D37_scripts_mavick_vogs"")) && !(is3DEN)) then { [_entity, 1] spawn mavic_drop_fnc_makeGrenadeDrone; };";
			};
		};
		class UserActions
		{
			class DisassembleUAV
			{
				displayName = "Put in inventory";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition = "[this] call mavic_fnc_canDisassembly";
				statement = "[this, player] call mavic_fnc_addUavToInventory";
			};
			class ChangeBattery
			{
				displayName = "Change Battery";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition = "!(isClass (configFile >> ""CfgPatches"" >> ""ace_main"")) && (alive this) && ([player, ""Laserbatteries""] call BIS_fnc_hasItem) && (cameraOn == player) && {(fuel this) < 1} && {(speed this) < 1} && {!(isEngineOn this)}";
				statement = "[this, player] call mavic_fnc_changeBattery";
			};
		};
		class Turrets {};
		// class Turrets:turrets
		// {
		// 	class mainturret:mainturret
		// 	{
		// 		LODTurnedIn = 0;
		// 		LODTurnedOut = 0;
		// 		maxElev = 35;
		// 		minElev = -90;
		// 		minTurn = -27;
		// 		maxTurn = 27;
		// 		stabilizedInAxes = 3;
		// 		GunnerOpticsModel="\mavik\mavik_hud.p3d";
		// 	};
		// };
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
	};

	class mavik_3T_OPF: mavic3T_drone_base_F
	{
		author="$Sam";
		_generalMacro="mavik_3T_OPF";
		scope=2;
		scopeCurator = 2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="Mavic-3T";
		accuracy=0.5;
		textureList[]=
		{
			"Indep",
			1
		};
	};
	class mavik_3T_BLU : mavik_3T_OPF
	{
		_generalMacro="mavik_3T_BLU";
		scope=2;
		scopeCurator = 2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
	};
	class mavik_3T_IND : mavik_3T_OPF
	{
		_generalMacro="mavik_3T_IND";
		scope=2;
		scopeCurator = 2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
	};

	class mavik_3_OPF: mavic_drone_base_F
	{
		author="$Sam";
		_generalMacro="mavik_3_OPF";
		scope=2;
		scopeCurator = 2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="Mavic-3";
		accuracy=0.5;
		textureList[]=
		{
			"Indep",
			1
		};
	};
	class mavik_3_BLU : mavik_3_OPF
	{
		_generalMacro="mavik_3_BLU";
		scope=2;
		scopeCurator = 2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
	};
	class mavik_3_IND : mavik_3_OPF
	{
		_generalMacro="mavik_3_IND";
		scope=2;
		scopeCurator = 2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
	};
};

class CfgMagazines
{
	class Laserbatteries;
	class Item_Mavic : Laserbatteries
	{
		_generalMacro = "Item_Mavic";
		scope = 2;
		author = "DarkBall";
		descriptionShort = "DJI Mavic 3";
		displayName = "Mavic 3";
		model="\mavik\mavik3.p3d";
		icon="\mavik\interface\game\mavick_map.paa";
		picture="\mavik\interface\game\mavick_map.paa";

		mass = 60;
		count = 1;
		ammo = "";
	};

	class Item_Mavic3T : Laserbatteries
	{
		_generalMacro = "Item_Mavic3T";
		scope = 2;
		author = "DarkBall";
		descriptionShort = "DJI Mavic 3T";
		displayName = "Mavic 3T";
		model="\mavik\mavik3.p3d";
		icon="\mavik\interface\game\mavick_map.paa";
		picture="\mavik\interface\game\mavick_map.paa";

		mass = 60;
		count = 1;
		ammo = "";
	};
};

class CfgSounds
{
	sounds[] = {};

	class Mavic_Beep
	{
		name = "Mavic Beep";						// display name
		sound[] = { "\mavik\sounds\beep.ogg", 1, 50, 100 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "" };
	};
};

#include "includes\RscTitles.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"
#include "includes\Extended_ClientInit_EventHandlers.hpp"