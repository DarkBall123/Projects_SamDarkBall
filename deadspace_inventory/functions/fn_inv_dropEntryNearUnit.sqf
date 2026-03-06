params ["_unit", "_entry"];

if (isNull _unit || {_entry isEqualTo []}) exitWith { objNull };

private _pos = _unit modelToWorld [0, 0.8, 0];
private _holder = "GroundWeaponHolder" createVehicle _pos;

_entry params ["_entryType", "_className", "_count"];

switch _entryType do {
    case "weapon": {
        _holder addWeaponCargoGlobal [_className, _count];
    };
    case "magazine": {
        _holder addMagazineCargoGlobal [_className, _count];
    };
    case "backpack": {
        _holder addBackpackCargoGlobal [_className, _count];
    };
    default {
        _holder addItemCargoGlobal [_className, _count];
    };
};

_holder
