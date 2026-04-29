params [
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _caller) exitWith {};
if (!isNil "remoteExecutedOwner" && {owner _caller != remoteExecutedOwner}) exitWith {};

private _replyTarget = owner _caller;

call DZ_fnc_initMissionSystem;

if !(missionNamespace getVariable ["DZ_missionActive", false]) exitWith {
    ["Штаб", "Нет активной миссии."] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

private _missionId = missionNamespace getVariable ["DZ_missionCurrentId", ""];
private _startTime = missionNamespace getVariable ["DZ_missionStartTime", time];

[
    "Штаб",
    format [
        "Активная миссия: %1\nПродолжительность: %2 мин",
        _missionId,
        floor ((time - _startTime) / 60)
    ]
] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
