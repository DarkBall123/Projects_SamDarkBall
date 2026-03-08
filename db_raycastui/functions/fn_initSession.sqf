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

private _columnWidth = DB_RUI_W / _columnCount;
private _settings =
[
    _qualityName,
    _columnCount,
    _columnWidth,
    65,
    DB_RUI_H * 0.92,
    2.85,
    135,
    _debug,
    22,
    DB_RUI_MAX_SPRITES
];

private _worldGroup = _display displayCtrl DB_RUI_IDC_WORLD_GROUP;
private _spriteGroup = _display displayCtrl DB_RUI_IDC_SPRITE_GROUP;
private _weaponCtrl = _display displayCtrl DB_RUI_IDC_WEAPON;
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
    _display displayCtrl DB_RUI_IDC_WEAPON_STRIP,
    _display displayCtrl DB_RUI_IDC_LOGO
];

private _wallCtrls = [];
for "_index" from 0 to (_columnCount - 1) do
{
    private _ctrl = _display ctrlCreate ["DB_RUI_RscPicture", -1, _worldGroup];
    _ctrl ctrlSetText DB_RUI_CLEAR_TEXTURE;
    _ctrl ctrlSetTextColor [1, 1, 1, 1];
    _ctrl ctrlSetPosition [0, 0, 0, 0];
    _ctrl ctrlCommit 0;
    _wallCtrls pushBack _ctrl;
};

private _spritePool = [];
for "_slot" from 0 to (DB_RUI_MAX_SPRITES - 1) do
{
    private _main = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _second = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _third = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _fourth = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];
    private _fifth = _display ctrlCreate ["DB_RUI_RscText", -1, _spriteGroup];

    {
        _x ctrlSetPosition [0, 0, 0, 0];
        _x ctrlCommit 0;
        _x ctrlShow false;
    }
    forEach [_main, _second, _third, _fourth, _fifth];

    _spritePool pushBack [_main, _second, _third, _fourth, _fifth];
};

private _wallCache = [[], [], [], []];
{
    private _folder = _x;
    private _paths = [];

    for "_slice" from 0 to (DB_RUI_SLICE_COUNT - 1) do
    {
        private _suffix = if (_slice < 10) then {format ["0%1", _slice]} else {str _slice};
        _paths pushBack format ["\db_raycastui\data\walls\%1\jpg\slice_%2.paa", _folder, _suffix];
    };

    _wallCache set [_forEachIndex + 1, _paths];
}
forEach ["brick", "tech", "stone"];

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
    [0, 0, 0, 100, 16, 0, 0],
    [false, false, false, false, false, false],
    [],
    _wallCtrls,
    _spritePool,
    _weaponCtrl,
    _hudCtrls,
    [],
    [],
    [diag_tickTime, 0.016, 16, 0, 60],
    "",
    diag_tickTime + 14,
    "blood",
    "grate",
    [-1, -1, -1, -1],
    _wallCache
];

_state = [_state] call DB_fnc_rui_resetRun;

