//if(!(alive player)) exitWith {};

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (gunner _unit != player) exitWith {};

_UAV = _unit getvariable ['proxy',objnull];

if (!(isnull _UAV) && (_UAV in (attachedobjects _unit))) then
{

	[_UAV, true] remoteExec ["engineOn"];
	player remoteControl driver _UAV;

	_UAV setAirplaneThrottle 1;

	sleep 0.1;

	(driver _uav) doMove [0, 0, 0];//assures that engines stays on (i personally use this every time)
	_UAV forceSpeed 1100;
	_UAV setAirplaneThrottle 1;

	private _timeEnd = time + 5;

	waituntil {time >= _timeEnd || !(alive _UAV)};
	playSound3D ["orlan\tripod\zapusk.ogg", _UAV, false, getPosASL _UAV, 5, 1, 250];
	_unit animatesource ['luch_anim',1,4.8];
	_unit animatesource ['reload_uav',1,true];
	
	waituntil {sleep 0.01;(_unit animationsourcephase 'luch_anim' > 0.95) || !(alive _unit) || !(alive _UAV)};
	
	detach _UAV;
	player remoteControl objNull;
	_UAV setVelocityModelSpace [0, 30, 0];

	_UAV setAirplaneThrottle 1;
	(driver _uav) doMove ((getPos _uav) vectorAdd [0, 500, 200]);//assures that engines stays on (i personally use this every time)
	_uav doMove ((getPos _uav) vectorAdd [0, 500, 200]);
	_UAV forceSpeed 1100;

	sleep 1;

	(driver _uav) doMove ((getPos _uav) vectorAdd [0, 500, 200]);//assures that engines stays on (i personally use this every time)
	_uav doMove ((getPos _uav) vectorAdd [0, 500, 200]);

	_wpfollow = (group (driver _uav)) addWaypoint [((getPos _uav) vectorAdd [0, 500, 200]), 0];
	_wpfollow setWaypointType "MOVE";
	_wpfollow setWaypointBehaviour "SAFE";
	_wpfollow setWaypointSpeed "FULL";

	player connectTerminalToUAV _uav;
	player remoteControl (driver getConnectedUAV player);

	sleep 0.2;

	player remoteControl objNull;
	
	_unit setvariable ['proxy',objnull,true];
};
