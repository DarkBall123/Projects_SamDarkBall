params [
    ["_entry", createHashMap, [createHashMap]],
    ["_settings", createHashMap, [createHashMap]]
];

private _startATL = _entry getOrDefault ["startATL", [0, 0, 1000]];
private _impactATL = _entry getOrDefault ["impactATL", [0, 0, 0]];
private _duration = _entry getOrDefault ["duration", 2.4];
private _fallDir = vectorNormalized (_entry getOrDefault ["fallDir", [0, 0, -1]]);
private _streakSize = _entry getOrDefault ["streakSize", 1];
private _debug = _settings getOrDefault ["debug", false];
private _sound = _settings getOrDefault ["sound", true];
private _isClusterLead = (_entry getOrDefault ["elementIndex", 0]) == 0;

private _rawStartATL = +_startATL;
private _fullFlightVector = _impactATL vectorDiff _rawStartATL;
private _visibleProgress = 0;
private _visualAltitude = (_settings getOrDefault ["skyVisualAltitude", 650]) max 150;
private _visualDistance = (_settings getOrDefault ["skyVisualDistance", 1200]) max 250;
private _minVisualDuration = (_settings getOrDefault ["minSkyDuration", 1.35]) max 0.25;

private _rawStartZ = _rawStartATL select 2;
private _impactZ = _impactATL select 2;
private _verticalTravel = (_rawStartZ - _impactZ) max 0;

if (_verticalTravel > _visualAltitude) then {
    _visibleProgress = 1 - (_visualAltitude / _verticalTravel);
};

private _observer = player;
if (!isNull cameraOn) then {
    _observer = cameraOn;
};

private _foundVisibleStart = false;
for "_clipIndex" from 0 to 24 do {
    if (!_foundVisibleStart) then {
        private _candidateProgress = _visibleProgress max (_clipIndex / 24);
        private _candidateATL = _rawStartATL vectorAdd (_fullFlightVector vectorMultiply _candidateProgress);
        private _candidateDistance = _candidateATL distance _observer;

        if ((_candidateDistance <= _visualDistance) || {_clipIndex == 24}) then {
            _visibleProgress = _candidateProgress;
            _startATL = _candidateATL;
            _foundVisibleStart = true;
        };
    };
};

_duration = (_duration * ((1 - _visibleProgress) max 0.05)) max _minVisualDuration;
_fallDir = vectorNormalized (_impactATL vectorDiff _startATL);

private _tailLength = _settings getOrDefault ["skyTailLength", 130];
_tailLength = _tailLength min ((_startATL distance _impactATL) * 0.58);
private _tailCount = round (_settings getOrDefault ["skyTailLights", 9]);
_tailCount = (_tailCount max 4) min 14;

private _rightDir = _fallDir vectorCrossProduct [0, 0, 1];
if (_rightDir isEqualTo [0, 0, 0]) then {
    _rightDir = [1, 0, 0];
};
_rightDir = vectorNormalized _rightDir;
private _upDir = vectorNormalized (_rightDir vectorCrossProduct _fallDir);

private _tracerLayer = _settings getOrDefault ["skyTracerLayer", true];
private _tracerClass = _settings getOrDefault ["skyTracerClass", "SDB_oreshnik_Tracer_Yellow"];
if !(isClass (configFile >> "CfgAmmo" >> _tracerClass)) then {
    _tracerClass = "B_127x99_Ball_Tracer_Yellow";
};
if !(isClass (configFile >> "CfgAmmo" >> _tracerClass)) then {
    _tracerLayer = false;
};

private _tracerInterval = (_settings getOrDefault ["skyTracerInterval", 0.14]) max 0.05;
private _tracerSpeed = (_settings getOrDefault ["skyTracerSpeed", 720]) max 120;
private _tracerTTL = (_settings getOrDefault ["skyTracerTTL", 0.72]) max 0.1;
private _tracerObjects = [];

if (_debug) then {
    systemChat format ["oreshnik sky: z %1->%2, dist %3m, dur %4s, tracer %5", round (_startATL select 2), round (_impactATL select 2), round (_startATL distance _observer), _duration toFixed 1, _tracerClass];
    diag_log format ["[oreshnik] spawnStreak rawStartATL=%1 visualStartATL=%2 impactATL=%3 visibleProgress=%4 duration=%5 tracerLayer=%6 tracerClass=%7 particlesQuality=%8", _rawStartATL, _startATL, _impactATL, _visibleProgress, _duration, _tracerLayer, _tracerClass, particlesQuality];
};

private _body = "Sign_Sphere100cm_F" createVehicleLocal _startATL;
_body setPosATL _startATL;
_body setVectorDirAndUp [_fallDir, _upDir];
_body setObjectScale (1.15 * _streakSize);
_body setObjectTexture [0, "#(rgb,8,8,3)color(1,0.86,0.38,1)"];
_body enableSimulation false;

