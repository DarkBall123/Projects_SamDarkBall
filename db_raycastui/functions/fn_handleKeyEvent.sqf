#include "\db_raycastui\script_component.hpp"

params [
    ["_source", controlNull],
    ["_dikCode", -1, [0]],
    ["_isDown", true, [true]],
    ["_shift", false, [true]],
    ["_ctrlKey", false, [true]],
    ["_alt", false, [true]]
];

disableSerialization;

private _state = GET_UIVAR(DB_RUI_STATE_VAR, []);
if (_state isEqualTo []) exitWith
{
    false
};

private _marker = if (_isDown) then {1} else {0};
private _gate = GET_UIVAR(DB_RUI_KEY_GATE_VAR, [-1, -1, -1]);
if (((_gate # 0) == diag_frameNo) && {(_gate # 1) == _dikCode} && {(_gate # 2) == _marker}) exitWith
{
    true
};

SET_UIVAR(DB_RUI_KEY_GATE_VAR, [diag_frameNo, _dikCode, _marker]);

private _input = +(_state # DB_RUI_S_INPUT);
private _settings = +(_state # DB_RUI_S_SETTINGS);
private _handled = true;
private _recognized = true;

if (_isDown) then
{
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
                            diag_log text "[DB_RUI] KeyDown requested stopGame via X";
                            [] call DB_fnc_rui_stopGame;
                        };
                        case DIK_ESCAPE:
                        {
                            diag_log text "[DB_RUI] KeyDown requested stopGame via Escape";
                            [] call DB_fnc_rui_stopGame;
                        };
                        default
                        {
                            _recognized = false;
                            _handled = false;
                        };
                    };
                };
            };
        };
    };
}
else
{
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
                        case DIK_F1:
                        {
                        };
                        case DIK_X:
                        {
                        };
                        case DIK_ESCAPE:
                        {
                        };
                        default
                        {
                            _recognized = false;
                            _handled = false;
                        };
                    };
                };
            };
        };
    };
};

_state set [DB_RUI_S_INPUT, _input];
SET_UIVAR(DB_RUI_STATE_VAR, _state);

if (_recognized) then
{
    private _display = _state # DB_RUI_S_DISPLAY;
    private _focusedIDC = -1;
    if (!isNull _display) then
    {
        private _focused = focusedCtrl _display;
        if (!isNull _focused) then
        {
            _focusedIDC = ctrlIDC _focused;
        };
    };

    diag_log text format
    [
        "[DB_RUI] key%1 src=%2 code=%3 handled=%4 focusIDC=%5 shift=%6 ctrl=%7 alt=%8 input=%9",
        if (_isDown) then {"Down"} else {"Up"},
        typeName _source,
        _dikCode,
        _handled,
        _focusedIDC,
        _shift,
        _ctrlKey,
        _alt,
        _input
    ];
};

_handled
