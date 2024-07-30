
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

	class UAV;
	class UAV_02_base_F:UAV
	{
		class NewTurret;
		class ViewPilot;
		class ViewOptics;
		class AnimationSources;
		class Components;
		class TextureSources;
	};
	class orion_F_OPF:  UAV_02_base_F
	{
		scope=2;
		scopeCurator=2;
		forceInGarage=1;
		vehicleClass="Autonomous";
		_generalMacro="orion_F";
		side=0;
		faction = "OPF_F";
		displayName="Orion";
		author="B01/Sam";
		unitInfoType="RscOptics_AV_airplane_pilot";
		simulation="airplaneX";
		crew = "O_UAV_AI";
		editorPreview = "\orion\pictures\preview_orion.jpg";
		icon = "\orion\pictures\map_orion.paa";
		mapSize=20.1;
		model="\orion\orion.p3d";
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
		hiddenSelections[] = {"Camo_1"};
		hiddenSelectionsTextures[] = {"\orion\textures\orion_CO"};
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
			class HitGear : HitHull
			{
				armor = 1.5;
				explosionShielding = 3;
				name = "HitGear";
				passThrough = 0.1;
				visual = "Hit_Gear";
				radius = 0.2;
				minimalHit = 0.1;
				depends = "0";
			};
		};
		class Exhausts
		{
			class Exhaust_center
			{
				position = "pos_Exhausts_start_center";
				direction = "pos_Exhausts_end_center";
				effect = "ExhaustsEffectHeliComHP";
			};
		};
		class Armory
		{
			description = "$STR_A3_CfgVehicles_UAV_02_base_Armory0";
		};
		driveOnComponent[] = {};
		maximumLoad = 250;
		class TransportItems{};
		uavCameraDriverPos = "PiP0_pos";
		uavCameraDriverDir = "PiP0_dir";
		uavCameraGunnerPos = "laserstart";
		uavCameraGunnerDir = "commanderview";
		LODTurnedIn = -1;
		LODTurnedOut = -1;
		memoryPointLDust = "DustLeft";
		memoryPointRDust = "DustRight";
		memoryPointDriverOptics = "PiP0_pos";
		driverOpticsModel = "\orion\driver.p3d";
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
			visionMode[] = {"Normal","NVG","Ti"};
			thermalMode[] = {0,1};
		};
		class AnimationSources: AnimationSources
		{
			class Bombs
			{
				source = "user";
				animPeriod = 1e-006;
				initPhase = 0;
			};
			class AT_missiles
			{
				source = "user";
				animPeriod = 0.99;
				initPhase = 1;
			};
			class Damper_1_source
			{
				source = "damper";
				wheel = "Wheel_1";
			};
			class Damper_2_source
			{
				source = "damper";
				wheel = "Wheel_2";
			};
			class Damper_3_source
			{
				source = "damper";
				wheel = "Wheel_3";
			};
			class Wheel_1_source
			{
				source = "wheel";
				wheel = "Wheel_1";
			};
			class Wheel_2_source
			{
				source = "wheel";
				wheel = "Wheel_2";
			};
			class Wheel_3_source
			{
				source = "wheel";
				wheel = "Wheel_3";
			};
		};
		class camShakeGForce
		{
			distance = 0;
			frequency = 2;
			minSpeed = 1;
			power = 0.1;
		};
		landingAoa = 0.1309;
		landingSpeed = 140;
		stallSpeed = 100;
		stallWarningTreshold = 0.07;
		wheelSteeringSensitivity = 1.3;
		airBrake = 1;
		airBrakeFrictionCoef = 2;
		flaps = 1;
		flapsFrictionCoef = 0.2;
		gearsUpFrictionCoef = 0.35;
		airFrictionCoefs0[] = {0.0, 0.0, 0.0};
		airFrictionCoefs1[] = {0.1, 0.5, 0.0082};
		airFrictionCoefs2[] = {0.001, 0.005, 7.5e-005};
		angleOfIndicence = 1*3.1415/180;
		envelope[] = {0.0,0.07,0.26,0.59,1.04,1.63,1.98,2.7,3.2,4.05,4.68,5.49,6.19,7.04,7.53,7.9,8.2,8.4,8.5,8.2,7.0};
		altNoForce = 14000;
		altFullForce = 6000;
		thrustCoef[] = {1.36,1.25,1.14,1.04,0.95,0.86,0.78,0.7,0.61,0.3,0.0,0.0,0.0};
		aileronSensitivity = 0.6;
		aileronCoef[] = {0.0,0.12,0.46,0.65,0.75,0.82,0.88,0.92,0.95,0.97,0.99,1.0,1.01};
		elevatorSensitivity = 0.7;
		elevatorCoef[] = {0.0,0.2,0.7,0.47,0.38,0.32,0.28,0.25,0.22,0.19,0.17,0.15,0.13};
		rudderInfluence = 0.9397;
		rudderCoef[] = {0.0,0.6,1.2,1.5,1.7,1.8,1.9,1.9,2.0,2.0,2.0,1.8,1.4};
		aileronControlsSensitivityCoef = 3.0;
		elevatorControlsSensitivityCoef = 3.0;
		rudderControlsSensitivityCoef = 3.0;
		draconicForceXCoef = 8.0;
		draconicForceYCoef = 1.1;
		draconicForceZCoef = 1.0;
		draconicTorqueXCoef[] = {2.0,2.5,3.1,3.7,4.4,5.1,5.9,6.5,7.0,7.5,7.9,8.3,8.5};
		draconicTorqueYCoef[] = {12.0,8.0,3.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
		engineMoi = 0.1;
		dampingRateFullThrottle = 0.03;
		dampingRateZeroThrottleClutchEngaged = 0.03;
		dampingRateZeroThrottleClutchDisengaged = 0.03;
		class Wheels
		{
			disableWheelsWhenDestroyed = 1;
			class Wheel_1
			{
				boneName = "Wheel_1";
				steering = 1;
				side = "left";
				center = "Wheel_1_center";
				boundary = "Wheel_1_rim";
				width = 0.16;
				mass = 10;
				MOI = 0.207057;
				dampingRate = 0.1;
				dampingRateDamaged = 1;
				dampingRateDestroyed = 1000;
				maxBrakeTorque = 0;
				maxHandBrakeTorque = 0;
				suspTravelDirection[] = {0,-1,0};
				suspForceAppPointOffset = "Wheel_1_center";
				tireForceAppPointOffset = "Wheel_1_center";
				maxCompression = 0.1;
				maxDroop = 0.1;
				sprungMass = 1200;
				springStrength = 50000;
				springDamperRate = 16000;
				longitudinalStiffnessPerUnitGravity = 400;
				latStiffX = 2;
				latStiffY = 18;
				frictionVsSlipGraph[] = {{0,0.4},{0.2,0.7},{0.5,0.5}};
			};
			class Wheel_2: Wheel_1
			{
				boneName = "Wheel_2";
				steering = 0;
				center = "Wheel_2_center";
				boundary = "Wheel_2_rim";
				width = 0.28;
				sprungMass = 900;
				suspForceAppPointOffset = "Wheel_2_center";
				tireForceAppPointOffset = "Wheel_2_center";
				maxCompression = 0.05;
				maxDroop = 0.05;
				maxBrakeTorque = 500;
			};
			class Wheel_3: Wheel_2
			{
				boneName = "Wheel_3";
				side = "right";
				center = "Wheel_3_center";
				boundary = "Wheel_3_rim";
				suspForceAppPointOffset = "Wheel_3_center";
				tireForceAppPointOffset = "Wheel_3_center";
			};
		};
		killFriendlyExpCoef = 0.1;
		driverCompartments = "Compartment3";
		cargoCompartments[] = {"Compartment2"};
		class Damage
		{
			tex[] = {};
			mat[] = {"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02.rvmat","A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_damage.rvmat","A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_destruct.rvmat"};
		};
		weapons[] = {};
		magazines[] = {};
		radarTargetSize = 0.5;
		visualTargetSize = 0.7;
		irTargetSize = 0.5;
		lockDetectionSystem = 8;
		incomingMissileDetectionSystem = "8 + 16";
		laserscanner = 1;
		showAllTargets = 4;
		receiveRemoteTargets = 1;
		reportRemoteTargets = 1;
		reportOwnPosition = 1;
		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB50_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
	
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
				weapons[] = {"Orion_Laserdesignator_mounted"};
				magazines[] = {"Laserbatteries"};
				fuelCapacity=2863;
				fuelConsumptionRate=0.00149999995;
				maxSpeed = 199;
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
						gunnerOpticsModel = "\orion\1.p3d";
					};
					class Medium: Wide
					{
						opticsDisplayName = "2.5x";
						initFov = 0.1;
						minFov = 0.1;
						maxFov = 0.1;
						gunnerOpticsModel = "\orion\2.p3d";
					};
					class Narrow: Wide
					{
						opticsDisplayName = "5x";
						initFov = 0.05;
						minFov = 0.05;
						maxFov = 0.05;
						gunnerOpticsModel = "\orion\3.p3d";
					};
					class Close: Wide
					{
						opticsDisplayName = "10x";
						initFov = 0.025;
						minFov = 0.025;
						maxFov = 0.025;
						gunnerOpticsModel = "\orion\4.p3d";
					};
					class SupClose: Wide
					{
						opticsDisplayName = "20x";
						initFov = 0.0125;
						minFov = 0.0125;
						maxFov = 0.0125;
						gunnerOpticsModel = "\orion\5.p3d";
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
		class TextureSources 
		{
			class Russian_DCamo {
				displayName = "Russian Camo VKS";
				author = SAM;
				textures[] = {"orion\textures\orion_CO.paa"};
				factions[] = {"OPF_F"};
			};
			
			class Russian_Camo {
				displayName = "Russian Camo";
				author = SAM;
				textures[] = {"orion\camo\eorion_CO.paa"};
				factions[] = {"OPF_F"};
			};
			
				class Syrian_camo {
				displayName = "Syrian Camo";
				author = SAM;
				textures[] = {"orion\camo\syrianorion_CO.paa"};
				factions[] = {"OPF_F"};
			};
		};
		textureList[] = {};
		
		class EventHandlers {
			class Orion_Events {
				killed = "player connectTerminalToUAV objNull; { _x setDamage 1 } forEach (crew (_this # 0));";
			};
		};
	};

	class orion_F_KORNET_OPF : orion_F_OPF
	{
		_generalMacro="orion_F_KORNET_OPF";
		displayName="Orion Kornet-D (ATGM)";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "Kornet_D_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};

	class orion_F_KAB50_OPF : orion_F_OPF
	{
		_generalMacro="orion_F_KAB50_OPF";
		displayName="Orion KAB-50";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB50_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};

	class orion_F_KAB20_OPF : orion_F_OPF
	{
		_generalMacro="orion_F_KAB20_OPF";
		displayName="Orion KAB-20";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB20_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};
	
	class orion_F_BLU : orion_F_OPF {
		side = 1;
		faction = BLU_F;
		displayName = "Orion-E";
		author = "B01/Sam";
		crew = B_UAV_AI;
		hiddenSelections[] = {"Camo_1"};
		hiddenSelectionsTextures[] = {"\orion\camo\Eorion_CO.paa"};
		class TextureSources 
		{
			class Russian_Camo {
				displayName = "Russian Camo";
				author = SAM;
				textures[] = {"orion\camo\Eorion_CO.paa"};
				factions[] = {"BLU_F"};
			};
			
			class Syrian_camo {
				displayName = "Syrian Camo";
				author = SAM;
				textures[] = {"orion\camo\syrianorion_CO.paa"};
				factions[] = {"BLU_F"};
			};
		};
		textureList[] = {};
	};

	class orion_F_KORNET_BLU : orion_F_BLU
	{
		_generalMacro="orion_F_KORNET_BLU";
		displayName="Orion Kornet-D (ATGM)";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "Kornet_D_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};

	class orion_F_KAB50_BLU : orion_F_BLU
	{
		_generalMacro="orion_F_KAB50_BLU";
		displayName="Orion KAB-50";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB50_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};

	class orion_F_KAB20_BLU : orion_F_BLU
	{
		_generalMacro="orion_F_KAB20_BLU";
		displayName="Orion KAB-20";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB20_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};
	
	class orion_F_IND : orion_F_OPF {
		side = 2;
		faction = IND_F;
		displayName = "Orion-E";
		author = "B01/Sam";
		crew = I_UAV_AI;
		hiddenSelections[] = {"Camo_1"};
		hiddenSelectionsTextures[] = {"\orion\camo\Eorion_CO.paa"};
		class TextureSources 
		{
			class Russian_Camo {
				displayName = "Russian Camo";
				author = SAM;
				textures[] = {"orion\camo\eorion_CO.paa"};
				factions[] = {"IND_F"};
			};
			
			class Syrian_camo {
				displayName = "Syrian Camo";
				author = SAM;
				textures[] = {"orion\camo\syrianorion_CO.paa"};
				factions[] = {"IND_F"};
			};
		};
		textureList[] = {};
	};

	class orion_F_KORNET_IND : orion_F_IND
	{
		_generalMacro="orion_F_KORNET_IND";
		displayName="Orion Kornet-D (ATGM)";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "Kornet_D_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};

	class orion_F_KAB50_IND : orion_F_IND
	{
		_generalMacro="orion_F_KAB50_IND";
		displayName="Orion KAB-50";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB50_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};

	class orion_F_KAB20_IND : orion_F_IND
	{
		_generalMacro="orion_F_KAB20_IND";
		displayName="Orion KAB-20";

		class Components: Components
		{
			class TransportPylonsComponent 
			{
				UIPicture = "\orion\pictures\orionpylons.paa";
				
				class pylons {
					class pylon_1 {
						hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
						attachment = "KAB20_Magazine";
						priority = 5;
						turret[] = {0};
						maxweight = 345;
						UIposition[] = {0.33, 0.4};
					};
					
					class pylon_2 : pylon_1 {
						UIposition[] = {0.33, 0.15};
						mirroredMissilePos = 1;
					};
				};
			};
		};
	};
};