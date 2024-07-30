[] spawn {
	private _dronesArray = ["mavik_3_OPF", "mavik_3_BLU", "mavik_3_IND", "mavik_3T_OPF", "mavik_3T_BLU", "mavik_3T_IND"];
	private _terminalsArray = ["B_UavTerminal", "O_UavTerminal", "I_UavTerminal"];

	while {true} do {
		private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

		private _assignedItems = assignedItems _player;

		if ({ _x in _assignedItems } count _terminalsArray > 0) then {
			private _drones = vehicles select { (typeOf _x) in _dronesArray };
			private _dronesNear = _player nearEntities [_dronesArray, 5000];

			{
				_player disableUAVConnectability [_x, true];
			} forEach (_drones - _dronesNear);

			{
				if (_x getVariable ["DB_mavic_isUAVsignalLost", false]) then { continue };

				_player enableUAVConnectability [_x, true];
			} forEach _dronesNear;
		};

		private _connectedUAVType = typeOf (getConnectedUAV _player);
		private _cameraOnType = typeOf cameraOn;

		if (_connectedUAVType in _dronesArray && cameraView == "GUNNER" && _cameraOnType in _dronesArray) then {

			if (Mavic_showInterface) then {
				("DB_Mavic_Layer" call BIS_fnc_rscLayer) cutRsc ["Mavic_Interface", "PLAIN"];

				private _ehId = addMissionEventHandler ["Draw3D", { call mavic_fnc_drawHud }];
			};

			(getConnectedUAV _player) setVariable ["DB_mavic_isUAVsignalLost", false];
			
			missionNamespace setVariable ["DB_mavic_prevHud", shownHUD];
			
			showHUD [true, false];

			waitUntil {
				_connectedUAVType = typeOf (getConnectedUAV _player);
				_cameraOnType = typeOf cameraOn;
				!(_connectedUAVType in _dronesArray) || cameraView != "GUNNER" || !(_cameraOnType in _dronesArray)
			};

			if !(isNil "_ehId") then
			{
				removeMissionEventHandler ["Draw3D", _ehId];
			};

			call mavic_fnc_onExit;
		};

		sleep 0.1;
	};
};

[] spawn {
	private _dronesArray = ["mavik_3_OPF", "mavik_3_BLU", "mavik_3_IND", "mavik_3T_OPF", "mavik_3T_BLU", "mavik_3T_IND"];
	private _signalDropTime = -1;

	while {true} do {
		private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
		private _uav = getConnectedUAV _player;
		private _connectedUAVType = typeOf _uav;

		if (_connectedUAVType in _dronesArray) then {
			private _uavSignal = [_player, _uav] call mavic_fnc_getSignal;

            if (_uavSignal < 0.05) then {
                if (_signalDropTime == -1) then {
                    _signalDropTime = time;
                } else {
					if !(isNil "DB_SIGNAL_PP_dynamic") then { DB_SIGNAL_PP_dynamic ppEffectEnable false; };

					DB_SIGNAL_PP_dynamic = ppEffectCreate ["DynamicBlur",500];
        			DB_SIGNAL_PP_dynamic ppEffectEnable true;
        			DB_SIGNAL_PP_dynamic ppEffectAdjust [0.8];
					DB_SIGNAL_PP_dynamic ppEffectCommit 0;

					private _currentTime = (time - _signalDropTime);

					switch (true) do {
						case ((_currentTime > 5) and (_currentTime <= 10)): {
							private _gradient = uiNamespace getVariable ["DB_gradient_control", controlNull];

							if (ctrlShown _gradient) exitWith {};

							_gradient ctrlShow true;
						};
						case (_currentTime > 15): {
							_uav engineOn false;
                        	_player connectTerminalToUAV objNull;
                        	_player disableUAVConnectability [_uav, true];
							_uav setVariable ["DB_mavic_isUAVsignalLost", true];
                        	_signalDropTime = -1;

							DB_SIGNAL_PP_dynamic ppEffectEnable false;
						};
						default { };
					};
                };
            } else {
                _signalDropTime = -1;
            };
		};

		sleep 0.1;
	};
};

[] spawn {
    private _dronesArray = ["mavik_3_OPF", "mavik_3_BLU", "mavik_3_IND", "mavik_3T_OPF", "mavik_3T_BLU", "mavik_3T_IND"];
    private _lastUAVStatus = [false, false, false];

    while {true} do {
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _uav = getConnectedUAV _player;
        private _connectedUAVType = typeOf _uav;

        if (_connectedUAVType in _dronesArray) then {
            private _isTouchingGround = isTouchingGround _uav;
            private _isEngineOn = isEngineOn _uav;
            private _altitude = (getPosATL _uav) select 2;
            private _isFallingFast = abs(speed _uav) >= 10;
            private _currentUAVStatus = [_isTouchingGround, _isEngineOn, _altitude > 10, _isFallingFast];

            if (_currentUAVStatus isEqualTo _lastUAVStatus) exitWith {};

            _lastUAVStatus = _currentUAVStatus;

            _uav allowDamage !((_isTouchingGround && _isEngineOn && !_isFallingFast) || (_altitude <= 10 && !_isFallingFast));
        };

        sleep 0.1;
    }; 
};
