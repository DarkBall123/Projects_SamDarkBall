if (!isServer) exitWith { false };

private _markerName = "forest_1";
private _count = 750;
private _maxAttempts = 10;
private _minDist = 4.5;
private _distRoad = 10;
private _distHouse = 10;
private _distWall = 6;
private _distRock = 4;
private _distEntity = 10;
private _bushChance = 0.30;

private _center = getMarkerPos _markerName;
private _size = getMarkerSize _markerName;

if (_center isEqualTo [0, 0, 0] && { _size isEqualTo [0, 0] }) exitWith
{
    diag_log format ["[FOREST] Marker not found or has zero size: %1", _markerName];
    false
};

private _treeModels =
[
    "a3\vegetation_f_exp\tree\t_Ficus_big_F.p3d",
    "a3\vegetation_f_exp\tree\t_Inocarpus_F.p3d",
    "a3\vegetation_f_exp\tree\t_Leucaena_F.p3d",
    "a3\vegetation_f_exp\tree\t_Millettia_F.p3d",
    "a3\plants_f\Tree\t_FicusB1s_F.p3d",
    "a3\plants_f\Tree\t_FicusB2s_F.p3d",
    "a3\plants_f\Tree\t_BroussonetiaP1s_F.p3d"
];

private _bushModels =
[
    "a3\plants_f\bush\b_neriumo2s_white_f.p3d",
    "a3\plants_f\bush\b_thistle_thorn_green.p3d"
];

private _placed = [];

private _fnc_isOnOrNearRoad =
{
    params ["_pos2D", "_distRoad"];

    if (isOnRoad _pos2D) exitWith { true };
    if (!isNull (roadAt _pos2D)) exitWith { true };
    if ((count (_pos2D nearRoads _distRoad)) > 0) exitWith { true };

    (count (nearestTerrainObjects [
        _pos2D,
        ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"],
        _distRoad,
        false,
        true
    ])) > 0
};

private _fnc_isBlocked =
{
    params ["_pos2D"];

    if (surfaceIsWater _pos2D) exitWith { true };
    if ([_pos2D, _distRoad] call _fnc_isOnOrNearRoad) exitWith { true };

    if ((count (nearestTerrainObjects [
        _pos2D,
        ["HOUSE", "BUILDING", "BUNKER", "BUSSTOP", "FUELSTATION", "VIEW-TOWER", "WATERTOWER", "STACK", "RUIN"],
        _distHouse,
        false,
        true
    ])) > 0) exitWith { true };

    if ((count (nearestTerrainObjects [
        _pos2D,
        ["WALL", "FENCE"],
        _distWall,
        false,
        true
    ])) > 0) exitWith { true };

    if ((count (nearestTerrainObjects [
        _pos2D,
        ["ROCK", "ROCKS"],
        _distRock,
        false,
        true
    ])) > 0) exitWith { true };

    if ((count (nearestObjects [
        _pos2D,
        ["House", "Wall", "Fence", "Thing", "Strategic", "Ruins"],
        _distEntity,
        true
    ])) > 0) exitWith { true };

    private _terrainZ = getTerrainHeightASL _pos2D;
    private _posASL = [_pos2D # 0, _pos2D # 1, _terrainZ];
    private _hits = lineIntersectsSurfaces [
        _posASL vectorAdd [0, 0, 0.25],
        _posASL vectorAdd [0, 0, 25],
        objNull,
        objNull,
        true,
        1,
        "GEOM",
        "NONE"
    ];

    if (_hits isNotEqualTo []) exitWith
    {
        private _hitObj = _hits # 0 # 2;
        private _hitParent = _hits # 0 # 3;

        (!isNull _hitParent && { _hitParent isKindOf "House" || { _hitParent isKindOf "Building" } }) ||
        { !isNull _hitObj && { _hitObj isKindOf "House" || { _hitObj isKindOf "Building" } } }
    };

    false
};

for "_i" from 1 to _count do
{
    private _found = false;
    private _spawnPos2D = [0, 0, 0];
    private _spawnPosASL = [0, 0, 0];
    private _attempt = 0;

    while { _attempt < _maxAttempts && { !_found } } do
    {
        private _angle = random 360;
        private _radiusScale = sqrt (random 1);
        private _px = (_center # 0) + (sin _angle) * ((_size # 0) * _radiusScale);
        private _py = (_center # 1) + (cos _angle) * ((_size # 1) * _radiusScale);

        _spawnPos2D = [_px, _py, 0];

        if !([_spawnPos2D] call _fnc_isBlocked) then
        {
            private _tooClose = false;

            {
                if ((_spawnPos2D distance2D _x) < _minDist) exitWith
                {
                    _tooClose = true;
                };
            } forEach _placed;

            if (!_tooClose) then
            {
                _spawnPosASL = [_px, _py, getTerrainHeightASL [_px, _py]];
                _found = true;
            };
        };

        _attempt = _attempt + 1;
    };

    if (_found) then
    {
        private _model = if ((random 1) < _bushChance) then
        {
            selectRandom _bushModels
        }
        else
        {
            selectRandom _treeModels
        };

        private _object = createSimpleObject [_model, _spawnPosASL];
        _object setDir (random 360);

        _placed pushBack _spawnPos2D;
    };
};

diag_log format ["[FOREST] Spawned vegetation objects: %1", count _placed];

true
