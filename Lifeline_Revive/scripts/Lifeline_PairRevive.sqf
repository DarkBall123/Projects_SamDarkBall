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
            _x setVariable ["Lifeline_RevivePartner", objNull, true];
            _x setVariable ["Lifeline_ReviveBusy", false, true];
        };
    } forEach _pair;

    _group setVariable ["Lifeline_RevivePair", [], true];
    _group setVariable ["Lifeline_ReviveBusy", false, true];

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

    _first setVariable ["Lifeline_RevivePartner", _second, true];
    _second setVariable ["Lifeline_RevivePartner", _first, true];
    _group setVariable ["Lifeline_RevivePair", _pair, true];

    diag_log format ["[Lifeline Revive] Pair selected for %1: %2 and %3", _group, name _first, name _second];

    _pair;
};

Lifeline_fnc_treatPartner = {
    params ["_group", "_healer", "_patient"];

    if (_group getVariable ["Lifeline_ReviveBusy", false]) exitWith {};

    _group setVariable ["Lifeline_ReviveBusy", true, true];
    _healer setVariable ["Lifeline_ReviveBusy", true, true];
    _patient setVariable ["Lifeline_ReviveBusy", true, true];

    ["Lifeline_moveToPartner", [_healer, _patient], _healer] call CBA_fnc_targetEvent;

    while {
        [_patient] call Lifeline_fnc_needsTreatment &&
        {[_healer] call Lifeline_fnc_canTreatPartner} &&
        {group _healer == _group} &&
        {group _patient == _group} &&
        {_healer distance2D _patient > 2.5}
    } do {
        ["Lifeline_moveToPartner", [_healer, _patient], _healer] call CBA_fnc_targetEvent;
        sleep 2;
    };

    private _canFinish = [_patient] call Lifeline_fnc_needsTreatment &&
        {[_healer] call Lifeline_fnc_canTreatPartner} &&
        {group _healer == _group} &&
        {group _patient == _group} &&
        {_healer distance2D _patient <= 3.5};

    if (_canFinish) then {
        ["Lifeline_holdPosition", [_patient], _patient] call CBA_fnc_targetEvent;
        ["Lifeline_startTreatment", [_healer, _patient], _healer] call CBA_fnc_targetEvent;

        sleep 8;

        _canFinish = [_patient] call Lifeline_fnc_needsTreatment &&
            {[_healer] call Lifeline_fnc_canTreatPartner} &&
            {group _healer == _group} &&
            {group _patient == _group} &&
            {_healer distance2D _patient <= 4.5};

        if (_canFinish) then {
            [_patient, _healer, true] call ace_medical_fnc_fullHeal;
        };
    };

    _group setVariable ["Lifeline_ReviveBusy", false, true];
    _healer setVariable ["Lifeline_ReviveBusy", false, true];
    _patient setVariable ["Lifeline_ReviveBusy", false, true];

    ["Lifeline_releaseUnit", [_healer], _healer] call CBA_fnc_targetEvent;
    ["Lifeline_releaseUnit", [_patient], _patient] call CBA_fnc_targetEvent;
};

waitUntil {time > 0};

while {true} do {
    {
        private _group = _x;
        private _existingPair = _group getVariable ["Lifeline_RevivePair", []];
        private _hasPlayer = (units _group findIf {isPlayer _x}) != -1;

        if (_hasPlayer || {_existingPair isNotEqualTo []}) then {
            private _pair = [_group] call Lifeline_fnc_getPair;

            if (count _pair == 2 && {!(_group getVariable ["Lifeline_ReviveBusy", false])}) then {
                _pair params ["_first", "_second"];

                if ([_first] call Lifeline_fnc_needsTreatment && {[_second] call Lifeline_fnc_canTreatPartner}) then {
                    [_group, _second, _first] spawn Lifeline_fnc_treatPartner;
                } else {
                    if ([_second] call Lifeline_fnc_needsTreatment && {[_first] call Lifeline_fnc_canTreatPartner}) then {
                        [_group, _first, _second] spawn Lifeline_fnc_treatPartner;
                    };
                };
            };
        };
    } forEach allGroups;

    sleep 1;
};
