[] spawn {
	private _dronesArray = ["orlan_F_OPF", "orlan_F_BLU", "orlan_F_IND"];

	while {true} do {
		private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
		private _connectedUAVType = typeOf (getConnectedUAV _player);
		private _cameraOnType = typeOf cameraOn;
		private _vehicleRole = (UAVControl (getConnectedUAV _player)) # 1;

		if (_connectedUAVType in _dronesArray && cameraView == "GUNNER" && _cameraOnType in _dronesArray) then {
			("DB_Orlan_Layer" call BIS_fnc_rscLayer) cutRsc ["Orlan_HUD", "PLAIN"];
			
			missionNamespace setVariable ["DB_orlan_prevHud", shownHUD];
			
			showHUD [true, false];

			private _ehId = addMissionEventHandler ["Draw3D", { call orlan_fnc_drawHud }];

			waitUntil {
				_connectedUAVType = typeOf (getConnectedUAV _player);
				_cameraOnType = typeOf cameraOn;
				!(_connectedUAVType in _dronesArray) || cameraView != "GUNNER" || !(_cameraOnType in _dronesArray)
			};

			removeMissionEventHandler ["Draw3D", _ehId];

			call orlan_fnc_onExit;
		};

		sleep 0.1;
	};
};