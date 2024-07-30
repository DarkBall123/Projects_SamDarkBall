private _uav = cameraOn;
private _positionATL = getPosATLVisual _uav;

// SQUARE X
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_squareX_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2</t>", localize "STR_zala421_squareX", floor((_positionATL # 0) / 100)];

// SQUARE Y
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_squareY_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2</t>", localize "STR_zala421_squareY", floor((_positionATL # 1) / 100)];

// LASER
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_laser_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2</t>", localize "STR_zala421_laser", [localize "STR_zala421_off", localize "STR_zala421_on"] select (isLaserOn _uav)];

// HEIGHT
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_height_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2</t>", localize "STR_zala421_altitude", floor(_uav call CBA_fnc_realHeight)];

// SPEED
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_speed_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2</t>", localize "STR_zala421_speed", floor(speed _uav)];

// DIRECTION
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_direction_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;
private _direction = getDirVisual _uav;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2</t>", localize "STR_zala421_course", floor _direction];

// TEMPERATURE
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_temperature_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;

_text ctrlSetStructuredText parseText format ["%1: <t align='right'>%2°C</t>", localize "STR_zala421_t", floor(ambientTemperature # 0)];

// DATE
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_date_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;
private _date = date;

_text ctrlSetText format ["%1/%2/%3", _date # 2, _date # 1, _date # 0];

// TIME
private _controlsGroup = uiNameSpace getVariable ["DB_zala421_time_HUD", controlNull];
private _text = _controlsGroup controlsGroupCtrl 101;
private _time = [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString;

_text ctrlSetText _time;

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
call zala421_fnc_drawCompass;