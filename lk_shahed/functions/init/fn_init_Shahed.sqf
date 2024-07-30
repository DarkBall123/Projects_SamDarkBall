params ["_drone"];

if(is3DEN) exitWith {};
if(!(alive player)) exitWith {};
if(allDisplays isEqualTo [findDisplay 0]) exitWith {};

_drone flyInHeight 200;

if(!local _drone) exitWith {};

_drone lockDriver true;

[{
    _this params ["_drone"];

    _drone addEventHandler["Hit", {
    params ["_player", "_killer", "_instigator", "_useEffects"];

    if(isObjectHidden _player) exitWith {
        true;
    };

    _unitPosATL = getPosATL _player;
    _typeOfdrone = typeOf _player;

    _yaw = direction _player; 
    _pitch = atan ((vectorDir _player)#2);
    if(((_unitPosATL#2)) <= 5) then {

            _unitPosATL = [_unitPosATL#0, _unitPosATL#1, _unitPosATL#2 + 2];
            [_unitPosATL, "lk_shahed_dummy_bomb", [_pitch, 0, _yaw], [0, 0, -150]] call shahed_fnc_createammo;
        };

    [_player] spawn {
        params ["_player"];
        sleep 0.5;
        if(!isNull _player) then {
            { 
                if(!isNull _x) then {
                    _player deleteVehicleCrew _x;
                };
            } forEach crew _player;
            deleteVehicle _player;
        };
    };
}];
}, [_drone], 5] call CBA_fnc_waitAndExecute;

Shahed_InitParam = [_drone] spawn {
	params ["_drone"];
	private _distance = 750;
	while{alive _drone} do {
		
		private _typeOfdrone = typeOf _drone;
		private _droneControl = UAVControl _drone;
		private _playeract = (_droneControl select 0);
		private _wpns = wayPoints (group _drone);
		
			if((count _wpns) > 0) then {
				private _wpnType = waypointType [group _drone, (count _wpns) - 1];

				switch (_wpnType) do {
					case "DESTROY": {
						private _waypointPos = waypointPosition [group _drone, (count _wpns) - 1];
						private _nearestTarget = objNull;
						_Cel = "B_TargetSoldier" createVehicle _waypointPos;
						deleteWaypoint [group _drone, (count _wpns) - 1];
						private _movewp = (group _drone) addWaypoint [position _Cel, 0];
						_movewp setWaypointDescription "destroy";
						_movewp setWaypointCompletionRadius 1;
						_drone setVariable ["Shahed_target", _Cel, true];
						_drone setVariable ["Shahed_manual", false, true];
					};
					case "UNLOAD": {
						private _waypointPos = waypointPosition [group _drone, (count _wpns) - 1];
						private _nearestTarget = objNull;
						_Cel = "B_TargetSoldier" createVehicle _waypointPos;
						deleteWaypoint [group _drone, (count _wpns) - 1];
						private _movewp = (group _drone) addWaypoint [position _Cel, 0];
						_movewp setWaypointDescription "unload";
						_movewp setWaypointCompletionRadius 1;
						_drone setVariable ["Shahed_target", _Cel, true];
						_drone setVariable ["Shahed_manual", false, true];
					};
					default {
						private _wpnis = waypointDescription [group _drone, (count _wpns) - 1];
						if (_wpnis != "destroy" && _wpnis != "unload" && !(_drone getVariable ["Shahed_manual", false])) then {
							_drone setVariable ["Shahed_target", objNull, true];
						};
						[group _drone, (count _wpns) - 1] setWaypointCompletionRadius 1;
					};
				};
			};

		sleep 3;
	};
};


Shahed_TargetSearch = [_drone] spawn {
	params ["_drone"];
	while{alive _drone} do {
		private _uavKilled = false;
		private _unitType = typeOf _drone;
		private _unitPosATL = getPosATL _drone;
		
		private _Cel = _drone getVariable ["Shahed_target", objNull];
		while{!(isNull _Cel)} do {
			private _wpns = wayPoints (group _drone);

			private _wpnis = waypointDescription [group _drone, (count _wpns) - 1];
			if(_wpnis == "unload") then {

				[group _drone, (count _wpns) - 1] setWaypointPosition [position _Cel, 0];
			};

			if(_drone distance2D _Cel <= 300) then {					
				private _lstTimeForceApplied = 0;
				private _start = diag_tickTime;
				while{alive _drone && {!(isNull _Cel) && {alive _Cel}}} do {

					private _uavPos = getPosASL _drone;
					private _cellocat = getPosASL _Cel;

					private _unitType = typeOf _drone;
					private _unitPosATL = getPosATL _drone;
					private _targetPosATL = getPosATL _Cel;
					
					if(time - _lstTimeForceApplied >= 0.25) then {
						private _relDirHor = [_uavPos, _cellocat] call BIS_fnc_DirTo;

						private _distToTarget = _cellocat distance _uavPos;
						private _droneSpeed = vectorMagnitude (velocity _drone);
						private _TTcel = _distToTarget / _droneSpeed;

						_cellocat = _cellocat vectorAdd ((velocity _Cel) vectorMultiply _TTcel);

						private _relDirVer = asin (
							((_uavPos select 2) - ((_cellocat) select 2)) / (_cellocat vectorDistance _uavPos)
						);

						_relDirVer = (_relDirVer * -1);

						if(!finite _relDirVer) then {
							_relDirVer = -90;
						};

						[_drone, [_relDirVer, 0, _relDirHor]] call shahed_fnc_setAngleOfAttack;
						
						//Za D blyat
						private _vectorFromTo = (_uavPos vectorFromTo _cellocat);
						_vectorFromTo = _vectorFromTo vectorMultiply 200;
						_drone setVelocity _vectorFromTo;
						_lstTimeForceApplied = time;
					};

					if(_uavKilled) exitWith {
						_bomb = "lk_shahed_dummy_bomb" createVehicle (_drone modelToWorld [0, 0, -150]);					
					};

					sleep 0.01;
				};
			};

			if(_uavKilled) exitWith {
						_bomb = "lk_shahed_dummy" createVehicle (_drone modelToWorld [0,0,-0.5]);
						_bomb setDamage 1;	};

			sleep 1;
			_Cel = _drone getVariable ["Shahed_target", objNull]; // fetch target in case it was cleared
		};
	};
};