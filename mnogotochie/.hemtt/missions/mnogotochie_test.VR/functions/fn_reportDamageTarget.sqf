if (!SDB_damage_active || {isNull SDB_damage_target}) exitWith
{
    hint "Spawn a damage target first.";
};

private _round3 = {round (_this * 1000) / 1000};
private _target = SDB_damage_target;
private _hitPointData = getAllHitPointsDamage _target;
private _hitPointNames = _hitPointData param [0, []];
private _hitPointValues = _hitPointData param [2, []];
private _damagedHitPoints = [];

{
    private _value = _hitPointValues param [_forEachIndex, 0];
    if (_value > 0.001) then
    {
        _damagedHitPoints pushBack format ["%1=%2", _x, _value call _round3];
    };
} forEach _hitPointNames;

private _hitPointText = if (_damagedHitPoints isEqualTo []) then
{
    "none"
}
else
{
    _damagedHitPoints joinString " | "
};

private _lines = [
    "Mnogotochie damage report",
    format ["distance_m=%1", SDB_test_distance],
    format ["target=%1", SDB_damage_targetLabel],
    format ["target_class=%1", typeOf _target],
    format ["magazines=%1", SDB_damage_magazines joinString " | "],
    format ["shots=%1", SDB_damage_shots],
    format ["alive=%1", alive _target],
    format ["overall_damage=%1", (damage _target) call _round3],
    format ["damaged_hitpoints=%1", _hitPointText]
];

SDB_damage_lastReport = _lines joinString toString [13, 10];
copyToClipboard SDB_damage_lastReport;

{
    diag_log format ["[SDB Mnogotochie Damage Test] %1", _x];
} forEach _lines;

hint format [
    "Damage report copied\nTarget: %1\nShots: %2\nDamage: %3\nAlive: %4",
    SDB_damage_targetLabel,
    SDB_damage_shots,
    (damage _target) call _round3,
    alive _target
];
