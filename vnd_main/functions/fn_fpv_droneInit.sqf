#include "\vnd_main\script_macros.hpp"

params ["_uav"];
if (isNull _uav) exitWith {};

if (isNil "CBA_fnc_waitUntilAndExecute") exitWith {
    _uav disableAI "ALL";
    _uav setVariable ["DB_jammer_customUavBehavior", true, true];
};

[
    {
        params ["_uav"];
        !isNull _uav
    },
    {
        params ["_uav"];
        _uav disableAI "ALL";
        _uav setVariable ["DB_jammer_customUavBehavior", true, true];
    },
    [_uav]
] call CBA_fnc_waitUntilAndExecute;
