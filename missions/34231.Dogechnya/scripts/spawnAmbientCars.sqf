/*
    Ambient empty cars in specific RHS garages near players.
    Simple and intentionally strict: one car per garage, no random skip logic.
*/

if (!isServer) exitWith {};

[] spawn {
    waitUntil {time > 0};

    private _debug = false;

    private _vehicleTypes = [
        "C_Offroad_01_F",
        "C_Offroad_01_covered_F",
        "C_Kart_01_F",
        "C_Quadbike_01_F",
        "C_SUV_01_F"
    ];
    private _rareVehicleTypes = [
        "b_afougf_ngu_UAZ_AGS30_Base",
        "b_afougf_ngu_UAZ_SPG9_Base",
        "b_afougf_ngu_UAZ_DShKM_Base"
    ];

    private _garageTypes = [
        "Land_rhs_garage_type_01_red",
        "Land_rhs_garage_type_01_green",
        "Land_rhs_garage_type_01_blue",
        "Land_rhs_garage_type_01_gray",
        "Land_rhs_garage_brick_o1",
        "Land_rhs_garage_brick_o2"
    ];

    private _searchRadius = 900;
    private _despawnRadius = 900;
    private _minSpawnDistance = 25;
    private _maxSpawnDistance = 700;
    private _maxCarsPerPlayer = 7;
    private _managedCars = [];

    private _fnc_isUavVehicle = {
        params ["_vehicle"];

        if (isNull _vehicle) exitWith { false };

        (getNumber (configOf _vehicle >> "isUav")) > 0
    };

    private _fnc_getActivePlayers = {
        private _candidates = allPlayers;
        if (_candidates isEqualTo []) then {
            _candidates = call BIS_fnc_listPlayers;
        };
        if (_candidates isEqualTo []) then {
            _candidates = playableUnits;
        };

        _candidates select {
            alive _x
            && {isPlayer _x}
            && {!(_x isKindOf "HeadlessClient_F")}
            && {!([vehicle _x] call _fnc_isUavVehicle)}
        }
    };

    private _fnc_getGarageOffsets = {
        params ["_garage"];

        switch (typeOf _garage) do {
            case "Land_rhs_garage_type_01_red";
            case "Land_rhs_garage_type_01_green";
            case "Land_rhs_garage_type_01_blue";
            case "Land_rhs_garage_type_01_gray": {
                [
                    [[0, 0.2, 0], 0],
                    [[0, 0.2, 0], 180],
                    [[0, 0.6, 0], 0],
                    [[0, 0.6, 0], 180]
                ]
            };
            case "Land_rhs_garage_brick_o1";
            case "Land_rhs_garage_brick_o2": {
                [
                    [[0, 10.0, 0], 0],
                    [[0, -10.0, 0], 180],
                    [[0, 11.5, 0], 0],
                    [[0, -11.5, 0], 180]
                ]
            };
            default {
                [
                    [[0, 7.0, 0], 0],
                    [[0, -7.0, 0], 180]
                ]
            };
        }
    };

    private _fnc_getRoadDistance = {
        params ["_pos"];

        private _roads = _pos nearRoads 25;
        if (_roads isEqualTo []) exitWith {9999};

        private _best = 9999;
        {
            private _d = _pos distance2D _x;
            if (_d < _best) then {
                _best = _d;
            };
        } forEach _roads;

        _best
    };

    private _fnc_countCarsNearPlayer = {
        params ["_playerPos", "_cars"];

        private _count = 0;
        {
            _x params ["_veh", "_spawnPos", "_garage"];
            if (!(isNull _veh) && {(_playerPos distance2D _spawnPos) < 250}) then {
                _count = _count + 1;
            };
        } forEach _cars;

        _count
    };

    private _fnc_isGarageOccupied = {
        params ["_garage", "_cars"];

        private _occupied = false;
        {
            _x params ["_veh", "_spawnPos", "_boundGarage"];
            if (!(isNull _veh) && {_boundGarage isEqualTo _garage}) exitWith {
                _occupied = true;
            };
        } forEach _cars;

        _occupied
    };

    private _fnc_isValidSpawnPos = {
        params ["_pos", "_garage", "_cars"];

        if (surfaceIsWater _pos) exitWith {false};

        private _nearVehicles = nearestObjects [_pos, ["AllVehicles"], 5, true];
        _nearVehicles = _nearVehicles select {!(_x isEqualTo objNull)};
        if (_nearVehicles isNotEqualTo []) exitWith {false};

        private _tooClose = false;
        {
            _x params ["_veh", "_spawnPos", "_boundGarage"];
            if (!(isNull _veh) && {_boundGarage != _garage} && {(_spawnPos distance2D _pos) < 12}) exitWith {
                _tooClose = true;
            };
        } forEach _cars;

        !_tooClose
    };

    private _fnc_findGarageSpawn = {
        params ["_player", "_cars", "_garageTypes", "_searchRadius", "_minSpawnDistance", "_maxSpawnDistance"];

        private _playerPos = getPosATL _player;
        private _structures = nearestObjects [_playerPos, ["House", "Building"], _searchRadius, true];
        private _garages = _structures select { (typeOf _x) in _garageTypes };

        if (_debug) then {
            diag_log format ["[GARAGE_CARS] Player %1: nearby garages = %2", name _player, count _garages];
        };

        if (_garages isEqualTo []) exitWith {[]};

        private _selectedSpawn = [];

        {
            private _garage = _x;
            private _garagePos = getPosATL _garage;
            private _distToPlayer = _playerPos distance2D _garagePos;

            if (_distToPlayer < _minSpawnDistance) then { continue };
            if (_distToPlayer > _maxSpawnDistance) then { continue };
            if ([_garage, _cars] call _fnc_isGarageOccupied) then { continue };

            private _garageOffsets = [_garage] call _fnc_getGarageOffsets;
            private _frontCandidates = [];
            private _backCandidates = [];

            {
                _x params ["_modelOffset", "_dirAdjust"];
                private _spawnPos = _garage modelToWorld _modelOffset;
                _spawnPos set [2, 0];
                if (_dirAdjust isEqualTo 0) then {
                    _frontCandidates pushBack [_spawnPos, _garage, _dirAdjust];
                } else {
                    _backCandidates pushBack [_spawnPos, _garage, _dirAdjust];
                };
            } forEach _garageOffsets;

            private _frontRoadDist = 9999;
            private _backRoadDist = 9999;

            {
                _x params ["_spawnPos"];
                private _d = [_spawnPos] call _fnc_getRoadDistance;
                if (_d < _frontRoadDist) then {
                    _frontRoadDist = _d;
                };
            } forEach _frontCandidates;

            {
                _x params ["_spawnPos"];
                private _d = [_spawnPos] call _fnc_getRoadDistance;
                if (_d < _backRoadDist) then {
                    _backRoadDist = _d;
                };
            } forEach _backCandidates;

            private _preferredCandidates = if (_frontRoadDist <= _backRoadDist) then {
                _frontCandidates
            } else {
                _backCandidates
            };

            {
                _x params ["_spawnPos", "_spawnGarage", "_dirAdjust"];

                if (!([_spawnPos, _spawnGarage, _cars] call _fnc_isValidSpawnPos)) then {
                    continue;
                };

                _selectedSpawn = [_spawnPos, _spawnGarage, _dirAdjust];
                if (true) exitWith {};
            } forEach _preferredCandidates;

            if !(_selectedSpawn isEqualTo []) exitWith {};
        } forEach _garages;

        _selectedSpawn
    };

    private _fnc_spawnCar = {
        params ["_spawnData", "_vehicleTypes", "_rareVehicleTypes"];

        _spawnData params ["_spawnPos", "_garage", "_dirAdjust"];

        private _selectedVehicle = if ((random 1) < 0.08) then {
            selectRandom _rareVehicleTypes
        } else {
            selectRandom _vehicleTypes
        };

        private _veh = createVehicle [_selectedVehicle, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh allowDamage false;
        _veh setDir ((getDir _garage) + _dirAdjust);
        _veh setVehiclePosition [_spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setVelocity [0, 0, 0];
        _veh enableSimulationGlobal false;
        _veh setFuel (0.10 + random 0.55);
        _veh setVehicleLock "UNLOCKED";
        _veh setDamage (random 0.25);
        clearWeaponCargoGlobal _veh;
        clearMagazineCargoGlobal _veh;
        clearItemCargoGlobal _veh;
        clearBackpackCargoGlobal _veh;

        [_veh] spawn {
            params ["_veh"];
            sleep 4;
            if (!isNull _veh) then {
                _veh enableSimulationGlobal true;
                _veh allowDamage true;
            };
        };

        if (_debug) then {
            diag_log format ["[GARAGE_CARS] Spawned %1 at %2 for garage %3", typeOf _veh, _spawnPos, typeOf _garage];
        };

        [_veh, _spawnPos, _garage]
    };

    while {true} do {
        private _players = call _fnc_getActivePlayers;
        if (_debug) then {
            diag_log format ["[GARAGE_CARS] Active players = %1", count _players];
        };

        private _keptCars = [];
        {
            _x params ["_veh", "_spawnPos", "_garage"];

            if (isNull _veh) then {
                continue;
            };

            private _keep = false;
            {
                if ((_x distance2D _spawnPos) < _despawnRadius) exitWith {
                    _keep = true;
                };
            } forEach _players;

            if (_keep) then {
                _keptCars pushBack _x;
            } else {
                deleteVehicle _veh;
                if (_debug) then {
                    diag_log format ["[GARAGE_CARS] Deleted car at %1 because no players are nearby", _spawnPos];
                };
            };
        } forEach _managedCars;
        _managedCars = _keptCars;

        {
            private _player = _x;
            private _playerPos = getPosATL _player;
            private _carsNearPlayer = [_playerPos, _managedCars] call _fnc_countCarsNearPlayer;

            if (_carsNearPlayer >= _maxCarsPerPlayer) then {
                if (_debug) then {
                    diag_log format ["[GARAGE_CARS] Player %1 already has %2 cars nearby", name _player, _carsNearPlayer];
                };
                continue;
            };

            private _spawnData = [
                _player,
                _managedCars,
                _garageTypes,
                _searchRadius,
                _minSpawnDistance,
                _maxSpawnDistance
            ] call _fnc_findGarageSpawn;

            if (_spawnData isEqualTo []) then {
                continue;
            };

            private _carData = [_spawnData, _vehicleTypes, _rareVehicleTypes] call _fnc_spawnCar;
            _managedCars pushBack _carData;
        } forEach _players;

        sleep 10;
    };
};
