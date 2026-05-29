class CfgPatches
{
    class oreshnik
    {
        name = "Oreshnik Effects";
        author = "DarkBall";
        requiredVersion = 0.1;
        requiredAddons[] =
        {
            "A3_Data_F_Decade_Loadorder",
            "A3_Misc_F",
            "A3_Weapons_F"
        };
        units[] = {};
        weapons[] = {};
    };
};

class CfgAmmo
{
    class B_127x99_Ball_Tracer_Yellow;

    class SDB_oreshnik_Tracer_Yellow: B_127x99_Ball_Tracer_Yellow
    {
        hit = 0;
        indirectHit = 0;
        indirectHitRange = 0;
        explosive = 0;
        caliber = 0;
        typicalSpeed = 900;
        airFriction = 0;
        timeToLive = 8;
        visibleFire = 0;
        audibleFire = 0;
        dangerRadiusBulletClose = 0;
        dangerRadiusHit = 0;
        suppressionRadiusBulletClose = 0;
        suppressionRadiusHit = 0;
        tracerScale = 5;
        tracerStartTime = 0;
        tracerEndTime = 8;
        nvgOnly = 0;
    };
};

#include "includes\CfgFunctions.hpp"

class cfgMods
{
    author = "[SEAL TEAM] DarkBall";
};
