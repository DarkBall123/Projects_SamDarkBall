if (DB_damage_batchRunning) exitWith
{
    hint "A damage batch is already running.";
};

if (!DB_damage_active || {isNull DB_damage_target}) exitWith
{
    hint "Spawn a damage target first.";
};

private _weaponState = weaponState player;
_weaponState params ["_weapon", "_muzzle", "_fireMode", "_magazine", "_ammoCount"];

private _trialCount = 10;
if (_weapon isEqualTo "" || {_magazine isEqualTo ""}) exitWith
{
    hint "Load and select a weapon first.";
};

if (_ammoCount < _trialCount) exitWith
{
    hint format ["The current magazine needs at least %1 rounds.", _trialCount];
};

private _targetIndex = DB_damage_targetIndex;
private _targetLabel = DB_damage_targetLabel;
private _distance = DB_test_distance;
private _results = [];

DB_damage_batchRunning = true;
hint format [
    "Automatic damage batch started\n%1 | %2 m\nKeep the weapon aimed at the marker.",
    _targetLabel,
    _distance
];

for "_trial" from 1 to _trialCount do
{
    [_targetIndex] call DB_damage_fnc_spawnTarget;
    private _target = DB_damage_target;
    uiSleep 0.1;

    player forceWeaponFire [_muzzle, _fireMode];

    private _firedDeadline = diag_tickTime + 1;
    waitUntil
    {
        uiSleep 0.01;
        DB_damage_shots > 0 || {diag_tickTime >= _firedDeadline}
    };

    private _impactDeadline = diag_tickTime + (_distance / 200) + 0.5;
    waitUntil
    {
        uiSleep 0.02;
        isNull _target || {!alive _target} || {damage _target > 0.001} || {diag_tickTime >= _impactDeadline}
    };
    uiSleep 0.15;

    private _targetAlive = !isNull _target && {alive _target};
    private _targetDamage = if (isNull _target) then {1} else {damage _target};
    _results pushBack [_trial, DB_damage_shots, _targetAlive, _targetDamage];
};

private _damageSum = 0;
private _minimumDamage = 1;
private _maximumDamage = 0;
{
    private _targetDamage = _x # 3;
    _damageSum = _damageSum + _targetDamage;
    _minimumDamage = _minimumDamage min _targetDamage;
    _maximumDamage = _maximumDamage max _targetDamage;
} forEach _results;

private _round3 = {round (_this * 1000) / 1000};
private _hitCount = {_x # 3 > 0.001} count _results;
private _killCount = {!(_x # 2)} count _results;
private _singleShotCount = {_x # 1 == 1} count _results;
private _meanDamage = _damageSum / _trialCount;
private _lines = [
    "Mnogotochie automatic damage report",
    format ["distance_m=%1", _distance],
    format ["target=%1", _targetLabel],
    format ["target_class=%1", (DB_damage_targetTypes # _targetIndex) # 1],
    format ["weapon=%1", _weapon],
    format ["magazine=%1", _magazine],
    format ["fire_mode=%1", _fireMode],
    format ["trials=%1", _trialCount],
    format ["single_shot_trials=%1/%2", _singleShotCount, _trialCount],
    format ["damaging_hits=%1/%2", _hitCount, _trialCount],
    format ["kills=%1/%2", _killCount, _trialCount],
    format ["mean_damage=%1", _meanDamage call _round3],
    format ["minimum_damage=%1", _minimumDamage call _round3],
    format ["maximum_damage=%1", _maximumDamage call _round3],
    "",
    "trial,shots,hit,alive,damage"
];

{
    _lines pushBack format [
        "%1,%2,%3,%4,%5",
        _x # 0,
        _x # 1,
        _x # 3 > 0.001,
        _x # 2,
        (_x # 3) call _round3
    ];
} forEach _results;

DB_damage_batchLastReport = _lines joinString toString [13, 10];
copyToClipboard DB_damage_batchLastReport;

{
    diag_log format ["[DB Mnogotochie Automatic Damage Test] %1", _x];
} forEach _lines;

DB_damage_batchRunning = false;
hint format [
    "Automatic batch finished\nTarget: %1\nHits: %2/%4\nKills: %3/%4\nMean damage: %5\n\nReport copied to clipboard.",
    _targetLabel,
    _hitCount,
    _killCount,
    _trialCount,
    _meanDamage call _round3
];
