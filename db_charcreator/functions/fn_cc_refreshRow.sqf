/*
    db_charcreator: refresh one row's value label.
    Purpose: redraw the centered "Display Name   (i/n)" text for an attribute after
             its selection changes.
    Context: client.
    Params:
        0: STRING - attribute key
    Returns: nothing.
*/

#include "..\script_macros.hpp"

disableSerialization;

params ["_key"];

private _display = GETUVAR(DB_cc_display, displayNull);
if (isNull _display) exitWith {};

private _model = GETUVAR(DB_cc_model, []);
private _idx = _model findIf { (_x select 0) isEqualTo _key };
if (_idx < 0) exitWith {};

private _entry = _model select _idx;
private _list  = _entry select 3;
private _ctrl  = _display displayCtrl CC_IDC_ROW_VALUE(_idx);

if (count _list == 0) exitWith {
    _ctrl ctrlSetStructuredText parseText "<t align='center' color='#808080'>-</t>";
};

private _sel  = _entry select 4;
private _disp = (_list select _sel) select 1;
private _text = format ["<t align='center' size='0.95'>%1</t><br/><t align='center' size='0.7' color='#7F8C9A'>%2 / %3</t>", _disp, _sel + 1, count _list];

_ctrl ctrlSetStructuredText parseText _text;
