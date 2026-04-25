if (hasInterface) then {
    if (isNil "kvn_fiberEH") then {
        kvn_fiberEH = addMissionEventHandler [
            "Draw3D",
            { [] call DB_kvn_fnc_fpv_fiberTick }
        ];
    };
};

if (isClass(configFile >> "CfgPatches" >> "ace_main")) then { 
    private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
    
	private _id = _player addEventHandler ["Put", { _this call DB_kvn_fnc_fpv_createKVNOnItemCheck }];
	_player setVariable ["DB_playerPutID", _id];
};

["loadout", {
    params ["_player"];

	private _id = _player getVariable ["DB_playerPutID", -1];

	if (_id != -1) then { _player removeEventHandler ["Put", _id] };
    if !(isPlayer _player) exitWith {};

	private _id = _player addEventHandler ["Put", { _this call DB_kvn_fnc_fpv_createKVNOnItemCheck }];
	_player setVariable ["DB_playerPutID", _id];
}] call CBA_fnc_addPlayerEventHandler;