#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

if (_state isEqualTo []) exitWith
{
    _state
};

private _input = +(_state # DB_RUI_S_INPUT);
private _outcome = _state # DB_RUI_S_OUTCOME;

if !(_outcome isEqualTo "") then
{
    if (_input # DB_RUI_IN_RESTART) then
    {
        _state = [_state] call DB_fnc_rui_resetRun;
        _input = _state # DB_RUI_S_INPUT;
        _input set [DB_RUI_IN_RESTART, false];
        _state set [DB_RUI_S_INPUT, _input];
    };

    _state
}
else
{
    if (_input # DB_RUI_IN_FIRE) then
    {
        _state = [_state] call DB_fnc_rui_fireWeapon;
    };

    _state
}
