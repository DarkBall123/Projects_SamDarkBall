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


private _kvnPayloads = ["AT", "AP", "AT_TI", "AP_TI"];
private _kvnRangeSuffixes = ["", "_20KM", "_25KM"];
private _kvnSidePrefixes = ["O", "B", "I"];

private _kvnDroneClasses = [];
{
    private _sidePrefix = _x;
    {
        private _payload = _x;
        {
            _kvnDroneClasses pushBack format ["frtz_%1_KVN_%2%3", _sidePrefix, _payload, _x];
        } forEach _kvnRangeSuffixes;
    } forEach _kvnPayloads;
} forEach _kvnSidePrefixes;

private _kvnDroneItems = [];
{
    private _payload = _x;
    {
        _kvnDroneItems pushBack format ["frtz_Item_KVN_%1%2", _payload, _x];
    } forEach _kvnRangeSuffixes;
} forEach _kvnPayloads;

missionNamespace setVariable ["DB_kvn_fpv_dronesArray", _kvnDroneClasses];
missionNamespace setVariable ["DB_kvn_fpv_dronesArray_items", _kvnDroneItems];
