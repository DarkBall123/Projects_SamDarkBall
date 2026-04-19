params
[
    ["_sectorId", -1],
    ["_counts", [0, 0, 0]]
];

if (_sectorId < 0) exitWith {};

private _sectorMarkers = missionNamespace getVariable ["DB_DS_sectorMarkers", []];
private _markerSet = _sectorMarkers param [_sectorId, []];

if (_markerSet isEqualTo []) exitWith {};

_markerSet params
[
    "_baseMarker",
    "_westMarker",
    "_eastMarker",
    "_indMarker"
];

_counts params
[
    ["_westCount", 0],
    ["_eastCount", 0],
    ["_independentCount", 0]
];

private _countsArray = [_westCount, _eastCount, _independentCount];
private _sideColors =
[
    "#(0.16,0.43,0.96)",
    "#(0.92,0.18,0.16)",
    "#(0.14,0.78,0.24)"
];
private _overlayMarkers = [_westMarker, _eastMarker, _indMarker];
private _activeIndices = [];
private _baseColor = "#(0.52,0.52,0.52)";
private _baseAlpha = 0.28;
private _combatColor = "#(0.96,0.56,0.14)";

{
    if (_x > 0) then
    {
        _activeIndices pushBack _forEachIndex;
    };
} forEach _countsArray;

private _activeCount = count _activeIndices;

if (_activeCount == 1) then
{
    _baseColor = _sideColors select (_activeIndices # 0);
    _baseAlpha = 0.42;
};

if (_activeCount > 1) then
{
    private _maxCount = selectMax _countsArray;
    private _leaderIndices = [];

    {
        if (_x == _maxCount) then
        {
            _leaderIndices pushBack _forEachIndex;
        };
    } forEach _countsArray;

    if ((count _leaderIndices) == 1) then
    {
        _baseColor = _sideColors select (_leaderIndices # 0);
        _baseAlpha = 0.24;
    }
    else
    {
        _baseColor = _combatColor;
        _baseAlpha = 0.35;
    };
};

_baseMarker setMarkerColorLocal _baseColor;
_baseMarker setMarkerAlphaLocal _baseAlpha;

{
    private _alpha = 0;

    if ((_activeCount > 1) && {(_countsArray # _forEachIndex) > 0}) then
    {
        _alpha = 0.75;
    };

    _x setMarkerAlphaLocal _alpha;
} forEach _overlayMarkers;
