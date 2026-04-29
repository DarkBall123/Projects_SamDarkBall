if (!isServer) exitWith { false };

call DZ_fnc_initMissionSystem;

if !(missionNamespace getVariable ["DZ_missionActive", false]) then
{
    missionNamespace setVariable ["DZ_missionActive", true, true];
    missionNamespace setVariable ["DZ_missionCurrentId", "interdiction", true];
    missionNamespace setVariable ["DZ_missionStartTime", time, true];
    missionNamespace setVariable ["DZ_missionUnits", []];
    missionNamespace setVariable ["DZ_missionMarkers", []];
    missionNamespace setVariable ["DZ_missionVehicles", []];
    missionNamespace setVariable ["DZ_missionPfhHandles", []];
};

if (isNil "DZ_missionConvoyRoutes" || { DZ_missionConvoyRoutes isEqualTo [] }) exitWith
{
    ["failure"] call DZ_fnc_endMission;
    false
};

private _route = selectRandom DZ_missionConvoyRoutes;
private _startPos = _route # 0;
private _endPos = _route # 1;
private _convoyDir = _startPos getDir _endPos;
private _convoyVehicles = [];
private _vehicles = missionNamespace getVariable ["DZ_missionVehicles", []];
private _units = missionNamespace getVariable ["DZ_missionUnits", []];
private _markers = missionNamespace getVariable ["DZ_missionMarkers", []];

private _vehicleDefs =
[
    ["b_afougf_kraz255b1_fuel", 0],
    ["b_afougf_kraz255b1_fuel", 10],
    ["b_afougf_Ural_Zu23", 20]
];

{
    _x params ["_className", "_placement"];

    private _vehicle = createVehicle [_className, _startPos, [], _placement, "NONE"];
    _vehicle setDir _convoyDir;

    _vehicles pushBack _vehicle;
    _convoyVehicles pushBack _vehicle;
} forEach _vehicleDefs;

{
    createVehicleCrew _x;

    private _driver = driver _x;
    if (!isNull _driver) then
    {
        private _group = group _driver;
        _group addVehicle _x;

        {
            _x setSkill 0.5;
            _units pushBack _x;
        } forEach crew _x;

        private _waypoint = _group addWaypoint [_endPos, 0];
        _waypoint setWaypointType "MOVE";
        _waypoint setWaypointSpeed "NORMAL";
        _waypoint setWaypointBehaviour "SAFE";
    };
} forEach _convoyVehicles;

["create", "marker_convoy", _startPos, "mil_destroy", "Convoy"] call DZ_fnc_missionUi;
["create", "marker_convoy_dest", _endPos, "mil_flag", "Destination"] call DZ_fnc_missionUi;

_markers pushBack "marker_convoy";
_markers pushBack "marker_convoy_dest";

missionNamespace setVariable ["DZ_missionUnits", _units];
missionNamespace setVariable ["DZ_missionMarkers", _markers];
missionNamespace setVariable ["DZ_missionVehicles", _vehicles];

[
    "hint",
    "MISSION: SUPPLY INTERDICTION",
    "Вражеский конвой.\nУничтожьте все транспортные средства до пункта назначения.\nПроверьте карту для определения позиции конвоя."
] call DZ_fnc_missionUi;

private _markerHandle = [
    {
        params ["_args", "_handle"];
        _args params ["_convoyVehicles"];

        if !(missionNamespace getVariable ["DZ_missionActive", false]) exitWith
        {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        private _aliveVehicles = _convoyVehicles select { alive _x };
        if (_aliveVehicles isNotEqualTo []) then
        {
            "marker_convoy" setMarkerPos (getPos (_aliveVehicles # 0));
        };
    },
    10,
    [_convoyVehicles]
] call CBA_fnc_addPerFrameHandler;

private _stateHandle = [
    {
        params ["_args", "_handle"];
        _args params ["_convoyVehicles", "_endPos"];

        if !(missionNamespace getVariable ["DZ_missionActive", false]) exitWith
        {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        private _aliveVehicles = _convoyVehicles select { alive _x };

        if (_aliveVehicles isEqualTo []) exitWith
        {
            [_handle] call CBA_fnc_removePerFrameHandler;
            ["success"] call DZ_fnc_endMission;
            ["Конвой уничтожен. Миссия завершена.", east] remoteExecCall ["DZ_fnc_sideMessage", 0];
        };

        private _arrived = _aliveVehicles select { (_x distance2D _endPos) < 50 };
        if (_arrived isNotEqualTo []) exitWith
        {
            [_handle] call CBA_fnc_removePerFrameHandler;
            ["failure"] call DZ_fnc_endMission;
        };
    },
    5,
    [_convoyVehicles, _endPos]
] call CBA_fnc_addPerFrameHandler;

missionNamespace setVariable ["DZ_missionPfhHandles", [_markerHandle, _stateHandle]];

true
