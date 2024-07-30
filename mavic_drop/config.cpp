
class cfgPatches
{
	class DB_D37_scripts_mavick_vogs
	{
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"A3_Drones_F_Air_F_Gamma_UAV_01",
			"A3_Weapons_F_Explosives"
		};
	};
};

class CfgAmmo
{
	class Default;
	class Grenade: Default
	{
	};
	class GrenadeHand: Grenade
	{
	};
	class mini_Grenade;
	class GrenadeBase;
	class R_PG32V_F;
	class G_40mm_HE: GrenadeBase
	{
		timeToLive=1e+010;
	};
	class mavick_Impact_25: GrenadeHand
	{
		model="\mavic_drop\vog25.p3d";
		hit = 5;
        indirectHit = 5;
        indirectHitRange = 5;
		dangerRadiusHit=-1;
		suppressionRadiusHit=-1;
		typicalspeed=22;
		cost=1;
		simulation="shotGrenade";
		explosive=1;
		explosionType="explosive";
		deflecting=30;
		explosionTime=-1;
		timeToLive=1e+010;
		fuseDistance=0;
		soundHit[]=
		{
			"",
			0,
			1
		};
		whistleDist=0;
		weaponType="Default";
		caliber=1;
		access=3;
		mavic_weight = 275;
	};
	class mavick_Impact_f1: GrenadeHand
	{
		model="\mavic_drop\f1.p3d";
		hit=8;
		indirectHit=8;
		indirectHitRange=6;
		dangerRadiusHit=-1;
		suppressionRadiusHit=-1;
		typicalspeed=22;
		cost=1;
		simulation="shotGrenade";
		explosive=1;
		explosionType="explosive";
		deflecting=30;
		explosionTime=-1;
		timeToLive=1e+010;
		fuseDistance=0;
		soundHit[]=
		{
			"",
			0,
			1
		};
		whistleDist=0;
		weaponType="Default";
		caliber=1;
		access=3;
		mavic_weight = 600;
	};
	class mavick_Impact_tbg: GrenadeHand
	{
		model="\mavic_drop\tbg.p3d";
		hit = 6;
        indirectHit = 12;
        indirectHitRange = 8;
		dangerRadiusHit=-1;
		suppressionRadiusHit=-1;
		typicalspeed=22;
		cost=1;
		simulation="shotGrenade";
		explosive=1;
		explosionType="explosive";
		deflecting=30;
		explosionTime=-1;
		timeToLive=1e+010;
		fuseDistance=0;
		soundHit[]=
		{
			"",
			0,
			1
		};
		whistleDist=0;
		weaponType="Default";
		caliber=1;
		access=3;
		mavic_weight = 300;
	};
	class mavick_HE_Impact_M67: GrenadeHand
	{
		model="\A3\Weapons_f\ammo\Handgrenade_throw";
		hit=8;
		indirectHit=8;
		indirectHitRange=6;
		dangerRadiusHit=-1;
		suppressionRadiusHit=-1;
		typicalspeed=22;
		cost=1;
		simulation="shotGrenade";
		explosive=1;
		explosionType="explosive";
		deflecting=30;
		explosionTime=-1;
		timeToLive=1e+010;
		fuseDistance=0;
		soundHit[]=
		{
			"",
			0,
			1
		};
		whistleDist=0;
		weaponType="Default";
		caliber=1;
		access=3;
		mavic_weight = 400;
	};
	class mavick_HE_Impact_V40: mini_Grenade
	{
		model="\A3\Weapons_f\ammo\mini_frag_throw";
		hit=8;
		indirectHit=8;
		indirectHitRange=6;
		dangerRadiusHit=-1;
		suppressionRadiusHit=-1;
		typicalspeed=22;
		cost=1;
		simulation="shotGrenade";
		explosive=1;
		explosionType="explosive";
		deflecting=30;
		explosionTime=-1;
		timeToLive=1e+010;
		fuseDistance=0;
		whistleDist=0;
		weaponType="Default";
		caliber=1;
		access=3;
		mavic_weight = 310;
	};
	class mavick_Impact_M433: GrenadeHand
    {
        model="\mavic_drop\m433.p3d";
        timeToLive=1e+010;
        
        explosionTime = -1;
        hit = 5;
        indirectHit = 5;
        indirectHitRange = 1;
        
        //ace_frag_enable = 1;
        //ace_frag_metal = 420;
        //ace_frag_charge = 70;
        
        fuseDistance = 2;
        