private _headLight = "#lightpoint" createVehicleLocal _startATL;
_headLight lightAttachObject [_body, [0, 0, 0]];
_headLight setLightColor [1, 0.9, 0.5];
_headLight setLightAmbient [1, 0.36, 0.14];
_headLight setLightBrightness (140 * _streakSize);
_headLight setLightIntensity (1450000 * _streakSize);
_headLight setLightAttenuation [0, 0, 0, 0.18, 0, 1200, 1800];
_headLight setLightUseFlare true;
_headLight setLightFlareSize (34 * _streakSize);
_headLight setLightFlareMaxDistance 7500;
_headLight setLightDayLight true;

private _core = "#particlesource" createVehicleLocal _startATL;
_core attachTo [_body, [0, 0, 0]];
_core setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
    "",
    "Billboard",
    1,
    0.15,
    [0, 0, 0],
    [0, 0, 0],
    0,
    1,
    1,
    0,
    [4.2 * _streakSize, 1.8 * _streakSize, 0],
    [
        [1, 0.98, 0.78, 1],
        [1, 0.58, 0.17, 0.52],
        [1, 0.16, 0.04, 0]
    ],
    [1],
    0,
    0,
    "",
    "",
    _body,
    0,
    false,
    -1,
    [
        [90, 74, 28, 1],
        [35, 8, 2, 0]
    ]
];
_core setParticleRandom [0.04, [0.45, 0.45, 0.45], [0.5, 0.5, 0.5], 0, 0.35, [0.03, 0.02, 0.01, 0.08], 0, 0, 25, 0];
_core setDropInterval 0.001;

private _trail = "#particlesource" createVehicleLocal _startATL;
_trail attachTo [_body, [0, 0, 0]];
_trail setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
    "",
    "Billboard",
    1,
    0.84,
    [0, 0, 0],
    (_fallDir vectorMultiply -92),
    0,
    1.05,
    1,
    0.02,
    [5.2 * _streakSize, 3.0 * _streakSize, 0.35],
    [
        [1, 0.82, 0.34, 0.74],
        [1, 0.31, 0.1, 0.36],
        [0.85, 0.07, 0.03, 0]
    ],
    [0.7, 0.25],
    0.02,
    0.02,
    "",
    "",
    _body,
    0,
    false,
    -1,
    [
        [70, 34, 10, 0.82],
        [20, 4, 1, 0]
    ]
];
_trail setParticleRandom [0.18, [1.15, 1.15, 1.15], [4.2, 4.2, 4.2], 0, 0.75, [0.06, 0.04, 0.02, 0.1], 0.02, 0.04, 35, 0];
_trail setDropInterval 0.002;

private _tailLights = [];
private _tailStep = _tailLength / _tailCount;

for "_tailIndex" from 1 to _tailCount do {
    private _tailLight = "#lightpoint" createVehicleLocal _startATL;
    private _tailFade = 1 - (_tailIndex / (_tailCount + 1));

    _tailLight setLightColor [1, 0.44, 0.13];
    _tailLight setLightAmbient [0.95, 0.17, 0.07];
    _tailLight setLightBrightness ((42 * _tailFade) * _streakSize);
    _tailLight setLightIntensity ((460000 * _tailFade) * _streakSize);
    _tailLight setLightAttenuation [0, 0, 0, 0.28, 0, 680, 1050];
    _tailLight setLightUseFlare true;
    _tailLight setLightFlareSize ((14 * _tailFade) * _streakSize);
    _tailLight setLightFlareMaxDistance 6500;
    _tailLight setLightDayLight true;

    _tailLights pushBack [_tailLight, _tailIndex * _tailStep, _tailFade];
};

private _rodObjects = [];
private _rodCount = round (_settings getOrDefault ["skyRodObjects", 5]);
_rodCount = (_rodCount max 2) min 8;

for "_rodIndex" from 0 to (_rodCount - 1) do {
    private _rod = "Sign_Sphere100cm_F" createVehicleLocal _startATL;
    private _rodFade = 1 - (_rodIndex / (_rodCount + 1));
    private _rodOffset = _rodIndex * (_tailLength / (_rodCount + 2));

    _rod setObjectTexture [0, "#(rgb,8,8,3)color(1,0.74,0.28,1)"];
    _rod setObjectScale ((0.82 + (0.42 * _rodFade)) * _streakSize);
    _rod enableSimulation false;

    _rodObjects pushBack [_rod, _rodOffset, _rodFade];
};

