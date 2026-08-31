disableSerialization;
params ["_display", "_id"];

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _nodeIndex = _nodes findIf {(_x # 0) == _id};
if (_nodeIndex < 0) exitWith {};

private _node = _nodes # _nodeIndex;
_node params ["", "_control", "_parentId", "_class", "_name"];

private _position = if (_class == "RscMapControl") then {
    ctrlMapPosition _control
} else {
    ctrlPosition _control
};

private _gridControl = _display getVariable ["DB_UIEditor_Grid", controlNull];
private _grid = lbCurSel _gridControl;
private _gridPosition = [_position, _grid, _parentId >= 0] call DB_fnc_uiEditorPosition;
private _fields = _display getVariable ["DB_UIEditor_Fields", []];
private _typeLabel = _display getVariable ["DB_UIEditor_TypeLabel", controlNull];

_display setVariable ["DB_UIEditor_Selected", _id];
_typeLabel ctrlSetText format ["#%1  %2  |  parent: %3", _id, _class, if (_parentId < 0) then {"root"} else {str _parentId}];

(_fields # 0) ctrlSetText ctrlText _control;
{
    (_fields # (_forEachIndex + 1)) ctrlSetText ((_x toFixed 4));
} forEach _gridPosition;
