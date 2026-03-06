params ["_unit", "_entry"];

if (isNull _unit || {_entry isEqualTo []}) exitWith { 0 };

private _requestedCount = _entry param [2, 0];
if (_requestedCount <= 0) exitWith { 0 };

_entry params ["_entryType", "_className", "_count"];

if (_entryType isEqualTo "backpack") exitWith {
    if !(_count isEqualTo 1) exitWith { 0 };
    if !([_unit, _entry] call DB_dsi_fnc_inv_canAddEntry) exitWith { 0 };

    private _previousBackpack = backpack _unit;
    _unit addBackpack _className;
    if (
        !((backpack _unit) isEqualTo _previousBackpack) &&
        {(backpack _unit) isEqualTo _className}
    ) then {
        1
    } else {
        0
    }
};

private _beforeCounts = uniqueUnitItems _unit;
private _beforeCount = _beforeCounts getOrDefault [_className, 0];

for "_i" from 1 to _count do {
    _unit addItem _className;
};

private _afterCounts = uniqueUnitItems _unit;
private _addedCount = (_afterCounts getOrDefault [_className, 0]) - _beforeCount;

(_addedCount max 0) min _count
