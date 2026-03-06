params ["_container"];

private _entries = [];
_entries append ([getItemCargo _container, "item"] call DB_dsi_fnc_inv_stackList);
_entries append ([getMagazineCargo _container, "magazine"] call DB_dsi_fnc_inv_stackList);
_entries append ([getWeaponCargo _container, "weapon"] call DB_dsi_fnc_inv_stackList);
_entries append ([getBackpackCargo _container, "backpack"] call DB_dsi_fnc_inv_stackList);

if (_entries isEqualTo []) exitWith { [] };

private _info = [typeOf _container] call DB_dsi_fnc_inv_getClassData;
[["cargo", _info # 0, _info # 1, _entries]]
