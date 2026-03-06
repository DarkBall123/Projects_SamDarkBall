if (!hasInterface) exitWith {};

private _display = findDisplay 46;
if (isNull _display) exitWith {};

private _lastDisplay = uiNamespace getVariable ["DB_dsi_inputDisplay", displayNull];
if (_display isEqualTo _lastDisplay) exitWith {};

if (!isNull _lastDisplay) then {
    {
        _x params ["_eventName", "_id"];
        if (_id >= 0) then {
            _lastDisplay displayRemoveEventHandler [_eventName, _id];
        };
    } forEach (uiNamespace getVariable ["DB_dsi_inputEhIds", []]);
};

call DB_dsi_fnc_inv_cleanupOverlay;

private _ids = [
    ["KeyDown", _display displayAddEventHandler ["KeyDown", { _this call DB_dsi_fnc_inv_handleKeyDown }]],
    ["MouseButtonDown", _display displayAddEventHandler ["MouseButtonDown", { _this call DB_dsi_fnc_inv_handleMouseButtonDown }]],
    ["MouseZChanged", _display displayAddEventHandler ["MouseZChanged", { _this call DB_dsi_fnc_inv_handleMouseZChanged }]]
];

uiNamespace setVariable ["DB_dsi_inputDisplay", _display];
uiNamespace setVariable ["DB_dsi_inputEhIds", _ids];
