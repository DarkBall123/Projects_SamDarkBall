if ((hasInterface && isServer) || (serverCommandAvailable "#kick")) then
{
    [
        "DB_DS_gridSizeOverride",
        "SLIDER",
        ["Grid Size Override", "0 = automatic choice based on map size. Applied on next mission start."],
        "Dynamic Sector Zones",
        [0, 2000, 0, 0],
        0,
        { publicVariable "DB_DS_gridSizeOverride"; }
    ] call cba_settings_fnc_init;

    [
        "DB_DS_updateInterval",
        "SLIDER",
        ["Update Interval", "Seconds between server-side sector recalculations."],
        "Dynamic Sector Zones",
        [1, 30, 5, 0],
        1,
        { publicVariable "DB_DS_updateInterval"; }
    ] call cba_settings_fnc_init;
};
