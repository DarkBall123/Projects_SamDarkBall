/*
    db_charcreator: postInit.
    Purpose: on clients, attach a scroll-wheel "Create Character" action to the
             player and re-attach it whenever the player unit changes (respawn /
             remote-controlled unit swap), since addAction is bound to a unit.
    Context: client only (hasInterface).
    Params: none.
    Returns: nothing.
*/

#include "script_macros.hpp"

if (!hasInterface) exitWith {};

DB_cc_fnc_addAction = {
    params ["_unit"];
    if (isNull _unit) exitWith {};

    // Drop a stale action from a previous unit, if any.
    private _old = _unit getVariable ["DB_cc_actionId", -1];
    if (_old >= 0) then {
        _unit removeAction _old;
    };

    private _id = _unit addAction [
        "<t color='#7CC0FF'>Create Character</t>",
        { call DB_fnc_cc_open; },
        nil,
        1.5,
        true,
        true,
        "",
        "alive _target
            && {_target == _this}
            && {vehicle _target == _target}
            && {isNull (uiNamespace getVariable ['DB_cc_display', displayNull])}",
        4
    ];
    _unit setVariable ["DB_cc_actionId", _id];
};

// Wire it to the current player and to every future player unit.
[player] call DB_cc_fnc_addAction;
["unit", { (_this select 0) call DB_cc_fnc_addAction; }] call CBA_fnc_addPlayerEventHandler;
