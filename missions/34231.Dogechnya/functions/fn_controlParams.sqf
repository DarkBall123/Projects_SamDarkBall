params [["_eps", 100]];

private _gridSize = 350;
private _zoneTemplate = [false, [[], []], -1, 0, false, -1, false, false, -1, -1];
private _enemyGroupRoot = configNull;
private _defaultEnemyUnitClass = "b_afougf_teamleader_gp25";
private _uavOperatorClasses = ["b_ngu_sergeant_gp25"];
private _uavOperatorBackpacks = ["B_Crocus_AP_Bag", "B_Crocus_AT_Bag"];
private _respawnPoints =
[
    ["База", [8860.52,10093.9,0]]
];

/*
    Supported group formats inside spawn pools:
    1. "CfgGroupsName"
    2. ["unit_a", "unit_b", ...]
    3. createHashMapFromArray
       [
           ["count", [4, 6]],
           ["required", ["leader_class"]],
           ["pool", [["rifleman_class", 1.0], ["medic_class", 0.2]]],
           ["unique", false]
       ]
*/

private _urbanUnitPool =
[
    ["b_afougf_rifleman_gp25", 1.00],
    ["b_afougf_rifleman_ak74", 0.95],
    ["b_afougf_mg_pkm", 0.45],
    ["b_afougf_mg_ast", 0.30],
    ["b_afougf_mg_rpk74", 0.55],
    ["b_afougf_medic", 0.22],
    ["b_afougf_rifleman_rpg26", 0.30],
    ["b_afougf_marksman_svdm", 0.18],
    ["b_ngu_sergeant_gp25", 0.55],
    ["b_ngu_rifleman_gp25", 0.35],
    ["b_ngu_medic", 0.12],
    ["b_ngu_rifleman_rpg26", 0.20],
    ["b_ngu_mg_pkm", 0.18],
    ["b_ngu_mg_ast", 0.15]
];

private _openUnitPool =
[
    ["b_afougf_rifleman_ak74", 1.00],
    ["b_afougf_rifleman_gp25", 0.75],
    ["b_afougf_marksman_svdm", 0.35],
    ["b_afougf_pt_rpg7", 0.20],
    ["b_afougf_pt_ast", 0.15],
    ["b_afougf_rifleman_rpg26", 0.45],
    ["b_afougf_mg_rpk74", 0.45],
    ["b_afougf_mg_pkm", 0.32],
    ["b_afougf_medic", 0.16],
    ["b_ngu_sergeant_gp25", 0.60],
    ["b_ngu_rifleman_gp25", 0.30],
    ["b_ngu_rifleman_rpg26", 0.22],
    ["b_ngu_medic", 0.10]
];

private _counterUnitPool =
[
    ["b_afougf_rifleman_gp25", 0.95],
    ["b_afougf_rifleman_ak74", 0.90],
    ["b_afougf_mg_pkm", 0.50],
    ["b_afougf_mg_ast", 0.28],
    ["b_afougf_mg_rpk74", 0.50],
    ["b_afougf_medic", 0.18],
    ["b_afougf_rifleman_rpg26", 0.36],
    ["b_afougf_pt_rpg7", 0.16],
    ["b_afougf_pt_ast", 0.12],
    ["b_afougf_marksman_svdm", 0.22],
    ["b_ngu_sergeant_gp25", 0.75],
    ["b_ngu_rifleman_gp25", 0.25],
    ["b_ngu_rifleman_rpg26", 0.25],
    ["b_ngu_medic", 0.08],
    ["b_ngu_mg_pkm", 0.12],
    ["b_ngu_mg_ast", 0.10]
];

