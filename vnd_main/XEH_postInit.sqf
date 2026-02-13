#include "\vnd_main\script_macros.hpp"

if (hasInterface) then {
    private _legacyEh = GETMVAR(vnd_fiberEH, -1);
    if (_legacyEh >= 0) then {
        removeMissionEventHandler ["Draw3D", _legacyEh];
        SETMVAR(vnd_fiberEH, -1);
    };

    private _fiberPfh = GETMVAR(vnd_fiberPFH, -1);
    if (_fiberPfh < 0) then {
        _fiberPfh = [
            { [] call DB_vnd_fnc_fpv_fiberTick },
            VND_FIBER_TICK_INTERVAL
        ] call CBA_fnc_addPerFrameHandler;
        SETMVAR(vnd_fiberPFH, _fiberPfh);
    };
};
