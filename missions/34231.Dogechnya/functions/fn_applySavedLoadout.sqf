params
[
    ["_unit", objNull],
    ["_loadout", []]
];

if (!hasInterface) exitWith { false };
if (isNull _unit || { !(_loadout isEqualType []) } || { _loadout isEqualTo [] }) exitWith { false };

[_unit, +_loadout] spawn
{
    params ["_target", "_savedLoadout"];

    waitUntil
    {
        sleep 0.2;
        !isNull _target && { local _target }
    };

    if (isNull _target || { !local _target }) exitWith {};

    _target setUnitLoadout _savedLoadout;
    [_target, _savedLoadout, true] call DZ_fnc_storeOriginalLoadout;
};

true
