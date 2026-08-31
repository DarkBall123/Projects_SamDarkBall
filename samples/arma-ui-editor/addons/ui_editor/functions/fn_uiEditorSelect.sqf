disableSerialization;
params ["_display", "_id", ["_toggle", false], ["_preserve", false]];

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
if ((_nodes findIf {(_x # 0) == _id}) < 0) exitWith {};

private _selection = _display getVariable ["DB_UIEditor_Selection", []];
private _selectedIndex = _selection find _id;

if (!_preserve) then {
    if (_toggle) then {
        if (_selectedIndex < 0) then {
            _selection pushBack _id;
        } else {
            _selection deleteAt _selectedIndex;
        };
    } else {
        _selection = [_id];
    };
};

_display setVariable ["DB_UIEditor_Selection", _selection];
[_display, true] call DB_fnc_uiEditorOverlay;
[_display] call DB_fnc_uiEditorRefresh;

if (_selection isEqualTo []) exitWith {};

private _primary = _selection # ((count _selection) - 1);
private _nodeIndex = _nodes findIf {(_x # 0) == _primary};
private _node = _nodes # _nodeIndex;
_node params ["", "_control", "_parentId", "_class"];

private _position = if (_class == "RscMapControl") then {
    ctrlMapPosition _control
} else {
    ctrlPosition _control
};

if (_parentId < 0) then {
    private _canvasPosition = ctrlPosition (_display getVariable ["DB_UIEditor_CanvasControl", controlNull]);
    _position set [0, (_position # 0) + (_canvasPosition # 0)];
    _position set [1, (_position # 1) + (_canvasPosition # 1)];
};

private _gridControl = _display getVariable ["DB_UIEditor_Grid", controlNull];
private _gridPosition = [_position, lbCurSel _gridControl, _parentId >= 0] call DB_fnc_uiEditorPosition;
private _fields = _display getVariable ["DB_UIEditor_Fields", []];
private _typeLabel = _display getVariable ["DB_UIEditor_TypeLabel", controlNull];

_typeLabel ctrlSetText format ["%1 selected  |  #%2 %3", count _selection, _primary, _class];
(_fields # 0) ctrlSetText ctrlText _control;

{
    (_fields # (_forEachIndex + 1)) ctrlSetText (_x toFixed 4);
} forEach _gridPosition;
