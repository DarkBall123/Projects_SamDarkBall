disableSerialization;
params ["_display"];

private _gapX = 6 * pixelW * pixelGrid;
private _gapY = 6 * pixelH * pixelGrid;
private _screenX = safeZoneX + _gapX;
private _screenY = safeZoneY + _gapY;
private _screenW = safeZoneW - 2 * _gapX;
private _screenH = safeZoneH - 2 * _gapY;
private _headerH = 5 * pixelH * pixelGrid;
private _contentY = _screenY + _headerH + _gapY;
private _contentH = _screenH - _headerH - _gapY;
private _leftW = 0.19 * _screenW;
private _rightW = 0.25 * _screenW;
private _canvasX = _screenX + _leftW + _gapX;
private _canvasW = _screenW - _leftW - _rightW - 2 * _gapX;
private _rightX = _canvasX + _canvasW + _gapX;

private _makeControl = {
    params ["_class", "_position", ["_text", ""]];

    private _control = _display ctrlCreate [_class, -1];
    _control ctrlSetPosition _position;
    _control ctrlCommit 0;

    if (_text != "") then {
        _control ctrlSetText _text;
    };

    _control
};

private _background = ["RscText", [_screenX, _screenY, _screenW, _screenH]] call _makeControl;
_background ctrlSetBackgroundColor [0.025, 0.03, 0.035, 0.97];
_background ctrlEnable false;

private _title = ["RscText", [_screenX + _gapX, _screenY, 0.32 * _screenW, _headerH], "DB UI EDITOR"] call _makeControl;
_title ctrlSetTextColor [0.35, 0.85, 1, 1];

private _gridLabel = ["RscText", [_screenX + 0.34 * _screenW, _screenY, 0.08 * _screenW, _headerH], "Grid"] call _makeControl;
_gridLabel ctrlEnable false;

private _grid = ["RscCombo", [_screenX + 0.42 * _screenW, _screenY + 0.4 * _gapY, 0.25 * _screenW, _headerH - 0.8 * _gapY]] call _makeControl;
{
    _grid lbAdd _x;
} forEach ["SafeZone", "PixelGrid + SafeZone", "PixelGrid", "GUI_GRID", "Absolute"];
_grid lbSetCurSel 1;

private _close = ["RscButton", [_screenX + _screenW - 0.08 * _screenW, _screenY + 0.4 * _gapY, 0.07 * _screenW, _headerH - 0.8 * _gapY], "Close"] call _makeControl;
_close ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    (ctrlParent _button) closeDisplay 2;
}];

private _leftPanel = ["RscText", [_screenX, _contentY, _leftW, _contentH]] call _makeControl;
_leftPanel ctrlSetBackgroundColor [0.06, 0.07, 0.08, 0.98];
_leftPanel ctrlEnable false;

private _paletteTitle = ["RscText", [_screenX + _gapX, _contentY + _gapY, _leftW - 2 * _gapX, _headerH], "CONTROL PALETTE"] call _makeControl;
_paletteTitle ctrlEnable false;

private _buttonH = 5 * pixelH * pixelGrid;
private _palette = ["RscListbox", [_screenX + _gapX, _contentY + _headerH + 2 * _gapY, _leftW - 2 * _gapX, _contentH - 3 * _headerH - 5 * _gapY]] call _makeControl;
private _types = [
    ["Text", "RscText", false],
    ["Structured Text", "RscStructuredText", false],
    ["Multiline Text", "RscTextMulti", false],
    ["Picture", "RscPicture", false],
    ["Picture Keep Aspect", "RscPictureKeepAspect", false],
    ["Edit", "RscEdit", false],
    ["Multiline Edit", "RscEditMulti", false],
    ["Read-only Edit", "RscEditReadOnly", false],
    ["Button", "RscButton", false],
    ["Button Menu", "RscButtonMenu", false],
    ["Active Text", "RscActiveText", false],
    ["Active Picture", "RscActivePicture", false],
    ["Checkbox", "RscCheckbox", false],
    ["Combo", "RscCombo", false],
    ["List Box", "RscListbox", false],
    ["List NBox", "RscListNBox", false],
    ["X List Box", "RscXListBox", false],
    ["Tree", "RscTree", false],
    ["Tree Multi", "RscTreeMulti", false],
    ["Slider", "RscSlider", false],
    ["X Slider", "RscXSliderH", false],
    ["Progress", "RscProgress", false],
    ["Toolbox", "RscToolbox", false],
    ["Map", "RscMapControl", false],
    ["HTML", "RscHTML", false],
    ["Controls Group", "RscControlsGroup", true],
    ["Group, no scrollbars", "RscControlsGroupNoScrollbars", true]
];

{
    _x params ["_name", "_class"];
    if (isClass (configFile >> _class)) then {
        private _index = _palette lbAdd format ["%1  [%2]", _name, _class];
        _palette lbSetData [_index, str _x];
    };
} forEach _types;
_palette lbSetCurSel 0;

private _addRoot = ["RscButton", [_screenX + _gapX, _contentY + _contentH - 2 * _buttonH - 2 * _gapY, _leftW - 2 * _gapX, _buttonH], "Add to root"] call _makeControl;
_addRoot ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button, false] call DB_fnc_uiEditorAdd;
}];

private _addGroup = ["RscButton", [_screenX + _gapX, _contentY + _contentH - _buttonH - _gapY, _leftW - 2 * _gapX, _buttonH], "Add inside selected group"] call _makeControl;
_addGroup ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button, true] call DB_fnc_uiEditorAdd;
}];

private _canvas = ["RscText", [_canvasX, _contentY, _canvasW, _contentH], ""] call _makeControl;
_canvas ctrlSetBackgroundColor [0.12, 0.13, 0.14, 1];
_canvas ctrlEnable false;

