if (isServer) then {
    ["orlan_tripod_launcher_OPF", "init", {
        _this spawn orlan_fnc_initializeTripod;
    }] call CBA_fnc_addClassEventHandler;

    ["orlan_tripod_launcher_OPF", "killed", {
        private _tripod = _this # 0;

        detach (_tripod getVariable ['proxy', objNull]); 
        (_tripod getVariable ['proxy', objNull]) setVelocity [1, 2, 1];
    }] call CBA_fnc_addClassEventHandler;

    ["orlan_tripod_launcher_OPF", "deleted", {
        private _tripod = _this # 0;

        deleteVehicle (_tripod getVariable ['proxy', objNull]);
    }] call CBA_fnc_addClassEventHandler;

    // MP Fix added by Nerexis https://discordapp.com/invite/s7BMSjp
    ["orlan_tripod_launcher_OPF", "GetIn", {
        params ["_vehicle", "_role", "_unit", "_turret"];
		private _fName = "orlan_getInEH: ";
        
        diag_log format[_fName + "enter"];
        private _drone = _vehicle getVariable["proxy",objNull];	
        _drone setOwner (owner _unit);
        (group _drone) setGroupOwner (owner _unit);        

        diag_log format[_fName + "exit"];
    }] call CBA_fnc_addClassEventHandler;

};

["orlan_tripod_launcher_OPF", "fired", {
    _this spawn orlan_fnc_init_launcher_tripod;
}] call CBA_fnc_addClassEventHandler;