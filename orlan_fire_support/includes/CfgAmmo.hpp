class CfgAmmo
{
	class R_PG32V_F;
	class OrlanFS_Ammo : R_PG32V_F
	{
		displayName = "Krasnopol_M";
		timeToLive = 500;
		model = "\A3\weapons_f\ammo\shell";
		CraterEffects = "ArtyShellCrater";
		ExplosionEffects = "MortarExplosion";
		access = 3;
		aiAmmoUsageFlags = "128 + 512";
		airFriction = 0.075;
		airLock = 0;
		allowAgainstInfantry = 0;
		animated = 0;
		artilleryCharge = 1;
		artilleryDispersion = 1;
		artilleryLock = 0;
		audibleFire = 32;
		autoSeekTarget = 0;
		caliber = 1;
		cartridge = "";
		cmImmunity = 1;
		cost = 100;
		craterShape = "";
		CraterWaterEffects = "ImpactEffectsWaterHE";
		dangerRadiusBulletClose = -1;
		dangerRadiusHit = 750;
		deflecting = 5;
		deflectionSlowDown = 0.8;
		deleteParentWhenTriggered = 0;
		directionalExplosion = 0;
		effectFlare = "FlareShell";
		effectFly = "";
		effectsFire = "CannonFire";
		effectsMissile = "EmptyEffect";
		effectsMissileInit = "";
		effectsSmoke = "SmokeShellWhite";
		explosionAngle = 60;
		explosionDir = "explosionDir";
		explosionEffectsDir = "explosionDir";
		explosionForceCoef = 1;
		explosionPos = "explosionPos";
		explosionSoundEffect = "DefaultExplosion";
		explosionTime = 0;
		explosionType = "explosive";
		explosive = 1;
		fuseDistance = 10;
		grenadeBurningSound[] = {};
		grenadeFireSound[] = {};
		hit = 2500;
		indirectHit = 2200;
		indirectHitRange = 20;
		hitArmor[] = {"soundHit",1};
		hitBuilding[] = {"soundHit",1};
		hitConcrete[] = {"soundHit",1};
		hitDefault[] = {"soundHit",1};
		hitFoliage[] = {"soundHit",1};
		hitGlass[] = {"soundHit",1};
		hitGlassArmored[] = {"soundHit",1};
		hitGroundHard[] = {"soundHit",1};
		hitGroundSoft[] = {"soundHit",1};
		hitIron[] = {"soundHit",1};
		hitMan[] = {"soundHit",1};
		hitMetal[] = {"soundHit",1};
		hitMetalplate[] = {"soundHit",1};
		hitOnWater = 0;
		hitPlastic[] = {"soundHit",1};
		hitRubber[] = {"soundHit",1};
		hitTyre[] = {"soundHit",1};
		hitWater[] = {"soundHit",1};
		hitWood[] = {"soundHit",1};
		icon = "";
		impactArmor[] = {"soundImpact",1};
		impactBuilding[] = {"soundImpact",1};
		impactConcrete[] = {"soundImpact",1};
		impactDefault[] = {"soundImpact",1};
		impactFoliage[] = {"soundImpact",1};
		impactGlass[] = {"soundImpact",1};
		impactGlassArmored[] = {"soundImpact",1};
		impactGroundHard[] = {"soundImpact",1};
		impactGroundSoft[] = {"soundImpact",1};
		impactIron[] = {"soundImpact",1};
		impactMan[] = {"soundImpact",1};
		impactMetal[] = {"soundImpact",1};
		impactMetalplate[] = {"soundImpact",1};
		impactPlastic[] = {"soundImpact",1};
		impactRubber[] = {"soundImpact",1};
		impactTyre[] = {"soundImpact",1};
		impactWater[] = {"soundImpact",1};
		impactWood[] = {"soundImpact",1};
		initTime = 0;
		irLock = 0;
		isCraterOriented = 0;
		laserLock = 0;
		lockSeekRadius = 100;
		lockType = 0;
		maneuvrability = 0;
		manualControl = 0;
		maverickweaponIndexOffset = 0;
		maxControlRange = 0;
		maxSpeed = 140;
		minDamageForCamShakeHit = 0.55;
		mineBoundingDist = 3;
		mineBoundingTime = 3;
		mineDiveSpeed = 1;
		mineFloating = -1;
		mineInconspicuousness = 10;
		mineJumpEffects = "";
		minePlaceDist = 0.5;
		mineTrigger = "RangeTrigger";
		minimumSafeZone = 0.1;
		minTimeToLive = 0;
		missileLockCone = 0;
		multiSoundHit[] = {"soundHit1",0.25,"soundHit2",0.25,"soundHit3",0.25,"soundHit4",0.25};
		muzzleEffect = "";
		nvLock = 0;
		proxyShape = "";
		shadow = 0;
		shootDistraction = -1;
		sideAirFriction = 0.075;
		simulation = "shotRocket";
		simulationStep = 0.02;
		soundActivation[] = {};
		soundDeactivation[] = {};
		soundEngine[] = {"",1,1};
		soundFakeFall[] = {"soundFakeFall0",0.25,"soundFakeFall1",0.25,"soundFakeFall2",0.25,"soundFakeFall3",0.25};
		soundFakeFall0[] = {"a3\Sounds_F\weapons\falling_bomb\fall_01",3.16228,1,1000};
		soundFakeFall1[] = {"a3\Sounds_F\weapons\falling_bomb\fall_02",3.16228,1,1000};
		soundFakeFall2[] = {"a3\Sounds_F\weapons\falling_bomb\fall_03",3.16228,1,1000};
		soundFakeFall3[] = {"a3\Sounds_F\weapons\falling_bomb\fall_04",3.16228,1,1000};
		soundFall[] = {"",1,1};
		soundFly[] = {"",0.0316228,4};
		soundHit[] = {"",316.228,1};
		soundHit1[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_01",2.51189,1,1900};
		soundHit2[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_02",2.51189,1,1900};
		soundHit3[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_03",2.51189,1,1900};
		soundHit4[] = {"A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_04",2.51189,1,1900};
		soundImpact[] = {"",1,1};
		SoundSetExplosion[] = {"Shell155mm_Exp_SoundSet","Shell155mm_Tail_SoundSet","Explosion_Debris_SoundSet"};
		soundSetSonicCrack[] = {"bulletSonicCrack_SoundSet","bulletSonicCrackTail_SoundSet"};
		soundTrigger[] = {};
		submunitionAmmo = "";
		supersonicCrackFar[] = {"A3\Sounds_F\weapons\Explosion\supersonic_crack_50meters",0.223872,1,150};
		supersonicCrackNear[] = {"A3\Sounds_F\weapons\Explosion\supersonic_crack_close",0.316228,1,50};
		suppressionRadiusBulletClose = -1;
		suppressionRadiusHit = 75;
		thrust = 500;
		thrustTime = 0.1;
		tracerColor[] = {0.7,0.7,0.5,0.04};
		tracerColorR[] = {0.7,0.7,0.5,0.04};
		trackLead = 1;
		trackOversteer = 1;
		triggerOnImpact = 1;
		typicalSpeed = 900;
		underwaterHitRangeCoef = 1;
		visibleFire = 32;
		visibleFireTime = 20;
		warheadName = "TandemHEAT";
		waterEffectOffset = 0.45;
		weaponLockSystem = 0;
		weaponType = "Default";
		whistleDist = 0;
		whistleOnFire = 0;
	};	
};