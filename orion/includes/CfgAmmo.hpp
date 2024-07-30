class CfgAmmo
{
	class bomb_04_f;
	class SAM_KAB50_Ammo: bomb_04_f
	{
		AIAmmoUsageFlags = 64+128+256;
		hit = 1000;
		indirectHit = 800;
		indirectHitRange = 30;
		model = "\orion\kab50\kab50_mag";
		proxyShape = "\orion\kab50\kab50_mag";
		canlock = 2;
		airLock = 0;
		irLock = 0;
		laserLock = 1;
		triggerOnImpact = 1;
		weaponLockSystem = 4;
		allowAgainstInfantry = 1;
		missileLockCone = 180;
		missileKeepLockedCone = 180;
		missileLockMaxDistance = 30000;
		missileLockMinDistance = 50;
		autoseekTarget = 1; 
		lockSeekRadius = 2000;
		flightProfiles[] = {"LoalAltitude"};
		class LoalAltitude
		{
			lockSeekAltitude = 5000;
		};
	};
	class SAM_KAB20_Ammo: bomb_04_f
	{
		AIAmmoUsageFlags = 64+128+256;
		hit = 500;
		indirectHit = 150;
		indirectHitRange = 10;
		canlock = 2;
		airLock = 0;
		irLock = 0;
		laserLock = 1;
		triggerOnImpact = 1;
		weaponLockSystem = 4;
		allowAgainstInfantry = 1;
		model = "\orion\kab20\kab20";
		proxyShape = "\orion\kab20\kab20";
		missileLockCone = 180;
		missileKeepLockedCone = 180;
		missileLockMaxDistance = 30000;
		missileLockMinDistance = 50;
		autoseekTarget = 1; 
		lockSeekRadius = 2000;
		flightProfiles[] = {"LoalAltitude"};
		class LoalAltitude
		{
			lockSeekAltitude = 5000;
		};	
		soundFakeFall0[] = {"a3\Sounds_F\weapons\falling_bomb\fall_01", 3.16228, 1, 1000};
		soundFakeFall1[] = {"a3\Sounds_F\weapons\falling_bomb\fall_02", 3.16228, 1, 1000};
		soundFakeFall2[] = {"a3\Sounds_F\weapons\falling_bomb\fall_03", 3.16228, 1, 1000};
		soundFakeFall3[] = {"a3\Sounds_F\weapons\falling_bomb\fall_04", 3.16228, 1, 1000};
		soundFakeFall[] = {"soundFakeFall0", 0.25, "soundFakeFall1", 0.25, "soundFakeFall2", 0.25, "soundFakeFall3", 0.25};
	};
	class MissileBase;
	class M_Titan_AT : MissileBase
	{
		class Components;
	};
	
	class Kornet_D_Ammo : M_Titan_AT 
	{
		AIAmmoUsageFlags = 64+128+256;
		
		model = "\A3\Weapons_F_Tank\Launchers\Vorona\Vorona_missile_heat_fly";
		
		submunitionAmmo = "ammo_Penetrator_Jian";
		submunitionDirectionType = "SubmunitionModelDirection";
		
		flightProfiles[] = {"Direct"};
		warheadName = "TandemHEAT";
		
		hit = 150;
		indirectHit = 70;
		indirectHitRange = 5;
		allowAgainstInfantry = 1;
		
		cost = 800;
		maxSpeed = 150;	// max speed on level road, km/h
		canlock = 2;
		airLock = 0;
		irLock = 0;
		laserLock = 1;
		
		weaponLockSystem = 4;
		trackOversteer = 0.3;
		trackLead = 0.85;
		
		manualControl = true;
		maxControlRange = 10000;	// max range for manual control, 0 = no control (passive weapon)
		triggerOnImpact = 1;
		timetolive = 1000;
		
		maneuvrability = 10;
		inittime = 0.1;
		
		missileManualControlCone	= 60;
		
		airfriction = -2e-005;
		sideairfriction = 0.14;
		thrustTime = 2.5;
		whistleDist = 4;
		
		thrust = 100;
		typicalSpeed = 115;
		
		effectsMissileInit = "";
		effectsMissile = "missile2";
		textureType = "semi";
		
		soundFly[] = {"A3\Sounds_F\weapons\Rockets\rocket_fly_2", 1, 1.0, 800};
		autoseekTarget = 1; 
		lockSeekRadius = 2000;
		class Components : Components 
		{
			class SensorsManagerComponent
			{
				class Components
				{
					class VisualSensorComponent : SensorTemplateVisual 
					{
						class AirTarget {
							minRange = 50;
							maxRange = 10000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = 1;
						};
						
						class GroundTarget {
							minRange = 50;
							maxRange = 10000;
							objectDistanceLimitCoef = 1;
							viewDistanceLimitCoef = 1;
						};
						maxTrackableSpeed = 35;
						nightRangeCoef = 0.8;
						angleRangeHorizontal = 5;
						angleRangeVertical = 5;
					};
				};
			};
		};
		class EventHandlers;	// External class reference
	};
};