[] spawn {
	while { True } do {
		private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
		private _uav = getConnectedUAV _player;
		private _wpOld = currentWaypoint (group _uav);
		private _wpIdOld = _uav getVariable ["DB_currentWpID", -1];

		if (isNull _uav) then { continue };

		if ((waypointDescription [group _uav, _wpOld]) == "LAND") then {
			waitUntil {
				sleep 0.1;
				private _wpIdNew = _uav getVariable ["DB_currentWpID", -2];
				(isTouchingGround _uav) ||
				!(alive _uav) ||
				_wpIdOld != _wpIdNew
			};

			[group _uav, currentWaypoint (group _uav)] setWaypointDescription "";

			if ((alive _uav) and (isTouchingGround _uav)) then {

				{ deleteVehicle _x } forEach crew _uav;

				createVehicleCrew _uav;

				_player connectTerminalToUAV _uav;
				_player switchCamera "Gunner";
			};
		};

		sleep 0.2;
	};
};