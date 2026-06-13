/*
    db_charcreator: build the creator panel.
    Purpose: create the dynamic RscDisplayEmpty dialog and a right-side, GTA-style
             translucent panel with one row per attribute (label + value + < >),
             section headers and a Finish button. Wires the orbit/ESC key handlers.
    Context: client, called once on open.
    Params: none.
    Returns: nothing (stores DB_cc_display in uiNamespace; null on failure).
*/

#include "..\script_macros.hpp"

disableSerialization;

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
if (isNull _display) exitWith { SETUVAR(DB_cc_display, displayNull); };
SETUVAR(DB_cc_display, _display);

private _model = GETUVAR(DB_cc_model, []);

// --- Panel geometry -----------------------------------------------------------
private _pw = GRID_W(30);
private _px = safeZoneX + safeZoneW - _pw - GRID_W(1.5);
private _py = safeZoneY + GRID_H(2);
private _ph = safeZoneH - GRID_H(4);

// Small control factory: [class, idc, x, y, w, h] -> ctrl.
private _mk = {
    params ["_cls", "_idc", "_cx", "_cy", "_cw", "_ch"];
    private _c = _display ctrlCreate [_cls, _idc];
    _c ctrlSetPosition [_cx, _cy, _cw, _ch];
    _c ctrlCommit 0;
    _c
};

// --- Background + header -------------------------------------------------------
private _bg = ["RscText", CC_IDC_BG, _px, _py, _pw, _ph] call _mk;
_bg ctrlSetBackgroundColor [0.05, 0.06, 0.07, 0.78];

private _accent = ["RscText", -1, _px, _py, _pw, GRID_H(0.25)] call _mk;
_accent ctrlSetBackgroundColor [0.18, 0.45, 0.78, 1];

private _header = ["RscStructuredText", CC_IDC_HEADER, _px + GRID_W(1.5), _py + GRID_H(0.8), _pw - GRID_W(3), GRID_H(2)] call _mk;
_header ctrlSetStructuredText parseText "<t size='1.5' shadow='1'>CHARACTER CREATOR</t>";

private _hint = ["RscStructuredText", CC_IDC_HINT, _px + GRID_W(1.5), _py + GRID_H(2.7), _pw - GRID_W(3), GRID_H(1.4)] call _mk;
_hint ctrlSetStructuredText parseText "<t size='0.85' color='#9FB4C8'>Hold A / E to rotate  -  changes apply live</t>";

// --- Rows ---------------------------------------------------------------------
private _rowH    = GRID_H(2.6);
private _rowGap  = GRID_H(0.5);
private _y       = _py + GRID_H(4.6);
private _lastSection = "";

{
    _x params ["_key", "_label", "_section"];

    // Section header when the section changes.
    if !(_section isEqualTo _lastSection) then {
        _lastSection = _section;
        private _sh = ["RscStructuredText", -1, _px + GRID_W(1.5), _y, _pw - GRID_W(3), GRID_H(1.6)] call _mk;
        _sh ctrlSetStructuredText parseText format ["<t size='1.0' color='#7CC0FF'>%1</t>", toUpper _section];
        _y = _y + GRID_H(1.8);
    };

    private _i = _forEachIndex;

    private _lbl = ["RscStructuredText", CC_IDC_ROW_LABEL(_i), _px + GRID_W(1.5), _y, GRID_W(8), _rowH] call _mk;
    _lbl ctrlSetStructuredText parseText format ["<t size='1.0'>%1</t>", _label];

    private _prev = ["RscButton", CC_IDC_ROW_PREV(_i), _px + GRID_W(9.5), _y, GRID_W(2.2), _rowH] call _mk;
    _prev ctrlSetText "<";
    _prev setVariable ["DB_cc_btn", [_key, -1]];
    _prev ctrlAddEventHandler ["ButtonClick", {
        (_this select 0) getVariable ["DB_cc_btn", ["", 0]] call DB_fnc_cc_cycle;
    }];

    private _val = ["RscStructuredText", CC_IDC_ROW_VALUE(_i), _px + GRID_W(11.9), _y + GRID_H(0.35), GRID_W(14), _rowH] call _mk;

    private _next = ["RscButton", CC_IDC_ROW_NEXT(_i), _px + GRID_W(26.3), _y, GRID_W(2.2), _rowH] call _mk;
    _next ctrlSetText ">";
    _next setVariable ["DB_cc_btn", [_key, 1]];
    _next ctrlAddEventHandler ["ButtonClick", {
        (_this select 0) getVariable ["DB_cc_btn", ["", 0]] call DB_fnc_cc_cycle;
    }];

    _y = _y + _rowH + _rowGap;
} forEach _model;

// --- Finish -------------------------------------------------------------------
private _finish = ["RscButtonMenu", CC_IDC_FINISH, _px + GRID_W(1.5), _py + _ph - GRID_H(2.6), _pw - GRID_W(3), GRID_H(2)] call _mk;
_finish ctrlSetText "FINISH";
_finish ctrlSetBackgroundColor [0.18, 0.45, 0.78, 1];
_finish ctrlAddEventHandler ["ButtonClick", { call DB_fnc_cc_close; }];

// --- Display-level handlers ----------------------------------------------------
_display displayAddEventHandler ["Unload", { call DB_fnc_cc_close; }];

_display displayAddEventHandler ["KeyDown", {
    params ["_disp", "_key"];
    switch (_key) do {
        case 1:  { call DB_fnc_cc_close; true };          // ESC
        case 30: { SETMVAR(DB_cc_orbitDir, -1); true };   // A
        case 18: { SETMVAR(DB_cc_orbitDir,  1); true };   // E
        case 17: { true };                                // W (keep player put)
        case 31: { true };                                // S
        case 32: { true };                                // D
        default { false };
    };
}];

_display displayAddEventHandler ["KeyUp", {
    params ["_disp", "_key"];
    if (_key in [30, 18]) then { SETMVAR(DB_cc_orbitDir, 0); };
    false
}];

// Populate every row's value label.
{
    [_x select 0] call DB_fnc_cc_refreshRow;
} forEach _model;
