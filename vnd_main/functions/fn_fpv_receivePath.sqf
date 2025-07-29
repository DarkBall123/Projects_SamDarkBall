params ["_uav","_path"];
if (isNull _uav) exitWith {};

_uav setVariable ["vnd_fiber_path", _path, false];
