disableSerialization;
params ["_display"];

private _selected = _display getVariable ["DB_UIEditor_Selected", -1];
private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _nodeIndex = _nodes findIf {(_x # 0) == _selected};
if (_nodeIndex < 0) exitWith {};

private _node = _nodes # _nodeIndex;
_node params ["", "_control", "_parentId", "_class"];

private _fields = _display getVariable ["DB_UIEditor_Fields", []];
private _gridControl = _display getVariable ["DB_UIEditor_Grid", controlNull];
private _grid = lbCurSel _gridControl;
private _gridPosition = [];

for "_index" from 1 to 4 do {
    _gridPosition pushBack parseNumber ctrlText (_fields # _index);
};

private _position = [_gridPosition, _grid, _parentId >= 0, true] call DB_fnc_uiEditorPosition;

if (_class == "RscMapControl") then {
    _control ctrlMapSetPosition _position;
} else {
    _control ctrlSetPosition _position;
    _control ctrlCommit 0;
};

{
    if ((_x # 3) == "RscMapControl") then {
        (_x # 1) ctrlMapSetPosition [];
    };
} forEach _nodes;

private _text = ctrlText (_fields # 0);
if (_class == "RscStructuredText") then {
    _control ctrlSetStructuredText parseText _text;
} else {
    _control ctrlSetText _text;
};

[_display, _selected] call DB_fnc_uiEditorSelect;
[_display] call DB_fnc_uiEditorExport;
