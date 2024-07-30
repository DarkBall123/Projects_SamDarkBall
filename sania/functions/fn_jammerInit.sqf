params ["_jammer"];

if (is3DEN) exitWith {};
if !(isServer) exitWith {};

_jammer setMass 100;
_jammer setVariable ["DB_jammer_isActive", true, true];
_jammer addEventHandler ["Killed", {
    params ["_jammer"];

    _jammer removeEventHandler ["Killed", _thisEventHandler];
    _jammer setVariable ["DB_jammer_isActive", nil, true];

    deleteVehicle _jammer;
}];

// scan
private _function = {
    params ["_args", "_handle"];

    private _jammer = _args # 0;

    if (!alive _jammer) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
    if !(_jammer getVariable ["DB_jammer_isActive", false]) exitWith {};

    private _nearUavs = allUnitsUAV select {	
	    ((_x distance _jammer) < (missionNameSpace getVariable ["DB_Jammer_maxJamDistance", 600])) &&
	    { alive _x } &&
        { !(isObjectHidden _x) } &&
        { isEngineOn _x } &&
        { !(_x getVariable ["DB_jammer_isUavJamming", false]) }
    };
    
    if (_nearUavs isEqualTo []) exitWith {};
    
    {
        private _uav = _x;
        private _uavUnit = (UAVControl _uav) # 0;
        private _isCustomBehavior = _uav getVariable ["DB_jammer_customUavBehavior", false];

        _uav setVariable ["DB_jammer_isUavJamming", true, true];

        if (isPlayer _uavUnit) then {
            if (!_isCustomBehavior) then {
                [_uav, _uavUnit] remoteExecCall ["DB_fnc_jammerUavDisable", _uavUnit];
            };
        } else {
            (driver _uav) setDamage 1;
            (gunner _uav) setDamage 1;
            _uav setVariable ["DB_jammer_isUavJamming", nil, true];
        };

    } forEach _nearUavs;
};

[_function, 0.5, [_jammer]] call CBA_fnc_addPerFrameHandler;
