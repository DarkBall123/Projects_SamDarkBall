params [["_laptop", objNull, [objNull]]];

if (isNull _laptop) exitWith { false };
if (!hasInterface) exitWith { true };
if (_laptop getVariable ["hq_actions_added", false]) exitWith { true };

_laptop setVariable ["hq_actions_added", true, false];

private _condition = "_this distance _target < 3";

_laptop addAction
[
    "Миссия: Перехват поставок",
    {
        params ["_target", "_caller"];

        ["interdiction", _caller] remoteExecCall ["DZ_fnc_startMission", 2];
    },
    nil,
    3,
    false,
    false,
    "",
    _condition
];

_laptop addAction
[
    "Миссия: Убийство цели",
    {
        params ["_target", "_caller"];

        ["assassination", _caller] remoteExecCall ["DZ_fnc_startMission", 2];
    },
    nil,
    2,
    false,
    false,
    "",
    _condition
];

_laptop addAction
[
    "Миссия: Сбитый пилот",
    {
        params ["_target", "_caller"];

        ["downed_pilot", _caller] remoteExecCall ["DZ_fnc_startMission", 2];
    },
    nil,
    1,
    false,
    false,
    "",
    _condition
];

_laptop addAction
[
    "Проверить статус миссии",
    {
        params ["_target", "_caller"];

        [_caller] remoteExecCall ["DZ_fnc_requestMissionStatus", 2];
    },
    nil,
    0,
    false,
    false,
    "",
    _condition
];

true
