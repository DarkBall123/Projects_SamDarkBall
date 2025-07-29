params ["_uav"];

if (isNull _uav) exitWith {};

private _dronesArray = missionNamespace getVariable ["DB_vnd_fpv_dronesArray", []];
if !(typeOf _uav in _dronesArray) exitWith {};

private _path = _uav getVariable ["vnd_fiber_path", []];
if !(_path isEqualTo []) then {
    private _ttl = missionNamespace getVariable ["vnd_fiberTTL", 60];
	private _now = time;
	missionNamespace setVariable [
		"vnd_deadFibers",
		(missionNamespace getVariable ["vnd_deadFibers", []]) + [[_path, _now + _ttl, _now]],
		true
	];
};

cutText ["", "PLAIN"];

private _killer     = driver _uav;
private _instigator = (UAVControl _uav) # 0;
private _missileType = "";
private _uavType     = toLower typeOf _uav;

if (_uavType find "at" > -1) then {
	_missileType = "FPV_RPG42_AT";
} else {
	if (_uavType find "ap" > -1) then {
		_missileType = "R_TBG32V_F";
	};
};

if (local _killer) then {
	_killer setCaptive false;
} else {
	[_killer, false] remoteExec ["setCaptive", 2];
};

private _missile = createVehicle [_missileType, _uav modelToWorld [0,0,0]];

_missile setVectorDirAndUp [vectorDir _uav, vectorUp _uav];

[_missile, [_killer, _instigator]] remoteExec ["setShotParents", 2];
[_missile, true] remoteExec ["hideObjectGlobal", 2];

deleteVehicle _uav;

[
	{
		_this params ["_missile", "_shotParents"];
		(getShotParents _missile) isEqualTo _shotParents
	},
	{
		_this params ["_missile"];
		triggerAmmo _missile
	},
	[_missile, [_killer, _instigator]]
] call CBA_fnc_waitUntilAndExecute;
