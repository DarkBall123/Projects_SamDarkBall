/*
    db_charcreator: step an attribute to the previous/next option.
    Purpose: shared handler for every < / > button. Wraps the index, applies the
             new selection to the player and refreshes the row label.
    Context: client, from a button ButtonClick handler.
    Params:
        0: STRING - attribute key
        1: NUMBER - delta (-1 previous, +1 next)
    Returns: nothing.
*/

#include "..\script_macros.hpp"

params ["_key", "_delta"];

private _model = GETUVAR(DB_cc_model, []);
private _idx = _model findIf { (_x select 0) isEqualTo _key };
if (_idx < 0) exitWith {};

private _entry = _model select _idx;
private _list  = _entry select 3;
private _count = count _list;
if (_count == 0) exitWith {};

private _sel = ((_entry select 4) + _delta + _count) % _count;
_entry set [4, _sel];
_model set [_idx, _entry];
SETUVAR(DB_cc_model, _model);

[_key] call DB_fnc_cc_apply;
[_key] call DB_fnc_cc_refreshRow;
