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
private _cellCount = _rows * _cols;
private _colorBuffer = [];
private _priorityBuffer = [];

_colorBuffer resize _cellCount;
_priorityBuffer resize _cellCount;

for "_index" from 0 to (_cellCount - 1) do
{
    _colorBuffer set [_index, +_voidColor];
    _priorityBuffer set [_index, 0];
};

private _setCellColor =
{
    params ["_index", "_color", "_priority"];

    if ((_index >= 0) && {_index < _cellCount} && {_priority >= (_priorityBuffer # _index)}) then
    {
        _colorBuffer set [_index, +_color];
        _priorityBuffer set [_index, _priority];
    };
};

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
        private _bufferIndex = (_row * _cols) + _column;
        private _writeDefault = true;

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
                private _lavaBand = DB_RUI_LAVA_RIM_BAND;
                private _nearLeft = false;
                private _nearRight = false;
                private _nearUp = false;
                private _nearDown = false;

                if (_tileX > 0) then
                {
                    private _leftType = ((_floorGrid # _tileY) # (_tileX - 1));
                    _nearLeft = (_leftType isEqualTo DB_RUI_FLOOR_LAVA) || {_leftType isEqualTo DB_RUI_FLOOR_SLIME};
                };

                if (_tileX < (_mapWidth - 1)) then
                {
                    private _rightType = ((_floorGrid # _tileY) # (_tileX + 1));
                    _nearRight = (_rightType isEqualTo DB_RUI_FLOOR_LAVA) || {_rightType isEqualTo DB_RUI_FLOOR_SLIME};
                };

                if (_tileY > 0) then
                {
                    private _upType = ((_floorGrid # (_tileY - 1)) # _tileX);
                    _nearUp = (_upType isEqualTo DB_RUI_FLOOR_LAVA) || {_upType isEqualTo DB_RUI_FLOOR_SLIME};
                };

                if (_tileY < (_mapHeight - 1)) then
                {
                    private _downType = ((_floorGrid # (_tileY + 1)) # _tileX);
                    _nearDown = (_downType isEqualTo DB_RUI_FLOOR_LAVA) || {_downType isEqualTo DB_RUI_FLOOR_SLIME};
                };

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
                        private _rimFactor = 0;
                        private _dropRows = ceil (((DB_RUI_LAVA_PIT_DEPTH * _projectionScale) / (_rowDistance max 0.75)) / _cellH);
                        private _shadowColor =
                        [
                            ((0.03 + (_pulse * 0.02)) * _shade) min 1,
                            ((0.01 + (_flow * 0.01)) * _shade) min 1,
                            ((0.01 + (_flow * 0.01)) * _shade) min 1,
                            (_alpha + 0.02) min 1
                        ];

                        if ((_tileX > 0) && {!_nearLeft} && {_fracX < _lavaBand}) then
                        {
                            _rimFactor = _rimFactor max ((_lavaBand - _fracX) / _lavaBand);
                        };

                        if ((_tileX < (_mapWidth - 1)) && {!_nearRight} && {_fracX > (1 - _lavaBand)}) then
                        {
                            _rimFactor = _rimFactor max ((_fracX - (1 - _lavaBand)) / _lavaBand);
                        };

                        if ((_tileY > 0) && {!_nearUp} && {_fracY < _lavaBand}) then
                        {
                            _rimFactor = _rimFactor max ((_lavaBand - _fracY) / _lavaBand);
                        };

                        if ((_tileY < (_mapHeight - 1)) && {!_nearDown} && {_fracY > (1 - _lavaBand)}) then
                        {
                            _rimFactor = _rimFactor max ((_fracY - (1 - _lavaBand)) / _lavaBand);
                        };

                        _dropRows = (_dropRows max 1) min ((_rows - 1) - _row);

                        private _pitWallColor = if (_rimFactor > 0) then
                        {
                            private _wallShade = (_shade * (0.32 + (_rimFactor * 0.34))) max 0.10;
                            [
                                ((0.22 + (_flow * 0.08)) * _wallShade) min 1,
                                ((0.08 + (_pulse * 0.04)) * _wallShade) min 1,
                                ((0.03 + (_pulse * 0.02)) * _wallShade) min 1,
                                (_alpha + 0.03) min 1
                            ]
                        }
                        else
                        {
                            _shadowColor
                        };

                        private _lavaColor =
                        [
                            ((0.44 + (_flow * 0.26) + (_pulse * 0.18)) * _shade) min 1,
                            ((0.07 + (_flow * 0.18) + (_pulse * 0.11)) * _shade) min 1,
                            ((0.01 + (_flow * 0.05)) * _shade) min 1,
                            (_alpha + 0.06) min 1
                        ];

                        [_bufferIndex, _pitWallColor, 2] call _setCellColor;
                        if (_dropRows > 0) then
                        {
                            private _lavaIndex = (((_row + _dropRows) min (_rows - 1)) * _cols) + _column;
                            [_lavaIndex, _lavaColor, 3] call _setCellColor;
                        }
                        else
                        {
                            [_bufferIndex, _lavaColor, 3] call _setCellColor;
                        };

                        _writeDefault = false;
                    };
                    case DB_RUI_FLOOR_SLIME:
                    {
                        private _flow = 0.5 + (0.5 * ((sin ((_worldX * 155) + (_time * 210))) * (cos ((_worldY * 132) - (_time * 160)))));
                        private _pulse = 0.5 + (0.5 * sin (((_worldX + _worldY) * 185) + (_time * 320)));
                        private _rimFactor = 0;
                        private _dropRows = ceil (((DB_RUI_LAVA_PIT_DEPTH * _projectionScale) / (_rowDistance max 0.75)) / _cellH);
                        private _shadowColor =
                        [
                            ((0.02 + (_pulse * 0.01)) * _shade) min 1,
                            ((0.04 + (_flow * 0.02)) * _shade) min 1,
                            ((0.02 + (_flow * 0.01)) * _shade) min 1,
                            (_alpha + 0.02) min 1
                        ];

                        if ((_tileX > 0) && {!_nearLeft} && {_fracX < _lavaBand}) then
                        {
                            _rimFactor = _rimFactor max ((_lavaBand - _fracX) / _lavaBand);
                        };

                        if ((_tileX < (_mapWidth - 1)) && {!_nearRight} && {_fracX > (1 - _lavaBand)}) then
                        {
                            _rimFactor = _rimFactor max ((_fracX - (1 - _lavaBand)) / _lavaBand);
                        };

                        if ((_tileY > 0) && {!_nearUp} && {_fracY < _lavaBand}) then
                        {
                            _rimFactor = _rimFactor max ((_lavaBand - _fracY) / _lavaBand);
                        };

                        if ((_tileY < (_mapHeight - 1)) && {!_nearDown} && {_fracY > (1 - _lavaBand)}) then
                        {
                            _rimFactor = _rimFactor max ((_fracY - (1 - _lavaBand)) / _lavaBand);
                        };

                        _dropRows = (_dropRows max 1) min ((_rows - 1) - _row);

                        private _pitWallColor = if (_rimFactor > 0) then
                        {
                            private _wallShade = (_shade * (0.34 + (_rimFactor * 0.36))) max 0.10;
                            [
                                ((0.06 + (_flow * 0.03)) * _wallShade) min 1,
                                ((0.19 + (_pulse * 0.06)) * _wallShade) min 1,
                                ((0.08 + (_pulse * 0.03)) * _wallShade) min 1,
                                (_alpha + 0.03) min 1
                            ]
                        }
                        else
                        {
                            _shadowColor
                        };

                        private _slimeColor =
                        [
                            ((0.05 + (_flow * 0.04)) * _shade) min 1,
                            ((0.34 + (_flow * 0.18) + (_pulse * 0.09)) * _shade) min 1,
                            ((0.09 + (_pulse * 0.04)) * _shade) min 1,
                            (_alpha + 0.08) min 1
                        ];

                        [_bufferIndex, _pitWallColor, 2] call _setCellColor;
                        if (_dropRows > 0) then
                        {
                            private _slimeIndex = (((_row + _dropRows) min (_rows - 1)) * _cols) + _column;
                            [_slimeIndex, _slimeColor, 3] call _setCellColor;
                        }
                        else
                        {
                            [_bufferIndex, _slimeColor, 3] call _setCellColor;
                        };

                        _writeDefault = false;
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

                if (_writeDefault) then
                {
                    private _rimFactor = 0;

                    if (_nearLeft && {_fracX < _lavaBand}) then
                    {
                        _rimFactor = _rimFactor max ((_lavaBand - _fracX) / _lavaBand);
                    };

                    if (_nearRight && {_fracX > (1 - _lavaBand)}) then
                    {
                        _rimFactor = _rimFactor max ((_fracX - (1 - _lavaBand)) / _lavaBand);
                    };

                    if (_nearUp && {_fracY < _lavaBand}) then
                    {
                        _rimFactor = _rimFactor max ((_lavaBand - _fracY) / _lavaBand);
                    };

                    if (_nearDown && {_fracY > (1 - _lavaBand)}) then
                    {
                        _rimFactor = _rimFactor max ((_fracY - (1 - _lavaBand)) / _lavaBand);
                    };

                    if (_rimFactor > 0) then
                    {
                        _tileColor set [0, (((_tileColor # 0) * (1 - (_rimFactor * 0.24))) + (_rimFactor * 0.08 * _shade)) min 1];
                        _tileColor set [1, ((_tileColor # 1) * (1 - (_rimFactor * 0.30))) min 1];
                        _tileColor set [2, ((_tileColor # 2) * (1 - (_rimFactor * 0.42))) min 1];
                    };
                };
            };
        };

        if (_writeDefault) then
        {
            [_bufferIndex, _tileColor, 1] call _setCellColor;
        };

        _worldX = _worldX + _stepX;
        _worldY = _worldY + _stepY;
    };
};

for "_index" from 0 to (_cellCount - 1) do
{
    (_ctrls # _index) ctrlSetBackgroundColor (_colorBuffer # _index);
};

_state
