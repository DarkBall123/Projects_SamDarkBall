#include "\vnd_main\script_macros.hpp"

if (!hasInterface) exitWith {};

private _prevPfh = GETMVAR(vnd_connectPFH, -1);
if (_prevPfh >= 0) then {
    [_prevPfh] call CBA_fnc_removePerFrameHandler;
};

private _pfhId = [{
    private _pl = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
    if (isNull _pl) then {
        _pl = player;
    };

    private _drones = GETMVAR(DB_vnd_fpv_dronesArray, []);
    private _uav = objNull;
    if (!isNull _pl) then {
        _uav = getConnectedUAV _pl;
    };

    private _isControl = !isNull _uav
        && { typeOf _uav in _drones }
        && { cameraView == "GUNNER" }
        && { cameraOn isEqualTo _uav };

    private _wasControl = GETMVAR(vnd_isControl, false);
    private _lastUav = GETMVAR(vnd_lastControlUav, objNull);

    if (_isControl) then {
        if (!_wasControl || { _uav isNotEqualTo _lastUav }) then {
            if (!isNull _lastUav && { _lastUav isNotEqualTo _uav }) then {
                if (local _lastUav) then {
                    _lastUav setCaptive false;
                } else {
                    [_lastUav, false] remoteExecCall ["setCaptive", _lastUav];
                };
            };

            SETMVAR(vnd_isControl, true);
            SETMVAR(vnd_lastControlUav, _uav);
            [_uav] call DB_vnd_fnc_fpv_createDialog;

            private _makeCaptive = !(GETMVAR(vnd_allowBotsShoot, true));
            if (local _uav) then {
                _uav setCaptive _makeCaptive;
            } else {
                [_uav, _makeCaptive] remoteExecCall ["setCaptive", _uav];
            };
        };
    } else {
        if (_wasControl) then {
            SETMVAR(vnd_isControl, false);
            call DB_vnd_fnc_fpv_destroyUI;

            if !(isNull _lastUav) then {
                if (local _lastUav) then {
                    _lastUav setCaptive false;
                } else {
                    [_lastUav, false] remoteExecCall ["setCaptive", _lastUav];
                };
            };

            SETMVAR(vnd_lastControlUav, objNull);
        };
    };
}, VND_CONNECT_LOOP_INTERVAL] call CBA_fnc_addPerFrameHandler;

SETMVAR(vnd_connectPFH, _pfhId);

if (isNil "CBA_fnc_waitUntilAndExecute" || { isNil "cba_common_waitUntilAndExecArray" }) then {
    [] spawn {
        waitUntil { !isNull findDisplay 46 };
        if (GETMVAR(vnd_keyEHAdded, false)) exitWith {};
        SETMVAR(vnd_keyEHAdded, true);

        findDisplay 46 displayAddEventHandler ["KeyDown", {
            private _handled = false;

            if (GETMVAR(vnd_isControl, false)) then {
                if (inputAction "showMap" > 0) then {
                    _handled = true;
                };
            };

            _handled
        }];
    };
} else {
    [
        { !isNull findDisplay 46 },
        {
            if (GETMVAR(vnd_keyEHAdded, false)) exitWith {};
            SETMVAR(vnd_keyEHAdded, true);

            findDisplay 46 displayAddEventHandler ["KeyDown", {
                private _handled = false;

                if (GETMVAR(vnd_isControl, false)) then {
                    if (inputAction "showMap" > 0) then {
                        _handled = true;
                    };
                };

                _handled
            }];
        },
        []
    ] call CBA_fnc_waitUntilAndExecute;
};
