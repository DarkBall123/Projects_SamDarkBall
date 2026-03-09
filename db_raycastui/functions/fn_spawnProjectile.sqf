#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]],
    ["_type", DB_RUI_PROJECTILE_FIREBALL, [""]],
    ["_x", 0, [0]],
    ["_y", 0, [0]],
    ["_dir", 0, [0]],
    ["_speed", DB_RUI_FIREBALL_SPEED, [0]],
    ["_damage", DB_RUI_FIREBALL_DAMAGE, [0]],
    ["_lifetime", DB_RUI_FIREBALL_LIFETIME, [0]],
    ["_owner", "enemy", [""]]
];

if (_state isEqualTo []) exitWith
{
    _state
};

private _projectiles = +(_state # DB_RUI_S_PROJECTILES);
_projectiles pushBack
[
    _type,
    _x,
    _y,
    _dir,
    _speed,
    _damage,
    diag_tickTime + _lifetime,
    DB_RUI_PROJECTILE_FLY,
    random 2,
    _owner
];

_state set [DB_RUI_S_PROJECTILES, _projectiles];
_state
