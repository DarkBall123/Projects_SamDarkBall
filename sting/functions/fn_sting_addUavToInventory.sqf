params ["_uav", "_player"];

private _vehicleCfg = configFile >> "CfgVehicles" >> typeOf _uav;
private _itemType = getText (_vehicleCfg >> "DB_stingItem");
if (_itemType isEqualTo "") exitWith {};
if !(_player canAdd _itemType) exitWith {};

_player addItem _itemType;
deleteVehicle _uav;

_player action ["TakeBag", objNull];
