params ["_uav", "_player"];

private _typeParts = typeOf _uav splitString "_";
private _coreType  = _typeParts select [2, count _typeParts - 2] joinString "_";
private _itemType = format ["frtz_Item_%1", _coreType];

private _validItems = missionNamespace getVariable ["DB_kvn_fpv_dronesArray_items", []];
if !(_itemType in _validItems) exitWith {};

_player addItem _itemType;

deleteVehicle _uav;

_player action ["TakeBag", objNull];
