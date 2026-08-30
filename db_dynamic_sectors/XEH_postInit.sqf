if (missionNamespace getVariable ["DB_DS_settingsRegistered", false]) exitWith {};
missionNamespace setVariable ["DB_DS_settingsRegistered", true];

[
    "DB_DS_gridSizeOverride",
    "SLIDER",
    ["Grid Size Override", "0 = automatic choice based on map size. Applied on next mission start."],
    "Dynamic Sector Zones",
    [0, 2000, 0, 0],
    1,
    { publicVariable "DB_DS_gridSizeOverride"; }
] call CBA_fnc_addSetting;

[
    "DB_DS_updateInterval",
    "SLIDER",
    ["Update Interval", "Seconds between server-side sector recalculations."],
    "Dynamic Sector Zones",
    [1, 30, 5, 0],
    1,
    { publicVariable "DB_DS_updateInterval"; }
] call CBA_fnc_addSetting;
