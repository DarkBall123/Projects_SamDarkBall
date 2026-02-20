#include "\vnd_main\script_macros.hpp"

if (hasInterface) then {
    private _legacyEh = GETMVAR(vnd_fiberEH, -1);
    if (_legacyEh >= 0) then {
        removeMissionEventHandler ["Draw3D", _legacyEh];
        SETMVAR(vnd_fiberEH, -1);
    };

    if !(GETMVAR(vnd_fiberInitQueued, false)) then {
        SETMVAR(vnd_fiberInitQueued, true);

        [
            { time > 0 },
            {
                private _fiberPfh = GETMVAR(vnd_fiberPFH, -1);
                if (_fiberPfh >= 0) exitWith {};

                private _newPfh = -1;
                _newPfh = [
                    { call DB_vnd_fnc_fpv_fiberTick },
                    VND_FIBER_TICK_INTERVAL
                ] call CBA_fnc_addPerFrameHandler;

                if (_newPfh isEqualType 0 && { _newPfh >= 0 }) then {
                    SETMVAR(vnd_fiberPFH, _newPfh);
                } else {
                    diag_log "[vnd_main] failed to register fiber PFH";
                };
            },
            []
        ] call CBA_fnc_waitUntilAndExecute;
    };

    private _registerPutEh = {
        params ["_unit"];
        if (isNull _unit) exitWith {};

        private _oldId = _unit getVariable ["vnd_playerPutID", -1];
        if (_oldId >= 0) then {
            _unit removeEventHandler ["Put", _oldId];
        };

        if !(isPlayer _unit) exitWith {};

        private _newId = _unit addEventHandler ["Put", {
            _this call DB_vnd_fnc_fpv_createUavOnItemCheck;
        }];
        _unit setVariable ["vnd_playerPutID", _newId];
    };

    [player] call _registerPutEh;

    if !(GETMVAR(vnd_putEhPlayerEventAdded, false)) then {
        SETMVAR(vnd_putEhPlayerEventAdded, true);

        ["loadout", {
            params ["_unit"];
            if (isNull _unit) exitWith {};

            private _oldId = _unit getVariable ["vnd_playerPutID", -1];
            if (_oldId >= 0) then {
                _unit removeEventHandler ["Put", _oldId];
            };
            if !(isPlayer _unit) exitWith {};

            private _newId = _unit addEventHandler ["Put", {
                _this call DB_vnd_fnc_fpv_createUavOnItemCheck;
            }];
            _unit setVariable ["vnd_playerPutID", _newId];
        }] call CBA_fnc_addPlayerEventHandler;
    };

    if !(GETMVAR(vnd_connectInitQueued, false)) then {
        SETMVAR(vnd_connectInitQueued, true);

        [
            { time > 0 },
            {
                call DB_vnd_fnc_fpv_handleConnect;
            },
            []
        ] call CBA_fnc_waitUntilAndExecute;
    };
};
