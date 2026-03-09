#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

disableSerialization;

if (_state isEqualTo []) exitWith
{
    _state
};

private _hud = _state # DB_RUI_S_HUD_CTRLS;
private _player = _state # DB_RUI_S_PLAYER;
private _settings = _state # DB_RUI_S_SETTINGS;
private _hpCtrl = _hud # DB_RUI_HUD_HP;
private _ammoCtrl = _hud # DB_RUI_HUD_AMMO;
private _mapCtrl = _hud # DB_RUI_HUD_MAP;
private _helpCtrl = _hud # DB_RUI_HUD_HELP;
private _outcomeCtrl = _hud # DB_RUI_HUD_OUTCOME;
private _crossH = _hud # DB_RUI_HUD_CROSS_H;
private _crossV = _hud # DB_RUI_HUD_CROSS_V;
private _faceCtrl = _hud # DB_RUI_HUD_FACE;
private _armorCtrl = _hud # DB_RUI_HUD_ARMOR;
private _armsCtrl = _hud # DB_RUI_HUD_ARMS;
private _ammoTableCtrl = _hud # DB_RUI_HUD_AMMO_TABLE;
private _statusBarCtrl = _hud # DB_RUI_HUD_STATUS_BAR;
private _weaponInfo = [_player] call DB_fnc_rui_getWeaponInfo;
_weaponInfo params ["_weaponName", "_clipText", "_reserveText", "_isReloading"];

