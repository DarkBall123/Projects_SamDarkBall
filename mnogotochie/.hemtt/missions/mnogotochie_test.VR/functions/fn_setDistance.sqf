params [["_distance", 50, [0]]];

if !(_distance in SDB_test_distances) exitWith
{
    hint format ["Unsupported distance: %1 m", _distance];
};

private _damageTargetIndex = if (SDB_damage_active) then
{
    SDB_damage_targetIndex
}
else
{
    -1
};

SDB_test_distance = _distance;

private _forward = [
    sin SDB_test_firingDirection,
    cos SDB_test_firingDirection,
    0
];

SDB_test_target setDir (SDB_test_firingDirection + 180);

(boundingBoxReal SDB_test_target) params ["_minimum", "_maximum"];
SDB_test_targetCenterModel = [
    ((_minimum # 0) + (_maximum # 0)) / 2,
    _maximum # 1,
    ((_minimum # 2) + (_maximum # 2)) / 2
];

private _targetOriginDistance = _distance + (_maximum # 1);
private _targetPosition = SDB_test_firingPosATL vectorAdd (_forward vectorMultiply _targetOriginDistance);
SDB_test_target setPosATL _targetPosition;
SDB_test_aimPointASL = SDB_test_target modelToWorldWorld SDB_test_targetCenterModel;

call SDB_test_fnc_resetSeries;

if (_damageTargetIndex >= 0) then
{
    [_damageTargetIndex] call SDB_damage_fnc_spawnTarget;
};
