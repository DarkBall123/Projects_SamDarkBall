#include "\db_raycastui\script_component.hpp"

params [
    ["_display", displayNull, [displayNull]],
    ["_isDown", false, [true]]
];

if (isNull _display) exitWith
{
    false
};

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
    false
};

private _input = +(_state # DB_RUI_S_INPUT);
_input set [DB_RUI_IN_FIRE, _isDown];
_state set [DB_RUI_S_INPUT, _input];
SET_UIVAR(DB_RUI_STATE_VAR, _state);

private _capture = _display displayCtrl DB_RUI_IDC_INPUT_CAPTURE;
if (!isNull _capture) then
{
    ctrlSetFocus _capture;
};

true
