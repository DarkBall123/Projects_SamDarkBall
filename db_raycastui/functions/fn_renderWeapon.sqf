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

private _baseX = DB_RUI_W * 0.32;
private _baseY = DB_RUI_H * 0.72;
private _bobStrength = 0;

if ((_input # DB_RUI_IN_FORWARD) || {_input # DB_RUI_IN_BACK}) then
{
    _bobStrength = (sin (_time * 520)) * (DB_RUI_W * 0.004);
};

private _kick = 0;
if (_time < (_player # DB_RUI_P_FLASH_UNTIL)) then
{
    _kick = DB_RUI_H * 0.012;
    _weaponCtrl ctrlSetTextColor [1, 1, 1, 1];
}
else
{
    _weaponCtrl ctrlSetTextColor [0.92, 0.92, 0.92, 1];
};

if !(_outcome isEqualTo "") then
{
    _baseY = DB_RUI_H * 0.76;
};

_weaponCtrl ctrlSetPosition [_baseX + _bobStrength, _baseY - _kick, DB_RUI_W * 0.36, DB_RUI_H * 0.27];
_weaponCtrl ctrlCommit 0;

_state
