params [
    ["_missionId", "", [""]],
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (!isNull _caller && {!isNil "remoteExecutedOwner"} && {owner _caller != remoteExecutedOwner}) exitWith {};

private _replyTarget = if (isNull _caller) then {0} else {owner _caller};

call DZ_fnc_initMissionSystem;

if (!(_missionId in ["interdiction", "assassination", "downed_pilot"])) exitWith {
    ["Штаб", "Неизвестный тип миссии."] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

if (missionNamespace getVariable ["DZ_missionActive", false]) exitWith {
    ["Штаб", "Миссия уже активна."] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

if (_missionId in ["assassination", "downed_pilot"]) exitWith {
    [
        "Штаб",
        "Эта миссия пока только зарезервирована в меню. Логика будет добавлена отдельным сценарием."
    ] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

missionNamespace setVariable ["DZ_missionActive", true, true];
missionNamespace setVariable ["DZ_missionCurrentId", _missionId, true];
missionNamespace setVariable ["DZ_missionStartTime", time, true];
missionNamespace setVariable ["DZ_missionUnits", []];
missionNamespace setVariable ["DZ_missionMarkers", []];
missionNamespace setVariable ["DZ_missionVehicles", []];
missionNamespace setVariable ["DZ_missionPfhHandles", []];

["hint", "Штаб", format ["Миссия активирована: %1", _missionId]] call DZ_fnc_missionUi;

switch (_missionId) do {
    case "interdiction": {
        call DZ_fnc_startInterdictionMission;
    };
    default {
        ["cancelled"] call DZ_fnc_endMission;
    };
};
