params [["_className", "", [""]]];

private _cfg = configNull;
private _icon = "";
private _label = _className;
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

private _cfgWeapon = configFile >> "CfgWeapons" >> _className;
private _cfgMagazine = configFile >> "CfgMagazines" >> _className;
private _cfgVehicle = configFile >> "CfgVehicles" >> _className;

if (isClass _cfgWeapon) then {
    _cfg = _cfgWeapon;
};

if (isClass _cfgMagazine) then {
    _cfg = _cfgMagazine;
};

if (isClass _cfgVehicle) then {
    _cfg = _cfgVehicle;
};

if (isClass _cfg) then {
    _icon = getText (_cfg >> "picture");
    if (_icon isEqualTo "") then {
        _icon = getText (_cfg >> "icon");
    };

    if !([_icon] call _isTexturePath) then {
        _icon = "";
    };

    private _displayName = getText (_cfg >> "displayName");
    if !(_displayName isEqualTo "") then {
        _label = _displayName;
    };
};

if (_icon isEqualTo "") then {
    _icon = "#(argb,8,8,3)color(1,1,1,1)";
};

[_icon, _label]
