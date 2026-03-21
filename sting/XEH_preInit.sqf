/*
	Sting: PreInit and base settings.
	Purpose: registers CBA settings and shared module constants.
	Context: runs on all machines during preInit.
*/

#include "\sting\script_macros.hpp"

if (isNil "DB_sting_droneTypes") then {
	DB_sting_droneTypes = STING_DRONE_TYPES;
};

if (isNil "DB_sting_dronesArray_items") then {
	DB_sting_dronesArray_items = STING_DRONE_ITEMS;
};

if (isNil "DB_sting_terminalTypes") then {
	DB_sting_terminalTypes = STING_TERMINAL_TYPES;
};

if (isNil "DB_sting_signalLossThreshold") then {
	DB_sting_signalLossThreshold = STING_SIGNAL_LOSS_THRESHOLD;
};

if (isNil "DB_sting_signalLossDuration") then {
	DB_sting_signalLossDuration = STING_SIGNAL_LOSS_DURATION;
};

if (isNil "DB_sting_signalUpdateInterval") then {
	DB_sting_signalUpdateInterval = STING_SIGNAL_UPDATE_INTERVAL;
};

if (isNil "DB_sting_connectLoopInterval") then {
	DB_sting_connectLoopInterval = STING_CONNECT_LOOP_INTERVAL;
};

[ 
    "STING_DefaultText",
    "EDITBOX",
    ["Default Text", "Enter the text"],
    "Sting Settings",
    "STING",
    0,
    { call DB_fnc_sting_handleSettings }
] call cba_settings_fnc_init;

private _fnc_registerAdminSettings = {
	if (GETMVAR(DB_sting_adminSettingsRegistered, false)) exitWith {};
	SETMVAR(DB_sting_adminSettingsRegistered, true);

	[
		"STING_isUavCaptive",
		"CHECKBOX",
		["AI Cannot See FPV Drones", ""],
		"Sting Settings",
		true,
		1,
		{
			publicVariable "STING_isUavCaptive";
			call DB_fnc_sting_handleSettings;
		}
	] call cba_settings_fnc_init;

	[
		"STING_MaxFlightDistance",
		"SLIDER",
		["Max Flight Distance", ""],
		"Sting Settings",
		[1500, 12000, 4000, 0],
		1,
		{ publicVariable "STING_MaxFlightDistance" }
	] call cba_settings_fnc_init;

};

SETMVAR(DB_sting_registerAdminSettings, _fnc_registerAdminSettings);

if (hasInterface) then {
	if (isServer || { serverCommandAvailable "#kick" }) then {
		call _fnc_registerAdminSettings;
	} else {
		// Defer admin registration to postInit (CBA is not guaranteed in preInit).
	};
};
