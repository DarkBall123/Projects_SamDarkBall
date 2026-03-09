#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

disableSerialization;

if (_state isEqualTo []) exitWith
{
    _state
};

private _floorMeta = _state # DB_RUI_S_FLOOR_META;
if (_floorMeta isEqualTo []) exitWith
{
    _state
};

private _ctrls = _floorMeta # DB_RUI_FM_CTRLS;
if (_ctrls isEqualTo []) exitWith
{
    _state
};

private _cols = _floorMeta # DB_RUI_FM_COLS;
private _rows = _floorMeta # DB_RUI_FM_ROWS;
private _cellW = _floorMeta # DB_RUI_FM_CELL_W;
private _cellH = _floorMeta # DB_RUI_FM_CELL_H;
private _floorGrid = _state # DB_RUI_S_FLOOR_GRID;
if (_floorGrid isEqualTo []) exitWith
{
    _state
};

private _mapWidth = _state # DB_RUI_S_WIDTH;
private _mapHeight = _state # DB_RUI_S_HEIGHT;
private _player = _state # DB_RUI_S_PLAYER;
private _settings = _state # DB_RUI_S_SETTINGS;
private _fov = _settings # DB_RUI_CFG_FOV;
private _projectionScale = _settings # DB_RUI_CFG_PROJ_SCALE;
private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _playerDir = _player # DB_RUI_P_DIR;
private _time = diag_tickTime;

