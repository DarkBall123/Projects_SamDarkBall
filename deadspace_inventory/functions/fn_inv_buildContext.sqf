params [["_source", objNull, [objNull]]];

if (isNull _source) exitWith { [] };

private _sourceInfo = [typeOf _source] call DB_dsi_fnc_inv_getClassData;
private _sourceIcon = _sourceInfo # 0;
private _sourceLabel = _sourceInfo # 1;
private _gearIcon = "\a3\ui_f\data\igui\cfg\actions\gear_ca.paa";
private _isTexturePath = {
    params ["_value"];

    if (_value isEqualTo "") exitWith { false };

    private _normalized = toLowerANSI _value;

    (_normalized find "#(") isEqualTo 0 ||
    {(_normalized find "\") >= 0} ||
    {(_normalized find "/") >= 0} ||
    {(_normalized find ".paa") >= 0} ||
    {(_normalized find ".pac") >= 0} ||
    {(_normalized find ".jpg") >= 0} ||
    {(_normalized find ".jpeg") >= 0}
};

if (_source isKindOf "CAManBase") then {
    private _unitName = name _source;
    if !(_unitName isEqualTo "") then {
        _sourceLabel = _unitName;
    };
};

private _panels = if (_source isKindOf "CAManBase") then {
    [_source] call DB_dsi_fnc_inv_buildUnitPanels
} else {
    if (_source isKindOf "AllVehicles") then {
        [_source] call DB_dsi_fnc_inv_buildVehiclePanels
    } else {
        [_source] call DB_dsi_fnc_inv_buildCargoPanel
    };
};

if (_panels isEqualTo []) exitWith { [] };

if !([_sourceIcon] call _isTexturePath) then {
    if (_source isKindOf "CAManBase") then {
        _sourceIcon = _gearIcon;
    } else {
        private _primaryPanel = _panels param [0, []];
        private _panelEntries = _primaryPanel param [3, []];

        if !(_panelEntries isEqualTo []) then {
            _sourceIcon = (_panelEntries # 0) param [3, _gearIcon];
        } else {
            _sourceIcon = _gearIcon;
        };
    };
} else {
    if ((_sourceIcon find "#(") isEqualTo 0) then {
        if (_source isKindOf "CAManBase") then {
            _sourceIcon = _gearIcon;
        } else {
            private _primaryPanel = _panels param [0, []];
            private _panelEntries = _primaryPanel param [3, []];

            if !(_panelEntries isEqualTo []) then {
                _sourceIcon = (_panelEntries # 0) param [3, _gearIcon];
            } else {
                _sourceIcon = _gearIcon;
            };
        };
    };
};

[_source, _source, _sourceIcon, _sourceLabel, _panels]
