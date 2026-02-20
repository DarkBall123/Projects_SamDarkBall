#include "\vnd_main\script_macros.hpp"

if (!hasInterface) exitWith {};

private _loopInterval = VND_CONNECT_LOOP_INTERVAL;
private _controlGracePeriod = 0.75;

private _tick = {
    params [["_args", []], ["_pfhId", -1]];
    _args params [["_controlGracePeriod", 0.75]];

    private _drones = GETMVAR(DB_vnd_fpv_dronesArray, []);
    private _pl = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
    if (isNull _pl) then {
        _pl = player;
    };

    private _uav = objNull;
    if (!isNull _pl) then {
        _uav = getConnectedUAV _pl;
    };

    private _uavType = typeOf _uav;
    private _cameraObj = cameraOn;
    private _cameraMode = cameraView;
    private _cameraMatches = !isNull _uav && { _cameraObj isEqualTo _uav };
    private _cameraDroneClass = !isNull _cameraObj && { typeOf _cameraObj in _drones };

    private _directControlActive = (_uavType in _drones)
        && { _cameraMode in ["GUNNER", "EXTERNAL"] }
        && { _cameraMatches || { _cameraDroneClass } };

    private _now = diag_tickTime;
    private _wasControl = GETMVAR(vnd_isControl, false);
    private _graceUntil = GETMVAR(vnd_controlGraceUntil, -1);

    if (_directControlActive) then {
        _graceUntil = _now + _controlGracePeriod;
        SETMVAR(vnd_controlGraceUntil, _graceUntil);
    };

    private _connectedControl = (_uavType in _drones) && { !isNull _uav };
    private _graceControlActive = _wasControl && { _connectedControl } && { _now <= _graceUntil };
    private _controlActive = _directControlActive || { _graceControlActive };
    private _uiActive = _controlActive
        && { _cameraMode == "GUNNER" }
        && { _cameraMatches || { _cameraDroneClass } };
    private _uiMissing = isNull GETUVAR(vnd_TL_TimeText, controlNull);

    private _lastUav = GETMVAR(vnd_lastControlUav, objNull);

    if (_controlActive) then {
        if (!_wasControl) then {
            SETMVAR(vnd_isControl, true);
        };

        if (!isNull _uav && { _uav isNotEqualTo _lastUav }) then {
            if (!isNull _lastUav) then {
                if (local _lastUav) then {
                    _lastUav setCaptive false;
                } else {
                    [_lastUav, false] remoteExecCall ["setCaptive", _lastUav];
                };
            };

            SETMVAR(vnd_lastControlUav, _uav);

            private _makeCaptive = !(GETMVAR(vnd_allowBotsShoot, true));
            if (local _uav) then {
                _uav setCaptive _makeCaptive;
            } else {
                [_uav, _makeCaptive] remoteExecCall ["setCaptive", _uav];
            };
        };

        if (_uiActive) then {
            if (_uiMissing) then {
                [_uav] call DB_vnd_fnc_fpv_createDialog;
            };
        } else {
            if (!_uiMissing) then {
                call DB_vnd_fnc_fpv_destroyUI;
            };
        };
    } else {
        if (_wasControl) then {
            SETMVAR(vnd_isControl, false);
            SETMVAR(vnd_controlGraceUntil, -1);
            call DB_vnd_fnc_fpv_destroyUI;
        };

        if (!isNull _lastUav) then {
            if (local _lastUav) then {
                _lastUav setCaptive false;
            } else {
                [_lastUav, false] remoteExecCall ["setCaptive", _lastUav];
            };
            SETMVAR(vnd_lastControlUav, objNull);
        };
    };
};

private _prevPfh = GETMVAR(vnd_connectPFH, -1);
if (_prevPfh >= 0) then {
    [_prevPfh] call CBA_fnc_removePerFrameHandler;
};

private _pfhId = -1;
_pfhId = [_tick, _loopInterval, [_controlGracePeriod]] call CBA_fnc_addPerFrameHandler;

if !(_pfhId isEqualType 0) exitWith {
    diag_log "[vnd_main] failed to register connect PFH";
};

SETMVAR(vnd_connectPFH, _pfhId);

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
