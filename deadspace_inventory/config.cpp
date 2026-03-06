class CfgPatches
{
    class deadspace_inventory
    {
        author = "DarkBall";
        name = "Deadspace Inventory";
        url = "";
        requiredVersion = 0.1;
        requiredAddons[] =
        {
            "A3_UI_F",
            "cba_main",
            "cba_xeh"
        };
        units[] = {};
        weapons[] = {};
    };
};

#include "includes\CfgFunctions.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"
#include "includes\Extended_PostInit_EventHandlers.hpp"
