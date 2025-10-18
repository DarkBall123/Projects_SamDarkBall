addMissionEventHandler ["EachFrame", {
        private _operator = call DB_fnc_fpv_getOperator;
        private _uav = [_operator] call DB_fnc_fpv_getControlledUAV;

        if (isNull _uav) exitWith {
                removeMissionEventHandler ["EachFrame", _thisEventHandler];
        };

        private _batteryLevel = (fuel _uav) max 0;
        private _picture = [
                _batteryLevel,
                [
                        [0.75, "\\ArmaFPV\\pictures\\A100.paa"],
                        [0.5, "\\ArmaFPV\\pictures\\A75.paa"],
                        [0.25, "\\ArmaFPV\\pictures\\A50.paa"],
                        [0.01, "\\ArmaFPV\\pictures\\A25.paa"]
                ],
                "\\ArmaFPV\\pictures\\A0.paa"
        ] call DB_fnc_fpv_selectGaugeTexture;

        private _controlPicture = uiNamespace getVariable ["ArmaFPV_BatteryPicture", controlNull];
        private _controlText = uiNamespace getVariable ["ArmaFPV_BatteryText", controlNull];

        _controlPicture ctrlSetText _picture;
        _controlText ctrlSetText str (round (_batteryLevel * 100));

        if !(missionNamespace getVariable ["ArmaFPV_isControl", false]) exitWith {
                removeMissionEventHandler ["EachFrame", _thisEventHandler];
        };
}];
