class CfgWeapons
{
	class Default;
	class InventoryItem_Base_F;
	class ItemCore: Default
	{
	};
	class CBA_MiscItem_ItemInfo: InventoryItem_Base_F
	{
	};
	class CBA_MiscItem: ItemCore
	{
		class ItemInfo: CBA_MiscItem_ItemInfo
		{
		};
	};
	class fakeWeapon;
	class orlan_launcher_weap: fakeWeapon
	{
		class GunParticles
		{
			class FirstEffect
			{
				directionName="konec hlavne";
				effectName="";
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