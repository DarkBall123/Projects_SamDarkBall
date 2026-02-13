#include "\vnd_main\script_macros.hpp"

params ["_uav","_path"];
if (isNull _uav) exitWith {};

[_uav, ["snapshot", _path]] remoteExecCall ["DB_vnd_fnc_fpv_receivePath", -clientOwner, _uav];
