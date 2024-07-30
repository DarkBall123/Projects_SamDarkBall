private _uav = cameraOn;
private _positionATL = getPosATLVisual _uav;

// ALT
private _altMainText = uiNameSpace getVariable ["DB_orionHUD_alt_mainText", controlNull];
_altMainText ctrlSetText format ["ВЫС: %1", floor(_uav call CBA_fnc_realHeight)];

// COORDINATES
private _coordMainText = uiNameSpace getVariable ["DB_orionHUD_coord_mainText", controlNull];
_coordMainText ctrlSetText format ["КВАДРАТ: %1 %2", floor((_positionATL # 0) / 100), floor((_positionATL # 1) / 100)];

// FUEL
private _fuelMainText = uiNameSpace getVariable ["DB_orionHUD_fuel_mainText", controlNull];
_fuelMainText ctrlSetText format ["ТОПЛИВО: %1", floor (fuel _uav * 100)];

// STATUS
private _statusMainText = uiNameSpace getVariable ["DB_orionHUD_status_mainText", controlNull];
_statusMainText ctrlSetText format ["СОСТОЯНИЕ: %1", ["УПРАВЛЯЕМЫЙ", "ПОВРЕЖДЕН"] select (damage _uav >= 0.33)];


// DRONE SPEED
private _droneSpeedMainText = uiNameSpace getVariable ["DB_orionHUD_droneSpeed_mainText", controlNull];
_droneSpeedMainText ctrlSetText format ["СКОРОСТЬ: %1 КМ/Ч", (floor speed _uav)];

// PITCH
private _pitchMainText = uiNameSpace getVariable ["DB_orionHUD_pitch_mainText", controlNull];
_pitchMainText ctrlSetText format ["ТАНГАЖ: %1 °", floor((_uav call BIS_fnc_getPitchBank) # 0)];