disableSerialization;
params ["_display"];

private _selection = _display getVariable ["DB_UIEditor_Selection", []];
if (_selection isEqualTo []) exitWith {};

private _selected = _selection # ((count _selection) - 1);
private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _nodeIndex = _nodes findIf {(_x # 0) == _selected};
if (_nodeIndex < 0) exitWith {};

private _node = _nodes # _nodeIndex;
_node params ["", "_control", "_parentId", "_class", "", "_isGroup"];

private _fields = _display getVariable ["DB_UIEditor_Fields", []];
private _gridControl = _display getVariable ["DB_UIEditor_Grid", controlNull];
private _gridPosition = [];

for "_index" from 1 to 4 do {
    _gridPosition pushBack parseNumber ctrlText (_fields # _index);
};

private _position = [_gridPosition, lbCurSel _gridControl, _parentId >= 0, true] call DB_fnc_uiEditorPosition;

if (_parentId < 0) then {
    private _canvasPosition = ctrlPosition (_display getVariable ["DB_UIEditor_CanvasControl", controlNull]);
    _position set [0, (_position # 0) - (_canvasPosition # 0)];
    _position set [1, (_position # 1) - (_canvasPosition # 1)];
};

private _parent = [_display, _parentId] call DB_fnc_uiEditorParent;
private _parentPosition = ctrlPosition _parent;
private _maxX = ((_parentPosition # 2) - (_position # 2)) max 0;
private _minY = [0, 4 * pixelH * pixelGrid] select (_parentId >= 0);
private _maxY = ((_parentPosition # 3) - (_position # 3)) max _minY;
_position set [0, ((_position # 0) max 0) min _maxX];
_position set [1, ((_position # 1) max _minY) min _maxY];

if (_class == "RscMapControl") then {
    _control ctrlMapSetPosition _position;
} else {
    _control ctrlSetPosition _position;
    _control ctrlCommit 0;
};

if (_isGroup) then {
    private _background = _control getVariable ["DB_UIEditor_GroupBackground", controlNull];
    private _header = _control getVariable ["DB_UIEditor_GroupHeader", controlNull];
    _background ctrlSetPosition [0, 0, _position # 2, _position # 3];
    _header ctrlSetPosition [0, 0, _position # 2, 4 * pixelH * pixelGrid];
    _background ctrlCommit 0;
    _header ctrlCommit 0;
};

private _text = ctrlText (_fields # 0);
if (_class == "RscStructuredText") then {
    _control ctrlSetStructuredText parseText _text;
} else {
    _control ctrlSetText _text;
};

{
    if ((_x # 3) == "RscMapControl") then {
        (_x # 1) ctrlMapSetPosition [];
    };
} forEach _nodes;

[_display, false] call DB_fnc_uiEditorOverlay;
[_display, _selected, false, true] call DB_fnc_uiEditorSelect;
[_display] call DB_fnc_uiEditorExport;
