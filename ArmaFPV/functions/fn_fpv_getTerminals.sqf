if (isNil { missionNamespace getVariable "DB_fpv_uavTerminals" }) then {
    missionNamespace setVariable ["DB_fpv_uavTerminals", [
        "B_UavTerminal",
        "O_UavTerminal",
        "I_UavTerminal"
    ]];
};

missionNamespace getVariable "DB_fpv_uavTerminals";