private _urbanFixedSquads =
[
    [["b_ngu_sergeant_gp25"], 0.35],
    [["b_ngu_sergeant_gp25", "b_ngu_rifleman_gp25"], 0.50],
    [["b_afougf_teamleader_gp25", "b_afougf_rifleman_gp25", "b_afougf_mg_pkm", "b_afougf_mg_ast"], 1.00],
    [["b_afougf_sergeant_gp25", "b_afougf_rifleman_ak74", "b_afougf_mg_rpk74", "b_afougf_rifleman_rpg26"], 0.95],
    [["b_afougf_teamleader_gp25", "b_afougf_rifleman_ak74", "b_afougf_mg_rpk74", "b_afougf_rifleman_rpg26"], 0.90],
    [["b_ngu_teamleader_gp25", "b_ngu_rifleman_gp25", "b_ngu_medic", "b_ngu_rifleman_rpg26"], 0.80],
    [["b_ngu_teamleader_gp25", "b_ngu_mg_pkm", "b_ngu_mg_ast", "b_ngu_mg_ast"], 0.55]
];

private _openFixedSquads =
[
    [["b_ngu_sergeant_gp25"], 0.45],
    [["b_ngu_sergeant_gp25", "b_ngu_rifleman_gp25"], 0.55],
    [["b_afougf_teamleader_gp25", "b_afougf_marksman_svdm", "b_afougf_pt_rpg7", "b_afougf_pt_ast"], 0.70],
    [["b_afougf_sergeant_gp25", "b_afougf_rifleman_ak74", "b_afougf_mg_rpk74", "b_afougf_rifleman_rpg26"], 0.90],
    [["b_afougf_teamleader_gp25", "b_afougf_rifleman_ak74", "b_afougf_mg_rpk74", "b_afougf_rifleman_rpg26"], 0.85],
    [["b_ngu_teamleader_gp25", "b_ngu_rifleman_gp25", "b_ngu_medic", "b_ngu_rifleman_rpg26"], 0.70]
];

private _counterFixedSquads =
[
    [["b_ngu_sergeant_gp25"], 0.55],
    [["b_ngu_sergeant_gp25", "b_ngu_rifleman_gp25", "b_ngu_rifleman_rpg26"], 0.65],
    [["b_afougf_teamleader_gp25", "b_afougf_marksman_svdm", "b_afougf_pt_rpg7", "b_afougf_pt_ast"], 0.55],
    [["b_afougf_teamleader_gp25", "b_afougf_rifleman_gp25", "b_afougf_mg_pkm", "b_afougf_mg_ast"], 0.95],
    [["b_afougf_sergeant_gp25", "b_afougf_rifleman_ak74", "b_afougf_mg_rpk74", "b_afougf_rifleman_rpg26"], 0.90],
    [["b_ngu_teamleader_gp25", "b_ngu_rifleman_gp25", "b_ngu_medic", "b_ngu_rifleman_rpg26"], 0.65]
];

private _urbanRandomSquads =
[
    [
        createHashMapFromArray
        [
            ["count", [5, 6]],
            ["required", ["b_afougf_teamleader_gp25", "b_afougf_rifleman_gp25"]],
            ["pool", _urbanUnitPool]
        ],
        0.80
    ],
    [
        createHashMapFromArray
        [
            ["count", [4, 5]],
            ["required", ["b_afougf_sergeant_gp25"]],
            ["pool", _urbanUnitPool]
        ],
        0.55
    ],
    [
        createHashMapFromArray
        [
            ["count", [4, 5]],
            ["required", ["b_ngu_sergeant_gp25"]],
            ["pool", _urbanUnitPool]
        ],
        0.40
    ]
];

private _openRandomSquads =
[
    [
        createHashMapFromArray
        [
            ["count", [3, 4]],
            ["required", ["b_afougf_teamleader_gp25"]],
            ["pool", _openUnitPool]
        ],
        0.80
    ],
    [
        createHashMapFromArray
        [
            ["count", [4, 5]],
            ["required", ["b_afougf_sergeant_gp25", "b_afougf_rifleman_rpg26"]],
            ["pool", _openUnitPool]
        ],
        0.55
    ],
    [
        createHashMapFromArray
        [
            ["count", [4, 4]],
            ["required", ["b_ngu_sergeant_gp25", "b_ngu_rifleman_rpg26"]],
            ["pool", _openUnitPool]
        ],
        0.35
    ]
];

