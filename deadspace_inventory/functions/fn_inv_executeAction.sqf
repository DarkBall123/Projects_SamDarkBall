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

call DB_dsi_fnc_inv_close;

private _handled = true;

switch (_role) do {
    case "driver": {
        player action ["GetInDriver", _vehicle];
    };
    case "commander": {
        player action ["GetInCommander", _vehicle];
    };
    case "gunner": {
        player action ["GetInGunner", _vehicle];
    };
    case "cargo": {
        player action ["GetInCargo", _vehicle, _cargoActionIndex];
    };
    case "turret": {
        [_vehicle, player, ["turret", _turretPath]] call BIS_fnc_moveIn;
    };
    default {
        _handled = false;
    };
};

_handled
