[] spawn {
    sleep 5;

    while { True } do {
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
        private _lastSoundTime = missionNamespace getVariable ["DB_ghost_lastSoundTime", -21];


        if ((typeOf (vehicle _player) in ["ghost_M_OPF", "ghost_M_BLU_F", "ghost_M_IND_F"]) && { isEngineOn (vehicle _player) }) then {
            if ((time - _lastSoundTime >= 21) and ((random 1.0) < 0.3)) then {
	    		_player say3D (selectRandom ["Cough_1", "Cough_2", "Cough_3"]);

                missionNamespace setVariable ["DB_ghost_lastSoundTime", time];
            };
        };


        sleep 0.1;
    };
};