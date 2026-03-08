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

private _player = +(_state # DB_RUI_S_PLAYER);
private _stats = _state # DB_RUI_S_STATS;
private _delta = _stats # DB_RUI_STATS_DELTA;
private _now = diag_tickTime;
private _grid = _state # DB_RUI_S_GRID;
private _width = _state # DB_RUI_S_WIDTH;
private _height = _state # DB_RUI_S_HEIGHT;
private _enemies = +(_state # DB_RUI_S_ENEMIES);

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

{
    if (_x # DB_RUI_E_ALIVE) then
    {
        private _enemyX = _x # DB_RUI_E_X;
        private _enemyY = _x # DB_RUI_E_Y;
        private _dx = (_player # DB_RUI_P_X) - _enemyX;
        private _dy = (_player # DB_RUI_P_Y) - _enemyY;
        private _distance = sqrt ((_dx * _dx) + (_dy * _dy));
        private _angleTo = ((_dy atan2 _dx) + 360) % 360;
        private _trace = [_state, _angleTo, _distance + 0.05, false] call DB_fnc_rui_castRay;
        private _hasLOS = ((_trace # 2) + 0.08) >= _distance;

        _x set [DB_RUI_E_DIR, _angleTo];
        _x set [DB_RUI_E_ANIM_FRAME, (_x # DB_RUI_E_ANIM_FRAME) + (_delta * 6)];

        if (_hasLOS && {_distance <= (_x # DB_RUI_E_ATTACK_RANGE)} && {_now >= (_x # DB_RUI_E_NEXT_ATTACK)}) then
        {
            _player set [DB_RUI_P_HP, (_player # DB_RUI_P_HP) - 12];
            _x set [DB_RUI_E_NEXT_ATTACK, _now + 0.9];
            _x set [DB_RUI_E_STATE, "attack"];
        }
        else
        {
            if (_hasLOS || {_distance <= (_x # DB_RUI_E_AGGRO_RANGE)}) then
            {
                private _speed = (_x # DB_RUI_E_SPEED) * _delta;
                private _moveX = (_dx / (_distance max 0.001)) * _speed;
                private _moveY = (_dy / (_distance max 0.001)) * _speed;
                private _radius = 0.16;

                private _tryX = _enemyX + _moveX;
                private _checkX = _tryX + (_radius * (if (_moveX >= 0) then {1} else {-1}));
                if !([_checkX, _enemyY] call _isBlocked) then
                {
                    _x set [DB_RUI_E_X, _tryX];
                };

                private _tryY = (_x # DB_RUI_E_Y) + _moveY;
                private _checkY = _tryY + (_radius * (if (_moveY >= 0) then {1} else {-1}));
                if !([(_x # DB_RUI_E_X), _checkY] call _isBlocked) then
                {
                    _x set [DB_RUI_E_Y, _tryY];
                };

                _x set [DB_RUI_E_STATE, "chase"];
            }
            else
            {
                _x set [DB_RUI_E_STATE, "idle"];
            };
        };

        if ((_x # DB_RUI_E_HP) <= 0) then
        {
            _x set [DB_RUI_E_ALIVE, false];
            _x set [DB_RUI_E_STATE, "dead"];
        };
    };
}
forEach _enemies;

if ((_player # DB_RUI_P_HP) <= 0) then
{
    _state set [DB_RUI_S_OUTCOME, "lost"];
};

if (((_enemies select {_x # DB_RUI_E_ALIVE}) isEqualTo []) && {(_state # DB_RUI_S_OUTCOME) isEqualTo ""}) then
{
    _state set [DB_RUI_S_OUTCOME, "won"];
};

_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_ENEMIES, _enemies];
_state
