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
    _state set [DB_RUI_S_PROJECTILES, []];
    _state
};

private _stats = _state # DB_RUI_S_STATS;
private _delta = _stats # DB_RUI_STATS_DELTA;
private _player = +(_state # DB_RUI_S_PLAYER);
private _playerX = _player # DB_RUI_P_X;
private _playerY = _player # DB_RUI_P_Y;
private _now = diag_tickTime;
private _nextProjectiles = [];

{
    private _projectile = +_x;
    private _lifeUntil = _projectile # DB_RUI_PR_LIFE_UNTIL;
    private _stateName = _projectile # DB_RUI_PR_STATE;
    _projectile set [DB_RUI_PR_ANIM, (_projectile # DB_RUI_PR_ANIM) + (_delta * 10)];

    if (_now < _lifeUntil) then
    {
        if (_stateName isEqualTo DB_RUI_PROJECTILE_BURST) then
        {
            _nextProjectiles pushBack _projectile;
        }
        else
        {
            private _step = (_projectile # DB_RUI_PR_SPEED) * _delta;
            private _nextX = (_projectile # DB_RUI_PR_X) + ((cos (_projectile # DB_RUI_PR_DIR)) * _step);
            private _nextY = (_projectile # DB_RUI_PR_Y) + ((sin (_projectile # DB_RUI_PR_DIR)) * _step);
            private _radius = DB_RUI_FIREBALL_RADIUS;
            private _blocked = false;

            {
                _x params ["_offsetX", "_offsetY"];
                if ([_state, _nextX + _offsetX, _nextY + _offsetY] call DB_fnc_rui_isBlocked) exitWith
                {
                    _blocked = true;
                };
            }
            forEach
            [
                [0, 0],
                [_radius, 0],
                [-_radius, 0],
                [0, _radius],
                [0, -_radius]
            ];

            if (_blocked) then
            {
                _projectile set [DB_RUI_PR_STATE, DB_RUI_PROJECTILE_BURST];
                _projectile set [DB_RUI_PR_SPEED, 0];
                _projectile set [DB_RUI_PR_LIFE_UNTIL, _now + DB_RUI_FIREBALL_BURST_TIME];
                _projectile set [DB_RUI_PR_ANIM, 0];
                _nextProjectiles pushBack _projectile;
            }
            else
            {
                private _hitDx = _nextX - _playerX;
                private _hitDy = _nextY - _playerY;
                private _hitDistanceSqr = (_hitDx * _hitDx) + (_hitDy * _hitDy);

                if (_hitDistanceSqr <= DB_RUI_FIREBALL_HIT_RADIUS_SQR) then
                {
                    _player set [DB_RUI_P_HP, (_player # DB_RUI_P_HP) - (_projectile # DB_RUI_PR_DAMAGE)];
                    _projectile set [DB_RUI_PR_X, _nextX];
                    _projectile set [DB_RUI_PR_Y, _nextY];
                    _projectile set [DB_RUI_PR_STATE, DB_RUI_PROJECTILE_BURST];
                    _projectile set [DB_RUI_PR_SPEED, 0];
                    _projectile set [DB_RUI_PR_LIFE_UNTIL, _now + DB_RUI_FIREBALL_BURST_TIME];
                    _projectile set [DB_RUI_PR_ANIM, 0];
                    _nextProjectiles pushBack _projectile;
                }
                else
                {
                    _projectile set [DB_RUI_PR_X, _nextX];
                    _projectile set [DB_RUI_PR_Y, _nextY];
                    _nextProjectiles pushBack _projectile;
                };
            };
        };
    };
}
forEach (_state # DB_RUI_S_PROJECTILES);

if ((_player # DB_RUI_P_HP) <= 0) then
{
    _state set [DB_RUI_S_OUTCOME, "lost"];
};

_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_PROJECTILES, _nextProjectiles];
_state
