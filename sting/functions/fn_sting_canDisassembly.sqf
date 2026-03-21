params ["_uav"];

private _vehicleCfg = configFile >> "CfgVehicles" >> typeOf _uav;
private _itemType = getText (_vehicleCfg >> "DB_stingItem");
if (_itemType isEqualTo "") exitWith { false };

alive _uav
	&& { player canAdd _itemType }
	&& { cameraOn == player }
	&& { (speed _uav) < 1 }
	&& { !(isEngineOn _uav) }
