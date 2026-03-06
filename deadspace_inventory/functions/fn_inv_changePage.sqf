params [["_delta", 0, [0]]];

private _context = uiNamespace getVariable ["DB_dsi_context", []];
if (_context isEqualTo []) exitWith {};

private _panels = _context # 4;
private _panel = _panels param [uiNamespace getVariable ["DB_dsi_panelIndex", 0], []];
if (_panel isEqualTo []) exitWith {};

private _entries = _panel # 3;
private _pageSize = 12;
private _pageCount = ((ceil ((count _entries) / _pageSize)) max 1);
private _maxPage = _pageCount - 1;

private _pageIndex = uiNamespace getVariable ["DB_dsi_pageIndex", 0];
private _newIndex = (_pageIndex + _delta) max 0 min (_maxPage max 0);

uiNamespace setVariable ["DB_dsi_pageIndex", _newIndex];
call DB_dsi_fnc_inv_render;
