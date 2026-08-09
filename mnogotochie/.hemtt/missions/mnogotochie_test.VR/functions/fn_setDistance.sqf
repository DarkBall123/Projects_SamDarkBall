params [["_distance", 50, [0]]];

if !(_distance in DB_test_distances) exitWith
{
    hint format ["Unsupported distance: %1 m", _distance];
};

private _damageTargetIndex = if (DB_damage_active) then
{
    DB_damage_targetIndex
}
else
{
    -1
};

DB_test_distance = _distance;

private _forward = [
    sin DB_test_firingDirection,
    cos DB_test_firingDirection,
    0
];

DB_test_target setDir (DB_test_firingDirection + 180);

(boundingBoxReal DB_test_target) params ["_minimum", "_maximum"];
DB_test_targetCenterModel = [
    ((_minimum # 0) + (_maximum # 0)) / 2,
    _maximum # 1,
    ((_minimum # 2) + (_maximum # 2)) / 2
];

private _targetOriginDistance = _distance + (_maximum # 1);
private _targetPosition = DB_test_firingPosATL vectorAdd (_forward vectorMultiply _targetOriginDistance);
DB_test_target setPosATL _targetPosition;
DB_test_aimPointASL = DB_test_target modelToWorldWorld DB_test_targetCenterModel;

call DB_test_fnc_resetSeries;

if (_damageTargetIndex >= 0) then
{
    [_damageTargetIndex] call DB_damage_fnc_spawnTarget;
};
