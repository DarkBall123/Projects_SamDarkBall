params ["_unit","_container","_item"];

private _validItems = missionNamespace getVariable ["DB_kvn_fpv_dronesArray_items",[]];
if !(_item in _validItems) exitWith {};
if (typeOf _container != "GroundWeaponHolder") exitWith {};

private _itemParts = _item splitString "_";
private _uavType = _itemParts select [2, count _itemParts - 2] joinString "_";
if (_uavType == "") exitWith { systemChat str "Item not found." };

private _sidePrefix = switch (side _unit) do {
    case east:       { "O" };
    case west:       { "B" };
    case resistance: { "I" };
    default         { "" };
};
if (_sidePrefix == "") exitWith { systemChat str "Unsupported side." };

private _uavClass = format ["frtz_%1_%2", _sidePrefix, _uavType];

private _pos = getPosATL _container;
private _uav = createVehicle [_uavClass, _pos, [], 0, "CAN_COLLIDE"];
createVehicleCrew _uav;

if (local _uav && local _container) then {
    _uav disableCollisionWith _container;
} else {
    [_uav, _container] remoteExecCall ["disableCollisionWith", 0, _uav];
};

private _cargo = magazineCargo _container;
private _newCargo = [];
{
    if (_x != _item) then { _newCargo pushBack _x };
} forEach _cargo;

clearMagazineCargo _container;
{
    _container addMagazineCargo [_x,1];
} forEach _newCargo;
