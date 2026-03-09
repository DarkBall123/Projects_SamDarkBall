#include "\db_raycastui\script_component.hpp"

disableSerialization;

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
};

if !(_state # DB_RUI_S_RUNNING) exitWith
{
};

private _display = _state # DB_RUI_S_DISPLAY;
if (isNull _display) then
{
    _display = findDisplay DB_RUI_IDD;
    if (!isNull _display) then
    {
        _state set [DB_RUI_S_DISPLAY, _display];
    };
};

if (isNull _display) exitWith
{
    [] call DB_fnc_rui_stopGame;
};

private _inputCapture = _display displayCtrl DB_RUI_IDC_INPUT_CAPTURE;
private _focusedIDC = -1;
private _focusedCtrl = focusedCtrl _display;
if (!isNull _focusedCtrl) then
{
    _focusedIDC = ctrlIDC _focusedCtrl;
};

private _lastFocusedIDC = GET_UIVAR(DB_RUI_FOCUS_TRACE_VAR, -999);
if (_focusedIDC != _lastFocusedIDC) then
{
    diag_log text format ["[DB_RUI] focus changed to IDC %1", _focusedIDC];
    SET_UIVAR(DB_RUI_FOCUS_TRACE_VAR, _focusedIDC);
};

if (!isNull _inputCapture) then
{
    if (_focusedCtrl != _inputCapture) then
    {
        if (_focusedIDC != _lastFocusedIDC) then
        {
            diag_log text format ["[DB_RUI] tick restoring focus from IDC %1 to input capture", _focusedIDC];
        };

        ctrlSetFocus _inputCapture;
        _inputCapture ctrlSetTextSelection [0, 0];
    };
};

private _stats = +(_state # DB_RUI_S_STATS);
private _now = diag_tickTime;
private _delta = (_now - (_stats # DB_RUI_STATS_LAST_TICK)) max 0.001;
_delta = _delta min 0.033;
_stats set [DB_RUI_STATS_LAST_TICK, _now];
_stats set [DB_RUI_STATS_DELTA, _delta];
_state set [DB_RUI_S_STATS, _stats];

_state = [_state] call DB_fnc_rui_handleInput;
_state = [_state] call DB_fnc_rui_movePlayer;
_state = [_state] call DB_fnc_rui_updateAI;
_state = [_state] call DB_fnc_rui_updateProjectiles;
_state = [_state] call DB_fnc_rui_renderFloor;
_state = [_state] call DB_fnc_rui_renderWalls;
_state = [_state] call DB_fnc_rui_renderSprites;
_state = [_state] call DB_fnc_rui_renderWeapon;
_state = [_state] call DB_fnc_rui_renderHud;
_state = [_state] call DB_fnc_rui_debugOverlay;

_stats = _state # DB_RUI_S_STATS;
_stats set [DB_RUI_STATS_FRAME_MS, ((_stats # DB_RUI_STATS_FRAME_MS) * 0.70) + ((_delta * 1000) * 0.30)];
_stats set [DB_RUI_STATS_FPS, ((_stats # DB_RUI_STATS_FPS) * 0.70) + ((1 / _delta) * 0.30)];
_state set [DB_RUI_S_STATS, _stats];

SET_UIVAR(DB_RUI_STATE_VAR, _state);
