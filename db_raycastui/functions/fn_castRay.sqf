#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]],
    ["_rayAngle", 0, [0]],
    ["_maxDistance", 999, [0]],
    ["_correctFisheye", true, [true]]
];

if (_state isEqualTo []) exitWith
{
    [false, 0, _maxDistance, _maxDistance, 0, 0, 0, -1, -1, 0, 0, -1, 0, 0]
};

private _grid = _state # DB_RUI_S_GRID;
private _floorHeightGrid = _state # DB_RUI_S_FLOOR_HEIGHT_GRID;
private _width = _state # DB_RUI_S_WIDTH;
private _height = _state # DB_RUI_S_HEIGHT;
private _player = _state # DB_RUI_S_PLAYER;
private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _playerDir = _player # DB_RUI_P_DIR;

private _angle = ((_rayAngle % 360) + 360) % 360;
private _rayDirX = cos _angle;
private _rayDirY = sin _angle;

private _mapX = floor _playerX;
private _mapY = floor _playerY;

private _deltaDistX = if ((abs _rayDirX) < DB_RUI_DIFFERENCE_EPSILON) then {1e9} else {abs (1 / _rayDirX)};
private _deltaDistY = if ((abs _rayDirY) < DB_RUI_DIFFERENCE_EPSILON) then {1e9} else {abs (1 / _rayDirY)};

private _stepX = 1;
private _stepY = 1;
private _sideDistX = 0;
private _sideDistY = 0;

if (_rayDirX < 0) then
{
    _stepX = -1;
    _sideDistX = (_playerX - _mapX) * _deltaDistX;
}
else
{
    _sideDistX = ((_mapX + 1) - _playerX) * _deltaDistX;
};

if (_rayDirY < 0) then
{
    _stepY = -1;
    _sideDistY = (_playerY - _mapY) * _deltaDistY;
}
else
{
    _sideDistY = ((_mapY + 1) - _playerY) * _deltaDistY;
};

private _hit = false;
private _side = 0;
private _wallType = 0;
private _rawDistance = _maxDistance;
private _prevTileX = _mapX;
private _prevTileY = _mapY;
private _prevFloorHeight = DB_RUI_FLOOR_HEIGHT_DEFAULT;
private _stepDistance = -1;
private _stepNearHeight = DB_RUI_FLOOR_HEIGHT_DEFAULT;
private _stepFarHeight = DB_RUI_FLOOR_HEIGHT_DEFAULT;

if !(_floorHeightGrid isEqualTo []) then
{
    if ((_mapX >= 0) && {_mapX < _width} && {_mapY >= 0} && {_mapY < _height}) then
    {
        _prevFloorHeight = (_floorHeightGrid # _mapY) # _mapX;
    };
};

for "_step" from 0 to 128 do
{
    _prevTileX = _mapX;
    _prevTileY = _mapY;

    if (_sideDistX < _sideDistY) then
    {
        _sideDistX = _sideDistX + _deltaDistX;
        _mapX = _mapX + _stepX;
        _side = 0;
    }
    else
    {
        _sideDistY = _sideDistY + _deltaDistY;
        _mapY = _mapY + _stepY;
        _side = 1;
    };

    if (_side == 0) then
    {
        if ((abs _rayDirX) < DB_RUI_DIFFERENCE_EPSILON) then
        {
            _rawDistance = _maxDistance;
        }
        else
        {
            _rawDistance = ((_mapX - _playerX) + ((1 - _stepX) * 0.5)) / _rayDirX;
        };
    }
    else
    {
        if ((abs _rayDirY) < DB_RUI_DIFFERENCE_EPSILON) then
        {
            _rawDistance = _maxDistance;
        }
        else
        {
            _rawDistance = ((_mapY - _playerY) + ((1 - _stepY) * 0.5)) / _rayDirY;
        };
    };

    _rawDistance = abs _rawDistance;
    if (_rawDistance > _maxDistance) exitWith {};

    if ((_mapX < 0) || {_mapX >= _width} || {_mapY < 0} || {_mapY >= _height}) then
    {
        _hit = true;
        _wallType = 1;
    }
    else
    {
        _wallType = (_grid # _mapY) # _mapX;
        _hit = _wallType > 0;

        if (!_hit && {_stepDistance < 0} && !(_floorHeightGrid isEqualTo []) && {_prevTileX >= 0} && {_prevTileX < _width} && {_prevTileY >= 0} && {_prevTileY < _height}) then
        {
            private _nextFloorHeight = (_floorHeightGrid # _mapY) # _mapX;

            if (abs (_nextFloorHeight - _prevFloorHeight) > 0.05) then
            {
                _stepDistance = _rawDistance;
                _stepNearHeight = _prevFloorHeight;
                _stepFarHeight = _nextFloorHeight;
            };

            _prevFloorHeight = _nextFloorHeight;
        };
    };

    if (_hit) exitWith {};
};

if (!_hit) exitWith
{
    [false, 0, _maxDistance, _maxDistance, _side, 0, 0, _mapX, _mapY, _stepX, _stepY, _stepDistance, _stepNearHeight, _stepFarHeight]
};

private _wallCoord = 0;
if (_side == 0) then
{
    _wallCoord = _playerY + (_rawDistance * _rayDirY);
}
else
{
    _wallCoord = _playerX + (_rawDistance * _rayDirX);
};

_wallCoord = _wallCoord - floor _wallCoord;

private _texIndex = floor (_wallCoord * DB_RUI_SLICE_COUNT);
_texIndex = (_texIndex max 0) min (DB_RUI_SLICE_COUNT - 1);

private _perpendicularDistance = if (_correctFisheye) then
{
    (_rawDistance * cos (_angle - _playerDir)) max 0.01
}
else
{
    _rawDistance max 0.01
};

[true, _wallType, _rawDistance, _perpendicularDistance, _side, _wallCoord, _texIndex, _mapX, _mapY, _stepX, _stepY, _stepDistance, _stepNearHeight, _stepFarHeight]
