params [
    ["_target", objNull, [objNull, []]],
    ["_settings", createHashMap, [createHashMap]]
];

if (!isServer) exitWith {
    [_target, _settings] remoteExecCall ["DB_fnc_oreshnikStrike", 2];
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

private _elementsSetting = _settings getOrDefault ["elementsPerCluster", [4, 6]];
private _minElements = 4;
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

private _patternLength = (_settings getOrDefault ["patternLength", 320]) max 0;
private _patternWidth = (_settings getOrDefault ["patternWidth", 80]) max 0;
private _longitudinalScatter = (_settings getOrDefault ["longitudinalScatter", 8]) max 0;
private _lateralScatter = (_settings getOrDefault ["lateralScatter", 5]) max 0;
private _entryAngle = (_settings getOrDefault ["entryAngle", 82]) max 45;
_entryAngle = _entryAngle min 89;

private _startAltitude = (_settings getOrDefault ["startAltitude", 15000]) max 200;
private _duration = (_settings getOrDefault ["duration", 4.2]) max 0.5;
private _durationJitter = (_settings getOrDefault ["durationJitter", 0.08]) max 0;
private _clusterDelay = (_settings getOrDefault ["clusterDelay", 1.1]) max 0;
private _elementDelay = (_settings getOrDefault ["elementDelay", 0.015]) max 0;
private _timingJitter = (_settings getOrDefault ["timingJitter", 0.04]) max 0;
private _streakScale = (_settings getOrDefault ["streakScale", 1.35]) max 0.1;
private _streakVariation = ((_settings getOrDefault ["streakVariation", 0.12]) max 0) min 0.9;
private _damage = _settings getOrDefault ["damage", true];
private _visualAltitude = (_settings getOrDefault ["skyVisualAltitude", 2200]) max 300;
private _minVisualDuration = (_settings getOrDefault ["minSkyDuration", 0.85]) max 0.5;

private _azimuth = _settings getOrDefault ["azimuth", random 360];
private _horizontalCoef = cos _entryAngle;
private _verticalCoef = sin _entryAngle;
private _flightLength = _startAltitude / _verticalCoef;
private _fallDir = [(sin _azimuth) * _horizontalCoef, (cos _azimuth) * _horizontalCoef, -_verticalCoef];

private _longitudinalAxis = [sin _azimuth, cos _azimuth, 0];
private _lateralAxis = [cos _azimuth, -(sin _azimuth), 0];
private _strikeData = [];
private _clusterSpacing = 0;

if (_clusterCount > 1) then {
    _clusterSpacing = _patternWidth / (_clusterCount - 1);
};

for "_clusterIndex" from 0 to (_clusterCount - 1) do {
    private _clusterOffsetIndex = _clusterIndex - ((_clusterCount - 1) / 2);
    private _clusterCenter = _targetATL vectorAdd (_lateralAxis vectorMultiply (_clusterOffsetIndex * _clusterSpacing));

    private _elementCount = _minElements + floor random ((_maxElements - _minElements) + 1);
    private _elementSpacing = 0;

    if (_elementCount > 1) then {
        _elementSpacing = _patternLength / (_elementCount - 1);
    };

    for "_elementIndex" from 0 to (_elementCount - 1) do {
        private _elementOffsetIndex = _elementIndex - ((_elementCount - 1) / 2);
        private _longitudinalOffset = (_elementOffsetIndex * _elementSpacing) + random [-_longitudinalScatter, 0, _longitudinalScatter];
        private _lateralOffset = random [-_lateralScatter, 0, _lateralScatter];
        private _impactATL = _clusterCenter vectorAdd (_longitudinalAxis vectorMultiply _longitudinalOffset);
        _impactATL = _impactATL vectorAdd (_lateralAxis vectorMultiply _lateralOffset);
        _impactATL set [2, 0 max (_impactATL select 2)];

        private _startATL = _impactATL vectorDiff (_fallDir vectorMultiply _flightLength);
        private _delay = (_clusterIndex * _clusterDelay) + (_elementIndex * _elementDelay) + random [0, _timingJitter / 2, _timingJitter];
        private _streakDuration = _duration + random [-_durationJitter, 0, _durationJitter];
        private _verticalTravel = ((_startATL select 2) - (_impactATL select 2)) max 0;
        private _visibleDuration = _streakDuration;

        if (_verticalTravel > _visualAltitude) then {
            _visibleDuration = (_streakDuration * (_visualAltitude / _verticalTravel)) max _minVisualDuration;
        };

        _strikeData pushBack createHashMapFromArray [
            ["startATL", _startATL],
            ["impactATL", _impactATL],
            ["delay", _delay],
            ["duration", _streakDuration max 0.35],
            ["visibleDuration", _visibleDuration],
            ["fallDir", _fallDir],
            ["clusterIndex", _clusterIndex],
            ["elementIndex", _elementIndex],
            ["streakSize", _streakScale * random [1 - _streakVariation, 1, 1 + _streakVariation]]
        ];
    };
};

[_strikeData, _settings] remoteExecCall ["DB_fnc_oreshnikClientStrike", 0];

if (_damage) then {
    {
        [_x, _settings] spawn {
            params ["_entry", "_settings"];

            sleep ((_entry get "delay") + (_entry getOrDefault ["visibleDuration", _entry get "duration"]));
            [_entry get "impactATL", _settings] call DB_fnc_oreshnikApplyKineticDamage;
        };
    } forEach _strikeData;
};

true;
