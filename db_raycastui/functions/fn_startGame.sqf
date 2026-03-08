#include "\db_raycastui\script_component.hpp"

params [
    ["_mapId", "demo_01", [""]],
    ["_quality", "MEDIUM", [""]],
    ["_debug", false, [false]]
];

disableSerialization;

private _existingState = GET_UIVAR(DB_RUI_STATE_VAR, []);
if ((_existingState isEqualType []) && {count _existingState > 0} && {_existingState # DB_RUI_S_RUNNING}) exitWith
{
    false
};

private _created = createDialog "DB_RaycastUIDialog";
if (!_created) exitWith
{
    false
};

private _display = GET_UIVAR(DB_RUI_DISPLAY_VAR, displayNull);
if (isNull _display) then
{
    _display = findDisplay DB_RUI_IDD;
};

if (isNull _display) exitWith
{
    closeDialog 0;
    false
};

[_display, _mapId, _quality, _debug] call DB_fnc_rui_initSession
