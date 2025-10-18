[] spawn {
        private _weakSignalStart = -1;
        private _transientTimer = 0;
        private _transientEffects = [];

        private _destroyEffects = {
                params ["_effects"];

                {
                        if (!isNil {_x}) then {
                                ppEffectDestroy _x;
                        };
                } forEach _effects;
        };

        private _createBaseEffects = {
                params ["_signal"];

                private _adjust = linearConversion [1, 0, _signal, 0.1, 1.0];

                private _color = ppEffectCreate ["ColorCorrections", 1500];
                _color ppEffectEnable true;
                _color ppEffectAdjust [[1.08, 1.2, _adjust] call BIS_fnc_lerp, [0.67, 1, _adjust] call BIS_fnc_lerp, 0.06, [0, 0, 0.45, 0.06], [1, 1, 0.93, 1.61], [0.33, 0.33, 0.15, 0.2], [0, 0, 0, 0, 0, 0, 5]];
                _color ppEffectCommit 0;

                private _blur = ppEffectCreate ["DynamicBlur", 500];
                _blur ppEffectEnable true;
                _blur ppEffectAdjust [[0.2, 0.7, _adjust] call BIS_fnc_lerp];
                _blur ppEffectCommit 0;

                private _film = ppEffectCreate ["FilmGrain", 2000];
                _film ppEffectEnable true;
                _film ppEffectAdjust [[0.04, 1, _adjust] call BIS_fnc_lerp, 1, [4.09, 4.5, _adjust] call BIS_fnc_lerp, 0.5, 0.5, true];
                _film ppEffectCommit 0;

                [_color, _blur, _film]
        };

        private _createTransientEffects = {
                private _color = ppEffectCreate ["ColorCorrections", 1500];
                _color ppEffectEnable true;
                _color ppEffectAdjust [1.08, 0.67, 0.06, [0, 0, 0.45, 0.06], [1, 1, 0.93, 1.61], [0.33, 0.33, 0.15, 0.2], [0, 0, 0, 0, 0, 0, 5]];
                _color ppEffectCommit 0;

                private _blur = ppEffectCreate ["DynamicBlur", 500];
                _blur ppEffectEnable true;
                _blur ppEffectAdjust [0.4];
                _blur ppEffectCommit 0;

                private _film = ppEffectCreate ["FilmGrain", 2000];
                _film ppEffectEnable true;
                _film ppEffectAdjust [1, 0.47, 4.26, 0.5, 0.5, true];
                _film ppEffectCommit 0;

                [_color, _blur, _film]
        };

        while { missionNamespace getVariable ["ArmaFPV_isControl", false] } do {
                private _operator = call DB_fnc_fpv_getOperator;
                private _uav = [_operator] call DB_fnc_fpv_getControlledUAV;

                if (isNull _uav) then {
                        sleep 0.2;
                        continue;
                };

                private _signal = [_operator, _uav] call DB_fnc_fpv_getSignal;
                private _altitude = (getPos _uav select 2) max 0;

                if (_signal < 0.05) then {
                        if (_weakSignalStart < 0) then {
                                _weakSignalStart = time;
                        } else {
                                if ((time - _weakSignalStart) >= 5) then {
                                        [_operator, _uav] call DB_fnc_fpv_onSignalLost;
                                        _weakSignalStart = -1;
                                };
                        };
                } else {
                        _weakSignalStart = -1;
                };

                if (_signal < 0.3 && { _altitude < 20 }) then {
                        if ((random 1) > 0.9 && { _transientTimer <= 0 }) then {
                                _transientEffects call _destroyEffects;
                                _transientEffects = call _createTransientEffects;
                                _transientTimer = 2;
                        };
                };

                if (_transientTimer > 0) then {
                        _transientTimer = _transientTimer - 0.2;

                        if (_transientTimer <= 0) then {
                                _transientEffects call _destroyEffects;
                                _transientEffects = [];
                        };
                };

                private _picture = [
                        _signal,
                        [
                                [0.75, "\\ArmaFPV\\pictures\\100.paa"],
                                [0.5, "\\ArmaFPV\\pictures\\75.paa"],
                                [0.25, "\\ArmaFPV\\pictures\\50.paa"],
                                [0.01, "\\ArmaFPV\\pictures\\25.paa"]
                        ],
                        "\\ArmaFPV\\pictures\\0.paa"
                ] call DB_fnc_fpv_selectGaugeTexture;

                private _controlPicture = uiNamespace getVariable ["ArmaFPV_SignalPicture", controlNull];
                private _controlText = uiNamespace getVariable ["ArmaFPV_SignalText", controlNull];

                _controlPicture ctrlSetText _picture;
                _controlText ctrlSetText str (round (_signal * 100));

                private _currentEffects = missionNamespace getVariable ["DB_fpv_ppEffect", []];
                _currentEffects call _destroyEffects;

                private _baseEffects = [_signal] call _createBaseEffects;
                missionNamespace setVariable ["DB_fpv_ppEffect", _baseEffects];

                sleep 0.2;
        };

        _transientEffects call _destroyEffects;

        private _remaining = missionNamespace getVariable ["DB_fpv_ppEffect", []];
        _remaining call _destroyEffects;
        missionNamespace setVariable ["DB_fpv_ppEffect", []];
};
