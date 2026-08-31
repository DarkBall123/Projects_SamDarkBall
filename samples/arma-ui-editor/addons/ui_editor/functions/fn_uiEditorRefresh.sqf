disableSerialization;
params ["_display"];

private _list = _display getVariable ["DB_UIEditor_Tree", controlNull];
private _nodes = _display getVariable ["DB_UIEditor_Nodes", []];
private _selection = _display getVariable ["DB_UIEditor_Selection", []];
private _primary = if (_selection isEqualTo []) then {-1} else {_selection # ((count _selection) - 1)};

_display setVariable ["DB_UIEditor_Refreshing", true];
lbClear _list;

{
    _x params ["_id", "", "_parentId", "_class", "_name"];
    private _depth = 0;
    private _ancestorId = _parentId;

    while {_ancestorId >= 0} do {
        private _ancestorIndex = _nodes findIf {(_x # 0) == _ancestorId};
        if (_ancestorIndex >= 0) then {
            _depth = _depth + 1;
            _ancestorId = (_nodes # _ancestorIndex) # 2;
        } else {
            _ancestorId = -1;
        };
    };

    private _indent = "";
    for "_level" from 1 to _depth do {
        _indent = _indent + "    ";
    };

    private _mark = ["[ ]", "[x]"] select (_id in _selection);
    private _index = _list lbAdd format ["%1 %2%3  %4", _mark, _indent, _name, _class];
    _list lbSetData [_index, str _id];

    if (_id == _primary) then {
        _list lbSetCurSel _index;
    };
} forEach _nodes;

_display setVariable ["DB_UIEditor_Refreshing", false];

if (_selection isEqualTo []) then {
    private _typeLabel = _display getVariable ["DB_UIEditor_TypeLabel", controlNull];
    _typeLabel ctrlSetText "Nothing selected";
};
