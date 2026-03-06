params ["_display", "_scroll"];

if !(uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith { false };

[0 - _scroll] call DB_dsi_fnc_inv_changePage;
true
