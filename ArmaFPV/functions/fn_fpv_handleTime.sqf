private _operator = call DB_fnc_fpv_getOperator;
private _uav = [_operator] call DB_fnc_fpv_getControlledUAV;

if (isNull _uav) exitWith {};

if (isNil { _uav getVariable ["DB_fpv_savedTime", nil] }) then {
    _uav setVariable ["DB_fpv_savedTime", 0];
};

private _savedTime = _uav getVariable ["DB_fpv_savedTime", 0];
private _startTime = time - _savedTime;

addMissionEventHandler ["EachFrame", {
        _thisArgs params ["_startTime", "_uav"];
        private _elapsed = time - _startTime;

        private _controlText = uiNamespace getVariable ["ArmaFPV_OnTimeText", controlNull];
        _controlText ctrlSetText ([_elapsed, "MM:SS"] call BIS_fnc_secondsToString);

        _uav setVariable ["DB_fpv_savedTime", _elapsed, true];

        if !(missionNamespace getVariable ["ArmaFPV_isControl", false]) exitWith {
                removeMissionEventHandler ["EachFrame", _thisEventHandler];
        };
}, [_startTime, _uav]];
