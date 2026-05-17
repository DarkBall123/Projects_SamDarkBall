/*
    Drone Backpack Auto Assignment
    FULL DEBUG VERSION

    Работает только на сервере
    Выдаёт 1 случайный дрон-рюкзак одной AI-группе

    Условия:
    - Только AI
    - Не civilian
    - Минимум 4 юнита
    - Никто не в технике
    - В группе ещё нет дрона
*/

if (!isServer) exitWith {};

systemChat "[DRONE SCRIPT] Script started";
diag_log "[DRONE SCRIPT] Script started";

[] spawn {

    private _perGroup = {

        params ["_group"];

        systemChat format [
            "[DRONE SCRIPT] Checking group: %1",
            _group
        ];

        // Проверка группы
        if (isNull _group) exitWith {
            systemChat "[DRONE SCRIPT] NULL group";
        };

        private _units = units _group;

        if ((count _units) == 0) exitWith {
            systemChat "[DRONE SCRIPT] Empty group";
        };

        // Уже выдавали
        if (_group getVariable ["_drone_already_added", false]) exitWith {
            systemChat "[DRONE SCRIPT] Drone already added";
        };

        // Сторона
        private _side = side _group;

        systemChat format [
            "[DRONE SCRIPT] Side: %1",
            _side
        ];

        // Только основные стороны
        if !(_side in [west, east, resistance]) exitWith {
            systemChat "[DRONE SCRIPT] Invalid side";
        };

        // Минимум 4 юнита
        if ((count _units) < 4) exitWith {
            systemChat "[DRONE SCRIPT] Not enough units";
        };

        // Массивы дронов
        private _opforDrones = [
            "O_Crocus_AP_Bag",
            "O_Crocus_AT_Bag",
            "O_KVN_AP_Bag",
            "O_KVN_AT_Bag"
        ];

        private _indDrones = [
            "I_Crocus_AP_Bag",
            "I_Crocus_AT_Bag",
            "I_KVN_AP_Bag",
            "I_KVN_AT_Bag"
        ];

        private _blueforDrones = [
            "B_Crocus_AP_Bag",
            "B_Crocus_AT_Bag",
            "B_KVN_AP_Bag",
            "B_KVN_AT_Bag"
        ];

        // Выбор стороны
        private _sideDrones = switch (_side) do {

            case west: {
                systemChat "[DRONE SCRIPT] WEST";
                _blueforDrones
            };

            case east: {
                systemChat "[DRONE SCRIPT] EAST";
                _opforDrones
            };

            case resistance: {
                systemChat "[DRONE SCRIPT] RESISTANCE";
                _indDrones
            };

            default {
                []
            };
        };

        if ((count _sideDrones) == 0) exitWith {
            systemChat "[DRONE SCRIPT] No drones for side";
        };

        private _unitsWithoutBackpack = [];
        private _hasDrone = false;
        private _hasVehicleCrew = false;

        {
            private _unit = _x;

            systemChat format [
                "[DRONE SCRIPT] Unit: %1",
                name _unit
            ];

            // Игрок
            if (isPlayer _unit) then {

                systemChat format [
                    "[DRONE SCRIPT] %1 is player",
                    name _unit
                ];

                continueWith {};
            };

            // Мёртвый
            if !(alive _unit) then {

                systemChat format [
                    "[DRONE SCRIPT] %1 dead",
                    name _unit
                ];

                continueWith {};
            };

            // В технике
            if (vehicle _unit != _unit) then {

                systemChat format [
                    "[DRONE SCRIPT] %1 in vehicle",
                    name _unit
                ];

                if (_unit in crew (vehicle _unit)) then {
                    _hasVehicleCrew = true;
                };

                continueWith {};
            };

            // Рюкзак
            private _backpack = backpack _unit;

            systemChat format [
                "[DRONE SCRIPT] %1 backpack: %2",
                name _unit,
                _backpack
            ];

            // Без рюкзака
            if (_backpack == "") then {

                _unitsWithoutBackpack pushBack _unit;

                systemChat format [
                    "[DRONE SCRIPT] %1 added as candidate",
                    name _unit
                ];

            } else {

                // Проверка на дрон
                if (_backpack in _sideDrones) then {

                    _hasDrone = true;

                    systemChat format [
                        "[DRONE SCRIPT] %1 already has drone",
                        name _unit
                    ];
                };
            };

        } forEach _units;

        // Уже есть дрон
        if (_hasDrone) exitWith {
            systemChat "[DRONE SCRIPT] Group already has drone";
        };

        // Кто-то в технике
        if (_hasVehicleCrew) exitWith {
            systemChat "[DRONE SCRIPT] Vehicle crew detected";
        };

        // Нет кандидатов
        if ((count _unitsWithoutBackpack) == 0) exitWith {
            systemChat "[DRONE SCRIPT] No free units";
        };

        systemChat format [
            "[DRONE SCRIPT] Candidates: %1",
            count _unitsWithoutBackpack
        ];

        // Выбор юнита
        private _chosenUnit = selectRandom _unitsWithoutBackpack;

        if (isNull _chosenUnit) exitWith {
            systemChat "[DRONE SCRIPT] Chosen unit NULL";
        };

        systemChat format [
            "[DRONE SCRIPT] Chosen unit: %1",
            name _chosenUnit
        ];

        // Выбор дрона
        private _chosenDrone = selectRandom _sideDrones;

        systemChat format [
            "[DRONE SCRIPT] Chosen drone: %1",
            _chosenDrone
        ];

        // Выдача
        _chosenUnit addBackpack _chosenDrone;

        systemChat format [
            "[DRONE SCRIPT] SUCCESS -> %1 received %2",
            name _chosenUnit,
            _chosenDrone
        ];

        diag_log format [
            "[DRONE SCRIPT] SUCCESS -> %1 received %2",
            name _chosenUnit,
            _chosenDrone
        ];

        // Помечаем группу
        _group setVariable ["_drone_already_added", true];
    };

    while {true} do {

        systemChat "[DRONE SCRIPT] Loop tick";
        diag_log "[DRONE SCRIPT] Loop tick";

        {
            [_x] call _perGroup;
        } forEach allGroups;

        sleep 60;
    };
};