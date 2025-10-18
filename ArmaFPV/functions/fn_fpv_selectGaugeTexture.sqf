params [
    ["_value", 0, [0]],
    ["_thresholds", [], [[]]],
    ["_default", "", [""]]
];

private _texture = _default;
{
    _x params ["_limit", "_path"];
    if (_value >= _limit) exitWith { _texture = _path; };
} forEach _thresholds;

_texture;
