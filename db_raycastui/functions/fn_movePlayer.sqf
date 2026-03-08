#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

if (_state isEqualTo []) exitWith
{
    _state
};

if !((_state # DB_RUI_S_OUTCOME) isEqualTo "") exitWith
{
    _state
};

private _settings = _state # DB_RUI_S_SETTINGS;
private _player = +(_state # DB_RUI_S_PLAYER);
private _input = _state # DB_RUI_S_INPUT;
private _grid = _state # DB_RUI_S_GRID;
private _width = _state # DB_RUI_S_WIDTH;
private _height = _state # DB_RUI_S_HEIGHT;
private _stats = _state # DB_RUI_S_STATS;
private _delta = _stats # DB_RUI_STATS_DELTA;

private _moveAxis = 0;
if (_input # DB_RUI_IN_FORWARD) then
{
    _moveAxis = _moveAxis + 1;
};

if (_input # DB_RUI_IN_BACK) then
{
    _moveAxis = _moveAxis - 1;
};

private _turnAxis = 0;
if (_input # DB_RUI_IN_TURN_RIGHT) then
{
    _turnAxis = _turnAxis + 1;
};

if (_input # DB_RUI_IN_TURN_LEFT) then
{
    _turnAxis = _turnAxis - 1;
};

private _dir = (_player # DB_RUI_P_DIR) + (_turnAxis * ((_settings # DB_RUI_CFG_TURN_SPEED) * _delta));
_dir = ((_dir % 360) + 360) % 360;

private _moveDistance = (_settings # DB_RUI_CFG_MOVE_SPEED) * _delta * _moveAxis;
private _stepX = (cos _dir) * _moveDistance;
private _stepY = (sin _dir) * _moveDistance;

private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _radius = 0.18;

private _isBlocked =
{
    params ["_testX", "_testY"];
    private _cellX = floor _testX;
    private _cellY = floor _testY;

    if ((_cellX < 0) || {_cellX >= _width} || {_cellY < 0} || {_cellY >= _height}) exitWith
    {
        true
    };

    ((_grid # _cellY) # _cellX) > 0
};

if (_moveAxis != 0) then
{
    private _nextX = _playerX + _stepX;
    private _checkX = _nextX + (_radius * (if (_stepX >= 0) then {1} else {-1}));
    if !([_checkX, _playerY] call _isBlocked) then
    {
        _playerX = _nextX;
    };

    private _nextY = _playerY + _stepY;
    private _checkY = _nextY + (_radius * (if (_stepY >= 0) then {1} else {-1}));
    if !([_playerX, _checkY] call _isBlocked) then
    {
        _playerY = _nextY;
    };
};

private _pickups = +(_state # DB_RUI_S_PICKUPS);
{
    private _pickup = _x;
    if (_pickup # DB_RUI_PK_ALIVE) then
    {
        private _dx = (_pickup # DB_RUI_PK_X) - _playerX;
        private _dy = (_pickup # DB_RUI_PK_Y) - _playerY;
        if (((_dx * _dx) + (_dy * _dy)) <= 0.40) then
        {
            switch (_pickup # DB_RUI_PK_TYPE) do
            {
                case "medkit":
                {
                    _player set [DB_RUI_P_HP, ((_player # DB_RUI_P_HP) + (_pickup # DB_RUI_PK_VALUE)) min 100];
                };
                default
                {
                    _player set [DB_RUI_P_AMMO, ((_player # DB_RUI_P_AMMO) + (_pickup # DB_RUI_PK_VALUE)) min 99];
                };
            };

            _pickup set [DB_RUI_PK_ALIVE, false];
            _pickups set [_forEachIndex, _pickup];
        };
    };
}
forEach _pickups;

_player set [DB_RUI_P_X, _playerX];
_player set [DB_RUI_P_Y, _playerY];
_player set [DB_RUI_P_DIR, _dir];

if ((_player # DB_RUI_P_HP) <= 0) then
{
    _state set [DB_RUI_S_OUTCOME, "lost"];
};

_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_PICKUPS, _pickups];
_state
