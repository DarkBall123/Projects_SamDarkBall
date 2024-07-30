[ 
    "Mavic_showInterface",
    "CHECKBOX",
    ["Show Interface", ""],
    "Mavic Settings",
    true,
    0,
    {}
] call CBA_fnc_addSetting; 

if ((hasInterface && isServer) || (serverCommandAvailable "#kick")) then {
    [ 
        "Mavic_windCoef",
        "SLIDER",
        ["Wind coefficient", ""],
        "Mavic Settings",
        [0.1/4, 0.2, 0.1/0.9, 2],
        1,
        { publicVariable "Mavic_windCoef" }
    ] call CBA_fnc_addSetting; 
};

["Mavic Drop", "MavicDropKey", "Mavic Drop Key", ["player", [], -100, "_this call mavic_fnc_checkUAVGrenadeDrop"], [35, [false, true, false]]] call cba_fnc_addKeybindToFleximenu;

