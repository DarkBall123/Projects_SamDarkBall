params [["_className", "", [""]]];

private _cfg = configNull;
private _icon = "";
private _label = _className;

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

    private _displayName = getText (_cfg >> "displayName");
    if !(_displayName isEqualTo "") then {
        _label = _displayName;
    };
};

if (_icon isEqualTo "") then {
    _icon = "#(argb,8,8,3)color(1,1,1,1)";
};

[_icon, _label]
