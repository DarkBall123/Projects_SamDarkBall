params ["_unit"];

private _panels = [];

private _uniformClass = uniform _unit;
if !(_uniformClass isEqualTo "") then {
    private _entries = [uniformItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    private _info = [_uniformClass] call DB_dsi_fnc_inv_getClassData;
    private _icon = _info # 0;
    if ((_icon find "#(") isEqualTo 0) then {
        _icon = "\a3\ui_f\data\igui\cfg\actions\gear_ca.paa";
    };

    _panels pushBack ["uniform", _icon, "Uniform", _entries];
};

private _vestClass = vest _unit;
if !(_vestClass isEqualTo "") then {
    private _entries = [vestItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    private _info = [_vestClass] call DB_dsi_fnc_inv_getClassData;
    private _icon = _info # 0;
    if ((_icon find "#(") isEqualTo 0) then {
        _icon = "\a3\ui_f\data\igui\cfg\actions\gear_ca.paa";
    };

    _panels pushBack ["vest", _icon, "Vest", _entries];
};

private _backpackClass = backpack _unit;
if !(_backpackClass isEqualTo "") then {
    private _entries = [backpackItems _unit, "item"] call DB_dsi_fnc_inv_stackList;
    private _info = [_backpackClass] call DB_dsi_fnc_inv_getClassData;
    private _icon = _info # 0;
    if ((_icon find "#(") isEqualTo 0) then {
        _icon = "\A3\Weapons_F\Ammoboxes\Bags\data\UI\backpack_CA.paa";
    };

    _panels pushBack ["backpack", _icon, "Backpack", _entries];
};

_panels
