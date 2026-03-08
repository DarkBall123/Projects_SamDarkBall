#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]],
    ["_testX", 0, [0]],
    ["_testY", 0, [0]]
];

if (_state isEqualTo []) exitWith
{
    true
};

private _cellX = floor _testX;
private _cellY = floor _testY;
private _width = _state # DB_RUI_S_WIDTH;
private _height = _state # DB_RUI_S_HEIGHT;

if ((_cellX < 0) || {_cellX >= _width} || {_cellY < 0} || {_cellY >= _height}) exitWith
{
    true
};

private _grid = _state # DB_RUI_S_GRID;
(((_grid # _cellY) # _cellX) > 0)
