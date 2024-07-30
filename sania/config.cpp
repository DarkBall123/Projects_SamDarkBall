class CfgPatches
{
    class sania_antiuav
    {
        units[]={"Podavitel", "Sania", "Sania_with_tripod", "Volnorez_1", "Volnorez_Bag", "Sania_Crate", "Sania_Bag"};
        weapons[]={};
        requiredVersion= 1.03;
        version= 1.14;
        requiredAddons[]=
        {
            "cba_xeh"
        };
		author = "sam and DarkBall";
    };
};

#include "includes\CfgVehicles.hpp"
#include "includes\CfgMagazines.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\Extended_ClientInit_EventHandlers.hpp"
#include "includes\Extended_InitPost_EventHandlers.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"