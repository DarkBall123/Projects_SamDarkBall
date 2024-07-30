#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

private _uav = cameraOn;
private _laserTarget = laserTarget _uav;
private _positionATL = getPosATLVisual _uav;

// EFFECTS
private _uavFOV = getObjectFOV _uav;

"DynamicBlur" ppEffectEnable false;
"filmGrain" ppEffectEnable false;
"ColorCorrections" ppEffectEnable false;

switch true do {

    case (_uavFOV >= 0.0124 && _uavFOV <= 0.0126): {
        "DynamicBlur" ppEffectEnable true;
        "filmGrain" ppEffectEnable true;
		"ColorCorrections" ppEffectEnable true;
        "filmGrain" ppEffectAdjust [0.09,0.2,3.96,0.12,0.12,true];
        "filmGrain" ppEffectCommit 0; 
        "DynamicBlur" ppEffectAdjust [1.2];
        "DynamicBlur" ppEffectCommit 0;
		"ColorCorrections" ppEffectAdjust [1.13,0.99,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
        "ColorCorrections" ppEffectCommit 0;
    };

    case (_uavFOV >= 0.024 && _uavFOV <= 0.026): {
        "DynamicBlur" ppEffectEnable true;
        "filmGrain" ppEffectEnable true;
		"ColorCorrections" ppEffectEnable true;
		"DynamicBlur" ppEffectAdjust [0.6];
		"DynamicBlur" ppEffectCommit 0;
		"filmGrain" ppEffectAdjust [0.06,0.2,3.96,0.12,0.12,true];
		"filmGrain" ppEffectCommit 0;
		"ColorCorrections" ppEffectAdjust [1.13,0.99,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
		"ColorCorrections" ppEffectCommit 0;
		
    };
    
    case (_uavFOV >= 0.04 && _uavFOV <= 0.06): {
        "DynamicBlur" ppEffectEnable true;
        "filmGrain" ppEffectEnable true;
		"ColorCorrections" ppEffectEnable true;
		"filmGrain" ppEffectAdjust [0.04,0.2,3.96,0.12,0.12,true];
		"filmGrain" ppEffectCommit 0;
		"DynamicBlur" ppEffectAdjust [0.45];
		"DynamicBlur" ppEffectCommit 0;
		"ColorCorrections" ppEffectAdjust [1.13,0.99,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
		"ColorCorrections" ppEffectCommit 0;
    };
	
	case (_uavFOV >= 0.04 && _uavFOV <= 0.03): {
        "DynamicBlur" ppEffectEnable true;
        "filmGrain" ppEffectEnable true;
		"ColorCorrections" ppEffectEnable true;
		"filmGrain" ppEffectAdjust [0.02,0.2,3.96,0.12,0.12,true];
		"filmGrain" ppEffectCommit 0;
		"DynamicBlur" ppEffectAdjust [0.4];
		"DynamicBlur" ppEffectCommit 0;
		"ColorCorrections" ppEffectAdjust [1.13,0.99,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
		"ColorCorrections" ppEffectCommit 0;
    };
	
	case (_uavFOV >= 0.09 && _uavFOV <= 0.11): {
        "DynamicBlur" ppEffectEnable true;
        "filmGrain" ppEffectEnable true;
		"ColorCorrections" ppEffectEnable true;
		"filmGrain" ppEffectAdjust [0.02,0.2,3.96,0.12,0.12,true];
		"filmGrain" ppEffectCommit 0; 
		"DynamicBlur" ppEffectAdjust [0.2];
		"DynamicBlur" ppEffectCommit 0;
		"ColorCorrections" ppEffectAdjust [1.13,0.99,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
		"ColorCorrections" ppEffectCommit 0;
    };
	
	case (_uavFOV >= 0.74 && _uavFOV <= 0.76): {
        "DynamicBlur" ppEffectEnable true;
        "filmGrain" ppEffectEnable true;
		"ColorCorrections" ppEffectEnable true;
		"filmGrain" ppEffectAdjust [0.02,0.2,3.96,0.12,0.12,true];
		"filmGrain" ppEffectCommit 0; 
		"DynamicBlur" ppEffectAdjust [0.2];
		"DynamicBlur" ppEffectCommit 0;
		"ColorCorrections" ppEffectAdjust [1.13,0.99,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
		"ColorCorrections" ppEffectCommit 0;
    };
};

// CURSOR HORIZONTAL MOVEMENT
private _cursorHorizontalPicture = uiNameSpace getVariable ["DB_orionHUD_horDirectionCursor", controlNull];
private _cursorVerticalPicture = uiNameSpace getVariable ["DB_orionHUD_verAngleCursor", controlNull];

private _cursorMaxW = (ctrlPosition (ctrlParentControlsGroup _cursorHorizontalPicture)) # 2;
private _cursorMaxH = (ctrlPosition (ctrlParentControlsGroup _cursorVerticalPicture)) # 3;

private _turretX = ([_uav, [0], true] call CBA_fnc_turretDir) # 0;
private _turretY = ([_uav, [0], true] call CBA_fnc_turretDir) # 1;

private _minElev = getNumber (configFile >> "CfgVehicles" >> typeOf _uav >> "Turrets" >> "MainTurret" >> "minElev");
private _maxElev = getNumber (configFile >> "CfgVehicles" >> typeOf _uav >> "Turrets" >> "MainTurret" >> "maxElev");

private _normalizedX = [_turretX, _turretX - 360] select (_turretX > 180);

_cursorHorizontalPicture ctrlSetPositionX (linearConversion [-180, 180, _normalizedX, 0 + GRID_W(0.6), _cursorMaxW - GRID_W(0.6), true]);
_cursorHorizontalPicture ctrlCommit 0.0;

_cursorVerticalPicture ctrlSetPositionY (linearConversion [_maxElev, _minElev, _turretY, 0 + GRID_H(0.65), _cursorMaxH - GRID_H(0.65), true]);
_cursorVerticalPicture ctrlCommit 0.0;

// DIRECTION
private _cameraDirectionCtrl = uiNameSpace getVariable ["DB_orionHUD_CameraDirectionLine", controlNull];
private _uavDirectionCtrl = uiNameSpace getVariable ["DB_orionHUD_UavDirectionLine", controlNull];

private _pictureUAV = "";
private _directionUAV = getDirVisual _uav;

// UAV
switch (true) do {
	case ((_directionUAV >= 0) and (_directionUAV < 30)):    { _pictureUAV = "\orion\pictures\display\trio\12.paa" };
	case ((_directionUAV >= 30) and (_directionUAV < 60)):   { _pictureUAV = "\orion\pictures\display\trio\1.paa" };
	case ((_directionUAV >= 60) and (_directionUAV < 90)):   { _pictureUAV = "\orion\pictures\display\trio\2.paa" };
	case ((_directionUAV >= 90) and (_directionUAV < 120)):  { _pictureUAV = "\orion\pictures\display\trio\3.paa" };
	case ((_directionUAV >= 120) and (_directionUAV < 150)): { _pictureUAV = "\orion\pictures\display\trio\4.paa" };
	case ((_directionUAV >= 150) and (_directionUAV < 180)): { _pictureUAV = "\orion\pictures\display\trio\5.paa" };
	case ((_directionUAV >= 180) and (_directionUAV < 210)): { _pictureUAV = "\orion\pictures\display\trio\6.paa"  };
	case ((_directionUAV >= 210) and (_directionUAV < 240)): { _pictureUAV = "\orion\pictures\display\trio\7.paa" };
	case ((_directionUAV >= 240) and (_directionUAV < 270)): { _pictureUAV = "\orion\pictures\display\trio\8.paa" };
	case ((_directionUAV >= 270) and (_directionUAV < 300)): { _pictureUAV = "\orion\pictures\display\trio\9.paa" };
	case ((_directionUAV >= 300) and (_directionUAV < 330)): { _pictureUAV = "\orion\pictures\display\trio\10.paa" };
	case ((_directionUAV >= 330) and (_directionUAV < 360)): { _pictureUAV = "\orion\pictures\display\trio\11.paa" };
	default { };
};

// CAMERA
private _pictureCamera = "";
private _directionCamera = ([_uav, [0], true] call CBA_fnc_turretDir) # 0;

switch (true) do {
	case ((_directionCamera >= 0) and (_directionCamera < 30)):    { _pictureCamera = "\orion\pictures\display\line\12.paa" };
	case ((_directionCamera >= 30) and (_directionCamera < 60)):   { _pictureCamera = "\orion\pictures\display\line\1.paa" };
	case ((_directionCamera >= 60) and (_directionCamera < 90)):   { _pictureCamera = "\orion\pictures\display\line\2.paa" };
	case ((_directionCamera >= 90) and (_directionCamera < 120)):  { _pictureCamera = "\orion\pictures\display\line\3.paa" };
	case ((_directionCamera >= 120) and (_directionCamera < 150)): { _pictureCamera = "\orion\pictures\display\line\4.paa" };
	case ((_directionCamera >= 150) and (_directionCamera < 180)): { _pictureCamera = "\orion\pictures\display\line\5.paa" };
	case ((_directionCamera >= 180) and (_directionCamera < 210)): { _pictureCamera = "\orion\pictures\display\line\6.paa"  };
	case ((_directionCamera >= 210) and (_directionCamera < 240)): { _pictureCamera = "\orion\pictures\display\line\7.paa" };
	case ((_directionCamera >= 240) and (_directionCamera < 270)): { _pictureCamera = "\orion\pictures\display\line\8.paa" };
	case ((_directionCamera >= 270) and (_directionCamera < 300)): { _pictureCamera = "\orion\pictures\display\line\9.paa" };
	case ((_directionCamera >= 300) and (_directionCamera < 330)): { _pictureCamera = "\orion\pictures\display\line\10.paa" };
	case ((_directionCamera >= 330) and (_directionCamera < 360)): { _pictureCamera = "\orion\pictures\display\line\11.paa" };
	default { };
};

_cameraDirectionCtrl ctrlSetText _pictureCamera;
_uavDirectionCtrl ctrlSetText _pictureUAV;

// ZOOM
private _zoomControl = uiNameSpace getVariable ["DB_orionHUD_scaleFactor", controlNull];
private _height = floor (_uav call CBA_fnc_realHeight);
 
private _scaleFactor = round(2 * tan(deg(_uavFov) / 2) * _height);

_zoomControl ctrlSetText format ["%1 %2", _scaleFactor, localize "STR_orion_meters"];

// LASER
private _laserText = uiNameSpace getVariable ["DB_orionHUD_laserText", controlNull];
private _laserDistance = 0.0;
_laserText ctrlSetText "";

if (!isNull _laserTarget) then {
	_laserDistance = floor(_uav distance _laserTarget);
	_laserText ctrlSetStructuredText parseText format ["ЛД<br/>%1 м", _laserDistance];
};

// WEAPON HUD
private _weaponText = uiNameSpace getVariable ["DB_orionHUD_weaponText", controlNull];
private _currentAmmo = [];

{
    private _itemName = _x select 0;
    private _itemCount = _x select 1;
    private _found = false;
    
    {
        if ((_x # 0) == _itemName) then {
            _x set [1, (_x select 1) + _itemCount];
            _found = true;
        };
    } forEach _currentAmmo;
    
    if (!_found) then {
        _currentAmmo pushBack [_itemName, _itemCount];
    };
} forEach magazinesAmmo _uav;

private _index = _currentAmmo findIf { (currentMagazine _uav) in _x };
private _ammo = 0;

if (_index != -1) then {
	_ammo = (_currentAmmo # _index) # 1;
};

_weaponText ctrlSetText format ["%1     %2", (configFile >> "CfgWeapons" >> currentWeapon _uav >> "displayName") call BIS_fnc_getCfgData, _ammo];


// LAUNCH ACCESS
private _launchPicture = uiNameSpace getVariable ["DB_orionHUD_launchAccessPicture", controlNull];
private _directionDiff = ((_directionUAV - (([_uav, [0], false] call CBA_fnc_turretDir) # 0) + 360) % 360 + 180) % 360 - 180; 

private _currentMagazine = currentMagazine _uav;
private _currentAmmo = (configFile >> "CfgMagazines" >> _currentMagazine >> "ammo") call BIS_fnc_getCfgData;
private _angle = (configFile >> "cfgAmmo" >> _currentAmmo >> "missileManualControlCone") call BIS_fnc_getCfgData;

if (isNil "_angle") then { _angle = 90 };

_launchPicture ctrlSetText "";

if ((abs(_directionDiff) <= _angle) && {!isNull _laserTarget && { _laserDistance <= 8000 }}) then {
    _launchPicture ctrlSetText "\orion\pictures\display\weapons\PR.paa";
};

