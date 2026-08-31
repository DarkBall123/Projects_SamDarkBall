disableSerialization;
params ["_display", "_action"];

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _selection = _display getVariable ["DB_UIEditor_Selection", []];

if (_action == "group") exitWith {
    if ((count _selection) < 2) exitWith {
        systemChat "DB UI Editor: Ctrl-click at least two controls.";
    };

    private _selectedNodes = _nodes select {(_x # 0) in _selection};
    private _parentIds = _selectedNodes apply {_x # 2};

    if ((_parentIds arrayIntersect _parentIds) isNotEqualTo [_parentIds # 0]) exitWith {
        systemChat "DB UI Editor: grouped controls must have the same parent.";
    };

    if ((_selectedNodes findIf {_x # 5}) >= 0) exitWith {
        systemChat "DB UI Editor: nested group selection is not supported in this sample.";
    };

    private _parentId = _parentIds # 0;
    private _parentControl = [_display, _parentId] call DB_fnc_uiEditorParent;
    private _parentPosition = ctrlPosition _parentControl;
    private _paddingX = 3 * pixelW * pixelGrid;
    private _paddingY = 6 * pixelH * pixelGrid;
    private _minX = 1e6;
    private _minY = 1e6;
    private _maxX = -1e6;
    private _maxY = -1e6;
    private _records = [];

    {
        _x params ["_id", "_control", "", "_class", "_name", "_isGroup"];
        private _position = if (_class == "RscMapControl") then {
            ctrlMapPosition _control
        } else {
            ctrlPosition _control
        };
        _position params ["_xPos", "_yPos", "_width", "_height"];
        _minX = _minX min _xPos;
        _minY = _minY min _yPos;
        _maxX = _maxX max (_xPos + _width);
        _maxY = _maxY max (_yPos + _height);
        _records pushBack [_id, _control, _class, _name, _isGroup, _position, ctrlText _control];
    } forEach _selectedNodes;

    private _groupX = (_minX - _paddingX) max 0;
    private _parentMinY = [0, 4 * pixelH * pixelGrid] select (_parentId >= 0);
    private _groupY = (_minY - _paddingY) max _parentMinY;
    private _groupW = (_maxX - _minX + 2 * _paddingX) min ((_parentPosition # 2) - _groupX);
    private _groupH = (_maxY - _minY + 2 * _paddingY) min ((_parentPosition # 3) - _groupY);
    private _groupId = _display getVariable ["DB_UIEditor_NextId", 1];
    private _groupName = format ["Group %1", _groupId];

    _display setVariable ["DB_UIEditor_Selection", []];
    [_display, true] call DB_fnc_uiEditorOverlay;

    private _groupControl = [
        _display,
        _groupId,
        "RscControlsGroupNoScrollbars",
        _parentControl,
        _groupName,
        true,
        [_groupX, _groupY, _groupW, _groupH]
    ] call DB_fnc_uiEditorCreateControl;

    _nodes pushBack [_groupId, _groupControl, _parentId, "RscControlsGroupNoScrollbars", _groupName, true];

    {
        _x params ["_id", "_oldControl", "_class", "_name", "_isGroup", "_oldPosition", "_text"];
        ctrlDelete _oldControl;
        private _newPosition = +_oldPosition;
        _newPosition set [0, (_oldPosition # 0) - _groupX];
        _newPosition set [1, (_oldPosition # 1) - _groupY];
        private _newControl = [
            _display,
            _id,
            _class,
            _groupControl,
            _name,
            _isGroup,
            _newPosition,
            _text,
            true
        ] call DB_fnc_uiEditorCreateControl;
        private _nodeIndex = _nodes findIf {(_x # 0) == _id};
        _nodes set [_nodeIndex, [_id, _newControl, _groupId, _class, _name, _isGroup]];
    } forEach _records;

    _display setVariable ["DB_UIEditor_Nodes", _nodes];
    _display setVariable ["DB_UIEditor_NextId", _groupId + 1];
    _display setVariable ["DB_UIEditor_Selection", [_groupId]];
    [_display, true] call DB_fnc_uiEditorOverlay;
    [_display] call DB_fnc_uiEditorRefresh;
    [_display] call DB_fnc_uiEditorExport;
};

if (_selection isEqualTo []) exitWith {
    systemChat "DB UI Editor: select a group first.";
};

private _groupId = _selection # ((count _selection) - 1);
private _groupIndex = _nodes findIf {(_x # 0) == _groupId};
if (_groupIndex < 0 || {!((_nodes # _groupIndex) # 5)}) exitWith {
    systemChat "DB UI Editor: select a group first.";
};

private _groupNode = _nodes # _groupIndex;
private _groupControl = _groupNode # 1;
private _groupParentId = _groupNode # 2;
private _groupPosition = ctrlPosition _groupControl;
private _children = _nodes select {(_x # 2) == _groupId};

if ((_children findIf {_x # 5}) >= 0) exitWith {
    systemChat "DB UI Editor: ungroup nested groups from the inside out.";
};

private _parentControl = [_display, _groupParentId] call DB_fnc_uiEditorParent;
private _records = [];

{
    _x params ["_id", "_control", "", "_class", "_name", "_isGroup"];
    private _position = if (_class == "RscMapControl") then {
        ctrlMapPosition _control
    } else {
        ctrlPosition _control
    };
    _records pushBack [_id, _control, _class, _name, _isGroup, _position, ctrlText _control];
} forEach _children;

_display setVariable ["DB_UIEditor_Selection", []];
[_display, true] call DB_fnc_uiEditorOverlay;

private _newSelection = [];
{
    _x params ["_id", "_oldControl", "_class", "_name", "_isGroup", "_oldPosition", "_text"];
    ctrlDelete _oldControl;
    private _newPosition = +_oldPosition;
    _newPosition set [0, (_oldPosition # 0) + (_groupPosition # 0)];
    _newPosition set [1, (_oldPosition # 1) + (_groupPosition # 1)];
    private _newControl = [
        _display,
        _id,
        _class,
        _parentControl,
        _name,
        _isGroup,
        _newPosition,
        _text,
        true
    ] call DB_fnc_uiEditorCreateControl;
    private _nodeIndex = _nodes findIf {(_x # 0) == _id};
    _nodes set [_nodeIndex, [_id, _newControl, _groupParentId, _class, _name, _isGroup]];
    _newSelection pushBack _id;
} forEach _records;

ctrlDelete _groupControl;
_groupIndex = _nodes findIf {(_x # 0) == _groupId};
_nodes deleteAt _groupIndex;

_display setVariable ["DB_UIEditor_Nodes", _nodes];
_display setVariable ["DB_UIEditor_Selection", _newSelection];
[_display, true] call DB_fnc_uiEditorOverlay;
[_display] call DB_fnc_uiEditorRefresh;
[_display] call DB_fnc_uiEditorExport;
