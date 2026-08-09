SDB_damage_active = false;
if (!isNull SDB_damage_target) then
{
    deleteVehicle SDB_damage_target;
};
SDB_damage_target = objNull;

SDB_test_seriesId = SDB_test_seriesId + 1;
SDB_test_nextShotId = 1;
SDB_test_shots = [];
SDB_test_elements = [];
SDB_test_impacts = [];
SDB_test_active = true;

player setPosATL SDB_test_firingPosATL;
player setDir SDB_test_firingDirection;

hint format [
    "New series: %1 m\nFire single shots, then use Finish + copy report.",
    SDB_test_distance
];
