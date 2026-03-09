#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

disableSerialization;

if (_state isEqualTo []) exitWith
{
    _state
};

private _settings = _state # DB_RUI_S_SETTINGS;
private _player = _state # DB_RUI_S_PLAYER;
private _wallCtrls = _state # DB_RUI_S_WALL_CTRLS;
private _wallCache = _state # DB_RUI_S_WALL_CACHE;
private _columns = _settings # DB_RUI_CFG_COLUMNS;
private _colW = _settings # DB_RUI_CFG_COLUMN_W;
private _fov = _settings # DB_RUI_CFG_FOV;
private _projectionScale = _settings # DB_RUI_CFG_PROJ_SCALE;
private _rayStart = diag_tickTime;

private _zBuffer = +(_state # DB_RUI_S_ZBUFFER);

for "_column" from 0 to (_columns - 1) do
{
    private _ctrl = _wallCtrls # _column;
    private _cameraX = ((2 * (_column + 0.5)) / _columns) - 1;
    private _rayAngle = (_player # DB_RUI_P_DIR) + (_cameraX * (_fov * 0.5));
    private _ray = [_state, _rayAngle, _settings # DB_RUI_CFG_VIEW_DISTANCE, true] call DB_fnc_rui_castRay;

    private _wallType = _ray # 1;
    private _distance = _ray # 3;
    private _side = _ray # 4;
    private _texIndex = _ray # 6;

    if ((_wallType <= 0) || {_wallType > 3}) then
    {
        _wallType = 1;
    };

    private _slicePath = ((_wallCache # _wallType) # _texIndex);
    private _lineHeight = (_projectionScale / (_distance max 0.10)) min (DB_RUI_H * 1.15);
    private _lineY = (DB_RUI_H * 0.5) - (_lineHeight * 0.5);
    private _brightness = (1.08 - (_distance * 0.055)) max 0.24;

    if (_side == 1) then
    {
        _brightness = _brightness * 0.82;
    };

    _ctrl ctrlSetText _slicePath;
    _ctrl ctrlSetTextColor [_brightness, _brightness, _brightness, 1];
    _ctrl ctrlSetPosition [(_column * _colW), _lineY, _colW + pixelW, _lineHeight];
    _ctrl ctrlCommit 0;

    _zBuffer set [_column, _distance];
};

private _stats = _state # DB_RUI_S_STATS;
_stats set [DB_RUI_STATS_RAY_MS, ((_stats # DB_RUI_STATS_RAY_MS) * 0.75) + (((diag_tickTime - _rayStart) * 1000) * 0.25)];

_state set [DB_RUI_S_STATS, _stats];
_state set [DB_RUI_S_ZBUFFER, _zBuffer];
_state
