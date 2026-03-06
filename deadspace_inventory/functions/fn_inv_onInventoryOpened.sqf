params ["_unit", "_primary", "_secondary"];

if (!hasInterface) exitWith { false };

private _current = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if !(_unit isEqualTo _current) exitWith { false };

if (uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith {
    call DB_dsi_fnc_inv_close;
    true
};

private _target = objNull;

if (!isNull _secondary && {!(_secondary isEqualTo _unit)}) then {
    _target = _secondary;
};

if (isNull _target && {!isNull _primary} && {!(_primary isEqualTo _unit)}) then {
    _target = _primary;
};

if (isNull _target) then {
    _target = call DB_dsi_fnc_inv_findTarget;
};

[_target] call DB_dsi_fnc_inv_open;
true
