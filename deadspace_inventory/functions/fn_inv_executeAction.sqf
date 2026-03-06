params [["_entry", [], [[]]]];

if (_entry isEqualTo []) exitWith { false };

_entry params ["_entryType", "_payload"];
if !(_entryType isEqualTo "action") exitWith { false };

_payload params [
    ["_actionType", "", [""]],
    ["_vehicle", objNull, [objNull]],
    ["_role", "", [""]],
    ["_cargoActionIndex", 0, [0]],
    ["_turretPath", [], [[]]]
];

if !(_actionType isEqualTo "seat") exitWith { false };
if (isNull _vehicle) exitWith { false };

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _unit) then {
    _unit = player;
};

call DB_dsi_fnc_inv_close;

private _handled = true;

switch (_role) do {
    case "driver": {
        _unit action ["GetInDriver", _vehicle];
    };
    case "commander": {
        _unit action ["GetInCommander", _vehicle];
    };
    case "gunner": {
        _unit action ["GetInGunner", _vehicle];
    };
    case "cargo": {
        _unit action ["GetInCargo", _vehicle, _cargoActionIndex];
    };
    case "turret": {
        [_vehicle, _unit, ["turret", _turretPath]] call BIS_fnc_moveIn;
    };
    default {
        _handled = false;
    };
};

_handled
