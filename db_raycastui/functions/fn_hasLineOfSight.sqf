#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]],
    ["_angle", 0, [0]],
    ["_distance", 0, [0]],
    ["_padding", DB_RUI_LOS_PADDING, [0]]
];

if (_state isEqualTo []) exitWith
{
    false
};

private _trace = [_state, _angle, _distance + DB_RUI_LOS_TRACE_EXTRA, false] call DB_fnc_rui_castRay;
(((_trace # 2) + _padding) >= _distance)
