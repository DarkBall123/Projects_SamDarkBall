[] spawn {
    private _drones = missionNamespace getVariable ["DB_kvn_fpv_dronesArray", []];

    while {true} do {
        private _pl  = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _uav = getConnectedUAV _pl;

        if ( typeOf _uav in _drones && {cameraView == "GUNNER"} && {typeOf cameraOn in _drones} ) then {
            missionNamespace setVariable ["kvn_isControl", true];

            [_uav] call DB_kvn_fnc_fpv_createDialog;

            _uav setCaptive !(missionNamespace getVariable ["kvn_allowBotsShoot", true]);

            waitUntil {
                !(typeOf (getConnectedUAV _pl) in _drones) ||
                cameraView != "GUNNER" ||
                !(typeOf cameraOn in _drones)
            };

            if (isNull _uav || {!alive _uav}) then {
                [] call DB_kvn_fnc_fpv_showNoImage;
            };

            missionNamespace setVariable ["kvn_isControl", false];
            call DB_kvn_fnc_fpv_destroyUI;
        };

        sleep 0.1;
    };
};

[] spawn {
    waitUntil {!isNull findDisplay 46};
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        private _h = false;
        if (missionNamespace getVariable ["kvn_isControl", false]) then {
            if (inputAction "showMap" > 0) then {_h = true};
        };
        _h
    }];
};
