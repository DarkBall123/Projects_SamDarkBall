if (hasInterface) then {
    if (isNil "vnd_fiberEH") then {
        vnd_fiberEH = addMissionEventHandler [
            "Draw3D",
            { [] call DB_vnd_fnc_fpv_fiberTick }
        ];
    };
};
