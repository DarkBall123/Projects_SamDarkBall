class CfgPatches
{
	class zala421_aero
	{
		units[]=
		{
			"zala421_uav_b",
			"zala421_uav_o",
			"zala421_uav_i",
			"zala421_tripod_launcher_b",
			"zala421_tripod_launcher_o",
			"zala421_tripod_launcher_i",
			"zala421_AmmoBox",
			"zala421_Tripod_Bag_Support",
			"zala421_dummy_mag"
		};
		weapons[]=
		{
			"zala421_launcher_weap"
		};
		ammo[]=
		{
		};
		requiredVersion=1.38;
		requiredAddons[]={};
		name="zala421";
		author="Sam";
	};
};

#include "interface\Zala421_Interface.hpp"

class CfgWeapons
{
	class fakeWeapon;
	class zala421_launcher_weap: fakeWeapon
	{
		class GunParticles
		{
			class FirstEffect
			{
				directionName="konec hlavne";
				effectName="GrenadeLauncherCloud";
				positionName="usti hlavne";
			};
		};
		class BaseSoundModeType
		{
			closure1[]=
			{
				"A3\Sounds_F\arsenal\weapons\UGL\Closure_UGL",
				1,
				1,
				10
			};
			soundClosure[]=
			{
				"closure1",
				1
			};
		};
		class StandardSound
		{
			begin1[]=
			{
				"A3\Sounds_F\arsenal\weapons\UGL\UGL_01",
				0.707946,
				1,
				200
			};
			begin2[]=
			{
				"A3\Sounds_F\arsenal\weapons\UGL\UGL_02",
				0.707946,
				1,
				200
			};
			closure1[]=
			{
				"A3\Sounds_F\arsenal\weapons\UGL\Closure_UGL",
				1,
				1,
				10
			};
			soundBegin[]=
			{
				"begin1",
				0.5,
				"begin2",
				0.5
			};
			soundClosure[]=
			{
				"closure1",
				1
			};
			soundSetShot[]=
			{
				"DS_UGL_Closure_SoundSet",
				"DS_UGL_Shot_SoundSet",
				"DS_pistol1_Tail_SoundSet"
			};
		};
		magazineReloadTime=60;
		reloadTime=60;
	};
};

class cfgMagazines
{
	class Titan_AT;
	class zala421_dummy_mag: Titan_AT
	{
		modelspecial="\zala421\zala421_uav.p3d";
		model="\zala421\zala421_uav.p3d";
		displayname="zala421 Disassembled";
		ammo="";
		mass=300;
		author="Z Virtual Ordnance";
		scope=2;
		picture="";
	};
};

