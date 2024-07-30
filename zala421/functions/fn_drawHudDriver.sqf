private _uav = cameraOn;
private _positionATL = getPosATLVisual _uav;

// ALT
private _altMainText = uiNameSpace getVariable ["DB_zala421_HUD_alt_mainText", controlNull];
_altMainText ctrlSetText format ["%1: %2", localize "STR_zala421_altitude", floor(_uav call CBA_fnc_realHeight)];

// COORDINATES
private _coordMainText = uiNameSpace getVariable ["DB_zala421_HUD_coord_mainText", controlNull];
_coordMainText ctrlSetText format ["%1: %2 %3", localize "STR_zala421_square", floor((_positionATL # 0) / 100), floor((_positionATL # 1) / 100)];

// FUEL
private _fuelMainText = uiNameSpace getVariable ["DB_zala421_HUD_fuel_mainText", controlNull];
_fuelMainText ctrlSetText format ["%1: %2", localize "STR_zala421_fuel", floor (fuel _uav * 100)];

// STATUS
private _statusMainText = uiNameSpace getVariable ["DB_zala421_HUD_status_mainText", controlNull];
_statusMainText ctrlSetText format ["%1: %2", localize "STR_zala421_condition", [localize "STR_zala421_controllable", localize "STR_zala421_damaged"] select (damage _uav >= 0.33)];


// DRONE SPEED
private _droneSpeedMainText = uiNameSpace getVariable ["DB_zala421_HUD_droneSpeed_mainText", controlNull];
_droneSpeedMainText ctrlSetText format ["%1: %2 KM/H", localize "STR_zala421_speed", (floor speed _uav)];

// PITCH
private _pitchMainText = uiNameSpace getVariable ["DB_zala421_HUD_pitch_mainText", controlNull];
_pitchMainText ctrlSetText format ["%1: %2 °", localize "STR_zala421_pitch", floor((_uav call BIS_fnc_getPitchBank) # 0)];