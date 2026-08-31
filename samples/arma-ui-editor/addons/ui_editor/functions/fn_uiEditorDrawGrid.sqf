disableSerialization;
params ["_display"];

private _canvas = _display getVariable ["DB_UIEditor_CanvasControl", controlNull];
private _canvasPosition = ctrlPosition _canvas;
private _width = _canvasPosition # 2;
private _height = _canvasPosition # 3;
private _stepX = 8 * pixelW * pixelGrid;
private _stepY = 8 * pixelH * pixelGrid;
private _lineW = pixelW;
private _lineH = pixelH;
private _lines = [];

private _background = _display ctrlCreate ["RscText", -1, _canvas];
_background ctrlSetPosition [0, 0, _width, _height];
_background ctrlSetBackgroundColor [0.035, 0.045, 0.06, 1];
_background ctrlCommit 0;
_background ctrlAddEventHandler ["MouseButtonDown", {
    params ["_control", "_button"];
    if (_button == 0) then {
        private _display = ctrlParent _control;
        _display setVariable ["DB_UIEditor_Selection", []];
        [_display, true] call DB_fnc_uiEditorOverlay;
        [_display] call DB_fnc_uiEditorRefresh;
    };
    true
}];
_lines pushBack _background;

for "_x" from _stepX to _width step _stepX do {
    private _line = _display ctrlCreate ["RscText", -1, _canvas];
    _line ctrlSetPosition [_x, 0, _lineW, _height];
    _line ctrlSetBackgroundColor [0.18, 0.24, 0.3, 0.22];
    _line ctrlEnable false;
    _line ctrlCommit 0;
    _lines pushBack _line;
};

for "_y" from _stepY to _height step _stepY do {
    private _line = _display ctrlCreate ["RscText", -1, _canvas];
    _line ctrlSetPosition [0, _y, _width, _lineH];
    _line ctrlSetBackgroundColor [0.18, 0.24, 0.3, 0.22];
    _line ctrlEnable false;
    _line ctrlCommit 0;
    _lines pushBack _line;
};

_display setVariable ["DB_UIEditor_GridLines", _lines];
