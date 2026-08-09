class CfgPatches
{
    class SDB_Mnogotochie
    {
        name = "$STR_SDB_Mnogotochie_Name";
        author = "Sam / DarkBall";
        requiredVersion = 2.24;
        requiredAddons[] =
        {
            "A3_Weapons_F",
            "A3_Weapons_F_Exp_Rifles_AKS",
            "A3_Weapons_F_LongRangeRifles_DMR_01",
            "A3_Weapons_F_Machineguns_Zafir",
            "cba_jam"
        };
        units[] = {};
        weapons[] = {};
    };
};

class CfgAmmo
{
    class B_545x39_Ball_F;
    class B_762x54_Ball;

    class SDB_Ammo_STs226_Element: B_545x39_Ball_F
    {
        hit = 4.4;
        caliber = 0.45;
        indirectHit = 0;
        indirectHitRange = 0;
        explosive = 0;
        typicalSpeed = 800;
        airFriction = -0.0032;
        cartridge = "";
        model = "";
        tracerScale = 0;
        tracerStartTime = 10;
        tracerEndTime = 0;
    };

    class SDB_Ammo_STs226_Carrier: B_545x39_Ball_F
    {
        simulation = "shotSubmunitions";
        hit = 5.1;
        caliber = 0.45;
        indirectHit = 0;
        indirectHitRange = 0;
        explosive = 0;
        typicalSpeed = 800;
        airFriction = -0.0032;
        submunitionAmmo = "SDB_Ammo_STs226_Element";
        submunitionConeType[] = {"poissondisccenter", 3};
        submunitionConeAngle = 0.18;
        submunitionDirectionType = "SubmunitionModelDirection";
        submunitionInitialOffset[] = {0, 0, 0};
        submunitionInitSpeed = 0;
        submunitionParentSpeedCoef = 1;
        triggerTime = 0.001;
        triggerOnImpact = 0;
        deleteParentWhenTriggered = 1;
        model = "";
        tracerScale = 0;
        tracerStartTime = 10;
        tracerEndTime = 0;
    };

    class SDB_Ammo_STs228_Element: B_762x54_Ball
    {
        hit = 6.4;
        caliber = 0.55;
        indirectHit = 0;
        indirectHitRange = 0;
        explosive = 0;
        typicalSpeed = 790;
        airFriction = -0.001023;
        cartridge = "";
        model = "";
        tracerScale = 0;
        tracerStartTime = 10;
        tracerEndTime = 0;
    };

    class SDB_Ammo_STs228_Carrier: B_762x54_Ball
    {
        simulation = "shotSubmunitions";
        hit = 7;
        caliber = 0.55;
        indirectHit = 0;
        indirectHitRange = 0;
        explosive = 0;
        typicalSpeed = 790;
        airFriction = -0.001023;
        submunitionAmmo = "SDB_Ammo_STs228_Element";
        submunitionConeType[] = {"poissondisccenter", 3};
        submunitionConeAngle = 0.18;
        submunitionDirectionType = "SubmunitionModelDirection";
        submunitionInitialOffset[] = {0, 0, 0};
        submunitionInitSpeed = 0;
        submunitionParentSpeedCoef = 1;
        triggerTime = 0.001;
        triggerOnImpact = 0;
        deleteParentWhenTriggered = 1;
        model = "";
        tracerScale = 0;
        tracerStartTime = 10;
        tracerEndTime = 0;
    };
};

class CfgMagazines
{
    class 30Rnd_545x39_Mag_F;
    class 10Rnd_762x54_Mag;
    class 150Rnd_762x54_Box;

    class SDB_30Rnd_545x39_STs226_Mag: 30Rnd_545x39_Mag_F
    {
        scope = 2;
        scopeArsenal = 2;
        author = "Sam / DarkBall";
        displayName = "$STR_SDB_Mnogotochie_STs226_30_Name";
        displayNameShort = "$STR_SDB_Mnogotochie_STs226_Short";
        descriptionShort = "$STR_SDB_Mnogotochie_STs226_Description";
        picture = "\z\sdb\addons\mnogotochie\data\ui\m_sts226_ca.paa";
        hiddenSelections[] = {"camo"};
        hiddenSelectionsTextures[] =
        {
            "\z\sdb\addons\mnogotochie\data\magazine_ak74_sts226_co.paa"
        };
        ammo = "SDB_Ammo_STs226_Carrier";
        count = 30;
        initSpeed = 800;
        tracersEvery = 0;
        lastRoundsTracer = 0;
    };

    class SDB_45Rnd_545x39_STs226_Mag: SDB_30Rnd_545x39_STs226_Mag
    {
        displayName = "$STR_SDB_Mnogotochie_STs226_45_Name";
        count = 45;
    };

    class SDB_10Rnd_762x54R_STs228_Mag: 10Rnd_762x54_Mag
    {
        scope = 2;
        scopeArsenal = 2;
        author = "Sam / DarkBall";
        displayName = "$STR_SDB_Mnogotochie_STs228_10_Name";
        displayNameShort = "$STR_SDB_Mnogotochie_STs228_Short";
        descriptionShort = "$STR_SDB_Mnogotochie_STs228_Description";
        hiddenSelections[] = {"camo"};
        hiddenSelectionsTextures[] =
        {
            "\z\sdb\addons\mnogotochie\data\dmr_06_02_sts228_co.paa"
        };
        ammo = "SDB_Ammo_STs228_Carrier";
        count = 10;
        initSpeed = 790;
        tracersEvery = 0;
        lastRoundsTracer = 0;
    };

    class SDB_100Rnd_762x54R_STs228_Box: 150Rnd_762x54_Box
    {
        scope = 2;
        scopeArsenal = 2;
        author = "Sam / DarkBall";
        displayName = "$STR_SDB_Mnogotochie_STs228_100_Name";
        displayNameShort = "$STR_SDB_Mnogotochie_STs228_Short";
        descriptionShort = "$STR_SDB_Mnogotochie_STs228_Description";
        ammo = "SDB_Ammo_STs228_Carrier";
        count = 100;
        initSpeed = 790;
        tracersEvery = 0;
        lastRoundsTracer = 0;
    };

    class SDB_150Rnd_762x54R_STs228_Box: SDB_100Rnd_762x54R_STs228_Box
    {
        displayName = "$STR_SDB_Mnogotochie_STs228_150_Name";
        count = 150;
    };
};

class CfgMagazineWells
{
    class AK_545x39
    {
        SDB_Mnogotochie[] =
        {
            "SDB_30Rnd_545x39_STs226_Mag",
            "SDB_45Rnd_545x39_STs226_Mag"
        };
    };

    class CBA_545x39_AK
    {
        SDB_Mnogotochie[] =
        {
            "SDB_30Rnd_545x39_STs226_Mag",
            "SDB_45Rnd_545x39_STs226_Mag"
        };
    };

    class CBA_545x39_RPK
    {
        SDB_Mnogotochie[] =
        {
            "SDB_30Rnd_545x39_STs226_Mag",
            "SDB_45Rnd_545x39_STs226_Mag"
        };
    };

    class CBA_762x54R_SVD
    {
        SDB_Mnogotochie[] =
        {
            "SDB_10Rnd_762x54R_STs228_Mag"
        };
    };

    class CBA_762x54R_LINKS
    {
        SDB_Mnogotochie[] =
        {
            "SDB_100Rnd_762x54R_STs228_Box",
            "SDB_150Rnd_762x54R_STs228_Box"
        };
    };
};
