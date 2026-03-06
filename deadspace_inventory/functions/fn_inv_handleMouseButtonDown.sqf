params ["_displayOrControl", "_button"];

if !(uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith { false };

if (_button isEqualTo 0) exitWith {
    true
};

false
