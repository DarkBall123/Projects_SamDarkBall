params ["_unit", "", "", "", "_ammo", "_magazine", "_projectile"];

if (!DB_test_active || {!(_unit isEqualTo player)} || {isNull _projectile}) exitWith {};

private _seriesId = DB_test_seriesId;
private _shotId = DB_test_nextShotId;
DB_test_nextShotId = DB_test_nextShotId + 1;

private _isMnogotochie = _ammo in [
    "DB_Ammo_STs226_Carrier",
    "DB_Ammo_STs228_Carrier"
];
private _expectedElements = [1, 3] select _isMnogotochie;

DB_test_shots pushBack [_shotId, _magazine, _ammo, _expectedElements];

_projectile setVariable ["DB_test_seriesId", _seriesId];
_projectile setVariable ["DB_test_shotId", _shotId];
_projectile setVariable ["DB_test_nextElementIndex", 0];

if (_isMnogotochie) then {
    _projectile addEventHandler ["SubmunitionCreated", {
        params ["_parent", "_submunition"];

        private _seriesId = _parent getVariable ["DB_test_seriesId", -1];
        private _shotId = _parent getVariable ["DB_test_shotId", -1];
        private _elementIndex = _parent getVariable ["DB_test_nextElementIndex", 0];
        _parent setVariable ["DB_test_nextElementIndex", _elementIndex + 1];

        [_submunition, _seriesId, _shotId, _elementIndex] call DB_test_fnc_trackProjectile;
    }];
} else {
    [_projectile, _seriesId, _shotId, 0] call DB_test_fnc_trackProjectile;
};
