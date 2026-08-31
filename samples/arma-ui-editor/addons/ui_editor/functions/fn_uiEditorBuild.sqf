disableSerialization;
params ["_display"];

private _unitX = pixelW * pixelGrid;
private _unitY = pixelH * pixelGrid;
private _screenX = safeZoneX + 2 * _unitX;
private _screenY = safeZoneY + 2 * _unitY;
private _screenW = safeZoneW - 4 * _unitX;
private _screenH = safeZoneH - 4 * _unitY;
private _gapX = 4 * _unitX;
private _gapY = 4 * _unitY;
private _headerH = 0.058 * _screenH;
private _contentY = _screenY + _headerH + _gapY;
private _contentH = _screenH - _headerH - _gapY;
private _leftW = 0.19 * _screenW;
private _rightW = 0.25 * _screenW;
private _canvasX = _screenX + _leftW + _gapX;
private _canvasW = _screenW - _leftW - _rightW - 2 * _gapX;
private _rightX = _canvasX + _canvasW + _gapX;
private _buttonH = 0.043 * _screenH;
private _titleH = 0.043 * _screenH;

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
_background ctrlSetBackgroundColor [0.015, 0.02, 0.03, 0.985];
_background ctrlEnable false;

private _header = ["RscText", [_screenX, _screenY, _screenW, _headerH]] call _makeControl;
_header ctrlSetBackgroundColor [0.055, 0.07, 0.09, 1];
_header ctrlEnable false;

private _title = ["RscText", [_screenX + _gapX, _screenY, 0.22 * _screenW, _headerH], "DB UI EDITOR"] call _makeControl;
_title ctrlSetTextColor [0.23, 0.78, 1, 1];

private _toolbarX = _screenX + 0.24 * _screenW;
private _toolbarY = _screenY + 0.12 * _headerH;
private _toolbarH = 0.76 * _headerH;
private _toolbarGap = 0.007 * _screenW;

private _grid = ["RscCombo", [_toolbarX, _toolbarY, 0.16 * _screenW, _toolbarH]] call _makeControl;
{
    _grid lbAdd _x;
} forEach ["Coords: SafeZone", "Coords: Pixel + SafeZone", "Coords: PixelGrid", "Coords: GUI_GRID", "Coords: Absolute"];
_grid lbSetCurSel 1;
_toolbarX = _toolbarX + 0.16 * _screenW + _toolbarGap;

private _snap = ["RscCombo", [_toolbarX, _toolbarY, 0.1 * _screenW, _toolbarH]] call _makeControl;
{
    _x params ["_label", "_value"];
    private _index = _snap lbAdd _label;
    _snap lbSetData [_index, str _value];
} forEach [["Snap: off", 0], ["Snap: 4", 4], ["Snap: 8", 8], ["Snap: 16", 16]];
_snap lbSetCurSel 2;
_toolbarX = _toolbarX + 0.1 * _screenW + _toolbarGap;

private _group = ["RscButton", [_toolbarX, _toolbarY, 0.085 * _screenW, _toolbarH], "Group"] call _makeControl;
_group ctrlSetTooltip "Ctrl-click controls, then group them";
_group ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button, "group"] call DB_fnc_uiEditorGroup;
}];
_toolbarX = _toolbarX + 0.085 * _screenW + _toolbarGap;

private _ungroup = ["RscButton", [_toolbarX, _toolbarY, 0.085 * _screenW, _toolbarH], "Ungroup"] call _makeControl;
_ungroup ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button, "ungroup"] call DB_fnc_uiEditorGroup;
}];
_toolbarX = _toolbarX + 0.085 * _screenW + _toolbarGap;

