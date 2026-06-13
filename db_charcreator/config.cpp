class CfgPatches
{
    class db_charcreator
    {
        author = "DarkBall & Sam";
        name   = "Character Creator";
        url    = "";
        requiredAddons[] =
        {
            "A3_Data_F",
            "A3_Characters_F",
            "cba_main",
            "cba_xeh"
        };
        requiredVersion = 0.1;
        units[]   = {};
        weapons[] = {};
    };
};

#include "includes\CfgFunctions.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"
#include "includes\Extended_PostInit_EventHandlers.hpp"
