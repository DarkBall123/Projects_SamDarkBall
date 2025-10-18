if (isNil { missionNamespace getVariable "DB_fpv_droneClasses" }) then {
    missionNamespace setVariable ["DB_fpv_droneClasses", [
        "O_Crocus_AT",
        "O_Crocus_AP",
        "O_Crocus_AT_TI",
        "O_Crocus_AP_TI",
        "B_Crocus_AT",
        "B_Crocus_AP",
        "B_Crocus_AT_TI",
        "B_Crocus_AP_TI",
        "I_Crocus_AT",
        "I_Crocus_AP",
        "I_Crocus_AT_TI",
        "I_Crocus_AP_TI"
    ]];
};

missionNamespace getVariable "DB_fpv_droneClasses";
