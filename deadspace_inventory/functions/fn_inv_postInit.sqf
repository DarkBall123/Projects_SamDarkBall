if (!hasInterface) exitWith {};

[
    "Deadspace Inventory",
    "DB_dsi_toggle",
    "Deadspace Inventory",
    { call DB_dsi_fnc_inv_toggle },
    {},
    [23, [false, true, false]]
] call CBA_fnc_addKeybind;

if (isNil "DB_dsi_draw2dEH") then {
    DB_dsi_draw2dEH = addMissionEventHandler ["Draw2D", { call DB_dsi_fnc_inv_render }];
};

call DB_dsi_fnc_inv_registerInventoryEH;

["unit", {
    call DB_dsi_fnc_inv_registerInventoryEH;
}, true] call CBA_fnc_addPlayerEventHandler;

[
    { !isNull findDisplay 46 },
    {
        call DB_dsi_fnc_inv_registerDisplayEH;
    }
] call CBA_fnc_waitUntilAndExecute;
