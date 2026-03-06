private _context = uiNamespace getVariable ["DB_dsi_context", []];
if (_context isEqualTo []) exitWith {};

private _source = _context # 0;
if (isNull _source) exitWith {
    call DB_dsi_fnc_inv_close;
};

private _panels = _context # 4;
private _selectedPanel = _panels param [uiNamespace getVariable ["DB_dsi_panelIndex", 0], []];
private _selectedType = _selectedPanel param [0, "cargo"];

private _newContext = [_source] call DB_dsi_fnc_inv_buildContext;
if (_newContext isEqualTo []) exitWith {
    call DB_dsi_fnc_inv_close;
};

uiNamespace setVariable ["DB_dsi_context", _newContext];

private _newPanels = _newContext # 4;
private _newIndex = _newPanels findIf { (_x # 0) isEqualTo _selectedType };
if (_newIndex < 0) then {
    _newIndex = 0;
};

uiNamespace setVariable ["DB_dsi_panelIndex", _newIndex];

private _entries = (_newPanels # _newIndex) # 3;
private _pageSize = call DB_dsi_fnc_inv_getPageSize;
private _pageCount = ((ceil ((count _entries) / _pageSize)) max 1);
private _maxPage = _pageCount - 1;
private _pageIndex = (uiNamespace getVariable ["DB_dsi_pageIndex", 0]) min (_maxPage max 0);
uiNamespace setVariable ["DB_dsi_pageIndex", _pageIndex];

call DB_dsi_fnc_inv_render;
