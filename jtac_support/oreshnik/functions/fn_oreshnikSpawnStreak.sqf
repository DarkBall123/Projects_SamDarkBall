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
private _tracerEnabled = _settings getOrDefault ["tracer", true];
private _trailEnabled = _settings getOrDefault ["trail", true];
private _trailLength = (_settings getOrDefault ["trailLength", 260]) max 10;
private _trailDensity = ((_settings getOrDefault ["trailDensity", 1]) max 0.1) min 4;
private _lightScale = (_settings getOrDefault ["lightScale", 1]) max 0;
private _isClusterLead = (_entry getOrDefault ["elementIndex", 0]) == 0;

private _rawStartATL = +_startATL;
private _fullFlightVector = _impactATL vectorDiff _rawStartATL;
private _visibleProgress = 0;
private _visualAltitude = (_settings getOrDefault ["skyVisualAltitude", 2200]) max 300;
private _minVisualDuration = (_settings getOrDefault ["minSkyDuration", 0.85]) max 0.5;
private _verticalTravel = ((_rawStartATL select 2) - (_impactATL select 2)) max 0;

if (_verticalTravel > _visualAltitude) then {
    _visibleProgress = 1 - (_visualAltitude / _verticalTravel);
    _startATL = _rawStartATL vectorAdd (_fullFlightVector vectorMultiply _visibleProgress);
};

_duration = _entry getOrDefault ["visibleDuration", (_duration * ((1 - _visibleProgress) max 0.05)) max _minVisualDuration];

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

private _tracerClass = _settings getOrDefault ["skyTracerClass", "DB_JTAC_Oreshnik_Tracer_White"];
if !(isClass (configFile >> "CfgAmmo" >> _tracerClass)) then {
    _tracerClass = "DB_JTAC_Oreshnik_Tracer_Yellow";
};
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

private _tracer = objNull;
if (_tracerEnabled) then {
    _tracer = _tracerClass createVehicleLocal _startATL;
    if (!isNull _tracer) then {
        _tracer setPosATL _startATL;
        _tracer setVectorDirAndUp [_fallDir, _upDir];
        _tracer setVelocity _velocity;
    };
};

private _light = objNull;
if (_lightScale > 0) then {
    _light = "#lightpoint" createVehicleLocal _startATL;
    _light setPosATL _startATL;
    _light setLightColor [1, 0.97, 0.88];
    _light setLightAmbient [0.38, 0.26, 0.14];
    _light setLightIntensity (720000 * _streakSize * _lightScale);
    _light setLightAttenuation [0, 0, 0, 0.28, 0, 1100, 1800];
    _light setLightUseFlare true;
    _light setLightFlareSize (8 * _streakSize * _lightScale);
    _light setLightFlareMaxDistance 12000;
    _light setLightDayLight true;
};

private _core = objNull;
private _halo = objNull;

if (_trailEnabled) then {
    private _trailLifetime = ((_trailLength / ((vectorMagnitude _velocity) max 1)) max 0.06) min 0.7;
    private _coreLifetime = (_trailLifetime * 0.45) max 0.04;

    _core = "#particlesource" createVehicleLocal _startATL;
    _core attachTo [_anchor, [0, 0, 0]];
    _core setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
        "",
        "Billboard",
        1,
        _coreLifetime,
        [0, 0, 0],
        (_fallDir vectorMultiply -35),
        0,
        1,
        1,
        0,
        [2.8 * _streakSize, 1.9 * _streakSize, 0.4 * _streakSize, 0],
        [
            [1, 1, 1, 1],
            [1, 0.97, 0.82, 0.78],
            [1, 0.68, 0.24, 0]
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
            [140, 136, 120, 1],
            [70, 50, 20, 1],
            [0, 0, 0, 0]
        ]
    ];
    _core setParticleRandom [0.02, [0.18, 0.18, 0.18], [0.8, 0.8, 0.8], 0, 0.12, [0.01, 0.01, 0.01, 0.03], 0, 0, 5, 0];
    _core setDropInterval (0.0025 / _trailDensity);

    _halo = "#particlesource" createVehicleLocal _startATL;
    _halo attachTo [_anchor, [0, 0, 0]];
    _halo setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
        "",
        "Billboard",
        1,
        _trailLifetime,
        [0, 0, 0],
        (_fallDir vectorMultiply -20),
        0,
        1,
        1,
        0,
        [4.8 * _streakSize, 3.1 * _streakSize, 0.8 * _streakSize, 0],
        [
            [1, 0.96, 0.76, 0.46],
            [1, 0.58, 0.16, 0.24],
            [0.72, 0.16, 0.03, 0]
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
            [32, 28, 18, 1],
            [12, 4, 1, 1],
            [0, 0, 0, 0]
        ]
    ];
    _halo setParticleRandom [0.04, [0.32, 0.32, 0.32], [1.6, 1.6, 1.6], 0, 0.25, [0.03, 0.02, 0.01, 0.06], 0, 0, 10, 0];
    _halo setDropInterval (0.004 / _trailDensity);
};

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
    playSound3D ["A3\Sounds_F\weapons\Explosion\supersonic_crack_50meters.wss", objNull, false, ATLToASL _startATL, 1.1 * _flybySoundVolume, random [0.78, 0.9, 1.02], _flybySoundDistance, 0, true];
};

private _startTime = time;
private _endTime = _startTime + _duration;
private _flybySoundPlayed = false;

while {time < _endTime} do {
    private _progress = ((time - _startTime) / _duration) min 1;
    private _posATL = _startATL vectorAdd (_flightVector vectorMultiply _progress);
    private _fade = 1 - _progress;

    _anchor setPosATL _posATL;

    if (!isNull _light) then {
        _light setPosATL _posATL;
        _light setLightIntensity ((320000 + (520000 * _fade)) * _streakSize * _lightScale);
        _light setLightFlareSize ((5 + (5 * _fade)) * _streakSize * _lightScale);
    };

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

if (!isNull _core) then {
    deleteVehicle _core;
};

if (!isNull _halo) then {
    deleteVehicle _halo;
};

if (!isNull _light) then {
    deleteVehicle _light;
};

if (!isNull _flare) then {
    deleteVehicle _flare;
};

if (!isNull _tracer) then {
    deleteVehicle _tracer;
};

deleteVehicle _anchor;

[_entry, _settings] call DB_fnc_oreshnikImpactEffect;

true;
