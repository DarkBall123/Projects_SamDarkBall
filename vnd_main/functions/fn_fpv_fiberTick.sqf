
if !(hasInterface) exitWith {};

private _pl = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _pl) exitWith {};

private _uav  = getConnectedUAV _pl;
private _dArr = missionNamespace getVariable ["DB_vnd_fpv_dronesArray", []];

if (!isNull _uav && {typeOf _uav in _dArr} && {vehicle _pl == _pl}) then {
    [_pl, _uav] call DB_vnd_fnc_fpv_updateFiberPath;
};
