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
private _stepCtrls = _state # DB_RUI_S_STEP_CTRLS;
private _wallCache = _state # DB_RUI_S_WALL_CACHE;
private _columns = _settings # DB_RUI_CFG_COLUMNS;
private _colW = _settings # DB_RUI_CFG_COLUMN_W;
private _fov = _settings # DB_RUI_CFG_FOV;
private _projectionScale = _settings # DB_RUI_CFG_PROJ_SCALE;
private _mapWidth = _state # DB_RUI_S_WIDTH;
private _mapHeight = _state # DB_RUI_S_HEIGHT;
private _floorHeightGrid = _state # DB_RUI_S_FLOOR_HEIGHT_GRID;
private _rayStart = diag_tickTime;

private _zBuffer = +(_state # DB_RUI_S_ZBUFFER);
private _horizonY = DB_RUI_H * 0.5;
private _playerFloorHeight = _state # DB_RUI_S_CAMERA_FLOOR;
private _cameraZ = _playerFloorHeight + DB_RUI_CAMERA_EYE_HEIGHT;
private _getFloorHeightAt =
{
    params ["_tileX", "_tileY"];

    if !(_floorHeightGrid isEqualTo []) then
    {
        if ((_tileX >= 0) && {_tileX < _mapWidth} && {_tileY >= 0} && {_tileY < _mapHeight}) exitWith
        {
            (_floorHeightGrid # _tileY) # _tileX
        };
    };

    DB_RUI_FLOOR_HEIGHT_DEFAULT
};

for "_column" from 0 to (_columns - 1) do
{
    private _ctrl = _wallCtrls # _column;
    private _stepCtrl = _stepCtrls # _column;
    private _cameraX = ((2 * (_column + 0.5)) / _columns) - 1;
    private _rayAngle = (_player # DB_RUI_P_DIR) + (_cameraX * (_fov * 0.5));
    private _ray = [_state, _rayAngle, _settings # DB_RUI_CFG_VIEW_DISTANCE, true] call DB_fnc_rui_castRay;

    private _wallType = _ray # 1;
    private _distance = _ray # 3;
    private _side = _ray # 4;
    private _texIndex = _ray # 6;
    private _hitTileX = _ray # 7;
    private _hitTileY = _ray # 8;
    private _stepX = _ray # 9;
    private _stepY = _ray # 10;
    private _stepDistance = _ray # 11;
    private _stepNearHeight = _ray # 12;
    private _stepFarHeight = _ray # 13;

    if ((_wallType <= 0) || {_wallType > 3}) then
    {
        _wallType = 1;
    };

    private _sectorTileX = _hitTileX;
    private _sectorTileY = _hitTileY;
    if (_side == 0) then
    {
        _sectorTileX = _hitTileX - _stepX;
    }
    else
    {
        _sectorTileY = _hitTileY - _stepY;
    };

    private _distanceSafe = _distance max 0.10;
    private _sectorFloorHeight = [_sectorTileX, _sectorTileY] call _getFloorHeightAt;
    private _slicePath = ((_wallCache # _wallType) # _texIndex);
    private _lineTop = _horizonY - (((DB_RUI_CEILING_HEIGHT - _cameraZ) * _projectionScale) / _distanceSafe);
    private _lineBottom = _horizonY - (((_sectorFloorHeight - _cameraZ) * _projectionScale) / _distanceSafe);
    private _lineHeight = (_lineBottom - _lineTop) max (pixelH * 2);
    private _brightness = (1.08 - (_distanceSafe * 0.055)) max 0.24;

    if (_side == 1) then
    {
        _brightness = _brightness * 0.82;
    };

    if (_lineBottom < _lineTop) then
    {
        private _swap = _lineTop;
        _lineTop = _lineBottom;
        _lineBottom = _swap;
        _lineHeight = (_lineBottom - _lineTop) max (pixelH * 2);
    };

    _lineHeight = _lineHeight min (DB_RUI_H * 2.40);

    _ctrl ctrlSetText _slicePath;
    _ctrl ctrlSetTextColor [_brightness, _brightness, _brightness, 1];
    _ctrl ctrlSetPosition [(_column * _colW), _lineTop, _colW + pixelW, _lineHeight];
    _ctrl ctrlCommit 0;

    _stepCtrl ctrlShow false;
    _stepCtrl ctrlSetPosition [0, 0, 0, 0];
    _stepCtrl ctrlCommit 0;

    if (_stepDistance > 0) then
    {
        private _stepDistanceSafe = _stepDistance max 0.10;
        private _stepTopWorld = _stepNearHeight max _stepFarHeight;
        private _stepBottomWorld = _stepNearHeight min _stepFarHeight;
        private _stepTop = _horizonY - (((_stepTopWorld - _cameraZ) * _projectionScale) / _stepDistanceSafe);
        private _stepBottom = _horizonY - (((_stepBottomWorld - _cameraZ) * _projectionScale) / _stepDistanceSafe);
        private _stepHeight = (_stepBottom - _stepTop) max (pixelH * 2);
        private _stepShade = (0.34 - (_stepDistanceSafe * 0.012)) max 0.12;
        private _stepAlpha = 0.94;

        if (_stepFarHeight < _stepNearHeight) then
        {
            _stepShade = _stepShade * 0.92;
        };

        if (_stepBottom < _stepTop) then
        {
            private _swap = _stepTop;
            _stepTop = _stepBottom;
            _stepBottom = _swap;
            _stepHeight = (_stepBottom - _stepTop) max (pixelH * 2);
        };

        _stepCtrl ctrlShow true;
        _stepCtrl ctrlSetBackgroundColor [_stepShade, _stepShade * 0.92, _stepShade * 0.88, _stepAlpha];
        _stepCtrl ctrlSetPosition [(_column * _colW), _stepTop, _colW + pixelW, (_stepHeight min (DB_RUI_H * 1.30))];
        _stepCtrl ctrlCommit 0;
    };

    _zBuffer set [_column, _distanceSafe];
};

private _stats = _state # DB_RUI_S_STATS;
_stats set [DB_RUI_STATS_RAY_MS, ((_stats # DB_RUI_STATS_RAY_MS) * 0.75) + (((diag_tickTime - _rayStart) * 1000) * 0.25)];

_state set [DB_RUI_S_STATS, _stats];
_state set [DB_RUI_S_ZBUFFER, _zBuffer];
_state
