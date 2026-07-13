Lifeline_fnc_needsTreatment = {
    params ["_unit"];

    alive _unit && {
        lifeState _unit in ["INCAPACITATED", "INJURED"] ||
        {_unit getVariable ["ACE_isUnconscious", false]} ||
        {_unit call ace_medical_blood_fnc_isBleeding}
    }
};

Lifeline_fnc_canTreatPartner = {
    params ["_unit"];

    alive _unit && {
        lifeState _unit != "INCAPACITATED" &&
        {!(_unit getVariable ["ACE_isUnconscious", false])}
    }
};

["Lifeline_moveToPartner", {
    params ["_healer", "_patient"];

    if (!local _healer || {!alive _healer} || {isNull _patient}) exitWith {};

    if (!isNull objectParent _healer) then {
        moveOut _healer;
    };

    doStop _healer;
    _healer doMove getPosATL _patient;
}] call CBA_fnc_addEventHandler;

["Lifeline_holdPosition", {
    params ["_unit"];

    if (!local _unit || {!alive _unit}) exitWith {};

    doStop _unit;
}] call CBA_fnc_addEventHandler;

["Lifeline_startTreatment", {
    params ["_healer", "_patient"];

    if (!local _healer || {!alive _healer} || {isNull _patient}) exitWith {};

    doStop _healer;
    _healer setDir (_healer getDir _patient);
    _healer playMoveNow "AinvPknlMstpSnonWnonDnon_medic4";
}] call CBA_fnc_addEventHandler;

["Lifeline_releaseUnit", {
    params ["_unit"];

    if (!local _unit || {!alive _unit}) exitWith {};

    _unit switchMove "";
    _unit doFollow leader group _unit;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [] execVM "\Lifeline_Revive\scripts\Lifeline_PairRevive.sqf";
};