private _voidColor = switch (_state # DB_RUI_S_FLOOR_STYLE) do
{
    case "stone":
    {
        [0.05, 0.05, 0.07, 0.78]
    };
    case "crucible":
    {
        [0.08, 0.04, 0.02, 0.80]
    };
    default
    {
        [0.06, 0.05, 0.04, 0.78]
    };
};

private _leftAngle = _playerDir - (_fov * 0.5);
private _rightAngle = _playerDir + (_fov * 0.5);
private _rayDirX0 = cos _leftAngle;
private _rayDirY0 = sin _leftAngle;
private _rayDirX1 = cos _rightAngle;
private _rayDirY1 = sin _rightAngle;
private _ctrlIndex = 0;

for "_row" from 0 to (_rows - 1) do
{
    private _rowOffset = ((_row + 0.5) * _cellH) max 0.001;
    private _rowDistance = ((0.5 * _projectionScale) / _rowOffset) max 0.01;
    private _shade = (1.10 - (_rowDistance * 0.045)) max 0.14;
    private _alpha = (0.95 - (_rowDistance * 0.018)) max 0.42;
    private _stepX = (_rowDistance * (_rayDirX1 - _rayDirX0)) / _cols;
    private _stepY = (_rowDistance * (_rayDirY1 - _rayDirY0)) / _cols;
    private _worldX = _playerX + (_rowDistance * _rayDirX0) + (_stepX * 0.5);
    private _worldY = _playerY + (_rowDistance * _rayDirY0) + (_stepY * 0.5);

    for "_column" from 0 to (_cols - 1) do
    {
        private _ctrl = _ctrls # _ctrlIndex;
        _ctrlIndex = _ctrlIndex + 1;

        private _tileColor = +_voidColor;
        _tileColor set [3, _alpha];

        private _tileX = floor _worldX;
        private _tileY = floor _worldY;

        if ((_tileX >= 0) && {_tileX < _mapWidth} && {_tileY >= 0} && {_tileY < _mapHeight}) then
        {
            private _floorType = ((_floorGrid # _tileY) # _tileX);

            if (_floorType > DB_RUI_FLOOR_VOID) then
            {
                private _fracX = _worldX - _tileX;
                private _fracY = _worldY - _tileY;
                private _edgeDist = ((_fracX min (1 - _fracX)) min (_fracY min (1 - _fracY)));

                switch (_floorType) do
                {
                    case DB_RUI_FLOOR_METAL:
                    {
                        private _stripe = 0.5 + (0.5 * sin ((_worldX * 960) + (_tileY * 26)));
                        private _plate = if (_edgeDist < 0.09) then {0.72} else {1};
                        _tileColor =
                        [
                            ((0.11 + (_stripe * 0.05)) * _shade * _plate) min 1,
                            ((0.10 + (_stripe * 0.04)) * _shade * _plate) min 1,
                            ((0.09 + (_stripe * 0.03)) * _shade * _plate) min 1,
                            _alpha
                        ];
                    };
                    case DB_RUI_FLOOR_STONE:
                    {
                        private _parity = ((_tileX + _tileY) mod 2);
                        private _grain = 0.5 + (0.5 * sin ((_worldX * 130) + (_worldY * 75)));
                        private _plate = if (_edgeDist < 0.08) then {0.78} else {1};
                        _tileColor =
                        [
                            ((0.13 + (_grain * 0.05) + (_parity * 0.02)) * _shade * _plate) min 1,
                            ((0.13 + (_grain * 0.05) + (_parity * 0.02)) * _shade * _plate) min 1,
                            ((0.15 + (_grain * 0.06) + (_parity * 0.03)) * _shade * _plate) min 1,
                            _alpha
                        ];
                    };
                    case DB_RUI_FLOOR_LAVA:
                    {
                        private _flow = 0.5 + (0.5 * ((sin ((_worldX * 170) + (_time * 240))) * (cos ((_worldY * 145) - (_time * 175)))));
                        private _pulse = 0.5 + (0.5 * sin (((_worldX + _worldY) * 210) + (_time * 420)));
                        private _crust = 1;
                        private _lavaEdge = false;

                        if (_tileX > 0) then
                        {
                            if (((_floorGrid # _tileY) # (_tileX - 1)) != DB_RUI_FLOOR_LAVA) then
                            {
                                _lavaEdge = true;
                            };
                        };

                        if (!_lavaEdge && {_tileX < (_mapWidth - 1)}) then
                        {
                            if (((_floorGrid # _tileY) # (_tileX + 1)) != DB_RUI_FLOOR_LAVA) then
                            {
                                _lavaEdge = true;
                            };
                        };

                        if (!_lavaEdge && {_tileY > 0}) then
                        {
                            if (((_floorGrid # (_tileY - 1)) # _tileX) != DB_RUI_FLOOR_LAVA) then
                            {
                                _lavaEdge = true;
                            };
                        };

                        if (!_lavaEdge && {_tileY < (_mapHeight - 1)}) then
                        {
                            if (((_floorGrid # (_tileY + 1)) # _tileX) != DB_RUI_FLOOR_LAVA) then
                            {
                                _lavaEdge = true;
                            };
                        };

                        if (_lavaEdge && {_edgeDist < 0.18}) then
                        {
                            _crust = 0.42 + (_edgeDist * 2.5);
                        };

                        _tileColor =
                        [
                            ((0.42 + (_flow * 0.27) + (_pulse * 0.16)) * _shade * _crust) min 1,
                            ((0.05 + (_flow * 0.18) + (_pulse * 0.10)) * _shade * _crust) min 1,
                            ((0.01 + (_flow * 0.05)) * _shade * _crust) min 1,
                            (_alpha + 0.04) min 1
                        ];
                    };
                    case DB_RUI_FLOOR_GRATE:
                    {
                        private _glow = 0.38 + (0.18 * (0.5 + (0.5 * sin (((_worldX + _worldY) * 180) + (_time * 180)))));
                        private _grateBar =
                            (_fracX < 0.08) ||
                            (_fracX > 0.92) ||
                            ((abs (_fracX - 0.5)) < 0.06) ||
                            (_fracY < 0.08) ||
                            (_fracY > 0.92) ||
                            ((abs (_fracY - 0.5)) < 0.06);

                        if (_grateBar) then
                        {
                            _tileColor =
                            [
                                (0.18 * _shade) min 1,
                                (0.18 * _shade) min 1,
                                (0.19 * _shade) min 1,
                                _alpha
                            ];
                        }
                        else
                        {
                            _tileColor =
                            [
                                ((0.11 + (_glow * 0.10)) * _shade) min 1,
                                ((0.07 + (_glow * 0.06)) * _shade) min 1,
                                ((0.05 + (_glow * 0.03)) * _shade) min 1,
                                _alpha
                            ];
                        };
                    };
                    default
                    {
                    };
                };
            };
        };

        _ctrl ctrlSetBackgroundColor _tileColor;
        _worldX = _worldX + _stepX;
        _worldY = _worldY + _stepY;
    };
};

_state
