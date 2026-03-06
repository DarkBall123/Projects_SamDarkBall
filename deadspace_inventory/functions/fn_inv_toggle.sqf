if (uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith {
    call DB_dsi_fnc_inv_close;
    true
};

private _target = call DB_dsi_fnc_inv_findTarget;
[_target] call DB_dsi_fnc_inv_open
