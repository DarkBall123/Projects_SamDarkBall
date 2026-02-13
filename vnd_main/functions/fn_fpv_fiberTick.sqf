#include "\vnd_main\script_macros.hpp"

if !(hasInterface) exitWith {};

private _pl = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
if (isNull _pl || { vehicle _pl != _pl }) exitWith {};

private _uav = getConnectedUAV _pl;
if (isNull _uav) exitWith {};

private _dArr = GETMVAR(DB_vnd_fpv_dronesArray, []);
if !(typeOf _uav in _dArr) exitWith {};

[_uav] call DB_vnd_fnc_fpv_updateFiberPath;
