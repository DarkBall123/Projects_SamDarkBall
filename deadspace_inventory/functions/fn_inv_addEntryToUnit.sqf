params ["_unit", "_entry"];

if !([_unit, _entry] call DB_dsi_fnc_inv_canAddEntry) exitWith { false };

_entry params ["_entryType", "_className", "_count"];

if (_entryType isEqualTo "backpack") exitWith {
    _unit addBackpack _className;
    true
};

for "_i" from 1 to _count do {
    _unit addItem _className;
};

true
