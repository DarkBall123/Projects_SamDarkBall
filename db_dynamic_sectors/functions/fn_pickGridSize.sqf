params [["_mapSize", worldSize]];

private _override = missionNamespace getVariable ["DB_DS_gridSizeOverride", -1];

if ((_override isEqualType 0) && {_override > 0}) exitWith
{
    _override
};

if (_mapSize <= 4096) exitWith {200};
if (_mapSize <= 8192) exitWith {300};
if (_mapSize <= 12288) exitWith {400};
if (_mapSize <= 20480) exitWith {550};
if (_mapSize <= 30720) exitWith {700};
if (_mapSize <= 40960) exitWith {900};

1100
