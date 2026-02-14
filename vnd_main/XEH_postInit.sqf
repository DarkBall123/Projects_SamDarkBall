#include "\vnd_main\script_macros.hpp"

if (hasInterface) then {
    private _canUseCbaPfh = !(
        isNil "CBA_fnc_addPerFrameHandler"
        || { isNil "CBA_fnc_removePerFrameHandler" }
        || { isNil "cba_common_perFrameHandlerArray" }
        || { isNil "cba_common_PFHhandles" }
    );

    if (_canUseCbaPfh) then {
        private _legacyEh = GETMVAR(vnd_fiberEH, -1);
        if (_legacyEh >= 0) then {
            removeMissionEventHandler ["Draw3D", _legacyEh];
            SETMVAR(vnd_fiberEH, -1);
        };

        private _fiberPfh = GETMVAR(vnd_fiberPFH, -1);
        if (_fiberPfh < 0) then {
            _fiberPfh = [
                { [] call DB_vnd_fnc_fpv_fiberTick },
                VND_FIBER_TICK_INTERVAL
            ] call CBA_fnc_addPerFrameHandler;
            SETMVAR(vnd_fiberPFH, _fiberPfh);
        };
    } else {
        private _fiberPfh = GETMVAR(vnd_fiberPFH, -1);
        if (_fiberPfh >= 0 && { !(isNil "CBA_fnc_removePerFrameHandler") } && { !(isNil "cba_common_perFrameHandlerArray") }) then {
            [_fiberPfh] call CBA_fnc_removePerFrameHandler;
        };
        SETMVAR(vnd_fiberPFH, -1);

        private _legacyEh = GETMVAR(vnd_fiberEH, -1);
        if (_legacyEh < 0) then {
            _legacyEh = addMissionEventHandler ["Draw3D", { [] call DB_vnd_fnc_fpv_fiberTick }];
            SETMVAR(vnd_fiberEH, _legacyEh);
        };
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

        if !(isNil "CBA_fnc_addPlayerEventHandler") then {
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
    };
};