private _keyDownEh = _display displayAddEventHandler ["KeyDown",
{
    params ["_display", "_dikCode"];

    private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
    if (_state isEqualTo []) exitWith
    {
        false
    };

    private _input = +(_state # DB_RUI_S_INPUT);
    private _settings = _state # DB_RUI_S_SETTINGS;
    private _handled = true;

    if (_dikCode in [DIK_W, DIK_UP]) then
    {
        _input set [DB_RUI_IN_FORWARD, true];
    }
    else
    {
        if (_dikCode in [DIK_S, DIK_DOWN]) then
        {
            _input set [DB_RUI_IN_BACK, true];
        }
        else
        {
            if (_dikCode in [DIK_A, DIK_LEFT]) then
            {
                _input set [DB_RUI_IN_TURN_LEFT, true];
            }
            else
            {
                if (_dikCode in [DIK_D, DIK_RIGHT]) then
                {
                    _input set [DB_RUI_IN_TURN_RIGHT, true];
                }
                else
                {
                    switch (_dikCode) do
                    {
                        case DIK_SPACE:
                        {
                            _input set [DB_RUI_IN_FIRE, true];
                        };
                        case DIK_R:
                        {
                            _input set [DB_RUI_IN_RESTART, true];
                        };
                        case DIK_F1:
                        {
                            _settings set [DB_RUI_CFG_DEBUG, !(_settings # DB_RUI_CFG_DEBUG)];
                            _state set [DB_RUI_S_SETTINGS, _settings];
                        };
                        case DIK_X:
                        {
                            [] call DB_fnc_rui_stopGame;
                        };
                        case DIK_ESCAPE:
                        {
                            _handled = false;
                        };
                        default
                        {
                            _handled = false;
                        };
                    };
                };
            };
        };
    };

    _state set [DB_RUI_S_INPUT, _input];
    SET_UIVAR(DB_RUI_STATE_VAR, _state);
    _handled
}];

private _keyUpEh = _display displayAddEventHandler ["KeyUp",
{
    params ["_display", "_dikCode"];

    private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
    if (_state isEqualTo []) exitWith
    {
        false
    };

    private _input = +(_state # DB_RUI_S_INPUT);
    private _handled = true;

    if (_dikCode in [DIK_W, DIK_UP]) then
    {
        _input set [DB_RUI_IN_FORWARD, false];
    }
    else
    {
        if (_dikCode in [DIK_S, DIK_DOWN]) then
        {
            _input set [DB_RUI_IN_BACK, false];
        }
        else
        {
            if (_dikCode in [DIK_A, DIK_LEFT]) then
            {
                _input set [DB_RUI_IN_TURN_LEFT, false];
            }
            else
            {
                if (_dikCode in [DIK_D, DIK_RIGHT]) then
                {
                    _input set [DB_RUI_IN_TURN_RIGHT, false];
                }
                else
                {
                    switch (_dikCode) do
                    {
                        case DIK_SPACE:
                        {
                            _input set [DB_RUI_IN_FIRE, false];
                        };
                        case DIK_R:
                        {
                            _input set [DB_RUI_IN_RESTART, false];
                        };
                        default
                        {
                            _handled = false;
                        };
                    };
                };
            };
        };
    };

    _state set [DB_RUI_S_INPUT, _input];
    SET_UIVAR(DB_RUI_STATE_VAR, _state);
    _handled
}];

private _mouseDownEh = _display displayAddEventHandler ["MouseButtonDown",
{
    params ["_display", "_button"];

    if (_button != 0) exitWith
    {
        false
    };

    private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
    if (_state isEqualTo []) exitWith
    {
        false
    };

    private _input = +(_state # DB_RUI_S_INPUT);
    _input set [DB_RUI_IN_FIRE, true];
    _state set [DB_RUI_S_INPUT, _input];
    SET_UIVAR(DB_RUI_STATE_VAR, _state);
    true
}];

private _mouseUpEh = _display displayAddEventHandler ["MouseButtonUp",
{
    params ["_display", "_button"];

    if (_button != 0) exitWith
    {
        false
    };

    private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
    if (_state isEqualTo []) exitWith
    {
        false
    };

    private _input = +(_state # DB_RUI_S_INPUT);
    _input set [DB_RUI_IN_FIRE, false];
    _state set [DB_RUI_S_INPUT, _input];
    SET_UIVAR(DB_RUI_STATE_VAR, _state);
    true
}];

_state set [DB_RUI_S_INPUT_EHS, [_keyDownEh, _keyUpEh, _mouseDownEh, _mouseUpEh]];

showCursor false;
SET_UIVAR(DB_RUI_DISPLAY_VAR, _display);
SET_UIVAR(DB_RUI_STATE_VAR, _state);

onEachFrame
{
    call DB_fnc_rui_tick;
};

true
