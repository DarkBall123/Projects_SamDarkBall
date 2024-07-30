class CfgPatches
{
	class orlan_main
	{
		addonRootClass="A3_Drones_F";
		requiredAddons[]=
		{
			"A3_Data_F_AoW_Loadorder",
			"A3_Drones_F",
			"A3_Supplies_F_Enoch_Ammoboxes"
		};
		requiredVersion=0.1;
		units[]=
		{
			"orlan_tripod_launcher_OPF",
			"orlan_tripod_launcher_BLU",
			"orlan_tripod_launcher_IND",
			"orlan_F_OPF",
			"orlan_F_BLU",
			"orlan_F_IND",
			"orlan_reloadBox"
		};
		weapons[]=
		{
		};
	};
};

#include "includes\CfgAmmo.hpp"
#include "includes\CfgMagazines.hpp"
#include "includes\CfgWeapons.hpp"
#include "includes\CfgVehicles.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\RscTitles.hpp"
#include "includes\Extended_PreInit_EventHandlers.hpp"
