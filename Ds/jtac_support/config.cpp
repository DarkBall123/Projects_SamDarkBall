class CfgPatches
{
    class Jtac_Addon
    {
        author="DarkBall/Sem";
        requiredVersion=1.6;
        requiredAddons[]=
        {
            "A3_Data_F_AoW_Loadorder",
            "cba_main"          // ← добавлено
        };
        units[]={};
        weapons[]=
        {
            "UMPK_launcher"
        };
    };
};
	class CfgAmmo {
    class BombCore;
    class ammo_Bomb_SDB: BombCore {
        class Components;
    };

    class UMPK250: ammo_Bomb_SDB {
        model="\jtac_support\umpk250\250.p3d";
        soundHit1[]= { "A3\Sounds_F\weapons\Explosion\expl_big_1", 2.5118864, 1, 2400 };
        soundHit2[]= { "A3\Sounds_F\weapons\Explosion\expl_big_2", 2.5118864, 1, 2400 };
        soundHit3[]= { "A3\Sounds_F\weapons\Explosion\expl_big_3", 2.5118864, 1, 2400 };
        soundHit4[]= { "A3\Sounds_F\weapons\Explosion\expl_shell_1", 2.5118864, 1, 2400 };
        soundHit5[]= { "A3\Sounds_F\weapons\Explosion\expl_shell_2", 2.5118864, 1, 2400 };
        multiSoundHit[]= { "soundHit1", 0.2, "soundHit2", 0.2, "soundHit3", 0.2, "soundHit4", 0.2, "soundHit5", 0.2 };
        warheadName="HE";
        hit=920;                    // Прямое попадание (FAB-250 ~100 кг ВВ)
        indirectHit=460;
        indirectHitRange=38;        // Lethal ~10-15 м, wounding ~40 м, опасно до ~100-120 м
        dangerRadiusHit=850;
        explosionDir="explosionDir";
        explosionEffects="HeavyBombExplosion";
        explosionEffectsDir="explosionDir";
        explosionForceCoef=1;
        explosionPos="explosionPos";
        explosionSoundEffect="DefaultExplosion";
        explosionType="explosive";
        explosive=0.80000001;
        cost=1200;
        craterEffects="HeavyBombCrater";
        craterShape="";
        craterWaterEffects="ImpactEffectsWater";
        trackOversteer=1;
        trackLead=0.94999999;
        maneuvrability=20;
        explosionTime=0;
        fuseDistance=100;
        whistleDist=500;
        class CamShakeExplode { power=46; duration=3; frequency=20; distance=361.32599; };
        class CamShakeHit { power=230; duration=0.80000001; frequency=20; distance=1; };
        class CamShakeFire { power=3.89432; duration=3; frequency=20; distance=121.326; };
        class CamShakePlayerFire { power=5; duration=0.1; frequency=20; distance=1; };
    };

    class UMPK500: UMPK250 {
        model="\jtac_support\umpk500\500.p3d";
        hit=1950;                   // FAB-500 (~150-200 кг ВВ)
        indirectHit=980;
        indirectHitRange=58;        // Damage radius ~250 м по открытым целям (ISW и др.)
        dangerRadiusHit=1250;
    };

    class UMPK1500: UMPK500 {
        model="\jtac_support\umpk1500\1500.p3d";
        hit=4500;                   // FAB-1500 (~670 кг ВВ)
        indirectHit=2250;
        indirectHitRange=95;        // Тяжёлое поражение ~70 м, среднее ~140-150 м, опасно до ~400-500 м
        dangerRadiusHit=1600;
    };

    class UMPK9000: UMPK1500 {
        model="\jtac_support\umpk9000\9000.p3d";
        hit=9200;                   // Аналог FAB-3000/FAB-9000 (очень крупный, 1200+ кг ВВ)
        indirectHit=5100;
        indirectHitRange=195;       // Blast radius может достигать сотен метров
        dangerRadiusHit=2800;
    };

    class Bo_GBU12_LGB;
    class GBU32: Bo_GBU12_LGB {     // Аналог GBU-12 / Mk82 (~87 кг ВВ)
        hit=680;
        indirectHit=340;
        indirectHitRange=30;        // Небольшой blast radius precision-бомбы
        dangerRadiusHit=650;
    };

    class GBU54: Bo_GBU12_LGB {     // Чуть мощнее (Laser JDAM 500 lb класс)
        hit=1250;
        indirectHit=620;
        indirectHitRange=47;
        dangerRadiusHit=950;
    };

    class MOAB: Bo_GBU12_LGB {      // GBU-43 (~8,4 тонны ВВ)
        hit=13500;
        indirectHit=7200;
        indirectHitRange=380;       // Blast radius до ~1 мили (~1600 м) по эффекту, lethal ближе
        dangerRadiusHit=3200;
    };

    class ammo_Missile_Cruise_01;
    class KINJAL: ammo_Missile_Cruise_01 {
        thrust=350;
        maxSpeed=3333;
        maneuvrability=16;
        hit=4100;                   // Kinzhal (~480-700 кг ВВ)
        indirectHit=2050;
        indirectHitRange=78;
        dangerRadiusHit=1450;
    };

    class X101: ammo_Missile_Cruise_01 {
        hit=3350;                   // Kh-101 (~400-450 кг ВВ)
        indirectHit=1680;
        indirectHitRange=72;
        dangerRadiusHit=1350;
    };

    class R_230mm_fly;
    class TORNADOS: R_230mm_fly {
        hit=680;
        indirectHit=295;
        indirectHitRange=34;
        dangerRadiusHit=750;
        model="\A3\Weapons_F\Ammo\Rocket_230mm_Fly_F";
        warheadName="HE";
        audibleFire=64;
        suppressionRadiusHit=120;
        deflecting=0;
        airFriction=0;
        muzzleEffect="";
        effectFly="ArtilleryTrails";
        explosionDir="explosionDir";
        explosionEffects="HeavyBombExplosion";
        explosionEffectsDir="explosionDir";
        explosionForceCoef=1;
        explosionPos="explosionPos";
        explosionSoundEffect="DefaultExplosion";
        explosionType="explosive";
        explosive=0.80000001;
        craterEffects="HeavyBombCrater";
        craterShape="";
        craterWaterEffects="ImpactEffectsWater";
        trackOversteer=1;
        trackLead=0.94999999;
        maneuvrability=20;
        explosionTime=0;
        fuseDistance=100;
        class CamShakeExplode { power=46; duration=3; frequency=20; distance=361.32599; };
        class CamShakeHit { power=230; duration=0.80000001; frequency=20; distance=1; };
        class CamShakeFire { power=3.89432; duration=3; frequency=20; distance=121.326; };
        class CamShakePlayerFire { power=5; duration=0.1; frequency=20; distance=1; };
        soundHit1[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_01", 2.5118864, 1, 1900 };
        soundHit2[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_02", 2.5118864, 1, 1900 };
        soundHit3[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_03", 2.5118864, 1, 1900 };
        multiSoundHit[]= { "soundHit1", 0.34, "soundHit2", 0.33000001, "soundHit3", 0.33000001 };
    };

    class TORNADOG: R_230mm_fly {
        hit=440;
        indirectHit=190;
        indirectHitRange=24;
        dangerRadiusHit=580;
        model="\A3\Weapons_F\Ammo\Rocket_230mm_Fly_F";
        warheadName="HE";
        audibleFire=64;
        suppressionRadiusHit=120;
        deflecting=0;
        airFriction=0;
        muzzleEffect="";
        effectFly="ArtilleryTrails";
        explosionDir="explosionDir";
        explosionEffects="HeavyBombExplosion";
        explosionEffectsDir="explosionDir";
        explosionForceCoef=1;
        explosionPos="explosionPos";
        explosionSoundEffect="DefaultExplosion";
        explosionType="explosive";
        explosive=0.80000001;
        craterEffects="HeavyBombCrater";
        craterShape="";
        craterWaterEffects="ImpactEffectsWater";
        trackOversteer=1;
        trackLead=0.94999999;
        maneuvrability=20;
        explosionTime=0;
        fuseDistance=100;
        class CamShakeExplode { power=46; duration=3; frequency=20; distance=361.32599; };
        class CamShakeHit { power=230; duration=0.80000001; frequency=20; distance=1; };
        class CamShakeFire { power=3.89432; duration=3; frequency=20; distance=121.326; };
        class CamShakePlayerFire { power=5; duration=0.1; frequency=20; distance=1; };
        soundHit1[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_01", 2.5118864, 1, 1900 };
        soundHit2[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_02", 2.5118864, 1, 1900 };
        soundHit3[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_03", 2.5118864, 1, 1900 };
        multiSoundHit[]= { "soundHit1", 0.34, "soundHit2", 0.33000001, "soundHit3", 0.33000001 };
    };

    class ISKANDERK: R_230mm_fly {
        hit=4350;                   // Iskander (~480-700 кг ВВ)
        indirectHit=2180;
        indirectHitRange=88;
        dangerRadiusHit=1550;
        model="\A3\Weapons_F\Ammo\Rocket_230mm_Fly_F";
        warheadName="HE";
        audibleFire=64;
        suppressionRadiusHit=120;
        deflecting=0;
        airFriction=0;
        muzzleEffect="";
        effectFly="ArtilleryTrails";
        explosionDir="explosionDir";
        explosionEffects="HeavyBombExplosion";
        explosionEffectsDir="explosionDir";
        explosionForceCoef=1;
        explosionPos="explosionPos";
        explosionSoundEffect="DefaultExplosion";
        explosionType="explosive";
        explosive=0.80000001;
        craterEffects="HeavyBombCrater";
        craterShape="";
        craterWaterEffects="ImpactEffectsWater";
        trackOversteer=1;
        trackLead=0.94999999;
        maneuvrability=20;
        explosionTime=0;
        fuseDistance=100;
        class CamShakeExplode { power=46; duration=3; frequency=20; distance=361.32599; };
        class CamShakeHit { power=230; duration=0.80000001; frequency=20; distance=1; };
        class CamShakeFire { power=3.89432; duration=3; frequency=20; distance=121.326; };
        class CamShakePlayerFire { power=5; duration=0.1; frequency=20; distance=1; };
        soundHit1[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_01", 2.5118864, 1, 1900 };
        soundHit2[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_02", 2.5118864, 1, 1900 };
        soundHit3[]= { "A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_03", 2.5118864, 1, 1900 };
        multiSoundHit[]= { "soundHit1", 0.34, "soundHit2", 0.33000001, "soundHit3", 0.33000001 };
    };
};
class cfgMagazines
{
	class VehicleMagazine;
	class magazine_Bomb_SDB_x1;
	class UMPK250_mag: magazine_Bomb_SDB_x1
	{
		ammo="UMPK250";
		model="\jtac_support\umpk250\250.p3d";
		displayname="UMPK250";
		displayNameShort="UMPK250";
		picture="\verba\ui\MAG.paa";
		descriptionShort="<br/>111111<br/>";
	};
	class UMPK500_mag: magazine_Bomb_SDB_x1
	{
		ammo="UMPK500";
		model="\jtac_support\umpk500\500.p3d";
		displayname="UMPK500";
		displayNameShort="UMPK500";
		picture="\verba\ui\MAG.paa";
		descriptionShort="<br/>111111<br/>";
	};
	class UMPK1500_mag: magazine_Bomb_SDB_x1
	{
		ammo="UMPK1500";
		model="\jtac_support\umpk1500\500.p3d";
		displayname="UMPK1500";
		displayNameShort="UMPK1500";
		picture="\verba\ui\MAG.paa";
		descriptionShort="<br/>111111<br/>";
	};
	class UMPK9000_mag: magazine_Bomb_SDB_x1
	{
		ammo="UMPK1500";
		model="\jtac_support\umpk9000\500.p3d";
		displayname="UMPK9000";
		displayNameShort="UMPK9000";
		picture="\verba\ui\MAG.paa";
		descriptionShort="<br/>111111<br/>";
	};
};
class CfgWeapons
{
	class Default;
	class weapon_SDBLauncher;
	class UMPK_launcher: weapon_SDBLauncher
	{
		displayName="$STR_A3_Bomb_SDB_weapon_name";
		weaponLockDelay=0.1;
		weaponLockSystem="2 + 4";
		cmImmunity=0.30000001;
		minRange=300;
		minRangeProbab=0.40000001;
		midRange=1000;
		midRangeProbab=0.94999999;
		maxRange=8000;
		maxRangeProbab=0.89999998;
		magazines[]=
		{
			"UMPK250_mag",
			"UMPK500_mag",
			"UMPK1500_mag",
			"UMPK5000_mag"
		};
		reloadTime=0.1;
		autoFire=0;
		magazineReloadTime=0.1;
		aiRateOfFire=5;
		aiRateOfFireDistance=500;
		nameSound="";
		cursor="EmptyCursor";
		cursorAim="bomb";
		showAimCursorInternal=0;
		ballisticsComputer=8;
		textureType="semi";
		lockedTargetSound[]=
		{
			"\A3\Sounds_F\weapons\Rockets\locked_3",
			0.56234133,
			2.5
		};
		lockingTargetSound[]=
		{
			"\A3\Sounds_F\weapons\Rockets\locked_1",
			0.56234133,
			1
		};
	};
	class ItemCore;
	class Laserdesignator;
	class JTAC_L: Laserdesignator
	{
		displayName="JTAC Laserdesignator";
		scope=2;
	};
};
class CfgNotifications
{
	class JtacReloadNotification
	{
		title="JTAC";
		iconPicture="a3\ui_f\data\gui\cfg\communicationmenu\call_ca.paa";
		iconText="1";
		description="%1";
		color[]={0.153,0.93300003,0.122,1};
		duration=5;
		priority=0;
		difficulty[]={};
	};
};
class CfgVehicles
{
	class Item_Laserdesignator_03;
	class Item_JTAC_L: Item_Laserdesignator_03
	{
		displayName="JTAC Laserdesignator";
		scope=2;
		class TransportItems
		{
			class JTAC_L
			{
				count=1;
				name="JTAC_L";
			};
		};
	};
};
class RscButton;
class JTAC_ModeButton: RscButton
{
	colorText[] = {0.7,0.7,0.7,1};
	colorDisabled[] = {1,1,1,1};
	colorBackground[] = {0.2,0.2,0.2,0.9};
	colorBackgroundDisabled[] = {0.2,0.2,0.2,0.9};
	colorBackgroundActive[] = {0.2,0.2,0.2,0.9};
	colorFocused[] = {0.2,0.2,0.2,0.9};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	shadow = 0;
	borderSize = 0;
	style = 2;
	font = "PuristaBold";
	soundEnter[] = {"",0,1};
	soundPush[] = {"",0,1};
	soundClick[] = {"",0,1};
	soundEscape[] = {"",0,1};
};
class CfgFunctions
{
	class DB
	{
		class JTAC
		{
			file="\jtac_support";
			class jtacInit
			{
				postInit=1;
			};
		};
	};
};
class cfgMods
{
	author="Sam";
	timepacked="1697401286";
};
