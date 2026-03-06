if !(uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith { false };

uiNamespace setVariable ["DB_dsi_isOpen", false];
uiNamespace setVariable ["DB_dsi_context", []];
uiNamespace setVariable ["DB_dsi_panelIndex", 0];
uiNamespace setVariable ["DB_dsi_pageIndex", 0];
uiNamespace setVariable ["DB_dsi_selectedOption", []];

call DB_dsi_fnc_inv_cleanupOverlay;

true
