params [
    ["_missionId", "", [""]],
    ["_caller", objNull, [objNull]],
    ["_source", "manual", [""]]
];

if (!isServer) exitWith {};
if (!isNull _caller && {!isNil "remoteExecutedOwner"} && {owner _caller != remoteExecutedOwner}) exitWith {};

private _replyTarget = if (isNull _caller) then {0} else {owner _caller};

call DZ_fnc_initMissionSystem;

private _definition = [_missionId] call DZ_fnc_getMissionDefinition;

if ((count _definition) == 0) exitWith {
    ["Штаб", "Неизвестный тип миссии."] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

if (missionNamespace getVariable ["DZ_missionActive", false]) exitWith {
    ["Штаб", "Миссия уже активна."] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

private _manualEnabled = _definition getOrDefault ["manualEnabled", false];
private _randomEnabled = _definition getOrDefault ["randomEnabled", false];
private _implemented = _definition getOrDefault ["implemented", false];

if (_source == "manual" && { !_manualEnabled }) exitWith {
    ["Штаб", "Эта миссия недоступна для ручного запуска."] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

if (_source == "auto" && { !_randomEnabled }) exitWith { false };

if (!_implemented) exitWith {
    [
        "Штаб",
        "Эта миссия пока только зарезервирована в меню. Логика будет добавлена отдельным сценарием."
    ] remoteExecCall ["DZ_fnc_showHint", _replyTarget];
};

[_missionId, _source, _definition] call DZ_fnc_prepareMissionState;

private _title = _definition getOrDefault ["title", _missionId];
["hint", "Штаб", format ["Миссия активирована: %1", _title]] call DZ_fnc_missionUi;

private _startFunction = _definition getOrDefault ["startFunction", ""];
private _startCode = missionNamespace getVariable [_startFunction, {}];

if !(_startCode isEqualType {}) exitWith
{
    ["failure"] call DZ_fnc_endMission;
    false
};

private _started = call _startCode;

if !(_started isEqualTo true) then
{
    if (missionNamespace getVariable ["DZ_missionActive", false]) then
    {
        ["failure"] call DZ_fnc_endMission;
    };
};

_started
