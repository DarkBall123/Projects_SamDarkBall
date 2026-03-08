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
private _now = diag_tickTime;
private _ammo = _player # DB_RUI_P_AMMO;

if (_ammo <= 0) exitWith
{
    _state
};

if (_now < (_player # DB_RUI_P_NEXT_FIRE)) exitWith
{
    _state
};

_player set [DB_RUI_P_AMMO, _ammo - 1];
_player set [DB_RUI_P_NEXT_FIRE, _now + 0.24];
_player set [DB_RUI_P_FLASH_UNTIL, _now + 0.08];

private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _playerDir = _player # DB_RUI_P_DIR;
private _enemies = +(_state # DB_RUI_S_ENEMIES);
private _bestIndex = -1;
private _bestMetric = 999;

{
    if (_x # DB_RUI_E_ALIVE) then
    {
        private _dx = (_x # DB_RUI_E_X) - _playerX;
        private _dy = (_x # DB_RUI_E_Y) - _playerY;
        private _distance = sqrt ((_dx * _dx) + (_dy * _dy));
        private _angleTo = ((_dy atan2 _dx) + 360) % 360;
        private _relative = (((_angleTo - _playerDir) + 540) % 360) - 180;

        if ((abs _relative) <= 6.0) then
        {
            private _trace = [_state, _angleTo, _distance + 0.05, false] call DB_fnc_rui_castRay;
            private _hasLOS = ((_trace # 2) + 0.08) >= _distance;
            if (_hasLOS) then
            {
                private _metric = (abs _relative) + (_distance * 0.05);
                if (_metric < _bestMetric) then
                {
                    _bestMetric = _metric;
                    _bestIndex = _forEachIndex;
                };
            };
        };
    };
}
forEach _enemies;

if (_bestIndex >= 0) then
{
    private _target = +(_enemies # _bestIndex);
    _target set [DB_RUI_E_HP, (_target # DB_RUI_E_HP) - 30];
    if ((_target # DB_RUI_E_HP) <= 0) then
    {
        _target set [DB_RUI_E_ALIVE, false];
        _target set [DB_RUI_E_STATE, "dead"];
    }
    else
    {
        _target set [DB_RUI_E_STATE, "hurt"];
    };

    _enemies set [_bestIndex, _target];
};

_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_ENEMIES, _enemies];
_state
