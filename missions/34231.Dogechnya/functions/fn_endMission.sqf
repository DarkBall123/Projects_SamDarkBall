params [["_result", "cancelled", [""]]];

if (!isServer) exitWith { false };

private _pfhHandles = missionNamespace getVariable ["DZ_missionPfhHandles", []];
{
    [_x] call CBA_fnc_removePerFrameHandler;
} forEach _pfhHandles;

{
    if (!isNull _x) then
    {
        deleteVehicle _x;
    };
} forEach (missionNamespace getVariable ["DZ_missionUnits", []]);

{
    if (!isNull _x) then
    {
        deleteVehicle _x;
    };
} forEach (missionNamespace getVariable ["DZ_missionVehicles", []]);

{
    deleteMarker _x;
} forEach (missionNamespace getVariable ["DZ_missionMarkers", []]);

missionNamespace setVariable ["DZ_missionActive", false, true];
missionNamespace setVariable ["DZ_missionCurrentId", "", true];
missionNamespace setVariable ["DZ_missionStartTime", 0, true];
missionNamespace setVariable ["DZ_missionUnits", []];
missionNamespace setVariable ["DZ_missionMarkers", []];
missionNamespace setVariable ["DZ_missionVehicles", []];
missionNamespace setVariable ["DZ_missionPfhHandles", []];

private _message = switch (_result) do
{
    case "success": { "Миссия выполнена успешно. Хорошая работа." };
    case "failure": { "Миссия провалена." };
    default { "Миссия завершена досрочно." };
};

["hint", "Штаб", _message] call DZ_fnc_missionUi;

true
