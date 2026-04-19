class CfgPatches
{
    class DB_dynamic_sectors
    {
        author = "DarkBall";
        name = "Dynamic Sector Zones";
        requiredAddons[] =
        {
            "A3_Functions_F",
            "cba_main",
            "cba_common",
            "cba_settings",
            "cba_xeh",
            "cba_xeh_a3"
        };
        requiredVersion = 1.0;
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class DB_DS
    {
        class sectors
        {
            file = "\db_dynamic_sectors\functions";

            class buildSectorGrid {};
            class clientInit {};
            class collectSectorState {};
            class handleStateUpdate {};
            class isLandSector {};
            class pickGridSize {};
            class postInit
            {
                postInit = 1;
            };
            class renderSectorState {};
            class serverLoop {};
        };
    };
};

#include "includes\Extended_PreInit_EventHandlers.hpp"

class cfgMods
{
    author = "[SEAL TEAM] DarkBall";
    timepacked = "1776547200";
};