private _canvasHint = ["RscText", [_canvasX + _gapX, _contentY + _gapY, _canvasW - 2 * _gapX, _headerH], "WORK AREA  |  add controls from the palette"] call _makeControl;
_canvasHint ctrlSetTextColor [0.65, 0.68, 0.7, 1];
_canvasHint ctrlEnable false;

private _rightPanel = ["RscText", [_rightX, _contentY, _rightW, _contentH]] call _makeControl;
_rightPanel ctrlSetBackgroundColor [0.06, 0.07, 0.08, 0.98];
_rightPanel ctrlEnable false;

private _treeTitle = ["RscText", [_rightX + _gapX, _contentY + _gapY, _rightW - 2 * _gapX, _headerH], "CONTROLS"] call _makeControl;
_treeTitle ctrlEnable false;

private _treeH = 0.24 * _contentH;
private _tree = ["RscListbox", [_rightX + _gapX, _contentY + _headerH + 2 * _gapY, _rightW - 2 * _gapX, _treeH]] call _makeControl;
_tree ctrlAddEventHandler ["LBSelChanged", {
    params ["_list", "_index"];
    if (_index >= 0) then {
        [ctrlParent _list, parseNumber (_list lbData _index)] call DB_fnc_uiEditorSelect;
    };
}];

private _propertyY = _contentY + _headerH + _treeH + 3 * _gapY;
private _labelW = 0.16 * _rightW;
private _fieldX = _rightX + _gapX + _labelW;
private _fieldW = _rightW - 3 * _gapX - _labelW;
private _rowH = 4 * pixelH * pixelGrid;

private _typeLabel = ["RscText", [_rightX + _gapX, _propertyY, _rightW - 2 * _gapX, _rowH], "Nothing selected"] call _makeControl;
_typeLabel ctrlSetTextColor [0.35, 0.85, 1, 1];
_typeLabel ctrlEnable false;

private _fields = [];
{
    _x params ["_name", "_default"];
    private _rowY = _propertyY + (_forEachIndex + 1) * (_rowH + 0.5 * _gapY);
    private _label = ["RscText", [_rightX + _gapX, _rowY, _labelW, _rowH], _name] call _makeControl;
    _label ctrlEnable false;
    private _edit = ["RscEdit", [_fieldX, _rowY, _fieldW, _rowH], _default] call _makeControl;
    _fields pushBack _edit;
} forEach [["Text", ""], ["x", "0"], ["y", "0"], ["w", "0"], ["h", "0"]];

private _actionsY = _propertyY + 6 * (_rowH + 0.5 * _gapY);
private _apply = ["RscButton", [_rightX + _gapX, _actionsY, 0.5 * (_rightW - 3 * _gapX), _buttonH], "Apply"] call _makeControl;
_apply ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button] call DB_fnc_uiEditorApply;
}];

private _delete = ["RscButton", [_rightX + 2 * _gapX + 0.5 * (_rightW - 3 * _gapX), _actionsY, 0.5 * (_rightW - 3 * _gapX), _buttonH], "Delete"] call _makeControl;
_delete ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];

    private _display = ctrlParent _button;
    private _selected = _display getVariable ["DB_UIEditor_Selected", -1];
    private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
    private _nodeIndex = _nodes findIf {(_x # 0) == _selected};

    if (_nodeIndex >= 0) then {
        ctrlDelete ((_nodes # _nodeIndex) # 1);
        _display setVariable ["DB_UIEditor_Nodes", _nodes select {!isNull (_x # 1)}];
        _display setVariable ["DB_UIEditor_Selected", -1];
        [_display] call DB_fnc_uiEditorRefresh;
        [_display] call DB_fnc_uiEditorExport;
    };
}];

private _exportY = _actionsY + _buttonH + _gapY;
private _exportH = _contentY + _contentH - _exportY - _buttonH - 2 * _gapY;
private _export = ["RscEditMulti", [_rightX + _gapX, _exportY, _rightW - 2 * _gapX, _exportH], ""] call _makeControl;
_export ctrlSetFont "EtelkaMonospacePro";
_export ctrlSetFontHeight (2.4 * pixelH * pixelGrid);

private _selectExport = ["RscButton", [_rightX + _gapX, _contentY + _contentH - _buttonH - _gapY, _rightW - 2 * _gapX, _buttonH], "Select export text"] call _makeControl;
_selectExport ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    private _display = ctrlParent _button;
    private _export = _display getVariable ["DB_UIEditor_Export", controlNull];
    _export ctrlSetTextSelection [0, count (ctrlText _export)];
    ctrlSetFocus _export;
}];

_display setVariable ["DB_UIEditor_Palette", _palette];
_display setVariable ["DB_UIEditor_Grid", _grid];
_display setVariable ["DB_UIEditor_Tree", _tree];
_display setVariable ["DB_UIEditor_TypeLabel", _typeLabel];
_display setVariable ["DB_UIEditor_Fields", _fields];
_display setVariable ["DB_UIEditor_Export", _export];
_display setVariable ["DB_UIEditor_Canvas", [_canvasX, _contentY, _canvasW, _contentH, _headerH, _gapX, _gapY]];
_display setVariable ["DB_UIEditor_Nodes", []];
_display setVariable ["DB_UIEditor_Selected", -1];
_display setVariable ["DB_UIEditor_NextId", 1];

_grid ctrlAddEventHandler ["LBSelChanged", {
    params ["_combo"];
    private _display = ctrlParent _combo;
    private _selected = _display getVariable ["DB_UIEditor_Selected", -1];
    if (_selected >= 0) then {
        [_display, _selected] call DB_fnc_uiEditorSelect;
    };
    [_display] call DB_fnc_uiEditorExport;
}];

[_display] call DB_fnc_uiEditorExport;
