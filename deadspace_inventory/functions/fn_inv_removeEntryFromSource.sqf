params ["_source", "_panelType", "_entry"];

if (isNull _source || {_entry isEqualTo []}) exitWith { false };

_entry params ["_entryType", "_className", "_count"];
if (_className isEqualTo "" || {_count <= 0}) exitWith { false };

private _getCargoCount = {
    params ["_holder", "_type", "_className"];

    private _cargo = switch _type do {
        case "weapon": { getWeaponCargo _holder };
        case "magazine": { getMagazineCargo _holder };
        case "backpack": { getBackpackCargo _holder };
        default { getItemCargo _holder };
    };

    private _classes = _cargo param [0, []];
    private _counts = _cargo param [1, []];
    private _index = _classes find _className;

    if (_index < 0) exitWith { 0 };

    _counts param [_index, 0]
};

private _getPanelItems = {
    params ["_holder", "_type"];

    switch _type do {
        case "uniform": { uniformItems _holder };
        case "vest": { vestItems _holder };
        case "backpack": { backpackItems _holder };
        default { [] };
    };
};

if (_panelType isEqualTo "cargo") exitWith {
    private _available = [_source, _entryType, _className] call _getCargoCount;
    if (_available < _count) exitWith { false };

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

    private _remaining = [_source, _entryType, _className] call _getCargoCount;
    (_available - _remaining) isEqualTo _count
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

private _available = {
    _x isEqualTo _className
} count ([_source, _panelType] call _getPanelItems);

if (_available < _count) exitWith { false };

for "_i" from 1 to _count do {
    [_source, _className] call _removeItem;
};

private _remaining = {
    _x isEqualTo _className
} count ([_source, _panelType] call _getPanelItems);

(_available - _remaining) isEqualTo _count
