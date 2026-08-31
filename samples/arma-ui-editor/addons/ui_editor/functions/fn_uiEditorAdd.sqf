disableSerialization;
params ["_display", "_insideSelectedGroup"];

private _palette = _display getVariable ["DB_UIEditor_Palette", controlNull];
private _paletteIndex = lbCurSel _palette;
if (_paletteIndex < 0) exitWith {};

private _definition = parseSimpleArray (_palette lbData _paletteIndex);
_definition params ["_name", "_class", "_isGroup"];

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _selection = _display getVariable ["DB_UIEditor_Selection", []];
private _parentId = -1;

if (_insideSelectedGroup) then {
    if (_selection isEqualTo []) exitWith {
        systemChat "DB UI Editor: select a ControlsGroup first.";
    };

    private _selected = _selection # ((count _selection) - 1);
    private _parentIndex = _nodes findIf {(_x # 0) == _selected};

    if (_parentIndex < 0 || {!((_nodes # _parentIndex) # 5)}) exitWith {
        systemChat "DB UI Editor: select a ControlsGroup first.";
    };

    _parentId = (_nodes # _parentIndex) # 0;
};

private _parentControl = [_display, _parentId] call DB_fnc_uiEditorParent;
private _parentPosition = ctrlPosition _parentControl;
private _parentW = _parentPosition # 2;
private _parentH = _parentPosition # 3;
private _id = _display getVariable ["DB_UIEditor_NextId", 1];
private _offsetX = ((_id - 1) mod 7) * 2 * pixelW * pixelGrid;
private _offsetY = ((_id - 1) mod 7) * 2 * pixelH * pixelGrid;
private _position = [
    3 * pixelW * pixelGrid + _offsetX,
    5 * pixelH * pixelGrid + _offsetY,
    0.28 * _parentW,
    0.08 * _parentH
];

if (_isGroup) then {
    _position set [2, 0.52 * _parentW];
    _position set [3, 0.38 * _parentH];
};

private _control = [_display, _id, _class, _parentControl, _name, _isGroup, _position] call DB_fnc_uiEditorCreateControl;
if (isNull _control) exitWith {
    systemChat format ["DB UI Editor: %1 could not be created.", _class];
};

_nodes pushBack [_id, _control, _parentId, _class, _name, _isGroup];
_display setVariable ["DB_UIEditor_Nodes", _nodes];
_display setVariable ["DB_UIEditor_NextId", _id + 1];

[_display, _id, false] call DB_fnc_uiEditorSelect;
[_display] call DB_fnc_uiEditorRefresh;
[_display] call DB_fnc_uiEditorExport;