private _hpValue = (round (_player # DB_RUI_P_HP)) max 0;
private _armorValue = 0;
private _reserveAmmo = (_player # DB_RUI_P_AMMO) max 0;
private _pistolPool = ((_player # DB_RUI_P_PISTOL_CLIP) + _reserveAmmo) min 200;
private _shellPool = if (_player # DB_RUI_P_HAS_SHOTGUN) then {((_player # DB_RUI_P_SHOTGUN_LOADED) + _reserveAmmo) min 50} else {0};
private _rocketPool = 0;
private _cellPool = 0;
private _ammoValue = if ((_player # DB_RUI_P_WEAPON) == DB_RUI_WPN_SHOTGUN) then {_shellPool} else {_pistolPool};
private _aliveEnemies = count ((_state # DB_RUI_S_ENEMIES) select {_x # DB_RUI_E_ALIVE});
private _hasExitGoal = (((_state # DB_RUI_S_PICKUPS) findIf {(_x # DB_RUI_PK_TYPE) isEqualTo "exit"}) >= 0);
private _flashActive = ((_player # DB_RUI_P_FLASH_UNTIL) > diag_tickTime);

_statusBarCtrl ctrlShow false;
_faceCtrl ctrlShow false;
_armsCtrl ctrlShow false;

private _bigNumberStyle = "font='EtelkaMonospaceProBold' shadow='1'";
private _labelStyle = "font='PuristaSemibold' shadow='1'";
private _ammoColor = "#F2E7BF";
private _healthColor = if (_hpValue < 35) then {"#FF8A5B"} else {"#F2E7BF"};
private _armorColor = "#D8E6F4";

_ammoCtrl ctrlSetStructuredText parseText format
[
    "<t align='left' valign='middle'><t %3 size='0.18' color='#CDBE96'>AMMO</t><br/><t %1 size='0.62' color='%4'>%2</t></t>",
    _bigNumberStyle,
    _ammoValue,
    _labelStyle,
    _ammoColor
];

_hpCtrl ctrlSetStructuredText parseText format
[
    "<t align='left' valign='middle'><t %3 size='0.18' color='#CDBE96'>HEALTH</t><br/><t %1 size='0.62' color='%4'>%2%%</t></t>",
    _bigNumberStyle,
    _hpValue,
    _labelStyle,
    _healthColor
];

_armorCtrl ctrlSetStructuredText parseText format
[
    "<t align='left' valign='middle'><t %3 size='0.18' color='#CDBE96'>ARMOR</t><br/><t %1 size='0.62' color='%4'>%2%%</t></t>",
    _bigNumberStyle,
    _armorValue,
    _labelStyle,
    _armorColor
];

_armsCtrl ctrlSetStructuredText parseText "";

_ammoTableCtrl ctrlSetStructuredText parseText format
[
    "<t align='left' font='EtelkaMonospaceProBold' size='0.25' shadow='1' color='#CDBE96'>RESERVES</t><br/><t align='left' font='EtelkaMonospaceProBold' size='0.31' shadow='1' color='#E9E1CC'>BULL  <t color='#F2E7BF'>%1</t> <t color='#8C8579'>/</t> 200<br/>SHEL  <t color='#F2E7BF'>%2</t> <t color='#8C8579'>/</t> 50<br/>RCKT  <t color='#F2E7BF'>%3</t> <t color='#8C8579'>/</t> 50<br/>CELL  <t color='#F2E7BF'>%4</t> <t color='#8C8579'>/</t> 300</t>",
    _pistolPool,
    _shellPool,
    _rocketPool,
    _cellPool
];

private _statusTag = if (_hasExitGoal) then
{
    if (_aliveEnemies > 0) then
    {
        format ["<br/><t font='PuristaSemibold' size='0.72' color='#F1D14B'>PURGE THE PIT: %1 LEFT</t>", _aliveEnemies]
    }
    else
    {
        "<br/><t font='PuristaSemibold' size='0.72' color='#7EF2A6'>REACH THE LIFT</t>"
    }
}
else
{
    if (_isReloading) then
    {
        "<br/><t font='PuristaSemibold' size='0.76' color='#F1D14B'>RELOADING</t>"
    }
    else
    {
        format ["<br/><t font='PuristaSemibold' size='0.72' color='#CFC6B4'>%1 READY</t>", _weaponName]
    }
};
_mapCtrl ctrlSetStructuredText parseText format ["<t shadow='1'>%1<br/><t size='0.82' color='#F0C35E'>QUALITY %2</t>%3</t>", _state # DB_RUI_S_MAP_NAME, (_settings # DB_RUI_CFG_QUALITY_NAME), _statusTag];

private _outcome = _state # DB_RUI_S_OUTCOME;

if (_outcome isEqualTo "") then
{
    _outcomeCtrl ctrlSetStructuredText parseText "";
    _helpCtrl ctrlSetStructuredText parseText format ["<t align='right' font='EtelkaMonospacePro'>%1</t>", DB_RUI_HELP_TEXT];
    if ((_player # DB_RUI_P_FLASH_UNTIL) > diag_tickTime) then
    {
        _crossH ctrlSetBackgroundColor [1, 0.82, 0.42, 1];
        _crossV ctrlSetBackgroundColor [1, 0.82, 0.42, 1];
    }
    else
    {
        _crossH ctrlSetBackgroundColor [0.95, 0.92, 0.72, 1];
        _crossV ctrlSetBackgroundColor [0.95, 0.92, 0.72, 1];
    };
}
else
{
    private _outcomeText = switch (_outcome) do
    {
        case "won":
        {
            "LEVEL CLEAR<br/><t size='0.55'>R restart the run<br/>Esc or X return to Arma</t>"
        };
        case "lost":
        {
            "YOU DIED<br/><t size='0.55'>R retry the arena<br/>Esc or X return to Arma</t>"
        };
        default
        {
            "SESSION CLOSED"
        };
    };

    _outcomeCtrl ctrlSetStructuredText parseText format ["<t align='center'>%1</t>", _outcomeText];
    _helpCtrl ctrlSetStructuredText parseText format ["<t align='right' font='EtelkaMonospacePro'>%1</t>", DB_RUI_HELP_TEXT];
    _crossH ctrlSetBackgroundColor [0.78, 0.22, 0.18, 1];
    _crossV ctrlSetBackgroundColor [0.78, 0.22, 0.18, 1];
};

_state
