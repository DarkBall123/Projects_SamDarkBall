[{
    private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
    private _uav = getConnectedUAV _player;

    isNull (laserTarget _uav);
}, {
    deleteVehicle (missionNamespace getVariable ["DB_orlanFS_rocket", objNull]);
}, []] call CBA_fnc_waitUntilAndExecute;