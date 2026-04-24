call DZ_fnc_controlParams;
call DZ_fnc_initServer;

// Start bundled civilian ambience scripts on the server.
call compile preprocessFileLineNumbers "Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "Alfa\Traffic\Init.sqf";
call compile preprocessFileLineNumbers 'scripts\spawnAmbientCars.sqf';

[] execVM "spawn_forest.sqf";