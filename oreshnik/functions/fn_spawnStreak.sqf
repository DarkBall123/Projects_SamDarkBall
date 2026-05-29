params [
    ["_entry", createHashMap, [createHashMap]],
    ["_settings", createHashMap, [createHashMap]]
];

private _startATL = _entry getOrDefault ["startATL", [0, 0, 1000]];
private _impactATL = _entry getOrDefault ["impactATL", [0, 0, 0]];
private _duration = _entry getOrDefault ["duration", 2.4];
private _fallDir = _entry getOrDefault ["fallDir", [0, 0, -1]];
private _streakSize = _entry getOrDefault ["streakSize", 1];

private _light = "#lightpoint" createVehicleLocal _startATL;
_light setPosATL _startATL;
_light setLightColor [1, 0.86, 0.48];
_light setLightAmbient [1, 0.34, 0.14];
_light setLightBrightness (7 * _streakSize);
_light setLightUseFlare true;
_light setLightFlareSize (2.3 * _streakSize);
_light setLightFlareMaxDistance 2400;
_light setLightDayLight true;

private _trail = "#particlesource" createVehicleLocal _startATL;
_trail setPosATL _startATL;
_trail setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
    "",
    "Billboard",
    1,
    0.18,
    [0, 0, 0],
    (_fallDir vectorMultiply -28),
    0,
    1.05,
    1,
    0.02,
    [0.45 * _streakSize, 0.18 * _streakSize, 0.04],
    [
        [1, 0.92, 0.62, 0.8],
        [1, 0.42, 0.16, 0.42],
        [0.95, 0.12, 0.07, 0]
    ],
    [0.8, 0.25],
    0.02,
    0.02,
    "",
    "",
    _trail,
    0,
    false,
    -1,
    [
        [1, 0.78, 0.34, 1],
        [1, 0.22, 0.08, 0]
    ]
];
_trail setParticleRandom [0.05, [0.08, 0.08, 0.08], [1.5, 1.5, 1.5], 0, 0.04, [0.05, 0.03, 0.02, 0.08], 0, 0, 8, 0];
_trail setDropInterval 0.004;

private _startTime = time;
private _endTime = _startTime + _duration;

while {time < _endTime} do
{
    private _progress = ((time - _startTime) / _duration) min 1;
    private _posATL = _startATL vectorAdd ((_impactATL vectorDiff _startATL) vectorMultiply _progress);

    _light setPosATL _posATL;
    _trail setPosATL _posATL;

    private _fade = 1 - _progress;
    _light setLightBrightness ((3 + (7 * _fade)) * _streakSize);
    _light setLightFlareSize ((1.2 + (1.4 * _fade)) * _streakSize);

    sleep 0.01;
};

deleteVehicle _trail;
deleteVehicle _light;

[_entry, _settings] call SDB_oreshnik_fnc_impactEffect;

true;
