#include "\db_raycastui\script_component.hpp"

params [
    ["_display", displayNull, [displayNull]]
];

disableSerialization;

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
    SET_UIVAR(DB_RUI_DISPLAY_VAR, displayNull);
    SET_UIVAR(DB_RUI_KEY_GATE_VAR, nil);
    SET_UIVAR(DB_RUI_FOCUS_TRACE_VAR, nil);
    SET_UIVAR(DB_RUI_SOUND_COOLDOWNS_VAR, nil);
    diag_log text "[DB_RUI] shutdownSession completed without active state";
    true
};

private _activeDisplay = _state # DB_RUI_S_DISPLAY;
if (isNull _display) then
{
    _display = _activeDisplay;
};

if (!isNull _display) then
{
    private _ehs = _state # DB_RUI_S_INPUT_EHS;
    private _inputCapture = _display displayCtrl DB_RUI_IDC_INPUT_CAPTURE;
    private _removeDisplayEh =
    {
        params ["_eventName", "_ehId"];
        if (_ehId >= 0) then
        {
            _display displayRemoveEventHandler [_eventName, _ehId];
        };
    };
    private _removeCtrlEh =
    {
        params ["_eventName", "_ehId"];
        if (!isNull _inputCapture && {_ehId >= 0}) then
        {
            _inputCapture ctrlRemoveEventHandler [_eventName, _ehId];
        };
    };

    if (count _ehs >= 9) then
    {
        ["KeyDown", _ehs # DB_RUI_EH_KEYDOWN] call _removeDisplayEh;
        ["KeyUp", _ehs # DB_RUI_EH_KEYUP] call _removeDisplayEh;
        ["MouseButtonDown", _ehs # DB_RUI_EH_MOUSEDOWN] call _removeDisplayEh;
        ["MouseButtonUp", _ehs # DB_RUI_EH_MOUSEUP] call _removeDisplayEh;
        ["MouseMoving", _ehs # DB_RUI_EH_MOUSEMOVING] call _removeDisplayEh;
        ["KeyDown", _ehs # DB_RUI_EH_CTRL_KEYDOWN] call _removeCtrlEh;
        ["KeyUp", _ehs # DB_RUI_EH_CTRL_KEYUP] call _removeCtrlEh;
        ["SetFocus", _ehs # DB_RUI_EH_CTRL_SETFOCUS] call _removeCtrlEh;
        ["KillFocus", _ehs # DB_RUI_EH_CTRL_KILLFOCUS] call _removeCtrlEh;
    };
};

private _frameEh = _state # DB_RUI_S_FRAME_EH;
if ((_frameEh isEqualType 0) && {_frameEh >= 0}) then
{
    removeMissionEventHandler ["EachFrame", _frameEh];
};

SET_UIVAR(DB_RUI_STATE_VAR, nil);
SET_UIVAR(DB_RUI_DISPLAY_VAR, displayNull);
SET_UIVAR(DB_RUI_KEY_GATE_VAR, nil);
SET_UIVAR(DB_RUI_FOCUS_TRACE_VAR, nil);
SET_UIVAR(DB_RUI_SOUND_COOLDOWNS_VAR, nil);

diag_log text "[DB_RUI] shutdownSession completed";

true
