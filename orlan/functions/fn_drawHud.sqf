private _uav = cameraOn;
private _positionATL = getPosATLVisual _uav;

// CURSOR ANGLE VERTICAL MOVEMENT
private _cursorPicture = uiNameSpace getVariable ["DB_orlanHUD_angle_cursorPicture", controlNull];
private _cursorMaxH = (ctrlPosition (ctrlParentControlsGroup _cursorPicture)) # 3;
private _turretY = ([_uav, [0], true] call CBA_fnc_turretDir) # 1;
private _minElev = getNumber (configFile >> "CfgVehicles" >> typeOf _uav >> "Turrets" >> "MainTurret" >> "minElev");
private _maxElev = getNumber (configFile >> "CfgVehicles" >> typeOf _uav >> "Turrets" >> "MainTurret" >> "maxElev");

_cursorPicture ctrlSetPositionY (linearConversion [_maxElev, _minElev, _turretY, 0, _cursorMaxH - ((ctrlPosition _cursorPicture) # 3), true]);
_cursorPicture ctrlCommit 0.0;

// CURSOR ANGLE TEXT
private _cursorMainText = uiNameSpace getVariable ["DB_orlanHUD_angle_mainText", controlNull];
_cursorMainText ctrlSetText (str(round _turretY));

// ALT
private _altMainText = uiNameSpace getVariable ["DB_orlanHUD_alt_mainText", controlNull];
_altMainText ctrlSetText format ["ВЫС: %1", floor(_uav call CBA_fnc_realHeight)];

// COORDINATES
private _coordMainText = uiNameSpace getVariable ["DB_orlanHUD_coord_mainText", controlNull];
_coordMainText ctrlSetText format ["КВАДРАТ: %1 %2", floor((_positionATL # 0) / 100), floor((_positionATL # 1) / 100)];

// FUEL
private _fuelMainText = uiNameSpace getVariable ["DB_orlanHUD_fuel_mainText", controlNull];
_fuelMainText ctrlSetText format ["ТОПЛИВО: %1", floor (fuel _uav * 100)];

// LASER
private _laserMainText = uiNameSpace getVariable ["DB_orlanHUD_laser_mainText", controlNull];
_laserMainText ctrlSetText format ["ЛЦУ: %1", ["ВЫКЛ", "ВКЛ"] select (isLaserOn _uav)];

// STATUS
private _statusMainText = uiNameSpace getVariable ["DB_orlanHUD_status_mainText", controlNull];
_statusMainText ctrlSetText format ["СОСТОЯНИЕ: %1", ["УПРАВЛЯЕМЫЙ", "ПОВРЕЖДЕН"] select (damage _uav >= 0.33)];

// DIRECTION
private _directionPicture = uiNameSpace getVariable ["DB_orlanHUD_direction_picture", controlNull];
private _directionMainText = uiNameSpace getVariable ["DB_orlanHUD_direction_mainText", controlNull];
private _picture = "";
private _direction = getDirVisual _uav;
private _laserTarget = laserTarget _uav;

switch (true) do {
	case ((_direction >= 0) and (_direction < 30)):    { _picture = "\orlan\pictures\12.paa" };
	case ((_direction >= 30) and (_direction < 60)):   { _picture = "\orlan\pictures\1.paa" };
	case ((_direction >= 60) and (_direction < 90)):   { _picture = "\orlan\pictures\2.paa" };
	case ((_direction >= 90) and (_direction < 120)):  { _picture = "\orlan\pictures\3.paa" };
	case ((_direction >= 120) and (_direction < 150)): { _picture = "\orlan\pictures\4.paa" };
	case ((_direction >= 150) and (_direction < 180)): { _picture = "\orlan\pictures\5.paa" };
	case ((_direction >= 180) and (_direction < 210)): { _picture = "\orlan\pictures\6.paa"  };
	case ((_direction >= 210) and (_direction < 240)): { _picture = "\orlan\pictures\7.paa" };
	case ((_direction >= 240) and (_direction < 270)): { _picture = "\orlan\pictures\8.paa" };
	case ((_direction >= 270) and (_direction < 300)): { _picture = "\orlan\pictures\9.paa" };
	case ((_direction >= 300) and (_direction < 330)): { _picture = "\orlan\pictures\10.paa" };
	case ((_direction >= 330) and (_direction < 360)): { _picture = "\orlan\pictures\11.paa" };
	default { };
};

_directionPicture ctrlSetText _picture;
_directionMainText ctrlSetText str(floor _direction);

// LASER DISTANCE
private _laserDistanceMainText = uiNameSpace getVariable ["DB_orlanHUD_laserDistance_mainText", controlNull];
_laserDistanceMainText ctrlSetText format ["%1", ["ВЫКЛ", format["%1 м.", floor(_uav distance _laserTarget)]] select !(isNull _laserTarget)];


// DRONE SPEED
private _droneSpeedMainText = uiNameSpace getVariable ["DB_orlanHUD_droneSpeed_mainText", controlNull];
_droneSpeedMainText ctrlSetText format ["СКОРОСТЬ: %1 КМ/Ч", (floor speed _uav)];

// PITCH
private _pitchMainText = uiNameSpace getVariable ["DB_orlanHUD_pitch_mainText", controlNull];
_pitchMainText ctrlSetText format ["ТАНГАЖ: %1 °", floor((_uav call BIS_fnc_getPitchBank) # 0)];

// FOV
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

// OTHER
call orlan_fnc_drawCompass;