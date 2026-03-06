params ["_source", "_panelType", "_entry"];

if (isNull _source || {_entry isEqualTo []}) exitWith { false };

_entry params ["_entryType", "_className", "_count"];

if (_panelType isEqualTo "cargo") exitWith {
    switch _entryType do {
        case "weapon": {
            _source addWeaponCargo [_className, -_count];
        };
        case "magazine": {
            _source addMagazineCargo [_className, -_count];
        };
        case "backpack": {
            _source addBackpackCargo [_className, -_count];
        };
        default {
            _source addItemCargo [_className, -_count];
        };
    };

    true
};

private _removeItem = {};
private _isValidPanel = true;

switch _panelType do {
    case "uniform": {
        _removeItem = {
            params ["_holder", "_class"];
            _holder removeItemFromUniform _class;
        };
    };
    case "vest": {
        _removeItem = {
            params ["_holder", "_class"];
            _holder removeItemFromVest _class;
        };
    };
    case "backpack": {
        _removeItem = {
            params ["_holder", "_class"];
            _holder removeItemFromBackpack _class;
        };
    };
    default {
        _isValidPanel = false;
    };
};

if (!_isValidPanel) exitWith { false };

for "_i" from 1 to _count do {
    [_source, _className] call _removeItem;
};

true
