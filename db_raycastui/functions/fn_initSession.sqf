#include "\db_raycastui\script_component.hpp"

params [
    ["_display", displayNull, [displayNull]],
    ["_mapId", "demo_01", [""]],
    ["_quality", "MEDIUM", [""]],
    ["_debug", false, [false]]
];

disableSerialization;

if (isNull _display) exitWith
{
    false
};

private _qualityName = toUpper _quality;
private _columnCount = switch (_qualityName) do
{
    case "LOW":
    {
        DB_RUI_QUALITY_LOW
    };
    case "HIGH":
    {
        DB_RUI_QUALITY_HIGH
    };
    default
    {
        _qualityName = "MEDIUM";
        DB_RUI_QUALITY_MEDIUM
    };
};

private _settings =
[
    _qualityName,
    _columnCount,
    (DB_RUI_W / _columnCount),
    65,
    (DB_RUI_H * 0.92),
    2.85,
    135,
    _debug,
    22,
    DB_RUI_MAX_SPRITES
];

private _worldGroup = _display displayCtrl DB_RUI_IDC_WORLD_GROUP;
private _spriteGroup = _display displayCtrl DB_RUI_IDC_SPRITE_GROUP;
private _weaponCtrl = _display displayCtrl DB_RUI_IDC_WEAPON;
private _inputCapture = _display displayCtrl DB_RUI_IDC_INPUT_CAPTURE;
private _hudCtrls =
[
    _display displayCtrl DB_RUI_IDC_HP,
    _display displayCtrl DB_RUI_IDC_AMMO,
    _display displayCtrl DB_RUI_IDC_MAP,
    _display displayCtrl DB_RUI_IDC_HELP,
    _display displayCtrl DB_RUI_IDC_OUTCOME,
    _display displayCtrl DB_RUI_IDC_CROSS_H,
    _display displayCtrl DB_RUI_IDC_CROSS_V,
    _display displayCtrl DB_RUI_IDC_DEBUG_BG,
    _display displayCtrl DB_RUI_IDC_DEBUG_TEXT,
    _display displayCtrl DB_RUI_IDC_CEILING,
    _display displayCtrl DB_RUI_IDC_FLOOR,
    _display displayCtrl DB_RUI_IDC_STATUS_BAR,
    _display displayCtrl DB_RUI_IDC_FACE,
    _display displayCtrl DB_RUI_IDC_ARMOR,
    _display displayCtrl DB_RUI_IDC_ARMS,
    _display displayCtrl DB_RUI_IDC_AMMO_TABLE
];

private _resetCtrl =
{
    params ["_ctrl"];
    _ctrl ctrlSetPosition [0, 0, 0, 0];
    _ctrl ctrlCommit 0;
};

private _wallCtrls = [];
for "_index" from 0 to (_columnCount - 1) do
{
    private _ctrl = _display ctrlCreate ["DB_RUI_RscPicture", -1, _worldGroup];
    _ctrl ctrlSetText DB_RUI_CLEAR_TEXTURE;
    _ctrl ctrlSetTextColor [1, 1, 1, 1];
    [_ctrl] call _resetCtrl;
    _wallCtrls pushBack _ctrl;
};

private _spritePool = [];
for "_slot" from 0 to (DB_RUI_MAX_SPRITES - 1) do
{
    private _main = _display ctrlCreate ["DB_RUI_RscPicture", -1, _spriteGroup];
    private _second = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _third = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _fourth = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _fifth = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];

    {
        [_x] call _resetCtrl;
        _x ctrlShow false;
    }
    forEach [_main, _second, _third, _fourth, _fifth];

    _spritePool pushBack [_main, _second, _third, _fourth, _fifth];
};

private _buildWallSet =
{
    params ["_folder"];

    private _paths = [];
    private _basePath = format ["\db_raycastui\data\walls\%1\%1.paa", _folder];
    _paths resize DB_RUI_SLICE_COUNT;
    _paths = _paths apply {_basePath};

    _paths
};

private _wallCache =
[
    [],
    ["brick"] call _buildWallSet,
    ["tech"] call _buildWallSet,
    ["stone"] call _buildWallSet
];

private _state =
[
    true,
    _display,
    _settings,
    toLower _mapId,
    "",
    [],
    0,
    0,
    [],
    [],
    [],
    _wallCtrls,
    _spritePool,
    _weaponCtrl,
    _hudCtrls,
    [],
    [],
    [diag_tickTime, 0.016, 16, 0, 60],
    "",
    (diag_tickTime + 14),
    "blood",
    "grate",
    [-1, -1, -1, -1, -1, -1, -1, -1, -1],
    _wallCache,
    -1,
    []
];

_state = [_state] call DB_fnc_rui_resetRun;
uiNamespace setVariable [DB_RUI_KEY_GATE_VAR, [-1, -1, -1]];
uiNamespace setVariable [DB_RUI_FOCUS_TRACE_VAR, -999];
uiNamespace setVariable [DB_RUI_SOUND_COOLDOWNS_VAR, createHashMap];

