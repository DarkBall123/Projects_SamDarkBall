disableSerialization;
params ["_display", "_parentId"];

if (_parentId < 0) exitWith {
    _display getVariable ["DB_UIEditor_CanvasControl", controlNull]
};

private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _parentIndex = _nodes findIf {(_x # 0) == _parentId};

if (_parentIndex < 0) then {
    controlNull
} else {
    (_nodes # _parentIndex) # 1
}
