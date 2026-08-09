params [
    ["_entry", createHashMap, [createHashMap]],
    ["_settings", createHashMap, [createHashMap]]
];

private _impactATL = _entry getOrDefault ["impactATL", [0, 0, 0]];
private _impactASL = ATLToASL _impactATL;
private _impactAGL = ASLToAGL _impactASL;

private _distance = player distance _impactATL;
private _sound = _settings getOrDefault ["sound", true];
private _soundScale = (_settings getOrDefault ["soundScale", 1]) max 0;
private _flashScale = (_settings getOrDefault ["impactFlashScale", 1]) max 0;
private _dustScale = (_settings getOrDefault ["impactDustScale", 1]) max 0;
private _dustDuration = (_settings getOrDefault ["impactDustDuration", 3]) max 0.5;
private _sparkCount = round (_settings getOrDefault ["impactSparkCount", 20]);
_sparkCount = (_sparkCount max 0) min 80;
private _shakeScale = (_settings getOrDefault ["cameraShakeScale", 1]) max 0;
private _shakeRadius = (_settings getOrDefault ["cameraShakeRadius", 650]) max 1;
private _isClusterLead = (_entry getOrDefault ["elementIndex", 0]) == 0;

if (_sound && {_soundScale > 0}) then {
    [_impactASL, _distance, _soundScale, _isClusterLead, _settings] spawn {
        params ["_impactASL", "_distance", "_soundScale", "_isClusterLead", "_settings"];

        private _delay = 0;
        if (_settings getOrDefault ["simulateSoundDelay", true]) then {
            private _maxDelay = (_settings getOrDefault ["soundDelayMax", 8]) max 0;
            _delay = (_distance / 343) min _maxDelay;
        };

        sleep _delay;

        private _closeVolume = 0.35 * _soundScale;
        if (_isClusterLead) then {
            _closeVolume = 1.35 * _soundScale;
        };
        playSound3D ["A3\Sounds_F\arsenal\explosives\shells\ShellLightA_closeExp_03.wss", objNull, false, _impactASL, _closeVolume, random [0.72, 0.84, 0.96], 1150, 0, true];

        if (_isClusterLead) then {
            playSound3D ["A3\Sounds_F\weapons\Explosion\expl_shell_1.wss", objNull, false, _impactASL, 2.2 * _soundScale, random [0.52, 0.62, 0.72], 2300, 0, true];
            sleep 0.18;
            playSound3D ["A3\Sounds_F\arsenal\explosives\shells\Artillery_tank_shell_155mm_explosion_01.wss", objNull, false, _impactASL, 1.45 * _soundScale, random [0.48, 0.58, 0.68], 2900, 0, true];
        };
    };
};

if (_distance < _shakeRadius && {_shakeScale > 0}) then {
    enableCamShake true;
    private _power = (12 * _shakeScale * (1 - (_distance / _shakeRadius))) max (0.7 * _shakeScale);
    addCamShake [_power, 0.8, 34];
};

if (_flashScale > 0) then {
    private _flash = "#lightpoint" createVehicleLocal _impactATL;
    _flash setPosATL _impactATL;
    _flash setLightColor [1, 0.96, 0.82];
    _flash setLightAmbient [1, 0.48, 0.2];
    _flash setLightIntensity (1200000 * _flashScale);
    _flash setLightAttenuation [0, 0, 0, 0.2, 0, 850, 1500];
    _flash setLightUseFlare true;
    _flash setLightFlareSize (9 * _flashScale);
    _flash setLightFlareMaxDistance 2200;
    _flash setLightDayLight true;

    [_flash, _flashScale] spawn {
        params ["_flash", "_scale"];

        private _startTime = time;
        private _duration = 0.18;

        while {time < _startTime + _duration} do {
            private _fade = 1 - ((time - _startTime) / _duration);
            _flash setLightIntensity (1200000 * _scale * _fade);
            _flash setLightFlareSize (9 * _scale * _fade);
            sleep 0.01;
        };

        deleteVehicle _flash;
    };

    drop [
        ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
        "",
        "Billboard",
        1,
        0.18,
        _impactAGL,
        [0, 0, 2],
        0,
        1.1,
        1,
        0,
        [4 * _flashScale, 9 * _flashScale, 0],
        [
            [1, 1, 1, 1],
            [1, 0.72, 0.24, 0.48],
            [1, 0.22, 0.05, 0]
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
            [120, 112, 88, 1],
            [36, 12, 2, 1],
            [0, 0, 0, 0]
        ]
    ];

    drop [
        ["\A3\data_f\ParticleEffects\Universal\Refract", 1, 0, 1],
        "",
        "Billboard",
        1,
        0.32,
        _impactAGL,
        [0, 0, 0.4],
        0,
        1,
        1,
        0,
        [3 * _flashScale, 24 * _flashScale, 46 * _flashScale, 0],
        [
            [1, 1, 1, 0.5],
            [1, 1, 1, 0]
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
            [0, 0, 0, 0]
        ]
    ];
};

