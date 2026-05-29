params [
    ["_strikeData", [], [[]]],
    ["_settings", createHashMap, [createHashMap]]
];

if (!hasInterface) exitWith { false };

{
    [_x, _settings] spawn {
        params ["_entry", "_settings"];

        sleep (_entry getOrDefault ["delay", 0]);
        [_entry, _settings] call SDB_oreshnik_fnc_spawnStreak;
    };
} forEach _strikeData;

true;
