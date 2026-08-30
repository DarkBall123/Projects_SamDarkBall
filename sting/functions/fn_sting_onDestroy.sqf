/*
	Sting: FPV drone detonation.
	Purpose: replaces the drone with a munition and triggers the explosion.
	Context: local where called (usually the operator client).
	Params: [_uav]
		_uav - FPV drone object.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

params ["_uav"];

if (isNull _uav) exitWith {};

private _droneTypes = GETMVAR(DB_sting_droneTypes, STING_DRONE_TYPES);
if !(typeOf _uav in _droneTypes) exitWith {};
if (_uav getVariable ["DB_sting_detonating", false]) exitWith {};
_uav setVariable ["DB_sting_detonating", true, true];

if (hasInterface) then {
	cutText ["", "PLAIN"];
};

private _killer = driver _uav;
private _instigator = (UAVControl _uav) # 0;
private _vehicleCfg = configFile >> "CfgVehicles" >> typeOf _uav;
private _missileType = getText (_vehicleCfg >> "DB_stingPayloadAmmo");

if (_missileType isEqualTo "") exitWith {};

if (!isNull _killer) then {
	if (local _killer) then {
		_killer setCaptive false;
	} else {
		[_killer, false] remoteExec ["setCaptive", 2];
	};
};

private _missile = createVehicle [_missileType, _uav modelToWorld [0, 0, 0]];
_missile setVectorDirAndUp [vectorDir _uav, vectorUp _uav];

[_missile, [_killer, _instigator]] remoteExec ["setShotParents", 2];
[_missile, true] remoteExec ["hideObjectGlobal", 2];

deleteVehicle _uav;

[
	{
		_this params ["_missile", "_shotParents"];
		(getShotParents _missile) isEqualTo _shotParents;
	},
	{
		_this params ["_missile"];
		triggerAmmo _missile;
	},
	[_missile, [_killer, _instigator]]
] call CBA_fnc_waitUntilAndExecute;
