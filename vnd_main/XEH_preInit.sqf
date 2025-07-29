if ((hasInterface && isServer) || (serverCommandAvailable "#kick")) then {
    [
        "vnd_allowBotsShoot",                              // setting variable
        "CHECKBOX",                                        // control type
        ["Allow Bots to Engage Drone",                     // label
         "If enabled, AI units may fire on the drone"],    // tooltip
        "Fiber-Optic FPV",                                 // category
        true,                                              // default = enabled
        1,                                                 // priority
        { publicVariable "vnd_allowBotsShoot" }            // publish to all
    ] call cba_settings_fnc_init;
};

[
    "vnd_showHorizon",                                 // setting variable
    "CHECKBOX",                                        // control type
    ["Show Horizon Bar",                               // label
     "Toggle the display of the horizon stripe"],      // tooltip
    "Fiber-Optic FPV",                                 // category
    true,                                              // default = enabled
    2                                                  // priority
] call cba_settings_fnc_init;

[
    "vnd_showFiber",                                   // setting variable
    "CHECKBOX",                                        // control type
    ["Show Fiber-Optic Cable",                         // label
     "Toggle the display of the fiber‑optic cable"],   // tooltip
    "Fiber-Optic FPV",                                 // category
    true,                                              // default = enabled
    3                                                  // priority
] call cba_settings_fnc_init;

["vnd_fiberTTL", "SLIDER",   ["Dead‑fiber lifetime (s)",   "0 = disabled"], "Fiber-Optic FPV", [0, 120, 60, 0], 0] call CBA_fnc_addSetting;


missionNamespace setVariable ["DB_vnd_fpv_dronesArray", [ 
    "O_KVN_AT",      "O_KVN_AP",
    "O_KVN_AT_TI",   "O_KVN_AP_TI",
    "B_KVN_AT",      "B_KVN_AP",
    "B_KVN_AT_TI",   "B_KVN_AP_TI",
    "I_KVN_AT",      "I_KVN_AP",
    "I_KVN_AT_TI",   "I_KVN_AP_TI"
]];