if (!hasInterface) exitWith {};

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _unit) then {
    _unit = player;
};

private _currentOwner = missionNamespace getVariable ["DB_dsi_safetyActionOwner", objNull];
private _currentId = missionNamespace getVariable ["DB_dsi_safetyActionId", -1];

if (!isNull _currentOwner && {!(_currentOwner isEqualTo _unit)} && {_currentId >= 0}) then {
    _currentOwner removeAction _currentId;
    missionNamespace setVariable ["DB_dsi_safetyActionOwner", objNull];
    missionNamespace setVariable ["DB_dsi_safetyActionId", -1];
    _currentId = -1;
};

if (uiNamespace getVariable ["DB_dsi_isOpen", false]) then {
    if (_currentId < 0) then {
        _currentId = _unit addAction [
            "<t color='#00000000'>Deadspace Select</t>",
            {
                if (uiNamespace getVariable ["DB_dsi_isOpen", false]) then {
                    call DB_dsi_fnc_inv_activateSelection;
                };
            },
            [],
            100,
            false,
            false,
            "DefaultAction",
            "uiNamespace getVariable ['DB_dsi_isOpen', false]"
        ];

        missionNamespace setVariable ["DB_dsi_safetyActionOwner", _unit];
        missionNamespace setVariable ["DB_dsi_safetyActionId", _currentId];
    };
} else {
    if (!isNull _currentOwner && {_currentId >= 0}) then {
        _currentOwner removeAction _currentId;
    };

    missionNamespace setVariable ["DB_dsi_safetyActionOwner", objNull];
    missionNamespace setVariable ["DB_dsi_safetyActionId", -1];
};
