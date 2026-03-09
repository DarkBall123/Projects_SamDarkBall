#include "\db_raycastui\script_component.hpp"

params [
    ["_player", [], [[]]]
];

if (_player isEqualTo []) exitWith
{
    ["PISTOL", "0", "0", false]
};

private _weaponName = "PISTOL";
private _clipText = str (_player # DB_RUI_P_PISTOL_CLIP);

if ((_player # DB_RUI_P_WEAPON) == DB_RUI_WPN_SHOTGUN) then
{
    _weaponName = "SHOTGUN";
    _clipText = str (_player # DB_RUI_P_SHOTGUN_LOADED);
};

[
    _weaponName,
    _clipText,
    str (_player # DB_RUI_P_AMMO),
    ((_player # DB_RUI_P_RELOAD_STATE) != DB_RUI_RELOAD_NONE)
]
