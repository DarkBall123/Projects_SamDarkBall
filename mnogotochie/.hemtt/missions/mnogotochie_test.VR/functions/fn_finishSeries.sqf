if (!SDB_test_active) exitWith
{
    hint "The series is already finished. Start a new series first.";
};

SDB_test_active = false;
private _seriesId = SDB_test_seriesId;
hint "Waiting 1.5 seconds for the last projectiles...";
sleep 1.5;

if (_seriesId != SDB_test_seriesId) exitWith {};

private _shots = +SDB_test_shots;
private _elements = +SDB_test_elements;
private _impacts = +SDB_test_impacts;

if (_shots isEqualTo []) exitWith
{
    hint "No shots were recorded.";
};

private _targetHits = _impacts select {_x # 3};
private _shotCount = count _shots;
private _elementCount = count _elements;
private _hitCount = count _targetHits;
private _resolvedCount = count _impacts;
private _invalidShotCount = 0;

{
    _x params ["_shotId", "", "", "_expectedElements"];
    private _createdElements = {_x # 0 == _shotId} count _elements;
    if (_createdElements != _expectedElements) then
    {
        _invalidShotCount = _invalidShotCount + 1;
    };
} forEach _shots;

private _meanX = 0;
private _meanZ = 0;
private _meanSpeed = 0;
private _r50 = 0;
private _r90 = 0;
private _groupWidth = 0;
private _groupHeight = 0;

if (_hitCount > 0) then
{
    private _sumX = 0;
    private _sumZ = 0;
    private _sumSpeed = 0;

    {
        _sumX = _sumX + (_x # 4);
        _sumZ = _sumZ + (_x # 5);
        _sumSpeed = _sumSpeed + (_x # 6);
    } forEach _targetHits;

    _meanX = _sumX / _hitCount;
    _meanZ = _sumZ / _hitCount;
    _meanSpeed = _sumSpeed / _hitCount;

    private _radii = _targetHits apply
    {
        private _deltaX = (_x # 4) - _meanX;
        private _deltaZ = (_x # 5) - _meanZ;
        sqrt ((_deltaX * _deltaX) + (_deltaZ * _deltaZ))
    };
    _radii sort true;

    private _r50Index = ((ceil (_hitCount * 0.5)) - 1) max 0;
    private _r90Index = ((ceil (_hitCount * 0.9)) - 1) max 0;
    _r50 = _radii # (_r50Index min (_hitCount - 1));
    _r90 = _radii # (_r90Index min (_hitCount - 1));

    private _minimumX = (_targetHits # 0) # 4;
    private _maximumX = _minimumX;
    private _minimumZ = (_targetHits # 0) # 5;
    private _maximumZ = _minimumZ;

    {
        _minimumX = _minimumX min (_x # 4);
        _maximumX = _maximumX max (_x # 4);
        _minimumZ = _minimumZ min (_x # 5);
        _maximumZ = _maximumZ max (_x # 5);
    } forEach _targetHits;

    _groupWidth = _maximumX - _minimumX;
    _groupHeight = _maximumZ - _minimumZ;
};

private _zoneHalfSize = 0.25;
private _zoneElementHits = {
    abs (_x # 4) <= _zoneHalfSize && {abs (_x # 5) <= _zoneHalfSize}
} count _targetHits;
private _zoneShotHits = 0;

{
    private _shotId = _x # 0;
    if (_targetHits findIf {
        _x # 0 == _shotId &&
        {abs (_x # 4) <= _zoneHalfSize} &&
        {abs (_x # 5) <= _zoneHalfSize}
    } >= 0) then
    {
        _zoneShotHits = _zoneShotHits + 1;
    };
} forEach _shots;

private _round3 = {round (_this * 1000) / 1000};
private _round1 = {round (_this * 10) / 10};
private _magazineNames = [];

{
    private _displayName = getText (configFile >> "CfgMagazines" >> (_x # 1) >> "displayName");
    if (_displayName isEqualTo "") then
    {
        _displayName = _x # 1;
    };
    if !(_displayName in _magazineNames) then
    {
        _magazineNames pushBack _displayName;
    };
} forEach _shots;

private _lines = [
    "Mnogotochie ballistics report",
    format ["distance_m=%1", SDB_test_distance],
    format ["magazines=%1", _magazineNames joinString " | "],
    format ["shots=%1", _shotCount],
    format ["elements_created=%1", _elementCount],
    format ["shots_with_wrong_element_count=%1", _invalidShotCount],
    format ["target_hits=%1", _hitCount],
    format ["other_or_unresolved=%1", _elementCount - _hitCount],
    format ["resolved_impacts=%1", _resolvedCount],
    format ["zone_0.5m_element_hits=%1", _zoneElementHits],
    format ["zone_0.5m_successful_shots=%1/%2", _zoneShotHits, _shotCount],
    format ["mean_x_m=%1", _meanX call _round3],
    format ["mean_z_m=%1", _meanZ call _round3],
    format ["r50_m=%1", _r50 call _round3],
    format ["r90_m=%1", _r90 call _round3],
    format ["group_width_m=%1", _groupWidth call _round3],
    format ["group_height_m=%1", _groupHeight call _round3],
    format ["mean_impact_speed_mps=%1", _meanSpeed call _round1],
    "",
    "shot_id,element,ammo,target_hit,x_m,z_m,speed_mps,hit_object"
];

{
    _x params ["_shotId", "_elementIndex", "_ammoClass"];
    private _impactIndex = _impacts findIf {
        _x # 0 == _shotId && {_x # 1 == _elementIndex}
    };

    if (_impactIndex < 0) then
    {
        _lines pushBack format ["%1,%2,%3,false,,,,unresolved", _shotId, _elementIndex, _ammoClass];
    }
    else
    {
        private _impact = _impacts # _impactIndex;
        _lines pushBack format [
            "%1,%2,%3,%4,%5,%6,%7,%8",
            _shotId,
            _elementIndex,
            _ammoClass,
            _impact # 3,
            (_impact # 4) call _round3,
            (_impact # 5) call _round3,
            (_impact # 6) call _round1,
            _impact # 7
        ];
    };
} forEach _elements;

SDB_test_lastReport = _lines joinString toString [13, 10];
copyToClipboard SDB_test_lastReport;

{
    diag_log format ["[SDB Mnogotochie Test] %1", _x];
} forEach _lines;

hint format [
    "Series finished\nShots: %1\nElements: %2\nTarget hits: %3\nR50: %4 m\nR90: %5 m\n0.5 m zone: %6/%1 shots\n\nFull CSV report copied to clipboard.",
    _shotCount,
    _elementCount,
    _hitCount,
    _r50 call _round3,
    _r90 call _round3,
    _zoneShotHits
];
