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
if (_now < (_player # DB_RUI_P_NEXT_FIRE)) exitWith
{
    _state
};

private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _playerDir = _player # DB_RUI_P_DIR;
private _enemies = +(_state # DB_RUI_S_ENEMIES);

private _readTargetData =
{
    params ["_enemy"];

    if !(_enemy # DB_RUI_E_ALIVE) exitWith
    {
        []
    };

    private _dx = (_enemy # DB_RUI_E_X) - _playerX;
    private _dy = (_enemy # DB_RUI_E_Y) - _playerY;
    private _distance = sqrt ((_dx * _dx) + (_dy * _dy));
    private _angleTo = ((_dy atan2 _dx) + 360) % 360;
    private _relative = (((_angleTo - _playerDir) + 540) % 360) - 180;

    [_distance, _angleTo, abs _relative]
};

private _applyEnemyDamage =
{
    params ["_enemyIndex", "_damage"];

    if (_damage <= 0) exitWith
    {
    };

    private _target = +(_enemies # _enemyIndex);
    _target set [DB_RUI_E_HP, (_target # DB_RUI_E_HP) - _damage];

    if ((_target # DB_RUI_E_HP) <= 0) then
    {
        _target set [DB_RUI_E_ALIVE, false];
        _target set [DB_RUI_E_STATE, "dead"];
        [DB_RUI_SND_MONSTER_DIE, 1.0, 0.92 + (random 0.16), "monster_die", 0.08] call DB_fnc_rui_playSound;
    }
    else
    {
        _target set [DB_RUI_E_STATE, "hurt"];
        [DB_RUI_SND_MONSTER_HURT, 0.95, 0.96 + (random 0.12), "monster_hurt", 0.05] call DB_fnc_rui_playSound;
    };

    _enemies set [_enemyIndex, _target];
};

switch (_player # DB_RUI_P_WEAPON) do
{
    case DB_RUI_WPN_SHOTGUN:
    {
        if ((_player # DB_RUI_P_SHOTGUN_LOADED) > 0) then
        {
            _player set [DB_RUI_P_SHOTGUN_LOADED, 0];
            _player set [DB_RUI_P_NEXT_FIRE, _now + DB_RUI_SHOTGUN_FIRE_COOLDOWN];
            _player set [DB_RUI_P_FLASH_UNTIL, _now + DB_RUI_SHOTGUN_FLASH_TIME];
            [DB_RUI_SND_SHOTGUN, 1.25, 0.97 + (random 0.08)] call DB_fnc_rui_playSound;

            if ((_player # DB_RUI_P_AMMO) > 0) then
            {
                _player set [DB_RUI_P_RELOAD_STATE, DB_RUI_RELOAD_SHOTGUN];
                _player set [DB_RUI_P_RELOAD_UNTIL, _now + DB_RUI_SHOTGUN_RELOAD_TIME];
            };

            private _candidates = [];
            {
                private _targetData = [_x] call _readTargetData;
                if !(_targetData isEqualTo []) then
                {
                    _targetData params ["_distance", "_angleTo", "_spread"];

                    if ((_spread <= DB_RUI_SHOTGUN_AIM_LIMIT) && {[_state, _angleTo, _distance] call DB_fnc_rui_hasLineOfSight}) then
                    {
                        private _metric = _spread + (_distance * 0.18);
                        _candidates pushBack [_metric, _forEachIndex, _distance, _spread];
                    };
                };
            }
            forEach _enemies;

            _candidates sort true;

            {
                _x params ["_metric", "_enemyIndex", "_distance", "_spread"];

                private _damage = switch (_forEachIndex) do
                {
                    case 0:
                    {
                        (48 - (_distance * 4.0) - (_spread * 1.3)) max 28
                    };
                    case 1:
                    {
                        (22 - (_distance * 2.2) - (_spread * 0.8)) max 8
                    };
                    default
                    {
                        (12 - (_distance * 1.4) - (_spread * 0.6)) max 4
                    };
                };

                [_enemyIndex, _damage] call _applyEnemyDamage;
            }
            forEach (_candidates select [0, 3]);
        };
    };
    default
    {
        if ((_player # DB_RUI_P_PISTOL_CLIP) > 0) then
        {
            _player set [DB_RUI_P_PISTOL_CLIP, (_player # DB_RUI_P_PISTOL_CLIP) - 1];
            _player set [DB_RUI_P_NEXT_FIRE, _now + DB_RUI_PISTOL_FIRE_COOLDOWN];
            _player set [DB_RUI_P_FLASH_UNTIL, _now + DB_RUI_PISTOL_FLASH_TIME];
            [DB_RUI_SND_PISTOL, 1.05, 0.98 + (random 0.08)] call DB_fnc_rui_playSound;

            private _bestIndex = -1;
            private _bestMetric = 999;

            {
                private _targetData = [_x] call _readTargetData;
                if !(_targetData isEqualTo []) then
                {
                    _targetData params ["_distance", "_angleTo", "_spread"];

                    if ((_spread <= DB_RUI_PISTOL_AIM_LIMIT) && {[_state, _angleTo, _distance] call DB_fnc_rui_hasLineOfSight}) then
                    {
                        private _metric = _spread + (_distance * 0.05);
                        if (_metric < _bestMetric) then
                        {
                            _bestMetric = _metric;
                            _bestIndex = _forEachIndex;
                        };
                    };
                };
            }
            forEach _enemies;

            if (_bestIndex >= 0) then
            {
                [_bestIndex, DB_RUI_PISTOL_DAMAGE] call _applyEnemyDamage;
            };
        };
    };
};

_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_ENEMIES, _enemies];
_state