private _spawnTracer = {
    params ["_posATL"];

    private _jitter = (_rightDir vectorMultiply (random [-1.2, 0, 1.2])) vectorAdd (_upDir vectorMultiply (random [-0.7, 0, 0.7]));
    private _tracerPosATL = _posATL vectorAdd _jitter;
    private _tracer = _tracerClass createVehicleLocal _tracerPosATL;

    if (!isNull _tracer) then {
        _tracer setPosATL _tracerPosATL;
        _tracer setVectorDirAndUp [_fallDir, _upDir];
        _tracer setVelocity (_fallDir vectorMultiply (_tracerSpeed + random [-80, 0, 80]));
        _tracerObjects pushBack [_tracer, time + _tracerTTL];
    };
};

private _startTime = time;
private _endTime = _startTime + _duration;
private _lastSparkTime = 0;
private _lastTracerTime = time - _tracerInterval;
private _approachSoundPlayed = false;

if (_tracerLayer) then {
    [_startATL] call _spawnTracer;
};

if (_sound && {_isClusterLead}) then {
    playSound3D ["A3\Sounds_F\weapons\Explosion\supersonic_crack_50meters.wss", objNull, false, ATLToASL _startATL, 1.45, random [0.72, 0.86, 1.02], 1400, 0, true];
};

while {time < _endTime} do {
    private _progress = ((time - _startTime) / _duration) min 1;
    private _posATL = _startATL vectorAdd ((_impactATL vectorDiff _startATL) vectorMultiply _progress);
    private _fade = 1 - _progress;

    if (_sound && {_isClusterLead} && {!_approachSoundPlayed} && {_progress > 0.58}) then {
        _approachSoundPlayed = true;
        playSound3D ["A3\Sounds_F\weapons\Explosion\supersonic_crack_close.wss", objNull, false, ATLToASL _posATL, 1.9, random [0.78, 0.94, 1.08], 950, 0, true];
    };

    _body setPosATL _posATL;
    _body setVectorDirAndUp [_fallDir, _upDir];
    _body setObjectScale ((0.85 + (0.55 * _fade)) * _streakSize);

    _headLight setLightBrightness ((82 + (125 * _fade)) * _streakSize);
    _headLight setLightIntensity ((850000 + (900000 * _fade)) * _streakSize);
    _headLight setLightFlareSize ((19 + (24 * _fade)) * _streakSize);

    {
        _x params ["_tailLight", "_offset", "_tailFade"];

        private _tailPosATL = _posATL vectorDiff (_fallDir vectorMultiply _offset);
        _tailLight setPosATL _tailPosATL;
        _tailLight setLightBrightness ((20 + (46 * _fade)) * _tailFade * _streakSize);
        _tailLight setLightFlareSize ((7 + (14 * _fade)) * _tailFade * _streakSize);
    } forEach _tailLights;

    {
        _x params ["_rod", "_offset", "_rodFade"];

        private _rodPosATL = _posATL vectorDiff (_fallDir vectorMultiply _offset);
        _rod setPosATL _rodPosATL;
        _rod setVectorDirAndUp [_fallDir, _upDir];
        _rod setObjectScale ((0.42 + (0.72 * _fade * _rodFade)) * _streakSize);
    } forEach _rodObjects;

    if (_tracerLayer && {time > _lastTracerTime + _tracerInterval}) then {
        _lastTracerTime = time;
        [_posATL] call _spawnTracer;
    };

    private _activeTracers = [];
    {
        _x params ["_tracer", "_expireTime"];

        if ((!isNull _tracer) && {time < _expireTime}) then {
            _activeTracers pushBack _x;
        } else {
            if (!isNull _tracer) then {
                deleteVehicle _tracer;
            };
        };
    } forEach _tracerObjects;
    _tracerObjects = _activeTracers;

    if (time > _lastSparkTime + 0.026) then {
        _lastSparkTime = time;

        drop [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
            "",
            "Billboard",
            1,
            0.24,
            _posATL,
            (_fallDir vectorMultiply -32),
            0,
            1,
            1,
            0.015,
            [2.3 * _streakSize, 0.82 * _streakSize, 0],
            [
                [1, 0.98, 0.8, 0.95],
                [1, 0.43, 0.12, 0.48],
                [0.8, 0.07, 0.02, 0]
            ],
            [1],
            0,
            0,
            "",
            "",
            objNull,
            0,
            false,
            -1,
            [
                [80, 56, 18, 1],
                [22, 4, 1, 0]
            ]
        ];
    };

    sleep 0.01;
};

deleteVehicle _core;
deleteVehicle _trail;
deleteVehicle _headLight;

{
    deleteVehicle (_x select 0);
} forEach _tailLights;

{
    deleteVehicle (_x select 0);
} forEach _rodObjects;

{
    _x params ["_tracer", "_expireTime"];

    if (!isNull _tracer) then {
        deleteVehicle _tracer;
    };
} forEach _tracerObjects;

deleteVehicle _body;

[_entry, _settings] call SDB_oreshnik_fnc_impactEffect;

true;
