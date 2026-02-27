/*
	ArmaFPV: create OSD interface.
	Purpose: creates the UI layer and starts battery/signal/time handlers.
	Context: client when entering FPV control.
	Params: none.
	Returns: nothing.
*/

#include "\ArmaFPV\script_macros.hpp"

SETMVAR(DB_fpv_pendingCleanupToken, -1);
SETMVAR(DB_timeInJammerZone, 0);
SETMVAR(DB_fpv_ppfx_input, 1);
private _ppfxContext = [];
SETMVAR(DB_fpv_ppfx_context, _ppfxContext);
SETMVAR(DB_fpv_ppfx_prevQ, 1);
private _ppfxGlitch = [];
SETMVAR(DB_fpv_ppfx_glitch, _ppfxGlitch);

private _layer = ("DB_FPV_Layer" call BIS_fnc_rscLayer);
_layer cutRsc ["ArmaFPV_Dialog", "PLAIN"];

SETMVAR(DB_FPV_Layer_ID, _layer);

call DB_fnc_fpv_handleSettings;
call DB_fnc_fpv_handleBattery;
call DB_fnc_fpv_handleSignal;
call DB_fnc_fpv_handleTime;
