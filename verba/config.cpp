class SensorTemplateIR;
class CfgPatches
{
	class MANPAD_VERBA
	{
		name="VERBA";
		author="Sem";
		requiredVersion=2;
		requiredAddons[]=
		{
			"A3_Weapons_F_Launchers_Titan",
			"A3_Data_F_AoW_Loadorder"
		};
		units[]={};
		weapons[]=
		{
			"Verba_9k333"
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
	class Verba_9m336: M_Titan_AA
	{
		model="verba\model\verba_missile.p3d";
		effectsMissile = "FX_Missile_SAM_LongRange";
		airlock=2;
		cmimmunity=0.98;
		proximityExplosionDistance=8;
		hit=80;
		indirecthit=40;
		indirecthitrange=30;
		irlock=1;
		maneuvrability=34;
		maxspeed=500;
		thrust=392;
		thrusttime=4.5;
		timetolive=20;
		tracklead=0.85000002;
		trackoversteer=0.94999999;
		sideairfriction=0.079999998;
		maxcontrolrange=6400;
		missileLockMaxDistance=6400;
		missileLockMinDistance=500;
		missileLockMaxSpeed=400;
		missileLockCone=15;
		missileKeepLockedCone=70;
		weaponLockSystem="2 + 16";
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
							minRange=500;
							maxRange=6400;
						};
						class GroundTarget
						{
							minRange=500;
							maxRange=1000;
						};
						angleRangeHorizontal=45;
						angleRangeVertical=45;
						minTrackableSpeed=0;
						maxTrackableSpeed=400;
						minTrackableATL=10;
						maxTrackableATL=4500;
					};
				};
			};
		};
	};
};
class CfgMagazines
{
	class Titan_AA;
	class 9m336: Titan_AA
	{
		ammo="Verba_9m336";
		model="verba\mag\verba_mag.p3d";		
		displayname="9m336";
		displayNameShort="9m336";
		picture = "\verba\ui\MAG.paa";
		descriptionShort="<br/>Three-band optical seeker<br/>";
		initspeed=30;
		maxleadspeed=400;
	};
};
class CfgWeapons
{
	class launch_O_Titan_F;
	class Verba_9k333: launch_O_Titan_F
	{
		displayname="9K333 Verba";
		model="verba\verba.p3d";
		weaponInfoType="RscOpticsRangeFinderVorona";
		modelOptics="A3\Weapons_F_Tank\acc\reticle_Vorona.p3d";
		handAnim[]=
		{
			"OFP2_ManSkeleton",
			"\verba\ani\verba.rtm"
		};
		picture = "\verba\ui\BODY.paa";
		magazines[]=
		{
			"9m336"
		};
		shotPos="";
		shotEnd="";
		magazineWell[]={};
		cmImmunity=0.5;
		canLock=2;
		lockAcquire=1;
		weaponLockDelay=5.4000001;
		weaponLockSystem=2;
			aiRateOfFire=7;
			aiRateOfFireDistance=3500;
			minRange=500;
			minRangeProbab=0.80000001;
			midRange=3000;
			midRangeProbab=0.94999999;
			maxRange=6400;
			maxRangeProbab=0.94999999;
		lockingTargetSound[]=
		{
			"verba\files\1.ogg",
			1,
			1
		};
		lockedTargetSound[]=
		{
			"verba\files\2.ogg",
			1,
			2.5
		};
	};
};

class CfgVehicles
{
    class Box_EAF_WpsSpecial_F;
    class verba_box : Box_EAF_WpsSpecial_F
    {   
        scope = 2;
        scopecurator = 2;
        author = "Sam";
        displayName = "Verba 9k333 box";

        class TransportWeapons 
        {
            class _xx_Verba_9k333 
            {
                weapon = "Verba_9k333";
                count = 1;
            };
        };

        class TransportMagazines 
		{
			class _xx_Verba_9m336 
            {
                magazine = "9m336";
                count = 1;
            };
		};
        class TransportItems {};
    };
};









