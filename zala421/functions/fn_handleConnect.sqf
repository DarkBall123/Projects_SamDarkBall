fn_Zala421_isGunnerView = compileFinal "
    cameraView == 'GUNNER' && {typeOf cameraOn in ['zala421_uav_b', 'zala421_uav_o', 'zala421_uav_i']}
";

fn_Zala421_updateHUD = compileFinal "
    private _player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit', player];
    private _vehicleRole = (UAVControl (getConnectedUAV _player)) # 1;
	
    private _layerGunner = 'DB_zala421_Layer_Gunner' call BIS_fnc_rscLayer;
    private _layerDriver = 'DB_zala421_Layer_Driver' call BIS_fnc_rscLayer;

    private _currentRole = missionNamespace getVariable ['fn_zala421_currentRole', ''];
    private _needsHUDUpdate = (_vehicleRole != _currentRole);

    if (_needsHUDUpdate) then {
        missionNamespace setVariable ['fn_zala421_currentRole', _vehicleRole];

        if (_vehicleRole == 'GUNNER') then {
            _layerGunner cutRsc ['Zala421_Interface_Gunner', 'PLAIN'];
            _layerDriver cutText ['', 'PLAIN'];
        } else {
            if (_vehicleRole == 'DRIVER') then {
                _layerDriver cutRsc ['Zala421_Interface_Driver', 'PLAIN'];
                _layerGunner cutText ['', 'PLAIN'];
            };
        };
    };

    if (_vehicleRole == 'GUNNER') then {
        call zala421_fnc_drawHudGunner;
    } else {
        if (_vehicleRole == 'DRIVER') then {
            call zala421_fnc_drawHudDriver;
        };
    };
";

[] spawn {
    private _dronesArray = ["zala421_uav_b", "zala421_uav_o", "zala421_uav_i"];

    while {true} do {
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _connectedUAVType = typeOf (getConnectedUAV _player);
        private _cameraOnType = typeOf cameraOn;

        if (_connectedUAVType in _dronesArray && (call fn_Zala421_isGunnerView)) then {
            missionNamespace setVariable ["DB_zala421_prevHud", shownHUD];
            showHUD [true, false];

            private _ehId = addMissionEventHandler ["Draw3D", fn_Zala421_updateHUD];

            waitUntil {
                _connectedUAVType = typeOf (getConnectedUAV _player);
                _cameraOnType = typeOf cameraOn;
                !(_connectedUAVType in _dronesArray) || !(call fn_Zala421_isGunnerView)
            };

            removeMissionEventHandler ["Draw3D", _ehId];

            call zala421_fnc_onExit;
        };

        sleep 0.1;
    };
};


