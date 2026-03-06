private _selected = uiNamespace getVariable ["DB_dsi_selectedOption", []];
if (_selected isEqualTo []) exitWith { false };

_selected params ["_kind", "_payload"];

if (_kind isEqualTo "panel") exitWith {
    [_payload] call DB_dsi_fnc_inv_setPanel;
    true
};

if (_kind isEqualTo "entry") exitWith {
    [_payload] call DB_dsi_fnc_inv_requestTransfer;
    true
};

false
