if ((hasInterface && isServer) || (serverCommandAvailable "#kick")) then {
    [
        "DB_Jammer_maxJamDistance", 
        "SLIDER",   
        ["Jamming Range Limit", ""], 
        "Jammer Settings", 
        [300, 3000, 600, 0],
        1,
        { publicVariable "DB_Jammer_maxJamDistance" }
    ] call cba_settings_fnc_init;
};



