SDB_test_fnc_resetSeries = compile preprocessFileLineNumbers "functions\fn_resetSeries.sqf";
SDB_test_fnc_setDistance = compile preprocessFileLineNumbers "functions\fn_setDistance.sqf";
SDB_test_fnc_trackProjectile = compile preprocessFileLineNumbers "functions\fn_trackProjectile.sqf";
SDB_test_fnc_onFired = compile preprocessFileLineNumbers "functions\fn_onFired.sqf";
SDB_test_fnc_finishSeries = compile preprocessFileLineNumbers "functions\fn_finishSeries.sqf";

SDB_test_distances = [5, 20, 50, 100, 150, 300, 500, 600];
SDB_test_distance = 50;
SDB_test_seriesId = 0;
SDB_test_nextShotId = 1;
SDB_test_shots = [];
SDB_test_elements = [];
SDB_test_impacts = [];
SDB_test_active = false;
SDB_test_traceEnabled = false;
SDB_test_lastReport = "";
SDB_test_firingDirection = 0;
SDB_test_firingPosATL = getPosATL player;
SDB_test_targetCenterModel = [0, 0, 0];
SDB_test_aimPointASL = [0, 0, 0];

player setDir SDB_test_firingDirection;
player enableStamina false;
player setCustomAimCoef 0;
player setUnitRecoilCoefficient 0;
setWind [0, 0, true];

removeAllWeapons player;
{
    player removeMagazine _x;
} forEach magazines player;

player addMagazines ["SDB_30Rnd_545x39_STs226_Mag", 8];
player addWeapon "arifle_AKS_F";
player selectWeapon "arifle_AKS_F";

SDB_test_target = createVehicle ["UserTexture10m_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
SDB_test_target allowDamage false;
SDB_test_target setObjectTextureGlobal [0, "#(rgb,8,8,3)color(0.85,0.85,0.85,1)"];

private _cratePosition = player modelToWorld [3, -1, 0];
private _crate = createVehicle ["Box_NATO_Ammo_F", _cratePosition, [], 0, "CAN_COLLIDE"];
_crate setPosATL _cratePosition;
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_crate addWeaponCargoGlobal ["arifle_AKS_F", 2];
_crate addWeaponCargoGlobal ["srifle_DMR_01_F", 2];
_crate addWeaponCargoGlobal ["LMG_Zafir_F", 2];
_crate addMagazineCargoGlobal ["SDB_30Rnd_545x39_STs226_Mag", 30];
_crate addMagazineCargoGlobal ["SDB_45Rnd_545x39_STs226_Mag", 20];
_crate addMagazineCargoGlobal ["SDB_10Rnd_762x54R_STs228_Mag", 30];
_crate addMagazineCargoGlobal ["SDB_100Rnd_762x54R_STs228_Box", 10];
_crate addMagazineCargoGlobal ["SDB_150Rnd_762x54R_STs228_Box", 10];
_crate addMagazineCargoGlobal ["30Rnd_545x39_Mag_F", 20];
_crate addMagazineCargoGlobal ["10Rnd_762x54_Mag", 20];
_crate addMagazineCargoGlobal ["150Rnd_762x54_Box", 10];

player addEventHandler ["Fired", {
    _this call SDB_test_fnc_onFired;
}];

addMissionEventHandler ["Draw3D", {
    if (!isNull SDB_test_target) then
    {
        drawIcon3D [
            "\a3\ui_f\data\map\markers\military\dot_CA.paa",
            [0.2, 1, 0.2, 0.95],
            ASLToAGL SDB_test_aimPointASL,
            0.5,
            0.5,
            0,
            format ["%1 m", SDB_test_distance],
            1,
            0.03,
            "RobotoCondensed",
            "center",
            true
        ];
    };
}];

player addAction [
    "<t color='#7FD8FF'>TEST: next distance</t>",
    {
        private _index = SDB_test_distances find SDB_test_distance;
        private _nextIndex = (_index + 1) mod (count SDB_test_distances);
        [SDB_test_distances # _nextIndex] call SDB_test_fnc_setDistance;
    },
    nil,
    1.5,
    false,
    true,
    "",
    "true",
    5
];

player addAction [
    "<t color='#8CFF8C'>TEST: start / reset series</t>",
    {
        call SDB_test_fnc_resetSeries;
    },
    nil,
    1.5,
    false,
    true,
    "",
    "true",
    5
];

player addAction [
    "<t color='#FFD27F'>TEST: finish + copy report</t>",
    {
        [] spawn SDB_test_fnc_finishSeries;
    },
    nil,
    1.5,
    false,
    true,
    "",
    "true",
    5
];

player addAction [
    "TEST: toggle trajectory display",
    {
        SDB_test_traceEnabled = !SDB_test_traceEnabled;
        if (SDB_test_traceEnabled) then
        {
            [player, 100] spawn BIS_fnc_traceBullets;
            hint "Trajectory display enabled.";
        }
        else
        {
            [player, 0] spawn BIS_fnc_traceBullets;
            hint "Trajectory display disabled.";
        };
    },
    nil,
    1.5,
    false,
    true,
    "",
    "true",
    5
];

[SDB_test_distance] call SDB_test_fnc_setDistance;

systemChat "Mnogotochie test ready. Ammunition and weapons are in the crate.";
