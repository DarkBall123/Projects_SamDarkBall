params [["_panelIndex", 0, [0]]];

private _context = uiNamespace getVariable ["DB_dsi_context", []];
if (_context isEqualTo []) exitWith {};

private _panelCount = count (_context # 4);
if (_panelCount <= 0) exitWith {};

uiNamespace setVariable ["DB_dsi_panelIndex", (_panelIndex max 0) min (_panelCount - 1)];
uiNamespace setVariable ["DB_dsi_pageIndex", 0];

call DB_dsi_fnc_inv_render;
