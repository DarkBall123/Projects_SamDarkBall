if (!hasInterface) exitWith {};

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\sting\script_macros.hpp"

private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
if (!isNull _player) then {
	private _id = _player addEventHandler ["Put", { _this call DB_fnc_sting_createUavOnItemCheck }];
	_player setVariable ["DB_sting_playerPutID", _id];
};

call DB_fnc_sting_handleConnect;

if (!GETMVAR(DB_sting_airburstKeybindRegistered, false)) then {
	SETMVAR(DB_sting_airburstKeybindRegistered, true);

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

["loadout", {
	params ["_player"];

	private _oldId = _player getVariable ["DB_sting_playerPutID", -1];
	if (_oldId != -1) then { _player removeEventHandler ["Put", _oldId]; };
	if !(isPlayer _player) exitWith {};

	private _newId = _player addEventHandler ["Put", { _this call DB_fnc_sting_createUavOnItemCheck }];
	_player setVariable ["DB_sting_playerPutID", _newId];
}] call CBA_fnc_addPlayerEventHandler;
