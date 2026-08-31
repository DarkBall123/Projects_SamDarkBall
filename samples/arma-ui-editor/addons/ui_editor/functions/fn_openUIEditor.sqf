disableSerialization;

private _existing = uiNamespace getVariable ["DB_UIEditor_Display", displayNull];
if (!isNull _existing) exitWith {
    _existing closeDisplay 2;
};

private _parent = if (is3DEN) then {
    findDisplay 313
} else {
    [] call BIS_fnc_displayMission
};

if (isNull _parent) exitWith {
    systemChat "DB UI Editor: open a mission or Eden first.";
};

private _display = _parent createDisplay "RscDisplayEmpty";
uiNamespace setVariable ["DB_UIEditor_Display", _display];

_display displayAddEventHandler ["Unload", {
    uiNamespace setVariable ["DB_UIEditor_Display", displayNull];
}];

[_display] call DB_fnc_uiEditorBuild;
_display
