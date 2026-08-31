disableSerialization;
params ["_display"];

private _interaction = _display getVariable ["DB_UIEditor_Interaction", []];
if (_interaction isEqualTo []) exitWith {};

_interaction params ["_mode", "_startMouse", "_items"];
private _mouse = getMousePosition;
private _deltaX = (_mouse # 0) - (_startMouse # 0);
private _deltaY = (_mouse # 1) - (_startMouse # 1);
private _snap = _display getVariable ["DB_UIEditor_Snap", 8];
private _stepX = _snap * pixelW * pixelGrid;
private _stepY = _snap * pixelH * pixelGrid;
private _minW = 8 * pixelW * pixelGrid;
private _minH = 8 * pixelH * pixelGrid;

{
    _x params ["", "_control", "_startPosition", "_bounds", "_class", "_isGroup"];
    _startPosition params ["_startX", "_startY", "_startW", "_startH"];
    _bounds params ["_boundW", "_boundH", "_minY"];
    private _position = +_startPosition;

    if (_mode == "drag") then {
        private _maxX = (_boundW - _startW) max 0;
        private _maxY = (_boundH - _startH) max _minY;
        private _xPos = ((_startX + _deltaX) max 0) min _maxX;
        private _yPos = ((_startY + _deltaY) max _minY) min _maxY;

        if (_snap > 0) then {
            _xPos = round (_xPos / _stepX) * _stepX;
            _yPos = round (_yPos / _stepY) * _stepY;
            _xPos = _xPos min _maxX;
            _yPos = _yPos min _maxY;
        };

        _position set [0, _xPos];
        _position set [1, _yPos];
    } else {
        private _maxW = (_boundW - _startX) max _minW;
        private _maxH = (_boundH - _startY) max _minH;
        private _width = ((_startW + _deltaX) max _minW) min _maxW;
        private _height = ((_startH + _deltaY) max _minH) min _maxH;

        if (_snap > 0) then {
            _width = round (_width / _stepX) * _stepX;
            _height = round (_height / _stepY) * _stepY;
            _width = _width min _maxW;
            _height = _height min _maxH;
        };

        _position set [2, _width max _minW];
        _position set [3, _height max _minH];
    };

    if (_class == "RscMapControl") then {
        _control ctrlMapSetPosition _position;
    } else {
        _control ctrlSetPosition _position;
        _control ctrlCommit 0;
    };

    if (_isGroup) then {
        private _background = _control getVariable ["DB_UIEditor_GroupBackground", controlNull];
        private _header = _control getVariable ["DB_UIEditor_GroupHeader", controlNull];
        _background ctrlSetPosition [0, 0, _position # 2, _position # 3];
        _header ctrlSetPosition [0, 0, _position # 2, 4 * pixelH * pixelGrid];
        _background ctrlCommit 0;
        _header ctrlCommit 0;
    };
} forEach _items;

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
{
    if ((_x # 3) == "RscMapControl") then {
        (_x # 1) ctrlMapSetPosition [];
    };
} forEach _nodes;

[_display, false] call DB_fnc_uiEditorOverlay;
