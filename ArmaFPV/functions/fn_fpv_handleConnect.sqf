[] spawn {
        private _droneClasses = call DB_fnc_fpv_getDroneClasses;
        private _terminalClasses = call DB_fnc_fpv_getTerminals;

        while { true } do {
                private _operator = call DB_fnc_fpv_getOperator;

                if (!isNull _operator) then {
                        private _assignedItems = assignedItems _operator;

                        if (_assignedItems findIf { _x in _terminalClasses } != -1) then {
                                private _controlledDrones = vehicles select { (typeOf _x) in _droneClasses };
                                private _nearbyDrones = _operator nearEntities [_droneClasses, 4000];

                                {
                                        _operator disableUAVConnectability [_x, true];
                                } forEach (_controlledDrones - _nearbyDrones);

                                {
                                        if (!(_x getVariable ["DB_fpv_isUAVsignalLost", false])) then {
                                                _operator enableUAVConnectability [_x, true];
                                        };
                                } forEach _nearbyDrones;
                        };

                        private _connectedUAV = [_operator] call DB_fnc_fpv_getControlledUAV;

                        if (!isNull _connectedUAV
                                && { cameraView == "GUNNER" }
                                && { (typeOf cameraOn) in _droneClasses }
                                && { (typeOf _connectedUAV) in _droneClasses }) then {

                                missionNamespace setVariable ["ArmaFPV_isControl", true];
                                _connectedUAV setVariable ["DB_fpv_isUAVsignalLost", false];

                                call DB_fnc_fpv_createDialog;

                                waitUntil {
                                        sleep 0.05;
                                        private _currentUAV = [_operator] call DB_fnc_fpv_getControlledUAV;
                                        isNull _currentUAV
                                                || { cameraView != "GUNNER" }
                                                || { !((typeOf cameraOn) in _droneClasses) }
                                                || { !((typeOf _currentUAV) in _droneClasses) }
                                };

                                missionNamespace setVariable ["ArmaFPV_isControl", false];
                                call DB_fnc_fpv_destroyUI;
                        };
                };

                sleep 0.1;
        };
};

[] spawn {
        waitUntil { !isNull findDisplay 46 };

        findDisplay 46 displayAddEventHandler ["KeyDown", {
                private _handled = false;

                if (missionNamespace getVariable ["ArmaFPV_isControl", false]) then {
                        if (inputAction "showMap" > 0) then {
                                _handled = true;
                        };
                };

                _handled;
        }];
};

[] spawn {
        private _droneClasses = call DB_fnc_fpv_getDroneClasses;
        private _signalDropStart = -1;

        while { true } do {
                private _operator = call DB_fnc_fpv_getOperator;
                private _uav = [_operator] call DB_fnc_fpv_getControlledUAV;

                if (!isNull _uav && { (typeOf _uav) in _droneClasses }) then {
                        private _signal = [_operator, _uav] call DB_fnc_fpv_getSignal;

                        if (_signal < 0.05) then {
                                if (_signalDropStart < 0) then {
                                        _signalDropStart = time;
                                } else {
                                        if ((time - _signalDropStart) >= 5) then {
                                                [_operator, _uav] call DB_fnc_fpv_onSignalLost;
                                                _signalDropStart = -1;
                                        };
                                };
                        } else {
                                _signalDropStart = -1;
                        };
                } else {
                        _signalDropStart = -1;
                };

                sleep 0.1;
        };
};
