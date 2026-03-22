/*
	Sting: create OSD interface.
	Purpose: creates the UI layer and starts battery, telemetry and time handlers.
	Context: client when entering FPV control.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

SETMVAR(DB_sting_pendingCleanupToken, -1);

private _layer = ("DB_STING_Layer" call BIS_fnc_rscLayer);
_layer cutRsc ["Sting_Dialog", "PLAIN"];

SETMVAR(DB_STING_Layer_ID, _layer);

call DB_fnc_sting_handleSettings;
call DB_fnc_sting_handleBattery;
call DB_fnc_sting_handleSignal;
call DB_fnc_sting_handleTime;
