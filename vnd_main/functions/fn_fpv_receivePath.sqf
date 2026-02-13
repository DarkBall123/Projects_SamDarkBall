params ["_uav", ["_payload", [], [[]]]];
if (isNull _uav) exitWith {};

if !(_payload isEqualType []) exitWith {};
if (_payload isEqualTo []) exitWith {};

private _recalcPathLen = {
    params ["_nodes"];
    private _len = 0;
    for "_i" from 0 to ((count _nodes) - 2) do {
        _len = _len + ((_nodes # _i) distance (_nodes # (_i + 1)));
    };
    _len
};

private _mode = _payload # 0;
if !(_mode isEqualType "") exitWith {};

switch (_mode) do {
    case "snapshot": {
        private _path = _payload param [1, [], [[]]];
        if !(_path isEqualType []) exitWith {};

        _uav setVariable ["vnd_fiber_path", +_path, false];
        _uav setVariable ["vnd_fiber_len", [_path] call _recalcPathLen, false];
    };
    case "delta": {
        private _trimReq = _payload param [1, 0, [0]];
        private _append = _payload param [2, [], [[]]];

        private _path = +(_uav getVariable ["vnd_fiber_path", []]);

        private _trim = _trimReq max 0;
        if (_trim > count _path) then {
            _trim = count _path;
        };

        for "_i" from 1 to _trim do {
            _path deleteAt 0;
        };

        {
            if (_x isEqualType [] && { count _x >= 3 }) then {
                _path pushBack _x;
            };
        } forEach _append;

        _uav setVariable ["vnd_fiber_path", _path, false];
        _uav setVariable ["vnd_fiber_len", [_path] call _recalcPathLen, false];
    };
};
