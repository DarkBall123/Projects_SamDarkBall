/*
	Sting: trigger airburst detonation.
	Purpose: detonates the actively controlled Sting drone via a user-configured CBA keybind.
	Context: interface client on key press.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

if (!hasInterface) exitWith {};
if !(GETMVAR(Sting_isControl, false)) exitWith {};

private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
if (isNull _player) exitWith {};

private _uav = getConnectedUAV _player;
if (isNull _uav) exitWith {};

private _droneTypes = GETMVAR(DB_sting_droneTypes, STING_DRONE_TYPES);
if !(typeOf _uav in _droneTypes) exitWith {};
if !(cameraOn isEqualTo _uav) exitWith {};
if (_uav getVariable ["DB_sting_detonating", false]) exitWith {};

if (local _uav) then {
	[_uav] call DB_fnc_sting_onDestroy;
} else {
	[_uav] remoteExecCall ["DB_fnc_sting_onDestroy", _uav];
};
