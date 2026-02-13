#define FIBER_TICK_INTERVAL 0.05

if (hasInterface) then {
    if !(isNil "vnd_fiberEH") then {
        removeMissionEventHandler ["Draw3D", vnd_fiberEH];
        vnd_fiberEH = nil;
    };

    if (isNil "vnd_fiberPFH") then {
        vnd_fiberPFH = -1;
    };

    if (vnd_fiberPFH < 0) then {
        vnd_fiberPFH = [
            { [] call DB_vnd_fnc_fpv_fiberTick },
            FIBER_TICK_INTERVAL
        ] call CBA_fnc_addPerFrameHandler;
    };
};
