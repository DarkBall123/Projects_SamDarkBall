params [["_targetIndex", 0, [0]]];

if (DB_damage_targetTypes isEqualTo []) exitWith {};

_targetIndex = (_targetIndex max 0) min ((count DB_damage_targetTypes) - 1);

if (!isNull DB_damage_target) then
{
    deleteVehicle DB_damage_target;
};

(DB_damage_targetTypes # _targetIndex) params ["_label", "_className", "_isMan"];

private _forward = [
    sin DB_test_firingDirection,
    cos DB_test_firingDirection,
    0
];
private _right = [
    cos DB_test_firingDirection,
    -sin DB_test_firingDirection,
    0
];
private _targetPosition = DB_test_firingPosATL
    vectorAdd (_forward vectorMultiply DB_test_distance)
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
_targetPosition set [2, (DB_test_firingPosATL # 2) - (_minimum # 2)];
_target setPosATL _targetPosition;
_target setDir (_target getDir player);
_target setVectorUp [0, 0, 1];
if (!_isMan) then
{
    _target enableSimulationGlobal false;
};
_target allowDamage true;

DB_damage_target = _target;
DB_damage_targetIndex = _targetIndex;
DB_damage_targetLabel = _label;
DB_damage_targetCenterModel = [
    ((_minimum # 0) + (_maximum # 0)) / 2,
    ((_minimum # 1) + (_maximum # 1)) / 2,
    ((_minimum # 2) + (_maximum # 2)) / 2
];
DB_damage_shots = 0;
DB_damage_magazines = [];
DB_damage_active = true;
DB_test_active = false;

if (!DB_damage_batchRunning) then
{
    hint format [
        "Damage target: %1\nDistance: %2 m\nFire one round, then copy the damage report.",
        DB_damage_targetLabel,
        DB_test_distance
    ];
};
