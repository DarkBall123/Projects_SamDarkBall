params [
    ["_entry", createHashMap, [createHashMap]],
    ["_settings", createHashMap, [createHashMap]]
];

private _impactATL = _entry getOrDefault ["impactATL", [0, 0, 0]];
private _impactASL = ATLToASL _impactATL;
private _impactAGL = ASLToAGL _impactASL;

private _distance = player distance _impactATL;
private _sound = _settings getOrDefault ["sound", true];
private _soundScale = _settings getOrDefault ["soundScale", 1];
private _isClusterLead = (_entry getOrDefault ["elementIndex", 0]) == 0;

if (_sound) then {
    [_impactASL, _distance, _soundScale, _isClusterLead, _settings] spawn {
        params ["_impactASL", "_distance", "_soundScale", "_isClusterLead", "_settings"];

        private _delay = 0;
        if (_settings getOrDefault ["simulateSoundDelay", true]) then {
            _delay = (_distance / 343) min 2.35;
        };

        sleep _delay;

        private _closeVolume = 0.85 * _soundScale;
        if (_isClusterLead) then {
            _closeVolume = 1.55 * _soundScale;
        };
        playSound3D ["A3\Sounds_F\arsenal\explosives\shells\ShellLightA_closeExp_03.wss", objNull, false, _impactASL, _closeVolume, random [0.72, 0.84, 0.96], 1150, 0, true];

        if (_isClusterLead) then {
            playSound3D ["A3\Sounds_F\weapons\Explosion\expl_shell_1.wss", objNull, false, _impactASL, 2.2 * _soundScale, random [0.52, 0.62, 0.72], 2300, 0, true];
            sleep 0.18;
            playSound3D ["A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_01.wss", objNull, false, _impactASL, 1.45 * _soundScale, random [0.48, 0.58, 0.68], 2900, 0, true];
        };
    };
};

if (_distance < 650) then
{
    enableCamShake true;
    private _power = (12 * (1 - (_distance / 650))) max 0.7;
    addCamShake [_power, 0.8, 34];
};

private _flash = "#lightpoint" createVehicleLocal _impactATL;
_flash setPosATL _impactATL;
_flash setLightColor [1, 0.86, 0.52];
_flash setLightAmbient [1, 0.42, 0.18];
_flash setLightBrightness 22;
_flash setLightUseFlare true;
_flash setLightFlareSize 8;
_flash setLightFlareMaxDistance 1800;
_flash setLightDayLight true;

[_flash] spawn {
    params ["_flash"];

    private _startTime = time;
    private _duration = 0.18;

    while {time < _startTime + _duration} do {
        private _fade = 1 - ((time - _startTime) / _duration);
        _flash setLightBrightness (22 * _fade);
        _flash setLightFlareSize (8 * _fade);
        sleep 0.01;
    };

    deleteVehicle _flash;
};

drop [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
    "",
    "Billboard",
    1,
    0.16,
    _impactAGL,
    [0, 0, 1.5],
    0,
    1.1,
    1,
    0,
    [4, 7, 0],
    [
        [1, 0.9, 0.55, 0.9],
        [1, 0.32, 0.12, 0]
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
        [1, 0.72, 0.24, 1],
        [1, 0.24, 0.08, 0]
    ]
];

private _dust = "#particlesource" createVehicleLocal _impactATL;
_dust setPosATL _impactATL;
_dust setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1],
    "",
    "Billboard",
    1,
    1.8,
    [0, 0, 0],
    [0, 0, 5.5],
    0,
    1.28,
    1,
    0.28,
    [2.5, 8, 15],
    [
        [0.42, 0.36, 0.28, 0.55],
        [0.38, 0.34, 0.3, 0.38],
        [0.22, 0.22, 0.22, 0]
    ],
    [0.25],
    0.05,
    0.08,
    "",
    "",
    _dust,
    0,
    false,
    -1,
    [
        [0, 0, 0, 0]
    ]
];
_dust setParticleRandom [0.7, [5, 5, 0.4], [8, 8, 2], 0, 2, [0.08, 0.07, 0.06, 0.18], 0.05, 0.08, 180, 0];
_dust setDropInterval 0.006;

for "_sparkIndex" from 0 to 17 do {
    private _dir = random 360;
    private _speed = random [8, 18, 32];
    private _sparkVelocity = [(sin _dir) * _speed, (cos _dir) * _speed, random [2, 6, 13]];

    drop [
        ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
        "",
        "Billboard",
        1,
        random [0.16, 0.28, 0.45],
        _impactAGL,
        _sparkVelocity,
        0,
        1,
        1,
        0.04,
        [0.08, 0.03, 0],
        [
            [1, 0.92, 0.5, 0.9],
            [1, 0.28, 0.08, 0]
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
            [1, 0.7, 0.25, 1],
            [1, 0.18, 0.04, 0]
        ]
    ];
};

[_dust] spawn {
    params ["_dust"];

    sleep 0.45;
    _dust setDropInterval 0.04;
    sleep 2.4;
    deleteVehicle _dust;
};

true;
