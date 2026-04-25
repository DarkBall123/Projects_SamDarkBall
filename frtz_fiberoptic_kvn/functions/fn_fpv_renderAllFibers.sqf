if !(hasInterface) exitWith {};

if (isNil "kvn_renderEH") then
{
    kvn_renderEH = addMissionEventHandler ["Draw3D",
    {
        if !(missionNamespace getVariable ["kvn_showFiber", true]) exitWith {};

        private _now = time;
        private _drones = missionNamespace getVariable ["kvn_cachedFiberDrones", []];
        private _nextScan = missionNamespace getVariable ["kvn_nextFiberScan", 0];

        if (_now >= _nextScan) then {
            private _dClasses = missionNamespace getVariable ["DB_kvn_fpv_dronesArray", []];
            _drones = allUnitsUAV select { !isNull _x && {typeOf _x in _dClasses} };
            missionNamespace setVariable ["kvn_cachedFiberDrones", _drones, false];
            missionNamespace setVariable ["kvn_nextFiberScan", _now + 1, false];
        };

        {
            if (!isNull _x && {alive _x}) then {
                private _path = _x getVariable ["kvn_fiber_path", []];
                if (_path isEqualTo []) then {
                    _x setVariable ["kvn_fiber_draw_path", [], false];
                    _x setVariable ["kvn_fiber_draw_raw_path", [], false];
                } else {
                    private _tip = _x modelToWorldVisual [0,-0.48,-0.05];
                    private _rawCount = count _path;
                    private _drawPath = _x getVariable ["kvn_fiber_draw_path", []];
                    private _lastSag = _x getVariable ["kvn_lastSagLocal", 0];
                    private _lastRawPath = _x getVariable ["kvn_fiber_draw_raw_path", []];
                    private _lastRawCount = count _lastRawPath;

                    if (_drawPath isEqualTo [] || {_lastRawPath isEqualTo []}) then {
                        _drawPath = +_path;
                        _drawPath pushBack _tip;
                    } else {
                        private _drop = -1;

                        if (_rawCount > 0) then {
                            private _newFirst = _path # 0;
                            for "_i" from 0 to (_lastRawCount - 1) do {
                                if (_drop < 0 && {((_lastRawPath # _i) distanceSqr _newFirst) < 0.01}) then {
                                    _drop = _i;
                                };
                            };
                        };

                        if (_drop < 0) then {
                            _drawPath = +_path;
                            _drawPath pushBack _tip;
                        } else {
                            for "_i" from 1 to _drop do {
                                if ((count _drawPath) > 0) then {
                                    _drawPath deleteAt 0;
                                };
                            };

                            private _oldAlignedCount = _lastRawCount - _drop;
                            if (_oldAlignedCount > _rawCount) then {
                                _drawPath = +_path;
                                _drawPath pushBack _tip;
                            } else {
                                if ((count _drawPath) > 0) then {
                                    _drawPath deleteAt ((count _drawPath) - 1);
                                };
                                for "_i" from _oldAlignedCount to (_rawCount - 1) do {
                                    _drawPath pushBack (_path # _i);
                                };
                                _drawPath pushBack _tip;
                            };
                        };
                    };

                    if ((_now - _lastSag) >= 0.1) then {
                        private _dt = if (_lastSag <= 0) then { 0 } else { _now - _lastSag };
                        if (_dt > 0) then {
                            _drawPath = [_drawPath, _dt] call DB_kvn_fnc_fpv_applyGravity;
                        };
                        _x setVariable ["kvn_lastSagLocal", _now, false];
                    };

                    _x setVariable ["kvn_fiber_draw_path", _drawPath, false];
                    _x setVariable ["kvn_fiber_draw_raw_path", +_path, false];
                    [_drawPath] call DB_kvn_fnc_fpv_drawFiberPath;
                };
            };
        } forEach _drones;

        private _dead = missionNamespace getVariable ["kvn_deadFibers", []];
        private _newDead = [];

        {
            private _entry = _x;
            private _path = _entry # 0;
            private _expire = _entry # 1;
            private _lastSag = if ((count _entry) > 2) then { _entry # 2 } else { _now };
            private _drawPath = if ((count _entry) > 3) then { _entry # 3 } else { +_path };

            if (_now < _expire) then {
                if ((_now - _lastSag) >= 0.25) then {
                    _drawPath = [_drawPath, _now - _lastSag] call DB_kvn_fnc_fpv_applyGravity;
                    _lastSag = _now;
                };

                [_drawPath] call DB_kvn_fnc_fpv_drawFiberPath;
                _newDead pushBack [_path, _expire, _lastSag, _drawPath];
            };
        } forEach _dead;

        missionNamespace setVariable ["kvn_deadFibers", _newDead, false];
    }];
};
