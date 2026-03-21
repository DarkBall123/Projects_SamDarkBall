if (!hasInterface) exitWith {};

#include "\sting\script_macros.hpp"

private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
if (!isNull _player) then {
	private _id = _player addEventHandler ["Put", { _this call DB_fnc_sting_createUavOnItemCheck }];
	_player setVariable ["DB_sting_playerPutID", _id];
};

call DB_fnc_sting_handleConnect;

["loadout", {
	params ["_player"];

	private _oldId = _player getVariable ["DB_sting_playerPutID", -1];
	if (_oldId != -1) then { _player removeEventHandler ["Put", _oldId]; };
	if !(isPlayer _player) exitWith {};

	private _newId = _player addEventHandler ["Put", { _this call DB_fnc_sting_createUavOnItemCheck }];
	_player setVariable ["DB_sting_playerPutID", _newId];
}] call CBA_fnc_addPlayerEventHandler;

if (hasInterface && {!isServer}) then {
	[
		{ !hasInterface || serverCommandAvailable "#kick" },
		{
			if (!hasInterface) exitWith {};
			private _register = GETMVAR(DB_sting_registerAdminSettings, {});
			call _register;
		}
	] call CBA_fnc_waitUntilAndExecute;
};
