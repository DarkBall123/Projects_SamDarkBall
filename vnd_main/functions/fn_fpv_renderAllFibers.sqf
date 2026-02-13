#include "\vnd_main\script_macros.hpp"

if (!hasInterface) exitWith {};

private _renderEh = GETMVAR(vnd_renderEH, -1);
if (_renderEh < 0) then
{
    _renderEh = addMissionEventHandler ["Draw3D",
    {
        if !(GETMVAR(vnd_showFiber, true)) exitWith {};

        private _dClasses = GETMVAR(DB_vnd_fpv_dronesArray, []);
        private _pl = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
        if (isNull _pl) then {
            _pl = player;
        };

        private _controlledUav = getConnectedUAV _pl;

        {
            if (typeOf _x in _dClasses) then {
                if (_x != _controlledUav && { _pl distance _x > VND_FIBER_DRAW_DISTANCE }) then {
                    continue;
                };

                private _path = _x getVariable ["vnd_fiber_path", []];
                if !(_path isEqualTo []) then {
                    private _nodes = _path + [_x modelToWorldVisual [0,-0.10,0.0825]];

                    [_nodes] call DB_vnd_fnc_fpv_drawFiberPath;
                };
            };
        } forEach allUnitsUAV;


        private _dead = GETMVAR(vnd_deadFibers, []);
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

        SETMVAR(vnd_deadFibers, _newDead);
    }];

    SETMVAR(vnd_renderEH, _renderEh);
};
