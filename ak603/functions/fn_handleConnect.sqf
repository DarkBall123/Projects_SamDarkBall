fn_AK603_isGunnerView = compileFinal "
    cameraView == 'GUNNER' && {typeOf cameraOn in ['ak603_O', 'ak603_B']}
";

[] spawn {
    private _dronesArray = ["ak603_O", "ak603_B"];

    while {true} do {
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _connectedUAVType = typeOf (getConnectedUAV _player);
        private _cameraOnType = typeOf cameraOn;

        if (_connectedUAVType in _dronesArray && (call fn_AK603_isGunnerView)) then {
            missionNamespace setVariable ["DB_AK603_prevHud", shownHUD];
            showHUD [true, false];

            private _layer = 'DB_AK603_Layer' call BIS_fnc_rscLayer;
            _layer cutRsc ['Ak607_Interface', 'PLAIN'];

            private _ehId = [AK603_fnc_drawHud, 0.1, []] call CBA_fnc_addPerFrameHandler;

            waitUntil {
                _connectedUAVType = typeOf (getConnectedUAV _player);
                _cameraOnType = typeOf cameraOn;
                !(_connectedUAVType in _dronesArray) || !(call fn_AK603_isGunnerView)
            };

            [_ehId] call CBA_fnc_removePerFrameHandler;
            call AK603_fnc_onExit;
        };

        sleep 0.1;
    };
};


