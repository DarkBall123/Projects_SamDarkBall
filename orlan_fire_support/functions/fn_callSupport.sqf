private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
private _uav = getConnectedUAV _player;
private _laserTarget = laserTarget _uav;
private _timeDelay = missionNamespace getVariable ["DB_orlanFS_timeDelay", 0];
private _dronesArray = missionNamespace getVariable ["orlanFS_allAvaiblesDrones", []];

if !((typeOf _uav) in _dronesArray) exitWith {};
if (cameraView != "GUNNER" || !((typeOf cameraOn) in _dronesArray)) exitWith {};
if (isNull _laserTarget) exitWith { ["Error: Turn on the laser"] call BIS_fnc_error };
if (time < _timeDelay) exitWith { [side _player, "PAPA_BEAR"] sideChat format["Negative! Wait! %1 seconds left.", floor(_timeDelay - time)]; };

private _projectile = toLower (missionNamespace getVariable ["orlanFS_ammoFly", "orlanfs_ammo"]);
private _projectileList = missionNamespace getVariable ["orlanFS_allAvaibles", ["orlanfs_ammo"]];
private _speed = 180;

if (_projectile == "random") then {
    _projectile = selectRandom _projectileList;
};

if (toLower _projectile == "m_lancet_dummy") then {
    _speed = 47;
};

private _flyRandom = missionNamespace getVariable ["orlanFS_randomFlyValues", "Medium"];
private _randomPos = [];

switch (toLower _flyRandom) do {
    case ("long"): { _randomPos = [random [2000, 3500, 5000], random [2000, 3500, 5000], random [4000, 5500, 7000]] vectorMultiply 2 };
    case ("medium"): { _randomPos = [random [2000, 3500, 5000], random [2000, 3500, 5000], random [4000, 5500, 7000]] };
    case ("fast"): { _randomPos = [random [2000, 3500, 5000], random [2000, 3500, 5000], random [4000, 5500, 7000]] vectorMultiply 1/4 };
};

[
    (getPosASL _laserTarget) vectorAdd _randomPos, _projectile, _laserTarget, _speed, false, [0, 0, 0.25], 5.0, true
] spawn orlan_fs_fnc_guideProjectile;

private _rocket = objNull;

waitUntil { sleep 0.5; _rocket = missionNamespace getVariable ["DB_orlanFS_rocket", objNull]; !isNull _rocket};

private _distance = _rocket distance _laserTarget; 
private _speedKMH = speed _rocket; 
private _speedMS = _speedKMH * 0.27778; 

private _eta = floor (_distance / _speedMS); 

[side _player, "PAPA_BEAR"] sideChat format["Coordinates reciveved, ETA: %1 seconds, out!", _eta];

private _callTime = time + (missionNamespace getVariable ["orlanFS_delayTime", 180]);

missionNamespace setVariable ["DB_orlanFS_timeDelay", _callTime];

call orlan_fs_fnc_handleShell;