private _debugBg = (_state # DB_RUI_S_HUD_CTRLS) # DB_RUI_HUD_DEBUG_BG;
private _debugText = (_state # DB_RUI_S_HUD_CTRLS) # DB_RUI_HUD_DEBUG_TEXT;
_debugBg ctrlShow false;
_debugText ctrlShow false;

if (!isNull _inputCapture) then
{
    _inputCapture ctrlEnable true;
    _inputCapture ctrlSetText " ";
    _inputCapture ctrlSetTextSelection [0, 0];
};

diag_log text format
[
    "[DB_RUI] initSession map=%1 quality=%2 debug=%3 displayIDD=%4 inputIDC=%5 inputEnabled=%6",
    toLower _mapId,
    _qualityName,
    _debug,
    DB_RUI_IDD,
    if (isNull _inputCapture) then {-1} else {ctrlIDC _inputCapture},
    if (isNull _inputCapture) then {false} else {ctrlEnabled _inputCapture}
];

private _keyDownEh = _display displayAddEventHandler ["KeyDown",
{
    params ["_display", "_dikCode", "_shift", "_ctrlKey", "_alt"];
    [_display, _dikCode, true, _shift, _ctrlKey, _alt] call DB_fnc_rui_handleKeyEvent
}];

private _keyUpEh = _display displayAddEventHandler ["KeyUp",
{
    params ["_display", "_dikCode", "_shift", "_ctrlKey", "_alt"];
    [_display, _dikCode, false, _shift, _ctrlKey, _alt] call DB_fnc_rui_handleKeyEvent
}];

private _mouseDownEh = _display displayAddEventHandler ["MouseButtonDown",
{
    params ["_display", "_button"];
    if (_button != 0) exitWith
    {
        false
    };

    [_display, true] call DB_fnc_rui_setMouseFire
}];

private _mouseUpEh = _display displayAddEventHandler ["MouseButtonUp",
{
    params ["_display", "_button"];
    if (_button != 0) exitWith
    {
        false
    };

    [_display, false] call DB_fnc_rui_setMouseFire
}];

private _mouseMovingEh = _display displayAddEventHandler ["MouseMoving",
{
    params ["_display"];

    private _capture = _display displayCtrl DB_RUI_IDC_INPUT_CAPTURE;
    if (!isNull _capture) then
    {
        ctrlSetFocus _capture;
    };

    false
}];

private _ctrlKeyDownEh = -1;
private _ctrlKeyUpEh = -1;
private _ctrlSetFocusEh = -1;
private _ctrlKillFocusEh = -1;

if (!isNull _inputCapture) then
{
    _ctrlKeyDownEh = _inputCapture ctrlAddEventHandler ["KeyDown",
    {
        params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
        [_ctrl, _dikCode, true, _shift, _ctrlKey, _alt] call DB_fnc_rui_handleKeyEvent
    }];

    _ctrlKeyUpEh = _inputCapture ctrlAddEventHandler ["KeyUp",
    {
        params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
        [_ctrl, _dikCode, false, _shift, _ctrlKey, _alt] call DB_fnc_rui_handleKeyEvent
    }];

    _ctrlSetFocusEh = _inputCapture ctrlAddEventHandler ["SetFocus",
    {
        params ["_ctrl"];
        diag_log text format ["[DB_RUI] inputCapture setFocus idc=%1", ctrlIDC _ctrl];
    }];

    _ctrlKillFocusEh = _inputCapture ctrlAddEventHandler ["KillFocus",
    {
        params ["_ctrl"];
        diag_log text format ["[DB_RUI] inputCapture killFocus idc=%1", ctrlIDC _ctrl];
    }];

    ctrlSetFocus _inputCapture;
    _inputCapture ctrlSetTextSelection [0, 0];
};

_state set [DB_RUI_S_INPUT_EHS, [_keyDownEh, _keyUpEh, _mouseDownEh, _mouseUpEh, _mouseMovingEh, _ctrlKeyDownEh, _ctrlKeyUpEh, _ctrlSetFocusEh, _ctrlKillFocusEh]];

private _frameEh = addMissionEventHandler ["EachFrame",
{
    call DB_fnc_rui_tick;
}];

_state set [DB_RUI_S_FRAME_EH, _frameEh];
SET_UIVAR(DB_RUI_DISPLAY_VAR, _display);
SET_UIVAR(DB_RUI_STATE_VAR, _state);

diag_log text format
[
    "[DB_RUI] initSession handlers display=%1 control=%2 frame=%3",
    [_keyDownEh, _keyUpEh, _mouseDownEh, _mouseUpEh, _mouseMovingEh],
    [_ctrlKeyDownEh, _ctrlKeyUpEh, _ctrlSetFocusEh, _ctrlKillFocusEh],
    _frameEh
];

call DB_fnc_rui_tick;

true
