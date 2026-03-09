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
private _debugBg = _hud # DB_RUI_HUD_DEBUG_BG;
private _debugText = _hud # DB_RUI_HUD_DEBUG_TEXT;
private _settings = _state # DB_RUI_S_SETTINGS;

if !(_settings # DB_RUI_CFG_DEBUG) exitWith
{
    _debugBg ctrlShow false;
    _debugText ctrlShow false;
    _state
};

_debugBg ctrlShow true;
_debugText ctrlShow true;
_debugBg ctrlSetBackgroundColor [0, 0, 0, 0.72];

private _player = _state # DB_RUI_S_PLAYER;
private _stats = _state # DB_RUI_S_STATS;
private _aliveEnemies = count ((_state # DB_RUI_S_ENEMIES) select {_x # DB_RUI_E_ALIVE});
private _projectileCount = count (_state # DB_RUI_S_PROJECTILES);
private _weaponInfo = [_player] call DB_fnc_rui_getWeaponInfo;
_weaponInfo params ["_weaponText", "_clipText", "_reserveText"];
private _fpsText = (_stats # DB_RUI_STATS_FPS) toFixed 1;
private _frameText = (_stats # DB_RUI_STATS_FRAME_MS) toFixed 2;
private _rayText = (_stats # DB_RUI_STATS_RAY_MS) toFixed 2;
private _posXText = (_player # DB_RUI_P_X) toFixed 2;
private _posYText = (_player # DB_RUI_P_Y) toFixed 2;
private _dirText = (_player # DB_RUI_P_DIR) toFixed 1;
private _text = format
[
    "<t shadow='1'>FPS %1<br/>FRAME %2 ms<br/>RAY %3 ms<br/>POS %4 / %5<br/>DIR %6<br/>WEAPON %7 (%8|%9)<br/>ENEMIES %10<br/>FIREBALLS %11<br/>COLUMNS %12<br/>QUALITY %13</t>",
    _fpsText,
    _frameText,
    _rayText,
    _posXText,
    _posYText,
    _dirText,
    _weaponText,
    _clipText,
    _reserveText,
    _aliveEnemies,
    _projectileCount,
    _settings # DB_RUI_CFG_COLUMNS,
    _settings # DB_RUI_CFG_QUALITY_NAME
];

_debugText ctrlSetStructuredText parseText _text;

_state