private _counterRandomSquads =
[
    [
        createHashMapFromArray
        [
            ["count", [5, 7]],
            ["required", ["b_afougf_teamleader_gp25", "b_afougf_mg_pkm"]],
            ["pool", _counterUnitPool]
        ],
        0.80
    ],
    [
        createHashMapFromArray
        [
            ["count", [4, 6]],
            ["required", ["b_afougf_sergeant_gp25", "b_afougf_rifleman_rpg26"]],
            ["pool", _counterUnitPool]
        ],
        0.60
    ],
    [
        createHashMapFromArray
        [
            ["count", [4, 5]],
            ["required", ["b_ngu_sergeant_gp25"]],
            ["pool", _counterUnitPool]
        ],
        0.35
    ]
];

private _urbanSquads = _urbanFixedSquads + _urbanRandomSquads;
private _openSquads = _openFixedSquads + _openRandomSquads;
private _counterSquads = _counterFixedSquads + _counterRandomSquads;

private _urbanPackages =
[
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25"], "b_afougf_m998_4dr"], 0.80],
    [[["b_afougf_teamleader_gp25", "b_afougf_rifleman_gp25", "b_afougf_rifleman_ak74", "b_afougf_pt_rpg7", "b_afougf_mg_pkm", "b_afougf_pt_ast", "b_afougf_medic", "b_afougf_mg_ast"], "b_afougf_gaz66_truck"], 0.20],
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25", "b_afougf_rifleman_rpg26"], "b_afougf_bmd1"], 0.10],
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25", "b_afougf_rifleman_rpg26"], "b_afougf_bmp2"], 0.08]
];

private _openPackages =
[
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25"], "b_afougf_m998_4dr"], 0.60],
    [[["b_afougf_teamleader_gp25", "b_afougf_rifleman_gp25", "b_afougf_rifleman_ak74", "b_afougf_pt_rpg7", "b_afougf_mg_pkm", "b_afougf_pt_ast", "b_afougf_medic", "b_afougf_mg_ast"], "b_afougf_gaz66_truck"], 0.35],
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25", "b_afougf_rifleman_rpg26"], "b_afougf_bmd1"], 0.16],
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25", "b_afougf_rifleman_rpg26"], "b_afougf_bmp2"], 0.12]
];

private _counterPackages =
[
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25"], "b_afougf_m998_4dr"], 0.55],
    [[["b_afougf_teamleader_gp25", "b_afougf_rifleman_gp25", "b_afougf_rifleman_ak74", "b_afougf_pt_rpg7", "b_afougf_mg_pkm", "b_afougf_pt_ast", "b_afougf_medic", "b_afougf_mg_ast"], "b_afougf_gaz66_truck"], 0.32],
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25", "b_afougf_rifleman_rpg26"], "b_afougf_bmd1"], 0.18],
    [[["b_afougf_teamleader_gp25", "b_afougf_mg_pkm", "b_afougf_rifleman_gp25", "b_afougf_rifleman_rpg26"], "b_afougf_bmp2"], 0.14]
];

private _urbanVehiclePool =
[
    ["b_afougf_kozak5_turret_armored_F", 1.00],
    ["b_afougf_offroad_armored_01", 0.85],
    ["b_afougf_offroad_armored_at", 0.20],
    ["b_afougf_m1151_mk19_base", 0.30],
    ["b_afougf_m1152_base_dshkm", 0.38]
];

