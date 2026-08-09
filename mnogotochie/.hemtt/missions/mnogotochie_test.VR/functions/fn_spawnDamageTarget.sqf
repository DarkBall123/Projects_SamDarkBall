params [["_targetIndex", 0, [0]]];

if (SDB_damage_targetTypes isEqualTo []) exitWith {};

_targetIndex = (_targetIndex max 0) min ((count SDB_damage_targetTypes) - 1);

if (!isNull SDB_damage_target) then
{
    deleteVehicle SDB_damage_target;
};

(SDB_damage_targetTypes # _targetIndex) params ["_label", "_className", "_isMan"];

private _forward = [
    sin SDB_test_firingDirection,
    cos SDB_test_firingDirection,
    0
];
private _right = [
    cos SDB_test_firingDirection,
    -sin SDB_test_firingDirection,
    0
];
private _targetPosition = SDB_test_firingPosATL
    vectorAdd (_forward vectorMultiply SDB_test_distance)
    vectorAdd (_right vectorMultiply 10);

private _target = objNull;
if (_isMan) then
{
    _target = createAgent [_className, _targetPosition, [], 0, "CAN_COLLIDE"];
    _target disableAI "ALL";
    _target setCaptive true;
    _target setUnitPos "UP";
    removeAllWeapons _target;
}
else
{
    _target = createVehicle [_className, _targetPosition, [], 0, "CAN_COLLIDE"];
    _target setFuel 0;
    _target lock 2;
};

(boundingBoxReal _target) params ["_minimum", "_maximum"];
_targetPosition set [2, (SDB_test_firingPosATL # 2) - (_minimum # 2)];
_target setPosATL _targetPosition;
_target setDir (_target getDir player);
_target setVectorUp [0, 0, 1];
if (!_isMan) then
{
    _target enableSimulationGlobal false;
};
_target allowDamage true;

SDB_damage_target = _target;
SDB_damage_targetIndex = _targetIndex;
SDB_damage_targetLabel = _label;
SDB_damage_targetCenterModel = [
    ((_minimum # 0) + (_maximum # 0)) / 2,
    ((_minimum # 1) + (_maximum # 1)) / 2,
    ((_minimum # 2) + (_maximum # 2)) / 2
];
SDB_damage_shots = 0;
SDB_damage_magazines = [];
SDB_damage_active = true;
SDB_test_active = false;

if (!SDB_damage_batchRunning) then
{
    hint format [
        "Damage target: %1\nDistance: %2 m\nFire one round, then copy the damage report.",
        SDB_damage_targetLabel,
        SDB_test_distance
    ];
};
