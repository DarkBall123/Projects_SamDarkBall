#include "\db_raycastui\script_component.hpp"

params [
    ["_sound", "", [""]],
    ["_volume", 1, [0]],
    ["_pitch", 1, [0]],
    ["_cooldownKey", "", [""]],
    ["_cooldown", 0, [0]]
];

if (_sound isEqualTo "") exitWith
{
    0
};

private _now = diag_tickTime;

if (_cooldownKey != "") then
{
    private _cooldowns = uiNamespace getVariable [DB_RUI_SOUND_COOLDOWNS_VAR, createHashMap];
    if (_now < (_cooldowns getOrDefault [_cooldownKey, 0])) exitWith
    {
        0
    };

    _cooldowns set [_cooldownKey, _now + _cooldown];
    uiNamespace setVariable [DB_RUI_SOUND_COOLDOWNS_VAR, _cooldowns];
};

playSoundUI [_sound, _volume, _pitch, true]
