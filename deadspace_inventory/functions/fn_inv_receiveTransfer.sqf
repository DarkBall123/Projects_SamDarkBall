params ["_requester", "_entry"];

if (isNull _requester || {!local _requester}) exitWith {};

if !([_requester, _entry] call DB_dsi_fnc_inv_addEntryToUnit) then {
    [_requester, _entry] call DB_dsi_fnc_inv_dropEntryNearUnit;
};

if (_requester isEqualTo player) then {
    [
        { call DB_dsi_fnc_inv_refresh },
        [],
        0.05
    ] call CBA_fnc_waitAndExecute;
};
