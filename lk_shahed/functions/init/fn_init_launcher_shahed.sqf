params ["_puskovaya", "_shaheedType"];

_puskovaya = _puskovaya # 0;
_puskovaya setVariable ["DB_shaheedType", _shaheedType];

if(is3DEN) exitWith {};
if(!(alive player)) exitWith {};
if(allDisplays isEqualTo [findDisplay 0]) exitWith {};

_puskovaya addEventHandler["Fired", {
	params ["_player", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_shooter"];

	// Locality fix - only spawn Shahed on client shooting this, or client controlling this gunner
	if(!(player == _shooter || player == _shooter getVariable ["BIS_fnc_moduleRemoteControl_owner", objNull])) exitWith {};

	private _shaheedType = _player getVariable ["DB_shaheedType", "lk_geran2"];

	_unitType = typeOf _player;

	_basePos = AGLToASL (_player modelToWorld (_player selectionPosition "konec hlavne"));
	_muzzlePos = AGLToASL (_player modelToWorld (_player selectionPosition "usti hlavne"));

	_launchPos = _muzzlePos vectorAdd (_basePos vectorFromTo _muzzlePos);
	_drone = _shaheedType createVehicle _launchPos;
	_drone setPosASL _launchPos;
	createVehicleCrew _drone;
	(driver _drone) disableAI "ALL";

	_shooter connectTerminalToUAV _drone;

	_dir = _player weaponDirection (currentWeapon _player);
	_dir_degrees = (_dir select 0) atan2 (_dir select 1);
	_vertical_angle = (atan ((vectorDir _player)#2)) max 0;
	_drone setDir _dir_degrees;

	_drone engineOn true;
	_drone setVehicleAmmo 0;
	[_drone, [30, 0, direction _drone]] call shahed_fnc_setAngleOfAttack;
	_vel = velocity _drone;
	_dir = direction _drone;
	_velocity = 60;
	_drone setVelocity [
		(sin _dir * _velocity), 
		(cos _dir * _velocity), 
		(30 + _vertical_angle)
	];
	_drone setDamage 0;

	_time = diag_tickTime;
	[_drone, _shooter, _vertical_angle, _time] spawn {
		params ["_drone", "_shooter", "_vertical_angle", "_time"];

		for "_i" from 1 to 5 do {
			[_drone, [30, 0, direction _drone]] call shahed_fnc_setAngleOfAttack;
			_vel = velocity _drone;
			_dir = direction _drone;
			_velocity = 60;
			_drone setVelocity [
				(sin _dir * _velocity), 
				(cos _dir * _velocity), 
				(30 + _vertical_angle)
			];
			_drone setDamage 0;
			sleep 0.2;
		};
		_drone setDamage 0;

		(driver _drone) enableAI "ALL";
		
		_folwp = (group _drone) addWaypoint [position _shooter, 0];
		_folwp setWaypointType "FOLLOW";
	};
}];