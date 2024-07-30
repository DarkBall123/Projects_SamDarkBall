params ["_player"];

private _uav = getConnectedUAV _player;
private _connectedUAVType = typeOf _uav;
private _cameraOnType = typeOf cameraOn;

if (!isNull (_uav) && cameraOn  == _uav && { (_uav getVariable ["grenadeObj", []]) isNotEqualTo [] }) then {
	[_player] call mavic_drop_fnc_dropGrenade;
};