private _delete = ["RscButton", [_toolbarX, _toolbarY, 0.075 * _screenW, _toolbarH], "Delete"] call _makeControl;
_delete ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    private _display = ctrlParent _button;
    private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
    private _selection = _display getVariable ["DB_UIEditor_Selection", []];
    private _removeIds = +_selection;
    private _foundChildren = true;

    while {_foundChildren} do {
        _foundChildren = false;
        {
            if ((_x # 2) in _removeIds && {!((_x # 0) in _removeIds)}) then {
                _removeIds pushBack (_x # 0);
                _foundChildren = true;
            };
        } forEach _nodes;
    };

    _display setVariable ["DB_UIEditor_Selection", []];
    [_display, true] call DB_fnc_uiEditorOverlay;

    {
        private _id = _x;
        private _nodeIndex = _nodes findIf {(_x # 0) == _id};
        if (_nodeIndex >= 0) then {
            ctrlDelete ((_nodes # _nodeIndex) # 1);
        };
    } forEach _selection;

    _display setVariable ["DB_UIEditor_Nodes", _nodes select {!((_x # 0) in _removeIds)}];
    [_display] call DB_fnc_uiEditorRefresh;
    [_display] call DB_fnc_uiEditorExport;
}];

private _close = ["RscButton", [_screenX + _screenW - 0.07 * _screenW - _gapX, _toolbarY, 0.07 * _screenW, _toolbarH], "Close"] call _makeControl;
_close ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    (ctrlParent _button) closeDisplay 2;
}];

private _leftPanel = ["RscText", [_screenX, _contentY, _leftW, _contentH]] call _makeControl;
_leftPanel ctrlSetBackgroundColor [0.04, 0.05, 0.065, 1];
_leftPanel ctrlEnable false;

private _paletteTitle = ["RscText", [_screenX + _gapX, _contentY + _gapY, _leftW - 2 * _gapX, _titleH], "CONTROLS"] call _makeControl;
_paletteTitle ctrlSetTextColor [0.72, 0.8, 0.86, 1];
_paletteTitle ctrlEnable false;

private _palette = [
    "RscListbox",
    [
        _screenX + _gapX,
        _contentY + _titleH + 2 * _gapY,
        _leftW - 2 * _gapX,
        _contentH - _titleH - 3 * _buttonH - 6 * _gapY
    ]
] call _makeControl;

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
        private _index = _palette lbAdd format ["%1   %2", _name, _class];
        _palette lbSetData [_index, str _x];
    };
} forEach _types;
_palette lbSetCurSel 0;
_palette ctrlAddEventHandler ["LBDblClick", {
    params ["_list"];
    [ctrlParent _list, false] call DB_fnc_uiEditorAdd;
}];

private _addRoot = [
    "RscButton",
    [_screenX + _gapX, _contentY + _contentH - 2 * _buttonH - 2 * _gapY, _leftW - 2 * _gapX, _buttonH],
    "Add to canvas"
] call _makeControl;
_addRoot ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button, false] call DB_fnc_uiEditorAdd;
}];

private _addGroup = [
    "RscButton",
    [_screenX + _gapX, _contentY + _contentH - _buttonH - _gapY, _leftW - 2 * _gapX, _buttonH],
    "Add inside selected group"
] call _makeControl;
_addGroup ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button, true] call DB_fnc_uiEditorAdd;
}];

private _hint = [
    "RscText",
    [_screenX + _gapX, _contentY + _contentH - 3 * _buttonH - 3 * _gapY, _leftW - 2 * _gapX, _buttonH],
    "Drag | resize corner | Ctrl multi-select"
] call _makeControl;
_hint ctrlSetTextColor [0.52, 0.62, 0.7, 1];
_hint ctrlEnable false;

private _canvas = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_canvas ctrlSetPosition [_canvasX, _contentY, _canvasW, _contentH];
_canvas ctrlCommit 0;

private _rightPanel = ["RscText", [_rightX, _contentY, _rightW, _contentH]] call _makeControl;
_rightPanel ctrlSetBackgroundColor [0.04, 0.05, 0.065, 1];
_rightPanel ctrlEnable false;

private _treeTitle = ["RscText", [_rightX + _gapX, _contentY + _gapY, _rightW - 2 * _gapX, _titleH], "HIERARCHY"] call _makeControl;
_treeTitle ctrlSetTextColor [0.72, 0.8, 0.86, 1];
_treeTitle ctrlEnable false;

private _treeH = 0.18 * _contentH;
private _tree = ["RscListbox", [_rightX + _gapX, _contentY + _titleH + 2 * _gapY, _rightW - 2 * _gapX, _treeH]] call _makeControl;
_tree ctrlAddEventHandler ["LBSelChanged", {
    params ["_list", "_index"];
    private _display = ctrlParent _list;
    if (_index >= 0 && {!(_display getVariable ["DB_UIEditor_Refreshing", false])}) then {
        [_display, parseNumber (_list lbData _index), false] call DB_fnc_uiEditorSelect;
    };
}];

private _inspectorY = _contentY + _titleH + _treeH + 3 * _gapY;
private _typeLabel = ["RscText", [_rightX + _gapX, _inspectorY, _rightW - 2 * _gapX, _titleH], "Nothing selected"] call _makeControl;
_typeLabel ctrlSetTextColor [0.23, 0.78, 1, 1];
_typeLabel ctrlEnable false;

private _labelW = 0.15 * _rightW;
private _fieldX = _rightX + _gapX + _labelW;
private _fieldW = _rightW - 3 * _gapX - _labelW;
private _rowH = 0.038 * _screenH;
private _fields = [];

