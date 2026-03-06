params ["_requester", "_source", "_panelType", "_entry"];

if (isNull _requester || {isNull _source}) exitWith {};

private _removed = [_source, _panelType, _entry] call DB_dsi_fnc_inv_removeEntryFromSource;
if (!_removed) exitWith {};

["DB_dsi_receiveTransfer", [_requester, _entry], _requester] call CBA_fnc_targetEvent;
