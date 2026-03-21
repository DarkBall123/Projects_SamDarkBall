params ["_unit", "_container", "_item"];

#include "\sting\script_macros.hpp"

private _validItems = GETMVAR(DB_sting_dronesArray_items, STING_DRONE_ITEMS);
if !(_item in _validItems) exitWith {};
if (typeOf _container != "GroundWeaponHolder") exitWith {};

private _itemCfg = configFile >> "CfgMagazines" >> _item;
if !(isClass _itemCfg) exitWith {};

private _uavSuffix = getText (_itemCfg >> "DB_stingVehicleSuffix");
if (_uavSuffix isEqualTo "") exitWith {};

private _sidePrefix = switch (side _unit) do {
	case east: { "O_" };
	case west: { "B_" };
	case resistance: { "I_" };
	default { "" };
};
if (_sidePrefix isEqualTo "") exitWith {};

private _uavClass = format ["%1%2", _sidePrefix, _uavSuffix];
if !(isClass (configFile >> "CfgVehicles" >> _uavClass)) exitWith {};

private _pos = getPosATL _container;
private _uav = createVehicle [_uavClass, _pos, [], 0, "CAN_COLLIDE"];
createVehicleCrew _uav;

if (local _uav && local _container) then {
	_uav disableCollisionWith _container;
} else {
	[_uav, _container] remoteExecCall ["disableCollisionWith", 0, _uav];
};

private _cargo = magazinesAmmoCargo _container;
private _newCargo = [];
{
	private _magClass = _x # 0;
	private _magAmmo = _x # 1;
	if (_magClass != _item) then { _newCargo pushBack [_magClass, _magAmmo] };
} forEach _cargo;

clearMagazineCargo _container;
{
	_container addMagazineAmmoCargo [_x # 0, 1, _x # 1];
} forEach _newCargo;
