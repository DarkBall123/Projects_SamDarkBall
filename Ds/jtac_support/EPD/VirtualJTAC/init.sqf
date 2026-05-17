if (missionNamespace getVariable ["DB_JTAC_RuntimeInitialized", false]) exitWith {
    if (!isDedicated and !(isNil "DB_fnc_jtacRefreshState")) then {
        [] call DB_fnc_jtacRefreshState;
    };
};

missionNamespace setVariable ["DB_JTAC_RuntimeInitialized", true];

call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacsettings.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Projectiles.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\EvenSpread.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Mines.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Bombs.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Rockets.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\GuidedMissile.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\StrafingRun.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacattackparser.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacfirecontrol.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacreload.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacmapcontrol.sqf";

// Новый UI
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtac_ui.sqf";

call PARSE_AVAILABLE_JTAC_ATTACKS;

if (isNil "DB_fnc_jtacRegisterSettings") then {
    DB_fnc_jtacRegisterSettings = {
        if (missionNamespace getVariable ["DB_JTAC_SettingsRegistered", false]) exitWith {};

        missionNamespace setVariable ["DB_JTAC_SettingsRegistered", true];

        [
            "EPDJtacAquisitionFixedTime",
            "SLIDER",
            ["Global Lock Time Override", "0 keeps each strike's own acquiring time. Any value above 0 forces the same lock time for every JTAC strike."],
            "JTAC Support",
            [0, 60, 0, 0],
            1,
            {
                missionNamespace setVariable ["EPDJtacAquisitionFixedTime", EPDJtacAquisitionFixedTime, true];
            }
        ] call CBA_fnc_addSetting;

        [
            "EPDJtacAquisitionGlobalModifier",
            "SLIDER",
            ["Global Lock Time Multiplier", "Applies when the override above is set to 0. 1.00 = original timing from jtacsettings.sqf."],
            "JTAC Support",
            [0.1, 10, 1, 2],
            1,
            {
                missionNamespace setVariable ["EPDJtacAquisitionGlobalModifier", EPDJtacAquisitionGlobalModifier, true];
            }
        ] call CBA_fnc_addSetting;
    };
};

call DB_fnc_jtacRegisterSettings;

// ====================== ИНИЦИАЛИЗАЦИЯ ПЕРЕМЕННОЙ КЛАВИШИ ======================
if (isNil "JTAC_KeyCode") then {
    JTAC_KeyCode = 35; // H по умолчанию
};

if (!isDedicated) then {
    JtacAvailable = true;
    JtacIncomingAngle = "RANDOM";
    JtacTargetingMethod = "LASER";

    waitUntil {sleep 0.5; !(isNull player)};
    [] call DB_fnc_jtacRefreshState;

    // ====================== CBA KEYBIND (с переменной) ======================
    if !(missionNamespace getVariable ["DB_JTAC_KeybindRegistered", false]) then {
        missionNamespace setVariable ["DB_JTAC_KeybindRegistered", true];

        [
            "JTAC Support",
            "JTAC_OpenMenu",
            ["Open JTAC Support Menu", "Открыть меню запроса поддержки JTAC"],
            {
                if (([] call DB_fnc_jtacRefreshState) && {JtacAvailable}) then {
                    [] call JTAC_OpenMainUI;
                };
            },
            {},
            [JTAC_KeyCode, [false, false, false]],
            false
        ] call CBA_fnc_addKeybind;
    };

    // ====================== Respawn ======================
    if !(missionNamespace getVariable ["DB_JTAC_RespawnHandlerRegistered", false]) then {
        missionNamespace setVariable ["DB_JTAC_RespawnHandlerRegistered", true];

        player addEventHandler ["Respawn", {
            params ["_unit"];
            [_unit] call DB_fnc_jtacRefreshState;
            JtacAvailable = true;
        }];
    };
};
