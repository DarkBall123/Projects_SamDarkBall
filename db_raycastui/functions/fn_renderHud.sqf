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
private _faceTexture = DB_RUI_TX_FACE_IDLE;
private _flashActive = ((_player # DB_RUI_P_FLASH_UNTIL) > diag_tickTime);

if (_flashActive) then
{
    _faceTexture = DB_RUI_TX_FACE_ALERT;
};

if (_hpValue < 35) then
{
    _faceTexture = DB_RUI_TX_FACE_HURT;
};

if ((_state # DB_RUI_S_OUTCOME) isEqualTo "lost") then
{
    _faceTexture = DB_RUI_TX_FACE_DEAD;
};

_faceCtrl ctrlSetText _faceTexture;

private _bigNumberStyle = "font='EtelkaMonospaceProBold' shadow='1'";
private _labelStyle = "font='PuristaSemibold' shadow='1'";

_ammoCtrl ctrlSetStructuredText parseText format
[
    "<t align='center' valign='middle'><t %1 size='0.76' color='#D31912'>%2</t><br/><t %3 size='0.26' color='#DDD4C6'>AMMO</t></t>",
    _bigNumberStyle,
    _ammoValue,
    _labelStyle
];

_hpCtrl ctrlSetStructuredText parseText format
[
    "<t align='center' valign='middle'><t %1 size='0.76' color='#D31912'>%2%%</t><br/><t %3 size='0.26' color='#DDD4C6'>HEALTH</t></t>",
    _bigNumberStyle,
    _hpValue,
    _labelStyle
];

_armorCtrl ctrlSetStructuredText parseText format
[
    "<t align='center' valign='middle'><t %1 size='0.76' color='#D31912'>%2%%</t><br/><t %3 size='0.26' color='#DDD4C6'>ARMOR</t></t>",
    _bigNumberStyle,
    _armorValue,
    _labelStyle
];

private _weaponSlotMarkup =
{
    params ["_slot", "_isOwned", "_isActive"];

    private _color = "#59544D";
    if (_isOwned) then
    {
        _color = "#D8D2B8";
    };
    if (_isActive) then
    {
        _color = "#F4D44C";
    };

    format ["<t color='%1'>%2</t>", _color, _slot]
};

private _slot2 = [2, true, ((_player # DB_RUI_P_WEAPON) == DB_RUI_WPN_PISTOL)] call _weaponSlotMarkup;
private _slot3 = [3, (_player # DB_RUI_P_HAS_SHOTGUN), ((_player # DB_RUI_P_WEAPON) == DB_RUI_WPN_SHOTGUN)] call _weaponSlotMarkup;
private _slot4 = [4, false, false] call _weaponSlotMarkup;
private _slot5 = [5, false, false] call _weaponSlotMarkup;
private _slot6 = [6, false, false] call _weaponSlotMarkup;
private _slot7 = [7, false, false] call _weaponSlotMarkup;

_armsCtrl ctrlSetStructuredText parseText format
[
    "<t align='center' valign='middle'><t font='EtelkaMonospaceProBold' size='0.28'>%1 %2 %3<br/>%4 %5 %6</t><br/><t %7 size='0.22' color='#DDD4C6'>ARMS</t></t>",
    _slot2,
    _slot3,
    _slot4,
    _slot5,
    _slot6,
    _slot7,
    _labelStyle
];

_ammoTableCtrl ctrlSetStructuredText parseText format
[
    "<t font='EtelkaMonospaceProBold' size='0.30' shadow='1' color='#D2CCC1'>BULL <t color='#F1D14B'>%1</t> <t color='#8C8579'>/</t> <t color='#E6E0CC'>200</t><br/>SHEL <t color='#F1D14B'>%2</t> <t color='#8C8579'>/</t> <t color='#E6E0CC'>50</t><br/>RCKT <t color='#F1D14B'>%3</t> <t color='#8C8579'>/</t> <t color='#E6E0CC'>50</t><br/>CELL <t color='#F1D14B'>%4</t> <t color='#8C8579'>/</t> <t color='#E6E0CC'>300</t></t>",
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
