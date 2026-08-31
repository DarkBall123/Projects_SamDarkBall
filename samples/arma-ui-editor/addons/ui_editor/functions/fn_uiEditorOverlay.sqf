disableSerialization;
params ["_display", ["_rebuild", false]];

private _overlays = _display getVariable ["DB_UIEditor_Overlays", []];

if (_rebuild) then {
    {
        {
            ctrlDelete _x;
        } forEach (_x # 1);
    } forEach _overlays;
    _overlays = [];

    private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
    private _selection = _display getVariable ["DB_UIEditor_Selection", []];
    private _primary = if (_selection isEqualTo []) then {-1} else {_selection # ((count _selection) - 1)};

    {
        private _id = _x;
        private _nodeIndex = _nodes findIf {(_x # 0) == _id};

        if (_nodeIndex >= 0) then {
            private _node = _nodes # _nodeIndex;
            private _parentControl = [_display, _node # 2] call DB_fnc_uiEditorParent;
            private _parts = [];

            for "_part" from 0 to 3 do {
                private _line = _display ctrlCreate ["RscText", -1, _parentControl];
                _line ctrlSetBackgroundColor [0.22, 0.78, 1, 1];
                _line ctrlEnable false;
                _parts pushBack _line;
            };

            private _handle = controlNull;
            if (_id == _primary) then {
                _handle = _display ctrlCreate ["RscText", -1, _parentControl];
                _handle ctrlSetBackgroundColor [0.2, 0.85, 0.55, 1];
                _handle ctrlSetTooltip "Drag to resize";
                _handle setVariable ["DB_UIEditor_NodeId", _id];
                _handle ctrlAddEventHandler ["MouseButtonDown", {
                    params ["_control", "_button"];
                    if (_button == 0) then {
                        [ctrlParent _control, _control getVariable ["DB_UIEditor_NodeId", -1], false, "resize"] call DB_fnc_uiEditorPointerDown;
                    };
                    true
                }];
                _parts pushBack _handle;
            };

            _overlays pushBack [_id, _parts];
        };
    } forEach _selection;

    _display setVariable ["DB_UIEditor_Overlays", _overlays];
};

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _lineW = 2 * pixelW;
private _lineH = 2 * pixelH;
private _handleW = 8 * pixelW * pixelGrid;
private _handleH = 8 * pixelH * pixelGrid;

{
    _x params ["_id", "_parts"];
    private _nodeIndex = _nodes findIf {(_x # 0) == _id};

    if (_nodeIndex >= 0) then {
        private _node = _nodes # _nodeIndex;
        private _control = _node # 1;
        private _position = if ((_node # 3) == "RscMapControl") then {
            ctrlMapPosition _control
        } else {
            ctrlPosition _control
        };
        _position params ["_xPos", "_yPos", "_width", "_height"];

        (_parts # 0) ctrlSetPosition [_xPos, _yPos, _width, _lineH];
        (_parts # 1) ctrlSetPosition [_xPos + _width - _lineW, _yPos, _lineW, _height];
        (_parts # 2) ctrlSetPosition [_xPos, _yPos + _height - _lineH, _width, _lineH];
        (_parts # 3) ctrlSetPosition [_xPos, _yPos, _lineW, _height];

        {
            _x ctrlCommit 0;
        } forEach _parts;

        if ((count _parts) > 4) then {
            private _handle = _parts # 4;
            _handle ctrlSetPosition [
                _xPos + _width - _handleW,
                _yPos + _height - _handleH,
                _handleW,
                _handleH
            ];
            _handle ctrlCommit 0;
        };
    };
} forEach _overlays;
