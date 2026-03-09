#include "\db_raycastui\script_component.hpp"

params [
    ["_source", displayNull, [displayNull, controlNull]],
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
private _gate = uiNamespace getVariable [DB_RUI_KEY_GATE_VAR, [-1, -1, -1]];
if (((_gate # 0) == diag_frameNo) && {(_gate # 1) == _dikCode} && {(_gate # 2) == _marker}) exitWith
{
    true
};

uiNamespace setVariable [DB_RUI_KEY_GATE_VAR, [diag_frameNo, _dikCode, _marker]];

private _input = +(_state # DB_RUI_S_INPUT);
private _settings = +(_state # DB_RUI_S_SETTINGS);
private _player = +(_state # DB_RUI_S_PLAYER);
private _handled = true;
private _recognized = true;
private _now = diag_tickTime;

private _setInputFlag =
{
    params ["_flag"];
    _input set [_flag, _isDown];
};

private _selectWeapon =
{
    params ["_weaponId"];

    if ((_player # DB_RUI_P_RELOAD_STATE) != DB_RUI_RELOAD_NONE) exitWith
    {
        false
    };

    if (_now < (_player # DB_RUI_P_SWITCH_UNTIL)) exitWith
    {
        false
    };

    if ((_weaponId == DB_RUI_WPN_SHOTGUN) && {!(_player # DB_RUI_P_HAS_SHOTGUN)}) exitWith
    {
        false
    };

    if ((_player # DB_RUI_P_WEAPON) == _weaponId) exitWith
    {
        false
    };

    _player set [DB_RUI_P_WEAPON, _weaponId];
    _player set [DB_RUI_P_SWITCH_UNTIL, _now + DB_RUI_SWITCH_TIME];
    _player set [DB_RUI_P_NEXT_FIRE, (_player # DB_RUI_P_NEXT_FIRE) max (_now + DB_RUI_SWITCH_TIME)];
    true
};

private _toggleWeapon =
{
    private _targetWeapon = if ((_player # DB_RUI_P_WEAPON) == DB_RUI_WPN_PISTOL) then
    {
        DB_RUI_WPN_SHOTGUN
    }
    else
    {
        DB_RUI_WPN_PISTOL
    };

    [_targetWeapon] call _selectWeapon
};

switch true do
{
    case (_dikCode in [DIK_W, DIK_UP]):
    {
        [DB_RUI_IN_FORWARD] call _setInputFlag;
    };
    case (_dikCode in [DIK_S, DIK_DOWN]):
    {
        [DB_RUI_IN_BACK] call _setInputFlag;
    };
    case (_dikCode in [DIK_A, DIK_LEFT]):
    {
        [DB_RUI_IN_TURN_LEFT] call _setInputFlag;
    };
    case (_dikCode in [DIK_D, DIK_RIGHT]):
    {
        [DB_RUI_IN_TURN_RIGHT] call _setInputFlag;
    };
    default
    {
        if (_isDown) then
        {
            switch (_dikCode) do
            {
                case DIK_Q:
                {
                    if (call _toggleWeapon) then
                    {
                        _input set [DB_RUI_IN_SWITCH, true];
                    };
                };
                case DIK_1:
                {
                    if ([DB_RUI_WPN_PISTOL] call _selectWeapon) then
                    {
                        _input set [DB_RUI_IN_SWITCH, true];
                    };
                };
                case DIK_2:
                {
                    if ([DB_RUI_WPN_SHOTGUN] call _selectWeapon) then
                    {
                        _input set [DB_RUI_IN_SWITCH, true];
                    };
                };
                case DIK_SPACE:
                {
                    _input set [DB_RUI_IN_FIRE, true];
                };
                case DIK_E:
                {
                    _input set [DB_RUI_IN_RELOAD, true];
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
        }
        else
        {
            switch (_dikCode) do
            {
                case DIK_Q:
                {
                    _input set [DB_RUI_IN_SWITCH, false];
                };
                case DIK_1:
                {
                    _input set [DB_RUI_IN_SWITCH, false];
                };
                case DIK_2:
                {
                    _input set [DB_RUI_IN_SWITCH, false];
                };
                case DIK_SPACE:
                {
                    _input set [DB_RUI_IN_FIRE, false];
                };
                case DIK_E:
                {
                    _input set [DB_RUI_IN_RELOAD, false];
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

_state set [DB_RUI_S_INPUT, _input];
_state set [DB_RUI_S_PLAYER, _player];
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
