if (!isServer) exitWith {};

private _previousPfh = missionNamespace getVariable ["DB_DS_serverPfhId", -1];

if (_previousPfh != -1) then
{
    [_previousPfh] call CBA_fnc_removePerFrameHandler;
};

private _gridSize = [] call DB_DS_fnc_pickGridSize;
private _sectorBuild = [_gridSize, worldSize] call DB_DS_fnc_buildSectorGrid;
private _sectorGrid = _sectorBuild # 0;
private _sectorLookup = _sectorBuild # 1;

missionNamespace setVariable ["DB_DS_gridSize", _gridSize, true];
missionNamespace setVariable ["DB_DS_sectorGrid", _sectorGrid, true];
missionNamespace setVariable ["DB_DS_sectorLookup", _sectorLookup];
missionNamespace setVariable ["DB_DS_sectorStatePayload", [0, []], true];
missionNamespace setVariable ["DB_DS_lastSectorState", []];
missionNamespace setVariable ["DB_DS_nextServerUpdateAt", diag_tickTime];

private _pfhId =
[
    {
        private _nextUpdateAt = missionNamespace getVariable ["DB_DS_nextServerUpdateAt", 0];

        if (diag_tickTime < _nextUpdateAt) exitWith {};

        private _updateInterval = missionNamespace getVariable ["DB_DS_updateInterval", 5];
        private _gridSize = missionNamespace getVariable ["DB_DS_gridSize", [] call DB_DS_fnc_pickGridSize];
        private _sectorState = [allUnits, _gridSize] call DB_DS_fnc_collectSectorState;
        private _lastSectorState = missionNamespace getVariable ["DB_DS_lastSectorState", []];

        missionNamespace setVariable ["DB_DS_nextServerUpdateAt", diag_tickTime + _updateInterval];

        if (_sectorState isEqualTo _lastSectorState) exitWith {};

        missionNamespace setVariable ["DB_DS_lastSectorState", +_sectorState];

        private _payload = missionNamespace getVariable ["DB_DS_sectorStatePayload", [0, []]];
        private _revision = (_payload # 0) + 1;

        missionNamespace setVariable ["DB_DS_sectorStatePayload", [_revision, _sectorState], true];
    },
    0.5,
    []
] call CBA_fnc_addPerFrameHandler;

missionNamespace setVariable ["DB_DS_serverPfhId", _pfhId];
