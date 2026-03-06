params ["_display", "_key", "_shift", "_ctrl", "_alt"];

if !(uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith { false };

if (_key isEqualTo 1) exitWith {
    call DB_dsi_fnc_inv_close;
    true
};

if ((_key isEqualTo 57) || {_key isEqualTo 28}) exitWith {
    call DB_dsi_fnc_inv_activateSelection;
    true
};

if (_key isEqualTo 203) exitWith {
    [-1] call DB_dsi_fnc_inv_changePage;
    true
};

if (_key isEqualTo 205) exitWith {
    [1] call DB_dsi_fnc_inv_changePage;
    true
};

if (_key isEqualTo 15) exitWith {
    private _context = uiNamespace getVariable ["DB_dsi_context", []];
    if (_context isEqualTo []) exitWith { true };

    private _panels = _context # 4;
    private _panelIndex = uiNamespace getVariable ["DB_dsi_panelIndex", 0];
    private _next = (_panelIndex + 1) mod ((count _panels) max 1);
    [_next] call DB_dsi_fnc_inv_setPanel;
    true
};

if ((_key isEqualTo 23) && {_ctrl}) exitWith {
    call DB_dsi_fnc_inv_close;
    true
};

false
