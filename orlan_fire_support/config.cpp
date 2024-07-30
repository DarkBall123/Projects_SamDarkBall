class CfgPatches
{
	class orlan_support
	{
		addonRootClass="A3_Drones_F";
		requiredAddons[]=
		{
			"A3_Data_F_AoW_Loadorder",
			"orlan_main"
		};
		requiredVersion=0.1;
		units[]={};
		weapons[]={};
	};
};

#include "includes\CfgAmmo.hpp"
#include "includes\CfgCommunicationMenu.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\Extended_ClientInit_EventHandlers.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"

class cfgMods
{
	author="[SEAL TEAM] DarkBall";
	timepacked="1701281005";
};
