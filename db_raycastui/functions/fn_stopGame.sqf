#include "\db_raycastui\script_component.hpp"

params [
    ["_reason", "exit", [""]]
];

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
    false
};

_state set [DB_RUI_S_RUNNING, false];
_state set [DB_RUI_S_OUTCOME, _reason];
SET_UIVAR(DB_RUI_STATE_VAR, _state);

closeDialog 0;
true
