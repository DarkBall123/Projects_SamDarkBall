class SensorTemplateIR;

class CfgPatches
{
    class MANPAD_
    {
        name = "kedr_antiUAVs";
        author = "Sam/Darkball";
        requiredVersion = 2;
        requiredAddons[] = 
        {
            "A3_Weapons_F_Launchers_Titan",
            "A3_Data_F_AoW_Loadorder"
        };
        units[] = {};
        weapons[] = {"Kedr_antiUAV"};
    };
};

class CfgAmmo
{    
    class MissileBase;
    class M_Titan_AA: MissileBase
    {
        class Components;
    };

    class Kedr_antiUAV: M_Titan_AA
    {
        model = "kedr\model\kedr_missile.p3d";
        airlock = 2;
        cmimmunity = 1;
        proximityExplosionDistance = 0;
        fuseDistance = 0;
        warheadName = "HE";
        hit = 80;
        indirecthit = 60;
        indirecthitrange = 6;
        explosive = 1;
        irlock = 1;
        maneuvrability = 34;
        maxspeed = 30;
        thrust = 35;
        thrusttime = 4;
        timetolive = 20;
        tracklead = 0.85;
        trackoversteer = 0.95;
        sideairfriction = 0.08;
        maxcontrolrange = 6400;
        missileLockMaxDistance = 6400;
        missileLockMinDistance = 25;
        missileLockMaxSpeed = 400;
        missileLockCone = 15;
        missileKeepLockedCone = 75;
        weaponLockSystem = "2 + 16";
        soundFly[] = {"", 0.13, 1};
        effectsMissile = "EmptyEffect";
        effectsMissileInit = "";
        effectsSmoke = "";
        muzzleEffect = "";
        CraterEffects = "AAMissileCrater";
        explosionEffects = "AAMissileExplosion";
        SoundSetExplosion[] = {"RocketsHeavy_Exp_SoundSet", "RocketsHeavy_Tail_SoundSet", "Explosion_Debris_SoundSet"};
        soundHit1[] = {"A3\\Sounds_F\\arsenal\\weapons\\Launchers\\Titan\\Explosion_titan_missile_01", 2.51189, 1, 1900};
        soundHit2[] = {"A3\\Sounds_F\\arsenal\\weapons\\Launchers\\Titan\\Explosion_titan_missile_02", 2.51189, 1, 1900};
        soundHit3[] = {"A3\\Sounds_F\\arsenal\\weapons\\Launchers\\Titan\\Explosion_titan_missile_03", 2.51189, 1, 1900};
        multiSoundHit[] = {"soundHit1", 0.34, "soundHit2", 0.33, "soundHit3", 0.33};

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
                            minRange = 25;
                            maxRange = 2000;
                            objectDistanceLimitCoef = -1;
                            viewDistanceLimitCoef = 1;
                        };
                        class GroundTarget
                        {
                            minRange = 0;
                            maxRange = 0;
                            objectDistanceLimitCoef = 1;
                            viewDistanceLimitCoef = 1;
                        };
                        angleRangeHorizontal = 45;
                        angleRangeVertical = 45;
                        minTrackableSpeed = 0;
                        maxTrackableSpeed = 400;
                        minTrackableATL = 10;
                        maxTrackableATL = 2000;
                    };
                };
            };
        };
    };
};

class CfgMagazines
{
    class Titan_AA;
    class kedr_mag: Titan_AA
    {
        ammo = "Kedr_antiUAV";
        model = "kedr\mag\kedr_mag.p3d";        
        displayname = "KEDR UAV 1x";
        displayNameShort = "KEDR UAV 1x";
        picture = "\kedr\ui\mag.paa";
        descriptionShort = "Three-band optical seeker";
        initspeed = 4;
        maxleadspeed = 400;
    };
};

class CfgWeapons
{
    class launch_O_Titan_F;
    
    class Kedr_antiUAV: launch_O_Titan_F
    {
        author = "Sem";
        displayname = "KEDR UAV";
        model = "kedr\kedr.p3d";
        weaponInfoType = "RscWeaponZeroing"; 
        modelOptics = "";                   
        useModelOptics = 0;  
        handAnim[] = {"OFP2_ManSkeleton", "\kedr\ani\kedr.rtm"};
        picture = "\kedr\ui\body.paa";
        magazines[] = {"kedr_mag"};
        shotPos = "";
        shotEnd = "";
        magazineWell[] = {};

        class GunParticles
        {
            class effect1
            {
                effectName = "";
            };
        };
        
        cmImmunity = 1;
        canLock = 2;
        lockAcquire = 1;
        weaponLockDelay = 5.4;
        weaponLockSystem = 2;

        lockingTargetSound[] = {"kedr\files\1.ogg", 1, 1};
        lockedTargetSound[] = {"kedr\files\2.ogg", 1, 2.5};

        modes[] = {"Single"};
        
        // Исправлено: Наследуемся напрямую от режима Single Титана
        class Single: launch_O_Titan_F
        {
            recoil = "recoil_single_titan";
            recoilProne = "recoil_single_prone_titan";

            sounds[] = {"StandardSound"};
            class StandardSound
            {
                begin1[] = {"\kedr\sound\zap.ogg", 2, 1, 2000};
                soundBegin[] = {"begin1", 1};
            };
            
            reloadTime = 2;
            dispersion = 0.002;
            aiRateOfFire = 7;
            aiRateOfFireDistance = 3500;
            minRange = 25;
            minRangeProbab = 0.8;
            midRange = 3000;
            midRangeProbab = 0.95;
            maxRange = 6400;
            maxRangeProbab = 0.95;
        };
    };
};

class CfgVehicles
{
    class Box_EAF_WpsSpecial_F;
    class kedr_box : Box_EAF_WpsSpecial_F
    {   
        scope = 2;
        scopecurator = 2;
        author = "Sam";
        displayName = "Kedr box 1x";

        class TransportWeapons 
        {
            class _xx_Kedr_antiUAV 
            {
                weapon = "Kedr_antiUAV";
                count = 1;
            };
        };

        class TransportMagazines 
        {
            class _xx_kedr_mag 
            {
                magazine = "kedr_mag";
                count = 3;
            };
        };
        class TransportItems {};
    };
};
