DB_damage_active = false;
if (!isNull DB_damage_target) then
{
    deleteVehicle DB_damage_target;
};
DB_damage_target = objNull;

DB_test_seriesId = DB_test_seriesId + 1;
DB_test_nextShotId = 1;
DB_test_shots = [];
DB_test_elements = [];
DB_test_impacts = [];
DB_test_active = true;

player setPosATL DB_test_firingPosATL;
player setDir DB_test_firingDirection;

hint format [
    "New series: %1 m\nFire single shots, then use Finish + copy report.",
    DB_test_distance
];
