private _definitions = createHashMap;

private _register =
{
    params ["_id", "_definition"];

    _definition set ["id", _id];
    _definitions set [_id, _definition];
};

[
    "interdiction",
    createHashMapFromArray
    [
        ["title", "Атака на конвой"],
        ["description", "Уничтожить вражеский конвой снабжения до прибытия в пункт назначения."],
        ["startFunction", "DZ_fnc_startInterdictionMission"],
        ["implemented", true],
        ["manualEnabled", true],
        ["randomEnabled", true],
        ["weight", 1],
        ["cooldown", 0]
    ]
] call _register;

[
    "assassination",
    createHashMapFromArray
    [
        ["title", "Убить офицера"],
        ["description", "Зарезервировано под сценарий ликвидации приоритетной цели."],
        ["startFunction", ""],
        ["implemented", false],
        ["manualEnabled", true],
        ["randomEnabled", false],
        ["weight", 1],
        ["cooldown", 1800]
    ]
] call _register;

[
    "downed_pilot",
    createHashMapFromArray
    [
        ["title", "Спасти пилота"],
        ["description", "Зарезервировано под сценарий поиска и эвакуации сбитого пилота."],
        ["startFunction", ""],
        ["implemented", false],
        ["manualEnabled", true],
        ["randomEnabled", false],
        ["weight", 1],
        ["cooldown", 1800]
    ]
] call _register;

_definitions
