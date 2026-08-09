params ["_projectile", "_seriesId", "_shotId", "_elementIndex"];

if (isNull _projectile || {_seriesId != DB_test_seriesId}) exitWith {};

_projectile setVariable ["DB_test_seriesId", _seriesId];
_projectile setVariable ["DB_test_shotId", _shotId];
_projectile setVariable ["DB_test_elementIndex", _elementIndex];
_projectile setVariable ["DB_test_resolved", false];

DB_test_elements pushBack [_shotId, _elementIndex, typeOf _projectile];

_projectile addEventHandler ["HitPart", {
    params [
        "_projectile",
        "_hitEntity",
        "",
        "_positionASL",
        "_velocity",
        "",
        "",
        "",
        "",
        ""
    ];

    private _seriesId = _projectile getVariable ["DB_test_seriesId", -1];
    if (_seriesId != DB_test_seriesId || {_projectile getVariable ["DB_test_resolved", false]}) exitWith {};

    _projectile setVariable ["DB_test_resolved", true];

    private _hitTarget = _hitEntity isEqualTo DB_test_target;
    private _localX = 0;
    private _localZ = 0;

    if (_hitTarget) then
    {
        private _modelPosition = DB_test_target worldToModel (ASLToAGL _positionASL);
        _localX = (_modelPosition # 0) - (DB_test_targetCenterModel # 0);
        _localZ = (_modelPosition # 2) - (DB_test_targetCenterModel # 2);
    };

    private _hitClass = if (isNull _hitEntity) then {""} else {typeOf _hitEntity};
    DB_test_impacts pushBack [
        _projectile getVariable ["DB_test_shotId", -1],
        _projectile getVariable ["DB_test_elementIndex", -1],
        typeOf _projectile,
        _hitTarget,
        _localX,
        _localZ,
        vectorMagnitude _velocity,
        _hitClass
    ];
}];
