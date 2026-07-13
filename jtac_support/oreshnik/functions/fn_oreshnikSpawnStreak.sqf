params [
    ["_entry", createHashMap, [createHashMap]],
    ["_settings", createHashMap, [createHashMap]]
];

private _startATL = _entry getOrDefault ["startATL", [0, 0, 15000]];
private _impactATL = _entry getOrDefault ["impactATL", [0, 0, 0]];
private _duration = _entry getOrDefault ["duration", 2.4];
private _streakSize = _entry getOrDefault ["streakSize", 1];
private _debug = _settings getOrDefault ["debug", false];
private _sound = _settings getOrDefault ["sound", true];
private _isClusterLead = (_entry getOrDefault ["elementIndex", 0]) == 0;

private _rawStartATL = +_startATL;
private _fullFlightVector = _impactATL vectorDiff _rawStartATL;
private _visibleProgress = 0;
private _visualAltitude = (_settings getOrDefault ["skyVisualAltitude", 1800]) max 300;
private _minVisualDuration = (_settings getOrDefault ["minSkyDuration", 1.55]) max 0.5;
private _verticalTravel = ((_rawStartATL select 2) - (_impactATL select 2)) max 0;

if (_verticalTravel > _visualAltitude) then {
    _visibleProgress = 1 - (_visualAltitude / _verticalTravel);
    _startATL = _rawStartATL vectorAdd (_fullFlightVector vectorMultiply _visibleProgress);
};

_duration = (_duration * ((1 - _visibleProgress) max 0.05)) max _minVisualDuration;

private _flightVector = _impactATL vectorDiff _startATL;
private _fallDir = vectorNormalized _flightVector;
private _velocity = _flightVector vectorMultiply (1 / _duration);
private _rightDir = _fallDir vectorCrossProduct [0, 0, 1];

if (_rightDir isEqualTo [0, 0, 0]) then {
    _rightDir = [1, 0, 0];
};

_rightDir = vectorNormalized _rightDir;
private _upDir = vectorNormalized (_rightDir vectorCrossProduct _fallDir);

private _flareClass = _settings getOrDefault ["skyFlareClass", "DB_JTAC_Oreshnik_Flare_White"];
if !(isClass (configFile >> "CfgAmmo" >> _flareClass)) then {
    _flareClass = "F_40mm_White";
};

private _tracerClass = _settings getOrDefault ["skyTracerClass", "DB_JTAC_Oreshnik_Tracer_Yellow"];
if !(isClass (configFile >> "CfgAmmo" >> _tracerClass)) then {
    _tracerClass = "B_127x99_Ball_Tracer_Yellow";
};

private _anchor = "#particlesource" createVehicleLocal _startATL;
_anchor setPosATL _startATL;

private _flare = _flareClass createVehicleLocal _startATL;
if (!isNull _flare) then {
    _flare setPosATL _startATL;
    _flare setVelocity _velocity;
};

private _tracer = _tracerClass createVehicleLocal _startATL;
if (!isNull _tracer) then {
    _tracer setPosATL _startATL;
    _tracer setVectorDirAndUp [_fallDir, _upDir];
    _tracer setVelocity _velocity;
};

private _light = "#lightpoint" createVehicleLocal _startATL;
_light setPosATL _startATL;
_light setLightColor [1, 0.92, 0.72];
_light setLightAmbient [0.32, 0.22, 0.12];
_light setLightIntensity (520000 * _streakSize);
_light setLightAttenuation [0, 0, 0, 0.35, 0, 900, 1600];
_light setLightUseFlare true;
_light setLightFlareSize (11 * _streakSize);
_light setLightFlareMaxDistance 12000;
_light setLightDayLight true;

private _trail = "#particlesource" createVehicleLocal _startATL;
_trail attachTo [_anchor, [0, 0, 0]];
_trail setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
    "",
    "Billboard",
    1,
    0.22,
    [0, 0, 0],
    (_fallDir vectorMultiply -105),
    0,
    1,
    1,
    0,
    [1.8 * _streakSize, 0.45 * _streakSize, 0],
    [
        [1, 0.98, 0.86, 0.85],
        [1, 0.72, 0.28, 0.34],
        [1, 0.36, 0.08, 0]
    ],
    [1],
    0,
    0,
    "",
    "",
    _anchor,
    0,
    false,
    -1,
    [
        [24, 20, 12, 1],
        [8, 3, 1, 0]
    ]
];
_trail setParticleRandom [0.04, [0.28, 0.28, 0.28], [1.5, 1.5, 1.5], 0, 0.15, [0.02, 0.02, 0.01, 0.05], 0, 0, 8, 0];
_trail setDropInterval 0.003;

private _flybySound = _settings getOrDefault ["flybySound", "jtac_support\oreshnik\sounds\rok.ogg"];
private _flybySoundProgress = ((_settings getOrDefault ["flybySoundProgress", 0.7]) max 0.2) min 0.95;
private _flybySoundVolume = (_settings getOrDefault ["flybySoundVolume", 1.25]) max 0;
private _flybySoundDistance = (_settings getOrDefault ["flybySoundDistance", 4500]) max 500;

if (_debug) then {
    private _observer = if (isNull cameraOn) then {player} else {cameraOn};

    systemChat format ["oreshnik sky: z %1->%2, observer %3m, duration %4s", round (_startATL select 2), round (_impactATL select 2), round (_startATL distance _observer), _duration toFixed 1];
    diag_log format ["[oreshnik] startATL=%1 impactATL=%2 duration=%3 velocity=%4 flare=%5 tracer=%6 particlesQuality=%7", _startATL, _impactATL, _duration, vectorMagnitude _velocity, _flareClass, _tracerClass, particlesQuality];
};

if (_sound && {_isClusterLead}) then {
    playSound3D ["A3\Sounds_F\weapons\Explosion\supersonic_crack_50meters.wss", objNull, false, ATLToASL _startATL, 1.4, random [0.78, 0.9, 1.02], 3500, 0, true];
};

private _startTime = time;
private _endTime = _startTime + _duration;
private _flybySoundPlayed = false;

while {time < _endTime} do {
    private _progress = ((time - _startTime) / _duration) min 1;
    private _posATL = _startATL vectorAdd (_flightVector vectorMultiply _progress);
    private _fade = 1 - _progress;

    _anchor setPosATL _posATL;
    _light setPosATL _posATL;
    _light setLightIntensity ((240000 + (420000 * _fade)) * _streakSize);
    _light setLightFlareSize ((7 + (7 * _fade)) * _streakSize);

    if (!isNull _flare) then {
        _flare setPosATL _posATL;
        _flare setVelocity _velocity;
    };

    if (!isNull _tracer) then {
        _tracer setPosATL _posATL;
        _tracer setVectorDirAndUp [_fallDir, _upDir];
        _tracer setVelocity _velocity;
    };

    if (_sound && {_isClusterLead} && {!_flybySoundPlayed} && {_progress >= _flybySoundProgress}) then {
        _flybySoundPlayed = true;
        playSound3D [_flybySound, objNull, false, ATLToASL _posATL, _flybySoundVolume * _streakSize, random [0.92, 1, 1.08], _flybySoundDistance, 0, true];
    };

    sleep 0.01;
};

deleteVehicle _trail;
deleteVehicle _light;

if (!isNull _flare) then {
    deleteVehicle _flare;
};

if (!isNull _tracer) then {
    deleteVehicle _tracer;
};

deleteVehicle _anchor;

[_entry, _settings] call DB_fnc_oreshnikImpactEffect;

true;
