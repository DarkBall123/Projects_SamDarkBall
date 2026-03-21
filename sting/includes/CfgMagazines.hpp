#include "Sting_config_macros.hpp"

class CfgMagazines
{
	class Laserbatteries;

	class Item_Sting: Laserbatteries
	{
		_generalMacro = "Item_Sting";
		scope = 2;
		STING_MAG_COMMON("Sting FPV Drone", "Sting Drone", QSTING_CFG_PATH(drone_inter.p3d), "Sting_F");
	};

	class Item_Sting_TI: Laserbatteries
	{
		_generalMacro = "Item_Sting_TI";
		scope = 2;
		STING_MAG_COMMON("Sting FPV Drone TI", "Sting TI Drone", QSTING_CFG_PATH(drone_inter.p3d), "Sting_TI_F");
	};
};
