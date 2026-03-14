class SensorTemplateIR;
class CfgPatches
{
	class sam_saloboy_aa
	{
		name = "Saloboy AA";
		author = "Sam";
		requiredVersion = 2;
		requiredAddons[] =
		{
			"A3_Weapons_F_Launchers_Titan",
			"A3_Data_F_AoW_Loadorder",
			"sam_saloboy"
		};
		units[] = {};
		weapons[] =
		{
			"saloboy_pistol_aa"
		};
	};
};

class CfgAmmo
{
	class MissileBase;
	class M_Titan_AA: MissileBase
	{
		class Components;
	};

	class saloboy_aa_bullet: M_Titan_AA
	{
		author = "Sam";
		model = "\saloboy\mag_saloboy.p3d";
		weaponType = "mGun";
		airLock = 2;
		irLock = 1;
		cmImmunity = 0.98;
		proximityExplosionDistance = 8;
		hit = 80;
		indirectHit = 40;
		indirectHitRange = 30;
		maneuvrability = 34;
		maxSpeed = 500;
		thrust = 392;
		thrustTime = 4.5;
		timeToLive = 20;
		trackLead = 0.85000002;
		trackOversteer = 0.94999999;
		sideAirFriction = 0.079999998;
		maxControlRange = 6400;
		missileLockMaxDistance = 6400;
		missileLockMinDistance = 500;
		missileLockMaxSpeed = 400;
		missileLockCone = 15;
		missileKeepLockedCone = 70;
		weaponLockSystem = "2 + 16";
		soundFly[] =
		{
			"",
			0.13095701,
			1
		};
		effectsMissile = "EmptyEffect";
		effectsMissileInit = "";
		effectsSmoke = "";
		muzzleEffect = "";

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
							minRange = 500;
							maxRange = 6400;
						};

						class GroundTarget
						{
							minRange = 500;
							maxRange = 1000;
						};

						angleRangeHorizontal = 45;
						angleRangeVertical = 45;
						minTrackableSpeed = 0;
						maxTrackableSpeed = 400;
						minTrackableATL = 10;
						maxTrackableATL = 4500;
					};
				};
			};
		};
	};
};

class CfgMagazines
{
	class 1x_saloboy_12mm;

	class 1x_saloboy_12mm_aa: 1x_saloboy_12mm
	{
		author = "Sam";
		scope = 2;
		scopeArsenal = 2;
		ammo = "saloboy_aa_bullet";
		displayName = "50 BMG AA";
		descriptionShort = "Guided anti-air round for Saloboy";
		initSpeed = 30;
		maxLeadSpeed = 400;
	};
};

class CfgWeapons
{
	class saloboy_pistol;

	class saloboy_pistol_aa: saloboy_pistol
	{
		author = "Sam";
		scope = 2;
		scopeArsenal = 2;
		scopeCurator = 2;
		baseWeapon = "saloboy_pistol_aa";
		displayName = "Saloboy T50 AA";
		descriptionShort = "Saloboy pistol with guided anti-air round";
		type = 2;
		magazines[] =
		{
			"1x_saloboy_12mm_aa"
		};
		magazineWell[] = {};
		canLock = 2;
		lockAcquire = 1;
		weaponLockDelay = 5.4000001;
		weaponLockSystem = 2;
		aiRateOfFire = 7;
		aiRateOfFireDistance = 3500;
		minRange = 500;
		minRangeProbab = 0.80000001;
		midRange = 3000;
		midRangeProbab = 0.94999999;
		maxRange = 6400;
		maxRangeProbab = 0.94999999;
	};
};
