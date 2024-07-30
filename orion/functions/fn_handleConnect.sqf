fn_orion_isGunnerView = compileFinal "
    cameraView == 'GUNNER' && {typeOf cameraOn in ['orion_F_OPF', 'orion_F_KORNET_OPF', 'orion_F_KAB50_OPF', 'orion_F_KAB20_OPF', 'orion_F_BLU', 'orion_F_KORNET_BLU', 'orion_F_KAB50_BLU', 'orion_F_KAB20_BLU', 'orion_F_IND', 'orion_F_KORNET_IND', 'orion_F_KAB50_IND', 'orion_F_KAB20_IND']}
";

fn_orion_updateHUD = compileFinal "
    private _player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit', player];
    private _vehicleRole = (UAVControl (getConnectedUAV _player)) # 1;
	
    private _layerGunner = 'DB_Orion_Layer_Gunner' call BIS_fnc_rscLayer;
    private _layerDriver = 'DB_Orion_Layer_Driver' call BIS_fnc_rscLayer;

    private _currentRole = missionNamespace getVariable ['fn_orion_currentRole', ''];
    private _needsHUDUpdate = (_vehicleRole != _currentRole);

    if (_needsHUDUpdate) then {
        missionNamespace setVariable ['fn_orion_currentRole', _vehicleRole];

        if (_vehicleRole == 'GUNNER') then {
            _layerGunner cutRsc ['orion_HUD_Gunner', 'PLAIN'];
            _layerDriver cutText ['', 'PLAIN'];
        } else {
            if (_vehicleRole == 'DRIVER') then {
                _layerDriver cutRsc ['orion_HUD_Driver', 'PLAIN'];
                _layerGunner cutText ['', 'PLAIN'];
            };
        };
    };

    if (_vehicleRole == 'GUNNER') then {
        call orion_fnc_drawHudGunner;
    } else {
        if (_vehicleRole == 'DRIVER') then {
            call orion_fnc_drawHudDriver;
        };
    };
";


[] spawn {
    private _dronesArray = ["orion_F_OPF", "orion_F_KORNET_OPF", "orion_F_KAB50_OPF", "orion_F_KAB20_OPF", "orion_F_BLU", "orion_F_KORNET_BLU", "orion_F_KAB50_BLU", "orion_F_KAB20_BLU", "orion_F_IND", "orion_F_KORNET_IND", "orion_F_KAB50_IND", "orion_F_KAB20_IND"];

    while {true} do {
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _connectedUAVType = typeOf (getConnectedUAV _player);
        private _cameraOnType = typeOf cameraOn;

        if (_connectedUAVType in _dronesArray && (call fn_orion_isGunnerView)) then {
            missionNamespace setVariable ["DB_orion_prevHud", shownHUD];
            showHUD [true, false];

            private _ehId = addMissionEventHandler ["Draw3D", {call fn_orion_updateHUD}];

            waitUntil {
                _connectedUAVType = typeOf (getConnectedUAV _player);
                _cameraOnType = typeOf cameraOn;
                !(_connectedUAVType in _dronesArray) || !(call fn_orion_isGunnerView)
            };

            removeMissionEventHandler ["Draw3D", _ehId];
            call orion_fnc_onExit;
        };

        sleep 0.1;
    };
};
