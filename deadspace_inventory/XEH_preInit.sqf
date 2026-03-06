["DB_dsi_commitTransfer", { _this call DB_dsi_fnc_inv_commitTransfer }] call CBA_fnc_addEventHandler;
["DB_dsi_receiveTransfer", { _this call DB_dsi_fnc_inv_receiveTransfer }] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    addMissionEventHandler ["Loaded", {
        call DB_dsi_fnc_inv_registerDisplayEH;
        call DB_dsi_fnc_inv_registerInventoryEH;
    }];
};
