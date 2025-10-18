#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

call DB_fnc_fpv_overwriteKey;

private _playerUnit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

if (!isNull _playerUnit && {isPlayer _playerUnit}) then {
        private _id = _playerUnit addEventHandler ["Put", { _this call DB_fnc_fpv_createDroneOnItemCheck }];
        _playerUnit setVariable ["DB_fpv_playerPutID", _id];
} else {
        if (!isNull _playerUnit) then {
                _playerUnit setVariable ["DB_fpv_playerPutID", -1];
        };
};

["loadout", {
        params ["_player"];

        if (isNull _player) exitWith {};

        private _id = _player getVariable ["DB_fpv_playerPutID", -1];

        if (_id != -1) then {
                _player removeEventHandler ["Put", _id];
        };

        if !(isPlayer _player) exitWith {
                _player setVariable ["DB_fpv_playerPutID", -1];
        };

        private _newId = _player addEventHandler ["Put", { _this call DB_fnc_fpv_createDroneOnItemCheck }];
        _player setVariable ["DB_fpv_playerPutID", _newId];
}] call CBA_fnc_addPlayerEventHandler;
