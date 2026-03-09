#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

if (_state isEqualTo []) exitWith
{
    _state
};

private _input = +(_state # DB_RUI_S_INPUT);
private _player = +(_state # DB_RUI_S_PLAYER);
private _outcome = _state # DB_RUI_S_OUTCOME;
private _now = diag_tickTime;

private _finishReload =
{
    switch (_player # DB_RUI_P_RELOAD_STATE) do
    {
        case DB_RUI_RELOAD_PISTOL:
        {
            private _missing = DB_RUI_PISTOL_CLIP_SIZE - (_player # DB_RUI_P_PISTOL_CLIP);
            private _load = (_missing min (_player # DB_RUI_P_AMMO)) max 0;
            _player set [DB_RUI_P_PISTOL_CLIP, (_player # DB_RUI_P_PISTOL_CLIP) + _load];
            _player set [DB_RUI_P_AMMO, (_player # DB_RUI_P_AMMO) - _load];
        };
        case DB_RUI_RELOAD_SHOTGUN:
        {
            if (((_player # DB_RUI_P_SHOTGUN_LOADED) < DB_RUI_SHOTGUN_CHAMBER_SIZE) && {(_player # DB_RUI_P_AMMO) > 0}) then
            {
                _player set [DB_RUI_P_SHOTGUN_LOADED, DB_RUI_SHOTGUN_CHAMBER_SIZE];
                _player set [DB_RUI_P_AMMO, (_player # DB_RUI_P_AMMO) - 1];
            };
        };
    };

    _player set [DB_RUI_P_RELOAD_UNTIL, 0];
    _player set [DB_RUI_P_RELOAD_STATE, DB_RUI_RELOAD_NONE];
};

private _startReload =
{
    private _reloadState = DB_RUI_RELOAD_NONE;
    private _reloadTime = 0;
    private _canReload = false;

    switch (_player # DB_RUI_P_WEAPON) do
    {
        case DB_RUI_WPN_SHOTGUN:
        {
            _canReload = (((_player # DB_RUI_P_SHOTGUN_LOADED) < DB_RUI_SHOTGUN_CHAMBER_SIZE) && {(_player # DB_RUI_P_AMMO) > 0});
            _reloadState = DB_RUI_RELOAD_SHOTGUN;
            _reloadTime = DB_RUI_SHOTGUN_RELOAD_TIME;
        };
        default
        {
            _canReload = (((_player # DB_RUI_P_PISTOL_CLIP) < DB_RUI_PISTOL_CLIP_SIZE) && {(_player # DB_RUI_P_AMMO) > 0});
            _reloadState = DB_RUI_RELOAD_PISTOL;
            _reloadTime = DB_RUI_PISTOL_RELOAD_TIME;
        };
    };

    if (!_canReload) exitWith
    {
        false
    };

    _player set [DB_RUI_P_RELOAD_STATE, _reloadState];
    _player set [DB_RUI_P_RELOAD_UNTIL, _now + _reloadTime];
    _player set [DB_RUI_P_NEXT_FIRE, (_player # DB_RUI_P_NEXT_FIRE) max (_now + _reloadTime)];
    true
};

if (((_player # DB_RUI_P_RELOAD_STATE) != DB_RUI_RELOAD_NONE) && {_now >= (_player # DB_RUI_P_RELOAD_UNTIL)}) then
{
    call _finishReload;
};

if !(_outcome isEqualTo "") exitWith
{
    if (_input # DB_RUI_IN_RESTART) then
    {
        _state = [_state] call DB_fnc_rui_resetRun;
        _input = _state # DB_RUI_S_INPUT;
        _input set [DB_RUI_IN_RESTART, false];
        _state set [DB_RUI_S_INPUT, _input];
        _state
    }
    else
    {
        _state set [DB_RUI_S_PLAYER, _player];
        _state set [DB_RUI_S_INPUT, _input];
        _state
    };
};

private _readyForWeaponActions = ((_player # DB_RUI_P_RELOAD_STATE) == DB_RUI_RELOAD_NONE) && {_now >= (_player # DB_RUI_P_SWITCH_UNTIL)};

if ((_input # DB_RUI_IN_RELOAD) && {_readyForWeaponActions}) then
{
    call _startReload;
    _input set [DB_RUI_IN_RELOAD, false];
};

if ((_input # DB_RUI_IN_FIRE) && {_readyForWeaponActions}) then
{
    private _hasLoadedRound = switch (_player # DB_RUI_P_WEAPON) do
    {
        case DB_RUI_WPN_SHOTGUN:
        {
            (_player # DB_RUI_P_SHOTGUN_LOADED) > 0
        };
        default
        {
            (_player # DB_RUI_P_PISTOL_CLIP) > 0
        };
    };

    if (_hasLoadedRound) then
    {
        _state set [DB_RUI_S_PLAYER, _player];
        _state = [_state] call DB_fnc_rui_fireWeapon;
        _player = +(_state # DB_RUI_S_PLAYER);
    }
    else
    {
        call _startReload;
    };
};

_state set [DB_RUI_S_PLAYER, _player];
_state set [DB_RUI_S_INPUT, _input];
_state
