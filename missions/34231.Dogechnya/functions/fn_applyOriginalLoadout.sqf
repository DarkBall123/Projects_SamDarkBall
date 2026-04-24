params [["_unit", objNull]];

if (!hasInterface) exitWith { false };
if (isNull _unit) exitWith { false };

private _originalLoadout = missionNamespace getVariable ["DZ_originalLoadout", []];
if !(_originalLoadout isEqualType []) exitWith { false };
if (_originalLoadout isEqualTo []) exitWith { false };

[_unit, +_originalLoadout] spawn
{
    params ["_target", "_loadout"];

    waitUntil
    {
        sleep 0.2;
        !isNull _target && { local _target } && { alive _target }
    };

    if (isNull _target || { !local _target }) exitWith {};

    _target setUnitLoadout _loadout;
};

true
