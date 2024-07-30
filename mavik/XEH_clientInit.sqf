// FORCE LOAD IF ACE
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then { 
    private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
    
	private _id = _player addEventHandler ["Put", { _this call mavic_fnc_createMavicOnItemCheck }];
	_player setVariable ["DB_playerPutID", _id];
};

["loadout", {
    params ["_player"];

	private _id = _player getVariable ["DB_playerPutID", -1];

	if (_id != -1) then { _player removeEventHandler ["Put", _id] };
    if !(isPlayer _player) exitWith {};

	private _id = _player addEventHandler ["Put", { _this call mavic_fnc_createMavicOnItemCheck }];
	_player setVariable ["DB_playerPutID", _id];
}] call CBA_fnc_addPlayerEventHandler;

[missionNamespace, "DB_mavic_showMessage", {
	//if !(isClass(configFile >> "CfgPatches" >> "DB_D37_scripts_mavick_vogs")) exitWith {};
	
	private _group = uiNameSpace getVariable ["DB_DetachGrenade_group", controlNull];

	if !(ctrlShown _group) exitWith {};

	private _controls = (allControls _group) + [_group];

	{
		_x ctrlSetFade 0;
		_x ctrlCommit 0.5;
	} forEach _controls;

	playSound "Mavic_Beep";

	[{
		_this params ["_controls"];

		{
			_x ctrlSetFade 1;
			_x ctrlCommit 0.0;
		} forEach _controls;
	}, [_controls], 1.5] call CBA_fnc_waitAndExecute;
}] call BIS_fnc_addScriptedEventHandler;