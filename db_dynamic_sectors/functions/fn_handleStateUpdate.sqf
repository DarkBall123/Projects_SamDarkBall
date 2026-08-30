params [["_payload", [0, []]]];

_payload params
[
    ["_revision", 0],
    ["_sectorState", []]
];

private _lastRevision = missionNamespace getVariable ["DB_DS_lastPayloadRevision", -1];

if (_revision == _lastRevision) exitWith {};

private _activeSectorIds = missionNamespace getVariable ["DB_DS_activeSectorIds", []];
private _renderedSectorState = missionNamespace getVariable ["DB_DS_renderedSectorState", createHashMap];
private _nextActiveSectorIds = [];

{
    _x params
    [
        ["_sectorId", -1],
        ["_westCount", 0],
        ["_eastCount", 0],
        ["_independentCount", 0]
    ];

    if (_sectorId >= 0) then
    {
        private _counts = [_westCount, _eastCount, _independentCount];

        _nextActiveSectorIds pushBack _sectorId;

        if !(_counts isEqualTo (_renderedSectorState getOrDefault [_sectorId, [0, 0, 0]])) then
        {
            [_sectorId, _counts] call DB_DS_fnc_renderSectorState;
            _renderedSectorState set [_sectorId, _counts];
        };
    };
} forEach _sectorState;

{
    if !(([0, 0, 0]) isEqualTo (_renderedSectorState getOrDefault [_x, [0, 0, 0]])) then
    {
        [_x, [0, 0, 0]] call DB_DS_fnc_renderSectorState;
        _renderedSectorState set [_x, [0, 0, 0]];
    };
} forEach (_activeSectorIds - _nextActiveSectorIds);

missionNamespace setVariable ["DB_DS_activeSectorIds", _nextActiveSectorIds];
missionNamespace setVariable ["DB_DS_lastPayloadRevision", _revision];
missionNamespace setVariable ["DB_DS_renderedSectorState", _renderedSectorState];
