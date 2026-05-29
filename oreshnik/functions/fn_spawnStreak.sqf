params [
    ["_entry", createHashMap, [createHashMap]],
    ["_settings", createHashMap, [createHashMap]]
];

private _startATL = _entry getOrDefault ["startATL", [0, 0, 1000]];
private _impactATL = _entry getOrDefault ["impactATL", [0, 0, 0]];
private _duration = _entry getOrDefault ["duration", 2.4];
private _fallDir = vectorNormalized (_entry getOrDefault ["fallDir", [0, 0, -1]]);
private _streakSize = _entry getOrDefault ["streakSize", 1];
private _tailLength = _settings getOrDefault ["skyTailLength", 110];
private _tailCount = round (_settings getOrDefault ["skyTailLights", 7]);
_tailCount = (_tailCount max 3) min 10;

private _rightDir = _fallDir vectorCrossProduct [0, 0, 1];
if (_rightDir isEqualTo [0, 0, 0]) then {
    _rightDir = [1, 0, 0];
};
_rightDir = vectorNormalized _rightDir;
private _upDir = vectorNormalized (_rightDir vectorCrossProduct _fallDir);

private _body = "Sign_Sphere100cm_F" createVehicleLocal _startATL;
_body setPosATL _startATL;
_body setVectorDirAndUp [_fallDir, _upDir];
_body setObjectScale (0.45 * _streakSize);

private _headLight = "#lightpoint" createVehicleLocal _startATL;
_headLight lightAttachObject [_body, [0, 0, 0]];
_headLight setLightColor [1, 0.88, 0.45];
_headLight setLightAmbient [1, 0.32, 0.12];
_headLight setLightBrightness (75 * _streakSize);
_headLight setLightIntensity (750000 * _streakSize);
_headLight setLightAttenuation [0, 0, 0, 0.22, 0, 900, 1400];
_headLight setLightUseFlare true;
_headLight setLightFlareSize (18 * _streakSize);
_headLight setLightFlareMaxDistance 6000;
_headLight setLightDayLight true;

private _core = "#particlesource" createVehicleLocal _startATL;
_core attachTo [_body, [0, 0, 0]];
_core setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
    "",
    "Billboard",
    1,
    0.11,
    [0, 0, 0],
    [0, 0, 0],
    0,
    1,
    1,
    0,
    [2.4 * _streakSize, 1.1 * _streakSize, 0],
    [
        [1, 0.96, 0.72, 1],
        [1, 0.58, 0.18, 0.45],
        [1, 0.16, 0.05, 0]
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
        [1, 0.82, 0.28, 1],
        [1, 0.26, 0.07, 0]
    ]
];
_core setParticleRandom [0.03, [0.35, 0.35, 0.35], [0.4, 0.4, 0.4], 0, 0.25, [0.03, 0.02, 0.01, 0.08], 0, 0, 25, 0];
_core setDropInterval 0.0015;

private _trail = "#particlesource" createVehicleLocal _startATL;
_trail attachTo [_body, [0, 0, 0]];
_trail setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
    "",
    "Billboard",
    1,
    0.72,
    [0, 0, 0],
    (_fallDir vectorMultiply -68),
    0,
    1.05,
    1,
    0.03,
    [3.4 * _streakSize, 2.2 * _streakSize, 0.3],
    [
        [1, 0.82, 0.36, 0.72],
        [1, 0.33, 0.12, 0.34],
        [0.85, 0.08, 0.04, 0]
    ],
    [0.7, 0.25],
    0.02,
    0.02,
    "",
    "",
    objNull,
    0,
    false,
    -1,
    [
        [1, 0.55, 0.16, 0.8],
        [1, 0.14, 0.04, 0]
    ]
];
_trail setParticleRandom [0.16, [0.9, 0.9, 0.9], [3.5, 3.5, 3.5], 0, 0.6, [0.06, 0.04, 0.02, 0.1], 0.02, 0.04, 35, 0];
_trail setDropInterval 0.0025;

private _tailLights = [];
private _tailStep = _tailLength / _tailCount;

for "_tailIndex" from 1 to _tailCount do {
    private _tailLight = "#lightpoint" createVehicleLocal _startATL;
    private _tailFade = 1 - (_tailIndex / (_tailCount + 1));

    _tailLight setLightColor [1, 0.42, 0.14];
    _tailLight setLightAmbient [0.9, 0.16, 0.08];
    _tailLight setLightBrightness ((24 * _tailFade) * _streakSize);
    _tailLight setLightIntensity ((260000 * _tailFade) * _streakSize);
    _tailLight setLightAttenuation [0, 0, 0, 0.34, 0, 520, 900];
    _tailLight setLightUseFlare true;
    _tailLight setLightFlareSize ((9 * _tailFade) * _streakSize);
    _tailLight setLightFlareMaxDistance 5200;
    _tailLight setLightDayLight true;

    _tailLights pushBack [_tailLight, _tailIndex * _tailStep, _tailFade];
};

private _startTime = time;
private _endTime = _startTime + _duration;
private _lastSparkTime = 0;

while {time < _endTime} do {
    private _progress = ((time - _startTime) / _duration) min 1;
    private _posATL = _startATL vectorAdd ((_impactATL vectorDiff _startATL) vectorMultiply _progress);
    private _fade = 1 - _progress;

    _body setPosATL _posATL;
    _body setVectorDirAndUp [_fallDir, _upDir];
    _body setObjectScale (0.45 * _streakSize);

    _headLight setLightBrightness ((42 + (70 * _fade)) * _streakSize);
    _headLight setLightFlareSize ((12 + (13 * _fade)) * _streakSize);

    {
        _x params ["_tailLight", "_offset", "_tailFade"];

        private _tailPosATL = _posATL vectorDiff (_fallDir vectorMultiply _offset);
        _tailLight setPosATL _tailPosATL;
        _tailLight setLightBrightness ((12 + (22 * _fade)) * _tailFade * _streakSize);
        _tailLight setLightFlareSize ((5 + (8 * _fade)) * _tailFade * _streakSize);
    } forEach _tailLights;

    if (time > _lastSparkTime + 0.028) then {
        _lastSparkTime = time;

        drop [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
            "",
            "Billboard",
            1,
            0.2,
            _posATL,
            (_fallDir vectorMultiply -22),
            0,
            1,
            1,
            0.02,
            [1.7 * _streakSize, 0.65 * _streakSize, 0],
            [
                [1, 0.96, 0.78, 0.95],
                [1, 0.43, 0.13, 0.45],
                [0.8, 0.07, 0.03, 0]
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
                [1, 0.75, 0.25, 1],
                [1, 0.18, 0.04, 0]
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

deleteVehicle _body;

[_entry, _settings] call SDB_oreshnik_fnc_impactEffect;

true;
