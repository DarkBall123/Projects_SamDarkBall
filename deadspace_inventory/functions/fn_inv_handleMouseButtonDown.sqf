params ["_displayOrControl", "_button"];

if !(uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith { false };

if (_button isEqualTo 0) exitWith {
    call DB_dsi_fnc_inv_activateSelection;
    true
};

false
