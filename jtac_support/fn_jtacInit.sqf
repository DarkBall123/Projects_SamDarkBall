if ((isServer) and (isDedicated)) exitWith {};

if (isNil "DB_fnc_jtacRefreshState") then {
    DB_fnc_jtacRefreshState = {
        private _unit = objNull;

        if (_this isEqualType objNull) then {
            _unit = _this;
        } else {
            if (_this isEqualType []) then {
                _unit = _this param [0, objNull, [objNull]];
            };
        };

        if (isNull _unit) then {
            _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull];
        };

        if (isNull _unit) then {
            _unit = player;
        };

        private _hasJtacDesignator = "JTAC_L" in (assignedItems [_unit, false, true]);

        _unit setVariable ["JTAC", _hasJtacDesignator, true];

        if (_unit != player) then {
            player setVariable ["JTAC", _hasJtacDesignator, false];
        };

        _hasJtacDesignator
    };
};

if !(missionNamespace getVariable ["DB_JTAC_LoadoutHandlerRegistered", false]) then {
    missionNamespace setVariable ["DB_JTAC_LoadoutHandlerRegistered", true];

    ["loadout", {
        params ["_unit"];
        [_unit] call DB_fnc_jtacRefreshState;
    }] call CBA_fnc_addPlayerEventHandler;
};

[] spawn {
    waitUntil {
        sleep 0.1;
        !(isNull player)
    };

    [player] call DB_fnc_jtacRefreshState;

    if !(missionNamespace getVariable ["DB_JTAC_InitScriptStarted", false]) then {
        missionNamespace setVariable ["DB_JTAC_InitScriptStarted", true];
        call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\init.sqf";
    };
};
