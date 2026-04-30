params ["_uav"];

if (isNull _uav) exitWith {};

private _dronesArray = missionNamespace getVariable ["DB_kvn_fpv_dronesArray", []];
if !(typeOf _uav in _dronesArray) exitWith {};

private _instigator = (UAVControl _uav) # 0;
if (!isNull _instigator) then {
	if (hasInterface && {player isEqualTo _instigator}) then {
		[] call DB_kvn_fnc_fpv_showNoImage;
	} else {
		[] remoteExecCall ["DB_kvn_fnc_fpv_showNoImage", _instigator];
	};
};

private _path = _uav getVariable ["kvn_fiber_path", []];
if !(_path isEqualTo []) then {
    private _ttl = missionNamespace getVariable ["kvn_fiberTTL", 20];
	private _now = time;
	if (_ttl > 0) then {
		missionNamespace setVariable [
			"kvn_deadFibers",
			(missionNamespace getVariable ["kvn_deadFibers", []]) + [[_path, _now + _ttl, _now, +_path]],
			true
		];
	};
};

cutText ["", "PLAIN"];

private _killer     = driver _uav;
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