class SensorTemplatePassiveRadar
{
};
class SensorTemplateAntiRadiation: SensorTemplatePassiveRadar
{
};
class SensorTemplateIR: SensorTemplateAntiRadiation
{
};
class SensorTemplateMan: SensorTemplateIR
{
};
class SensorTemplateVisual: SensorTemplateIR
{
};
class SensorTemplateLaser : SensorTemplateAntiRadiation
{
};
class SensorTemplateNV : SensorTemplateLaser
{
};
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
	class Air: AllVehicles
	{
		class Components
		{
		};
	};
	class Plane: Air
	{
	};
	class UAV: Plane
	{
	};
	class UAV_02_base_F: UAV
	{
		class Turrets
		{
			class MainTurret: NewTurret
			{
			};
		};
		class Sounds
		{
			class EngineHighIn
			{
			};
			class EngineHighOut
			{
			};
			class EngineLowIn
			{
			};
			class EngineLowOut
			{
			};
			class ForsageIn
			{
			};
			class ForsageOut
			{
			};
			class WindNoiseIn
			{
			};
			class WindNoiseOut
			{
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
					};
					class VisualSensorComponent: SensorTemplateVisual
					{
					};
				};
			};
		};
	};
	class UAV_02_dynamicLoadout_base_F: UAV_02_base_F
	{
		class Turrets
		{
			class MainTurret: NewTurret
			{
			};
		};
		class Components: Components
		{
			class TransportPylonsComponent
			{
				class presets
				{
				};
				class pylons
				{
					class pylons1
					{
					};
					class pylons2: pylons1
					{
					};
				};
			};
		};
	};
	class B_UAV_02_dynamicLoadout_F: UAV_02_dynamicLoadout_base_F
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
			};
		};
	};
	class zala421_uav_base: B_UAV_02_dynamicLoadout_F
	{
		side=1;
		faction="BLU_F";
		scopecurator=0;
		scope=0;
		class MFD
		{
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
		unitInfoType="RscUnitInfoNoWeapon";
		unitInfoTypeRTD="RscUnitInfoNoWeapon";
		driverWeaponsInfoType="RscOptics_Offroad_01";
		driverOpticsModel="\zala421\2.p3d";
		GunnerOpticsModel="\zala421\1.p3d";
		uavCameraDriverDir="laserstart";
		uavCameraDriverPos="commanderview";
		uavCameraGunnerDir="laserstart";
		uavCameraGunnerPos="commanderview";
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
		artilleryScanner=0;
		artilleryTarget=0;
		attendant=0;
		attenuationEffectType="OpenHeliAttenuation";
		audible=0.1;
		autocenter=1;
		brakeDistance=500;
		cameraSmoothSpeed=5;
		camouflage=0.2;
		camShakeCoef=0;
		canHideDriver=-1;
		canUseScanners=1;
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
		cost=10100;
		countermeasureActivationRadius=1;
		countsForScoreboard=1;
		crew="B_UAV_AI";
		crewCrashProtection=0.15000001;
		crewVulnerable=1;
		curatorInfoType="";
		curatorInfoTypeEmpty="";
		damageEffect="";
		damageFull[]={};
		damageHalf[]={};
		damageResistance=0.0067599998;
		damageTexDelay=0;
		destrType="DestructWreck";
		detectSkill=10;
		draconicForceXCoef=8;
		draconicForceYCoef=1;
		draconicForceZCoef=1;
		draconicTorqueXCoef=0.15000001;
		draconicTorqueYCoef=0;
		driveOnComponent[]={};
		driverCanSee="31+32";
		elevatorControlsSensitivityCoef=1.2;
		elevatorSensitivity=0.3;
		elevatorCoef[]={0,0.80000001,0.89999998,1,1.1,1.2,1.2,1.3,1.3,1.3,1.4,1.4,1.4};
		envelope[]={0,2.5999999,2.8,2.5,2,1.8200001,1.75,1.63,1.55,2,2,2,1,1};
		epeImpulseDamageCoef=100;
		expansion=3;
		explosionShielding=2;
		extCameraParams[]={0.5,10,50,0.5,1,10,30,0,1};
		extCameraPosition[]={0,2,-5};
		fireResistance=10;
		flaps=1;
		flapsFrictionCoef=0.5;
		flareVelocity=100;
		forceHideDriver=0;
		formationTime=10;
		formationX=200;
		formationZ=300;
		fuelCapacity=200;
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
		hullDamageCauseExplosion=0;
		impactEffectSpeedLimit=8;
		impactEffectsSea="ImpactEffectsAir";
		incomingMissileDetectionSystem="8 + 16";
		indirectHitCivilianCoefAI=-20;
		indirectHitEnemyCoefAI=10;
		indirectHitFriendlyCoefAI=-20;
		indirectHitUnknownCoefAI=-0.5;
		insideDetectCoef=0.0099999998;
		insideSoundCoef=0.0116228;
		irScanGround=1;
		irScanRangeMax=10000;
		irScanRangeMin=2000;
		irScanToEyeFactor=2;
		irTarget=1;
		irTargetSize=0.1;
		isbackpack=0;
		isUav=1;
		keepInEPESceneAfterDeath=0;
		killFriendlyExpCoef=1;
		landingAoa=0;
		landingSpeed=0;
		laserScanner=1;
		laserTarget=0;
		limitedSpeedCoef=1;
		LockDetectionSystem="8 + 4";
		magazines[]={};
		mapSize=5;
		maxDetectRange=1;
		maxFordingDepth=0.001;
		maxGForce=2;
		maxGunElev=0;
		maxGunTurn=0;
		maximumLoad=300;
		maxSpeed=180;
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
		radarTargetSize=1;
		radarType=4;
		rudderCoef[]={0.80000001,1,1,0.89999998,0.80000001,0.69999999,0.60000002};
		rudderControlsSensitivityCoef=4;
		rudderInfluence=0.96194702;
		secondaryExplosion=-1;
		sensitivity=2.5;
		sensitivityEar=0.0074999998;
		shadow=1;
		showAllTargets=2;
		showCrewAim=0;
		simulation="AirplaneX";
		stallSpeed=140;
		steerAheadPlan=2;
		steerAheadSimul=1;
		supplyRadius=1.2;
		tailHook=0;
		tBody=0;
		threat[]={0.5,1,0.1};
		thrustCoef[]={0,4.8000002,4.1999998,3.4000001,3.2,2.8,2.7,2.5999999,1.8,1.4,0.75,0.5,0,0,0,0};
		type=2;
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		uavHacker=0;
		unitInfoTypeLite=0;
		unloadInCombat=0;
		usePreciseGetInAction=0;
		vehicleClass="Autonomous";
		visualTarget=1;
		visualTargetSize=1;
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
		weapons[]={};
		weaponsGroup1="";
		weaponsGroup2="";
		weaponsGroup3="";
		weaponsGroup4="";
		weaponSlots=0;
		wheelCircumference=1;
		wheelSteeringSensitivity=0.5;
		windSockExist=0;
	};
	class zala421_uav_b: zala421_uav_base
	{
		model="\zala421\zala421_uav.p3d";
		destrType="DestructWreck";
		editorPreview = "\zala421\preview_zala421.jpg";
		icon = "\zala421\map_zala421.paa";
		displayName="Zala Z-16";
		_generalMacro="zala421_uav_b";
		scopecurator=2;
		scope=2;
		memoryPointPilot="commanderview";
		memoryPointDriverOptics="commanderview";
		fuelCapacity=235;
		radarTargetSize=0.30000001;
		accuracy=0.2;
		soundEngineOffExt[]=
		{
			"A3\Sounds_F_Orange\Vehicles\Air\UAV_01\Uav_01_Eng_Off_Ext",
			0.55848902,
			1,
			50
		};
		soundEngineOffInt[]=
		{
			"A3\Sounds_F_Orange\Vehicles\Air\UAV_01\Uav_01_Eng_Off_Ext",
			0.55848902,
			1,
			10
		};
		soundEngineOnExt[]=
		{
			"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_Eng_On_Ext",
			0.55848902,
			1,
			50
		};
		soundEngineOnInt[]=
		{
			"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_Eng_On_Int",
			0.55848902,
			1,
			10
		};
		soundGearUp[]=
		{
			"",
			1,
			1,
			120
		};
		soundGearDown[]=
		{
			"",
			1,
			1,
			120
		};
		soundFlapsDown[]=
		{
			"",
			0.63095701,
			1,
			100
		};
		soundFlapsUp[]=
		{
			"",
			0.63095701,
			1,
			100
		};
		class Sounds: Sounds
		{
			class EngineHighIn: EngineHighIn
			{
				frequency="(rpm factor[0.2, 1.0])";
				sound[]=
				{
					"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_Eng_01_Int",
					0.79432797,
					50
				};
				volume="0.25*((1-camPos)*(rpm factor[0.2, 1.0]))";
			};
			class EngineHighOut: EngineHighOut
			{
				frequency="(rpm factor[0.2, 1.0])";
				sound[]=
				{
					"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_Eng_01_Ext",
					1.87828,
					50,
					125
				};
				volume="0.10+(playerPos*(rpm factor[0.2, 1.0]))";
			};
			class EngineLowIn: EngineLowIn
			{
				frequency="1.0 min (rpm + 0.5)";
				sound[]=
				{
					"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_Eng_01_Int",
					0.63095701,
					50
				};
				volume="0.5*((1-camPos)*(rpm factor[0.95, 0])*(rpm factor[0, 0.95]))";
			};
			class EngineLowOut: EngineLowOut
			{
				frequency="1.0 min (rpm + 0.5)";
				sound[]=
				{
					"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_Eng_01_Ext",
					1.91254,
					50,
					125
				};
				volume="0.12+(playerPos*(rpm factor[0.95, 0])*(rpm factor[0, 0.95]))";
			};
			class ForsageIn: ForsageIn
			{
				sound[]=
				{
					"",
					0.63095701,
					1
				};
				volume="0";
			};
			class ForsageOut: ForsageOut
			{
				sound[]=
				{
					"",
					1.12202,
					1,
					900
				};
				volume="0";
			};
			class WindNoiseIn: WindNoiseIn
			{
				sound[]=
				{
					"",
					0,
					0
				};
				volume="0";
			};
			class WindNoiseOut: WindNoiseOut
			{
				frequency="(0.3+(1.005*(speed factor[1, 180])))";
				sound[]=
				{
					"A3\Sounds_F_Orange\Vehicles\Air\Uav_01\Uav_01_WindNoise_01_Ext",
					0.14125399,
					1,
					150
				};
				volume="0.15*(1-camPos)*(speed factor[1, 180])";
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
				minTurn = -120;
				maxTurn = 120;
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
						gunnerOpticsModel = "\zala421\1.p3d";
					};
					class Medium: Wide
					{
						opticsDisplayName = "2.5x";
						initFov = 0.1;
						minFov = 0.1;
						maxFov = 0.1;
						gunnerOpticsModel = "\zala421\1.p3d";
					};
					class Narrow: Wide
					{
						opticsDisplayName = "5x";
						initFov = 0.05;
						minFov = 0.05;
						maxFov = 0.05;
						gunnerOpticsModel = "\zala421\1.p3d";
					};
					class Close: Wide
					{
						opticsDisplayName = "10x";
						initFov = 0.025;
						minFov = 0.025;
						maxFov = 0.025;
						gunnerOpticsModel = "\zala421\1.p3d";
					};
					class SupClose: Wide
					{
						opticsDisplayName = "20x";
						initFov = 0.0125;
						minFov = 0.0125;
						maxFov = 0.0125;
						gunnerOpticsModel = "\zala421\1.p3d";
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
						gunnerOpticsModel = "\zala421\1.p3d";
						gunnerOpticsEffect[] = {};
					};
				};
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
	};

	class zala421_uav_o: zala421_uav_b
	{
		side=0;
		faction="OPF_F";
		displayName="Zala Z-16";
		_generalMacro="zala421_uav_o";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
	};

	class zala421_uav_i: zala421_uav_b
	{
		side=2;
		faction="IND_F";
		displayName="Zala Z-16";
		_generalMacro="zala421_uav_i";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
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
	class StaticMortar: StaticWeapon
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
			};
		};
	};
	class Mortar_01_base_F: StaticMortar
	{
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				class ViewOptics;
			};
		};
	};
	class zala421_tripod_launcher_b: Mortar_01_base_F
	{
		model="\zala421\tripod\zala421_tripod.p3d";
		crew="B_soldier_UAV_F";
		editorPreview = "\zala421\preview_tripodzala421.jpg";
		_generalmacro="zala421_tripod_launcher";
		displayName="Zala Z-16 Tripod Launcher";
		scopecurator=2;
		scope=2;
		side=1;
		faction="BLU_F";
		artilleryScanner=0;
		destrType="DestructWreck";
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				LODTurnedIn=0;
				LODTurnedOut=0;
				LODOpticsIn=0;
				LODOpticsOut=0;
				gunnerOpticsModel="\A3\weapons_f\reticle\optics_empty";
				turretInfoType="RscOptics_Offroad_01";
				weapons[]=
				{
					"zala421_launcher_weap"
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
				class ViewOptics: ViewOptics
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
						"Normal",
						"NVG"
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
		class AnimationSources
		{
			class zala421_revolving
			{
				source="revolving";
				weapon="zala421_launcher_weap";
			};
		};
		class EventHandlers
		{
			class zala421_Handlers
			{
				init="_this spawn zala421_fnc_handleAnim;";
				fired="_this call zala421_fnc_init_launcher_tripod; playSound3D ['\zala421\tripod\zapusk.ogg', _this # 0, false, getPosASL (_this # 0), 5]";
			};
		};

		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"zala421_Tripod_Bag_Weapon",
				"zala421_Tripod_Bag_Support"
			};
			displayName="";
		};

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
				condition="(vehicle player == player) && (not (this getVariable ['zala421_isAssembleing', false])) && (not (someAmmo this)) && ((this call zala421_fnc_checkContainersForMag) || ('zala421_dummy_mag' in magazines player))";
				statement="current_tripod = this; this setVariable ['zala421_isAssembleing', true, true]; ['Assembling the zala421', 30, {player playMoveNow 'AinvPknlMstpSnonWnonDnon_medic_1'; alive player}, {current_tripod call zala421_fnc_reload_tripod}, {current_tripod setVariable ['zala421_isAssembleing', false, true]}] call CBA_fnc_progressBar;";
				icon="";
			};
		};
	};

	class zala421_tripod_launcher_o: zala421_tripod_launcher_b
	{
		crew="O_soldier_UAV_F";
		_generalmacro="zala421_tripod_launcher_o";
		scopecurator=2;
		scope=2;
		side=0;
		faction="OPF_F";
	};

	class zala421_tripod_launcher_i: zala421_tripod_launcher_b
	{
		crew="I_soldier_UAV_F";
		_generalmacro="zala421_tripod_launcher_i";
		scopecurator=2;
		scope=2;
		side=2;
		faction="IND_F";
	};

	class Bag_Base;
	class Weapon_Bag_Base;
	class zala421_Tripod_Bag_Support: Bag_Base
	{
		scope=2;
		displayName="Folded Zala Z-16 Bipod";
		author="DarkBall";
		vehicleClass="Backpacks";
		class assembleInfo
		{
			assembleTo="";
			base="";
			displayName="";
			dissasembleTo[]={};
			primary=0;
		};
	};
	class zala421_Tripod_Bag_Weapon: Weapon_Bag_Base
	{
		scope=2;
		displayName="Folded Zala Z-16 Tripod Tube";
		author="DarkBall";
		vehicleClass="Backpacks";
		class assembleInfo
		{
			assembleTo="zala421_tripod_launcher";
			base[]=
			{
				"zala421_Tripod_Bag_Support"
			};
			displayName="zala421 Tripod";
			dissasembleTo[]={};
			primary=1;
		};
	};

	class Box_EAF_WpsSpecial_F;
	class zala421_AmmoBox: Box_EAF_WpsSpecial_F
	{
		scope=2;
		scopecurator=2;
		author="DarkBall";
		displayName="Zala Z-16 disassembled";
		class EventHandlers
		{
			class zala421Box_Init
			{
				init="clearItemCargoGlobal (_this # 0); clearMagazineCargoGlobal (_this # 0); clearWeaponCargoGlobal (_this # 0); (_this # 0) addItemCargoGlobal ['zala421_dummy_mag', 1];";
			};
		};
	};
};

class CfgFunctions
{
	class zala421
	{
		class init
		{
			file="\zala421\functions";
			class handleAnim
			{
			};
			class init_launcher_tripod
			{
			};
			class setAngleOfAttack
			{
			};
			class reload_tripod
			{
			};
			class checkContainersForMag
			{
			};
			class drawHudGunner
			{
			};
			class drawHudDriver
			{
			};
			class handleConnect
			{
				postInit = 1;
			};
			class onExit
			{
			};
			class drawCompass
			{
			};
		};
	};
};