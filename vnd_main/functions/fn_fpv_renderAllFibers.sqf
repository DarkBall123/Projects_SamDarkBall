if (isNil "vnd_renderEH") then
{
    vnd_renderEH = addMissionEventHandler ["Draw3D",
    {
        if !(missionNamespace getVariable ["vnd_showFiber", true]) exitWith {};

        private _dClasses = missionNamespace getVariable ["DB_vnd_fpv_dronesArray", []];
        private _pl = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

        {
            if (typeOf _x in _dClasses) then {
                private _path = _x getVariable ["vnd_fiber_path", []];
                if !(_path isEqualTo []) then {
                    private _last = _x getVariable ["vnd_lastSagLocal", time];
                    private _dt   = time - _last;
                    _x setVariable ["vnd_lastSagLocal", time];

                    private _nodes = _path + [_x modelToWorldVisual [0,-0.10,0.0825]];
                    _nodes = [_nodes, _dt] call DB_vnd_fnc_fpv_applyGravity;

                    [_nodes] call DB_vnd_fnc_fpv_drawFiberPath;
                };
            };
        } forEach allUnitsUAV;


        private _dead = missionNamespace getVariable ["vnd_deadFibers", []];
        private _newDead = [];

        {
            private _entry = _x;
            private _path = _entry # 0;
            private _expire = _entry # 1;
            private _lastSag = _entry # 2;
            private _now = time;

            if (_now < _expire) then {
                private _dt = _now - _lastSag;
                private _newPath = [_path, _dt] call DB_vnd_fnc_fpv_applyGravity;

                [_newPath] call DB_vnd_fnc_fpv_drawFiberPath;
                _newDead pushBack [_newPath, _expire, _now];
            };
        } forEach _dead;

        missionNamespace setVariable ["vnd_deadFibers", _newDead, false];
    }];
};