if (_dustScale > 0) then {
    private _dust = "#particlesource" createVehicleLocal _impactATL;
    _dust setPosATL _impactATL;
    _dust setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1],
        "",
        "Billboard",
        1,
        2.4,
        [0, 0, 0],
        [0, 0, 7 * _dustScale],
        0,
        1.28,
        1,
        0.26,
        [2.5 * _dustScale, 10 * _dustScale, 22 * _dustScale],
        [
            [0.46, 0.4, 0.32, 0.58],
            [0.36, 0.33, 0.3, 0.4],
            [0.2, 0.2, 0.2, 0]
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
    _dust setParticleRandom [0.8, [4 * _dustScale, 4 * _dustScale, 0.5], [7 * _dustScale, 7 * _dustScale, 3], 0, 2 * _dustScale, [0.08, 0.07, 0.06, 0.16], 0.05, 0.08, 180, 0];
    _dust setDropInterval 0.007;

    private _groundDust = "#particlesource" createVehicleLocal _impactATL;
    _groundDust setPosATL _impactATL;
    _groundDust setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1],
        "",
        "Billboard",
        1,
        1.5,
        [0, 0, 0.15],
        [0, 0, 0.8],
        0,
        1.3,
        1,
        0.38,
        [3 * _dustScale, 12 * _dustScale, 26 * _dustScale],
        [
            [0.5, 0.43, 0.34, 0.42],
            [0.38, 0.35, 0.32, 0.28],
            [0.24, 0.24, 0.24, 0]
        ],
        [0.25],
        0,
        0,
        "",
        "",
        _groundDust,
        0,
        true,
        -1,
        [
            [0, 0, 0, 0]
        ]
    ];
    _groundDust setParticleCircle [1.5 * _dustScale, [10 * _dustScale, 0, 0.8]];
    _groundDust setParticleRandom [0.45, [1.5, 1.5, 0.2], [2.5, 2.5, 1], 0, 1.5 * _dustScale, [0.06, 0.05, 0.04, 0.12], 0, 0, 180, 0];
    _groundDust setDropInterval 0.01;

    [_dust, _groundDust, _dustDuration] spawn {
        params ["_dust", "_groundDust", "_duration"];

        sleep 0.35;
        _dust setDropInterval 0.04;
        _groundDust setDropInterval 0.05;
        sleep ((_duration - 0.35) max 0);
        deleteVehicle _dust;
        deleteVehicle _groundDust;
    };
};

if (_flashScale > 0 && {_sparkCount > 0}) then {
    for "_sparkIndex" from 1 to _sparkCount do {
        private _dir = random 360;
        private _speed = random [10, 22, 38] * _flashScale;
        private _sparkVelocity = [(sin _dir) * _speed, (cos _dir) * _speed, random [3, 8, 16] * _flashScale];

        drop [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 2, 0],
            "",
            "Billboard",
            1,
            random [0.2, 0.38, 0.7],
            _impactAGL,
            _sparkVelocity,
            0,
            1,
            1,
            0.04,
            [0.12 * _flashScale, 0.05 * _flashScale, 0],
            [
                [1, 1, 1, 1],
                [1, 0.72, 0.24, 0.82],
                [1, 0.2, 0.04, 0]
            ],
            [1],
            0,
            0,
            "",
            "",
            objNull,
            0,
            false,
            0.35,
            [
                [80, 70, 44, 1],
                [24, 7, 1, 1],
                [0, 0, 0, 0]
            ]
        ];
    };
};

true;
