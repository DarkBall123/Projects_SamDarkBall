params ["_uav","_path"];
if (isNull _uav) exitWith {};

[_uav, _path] remoteExecCall ["DB_vnd_fnc_fpv_receivePath", -clientOwner, _uav];