private _openVehiclePool =
[
    ["b_afougf_kozak5_turret_armored_F", 0.85],
    ["b_afougf_offroad_armored_01", 0.72],
    ["b_afougf_offroad_armored_at", 0.28],
    ["b_afougf_m1151_mk19_base", 0.26],
    ["b_afougf_m1152_base_dshkm", 0.32],
    ["b_afougf_btr80_common", 0.10],
    ["b_afougf_m113_unarmed", 0.08],
    ["b_afougf_BRDM2_HQ", 0.06],
    ["b_afougf_gaz66_zu23", 0.04],
    ["b_afougf_bmd1", 0.04],
    ["b_afougf_bmp2", 0.03]
];

private _counterVehiclePool =
[
    ["b_afougf_kozak5_turret_armored_F", 0.60],
    ["b_afougf_offroad_armored_01", 0.50],
    ["b_afougf_offroad_armored_at", 0.24],
    ["b_afougf_m1151_mk19_base", 0.24],
    ["b_afougf_m1152_base_dshkm", 0.28],
    ["b_afougf_btr80_common", 0.20],
    ["b_afougf_m113_unarmed", 0.16],
    ["b_afougf_BRDM2_HQ", 0.08],
    ["b_afougf_bmd1", 0.12],
    ["b_afougf_bmp2", 0.10],
    ["b_afougf_gaz66_zu23", 0.06],
    ["b_afougf_zsu234_aa", 0.03],
    ["RHS_M2A2_wd", 0.02],
    ["b_afougf_t72ba", 0.01],
    ["b_afougf_t80bv", 0.008],
    ["rhsusf_m1a1aimwd_usarmy", 0.004]
];

private _vehicleMeta = createHashMapFromArray
[
    ["b_afougf_bmp2", ["ifv"]],
    ["b_afougf_bmd1", ["ifv"]],
    ["RHS_M2A2_wd", ["ifv"]],
    ["b_afougf_m113_unarmed", ["apc"]],
    ["b_afougf_btr80_common", ["apc"]],
    ["b_afougf_BRDM2_HQ", ["recon"]],
    ["b_afougf_gaz66_zu23", ["aa"]],
    ["b_afougf_zsu234_aa", ["aa"]],
    ["b_afougf_t72ba", ["tank"]],
    ["b_afougf_t80bv", ["tank"]],
    ["rhsusf_m1a1aimwd_usarmy", ["tank"]],
    ["b_afougf_kozak5_turret_armored_F", ["mrap"]],
    ["b_afougf_offroad_armored_01", ["mrap"]],
    ["b_afougf_offroad_armored_at", ["mrap"]],
    ["b_afougf_m1151_mk19_base", ["mrap"]],
    ["b_afougf_m1152_base_dshkm", ["mrap"]],
    ["b_afougf_gaz66_truck", ["truck"]],
    ["b_afougf_m998_4dr", ["utility"]]
];

private _vehicleCategoryCaps = createHashMapFromArray
[
    ["tank", 1],
    ["ifv", 2],
    ["apc", 2],
    ["aa", 1],
    ["mrap", 4],
    ["truck", 2],
    ["utility", 2],
    ["recon", 2]
];

private _vehicleCategoryLocalCaps = createHashMapFromArray
[
    ["tank", 1],
    ["ifv", 1],
    ["apc", 1],
    ["aa", 1],
    ["mrap", 2],
    ["truck", 1],
    ["utility", 1],
    ["recon", 1]
];

