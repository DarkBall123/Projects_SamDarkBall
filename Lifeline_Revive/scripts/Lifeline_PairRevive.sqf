Lifeline_fnc_releaseTreatment = {
    params ["_healer"];

    private _patient = _healer getVariable ["Lifeline_RevivePatient", objNull];

    if (!isNull _patient && {_patient getVariable ["Lifeline_ReviveHealer", objNull] == _healer}) then {
        _patient setVariable ["Lifeline_ReviveHealer", objNull, true];
        ["Lifeline_releaseUnit", [_patient], _patient] call CBA_fnc_targetEvent;
    };

    _healer setVariable ["Lifeline_RevivePatient", objNull, true];
    ["Lifeline_releaseUnit", [_healer], _healer] call CBA_fnc_targetEvent;
};

Lifeline_fnc_restoreMedicClass = {
    params ["_unit"];

    private _originalMedicClass = _unit getVariable ["Lifeline_ReviveOriginalMedicClass", -1];

    if (_originalMedicClass == -1) then {
        _unit setVariable ["ace_medical_medicClass", nil, true];
    } else {
        _unit setVariable ["ace_medical_medicClass", _originalMedicClass, true];
    };

    _unit setVariable ["Lifeline_ReviveOriginalMedicClass", nil, true];
};

Lifeline_fnc_addSupplies = {
    params ["_unit"];

    private _supplies = [
        ["ACE_fieldDressing", 12],
        ["ACE_tourniquet", 2],
        ["ACE_splint", 2],
        ["ACE_morphine", 4],
        ["ACE_epinephrine", 4],
        ["ACE_salineIV_500", 2]
    ];

    {
        _x params ["_item", "_minimumCount"];

        private _missingItems = _minimumCount - ({_x == _item} count items _unit);

        if (_missingItems > 0) then {
            for "_index" from 1 to _missingItems do {
                if (_unit canAdd _item) then {
                    _unit addItem _item;
                };
            };
        };
    } forEach _supplies;
};

Lifeline_fnc_getPair = {
    params ["_group"];

    private _pair = _group getVariable ["Lifeline_RevivePair", []];
    private _validPair = count _pair == 2 && {
        (_pair findIf {
            isNull _x ||
            {!alive _x} ||
            {isPlayer _x} ||
            {group _x != _group}
        }) == -1;
    };

    if (_validPair) exitWith {_pair};

    {
        if (!isNull _x) then {
            [_x] call Lifeline_fnc_releaseTreatment;
            [_x] call Lifeline_fnc_restoreMedicClass;
            _x setVariable ["Lifeline_RevivePartner", objNull, true];
        };
    } forEach _pair;

    _group setVariable ["Lifeline_RevivePair", [], true];

    private _candidates = units _group select {
        !isPlayer _x &&
        {alive _x} &&
        {simulationEnabled _x} &&
        {_x isKindOf "CAManBase"}
    };

    if (count _candidates < 2) exitWith {[]};

    private _first = selectRandom _candidates;
    private _second = selectRandom (_candidates - [_first]);
    _pair = [_first, _second];

    {
        _x setVariable ["Lifeline_ReviveOriginalMedicClass", _x getVariable ["ace_medical_medicClass", -1], true];
        _x setVariable ["ace_medical_medicClass", 1, true];
        [_x] call Lifeline_fnc_addSupplies;
    } forEach _pair;

    _first setVariable ["Lifeline_RevivePartner", _second, true];
    _second setVariable ["Lifeline_RevivePartner", _first, true];
    _group setVariable ["Lifeline_RevivePair", _pair, true];

    diag_log format ["[Lifeline Revive] Pair selected for %1: %2 and %3", _group, name _first, name _second];

    _pair;
};

Lifeline_fnc_findPatient = {
    params ["_healer"];

    private _healerSide = side group _healer;
    private _blockedTarget = _healer getVariable ["Lifeline_ReviveBlockedTarget", objNull];
    private _blockedUntil = _healer getVariable ["Lifeline_ReviveBlockedUntil", 0];
    private _patients = allUnits select {
        _x != _healer &&
        {side group _x == _healerSide} &&
        {[_x] call Lifeline_fnc_needsTreatment} &&
        {
            private _assignedHealer = _x getVariable ["Lifeline_ReviveHealer", objNull];
            isNull _assignedHealer || {!alive _assignedHealer} || {_assignedHealer == _healer}
        } &&
        {_x != _blockedTarget || {CBA_missionTime >= _blockedUntil}}
    };

    private _urgentPatients = _patients select {
        lifeState _x == "INCAPACITATED" ||
        {_x getVariable ["ACE_isUnconscious", false]}
    };

    if (_urgentPatients isNotEqualTo []) then {
        _patients = _urgentPatients;
    };

    if (_patients isEqualTo []) exitWith {objNull};

    private _patient = _patients select 0;
    private _distance = _healer distance2D _patient;

    {
        private _currentDistance = _healer distance2D _x;

        if (_currentDistance < _distance) then {
            _patient = _x;
            _distance = _currentDistance;
        };
    } forEach _patients;

    _patient;
};

Lifeline_fnc_processHealer = {
    params ["_healer"];

    if (!([_healer] call Lifeline_fnc_canTreat)) exitWith {
        [_healer] call Lifeline_fnc_releaseTreatment;
    };

    private _patient = _healer getVariable ["Lifeline_RevivePatient", objNull];
    private _blockedTarget = _healer getVariable ["Lifeline_ReviveBlockedTarget", objNull];
    private _blockedUntil = _healer getVariable ["Lifeline_ReviveBlockedUntil", 0];
    private _patientInvalid = isNull _patient ||
        {!([_patient] call Lifeline_fnc_needsTreatment)} ||
        {side group _patient != side group _healer} ||
        {_patient getVariable ["Lifeline_ReviveHealer", objNull] != _healer} ||
        {_patient == _blockedTarget && {CBA_missionTime < _blockedUntil}};

    if (_patientInvalid) then {
        [_healer] call Lifeline_fnc_releaseTreatment;
        _patient = [_healer] call Lifeline_fnc_findPatient;

        if (!isNull _patient) then {
            _healer setVariable ["Lifeline_RevivePatient", _patient, true];
            _patient setVariable ["Lifeline_ReviveHealer", _healer, true];
        };
    };

    if (isNull _patient) exitWith {};

    ["Lifeline_holdPatient", [_patient], _patient] call CBA_fnc_targetEvent;
    ["Lifeline_processTreatment", [_healer, _patient], _healer] call CBA_fnc_targetEvent;
};

waitUntil {time > 0};

while {true} do {
    {
        private _group = _x;
        private _pair = [_group] call Lifeline_fnc_getPair;

        {
            [_x] call Lifeline_fnc_processHealer;
        } forEach _pair;
    } forEach allGroups;

    sleep 1;
};
