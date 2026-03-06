params [
    ["_payload", [], [[]]],
    ["_entryType", "item", [""]]
];

private _ordered = [];
private _counts = createHashMap;

private _isCargoPair =
    (count _payload isEqualTo 2) &&
    {(_payload # 0) isEqualType []} &&
    {(_payload # 1) isEqualType []};

if (_isCargoPair) then {
    private _classes = _payload # 0;
    private _numbers = _payload # 1;

    {
        if !(_x isEqualTo "") then {
            _ordered pushBack _x;
            _counts set [_x, _numbers param [_forEachIndex, 0]];
        };
    } forEach _classes;
} else {
    {
        if !(_x isEqualTo "") then {
            private _current = _counts getOrDefault [_x, -1];
            if (_current < 0) then {
                _ordered pushBack _x;
                _counts set [_x, 1];
            } else {
                _counts set [_x, _current + 1];
            };
        };
    } forEach _payload;
};

private _entries = [];

{
    private _className = _x;
    private _count = _counts getOrDefault [_className, 0];

    if (_count > 0) then {
        private _info = [_className] call DB_dsi_fnc_inv_getClassData;
        _entries pushBack [_entryType, _className, _count, _info # 0, _info # 1];
    };
} forEach _ordered;

_entries
