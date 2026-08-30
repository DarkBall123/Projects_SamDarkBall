if ((hasInterface && isServer) || (serverCommandAvailable "#kick")) then {
    [
        "kvn_allowBotsShoot",                              // setting variable
        "CHECKBOX",                                        // control type
        ["Allow Bots to Engage Drone",                     // label
         "If enabled, AI units may fire on the drone"],    // tooltip
        "Fiber-Optic FPV",                                 // category
        true,                                              // default = enabled
        1,                                                 // priority
        { publicVariable "kvn_allowBotsShoot" }            // publish to all
    ] call cba_settings_fnc_init;
};

[
    "kvn_showHorizon",                                 // setting variable
    "CHECKBOX",                                        // control type
    ["Show Horizon Bar",                               // label
     "Toggle the display of the horizon stripe"],      // tooltip
    "Fiber-Optic FPV",                                 // category
    true,                                              // default = enabled
    2                                                  // priority
] call cba_settings_fnc_init;

[
    "kvn_showFiber",                                   // setting variable
    "CHECKBOX",                                        // control type
    ["Show Fiber-Optic Cable",                         // label
     "Toggle the display of the fiber‑optic cable"],   // tooltip
    "Fiber-Optic FPV",                                 // category
    true,                                              // default = enabled
    3                                                  // priority
] call cba_settings_fnc_init;

["kvn_fiberTTL", "SLIDER",   ["Dead‑fiber lifetime (s)",   "0 = disabled"], "Fiber-Optic FPV", [0, 120, 20, 0], 0] call CBA_fnc_addSetting;


missionNamespace setVariable ["DB_kvn_fpv_dronesArray", [ 
    "frtz_O_KVN_AT",      "frtz_O_KVN_AP",
    "frtz_O_KVN_AT_TI",   "frtz_O_KVN_AP_TI",
    "frtz_B_KVN_AT",      "frtz_B_KVN_AP",
    "frtz_B_KVN_AT_TI",   "frtz_B_KVN_AP_TI",
    "frtz_I_KVN_AT",      "frtz_I_KVN_AP",
    "frtz_I_KVN_AT_TI",   "frtz_I_KVN_AP_TI"
]];

missionNamespace setVariable ["DB_kvn_fpv_dronesArray_items", [ 
    "frtz_Item_KVN_AT", "frtz_Item_KVN_AT_TI",
    "frtz_Item_KVN_AP", "frtz_Item_KVN_AP_TI"
]];
