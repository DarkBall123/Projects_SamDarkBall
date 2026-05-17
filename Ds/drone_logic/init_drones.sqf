/*
    Drone Backpack Auto Assignment
    FULL DEBUG VERSION (REWORKED)

    Работает только на сервере
    Выдаёт дрон-рюкзак группе AI, если у неё его нет

    Условия:
    - Только AI
    - Не civilian
    - Минимум 4 юнита
    - Никто не в технике
    - Выдача возможна повторно при потере
*/

if (!isServer) exitWith {};

[] spawn {

    private _perGroup = {

        params ["_group"];

        // Проверка группы
        if (isNull _group) exitWith {};

        private _units = units _group;

        if ((count _units) == 0) exitWith {};

        // Сторона
        private _side = side _group;

        if !(_side in [west, east, resistance]) exitWith {};

        // Минимум 4 юнита
        if ((count _units) < 4) exitWith {};

        // Дроны по сторонам
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

        private _sideDrones = switch (_side) do {

            case west: {
                _blueforDrones
            };

            case east: {
                _opforDrones
            };

            case resistance: {
                _indDrones
            };

            default {
                []
            };
        };

        if ((count _sideDrones) == 0) exitWith {};

        private _unitsWithoutBackpack = [];
        private _hasDrone = false;
        private _hasVehicleCrew = false;

        {
            private _unit = _x;

            if (isPlayer _unit) then { continueWith {}; };
            if !(alive _unit) then { continueWith {}; };

            if (vehicle _unit != _unit) then {
                if (_unit in crew (vehicle _unit)) then {
                    _hasVehicleCrew = true;
                };
                continueWith {};
            };

            private _backpack = backpack _unit;

            // Уже есть дрон у группы → фиксируем и выходим
            if (_backpack in _sideDrones) exitWith {
                _hasDrone = true;
            };

            // кандидаты без рюкзака
            if (_backpack == "") then {

                _unitsWithoutBackpack pushBack _unit;
            };

        } forEach _units;

        // если уже есть дрон — ничего не делаем
        if (_hasDrone) exitWith {};

        // если кто-то в технике
        if (_hasVehicleCrew) exitWith {};

        // нет кандидатов
        if ((count _unitsWithoutBackpack) == 0) exitWith {};

        // выбор юнита
        private _chosenUnit = selectRandom _unitsWithoutBackpack;

        if (isNull _chosenUnit) exitWith {};

        // выбор дрона
        private _chosenDrone = selectRandom _sideDrones;

        // выдача
        _chosenUnit addBackpack _chosenDrone;
    };

    while {true} do {

        {
            [_x] call _perGroup;
        } forEach allGroups;

        sleep 60;
    };
};