{
    _x params ["_name", "_default"];
    private _rowY = _inspectorY + _titleH + _gapY + _forEachIndex * (_rowH + _gapY);
    private _label = ["RscText", [_rightX + _gapX, _rowY, _labelW, _rowH], _name] call _makeControl;
    _label ctrlSetTextColor [0.6, 0.68, 0.74, 1];
    _label ctrlEnable false;
    private _edit = ["RscEdit", [_fieldX, _rowY, _fieldW, _rowH], _default] call _makeControl;
    _fields pushBack _edit;
} forEach [["Text", ""], ["x", "0"], ["y", "0"], ["w", "0"], ["h", "0"]];

private _applyY = _inspectorY + _titleH + _gapY + 5 * (_rowH + _gapY);
private _apply = ["RscButton", [_rightX + _gapX, _applyY, _rightW - 2 * _gapX, _buttonH], "Apply exact values"] call _makeControl;
_apply ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    [ctrlParent _button] call DB_fnc_uiEditorApply;
}];

private _exportTitleY = _applyY + _buttonH + _gapY;
private _exportTitle = ["RscText", [_rightX + _gapX, _exportTitleY, _rightW - 2 * _gapX, _titleH], "CONFIG OUTPUT"] call _makeControl;
_exportTitle ctrlSetTextColor [0.72, 0.8, 0.86, 1];
_exportTitle ctrlEnable false;

private _selectExportY = _contentY + _contentH - _buttonH - _gapY;
private _exportY = _exportTitleY + _titleH + _gapY;
private _exportH = _selectExportY - _exportY - _gapY;
private _export = ["RscEditMulti", [_rightX + _gapX, _exportY, _rightW - 2 * _gapX, _exportH], ""] call _makeControl;
_export ctrlSetFont "EtelkaMonospacePro";
_export ctrlSetFontHeight (2.5 * _unitY);

private _selectExport = ["RscButton", [_rightX + _gapX, _selectExportY, _rightW - 2 * _gapX, _buttonH], "Select output for Ctrl+C"] call _makeControl;
_selectExport ctrlAddEventHandler ["ButtonClick", {
    params ["_button"];
    private _display = ctrlParent _button;
    private _export = _display getVariable ["DB_UIEditor_Export", controlNull];
    _export ctrlSetTextSelection [0, count (ctrlText _export)];
    ctrlSetFocus _export;
}];

_display setVariable ["DB_UIEditor_Palette", _palette];
_display setVariable ["DB_UIEditor_Grid", _grid];
_display setVariable ["DB_UIEditor_SnapControl", _snap];
_display setVariable ["DB_UIEditor_Tree", _tree];
_display setVariable ["DB_UIEditor_TypeLabel", _typeLabel];
_display setVariable ["DB_UIEditor_Fields", _fields];
_display setVariable ["DB_UIEditor_Export", _export];
_display setVariable ["DB_UIEditor_CanvasControl", _canvas];
_display setVariable ["DB_UIEditor_Nodes", []];
_display setVariable ["DB_UIEditor_Selection", []];
_display setVariable ["DB_UIEditor_Overlays", []];
_display setVariable ["DB_UIEditor_Interaction", []];
_display setVariable ["DB_UIEditor_NextId", 1];
_display setVariable ["DB_UIEditor_Snap", 8];
_display setVariable ["DB_UIEditor_Refreshing", false];

[_display] call DB_fnc_uiEditorDrawGrid;

_grid ctrlAddEventHandler ["LBSelChanged", {
    params ["_combo"];
    private _display = ctrlParent _combo;
    private _selection = _display getVariable ["DB_UIEditor_Selection", []];
    if (_selection isNotEqualTo []) then {
        [_display, _selection # ((count _selection) - 1), false, true] call DB_fnc_uiEditorSelect;
    };
    [_display] call DB_fnc_uiEditorExport;
}];

_snap ctrlAddEventHandler ["LBSelChanged", {
    params ["_combo", "_index"];
    (ctrlParent _combo) setVariable ["DB_UIEditor_Snap", parseNumber (_combo lbData _index)];
}];

_display displayAddEventHandler ["MouseMoving", {
    params ["_display"];
    [_display] call DB_fnc_uiEditorPointerMove;
}];

_display displayAddEventHandler ["MouseButtonUp", {
    params ["_display", "_button"];
    if (_button == 0) then {
        [_display] call DB_fnc_uiEditorPointerUp;
    };
}];

[_display] call DB_fnc_uiEditorExport;
