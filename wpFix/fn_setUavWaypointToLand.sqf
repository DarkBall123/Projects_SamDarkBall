params ["", "_id"];

private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
private _uav = getConnectedUAV _player;
private _wp = currentWaypoint (group _uav);

if (_id == 9) then {
	[group _uav, _wp] setWaypointDescription "LAND";
};

_uav setVariable ["DB_currentWpID", _id];