[
    {
        missionNamespace getVariable ["DB_DS_settingsRegistered", false]
    },
    {
        if (isServer) then
        {
            call DB_DS_fnc_serverLoop;
        };

        if (hasInterface) then
        {
            call DB_DS_fnc_clientInit;
        };
    },
    []
] call CBA_fnc_waitUntilAndExecute;
