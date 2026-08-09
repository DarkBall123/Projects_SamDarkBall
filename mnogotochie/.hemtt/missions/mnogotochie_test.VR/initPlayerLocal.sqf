DB_test_fnc_resetSeries = compile preprocessFileLineNumbers "functions\fn_resetSeries.sqf";
DB_test_fnc_setDistance = compile preprocessFileLineNumbers "functions\fn_setDistance.sqf";
DB_test_fnc_trackProjectile = compile preprocessFileLineNumbers "functions\fn_trackProjectile.sqf";
DB_test_fnc_onFired = compile preprocessFileLineNumbers "functions\fn_onFired.sqf";
DB_test_fnc_finishSeries = compile preprocessFileLineNumbers "functions\fn_finishSeries.sqf";
DB_damage_fnc_spawnTarget = compile preprocessFileLineNumbers "functions\fn_spawnDamageTarget.sqf";
DB_damage_fnc_reportTarget = compile preprocessFileLineNumbers "functions\fn_reportDamageTarget.sqf";
DB_damage_fnc_runBatch = compile preprocessFileLineNumbers "functions\fn_runDamageBatch.sqf";

DB_test_fnc_nextDistance = {
    private _index = DB_test_distances find DB_test_distance;
    private _nextIndex = (_index + 1) mod (count DB_test_distances);
    [DB_test_distances # _nextIndex] call DB_test_fnc_setDistance;
};

DB_damage_fnc_nextTarget = {
    private _nextIndex = if (DB_damage_active) then
    {
        (DB_damage_targetIndex + 1) mod (count DB_damage_targetTypes)
    }
    else
    {
        0
    };
    [_nextIndex] call DB_damage_fnc_spawnTarget;
};

DB_test_distances = [5, 20, 50, 100, 150, 300, 500, 600];
DB_test_distance = 50;
DB_test_seriesId = 0;
DB_test_nextShotId = 1;
DB_test_shots = [];
DB_test_elements = [];
DB_test_impacts = [];
DB_test_active = false;
DB_test_traceEnabled = false;
DB_test_lastReport = "";
DB_test_firingDirection = 0;
DB_test_firingPosATL = getPosATL player;
DB_test_targetCenterModel = [0, 0, 0];
DB_test_aimPointASL = [0, 0, 0];
DB_damage_targetTypes = [
    ["VR infantry", "B_Soldier_VR_F", true],
    ["NATO rifleman", "B_Soldier_F", true],
    ["Darter UAV", "B_UAV_01_F", false],
    ["Offroad", "C_Offroad_01_F", false],
    ["Marshall", "B_APC_Wheeled_01_cannon_F", false]
];
DB_damage_target = objNull;
DB_damage_targetIndex = 0;
DB_damage_targetLabel = "";
DB_damage_targetCenterModel = [0, 0, 0];
DB_damage_shots = 0;
DB_damage_magazines = [];
DB_damage_active = false;
DB_damage_lastReport = "";
DB_damage_batchRunning = false;
DB_damage_batchLastReport = "";

player setDir DB_test_firingDirection;
player enableStamina false;
player setCustomAimCoef 0;
player setUnitRecoilCoefficient 0;
setWind [0, 0, true];

removeAllWeapons player;
{
    player removeMagazine _x;
} forEach magazines player;

player addMagazines ["DB_30Rnd_545x39_STs226_Mag", 8];
player addWeapon "arifle_AKS_F";
player selectWeapon "arifle_AKS_F";

DB_test_target = createVehicle ["Land_VR_Block_02_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
DB_test_target allowDamage false;
DB_test_target setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"];
DB_test_target setObjectMaterialGlobal [1, "\a3\data_f\default.rvmat"];
DB_test_target setObjectTextureGlobal [0, "#(rgb,8,8,3)color(0.82,0.82,0.82,1)"];
DB_test_target setObjectTextureGlobal [1, "#(rgb,8,8,3)color(0.72,0.72,0.72,1)"];

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
_crate addMagazineCargoGlobal ["DB_30Rnd_545x39_STs226_Mag", 30];
_crate addMagazineCargoGlobal ["DB_10Rnd_762x54R_STs228_Mag", 30];
_crate addMagazineCargoGlobal ["DB_100Rnd_762x54R_STs228_Box", 10];
_crate addMagazineCargoGlobal ["30Rnd_545x39_Mag_F", 20];
_crate addMagazineCargoGlobal ["10Rnd_762x54_Mag", 20];
_crate addMagazineCargoGlobal ["150Rnd_762x54_Box", 10];

player addEventHandler ["Fired", {
    if (DB_damage_active && {!isNull DB_damage_target}) then
    {
        DB_damage_shots = DB_damage_shots + 1;
        DB_damage_magazines pushBackUnique (_this param [5, ""]);
    };

    _this call DB_test_fnc_onFired;
}];

addMissionEventHandler ["Draw3D", {
    if (!isNull DB_test_target) then
    {
        drawIcon3D [
            "\a3\ui_f\data\map\markers\military\dot_CA.paa",
            [0.2, 1, 0.2, 0.95],
            ASLToAGL DB_test_aimPointASL,
            0.5,
            0.5,
            0,
            format ["%1 m", DB_test_distance],
            1,
            0.03,
            "RobotoCondensed",
            "center",
            true
        ];
    };

    if (DB_damage_active && {!isNull DB_damage_target}) then
    {
        private _damageAimPoint = DB_damage_target modelToWorldWorld DB_damage_targetCenterModel;
        drawIcon3D [
            "\a3\ui_f\data\map\markers\military\dot_CA.paa",
            [1, 0.35, 0.15, 0.95],
            ASLToAGL _damageAimPoint,
            0.6,
            0.6,
            0,
            format ["DAMAGE: %1 | %2 m", DB_damage_targetLabel, DB_test_distance],
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
        call DB_test_fnc_nextDistance;
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
        call DB_test_fnc_resetSeries;
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
        [] spawn DB_test_fnc_finishSeries;
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
        DB_test_traceEnabled = !DB_test_traceEnabled;
        if (DB_test_traceEnabled) then
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

player addAction [
    "<t color='#FF8C66'>DAMAGE: next target</t>",
    {
        call DB_damage_fnc_nextTarget;
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
    "<t color='#FFB366'>DAMAGE: fresh target</t>",
    {
        [DB_damage_targetIndex] call DB_damage_fnc_spawnTarget;
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
    "<t color='#FFD27F'>DAMAGE: copy report</t>",
    {
        call DB_damage_fnc_reportTarget;
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
    "<t color='#FFDF66'>DAMAGE: automatic 10-shot batch</t>",
    {
        [] spawn DB_damage_fnc_runBatch;
    },
    nil,
    1.5,
    false,
    true,
    "",
    "!DB_damage_batchRunning",
    5
];

[] spawn
{
    waitUntil
    {
        uiSleep 0.1;
        !isNull findDisplay 46
    };

    DB_damage_keyHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_display", "_key", "_shift", "_ctrl", "_alt"];

        if (!_shift || {!_ctrl} || {_alt}) exitWith {false};
        if (DB_damage_batchRunning) exitWith {true};

        if (_key == 32) exitWith
        {
            call DB_test_fnc_nextDistance;
            true
        };

        if (_key == 20) exitWith
        {
            call DB_damage_fnc_nextTarget;
            true
        };

        if (_key == 19) exitWith
        {
            [DB_damage_targetIndex] call DB_damage_fnc_spawnTarget;
            true
        };

        if (_key == 46) exitWith
        {
            call DB_damage_fnc_reportTarget;
            true
        };

        if (_key == 48) exitWith
        {
            [] spawn DB_damage_fnc_runBatch;
            true
        };

        false
    }];
};

[DB_test_distance] call DB_test_fnc_setDistance;

systemChat "Mnogotochie test ready. Ammunition and weapons are in the crate.";
systemChat "Shortcuts: Ctrl+Shift+D distance | T target | R fresh | C report | B automatic batch.";
