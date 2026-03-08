#include "\db_raycastui\script_component.hpp"

params [
    ["_display", displayNull, [displayNull]]
];

disableSerialization;

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
    SET_UIVAR(DB_RUI_DISPLAY_VAR, displayNull);
    onEachFrame {};
    showCursor true;
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
    if (count _ehs >= 4) then
    {
        private _keyDown = _ehs # DB_RUI_EH_KEYDOWN;
        private _keyUp = _ehs # DB_RUI_EH_KEYUP;
        private _mouseDown = _ehs # DB_RUI_EH_MOUSEDOWN;
        private _mouseUp = _ehs # DB_RUI_EH_MOUSEUP;

        if (_keyDown >= 0) then
        {
            _display displayRemoveEventHandler ["KeyDown", _keyDown];
        };

        if (_keyUp >= 0) then
        {
            _display displayRemoveEventHandler ["KeyUp", _keyUp];
        };

        if (_mouseDown >= 0) then
        {
            _display displayRemoveEventHandler ["MouseButtonDown", _mouseDown];
        };

        if (_mouseUp >= 0) then
        {
            _display displayRemoveEventHandler ["MouseButtonUp", _mouseUp];
        };
    };
};

onEachFrame {};
showCursor true;

SET_UIVAR(DB_RUI_STATE_VAR, nil);
SET_UIVAR(DB_RUI_DISPLAY_VAR, displayNull);

true
