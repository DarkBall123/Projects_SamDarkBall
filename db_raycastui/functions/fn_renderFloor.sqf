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

private _floorHeightGrid = _state # DB_RUI_S_FLOOR_HEIGHT_GRID;
private _mapWidth = _state # DB_RUI_S_WIDTH;
private _mapHeight = _state # DB_RUI_S_HEIGHT;
private _player = _state # DB_RUI_S_PLAYER;
private _settings = _state # DB_RUI_S_SETTINGS;
private _fov = _settings # DB_RUI_CFG_FOV;
private _projectionScale = _settings # DB_RUI_CFG_PROJ_SCALE;
private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _playerDir = _player # DB_RUI_P_DIR;
private _playerTileX = floor _playerX;
private _playerTileY = floor _playerY;
private _time = diag_tickTime;
private _playerFloorHeight = DB_RUI_FLOOR_HEIGHT_DEFAULT;

if !(_floorHeightGrid isEqualTo []) then
{
    if ((_playerTileX >= 0) && {_playerTileX < _mapWidth} && {_playerTileY >= 0} && {_playerTileY < _mapHeight}) then
    {
        _playerFloorHeight = (_floorHeightGrid # _playerTileY) # _playerTileX;
    };
};

private _cameraZ = _playerFloorHeight + DB_RUI_CAMERA_EYE_HEIGHT;

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

private _cellCount = _rows * _cols;
private _colorBuffer = [];
private _priorityBuffer = [];
private _rayDirsX = [];
private _rayDirsY = [];

_colorBuffer resize _cellCount;
_priorityBuffer resize _cellCount;
_rayDirsX resize _cols;
_rayDirsY resize _cols;

for "_index" from 0 to (_cellCount - 1) do
{
    _colorBuffer set [_index, +_voidColor];
    _priorityBuffer set [_index, 0];
};

for "_column" from 0 to (_cols - 1) do
{
    private _cameraX = ((2 * (_column + 0.5)) / _cols) - 1;
    private _rayAngle = _playerDir + (_cameraX * (_fov * 0.5));
    _rayDirsX set [_column, cos _rayAngle];
    _rayDirsY set [_column, sin _rayAngle];
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
    private _baseDistance = ((DB_RUI_CAMERA_EYE_HEIGHT * _projectionScale) / _rowOffset) max 0.05;

    for "_column" from 0 to (_cols - 1) do
    {
        private _bufferIndex = (_row * _cols) + _column;
        private _rayDirX = _rayDirsX # _column;
        private _rayDirY = _rayDirsY # _column;
        private _distance = _baseDistance;
        private _worldX = _playerX + (_rayDirX * _distance);
        private _worldY = _playerY + (_rayDirY * _distance);
        private _tileX = floor _worldX;
        private _tileY = floor _worldY;
        private _tileColor = +_voidColor;
        private _priority = 1;

        if ((_tileX >= 0) && {_tileX < _mapWidth} && {_tileY >= 0} && {_tileY < _mapHeight}) then
        {
            private _floorType = ((_floorGrid # _tileY) # _tileX);

            if (_floorType > DB_RUI_FLOOR_VOID) then
            {
                private _floorHeight = if (_floorHeightGrid isEqualTo []) then
                {
                    DB_RUI_FLOOR_HEIGHT_DEFAULT
                }
                else
                {
                    (_floorHeightGrid # _tileY) # _tileX
                };

                if (abs (_floorHeight - _playerFloorHeight) > 0.01) then
                {
                    _distance = (((_cameraZ - _floorHeight) * _projectionScale) / _rowOffset) max 0.05;
                    _worldX = _playerX + (_rayDirX * _distance);
                    _worldY = _playerY + (_rayDirY * _distance);
                    _tileX = floor _worldX;
                    _tileY = floor _worldY;

                    if ((_tileX >= 0) && {_tileX < _mapWidth} && {_tileY >= 0} && {_tileY < _mapHeight}) then
                    {
                        _floorType = ((_floorGrid # _tileY) # _tileX);
                        _floorHeight = if (_floorHeightGrid isEqualTo []) then
                        {
                            DB_RUI_FLOOR_HEIGHT_DEFAULT
                        }
                        else
                        {
                            (_floorHeightGrid # _tileY) # _tileX
                        };
                    }
                    else
                    {
                        _floorType = DB_RUI_FLOOR_VOID;
                    };
                };

                if (_floorType > DB_RUI_FLOOR_VOID) then
                {
                    private _fracX = _worldX - _tileX;
                    private _fracY = _worldY - _tileY;
                    private _edgeDist = ((_fracX min (1 - _fracX)) min (_fracY min (1 - _fracY)));
                    private _shade = (1.12 - (_distance * 0.042)) max 0.14;
                    private _alpha = (0.96 - (_distance * 0.016)) max 0.42;
                    private _rimBand = DB_RUI_LAVA_RIM_BAND;
                    private _leftHeight = _floorHeight;
                    private _rightHeight = _floorHeight;
                    private _upHeight = _floorHeight;
                    private _downHeight = _floorHeight;

                    if (_tileX > 0) then
                    {
                        _leftHeight = if (_floorHeightGrid isEqualTo []) then
                        {
                            DB_RUI_FLOOR_HEIGHT_DEFAULT
                        }
                        else
                        {
                            (_floorHeightGrid # _tileY) # (_tileX - 1)
                        };
                    };

                    if (_tileX < (_mapWidth - 1)) then
                    {
                        _rightHeight = if (_floorHeightGrid isEqualTo []) then
                        {
                            DB_RUI_FLOOR_HEIGHT_DEFAULT
                        }
                        else
                        {
                            (_floorHeightGrid # _tileY) # (_tileX + 1)
                        };
                    };

                    if (_tileY > 0) then
                    {
                        _upHeight = if (_floorHeightGrid isEqualTo []) then
                        {
                            DB_RUI_FLOOR_HEIGHT_DEFAULT
                        }
                        else
                        {
                            (_floorHeightGrid # (_tileY - 1)) # _tileX
                        };
                    };

                    if (_tileY < (_mapHeight - 1)) then
                    {
                        _downHeight = if (_floorHeightGrid isEqualTo []) then
                        {
                            DB_RUI_FLOOR_HEIGHT_DEFAULT
                        }
                        else
                        {
                            (_floorHeightGrid # (_tileY + 1)) # _tileX
                        };
                    };

                    private _lowerLeft = _leftHeight < (_floorHeight - 0.05);
                    private _lowerRight = _rightHeight < (_floorHeight - 0.05);
                    private _lowerUp = _upHeight < (_floorHeight - 0.05);
                    private _lowerDown = _downHeight < (_floorHeight - 0.05);
                    private _higherLeft = _leftHeight > (_floorHeight + 0.05);
                    private _higherRight = _rightHeight > (_floorHeight + 0.05);
                    private _higherUp = _upHeight > (_floorHeight + 0.05);
                    private _higherDown = _downHeight > (_floorHeight + 0.05);

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
                        case DB_RUI_FLOOR_LAVA:
                        {
                            private _flow = 0.5 + (0.5 * ((sin ((_worldX * 170) + (_time * 240))) * (cos ((_worldY * 145) - (_time * 175)))));
                            private _pulse = 0.5 + (0.5 * sin (((_worldX + _worldY) * 210) + (_time * 420)));
                            private _rimFactor = 0;
                            private _wallDelta = 0;

                            if (_higherLeft && {_fracX < _rimBand}) then
                            {
                                _rimFactor = _rimFactor max ((_rimBand - _fracX) / _rimBand);
                                _wallDelta = _wallDelta max (_leftHeight - _floorHeight);
                            };

                            if (_higherRight && {_fracX > (1 - _rimBand)}) then
                            {
                                _rimFactor = _rimFactor max ((_fracX - (1 - _rimBand)) / _rimBand);
                                _wallDelta = _wallDelta max (_rightHeight - _floorHeight);
                            };

                            if (_higherUp && {_fracY < _rimBand}) then
                            {
                                _rimFactor = _rimFactor max ((_rimBand - _fracY) / _rimBand);
                                _wallDelta = _wallDelta max (_upHeight - _floorHeight);
                            };

                            if (_higherDown && {_fracY > (1 - _rimBand)}) then
                            {
                                _rimFactor = _rimFactor max ((_fracY - (1 - _rimBand)) / _rimBand);
                                _wallDelta = _wallDelta max (_downHeight - _floorHeight);
                            };

                            private _lavaColor =
                            [
                                ((0.44 + (_flow * 0.26) + (_pulse * 0.18)) * _shade) min 1,
                                ((0.07 + (_flow * 0.18) + (_pulse * 0.11)) * _shade) min 1,
                                ((0.01 + (_flow * 0.05)) * _shade) min 1,
                                (_alpha + 0.06) min 1
                            ];

                            if ((_rimFactor > 0) && {_wallDelta > 0.05}) then
                            {
                                private _wallShade = (_shade * (0.28 + (_rimFactor * 0.34))) max 0.10;
                                private _wallColor =
                                [
                                    ((0.13 + (_flow * 0.04)) * _wallShade) min 1,
                                    ((0.09 + (_pulse * 0.03)) * _wallShade) min 1,
                                    ((0.08 + (_pulse * 0.02)) * _wallShade) min 1,
                                    (_alpha + 0.03) min 1
                                ];
                                private _dropRows = ceil (((_wallDelta * _projectionScale) / (_distance max 0.40)) / _cellH);
                                private _surfaceIndex = 0;
                                _dropRows = (_dropRows max 1) min ((_rows - 1) - _row);
                                _surfaceIndex = (((_row + _dropRows) min (_rows - 1)) * _cols) + _column;
                                [_bufferIndex, _wallColor, 3] call _setCellColor;
                                [_surfaceIndex, _lavaColor, 4] call _setCellColor;
                                _priority = 0;
                            }
                            else
                            {
                                _tileColor = _lavaColor;
                            };
                        };
                        case DB_RUI_FLOOR_SLIME:
                        {
                            private _flow = 0.5 + (0.5 * ((sin ((_worldX * 155) + (_time * 210))) * (cos ((_worldY * 132) - (_time * 160)))));
                            private _pulse = 0.5 + (0.5 * sin (((_worldX + _worldY) * 185) + (_time * 320)));
                            private _rimFactor = 0;
                            private _wallDelta = 0;

                            if (_higherLeft && {_fracX < _rimBand}) then
                            {
                                _rimFactor = _rimFactor max ((_rimBand - _fracX) / _rimBand);
                                _wallDelta = _wallDelta max (_leftHeight - _floorHeight);
                            };

                            if (_higherRight && {_fracX > (1 - _rimBand)}) then
                            {
                                _rimFactor = _rimFactor max ((_fracX - (1 - _rimBand)) / _rimBand);
                                _wallDelta = _wallDelta max (_rightHeight - _floorHeight);
                            };

                            if (_higherUp && {_fracY < _rimBand}) then
                            {
                                _rimFactor = _rimFactor max ((_rimBand - _fracY) / _rimBand);
                                _wallDelta = _wallDelta max (_upHeight - _floorHeight);
                            };

                            if (_higherDown && {_fracY > (1 - _rimBand)}) then
                            {
                                _rimFactor = _rimFactor max ((_fracY - (1 - _rimBand)) / _rimBand);
                                _wallDelta = _wallDelta max (_downHeight - _floorHeight);
                            };

                            private _slimeColor =
                            [
                                ((0.05 + (_flow * 0.04)) * _shade) min 1,
                                ((0.34 + (_flow * 0.18) + (_pulse * 0.09)) * _shade) min 1,
                                ((0.09 + (_pulse * 0.04)) * _shade) min 1,
                                (_alpha + 0.08) min 1
                            ];

                            if ((_rimFactor > 0) && {_wallDelta > 0.05}) then
                            {
                                private _wallShade = (_shade * (0.30 + (_rimFactor * 0.34))) max 0.10;
                                private _wallColor =
                                [
                                    ((0.09 + (_flow * 0.03)) * _wallShade) min 1,
                                    ((0.12 + (_pulse * 0.04)) * _wallShade) min 1,
                                    ((0.08 + (_pulse * 0.02)) * _wallShade) min 1,
                                    (_alpha + 0.03) min 1
                                ];
                                private _dropRows = ceil (((_wallDelta * _projectionScale) / (_distance max 0.40)) / _cellH);
                                private _surfaceIndex = 0;
                                _dropRows = (_dropRows max 1) min ((_rows - 1) - _row);
                                _surfaceIndex = (((_row + _dropRows) min (_rows - 1)) * _cols) + _column;
                                [_bufferIndex, _wallColor, 3] call _setCellColor;
                                [_surfaceIndex, _slimeColor, 4] call _setCellColor;
                                _priority = 0;
                            }
                            else
                            {
                                _tileColor = _slimeColor;
                            };
                        };
                        default
                        {
                        };
                    };

                    if (_priority > 0) then
                    {
                        private _rimFactor = 0;

                        if (_lowerLeft && {_fracX < _rimBand}) then
                        {
                            _rimFactor = _rimFactor max ((_rimBand - _fracX) / _rimBand);
                        };

                        if (_lowerRight && {_fracX > (1 - _rimBand)}) then
                        {
                            _rimFactor = _rimFactor max ((_fracX - (1 - _rimBand)) / _rimBand);
                        };

                        if (_lowerUp && {_fracY < _rimBand}) then
                        {
                            _rimFactor = _rimFactor max ((_rimBand - _fracY) / _rimBand);
                        };

                        if (_lowerDown && {_fracY > (1 - _rimBand)}) then
                        {
                            _rimFactor = _rimFactor max ((_fracY - (1 - _rimBand)) / _rimBand);
                        };

                        if (_rimFactor > 0) then
                        {
                            _tileColor set [0, (((_tileColor # 0) * (1 - (_rimFactor * 0.30))) + (_rimFactor * 0.08 * _shade)) min 1];
                            _tileColor set [1, ((_tileColor # 1) * (1 - (_rimFactor * 0.34))) min 1];
                            _tileColor set [2, ((_tileColor # 2) * (1 - (_rimFactor * 0.46))) min 1];
                        };

                        [_bufferIndex, _tileColor, _priority] call _setCellColor;
                    };
                };
            };
        };
    };
};

for "_index" from 0 to (_cellCount - 1) do
{
    (_ctrls # _index) ctrlSetBackgroundColor (_colorBuffer # _index);
};

_state
