params [["_entry", [], [[]]]];

if (_entry isEqualTo []) exitWith { false };

_entry params ["_entryType", "_payload"];
if !(_entryType isEqualTo "action") exitWith { false };

_payload params [
    ["_actionType", "", [""]],
    ["_vehicle", objNull, [objNull]],
    ["_role", "", [""]],
    ["_cargoIndex", -1, [0]],
    ["_turretPath", [], [[]]]
];

if !(_actionType isEqualTo "seat") exitWith { false };
if (isNull _vehicle) exitWith { false };

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _unit) then {
    _unit = player;
};

call DB_dsi_fnc_inv_close;

if !(isNull objectParent _unit) then {
    moveOut _unit;
};

private _handled = true;

switch (_role) do {
    case "driver": {
        _unit moveInDriver _vehicle;
    };
    case "commander": {
        _unit moveInCommander _vehicle;
    };
    case "gunner": {
        _unit moveInGunner _vehicle;
    };
    case "cargo": {
        if (_cargoIndex >= 0) then {
            _unit moveInCargo [_vehicle, _cargoIndex, false];
        } else {
            _unit moveInCargo _vehicle;
        };
    };
    case "turret": {
        _unit moveInTurret [_vehicle, _turretPath];
    };
    default {
        _handled = false;
    };
};

_handled