private _spawnTaskConfigs = createHashMapFromArray
[
    [
        "urban_dense",
        createHashMapFromArray
        [
            ["groups", [[2, 3], _urbanSquads]],
            ["packages", [[0, 1], _urbanPackages]],
            ["vehicles", [[0, 1], _urbanVehiclePool]]
        ]
    ],
    [
        "urban_sparse",
        createHashMapFromArray
        [
            ["groups", [[1, 2], _urbanSquads]],
            ["packages", [[0, 1], _urbanPackages]],
            ["vehicles", [[0, 1], _urbanVehiclePool]]
        ]
    ],
    [
        "checkpoint_builtup",
        createHashMapFromArray
        [
            ["groups", [[1, 2], _urbanSquads]],
            ["packages", [[0, 1], _urbanPackages]],
            ["vehicles", [[0, 1], _urbanVehiclePool]]
        ]
    ],
    [
        "checkpoint_open",
        createHashMapFromArray
        [
            ["groups", [[1, 1], _openSquads]],
            ["packages", [[0, 1], _openPackages]],
            ["vehicles", [[0, 1], _openVehiclePool]]
        ]
    ],
    [
        "counterattack_urban",
        createHashMapFromArray
        [
            ["groups", [[2, 3], _counterSquads]],
            ["packages", [[0, 1], _urbanPackages]],
            ["vehicles", [[0, 1], _urbanVehiclePool]]
        ]
    ],
    [
        "counterattack_open",
        createHashMapFromArray
        [
            ["groups", [[1, 2], _counterSquads]],
            ["packages", [[0, 1], _counterPackages]],
            ["vehicles", [[0, 1], _counterVehiclePool]]
        ]
    ]
];

missionNamespace setVariable ["DZ_gridSize", _gridSize];
missionNamespace setVariable ["DZ_alpha", 0.35];
missionNamespace setVariable ["DZ_eps", _gridSize * 0.9];
missionNamespace setVariable ["DZ_preSpawnFactor", 1.5];
missionNamespace setVariable ["DZ_updateInterval", 1];
missionNamespace setVariable ["DZ_cleanupDelay", 30];
missionNamespace setVariable ["DZ_corpseCleanupInterval", 600];
missionNamespace setVariable ["DZ_enableCorpseCleanup", false];
missionNamespace setVariable ["DZ_enableLiveDespawn", false];
missionNamespace setVariable ["DZ_loadoutSaveInterval", 60];
missionNamespace setVariable ["DZ_respawnPoints", _respawnPoints];

missionNamespace setVariable ["DZ_cpChance", 0.0003];
missionNamespace setVariable ["CH_sideEnemy", west];
missionNamespace setVariable ["CH_sidePlayers", east];

missionNamespace setVariable ["DZ_captureHold", 60];
missionNamespace setVariable ["DZ_recaptureSpawnCooldown", 180];
missionNamespace setVariable ["DZ_spawnRetryCooldown", 30];
missionNamespace setVariable ["DZ_counterRepeatCooldown", 180];
missionNamespace setVariable ["DZ_counterRepeatChance", 0.35];
missionNamespace setVariable ["DZ_counterMaxActive", 2];
missionNamespace setVariable ["DZ_frontMinEnemyNeighbors", 2];

missionNamespace setVariable ["DZ_styleEnemyDormant", 0];
missionNamespace setVariable ["DZ_styleEnemyActive", 1];
missionNamespace setVariable ["DZ_stylePlayerOwned", 2];
missionNamespace setVariable ["DZ_styleContested", 3];

missionNamespace setVariable ["DZ_zoneStateTemplate", _zoneTemplate];
missionNamespace setVariable ["DZ_enemyGroupRoot", _enemyGroupRoot];
missionNamespace setVariable ["DZ_defaultEnemyUnitClass", _defaultEnemyUnitClass];
missionNamespace setVariable ["DZ_uavOperatorClasses", _uavOperatorClasses];
missionNamespace setVariable ["DZ_uavOperatorBackpacks", _uavOperatorBackpacks];
missionNamespace setVariable ["DZ_spawnTaskConfigs", _spawnTaskConfigs];
missionNamespace setVariable ["DZ_vehicleMeta", _vehicleMeta];
missionNamespace setVariable ["DZ_vehicleCategoryCaps", _vehicleCategoryCaps];
missionNamespace setVariable ["DZ_vehicleCategoryLocalCaps", _vehicleCategoryLocalCaps];
missionNamespace setVariable ["DZ_vehicleCategoryLocalRadius", _gridSize * 2.25];
