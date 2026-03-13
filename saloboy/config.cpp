class CfgPatches
{
	class sam_saloboy
	{
		units[]={};
		weapons[]=
		{
			"saloboy_pistol"
		};
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"A3_Weapons_F"
		};
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
	class saloboy_pistol: Pistol_Base_F
	{
		author="Sam";
		displayName="Saloboy T50";
		scope=2;
		baseWeapon="saloboy_pistol";
		model="\saloboy\saloboy.p3d";
		picture="\saloboy\saloboy.paa";
		handAnim[]=
		{
			"OFP2_ManSkeleton"
		};
		reloadAction="GestureReloadPistol";
		recoil="recoil_gm6";
		inertia=0.1;
		aimTransitionSpeed=1.6;
		dexterity=1.9;
		maxZeroing=100;
		modes[]=
		{
			"Single"
		};
		weaponInfoType="RscWeaponZeroing";
		magazines[]=
		{
			"1x_saloboy_12mm"
		};
		reloadMagazineSound[]=
		{
			"\saloboy\saloboy_reload.wav",
			1,
			1,
			10
		};
		class Single: Mode_SemiAuto
		{
			sounds[]=
			{
				"StandardSound"
			};
			reloadTime=0.059999999;
			dispersion=0.00118;
			recoil="recoil_single_gm6";
			recoilProne="recoil_single_prone_gm6";
			minRange=5;
			minRangeProbab=0.2;
			midRange=10;
			midRangeProbab=0.30000001;
			maxRange=15;
			maxRangeProbab=0.1;
			class BaseSoundModeType
			{
				closure1[]=
				{
					"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_closure_01",
					0.22387211,
					1,
					10
				};
				closure2[]=
				{
					"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_closure_02",
					0.22387211,
					1.2,
					10
				};
				soundClosure[]=
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
						sound[]=
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_interior",
							1,
							1,
							1200
						};
						frequency=1;
						volume="interior";
					};
					class TailTrees
					{
						sound[]=
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_trees",
							1,
							1,
							1200
						};
						frequency=1;
						volume="(1-interior/1.4)*trees";
					};
					class TailForest
					{
						sound[]=
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_forest",
							1,
							1,
							1200
						};
						frequency=1;
						volume="(1-interior/1.4)*forest";
					};
					class TailMeadows
					{
						sound[]=
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_meadows",
							1,
							1,
							1200
						};
						frequency=1;
						volume="(1-interior/1.4)*(meadows/2 max sea/2)";
					};
					class TailHouses
					{
						sound[]=
						{
							"A3\Sounds_F\arsenal\weapons\LongRangeRifles\GM6_Lynx\GM6_tail_houses",
							1,
							1,
							1200
						};
						frequency=1;
						volume="(1-interior/1.4)*houses";
					};
				};
				begin1[]=
				{
					"\saloboy\saloboy_fire.wav",
					1.9810717,
					1,
					1000
				};
				begin2[]=
				{
					"\saloboy\saloboy_fire.wav",
					1.9810717,
					1,
					10000
				};
				begin3[]=
				{
					"\saloboy\saloboy_fire.wav",
					1.9810717,
					1,
					10000
				};
				soundBegin[]=
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
			mass=4;
			class CowsSlot
			{
			};
			class MuzzleSlot
			{
			};
		};
		class ItemInfo
		{
			priority=2;
		};
	};
};
class CfgMagazines
{
	class 30Rnd_9x21_Mag;
	class 1x_saloboy_12mm: 30Rnd_9x21_Mag
	{
		scope=2;
		picture="\saloboy\mag_saloboy.paa";
		model="\saloboy\mag_saloboy.p3d";
		ammo="12mm_saloboy";
		author="Sam";
		displayName="50 BMG";
		count=1;
		descriptionShort="50 BMG";
		mass=1;
	};
};
class CfgAmmo
{
	class B_127x99_Ball;
	class 12mm_saloboy: B_127x99_Ball
	{
		author="Sam";
		hit=30;
		airFriction=-0.0098000001;
		tracerScale=0.1;
		deflecting=25;
		audibleFire=120;
		aiAmmoUsageFlags=64;
		timeToLive=5;
		cartridge="\saloboy\gilse.p3d";
	};
};
class cfgMods
{
	author="Sam";
	timepacked="1705086620";
};
