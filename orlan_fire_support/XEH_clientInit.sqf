["cameraView", {
    params ["_player", "_view"];
    private _commID = _player getVariable ["DB_orlanFS_commID", -1];
    private _dronesArray = missionNamespace getVariable ["orlanFS_allAvaiblesDrones", []];

    if !(isPlayer _player) exitWith {};

    if ((_view == "GUNNER") and {typeOf(getConnectedUAV _player) in _dronesArray}) then {
        _commID = [_player, "Orlan_FireSupport", nil, nil, ""] call BIS_fnc_addCommMenuItem;
    }
    else {
        if (_commID != -1) then { [_player, _commID] call BIS_fnc_removeCommMenuItem };
        _commID = -1;
    };

    _player setVariable ["DB_orlanFS_commID", _commID];
}] call CBA_fnc_addPlayerEventHandler;