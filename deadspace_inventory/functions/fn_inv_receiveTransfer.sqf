params ["_requester", "_entry"];

if (isNull _requester || {!local _requester}) exitWith {};

private _addedCount = [_requester, _entry] call DB_dsi_fnc_inv_addEntryToUnit;
private _requestedCount = _entry param [2, 0];

if (_addedCount < _requestedCount) then {
    private _remainderEntry = +_entry;
    _remainderEntry set [2, _requestedCount - _addedCount];
    [_requester, _remainderEntry] call DB_dsi_fnc_inv_dropEntryNearUnit;
};

private _currentUnit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _currentUnit) then {
    _currentUnit = player;
};

if (_requester isEqualTo _currentUnit) then {
    [
        { call DB_dsi_fnc_inv_refresh },
        [],
        0.05
    ] call CBA_fnc_waitAndExecute;
};
