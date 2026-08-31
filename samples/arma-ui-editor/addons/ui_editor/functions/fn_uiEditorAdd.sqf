disableSerialization;
params ["_display", "_insideSelectedGroup"];

private _palette = _display getVariable ["DB_UIEditor_Palette", controlNull];
private _paletteIndex = lbCurSel _palette;
if (_paletteIndex < 0) exitWith {};

private _definition = parseSimpleArray (_palette lbData _paletteIndex);
_definition params ["_name", "_class", "_isGroup"];

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _parentId = -1;
private _parentControl = controlNull;

if (_insideSelectedGroup) then {
    private _selected = _display getVariable ["DB_UIEditor_Selected", -1];
    private _parentIndex = _nodes findIf {(_x # 0) == _selected};

    if (_parentIndex < 0 || {!((_nodes # _parentIndex) # 5)}) exitWith {
        systemChat "DB UI Editor: select a ControlsGroup first.";
    };

    _parentId = (_nodes # _parentIndex) # 0;
    _parentControl = (_nodes # _parentIndex) # 1;
};

private _id = _display getVariable ["DB_UIEditor_NextId", 1];
private _control = if (isNull _parentControl) then {
    _display ctrlCreate [_class, 5000 + _id]
} else {
    _display ctrlCreate [_class, 5000 + _id, _parentControl]
};

if (isNull _control) exitWith {
    systemChat format ["DB UI Editor: %1 could not be created.", _class];
};

_control ctrlAddEventHandler ["MouseButtonDown", {
    params ["_control"];
    [ctrlParent _control, ctrlIDC _control - 5000] call DB_fnc_uiEditorSelect;
}];

private _canvas = _display getVariable ["DB_UIEditor_Canvas", []];
_canvas params ["_canvasX", "_canvasY", "_canvasW", "_canvasH", "_headerH", "_gapX", "_gapY"];

private _position = if (_parentId < 0) then {
    private _offset = ((_id - 1) mod 7) * 0.012 * safeZoneH;
    [
        _canvasX + 2 * _gapX + _offset,
        _canvasY + _headerH + 3 * _gapY + _offset,
        0.22 * _canvasW,
        0.06 * _canvasH
    ]
} else {
    [
        2 * _gapX,
        2 * _gapY + ((_id - 1) mod 6) * 0.045 * safeZoneH,
        0.16 * safeZoneW,
        0.04 * safeZoneH
    ]
};

if (_isGroup) then {
    _position set [2, if (_parentId < 0) then {0.42 * _canvasW} else {0.2 * safeZoneW}];
    _position set [3, 0.28 * _canvasH];
};

if (_class == "RscMapControl") then {
    _control ctrlMapSetPosition _position;
} else {
    _control ctrlSetPosition _position;
    _control ctrlCommit 0;
};

switch (_class) do {
    case "RscStructuredText": {
        _control ctrlSetStructuredText parseText (format ["<t color='#59D9FF'>%1</t><br/><t size='0.8'>Structured text</t>", _name]);
    };
    case "RscPicture";
    case "RscPictureKeepAspect";
    case "RscActivePicture": {
        _control ctrlSetText "\a3\ui_f\data\logos\arma3_white_ca.paa";
    };
    case "RscCombo";
    case "RscXListBox": {
        {
            _control lbAdd _x;
        } forEach ["Alpha", "Bravo", "Charlie"];
        _control lbSetCurSel 0;
    };
    case "RscListbox": {
        {
            _control lbAdd _x;
        } forEach ["First item", "Second item", "Third item"];
        _control lbSetCurSel 0;
    };
    case "RscListNBox": {
        _control lnbAddRow ["Column A", "Column B"];
        _control lnbAddRow ["Value 1", "Value 2"];
    };
    case "RscTree";
    case "RscTreeMulti": {
        private _root = _control tvAdd [[], "Root"];
        _control tvAdd [[_root], "Child"];
        _control tvExpand [_root];
    };
    case "RscSlider";
    case "RscXSliderH": {
        _control sliderSetRange [0, 100];
        _control sliderSetPosition 55;
    };
    case "RscProgress": {
        _control progressSetPosition 0.65;
    };
    case "RscCheckbox": {
        _control cbSetChecked true;
    };
    case "RscMapControl": {
        private _mapCenter = if (isNull player) then {
            [worldSize / 2, worldSize / 2, 0]
        } else {
            getPosWorld player
        };
        _control ctrlMapAnimAdd [0, 0.08, _mapCenter];
        ctrlMapAnimCommit _control;
    };
    case "RscControlsGroup";
    case "RscControlsGroupNoScrollbars": {
        private _groupBackground = _display ctrlCreate ["RscText", -1, _control];
        _groupBackground ctrlSetPosition [0, 0, _position # 2, _position # 3];
        _groupBackground ctrlSetBackgroundColor [0.05, 0.18, 0.22, 0.7];
        _groupBackground ctrlSetText format ["%1  |  add children with the left button", _name];
        _groupBackground ctrlEnable false;
        _groupBackground ctrlCommit 0;
    };
    default {
        _control ctrlSetText _name;
    };
};

_nodes pushBack [_id, _control, _parentId, _class, _name, _isGroup];
_display setVariable ["DB_UIEditor_Nodes", _nodes];
_display setVariable ["DB_UIEditor_NextId", _id + 1];
_display setVariable ["DB_UIEditor_Selected", _id];

[_display] call DB_fnc_uiEditorRefresh;
[_display, _id] call DB_fnc_uiEditorSelect;
[_display] call DB_fnc_uiEditorExport;
