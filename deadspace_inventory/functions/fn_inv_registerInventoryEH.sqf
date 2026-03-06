if (!hasInterface) exitWith {};

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _unit) exitWith {};

private _lastUnit = missionNamespace getVariable ["DB_dsi_inventoryEH_unit", objNull];
if (_unit isEqualTo _lastUnit) exitWith {};

private _oldId = _lastUnit getVariable ["DB_dsi_inventoryEH_id", -1];
if (!isNull _lastUnit && {_oldId >= 0}) then {
    _lastUnit removeEventHandler ["InventoryOpened", _oldId];
};

private _newId = _unit addEventHandler ["InventoryOpened", { _this call DB_dsi_fnc_inv_onInventoryOpened }];
_unit setVariable ["DB_dsi_inventoryEH_id", _newId];
missionNamespace setVariable ["DB_dsi_inventoryEH_unit", _unit];
