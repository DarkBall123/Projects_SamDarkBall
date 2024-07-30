class CfgPatches
{
	class orion
	{
		addonRootClass="A3_Drones_F";
		requiredAddons[]=
		{
			"A3_Data_F_AoW_Loadorder",
			"A3_Drones_F"
		};
		requiredVersion=0.1;
		units[]=
		{
			"orion_F_OPF",
			"orion_F_KORNET_OPF",
			"orion_F_KAB50_OPF",
			"orion_F_KAB20_OPF",
			"orion_F_BLU",
			"orion_F_KORNET_BLU",
			"orion_F_KAB50_BLU",
			"orion_F_KAB20_BLU",
			"orion_F_IND",
			"orion_F_KORNET_IND",
			"orion_F_KAB50_IND",
			"orion_F_KAB20_IND"
		};
		weapons[]={};
	};
};


#include "includes\CfgVehicles.hpp"
#include "includes\CfgMagazines.hpp"
#include "includes\CfgAmmo.hpp"
#include "includes\CfgWeapons.hpp"
#include "includes\RscTitles.hpp"
#include "includes\CfgFunctions.hpp"
#include "includes\CfgNonAIVehicles.hpp"
