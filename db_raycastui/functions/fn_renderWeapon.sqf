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
private _time = diag_tickTime;
private _weaponId = _player # DB_RUI_P_WEAPON;
private _flashActive = _time < (_player # DB_RUI_P_FLASH_UNTIL);
private _reloadState = _player # DB_RUI_P_RELOAD_STATE;
private _switching = _time < (_player # DB_RUI_P_SWITCH_UNTIL);
private _statusTop = DB_RUI_H - (DB_RUI_H * 0.245);

private _layout = switch (_weaponId) do
{
    case DB_RUI_WPN_SHOTGUN:
    {
        [DB_RUI_W * 0.355, _statusTop - (DB_RUI_H * 0.155), DB_RUI_W * 0.29, DB_RUI_H * 0.17]
    };
    default
    {
        [DB_RUI_W * 0.410, _statusTop - (DB_RUI_H * 0.110), DB_RUI_W * 0.18, DB_RUI_H * 0.13]
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
            _baseY = _baseY + (DB_RUI_H * 0.015);
        };

        if (_flashActive) then
        {
            _texture = DB_RUI_TX_WPN_SHOTGUN_FIRE;
            _baseY = _baseY - (DB_RUI_H * 0.010);
            _baseX = _baseX - (DB_RUI_W * 0.004);
        };
    };
    default
    {
        if (_flashActive) then
        {
            _texture = DB_RUI_TX_WPN_PISTOL_FIRE;
            _baseY = _baseY - (DB_RUI_H * 0.008);
            _baseX = _baseX - (DB_RUI_W * 0.003);
        };

        if (_reloadState == DB_RUI_RELOAD_PISTOL) then
        {
            _baseY = _baseY + (DB_RUI_H * 0.022);
            _bobX = _bobX - (DB_RUI_W * 0.006);
        };
    };
};

if (_switching) then
{
    _baseY = _baseY + (DB_RUI_H * 0.06);
};

if !(_outcome isEqualTo "") then
{
    _baseY = _baseY + (DB_RUI_H * 0.05);
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
