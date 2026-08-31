disableSerialization;
params [
    "_display",
    "_id",
    "_class",
    "_parentControl",
    "_name",
    "_isGroup",
    "_position",
    ["_text", ""],
    ["_initialize", true]
];

private _control = _display ctrlCreate [_class, 5000 + _id, _parentControl];
if (isNull _control) exitWith {controlNull};

_control ctrlSetPixelPrecision "OFF";

if (_class == "RscMapControl") then {
    _control ctrlMapSetPosition _position;
} else {
    _control ctrlSetPosition _position;
    _control ctrlCommit 0;
};

_control setVariable ["DB_UIEditor_NodeId", _id];
_control ctrlAddEventHandler ["MouseButtonDown", {
    params ["_control", "_button", "", "", "", "_ctrlKey"];
    if (_button == 0) then {
        [ctrlParent _control, _control getVariable ["DB_UIEditor_NodeId", -1], _ctrlKey, "drag"] call DB_fnc_uiEditorPointerDown;
    };
    true
}];

if (_initialize) then {
    switch (_class) do {
        case "RscStructuredText": {
            _control ctrlSetStructuredText parseText (format ["<t color='#38BDF8'>%1</t><br/><t size='0.8'>Structured text</t>", _name]);
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
        default {
            _control ctrlSetText _name;
        };
    };

    if (_text != "") then {
        if (_class == "RscStructuredText") then {
            _control ctrlSetStructuredText parseText _text;
        } else {
            _control ctrlSetText _text;
        };
    };
} else {
    if (_class == "RscStructuredText") then {
        _control ctrlSetStructuredText parseText _text;
    } else {
        _control ctrlSetText _text;
    };
};

if (_isGroup) then {
    private _background = _display ctrlCreate ["RscText", -1, _control];
    _background ctrlSetPosition [0, 0, _position # 2, _position # 3];
    _background ctrlSetBackgroundColor [0.04, 0.055, 0.075, 0.92];
    _background ctrlEnable false;
    _background ctrlCommit 0;

    private _header = _display ctrlCreate ["RscText", -1, _control];
    _header ctrlSetPosition [0, 0, _position # 2, 4 * pixelH * pixelGrid];
    _header ctrlSetBackgroundColor [0.07, 0.14, 0.19, 1];
    _header ctrlSetText format ["  %1", _name];
    _header ctrlSetTextColor [0.65, 0.83, 0.92, 1];
    _header ctrlCommit 0;
    _header setVariable ["DB_UIEditor_NodeId", _id];
    _header ctrlAddEventHandler ["MouseButtonDown", {
        params ["_control", "_button", "", "", "", "_ctrlKey"];
        if (_button == 0) then {
            [ctrlParent _control, _control getVariable ["DB_UIEditor_NodeId", -1], _ctrlKey, "drag"] call DB_fnc_uiEditorPointerDown;
        };
        true
    }];
    _control setVariable ["DB_UIEditor_GroupBackground", _background];
    _control setVariable ["DB_UIEditor_GroupHeader", _header];
};

_control
