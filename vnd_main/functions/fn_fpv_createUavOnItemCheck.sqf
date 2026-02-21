#include "\vnd_main\script_macros.hpp"

params ["_unit", "_container", "_item"];

if (isNull _unit || { isNull _container }) exitWith {};

private _validItems = GETMVAR(DB_vnd_fpv_dronesArray_items, []);
if !(_item in _validItems) exitWith {};
if !(_container isKindOf "GroundWeaponHolder") exitWith {};

private _uavType = switch (_item) do {
    case "Item_KVN_AT": { "KVN_AT" };
    case "Item_KVN_AP": { "KVN_AP" };
    case "Item_KVN_AT_TI": { "KVN_AT_TI" };
    case "Item_KVN_AP_TI": { "KVN_AP_TI" };
    default { "" };
};
if (_uavType isEqualTo "") exitWith {};

private _sidePrefix = switch (side _unit) do {
    case east: { "O_" };
    case west: { "B_" };
    case resistance: { "I_" };
    default { "" };
};
if (_sidePrefix isEqualTo "") exitWith {};

private _uavClass = format ["%1%2", _sidePrefix, _uavType];
private _pos = getPosATL _container;
private _uav = createVehicle [_uavClass, _pos, [], 0, "CAN_COLLIDE"];
createVehicleCrew _uav;

if (local _uav && { local _container }) then {
    _uav disableCollisionWith _container;
} else {
    [_uav, _container] remoteExecCall ["disableCollisionWith", 0, _uav];
};

private _cargo = magazinesAmmoCargo _container;
private _newCargo = [];
private _removedOne = false;
{
    private _magClass = _x # 0;
    private _magAmmo = _x # 1;

    // Each Put event consumes exactly one dropped item; keep other identical mags in holder.
    if (!_removedOne && { _magClass isEqualTo _item }) then {
        _removedOne = true;
    } else {
        _newCargo pushBack [_magClass, _magAmmo];
    };
} forEach _cargo;

clearMagazineCargo _container;
{
    _container addMagazineAmmoCargo [_x # 0, 1, _x # 1];
} forEach _newCargo;
