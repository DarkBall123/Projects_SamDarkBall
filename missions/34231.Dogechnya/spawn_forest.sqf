if (!isServer) exitWith {};

// =========================
// НАСТРОЙКИ
// =========================
private _markerName   = "forest_1";  // имя маркера в Eden
private _count        = 750;         // сколько всего объектов растительности
private _maxAttempts  = 10;          // попыток найти точку для каждого объекта
private _minDist      = 4.5;         // минимальная дистанция между новыми объектами

// Буферы от окружения
private _distRoad     = 10;          // дороги / main road / track / trail
private _distHouse    = 10;          // дома / здания
private _distWall     = 6;           // стены / заборы
private _distRock     = 4;           // камни
private _distEntity   = 10;          // вручную поставленные объекты рядом

// Шанс куста среди всей растительности
private _bushChance   = 0.30;        // 0.30 = 30% кустов, 70% деревьев

private _center = getMarkerPos _markerName;
private _size   = getMarkerSize _markerName;

// =========================
// МОДЕЛИ
// =========================

// Плотные деревья / густые кроны
private _treeModels = [
    "a3\vegetation_f_exp\tree\t_Ficus_big_F.p3d",
    "a3\vegetation_f_exp\tree\t_Inocarpus_F.p3d",
    "a3\vegetation_f_exp\tree\t_Leucaena_F.p3d",
    "a3\vegetation_f_exp\tree\t_Millettia_F.p3d",
    "a3\plants_f\Tree\t_FicusB1s_F.p3d",
    "a3\plants_f\Tree\t_FicusB2s_F.p3d",
    "a3\plants_f\Tree\t_BroussonetiaP1s_F.p3d"
];

// Кусты
private _bushModels = [
    "a3\plants_f\bush\b_neriumo2s_white_f.p3d",
    "a3\plants_f\bush\b_thistle_thorn_green.p3d"
];

// Сюда будем сохранять уже занятые точки
private _placed = [];

// =========================
// ФУНКЦИИ
// =========================

// Проверка дороги
private _fnc_isOnOrNearRoad = {
    params ["_pos2D", "_distRoad"];

    if (isOnRoad _pos2D) exitWith { true };
    if (!isNull (roadAt _pos2D)) exitWith { true };
    if (count (_pos2D nearRoads _distRoad) > 0) exitWith { true };

    if (count (nearestTerrainObjects [
        _pos2D,
        ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"],
        _distRoad,
        false,
        true
    ]) > 0) exitWith { true };

    false
};

// Главная проверка "точка занята / плохая"
private _fnc_isBlocked = {
    params [
        "_pos2D",
        "_distRoad",
        "_distHouse",
        "_distWall",
        "_distRock",
        "_distEntity"
    ];

    // вода
    if (surfaceIsWater _pos2D) exitWith { true };

    // дороги
    if ([_pos2D, _distRoad] call _fnc_isOnOrNearRoad) exitWith { true };

    // terrain-дома / строения
    if (count (nearestTerrainObjects [
        _pos2D,
        ["HOUSE", "BUILDING", "BUNKER", "BUSSTOP", "FUELSTATION", "VIEW-TOWER", "WATERTOWER", "STACK", "RUIN"],
        _distHouse,
        false,
        true
    ]) > 0) exitWith { true };

    // terrain-стены / заборы
    if (count (nearestTerrainObjects [
        _pos2D,
        ["WALL", "FENCE"],
        _distWall,
        false,
        true
    ]) > 0) exitWith { true };

    // terrain-камни
    if (count (nearestTerrainObjects [
        _pos2D,
        ["ROCK", "ROCKS"],
        _distRock,
        false,
        true
    ]) > 0) exitWith { true };

    // editor-placed / scripted объекты
    private _nearEntities = nearestObjects [
        _pos2D,
        ["House", "Wall", "Fence", "Thing", "Strategic", "Ruins"],
        _distEntity,
        true
    ];

    if (count _nearEntities > 0) exitWith { true };

    // Проверка "под крышей / внутри здания / под мостом"
    private _terrainZ = getTerrainHeightASL _pos2D;
    private _posASL   = [_pos2D # 0, _pos2D # 1, _terrainZ];

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

    if (count _hits > 0) then {
        private _hitObj    = _hits # 0 # 2;
        private _hitParent = _hits # 0 # 3;

        if (!isNull _hitParent && { _hitParent isKindOf "House" }) exitWith { true };
        if (!isNull _hitObj    && { _hitObj    isKindOf "House" }) exitWith { true };

        // под мостами / крупными объектами тоже не спавнить
        if (!isNull _hitParent && { _hitParent isKindOf "Building" }) exitWith { true };
        if (!isNull _hitObj    && { _hitObj    isKindOf "Building" }) exitWith { true };
    };

    false
};

// =========================
// ОСНОВНОЙ ЦИКЛ
// =========================
for "_i" from 1 to _count do {
    private _found       = false;
    private _spawnPos2D  = [0, 0, 0];
    private _spawnPosASL = [0, 0, 0];

    for "_j" from 1 to _maxAttempts do {
        // Случайная точка внутри эллипса маркера
        private _angle = random 360;
        private _r     = sqrt (random 1);

        private _px = (_center # 0) + (sin _angle) * ((_size # 0) * _r);
        private _py = (_center # 1) + (cos _angle) * ((_size # 1) * _r);

        _spawnPos2D = [_px, _py, 0];

        private _blocked = [
            _spawnPos2D,
            _distRoad,
            _distHouse,
            _distWall,
            _distRock,
            _distEntity
        ] call _fnc_isBlocked;

        if (!_blocked) then {
            private _tooClose = false;

            {
                if (_spawnPos2D distance2D _x < _minDist) exitWith {
                    _tooClose = true;
                };
            } forEach _placed;

            if (!_tooClose) then {
                _spawnPosASL = [_px, _py, getTerrainHeightASL [_px, _py]];
                _found = true;
                break;
            };
        };
    };

    if (_found) then {
        private _model = "";

        if ((random 1) < _bushChance) then {
            _model = selectRandom _bushModels;
        } else {
            _model = selectRandom _treeModels;
        };

        private _obj = createSimpleObject [_model, _spawnPosASL];
        _obj setDir (random 360);

        _placed pushBack _spawnPos2D;
    };
};

diag_log format ["[FOREST] Spawned vegetation objects: %1", count _placed];