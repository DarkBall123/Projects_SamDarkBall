params [["_source", objNull, [objNull]]];

if (isNull _source) exitWith { [] };

private _sourceInfo = [typeOf _source] call DB_dsi_fnc_inv_getClassData;
private _sourceIcon = _sourceInfo # 0;
private _sourceLabel = _sourceInfo # 1;

if (_source isKindOf "CAManBase") then {
    private _unitName = name _source;
    if !(_unitName isEqualTo "") then {
        _sourceLabel = _unitName;
    };
};

private _panels = if (_source isKindOf "CAManBase") then {
    [_source] call DB_dsi_fnc_inv_buildUnitPanels
} else {
    [_source] call DB_dsi_fnc_inv_buildCargoPanel
};

if (_panels isEqualTo []) exitWith { [] };

[_source, _source, _sourceIcon, _sourceLabel, _panels]
