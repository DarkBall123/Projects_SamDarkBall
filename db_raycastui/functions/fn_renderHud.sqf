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

_hpCtrl ctrlSetStructuredText parseText format ["<t shadow='1'>HP %1</t>", round (_player # DB_RUI_P_HP)];
_ammoCtrl ctrlSetStructuredText parseText format ["<t shadow='1'>AMMO %1</t>", round (_player # DB_RUI_P_AMMO)];
_mapCtrl ctrlSetStructuredText parseText format ["<t shadow='1'>%1<br/><t size='0.8'>QUALITY %2</t></t>", _state # DB_RUI_S_MAP_NAME, (_settings # DB_RUI_CFG_QUALITY_NAME)];

private _helpText = "W/S move<br/>A/D turn<br/>SPACE or LMB fire<br/>R restart run<br/>F1 debug | X or Esc exit";
private _outcome = _state # DB_RUI_S_OUTCOME;

if (_outcome isEqualTo "") then
{
    _outcomeCtrl ctrlSetStructuredText parseText "";
    _helpCtrl ctrlSetStructuredText parseText format ["<t align='right'>%1</t>", _helpText];
    _crossH ctrlSetBackgroundColor [0.95, 0.92, 0.72, 1];
    _crossV ctrlSetBackgroundColor [0.95, 0.92, 0.72, 1];
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
    _helpCtrl ctrlSetStructuredText parseText format ["<t align='right'>%1</t>", _helpText];
    _crossH ctrlSetBackgroundColor [0.78, 0.22, 0.18, 1];
    _crossV ctrlSetBackgroundColor [0.78, 0.22, 0.18, 1];
};

_state
