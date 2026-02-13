[] spawn {
    private _drones = missionNamespace getVariable ["DB_vnd_fpv_dronesArray", []];

    while {true} do {
        private _pl  = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _uav = getConnectedUAV _pl;

        if ( typeOf _uav in _drones && {cameraView == "GUNNER"} && {typeOf cameraOn in _drones} ) then {
            missionNamespace setVariable ["vnd_isControl", true];

            [_uav] call DB_vnd_fnc_fpv_createDialog;

            private _makeCaptive = !(missionNamespace getVariable ["vnd_allowBotsShoot", true]);
            if (local _uav) then {
                _uav setCaptive _makeCaptive;
            } else {
                [_uav, _makeCaptive] remoteExecCall ["setCaptive", _uav];
            };

            waitUntil {
                !(typeOf (getConnectedUAV _pl) in _drones) ||
                cameraView != "GUNNER" ||
                !(typeOf cameraOn in _drones)
            };

            missionNamespace setVariable ["vnd_isControl", false];
            call DB_vnd_fnc_fpv_destroyUI;

            if !(isNull _uav) then {
                if (local _uav) then {
                    _uav setCaptive false;
                } else {
                    [_uav, false] remoteExecCall ["setCaptive", _uav];
                };
            };
        };

        sleep 0.1;
    };
};

[] spawn {
    waitUntil {!isNull findDisplay 46};
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        private _h = false;
        if (missionNamespace getVariable ["vnd_isControl", false]) then {
            if (inputAction "showMap" > 0) then {_h = true};
        };
        _h
    }];
};
