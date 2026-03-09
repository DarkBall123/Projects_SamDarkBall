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

private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;

if (_moveAxis != 0) then
{
    private _moveDistance = (_settings # DB_RUI_CFG_MOVE_SPEED) * _delta * _moveAxis;
    private _stepX = (cos _dir) * _moveDistance;
    private _stepY = (sin _dir) * _moveDistance;

    private _nextX = _playerX + _stepX;
    private _checkX = _nextX + (DB_RUI_PLAYER_RADIUS * (if (_stepX >= 0) then {1} else {-1}));
    if !([_state, _checkX, _playerY] call DB_fnc_rui_isBlocked) then
    {
        _playerX = _nextX;
    };

    private _nextY = _playerY + _stepY;
    private _checkY = _nextY + (DB_RUI_PLAYER_RADIUS * (if (_stepY >= 0) then {1} else {-1}));
    if !([_state, _playerX, _checkY] call DB_fnc_rui_isBlocked) then
    {
        _playerY = _nextY;
    };
};

private _pickups = +(_state # DB_RUI_S_PICKUPS);
private _aliveEnemies = count ((_state # DB_RUI_S_ENEMIES) select {_x # DB_RUI_E_ALIVE});
{
    private _pickup = _x;
    if (_pickup # DB_RUI_PK_ALIVE) then
    {
        private _dx = (_pickup # DB_RUI_PK_X) - _playerX;
        private _dy = (_pickup # DB_RUI_PK_Y) - _playerY;
        if (((_dx * _dx) + (_dy * _dy)) <= DB_RUI_PICKUP_RADIUS_SQR) then
        {
            switch (_pickup # DB_RUI_PK_TYPE) do
            {
                case "exit":
                {
                    if (_aliveEnemies == 0) then
                    {
                        _pickup set [DB_RUI_PK_ALIVE, false];
                        _pickups set [_forEachIndex, _pickup];
                        _state set [DB_RUI_S_OUTCOME, "won"];
                    };
                };
                case "medkit":
                {
                    _player set [DB_RUI_P_HP, ((_player # DB_RUI_P_HP) + (_pickup # DB_RUI_PK_VALUE)) min DB_RUI_PLAYER_MAX_HP];
                    _pickup set [DB_RUI_PK_ALIVE, false];
                    _pickups set [_forEachIndex, _pickup];
                };
                default
                {
                    _player set [DB_RUI_P_AMMO, ((_player # DB_RUI_P_AMMO) + (_pickup # DB_RUI_PK_VALUE)) min DB_RUI_PLAYER_MAX_RESERVE_AMMO];
                    _pickup set [DB_RUI_PK_ALIVE, false];
                    _pickups set [_forEachIndex, _pickup];
                };
            };
        };
    };
}
forEach _pickups;

private _floorGrid = _state # DB_RUI_S_FLOOR_GRID;
if !(_floorGrid isEqualTo []) then
{
    private _cellX = (floor _playerX) max 0 min ((_state # DB_RUI_S_WIDTH) - 1);
    private _cellY = (floor _playerY) max 0 min ((_state # DB_RUI_S_HEIGHT) - 1);
    private _floorType = ((_floorGrid # _cellY) # _cellX);
    if (_floorType isEqualTo DB_RUI_FLOOR_LAVA) then
    {
        _player set [DB_RUI_P_HP, (_player # DB_RUI_P_HP) - (DB_RUI_LAVA_DAMAGE_PER_SEC * _delta)];
    };

    if (_floorType isEqualTo DB_RUI_FLOOR_SLIME) then
    {
        _player set [DB_RUI_P_HP, (_player # DB_RUI_P_HP) - (DB_RUI_SLIME_DAMAGE_PER_SEC * _delta)];
    };
};

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
