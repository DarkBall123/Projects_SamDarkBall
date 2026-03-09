#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

disableSerialization;

if (_state isEqualTo []) then
{
    _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
};

if (_state isEqualTo []) exitWith
{
    []
};

uiNamespace setVariable [DB_RUI_SOUND_COOLDOWNS_VAR, createHashMap];

private _mapData = [(_state # DB_RUI_S_MAP_ID)] call DB_fnc_rui_loadMap;
private _mapName = "";
private _size = [0, 0];
private _grid = [];
private _floorGrid = [];
private _spawn = [1.5, 1.5, 0];
private _enemySpawns = [];
private _pickupSpawns = [];
private _skyStyle = "ember";
private _floorStyle = "crucible";

if ((count _mapData) >= 9) then
{
    _mapData params
    [
        "_mapName",
        "_size",
        "_grid",
        "_floorGrid",
        "_spawn",
        "_enemySpawns",
        "_pickupSpawns",
        "_skyStyle",
        "_floorStyle"
    ];
}
else
{
    _mapData params
    [
        "_mapName",
        "_size",
        "_grid",
        "_spawn",
        "_enemySpawns",
        "_pickupSpawns",
        "_skyStyle",
        "_floorStyle"
    ];
};

_size params ["_mapWidth", "_mapHeight"];
_spawn params ["_spawnX", "_spawnY", "_spawnDir"];

diag_log text format
[
    "[DB_RUI] resetRun map=%1 size=%2x%3 gridRows=%4 floorRows=%5 enemies=%6 pickups=%7",
    _mapName,
    _mapWidth,
    _mapHeight,
    count _grid,
    count _floorGrid,
    count _enemySpawns,
    count _pickupSpawns
];

if (_floorGrid isEqualTo []) then
{
    private _defaultFloor = switch (_floorStyle) do
    {
        case "stone":
        {
            DB_RUI_FLOOR_STONE
        };
        default
        {
            DB_RUI_FLOOR_METAL
        };
    };

    {
        private _floorRow = [];
        {
            _floorRow pushBack (if (_x > 0) then {DB_RUI_FLOOR_VOID} else {_defaultFloor});
        }
        forEach _x;
        _floorGrid pushBack _floorRow;
    }
    forEach _grid;
};

private _enemies = [];
{
    _x params ["_type", "_enemyX", "_enemyY"];
    _enemies pushBack [_type, _enemyX, _enemyY, 55, "idle", 0, 1.1, 0.95, 8.0, 0, true, 0];
}
forEach _enemySpawns;

private _pickups = [];
{
    _x params ["_type", "_pickupX", "_pickupY", "_value"];
    _pickups pushBack [_type, _pickupX, _pickupY, _value, true];
}
forEach _pickupSpawns;

private _player =
[
    _spawnX,
    _spawnY,
    _spawnDir,
    DB_RUI_PLAYER_MAX_HP,
    DB_RUI_START_RESERVE_AMMO,
    0,
    0,
    DB_RUI_WPN_PISTOL,
    DB_RUI_PISTOL_CLIP_SIZE,
    DB_RUI_SHOTGUN_CHAMBER_SIZE,
    0,
    DB_RUI_RELOAD_NONE,
    0,
    true
];
private _columnCount = (_state # DB_RUI_S_SETTINGS) # DB_RUI_CFG_COLUMNS;
private _zBuffer = [];
_zBuffer resize _columnCount;
_zBuffer = _zBuffer apply {999};

_state set [DB_RUI_S_MAP_NAME, _mapName];
_state set [DB_RUI_S_GRID, _grid];
_state set [DB_RUI_S_WIDTH, _mapWidth];
_state set [DB_RUI_S_HEIGHT, _mapHeight];
_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_ZBUFFER, _zBuffer];
_state set [DB_RUI_S_ENEMIES, _enemies];
_state set [DB_RUI_S_PICKUPS, _pickups];
_state set [DB_RUI_S_PROJECTILES, []];
_state set [DB_RUI_S_OUTCOME, ""];
_state set [DB_RUI_S_HELP_UNTIL, diag_tickTime + 14];
_state set [DB_RUI_S_SKY_STYLE, _skyStyle];
_state set [DB_RUI_S_FLOOR_STYLE, _floorStyle];
_state set [DB_RUI_S_FLOOR_GRID, _floorGrid];

private _input = [false, false, false, false, false, false, false, false];
_state set [DB_RUI_S_INPUT, _input];

private _stats = _state # DB_RUI_S_STATS;
_stats set [DB_RUI_STATS_LAST_TICK, diag_tickTime];
_stats set [DB_RUI_STATS_DELTA, 0.016];
_state set [DB_RUI_S_STATS, _stats];

private _hud = _state # DB_RUI_S_HUD_CTRLS;
private _ceilingCtrl = _hud # DB_RUI_HUD_CEILING;
private _floorCtrl = _hud # DB_RUI_HUD_FLOOR;
private _statusBarCtrl = _hud # DB_RUI_HUD_STATUS_BAR;
private _faceCtrl = _hud # DB_RUI_HUD_FACE;
private _armsCtrl = _hud # DB_RUI_HUD_ARMS;
private _outcomeCtrl = _hud # DB_RUI_HUD_OUTCOME;
private _floorMeta = _state # DB_RUI_S_FLOOR_META;

private _skyColor = switch (_skyStyle) do
{
    case "ember":
    {
        [0.30, 0.14, 0.03, 1]
    };
    default
    {
        [0.33, 0.07, 0.08, 1]
    };
};

private _floorColor = switch (_floorStyle) do
{
    case "crucible":
    {
        [0.17, 0.10, 0.07, 1]
    };
    case "stone":
    {
        [0.11, 0.11, 0.13, 1]
    };
    default
    {
        [0.08, 0.08, 0.08, 1]
    };
};

_ceilingCtrl ctrlSetBackgroundColor _skyColor;
_floorCtrl ctrlSetBackgroundColor _floorColor;
_statusBarCtrl ctrlSetText DB_RUI_TX_STATUS_BAR;
_statusBarCtrl ctrlSetTextColor [1, 1, 1, 1];
_statusBarCtrl ctrlShow false;
_faceCtrl ctrlSetText DB_RUI_TX_FACE_IDLE;
_faceCtrl ctrlShow false;
_armsCtrl ctrlShow false;
_outcomeCtrl ctrlSetStructuredText parseText "";

if !(_floorMeta isEqualTo []) then
{
    {
        _x ctrlSetBackgroundColor [0, 0, 0, 0];
    }
    forEach (_floorMeta # DB_RUI_FM_CTRLS);
};

{
    {
        _x ctrlShow false;
        _x ctrlSetPosition [0, 0, 0, 0];
        _x ctrlCommit 0;
    }
    forEach _x;
}
forEach (_state # DB_RUI_S_SPRITE_POOL);

_state
