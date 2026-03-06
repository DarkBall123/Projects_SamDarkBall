params ["_unit"];

private _panels = [];

private _uniformClass = uniform _unit;
if !(_uniformClass isEqualTo "") then {
    private _entries = [uniformItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    _panels pushBack ["uniform", "U", "Uniform", _entries];
};

private _vestClass = vest _unit;
if !(_vestClass isEqualTo "") then {
    private _entries = [vestItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    _panels pushBack ["vest", "V", "Vest", _entries];
};

private _backpackClass = backpack _unit;
if !(_backpackClass isEqualTo "") then {
    private _entries = [backpackItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    _panels pushBack ["backpack", "B", "Backpack", _entries];
};

_panels
