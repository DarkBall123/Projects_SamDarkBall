/*
	Sting: drone initialization.
	Purpose: disables AI for the drone after creation.
	Context: server/client when the drone is created.
	Params: [_uav]
		_uav - drone object.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

params ["_uav"];

if (isNull _uav) exitWith {};
if (!isServer) exitWith {};

if (isNil "cba_common_waitUntilAndExecArray") exitWith {
	_uav disableAI "ALL";
	_uav setCaptive true;
};

[
	{
		params ["_uav"];
		!isNull _uav
	},
	{
		params ["_uav"];
		_uav disableAI "ALL";
		_uav setCaptive true;
	},
	[_uav]
] call CBA_fnc_waitUntilAndExecute;
