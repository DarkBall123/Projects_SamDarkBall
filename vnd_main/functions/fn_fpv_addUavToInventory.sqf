#include "\vnd_main\script_macros.hpp"

params ["_uav", "_unit"];
if (isNull _uav || { isNull _unit }) exitWith {};

private _typeParts = typeOf _uav splitString "_";
private _coreType = _typeParts select [1, count _typeParts - 1] joinString "_";
private _itemType = format ["Item_%1", _coreType];

_unit addItem _itemType;
deleteVehicle _uav;

_unit action ["TakeBag", objNull];