        warheadName="HEAT";
        submunitionAmmo="mavick_Impact_M433_Penetrator";
        submunitionDirectionType="SubmunitionModelDirection";
        submunitionInitSpeed=1053;
        submunitionParentSpeedCoef=0;
        submunitionInitialOffset[]={0,0,-0.1};
        triggerOnImpact=1;
        deleteParentWhenTriggered=0;
        mavic_weight = 230;
    };
    class ammo_Penetrator_Base;
    class mavick_Impact_M433_Penetrator: ammo_Penetrator_Base
    {
            caliber=11.3333;
            hit=160;
    };	
};
class cfgMagazines
{
	class Default;
	class CA_Magazine: Default
	{
	};
	class HandGrenade: CA_Magazine
	{
	};
	class Mavic_Vog25: HandGrenade
	{
		author="sam";
		displayName="VOG25 impact";
		picture="\mavic_drop\pictures\vog25.paa";
		model="\mavic_drop\vog25.p3d";
		value=2;
		ammo="mavick_Impact_25";
		nameSound="handgrenade";
		descriptionShort="Vog-25";
		displayNameShort="Vog-25";
		mass=8;
		initSpeed=18;
		type=256;
		maxThrowHoldTime=2;
		maxThrowIntensityCoef=1.4;
		minThrowIntensityCoef=0.30000001;
		scope=2;
		mavic_weight = 275;
	};
	class Mavic_F1: HandGrenade
	{
		author="sam";
		displayName="F1 impact";
		picture="\mavic_drop\pictures\f1.paa";
		model="\mavic_drop\f1.p3d";
		value=2;
		ammo="mavick_Impact_f1";
		nameSound="handgrenade";
		descriptionShort="F1";
		displayNameShort="F1";
		mass=8;
		initSpeed=18;
		type=256;
		maxThrowHoldTime=2;
		maxThrowIntensityCoef=1.4;
		minThrowIntensityCoef=0.30000001;
		scope=2;
		mavic_weight = 600;
	};
	class Mavic_tbg: HandGrenade
	{
		author="sam";
		displayName="VG40TB impact";
		picture="\mavic_drop\pictures\tbg.paa";
		model="\mavic_drop\tbg.p3d";
		value=2;
		ammo="mavick_Impact_tbg";
		nameSound="handgrenade";
		descriptionShort="Thermobaric";
		displayNameShort="Thermobaric";
		mass=8;
		initSpeed=18;
		type=256;
		maxThrowHoldTime=2;
		maxThrowIntensityCoef=1.4;
		minThrowIntensityCoef=0.30000001;
		scope=2;
		mavic_weight = 300;
	};
	class mavick_M67_Impact_Grenade: HandGrenade
	{
		author="Wenza";
		displayName="RGO impact";
		picture="\A3\Weapons_F\Data\UI\gear_M67_CA.paa";
		model="\A3\Weapons_f\ammo\Handgrenade";
		value=2;
		ammo="mavick_HE_Impact_M67";
		nameSound="handgrenade";
		descriptionShort="M67 Impact";
		displayNameShort="M67 Impact";
		mass=8;
		initSpeed=18;
		type=256;
		maxThrowHoldTime=2;
		maxThrowIntensityCoef=1.4;
		minThrowIntensityCoef=0.30000001;
		scope=2;
		mavic_weight = 400;
	};
	class mavick_V40_Impact_Grenade: HandGrenade
	{
		author="Wenza";
		displayName="RGN impact";
		picture="\A3\Weapons_F\Data\UI\gear_M67_CA.paa";
		model="\A3\Weapons_f\ammo\mini_frag";
		value=2;
		ammo="mavick_HE_Impact_V40";
		nameSound="handgrenade";
		descriptionShort="V40 Impact";
		displayNameShort="V40 Impact";
		mass=4;
		initSpeed=26;
		type=256;
		maxThrowHoldTime=2;
		maxThrowIntensityCoef=1.4;
		minThrowIntensityCoef=0.30000001;
		scope=2;
		mavic_weight = 310;
	};
	class Mavic_M433: HandGrenade
	{
		author="sam";
		displayName="M433 Impact";
		picture="\mavic_drop\pictures\m433.paa";
		model="\mavic_drop\m433.p3d";
		value=2;
		ammo="mavick_Impact_M433";
		nameSound="handgrenade";
		descriptionShort="M433";
		displayNameShort="M433";
		mass=8;
		initSpeed=18;
		type=256;
		maxThrowHoldTime=2;
		maxThrowIntensityCoef=1.4;
		minThrowIntensityCoef=0.30000001;
		scope=2;
		mavic_weight = 230;
	};
	
};
class CfgWeapons
{
	class Default;
	class GrenadeLauncher: Default
	{
	};
	class Throw: GrenadeLauncher
	{
		muzzles[]+=
		{
			"mavick_Impact_muzzle",
			"mavick_M67_Impact_Muzzle",
			"mavick_V40_Impact_Muzzle",
			"f1_Impact_muzzle",
			"tbg_Impact_muzzle",
			"mavick_M433_Impact_Muzzle"
		};
		class ThrowMuzzle: GrenadeLauncher
		{
			aidispersioncoefx=6;
			aidispersioncoefy=6;
			autoreload=1;
			cursor="EmptyCursor";
			cursoraim="throw";
			enableattack=1;
			keepininventory=1;
			magazinereloadtime=0;
			maxrange=60;
			maxrangeprobab=0.029999999;
			midrange=45;
			midrangeprobab=0.89999998;
			minrange=10;
			minrangeprobab=0.2;
			modeloptics="";
			reloadsound[]=
			{
				"",
				0.00031622799,
				1
			};
			reloadtime=0;
			showempty=0;
			sound[]=
			{
				"",
				0.00031622799,
				1
			};
		};
		class mavick_Impact_muzzle: ThrowMuzzle
		{
			magazines[]=
			{
				"Mavic_Vog25"
			};
		};
		class f1_Impact_muzzle: ThrowMuzzle
		{
			magazines[]=
			{
				"Mavic_F1"
			};
		};
		class tbg_Impact_muzzle: ThrowMuzzle
		{
			magazines[]=
			{
				"Mavic_tbg"
			};
		};
		class mavick_M67_Impact_Muzzle: ThrowMuzzle
		{
			magazines[]=
			{
				"mavick_M67_Impact_Grenade"
			};
		};
		class mavick_V40_Impact_Muzzle: ThrowMuzzle
		{
			magazines[]=
			{
				"mavick_V40_Impact_Grenade"
			};
		};
		class mavick_M433_Impact_Muzzle: ThrowMuzzle
		{
			magazines[]=
			{
				"Mavic_M433"
			};
		};
	};
};

class CfgFunctions
{
	class mavic_drop
	{
		file = "mavic_drop\functions";
		
		class mdf {
			class initDrone {};
			class makeGrenadeDrone {};
			class dropGrenade {};
			class dynamicBlurToggle {};
			class uiGrenadeSelector {};
			class detach_uiGrenadeSelector {};
		};
	};
};