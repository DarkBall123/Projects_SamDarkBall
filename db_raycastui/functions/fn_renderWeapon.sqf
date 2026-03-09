#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

disableSerialization;

if (_state isEqualTo []) exitWith
{
    _state
};

private _weaponCtrl = _state # DB_RUI_S_WEAPON_CTRL;
private _player = _state # DB_RUI_S_PLAYER;
private _input = _state # DB_RUI_S_INPUT;
private _outcome = _state # DB_RUI_S_OUTCOME;
private _hudCtrls = _state # DB_RUI_S_HUD_CTRLS;
private _time = diag_tickTime;
private _weaponId = _player # DB_RUI_P_WEAPON;
private _flashActive = _time < (_player # DB_RUI_P_FLASH_UNTIL);
private _reloadState = _player # DB_RUI_P_RELOAD_STATE;
private _switching = _time < (_player # DB_RUI_P_SWITCH_UNTIL);
private _statusBarCtrl = _hudCtrls # DB_RUI_HUD_STATUS_BAR;
private _statusBarPos = ctrlPosition _statusBarCtrl;
_statusBarPos params ["_statusX", "_statusY", "_statusW", "_statusH"];

private _layout = switch (_weaponId) do
{
    case DB_RUI_WPN_SHOTGUN:
    {
        [_statusX + (_statusW * 0.401), _statusY - (_statusH * 1.42), _statusW * 0.15, _statusH * 1.24]
    };
    default
    {
        [_statusX + (_statusW * 0.446), _statusY - (_statusH * 1.05), _statusW * 0.072, _statusH * 0.92]
    };
};

_layout params ["_baseX", "_baseY", "_width", "_height"];
private _texture = if (_weaponId == DB_RUI_WPN_SHOTGUN) then
{
    DB_RUI_TX_WPN_SHOTGUN
}
else
{
    DB_RUI_TX_WPN_PISTOL
};
private _bobX = 0;
private _bobY = 0;

if ((_input # DB_RUI_IN_FORWARD) || {_input # DB_RUI_IN_BACK}) then
{
    _bobX = (sin (_time * 460)) * (DB_RUI_W * 0.0045);
    _bobY = abs (cos (_time * 460)) * (DB_RUI_H * 0.010);
};

switch (_weaponId) do
{
    case DB_RUI_WPN_SHOTGUN:
    {
        if (_reloadState == DB_RUI_RELOAD_SHOTGUN) then
        {
            _texture = DB_RUI_TX_WPN_SHOTGUN_RELOAD;
            _baseY = _baseY + (_statusH * 0.12);
        };

        if (_flashActive) then
        {
            _texture = DB_RUI_TX_WPN_SHOTGUN_FIRE;
            _baseY = _baseY - (_statusH * 0.08);
            _baseX = _baseX - (_statusW * 0.003);
        };
    };
    default
    {
        if (_flashActive) then
        {
            _texture = DB_RUI_TX_WPN_PISTOL_FIRE;
            _baseY = _baseY - (_statusH * 0.06);
            _baseX = _baseX - (_statusW * 0.0015);
        };

        if (_reloadState == DB_RUI_RELOAD_PISTOL) then
        {
            _baseY = _baseY + (_statusH * 0.16);
            _bobX = _bobX - (_statusW * 0.003);
        };
    };
};

if (_switching) then
{
    _baseY = _baseY + (_statusH * 0.26);
};

if !(_outcome isEqualTo "") then
{
    _baseY = _baseY + (_statusH * 0.18);
    _weaponCtrl ctrlSetTextColor [0.62, 0.62, 0.62, 0.92];
}
else
{
    _weaponCtrl ctrlSetTextColor (if (_flashActive) then {[1, 1, 1, 1]} else {[0.96, 0.96, 0.96, 1]});
};

_weaponCtrl ctrlSetText _texture;
_weaponCtrl ctrlSetPosition [_baseX + _bobX, _baseY + _bobY, _width, _height];
_weaponCtrl ctrlCommit 0;

_state
