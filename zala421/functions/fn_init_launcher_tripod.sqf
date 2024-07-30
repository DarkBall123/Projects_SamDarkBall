if(!(alive player)) exitWith {};

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

_gunner = (getShotParents _projectile) # 1;

deleteVehicle _projectile;

// Locality fix - only spawn zala421 on client shooting this, or client controlling this gunner
private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

if(_gunner != _player) exitWith {};

[_unit, false] remoteExec ["enableSimulationGlobal", 2];

_unitType = typeOf _unit;

_basePos = AGLToASL (_unit modelToWorld (_unit selectionPosition "konec hlavne"));
_muzzlePos = AGLToASL (_unit modelToWorld (_unit selectionPosition "usti hlavne"));

private _uavType = "zala421_uav_b";

switch (true) do {
	case (_unitType find "_o" > -1): { _uavType = "zala421_uav_o" };
	case (_unitType find "_b" > -1): { _uavType = "zala421_uav_b" };
	case (_unitType find "_i" > -1): { _uavType = "zala421_uav_i" };
	default { };
};

_launchPos = _muzzlePos vectorAdd (_basePos vectorFromTo _muzzlePos);
_uav = _uavType createVehicle _launchPos;
createVehicleCrew _uav;
_uav setPosASL _launchPos;


_dir = _unit weaponDirection (currentWeapon _unit);
_dir_degrees = (_dir select 0) atan2 (_dir select 1);
_vertical_angle = (atan ((vectorDir _unit)#2)) max 0;
_uav setDir _dir_degrees;

_uav engineOn true;

[_uav, [40, 0, direction _uav]] call zala421_fnc_setAngleOfAttack;
_vel = velocity _uav;
_dir = direction _uav;
_speed = 60;
_uav setVelocity [
	(sin _dir * _speed), 
	(cos _dir * _speed), 
	(50 + _vertical_angle)
];
_uav setDamage 0;

_startTime = diag_tickTime;
[_uav, _gunner, _vertical_angle, _startTime, _unit] spawn {
	params ["_uav", "_gunner", "_vertical_angle", "_startTime", "_unit"];

	for "_i" from 1 to 5 do {
		[_uav, [25, 0, direction _uav]] call zala421_fnc_setAngleOfAttack;
		_vel = velocity _uav;
		_dir = direction _uav;
		_speed = 60;
		_uav setVelocity [
			(sin _dir * _speed), 
			(cos _dir * _speed), 
			(25 + _vertical_angle)
			];
		_uav setDamage 0;
		sleep 0.2;
	};
	_uav setDamage 0;
	
	[_unit, true] remoteExec ["enableSimulationGlobal", 2];
};