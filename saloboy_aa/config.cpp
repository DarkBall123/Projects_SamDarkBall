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
			"sam_saloboy"
		};
		units[] = {};
		weapons[] =
		{
			"saloboy_aa_launcher"
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

	class saloboy_aa_missile: M_Titan_AA
	{
		author = "Sam";
		model = "\saloboy\mag_saloboy.p3d";
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
	};
};

class CfgMagazines
{
	class Titan_AA;

	class 1Rnd_saloboy_aa: Titan_AA
	{
		author = "Sam";
		scope = 2;
		scopeArsenal = 2;
		ammo = "saloboy_aa_missile";
		displayName = "Saloboy AA Missile";
		displayNameShort = "Saloboy AA";
		descriptionShort = "Titan AA missile logic with Saloboy projectile visuals";
		picture = "\saloboy\mag_saloboy.paa";
		model = "\saloboy\mag_saloboy.p3d";
		initSpeed = 30;
		maxLeadSpeed = 400;
	};
};

class CfgWeapons
{
	class launch_O_Titan_F;

	class saloboy_aa_launcher: launch_O_Titan_F
	{
		author = "Sam";
		scope = 2;
		scopeArsenal = 2;
		baseWeapon = "saloboy_aa_launcher";
		displayName = "Saloboy AA";
		descriptionShort = "Titan AA launcher built on the Saloboy model";
		model = "\saloboy\saloboy.p3d";
		picture = "\saloboy\saloboy.paa";
		magazines[] =
		{
			"1Rnd_saloboy_aa"
		};
		magazineWell[] = {};
		shotPos = "";
		shotEnd = "";
		drySound[] =
		{
			"",
			1,
			1,
			1
		};
		reloadMagazineSound[] =
		{
			"",
			1,
			1,
			1
		};
		lockingTargetSound[] =
		{
			"",
			1,
			1
		};
		lockedTargetSound[] =
		{
			"",
			1,
			1
		};

		class GunParticles
		{
			class FirstEffect
			{
				directionName = "konec hlavne";
				effectName = "";
				positionName = "usti hlavne";
			};
		};
	};
};
