params [["_entry", [], [[]]]];

if (_entry isEqualTo []) exitWith { false };

private _context = uiNamespace getVariable ["DB_dsi_context", []];
if (_context isEqualTo []) exitWith { false };

private _source = _context # 0;
private _panels = _context # 4;
private _panel = _panels param [uiNamespace getVariable ["DB_dsi_panelIndex", 0], []];
if (_panel isEqualTo []) exitWith { false };

private _panelType = _panel # 0;

if !([player, _entry] call DB_dsi_fnc_inv_canAddEntry) exitWith {
    hintSilent "No space";
    false
};

["DB_dsi_commitTransfer", [player, _source, _panelType, _entry], _source] call CBA_fnc_targetEvent;

[
    { call DB_dsi_fnc_inv_refresh },
    [],
    0.15
] call CBA_fnc_waitAndExecute;

true
