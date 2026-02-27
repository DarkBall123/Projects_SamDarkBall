/*
	ArmaFPV: FPV drone detonation.
	Purpose: replaces the drone with a munition and triggers the explosion.
	Context: local where called (usually the operator client).
	Params: [_uav]
		_uav - FPV drone object.
	Returns: nothing.
*/

#include "\ArmaFPV\script_macros.hpp"

params ["_uav"];

if (isNull _uav) exitWith {};

private _droneTypes = GETMVAR(DB_fpv_droneTypes, FPV_DRONE_TYPES);
if !(typeOf _uav in _droneTypes) exitWith {};

if (hasInterface) then {
	private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
	if (isNull _player) then { _player = player; };
	private _connectedUav = if (!isNull _player) then { getConnectedUAV _player } else { objNull };
	private _lastUav = GETMVAR(DB_fpv_lastUav, objNull);
	private _isCurrentFpv = (_connectedUav isEqualTo _uav) || { cameraOn isEqualTo _uav } || { _lastUav isEqualTo _uav };

	if (_isCurrentFpv) then {
		SETMVAR(ArmaFPV_isControl, false);
		SETMVAR(DB_fpv_controlGraceUntil, -1);
		SETMVAR(DB_fpv_lastUav, objNull);
		SETMVAR(DB_timeInJammerZone, 0);
		SETMVAR(DB_fpv_ppfx_input, 1);
		private _ppfxContext = [];
		SETMVAR(DB_fpv_ppfx_context, _ppfxContext);
		SETMVAR(DB_fpv_ppfx_prevQ, 1);
		private _ppfxGlitch = [];
		SETMVAR(DB_fpv_ppfx_glitch, _ppfxGlitch);
		call DB_fnc_fpv_destroyUI;
	};
};

cutText ["", "PLAIN"];

private _killer = driver _uav;
private _instigator = (UAVControl _uav) # 0;
private _missileType = "";
private _uavType = toLower (typeOf _uav);

if (_uavType find "at" > -1) then {
	_missileType = "FPV_RPG42_AT";
};

if (_uavType find "ap" > -1) then {
	_missileType = "R_TBG32V_F";
};

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
