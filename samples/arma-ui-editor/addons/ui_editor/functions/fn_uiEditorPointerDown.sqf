disableSerialization;
params ["_display", "_id", "_ctrlKey", "_mode"];

if (_id < 0) exitWith {};

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _selection = _display getVariable ["DB_UIEditor_Selection", []];

if (_mode == "drag") then {
    if (_ctrlKey) then {
        [_display, _id, true] call DB_fnc_uiEditorSelect;
        _selection = _display getVariable ["DB_UIEditor_Selection", []];
    } else {
        if !(_id in _selection) then {
            [_display, _id, false] call DB_fnc_uiEditorSelect;
            _selection = [_id];
        };
    };
} else {
    _selection = [_id];
    _display setVariable ["DB_UIEditor_Selection", _selection];
};

if (_selection isEqualTo []) exitWith {};

private _items = [];
{
    private _selectedId = _x;
    private _nodeIndex = _nodes findIf {(_x # 0) == _selectedId};

    if (_nodeIndex >= 0) then {
        private _node = _nodes # _nodeIndex;
        private _control = _node # 1;
        private _position = if ((_node # 3) == "RscMapControl") then {
            ctrlMapPosition _control
        } else {
            ctrlPosition _control
        };
        private _parent = [_display, _node # 2] call DB_fnc_uiEditorParent;
        private _parentPosition = ctrlPosition _parent;
        private _minY = [0, 4 * pixelH * pixelGrid] select ((_node # 2) >= 0);
        _items pushBack [_selectedId, _control, _position, [_parentPosition # 2, _parentPosition # 3, _minY], _node # 3, _node # 5];
    };
} forEach _selection;

if (_mode == "resize") then {
    _items = _items select {(_x # 0) == _id};
};

_display setVariable ["DB_UIEditor_Interaction", [_mode, getMousePosition, _items]];
