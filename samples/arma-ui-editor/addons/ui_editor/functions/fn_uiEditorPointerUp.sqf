disableSerialization;
params ["_display"];

if ((_display getVariable ["DB_UIEditor_Interaction", []]) isEqualTo []) exitWith {};

_display setVariable ["DB_UIEditor_Interaction", []];
private _selection = _display getVariable ["DB_UIEditor_Selection", []];

if (_selection isNotEqualTo []) then {
    [_display, _selection # ((count _selection) - 1), false, true] call DB_fnc_uiEditorSelect;
};

[_display] call DB_fnc_uiEditorExport;
