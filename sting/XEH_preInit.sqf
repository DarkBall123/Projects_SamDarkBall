/*
	Sting: PreInit and base settings.
	Purpose: registers shared module constants.
	Context: runs on all machines during preInit.
*/

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
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

if (isNil "DB_sting_connectLoopInterval") then {
	DB_sting_connectLoopInterval = STING_CONNECT_LOOP_INTERVAL;
};

if (hasInterface) then {
	[
		["Sting", "Controls"],
		"StingAirburst",
		["Airburst Detonation", "Detonate the actively controlled Sting drone in flight. Assign the key in CBA keybindings."],
		{
			call DB_fnc_sting_triggerAirburst;
		},
		"",
		[DIK_SPACE, [false, false, false]]
	] call CBA_fnc_addKeybind;
};
