class CfgPatches
{
	class sting_data
	{
		addonRootClass = "A3_Drones_F";
		author = "DarkBall & Sam";
		name = "Sting";
		requiredAddons[] =
		{
			"A3_Data_F_AoW_Loadorder",
			"A3_Data_F",
			"A3_Drones_F",
			"cba_main",
			"cba_common",
			"cba_xeh",
			"cba_xeh_a3",
			"cba_settings"
		};
		requiredVersion = 0.1;
		units[] =
		{
			"O_Sting_F",
			"B_Sting_F",
			"I_Sting_F",
			"O_Sting_TI_F",
			"B_Sting_TI_F",
			"I_Sting_TI_F",
			"O_Sting_Bag",
			"B_Sting_Bag",
			"I_Sting_Bag",
			"O_Sting_TI_Bag",
			"B_Sting_TI_Bag",
			"I_Sting_TI_Bag"
		};
		weapons[] = {};
	};
};

#include "includes\Sting_interface.hpp"
#include "includes\CfgAmmo.hpp"
#include "includes\CfgFontFamilies.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\CfgMagazines.hpp"
#include "includes\CfgVehicles.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"
#include "includes\Extended_PostInit_EventHandlers.hpp"

class cfgMods
{
	author = "DarkBall & Sam";
	timepacked = "1774100000";
};
