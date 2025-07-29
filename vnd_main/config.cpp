class CfgPatches
{
	class vnd_Data
	{
		author = "DarkBall & Sam";
		name   = "vnd";
		url    = "";
		requiredAddons[] =
		{
			"A3_Data_F_AoW_Loadorder",
			"A3_Data_F",
			"A3_Drones_F",
			"cba_settings"
		};
		requiredVersion = 0.1;
		units[] =
		{
			"O_KVN_AT",      "O_KVN_AP",
			"O_KVN_AT_TI",   "O_KVN_AP_TI",
			"B_KVN_AT",      "B_KVN_AP",
			"B_KVN_AT_TI",   "B_KVN_AP_TI",
			"I_KVN_AT",      "I_KVN_AP",
			"I_KVN_AT_TI",   "I_KVN_AP_TI"
		};
		weapons[] = {};
	};
};

#include "includes\vnd_interface.hpp"
#include "includes\CfgAmmo.hpp"
#include "includes\CfgFontFamilies.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\CfgVehicles.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"
#include "includes\Extended_PostInit_EventHandlers.hpp"