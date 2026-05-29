params [
    ["_target", objNull, [objNull, []]],
    ["_settings", createHashMap, [createHashMap]]
];

if (!isServer) exitWith {
    [_target, _settings] remoteExecCall ["SDB_oreshnik_fnc_strike", 2];
    true;
};

private _targetATL = [0, 0, 0];

if (_target isEqualType objNull) then {
    if (isNull _target) exitWith {};
    _targetATL = getPosATL _target;
} else {
    if (count _target < 2) exitWith {};
    _targetATL = [
        _target select 0,
        _target select 1,
        _target param [2, 0]
    ];
};

if (_targetATL isEqualTo [0, 0, 0]) exitWith { false };

private _clusterCount = round (_settings getOrDefault ["clusterCount", 6]);
_clusterCount = (_clusterCount max 1) min 8;

private _elementsSetting = _settings getOrDefault ["elementsPerCluster", [6, 6]];
private _minElements = 6;
private _maxElements = 6;

if (_elementsSetting isEqualType []) then {
    _minElements = round (_elementsSetting param [0, 3]);
    _maxElements = round (_elementsSetting param [1, _minElements]);
} else {
    _minElements = round _elementsSetting;
    _maxElements = _minElements;
};

_minElements = (_minElements max 1) min 10;
_maxElements = (_maxElements max _minElements) min 10;

private _impactRadius = (_settings getOrDefault ["impactRadius", 110]) max 10;
private _entryAngle = (_settings getOrDefault ["entryAngle", 82]) max 45;
_entryAngle = _entryAngle min 89;

private _startAltitude = (_settings getOrDefault ["startAltitude", 15000]) max 200;
private _duration = (_settings getOrDefault ["duration", 4.2]) max 0.5;
private _clusterDelay = (_settings getOrDefault ["clusterDelay", 0.18]) max 0;
private _damage = _settings getOrDefault ["damage", true];

private _azimuth = _settings getOrDefault ["azimuth", random 360];
private _horizontalCoef = cos _entryAngle;
private _verticalCoef = sin _entryAngle;
private _flightLength = _startAltitude / _verticalCoef;
private _fallDir = [(sin _azimuth) * _horizontalCoef, (cos _azimuth) * _horizontalCoef, -_verticalCoef];

private _clusterAxis = [cos _azimuth, -(sin _azimuth), 0];
private _elementAxis = [sin _azimuth, cos _azimuth, 0];
private _strikeData = [];
private _clusterSpacing = _impactRadius / (_clusterCount max 2);

for "_clusterIndex" from 0 to (_clusterCount - 1) do {
    private _clusterOffsetIndex = _clusterIndex - ((_clusterCount - 1) / 2);
    private _clusterCenter = _targetATL vectorAdd (_clusterAxis vectorMultiply (_clusterOffsetIndex * _clusterSpacing));
    _clusterCenter = _clusterCenter vectorAdd (_elementAxis vectorMultiply (random [-8, 0, 8]));

    private _elementCount = _minElements + floor random ((_maxElements - _minElements) + 1);
    private _elementSpacing = random [10, 14, 20];

    for "_elementIndex" from 0 to (_elementCount - 1) do {
        private _elementOffsetIndex = _elementIndex - ((_elementCount - 1) / 2);
        private _impactATL = _clusterCenter vectorAdd (_elementAxis vectorMultiply (_elementOffsetIndex * _elementSpacing));
        _impactATL = _impactATL vectorAdd (_clusterAxis vectorMultiply (random [-4, 0, 4]));
        _impactATL set [2, 0 max (_impactATL select 2)];

        private _startATL = _impactATL vectorDiff (_fallDir vectorMultiply _flightLength);
        private _delay = (_clusterIndex * _clusterDelay) + (_elementIndex * 0.025) + random [0, 0.025, 0.055];
        private _streakDuration = _duration + random [-0.35, 0, 0.35];

        _strikeData pushBack createHashMapFromArray [
            ["startATL", _startATL],
            ["impactATL", _impactATL],
            ["delay", _delay],
            ["duration", _streakDuration max 0.35],
            ["fallDir", _fallDir],
            ["clusterIndex", _clusterIndex],
            ["elementIndex", _elementIndex],
            ["streakSize", random [1.2, 1.55, 1.9]]
        ];
    };
};

[_strikeData, _settings] remoteExecCall ["SDB_oreshnik_fnc_clientStrike", 0];

if (_damage) then {
    {
        [_x, _settings] spawn {
            params ["_entry", "_settings"];

            sleep ((_entry get "delay") + (_entry get "duration"));
            [_entry get "impactATL", _settings] call SDB_oreshnik_fnc_applyKineticDamage;
        };
    } forEach _strikeData;
};

true;
