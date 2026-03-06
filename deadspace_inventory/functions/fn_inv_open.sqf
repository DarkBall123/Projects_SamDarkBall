params [["_target", objNull, [objNull]]];

if (isNull _target) then {
    _target = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
    if (isNull _target) then {
        _target = player;
    };
};

private _context = [_target] call DB_dsi_fnc_inv_buildContext;
if (_context isEqualTo []) exitWith { false };

if (uiNamespace getVariable ["DB_dsi_isOpen", false]) then {
    call DB_dsi_fnc_inv_close;
};

uiNamespace setVariable ["DB_dsi_context", _context];
uiNamespace setVariable ["DB_dsi_panelIndex", 0];
uiNamespace setVariable ["DB_dsi_pageIndex", 0];
uiNamespace setVariable ["DB_dsi_isOpen", true];
uiNamespace setVariable ["DB_dsi_selectedOption", []];

call DB_dsi_fnc_inv_updateSafetyAction;
true
