Lifeline_fnc_needsTreatment = {
    params ["_unit"];

    alive _unit && {_unit call ace_medical_ai_fnc_isInjured}
};

Lifeline_fnc_canTreat = {
    params ["_unit"];

    alive _unit && {
        lifeState _unit != "INCAPACITATED" &&
        {!(_unit getVariable ["ACE_isUnconscious", false])}
    }
};

["Lifeline_processTreatment", {
    params ["_healer", "_patient"];

    if (!local _healer || {!alive _healer} || {isNull _patient} || {!alive _patient}) exitWith {};

    if (!isNull objectParent _healer) then {
        moveOut _healer;
    };

    private _currentTreatment = _healer getVariable ["ace_medical_ai_currentTreatment", []];
    private _currentTarget = _currentTreatment param [1, objNull];

    if (_healer distance2D _patient > 2.5) exitWith {
        if (_currentTarget == _patient) then {
            _healer setVariable ["ace_medical_ai_currentTreatment", nil];
        };

        doStop _healer;
        _healer forceSpeed -1;
        _healer doMove getPosATL _patient;
    };

    doStop _healer;
    _healer forceSpeed 0;
    _healer setDir (_healer getDir _patient);

    private _treatmentState = _currentTreatment param [2, ""];

    if (!isNull _currentTarget && {_currentTarget != _patient}) exitWith {};

    if ((_treatmentState select [0, 6]) == "#needs") exitWith {
        _healer setVariable ["Lifeline_ReviveBlockedTarget", _patient, true];
        _healer setVariable ["Lifeline_ReviveBlockedUntil", CBA_missionTime + 15, true];
        _healer setVariable ["ace_medical_ai_currentTreatment", nil];
    };

    private _requireItems = ace_medical_ai_requireItems;
    ace_medical_ai_requireItems = 1;
    [_healer, _patient] call ace_medical_ai_fnc_healingLogic;
    ace_medical_ai_requireItems = _requireItems;

    _currentTreatment = _healer getVariable ["ace_medical_ai_currentTreatment", []];
    _treatmentState = _currentTreatment param [2, ""];

    if ((_treatmentState select [0, 6]) == "#needs") then {
        _healer setVariable ["Lifeline_ReviveBlockedTarget", _patient, true];
        _healer setVariable ["Lifeline_ReviveBlockedUntil", CBA_missionTime + 15, true];
        _healer setVariable ["ace_medical_ai_currentTreatment", nil];
    };
}] call CBA_fnc_addEventHandler;

["Lifeline_holdPatient", {
    params ["_patient"];

    if (!local _patient || {!alive _patient} || {isPlayer _patient}) exitWith {};

    doStop _patient;
    _patient forceSpeed 0;
}] call CBA_fnc_addEventHandler;

["Lifeline_releaseUnit", {
    params ["_unit"];

    if (!local _unit || {!alive _unit} || {isPlayer _unit}) exitWith {};

    _unit switchMove "";
    _unit forceSpeed -1;
    _unit doFollow leader group _unit;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [] execVM "\Lifeline_Revive\scripts\Lifeline_PairRevive.sqf";
};
