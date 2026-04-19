params [["_mapSize", worldSize]];

private _override = missionNamespace getVariable ["DB_DS_gridSizeOverride", -1];

if ((_override isEqualType 0) && {_override > 0}) exitWith
{
    _override
};

if (_mapSize <= 4096) exitWith {250};
if (_mapSize <= 8192) exitWith {350};
if (_mapSize <= 12288) exitWith {450};
if (_mapSize <= 20480) exitWith {600};
if (_mapSize <= 30720) exitWith {750};
if (_mapSize <= 40960) exitWith {1000};

1250
