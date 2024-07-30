#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

private _uav = cameraOn;

// DATE
private _dateControls = uiNameSpace getVariable ["DB_Ak607_date_UI", controlNull];
private _textControl = _dateControls controlsGroupCtrl 101;
private _date = date;
private _time = [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString;

_textControl ctrlSetStructuredText parseText format ["<t align='left'>%1-%2-%3</t><t align='right'>%4</t>", _date # 2, _date # 1, _date # 0, _time];

// WEAPON INFO
private _weaponInfoControls = uiNameSpace getVariable ["DB_Ak607_weaponInfo_UI", controlNull];
private _textControl = _weaponInfoControls controlsGroupCtrl 101;

([_uav, [0]] call CBA_fnc_turretDir) params ["_xDir", "_yDir"];

private _xDirText = format ["%1=%2°", localize "STR_AK603_CA", _xDir toFixed 2];
private _yDirText = format ["%1=%2°", localize "STR_AK603_EA", _yDir toFixed 2];
private _distanceText = format ["%1=%2", localize "STR_AK603_D", floor(_uav distance (screenToWorld [0.5, 0.5]))];

_textControl ctrlSetStructuredText parseText format ["<t align='left'>%1</t><t align='center'>%2</t><t align='right'>%3</t>", _xDirText, _yDirText, _distanceText];

// AMMO INFO
private _ammoInfoControls = uiNameSpace getVariable ["DB_Ak607_AmmoInfo_UI", controlNull];
private _textControl = _ammoInfoControls controlsGroupCtrl 101;

private _weapon = currentWeapon _uav;
private _magazine = currentMagazine _uav;
private _ammo = _uav magazineTurretAmmo [_magazine, [0]];
private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");

_textControl ctrlSetStructuredText parseText format ["<t align='left'>%1:</t><t align='right'>%2</t>", _weaponName, _ammo];