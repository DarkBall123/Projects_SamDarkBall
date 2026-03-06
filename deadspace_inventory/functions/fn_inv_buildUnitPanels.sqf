params ["_unit"];

private _panels = [];

private _uniformClass = uniform _unit;
if !(_uniformClass isEqualTo "") then {
    private _entries = [uniformItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    private _info = [_uniformClass] call DB_dsi_fnc_inv_getClassData;
    _panels pushBack ["uniform", _info # 0, _info # 1, _entries];
};

private _vestClass = vest _unit;
if !(_vestClass isEqualTo "") then {
    private _entries = [vestItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    private _info = [_vestClass] call DB_dsi_fnc_inv_getClassData;
    _panels pushBack ["vest", _info # 0, _info # 1, _entries];
};

private _backpackClass = backpack _unit;
if !(_backpackClass isEqualTo "") then {
    private _entries = [backpackItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    private _info = [_backpackClass] call DB_dsi_fnc_inv_getClassData;
    _panels pushBack ["backpack", _info # 0, _info # 1, _entries];
};

_panels
