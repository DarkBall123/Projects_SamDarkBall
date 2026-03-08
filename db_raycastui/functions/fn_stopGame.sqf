#include "\db_raycastui\script_component.hpp"

params [
    ["_reason", "exit", [""]]
];

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
    diag_log text format ["[DB_RUI] stopGame ignored: no state, reason=%1", _reason];
    false
};

_state set [DB_RUI_S_RUNNING, false];
_state set [DB_RUI_S_OUTCOME, _reason];
SET_UIVAR(DB_RUI_STATE_VAR, _state);

diag_log text format ["[DB_RUI] stopGame reason=%1", _reason];

closeDialog 0;
true
