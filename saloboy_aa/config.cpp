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
		weaponType = "Default";
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

class Mode_SemiAuto;
class MuzzleSlot;
class CfgWeapons
{
	class Pistol;
	class Pistol_Base_F: Pistol
	{
		class WeaponSlotsInfo;
	};

	class saloboy_pistol_aa: Pistol_Base_F
	{
		author = "Sam";
		scope = 2;
		scopeArsenal = 2;
		scopeCurator = 2;
		baseWeapon = "saloboy_pistol_aa";
		displayName = "Saloboy T50 AA";
		descriptionShort = "Saloboy pistol with guided anti-air round";
		model = "\saloboy\saloboy.p3d";
		picture = "\saloboy\saloboy.paa";
		handAnim[] =
		{
			"OFP2_ManSkeleton"
		};
		reloadAction = "GestureReloadPistol";
		recoil = "recoil_gm6";
		inertia = 0.1;
		aimTransitionSpeed = 1.6;
		dexterity = 1.9;
		maxZeroing = 100;
		modes[] =
		{
			"Single"
		};
		weaponInfoType = "RscWeaponZeroing";
		magazines[] =
		{
			"1x_saloboy_12mm_aa"
		};
		magazineWell[] = {};
		canLock = 2;
		lockAcquire = 1;
		weaponLockSystem = 2;
		reloadMagazineSound[] =
		{
			"\saloboy\saloboy_reload.wav",
			1,
			1,
			10
		};

		class Single: Mode_SemiAuto
		{
			sounds[] =
			{
				"StandardSound"
			};
			reloadTime = 0.059999999;
			dispersion = 0.00118;
			recoil = "recoil_single_gm6";
			recoilProne = "recoil_single_prone_gm6";
			minRange = 500;
			minRangeProbab = 0.8;
			midRange = 3000;
			midRangeProbab = 0.95;
			maxRange = 6400;
			maxRangeProbab = 0.95;

			class BaseSoundModeType
			{
				closure1[] =
				{
					"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_closure_01",
					0.22387211,
					1,
					10
				};
				closure2[] =
				{
					"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_closure_02",
					0.22387211,
					1.2,
					10
				};
				soundClosure[] =
				{
					"closure1",
					0.5,
					"closure2",
					0.5
				};
			};

			class StandardSound: BaseSoundModeType
			{
				class SoundTails
				{
					class TailInterior
					{
						sound[] =
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_interior",
							1,
							1,
							1200
						};
						frequency = 1;
						volume = "interior";
					};
					class TailTrees
					{
						sound[] =
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_trees",
							1,
							1,
							1200
						};
						frequency = 1;
						volume = "(1-interior/1.4)*trees";
					};
					class TailForest
					{
						sound[] =
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_forest",
							1,
							1,
							1200
						};
						frequency = 1;
						volume = "(1-interior/1.4)*forest";
					};
					class TailMeadows
					{
						sound[] =
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_meadows",
							1,
							1,
							1200
						};
						frequency = 1;
						volume = "(1-interior/1.4)*(meadows/2 max sea/2)";
					};
					class TailHouses
					{
						sound[] =
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_houses",
							1,
							1,
							1200
						};
						frequency = 1;
						volume = "(1-interior/1.4)*houses";
					};
				};
				begin1[] =
				{
					"\saloboy\saloboy_fire.wav",
					1.9810717,
					1,
					1000
				};
				begin2[] =
				{
					"\saloboy\saloboy_fire.wav",
					1.9810717,
					1,
					10000
				};
				begin3[] =
				{
					"\saloboy\saloboy_fire.wav",
					1.9810717,
					1,
					10000
				};
				soundBegin[] =
				{
					"begin1",
					0.33000001,
					"begin2",
					0.33000001,
					"begin3",
					0.34
				};
			};
		};

		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			mass = 4;

			class CowsSlot
			{
			};

			class MuzzleSlot
			{
			};
		};

		class ItemInfo
		{
			priority = 2;
		};
	};
};
