params ["_unit", "", "", "", "_ammo", "_magazine", "_projectile"];

if (!SDB_test_active || {!(_unit isEqualTo player)} || {isNull _projectile}) exitWith {};

private _seriesId = SDB_test_seriesId;
private _shotId = SDB_test_nextShotId;
SDB_test_nextShotId = SDB_test_nextShotId + 1;

private _expectedElements = if (_ammo in [
    "SDB_Ammo_STs226_Carrier",
    "SDB_Ammo_STs228_Carrier"
]) then {3} else {1};

SDB_test_shots pushBack [_shotId, _magazine, _ammo, _expectedElements];

_projectile setVariable ["SDB_test_seriesId", _seriesId];
_projectile setVariable ["SDB_test_shotId", _shotId];
_projectile setVariable ["SDB_test_nextElementIndex", 1];

_projectile addEventHandler ["SubmunitionCreated", {
    params ["_parent", "_submunition"];

    private _seriesId = _parent getVariable ["SDB_test_seriesId", -1];
    private _shotId = _parent getVariable ["SDB_test_shotId", -1];
    private _elementIndex = _parent getVariable ["SDB_test_nextElementIndex", 1];
    _parent setVariable ["SDB_test_nextElementIndex", _elementIndex + 1];

    [_submunition, _seriesId, _shotId, _elementIndex] call SDB_test_fnc_trackProjectile;
}];

[_projectile, _seriesId, _shotId, 0] call SDB_test_fnc_trackProjectile;
